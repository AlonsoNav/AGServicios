USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_client
GO
CREATE PROCEDURE sp_add_client
    @name VARCHAR(50),
	@number INT,
	@address VARCHAR(50),
	@email VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @output VARCHAR(200);

    BEGIN TRY
        BEGIN TRANSACTION;
        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        IF NOT EXISTS (SELECT 1 FROM clients WHERE LOWER([name]) = LOWER(@name))
        BEGIN
            INSERT INTO clients ([name], [contactNumber], [address], [email])
            VALUES (@name, @number, @address, @email);

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New client added <Name: ' + @name + ' - Number: ' + CAST(@number AS VARCHAR) + ' - Address: ' + @address + ' - Email: ' + @email + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Cliente añadido exitosamente"}';

            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de cliente fallida: El cliente ya existe"}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
END