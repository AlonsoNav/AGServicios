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

    DECLARE @output VARCHAR(200);

    BEGIN try
        IF EXISTS
        (
            SELECT 1
            FROM [dbo].[machine]
            WHERE [serial] = @inSerial
                  AND [available] = 1
        )
        BEGIN
            IF @inNewModel IS NOT NULL
            BEGIN
                SET @inNewModel = Ltrim(Rtrim(@inNewModel));
                IF Len(@inNewModel) = 0
                BEGIN
                    SET @output = '{"result": 0, "description": "Error: El modelo de la máquina no puede ser vacío"}';

                    SELECT @output;

                    RETURN;
                END
                BEGIN TRANSACTION

                UPDATE [dbo].[machine]
                SET [model] = @inNewModel
                WHERE [serial] = @inSerial;

                COMMIT TRANSACTION
            END

            IF @inNewSerial IS NOT NULL
            BEGIN
                SET @inNewSerial = Ltrim(Rtrim(@inNewSerial));
                IF Len(@inNewSerial) = 0
                BEGIN
                    SET @output = '{"result": 0, "description": "Error: El serial de la máquina no puede ser vacío"}';

                    SELECT @output;

                    RETURN;
                END
                BEGIN TRANSACTION

                UPDATE [dbo].[machine]
                SET [serial] = @inNewSerial
                WHERE [serial] = @inSerial;

                COMMIT TRANSACTION
            END

            SET @output = '{"result": 1, "description": "Cliente actualizado exitosamente."}';

            INSERT INTO dbo.eventlog
            (
                description,
                posttime
            )
            VALUES
            ('Machine updated <Serial: ' + @inSerial + ' - Model: ' + COALESCE(@inNewModel, 'Unchanged')
             +  ' - New Serial: ' + COALESCE(@inNewSerial, 'Unchanged') + '>',
             Getdate()
            );
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "El cliente ingresado no existe o no está disponible."}';

            INSERT INTO dbo.eventlog
            (
                description,
                posttime
            )
            VALUES
            ('Machine update failed - Machine with serial number ' + @inSerial + ' does not exist or is not available.',
             Getdate()
            );
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END
GO