USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_machine
GO
CREATE PROCEDURE [dbo].[sp_update_machine]
    @inSerial VARCHAR(30),
    @inNewModel VARCHAR(60) = NULL,
    @inNewSerial VARCHAR(30) = NULL
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idMachine INT;
	SET @inNewModel = Ltrim(Rtrim(@inNewModel));
	SET @inNewSerial = Ltrim(Rtrim(@inNewSerial));
    DECLARE @output VARCHAR(200);

    BEGIN try
        SET @idMachine = Isnull(
                      (
                          SELECT TOP 1
                              idMachine
                          FROM [SGR].[dbo].[machines]
                          WHERE Lower([serial]) = Lower(@inSerial)
                                AND available = 1
                      ),
                      0
                            )

        IF @idMachine <> 0
        BEGIN
          
			IF EXISTS
            (
                SELECT 1
                FROM [SGR].[dbo].[machines]
                WHERE Lower([serial]) = Lower(@inNewSerial)
            )
			BEGIN
				SET @output = '{"result": 0, "description": "Error: serial ya existe"}';
				SELECT @output;
				RETURN;
			END

            IF NOT Len(@inNewModel) = 0
            BEGIN
                BEGIN TRANSACTION
				UPDATE [SGR].[dbo].[machines]
				SET [model] = @inNewModel
				WHERE [serial] = @inSerial;
				COMMIT TRANSACTION
            END
                   
            IF NOT Len(@inNewSerial) = 0
            BEGIN
                BEGIN TRANSACTION
				UPDATE [SGR].[dbo].[machines]
				SET [serial] = @inNewSerial
				WHERE [serial] = @inSerial;
				COMMIT TRANSACTION
            END
            
            

            SET @output = '{"result": 1, "description": "Máquina editada exitosamente"}';

        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Error: máquina no disponible"}';

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