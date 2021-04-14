$PBExportHeader$w_con_pagos_proveedor_fra.srw
forward
global type w_con_pagos_proveedor_fra from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_proveedor_fra
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_proveedor_fra
end type
type cb_consulta from u_boton within w_con_pagos_proveedor_fra
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_proveedor_fra
end type
type dw_listado from datawindow within w_con_pagos_proveedor_fra
end type
type uo_proveedor from u_em_campo_2 within w_con_pagos_proveedor_fra
end type
type st_1 from statictext within w_con_pagos_proveedor_fra
end type
type em_fra from u_em_campo within w_con_pagos_proveedor_fra
end type
type st_2 from statictext within w_con_pagos_proveedor_fra
end type
type dw_1 from u_datawindow_consultas within w_con_pagos_proveedor_fra
end type
type gb_cuenta from groupbox within w_con_pagos_proveedor_fra
end type
type dw_fra from datawindow within w_con_pagos_proveedor_fra
end type
end forward

global type w_con_pagos_proveedor_fra from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 2971
integer height = 2104
string menuname = ""
pb_2 pb_2
uo_1 uo_1
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_proveedor uo_proveedor
st_1 st_1
em_fra em_fra
st_2 st_2
dw_1 dw_1
gb_cuenta gb_cuenta
dw_fra dw_fra
end type
global w_con_pagos_proveedor_fra w_con_pagos_proveedor_fra

type variables

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros

dw_data.reset()
dw_data.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,Trim(em_fra.text))


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(Sqlca)
This.title = " CONSULTA PAGOS POR PROVEEDOR Y FRA"
// Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_proveedor.em_codigo.text=istr_parametros.s_argumentos[2]
      em_fra.text=istr_parametros.s_argumentos[3]
//		messagebox("factura en consulta",em_fra.text)
		uo_proveedor.em_campo.text = f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
		cb_consulta.TriggerEvent(Clicked!)		
//		f_posicion_inicio(This)
		Return
   END IF
f_activar_campo(uo_proveedor.em_campo)


end event

on w_con_pagos_proveedor_fra.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_proveedor=create uo_proveedor
this.st_1=create st_1
this.em_fra=create em_fra
this.st_2=create st_2
this.dw_1=create dw_1
this.gb_cuenta=create gb_cuenta
this.dw_fra=create dw_fra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_proveedor
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_fra
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.dw_fra
end on

on w_con_pagos_proveedor_fra.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_proveedor)
destroy(this.st_1)
destroy(this.em_fra)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.gb_cuenta)
destroy(this.dw_fra)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_proveedor_fra
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_proveedor_fra
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_proveedor_fra
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_proveedor_fra
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_proveedor_fra
integer x = 2240
integer y = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_consulta from u_boton within w_con_pagos_proveedor_fra
integer x = 1947
integer y = 216
integer width = 274
integer height = 72
integer taborder = 40
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.SetFocus()
dw_1.SetRow(1)
dw_1.SetColumn("fvto")


end event

type pb_imprimir_preli from picturebutton within w_con_pagos_proveedor_fra
integer x = 2715
integer y = 192
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_proveedor.em_campo)
end event

type dw_listado from datawindow within w_con_pagos_proveedor_fra
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_proveedor_fra"
boolean livescroll = true
end type

type uo_proveedor from u_em_campo_2 within w_con_pagos_proveedor_fra
event destroy ( )
integer x = 27
integer y = 200
integer width = 1431
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 

f_cargar(dw_1)
end event

type st_1 from statictext within w_con_pagos_proveedor_fra
integer x = 23
integer y = 144
integer width = 1435
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "P r o v e e d o r"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fra from u_em_campo within w_con_pagos_proveedor_fra
integer x = 1477
integer y = 200
integer width = 448
integer taborder = 30
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = "À"
end type

event modificado;call super::modificado;f_cargar(dw_1)
end event

type st_2 from statictext within w_con_pagos_proveedor_fra
integer x = 1477
integer y = 128
integer width = 448
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 67108864
string text = "Nº Factura"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_1.Reset()
dw_fra.SetTransObject(SQLCA)
dw_fra.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)
dw_fra.visible = TRUE

end event

type dw_1 from u_datawindow_consultas within w_con_pagos_proveedor_fra
integer y = 320
integer width = 2871
integer height = 1612
integer taborder = 10
string dataobject = "dw_con_pagos_proveedor_fra"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;call super::key;IF Key = KeyEnter! Then
	dw_1.Accepttext()
	dw_1.Update()
	Commit;
END IF
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param) 
End If
end event

event rbuttondown;call super::rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

type gb_cuenta from groupbox within w_con_pagos_proveedor_fra
integer x = 5
integer y = 88
integer width = 1938
integer height = 216
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_fra from datawindow within w_con_pagos_proveedor_fra
boolean visible = false
integer x = 1861
integer y = 120
integer width = 699
integer height = 444
integer taborder = 2
boolean bringtotop = true
string dataobject = "dw_con_pagos_proveedor_fra2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return
em_fra.text = GetItemString(row,"fra")
Reset()
Visible= FALSE
end event

