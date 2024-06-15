-- ####################################
-- ### DIA #5 - Consultas - Funciones #
-- ####################################

use dia3;

## clientes - no han realizado pagos
select distinct cliente.nombre_cliente, cliente.codigo_cliente
from cliente
where cliente.codigo_cliente not in(select pago.codigo_cliente from pago);

## clientes - no han realizado pedidos
select distinct cliente.nombre_cliente, cliente.codigo_cliente
from cliente
where cliente.codigo_cliente not in(select pedido.codigo_cliente from pedido);

## clientes - no han realizado pagos - ni pedidos
select distinct cliente.nombre_cliente, cliente.codigo_cliente
from cliente
where cliente.codigo_cliente not in(select pedido.codigo_cliente from pedido) and cliente.codigo_cliente not in (select pago.codigo_cliente from pago);

##  empleados - sin oficina asociada (no hay)
select empleado.codigo_empleado, empleado.nombre
from empleado
where empleado.codigo_oficina not in (select oficina.codigo_oficina from oficina);

## empleados - sin cliente asociado
select empleado.codigo_empleado, empleado.nombre
from empleado
where empleado.codigo_empleado not in (select cliente.codigo_empleado_rep_ventas from cliente);

## empleados - sin cliente asociado - datos de la oficina donde trabajan
select empleado.codigo_empleado, empleado.nombre, oficina.codigo_oficina, oficina.ciudad, oficina.pais, oficina.telefono
from empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where empleado.codigo_empleado not in (select cliente.codigo_empleado_rep_ventas from cliente);

## empleados - sin oficina asociada - sin cliente asociado (no hay)
select empleado.codigo_empleado, empleado.nombre
from empleado
where empleado.codigo_oficina not in (select oficina.codigo_oficina from oficina) and empleado.codigo_empleado not in (select cliente.codigo_empleado_rep_ventas from cliente);

## productos - nunca han aparecido en un pedido
select producto.codigo_producto, producto.nombre, producto.gama
from producto
where producto.codigo_producto not in (select detalle_pedido.codigo_producto from detalle_pedido);

## productos - nunca han aparecido en un pedido - nombre - descripción - imagen del producto
select producto.codigo_producto, producto.nombre, producto.gama, producto.descripcion, gp.imagen
from producto
inner join gama_producto gp on producto.gama = gp.gama
where producto.codigo_producto not in (select detalle_pedido.codigo_producto from detalle_pedido);

## oficinas - no trabajan empleados_rep_ventas de clientes que han hecho compras de productos de la gama frutales
select oficina.codigo_oficina, oficina.pais, oficina.telefono, producto.gama

from producto
inner join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
inner join pedido on detalle_pedido.codigo_pedido = pedido.codigo_pedido
inner join cliente on pedido.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where producto.gama != 'Frutales';


-- Desarrollado por Andres Daza / T.I. 1095916023