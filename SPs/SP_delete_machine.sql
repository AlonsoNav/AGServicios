USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_machine
GO
CREATE PROCEDURE [dbo].[sp_delete_machine]
	@serial varchar(30)

AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @idMachine INT;
		DECLARE @output VARCHAR(200);

		SET @idMachine = ISNULL((SELECT TOP 1 idMachine FROM machines WHERE serial = @serial and available = 1), 0);

		IF @idMachine <> 0
		BEGIN
			BEGIN TRANSACTION
				UPDATE machines SET available = 0 WHERE idMachine = @idMachine;
			COMMIT

			SET @output = '{"result": 1, "description": "Máquina eliminada exitosamente"}';
		END
		ELSE
		BEGIN
			SET @output = '{"result": 0, "description": "Error: máquina no disponible"}';
		END

	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;

		SET @output = '{"result": 0, "description": "Error: fallo inesperado en el servidor"}';
	END CATCH
	SELECT @output;
	SET NOCOUNT OFF;

END
GO