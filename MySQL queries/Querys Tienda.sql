SELECT nombre FROM producto;
SELECT nombre,precio FROM producto;
SELECT * FROM producto;
SELECT nombre,precio,precio* 0.8 precio_usd  From producto;
SELECT nombre AS nombre_producto,precio AS euros,precio * 0.8 AS dolares FROM producto;
SELECT upper(nombre),precio FROM producto;
SELECT lower(nombre),precio FROM producto;
SELECT nombre,concat(upper(LEFT(nombre,2)),lower(substring(nombre,2))) FROM fabricante;
SELECT nombre,round(precio) FROM producto;
SELECT nombre,truncate(precio,0) FROM producto;
SELECT codigo_fabricante FROM producto p,fabricante f WHERE p.codigo_fabricante = f.codigo;
SELECT DISTINCT codigo_fabricante FROM producto p,fabricante f WHERE p.codigo_fabricante = f.codigo;
SELECT nombre  FROM fabricante ORDER BY nombre  ASC;
SELECT nombre  FROM fabricante ORDER BY nombre  DESC;
SELECT nombre,precio FROM producto ORDER BY nombre ASC,precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 3,2;
SELECT nombre,precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT p.nombre,precio,f.nombre FROM producto p,fabricante f ;
SELECT p.nombre,precio,f.nombre FROM producto p,fabricante f ORDER BY f.nombre ASC;
SELECT p.codigo,p.nombre,f.codigo,f.nombre FROM producto p ,fabricante f;
SELECT p.nombre, precio,f.nombre FROM producto p, fabricante f ORDER BY precio ASC LIMIT 1;
SELECT p.nombre, precio,f.nombre FROM producto p, fabricante f ORDER BY precio DESC LIMIT 1;
SELECT * FROM producto WHERE codigo_fabricante = 2;
SELECT * FROM producto WHERE codigo_fabricante = 6 AND precio > 200;
SELECT nombre FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante =3 OR codigo_fabricante =5;
SELECT nombre FROM producto WHERE codigo_fabricante  IN (1,3,5);
SELECT p.nombre,p.precio FROM producto p INNER JOIN fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE '%e';
SELECT p.nombre,precio FROM producto p INNER JOIN  fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE '%w%';
SELECT p.nombre,precio,f.nombre FROM producto p INNER JOIN  fabricante f WHERE p.codigo_fabricante = f.codigo AND precio >= 180 ORDER BY precio DESC,p.nombre ASC ;
SELECT DISTINCT f.codigo,f.nombre FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.codigo,f.nombre,p.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT * FROM fabricante where codigo NOT IN ( SELECT codigo_fabricante FROM producto);
SELECT f.nombre as fabricante,p.nombre,p.precio FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre ='lenovo';
SELECT * from producto WHERE precio = (SELECT max(precio) FROM producto WHERE codigo_fabricante = 2);
SELECT nombre FROM producto WHERE precio = (SELECT max(precio) FROM producto WHERE codigo_fabricante = 2);
SELECT nombre FROM producto WHERE precio = (SELECT min(precio) FROM producto WHERE codigo_fabricante = 3);
SELECT *  from producto WHERE PRECIO >= (SELECT max(precio) FROM producto WHERE codigo_fabricante = 2);
SELECT * FROM producto WHERE precio > (SELECT avg(precio) FROM producto WHERE codigo_fabricante = 1)




