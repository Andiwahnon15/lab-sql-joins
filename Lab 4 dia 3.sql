-- 1. Enumere el número de películas por categoría.
SELECT name AS category, COUNT(film_category.film_id) AS films_per_cate
FROM sakila.category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY name;
-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.
SELECT s.store_id, c.city_id, co.country_id
FROM sakila.store as s 
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON c.country_id = co.country_id;
-- 3. Calcula los ingresos totales generados por cada tienda en dólares.
SELECT s.store_id, SUM(p.amount) AS total_ing
FROM sakila.store as s 
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id; 
-- 4. Determine el tiempo promedio de duración de las películas para cada categoría.
SELECT c.name AS category, AVG(f.length) AS avg_duration
FROM sakila.film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;
-- 5. Identifique las categorías de películas con el tiempo promedio de duración más largo.
SELECT c.name AS category, AVG(f.length) AS avg_duration
FROM sakila.film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC -- Agrupar resultados por nombre de categoria, AVG calcular el tiempo promedio de duración de las peliculas
LIMIT 1;
-- 6. Muestra las 10 películas más alquiladas en orden descendente.
SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM sakila.film AS f
JOIN inventory AS i ON f.film_id =i.film_id
JOIN rental AS r On i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
-- 7. Determina si "Dinosaurio de la Academia" se puede alquilar en la Tienda 1.
SELECT f.title as movie_title, s.store_id, COUNT(*) AS available_copies
FROM sakila.film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s On i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, store_id;
-- 8. Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. 
-- Incluya una columna que indique si cada título está "Disponible" o "NO disponible". Tenga en cuenta que hay 42 títulos que no 
-- están en el inventario, y esta información se puede obtener utilizando una declaración combinada con ".CASEIFNULL.

