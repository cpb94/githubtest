$PBExportHeader$w_busquedas_largo_2.srw
forward
global type w_busquedas_largo_2 from Window
end type
type st_tipo from statictext within w_busquedas_largo_2
end type
type criterio4 from singlelineedit within w_busquedas_largo_2
end type
type criterio3 from u_em_campo within w_busquedas_largo_2
end type
type criterio2 from singlelineedit within w_busquedas_largo_2
end type
type gb_10 from groupbox within w_busquedas_largo_2
end type
type gb_9 from groupbox within w_busquedas_largo_2
end type
type gb_8 from groupbox within w_busquedas_largo_2
end type
type st_4 from statictext within w_busquedas_largo_2
end type
type st_3 from statictext within w_busquedas_largo_2
end type
type st_1 from statictext within w_busquedas_largo_2
end type
type pb_ordenar from picturebutton within w_busquedas_largo_2
end type
type pb_salir from upb_salir within w_busquedas_largo_2
end type
type cb_buscar from u_boton within w_busquedas_largo_2
end type
type criterio from singlelineedit within w_busquedas_largo_2
end type
type dw_seleccion from datawindow within w_busquedas_largo_2
end type
type gb_5 from groupbox within w_busquedas_largo_2
end type
type gb_1 from groupbox within w_busquedas_largo_2
end type
type gb_3 from groupbox within w_busquedas_largo_2
end type
type gb_2 from groupbox within w_busquedas_largo_2
end type
type gb_4 from groupbox within w_busquedas_largo_2
end type
type em_1 from editmask within w_busquedas_largo_2
end type
type st_2 from statictext within w_busquedas_largo_2
end type
end forward

type ws_busquedas from structure
    string str_nom_datawindow
    string str_valor_busqueda
end type

global type w_busquedas_largo_2 from Window
int X=247
int Y=424
int Width=3259
int Height=1600
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
st_tipo st_tipo
criterio4 criterio4
criterio3 criterio3
criterio2 criterio2
gb_10 gb_10
gb_9 gb_9
gb_8 gb_8
st_4 st_4
st_3 st_3
st_1 st_1
pb_ordenar pb_ordenar
pb_salir pb_salir
cb_buscar cb_buscar
criterio criterio
dw_seleccion dw_seleccion
gb_5 gb_5
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
em_1 em_1
st_2 st_2
end type
global w_busquedas_largo_2 w_busquedas_largo_2

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
CloseWithReturn(w_busquedas_largo_2, ll_codigo)

end subroutine

public subroutine f_salir ();CloseWithReturn(w_busquedas_largo_2,0)
end subroutine

event open;// Variable para parametros de las ventanas
string cadena

str_parametros	lstr_parametros
lstr_parametros = Message.PowerObjectParm
var_valor_empresa = lstr_parametros.b_empresa
IF IsNull(var_valor_empresa) Then var_valor_empresa = TRUE

This.Title           	= lstr_parametros.s_titulo_ayuda
dw_seleccion.DataObject = lstr_parametros.s_nom_datawindow
cadena  = upper(trim(lstr_parametros.s_criterio_busqueda))

criterio.Text      		= cadena
criterio2.text          = ""
criterio4.Text          = ""

is_filtro					= lstr_parametros.s_filtro

dw_seleccion.SetTransObject(SQLCA)
dw_seleccion.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
criterio.setfocus()
cb_buscar.TriggerEvent(Clicked!)
Return



end event

on w_busquedas_largo_2.create
this.st_tipo=create st_tipo
this.criterio4=create criterio4
this.criterio3=create criterio3
this.criterio2=create criterio2
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_8=create gb_8
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.pb_ordenar=create pb_ordenar
this.pb_salir=create pb_salir
this.cb_buscar=create cb_buscar
this.criterio=create criterio
this.dw_seleccion=create dw_seleccion
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
this.em_1=create em_1
this.st_2=create st_2
this.Control[]={this.st_tipo,&
this.criterio4,&
this.criterio3,&
this.criterio2,&
this.gb_10,&
this.gb_9,&
this.gb_8,&
this.st_4,&
this.st_3,&
this.st_1,&
this.pb_ordenar,&
this.pb_salir,&
this.cb_buscar,&
this.criterio,&
this.dw_seleccion,&
this.gb_5,&
this.gb_1,&
this.gb_3,&
this.gb_2,&
this.gb_4,&
this.em_1,&
this.st_2}
end on

on w_busquedas_largo_2.destroy
destroy(this.st_tipo)
destroy(this.criterio4)
destroy(this.criterio3)
destroy(this.criterio2)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_ordenar)
destroy(this.pb_salir)
destroy(this.cb_buscar)
destroy(this.criterio)
destroy(this.dw_seleccion)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.em_1)
destroy(this.st_2)
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

type st_tipo from statictext within w_busquedas_largo_2
int X=247
int Y=280
int Width=535
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=128
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Small Fonts"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type criterio4 from singlelineedit within w_busquedas_largo_2
int X=2231
int Y=280
int Width=649
int Height=88
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type criterio3 from u_em_campo within w_busquedas_largo_2
int X=82
int Y=280
int Width=160
int TabOrder=10
long BackColor=16777215
int TextSize=-8
FontCharSet FontCharSet=Ansi!
end type

event modificado;call super::modificado;st_tipo.text = f_nombre_materia( codigo_empresa , criterio3.text )
if trim(st_tipo.text) = "" then
	if Trim(criterio3.text)<>"" Then  f_activar_campo(criterio3)
 	criterio3.text=""
end if
end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmateria"
ue_titulo     =  "VENTANA SELECCION DE TIPO DE MATERIA"
ue_filtro     =  ""
//isle_campo    = This
valor_empresa = TRUE
end event

type criterio2 from singlelineedit within w_busquedas_largo_2
int X=1527
int Y=280
int Width=649
int Height=88
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_10 from groupbox within w_busquedas_largo_2
int X=2208
int Y=224
int Width=699
int Height=172
string Text="Descripción Vtas."
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_9 from groupbox within w_busquedas_largo_2
int X=1504
int Y=224
int Width=699
int Height=172
string Text="Descrip. Producción"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_8 from groupbox within w_busquedas_largo_2
int X=59
int Y=224
int Width=741
int Height=172
string Text="Tipo de producto"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_busquedas_largo_2
int X=1559
int Y=1396
int Width=1367
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

type st_3 from statictext within w_busquedas_largo_2
int X=1065
int Y=1400
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

type st_1 from statictext within w_busquedas_largo_2
int X=91
int Y=1400
int Width=517
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

type pb_ordenar from picturebutton within w_busquedas_largo_2
int X=1353
int Y=1396
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

type pb_salir from upb_salir within w_busquedas_largo_2
int X=3081
int Y=68
int Width=123
int Height=128
int TabOrder=0
string PictureName="c:\bmp\salir1.bmp"
end type

event clicked;// Devuelve un 0, cancelar la busqueda.
f_salir()
end event

type cb_buscar from u_boton within w_busquedas_largo_2
int X=2926
int Y=256
int Width=279
int Height=132
int TabOrder=0
string Text="&Buscar"
end type

event clicked;
// Recupera las filas en dw_1 usando como parametro el valor "sle_valor"
String tipo_columna
string ls_valor,ls_valor2,ls_valor3,ls_valor4

IF f_busquedas_uti_parametros(codigo_empresa) = "1" Then
	ls_valor  = Trim(CRITERIO.Text)  + "%"
	ls_valor2 = Trim(CRITERIO2.Text) + "%"
	ls_valor4 = Trim(CRITERIO4.Text) + "%"
ELSE
	ls_valor  = "%" + Trim(CRITERIO.Text) + "%" 
	ls_valor2 = "%" + Trim(CRITERIO2.Text) + "%"
	ls_valor4 = "%" + Trim(CRITERIO4.Text) + "%"
END IF
if Trim(CRITERIO3.Text) = "" or isnull(CRITERIO3.Text) then
	ls_valor3 = "%"
else
	ls_valor3 = Trim(CRITERIO3.Text)
end if
// Comprobar si hay algun filtro para la Datawindow
dw_seleccion.SetFilter("")
dw_seleccion.SetFilter(is_filtro)
dw_seleccion.Filter()

IF var_valor_empresa = FALSE THEN
	var_filas = dw_seleccion.Retrieve(ls_valor,ls_valor2,ls_valor3,ls_valor4)
ELSE	
	// Control filtro para tabla con claves decimales o alfanumericas.		
	tipo_columna = dw_seleccion.Describe("empresa.Coltype")
	CHOOSE CASE Lower (Left (tipo_columna,1))
	CASE "C","c"
		var_filas = dw_seleccion.Retrieve(codigo_empresa,ls_valor,ls_valor2,ls_valor3,ls_valor4)
	CASE ELSE
		var_filas = dw_seleccion.Retrieve(empresa_decimal,ls_valor,ls_valor2,ls_valor3,ls_valor4)
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

type criterio from singlelineedit within w_busquedas_largo_2
int X=823
int Y=280
int Width=649
int Height=88
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
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

type dw_seleccion from datawindow within w_busquedas_largo_2
event key pbm_dwnkey
int X=59
int Y=424
int Width=3168
int Height=928
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

type gb_5 from groupbox within w_busquedas_largo_2
int X=2917
int Y=224
int Width=302
int Height=176
int TabOrder=50
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_busquedas_largo_2
int X=59
int Y=1356
int Width=901
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

type gb_3 from groupbox within w_busquedas_largo_2
int X=1499
int Y=1356
int Width=1440
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

type gb_2 from groupbox within w_busquedas_largo_2
int X=997
int Y=1356
int Width=466
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

type gb_4 from groupbox within w_busquedas_largo_2
int X=800
int Y=224
int Width=699
int Height=172
string Text="Descripción"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_busquedas_largo_2
int X=617
int Y=1396
int Width=315
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

type st_2 from statictext within w_busquedas_largo_2
int X=59
int Y=116
int Width=699
int Height=88
boolean Enabled=false
boolean BringToTop=true
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

