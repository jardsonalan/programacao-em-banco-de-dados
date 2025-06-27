-- Questão 3
create or replace procedure crud_filme(id integer, titulo_filme text, desc_filme text, ano_filme date, dur_aluguel integer, tx_aluguel integer, tam integer, custo_repo integer, tx integer, caract_esp text, id_idioma integer, opcao integer)
as $$
	begin
		if (opcao = -1) then
			delete from categoria_filme cf
			where cf.filme_id = id;
		
			delete from ator_filme af
			where af.filme_id = id;
		
			delete from filme f
			where f.filme_id = id;
		elsif (opcao = 0) then
			update filme
			set titulo = titulo_filme
			where filme_id = id;
		elsif (opcao = 1) then
			insert into filme(titulo, descricao, ano_lancamento, idioma, duracao_aluguel, taxa_aluguel, tamanho, custo_reposicao, taxa, caracteristicas_especiais)
			values(titulo_filme, desc_filme, ano_filme, id_idioma, dur_aluguel, tx_aluguel, tam, custo_repo, tx, caract_esp);
		else
			raise exception 'Opção inválida. Use -1 (delete), 0 (update) ou 1 (insert).';
		end if;
	end;
$$ language plpgsql;

call crud_filme(14, 'Turma da Mônica'::text, 'Filme infântil'::text, '2020-01-01'::date, 2, 4, 120, 3, 2, 'Crianças'::text, 6, 1);

-- Questão 4
-- Aluguel
create or replace procedure crud_aluguel(alu_id integer, funcio_id integer, cli_id integer, inven_id integer, opcao integer)
as $$
	begin
		if (opcao = -1) then
			delete from aluguel
			where aluguel_id = alu_id;
		elsif (opcao = 0) then
			update aluguel
			set cliente_id = cli_id
			where aluguel_id = alu_id;
		elsif (opcao = 1) then
			insert into aluguel(funcionario_id, cliente_id, inventario_id)
			values(funcio_id, cliente_id, inven_id);
		else
			raise exception 'Opção inválida. Use -1 (delete), 0 (update) ou 1 (insert).';
		end if;
	end;
$$ language plpgsql;

call crud_aluguel(3, 1, 3, null, 0);

-- Inventário
create or replace procedure crud_inventario(inven_id integer, film_id integer, loj_id integer, opcao integer)
as $$
	begin
		if (opcao = -1) then
			delete from inventario
			where inventario_id = inven_id;
		elsif (opcao = 0) then
			update inventario
			set filme_id = film_id
			where inventario_id = inven_id;
		elsif (opcao = 1) then
			insert into inventario(filme_id, loja_id)
			values(film_id, loj_id);
		else
			raise exception 'Opção inválida. Use -1 (delete), 0 (update) ou 1 (insert).';
		end if;
	end;
$$ language plpgsql;

call crud_inventario(2, 5, 1, -1);

-- Funcionário
create or replace procedure crud_funcionario(func_id integer, nom text, sobrenom text, end_id integer, emai text, ativ boolean, loj_id integer, geren boolean, logi text, senh text, ft bytea, opcao integer)
as $$
	begin
		if (opcao = -1) then
			delete from funcionario
			where funcionario_id = func_id;
		elsif (opcao = 0) then
			update funcionario
			set nome = nom, sobrenome = sobrenom
			where funcionario_id = func_id;
		elsif (opcao = 1) then
			insert into funcionario(nome, sobrenome, endereco_id, email, ativo, loja_id, gerente, login, senha, foto)
			values(nom, sobrenom, end_id, emai, ativ, loj_id, geren, logi, senh, ft);
		else
			raise exception 'Opção inválida. Use -1 (delete), 0 (update) ou 1 (insert).';
		end if;
	end;
$$ language plpgsql;

call crud_funcionario(5, 'Jardson'::text, 'Alan'::text, 3, 'jardson@email.com'::text, true, 1, true, 'jardson'::text, '123'::text, null::bytea, 0);

-- Cliente
create or replace procedure crud_cliente(clien_id integer, loj_id integer, nom text, sobrenom text, emai text, end_id integer, ativ boolean, dat_criacao date, opcao integer)
as $$
	begin
		if (opcao = -1) then
			delete from cliente
			where cliente_id = clien_id;
		elsif (opcao = 0) then
			update cliente
			set nome = nom, sobrenome = sobrenom, email = emai
			where cliente_id = clien_id;
		elsif (opcao = 1) then
			insert into cliente(loja_id, nome, sobrenome, email, endereco_id, ativo, data_criacao)
			values(loj_id, nom, sobrenom, emai, end_id, ativ, dat_criacao);
		else
			raise exception 'Opção inválida. Use -1 (delete), 0 (update) ou 1 (insert)';
		end if;
	end;
$$ language plpgsql;

call crud_cliente(4, 1, 'Jardson'::text, 'Alan'::text, 'jardson@email.com'::text, 2, true, '2024-01-01'::date, 1);

-- Questão 5
create or replace function update_time() returns trigger
as $$
	begin
		new.ultima_atualizacao := now();
		return new;
	end;
$$ language plpgsql;

create trigger log_insert_filme before insert on filme
for each row execute function update_time();
create trigger log_update_filme before update on filme
for each row execute function update_time();

create trigger log_insert_aluguel before insert on aluguel
for each row execute function update_time();
create trigger log_update_aluguel before update on aluguel
for each row execute function update_time();

create trigger log_insert_inventario before insert on inventario
for each row execute function update_time();
create trigger log_update_inventario before update on inventario
for each row execute function update_time();

create trigger log_insert_funcionario before insert on funcionario
for each row execute function update_time();
create trigger log_update_funcionario before update on funcionario
for each row execute function update_time();

create trigger log_insert_cliente before insert on cliente
for each row execute function update_time();
create trigger log_update_cliente before update on cliente
for each row execute function update_time();

update filme
set titulo = 'Turma da Mônica'
where filme_id = 14;