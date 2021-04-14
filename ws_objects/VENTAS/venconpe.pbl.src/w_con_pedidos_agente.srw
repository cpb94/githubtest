$PBExportHeader$w_con_pedidos_agente.srw
forward
global type w_con_pedidos_agente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_agente
end type
type pb_2 from upb_imprimir within w_con_pedidos_agente
end type
type st_2 from statictext within w_con_pedidos_agente
end type
type em_agente from u_em_campo within w_con_pedidos_agente
end type
type st_nombre_agente from statictext within w_con_pedidos_agente
end type
type dw_listado from datawindow within w_con_pedidos_agente
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_agente
end type
type dw_detalle from datawindow within w_con_pedidos_agente
end type
end forward

global type w_con_pedidos_agente from w_int_con_empresa
integer width = 2907
integer height = 1632
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_agente em_agente
st_nombre_agente st_nombre_agente
dw_listado dw_listado
uo_manejo uo_manejo
dw_detalle dw_detalle
end type
global w_con_pedidos_agente w_con_pedidos_agente

type variables
string filtro

Boolean cabecera_wow = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_agente.text)

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por agente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,em_agente.text)

if cabecera_wow then
	dw_report.object.dw_1.visible = false
	dw_report.object.dw_2.visible = true
else
	dw_report.object.dw_1.visible = true
	dw_report.object.dw_2.visible = false
end if

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_pedidos_agente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_agente=create em_agente
this.st_nombre_agente=create st_nombre_agente
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_agente
this.Control[iCurrent+5]=this.st_nombre_agente
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_manejo
this.Control[iCurrent+8]=this.dw_detalle
end on

on w_con_pedidos_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_agente)
destroy(this.st_nombre_agente)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_agente
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_agente
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_agente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_agente
integer y = 4
integer width = 2427
integer height = 104
end type

type pb_1 from upb_salir within w_con_pedidos_agente
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_agente
integer x = 2706
integer y = 160
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_pedidos_agente
integer x = 18
integer y = 176
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_agente from u_em_campo within w_con_pedidos_agente
integer x = 265
integer y = 172
integer width = 549
integer taborder = 20
long backcolor = 16773367
end type

event modificado;call super::modificado; st_nombre_agente.text = f_nombre_venagentes(codigo_empresa,em_agente.text)	
 if Trim(st_nombre_agente.text)="" Then
      IF len( st_nombre_agente.text) <> 0 Then f_activar_campo(em_agente)
		em_agente.text = ""
      return
 End If
 f_control()


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE AGENTES"
		ue_datawindow = "dw_ayuda_venagentes"
		ue_filtro     = ""
  


 
        
end event

type st_nombre_agente from statictext within w_con_pedidos_agente
integer x = 827
integer y = 176
integer width = 1271
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_pedidos_agente
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_pedidos_agente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_agente
integer x = 2226
integer y = 116
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_agente)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_pedidos_agente
event doubleclicked pbm_dwnlbuttondblclk
integer x = 5
integer y = 272
integer width = 2839
integer height = 1140
integer taborder = 21
string dataobject = "dw_con_pedidos_agente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
  
end event

event retrieveend;Int i
String familia 

cabecera_wow = true
For i = 1 To rowcount
	familia = dw_detalle.object.articulos_familia[i]
	if familia <> '2' then
		cabecera_wow = false
	end if
next

end event

