$PBExportHeader$w_bloqueo.srw
$PBExportComments$Ventana gestion presentcion del bloqueo.
forward
global type w_bloqueo from Window
end type
type dw_1 from datawindow within w_bloqueo
end type
type cb_2 from commandbutton within w_bloqueo
end type
type cb_1 from commandbutton within w_bloqueo
end type
end forward

global type w_bloqueo from Window
int X=252
int Y=481
int Width=2414
int Height=969
long BackColor=12632256
WindowType WindowType=response!
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_bloqueo w_bloqueo

event open;string a_codigo,a_tabla
str_parametros istr_parametros

istr_parametros = Message.PowerObjectParm
This.Title = istr_parametros.s_titulo_ventana

string bloq_tabla,bloq_codigo
boolean valor

bloq_tabla    = istr_parametros.s_argumentos[2]
bloq_codigo   = istr_parametros.s_argumentos[3]

dw_1.SetTransObject(SQLCA)
IF dw_1.Retrieve(bloq_tabla,bloq_codigo)= 0 Then CloseWithReturn(w_bloqueo,"A")
end event

on w_bloqueo.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_bloqueo.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_bloqueo
int X=23
int Y=21
int Width=2332
int Height=701
int TabOrder=10
string DataObject="dw_bloqueo"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_bloqueo
int X=1258
int Y=781
int Width=407
int Height=129
int TabOrder=30
string Text="&Cancelar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn(Parent,"B")
end on

type cb_1 from commandbutton within w_bloqueo
int X=252
int Y=781
int Width=462
int Height=129
int TabOrder=20
string Text="&Reintentar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn(Parent,"A")
end on

