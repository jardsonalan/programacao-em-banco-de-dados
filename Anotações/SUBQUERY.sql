-- distinct: evita mostra registros repetidos
-- exists: serve para observar se um registro existe
	-- not exists: serve para observar se um registro NÃO existe
select nome, sobrenome from cliente
where not exists (select 1 from aluguel where cliente.cliente_id = aluguel.cliente_id);

-- in: verifica se os registros são iguais
	-- not in: verifica se os registros NÃO são iguais
select nome from cliente
where cliente.cliente_id not in (select cliente_id from aluguel where aluguel.data_aluguel > '2025-04-01' and aluguel.data_aluguel < '2025-04-10');

-- any/some: verifica se existe igualdade com qualquer outro registro