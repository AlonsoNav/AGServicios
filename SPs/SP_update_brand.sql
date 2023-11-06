USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_brand
GO
CREATE PROCEDURE [dbo].[sp_update_brand] @inName        VARCHAR(50),
                                         @inNewName     VARCHAR(50) = NULL,
                                         @inDescription VARCHAR(100) = NULL
AS
  BEGIN
      SET nocount ON;
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output VARCHAR(200);

      BEGIN try
          -- Begin a transaction
          IF EXISTS (SELECT 1
                     FROM   [dbo].[brands]
                     WHERE  Lower([name]) = Lower(@inName)
                            AND [available] = 1)
            BEGIN
                IF @inDescription IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[brands]
                      SET    [description] = @inDescription
                      WHERE  Lower([name]) = Lower(@inName);

                      COMMIT TRANSACTION
                  END

                IF @inNewName IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION;

                      UPDATE [dbo].[brands]
                      SET    [name] = @inNewName
                      WHERE  Lower([name]) = Lower(@inName);

                      COMMIT TRANSACTION;
                  END

                SET @output =
                '{"result": 1, "description": "Marca editada exitosamente."}';

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('Brand updated <Name: '
                             + COALESCE(@inNewName, 'Unchanged')
                             + ' - Description: '
                             + COALESCE(@inDescription, 'Unchanged') + '>',
                             Getdate());
            END
          ELSE
            BEGIN
                SET @output =
'{"result": 0, "description": "Ocurrió un error al intentar editar la marca: '
+ @inName
+ ' No existe o no está disponible."}';
END
END try

    BEGIN catch
        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
          ROLLBACK TRANSACTION;

        SET @output =
        '{"result": 0, "description": "Ocurrió un error al editar la marca: '
        + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

go 