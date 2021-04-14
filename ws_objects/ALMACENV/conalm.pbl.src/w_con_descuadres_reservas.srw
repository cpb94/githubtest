$PBExportHeader$w_con_descuadres_reservas.srw
forward
global type w_con_descuadres_reservas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_descuadres_reservas
end type
type dw_1 from datawindow within w_con_descuadres_reservas
end type
type cb_2 from u_boton within w_con_descuadres_reservas
end type
type report from datawindow within w_con_descuadres_reservas
end type
end forward

global type w_con_descuadres_reservas from w_int_con_empresa
integer x = 46
integer y = 16
integer width = 2930
integer height = 2140
pb_1 pb_1
dw_1 dw_1
cb_2 cb_2
report report
end type
global w_con_descuadres_reservas w_con_descuadres_reservas

type variables
String filtro

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
report.settransobject(SQLCA)

end event

on w_con_descuadres_reservas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.report=create report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.report
end on

on w_con_descuadres_reservas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.report)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_descuadres_reservas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_descuadres_reservas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_descuadres_reservas
end type

type pb_1 from upb_salir within w_con_descuadres_reservas
integer x = 2670
integer y = 24
integer height = 124
integer taborder = 0
end type

type dw_1 from datawindow within w_con_descuadres_reservas
event key pbm_dwnkey
integer y = 348
integer width = 2843
integer height = 1564
integer taborder = 30
string dataobject = "dw_con_descuadres_reservar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from u_boton within w_con_descuadres_reservas
integer x = 41
integer y = 228
integer width = 526
integer height = 92
integer taborder = 20
string text = "&Consultar"
end type

event clicked;String sel
Datastore   d
STring vempresa,varticulo,vcalidad,vtipo_pallet,vcaja,vtono
Dec{2} r,r1,contador,vanyo,vpedido,vlinea,vcantidad1,vcantidad2,vcalibre

sel = " Select empresa,anyo,pedido,linea,articulo,calidad,tipo_pallet,caja,tonochar,calibre,cantidad" +&
      " from venliped" +&
		" Where empresa = '"+codigo_empresa +"'" +&
		" And   situacion = 'P'" +&
		" Order by empresa,anyo,pedido,linea"  
contador = 0		

//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)


For r = 1 To d.RowCount()
	vempresa     = d.GetItemSTring(r,"empresa")
	vanyo        = d.GetItemNumber(r,"anyo")
	vpedido      = d.GetItemNumber(r,"pedido")
	vlinea       = d.GetItemNumber(r,"linea")
	vcantidad1   = d.GetItemNumber(r,"cantidad")
	Select Sum(existencias) Into :vcantidad2 from almlinubica
	Where  almlinubica.empresa = :vempresa
	And    almlinubica.anyo    = :vanyo
	And    almlinubica.pedido  = :vpedido
	And    almlinubica.linped   = :vlinea;
	IF IsNull(vcantidad2) Then vcantidad2 = 0
	IF vcantidad1 <> vcantidad2 Then
		vtono        = d.GetItemString(r,"tonochar")
		vcalibre     = d.GetItemNumber(r,"calibre")
		vtipo_pallet = d.GetItemString(r,"tipo_pallet")
		vcaja        = d.GetItemString(r,"caja")
		varticulo    = d.GetItemString(r,"articulo")
		vcalidad     = d.GetItemString(r,"calidad")
		contador = contador +1
		dw_1.InsertRow(contador)
		dw_1.SetItem(contador,"articulo",f_nombre_articulo(vempresa,varticulo))
		dw_1.SetItem(contador,"calidad",f_nombre_calidad_abr(vempresa,vcalidad))
		dw_1.SetItem(contador,"tipo_pallet",f_nombre_pallet_abr(vempresa,vtipo_pallet))
		dw_1.SetItem(contador,"caja",f_nombre_caja_abr(vempresa,vcaja))		
		dw_1.SetItem(contador,"tonochar",vtono)
		dw_1.SetItem(contador,"pedido",vpedido)
		dw_1.SetItem(contador,"linea",vlinea)
		dw_1.SetItem(contador,"calibre",vcalibre)
		dw_1.SetItem(contador,"cantidad_pedido",vcantidad1)
		dw_1.SetItem(contador,"cantidad_almacen",vcantidad2)
		dw_1.SetItem(contador,"diferencia",vcantidad1 - vcantidad2)
		END IF
	f_mensaje_proceso("Procesando pedidos",r,d.RowCount())
Next



sel = " Select empresa,anyo,pedido,linped,articulo,calidad,tipo_pallet,caja,tonochar,calibre,existencias" +&
      " from  almlinubica" +&
		" Where empresa = '"+codigo_empresa +"'" +&
		" And   pedido IS NOT null" +&
		" Order by empresa,anyo,pedido,linped"  
contador = 0		

//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

For r = 1 To d.RowCount()
	vempresa     = d.GetItemSTring(r,"empresa")
	vanyo        = d.GetItemNumber(r,"anyo")
	vpedido      = d.GetItemNumber(r,"pedido")
	vlinea       = d.GetItemNumber(r,"linped")
	vcantidad2   = d.GetItemNumber(r,"existencias")
	Select Sum(cantidad) Into :vcantidad1 from venliped
	Where  venliped.empresa = :vempresa
	And    venliped.anyo    = :vanyo
	And    venliped.pedido  = :vpedido
	And    venliped.linea   = :vlinea;
	IF IsNull(vcantidad1) Then vcantidad1 = 0
	IF vcantidad1 = 0 Then
		vtono        = d.GetItemString(r,"tonochar")
		vcalibre     = d.GetItemNumber(r,"calibre")
		vtipo_pallet = d.GetItemString(r,"tipo_pallet")
		vcaja        = d.GetItemString(r,"caja")
		varticulo    = d.GetItemString(r,"articulo")
		vcalidad     = d.GetItemString(r,"calidad")
		contador = contador +1
		dw_1.InsertRow(contador)
		dw_1.SetItem(contador,"pedido",vpedido)
		dw_1.SetItem(contador,"linea",vlinea)
		dw_1.SetItem(contador,"articulo",f_nombre_articulo(vempresa,varticulo))
		dw_1.SetItem(contador,"calidad",f_nombre_calidad_abr(vempresa,vcalidad))
		dw_1.SetItem(contador,"tipo_pallet",f_nombre_pallet_abr(vempresa,vtipo_pallet))
		dw_1.SetItem(contador,"caja",f_nombre_caja_abr(vempresa,vcaja))		
		dw_1.SetItem(contador,"tonochar",vtono)
		dw_1.SetItem(contador,"calibre",vcalibre)
		dw_1.SetItem(contador,"cantidad_pedido",vcantidad1)
		dw_1.SetItem(contador,"cantidad_almacen",vcantidad2)
		dw_1.SetItem(contador,"diferencia",vcantidad1 - vcantidad2)
		END IF
	f_mensaje_proceso("Procesando ubicaciones",r,d.RowCount())
Next

destroy d
end event

type report from datawindow within w_con_descuadres_reservas
boolean visible = false
integer x = 1189
integer y = 148
integer width = 494
integer height = 164
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_descuadres_articulos"
boolean livescroll = true
end type

