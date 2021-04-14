$PBExportHeader$w_con_almubimapa.srw
$PBExportComments$Consulta mapa de ubicaciones.
forward
global type w_con_almubimapa from window
end type
type pb_1 from upb_salir within w_con_almubimapa
end type
type sle_codigo_almacen from u_em_campo within w_con_almubimapa
end type
type dw_formatos from datawindow within w_con_almubimapa
end type
type st_nombre_almacen from statictext within w_con_almubimapa
end type
type st_1 from statictext within w_con_almubimapa
end type
type dw_1 from datawindow within w_con_almubimapa
end type
end forward

global type w_con_almubimapa from window
integer x = 14
integer y = 200
integer width = 2894
integer height = 1572
boolean titlebar = true
string title = "Consulta mapa ubicaciones"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
boolean center = true
pb_1 pb_1
sle_codigo_almacen sle_codigo_almacen
dw_formatos dw_formatos
st_nombre_almacen st_nombre_almacen
st_1 st_1
dw_1 dw_1
end type
global w_con_almubimapa w_con_almubimapa

type variables


end variables

on key;IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) THEN

	str_parametros  istr_parametros	
   istr_parametros.b_empresa = TRUE
	istr_parametros.s_titulo_ayuda   = "AYUDA SELECCION DE ALMACENES"
	istr_parametros.s_nom_datawindow = "dw_ayuda_almacenes"
	istr_parametros.i_nargumentos    = 0

	// Lanza la ventana de ayuda para Busquedas de codigos

	IF Not IsNumber(sle_codigo_almacen.Text) THEN
			String ll_clave
			istr_parametros.s_criterio_busqueda = sle_codigo_almacen.Text

			OpenWithParm(w_busquedas,istr_parametros)

			ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...

			IF ll_clave <> "" THEN				// Returns 0 on cancel
					sle_codigo_almacen.text = ll_clave
					sle_codigo_almacen.TriggerEvent(Modified!)	// Mostrara la descripcion
			ELSE
					RETURN
			END IF

	END IF

END IF
end on

on open;str_parametros valores
valores = Message.PowerObjectParm
codigo_empresa = valores.s_argumentos[2]
sle_codigo_almacen.text = valores.s_argumentos[3]

valores.b_empresa = TRUE

f_no_nulo(sle_codigo_almacen)

dw_1.SetTransObject(SQLCA)
dw_formatos.SetTransObject(sqlca)       
dw_formatos.visible = FALSE

IF trim(sle_codigo_almacen.text) = "" THEN
	f_activar_campo(sle_codigo_almacen)
	return
ELSE
	dw_1.retrieve(codigo_empresa,sle_codigo_almacen.text)
	dw_1.SetFocus()
END IF






end on

on w_con_almubimapa.create
this.pb_1=create pb_1
this.sle_codigo_almacen=create sle_codigo_almacen
this.dw_formatos=create dw_formatos
this.st_nombre_almacen=create st_nombre_almacen
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.pb_1,&
this.sle_codigo_almacen,&
this.dw_formatos,&
this.st_nombre_almacen,&
this.st_1,&
this.dw_1}
end on

on w_con_almubimapa.destroy
destroy(this.pb_1)
destroy(this.sle_codigo_almacen)
destroy(this.dw_formatos)
destroy(this.st_nombre_almacen)
destroy(this.st_1)
destroy(this.dw_1)
end on

type pb_1 from upb_salir within w_con_almubimapa
integer x = 2665
integer y = 28
integer width = 123
integer height = 108
integer taborder = 20
string picturename = "exit!"
end type

on clicked;CloseWithReturn(Parent,-1)

end on

type sle_codigo_almacen from u_em_campo within w_con_almubimapa
integer x = 430
integer y = 32
integer width = 293
integer taborder = 10
end type

on rbuttondown;call u_em_campo::rbuttondown;	
   str_parametros  istr_parametros	
   istr_parametros.b_empresa = TRUE
	istr_parametros.s_titulo_ayuda   = "AYUDA SELECCION DE ALMACENES"
	istr_parametros.s_nom_datawindow = "dw_ayuda_almacenes"
	istr_parametros.i_nargumentos    = 0

	// Lanza la ventana de ayuda para Busquedas de codigos

	IF Not IsNumber(sle_codigo_almacen.Text) THEN
			String ll_clave
			istr_parametros.s_criterio_busqueda = sle_codigo_almacen.Text

			OpenWithParm(w_busquedas,istr_parametros)

			ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...

			IF ll_clave <> "" THEN				// Returns 0 on cancel
					sle_codigo_almacen.text = ll_clave
					sle_codigo_almacen.TriggerEvent(Modified!)	// Mostrara la descripcion
			ELSE
					RETURN
			END IF

	END IF

end on

on modified;call u_em_campo::modified;if Trim(sle_codigo_almacen.text)="" then
   f_activar_campo(sle_codigo_almacen)
   return
end if

st_nombre_almacen.text = f_nombre_almacen(codigo_empresa,sle_codigo_almacen.text)
dw_1.retrieve(codigo_empresa,sle_codigo_almacen.text)
dw_1.SetFocus()

end on

type dw_formatos from datawindow within w_con_almubimapa
boolean visible = false
integer x = 503
integer y = 980
integer width = 1760
integer height = 420
string dataobject = "dw_ubiformatos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

on losefocus;	// Si pulsamos fuera de la datawindow formatos, la ocultamos

dw_formatos.Visible = FALSE

end on

type st_nombre_almacen from statictext within w_con_almubimapa
integer x = 745
integer y = 36
integer width = 773
integer height = 84
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

type st_1 from statictext within w_con_almubimapa
integer x = 91
integer y = 48
integer width = 306
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Almacén"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_almubimapa
integer x = 23
integer y = 188
integer width = 2775
integer height = 780
string dataobject = "dw_con_almubimapa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;long  ll_fila_actual
str_parametros valores

ll_fila_actual = row

IF dw_1.RowCount() <> 0 AND ll_fila_actual <> 0 THEN

	valores.s_argumentos[1]=sle_codigo_almacen.text
	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"zona")
	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"fila_desde"))
	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"fila_hasta"))
	valores.s_argumentos[5]=string(dw_1.getitemNumber(ll_fila_actual,"altura_desde"))
	valores.s_argumentos[6]=string(dw_1.getitemNumber(ll_fila_actual,"altura_hasta"))
	CloseWithReturn(Parent,valores)

END IF
end event

event clicked;long ll_fila_actual
String ls_cod_zona
Integer li_fil_desde, li_fil_hasta
Integer li_alt_desde, li_alt_hasta

ll_fila_actual = row

IF dw_1.RowCount() <> 0 AND ll_fila_actual <> 0 THEN

	This.SelectRow(0,FALSE)
	This.SelectRow(ll_fila_actual,TRUE)

	ls_cod_zona = dw_1.GetItemString(ll_fila_actual,"zona")
	li_fil_desde= dw_1.GetItemNumber(ll_fila_actual,"fila_desde")
	li_fil_hasta= dw_1.GetItemNumber(ll_fila_actual,"fila_hasta")
	li_alt_desde= dw_1.GetItemNumber(ll_fila_actual,"altura_desde")
	li_alt_hasta= dw_1.GetItemNumber(ll_fila_actual,"altura_hasta")

	dw_formatos.Retrieve( &
			codigo_empresa,sle_codigo_almacen.text, ls_cod_zona, &
			li_fil_desde, li_fil_hasta, li_alt_desde, li_alt_hasta)
	dw_formatos.Visible = TRUE
	dw_formatos.SetFocus()

END IF


end event

