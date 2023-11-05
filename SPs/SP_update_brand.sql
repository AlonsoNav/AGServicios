USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_brand
GO
CREATE PROCEDURE sp_update_brand
	@name VARCHAR(50),
    @newName VARCHAR(50) = NULL,
    @description VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		DECLARE @idBrand INT;
        DECLARE @output NVARCHAR(200);

        BEGIN TRANSACTION;
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        SET @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@name) and available = 1), 0);

        IF @idBrand <> 0
        BEGIN
            DECLARE @sql NVARCHAR(MAX);
            SET @sql = N'UPDATE brands SET ';

            IF LEN(LTRIM(RTRIM(@newName))) > 0
                SET @sql = @sql + N'[name] = @newName ';

            IF LEN(LTRIM(RTRIM(@description))) > 0
            BEGIN
                IF LEN(LTRIM(RTRIM(@newName))) > 0
                    SET @sql = @sql + N', ';

                SET @sql = @sql + N'[description] = @description ';
            END

            SET @sql = @sql + N'WHERE idBrand = @idBrand';

            EXEC sp_executesql @sql,
                N'@newName VARCHAR(50), @description VARCHAR(100), @idBrand INT',
                @newName, @description, @idBrand;

            IF @@ROWCOUNT > 0
            BEGIN
                COMMIT;
                INSERT INTO dbo.EventLog (description, postTime)
                VALUES ('Brand updated <' + ISNULL(@newName, @name) + '>'
                    , GETDATE());

                SET @output = '{"result": 1, "description": "Brand updated successfully."}';
            END
            ELSE
            BEGIN
                ROLLBACK;
                INSERT INTO dbo.EventLog (description, postTime)
                VALUES ('Brand update failed - No changes were made for brand <' + @name + '>.'
                    , GETDATE());

                SET @output = '{"result": 0, "description": "Brand update failed: No changes were made."}';
            END
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Brand update failed - Brand with name <' + @name + '> does not exist.'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Brand update failed: Brand does not exist."}';
        END

        SELECT @output;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() = 1
            ROLLBACK;

        SELECT '{"result": 0, "description": "An error occurred during the update."}';
    END CATCH;
END