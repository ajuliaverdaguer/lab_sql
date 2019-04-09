-------------------
-- SQL EXERCISES --
-------------------

-- P1
select distinct fav_music_gndr
from people

-- P2
select fav_music_gndr, count(*) as n_followers 
from people
group by fav_music_gndr
order by n_followers desc

-- P3
-- List all names starting with "Ma" corresponding to boys
-- Hint! Check for SUBSTRING or LEFT build-in functions
select name, fav_music_gndr
from people
where left(name, 2) = 'Ma'
-- where substring(name from 1 for 2) = 'Ma'

-- P4
select fav_music_gndr, count(*) * 200 / (select count(*) from people) as perc
from people
group by fav_music_gndr
order by perc desc

-- P5
select sum(case when fav_music_gndr != 'reggaeton' then 1 else 0 end) as opositors,
sum(case when fav_music_gndr = 'reggaeton' then 1 else 0 end) as followers
from people

-- P6
select sum(debt_balance) 
from people

-- P7
with a as (select * 
from people
left join housing
on people.house_id = housing.house_id) 
select neighborhood, locality, abs(sum(debt_balance)) as total_debt
from a 
group by neighborhood, locality
order by total_debt desc
limit 1

-- P8
with a as (select * 
from people
left join housing
on people.house_id = housing.house_id) 
select neighborhood, locality, abs(sum(debt_balance) / count(*)) as debt_pers
from a 
group by neighborhood, locality
order by debt_pers desc
limit 1

-- P9
select people_jobs.job_id, job_name, sum(abs(debt_balance)) / count(*) as total_debt
from people
join people_jobs
on people.person_id = people_jobs.person_id
join jobs
on people_jobs.job_id = jobs.job_id
group by people_jobs.job_id, job_name
order by total_debt desc

-- P10
select name 
from people
where house_id = 
(select house_id from people where name = 'Anna') and name != 'Anna'

