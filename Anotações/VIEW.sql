create or replace view alunos_view
as
select nom_alu
from alunos
order by nom_alu asc;

select * from alunos_view;
select * from alunos_view where nom_alu like 'A%';

create or replace view media_cursos
as
select d.nom_disc, avg(h.media) from disciplinas d
	inner join historicos_escolares h
	on d.cod_disc = h.cod_disc
group by d.nom_disc
order by avg(h.media) desc;

select * from media_cursos;