DROP DATABASE IF EXISTS cineforum;

CREATE DATABASE cineforum;

DROP USER IF EXISTS 'cineadmin'@'localhost';
CREATE USER 'cineadmin'@'localhost' IDENTIFIED BY 'Cine.123';
GRANT ALL ON cineforum.* TO 'cineadmin'@'localhost';

USE cineforum;


-- Creazione tabelle
DROP TABLE IF EXISTS utente;
CREATE TABLE utente(
	Username CHAR(20) NOT NULL,
	Email CHAR(50) NOT NULL,
	Password CHAR(255) NOT NULL,
	Ruolo ENUM('registered', 'admin') NOT NULL DEFAULT 'registered',
	PRIMARY KEY(Username),
	UNIQUE(Email)
);

DROP TABLE IF EXISTS film;
CREATE TABLE film(
	CodiceFilm INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Titolo VARCHAR(80) NOT NULL,
	Genere VARCHAR(20) NOT NULL,
	DataUscita VARCHAR(15),
	Classificazione VARCHAR(10),
	Studio VARCHAR(70),
	Descrizione VARCHAR(255),
	Durata SMALLINT UNSIGNED,
	Immagine mediumblob DEFAULT NULL,
	PRIMARY KEY(CodiceFilm)
);

DROP TABLE IF EXISTS commento_film;
CREATE TABLE commento_film(
	Id_commento INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Commento VARCHAR(255) NOT NULL,
	Orario DATETIME NOT NULL,
	Username CHAR(20) NOT NULL,
	CodiceFilm INT UNSIGNED NOT NULL,
	PRIMARY KEY(Id_commento),
	FOREIGN KEY (Username) REFERENCES utente(Username)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(CodiceFilm) REFERENCES film(CodiceFilm)
		ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS richiesta_film;
CREATE TABLE richiesta_film(
	Id_richiesta INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Commento VARCHAR(255),
	Esito ENUM('in attesa', 'accettata', 'rifiutata') DEFAULT 'in attesa' NOT NULL,
	Username CHAR(20) NOT NULL,
	Titolo VARCHAR(30) NOT NULL,
	PRIMARY KEY(Id_richiesta),
	FOREIGN KEY (Username) REFERENCES utente(Username)
		ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS lista;
CREATE TABLE lista(
	CodiceFilm INT UNSIGNED NOT NULL,
	Username CHAR(20) NOT NULL,
	Voto TINYINT UNSIGNED NOT NULL,
	Categoria ENUM('visti', 'in programma') NOT NULL,
	PRIMARY KEY(CodiceFilm, Username),
	FOREIGN KEY (Username) REFERENCES utente(Username)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(CodiceFilm) REFERENCES film(CodiceFilm)
		ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS dati_estrazione_suggerimenti;
CREATE TABLE dati_estrazione_suggerimenti(
	Username CHAR(20) NOT NULL,
	Cluster TINYINT UNSIGNED NOT NULL,
	NumeroEstrazione TINYINT UNSIGNED NOT NULL,
	PRIMARY KEY(Username, Cluster),
	FOREIGN KEY (Username) REFERENCES utente(Username)
		ON DELETE CASCADE ON UPDATE CASCADE
);


insert into utente values ('vyncy98', 'vyncy98@gmail.com', '4fafee4c9557e135d879f7953ce1875602ab875308b20367f5f34e6898d46afc08e99d3fe71ff5abe9cd850f154af8691a4a05fc035a9498191fba10a8002ead', 'admin');
insert into utente values ('michele97', 'michele@gmail.com', '4fafee4c9557e135d879f7953ce1875602ab875308b20367f5f34e6898d46afc08e99d3fe71ff5abe9cd850f154af8691a4a05fc035a9498191fba10a8002ead', 'admin');
insert into utente values ('giuseppeandreozzi', 'giuseppe@gmail.com', '4fafee4c9557e135d879f7953ce1875602ab875308b20367f5f34e6898d46afc08e99d3fe71ff5abe9cd850f154af8691a4a05fc035a9498191fba10a8002ead', 'admin');

INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',136,'PG-13','4-Apr-14','Marvel Studios','Captain America: The Winter Soldier');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',130,'PG-13','11-Jul-14','20th Century Fox','Dawn of the Planet of the Apes');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',121,'PG-13','1-Aug-14','Marvel Studios','Guardians of the Galaxy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',169,'PG-13','7-Nov-14','Paramount Pictures / Warner Bros.','Interstellar');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',97,'PG','30-May-14','Walt Disney Pictures','Maleficent');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',142,'PG-13','2-May-14','Columbia Pictures','The Amazing Spider-Man 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',144,'PG-13','17-Dec-14','Warner Bros. / New Line Cinema / MGM','The Hobbit: The Battle of the Five Armies');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',123,'PG-13','21-Nov-14','Lionsgate Films','The Hunger Games: Mockingjay - Part 1');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',165,'PG-13','27-Jun-14','Paramount Pictures','Transformers: Age of Extinction');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',131,'PG-13','23-May-14','20th Century Fox','X-Men: Days of Future Past');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',98,'PG','3-Jul-13','Universal / Illumination','Despicable Me 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',130,'PG-13','24-May-13','Universal','Fast & Furious 6');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',102,'PG','27-Nov-13','Walt Disney Pictures','Frozen');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',91,'PG-13','4-Oct-13','Warner Bros.','Gravity');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',130,'PG-13','3-May-13','Marvel Studios','Iron Man 3');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',143,'PG-13','14-Jun-13','Warner Bros. / Legendary','Man of Steel');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',104,'G','21-Jun-13','Walt Disney Pictures / Pixar','Monsters University');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',161,'PG-13','13-Dec-13','Warner Bros. / New Line / MGM','The Hobbit: The Desolation of Smaug');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',146,'PG-13','22-Nov-13','Lionsgate','The Hunger Games: Catching Fire');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',112,'PG-13','8-Nov-13','Marvel Studios','Thor: The Dark World');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',88,'PG','13-Jul-12','Fox / Blue Sky','Ice Age: Continental Drift');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',93,'PG','8-Jun-12','Paramount / DreamWorks','Madagascar 3: Europe''s Most Wanted');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',106,'PG-13','25-May-12','Columbia','Men in Black 3');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',143,'PG-13','9-Nov-12','MGM / Columbia','Skyfall');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',136,'PG-13','3-Jul-12','Columbia','The Amazing Spider-Man');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',143,'PG-13','4-May-12','Marvel Studios','The Avengers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',165,'PG-13','20-Jul-12','Warner Bros. / Legendary','The Dark Knight Rises');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',169,'PG-13','14-Dec-12','Warner Bros. / MGM / New Line','The Hobbit: An Unexpected Journey');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',142,'PG-13','23-Mar-12','Lionsgate','The Hunger Games');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',115,'PG-13','16-Nov-12','Lionsgate / Summit','The Twilight Saga: Breaking Dawn - Part 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',106,'G','24-Jun-11','Walt Disney Pictures / Pixar','Cars 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',131,'PG-13','29-Apr-11','Universal','Fast Five');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',130,'PG-13','15-Jul-11','Warner Bros.','Harry Potter and the Deathly Hallows - Part 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',91,'PG','26-May-11','Paramount / DreamWorks','Kung Fu Panda 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',133,'PG-13','21-Dec-11','Paramount','Mission: Impossible - Ghost Protocol');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',136,'PG-13','20-May-11','Walt Disney Pictures','Pirates of the Caribbean: On Stranger Tides');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',102,'R','26-May-11','Warner Bros.','The Hangover Part II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',103,'PG','29-Jul-11','Columbia / Sony Pictures','The Smurfs');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',117,'PG-13','18-Nov-11','Summit','The Twilight Saga: Breaking Dawn - Part 1');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',154,'PG-13','29-Jun-11','Paramount','Transformers: Dark of the Moon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',108,'PG','5-Mar-10','Walt Disney Pictures','Alice in Wonderland');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',95,'PG','9-Jul-10','Universal / Illumination','Despicable Me');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',146,'PG-13','19-Nov-10','Warner Bros.','Harry Potter and the Deathly Hallows - Part 1');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',98,'PG','26-Mar-10','Paramount / DreamWorks','How to Train Your Dragon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',148,'PG-13','16-Jul-10','Warner Bros. / Legendary','Inception');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',124,'PG-13','7-May-10','Paramount / Marvel','Iron Man 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',93,'PG','21-May-10','Paramount / DreamWorks','Shrek Forever After');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',100,'PG','24-Nov-10','Disney','Tangled');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',124,'PG-13','30-Jun-10','Summit Entertainment','The Twilight Saga: Eclipse');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',103,'G','18-Jun-10','Walt Disney Pictures / Pixar','Toy Story 3');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',158,'PG-13','13-Nov-09','Columbia','2012');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',138,'PG-13','12-Dec-80','Columbia / Imagine','Angels & Demons');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',162,'PG-13','18-Dec-09','Fox','Avatar');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',153,'PG','15-Jul-09','Warner Bros.','Harry Potter and the Half-Blood Prince');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',94,'PG','1-Jul-09','Fox / Blue Sky','Ice Age: Dawn of the Dinosaurs');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',128,'PG-13','25-Dec-09','Warner Bros.','Sherlock Holmes');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',100,'R','5-Jun-09','Warner Bros. / Legendary','The Hangover');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',130,'PG-13','20-Nov-09','Summit','The Twilight Saga: New Moon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',150,'PG-13','24-Jun-09','Paramount / DreamWorks','Transformers: Revenge of the Fallen');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',96,'PG','29-May-09','Disney / Pixar','Up');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',92,'PG-13','2-Jul-08','Columbia','Hancock');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',122,'PG-13','22-May-08','Paramount / Lucasfilm','Indiana Jones and the Kingdom of the Crystal Skull');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',126,'PG-13','2-May-08','Paramount / Marvel Studios','Iron Man');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',92,'PG','6-Jun-08','Paramount / DreamWorks','Kung Fu Panda');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',89,'PG','7-Nov-08','Paramount / DreamWorks','Madagascar: Escape 2 Africa');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',108,'PG-13','18-Jul-08','Universal','Mamma Mia!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',106,'PG-13','14-Nov-08','MGM / Columbia','Quantum of Solace');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',150,'PG','16-May-08','Disney / Walden Media','The Chronicles of Narnia: Prince Caspian');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',152,'PG-13','18-Jul-08','Warner Bros. / Legendary','The Dark Knight');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',98,'G','27-Jun-08','Disney / Pixar','WALL-E');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',117,'R','9-Mar-07','Warner Bros. / Legendary','300');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',138,'PG-13','11-Jul-07','Warner Bros.','Harry Potter and the Order of the Phoenix');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',101,'PG-13','14-Dec-07','Warner Bros.','I Am Legend');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',124,'PG','21-Dec-07','Disney','National Treasure: Book of Secrets');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',169,'PG-13','25-May-07','Disney','Pirates of the Caribbean: At World''s End');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',111,'G','29-Jun-07','Disney / Pixar','Ratatouille');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',93,'PG','18-May-07','DreamWorks / Paramount','Shrek the Third');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',139,'PG-13','4-May-07','Columbia','Spider-Man 3');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',87,'PG-13','27-Jul-07','Fox','The Simpsons Movie');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',144,'PG-13','3-Jul-07','DreamWorks / Paramount','Transformers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',117,'G','9-Jun-06','Disney / Pixar','Cars');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',144,'PG-13','17-Nov-06','MGM / Columbia','Casino Royale');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',108,'PG','17-Nov-06','Warner Bros.','Happy Feet');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',91,'PG','31-Mar-06','Fox / Blue Sky','Ice Age: The Meltdown');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',126,'PG-13','5-May-06','Paramount','Mission: Impossible III');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',108,'PG','22-Dec-06','Fox','Night at the Museum');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',151,'PG-13','7-Jul-06','Disney','Pirates of the Caribbean: Dead Man''s Chest');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',154,'PG-13','28-Jun-06','Warner Bros. / Village Roadshow','Superman Returns');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',149,'PG-13','19-May-06','Columbia','The Da Vinci Code');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',104,'PG-13','26-May-06','Fox','X-Men: The Last Stand');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',140,'PG-13','15-Jun-05','Warner Bros / Legendary','Batman Begins');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',115,'PG','15-Jul-05','Warner Bros','Charlie and the Chocolate Factory');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',157,'PG-13','18-Nov-05','Warner Bros.','Harry Potter and the Goblet of Fire');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',118,'PG-13','11-Feb-05','Columbia','Hitch');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',187,'PG-13','14-Dec-05','Universal','King Kong');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',86,'PG','27-May-05','DreamWorks','Madagascar');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',120,'PG-13','10-Jun-05','20th Century Fox','Mr. & Mrs. Smith');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',140,'PG-13','19-May-05','20th Century Fox / Lucasfilm','Star Wars Episode III: Revenge of the Sith');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',143,'PG','9-Dec-05','Disney','The Chronicles of Narnia: The Lion, the Witch and the Wardrobe');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',116,'PG-13','29-Jun-05','Paramount / DreamWorks','War of the Worlds');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',142,'PG','4-Jun-04','Warner Bros.','Harry Potter and the Prisoner of Azkaban');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',115,'PG-13','22-Dec-04','Universal / DreamWorks','Meet the Fockers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',125,'PG-13','10-Dec-04','Warner Bros.','Ocean''s Twelve');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',90,'PG','1-Oct-04','DreamWorks','Shark Tale');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',93,'PG','19-May-04','DreamWorks','Shrek 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',127,'PG-13','30-Jun-04','Columbia','Spider-Man 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',124,'PG-13','28-May-04','Fox','The Day After Tomorrow');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Animation',115,'PG','5-Nov-04','Disney / Pixar','The Incredibles');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',127,'R','25-Feb-04','Icon / Newmarket','The Passion of the Christ');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',163,'R','14-May-04','Warner Bros.','Troy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',147,'R','18-Jul-03','Columbia','Bad Boys II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',101,'PG-13','23-May-03','Universal','Bruce Almighty');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',100,'G','30-May-03','Disney / Pixar','Finding Nemo');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',143,'PG-13','9-Jul-03','Disney','Pirates of the Caribbean: The Curse of the Black Pearl');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',109,'R','2-Jul-03','Warner Bros. / Columbia','Terminator 3: Rise of the Machines');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('History',154,'R','5-Dec-03','Warner Bros.','The Last Samurai');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',201,'PG-13','17-Dec-03','New Line','The Lord of the Rings: The Return of the King');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',138,'R','15-May-03','Warner Bros.','The Matrix Reloaded');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',129,'R','5-Nov-03','Warner Bros.','The Matrix Revolutions');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',134,'PG-13','2-May-03','Fox','X2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',133,'PG-13','22-Nov-02','MGM','Die Another Day');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',161,'PG','15-Nov-02','Warner Bros.','Harry Potter and the Chamber of Secrets');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',81,'PG','15-Mar-02','20th Century Fox / Blue Sky','Ice Age');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',88,'PG-13','3-Jul-02','Columbia','Men in Black II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',145,'PG-13','21-Jun-02','DreamWorks / 20th Century Fox','Minority Report');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',95,'PG','2-Aug-02','IFC Films','My Big Fat Greek Wedding');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',106,'PG-13','2-Aug-02','Touchstone','Signs');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',121,'PG-13','3-May-02','Columbia / Marvel','Spider-Man');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',142,'PG','16-May-02','20th Century Fox / Lucasfilm','Star Wars Episode II: Attack of the Clones');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',179,'PG-13','18-Dec-02','New Line Cinema','The Lord of the Rings: The Two Towers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',131,'R','9-Feb-01','MGM / Universal','Hannibal');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',152,'PG','16-Nov-01','Warner Bros.','Harry Potter and the Sorcerer''s Stone');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',92,'PG-13','18-Jul-01','Universal','Jurassic Park III');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',92,'G','2-Nov-01','Disney / Pixar','Monsters, Inc.');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',116,'PG-13','7-Dec-01','Warner Bros','Ocean''s Eleven');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',183,'PG-13','25-May-01','Touchstone','Pearl Harbor');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',119,'PG-13','27-Jul-01','20th Century Fox','Planet of the Apes');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',90,'PG','18-May-01','DreamWorks','Shrek');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',178,'PG-13','19-Dec-01','New Line Cinema','The Lord of the Rings: The Fellowship of the Ring');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',130,'PG-13','4-May-01','Universal','The Mummy Returns');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',143,'PG-13','22-Dec-00','Fox','Cast Away');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',82,'PG','19-May-00','Disney','Dinosaur');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',155,'R','5-May-00','DreamWorks / Universal','Gladiator');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',104,'PG','17-Nov-00','Universal','How the Grinch Stole Christmas');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',108,'PG-13','6-Oct-00','Universal / DreamWorks','Meet the Parents');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',123,'PG-13','24-May-00','Paramount','Mission: Impossible II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',130,'PG-13','30-Jun-00','Warner Bros.','The Perfect Storm');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',130,'PG-13','21-Jul-00','DreamWorks / Fox','What Lies Beneath');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',127,'PG-13','15-Dec-00','Paramount','What Women Want');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',104,'PG-13','14-Jul-00','Fox','X-Men');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',122,'R','1-Oct-99','DreamWorks Pictures','American Beauty');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',95,'PG-13','11-Jun-99','New Line Cinema','Austin Powers: The Spy Who Shagged Me');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',124,'PG-13','28-May-99','Universal Pictures','Notting Hill');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',136,'PG','19-May-99','20th Century Fox / Lucasfilm','Star Wars Episode I: The Phantom Menace');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',88,'G','18-Jun-99','Walt Disney Pictures','Tarzan');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',136,'R','31-Mar-99','Warner Bros.','The Matrix');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',125,'PG-13','7-May-99','Universal Pictures','The Mummy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',107,'PG-13','6-Aug-99','Hollywood Pictures','The Sixth Sense');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',128,'PG-13','19-Nov-99','Metro-Goldwyn-Mayer','The World Is Not Enough');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',92,'G','24-Nov-99','Walt Disney Pictures / Pixar','Toy Story 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',95,'G','25-Nov-98','Walt Disney Pictures / Pixar','A Bug''s Life');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',151,'PG-13','1-Jul-98','Touchstone Pictures','Armageddon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',120,'PG-13','8-May-98','DreamWorks Pictures / Paramount Pictures','Deep Impact');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',85,'PG-13','26-Jun-98','20th Century Fox','Dr. Dolittle');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',139,'PG-13','20-May-98','TriStar Pictures','Godzilla');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',127,'R','10-Jul-98','Warner Bros.','Lethal Weapon 4');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',88,'G','19-Jun-98','Walt Disney Pictures','Mulan');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',169,'R','24-Jul-98','DreamWorks Pictures / Paramount Pictures','Saving Private Ryan');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',123,'R','8-Jan-99','Miramax Films / Universal Pictures','Shakespeare in Love');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',119,'R','15-Jul-98','20th Century Fox','There''s Something About Mary');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',124,'R','25-Jul-97','Columbia Pictures','Air Force One');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',139,'PG-13','25-Dec-97','TriStar Pictures','As Good as It Gets');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',86,'PG-13','21-Mar-97','Universal Pictures','Liar Liar');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',98,'PG-13','2-Jul-97','Columbia Pictures','Men in Black');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',105,'PG-13','20-Jun-97','TriStar Pictures','My Best Friend''s Wedding');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',126,'PG-13','9-May-97','Columbia Pictures','The Fifth Element');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Music',91,'R','19-Sep-97','Fox Searchlight Pictures','The Full Monty');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',129,'PG-13','23-May-97','Universal Pictures','The Lost World: Jurassic Park');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',194,'PG-13','19-Dec-97','Paramount Pictures / 20th Century Fox','Titanic');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',119,'PG-13','19-Dec-97','United Artists','Tomorrow Never Dies');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',103,'G','27-Nov-96','Walt Disney Pictures','101 Dalmatians');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',115,'R','21-Jun-96','Warner Bros.','Eraser');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',145,'PG-13','3-Jul-96','20th Century Fox','Independence Day');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',139,'R','13-Dec-96','TriStar Pictures','Jerry Maguire');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',110,'PG-13','22-May-96','Paramount Pictures','Mission: Impossible');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',121,'R','8-Nov-96','Touchstone Pictures / Imagine Entertainment','Ransom');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',91,'G','21-Jun-96','Walt Disney Pictures','The Hunchback of Notre Dame');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',95,'PG-13','28-Jun-96','Universal Pictures','The Nutty Professor');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',136,'R','7-Jun-96','Hollywood Pictures','The Rock');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',113,'PG-13','10-May-96','Warner Bros. / Universal Pictures','Twister');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('History',140,'PG','30-Jun-95','Universal Pictures / Imagine Entertainment','Apollo 13');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',121,'PG-13','16-Jun-95','Warner Bros. / PolyGram','Batman Forever');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',100,'PG','26-May-95','Universal Pictures','Casper');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',131,'R','19-May-95','20th Century Fox / Cinergi Pictures','Die Hard with a Vengeance');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',130,'PG-13','17-Nov-95','United Artists','GoldenEye');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',104,'PG','15-Dec-95','TriStar Pictures','Jumanji');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',81,'G','23-Jun-95','Walt Disney Pictures','Pocahontas');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',127,'R','22-Sep-95','New Line Cinema','Seven');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',81,'G','22-Nov-95','Walt Disney Pictures / Pixar','Toy Story');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',135,'PG-13','28-Jul-95','Universal Pictures','Waterworld');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',141,'PG-13','3-Aug-94','Paramount Pictures','Clear and Present Danger');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',107,'PG-13','16-Dec-94','New Line Cinema','Dumb and Dumber');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',142,'PG-13','6-Jul-94','Paramount Pictures','Forrest Gump');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',117,'R','15-Apr-94','Gramercy Pictures / PolyGram','Four Weddings and a Funeral');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',123,'R','11-Nov-94','Warner Bros. / Geffen Pictures','Interview with the Vampire: The Vampire Chronicles');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',116,'R','10-Jun-94','20th Century Fox','Speed');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',91,'PG','27-May-94','Universal Pictures / Amblin Entertainment','The Flintstones');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',89,'G','24-Jun-94','Walt Disney Pictures','The Lion King');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',101,'PG-13','29-Jul-94','New Line Cinema','The Mask');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',141,'R','15-Jul-94','20th Century Fox','True Lies');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',112,'R','28-May-93','TriStar Pictures / Carolco Pictures','Cliffhanger');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',117,'R','7-Apr-93','Paramount Pictures','Indecent Proposal');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',127,'PG-13','11-Jun-93','Universal Pictures / Amblin Entertainment','Jurassic Park');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',125,'PG-13','24-Nov-93','20th Century Fox','Mrs. Doubtfire');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',125,'PG-13','14-Jan-94','TriStar Pictures','Philadelphia');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('History',195,'R','4-Feb-94','Universal Pictures / Amblin Entertainment','Schindler''s List');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',105,'PG','25-Jun-93','TriStar Pictures','Sleepless in Seattle');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',154,'R','30-Jun-93','Paramount Pictures','The Firm');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',130,'PG-13','6-Aug-93','Warner Bros.','The Fugitive');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',141,'PG-13','17-Dec-93','Warner Bros.','The Pelican Brief');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',138,'R','11-Dec-92','Columbia Pictures / Castle Rock Entertainment','A Few Good Men');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',90,'G','25-Nov-92','Walt Disney Pictures','Aladdin');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',127,'R','20-Mar-92','TriStar Pictures / Carolco Pictures','Basic Instinct');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Action',126,'PG-13','19-Jun-92','Warner Bros. / PolyGram','Batman Returns');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',128,'R','13-Nov-92','Columbia Pictures','Bram Stoker''s Dracula');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',120,'PG','20-Nov-92','20th Century Fox','Home Alone 2: Lost in New York');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',118,'R','15-May-92','Warner Bros.','Lethal Weapon 3');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Music',100,'PG','29-May-92','Touchstone Pictures','Sister Act');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Music',129,'R','25-Nov-92','Warner Bros.','The Bodyguard');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Music',94,'PG-13','14-Feb-92','Paramount Pictures','Wayne''s World');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',84,'G','22-Nov-91','Walt Disney Pictures','Beauty and the Beast');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',128,'R','15-Nov-91','Universal Pictures','Cape Fear');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Western',113,'PG-13','7-Jun-91','Columbia Pictures / Castle Rock Entertainment / Nelson Entertainment','City Slickers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',142,'PG','11-Dec-91','TriStar Pictures / Amblin Entertainment','Hook');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',84,'PG-13','31-Jul-91','20th Century Fox','Hot Shots!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',189,'R','20-Dec-91','Warner Bros.','JFK');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',143,'PG-13','14-Jun-91','Warner Bros.','Robin Hood: Prince of Thieves');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',137,'R','3-Jul-91','TriStar Pictures / Carolco Pictures / Lightstorm Entertainment','Terminator 2: Judgment Day');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',99,'PG-13','22-Nov-91','Paramount Pictures / Orion Pictures','The Addams Family');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',118,'R','14-Feb-91','Orion Pictures','The Silence of the Lambs');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',118,'PG','25-May-90','Universal Pictures','Back to the Future Part III');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Western',181,'PG-13','21-Nov-90','Orion Pictures','Dances with Wolves');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',124,'R','4-Jul-90','20th Century Fox / Silver Pictures','Die Hard 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',127,'PG-13','13-Jul-90','Paramount Pictures','Ghost');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',103,'PG','16-Nov-90','20th Century Fox','Home Alone');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',111,'PG-13','21-Dec-90','Universal Pictures','Kindergarten Cop');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',127,'R','27-Jul-90','Warner Bros.','Presumed Innocent');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',119,'R','23-Mar-90','Touchstone Pictures','Pretty Woman');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',93,'PG','30-Mar-90','New Line Cinema','Teenage Mutant Ninja Turtles');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Action',113,'R','1-Jun-90','TriStar Pictures / Carolco Pictures','Total Recall');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',108,'PG','22-Nov-89','Universal Pictures','Back to the Future Part II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',126,'PG-13','23-Jun-89','Warner Bros. / PolyGram','Batman');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',145,'R','5-Jan-90','Universal Pictures','Born on the Fourth of July');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',128,'PG','9-Jun-89','Touchstone Pictures','Dead Poets Society');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',108,'PG','16-Jun-89','Columbia Pictures','Ghostbusters II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',93,'PG','23-Jun-89','Walt Disney Pictures','Honey, I Shrunk the Kids');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',127,'PG-13','24-May-89','Paramount Pictures / Lucasfilm','Indiana Jones and the Last Crusade');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',114,'R','7-Jul-89','Warner Bros.','Lethal Weapon 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',93,'PG-13','13-Oct-89','TriStar Pictures','Look Who''s Talking');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',83,'G','17-Nov-89','Walt Disney Pictures','The Little Mermaid');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',108,'PG','25-May-88','Paramount Pictures','"Crocodile" Dundee II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',92,'PG','30-Mar-88','Warner Bros. / Geffen Pictures','Beetlejuice');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',104,'PG','3-Jun-88','20th Century Fox / Gracie Films','Big');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',104,'R','29-Jul-88','Touchstone Pictures','Cocktail');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',116,'R','29-Jun-88','Paramount Pictures','Coming to America');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',131,'R','20-Jul-88','20th Century Fox / Silver Pictures','Die Hard');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',133,'R','16-Dec-88','United Artists','Rain Man');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',85,'PG-13','2-Dec-88','Paramount Pictures','The Naked Gun: From the Files of Police Squad!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',107,'PG','9-Dec-88','Universal Pictures','Twins');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',104,'PG','22-Jun-88','Touchstone Pictures / Amblin Entertainment','Who Framed Roger Rabbit');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',100,'R','20-May-87','Paramount','Beverly Hills Cop II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',119,'R','18-Sep-87','Paramount Pictures','Fatal Attraction');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',121,'R','15-Jan-88','Touchstone','Good Morning, Vietnam');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',110,'R','6-Mar-87','Warner Bros.','Lethal Weapon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',102,'PG','15-Jan-88','Metro-Goldwyn-Mayer','Moonstruck');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',117,'R','5-Aug-87','Touchstone','Stakeout');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',111,'PG-13','10-Apr-87','Universal Pictures','The Secret of My Success');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',119,'R','3-Jun-87','Paramount','The Untouchables');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',118,'R','12-Jun-87','Warner Bros.','The Witches of Eastwick');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',102,'PG','25-Nov-87','Touchstone Pictures','Three Men and a Baby');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',97,'PG-13','26-Sep-86','Paramount Pictures / 20th Century Fox','"Crocodile" Dundee');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',137,'R','18-Jul-86','20th Century Fox','Aliens');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',80,'G','21-Nov-86','Universal Studios','An American Tail');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',96,'PG-13','13-Jun-86','Orion Pictures','Back to School');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',120,'R','6-Feb-87','Orion Pictures','Platoon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',93,'R','27-Jun-86','Buena Vista Pictures Distribution','Ruthless People');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',119,'PG','26-Nov-86','Paramount Pictures','Star Trek IV: The Voyage Home');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',94,'PG-13','12-Dec-86','Paramount Pictures','The Golden Child');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',113,'PG','20-Jun-86','Columbia Pictures','The Karate Kid, Part II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',110,'PG','16-May-86','Paramount Pictures','Top Gun');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',116,'PG','3-Jul-85','Universal Pictures / Amblin Entertainment','Back to the Future');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',117,'PG-13','21-Jun-85','20th Century Fox','Cocoon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',161,'PG','20-Dec-85','Universal Pictures','Out Of Africa');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',96,'R','22-May-85','TriStar Pictures / Carolco','Rambo: First Blood Part II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',91,'PG','27-Nov-85','United Artists','Rocky IV');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',102,'PG','6-Dec-85','Warner Bros.','Spies Like Us');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',154,'PG-13','7-Feb-86','Warner Bros.','The Color Purple');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',114,'PG','7-Jun-85','Warner Bros.','The Goonies');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',106,'PG','11-Dec-85','20th Century Fox','The Jewel of the Nile');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',112,'R','8-Feb-85','Paramount Pictures','Witness');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',105,'R','5-Dec-84','Paramount Pictures','Beverly Hills Cop');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',107,'R','17-Feb-84','Paramount Pictures','Footloose');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',105,'PG','8-Jun-84','Columbia Pictures','Ghostbusters');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',106,'PG','8-Jun-84','Warner Bros.','Gremlins');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Action',118,'PG','23-May-84','Paramount Pictures / Lucasfilm','Indiana Jones and the Temple of Doom');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',96,'R','23-Mar-84','Warner Bros. / The Ladd Company','Police Academy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',106,'PG','30-Mar-84','20th Century Fox','Romancing the Stone');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',105,'PG','1-Jun-84','Paramount Pictures','Star Trek III: The Search for Spock');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',126,'PG','22-Jun-84','Columbia Pictures','The Karate Kid');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',107,'R','26-Oct-84','Orion Pictures','The Terminator');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',95,'R','15-Apr-83','Paramount Pictures / PolyGram','Flashdance');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',91,'PG','19-Aug-83','20th Century Fox','Mr. Mom');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',131,'PG','10-Jun-83','United Artists','Octopussy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',99,'R','5-Aug-83','Warner Bros.','Risky Business');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',134,'PG','25-May-83','Lucasfilm / 20th Century Fox','Star Wars Episode VI: Return of the Jedi');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',93,'PG','15-Jul-83','Paramount Pictures','Staying Alive');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',117,'R','9-Dec-83','Warner Bros.','Sudden Impact');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',132,'R','9-Dec-83','Paramount Pictures','Terms of Endearment');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',116,'R','8-Jun-83','Paramount Pictures','Trading Places');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',114,'PG','3-Jun-83','United Artists','WarGames');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',96,'R','8-Dec-82','Paramount Pictures','48 Hrs.');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',124,'R','13-Aug-82','Paramount Pictures / Lorimar','An Officer and a Gentleman');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',127,'PG','18-Jun-82','Columbia Pictures / Rastar','Annie');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',115,'PG','11-Jun-82','Universal Pictures','E.T. the Extra-Terrestrial');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',114,'PG','4-Jun-82','Metro-Goldwyn-Mayer','Poltergeist');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',94,'R','19-Mar-82','20th Century Fox','Porky''s');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',99,'PG','28-May-82','United Artists','Rocky III');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',113,'PG','4-Jun-82','Paramount Pictures','Star Trek II: The Wrath of Khan');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Musical',114,'R','23-Jul-82','Universal Pictures / RKO Pictures','The Best Little Whorehouse in Texas');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',116,'PG','17-Dec-82','Columbia Pictures','Tootsie');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',97,'PG','17-Jul-81','Orion Pictures / Warner Bros.','Arthur');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',119,'PG','9-Apr-82','Warner Bros. / Ladd','Chariots of Fire');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',127,'PG','26-Jun-81','United Artists','For Your Eyes Only');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',109,'PG','12-Feb-82','Universal Pictures / ITC','On Golden Pond');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',115,'PG','12-Jun-81','Paramount Pictures / Lucasfilm','Raiders of the Lost Ark');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',106,'R','26-Jun-81','Columbia Pictures','Stripes');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',127,'PG','19-Jun-81','Warner Bros.','Superman II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',95,'PG','19-Jun-81','20th Century Fox / Golden Harvest','The Cannonball Run');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',107,'PG','22-May-81','Universal Pictures','The Four Seasons');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',110,'PG','6-Nov-81','Embassy Pictures','Time Bandits');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',110,'PG','19-Dec-80','20th Century-Fox','9 to 5');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',88,'PG','2-Jul-80','Paramount Pictures','Airplane!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',116,'PG','17-Dec-80','Warner Bros. Pictures','Any Which Way You Can');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Music',124,'PG','7-Mar-80','Universal Studios','Coal Miner''s Daughter');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',109,'R','10-Oct-80','Warner Bros.','Private Benjamin');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',100,'PG','15-Aug-80','Universal Studios','Smokey and the Bandit II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Adventure',124,'PG','20-Jun-80','20th Century Fox','Star Wars Episode V: The Empire Strikes Back');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',111,'R','12-Dec-80','Columbia Pictures','Stir Crazy');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',104,'R','2-Jul-80','Columbia Pictures','The Blue Lagoon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',133,'R','20-Jun-80','Universal Studios','The Blues Brothers');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',122,'R','5-Oct-79','Warner Bros. Pictures','10');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',117,'R','22-Jun-79','20th Century Fox Film Corporation','Alien');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',153,'R','15-Aug-79','United Artists Pictures','Apocalypse Now');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',105,'PG-13','19-Dec-79','Columbia Pictures','Kramer vs. Kramer');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',126,'PG','29-Jun-79','United Artists Pictures','Moonraker');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',119,'PG','15-Jun-79','United Artists Pictures','Rocky II');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',132,'PG','7-Dec-79','Paramount Pictures','Star Trek: The Motion Picture');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',117,'R','27-Jul-79','American International Pictures','The Amityville Horror');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',94,'R','14-Dec-79','Universal Studios','The Jerk');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',95,'G','22-Jun-79','Associated Film Distribution','The Muppet Movie');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',127,'R','24-May-79','United Film Distribution Company','Dawn of the Dead');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',114,'PG','20-Dec-78','Warner Bros.','Every Which Way but Loose');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',110,'PG-13','16-Jun-78','Paramount Pictures','Grease');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',101,'PG','28-Jun-78','Paramount Pictures','Heaven Can Wait');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',99,'PG','28-Jul-78','Warner Bros.','Hooper');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',116,'PG','16-Jun-78','Universal Pictures','Jaws 2');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Comedy',109,'R','28-Jul-78','Universal Pictures','National Lampoon''s Animal House');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',99,'PG','19-Jul-78','United Artists','Revenge of the Pink Panther');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',143,'PG','15-Dec-78','Warner Bros.','Superman');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',182,'R','23-Feb-79','Universal Pictures','The Deer Hunter');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('War',175,'PG','15-Jun-77','United Artists','A Bridge Too Far');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',93,'PG','20-Apr-77','United Artists','Annie Hall');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sci-Fi',137,'PG','25-Dec-77','Columbia Pictures','Close Encounters of the Third Kind');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',98,'PG','7-Oct-77','Warner Bros.','Oh, God!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',118,'R','16-Dec-77','Paramount Pictures','Saturday Night Fever');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',96,'PG','27-May-77','Universal Pictures','Smokey and the Bandit');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Fantasy',121,'PG','25-May-77','Lucasfilm / 20th Century Fox','Star Wars');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',123,'PG','17-Jun-77','Columbia Pictures','The Deep');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',111,'PG','1-Feb-78','Metro-Goldwyn-Mayer / Warner Bros. / Rastar','The Goodbye Girl');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',125,'PG','3-Aug-77','United Artists','The Spy Who Loved Me');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',139,'R','17-Dec-76','Warner Bros. Pictures','A Star Is Born');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',138,'R','9-Apr-76','Warner Bros. Pictures','All the President''s Men');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Family',99,'G','11-Feb-77','Sunn Classic Pictures','In Search of Noah''s Ark');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Horror',134,'PG','17-Dec-76','Paramount Pictures','King Kong');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('History',132,'PG','18-Jun-76','Universal Studios / Cinema International Corporation','Midway');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Sport',119,'PG','3-Dec-76','United Artists Pictures','Rocky');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Crime',114,'PG','3-Dec-76','20th Century-Fox Film Corporation','Silver Streak');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',96,'R','22-Dec-76','Warner Bros. Pictures','The Enforcer');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',111,'R','25-Jun-76','20th Century Fox Film Corporation','The Omen');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('History',27,'G','19-Jun-81','National Air and Space Museum','To Fly!');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',88,'PG','29-Apr-75','Columbia Pictures','Aloha, Bobby and Rose');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',125,'R','21-Sep-75','Warner Bros.','Dog Day Afternoon');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Musical',136,'PG','15-Mar-75','Columbia Pictures','Funny Lady');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Romance',109,'R','13-Mar-75','Columbia Pictures','Shampoo');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Western',100,'G','1-Jul-75','Walt Disney Productions','The Apple Dumpling Gang');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Drama',103,'PG','20-Dec-75','Universal Pictures','The Other Side of the Mountain');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Mystery',113,'G','21-May-75','United Artists','The Return of the Pink Panther');
INSERT INTO film(Genere,Durata,Classificazione,DataUscita,Studio,Titolo) VALUES ('Thriller',106,'PG-13','2-Aug-02','Touchstone','Signs');
