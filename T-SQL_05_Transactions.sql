---------------------
-- TRANSACTIONS
---------------------

-- TRANSACTION          set of statements executed as a single unit (success / fail together)
-- COMMIT / ROLLBACK    Save / Undo, CANNOT BE UNDONE!
-- SAVE                 SAVE TRANSACTION savepoint_name - Savepoint to split transactions to smaller parts for ROLLBACK
-- @@TRANCOUNT          counts number of transactions
-- Transaction Status   is inconclusive until ROLLBACK / COMMIT statement; other users cannot query database during this time

BEGIN TRANSACTION 
    SAVE TRANSACTION S1
    DELETE FROM 
        [sales].[staffs] 
    WHERE 
        [staff_id] = 3;
    PRINT @@TRANCOUNT -- stays 1 on COMMIT, reduced by 1 on ROLLBACK

    SAVE TRANSACTION S2
    DELETE FROM 
        [sales].[staffs] 
    WHERE 
        [staff_id] = 4;
    PRINT @@TRANCOUNT

    ROLLBACK TRANSACTION S2 -- to before 'DELETE ... staff_id = 4' step (line 20)
    COMMIT -- once executed, 'staff_id = 3' row will be deleted, since following deletion was rolled back