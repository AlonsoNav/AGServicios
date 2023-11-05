USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_type
GO
CREATE PROCEDURE sp_update_type
@inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL,
    @inDescription VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @output AS VARCHAR(MAX);
    DECLARE @idType INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SET @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM [dbo].[typesMachine] WHERE LOWER([name]) = LOWER(@inName) and available = 1), 0)
        IF @idType <> 0
        BEGIN
            DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[typesMachine] SET';
            DECLARE @Success INT = 0;

            IF @inNewName IS NOT NULL
            BEGIN
                SET @sql = @sql + ' [name] = @inNewName';
                SET @Success = 1;
            END

            IF @inDescription IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [description] = @inDescription';
                SET @Success = 1;
            END

            SET @sql = @sql + ' WHERE idTypeMachine = @idType';

            EXEC sp_executesql @sql, N'@inNewName VARCHAR(50), @inDescription VARCHAR(100), @inName VARCHAR(50)', @inNewName, @inDescription, @inName;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine type updated <TypeMachine: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: ' + COALESCE(@inDescription, 'Unchanged') + '>', GETDATE());

            COMMIT;

            SET @output = '{"success": 1, "description": "Machine type updated successfully."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine type update failed - TypeMachine with name ' + @inName + ' does not exist.', GETDATE());

            ROLLBACK;
            SET @output = '{"success": 0, "description": "Machine type update failed - TypeMachine with name ' + @inName + ' does not exist."}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the machine type.', GETDATE());

        SET @output = '{"success": 0, "description": "An error occurred while updating the machine type."}';
    END CATCH

    SELECT @output;
END