---------------------
-- STORED FUCTIONS
---------------------

-- FUNCTION         must return a value (must define value type). For comparison, PROCEDURES do not return value (unless you pass a value using the OUTPUT parameter)
-- How to use       in SELECT / WHERE / HAVING clause
-- NOTE:            can't use Exception handling, b/c in case of error jump to CATCH block which does not return value but FUNCTION MUST return a value

-- Calculate 25% discount on inventory

CREATE FUNCTION DiscountAmount(@amount NUMERIC(10,2)) RETURNS NUMERIC(8,2) AS

BEGIN
    RETURN @amount * 0.25;
END;

SELECT 
    [product_name] AS 'Bike Model Name', 
    [list_price] AS 'Original Price',
    dbo.DiscountAmount([list_price]) AS 'Discount Applied (25%)',
    [list_price] - dbo.DiscountAmount([list_price]) AS 'Sale Price'
FROM
    [production].[products]