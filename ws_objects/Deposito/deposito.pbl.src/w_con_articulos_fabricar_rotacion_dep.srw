$PBExportHeader$w_con_articulos_fabricar_rotacion_dep.srw
forward
global type w_con_articulos_fabricar_rotacion_dep from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_articulos_fabricar_rotacion_dep
end type
type dw_1 from u_datawindow_consultas within w_con_articulos_fabricar_rotacion_dep
end type
type cb_2 from commandbutton within w_con_articulos_fabricar_rotacion_dep
end type
type pb_imprimir_preli from upb_imprimir within w_con_articulos_fabricar_rotacion_dep
end type
type dw_2 from datawindow within w_con_articulos_fabricar_rotacion_dep
end type
type st_9 from statictext within w_con_articulos_fabricar_rotacion_dep
end type
type em_fechadesde from u_em_campo within w_con_articulos_fabricar_rotacion_dep
end type
type st_8 from statictext within w_con_articulos_fabricar_rotacion_dep
end type
type em_fechahasta from u_em_campo within w_con_articulos_fabricar_rotacion_dep
end type
type em_fechanecesidades from u_em_campo within w_con_articulos_fabricar_rotacion_dep
end type
type st_10 from statictext within w_con_articulos_fabricar_rotacion_dep
end type
type cbx_inactivos from checkbox within w_con_articulos_fabricar_rotacion_dep
end type
type cbx_conrotacion from checkbox within w_con_articulos_fabricar_rotacion_dep
end type
type cbx_sinrotacion from checkbox within w_con_articulos_fabricar_rotacion_dep
end type
type cb_4 from commandbutton within w_con_articulos_fabricar_rotacion_dep
end type
type cb_5 from commandbutton within w_con_articulos_fabricar_rotacion_dep
end type
type uo_familia from u_marca_lista within w_con_articulos_fabricar_rotacion_dep
end type
type uo_formato from u_marca_lista within w_con_articulos_fabricar_rotacion_dep
end type
type gb_1 from groupbox within w_con_articulos_fabricar_rotacion_dep
end type
type uo_calidad from u_em_campo_2 within w_con_articulos_fabricar_rotacion_dep
end type
type gb_2 from groupbox within w_con_articulos_fabricar_rotacion_dep
end type
type st_cl from statictext within w_con_articulos_fabricar_rotacion_dep
end type
type gb_3 from groupbox within w_con_articulos_fabricar_rotacion_dep
end type
type uo_deposito from u_em_campo_2 within w_con_articulos_fabricar_rotacion_dep
end type
type gb_4 from groupbox within w_con_articulos_fabricar_rotacion_dep
end type
end forward

global type w_con_articulos_fabricar_rotacion_dep from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1624
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_2 dw_2
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
em_fechanecesidades em_fechanecesidades
st_10 st_10
cbx_inactivos cbx_inactivos
cbx_conrotacion cbx_conrotacion
cbx_sinrotacion cbx_sinrotacion
cb_4 cb_4
cb_5 cb_5
uo_familia uo_familia
uo_formato uo_formato
gb_1 gb_1
uo_calidad uo_calidad
gb_2 gb_2
st_cl st_cl
gb_3 gb_3
uo_deposito uo_deposito
gb_4 gb_4
end type
global w_con_articulos_fabricar_rotacion_dep w_con_articulos_fabricar_rotacion_dep

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
end prototypes

public subroutine f_cargar (datawindow data);
String   fam,form,color,sel,var_articulo,var_unidad,var_familia,var_deposito
string   var_formato,mascara,activos,cliente_mercaderias
string   filtro_final,base,sel2
long     indice,total,dias_rotacion,dias_necesidades,donde,indice2,total2
long     relacion_base_decorado,es_base,i
dec      var_albaranes,var_existencias,var_facturas,total_rotacion
dec      media_dias,necesidades,ventas_1,ventas_2,ventas_3,ventas_4
dec      prevision_ventas
dec      pendiente_recibir
datetime rot_desde,rot_hasta,nec_hasta,fecha_alta,min_ffacturas,min_falbaran
string   v_conrotacion = "N",v_sinrotacion = "N",v_inactivos = "N"
string   filtro_familias,filtro_formatos,calidad
datastore articulos,bases_decorados
//Inicio del proceso by Pakito 07/05/01

uo_familia.visible = false
uo_formato.visible = false

var_deposito = uo_deposito.em_codigo.text

filtro_familias = ""
for i = 1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		if trim(filtro_familias) = "" then
			filtro_familias = "'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_familias = filtro_familias+",'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
		end if
	end if
next
filtro_formatos = ""
for i = 1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		if trim(filtro_formatos) = "" then
			filtro_formatos = "'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_formatos = filtro_formatos+",'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
		end if		
	end if
next

calidad = uo_calidad.em_codigo.text

if cbx_inactivos.checked then
	activos = ""
else
	activos = " and activo = 'S' "
end if

rot_desde = datetime(date(em_fechadesde.text))
rot_hasta = datetime(date(em_fechahasta.text))
nec_hasta = datetime(date(em_fechanecesidades.text))

data.Reset()
data.SetRedraw(FALSE)
data.setfilter("")

if cbx_conrotacion.checked then
	v_conrotacion = "S"
end if
if cbx_sinrotacion.checked then
	v_sinrotacion = "S"
end if
if cbx_inactivos.checked then
	v_inactivos   = "S"
end if

data.Retrieve(codigo_empresa,fam,form,em_fechadesde.text,em_fechahasta.text,em_fechanecesidades.text,v_conrotacion,v_sinrotacion,v_inactivos,uo_deposito.em_campo.text)

sel = " Select codigo articulo,unidad,familia,formato from articulos "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and familia in ("+filtro_familias+") "+&
		" and formato in ("+filtro_formatos+") "+&
		activos+&
		" group by codigo,unidad,familia,formato"

dias_necesidades = daysafter(today(),date(nec_hasta)) + 1
articulos = f_cargar_cursor(sel)
total = articulos.rowcount()

if total > 0 then
	for indice = 1 to total
		f_mensaje_proceso("PROCESANDO "+string(indice,"###,##0")+" de "+string(total,"###,##0"),indice,total)
		var_articulo = articulos.object.articulo[indice]
		es_base = 0
		
		select count(*)
		into   :es_base
		from   almdecorados
		where  empresa = :codigo_empresa
		and    base    = :var_articulo;
		
		if isnull(es_base) then es_base = 0
		//Solo mostramos los articulos que no sean base de otros
		if es_base = 0 then
			var_unidad   = articulos.object.unidad[indice]
			var_familia  = articulos.object.familia[indice]
			var_formato  = articulos.object.formato[indice]
			rot_desde    = datetime(date(em_fechadesde.text))
			
			select fecha_alta
			into   :fecha_alta
			from   articulos 
			where  empresa = :codigo_empresa
			and    codigo  = :var_articulo;
			
			if isnull(fecha_alta) then fecha_alta = rot_desde
			
			if (date(fecha_alta) > date(rot_desde)) and (date(fecha_alta) < date(rot_hasta)) then
				rot_desde = fecha_alta		
				
				select min(falbaran)
				into   :min_ffacturas
				from   venlifac
				where  empresa   = :codigo_empresa
				and    articulo  = :var_articulo
				and    consumo_deposito = 'S'
				and    almacen_deposito = :var_deposito;
				
				if not(isnull(min_ffacturas)) then
					if rot_desde > min_ffacturas then
						rot_desde = min_ffacturas
					end if
				end if
				
				select min(falbaran)
				into   :min_falbaran
				from   venlialb
				where  empresa   = :codigo_empresa
				and    articulo  = :var_articulo
				and    consumo_deposito = 'S'
				and    almacen_deposito = :var_deposito;
				
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
			from   deplinubica
			where  empresa  = :codigo_empresa
			and    articulo = :var_articulo
			and    calidad  = :calidad
			and    almacen  = :var_deposito;
			
			if isnull(var_existencias) then var_existencias = 0 
						
			//Obtenemos las cantidades que tenemos en pedidos pendientes de enviar al deposito
			select sum(cantidad) 
			into   :pendiente_recibir
			from   venliped
			where  empresa  = :codigo_empresa
			and    articulo = :var_articulo
			and    deposito = 'S'
			and    almacen_deposito = :var_deposito;
			
			if isnull(pendiente_recibir) then pendiente_recibir = 0 
			
			select sum(cantidad)
			into   :var_facturas
			from   venlifac
			where  empresa   = :codigo_empresa
			and    articulo  = :var_articulo
			and    calidad   = :calidad
			and    consumo_deposito = 'S'
			and    almacen_deposito = :var_deposito			
			and    falbaran between :rot_desde and :rot_hasta;
			
			if isnull(var_facturas) then var_facturas = 0
			
			select sum(cantidad)
			into   :var_albaranes
			from   venlialb
			where  empresa   = :codigo_empresa
			and    articulo  = :var_articulo
			and    calidad   = :calidad
			and    consumo_deposito = 'S'
			and    almacen_deposito = :var_deposito			
			and    falbaran between :rot_desde and :rot_hasta;
			
			if isnull(var_albaranes) then var_albaranes = 0
			
			///////////////
			
			total_rotacion = var_facturas + var_albaranes
			
			media_dias = total_rotacion / dias_rotacion
						
			prevision_ventas   = dias_necesidades * media_dias
			necesidades        = ((dias_necesidades * media_dias) &
										- (var_existencias + pendiente_recibir))
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
			data.object.articulo[donde]                = f_nombre_articulo(codigo_empresa,var_articulo)
			data.object.stock[donde]                   = var_existencias
			data.object.rotacion[donde]                = total_rotacion
			data.object.fabricar[donde]                = necesidades
			data.object.ventas_1[donde]                = ventas_1
			data.object.ventas_2[donde]                = ventas_2
			data.object.ventas_3[donde]                = ventas_3
			data.object.ventas_4[donde]                = ventas_4
			data.object.prevision_ventas[donde]        = prevision_ventas
			data.object.pendiente_recibir[donde]       = pendiente_recibir
			
		end if
	next
end if

destroy articulos

filtro_final = ""
if cbx_conrotacion.checked and not cbx_sinrotacion.checked then
	//Solo articulos con rotacion
	filtro_final =  "rotacion <> 0 or pendiente_recibir <> 0 "
else
	if cbx_sinrotacion.checked and not cbx_conrotacion.checked then
		//Solo articulos sin rotacion
		filtro_final = "rotacion = 0 "
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
string var_deposito

var_deposito = uo_deposito.em_codigo.text

hoy  = today()
mes  = month(hoy)
dia  = day(hoy)
anyo = year(hoy)
mes_final_trimestre = mes - ((trimestre -1) * 3)

if mes_final_trimestre < 1 then
	mes_final_trimestre = 12 + mes_final_trimestre
	anyo_final_trimestre = anyo -1
	final_trimestre = mdy(mes_final_trimestre,dia,anyo_final_trimestre)
else
	final_trimestre = mdy(mes_final_trimestre,dia,anyo)
end if
mes_inicio_trimestre = mes - (trimestre * 3)
if mes_inicio_trimestre < 1 then
	mes_inicio_trimestre = 12 + mes_inicio_trimestre
	anyo_inicio_trimestre = anyo -1
	inicio_trimestre = mdy(mes_inicio_trimestre,dia,anyo_inicio_trimestre)
else
	inicio_trimestre = mdy(mes_inicio_trimestre,dia,anyo)
end if

select sum(cantidad)
into   :ventas
from   venlifac
where  empresa   = :codigo_empresa
and    articulo  = :articulo
and    calidad   = :calidad
and    consumo_deposito = 'S'
and    almacen_deposito = :var_deposito
and    (falbaran > :inicio_trimestre and falbaran <= :final_trimestre);

select sum(cantidad)
into   :ventas_alb
from   venlialb
where  empresa   = :codigo_empresa
and    articulo  = :articulo
and    calidad   = :calidad
and    consumo_deposito = 'S'
and    almacen_deposito = :var_deposito
and    (falbaran > :inicio_trimestre and falbaran <= :final_trimestre);

if isnull(ventas_alb) then ventas_alb = 0

if isnull(ventas) then ventas = 0

return ventas + ventas_alb
end function

event open;call super::open;string    sel,familia,formato
long      indice,total
datastore datos

dw_2.SetTransObject(sqlca)
dw_2.ShareData(dw_1)
This.title = " Consulta de Artículos a Fabricar con Rotación Por Deposito"
//istr_parametros = Message.PowerObjectParm
uo_calidad.em_codigo.text = "1"
uo_calidad.triggerevent("modificado")
uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_formato.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")

sel = "select familia "+&
		"from   venfamdeposito "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"group  by familia"

//datos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	familia = datos.object.familia[indice]	
	uo_familia.dw_marca.insertrow(indice)
	uo_familia.dw_marca.object.marca[indice]  = "S"
	uo_familia.dw_marca.object.codigo[indice] = familia
	uo_familia.dw_marca.object.texto[indice]  = f_nombre_familia(codigo_empresa,familia)
next
uo_familia.st_titulo1.text = "familia"
uo_familia.st_titulo2.text = "Descripción"

destroy datos

sel = "select formato "+&
		"from   venfamfordeposito "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"group  by formato"

//datos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	formato = datos.object.formato[indice]	
	uo_formato.dw_marca.insertrow(indice)
	uo_formato.dw_marca.object.marca[indice]  = "S"
	uo_formato.dw_marca.object.codigo[indice] = formato
	uo_formato.dw_marca.object.texto[indice]  = f_nombre_formato_abr(codigo_empresa,formato)
next
uo_formato.st_titulo1.text = "formato"
uo_formato.st_titulo2.text = "Descripción"

destroy datos

f_activar_campo(em_fechadesde)
end event

on w_con_articulos_fabricar_rotacion_dep.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_2=create dw_2
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.em_fechanecesidades=create em_fechanecesidades
this.st_10=create st_10
this.cbx_inactivos=create cbx_inactivos
this.cbx_conrotacion=create cbx_conrotacion
this.cbx_sinrotacion=create cbx_sinrotacion
this.cb_4=create cb_4
this.cb_5=create cb_5
this.uo_familia=create uo_familia
this.uo_formato=create uo_formato
this.gb_1=create gb_1
this.uo_calidad=create uo_calidad
this.gb_2=create gb_2
this.st_cl=create st_cl
this.gb_3=create gb_3
this.uo_deposito=create uo_deposito
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.em_fechanecesidades
this.Control[iCurrent+11]=this.st_10
this.Control[iCurrent+12]=this.cbx_inactivos
this.Control[iCurrent+13]=this.cbx_conrotacion
this.Control[iCurrent+14]=this.cbx_sinrotacion
this.Control[iCurrent+15]=this.cb_4
this.Control[iCurrent+16]=this.cb_5
this.Control[iCurrent+17]=this.uo_familia
this.Control[iCurrent+18]=this.uo_formato
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.uo_calidad
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.st_cl
this.Control[iCurrent+23]=this.gb_3
this.Control[iCurrent+24]=this.uo_deposito
this.Control[iCurrent+25]=this.gb_4
end on

on w_con_articulos_fabricar_rotacion_dep.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_2)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.em_fechanecesidades)
destroy(this.st_10)
destroy(this.cbx_inactivos)
destroy(this.cbx_conrotacion)
destroy(this.cbx_sinrotacion)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.uo_familia)
destroy(this.uo_formato)
destroy(this.gb_1)
destroy(this.uo_calidad)
destroy(this.gb_2)
destroy(this.st_cl)
destroy(this.gb_3)
destroy(this.uo_deposito)
destroy(this.gb_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_articulos_fabricar_rotacion_dep
integer height = 44
integer taborder = 130
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_articulos_fabricar_rotacion_dep
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_articulos_fabricar_rotacion_dep
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_articulos_fabricar_rotacion_dep
integer x = 2734
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

type dw_1 from u_datawindow_consultas within w_con_articulos_fabricar_rotacion_dep
integer y = 384
integer width = 2857
integer height = 992
integer taborder = 140
string dataobject = "dw_con_articulos_fabricar_rotacion_dep"
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

type cb_2 from commandbutton within w_con_articulos_fabricar_rotacion_dep
event clicked pbm_bnclicked
integer x = 2414
integer y = 284
integer width = 311
integer height = 80
integer taborder = 90
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

type pb_imprimir_preli from upb_imprimir within w_con_articulos_fabricar_rotacion_dep
event clicked pbm_bnclicked
integer x = 2747
integer y = 276
integer height = 92
integer taborder = 100
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

type dw_2 from datawindow within w_con_articulos_fabricar_rotacion_dep
boolean visible = false
integer x = 530
integer y = 372
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "report_con_articulos_fabricar_rotacion_d"
boolean livescroll = true
end type

type st_9 from statictext within w_con_articulos_fabricar_rotacion_dep
integer x = 27
integer y = 292
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

type em_fechadesde from u_em_campo within w_con_articulos_fabricar_rotacion_dep
integer x = 201
integer y = 288
integer height = 72
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_articulos_fabricar_rotacion_dep
integer x = 480
integer y = 292
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

type em_fechahasta from u_em_campo within w_con_articulos_fabricar_rotacion_dep
integer x = 640
integer y = 288
integer height = 72
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechanecesidades from u_em_campo within w_con_articulos_fabricar_rotacion_dep
integer x = 1184
integer y = 288
integer height = 72
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_10 from statictext within w_con_articulos_fabricar_rotacion_dep
integer x = 946
integer y = 292
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

type cbx_inactivos from checkbox within w_con_articulos_fabricar_rotacion_dep
integer x = 827
integer y = 156
integer width = 315
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

type cbx_conrotacion from checkbox within w_con_articulos_fabricar_rotacion_dep
integer x = 14
integer y = 156
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

type cbx_sinrotacion from checkbox within w_con_articulos_fabricar_rotacion_dep
integer x = 439
integer y = 156
integer width = 384
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

type cb_4 from commandbutton within w_con_articulos_fabricar_rotacion_dep
integer x = 1477
integer y = 284
integer width = 311
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;if uo_familia.visible= True then
   uo_familia.visible = False
else
	uo_familia.visible= True
	uo_formato.visible= false
End if
end event

type cb_5 from commandbutton within w_con_articulos_fabricar_rotacion_dep
integer x = 1787
integer y = 284
integer width = 311
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;if uo_formato.visible= True then
   uo_formato.visible = False
else
	uo_familia.visible= false
	uo_formato.visible= true
End if
end event

type uo_familia from u_marca_lista within w_con_articulos_fabricar_rotacion_dep
event destroy ( )
boolean visible = false
integer x = 901
integer y = 372
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type uo_formato from u_marca_lista within w_con_articulos_fabricar_rotacion_dep
event destroy ( )
boolean visible = false
integer x = 1426
integer y = 372
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

type gb_1 from groupbox within w_con_articulos_fabricar_rotacion_dep
integer y = 240
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

type uo_calidad from u_em_campo_2 within w_con_articulos_fabricar_rotacion_dep
event destroy ( )
integer x = 2309
integer y = 288
integer width = 96
integer height = 72
integer taborder = 80
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

type gb_2 from groupbox within w_con_articulos_fabricar_rotacion_dep
integer x = 914
integer y = 240
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

type st_cl from statictext within w_con_articulos_fabricar_rotacion_dep
integer x = 2107
integer y = 292
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

type gb_3 from groupbox within w_con_articulos_fabricar_rotacion_dep
integer x = 1458
integer y = 240
integer width = 1280
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

type uo_deposito from u_em_campo_2 within w_con_articulos_fabricar_rotacion_dep
event destroy ( )
integer x = 1321
integer y = 156
integer width = 1399
integer height = 72
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_deposito.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_depalmacen(codigo_empresa,this.em_codigo.text)
If Trim(this.em_campo.text) = "" then
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_depalmacenes"
ue_titulo     = "AYUDA SELECCION DE ALMACENES"
ue_filtro     = ""

end event

type gb_4 from groupbox within w_con_articulos_fabricar_rotacion_dep
integer x = 1298
integer y = 108
integer width = 1440
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deposito"
end type

