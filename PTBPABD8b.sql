-- Cria um gatilho (trigger) chamado trigger_prevent_assignment_teaches
-- Esse trigger é executado ao invés de uma inserção na tabela 'teaches'
CREATE TRIGGER trigger_prevent_assignment_teaches
ON teaches
INSTEAD OF INSERT
AS
BEGIN
    -- Impede que mensagens extras sejam retornadas após comandos DML
    SET NOCOUNT ON;

    -- Verifica se algum dos professores que estão sendo inseridos já têm 2 ou mais atribuições no mesmo ano
    IF EXISTS (
        SELECT 1
        FROM inserted i  -- 'inserted' é uma tabela temporária com os dados que estão sendo inseridos
        JOIN teaches t
            ON i.ID = t.ID AND i.year = t.year  -- Combina os dados inseridos com os já existentes no mesmo ano
        GROUP BY i.ID, i.year
        HAVING COUNT(*) + 1 > 2  -- Verifica se o total de atribuições (existentes + nova) ultrapassa 2
    )
    BEGIN
        -- Se algum professor já tiver 2 ou mais atribuições, gera um erro
        RAISERROR('Esse professor já possui 2 ou mais atribuições neste ano.', 16, 1);

        -- Cancela a transação de inserção
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Se nenhum professor ultrapassar o limite, realiza a inserção normalmente
    INSERT INTO teaches (ID, course_id, sec_id, semester, year)
    SELECT ID, course_id, sec_id, semester, year
    FROM inserted;
END;
