﻿$PBExportHeader$w_con_stock_formato.srw
forward
global type w_con_stock_formato from w_int_con_empresa
end type
type gb_5 from groupbox within w_con_stock_formato
end type
type gb_4 from groupbox within w_con_stock_formato
end type
type gb_2 from groupbox within w_con_stock_formato
end type
type pb_2 from upb_salir within w_con_stock_formato
end type
type dw_listado from datawindow within w_con_stock_formato
end type
type cb_1 from commandbutton within w_con_stock_formato
end type
type cb_2 from commandbutton within w_con_stock_formato
end type
type uo_calidad from u_marca_lista within w_con_stock_formato
end type
type st_1 from statictext within w_con_stock_formato
end type
type rb_1 from radiobutton within w_con_stock_formato
end type
type rb_2 from radiobutton within w_con_stock_formato
end type
type em_cuanto from u_em_campo within w_con_stock_formato
end type
type gb_3 from groupbox within w_con_stock_formato
end type
type rb_5 from radiobutton within w_con_stock_formato
end type
type rb_6 from radiobutton within w_con_stock_formato
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_formato
end type
type dw_consulta from datawindow within w_con_stock_formato
end type
type uo_1 from u_manejo_datawindow within w_con_stock_formato
end type
type cb_3 from commandbutton within w_con_stock_formato
end type
end forward

global type w_con_stock_formato from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3278
integer height = 1708
string title = "Consulta de Movimientos"
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
pb_2 pb_2
dw_listado dw_listado
cb_1 cb_1
cb_2 cb_2
uo_calidad uo_calidad
st_1 st_1
rb_1 rb_1
rb_2 rb_2
em_cuanto em_cuanto
gb_3 gb_3
rb_5 rb_5
rb_6 rb_6
pb_imprimir_preli pb_imprimir_preli
dw_consulta dw_consulta
uo_1 uo_1
cb_3 cb_3
end type
global w_con_stock_formato w_con_stock_formato

type variables
String ante_articulo,retrasos
int como
end variables

forward prototypes
public subroutine f_totales (string tipo, long donde)
public function string f_filtro2 ()
public subroutine f_totales_listado (string tipo, long donde)
end prototypes

public subroutine f_totales (string tipo, long donde);dec{2} reservado,preparado
string articulo,calidad,tono
long   calibre

if tipo="S" then
  articulo    = dw_consulta.getitemstring(donde,"almlinubica_articulo")
  calidad     = dw_consulta.getitemstring(donde,"almlinubica_calidad") 
  tono        = dw_consulta.getitemstring(donde,"tonochar") 
  calibre     = dw_consulta.getitemnumber(donde,"calibre") 
  reservado   = f_reservado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
  preparado   = f_preparado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
else
  reservado  = 0
  preparado  = 0
end if
dw_consulta.SetItem(donde,"reservado",reservado)
dw_consulta.SetItem(donde,"preparado",preparado)
end subroutine

public function string f_filtro2 ();string filtro
if rb_1.checked then
	filtro="(disponible >= "+string(dec(em_cuanto.text),"##############0")+")"
else
	filtro="(disponible < "+string(dec(em_cuanto.text),"##############0")+")"
end if
return filtro
end function

public subroutine f_totales_listado (string tipo, long donde);dec{2} reservado,preparado
string articulo,calidad,tono
long   calibre

if tipo="S" then
  articulo    = dw_listado.getitemstring(donde,"almlinubica_articulo")
  calidad     = dw_listado.getitemstring(donde,"almlinubica_calidad") 
  tono        = dw_listado.getitemstring(donde,"tonochar") 
  calibre     = dw_listado.getitemnumber(donde,"calibre") 
  reservado   = f_reservado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
  preparado   = f_preparado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
else
  reservado  = 0
  preparado  = 0
end if
dw_listado.SetItem(donde,"reservado",reservado)
dw_listado.SetItem(donde,"preparado",preparado)
end subroutine

event open;call super::open;dw_consulta.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA STOCK POR CALIDADES"

uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")

// Se utiliza para el boton de marcar ó desmarcar
//   como = 0
//   cb_3.text ="&Marcar"
/////////////////////////////////////////////////	

em_cuanto.SetFocus()


end event

on w_con_stock_formato.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_calidad=create uo_calidad
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_cuanto=create em_cuanto
this.gb_3=create gb_3
this.rb_5=create rb_5
this.rb_6=create rb_6
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_consulta=create dw_consulta
this.uo_1=create uo_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.uo_calidad
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.em_cuanto
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.rb_5
this.Control[iCurrent+15]=this.rb_6
this.Control[iCurrent+16]=this.pb_imprimir_preli
this.Control[iCurrent+17]=this.dw_consulta
this.Control[iCurrent+18]=this.uo_1
this.Control[iCurrent+19]=this.cb_3
end on

on w_con_stock_formato.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_calidad)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_cuanto)
destroy(this.gb_3)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_formato
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_formato
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_formato
integer y = 20
integer width = 2377
end type

type gb_5 from groupbox within w_con_stock_formato
integer x = 1376
integer y = 100
integer width = 402
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_con_stock_formato
integer x = 965
integer y = 100
integer width = 402
integer height = 184
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_stock_formato
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

type pb_2 from upb_salir within w_con_stock_formato
integer x = 2729
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado from datawindow within w_con_stock_formato
boolean visible = false
integer x = 2921
integer y = 24
integer width = 178
integer height = 156
boolean bringtotop = true
string dataobject = "report_con_stock_formatos_2"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_stock_formato
integer x = 1824
integer y = 144
integer width = 357
integer height = 64
integer taborder = 50
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

type cb_2 from commandbutton within w_con_stock_formato
event clicked pbm_bnclicked
integer x = 1824
integer y = 208
integer width = 357
integer height = 64
integer taborder = 60
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
	calidades[i] = ""
next

for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next
tipounidad = "0"
if rb_6.checked = True THEN tipounidad = "1"

dw_consulta.retrieve(codigo_empresa,calidades,tipounidad)

if dw_consulta.rowcount()=0 then
	pb_imprimir_preli.enabled=false

	return
else
	pb_imprimir_preli.enabled=true
end if

for i=1 TO dw_consulta.rowcount()
	f_mensaje_proceso("Calculando Totales",i,dw_consulta.rowcount())	
	f_totales("S",i)
next

dw_consulta.setfilter(f_filtro2())
dw_consulta.filter()
dw_consulta.sort()
dw_consulta.groupcalc()
dw_consulta.SetRedraw(TRUE)

cb_3.enabled = True
end event

type uo_calidad from u_marca_lista within w_con_stock_formato
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

type st_1 from statictext within w_con_stock_formato
integer x = 55
integer y = 172
integer width = 306
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_con_stock_formato
integer x = 370
integer y = 212
integer width = 160
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Symbol"
long backcolor = 12632256
string text = "³"
boolean checked = true
end type

type rb_2 from radiobutton within w_con_stock_formato
integer x = 370
integer y = 152
integer width = 160
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Symbol"
long backcolor = 12632256
string text = "<"
end type

type em_cuanto from u_em_campo within w_con_stock_formato
integer x = 535
integer y = 168
integer width = 320
integer taborder = 20
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###,##0"
string displaydata = "$"
end type

type gb_3 from groupbox within w_con_stock_formato
integer y = 100
integer width = 960
integer height = 184
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type rb_5 from radiobutton within w_con_stock_formato
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
boolean checked = true
end type

type rb_6 from radiobutton within w_con_stock_formato
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
end type

type pb_imprimir_preli from upb_imprimir within w_con_stock_formato
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
uo_calidad.visible=false
dw_consulta.SetRedraw(FALSE)
string calidades[1 to 20],tipounidad,articulo
long i

for i=1 to 20
	calidades[i] = ""
next

for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next
tipounidad = "0"
if rb_6.checked = True THEN tipounidad = "1"

dw_listado.retrieve(codigo_empresa,calidades,tipounidad)

if dw_listado.rowcount()=0 then return

for i=1 TO dw_listado.rowcount()
	f_mensaje_proceso("Calculando Totales",i,dw_listado.rowcount())
	f_totales_listado("S",i)
next

dw_listado.setfilter(f_filtro2())
dw_listado.filter()
dw_listado.sort()
dw_listado.groupcalc()
dw_listado.SetRedraw(TRUE)
cb_3.enabled = True

f_imprimir_datawindow(dw_listado)

end event

type dw_consulta from datawindow within w_con_stock_formato
integer y = 292
integer width = 3182
integer height = 1148
boolean bringtotop = true
string dataobject = "dw_con_stock_formatos_2"
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

type uo_1 from u_manejo_datawindow within w_con_stock_formato
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

type cb_3 from commandbutton within w_con_stock_formato
boolean visible = false
integer x = 27
integer y = 1364
integer width = 366
integer height = 60
integer taborder = 70
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

