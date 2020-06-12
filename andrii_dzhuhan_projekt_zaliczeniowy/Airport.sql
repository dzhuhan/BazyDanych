-- Ustawiamy format daty 'dd-mm-yyyy'
alter session set nls_date_format='dd-mm-yyyy';

-- Tworzymy sekwencje dla indeksow
-- Sekwencja dla tabeli pracownik
DROP SEQUENCE id_prac;
CREATE SEQUENCE id_prac
    INCREMENT BY 10
    START WITH 1000
    MINVALUE 1000
    MAXVALUE 3000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli rola
DROP SEQUENCE id_rola;
CREATE SEQUENCE id_rola
    INCREMENT BY 10
    START WITH 4000
    MINVALUE 4000
    MAXVALUE 4300
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli kontrola
DROP SEQUENCE id_kont;
CREATE SEQUENCE id_kont
    INCREMENT BY 10
    START WITH 5000
    MINVALUE 5000
    MAXVALUE 7000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli pasazer
DROP SEQUENCE id_pas;
CREATE SEQUENCE id_pas
    INCREMENT BY 1
    START WITH 101
    MINVALUE 101
    MAXVALUE 800000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli komentarz
DROP SEQUENCE id_kom;
CREATE SEQUENCE id_kom
    INCREMENT BY 3
    START WITH 3000
    MINVALUE 3000
    MAXVALUE 4000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli bagaz
DROP SEQUENCE id_bag;
CREATE SEQUENCE id_bag
    INCREMENT BY 1
    START WITH 501
    MINVALUE 501
    MAXVALUE 800000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli samolot
DROP SEQUENCE id_mod;
CREATE SEQUENCE id_mod
    INCREMENT BY 1
    START WITH 10
    MINVALUE 10
    MAXVALUE 35
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli linia_lotnicza
DROP SEQUENCE id_lin;
CREATE SEQUENCE id_lin
    INCREMENT BY 1
    START WITH 40
    MINVALUE 40
    MAXVALUE 51
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli rezerwacja
DROP SEQUENCE id_rez;
CREATE SEQUENCE id_rez
    INCREMENT BY 1
    START WITH 201
    MINVALUE 201
    MAXVALUE 800000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli media
DROP SEQUENCE id_media;
CREATE SEQUENCE id_media
    INCREMENT BY 1
    START WITH 8001
    MINVALUE 8001
    MAXVALUE 8500
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli jedzenie
DROP SEQUENCE id_jed;
CREATE SEQUENCE id_jed
    INCREMENT BY 1
    START WITH 8501
    MINVALUE 8501
    MAXVALUE 9000
    NOCYCLE
    CACHE 2;
    
-- Sekwencja dla tabeli lot
DROP SEQUENCE id_lot;
CREATE SEQUENCE id_lot
    INCREMENT BY 1
    START WITH 10001
    MINVALUE 10000
    MAXVALUE 11000
    NOCYCLE
    CACHE 2;
    
-- Dla wygodnosci, usuwamy wszystkie tabele. 
-- Tak mozna szybko aktualizowac baze danych.
-- CASCADE CONSTRAINTS pozwala usunac tabele, nawet jezeli sa do niej referencje
DROP TABLE rola cascade constraints;
DROP TABLE pracownik cascade constraints;
DROP TABLE pasazer cascade constraints;
DROP TABLE bagaz cascade constraints;
DROP TABLE komentarz cascade constraints;
DROP TABLE lot cascade constraints;
DROP TABLE rezerwacja cascade constraints;
DROP TABLE linia_lotnicza cascade constraints;
DROP TABLE samolot cascade constraints;
DROP TABLE kontrola cascade constraints;
DROP TABLE media cascade constraints;
DROP TABLE jedzenie cascade constraints;
DROP TABLE linia_jedzenie cascade constraints;
DROP TABLE linia_media cascade constraints;

-- Tworzymy tabele rola
CREATE TABLE rola (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 stanowisko VARCHAR(65) NOT NULL UNIQUE, -- Nazwa stanowiska pracy. Musi byc unikalna i nie moze byc NULL
 PRIMARY KEY (id)); -- tworzymy klucz glowny
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO rola
	VALUES (id_rola.nextval, 'dyrektor lotniska');
INSERT INTO rola
	VALUES (id_rola.nextval, 'manager ds. logistyki');
INSERT INTO rola
	VALUES (id_rola.nextval, 'manager ds. obslugi pasazerow');
INSERT INTO rola
	VALUES (id_rola.nextval, 'manager ds. bezpieczenstwa');
INSERT INTO rola
    VALUES (id_rola.nextval, 'manager ds. kontroli technicznej');
INSERT INTO rola
	VALUES (id_rola.nextval, 'kontroler ruchu lotniczego');
INSERT INTO rola
	VALUES (id_rola.nextval, 'logistyk');
INSERT INTO rola
	VALUES (id_rola.nextval, 'pracownik sortujacy');
INSERT INTO rola
	VALUES (id_rola.nextval, 'pracownik wsparcia kontroli bezpieczenstwa');
INSERT INTO rola
	VALUES (id_rola.nextval, 'pracownik magazynu cargo');
INSERT INTO rola
	VALUES (id_rola.nextval, 'pracownik do sprzatania i wyposazenia pokladow samolotu');
INSERT INTO rola
	VALUES (id_rola.nextval, 'mechanik samolotowy');
INSERT INTO rola
	VALUES (id_rola.nextval, 'mechanik silnikow lotniczych');
INSERT INTO rola
	VALUES (id_rola.nextval, 'pracownik ds. obslugi pasazerow w terminalu');
INSERT INTO rola
	VALUES (id_rola.nextval, 'kierowca autobusu lotniskowego');
INSERT INTO rola
	VALUES (id_rola.nextval, 'specjalista ds. obslugi infolinii pasazerow z jezykiem obcym');
INSERT INTO rola
	VALUES (id_rola.nextval, 'specjalista ds. koordynacji odpraw');
INSERT INTO rola
	VALUES (id_rola.nextval, 'sprzedawca na lotnisku');
INSERT INTO rola
	VALUES (id_rola.nextval, 'straz ochrony lotniska');

-- Tworzymy tabele pracownik
CREATE TABLE pracownik (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_rola NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli rola
 nazwisko VARCHAR2(25) NOT NULL, -- nazwisko, nie moze byc NULL
 imie VARCHAR2(25) NOT NULL, -- imie, nie moze byc NULL
 pracuje_z DATE NOT NULL, -- data zatrudnienia, nie moze byc NULL
 manager_id NUMBER(7) NULL, -- id managera, moze byc NULL
 zarobki NUMBER(7) NOT NULL, -- zarobki, nie moga buc NULL
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_rola) REFERENCES Rola(id), -- tworzymy klucz obcy
 FOREIGN KEY(manager_id) REFERENCES pracownik(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4000, 'Tadeusz', 'Jan', '21-07-2010', NULL, 11500);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4010, 'Pawlowski', 'Wladyslaw', '10-04-2013', 1000, 9500);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4020, 'Jaworski', 'Kazimierz', '30-04-2011', 1000, 9500);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4030, 'Dudek', 'Lucjan', '22-08-2012', 1000, 9500);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4040, 'Jakubowska', 'Adela', '31-03-2012', 1000, 9500);
INSERT INTO pracownik
 	VALUES (id_prac.nextval, 4050, 'Cielecki', 'Mieszko', '28-04-2020', 1010, 6977);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4060, 'Domachowska', 'Adria', '27-08-2015', 1010, 6505);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4070, 'Domagalska', 'Iwona', '02-04-2019', 1010, 5559);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4080, 'Halicka', 'Adriana', '19-09-2017', 1030, 6673);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4090, 'Drewniowska', 'Adrianna', '12-09-2017', 1040, 4473);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4100, 'Dunajewska', 'Agata', '29-06-2015', 1020, 5609);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4180, 'Nowak', 'Kazimierz', '11-02-2014', 1030, 4945);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4180, 'Michalak', 'Agnieszka', '10-04-2017', 1030, 4493);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4130, 'Nowak', 'Ignacy', '12-02-2014', 1020, 5013);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4140, 'Lewandowska', 'Alberta', '07-10-2017', 1010, 6318);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4150, 'Kowalczyk', 'Ziemowit', '04-10-2015', 1020, 5337);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4160, 'Mazur', 'Radzimir', '21-10-2016', 1010, 6988);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4170, 'Zajac', 'Gniewomir', '20-08-2014', 1020, 6216);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4130, 'Pawlowski', 'Tadeusz', '10-02-2018', 1020, 6572);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4070, 'Michalski', 'Mieszko', '11-05-2020', 1010, 4389);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4070, 'Krol', 'Ada', '10-10-2015', 1010, 6059);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4080, 'Wieczorek', 'Adamina', '11-10-2019', 1030, 6022);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4180, 'Jablonska', 'Iwona', '26-12-2014', 1030, 5752);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4100, 'Wrobel', 'Adela', '21-09-2016', 1020, 4333);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4110, 'Nowakowski', 'Krzesimir', '11-04-2018', 1040, 6881);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4120, 'Majewski', 'Tadeusz', '13-08-2014', 1040, 6991);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4130, 'Olszewski', 'Kazimierz', '24-02-2020', 1020, 5875);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4140, 'Stepien', 'Jacenty', '15-12-2016', 1010, 4704);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4130, 'Malinowski', 'Ignacy', '16-05-2018', 1020, 6308);
INSERT INTO pracownik
	VALUES (id_prac.nextval, 4180, 'Jaworski', 'Waclaw', '27-08-2015', 1030, 5319);

-- Tworzymy tabele pasazer
CREATE TABLE pasazer (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_p NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pracownik
 nazwisko VARCHAR2(25) NOT NULL, -- nazwisko, nie moze byc NULL
 imie VARCHAR2(25) NOT NULL, -- imie, nie moze byc NULL
 email VARCHAR2(25) NOT NULL UNIQUE, -- email, nie moze byc NULL
 telefon VARCHAR2(20) NOT NULL UNIQUE, -- telefon, nie moze byc NULL
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_p) REFERENCES pracownik(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1130, 'Adamczyk', 'Zbyszko', 'adillon@outlook.com', '+48 69 257 1835');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1280, 'Dudek', 'Agata', 'seurat@gmail.com', '+48 69 297 6846');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1260, 'Nowicka', 'Agnieszka', 'helger@hotmail.com', '+48 69 241 4723');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1180, 'Pawlak', 'Roch', 'mschilli@verizon.net', '+48 69 971 1721');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1130, 'Gorski', 'Wit', 'sburke@verizon.net', '+48 69 711 9888');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1130, 'Witkowski', 'Kazimierz', 'melnik@mac.com', '+48 69 051 7464');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1260, 'Walczak', 'Tadeusz', 'burns@outlook.com', '+48 69 992 7963');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1260, 'Sikora', 'Szczepan', 'lpalmer@me.com', '+48 69 832 1158');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1260, 'Baran', 'Wincenty', 'boomzilla@yahoo.ca', '+48 69 560 6279');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1180, 'Rutkowski', 'Tadeusz', 'alastair@hotmail.com', '+48 69 598 9847');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1180, 'Michalak', 'Fryderyk', 'doormat@att.net', '+48 69 999 8181');
INSERT INTO pasazer
	VALUES (id_pas.nextval, 1130, 'Szewczyk', 'Wladyslaw', 'amaranth@yahoo.ca', '+48 69 093 7438');

-- Tworzymy tabele bagaz
CREATE TABLE bagaz (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_pas NUMBER(7) NOT NULL UNIQUE, -- Klucz obcy, referuje do tabeli pasazer. Musi byc unikalny, i nie moze byc null
 waga NUMBER(5) NOT NULL, -- waga, nie moze byc null
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_pas) REFERENCES pasazer(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO bagaz
	VALUES (id_bag.nextval, 101, 8);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 102, 7);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 103, 17);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 104, 27);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 105, 12);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 106, 13);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 107, 26);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 108, 27);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 109, 30);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 110, 21);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 111, 6);
INSERT INTO bagaz
	VALUES (id_bag.nextval, 112, 8);

-- Tworzymy tabele komentarz
CREATE TABLE komentarz (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_pas NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pasazer
 komentarz VARCHAR(400) NOT NULL, -- komentarz, nie moze byc NULL
 ocena NUMBER(2)
    CHECK (ocena >= 1 AND ocena <= 10) NOT NULL, -- sprawdzamy, czy ocena w predziale (1, 10)
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_pas) REFERENCES pasazer(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO komentarz
	VALUES (id_kom.nextval, 101, 'Serwis jest zadowalajacy.', 7);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 102, 'Serwis jest zadowalajacy.', 7);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 103, 'Nie jestem zadowolona z serwisu.', 4);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 104, 'Serwis jest zadowalajacy.', 8);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 105, 'Jedzenie jest bardzo smaczne.', 10);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 106, 'Jedzenie jest smaczne.', 7);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 107, 'Jedzenie jest smaczne.', 6);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 108, 'Jestem zadowolony z serwisu.', 8);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 109, 'Nie jestem zadowolony z serwisu.', 3);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 110, 'Nie spodobalo mi sie jedzenie.', 4);
INSERT INTO komentarz
	VALUES (id_kom.nextval, 111, 'Jestem zadowolony z serwisu.', 9);
 
-- Tworzymy tabele lot
CREATE TABLE lot (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 czas VARCHAR2(5) NOT NULL, -- czas, nie moze byc NULL
 miasto_d VARCHAR(35) NOT NULL, -- miasto docelowe, nie moze byc NULL
 PRIMARY KEY(id)); -- tworzymy klucz glowny
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO lot
	VALUES (id_lot.nextval, '00:55', 'Partington');
INSERT INTO lot
	VALUES (id_lot.nextval, '03:00', 'Chillicothe');
INSERT INTO lot
	VALUES (id_lot.nextval, '04:15', 'Iqaluit');
INSERT INTO lot
	VALUES (id_lot.nextval, '02:25', 'Wyndham');
INSERT INTO lot
	VALUES (id_lot.nextval, '05:35', 'Peekskill');
INSERT INTO lot
	VALUES (id_lot.nextval, '02:50', 'Kerang');
INSERT INTO lot
	VALUES (id_lot.nextval, '03:05', 'Troy');
INSERT INTO lot
	VALUES (id_lot.nextval, '03:50', 'Vernal');
INSERT INTO lot
	VALUES (id_lot.nextval, '04:30', 'San Luis Obispo');
INSERT INTO lot
	VALUES (id_lot.nextval, '04:45', 'Dovercourt');
INSERT INTO lot
	VALUES (id_lot.nextval, '01:05', 'Newman');
INSERT INTO lot
	VALUES (id_lot.nextval, '05:40', 'Arundel');
INSERT INTO lot
	VALUES (id_lot.nextval, '06:00', 'Lehi');
INSERT INTO lot
	VALUES (id_lot.nextval, '06:05', 'Wisbech');
INSERT INTO lot
	VALUES (id_lot.nextval, '02:05', 'Covington');
 
-- Tworzymy tabele linia_lotnicza
CREATE TABLE linia_lotnicza (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 nazwa VARCHAR2(25) NOT NULL UNIQUE, -- nazwa, unikalna, nie moze byc NULL
 adres VARCHAR2(45) NOT NULL UNIQUE, -- adres, unikalny, nie moze byc NULL
 email VARCHAR2(25) NOT NULL UNIQUE, -- email, unikalny, nie moze byc NULL
 telefon VARCHAR2(20) NOT NULL UNIQUE, -- telefon, unikalny, nie moze byc NULL
 PRIMARY KEY(id)); -- tworzymy klucz glowny

-- Wypewniamy tabele przykladowymi danymi
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Lot PL', 'Wroclaw, ul. Zolnierska 48', 'akoblin@aol.com', '+48 69 297 7842');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Lot', 'Warszawa, ul. Elekcyjna 134', 'sinclair@icloud.com', '+48 69 915 5424');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Air Flight', 'Olsztyn, ul. Kajki Michala 64', 'frode@yahoo.ca', '+48 69 540 9984');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Lublin Airlines', 'Lodz, ul. 1 Maja 83', 'geekgrl@verizon.net', '+48 69 396 4512');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'EVA Air', 'Warszawa, ul. 1 Maja 83', 'heckerman@aol.com', '+48 69 689 7940');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Lufthansa', 'Warszawa, ul. Henryka Probusa 60', 'ideguy@msn.com', '+48 69 834 9362');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Qantas Airways', 'Warszawa, ul. Potok 150', 'crimsane@sbcglobal.net', '+48 69 510 8767');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Polish Airways', 'Lublin, ul. Chorzowska 120', 'naoya@att.net', '+48 69 992 6266');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'Aer Lingus', 'Lublin, ul. Grabowskiego Antoniego 107', 'psharpe@live.com', '+48 69 678 7734');
INSERT INTO linia_lotnicza
	VALUES (id_lin.nextval, 'FlyOne ', 'Katowice, ul. Strumienna 104', 'openldap@icloud.com', '+48 69 546 0242');

-- Tworzymy tabele samolot
CREATE TABLE samolot (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_ll NUMBER(7) NOT NULL, -- Klucz obcy,, referuje do tabeli linia_lotnicza
 nazwa VARCHAR(25) NOT NULL UNIQUE, -- nazwa samolotu, unikalna, nie moze byc NULL
 ilosc_m NUMBER(4) NOT NULL, -- ilosc miejsc
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_ll) REFERENCES linia_lotnicza(id)); -- tworzymy klucz obcy

-- Wypewniamy tabele przykladowymi danymi
INSERT INTO samolot
	VALUES (id_mod.nextval, 40, 'ERD-123', 202);
INSERT INTO samolot
	VALUES (id_mod.nextval, 46, 'DKW-55', 107);
INSERT INTO samolot
	VALUES (id_mod.nextval, 42, 'F-22', 150);
INSERT INTO samolot
	VALUES (id_mod.nextval, 43, 'AN-222', 84);
INSERT INTO samolot
	VALUES (id_mod.nextval, 44, 'A-380', 233);
INSERT INTO samolot
	VALUES (id_mod.nextval, 45, 'D-234', 146);
INSERT INTO samolot
	VALUES (id_mod.nextval, 41, 'L-54', 246);
INSERT INTO samolot
	VALUES (id_mod.nextval, 47, 'TU-95', 244);
INSERT INTO samolot
	VALUES (id_mod.nextval, 48, 'R-500', 83);
INSERT INTO samolot
	VALUES (id_mod.nextval, 49, 'AN-210', 210);
INSERT INTO samolot
	VALUES (id_mod.nextval, 40, 'A-320', 155);
INSERT INTO samolot
	VALUES (id_mod.nextval, 49, 'D-133', 84);
INSERT INTO samolot
	VALUES (id_mod.nextval, 40, 'FR-222', 89);
INSERT INTO samolot
	VALUES (id_mod.nextval, 40, 'Q-380', 213);
INSERT INTO samolot
	VALUES (id_mod.nextval, 41, 'P-234', 125);
INSERT INTO samolot
	VALUES (id_mod.nextval, 41, 'J-234', 54);

-- Tworzymy tabele rezerwacja
CREATE TABLE rezerwacja (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_pas NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pasazer
 id_l NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli lot
 id_s NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli samolot
 teminal VARCHAR2(1) 
    CHECK (teminal in ('C', 'E', 'G')) NOT NULL, -- Sprawdzamy, czy wpisalismy jeden z trzech terminalow
 numer_s NUMBER(7) NOT NULL,
 rzad VARCHAR2(1) 
    CHECK (rzad in ('A', 'B', 'C', 'D', 'E', 'F')) NOT NULL, -- Sprawdzamy, czy wpisalismy jeden z szesciu rzadow
 data_w DATE NOT NULL, -- Data wylotu
 cena NUMBER(4) NOT NULL, -- cena
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_pas) REFERENCES pasazer(id), -- tworzymy klucz obcy
 FOREIGN KEY(id_l) REFERENCES lot(id), -- tworzymy klucz obcy
 FOREIGN KEY(id_s) REFERENCES samolot(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 104, 10006, 10, 'C', 127, 'A', '21-05-2019', 517);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 107, 10001, 11, 'G', 103, 'A', '19-02-2020', 541);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 103, 10015, 12, 'E', 123, 'B', '21-11-2019', 437);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 104, 10004, 13, 'C', 144, 'E', '13-09-2019', 578);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 105, 10005, 14, 'G', 129, 'F', '03-01-2020', 792);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 106, 10015, 15, 'G', 101, 'D', '09-04-2020', 798);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 107, 10007, 16, 'G', 117, 'E', '11-03-2019', 716);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 108, 10008, 17, 'E', 99, 'F', '07-12-2019', 309);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 109, 10008, 18, 'C', 22, 'A', '12-04-2020', 436);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 110, 10001, 19, 'G', 22, 'A', '24-05-2019', 519);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 111, 10002, 20, 'E', 133, 'B', '11-07-2019', 357);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 112, 10003, 21, 'C', 73, 'A', '18-04-2020', 731);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 111, 10012, 20, 'G', 12, 'F', '18-02-2020', 424);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 102, 10012, 20, 'C', 24, 'D', '25-06-2019', 704);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 102, 10009, 25, 'E', 61, 'B', '04-07-2019', 593);
INSERT INTO rezerwacja
	VALUES (id_rez.nextval, 101, 10008, 25, 'G', 167, 'C', '13-06-2019', 434);
 
-- Tworzymy tabele kontrola
CREATE TABLE kontrola (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_p NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pracownik
 id_s NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli samolot
 data_k DATE NOT NULL, -- Data przeprowadzenia kontroli
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_p) REFERENCES pracownik(id), -- tworzymy klucz obcy
 FOREIGN KEY(id_s) REFERENCES samolot(id)); -- tworzymy klucz obcy
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 11, '25-04-2020');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 11, '06-06-2020');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 12, '26-02-2020');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 13, '19-08-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 15, '14-12-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 11, '14-05-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 16, '08-11-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 22, '28-09-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 18, '24-03-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 19, '23-06-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 20, '09-02-2020');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 13, '01-07-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1250, 13, '02-08-2019');
INSERT INTO kontrola
	VALUES (id_kont.nextval, 1240, 10, '06-03-2020');
 
-- Tworzymy tabele media
CREATE TABLE media (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 nazwa VARCHAR2(35) NOT NULL UNIQUE, -- Nazwa filmu, unikalna, nie moze byc NULL
 rok NUMBER(4) NOT NULL, -- rok produkcji, nie moze byc NULL
 PRIMARY KEY(id)); -- tworzymy klucz glowny
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO media
	VALUES (id_media.nextval, 'The Stolen Secret', 1981);
INSERT INTO media
	VALUES (id_media.nextval, 'Destruction in the Voyagers', 2014);
INSERT INTO media
	VALUES (id_media.nextval, 'Flight of Blade', 2014);
INSERT INTO media
	VALUES (id_media.nextval, 'The Broken Future', 1999);
INSERT INTO media
	VALUES (id_media.nextval, 'Cloud in the Thorn', 1978);
INSERT INTO media
	VALUES (id_media.nextval, 'Servants in the Secret', 1979);
INSERT INTO media
	VALUES (id_media.nextval, 'Frozen Man', 1975);
INSERT INTO media
	VALUES (id_media.nextval, 'Rose in the Stones', 1952);
INSERT INTO media
	VALUES (id_media.nextval, 'Rose in the Stones 2', 1970);
INSERT INTO media
	VALUES (id_media.nextval, 'Laughing Waves', 1987);
INSERT INTO media
	VALUES (id_media.nextval, 'The Tears of the Abyss', 2006);
INSERT INTO media
	VALUES (id_media.nextval, 'The Tears of the Abyss 2', 2019);
INSERT INTO media
	VALUES (id_media.nextval, 'The Tears of the Abyss 3', 2020);
INSERT INTO media
	VALUES (id_media.nextval, 'The Darkness of the Sky', 2017);
 
-- Tworzymy tabele jedzenie
CREATE TABLE jedzenie (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 nazwa VARCHAR2(35) NOT NULL UNIQUE, -- nazwa potrawy, unikalna, nie moze byc NULL
 PRIMARY KEY(id)); -- tworzymy klucz glowny
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Bigos');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Pierogi');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Zupa ogorkowa');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Flaki');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Zurek');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Barszcz czerwony z uszkami');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Schabowy z ziemniakami i kapusta');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Zupa szczawiowa');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Rosol');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Chleb ze smalcem');
INSERT INTO jedzenie
	VALUES (id_jed.nextval, 'Bliny zmudzkie');
 
-- Tworzymy tabele linia_jedzenie
-- Tabela realizuje zwiazek m:n miedzy tabelami jedzenie ta linia_lotnicza
-- Z dwoch kolumn tworzymy klucz glowny zlozony, zeby uniknac redundancji danych
CREATE TABLE linia_jedzenie (
 id_j NUMBER(7) NOT NULL,
 id_l NUMBER(7) NOT NULL,
 PRIMARY KEY(id_j, id_l),
 FOREIGN KEY(id_j) REFERENCES jedzenie(id),
 FOREIGN KEY(id_l) REFERENCES linia_lotnicza(id));
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO linia_jedzenie
	VALUES (8501, 40);
INSERT INTO linia_jedzenie
	VALUES (8502, 41);
INSERT INTO linia_jedzenie
	VALUES (8503, 42);
INSERT INTO linia_jedzenie
	VALUES (8504, 43);
INSERT INTO linia_jedzenie
	VALUES (8505, 44);
INSERT INTO linia_jedzenie
	VALUES (8506, 45);
INSERT INTO linia_jedzenie
	VALUES (8507, 46);
INSERT INTO linia_jedzenie
	VALUES (8508, 47);
INSERT INTO linia_jedzenie
	VALUES (8509, 48);
INSERT INTO linia_jedzenie
	VALUES (8510, 49);
INSERT INTO linia_jedzenie
	VALUES (8511, 40);
INSERT INTO linia_jedzenie
	VALUES (8501, 41);
INSERT INTO linia_jedzenie
	VALUES (8502, 40);
INSERT INTO linia_jedzenie
	VALUES (8503, 40);
INSERT INTO linia_jedzenie
	VALUES (8504, 41);
INSERT INTO linia_jedzenie
	VALUES (8505, 41);
INSERT INTO linia_jedzenie
	VALUES (8506, 41);
INSERT INTO linia_jedzenie
	VALUES (8507, 43);
INSERT INTO linia_jedzenie
	VALUES (8508, 43);
 
-- Tworzymy tabele linia_media
-- Tabela realizuje zwiazek m:n miedzy tabelami media ta linia_lotnicza
-- Z dwoch kolumn tworzymy klucz glowny zlozony, zeby uniknac redundancji danych
CREATE TABLE linia_media (
 id_m NUMBER(7) NOT NULL, 
 id_l NUMBER(7) NOT NULL,
 PRIMARY KEY(id_m, id_l),
 FOREIGN KEY(id_m) REFERENCES media(id),
 FOREIGN KEY(id_l) REFERENCES linia_lotnicza(id));
 
-- Wypewniamy tabele przykladowymi danymi
INSERT INTO linia_media
	VALUES (8001, 40);
INSERT INTO linia_media
	VALUES (8002, 41);
INSERT INTO linia_media
	VALUES (8003, 42);
INSERT INTO linia_media
	VALUES (8004, 43);
INSERT INTO linia_media
	VALUES (8005, 44);
INSERT INTO linia_media
	VALUES (8006, 45);
INSERT INTO linia_media
	VALUES (8007, 46);
INSERT INTO linia_media
	VALUES (8008, 47);
INSERT INTO linia_media
	VALUES (8009, 48);
INSERT INTO linia_media
	VALUES (8010, 49);
INSERT INTO linia_media
	VALUES (8011, 40);
INSERT INTO linia_media
	VALUES (8012, 40);
INSERT INTO linia_media
	VALUES (8013, 40);
INSERT INTO linia_media
	VALUES (8014, 40);
INSERT INTO linia_media
	VALUES (8001, 45);
INSERT INTO linia_media
	VALUES (8003, 41);
INSERT INTO linia_media
	VALUES (8004, 45);
INSERT INTO linia_media
	VALUES (8005, 43);
INSERT INTO linia_media
	VALUES (8006, 40);
INSERT INTO linia_media
	VALUES (8007, 41);
INSERT INTO linia_media
	VALUES (8008, 42);
INSERT INTO linia_media
	VALUES (8009, 43);
INSERT INTO linia_media
	VALUES (8010, 44);
INSERT INTO linia_media
	VALUES (8011, 45);