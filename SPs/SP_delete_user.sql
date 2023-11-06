USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_user
GO
CREATE PROCEDURE [dbo].[Sp_delete_user] @username VARCHAR(16)
AS
  BEGIN
      SET nocount ON

      BEGIN try
          DECLARE @idUser INT;
          DECLARE @output NVARCHAR(200);

          SELECT @idUser = Isnull((SELECT TOP 1 iduser
                                   FROM   users
                                   WHERE  Lower([username]) = Lower(@username)
                                          AND available = 1
                                          AND [isadmin] = 0), 0)

          IF @idUser <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE users
                SET    available = 0
                WHERE  iduser = @idUser;

                COMMIT

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Usuario eliminado <Nombre de usuario: '
                             + @username + '>',
                             Getdate());

                SET @output =
      '{"result": 1, "description": "Usuario eliminado exitosamente."}';
            END
          ELSE
            BEGIN
                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      (
                'Fallo en la eliminación del usuario - El usuario con nombre '
                + @username
                + ' no existe o es un administrador.',
                Getdate());

                SET @output =
'{"result": 0, "description": "Fallo en la eliminación del usuario: El usuario no existe o es un administrador."}'
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