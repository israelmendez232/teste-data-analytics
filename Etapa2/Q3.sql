-- Escreva uma única consulta que apresente o crescimento percentual de vendas  em relação  ao último mês para todos os meses a partir de 2018. Apresente também a variação em relação ao mesmo mês do ano anterior para todos os meses.
SELECT Período as "Período", Mês_Passado AS "% de Vendas por Mês/2018", Ano_Passado AS "% de Vendas no Mesmo Mês/2017"
FROM (
    SELECT Período,
    100 * (Receita - LAG(Receita, 1) OVER (ORDER BY Período)) / lag(Receita, 1) OVER (ORDER BY Período) || '%' AS Mês_Passado,
    100 * (Receita - LAG(Receita, 12) OVER (ORDER BY Período)) / lag(Receita, 12) OVER (ORDER BY Período) || '%' AS Ano_Passado
    FROM (
        SELECT SUM(receita) as Receita, TO_CHAR(dia_emissao_nota, 'YYYY-MM') as Período
        FROM faturamento
        GROUP BY TO_CHAR(dia_emissao_nota, 'YYYY-MM')
        ORDER BY TO_CHAR(dia_emissao_nota, 'YYYY-MM')
    ) f
    GROUP BY Período, Receita
) t
WHERE Período LIKE '2018%'
