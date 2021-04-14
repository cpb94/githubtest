$PBExportHeader$w_busquedas.srw
$PBExportComments$Ventana de ayuda.
forward
global type w_busquedas from window
end type
type st_4 from statictext within w_busquedas
end type
type st_3 from statictext within w_busquedas
end type
type st_1 from statictext within w_busquedas
end type
type pb_ordenar from picturebutton within w_busquedas
end type
type pb_salir from upb_salir within w_busquedas
end type
type cb_buscar from u_boton within w_busquedas
end type
type criterio from singlelineedit within w_busquedas
end type
type st_2 from statictext within w_busquedas
end type
type dw_seleccion from datawindow within w_busquedas
end type
type gb_1 from groupbox within w_busquedas
end type
type gb_4 from groupbox within w_busquedas
end type
type gb_3 from groupbox within w_busquedas
end type
type gb_2 from groupbox within w_busquedas
end type
type em_1 from editmask within w_busquedas
end type
type ws_busquedas from structure within w_busquedas
end type
end forward

type ws_busquedas from structure
    string str_nom_datawindow
    string str_valor_busqueda
end type

global type w_busquedas from window
integer x = 608
integer y = 384
integer width = 4096
integer height = 2624
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_4 st_4
st_3 st_3
st_1 st_1
pb_ordenar pb_ordenar
pb_salir pb_salir
cb_buscar cb_buscar
criterio criterio
st_2 st_2
dw_seleccion dw_seleccion
gb_1 gb_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
em_1 em_1
end type
global w_busquedas w_busquedas

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
CloseWithReturn(w_busquedas, ll_codigo)

end subroutine

public subroutine f_salir ();CloseWithReturn(w_busquedas,0)
end subroutine

event open;
// Variable para parametros de las ventanas
str_parametros	lstr_parametros
lstr_parametros = Message.PowerObjectParm
var_valor_empresa = lstr_parametros.b_empresa
IF IsNull(var_valor_empresa) Then var_valor_empresa = TRUE

This.Title           	= lstr_parametros.s_titulo_ayuda
dw_seleccion.DataObject = lstr_parametros.s_nom_datawindow
criterio.Text      		= lstr_parametros.s_criterio_busqueda
is_filtro					= lstr_parametros.s_filtro

dw_seleccion.SetTransObject(SQLCA)
//dw_seleccion.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
criterio.setfocus()
cb_buscar.TriggerEvent(Clicked!)
Return



end event

on w_busquedas.create
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.pb_ordenar=create pb_ordenar
this.pb_salir=create pb_salir
this.cb_buscar=create cb_buscar
this.criterio=create criterio
this.st_2=create st_2
this.dw_seleccion=create dw_seleccion
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_1=create em_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_1,&
this.pb_ordenar,&
this.pb_salir,&
this.cb_buscar,&
this.criterio,&
this.st_2,&
this.dw_seleccion,&
this.gb_1,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.em_1}
end on

on w_busquedas.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_ordenar)
destroy(this.pb_salir)
destroy(this.cb_buscar)
destroy(this.criterio)
destroy(this.st_2)
destroy(this.dw_seleccion)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_1)
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

type st_4 from statictext within w_busquedas
integer x = 3150
integer y = 2436
integer width = 901
integer height = 72
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

type st_3 from statictext within w_busquedas
integer x = 1970
integer y = 2436
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

type st_1 from statictext within w_busquedas
integer x = 32
integer y = 2436
integer width = 457
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

type pb_ordenar from picturebutton within w_busquedas
integer x = 2190
integer y = 2432
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

type pb_salir from upb_salir within w_busquedas
integer x = 3950
integer y = 24
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

event clicked;// Devuelve un 0, cancelar la busqueda.
f_salir()
end event

type cb_buscar from u_boton within w_busquedas
integer x = 3666
integer y = 36
integer width = 238
integer height = 88
integer taborder = 0
string text = "&Buscar"
end type

event clicked;
// Recupera las filas en dw_1 usando como parametro el valor "sle_valor"
String tipo_columna
string	ls_valor

//IF mid(dw_seleccion.DataObject,1,18) = "dw_ayuda_contaplan" THEN
//	int posicion,num_ceros
//	string  ceros
//	posicion=pos(criterio.text,'.')
//	criterio.text=mid(criterio.text,1,posicion - 1)+mid(criterio.text,posicion+1)
//	num_ceros=f_digitos_contaparam(codigo_empresa,f_ejercicio_activo(codigo_empresa)) - len(criterio.text)
//	choose case num_ceros
//		case 1
//			ceros='0'
//		case 2
//			ceros='00'			
//		case 3
//			ceros='000'			
//		case 4
//			ceros='0000'			
//		case 5
//			ceros='00000'			
//		case 6
//			ceros='000000'						
//		case 7
//			ceros='0000000'			
//		case 8
//			ceros='00000000'						
//		case 9
//			ceros='000000000'
//	end choose		
//	criterio.text=mid(criterio.text,1,posicion - 1)+ceros+mid(criterio.text,posicion)
//end if

IF f_busquedas_uti_parametros(codigo_empresa) = "1" Then
	ls_valor  = Trim(CRITERIO.Text) + "%" 
ELSE
	ls_valor  = "%" + Trim(CRITERIO.Text) + "%" 
END IF

// Comprobar si hay algun filtro para la Datawindow
dw_seleccion.SetFilter("")
dw_seleccion.SetFilter(is_filtro)
dw_seleccion.Filter()

IF var_valor_empresa = FALSE THEN
	var_filas = dw_seleccion.Retrieve(ls_valor)
ELSE	
	// Control filtro para tabla con claves decimales o alfanumericas.		
	tipo_columna = dw_seleccion.Describe("empresa.Coltype")
	CHOOSE CASE Lower (Left (tipo_columna,1))
	CASE "C","c"
		var_filas = dw_seleccion.Retrieve(codigo_empresa,ls_valor)
	CASE ELSE
		var_filas = dw_seleccion.Retrieve(empresa_decimal,ls_valor)
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

type criterio from singlelineedit within w_busquedas
integer x = 617
integer y = 40
integer width = 3031
integer height = 88
integer taborder = 10
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

type st_2 from statictext within w_busquedas
integer x = 41
integer y = 40
integer width = 571
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Criterio de Busqueda"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_seleccion from datawindow within w_busquedas
event key pbm_dwnkey
integer x = 27
integer y = 152
integer width = 4041
integer height = 2216
boolean vscrollbar = true
boolean livescroll = true
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

event rowfocuschanged;This.SelectRow(0, false)
This.SelectRow(currentrow, TRUE)
this.SetRow(currentrow)

end event

type gb_1 from groupbox within w_busquedas
integer x = 18
integer y = 2392
integer width = 713
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_busquedas
integer x = 27
integer width = 3895
integer height = 140
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_busquedas
integer x = 3090
integer y = 2396
integer width = 974
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_busquedas
integer x = 1952
integer y = 2392
integer width = 347
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_1 from editmask within w_busquedas
integer x = 466
integer y = 2432
integer width = 247
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

