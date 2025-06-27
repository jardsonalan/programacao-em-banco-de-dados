-- Retorna a idade
select age(now(), timestamp '1989-10-10');

-- Retorna a data
select current_date;

-- Retorna a hora
select current_time;

-- Retorna a data e hora
select current_timestamp;

-- Retorna uma parte de uma hora
select date_part('MINUTE', now());

-- Serve para somar dois valores
create function add(integer, integer) returns integer as '
	select $1 + $2;
' language sql
immutable
returns null on null input;

select add(1, 2);

-- Função com linguagem plpgsql
-- Serve para incrementar 1 ao valor fornecido
create or replace function increment(i integer) returns integer as $$
	begin
		return i + 1;
	end;
$$ language plpgsql;

select increment(1);

-- Serve para retornar um aluno através de sua matrícula
create or replace function select_alunos(mat integer) returns alunos as $$
	select * from alunos where mat_alu = mat;
$$ language sql;

select select_alunos(911094);

-- Serve para retornar apenas o nome de um aluno
create or replace function nome_alunos(mat integer) returns text as $$
	select nom_alu from alunos where mat_alu = mat;
$$ language sql;

select nome_alunos(911094);

create or replace function insert_alunos(cod_curso integer, dat_nasc date, tot_cred int, mgp numeric, nom_alu text, email text) returns int as $$
	insert into alunos(cod_curso, dat_nasc, tot_cred, mgp, nom_alu, email)
	values (cod_curso, dat_nasc, tot_cred, mgp, nom_alu, email)
	returning mat_alu;
$$ language sql;

create or replace function registrar_media_aluno(nome text, n1 numeric, n2 numeric, n3 numeric, n4 numeric) returns void
as $$
	declare 
		id integer;
		media numeric;

	begin 
		media := (n1+n2+n3+n4)/4;

		select mat_alu into id from alunos where nom_alu ilike '%'|| nome ||'%';

		if not found then
			raise exception 'não foi encontrado o(a) aluno %', nome;
		else
			update alunos
				set mgp = media
			where mat_alu = id;
		end if;
	end;
$$ language plpgsql;