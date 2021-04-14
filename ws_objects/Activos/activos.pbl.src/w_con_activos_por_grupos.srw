$PBExportHeader$w_con_activos_por_grupos.srw
forward
global type w_con_activos_por_grupos from w_int_con_empresa
end type
type st_1 from statictext within w_con_activos_por_grupos
end type
type em_elemento from u_em_campo within w_con_activos_por_grupos
end type
type st_delemento from statictext within w_con_activos_por_grupos
end type
type dw_1 from u_datawindow within w_con_activos_por_grupos
end type
type cb_3 from u_boton within w_con_activos_por_grupos
end type
type dw_listado from datawindow within w_con_activos_por_grupos
end type
type pb_1 from upb_imprimir within w_con_activos_por_grupos
end type
type pb_2 from upb_salir within w_con_activos_por_grupos
end type
type uo_ejercicio1 from u_ejercicio within w_con_activos_por_grupos
end type
type uo_ejercicio2 from u_ejercicio within w_con_activos_por_grupos
end type
type st_2 from statictext within w_con_activos_por_grupos
end type
type em_centro_trabajo from u_em_campo within w_con_activos_por_grupos
end type
type st_centro_trabajo from statictext within w_con_activos_por_grupos
end type
type st_3 from statictext within w_con_activos_por_grupos
end type
type em_dpto from u_em_campo within w_con_activos_por_grupos
end type
type st_dpto from statictext within w_con_activos_por_grupos
end type
type st_4 from statictext within w_con_activos_por_grupos
end type
type em_subdpto from u_em_campo within w_con_activos_por_grupos
end type
type st_subdpto from statictext within w_con_activos_por_grupos
end type
type st_5 from statictext within w_con_activos_por_grupos
end type
type em_seccion from u_em_campo within w_con_activos_por_grupos
end type
type st_seccion from statictext within w_con_activos_por_grupos
end type
type cbx_elementos from checkbox within w_con_activos_por_grupos
end type
type cbx_secciones from checkbox within w_con_activos_por_grupos
end type
type cbx_subdpto from checkbox within w_con_activos_por_grupos
end type
type kk from structure within w_con_activos_por_grupos
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

global type w_con_activos_por_grupos from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 4242
integer height = 2592
string title = "Consulta de Activos por Grupos / Amortización"
st_1 st_1
em_elemento em_elemento
st_delemento st_delemento
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
pb_1 pb_1
pb_2 pb_2
uo_ejercicio1 uo_ejercicio1
uo_ejercicio2 uo_ejercicio2
st_2 st_2
em_centro_trabajo em_centro_trabajo
st_centro_trabajo st_centro_trabajo
st_3 st_3
em_dpto em_dpto
st_dpto st_dpto
st_4 st_4
em_subdpto em_subdpto
st_subdpto st_subdpto
st_5 st_5
em_seccion em_seccion
st_seccion st_seccion
cbx_elementos cbx_elementos
cbx_secciones cbx_secciones
cbx_subdpto cbx_subdpto
end type
global w_con_activos_por_grupos w_con_activos_por_grupos

type variables


end variables

on w_con_activos_por_grupos.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_elemento=create em_elemento
this.st_delemento=create st_delemento
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_ejercicio1=create uo_ejercicio1
this.uo_ejercicio2=create uo_ejercicio2
this.st_2=create st_2
this.em_centro_trabajo=create em_centro_trabajo
this.st_centro_trabajo=create st_centro_trabajo
this.st_3=create st_3
this.em_dpto=create em_dpto
this.st_dpto=create st_dpto
this.st_4=create st_4
this.em_subdpto=create em_subdpto
this.st_subdpto=create st_subdpto
this.st_5=create st_5
this.em_seccion=create em_seccion
this.st_seccion=create st_seccion
this.cbx_elementos=create cbx_elementos
this.cbx_secciones=create cbx_secciones
this.cbx_subdpto=create cbx_subdpto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_elemento
this.Control[iCurrent+3]=this.st_delemento
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.uo_ejercicio1
this.Control[iCurrent+10]=this.uo_ejercicio2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.em_centro_trabajo
this.Control[iCurrent+13]=this.st_centro_trabajo
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.em_dpto
this.Control[iCurrent+16]=this.st_dpto
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.em_subdpto
this.Control[iCurrent+19]=this.st_subdpto
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.em_seccion
this.Control[iCurrent+22]=this.st_seccion
this.Control[iCurrent+23]=this.cbx_elementos
this.Control[iCurrent+24]=this.cbx_secciones
this.Control[iCurrent+25]=this.cbx_subdpto
end on

on w_con_activos_por_grupos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_elemento)
destroy(this.st_delemento)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_ejercicio1)
destroy(this.uo_ejercicio2)
destroy(this.st_2)
destroy(this.em_centro_trabajo)
destroy(this.st_centro_trabajo)
destroy(this.st_3)
destroy(this.em_dpto)
destroy(this.st_dpto)
destroy(this.st_4)
destroy(this.em_subdpto)
destroy(this.st_subdpto)
destroy(this.st_5)
destroy(this.em_seccion)
destroy(this.st_seccion)
destroy(this.cbx_elementos)
destroy(this.cbx_secciones)
destroy(this.cbx_subdpto)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta de Activos por Grupos / Amortización" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_activos_por_grupos
integer taborder = 120
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_activos_por_grupos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_activos_por_grupos
integer x = 50
integer y = 24
integer width = 4384
integer height = 88
boolean italic = true
end type

type st_1 from statictext within w_con_activos_por_grupos
integer x = 2903
integer y = 228
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
alignment alignment = right!
boolean focusrectangle = false
end type

type em_elemento from u_em_campo within w_con_activos_por_grupos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 3195
integer y = 216
integer width = 183
integer height = 80
integer taborder = 70
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

type st_delemento from statictext within w_con_activos_por_grupos
integer x = 3387
integer y = 224
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
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_con_activos_por_grupos
integer x = 32
integer y = 504
integer width = 4151
integer height = 1940
integer taborder = 0
string dataobject = "dw_con_activos_por_grupos"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_3 from u_boton within w_con_activos_por_grupos
event clicked pbm_bnclicked
integer x = 3625
integer y = 308
integer width = 293
integer height = 116
integer taborder = 80
string text = "&Consulta"
end type

event clicked;call super::clicked;string centro_trabajo, dpto, subdpto, seccion, elemento

if em_centro_trabajo.text <> "" then
	centro_trabajo = em_centro_trabajo.text
else
	centro_trabajo = '%'
end if
if em_dpto.text <> "" then
	dpto = em_dpto.text
else
	dpto = '%'
end if
if em_subdpto.text <> "" then
	subdpto = em_subdpto.text
	if Len(subdpto) < 2 then
		subdpto = "0"+subdpto
	end if
else
	subdpto = '%'
end if
if em_seccion.text <> "" then
	seccion = em_seccion.text
	if Len(seccion) < 2 then
		seccion = "0"+seccion
	end if
else
	seccion = '%'
end if
if em_elemento.text <> "" then
	elemento = em_elemento.text
else
	elemento = '%'
end if

if cbx_elementos.checked then
	dw_1.Object.DataWindow.Detail.Height = 0
else
	dw_1.Object.DataWindow.Detail.Height = 56
end if
if cbx_secciones.checked then
	dw_1.Modify("DataWindow.Header.5.Height=0")	
else
	dw_1.Modify("DataWindow.Header.5.Height=64")	
end if
if cbx_subdpto.checked then
	dw_1.Modify("DataWindow.Header.4.Height=0")	
else
	dw_1.Modify("DataWindow.Header.4.Height=64")	
end if

dw_1.retrieve (codigo_empresa, dec(uo_ejercicio1.em_ejercicio.text), dec(uo_ejercicio2.em_ejercicio.text), &
					centro_trabajo, dpto, subdpto, seccion, elemento)
					
end event

type dw_listado from datawindow within w_con_activos_por_grupos
boolean visible = false
integer x = 133
integer y = 228
integer width = 494
integer height = 360
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_detalle_af"
boolean livescroll = true
end type

type pb_1 from upb_imprimir within w_con_activos_por_grupos
integer x = 3931
integer y = 308
integer width = 119
integer height = 112
integer taborder = 90
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

type pb_2 from upb_salir within w_con_activos_por_grupos
integer x = 4069
integer y = 308
integer width = 119
integer height = 112
integer taborder = 110
boolean bringtotop = true
end type

type uo_ejercicio1 from u_ejercicio within w_con_activos_por_grupos
integer x = 78
integer y = 120
integer height = 308
integer taborder = 10
end type

on uo_ejercicio1.destroy
call u_ejercicio::destroy
end on

type uo_ejercicio2 from u_ejercicio within w_con_activos_por_grupos
integer x = 731
integer y = 128
integer height = 308
integer taborder = 20
boolean bringtotop = true
end type

on uo_ejercicio2.destroy
call u_ejercicio::destroy
end on

type st_2 from statictext within w_con_activos_por_grupos
integer x = 1486
integer y = 144
integer width = 398
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
string text = "Centro Trabajo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_centro_trabajo from u_em_campo within w_con_activos_por_grupos
integer x = 1893
integer y = 136
integer width = 183
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_fcampo1"
ue_titulo         = "AYUDA SELECCION 1er DIGITO"
ue_filtro         = ""

end event

event modificado;call super::modificado;String 	cadena
dec codigo

codigo = dec(this.text)
select texto
into :cadena
from act_fcampo1
where empresa = :codigo_empresa
and codigo = :codigo;

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.SetFocus()
	return
Else
	st_centro_trabajo.text = cadena
End If



end event

type st_centro_trabajo from statictext within w_con_activos_por_grupos
integer x = 2085
integer y = 144
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
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_activos_por_grupos
integer x = 1486
integer y = 228
integer width = 398
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
string text = "Departamento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_dpto from u_em_campo within w_con_activos_por_grupos
integer x = 1893
integer y = 220
integer width = 183
integer height = 80
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_fcampo2"
ue_titulo         = "AYUDA SELECCION 2º DIGITO"
ue_filtro         = ""

end event

event modificado;call super::modificado;String 	cadena
dec codigo

codigo = dec(this.text)
select texto
into :cadena
from act_fcampo2
where empresa = :codigo_empresa
and codigo = :codigo;

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_dpto.SetFocus()
	return
Else
	st_dpto.text = cadena
End If



end event

type st_dpto from statictext within w_con_activos_por_grupos
integer x = 2085
integer y = 228
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
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_activos_por_grupos
integer x = 1408
integer y = 312
integer width = 475
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
string text = "Subdepartamento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_subdpto from u_em_campo within w_con_activos_por_grupos
integer x = 1893
integer y = 304
integer width = 183
integer height = 80
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_fcampo3"
ue_titulo         = "AYUDA SELECCION 3º y 4º DIGITO"
ue_filtro         = ""

end event

event modificado;call super::modificado;String 	cadena
dec codigo

codigo = dec(this.text)
select texto
into :cadena
from act_fcampo3
where empresa = :codigo_empresa
and codigo = :codigo;

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_subdpto.SetFocus()
	return
Else
	st_subdpto.text = cadena
End If



end event

type st_subdpto from statictext within w_con_activos_por_grupos
integer x = 2085
integer y = 312
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
boolean border = true
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_activos_por_grupos
integer x = 2903
integer y = 140
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
string text = "Sección:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_seccion from u_em_campo within w_con_activos_por_grupos
integer x = 3195
integer y = 132
integer width = 183
integer height = 80
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "########"
end type

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_fcampo4"
ue_titulo         = "AYUDA SELECCION 5º y 6º DIGITO"
ue_filtro         = ""

end event

event modificado;call super::modificado;String 	cadena
dec codigo

codigo = dec(this.text)
select texto
into :cadena
from act_fcampo4
where empresa = :codigo_empresa
and codigo = :codigo;

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_seccion.SetFocus()
	return
Else
	st_seccion.text = cadena
End If



end event

type st_seccion from statictext within w_con_activos_por_grupos
integer x = 3387
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
boolean border = true
boolean focusrectangle = false
end type

type cbx_elementos from checkbox within w_con_activos_por_grupos
integer x = 2994
integer y = 300
integer width = 530
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ocultar Elementos"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type cbx_secciones from checkbox within w_con_activos_por_grupos
integer x = 2999
integer y = 364
integer width = 530
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ocultar Secciones"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type cbx_subdpto from checkbox within w_con_activos_por_grupos
integer x = 2784
integer y = 428
integer width = 745
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ocultar Subdepartamentos"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

