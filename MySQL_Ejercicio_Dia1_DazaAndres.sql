-- #####################
-- ### EJERCICIO # 1 ###
-- #####################

-- Creaciòn de la base de datos "tienda"
CREATE DATABASE tienda;

-- Usar base de datos "tienda"
uSE tienda;

-- Crear tabla fabricante
create table fabricante(
id int auto_increment primary key,
nombre varchar(100)
);

-- Mostrar tablas
show tables;

-- Crear tabla "producto"
create table producto(
id int auto_increment primary key,
nombre varchar(100),
precio decimal(10,2),
id_fabricante int,
foreign key (id_fabricante) references fabricante(id)
);

-- Insertar informacion a fabricante

insert into fabricante value(1, 'Infinix');
insert into fabricante value(2, 'Samsung');
insert into fabricante value(3, 'Apple');
insert into fabricante value(4, 'Xiaomi');
insert into fabricante value(5, 'Oppo');
insert into fabricante value(6, 'Motorola');
insert into fabricante value(7, 'Tecno');
insert into fabricante value(8, 'ZTE');
insert into fabricante value(9, 'VIVO');

-- Insertar productos en la tabla 

insert into producto value(1, 'Note 40 Pro Plus', 1100000.00, 1);
insert into producto value(2, 'Note 30 Pro', 758000.00, 1);
insert into producto value(3, 'Galaxy A54', 1200000.00, 2);
insert into producto value(4, '11 Pro Max', 2500000.00, 3);
insert into producto value(5, 'Redmi 13C', 650000.00, 4);
insert into producto value(6, 'Reno 7', 850000.00, 5);
insert into producto value(7, 'Moto G13', 540000.00, 6);
insert into producto value(8, 'Spark 10C', 320000.00, 7);
insert into producto value(9, 'ZTE no se', 325000.00, 8);
insert into producto value(10, 'Y9 Vivo', 465000.00, 9);

-- Revisar todos los datos creados por la tabla
select * from fabricante;

-- Revisar todos los datos creados de x tabla con un dato espesifico
select * from fabricante where id=2;

-- Revisar x columna de los datos creados de y tabla
select nombre from producto;

-- Revisar x y y columna de los datos creado de z tabla
select id, nombre from producto;

-- Actualizar dato de x columna 
update producto set nombre='Campusland' where id=10;

select * from producto;

-- Actualizar todas las filas a un nuevo nombre
update producto set nombre='Campuslands';

-- Eliminar un dato 
delete from producto where id=10;
select * from producto;

-- Eliminar todos los datos de una tabla
delete from producto;
 
 
 -- Desarrollado por Andres Daza / T.I. 1095916023


