$PBExportHeader$w_seguimiento_objetivos.srw
forward
global type w_seguimiento_objetivos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_seguimiento_objetivos
end type
type pb_2 from upb_imprimir within w_seguimiento_objetivos
end type
type cb_1 from commandbutton within w_seguimiento_objetivos
end type
type gb_1 from groupbox within w_seguimiento_objetivos
end type
type gb_6 from groupbox within w_seguimiento_objetivos
end type
type dw_informe from datawindow within w_seguimiento_objetivos
end type
type sle_anyo from singlelineedit within w_seguimiento_objetivos
end type
type st_titulo from statictext within w_seguimiento_objetivos
end type
type st_1 from statictext within w_seguimiento_objetivos
end type
type st_2 from statictext within w_seguimiento_objetivos
end type
end forward

global type w_seguimiento_objetivos from w_int_con_empresa
integer width = 5298
integer height = 3196
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
sle_anyo sle_anyo
st_titulo st_titulo
st_1 st_1
st_2 st_2
end type
global w_seguimiento_objetivos w_seguimiento_objetivos

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string mes
long fila_actual
dec{2} v_t_metros_ventas, v_t_metros_rev

data.SetTransObject(SQLCA)
data.Reset()

st_titulo.visible = true
st_titulo.text = '  C a r g a n d o     I n f o r m e   .  .  .  .  .  .  .  .  .   '
//data.setredraw(false)		
fila_actual = data.insertrow(0)
if long(sle_anyo.text) < year(today()) then
	data.retrieve(codigo_empresa, long(sle_anyo.text),13)
else
	data.retrieve(codigo_empresa, long(sle_anyo.text),month(today()))
end if

data.object.st_anyo.text = sle_anyo.text

st_titulo.visible = False

data.sort()
data.groupcalc()
//data.setredraw(true)
end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Seguimiento de Objetivos"
This.title=istr_parametros.s_titulo_ventana

//em_fdesde.text = "01-01-01"
//em_fhasta.text = string(today(),"dd-mm-yy")
sle_anyo.text = string(year(today()))


end event

on w_seguimiento_objetivos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.sle_anyo=create sle_anyo
this.st_titulo=create st_titulo
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.sle_anyo
this.Control[iCurrent+8]=this.st_titulo
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
end on

on w_seguimiento_objetivos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.sle_anyo)
destroy(this.st_titulo)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_seguimiento_objetivos
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_seguimiento_objetivos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_seguimiento_objetivos
integer y = 8
integer width = 5147
integer height = 84
end type

type pb_1 from upb_salir within w_seguimiento_objetivos
integer x = 5047
integer y = 132
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_seguimiento_objetivos
integer x = 4878
integer y = 132
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_seguimiento_objetivos
integer x = 4581
integer y = 132
integer width = 288
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_seguimiento_objetivos
integer x = 23
integer y = 84
integer width = 311
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type gb_6 from groupbox within w_seguimiento_objetivos
integer x = 4562
integer y = 92
integer width = 462
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_seguimiento_objetivos
integer x = 18
integer y = 256
integer width = 5184
integer height = 2672
boolean bringtotop = true
string dataobject = "dw_seguimiento_objetivos"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

type sle_anyo from singlelineedit within w_seguimiento_objetivos
integer x = 50
integer y = 140
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_titulo from statictext within w_seguimiento_objetivos
boolean visible = false
integer x = 1394
integer y = 124
integer width = 1728
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65535
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_seguimiento_objetivos
integer x = 2496
integer y = 108
integer width = 1275
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Tiene en cuenta Rappels y todos los dtos. excepto dtopp."
boolean focusrectangle = false
end type

type st_2 from statictext within w_seguimiento_objetivos
integer x = 2501
integer y = 164
integer width = 1275
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Incluye la facturación ajena a la actividad."
boolean focusrectangle = false
end type

