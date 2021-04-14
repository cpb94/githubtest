$PBExportHeader$w_con_ubicaciones2.srw
$PBExportComments$Material por ubicación
forward
global type w_con_ubicaciones2 from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ubicaciones2
end type
type dw_proceso from datawindow within w_con_ubicaciones2
end type
type dw_listado from datawindow within w_con_ubicaciones2
end type
type pb_imprimir_preli from picturebutton within w_con_ubicaciones2
end type
type dw_1 from datawindow within w_con_ubicaciones2
end type
type uo_1 from u_manejo_datawindow within w_con_ubicaciones2
end type
type dw_almacenes from datawindow within w_con_ubicaciones2
end type
type dw_zonas from datawindow within w_con_ubicaciones2
end type
type etiqueta1 from statictext within w_con_ubicaciones2
end type
type etiqueta2 from statictext within w_con_ubicaciones2
end type
type etiqueta3 from statictext within w_con_ubicaciones2
end type
type em_pallets from u_em_campo within w_con_ubicaciones2
end type
type em_cajas from u_em_campo within w_con_ubicaciones2
end type
type em_total_cajas from u_em_campo within w_con_ubicaciones2
end type
type etiqueta4 from statictext within w_con_ubicaciones2
end type
type em_cantidad from u_em_campo within w_con_ubicaciones2
end type
end forward

global type w_con_ubicaciones2 from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4498
integer height = 3184
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_1 uo_1
dw_almacenes dw_almacenes
dw_zonas dw_zonas
etiqueta1 etiqueta1
etiqueta2 etiqueta2
etiqueta3 etiqueta3
em_pallets em_pallets
em_cajas em_cajas
em_total_cajas em_total_cajas
etiqueta4 etiqueta4
em_cantidad em_cantidad
end type
global w_con_ubicaciones2 w_con_ubicaciones2

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_zonas ()
public subroutine f_ir ()
public subroutine f_totales ()
end prototypes

public subroutine f_zonas ();String almacen
IF dw_almacenes.GetRow()= 0 Then Return
almacen= dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
dw_zonas.Retrieve(codigo_empresa,almacen)
dw_1.Retrieve(codigo_empresa,almacen)
end subroutine

public subroutine f_ir ();String zona
Integer registro
If dw_zonas.GetRow() = 0 Then Return
zona = dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")
IF dw_1.RowCount()= 0 Then Return
registro = dw_1.find("zona = '" + zona + "'",1,dw_1.RowCount())
dw_1.ScrollToRow(registro)
end subroutine

public subroutine f_totales ();Dec{0} total_cajas,cajas,pallets,registro
Dec{2} cantidad
String  articulo,tipo_pallet,nombre_unidad,var_caja
registro = dw_1.GetRow()
If registro = 0 Then Return

cantidad = dw_1.GetItemNumber(registro,"almlinubica_existencias")
articulo = dw_1.GetItemString(registro,"almlinubica_articulo")
tipo_pallet = dw_1.GetItemString(registro,"almlinubica_tipo_pallet")
nombre_unidad = dw_1.GetItemString(registro,"unidades_abreviado")
var_caja = dw_1.GetItemString(registro,"almlinubica_caja")

pallets = f_calculo_pallets(codigo_empresa,articulo,tipo_pallet,var_caja,cantidad)
cajas   = f_calculo_cajas(codigo_empresa,articulo,tipo_pallet,var_caja,pallets,cantidad)
total_cajas= f_calculo_total_cajas(codigo_empresa,articulo,var_caja,cantidad)


//em_pallets.text     = String(pallets)
//em_cajas.text       = String(cajas)
//em_total_cajas.text = String(total_cajas)
//em_cantidad.text    = String(cantidad)


end subroutine

event ue_listar;String almacen,zona
IF dw_almacenes.GetRow()= 0 Then Return
almacen = dw_almacenes.GetItemString(dw_almacenes.GetRow(),"codigo")
zona    = dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")
dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa,almacen,zona)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_zonas.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_almacenes.SetTransObject(sqlca)
dw_almacenes.SetRowFocusIndicator(Hand!)
dw_1.SetRowFocusIndicator(Hand!)
dw_almacenes.Retrieve(codigo_empresa)

dw_zonas.SetRowFocusIndicator(Hand!)
This.title = " CONSULTA MATERIAL POR UBICACION	"

dw_almacenes.Setfocus()


end event

on w_con_ubicaciones2.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_1=create uo_1
this.dw_almacenes=create dw_almacenes
this.dw_zonas=create dw_zonas
this.etiqueta1=create etiqueta1
this.etiqueta2=create etiqueta2
this.etiqueta3=create etiqueta3
this.em_pallets=create em_pallets
this.em_cajas=create em_cajas
this.em_total_cajas=create em_total_cajas
this.etiqueta4=create etiqueta4
this.em_cantidad=create em_cantidad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_almacenes
this.Control[iCurrent+8]=this.dw_zonas
this.Control[iCurrent+9]=this.etiqueta1
this.Control[iCurrent+10]=this.etiqueta2
this.Control[iCurrent+11]=this.etiqueta3
this.Control[iCurrent+12]=this.em_pallets
this.Control[iCurrent+13]=this.em_cajas
this.Control[iCurrent+14]=this.em_total_cajas
this.Control[iCurrent+15]=this.etiqueta4
this.Control[iCurrent+16]=this.em_cantidad
end on

on w_con_ubicaciones2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.dw_almacenes)
destroy(this.dw_zonas)
destroy(this.etiqueta1)
destroy(this.etiqueta2)
destroy(this.etiqueta3)
destroy(this.em_pallets)
destroy(this.em_cajas)
destroy(this.em_total_cajas)
destroy(this.etiqueta4)
destroy(this.em_cantidad)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubicaciones2
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubicaciones2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubicaciones2
integer x = 27
integer y = 20
integer width = 4334
end type

type pb_2 from upb_salir within w_con_ubicaciones2
integer x = 4251
integer y = 132
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_proceso from datawindow within w_con_ubicaciones2
boolean visible = false
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_ubicaciones2
boolean visible = false
integer x = 2021
integer y = 128
integer width = 201
integer height = 144
boolean bringtotop = true
string dataobject = "report_con_ubicaciones"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_ubicaciones2
integer x = 4261
integer y = 360
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;Parent.TriggerEvent("ue_listar")
end event

type dw_1 from datawindow within w_con_ubicaciones2
integer x = 23
integer y = 528
integer width = 4384
integer height = 2412
integer taborder = 40
string dataobject = "dw_con_ubicaciones_nuevo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;f_totales()
end event

event rowfocuschanged;f_totales()
end event

type uo_1 from u_manejo_datawindow within w_con_ubicaciones2
integer x = 3785
integer y = 316
integer width = 613
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_almacenes from datawindow within w_con_ubicaciones2
integer x = 23
integer y = 124
integer width = 1367
integer height = 384
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_ubicaciones1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event getfocus;This.BorderStyle = StyleLowered!
f_zonas()
end event

event rowfocuschanged;f_zonas()
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type dw_zonas from datawindow within w_con_ubicaciones2
integer x = 1385
integer y = 124
integer width = 631
integer height = 376
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_con_ubicaciones2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event getfocus;This.BorderStyle = StyleLowered!
f_ir()
end event

event rowfocuschanged;f_ir()
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type etiqueta1 from statictext within w_con_ubicaciones2
boolean visible = false
integer x = 663
integer y = 1280
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pallets"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type etiqueta2 from statictext within w_con_ubicaciones2
boolean visible = false
integer x = 937
integer y = 1280
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type etiqueta3 from statictext within w_con_ubicaciones2
boolean visible = false
integer x = 1211
integer y = 1280
integer width = 366
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_pallets from u_em_campo within w_con_ubicaciones2
boolean visible = false
integer x = 663
integer y = 1352
integer width = 270
integer taborder = 0
long textcolor = 128
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
string displaydata = ""
end type

type em_cajas from u_em_campo within w_con_ubicaciones2
boolean visible = false
integer x = 933
integer y = 1352
integer width = 274
integer taborder = 0
boolean bringtotop = true
long textcolor = 128
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
string displaydata = ""
end type

type em_total_cajas from u_em_campo within w_con_ubicaciones2
boolean visible = false
integer x = 1207
integer y = 1352
integer width = 366
integer taborder = 0
boolean bringtotop = true
long textcolor = 128
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
string displaydata = ""
end type

type etiqueta4 from statictext within w_con_ubicaciones2
boolean visible = false
integer x = 1577
integer y = 1280
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_con_ubicaciones2
boolean visible = false
integer x = 1573
integer y = 1352
integer width = 320
integer taborder = 0
boolean bringtotop = true
long textcolor = 128
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

