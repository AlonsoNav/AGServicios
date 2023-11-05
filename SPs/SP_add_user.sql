USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_user
GO
CREATE PROCEDURE sp_add_user
	@username VARCHAR(16),
    @name VARCHAR(80),
    @number int,
    @password VARBINARY(64)  -- El hash de la contrase�a
AS
BEGIN
    SET NOCOUNT ON
	DECLARE @output VARCHAR(200);

    BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM users WHERE LOWER(username) = LOWER(@username))
        BEGIN
            INSERT INTO users(username, name, number, password)
            VALUES (@username, @name, @number, @password);

            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User inserted <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}';

            COMMIT;
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User insertion failed <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la inserción del usuario: El nombre de usuario ya existe."}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        SET @output = '{"result": 0, "description": "Error durante la inserción del usuario."}';
    END CATCH

    SELECT @output;
END