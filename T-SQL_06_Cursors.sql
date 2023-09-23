---------------------
-- CURSORS
---------------------

-- Variables do not handle multiple values at the same time
-- Cursors retrieve data from result one row at a time, update records row-by-row
-- @@FETCH_STATUS 0, data available; -1 no data left

-- Cursor Stages
---- Declare Cursor         DECLARE cursor_name CURSOR FOR + SELECT statement      not DB object, declared like variable
---- Open                   OPEN cursor_name                                following the SELECT statement will be executed and result set generated 
---- Fetch                  FETCH NEXT FROM cursor_name INTO @var1, @var2   start pointing one-by-one
---- Close                  CLOSE cursor_name                               Cursor no longer available for fetching
---- Deallocate             DEALLOCATE cursor_name                          deallocate resources from cursor

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
        [list_price] = 999.99;
    
    OPEN bikecur;
    FETCH NEXT FROM bikecur INTO @bike_model, @list_price, @model_year;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @bike_model + ' --- $' + CAST(@list_price AS VARCHAR) + ' --- ' + CAST(@model_year AS VARCHAR);
        FETCH NEXT FROM bikecur INTO @bike_model, @list_price, @model_year;
    END
    CLOSE bikecur
    DEALLOCATE bikecur
END