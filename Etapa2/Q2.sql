-- Em apenas UMA query.
/* SELECT 
    p.sku,
    (r.custo_frete / p.peso_unitario * f.quantidade) * p.peso_unitario AS "Regra de Rateio"
FROM faturamento f
JOIN familiasetor s 
ON f.sku = s.sku
JOIN peso_unitario p
ON f.sku = p.sku
JOIN frete r
ON f.uf_entrega = r.uf_entrega
WHERE s.setor = 'Alimentos'
GROUP BY r.custo_frete, p.peso_unitario, f.quantidade

UNION 
*/

-- Funcionando
SELECT SUM(r.custo_frete) AS "Custo Total do Frete"
FROM faturamento f
JOIN familiasetor s 
ON f.sku = s.sku
JOIN frete r
ON f.uf_entrega = r.uf_entrega
WHERE s.setor = 'Alimentos'
