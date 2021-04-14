$PBExportHeader$w_opciones.srw
forward
global type w_opciones from Window
end type
type st_texto from statictext within w_opciones
end type
type cb_4 from u_boton within w_opciones
end type
type cb_3 from u_boton within w_opciones
end type
type cb_2 from u_boton within w_opciones
end type
type cb_1 from u_boton within w_opciones
end type
end forward

global type w_opciones from Window
int X=673
int Y=265
int Width=1806
int Height=517
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
WindowType WindowType=response!
string Icon="Exclamation!"
event tecla_f1 pbm_custom01
event tecla_f2 pbm_custom02
event tecla_f3 pbm_custom03
event tecla_f4 pbm_custom04
event tecla_f5 pbm_custom05
event tecla_f6 pbm_custom06
event tecla_f7 pbm_custom07
st_texto st_texto
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_opciones w_opciones

type variables
Integer argumentos
end variables

on tecla_f1;cb_1.TriggerEvent(Clicked!)
end on

on tecla_f2;cb_2.TriggerEvent(Clicked!)
end on

on tecla_f3;cb_3.TriggerEvent(Clicked!)
end on

on tecla_f4;cb_4.TriggerEvent(Clicked!)
end on

event open;tipo_array  arg
String  text
commandbutton boton
Integer x1,y1
arg = Message.PowerObjectParm
argumentos = 0
This.title = arg.valor[1]
FOR x1 = 1 to 10
  y1 = 10 +x1
  IF Trim(arg.valor[y1]) = "" Then  EXIT
  argumentos = argumentos + 1
  CHOOSE CASE x1
	CASE 1
		boton = cb_1
   CASE 2
	 	boton = cb_2
   CASE 3
		boton = cb_3
   CASE 4
		boton = cb_4
   END CHOOSE
    text= "F" + String(x1)
    boton.visible = TRUE
    boton.Text= text + " " + arg.valor[y1]
 NEXT
end event

on w_opciones.create
this.st_texto=create st_texto
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.st_texto,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_opciones.destroy
destroy(this.st_texto)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event key;if KeyDown(KeyF1!) Then This.TriggerEvent("tecla_f1")
if KeyDown(KeyF2!) Then This.TriggerEvent("tecla_f2")
if KeyDown(KeyF3!) Then This.TriggerEvent("tecla_f3")
if KeyDown(KeyF4!) Then This.TriggerEvent("tecla_f4")
//if KeyDown(KeyF5!) Then This.TriggerEvent("tecla_f5")
//if KeyDown(KeyF6!) Then This.TriggerEvent("tecla_f6")
//if KeyDown(KeyF7!) Then This.TriggerEvent("tecla_f7")
end event

type st_texto from statictext within w_opciones
int X=19
int Y=85
int Width=1166
int Height=109
boolean Enabled=false
string Text="Elija la opcion deseada"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-14
int Weight=700
string FaceName="Arial Narrow"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from u_boton within w_opciones
int X=1335
int Y=241
int Width=439
int TabOrder=40
boolean Visible=false
end type

on clicked;call u_boton::clicked;CloseWithReturn(Parent,4)
end on

type cb_3 from u_boton within w_opciones
int X=901
int Y=241
int Width=439
int TabOrder=30
boolean Visible=false
end type

on clicked;call u_boton::clicked;CloseWithReturn(Parent,3)
end on

type cb_2 from u_boton within w_opciones
int X=467
int Y=241
int Width=439
int TabOrder=20
boolean Visible=false
end type

on clicked;call u_boton::clicked;CloseWithReturn(Parent,2)
end on

type cb_1 from u_boton within w_opciones
int X=28
int Y=241
int Width=439
int TabOrder=10
boolean Visible=false
end type

on clicked;call u_boton::clicked;CloseWithReturn(Parent,1)
end on

