create table Disco (
nro_serie_disco varchar (255),
titolo_album varchar (255) not null,
anno year,
prezzo dec(4,2) unsigned,
primary key (nro_serie_disco));

create table Esecuzione (
codice_reg int unsigned,
titolo_canzone varchar (255),
anno year,
primary key (codice_reg));

create table Autore (
nome_autore varchar (255),
titolo_canzone varchar (255),
primary key (nome_autore, titolo_canzone));

create unique index index_autore
on Autore (nome_autore,titolo_canzone);

create table Cantante (
nome_cantante varchar (255),
codice_reg int unsigned,
primary key (nome_cantante, codice_reg),
constraint fk_codice_reg_Cantante_Esecuzione foreign key (codice_reg) references Esecuzione(codice_reg) on update cascade on delete no action);


create unique index index_cantante
on Cantante (nome_cantante,codice_reg);

create table Contiene (
nro_serie_disco varchar (255),
codice_reg int unsigned,
nro_prog int unsigned,
         primary key (nro_serie_disco, codice_reg),
             constraint fk_nro_serie_disco_Contiene_Disco foreign key (nro_serie_disco) references Disco(nro_serie_disco) on update cascade on delete no action,
             constraint fk_codice_reg_Contiene_Esecuzione foreign key (codice_reg) references Esecuzione(codice_reg) on update cascade on delete no action);

select Cantante.nome_cantante
from Cantante
join Esecuzione on Cantante.codice_reg=Esecuzione.codice_reg
join Autore on Autore.titolo_canzone=Esecuzione.titolo_canzone
where Autore.nome_autore=Cantante.nome_cantante and Autore.nome_autore like "D%";

select Disco.titolo_album
from Disco
join Contiene on Disco.nro_serie_disco=Contiene.nro_serie_disco
join Esecuzione on Contiene.codice_reg=Esecuzione.codice_reg
where Esecuzione.anno is null;

select Cantante.nome_cantante
from Cantante
where Cantante.nome_cantante not in
(select Cantante_2.nome_cantante 
from Cantante as Cantante_2 inner join Cantante as Cantante_3 on Cantante_2.codice_reg=Cantante_3.codice_reg
where Cantante_2.nome_cantante>Cantante_3.nome_cantante);
