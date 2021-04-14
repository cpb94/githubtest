$PBExportHeader$w_con_pagos_vto_banco.srw
forward
global type w_con_pagos_vto_banco from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_vto_banco
end type
type cb_consulta from u_boton within w_con_pagos_vto_banco
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_vto_banco
end type
type dw_listado from datawindow within w_con_pagos_vto_banco
end type
type dw_1 from datawindow within w_con_pagos_vto_banco
end type
type uo_banco from u_em_campo_2 within w_con_pagos_vto_banco
end type
type gb_vto from groupbox within w_con_pagos_vto_banco
end type
type gb_cuenta from groupbox within w_con_pagos_vto_banco
end type
type st_2 from statictext within w_con_pagos_vto_banco
end type
type st_3 from statictext within w_con_pagos_vto_banco
end type
type st_4 from statictext within w_con_pagos_vto_banco
end type
type st_5 from statictext within w_con_pagos_vto_banco
end type
type st_6 from statictext within w_con_pagos_vto_banco
end type
type em_vto_desde from editmask within w_con_pagos_vto_banco
end type
type em_vto_hasta from editmask within w_con_pagos_vto_banco
end type
type uo_banco1 from u_em_campo_2 within w_con_pagos_vto_banco
end type
type st_1 from statictext within w_con_pagos_vto_banco
end type
end forward

global type w_con_pagos_vto_banco from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 2100
string menuname = ""
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
uo_banco uo_banco
gb_vto gb_vto
gb_cuenta gb_cuenta
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
em_vto_desde em_vto_desde
em_vto_hasta em_vto_hasta
uo_banco1 uo_banco1
st_1 st_1
end type
global w_con_pagos_vto_banco w_con_pagos_vto_banco

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String ban1,ban2
DateTime	fec1,fec2

dw_data.reset()

dw_data.SetTransObject(sqlca)

IF Trim(uo_banco.em_codigo.text) = "" Then
   ban1 = "."
ELSE
	ban1 = uo_banco.em_codigo.text
END IF

IF Trim(uo_banco1.em_codigo.text) = "" Then
   ban2 = "ZZZZ"
ELSE
	ban2 = uo_banco1.em_codigo.text
END IF
IF ban1 > ban2 THEN
	MessageBox("ERROR EN BANCOS","El banco desde mayor que banco Hasta",Exclamation!)
	f_activar_campo(uo_banco.em_campo)
	RETURN
END IF

IF em_vto_desde.text = "00/00/00" THEN
	fec1 = DateTime(date("01/01/92"))
ELSE
	fec1 = DateTime(date(em_vto_desde.text))
END IF

IF em_vto_hasta.text = "00/00/00" THEN
	fec2 = DateTime(date("31/12/15"))
ELSE
	fec2 = DateTime(date(em_vto_hasta.text))
END IF

IF fec1 > fec2 THEN
	MessageBox("ERROR EN FECHAS","La fecha desde mayor que la fecha Hasta",Exclamation!)
	f_activar_campo(uo_banco.em_campo)
	RETURN
END IF

dw_data.Retrieve(codigo_empresa,ban1,ban2,fec1,fec2)
registros = dw_data.RowCount()

end subroutine

event open;call super::open;
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE PAGOS POR VENCIMIENTO Y BANCO"

em_vto_desde.text = "01/01/98"
em_vto_hasta.text = "31/12/15"

f_activar_campo(em_vto_desde)





end event

on w_con_pagos_vto_banco.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.uo_banco=create uo_banco
this.gb_vto=create gb_vto
this.gb_cuenta=create gb_cuenta
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.em_vto_desde=create em_vto_desde
this.em_vto_hasta=create em_vto_hasta
this.uo_banco1=create uo_banco1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_banco
this.Control[iCurrent+7]=this.gb_vto
this.Control[iCurrent+8]=this.gb_cuenta
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.em_vto_desde
this.Control[iCurrent+15]=this.em_vto_hasta
this.Control[iCurrent+16]=this.uo_banco1
this.Control[iCurrent+17]=this.st_1
end on

on w_con_pagos_vto_banco.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.uo_banco)
destroy(this.gb_vto)
destroy(this.gb_cuenta)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.em_vto_desde)
destroy(this.em_vto_hasta)
destroy(this.uo_banco1)
destroy(this.st_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_vto_banco
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_vto_banco
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_vto_banco
integer x = 59
integer y = 12
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_vto_banco
integer x = 2757
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_pagos_vto_banco
integer x = 2135
integer y = 204
integer width = 361
integer height = 128
integer taborder = 50
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(em_vto_desde)


end event

type pb_imprimir_preli from picturebutton within w_con_pagos_vto_banco
integer x = 2551
integer y = 204
integer width = 151
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_pagos_vto_banco
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_vto_banco"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_pagos_vto_banco
integer x = 5
integer y = 480
integer width = 2853
integer height = 1452
string dataobject = "dw_con_pagos_vto_bancos"
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

type uo_banco from u_em_campo_2 within w_con_pagos_vto_banco
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 946
integer y = 328
integer width = 1115
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
IF Trim(uo_banco1.em_codigo.text) <> "" THEN
	uo_banco1.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco1.em_codigo.text)
	If Trim(uo_banco1.em_campo.text)="" then
		uo_banco1.em_campo.text=""
		uo_banco1.em_codigo.text=""
		Return
	end if 
END IF

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type gb_vto from groupbox within w_con_pagos_vto_banco
integer x = 27
integer y = 116
integer width = 672
integer height = 336
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_cuenta from groupbox within w_con_pagos_vto_banco
integer x = 722
integer y = 116
integer width = 1381
integer height = 336
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_2 from statictext within w_con_pagos_vto_banco
integer x = 745
integer y = 244
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_pagos_vto_banco
integer x = 741
integer y = 336
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_pagos_vto_banco
integer x = 37
integer y = 152
integer width = 645
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "VENCIMIENTO"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_pagos_vto_banco
integer x = 110
integer y = 236
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_pagos_vto_banco
integer x = 105
integer y = 324
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_vto_desde from editmask within w_con_pagos_vto_banco
integer x = 315
integer y = 220
integer width = 311
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_vto_hasta from editmask within w_con_pagos_vto_banco
integer x = 315
integer y = 316
integer width = 311
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;IF Date(em_vto_desde.text) > Date(em_vto_hasta.text)  AND em_vto_hasta.text <> "00/00/00" THEN
	MessageBox("ERROR EN FECHAS","La Fecha desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_vto_hasta)
END IF
end event

type uo_banco1 from u_em_campo_2 within w_con_pagos_vto_banco
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 946
integer y = 232
integer width = 1115
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco1.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_con_pagos_vto_banco
integer x = 750
integer y = 148
integer width = 1344
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "BANCO"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

