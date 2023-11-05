USE SGR
GO
DROP PROCEDURE IF EXISTS sp_delete_machine
GO
CREATE PROCEDURE sp_delete_machine
	@serial varchar(30)

AS
BEGIN
	DECLARE @idMachine INT;
    DECLARE @output VARCHAR(200);

    SET @idMachine = ISNULL((SELECT TOP 1 idMachine FROM machines WHERE serial = @serial and available = 1), 0);

    IF @idMachine <> 0
    BEGIN
        UPDATE machines SET available = 0 WHERE idMachine = @idMachine;

        INSERT INTO dbo.EventLog(description, postTime)
        VALUES ('Máquina eliminada <Serial ' + @serial + '>', GETDATE());

        SET @output = '{"result": 1, "description": "Máquina eliminada exitosamente."}';
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog(description, postTime)
        VALUES ('Fallo en la eliminación de la máquina - La máquina con serial ' + @serial + ' no existe.'
            , GETDATE());

        SET @output = '{"result": 0, "description": "Fallo en la eliminación de la máquina: La máquina no existe."}';
    END

    SELECT @output;
END