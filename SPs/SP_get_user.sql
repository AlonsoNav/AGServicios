USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_user
GO
CREATE PROCEDURE [dbo].[sp_get_user]
	@username VARCHAR(50)
AS
BEGIN
	SELECT username, name, number, password, isAdmin FROM users WHERE LOWER([username]) = LOWER(@username) and available = 1;
END
GO