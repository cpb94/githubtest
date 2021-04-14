$PBExportHeader$u_manejo_datawindow.sru
$PBExportComments$Manipulador de datawindow.
forward
global type u_manejo_datawindow from UserObject
end type
type pb_siguiente from picturebutton within u_manejo_datawindow
end type
type pb_primero from picturebutton within u_manejo_datawindow
end type
type pb_ultimo from picturebutton within u_manejo_datawindow
end type
type pb_anterior from picturebutton within u_manejo_datawindow
end type
type linea_arriba from statictext within u_manejo_datawindow
end type
type linea_abajo from statictext within u_manejo_datawindow
end type
type gb_1 from groupbox within u_manejo_datawindow
end type
end forward

global type u_manejo_datawindow from UserObject
int Width=626
int Height=152
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event valores pbm_custom01
event pagina_arriba pbm_custom02
event pagina_abajo pbm_custom03
event linea_arriba pbm_custom04
event linea_abajo pbm_custom05
pb_siguiente pb_siguiente
pb_primero pb_primero
pb_ultimo pb_ultimo
pb_anterior pb_anterior
linea_arriba linea_arriba
linea_abajo linea_abajo
gb_1 gb_1
end type
global u_manejo_datawindow u_manejo_datawindow

type variables
datawindow   dw_data
end variables

forward prototypes
public subroutine pagina_abajo ()
public subroutine pagina_arriba ()
public subroutine linea_abajo ()
public subroutine linea_arriba ()
end prototypes

on valores;// Introducir  el valor de (dw_data )

end on

on pagina_arriba;pagina_arriba()
end on

on pagina_abajo;pagina_abajo()



end on

on linea_arriba;linea_arriba()
end on

on linea_abajo;linea_abajo()
end on

public subroutine pagina_abajo ();pb_siguiente.TriggerEvent(Clicked!)
end subroutine

public subroutine pagina_arriba ();pb_anterior.TriggerEvent(Clicked!)
end subroutine

public subroutine linea_abajo ();linea_abajo.TriggerEvent(clicked!)

end subroutine

public subroutine linea_arriba ();linea_arriba.TriggerEvent(clicked!)

end subroutine

on u_manejo_datawindow.create
this.pb_siguiente=create pb_siguiente
this.pb_primero=create pb_primero
this.pb_ultimo=create pb_ultimo
this.pb_anterior=create pb_anterior
this.linea_arriba=create linea_arriba
this.linea_abajo=create linea_abajo
this.gb_1=create gb_1
this.Control[]={this.pb_siguiente,&
this.pb_primero,&
this.pb_ultimo,&
this.pb_anterior,&
this.linea_arriba,&
this.linea_abajo,&
this.gb_1}
end on

on u_manejo_datawindow.destroy
destroy(this.pb_siguiente)
destroy(this.pb_primero)
destroy(this.pb_ultimo)
destroy(this.pb_anterior)
destroy(this.linea_arriba)
destroy(this.linea_abajo)
destroy(this.gb_1)
end on

type pb_siguiente from picturebutton within u_manejo_datawindow
int X=256
int Y=48
int Width=101
int Height=84
string PictureName="c:\bmp\next1.bmp"
string DisabledName="c:\bmp\next2.bmp"
boolean OriginalSize=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent("valores")
IF dw_data.RowCount() = 0 Then   Return
dw_data.ScrollNextPage()
Parent.TriggerEvent("valores")
end event

type pb_primero from picturebutton within u_manejo_datawindow
int X=37
int Y=48
int Width=101
int Height=84
string PictureName="c:\bmp\first1.bmp"
string DisabledName="c:\bmp\first2.bmp"
boolean OriginalSize=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked; Parent.TriggerEvent("valores")
 IF dw_data.RowCount() = 0 Then   Return
 dw_data.ScrollToRow(0)
 Parent.TriggerEvent("valores")


end event

type pb_ultimo from picturebutton within u_manejo_datawindow
int X=366
int Y=48
int Width=101
int Height=84
string PictureName="c:\bmp\last1.bmp"
string DisabledName="c:\bmp\last2.bmp"
boolean OriginalSize=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked; Parent.TriggerEvent("valores")
 IF dw_data.RowCount() = 0 Then    Return
 dw_data.ScrollToRow(999999)
Parent.TriggerEvent("valores")


end event

type pb_anterior from picturebutton within u_manejo_datawindow
int X=146
int Y=48
int Width=101
int Height=84
string PictureName="c:\bmp\prior1.bmp"
string DisabledName="c:\bmp\prior2.bmp"
boolean OriginalSize=true
string Pointer="\bmp\MANO.CUR"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent("valores")
IF dw_data.RowCount() = 0 Then   Return
dw_data.ScrollPriorPage()
Parent.TriggerEvent("valores")


end event

type linea_arriba from statictext within u_manejo_datawindow
int X=617
int Width=46
int Height=40
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Integer linea 
Parent.TriggerEvent("valores")
linea = Integer(dw_data.Describe("DataWindow.FirstRowOnPage"))
dw_data.SetRow(linea)
IF dw_data.RowCount() = 0 Then Return
IF dw_data.GetRow() -1 =0 Then Return
dw_data.ScrollToRow(dw_data.GetRow() -1)
end on

type linea_abajo from statictext within u_manejo_datawindow
int X=617
int Y=132
int Width=46
int Height=40
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Integer linea
Parent.TriggerEvent("valores")
IF dw_data.RowCount() = 0 Then Return
linea = Integer(dw_data.Describe("DataWindow.LastRowOnPage"))
dw_data.SetRow(linea)
IF dw_data.GetRow() +1 > dw_data.RowCount() Then Return
dw_data.ScrollToRow(dw_data.GetRow() +1)
end on

type gb_1 from groupbox within u_manejo_datawindow
int X=14
int Width=585
int Height=148
BorderStyle BorderStyle=StyleLowered!
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

