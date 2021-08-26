-- DROP TABLE public."Spotify2020";

CREATE TABLE public."Spotify2020"
(
    index numeric NOT NULL,
    "Highest Charting Position" numeric,
    "Number of Times Charted" numeric,
    "Week of Highest Charting" character varying COLLATE pg_catalog."default",
    "Song Name" character varying COLLATE pg_catalog."default",
    "Streams" bigint,
    "Artist" character varying COLLATE pg_catalog."default",
    "Artist Followers" bigint,
    "Song ID" character varying COLLATE pg_catalog."default",
    "Genre" character varying COLLATE pg_catalog."default",
    "Release Date" character varying COLLATE pg_catalog."default",
    "Weeks Charted" character varying COLLATE pg_catalog."default",
    "Popularity" real,
    "Danceability" real,
    "Energy" real,
    "Loudness" real,
    "Speechiness" real,
    "Acousticness" real,
    "Liveness" real,
    "Tempo" real,
    "Duration (ms)" bigint,
    "Valence" real,
    "Chord" character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE public."Spotify2020"
    OWNER to postgres;
	
	
-- UPLOAD DATA FROM .CSV FILE



-- CHECK DATA
select * from public."Spotify2020";


-- ALTER COLUMN TYPES TO UPDATE 
ALTER TABLE public."Spotify2020"
ALTER COLUMN "Valence" TYPE real
USING "Valence"::real;

TRUNCATE TABLE public."Spotify2020";


SELECT count("index") 
from public."Spotify2020" 
WHERE "Valence"='' or "Tempo"='';

-- Create Table
CREATE TABLE public."Spotify2020"
(
    index numeric NOT NULL,
    "Highest Charting Position" numeric,
    "Number of Times Charted" numeric,
    "Week of Highest Charting" character varying COLLATE pg_catalog."default",
    "Song Name" character varying COLLATE pg_catalog."default",
    "Streams" bigint,
    "Artist" character varying COLLATE pg_catalog."default",
    "Artist Followers" bigint,
    "Song ID" character varying COLLATE pg_catalog."default",
    "Genre" character varying COLLATE pg_catalog."default",
    "Release Date" character varying COLLATE pg_catalog."default",
    "Weeks Charted" character varying COLLATE pg_catalog."default",
    "Popularity" real,
    "Danceability" real,
    "Energy" real,
    "Loudness" real,
    "Speechiness" real,
    "Acousticness" real,
    "Liveness" real,
    "Tempo" real,
    "Duration (ms)" bigint,
    "Valence" real,
    "Chord" character varying COLLATE pg_catalog."default"
)

-- Import data from CSV

-- Remove Leading & Trailing spaces from character columns
UPDATE public."Spotify2020" set "Song Name" = TRIM(BOTH from "Song Name");
UPDATE public."Spotify2020" set "Streams" = TRIM("Streams");
UPDATE public."Spotify2020" set "Artist" = TRIM("Artist");
UPDATE public."Spotify2020" set "Artist Followers" = TRIM("Artist Followers");
UPDATE public."Spotify2020" set "Song ID" = TRIM("Song ID");
UPDATE public."Spotify2020" set "Genre" = TRIM("Genre");
UPDATE public."Spotify2020" set "Release Date" = TRIM("Release Date");
UPDATE public."Spotify2020" set "Weeks Charted" = TRIM("Weeks Charted");
UPDATE public."Spotify2020" set "Popularity" = TRIM("Popularity");
UPDATE public."Spotify2020" set "Danceability" = TRIM("Danceability");
UPDATE public."Spotify2020" set "Energy" = TRIM("Energy");
UPDATE public."Spotify2020" set "Loudness" = TRIM("Loudness");
UPDATE public."Spotify2020" set "Speechiness" = TRIM("Speechiness");
UPDATE public."Spotify2020" set "Acousticness" = TRIM("Acousticness");
UPDATE public."Spotify2020" set "Liveness" = TRIM("Liveness");
UPDATE public."Spotify2020" set "Tempo" = TRIM("Tempo");
UPDATE public."Spotify2020" set "Duration (ms)" = TRIM("Duration (ms)");
UPDATE public."Spotify2020" set "Valence" = TRIM("Valence");
UPDATE public."Spotify2020" set "Chord" = TRIM("Chord");


-- CHECK NULL VALUES
SELECT count("index") 
from public."Spotify2020" 
WHERE "Valence"='' or "Tempo"='';

-- SAVE NULL VALUES IN ANOTHER TABLE
select column_name,data_type 
from information_schema.columns 
where table_name = 'Spotify2020';


CREATE TABLE CORRUPT_DATA_SPOTIFY
AS 
SELECT * 
from public."Spotify2020" 
WHERE "Valence"='' or "Tempo"='';
commit;

select * from public.CORRUPT_DATA_SPOTIFY;

-- DELETE NULL VALUES FROM ORIG TABLE
DELETE FROM public."Spotify2020"
WHERE "Valence"='' or "Tempo"='';
COMMIT;

-- ALTER COLUMN DATA TYPES
UPDATE public."Spotify2020" set "Streams" = REPLACE("Streams",',','');
ALTER TABLE public."Spotify2020"
ALTER COLUMN "Streams" TYPE bigint
USING "Streams"::bigint;

UPDATE public."Spotify2020" set "Artist Followers" = REPLACE("Artist Followers",',','');
ALTER TABLE public."Spotify2020"
ALTER COLUMN "Artist Followers" TYPE bigint
USING "Artist Followers"::bigint;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Popularity" TYPE real
USING "Popularity"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Danceability" TYPE real
USING "Danceability"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Energy" TYPE real
USING "Energy"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Loudness" TYPE real
USING "Loudness"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Speechiness" TYPE real
USING "Speechiness"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Acousticness" TYPE real
USING "Acousticness"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Liveness" TYPE real
USING "Liveness"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Tempo" TYPE real
USING "Tempo"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Duration (ms)" TYPE bigint
USING "Duration (ms)"::bigint;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Valence" TYPE real
USING "Valence"::real;

ALTER TABLE public."Spotify2020"
ALTER COLUMN "Release Date" TYPE DATE
USING TO_DATE("Release Date", 'MM/DD/YY');

commit;

-- QUERIES --------------

-- Artist
SELECT count(DISTINCT "Artist")
from public."Spotify2020"; --total unique artists --712

SELECT count(DISTINCT "Artist")
from public."Spotify2020"
where "Artist" NOT LIKE '%,%'; --individual artist --387

-- Songs
SELECT count(DISTINCT "Song ID")
from public."Spotify2020"; --total unique songs -- 1516


-- Top Songs
SELECT "Song Name", "Artist", "Streams"
from public."Spotify2020"
order by "Streams" DESC
LIMIT 10; -- by highest streams

-- Top Artists by highest Streams
SELECT SUM("Streams") as CumStream, "Artist"
from public."Spotify2020"
GROUP BY "Artist"
ORDER BY CumStream DESC
LIMIT 10;

-- Ranking all songs by Top Highly Streamed Artists
SELECT "Artist",
	RANK() OVER(PARTITION BY "Artist" ORDER BY "Streams" DESC) as "RankStream",
	"Song Name", "Streams",
	SUM("Streams") OVER(PARTITION BY "Artist" ORDER BY "Streams" DESC) as RunningTotal
from public."Spotify2020"
WHERE "Artist" IN (SELECT "Artist" from public."Spotify2020" 
				  GROUP BY "Artist" ORDER BY SUM("Streams") DESC
				  LIMIT 10);


-- Songs released by artists IN 2020
SELECT  DISTINCT "Artist"
	,COUNT("Song ID") OVER(PARTITION BY "Artist") as NoOfSongs
from public."Spotify2020"
WHERE "Artist" NOT LIKE '%,%'
order by NoOfSongs desc
LIMIT 10;
--- can also be written as:
SELECT "Artist", COUNT("Song ID") as NoOfSongs
from public."Spotify2020"
GROUP BY "Artist"
ORDER BY NoOfSongs DESC
LIMIT 10;

-- Artists with highest followers at any time in 2020
SELECT DISTINCT "Artist"
	,MAX("Artist Followers") OVER(PARTITION BY "Artist") as HighFollowers
from public."Spotify2020"
WHERE "Artist" NOT LIKE '%,%'
order by HighFollowers DESC
LIMIT 10;

-- Songs with highest streams
SELECT "Streams", "Song Name", "Artist"
from public."Spotify2020"
order by "Streams" DESC
LIMIT 10;


-- 
SELECT "Artist", "Song Name", "Streams"
	,AVG("Streams") OVER(PARTITION BY "Artist" 
						 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
						 AS AverageStreams
from public."Spotify2020"
WHERE "Artist" IN (
	SELECT "Artist" from public."Spotify2020"
	GROUP BY "Artist"
	ORDER BY SUM("Streams") DESC
	LIMIT 10
)
ORDER BY AverageStreams DESC, "Streams" DESC,  "Artist" ASC, "Song Name";




