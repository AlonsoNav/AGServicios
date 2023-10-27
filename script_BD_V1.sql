USE [master]
GO
/****** Object:  Database [SGR]    Script Date: 26/10/2023 20:31:17 ******/
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
/****** Object:  User [admin]    Script Date: 26/10/2023 20:31:19 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  Table [dbo].[Client]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  Table [dbo].[DBErrors]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 26/10/2023 20:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[idEvent] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[postBy] [int] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[idEvent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 26/10/2023 20:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
	[idMachine] [int] IDENTITY(1,1) NOT NULL,
	[serial] [varchar](30) NOT NULL,
	[model] [varchar](50) NOT NULL,
	[idBrand] [int] NOT NULL,
	[idType] [int] NOT NULL,
	[available] [bit] NOT NULL,
 CONSTRAINT [PK_Machine] PRIMARY KEY CLUSTERED 
(
	[idMachine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maintenance]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  Table [dbo].[TypeMachine]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_brand]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_type]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_user]    Script Date: 26/10/2023 20:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_user]
    @username VARCHAR(16),
    @name VARCHAR(80),
    @number int,
    @password VARBINARY(64),  -- El hash de la contraseña
    @salt VARBINARY(16)  -- El salt
AS
BEGIN
    -- Inserta el nuevo usuario en la tabla Usuarios
    INSERT INTO users(username, name, number, password, salt)
    VALUES (@username, @name, @number, @password, @salt);

	--Inserta en el log la accion de nuevo usuario registrado
	INSERT INTO dbo.EventLog(description,postTime)
	VALUES ('User inserted <username '+@username+ '-name '+@name+ '-number '+@number + '-password '+@password +'-salt '+@salt+'>', GETDATE());
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_machine]    Script Date: 26/10/2023 20:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_machine]
	@inSerial INT
	,@inPostBy INT

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

			INSERT INTO dbo.EventLog(description,postBy,postTime)
			VALUES ('Machine deleted <Serial '+@inSerial+'>', @inPostBy, GETDATE());

			RETURN 1;
		END
		ELSE
		BEGIN
			INSERT INTO dbo.EventLog(description,postBy,postTime)
			VALUES ('Machine deletion failed <Serial '+@inSerial+'>', @inPostBy, GETDATE());

			RETURN 0;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_machine]    Script Date: 26/10/2023 20:31:20 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 26/10/2023 20:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_user]
    @username VARCHAR(16)
AS
BEGIN
    SELECT TOP 1 isAdmin, password
    FROM users
    WHERE username = @username;
END;
GO
USE [master]
GO
ALTER DATABASE [SGR] SET  READ_WRITE 
GO
