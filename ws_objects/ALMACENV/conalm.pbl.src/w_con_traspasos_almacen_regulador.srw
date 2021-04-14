$PBExportHeader$w_con_traspasos_almacen_regulador.srw
$PBExportComments$Consulta y listado material reservado almacenes reguladores.
forward
global type w_con_traspasos_almacen_regulador from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_traspasos_almacen_regulador
end type
type pb_imprimir_preli from picturebutton within w_con_traspasos_almacen_regulador
end type
type dw_listado from datawindow within w_con_traspasos_almacen_regulador
end type
type uo_1 from u_manejo_datawindow within w_con_traspasos_almacen_regulador
end type
type cb_1 from u_boton within w_con_traspasos_almacen_regulador
end type
type dw_1 from datawindow within w_con_traspasos_almacen_regulador
end type
type dw_2 from datawindow within w_con_traspasos_almacen_regulador
end type
type st_6 from statictext within w_con_traspasos_almacen_regulador
end type
end forward

global type w_con_traspasos_almacen_regulador from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2930
integer height = 1632
string title = "Consulta de Movimientos"
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_1 uo_1
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
st_6 st_6
end type
global w_con_traspasos_almacen_regulador w_con_traspasos_almacen_regulador

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String  compuesto,articulo,nombre_articulo,calidad,nombre_calidad,tipo_pallet,nombre_tipo_pallet,almacen,nombre_almacen,tipo_unidad,referencia,zona,nombre_zona,nombre_unidad,caja,tono
Dec     calibre,pallets,cajas,metros,unidades,existencias,t_cajas,fila,altura,reser,dispo
Integer r,r1,contador


compuesto = "Select articulo,calidad,tonochar,calibre,tipo_pallet,caja,existencias," +&
            "tipo_unidad,almacen,zona,fila,altura From almlinubica Where  almlinubica.empresa = '" + codigo_empresa + "'" + &
				"And    almlinubica.externo = 'N' "
DataStore dw_comodin

//dw_comodin = f_cargar_cursor(compuesto)
f_cargar_cursor_nuevo(compuesto, dw_comodin)

data.SetTransobject(sqlca)
data.retrieve(codigo_empresa)

r1 = dw_comodin.RowCount()
IF r1 = 0 Then 
	destroy dw_comodin
	Return
end if
	
contador = 0
data.SetReDraw(FALSE)
data.Reset()
For r = 1 To r1
	articulo          = dw_comodin.GetItemString(r,"articulo")
	almacen           = dw_comodin.GetItemString(r,"almacen")
	zona              = dw_comodin.GetItemString(r,"zona")
	calidad           = dw_comodin.GetItemString(r,"calidad")
	tipo_unidad       = dw_comodin.GetItemString(r,"tipo_unidad")
	tono              = dw_comodin.GetItemString(r,"tonochar")
	fila              = dw_comodin.GetItemNumber(r,"fila")
	altura            = dw_comodin.GetItemNumber(r,"altura")
   calibre           = dw_comodin.GetItemNumber(r,"calibre")
	referencia = f_componer_ref(articulo,calidad,tono,calibre)
   existencias       = dw_comodin.GetItemNumber(r,"existencias")
	IF IsNUll(existencias) Then existencias = 0

	IF existencias <> 0 Then 
		tipo_pallet   = dw_comodin.GetItemString(r,"tipo_pallet")
		caja          = dw_comodin.GetItemString(r,"caja") 
		dispo = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,referencia,tipo_pallet,caja)
		IF dispo < 0 Then
		reser  = f_reservado_referencia_tipo_pallet_caja(codigo_empresa,referencia,tipo_pallet,caja)
		nombre_unidad = f_nombre_unidad_abr(tipo_unidad)
		nombre_articulo   = f_nombre_articulo(codigo_empresa,articulo)
		nombre_almacen    = f_nombre_almacen(codigo_empresa,almacen)
		nombre_zona       = f_nombre_zona_abr(codigo_empresa,almacen,zona)
		nombre_calidad    = f_nombre_calidad_abr(codigo_empresa,calidad)
		nombre_tipo_pallet = f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
		contador          = contador +1
		data.InsertRow(contador)
		data.SetItem(contador,"articulo",articulo)
		data.SetItem(contador,"calidad",calidad)
		data.SetItem(contador,"dispo",(dispo*-1))
		data.SetItem(contador,"tono",tono)
		data.SetItem(contador,"calibre",calibre)
		data.SetItem(contador,"fila",fila)
		data.SetItem(contador,"reser",reser)
		data.SetItem(contador,"altura",altura)
		data.SetItem(contador,"nombre_articulo",nombre_articulo)
		data.SetItem(contador,"nombre_unidad",nombre_unidad)
		data.SetItem(contador,"nombre_calidad",nombre_calidad)
		data.SetItem(contador,"nombre_almacen",nombre_almacen)
		data.SetItem(contador,"nombre_zona",nombre_zona)
		data.SetItem(contador,"empresa",codigo_empresa)
		data.SetItem(contador,"almacen",almacen)
		data.SetItem(contador,"zona",zona)
		data.SetItem(contador,"tipo_pallet",tipo_pallet)
		data.SetItem(contador,"nombre_tipo_pallet",nombre_tipo_pallet)
		data.SetItem(contador,"caja",caja)
		data.SetItem(contador,"existencias",existencias)
			
		   string cadena
		   cadena=f_calculo_unidades(codigo_empresa,articulo,tipo_pallet,caja,&
		                            0,0,existencias)
		   pallets    =Dec(Mid(cadena,1,6))
		   cajas      =Dec(Mid(cadena,7,6))
		   t_cajas    =Dec(Mid(cadena,13,6))
		 	data.SetItem(contador,"cajas",cajas)
			data.SetItem(contador,"pallets",pallets)
			
			// Material a subir
			cadena=f_calculo_unidades(codigo_empresa,articulo,tipo_pallet,caja,&
		                            0,0,dispo)
		   pallets    =Dec(Mid(cadena,1,6))
		   cajas      =Dec(Mid(cadena,7,6))
		   data.SetItem(contador,"cajas_s",(cajas*-1))
			data.SetItem(contador,"pallets_s",(pallets*-1))
			
		END IF	
	END IF
	f_contador_procesos(r,r1)
Next
destroy dw_comodin
data.SetSort("nombre_articulo")
data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " CONSULTA TRASPASOS ALMACEN REGULADOR"

dw_2.settransobject(SQLCA)




end event

on w_con_traspasos_almacen_regulador.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_1=create uo_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_6
end on

on w_con_traspasos_almacen_regulador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_6)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_traspasos_almacen_regulador
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_traspasos_almacen_regulador
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_traspasos_almacen_regulador
integer x = 32
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_traspasos_almacen_regulador
integer x = 2697
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type pb_imprimir_preli from picturebutton within w_con_traspasos_almacen_regulador
integer x = 2720
integer y = 196
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_traspasos_almacen_regulador
boolean visible = false
integer y = 4
integer width = 270
integer height = 268
string dataobject = "report_con_transpasos_almacen_regulador"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_traspasos_almacen_regulador
event valores pbm_custom01
event destroy ( )
integer x = 2245
integer y = 152
integer taborder = 20
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within w_con_traspasos_almacen_regulador
integer x = 1733
integer y = 200
integer width = 434
integer height = 88
integer taborder = 10
string text = "&Continuar"
end type

event clicked;call super::clicked;f_cargar(dw_1)
end event

type dw_1 from datawindow within w_con_traspasos_almacen_regulador
integer x = 18
integer y = 304
integer width = 2834
integer height = 1116
integer taborder = 40
string dataobject = "dw_con_transpasos_almacen_regulador"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer   linea
linea = dw_1.GetRow()
string var_pallet,var_calidad,var_articulo,referencia,var_tono
dec var_calibre

IF linea = 0 Then   Return

var_calidad  = dw_1.GetItemString(linea,"calidad")
var_pallet   = dw_1.GetItemString(linea,"tipo_pallet")
var_articulo = dw_1.GetItemString(linea,"articulo")
var_tono     = dw_1.GetItemString(linea,"tono")
var_calibre  = dw_1.GetItemNumber(linea,"calibre")
if isnull(var_calidad) then var_calidad =""
if isnull(var_pallet) then var_pallet =""

referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)

dw_2.retrieve(codigo_empresa,referencia)

if dw_2.rowcount() <> 0 then
	dw_2.visible = True
End if
   


end event

type dw_2 from datawindow within w_con_traspasos_almacen_regulador
boolean visible = false
integer x = 18
integer y = 316
integer width = 2834
integer height = 924
integer taborder = 41
boolean titlebar = true
string title = "Reservas del artículo"
string dataobject = "dw_con_reservas_articulos3"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_6 from statictext within w_con_traspasos_almacen_regulador
integer x = 14
integer y = 152
integer width = 3122
integer height = 1288
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

