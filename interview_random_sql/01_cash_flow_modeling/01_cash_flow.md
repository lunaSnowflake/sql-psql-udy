# Cash Flow Modeling SQL

Suppose we have the following table `transactions`:

```SQL
CREATE TABLE transactions (
  month DATE,
  cash_on_hand_ob NUMERIC(9,2),
  revenue NUMERIC(9,2),
  fixed_costs NUMERIC(9,2),
  variable_costs NUMERIC(9,2),
  cash_on_hand_cb NUMERIC(9,2)
);
```

The data in this table are:

```SQL
INSERT INTO transactions
       (month, cash_on_hand_ob, revenue, fixed_costs, variable_costs, cash_on_hand_cb)
VALUES ('2016-01-01',1000000,100000,200000,50000,NULL),
       ('2016-02-01',NULL   ,115000,200000,57500,NULL),
       ('2016-03-01',NULL   ,132250,200000,66125,NULL),
       ('2016-04-01',NULL   ,152088,200000,76044,NULL),
       ('2016-05-01',NULL   ,174901,200000,87450,NULL),
       ('2016-06-01',NULL   ,201136,200000,100568,NULL),
       ('2016-07-01',NULL   ,231306,200000,115653,NULL),
       ('2016-08-01',NULL   ,266002,200000,133001,NULL),
       ('2016-09-01',NULL   ,305902,200000,107066,NULL),
       ('2016-10-01',NULL   ,351788,200000,123126,NULL),
       ('2016-11-01',NULL   ,404556,200000,141595,NULL),
       ('2016-12-01',NULL   ,465239,200000,162834,NULL),
       ('2017-01-01',NULL   ,695533,400000,187259,NULL),
       ('2017-02-01',NULL   ,799862,400000,215348,NULL),
       ('2017-03-01',NULL   ,919842,400000,247650,NULL),
       ('2017-04-01',NULL   ,1057818,400000,284797,NULL),
       ('2017-05-01',NULL   ,1216491,400000,327517,NULL),
       ('2017-06-01',NULL   ,1398964,400000,430451,NULL),
       ('2017-07-01',NULL   ,1608809,400000,495018,NULL),
       ('2017-08-01',NULL   ,1850130,400000,569271,NULL),
       ('2017-09-01',NULL   ,2127650,400000,654661,NULL),
       ('2017-10-01',NULL   ,2446797,400000,752861,NULL),
       ('2017-11-01',NULL   ,2813817,400000,865790,NULL),
       ('2017-12-01',NULL   ,3235889,400000,995658,NULL);
```

Table:

```SQL
SELECT month,
       cash_on_hand_ob::MONEY,
       revenue::MONEY,
       fixed_costs::MONEY,
       variable_costs::MONEY,
       cash_on_hand_cb::MONEY
  FROM transactions;    
```


```console
month      | cash_on_hand_ob |    revenue    | fixed_costs | variable_costs | cash_on_hand_cb
-----------+-----------------+---------------+-------------+----------------+-----------------
2016-01-01 |   $1,000,000.00 |   $100,000.00 | $200,000.00 |     $50,000.00 |
2016-02-01 |                 |   $115,000.00 | $200,000.00 |     $57,500.00 |
2016-03-01 |                 |   $132,250.00 | $200,000.00 |     $66,125.00 |
2016-04-01 |                 |   $152,088.00 | $200,000.00 |     $76,044.00 |
2016-05-01 |                 |   $174,901.00 | $200,000.00 |     $87,450.00 |
2016-06-01 |                 |   $201,136.00 | $200,000.00 |    $100,568.00 |
2016-07-01 |                 |   $231,306.00 | $200,000.00 |    $115,653.00 |
2016-08-01 |                 |   $266,002.00 | $200,000.00 |    $133,001.00 |
2016-09-01 |                 |   $305,902.00 | $200,000.00 |    $107,066.00 |
2016-10-01 |                 |   $351,788.00 | $200,000.00 |    $123,126.00 |
2016-11-01 |                 |   $404,556.00 | $200,000.00 |    $141,595.00 |
2016-12-01 |                 |   $465,239.00 | $200,000.00 |    $162,834.00 |
2017-01-01 |                 |   $695,533.00 | $400,000.00 |    $187,259.00 |
2017-02-01 |                 |   $799,862.00 | $400,000.00 |    $215,348.00 |
2017-03-01 |                 |   $919,842.00 | $400,000.00 |    $247,650.00 |
2017-04-01 |                 | $1,057,818.00 | $400,000.00 |    $284,797.00 |
2017-05-01 |                 | $1,216,491.00 | $400,000.00 |    $327,517.00 |
2017-06-01 |                 | $1,398,964.00 | $400,000.00 |    $430,451.00 |
2017-07-01 |                 | $1,608,809.00 | $400,000.00 |    $495,018.00 |
2017-08-01 |                 | $1,850,130.00 | $400,000.00 |    $569,271.00 |
2017-09-01 |                 | $2,127,650.00 | $400,000.00 |    $654,661.00 |
2017-10-01 |                 | $2,446,797.00 | $400,000.00 |    $752,861.00 |
2017-11-01 |                 | $2,813,817.00 | $400,000.00 |    $865,790.00 |
2017-12-01 |                 | $3,235,889.00 | $400,000.00 |    $995,658.00 |
(24 rows)
```

Given a set of past or projected cash flows and an opening balance, we want to calculate the `closing` and `opening balance` for each period.

The **Closing Balance (CB)** will be equal to the `Opening Balance (OB)` plus `Revenue`, less the `Fixed Costs` and the `Variable Costs`:

```console
CB = OB + Revenue - Fixed_Costs - Variable_Costs
CB = OB + (change in balance)

change in balance = Revenue - fixed_Costs - Variable_costs
```

The **Opening Balance (OB)** will be equal to the previous period’s `Closing Balance` (CB).

```console
OB = Previous CB
```

We want to return the following table:

```console
month      | cash_on_hand_ob |    revenue    | fixed_costs | variable_costs | cash_on_hand_cb
-----------+-----------------+---------------+-------------+----------------+-----------------
2016-01-01 |   $1,000,000.00 |   $100,000.00 | $200,000.00 |     $50,000.00 |     $850,000.00
2016-02-01 |     $850,000.00 |   $115,000.00 | $200,000.00 |     $57,500.00 |     $707,500.00
2016-03-01 |     $707,500.00 |   $132,250.00 | $200,000.00 |     $66,125.00 |     $573,625.00
2016-04-01 |     $573,625.00 |   $152,088.00 | $200,000.00 |     $76,044.00 |     $449,669.00
2016-05-01 |     $449,669.00 |   $174,901.00 | $200,000.00 |     $87,450.00 |     $337,120.00
2016-06-01 |     $337,120.00 |   $201,136.00 | $200,000.00 |    $100,568.00 |     $237,688.00
2016-07-01 |     $237,688.00 |   $231,306.00 | $200,000.00 |    $115,653.00 |     $153,341.00
2016-08-01 |     $153,341.00 |   $266,002.00 | $200,000.00 |    $133,001.00 |      $86,342.00
2016-09-01 |      $86,342.00 |   $305,902.00 | $200,000.00 |    $107,066.00 |      $85,178.00
2016-10-01 |      $85,178.00 |   $351,788.00 | $200,000.00 |    $123,126.00 |     $113,840.00
2016-11-01 |     $113,840.00 |   $404,556.00 | $200,000.00 |    $141,595.00 |     $176,801.00
2016-12-01 |     $176,801.00 |   $465,239.00 | $200,000.00 |    $162,834.00 |     $279,206.00
2017-01-01 |     $279,206.00 |   $695,533.00 | $400,000.00 |    $187,259.00 |     $387,480.00
2017-02-01 |     $387,480.00 |   $799,862.00 | $400,000.00 |    $215,348.00 |     $571,994.00
2017-03-01 |     $571,994.00 |   $919,842.00 | $400,000.00 |    $247,650.00 |     $844,186.00
2017-04-01 |     $844,186.00 | $1,057,818.00 | $400,000.00 |    $284,797.00 |   $1,217,207.00
2017-05-01 |   $1,217,207.00 | $1,216,491.00 | $400,000.00 |    $327,517.00 |   $1,706,181.00
2017-06-01 |   $1,706,181.00 | $1,398,964.00 | $400,000.00 |    $430,451.00 |   $2,274,694.00
2017-07-01 |   $2,274,694.00 | $1,608,809.00 | $400,000.00 |    $495,018.00 |   $2,988,485.00
2017-08-01 |   $2,988,485.00 | $1,850,130.00 | $400,000.00 |    $569,271.00 |   $3,869,344.00
2017-09-01 |   $3,869,344.00 | $2,127,650.00 | $400,000.00 |    $654,661.00 |   $4,942,333.00
2017-10-01 |   $4,942,333.00 | $2,446,797.00 | $400,000.00 |    $752,861.00 |   $6,236,269.00
2017-11-01 |   $6,236,269.00 | $2,813,817.00 | $400,000.00 |    $865,790.00 |   $7,784,296.00
2017-12-01 |   $7,784,296.00 | $3,235,889.00 | $400,000.00 |    $995,658.00 |   $9,624,527.00
(24 rows)
```


## Solution

```SQL
WITH chg_tx AS (
  SELECT   t.*
         , (revenue - fixed_costs - variable_costs)::MONEY AS change
    FROM transactions t
),
cumulative_change AS (
  SELECT   month
         , revenue::MONEY
         , fixed_costs::MONEY
         , variable_costs::MONEY
         , MIN(month) OVER() AS first_month
         , SUM(change) OVER(ORDER BY month) AS change
    FROM chg_tx
)
SELECT  cc.month AS month
      , CASE WHEN cc.month = cc.first_month
             THEN t1.initial_ob::MONEY
             ELSE t1.initial_ob::MONEY + LAG(change,1) OVER(ORDER BY cc.month)
        END AS cash_on_hand_ob
      , cc.revenue
      , cc.fixed_costs
      , cc.variable_costs
      , t1.initial_ob::MONEY + change AS cash_on_hand_cb
  FROM (SELECT MAX(cash_on_hand_ob) AS initial_ob
          FROM transactions) t1, cumulative_change cc;
```

## Discussion

Let’s start by calculating change in balance:

```console
Change = Revenue – Fixed Costs – Variable Costs
```

```SQL
SELECT (revenue - fixed_costs - variable_costs)::MONEY AS change
  FROM transactions;  
```

```console
change
---------------
-$150,000.00
-$142,500.00
-$133,875.00
-$123,956.00
-$112,549.00
-$99,432.00
-$84,347.00
-$66,999.00
-$1,164.00
$28,662.00
$62,961.00
$102,405.00
$108,274.00
$184,514.00
$272,192.00
$373,021.00
$488,974.00
$568,513.00
$713,791.00
$880,859.00
$1,072,989.00
$1,293,936.00
$1,548,027.00
$1,840,231.00
(24 rows)
```

Next, we want to calculate the cumulative of this number.

```SQL
WITH chg_tx AS (
  SELECT   month
         , (revenue - fixed_costs - variable_costs)::MONEY AS change
    FROM transactions
)
SELECT   month
       , SUM(change) OVER(ORDER BY month)
  FROM chg_tx;  
```

```console
month      |      sum
-----------+---------------
2016-01-01 |  -$150,000.00
2016-02-01 |  -$292,500.00
2016-03-01 |  -$426,375.00
2016-04-01 |  -$550,331.00
2016-05-01 |  -$662,880.00
2016-06-01 |  -$762,312.00
2016-07-01 |  -$846,659.00
2016-08-01 |  -$913,658.00
2016-09-01 |  -$914,822.00
2016-10-01 |  -$886,160.00
2016-11-01 |  -$823,199.00
2016-12-01 |  -$720,794.00
2017-01-01 |  -$612,520.00
2017-02-01 |  -$428,006.00
2017-03-01 |  -$155,814.00
2017-04-01 |   $217,207.00
2017-05-01 |   $706,181.00
2017-06-01 | $1,274,694.00
2017-07-01 | $1,988,485.00
2017-08-01 | $2,869,344.00
2017-09-01 | $3,942,333.00
2017-10-01 | $5,236,269.00
2017-11-01 | $6,784,296.00
2017-12-01 | $8,624,527.00
(24 rows)
```

Now that we’ve got the `cumulative change` for each period, we’ll add that change to the `opening balance` to get the `closing balance`.

The **closing balance** for each period is calculated as the `initial opening balance` plus the `change each period`.

The opening balance for each period is calculated as the `initial opening balance` plus the `cumulative change` in the last period.


```SQL
WITH chg_tx AS (
  SELECT   t.*
         , (revenue - fixed_costs - variable_costs)::MONEY AS change
    FROM transactions t
),
cumulative_change AS (
  SELECT   month
         , revenue::MONEY
         , fixed_costs::MONEY
         , variable_costs::MONEY
         , MIN(month) OVER() AS first_month
         , SUM(change) OVER(ORDER BY month) AS change
    FROM chg_tx
)
SELECT  cc.month AS month
      , CASE WHEN cc.month = cc.first_month
             THEN t1.initial_ob::MONEY
             ELSE t1.initial_ob::MONEY + LAG(change,1) OVER(ORDER BY cc.month)
        END AS cash_on_hand_ob
      , cc.revenue
      , cc.fixed_costs
      , cc.variable_costs
      , t1.initial_ob::MONEY + change AS cash_on_hand_cb
  FROM (SELECT MAX(cash_on_hand_ob) AS initial_ob
          FROM transactions) t1, cumulative_change cc;
```

```console
month      | cash_on_hand_ob |    revenue    | fixed_costs | variable_costs | cash_on_hand_cb
-----------+-----------------+---------------+-------------+----------------+-----------------
2016-01-01 |   $1,000,000.00 |   $100,000.00 | $200,000.00 |     $50,000.00 |     $850,000.00
2016-02-01 |     $850,000.00 |   $115,000.00 | $200,000.00 |     $57,500.00 |     $707,500.00
2016-03-01 |     $707,500.00 |   $132,250.00 | $200,000.00 |     $66,125.00 |     $573,625.00
2016-04-01 |     $573,625.00 |   $152,088.00 | $200,000.00 |     $76,044.00 |     $449,669.00
2016-05-01 |     $449,669.00 |   $174,901.00 | $200,000.00 |     $87,450.00 |     $337,120.00
2016-06-01 |     $337,120.00 |   $201,136.00 | $200,000.00 |    $100,568.00 |     $237,688.00
2016-07-01 |     $237,688.00 |   $231,306.00 | $200,000.00 |    $115,653.00 |     $153,341.00
2016-08-01 |     $153,341.00 |   $266,002.00 | $200,000.00 |    $133,001.00 |      $86,342.00
2016-09-01 |      $86,342.00 |   $305,902.00 | $200,000.00 |    $107,066.00 |      $85,178.00
2016-10-01 |      $85,178.00 |   $351,788.00 | $200,000.00 |    $123,126.00 |     $113,840.00
2016-11-01 |     $113,840.00 |   $404,556.00 | $200,000.00 |    $141,595.00 |     $176,801.00
2016-12-01 |     $176,801.00 |   $465,239.00 | $200,000.00 |    $162,834.00 |     $279,206.00
2017-01-01 |     $279,206.00 |   $695,533.00 | $400,000.00 |    $187,259.00 |     $387,480.00
2017-02-01 |     $387,480.00 |   $799,862.00 | $400,000.00 |    $215,348.00 |     $571,994.00
2017-03-01 |     $571,994.00 |   $919,842.00 | $400,000.00 |    $247,650.00 |     $844,186.00
2017-04-01 |     $844,186.00 | $1,057,818.00 | $400,000.00 |    $284,797.00 |   $1,217,207.00
2017-05-01 |   $1,217,207.00 | $1,216,491.00 | $400,000.00 |    $327,517.00 |   $1,706,181.00
2017-06-01 |   $1,706,181.00 | $1,398,964.00 | $400,000.00 |    $430,451.00 |   $2,274,694.00
2017-07-01 |   $2,274,694.00 | $1,608,809.00 | $400,000.00 |    $495,018.00 |   $2,988,485.00
2017-08-01 |   $2,988,485.00 | $1,850,130.00 | $400,000.00 |    $569,271.00 |   $3,869,344.00
2017-09-01 |   $3,869,344.00 | $2,127,650.00 | $400,000.00 |    $654,661.00 |   $4,942,333.00
2017-10-01 |   $4,942,333.00 | $2,446,797.00 | $400,000.00 |    $752,861.00 |   $6,236,269.00
2017-11-01 |   $6,236,269.00 | $2,813,817.00 | $400,000.00 |    $865,790.00 |   $7,784,296.00
2017-12-01 |   $7,784,296.00 | $3,235,889.00 | $400,000.00 |    $995,658.00 |   $9,624,527.00
(24 rows)
```