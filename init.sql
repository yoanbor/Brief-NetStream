-- Création de la table "movies" avec comme colonne "id_movie", "title_movie", "time_movie" et "date_movie"
CREATE TABLE IF NOT EXISTS 
    movies (
        id_movie SERIAL PRIMARY KEY,
        title_movie VARCHAR(250) NOT NULL,
        time_movie TIME NOT NULL,
        date_movie DATE NOT NULL,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_movies() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_movies$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_movies$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

-- Création du trigger (en appelant la fonction 'set_creation_date_movies()')
CREATE TRIGGER set_creation_date_movies_trigger
BEFORE INSERT ON movies -- avant l'insertion dans la table movies
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_movies(); -- exécute la fonction pour chaque nouvelle ligne insérée    

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_movies()
RETURNS TRIGGER AS $update_date_movies$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_movies$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_movies()')
CREATE TRIGGER set_modification_date_movies_trigger
BEFORE UPDATE ON movies -- avant l'insertion dans la table movies
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_movies(); -- exécute la fonction pour chaque nouvelle ligne insérée

----------------------------------------------------------------------------------------------------------- 

-- Création de la table "directors" avec comme colonne "id_director", "firstname_director" et "name_director"
CREATE TABLE IF NOT EXISTS 
    directors (
        id_director SERIAL PRIMARY KEY,
        firstname_director VARCHAR(50) NOT NULL,
        name_director VARCHAR(50) NOT NULL,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_directors() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_directors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_directors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_directors()')
CREATE TRIGGER set_creation_date_directors_trigger
BEFORE INSERT ON directors -- avant l'insertion dans la table directors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_directors(); -- exécute la fonction pour chaque nouvelle ligne insérée    

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_directors()
RETURNS TRIGGER AS $update_date_directors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_directors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_directors()')
CREATE TRIGGER set_modification_date_directors_trigger
BEFORE UPDATE ON directors -- avant l'insertion dans la table directors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_directors(); -- exécute la fonction pour chaque nouvelle ligne insérée
----------------------------------------------------------------------------------------------------------- 

-- Modification de la table "movies" afin de rajouter une colonne "id_director" ("id_director" est la clé primaire de la table "directors" et sera la clé étrangère de la table "movies")
ALTER TABLE movies
ADD COLUMN id_director INT REFERENCES directors (id_director);

----------------------------------------------------------------------------------------------------------- 

-- Création de la table "users" avec comme colonne "id_user", "firstname_user", "name_user", "dob_user", "email_user" et "pwd_user"
CREATE TABLE IF NOT EXISTS 
    users (
        id_user SERIAL PRIMARY KEY,
        firstname_user VARCHAR(50) NOT NULL,
        name_user VARCHAR(50) NOT NULL,
        dob_user DATE,
        email_user VARCHAR(50) NOT NULL,
        pwd_user VARCHAR(50) NOT NULL,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_users() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_users$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_users$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_users()')
CREATE TRIGGER set_creation_date_users_trigger
BEFORE INSERT ON users -- avant l'insertion dans la table users
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_users(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_users()
RETURNS TRIGGER AS $update_date_users$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_users$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_users()')
CREATE TRIGGER set_modification_date_users_trigger
BEFORE UPDATE ON users -- avant l'insertion dans la table users
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_users(); -- exécute la fonction pour chaque nouvelle ligne insérée

--Création fonction (trigger) => on RECUPERE des données avant et après modification
CREATE OR REPLACE FUNCTION archive_user_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_archive (
        user_id,
        old_firstname, old_name, old_dob, old_email, old_pwd,
        new_firstname, new_name, new_dob, new_email, new_pwd
    )
    VALUES (
        OLD.id_user,
        OLD.firstname_user, OLD.name_user, OLD.dob_user, OLD.email_user, OLD.pwd_user,
        NEW.firstname_user, NEW.name_user, NEW.dob_user, NEW.email_user, NEW.pwd_user
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_changes_trigger
AFTER UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION archive_user_changes();

----------------------------------------------------------------------------------------------------------- 

-- Création de la table "roleusers" avec comme colonne "id_roleuser" et "name_roleuser"  
CREATE TABLE IF NOT EXISTS 
    roleusers (
        id_roleuser SERIAL PRIMARY KEY, 
        name_roleuser VARCHAR(50) NOT NULL,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_roleusers() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_roleusers$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_roleusers$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_roleusers()')
CREATE TRIGGER set_creation_date_roleusers_trigger
BEFORE INSERT ON roleusers -- avant l'insertion dans la table roleusers
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_roleusers(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_roleusers()
RETURNS TRIGGER AS $update_date_roleusers$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_roleusers$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_roleusers()')
CREATE TRIGGER set_modification_date_roleusers_trigger
BEFORE UPDATE ON roleusers -- avant l'insertion dans la table roleusers
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_roleusers(); -- exécute la fonction pour chaque nouvelle ligne insérée

----------------------------------------------------------------------------------------------------------- 

-- Modification de la table "users" afin de rajouter une colonne "id_roleuser" ("id_roleuser" est la clé primaire de la table "roleusers" et sera la clé étrangère de la table "users")
ALTER TABLE users
ADD COLUMN id_roleuser INT REFERENCES roleusers (id_roleuser);

----------------------------------------------------------------------------------------------------------- 
-- Création de la table "user_archive" qui vient récupérer tous les changements de la table "users" 
CREATE TABLE IF NOT EXISTS user_archive (
    archive_id SERIAL PRIMARY KEY,
    user_id INT,
    old_firstname VARCHAR(50),
    old_name VARCHAR(50),
    old_dob DATE,
    old_email VARCHAR(50),
    old_pwd VARCHAR(50),
    new_firstname VARCHAR(50),
    new_name VARCHAR(50),
    new_dob DATE,
    new_email VARCHAR(50),
    new_pwd VARCHAR(50),
    modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-----------------------------------------------------------------------------------------------------------

-- Création de la table "favmovies" avec comme colonne "id_movie" et "id_user" ("id_movie" et "id_user" sont deux clés étrangères formant ensemble la clé primaire de la table "favmovies")
CREATE TABLE IF NOT EXISTS 
    favmovies (
        id_movie INT REFERENCES movies (id_movie), 
        id_user INT REFERENCES users (id_user),
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_favmovies() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_favmovies$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_favmovies$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_favmovies()')
CREATE TRIGGER set_creation_date_favmovies_trigger
BEFORE INSERT ON favmovies -- avant l'insertion dans la table favmovies
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_favmovies(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_favmovies()
RETURNS TRIGGER AS $update_date_favmovies$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_favmovies$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_favmovies()')
CREATE TRIGGER set_modification_date_favmovies_trigger
BEFORE UPDATE ON favmovies -- avant l'insertion dans la table favmovies
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_favmovies(); -- exécute la fonction pour chaque nouvelle ligne insérée
----------------------------------------------------------------------------------------------------------- 

-- Création de la table "actors" avec comme colonne "id_actor", "firstname_actor", "name_actor" et "dob_actor"
CREATE TABLE IF NOT EXISTS 
    actors (
        id_actor SERIAL PRIMARY KEY,
        firstname_actor VARCHAR(50) NOT NULL,
        name_actor VARCHAR(50) NOT NULL,
        dob_actor DATE,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_actors() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_actors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_actors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_actors()')
CREATE TRIGGER set_creation_date_actors_trigger
BEFORE INSERT ON actors -- avant l'insertion dans la table actors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_actors(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_actors()
RETURNS TRIGGER AS $update_date_actors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_actors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_actors()')
CREATE TRIGGER set_modification_date_actors_trigger
BEFORE UPDATE ON actors -- avant l'insertion dans la table actors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_actors(); -- exécute la fonction pour chaque nouvelle ligne insérée

-----------------------------------------------------------------------------------------------------------    

-- Création de la table "roleactors" avec comme colonne "id_roleactor" et "nameof_roleactor" 
CREATE TABLE IF NOT EXISTS 
    roleactors (
        id_roleactor SERIAL PRIMARY KEY,
        nameof_roleactor VARCHAR(50) NOT NULL,
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_roleactors() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_roleactors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_roleactors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_roleactors()')
CREATE TRIGGER set_creation_date_roleactors_trigger
BEFORE INSERT ON roleactors -- avant l'insertion dans la table roleactors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_roleactors(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_roleactors()
RETURNS TRIGGER AS $update_date_roleactors$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_roleactors$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_roleactors()')
CREATE TRIGGER set_modification_date_roleactors_trigger
BEFORE UPDATE ON roleactors -- avant l'insertion dans la table roleactors
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_roleactors(); -- exécute la fonction pour chaque nouvelle ligne insérée

----------------------------------------------------------------------------------------------------------- 

-- Création de la table "playing" avec comme colonne "id_movie", "id_actor" et "id_roleactor" ()"id_movie", "id_actor" et "id_roleactor" sont trois clés étrangères formant ensemble la clé primaire de la table "playing")
CREATE TABLE IF NOT EXISTS 
    playing (
        id_movie INT REFERENCES movies (id_movie), 
        id_actor INT REFERENCES actors (id_actor),
        id_roleactor INT REFERENCES roleactors (id_roleactor),
        creation_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      	modification_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Création fonction (trigger) => si ON AJOUTE des données
CREATE OR REPLACE FUNCTION set_creation_date_playing() -- déclare ma fonction
RETURNS TRIGGER AS $create_date_playing$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.creation_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne creation_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$create_date_playing$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_creation_date_playing()')
CREATE trigger set_creation_date_playing_trigger
BEFORE INSERT ON playing -- avant l'insertion dans la table playing
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_creation_date_playing(); -- exécute la fonction pour chaque nouvelle ligne insérée

-- Création fonction (trigger) => si ON MODIFIE des données
CREATE OR REPLACE FUNCTION set_modification_date_playing()
RETURNS TRIGGER AS $update_date_playing$ --  retourne la variable trigger
BEGIN -- démarre la fonction
	NEW.modification_dt := CURRENT_TIMESTAMP; -- attribut de la date et l'heure actuelles à la colonne modification_dt
	RETURN NEW; -- retourne la nouvelle ligne modifiée
END;
$update_date_playing$ LANGUAGE plpgsql; -- variable trigger + spécifie le langage

--Création du trigger (en appelant la fonction 'set_modification_date_playing()')
CREATE TRIGGER set_modification_date_playing_trigger
BEFORE UPDATE ON playing -- avant l'insertion dans la table playing
FOR EACH ROW -- pour chaque ligne
EXECUTE FUNCTION set_modification_date_playing(); -- exécute la fonction pour chaque nouvelle ligne insérée

----------------------------------------------------------------------------------------------------------- 

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