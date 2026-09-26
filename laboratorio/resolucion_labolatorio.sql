USE pdan_8_rentabilidad_cliente;

/*
Mostrar:

ID
Código
Tipo de cliente
Estado
Segmento
Ordenar los resultados por código de cliente.
*/
SELECT
	cl.id,
	cl.codigo,
	cl.tipo_cliente,
	cl.estado,
	s.nombre
FROM clientes cl
	INNER JOIN segmentos s ON s.id =cl.segmento_id
ORDER BY 2 DESC;

-- Mostrar todos los clientes cuyo estado sea:

SELECT
	cl.id,
	cl.codigo,
	cl.tipo_cliente,
	cl.estado,
	s.nombre
FROM clientes cl
	INNER JOIN segmentos s ON s.id =cl.segmento_id
WHERE 
	cl.estado='activo'
ORDER BY 2 DESC;

/*
Mostrar:

Código
Nombre
Tipo de producto
Moneda
Estado
Únicamente para productos activos.
*/

SELECT 
	p.codigo,
	p.nombre,
	p.tipo_producto,
	p.moneda, 
	p.estado 
FROM productos p 
WHERE p.estado = 'activo' 
ORDER BY p.nombre;

/* 
Ejercicio 4 — Operaciones mayores a S/ 5,000
Mostrar las operaciones cuyo importe sea mayor a:

S/ 5,000
Ordenarlas de mayor a menor importe.
*/

SELECT
*FROM operaciones
WHERE importe > '5000'
ORDER BY importe DESC;


/*
Ejercicio 5 — ¿Cuántos clientes tenemos?
Obtener:

Cantidad total de clientes.
Cantidad de clientes activos.
Cantidad de clientes bloqueados.
Cantidad de clientes Inactivos.
*/


SELECT COUNT(*) FROM clientes;

SELECT COUNT(*) FROM CLIENTES WHERE estado = 'Activo';

SELECT COUNT(*)
FROM clientes
WHERE estado = 'Bloqueado';

Select count(*) from CLIENTES
Where ESTADO = 'inactivo'
/*
Ejercicio 6 — Importe de las operaciones
Calcular:

Operación mínima.
Operación máxima.
Importe promedio.
Importe total.
Conceptos
*/

SELECT
	tipo_operacion AS concepto,
	MIN (importe) AS 'Operación mínima',
	MAX (importe) AS 'Operación máxima',
	AVG (importe) AS 'Importe promedio',
	SUM (importe) AS 'Importe total'
FROM operaciones
GROUP BY tipo_operacion;

/*
Ejercicio 7 — Clientes y sus segmentos
Mostrar:

Cliente
Código
Segmento
Estado
Relacionar:

clientes → segmentos
Conceptos
INNER JOIN
*/

SELECT 
CASE WHEN c.tipo_cliente = 'N' THEN CONCAT(pn.nombres, ' ', pn.app, ' ', pn.apm) ELSE pj.razon_social END AS Cliente,
c.codigo AS Codigo,
s.nombre AS Segmento,
c.estado AS Estado 
FROM clientes AS c 
INNER JOIN segmentos AS s ON c.segmento_id = s.id 
LEFT JOIN personas_naturales AS pn ON pn.cliente_id = c.id
LEFT JOIN personas_juridicas AS pj ON pj.cliente_id = c.id ORDER BY Cliente;

SELECT
    c.id AS Cliente,
    c.codigo AS Codigo,
    CONCAT(pn.nombres, ' ', pn.app, ' ', pn.apm) AS NombreCliente,
    s.nombre AS Segmento,
    c.estado AS Estado
FROM clientes AS c
INNER JOIN segmentos AS s
    ON c.segmento_id = s.id
INNER JOIN personas_naturales AS pn
    ON c.id = pn.cliente_id;

SELECT
    c.id AS Cliente,
    c.codigo AS Codigo,
    s.nombre AS Segmento,
    c.estado AS Estado
FROM clientes AS c
INNER JOIN segmentos AS s
    ON c.segmento_id = s.id;

/*
Ejercicio 8 — Productos y categorías
Mostrar:

Producto
Código
Categoría
Tipo de producto
Moneda
Estado
Relacionar:

productos → categoria_productos
*/
SELECT
    p.nombre AS Producto,
    p.codigo AS Codigo,
    cp.nombre AS Categoria,
    p.tipo_producto AS Tipo_producto,
    p.moneda AS Moneda,
    p.estado AS Estado
FROM productos AS p
INNER JOIN categoria_productos AS cp
    ON p.categoria_id = cp.id;

	/*
	Ejercicio 9 — Clientes por segmento
Determinar cuántos clientes pertenecen a cada segmento.

Resultado esperado:

Segmento       CantidadClientes
-------------- ---------------
Básico         ...
Masivo         ...
Preferente     ...
Premium        ...
...
Ordenar de mayor a menor cantidad de clientes.
	*/


SELECT
	s.nombre AS 'segmento',
	COUNT(*) AS 'num_clientes'
FROM clientes c
INNER JOIN segmentos s ON s.id=c.segmento_id
GROUP BY s.nombre
ORDER BY 2 DESC;

/* 
Ejercicio 10 — Operaciones por canal
Determinar cuántas operaciones se realizan por cada canal.

Mostrar:

Canal
CantidadOperaciones
ImporteTotal
*/
SELECT
    c.nombre AS Canal,
    COUNT(o.id) AS CantidadOperaciones,
    SUM(o.importe) AS ImporteTotal
FROM operaciones AS o
INNER JOIN canales AS c
    ON o.canal_id = c.id
GROUP BY
    c.id,
    c.nombre
ORDER BY 2 DESC;

/* 
Ejercicio 11 — Productos más contratados
Determinar qué productos tienen mayor cantidad de contrataciones.

Mostrar:

Producto
CantidadContrataciones
Ordenar de mayor a menor.
*/

SELECT
p.nombre AS 'Producto',
COUNT(c.id) AS 'num_contrataciones'
FROM productos p
INNER JOIN contrataciones c ON c.producto_id=p.id
GROUP BY p.nombre
ORDER BY 2 DESC;

/*
Ejercicio 12 — Clientes sin contrataciones
Encontrar clientes que nunca hayan contratado un producto.

Pista
Analizar cuándo resulta conveniente utilizar:

LEFT JOIN
en lugar de:

INNER JOIN
*/

SELECT
    c.id AS Cliente,
    c.codigo AS Codigo
FROM clientes AS c
LEFT JOIN contrataciones AS co
    ON c.id = co.cliente_id
WHERE co.id IS NULL;


INSERT INTO clientes VALUES ('C71118','N','2026-09-23',	'inactivo','6')

/* 
Calcular cuánto ingreso genera cada segmento.

Resultado esperado:

Segmento       Ingresos
-------------- ----------
Básico         S/ ...
Masivo         S/ ...
Premium        S/ ...
*/ 
SELECT
    s.nombre AS Segmento,
    SUM(i.importe) AS Ingresos
FROM ingresos AS i
INNER JOIN clientes AS c
    ON i.cliente_id = c.id
INNER JOIN segmentos AS s
    ON c.segmento_id = s.id
GROUP BY
    s.id,
    s.nombre
ORDER BY 2 DESC;

/*
Ejercicio 14 — Costos por segmento
Calcular cuánto costo genera cada segmento.

Mostrar:

Segmento
Costos
*/

SELECT 
s.nombre AS Segmento, 
CONCAT('S/ ', FORMAT(ISNULL(SUM(i.importe), 0), 'N2')) AS Costos 
FROM segmentos AS s 
LEFT JOIN clientes AS c ON c.segmento_id = s.id 
LEFT JOIN costos AS i ON i.cliente_id = c.id 
GROUP BY s.nombre 
ORDER BY ISNULL(SUM(i.importe), 0) DESC;

/*
Ejercicio 15 — Rentabilidad por segmento ⭐
Calcular:

RENTABILIDAD = INGRESOS - COSTOS
Mostrar:

Segmento
Ingresos
Costos
Rentabilidad
*/

--WITH
WITH ingresos_segmento AS (
    SELECT
        c.segmento_id,
        SUM(i.importe) AS Ingresos
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.segmento_id
),
costos_segmento AS (
    SELECT
        c.segmento_id,
        SUM(co.importe) AS Costos
    FROM costos AS co
    INNER JOIN clientes AS c
        ON co.cliente_id = c.id
    GROUP BY
        c.segmento_id
)
SELECT
    s.nombre AS Segmento,
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad
FROM segmentos AS s
LEFT JOIN ingresos_segmento AS i
    ON s.id = i.segmento_id
LEFT JOIN costos_segmento AS co
    ON s.id = co.segmento_id
ORDER BY
    s.id;


--SUBCONSULTA

  SELECT
  s.nombre AS segmento,
  (SELECT SUM (importe) FROM ingresos i INNER JOIN clientes c ON c.id=i.cliente_id WHERE c.segmento_id=s.id)AS 'Ingresos',
  (SELECT SUM (importe) FROM costos i INNER JOIN clientes c ON c.id=i.cliente_id WHERE c.segmento_id=s.id)AS 'Costos',
  (SELECT SUM (importe) FROM ingresos i INNER JOIN clientes c ON c.id=i.cliente_id WHERE c.segmento_id=s.id) -
  (SELECT SUM (importe) FROM costos i INNER JOIN clientes c ON c.id=i.cliente_id WHERE c.segmento_id=s.id) AS 'rentabilidad'
  FROM segmentos s;

  -- Con tablas temporales

      SELECT
        c.segmento_id,
        SUM(i.importe) AS Ingresos
        INTO #i
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.segmento_id;

    SELECT
        c.segmento_id,
        SUM(i.importe) AS Costos
        INTO #c
    FROM costos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.segmento_id;

    SELECT
    s.nombre AS Segmento,
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad
FROM segmentos AS s
LEFT JOIN #i AS i
    ON s.id = i.segmento_id
LEFT JOIN #c AS co
    ON s.id = co.segmento_id
ORDER BY
    s.id;

DROP TABLE #i;
DROP TABLE #c;

/*
Ejercicio 16 — Rentabilidad por cliente ⭐
Determinar cuánto gana o pierde el banco con cada cliente.

Mostrar:

Cliente
Ingresos
Costos
Rentabilidad
Ordenar de mayor a menor rentabilidad.

*/

WITH ingresos_segmento AS (
    SELECT
        c.id,
        SUM(i.importe) AS Ingresos
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.id
),
costos_segmento AS (
    SELECT
        c.id,
        SUM(co.importe) AS Costos
    FROM costos AS co
    INNER JOIN clientes AS c
        ON co.cliente_id = c.id
    GROUP BY
        c.id
)
SELECT
    cl.codigo AS Cliente,
    CASE WHEN cl.tipo_cliente='N' THEN 'Persona Natural' 
     ELSE 'Persona Juridica' END AS 'Tipo cliente',
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad
FROM clientes AS cl
LEFT JOIN ingresos_segmento AS i
    ON cl.id = i.id
LEFT JOIN costos_segmento AS co
    ON cl.id = co.id
ORDER BY
    2,5 DESC;

/*
Ejercicio 17 — Top 10 clientes más rentables
Mostrar los 10 clientes con mayor rentabilidad.

Concepto sugerido
TOP

*/
DROP TABLE #rtbl_cliente;

WITH ingresos_segmento AS (
    SELECT
        c.id,
        SUM(i.importe) AS Ingresos
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.id
),
costos_segmento AS (
    SELECT
        c.id,
        SUM(co.importe) AS Costos
    FROM costos AS co
    INNER JOIN clientes AS c
        ON co.cliente_id = c.id
    GROUP BY
        c.id
)
SELECT
    cl.codigo AS Cliente,
    CASE WHEN cl.tipo_cliente='N' THEN 'Persona Natural' 
     ELSE 'Persona Juridica' END AS 'tipo_cliente',
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad
INTO #rtbl_cliente
FROM clientes AS cl
LEFT JOIN ingresos_segmento AS i
    ON cl.id = i.id
LEFT JOIN costos_segmento AS co
    ON cl.id = co.id
ORDER BY  5 DESC;


SELECT 
    RANK() OVER (ORDER BY Rentabilidad DESC) AS Puesto,
    Cliente,
    tipo_cliente,
    Ingresos,
    Costos,
    Rentabilidad
INTO #rtbl_cliente_ranking
FROM #rtbl_cliente

SELECT*
FROM #rtbl_cliente_ranking
WHERE Puesto<=10;


--CTE
--RANK
WITH rtlb_ranking AS (
SELECT 
    RANK() OVER (ORDER BY Rentabilidad DESC) AS Puesto,
    Cliente,
    tipo_cliente,
    Ingresos,
    Costos,
    Rentabilidad
FROM #rtbl_cliente
)
SELECT * FROM rtlb_ranking;
--WHERE Puesto<=10;

--DENSE_RANK
WITH rtlb_ranking AS (
SELECT 
    DENSE_RANK() OVER (ORDER BY Rentabilidad DESC) AS Puesto,
    Cliente,
    tipo_cliente,
    Ingresos,
    Costos,
    Rentabilidad
FROM #rtbl_cliente
)
SELECT * FROM rtlb_ranking
WHERE Puesto<=10;

-- ROW_NUMBER()

WITH rtlb_ranking AS (
SELECT 
    DENSE_RANK() OVER (ORDER BY Rentabilidad DESC) AS Puesto,
    Cliente,
    tipo_cliente,
    Ingresos,
    Costos,
    Rentabilidad
FROM #rtbl_cliente
)
SELECT * FROM rtlb_ranking;
--WHERE Puesto<=10;

-- Consulta 1: calcular las 10 rentabilidades mas altas
-- Consultados hallo la rentabilidad y pregunto si esta en el grupo de las 10 rentabilidades mas altas


/*Ejercicio 18 — Clientes que generan pérdidas
Encontrar clientes cuya rentabilidad sea menor que cero.

Rentabilidad < 0
Mostrar:

Cliente
Ingresos
Costos
Rentabilidad*/

DROP TABLE #rtbl_cliente;

WITH ingresos_segmento AS (
    SELECT
        c.id,
        SUM(i.importe) AS Ingresos
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.id
),
costos_segmento AS (
    SELECT
        c.id,
        SUM(co.importe) AS Costos
    FROM costos AS co
    INNER JOIN clientes AS c
        ON co.cliente_id = c.id
    GROUP BY
        c.id
)
SELECT
    cl.codigo AS Cliente,
    CASE WHEN cl.tipo_cliente='N' THEN 'Persona Natural' 
     ELSE 'Persona Juridica' END AS 'tipo_cliente',
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad
INTO #rtbl_cliente
FROM clientes AS cl
LEFT JOIN ingresos_segmento AS i
    ON cl.id = i.id
LEFT JOIN costos_segmento AS co
    ON cl.id = co.id
ORDER BY  5 DESC;

SELECT 
    Cliente,
    tipo_cliente,
    Ingresos,
    Costos,
    Rentabilidad
FROM #rtbl_cliente
WHERE Rentabilidad < 0
ORDER BY  5 ASC;

/*

🔵 NIVEL 4 — INTERMEDIO / AVANZADO
Ahora introducimos herramientas más potentes de SQL Server.

Ejercicio 19 — Clasificación de clientes por rentabilidad
Crear una clasificación utilizando CASE:

Condición	Clasificación
Rentabilidad >= 10,000	Alta
Rentabilidad >= 5,000	Media
Rentabilidad >= 0	Baja
Rentabilidad < 0	Pérdida

Concepto
CASE

*/

WITH ingresos_segmento AS (
    SELECT
        c.id,
        SUM(i.importe) AS Ingresos
    FROM ingresos AS i
    INNER JOIN clientes AS c
        ON i.cliente_id = c.id
    GROUP BY
        c.id
),
costos_segmento AS (
    SELECT
        c.id,
        SUM(co.importe) AS Costos
    FROM costos AS co
    INNER JOIN clientes AS c
        ON co.cliente_id = c.id
    GROUP BY
        c.id
)
SELECT
    cl.codigo AS Cliente,
    CASE WHEN cl.tipo_cliente='N' THEN 'Persona Natural' 
     ELSE 'Persona Juridica' END AS 'tipo_cliente',
    ISNULL(i.Ingresos, 0) AS Ingresos,
    ISNULL(co.Costos, 0) AS Costos,
    ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) AS Rentabilidad,
    CASE 
        WHEN ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) >= 10000 THEN 'Alta'
        WHEN ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) >= 5000 THEN 'Media'
        WHEN ISNULL(i.Ingresos, 0) - ISNULL(co.Costos, 0) >= 0 THEN 'Baja'
    ELSE 'Pérdida' END AS 'Clasificacion'
FROM clientes AS cl
LEFT JOIN ingresos_segmento AS i
    ON cl.id = i.id
LEFT JOIN costos_segmento AS co
    ON cl.id = co.id
ORDER BY  5 DESC;





/*
Ejercicio 20 — Participación de cada cliente
Calcular qué porcentaje de los ingresos totales representa cada cliente.

Resultado esperado:

Cliente    Ingresos    Participación
---------  ----------  ------------
C00001     50,000      2.35%
C00002     30,000      1.41%
...
*/

DECLARE @ingreso_total DECIMAL(18,4);
SET @ingreso_total= (SELECT SUM(importe) FROM ingresos);

SELECT
c.codigo AS Cliente, 
SUM(i.importe) AS Ingresos, 
CONCAT(CAST( SUM(i.importe) * 100.0 / @ingreso_total AS DECIMAL(5,4) ), ' %') AS Participacion_Pct 
INTO #prtcp_ingresos
FROM clientes c
LEFT JOIN ingresos i ON i.cliente_id = c.id 
GROUP BY c.codigo 
ORDER BY Participacion_Pct DESC;

--DENSE_RANK
SELECT
DENSE_RANK() OVER (ORDER BY Participacion_Pct DESC) AS Ranking,*
FROM #prtcp_ingresos

--RANK
SELECT
RANK() OVER (ORDER BY Participacion_Pct DESC) AS Ranking,*
FROM #prtcp_ingresos

--ROW_NUMBER

SELECT
ROW_NUMBER() OVER (ORDER BY Participacion_Pct DESC) AS Ranking,*
FROM #prtcp_ingresos
-----------------------------------------------------------------

WITH ingresos_por_cliente AS (
    -- 1. Sumar los ingresos de cada cliente.
    SELECT
        c.id,
        c.codigo,
        ISNULL(SUM(i.importe), 0) AS ingreso_cliente
    FROM dbo.clientes AS c
    LEFT JOIN dbo.ingresos AS i
        ON i.cliente_id = c.id
    GROUP BY c.id, c.codigo
),
ingresos_con_total AS (
    -- 2. Sumar los ingresos de todos los clientes.
    SELECT
        codigo,
        ingreso_cliente,
        SUM(ingreso_cliente) OVER () AS ingreso_total
    FROM ingresos_por_cliente
)
-- 3. Calcular la participación de cada cliente.
SELECT
    codigo AS Cliente,
    ingreso_cliente AS Ingresos,
    ingreso_total AS TotalIngresos,
    CONCAT(CAST(
        ingreso_cliente / NULLIF(ingreso_total, 0) * 100.0
        AS DECIMAL(10, 4)
    ), '%') AS Participacion_Porcentaje
FROM ingresos_con_total
ORDER BY ingreso_cliente DESC, codigo;


SELECT cl.codigo AS Cliente, 
ISNULL(ing.Ingresos, 0) AS Ingresos,
CONCAT( FORMAT( ISNULL(ing.Ingresos, 0) * 100.0 / SUM(ISNULL(ing.Ingresos, 0)) OVER (), 'N2' ), '%' ) AS Participacion 
FROM clientes AS cl
LEFT JOIN ( SELECT cliente_id, SUM(importe) AS Ingresos FROM ingresos GROUP BY cliente_id ) AS ing ON cl.id = ing.cliente_id 
ORDER BY Ingresos DESC;



