-- Serve para criar um novo aluno na tabela
create or replace procedure cadastrar_aluno (
	nome_aluno text,
	email_aluno text,
	matricula_aluno int,
	nascimento timestamp,
	cred int,
	mgp numeric
)
language sql as $$
	insert into alunos(nom_alu, email, mat_alu, dat_nasc, tot_cred, mgp)
	values (nome_aluno, email_aluno, matricula_aluno, nascimento, cred, mgp);
$$;

call cadastrar_aluno('Eliezio', 'eliezio@gmail.com', 2221133, '1989-10-10', 100, 5.5);

-- Serve para renomear um dado de um aluno
create or replace procedure renomear_aluno(matricula integer, nome text)
language sql as $$
	update alunos
	set nom_alu = nome
	where mat_alu = matricula
$$;

call renomear_aluno(911113, 'GARRINCHA');

select * from alunos;