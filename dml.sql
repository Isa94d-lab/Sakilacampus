--CONSULTAS

USE sakilacampus;

--1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.

SELECT cliente.nombre, COUNT(alquiler.id_alquiler) AS total_alquileres
FROM cliente
INNER JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
WHERE alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY cliente.id_cliente, cliente.nombre
ORDER BY total_alquileres DESC
LIMIT 1;

--2. Lista las cinco películas más alquiladas durante el último año.

SELECT pelicula.titulo, COUNT(alquiler.id_alquiler) AS total_alquileres
FROM alquiler
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula ON inventario.id_pelicula = pelicula.id_pelicula
WHERE alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY pelicula.id_pelicula, pelicula.titulo
ORDER BY total_alquileres DESC
LIMIT 5;


--3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película.

SELECT categoria.nombre AS nombre_categoria, 
       COUNT(alquiler.id_alquiler) AS cantidad_alquileres,
       SUM(pago.total) AS total_ingresos
FROM alquiler
JOIN pago ON alquiler.id_alquiler = pago.id_alquiler
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula_categoria ON inventario.id_pelicula = pelicula_categoria.id_pelicula
JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
GROUP BY categoria.id_categoria, categoria.nombre
ORDER BY total_ingresos DESC;


--4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico.

SELECT idioma.nombre AS nombre_idioma, COUNT(DISTINCT alquiler.id_cliente) AS cantidad_clientes
FROM alquiler
JOIN cliente ON alquiler.id_cliente = cliente.id_cliente
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula ON inventario.id_pelicula = pelicula.id_pelicula
JOIN idioma ON pelicula.id_idioma = idioma.id_idioma
--En esta parte el numero despues de "MONTH(alquiler.fecha_alquiler) = X" Ese numero hace referencia al numero del mes al que se le esta haciendo la consulta
WHERE MONTH(alquiler.fecha_alquiler) = 3 
AND YEAR(alquiler.fecha_alquiler) = YEAR(CURDATE())
GROUP BY idioma.id_idioma, idioma.nombre
ORDER BY cantidad_clientes DESC;



--5. Encuentra a los clientes que han alquilado todas las películas de una misma categoría.

SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos, categoria.nombre AS nombre_categoria
FROM cliente
JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula_categoria ON inventario.id_pelicula = pelicula_categoria.id_pelicula
JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
GROUP BY cliente.id_cliente, cliente.nombre, cliente.apellidos, categoria.id_categoria, categoria.nombre
HAVING COUNT(DISTINCT pelicula_categoria.id_pelicula) = 
       (SELECT COUNT(*) FROM pelicula_categoria WHERE pelicula_categoria.id_categoria = categoria.id_categoria);


--6. Lista las tres ciudades con más clientes activos en el último trimestre.

SELECT ciudad.nombre AS nombre_ciudad, COUNT(cliente.id_cliente) AS cantidad_clientes_activos
FROM cliente
JOIN direccion ON cliente.id_direccion = direccion.id_direccion
JOIN ciudad ON direccion.id_ciudad = ciudad.id_ciudad
WHERE cliente.activo = 1 
AND cliente.fecha_creacion >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY ciudad.id_ciudad, ciudad.nombre
ORDER BY cantidad_clientes_activos DESC
LIMIT 3;


--7. Muestra las cinco categorías con menos alquileres registrados en el último año.

SELECT categoria.nombre AS nombre_categoria, COUNT(alquiler.id_alquiler) AS cantidad_alquileres
FROM alquiler
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula_categoria ON inventario.id_pelicula = pelicula_categoria.id_pelicula
JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
WHERE alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY categoria.id_categoria, categoria.nombre
ORDER BY cantidad_alquileres ASC
LIMIT 5;



--8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas.

SELECT AVG(DATEDIFF(alquiler.fecha_devolucion, alquiler.fecha_alquiler)) AS promedio_dias_devolucion
FROM alquiler
WHERE alquiler.fecha_devolucion IS NOT NULL;


--9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.


SELECT empleado.id_empleado, empleado.nombre, empleado.apellidos, COUNT(alquiler.id_alquiler) AS cantidad_alquileres
FROM alquiler
JOIN empleado ON alquiler.id_empleado = empleado.id_empleado
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula_categoria ON inventario.id_pelicula = pelicula_categoria.id_pelicula
JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
WHERE categoria.nombre = 'Acción'
GROUP BY empleado.id_empleado, empleado.nombre, empleado.apellidos
ORDER BY cantidad_alquileres DESC
LIMIT 5;



--10. Genera un informe de los clientes con alquileres más recurrentes.


SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos, COUNT(alquiler.id_alquiler) AS cantidad_alquileres
FROM cliente
JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
GROUP BY cliente.id_cliente, cliente.nombre, cliente.apellidos
ORDER BY cantidad_alquileres DESC;



--11. Calcula el costo promedio de alquiler por idioma de las películas.

SELECT idioma.nombre AS nombre_idioma, AVG(pelicula.rental_rate) AS costo_promedio_alquiler
FROM pelicula
JOIN idioma ON pelicula.id_idioma = idioma.id_idioma
GROUP BY idioma.id_idioma, idioma.nombre;


--12. Lista las cinco películas con mayor duración alquiladas en el último año.
--13. Muestra los clientes que más alquilaron películas de Comedia.

SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos, COUNT(alquiler.id_alquiler) AS cantidad_alquileres
FROM cliente
JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN pelicula_categoria ON inventario.id_pelicula = pelicula_categoria.id_pelicula
JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
WHERE categoria.nombre = 'Comedia'
GROUP BY cliente.id_cliente, cliente.nombre, cliente.apellidos
ORDER BY cantidad_alquileres DESC
LIMIT 5;


--14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes.

SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos, 
       SUM(DATEDIFF(alquiler.fecha_devolucion, alquiler.fecha_alquiler)) AS total_dias_alquilados
FROM cliente
JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
WHERE alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
AND alquiler.fecha_devolucion IS NOT NULL
GROUP BY cliente.id_cliente, cliente.nombre, cliente.apellidos
ORDER BY total_dias_alquilados DESC;


--15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre.

SELECT almacen.id_almacen, almacen.id_direccion, DATE(alquiler.fecha_alquiler) AS fecha, 
       COUNT(alquiler.id_alquiler) AS cantidad_alquileres
FROM alquiler
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN almacen ON inventario.id_almacen = almacen.id_almacen
WHERE alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY almacen.id_almacen, almacen.id_direccion, fecha
ORDER BY fecha DESC;


--16. Calcula los ingresos totales generados por cada almacén en el último semestre.

SELECT almacen.id_almacen, almacen.id_direccion, SUM(pago.total) AS ingresos_totales
FROM pago
JOIN alquiler ON pago.id_alquiler = alquiler.id_alquiler
JOIN inventario ON alquiler.id_inventario = inventario.id_inventario
JOIN almacen ON inventario.id_almacen = almacen.id_almacen
WHERE pago.fecha_pago >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY almacen.id_almacen, almacen.id_direccion
ORDER BY ingresos_totales DESC;


--17. Encuentra el cliente que ha realizado el alquiler más caro en el último año.

SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos, pago.total AS monto_alquiler
FROM pago
JOIN alquiler ON pago.id_alquiler = alquiler.id_alquiler
JOIN cliente ON alquiler.id_cliente = cliente.id_cliente
WHERE pago.fecha_pago >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY pago.total DESC
LIMIT 1;


--18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses.
--19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes.
--20. Lista los clientes que no han realizado ningún alquiler en el último año

SELECT cliente.id_cliente, cliente.nombre, cliente.apellidos
FROM cliente
LEFT JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente
AND alquiler.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
WHERE alquiler.id_alquiler IS NULL;
