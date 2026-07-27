create table youtube(video_id varchar2(50),
trending_date date,
title varchar2(500),
channel_title varchar2(300),
category_id number,
publish_date date,
time_frame varchar2(100),
published_day_of_week varchar2(20),
publish_country varchar2(50),
tags varchar2(4000),
views number,
likes number,
dislikes number,
comment_count number,
comments_disabled varchar2(10),
ratings_disabled varchar2(10),
video_error_or_removed varchar2(10),
year number,
month varchar2(20),
day varchar2(20),
trending_days number,
sentiment varchar2(20));

alter table youtube modify title varchar2(2000);

//This query is used to display the table
select * from youtube;

//Total Videos
select count(*) as total_videos from youtube;

//Total views
select sum(views) as total_views from youtube;

//Average views
select round(avg(views),2) as Average_views from youtube;

//Average Likes
select round(avg(likes),2) as Average_likes from youtube;

//Average comments
select round(avg(comment_count),2) as Average_Comments from youtube;

//Maximum views
select max(views) from youtube;

//Top 10 Most Viewed Videos
select title,views from youtube
order by views desc
fetch first 10 rows only;

//Top 10 Channels
select channel_title,count(*) as trending_videos from youtube
group by channel_title
order by trending_videos desc
fetch first 10 rows only;

//Videos by Category
select category_id,count(*) from youtube
group by category_id
order by count(*) desc;

//Average views by Category
select category_id,round(avg(views),2) as Average_Views from youtube
group by category_id
order by Average_Views desc;

//Total Views by Country
select Publish_country,sum(views) from youtube
group by publish_country
order by sum(views) desc;

//Average likes by Country
select publish_country,round(avg(views)) from youtube
group by publish_country
order by avg(views) desc;

//Videos published each year
select year,count(*) from youtube
group by year
order by year asc;

//Monthly Trend
select month,count(*) from youtube
group by month;

//Published Day Analysis
select published_day_of_week,count(*) from youtube
group by published_day_of_week;

//Sentiment Count
select sentiment,count(*) from youtube 
group by sentiment;

//Videos with Highest Likes
select title,likes
from youtube
order by likes desc
fetch first 10 rows only;

//Highest Commented Videos
select title,comment_count
from youtube
order by comment_count desc
fetch first 10 rows only;

//Videos with Disabled Comments
select count(*) from youtube 
where comments_disabled = 'TRUE';

//Videos with Disabled Ratings
select count(*) 
from youtube
where ratings_disabled='TRUE';

//Videos above Average Views
select title,views from youtube
where views > (select round(avg(views)) from youtube);

//Rank Categories by Average Views
select category_id,
round(avg(views)) avg_views,
RANK() over(order by avg(views) desc) ranking
from youtube
group by category_id;

//create a view
create view top_videos as 
select title,
views,likes,comment_count
from youtube
where views>1000000;

//Query the view
select * from top_videos;

//Top 5 Videos per Country
select * from (select publish_country,title,views,ROW_NUMBER() over(PARTITION by publish_country 
order by views desc)
rn
from youtube)
where rn<=5;

