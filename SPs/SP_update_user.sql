USE SGR
GO
DROP PROCEDURE IF EXISTS sp_update_user
GO
CREATE PROCEDURE [dbo].[sp_update_user] @inUsername VARCHAR(16), @inNewUsername VARCHAR(16), @inNewName VARCHAR(80), @inNewNumber INT, @inNewPassword VARBINARY(max)
AS BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @output AS NVARCHAR(200);
    DECLARE @idUser INT;
    SET @inNewUsername=Ltrim(Rtrim(@inNewUsername));
    SET @inNewName=Ltrim(Rtrim(@inNewName));
    BEGIN try
        SET @idUser=Isnull((SELECT TOP 1 iduser
                            FROM [dbo].[users]
                            WHERE Lower([username])=Lower(@inUsername)AND available=1 AND [isadmin]=0), 0)
        IF @idUser<>0 BEGIN
            IF NOT Len(@inNewUsername)=0 BEGIN
                BEGIN TRANSACTION;
                UPDATE [dbo].[users] SET [username]=@inNewUsername WHERE iduser=@idUser;
                COMMIT TRANSACTION
            END
            IF NOT Len(@inNewName)=0 BEGIN
                BEGIN TRANSACTION;
                UPDATE [dbo].[users] SET NAME=@inNewName WHERE iduser=@idUser;
                COMMIT TRANSACTION
            END
            IF NOT @inNewNumber=0 --ni idea de cómo se maneje en la app los números
            BEGIN
                BEGIN TRANSACTION;
                UPDATE [dbo].[users] SET number=@inNewNumber WHERE iduser=@idUser;
                COMMIT TRANSACTION
            END
            BEGIN TRANSACTION;
            UPDATE [dbo].[users] SET password=@inNewPassword WHERE iduser=@idUser;
            COMMIT TRANSACTION
            SET @output='{"success": 1, "description": "Usuario editado exitosamente"}';
        END
        ELSE BEGIN
            SET @output='{"success": 0, "description": "Error: usuario no existe o no es admin"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT>0 ROLLBACK;
        SET @output='{"success": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
END
GO
