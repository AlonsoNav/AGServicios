USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_brand
GO
CREATE PROCEDURE [dbo].[Sp_delete_brand] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idBrand INT;
          DECLARE @output VARCHAR(200);

          SET @idBrand = Isnull((SELECT TOP 1 idbrand
                                 FROM   brands
                                 WHERE  Lower([name]) = Lower(@name)
                                        AND available = 1), 0)

          IF @idBrand <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE brands
                SET    available = 0
                WHERE  idbrand = @idBrand;

                COMMIT

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Marca eliminada <' + @name + '>',
                             Getdate());

                SET @output =
                '{"result": 1, "description": "Marca eliminada exitosamente."}';
            END
          ELSE
            BEGIN
                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      (
                'Fallo en la eliminación de la marca - La marca con nombre '
                + @name + ' no existe.',
                Getdate());

                SET @output =
'{"result": 0, "description": "Fallo en la eliminación de la marca: La marca no existe."}'
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