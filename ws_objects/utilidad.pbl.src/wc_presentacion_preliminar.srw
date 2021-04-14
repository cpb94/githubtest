$PBExportHeader$wc_presentacion_preliminar.srw
forward
global type wc_presentacion_preliminar from window
end type
type pb_linea from picturebutton within wc_presentacion_preliminar
end type
type pb_italica from picturebutton within wc_presentacion_preliminar
end type
type pb_negrilla from picturebutton within wc_presentacion_preliminar
end type
type rb_visible from radiobutton within wc_presentacion_preliminar
end type
type st_tamaño from statictext within wc_presentacion_preliminar
end type
type em_tamanyo from editmask within wc_presentacion_preliminar
end type
type sle_objeto from singlelineedit within wc_presentacion_preliminar
end type
type sle_texto from multilineedit within wc_presentacion_preliminar
end type
type pb_imprimir from upb_imprimir within wc_presentacion_preliminar
end type
type pb_alindere from picturebutton within wc_presentacion_preliminar
end type
type pb_alincent from picturebutton within wc_presentacion_preliminar
end type
type pb_alinizq from picturebutton within wc_presentacion_preliminar
end type
type rb_regla from radiobutton within wc_presentacion_preliminar
end type
type sle_posicion from singlelineedit within wc_presentacion_preliminar
end type
type sle_pagina from singlelineedit within wc_presentacion_preliminar
end type
type st_objeto from statictext within wc_presentacion_preliminar
end type
type dw_imprimir from datawindow within wc_presentacion_preliminar
end type
type pb_2 from picturebutton within wc_presentacion_preliminar
end type
type pb_salvar_fichero from picturebutton within wc_presentacion_preliminar
end type
type cb_zoom from u_boton within wc_presentacion_preliminar
end type
type pb_inc_zoom from picturebutton within wc_presentacion_preliminar
end type
type pb_dec_zoom from picturebutton within wc_presentacion_preliminar
end type
type pb_salir from picturebutton within wc_presentacion_preliminar
end type
type pb_anterior from picturebutton within wc_presentacion_preliminar
end type
type pb_ultimo from picturebutton within wc_presentacion_preliminar
end type
type pb_primero from picturebutton within wc_presentacion_preliminar
end type
type pb_siguiente from picturebutton within wc_presentacion_preliminar
end type
end forward

shared variables

end variables

global type wc_presentacion_preliminar from window
integer width = 5696
integer height = 3480
boolean titlebar = true
string title = "Presentación Preliminar"
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 8421504
pb_linea pb_linea
pb_italica pb_italica
pb_negrilla pb_negrilla
rb_visible rb_visible
st_tamaño st_tamaño
em_tamanyo em_tamanyo
sle_objeto sle_objeto
sle_texto sle_texto
pb_imprimir pb_imprimir
pb_alindere pb_alindere
pb_alincent pb_alincent
pb_alinizq pb_alinizq
rb_regla rb_regla
sle_posicion sle_posicion
sle_pagina sle_pagina
st_objeto st_objeto
dw_imprimir dw_imprimir
pb_2 pb_2
pb_salvar_fichero pb_salvar_fichero
cb_zoom cb_zoom
pb_inc_zoom pb_inc_zoom
pb_dec_zoom pb_dec_zoom
pb_salir pb_salir
pb_anterior pb_anterior
pb_ultimo pb_ultimo
pb_primero pb_primero
pb_siguiente pb_siguiente
end type
global wc_presentacion_preliminar wc_presentacion_preliminar

type variables
// Valor de control del zoom
integer ii_valor_zoom = 100
// Valores minimos, alto y ancho
integer ii_alto_min, ii_ancho_min
// Indica si aparece o no la regla de medida
string is_regla_visible = "yes"
str_parametros istr_parametros	
Datawindow dw_data
String  objeto,tipo,ante_objeto,tipoobj
Integer elemento
Boolean campo_visible
String   cri[],pal[]
STring   cadena,palabra,letra
Integer  re,contador1,contador2
end variables

forward prototypes
public subroutine wf_size_dw (ref datawindow adw_datawindow)
public subroutine f_pagina ()
public function boolean f_control ()
end prototypes

public subroutine wf_size_dw (ref datawindow adw_datawindow);/////////////////////////////////////////////////////////////////
//																					//
// Ajusta el tamaño de una Datawindow a la ventana a la que		//
// pertenece.																	//
//																					//
// El tamaño de la DataWindow se calculo:								//
//		- Ancho:	El numero de columnas que posee						//
//		- Alto : El tamaño de las partes de la report				//
//																					//
/////////////////////////////////////////////////////////////////

environment le_env

int li_num_columnas, li_cont, li_indice, li_controles

int li_col_x							// Coordenada X de una columna en la report
int li_col_ancho						// Ancho de una columna
int li_max_x = 0						// Distancia maxima de la ultima columna
int li_max_y = 0						// Altura maxima de la Datawindow
int li_dw_ancho, li_dw_alto		//	Ancho y alto de la DataWindow
int li_vent_ancho, li_vent_alto	// Ancho y alto de la ventana
int li_pant_ancho, li_pant_alto	// Ancho y alto de la pantalla

int li_nuevo_ancho, li_nuevo_alto
int li_vscroll_ancho = 78
int li_hscroll_alto = 69

dragobject ldo_temp


adw_datawindow.SetRedraw(FALSE)

		// Numero de columnas en la DataWindow

li_num_columnas = Integer(adw_datawindow.Describe("DataWindow.column.Count"))

		// Calcula el ancho de cada columna y obtiene el ancho maximo de la Datawindow

FOR li_cont = 1 TO li_num_columnas

	li_col_x = Integer(adw_datawindow.Describe("#"+String(li_cont)+".X"))
	li_col_ancho = Integer(adw_datawindow.Describe("#"+String(li_cont)+".Width"))

	IF li_col_x + li_col_ancho > li_max_x THEN

			li_max_x = li_col_x + li_col_ancho
	END IF

NEXT

		// Calculo de la Altura de la DataWindow

li_max_y = Integer(adw_datawindow.Describe("DataWindow.Summary.Height"))
li_max_y = li_max_y + Integer(adw_datawindow.Describe("DataWindow.Detail.Height"))
li_max_y = li_max_y + Integer(adw_datawindow.Describe("DataWindow.Header.Height"))
li_max_y = li_max_y + Integer(adw_datawindow.Describe("DataWindow.Footer.Height"))
li_max_y = li_max_y + Integer(adw_datawindow.Describe("DataWindow.Trail_Footer.Height"))

li_nuevo_ancho = adw_datawindow.X + li_max_x + li_vscroll_ancho + 25
li_nuevo_alto  = adw_datawindow.Y + li_max_y + li_hscroll_alto + 25

IF li_nuevo_ancho < ii_ancho_min THEN li_nuevo_ancho = ii_ancho_min
IF li_nuevo_alto < ii_alto_min THEN li_nuevo_alto = ii_alto_min

		// Obtiene informacion de los datos de la pantalla

GetEnvironment(le_env)

li_pant_alto  = PixelsToUnits(le_env.screenheight, YPixelsToUnits!)
li_pant_ancho = PixelsToUnits(le_env.screenwidth, XPixelsToUnits!)

		// Maximo ancho de la DataWindow respecto a la pantalla

IF li_nuevo_ancho >= li_pant_ancho THEN

		adw_datawindow.hscrollbar = true
		li_dw_ancho = li_pant_ancho - 75
		li_vent_ancho = li_pant_ancho

ELSE

		adw_datawindow.hscrollbar = true
		li_dw_ancho = li_nuevo_ancho
		li_vent_ancho = li_nuevo_ancho + adw_datawindow.X + 75

END IF

		// Maxima altura en funcion de la pantalla

IF li_nuevo_alto >= li_pant_alto THEN

		li_vent_alto = li_pant_alto

ELSE

		li_vent_alto = li_nuevo_alto + adw_datawindow.Y + 350

END IF

li_dw_alto = li_pant_alto - 350



		// Colocar la ventana al tamaño optimo

This.Resize(li_vent_ancho, li_vent_alto)

		//	Centrar la ventana en la pantalla

This.Move(	(li_pant_ancho - li_vent_ancho) / 2, &
				(li_pant_alto - li_vent_alto) / 2 )

		// Dar el tamaño a la datawindow

adw_datawindow.Resize(li_dw_ancho,li_dw_alto)

adw_datawindow.SetRedraw(TRUE)
end subroutine

public subroutine f_pagina ();IF dw_imprimir.RowCount() <> 0 Then	
  sle_pagina.text   = "Páginas:" +String(dw_imprimir.GetItemNumber(1,"total_paginas"))
END IF


end subroutine

public function boolean f_control ();
cadena = dw_data.Describe("Datawindow.Table.Select")
contador1 = 0 
contador2 = 0
Return false
//cri[1] = "1"
//cri[2] = "1"
//cri[3] = "1"
//cri[4] = "1"
//cri[5] = "1"
//cri[6] = "1"
//cri[7] = "1"
//cri[8] = "1"
//For re = 1 To Len(cadena)
//	letra   = Mid(cadena,re,1)
//	IF letra = ":" Then
//		contador2 = contador2 +1
//		cri[contador2] = f_valor_columna(dw_data,1,pal[contador1 - 1])
////		f_mensaje("Argumento",		cri[contador2])
//	END IF
//	IF letra <> '"' and letra<>"(" and letra<>")" Then
//		IF len(Trim(palabra)) <> 0 and (letra = " "  or letra= "." )Then
//			contador1= contador1 +1
//			pal[contador1] = Trim(palabra)
////			f_mensaje(Trim(palabra),"")
//			palabra =""
//		ELSE
//				palabra = palabra + letra
//		END IF
//	END IF
//Next
////CHOOSE CASE contador2
////	CASE 1
////		dw_imprimir.Retrieve(cri[1])
////	CASE 2
////		dw_imprimir.Retrieve(cri[1],cri[2])
////	CASE 3
////		dw_imprimir.Retrieve(cri[1],cri[2],cri[3])
////	CASE 4
////		dw_imprimir.Retrieve(cri[1],cri[2],cri[3],cri[4])
////	CASE 5
////		dw_imprimir.Retrieve(cri[1],cri[2],cri[3],cri[4],cri[5])
////	CASE 6
////		dw_imprimir.Retrieve(cri[1],cri[2],cri[3],cri[4],cri[5],cri[6])
////	CASE 7
////		dw_imprimir.Retrieve(cri[1],cri[2],cri[3],cri[4],cri[5],cri[6],cri[7])
////	CASE 8
//		dw_imprimir.Retrieve(cri[1],cri[2],cri[3],cri[4],cri[5],cri[6],cri[7],cri[8])
////END CHOOSE
//IF dw_imprimir.RowCount() = 0 Then
//	Return False
//Else
//	Return True
//END IF
end function

event open;dw_data= Message.PowerObjectParm

IF dw_data.RowCount() =0 Then
	pb_salir.TriggerEvent(Clicked!)
	return
END IF
dw_imprimir.SetRedraw(FALSE)
//dw_imprimir.DataObject = dw_data.DataObject
//dw_imprimir.Object = dw_data.Object
//dw_imprimir.SetTransObject(SQLCA)

If Not f_control() Then 
IF contador2= 0 Then
//	dw_data.SaveAs("",Clipboard!,False)
//	dw_imprimir.ImportClipboard()
   blob estado
   dw_data.getfullstate(estado)
	dw_imprimir.setfullstate(estado)
	dw_imprimir.groupcalc()
ELSE
	pb_salir.TriggerEvent(Clicked!)
	return
END IF
END IF

dw_imprimir.Modify ("DataWindow.Print.Preview=Yes")
dw_imprimir.Modify ("DataWindow.Print.Preview.Rulers=" + is_regla_visible)
dw_imprimir.Modify ("DataWindow.Print.Preview.Zoom=" + String(ii_valor_zoom))
cb_zoom.Text = String (ii_valor_zoom) + " %"
dw_imprimir.SetRedraw(TRUE)
f_pagina()





end event

on wc_presentacion_preliminar.create
this.pb_linea=create pb_linea
this.pb_italica=create pb_italica
this.pb_negrilla=create pb_negrilla
this.rb_visible=create rb_visible
this.st_tamaño=create st_tamaño
this.em_tamanyo=create em_tamanyo
this.sle_objeto=create sle_objeto
this.sle_texto=create sle_texto
this.pb_imprimir=create pb_imprimir
this.pb_alindere=create pb_alindere
this.pb_alincent=create pb_alincent
this.pb_alinizq=create pb_alinizq
this.rb_regla=create rb_regla
this.sle_posicion=create sle_posicion
this.sle_pagina=create sle_pagina
this.st_objeto=create st_objeto
this.dw_imprimir=create dw_imprimir
this.pb_2=create pb_2
this.pb_salvar_fichero=create pb_salvar_fichero
this.cb_zoom=create cb_zoom
this.pb_inc_zoom=create pb_inc_zoom
this.pb_dec_zoom=create pb_dec_zoom
this.pb_salir=create pb_salir
this.pb_anterior=create pb_anterior
this.pb_ultimo=create pb_ultimo
this.pb_primero=create pb_primero
this.pb_siguiente=create pb_siguiente
this.Control[]={this.pb_linea,&
this.pb_italica,&
this.pb_negrilla,&
this.rb_visible,&
this.st_tamaño,&
this.em_tamanyo,&
this.sle_objeto,&
this.sle_texto,&
this.pb_imprimir,&
this.pb_alindere,&
this.pb_alincent,&
this.pb_alinizq,&
this.rb_regla,&
this.sle_posicion,&
this.sle_pagina,&
this.st_objeto,&
this.dw_imprimir,&
this.pb_2,&
this.pb_salvar_fichero,&
this.cb_zoom,&
this.pb_inc_zoom,&
this.pb_dec_zoom,&
this.pb_salir,&
this.pb_anterior,&
this.pb_ultimo,&
this.pb_primero,&
this.pb_siguiente}
end on

on wc_presentacion_preliminar.destroy
destroy(this.pb_linea)
destroy(this.pb_italica)
destroy(this.pb_negrilla)
destroy(this.rb_visible)
destroy(this.st_tamaño)
destroy(this.em_tamanyo)
destroy(this.sle_objeto)
destroy(this.sle_texto)
destroy(this.pb_imprimir)
destroy(this.pb_alindere)
destroy(this.pb_alincent)
destroy(this.pb_alinizq)
destroy(this.rb_regla)
destroy(this.sle_posicion)
destroy(this.sle_pagina)
destroy(this.st_objeto)
destroy(this.dw_imprimir)
destroy(this.pb_2)
destroy(this.pb_salvar_fichero)
destroy(this.cb_zoom)
destroy(this.pb_inc_zoom)
destroy(this.pb_dec_zoom)
destroy(this.pb_salir)
destroy(this.pb_anterior)
destroy(this.pb_ultimo)
destroy(this.pb_primero)
destroy(this.pb_siguiente)
end on

event key;IF trim(objeto) <> "" Then
 String compuesto
 CHOOSE CASE tipoobj
	CASE "column"
		f_asignar_columna(dw_imprimir,elemento,objeto,sle_texto.text)
		CASE "compute"
		  //
	CASE ELSE  
	  compuesto = objeto + ".text= '"  + sle_texto.text + "'"
     dw_imprimir.Modify(compuesto)
END CHOOSE
END IF

IF key = KeyPageUp!    Then pb_anterior.TriggerEvent(Clicked!)
IF key = KeyPageDown!  Then pb_siguiente.TriggerEvent(Clicked!)
end event

type pb_linea from picturebutton within wc_presentacion_preliminar
event clicked pbm_bnclicked
integer x = 4750
integer y = 28
integer width = 110
integer height = 92
integer taborder = 11
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\subbra.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
IF Trim(objeto)<> "" Then
 compuesto = objeto + ".font.underline"
IF  dw_imprimir.Describe(compuesto) = "no" Then
 compuesto = objeto + ".font.underline= 'yes'"
 dw_imprimir.Modify(compuesto)
ELSE
 compuesto = objeto + ".font.underline= 'no'"
 dw_imprimir.Modify(compuesto)
END IF
END IF
end event

type pb_italica from picturebutton within wc_presentacion_preliminar
event clicked pbm_bnclicked
integer x = 4855
integer y = 28
integer width = 110
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
string picturename = "c:\bmp\italica.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
Boolean valor
IF Trim(objeto)<> "" Then
 compuesto = objeto + "font.italic"
 valor = dw_imprimir.Object.datawindow.font.italic 
IF  valor= false Then
 compuesto = objeto + ".font.italic= 'true'"
 dw_imprimir.Modify(compuesto)
ELSE
 compuesto = objeto + ".font.italic= 'false'"
 dw_imprimir.Modify(compuesto)
END IF
END IF


end event

type pb_negrilla from picturebutton within wc_presentacion_preliminar
event clicked pbm_bnclicked
integer x = 4960
integer y = 28
integer width = 110
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
string picturename = "c:\bmp\negrilla.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
IF Trim(objeto)<> "" Then
 compuesto = objeto + ".font.weight"
IF  dw_imprimir.Describe(compuesto) = "400" Then
 compuesto = objeto + ".font.weight= '700'"
 dw_imprimir.Modify(compuesto)
ELSE
 compuesto = objeto + ".font.weight= '400'"
 dw_imprimir.Modify(compuesto)
END IF
END IF
end event

type rb_visible from radiobutton within wc_presentacion_preliminar
event clicked pbm_bnclicked
integer x = 4443
integer y = 44
integer width = 270
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
long textcolor = 128
long backcolor = 8421504
string text = "Visible:"
boolean checked = true
boolean lefttext = true
end type

event clicked;String montaje,val

IF campo_visible = TRUE Then
    campo_visible = FALSE
    This.checked = FALSE
Else
    campo_visible = TRUE
    This.checked = TRUE
END IF

IF campo_visible Then
	val = "1"
ELSE
	val = "0"
END IF
IF Trim(objeto) <> "" Then
	montaje = objeto + ".visible='" + val+"'"
	dw_imprimir.Modify(montaje)
END IF
end event

type st_tamaño from statictext within wc_presentacion_preliminar
integer x = 498
integer width = 279
integer height = 40
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 8421504
boolean enabled = false
string text = "Tamaño"
alignment alignment = center!
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type em_tamanyo from editmask within wc_presentacion_preliminar
event change pbm_enchange
integer x = 530
integer y = 40
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string displaydata = "Ä"
end type

event change;em_tamanyo.TriggerEvent(modified!)
end event

event modified;IF trim(objeto) <> "" Then
 String compuesto
 compuesto = objeto + ".font.Height= '-"  + em_tamanyo.text + "'"
 dw_imprimir.Modify(compuesto)
END IF
 
end event

type sle_objeto from singlelineedit within wc_presentacion_preliminar
integer x = 3319
integer y = 40
integer width = 722
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_texto from multilineedit within wc_presentacion_preliminar
event tecla pbm_dwnkey
event change pbm_enchange
integer x = 795
integer y = 40
integer width = 905
integer height = 76
integer taborder = 30
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event change;wc_presentacion_preliminar.TriggerEvent("Key")
end event

event modified;wc_presentacion_preliminar.TriggerEvent("Key")
end event

type pb_imprimir from upb_imprimir within wc_presentacion_preliminar
integer x = 5417
integer y = 28
integer width = 110
integer taborder = 0
boolean originalsize = false
string picturename = "Print!"
end type

event clicked;call super::clicked;dw_imprimir.Print(TRUE) 
end event

type pb_alindere from picturebutton within wc_presentacion_preliminar
integer x = 5079
integer y = 28
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\alinder.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
IF Trim(objeto)<> "" Then
 compuesto = objeto + ".alignment= '1'"
 dw_imprimir.Modify(compuesto)
END IF
end event

type pb_alincent from picturebutton within wc_presentacion_preliminar
integer x = 5184
integer y = 28
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\alincent.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
IF Trim(objeto)<> "" Then
 compuesto = objeto + ".alignment= '2'"
 dw_imprimir.Modify(compuesto)
END IF
end event

type pb_alinizq from picturebutton within wc_presentacion_preliminar
integer x = 5285
integer y = 28
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\alinizq.bmp"
alignment htextalign = left!
end type

event clicked;String compuesto
IF Trim(objeto)<> "" Then
 compuesto = objeto + ".alignment= '0'"
 dw_imprimir.Modify(compuesto)
END IF
end event

type rb_regla from radiobutton within wc_presentacion_preliminar
integer x = 18
integer y = 32
integer width = 238
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
long textcolor = 128
long backcolor = 8421504
string text = "Regla:"
boolean checked = true
boolean lefttext = true
end type

event clicked;IF is_regla_visible = "yes" Then
    is_regla_visible = "no"
    rb_regla.checked = FALSE
Else
    is_regla_visible = "yes"
    rb_regla.checked = TRUE
END IF
dw_imprimir.Modify ("DataWindow.Print.Preview.Rulers=" + is_regla_visible)
end event

type sle_posicion from singlelineedit within wc_presentacion_preliminar
integer x = 4037
integer y = 40
integer width = 352
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_pagina from singlelineedit within wc_presentacion_preliminar
integer x = 2245
integer y = 36
integer width = 439
integer height = 68
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Página:"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_objeto from statictext within wc_presentacion_preliminar
integer x = 791
integer width = 901
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 8421504
boolean enabled = false
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type dw_imprimir from datawindow within wc_presentacion_preliminar
event mover_raton pbm_dwnmousemove
integer x = 14
integer y = 124
integer width = 5646
integer height = 3128
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event mover_raton;////--------------------------------------------------
//----------------Visor de la posicion -------------
//--------------------------------------------------

String obj
sle_posicion.text = "X:"+ String(dw_imprimir.PointerX()) + " Y:" + String(dw_imprimir.PointerY())


 String montaje
 obj = f_objeto_datawindow(dw_imprimir)
if Trim(obj) <> ""  and Not IsNull(obj) Then 
 IF Trim(obj) <> Trim(ante_objeto) or IsNull(ante_objeto) then
  montaje  =  obj +".type"
  tipo     =  dw_imprimir.Describe(montaje)
  montaje = obj +".Moveable = 1"
  dw_imprimir.modify(montaje)
  montaje = obj +".Resizeable = 1"
  dw_imprimir.modify(montaje)
  montaje = obj +".Pointer = '\bmp\mano.cur'"
  dw_imprimir.modify(montaje)
   sle_objeto.text = "Objeto: "+ "(" + tipo+") " + obj
END IF
ELSE
	 sle_objeto.text = ""
END IF
ante_objeto=  obj
end event

event clicked;String montaje,val

objeto = f_objeto_datawindow(dw_imprimir)
if Trim(objeto) = "" Then Return

st_objeto.text = objeto
montaje = objeto +".font.Height"
em_tamanyo.text = String(Abs(Integer(dw_imprimir.describe(montaje))),"###")
  montaje  =  objeto +".type"
  tipoobj     =  dw_imprimir.Describe(montaje)
elemento = 0
CHOOSE CASE tipoobj
	CASE "column"
		elemento = row
      sle_texto.text = f_valor_columna(dw_imprimir,elemento,objeto)
	CASE "compute"
		 //
	CASE ELSE  
	 montaje = objeto +".text"
    sle_texto.text = dw_imprimir.describe(montaje)
END CHOOSE

 montaje = objeto +".visible"
 val = dw_imprimir.describe(montaje)
 If val = "0" Then
	campo_visible = FALSE
	rb_visible.checked= FALSE
 ELSE
	campo_visible = TRUE
	rb_visible.checked= TRUE
 END IF
	 
	 
sle_texto.SetFocus()
sle_texto.Selecttext(1,100)


end event

type pb_2 from picturebutton within wc_presentacion_preliminar
integer x = 283
integer y = 24
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Sort!"
end type

on clicked;string ls_null
SetNull(ls_null)
dw_imprimir.SetSort(ls_null)
dw_imprimir.Sort( )

end on

type pb_salvar_fichero from picturebutton within wc_presentacion_preliminar
integer x = 398
integer y = 24
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Save!"
end type

on clicked;dw_imprimir.SaveAs()
end on

type cb_zoom from u_boton within wc_presentacion_preliminar
integer x = 2798
integer y = 28
integer width = 224
integer height = 84
integer taborder = 0
end type

on clicked;call u_boton::clicked;
ii_valor_zoom = 80

dw_imprimir.Modify("DataWindow.Print.Preview.Zoom=" + String(ii_valor_zoom))

cb_zoom.Text = String (ii_valor_zoom) + " %"

end on

type pb_inc_zoom from picturebutton within wc_presentacion_preliminar
integer x = 3017
integer y = 24
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\next1.bmp"
string disabledname = "c:\bmp\next2.bmp"
end type

on clicked;
////////////////////////////////////////////////////////////////////
//		Reducimos la presentacion preliminar en 10 unidades			//
////////////////////////////////////////////////////////////////////

IF ii_valor_zoom < 200 THEN

	ii_valor_zoom = ii_valor_zoom + 10

		// Preparamos el zoom con el nuevo valor

		dw_imprimir.Modify("DataWindow.Print.Preview.Zoom=" + String(ii_valor_zoom))

		cb_zoom.Text = String (ii_valor_zoom) + " %"

END IF
end on

type pb_dec_zoom from picturebutton within wc_presentacion_preliminar
integer x = 2688
integer y = 24
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\prior1.bmp"
string disabledname = "c:\bmp\prior2.bmp"
end type

on clicked;
////////////////////////////////////////////////////////////////////
//		Reducimos la presentacion preliminar en 10 unidades			//
////////////////////////////////////////////////////////////////////

string ls_zoom

IF ii_valor_zoom > 10 THEN

	ii_valor_zoom = ii_valor_zoom - 10

		// Preparamos el zoom con el nuevo valor

		ls_zoom  = "DataWindow.Print.Preview.Zoom=" + String(ii_valor_zoom)

		dw_imprimir.Modify(ls_zoom)

		cb_zoom.Text = String (ii_valor_zoom) + " %"

END IF
end on

type pb_salir from picturebutton within wc_presentacion_preliminar
integer x = 5527
integer y = 28
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean cancel = true
string picturename = "Exit!"
string disabledname = "Exit!"
alignment htextalign = left!
end type

on clicked;Close(Parent)
end on

type pb_anterior from picturebutton within wc_presentacion_preliminar
integer x = 1915
integer y = 24
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\prior1.bmp"
string disabledname = "c:\bmp\prior2.bmp"
end type

event clicked;dw_imprimir.ScrollPriorPage()
f_pagina()
end event

type pb_ultimo from picturebutton within wc_presentacion_preliminar
integer x = 2135
integer y = 24
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\last1.bmp"
string disabledname = "c:\bmp\last2.bmp"
end type

event clicked;dw_imprimir.ScrollToRow(99999999)
f_pagina()
end event

type pb_primero from picturebutton within wc_presentacion_preliminar
integer x = 37
integer y = 2420
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\first1.bmp"
string disabledname = "c:\bmp\first2.bmp"
end type

event clicked;dw_imprimir.ScrollToRow(0)
f_pagina()
end event

type pb_siguiente from picturebutton within wc_presentacion_preliminar
integer x = 2025
integer y = 24
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\next1.bmp"
string disabledname = "c:\bmp\next2.bmp"
end type

event clicked;dw_imprimir.ScrollNextPage()
f_pagina()
end event

