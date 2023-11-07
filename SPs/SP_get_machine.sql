USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_machine
GO
CREATE PROCEDURE [dbo].[sp_get_machine] @serial VARCHAR(30)
AS
  BEGIN
      SELECT M.[serial],
             M.[model],
             B.[name]  brand,
             TM.[name] type
      FROM   [dbo].[machine] M
             INNER JOIN brands B
                     ON M.[idbrand] = B.[idbrand]
             INNER JOIN typesmacine TM
                     ON M.[idtype] = TM.[idtypemachine]
      WHERE  M.[serial] = @serial
             AND available = 1;
  END 
GO