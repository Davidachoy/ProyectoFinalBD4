SET NOCOUNT ON


DECLARE @xmlData XML---------------XML
 SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\david\Desktop\ProyectoBD\Datos_Tarea3.2.xml', SINGLE_BLOB) 
		AS xmlData
		);



-----------------------------------Variables para trabajar mejor
DECLARE @Fechas TABLE ( --tabla para manejar las fechas
	sec INT IDENTITY (1, 1),
	FechaOperacion DATE
)

DECLARE @EmpleadosInsertar TABLE (    --tabala para los empleados a insertar
	Sec INT IDENTITY(1,1),
	FechaNacimiento DATE,
	Nombre VARCHAR(64),
	IdTipoDocumento INT,
	ValorDocumento INT,
	IdDepartamento INT,
	IdPuesto INT,
	Usuario VARCHAR(64),
	Password VARCHAR(64)
)

DECLARE @EmpleadosBorrar TABLE ( -- tabla para los empleados a borrar
	Sec INT IDENTITY(1,1),
	ValorDocumento INT
)

DECLARE @InsertarDeduccionesEmpleado TABLE ( -- tabla para las deducciones  a insertar
	Sec INT IDENTITY(1,1),
	monto MONEY,
	ValorDocumento INT,
	IdDeduccion INT
)

DECLARE @EliminarDeduccionesEmpleado TABLE ( -- tabla para eliminar deducciones
	Sec INT IDENTITY(1,1),
	ValorDocumento INT,
	IdDeduccion INT
)

DECLARE @Asistencias TABLE (--tabla para las asistencias
	Sec INT IDENTITY(1,1),
	ValorDocumento INT,
	Entrada smalldatetime,
	Salida smalldatetime
)

DECLARE @NuevosHorarios TABLE (--tablas para las jornadas
	Sec INT IDENTITY(1,1),
	IdJornada INT,
	ValorDocumentoIdentidad INT
)

-------------------------------------------------------
--Declarar variables

DECLARE @FechaItera DATE
DECLARE @FechaFin DATE
--VARIABLES RECORRIDOS
DECLARE @RecorrerSemanas DATE
DECLARE @Semanas INT
DECLARE @SecInicio INT
DECLARE @SecFinal INT
DECLARE @SecItera INT

--EMPLEADO
DECLARE @Nombre VARCHAR(64)
DECLARE @ValorDocumentoIdentidad INT
DECLARE @FechaNacimiento DATE
DECLARE @Username VARCHAR(64)
DECLARE @Contraseña VARCHAR(64)
DECLARE @IdTipoDocumentoIdentidad INT
DECLARE @IdPuesto INT
DECLARE @IdDepartamento INT

--JORNADA
DECLARE @IdJornada INT
--ASISTENCIA 
DECLARE @Entrada SMALLDATETIME
DECLARE @Salida SMALLDATETIME
DECLARE @Fecha DATE

DECLARE @empleadoEliminar INT
DECLARE @tipoEliminar INT



--Ejecutar script cargar catalogo

EXEC [dbo].[BorrarDatos]-- SCRIPT PARA BORRAR DATOS

EXEC [dbo].[cargarDatosCatalogo]



INSERT INTO @Fechas(FechaOperacion)
SELECT T.Item.value('@Fecha', 'DATE') AS FechaOperacion
FROM @xmlData.nodes('Datos/Operacion') AS T(Item)


SET @FechaItera = (SELECT MIN(f.FechaOperacion)
					FROM @Fechas f)
SET @FechaFin  = (SELECT MAX(f.FechaOperacion)
					FROM @Fechas f)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
WHILE (@FechaItera <= @FechaFin)
BEGIN
  
	IF DATEPART(WEEKDAY, @FechaItera) = 5--CALCULO DE LA SEMANA Y EL MES
	BEGIN
		IF(DATENAME(MONTH,DATEADD(DAY,1,@FechaItera)) <> DATENAME(MONTH,DATEADD(DAY,-6,@FechaItera)))
		BEGIN
			SELECT @Semanas = 0
			SELECT @RecorrerSemanas = (SELECT DATEADD(DAY,1,@FechaItera))
			WHILE (DATENAME(MONTH,DATEADD(DAY,1,@FechaItera)) = (DATENAME(MONTH,@RecorrerSemanas)))
			BEGIN
				SET @RecorrerSemanas = (SELECT DATEADD(WEEK,1,@RecorrerSemanas))
				SET @Semanas = @Semanas+1
			END
				INSERT INTO dbo.MesPlanilla([FechaInicio],
											[FechaFin]
											)
				VALUES((SELECT DATEADD(DAY,1,@FechaItera)), (SELECT DATEADD(DAY,7*@Semanas,@FechaItera)))--crea la variable de mes planilla
		END
		
		INSERT INTO dbo.SemanaPlanilla([idMesPlanilla],
									   [FechaInicio],
									   [FechaFin]
									   )
		VALUES( (SELECT MAX(Id) AS Id FROM dbo.MesPlanilla),(SELECT DATEADD(DAY,1,@FechaItera)), (SELECT DATEADD(DAY,7,@FechaItera)))--crea la variable de semana planilla
	END

	----------------------------------------------------EmpleadosInsertar                                                                Insertar en orden o da error
	INSERT INTO @EmpleadosInsertar(FechaNacimiento,
								   Nombre,
								   IdTipoDocumento,
								   ValorDocumento,
								   IdDepartamento,
								   IdPuesto,
								   Usuario,
								   Password
								   )
	SELECT  T.Item.value('@FechaNacimiento', 'DATE') AS FechaNacimiento,
			T.Item.value('@Nombre', 'VARCHAR(64)') AS Nombre,
			T.Item.value('@idTipoDocumentacionIdentidad', 'INT') AS IdTipoDocumento,
			T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumento,
			T.Item.value('@idDepartamento', 'INT') AS IdDepartamento,
			T.Item.value('@idPuesto', 'INT') AS IdPuesto,
			T.Item.value('@Username', 'VARCHAR(64)') AS Usuario,
			T.Item.value('@Password', 'VARCHAR(64)') AS Password
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/NuevoEmpleado') AS T(Item) 



	------------------------------------------------EmpleadosBorrar
	INSERT INTO @EmpleadosBorrar(ValorDocumento)
	SELECT T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumento
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/EliminarEmpleado') AS T(Item)

	----------------------------------------------------InsertarDeducciones

	INSERT INTO @InsertarDeduccionesEmpleado(monto,
											 ValorDocumento,
											 IdDeduccion
											 )
	SELECT  T.Item.value('@Monto', 'MONEY') AS monto,  
			T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumento,
			T.Item.value('@IdDeduccion', 'INT') AS IdDeduccion	
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/AsociaEmpleadoConDeduccion')  AS T(Item)



	-----------------------------------------------EliminarDeducciones
	INSERT INTO @EliminarDeduccionesEmpleado(ValorDocumento,
											 IdDeduccion
											 )
	SELECT  T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumento,
			T.Item.value('@IdDeduccion', 'INT') AS IdDeduccion
			
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/DesasociaEmpleadoConDeduccion') AS T(Item)

	--------------------------------------------insert @asistencias

	INSERT INTO @Asistencias
	SELECT  T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumentoIdentidad,
			T.Item.value('@FechaEntrada', 'smalldatetime') AS Entrada,
			T.Item.value('@FechaSalida', 'smalldatetime') AS Salida
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/MarcaDeAsistencia') AS T(Item)

	--------------------------------------------insert @NuevosHorarios

	INSERT INTO @NuevosHorarios(IdJornada,
								ValorDocumentoIdentidad
								)
	SELECT  T.Item.value('@IdJornada', 'INT') AS IdJornada,
			T.Item.value('@ValorDocumentoIdentidad', 'INT') AS ValorDocumentoIdentidad
	FROM @xmlData.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/TipoDeJornadaProximaSemana') AS T(Item)

	-------------------------------------------------------------------------------------------------------------------------------- Insertar empleados
	-- Marcar Asistencia


	If EXISTS(SELECT 1 
		      FROM @Asistencias
			  )
	BEGIN
		SELECT @SecInicio = MIN(Sec), 
			   @SecFinal = MAX(Sec) 
		FROM @Asistencias;

		SET @SecItera = @SecInicio;

		WHILE @SecItera <= @SecFinal
		BEGIN

			SELECT @ValorDocumentoIdentidad = A.ValorDocumento,
				   @Entrada = A.Entrada,
				   @Salida = A.Salida
			FROM @Asistencias A
			WHERE A.Sec = @SecItera

			EXEC [dbo].[sp_InsertarMarca]
				@ValorDocumentoIdentidad,
				@Entrada,
				@Salida,
				@FechaItera




			SET @SecItera = @SecItera + 1
		END;
	END;

	-- Ingreso de los empleados nuevos 

	If EXISTS(SELECT 1 
		      FROM @EmpleadosInsertar E
			  )
	BEGIN
		SELECT @SecInicio = MIN(Sec),
			   @SecFinal = MAX(Sec)
		FROM @EmpleadosInsertar

		SET @SecItera = @SecInicio

		WHILE @SecItera <= @SecFinal
		BEGIN
			SELECT @Nombre = E.Nombre,
				   @ValorDocumentoIdentidad = E.ValorDocumento,
				   @FechaNacimiento = E.FechaNacimiento,
				   @IdPuesto = E.IdPuesto,
				   @IdTipoDocumentoIdentidad = E.IdTipoDocumento,
				   @IdDepartamento = E.IdDepartamento,
				   @Username = E.Usuario,
				   @Contraseña = E.Password
			FROM @EmpleadosInsertar E
			WHERE @SecItera = E.Sec

			EXEC [dbo].[sp_InsertarEmpleado]
				@Nombre,
				@ValorDocumentoIdentidad,
				@FechaNacimiento,
				@IdPuesto,
				@IdDepartamento,
				@IdTipoDocumentoIdentidad,
				@Username,
				@Contraseña

			SET @SecItera = @SecItera + 1
		END;	
	END;


	-- Eliminacion de empleados 
	If EXISTS(SELECT 1 
		      FROM @EmpleadosBorrar E
			  )
	BEGIN
		SELECT @SecInicio = MIN(Sec), 
			   @SecFinal = MAX(Sec) 
		FROM @EmpleadosBorrar;

		SET @SecItera = @SecInicio;
		WHILE @SecItera <= @SecFinal
		BEGIN
			SELECT @ValorDocumentoIdentidad = E.ValorDocumento
			FROM @EmpleadosBorrar E
			WHERE @SecItera = E.Sec

			EXEC [dbo].[sp_EliminarEmpleado]
				@ValorDocumentoIdentidad
			SET @SecItera = @SecItera + 1
		END;
	END;






-- Asignar Jornada

	If EXISTS(SELECT 1 
		      FROM @NuevosHorarios N
			  )
	BEGIN 
		SELECT @SecInicio = MIN(Sec), 
			   @SecFinal = MAX(Sec) 
		FROM @NuevosHorarios;

		SET @SecItera = @SecInicio;

		WHILE @SecItera <= @SecFinal
		BEGIN
			SELECT @ValorDocumentoIdentidad = N.ValorDocumentoIdentidad,
			       @IdJornada = N.IdJornada
			FROM @NuevosHorarios N
			WHERE @SecItera = N.Sec

			EXEC [dbo].[sp_NuevoHorario]
				@ValorDocumentoIdentidad,
				@IdJornada
			SET @SecItera = @SecItera + 1
		END;
	END;









--	 --Insertar deduccion no obligatorias
	IF (NOT EXISTS (SELECT * 
					FROM dbo.FijaNoObligatoria f 
					INNER JOIN @InsertarDeduccionesEmpleado E
					ON E.monto = F.Monto
					WHERE F.Monto = E.monto)
					)
		BEGIN
			INSERT INTO dbo.FijaNoObligatoria
			SELECT  E.monto AS [Monto]
			FROM @InsertarDeduccionesEmpleado E


		END;

	DECLARE @maxId int
	SELECT @maxId = MAX(Id) FROM dbo.SemanaPlanilla
	IF  DATEPART(WEEKDAY, @FechaItera) = 5 
		SELECT @Fecha = (SELECT FechaInicio FROM dbo.SemanaPlanilla WHERE Id = @maxId)
	ELSE
		SELECT @Fecha = (SELECT DATEADD(DAY, 1 , (SELECT FechaFin FROM dbo.SemanaPlanilla WHERE Id = @maxId)))



	INSERT dbo.DeduccionXEmpleado
	SELECT  E.Id AS [IdEmpleado],
			I.IdDeduccion AS [IdTipoDeduccion],
			f.Id AS [IdFijaNoObligatoria],
			@Fecha,
			NULL,
			1
	FROM @InsertarDeduccionesEmpleado I
	INNER JOIN dbo.Empleado E 
	ON I.ValorDocumento = E.ValorDocumentoIdentificacion
	INNER JOIN dbo.FijaNoObligatoria f
	ON f.Monto = i.monto


	 --desasociar (eliminar deducciones) ...

	SELECT @empleadoEliminar= E.Id, @tipoEliminar = T.Id
	FROM @EliminarDeduccionesEmpleado D
	INNER JOIN dbo.Empleado E
	ON e.ValorDocumentoIdentificacion = D.ValorDocumento
	INNER JOIN DBO.TipoDeduccion T
	ON T.Id =D.IdDeduccion 

	
	IF DATEPART(WEEKDAY, @FechaItera) = 5
		SELECT @Fecha = @FechaItera

	ELSE
		SELECT @Fecha = (SELECT FechaFin FROM dbo.SemanaPlanilla WHERE Id = @maxId)

	UPDATE dbo.DeduccionXEmpleado
	SET FechaFin = @Fecha, Activo = 0
	where @empleadoEliminar = [IdEmpleado]  AND  @tipoEliminar = [IdTipoDeduccion]


--	-----------------------------------------------------------------------------------------------------------------------------------------------------

	DELETE FROM @EmpleadosInsertar/*Limpia la tabla @EmpleadosInsertar*/
	DELETE FROM @Asistencias/*Limpia la tabla @Asistencias*/
	DELETE FROM @EmpleadosBorrar/*Limpia la tabla @EmpleadosBorrar*/
	DELETE FROM @EliminarDeduccionesEmpleado/*Limpia la tabla @EliminarDeduccionesEmpleado*/
	DELETE FROM @NuevosHorarios/*Limpia la tabla @NuevosHorarios*/
	DELETE FROM @InsertarDeduccionesEmpleado/*Limpia la tabla de @InsertarDeduccionesEmpleado*/


	SET @FechaItera = DATEADD(DAY,1,@FechaItera)

END;
SET NOCOUNT OFF;
 
