USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_all_users
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