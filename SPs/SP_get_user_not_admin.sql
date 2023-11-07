USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_user_not_admin
GO
CREATE PROCEDURE [dbo].[sp_get_user_not_admin] @username VARCHAR(50)
AS
  BEGIN
      SELECT U.username,
             U.name,
             U.number,
             U.password,
             U.isAdmin
      FROM   users AS U
      WHERE  Lower([username]) = Lower(@username)
             AND available = 1
             AND isadmin = 0;
  END
GO