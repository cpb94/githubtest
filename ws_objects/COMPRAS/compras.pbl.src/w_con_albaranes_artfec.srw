$PBExportHeader$w_con_albaranes_artfec.srw
forward
global type w_con_albaranes_artfec from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_artfec
end type
type st_articulo from statictext within w_con_albaranes_artfec
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_artfec
end type
type dw_ordenes1 from datawindow within w_con_albaranes_artfec
end type
type pb_imprimir from upb_imprimir within w_con_albaranes_artfec
end type
type st_articulo2 from statictext within w_con_albaranes_artfec
end type
type st_fecha from statictext within w_con_albaranes_artfec
end type
type st_fecha2 from statictext within w_con_albaranes_artfec
end type
type em_fecha from u_em_campo within w_con_albaranes_artfec
end type
type em_fecha2 from u_em_campo within w_con_albaranes_artfec
end type
type dw_listado from datawindow within w_con_albaranes_artfec
end type
type em_prima1 from u_em_campo within w_con_albaranes_artfec
end type
type st_prima1 from statictext within w_con_albaranes_artfec
end type
type em_prima2 from u_em_campo within w_con_albaranes_artfec
end type
type st_prima2 from statictext within w_con_albaranes_artfec
end type
end forward

global type w_con_albaranes_artfec from w_int_con_empresa
integer width = 2921
integer height = 1720
string icon = "Application!"
pb_1 pb_1
st_articulo st_articulo
uo_manejo uo_manejo
dw_ordenes1 dw_ordenes1
pb_imprimir pb_imprimir
st_articulo2 st_articulo2
st_fecha st_fecha
st_fecha2 st_fecha2
em_fecha em_fecha
em_fecha2 em_fecha2
dw_listado dw_listado
em_prima1 em_prima1
st_prima1 st_prima1
em_prima2 em_prima2
st_prima2 st_prima2
end type
global w_con_albaranes_artfec w_con_albaranes_artfec

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Albaranes por M.Primas y fechas"
This.title=istr_parametros.s_titulo_ventana
em_prima1.SetFocus()
dw_ordenes1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_ordenes1.SetRowFocusIndicator(Hand!)
//uo_articulo.em_campo.text= f_nombre_mprima(codigo_empresa,uo_articulo.em_codigo.text)
em_fecha2.text=string(today())
end event

event ue_listar;Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fecha.Text)))
fecha2=Datetime(date(string(em_fecha2.Text)))
dw_listado.Retrieve(codigo_empresa,em_prima1.text,em_prima2.text,fecha1,fecha2)
dw_report=dw_listado
CALL Super::ue_listar
end event

on w_con_albaranes_artfec.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_articulo=create st_articulo
this.uo_manejo=create uo_manejo
this.dw_ordenes1=create dw_ordenes1
this.pb_imprimir=create pb_imprimir
this.st_articulo2=create st_articulo2
this.st_fecha=create st_fecha
this.st_fecha2=create st_fecha2
this.em_fecha=create em_fecha
this.em_fecha2=create em_fecha2
this.dw_listado=create dw_listado
this.em_prima1=create em_prima1
this.st_prima1=create st_prima1
this.em_prima2=create em_prima2
this.st_prima2=create st_prima2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_articulo
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.dw_ordenes1
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.st_articulo2
this.Control[iCurrent+7]=this.st_fecha
this.Control[iCurrent+8]=this.st_fecha2
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.em_fecha2
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.em_prima1
this.Control[iCurrent+13]=this.st_prima1
this.Control[iCurrent+14]=this.em_prima2
this.Control[iCurrent+15]=this.st_prima2
end on

on w_con_albaranes_artfec.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_articulo)
destroy(this.uo_manejo)
destroy(this.dw_ordenes1)
destroy(this.pb_imprimir)
destroy(this.st_articulo2)
destroy(this.st_fecha)
destroy(this.st_fecha2)
destroy(this.em_fecha)
destroy(this.em_fecha2)
destroy(this.dw_listado)
destroy(this.em_prima1)
destroy(this.st_prima1)
destroy(this.em_prima2)
destroy(this.st_prima2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_ordenes1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_ordenes1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_artfec
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_artfec
integer taborder = 50
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_prima1)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_artfec
integer x = 18
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_albaranes_artfec
integer x = 2729
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_articulo from statictext within w_con_albaranes_artfec
integer x = 14
integer y = 144
integer width = 443
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde M.Prima:"
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_artfec
integer x = 2254
integer y = 188
integer width = 613
end type

event valores;call super::valores;dw_data=dw_ordenes1
f_activar_campo(em_prima1)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_ordenes1 from datawindow within w_con_albaranes_artfec
integer x = 27
integer y = 340
integer width = 2839
integer height = 1164
string dataobject = "dw_con_albaranes_artfec"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[1]="w_con_albaranes_artfec"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"comlinalb_anyo")
lstr_param.s_argumentos[2]=This.GetItemString(Row,"comlinalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type pb_imprimir from upb_imprimir within w_con_albaranes_artfec
integer x = 2729
integer y = 236
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
f_activar_campo(em_prima1)
end event

type st_articulo2 from statictext within w_con_albaranes_artfec
integer x = 14
integer y = 236
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta M.Prima:"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_con_albaranes_artfec
integer x = 1431
integer y = 144
integer width = 453
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_fecha2 from statictext within w_con_albaranes_artfec
integer x = 1426
integer y = 236
integer width = 453
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_con_albaranes_artfec
integer x = 1897
integer y = 144
integer width = 334
integer height = 72
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fecha2 from u_em_campo within w_con_albaranes_artfec
integer x = 1897
integer y = 236
integer width = 338
integer height = 72
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event modificado;call super::modificado;Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fecha.Text)))
fecha2=Datetime(Date(String(em_fecha2.Text)))

dw_ordenes1.Retrieve(codigo_empresa,em_prima1.text,em_prima2.text,fecha1,fecha2)
end event

type dw_listado from datawindow within w_con_albaranes_artfec
boolean visible = false
integer x = 23
integer y = 4
integer width = 494
integer height = 108
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_albaranes_artfec"
boolean livescroll = true
end type

type em_prima1 from u_em_campo within w_con_albaranes_artfec
integer x = 462
integer y = 136
integer width = 334
integer taborder = 10
end type

event modificado;call super::modificado;st_prima1.text = f_nombre_mprima(codigo_empresa,This.text)
iF Trim(st_prima1.text) = "" Then
	IF Trim(em_prima1.text)<>"" Then
	f_activar_campo(em_prima1)
END IF
em_prima1.text = ""
END iF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Articulos"
ue_datawindow = "dw_ayuda_venmprima_compras"
ue_filtro     = "tipo_materia = '1'"

end event

type st_prima1 from statictext within w_con_albaranes_artfec
integer x = 809
integer y = 136
integer width = 613
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_prima2 from u_em_campo within w_con_albaranes_artfec
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 462
integer y = 228
integer width = 334
integer taborder = 11
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Articulos"
ue_datawindow = "dw_ayuda_venmprima_compras"
ue_filtro     = "tipo_materia = '1'"

end event

event modificado;call super::modificado;st_prima2.text = f_nombre_mprima(codigo_empresa,This.text)
iF Trim(st_prima2.text) = "" Then
	IF Trim(em_prima2.text)<>"" Then
	f_activar_campo(em_prima2)
END IF
em_prima2.text = ""
END iF

end event

type st_prima2 from statictext within w_con_albaranes_artfec
integer x = 809
integer y = 228
integer width = 613
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

