$PBExportHeader$w_reorganizar_pedidos.srw
forward
global type w_reorganizar_pedidos from w_int_con_empresa
end type
type em_cliente from u_em_campo within w_reorganizar_pedidos
end type
type st_nomcliente from statictext within w_reorganizar_pedidos
end type
type cb_generar_nueva from u_boton within w_reorganizar_pedidos
end type
type dw_temporal from datawindow within w_reorganizar_pedidos
end type
type sle_articulo from singlelineedit within w_reorganizar_pedidos
end type
type anyo_orden_filtro from editmask within w_reorganizar_pedidos
end type
type orden_filtro from editmask within w_reorganizar_pedidos
end type
type gb_1 from groupbox within w_reorganizar_pedidos
end type
type gb_2 from groupbox within w_reorganizar_pedidos
end type
type gb_3 from groupbox within w_reorganizar_pedidos
end type
type pb_3 from picturebutton within w_reorganizar_pedidos
end type
type pb_salir from upb_salir within w_reorganizar_pedidos
end type
type dw_detalle from u_datawindow_consultas within w_reorganizar_pedidos
end type
type em_proforma_agrupo from editmask within w_reorganizar_pedidos
end type
type em_anyo_proforma_agrupo from editmask within w_reorganizar_pedidos
end type
type st_1 from statictext within w_reorganizar_pedidos
end type
type em_fecha_proforma_agrupo from editmask within w_reorganizar_pedidos
end type
type st_2 from statictext within w_reorganizar_pedidos
end type
type cb_agrupar from commandbutton within w_reorganizar_pedidos
end type
type em_anyo_proforma_genero from editmask within w_reorganizar_pedidos
end type
type st_3 from statictext within w_reorganizar_pedidos
end type
type em_proforma_genero from editmask within w_reorganizar_pedidos
end type
type st_4 from statictext within w_reorganizar_pedidos
end type
type em_fecha_proforma_genero from editmask within w_reorganizar_pedidos
end type
type cb_generar from commandbutton within w_reorganizar_pedidos
end type
type gb_4 from groupbox within w_reorganizar_pedidos
end type
type gb_5 from groupbox within w_reorganizar_pedidos
end type
end forward

global type w_reorganizar_pedidos from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 5175
integer height = 3156
string pointer = "Arrow!"
em_cliente em_cliente
st_nomcliente st_nomcliente
cb_generar_nueva cb_generar_nueva
dw_temporal dw_temporal
sle_articulo sle_articulo
anyo_orden_filtro anyo_orden_filtro
orden_filtro orden_filtro
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
pb_3 pb_3
pb_salir pb_salir
dw_detalle dw_detalle
em_proforma_agrupo em_proforma_agrupo
em_anyo_proforma_agrupo em_anyo_proforma_agrupo
st_1 st_1
em_fecha_proforma_agrupo em_fecha_proforma_agrupo
st_2 st_2
cb_agrupar cb_agrupar
em_anyo_proforma_genero em_anyo_proforma_genero
st_3 st_3
em_proforma_genero em_proforma_genero
st_4 st_4
em_fecha_proforma_genero em_fecha_proforma_genero
cb_generar cb_generar
gb_4 gb_4
gb_5 gb_5
end type
global w_reorganizar_pedidos w_reorganizar_pedidos

type variables
Dec{0} paso,nueva_ln_pedido
Dec{2} peso, peso_neto
Dec{0}  var_anyo_albaran,veces
Dec{0} control_lineas = 0
Dec{0} lin_alb = 0
String  v_deposito,is_contenedor
String observaciones = "",dni=''
String precinto, matricula,formaenvio,is_remolque
Dec var_albaran[]
Dec var_peso_neto[]
Dec var_peso_bruto[]
Dec var_contador  = 1
dec{2} precio_portes = 0
dec bultos
String is_agencia,is_conductor,conductor 
Dec peso_neto_albaran, peso_bruto_albaran
String observaciones_albaran

str_albaranes_a_generar istr_albaranes_a_generar[],istr_albaranes_a_generar_vacio[]

string is_booking,is_metodo_verificacion_masa_bruta
dec    id_tara_contenedor
int    il_contador_array_albaranes
end variables

forward prototypes
public subroutine f_campos (boolean bool)
public subroutine f_salir ()
public subroutine f_todo ()
public subroutine f_marcar_linea (integer t)
public subroutine f_control_marcar_linea (integer t)
public subroutine f_desmarcar_linea (integer t)
public subroutine f_salir2 ()
public function boolean f_control_ubicaciones (long var_anyo, long var_pedido, long var_linea)
public subroutine f_filtrar ()
end prototypes

public subroutine f_campos (boolean bool);
IF bool Then
	em_cliente.enabled = FALSE
	sle_opcion_orden.enabled = FALSE
	em_cliente.TabOrder = 0
	sle_opcion_orden.TabOrder = 0
ELSE
	em_cliente.enabled = TRUE
	sle_opcion_orden.enabled = TRUE
	em_cliente.TabOrder = 10
	sle_opcion_orden.TabOrder = 20
		f_activar_campo(em_cliente)
END IF
	
IF bool Then 
	paso= 2
ELSE
	paso = 1
END IF
end subroutine

public subroutine f_salir ();integer respuesta

f_campos(FALSE)

dw_detalle.SetRow(1)
end subroutine

public subroutine f_todo ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
Integer Contes

IF dw_detalle.RowCount() = 0 Then Return
FOR t = 1 To dw_detalle.RowCount()
	IF dw_detalle.GetItemString(t,"venliped_situacion") = "F" Then
		//Contes = MessageBox("Antención","Linea a Fabricar "+dw_detalle.GetItemString(t,"venliped_descripcion") , Exclamation!, YesNo!)
		contes = 1
		IF Contes = 1 then
			f_marcar_linea(t)	
		END IF
	ELSE
		f_marcar_linea(t)	
	END IF
NEXT

end subroutine

public subroutine f_marcar_linea (integer t);Dec{4}  num,d,var_cantidad,var_pallets,var_cajas
dec{4}  var_cantidadp,var_palletsp,var_cajasp
dec{4}  var_total_cajas,var_total_cajasp,var_cantidad_facturar
Dec{0}  var_pedido,var_linea,var_anyo
Dec     var_hornos,var_calibre, var_peso_bruto_linea, var_peso_neto_linea
String  var_articulo,var_nombre,var_familia,var_formato,var_modelo,var_calidad,var_tono,var_sector,var_tipo_unidad,var_marcado
String  var_caja,var_tipo_pallet

dw_detalle.AcceptText()
//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo              = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido            = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea             = dw_detalle.GetItemNumber(t,"venliped_linea")
		var_cantidad          = dw_detalle.GetItemNumber(t,"venliped_cantidad")

		var_pallets           = dw_detalle.GetItemNumber(t,"venliped_pallets")
		var_cajas             = dw_detalle.GetItemNumber(t,"venliped_cajas")		
		var_total_cajas       = dw_detalle.GetItemNumber(t,"venliped_total_cajas")		
		var_cantidad_facturar = dw_detalle.GetItemNumber(t,"venliped_cantidad_facturar")
		
		var_peso_bruto_linea = dw_detalle.GetItemNumber(t,"peso_bruto")
		var_peso_neto_linea = dw_detalle.GetItemNumber(t,"peso_neto")
		
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num = 0 Then
			Select cantidad,pallets,cajas,total_cajas
			Into   :var_cantidadp,:var_palletsp,:var_cajasp,:var_total_cajasp
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			// David 
//			IF var_cantidadp < var_cantidad Then
//				f_mensaje("Error en introduccion de datos","La cantidad no puede superar al pedido")
//				dw_detalle.SetItem(t,"venliped_cantidad",var_cantidadp)
//				dw_detalle.SetItem(t,"venliped_pallets",var_palletsp)
//				dw_detalle.SetItem(t,"venliped_cajas",var_cajasp)
//				dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajasp)
//				return
//			END IF
			// Fin David
			if f_control_ubicaciones(var_anyo,var_pedido,var_linea) then
				dw_detalle.SetItem(t,"aux","V")
			else
				dw_detalle.SetItem(t,"aux","R")
			end if
			
			dw_detalle.SetColumn("marcado")
			dw_detalle.SetItem(t,"marcado","X")
			
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"pedido",var_pedido)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"linea",var_linea)
			//dw_temporal.SetItem(d,"cantidad",var_cantidad)
			dw_temporal.object.cantidad[d] = var_cantidad
			dw_temporal.SetItem(d,"pallets",var_pallets)
			dw_temporal.SetItem(d,"cajas",var_cajas)
			dw_temporal.SetItem(d,"total_cajas",var_total_cajas)
			//dw_temporal.SetItem(d,"cantidad_facturar",var_cantidad_facturar)
			dw_temporal.object.cantidad_facturar[d] = var_cantidad_facturar
			dw_temporal.SetItem(d,"peso_bruto",var_peso_bruto_linea)
			dw_temporal.SetItem(d,"peso_neto",var_peso_neto_linea)
		END IF
//END IF

/*
//NO USADO EN NUEVO ALMACEN 01/2014
// Santiago.14/12/00. Movimiento automático de hornos

	var_hornos  = dw_detalle.GetItemNumber(t,"hornos")
	var_marcado = dw_detalle.GetItemString(t,"marcado")
	if var_hornos <> 0 and var_marcado = "X" then
		var_articulo    = dw_detalle.GetItemString(t,"venliped_articulo")
		var_nombre      = dw_detalle.GetItemString(t,"venliped_descripcion")
		var_calidad     = dw_detalle.GetItemString(t,"venliped_calidad")
		var_tono        = dw_detalle.GetItemString(t,"venliped_tonochar")
		var_calibre     = dw_detalle.GetItemNumber(t,"venliped_calibre")
		var_caja        = dw_detalle.GetItemString(t,"venliped_caja")
		var_tipo_unidad = dw_detalle.GetItemString(t,"venliped_tipo_unidad")
		var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		messagebox("Atención","Movimiento de HORNOS "+var_nombre)
		select familia,formato,modelo,sector
		into   :var_familia,:var_formato,:var_modelo,:var_sector
		from   articulos
		where  empresa = :codigo_empresa and
				 codigo  = :var_articulo;
		if not f_entrada_regularizacion(var_hornos,var_articulo,var_calidad,var_tono,var_calibre,var_caja,&
		       var_tipo_unidad,var_tipo_pallet,var_familia,var_formato,var_modelo,var_sector) then 
			 f_mensaje("Error","No se ha realizado el movimiento automático en almacén")
			 return
		end if
	end if
// Santiago.14/12/00. Movimiento automático de hornos
*/

end subroutine

public subroutine f_control_marcar_linea (integer t);Dec num,d
Dec{0}  var_pedido,var_linea,var_anyo
String articulo, oc_finalizada, unidad
Dec metroscaja
Int piezascaja
dw_detalle.AcceptText()
IF dw_detalle.GetItemString(t,"venliped_situacion") = "F" Then
	//messagebox("Atención","Linea a Fabricar "+dw_detalle.GetItemString(t,"venliped_descripcion"))
END IF
//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
IF dw_detalle.GetItemString(t,"marcado")= "" Then

	var_anyo        = dw_detalle.GetItemNumber(t,"venliped_anyo")
	var_pedido      = dw_detalle.GetItemNumber(t,"venliped_pedido")
	var_linea       = dw_detalle.GetItemNumber(t,"venliped_linea")
	articulo = dw_detalle.GetItemString(t,"venliped_articulo")
		
	oc_finalizada = ""
	SELECT orden_carga.finalizada INTO :oc_finalizada FROM orden_carga INNER JOIN orden_carga_linea ON orden_carga.empresa = orden_carga_linea.empresa AND orden_carga.anyo = orden_carga_linea.anyo AND orden_carga.codigo = orden_carga_linea.codigo 
	WHERE orden_carga_linea.empresa = :codigo_empresa AND orden_carga_linea.venliped_anyo = :var_anyo AND orden_carga_linea.venliped_pedido = :var_pedido AND orden_carga_linea.venliped_linea = :var_linea;
	
	SELECT articulos.unidad, almarcajas.metroscaja, almarcajas.piezascaja INTO :unidad, :metroscaja, :piezascaja
	FROM articulos 
	INNER JOIN almarcajas ON almartcajas.empresa = articulos.empresa AND almartcajas.articulo = articulos.codigo  AND almartcajas.pordefecto = 'S' 
	WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :articulo;
	if isnull(piezascaja) then piezascaja = 0
	if isnull(metroscaja) then metroscaja = 0
	
	if oc_finalizada = "N" then
		MessageBox("Error", "No puede expedir el artículo "+articulo+" que esté en una orden de carga sin finalizar. Contacte con almacén.")
	else
		if unidad = "1" AND piezascaja = 0 and metroscaja = 0 then
			MessageBox("Error", "Debe indicar los metros caja y las piezas caja del artículo "+articulo)
		else
			f_marcar_linea(t)
		end if
	end if
	
ELSE
	f_desmarcar_linea(t)
END IF
//END IF


end subroutine

public subroutine f_desmarcar_linea (integer t);Dec num,d,var_cantidad,var_pallets,var_cajas,var_total_cajas,var_cantidad_facturar
Dec{0}  var_pedido,var_linea,var_anyo
Dec     var_hornos,var_calibre
String  var_articulo,var_nombre,var_familia,var_formato,var_modelo,var_calidad,var_tono,var_sector,var_tipo_unidad,var_marcado
String  var_caja,var_tipo_pallet

// Santiago.14/12/00. Movimiento automático de hornos
	var_hornos  = dw_detalle.GetItemNumber(t,"hornos")
	var_marcado = dw_detalle.GetItemString(t,"marcado")
	if var_hornos <> 0 and var_marcado = "X" then
		var_articulo    = dw_detalle.GetItemString(t,"venliped_articulo")
		var_nombre      = dw_detalle.GetItemString(t,"venliped_descripcion")
		var_calidad     = dw_detalle.GetItemString(t,"venliped_calidad")
		var_tono        = dw_detalle.GetItemString(t,"venliped_tonochar")
		var_calibre     = dw_detalle.GetItemNumber(t,"venliped_calibre")
		var_caja        = dw_detalle.GetItemString(t,"venliped_caja")
		var_tipo_unidad = dw_detalle.GetItemString(t,"venliped_tipo_unidad")
		var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		messagebox("Atención","Movimiento de HORNOS "+var_nombre)
		select familia,formato,modelo,sector
		into   :var_familia,:var_formato,:var_modelo,:var_sector
		from   articulos
		where  empresa = :codigo_empresa and
				 codigo  = :var_articulo;

		dw_detalle.SetItem(t,"hornos",0)
	end if
// Santiago.14/12/00. Movimiento automático de hornos

//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo   = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea  = dw_detalle.GetItemNumber(t,"venliped_linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num <>0 Then
			Select cantidad,
			       pallets,
					 cajas,
					 total_cajas,
					 cantidad_facturar
			Into   :var_cantidad,
			       :var_pallets,
					 :var_cajas,
					 :var_total_cajas,
					 :var_cantidad_facturar
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			dw_temporal.DeleteRow(num)
			dw_detalle.SetItem(t,"marcado","")
			dw_detalle.SetItem(t,"aux","")
			dw_detalle.SetItem(t,"venliped_cantidad",var_cantidad)
			dw_detalle.SetItem(t,"venliped_pallets",var_pallets)
			dw_detalle.SetItem(t,"venliped_cajas",var_cajas)
			dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajas)
			dw_detalle.SetItem(t,"venliped_cantidad_facturar",var_cantidad_facturar)
		END IF
//END IF





end subroutine

public subroutine f_salir2 ();integer respuesta

f_campos(FALSE)

respuesta = MessageBox("Atención", "¿Quieres desmarcar las lineas? ", Exclamation!, YesNo!, 2)
IF respuesta = 1 THEN
 	dw_temporal.Reset()
	var_contador = 1
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
END IF
dw_detalle.SetRow(1)
end subroutine

public function boolean f_control_ubicaciones (long var_anyo, long var_pedido, long var_linea);/*
String ubicacion_aux

Select almlinubica.ubicacion
into   :ubicacion_aux
From   almlinubica
Where  almlinubica.empresa = :codigo_empresa
And    almlinubica.anyo    = :var_anyo
And    almlinubica.pedido  = :var_pedido
And    almlinubica.linped  = :var_linea;
if isnull(ubicacion_aux) or trim(ubicacion_aux)="" then
	return false
else
	return true
end if
*/
//Almacen Nuevo - No se reserva para pedidos nada
return false
			
end function

public subroutine f_filtrar ();string filtro

dw_detalle.setredraw(false)
dw_detalle.setfilter('')
dw_detalle.Filter()

filtro = " 1 = 1 "

if not isnull(orden_filtro.text) and orden_filtro.text <> '' and not isnull(anyo_orden_filtro.text) and anyo_orden_filtro.text <> '' then
	filtro = filtro + upper (" and venliped_anyo = "+anyo_orden_filtro.text+" and venliped_pedido = "+orden_filtro.text+" ")
end if

if not isnull(sle_articulo.text) and sle_articulo.text <> '' then
	filtro = filtro + upper (" and venliped_descripcion like '%"+sle_articulo.text+"%'")
end if

dw_detalle.setfilter(filtro)
dw_detalle.Filter()
dw_detalle.setredraw(true)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Reorganización de pedidos"
This.title=istr_parametros.s_titulo_ventana
paso = 1
//em_fecha.text = String(Today(),"dd-mm-yy")

dw_detalle.SetTransObject(SQLCA)

//dw_etiqueta_agencia.settransobject(sqlca)
//f_mascara_columna(dw_detalle,"venliped_cantidad",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"venliped_cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"venliped_pallets",f_mascara_decimales(0))
f_activar_campo(em_cliente)

anyo_orden_filtro.text = String(Year(Today()))
em_anyo_proforma_genero.text  = String(Year(Today()),em_anyo_proforma_genero.mask)
em_fecha_proforma_genero.text = String(Today(),em_fecha_proforma_genero.mask)


end event

on w_reorganizar_pedidos.create
int iCurrent
call super::create
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.cb_generar_nueva=create cb_generar_nueva
this.dw_temporal=create dw_temporal
this.sle_articulo=create sle_articulo
this.anyo_orden_filtro=create anyo_orden_filtro
this.orden_filtro=create orden_filtro
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.pb_3=create pb_3
this.pb_salir=create pb_salir
this.dw_detalle=create dw_detalle
this.em_proforma_agrupo=create em_proforma_agrupo
this.em_anyo_proforma_agrupo=create em_anyo_proforma_agrupo
this.st_1=create st_1
this.em_fecha_proforma_agrupo=create em_fecha_proforma_agrupo
this.st_2=create st_2
this.cb_agrupar=create cb_agrupar
this.em_anyo_proforma_genero=create em_anyo_proforma_genero
this.st_3=create st_3
this.em_proforma_genero=create em_proforma_genero
this.st_4=create st_4
this.em_fecha_proforma_genero=create em_fecha_proforma_genero
this.cb_generar=create cb_generar
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_cliente
this.Control[iCurrent+2]=this.st_nomcliente
this.Control[iCurrent+3]=this.cb_generar_nueva
this.Control[iCurrent+4]=this.dw_temporal
this.Control[iCurrent+5]=this.sle_articulo
this.Control[iCurrent+6]=this.anyo_orden_filtro
this.Control[iCurrent+7]=this.orden_filtro
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.pb_3
this.Control[iCurrent+12]=this.pb_salir
this.Control[iCurrent+13]=this.dw_detalle
this.Control[iCurrent+14]=this.em_proforma_agrupo
this.Control[iCurrent+15]=this.em_anyo_proforma_agrupo
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.em_fecha_proforma_agrupo
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.cb_agrupar
this.Control[iCurrent+20]=this.em_anyo_proforma_genero
this.Control[iCurrent+21]=this.st_3
this.Control[iCurrent+22]=this.em_proforma_genero
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.em_fecha_proforma_genero
this.Control[iCurrent+25]=this.cb_generar
this.Control[iCurrent+26]=this.gb_4
this.Control[iCurrent+27]=this.gb_5
end on

on w_reorganizar_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.cb_generar_nueva)
destroy(this.dw_temporal)
destroy(this.sle_articulo)
destroy(this.anyo_orden_filtro)
destroy(this.orden_filtro)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.pb_3)
destroy(this.pb_salir)
destroy(this.dw_detalle)
destroy(this.em_proforma_agrupo)
destroy(this.em_anyo_proforma_agrupo)
destroy(this.st_1)
destroy(this.em_fecha_proforma_agrupo)
destroy(this.st_2)
destroy(this.cb_agrupar)
destroy(this.em_anyo_proforma_genero)
destroy(this.st_3)
destroy(this.em_proforma_genero)
destroy(this.st_4)
destroy(this.em_fecha_proforma_genero)
destroy(this.cb_generar)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;
f_cursor_arriba(dw_detalle)

end event

event ue_cursor_abajo;call super::ue_cursor_abajo;	f_cursor_abajo(dw_detalle)

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;
	f_pagina_abajo(dw_detalle)

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;
	f_pagina_arriba(dw_detalle)

end event

event activate;call super::activate;w_expedir_pedidos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_reorganizar_pedidos
integer x = 82
integer y = 1268
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_reorganizar_pedidos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_reorganizar_pedidos
integer x = 55
integer y = 16
integer width = 4539
integer height = 80
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
end type

type em_cliente from u_em_campo within w_reorganizar_pedidos
integer x = 82
integer y = 172
integer width = 224
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;Int bloqueada_expedicion

st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF
//dw_consulta.Retrieve(codigo_empresa,em_cliente.text)

sle_articulo.text = ""
anyo_orden_filtro.text = String(Year(Today()))
orden_filtro.text = ""

dw_detalle.setfilter("")
dw_detalle.filter()
dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
dw_detalle.SetRow(1)
//dw_temporal.Reset()
em_proforma_genero.text = ''

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_reorganizar_pedidos
integer x = 325
integer y = 172
integer width = 1746
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type cb_generar_nueva from u_boton within w_reorganizar_pedidos
integer x = 4713
integer width = 288
integer height = 124
integer taborder = 0
string text = "Generar"
end type

event clicked;string cadena
int  posi_aux,posi
long ll_total_marcado,ll_indice,ll_total,ll_ultima_linea_pedido,ll_ultima_linea_albaran,ll_ultima_linea_factura,ll_nueva_linea
long ll_anyo_pedido_original,ll_pedido_original,ll_linea_pedido_original,ll_lineas_pedido
dec  ld_cantidad,cantidad_actualizar
boolean lb_correcto = true
str_venped lstr_venped
str_venliped lstr_venliped

ll_total_marcado = dw_temporal.RowCount()

if ll_total_marcado = 0 or isnull(ll_total_marcado) then
	messagebox("Atención","No hay nada marcado")
	return
end if

ll_total = dw_detalle.RowCount()

For ll_indice = 1 to ll_total
	IF dw_detalle.object.marcado[ll_indice] = "X" Then
		ll_anyo_pedido_original  = dw_detalle.object.venliped_anyo[ll_indice]
		ll_pedido_original       = dw_detalle.object.venliped_pedido[ll_indice]
		ll_linea_pedido_original = dw_detalle.object.venliped_linea[ll_indice]
		
		lstr_venliped.empresa  = codigo_empresa
		lstr_venliped.anyo     = dw_detalle.object.venliped_anyo[ll_indice]
		lstr_venliped.pedido   = dw_detalle.object.venliped_pedido[ll_indice]
		lstr_venliped.linea    = dw_detalle.object.venliped_linea[ll_indice]
		ld_cantidad            = dw_detalle.object.venliped_cantidad[ll_indice]
		
		if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then
			if ld_cantidad < lstr_venliped.cantidad then		
				if f_dividir_linea_venliped (lstr_venliped.empresa, lstr_venliped.anyo, lstr_venliped.pedido, lstr_venliped.linea, ld_cantidad) = 0 then
					lb_correcto = false
				else
					//Volvemos a leer los datos de la linea para recoger los nuevos valores de la linea dividida
					if not(f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped)) then
						lb_correcto = false
					end if
				end if		
			end if			
			
			if dec(em_proforma_genero.text) = 0 then
				if f_cargar_str_venped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venped) then
					lstr_venped.fpedido = datetime(date(em_fecha_proforma_genero.text))
					lstr_venped.anyo    = year(date(lstr_venped.fpedido))
					
					//Nuevo pedido
					long registros
					str_colisiones param_colisiones
					transaction transaccion
								
					lstr_venped.usuario_pedido = nombre_usuario
					
					f_crear_transaccion(transaccion,"","",false,"TS","")
					
					param_colisiones.empresa = codigo_empresa
					param_colisiones.tabla = "venparamped"
					param_colisiones.campo = "pedido"
					param_colisiones.filtro =  "anyo = "+string(lstr_venped.anyo)
					param_colisiones.buscar_huecos = false
					
					CONNECT USING transaccion;
					
					registros = long ( f_colisiones ( transaccion, param_colisiones)) 
					
					UPDATE venparamped
					SET    pedido = :registros  
					WHERE  venparamped.empresa = :codigo_empresa
					And    venparamped.anyo    = :lstr_venped.anyo
					USING transaccion;
					
					COMMIT USING transaccion;
					DISCONNECT USING transaccion;
					
					destroy transaccion
								
					lstr_venped.pedido = registros
					lstr_venped.es_proforma = 'S'
					//Nuevo pedido
					
					if f_insertar_venped(lstr_venped) then					
						em_anyo_proforma_genero.text = string(lstr_venped.anyo,em_anyo_proforma_genero.mask)
						em_proforma_genero.text = string(lstr_venped.pedido,em_proforma_genero.mask)
					else
						messagebox("¡Error!","No se puede insertar la cabecera, no se puede duplicar.")
						lb_correcto = false
					end if
				end if
			end if
			
			lstr_venliped.anyo    = dec(em_anyo_proforma_genero.text)
			lstr_venliped.pedido  = dec(em_proforma_genero.text)
			lstr_venliped.fpedido = datetime(date(em_fecha_proforma_genero.text))
						
			select max(linea)
			into   :ll_ultima_linea_pedido
			from   venliped
			where  empresa = :lstr_venliped.empresa
			and    anyo    = :lstr_venliped.anyo
			and    pedido  = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_pedido) then ll_ultima_linea_pedido = 0
			
			select max(linea_pedido_origen)
			into   :ll_ultima_linea_albaran
			from   venlialb
			where  empresa            = :lstr_venliped.empresa
			and    anyo_pedido_origen = :lstr_venliped.anyo
			and    pedido_origen      = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_albaran) then ll_ultima_linea_albaran = 0				
			
			select max(linea_pedido_origen)
			into   :ll_ultima_linea_factura
			from   venlifac
			where  empresa            = :lstr_venliped.empresa
			and    anyo_pedido_origen = :lstr_venliped.anyo
			and    pedido_origen      = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_factura) then ll_ultima_linea_factura = 0								
			
			ll_nueva_linea = ll_ultima_linea_pedido
			
			if ll_ultima_linea_albaran > ll_nueva_linea then
				ll_nueva_linea = ll_ultima_linea_albaran
			end if
			
			if ll_ultima_linea_factura > ll_nueva_linea then
				ll_nueva_linea = ll_ultima_linea_factura
			end if				
			
			ll_nueva_linea ++
			
			lstr_venliped.linea = ll_nueva_linea			
			
			if f_insertar_venliped(lstr_venliped) then
				//Borramos la linea original
				delete venliped
				where  venliped.empresa = :codigo_empresa 
				and    venliped.anyo    = :ll_anyo_pedido_original
				and    venliped.pedido  = :ll_pedido_original
				and    venliped.linea   = :ll_linea_pedido_original;
				
				if sqlca.sqlcode <> 0 then
					messagebox("¡Error!","No se puede borrar la linea, no se puede duplicar.")
					lb_correcto = false					
				end if
				//Borramos la cabecera del pedido si no tiene lineas
				
				ll_lineas_pedido = 0
				
				select isnull(Count(*),0)
				into  :ll_lineas_pedido 
				from  venliped
				where venliped.empresa = :codigo_empresa 
				and   venliped.anyo    = :ll_anyo_pedido_original 
				and   venliped.pedido  = :ll_pedido_original;
				
				if ll_lineas_pedido = 0 Then
					delete venped
					where  venped.empresa = :codigo_empresa 
					and    venped.anyo    = :ll_anyo_pedido_original 
					and    venped.pedido  = :ll_pedido_original;
					
					if sqlca.sqlcode <> 0 then
						messagebox("¡Error!","No se puede borrar la cabecera, no se puede duplicar.")
						lb_correcto = false					
					end if				
				end if
				
				if not(f_actualizar_linea_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea)) then
					messagebox("¡Error!","No se puede recalcular la linea, no se puede duplicar.")
					lb_correcto = false					
				end if				
				
			else
				messagebox("¡Error!","No se puede insertar la linea, no se puede duplicar.")
				lb_correcto = false
			end if			
			
		end if
		
	end if	
next

if lb_correcto then
	if not(f_actualizar_venpedido(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido)) then
		messagebox("¡Error!","No se puede recalcular la cabecera, no se puede duplicar.")
		lb_correcto = false					
	end if						
end if

if lb_correcto then
	commit;
	dw_temporal.reset()
else
	rollback;
end if


end event

type dw_temporal from datawindow within w_reorganizar_pedidos
boolean visible = false
integer x = 41
integer y = 1392
integer width = 1701
integer height = 660
string dataobject = "dw_expedicion_pedidos3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type sle_articulo from singlelineedit within w_reorganizar_pedidos
integer x = 2181
integer y = 168
integer width = 1737
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;f_filtrar()
end event

type anyo_orden_filtro from editmask within w_reorganizar_pedidos
integer x = 4032
integer y = 168
integer width = 178
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
end type

event modified;f_filtrar()

end event

type orden_filtro from editmask within w_reorganizar_pedidos
integer x = 4229
integer y = 168
integer width = 379
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;f_filtrar()


end event

type gb_1 from groupbox within w_reorganizar_pedidos
integer x = 3986
integer y = 92
integer width = 667
integer height = 192
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proforma"
end type

type gb_2 from groupbox within w_reorganizar_pedidos
integer x = 46
integer y = 96
integer width = 2075
integer height = 192
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cliente"
end type

type gb_3 from groupbox within w_reorganizar_pedidos
integer x = 2135
integer y = 96
integer width = 1833
integer height = 192
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Artículo"
end type

type pb_3 from picturebutton within w_reorganizar_pedidos
integer x = 4805
integer y = 140
integer width = 146
integer height = 128
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = st_nomcliente.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_detalle.Object.DataWindow.Zoom = 67

u_imp.event ue_imprimir(dw_detalle)

destroy u_imp

//dw_detalle.Object.DataWindow.Zoom = 100
end event

type pb_salir from upb_salir within w_reorganizar_pedidos
integer x = 4992
integer y = 140
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
end type

type dw_detalle from u_datawindow_consultas within w_reorganizar_pedidos
integer x = 41
integer y = 304
integer width = 5111
integer height = 2484
integer taborder = 60
string dataobject = "dw_reorganizar_pedidos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec    pallet,cajas,vanyo,vpedido,total_cajas,vlinea
string marcado
long   var_venliped_cantidad,var_hornos,fila
string var_situacion

if GetRow() = 0 tHEN Return
IF f_objeto_datawindow(This) = "todo" Then
	f_todo()
END IF
	
vanyo    = GetItemNumber(GetRow(),"venliped_anyo")
vpedido  = GetItemNumber(GetRow(),"venliped_pedido")
vlinea   = GetItemNumber(GetRow(),"venliped_linea")

IF f_objeto_datawindow(This) = "pallet_text" Then
	SetSort("")
	This.SetSort("venliped_numpalet")
	This.Sort( )
END IF

IF f_objeto_datawindow(This) = "pedido_text" Then
	SetSort("")
	This.SetSort("venliped_anyo,venliped_pedido,venliped_numpallet,venliped_descripcion")
	This.Sort( )
END IF

if row=0 then return
marcado = this.GetItemString(row,"marcado")

if marcado = "X" then
	This.SetTabOrder("venliped_pallets",0)	
	This.SetTabOrder("venliped_cajas",0)
	This.SetTabOrder("venliped_cantidad",0)	
else
	This.SetTabOrder("venliped_pallets",1)	
	This.SetTabOrder("venliped_cajas",2)
	This.SetTabOrder("venliped_cantidad",3)	
End if	

dw_detalle.AcceptText()

COMMIT;
end event

event doubleclicked;IF row = 0 Then Return

f_control_marcar_linea(row)
end event

event retrieveend;call super::retrieveend;Integer t,n
Dec{0}  var_pedido,var_linea,var_anyo,var_cantidad,var_pallets,var_cajas,var_total_cajas
IF RowCount() = 0 Then return
For t = 1 To RowCount()
	var_anyo  = GetItemNumber(t,"venliped_anyo")
	var_pedido = GetItemNumber(t,"venliped_pedido")
	var_linea = GetItemNumber(t,"venliped_linea")
	n =  dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
	IF n<> 0 Then
		SetItem(t,"marcado","X")
		var_cantidad = dw_temporal.GetItemNumber(n,"cantidad")
		var_pallets  = dw_temporal.GetItemNumber(n,"pallets")
		var_cajas    = dw_temporal.GetItemNumber(n,"cajas")
		var_total_cajas    = dw_temporal.GetItemNumber(n,"total_cajas")
		SetItem(t,"venliped_cantidad", var_cantidad)
		SetItem(t,"venliped_pallets",  var_pallets)
		SetItem(t,"venliped_cajas",    var_cajas)
		SetItem(t,"venliped_total_cajas",  var_total_cajas)
	END IF
NEXT




end event

event key;call super::key;Int row
string     cadena,var_articulo,var_tipo_pallet,var_caja,control_pico, var_tipo_unidad
Dec{0}     var_pallets,var_cajas,var_total_cajas,var_pallets_ant
Dec     var_cantidad,var_cantidad_facturar
long       var_anyo,var_pedido,posi,posi_aux

row = GetRow()
if key = KeyTab! Then
	 AccepTtext()
	 var_anyo        =  GetItemNumber(row,"venliped_anyo")
	 var_pedido      =  GetItemNumber(row,"venliped_pedido")
	 var_pallets     =  GetItemNumber(row,"venliped_pallets")
	 var_cajas       =  GetItemNumber(row,"venliped_cajas")
	 var_cantidad    =  GetItemDecimal(row,"venliped_cantidad")
	 var_articulo    =  GetItemString(row,"venliped_articulo")
	 var_tipo_pallet =  GetItemString(row,"venliped_tipo_pallet")
	 var_caja        =  GetItemString(row,"venliped_caja")
	 control_pico    =  GetItemString(row,"venliped_es_pico")
	 var_tipo_unidad    =  GetItemString(row,"venliped_tipo_unidad")
	
 	 if control_pico = "S" then 
		 var_pallets_ant = var_pallets
		 var_pallets = 0
	 End if

	 IF GetColumnName() = "venliped_cantidad" Then 
		var_pallets = 0
		var_cajas   = 0
	 END IF
	 
	 cadena=f_calculo_unidades_tipolin(codigo_empresa,var_articulo,&
										 var_tipo_pallet,var_caja,&
										 var_pallets,&
										 var_cajas,&
										 var_cantidad, var_tipo_unidad)
										 
    posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			var_pallets     = dec(Mid(cadena,1,posi - 1))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			var_cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			var_total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			var_cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
			posi_aux = posi + 1
		end if										 
								  
	 
	 if control_pico = "S" then var_pallets = var_pallets_ant
	 
	 SetItem(row,"venliped_pallets",var_pallets)
	 SetItem(row,"venliped_cajas",var_cajas)
	 SetItem(row,"venliped_total_cajas",var_total_cajas)
	 SetItem(row,"venliped_cantidad",var_cantidad)
	 
	var_cantidad_facturar = var_cantidad 
	
	if f_facturar_metros_reales_venped(codigo_empresa,var_anyo,var_pedido) = "S" then 
		if f_unidad_articulo(codigo_empresa,var_articulo) = "1" then
		var_cantidad_facturar = f_cantidad_facturar_articulo(codigo_empresa,&
											  var_articulo,&
											  var_caja,&
											  var_cantidad)
		end if	 
	end if
	SetItem(row,"venliped_cantidad_facturar",var_cantidad_facturar)
END IF
end event

event itemchanged;call super::itemchanged;string v_separar_bultos
dec piezas_pallet
long fila


select separar_bultos
into :v_separar_bultos
from venclientes
where empresa = :codigo_empresa
and codigo = :em_cliente.text;

dw_detalle.accepttext()
fila = dw_detalle.getrow()
if v_separar_bultos = 'S' then
	piezas_pallet = f_piezas_por_pallet (dw_detalle.object.venliped_articulo[fila], &
								dw_detalle.object.venliped_caja[fila], &
								dw_detalle.object.venliped_tipo_pallet[fila])
								
	if dec(dw_detalle.object.venliped_cantidad[dw_detalle.getrow()]) > piezas_pallet then
		messagebox("ATENCIÓN", "NO SE PUEDE PONER UNA CANTIDAD SUPERIOR A LA DE UN PALLET. ~n            INTRODUCIR UNA NUEVA LÍNEA DE PEDIDO")
	  	dw_detalle.setfocus()
		dw_detalle.SetRow(fila)
	  	dw_detalle.SetColumn("venliped_cantidad")
	end if
end if


end event

type em_proforma_agrupo from editmask within w_reorganizar_pedidos
integer x = 334
integer y = 2864
integer width = 379
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;str_venped lstr_venped

lstr_venped.empresa = codigo_empresa
lstr_venped.anyo    = dec(em_anyo_proforma_agrupo.text)
lstr_venped.pedido  = dec(this.text)

if lstr_venped.anyo <> 0 and lstr_venped.pedido <> 0 then
	
	if f_cargar_str_venped(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido,lstr_venped) then
		if lstr_venped.cliente = em_cliente.text then
			em_fecha_proforma_agrupo.text = string(lstr_venped.fpedido,em_fecha_proforma_agrupo.mask)
		else
			this.text = ""
		end if
	else
		this.text = ""
	end if
end if
end event

type em_anyo_proforma_agrupo from editmask within w_reorganizar_pedidos
integer x = 64
integer y = 2864
integer width = 178
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

event modified;str_venped lstr_venped

lstr_venped.empresa = codigo_empresa
lstr_venped.anyo    = dec(this.text)
lstr_venped.pedido  = dec(em_proforma_agrupo.text)

if lstr_venped.anyo <> 0 and lstr_venped.pedido <> 0 then
	
	if f_cargar_str_venped(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido,lstr_venped) then
		if lstr_venped.cliente = em_cliente.text then
			em_fecha_proforma_agrupo.text = string(lstr_venped.fpedido,em_fecha_proforma_agrupo.mask)
		else
			this.text = ""
		end if
	else
		this.text = ""
	end if
end if
end event

type st_1 from statictext within w_reorganizar_pedidos
integer x = 247
integer y = 2864
integer width = 82
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha_proforma_agrupo from editmask within w_reorganizar_pedidos
integer x = 805
integer y = 2864
integer width = 379
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_reorganizar_pedidos
integer x = 718
integer y = 2864
integer width = 82
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_agrupar from commandbutton within w_reorganizar_pedidos
integer x = 1193
integer y = 2848
integer width = 1376
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agrupar"
end type

event clicked;string cadena
int  posi_aux,posi
long ll_total_marcado,ll_indice,ll_total,ll_ultima_linea_pedido,ll_ultima_linea_albaran,ll_ultima_linea_factura,ll_nueva_linea
long ll_anyo_pedido_original,ll_pedido_original,ll_linea_pedido_original,ll_lineas_pedido
dec  ld_cantidad,cantidad_actualizar
boolean lb_correcto = true
str_venped lstr_venped
str_venliped lstr_venliped

ll_total_marcado = dw_temporal.RowCount()

if ll_total_marcado = 0 or isnull(ll_total_marcado) then
	messagebox("Atención","No hay nada marcado")
	return
end if

lstr_venped.empresa = codigo_empresa
lstr_venped.anyo    = dec(em_anyo_proforma_agrupo.text)
lstr_venped.pedido  = dec(em_proforma_agrupo.text)

if f_cargar_str_venped(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido,lstr_venped) then
	if lstr_venped.cliente = em_cliente.text then
			
		ll_total = dw_detalle.RowCount()
		
		For ll_indice = 1 to ll_total
			IF dw_detalle.object.marcado[ll_indice] = "X" Then
				ll_anyo_pedido_original  = dw_detalle.object.venliped_anyo[ll_indice]
				ll_pedido_original       = dw_detalle.object.venliped_pedido[ll_indice]
				ll_linea_pedido_original = dw_detalle.object.venliped_linea[ll_indice]
				
				lstr_venliped.empresa  = codigo_empresa
				lstr_venliped.anyo     = dw_detalle.object.venliped_anyo[ll_indice]
				lstr_venliped.pedido   = dw_detalle.object.venliped_pedido[ll_indice]
				lstr_venliped.linea    = dw_detalle.object.venliped_linea[ll_indice]
				ld_cantidad            = dw_detalle.object.venliped_cantidad[ll_indice]
				
				if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then
					if ld_cantidad < lstr_venliped.cantidad then		
						if f_dividir_linea_venliped (lstr_venliped.empresa, lstr_venliped.anyo, lstr_venliped.pedido, lstr_venliped.linea, ld_cantidad) = 0 then
							lb_correcto = false
						else
							//Volvemos a leer los datos de la linea para recoger los nuevos valores de la linea dividida
							if not(f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped)) then
								lb_correcto = false
							end if
						end if		
					end if			
										
					lstr_venliped.anyo    = lstr_venped.anyo
					lstr_venliped.pedido  = lstr_venped.pedido
					lstr_venliped.fpedido = lstr_venped.fpedido
								
					select max(linea)
					into   :ll_ultima_linea_pedido
					from   venliped
					where  empresa = :lstr_venliped.empresa
					and    anyo    = :lstr_venliped.anyo
					and    pedido  = :lstr_venliped.pedido;
					
					if isnull(ll_ultima_linea_pedido) then ll_ultima_linea_pedido = 0
					
					select max(linea_pedido_origen)
					into   :ll_ultima_linea_albaran
					from   venlialb
					where  empresa            = :lstr_venliped.empresa
					and    anyo_pedido_origen = :lstr_venliped.anyo
					and    pedido_origen      = :lstr_venliped.pedido;
					
					if isnull(ll_ultima_linea_albaran) then ll_ultima_linea_albaran = 0				
					
					select max(linea_pedido_origen)
					into   :ll_ultima_linea_factura
					from   venlifac
					where  empresa            = :lstr_venliped.empresa
					and    anyo_pedido_origen = :lstr_venliped.anyo
					and    pedido_origen      = :lstr_venliped.pedido;
					
					if isnull(ll_ultima_linea_factura) then ll_ultima_linea_factura = 0								
					
					ll_nueva_linea = ll_ultima_linea_pedido
					
					if ll_ultima_linea_albaran > ll_nueva_linea then
						ll_nueva_linea = ll_ultima_linea_albaran
					end if
					
					if ll_ultima_linea_factura > ll_nueva_linea then
						ll_nueva_linea = ll_ultima_linea_factura
					end if				
					
					ll_nueva_linea ++
					
					lstr_venliped.linea = ll_nueva_linea			
					
					if f_insertar_venliped(lstr_venliped) then
						//Borramos la linea original
						delete venliped
						where  venliped.empresa = :codigo_empresa 
						and    venliped.anyo    = :ll_anyo_pedido_original
						and    venliped.pedido  = :ll_pedido_original
						and    venliped.linea   = :ll_linea_pedido_original;
						
						if sqlca.sqlcode <> 0 then
							messagebox("¡Error!","No se puede borrar la linea, no se puede duplicar.")
							lb_correcto = false					
						end if
						//Borramos la cabecera del pedido si no tiene lineas
						
						ll_lineas_pedido = 0
						
						select isnull(Count(*),0)
						into  :ll_lineas_pedido 
						from  venliped
						where venliped.empresa = :codigo_empresa 
						and   venliped.anyo    = :ll_anyo_pedido_original 
						and   venliped.pedido  = :ll_pedido_original;
						
						if ll_lineas_pedido = 0 Then
							delete venped
							where  venped.empresa = :codigo_empresa 
							and    venped.anyo    = :ll_anyo_pedido_original 
							and    venped.pedido  = :ll_pedido_original;
							
							if sqlca.sqlcode <> 0 then
								messagebox("¡Error!","No se puede borrar la cabecera, no se puede duplicar.")
								lb_correcto = false					
							end if				
						end if
						
						if not(f_actualizar_linea_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea)) then
							messagebox("¡Error!","No se puede recalcular la linea, no se puede duplicar.")
							lb_correcto = false					
						end if				
						
					else
						messagebox("¡Error!","No se puede insertar la linea, no se puede duplicar.")
						lb_correcto = false
					end if			
					
				end if
				
			end if	
		next
		
		if lb_correcto then
			if not(f_actualizar_venpedido(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido)) then
				messagebox("¡Error!","No se puede recalcular la cabecera, no se puede duplicar.")
				lb_correcto = false					
			end if						
		end if
		
		if lb_correcto then
			commit;
			dw_temporal.reset()
			dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
			dw_detalle.SetRow(1)	
		else
			rollback;
		end if
	else
		messagebox("¡Error!","La proforma seleccionada no es del mismo cliente, no se puede duplicar.")
	end if
else
	messagebox("¡Error!","No se puede cargar la cabecera, no se puede duplicar.")
end if
end event

type em_anyo_proforma_genero from editmask within w_reorganizar_pedidos
integer x = 2624
integer y = 2864
integer width = 178
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_3 from statictext within w_reorganizar_pedidos
integer x = 2807
integer y = 2864
integer width = 82
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_proforma_genero from editmask within w_reorganizar_pedidos
integer x = 2894
integer y = 2864
integer width = 379
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_4 from statictext within w_reorganizar_pedidos
integer x = 3278
integer y = 2864
integer width = 82
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha_proforma_genero from editmask within w_reorganizar_pedidos
integer x = 3365
integer y = 2864
integer width = 379
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event modified;
if not(isdate(this.text)) then
	this.text = string(today(),this.mask)	
end if

em_anyo_proforma_genero.text = string(year(date(this.text)),em_anyo_proforma_genero.mask)
end event

type cb_generar from commandbutton within w_reorganizar_pedidos
integer x = 3753
integer y = 2848
integer width = 1376
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;string cadena
int  posi_aux,posi
long ll_total_marcado,ll_indice,ll_total,ll_ultima_linea_pedido,ll_ultima_linea_albaran,ll_ultima_linea_factura,ll_nueva_linea
long ll_anyo_pedido_original,ll_pedido_original,ll_linea_pedido_original,ll_lineas_pedido
dec  ld_cantidad,cantidad_actualizar
boolean lb_correcto = true
str_venped lstr_venped
str_venliped lstr_venliped

ll_total_marcado = dw_temporal.RowCount()

if ll_total_marcado = 0 or isnull(ll_total_marcado) then
	messagebox("Atención","No hay nada marcado")
	return
end if

ll_total = dw_detalle.RowCount()

em_proforma_genero.text = ""

For ll_indice = 1 to ll_total
	IF dw_detalle.object.marcado[ll_indice] = "X" Then
		ll_anyo_pedido_original  = dw_detalle.object.venliped_anyo[ll_indice]
		ll_pedido_original       = dw_detalle.object.venliped_pedido[ll_indice]
		ll_linea_pedido_original = dw_detalle.object.venliped_linea[ll_indice]
		
		lstr_venliped.empresa  = codigo_empresa
		lstr_venliped.anyo     = dw_detalle.object.venliped_anyo[ll_indice]
		lstr_venliped.pedido   = dw_detalle.object.venliped_pedido[ll_indice]
		lstr_venliped.linea    = dw_detalle.object.venliped_linea[ll_indice]
		ld_cantidad            = dw_detalle.object.venliped_cantidad[ll_indice]
		
		if f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped) then
			if ld_cantidad < lstr_venliped.cantidad then		
				if f_dividir_linea_venliped (lstr_venliped.empresa, lstr_venliped.anyo, lstr_venliped.pedido, lstr_venliped.linea, ld_cantidad) = 0 then
					lb_correcto = false
				else
					//Volvemos a leer los datos de la linea para recoger los nuevos valores de la linea dividida
					if not(f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped)) then
						lb_correcto = false
					end if
				end if		
			end if			
			
			if dec(em_proforma_genero.text) = 0 then
				if f_cargar_str_venped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venped) then
					lstr_venped.fpedido = datetime(date(em_fecha_proforma_genero.text))
					lstr_venped.anyo    = year(date(lstr_venped.fpedido))
					
					//Nuevo pedido
					long registros
					str_colisiones param_colisiones
					transaction transaccion
								
					lstr_venped.usuario_pedido = nombre_usuario
					
					f_crear_transaccion(transaccion,"","",false,"TS","")
					
					param_colisiones.empresa = codigo_empresa
					param_colisiones.tabla = "venparamped"
					param_colisiones.campo = "pedido"
					param_colisiones.filtro =  "anyo = "+string(lstr_venped.anyo)
					param_colisiones.buscar_huecos = false
					
					CONNECT USING transaccion;
					
					registros = long ( f_colisiones ( transaccion, param_colisiones)) 
					
					UPDATE venparamped
					SET    pedido = :registros  
					WHERE  venparamped.empresa = :codigo_empresa
					And    venparamped.anyo    = :lstr_venped.anyo
					USING transaccion;
					
					COMMIT USING transaccion;
					DISCONNECT USING transaccion;
					
					destroy transaccion
								
					lstr_venped.pedido = registros
					lstr_venped.es_proforma = 'S'
					//Nuevo pedido
					
					if f_insertar_venped(lstr_venped) then					
						em_anyo_proforma_genero.text = string(lstr_venped.anyo,em_anyo_proforma_genero.mask)
						em_proforma_genero.text = string(lstr_venped.pedido,em_proforma_genero.mask)
					else
						messagebox("¡Error!","No se puede insertar la cabecera, no se puede duplicar.")
						lb_correcto = false
					end if
				end if
			end if
			
			lstr_venliped.anyo    = dec(em_anyo_proforma_genero.text)
			lstr_venliped.pedido  = dec(em_proforma_genero.text)
			lstr_venliped.fpedido = datetime(date(em_fecha_proforma_genero.text))
						
			select max(linea)
			into   :ll_ultima_linea_pedido
			from   venliped
			where  empresa = :lstr_venliped.empresa
			and    anyo    = :lstr_venliped.anyo
			and    pedido  = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_pedido) then ll_ultima_linea_pedido = 0
			
			select max(linea_pedido_origen)
			into   :ll_ultima_linea_albaran
			from   venlialb
			where  empresa            = :lstr_venliped.empresa
			and    anyo_pedido_origen = :lstr_venliped.anyo
			and    pedido_origen      = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_albaran) then ll_ultima_linea_albaran = 0				
			
			select max(linea_pedido_origen)
			into   :ll_ultima_linea_factura
			from   venlifac
			where  empresa            = :lstr_venliped.empresa
			and    anyo_pedido_origen = :lstr_venliped.anyo
			and    pedido_origen      = :lstr_venliped.pedido;
			
			if isnull(ll_ultima_linea_factura) then ll_ultima_linea_factura = 0								
			
			ll_nueva_linea = ll_ultima_linea_pedido
			
			if ll_ultima_linea_albaran > ll_nueva_linea then
				ll_nueva_linea = ll_ultima_linea_albaran
			end if
			
			if ll_ultima_linea_factura > ll_nueva_linea then
				ll_nueva_linea = ll_ultima_linea_factura
			end if				
			
			ll_nueva_linea ++
			
			lstr_venliped.linea = ll_nueva_linea			
			
			if f_insertar_venliped(lstr_venliped) then
				//Borramos la linea original
				delete venliped
				where  venliped.empresa = :codigo_empresa 
				and    venliped.anyo    = :ll_anyo_pedido_original
				and    venliped.pedido  = :ll_pedido_original
				and    venliped.linea   = :ll_linea_pedido_original;
				
				if sqlca.sqlcode <> 0 then
					messagebox("¡Error!","No se puede borrar la linea, no se puede duplicar.")
					lb_correcto = false					
				end if
				//Borramos la cabecera del pedido si no tiene lineas
				
				ll_lineas_pedido = 0
				
				select isnull(Count(*),0)
				into  :ll_lineas_pedido 
				from  venliped
				where venliped.empresa = :codigo_empresa 
				and   venliped.anyo    = :ll_anyo_pedido_original 
				and   venliped.pedido  = :ll_pedido_original;
				
				if ll_lineas_pedido = 0 Then
					delete venped
					where  venped.empresa = :codigo_empresa 
					and    venped.anyo    = :ll_anyo_pedido_original 
					and    venped.pedido  = :ll_pedido_original;
					
					if sqlca.sqlcode <> 0 then
						messagebox("¡Error!","No se puede borrar la cabecera, no se puede duplicar.")
						lb_correcto = false					
					end if				
				end if
				
				if not(f_actualizar_linea_venpedido(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea)) then
					messagebox("¡Error!","No se puede recalcular la linea, no se puede duplicar.")
					lb_correcto = false					
				end if				
				
			else
				messagebox("¡Error!","No se puede insertar la linea, no se puede duplicar.")
				lb_correcto = false
			end if			
			
		end if
		
	end if	
next

if lb_correcto then
	if not(f_actualizar_venpedido(lstr_venped.empresa,lstr_venped.anyo,lstr_venped.pedido)) then
		messagebox("¡Error!","No se puede recalcular la cabecera, no se puede duplicar.")
		lb_correcto = false					
	end if						
end if

if lb_correcto then
	commit;
	dw_temporal.reset()
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
	dw_detalle.SetRow(1)	
else
	rollback;
end if


end event

type gb_4 from groupbox within w_reorganizar_pedidos
integer x = 41
integer y = 2800
integer width = 2551
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Agrupar sobre la proforma:"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_reorganizar_pedidos
integer x = 2601
integer y = 2800
integer width = 2551
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Generar nueva proforma:"
borderstyle borderstyle = styleraised!
end type

