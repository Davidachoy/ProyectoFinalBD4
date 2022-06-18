DECLARE @xmlData XML

  SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\david\Desktop\ProyectoBD\Datos_Tarea3.xml', SINGLE_BLOB) 
		AS xmlData
		);

declare @TDedu table(
	Id int,
	Nombre varchar(64),
	EsObligatorio varchar(64),
	EsPorcentual varchar(64)
);

declare @DPorObli table(
	Id int,
	Porcentage float
);

INSERT INTO @TDedu
SELECT 
    T.Item.value('@Id','INT') as Id,
    T.Item.value('@Nombre', 'varchar(64)') as Nombre,
    T.Item.value('@Obligatorio', 'varchar(64)') as EsObligatorio,
    T.Item.value('@Porcentual', 'varchar(64)') as EsPorcentual

FROM @xmlData.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') as T(Item)

INSERT INTO @DPorObli
SELECT 
    T.Item.value('@Id','INT') as Id,
    T.Item.value('@Valor','FLOAT') as Porcentaje
FROM @xmlData.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion[@Porcentual = "Si"]') as T(Item)




select TD.Nombre, TD.EsObligatorio, TD.EsObligatorio, DPO.Porcentage
from @DPorObli DPO
inner join @TDedu TD on 
DPO.Id = TD.Id




