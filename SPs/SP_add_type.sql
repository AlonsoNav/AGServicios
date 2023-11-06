USE SGR
GO
DROP PROCEDURE IF EXISTS sp_add_type
GO
CREATE PROCEDURE [dbo].[Sp_add_type]
    @name VARCHAR(50),
    @description VARCHAR(80)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;

    DECLARE @idType INT;
    DECLARE @output VARCHAR(200);
    SET @name = Ltrim(Rtrim(@name));
    SET @description = Ltrim(Rtrim(@description));

    BEGIN try
        IF Len(@name) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: El nombre del tipo de maquinaria está vacío"}';

            SELECT @output;

            RETURN;
        END

        IF Len(@description) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: La descripción del tipo de maquinaria está vacía"}';

            SELECT @output;

            RETURN;
        END

        SELECT @idType = Isnull(
                         (
                             SELECT TOP 1
                                 idtypemachine
                             FROM typesmachine
                             WHERE Lower([name]) = Lower(@name)
                         ),
                         0
                               );

        IF @idType = 0
        BEGIN
            INSERT INTO dbo.eventlog
            (
                description,
                posttime
            )
            VALUES
            ('Fallo en la inserción del tipo de máquina - NOMBRE DUPLICADO <' + 'Nombre: ' + @name + ' - Descripción: '
             +  @description + '>',
             Getdate()
            );

            SET @output
                = '{"result": 0, "description": "Fallo en la inserción del tipo de máquina: El nombre ya existe."}';
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION;

            INSERT INTO typesmachine
            (
                [name],
                [description]
            )
            VALUES
            (@name, @description);

            COMMIT TRANSACTION;

            INSERT INTO dbo.eventlog
            (
                description,
                posttime
            )
            VALUES
            ('Nuevo tipo de máquina agregado <' + 'Nombre: ' + @name + ' - Descripción: ' + @description + '>',
             Getdate()
            );

            SET @output = '{"result": 1, "description": "Nuevo tipo de máquina agregado exitosamente."}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error during type machine insertion: ' + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

go