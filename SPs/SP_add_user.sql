USE [SGR]
GO
/****** Object:  StoredProcedure [dbo].[sp_add_user]    Script Date: 26/10/2023 20:25:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_add_user]
    @username VARCHAR(16),
    @name VARCHAR(80),
    @number int,
    @password VARBINARY(64)  -- El hash de la contraseña
AS
BEGIN
    -- Inserta el nuevo usuario en la tabla Usuarios
    INSERT INTO users(username, name, number, password)
    VALUES (@username, @name, @number, @password);

	--Inserta en el log la accion de nuevo usuario registrado
	INSERT INTO dbo.EventLog(description,postTime)
	VALUES ('User inserted <username '+@username+ '-name '+@name+ '-number '+@number + '-password '+@password+'>', GETDATE());
END;