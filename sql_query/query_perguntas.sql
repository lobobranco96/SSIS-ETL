-- 1 - Qual a escola com a maior média de notas?

SELECT TOP 1
    de.CO_MUNICIPIO_ESC, 
    de.NO_MUNICIPIO_ESC,
    de.CO_UF_ESC,
    de.SG_UF_ESC,
    CASE de.TP_DEPENDENCIA_ADM_ESC
        WHEN 1 THEN 'Federal'
        WHEN 2 THEN 'Estadual'
        WHEN 3 THEN 'Municipal'
        WHEN 4 THEN 'Privada'
        ELSE 'Outra' 
    END AS 'Dependencia Admnistrativa',
    CASE de.TP_LOCALIZACAO_ESC
        WHEN 1 THEN 'Urbana'
        WHEN 2 THEN 'Rural'
        ELSE 'Outra' 
    END AS 'Localização Escola',
    AVG(CAST(dpo.NU_NOTA_CN AS DECIMAL(10, 2)) + 
        CAST(dpo.NU_NOTA_CH AS DECIMAL(10, 2)) + 
        CAST(dpo.NU_NOTA_LC AS DECIMAL(10, 2)) + 
        CAST(dpo.NU_NOTA_MT AS DECIMAL(10, 2)) + 
        CAST(dr.NU_NOTA_REDACAO AS DECIMAL(10, 2))) / 5.0 AS MEDIA_TOTAL
FROM fato_identificadores fi
INNER JOIN dim_escola de ON de.ID_ESCOLA = fi.ID_ESCOLA
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO
GROUP BY 
    de.CO_MUNICIPIO_ESC, 
    de.NO_MUNICIPIO_ESC,
    de.CO_UF_ESC,
    de.SG_UF_ESC,
    de.TP_DEPENDENCIA_ADM_ESC,
    de.TP_LOCALIZACAO_ESC
ORDER BY MEDIA_TOTAL DESC;


-- 2 - Os 10 alunos com a maior média de notas e o valor dessa média?

SELECT TOP 10
    dp.NU_INSCRICAO, 
    dpo.NU_NOTA_CN AS 'Nota Ciências da Natureza',
    dpo.NU_NOTA_CH AS 'Nota Ciências Humanas',
    dpo.NU_NOTA_LC AS 'Nota Linguagens e Códigos',
    dpo.NU_NOTA_MT AS 'Nota Matemática',
    dr.NU_NOTA_REDACAO AS 'Nota Redação',
    (AVG(dpo.NU_NOTA_CN + dpo.NU_NOTA_CH + dpo.NU_NOTA_LC + dpo.NU_NOTA_MT + dr.NU_NOTA_REDACAO) / 5) AS MEDIA_TOTAL
FROM fato_identificadores fi
INNER JOIN dim_participante dp ON dp.ID_PARTICIPANTE = fi.ID_PARTICIPANTE
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO
GROUP BY dp.NU_INSCRICAO, dpo.NU_NOTA_CH, dpo.NU_NOTA_CN, dpo.NU_NOTA_LC, dpo.NU_NOTA_MT, dr.NU_NOTA_REDACAO
ORDER BY MEDIA_TOTAL DESC;


-- 3 - Qual a média geral?

SELECT
    AVG(CONVERT(FLOAT, dpo.NU_NOTA_CN) + CONVERT(FLOAT, dpo.NU_NOTA_CH) + 
        CONVERT(FLOAT, dpo.NU_NOTA_LC) + CONVERT(FLOAT, dpo.NU_NOTA_MT) + 
        CONVERT(FLOAT, dr.NU_NOTA_REDACAO)) / 5 AS MEDIA_GERAL
FROM fato_identificadores fi
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO
ORDER BY MEDIA_GERAL DESC;


-- 4 - Qual o % de Ausentes?

SELECT 
    FORMAT(SUM(CASE WHEN dpo.TP_PRESENCA_CN = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 'N2') AS 'Ciencias da Natureza % Ausentes',
    FORMAT(SUM(CASE WHEN dpo.TP_PRESENCA_CH = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 'N2') AS 'Ciencias Humanas % Ausentes',
    FORMAT(SUM(CASE WHEN dpo.TP_PRESENCA_LC = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 'N2') AS 'Linguagens e Códigos % Ausentes',
    FORMAT(SUM(CASE WHEN dpo.TP_PRESENCA_MT = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 'N2') AS 'Matemática % Ausentes'
FROM fato_identificadores fi
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA;


-- 5 - Qual o número total de Inscritos?

SELECT
	COUNT(dpo.ID_PARTICIPANTE) AS 'Total Inscritos'
FROM fato_identificadores fi
INNER JOIN dim_participante dpo ON dpo.ID_PARTICIPANTE = fi.ID_PARTICIPANTE


-- 6 Qual a média por disciplina?

SELECT TOP 1
    AVG(dpo.NU_NOTA_CN) AS 'Media Ciências da Natureza',
    AVG(dpo.NU_NOTA_CH) AS 'Media Ciências Humanas',
    AVG(dpo.NU_NOTA_LC) AS 'Media Linguangens e Códigos',
    AVG(dpo.NU_NOTA_MT) AS 'Media Matemática',
    AVG(dr.NU_NOTA_REDACAO) AS 'Media Redação'
FROM fato_identificadores fi
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO

-- 7 - Qual a média por Sexo?

SELECT 
    CASE dp.TP_SEXO
        WHEN 'F' THEN 'Feminino'
        WHEN 'M' THEN 'Masculino'
        ELSE dp.TP_SEXO -- Tratamento para outros valores, se necessário
    END AS 'Sexo do Participante',
    COUNT(*) AS 'Quantidade',
    AVG(dpo.NU_NOTA_CN) AS 'Media Ciências da Natureza',
    AVG(dpo.NU_NOTA_CH) AS 'Media Ciências Humanas',
    AVG(dpo.NU_NOTA_LC) AS 'Media Linguagens e Códigos',
    AVG(dpo.NU_NOTA_MT) AS 'Media Matemática',
    AVG(dr.NU_NOTA_REDACAO) AS 'Media Redação'
FROM fato_identificadores fi
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO
INNER JOIN dim_participante dp ON dp.ID_PARTICIPANTE = fi.ID_PARTICIPANTE
GROUP BY dp.TP_SEXO;


-- 8 - Qual a média por Etnia?

SELECT 
    CASE dp.TP_COR_RACA 
        WHEN 0 THEN 'Não declarado'
        WHEN 1 THEN 'Branca'
        WHEN 2 THEN 'Preta'
        WHEN 3 THEN 'Parda'
        WHEN 4 THEN 'Amarela'
        WHEN 5 THEN 'Indígena'
        ELSE 'Outra' -- Se houver algum valor não esperado, pode ser tratado como 'Outra' ou conforme necessário
    END AS 'Etnia do Participante',
    COUNT(*) AS 'Quantidade',
    AVG(dpo.NU_NOTA_CN) AS 'Media Ciências da Natureza',
    AVG(dpo.NU_NOTA_CH) AS 'Media Ciências Humanas',
    AVG(dpo.NU_NOTA_LC) AS 'Media Linguagens e Códigos',
    AVG(dpo.NU_NOTA_MT) AS 'Media Matemática',
    AVG(dr.NU_NOTA_REDACAO) AS 'Media Redação'
FROM fato_identificadores fi
INNER JOIN dim_prova_objetiva dpo ON dpo.ID_PROVA_OBJETIVA = fi.ID_PROVA_OBJETIVA
INNER JOIN dim_redacao dr ON dr.ID_REDACAO = fi.ID_REDACAO
INNER JOIN dim_participante dp ON dp.ID_PARTICIPANTE = fi.ID_PARTICIPANTE
GROUP BY dp.TP_COR_RACA
ORDER BY dp.TP_COR_RACA;

