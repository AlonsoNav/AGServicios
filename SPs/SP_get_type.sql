USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_type
GO
CREATE PROCEDURE [dbo].[sp_get_type] @name VARCHAR(50)
AS BEGIN
    SELECT name, description
    FROM typesMachine
    WHERE LOWER([name])=LOWER(@name)and available=1;
END
GO