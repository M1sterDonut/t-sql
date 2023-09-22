---------------------
-- BEGIN/END and PRINT
---------------------

BEGIN
    PRINT 'Welcome to T-SQL';
END

-- BEGIN and END are like {} in JSON file
-- PRINT uses 'single quotes' only


---------------------
-- DECLARE a variable
---------------------

BEGIN
    DECLARE @var int = 200;
    -- SET @var = 100;
    PRINT @var; 
END

-- syntax: DECLARE @var_name data_type = value/'string'


---------------------
-- CONCAT @variables
---------------------

BEGIN
    DECLARE @name VARCHAR(20);
    DECLARE @sal NUMERIC(8,2);
    SET @name = 'Anadi'; 
    SET @sal = 5000; 
    PRINT @name + ' earns ' + CAST(@sal AS VARCHAR);
END

BEGIN
    DECLARE @customer_name VARCHAR(20);
    DECLARE @phone_number VARCHAR(20);

    SELECT @customer_name = first_name, @phone_number = phone FROM [BikeStores].[sales].[customers]
    WHERE customer_id = 292;

    PRINT @customer_name + '''s phone number is: ' + @phone_number
END

-- CONCAT: can concatenate variable names, not column names; need to cast to VARCHAR type