USE SGR
GO
DROP PROCEDURE IF EXISTS sp_get_machine
GO
CREATE PROCEDURE sp_get_machine
	@serial VARCHAR(30)
AS
BEGIN
	SELECT M.[serial], M.[model], B.[name] brand, TM.[name] type
    FROM [dbo].[Machine] M
    INNER JOIN brands B ON M.[idBrand] = B.[idBrand]
    INNER JOIN typesMacine TM ON M.[idType] = TM.[idTypeMachine]
    WHERE M.[serial] = @serial and available = 1;
END