--
-- File generated with SQLiteStudio v3.3.3 on Fri Nov 4 20:51:50 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: country_data
DROP TABLE IF EXISTS country_data;

CREATE TABLE country_data (
    country_id CHAR (25)    PRIMARY KEY
                            NOT NULL,
    location   CHAR (10),
    date       DATETIME,
    vaccine    VARCHAR (20),
    source_url VARCHAR (15) 
);


-- Table: data_source
DROP TABLE IF EXISTS data_source;

CREATE TABLE data_source (
    data_source_id INTEGER      PRIMARY KEY AUTOINCREMENT
                                NOT NULL,
    location       VARCHAR (10),
    iso_code       CHAR (4)     REFERENCES locations (location),
    source_name    VARCHAR (10),
    source_website VARCHAR (15) 
);


-- Table: locations
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location              VARCHAR (10),
    iso_code              CHAR (4)     PRIMARY KEY
                                       NOT NULL,
    vaccines              VARCHAR (15),
    last_observation_date DATE,
    source_name           VARCHAR (10),
    source_website        VARCHAR (15) 
);


-- Table: us_state_vaccinations
DROP TABLE IF EXISTS us_state_vaccinations;

CREATE TABLE us_state_vaccinations (
    us_state_id             CHAR (25) NOT NULL
                                      PRIMARY KEY,
    date                    DATE,
    location                CHAR (15),
    total_vaccinations      NUMERIC,
    total_distributed       NUMERIC,
    people_vaccinated       NUMERIC,
    people_fully_vaccinated NUMERIC,
    daily_vaccinations      NUMERIC,
    share_doses_used        NUMERIC,
    total_boosters          NUMERIC
);


-- Table: vaccinations
DROP TABLE IF EXISTS vaccinations;

CREATE TABLE vaccinations (
    vaccination_id          CHAR (25)    NOT NULL
                                         PRIMARY KEY,
    location                VARCHAR (10),
    iso_code                CHAR (4)     REFERENCES locations (iso_code),
    date                    DATE,
    total_vaccinations      NUMERIC,
    people_vaccinated       NUMERIC,
    people_fully_vaccinated NUMERIC,
    total_boosters          NUMERIC,
    daily_vaccinations_raw  NUMERIC,
    daily_vaccinations      NUMERIC,
    daily_people_vaccinated NUMERIC
);


-- Table: vaccinations_by_age_group
DROP TABLE IF EXISTS vaccinations_by_age_group;

CREATE TABLE vaccinations_by_age_group (
    age_group_id CHAR (25) NOT NULL
                           PRIMARY KEY,
    location     CHAR (10),
    date         DATE,
    age_group    INT
);


-- Table: vaccinations_by_manufacturer
DROP TABLE IF EXISTS vaccinations_by_manufacturer;

CREATE TABLE vaccinations_by_manufacturer (
    manufacturer_id    CHAR (25)    NOT NULL
                                    PRIMARY KEY,
    location           CHAR (10),
    date               DATE,
    vaccine            VARCHAR (20),
    total_vaccinations NUMERIC
);


-- Table: vaccines
DROP TABLE IF EXISTS vaccines;

CREATE TABLE vaccines (
    vaccine_id INTEGER      NOT NULL,
    location   VARCHAR (35),
    vaccines   TEXT (10) 
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
