$PBExportHeader$w_desconexion_limite.srw
forward
global type w_desconexion_limite from Window
end type
type st_tiempo from statictext within w_desconexion_limite
end type
type st_2 from statictext within w_desconexion_limite
end type
type st_1 from statictext within w_desconexion_limite
end type
end forward

global type w_desconexion_limite from Window
int X=673
int Y=265
int Width=1582
int Height=465
long BackColor=33551093
WindowType WindowType=response!
st_tiempo st_tiempo
st_2 st_2
st_1 st_1
end type
global w_desconexion_limite w_desconexion_limite

type variables
Integer contador = 60
end variables

event open;Timer(1)

end event

on w_desconexion_limite.create
this.st_tiempo=create st_tiempo
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.st_tiempo,&
this.st_2,&
this.st_1}
end on

on w_desconexion_limite.destroy
destroy(this.st_tiempo)
destroy(this.st_2)
destroy(this.st_1)
end on

event timer;st_tiempo.text = String(contador)


IF tiempo_limite < f_tiempo_limite_uti_parametros(codigo_empresa) - 60 Then
	Close(This)
	return
END IF
IF contador = 0 Then 
	Close(This)
	return
END IF
contador  = contador -1
end event

type st_tiempo from statictext within w_desconexion_limite
int X=759
int Y=205
int Width=247
int Height=89
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=33551093
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_desconexion_limite
int X=252
int Y=205
int Width=490
int Height=73
boolean Enabled=false
string Text="Tiempo Límite:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=33551093
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_desconexion_limite
int Width=1550
int Height=117
boolean Enabled=false
string Text="Aviso de Desconexion"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15780518
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

