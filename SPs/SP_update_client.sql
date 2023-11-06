USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_client
GO
CREATE PROCEDURE [dbo].[sp_update_client] @inName       VARCHAR(30),
                                          @inNewName    VARCHAR(30) = NULL,
                                          @inNewNumber  INT = NULL,
                                          @inNewAddress VARCHAR(50) = NULL,
                                          @inNewEmail   VARCHAR(50) = NULL
AS
  BEGIN
      SET nocount ON;
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output AS NVARCHAR(200);
      DECLARE @idClient INT;

      BEGIN try
          -- Begin a transaction
          SET @idClient = Isnull((SELECT TOP 1 idclient
                                  FROM   [dbo].[clients]
                                  WHERE  Lower([name]) = Lower(@inName)
                                         AND available = 1), 0)

          IF @idClient <> 0
            BEGIN
                IF @inNewName IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[clients]
                      SET    [name] = @inNewName
                      WHERE  Lower([idclient]) = Lower(@idClient);

                      COMMIT TRANSACTION
                  END

                IF @inNewNumber IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[clients]
                      SET    [contactnumber] = @inNewNumber
                      WHERE  Lower([idclient]) = Lower(@idClient);

                      COMMIT TRANSACTION
                  END

                IF @inNewAddress IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[clients]
                      SET    [address] = @inNewAddress
                      WHERE  Lower([idclient]) = Lower(@idClient);

                      COMMIT TRANSACTION
                  END

                IF @inNewEmail IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[clients]
                      SET    [email] = @inNewEmail
                      WHERE  Lower([idclient]) = Lower(@idClient);

                      COMMIT TRANSACTION
                  END

                SET @output =
                '{"result": 1, "description": "Cliente editado exitosamente."}';

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Brand updated <Name: '
                             + COALESCE(@inNewName, 'Unchanged')
                             + ' - Description: '
                             + COALESCE(@inNewName, 'Unchanged') + '>',
                             Getdate());
            END
          ELSE
            BEGIN
                SET @output =
'{"result": 0, "description": "Ocurrió un error al intentar editar al cliente: '
+ @inName
+ ' No existe o no está disponible."}';
END
END try

    BEGIN catch
        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
          ROLLBACK TRANSACTION;

        SET @output =
        '{"result": 0, "description": "Ocurrió un error al editar al cliente: '
        + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

go 