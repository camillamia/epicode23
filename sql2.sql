create table Studente (
matricola_studente varchar (255),
nome_studente varchar (255),
città varchar (255),
primary key (matricola_studente));

create table Corso (
codice_corso varchar (255),
nome_corso varchar (255),
matricola_docente varchar (255),
primary key (codice_corso));

create table Docente (
matricola_docente varchar (255),
nome_docente varchar (255),
primary key (matricola_docente,nome_docente));

create table Esame (
codice_esame varchar (255),
matricola_studente varchar (255),
data date not null,
voto float,
settore_scientifico varchar (255),
primary key (codice_esame, matricola_studente),
constraint fk_matricola_studente_Esame_Studente foreign key (matricola_studente) references Studente (matricola_studente) on update cascade on delete no action,
constraint fk_Esame_corso_Esame foreign key (codice_esame) references Corso (codice_corso) on update cascade on delete no action);

select Esame.matricola_studente, Docente.nome_docente, Esame.codice_esame
from Esame
inner join Corso on Esame.codice_esame=Corso.codice_corso
inner join Docente on Corso.matricola_docente=Docente.matricola_docente
where Esame.voto>28;

select Docente.nome_docente, Corso.nome_corso, Esame.settore_scientifico
from Corso
inner join Docente on Corso.matricola_docente=Docente.matricola_docente
inner join Esame on Corso.codice_corso=Esame.codice_esame;



