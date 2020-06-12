-- Zapytania do bazy danych Airport
alter session set nls_date_format='dd-mm-yyyy';

      -- PROJEKCIE --

-- 1
-- Wybieramy wszystkie kolumny z tabeli pasazer i sortujemy ich
-- malejaco wedlug columny "nazwisko"
SELECT * 
FROM pasazer
ORDER BY nazwisko ASC;

-- 2
-- Wybieramy kolumne id_p z tabeli pasazer i sortujemy ja rosnaco
SELECT id_p
FROM pasazer
ORDER BY id_p ASC;

-- 3
-- Wybieramy kolumny "nazwisko", "imie", "zarobki" z tabeli pasazer i sortujemy ich malejanco
-- wedlug kolumny "zarobki"
SELECT nazwisko, imie, zarobki
FROM pracownik
ORDER BY zarobki DESC;

-- 4
-- Wybieramy wszystkie kolumny z tabeli pracownik i sortujemy ich
-- malejaco wedlug column "nazwisko" i "imie"
SELECT * 
FROM pracownik
ORDER BY nazwisko, imie ASC;

-- 5
-- Wybieramy kolumny "nazwisko", "imie", "zarobki" * 12 z tabeli pasazer i sortujemy ich malejanco
-- wedlug kolumny "zarobki". Tak otrzymamy dochod roczny.
SELECT nazwisko, imie, zarobki * 12
FROM pracownik
ORDER BY zarobki DESC;

-- 6
-- Wybieramy kolumny "nazwisko", "imie", "zarobki" + 1000 z tabeli pasazer i sortujemy ich malejanco
-- wedlug kolumny "zarobki". Tak otrzymamy dochod miesieczny z premija.
SELECT nazwisko, imie, zarobki + 1000
FROM pracownik
ORDER BY zarobki DESC;

-- 7
-- Wybieramy wszystko z tabeli samolot i sortujemy malejanco wedlug kolumny "id_ll"
SELECT *
FROM samolot
ORDER BY id_ll DESC;

-- 8
-- Wybieramy wszystko z tabeli samolot i sortujemy rosnaco wedlug ilosci mejsc
SELECT *
FROM samolot
ORDER BY ilosc_m ASC;

-- 9
-- Wybieramy wszystko z tabeli bagaz i sortujemy rosnaco
-- wedlug wagi
SELECT *
FROM bagaz
ORDER BY waga ASC;

-- 10
-- Wybieramy wszystko z tabeli media i sortujemy rosnaco
-- wedlug columny "rok"
SELECT *
FROM media
ORDER BY rok ASC;

      -- SELEKCJE --
      
-- 1
-- Wybieramy kolumny "nazwisko", "imie", "zarobki" z tabeli pracownik, gdzie zarobki > 6000 i sortujemy ich malejanco
-- wedlug kolumny "zarobki"
SELECT nazwisko, imie, zarobki
FROM pracownik
WHERE zarobki > 6000
ORDER BY zarobki DESC;

-- 2
-- Wybieramy kolumny "nazwisko", "imie", "zarobki" z tabeli pracownik, gdzie zarobki > 5000 oraz zarobki < 7000
-- i sortujemy ich malejanco wedlug kolumny "zarobki"
SELECT nazwisko, imie, zarobki
FROM pracownik
WHERE zarobki > 6000 AND zarobki < 7000
ORDER BY zarobki DESC;

-- 3
-- Wybieramy kolumny "id", "nazwisko", "imie", z tabeli pracownik, gdzie id == manager_id
-- polecenie wypisuje ilosc managerow
SELECT COUNT(DISTINCT manager_id) AS "Ilosc managerow"
FROM pracownik;

-- 4
-- Wybieramy kolumne "cena", z tabeli pracownik, gdzie cena > 700
-- polecenie wypisuje ilosc takich rezerwacji pod nazwa "VIP"
SELECT COUNT(cena) AS "VIP"
FROM rezerwacja
WHERE cena > 700;

-- 5
-- Wypisujemy liczbe pracownikow iaki pracuja pod kierownictwem kazdego managera
SELECT a.manager_id, COUNT(*)
FROM pracownik a, pracownik b
WHERE a.manager_id = b.id
GROUP BY a.manager_id
ORDER BY a.manager_id ASC;

-- 6
-- Wypisujemy sriedni zarobek pracownikow iaki pracuja pod kierownictwem kazdego managera
SELECT a.manager_id, SUM(a.zarobki)/COUNT(*) AS "Sredni"
FROM pracownik a, pracownik b
WHERE a.manager_id = b.id
GROUP BY a.manager_id
ORDER BY a.manager_id ASC;

-- 7
-- Wypisujemy ilosc pracownikow na stanowisku
SELECT a.id_rola, COUNT(*) AS "Ilosc pracownikow na stanowisku"
FROM pracownik a, pracownik b
WHERE a.manager_id = b.id
GROUP BY a.id_rola
ORDER BY a.id_rola ASC;

-- 8
-- Wypisujemy stanowisko, na jakim pracuje wiecej niz 3 pracowniki
SELECT a.id_rola, COUNT(*) AS "Ilosc"
FROM pracownik a, pracownik b
WHERE a.manager_id = b.id
GROUP BY a.id_rola
HAVING COUNT(*) >= 3
ORDER BY a.id_rola ASC;

-- 9
-- Wypisujemy maksymalny zarobek na stanowisku
SELECT a.id_rola, MAX(a.zarobki) AS "Max"
FROM pracownik a, pracownik b
WHERE a.manager_id = b.id
GROUP BY a.id_rola
ORDER BY a.id_rola ASC;

-- 10
-- wiswietlamy dyrektora lotniska
SELECT nazwisko, imie
FROM pracownik
WHERE manager_id IS NULL;

-- 11
-- wiswietlamy pracownikow w cyim nazwisku jest 'al' i sortujemy malejanco
SELECT nazwisko, imie
FROM pracownik
WHERE nazwisko LIKE '%al%'
ORDER BY nazwisko;

-- 12
-- wiswietlamy pasazerow w cyim nazwisku jest 'u' jako druga litera i sortujemy malejanco
SELECT nazwisko, imie
FROM pracownik
WHERE nazwisko LIKE '_u%'
ORDER BY nazwisko;

-- 13
-- wiswietlamy pracownikow w cyim nazwisku jest 'w?k' i sortujemy malejanco
SELECT nazwisko, imie
FROM pracownik
WHERE nazwisko LIKE '%w_k%'
ORDER BY nazwisko;

-- 14
-- wiswietlamy pracownikow, prazujacych z 2019 roku i sortujemy malejanco
SELECT nazwisko, imie, pracuje_z
FROM pracownik
WHERE pracuje_z >= '01-01-2019'
ORDER BY nazwisko;

-- 15
-- wiswietlamy pracownikow, przyjetych w 2019 roku
SELECT nazwisko, imie, pracuje_z
FROM pracownik
WHERE pracuje_z >= '01-01-2019' AND pracuje_z <= '31-12-2019';

-- 16
-- wiswietlamy id pracownikow, jaki obsluguja pasazerow
SELECT id
FROM pracownik
INTERSECT 
SELECT id_p
FROM pasazer;

      -- JOIN DWIE TABELI --

-- 1
-- Wypisujemy cene kazdej rezerwacji, oraz imie i nazwisko pasazera 
SELECT a.id, a.imie, a.nazwisko, b.cena
FROM pasazer a
INNER JOIN rezerwacja b ON a.id = b.id_pas;

-- 2
-- Wypisujemy stanowisko kazdego pracownika z imieniem, zaczynajacym sie na 'I'
SELECT a.id, a.imie, a.nazwisko, b.stanowisko
FROM pracownik a
INNER JOIN rola b ON a.id_rola = b.id
WHERE a.imie LIKE 'I%';

-- 3
-- Wypisujemy pasazerow, z bagazem ciezszym niz 20 kg
SELECT a.id, a.imie, a.nazwisko, b.waga
FROM pasazer a
LEFT JOIN bagaz b ON a.id = b.id_pas
WHERE waga > 20;

-- 4
-- Wypisujemy pasazerow, ktorzy zostawili komentarz 
SELECT a.id, a.imie, a.nazwisko, b.komentarz
FROM pasazer a
RIGHT JOIN komentarz b ON a.id = b.id_pas;

-- 5
-- Wypisujemy pasazerow, ktorzy zostawili pozytywny komentarz 
SELECT p.id, p.imie, p.nazwisko, k.komentarz, k.ocena
FROM pasazer p
RIGHT JOIN komentarz k ON p.id = k.id_pas
WHERE k.ocena > 5;

-- 6
-- Wypisujemy wszystkich pasazerow, niezaleznie od tego, czy zostawili komentarz 
SELECT a.id, a.imie, a.nazwisko, b.komentarz
FROM pasazer a
FULL JOIN komentarz b ON a.id = b.id_pas
ORDER BY nazwisko ASC;

-- 7
-- Wypisujemy pracownika, przez ktorego byla przeprowadzona kazda kontrola, oraz jej date
SELECT a.id, a.imie, a.nazwisko, b.data_k
FROM pracownik a
RIGHT JOIN kontrola b ON a.id = b.id_p
ORDER BY a.nazwisko ASC;

-- 8
-- Wypisujemy samoloty, oraz linie lotnicze, ktorym one naleza
SELECT a.nazwa AS "linia_lotnicza", b.nazwa AS "samolot"
FROM linia_lotnicza b
RIGHT JOIN samolot a ON b.id = a.id_ll
ORDER BY b.nazwa ASC;

-- 9
-- Wypisujemy samoloty, ktorze maja wiecej niz 200 miejsc oraz linie lotnicze, ktorym one naleza
SELECT a.nazwa AS "linia_lotnicza", b.nazwa AS "samolot"
FROM linia_lotnicza b
RIGHT JOIN samolot a ON b.id = a.id_ll
WHERE a.ilosc_m > 200
ORDER BY b.nazwa ASC;

-- 10 
-- Wypisujemy pasazerow, ktorzy nie zostawili komentarz 
SELECT a.id, a.imie, a.nazwisko, b.komentarz
FROM pasazer a
FULL JOIN komentarz b ON a.id = b.id_pas
MINUS
SELECT a.id, a.imie, a.nazwisko, b.komentarz
FROM pasazer a
RIGHT JOIN komentarz b ON a.id = b.id_pas;

-- 11
-- Wypisujemy wszystkie rezerwacje do miasta, ktorze maja w nazwie litere 'v'
SELECT a.id, b.miasto_d
FROM rezerwacja a
LEFT JOIN lot b ON a.id_l = b.id
WHERE b.miasto_d LIKE 'V%' OR b.miasto_d LIKE '%v%';

      -- JOIN TRZY TABELI --

-- 1
-- Wypisujemy pracownika, przez ktorego byla przeprowadzona kazda kontrola, jej date
-- oraz nazwe samolotu
SELECT a.id, a.imie, a.nazwisko, b.data_k, s.nazwa
FROM pracownik a
INNER JOIN kontrola b ON a.id = b.id_p
INNER JOIN samolot s ON b.id_s = s.id
ORDER BY a.nazwisko ASC;

-- 2
-- Wypisujemy wszystkie samoloty, niezaleznie od tego, czy byly one
-- na kontroli technicanej
SELECT a.id, a.imie, a.nazwisko, b.data_k, s.nazwa
FROM pracownik a
INNER JOIN kontrola b ON a.id = b.id_p
RIGHT JOIN samolot s ON b.id_s = s.id
ORDER BY a.nazwisko ASC;

-- 3
-- Wypisujemy wszystkich pasazerow, ktorzy kiedykolwiek rezerwowali miejsce
-- na samolot, ktorego nazwa zaczyna sie na 'A'
SELECT a.id, b.id AS "id_rez", a.imie, a.nazwisko, s.nazwa
FROM pasazer a
INNER JOIN rezerwacja b ON a.id = b.id_pas
INNER JOIN samolot s ON b.id_s = s.id
WHERE s.nazwa LIKE 'A%'
ORDER BY a.nazwisko ASC;

-- 4
-- Wypisujemy wszystkich pasazerow, ktorzy zadnego razu nie rezerwowali miejsce
-- na samolot, ktorego nazwa zaczyna sie na 'D'
SELECT a.id, b.id AS "id_rez", a.imie, a.nazwisko, s.nazwa
FROM pasazer a
INNER JOIN rezerwacja b ON a.id = b.id_pas
INNER JOIN samolot s ON b.id_s = s.id
MINUS
SELECT a.id, b.id AS "id_rez", a.imie, a.nazwisko, s.nazwa
FROM pasazer a
INNER JOIN rezerwacja b ON a.id = b.id_pas
INNER JOIN samolot s ON b.id_s = s.id
WHERE s.nazwa LIKE 'D%';

-- 5
-- Wypisujemy wszystkie filmy, oferowane przez linie lotnicze
SELECT a.nazwa, m.nazwa
FROM linia_lotnicza a
FULL JOIN linia_media b ON a.id = b.id_l
FULL JOIN media m ON b.id_m = m.id
ORDER BY a.nazwa ASC;

-- 6
-- Wypisujemy wszystkie filmy, oferowane przez linie lotnicze roku 2014, 1975, 1979
SELECT a.nazwa, m.nazwa, m.rok
FROM linia_lotnicza a
FULL JOIN linia_media b ON a.id = b.id_l
FULL JOIN media m ON b.id_m = m.id
WHERE m.rok IN(2014, 1975, 1979);

-- 7
-- Wypisujemy wszystkie filmy, oferowane przez linie lotnicze, ktorzy
-- w nazwie maja slowa 'The' lub 'Tears' lub 'Future'
SELECT a.nazwa, m.nazwa
FROM linia_lotnicza a
RIGHT JOIN linia_media b ON a.id = b.id_l
RIGHT JOIN media m ON b.id_m = m.id
WHERE m.nazwa LIKE 'The%' OR m.nazwa LIKE '%Tears%' OR m.nazwa LIKE '%Future%';

-- 8
-- Wypisujemy linie litnicze, z czyich uslug korzystaly pasazery
SELECT DISTINCT a.imie, a.nazwisko, l.nazwa
FROM pasazer a
LEFT JOIN rezerwacja b ON a.id = b.id_pas
LEFT JOIN samolot s ON b.id_s = s.id
LEFT JOIN linia_lotnicza l ON s.id_ll = l.id;

-- 9
-- Wypisujemy linie litnicze, z czyich uslug korzystaly pasazery i gdzie samolot
-- byl nie wiecej niz na 90 miejsc
SELECT DISTINCT a.imie, a.nazwisko, s.nazwa, l.nazwa
FROM pasazer a
LEFT JOIN rezerwacja b ON a.id = b.id_pas
LEFT JOIN samolot s ON b.id_s = s.id
LEFT JOIN linia_lotnicza l ON s.id_ll = l.id
WHERE s.ilosc_m <= 90;

-- 10
-- Wypisujemy pasazerow, ktorzy zostawili pozytywny komentarz oraz linie litnicze, 
-- z czyich uslug korzystaly
SELECT a.id, a.imie, a.nazwisko, k.komentarz, k.ocena, l.nazwa
FROM pasazer a
RIGHT JOIN komentarz k ON a.id = k.id_pas
LEFT JOIN rezerwacja b ON a.id = b.id_pas
LEFT JOIN samolot s ON b.id_s = s.id
LEFT JOIN linia_lotnicza l ON s.id_ll = l.id
WHERE k.ocena > 5;

-- 11
-- Wypisujemy wszystkie potrawy, oferowane przez linie lotnicze
SELECT a.nazwa AS "Linia lotnicza", m.nazwa AS "Jedzenie"
FROM linia_lotnicza a
FULL JOIN linia_jedzenie b ON a.id = b.id_l
FULL JOIN jedzenie m ON b.id_j = m.id
ORDER BY a.nazwa ASC;

-- 12
-- Wypisujemy wszystkie potrawy, oferowane przez linie lotnicza 'Lot PL'
SELECT a.nazwa AS "Linia lotnicza", m.nazwa AS "Jedzenie"
FROM linia_lotnicza a
FULL JOIN linia_jedzenie b ON a.id = b.id_l
FULL JOIN jedzenie m ON b.id_j = m.id
WHERE a.nazwa = 'Lot PL'
ORDER BY m.nazwa ASC;