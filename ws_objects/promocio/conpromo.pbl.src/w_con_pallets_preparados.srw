$PBExportHeader$w_con_pallets_preparados.srw
forward
global type w_con_pallets_preparados from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_con_pallets_preparados
end type
type uo_conpromped2 from u_em_campo_2 within w_con_pallets_preparados
end type
type pb_1 from upb_salir within w_con_pallets_preparados
end type
type pb_imprimir from upb_imprimir within w_con_pallets_preparados
end type
type dw_listado2 from datawindow within w_con_pallets_preparados
end type
type uo_manejo from u_manejo_datawindow within w_con_pallets_preparados
end type
type dw_conpromped2 from datawindow within w_con_pallets_preparados
end type
type ddlb_1 from dropdownlistbox within w_con_pallets_preparados
end type
type cb_procesar from u_boton within w_con_pallets_preparados
end type
type ddlb_2 from dropdownlistbox within w_con_pallets_preparados
end type
type st_1 from statictext within w_con_pallets_preparados
end type
end forward

global type w_con_pallets_preparados from w_int_con_empresa
integer width = 2894
integer height = 2052
st_conpromped2 st_conpromped2
uo_conpromped2 uo_conpromped2
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado2 dw_listado2
uo_manejo uo_manejo
dw_conpromped2 dw_conpromped2
ddlb_1 ddlb_1
cb_procesar cb_procesar
ddlb_2 ddlb_2
st_1 st_1
end type
global w_con_pallets_preparados w_con_pallets_preparados

type variables
String situ
end variables

on w_con_pallets_preparados.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_conpromped2=create uo_conpromped2
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado2=create dw_listado2
this.uo_manejo=create uo_manejo
this.dw_conpromped2=create dw_conpromped2
this.ddlb_1=create ddlb_1
this.cb_procesar=create cb_procesar
this.ddlb_2=create ddlb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_conpromped2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado2
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_conpromped2
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.cb_procesar
this.Control[iCurrent+10]=this.ddlb_2
this.Control[iCurrent+11]=this.st_1
end on

on w_con_pallets_preparados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_conpromped2)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado2)
destroy(this.uo_manejo)
destroy(this.dw_conpromped2)
destroy(this.ddlb_1)
destroy(this.cb_procesar)
destroy(this.ddlb_2)
destroy(this.st_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Pedidos por Cliente"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped2.SetTransObject(SQLCA)

dw_listado2.SetTransObject(SQLCA)

ddlb_1.text ="Si" 
ddlb_2.text ="Expositor" 
f_activar_campo(uo_conpromped2.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped2)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pallets_preparados
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pallets_preparados
integer taborder = 50
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromped2.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pallets_preparados
integer y = 44
integer width = 2139
end type

type st_conpromped2 from statictext within w_con_pallets_preparados
integer x = 14
integer y = 208
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_conpromped2 from u_em_campo_2 within w_con_pallets_preparados
integer x = 475
integer y = 204
integer width = 1115
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromped2.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	   uo_conpromped2.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_conpromped2.em_codigo.text)
	else
      uo_conpromped2.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_conpromped2.em_codigo.text)		
End if

If Trim(uo_conpromped2.em_campo.text)="" then
	uo_conpromped2.em_campo.text=""
	uo_conpromped2.em_codigo.text=""
	Return
end if 

end event

type pb_1 from upb_salir within w_con_pallets_preparados
integer x = 2688
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_pallets_preparados
integer x = 2697
integer y = 208
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
String cli1,cli2
If ddlb_1.text="Si" then tipo_cli="S"
IF Trim(uo_conpromped2.em_codigo.text) = "" Then
	cli1 = "."
	cli2 = "Z"
ELSE
	cli1 = uo_conpromped2.em_codigo.text
	cli2 = uo_conpromped2.em_codigo.text
END IF

If ddlb_2.text="Panel" then 
	dw_conpromped2.SetFilter("tipo = '1' ")
	dw_conpromped2.Filter()
else
	dw_conpromped2.SetFilter("tipo = '2' ")
	dw_conpromped2.Filter()
End if


dw_listado2.Retrieve(codigo_empresa,tipo_cli,cli1,cli2)
f_imprimir_datawindow(dw_listado2)
f_activar_campo(uo_conpromped2.em_campo)

end event

type dw_listado2 from datawindow within w_con_pallets_preparados
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_pallets_preparados"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pallets_preparados
integer x = 2217
integer y = 160
end type

event valores;call super::valores;dw_data=dw_conpromped2
f_activar_campo(uo_conpromped2.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromped2 from datawindow within w_con_pallets_preparados
integer x = 27
integer y = 320
integer width = 2784
integer height = 1500
boolean bringtotop = true
string dataobject = "dw_con_pallets_preparados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row=0 then Return
string pedido
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[1]="w_con_conpromped2"
  lstr_param.s_argumentos[2]=String(dw_conpromped2.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromped2.GetItemNumber(This.GetRow(),"pedido"))
  OpenWithParm(w_int_prompedidos,lstr_param)

end event

type ddlb_1 from dropdownlistbox within w_con_pallets_preparados
integer x = 256
integer y = 200
integer width = 210
integer height = 260
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type cb_procesar from u_boton within w_con_pallets_preparados
integer x = 1929
integer y = 208
integer width = 288
integer height = 76
integer taborder = 10
string text = "&Continuar"
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
String cli1,cli2

If ddlb_1.text="Si" then tipo_cli="S"
If ddlb_2.text="Panel" then 
	dw_conpromped2.SetFilter("tipo = '1' ")
	dw_conpromped2.Filter()
else
	dw_conpromped2.SetFilter("tipo = '2' ")
	dw_conpromped2.Filter()
End if

IF Trim(uo_conpromped2.em_codigo.text) = "" Then
	cli1 = "."
	cli2 = "Z"
ELSE
	cli1 = uo_conpromped2.em_codigo.text
	cli2 = uo_conpromped2.em_codigo.text
END IF
dw_conpromped2.Retrieve(codigo_empresa,tipo_cli,cli1,cli2)
f_activar_campo(uo_conpromped2.em_campo)
end event

type ddlb_2 from dropdownlistbox within w_con_pallets_preparados
integer x = 1600
integer y = 200
integer width = 320
integer height = 228
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Panel","Expositor"}
end type

type st_1 from statictext within w_con_pallets_preparados
integer x = 1655
integer y = 152
integer width = 201
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Tipo"
alignment alignment = center!
boolean focusrectangle = false
end type

