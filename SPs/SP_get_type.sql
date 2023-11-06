USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_type
GO
CREATE PROCEDURE [dbo].[sp_get_type] @name VARCHAR(50)
AS
  BEGIN
      SELECT NAME,
             description
      FROM   typesmachine
      WHERE  Lower([name]) = Lower(@name)
             AND available = 1;
  END

go 