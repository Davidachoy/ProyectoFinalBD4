CREATE OR ALTER PROCEDURE dbo.InsertarMarca
	@inValDoc INT,
	@inFechaEntrada smalldatetime,
	@inFechaSalida smalldatetime,
	@OutResult INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
		SET @OutResult = 0

		DECLARE @idEmp INT
		DECLARE @diaDeLaSemana VARCHAR(10)
		DECLARE @IdMesActual INT
		DECLARE @idMPXE INT
		DECLARE @idSPXE INT
		DECLARE @idJornada INT	
		DECLARE @SalarioXHora MONEY
		DECLARE @TotalDeduccion INT
		DECLARE @esJueves BIT = 0


		DECLARE @horasTrabajadas INT --Horas
		DECLARE @horasJornada INT
		DECLARE @horasExtra INT
		DECLARE @horasOrdinarias INT
		DECLARE @horasExtraDobles INT


		DECLARE @MontoGanadoHO MONEY  --Salarios
		DECLARE @MontoGanadoHExtra MONEY
		DECLARE @MontoGanadoHExtraDoble MONEY



		SET @diaDeLaSemana = DATENAME(dw, @inFechaEntrada)
		SET @IdMesActual =  (SELECT IdMesPlanilla FROM [dbo].[PlanillaMesXEmpleado] WHERE Id = @idMPXE)
		SET @horasTrabajadas =( DATEDIFF (hh, @inFechaEntrada, @inFechaSalida ))

		SELECT @idEmp = Id	-- Buscar el empleado					
		FROM dbo.Empleado 
		WHERE @inValDoc = ValorDocumentoIdentificacion

		SELECT  @idSPXE = MAX(Id), --  se busca en la PlanillaXSemanaXEmpleado
				@idMPXE = MAX([IdPlanillaMesXEmpleado]) 
		FROM [dbo].[PlanillaSemXEmpleado]
		WHERE @idEmp = IdEmpleado


		SELECT @idJornada = MAX(Id)		-- Busca Jornada para saber los rangos de tiempo
		FROM dbo.Jornada
		WHERE @idEmp = IdEmpleado


		SELECT @SalarioXHora = P.SalarioXHora -- Calcula el Salario del empleado 
		FROM dbo.Puesto P
		INNER JOIN dbo.empleado E 
		ON E.IdPuesto = P.Id
		WHERE E.Id = @idEmp			
		

		SELECT @horasJornada = DATEDIFF(HOUR, TJ.HoraInicio, TJ.HoraFin) 
		FROM TipoJornada TJ
		INNER JOIN DBO.Jornada J
		ON J.IdTipoJornada = TJ.Id
		WHERE J.Id = @idJornada

		SELECT  @horasExtra = @horasTrabajadas - @horasJornada, --DECLARA HORAS EXTRA
				@horasOrdinarias = @horasJornada
		WHERE @horasTrabajadas > @horasJornada

		
		SELECT  @horasExtraDobles = @horasExtra,
				@horasExtra = 0
		WHERE (@diaDeLaSemana = 'Sunday') 
		or (EXISTS (SELECT Fecha 
					FROM dbo.Feriado f 
					WHERE CAST(@inFechaEntrada AS DATE)= f.Fecha))
		


		SELECT  @MontoGanadoHO = @SalarioxHora * @horasOrdinarias,
				@MontoGanadoHExtra = (@SalarioxHora * @horasExtra) * 1.5,
				@MontoGanadoHExtraDoble = (@SalarioxHora * @horasExtraDobles)*2,
				@TotalDeduccion = 0										

		IF DATEPART(WEEKDAY, @inFechaEntrada) = 5					-- Define si la fecha es jueves
		BEGIN	
			SET @esJueves = 1
		END






	SET NOCOUNT OFF;
END;