$PBExportHeader$w_emision_cobros.srw
forward
global type w_emision_cobros from w_int_con_empresa
end type
type pb_2 from upb_salir within w_emision_cobros
end type
type dw_1 from u_datawindow_consultas within w_emision_cobros
end type
type st_1 from statictext within w_emision_cobros
end type
type cb_consulta from u_boton within w_emision_cobros
end type
type st_4 from statictext within w_emision_cobros
end type
type pb_imprimir_recibos from picturebutton within w_emision_cobros
end type
type dw_listado1 from datawindow within w_emision_cobros
end type
type em_fecha1 from u_em_campo within w_emision_cobros
end type
type st_2 from statictext within w_emision_cobros
end type
type em_fecha2 from u_em_campo within w_emision_cobros
end type
type uo_tipodoc from u_em_campo_2 within w_emision_cobros
end type
type st_787 from statictext within w_emision_cobros
end type
type gb_1 from groupbox within w_emision_cobros
end type
type uo_1 from u_selec_impresoras within w_emision_cobros
end type
type cb_marcar from u_boton within w_emision_cobros
end type
type cb_desmarcar from u_boton within w_emision_cobros
end type
type timbre from radiobutton within w_emision_cobros
end type
type recibo from radiobutton within w_emision_cobros
end type
type cbx_otrassitu from checkbox within w_emision_cobros
end type
end forward

global type w_emision_cobros from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3214
integer height = 2248
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
st_1 st_1
cb_consulta cb_consulta
st_4 st_4
pb_imprimir_recibos pb_imprimir_recibos
dw_listado1 dw_listado1
em_fecha1 em_fecha1
st_2 st_2
em_fecha2 em_fecha2
uo_tipodoc uo_tipodoc
st_787 st_787
gb_1 gb_1
uo_1 uo_1
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
timbre timbre
recibo recibo
cbx_otrassitu cbx_otrassitu
end type
global w_emision_cobros w_emision_cobros

type variables
Date fpago
Dec num_talon
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
DateTime  fecha1,fecha2
String tip1,tip2
String situ[]

fecha1 = dateTime(Date(em_fecha1.text))
fecha2 = dateTime(Date(em_fecha2.text))
dw_data.reset()
dw_data.SetTransObject(sqlca)

if trim(uo_tipodoc.em_codigo.text)="" then
	tip1="%"
else
	tip1=uo_tipodoc.em_codigo.text
End if

situ[1] = '0'
if cbx_otrassitu.checked then
	situ[2] = '1'
	situ[3] = '5'
end if

string f="",fi=""
string mensaje
if isnull(tipo_vista) or trim(tipo_vista) = "" then tipo_vista = "Ambos"
if tipo_vista = "Nacional" then mensaje = "la serie Nacional"
if tipo_vista = "Exportacion" then mensaje = "la serie Exportación"
if tipo_vista = "Ambos" then mensaje = "las dos Series"
MESSAGEBOX("Atención","Le recuerdo que el listado se realizara sobre "+mensaje)
if tipo_vista = "Nacional" then fi="(nacional='S')"
if tipo_vista = "Exportacion" then fi="(nacional='N')"
if tipo_vista = "Ambos" then fi="((nacional='N') or (nacional='S'))"
dw_data.SetFilter(fi)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa,fecha1,fecha2,tip1,situ)

end subroutine

event open;call super::open;String mascara
dw_listado1.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
This.title = " EMISION COBROS"
em_fecha1.text = STring(Today(),"dd-mm-yy")
em_fecha2.text = STring(Today(),"dd-mm-yy")
cbx_otrassitu.checked = true
f_activar_campo(em_fecha1)


end event

on w_emision_cobros.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_consulta=create cb_consulta
this.st_4=create st_4
this.pb_imprimir_recibos=create pb_imprimir_recibos
this.dw_listado1=create dw_listado1
this.em_fecha1=create em_fecha1
this.st_2=create st_2
this.em_fecha2=create em_fecha2
this.uo_tipodoc=create uo_tipodoc
this.st_787=create st_787
this.gb_1=create gb_1
this.uo_1=create uo_1
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
this.timbre=create timbre
this.recibo=create recibo
this.cbx_otrassitu=create cbx_otrassitu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.pb_imprimir_recibos
this.Control[iCurrent+7]=this.dw_listado1
this.Control[iCurrent+8]=this.em_fecha1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_fecha2
this.Control[iCurrent+11]=this.uo_tipodoc
this.Control[iCurrent+12]=this.st_787
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.uo_1
this.Control[iCurrent+15]=this.cb_marcar
this.Control[iCurrent+16]=this.cb_desmarcar
this.Control[iCurrent+17]=this.timbre
this.Control[iCurrent+18]=this.recibo
this.Control[iCurrent+19]=this.cbx_otrassitu
end on

on w_emision_cobros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_consulta)
destroy(this.st_4)
destroy(this.pb_imprimir_recibos)
destroy(this.dw_listado1)
destroy(this.em_fecha1)
destroy(this.st_2)
destroy(this.em_fecha2)
destroy(this.uo_tipodoc)
destroy(this.st_787)
destroy(this.gb_1)
destroy(this.uo_1)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.timbre)
destroy(this.recibo)
destroy(this.cbx_otrassitu)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_emision_cobros
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_emision_cobros
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_emision_cobros
integer x = 55
integer width = 2642
end type

type pb_2 from upb_salir within w_emision_cobros
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type dw_1 from u_datawindow_consultas within w_emision_cobros
integer y = 376
integer width = 3131
integer height = 1632
integer taborder = 0
string dataobject = "dw_emision_cobros"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;IF  key  <> KeyEnter! Then
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

END IF



end event

event rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from statictext within w_emision_cobros
integer x = 14
integer y = 164
integer width = 297
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Fra:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_consulta from u_boton within w_emision_cobros
integer x = 2089
integer y = 152
integer width = 293
integer height = 72
integer taborder = 0
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(em_fecha1)

end event

type st_4 from statictext within w_emision_cobros
integer x = 2651
integer y = 212
integer width = 174
integer height = 40
boolean bringtotop = true
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "RECIBOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir_recibos from picturebutton within w_emision_cobros
event clicked pbm_bnclicked
integer x = 2679
integer y = 256
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;Dec registros,var_anyo,var_orden,r1,r
Dec v_orden[]
IF recibo.checked = TRUE Then
	// RECIBOS
	// Modificación (Mila) para sacar 3 recibos en cada A4
	//dw_listado1.DataObject = "report_emision_cobros_recibos_sin"
	//dw_listado1.DataObject = "report_emision_cobros_recibos_matricial"
	dw_listado1.DataObject = "report_emision_cobros_recibos"

	dw_listado1.SetTransObject(SQLCA)
	
	r1 = dw_1.RowCOunt()
	For r = 1 To r1
		IF  dw_1.GetItemNumber(r,"marca") = 1 Then
			var_anyo  = dw_1.GetItemNumber(r,"anyo")
			v_orden[r] = dw_1.GetItemNumber(r,"orden")
			//dw_listado1.Retrieve(codigo_empresa,var_anyo,var_orden)
			//dw_listado1.Print(FALSE)
		END IF
		f_contador_procesos(r,r1)
	Next
	
	dw_listado1.Retrieve(codigo_empresa,var_anyo,v_orden[],"La Caixa")
	dw_listado1.Print(FALSE)
ELSE
	// TIMBRES
	dw_listado1.DataObject = "report_emision_cobros_timbres"
	dw_listado1.SetTransObject(SQLCA)
	
	r1 = dw_1.RowCOunt()
	For r = 1 To r1
		IF  dw_1.GetItemNumber(r,"marca") = 1 Then
			var_anyo  = dw_1.GetItemNumber(r,"anyo")
			var_orden = dw_1.GetItemNumber(r,"orden")
			dw_listado1.Retrieve(codigo_empresa,var_anyo,var_orden)
			dw_listado1.Print(FALSE)
		END IF
		f_contador_procesos(r,r1)
	Next
END IF

f_activar_campo(uo_tipodoc.em_campo)
end event

type dw_listado1 from datawindow within w_emision_cobros
boolean visible = false
integer x = 2811
integer y = 256
integer width = 187
integer height = 80
integer taborder = 40
string dataobject = "report_emision_cobros_timbres"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fecha1 from u_em_campo within w_emision_cobros
integer x = 343
integer y = 148
integer width = 293
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~r"
end type

type st_2 from statictext within w_emision_cobros
integer x = 645
integer y = 160
integer width = 50
integer height = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha2 from u_em_campo within w_emision_cobros
integer x = 713
integer y = 148
integer width = 302
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~r"
end type

type uo_tipodoc from u_em_campo_2 within w_emision_cobros
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1307
integer y = 148
integer width = 773
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_tipodoc.em_campo.text=f_nombre_cartipodoc(codigo_empresa,uo_tipodoc.em_codigo.text)
If Trim(uo_tipodoc.em_campo.text)="" then
	uo_tipodoc.em_campo.text=""
	uo_tipodoc.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de tipos de documento"
ue_datawindow ="dw_ayuda_cartipodoc"

end event

on uo_tipodoc.destroy
call u_em_campo_2::destroy
end on

type st_787 from statictext within w_emision_cobros
integer x = 1070
integer y = 164
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "T. Dmto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_emision_cobros
integer y = 108
integer width = 2400
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_1 from u_selec_impresoras within w_emision_cobros
integer x = 18
integer y = 256
integer height = 108
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_listado1
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type cb_marcar from u_boton within w_emision_cobros
event clicked pbm_bnclicked
integer x = 1733
integer y = 260
integer width = 315
integer height = 80
integer taborder = 0
string text = "&Marcar"
end type

event clicked;call super::clicked;Int r,r1
r1 = dw_1.RowCount()
For r = 1 To r1
	dw_1.SetItem(r,"marca",1)
Next
end event

type cb_desmarcar from u_boton within w_emision_cobros
event clicked pbm_bnclicked
integer x = 1408
integer y = 260
integer width = 315
integer height = 80
integer taborder = 0
string text = "&Desmarcar"
end type

event clicked;call super::clicked;Int r,r1
r1 = dw_1.RowCount()
For r = 1 To r1
	dw_1.SetItem(r,"marca",0)
Next
end event

type timbre from radiobutton within w_emision_cobros
integer x = 2359
integer y = 260
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Timbre"
boolean lefttext = true
end type

type recibo from radiobutton within w_emision_cobros
integer x = 2071
integer y = 264
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Recibo"
boolean checked = true
boolean lefttext = true
end type

type cbx_otrassitu from checkbox within w_emision_cobros
integer x = 2423
integer y = 136
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Otras Situac."
end type

