﻿$PBExportHeader$wc_mensaje_proceso.srw
forward
global type wc_mensaje_proceso from window
end type
type medidor from olecustomcontrol within wc_mensaje_proceso
end type
type barra_progreso from hprogressbar within wc_mensaje_proceso
end type
type contador from u_barra_contador within wc_mensaje_proceso
end type
type mensaje from statictext within wc_mensaje_proceso
end type
end forward

shared variables

end variables

global type wc_mensaje_proceso from window
integer x = 18
integer y = 20
integer width = 3534
integer height = 156
boolean titlebar = true
string title = "Espere por favor ..."
windowtype windowtype = popup!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatbottom!
medidor medidor
barra_progreso barra_progreso
contador contador
mensaje mensaje
end type
global wc_mensaje_proceso wc_mensaje_proceso

type variables
// Valor de control del zoom
integer ii_valor_zoom = 70
// Valores minimos, alto y ancho
integer ii_alto_min, ii_ancho_min
// Indica si aparece o no la regla de medida
string is_regla_visible = "yes"
str_parametros istr_parametros	
Datawindow dw_data
String  objeto,tipo,ante_objeto,tipoobj
Integer elemento
Boolean campo_visible
String   cri[],pal[]
STring   cadena,palabra,letra
Integer  re,contador1,contador2

Long id_ventana_activa
end variables

on wc_mensaje_proceso.create
this.medidor=create medidor
this.barra_progreso=create barra_progreso
this.contador=create contador
this.mensaje=create mensaje
this.Control[]={this.medidor,&
this.barra_progreso,&
this.contador,&
this.mensaje}
end on

on wc_mensaje_proceso.destroy
destroy(this.medidor)
destroy(this.barra_progreso)
destroy(this.contador)
destroy(this.mensaje)
end on

event activate;//id_ventana_activa = f_menu_insertar_ventana(this)
end event

event close;//f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type medidor from olecustomcontrol within wc_mensaje_proceso
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
boolean visible = false
integer x = 18
integer y = 536
integer width = 2034
integer height = 108
integer taborder = 1
borderstyle borderstyle = styleraised!
long backcolor = 16777215
string binarykey = "wc_mensaje_proceso.win"
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type barra_progreso from hprogressbar within wc_mensaje_proceso
integer x = 503
integer y = 4
integer width = 3008
integer height = 60
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type contador from u_barra_contador within wc_mensaje_proceso
boolean visible = false
integer x = 503
integer y = 4
integer width = 3008
integer height = 64
integer taborder = 2
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on contador.destroy
call u_barra_contador::destroy
end on

type mensaje from statictext within wc_mensaje_proceso
integer width = 3520
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "  Proceso"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dwc_mensaje_proceso.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dwc_mensaje_proceso.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
