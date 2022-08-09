# Table of Contents

This file list the chapters and paragraphs of this book.

Extract of CookBook SQL 2nd edition.

# Chapter 0: DATA

[It](./00_data) contains the instructions to create the database and load the data used in this book.

|file|description|
|:-:|:----------:|
|[01_cbook_db](./00_data/01_cbook_db.md)|create the cookbook database|

# Chapter 1: Retrieving Records

[Chapter 1](./01_retrieving_records) focuses on basic SELECT statements.

|file|description|
|:---:|:--------:|
|[01](./01_retrieving_records/01_retrieving_all_rows_and_columns_from_a_table.md)|Retrieving all rows and columns from a table|
|[02](./01_retrieving_records/02_retrieving_a_subset_of_rows_from_a_table.md)|Retrieving a Subset of Rows from a Table Problem|
|[03](./01_retrieving_records/03_finding_rows_that_satisfy_multiple_conditions.md)|Finding Rows That Satisfy Multiple Conditions Problem|
|[04](./01_retrieving_records/04_retrieving_a_subset_of_columns_from_a_table.md)|Retrieving a Subset of Columns from a Table Problem|
|[05](./01_retrieving_records/05_providing_meaningful_names_to_columns.md)|Providing Meaningful Names for Columns Problem|
|[06](./01_retrieving_records/06_referencing_alias_column_in_where_clause.md)|Referencing an Aliased Column in the WHERE Clause Problem|
|[07](./01_retrieving_records/07_concatenating_column_values.md)|Concatenating Column Values Problem|
|[08](./01_retrieving_records/08_using_conditional_logic_select.md)|Using Conditional Logic in a SELECT Statement Problem|
|[09](./01_retrieving_records/09_limiting_number_of_rows.md)|Limiting the Number of Rows Returned Problem|
|[10](./01_retrieving_records/10_returning_n_random_records.md)|Returning n Random Records from a Table Problem|
|[11](./01_retrieving_records/11_finding_null_values.md)|Finding Null Values|
|[12](./01_retrieving_records/12_transforming_null_values_to_real_values.md)|Transforming Nulls into Real Values Problem|
|[13](./01_retrieving_records/13_searching_for_patterns.md)|Searching for Patterns Problem|

# Chapter 2: Sorting Query Results

[Chapter 2](./02_sorting_query_results) focuses on customizing how your query results look. By understanding how to control how your result set is organized, you can provide more readable and meaningful data.

|file|description|
|:---:|:--------:|
|[01](./02_sorting_query_results/01_returning_query_results_in_specified_order.md)|Returning Query Results in a Specified Order Problem|
|[02](./02_sorting_query_results/02_sorting_by_multiple_fields.md)|Sorting by Multiple Fields Problem|
|[03](./02_sorting_query_results/03_sorting_by_substring.md)|Sorting by Substrings Problem|
|[04](./02_sorting_query_results/04_sorting_mixed_alphanumeric_data.md)|Sorting Mixed Alphanumeric Data Problem|
|[05](./02_sorting_query_results/05_dealing_with_nulls_sorting.md)|Dealing with Nulls When Sorting Problem|
|[06](./02_sorting_query_results/06_sorting_on_data_dependent_key.md)|Sorting on a Data-Dependent Key Problem|

# Chapter 3: Working with Multiple Tables

[Chapter 3](./03_working_with_multiple_tables) introduces the use of joins and set operations to combine data from multiple tables. Joins are the foundation of SQL. Set operations are also important.

|file|description|
|:---:|:--------:|
|[01](./03_working_with_multiple_tables/01_stacking_one_rowset_atop_another.md)|Stacking One Rowset A Top Atop another|
|[02](./03_working_with_multiple_tables/02_combining_related_rows.md)|Combining Related Rows|
|[03](./03_working_with_multiple_tables/03_finding_rows_in_common_between_two_tables.md)|Finding Rows in common between tables|
|[04](./03_working_with_multiple_tables/04_retrieving_values_from_table_that_donot_exist_in_another.md)|Retrieving Values From One Table That Do not Exists in Another|
|[05](./03_working_with_multiple_tables/05_retrieving_rows_from_a_table_that_donot_correspond_to_row_in_another.md)|Retrieving Rows From One Table That Do not correspond To Rows In Another|
|[06](./03_working_with_multiple_tables/06_adding_join_to_query_without_interferring.md)|Adding Joins to a Query Without Interfering With Other Joins|
|[07](./03_working_with_multiple_tables/07_determing_whether_two_tables_have_same_data.md)|Determiong Whether Two Tables Have the Same Data|
|[08](./03_working_with_multiple_tables/08_filtering_join.md)|Identyfing and Avoiding Cartesian Product|
|[09](./03_working_with_multiple_tables/09_performing_join_when_using_aggregates.md)|Performing Joins When Using Aggregates|
|[10](./03_working_with_multiple_tables/10_performing_outer_join_when_using_aggregates.md)|Performing Outer Joins When using Aggregates|
|[11](./03_working_with_multiple_tables/11_returning_missing_data_from_multiple_tables.md)|Retruning Missing Data From Multiple Tables|
|[12](./03_working_with_multiple_tables/12_using_nulls_in_operations_compartison.md)|Using NULLs in Operations and Comparisons|

# Chapter 4: Working with Strings

This [chapter](./04_working_with_strings) focuses on **string manipulation** in `SQL`. Keep in mind that `SQL` **is not designed to perform complex string manipulation**, and you can (and will) find working with strings in SQL to be cumbersome and frustrating at times.

Despite SQL’s limitations, there are some **useful built-in functions provided by the different DBMSs**, and we’ve tried to use them in creative ways. Hopefully you take away from this chapter a better appreciation for what can and can’t be done in SQL when working with strings.

In many cases you’ll be surprised by how easy parsing and transforming strings can be, while at other times you’ll be aghast by the kind of SQL that is necessary to accomplish a particular task.

Many of the recipes that follow use the `TRANSLATE` and `REPLACE` functions that are now available in all the DBMSs covered in this book, with the exception of MySQL, which only has replace. In this last case, it is worth noting early on that you can replicate the effect of `TRANSLATE` by using nested `REPLACE` functions.

The first recipe in this chapter is critically important, as it is leveraged by several of the subsequent solutions. In many cases, you’d like to have the **ability to traverse a string by moving through it a character at a time**. Unfortunately, SQL does not make this easy. Because there is limited loop functionality in SQL, you need to **mimic a loop to traverse a string**. We call this operation “**walking a string**” or “walking through a string,” and the very first recipe explains the technique. This is a fundamental operation in string parsing when using SQL, and is referenced and used by almost all recipes in this chapter. We strongly suggest becoming comfortable with how the technique works.

|file|description|
|:---:|:--------:|
|[01](./04_working_with_strings/01_walking_a_string.md)|Walking a string|
|[02](./04_working_with_strings/02_embedding_quotes_with_string_literals.md)|Embedding Quotes Within String Literals|
|[03](./04_working_with_strings/03_counting_occurrences_char_strings.md)|Counting the Occurrences of a Character in a String|
|[04](./04_working_with_strings/04_removing_unwanted_characters_from_a_string.md)|Removing Unwanted Characters from a String|
|[05](./04_working_with_strings/05_separating_numeric_and_charater_data.md)|Separating Numeric and Character Data|
|[06](./04_working_with_strings/06_determining_whether_a_string_is_alphanumeric.md)|Determining Whether a String Is Alphanumeric|
|[07](./04_working_with_strings/07_extracting_initials_from_a_name.md)|Extracting Initials from a Name|
|[08](./04_working_with_strings/08_ordering_by_parts_of_a_string.md)|Ordering by Parts of a String|
|[09](./04_working_with_strings/09_ordering_by_a_number_in_a_string.md)|Ordering by a Number in a String|
|[10](./04_working_with_strings/10_creating_delimited_list_form_table_rows.md)|Creating a Delimited List from Table Rows|
|[11](./04_working_with_strings/11_converting_delimited_data_into_multivalue_in_list.md)|Converting Delimited Data into a Multivalued IN-List|
|[12](./04_working_with_strings/12_alphabetaizing_a_string.md)|Alphabetizing a String|
|[13](./04_working_with_strings/13_identifying_string_that_can_be_treated_as_numbers.md)|Identifying Strings That Can Be Treated as Numbers|
|[14](./04_working_with_strings/14_extracting_the_nth_delimited_string.md)|Extracting the nth Delimited Substring|
|[15](./04_working_with_strings/15_parsing_an_ip_address.md)|Parsing an IP Address|
|[16](./04_working_with_strings/16_finiding_text_not_matching_a_pattern.md)|Finding Text Not Matching a Pattern|