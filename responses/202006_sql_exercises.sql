-------------------
-- SQL EXERCISES --
-------------------

-- 1
select name 
from people

-- 2
select name 
from people
order by name desc 


-- 3 
select count(*) as n_people
from people

-- Check
select *
from people
limit 5

-- 4
select *
from people
where fav_music_gndr is null;

-- 5
select distinct fav_music_gndr
from people
where fav_music_gndr is not null;

-- 6
select fav_music_gndr, count(*) as n_followers 
from people
where fav_music_gndr is not null
group by fav_music_gndr
order by n_followers DESC;

-- 7 
-- List all names starting with "Ma" 
-- Hint! Check for SUBSTRING or LEFT build-in functions
select name, fav_music_gndr
from people
where left(name, 2) = 'Ma';
-- where substring(name from 1 for 2) = 'Ma'

-- 8 (session 2)
select fav_music_gndr, 
	count(*) * 200 / (select count(*) from people where fav_music_gndr is not null) as perc
from people
where fav_music_gndr is not null
group by fav_music_gndr
order by perc DESC;

select fav_music_gndr, 
    round(count(fav_music_gndr)::float / (select count(*) from people where fav_music_gndr is not null) * 200)::int 
        as n_songs 
from people
where fav_music_gndr is not null
group by fav_music_gndr
order by n_songs desc;

select fav_music_gndr,  
    round(200 * count(*)::float / (select count(*) from people where fav_music_gndr is not null))::int as n_songs
from people
where fav_music_gndr is not null
group by fav_music_gndr;

-- 9
select sum(case when fav_music_gndr != 'reggaeton' then 1 else 0 end) as opositors,
sum(case when fav_music_gndr = 'reggaeton' then 1 else 0 end) as followers
from people;

with tmp_table as (
    select 
        sum(CASE WHEN fav_music_gndr != 'reggaeton' THEN 1
            else 0
        END) as opositors,
        sum(CASE WHEN fav_music_gndr = 'reggaeton' THEN 1
            else 0
        END) as pro_reggaeton
    from 
        people
)
select opositors, pro_reggaeton, opositors > pro_reggaeton as controversy
from tmp_table;

-- 10
select sum(debt_balance) 
from people;

-- 11
select max(abs(debt_balance)) as max_owed,
	min(abs(debt_balance)) as min_owed,
	avg(abs(debt_balance)) as avg_owed
from people
where debt_balance != 0;

-- 12
with tab as (
	select * 
	from people
	left join housing
	on people.house_id = housing.house_id
) 
select neighborhood, locality, abs(sum(debt_balance)) as total_debt
from tab 
group by neighborhood, locality
order by total_debt desc
limit 1;

-- 13
with tab as (
	select * 
	from people
	left join housing
	on people.house_id = housing.house_id
) 
select neighborhood, locality, abs(sum(debt_balance) / count(*)) as debt_pers
from tab 
group by neighborhood, locality
order by debt_pers desc
limit 1;

-- 14
select people_jobs.job_id, job_name, sum(abs(debt_balance)) / count(*) as total_debt
from people
join people_jobs
on people.person_id = people_jobs.person_id
join jobs
on people_jobs.job_id = jobs.job_id
group by people_jobs.job_id, job_name
order by total_debt desc;

-- 15
select name 
from people
where house_id = 
(select house_id from people where name = 'Anna') and name != 'Anna';
