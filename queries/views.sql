-- представление текущего лидера в каждой категории каждой игры, а также его лучшее игровое время
CREATE VIEW game_leaderboard AS
SELECT g.name AS game_name, c.category_name, p.nick AS leader_nick, s.in_game_time
FROM speedruns_stats.speedrun s
JOIN speedruns_stats.category c ON s.category_id = c.category_id
JOIN speedruns_stats.player p ON s.player_id = p.player_id
JOIN speedruns_stats.game g ON c.category_id = g.game_id
WHERE s.in_game_time = (SELECT MIN(in_game_time) FROM speedruns_stats.speedrun WHERE category_id = c.category_id);

-- представление с количеством игроков из каждой страны
CREATE VIEW player_country_stats AS
SELECT country, COUNT(*) AS num_players
FROM speedruns_stats.player
GROUP BY country
ORDER BY num_players DESC;

-- представление со среднем временем прохождения для каждой игры в каждой категории
CREATE VIEW average_speedrun_time_per_game AS
SELECT gc.game_id, g.name AS game_name, c.category_name, AVG(EXTRACT(EPOCH FROM s.in_game_time)) AS avg_time_seconds
FROM speedruns_stats.speedrun s
JOIN speedruns_stats.category c ON s.category_id = c.category_id
JOIN speedruns_stats.game_x_category gc ON s.category_id = gc.category_id
JOIN speedruns_stats.game g ON gc.game_id = g.game_id
GROUP BY gc.game_id, g.name, c.category_name;

-- представление с количеством забегов по странам
CREATE VIEW platform_distribution AS
SELECT platform, COUNT(*) AS num_speedruns
FROM speedruns_stats.speedrun_info
GROUP BY platform
ORDER BY num_speedruns DESC;

-- представление с количеством забегов у каждого игрока за всё время
CREATE VIEW player_speedrun_count AS
SELECT p.nick AS player_nick, COUNT(s.record_id) AS num_speedruns
FROM speedruns_stats.speedrun s
JOIN speedruns_stats.player p ON s.player_id = p.player_id
GROUP BY p.nick
ORDER BY num_speedruns DESC;
