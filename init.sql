-- Création de la table "movies" avec comme colonne "id_movie", "title_movie", "time_movie" et "date_movie"
CREATE TABLE
    movies (
        id_movie SERIAL PRIMARY KEY,
        title_movie VARCHAR(250) NOT NULL,
        time_movie TIME NOT NULL,
        date_movie DATE NOT NULL
    );
    
-- Création de la table "directors" avec comme colonne "id_director", "firstname_director" et "name_director"
CREATE TABLE
    directors (
        id_director SERIAL PRIMARY KEY,
        firstname_director VARCHAR(50) NOT NULL,
        name_director VARCHAR(50) NOT NULL
    );

-- Modification de la table "movies" afin de rajouter une colonne "id_director" ("id_director" est la clé primaire de la table "directors" et sera la clé étrangère de la table "movies")
ALTER TABLE movies
ADD COLUMN id_director INT REFERENCES directors (id_director);

-- Création de la table "users" avec comme colonne "id_user", "firstname_user", "name_user", "dob_user", "email_user" et "pwd_user"
CREATE TABLE
    users (
        id_user SERIAL PRIMARY KEY,
        firstname_user VARCHAR(50) NOT NULL,
        name_user VARCHAR(50) NOT NULL,
        dob_user DATE,
        email_user VARCHAR(50) NOT NULL,
        pwd_user VARCHAR(50) NOT NULL
    );
    
-- Création de la table "roleusers" avec comme colonne "id_roleuser" et "name_roleuser"  
CREATE TABLE
    roleusers (
        id_roleuser SERIAL PRIMARY KEY, 
        name_roleuser VARCHAR(50) NOT NULL
    );

-- Modification de la table "users" afin de rajouter une colonne "id_roleuser" ("id_roleuser" est la clé primaire de la table "roleusers" et sera la clé étrangère de la table "users")
ALTER TABLE users
ADD COLUMN id_roleuser INT REFERENCES roleusers (id_roleuser);

-- Création de la table "favmovies" avec comme colonne "id_movie" et "id_user" ("id_movie" et "id_user" sont deux clés étrangères formant ensemble la clé primaire de la table "favmovies")
CREATE TABLE
    favmovies (
        id_movie INT REFERENCES movies (id_movie), 
        id_user INT REFERENCES users (id_user)
    );

-- Création de la table "actors" avec comme colonne "id_actor", "firstname_actor", "name_actor" et "dob_actor"
CREATE TABLE
    actors (
        id_actor SERIAL PRIMARY KEY,
        firstname_actor VARCHAR(50) NOT NULL,
        name_actor VARCHAR(50) NOT NULL,
        dob_actor DATE
    );
    
-- Création de la table "roleactors" avec comme colonne "id_roleactor" et "nameof_roleactor" 
CREATE TABLE
    roleactors (
        id_roleactor SERIAL PRIMARY KEY,
        nameof_roleactor VARCHAR(50) NOT NULL
    );

-- Création de la table "playing" avec comme colonne "id_movie", "id_actor" et "id_roleactor" ()"id_movie", "id_actor" et "id_roleactor" sont trois clés étrangères formant ensemble la clé primaire de la table "playing")
CREATE TABLE
    playing (
        id_movie INT REFERENCES movies (id_movie), 
        id_actor INT REFERENCES actors (id_actor),
        id_roleactor INT REFERENCES roleactors (id_roleactor)
    );






-- Insertion de données dans la table "directors" dans les colonnes "name_director" et "firstname_director"
INSERT INTO directors (name_director, firstname_director)
VALUES
	('Lucas', 'George'), 
    ('Rowling','JK'),
    ('Abrams', 'J.J.');

-- Insertion de données dans la table "movies" dans les colonnes "title_movie", "time_movie", "date_movie" et "id_director"
INSERT INTO movies (title_movie, time_movie, date_movie, id_director)
VALUES
    ('Star Wars: Episode IV - A New Hope', '2:01:00', '1977-05-25', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: Episode V - The Empire Strikes Back', '2:04:00', '1980-05-21', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: Episode VI - Return of the Jedi', '2:11:00', '1983-05-25', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: Episode I - The Phantom Menace', '2:16:00', '1999-05-19', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: Episode II - Attack of the Clones', '2:22:00', '2002-05-16', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: Episode III - Revenge of the Sith', '2:20:00', '2005-05-19', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: The Last Jedi', '2:32:00', '2017-12-15', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Star Wars: The Rise of Skywalker', '2:22:00', '2019-12-20', (SELECT id_director FROM directors
  WHERE firstname_director = 'George'
  AND name_director = 'Lucas') ),
    ('Harry Potter à l''école des sorciers', '2:32:00', '2001-11-16', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et la Chambre des secrets', '2:41:00', '2002-11-15', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et le Prisonnier d''Azkaban', '2:22:00', '2004-06-04', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et la Coupe de feu', '2:37:00', '2005-11-18', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et l''Ordre du Phénix', '2:18:00', '2007-07-11', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et le Prince de sang-mêlé', '2:33:00', '2009-07-15', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et les Reliques de la Mort - Partie 1', '2:26:00', '2010-11-19', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') ),
    ('Harry Potter et les Reliques de la Mort - Partie 2', '2:10:00', '2011-07-15', (SELECT id_director FROM directors
  WHERE firstname_director = 'JK'
  AND name_director = 'Rowling') );

-- Insertion de données dans la table "roleusers" dans la colonne "name_roleuser"
INSERT INTO roleusers (name_roleuser)
VALUES
    ('admin'),
    ('user'),
    ('premium');
    
-- Insertion de données dans la table "users" dans les colonnes "firstname_user", "name_user", "dob_user", "email_user" et "id_roleuser"
INSERT INTO users (firstname_user, name_user, dob_user, email_user, pwd_user, id_roleuser)
VALUES
    ('Yoan', 'Bor', '2002-10-26','yoanbor@icloud.com', 'Yoan', (SELECT id_roleuser FROM roleusers
  WHERE name_roleuser = 'admin')),
    ('Saif', 'Ali', '1996-09-01','saif@icloud.com', 'Saif', (SELECT id_roleuser FROM roleusers
  WHERE name_roleuser = 'premium')),
    ('Cecile', 'Ledino', '1001-01-26','cecile@icloud.com', 'Cecile', (SELECT id_roleuser FROM roleusers
  WHERE name_roleuser = 'user'));

-- Insertion de données dans la table "favmovies" dans les colonnes "id_movie" et "id_user"
INSERT INTO favmovies (id_movie, id_user)
VALUES 
    ( (SELECT id_movie FROM movies
  WHERE title_movie = 'Star Wars: Episode IV - A New Hope'), (SELECT id_user FROM users
  WHERE name_user = 'Bor' AND firstname_user = 'Yoan') );

-- Insertion de données dans la table "actors" dans les colonnes "firstname_actor", "name_actor" et "dob_actor"
INSERT INTO actors (firstname_actor, name_actor, dob_actor)
VALUES
    ('Daniel', 'Radcliffe', '1989-07-23'),  -- Harry
    ('Emma', 'Watson', '1990-04-15'),       -- Hermione
    ('Rupert', 'Grint', '1988-08-24'),      -- Ron
    ('Mark', 'Hamill', '1951-09-25'),  -- Luke Skywalker
    ('Harrison', 'Ford', '1942-07-13'), -- Han Solo
    ('Carrie', 'Fisher', '1956-10-21'); -- Leia Organa

-- Insertion de données dans la table "roleactors" dans la colonne "nameof_roleactor"
INSERT INTO roleactors (nameof_roleactor)
VALUES
    ('Policier'),
    ('Détective'),
    ('Infirmier'),
    ('Tueur'),
    ('Héros'),
    ('Vilain'),
    ('Scientifique'),
    ('Enseignant'),
    ('Aventurier'),
    ('Comédien');

-- Insertion de données dans la table "playing" dans les colonnes "id_movie", "id_actor" et "id_roleactor"
INSERT INTO playing (id_movie, id_actor, id_roleactor)
VALUES 
    ( (SELECT id_movie FROM movies
  WHERE title_movie = 'Star Wars: Episode IV - A New Hope'), (SELECT id_actor FROM actors
  WHERE firstname_actor = 'Mark' AND name_actor = 'Hamill'), (SELECT id_roleactor FROM roleactors
  WHERE nameof_roleactor = 'Héros') );

INSERT INTO playing (id_movie, id_actor, id_roleactor)
VALUES 
    ( (SELECT id_movie FROM movies
  WHERE title_movie = 'Star Wars: Episode V - The Empire Strikes Back'), (SELECT id_actor FROM actors
  WHERE firstname_actor = 'Harrison' AND name_actor = 'Ford'), (SELECT id_roleactor FROM roleactors
  WHERE nameof_roleactor = 'Aventurier') );
  
  INSERT INTO playing (id_movie, id_actor, id_roleactor)
VALUES 
    ( (SELECT id_movie FROM movies
  WHERE title_movie = 'Star Wars: Episode VI - Return of the Jedi'), (SELECT id_actor FROM actors
  WHERE firstname_actor = 'Mark' AND name_actor = 'Hamill'), (SELECT id_roleactor FROM roleactors
  WHERE nameof_roleactor = 'Héros') );


