USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_type
GO
CREATE PROCEDURE sp_delete_type
	@name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
	DECLARE @idType INT;
    DECLARE @output NVARCHAR(200);

    SET @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@name) and available=1), 0)

    IF @idType <> 0
    BEGIN
        UPDATE typesMachine SET available = 0 WHERE idTypeMachine = @idType;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Tipo de máquina eliminado <Tipo de máquina: ' + @name + '>'
            , GETDATE());

        SET @output = '{"result": 1, "description": "Tipo de máquina eliminado exitosamente."}';
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Fallo en la eliminación del tipo de máquina - El tipo de máquina con nombre ' + @name + ' no existe.'
            , GETDATE());

        SET @output = '{"result": 0, "description": "Fallo en la eliminación del tipo de máquina: El tipo de máquina no existe."}';
    END

    SELECT @output;
END