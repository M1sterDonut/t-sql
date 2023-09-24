---------------------
-- TRIGGERS
---------------------

-- TRIGGERS             like PROCEDURE, pre-defined set of stored SQL blocks
-- How to use           Invoked implicitly i.e. when defined event takes place (DDL, DML or login event)
-- Example              Writing logs: when user log in and out of platform record created in DB 
-- Magic Tables         (1) Inserted (2) Deleted - automatically created on DML trigger, same structure as base table. 
----                    These tables will hold the affected rows (what has been inserted/deleted); 
----                    in UPDATE, rows are added to both tables b/c 'update' is basically a 'delete' followed by 'insert'

-- Example: Prevent reduction of discount amount

CREATE TRIGGER DiscountCheck ON [sales].[order_items] FOR UPDATE AS

BEGIN
    DECLARE @old_disc NUMERIC(3,2);
    DECLARE @new_disc NUMERIC(3,2);

    SELECT @old_disc = [discount] FROM Deleted;
    SELECT @new_disc = [discount] FROM Inserted; 

    IF(@old_disc > @new_disc)
    BEGIN
        PRINT 'New discount cannot be lower than old discount - we love giving good discounts!'; 
        ROLLBACK;
    END;
END;

UPDATE [sales].[order_items]
SET [discount] = [discount] - 0.1


-- Example 2: Prevent deleting more than one record at a time

CREATE TRIGGER DeleteCheck ON [sales].[order_items] FOR DELETE AS

BEGIN
    DECLARE @count INTEGER; 

    SELECT @count = COUNT(*) FROM Deleted

    IF @count > 1
    BEGIN
        PRINT 'Cannot delete more than one record at a time'
        ROLLBACK;
    END;
END;

DELETE FROM [sales].[order_items] WHERE [discount] = 0.10


---------------------
-- 'INSTEAD OF' TRIGGERS
---------------------

-- work on VIEWS ONLY!
-- When using DML statement on view, 'instead of' triggers can change action affecting underlying tables

-- Example:
-- Create view of which store an employee works in
-- When adding new employee to view, 'instead of' trigger will add store_id to sales.staffs table, rather than the store name we insert

-- Create view
CREATE VIEW EmpLoc AS
SELECT e.[staff_id], e.[first_name], s.[store_name]
FROM [sales].[staffs] e JOIN [sales].[stores] s
ON e.[store_id] = s.[store_id];

-- Create trigger
CREATE TRIGGER trig_EmpLocInsert ON EmpLoc
INSTEAD OF INSERT AS
BEGIN
    DECLARE @emp_id INT;
    DECLARE @name VARCHAR(20);
    DECLARE @store_id INT;

    SELECT @emp_id = [staff_id], @name = [first_name], @store_id = s.[store_id]
    FROM [sales].[stores] s JOIN inserted
    ON s.[store_name] = inserted.[store_name];

    -- prevent use of invalid store name

    IF @store_id IS NULL
    BEGIN
        PRINT 'Invalid department name entered.'
        ROLLBACK;
    END;
    INSERT INTO [sales].[staffs] ([staff_id], [first_name], [store_id]) VALUES (@emp_id, @name, @store_id)
END;

-- Update view
INSERT INTO EmpLoc VALUES (11, 'Boris', 'Santa Cruz Bikes')