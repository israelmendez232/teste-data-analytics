-- Escreva uma única consulta que aplique a regra de rateio do frete definida com a àrea de negócio e apresente o custo total de frete gasto no Setor "Alimentos".
-- ***Regra rateio = (Custo de frete / Peso total) *  Peso unitário

SELECT 
	ROUND((Custo_Frete / Peso_Unitario * Quantidade) * Peso_Unitario, 2) AS "Regra de Rateio",
	ROUND((
		SELECT SUM(r.custo_frete)
		FROM faturamento f
		JOIN familiasetor s 
		ON f.sku = s.sku
		JOIN frete r
		ON f.uf_entrega = r.uf_entrega
		WHERE s.setor = 'Alimentos'
	), 2) AS "Custo Total do Frete no Setor de Alimentos"
FROM (
	SELECT (
		SELECT AVG(custo_frete)
		FROM frete
	) as Custo_Frete,
	(
		SELECT AVG(peso_unitario)
		FROM peso_unitario
	) as Peso_Unitario,
	(
		SELECT AVG(quantidade)
		FROM faturamento
	) as Quantidade
) r
