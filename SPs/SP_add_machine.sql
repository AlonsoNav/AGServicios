USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_machine
GO
CREATE PROCEDURE [dbo].[sp_add_machine]
	@brand VARCHAR(50),
    @type VARCHAR(50),
    @serial VARCHAR(30),
    @model VARCHAR(60)
AS
BEGIN
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @idBrand INT, @idType INT, @machineId INT;
    DECLARE @output VARCHAR(200);

	BEGIN TRY

		SELECT @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@brand)), 0);
		SELECT @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@type)), 0);

		IF EXISTS (SELECT 1 FROM machines WHERE [serial] = @serial)
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la inserción de la máquina - MISMO NÚMERO DE SERIE <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la inserción de la máquina: Ya existe una máquina con el mismo número de serie."}';
		END
		ELSE IF @idBrand = 0 OR @idType = 0
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la inserción de la máquina - MARCA O TIPO NO ENCONTRADOS <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la inserción de la máquina: Marca o tipo de máquina no encontrados."}';
		END
		ELSE
		BEGIN
			BEGIN TRANSACTION;

				INSERT INTO [dbo].[Machine] ([idBrand], [idType], [serial], [model])
				VALUES (@idBrand, @idType, @serial, @model);
			
			COMMIT TRANSACTION;

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Nueva máquina agregada <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Nueva máquina agregada exitosamente."}';
		END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
	END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO