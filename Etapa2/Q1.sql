-- Escreva uma única consulta que apresente a quantidade total de SKUs distintos comprados em 2018 na família "Cachorros"  e também o total de SKUs distintos comprados em cada mês em 2018 na família "Cachorros".
SELECT DISTINCT COUNT(f.sku) AS "Total SKUs", TO_CHAR(f.dia_emissao_nota, 'YYYY') as "Período"
FROM faturamento f
JOIN familiasetor s
ON f.sku = s.sku
WHERE s.familia = 'Cachorros'
AND EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY')

UNION

SELECT DISTINCT COUNT(f.sku) AS "Total SKUs", TO_CHAR(f.dia_emissao_nota, 'YYYY-MM') as "Período"
FROM faturamento f
JOIN familiasetor s
ON f.sku = s.sku
WHERE EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
AND s.familia = 'Cachorros'
GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY-MM')
