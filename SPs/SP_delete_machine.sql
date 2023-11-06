USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_machine
GO
CREATE PROCEDURE [dbo].[Sp_delete_machine] @serial VARCHAR(30)
AS
  BEGIN
      SET nocount ON;

      BEGIN try
          DECLARE @idMachine INT;
          DECLARE @output VARCHAR(200);

          SET @idMachine = Isnull((SELECT TOP 1 idmachine
                                   FROM   machines
                                   WHERE  serial = @serial
                                          AND available = 1), 0);

          IF @idMachine <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE machines
                SET    available = 0
                WHERE  idmachine = @idMachine;

                COMMIT

                SET @output =
      '{"result": 1, "description": "Máquina eliminada exitosamente."}'
      ;
            END
          ELSE
            BEGIN

      SET @output =
'{"result": 0, "description": "Error: máquina no existe"}'
    ;
END

    SELECT @output;
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;
    END catch

    SET nocount OFF;
END

go 