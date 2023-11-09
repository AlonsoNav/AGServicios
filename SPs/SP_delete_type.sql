USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_type
GO
CREATE PROCEDURE [dbo].[sp_delete_type] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idType INT;
          DECLARE @output NVARCHAR(200);

          SET @idType = Isnull((SELECT TOP 1 idtypemachine
                                FROM   typesmachine
                                WHERE  Lower([name]) = Lower(@name)
                                       AND available = 1), 0)

          IF @idType <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE typesmachine
                SET    available = 0
                WHERE  idtypemachine = @idType;

                COMMIT

                SET @output =
      '{"result": 1, "description": "Tipo de máquina eliminado exitosamente"}'
      ;
      END
      ELSE
      BEGIN

SET @output =
'{"result": 0, "description": "Error: tipo de máquina no existe"}'
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