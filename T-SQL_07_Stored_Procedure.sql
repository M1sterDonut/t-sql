---------------------
-- STORED PROCEDURE
---------------------

-- EXEC / EXECUTE       DB object of set of logical T-SQL statements
-- Reusable             multiple executions of pre-written code
-- Faster               compilation takes place at creation (makes queries faster b/c code in SP does not have to compile again)
-- Access control       depending on intended user


---------------------
-- STORED PROCEDURE - using provided parameters
---------------------

CREATE PROCEDURE BikesAtThisPrice AS
ALTER PROCEDURE BikesAtThisPrice @bike_price NUMERIC(6,2) AS

BEGIN
    DECLARE @bike_model VARCHAR(50);
    DECLARE @list_price NUMERIC(6,2);
    DECLARE @model_year NUMERIC(4);
    
    DECLARE bikecur CURSOR FOR
    SELECT 
        [product_name], 
        [list_price], 
        [model_year]
    FROM
        [production].[products]
    WHERE
        [list_price] = @bike_price; 
    OPEN bikecur;

    FETCH NEXT FROM bikecur INTO @bike_model, @list_price, @model_year;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @bike_model + ' --- $' + CAST(@list_price AS VARCHAR) + ' --- ' + CAST(@model_year AS VARCHAR);
        FETCH NEXT FROM bikecur INTO @bike_model, @list_price, @model_year;
    END
    CLOSE bikecur;
    DEALLOCATE bikecur;
END;

EXECUTE BikesAtThisPrice 499.99


---------------------
-- STORED PROCEDURE - using provided and retrieved parameters
---------------------

-- OUTPUT       to flag as retrieved parameter

CREATE PROCEDURE WhoIsIt @emp_num INT, @name VARCHAR(30) OUTPUT, @us_state VARCHAR(2) OUTPUT AS

BEGIN
    SELECT 
        @name = [first_name], 
        @us_state = [state] 
    FROM 
        [sales].[customers]
    WHERE
        [customer_id] = @emp_num;
END;

BEGIN
    DECLARE @cust_name VARCHAR(30);
    DECLARE @us_state_abbr VARCHAR(2);

    EXECUTE WhoIsIt 163, @cust_name OUTPUT, @us_state_abbr OUTPUT;
    PRINT 'Customer of the month: ' + @cust_name + ' from ' + @us_state_abbr + '!'
END