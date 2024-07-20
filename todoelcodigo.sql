create database prueba;
use prueba;

/*1: Crea una función PL/SQL llamada calcular_iva que acepte un precio (sin IVA) como parámetro
y retorne el precio incluyendo el IVA (considera un IVA del 16%). La función debe manejar
valores numéricos con dos decimales.

Requerimientos:
La función debe aceptar y retornar un número con dos decimales.
Asegúrate de que la función maneje adecuadamente los tipos de datos.
 */
 
DELIMITER //

CREATE FUNCTION calcular_iva(precio DECIMAL(10, 2)) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio_con_iva DECIMAL(10, 2);
    -- Calcula el precio con IVA (16%)
    SET precio_con_iva = precio * 1.16;
    RETURN precio_con_iva;
END; //

DELIMITER ;

SELECT calcular_iva(3000.00) as calculo_con_iva;
SELECT calcular_iva(4000.00) as calculo_con_iva;
SELECT calcular_iva(6000.00) as calculo_con_iva;
DROP FUNCTION IF EXISTS calcular_iva;


/*
Ejercicio 2: Procedimientos Almacenados
Descripción:
Escribe un procedimiento almacenado llamado actualizar_salario que aumente el salario de
un empleado por un porcentaje dado. El procedimiento debe recibir el ID del empleado y el
porcentaje de aumento.
Requerimientos:
El procedimiento debe actualizar la tabla de empleados (empleado) que tiene columnas para
id_empl y salario.
Debe mostrar un mensaje indicando si la actualización fue exitosa o si el empleado no existe
(DBMS).  */

/* creamos las tablas */
create table departamento (
id_depart bigint  primary key,
descripcion varchar(255),
id_ubict bigint
);
create table empleado(
id_empl bigint primary key,
nombres varchar(255),
apellidos varchar(255),
id_cargo bigint,
salario bigint,
fecha_contratacion date,
id_jefatura bigint,
id_depart bigint,
foreign key (id_depart) references departamento(id_depart)
);
/* vemos que esten bien las tablas */
select * from empleado;
select * from departamento;

/* GENERAMOS NUESTRO procedimiento almacenado */
DELIMITER $$
CREATE PROCEDURE actualizar_salario (
    IN p_id_empl BIGINT,
    IN p_porcentaje DECIMAL(5, 2)
)
BEGIN
    DECLARE v_salario_actual DECIMAL(15, 2);
    DECLARE v_count INT;

    -- Verificar si el empleado existe
    SELECT COUNT(*) INTO v_count
    FROM empleado
    WHERE id_empl = p_id_empl;

    -- Si el empleado no existe, mostrar mensaje y salir
    IF v_count = 0 THEN
        SELECT CONCAT('El empleado con ID ', p_id_empl, ' no existe.') AS mensaje;
    ELSE
        -- Obtener el salario actual del empleado
        SELECT salario INTO v_salario_actual
        FROM empleado
        WHERE id_empl = p_id_empl;

        -- Actualizar el salario del empleado
        UPDATE empleado
        SET salario = salario + (salario * (p_porcentaje / 100))
        WHERE id_empl = p_id_empl;

        -- Mostrar mensaje de éxito
        SELECT CONCAT('El salario del empleado con ID ', p_id_empl, ' ha sido actualizado exitosamente.') AS mensaje;
    END IF;
END $$
DELIMITER ;

/* llamamos nuestro procedimiento almacenado */
CALL actualizar_salario(2, 90);
select * from empleado;
select * from departamento;

/* creamos un registro para hacer las pruebas */
INSERT INTO empleado (
    id_empl,
    nombres,
    apellidos,
    id_cargo,
    salario,
    fecha_contratacion,
    id_jefatura,
    id_depart
) VALUES (
    4,                    
    'Anna',               
    'White',              
    2,                    
    8000.00,             
    '2021-01-20',         
    2,                
    2                     
);


/* 3.-Escribe una consulta que retorne el nombre del departamento y el número total de empleado en cada departamento que 
	tengan un salario mayor a 3000, usando las tablas departamento y empleado.  
    
EMPLEADO: contiene detalles sobre cada empleado que trabaja en un departamento. Puede
que algunos empleados no estén asignados a ningún departamento.

DEPARTAMENTO: muestra detalles de los departamentos en los que trabajan los empleados.

Requerimientos:

Utiliza JOIN para combinar las tablas.
Agrupa los resultados por departamento.  */

select 
	departamento.descripcion as nombre_departamento,
	count(empleado.id_empl) as total_empleado 
from 
	empleado 
inner join 
	departamento 
on 
	empleado.id_depart = departamento.id_depart 
where 
	empleado.salario > 3000 
group by 
	departamento.descripcion;
    select * from empleado;
    select * from departamento;
    
    
/* 

Ejercicio 4: Optimización de Consultas
Descripción:
Proporciona una versión optimizada de la siguiente consulta que tarda mucho en ejecutarse:
*/
SELECT * FROM empleado WHERE fecha_contratacion BETWEEN '2010-01-01' AND
'2023-12-31' AND id_depart IN (SELECT id_depart FROM departamento WHERE
id_ubict = '1'); /* modifique la consulta un poquito para poder trabajar con los datos que tenemos en la tabla, solo cambie el id_ubict y 
					el orden de las fechas solamente.
Requerimientos:
Explica qué cambios hiciste para optimizar la consulta y por qué
*/    
select * from empleado inner join departamento on empleado.id_depart = departamento.id_depart;


/* respuesta numero 4.*/

SELECT e.* 
FROM empleado e 
JOIN departamento d  
ON e.id_depart = d.id_depart
WHERE e.fecha_contratacion BETWEEN '2010-01-01' AND '2023-12-31'
  AND d.id_ubict = '1';
  
  /* Primero, cambie la seleccion de las columnas en vez de ser un select * from cambiarlo por un select e.* 
		asi solo traemos las columnas de la tabla que nosotros necesitamos.
     
     Segundo, combine la consulta utilizando un JOIN para combinar las tablas de empleado y departamento,
		esto permite leer la consulta de manera mas rapida y ademas es mas facil de leer para nosotros.
        
     Tercero cambie la subconsulta por JOIN, ya que esta buscando con el IN en los registros de la tabla,
		ahora al cambiar esto es mas rapido, por que las tablas ya estan mezcladas.
        
        Todos estos aspectos hacen que mejore la calidad y legibilidad en la consulta
  */