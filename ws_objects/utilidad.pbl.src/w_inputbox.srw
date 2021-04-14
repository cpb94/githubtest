$PBExportHeader$w_inputbox.srw
$PBExportComments$ventana para inputbox()
forward
global type w_inputbox from Window
end type
type texto_fecha from u_em_campo within w_inputbox
end type
type p_1 from picture within w_inputbox
end type
type cb_cancelar from commandbutton within w_inputbox
end type
type cb_ok from commandbutton within w_inputbox
end type
type texto from u_em_campo within w_inputbox
end type
type mensaje from statictext within w_inputbox
end type
end forward

global type w_inputbox from Window
int X=718
int Y=784
int Width=1582
int Height=556
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
texto_fecha texto_fecha
p_1 p_1
cb_cancelar cb_cancelar
cb_ok cb_ok
texto texto
mensaje mensaje
end type
global w_inputbox w_inputbox

on w_inputbox.create
this.texto_fecha=create texto_fecha
this.p_1=create p_1
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.texto=create texto
this.mensaje=create mensaje
this.Control[]={this.texto_fecha,&
this.p_1,&
this.cb_cancelar,&
this.cb_ok,&
this.texto,&
this.mensaje}
end on

on w_inputbox.destroy
destroy(this.texto_fecha)
destroy(this.p_1)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.texto)
destroy(this.mensaje)
end on

event open;str_parametros param
param=message.PowerObjectParm
this.title=param.s_argumentos[1]
mensaje.text=param.s_argumentos[2]
if isnull(param.s_argumentos[4]) or param.s_argumentos[4]="" then
	texto.visible=true
	texto_fecha.visible=false
	texto.text=param.s_argumentos[3]
	texto.SetFocus()
else
	texto.visible=false
	texto_fecha.visible=true
	texto_fecha.text=param.s_argumentos[3]
	texto_fecha.SetFocus()
end if
end event

type texto_fecha from u_em_campo within w_inputbox
int X=512
int Y=336
int Width=338
boolean Visible=false
Alignment Alignment=Center!
string Mask="dd-mm-yy"
MaskDataType MaskDataType=DateMask!
string DisplayData="<8"
end type

type p_1 from picture within w_inputbox
int X=73
int Y=44
int Width=146
int Height=128
string PictureName="c:\bmp\pencil.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_cancelar from commandbutton within w_inputbox
int X=1184
int Y=204
int Width=320
int Height=88
string Text="&Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,"RETURN")
end event

type cb_ok from commandbutton within w_inputbox
int X=1184
int Y=104
int Width=320
int Height=88
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if texto.visible=true then
	closewithreturn(parent,texto.text)
else
	closewithreturn(parent,texto_fecha.text)
end if
end event

type texto from u_em_campo within w_inputbox
int X=37
int Y=336
int Width=1467
string Mask="!!!!!!!!!!"
string DisplayData="<f_autorizar_pedido"
end type

type mensaje from statictext within w_inputbox
int X=261
int Y=36
int Width=878
int Height=260
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

