USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_brand
GO
CREATE PROCEDURE [dbo].[sp_get_brand] @name VARCHAR(50)
AS
  BEGIN
      SELECT NAME,
             description
      FROM   brands
      WHERE  Lower([name]) = Lower(@name)
             AND available = 1;
  END

go 