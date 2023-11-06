USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_type
GO
CREATE PROCEDURE [dbo].[Sp_delete_type] @name VARCHAR(50)
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

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Tipo de máquina eliminado <Tipo de máquina: '
                             + @name + '>',
                             Getdate());

                SET @output =
      '{"result": 1, "description": "Tipo de máquina eliminado exitosamente."}'
      ;
      END
      ELSE
      BEGIN
      INSERT INTO dbo.eventlog
                  (description,
                   posttime)
      VALUES      (
'Fallo en la eliminación del tipo de máquina - El tipo de máquina con nombre '
+ @name + ' no existe.',
Getdate());

SET @output =
'{"result": 0, "description": "Fallo en la eliminación del tipo de máquina: El tipo de máquina no existe."}'
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