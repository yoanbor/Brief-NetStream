# Brief-NetStream

Bienvenu dans mon brief NetStream !!

## Voici mon lien vers mon document Notion :

Sur le web :
https://chambray-armchair-216.notion.site/Briefs-NetStream-6de89c48080b43f6aa25937f1c5324b7

## Pour commencer :

Commencer par cloner le repo git,
Créer ensuite un terminal au clone et lancer à l'aide de la commande : "docker compose up"
Vous pouvez désormais ouvrir votre naviguateur et aller sur http://localhost:5050/ afin de lancer pgadmin.

Pour se connecter, le mail est "admin@email.com" et le mot de passe est "adminpass".
Une fois connecté, cliquez sur "créer un nouveau serveur"
Donnez lui un nom puis aller dans l'onglet "connexion" pour mettre en nom "db", en utilisateur "dbuser" et en mot de passe "dbpass" puis cliquez sur "save".
Vous pouvez maintenat ouvrir le serveur que vous avez nommé où se trouvera la base de donnée nommée "NetStream" !

En allant dans "Schémas" puis "public" vous trouverez les "tables" et en ouvrant chaque tables, vous y trouverez leurs colonnes.
Vous pouvez aussi faire clique droit sur la base de donnée "NetStream" puis cliquer sur CREATE SCRIPT afin de tester la base de données avec des commandes SQL.

## Quelques requêtes SQL :

Pour sélectionner chaque tables :

```sql
SELECT * FROM movies;
SELECT * FROM directors;
SELECT * FROM actors;
SELECT * FROM roleactors;
SELECT * FROM playing;
SELECT * FROM users;
SELECT * FROM roleusers;
SELECT * FROM favmovies;
```

Pour modifier un film :

```sql
UPDATE movies
SET title_movie = 'Star Treck'
WHERE id = 1;
```

Pour ajouter un film :

```sql
INSERT INTO movies (title_movie, time_movie, date_movie, id_director)
VALUES (
    'Star Wars: Episode VII - The Force Awakens',
    '2:18:00',
    '2015-12-18',
    (SELECT id_director FROM directors
     WHERE firstname_director = 'J.J.' AND name_director = 'Abrams')
);
```

Pour ajouter un acteur/actrice :

```sql
INSERT INTO actors (firstname_actor, name_actor, dob_actor)
VALUES ('Ewan', 'McGregor', '1971/03/31');
```

Afficher les 3 derniers acteurs/actrices ajouté(e)s:

```sql
SELECT * FROM actors
ORDER BY id_actor DESC
LIMIT 3;
```

Pour supprimer un acteur/actrice :

```sql
DELETE FROM actors
WHERE id_actor = 1;
```

Pour afficher les titres et dates de sortie des films du plus récent au plus ancien :

```sql
SELECT title_movie, date_movie FROM movies
ORDER BY date_movie DESC;
```

Pour afficher les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique :

```sql
SELECT name_actor, firstname_actor, dob_actor FROM actors
WHERE dob_actor <= '1993/12/21'
ORDER BY name_actor;
```
