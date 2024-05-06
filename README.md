# Introduction

Dive into the data job market. Focusing on data analyst roles, this project explores top paying jobs in-demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

### The questions to be answered through the SQL queries:

1. What are the top-paying jobs for my role?
2. What are the skills requires for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
   a. Optimal: High Demand AND High Paying

# Tools I Used

- **SQL:** The bakcbone of the analysis, allowing me to query the database and unerth critical imsights.
- **PostreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** The go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing the SQL scrips and analysis, ensuring collaboration and project tracking

# The Analysis

Each query of this project aimend at investigating specific aspects of the data analyst job market.
Here how each question was approached:

### 1.Top Paying Data Analyst Jobs

To identify the highest-pating roles, we filtered the data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL --remove the null salaries
ORDER BY salary_year_avg DESC
LIMIT 10
```

Here´s is the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There´s a high diversity in the job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytcs

### 2. Skills for Top Paying Jobs

To understand what skills are requires for the top-paying jobs, a join between the job postings table and the skills data table was done, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS(
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL --remove the null salaries
    ORDER BY salary_year_avg DESC
    LIMIT 10 --showing the top 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```

Here´s the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a b old count of 6.
  Other skills like **R**,**Snowflake**, **Pandas**, and **Excel** showing varying degrees of demand.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frecuently requested in job postings, directing focus to areas with high demand.

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
limit 5
```

Here´s the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong fundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualisation Tools** like **Python**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Skills based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT skills,
    ROUND(AVG(salary_year_avg), 1) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL -- AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
limit 25
```

Here´s a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Top salaries and commanded by analysts skilled in big data technoligies (PySpark,Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy)reflecting the industry´s high valuation of data processing and predictive modeling capabilities.
- **Software Developement & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premiun on skills that facilitate automation adn efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boost earning potential in data analytics.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary daa, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skills development.

```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25
```

Here´s the breakdown of the most optimal skills for Data Analysts in 2023:

- **High Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectivaly. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data alalysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,975, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries from $97,786 to $104,534 reflects the enduring need for data storage, retrieve and management expertise.

# What I learned

- **Complex Query Crafting:** Mastered tge art of advanced SQL, merging tables and wielding WITH clauses.
- **Data aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into data summarising.
- **Analytical Wizardry:** Leveled up my real world puzzle-solving skills, turning question into actionable, insightful SQL queries.

# Conclusions

### Insights

1. **Top Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000
2. **Skills for Top-Paying Jobs:** High paying data analyst jobs require advanced proficiency in SQL, suggesting it´s critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skills in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premiun on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary positioning it as one of the most optimal skills for data analysts to learn and maximize their market value.

### Closing Thoughts

This project enhanced SQL skills and provided valuable insights into the data analyst job market. The finsings from the analysts serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adaptation to emerging trends in the field of data analytics.
