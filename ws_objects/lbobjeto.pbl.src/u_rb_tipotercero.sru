$PBExportHeader$u_rb_tipotercero.sru
$PBExportComments$Opciones para seleccionar el tipo tercero.
forward
global type u_rb_tipotercero from UserObject
end type
type rb_opcion3 from radiobutton within u_rb_tipotercero
end type
type rb_opcion2 from radiobutton within u_rb_tipotercero
end type
type rb_opcion1 from radiobutton within u_rb_tipotercero
end type
type gb_1 from groupbox within u_rb_tipotercero
end type
end forward

global type u_rb_tipotercero from UserObject
int Width=842
int Height=457
boolean Border=true
long BackColor=12632256
rb_opcion3 rb_opcion3
rb_opcion2 rb_opcion2
rb_opcion1 rb_opcion1
gb_1 gb_1
end type
global u_rb_tipotercero u_rb_tipotercero

type variables
	// Tipo Tercero

char ic_tipoter
end variables

on u_rb_tipotercero.create
this.rb_opcion3=create rb_opcion3
this.rb_opcion2=create rb_opcion2
this.rb_opcion1=create rb_opcion1
this.gb_1=create gb_1
this.Control[]={ this.rb_opcion3,&
this.rb_opcion2,&
this.rb_opcion1,&
this.gb_1}
end on

on u_rb_tipotercero.destroy
destroy(this.rb_opcion3)
destroy(this.rb_opcion2)
destroy(this.rb_opcion1)
destroy(this.gb_1)
end on

type rb_opcion3 from radiobutton within u_rb_tipotercero
int X=161
int Y=301
int Width=444
int Height=73
int TabOrder=30
string Text="&Tercero"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ic_tipoter = "T"
end on

type rb_opcion2 from radiobutton within u_rb_tipotercero
int X=161
int Y=201
int Width=444
int Height=73
int TabOrder=20
string Text="&Proveedor"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ic_tipoter = "P"
end on

type rb_opcion1 from radiobutton within u_rb_tipotercero
int X=161
int Y=101
int Width=444
int Height=73
int TabOrder=10
string Text="&Cliente"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ic_tipoter = "C"

end on

type gb_1 from groupbox within u_rb_tipotercero
int X=23
int Width=778
int Height=421
string Text="Tipo Tercero"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

