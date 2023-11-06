USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_brand
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL,
    @inDescription VARCHAR(100) = NULL
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idBrand INT;
    SET @inNewName = Ltrim(Rtrim(@inNewName));
    SET @inDescription = Ltrim(Rtrim(@inDescription));
    DECLARE @output VARCHAR(200);

    BEGIN try
        SET @idBrand = Isnull(
                      (
                          SELECT TOP 1
                              idBrand
                          FROM [dbo].[brands]
                          WHERE Lower([name]) = Lower(@inName)
                                AND available = 1
                      ),
                      0
                            )

        IF @idBrand <> 0
        BEGIN
            IF EXISTS
            (
                SELECT 1
                FROM [dbo].[brands]
                WHERE Lower([name]) = Lower(@inName)
                    AND [available] = 1
            )
            BEGIN
                
                    IF NOT Len(@inDescription) = 0
                    BEGIN
                        BEGIN TRANSACTION;

                        UPDATE [dbo].[brands]
                        SET [description] = @inDescription
                        WHERE idBrand = Lower(@idBrand);

                        COMMIT TRANSACTION
                    END
                
                    IF NOT Len(@inNewName) = 0
                    BEGIN
                        BEGIN TRANSACTION;

                        UPDATE [dbo].[brands]
                        SET [name] = @inNewName
                        WHERE idBrand = Lower(@idBrand);

                        COMMIT TRANSACTION;
                    END
                

                SET @output = '{"result": 1, "description": "Marca editada exitosamente."}';
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

        SET @output = '{"result": 0, "description": "Error inesperado"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

go