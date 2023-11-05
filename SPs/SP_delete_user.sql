USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_user
GO
CREATE PROCEDURE sp_delete_user
	@username VARCHAR(16)
AS
BEGIN
	DECLARE @idUser INT;
    DECLARE @output VARCHAR(200);

    SELECT @idUser = ISNULL((SELECT TOP 1 idUser FROM users WHERE LOWER([username]) = LOWER(@username) and available = 1), 0)

    IF @idUser <> 0
    BEGIN
        UPDATE users SET available = 0 WHERE idUser = @idUser;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Usuario eliminado <Nombre de usuario: ' + @username + '>'
            , GETDATE());

        SET @output = '{"result": 1, "description": "Usuario eliminado exitosamente."}';
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Fallo en la eliminación del usuario - El usuario con nombre ' + @username + ' no existe.'
            , GETDATE());

        SET @output = '{"result": 0, "description": "Fallo en la eliminación del usuario: El usuario no existe."}';
    END

    SELECT @output;
END