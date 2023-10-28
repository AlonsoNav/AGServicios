USE [master]
GO
/****** Object:  Database [SGR]    Script Date: 27/10/2023 14:55:27 ******/
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
/****** Object:  User [admin]    Script Date: 27/10/2023 14:55:30 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 27/10/2023 14:55:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
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
/****** Object:  Table [dbo].[Client]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
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
/****** Object:  Table [dbo].[DBErrors]    Script Date: 27/10/2023 14:55:31 ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 27/10/2023 14:55:31 ******/
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
/****** Object:  Table [dbo].[Machine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
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
/****** Object:  Table [dbo].[Maintenance]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maintenance](
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
/****** Object:  Table [dbo].[TypeMachine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeMachine](
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
/****** Object:  Table [dbo].[users]    Script Date: 27/10/2023 14:55:31 ******/
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
 CONSTRAINT [PK_Technician] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_isAdmin]  DEFAULT ((0)) FOR [isAdmin]
GO
ALTER TABLE [dbo].[Machine]  WITH CHECK ADD  CONSTRAINT [FK_Machine_Brand] FOREIGN KEY([idType])
REFERENCES [dbo].[Brand] ([idBrand])
GO
ALTER TABLE [dbo].[Machine] CHECK CONSTRAINT [FK_Machine_Brand]
GO
ALTER TABLE [dbo].[Machine]  WITH CHECK ADD  CONSTRAINT [FK_Machine_TypeMachine] FOREIGN KEY([idType])
REFERENCES [dbo].[TypeMachine] ([idTypeMachine])
GO
ALTER TABLE [dbo].[Machine] CHECK CONSTRAINT [FK_Machine_TypeMachine]
GO
ALTER TABLE [dbo].[Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Client] FOREIGN KEY([idClient])
REFERENCES [dbo].[Client] ([idClient])
GO
ALTER TABLE [dbo].[Maintenance] CHECK CONSTRAINT [FK_Maintenance_Client]
GO
ALTER TABLE [dbo].[Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Machine] FOREIGN KEY([idMachine])
REFERENCES [dbo].[Machine] ([idMachine])
GO
ALTER TABLE [dbo].[Maintenance] CHECK CONSTRAINT [FK_Maintenance_Machine]
GO
ALTER TABLE [dbo].[Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Maintenance_Technician] FOREIGN KEY([idUser])
REFERENCES [dbo].[users] ([idUser])
GO
ALTER TABLE [dbo].[Maintenance] CHECK CONSTRAINT [FK_Maintenance_Technician]
GO
/****** Object:  StoredProcedure [dbo].[sp_add_brand]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @brandName VARCHAR(50)
	,@inDescription VARCHAR(60)


AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Brand] WHERE LOWER([name]) = LOWER(@brandName))
    BEGIN
        INSERT INTO [dbo].[Brand] (name,description,available)
        VALUES (@brandName,@inDescription,1);

		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('New brand added <' + @brandName+'>'
			, GETDATE());
	
        RETURN 1;
    END
    ELSE
    BEGIN
		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('Brand insertion failed <' + @brandName +'>'
			, GETDATE());
	
        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_client]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_client]
	@inName VARCHAR(50)
	,@inContactNumber INT
	,@inAddress VARCHAR(50)
	,@inEmail VARCHAR(50)
	,@inAvailable BIT

AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM [dbo].[Client] WHERE LOWER([name]) = LOWER(@inName))
    BEGIN
        INSERT INTO [dbo].[Client] ([name],[contactNumber],[address],[email],[available])
        VALUES (@inName, @inContactNumber, @inAddress, @inEmail, @inAvailable);

		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('New client added <'+'Name: ' +@inName+ ' - Number: '+@inAddress+' - Address: '+@inAddress+ ' - Email: '+@inEmail+'>'
			, GETDATE());
	
        RETURN 1;
    END
    ELSE
    BEGIN
		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('Client insertion failed - ALREADY EXISTS <'+'Name: ' +@inName+ ' - Number: '+@inAddress+' - Address: '+@inAddress+ ' - Email: '+@inEmail+'>'
			, GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_machine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_machine]
	@inBrand VARCHAR(50),
    @inType VARCHAR(50),
    @inSerial VARCHAR(50),
    @inModel VARCHAR(50)
AS
BEGIN
    DECLARE @idBrand INT
			, @idType INT
			, @machineId INT

	-- Verifica que la brand y el type realmente existan.
    SELECT @idBrand = ISNULL((SELECT TOP 1 idBrand FROM [dbo].[Brand] WHERE LOWER([name]) = LOWER(@inBrand)), 0)
    SELECT @idType = ISNULL((SELECT TOP 1 idTypeMachine FROM [dbo].[TypeMachine] WHERE LOWER([name]) = LOWER(@inType)), 0)

	 -- Verifica de que no exista ya una maquina con el mismo serial.
    IF EXISTS (SELECT 1 FROM [dbo].[Machine] WHERE [serial] = @inSerial)
    BEGIN
		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('Machine insertion failed - SAME SERIAL <'+'Brand: '+ @inBrand+' - Machine type: '+@inType+' - Serial: '+@inSerial+' - Model: '+@inModel+'>'
			, GETDATE());
        RETURN 0;
    END

    IF @idBrand = 0 OR @idType = 0 
    BEGIN

		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('Machine insertion failed - NO BRAND OR TYPE FOUNDED <'+'Brand: '+ @inBrand+' - Machine type: '+@inType+' - Serial: '+@inSerial+' - Model: '+@inModel+'>'
			, GETDATE());

        RETURN 0;
    END

    INSERT INTO [dbo].[Machine] ([idBrand], [idType], [serial], [model], [available])
    VALUES (@idBrand
			, @idType
			, @inSerial
			, @inModel
			,1);

    INSERT INTO dbo.EventLog (description, postTime)
    VALUES ('New machine added <'+'Brand: '+ @inBrand+' - Machine type: '+@inType+' - Serial: '+@inSerial+' - Model: '+@inModel+'>'
			, GETDATE());

    RETURN 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_type]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_type]
    @typeName VARCHAR(50)
	,@inDescription VARCHAR(80)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[TypeMachine] WHERE LOWER([name]) = LOWER(@typeName))
    BEGIN
        INSERT INTO [dbo].[TypeMachine] ([name],[description],[available])
        VALUES (@typeName,@inDescription, 1);

		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('New machine type added <' + @typeName+'>'
			, GETDATE());
	
        RETURN 1;
    END
    ELSE
    BEGIN
		INSERT INTO dbo.EventLog (description, postTime)
		VALUES ('Machine type insertion failed <' + @typeName +'>'
			, GETDATE());
	

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_user]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_user]
    @username VARCHAR(16),
    @name VARCHAR(80),
    @number int,
    @password VARBINARY(64)  -- El hash de la contraseña
	,@isAdmin BIT

AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER(@username) = LOWER(@username))
	BEGIN --true 1, false 0

		-- Inserta el nuevo usuario en la tabla Usuarios
		INSERT INTO users(username, name, number, password, isAdmin)
		VALUES (@username, @name, @number, @password, @isAdmin);

		--Inserta en el log la accion de nuevo usuario registrado
		INSERT INTO dbo.EventLog(description,postTime)
		VALUES ('User inserted <username '+@username+ '- name '+@name+ '- number '+CAST(@number AS VARCHAR) + '- password '+CONVERT(VARCHAR(64), @password, 2)+'>', GETDATE());
		RETURN 1;
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog(description,postTime)
			VALUES ('User insertion failed <username '+@username+ '- name '+@name+ '- number '+CAST(@number AS VARCHAR) + '- password '+CONVERT(VARCHAR(64), @password, 2)+'>', GETDATE());

			RETURN 0;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_brand]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_brand]
    @brandName VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[Brand] WHERE LOWER([name]) = LOWER(@brandName))
    BEGIN
        DELETE FROM [dbo].[Brand]
        WHERE LOWER([name]) = LOWER(@brandName);

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Brand deleted <' + @brandName + '>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Brand deletion failed - Brand with name ' + @brandName + ' does not exist.'
            , GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_machine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_machine]
	@inSerial INT

AS
	BEGIN

		DECLARE @idMachine INT;
		SELECT @idMachine = M.idMachine
		FROM dbo.Machine M
		WHERE M.serial = @inSerial;

		IF @idMachine IS NOT NULL
		BEGIN
			DELETE FROM dbo.Machine
			WHERE serial = @inSerial;

			INSERT INTO dbo.EventLog(description,postTime)
			VALUES ('Machine deleted <Serial '+@inSerial+'>', GETDATE());

			RETURN 1;
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog(description,postTime)
			VALUES ('Machine deletion failed <Serial '+@inSerial+'>', GETDATE());

			RETURN 0;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_type]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_type]
    @typeName VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[TypeMachine] WHERE LOWER([name]) = LOWER(@typeName))
    BEGIN
        DELETE FROM [dbo].[TypeMachine]
        WHERE LOWER([name]) = LOWER(@typeName);

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type deleted <TypeMachine: ' + @typeName + '>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type deletion failed - TypeMachine with name ' + @typeName + ' does not exist.'
            , GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_user]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_delete_user]
    @inUsername VARCHAR(16)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inUsername))
    BEGIN
        DELETE FROM [dbo].[users]
        WHERE LOWER([username]) = LOWER(@inUsername);

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type deleted <TypeMachine: ' + @inUsername + '>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type deletion failed - TypeMachine with name ' + @inUsername + ' does not exist.'
            , GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_brand]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_brand]
	@inName VARCHAR(50)
AS
BEGIN
		IF EXISTS (SELECT 1 FROM [dbo].[Brand] WHERE LOWER([name]) = LOWER(@inName))
		BEGIN
			SELECT name,description,available
			FROM [dbo].[Brand]
			WHERE LOWER([name]) = LOWER(@inName);

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Brand read <Name: '+@inName+'>'
				, GETDATE());
			RETURN 1;
		END
		ELSE
			BEGIN
				INSERT INTO dbo.EventLog (description, postTime)
				VALUES ('Brand with the name: <'+@inName+'> does not exist'
					, GETDATE());
				RETURN 0;
			END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_machine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_machine]
    @inSerial VARCHAR(30),
    @inBrand VARCHAR(50),
    @inType VARCHAR(50),
    @postBy INT
AS
BEGIN
    DECLARE @idMachine INT;

    SELECT @idMachine = M.[idMachine]
    FROM [dbo].[Machine] M
    INNER JOIN [dbo].[Brand] B ON M.[idBrand] = B.[idBrand]
    INNER JOIN [dbo].[TypeMachine] TM ON M.[idType] = TM.[idTypeMachine]
    WHERE M.[serial] = @inSerial
        AND B.[name] = @inBrand
        AND TM.[name] = @inType;

    IF @idMachine IS NOT NULL
    BEGIN
        INSERT INTO [dbo].[EventLog] ([description], [postTime], [postBy])
        VALUES ('Machine found <serial: ' + @inSerial + ', brand: ' + @inBrand + ', type: ' + @inType+'>',
                GETDATE(),
                @postBy);
    END
    ELSE
    BEGIN
        -- Insert an event log entry if the machine is not found
        INSERT INTO [dbo].[EventLog] ([description], [postTime], [postBy])
        VALUES ('Machine not found <serial: ' + @inSerial + ', brand: ' + @inBrand + ', type: ' + @inType+'>',
                GETDATE(),
                @postBy);
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_type]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_type]
	@inName VARCHAR(50)
AS
BEGIN
		IF EXISTS (SELECT 1 FROM [dbo].[TypeMachine] WHERE LOWER([name]) = LOWER(@inName))
		BEGIN
			SELECT name,description,available
			FROM [dbo].[TypeMachine]
			WHERE LOWER([name]) = LOWER(@inName);

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Brand read <Name: '+@inName+'>'
				, GETDATE());
			RETURN 1;
		END
		ELSE
			BEGIN
				INSERT INTO dbo.EventLog (description, postTime)
				VALUES ('Brand with the name: <'+@inName+'> does not exist'
					, GETDATE());
				RETURN 0;
			END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_user]
	@inUsername VARCHAR(50)
AS
BEGIN
		IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inUsername))
		BEGIN
			SELECT username,name,number,password,isAdmin
			FROM [dbo].[users]
			WHERE LOWER([username]) = LOWER(@inUsername);

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('Brand read <Name: '+@inUsername+'>'
				, GETDATE());
			RETURN 1;
		END
		ELSE
			BEGIN
				INSERT INTO dbo.EventLog (description, postTime)
				VALUES ('Brand with the name: <'+@inUsername+'> does not exist'
					, GETDATE());
				RETURN 0;
			END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_brand]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @inName VARCHAR(50)
	,@inNewName VARCHAR(50)
    ,@inDescription VARCHAR(100)
	,@inAvailable BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[Brand] WHERE LOWER([name]) = LOWER(@inName))
    BEGIN
        UPDATE [dbo].[Brand]
        SET [description] = @inDescription,
			[name] = @inNewName
			,[available] = @inAvailable
        WHERE LOWER([name]) = LOWER(@inName);

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Brand updated <' + @inNewName + '>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Brand update failed - Brand with name <' + @inName + '> does not exist.'
            , GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_machine]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Delete an existing Machine
CREATE PROCEDURE [dbo].[sp_update_machine]
    @inSerial VARCHAR(30),
    @inNewModel VARCHAR(60)
	,@inNewSerial VARCHAR(30)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[Machine] WHERE [serial] = @inSerial)
    BEGIN
        UPDATE [dbo].[Machine]
        SET [model] = @inNewModel
			,[serial] = @inNewSerial
        WHERE [serial] = @inSerial;

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine updated <Serial: ' + @inSerial + ' - Model: ' + @inNewModel +  '>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine update failed - Machine with serial number ' + @inSerial + ' does not exist.'
            , GETDATE());

        RETURN 0;
    END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_type]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
	@inNewName VARCHAR(50)
    ,@inDescription VARCHAR(100)
	,@inAvailable BIT

AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[TypeMachine] WHERE LOWER([name]) = LOWER(@inName))
    BEGIN
        UPDATE [dbo].[TypeMachine]
        SET [description] = @inDescription,
			[name] = @inNewName,
			[available] = @inAvailable
        WHERE LOWER([name]) = LOWER(@inName);

        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type updated <TypeMachine: ' + @inNewName +' - Description: ' + @inDescription +'>'
            , GETDATE());

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.EventLog (description, postTime)
        VALUES ('Machine type update failed - TypeMachine with name ' + @inName + ' does not exist.'
            , GETDATE());

        RETURN 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_user]    Script Date: 27/10/2023 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Delete an existing Machine
create PROCEDURE [dbo].[sp_update_user]
    @inUsername VARCHAR(16),
	@inNewUsername VARCHAR(16),
    @inNewName VARCHAR(80),
    @inNewNumber INT,
    @inNewPassword VARBINARY(MAX), -- Hashed password
    @newIsAdmin BIT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([name]) = LOWER(@inUsername))
	BEGIN
		IF EXISTS (SELECT 1 FROM [dbo].[users] WHERE LOWER([username]) = LOWER(@inNewUsername))
		BEGIN
			-- ya existe username
			RETURN 0;
		END
		ELSE
		BEGIN
			UPDATE [dbo].[users]
			SET [username] = @inNewUsername,
				[name] = @inNewName,
				[number] = @inNewNumber,
				[password] = @inNewPassword,
				[isAdmin] = @inNewPassword
			WHERE [username] = @inUsername;

			INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('User updated <username ' + @inNewUsername + '- name ' + @inNewName + '- number ' + CAST(@inNewNumber AS VARCHAR) + '>',
				GETDATE());

			RETURN 1;
		END
	END
	ELSE
	BEGIN

		INSERT INTO dbo.EventLog (description, postTime)
			VALUES ('User update FAILED <username ' + @inUsername + '- name ' + @inNewName + '- number ' + CAST(@inNewNumber AS VARCHAR) + '>',
				GETDATE());

        RETURN 0;

	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_verify_user]    Script Date: 27/10/2023 14:55:31 ******/
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
