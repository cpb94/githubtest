$PBExportHeader$w_con_act_amortizaciones.srw
forward
global type w_con_act_amortizaciones from w_int_con_empresa
end type
type dw_1 from u_datawindow_consultas within w_con_act_amortizaciones
end type
type rb_1 from radiobutton within w_con_act_amortizaciones
end type
type rb_2 from radiobutton within w_con_act_amortizaciones
end type
type rb_3 from radiobutton within w_con_act_amortizaciones
end type
type gb_1 from groupbox within w_con_act_amortizaciones
end type
type pb_1 from upb_salir within w_con_act_amortizaciones
end type
end forward

global type w_con_act_amortizaciones from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 2546
integer height = 2000
string title = "Consulta de las Amortizaciones"
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
gb_1 gb_1
pb_1 pb_1
end type
global w_con_act_amortizaciones w_con_act_amortizaciones

type variables
Dec{0}	elemento
end variables

event open;call super::open;This.x = 300
This.y = 250

dw_1.SetTransObject(sqlca)

IF istr_parametros.i_nargumentos>1 THEN
	elemento = Dec(istr_parametros.s_argumentos[2])
	dw_1.Retrieve(codigo_empresa,elemento,'S','N')
End IF
end event

on w_con_act_amortizaciones.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.gb_1=create gb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.pb_1
end on

on w_con_act_amortizaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.gb_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_act_amortizaciones
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_act_amortizaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_act_amortizaciones
integer width = 2245
end type

type dw_1 from u_datawindow_consultas within w_con_act_amortizaciones
integer x = 32
integer y = 156
integer width = 2258
integer height = 1548
integer taborder = 30
string dataobject = "dw_con_amortizaciones"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if f_objeto_datawindow(this) = "grabar" then
	this.accepttext()
	if this.update() = 1 then
		commit;
	else
		rollback;
		messagebox("Atención","Se ha producido un error al actualizar los datos")
	end if
	dw_1.Retrieve(codigo_empresa,elemento,'S','N')
end if

end event

type rb_1 from radiobutton within w_con_act_amortizaciones
integer x = 133
integer y = 1764
integer width = 494
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Actualizadas"
end type

event clicked;dw_1.Reset()
dw_1.Retrieve(codigo_empresa,elemento,'S','S')
end event

type rb_2 from radiobutton within w_con_act_amortizaciones
integer x = 635
integer y = 1764
integer width = 549
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No Actualizadas"
end type

event clicked;dw_1.Reset()
dw_1.Retrieve(codigo_empresa,elemento,'N','N')
end event

type rb_3 from radiobutton within w_con_act_amortizaciones
integer x = 1221
integer y = 1764
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todas"
boolean checked = true
end type

event clicked;dw_1.Reset()
dw_1.Retrieve(codigo_empresa,elemento,'S','N')
end event

type gb_1 from groupbox within w_con_act_amortizaciones
integer x = 91
integer y = 1704
integer width = 1458
integer height = 160
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_con_act_amortizaciones
integer x = 2331
integer y = 44
integer taborder = 2
string picturename = "c:\bmp\salir1.bmp"
end type

