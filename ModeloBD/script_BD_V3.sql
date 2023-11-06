USE [master]
GO
/****** Object:  Database [SGR]    Script Date: 1/11/2023 22:28:27 ******/
CREATE DATABASE [SGR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SGR', FILENAME = N'D:\rdsdbdata\DATA\SGR.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'SGR_log', FILENAME = N'D:\rdsdbdata\DATA\SGR_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SGR] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SGR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SGR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SGR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SGR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SGR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SGR] SET ARITHABORT OFF 
GO
ALTER DATABASE [SGR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SGR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SGR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SGR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SGR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SGR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SGR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SGR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SGR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SGR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SGR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SGR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SGR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SGR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SGR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SGR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SGR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SGR] SET RECOVERY FULL 
GO
ALTER DATABASE [SGR] SET  MULTI_USER 
GO
ALTER DATABASE [SGR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SGR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SGR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SGR] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SGR] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SGR] SET QUERY_STORE = OFF
GO
USE [SGR]
GO
/****** Object:  User [admin]    Script Date: 1/11/2023 22:28:30 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brands](
	[idBrand] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[idBrand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clients]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clients](
	[idClient] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[contactNumber] [int] NOT NULL,
	[address] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBErrors]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBErrors](
	[idError] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[errorNumber] [int] NULL,
	[severity] [int] NULL,
	[message] [varchar](max) NULL,
	[datetime] [datetime] NULL,
 CONSTRAINT [PK_DBErrors] PRIMARY KEY CLUSTERED 
(
	[idError] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[idEvent] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](200) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[postBy] [int] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[idEvent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[machines]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[machines](
	[idMachine] [int] IDENTITY(1,1) NOT NULL,
	[serial] [varchar](30) NULL,
	[model] [varchar](60) NULL,
	[idBrand] [int] NOT NULL,
	[idType] [int] NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_Machine] PRIMARY KEY CLUSTERED 
(
	[idMachine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[maintenances]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[maintenances](
	[idMaintenance] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[idClient] [int] NOT NULL,
	[idMachine] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[isCorrective] [bit] NOT NULL,
	[remarks] [varchar](300) NOT NULL,
 CONSTRAINT [PK_Maintenance] PRIMARY KEY CLUSTERED 
(
	[idMaintenance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[typesMachine]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[typesMachine](
	[idTypeMachine] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_TypeMachine] PRIMARY KEY CLUSTERED 
(
	[idTypeMachine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](16) NOT NULL,
	[name] [varchar](80) NOT NULL,
	[number] [int] NOT NULL,
	[password] [varbinary](max) NOT NULL,
	[isAdmin] [bit] NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_Technician] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[brands] ADD  CONSTRAINT [DF_Brand_available]  DEFAULT ((1)) FOR [available]
GO
ALTER TABLE [dbo].[clients] ADD  CONSTRAINT [DF_Client_available]  DEFAULT ((1)) FOR [available]
GO
ALTER TABLE [dbo].[machines] ADD  CONSTRAINT [DF_Machine_available]  DEFAULT ((1)) FOR [available]
GO
ALTER TABLE [dbo].[typesMachine] ADD  CONSTRAINT [DF_TypeMachine_available]  DEFAULT ((1)) FOR [available]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_isAdmin]  DEFAULT ((0)) FOR [isAdmin]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_available]  DEFAULT ((1)) FOR [available]
GO
ALTER TABLE [dbo].[machines]  WITH CHECK ADD  CONSTRAINT [FK_Machine_Brand] FOREIGN KEY([idType])
REFERENCES [dbo].[brands] ([idBrand])
GO
ALTER TABLE [dbo].[machines] CHECK CONSTRAINT [FK_Machine_Brand]
GO
ALTER TABLE [dbo].[machines]  WITH CHECK ADD  CONSTRAINT [FK_Machine_TypeMachine] FOREIGN KEY([idType])
REFERENCES [dbo].[typesMachine] ([idTypeMachine])
GO
ALTER TABLE [dbo].[machines] CHECK CONSTRAINT [FK_Machine_TypeMachine]
GO
ALTER TABLE [dbo].[maintenances]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Client] FOREIGN KEY([idClient])
REFERENCES [dbo].[clients] ([idClient])
GO
ALTER TABLE [dbo].[maintenances] CHECK CONSTRAINT [FK_Maintenance_Client]
GO
ALTER TABLE [dbo].[maintenances]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Machine] FOREIGN KEY([idMachine])
REFERENCES [dbo].[machines] ([idMachine])
GO
ALTER TABLE [dbo].[maintenances] CHECK CONSTRAINT [FK_Maintenance_Machine]
GO
ALTER TABLE [dbo].[maintenances]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Technician] FOREIGN KEY([idUser])
REFERENCES [dbo].[users] ([idUser])
GO
ALTER TABLE [dbo].[maintenances] CHECK CONSTRAINT [FK_Maintenance_Technician]
GO
/****** Object:  StoredProcedure [dbo].[sp_add_brand]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @name VARCHAR(50),
    @description VARCHAR(100)
AS
BEGIN
    DECLARE @output NVARCHAR(200);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- leer cualquier dato en la base
        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        IF NOT EXISTS (SELECT 1 FROM brands WHERE LOWER([name]) = LOWER(@name))
        BEGIN
            INSERT INTO brands (name, description)
            VALUES (@name, @description);

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New brand added <' + @name + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Marca añadida exitosamente"}';

            COMMIT TRANSACTION; 
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de marca fallida: la marca ya existe"}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir la marca: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_client]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_client]
    @name VARCHAR(50),
    @number INT,
    @address VARCHAR(50),
    @email VARCHAR(50)
AS
BEGIN
    DECLARE @output NVARCHAR(200);

    BEGIN TRY
        BEGIN TRANSACTION;

        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        IF NOT EXISTS (SELECT 1 FROM clients WHERE LOWER([name]) = LOWER(@name))
        BEGIN
            INSERT INTO clients ([name], [contactNumber], [address], [email])
            VALUES (@name, @number, @address, @email);

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New client added <Name: ' + @name + ' - Number: ' + CAST(@number AS VARCHAR) + ' - Address: ' + @address + ' - Email: ' + @email + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Cliente añadido exitosamente"}';

            COMMIT TRANSACTION; 
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de cliente fallida: El cliente ya existe"}';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_machine]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_machine]
	@brand VARCHAR(50),
    @type VARCHAR(50),
    @serial VARCHAR(30),
    @model VARCHAR(60)
AS
BEGIN

	DECLARE @idBrand INT, @idType INT, @machineId INT;
  
    DECLARE @output NVARCHAR(200);

	BEGIN TRY

		BEGIN TRANSACTION;

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		SELECT @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@brand)), 0);
		SELECT @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@type)), 0);

		IF EXISTS (SELECT 1 FROM machines WHERE [serial] = @serial)
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la inserción de la máquina - MISMO NÚMERO DE SERIE <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la inserción de la máquina: Ya existe una máquina con el mismo número de serie."}';

		END
		ELSE IF @idBrand = 0 OR @idType = 0 
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la inserción de la máquina - MARCA O TIPO NO ENCONTRADOS <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la inserción de la máquina: Marca o tipo de máquina no encontrados."}';

		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[Machine] ([idBrand], [idType], [serial], [model])
			VALUES (@idBrand, @idType, @serial, @model);

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Nueva máquina agregada <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Nueva máquina agregada exitosamente."}';

			COMMIT TRANSACTION;
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
	END CATCH

    SELECT @output;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_add_type]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_type]
    @name VARCHAR(50),
    @description VARCHAR(80)
AS
BEGIN
	DECLARE @idType INT;
    DECLARE @output NVARCHAR(200);
	
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
GO
/****** Object:  StoredProcedure [dbo].[sp_add_user]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_user]
	@username VARCHAR(16),
    @name VARCHAR(80),
    @number INT,
    @password VARBINARY(64)  -- El hash de la contraseña
AS
BEGIN
	DECLARE @output NVARCHAR(200);

    BEGIN TRANSACTION;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM users WHERE LOWER(username) = LOWER(@username))
        BEGIN

            INSERT INTO users(username, name, number, password, isAdmin)
            VALUES (@username, @name, @number, @password, 1);

    
            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User inserted <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());


            SET @output = '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}';

            COMMIT; 
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User insertion failed <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la inserción del usuario: El nombre de usuario ya existe."}';

        END
    END TRY
    BEGIN CATCH
        
        ROLLBACK;

        SET @output = '{"result": 0, "description": "Error durante la inserción del usuario."}';
    END CATCH

    SELECT @output;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_brand]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_brand]
	@name VARCHAR(50)
AS
BEGIN
    DECLARE @idBrand INT;
    DECLARE @output NVARCHAR(200);

	-- marca existe?
    SELECT @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@name)), 0)

    IF @idBrand <> 0
    BEGIN	
		-- marca disponible?
        IF (SELECT TOP 1 available FROM brands WHERE idBrand = @idBrand) = 1
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
            VALUES ('Fallo en la eliminación de la marca - La marca ' + @name + ' no está disponible.'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la eliminación de la marca: La marca no está disponible."}';
        END
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
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_machine]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_machine]
	@serial VARCHAR(30)
AS
BEGIN
    DECLARE @idMachine INT;
    DECLARE @output NVARCHAR(200);

    SELECT @idMachine = idMachine FROM machines WHERE serial = @serial;

    IF @idMachine IS NOT NULL
    BEGIN

        IF (SELECT TOP 1 available FROM machines WHERE idMachine = @idMachine) = 1
        BEGIN

            UPDATE machines SET available = 0 WHERE idMachine = @idMachine;

            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('Máquina eliminada <Serial ' + @serial + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Máquina eliminada exitosamente."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('Fallo en la eliminación de la máquina - La máquina con serial ' + @serial + ' no está disponible.'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la eliminación de la máquina: La máquina no está disponible."}';
        END
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
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_type]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_type]
	@name VARCHAR(50)
AS
BEGIN
    DECLARE @idType INT;
    DECLARE @result INT;
    DECLARE @output NVARCHAR(200);

    SELECT @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@name)), 0)

    IF @idType <> 0
    BEGIN
        IF (SELECT TOP 1 available FROM typesMachine WHERE idTypeMachine = @idType) = 1
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
            VALUES ('Fallo en la eliminación del tipo de máquina - El tipo de máquina ' + @name + ' no está disponible.'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la eliminación del tipo de máquina: El tipo de máquina no está disponible."}';
        END
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
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_user]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_user]
	@username VARCHAR(16)
AS
BEGIN
    DECLARE @idUser INT;
    DECLARE @output NVARCHAR(200);

    SELECT @idUser = ISNULL((SELECT TOP 1 idUser FROM users WHERE LOWER([username]) = LOWER(@username)), 0)

    IF @idUser <> 0
    BEGIN
        -- Check if the user is available
        IF (SELECT TOP 1 available FROM users WHERE idUser = @idUser) = 1
        BEGIN
            -- Mark the user as unavailable
            UPDATE users SET available = 0 WHERE idUser = @idUser;

            -- Insert the action into the EventLog
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Usuario eliminado <Nombre de usuario: ' + @username + '>'
                , GETDATE());

            SET @output = '{"result": 1, "description": "Usuario eliminado exitosamente."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Fallo en la eliminación del usuario - El usuario ' + @username + ' no está disponible.'
                , GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la eliminación del usuario: El usuario no está disponible."}';
        END
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Fallo en la eliminación del usuario - El usuario con nombre ' + @username + ' no existe.'
            , GETDATE());

        SET @output = '{"result": 0, "description": "Fallo en la eliminación del usuario: El usuario no existe."}';
    END

    SELECT @output;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_brand]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_brand]
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, description FROM brands WHERE LOWER([name]) = LOWER(@name) and available = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_machine]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_machine]
	@serial VARCHAR(30)
AS
BEGIN
	SELECT M.[serial], M.[model], B.[name] brand, TM.[name] type
    FROM [dbo].[Machine] M
    INNER JOIN brands B ON M.[idBrand] = B.[idBrand]
    INNER JOIN typesMacine TM ON M.[idType] = TM.[idTypeMachine]
    WHERE M.[serial] = @serial and available = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_type]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_type]
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, description FROM typesMachine WHERE LOWER([name]) = LOWER(@name);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_user]
	@username VARCHAR(50)
AS
BEGIN
	SELECT username, name, number, password, isAdmin FROM users WHERE LOWER([username]) = LOWER(@username);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_brand]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @name VARCHAR(50),
    @newName VARCHAR(50) = NULL,
    @description VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		
		DECLARE @idBrand INT;
        DECLARE @output NVARCHAR(200);
        DECLARE @brandAvailable BIT;
		
        BEGIN TRANSACTION;
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

        SELECT @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@name)), 0);
        SELECT @brandAvailable = ISNULL((SELECT TOP 1 available FROM brands WHERE idBrand = @idBrand), 0);

        IF @idBrand <> 0
        BEGIN
            IF @brandAvailable = 1
            BEGIN
                DECLARE @sql NVARCHAR(MAX);
                SET @sql = N'UPDATE brands SET ';

                IF @newName IS NOT NULL
                    SET @sql = @sql + N'[name] = @newName ';

                IF @description IS NOT NULL
                BEGIN
                    IF @newName IS NOT NULL
                        SET @sql = @sql + N', ';

                    SET @sql = @sql + N'[description] = @description ';
                END

                SET @sql = @sql + N'WHERE idBrand = @idBrand';

                -- Execute the dynamic SQL query
                EXEC sp_executesql @sql, 
                    N'@newName VARCHAR(50), @description VARCHAR(100), @idBrand INT', 
                    @newName, @description, @idBrand;

                -- Check the result and create the JSON response
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
                VALUES ('Brand update failed - Brand <' + @name + '> is not available.'
                    , GETDATE());

                SET @output = '{"result": 0, "description": "Brand update failed: Brand is not available."}';
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
GO
/****** Object:  StoredProcedure [dbo].[sp_update_machine]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Delete an existing Machine
CREATE PROCEDURE [dbo].[sp_update_machine]
    @inSerial VARCHAR(30),
    @inNewModel VARCHAR(60) = NULL,
    @inNewSerial VARCHAR(30) = NULL
AS
BEGIN
    DECLARE @Result AS NVARCHAR(200);
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM [dbo].[machines] WHERE [serial] = @inSerial AND [available] = 1)
        BEGIN
            DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[machines] SET';
            DECLARE @Success INT = 0;

            IF @inNewModel IS NOT NULL
            BEGIN
                SET @sql = @sql + ' [model] = @inNewModel';
                SET @Success = 1;
            END

            IF @inNewSerial IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [serial] = @inNewSerial';
                SET @Success = 1;
            END

            SET @sql = @sql + ' WHERE [serial] = @inSerial';

            -- Execute dynamic SQL
            EXEC sp_executesql @sql, N'@inNewModel VARCHAR(60), @inNewSerial VARCHAR(30), @inSerial VARCHAR(30)', @inNewModel, @inNewSerial, @inSerial;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine updated <Serial: ' + @inSerial + ' - Model: ' + COALESCE(@inNewModel, 'Unchanged') + ' - New Serial: ' + COALESCE(@inNewSerial, 'Unchanged') + '>', GETDATE());

            COMMIT; -- Commit the transaction
            SET @Result = '{"success": 1, "description": "Machine updated successfully."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine update failed - Machine with serial number ' + @inSerial + ' does not exist or is not available.', GETDATE());

            ROLLBACK; -- Rollback the transaction
            SET @Result = '{"success": 0, "description": "Machine update failed - Machine with serial number ' + @inSerial + ' does not exist or is not available."}';
        END
    END TRY
    BEGIN CATCH
        -- Handle exceptions and rollback the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Log the error and return an error message
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the machine.', GETDATE());

        SET @Result = '{"success": 0, "description": "An error occurred while updating the machine."}';
    END CATCH

    SELECT @Result AS 'Result';
END


GO
/****** Object:  StoredProcedure [dbo].[sp_update_type]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL,
    @inDescription VARCHAR(100) = NULL,
    @inAvailable BIT = NULL
AS
BEGIN
    DECLARE @Result AS NVARCHAR(MAX);
    BEGIN TRY
        BEGIN TRANSACTION; -- Start a transaction

        -- Check if the TypeMachine with the specified name exists
        IF EXISTS (SELECT 1 FROM [dbo].[typesMachine] WHERE LOWER([name]) = LOWER(@inName))
        BEGIN
            DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[typesMachine] SET';
            DECLARE @Success INT = 0;

            -- Build dynamic SQL to conditionally update columns
            IF @inNewName IS NOT NULL
            BEGIN
                SET @sql = @sql + ' [name] = @inNewName';
                SET @Success = 1;
            END

            IF @inDescription IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [description] = @inDescription';
                SET @Success = 1;
            END

            IF @inAvailable IS NOT NULL
            BEGIN
                IF @Success = 1
                BEGIN
                    SET @sql = @sql + ',';
                END
                SET @sql = @sql + ' [available] = @inAvailable';
                SET @Success = 1;
            END

            SET @sql = @sql + ' WHERE LOWER([name]) = LOWER(@inName)';

            -- Execute dynamic SQL
            EXEC sp_executesql @sql, N'@inNewName VARCHAR(50), @inDescription VARCHAR(100), @inAvailable BIT, @inName VARCHAR(50)', @inNewName, @inDescription, @inAvailable, @inName;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine type updated <TypeMachine: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: ' + COALESCE(@inDescription, 'Unchanged') + ' - Available: ' + COALESCE(CAST(@inAvailable AS VARCHAR), 'Unchanged') + '>', GETDATE());

            COMMIT; -- Commit the transaction
            SET @Result = '{"success": 1, "description": "Machine type updated successfully."}';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Machine type update failed - TypeMachine with name ' + @inName + ' does not exist.', GETDATE());

            ROLLBACK; -- Rollback the transaction
            SET @Result = '{"success": 0, "description": "Machine type update failed - TypeMachine with name ' + @inName + ' does not exist."}';
        END
    END TRY
    BEGIN CATCH
        -- Handle exceptions and rollback the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Log the error and return an error message
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the machine type.', GETDATE());

        SET @Result = '{"success": 0, "description": "An error occurred while updating the machine type."}';
    END CATCH

    SELECT @Result AS 'Result';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_user]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Delete an existing Machine
CREATE PROCEDURE [dbo].[sp_update_user]
    @inUsername VARCHAR(16),
    @inNewUsername VARCHAR(16) = NULL,
    @inNewName VARCHAR(80) = NULL,
    @inNewNumber INT = NULL,
    @inNewPassword VARBINARY(MAX) = NULL, -- Hashed password
    @newIsAdmin BIT = NULL
AS
BEGIN
    DECLARE @Result AS NVARCHAR(MAX);

    BEGIN TRY
        BEGIN TRANSACTION; -- Start a transaction

        -- Check if the user with the specified username exists
        IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inUsername))
        BEGIN
            -- Check if the new username already exists
            IF @inNewUsername IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inNewUsername))
            BEGIN
                -- New username already exists
                SET @Result = '{"success": 0, "description": "User update failed - New username already exists."}';
            END
            ELSE
            BEGIN
                DECLARE @sql NVARCHAR(MAX) = 'UPDATE [dbo].[users] SET';
                DECLARE @Success INT = 0;

                -- Build dynamic SQL to conditionally update user attributes
                IF @inNewUsername IS NOT NULL
                BEGIN
                    SET @sql = @sql + ' [username] = @inNewUsername';
                    SET @Success = 1;
                END

                IF @inNewName IS NOT NULL
                BEGIN
                    IF @Success = 1
                    BEGIN
                        SET @sql = @sql + ',';
                    END
                    SET @sql = @sql + ' [name] = @inNewName';
                    SET @Success = 1;
                END

                IF @inNewNumber IS NOT NULL
                BEGIN
                    IF @Success = 1
                    BEGIN
                        SET @sql = @sql + ',';
                    END
                    SET @sql = @sql + ' [number] = @inNewNumber';
                    SET @Success = 1;
                END

                IF @inNewPassword IS NOT NULL
                BEGIN
                    IF @Success = 1
                    BEGIN
                        SET @sql = @sql + ',';
                    END
                    SET @sql = @sql + ' [password] = @inNewPassword';
                    SET @Success = 1;
                END

                IF @newIsAdmin IS NOT NULL
                BEGIN
                    IF @Success = 1
                    BEGIN
                        SET @sql = @sql + ',';
                    END
                    SET @sql = @sql + ' [isAdmin] = @newIsAdmin';
                    SET @Success = 1;
                END

                SET @sql = @sql + ' WHERE [username] = @inUsername';

                -- Execute dynamic SQL
                EXEC sp_executesql @sql, N'@inNewUsername VARCHAR(16), @inNewName VARCHAR(80), @inNewNumber INT, @inNewPassword VARBINARY(MAX), @newIsAdmin BIT, @inUsername VARCHAR(16)', @inNewUsername, @inNewName, @inNewNumber, @inNewPassword, @newIsAdmin, @inUsername;

                INSERT INTO dbo.EventLog (description, postTime)
                VALUES ('User updated <username ' + COALESCE(@inNewUsername, 'Unchanged') + '- name ' + COALESCE(@inNewName, 'Unchanged') + '- number ' + COALESCE(CAST(@inNewNumber AS VARCHAR), 'Unchanged') + '>',
                    GETDATE());

                COMMIT; -- Commit the transaction
                SET @Result = '{"success": 1, "description": "User updated successfully."}';
            END
        END
        ELSE
        BEGIN
            -- User with the specified username does not exist
            SET @Result = '{"success": 0, "description": "User update failed - User with username ' + @inUsername + ' does not exist."}';
        END
    END TRY
    BEGIN CATCH
        -- Handle exceptions and rollback the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Log the error and return an error message
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the user.', GETDATE());

        SET @Result = '{"success": 0, "description": "An error occurred while updating the user."}';
    END CATCH

    SELECT @Result AS 'Result';
END

GO
/****** Object:  StoredProcedure [dbo].[sp_verify_user]    Script Date: 1/11/2023 22:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_verify_user]
    @username VARCHAR(16),
    @password VARBINARY(64) -- Hashed password
AS
BEGIN
    DECLARE @userCount INT

    SELECT @userCount = COUNT(*) FROM [dbo].[users]
    WHERE [username] = @username AND [password] = @password;

    IF @userCount > 0
    BEGIN
        -- existe
        RETURN 1;
    END
    ELSE
    BEGIN
        -- no existe o contra incorrecta
        RETURN 0;
    END
END

GO
USE [master]
GO
ALTER DATABASE [SGR] SET  READ_WRITE 
GO
