# Using subqueries

SELECT \*
FROM (
SELECT 'ME@hakibenita.com' AS email
) AS emails;

# Using the WITH clause

-   In SQL, we can define a common table expression (CTE) using the WITH clause:

WITH emails AS (
SELECT 'ME@hakibenita.com' AS email
)
SELECT \* FROM emails;

-   Using the WITH clause, we declare a named query that we can reference in the same query like any other table or subquery. Using the WITH clause is very similar to using a subquery.

# Multiple CTEs

-   For large queries, we can have multiple CTE’s in a single query. The CTEs can also depend on each other.

-   In the previous example we generated a list of emails. Before we can start processing the emails, we want to clean the data. We also want to work on them in lowercase.

-   To clean the emails we generated in a CTE in the previous example, we can add another CTE that depends on it, and transforms the emails to lowercase:

WITH emails AS (
SELECT 'ME@hakibenita.com' AS email
),

normalized_emails AS (
SELECT lower(email::text) AS email FROM emails
)

SELECT \* FROM normalized_emails;

-   We first declared a common table expression called emails with a single email address.

-   We then added another common table expression called normalized_emails, that depends on emails, and applied the function lower to transform the emails to lowercase.

-   We can now reference normalized_emails in the main query like any other table or subquery. Notice how using CTE’s makes the query much easier to read and follow.

# CTE as optimization fences

-   In the beginning of this lesson, we said that using CTE is equivalent to using a subquery. For example, consider the following query using a subquery:

SELECT \* FROM (SELECT 'me@hakibenita.com' AS email) as emails;

-   The query above is equivalent to the following query using a CTE:

WITH emails AS (SELECT 'me@hakibenita.com' AS email) SELECT \* FROM emails;

-   Before PostgreSQL version 11, a Common Table Expression (CTE) would be executed and its results would be stored for the duration of the query. This process is known as materializing the CTE.

-   In PostgreSQL version 11 and later, the default behavior changed to not materialize the CTE. Instead, the database evaluates the CTE on-the-fly, similar to how subqueries are handled.

-   If we do want the database to materialize the results of a CTE in PostgreSQL versions 11 and later, we can use the MATERIALIZE keyword:

WITH emails AS MATERIALIZED (
SELECT 'me@hakibenita.com' AS email
)
SELECT \* FROM emails;

-   Notice how we added the MATERIALIZE keyword before the CTE query. The database will now materialize the results of the CTE emails before performing any processing on it.

-   If we don’t mark the CTE as MATERIALIZED, it will not be materialized. If for some reason we want to explicitly state that the CTE should not be materialized, we can use the NOT MATERIALIZE keyword:

WITH emails AS NOT MATERIALIZED (
SELECT 'me@hakibenita.com' AS email
)
SELECT \* FROM emails;

-   So, when might we want to materialize a CTE?

-   When we use multiple CTEs in a single query, the query can get pretty big. Sometimes they can become so huge that it can become a real challenge for the database to optimize. Sometimes it is useful to instruct the database to process parts of the query separately from the rest of the query. This is often called an “optimization fence.”

-   Materializing the results of large queries takes up space and memory, and can also prevent the database from transforming the query in ways that might make it more performant. This is why the default behavior is to not materialize the results of a CTE.
