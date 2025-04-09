-- questão 1: 
-- utiliza LEFT OUTER JOIN para incluir instrutores que não ministraram nenhuma seção

SELECT --a consulta mostrará:
    i.ID,                     -- ID do instrutor
    i.name,                   -- nome do instrutor
    COUNT(t.course_id) AS num_sections  -- número de seções ministradas (0 se não ministrou)
FROM --tirando de instrutor, usando abreviação i
    instructor i
LEFT JOIN 
    teaches t ON i.ID = t.ID  -- liga os instrutores às seções que ministraram
GROUP BY 
    i.ID, i.name              -- agrupa por instrutor para contar corretamente
ORDER BY 
    i.ID;


-- questão 2:--
-- a subconsulta conta quantas seções cada instrutor ministrou

SELECT  -- a consulta mostrará:
    i.ID,                     -- ID do instrutor
    i.name,                   -- Nome do instrutor
    (
        SELECT COUNT(*)       -- subconsulta: conta quantas linhas existem no teaches
        FROM teaches t 
        WHERE t.ID = i.ID     -- para o instrutor atual
    ) AS num_sections
FROM 
    instructor i --consulta retirada da tabela de instrutores, utilizando abreviação i
ORDER BY --consulta ordenada pelo id dos instrutores
    i.ID;

-- questão 3:
-- lista de todas as seções oferecidas na primaverad e 2010
-- se houver instrutor, mostra o nome; se não, mostra '-'
-- se houver mais de um instrutor, repete a seção

SELECT --consulta que apresenta:
    s.course_id,             -- ID do curso
    s.sec_id,                -- ID da seção
    s.building,              -- prédio da seção
    s.room_number,           -- sala
    COALESCE(i.name, '-') AS instructor_name  -- nome do instrutor ou '-' se não houver
FROM  --consulta retirada ta tabela section utilizando abreviação s
    section s
LEFT JOIN  -- liga as seções às passagens dos instrutores
    teaches t ON s.course_id = t.course_id 
             AND s.sec_id = t.sec_id 
             AND s.semester = t.semester 
             AND s.year = t.year
LEFT JOIN 
    instructor i ON t.ID = i.ID  -- liga ao nome do instrutor
WHERE 
    s.semester = 'Spring' AND s.year = 2010  -- consulta condicionada para relações na primavera de 2010
ORDER BY 
    s.course_id, s.sec_id;

-- questão 4:
-- pontos totais = créditos do curso × valor numérico da nota
-- supondo que exista a tabela grade_points(grade, points)

SELECT --consulta que apresenta:
    t.ID AS student_id,                   -- ID do aluno
    t.course_id,                          -- ID do curso
    c.credits * gp.points AS total_points  -- multiplica créditos pela nota (em pontos)
FROM --cosulta retirada da tabela takes coma abreviação t
    takes t
JOIN 
    course c ON t.course_id = c.course_id       -- junta com os créditos do curso
JOIN 
    grade_points gp ON t.grade = gp.grade       -- junta com os pontos da nota
WHERE 
    t.grade IS NOT NULL                    -- ignora cursos ainda sem nota atribuída
ORDER BY 
    t.ID, t.course_id;

-- questão 5:
-- o view praticamente salva a consulta para consultas futuras, podendo ser aberta com SELECT * FROM coeficiente_rendimento;

CREATE VIEW coeficiente_rendimento AS
SELECT --consulta que apresenta:
    t.ID AS student_id,                   -- ID do aluno
    t.course_id,                          -- ID do curso
    c.credits * gp.points AS total_points  -- pontos totais (créditos × nota)
FROM --retirado da tabela takes com abreviação t
    takes t
JOIN 
    course c ON t.course_id = c.course_id       -- junta com os créditos do curso
JOIN 
    grade_points gp ON t.grade = gp.grade       -- junta com os pontos da nota
WHERE 
    t.grade IS NOT NULL;                   -- ignora cursos ainda sem nota atribuída
