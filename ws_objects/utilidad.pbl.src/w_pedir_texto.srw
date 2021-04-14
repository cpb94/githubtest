$PBExportHeader$w_pedir_texto.srw
forward
global type w_pedir_texto from Window
end type
type p_1 from picture within w_pedir_texto
end type
type cb_cancelar from commandbutton within w_pedir_texto
end type
type cb_ok from commandbutton within w_pedir_texto
end type
type mensaje from statictext within w_pedir_texto
end type
type texto from multilineedit within w_pedir_texto
end type
end forward

global type w_pedir_texto from Window
int X=718
int Y=784
int Width=1582
int Height=732
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
p_1 p_1
cb_cancelar cb_cancelar
cb_ok cb_ok
mensaje mensaje
texto texto
end type
global w_pedir_texto w_pedir_texto

on w_pedir_texto.create
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.mensaje=create mensaje
this.texto=create texto
this.Control[]={this.p_1,&
this.cb_cancelar,&
this.cb_ok,&
this.mensaje,&
this.texto}
end on

on w_pedir_texto.destroy
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.mensaje)
destroy(this.texto)
end on

event open;str_parametros param
param=message.PowerObjectParm
this.title   = param.s_argumentos[1]
mensaje.text = param.s_argumentos[2]
texto.text = param.s_argumentos[3]
texto.SetFocus()

end event

type p_1 from picture within w_pedir_texto
int X=14
int Y=12
int Width=146
int Height=128
string PictureName="c:\bmp\pencil.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_cancelar from commandbutton within w_pedir_texto
int X=1221
int Y=92
int Width=320
int Height=80
string Text="&Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,"RETURN")
end event

type cb_ok from commandbutton within w_pedir_texto
int X=1221
int Y=8
int Width=320
int Height=80
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;	closewithreturn(parent,texto.text)

end event

type mensaje from statictext within w_pedir_texto
int X=238
int Width=960
int Height=180
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type texto from multilineedit within w_pedir_texto
int Y=196
int Width=1568
int Height=452
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

