$PBExportHeader$w_con_remesas_completo.srw
$PBExportComments$€ Consulta. Remesas No confirmadas.
forward
global type w_con_remesas_completo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_remesas_completo
end type
type dw_detalle from datawindow within w_con_remesas_completo
end type
type pb_2 from upb_imprimir within w_con_remesas_completo
end type
type ddlb_1 from dropdownlistbox within w_con_remesas_completo
end type
type cb_2 from commandbutton within w_con_remesas_completo
end type
type em_anyo from editmask within w_con_remesas_completo
end type
type st_6 from statictext within w_con_remesas_completo
end type
type st_1 from statictext within w_con_remesas_completo
end type
type dw_listado from datawindow within w_con_remesas_completo
end type
end forward

shared variables
string variable

end variables

global type w_con_remesas_completo from w_int_con_empresa
integer width = 2912
integer height = 2236
pb_1 pb_1
dw_detalle dw_detalle
pb_2 pb_2
ddlb_1 ddlb_1
cb_2 cb_2
em_anyo em_anyo
st_6 st_6
st_1 st_1
dw_listado dw_listado
end type
global w_con_remesas_completo w_con_remesas_completo

type variables
string filtro

string inst_naci


end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Remesas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

ddlb_1.text = "Liquidada"

em_anyo.text = string(year(today()))

if tipo_vista = "Nacional" then
	inst_naci = "N"
else	
	inst_naci = "S"
end if
end event

on w_con_remesas_completo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
this.pb_2=create pb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.em_anyo=create em_anyo
this.st_6=create st_6
this.st_1=create st_1
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.em_anyo
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_listado
end on

on w_con_remesas_completo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
destroy(this.pb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.em_anyo)
destroy(this.st_6)
destroy(this.st_1)
destroy(this.dw_listado)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_remesas_completo
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_remesas_completo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_remesas_completo
integer x = 9
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_remesas_completo
integer x = 2702
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_detalle from datawindow within w_con_remesas_completo
integer x = 9
integer y = 252
integer width = 2834
integer height = 1748
string dataobject = "dw_con_remesas1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)

CASE "text_num"
	dw_detalle.visible = false
	dw_detalle.setsort("banco A,remesa A")
	dw_detalle.sort()
	dw_detalle.groupcalc()
	dw_detalle.visible = true
case "text_fecha"
	dw_detalle.visible = false
	dw_detalle.setsort("banco A,fremesa A")
	dw_detalle.sort()
	dw_detalle.groupcalc()
	dw_detalle.visible = true
end choose
end event

type pb_2 from upb_imprimir within w_con_remesas_completo
event clicked pbm_bnclicked
integer x = 2702
integer y = 128
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
end type

event clicked;call super::clicked;int situ1,situ2

if ddlb_1.text = "Liquidada" then 
	situ1 = 3
	situ2 = 3
else
	situ1 = 0
	situ2 = 2
end if

dw_listado.Retrieve(codigo_empresa,integer(em_anyo.text),inst_naci,situ1,situ2)
dw_listado.groupcalc()



f_imprimir_datawindow(dw_listado)

end event

type ddlb_1 from dropdownlistbox within w_con_remesas_completo
integer x = 1271
integer y = 124
integer width = 544
integer height = 260
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Liquidada","Resto"}
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_con_remesas_completo
integer x = 1902
integer y = 128
integer width = 352
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;int situ1,situ2

if ddlb_1.text = "Liquidada" then 
	situ1 = 3
	situ2 = 3
else
	situ1 = 0
	situ2 = 2
end if

dw_detalle.Retrieve(codigo_empresa,integer(em_anyo.text),inst_naci,situ1,situ2)
dw_detalle.groupcalc()


end event

type em_anyo from editmask within w_con_remesas_completo
integer x = 489
integer y = 124
integer width = 187
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_6 from statictext within w_con_remesas_completo
integer x = 87
integer y = 132
integer width = 379
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año remesa:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_remesas_completo
integer x = 864
integer y = 140
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Situación:"
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_remesas_completo
boolean visible = false
integer x = 18
integer y = 116
integer width = 512
integer height = 116
integer taborder = 1
boolean bringtotop = true
string dataobject = "report_con_remesas1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

