$PBExportHeader$w_con_buscar_pagos.srw
forward
global type w_con_buscar_pagos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_buscar_pagos
end type
type cb_consulta from u_boton within w_con_buscar_pagos
end type
type pb_imprimir_preli from picturebutton within w_con_buscar_pagos
end type
type dw_listado from datawindow within w_con_buscar_pagos
end type
type gb_2 from groupbox within w_con_buscar_pagos
end type
type uo_proveedor from u_em_campo_2 within w_con_buscar_pagos
end type
type gb_cuenta from groupbox within w_con_buscar_pagos
end type
type em_desde from u_em_campo within w_con_buscar_pagos
end type
type em_hasta from u_em_campo within w_con_buscar_pagos
end type
type em_importe1 from u_em_campo within w_con_buscar_pagos
end type
type em_importe2 from u_em_campo within w_con_buscar_pagos
end type
type gb_1 from groupbox within w_con_buscar_pagos
end type
type gb_3 from groupbox within w_con_buscar_pagos
end type
type dw_1 from datawindow within w_con_buscar_pagos
end type
end forward

global type w_con_buscar_pagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3707
integer height = 2256
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
gb_2 gb_2
uo_proveedor uo_proveedor
gb_cuenta gb_cuenta
em_desde em_desde
em_hasta em_hasta
em_importe1 em_importe1
em_importe2 em_importe2
gb_1 gb_1
gb_3 gb_3
dw_1 dw_1
end type
global w_con_buscar_pagos w_con_buscar_pagos

type variables

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String pro1,pro2

dw_data.reset()
dw_data.SetTransObject(sqlca)

if trim(uo_proveedor.em_codigo.text)<>"" then
	pro1=uo_proveedor.em_codigo.text
	pro2=uo_proveedor.em_codigo.text
  else
	pro1="."
	pro2="Z"
End if

dw_data.Retrieve(codigo_empresa,pro1,pro2,datetime(date(em_desde.text)),datetime(date(em_hasta.text)),dec(em_importe1.text), dec(em_importe2.text))


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " BUSCAR PAGOS"
em_desde.text = String(mdy(1,1,year(today())))
em_hasta.text = String(mdy(12,31,year(today())))



IF istr_parametros.i_nargumentos>1 THEN
	uo_proveedor.em_codigo.text=istr_parametros.s_argumentos[2]
	
	uo_proveedor.triggerevent("modificado")
	cb_consulta.TriggerEvent(clicked!)
	 
END IF

f_activar_campo(uo_proveedor.em_campo)


end event

on w_con_buscar_pagos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.uo_proveedor=create uo_proveedor
this.gb_cuenta=create gb_cuenta
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.em_importe1=create em_importe1
this.em_importe2=create em_importe2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.uo_proveedor
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.em_desde
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.em_importe1
this.Control[iCurrent+11]=this.em_importe2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.dw_1
end on

on w_con_buscar_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.uo_proveedor)
destroy(this.gb_cuenta)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.em_importe1)
destroy(this.em_importe2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_buscar_pagos
integer x = 187
integer y = 896
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_buscar_pagos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_buscar_pagos
integer width = 3488
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type pb_2 from upb_salir within w_con_buscar_pagos
integer x = 3520
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_buscar_pagos
integer x = 3026
integer y = 184
integer width = 293
integer height = 96
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_proveedor.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_buscar_pagos
boolean visible = false
integer x = 3470
integer y = 184
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

type dw_listado from datawindow within w_con_buscar_pagos
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_proveedor"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_buscar_pagos
integer x = 3008
integer y = 128
integer width = 613
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_proveedor from u_em_campo_2 within w_con_buscar_pagos
event destroy ( )
integer x = 27
integer y = 200
integer width = 1477
integer taborder = 10
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


end event

type gb_cuenta from groupbox within w_con_buscar_pagos
integer x = 2286
integer y = 120
integer width = 690
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Importes"
end type

type em_desde from u_em_campo within w_con_buscar_pagos
integer x = 1573
integer y = 200
integer width = 325
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type em_hasta from u_em_campo within w_con_buscar_pagos
integer x = 1915
integer y = 200
integer width = 325
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type em_importe1 from u_em_campo within w_con_buscar_pagos
integer x = 2322
integer y = 184
integer width = 306
integer taborder = 40
boolean bringtotop = true
string text = "1"
alignment alignment = right!
end type

type em_importe2 from u_em_campo within w_con_buscar_pagos
integer x = 2638
integer y = 184
integer width = 306
integer taborder = 50
boolean bringtotop = true
string text = "99999999"
alignment alignment = right!
end type

type gb_1 from groupbox within w_con_buscar_pagos
integer x = 5
integer y = 128
integer width = 1527
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Proveedor"
end type

type gb_3 from groupbox within w_con_buscar_pagos
integer x = 1545
integer y = 124
integer width = 731
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fecha de Vto"
end type

type dw_1 from datawindow within w_con_buscar_pagos
integer x = 9
integer y = 316
integer width = 3621
integer height = 1696
string dataobject = "dw_con_buscar_pagos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

event rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

