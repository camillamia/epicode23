create table Studente (
matricola_studente varchar (255),
nome_studente varchar (255),
città varchar (255),
primary key (matricola_studente));

create table Docente (
matricola_docente varchar (255),
nome_docente varchar (255),
primary key (matricola_docente,nome_docente));

create table Corso (
codice_corso varchar (255),
nome_corso varchar (255),
matricola_docente varchar (255),
primary key (codice_corso),
constraint fk_matricola_docente_Docente_Corso foreign key (matricola_docente) references Docente (matricola_docente) on update cascade on delete no action);


create table Esame (
codice_esame varchar (255),
matricola_studente varchar (255),
data date not null,
voto float,
settore_scientifico varchar (255),
primary key (codice_esame, matricola_studente),
constraint fk_matricola_studente_Esame_Studente foreign key (matricola_studente) references Studente (matricola_studente) on update cascade on delete no action,
constraint fk_Esame_corso_Esame foreign key (codice_esame) references Corso (codice_corso) on update cascade on delete no action);

select Studente.matricola_studente, Studente.nome_studente, max(voto), min(voto), avg(voto)
from Esame
join Studente on Studente.matricola_studente=Esame.matricola_studente
group by Studente.matricola_studente, Studente.nome_studente;

select Studente.matricola_studente, Studente.nome_studente, max(voto) as voto_max, min(voto), avg(voto)
from Esame
join Studente on Studente.matricola_studente=Esame.matricola_studente
group by Studente.matricola_studente, Studente.nome_studente
having avg(Esame.voto)>25 and count(Esame.data)>=10
order by voto_max asc;


