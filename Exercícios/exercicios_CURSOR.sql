-- Questão 1
create or replace function abaixoMedia() returns void
as $$
	declare
		notas cursor for select distinct he.mat_alu from historicos_escolares he where he.media < 6 order by he.mat_alu asc;
	begin
		for nota in notas loop
			raise notice 'Matrícula: %', nota.mat_alu;
		end loop;
	end;
$$ language plpgsql;

select abaixoMedia();

-- Questão 2
create or replace function adicionarCoordenador() returns void
as $$
	declare
		coordenadores cursor for select p.cod_prof, p.cod_curso from professores p where p.cod_curso in (
			select c.cod_curso from cursos c where c.cod_coord is null
		) order by p.cod_prof asc limit 1;
	begin
		for coordenador in coordenadores loop
			update cursos
			set cod_coord = coordenador.cod_prof
			where cod_curso = coordenador.cod_curso;
		end loop;
	end;
$$ language plpgsql;

select adicionarCoordenador();