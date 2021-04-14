$PBExportHeader$w_pedir_version.srw
forward
global type w_pedir_version from Window
end type
type st_3 from statictext within w_pedir_version
end type
type p_1 from picture within w_pedir_version
end type
type cb_2 from commandbutton within w_pedir_version
end type
type cb_1 from commandbutton within w_pedir_version
end type
type st_2 from statictext within w_pedir_version
end type
type st_1 from statictext within w_pedir_version
end type
type sle_2 from singlelineedit within w_pedir_version
end type
type sle_1 from singlelineedit within w_pedir_version
end type
type gb_1 from groupbox within w_pedir_version
end type
end forward

global type w_pedir_version from Window
int X=823
int Y=360
int Width=1449
int Height=804
boolean TitleBar=true
string Title="Imprimir versiones"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_3 st_3
p_1 p_1
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_2 sle_2
sle_1 sle_1
gb_1 gb_1
end type
global w_pedir_version w_pedir_version

event open;tipo_array ent

ent =message.powerobjectparm

sle_1.text=ent.valor[1]
sle_2.text=ent.valor[2]
end event

on w_pedir_version.create
this.st_3=create st_3
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.p_1,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_2,&
this.sle_1,&
this.gb_1}
end on

on w_pedir_version.destroy
destroy(this.st_3)
destroy(this.p_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.gb_1)
end on

type st_3 from statictext within w_pedir_version
int X=343
int Y=56
int Width=955
int Height=76
boolean Enabled=false
string Text="Imprimir Rango de Versiones"
boolean FocusRectangle=false
long TextColor=128
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_pedir_version
int X=91
int Y=36
int Width=165
int Height=144
string PictureName="c:\bmp\pencil.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

type cb_2 from commandbutton within w_pedir_version
int X=759
int Y=476
int Width=384
int Height=108
int TabOrder=40
string Text="Cancelar"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tipo_array  val
val.valor[1] = "RETURN"
val.valor[2] = ""
closewithreturn(parent,val)
end event

type cb_1 from commandbutton within w_pedir_version
int X=485
int Y=476
int Width=247
int Height=108
int TabOrder=30
string Text="Ok"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tipo_array  val
val.valor[1] = sle_1.text
val.valor[2] = sle_2.text
Closewithreturn(parent,val)
end event

type st_2 from statictext within w_pedir_version
int X=110
int Y=280
int Width=416
int Height=76
boolean Enabled=false
string Text="Versiones :"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_pedir_version
int X=827
int Y=276
int Width=59
int Height=76
boolean Enabled=false
string Text="-"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_pedir_version
int X=896
int Y=272
int Width=247
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=3
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_pedir_version
int X=530
int Y=272
int Width=247
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=3
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_pedir_version
int X=457
int Y=420
int Width=713
int Height=188
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

