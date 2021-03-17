SELECT apellido1,apellido2,nombre FROM persona WHERE tipo = 'alumno' order by apellido1,apellido2,nombre ASC;
SELECT nombre,apellido1,apellido2 FROM persona WHERE telefono IS NULL AND tipo = 'alumno';
SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';
SELECT * FROM persona WHERE telefono IS NULL AND tipo = 'profesor' AND nif  LIKE '%k';
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT  p.apellido1,p.apellido2,p.nombre,d.nombre FROM persona p jOIN profesor pr  ON  P.id = pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento ORDER BY p.apellido1,p.apellido2,p.nombre ASC;
SELECT a.nombre,c.anyo_inicio,c.anyo_fin FROM alumno_se_matricula_asignatura al JOIN curso_escolar c ON al.id_curso_escolar = c.id JOIN asignatura a ON  a.id = al.id_asignatura JOIN persona p ON al.id_alumno = p.id AND nif = '26902806M';
SELECT DISTINCT  d.nombre FROM departamento d JOIN profesor pr ON d.id = pr.id_departamento JOIN asignatura a on pr.id_profesor = a.id_profesor JOIN grado g ON g.id = a.id_grado WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
SELECT  DISTINCT p.nombre,p.apellido1,p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura al on p.id = al.id_alumno JOIN curso_escolar c ON al.id_curso_escolar = c.id WHERE anyo_inicio = 2018 AND anyo_fin = 2019;

/* Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.*/

SELECT d.nombre,p.apellido1,p.apellido2,p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento ORDER BY d.nombre,p.apellido1,p.apellido2,p.nombre DESC;
SELECT p.nombre,p.apellido1,p.apellido2 FROM persona p RIGHT JOIN profesor pr ON p.id = pr.id_profesor AND pr.id_departamento IS NULL;
SELECT DISTINCT nombre FROM profesor LEFT JOIN departamento ON id NOT IN (SELECT id_departamento FROM profesor);
SELECT DISTINCT pr.id_profesor,p.nombre,p.apellido1,p.apellido2 FROM persona p RIGHT JOIN profesor pr  on p.id = pr.id_profesor and pr.id_profesor not in (select a.id_profesor from asignatura a where pr.id_profesor = a.id_profesor) ;
SELECT  a.id, a.nombre FROM asignatura a  RIGHT JOIN profesor pr ON a.id_profesor IS NULL ;
SELECT DISTINCT d.id,d.nombre FROM departamento d RIGHT JOIN profesor pr ON d.id = pr.id_departamento AND pr.id_profesor NOT IN (SELECT  DISTINCT id_profesor FROM asignatura a where a.id_profesor = pr.id_profesor);


/* Consultes resum: */

SELECT COUNT(*) AS Nº_Alumnos FROM persona WHERE tipo = 'alumno';
SELECT COUNT(*) AS Alumno_nacidos_en_1999 FROM persona WHERE YEAR(fecha_nacimiento) = 1999;
SELECT nombre AS Departamento, COUNT(id_departamento) AS Nº_profesores FROM profesor JOIN departamento ON id = id_departamento GROUP BY id ORDER BY  Nº_profesores DESC;
SELECT nombre AS Departamento, COUNT(id_departamento) AS Nº_profesores FROM profesor  RIGHT JOIN departamento ON id = id_departamento GROUP BY id;
SELECT g.nombre AS Nombre_Grado, COUNT(a.id_grado) AS Nº_Asignaturas FROM asignatura a RIGHT JOIN grado g ON a.id_grado = g.id GROUP BY g.id ORDER BY Nº_asignaturas DESC;
SELECT g.nombre AS Nombre_Grado, COUNT(a.id_grado) AS Nº_Asignaturas FROM asignatura a  JOIN grado g ON a.id_grado = g.id GROUP BY g.id HAVING Nº_asignaturas > 40 ;
SELECT g.nombre AS Grado,a.tipo, SUM(a.creditos) AS Total_Creditos FROM grado g  JOIN asignatura a ON a.id_grado = g.id GROUP BY a.tipo,g.nombre;
SELECT anyo_inicio, COUNT(id_alumno) AS NºAlumnos FROM curso_escolar JOIN alumno_se_matricula_asignatura ON id_curso_escolar = id GROUP BY anyo_inicio;
SELECT p.id,p.nombre,p.apellido1,p.apellido2,COUNT(a.id_profesor)AS NºAsignaturas FROM  asignatura a  right JOIN profesor pr ON  pr.id_profesor = a.id_profesor join persona p on p.id = pr.id_profesor  GROUP BY pr.id_profesor ORDER BY NºAsignaturas DESC;
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona) AND tipo = 'alumno';
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona) AND tipo = 'alumno';
SELECT pr.id_profesor,p.nombre,p.apellido1,p.apellido2 FROM profesor pr JOIN persona p ON p.id=pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento where  NOT exists (select a.id_profesor from asignatura a where _profesor

SELECT pr.id_profesor,p.nombre,p.apellido1,p.apellido2 FROM profesor pr JOIN persona p ON p.id=pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento where  NOT exists (select a.id_profesor from asignatura a where a.id_profesor=pr.id_profesor);
