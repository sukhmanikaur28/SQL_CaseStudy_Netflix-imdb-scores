create database Netflix;
use Netflix;

select * from netflix_originals;
select * from genre_details;

select * from netflix_originals n join genre_details g
where n.genreID = g.genreID;

-- Count of number of rows in both the tables (584, 19)
select count(*) as no_of_rows from netflix_originals;

select count(*) as no_of_rows from genre_details;

-- Setting the date in a format that SQL understands
alter table netflix_originals
add column new_date date;

select premiere_date, str_to_date(left(premiere_date,10), "%d-%m-%y")
from netflix_originals;

update netflix_originals
set new_date = str_to_date(left(premiere_date,10), "%d-%m-%Y");

select * from netflix_originals;

-- Count of Distinct Language
select distinct language from netflix_originals;

-- Languages in which the films were released
select language, count(language) as films_count
from netflix_originals group by language;

-- Comparison of most popular language used
select language, count(language) as Preferred_language,
round(AVG(Runtime),2) as Average_Time, round(AVG(IMDBScore),2) as Average_Score
from netflix_originals group by Language having count(language)>=1
order by AVG(IMDBScore) DESC, AVG(Runtime) DESC;

-- IMDB Score Range
select max(ImdbScore) as MaxScore, min(ImdbScore) as MinScore, 
round(Avg(ImdbScore),2) as AvgScore from netflix_originals;

-- Distinct Genre
select distinct genre from genre_details;

-- Comparison of Popular Genres
select n.genreID, g.genre, count(genre) as Popular_Genre
from netflix_originals n join genre_details g
where n.GenreID = g.GenreID group by Genre
having count(genre)>=1 order by Popular_Genre desc;

select g.genre, n.imdbscore from netflix_originals n join genre_details g
where n.GenreID=g.GenreID group by Genre
order by IMDBScore desc;


-- Highest rank original release 
select title, genreid, IMDBScore, dense_rank()
over(order by IMDBScore DESC) as DRank from netflix_originals;

select * from (
select title, genreid, IMDBScore, dense_rank()
over(order by IMDBScore DESC) as DRank from netflix_originals)
as DerivedTable where DRank = 1;

-- Comparison of films release year
select year(new_date), count(year(new_date)) as no_of_movies
from netflix_originals group by year(new_date)
having count(year(new_date))>=1
order by year(new_date) desc;

select * from netflix_originals;
select * from genre_details;



