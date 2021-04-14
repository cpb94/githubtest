$PBExportHeader$w_consulta_cajas_disponibles.srw
forward
global type w_consulta_cajas_disponibles from window
end type
type dw_1 from datawindow within w_consulta_cajas_disponibles
end type
end forward

global type w_consulta_cajas_disponibles from window
integer x = 1056
integer y = 484
integer width = 3483
integer height = 1504
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 79741120
dw_1 dw_1
end type
global w_consulta_cajas_disponibles w_consulta_cajas_disponibles

on w_consulta_cajas_disponibles.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_consulta_cajas_disponibles.destroy
destroy(this.dw_1)
end on

event open;datawindow DW
string v_articulo, v_uso
long i, k
string encajados[]
string sel, art_encajados = '' , lista_cajas = ''
datastore ds_datos, ds_datos2
string cod_caja, des_caja
dec stock, cantidad

Dw_1.SetTransObject(SQLCA)
DW = Message.PowerObjectParm

v_Articulo = DW.object.cod_articulo[dw.Getrow()]
v_uso = DW.object.articulos_uso[dw.Getrow()]

if v_uso = '3' then
	encajados[1] = v_articulo
end if

f_busca_encajados (v_articulo,  encajados)

for i = 1 to upperbound (encajados)
	if art_encajados = '' then
		art_encajados = " '"+encajados[i]+"' "
	else
		art_encajados = art_encajados +", '"+ encajados[i]+"' "
	end if
next


sel = " select distinct almartcajas.caja, almcajas.codigo_compras "+&
		" from almartcajas "+&
		" inner join almcajas on almartcajas.empresa = almcajas.empresa and almartcajas.caja = almcajas.codigo "+&
		" inner join articulos on almartcajas.empresa = articulos.empresa and almartcajas.articulo = articulos.codigo "+&
		" where almartcajas.empresa = '"+codigo_empresa+"' "+&
		" and almartcajas.articulo in ("+art_encajados+") "+&
		" and almartcajas.pordefecto = 'S' "+&
		" and articulos.promocion <> 'S' "+&
		" and almartcajas.caja is not null "
		
f_cargar_cursor_nuevo (sel, ds_datos)
		
for k = 1 to ds_datos.rowcount()
	if lista_cajas = '' then
		lista_cajas = "'"+ds_datos.object.almcajas_codigo_compras[k]+"'"
	else
		lista_cajas = lista_cajas +", '"+ ds_datos.object.almcajas_codigo_compras[k]+"' "
	end if
next


sel = " select   almcajas.codigo "+&
		" 		, almcajas.descripcion "+&
		" 		, sum (planificacion.cantidad / almartcajas.piezascaja) as cantidad "+&
		" 		, (select sum(commovhis.cantidade - commovhis.cantidads)  "+&
		" 		  from commovhis  "+&
		" 		  where commovhis.empresa = almcajas.empresa and commovhis.mp = almcajas.codigo_compras ) as stock  "+&
		" from planificacion  "+&
		" inner join almartcajas on planificacion.empresa = almartcajas.empresa and planificacion.cod_articulo = almartcajas.articulo  "+&
		" inner join almcajas on almartcajas.empresa = almcajas.empresa and almartcajas.caja = almcajas.codigo  "+&
		" where almcajas.codigo_compras in ("+lista_cajas+") "+&
		" and planificacion.empresa = '"+codigo_empresa+"'  "+&
		" group by almcajas.empresa "+&
		" 		, almcajas.codigo "+&
		" 		, almcajas.descripcion "+&
		" 		, almcajas.codigo_compras "

// 		" where planificacion.cod_articulo in ("+art_encajados+")  "+&


/*
sel = " select almcajas.codigo, almcajas.descripcion, commovhis.mp, ( select  sum(C.cantidade- C.cantidads) 	from commovhis C where C.mp = commovhis.mp )  as stock  ,  "+&
		" 	((select sum(cantidad) "+&
		" 	from planificacion "+&
		" 	where cod_articulo in (select articulo  "+&
		" 							from almartcajas  "+&
		" 							inner join planificacion b on almartcajas.empresa = b.empresa and b.cod_articulo = almartcajas.articulo "+&
		" 							where caja = almcajas.codigo)))/ almartcajas.piezascaja as  cantidad "+&
		" from commovhis  "+&
		" inner join almcajas on commovhis.empresa = almcajas.empresa and commovhis.mp = almcajas.codigo_compras "+&
		" inner join almartcajas on almcajas.empresa = almartcajas.empresa and almcajas.codigo = almartcajas.caja "+&
		" where commovhis.empresa = '"+codigo_empresa+"' "+&
		" and commovhis.mp in ("+lista_cajas+") "+&
		" group by commovhis.empresa, almcajas.codigo, almcajas.descripcion, commovhis.mp , almartcajas.piezascaja "
*/

f_cargar_cursor_nuevo (sel, ds_datos2)

dw_1.reset()
for k = 1 to ds_datos2.rowcount()
	
	cod_caja = ds_datos2.object.almcajas_codigo[k]
	des_caja = ds_datos2.object.almcajas_descripcion[k]
	stock = ds_datos2.object.stock[k]
	cantidad = ds_datos2.object.cantidad[k]

	dw_1.insertrow(k)	
	dw_1.object.codigo[k] = cod_caja
	dw_1.object.descripcion[k] = des_caja
	dw_1.object.stock[k] = stock
	dw_1.object.cantidad[k] = cantidad
	
	if stock - cantidad >= 0 then
		dw_1.object.necesidad[k] = 0
	else		
		dw_1.object.necesidad[k] = stock - cantidad
	end if
next

destroy ds_datos
destroy ds_datos2

dw_1.retrieve ()
dw_1.Sort()
dw_1.GroupCalc()


end event

type dw_1 from datawindow within w_consulta_cajas_disponibles
integer x = 14
integer y = 16
integer width = 3433
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_cajas_disponibles"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;/*
long v_ot, fila_seleccionada
string cod_linea, linea

v_ot = w_ver_seleccion.dw_1.object.planificacion_ot[row]
linea = w_ver_seleccion.dw_1.object.prodlineas_resumido[row]

select codigo 
into :cod_linea
from prodlineas
where resumido = :linea
and empresa = :codigo_empresa;

w_planificacion.dw_1.retrieve(codigo_empresa,cod_linea)
fila_seleccionada = w_planificacion.dw_1.Find ("ot = "+string(v_ot), 1, w_planificacion.dw_1.RowCount() )
w_planificacion.dw_1.SelectRow ( fila_seleccionada, true )
w_planificacion.dw_1.ScrollToRow ( fila_seleccionada)
w_planificacion.sle_valor.text = cod_linea

w_planificacion.des_linea.text = linea

close(w_ver_seleccion)
*/
end event

