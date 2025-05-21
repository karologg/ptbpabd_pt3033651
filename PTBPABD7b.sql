CREATE PROCEDURE salaryHistogram
    @num_intervals INT
AS
BEGIN
    DECLARE @min_salary DECIMAL(10,2),
            @max_salary DECIMAL(10,2),
            @interval_size DECIMAL(10,2),
            @i INT = 0;

    SELECT 
        @min_salary = MIN(salary), 
        @max_salary = MAX(salary)
    FROM professor;

    SET @interval_size = (@max_salary - @min_salary) / @num_intervals;

    DECLARE @results TABLE (
        valorMinimo DECIMAL(10,2),
        valorMaximo DECIMAL(10,2),
        total INT
    );

    WHILE @i < @num_intervals
    BEGIN
        DECLARE @start_range DECIMAL(10,2) = @min_salary + (@interval_size * @i);
        DECLARE @end_range DECIMAL(10,2) = @start_range + @interval_size;

        DECLARE @count INT;

        IF @i = @num_intervals - 1
        BEGIN
            SELECT @count = COUNT(*) 
            FROM professor
            WHERE salary >= @start_range AND salary <= @end_range;
        END
        ELSE
        BEGIN
            SELECT @count = COUNT(*) 
            FROM professor
            WHERE salary >= @start_range AND salary < @end_range;
        END

        INSERT INTO @results (valorMinimo, valorMaximo, total)
        VALUES (@start_range, @end_range, @count);

        SET @i = @i + 1;
    END

    SELECT * FROM @results;
END;
