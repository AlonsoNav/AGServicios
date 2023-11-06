USE SGR
GO
DROP PROCEDURE IF EXISTS Sp_get_all_brands
GO
CREATE PROCEDURE [dbo].[Sp_get_all_brands]
AS
  BEGIN
      SELECT B.name,
             B.description
      FROM   brands AS B
      WHERE  available = 1;
  END

go 