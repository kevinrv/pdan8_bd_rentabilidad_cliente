--- Laboratorio Funciones y procedimientos
/*

Ejercicio 1. Crear una función para calcular la rentabilidad
Crear una función escalar llamada fn_calcular_rentabilidad.

La función debe recibir dos parámetros:

@Ingresos DECIMAL(18,2)
@Costos DECIMAL(18,2)
Debe devolver la diferencia entre ambos valores.

Reglas
Si ambos parámetros tienen valores, calcular ingresos menos costos.
Si alguno es NULL, definir y documentar cómo debe comportarse la función.
El resultado debe admitir valores positivos, negativos y cero.
Ejemplo de uso esperado
*/


CREATE FUNCTION dbo.fn_calcular_rentabilidad (@Ingresos DECIMAL(18,2),
@Costos DECIMAL(18,2))
RETURNS DECIMAL(18,2)
AS 
BEGIN
DECLARE @rentabilidad DECIMAL(18,2);

SET @rentabilidad = @Ingresos-@Costos;

RETURN @rentabilidad;

END;

SELECT dbo.fn_calcular_rentabilidad(15000, 9000) AS Rentabilidad;