-- Questão 1
select * from cliente;
select * from aluguel;

-- Inner Join
select cliente.nome, cliente.sobrenome from cliente
	inner join aluguel
	on cliente.cliente_id = aluguel.cliente_id;

-- Left Join
select cliente.nome, cliente.sobrenome from cliente
	left join aluguel
	on cliente.cliente_id = aluguel.cliente_id;

-- Right Join
select cliente.nome, cliente.sobrenome from cliente
	right join aluguel
	on cliente.cliente_id = aluguel.cliente_id;

-- Questão 2
select * from filme;
select * from idioma;

select filme.titulo, idioma.nome from filme
	inner join idioma
	on filme.idioma = idioma.idioma_id;

-- Questão 3
select * from funcionario;
select * from loja;

select funcionario.nome, loja.loja_id from funcionario
	inner join loja
	on funcionario.loja_id = loja.loja_id;

-- Questão 4
select * from filme;

select cliente.nome, filme.titulo from cliente
	inner join aluguel on aluguel.cliente_id = cliente.cliente_id
	inner join inventario on inventario.inventario_id = aluguel.inventario_id
	inner join filme on filme.filme_id = inventario.filme_id;

-- Questão 5
select filme.titulo from filme
	inner join inventario on inventario.filme_id = filme.filme_id
	where inventario.inventario_id not in (select aluguel.inventario_id from aluguel);

-- Questão 6
select * from filme
	full outer join categoria_filme on filme.filme_id = categoria_filme.filme_id
	full outer join categoria on categoria.categoria_id = categoria_filme.categoria_id;
	
select cliente.nome, cidade.cidade from cliente
	inner join endereco on endereco.endereco_id = cliente.endereco_id
	inner join cidade on cidade.cidade_id = endereco.cidade_id;

select categoria.nome, filme.titulo from categoria
	inner join categoria_filme on categoria_filme.categoria_id = categoria.categoria_id
	inner join filme on filme.filme_id = categoria_filme.filme_id;

select * from aluguel;