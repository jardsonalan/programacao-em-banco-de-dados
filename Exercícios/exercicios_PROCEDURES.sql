-- Questão 1
create or replace procedure recalcular_media(matricula int, codigo_disc int)
language sql as $$
	select tm.nota_1, tm.nota_2, tm.nota_3, tm.nota_4 from turmas_matriculadas tm
	where tm.mat_alu = matricula and tm.cod_disc = codigo_disc;
$$;

-- Questão 2
create or replace procedure excluir_aluno(matricula_aluno integer)
language sql as $$
	delete from turmas_matriculadas
	where mat_alu = matricula_aluno;

	delete from historicos_escolares
	where mat_alu = matricula_aluno;

	delete from alunos
	where mat_alu = matricula_aluno;
$$;

call excluir_aluno(2221133);

select * from historicos_escolares;
select * from alunos;
select * from turmas_matriculadas;