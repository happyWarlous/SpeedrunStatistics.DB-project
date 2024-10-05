DROP SCHEMA IF EXISTS speedruns_stats CASCADE;
CREATE SCHEMA IF NOT EXISTS speedruns_stats;


DROP TABLE IF EXISTS speedruns_stats.game;
CREATE TABLE speedruns_stats.game (
  game_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  release_year date NOT NULL,
  genre VARCHAR(100) NOT NULL,
  platform VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS speedruns_stats.category;
CREATE TABLE speedruns_stats.category (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  leader VARCHAR(100) NOT NULL,
  update_dttm VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS speedruns_stats.game_x_category;
CREATE TABLE speedruns_stats.game_x_category (
  game_id SERIAL NOT NULL,
  category_id SERIAL NOT NULL,

  PRIMARY KEY (game_id, category_id),
  FOREIGN KEY (game_id) REFERENCES speedruns_stats.game(game_id),
  FOREIGN KEY (category_id) REFERENCES speedruns_stats.category(category_id)
);


DROP TABLE IF EXISTS speedruns_stats.speedrun_info;
CREATE TABLE speedruns_stats.speedrun_info (
  record_id SERIAL,
  platform VARCHAR(100) NOT NULL,
  mods VARCHAR(100),
  game_version VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS speedruns_stats.player;
CREATE TABLE speedruns_stats.player (
  player_id SERIAL PRIMARY KEY,
  nick VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(100) NOT NULL,
  social VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS speedruns_stats.speedrun;
CREATE TABLE speedruns_stats.speedrun (
  record_id SERIAL PRIMARY KEY,
  category_id SERIAL,
  player_id SERIAL,
  player VARCHAR(100) NOT NULL,
  in_game_time TIME NOT NULL,
  run_date DATE NOT NULL,
  verificator_url VARCHAR(100) NOT NULL,

  FOREIGN KEY (category_id) REFERENCES speedruns_stats.category(category_id),
  FOREIGN KEY (player_id) REFERENCES speedruns_stats.player(player_id)
);

