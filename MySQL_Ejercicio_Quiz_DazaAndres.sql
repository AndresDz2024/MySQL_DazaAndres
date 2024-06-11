-- #########################
-- ###### EJERCICIO 2 ######
-- #########################

create database Oracle;

use Oracle;

create table equipo(
id int auto_increment primary key,
nombre varchar(25),
N_jugadores int(2),
Descuento decimal(3,2)
);

create table representante(
id int auto_increment primary key,
nombre varchar(25),
Email varchar(30),
Direccion varchar(30),
Telefono int(15),
comision decimal(2,2)
);

create table cliente(
id int auto_increment primary key,
nombre varchar(25),
Email varchar(30),
Direccion varchar(30),
Telefono int(15),
saldo int(30),
id_equipo int,
foreign key (id_equipo) references equipo(id),
id_representante int,
foreign key (id_representante) references representante(id)
);

create table pedido(
id int auto_increment primary key,
fecha date,
cant_unidades int(3),
total decimal(10,2),
id_cliente int,
foreign key (id_cliente) references cliente(id)
);

create table articulo(
id int auto_increment primary key,
descripcion varchar(100),
precio int(10),
nombre varchar(25),
categoria varchar(20),
color varchar(10),
tamaño decimal(2,2),
id_inventario int,
foreign key (id_inventario) references inventario(id)
);

create table inventario(
id int auto_increment primary key,
cant_unidades int(7)
);

show tables;

