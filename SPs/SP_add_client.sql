USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_client
GO
CREATE PROCEDURE [dbo].[sp_add_client]
    @name VARCHAR(30),
    @number INT,
    @address VARCHAR(50),
    @email VARCHAR(50)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @output VARCHAR(200);
    SET @number = Ltrim(Rtrim(@number));
    SET @address = Ltrim(Rtrim(@address));
    SET @email = Ltrim(Rtrim(@email));
    BEGIN try
        IF Len(@number) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: El número está vacío."}';
            SELECT @output;
            RETURN;
        END
        IF Len(@address) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: La dirección está vacía."}';
            SELECT @output;
            RETURN;
        END
        IF Len(@email) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: El correo electrónico está vacío."}';
            SELECT @output;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM clients WHERE Lower([name]) = Lower(@name))
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO clients
            (
                [name],
                [contactnumber],
                [address],
                [email],
                [available]
            )
            VALUES
            (@name, @number, @address, @email, 1);
            COMMIT TRANSACTION;
            INSERT INTO dbo.eventlog
            (
                description,
                posttime
            )
            VALUES
            ('New client added <Name: ' + @name + ' - Number: ' + Cast(@number AS VARCHAR) + ' - Address: ' + @address
             +  ' - Email: ' + @email + '>',
             Getdate()
            );
            SET @output = '{"result": 1, "description": "Cliente añadido exitosamente."}';
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de cliente fallida: El cliente ya existe."}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION;
        -- se deshacen los cambios realizados
        END;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + Error_message() + '"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END
GO
