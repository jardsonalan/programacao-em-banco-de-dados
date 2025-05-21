-- Questão 1
select d.cod_disc, d.nom_disc from disciplinas d where d.cod_disc in (
	select pr.cod_disc from pre_requisitos pr
	where pr.cod_disc_pre in (
		select d.cod_disc from disciplinas d
		where d.nom_disc like 'ALGORITMOS E ESTRUTURAS DE DADOS I'
	)
);

-- Questão 2
select d.cod_disc, d.nom_disc from disciplinas d
inner join pre_requisitos pr
on pr.cod_disc = d.cod_disc
where pr.cod_disc_pre in (
	select d.cod_disc from disciplinas d
	where d.nom_disc like 'ALGORITMOS E ESTRUTURAS DE DADOS I'
);

-- Questão 3
select distinct pr.cod_disc_pre, count(pr.cod_disc)
from pre_requisitos pr
group by pr.cod_disc_pre
order by count(pr.cod_disc) desc;

-- Questão 4
select d.cod_disc, d.nom_disc from disciplinas d where d.cod_disc in (
	select d.cod_disc from disciplinas d
	inner join (
		select distinct pr.cod_disc_pre, count(pr.cod_disc)
		from pre_requisitos pr
		group by pr.cod_disc_pre
		order by count(pr.cod_disc) desc
		limit 1
	)
	on d.cod_disc = cod_disc_pre
);

-- Questão 5
select c.nom_curso, 
	(select count(a.cod_curso) from alunos a where a.cod_curso = c.cod_curso) 
from cursos c order by c.cod_curso desc;

-- Questão 6
select a.mat_alu, a.nom_alu from alunos a where a.mat_alu in (
	select tm.mat_alu from turmas_matriculadas tm where tm.cod_disc in (
		select t.cod_disc from turmas t where t.cod_disc in (
			select d.cod_disc from disciplinas d
			where d.qtd_cred > 5
		)
	)
);

-- Questão 7
select a.mat_alu, a.nom_alu from alunos a where a.mat_alu not in (
	select tm.mat_alu from turmas_matriculadas tm where tm.turma in (
		select t.turma from turmas t where t.ano between 2022 and 2024
	)
);

-- Questão 8
select distinct a.mat_alu, a.nom_alu from alunos a where a.mat_alu in (
	select he.mat_alu from historicos_escolares he where he.faltas > 3
);

-- Questão 9
select distinct a.mat_alu, a.nom_alu from alunos a where a.mat_alu in (
	select he.mat_alu from historicos_escolares he where he.media > 7
);

-- Questão 10
select a.mat_alu, a.nom_alu from alunos a where a.mat_alu in (
	select tm.mat_alu from turmas_matriculadas tm where tm.cod_disc in (
		select d.cod_disc from disciplinas d where d.cod_disc in (
			select t.cod_disc from turmas t where t.cod_prof in (
				select distinct p.cod_prof from professores p
			)
		)
	)
);

-- Questão 11
select a.mat_alu, a.nom_alu from alunos a where a.mat_alu in (
	select tm.mat_alu from turmas_matriculadas tm where tm.turma in (
		select t.turma from turmas t where t.cod_prof in (
			select p.cod_prof from professores p where p.nom_prof like 'João Silva'
		)
	)
);