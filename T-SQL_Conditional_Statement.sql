---------------------
-- CONDITIONAL STATEMENTS using declared variables
---------------------

BEGIN
    DECLARE @prod_name VARCHAR(20);
    DECLARE @price NUMERIC(8,2);
    DECLARE @price_category VARCHAR(20);

    SELECT 
        @prod_name = product_name, 
        @price = list_price
    FROM 
        [production].[products]
    WHERE  
        [product_id] = 303;

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
    
END

-- CONDITIONAL statements allow e.g. PRINT of specific results, rather than CASE which returns rows based on the conditions described 