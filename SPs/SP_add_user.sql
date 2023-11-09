USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_user
GO
CREATE PROCEDURE [dbo].[Sp_add_user]
    @username VARCHAR(16),
    @name VARCHAR(80),
    @number INT,
    @password VARBINARY(64)
-- El hash de la contrase�a
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;

    DECLARE @output VARCHAR(200);
    SET @username = Ltrim(Rtrim(@username));
    SET @name = Ltrim(Rtrim(@name));

    BEGIN try
        IF Len(@username) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre de usuario vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@name) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF @number = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: número vacío"}';
            SELECT @output;
            RETURN;
        END
        IF NOT EXISTS
        (
            SELECT 1
            FROM users
            WHERE Lower(username) = Lower(@username)
            and available = 1
        )
        BEGIN
            BEGIN TRANSACTION;

            INSERT INTO users
            (
                username,
                NAME,
                number,
                password
            )
            VALUES
            (@username, @name, @number, @password);

            COMMIT TRANSACTION;

            SET @output = '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}';
        END
        ELSE
        BEGIN

            SET @output
                = '{"result": 0, "description": "Error: nombre de usuario ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error: fallo inesperado en el servidor"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

GO