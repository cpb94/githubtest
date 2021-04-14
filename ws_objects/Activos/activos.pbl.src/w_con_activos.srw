$PBExportHeader$w_con_activos.srw
forward
global type w_con_activos from w_int_con_empresa
end type
type st_1 from statictext within w_con_activos
end type
type em_elemento from u_em_campo within w_con_activos
end type
type st_delemento from statictext within w_con_activos
end type
type cb_3 from u_boton within w_con_activos
end type
type dw_listado from datawindow within w_con_activos
end type
type pb_1 from upb_imprimir within w_con_activos
end type
type pb_2 from upb_salir within w_con_activos
end type
type gb_1 from groupbox within w_con_activos
end type
type rb_1 from radiobutton within w_con_activos
end type
type rb_2 from radiobutton within w_con_activos
end type
type rb_3 from radiobutton within w_con_activos
end type
type rb_4 from radiobutton within w_con_activos
end type
type em_cuenta_activo from u_em_campo within w_con_activos
end type
type st_2 from statictext within w_con_activos
end type
type st_cuenta_activo from statictext within w_con_activos
end type
type em_clase_inmov from u_em_campo within w_con_activos
end type
type st_4 from statictext within w_con_activos
end type
type st_clase_inmov from statictext within w_con_activos
end type
type em_cuenta_prov from u_em_campo within w_con_activos
end type
type st_7 from statictext within w_con_activos
end type
type st_cuenta_prov from statictext within w_con_activos
end type
type uo_ejercicio from u_ejercicio within w_con_activos
end type
type st_3 from statictext within w_con_activos
end type
type em_importe from editmask within w_con_activos
end type
type em_fecha from u_em_campo within w_con_activos
end type
type st_6 from statictext within w_con_activos
end type
type st_8 from statictext within w_con_activos
end type
type dw_1 from u_datawindow within w_con_activos
end type
type cbx_baja from checkbox within w_con_activos
end type
type em_neto_cont from editmask within w_con_activos
end type
type st_9 from statictext within w_con_activos
end type
type st_mensaje from statictext within w_con_activos
end type
type gb_2 from groupbox within w_con_activos
end type
type kk from structure within w_con_activos
end type
end forward

type kk from structure
	string		empresa
	decimal {0}	elemento
	integer		amortizacion
	decimal {0}	ejercicio
	decimal {0}	clase_inmobilizado
	string		familia
	decimal {0}	bien
	decimal {0}	periodo
	string		tipo_amor
	decimal {0}	porcentaje_amor
	string		cuenta_activo
	string		cuenta_cargo
	string		cuenta_abono
	string		seccion
	string		centro_coste
	date		fecha_contable
	decimal {0}	asiento
	string		actualizado
	date		fecha_amor
	decimal {0}	importe_amor
	decimal {0}	importe_amorfis
	string		clase_amor
end type

global type w_con_activos from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 4517
integer height = 3156
st_1 st_1
em_elemento em_elemento
st_delemento st_delemento
cb_3 cb_3
dw_listado dw_listado
pb_1 pb_1
pb_2 pb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
em_cuenta_activo em_cuenta_activo
st_2 st_2
st_cuenta_activo st_cuenta_activo
em_clase_inmov em_clase_inmov
st_4 st_4
st_clase_inmov st_clase_inmov
em_cuenta_prov em_cuenta_prov
st_7 st_7
st_cuenta_prov st_cuenta_prov
uo_ejercicio uo_ejercicio
st_3 st_3
em_importe em_importe
em_fecha em_fecha
st_6 st_6
st_8 st_8
dw_1 dw_1
cbx_baja cbx_baja
em_neto_cont em_neto_cont
st_9 st_9
st_mensaje st_mensaje
gb_2 gb_2
end type
global w_con_activos w_con_activos

type variables


end variables

on w_con_activos.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_elemento=create em_elemento
this.st_delemento=create st_delemento
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.em_cuenta_activo=create em_cuenta_activo
this.st_2=create st_2
this.st_cuenta_activo=create st_cuenta_activo
this.em_clase_inmov=create em_clase_inmov
this.st_4=create st_4
this.st_clase_inmov=create st_clase_inmov
this.em_cuenta_prov=create em_cuenta_prov
this.st_7=create st_7
this.st_cuenta_prov=create st_cuenta_prov
this.uo_ejercicio=create uo_ejercicio
this.st_3=create st_3
this.em_importe=create em_importe
this.em_fecha=create em_fecha
this.st_6=create st_6
this.st_8=create st_8
this.dw_1=create dw_1
this.cbx_baja=create cbx_baja
this.em_neto_cont=create em_neto_cont
this.st_9=create st_9
this.st_mensaje=create st_mensaje
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_elemento
this.Control[iCurrent+3]=this.st_delemento
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.rb_2
this.Control[iCurrent+11]=this.rb_3
this.Control[iCurrent+12]=this.rb_4
this.Control[iCurrent+13]=this.em_cuenta_activo
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_cuenta_activo
this.Control[iCurrent+16]=this.em_clase_inmov
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.st_clase_inmov
this.Control[iCurrent+19]=this.em_cuenta_prov
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.st_cuenta_prov
this.Control[iCurrent+22]=this.uo_ejercicio
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.em_importe
this.Control[iCurrent+25]=this.em_fecha
this.Control[iCurrent+26]=this.st_6
this.Control[iCurrent+27]=this.st_8
this.Control[iCurrent+28]=this.dw_1
this.Control[iCurrent+29]=this.cbx_baja
this.Control[iCurrent+30]=this.em_neto_cont
this.Control[iCurrent+31]=this.st_9
this.Control[iCurrent+32]=this.st_mensaje
this.Control[iCurrent+33]=this.gb_2
end on

on w_con_activos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_elemento)
destroy(this.st_delemento)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.em_cuenta_activo)
destroy(this.st_2)
destroy(this.st_cuenta_activo)
destroy(this.em_clase_inmov)
destroy(this.st_4)
destroy(this.st_clase_inmov)
destroy(this.em_cuenta_prov)
destroy(this.st_7)
destroy(this.st_cuenta_prov)
destroy(this.uo_ejercicio)
destroy(this.st_3)
destroy(this.em_importe)
destroy(this.em_fecha)
destroy(this.st_6)
destroy(this.st_8)
destroy(this.dw_1)
destroy(this.cbx_baja)
destroy(this.em_neto_cont)
destroy(this.st_9)
destroy(this.st_mensaje)
destroy(this.gb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta de Activos Fijos" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fecha.text = string(today())
em_neto_cont.text = '9999999999'
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_activos
integer taborder = 100
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_activos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_activos
integer x = 50
integer y = 24
integer width = 4357
integer height = 88
boolean italic = true
end type

type st_1 from statictext within w_con_activos
integer x = 69
integer y = 144
integer width = 283
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Elemento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_elemento from u_em_campo within w_con_activos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 352
integer y = 132
integer width = 183
integer height = 80
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.SetFocus()
	return
Else
	st_delemento.text = cadena
End If


end event

type st_delemento from statictext within w_con_activos
integer x = 544
integer y = 140
integer width = 782
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_3 from u_boton within w_con_activos
event clicked pbm_bnclicked
integer x = 4123
integer y = 288
integer width = 293
integer height = 116
integer taborder = 0
string text = "&Consulta"
end type

event clicked;string filtro 
string cuenta_activo, cuenta_proveedor, clase_inmovilizado

dw_1.setredraw(false)
dw_1.SetFilter("")
st_mensaje.visible = true
st_mensaje.text = "Ejecutando Consulta .... "


If rb_1.checked then 
	dw_1.DataObject = 'dw_con_activos_familia'
ElseIf rb_2.checked then 
	dw_1.DataObject = 'dw_con_activos_clase_inmov'
ElseIf rb_3.checked then 
	dw_1.DataObject = 'dw_con_activos_cuenta_activo'
ElseIf rb_4.checked then 
	dw_1.DataObject = 'dw_con_activos_cuenta_proveedor'
End If
dw_1.SetTransObject(SQLCA)


//dw_1.SetRedraw(False)

if em_cuenta_activo.text = '' or isnull(em_cuenta_activo.text) then
	cuenta_activo = '%'
else
	cuenta_activo = em_cuenta_activo.text 
end if
if em_cuenta_prov.text = '' or isnull(em_cuenta_prov.text) then
	cuenta_proveedor = '%'
else
	cuenta_proveedor = em_cuenta_prov.text 
end if
if em_clase_inmov.text = '' or isnull(em_clase_inmov.text) then
	clase_inmovilizado = '%'
else
	clase_inmovilizado = em_clase_inmov.text 
end if


dw_1.Retrieve(codigo_empresa, cuenta_activo, cuenta_proveedor, clase_inmovilizado, integer(uo_ejercicio.em_ejercicio.text), datetime(date(em_fecha.text)))

st_mensaje.text = " Aplicando Filtro ..... "

dw_1.SetFilter("")

if cbx_baja.checked then
	filtro = " not ISNULL (act_bienesdet_fechabaja) AND  "
else
	filtro = " ISNULL (act_bienesdet_fechabaja) AND  "
end if

IF trim(em_importe.text) <> "" THEN
	filtro = filtro + " act_bienesdet_importe >= " +string(dec(em_importe.text )) + " and "
ELSE
	filtro = filtro + " 1 = 1 and "
END IF

IF trim(em_neto_cont.text) <> "" THEN
	filtro = filtro + " neto <= " +string(dec(em_neto_cont.text )) 
ELSE
	filtro = filtro + " 1 = 1  "
END IF


if dw_1.rowcount() > 1 then
	dw_1.SetFilter(filtro)
	dw_1.Filter()
//	dw_1.SetRedraw(True)	
end if

dw_1.GroupCalc()

st_mensaje.visible = false

dw_1.setredraw(true)

end event

type dw_listado from datawindow within w_con_activos
boolean visible = false
integer x = 133
integer y = 228
integer width = 494
integer height = 360
integer taborder = 90
boolean bringtotop = true
string dataobject = "report_detalle_af"
boolean livescroll = true
end type

type pb_1 from upb_imprimir within w_con_activos
integer x = 4146
integer y = 168
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;//dw_1.SetFilter("")
//
//IF trim(em_elemento.text)<>'' THEN
//	dw_1.SetFilter("act_bienesdet_elemento = " + em_elemento.text )
//	dw_1.Filter()
//END IF
//
////dw_1.SetRedraw(False)

//dw_1.Retrieve(codigo_empresa)
/*
If rb_1.checked then 
	dw_listado.modify("datawindow.header.1.height = 64")
	dw_listado.modify("datawindow.trailer.1.height = 64")
	dw_listado.modify("datawindow.header.2.height = 0")
	dw_listado.modify("datawindow.trailer.2.height = 0")
	dw_listado.modify("datawindow.header.3.height = 0")
	dw_listado.modify("datawindow.trailer.3.height = 0")
ElseIf rb_2.checked then 
		dw_listado.modify("datawindow.header.1.height = 0")
		dw_listado.modify("datawindow.trailer.1.height = 0")
		dw_listado.modify("datawindow.header.2.height = 64")
		dw_listado.modify("datawindow.trailer.2.height = 64")
		dw_listado.modify("datawindow.header.3.height = 0")
		dw_listado.modify("datawindow.trailer.3.height = 0")
	ElseIf rb_3.checked then 
			dw_listado.modify("datawindow.header.1.height = 0")
			dw_listado.modify("datawindow.trailer.1.height = 0")
			dw_listado.modify("datawindow.header.2.height = 0")
			dw_listado.modify("datawindow.trailer.2.height = 0")
			dw_listado.modify("datawindow.header.3.height = 64")
			dw_listado.modify("datawindow.trailer.3.height = 64")
End If
*/
//dw_1.SetRedraw(True)

f_imprimir_datawindow(dw_1)
end event

type pb_2 from upb_salir within w_con_activos
integer x = 4279
integer y = 168
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_1 from groupbox within w_con_activos
integer x = 3621
integer y = 132
integer width = 480
integer height = 280
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agrupa por"
end type

type rb_1 from radiobutton within w_con_activos
integer x = 3657
integer y = 184
integer width = 411
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Familia"
boolean checked = true
end type

type rb_2 from radiobutton within w_con_activos
integer x = 3657
integer y = 240
integer width = 421
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clase Inmov."
end type

type rb_3 from radiobutton within w_con_activos
integer x = 3657
integer y = 288
integer width = 366
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cta. Activo"
end type

type rb_4 from radiobutton within w_con_activos
integer x = 3657
integer y = 348
integer width = 347
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cta. Prov."
end type

type em_cuenta_activo from u_em_campo within w_con_activos
integer x = 1673
integer y = 132
integer width = 325
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "##########"
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_contaplan"
   ue_titulo         = "AYUDA SELECCION DE PLAN DE CONTABILIDAD"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena
integer fecha

fecha = year(date(String(today(), 'dd-mm-yyyy')))
cadena = f_nombre_contaplan(fecha, codigo_empresa,this.text)

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","La cuenta no existe.")
	em_cuenta_activo.SetFocus()
	return
Else
	st_cuenta_activo.text = cadena
End If
end event

type st_2 from statictext within w_con_activos
integer x = 1376
integer y = 144
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cta. Activo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cuenta_activo from statictext within w_con_activos
integer x = 2039
integer y = 140
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_clase_inmov from u_em_campo within w_con_activos
integer x = 352
integer y = 232
integer width = 183
integer height = 80
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_clase"
   ue_titulo         = "AYUDA SELECCION CLASE DE INMOVILIZADO"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

select descripcion
into :cadena
from act_clase
where empresa = :codigo_empresa
and clase = :this.text;

//cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","La clase de inmovilizado no existe.")
	em_clase_inmov.SetFocus()
	return
Else
	st_clase_inmov.text = cadena
End If

end event

type st_4 from statictext within w_con_activos
integer y = 244
integer width = 347
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Clase Inmov.:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_clase_inmov from statictext within w_con_activos
integer x = 544
integer y = 240
integer width = 782
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_cuenta_prov from u_em_campo within w_con_activos
integer x = 1673
integer y = 228
integer width = 325
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "##########"
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_contaplan"
   ue_titulo         = "AYUDA SELECCION DE PLAN DE CONTABILIDAD"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena
integer fecha

fecha = year(date(String(today(), 'dd-mm-yyyy')))
cadena = f_nombre_contaplan(fecha, codigo_empresa,this.text)

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","La cuenta no existe.")
	em_cuenta_prov.SetFocus()
	return
Else
	st_cuenta_prov.text = cadena
End If
end event

type st_7 from statictext within w_con_activos
integer x = 1376
integer y = 240
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cta. Prov.:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cuenta_prov from statictext within w_con_activos
integer x = 2039
integer y = 236
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_con_activos
integer x = 78
integer y = 328
integer height = 308
integer taborder = 50
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_3 from statictext within w_con_activos
integer x = 2734
integer y = 304
integer width = 393
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Imp. Compra >"
boolean focusrectangle = false
end type

type em_importe from editmask within w_con_activos
integer x = 3131
integer y = 300
integer width = 448
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###.00"
end type

type em_fecha from u_em_campo within w_con_activos
integer x = 1381
integer y = 336
integer width = 288
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_6 from statictext within w_con_activos
integer x = 809
integer y = 344
integer width = 503
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Am. Ac. a Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_con_activos
integer x = 809
integer y = 392
integer width = 539
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
boolean enabled = false
string text = "( ~"Fecha Incio amort.~" <= )"
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_con_activos
integer x = 37
integer y = 456
integer width = 4389
integer height = 2508
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_activos_familia"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cbx_baja from checkbox within w_con_activos
integer x = 1829
integer y = 352
integer width = 663
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Activos dados de baja"
end type

type em_neto_cont from editmask within w_con_activos
integer x = 3131
integer y = 200
integer width = 448
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,###.00"
end type

type st_9 from statictext within w_con_activos
integer x = 2738
integer y = 204
integer width = 393
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Neto Cont. <="
boolean focusrectangle = false
end type

type st_mensaje from statictext within w_con_activos
boolean visible = false
integer x = 59
integer y = 2668
integer width = 4343
integer height = 268
boolean bringtotop = true
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 20228454
boolean enabled = false
string text = "Mensaje"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_con_activos
integer x = 2697
integer y = 136
integer width = 914
integer height = 280
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 12632256
string text = "Sólo para Agrupados  por familia"
end type

