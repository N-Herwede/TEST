BEGIN TRANSACTION;

-- Players table
DROP TABLE IF EXISTS players;
CREATE TABLE players (
    fide_id TEXT PRIMARY KEY,
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

-- Rankings table
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings (
    ranking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fide_id TEXT NOT NULL,
    date TEXT NOT NULL,
    elo_standard INTEGER,
    elo_rapid INTEGER,
    elo_blitz INTEGER,
    FOREIGN KEY (fide_id) REFERENCES players(fide_id)
);

-- Tournaments table
DROP TABLE IF EXISTS tournaments;
CREATE TABLE tournaments (
    tournament_id INTEGER PRIMARY KEY,
    nom TEXT,
    ville TEXT,
    pays TEXT,
    debut DATE,
    fin DATE
);

-- Games table
DROP TABLE IF EXISTS games;
CREATE TABLE games (
    game_id INTEGER PRIMARY KEY,
    tournament_id INTEGER,
    date DATE,
    joueur_blanc_id TEXT,
    joueur_noir_id TEXT,
    resultat TEXT,
    format TEXT,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id),
    FOREIGN KEY (joueur_blanc_id) REFERENCES players(fide_id),
    FOREIGN KEY (joueur_noir_id) REFERENCES players(fide_id)
);

-- Registrations table
DROP TABLE IF EXISTS registrations;
CREATE TABLE registrations (
    registration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INTEGER,
    fide_id TEXT,
    registration_date DATE,
    seed INTEGER,
    bye INTEGER,
    fee_paid INTEGER,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id),
    FOREIGN KEY (fide_id) REFERENCES players(fide_id)
);

COMMIT;
