USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_all_types
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