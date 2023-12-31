USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_client
GO
CREATE PROCEDURE [dbo].[sp_update_client]
    @inName VARCHAR(30),
    @inNewName VARCHAR(30) = NULL,
    @inNewNumber INT = NULL,
    @inNewAddress VARCHAR(50) = NULL,
    @inNewEmail VARCHAR(50) = NULL
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    SET @inNewName = Ltrim(Rtrim(@inNewName));
    DECLARE @output AS NVARCHAR(200);
    DECLARE @idClient INT;
	SET @inNewAddress = Ltrim(Rtrim(@inNewAddress));
    SET @inNewEmail = Ltrim(Rtrim(@inNewEmail));

    BEGIN try
			SET @idClient = Isnull(
			(
				SELECT TOP 1
					idclient
				FROM [dbo].[clients]
				WHERE Lower([name]) = Lower(@inName)
						AND available = 1
			),
			0
					)

			IF @idClient <> 0
			BEGIN
					IF EXISTS
					(
						SELECT 1
						FROM [SGR].[dbo].[cliens]
						WHERE Lower([name]) = Lower(@inNewName)
							AND available = 1
					)
					BEGIN
						SET @output = '{"result": 0, "description": "Error: cliente ya existe"}';
						SELECT @output;
						RETURN;
					END
					IF NOT Len(@inNewName) = 0
					BEGIN
						BEGIN TRANSACTION;
						UPDATE [dbo].[clients]
						SET [name] = @inNewName
						WHERE Lower([idclient]) = Lower(@idClient);
						COMMIT TRANSACTION
					END  
                 
					 IF NOT @inNewNumber = 0
					BEGIN
						BEGIN TRANSACTION;

						UPDATE [dbo].[clients]
						SET [contactnumber] = @inNewNumber
						WHERE Lower([idclient]) = Lower(@idClient);

						COMMIT TRANSACTION
					END
					IF NOT Len(@inNewEmail) = 0
					BEGIN
						IF (PATINDEX('%[^a-zA-Z0-9_\-\.@]%', @inNewEmail) <> 0) OR (CHARINDEX('@', @inNewEmail) <= 1) OR (CHARINDEX('.', @inNewEmail, CHARINDEX('@', @inNewEmail)) <= CHARINDEX('@', @inNewEmail) + 1)
						BEGIN
							SET @output = '{"result": 0, "description": "Error: email inválido"}';
							SELECT @output;
							RETURN;
						END
						BEGIN TRANSACTION;

						UPDATE [dbo].[clients]
						SET [email] = @inNewEmail
						WHERE Lower([idclient]) = Lower(@idClient);

						COMMIT TRANSACTION
					END
                       
					IF NOT LEN(@inNewAddress) = 0
					BEGIN
						 BEGIN TRANSACTION;
						UPDATE [dbo].[clients]
						SET [address] = @inNewAddress
						WHERE Lower([idclient]) = Lower(@idClient);
						COMMIT TRANSACTION
					END
            

				SET @output = '{"result": 1, "description": "Cliente editado exitosamente"}';
			END
			ELSE
			BEGIN
				SET @output
					= '{"result": 0, "description": "Error: cliente no disponible"}';
			END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @output = '{"result": 0, "description": "Error: fallo inesperado en el servidor"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END


GO
