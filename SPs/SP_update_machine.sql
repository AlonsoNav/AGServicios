USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_machine
GO
CREATE PROCEDURE sp_update_machine
 @inSerial VARCHAR(30),
    @inNewModel VARCHAR(60) = NULL,
    @inNewSerial VARCHAR(30) = NULL
AS
BEGIN
    DECLARE @output VARCHAR(200);
    DECLARE @idMachine INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SET @idMachine = ISNULL((SELECT TOP 1 idMachine FROM [dbo].[machines] WHERE [serial] = @inSerial AND [available] = 1), 0)
        IF @idMachine <> 0
        BEGIN
            DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[machines] SET';
            DECLARE @Success INT = 0;

            IF @inNewModel IS NOT NULL
            BEGIN
                SET @sql = @sql + ' [model] = @inNewModel';
                SET @Success = 1;
            END

            IF @inNewSerial IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [serial] = @inNewSerial';
                SET @Success = 1;
            END

            SET @sql = @sql + ' WHERE [idMachine] = @idMachine';

            EXEC sp_executesql @sql, N'@inNewModel VARCHAR(60), @inNewSerial VARCHAR(30), @inSerial VARCHAR(30)', @inNewModel, @inNewSerial, @inSerial;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine updated <Serial: ' + @inSerial + ' - Model: ' + COALESCE(@inNewModel, 'Unchanged') + ' - New Serial: ' + COALESCE(@inNewSerial, 'Unchanged') + '>', GETDATE());

            COMMIT;

            SET @output = '{"success": 1, "description": "Machine updated successfully."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine update failed - Machine with serial number ' + @inSerial + ' does not exist or is not available.', GETDATE());

            ROLLBACK;
            SET @output = '{"success": 0, "description": "Machine update failed - Machine with serial number ' + @inSerial + ' does not exist or is not available."}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the machine.', GETDATE());

        SET @output = '{"success": 0, "description": "An error occurred while updating the machine."}';
    END CATCH

    SELECT @output;
END