USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_machine
GO
CREATE PROCEDURE [dbo].[sp_add_machine]
    @brand VARCHAR(50),
    @type VARCHAR(50),
    @serial VARCHAR(30),
    @model VARCHAR(60)
AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @idBrand INT,
            @idType INT,
            @machineId INT;
    DECLARE @output VARCHAR(200);
    SET @brand = Ltrim(Rtrim(@brand));
    SET @type = Ltrim(Rtrim(@type));
    SET @serial = Ltrim(Rtrim(@serial));
    SET @model = Ltrim(Rtrim(@model));
    BEGIN TRY
        IF Len(@brand) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: marca vacía"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@type) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: tipo de maquinaria vacía"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@serial) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: serial vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@model) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: modelo vacío"}';
            SELECT @output;
            RETURN;
        END
        SELECT @idBrand = ISNULL(
                          (
                              SELECT TOP 1 idBrand FROM dbo.brands WHERE Lower([name]) = Lower(@brand) AND available =1
                          ),
                          0
                                );
        SELECT @idType = ISNULL(
                         (
                             SELECT TOP 1
                                 idtypemachine
                             FROM dbo.typesMachine
                             WHERE Lower([name]) = Lower(@type) AND available = 1
                         ),
                         0
                               );
        IF EXISTS (SELECT 1 FROM SGR.dbo.machines WHERE [serial] = @serial)
        BEGIN
            SET @output= '{"result": 0, "description": "Error: máquina ya existe"}';
        END
        ELSE IF @idBrand = 0 OR @idType = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: Marca o maquinaria no disponible"}';
			SELECT @output
			RETURN;
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO [SGR].[dbo].[machines]
            (
                [idBrand],
                [idType],
                [serial],
                [model]
            )
            VALUES
            (@idBrand, @idType, @serial, @model);
            COMMIT TRANSACTION;
            SET @output = '{"result": 1, "description": "Máquina añadida exitosamente"}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @output
            = '{"result": 0, "description": "Error: fallo inesperado en el servidor"}';
    END CATCH
    SELECT @output;
    SET NOCOUNT OFF;
END
GO