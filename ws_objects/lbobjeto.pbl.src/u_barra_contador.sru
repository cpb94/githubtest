$PBExportHeader$u_barra_contador.sru
forward
global type u_barra_contador from userobject
end type
type st_1 from statictext within u_barra_contador
end type
type rc_2 from rectangle within u_barra_contador
end type
end forward

global type u_barra_contador from userobject
integer width = 2999
integer height = 52
long backcolor = 16777215
long tabtextcolor = 33554432
st_1 st_1
rc_2 rc_2
end type
global u_barra_contador u_barra_contador

type variables
// Determines if the progress bar has touched the 
// percentage text
boolean    ib_invert
end variables

forward prototypes
public subroutine f_contar (integer porcentaje)
end prototypes

public subroutine f_contar (integer porcentaje);
long	ll_color


//////////////////////////////////////////////////////////////////////
// Reset instance variable and colors if progress meter has been restarted
//////////////////////////////////////////////////////////////////////
if Int (porcentaje) = 0 then
	ib_invert = false
	st_1.TextColor = RGB (0, 0, 255)
	st_1.BackColor = RGB (255, 255, 255)	
end if


//////////////////////////////////////////////////////////////////////
// expand the progess bar
//////////////////////////////////////////////////////////////////////
rc_2.width = porcentaje / 100.0 * this.width
rc_2.visible = true

//////////////////////////////////////////////////////////////////////
// update the percentage text
//////////////////////////////////////////////////////////////////////
st_1.text = String (porcentaje / 100.0, "##0%")


//////////////////////////////////////////////////////////////////////
// check to see if the progress bar touches the percentage text.  
// If so, invert the percentage text colors.
//////////////////////////////////////////////////////////////////////
if not ib_invert then
	if rc_2.width >= st_1.x then
		ib_invert = true
		ll_color = st_1.textcolor
		st_1.TextColor = st_1.BackColor
		st_1.BackColor = ll_color
	end if
end if
end subroutine

on u_barra_contador.create
this.st_1=create st_1
this.rc_2=create rc_2
this.Control[]={this.st_1,&
this.rc_2}
end on

on u_barra_contador.destroy
destroy(this.st_1)
destroy(this.rc_2)
end on

type st_1 from statictext within u_barra_contador
integer x = 1431
integer width = 224
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 16777215
string text = "0%"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type rc_2 from rectangle within u_barra_contador
boolean visible = false
long linecolor = 16711680
integer linethickness = 5
long fillcolor = 16711680
integer width = 32
integer height = 144
end type

