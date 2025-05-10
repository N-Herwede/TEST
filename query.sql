-- SECTION 2 : CLASSEMENTS INSTANTANÉS

-- 2.1 Top 10 mondial (standard rating)
SELECT fide_id, nom AS name, elo_standard AS rating
FROM   players
ORDER  BY elo_standard DESC
LIMIT  10;

-- 2.2 Top 10 féminin (standard rating)
SELECT fide_id, nom AS name, elo_standard AS rating
FROM   players
WHERE  gender = 'F'
ORDER  BY elo_standard DESC
LIMIT  10;

-- 2.3 Top 10 masculin (standard rating)
SELECT fide_id, nom AS name, elo_standard AS rating
FROM   players
WHERE  gender = 'M'
ORDER  BY elo_standard DESC
LIMIT  10;
