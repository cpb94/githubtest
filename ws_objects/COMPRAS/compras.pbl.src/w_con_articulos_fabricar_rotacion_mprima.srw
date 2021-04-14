$PBExportHeader$w_con_articulos_fabricar_rotacion_mprima.srw
forward
global type w_con_articulos_fabricar_rotacion_mprima from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_articulos_fabricar_rotacion_mprima
end type
type dw_1 from u_datawindow_consultas within w_con_articulos_fabricar_rotacion_mprima
end type
type cb_2 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
end type
type pb_imprimir_preli from upb_imprimir within w_con_articulos_fabricar_rotacion_mprima
end type
type dw_2 from datawindow within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_solopedidos from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type st_9 from statictext within w_con_articulos_fabricar_rotacion_mprima
end type
type em_fechadesde from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
end type
type st_8 from statictext within w_con_articulos_fabricar_rotacion_mprima
end type
type em_fechahasta from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
end type
type em_fechanecesidades from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
end type
type st_10 from statictext within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_inactivos from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_conrotacion from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_sinpedidos from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_sinrotacion from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type gb_1 from groupbox within w_con_articulos_fabricar_rotacion_mprima
end type
type uo_calidad from u_em_campo_2 within w_con_articulos_fabricar_rotacion_mprima
end type
type gb_2 from groupbox within w_con_articulos_fabricar_rotacion_mprima
end type
type st_cl from statictext within w_con_articulos_fabricar_rotacion_mprima
end type
type gb_3 from groupbox within w_con_articulos_fabricar_rotacion_mprima
end type
type cbx_solo_a_fabricar from checkbox within w_con_articulos_fabricar_rotacion_mprima
end type
type cb_3 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
end type
type uo_productos from u_marca_lista within w_con_articulos_fabricar_rotacion_mprima
end type
type cb_1 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
end type
end forward

global type w_con_articulos_fabricar_rotacion_mprima from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3675
integer height = 2004
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
dw_1 dw_1
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_2 dw_2
cbx_solopedidos cbx_solopedidos
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
em_fechanecesidades em_fechanecesidades
st_10 st_10
cbx_inactivos cbx_inactivos
cbx_conrotacion cbx_conrotacion
cbx_sinpedidos cbx_sinpedidos
cbx_sinrotacion cbx_sinrotacion
gb_1 gb_1
uo_calidad uo_calidad
gb_2 gb_2
st_cl st_cl
gb_3 gb_3
cbx_solo_a_fabricar cbx_solo_a_fabricar
cb_3 cb_3
uo_productos uo_productos
cb_1 cb_1
end type
global w_con_articulos_fabricar_rotacion_mprima w_con_articulos_fabricar_rotacion_mprima

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
boolean imprimir = false
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public function decimal f_cantidad_producir_articulo (string articulo)
public function decimal f_ventas_trimestre (string articulo, string calidad, integer trimestre)
public subroutine f_cargar_aux (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String   fam,form,color,sel,var_articulo,var_unidad,var_familia,filtro_materias,var_nombre_articulo
string   var_formato,mascara,activos,cliente_mercaderias,var_activo
string   filtro_final,var_materia_prima,var_materia_prima_ant,var_nombre_mp,var_unidad_mp
long     indice,total,dias_rotacion,dias_necesidades,donde,indice2,total2
long     relacion_base_decorado,es_base,i
dec      var_pedidas,var_albaranes,var_existencias,var_facturas,total_rotacion
dec      media_dias,necesidades,stock_minimo,ventas_1,ventas_2,ventas_3,ventas_4
dec      pendiente_fabricar,prevision_ventas
dec      pendiente_recibir_materia_prima,stock_materia_prima,var_existencias_base,var_relacion
datetime rot_desde,rot_hasta,nec_hasta,fecha_alta,min_ffacturas,min_falbaran
string   v_conrotacion = "N",v_sinpedidos = "N",v_sinrotacion = "N",v_conpedidos = "N",v_inactivos = "N"
string   filtro_familias,filtro_formatos,filtro_cliente,calidad,cliente
datastore articulos,bases_decorados
//Inicio del proceso by Pakito 27/08/01

uo_productos.visible = false

filtro_materias = ""
for i = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(i,"marca")="S" then
		if trim(filtro_materias) = "" then
			filtro_materias = "'"+uo_productos.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_materias = filtro_materias+",'"+uo_productos.dw_marca.getitemstring(i,"codigo")+"'"
		end if		
	end if
next
rot_desde = datetime(date(em_fechadesde.text))
rot_hasta = datetime(date(em_fechahasta.text))
nec_hasta = datetime(date(em_fechanecesidades.text))
calidad   = uo_calidad.em_codigo.text

data.Reset()
data.SetRedraw(FALSE)
data.setfilter("")
data.Retrieve(codigo_empresa,em_fechadesde.text,em_fechahasta.text,em_fechanecesidades.text)

sel = 	" select producto,articulo,cantidad,cantidad_articulo from almcompuestoart "+&
			" where empresa = '"+codigo_empresa+"' "+&
			" and   producto_terminado = 'N' "+&
			" and   producto in( "+&
			" select codigo from venmprima "+&
			" where empresa = '"+codigo_empresa+"' "+&
			" and   tipo_materia in("+filtro_materias+") "+&			
			") order by producto"

dias_necesidades = daysafter(today(),date(nec_hasta)) + 1
//articulos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, articulos)
total = articulos.rowcount()
var_materia_prima_ant = ""
if total > 0 then
	for indice = 1 to total
		f_mensaje_proceso("PROCESANDO "+string(indice,"###,##0")+" de "+string(total,"###,##0"),indice,total)
		var_materia_prima = articulos.object.producto[indice]
		
		if var_materia_prima_ant <> var_materia_prima then
			var_materia_prima_ant = var_materia_prima
			
			select descripcion,
					 tipo_unidad
			into   :var_nombre_mp,
					 :var_unidad_mp
			from   venmprima
			where  empresa = :codigo_empresa
			and    codigo  = :var_materia_prima;
			
			//Obtenemos las cantidades que tenemos en pedidos a proveedores
			select sum(cantidad) 
			into   :pendiente_recibir_materia_prima
			from   comlinpedpro
			where  empresa = :codigo_empresa
			and    mprima  = :var_materia_prima;
			
			if isnull(pendiente_recibir_materia_prima) then pendiente_recibir_materia_prima = 0 		
			
			select sum(existencias)
			into   :stock_materia_prima
			from   comlinubica
			where  empresa = :codigo_empresa
			and    mp     = :var_materia_prima;
			
			if isnull(stock_materia_prima) then stock_materia_prima = 0
		end if
		
		var_relacion      = articulos.object.cantidad[indice] / articulos.object.cantidad_articulo[indice]
		var_articulo      = articulos.object.articulo[indice]
		
		select descripcion,
				 familia,
				 formato,
				 unidad,
				 fecha_alta,
				 activo
		into   :var_nombre_articulo,
				 :var_familia,
				 :var_formato,
				 :var_unidad,
				 :fecha_alta,
				 :var_activo
		from   articulos
		where  empresa = :codigo_empresa
		and    codigo  = :var_articulo;
		
		rot_desde    = datetime(date(em_fechadesde.text))
		if isnull(var_activo) then var_activo = "S"
		
		if cbx_inactivos.checked or var_activo = "S" then
			if (date(fecha_alta) > date(rot_desde)) and (date(fecha_alta) < date(rot_hasta)) then
				rot_desde = fecha_alta		
				
				select min(falbaran)
				into   :min_ffacturas
				from   venlifac
				where  empresa   = :codigo_empresa
				and    articulo  = :var_articulo;
				
				if not(isnull(min_ffacturas)) then
					if rot_desde > min_ffacturas then
						rot_desde = min_ffacturas
					end if
				end if
				
				select min(falbaran)
				into   :min_falbaran
				from   venlialb
				where  empresa   = :codigo_empresa
				and    articulo  = :var_articulo;
				
				if not(isnull(min_falbaran)) then
					if rot_desde > min_falbaran then
						rot_desde = min_falbaran
					end if
				end if
				
			else
				rot_desde = datetime(date(em_fechadesde.text))
			end if
			
			dias_rotacion = DaysAfter (date(rot_desde),date(rot_hasta)) + 1
			
			select sum(existencias) 
			into   :var_existencias
			from   almlinubica 
			where  empresa  = :codigo_empresa
			and    articulo = :var_articulo
			and    calidad  = :calidad;
			
			if isnull(var_existencias) then var_existencias = 0 
			
			select sum(cantidad) 
			into   :var_pedidas
			from   venliped 
			where  empresa  = :codigo_empresa
			and    articulo = :var_articulo
			and    calidad  = :calidad;
			
			if isnull(var_pedidas) then var_pedidas = 0 
					
			select sum(cantidad)
			into   :var_facturas
			from   venlifac
			where  empresa   = :codigo_empresa
			and    articulo  = :var_articulo
			and    calidad   = :calidad
			and    falbaran between :rot_desde and :rot_hasta;
			
			if isnull(var_facturas) then var_facturas = 0
			
			select sum(cantidad)
			into   :var_albaranes
			from   venlialb
			where  empresa   = :codigo_empresa
			and    articulo  = :var_articulo
			and    calidad   = :calidad
			and    falbaran between :rot_desde and :rot_hasta;
			
			if isnull(var_albaranes) then var_albaranes = 0
			
			total_rotacion = var_facturas + var_albaranes
			
			media_dias = total_rotacion / dias_rotacion
						
			prevision_ventas   = (dias_necesidades * media_dias)+var_pedidas
			necesidades        = ((dias_necesidades * media_dias) &
										- (var_existencias + pendiente_recibir_materia_prima + pendiente_fabricar)) &
										+ var_pedidas + stock_minimo
			if necesidades < 0 then
				necesidades = 0
			end if	
			
			ventas_1 = f_ventas_trimestre(var_articulo,calidad,1)
			ventas_2 = f_ventas_trimestre(var_articulo,calidad,2)
			ventas_3 = f_ventas_trimestre(var_articulo,calidad,3)
			ventas_4 = f_ventas_trimestre(var_articulo,calidad,4)		
			
			donde = data.insertrow(0)
			data.object.empresa[donde]                 = codigo_empresa
			data.object.familia[donde]                 = f_nombre_familia(codigo_empresa,var_familia)
			data.object.fecha_alta[donde]              = string(date(fecha_alta),"dd/mm/yy")
			data.object.formato[donde]                 = f_nombre_formato_abr(codigo_empresa,var_formato)
			data.object.unidad[donde]                  = f_nombre_unidad_abr(var_unidad)
			data.object.codigo_unidad[donde]           = var_unidad
			data.object.articulo[donde]                = var_nombre_articulo
			data.object.stock[donde]                   = var_existencias
			data.object.stock_minimo[donde]            = stock_minimo
			data.object.pedido[donde]                  = var_pedidas
			data.object.rotacion[donde]                = total_rotacion
			data.object.fabricar[donde]                = necesidades
			data.object.ventas_1[donde]                = ventas_1
			data.object.ventas_2[donde]                = ventas_2
			data.object.ventas_3[donde]                = ventas_3
			data.object.ventas_4[donde]                = ventas_4
			data.object.prevision_ventas[donde]        = prevision_ventas
			data.object.pendiente_fabricar[donde]      = pendiente_fabricar
			
			data.object.materia_prima[donde]           = var_materia_prima
			data.object.nombre_materia_prima[donde]    = var_nombre_mp
			data.object.pendiente_recibir_mp[donde]    = pendiente_recibir_materia_prima
			data.object.stock_materia_prima[donde]     = stock_materia_prima	
			data.object.relacion_articulo_mp[donde]    = var_relacion
			data.object.unidad_mp[donde]               = var_unidad_mp
		end if //Comprobación activos
	next
end if

destroy articulos

filtro_final = ""
if cbx_conrotacion.checked and not cbx_sinrotacion.checked then
	//Solo articulos con rotacion
	filtro_final =  "rotacion <> 0 "
else
	if cbx_sinrotacion.checked and not cbx_conrotacion.checked then
		//Solo articulos sin rotacion
		filtro_final = "rotacion = 0 "
	end if
end if

if cbx_sinpedidos.checked and not cbx_solopedidos.checked then
	if filtro_final <> "" then
		filtro_final = filtro_final + " and pedido = 0 "
	else
		filtro_final = "pedido = 0 "
	end if
end if
if cbx_solo_a_fabricar.checked then
	if filtro_final <> "" then
		filtro_final = filtro_final + " and fabricar > 0 "
	else
		filtro_final = "fabricar > 0 "
	end if	
end if
data.setfilter(filtro_final)
data.filter()
data.sort()
data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

public function decimal f_cantidad_producir_articulo (string articulo);dec    produccion,produccion_otra
string otra_empresa

select sum(cantidad)
into   :produccion
from   proddiaria
where  empresa   = :codigo_empresa
and    articulo  = :articulo
and    fabricado <> "S";

if isnull(produccion) then produccion = 0

otra_empresa = f_mercaderia_empresa(codigo_empresa)

select sum(cantidad)
into   :produccion_otra
from   proddiaria
where  empresa   = :otra_empresa
and    articulo  = :articulo
and    fabricado <> "S";

if isnull(produccion_otra) then produccion_otra = 0

return produccion + produccion_otra
end function

public function decimal f_ventas_trimestre (string articulo, string calidad, integer trimestre);dec    ventas,ventas_alb
date   hoy,inicio_trimestre,final_trimestre
int    mes,dia,anyo,mes_inicio_trimestre,anyo_inicio_trimestre,mes_final_trimestre,anyo_final_trimestre
int    retraso_dias 

hoy  = today()
mes  = month(hoy)
dia  = day(hoy)
anyo = year(hoy)

mes_final_trimestre = mes - ((trimestre -1) * 3)
retraso_dias = 0
if mes_final_trimestre < 1 then
	mes_final_trimestre = 12 + mes_final_trimestre
	anyo_final_trimestre = anyo -1	
	do
		final_trimestre = mdy(mes_final_trimestre,dia - retraso_dias,anyo_final_trimestre)
		retraso_dias ++
	loop while year(final_trimestre) = 1900
	
else
	do
		final_trimestre = mdy(mes_final_trimestre,dia - retraso_dias,anyo)	
		retraso_dias ++
	loop while year(final_trimestre) = 1900
end if

mes_inicio_trimestre = mes - (trimestre * 3)
retraso_dias = 0
if mes_inicio_trimestre < 1 then
	mes_inicio_trimestre = 12 + mes_inicio_trimestre
	anyo_inicio_trimestre = anyo -1	
	do		
		inicio_trimestre = mdy(mes_inicio_trimestre,dia - retraso_dias,anyo_inicio_trimestre)		
		retraso_dias ++
	loop while year(inicio_trimestre) = 1900
	
else		
	do		
		inicio_trimestre = mdy(mes_inicio_trimestre,dia - retraso_dias,anyo)
		retraso_dias ++
	loop while year(inicio_trimestre) = 1900
end if

select sum(cantidad)
into   :ventas
from   venlifac
where  empresa   = :codigo_empresa
and    articulo  = :articulo
and    calidad   = :calidad
and    (falbaran > :inicio_trimestre and falbaran <= :final_trimestre);

select sum(cantidad)
into   :ventas_alb
from   venlialb
where  empresa   = :codigo_empresa
and    articulo  = :articulo
and    calidad   = :calidad
and    (falbaran > :inicio_trimestre and falbaran <= :final_trimestre);

if isnull(ventas_alb) then ventas_alb = 0

if isnull(ventas) then ventas = 0

return ventas + ventas_alb
end function

public subroutine f_cargar_aux (datawindow data);//String   fam,form,color,sel,var_articulo,var_unidad,var_familia,filtro_materias
//string   var_formato,mascara,activos,cliente_mercaderias
//string   filtro_final,base,sel2,var_base
//long     indice,total,dias_rotacion,dias_necesidades,donde,indice2,total2
//long     relacion_base_decorado,es_base,i,linea_decorado
//dec      var_pedidas,var_albaranes,var_existencias,var_facturas,total_rotacion
//dec      media_dias,necesidades,stock_minimo,ventas_1,ventas_2,ventas_3,ventas_4
//dec      pendiente_fabricar,prevision_ventas,total_rotacion_decorado,prevision_ventas_base,total_rotacion_base
//
//dec      pendiente_recibir,stock_base,var_existencias_base
//datetime rot_desde,rot_hasta,nec_hasta,fecha_alta,min_ffacturas,min_falbaran
//string   v_conrotacion = "N",v_sinpedidos = "N",v_sinrotacion = "N",v_conpedidos = "N",v_inactivos = "N"
//string   filtro_familias,filtro_formatos,calidad,var_unidad_base
//datastore articulos,bases_decorados
////Inicio del proceso by Pakito 28/03/00
//
//uo_familia.visible   = false
//uo_formato.visible   = false
//uo_productos.visible = false
//
//filtro_familias = ""
//for i = 1 to uo_familia.dw_marca.rowcount()
//	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
//		if trim(filtro_familias) = "" then
//			filtro_familias = "'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
//		else
//			filtro_familias = filtro_familias+",'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
//		end if
//	end if
//next
//filtro_formatos = ""
//for i = 1 to uo_formato.dw_marca.rowcount()
//	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
//		if trim(filtro_formatos) = "" then
//			filtro_formatos = "'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
//		else
//			filtro_formatos = filtro_formatos+",'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
//		end if		
//	end if
//next
//
//filtro_materias = ""
//for i = 1 to uo_productos.dw_marca.rowcount()
//	if uo_productos.dw_marca.getitemstring(i,"marca")="S" then
//		if trim(filtro_materias) = "" then
//			filtro_materias = "'"+uo_productos.dw_marca.getitemstring(i,"codigo")+"'"
//		else
//			filtro_materias = filtro_materias+",'"+uo_productos.dw_marca.getitemstring(i,"codigo")+"'"
//		end if		
//	end if
//next
//
//calidad = uo_calidad.em_codigo.text
//
//if cbx_inactivos.checked then
//	activos = ""
//else
//	activos = " and activo = 'S' "
//end if
//
//rot_desde = datetime(date(em_fechadesde.text))
//rot_hasta = datetime(date(em_fechahasta.text))
//nec_hasta = datetime(date(em_fechanecesidades.text))
//
//data.Reset()
//data.SetRedraw(FALSE)
//data.setfilter("")
//
//if cbx_solopedidos.checked then	
//	v_conpedidos  = "S"
//end if
//if cbx_sinpedidos.checked then
//	v_sinpedidos  = "S"
//end if
//if cbx_conrotacion.checked then
//	v_conrotacion = "S"
//end if
//if cbx_sinrotacion.checked then
//	v_sinrotacion = "S"
//end if
//if cbx_inactivos.checked then
//	v_inactivos   = "S"
//end if
//
//data.Retrieve(codigo_empresa,fam,form,em_fechadesde.text,em_fechahasta.text,em_fechanecesidades.text,v_conpedidos,v_sinpedidos,v_conrotacion,v_sinrotacion,v_inactivos)
//
//if cbx_solopedidos.checked and not cbx_sinpedidos.checked then
//	sel = "Select articulo,tipo_unidad unidad,familia,formato from venliped "+&
//			" where empresa = '"+codigo_empresa+"'"+&
//			" and calidad   = '"+calidad+"' "+&
//			" and articulo in("+&
//			" Select codigo from articulos "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and familia in ("+filtro_familias+") "+&
//			" and formato in ("+filtro_formatos+") "+&
//			activos+&
//			" and codigo in ("+&
//			" select articulo from almcompuestoart "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and   producto_terminado = 'N' "+&
//			" and   producto in( "+&
//			" select codigo from venmprima "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and   tipo_materia in("+filtro_materias+"))) "+&			
//			") group by articulo,tipo_unidad,familia,formato"
//else
//	sel = " Select codigo articulo,unidad,familia,formato from articulos "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and familia in ("+filtro_familias+") "+&
//			" and formato in ("+filtro_formatos+") "+&
//			activos+&
//			" and codigo in ("+&
//			" select articulo from almcompuestoart "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and   producto_terminado = 'N' "+&
//			" and   producto in( "+&
//			" select codigo from venmprima "+&
//			" where empresa = '"+codigo_empresa+"' "+&
//			" and   tipo_materia in("+filtro_materias+"))) "+&
//			" group by codigo,unidad,familia,formato"
//	
//end if
//
//dias_necesidades = daysafter(today(),date(nec_hasta)) + 1
//articulos = f_cargar_cursor(sel)
//total = articulos.rowcount()
//
//if total > 0 then
//	for indice = 1 to total
//		f_mensaje_proceso("PROCESANDO "+string(indice,"###,##0")+" de "+string(total,"###,##0"),indice,total)
//		var_articulo = articulos.object.articulo[indice]
//		es_base = 0
//		
//		select count(*)
//		into   :es_base
//		from   almdecorados
//		where  empresa = :codigo_empresa
//		and    base    = :var_articulo;
//		
//		if isnull(es_base) then es_base = 0
//		//Solo mostramos los articulos que no sean base de otros
//		if es_base = 0 then
//			var_unidad   = articulos.object.unidad[indice]
//			var_familia  = articulos.object.familia[indice]
//			var_formato  = articulos.object.formato[indice]
//			rot_desde    = datetime(date(em_fechadesde.text))
//			
//			select fecha_alta,stock_minimo
//			into   :fecha_alta,:stock_minimo 
//			from   articulos 
//			where  empresa = :codigo_empresa
//			and    codigo  = :var_articulo;
//			
//			if isnull(fecha_alta) then fecha_alta = rot_desde
//			if isnull(stock_minimo) then stock_minimo = 0
//			
//			if (date(fecha_alta) > date(rot_desde)) and (date(fecha_alta) < date(rot_hasta)) then
//				rot_desde = fecha_alta		
//				
//				select min(falbaran)
//				into   :min_ffacturas
//				from   venlifac
//				where  empresa   = :codigo_empresa
//				and    articulo  = :var_articulo;
//				
//				if not(isnull(min_ffacturas)) then
//					if rot_desde > min_ffacturas then
//						rot_desde = min_ffacturas
//					end if
//				end if
//				
//				select min(falbaran)
//				into   :min_falbaran
//				from   venlialb
//				where  empresa   = :codigo_empresa
//				and    articulo  = :var_articulo;
//				
//				if not(isnull(min_falbaran)) then
//					if rot_desde > min_falbaran then
//						rot_desde = min_falbaran
//					end if
//				end if
//				
//			else
//				rot_desde = datetime(date(em_fechadesde.text))
//			end if
//			
//			dias_rotacion = DaysAfter (date(rot_desde),date(rot_hasta)) + 1
//			
//			select sum(existencias) 
//			into   :var_existencias
//			from   almlinubica 
//			where  empresa  = :codigo_empresa
//			and    articulo = :var_articulo
//			and    calidad  = :calidad;
//			
//			if isnull(var_existencias) then var_existencias = 0 
//			
//			select sum(cantidad) 
//			into   :var_pedidas
//			from   venliped 
//			where  empresa  = :codigo_empresa
//			and    articulo = :var_articulo
//			and    calidad  = :calidad;
//			
//			if isnull(var_pedidas) then var_pedidas = 0 
//			
//			//Obtenemos las cantidades que tenemos en pedidos a proveedores
//			select sum(cantidad) 
//			into   :pendiente_recibir
//			from   decoralinalb
//			where  empresa  = :codigo_empresa
//			and    articulo = :var_articulo
//			and    situacion = 'P';
//			
//			if isnull(pendiente_recibir) then pendiente_recibir = 0 
//			
//			//Obtenemos las cantidades que tenemos de base pendientes de enviar a proveedores
//			sel2 = "select base,unidades "+&
//					 "from   almdecorados "+&
//					 "where  empresa  = '"+codigo_empresa+"' "+&
//					 "and    decorado = '"+var_articulo+"' "
//					
//			bases_decorados    = f_cargar_cursor(sel2)
//			total2             = bases_decorados.rowcount()
//			stock_base         = 0
//			pendiente_fabricar = 0
//			if total2 > 0 then
//				
//				for indice2 = 1 to total2
//					base                   = bases_decorados.object.base[indice2]
//					relacion_base_decorado = bases_decorados.object.unidades[indice2]
//					if isnull(relacion_base_decorado) then relacion_base_decorado = 0
//					if relacion_base_decorado = 0 then relacion_base_decorado = 1
//					
//					var_existencias_base   = 0
//					
//					select sum(existencias) 
//					into   :var_existencias_base
//					from   almlinubica 
//					where  empresa  = :codigo_empresa
//					and    articulo = :base
//					and    calidad  = :calidad;
//					
//					if isnull(var_existencias_base) then var_existencias_base = 0 
//					var_existencias_base = var_existencias_base * relacion_base_decorado
//					stock_base = stock_base + var_existencias_base
//					pendiente_fabricar = 0
//					//pendiente_fabricar = pendiente_fabricar + f_cantidad_producir_articulo(base)
//				next
//			else
//				pendiente_fabricar = 0
//				//pendiente_fabricar = f_cantidad_producir_articulo(var_articulo)
//			end if
//			destroy bases_decorados
//			///////////////
//
//			select sum(cantidad)
//			into   :var_facturas
//			from   venlifac
//			where  empresa   = :codigo_empresa
//			and    articulo  = :var_articulo
//			and    calidad   = :calidad
//			and    falbaran between :rot_desde and :rot_hasta;
//			
//			if isnull(var_facturas) then var_facturas = 0
//			
//			select sum(cantidad)
//			into   :var_albaranes
//			from   venlialb
//			where  empresa   = :codigo_empresa
//			and    articulo  = :var_articulo
//			and    calidad   = :calidad
//			and    falbaran between :rot_desde and :rot_hasta;
//			
//			if isnull(var_albaranes) then var_albaranes = 0
//			
//			///////////////
//			
//			total_rotacion = var_facturas + var_albaranes
//			
//			media_dias = total_rotacion / dias_rotacion
//						
//			prevision_ventas   = (dias_necesidades * media_dias)+var_pedidas
//			necesidades        = ((dias_necesidades * media_dias) &
//										- (var_existencias + pendiente_recibir + &
//											stock_base + pendiente_fabricar)) &
//										+ var_pedidas + stock_minimo
//			if necesidades < 0 then
//				necesidades = 0
//			end if	
//			
//			ventas_1 = f_ventas_trimestre(var_articulo,calidad,1)
//			ventas_2 = f_ventas_trimestre(var_articulo,calidad,2)
//			ventas_3 = f_ventas_trimestre(var_articulo,calidad,3)
//			ventas_4 = f_ventas_trimestre(var_articulo,calidad,4)		
//			
//			donde = data.insertrow(data.rowcount() + 1)
//			linea_decorado = donde
//			
//			data.object.empresa[donde]                 = codigo_empresa
//			data.object.familia[donde]                 = f_nombre_familia(codigo_empresa,var_familia)
//			data.object.fecha_alta[donde]              = string(date(fecha_alta),"dd/mm/yy")
//			data.object.formato[donde]                 = f_nombre_formato_abr(codigo_empresa,var_formato)
//			data.object.unidad[donde]                  = f_nombre_unidad_abr(var_unidad)
//			data.object.codigo_unidad[donde]           = var_unidad
//			data.object.articulo[donde]                = f_nombre_articulo(codigo_empresa,var_articulo)
//			data.object.stock[donde]                   = var_existencias
//			data.object.stock_minimo[donde]            = stock_minimo
//			data.object.pedido[donde]                  = var_pedidas
//			data.object.rotacion[donde]                = total_rotacion
//			data.object.fabricar[donde]                = necesidades
//			data.object.ventas_1[donde]                = ventas_1
//			data.object.ventas_2[donde]                = ventas_2
//			data.object.ventas_3[donde]                = ventas_3
//			data.object.ventas_4[donde]                = ventas_4
//			data.object.prevision_ventas[donde]        = prevision_ventas
//			data.object.pendiente_fabricar[donde]      = pendiente_fabricar
//			data.object.pendiente_recibir[donde]       = pendiente_recibir
//			data.object.stock_base[donde]              = stock_base			
//			data.object.es_base[donde]                 = "N"
//			data.object.base[donde]                    = ""
//			data.object.unidad_base[donde]             = ""
//			data.object.formato_base[donde]            = ""
//			data.object.codigo_unidad_base[donde]      = ""
//			total_rotacion_decorado = total_rotacion 			
//		
//			//Introducimos el detalle de las bases 
//	
//			sel2 = "select base "+&
//					 "from   almdecorado_base "+&
//					 "where  empresa  = '"+codigo_empresa+"' "+&
//					 "and    decorado = '"+var_articulo+"' "
//					
//			bases_decorados    = f_cargar_cursor(sel2)
//			total2             = bases_decorados.rowcount()
//			prevision_ventas_base = 0
//			total_rotacion_base   = 0
//			
//			for indice2 = 1 to total2
//				var_base        = bases_decorados.object.base[indice2]
//				var_unidad_base = f_unidad_articulo(codigo_empresa,var_base)				
//				//rot_desde       = datetime(date(em_fechadesde.text))
//				
//				select fecha_alta,stock_minimo
//				into   :fecha_alta,:stock_minimo 
//				from   articulos 
//				where  empresa = :codigo_empresa
//				and    codigo  = :var_base;
//				
//				if isnull(fecha_alta) then fecha_alta = rot_desde
//				if isnull(stock_minimo) then stock_minimo = 0
//				
//				//La rotación sera igual a la del decorado				
////				if (date(fecha_alta) > date(rot_desde)) and (date(fecha_alta) < date(rot_hasta)) then
////					rot_desde = fecha_alta		
////					
////					select min(falbaran)
////					into   :min_ffacturas
////					from   venlifac
////					where  empresa   = :codigo_empresa
////					and    articulo  = :var_base;
////					
////					if not(isnull(min_ffacturas)) then
////						if rot_desde > min_ffacturas then
////							rot_desde = min_ffacturas
////						end if
////					end if
////					
////					select min(falbaran)
////					into   :min_falbaran
////					from   venlialb
////					where  empresa   = :codigo_empresa
////					and    articulo  = :var_base;
////					
////					if not(isnull(min_falbaran)) then
////						if rot_desde > min_falbaran then
////							rot_desde = min_falbaran
////						end if
////					end if
////					
////				else
////					rot_desde = datetime(date(em_fechadesde.text))
////				end if
//				
//				dias_rotacion = DaysAfter (date(rot_desde),date(rot_hasta)) + 1
//				
//				select sum(existencias) 
//				into   :var_existencias
//				from   almlinubica 
//				where  empresa  = :codigo_empresa
//				and    articulo = :var_base
//				and    calidad  = :calidad;
//				
//				if isnull(var_existencias) then var_existencias = 0 
//				
//				select sum(cantidad) 
//				into   :var_pedidas
//				from   venliped 
//				where  empresa  = :codigo_empresa
//				and    articulo = :var_base
//				and    calidad  = :calidad;
//				
//				if isnull(var_pedidas) then var_pedidas = 0 
//				
//				//Obtenemos las cantidades que tenemos en pedidos a proveedores
//				select sum(cantidad) 
//				into   :pendiente_recibir
//				from   decoralinalb
//				where  empresa  = :codigo_empresa
//				and    articulo = :var_base
//				and    situacion = 'P';
//				
//				if isnull(pendiente_recibir) then pendiente_recibir = 0 
//				
//	//			//Obtenemos las cantidades que tenemos de base pendientes de enviar a proveedores
//	//			sel2 = "select base,unidades "+&
//	//					 "from   almdecorados "+&
//	//					 "where  empresa  = '"+codigo_empresa+"' "+&
//	//					 "and    decorado = '"+var_base+"' "
//	//					
//	//			bases_decorados    = f_cargar_cursor(sel2)
//	//			total2             = bases_decorados.rowcount()
//				stock_base         = 0
//				pendiente_fabricar = 0
//	//			if total2 > 0 then
//	//				
//	//				for indice2 = 1 to total2
//	//					base                   = bases_decorados.object.base[indice2]
//	//					relacion_base_decorado = bases_decorados.object.unidades[indice2]
//	//					if isnull(relacion_base_decorado) then relacion_base_decorado = 0
//	//					if relacion_base_decorado = 0 then relacion_base_decorado = 1
//	//					
//	//					var_existencias_base   = 0
//	//					
//	//					select sum(existencias) 
//	//					into   :var_existencias_base
//	//					from   almlinubica 
//	//					where  empresa  = :codigo_empresa
//	//					and    articulo = :base
//	//					and    calidad  = :calidad;
//	//					
//	//					if isnull(var_existencias_base) then var_existencias_base = 0 
//	//					var_existencias_base = var_existencias_base * relacion_base_decorado
//	//					stock_base = stock_base + var_existencias_base
//	//					pendiente_fabricar = 0
//	//					//pendiente_fabricar = pendiente_fabricar + f_cantidad_producir_articulo(base)
//	//				next
//	//			else
//	//				pendiente_fabricar = 0
//	//				//pendiente_fabricar = f_cantidad_producir_articulo(var_articulo)
//	//			end if
//	//			destroy bases_decorados
//				///////////////
//	
//				select sum(cantidad)
//				into   :var_facturas
//				from   venlifac
//				where  empresa   = :codigo_empresa
//				and    articulo  = :var_base
//				and    calidad   = :calidad
//				and    falbaran between :rot_desde and :rot_hasta;
//				
//				if isnull(var_facturas) then var_facturas = 0
//				
//				select sum(cantidad)
//				into   :var_albaranes
//				from   venlialb
//				where  empresa   = :codigo_empresa
//				and    articulo  = :var_base
//				and    calidad   = :calidad
//				and    falbaran between :rot_desde and :rot_hasta;
//				
//				if isnull(var_albaranes) then var_albaranes = 0
//				
//				///////////////
//				
//				total_rotacion = var_facturas + var_albaranes
//				
//				media_dias = total_rotacion / dias_rotacion
//							
//				prevision_ventas   = (dias_necesidades * media_dias)+var_pedidas
//				necesidades        = ((dias_necesidades * media_dias) &
//											- (var_existencias + pendiente_recibir + &
//												stock_base + pendiente_fabricar)) &
//											+ var_pedidas + stock_minimo
//				if necesidades < 0 then
//					necesidades = 0
//				end if	
//				
//				ventas_1 = f_ventas_trimestre(var_base,calidad,1)
//				ventas_2 = f_ventas_trimestre(var_base,calidad,2)
//				ventas_3 = f_ventas_trimestre(var_base,calidad,3)
//				ventas_4 = f_ventas_trimestre(var_base,calidad,4)		
//				
//				donde = data.insertrow(data.rowcount() + 1)
//				data.object.empresa[donde]                 = codigo_empresa
//				data.object.familia[donde]                 = f_nombre_familia(codigo_empresa,var_familia)
//				data.object.fecha_alta[donde]              = string(date(fecha_alta),"dd/mm/yy")
//				data.object.formato[donde]                 = f_nombre_formato_abr(codigo_empresa,var_formato)
//				data.object.unidad[donde]                  = f_nombre_unidad_abr(var_unidad)
//				data.object.codigo_unidad[donde]           = var_unidad
//				data.object.articulo[donde]                = f_nombre_articulo(codigo_empresa,var_articulo)
//				data.object.stock[donde]                   = var_existencias
//				data.object.stock_minimo[donde]            = stock_minimo
//				data.object.pedido[donde]                  = var_pedidas
//				data.object.rotacion[donde]                = total_rotacion
//				data.object.fabricar[donde]                = 0 //necesidades
//				data.object.ventas_1[donde]                = ventas_1
//				data.object.ventas_2[donde]                = ventas_2
//				data.object.ventas_3[donde]                = ventas_3
//				data.object.ventas_4[donde]                = ventas_4
//				data.object.prevision_ventas[donde]        = prevision_ventas
//				data.object.pendiente_fabricar[donde]      = pendiente_fabricar
//				data.object.pendiente_recibir[donde]       = pendiente_recibir
//				data.object.stock_base[donde]              = stock_base			
//				data.object.es_base[donde]                 = "S"
//				data.object.base[donde]                    = f_nombre_articulo(codigo_empresa,var_base)
//				data.object.unidad_base[donde]             = f_nombre_unidad_abr(var_unidad_base)
//				data.object.formato_base[donde]            = f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,var_base))
//				data.object.codigo_unidad_base[donde]      = var_unidad_base
//				
//				if total_rotacion <> 0 then
//					data.object.prevision_ventas_segun_base[donde] = prevision_ventas * (total_rotacion_decorado / total_rotacion)
//				else
//					data.object.prevision_ventas_segun_base[donde] = 0
//				end if
//							
//				total_rotacion_base   = total_rotacion_base + total_rotacion			
//				prevision_ventas_base = prevision_ventas_base + prevision_ventas
//			next
//			destroy bases_decorados
//			//Fin de introducimos el detalle de las bases 
//			if total_rotacion_base <> 0 then
//				data.object.prevision_ventas_segun_base[linea_decorado] = prevision_ventas_base * (total_rotacion_decorado / total_rotacion_base)
//				necesidades = data.object.fabricar[linea_decorado] + (data.object.prevision_ventas_segun_base[linea_decorado] - data.object.prevision_ventas[linea_decorado])
//				if necesidades < 0 then necesidades = 0 
//				data.object.fabricar[linea_decorado] = necesidades
//			else
//				data.object.prevision_ventas_segun_base[linea_decorado] = 0
//			end if
//		end if
//	next
//end if
//
//destroy articulos
//
//filtro_final = ""
//if cbx_conrotacion.checked and not cbx_sinrotacion.checked then
//	//Solo articulos con rotacion
//	filtro_final =  "rotacion <> 0 "
//else
//	if cbx_sinrotacion.checked and not cbx_conrotacion.checked then
//		//Solo articulos sin rotacion
//		filtro_final = "rotacion = 0 "
//	end if
//end if
//
//if cbx_sinpedidos.checked and not cbx_solopedidos.checked then
//	if filtro_final <> "" then
//		filtro_final = filtro_final + " and pedido = 0 "
//	else
//		filtro_final = "pedido = 0 "
//	end if
//end if
//if cbx_solo_a_fabricar.checked then
//	if filtro_final <> "" then
//		filtro_final = filtro_final + " and fabricar > 0 "
//	else
//		filtro_final = "fabricar > 0 "
//	end if	
//end if
//data.setfilter(filtro_final)
//data.filter()
//data.sort()
//data.GroupCalc()
//data.SetRedraw(TRUE)
//
end subroutine

event open;call super::open;dw_2.SetTransObject(sqlca)
dw_2.ShareData(dw_1)
This.title = "Necesidades de Materias Primas Segun Ventas"
//istr_parametros = Message.PowerObjectParm
uo_calidad.em_codigo.text = "1"
uo_calidad.triggerevent("modificado")

uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")
f_activar_campo(em_fechadesde)
end event

on w_con_articulos_fabricar_rotacion_mprima.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_2=create dw_2
this.cbx_solopedidos=create cbx_solopedidos
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.em_fechanecesidades=create em_fechanecesidades
this.st_10=create st_10
this.cbx_inactivos=create cbx_inactivos
this.cbx_conrotacion=create cbx_conrotacion
this.cbx_sinpedidos=create cbx_sinpedidos
this.cbx_sinrotacion=create cbx_sinrotacion
this.gb_1=create gb_1
this.uo_calidad=create uo_calidad
this.gb_2=create gb_2
this.st_cl=create st_cl
this.gb_3=create gb_3
this.cbx_solo_a_fabricar=create cbx_solo_a_fabricar
this.cb_3=create cb_3
this.uo_productos=create uo_productos
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cbx_solopedidos
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.em_fechahasta
this.Control[iCurrent+11]=this.em_fechanecesidades
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.cbx_inactivos
this.Control[iCurrent+14]=this.cbx_conrotacion
this.Control[iCurrent+15]=this.cbx_sinpedidos
this.Control[iCurrent+16]=this.cbx_sinrotacion
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.uo_calidad
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.st_cl
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.cbx_solo_a_fabricar
this.Control[iCurrent+23]=this.cb_3
this.Control[iCurrent+24]=this.uo_productos
this.Control[iCurrent+25]=this.cb_1
end on

on w_con_articulos_fabricar_rotacion_mprima.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_2)
destroy(this.cbx_solopedidos)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.em_fechanecesidades)
destroy(this.st_10)
destroy(this.cbx_inactivos)
destroy(this.cbx_conrotacion)
destroy(this.cbx_sinpedidos)
destroy(this.cbx_sinrotacion)
destroy(this.gb_1)
destroy(this.uo_calidad)
destroy(this.gb_2)
destroy(this.st_cl)
destroy(this.gb_3)
destroy(this.cbx_solo_a_fabricar)
destroy(this.cb_3)
destroy(this.uo_productos)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_articulos_fabricar_rotacion_mprima
integer height = 44
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_articulos_fabricar_rotacion_mprima
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_articulos_fabricar_rotacion_mprima
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_articulos_fabricar_rotacion_mprima
integer x = 3488
integer y = 8
integer width = 114
integer height = 104
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_articulos_fabricar_rotacion_mprima
integer y = 316
integer width = 3602
integer height = 1468
integer taborder = 80
string dataobject = "dw_con_articulos_fabricar_rotacion_mp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"codigo_tipo_pallet"))
//
//if dw_1.Rowcount()<>0 then 
//   dw_1.SetRow(1)
//   dw_1.SelectRow(1,true)
//end if
end event

event clicked;call super::clicked;long  ll_fila_actual
str_parametros valores
String ls_objeto
ll_fila_actual = row


str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE ls_objeto
  
CASE 'valor'
IF ll_fila_actual <> 0 THEN
  IF dw_1.getitemString(ll_fila_actual,"valor") = "*" Then
   valores.s_argumentos[1]=dw_1.getitemString(ll_fila_actual,"referencia")
	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
   OpenWithParm(w_observaciones_almlinubica,valores)  
  END IF
END IF


CASE ELSE
//IF ll_fila_actual <> 0  and devolver = "S" THEN
//   valores.s_argumentos[1]=uo_articulo.em_codigo.text
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
//	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
//	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
//	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//	CloseWithReturn(Parent,valores)
//END IF
//
//

END CHOOSE





end event

event rowfocuschanged;call super::rowfocuschanged;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"tipo_pallet"))
end event

event tecla_enter;call super::tecla_enter;//long  ll_fila_actual
//str_parametros valores
//ll_fila_actual = dw_1.GetRow()
//IF ll_fila_actual <> 0  and devolver = "S" THEN
//   valores.s_argumentos[1]=uo_articulo.em_codigo.text
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
//	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
//	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
//	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//	CloseWithReturn(Parent,valores)
//END IF
end event

event key;call super::key;//contro = "S"
end event

type cb_2 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
event clicked pbm_bnclicked
integer x = 2414
integer y = 216
integer width = 311
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;if trim(em_fechadesde.text) = "" then
	messagebox("Atención","Falta la fecha de inicio")
	em_fechadesde.setfocus()
else
	if trim(em_fechahasta.text) = "" then
		messagebox("Atención","Falta la fecha de fin")
		em_fechahasta.setfocus()
	else
		if date(em_fechahasta.text) < date(em_fechadesde.text) then
			messagebox("Atención", "La fecha final debe ser mayor o igual a la inicial")
			em_fechahasta.setfocus()
		else
			if date(em_fechanecesidades.text) < today() then
				messagebox("Atención", "La fecha de necesidades debe ser~nposterior o igual a la de hoy.")
				em_fechanecesidades.setfocus()
			else
				if trim(uo_calidad.em_codigo.text) = "" then
					messagebox("Atención", "Debe seleccionar la calidad.")
					uo_calidad.em_campo.setfocus()					
				else
					f_cargar(dw_2)					
				end if
			end if
		end if	
	end if
end if
end event

type pb_imprimir_preli from upb_imprimir within w_con_articulos_fabricar_rotacion_mprima
event clicked pbm_bnclicked
integer x = 3150
integer y = 208
integer height = 92
integer taborder = 60
boolean originalsize = false
end type

event clicked;if trim(em_fechadesde.text) = "" then
	messagebox("Atención","Falta la fecha de inicio")
	em_fechadesde.setfocus()
else
	if trim(em_fechahasta.text) = "" then
		messagebox("Atención","Falta la fecha de fin")
		em_fechahasta.setfocus()
	else
		if date(em_fechahasta.text) < date(em_fechadesde.text) then
			messagebox("Atención", "La fecha final debe ser mayor o igual a la inicial")
			em_fechahasta.setfocus()
		else
			if date(em_fechanecesidades.text) < today() then
				messagebox("Atención", "La fecha de necesidades debe ser~nposterior o igual a la de hoy.")
				em_fechanecesidades.setfocus()
			else
				if dw_2.rowcount() = 0 then
					f_cargar(dw_2)
				end if				
				if dw_2.rowcount() > 0 then
					f_imprimir_datawindow(dw_2)
				end if
			end if
		end if	
	end if
end if


end event

type dw_2 from datawindow within w_con_articulos_fabricar_rotacion_mprima
boolean visible = false
integer x = 530
integer y = 372
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "repor_con_articulos_fabricar_rotacion_mp"
boolean livescroll = true
end type

type cbx_solopedidos from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 14
integer y = 120
integer width = 407
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Con pedidos"
boolean checked = true
end type

type st_9 from statictext within w_con_articulos_fabricar_rotacion_mprima
integer x = 27
integer y = 224
integer width = 183
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
integer x = 201
integer y = 220
integer height = 72
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_articulos_fabricar_rotacion_mprima
integer x = 480
integer y = 224
integer width = 151
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
integer x = 640
integer y = 220
integer height = 72
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechanecesidades from u_em_campo within w_con_articulos_fabricar_rotacion_mprima
integer x = 1184
integer y = 220
integer height = 72
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_10 from statictext within w_con_articulos_fabricar_rotacion_mprima
integer x = 946
integer y = 224
integer width = 151
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_inactivos from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 1714
integer y = 120
integer width = 407
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inactivos"
end type

type cbx_conrotacion from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 864
integer y = 120
integer width = 407
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Con rotación"
boolean checked = true
end type

type cbx_sinpedidos from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 439
integer y = 120
integer width = 407
integer height = 56
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sin pedidos"
end type

type cbx_sinrotacion from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 1289
integer y = 120
integer width = 407
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sin rotación"
end type

type gb_1 from groupbox within w_con_articulos_fabricar_rotacion_mprima
integer y = 172
integer width = 914
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rotación"
end type

type uo_calidad from u_em_campo_2 within w_con_articulos_fabricar_rotacion_mprima
event destroy ( )
integer x = 2309
integer y = 220
integer width = 96
integer height = 72
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_calidad.em_campo.text = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text) = "" THEN 
	IF Trim(uo_calidad.em_codigo.text) <> "" Then uo_calidad.em_campo.SetFocus()
	uo_calidad.em_campo.text  = ""
	uo_calidad.em_codigo.text = ""
END IF


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

type gb_2 from groupbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 914
integer y = 172
integer width = 544
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Necesidades"
end type

type st_cl from statictext within w_con_articulos_fabricar_rotacion_mprima
integer x = 2107
integer y = 224
integer width = 197
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Calidad"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 1458
integer y = 172
integer width = 1810
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_solo_a_fabricar from checkbox within w_con_articulos_fabricar_rotacion_mprima
integer x = 2098
integer y = 120
integer width = 558
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo a Fabricar"
end type

type cb_3 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
integer x = 1467
integer y = 212
integer width = 635
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Materias Primas"
end type

event clicked;uo_productos.visible = not(uo_productos.visible)

end event

type uo_productos from u_marca_lista within w_con_articulos_fabricar_rotacion_mprima
event destroy ( )
boolean visible = false
integer x = 754
integer y = 312
integer width = 1349
integer height = 656
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type cb_1 from commandbutton within w_con_articulos_fabricar_rotacion_mprima
integer x = 2729
integer y = 216
integer width = 311
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;if this.text = "Detalle" then
	this.text = "Resumen"
	dw_1.modify("datawindow.header.1.height = 152")
	dw_1.modify("datawindow.detail.height   = 64")
	dw_2.modify("datawindow.header.1.height = 152")
	dw_2.modify("datawindow.detail.height   = 64")
	dw_2.Object.DataWindow.Print.Orientation = 1 //Landscape
else
	this.text = "Detalle"
	dw_1.modify("datawindow.header.1.height = 64")
	dw_1.modify("datawindow.detail.height   = 0")
	dw_2.modify("datawindow.header.1.height = 64")
	dw_2.modify("datawindow.detail.height   = 0")	
	dw_2.Object.DataWindow.Print.Orientation = 2 //Portrait
end if
end event

