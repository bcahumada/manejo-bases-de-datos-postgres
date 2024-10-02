--desafio3-definicion-de-tablas-sql--

--1.--Creación de base de datos "pelícuas"
CREATE DATABASE peliculas;

2.1--Creación tablas pelicula y reparto--

CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    anio_estreno INTEGER,
    director VARCHAR(255)
);


CREATE TABLE reparto (
    id SERIAL PRIMARY KEY,
    id_pelicula INTEGER REFERENCES peliculas(id),
    actor VARCHAR(255)
);

/*
-----\d

               Listado de relaciones
 Esquema |      Nombre      |   Tipo    |  Due±o
---------+------------------+-----------+----------
 public  | peliculas        | tabla     | postgres
 public  | peliculas_id_seq | secuencia | postgres
 public  | reparto          | tabla     | postgres
 public  | reparto_id_seq   | secuencia | postgres
(4 filas)

*/

--2.2--Carga de datos desde los csv--

\copy peliculas(id, titulo, anio_estreno, director) FROM 'C:\Users\bhahu\OneDrive\Escritorio\Apoyo Desafio - Top 100\peliculas.csv' DELIMITER ',' CSV HEADER;

\copy reparto(id_pelicula, actor) FROM 'C:\Users\bhahu\OneDrive\Escritorio\Apoyo Desafio - Top 100\reparto.csv' DELIMITER ',' CSV HEADER;





--3.--Consultas y Resultados--

-----1. Obtener el ID de la película "Titanic":

SELECT id FROM peliculas WHERE titulo = 'Titanic';

/*
-----Resultado:
 id
----
  2
(1 fila)

*/



-----2. Listar a todos los actores que aparecen en la película "Titanic":

SELECT r.actor 
FROM reparto r 
JOIN peliculas p ON r.id_pelicula = p.id 
WHERE p.titulo = 'Titanic';

/*
-----Resultado:
       actor
-------------------
 Leonardo DiCaprio
 Kate Winslet
 Billy Zane
 Kathy Bates
 Frances Fisher
 Bernard Hill
 Jonathan Hyde
 Danny Nucci
 David Warner
 Bill Paxton
 Gloria Stuart
 Victor Garber
 Suzy Amis
(13 filas)
*/




-----3. Consultar cuántas películas del top 100 participa Harrison Ford:

SELECT COUNT(DISTINCT p.id)
FROM peliculas p
JOIN reparto r ON p.id = r.id_pelicula
WHERE r.actor = 'Harrison Ford';

/*
-----Resultado:
 count
-------
     8
(1 fila)
*/

-----4. Indicar las películas estrenadas entre los años 1990 y 1999, ordenadas por título:

SELECT titulo 
FROM peliculas 
WHERE anio_estreno BETWEEN 1990 AND 1999 
ORDER BY titulo ASC;

/*
-----Resultado:
                   titulo
--------------------------------------------
 American Beauty
 American History X
 Braveheart
 Cadena perpetua
 Eduardo Manostijeras
 El club de la pelea
 El Padrino. Parte III
 El profesional
 El sexto sentido
 El show de Truman
 El silencio de los corderos
 Entrevista con el vampiro
 Forest Gump
 Hombres de negro
 La lista de Schindler
 La milla verde
 Matrix
 Mejor... imposible
 Parque Jur├ísico
 Pesadilla antes de navidad
 Pulp Fiction
 Salvar al soldado Ryan
 Seven
 Star Wars. Episodio I: La amenaza fantasma
 Terminator 2: el juicio final
 Titanic
 Toy Story
 Toy Story 2
 Trainspotting
 Uno de los nuestros
(30 filas)

*/


-----5. Mostrar los títulos con su longitud (longitud_titulo):

SELECT titulo, LENGTH(titulo) AS longitud_titulo 
FROM peliculas;

/*
-----Resultado:
                        titulo                         | longitud_titulo
-------------------------------------------------------+-----------------
 Forest Gump                                           |              11
 Titanic                                               |               7
 El Padrino                                            |              10
 Gladiator                                             |               9
 El Se├▒or de los anillos: El retorno del rey          |              44
 El caballero oscuro                                   |              19
 Cadena perpetua                                       |              15
 Piratas del Caribe: La maldici├│n de la Perla Negra   |              51
 Braveheart                                            |              10
 La lista de Schindler                                 |              21
 Toy Story                                             |               9
 Eduardo Manostijeras                                  |              20
 El Se├▒or de los anillos: La comunidad del anillo     |              49
 Salvar al soldado Ryan                                |              22
 Regreso al futuro                                     |              17
 Monstruos S.A.                                        |              14
 Buscando a Nemo                                       |              15
 El Se├▒or de los anillos: Las dos torres              |              40
 Harry Potter y el Prisionero de Azkaban               |              39
 American History X                                    |              18
 300                                                   |               3
 El sexto sentido                                      |              16
 Pulp Fiction                                          |              12
 V de Vendetta                                         |              13
 El silencio de los corderos                           |              27
 Rocky                                                 |               5
 El club de la pelea                                   |              19
 E.T                                                   |               3
 Parque Jur├ísico                                      |              16
 Matrix                                                |               6
 La milla verde                                        |              14
 Ratatouille                                           |              11
 Grease                                                |               6
 El Padrino. Parte II                                  |              20
 Wall-E                                                |               6
 Iron Man                                              |               8
 El exorcista                                          |              12
 Piratas del Caribe: El cofre del hombre muerto        |              46
 Seven                                                 |               5
 Terminator 2: el juicio final                         |              29
 El resplandor                                         |              13
-- Más  --


*/

---6. Consultar la longitud más grande entre todos los títulos de las películas:

SELECT MAX(LENGTH(titulo)) AS longitud_maxima 
FROM peliculas;

/*
-----Resultado:
 longitud_maxima
-----------------
              53
(1 fila)


*/

-------Fin del Reporte-------