$PBExportHeader$wi_con_articulos.srw
forward
global type wi_con_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_articulos
end type
type dw_1 from datawindow within wi_con_articulos
end type
type dw_listado from datawindow within wi_con_articulos
end type
type pb_imprimir from upb_imprimir within wi_con_articulos
end type
type uo_manejo from u_manejo_datawindow within wi_con_articulos
end type
type gb_2 from groupbox within wi_con_articulos
end type
type gb_1 from groupbox within wi_con_articulos
end type
type em_desde from u_em_campo within wi_con_articulos
end type
type st_1 from statictext within wi_con_articulos
end type
type st_2 from statictext within wi_con_articulos
end type
type em_hasta from u_em_campo within wi_con_articulos
end type
type cb_1 from u_boton within wi_con_articulos
end type
type rb_1 from radiobutton within wi_con_articulos
end type
type rb_2 from radiobutton within wi_con_articulos
end type
end forward

global type wi_con_articulos from w_int_con_empresa
integer width = 2958
integer height = 1640
pb_1 pb_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_manejo uo_manejo
gb_2 gb_2
gb_1 gb_1
em_desde em_desde
st_1 st_1
st_2 st_2
em_hasta em_hasta
cb_1 cb_1
rb_1 rb_1
rb_2 rb_2
end type
global wi_con_articulos wi_con_articulos

on wi_con_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_desde=create em_desde
this.st_1=create st_1
this.st_2=create st_2
this.em_hasta=create em_hasta
this.cb_1=create cb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_desde
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.em_hasta
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.rb_1
this.Control[iCurrent+14]=this.rb_2
end on

on wi_con_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_desde)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_hasta)
destroy(this.cb_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por formato"
istr_parametros.s_listado        =   "report_articulos1"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;String v_desde, v_hasta

if rb_1.checked then
	dw_listado.dataobject = "report_articulos1"
else
	dw_listado.dataobject = "report_articulos2"
end if

dw_listado.SetTransObject(SQLCA)

v_desde = Trim(em_desde.text) + "."
v_hasta = Trim(em_hasta.text) + "Z"

dw_listado.Retrieve(codigo_empresa, v_desde, v_hasta)

dw_report = dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_articulos
end type

type pb_1 from upb_salir within wi_con_articulos
integer x = 2706
integer y = 28
integer height = 116
integer taborder = 0
string picturename = "exit!"
end type

type dw_1 from datawindow within wi_con_articulos
integer x = 32
integer y = 324
integer width = 2807
integer height = 1084
boolean bringtotop = true
string dataobject = "dw_con_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
  OpenWithParm(wi_mant_articulos,lstr_param)

end event

event clicked;String orden
choose case f_objeto_datawindow(This) 
	case "familia_t"
		orden = "familias_descripcion A, formatos_descripcion A,descripcion A"
	case "descripcion_t"
		orden = "descripcion A"
		
end choose

dw_1.SetSort(orden)
dw_listado.SetSort(orden)
dw_1.Sort()
dw_listado.Sort()
end event

type dw_listado from datawindow within wi_con_articulos
boolean visible = false
integer width = 521
integer height = 208
boolean bringtotop = true
string dataobject = "report_articulos1"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_articulos
event clicked pbm_bnclicked
integer x = 2711
integer y = 196
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
end event

type uo_manejo from u_manejo_datawindow within wi_con_articulos
event valores pbm_custom01
integer x = 2231
integer y = 152
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_2 from groupbox within wi_con_articulos
integer x = 937
integer y = 148
integer width = 933
integer height = 172
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421376
long backcolor = 12632256
string text = "Opciones de impresión"
end type

type gb_1 from groupbox within wi_con_articulos
integer x = 32
integer y = 148
integer width = 896
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Iniciales"
end type

type em_desde from u_em_campo within wi_con_articulos
integer x = 270
integer y = 212
integer width = 206
integer height = 88
integer taborder = 10
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type st_1 from statictext within wi_con_articulos
integer x = 87
integer y = 224
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Desde"
boolean focusrectangle = false
end type

type st_2 from statictext within wi_con_articulos
integer x = 503
integer y = 224
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Hasta"
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within wi_con_articulos
integer x = 677
integer y = 212
integer width = 206
integer height = 88
integer taborder = 20
boolean bringtotop = true
end type

type cb_1 from u_boton within wi_con_articulos
integer x = 1883
integer y = 184
integer width = 347
integer height = 116
integer taborder = 30
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;String v_desde, v_hasta

v_desde = Trim(em_desde.text) + "."
v_hasta = Trim(em_hasta.text) + "Z"

dw_1.Retrieve(codigo_empresa, v_desde, v_hasta)
end event

type rb_1 from radiobutton within wi_con_articulos
integer x = 946
integer y = 224
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Repetir Articulos"
boolean checked = true
boolean lefttext = true
end type

type rb_2 from radiobutton within wi_con_articulos
integer x = 1477
integer y = 224
integer width = 366
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "No Repetir"
boolean lefttext = true
end type

