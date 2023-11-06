USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_type
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL,
    @inDescription VARCHAR(100) = NULL
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;

    DECLARE @output VARCHAR(200);

    BEGIN try
        IF @inNewName IS NOT NULL
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM [dbo].[typesmachine]
                WHERE Lower([name]) = Lower(@inNewName)
            )
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM [dbo].[typesmachine]
                    WHERE Lower([name]) = Lower(@inName)
                          AND available = 1
                )
                BEGIN
                    IF @inDescription IS NOT NULL
                    BEGIN
                        SET @inDescription = Ltrim(Rtrim(@inDescription));
                        IF Len(@inDescription) = 0
                        BEGIN
                            SET @output = '{"result": 0, "description": "Error: El nombre del tipo de maquinaria está vacío"}';

                            SELECT @output;

                            RETURN;
                        END
                        BEGIN TRANSACTION;

                        UPDATE [dbo].[typesmachine]
                        SET [description] = @inDescription
                        WHERE Lower([name]) = Lower(@inName);

                        COMMIT TRANSACTION;
                    END

                    IF @inNewName IS NOT NULL
                    BEGIN
                        SET @inNewName = Ltrim(Rtrim(@inNewName));
                        IF Len(@inNewName) = 0
                        BEGIN
                            SET @output = '{"result": 0, "description": "Error: El nombre del tipo de máquina no puede ser vacío."}';

                            SELECT @output;

                            RETURN;
                        END
                        BEGIN TRANSACTION

                        UPDATE [dbo].[typesmachine]
                        SET [name] = @inNewName
                        WHERE Lower([name]) = Lower(@inName);

                        COMMIT TRANSACTION;
                    END

                    SET @output = '{"result": 1, "description": "Maquinaria editada exitosamente."}';
                END
                ELSE
                BEGIN
                    SET @output
                        = '{"result": 0, "description": "Ocurrió un error al intentar editar la maquinaria: ' + @inName
                          + ' No existe o no está disponible."}';
                END
            END
            ELSE
            BEGIN
                SET @output
                    = '{"result": 0, "description": "Ocurrió un error al intentar editar la maquinaria: ' + @inName
                      + ' Ya existe."}';
            END
        END

        INSERT INTO dbo.eventlog
        (
            description,
            posttime
        )
        VALUES
        ('TypeMachine updated <Name: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: '
         +  COALESCE(@inDescription, 'Unchanged') + '>',
         Getdate()
        );
    END try
    BEGIN catch
        ERRORHANDLING:

        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @output
            = '{"result": 0, "description": "Ha ocurrido un error al intentar editar el tipo de máquina: '
              + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

go