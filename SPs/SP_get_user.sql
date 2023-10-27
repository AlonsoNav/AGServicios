USE [SGR]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_user]    Script Date: 26/10/2023 20:31:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_get_user]
    @username VARCHAR(16)
AS
BEGIN
    SELECT TOP 1 isAdmin, password
    FROM users
    WHERE username = @username;
END;