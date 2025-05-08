-- Inner join: Retorna o que está dentro das duas tabelas
select filme.titulo, idioma.nome from filme
	inner join idioma
	on filme.idioma = idioma.idioma_id;

-- Left join: Retorna tudo que está na tabela da esquerda
select filme.titulo, idioma.nome from idioma
	left join filme
	on filme.idioma = idioma.idioma_id;

-- Full Outer Join: Retorna tudo que está nas duas tabelas
select filme.titulo, idioma.nome from idioma
	full outer join filme
	on filme.idioma = idioma.idioma_id;

-- Union: Exibe a união de duas tabelas, sem repetir as linhas
-- Union All: Permite exibir todas as linhas, mesmo que elas estejam repetidas
select nome, sobrenome from funcionario
union
select nome, sobrenome from ator
order by nome;

-- Cross Join: Faz o produto cartesiano entre duas tabelas
select filme.titulo, idioma.nome from filme
	cross join idioma
	order by filme.titulo;