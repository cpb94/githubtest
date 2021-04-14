$PBExportHeader$u_ejercicio.sru
$PBExportComments$Objeto manejo seleccion ejercicio.
forward
global type u_ejercicio from UserObject
end type
type st_1 from statictext within u_ejercicio
end type
type p_1 from picture within u_ejercicio
end type
type em_ejercicio from u_em_campo within u_ejercicio
end type
type dw_1 from datawindow within u_ejercicio
end type
end forward

global type u_ejercicio from UserObject
int Width=640
int Height=312
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_1 st_1
p_1 p_1
em_ejercicio em_ejercicio
dw_1 dw_1
end type
global u_ejercicio u_ejercicio

on u_ejercicio.create
this.st_1=create st_1
this.p_1=create p_1
this.em_ejercicio=create em_ejercicio
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.p_1,&
this.em_ejercicio,&
this.dw_1}
end on

on u_ejercicio.destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.em_ejercicio)
destroy(this.dw_1)
end on

event constructor;em_ejercicio.text = String(f_ejercicio_activo(codigo_empresa))
ejercicio_activo  = f_ejercicio_activo(codigo_empresa)
end event

type st_1 from statictext within u_ejercicio
int X=5
int Y=8
int Width=265
int Height=80
boolean Enabled=false
string Text="Ejercicio"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within u_ejercicio
int X=535
int Y=4
int Width=87
int Height=76
string PictureName="c:\bmp\carpeta.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
string Pointer="\bmp\MANO.CUR"
end type

event clicked;dw_1.SetRowFocusIndicator(Hand!)	
dw_1.settransobject(sqlca)
dw_1.visible=TRUE
Parent.BringToTop = TRUE
dw_1.Retrieve(codigo_empresa)
dw_1.SetFocus()

end event

type em_ejercicio from u_em_campo within u_ejercicio
int X=274
int Y=0
int TabOrder=10
string Mask="####"
MaskDataType MaskDataType=NumericMask!
FontCharSet FontCharSet=Ansi!
end type

type dw_1 from datawindow within u_ejercicio
event key pbm_dwnkey
int X=270
int Y=84
int Width=352
int Height=212
int TabOrder=20
boolean Visible=false
string DataObject="dw_ejercicios"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on key;If KeyDown(KeyEnter!) Then
  em_ejercicio.text= String(This.GetItemNumber(This.GetRow(),"ejercicio"))
  This.visible=FALSE
  em_ejercicio.Setfocus()
END IF
end on

event clicked;If row=0 Then Return
em_ejercicio.text= String(This.GetItemNumber(row,"ejercicio"))
This.visible=FALSE
Parent.BringToTop = FALSE
em_ejercicio.Setfocus()
end event

