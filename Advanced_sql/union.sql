/*
 UNION
 Notes:
 UNION - combines results from two or more SELECT statements
 they need to have the same amount of columns, and the data type must match
 SELECT column_name
 FROM table_name
 
 UNION -- combine the two tables
 
 SELECT column_name
 FROM table_two;
 
 Gets rid of duplicate rows (unlike UNION ALL)
 All rows are unique
 */
--Get jobs and companies from January
SELECT job_title_short,
    company_id,
    job_location
FROM january_jobs
UNION
--Get jobs and comapnies from february
SELECT job_title_short,
    company_id,
    job_location
FROM february_jobs
UNION
--combine another table
--Get jobs and comapnies from february
SELECT job_title_short,
    company_id,
    job_location
FROM march_jobs
    /*
     UNION ALL
     Notes
     UNION ALL - combine the result of two or more SELECT statements
     They need to have the same amount of columns, and the data type must match
     SELECT column_name
     FROM table_name
     
     UNION ALL -- combine the two tables
     
     SELECT column_name
     FROM table_two;
     
     *Returns all rows, even duplicates (unlike UNION)
     */
    --Get jobs and companies from January
SELECT job_title_short,
    company_id,
    job_location
FROM january_jobs
UNION ALL
--Get jobs and companies from february
SELECT job_title_short,
    company_id,
    job_location
FROM february_jobs
UNION ALL
--combine another table
--Get jobs and comapnies from february
SELECT job_title_short,
    company_id,
    job_location
FROM march_jobs --this query returns 220984 records due to returns duplicates as well
    /*
     Problem 8
     Find job postings from the first quarter that have a salary quarter greater than $70k
     -Combine job postings tables from the first quarter of 2023 (Jan-Mar)
     -Get job postings with and average yearly salary > $70,000
     */
SELECT quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    --Only the date
    quarter1_job_postings.salary_year_avg
FROM(
        --Subquery
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000
    AND quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC