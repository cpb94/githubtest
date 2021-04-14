$PBExportHeader$rf_traspasos_oc_a_playa.srw
forward
global type rf_traspasos_oc_a_playa from window
end type
type dw_lineas_oc from datawindow within rf_traspasos_oc_a_playa
end type
type uo_1 from u_sle_codbar within rf_traspasos_oc_a_playa
end type
end forward

global type rf_traspasos_oc_a_playa from window
integer width = 4718
integer height = 2904
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_lineas_oc dw_lineas_oc
uo_1 uo_1
end type
global rf_traspasos_oc_a_playa rf_traspasos_oc_a_playa

on rf_traspasos_oc_a_playa.create
this.dw_lineas_oc=create dw_lineas_oc
this.uo_1=create uo_1
this.Control[]={this.dw_lineas_oc,&
this.uo_1}
end on

on rf_traspasos_oc_a_playa.destroy
destroy(this.dw_lineas_oc)
destroy(this.uo_1)
end on

type dw_lineas_oc from datawindow within rf_traspasos_oc_a_playa
integer x = 5
integer y = 152
integer width = 4626
integer height = 1292
integer taborder = 30
string title = "none"
string dataobject = "dw_rf_traspasos_oc_a_playa"
boolean livescroll = true
end type

type uo_1 from u_sle_codbar within rf_traspasos_oc_a_playa
integer x = 5
integer y = 1456
integer taborder = 20
boolean ib_obligatorio_marcar_una_linea = true
end type

on uo_1.destroy
call u_sle_codbar::destroy
end on

