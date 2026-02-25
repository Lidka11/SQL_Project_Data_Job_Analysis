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

### 2. To do

# What I Learned

# Conclusions

