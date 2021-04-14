$PBExportHeader$w_con_conpromped5.srw
$PBExportComments$Consulta por Pais
forward
global type w_con_conpromped5 from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_con_conpromped5
end type
type uo_conpromped2 from u_em_campo_2 within w_con_conpromped5
end type
type pb_1 from upb_salir within w_con_conpromped5
end type
type pb_imprimir from upb_imprimir within w_con_conpromped5
end type
type dw_listado2 from datawindow within w_con_conpromped5
end type
type uo_manejo from u_manejo_datawindow within w_con_conpromped5
end type
type dw_conpromped2 from datawindow within w_con_conpromped5
end type
type ddlb_opcion from dropdownlistbox within w_con_conpromped5
end type
end forward

global type w_con_conpromped5 from w_int_con_empresa
integer width = 2862
integer height = 2008
st_conpromped2 st_conpromped2
uo_conpromped2 uo_conpromped2
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado2 dw_listado2
uo_manejo uo_manejo
dw_conpromped2 dw_conpromped2
ddlb_opcion ddlb_opcion
end type
global w_con_conpromped5 w_con_conpromped5

type variables
String situ
end variables

on w_con_conpromped5.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_conpromped2=create uo_conpromped2
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado2=create dw_listado2
this.uo_manejo=create uo_manejo
this.dw_conpromped2=create dw_conpromped2
this.ddlb_opcion=create ddlb_opcion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_conpromped2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado2
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_conpromped2
this.Control[iCurrent+8]=this.ddlb_opcion
end on

on w_con_conpromped5.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_conpromped2)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado2)
destroy(this.uo_manejo)
destroy(this.dw_conpromped2)
destroy(this.ddlb_opcion)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Pedidos por Pais"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped2.SetTransObject(SQLCA)
dw_conpromped2.SetRowFocusIndicator(Hand!)
dw_listado2.SetTransObject(SQLCA)

ddlb_opcion.text = "Todos"
Situ = "T"

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

event ue_listar;
dw_listado2.SetFilter("")
dw_listado2.Filter()

CHOOSE CASE ddlb_opcion.text
	CASE "Todos"
	CASE "Preparados"
		dw_listado2.SetFilter("situacion='P'")
      dw_listado2.Filter()	
  	CASE "Sin preparar"
		dw_listado2.SetFilter("situacion='C'")
      dw_listado2.Filter()	
   CASE ELSE
		dw_listado2.SetFilter("situacion ='S'")
		dw_listado2.Filter()
END CHOOSE


dw_listado2.Retrieve(codigo_empresa,uo_conpromped2.em_codigo.text)
dw_report =dw_listado2
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_conpromped5
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_conpromped5
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromped2.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_conpromped5
integer y = 44
integer width = 2139
end type

type st_conpromped2 from statictext within w_con_conpromped5
integer x = 32
integer y = 224
integer width = 187
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pais:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_conpromped2 from u_em_campo_2 within w_con_conpromped5
integer x = 242
integer y = 216
integer width = 1111
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromped2.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Paises"
ue_datawindow ="dw_ayuda_paises"
ue_filtro = ""
valor_empresa = FALSE
end event

event modificado;call super::modificado;uo_conpromped2.em_campo.text=f_nombre_pais(uo_conpromped2.em_codigo.text)
If Trim(uo_conpromped2.em_campo.text)="" then
	uo_conpromped2.em_campo.text=""
	uo_conpromped2.em_codigo.text=""
	Return
end if 

dw_conpromped2.SetFilter("")
dw_conpromped2.Filter()

CHOOSE CASE ddlb_opcion.text
	CASE "Todos"
	CASE "Preparados"
		dw_conpromped2.SetFilter("situacion='P'")
      dw_conpromped2.Filter()	
  	CASE "Sin preparar"
		dw_conpromped2.SetFilter("situacion='C'")
      dw_conpromped2.Filter()	
   CASE ELSE
		dw_conpromped2.SetFilter("situacion ='S'")
		dw_conpromped2.Filter()
END CHOOSE

dw_conpromped2.Retrieve(codigo_empresa,uo_conpromped2.em_codigo.text)
end event

type pb_1 from upb_salir within w_con_conpromped5
integer x = 2651
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_con_conpromped5
integer x = 2624
integer y = 216
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_conpromped2.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el Pais")
	  Return
END IF
f_activar_campo(uo_conpromped2.em_campo)
Parent.triggerEvent("ue_listar")
end event

type dw_listado2 from datawindow within w_con_conpromped5
boolean visible = false
integer x = 64
integer y = 8
integer width = 494
integer height = 264
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_conpromped5"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_conpromped5
integer x = 2144
integer y = 168
end type

event valores;call super::valores;dw_data=dw_conpromped2
f_activar_campo(uo_conpromped2.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromped2 from datawindow within w_con_conpromped5
integer x = 50
integer y = 328
integer width = 2738
integer height = 1448
boolean bringtotop = true
string dataobject = "dw_con_conpromped5"
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

type ddlb_opcion from dropdownlistbox within w_con_conpromped5
integer x = 1367
integer y = 216
integer width = 485
integer height = 360
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Todos","Preparados","Sin preparar","Servidos"}
end type

event modified;uo_conpromped2.TriggerEvent("modificado")
end event

