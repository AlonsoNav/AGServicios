USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_user
GO
CREATE PROCEDURE [dbo].[Sp_add_user] @username VARCHAR(16),
                                     @name     VARCHAR(80),
                                     @number   INT,
                                     @password VARBINARY(64)
-- El hash de la contrase�a
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output VARCHAR(200);

      BEGIN try
          IF NOT EXISTS (SELECT 1
                         FROM   users
                         WHERE  Lower(username) = Lower(@username))
            BEGIN
                BEGIN TRANSACTION;

                INSERT INTO users
                            (username,
                             NAME,
                             number,
                             password)
                VALUES      (@username,
                             @name,
                             @number,
                             @password);

                COMMIT TRANSACTION;

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('User inserted <username ' + @username
                             + ' - name ' + @name + ' - number '
                             + Cast(@number AS VARCHAR) + ' - password '
                             + CONVERT(VARCHAR(64), @password, 2) + '>',
                             Getdate());

                SET @output =
      '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}'
      ;
            END
          ELSE
            BEGIN
                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('User insertion failed <username '
                             + @username + ' - name ' + @name + ' - number '
                             + Cast(@number AS VARCHAR) + ' - password '
                             + CONVERT(VARCHAR(64), @password, 2) + '>',
                             Getdate());

                SET @output =
'{"result": 0, "description": "Fallo en la inserción del usuario: El nombre de usuario ya existe."}'
    ;
END
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;

        SET @output =
'{"result": 0, "description": "Error durante la inserción del usuario."}';
END catch

    SELECT @output;

    SET nocount OFF;
END

go 