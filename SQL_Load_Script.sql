-- Load data into FIDE Chess Database

-- IMPORTANT: run using the sqlite3 CLI with ".read SQL_Schema.sql" first to create schema,
-- then ".read SQL_Load_Script.sql" to load data. Ensure you're in the directory containing Data/.

-- Players staging imports
DROP TABLE IF EXISTS players_staging;
CREATE TABLE players_staging (
    fide_id TEXT,
    nom TEXT,
    titre TEXT,
    sexe TEXT,
    pays TEXT,
    age INTEGER,
    annee_naissance INTEGER,
    elo_standard INTEGER,
    elo_rapid INTEGER,
    elo_blitz INTEGER
);
.mode csv
.import Data/FIDE_Avril_2025.csv players_staging
.import Data/FIDE_Mars_2025.csv players_staging

-- Final players table
DELETE FROM players;
INSERT OR IGNORE INTO players
SELECT DISTINCT
    fide_id,
    nom,
    titre,
    sexe,
    pays,
    age,
    annee_naissance,
    elo_standard,
    elo_rapid,
    elo_blitz
FROM players_staging;

-- Rankings imports
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings (
    ranking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fide_id TEXT,
    date TEXT,
    elo_standard INTEGER,
    elo_rapid INTEGER,
    elo_blitz INTEGER
);
.mode csv
.import Data/Rankings_Avril.csv rankings
.import Data/Rankings_Mars.csv rankings

-- Tournaments imports
DROP TABLE IF EXISTS tournaments;
CREATE TABLE tournaments (
    tournament_id INTEGER PRIMARY KEY,
    nom TEXT,
    ville TEXT,
    pays TEXT,
    debut DATE,
    fin DATE
);
.mode csv
.import Data/Tournaments.csv tournaments

-- Games imports
DROP TABLE IF EXISTS games;
CREATE TABLE games (
    game_id INTEGER PRIMARY KEY,
    tournament_id INTEGER,
    date DATE,
    joueur_blanc_id TEXT,
    joueur_noir_id TEXT,
    resultat TEXT,
    format TEXT
);
.mode csv
.import Data/Games.csv games

-- Registrations imports
DROP TABLE IF EXISTS registrations;
CREATE TABLE registrations (
    registration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INTEGER,
    fide_id TEXT,
    registration_date DATE,
    seed INTEGER,
    bye INTEGER,
    fee_paid INTEGER
);
.mode csv
.import Data/ParisOpen2025_registrations.csv registrations
