SELECT * FROM avaliacoes;


SELECT hospedagem_id, nota,
CASE nota
        WHEN  5 THEN 'Excelente'
        WHEN  4 THEN 'Ótimo'
        WHEN  3 THEN 'Muito Bom'
        WHEN  2 THEN 'Bom'
        ELSE 'Ruim'
END AS StatusNota
FROM avaliacoes;

SELECT 
    CASE nota
        WHEN 5 THEN 'Excelente'
        WHEN 4 THEN 'Ótimo'
        WHEN 3 THEN 'Muito Bom'
        WHEN 2 THEN 'Bom'
        ELSE 'Ruim'
    END AS StatusNota,
    COUNT(*) AS Quantidade
FROM avaliacoes
GROUP BY StatusNota
ORDER BY Quantidade DESC;