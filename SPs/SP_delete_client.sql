USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_client
GO
CREATE PROCEDURE [dbo].[sp_delete_client] @name VARCHAR(50)
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

                SET @output =
      '{"result": 1, "description": "Cliente eliminado exitosamente"}';
            END
          ELSE
            BEGIN

                SET @output =
'{"result": 0, "description": "Error: cliente no existe"}'
    ;
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
END

GO