/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/



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