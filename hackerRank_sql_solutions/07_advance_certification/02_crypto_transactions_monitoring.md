# Crypto Market transactions Monitoring

As part of a cryptocurrency trade monitoring platform create a query to return a list of suspicious transactions.

Suspicious transactions are defined as:
- a series of two or more transactions occur at intervals of an hour or less
- they are from the same sender
- the sum of transactions in a sequence is 150 or greater.

A sequence of suspicious transactions may occur over time periods greater than one hour. As an example, there are 5 transactions from one sender for 30 each. They occur at intervals of less than an hour between from 8 AM to 11 AM. These are suspicious and will all be reported as one sequence that starts at 8 AM, ends at 11 AM, with 5 transactions that sum to 150.

The result should have the following columns:`sender`, `sequence_start`,`sequence_end`,`transactions_count`,`transactions_sum`.

- `sender`: is the sender's address
- `sequence_start`: is the timestamp of the first transaction in the sequence
- `sequence_end`: is the timestamp of the last transaction in the sequence
- `transaction_count`: is the number of transactions in the sequence
- `transactions_sum`: is the sum of transaction amounts in the sequence, to 6 places after the decimal.

Order the data `ascending`, first by `sender`, then by `sequence_start` and finally by `sequence_end`.


```SQL
WITH df AS (
  -- Compute time difference between transactions
  SELECT *,
    CASE 
      WHEN LAG(sender) OVER (ORDER BY sender, dt) = sender
      THEN (strftime('%s', dt) - strftime('%s', LAG(dt) OVER (ORDER BY sender, dt))) / 60
    END AS df_minute
  FROM transactions
),
fin1 AS (
  -- Extract rows with 2 or more transactions within an hour
  SELECT *
  FROM (
    SELECT *,
      CASE 
        WHEN df_minute < 60 OR 
              ( LEAD(sender) OVER (ORDER BY sender, dt) = sender AND 
               		LEAD(df_minute) OVER (ORDER BY sender, dt) < 60 )
        THEN 'Yes' ELSE 'No'
      END as selection
    FROM df
  ) f
  WHERE selection = 'Yes'
),
fin2 AS (
  -- Identifying first and last sequence transaction
  SELECT dt, sender, amount, df_minute,
  CASE 
      WHEN df_minute > 60 AND 
  		( LEAD(df_minute) OVER (ORDER BY sender, dt) < 60 OR 
         	LEAD(df_minute) OVER (ORDER BY sender, dt) IS NULL ) AND
        ( LAG(df_minute) OVER (ORDER BY sender, dt) < 60 OR 
         	LAG(df_minute) OVER (ORDER BY sender, dt) IS NULL )
      THEN 'Yes'
  END as is_first_trans,
  CASE 
      WHEN df_minute < 60 AND 
  		( LEAD(df_minute) OVER (ORDER BY sender, dt) > 60 OR 
         	LEAD(df_minute) OVER (ORDER BY sender, dt) IS NULL )
      THEN 'Yes'
  END as is_last_trans
  FROM fin1
),
fin4 AS (
  -- Computing the sequence transactions' start date
  SELECT *,
  CASE 
      WHEN is_last_trans = 'Yes' 
      THEN (
        SELECT f.dt
        FROM (
          SELECT dt, 
          		abs( strftime('%s', f1.dt) - strftime('%s', f2.dt) ) as diff_dt
          FROM fin2 f2 
          WHERE (f2.is_first_trans = 'Yes') AND (f2.sender = f1.sender) AND (f2.dt < f1.dt)
        ) f
        ORDER BY diff_dt ASC LIMIT 1
      )
  END as sequence_start
  FROM fin2 f1
),
fin AS (
  -- Computing the sequence transactions' total amount and number of transactions
  SELECT *,
    CASE
      WHEN f1.is_last_trans = 'Yes'
      THEN ( SELECT SUM(amount)
            FROM fin4 f2
            WHERE f2.sender = f1.sender AND f2.dt >= f1.sequence_start AND f2.dt <= f1.dt
           )
    END transactions_sum,
    CASE
      WHEN f1.is_last_trans = 'Yes'
      THEN ( SELECT COUNT(1)
            FROM fin4 f2
            WHERE f2.sender = f1.sender AND f2.dt >= f1.sequence_start AND f2.dt <= f1.dt
           )
    END transactions_count
  FROM fin4 f1
)

SELECT *
FROM (
  SELECT sender, 
          sequence_start, 
          dt AS sequence_end,
          transactions_count,
          transactions_sum
  FROM fin
  WHERE is_last_trans = 'Yes'
) f
WHERE transactions_sum >= 150
ORDER BY sender, sequence_start, sequence_end;
```
