USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_client
GO
create PROCEDURE [dbo].[sp_get_client]
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, contactNumber,address,email FROM clients WHERE LOWER([name]) = LOWER(@name) and available = 1;
END

go 