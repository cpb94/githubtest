$PBExportHeader$wi_con_proddetalleformulas.srw
forward
global type wi_con_proddetalleformulas from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_proddetalleformulas
end type
type dw_1 from datawindow within wi_con_proddetalleformulas
end type
type dw_listado from datawindow within wi_con_proddetalleformulas
end type
type pb_imprimir from upb_imprimir within wi_con_proddetalleformulas
end type
type cb_1 from commandbutton within wi_con_proddetalleformulas
end type
type st_1 from statictext within wi_con_proddetalleformulas
end type
type st_2 from statictext within wi_con_proddetalleformulas
end type
type gb_1 from groupbox within wi_con_proddetalleformulas
end type
type em_desde from u_em_campo_2 within wi_con_proddetalleformulas
end type
type em_hasta from u_em_campo_2 within wi_con_proddetalleformulas
end type
type st_3 from statictext within wi_con_proddetalleformulas
end type
type sle_1 from singlelineedit within wi_con_proddetalleformulas
end type
end forward

global type wi_con_proddetalleformulas from w_int_con_empresa
integer width = 3241
integer height = 1808
pb_1 pb_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
cb_1 cb_1
st_1 st_1
st_2 st_2
gb_1 gb_1
em_desde em_desde
em_hasta em_hasta
st_3 st_3
sle_1 sle_1
end type
global wi_con_proddetalleformulas wi_con_proddetalleformulas

on wi_con_proddetalleformulas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.em_desde
this.Control[iCurrent+10]=this.em_hasta
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.sle_1
end on

on wi_con_proddetalleformulas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
destroy(this.sle_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Listado de Formulas"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(em_desde.em_campo)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_proddetalleformulas
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_proddetalleformulas
integer x = 1865
integer y = 64
integer width = 50
integer height = 48
fontcharset fontcharset = ansi!
end type

event getfocus;//f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_proddetalleformulas
integer width = 2811
end type

type pb_1 from upb_salir within wi_con_proddetalleformulas
integer x = 2953
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_1 from datawindow within wi_con_proddetalleformulas
integer x = 9
integer y = 608
integer width = 3113
integer height = 940
boolean bringtotop = true
string dataobject = "dw_con_proddetalleformulas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within wi_con_proddetalleformulas
boolean visible = false
integer x = 2062
integer y = 160
integer width = 329
integer height = 160
boolean bringtotop = true
string dataobject = "report_con_proddetalleformulas"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_proddetalleformulas
event clicked pbm_bnclicked
integer x = 2441
integer y = 464
integer taborder = 0
end type

event clicked;dw_listado.retrieve(codigo_empresa,dec(em_desde.em_codigo.text),dec(em_hasta.em_codigo.text),trim(sle_1.text)+"%")
f_imprimir_datawindow(dw_listado)

end event

type cb_1 from commandbutton within wi_con_proddetalleformulas
integer x = 2085
integer y = 464
integer width = 347
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_1.retrieve(codigo_empresa,dec(em_desde.em_codigo.text),dec(em_hasta.em_codigo.text),trim(sle_1.text)+"%")

end event

type st_1 from statictext within wi_con_proddetalleformulas
integer x = 128
integer y = 244
integer width = 151
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "De :"
boolean focusrectangle = false
end type

type st_2 from statictext within wi_con_proddetalleformulas
integer x = 128
integer y = 368
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Hasta :"
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_con_proddetalleformulas
integer x = 69
integer y = 144
integer width = 1970
integer height = 456
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rango :"
end type

type em_desde from u_em_campo_2 within wi_con_proddetalleformulas
event destroy ( )
integer x = 352
integer y = 236
integer width = 1618
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on em_desde.destroy
call u_em_campo_2::destroy
end on

event modificado;em_desde.em_campo.text=f_nombre_formulacion_laboratorio(codigo_empresa,em_desde.em_codigo.text)

IF Trim(em_desde.em_campo.text)="" THEN 
 IF Trim(em_desde.em_codigo.text)<>"" Then em_desde.em_campo.SetFocus()
 em_desde.em_campo.text=""
 em_desde.em_codigo.text=""
END IF






end event

event getfocus;ue_titulo     = "Ayuda seleccion de fórmulass"
ue_datawindow = "dw_ayuda_prodformulaciones"
ue_filtro     = ""

end event

type em_hasta from u_em_campo_2 within wi_con_proddetalleformulas
event destroy ( )
integer x = 352
integer y = 352
integer width = 1623
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on em_hasta.destroy
call u_em_campo_2::destroy
end on

event modificado;em_hasta.em_campo.text=f_nombre_formulacion_laboratorio(codigo_empresa,em_hasta.em_codigo.text)

IF Trim(em_hasta.em_campo.text)="" THEN 
 IF Trim(em_hasta.em_codigo.text)<>"" Then em_hasta.em_campo.SetFocus()
 em_hasta.em_campo.text=""
 em_hasta.em_codigo.text=""
END IF





end event

event getfocus;ue_titulo     = "Ayuda seleccion de fórmulas"
ue_datawindow = "dw_ayuda_prodformulaciones"
ue_filtro     = ""

end event

type st_3 from statictext within wi_con_proddetalleformulas
integer x = 123
integer y = 492
integer width = 622
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Patrón de búsqueda :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within wi_con_proddetalleformulas
integer x = 754
integer y = 476
integer width = 411
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

