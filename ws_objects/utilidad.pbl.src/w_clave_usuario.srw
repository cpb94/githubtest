$PBExportHeader$w_clave_usuario.srw
forward
global type w_clave_usuario from Window
end type
type cb_2 from commandbutton within w_clave_usuario
end type
type cb_1 from commandbutton within w_clave_usuario
end type
type sle_password from singlelineedit within w_clave_usuario
end type
type st_2 from statictext within w_clave_usuario
end type
end forward

global type w_clave_usuario from Window
int X=673
int Y=265
int Width=1719
int Height=573
boolean TitleBar=true
string Title="CLAVE DE ACCESO !!!"
long BackColor=12632256
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
sle_password sle_password
st_2 st_2
end type
global w_clave_usuario w_clave_usuario

type variables
String opcion
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

event open;opcion="N"
This.title = "CLAVE DE ACCESO (Clave de usuario) "
end event

on w_clave_usuario.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_password=create sle_password
this.st_2=create st_2
this.Control[]={ this.cb_2,&
this.cb_1,&
this.sle_password,&
this.st_2}
end on

on w_clave_usuario.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_password)
destroy(this.st_2)
end on

type cb_2 from commandbutton within w_clave_usuario
int X=1153
int Y=261
int Width=289
int Height=93
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

type cb_1 from commandbutton within w_clave_usuario
int X=1153
int Y=145
int Width=289
int Height=93
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

event clicked;string  ls_password, var_password

ls_password = Trim (sle_password.text)
	
SELECT usuarios.v_password
INTO   :var_password
FROM   usuarios
WHERE  usuarios.v_usuario = :nombre_usuario;
 
     IF ISNull(var_password)  THEN  var_password=""
    IF ISNull(ls_password)   THEN  ls_password=""         
    IF var_password <> ls_password THEN
    	opcion= "N"
   ELSE
		 opcion = "S"
      
    END IF


CloseWithReturn(parent,opcion)
end event

type sle_password from singlelineedit within w_clave_usuario
int X=508
int Y=193
int Width=439
int Height=97
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

type st_2 from statictext within w_clave_usuario
int X=69
int Y=217
int Width=316
int Height=73
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

