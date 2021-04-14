$PBExportHeader$w_ver_seleccion_tencer.srw
forward
global type w_ver_seleccion_tencer from window
end type
type dw_1 from datawindow within w_ver_seleccion_tencer
end type
end forward

global type w_ver_seleccion_tencer from window
integer x = 1056
integer y = 484
integer width = 2766
integer height = 1184
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 80269524
dw_1 dw_1
end type
global w_ver_seleccion_tencer w_ver_seleccion_tencer

type variables
datawindow DW
end variables

on w_ver_seleccion_tencer.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_ver_seleccion_tencer.destroy
destroy(this.dw_1)
end on

event open;string usuario

usuario = nombre_usuario

//DW = w_planificacion.dw_1
DW = Message.PowerObjectParm

Dw_1.SetTransObject(SQLCA)
dw_1.retrieve (usuario,codigo_empresa)
end event

type dw_1 from datawindow within w_ver_seleccion_tencer
integer x = 18
integer y = 24
integer width = 2729
integer height = 1040
integer taborder = 10
string dataobject = "dw_ver_seleccion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long v_ot, fila_seleccionada
string cod_linea, linea

v_ot = w_ver_seleccion_tencer.dw_1.object.planificacion_ot[row]
linea = w_ver_seleccion_tencer.dw_1.object.prodlineas_resumido[row]

select codigo 
into :cod_linea
from prodlineas
where resumido = :linea
and empresa = :codigo_empresa;

DW.retrieve(codigo_empresa,cod_linea)
fila_seleccionada = DW.Find ("ot = "+string(v_ot), 1, DW.RowCount() )
DW.SelectRow ( fila_seleccionada, true )
DW.ScrollToRow ( fila_seleccionada)

w_planificacion_tencer_wide.uo_1.em_codigo.text = cod_linea
w_planificacion_tencer_wide.uo_1.em_campo.text = linea

close(parent)

end event

