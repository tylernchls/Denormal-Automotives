DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars WITH OWNER normal_user;

DROP TABLE IF EXISTS make_table;

CREATE TABLE make_table (
  make_id serial NOT NULL primary key,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
  );

DROP TABLE IF EXISTS model_table;

CREATE TABLE model_table (
  id serial NOT NULL primary key,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  make_id integer REFERENCES make_table(make_id),
  year integer NOT NULL
  );

\c normal_cars normal_user
\i scripts/denormal_data.sql

INSERT INTO make_table(make_code, make_title)
  SELECT DISTINCT make_code, make_title FROM car_models;
