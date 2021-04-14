$PBExportHeader$w_con_pedidos_pais.srw
forward
global type w_con_pedidos_pais from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_pais
end type
type pb_2 from upb_imprimir within w_con_pedidos_pais
end type
type st_2 from statictext within w_con_pedidos_pais
end type
type em_pais from u_em_campo within w_con_pedidos_pais
end type
type st_nombre_pais from statictext within w_con_pedidos_pais
end type
type dw_detalle from datawindow within w_con_pedidos_pais
end type
type dw_listado from datawindow within w_con_pedidos_pais
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_pais
end type
end forward

global type w_con_pedidos_pais from w_int_con_empresa
integer width = 2930
integer height = 1648
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_pais em_pais
st_nombre_pais st_nombre_pais
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
end type
global w_con_pedidos_pais w_con_pedidos_pais

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_pais.text)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por País"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,em_pais.text)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_pedidos_pais.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_pais=create em_pais
this.st_nombre_pais=create st_nombre_pais
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_pais
this.Control[iCurrent+5]=this.st_nombre_pais
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_manejo
end on

on w_con_pedidos_pais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_pais)
destroy(this.st_nombre_pais)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_pais
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_pais
integer taborder = 180
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_pais)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_pais
integer x = 14
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_pais
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_pais
integer x = 2720
integer y = 140
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_pedidos_pais
integer x = 50
integer y = 144
integer width = 183
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
string text = "País "
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pais from u_em_campo within w_con_pedidos_pais
integer x = 256
integer y = 140
integer width = 549
integer taborder = 160
long backcolor = 16773367
end type

event modificado;call super::modificado; st_nombre_pais.text = f_nombre_pais(em_pais.text)	
 if Trim(st_nombre_pais.text)="" Then
      IF len( st_nombre_pais.text) <> 0 Then f_activar_campo(em_pais)
		em_pais.text = ""
      return
 End If
 f_control()


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PAISES"
		ue_datawindow = "dw_ayuda_paises"
		ue_filtro     = ""
		valor_empresa = FALSE
  


 
        
end event

type st_nombre_pais from statictext within w_con_pedidos_pais
integer x = 818
integer y = 144
integer width = 1367
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

type dw_detalle from datawindow within w_con_pedidos_pais
integer y = 248
integer width = 2853
integer height = 1168
string dataobject = "dw_con_pedidos_pais"
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

type dw_listado from datawindow within w_con_pedidos_pais
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 200
boolean bringtotop = true
string dataobject = "report_con_pedidos_pais"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_pais
integer x = 2245
integer y = 96
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_pais)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

