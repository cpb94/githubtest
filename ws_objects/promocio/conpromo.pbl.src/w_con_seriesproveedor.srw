$PBExportHeader$w_con_seriesproveedor.srw
forward
global type w_con_seriesproveedor from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_seriesproveedor
end type
type pb_imprimir from upb_imprimir within w_con_seriesproveedor
end type
type dw_listado from datawindow within w_con_seriesproveedor
end type
type uo_manejo from u_manejo_datawindow within w_con_seriesproveedor
end type
type rb_pendientes from radiobutton within w_con_seriesproveedor
end type
type rb_todos from radiobutton within w_con_seriesproveedor
end type
type cb_continuar from u_boton within w_con_seriesproveedor
end type
type dw_conpromped1 from u_datawindow_consultas within w_con_seriesproveedor
end type
type gb_1 from groupbox within w_con_seriesproveedor
end type
end forward

global type w_con_seriesproveedor from w_int_con_empresa
integer x = 14
integer y = 32
integer width = 2935
integer height = 2136
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
rb_pendientes rb_pendientes
rb_todos rb_todos
cb_continuar cb_continuar
dw_conpromped1 dw_conpromped1
gb_1 gb_1
end type
global w_con_seriesproveedor w_con_seriesproveedor

type variables
String tipo = "P"


end variables

on w_con_seriesproveedor.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.rb_pendientes=create rb_pendientes
this.rb_todos=create rb_todos
this.cb_continuar=create cb_continuar
this.dw_conpromped1=create dw_conpromped1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.rb_pendientes
this.Control[iCurrent+6]=this.rb_todos
this.Control[iCurrent+7]=this.cb_continuar
this.Control[iCurrent+8]=this.dw_conpromped1
this.Control[iCurrent+9]=this.gb_1
end on

on w_con_seriesproveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.rb_pendientes)
destroy(this.rb_todos)
destroy(this.cb_continuar)
destroy(this.dw_conpromped1)
destroy(this.gb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Listado de expositores por Proveedor"
istr_parametros.s_listado        =   "report_seriesproveedor"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
rb_pendientes.checked= TRUE
rb_todos.checked= FALSE


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped1)
end event

event ue_listar;dw_listado.SetFilter("")
dw_listado.Filter()

IF  tipo = "P" Then
    dw_listado.SetFilter("situacion = 'P'")
    dw_listado.Filter()
END IF
dw_listado.retrieve(codigo_empresa)
dw_report = dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_seriesproveedor
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_seriesproveedor
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_seriesproveedor
end type

type pb_1 from upb_salir within w_con_seriesproveedor
integer x = 2711
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_seriesproveedor
integer x = 2715
integer y = 208
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;

Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_seriesproveedor
boolean visible = false
integer x = 64
integer y = 4
integer width = 494
integer height = 264
boolean bringtotop = true
string dataobject = "report_int_asignacion_series"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_seriesproveedor
integer x = 2235
integer y = 160
integer width = 608
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromped1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type rb_pendientes from radiobutton within w_con_seriesproveedor
integer x = 96
integer y = 184
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pdte recibir"
end type

event clicked;rb_pendientes.checked= TRUE
rb_todos.checked= FALSE
tipo= "P"

end event

type rb_todos from radiobutton within w_con_seriesproveedor
integer x = 558
integer y = 184
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

event clicked;rb_pendientes.checked= FALSE
rb_todos.checked= TRUE
tipo= "T"
end event

type cb_continuar from u_boton within w_con_seriesproveedor
integer x = 1001
integer y = 184
integer height = 72
integer taborder = 20
string text = "&Continuar"
end type

event clicked;call super::clicked;dw_conpromped1.SetFilter("")
dw_conpromped1.Filter()

IF  tipo = "P" Then
    dw_conpromped1.SetFilter("situacion='P'")
    dw_conpromped1.Filter()
END IF

dw_conpromped1.Retrieve(codigo_empresa)
end event

type dw_conpromped1 from u_datawindow_consultas within w_con_seriesproveedor
integer x = 37
integer y = 308
integer width = 2825
integer height = 1588
integer taborder = 10
string dataobject = "dw_con_seriesproveedor"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;if row=0 then Return
str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=dw_conpromped1.GetItemString(This.GetRow(),"codigo")
OpenWithParm(wi_mant_promseries,lstr_param)

end event

type gb_1 from groupbox within w_con_seriesproveedor
integer x = 41
integer y = 140
integer width = 1381
integer height = 132
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

