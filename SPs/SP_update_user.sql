USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_user
GO
CREATE PROCEDURE sp_update_user
    @inUsername VARCHAR(16),
    @inNewName VARCHAR(80) = NULL,
    @inNewNumber INT = NULL,
    @inNewPassword VARBINARY(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @output AS NVARCHAR(MAX);
    DECLARE @idUser INT;

    BEGIN TRY
        BEGIN TRANSACTION; 

        SET @idUser = ISNULL((SELECT TOP 1 idUser FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inUsername) and available = 1), 0)
        IF @idUser <> 0
        BEGIN
            DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[users] SET';
            DECLARE @Success INT = 0;

            IF @inNewName IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [name] = @inNewName';
                SET @Success = 1;
            END

            IF @inNewNumber IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [number] = @inNewNumber';
                SET @Success = 1;
            END

            IF @inNewPassword IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [password] = @inNewPassword';
                SET @Success = 1;
            END


            SET @sql = @sql + ' WHERE idUser = @idUser';

            EXEC sp_executesql @sql, N'@inNewName VARCHAR(80), @inNewNumber INT, @inNewPassword VARBINARY(MAX), @inUsername VARCHAR(16)', @inNewName, @inNewNumber, @inNewPassword, @inUsername;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('User updated <name ' + COALESCE(@inNewName, 'Unchanged') + '- number ' + COALESCE(CAST(@inNewNumber AS VARCHAR), 'Unchanged') + '>',
                GETDATE());

            COMMIT;
            SET @output = '{"success": 1, "description": "User updated successfully."}';
        END
        ELSE
        BEGIN
            SET @output = '{"success": 0, "description": "User update failed - User with username ' + @inUsername + ' does not exist."}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the user.', GETDATE());

        SET @output = '{"success": 0, "description": "An error occurred while updating the user."}';
    END CATCH

    SELECT @output;
END
