-- Questão 1
create or replace view boletim
as
	select a.mat_alu, a.nom_alu, he.cod_disc, he.semestre, he.media, he.faltas, he.situacao from alunos a
	inner join historicos_escolares he
	on a.mat_alu = he.mat_alu;

select * from boletim;

-- Questão 2
create or replace view dados_escolar
as

select * from turmas;
select * from professores;
select * from disciplinas;

select d.nom_disc, p. from professores p where p.cod_prof in (
	select t.cod_prof from turmas t where t.cod_disc in (
		select d.cod_disc from disciplinas d;
	)
)