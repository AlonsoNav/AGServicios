USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_type
GO
CREATE PROCEDURE sp_add_type
	@name VARCHAR(50),
	@description VARCHAR(80)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @idType INT;
    DECLARE @output VARCHAR(200);

    BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRY
        SELECT @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@name)), 0);

        IF @idType = 0
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Fallo en la inserción del tipo de máquina - NOMBRE DUPLICADO <' + 'Nombre: ' + @name + ' - Descripción: ' + @description + '>'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la inserción del tipo de máquina: El nombre ya existe."}';
        END
        ELSE
        BEGIN
            INSERT INTO typesMachine ([name],[description])
            VALUES (@name, @description);

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Nuevo tipo de máquina agregado <' + 'Nombre: ' + @name + ' - Descripción: ' + @description + '>'
                , GETDATE());

            SET @output = '{"result": 1, "description": "Nuevo tipo de máquina agregado exitosamente."}';
        END

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        SET @output = '{"result": 0, "description": "Error during type machine insertion: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
END