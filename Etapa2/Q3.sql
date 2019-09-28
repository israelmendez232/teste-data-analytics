SELECT 
    CAST (
        CASE
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 1 THEN 'Janeiro'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 2 THEN 'Fevereiro'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 3 THEN 'Março'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 4 THEN 'Abril'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 5 THEN 'Maio'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 6 THEN 'Junho'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 7 THEN 'Julho'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 8 THEN 'Agosto'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 9 THEN 'Setembro'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 10 THEN 'Outubro'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 11 THEN 'Novembro'
            WHEN EXTRACT(MONTH FROM dia_emissao_nota) = 12 THEN 'Dezembro'
            ELSE NULL
        END AS Text
    ) AS "Mês/2018",
    100 * (SUM(receita) - lag(SUM(receita), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota))) / lag(EXTRACT(MONTH FROM dia_emissao_nota), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota)) || '%' AS "% de Vendas por Mês/2018"
    100 * (SUM(receita) - lag(SUM(receita), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota))) / lag(EXTRACT(MONTH FROM dia_emissao_nota), 1) over (order by EXTRACT(MONTH FROM dia_emissao_nota)) || '%' AS "% de Vendas no Mesmo Mês/2017"
FROM faturamento 
WHERE dia_emissao_nota LIKE '%2018%'
