-- Ejemplo del script de similacion
-- Carga XML
DECLARE @xmlData XML

  SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\david\Desktop\BDtarea1\DatosTarea2.xml', SINGLE_BLOB) 
		AS xmlData
		);

-- cargos todas las fechas en la Tabla fechas

DECLARE @Fechas TABLE (
					   sec INT IDENTITY (1, 1),
					   FechaOperacion DATE
					   )

DECLARE @EmpleadosInsertar TABLE (
								  Sec INT IDENTITY(1,1),
								  Nombre VARCHAR(32),
								  IdTipoDocumento INT,
								  ValorDocumento INT,
								  IdDepartamento INT,
								  IdPuesto INT,
								  Usuario VARCHAR(32),
								  Password VARCHAR(32)
								  )

DECLARE @EmpleadosBorrar TABLE (
								Sec INT IDENTITY(1,1),
								ValorDocumento INT
								)

DECLARE @InsertarDeducciones TABLE (
									Sec INT IDENTITY(1,1),
									ValorDocumento INT,
									HoraEntrada DATETIME,
									HoraSalida DATETIME
									)

DECLARE @EliminarDeducciones TABLE (
									Sec INT IDENTITY(1,1),
									ValorDocumento INT,
									IdTipoDeduccion INT
									)

DECLARE @Asistencias TABLE (
							Sec INT IDENTITY(1,1),
							ValorDocumento INT,
							Entrada DATETIME,
							Salida DATETIME
							)

INSERT INTO @Fechas (FechaOperacion)
SELECT T.Item.value('@Fecha', 'DATE')
FROM @xmlData.nodes('Datos/Tipo_Doc/TipoDocuIdentidad') AS T(Item)



DECLARE @FechaItera DATE, @FechaFin DATE
SET @FechaItera=min(FechaOperacion), @FechaFin= max(FechaOperacion)
FROM @Fechas

While (@FechaItera<=@FechaFin)
BEGIN
	-- cargo en tablas variables la info del xml para esta fecha
	Insert @EmpleadosInsertar (
								  Nombre,
								  IdTipoDocumento,
								  ValorDocumento,
								  IdDepartamento,
								  IdPuesto,
								  Usuario,
								  Password
								  )

	SELECT T.Item.value('@Nombre', 'VARCHAR(64)'),
		   T.Item.value('@IdTipoIdentificacion','INT'),
		   T.Item.value('@ValorDocumentoIdentificacion', 'INT'),
		   T.Item.value('@IdDepartamento', 'INT'),
		   T.Item.value('@IdPuesto', 'INT'),
		   T.Item.value('@Usuario', 'VARCHAR(32)'),
		   T.Item.value('@Password', 'VARCHAR(32)')
	FROM @xmlData.nodes('Datos/Usuarios/Usuario') AS T(Item)
	WHERE @xmlData.FechaOperacion=@FechaItera
	





SELECT
	T.Item.value('@Nombre', 'VARCHAR(64)'),
	T.Item.value('@IdTipoIdentificacion','INT'),
	T.Item.value('@ValorDocumentoIdentificacion', 'INT'),
	T.Item.value('@IdDepartamento', 'INT'),
	T.Item.value('@Puesto', 'VARCHAR(64)'),
	T.Item.value('@FechaNacimiento', 'date')
FROM @xmlData.nodes('Datos/Empleados/Empleado') as T(Item)

















	insert @EmpleadosBorrar  ...
	insert @InsertarDeducciones  ..
	insert @EliminarDeducciones ...
	insert @asistencias
	insert @NuevosHorarios
	
	-- Aplicamos los cargado en tablas variable a la BD real
	-- segun la entidad se puede hacer iterando o utilizando SQL masivo.
	
	Insert dbo.Empleado (Nombre, IdTipoDocIdentidad, ValorDocumentoIdentidad, ...)
	Select E.Nombre, E.IdTipoDocIdentidad, E.ValorDocumentoIdentidad, ..
	From @EmpleadosInsertar
	
	-- el mapeo entre usuarios y empleado, al insertar usuarios sera por ValorDocIdentidad
	
	INSERT dbo.Usuarios (UserName, Password, EsAdministrador, IdEmpleado)
	SELECT E.UserName, E.Password, 0, E.Id
	FROM @EmpleadosInsertar EXML
	INNER JOIN dbo.Empleado E ON EXML.ValorDocumentoIdentidad=E.ValorDocIdentidad
	
	-- Insertar deduccion no obligatorias
    INSERT dbo.DeduccionesXEmpleado (..)
	Select 
	from @InsertarDeducciones
	
	-- desasociar (eliminar deducciones) ...
	
	UPDATE ....
	
	-- Procesar asistencias
	
	Select @lo=Min(A.Sec), @hi=Max(A.Sec)
	from @asistencias A
	
	WHILE (@lo<=@hi)
	BEGIN
		SELECT @Entrada=A.Entrada, @Salida=A.Salida, @ValorDocIdentidad=A.ValorDocIdentidad
		FROM @Asistencias
		WHERE A.Sec=@lo;
		
		Select @idempleado=E.Id
		from dbo.Empleado E
		Where E.ValorDocIdentidad=@ValorDocIdentidad
		
		-- Determinar horas ordinarias
			-- determinar la jornada de esta semana de ese empleado
			Select @HoraInicioJornada=TJ.HoraInicio, @HoraFinJornada=TJ.HoraFin
			FROM dbo.SemanaPlanilla S
			INNER JOIN dbo.Jornada J on S.Id=J.IdSemana 
			INNER JOIN dbo.TipoJornada TJ H.IdTipoJornada=TJ.I
			WHERE (J.IdEmpleado=@idempleado) and (@FechaItera between S.FechaInicio and S.FechaFin)
			
			-- determinar horas ordinarias
			@horasOrdinarias = ????
			
			-- determinar monto ganado por horas ordinarias
			
			@montoGanadoHO = @horasOrdinarias*Puesto.SalarioxHOra de ese empleado
			
			IF @fechaItera es feriado o domingo
			begin
				
				--- determinar horas extraordinarias dobles  y monto
				@montoGanadoHO @horasOrdinarias*Puesto.SalarioxHOra de ese empleado * 2
				
				@horasExtraOrdinariasDobles = ???
				
			end else begin
				--- determinar horas extraordinarias normales y moto
				@montoGanadoHO @horasOrdinarias*Puesto.SalarioxHOra de ese empleado * 1. 5
				
				@horasExtraOrdinariasNormales = ???
			
			end;
			
			Set @EsJueves = 0
			If fechaitera es jueves
			begin
			  Set @EsJueves = 1
			  
			  -- calcular deduccionesObligatorias
			  
			  -- calcular deducciones no obligatorias
			  
			
			end
			
			Set @EsFinMes=0
			If FechaItera es fin de mes
			Begin
			   Set @EsFinMes=1
			end
			
			
			.... la transaccion siempre sera lo ultimo respecto del proceso de un empleado
			Begin transation
			    insertar asistencias 
				...
				
				insertar movimientoplanilla ()
				select .... @montoGanadoHO ...
				where  @horasOrdinarias>0
				
				insertar movimientoplanilla ()
				select .... @montoGanadoHExtrasNormal ...
				where  @horasExtraOrdinariasNOrmales>0
				
				insertar movimientoplanilla ()
				select .... @montoGanadoHExtrasDobles ...
				where  @horasExtraOrdinariasDobles>0
				
				if @esJueves
				Begin
					-- insertar movimientos de deduccion
					-- Cear instancia en semanaplanilla
					-- actualizar planillaxmesxemp
				end
				
				If #esfin de mes
				begin
				    -- crear instancia de PlanillaxMesxEmp
				end
				
				Update dbo.PlanillaSemanalXEmp
				set SalarioBruto=@montoGanadoHO+@montoGanadoHExtrasNormal+@horasExtraOrdinariasDobles
				where EdEmpleado=@idEmpleado and IdSemama=@IdSemana	
			
			commit transaction
			
			
			
		
		
	
	END
	
	
	
	
	
	



end;