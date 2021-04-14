$PBExportHeader$w_est_conpromalb_cliente.srw
forward
global type w_est_conpromalb_cliente from w_int_con_empresa
end type
type uo_conpromalb2 from u_em_campo_2 within w_est_conpromalb_cliente
end type
type pb_1 from upb_salir within w_est_conpromalb_cliente
end type
type pb_imprimir from upb_imprimir within w_est_conpromalb_cliente
end type
type dw_listado_conpromalb2 from datawindow within w_est_conpromalb_cliente
end type
type uo_manejo from u_manejo_datawindow within w_est_conpromalb_cliente
end type
type dw_conpromalb2 from datawindow within w_est_conpromalb_cliente
end type
type ddlb_1 from dropdownlistbox within w_est_conpromalb_cliente
end type
type gb_cliente from groupbox within w_est_conpromalb_cliente
end type
type gb_fecha from groupbox within w_est_conpromalb_cliente
end type
type em_fechadesde from u_em_campo within w_est_conpromalb_cliente
end type
type em_fechahasta from u_em_campo within w_est_conpromalb_cliente
end type
type st_1 from statictext within w_est_conpromalb_cliente
end type
end forward

global type w_est_conpromalb_cliente from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 2939
integer height = 2200
uo_conpromalb2 uo_conpromalb2
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado_conpromalb2 dw_listado_conpromalb2
uo_manejo uo_manejo
dw_conpromalb2 dw_conpromalb2
ddlb_1 ddlb_1
gb_cliente gb_cliente
gb_fecha gb_fecha
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_1 st_1
end type
global w_est_conpromalb_cliente w_est_conpromalb_cliente

on w_est_conpromalb_cliente.create
int iCurrent
call super::create
this.uo_conpromalb2=create uo_conpromalb2
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado_conpromalb2=create dw_listado_conpromalb2
this.uo_manejo=create uo_manejo
this.dw_conpromalb2=create dw_conpromalb2
this.ddlb_1=create ddlb_1
this.gb_cliente=create gb_cliente
this.gb_fecha=create gb_fecha
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_conpromalb2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado_conpromalb2
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.dw_conpromalb2
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.gb_cliente
this.Control[iCurrent+9]=this.gb_fecha
this.Control[iCurrent+10]=this.em_fechadesde
this.Control[iCurrent+11]=this.em_fechahasta
this.Control[iCurrent+12]=this.st_1
end on

on w_est_conpromalb_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_conpromalb2)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado_conpromalb2)
destroy(this.uo_manejo)
destroy(this.dw_conpromalb2)
destroy(this.ddlb_1)
destroy(this.gb_cliente)
destroy(this.gb_fecha)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Informe Promoción por Cliente"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

dw_conpromalb2.SetTransObject(SQLCA)
dw_listado_conpromalb2.SetTransObject(SQLCA)
f_activar_campo(uo_conpromalb2.em_campo)

ddlb_1.text = "Si"

em_fechadesde.text=string(datetime(date(year(today()),01,01)))
em_fechahasta.text=string(datetime(today()))
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromalb2)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromalb2)
end event

event ue_listar;string tipo_cli
tipo_cli ="N"
if ddlb_1.text ="Si" then tipo_cli = "S"

dw_listado_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,tipo_cli,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
dw_report =dw_listado_conpromalb2
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_est_conpromalb_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_est_conpromalb_cliente
integer taborder = 50
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_conpromalb2.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_est_conpromalb_cliente
integer x = 18
end type

type uo_conpromalb2 from u_em_campo_2 within w_est_conpromalb_cliente
integer x = 1015
integer y = 212
integer width = 1202
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conpromalb2.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;if ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
   ue_datawindow ="dw_ayuda_clientes"
   ue_filtro = ""
Else
	ue_titulo = "Selección de no clientes"
   ue_datawindow ="dw_ayuda_vencliproforma"
   ue_filtro = ""
End if
	
end event

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	uo_conpromalb2.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_conpromalb2.em_codigo.text)
Else
   uo_conpromalb2.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_conpromalb2.em_codigo.text)	
End if

If Trim(uo_conpromalb2.em_campo.text)="" then
	uo_conpromalb2.em_campo.text=""
	uo_conpromalb2.em_codigo.text=""
	Return
end if 
string tipo_cli
tipo_cli ="N"
if ddlb_1.text = "Si" then tipo_cli = "S"
dw_conpromalb2.Retrieve(codigo_empresa,uo_conpromalb2.em_codigo.text,tipo_cli,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

type pb_1 from upb_salir within w_est_conpromalb_cliente
integer x = 2729
integer y = 20
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within w_est_conpromalb_cliente
integer x = 2747
integer y = 220
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;if trim( uo_conpromalb2.em_codigo.text)= "" Then
	  f_mensaje("No se puede procesar el listado"," Introduzca el Cliente")
	  Return
END IF

f_activar_campo(uo_conpromalb2.em_campo)
Parent.triggerEvent("ue_listar")
end event

type dw_listado_conpromalb2 from datawindow within w_est_conpromalb_cliente
boolean visible = false
integer x = 64
integer y = 16
integer width = 402
integer height = 168
boolean bringtotop = true
string dataobject = "report_est_conpromalb_cliente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_est_conpromalb_cliente
integer x = 2267
integer y = 172
integer width = 617
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromalb2
f_activar_campo(uo_conpromalb2.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_conpromalb2 from datawindow within w_est_conpromalb_cliente
integer y = 332
integer width = 2871
integer height = 1636
boolean bringtotop = true
string dataobject = "dw_est_conpromalb_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 then Return
string albaran
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromalb2.GetItemNumber(This.GetRow(),"albaran"))
  OpenWithParm(w_con_promalbaranes,lstr_param)

end event

type ddlb_1 from dropdownlistbox within w_est_conpromalb_cliente
integer x = 754
integer y = 212
integer width = 247
integer height = 272
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type gb_cliente from groupbox within w_est_conpromalb_cliente
integer x = 713
integer y = 144
integer width = 1554
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_fecha from groupbox within w_est_conpromalb_cliente
integer x = 9
integer y = 144
integer width = 690
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type em_fechadesde from u_em_campo within w_est_conpromalb_cliente
integer x = 23
integer y = 216
integer width = 283
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fechahasta from u_em_campo within w_est_conpromalb_cliente
integer x = 393
integer y = 216
integer width = 279
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_est_conpromalb_cliente
integer x = 315
integer y = 212
integer width = 64
integer height = 68
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

