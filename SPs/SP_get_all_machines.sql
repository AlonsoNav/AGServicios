USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_all_machines
GO
CREATE PROCEDURE [dbo].[sp_get_all_machines]
AS
  BEGIN
      SELECT M.[serial],
             M.[model],
             B.[name]  brand,
             TM.[name] type
      FROM   [dbo].[machines] M
             INNER JOIN brands B
                     ON M.[idbrand] = B.[idbrand]
             INNER JOIN typesmachine TM
                     ON M.[idtype] = TM.[idtypemachine]
      WHERE  M.available = 1;
  END 
GO