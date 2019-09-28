-- Pegar o percentual total e dividir pelo percentual por linha.
SELECT s.familia, (SUM(f.receita) / (
    SELECT SUM(receita) as Total
    FROM faturamento
    WHERE dia_emissao_nota LIKE '%2018%'
))
FROM familiasetor s
JOIN faturamento f
ON s.sku = f.sku
WHERE f.dia_emissao_nota LIKE '%2018%'
OR s.familia = 'Cachorros'
OR s.familia = 'Gato'
OR s.familia = 'Peixes'
