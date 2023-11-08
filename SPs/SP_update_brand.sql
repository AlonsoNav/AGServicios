USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_brand
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @name VARCHAR(50),
    @newName VARCHAR(50),
    @description VARCHAR(100)
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idBrand INT;
    SET @description = Ltrim(Rtrim(@description));
    SET @newName = Ltrim(Rtrim(@newName));
    DECLARE @output VARCHAR(200);

    BEGIN try

        SET @idBrand = Isnull(
            (
                SELECT TOP 1
                    idBrand
                FROM [dbo].[brands]
                WHERE Lower([name]) = Lower(@name)
                    AND available = 1
            ),
            0
                )
        IF @idBrand <> 0
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM [dbo].[brands]
                WHERE Lower([name]) = Lower(@newName)
            )
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM [dbo].[brands]
                    WHERE Lower([name]) = Lower(@name)
                          AND available = 1
                )
                
                    BEGIN
                        IF NOT Len(@description) = 0
                        BEGIN
                            BEGIN TRANSACTION;

                            UPDATE [dbo].[brands]
                            SET [description] = @description
                            WHERE idBrand = @idBrand;

                            COMMIT TRANSACTION;
                        END
                    
                        IF NOT Len(@inNewName) = 0
                            BEGIN
                            BEGIN TRANSACTION;
                            UPDATE [dbo].[brands]
                            SET [name] = @newName
                            WHERE idBrand = @idBrand;
                            COMMIT TRANSACTION;
                        END
                    

                    SET @output = '{"result": 1, "description": "Marca editada exitosamente."}';
                END
                ELSE
                BEGIN
                    SET @output
                        = '{"result": 0, "description": "Error: marca no disponible"}';
                END
            END
            ELSE
            BEGIN
                SET @output
                    = '{"result": 0, "description": "Error: marca ya existe"}';
            END
        END
        ELSE
        BEGIN
            SET @output
                        = '{"result": 0, "description": "Error: marca no disponible"}';
        END

    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @output
            = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

go