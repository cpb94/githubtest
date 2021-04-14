$PBExportHeader$w_busquedas_largo.srw
forward
global type w_busquedas_largo from window
end type
type criterio2 from singlelineedit within w_busquedas_largo
end type
type gb_7 from groupbox within w_busquedas_largo
end type
type st_4 from statictext within w_busquedas_largo
end type
type st_3 from statictext within w_busquedas_largo
end type
type st_1 from statictext within w_busquedas_largo
end type
type pb_ordenar from picturebutton within w_busquedas_largo
end type
type pb_salir from upb_salir within w_busquedas_largo
end type
type cb_buscar from u_boton within w_busquedas_largo
end type
type criterio from singlelineedit within w_busquedas_largo
end type
type st_2 from statictext within w_busquedas_largo
end type
type dw_seleccion from datawindow within w_busquedas_largo
end type
type gb_5 from groupbox within w_busquedas_largo
end type
type gb_1 from groupbox within w_busquedas_largo
end type
type gb_3 from groupbox within w_busquedas_largo
end type
type gb_2 from groupbox within w_busquedas_largo
end type
type em_1 from editmask within w_busquedas_largo
end type
type gb_6 from groupbox within w_busquedas_largo
end type
type gb_4 from groupbox within w_busquedas_largo
end type
type ws_busquedas from structure within w_busquedas_largo
end type
end forward

type ws_busquedas from structure
    string str_nom_datawindow
    string str_valor_busqueda
end type

global type w_busquedas_largo from window
integer x = 247
integer y = 424
integer width = 3387
integer height = 2444
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
criterio2 criterio2
gb_7 gb_7
st_4 st_4
st_3 st_3
st_1 st_1
pb_ordenar pb_ordenar
pb_salir pb_salir
cb_buscar cb_buscar
criterio criterio
st_2 st_2
dw_seleccion dw_seleccion
gb_5 gb_5
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
em_1 em_1
gb_6 gb_6
gb_4 gb_4
end type
global w_busquedas_largo w_busquedas_largo

type variables
	// Filtro para la DataWindow
string	is_filtro
dec{0}     var_filas
Boolean  var_valor_empresa


end variables

forward prototypes
public subroutine f_volver ()
public subroutine f_salir ()
end prototypes

public subroutine f_volver ();string	ll_codigo,el_campo
IF dw_seleccion.RowCount() = 0 THEN Return
el_campo = dw_seleccion.Describe("#" + string(1) + ".Name")
ll_codigo = f_valor_columna(dw_seleccion,dw_seleccion.GetRow(),el_campo)
CloseWithReturn(w_busquedas_largo, ll_codigo)

end subroutine

public subroutine f_salir ();CloseWithReturn(w_busquedas_largo,0)
end subroutine

event open;// Variable para parametros de las ventanas
string cadena,cadena1,cadena2,caracter,cadena_x
long formato,posicion_x

str_parametros	lstr_parametros
lstr_parametros = Message.PowerObjectParm
var_valor_empresa = lstr_parametros.b_empresa
IF IsNull(var_valor_empresa) Then var_valor_empresa = TRUE

This.Title           	= lstr_parametros.s_titulo_ayuda
dw_seleccion.DataObject = lstr_parametros.s_nom_datawindow
cadena  = upper(trim(lstr_parametros.s_criterio_busqueda))
formato = pos(cadena," ")
if formato = 0 then
	posicion_x = pos(left(cadena,5),"X")
   if posicion_x <> 0 then
		caracter = mid(cadena,posicion_x - 1,1)
		if asc(caracter) >= 40 and asc(caracter) <= 57 then
			cadena1  = cadena
	   	cadena2  = ""
		else
	   	cadena1  = ""
	   	cadena2  = cadena
		end if
	else
		cadena1 = ""
	   cadena2 = cadena
	end if
else
	cadena1 = trim(left(cadena,formato))
	posicion_x = pos(left(cadena1,5),"X")
	if posicion_x = 0 then
		cadena1 = ""
		cadena2 = cadena
	else
		caracter = mid(cadena1,posicion_x - 1,1)
		if asc(caracter) >= 48 and asc(caracter) <= 57 then		
		   cadena2 = trim(mid(cadena,formato,len(cadena)))
		else
			cadena1 = ""
			cadena2 = cadena
		end if
	end if
end if

criterio2.text          = cadena1
criterio.Text      		= cadena2

is_filtro					= lstr_parametros.s_filtro

dw_seleccion.SetTransObject(SQLCA)
dw_seleccion.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
criterio2.setfocus()
cb_buscar.TriggerEvent(Clicked!)
Return



end event

on w_busquedas_largo.create
this.criterio2=create criterio2
this.gb_7=create gb_7
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.pb_ordenar=create pb_ordenar
this.pb_salir=create pb_salir
this.cb_buscar=create cb_buscar
this.criterio=create criterio
this.st_2=create st_2
this.dw_seleccion=create dw_seleccion
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_1=create em_1
this.gb_6=create gb_6
this.gb_4=create gb_4
this.Control[]={this.criterio2,&
this.gb_7,&
this.st_4,&
this.st_3,&
this.st_1,&
this.pb_ordenar,&
this.pb_salir,&
this.cb_buscar,&
this.criterio,&
this.st_2,&
this.dw_seleccion,&
this.gb_5,&
this.gb_1,&
this.gb_3,&
this.gb_2,&
this.em_1,&
this.gb_6,&
this.gb_4}
end on

on w_busquedas_largo.destroy
destroy(this.criterio2)
destroy(this.gb_7)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_ordenar)
destroy(this.pb_salir)
destroy(this.cb_buscar)
destroy(this.criterio)
destroy(this.st_2)
destroy(this.dw_seleccion)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_1)
destroy(this.gb_6)
destroy(this.gb_4)
end on

event key;string	ll_codigo,el_campo
IF key = KeyUpArrow!    Then f_cursor_arriba(dw_seleccion)
IF key = KeyDownArrow!  Then f_cursor_abajo(dw_seleccion)
IF key = KeyPageUp!     Then f_pagina_arriba(dw_seleccion)
IF key = KeyPageDown!   Then f_pagina_abajo(dw_seleccion)
IF Key = KeyEnter! Then
   IF dw_seleccion.RowCount() = 0 THEN Return
	el_campo = dw_seleccion.Describe("#" + string(1) + ".Name")
	ll_codigo = f_valor_columna(dw_seleccion,dw_seleccion.GetRow(),el_campo)
   CloseWithReturn(This, ll_codigo)
END IF
end event

event timer;IF var_filas= 0 THEN
	  pb_salir.TriggerEvent(Clicked!)	
	  Return
END IF
IF var_filas= 1 THEN
	dw_seleccion.TriggerEvent(Clicked!)		// Pulsar el boton Aceptar
	return
END IF
end event

type criterio2 from singlelineedit within w_busquedas_largo
integer x = 800
integer y = 88
integer width = 494
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type gb_7 from groupbox within w_busquedas_largo
integer x = 763
integer width = 571
integer height = 224
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Formato"
end type

type st_4 from statictext within w_busquedas_largo
integer x = 1536
integer y = 2240
integer width = 1367
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Enter o Click selecciona."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_busquedas_largo
integer x = 1042
integer y = 2244
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Orden"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_busquedas_largo
integer x = 69
integer y = 2244
integer width = 517
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total registros : "
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type pb_ordenar from picturebutton within w_busquedas_largo
integer x = 1330
integer y = 2240
integer width = 96
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\orden.bmp"
end type

on clicked;string ls_null
SetNull(ls_null)

dw_seleccion.SetSort(ls_null)
dw_seleccion.Sort( )
dw_seleccion.SetFocus()
end on

type pb_salir from upb_salir within w_busquedas_largo
integer x = 3186
integer y = 52
integer width = 123
integer height = 128
integer taborder = 0
end type

event clicked;// Devuelve un 0, cancelar la busqueda.
f_salir()
end event

type cb_buscar from u_boton within w_busquedas_largo
integer x = 2793
integer y = 32
integer width = 343
integer height = 184
integer taborder = 0
string text = "&Buscar"
end type

event clicked;
// Recupera las filas en dw_1 usando como parametro el valor "sle_valor"
String tipo_columna
string ls_valor,ls_valor2

IF f_busquedas_uti_parametros(codigo_empresa) = "1" Then
	ls_valor  = Trim(CRITERIO.Text) + "%" 
//	ls_valor2 = Trim(CRITERIO2.Text) + "%" 
ELSE
	ls_valor  = "%" + Trim(CRITERIO.Text) + "%" 
//	ls_valor2 = "%" + Trim(CRITERIO2.Text) + "%" 
END IF
ls_valor2 = Trim(CRITERIO2.Text) + "%"
// Comprobar si hay algun filtro para la Datawindow
dw_seleccion.SetFilter("")
dw_seleccion.SetFilter(is_filtro)
dw_seleccion.Filter()

IF var_valor_empresa = FALSE THEN
	var_filas = dw_seleccion.Retrieve(ls_valor,ls_valor2)
ELSE	
	// Control filtro para tabla con claves decimales o alfanumericas.		
	tipo_columna = dw_seleccion.Describe("empresa.Coltype")
	CHOOSE CASE Lower (Left (tipo_columna,1))
	CASE "C","c"
		var_filas = dw_seleccion.Retrieve(codigo_empresa,ls_valor,ls_valor2)
	CASE ELSE
		var_filas = dw_seleccion.Retrieve(empresa_decimal,ls_valor,ls_valor2)
	END CHOOSE
END IF
CHOOSE CASE dw_seleccion.rowcount()
	CASE 1
		f_volver()
	CASE 0
		f_salir()
	CASE ELSE
		em_1.text = string(dw_seleccion.rowcount())
END CHOOSE






end event

type criterio from singlelineedit within w_busquedas_largo
integer x = 1362
integer y = 88
integer width = 1381
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event getfocus;// Cambiamos el boton por defecto a Buscar
IF Parent.visible = FALSE Then Return
selecttext(1,100)


end event

on losefocus;// Cambiamos el boton por defecto a Aceptar
cb_buscar.Default  = FALSE

end on

type st_2 from statictext within w_busquedas_largo
integer x = 59
integer y = 88
integer width = 699
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Criterios de Busqueda"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_seleccion from datawindow within w_busquedas_largo
event key pbm_dwnkey
integer x = 32
integer y = 240
integer width = 3314
integer height = 1940
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;SetRow(row )
string	ll_codigo,el_campo
IF dw_seleccion.RowCount() = 0 THEN Return
el_campo = Describe("#" + string(1) + ".Name")
ll_codigo = f_valor_columna(This,GetRow(),el_campo)
CloseWithReturn(Parent, ll_codigo)

end event

event retrieveend;//CHOOSE CASE This.rowcount()
//	CASE 1
//		f_volver()
//	CASE 0
//		f_salir()
//	CASE ELSE
//		em_1.text = string(This.rowcount())
//END CHOOSE
//
//
//
end event

type gb_5 from groupbox within w_busquedas_largo
integer x = 2784
integer width = 361
integer height = 224
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_busquedas_largo
integer x = 37
integer y = 2200
integer width = 901
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_busquedas_largo
integer x = 1477
integer y = 2200
integer width = 1440
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_busquedas_largo
integer x = 974
integer y = 2200
integer width = 466
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_1 from editmask within w_busquedas_largo
integer x = 594
integer y = 2240
integer width = 315
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
alignment alignment = center!
string mask = "###,###"
end type

type gb_6 from groupbox within w_busquedas_largo
integer x = 1326
integer width = 1449
integer height = 224
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Descripción"
end type

type gb_4 from groupbox within w_busquedas_largo
integer x = 37
integer width = 2738
integer height = 224
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

