--Project
/*
 Questions to Answer
 1.What are the top-paying jobs for my role?
 2.What are the skills requires for these top-paying roles?
 3.What are the most in-demand skills for my role?
 4.What are the top skills based on salary for my role?
 5.What are the most optimal skills to learn?
 a. Optimal: High Demand AND High Paying
 */
/*
 Question: What are the top-paying jobs for my role?
 -Identify the top 10 highest-paying Data Analyst roles that are available remotely.
 -Focuses on job postings with specified salaries (remove nulls)
 -Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment op
 
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    --contract or full time
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL --remove the null salaries
ORDER BY salary_year_avg DESC
LIMIT 10 --showing the top 10