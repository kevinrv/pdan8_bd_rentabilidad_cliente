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