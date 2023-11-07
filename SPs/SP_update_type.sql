USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_type
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50),
    @inDescription VARCHAR(100)
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idTypeMachine INT;
    SET @inDescription = Ltrim(Rtrim(@inDescription));
    SET @inNewName = Ltrim(Rtrim(@inNewName));
    DECLARE @output VARCHAR(200);

    BEGIN try

        SET @idTypeMachine = Isnull(
            (
                SELECT TOP 1
                    idTypeMachine
                FROM [dbo].[typesMachine]
                WHERE Lower([name]) = Lower(@inName)
                    AND available = 1
            ),
            0
                )
        IF @idTypeMachine <> 0
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
                        IF NOT Len(@inDescription) = 0
                        BEGIN
                            BEGIN TRANSACTION;

                            UPDATE [dbo].[typesmachine]
                            SET [description] = @inDescription
                            WHERE idTypeMachine = @idTypeMachine;

                            COMMIT TRANSACTION;
                        END
                    
                        IF NOT Len(@inNewName) = 0
                            BEGIN
                            BEGIN TRANSACTION;
                            UPDATE [dbo].[typesmachine]
                            SET [name] = @inNewName
                            WHERE idTypeMachine = @idTypeMachine;
                            COMMIT TRANSACTION;
                        END
                    

                    SET @output = '{"result": 1, "description": "Maquinaria editada exitosamente."}';
                END
                ELSE
                BEGIN
                    SET @output
                        = '{"result": 0, "description": "Error: tipo de máquina no disponible"}';
                END
            END
            ELSE
            BEGIN
                SET @output
                    = '{"result": 0, "description": "Error: tipo de máquina ya existe"}';
            END
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @output
            = '{"result": 0, "description": "Error inesperado"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

go