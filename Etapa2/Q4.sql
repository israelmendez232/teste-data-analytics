-- Escreva uma única consulta que apresente o percentual de vendas das famílias Cachorros, Gato e Peixes em relação ao total para todos os meses em 2018.
SELECT f.Período, c.Cachorros, g.Gatos, p.Peixes
FROM (
    SELECT TO_CHAR(dia_emissao_nota, 'YYYY-MM') as Período
    FROM faturamento
    WHERE EXTRACT(YEAR FROM dia_emissao_nota) = '2018'
    GROUP BY TO_CHAR(dia_emissao_nota, 'YYYY-MM')
    ORDER BY TO_CHAR(dia_emissao_nota, 'YYYY-MM')
) f
JOIN (
    SELECT 
        100 * (SUM(f.receita) / (
            SELECT SUM(receita) as Total
            FROM faturamento
            WHERE EXTRACT(YEAR FROM dia_emissao_nota) = '2018'
        )) || '%' as Gatos, 
        TO_CHAR(f.dia_emissao_nota, 'YYYY-MM') as Período
    FROM familiasetor s
    JOIN faturamento f
    ON s.sku = f.sku
    WHERE EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
    AND s.familia = 'Gatos'
    GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY-MM')
) g
ON f.Período = g.Período
JOIN (
    SELECT 
        100 * (SUM(f.receita) / (
            SELECT SUM(receita) as Total
            FROM faturamento
            WHERE EXTRACT(YEAR FROM dia_emissao_nota) = '2018'
    )) || '%' as Cachorros, 
        TO_CHAR(f.dia_emissao_nota, 'YYYY-MM') as Período
    FROM familiasetor s
    JOIN faturamento f
    ON s.sku = f.sku
    WHERE EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
    AND s.familia = 'Cachorros'
    GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY-MM')
) c
ON g.Período = c.Período
JOIN (
    SELECT 
        100 * (SUM(f.receita) / (
            SELECT SUM(receita) as Total
            FROM faturamento
            WHERE EXTRACT(YEAR FROM dia_emissao_nota) = '2018'
    )) || '%' as Peixes, 
        TO_CHAR(f.dia_emissao_nota, 'YYYY-MM') as Período
    FROM familiasetor s
    JOIN faturamento f
    ON s.sku = f.sku
    WHERE EXTRACT(YEAR FROM f.dia_emissao_nota) = '2018'
    AND s.familia = 'Peixes'
    GROUP BY TO_CHAR(f.dia_emissao_nota, 'YYYY-MM')
) p
ON c.Período = p.Período
