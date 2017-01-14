
DROP DATABASE IF EXISTS normal_cars;

DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars normal_user
\i scripts/denormal_data.sql

DROP TABLE IF EXISTS model_table;

DROP TABLE IF EXISTS make_table;

CREATE TABLE make_table (
  id serial NOT NULL primary key,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
  );


CREATE TABLE model_table (
  id serial primary key,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  make_id integer REFERENCES make_table(id),
  year integer NOT NULL
  );


INSERT INTO make_table(make_code, make_title)
  SELECT DISTINCT make_code, make_title FROM car_models;

INSERT INTO model_table(model_code, model_title, year, make_id)
  SELECT DISTINCT model_code, model_title, year, id AS make_id
  FROM car_models
  INNER JOIN make_table ON car_models.make_title = make_table.make_title;


