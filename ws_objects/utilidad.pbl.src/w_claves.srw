$PBExportHeader$w_claves.srw
$PBExportComments$Ventana validacion de claves (Esta ventana la abre la función f_pedir_clave().
forward
global type w_claves from Window
end type
type cb_2 from commandbutton within w_claves
end type
type cb_1 from commandbutton within w_claves
end type
type sle_password from singlelineedit within w_claves
end type
type st_2 from statictext within w_claves
end type
end forward

global type w_claves from Window
int X=672
int Y=264
int Width=1719
int Height=572
boolean TitleBar=true
string Title="CLAVE DE ACCESO !!!"
long BackColor=12632256
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
sle_password sle_password
st_2 st_2
end type
global w_claves w_claves

type variables
String codigo_clave,opcion
end variables

forward prototypes
public function boolean f_verificar_clave (string arg_codigo, string arg_clave)
end prototypes

public function boolean f_verificar_clave (string arg_codigo, string arg_clave);String var_codigo,var_clave

  SELECT uti_claves.codigo,uti_claves.clave  
    INTO :var_codigo,:var_clave  
    FROM uti_claves  
   WHERE uti_claves.codigo = :arg_codigo;
IF IsNull(var_clave) Then var_clave = ""
IF IsNull(arg_clave) Then arg_clave = ""

IF var_clave <> arg_clave Then
  Return FALSE
ELSE
  Return TRUE
END IF

end function

event open;// Asigna datos por defecto pasados como parametro
codigo_clave= Message.StringParm
 opcion="N"
 
 String var_texto

  SELECT uti_claves.descripcion
    INTO :var_texto  
    FROM uti_claves  
   WHERE uti_claves.codigo = :codigo_clave;
This.title = var_texto
end event

on w_claves.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_password=create sle_password
this.st_2=create st_2
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_password,&
this.st_2}
end on

on w_claves.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_password)
destroy(this.st_2)
end on

type cb_2 from commandbutton within w_claves
int X=1152
int Y=260
int Width=288
int Height=92
string Text="Cancelar"
boolean Cancel=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked; opcion="C"
CloseWithReturn(parent,opcion)
end on

type cb_1 from commandbutton within w_claves
int X=1152
int Y=144
int Width=288
int Height=92
int TabOrder=20
string Text="Aceptar"
boolean Default=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF f_verificar_clave(codigo_clave,sle_password.text) THEN
   opcion="S"
ELSE
   opcion="N"
END IF
//IF sle_password.text="º" Then opcion="S"

CloseWithReturn(parent,opcion)
Return
end event

type sle_password from singlelineedit within w_claves
int X=507
int Y=192
int Width=439
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Accelerator=112
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_claves
int X=69
int Y=216
int Width=315
int Height=72
boolean Enabled=false
string Text="Clave:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

