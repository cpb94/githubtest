$PBExportHeader$u_aceptar.sru
$PBExportComments$Boton Aceptar.
forward
global type u_aceptar from commandbutton
end type
end forward

global type u_aceptar from commandbutton
int Width=407
int Height=93
int TabOrder=1
string Text="Aceptar"
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_aceptar u_aceptar

on clicked;Close (Parent)
end on

