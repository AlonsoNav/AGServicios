USE [master]
GO
/****** Object:  Database [SGR]    Script Date: 6/11/2023 08:11:23 ******/
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
/****** Object:  User [admin]    Script Date: 6/11/2023 08:11:26 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 6/11/2023 08:11:26 ******/
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
/****** Object:  Table [dbo].[clients]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[DBErrors]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[machines]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[maintenances]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[typesMachine]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_brand]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @name VARCHAR(50),
	@description VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output VARCHAR(200);

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM brands WHERE LOWER([name]) = LOWER(@name))
        BEGIN
			BEGIN TRANSACTION;
				INSERT INTO brands (name, description)
				VALUES (@name, @description);
			COMMIT TRANSACTION;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('New brand added <' + @name + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Marca añadida exitosamente"}';
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Inserción de marca fallida: la marca ya existe"}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
		SET @output = '{"result": 0, "description": "Error al añadir la marca: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_client]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_client] @name    VARCHAR(30),
                                      @number  INT,
                                      @address VARCHAR(50),
                                      @email   VARCHAR(50)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output VARCHAR(200);

      BEGIN try
          IF NOT EXISTS (SELECT 1
                         FROM   clients
                         WHERE  Lower([name]) = Lower(@name))
            BEGIN
                BEGIN TRANSACTION;

                INSERT INTO clients
                            ([name],
                             [contactnumber],
                             [address],
                             [email],
                             [available])
                VALUES      (@name,
                             @number,
                             @address,
                             @email,
                             1);

                COMMIT TRANSACTION;

                INSERT INTO dbo.eventlog
                            (description,
                             posttime)
                VALUES      ('New client added <Name: ' + @name
                             + ' - Number: ' + Cast(@number AS VARCHAR)
                             + ' - Address: ' + @address + ' - Email: ' + @email
                             + '>',
                             Getdate());

                SET @output =
                '{"result": 1, "description": "Cliente añadido exitosamente."}'
                ;
            END
          ELSE
            BEGIN
                SET @output =
'{"result": 0, "description": "Inserción de cliente fallida: El cliente ya existe."}'
    ;
END
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;

        SET @output =
        '{"result": 0, "description": "Error al añadir al cliente: '
        + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_add_machine]    Script Date: 6/11/2023 08:11:27 ******/
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
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @idBrand INT, @idType INT, @machineId INT;
    DECLARE @output VARCHAR(200);

	BEGIN TRY

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
			BEGIN TRANSACTION;

				INSERT INTO [dbo].[Machine] ([idBrand], [idType], [serial], [model])
				VALUES (@idBrand, @idType, @serial, @model);
			
			COMMIT TRANSACTION;

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Nueva máquina agregada <'+'Marca: '+ @brand+' - Tipo de máquina: '+@type+' - Número de serie: '+@serial+' - Modelo: '+@model+'>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Nueva máquina agregada exitosamente."}';
		END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
        SET @output = '{"result": 0, "description": "Error al añadir al cliente: ' + ERROR_MESSAGE() + '"}';
	END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_type]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_type]
	@name VARCHAR(50),
	@description VARCHAR(80)
AS
BEGIN
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @idType INT;
    DECLARE @output VARCHAR(200);

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
			BEGIN TRANSACTION;

				INSERT INTO typesMachine ([name],[description])
				VALUES (@name, @description);
			
			COMMIT TRANSACTION;

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Nuevo tipo de máquina agregado <' + 'Nombre: ' + @name + ' - Descripción: ' + @description + '>'
                , GETDATE());

            SET @output = '{"result": 1, "description": "Nuevo tipo de máquina agregado exitosamente."}';
        END

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
        SET @output = '{"result": 0, "description": "Error during type machine insertion: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_user]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_user]
	@username VARCHAR(16),
    @name VARCHAR(80),
    @number int,
    @password VARBINARY(64)  -- El hash de la contrase�a
AS
BEGIN
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	DECLARE @output VARCHAR(200);

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM users WHERE LOWER(username) = LOWER(@username))
        BEGIN
			BEGIN TRANSACTION;

				INSERT INTO users(username, name, number, password)
				VALUES (@username, @name, @number, @password);

			COMMIT TRANSACTION;

            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User inserted <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());

            SET @output = '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}';

        END
        ELSE
        BEGIN
            INSERT INTO dbo.EventLog(description, postTime)
            VALUES ('User insertion failed <username ' + @username + ' - name ' + @name + ' - number ' + CAST(@number AS VARCHAR) + ' - password ' + CONVERT(VARCHAR(64), @password, 2) + '>', GETDATE());

            SET @output = '{"result": 0, "description": "Fallo en la inserción del usuario: El nombre de usuario ya existe."}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
        SET @output = '{"result": 0, "description": "Error durante la inserción del usuario."}';
    END CATCH

    SELECT @output;
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_brand]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_brand]
	@name VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		DECLARE @idBrand INT;
		DECLARE @output VARCHAR(200);

		SET @idBrand = ISNULL((SELECT TOP 1 idBrand FROM brands WHERE LOWER([name]) = LOWER(@name) and available = 1), 0)

		IF @idBrand <> 0
		BEGIN
			
			BEGIN TRANSACTION

				UPDATE brands SET available = 0 WHERE idBrand = @idBrand;

			COMMIT

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Marca eliminada <' + @name + '>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Marca eliminada exitosamente."}';
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la eliminación de la marca - La marca con nombre ' + @name + ' no existe.'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la eliminación de la marca: La marca no existe."}';
		END

		SELECT @output;
	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_client]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_client]
	@name VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		DECLARE @idClient INT;
		DECLARE @output VARCHAR(200);

		SET @idClient = ISNULL((SELECT TOP 1 idCLient FROM clients WHERE LOWER([name]) = LOWER(@name) and available = 1), 0)

		IF @idClient <> 0
		BEGIN
			
			BEGIN TRANSACTION

				UPDATE clients SET available = 0 WHERE idCLient = @idClient;

			COMMIT

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Cliente eliminado <' + @name + '>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Cliente eliminado exitosamente."}';
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la eliminación del cliente - El cliente con nombre ' + @name + ' no existe.'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la eliminación del cliente: El cliente no existe."}';
		END

		SELECT @output;
	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_machine]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_machine]
	@serial varchar(30)

AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @idMachine INT;
		DECLARE @output VARCHAR(200);

		SET @idMachine = ISNULL((SELECT TOP 1 idMachine FROM machines WHERE serial = @serial and available = 1), 0);

		IF @idMachine <> 0
		BEGIN
			BEGIN TRANSACTION
				UPDATE machines SET available = 0 WHERE idMachine = @idMachine;
			COMMIT
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
	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;

	END CATCH
	SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_type]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_type]
	@name VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		DECLARE @idType INT;
		DECLARE @output NVARCHAR(200);

		SET @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM typesMachine WHERE LOWER([name]) = LOWER(@name) and available=1), 0)

		IF @idType <> 0
		BEGIN
			BEGIN TRANSACTION
				UPDATE typesMachine SET available = 0 WHERE idTypeMachine = @idType;
			COMMIT

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
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
		END;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_user]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_user]
    @username VARCHAR(16)
AS
BEGIN
    SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUser INT;
		DECLARE @output NVARCHAR(200);

		SELECT @idUser = ISNULL((SELECT TOP 1 idUser FROM users WHERE LOWER([username]) = LOWER(@username) AND available = 1 AND [isAdmin] = 0), 0)

		IF @idUser <> 0
		BEGIN
			BEGIN TRANSACTION
				UPDATE users SET available = 0 WHERE idUser = @idUser;
			COMMIT

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Usuario eliminado <Nombre de usuario: ' + @username + '>'
				, GETDATE());

			SET @output = '{"result": 1, "description": "Usuario eliminado exitosamente."}';
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Fallo en la eliminación del usuario - El usuario con nombre ' + @username + ' no existe o es un administrador.'
				, GETDATE());

			SET @output = '{"result": 0, "description": "Fallo en la eliminación del usuario: El usuario no existe o es un administrador."}';
		END

		SELECT @output;
	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
			BEGIN
				ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
			END;

	END CATCH
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_brands]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_brands]
AS
  BEGIN
      SELECT B.name,
             B.description
      FROM   brands AS B
      WHERE  available = 1;
  END

go 
/****** Object:  StoredProcedure [dbo].[sp_get_all_clients]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_clients]
AS
  BEGIN
      SELECT C.NAME,
             C.contactnumber,
             C.address,
             C.email
      FROM   clients AS C
      WHERE  available = 1;
  END 
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_machines]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_machines]
AS
  BEGIN
      SELECT M.[serial],
             M.[model],
             B.[name]  brand,
             TM.[name] type
      FROM   [dbo].[machine] M
             INNER JOIN brands B
                     ON M.[idbrand] = B.[idbrand]
             INNER JOIN typesmacine TM
                     ON M.[idtype] = TM.[idtypemachine]
      WHERE  available = 1;
  END 
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_types]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_types]
AS
  BEGIN
      SELECT T.name,
			 T.description
      FROM   typesMachine AS T
      WHERE  available = 1;
  END 
GO
/****** Object:  StoredProcedure [dbo].[Sp_get_all_users]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_users]
AS
  BEGIN
      SELECT U.username,
             U.NAME,
             U.number,
             U.password,
             U.isadmin
      FROM   users AS U
      WHERE  available = 1;
  END 
GO
/****** Object:  StoredProcedure [dbo].[sp_get_brand]    Script Date: 6/11/2023 08:11:27 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_client]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_get_client]
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, contactNumber,address,email FROM clients WHERE LOWER([name]) = LOWER(@name) and available = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_machine]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_machine] @serial VARCHAR(30)
AS
  BEGIN
      SELECT M.[serial],
             M.[model],
             B.[name]  brand,
             TM.[name] type
      FROM   [dbo].[machine] M
             INNER JOIN brands B
                     ON M.[idbrand] = B.[idbrand]
             INNER JOIN typesmacine TM
                     ON M.[idtype] = TM.[idtypemachine]
      WHERE  M.[serial] = @serial
             AND available = 1;
  END 
GO
/****** Object:  StoredProcedure [dbo].[sp_get_type]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_get_type] @name VARCHAR(50)
AS
  BEGIN
      SELECT NAME,
             description
      FROM   typesmachine
      WHERE  Lower([name]) = Lower(@name)
             AND available = 1;
  END

go 
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_user]
	@username VARCHAR(50)
AS
BEGIN
	SELECT username, name, number, password, isAdmin FROM users WHERE LOWER([username]) = LOWER(@username) and available = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_get_user_not_admin]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_get_user_not_admin] @username VARCHAR(50)
AS
  BEGIN
      SELECT U.username,
             U.name,
             U.number,
             U.password,
             U.isAdmin
      FROM   users AS U
      WHERE  Lower([username]) = Lower(@username)
             AND available = 1
             AND isadmin = 0;
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_brand]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL, 
    @inDescription VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output VARCHAR(200);

    BEGIN TRY
        -- Begin a transaction
   
        IF EXISTS (SELECT 1 FROM [dbo].[brands] WHERE LOWER([name]) = LOWER(@inName) AND [available] = 1)
        BEGIN

            IF @inDescription IS NOT NULL
            BEGIN
				begin transaction;
					UPDATE [dbo].[brands]
					SET [description] = @inDescription
					WHERE LOWER([name]) = LOWER(@inName);
				commit transaction
            END

			IF @inNewName IS NOT NULL
            BEGIN
				BEGIN TRANSACTION;
					UPDATE [dbo].[brands]
					SET [name] = @inNewName
					WHERE LOWER([name]) = LOWER(@inName);
				COMMIT TRANSACTION;
            END

            SET @output = '{"result": 1, "description": "Marca editada exitosamente."}';

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Brand updated <Name: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: ' + COALESCE(@inDescription, 'Unchanged') + '>'
                , GETDATE());
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Ocurrió un error al intentar editar la marca: ' + @inName + ' No existe o no está disponible."}';
        END

    END TRY
    BEGIN CATCH
        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        SET @output = '{"result": 0, "description": "Ocurrió un error al editar la marca: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
    SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_client]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_client]
    @inName VARCHAR(30),
    @inNewName VARCHAR(30) = NULL, 
    @inNewNumber INT = NULL,
	@inNewAddress VARCHAR(50) = NULL,
	@inNewEmail VARCHAR(50) = NULL

AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output AS NVARCHAR(200);
    DECLARE @idClient INT;

    BEGIN TRY
        -- Begin a transaction
   
        SET @idClient = ISNULL((SELECT TOP 1 idCLient FROM [dbo].[clients] WHERE LOWER([name]) = LOWER(@inName) AND available = 1), 0)
        IF @idClient <> 0
        BEGIN

            IF @inNewName IS NOT NULL
            BEGIN
				begin transaction;
					UPDATE [dbo].[clients]
					SET [name] = @inNewName
					WHERE LOWER([idCLient]) = LOWER(@idClient);
				commit transaction
            END
			IF @inNewNumber IS NOT NULL
            BEGIN
				begin transaction;
					UPDATE [dbo].[clients]
					SET [contactNumber] = @inNewNumber
					WHERE LOWER([idCLient]) = LOWER(@idClient);
				commit transaction
            END
			IF @inNewAddress IS NOT NULL
            BEGIN
				begin transaction;
					UPDATE [dbo].[clients]
					SET [address] = @inNewAddress
					WHERE LOWER([idCLient]) = LOWER(@idClient);
				commit transaction
            END
			IF @inNewEmail IS NOT NULL
            BEGIN
				begin transaction;
					UPDATE [dbo].[clients]
					SET [email] = @inNewEmail
					WHERE LOWER([idCLient]) = LOWER(@idClient);
				commit transaction
            END

			

            SET @output = '{"result": 1, "description": "Cliente editado exitosamente."}';

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('Brand updated <Name: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: ' + COALESCE(@inNewName, 'Unchanged') + '>'
                , GETDATE());
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Ocurrió un error al intentar editar al cliente: ' + @inName + ' No existe o no está disponible."}';
        END

    END TRY
    BEGIN CATCH
        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        SET @output = '{"result": 0, "description": "Ocurrió un error al editar al cliente: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
    SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_machine]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_machine] @inSerial    VARCHAR(30),
                                          @inNewModel  VARCHAR(60) = NULL,
                                          @inNewSerial VARCHAR(30) = NULL
AS
  BEGIN
      SET nocount ON;
      SET TRANSACTION isolation level READ uncommitted;

      DECLARE @output VARCHAR(200);

      BEGIN try
          IF EXISTS (SELECT 1
                     FROM   [dbo].[machine]
                     WHERE  [serial] = @inSerial
                            AND [available] = 1)
            BEGIN
                IF @inNewModel IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION

                      UPDATE [dbo].[machine]
                      SET    [model] = @inNewModel
                      WHERE  [serial] = @inSerial;

                      COMMIT TRANSACTION
                  END

                IF @inNewSerial IS NOT NULL
                  BEGIN
                      BEGIN TRANSACTION

                      UPDATE [dbo].[machine]
                      SET    [serial] = @inNewSerial
                      WHERE  [serial] = @inSerial;

                      COMMIT TRANSACTION
                  END

                SET @output =
      '{"result": 1, "description": "Cliente actualizado exitosamente."}';

      INSERT INTO dbo.eventlog
                  (description,
                   posttime)
      VALUES      ('Machine updated <Serial: ' + @inSerial
                   + ' - Model: '
                   + COALESCE(@inNewModel, 'Unchanged')
                   + ' - New Serial: '
                   + COALESCE(@inNewSerial, 'Unchanged') + '>',
                   Getdate());
            END
          ELSE
            BEGIN
                SET @output =
'{"result": 0, "description": "El cliente ingresado no existe o no está disponible."}'
    ;

    INSERT INTO dbo.eventlog
                (description,
                 posttime)
    VALUES      ('Machine update failed - Machine with serial number '
                 + @inSerial
                 + ' does not exist or is not available.',
                 Getdate());
END
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;

        SET @output =
        '{"result": 0, "description": "Error al añadir al cliente: '
        + Error_message() + '"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_update_type]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50) = NULL,
    @inDescription VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output VARCHAR(200);

    BEGIN TRY

        IF @inNewName IS NOT NULL
        BEGIN

            IF NOT EXISTS (SELECT 1 FROM [dbo].[typesMachine] WHERE LOWER([name]) = LOWER(@inNewName))
            BEGIN

                IF EXISTS (SELECT 1 FROM [dbo].[typesMachine] WHERE LOWER([name]) = LOWER(@inName) AND available = 1)
                BEGIN
					IF @inDescription IS NOT NULL
					BEGIN
						BEGIN TRANSACTION;
							UPDATE [dbo].[typesMachine]
							SET [description] = @inDescription
							WHERE LOWER([name]) = LOWER(@inName);
						COMMIT TRANSACTION;
					END
					IF @inNewName IS NOT NULL
					BEGIN
						BEGIN TRANSACTION
							UPDATE [dbo].[typesMachine]
							SET [name] = @inNewName
							WHERE LOWER([name]) = LOWER(@inName);
						COMMIT TRANSACTION;
					END
					SET @output = '{"result": 1, "description": "Maquinaria editada exitosamente."}';
                END
				ELSE
				BEGIN
					SET @output = '{"result": 0, "description": "Ocurrió un error al intentar editar la maquinaria: ' + @inName + ' No existe o no está disponible."}';
				END
            END
            ELSE
            BEGIN
                SET @output = '{"result": 0, "description": "Ocurrió un error al intentar editar la maquinaria: ' + @inName + ' Ya existe."}';
            END
        END

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('TypeMachine updated <Name: ' + COALESCE(@inNewName, 'Unchanged') + ' - Description: ' + COALESCE(@inDescription, 'Unchanged') + '>'
            , GETDATE());

    END TRY
    BEGIN CATCH
        ErrorHandling:
        -- If there's an error, roll back the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        SET @output = '{"result": 0, "description": "Ha ocurrido un error al intentar editar el tipo de máquina: ' + ERROR_MESSAGE() + '"}';
    END CATCH

    SELECT @output;
    SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_user]    Script Date: 6/11/2023 08:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_user]
    @inUsername VARCHAR(16),
	@inNewUsername VARCHAR(16) = NULL, 
    @inNewName VARCHAR(80) = NULL,
    @inNewNumber INT = NULL,
    @inNewPassword VARBINARY(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    DECLARE @output AS NVARCHAR(200);
    DECLARE @idUser INT;

    BEGIN TRY
        SET @idUser = ISNULL((SELECT TOP 1 idUser FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inUsername) AND available = 1 AND [isAdmin] = 0), 0)
        IF @idUser <> 0
        BEGIN

			IF @inNewUsername IS NOT NULL
			BEGIN
				begin transaction;
					UPDATE [dbo].[users]
					SET [username] = @inNewUsername
					WHERE idUser = @idUser;
				commit transaction
			END
			IF @inNewName IS NOT NULL
			BEGIN
				begin transaction;
					UPDATE [dbo].[users]
					SET name = @inNewName
					WHERE idUser = @idUser;
				commit transaction
			END
			IF @inNewNumber IS NOT NULL
			BEGIN
				begin transaction;
					UPDATE [dbo].[users]
					SET number = @inNewNumber
					WHERE idUser = @idUser;
				commit transaction
			END
			IF @inNewPassword IS NOT NULL
			BEGIN
				begin transaction;
					UPDATE [dbo].[users]
					SET password = @inNewPassword
					WHERE idUser = @idUser;
				commit transaction
			END

            INSERT INTO dbo.EventLog (description, postTime)
            VALUES ('User updated <name ' + COALESCE(@inNewName, 'Unchanged') + '- number ' + COALESCE(CAST(@inNewNumber AS VARCHAR), 'Unchanged') + '>',
                GETDATE());

            SET @output = '{"success": 1, "description": "User updated successfully."}';
        END
        ELSE
        BEGIN
            SET @output = '{"success": 0, "description": "User update failed - User with username ' + @inUsername + ' does not exist or is an admin."}';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('An error occurred while updating the user.', GETDATE());

        SET @output = '{"success": 0, "description": "An error occurred while updating the user."}';
    END CATCH

    SELECT @output;
END
GO
USE [master]
GO
ALTER DATABASE [SGR] SET  READ_WRITE 
GO
