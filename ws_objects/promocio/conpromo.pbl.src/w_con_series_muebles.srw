$PBExportHeader$w_con_series_muebles.srw
forward
global type w_con_series_muebles from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_con_series_muebles
end type
type dw_listado from datawindow within w_con_series_muebles
end type
type uo_manejo from u_manejo_datawindow within w_con_series_muebles
end type
type cb_continuar from u_boton within w_con_series_muebles
end type
type dw_conpromped1 from u_datawindow_consultas within w_con_series_muebles
end type
type ddlb_1 from dropdownlistbox within w_con_series_muebles
end type
type pb_1 from upb_salir within w_con_series_muebles
end type
end forward

global type w_con_series_muebles from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 2944
integer height = 2172
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
cb_continuar cb_continuar
dw_conpromped1 dw_conpromped1
ddlb_1 ddlb_1
pb_1 pb_1
end type
global w_con_series_muebles w_con_series_muebles

type variables
String tipo = "P",variable



end variables

on w_con_series_muebles.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.cb_continuar=create cb_continuar
this.dw_conpromped1=create dw_conpromped1
this.ddlb_1=create ddlb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_continuar
this.Control[iCurrent+5]=this.dw_conpromped1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.pb_1
end on

on w_con_series_muebles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.cb_continuar)
destroy(this.dw_conpromped1)
destroy(this.ddlb_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Listado situación muebles"
istr_parametros.s_listado        =   "report_seriesproveedor"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromped1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
ddlb_1.text = "Stock"
variable = "S"


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped1)
end event

event ue_listar;String filtro
dw_listado.SetFilter("")
dw_listado.Filter()

CHOOSE CASE ddlb_1.text
	CASE "Stock"
	    filtro = "situacion ='S'"
   CASE "Pedido"
       filtro = "situacion ='P'" 		
	CASE "Reservado"
		 filtro = "situacion ='R'"
	CASE "Todos"
       filtro = ""
END CHOOSE

IF  trim(filtro)<>"" Then
    dw_listado.SetFilter(filtro)
    dw_listado.Filter()
END IF

dw_listado.retrieve(codigo_empresa)
dw_report = dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_series_muebles
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_series_muebles
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_series_muebles
end type

type pb_imprimir from upb_imprimir within w_con_series_muebles
integer x = 2715
integer y = 208
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_series_muebles
boolean visible = false
integer x = 64
integer y = 4
integer width = 494
integer height = 264
boolean bringtotop = true
string dataobject = "report_con_series_muebles"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_series_muebles
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

type cb_continuar from u_boton within w_con_series_muebles
integer x = 599
integer y = 184
integer width = 411
integer height = 92
integer taborder = 30
string text = "&Continuar"
end type

event clicked;call super::clicked;String filtro

dw_conpromped1.SetFilter("")
dw_conpromped1.Filter()

CHOOSE CASE ddlb_1.text
	CASE "Stock"
	    filtro = "situacion ='S'"
   CASE "Pedido"
       filtro = "situacion ='P'" 		
	CASE "Reservado"
		 filtro = "situacion ='R'"
	CASE "Todos"
       filtro = ""
END CHOOSE

IF  trim(filtro)<>"" Then
    dw_conpromped1.SetFilter(filtro)
    dw_conpromped1.Filter()
END IF

dw_conpromped1.Retrieve(codigo_empresa)
end event

type dw_conpromped1 from u_datawindow_consultas within w_con_series_muebles
integer x = 37
integer y = 308
integer width = 2816
integer height = 1612
integer taborder = 20
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

type ddlb_1 from dropdownlistbox within w_con_series_muebles
integer x = 46
integer y = 180
integer width = 539
integer height = 396
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Pedido","Reservado","Stock","Todos"}
end type

type pb_1 from upb_salir within w_con_series_muebles
integer x = 2711
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

