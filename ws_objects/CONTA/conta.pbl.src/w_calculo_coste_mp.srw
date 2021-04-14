$PBExportHeader$w_calculo_coste_mp.srw
forward
global type w_calculo_coste_mp from w_int_con_empresa
end type
type st_1 from statictext within w_calculo_coste_mp
end type
end forward

global type w_calculo_coste_mp from w_int_con_empresa
integer height = 676
string title = "Cálculo del Coste de MP en Todos los Artículos"
string menuname = ""
boolean minbox = false
boolean maxbox = false
windowtype windowtype = response!
st_1 st_1
end type
global w_calculo_coste_mp w_calculo_coste_mp

event open;call super::open;f_calculo_coste_mp_general()
close(this)
end event

on w_calculo_coste_mp.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_calculo_coste_mp.destroy
call super::destroy
destroy(this.st_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_calculo_coste_mp
integer x = 421
integer y = 340
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_calculo_coste_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_calculo_coste_mp
end type

type st_1 from statictext within w_calculo_coste_mp
integer x = 82
integer y = 144
integer width = 2862
integer height = 156
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 553648127
string text = "Cálculo del Coste de MP en Todos los Artículos"
alignment alignment = center!
boolean focusrectangle = false
end type

