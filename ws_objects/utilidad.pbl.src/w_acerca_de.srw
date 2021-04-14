$PBExportHeader$w_acerca_de.srw
forward
global type w_acerca_de from Window
end type
type st_14 from statictext within w_acerca_de
end type
type st_13 from statictext within w_acerca_de
end type
type st_12 from statictext within w_acerca_de
end type
type st_11 from statictext within w_acerca_de
end type
type st_2 from statictext within w_acerca_de
end type
type cb_1 from commandbutton within w_acerca_de
end type
type c3 from statictext within w_acerca_de
end type
type st_9 from statictext within w_acerca_de
end type
type st_8 from statictext within w_acerca_de
end type
type st_7 from statictext within w_acerca_de
end type
type c4 from statictext within w_acerca_de
end type
type st_5 from statictext within w_acerca_de
end type
type c1 from statictext within w_acerca_de
end type
type c2 from statictext within w_acerca_de
end type
type st_1 from statictext within w_acerca_de
end type
type ln_2 from line within w_acerca_de
end type
type ln_3 from line within w_acerca_de
end type
end forward

global type w_acerca_de from Window
int X=673
int Y=269
int Width=1843
int Height=621
long BackColor=8421376
WindowType WindowType=response!
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_2 st_2
cb_1 cb_1
c3 c3
st_9 st_9
st_8 st_8
st_7 st_7
c4 c4
st_5 st_5
c1 c1
c2 c2
st_1 st_1
ln_2 ln_2
ln_3 ln_3
end type
global w_acerca_de w_acerca_de

type variables
Integer posy1,posx1,contador
Integer posy2,posx2
Integer posy3,posx3
Integer posy4,posx4
String opcion = "1"
end variables

on w_acerca_de.create
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_2=create st_2
this.cb_1=create cb_1
this.c3=create c3
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.c4=create c4
this.st_5=create st_5
this.c1=create c1
this.c2=create c2
this.st_1=create st_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.Control[]={ this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_2,&
this.cb_1,&
this.c3,&
this.st_9,&
this.st_8,&
this.st_7,&
this.c4,&
this.st_5,&
this.c1,&
this.c2,&
this.st_1,&
this.ln_2,&
this.ln_3}
end on

on w_acerca_de.destroy
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.c3)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.c4)
destroy(this.st_5)
destroy(this.c1)
destroy(this.c2)
destroy(this.st_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event open;contador = 1
posx1 = c1.x
posy1 = c1.y
posx2 = c2.x
posy2 = c2.y
posx3 = c3.x
posy3 = c3.y
posx4 = c4.x
posy4 = c4.y
Timer(.05)
end event

event timer;IF opcion = "1" Then
	contador = contador +1
ELSE
	contador = contador -1
END IF

IF contador = 30 or contador = 0 Then

	IF opcion = "1" Then
		Idle(3)
		opcion = "2"
	ELSE
		opcion = "1"
	END IF
END IF

	c1.x = posx1 - contador
	c2.x = posx2  + contador
	c3.x = posx3  + contador
	c4.x = posx4  - contador
	c1.y = posy1 - contador
	c2.y = posy2 + contador
	c3.y = posy3 - contador
	c4.y = posy4 + contador


end event

type st_14 from statictext within w_acerca_de
int X=1381
int Y=501
int Width=403
int Height=49
boolean Enabled=false
string Text="46001 VALENCIA"
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within w_acerca_de
int X=23
int Y=521
int Width=1061
int Height=45
boolean Enabled=false
string Text="TELEFONO: 96-352.41.82 - FAX: 96-352.69.64"
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_acerca_de
int X=23
int Y=469
int Width=750
int Height=49
boolean Enabled=false
string Text="C/ NTRA. SRA. DE GRACIA, 4-6"
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_acerca_de
int X=517
int Y=201
int Width=1203
int Height=77
boolean Enabled=false
string Text="Consultoría  y  desarrollo  de  Software."
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_acerca_de
int X=522
int Y=117
int Width=1203
int Height=105
boolean Enabled=false
string Text="JOBERS  S.L."
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-15
int Weight=400
string FaceName="MS Serif"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_acerca_de
int X=1518
int Y=361
int Width=206
int Height=85
int TabOrder=1
string Text="Ok"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(w_acerca_de)
end event

type c3 from statictext within w_acerca_de
int X=284
int Y=85
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_acerca_de
int X=92
int Y=169
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_acerca_de
int X=188
int Y=169
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_acerca_de
int X=284
int Y=169
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type c4 from statictext within w_acerca_de
int X=92
int Y=253
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_acerca_de
int X=188
int Y=253
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type c1 from statictext within w_acerca_de
int X=69
int Y=65
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type c2 from statictext within w_acerca_de
int X=307
int Y=273
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_acerca_de
int X=188
int Y=85
int Width=97
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_2 from line within w_acerca_de
boolean Enabled=false
int BeginX=522
int BeginY=281
int EndX=1701
int EndY=281
int LineThickness=5
long LineColor=15793151
end type

type ln_3 from line within w_acerca_de
boolean Enabled=false
int BeginX=526
int BeginY=293
int EndX=1697
int EndY=293
int LineThickness=9
long LineColor=33554432
end type

