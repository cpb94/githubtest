$PBExportHeader$w_telefonos.srw
$PBExportComments$Ventana de Visualizacion de telefonos.
forward
global type w_telefonos from Window
end type
type pb_salir from picturebutton within w_telefonos
end type
type dw_1 from datawindow within w_telefonos
end type
end forward

global type w_telefonos from Window
int X=261
int Y=352
int Width=2501
int Height=1284
boolean TitleBar=true
long BackColor=12632256
WindowType WindowType=response!
string Icon="\bmp\RINO.ICO"
pb_salir pb_salir
dw_1 dw_1
end type
global w_telefonos w_telefonos

on open;
string ls_codcliente

ls_codcliente = Trim( Left(Message.StringParm,10) )
This.Title    = Mid( Message.StringParm,11,Len(Message.StringParm) )


dw_1.SetTransObject(sqlca)
dw_1.Retrieve(codigo_empresa,ls_codcliente)
end on

on w_telefonos.create
this.pb_salir=create pb_salir
this.dw_1=create dw_1
this.Control[]={this.pb_salir,&
this.dw_1}
end on

on w_telefonos.destroy
destroy(this.pb_salir)
destroy(this.dw_1)
end on

type pb_salir from picturebutton within w_telefonos
int X=69
int Y=1040
int Width=101
int Height=84
int TabOrder=20
string PictureName="c:\bmp\exit1.bmp"
boolean OriginalSize=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)
end on

type dw_1 from datawindow within w_telefonos
int X=46
int Y=40
int Width=2400
int Height=1100
int TabOrder=10
string DataObject="report_tfnos_consulta"
boolean VScrollBar=true
boolean LiveScroll=true
end type

