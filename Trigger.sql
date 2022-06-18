CREATE OR ALTER TRIGGER TR_Persona_InsertarDeduccionObligatoria
ON dbo.Empleado
AFTER INSERT
AS
BEGIN
declare @idObligatoria int

SET NOCOUNT ON;

	set @idObligatoria = (select E.id 
						  from dbo.TipoDeduccion E 
						  where E.EsObligatorio = 'Si'
						  )

	INSERT INTO dbo.DeduccionXEmpleado( [IdEmpleado],
										[IdTipoDeduccion]
										)
	SELECT  E.ID,
			@idObligatoria
	FROM INSERTED E
	ORDER BY E.Id
	


SET NOCOUNT OFF;
END;