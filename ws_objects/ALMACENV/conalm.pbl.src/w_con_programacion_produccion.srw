﻿$PBExportHeader$w_con_programacion_produccion.srw
forward
global type w_con_programacion_produccion from w_int_con_empresa
end type
type gb_5 from groupbox within w_con_programacion_produccion
end type
type gb_2 from groupbox within w_con_programacion_produccion
end type
type pb_2 from upb_salir within w_con_programacion_produccion
end type
type dw_listado from datawindow within w_con_programacion_produccion
end type
type cb_1 from commandbutton within w_con_programacion_produccion
end type
type cb_2 from commandbutton within w_con_programacion_produccion
end type
type uo_calidad from u_marca_lista within w_con_programacion_produccion
end type
type rb_5 from radiobutton within w_con_programacion_produccion
end type
type rb_6 from radiobutton within w_con_programacion_produccion
end type
type pb_imprimir_preli from upb_imprimir within w_con_programacion_produccion
end type
type dw_consulta from datawindow within w_con_programacion_produccion
end type
type uo_1 from u_manejo_datawindow within w_con_programacion_produccion
end type
type cb_3 from commandbutton within w_con_programacion_produccion
end type
end forward

global type w_con_programacion_produccion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 1680
string title = "Consulta stock por calidades"
gb_5 gb_5
gb_2 gb_2
pb_2 pb_2
dw_listado dw_listado
cb_1 cb_1
cb_2 cb_2
uo_calidad uo_calidad
rb_5 rb_5
rb_6 rb_6
pb_imprimir_preli pb_imprimir_preli
dw_consulta dw_consulta
uo_1 uo_1
cb_3 cb_3
end type
global w_con_programacion_produccion w_con_programacion_produccion

type variables
String ante_articulo,retrasos
int como
end variables

forward prototypes
public subroutine f_totales (string tipo, long donde)
end prototypes

public subroutine f_totales (string tipo, long donde);dec{2} reservado,preparado,fabricar
string referencia,tipo_pallet
if tipo="S" then
  referencia = dw_consulta.getitemstring(donde,"referencia")
  tipo_pallet= dw_consulta.getitemstring(donde,"tipo_pallet") 
  reservado  = f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
  preparado  = f_preparado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
  fabricar   = f_fabricar_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
else
  reservado  = 0
  preparado  = 0
  fabricar   = 0
end if
	
  dw_consulta.SetItem(donde,"reservado",reservado)
  dw_consulta.SetItem(donde,"preparado",preparado)
  dw_consulta.SetItem(donde,"fabricar",fabricar)
end subroutine

event open;call super::open;dw_consulta.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = "Consulta stock por calidades"

uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")

// Se utiliza para el boton de marcar ó desmarcar
   como = 0
   cb_3.text ="&Marcar"
/////////////////////////////////////////////////	




end event

on w_con_programacion_produccion.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_calidad=create uo_calidad
this.rb_5=create rb_5
this.rb_6=create rb_6
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_consulta=create dw_consulta
this.uo_1=create uo_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.uo_calidad
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.dw_consulta
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.cb_3
end on

on w_con_programacion_produccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_calidad)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.pb_imprimir_preli)
destroy(this.dw_consulta)
destroy(this.uo_1)
destroy(this.cb_3)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_programacion_produccion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_programacion_produccion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_programacion_produccion
integer y = 20
integer width = 2377
end type

type gb_5 from groupbox within w_con_programacion_produccion
integer x = 1376
integer y = 100
integer width = 402
integer height = 184
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_programacion_produccion
integer x = 1810
integer y = 100
integer width = 384
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_programacion_produccion
integer x = 2729
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado from datawindow within w_con_programacion_produccion
boolean visible = false
integer x = 155
integer y = 4
integer width = 494
integer height = 156
boolean bringtotop = true
string dataobject = "report_con_stock_formatos_2"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_programacion_produccion
integer x = 1824
integer y = 144
integer width = 357
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;if uo_calidad.visible= True then
   uo_calidad.visible = False
else
	uo_calidad.visible= True
End if
end event

type cb_2 from commandbutton within w_con_programacion_produccion
event clicked pbm_bnclicked
integer x = 1824
integer y = 208
integer width = 357
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_consulta.reset()
uo_calidad.visible=false
dw_consulta.SetRedraw(FALSE)
string calidades[1 to 20],tipounidad
long i

for i=1 to 20
	calidades[i]=""
next

for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next
tipounidad = "0"
if rb_6.checked = True THEN tipounidad = "1"
f_mensaje_proceso("Espere Por Favor ",0,100)
dw_consulta.retrieve(codigo_empresa,calidades,tipounidad)
f_mensaje_proceso("Espere Por Favor ",50,100)
if dw_consulta.rowcount()=0 then
	pb_imprimir_preli.enabled=false
	f_mensaje_proceso("Espere Por Favor ",100,100)
	return
else
	pb_imprimir_preli.enabled=true
end if


for i=1 TO dw_consulta.rowcount()
	f_totales("S",i)
next
dw_consulta.filter()
dw_consulta.SetRedraw(TRUE)


f_mensaje_proceso("Espere Por Favor ",100,100)
cb_3.enabled = True
end event

type uo_calidad from u_marca_lista within w_con_programacion_produccion
event destroy ( )
boolean visible = false
integer x = 1504
integer y = 296
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type rb_5 from radiobutton within w_con_programacion_produccion
integer x = 1403
integer y = 140
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades"
end type

type rb_6 from radiobutton within w_con_programacion_produccion
integer x = 1403
integer y = 212
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Metros"
boolean checked = true
end type

type pb_imprimir_preli from upb_imprimir within w_con_programacion_produccion
integer x = 2738
integer y = 184
integer width = 101
integer height = 84
integer taborder = 10
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;integer bien
dw_listado.reset()
if dw_consulta.RowCount()=0 then cb_2.TriggerEvent(clicked!)
bien=dw_consulta.RowsCopy(1,dw_consulta.RowCount(), Primary!, dw_listado, 1, Primary!)
if bien=-1 or isnull(bien) then messagebox("Error al copiar lineas","Avise al administrador del sistema")
dw_listado.SetFilter("(marca='S')")
dw_listado.Filter()
f_imprimir_datawindow(dw_listado)

end event

type dw_consulta from datawindow within w_con_programacion_produccion
integer y = 292
integer width = 2862
integer height = 1148
boolean bringtotop = true
string dataobject = "dw_con_programacion_produccion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if isnull(row) then return
if row=0 then return

if getitemstring(row,"marca")="S" then
	setitem(row,"marca","N")
else
	setitem(row,"marca","S")
end if
end event

type uo_1 from u_manejo_datawindow within w_con_programacion_produccion
integer x = 2267
integer y = 136
integer width = 617
integer height = 168
end type

event valores;call super::valores;dw_data = dw_consulta
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_3 from commandbutton within w_con_programacion_produccion
integer x = 27
integer y = 1364
integer width = 366
integer height = 60
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
boolean enabled = false
end type

event clicked;integer r,r1
String var

if como=0 then
		como=1
		var ="S"
	   cb_3.text ="&Desmarcar"
 else
		como=0
		var ="N"
		cb_3.text ="&Marcar"
End if

dw_consulta.SetRedraw(False)
r1 = dw_consulta.RowCount()
for r = 1 To r1
		dw_consulta.SetItem(r,"marca",var)
Next
dw_consulta.SetRedraw(True)

end event

