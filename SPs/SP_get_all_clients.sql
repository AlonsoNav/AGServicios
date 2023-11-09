USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_all_clients
GO
CREATE PROCEDURE [dbo].[sp_get_all_clients]
AS BEGIN
    SELECT C.name, C.contactnumber, C.address, C.email
    FROM clients AS C
    WHERE available=1;
END
GO