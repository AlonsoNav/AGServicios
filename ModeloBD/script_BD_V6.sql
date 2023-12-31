USE [master]
GO
/****** Object:  Database [SGR]    Script Date: 7/11/2023 23:23:45 ******/
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
/****** Object:  User [admin]    Script Date: 7/11/2023 23:23:49 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[clients]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[DBErrors]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[machines]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[maintenances]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[typesMachine]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_add_brand]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_brand]
    @name VARCHAR(50),
    @description VARCHAR(80)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idBrand INT;
    DECLARE @output VARCHAR(200);
    SET @name = Ltrim(Rtrim(@name));
    SET @description = Ltrim(Rtrim(@description));
    BEGIN try
        IF Len(@name) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: Nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@description) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: Descripción vacía"}';
            SELECT @output;
            RETURN;
        END
        SELECT @idBrand = Isnull(
                (
                    SELECT TOP 1
                        idBrand
                    FROM brands
                    WHERE Lower([name]) = Lower(@name)
                    AND available = 1
                ),
                0
                    );
        IF @idBrand = 0
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO brands
            (
                [name],
                [description]
            )
            VALUES
            (@name, @description);
            SET @output = '{"result": 1, "description": "Marca agregada con éxito"}';
            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            SET @output
                = '{"result": 0, "description": "Error: El nombre ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;
        SET @output = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_add_client]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_add_client]
    @name VARCHAR(30),
    @number INT,
    @address VARCHAR(50),
    @email VARCHAR(50)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @output VARCHAR(200);
    SET @name = Ltrim(Rtrim(@name));
    SET @number = Ltrim(Rtrim(@number));
    SET @address = Ltrim(Rtrim(@address));
    SET @email = Ltrim(Rtrim(@email));
    BEGIN try
        IF Len(@name) = 0 --no sé cómo se vaya a tomar en la app el manejo de números
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@number) = 0 --no sé cómo se vaya a tomar en la app el manejo de números
        BEGIN
            SET @output = '{"result": 0, "description": "Error: número vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@address) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: ubicación vacía"}';
            SELECT @output;
            RETURN;
        END
        IF (LEN(@email) = 0) OR (PATINDEX('%[^a-zA-Z0-9_\-\.@]%', @email) <> 0) OR (CHARINDEX('@', @email) <= 1) OR (CHARINDEX('.', @email, CHARINDEX('@', @email)) <= CHARINDEX('@', @email) + 1)
        BEGIN
            SET @output = '{"result": 0, "description": "Error: email inválido"}';
            SELECT @output;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM clients WHERE Lower([name]) = Lower(@name))
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO clients
            (
                [name],
                [contactnumber],
                [address],
                [email],
                [available]
            )
            VALUES
            (@name, @number, @address, @email, 1);
            COMMIT TRANSACTION;

            SET @output = '{"result": 1, "description": "Cliente añadido exitosamente"}';
        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Error: cliente ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION;
        -- se deshacen los cambios realizados
        END;
        SET @output = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_add_machine]    Script Date: 7/11/2023 23:23:49 ******/
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
            SET @output = '{"result": 0, "description": "Error: nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@type) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: tipo vacío"}';
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
                              SELECT TOP 1 idbrand FROM brands WHERE Lower([name]) = Lower(@brand)
                          ),
                          0
                                );
        SELECT @idType = ISNULL(
                         (
                             SELECT TOP 1
                                 idtypemachine
                             FROM typesmachine
                             WHERE Lower([name]) = Lower(@type)
                         ),
                         0
                               );
        IF EXISTS (SELECT 1 FROM machines WHERE [serial] = @serial)
        BEGIN
            SET @output
                = '{"result": 0, "description": "Error: máquina ya existe"}';
        END
        ELSE IF @idBrand = 0
                OR @idType = 0
        BEGIN
            SET @output
                = '{"result": 0, "description": "Error: Marca o maquinaria no disponible"}';
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION;
            INSERT INTO [dbo].[machine]
            (
                [idbrand],
                [idtype],
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
            = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END CATCH
    SELECT @output;
    SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_add_type]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
            SET @output = '{"result": 0, "description": "Error: Nombre vacío"}';

            SELECT @output;

            RETURN;
        END

        IF Len(@description) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: Descripción vacía"}';

            SELECT @output;

            RETURN;
        END

        SELECT @idType = Isnull(
                (
                    SELECT TOP 1
                        idtypemachine
                    FROM typesmachine
                    WHERE Lower([name]) = Lower(@name)
                    AND available = 1
                ),
                0
                    );

        IF @idType = 0
        BEGIN

            BEGIN TRANSACTION;

            INSERT INTO typesmachine
            (
                [name],
                [description]
            )
            VALUES
            (@name, @description);

            SET @output = '{"result": 1, "description": "Maquinaria agregada con éxito"}';

            COMMIT TRANSACTION;
        
        END
        ELSE
        BEGIN

            SET @output
                = '{"result": 0, "description": "Error: El nombre ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_add_user]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_add_user]
    @username VARCHAR(16),
    @name VARCHAR(80),
    @number INT,
    @password VARBINARY(64)
-- El hash de la contrase�a
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;

    DECLARE @output VARCHAR(200);
    SET @username = Ltrim(Rtrim(@username));
    SET @name = Ltrim(Rtrim(@name));

    BEGIN try
        IF Len(@username) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre de usuario vacío"}';
            SELECT @output;
            RETURN;
        END
        IF Len(@name) = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: nombre vacío"}';
            SELECT @output;
            RETURN;
        END
        IF @number = 0
        BEGIN
            SET @output = '{"result": 0, "description": "Error: número vacío"}';
            SELECT @output;
            RETURN;
        END
        IF NOT EXISTS
        (
            SELECT 1
            FROM users
            WHERE Lower(username) = Lower(@username)
            and available = 1
        )
        BEGIN
            BEGIN TRANSACTION;

            INSERT INTO users
            (
                username,
                NAME,
                number,
                password
            )
            VALUES
            (@username, @name, @number, @password);

            COMMIT TRANSACTION;

            SET @output = '{"result": 1, "description": "Nuevo usuario agregado exitosamente."}';
        END
        ELSE
        BEGIN

            SET @output
                = '{"result": 0, "description": "Error: nombre de usuario ya existe"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error inesperado"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_delete_brand]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_delete_brand] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idBrand INT;
          DECLARE @output VARCHAR(200);

          SET @idBrand = Isnull((SELECT TOP 1 idbrand
                                 FROM   brands
                                 WHERE  Lower([name]) = Lower(@name)
                                        AND available = 1), 0)

          IF @idBrand <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE brands
                SET    available = 0
                WHERE  idbrand = @idBrand;

                COMMIT

                SET @output =
                '{"result": 1, "description": "Marca eliminada exitosamente."}';
            END
          ELSE
            BEGIN
                SET @output =
'{"result": 0, "description": "Error: marca no disponible"}'
    ;
END

    SELECT @output;
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;
    END catch
END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_client]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_client] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idClient INT;
          DECLARE @output VARCHAR(200);

          SET @idClient = Isnull((SELECT TOP 1 idclient
                                  FROM   clients
                                  WHERE  Lower([name]) = Lower(@name)
                                         AND available = 1), 0)

          IF @idClient <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE clients
                SET    available = 0
                WHERE  idclient = @idClient;

                COMMIT

                SET @output =
      '{"result": 1, "description": "Cliente eliminado exitosamente."}';
            END
          ELSE
            BEGIN

                SET @output =
'{"result": 0, "description": "Error: cliente no existe"}'
    ;
END

    SELECT @output;
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;
    END catch
END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_machine]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_type]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_type] @name VARCHAR(50)
AS
  BEGIN
      BEGIN try
          SET nocount ON

          DECLARE @idType INT;
          DECLARE @output NVARCHAR(200);

          SET @idType = Isnull((SELECT TOP 1 idtypemachine
                                FROM   typesmachine
                                WHERE  Lower([name]) = Lower(@name)
                                       AND available = 1), 0)

          IF @idType <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE typesmachine
                SET    available = 0
                WHERE  idtypemachine = @idType;

                COMMIT

                SET @output =
      '{"result": 1, "description": "Tipo de máquina eliminado exitosamente."}'
      ;
      END
      ELSE
      BEGIN

SET @output =
'{"result": 0, "description": "Error: tipo de máquina no existe"}'
;
END

    SELECT @output;
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;
    END catch
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_delete_user]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_delete_user] @username VARCHAR(16)
AS
  BEGIN
      SET nocount ON

      BEGIN try
          DECLARE @idUser INT;
          DECLARE @output NVARCHAR(200);

          SELECT @idUser = Isnull((SELECT TOP 1 iduser
                                   FROM   users
                                   WHERE  Lower([username]) = Lower(@username)
                                          AND available = 1
                                          AND [isadmin] = 0), 0)

          IF @idUser <> 0
            BEGIN
                BEGIN TRANSACTION

                UPDATE users
                SET    available = 0
                WHERE  iduser = @idUser;

                COMMIT

                SET @output =
      '{"result": 1, "description": "Usuario eliminado exitosamente."}';
            END
          ELSE
            BEGIN

                SET @output =
'{"result": 0, "description": "Error: usuario no existe o es administrador"}'
    ;
END

    SELECT @output;
END try

    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
          BEGIN
              ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
          END;
    END catch

    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_brands]    Script Date: 7/11/2023 23:23:49 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_clients]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_all_machines]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_all_types]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_all_users]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_brand]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_client]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_machine]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_type]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_type]
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, description FROM typesMachine WHERE LOWER([name]) = LOWER(@name) and available = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 7/11/2023 23:23:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_user_not_admin]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_user_not_admin] @username VARCHAR(50)
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
/****** Object:  StoredProcedure [dbo].[sp_update_brand]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_brand]
    @name VARCHAR(50),
    @newName VARCHAR(50),
    @description VARCHAR(100)
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idBrand INT;
    SET @description = Ltrim(Rtrim(@description));
    SET @newName = Ltrim(Rtrim(@newName));
    DECLARE @output VARCHAR(200);

    BEGIN try

        SET @idBrand = Isnull(
            (
                SELECT TOP 1
                    idBrand
                FROM [dbo].[brands]
                WHERE Lower([name]) = Lower(@name)
                    AND available = 1
            ),
            0
                )
        IF @idBrand <> 0
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM [dbo].[brands]
                WHERE Lower([name]) = Lower(@newName)
            )
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM [dbo].[brands]
                    WHERE Lower([name]) = Lower(@name)
                          AND available = 1
                )
                
                    BEGIN
                        IF NOT Len(@description) = 0
                        BEGIN
                            BEGIN TRANSACTION;

                            UPDATE [dbo].[brands]
                            SET [description] = @description
                            WHERE idBrand = @idBrand;

                            COMMIT TRANSACTION;
                        END
                    
                        IF NOT Len(@newName) = 0
                            BEGIN
                            BEGIN TRANSACTION;
                            UPDATE [dbo].[brands]
                            SET [name] = @newName
                            WHERE idBrand = @idBrand;
                            COMMIT TRANSACTION;
                        END
                    

                    SET @output = '{"result": 1, "description": "Marca editada exitosamente"}';
                END
                ELSE
                BEGIN
                    SET @output
                        = '{"result": 0, "description": "Error: marca no disponible"}';
                END
            END
            ELSE
            BEGIN
                SET @output
                    = '{"result": 0, "description": "Error: marca ya existe"}';
            END
        END
        ELSE
        BEGIN
            SET @output
                        = '{"result": 0, "description": "Error: marca no disponible"}';
        END

    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @output
            = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_client]    Script Date: 7/11/2023 23:23:49 ******/
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
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    SET @inNewName = Ltrim(Rtrim(@inNewName));
    DECLARE @output AS NVARCHAR(200);
    DECLARE @idClient INT;
    SET @inNewEmail = Ltrim(Rtrim(@inNewEmail));

    BEGIN try
        -- Begin a transaction
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
            
                SET @inNewAddress = Ltrim(Rtrim(@inNewAddress));
                IF NOT Len(@inNewAddress) = 0
                BEGIN
                    BEGIN TRANSACTION;

                    UPDATE [dbo].[clients]
                    SET [address] = @inNewAddress
                    WHERE Lower([idclient]) = Lower(@idClient);

                    COMMIT TRANSACTION
                END
                       
                IF NOT (LEN(@inNewEmail) = 0) AND (PATINDEX('%[^a-zA-Z0-9_\-\.@]%', @inNewEmail) = 0) AND (CHARINDEX('@', @inNewEmail) > 1) AND (CHARINDEX('.', @inNewEmail, CHARINDEX('@', @inNewEmail)) > CHARINDEX('@', @inNewEmail) + 1)
                BEGIN
                     BEGIN TRANSACTION;
                    UPDATE [dbo].[clients]
                    SET [email] = @inNewEmail
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

        SET @output = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_machine]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_machine]
    @inSerial VARCHAR(30),
    @inNewModel VARCHAR(60) = NULL,
    @inNewSerial VARCHAR(30) = NULL
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idMachine INT;
	SET @inNewModel = Ltrim(Rtrim(@inNewModel));
	SET @inNewSerial = Ltrim(Rtrim(@inNewSerial));
    DECLARE @output VARCHAR(200);

    BEGIN try
        SET @idMachine = Isnull(
                      (
                          SELECT TOP 1
                              idMachine
                          FROM [dbo].[machines]
                          WHERE Lower([serial]) = Lower(@inSerial)
                                AND available = 1
                      ),
                      0
                            )

        IF @idMachine <> 0
        BEGIN
            
            IF NOT Len(@inNewModel) = 0
            BEGIN
                BEGIN TRANSACTION
				UPDATE [dbo].[machine]
				SET [model] = @inNewModel
				WHERE [serial] = @inSerial;
				COMMIT TRANSACTION
            END
                   
            IF NOT Len(@inNewSerial) = 0
            BEGIN
                BEGIN TRANSACTION
				UPDATE [dbo].[machine]
				SET [serial] = @inNewSerial
				WHERE [serial] = @inSerial;
				COMMIT TRANSACTION
            END
            
            

            SET @output = '{"result": 1, "description": "Cliente editado exitosamente"}';

        END
        ELSE
        BEGIN
            SET @output = '{"result": 0, "description": "Error: cliente no disponible"}';

        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0 -- error sucedio dentro de la transaccion
        BEGIN
            ROLLBACK TRANSACTION; -- se deshacen los cambios realizados
        END;

        SET @output = '{"result": 0, "description": "Error inesperado"}';
    END catch

    SELECT @output;

    SET nocount OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_type]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_type]
    @inName VARCHAR(50),
    @inNewName VARCHAR(50),
    @inDescription VARCHAR(100)
AS
BEGIN
    SET nocount ON;
    SET TRANSACTION isolation level READ uncommitted;
    DECLARE @idTypeMachine INT;
    SET @inDescription = Ltrim(Rtrim(@inDescription));
    SET @inNewName = Ltrim(Rtrim(@inNewName));
    DECLARE @output VARCHAR(200);

    BEGIN try

        SET @idTypeMachine = Isnull(
            (
                SELECT TOP 1
                    idTypeMachine
                FROM [dbo].[typesMachine]
                WHERE Lower([name]) = Lower(@inName)
                    AND available = 1
            ),
            0
                )
        IF @idTypeMachine <> 0
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM [dbo].[typesmachine]
                WHERE Lower([name]) = Lower(@inNewName)
            )
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM [dbo].[typesmachine]
                    WHERE Lower([name]) = Lower(@inName)
                          AND available = 1
                )
                
                    BEGIN
                        IF NOT Len(@inDescription) = 0
                        BEGIN
                            BEGIN TRANSACTION;

                            UPDATE [dbo].[typesmachine]
                            SET [description] = @inDescription
                            WHERE idTypeMachine = @idTypeMachine;

                            COMMIT TRANSACTION;
                        END
                    
                        IF NOT Len(@inNewName) = 0
                            BEGIN
                            BEGIN TRANSACTION;
                            UPDATE [dbo].[typesmachine]
                            SET [name] = @inNewName
                            WHERE idTypeMachine = @idTypeMachine;
                            COMMIT TRANSACTION;
                        END
                    

                    SET @output = '{"result": 1, "description": "Maquinaria editada exitosamente."}';
                END
                ELSE
                BEGIN
                    SET @output
                        = '{"result": 0, "description": "Error: tipo de máquina no disponible"}';
                END
            END
            ELSE
            BEGIN
                SET @output
                    = '{"result": 0, "description": "Error: tipo de máquina ya existe"}';
            END
        END
        ELSE
        BEGIN
            SET @output
                        = '{"result": 0, "description": "Error: tipo de máquina no disponible"}';
        END

    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @output
            = '{"result": 0, "description": "Error inesperado en el servidor"}';
    END catch
    SELECT @output;
    SET nocount OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_user]    Script Date: 7/11/2023 23:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_user]
    @inUsername VARCHAR(16),
    @inNewUsername VARCHAR(16),
    @inNewName VARCHAR(80),
    @inNewNumber INT,
    @inNewPassword VARBINARY(max)
AS
BEGIN
    SET nocount ON
    SET TRANSACTION isolation level READ uncommitted;

    DECLARE @output AS NVARCHAR(200);
    DECLARE @idUser INT;
    SET @inNewUsername = Ltrim(Rtrim(@inNewUsername));
    SET @inNewName = Ltrim(Rtrim(@inNewName));

    BEGIN try
        SET @idUser = Isnull(
                      (
                          SELECT TOP 1
                              iduser
                          FROM [dbo].[users]
                          WHERE Lower([username]) = Lower(@inUsername)
                                AND available = 1
                                AND [isadmin] = 0
                      ),
                      0
                            )

        IF @idUser <> 0
        BEGIN
            
                IF NOT Len(@inNewUsername) = 0
                BEGIN
                    BEGIN TRANSACTION;

                    UPDATE [dbo].[users]
                    SET [username] = @inNewUsername
                    WHERE iduser = @idUser;

                    COMMIT TRANSACTION
                END
                

                IF NOT Len(@inNewName) = 0

                BEGIN
                    BEGIN TRANSACTION;

                    UPDATE [dbo].[users]
                    SET NAME = @inNewName
                    WHERE iduser = @idUser;

                    COMMIT TRANSACTION    
                END
            
                IF NOT @inNewNumber = 0 --ni idea de cómo se maneje en la app los números
                BEGIN
                    BEGIN TRANSACTION;
                    UPDATE [dbo].[users]
                    SET number = @inNewNumber
                    WHERE iduser = @idUser;
                    COMMIT TRANSACTION
                END
                

            
                BEGIN TRANSACTION;
                    UPDATE [dbo].[users]
                    SET password = @inNewPassword
                    WHERE iduser = @idUser;
                COMMIT TRANSACTION

            SET @output = '{"success": 1, "description": "Usuario editado exitosamente"}';
        END
        ELSE
        BEGIN
            SET @output
                = '{"success": 0, "description": "Error: usuario no existe o no es admin"}';
        END
    END try
    BEGIN catch
        IF @@TRANCOUNT > 0
            ROLLBACK;
        SET @output = '{"success": 0, "description": "Error inesperado en el servidor"}';
    END catch

    SELECT @output;
END

GO
USE [master]
GO
ALTER DATABASE [SGR] SET  READ_WRITE 
GO
