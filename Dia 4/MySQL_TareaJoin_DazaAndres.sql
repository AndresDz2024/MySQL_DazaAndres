-- ####################################
-- ### DIA # 4 - consultas join ###
-- ####################################

use dia3;

## cliente - nombre y apellido de su representante de ventas
select cliente.nombre_cliente, empleado.nombre, empleado.apellido1
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

## clientes - hayan realizado pagos - nombre de sus representantes de ventas
select cliente.nombre_cliente, empleado.nombre
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

## clientes - han hecho pagos - nombre de sus representantes - ciudad de la oficina del representante
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

## clientes - han hecho pagos - nombre de sus representantes - ciudad de la oficina del representante - dirección de las oficinas con clientes en Fuenlabrada
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad, oficina.linea_direccion1, cliente.ciudad
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cliente.ciudad = 'Fuenlabrada';

## clientes - nombre de sus representantes - ciudad de la oficina a la que pertenece el representante
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

## nombre de los empleados junto al nombre de sus jefes
select emp.nombre as NombreEmpleado, jef.nombre as NombreJefe
from empleado emp
left join empleado jef on emp.codigo_jefe = jef.codigo_empleado;

## empleado, nombre jefe, nombre jefe del jefe
select emp.nombre as NombreEmpleado, jef.nombre as NombreJefe, jef2.nombre as NombreJefe2
from empleado emp
left join empleado jef on emp.codigo_jefe = jef.codigo_empleado
left join empleado jef2 on jef.codigo_jefe = jef2.codigo_empleado;

## clientes, pedido no entregado a tiempo
select cliente.nombre_cliente
from cliente
inner join pedido on cliente.codigo_cliente = pedido.codigo_cliente
where date(pedido.fecha_esperada)<date(pedido.fecha_entrega);

## gamas compradas por cada cliente
select distinct cliente.nombre_cliente, producto.gama as GamaComprada
from cliente
inner join pedido on cliente.codigo_cliente = pedido.codigo_cliente
inner join detalle_pedido on pedido.codigo_pedido = detalle_pedido.codigo_pedido
inner join producto on producto.codigo_producto = detalle_pedido.codigo_producto;

-- Desarrollado por Andres Daza / T.I. 1095916023