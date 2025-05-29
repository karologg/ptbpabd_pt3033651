-- Trigger que atualiza créditos após remoção de curso
CREATE TRIGGER dbo.lost_credits
ON dbo.takes
AFTER DELETE
AS
BEGIN
    -- Sai se nada foi deletado
    IF (ROWCOUNT_BIG() = 0)
        RETURN;

    -- Atualiza créditos dos alunos afetados
    UPDATE s
    SET s.tot_cred = s.tot_cred - x.cred_lost
    FROM dbo.student s
    INNER JOIN (
        -- Soma créditos perdidos por aluno
        SELECT d.ID, SUM(c.credits) AS cred_lost
        FROM deleted d
        INNER JOIN dbo.course c ON d.course_id = c.course_id
        GROUP BY d.ID
    ) x ON s.ID = x.ID;
END;
GO

-- Consulta: total de cursos por aluno
SELECT ID, COUNT(*) AS qtd_courses 
FROM takes 
GROUP BY ID
ORDER BY qtd_courses;

-- Inserção de curso para teste
INSERT INTO takes (ID, course_id, sec_id, semester, [year], grade) 
VALUES ('30299', '105', '1', 'Fall', 2009, 'A+');

-- Remoção do curso (ativa a trigger)
DELETE FROM takes 
WHERE ID = '30299' 
  AND course_id = '105' 
  AND sec_id = '1' 
  AND semester = 'Fall' 
  AND [year] = 2009 
  AND grade = 'A+';

-- Verifica créditos atualizados do aluno
SELECT ID, name, dept_name, tot_cred 
FROM student 
WHERE ID = '30299';
