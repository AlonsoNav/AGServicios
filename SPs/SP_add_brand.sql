USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_brand
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @name VARCHAR(50),
    @description VARCHAR(80)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idBrand INT;
    DECLARE @output VARCHAR(200);
    SET @name = Ltrim(Rtrim(@name));
    SET @description = Ltrim(Rtrim(@description));
    BEGIN try
        IF Len(@name) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@description) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: descripción vacía"}';
            SELECT @output;
            RETURN;
        END
        SELECT @idBrand = Isnull(
                (
                    SELECT TOP 1
                        idBrand
                    FROM brands
                    WHERE Lower([name]) = Lower(@name)
                    AND available = 1
                ),
                0
                    );
        IF @idBrand = 0
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO brands
            (
                [name],
                [description]
            )
            VALUES
            (@name, @description);
            SET @output = '{"result": 1, "description": "Marca agregada con éxito"}';
            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            SET @output
                = '{"result": 0, "description": "Error: el nombre ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;
        SET @output = '{"result": 0, "description": "Error: fallo inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

GO