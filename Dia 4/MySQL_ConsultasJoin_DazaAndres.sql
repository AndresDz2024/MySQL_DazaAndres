## consultas Join

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
select cliente.nombre, empleado.nombre, oficina.ciudad
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

## clientes - han hecho pagos - nombre de sus representantes - ciudad de la oficina del representante - dirección de las oficinas con clientes en Fuenlabrada
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad, oficina.linea_direccion1
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cliente.ciudad = 'Fuenlabrada' or cliente.region = 'Fuenlabrada';

## clientes - nombre de sus representantes - ciudad de la oficina a la que pertenece el representante
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina;

## nombre de los empleados junto al nombre de sus jefes
