-- Pegar o percentual total e dividir pelo percentual por linha.
SELECT s.setor, 100 * (SUM(f.receita) / (
    SELECT SUM(receita) as Total
    FROM faturamento
    WHERE EXTRACT(YEAR FROM dia_emissao_nota) = '2018'
)) || '%' as "% de Vendas"
FROM familiasetor s
JOIN faturamento f
ON s.sku = f.sku
WHERE EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
OR s.setor = 'Cachorros'
OR s.setor = 'Gato'
OR s.setor = 'Peixes'
GROUP BY s.setor
