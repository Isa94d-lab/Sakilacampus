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


--1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.

--2. Lista las cinco películas más alquiladas durante el último año.

--3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película.

--4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico.

--5. Encuentra a los clientes que han alquilado todas las películas de una misma categoría.
--6. Lista las tres ciudades con más clientes activos en el último trimestre.

--7. Muestra las cinco categorías con menos alquileres registrados en el último año.
--8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas.
--9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.

--10. Genera un informe de los clientes con alquileres más recurrentes.
--11. Calcula el costo promedio de alquiler por idioma de las películas.
--12. Lista las cinco películas con mayor duración alquiladas en el último año.
--13. Muestra los clientes que más alquilaron películas de Comedia.
--14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes.
--15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre.
--16. Calcula los ingresos totales generados por cada almacén en el último semestre.
--17. Encuentra el cliente que ha realizado el alquiler más caro en el último año.
--18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses.
--19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes.
--20. Lista los clientes que no han realizado ningún alquiler en el último año