USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_user
GO
CREATE PROCEDURE [dbo].[sp_update_user] @inUsername    VARCHAR(16),
                                        @inNewUsername VARCHAR(16) = NULL,
                                        @inNewName     VARCHAR(80) = NULL,
                                        @inNewNumber   INT = NULL,
                                        @inNewPassword VARBINARY(max) = NULL
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output AS NVARCHAR(200);
      DECLARE @idUser INT;

      BEGIN try
          SET @idUser = Isnull((SELECT TOP 1 iduser
                                FROM   [dbo].[users]
                                WHERE  Lower([username]) = Lower(@inUsername)
                                       AND available = 1
                                       AND [isadmin] = 0), 0)

          IF @idUser <> 0
            BEGIN
                IF @inNewUsername IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[users]
                      SET    [username] = @inNewUsername
                      WHERE  iduser = @idUser;

                      COMMIT TRANSACTION
                  END

                IF @inNewName IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[users]
                      SET    NAME = @inNewName
                      WHERE  iduser = @idUser;

                      COMMIT TRANSACTION
                  END

                IF @inNewNumber IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[users]
                      SET    number = @inNewNumber
                      WHERE  iduser = @idUser;

                      COMMIT TRANSACTION
                  END

                IF @inNewPassword IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[users]
                      SET    password = @inNewPassword
                      WHERE  iduser = @idUser;

                      COMMIT TRANSACTION
                  END

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('User updated <name '
                             + COALESCE(@inNewName, 'Unchanged')
                             + '- number '
                             + COALESCE(Cast(@inNewNumber AS VARCHAR),
                             'Unchanged'
                             )
                             + '>',
                             Getdate());

                SET @output =
                '{"success": 1, "description": "User updated successfully."}';
            END
          ELSE
            BEGIN
                SET @output =
      '{"success": 0, "description": "User update failed - User with username '
      + @inUsername
      + ' does not exist or is an admin."}';
      END
      END try

      BEGIN catch
          IF @@TRANCOUNT > 0
            ROLLBACK;

          INSERT INTO dbo.eventlog
                      (description,
                       posttime)
          VALUES      ('An error occurred while updating the user.',
                       Getdate());

          SET @output =
  '{"success": 0, "description": "An error occurred while updating the user."}';
  END catch

      SELECT @output;
  END

go 