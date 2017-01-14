
DROP DATABASE IF EXISTS normal_cars;

DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars normal_user
\i scripts/denormal_data.sql

CREATE TABLE make_table (
  id serial NOT NULL primary key,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
  );


CREATE TABLE model_table (
  id serial NOT NULL primary key,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  make_id integer NOT NULL,
  FOREIGN KEY(make_id) REFERENCES make_table(id),
  year integer NOT NULL
  );


INSERT INTO make_table(make_code, make_title)
  SELECT DISTINCT make_code, make_title FROM car_models;
