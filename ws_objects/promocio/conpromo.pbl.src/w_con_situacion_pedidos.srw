$PBExportHeader$w_con_situacion_pedidos.srw
forward
global type w_con_situacion_pedidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_situacion_pedidos
end type
type pb_imprimir from upb_imprimir within w_con_situacion_pedidos
end type
type dw_listado2 from datawindow within w_con_situacion_pedidos
end type
type uo_manejo from u_manejo_datawindow within w_con_situacion_pedidos
end type
type dw_conpromped2 from datawindow within w_con_situacion_pedidos
end type
type rb_expositor from radiobutton within w_con_situacion_pedidos
end type
type rb_panel from radiobutton within w_con_situacion_pedidos
end type
type rb_todos from radiobutton within w_con_situacion_pedidos
end type
type rb_preparados from radiobutton within w_con_situacion_pedidos
end type
type rb_no_preparados from radiobutton within w_con_situacion_pedidos
end type
type cb_1 from commandbutton within w_con_situacion_pedidos
end type
type rb_no_preparados_sin_imp from radiobutton within w_con_situacion_pedidos
end type
end forward

global type w_con_situacion_pedidos from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 2912
integer height = 2160
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado2 dw_listado2
uo_manejo uo_manejo
dw_conpromped2 dw_conpromped2
rb_expositor rb_expositor
rb_panel rb_panel
rb_todos rb_todos
rb_preparados rb_preparados
rb_no_preparados rb_no_preparados
cb_1 cb_1
rb_no_preparados_sin_imp rb_no_preparados_sin_imp
end type
global w_con_situacion_pedidos w_con_situacion_pedidos

type variables
String tipos,situ
end variables

on w_con_situacion_pedidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado2=create dw_listado2
this.uo_manejo=create uo_manejo
this.dw_conpromped2=create dw_conpromped2
this.rb_expositor=create rb_expositor
this.rb_panel=create rb_panel
this.rb_todos=create rb_todos
this.rb_preparados=create rb_preparados
this.rb_no_preparados=create rb_no_preparados
this.cb_1=create cb_1
this.rb_no_preparados_sin_imp=create rb_no_preparados_sin_imp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_listado2
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.dw_conpromped2
this.Control[iCurrent+6]=this.rb_expositor
this.Control[iCurrent+7]=this.rb_panel
this.Control[iCurrent+8]=this.rb_todos
this.Control[iCurrent+9]=this.rb_preparados
this.Control[iCurrent+10]=this.rb_no_preparados
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.rb_no_preparados_sin_imp
end on

on w_con_situacion_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado2)
destroy(this.uo_manejo)
destroy(this.dw_conpromped2)
destroy(this.rb_expositor)
destroy(this.rb_panel)
destroy(this.rb_todos)
destroy(this.rb_preparados)
destroy(this.rb_no_preparados)
destroy(this.cb_1)
destroy(this.rb_no_preparados_sin_imp)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta situación Pedidos"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped2.SetTransObject(SQLCA)
dw_conpromped2.SetRowFocusIndicator(Hand!)
dw_listado2.SetTransObject(SQLCA)

rb_expositor.checked = True
rb_panel.checked     = False
tipos="2"

rb_preparados.checked    = False
rb_todos.checked         = True
rb_no_preparados.checked = False

situ = "T"

cb_1.TriggerEvent(Clicked!)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped2)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_situacion_pedidos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_situacion_pedidos
integer taborder = 20
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_situacion_pedidos
integer y = 44
integer width = 2139
end type

type pb_1 from upb_salir within w_con_situacion_pedidos
integer x = 2702
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_situacion_pedidos
integer x = 2706
integer y = 216
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;String vtitulo
dw_listado2.SetFilter("")
dw_listado2.Filter()

if tipos="2" then
	vtitulo="Tipo: Expositores. "
else
	vtitulo="Tipo: Paneles. "
end if

CHOOSE CASE situ
	CASE "T"
		vtitulo=vtitulo+"Situación: Todos."
	CASE "P"
		vtitulo=vtitulo+"Situación: Pendientes."		
		dw_listado2.SetFilter("situacion='P'")
      dw_listado2.Filter()	
   CASE "S"
		vtitulo=vtitulo+"Situación: Sin Preparar No Impresos."
		dw_listado2.SetFilter("situacion <>'P' and isnull(flistado)")
		dw_listado2.Filter()
   CASE "N"
		vtitulo=vtitulo+"Situación: Sin Preparar Impresos."		
		dw_listado2.SetFilter("situacion <>'P' and Not isnull(flistado)")
		dw_listado2.Filter()
END CHOOSE

dw_listado2.Retrieve(codigo_empresa,tipos,vtitulo)
f_Imprimir_DataWindow(dw_listado2)
end event

type dw_listado2 from datawindow within w_con_situacion_pedidos
boolean visible = false
integer x = 64
integer width = 494
integer height = 264
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_situacion_pedidos"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_situacion_pedidos
integer x = 2226
integer y = 168
end type

event valores;call super::valores;dw_data=dw_conpromped2

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromped2 from datawindow within w_con_situacion_pedidos
integer x = 18
integer y = 332
integer width = 2821
integer height = 1600
boolean bringtotop = true
string dataobject = "dw_con_situacion_pedidos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;string pedido
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[1]="w_con_conpromped2"
  lstr_param.s_argumentos[2]=String(dw_conpromped2.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromped2.GetItemNumber(This.GetRow(),"pedido"))
  OpenWithParm(w_int_prompedidos,lstr_param)

end event

type rb_expositor from radiobutton within w_con_situacion_pedidos
integer x = 59
integer y = 168
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Expositores"
boolean automatic = false
end type

event clicked;rb_panel.checked     = False
rb_expositor.checked = True

tipos = "2"
cb_1.TriggerEvent(Clicked!)
end event

type rb_panel from radiobutton within w_con_situacion_pedidos
integer x = 59
integer y = 244
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Paneles"
boolean automatic = false
end type

event clicked;rb_expositor.checked = False
rb_panel.checked     = True
tipos = "1"
cb_1.TriggerEvent(Clicked!)
end event

type rb_todos from radiobutton within w_con_situacion_pedidos
integer x = 699
integer y = 176
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean automatic = false
end type

event clicked;rb_no_preparados_sin_imp.checked    = False
rb_preparados.checked    = False
rb_no_preparados.checked = False
rb_todos.checked         = True

situ = "T"
cb_1.TriggerEvent(Clicked!)

end event

type rb_preparados from radiobutton within w_con_situacion_pedidos
integer x = 699
integer y = 248
integer width = 421
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Preparados"
boolean automatic = false
end type

event clicked;rb_no_preparados_sin_imp.checked    = False
rb_no_preparados.checked = False
rb_todos.checked         = False
rb_preparados.checked    = True

situ = "P"
cb_1.TriggerEvent(Clicked!)
end event

type rb_no_preparados from radiobutton within w_con_situacion_pedidos
integer x = 1170
integer y = 176
integer width = 718
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sin preparar impresos "
boolean automatic = false
end type

event clicked;rb_no_preparados_sin_imp.checked    = False
rb_preparados.checked    = False
rb_todos.checked         = False
rb_no_preparados.checked = True

situ = "N"
cb_1.TriggerEvent(Clicked!)
end event

type cb_1 from commandbutton within w_con_situacion_pedidos
boolean visible = false
integer x = 1934
integer y = 208
integer width = 242
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;dw_conpromped2.SetFilter("")
dw_conpromped2.Filter()

CHOOSE CASE situ
	CASE "T"
	CASE "P"
		dw_conpromped2.SetFilter("situacion='P'")
      dw_conpromped2.Filter()	
   CASE "S"
		dw_conpromped2.SetFilter("situacion <>'P' and Isnull(flistado)")
		dw_conpromped2.Filter()
   CASE "N"
		dw_conpromped2.SetFilter("situacion <>'P' and not isnull(flistado)")
		dw_conpromped2.Filter()
END CHOOSE

dw_conpromped2.Retrieve(codigo_empresa,tipos)
end event

type rb_no_preparados_sin_imp from radiobutton within w_con_situacion_pedidos
event clicked pbm_bnclicked
integer x = 1170
integer y = 244
integer width = 741
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sin preparar no impresos"
boolean automatic = false
end type

event clicked;
rb_preparados.checked    = False
rb_todos.checked         = False
rb_no_preparados.checked = False
rb_no_preparados_sin_imp.checked  = True

situ = "S"
cb_1.TriggerEvent(Clicked!)
end event

