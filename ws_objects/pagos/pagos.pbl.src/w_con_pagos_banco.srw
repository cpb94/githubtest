$PBExportHeader$w_con_pagos_banco.srw
forward
global type w_con_pagos_banco from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_banco
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_banco
end type
type cb_consulta from u_boton within w_con_pagos_banco
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_banco
end type
type dw_listado from datawindow within w_con_pagos_banco
end type
type dw_1 from datawindow within w_con_pagos_banco
end type
type uo_banco from u_em_campo_2 within w_con_pagos_banco
end type
type st_1 from statictext within w_con_pagos_banco
end type
type em_hasta from u_em_campo within w_con_pagos_banco
end type
type st_2 from statictext within w_con_pagos_banco
end type
type em_desde from u_em_campo within w_con_pagos_banco
end type
type st_3 from statictext within w_con_pagos_banco
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_banco
end type
type st_4 from statictext within w_con_pagos_banco
end type
type uo_tipodoc from u_em_campo_2 within w_con_pagos_banco
end type
type st_5 from statictext within w_con_pagos_banco
end type
type ln_1 from line within w_con_pagos_banco
end type
type ln_2 from line within w_con_pagos_banco
end type
type ln_3 from line within w_con_pagos_banco
end type
type ln_4 from line within w_con_pagos_banco
end type
end forward

global type w_con_pagos_banco from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3730
integer height = 2168
pb_2 pb_2
uo_1 uo_1
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
uo_banco uo_banco
st_1 st_1
em_hasta em_hasta
st_2 st_2
em_desde em_desde
st_3 st_3
ddlb_1 ddlb_1
st_4 st_4
uo_tipodoc uo_tipodoc
st_5 st_5
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_con_pagos_banco w_con_pagos_banco

type variables
String situacion= "0"


end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String ban1,ban2,situaciond,situacionh,ls_tipodoc

dw_data.reset()
//uo_tipo2.visible   = FALSE
dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()


CHOOSE CASE ddlb_1.text
	CASE "Pendientes"
		situaciond = '0'
		situacionh = '0'
	CASE "Emitidos"
		situaciond = '1'
		situacionh = '1'
	CASE "Pagados"
		situaciond = '2'
		situacionh = '2'
	CASE "Pendientes/Emitidos"
		situaciond = '0'
		situacionh = '1'
	CASE "Todos"
		situaciond = '0'
		situacionh = '2'
END CHOOSE

iF Trim(uo_banco.em_codigo.text) = "" Then
   ban1 = "."
   ban2 = "Z"
ELSE
	ban1 = uo_banco.em_codigo.text
	ban2 = uo_banco.em_codigo.text
END IF
if uo_tipodoc.em_codigo.text <> "" then
	ls_tipodoc = uo_tipodoc.em_codigo.text
else
	ls_tipodoc = "%"
end if
dw_data.Retrieve(codigo_empresa,ban1,ban2,datetime(date(em_desde.text)),datetime(date(em_hasta.text)),situaciond,situacionh,ls_tipodoc)
registros = dw_data.RowCount()

end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta de pagos por banco"


f_activar_campo(uo_banco.em_campo)



em_desde.text = "1/1/" + string(year(today()))
em_hasta.text = string(today())

ddlb_1.text = "Pendientes"






end event

on w_con_pagos_banco.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.uo_banco=create uo_banco
this.st_1=create st_1
this.em_hasta=create em_hasta
this.st_2=create st_2
this.em_desde=create em_desde
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.uo_tipodoc=create uo_tipodoc
this.st_5=create st_5
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_banco
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.em_desde
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.ddlb_1
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.uo_tipodoc
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.ln_1
this.Control[iCurrent+18]=this.ln_2
this.Control[iCurrent+19]=this.ln_3
this.Control[iCurrent+20]=this.ln_4
end on

on w_con_pagos_banco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.uo_banco)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.st_2)
destroy(this.em_desde)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.uo_tipodoc)
destroy(this.st_5)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_banco
integer x = 818
integer y = 72
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_banco
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_banco
integer x = 59
integer y = 12
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_banco
integer x = 3520
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_banco
boolean visible = false
integer x = 1970
integer y = 32
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_consulta from u_boton within w_con_pagos_banco
integer x = 3200
integer y = 184
integer width = 311
integer height = 108
integer taborder = 60
integer textsize = -10
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_banco.em_campo)


end event

type pb_imprimir_preli from picturebutton within w_con_pagos_banco
integer x = 3515
integer y = 188
integer width = 110
integer height = 96
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

type dw_listado from datawindow within w_con_pagos_banco
boolean visible = false
integer x = 27
integer y = 344
integer width = 553
integer height = 316
string dataobject = "report_con_pagos_banco"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_pagos_banco
integer x = 5
integer y = 320
integer width = 3621
integer height = 1608
string dataobject = "dw_con_pagos_bancos"
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

type uo_banco from u_em_campo_2 within w_con_pagos_banco
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 5
integer y = 208
integer width = 1083
integer height = 88
integer taborder = 10
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

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_con_pagos_banco
integer x = 5
integer y = 116
integer width = 1074
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_con_pagos_banco
integer x = 1454
integer y = 208
integer width = 279
integer height = 88
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_pagos_banco
integer x = 1385
integer y = 208
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_con_pagos_banco
event modified pbm_enmodified
integer x = 1093
integer y = 208
integer width = 283
integer height = 88
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;
//cb_consultar.triggerevent("clicked")
end event

type st_3 from statictext within w_con_pagos_banco
integer x = 1097
integer y = 120
integer width = 631
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Vencimiento "
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_con_pagos_banco
integer x = 1742
integer y = 208
integer width = 549
integer height = 424
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_con_pagos_banco
integer x = 1751
integer y = 112
integer width = 530
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Situación"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_tipodoc from u_em_campo_2 within w_con_pagos_banco
event destroy ( )
integer x = 2304
integer y = 212
integer width = 795
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipodoc.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tipodoc.em_campo.text=f_nombre_cartipodoc(codigo_empresa,uo_tipodoc.em_codigo.text)
If Trim(uo_tipodoc.em_campo.text)="" then
	uo_tipodoc.em_campo.text=""
	uo_tipodoc.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de tipos de documento"
ue_datawindow ="dw_ayuda_cartipodoc"

end event

type st_5 from statictext within w_con_pagos_banco
integer x = 2304
integer y = 112
integer width = 795
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Doc."
alignment alignment = center!
boolean focusrectangle = false
end type

type ln_1 from line within w_con_pagos_banco
long linecolor = 8421376
integer linethickness = 8
integer beginx = 1088
integer beginy = 112
integer endx = 1088
integer endy = 204
end type

type ln_2 from line within w_con_pagos_banco
long linecolor = 8421376
integer linethickness = 8
integer beginx = 1737
integer beginy = 112
integer endx = 1737
integer endy = 204
end type

type ln_3 from line within w_con_pagos_banco
long linecolor = 8421376
integer linethickness = 8
integer beginx = 2299
integer beginy = 112
integer endx = 2299
integer endy = 204
end type

type ln_4 from line within w_con_pagos_banco
long linecolor = 8421376
integer linethickness = 8
integer beginx = 3109
integer beginy = 112
integer endx = 3109
integer endy = 204
end type

