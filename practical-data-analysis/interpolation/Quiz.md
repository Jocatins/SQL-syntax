1 - What is the result of the expression 0 = NULL?
Null
Using the equality operator to compare a literal against NULL will evaluate to NULL.

2- Is the result of the expression A = 1 equivalent to A IS NOT DISTINCT FROM 1?
Only if A is not nullable
When A cannot be null, the equality operator will evaluate to either True to False, just like the expression using IS NOT DISTINT FROM

3 - What is the result of the expression NULL IS NOT DISTINCT FROM NULL?
True

4 - What is the result of the expression COALESCE(NULL, 1, NULL, 2)?
1
The function COALESCE will return the first value that is not NULL.

5 - Can you use the window function LEAD to get the last known value for forward fill?
Only if there are no consecutive missing values

When there are consecutive missing values, LEAD will not work as expected.
