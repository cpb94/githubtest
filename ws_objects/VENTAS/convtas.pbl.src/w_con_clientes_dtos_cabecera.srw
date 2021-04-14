$PBExportHeader$w_con_clientes_dtos_cabecera.srw
forward
global type w_con_clientes_dtos_cabecera from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_dtos_cabecera
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_dtos_cabecera
end type
type dw_listado from datawindow within w_con_clientes_dtos_cabecera
end type
type dw_dtoclientes from datawindow within w_con_clientes_dtos_cabecera
end type
type pb_imprimir from upb_imprimir within w_con_clientes_dtos_cabecera
end type
type cb_1 from commandbutton within w_con_clientes_dtos_cabecera
end type
type tipo from dropdownlistbox within w_con_clientes_dtos_cabecera
end type
end forward

global type w_con_clientes_dtos_cabecera from w_int_con_empresa
integer width = 2907
integer height = 2104
pb_1 pb_1
uo_manejo uo_manejo
dw_listado dw_listado
dw_dtoclientes dw_dtoclientes
pb_imprimir pb_imprimir
cb_1 cb_1
tipo tipo
end type
global w_con_clientes_dtos_cabecera w_con_clientes_dtos_cabecera

type variables
string filtro
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String serie1,serie2
IF tipo.text = "Nacional"    Then 
	serie1 = "1"
	serie2 = "1"
END IF
IF tipo.text = "Exportacion" Then 
	serie1 = "2"
	serie2 = "2"
END IF
IF tipo.text = "Todos"       Then 
	serie1 = "."
	serie2 = "Z"
END IF


data.Retrieve(codigo_empresa,serie1,serie2)

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Clientes descuentos cabecera"
This.title=istr_parametros.s_titulo_ventana

dw_dtoclientes.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)



end event

on w_con_clientes_dtos_cabecera.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado=create dw_listado
this.dw_dtoclientes=create dw_dtoclientes
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.tipo=create tipo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_dtoclientes
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.tipo
end on

on w_con_clientes_dtos_cabecera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado)
destroy(this.dw_dtoclientes)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.tipo)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_dtoclientes)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_dtoclientes)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_dtoclientes)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_dtoclientes)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_dtos_cabecera
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_dtos_cabecera
integer taborder = 20
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_dtos_cabecera
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_clientes_dtos_cabecera
integer x = 2729
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type uo_manejo from u_manejo_datawindow within w_con_clientes_dtos_cabecera
integer x = 2254
integer y = 132
integer width = 613
end type

event valores;call super::valores;dw_data=dw_dtoclientes


end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_clientes_dtos_cabecera
boolean visible = false
integer x = 69
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_dtos_cabecera"
boolean livescroll = true
end type

type dw_dtoclientes from datawindow within w_con_clientes_dtos_cabecera
integer y = 276
integer width = 2857
integer height = 1592
string dataobject = "dw_con_clientes_dtos_cabecera"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="wi_con_clientes_agente"
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_clientes_dtos_cabecera
integer x = 2734
integer y = 176
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type cb_1 from commandbutton within w_con_clientes_dtos_cabecera
event clicked pbm_bnclicked
integer x = 773
integer y = 176
integer width = 325
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_cargar(dw_dtoclientes)
end event

type tipo from dropdownlistbox within w_con_clientes_dtos_cabecera
integer y = 176
integer width = 763
integer height = 368
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Todos"
boolean vscrollbar = true
string item[] = {"Nacional","Exportacion","Todos"}
end type

