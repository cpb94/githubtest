$PBExportHeader$u_selec_impresoras.sru
$PBExportComments$Objeto manejo de datos (Mantenientos, y tabutares con opcion a ventana de ayuda etc)
forward
global type u_selec_impresoras from userobject
end type
type sacar from commandbutton within u_selec_impresoras
end type
type cb_impresora from u_boton within u_selec_impresoras
end type
type sle_impresora from editmask within u_selec_impresoras
end type
end forward

global type u_selec_impresoras from userobject
integer width = 1390
integer height = 108
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_valores pbm_custom01
sacar sacar
cb_impresora cb_impresora
sle_impresora sle_impresora
end type
global u_selec_impresoras u_selec_impresoras

type variables
Datawindow  u_selec_impresoras_report

end variables

event ue_valores;// introducir el valor de u_selec_impresoras_report
end event

event constructor;sacar.TriggerEvent(Clicked!)

end event

on u_selec_impresoras.create
this.sacar=create sacar
this.cb_impresora=create cb_impresora
this.sle_impresora=create sle_impresora
this.Control[]={this.sacar,&
this.cb_impresora,&
this.sle_impresora}
end on

on u_selec_impresoras.destroy
destroy(this.sacar)
destroy(this.cb_impresora)
destroy(this.sle_impresora)
end on

type sacar from commandbutton within u_selec_impresoras
boolean visible = false
integer x = 485
integer y = 12
integer width = 247
integer height = 108
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "sarcar"
end type

event clicked;Parent.TriggerEvent("ue_valores")
IF IsValid(u_selec_impresoras_report) Then
	sle_impresora.text = u_selec_impresoras_report.Describe('datawindow.printer')
	
//	if sle_impresora.text = "?" then
//		cb_impresora.event clicked()
//	end if
END IF
end event

type cb_impresora from u_boton within u_selec_impresoras
event clicked pbm_bnclicked
integer y = 4
integer width = 347
integer height = 92
integer taborder = 0
string text = "Im&presoras"
end type

event clicked;call super::clicked;PrintSetup()
sacar.TriggerEvent(Clicked!)

end event

type sle_impresora from editmask within u_selec_impresoras
integer x = 352
integer y = 4
integer width = 1024
integer height = 92
integer taborder = 2
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 12632256
boolean enabled = false
boolean displayonly = true
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
string displaydata = "À"
end type

