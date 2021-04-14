$PBExportHeader$u_cancelar.sru
$PBExportComments$Boton para Cancelar y Salir.
forward
global type u_cancelar from commandbutton
end type
end forward

global type u_cancelar from commandbutton
int Width=407
int Height=93
int TabOrder=1
string Text="Cancelar"
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_cancelar u_cancelar

on clicked;Close (Parent)
end on

