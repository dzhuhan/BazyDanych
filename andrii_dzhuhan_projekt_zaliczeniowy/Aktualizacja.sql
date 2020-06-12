        -- Aktualizacja bazy danych "Lotnisko" --
        
-- 1 --
-- Dodanie nowych stanowisk, oraz tabeli "Aerotel"
-- dodajemy nowe stanowiska
INSERT INTO rola
	VALUES (id_rola.nextval, 'pokojowy');
INSERT INTO rola
	VALUES (id_rola.nextval, 'manager aerotelu');
    
-- tworzymy tabele aerotel
CREATE TABLE aerotel(
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_pas NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pasazer
 nr_pok NUMBER(7) NOT NULL, -- Numer pokoju, nie moze byc NULL
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_pas) REFERENCES pasazer(id)); -- tworzymy klucz obcy
 
 -- 2 --
 -- Dodanie mozliwosci komentowania dla pracownikow.
 ALTER TABLE komentarz -- zmienamy nazwe tabeli "komentarz"
 RENAME TO komentarz_pasazer; -- na "komentarz_pasazer"
 
 CREATE TABLE komentarz_pracownik (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_prac NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pasazer
 komentarz VARCHAR(400) NOT NULL, --komentarz, nie moze byc NULL
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_prac) REFERENCES pracownik(id)); -- tworzymy klucz obcy
 
 -- 3 --
 -- Dodanie restauracji.
 CREATE TABLE restauracja (
 id NUMBER(7) NOT NULL, -- Klucz glowny
 id_pas NUMBER(7) NOT NULL, -- Klucz obcy, referuje do tabeli pasazer
 nazwa VARCHAR(40) NOT NULL, -- nazwa potrawy, nie moze byc NULL
 cena NUMBER(4) NOT NULL, -- cena, nie moze byc NULL
 PRIMARY KEY(id), -- tworzymy klucz glowny
 FOREIGN KEY(id_pas) REFERENCES pasazer(id)); -- tworzymy klucz obcy