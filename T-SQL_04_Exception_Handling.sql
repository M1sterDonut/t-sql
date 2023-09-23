---------------------
-- EXCEPTION HANDLING
---------------------

-- 'Error at runtime' = Exception
-- Handle expection to prevent abnormal end of program

-- TRY block: runs code with suspected exception. Pass = intended output, Fail = handover to CATCH block
-- CATCH block: excecutes on TRY fail, used to handle exception

BEGIN TRY
    SELECT 1/0 -- 'devide by 0 exception'
END TRY

BEGIN CATCH
    SELECT
        @@ERROR AS Error, -- global variable to return error number
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLIne,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH; 


---------------------
-- EXCEPTION HANDLING Example
---------------------

BEGIN TRY
    DECLARE @name VARCHAR(20);
    DECLARE @sal NUMERIC(8,2);
    SET @name = 'Anadi'; 
    SET @sal = 5000; 
    PRINT @name + ' earns ' + @sal; -- error, b/c not casting numeric type
END TRY

BEGIN CATCH
    SELECT
            @@ERROR AS Error, -- global variable to return error number
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLIne,
            ERROR_MESSAGE() AS ErrorMessage;
END CATCH