$PBExportHeader$w_impresoras_v3.srw
forward
global type w_impresoras_v3 from Window
end type
type cb_saveas from u_boton within w_impresoras_v3
end type
type uo_impresoras from u_selec_impresoras within w_impresoras_v3
end type
type cb_preliminar from u_boton within w_impresoras_v3
end type
type em_paginas from editmask within w_impresoras_v3
end type
type st_8 from statictext within w_impresoras_v3
end type
type cb_aceptar from u_aceptar within w_impresoras_v3
end type
type cb_cancelar from u_cancelar within w_impresoras_v3
end type
type mle_1 from multilineedit within w_impresoras_v3
end type
type ddlb_rango from dropdownlistbox within w_impresoras_v3
end type
type st_4 from statictext within w_impresoras_v3
end type
type cbx_imprime_a_fichero from checkbox within w_impresoras_v3
end type
type sle_rango_paginas from singlelineedit within w_impresoras_v3
end type
type rb_paginas from radiobutton within w_impresoras_v3
end type
type rb_todas from radiobutton within w_impresoras_v3
end type
type em_copias from editmask within w_impresoras_v3
end type
type st_2 from statictext within w_impresoras_v3
end type
type gb_1 from groupbox within w_impresoras_v3
end type
end forward

global type w_impresoras_v3 from Window
int X=256
int Y=160
int Width=2011
int Height=972
boolean Visible=false
boolean TitleBar=true
string Title="Opciones de Impresión"
long BackColor=12632256
WindowType WindowType=response!
cb_saveas cb_saveas
uo_impresoras uo_impresoras
cb_preliminar cb_preliminar
em_paginas em_paginas
st_8 st_8
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
mle_1 mle_1
ddlb_rango ddlb_rango
st_4 st_4
cbx_imprime_a_fichero cbx_imprime_a_fichero
sle_rango_paginas sle_rango_paginas
rb_paginas rb_paginas
rb_todas rb_todas
em_copias em_copias
st_2 st_2
gb_1 gb_1
end type
global w_impresoras_v3 w_impresoras_v3

type variables
string is_rango_paginas
datawindow  report

end variables

forward prototypes
private subroutine wf_rango_paginas (radiobutton arb_opcion)
end prototypes

private subroutine wf_rango_paginas (radiobutton arb_opcion);CHOOSE CASE arb_opcion

	CASE rb_todas
		sle_rango_paginas.text = ''
		is_rango_paginas = 'a'
	
	CASE rb_paginas	
		is_rango_paginas = 'p'

END CHOOSE
end subroutine

event open;report=  Message.PowerObjectParm
uo_impresoras.TriggerEvent(constructor!)
is_rango_paginas = 'a'
IF report.RowCount() <> 0 Then	
  em_paginas.text  = String(report.GetItemNumber(1,"total_paginas"))
END IF
cb_aceptar.TriggerEvent(Clicked!)


end event

on w_impresoras_v3.create
this.cb_saveas=create cb_saveas
this.uo_impresoras=create uo_impresoras
this.cb_preliminar=create cb_preliminar
this.em_paginas=create em_paginas
this.st_8=create st_8
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.mle_1=create mle_1
this.ddlb_rango=create ddlb_rango
this.st_4=create st_4
this.cbx_imprime_a_fichero=create cbx_imprime_a_fichero
this.sle_rango_paginas=create sle_rango_paginas
this.rb_paginas=create rb_paginas
this.rb_todas=create rb_todas
this.em_copias=create em_copias
this.st_2=create st_2
this.gb_1=create gb_1
this.Control[]={this.cb_saveas,&
this.uo_impresoras,&
this.cb_preliminar,&
this.em_paginas,&
this.st_8,&
this.cb_aceptar,&
this.cb_cancelar,&
this.mle_1,&
this.ddlb_rango,&
this.st_4,&
this.cbx_imprime_a_fichero,&
this.sle_rango_paginas,&
this.rb_paginas,&
this.rb_todas,&
this.em_copias,&
this.st_2,&
this.gb_1}
end on

on w_impresoras_v3.destroy
destroy(this.cb_saveas)
destroy(this.uo_impresoras)
destroy(this.cb_preliminar)
destroy(this.em_paginas)
destroy(this.st_8)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.mle_1)
destroy(this.ddlb_rango)
destroy(this.st_4)
destroy(this.cbx_imprime_a_fichero)
destroy(this.sle_rango_paginas)
destroy(this.rb_paginas)
destroy(this.rb_todas)
destroy(this.em_copias)
destroy(this.st_2)
destroy(this.gb_1)
end on

type cb_saveas from u_boton within w_impresoras_v3
int X=1550
int Y=720
int TabOrder=120
string Text="&Grabar como"
end type

event clicked;
report.saveas()
end event

type uo_impresoras from u_selec_impresoras within w_impresoras_v3
int X=0
int Y=0
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = report
end event

on uo_impresoras.destroy
call u_selec_impresoras::destroy
end on

type cb_preliminar from u_boton within w_impresoras_v3
event clicked pbm_bnclicked
int X=1550
int Y=604
int TabOrder=60
string Text="&Preliminar"
end type

event clicked;call super::clicked;
f_preliminar(report)
end event

type em_paginas from editmask within w_impresoras_v3
int X=1874
int Y=28
int Width=137
int Height=88
boolean Border=false
string Mask="#####"
double Increment=1
string MinMax="1~~15"
boolean DisplayOnly=true
string Text="1"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_impresoras_v3
int X=1550
int Y=24
int Width=315
int Height=68
boolean Enabled=false
string Text="Nº Páginas:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_aceptar from u_aceptar within w_impresoras_v3
int X=1545
int Y=212
int TabOrder=90
string Text="&Aceptar"
boolean Default=true
end type

event clicked;string ls_tmp
string ls_comando
long ll_fila 
string	ls_nomdoc, ls_nom
int	li_valor


CHOOSE CASE lower(left(ddlb_rango.Text,1)) 
	CASE 't' 				// Todas las paginas
		ls_tmp = '0'
	CASE 'p'					// Las Pares
		ls_tmp = '1'
	CASE 'i' 				// Las Impares
		ls_tmp = '2'
END CHOOSE

ls_comando = 'datawindow.print.page.rangeinclude = ' + ls_tmp

CHOOSE CASE is_rango_paginas // Imprimir un rango de paginas
	CASE 'a'  				// Todas
		ls_tmp = ''
	CASE 'c' 				// Pagina actual

		ll_fila = report.GetRow()
		ls_tmp  = report.Describe("evaluate('page()',"+string(ll_fila)+")")

	CASE 'p' 				// Rango de paginas
		ls_tmp = sle_rango_paginas.text
END CHOOSE
	
IF len(ls_tmp) > 0 THEN
	ls_comando = ls_comando +  " datawindow.print.page.range = '"+ls_tmp+"'"
END IF

		//	Numero de copias

IF len(em_copias.text) > 0 THEN
	ls_comando = ls_comando +  " datawindow.print.copies = "+em_copias.text
END IF

		// Imprimir a un Fichero

IF cbx_imprime_a_fichero.checked THEN 
	li_valor = GetFileSaveName("Imprimir a un Fichero", ls_nomdoc, ls_nom, "PRN", "Imprime (*.PRN),*.PRN")
	IF li_valor = 1 THEN
		ls_comando = ls_comando + " datawindow.print.filename = '"+ls_nomdoc+"'"
	ELSE
		return
	END IF
END IF


	// Modificar la DataWindow

ls_tmp = report.Modify(ls_comando)
IF len(ls_tmp) > 0 THEN
	MessageBox('Error al preparar las Opciones de Impresión', &
					'Mensaje de Error = ' + ls_tmp + '~r~nls_comando = ' + ls_comando)
	Return
END IF

IF report.Print(TRUE) =1 Then
	CloseWithReturn(Parent,1)
ELSE
	CloseWithReturn(Parent,-1)
END IF
//Yield()
//
//report.Print(FALSE) 
//CloseWithReturn(Parent,1)


// Prueba comparativa rapidez
//long job
//job= PrintOpen()
//PrintDatawindow(job,report)
//PrintClose(Job)
//
end event

type cb_cancelar from u_cancelar within w_impresoras_v3
int X=1541
int Y=332
int TabOrder=100
string Text="&Salir"
boolean Cancel=true
end type

on clicked;CloseWithReturn(Parent,-1)
end on

type mle_1 from multilineedit within w_impresoras_v3
int X=110
int Y=516
int Width=1207
int Height=128
int TabOrder=110
boolean Border=false
boolean DisplayOnly=true
string Text="Introducir numeros y/o rangos de pagina separados por comas. Por ejemplo, 2,5,8-10"
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_rango from dropdownlistbox within w_impresoras_v3
int X=320
int Y=736
int Width=1029
int Height=288
int TabOrder=80
string Text="Todas la Paginas del Rango"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Todas la Paginas del Rango",&
"Impares",&
"Pares"}
end type

type st_4 from statictext within w_impresoras_v3
int X=46
int Y=736
int Width=233
int Height=68
boolean Enabled=false
string Text="&Imprimir:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_imprime_a_fichero from checkbox within w_impresoras_v3
int X=704
int Y=156
int Width=357
int Height=68
int TabOrder=70
string Text="A &Fichero"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_rango_paginas from singlelineedit within w_impresoras_v3
int X=489
int Y=420
int Width=846
int Height=84
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;rb_paginas.TriggerEvent(clicked!)
end on

type rb_paginas from radiobutton within w_impresoras_v3
int X=142
int Y=424
int Width=347
int Height=68
int TabOrder=40
string Text="Pa&ginas:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_rango_paginas(This)
This.checked= TRUE
sle_rango_paginas.SetFocus()
end on

type rb_todas from radiobutton within w_impresoras_v3
int X=142
int Y=340
int Width=283
int Height=68
int TabOrder=30
string Text="&Todas"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_rango_paginas(This)
end on

type em_copias from editmask within w_impresoras_v3
int X=379
int Y=144
int Width=242
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
boolean Spin=true
double Increment=1
string MinMax="1~~15"
string Text="1"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_impresoras_v3
int X=37
int Y=160
int Width=210
int Height=68
boolean Enabled=false
string Text="Copias:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_impresoras_v3
int X=64
int Y=272
int Width=1298
int Height=400
int TabOrder=20
string Text="Rango de Paginas"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

