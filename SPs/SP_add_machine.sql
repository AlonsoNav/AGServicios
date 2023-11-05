USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_machine
GO
CREATE PROCEDURE sp_add_machine
	@brand VARCHAR(50),
    @type VARCHAR(50),
    @serial VARCHAR(30),
    @model VARCHAR(60)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @idBrand INT, @idType INT, @machineId INT;
    DECLARE @output VARCHAR(200);

	BEGIN TRY
		BEGIN TRANSACTION;
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

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
			INSERT INTO [dbo].[Machine] ([idBrand], [idType], [serial], [model])
			VALUES (@idBrand, @idType, @serial, @model);

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Nueva máquina agregada <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Nueva máquina agregada exitosamente."}';

			COMMIT TRANSACTION;
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
	END CATCH

    SELECT @output;
END