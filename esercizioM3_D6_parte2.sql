create table Studente (
matricola_studente int,
nome_studente varchar (255),
anno_laurea int,
titolo_studio varchar (255),
voto_laurea float,
primary key (matricola_studente));

create table Dipartimento (
codice_dipartimento int,
nome_dipartimento varchar (255),
settore_scientifico varchar (255),
num_docenti int,
primary key (codice_dipartimento));

create table ConcorsoMaster (
codice_master int,
codice_dipartimento int,
data_pubblicazione date,
data_scadenza date,
num_posti_disponibili float,
primary key (codice_master),
constraint fk_codice_dipartimento_Dipartimento_ConcorsoMaster foreign key (codice_dipartimento) references Dipartimento (codice_dipartimento) on update cascade on delete no action);

create table PartecipaConcorsoMaster (
codice_dipartimento int,
codice_master int,
matricola_studente int,
data_invio_domanda date,
constraint fk_codice_dipartimento_Dipartimento_PartecipaConcorsoMaster foreign key (codice_dipartimento) references Dipartimento (codice_dipartimento) on update cascade on delete no action,
constraint fk_codice_master_ConcorsoMaster_PartecipaConcorsoMaster foreign key (codice_master) references ConcorsoMaster (codice_master) on update cascade on delete no action,
constraint fk_matricola_studente_Studente_PartecipaConcorsoMaster foreign key (matricola_studente) references Studente (matricola_studente) on update cascade on delete no action);

select Studente.nome_studente, Dipartimento.settore_scientifico
from Studente
join PartecipaConcorsoMaster on Studente.matricola_studente=PartecipaConcorsoMaster.matricola_studente
join Dipartimento on PartecipaConcorsoMaster.codice_dipartimento=Dipartimento.codice_dipartimento
group by Studente.nome_studente, Dipartimento.settore_scientifico
having count(PartecipaConcorsoMaster.codice_master)=3
order by Studente.nome_studente asc;

select Dipartimento.nome_dipartimento, Dipartimento.settore_scientifico, count(ConcorsoMaster.codice_master)
from Dipartimento
join ConcorsoMaster on Dipartimento.codice_dipartimento=ConcorsoMaster.codice_dipartimento
where Dipartimento.codice_dipartimento not in (select ConcorsoMaster.codice_dipartimento
												from ConcorsoMaster where ConcorsoMaster.num_posti_disponibili<=7)
group by Dipartimento.nome_dipartimento, Dipartimento.settore_scientifico;

select Studente.matricola_studente, Studente.nome_studente
from Studente
join PartecipaConcorsoMaster on PartecipaConcorsoMaster.matricola_studente=Studente.matricola_studente
join ConcorsoMaster on ConcorsoMaster.codice_master=PartecipaConcorsoMaster.codice_master
where Studente.voto_laurea>100
group by Studente.matricola_studente, Studente.nome_studente
having count(ConcorsoMaster.codice_master)>=2 and count(distinct ConcorsoMaster.data_pubblicazione)<count(ConcorsoMaster.codice_master);


