-- Criação do procedimento chamado salaryHistogram, que recebe como parâmetro o número de intervalos desejado
CREATE PROCEDURE salaryHistogram
    @num_intervals INT  -- parâmetro de entrada: número de faixas (intervalos) do histograma
AS
BEGIN
    -- Declara variáveis para armazenar o menor e o maior salário da tabela
    DECLARE @min_salary FLOAT, @max_salary FLOAT;

    -- Obtém o menor (MIN) e maior (MAX) salário da tabela professor e armazena nas variáveis
    SELECT @min_salary = MIN(salary), @max_salary = MAX(salary)
    FROM professor;

    -- Declara uma variável para armazenar o tamanho de cada faixa do histograma
    DECLARE @interval_size FLOAT;

    -- Calcula o tamanho de cada faixa dividindo a diferença entre o maior e o menor salário
    -- pelo número de intervalos desejado
    SET @interval_size = (@max_salary - @min_salary) / @num_intervals;

    -- Cria uma tabela temporária para armazenar os dados do histograma
    CREATE TABLE #histogram (
        valorMinimo FLOAT,  -- início do intervalo
        valorMaximo FLOAT,  -- fim do intervalo
        total INT           -- quantidade de professores naquele intervalo
    );

    -- Inicializa um contador de loop
    DECLARE @i INT = 0;

    -- Loop que percorre todos os intervalos, de 0 até (n-1)
    WHILE @i < @num_intervals
    BEGIN
        -- Calcula o valor mínimo da faixa atual
        DECLARE @start_range FLOAT = @min_salary + @i * @interval_size;

        -- Calcula o valor máximo da faixa atual
        DECLARE @end_range FLOAT = @start_range + @interval_size;

        -- Verifica se é o último intervalo (o mais alto)
        -- Nesse caso, o salário máximo também deve ser incluído (com <=)
        IF @i = @num_intervals - 1
        BEGIN
            -- Insere os valores da faixa na tabela temporária, contando quantos salários estão entre os limites (inclusive o máximo)
            INSERT INTO #histogram
            SELECT
                @start_range AS valorMinimo,
                @end_range AS valorMaximo,
                COUNT(*) AS total
            FROM professor
            WHERE salary >= @start_range AND salary <= @end_range;  -- inclui o máximo com <=
        END
        ELSE
        BEGIN
            -- Para faixas intermediárias, conta quantos salários estão no intervalo, sem incluir o máximo da faixa
            INSERT INTO #histogram
            SELECT
                @start_range AS valorMinimo,
                @end_range AS valorMaximo,
                COUNT(*) AS total
            FROM professor
            WHERE salary >= @start_range AND salary < @end_range;  -- exclusivo do máximo
        END

        -- Incrementa o contador para passar para a próxima faixa
        SET @i = @i + 1;
    END

    -- Exibe os resultados do histograma após o loop
    SELECT * FROM #histogram;

    -- Apaga a tabela temporária após exibir os resultados
    DROP TABLE #histogram;
END;
