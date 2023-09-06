create database esercitazionefinale;

create table TecniciRadiologia (
ID_tecnico int primary key,
nome_tecnico varchar (100),
cognome_tecnico varchar (100),
specializzazione_tecnico varchar (255));

insert into TecniciRadiologia
values (1, 'Camilla', 'Miacci', 'Rx'),
	(2, 'Federica', 'Leonardi', 'Rm'),
    (3, 'Gianpaolo', 'Bianchi', 'Tc'),
    (4, 'Mario', 'Ferrari', 'Moc'),
    (5, 'Lorenza', 'Giustini', 'Rx'),
    (6, 'Valerio', 'Rossi', 'Rx'),
    (7, 'Domenico', 'Fabrizi', 'Rm'),
    (8, 'Martina', 'Bruno', 'Rm');

create table Pazienti (
ID_paziente int primary key,
nome_paziente varchar (100),
cognome_paziente varchar (100),
data_nascita date);

insert into Pazienti
values (10, 'Marco', 'Perella', '1985-03-15'),
(11, 'Laura', 'Cupini', '1990-07-22'),
(12, 'Paolo', 'Verdi', '1978-11-10'),
(13, 'Anna', 'Giallo', '1995-05-03'),
(14, 'Luca', 'Neri', '1982-09-28'),
(15, 'Sofia', 'Marrone', '1993-12-19'),
(16, 'Giovanni', 'Russo', '1989-06-08'),
(17, 'Martina', 'Verde', '1977-02-14');

create table MediciRadiologi (
ID_medico int primary key,
nome_medico varchar (100),
cognome_medico varchar (100),
specializzazione_medico varchar (255),
numero_telefono varchar (50),
email varchar (100));

insert into MediciRadiologi
values (20, 'Maria', 'Valeri', 'Tc_m', '3331234567', 'maria.valeri@email.com'),
(21, 'Luigi', 'Blu', 'Tc_m', '3479876543', 'luigi.blu@email.com'),
(22, 'Chiara', 'Rosa', 'Rx_m', '3664567890', 'chiara.rosa@email.com'),
(23, 'Paolo', 'Porta', 'Rm_m', '3295671234', 'paolo.porta@email.com'),
(24, 'Laura', 'Treni', 'Rm_m', '3382345678', 'laura.treni@email.com'),
(25, 'Francesco', 'Italia', 'Moc_m', '3667890123', 'francesco.italia@email.com'),
(26, 'Alessia', 'Marcelli', 'Rx_m', '3408765432', 'alessia.marcelli@email.com'),
(27, 'Luca', 'Leuci', '3333456789', 'Rx_m', 'luca.leuci@email.com');
	

create table Esami (
ID_paziente int,
ID_tecnico int,
tipo_esame varchar (255),
data_esame date,
constraint fk_ID_paziente_Pazienti_Esami foreign key (ID_paziente) references Pazienti (ID_paziente) on update cascade on delete no action,
constraint fk_ID_tecnico_TecniciRadiologia_Esami foreign key (ID_tecnico) references TecniciRadiologia (ID_tecnico) on update cascade on delete no action);

insert into Esami
values (15, 6, 'Rx_mani', '2021-08-17'),
(13, 2, 'Rm_ginocchio_dx', '2022-12-05'),
(11, 8, 'Rm_piede_dx', '2023-04-29'),
(16, 3, 'Tc_encefalo', '2021-10-12'),
(12, 3, 'Tc_torace', '2022-02-08'),
(14, 1, 'Rx_torace', '2023-06-20'),
(17, 5, 'Rx_gamba_sn', '2021-11-03'),
(10, 5, 'Rx_spalla_dx', '2022-05-14'),
(10, 4, 'Moc_lombare', '2023-03-09'),
(11, 8, 'Rm_addome', '2023-04-29');

create table Referti (
ID_referto int primary key,
ID_paziente int,
ID_medico int,
data_esame date,
data_referto date,
risultato text,
constraint fk_ID_paziente_Pazienti_Referti foreign key (ID_paziente) references Pazienti (ID_paziente) on update cascade on delete no action,
constraint fk_ID_medico_MediciRadiologi_Referti foreign key (ID_medico) references MediciRadiologi (ID_medico) on update cascade on delete no action,
constraint fk_data_esame_Esami_Referti foreign key (data_esame) references Esami (data_esame) on update cascade on delete no action);

insert into Referti
values (30, 15, 22, '2021-08-17', '2021-08-24', 'Note di rizoartrosi ed osteofitosi, deformazione, sclerosi e parziale riduzione di ampiezza di alcune interfalange con diffuse aree di riassorbimento osseo subcondrale e calcificazioni extra-articolari'),
(31, 13, 23, '2022-12-05', '2022-12-12', 'Non evidenza di rime di lesione a carico entrambe le fibrocartilagini meniscali. Moderata alterazione del segnale del LCA, continuo lungo i piani di scansione eseguiti, da correlare a moderato esito distrattivo di medio-basso grado. Nella norma il LCP. Non evidenza di significative alterazioni a carico delle rimanenti strutture capsulo-legamentose in esame'),
(32, 11, 24, '2023-04-29', '2023-05-05', 'Piccola formazione di circa 6mm di diametro, in corrispondenza del II spazio interdigitale, sul versante plantare, a livello di un piano passante per la regione MTF, riferibile a neuroma di Morton; a tale livello coesistono modesti fenomeni infiammatori nel contesto delle parti molli perischeletriche'),
(33, 16, 20, '2021-10-12', '2021-10-19', 'Lo studio non ha documentato significative alterazioni tomodensitometriche a carico del tessuto cerebrale e cerebellare. Sistema ventricolare sotto e sovratentoriale in asse, di normale morfologia e dimensioni. Spazi sub aracnoidei della base e della volta normo configurati'),
(34, 12, 21, '2022-02-08', '2022-02-15', 'Esame eseguito con tecnica spirale multistrato, prima e dopo somministrazione endovenosa di mezzo di contrasto. Lieve uniforme ispessimento delle pareti dei bronchi polmonari principali, delle loro ramificazioni lobari e segmentarie, come da esito di flogosi cronica.Quadro di lieve enfisema polmonare'),
(35, 14, 22, '2023-06-20', '2023-06-27', 'Diffuso ispessimento trama interstiziale, Non lesioni pleuroparenchimali in atto, Cuore nei limiti'),
(36, 17, 26, '2021-11-03', '2021-11-10', 'Presenza di lesioni di tipo traumatico'),
(37, 10, 27, '2022-05-14', '2022-05-21', 'Testa omerale in sede, normoconformata, senza evidenza di immagini a densità calcica a carico delle parti molli peri trochitee ed intraarticolari'),
(38, 10, 25, '2023-03-09', '2023-03-16', 'Normale: +2.5> T-score >-1.0'),
(39, 11, 24, '2023-04-29', '2023-05-05', 'Il fegato ha dimensioni e morfologia regolari, mostra contorni lineari e presenta nel lobo destro, a sede para-cavale piccola formazione tondeggiante (1,5 cm circa) che mostra tenue e progressiva impregnazione nelle fasi contrastografiche acquisite, tale reperto è compatibile con formazione di tipo angiomatoso');

/*Trova il numero di esami effettuati da ciascun tecnico radiologo e ordina i risultati in ordine decrescente in base al numero di esami.*/

SELECT TecniciRadiologia.nome_tecnico, TecniciRadiologia.cognome_tecnico, COUNT(Esami.tipo_esame) AS numero_esami
FROM TecniciRadiologia
LEFT JOIN Esami ON TecniciRadiologia.ID_tecnico = Esami.ID_tecnico
GROUP BY TecniciRadiologia.nome_tecnico, TecniciRadiologia.cognome_tecnico
ORDER BY numero_esami DESC;

/*Trova il nome e il cognome dei pazienti che hanno sottoposto più esami e ordina i risultati in ordine decrescente in base al numero di esami.*/

SELECT p.nome_paziente, p.cognome_paziente, COUNT(e.tipo_esame) AS numero_esami
FROM Pazienti p
LEFT JOIN Esami e ON p.ID_paziente = e.ID_paziente
GROUP BY p.nome_paziente, p.cognome_paziente
ORDER BY numero_esami DESC;

/*Trova tutti i referti firmati da medici radiologi con la specializzazione "Tc_m".*/

SELECT r.data_referto, r.risultato
FROM Referti r
JOIN MediciRadiologi m ON r.ID_medico = m.ID_medico
WHERE m.specializzazione_medico = 'Tc_m';

/*Trova il numero di referti firmati da ciascun medico radiologo e ordina i risultati in ordine crescente in base al numero di referti.*/

SELECT m.nome_medico, m.cognome_medico, COUNT(r.ID_referto) AS numero_referti
FROM MediciRadiologi m
LEFT JOIN Referti r ON m.ID_medico = r.ID_medico
GROUP BY m.nome_medico, m.cognome_medico
ORDER BY numero_referti ASC;

/*Trova il numero totale di esami eseguiti in ciascun mese dell'anno 2023.*/

SELECT EXTRACT(MONTH FROM e.data_esame) AS mese, COUNT(e.tipo_esame) AS numero_esami
FROM Esami e
WHERE EXTRACT(YEAR FROM e.data_esame) = 2023
GROUP BY EXTRACT(MONTH FROM e.data_esame)
ORDER BY mese;

/*Trova il nome e il cognome del paziente, il tipo di esame e la data dell'esame per tutti gli esami effettuati nel mese di Aprile 2023.*/

SELECT p.nome_paziente, p.cognome_paziente, e.tipo_esame, e.data_esame
FROM Pazienti p
JOIN Esami e ON p.ID_paziente = e.ID_paziente
WHERE EXTRACT(YEAR FROM e.data_esame) = 2023 AND EXTRACT(MONTH FROM e.data_esame) = 4;

/*Trova il numero totale di esami effettuati per ciascuna specializzazione tecnica.*/

SELECT t.specializzazione_tecnico, COUNT(*) AS numero_esami
FROM TecniciRadiologia t
JOIN Esami e ON t.ID_tecnico = e.ID_tecnico
GROUP BY t.specializzazione_tecnico;

/*Trova il medico radiologo che ha firmato il maggior numero di referti.*/

SELECT mr.nome_medico, COUNT(*) AS numero_referti
FROM MediciRadiologi mr
JOIN Referti r ON mr.ID_medico = r.ID_medico
GROUP BY mr.nome_medico
ORDER BY numero_referti DESC
LIMIT 1;

/*Elenco dei pazienti e il numero di esami effettuati da ciascun paziente.*/

SELECT p.nome_paziente, p.cognome_paziente, COUNT(e.tipo_esame) AS numero_esami
FROM Pazienti p
LEFT JOIN Esami e ON p.ID_paziente = e.ID_paziente
GROUP BY p.nome_paziente, p.cognome_paziente
ORDER BY numero_esami DESC;

/*Elenco dei referti firmati dal medico radiologo "Maria Valeri" con il suo numero di telefono e la data del referto.*/

SELECT mr.nome_medico, mr.cognome_medico, mr.numero_telefono, r.data_referto
FROM MediciRadiologi mr
INNER JOIN Referti r ON mr.ID_medico = r.ID_medico
WHERE mr.nome_medico = 'Maria' AND mr.cognome_medico = 'Valeri';



