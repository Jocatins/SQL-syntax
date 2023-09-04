1 - (True or False) The following expression will find the maximum value MAX(value) OVER (PARTITION BY 1).
True

The aggregate expression is using the constant value 1, which means all rows will fall into the same group, and the result of the aggregate will be the max value in the table.

2 - To use a ROW frame we must include ORDER BY in the aggregate expression.
True

Without an ORDER BY, the database can’t sort the rows.

3 - A ROW frame can only include rows prior to the current row
False

A ROW frame can contain both preceding and following rows to the current row.

4 - The following frame will always include exactly 3 rows: ROWS BETWEEN 3 PRECEDING AND CURRENT ROW.
False

The first two rows in each group can contain less than 3 rows.

5 - The LAG(value) and LAG(value, 1) expressions are equal.
True

The default value for the offset is 1, so the two expressions are equivalent.

6 - The LAG(value, -1) and LEAD(value) are equal.
True

Using the LAG function with the negative offset -1 will return the next row, similar to the outcome of running LEAD(value).

7 - The functions LAG and LEAD will always return a value.
False

When no previous or next value is found for the given offset, and a default value was not provided, both LEAD and LAG can return null.

8 - What will be the ranking of the value 5 in series 1,2,2,5,6 using the ROW_NUMBER function?
4

The number 5 is the fourth number in the series.

9 - What will be the ranking of the value 5 in the series 1,2,2,5,6 using the RANK function?
4
The value 5 is the fourth value in the series.

10 - What will be the ranking of the value 5 in the series 1,2,2,5,6 using the DENSE_RANK function?
3

The value 2 repeats itself, so both rows will be ranked 2. The function DENSE_RANK does not have gaps in the ranking, so the rank of the value 5 will be 3.

11 - If there are no duplicates in the ranking sorting key, the ranking of ROW_NUMBER, RANK, and DENSE_RANK will be the same.
True

The difference between RANK and DENSE_RANK to ROW_NUMBER is in how they handle duplicate sorting keys. When there are no duplicate sorting keys, the outcome from all three functions is the same.
