$PBExportHeader$w_detalle_agrupado.srw
$PBExportComments$€
forward
global type w_detalle_agrupado from window
end type
type dw_detalle from datawindow within w_detalle_agrupado
end type
type dw_cabecera from datawindow within w_detalle_agrupado
end type
type pb_salir from upb_salir within w_detalle_agrupado
end type
type st_2 from statictext within w_detalle_agrupado
end type
type st_1 from statictext within w_detalle_agrupado
end type
end forward

global type w_detalle_agrupado from window
integer x = 165
integer y = 536
integer width = 2587
integer height = 912
boolean titlebar = true
string title = "Detalle del Recibo Agrupado"
boolean controlmenu = true
long backcolor = 79741120
boolean center = true
dw_detalle dw_detalle
dw_cabecera dw_cabecera
pb_salir pb_salir
st_2 st_2
st_1 st_1
end type
global w_detalle_agrupado w_detalle_agrupado

type variables
dec var_anyo,var_orden
string var_empresa
str_parametros	istr_parametros
end variables

on w_detalle_agrupado.create
this.dw_detalle=create dw_detalle
this.dw_cabecera=create dw_cabecera
this.pb_salir=create pb_salir
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.dw_detalle,&
this.dw_cabecera,&
this.pb_salir,&
this.st_2,&
this.st_1}
end on

on w_detalle_agrupado.destroy
destroy(this.dw_detalle)
destroy(this.dw_cabecera)
destroy(this.pb_salir)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;istr_parametros= Message.PowerObjectParm

var_empresa=istr_parametros.s_argumentos[1]
var_anyo =dec(istr_parametros.s_argumentos[2])
var_orden=dec(istr_parametros.s_argumentos[3])

f_posicion_inicio(this)

dw_cabecera.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)

dw_cabecera.Retrieve(var_empresa,var_anyo,var_orden)
dw_detalle.Retrieve(var_empresa,var_anyo,var_orden)


	


end event

event timer;pb_salir.TriggerEvent(Clicked!)	

end event

type dw_detalle from datawindow within w_detalle_agrupado
integer x = 73
integer y = 276
integer width = 2258
integer height = 512
integer taborder = 3
string dataobject = "dw_detalle_agrupados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_cabecera from datawindow within w_detalle_agrupado
integer x = 686
integer y = 64
integer width = 1591
integer height = 164
integer taborder = 20
boolean enabled = false
string dataobject = "dw_cabecera_agrupados"
boolean border = false
end type

type pb_salir from upb_salir within w_detalle_agrupado
integer x = 2377
integer y = 64
integer width = 110
integer height = 96
integer taborder = 10
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_detalle_agrupado
integer x = 73
integer y = 192
integer width = 279
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Detalle:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_detalle_agrupado
integer x = 73
integer y = 64
integer width = 553
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Recibo Agrupado:"
boolean focusrectangle = false
end type

