-- 1. все игроки, которые прошли игру менее чем за два, в категории 100%

SELECT player, in_game_time
FROM speedruns_stats.speedrun a
JOIN speedruns_stats.category b ON a.category_id = b.category_id
WHERE b.category_name = '100%' AND EXTRACT(HOUR FROM in_game_time) < 2;

-- 2. список игроков, у которых есть забеги на платформе PC

SELECT nick
FROM speedruns_stats.player
WHERE player_id IN (
  SELECT DISTINCT player_id
  FROM speedruns_stats.speedrun
  WHERE category_id IN (
    SELECT category_id
    FROM speedruns_stats.speedrun_info
    WHERE platform = 'PC'
  )
);

-- 3. количество спидранов для каждой категории и отфильтровать только те, у которых количество спидранов больше 5

SELECT a.category_name, COUNT(b.record_id) AS num_speedruns
FROM speedruns_stats.category a
JOIN speedruns_stats.speedrun b ON a.category_id = b.category_id
GROUP BY a.category_name
HAVING COUNT(b.record_id) > 5;

-- 4. имена игроков с ссылками на Твич

SELECT name, social AS twitch_channel
FROM speedruns_stats.player
WHERE social LIKE '%twitch.tv%';

-- 5. вывести игроков и время забгеа, выполненные на платформе Xbox One без модов, и отсортировать их по дате спидрана

SELECT player, in_game_time, s.run_date
FROM speedruns_stats.speedrun_info si
JOIN speedruns_stats.speedrun s ON si.record_id = s.record_id
WHERE si.platform = 'Xbox One' AND si.mods is NULL
ORDER BY s.run_date;

--- 6. ссылка на подтверждение забегов, которые были совершены с 5 по 10 числа в категории All Bosses

SELECT verificator_url
FROM speedruns_stats.speedrun s
JOIN speedruns_stats.category c ON c.category_id = s.category_id
WHERE EXTRACT(DAY FROM run_date) BETWEEN 5 AND 10 AND category_name = 'All Bosses';

--  7. страны спидранеров, которые проходили игры в жанре Platformer, в алфавитном порядке

SELECT country
FROM speedruns_stats.player
WHERE player_id IN (
    SELECT DISTINCT player_id
    FROM speedruns_stats.speedrun
    WHERE category_id IN (
        SELECT category_id
        FROM speedruns_stats.game_x_category
        WHERE game_id IN (
          SELECT game_id
          FROM speedruns_stats.game
          WHERE genre = 'Platformer'
        )
    )
)
ORDER BY 1;

-- 8. количество спидранов для каждой платформы

SELECT si.platform, COUNT(*) AS num_speedruns
FROM speedruns_stats.speedrun_info si
JOIN speedruns_stats.speedrun s ON si.record_id = s.record_id
GROUP BY si.platform;

-- 9. лидеры в играх с жанром Action, в обратном алфавитном порядке

SELECT leader, genre
FROM speedruns_stats.game g
JOIN speedruns_stats.game_x_category gc ON g.game_id = gc.game_id
JOIN speedruns_stats.category c ON c.category_id = gc.category_id
WHERE genre LIKE '%Action%'
ORDER BY leader DESC;

-- 10. названия игр, которые спидранили более 3 часов, в алфавитном порядке

SELECT name, in_game_time
FROM speedruns_stats.game g
JOIN speedruns_stats.game_x_category gc ON g.game_id = gc.game_id
JOIN speedruns_stats.category c ON gc.category_id = c.category_id 
JOIN speedruns_stats.speedrun s ON c.category_id = s.category_id
WHERE EXTRACT(HOUR FROM in_game_time) > 3
ORDER BY name
