USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_user
GO
CREATE PROCEDURE [dbo].[sp_get_user] @username VARCHAR(50)
AS
  BEGIN
      SELECT username,
             NAME,
             number,
             password,
             isadmin
      FROM   users
      WHERE  Lower([username]) = Lower(@username)
             AND available = 1;
  END

go 