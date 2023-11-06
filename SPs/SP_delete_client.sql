USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_client
GO
CREATE PROCEDURE [dbo].[Sp_delete_client] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idClient INT;
          DECLARE @output VARCHAR(200);

          SET @idClient = Isnull((SELECT TOP 1 idclient
                                  FROM   clients
                                  WHERE  Lower([name]) = Lower(@name)
                                         AND available = 1), 0)

          IF @idClient <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE clients
                SET    available = 0
                WHERE  idclient = @idClient;

                COMMIT

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Cliente eliminado <' + @name + '>',
                             Getdate());

                SET @output =
      '{"result": 1, "description": "Cliente eliminado exitosamente."}';
            END
          ELSE
            BEGIN
                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      (
                'Fallo en la eliminación del cliente - El cliente con nombre '
                + @name + ' no existe.',
                Getdate());

                SET @output =
'{"result": 0, "description": "Fallo en la eliminación del cliente: El cliente no existe."}'
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
END

go 