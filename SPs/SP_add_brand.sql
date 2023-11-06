USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_brand
GO
CREATE PROCEDURE sp_add_brand
    @name VARCHAR(50),
	@description VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @output VARCHAR(200);

    BEGIN TRY
        BEGIN TRANSACTION;
        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        IF NOT EXISTS (SELECT 1 FROM brands WHERE LOWER([name]) = LOWER(@name))
        BEGIN
            INSERT INTO brands (name, description)
            VALUES (@name, @description);

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New brand added <' + @name + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Marca añadida exitosamente"}';

            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de marca fallida: la marca ya existe"}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir la marca: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
END