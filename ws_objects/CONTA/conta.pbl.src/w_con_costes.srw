$PBExportHeader$w_con_costes.srw
$PBExportComments$€
forward
global type w_con_costes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_costes
end type
type nivel1 from u_em_campo within w_con_costes
end type
type gb_1 from groupbox within w_con_costes
end type
type cb_consulta from u_boton within w_con_costes
end type
type st_1 from statictext within w_con_costes
end type
type dw_listado from datawindow within w_con_costes
end type
type pb_imprimir_preli from picturebutton within w_con_costes
end type
type uo_tipo2 from u_marca_lista within w_con_costes
end type
type dw_proceso2 from datawindow within w_con_costes
end type
type dw_1 from datawindow within w_con_costes
end type
type gb_cuenta from groupbox within w_con_costes
end type
type em_cuenta1 from u_em_campo within w_con_costes
end type
type st_2 from statictext within w_con_costes
end type
type em_cuenta2 from u_em_campo within w_con_costes
end type
type nivel2 from u_em_campo within w_con_costes
end type
type ejercicio from u_ejercicio within w_con_costes
end type
end forward

global type w_con_costes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2120
string title = "Consulta de Movimientos"
pb_2 pb_2
nivel1 nivel1
gb_1 gb_1
cb_consulta cb_consulta
st_1 st_1
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
gb_cuenta gb_cuenta
em_cuenta1 em_cuenta1
st_2 st_2
em_cuenta2 em_cuenta2
nivel2 nivel2
ejercicio ejercicio
end type
global w_con_costes w_con_costes

type variables
String ante_articulo,retrasos
end variables

event open;call super::open;This.title = " LISTADO PLAN CONTABLE"
dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
nivel1.text = "1"
nivel2.text = "9"
em_cuenta1.text= ""
em_cuenta2.text= ""



end event

on w_con_costes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.nivel1=create nivel1
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.gb_cuenta=create gb_cuenta
this.em_cuenta1=create em_cuenta1
this.st_2=create st_2
this.em_cuenta2=create em_cuenta2
this.nivel2=create nivel2
this.ejercicio=create ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.nivel1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.pb_imprimir_preli
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.em_cuenta1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_cuenta2
this.Control[iCurrent+15]=this.nivel2
this.Control[iCurrent+16]=this.ejercicio
end on

on w_con_costes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.nivel1)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.gb_cuenta)
destroy(this.em_cuenta1)
destroy(this.st_2)
destroy(this.em_cuenta2)
destroy(this.nivel2)
destroy(this.ejercicio)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_costes
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_costes
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_costes
integer y = 16
integer width = 2642
end type

type pb_2 from upb_salir within w_con_costes
integer x = 2725
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type nivel1 from u_em_campo within w_con_costes
integer x = 37
integer y = 224
integer width = 133
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = "À"
end type

type gb_1 from groupbox within w_con_costes
integer x = 5
integer y = 152
integer width = 375
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Nivel"
end type

type cb_consulta from u_boton within w_con_costes
integer x = 1467
integer y = 212
integer width = 334
integer height = 96
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;call super::clicked;Dec niv1,niv2
String cta1,cta2
niv1 = Dec(nivel1.text)
niv2 = Dec(nivel2.text)

cta1 = em_cuenta1.text
cta2 = em_cuenta2.text
IF Trim(cta1) = "" Then cta1 = "."
IF Trim(cta2) = "" Then cta2 = "Z"
dw_1.retrieve(Dec(ejercicio.em_ejercicio.text),codigo_empresa,niv1,niv2,cta1,cta2)
end event

type st_1 from statictext within w_con_costes
integer x = 178
integer y = 204
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_costes
boolean visible = false
integer x = 14
integer y = 72
integer width = 448
integer height = 264
boolean bringtotop = true
string dataobject = "report_con_costes"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_costes
integer x = 1806
integer y = 216
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;Dec niv1,niv2
String cta1,cta2
niv1 = Dec(nivel1.text)
niv2 = Dec(nivel2.text)

cta1 = em_cuenta1.text
cta2 = em_cuenta2.text
IF Trim(cta1) = "" Then cta1 = "."
IF Trim(cta2) = "" Then cta2 = "Z"
dw_listado.retrieve(Dec(ejercicio.em_ejercicio.text),codigo_empresa,niv1,niv2,cta1,cta2)
f_imprimir_datawindow(dw_listado)
end event

type uo_tipo2 from u_marca_lista within w_con_costes
boolean visible = false
integer x = 1435
integer y = 364
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_con_costes
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_costes
integer y = 360
integer width = 2857
integer height = 1548
string dataobject = "dw_con_costes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
  
  OpenWithParm(w_int_contaapun,zstr_param) 

end event

type gb_cuenta from groupbox within w_con_costes
integer x = 416
integer y = 152
integer width = 891
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

type em_cuenta1 from u_em_campo within w_con_costes
integer x = 434
integer y = 224
integer width = 384
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
string mask = ""
string displaydata = "~b"
end type

type st_2 from statictext within w_con_costes
integer x = 837
integer y = 204
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cuenta2 from u_em_campo within w_con_costes
integer x = 882
integer y = 224
integer width = 384
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
string mask = ""
string displaydata = ""
end type

type nivel2 from u_em_campo within w_con_costes
integer x = 229
integer y = 224
integer width = 114
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = "Ä"
end type

type ejercicio from u_ejercicio within w_con_costes
event destroy ( )
integer x = 2208
integer y = 140
integer taborder = 60
end type

on ejercicio.destroy
call u_ejercicio::destroy
end on

