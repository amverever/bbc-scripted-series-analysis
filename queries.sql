USE bbc;

SELECT *
FROM scripted;

# The series which have the most seasons
SELECT *
FROM scripted
ORDER BY season desc
limit 1;

# The series which have the most episodes
SELECT *
FROM scripted
ORDER BY episode desc
limit 1;

# The series whose the average number of episodes per one season is the highest
SELECT *
FROM scripted
ORDER BY avg_episode desc
limit 1;

# How many series are still going?
SELECT genre, category, premiere_age, count(*)
FROM scripted
WHERE status = "Renewed"
GROUP BY genre, category, premiere_age
ORDER BY count(*) desc;

# The series which are in present and lasts the longest
SELECT *
FROM scripted
WHERE status = "Renewed"
ORDER BY premiere_age asc
limit 1;

# Number of Seasons breakdown
SELECT season, count(*) as count
FROM scripted
GROUP BY season
ORDER BY count desc;

# Short/Medium/Long Breakdown
SELECT category, count(*)
FROM scripted
GROUP BY category;

# Genre Breakdown
SELECT genre, count(*)
FROM scripted
GROUP BY genre;

# Age Breakdown
SELECT premiere_age, count(*)
FROM scripted
GROUP BY premiere_age
ORDER BY premiere_age asc;

# Category, Age, Genre Breakdown
SELECT category, premiere_age, genre, count(*)
FROM scripted
GROUP BY category, premiere_age, genre
ORDER BY premiere_age;

# List of TV Flim
SELECT *
FROM scripted
WHERE classification = "TV Flim";

# Average number of episode per one season
SELECT sum(episode) / sum(season)
FROM scripted;

# Average number of episode per one season
SELECT genre, category, sum(episode) / sum(season)
FROM scripted
GROUP BY genre, category;

# Number of Seasons Breakdown
SELECT category, premiere_age, genre, avg(season)
FROM scripted
GROUP BY category, premiere_age, genre
ORDER BY premiere_age;

# The series which last more than the average
SELECT * FROM 
(SELECT name, category, genre, premiere_age, season, avg(season) over(partition by genre, category) as avg_season_partition
FROM scripted) as s
HAVING s.season > s.avg_season_partition;

# Number of Episode Breakdown
SELECT category, premiere_age, genre, avg (avg_episode)
FROM scripted
GROUP BY category, premiere_age, genre
ORDER BY premiere_age;

