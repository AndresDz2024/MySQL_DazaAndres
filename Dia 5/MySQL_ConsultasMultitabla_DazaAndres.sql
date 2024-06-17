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

## clientes que han realizado algun pedido pero ningun pago
select cliente.nombre_cliente
from pedido
inner join cliente on pedido.codigo_cliente = cliente.codigo_cliente
where cliente.codigo_cliente not in(select pago.codigo_cliente from pago);

## empleados que no tienen clientes asocicados y el nombre de su jefe asociado
select emp.nombre as NombreEmpleado, jef.nombre as NombreJefe
from empleado emp
inner join empleado jef on emp.codigo_jefe = jef.codigo_empleado
where emp.codigo_empleado not in (select cliente.codigo_empleado_rep_ventas from cliente);

## cuantos empleados hay en la empresa
select count(*)
from empleado;

## cuantos clientes tiene cada país
select pais, count(*) as numero_clientes
from cliente
group by pais;

## pago medio año 2009
select avg(total)
from pago
where year(fecha_pago) = 2009;

## cuantos pedidos hay en cada estado - resultado de forma descendente por el numero de pedidos
select estado, count(*) as numero_pedidos
from pedido
group by estado
order by numero_pedidos Desc;

## precio de venta del producto mas caro y mas barato en una consulta
select max(precio_venta) , min(precio_venta)
from producto;

## numero de clientes en la empresa
select count(*)
from cliente;

## clientes - domicilio en madrid
select count(*)
from cliente
where ciudad = 'Madrid';

## clientes - cada una de las ciudades que empiezan por m
select ciudad, count(*) as numero_clientes
from cliente
where ciudad like 'M%'
group by ciudad;

## nombre de representantes de ventas y numero de clientes que atiende cada uno
select empleado.nombre, count(*) as numero_clientes
from empleado
left join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
group by empleado.nombre;

## numero de clientes que no tiene representante de ventas
select count(*)
from cliente
where codigo_empleado_rep_ventas = null;

## fecha primer y ultimo pago realizado por cada uno de los clientes - mostrar nombre y apellidos de cada cliente (los clientes no tienen registrado apellido)
select cliente.nombre_cliente, min(pago.fecha_pago) as primer_pago, max(pago.fecha_pago) as ultimo_pago
from cliente
inner join pago on cliente.codigo_cliente = pago.codigo_cliente
group by cliente.nombre_cliente;

## numero de productos diferentes en cada uno de los pedidos
select detalle_pedido.codigo_pedido, count(distinct detalle_pedido.codigo_producto) as productos_diferentes
from detalle_pedido
group by detalle_pedido.codigo_pedido;

## suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos
select codigo_pedido, sum(cantidad) as cantidad_total
from detalle_pedido
group by codigo_pedido;

## Devuelve un listado de los 20 productos más vendidos - el número total de unidades que se han vendido de cada uno - El listado deberá estar ordenado por el número total de unidades vendidas
select detalle_pedido.codigo_producto, producto.nombre as nombre_producto, sum(detalle_pedido.cantidad) as total_unidades_vendidas
from detalle_pedido
inner join producto on detalle_pedido.codigo_producto = producto.codigo_producto
group by detalle_pedido.codigo_producto, producto.nombre
ORDER BY total_unidades_vendidas desc limit 20;

## La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
select sum(dp.cantidad * p.precio_venta) as base_imponible, sum(dp.cantidad * p.precio_venta) * 0.21 as iva, sum(dp.cantidad * p.precio_venta) * 1.21 as total_facturado
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto;

## la misma informacion anterior pero agrupada por codigo_producto
select dp.codigo_producto, sum(dp.cantidad * p.precio_venta) as base_imponible, sum(dp.cantidad * p.precio_venta) * 0.21 as iva, sum(dp.cantidad * p.precio_venta) * 1.21 as total_facturado
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto
group by dp.codigo_producto;

## La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
select dp.codigo_producto, sum(dp.cantidad * p.precio_venta) as base_imponible, sum(dp.cantidad * p.precio_venta) * 0.21 as iva, sum(dp.cantidad * p.precio_venta) * 1.21 as total_facturado
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto
where dp.codigo_producto like 'OR%'
group by dp.codigo_producto;

## Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
select p.nombre as nombre_producto, sum(dp.cantidad) as unidades_vendidas, sum(dp.cantidad * p.precio_venta) as total_facturado, sum(dp.cantidad * p.precio_venta) * 1.21 as total_facturado_con_iva
from detalle_pedido dp
join producto p on dp.codigo_producto = p.codigo_producto
group by p.codigo_producto, p.nombre
having total_facturado > 3000;

## suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla de pagos
select year(fecha_pago) as año, sum(total) as suma_total
from pago
group by year(fecha_pago)
order by año;

## devuelve el nombre del cliente con mayor límite de crédito
select nombre_cliente
from cliente
where limite_credito = (select max(limite_credito) from cliente);

## devuelve el nombre del producto que tenga el precio de venta mas caro
select nombre
from producto
where precio_venta = (select max(precio_venta) from producto);

## nombre del producto del que se hayan vendido mas unidades
select producto.nombre as nombre_producto, sum(detalle_pedido.cantidad) as total_u_vendidas 
from detalle_pedido
inner join producto on detalle_pedido.codigo_producto = producto.codigo_producto
group by producto.nombre
order by total_u_vendidas desc limit 1;

## clientes cuyo limite de credito sea mayor que los pagos que hayan realizado
select cliente.nombre_cliente
from cliente
where cliente.limite_credito > (select sum(pago.total) from pago where pago.codigo_cliente = cliente.codigo_cliente);

## producto que tiene mas unidades en stock (hay varios con la misma cantidad)
select producto.nombre, cantidad_en_stock
from producto
where cantidad_en_stock = (select max(cantidad_en_stock) from producto) ;

## producto que tiene menos unidades en stock
select producto.nombre, cantidad_en_stock
from producto
where cantidad_en_stock = (select min(cantidad_en_stock) from producto) ;

## nombre - apellidos - email - empleados encargados de Alberto Soria
select empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.email, codigo_jefe
from empleado
where codigo_empleado in (select codigo_empleado from empleado where codigo_jefe = 3);

## Devuelve el nombre del cliente con mayor límite de crédito
select nombre_cliente
from cliente
where limite_credito = any (select max(limite_credito) from cliente);

## Devuelve el nombre del producto que tenga el precio de venta más caro
select nombre
from producto
where precio_venta >= all (select precio_venta from producto);

## Devuelve el producto que menos unidades tiene en stock
select nombre
from producto
where cantidad_en_stock <= all (select cantidad_en_stock from producto);

## empleados que no representan a ningún cliente
select e.nombre, e.apellido1, e.puesto
from empleado e
where e.codigo_empleado not in (
    select c.codigo_empleado_rep_ventas
    from cliente c
);

## Clientes que no han realizado ningún pago
select c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, c.telefono
from cliente c
where c.codigo_cliente not in (
    select p.codigo_cliente
    from pago p
);

## Clientes que han realizado algún pago
select c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, c.telefono
from cliente c
where c.codigo_cliente in (
    select p.codigo_cliente
    from pago p
);

## Productos que nunca han aparecido en un pedido
select p.codigo_producto, p.nombre
from producto p
where p.codigo_producto not in (
    select dp.codigo_producto
    from detalle_pedido dp
);

-- 5. Empleados que no son representantes de ventas de ningún cliente
select e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono
from empleado e
join oficina o on e.codigo_oficina = o.codigo_oficina
where e.codigo_empleado not in (
    select c.codigo_empleado_rep_ventas
    from cliente c
);

## Oficinas donde no trabajan empleados que han sido representantes de ventas de algún cliente que haya comprado productos de la gama "frutales"
select o.*
from oficina o
where o.codigo_oficina not in (
    select distinct e.codigo_oficina
    from empleado e
    where e.codigo_empleado in (
        select distinct c.codigo_empleado_rep_ventas
        from cliente c
        where c.codigo_cliente in (
            select p.codigo_cliente
            from pedido p
            join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido
            join producto pr on dp.codigo_producto = pr.codigo_producto
            where pr.gama = 'frutales'
        )
    )
);

## Clientes que han realizado algún pedido pero no han realizado ningún pago
select c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, c.telefono
from cliente c
where c.codigo_cliente in (
    select p.codigo_cliente
    from pedido p
)
and c.codigo_cliente not in (
    select pa.codigo_cliente
    from pago pa
);

## Clientes que no han realizado ningún pago (usando exists)
select c.nombre_cliente
from cliente c
where not exists (
    select 1
    from pago p
    where p.codigo_cliente = c.codigo_cliente
)
order by c.nombre_cliente;

## Clientes que han realizado algún pago (usando exists)
select c.nombre_cliente
from cliente c
where exists (
    select 1
    from pago p
    where p.codigo_cliente = c.codigo_cliente
)
order by c.nombre_cliente;

## Productos que nunca han aparecido en un pedido (usando exists)
select p.nombre
from producto p
where not exists (
    select 1
    from detalle_pedido dp
    where dp.codigo_producto = p.codigo_producto
)
order by p.nombre;

## Productos que han aparecido en un pedido alguna vez
select p.codigo_producto, p.nombre
from producto p
where exists (
    select 1
    from detalle_pedido dp
    where dp.codigo_producto = p.codigo_producto
);

## Clientes y el número de pedidos realizados
select c.nombre_cliente, count(p.codigo_pedido) as num_pedidos
from cliente c
left join pedido p on c.codigo_cliente = p.codigo_cliente
group by c.nombre_cliente;

## Clientes y el total pagado
select c.nombre_cliente, coalesce(sum(p.total), 0) as total_pagado
from cliente c
left join pago p on c.codigo_cliente = p.codigo_cliente
group by c.nombre_cliente;

## Clientes que han hecho pedidos en 2008 ordenados alfabéticamente
select distinct c.nombre_cliente
from cliente c
join pedido p on c.codigo_cliente = p.codigo_cliente
where year(p.fecha_pedido) = 2008
order by c.nombre_cliente asc;

## Clientes, sus representantes y teléfonos de oficina para aquellos que no han realizado ningún pago
select c.nombre_cliente, e.nombre as nombre_representante, e.apellido1 as apellido_representante, o.telefono as telefono_oficina
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o on e.codigo_oficina = o.codigo_oficina
left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null
group by c.codigo_cliente;

## Clientes, sus representantes y la ciudad de la oficina
select c.nombre_cliente, e.nombre as nombre_representante, e.apellido1 as apellido_representante, o.ciudad
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o on e.codigo_oficina = o.codigo_oficina
order by c.nombre_cliente;

## Empleados que no son representantes de ventas de ningún cliente
select e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono
from empleado e
join oficina o on e.codigo_oficina = o.codigo_oficina
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.codigo_empleado_rep_ventas is null
order by e.nombre;

## Ciudades con oficinas y el número de empleados en cada una
select o.ciudad, count(e.codigo_empleado) as num_empleados
from oficina o
join empleado e on o.codigo_oficina = e.codigo_oficina
group by o.ciudad
order by o.ciudad;

-- Desarrollado por Andres Daza / T.I. 1095916023