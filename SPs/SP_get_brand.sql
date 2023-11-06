USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_brand
GO
CREATE PROCEDURE sp_get_brand
	@name VARCHAR(50)
AS
BEGIN
	SELECT name, description FROM brands WHERE LOWER([name]) = LOWER(@name) and available = 1;
END