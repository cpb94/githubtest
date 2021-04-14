$PBExportHeader$w_con_proformas_transpor.srw
forward
global type w_con_proformas_transpor from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_proformas_transpor
end type
type pb_2 from upb_imprimir within w_con_proformas_transpor
end type
type st_2 from statictext within w_con_proformas_transpor
end type
type em_transpor from u_em_campo within w_con_proformas_transpor
end type
type st_nombre_transpor from statictext within w_con_proformas_transpor
end type
type dw_detalle from datawindow within w_con_proformas_transpor
end type
type dw_listado from datawindow within w_con_proformas_transpor
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_transpor
end type
end forward

global type w_con_proformas_transpor from w_int_con_empresa
integer width = 2903
integer height = 1664
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_transpor em_transpor
st_nombre_transpor st_nombre_transpor
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
end type
global w_con_proformas_transpor w_con_proformas_transpor

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_transpor.text)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de proforma por Transportista"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,em_transpor.text)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_proformas_transpor.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_transpor=create em_transpor
this.st_nombre_transpor=create st_nombre_transpor
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_transpor
this.Control[iCurrent+5]=this.st_nombre_transpor
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_manejo
end on

on w_con_proformas_transpor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_transpor)
destroy(this.st_nombre_transpor)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event activate;call super::activate;w_con_proformas_transpor = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_transpor
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_transpor
integer taborder = 180
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_transpor)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_transpor
integer x = 14
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_proformas_transpor
integer x = 2693
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_proformas_transpor
integer x = 2693
integer y = 136
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_proformas_transpor
integer y = 144
integer width = 389
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
string text = "Transportista"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_transpor from u_em_campo within w_con_proformas_transpor
integer x = 411
integer y = 140
integer width = 425
integer taborder = 160
long backcolor = 16773367
end type

event modificado;call super::modificado; st_nombre_transpor.text = f_nombre_ventransportista(codigo_empresa,em_transpor.text)	
 if Trim(st_nombre_transpor.text)="" Then
      IF len( st_nombre_transpor.text) <> 0 Then f_activar_campo(em_transpor)
		em_transpor.text = ""
      return
 End If
 f_control()


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PAISES"
		ue_datawindow = "dw_ayuda_ventransportistas"
		ue_filtro     = ""
		


 
        
end event

type st_nombre_transpor from statictext within w_con_proformas_transpor
integer x = 846
integer y = 148
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

type dw_detalle from datawindow within w_con_proformas_transpor
integer y = 248
integer width = 2816
integer height = 1168
string dataobject = "dw_con_proformas_transpor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"proforma"))
  OpenWithParm(w_int_venproformas,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_proformas_transpor
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 200
boolean bringtotop = true
string dataobject = "report_con_proformas_transpor"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_transpor
integer x = 2217
integer y = 92
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_transpor)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

