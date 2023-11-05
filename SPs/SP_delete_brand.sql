USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_brand
GO
CREATE PROCEDURE sp_delete_brand
	@name VARCHAR(50)
AS
BEGIN
	DECLARE @idBrand INT;
    DECLARE @output VARCHAR(200);

    SET @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@name) and available = 1), 0)

    IF @idBrand <> 0
    BEGIN
        UPDATE brands SET available = 0 WHERE idBrand = @idBrand;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Marca eliminada <' + @name + '>'
            , GETDATE());

        SET @output = '{"result": 1, "description": "Marca eliminada exitosamente."}';
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Fallo en la eliminación de la marca - La marca con nombre ' + @name + ' no existe.'
            , GETDATE());

        SET @output = '{"result": 0, "description": "Fallo en la eliminación de la marca: La marca no existe."}';
    END

    SELECT @output;
END