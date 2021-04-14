$PBExportHeader$w_con_detalle_pago_agrupado.srw
forward
global type w_con_detalle_pago_agrupado from window
end type
type dw_1 from datawindow within w_con_detalle_pago_agrupado
end type
type texto_fecha from u_em_campo within w_con_detalle_pago_agrupado
end type
end forward

global type w_con_detalle_pago_agrupado from window
integer x = 23
integer y = 640
integer width = 3845
integer height = 764
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
dw_1 dw_1
texto_fecha texto_fecha
end type
global w_con_detalle_pago_agrupado w_con_detalle_pago_agrupado

on w_con_detalle_pago_agrupado.create
this.dw_1=create dw_1
this.texto_fecha=create texto_fecha
this.Control[]={this.dw_1,&
this.texto_fecha}
end on

on w_con_detalle_pago_agrupado.destroy
destroy(this.dw_1)
destroy(this.texto_fecha)
end on

event open;str_parametros param
long anyo,orden,arg_x,arg_y

dw_1.settransobject(sqlca)

param = message.PowerObjectParm
anyo  = dec(param.s_argumentos[1])
orden = dec(param.s_argumentos[2])
this.title = "Detalle Agrupado "+param.s_argumentos[3]

arg_y = dec(param.s_argumentos[4])
arg_y = arg_y
this.x = 80

if arg_y < 90 then
	this.y = arg_y
else	
	this.y = arg_y - 90
end if

dw_1.retrieve(codigo_empresa,anyo,orden)
end event

type dw_1 from datawindow within w_con_detalle_pago_agrupado
integer width = 3799
integer height = 652
integer taborder = 10
string dataobject = "dw_con_detalle_pago_agrupado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;close(parent)
end event

type texto_fecha from u_em_campo within w_con_detalle_pago_agrupado
boolean visible = false
integer x = 512
integer y = 336
integer width = 338
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "<8"
end type

