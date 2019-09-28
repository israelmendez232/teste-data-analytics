-- Em apenas UMA query.
SELECT 
    ((f.custo_frete / (p.peso_unitario * f.quantidade)) * p.peso_unitario) AS "Regra de Rateio",
    SUM(r.custo_frete) AS "Custo Total de Frete Gasto"
FROM faturamento f
JOIN familiasetor s 
ON f.sku = s.sku
JOIN peso_unitario p
ON s.sku = p.sku
JOIN frete r
ON f.uf_entrega = r.uf_entrega
WHERE dia_emissao_nota LIKE '%2018%'
AND s.setor = 'alimentos'
