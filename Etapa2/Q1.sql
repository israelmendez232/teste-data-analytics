-- Em apenas UMA query.
SELECT DISTINCT COUNT(sku) AS "Total de SKUs"
FROM faturamento f
JOIN familiasetor s
ON f.sku = s.sku
WHERE f.dia_emissao_nota LIKE '%2018%'
AND s.familia = 'Cachorros'

UNION

SELECT DISTINCT COUNT(sku) AS "Total de SKUs", TO_CHAR(dia_emissao_nota, 'YYYY-MM') as "Período"
FROM faturamento f
JOIN familiasetor s
ON f.sku = s.sku
WHERE f.dia_emissao_nota LIKE '%2018%'
AND s.familia = 'Cachorros'
GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY-MM')
