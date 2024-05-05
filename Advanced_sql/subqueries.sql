/*
 Subqueries: query nested inside a larger query
 It can be used in SELECT, FROM, and WHERE clauses
 */
SELECT *
FROM(
        --subquery starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT (
                MONTH
                FROM job_posted_date
            ) = 1
    ) AS january_jobs;
--subquery ends here
/*Common Table Expressions (CTEs): define a temporary result sta that you can reference
 Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
 Defined with WITH
 */
WITH january_jobs AS (
    --CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (
            MONTH
            FROM job_posted_date
        ) = 1
) --CTE definition ends here
SELECT *
FROM january_jobs
    /*
     Subqueries
     Notes:
     Subquery: query withing another query
     It can be used in several places in the main query
     -such as the SELECT, FROM, WHERE, or HAVING clauses
     It´s executed first, and the results are passed to the outer query
     -it´s used when you want to perform a calcualtion before the main query can complete its calcualtion
     */
SELECT company_id,
    job_no_degree_mention
FROM job_postings_fact
WHERE job_no_degree_mention = true --Now we are going to add this query inside another query
SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = true
        ORDER BY company_id
    )
    /*
     CTEs - Common Table Expresion
     Notes:
     CTE - A temporary result set that can reference within a SELECT, INSERT, UPDATE or DELETE statement
     Exist only during the execution of a query
     It´s a defined query that can be referenced in the main query or other CTEs
     WITH - used to define CTE at the beginning of a query.
     */
    WITH january_jobs AS (
        -- CTE definition starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(
                MONTH
                FROM job_posted_date
            ) = 1
    ) -- CTE definition ends here
SELECT *
FROM january_jobs
    /*
     Find the companies that have the most job openings.
     - get the total number of job postings per company id (job_posting_fact)
     - Return the total number of jobs with the companu name (comapny_dim)
     */
    WITH company_job_count AS(
        --The CTE starts here
        SELECT company_id,
            count(*) AS total_jobs
        FROM job_postings_fact
        GROUP BY company_id
    ) --CTE ends here
    -- SELECT *
    -- FROM company_job_count
    --Now we´re joing to do a LEFT JOIN between A (company_dim) and B (job_postings_fact)
SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC --Practice Problem 7
    /*
     Find the count of the number of remote job postings per skill
     - Display the top 5 skills by their demand in remote jobs
     - Include skill ID, name, and count of postings requiring the skill
     */
SELECT job_id,
    skill_id
FROM skills_job_dim AS skills_to_job
LIMIT 30
SELECT job_postings.job_id,
    skill_id --job_postings.job_work_from_home 
FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE job_postings.job_work_from_home = True --Count
SELECT skill_id,
    COUNT(*) AS skill_count --job_postings.job_work_from_home 
FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE job_postings.job_work_from_home = True
GROUP BY skill_id
    /*CTE */
    /*
     Problem 7
     */
    WITH remote_job_skills as (
        SELECT skill_id,
            COUNT(*) AS skill_count --job_postings.job_work_from_home 
        FROM skills_job_dim AS skills_to_job
            INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
        WHERE job_postings.job_work_from_home = True
            and job_postings.job_title_short = 'Data Analyst'
        GROUP BY skill_id
    )
SELECT skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
    INNER JOIN skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5