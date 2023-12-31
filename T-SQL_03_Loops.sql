---------------------
-- LOOPS
---------------------

-- Example of loop syntax, will implement Cursor in following lessons (since this will send a database request each time the loop re-starts)

BEGIN
    DECLARE @prod_name VARCHAR(20);
    DECLARE @price NUMERIC(8,2);
    DECLARE @price_category VARCHAR(20);
    DECLARE @prod_id INTEGER = 303; 

    WHILE @prod_id <= 313
    BEGIN
        SELECT 
            @prod_name = product_name, 
            @price = list_price
        FROM 
            [production].[products]
        WHERE  
            [product_id] = @prod_id;

        IF @price >= 2000
        BEGIN
            SET @price_category = 'Luxury Range';
        END

        ELSE IF @price >= 1000
        BEGIN
            SET @price_category = 'Intermediate Range';
        END

        ELSE
        BEGIN
            SET @price_category = 'Budget Range';
        END

        PRINT @prod_name + ' costs $' + CAST(@price AS VARCHAR) + ' and is part of our ''' + @price_category + ''' cycles.';

        SET @prod_id = @prod_id + 1;
    END
    
END
