# Question 1

-   Calculate the running total of the revenue generated per week for the first 10 weeks for the movie Avengers.

-   To calculate the running total, we need the MovieId, Weekend, and RevenueInMillions columns from the MovieScreening table. The running total will be calculated using the RevenueInMillions column. The data required to answer this question is shown in the query below:

SELECT Weekend, RevenueInMillions
FROM MovieScreening
WHERE MovieId = 10
ORDER BY Weekend;

# Question 2

-   Calculate the total revenue of each Genre and find the percentage of revenue of each.

# Question 3

-   Calculate the moving average of revenue generated in a three week window for the movie Ocean’s 11.

# Question 4

-   Find the value of RevenueInMillions at the start of each month for the movie Mr. & Mrs. Smith.

# Question 5

-   Calculate the monthly growth rate of revenue for the movie Mission Impossible.
