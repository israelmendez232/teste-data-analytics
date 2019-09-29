SELECT TO_CHAR(dia_emissao_nota, 'YYYY') as "Período" AS "Mês/2018",
    100 * (SUM(receita) - lag(SUM(receita), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota))) / lag(EXTRACT(MONTH FROM dia_emissao_nota), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota)) || '%' AS "% de Vendas por Mês/2018"
    100 * (SUM(receita) - lag(SUM(receita), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota))) / lag(EXTRACT(MONTH FROM dia_emissao_nota), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota)) || '%' AS "% de Vendas no Mesmo Mês/2017"
FROM faturamento 
-- WHERE dia_emissao_nota LIKE '%2018%'
