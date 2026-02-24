
with company_job_count AS(
    SELECT 
        company_id,
        count(*) as sum_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
)

SELECT cd.name, cc.sum_jobs
FROM
    company_dim AS cd
LEFT JOIN company_job_count AS cc 
ON cd.company_id=cc.company_id
ORDER BY cc.sum_jobs DESC

#-------

SELECT * FROM skills_job_dim
LIMIT 5;

#--------

WITH skill_count AS(
    SELECT
        skill_id,
        COUNT(skill_id) liczba_skilli
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT 
    sd.skills, sd.type, sc.liczba_skilli
FROM
    skills_dim AS sd
LEFT JOIN skill_count AS sc
ON sd.skill_id=sc.skill_id
ORDER BY sc.liczba_skilli DESC
LIMIT 5

#-------

WITH oferty AS(
    SELECT
        company_id,
        COUNT(*) AS liczba_ofert
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT cd.name, o.liczba_ofert,
    (CASE
        WHEN o.liczba_ofert>50 THEN 'Large'
        WHEN o.liczba_ofert BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Small'
    END) AS wielkosc_firmy
FROM company_dim as cd
LEFT JOIN oferty as o ON cd.company_id=o.company_id


#-------

SELECT * FROM job_postings_fact
LIMIT 5

#-------trudne 2:47

WITH remote_job_skills AS(
    SELECT
        sjd.skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS jpf ON sjd.job_id=jpf.job_id
    WHERE jpf.job_work_from_home=TRUE
    AND jpf.job_title_short = 'Data Analyst'
    GROUP BY sjd.skill_id
)

SELECT
    sd.skills, rjs.skill_count
FROM
    skills_dim AS sd
INNER JOIN remote_job_skills AS rjs ON sd.skill_id=rjs.skill_id
ORDER BY rjs.skill_count DESC
LIMIT 5

#-------

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

#-------------


SELECT
    q1_job_postings.job_title_short,
    q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::date
FROM
    (
        SELECT *
        FROM
            job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) BETWEEN 1 AND 3
        ) AS q1_job_postings
WHERE salary_year_avg > 70000