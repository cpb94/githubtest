$PBExportHeader$w_informe_pantallas.srw
forward
global type w_informe_pantallas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_informe_pantallas
end type
type pb_2 from upb_imprimir within w_informe_pantallas
end type
type cb_1 from commandbutton within w_informe_pantallas
end type
type gb_1 from groupbox within w_informe_pantallas
end type
type gb_6 from groupbox within w_informe_pantallas
end type
type dw_informe from datawindow within w_informe_pantallas
end type
type em_fdesde from u_em_campo within w_informe_pantallas
end type
type em_fhasta from u_em_campo within w_informe_pantallas
end type
end forward

global type w_informe_pantallas from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3383
integer height = 3268
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
end type
global w_informe_pantallas w_informe_pantallas

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);
data.SetTransObject(SQLCA)
data.retrieve(codigo_empresa)

data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Resumen de Producción"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-09-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_informe_pantallas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
end on

on w_informe_pantallas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_informe_pantallas
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_informe_pantallas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_informe_pantallas
integer y = 8
integer width = 3287
integer height = 84
end type

type pb_1 from upb_salir within w_informe_pantallas
integer x = 3163
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_informe_pantallas
integer x = 3026
integer y = 156
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control_copia(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_informe_pantallas
integer x = 2729
integer y = 156
integer width = 288
integer height = 96
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

type gb_1 from groupbox within w_informe_pantallas
integer x = 78
integer y = 112
integer width = 773
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_6 from groupbox within w_informe_pantallas
integer x = 2706
integer y = 112
integer width = 599
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_informe_pantallas
integer x = 9
integer y = 284
integer width = 3310
integer height = 2752
boolean bringtotop = true
string dataobject = "dw_informe_pantallas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_informe_pantallas
integer x = 101
integer y = 168
integer width = 357
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_informe_pantallas
integer x = 471
integer y = 168
integer width = 357
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

