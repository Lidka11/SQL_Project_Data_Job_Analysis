# Introduction
Hi! This project is the effect of [course](https://youtu.be/7mz73uXD9DA?si=NFWGiKA8JLo5EtK4) made by Luke Barousse.

There are some statistics about salaries, demand in Data Analyst jobs.

SQL queries? Check them here: [project_sql folder](/project_sql/)
# Background

# Tools I Used
- **SQL**
- **PostgresSQL**
- **Visual Studio Code**
- **Git & Github**

# The Analysis

### 1. Top Paying Data Analyst Jobs
```sql
SELECT
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.job_title_short,
    jpf.job_work_from_home,
    jpf.salary_year_avg,
    jpf.job_posted_date,
    cd.name as company_name
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd ON jpf.company_id=cd.company_id
WHERE
    jpf.job_title_short='Data Analyst' 
    AND jpf.job_location='Anywhere'
    AND jpf.salary_year_avg IS NOT NULL
ORDER BY jpf.salary_year_avg DESC
LIMIT 10
```
| Job Title | Company | Salary (USD) | Job Location |
| :--- | :--- | :--- | :--- |
| **Data Analyst** | Mantys | **$650,000** | Anywhere |
| **Director of Analytics** | Meta | **$336,500** | Anywhere |
| **Associate Director- Data Insights** | AT&T | **$255,830** | Anywhere |
| **Data Analyst, Marketing** | Pinterest Job Advertisements | **$232,423** | Anywhere |
| **Data Analyst (Hybrid/Remote)** | Uclahealthcareers | **$217,000** | Anywhere |
| **Principal Data Analyst (Remote)** | SmartAsset | **$205,000** | Anywhere |
| **Director, Data Analyst - HYBRID** | Inclusively | **$189,309** | Anywhere |
| **Principal Data Analyst, AV Performance Analysis** | Motional | **$189,000** | Anywhere |
| **Principal Data Analyst** | SmartAsset | **$186,000** | Anywhere |
| **ERM Data Analyst** | Get It Recruit - Information Technology | **$184,000** | Anywhere |

### 2. Top paying job skills
```sql
WITH top_paying_jobs AS(
    SELECT
        jpf.job_id,
        jpf.job_title,    
        jpf.salary_year_avg,
        cd.name as company_name
    FROM
        job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd ON jpf.company_id=cd.company_id
    WHERE
        jpf.job_title_short='Data Analyst' 
        AND jpf.job_location='Anywhere'
        AND jpf.salary_year_avg IS NOT NULL
    ORDER BY jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT
    tpj.*,
    sd.skills
FROM top_paying_jobs AS tpj
INNER JOIN skills_job_dim AS sjd ON tpj.job_id=sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id=sd.skill_id
ORDER BY salary_year_avg DESC
```
| Job Title | Company | Salary (USD) | Skills |
| :--- | :--- | :--- | :--- |
| **Associate Director- Data Insights** | AT&T | **$255,830** | sql, python, r, azure, databricks, aws, pandas, pyspark, jupyter, excel, tableau, power bi, powerpoint |
| **Data Analyst, Marketing** | Pinterest | **$232,423** | sql, python, r, hadoop, tableau |
| **Data Analyst (Hybrid/Remote)** | Uclahealthcareers | **$217,000** | sql, crystal, oracle, tableau, flow |
| **Principal Data Analyst (Remote)** | SmartAsset | **$205,000** | sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab |
| **Director, Data Analyst - HYBRID** | Inclusively | **$189,309** | sql, python, azure, aws, oracle, snowflake, tableau, power bi, sap, jenkins, bitbucket, atlassian, jira, confluence |
| **Principal Data Analyst, AV Performance** | Motional | **$189,000** | sql, python, r, git, bitbucket, atlassian, jira, confluence |
| **Principal Data Analyst** | SmartAsset | **$186,000** | sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab |
| **ERM Data Analyst** | Get It Recruit | **$184,000** | sql, python, r |

### 3. Top demanded skills
```sql
SELECT
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id=sd.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_work_from_home=True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
### 4. Top paying skills
```sql
SELECT
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg),0) AS srednia
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id=sd.skill_id
WHERE
    job_title_short='Data Analyst' 
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
ORDER BY srednia DESC
LIMIT 25;
```
### 5. Optimal skills
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

# What I Learned

# Conclusions

