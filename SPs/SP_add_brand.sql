USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_brand
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @name VARCHAR(50),
	@description VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output VARCHAR(200);

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM brands WHERE LOWER([name]) = LOWER(@name))
        BEGIN
			BEGIN TRANSACTION;
				INSERT INTO brands (name, description)
				VALUES (@name, @description);
			COMMIT TRANSACTION;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New brand added <' + @name + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Marca añadida exitosamente"}';
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de marca fallida: la marca ya existe"}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
		SET @output = '{"result": 0, "description": "Error al añadir la marca: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO