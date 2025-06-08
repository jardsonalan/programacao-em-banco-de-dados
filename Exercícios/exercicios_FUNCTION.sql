-- Questão  1
create or replace function consulta_aluno(nome_aluno text) returns table(nome_curso text, total_credito integer, media decimal)
as $$
	select c.nom_curso, a.tot_cred, a.mgp from alunos a
	inner join cursos c
	on a.cod_curso = c.cod_curso
	where a.nom_alu ilike '%' || nome_aluno || '%';
$$ language sql;

select consulta_aluno('Ben');

-- Questão 2
create or replace function codigo_disciplina(nome_disciplina text) returns table(codigo_disciplina integer)
as $$
	select d.cod_disc from disciplinas d
	where d.nom_disc ilike '%' || nome_disciplina || '%';
$$ language sql;

select codigo_disciplina('Intr');

-- Questão 3
create or replace function codigo_curso(nome_curso text) returns table(codigo_curso integer)
as $$
	select c.cod_curso from cursos c
	where c.nom_curso ilike '%' || nome_curso || '%';
$$ language sql;

select codigo_curso('Ciencias Econ');

-- Questão 4
create or replace function pre_requisitos(codigo_disciplina integer) returns table(pre_requisitos text)
as $$
	select d.nom_disc from disciplinas d where d.cod_disc in (
		select pr.cod_disc_pre from pre_requisitos pr
		where pr.cod_disc = codigo_disciplina
	);
$$ language sql;

select pre_requisitos(200746);

-- Questão 5 - Lógica inversa da questão 4
create or replace function disciplinas_dependentes(codigo_disciplina integer) returns table(disciplinas_dependentes text)
as $$
	select d.nom_disc from disciplinas d where d.cod_disc in (
		select pr.cod_disc from pre_requisitos pr
		where pr.cod_disc_pre = codigo_disciplina
	);
$$ language sql;

select disciplinas_dependentes(200657);

-- Questão 7
create or replace function migra_curso(codigo_origem integer, novo_codigo integer) returns void
as $$
	declare
		coordenador_id int; -- Variável que armazena o cod_coord
	begin
		-- Serve para verificar se o código de origem não corresponde a nenhum cod_curso
		if not exists (select 1 from cursos where cod_curso = codigo_origem) then
			raise exception 'Curso de origem não encontrado.'; -- Exibe uma exceção
		end if;

		-- Serve para verificar se o novo código não corresponde a nenhum cod_curso
		if not exists (select 1 from cursos where cod_curso = novo_codigo) then
			raise exception 'Curso de destino não encontrado.'; -- Exibe um exceção
		end if;

		-- Seleciona o valor do cod_coord que está presente no curso com o cod_curso igual o código de origem
		-- E armazena o valor na variável coordenador_id
		select cod_coord into coordenador_id from cursos where cod_curso = codigo_origem;

		-- Atualiza o cod_curso antigo, na tabela professores, para o código do novo curso
		update professores
		set cod_curso = novo_codigo
		where cod_curso = codigo_origem;

		-- Atualiza o cod_curso antigo, na tabela alunos, para o código do novo curso
		update alunos
		set cod_curso = novo_codigo
		where cod_curso = codigo_origem;

		-- Verifica se o cod_prof é igual ao valor do coordenador_id
		-- E verifica se o cod_curso do professor é igual ao código do novo curso
		if exists (select 1 from professores where cod_prof = coordenador_id and cod_curso = novo_codigo) then
			-- Alterar o valor do cod_coord para null, no curso antigo
			-- Serve para evitar o erro de duplicidade de chaves na tabela
			update cursos
			set cod_coord = null
			where cod_curso = codigo_origem;

			-- Adiciona o valor do cod_coord que estava no curso antigo, no cod_coord do novo curso
			update cursos 
			set cod_coord = coordenador_id
			where cod_curso = novo_codigo;
		end if;
	end;
$$ language plpgsql;

select migra_curso(3, 4);