1 - (True or False) The following expressions are equivalent: percentile_cont(0) WITHIN GROUP (ORDER BY n) and MIN(n).

The 0 percentile is the minimum value.
True

2 - The following expressions are equivalent: percentile_cont(0.5) WITHIN GROUP (ORDER BY n) and percentile_disc(0.5) WITHIN GROUP (ORDER BY n).

The function percentile_cont computes the continuous percentile within the ordered set, while percentile_disc computes the discrete percentile.
False

3- (True or False) The following expressions are equivalent: percentile_disc(0) WITHIN GROUP (ORDER BY n) and percentile_disc(1) WITHIN GROUP (ORDER BY n DESC).

The expression percentile_disc(0) WITHIN GROUP (ORDER BY n) computes the 0 percentile from the data set sorted in ascending order, and the expression percentile_disc(1) WITHIN GROUP (ORDER BY n DESC) computes the 100% percentile from a dataset sorted in descending order. Both expressions will compute the minimum value
True
