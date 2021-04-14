$PBExportHeader$w_busquedas_2_criterios.srw
forward
global type w_busquedas_2_criterios from Window
end type
type criterio from singlelineedit within w_busquedas_2_criterios
end type
type st_4 from statictext within w_busquedas_2_criterios
end type
type st_3 from statictext within w_busquedas_2_criterios
end type
type st_1 from statictext within w_busquedas_2_criterios
end type
type pb_ordenar from picturebutton within w_busquedas_2_criterios
end type
type pb_salir from upb_salir within w_busquedas_2_criterios
end type
type cb_buscar from u_boton within w_busquedas_2_criterios
end type
type criterio2 from singlelineedit within w_busquedas_2_criterios
end type
type st_2 from statictext within w_busquedas_2_criterios
end type
type dw_seleccion from datawindow within w_busquedas_2_criterios
end type
type gb_1 from groupbox within w_busquedas_2_criterios
end type
type gb_3 from groupbox within w_busquedas_2_criterios
end type
type gb_2 from groupbox within w_busquedas_2_criterios
end type
type em_1 from editmask within w_busquedas_2_criterios
end type
type gb_5 from groupbox within w_busquedas_2_criterios
end type
type gb_6 from groupbox within w_busquedas_2_criterios
end type
type gb_4 from groupbox within w_busquedas_2_criterios
end type
end forward

type ws_busquedas from structure
    string str_nom_datawindow
    string str_valor_busqueda
end type

global type w_busquedas_2_criterios from Window
int X=608
int Y=384
int Width=2674
int Height=1344
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
criterio criterio
st_4 st_4
st_3 st_3
st_1 st_1
pb_ordenar pb_ordenar
pb_salir pb_salir
cb_buscar cb_buscar
criterio2 criterio2
st_2 st_2
dw_seleccion dw_seleccion
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
em_1 em_1
gb_5 gb_5
gb_6 gb_6
gb_4 gb_4
end type
global w_busquedas_2_criterios w_busquedas_2_criterios

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
CloseWithReturn(w_busquedas_2_criterios, ll_codigo)

end subroutine

public subroutine f_salir ();CloseWithReturn(w_busquedas_2_criterios,0)
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
criterio.Text      		= cadena2
criterio2.text          = cadena1
is_filtro					= lstr_parametros.s_filtro
dw_seleccion.SetTransObject(SQLCA)
dw_seleccion.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
criterio2.setfocus()
cb_buscar.TriggerEvent(Clicked!)
Return



end event

on w_busquedas_2_criterios.create
this.criterio=create criterio
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.pb_ordenar=create pb_ordenar
this.pb_salir=create pb_salir
this.cb_buscar=create cb_buscar
this.criterio2=create criterio2
this.st_2=create st_2
this.dw_seleccion=create dw_seleccion
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_1=create em_1
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_4=create gb_4
this.Control[]={this.criterio,&
this.st_4,&
this.st_3,&
this.st_1,&
this.pb_ordenar,&
this.pb_salir,&
this.cb_buscar,&
this.criterio2,&
this.st_2,&
this.dw_seleccion,&
this.gb_1,&
this.gb_3,&
this.gb_2,&
this.em_1,&
this.gb_5,&
this.gb_6,&
this.gb_4}
end on

on w_busquedas_2_criterios.destroy
destroy(this.criterio)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_ordenar)
destroy(this.pb_salir)
destroy(this.cb_buscar)
destroy(this.criterio2)
destroy(this.st_2)
destroy(this.dw_seleccion)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_1)
destroy(this.gb_5)
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

type criterio from singlelineedit within w_busquedas_2_criterios
int X=1166
int Y=64
int Width=919
int Height=88
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;// Cambiamos el boton por defecto a Buscar
IF Parent.visible = FALSE Then Return
selecttext(1,100)

end event

event losefocus;// Cambiamos el boton por defecto a Aceptar
cb_buscar.Default  = FALSE
end event

type st_4 from statictext within w_busquedas_2_criterios
int X=1161
int Y=1144
int Width=681
int Height=60
boolean Enabled=false
string Text="Enter o Click selecciona."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_busquedas_2_criterios
int X=768
int Y=1148
int Width=210
int Height=64
boolean Enabled=false
string Text="Orden"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_busquedas_2_criterios
int X=50
int Y=1148
int Width=457
int Height=64
boolean Enabled=false
string Text="Total registros : "
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_ordenar from picturebutton within w_busquedas_2_criterios
int X=987
int Y=1140
int Width=96
int Height=80
string PictureName="c:\bmp\orden.bmp"
string Pointer="\bmp\MANO.CUR"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;string ls_null
SetNull(ls_null)

dw_seleccion.SetSort(ls_null)
dw_seleccion.Sort( )
dw_seleccion.SetFocus()
end on

type pb_salir from upb_salir within w_busquedas_2_criterios
int X=2491
int Y=28
int Width=137
int Height=108
int TabOrder=0
string PictureName="c:\bmp\salir1.bmp"
end type

event clicked;// Devuelve un 0, cancelar la busqueda.
f_salir()
end event

type cb_buscar from u_boton within w_busquedas_2_criterios
int X=2117
int Y=64
int Width=347
int Height=88
int TabOrder=0
string Text="&Buscar"
end type

event clicked;// Recupera las filas en dw_1 usando como parametro el valor "sle_valor"
String tipo_columna
// ls_valor = descripción ; ls_valor2 = formato
String ls_valor,ls_valor2


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

type criterio2 from singlelineedit within w_busquedas_2_criterios
int X=754
int Y=64
int Width=389
int Height=88
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;// Cambiamos el boton por defecto a Buscar
IF Parent.visible = FALSE Then Return
selecttext(1,100)


end event

on losefocus;// Cambiamos el boton por defecto a Aceptar
cb_buscar.Default  = FALSE

end on

type st_2 from statictext within w_busquedas_2_criterios
int X=37
int Y=64
int Width=699
int Height=88
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Criterios de Busqueda"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_seleccion from datawindow within w_busquedas_2_criterios
event key pbm_dwnkey
int X=27
int Y=200
int Width=2455
int Height=912
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;SetRow(row )
string	ll_codigo,el_campo
IF dw_seleccion.RowCount() = 0 THEN Return
el_campo = Describe("#" + string(1) + ".Name")
ll_codigo = f_valor_columna(This,GetRow(),el_campo)
CloseWithReturn(Parent, ll_codigo)

end event

type gb_1 from groupbox within w_busquedas_2_criterios
int X=37
int Y=1104
int Width=713
int Height=128
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_busquedas_2_criterios
int X=1102
int Y=1104
int Width=754
int Height=128
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_busquedas_2_criterios
int X=750
int Y=1104
int Width=347
int Height=128
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_busquedas_2_criterios
int X=485
int Y=1144
int Width=247
int Height=76
boolean BringToTop=true
Alignment Alignment=Center!
boolean Border=false
string Mask="###,###"
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_busquedas_2_criterios
int X=736
int Width=425
int Height=176
int TabOrder=30
string Text="Formato"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within w_busquedas_2_criterios
int X=1152
int Width=955
int Height=176
int TabOrder=40
string Text="Descripción"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_busquedas_2_criterios
int X=27
int Width=2455
int Height=176
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

