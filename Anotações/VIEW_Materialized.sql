create materialized view filmes_locacao_view
as
	select titulo, taxa_aluguel
	from filme
	order by titulo asc;

select * from filmes_locacao_view;

select * from filme;

insert into filme(titulo, descricao, ano_lancamento, idioma, duracao_aluguel, taxa_aluguel, tamanho, custo_reposicao, taxa, ultima_atualizacao, caracteristicas_especiais)
values('Thor', 'Um super-héroi do trovão...', '2014-03-12', 2, 5, 3, 120, 50, 4, null, 'Filme');

refresh materialized view filmes_locacao_view;