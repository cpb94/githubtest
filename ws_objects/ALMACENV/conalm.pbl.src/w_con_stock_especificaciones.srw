$PBExportHeader$w_con_stock_especificaciones.srw
forward
global type w_con_stock_especificaciones from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_especificaciones
end type
type pb_1 from upb_imprimir within w_con_stock_especificaciones
end type
type dw_listado from datawindow within w_con_stock_especificaciones
end type
type gb_3 from groupbox within w_con_stock_especificaciones
end type
type gb_1 from groupbox within w_con_stock_especificaciones
end type
type gb_2 from groupbox within w_con_stock_especificaciones
end type
type cb_1 from commandbutton within w_con_stock_especificaciones
end type
type cb_2 from commandbutton within w_con_stock_especificaciones
end type
type cb_3 from commandbutton within w_con_stock_especificaciones
end type
type uo_subformato from u_marca_lista within w_con_stock_especificaciones
end type
type cb_4 from commandbutton within w_con_stock_especificaciones
end type
type cb_5 from commandbutton within w_con_stock_especificaciones
end type
type cb_6 from commandbutton within w_con_stock_especificaciones
end type
type uo_formato from u_marca_lista within w_con_stock_especificaciones
end type
type uo_subfamilia from u_marca_lista within w_con_stock_especificaciones
end type
type uo_familia from u_marca_lista within w_con_stock_especificaciones
end type
type cb_7 from commandbutton within w_con_stock_especificaciones
end type
type uo_calidad from u_marca_lista within w_con_stock_especificaciones
end type
type uo_almacen from u_marca_lista within w_con_stock_especificaciones
end type
type dw_1 from u_datawindow_consultas within w_con_stock_especificaciones
end type
type cb_8 from commandbutton within w_con_stock_especificaciones
end type
type uo_cajas from u_marca_lista within w_con_stock_especificaciones
end type
type em_calibre_desde from editmask within w_con_stock_especificaciones
end type
type em_calibre_hasta from editmask within w_con_stock_especificaciones
end type
type cbx_1 from checkbox within w_con_stock_especificaciones
end type
type uo_1 from u_manejo_datawindow within w_con_stock_especificaciones
end type
end forward

global type w_con_stock_especificaciones from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 2953
integer height = 1604
string title = "Consulta de Movimientos"
pb_2 pb_2
pb_1 pb_1
dw_listado dw_listado
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
uo_subformato uo_subformato
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
uo_formato uo_formato
uo_subfamilia uo_subfamilia
uo_familia uo_familia
cb_7 cb_7
uo_calidad uo_calidad
uo_almacen uo_almacen
dw_1 dw_1
cb_8 cb_8
uo_cajas uo_cajas
em_calibre_desde em_calibre_desde
em_calibre_hasta em_calibre_hasta
cbx_1 cbx_1
uo_1 uo_1
end type
global w_con_stock_especificaciones w_con_stock_especificaciones

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string formatos[],familias[]
string subformatos[],subfamilias[],calidades[]
string almacen[],cajas[]
long   i,indice_for,indice_fam,total,donde,indice
long   indice_subfam,indice_subfor,indice_calidad,indice_almacen,indice_cajas
long   calibre_desde,calibre_hasta
string ant_referencia,ant_tipo_pallet,ant_caja

/*for i=1 to 50
	familias[i] = ""
	subfamilias[i] = ""
	subfamilias[i + 50] = ""
	formatos[i] = ""
	subformatos[i] = ""
	subformatos[i + 50] = ""
	calidades[i] = ""
	almacen[i] = ""
	cajas[i] = ""
	cajas[i + 50] = ""
	cajas[i + 100] = ""
	cajas[i + 150] = ""
next*/

indice_almacen = 1
for i=1 to uo_almacen.dw_marca.rowcount()
	if uo_almacen.dw_marca.getitemstring(i,"marca")="S" then
		almacen[indice_almacen] = uo_almacen.dw_marca.getitemstring(i,"codigo")
		indice_almacen ++
	end if	
next

indice_fam = 1
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		familias[indice_fam] = uo_familia.dw_marca.getitemstring(i,"codigo")
		indice_fam ++
	end if	
next

indice_subfam = 1
for i=1 to uo_subfamilia.dw_marca.rowcount()
	if uo_subfamilia.dw_marca.getitemstring(i,"marca")="S" then
		subfamilias[indice_subfam] = uo_subfamilia.dw_marca.object.codigo[i]
		indice_subfam ++
	end if	
next

indice_for = 1
for i=1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		formatos[indice_for] = uo_formato.dw_marca.getitemstring(i,"codigo")
		indice_for ++
	end if
next

indice_subfor = 1
for i=1 to uo_subformato.dw_marca.rowcount()
	if uo_subformato.dw_marca.getitemstring(i,"marca")="S" then
		subformatos[indice_subfor] = uo_subformato.dw_marca.getitemstring(i,"codigo")
		indice_subfor ++
	end if
next

indice_calidad= 1
for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[indice_calidad] = uo_calidad.dw_marca.getitemstring(i,"codigo")
		indice_calidad ++
	end if	
next
indice_cajas = 1
for i=1 to uo_cajas.dw_marca.rowcount()
	if uo_cajas.dw_marca.getitemstring(i,"marca")="S" then
		cajas[indice_cajas] = uo_cajas.dw_marca.getitemstring(i,"codigo")
		indice_cajas ++
	end if	
next
calibre_desde = dec(em_calibre_desde.text)
calibre_hasta = dec(em_calibre_hasta.text)
uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible    = False
uo_almacen.visible    = false
uo_cajas.visible      = false
data.setredraw(false)
data.retrieve(codigo_empresa,familias,subfamilias,formatos,subformatos,calidades,almacen,cajas,calibre_desde,calibre_hasta)
data.sort()
TOTAL = DATA.ROWCOUNT()
string referencia,tipo_pallet,caja,articulo,calidad
dec reservado,fabricar,preparado,stock,ant_stock,total_fabricar
boolean ant_grabado
ant_referencia = ""
ant_tipo_pallet = ""
ant_caja = ""
ant_stock = 0
ant_grabado = false
FOR INDICE = 1 TO TOTAL
	f_mensaje_proceso("Calculando Reservas",indice,total)
	
	stock          = data.object.total[indice]
	referencia     = data.object.almlinubica_referencia[indice]
	articulo       = f_articulo_referencia(referencia)
	calidad        = f_calidad_referencia(referencia)
	tipo_pallet    = data.object.tipo_pallet[indice]
	caja           = data.object.almlinubica_caja[indice]
	reservado      = f_reservado_referencia_tipo_pallet_caja(codigo_empresa,referencia,tipo_pallet,caja)
	fabricar       = f_fabricar_referencia_tipo_pallet_caja(codigo_empresa,referencia,tipo_pallet,caja)
	total_fabricar = f_fabricar_art_cal_tipo_pallet_caja(codigo_empresa,articulo,calidad,tipo_pallet,caja)
	preparado      = f_preparado_referencia_tipo_pallet_caja(codigo_empresa,referencia,tipo_pallet,caja)
	
	if isnull(reservado) then reservado             = 0
	if isnull(preparado) then preparado             = 0
	if isnull(fabricar)  then fabricar              = 0
	if isnull(total_fabricar)  then total_fabricar  = 0
	
	data.object.almlinubica_total_fabricar[indice]  = total_fabricar
	
	if ant_referencia = referencia and ant_tipo_pallet = tipo_pallet and ant_caja = caja then 
		if not ant_grabado then
			data.object.reservado[indice]    = reservado
			data.object.preparado[indice]    = preparado
			data.object.fabricar[indice]     = fabricar
			data.object.reservado[indice -1] = 0
			data.object.fabricar[indice -1]  = 0
			data.object.preparado[indice -1] = 0
			if stock >= (reservado + preparado) then
				ant_grabado = true
			else
				ant_grabado = false
			end if			
		else
			data.object.reservado[indice] = 0
			data.object.fabricar[indice]  = 0
			data.object.preparado[indice] = 0			
		end if
	else
		data.object.reservado[indice]    = reservado
		data.object.preparado[indice]    = preparado
		data.object.fabricar[indice]     = fabricar		
		if stock >= (reservado + preparado) then
			ant_grabado = true
		else
			ant_grabado = false
		end if
	end if
	ant_referencia  = referencia
	ant_tipo_pallet = tipo_pallet
	ant_caja        = caja
	ant_stock       = stock
NEXT

data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = " CONSULTA RESERVAS POR ESPECIFICACIONES "

uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_subfamilia.f_cargar_datos("dw_ayuda_subfamilias","","","Subfamilia","Descripción")
uo_formato.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")
uo_subformato.f_cargar_datos("dw_ayuda_subformatos","","","Subformato","Descripción")
uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")
uo_almacen.f_cargar_datos("dw_ayuda_almacenes","","","Almacen","Descripción")
uo_cajas.f_cargar_datos("dw_ayuda_cajas","","","Caja","Descripción")


end event

on w_con_stock_especificaciones.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.uo_subformato=create uo_subformato
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.uo_formato=create uo_formato
this.uo_subfamilia=create uo_subfamilia
this.uo_familia=create uo_familia
this.cb_7=create cb_7
this.uo_calidad=create uo_calidad
this.uo_almacen=create uo_almacen
this.dw_1=create dw_1
this.cb_8=create cb_8
this.uo_cajas=create uo_cajas
this.em_calibre_desde=create em_calibre_desde
this.em_calibre_hasta=create em_calibre_hasta
this.cbx_1=create cbx_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.uo_subformato
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_5
this.Control[iCurrent+13]=this.cb_6
this.Control[iCurrent+14]=this.uo_formato
this.Control[iCurrent+15]=this.uo_subfamilia
this.Control[iCurrent+16]=this.uo_familia
this.Control[iCurrent+17]=this.cb_7
this.Control[iCurrent+18]=this.uo_calidad
this.Control[iCurrent+19]=this.uo_almacen
this.Control[iCurrent+20]=this.dw_1
this.Control[iCurrent+21]=this.cb_8
this.Control[iCurrent+22]=this.uo_cajas
this.Control[iCurrent+23]=this.em_calibre_desde
this.Control[iCurrent+24]=this.em_calibre_hasta
this.Control[iCurrent+25]=this.cbx_1
this.Control[iCurrent+26]=this.uo_1
end on

on w_con_stock_especificaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.uo_subformato)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.uo_formato)
destroy(this.uo_subfamilia)
destroy(this.uo_familia)
destroy(this.cb_7)
destroy(this.uo_calidad)
destroy(this.uo_almacen)
destroy(this.dw_1)
destroy(this.cb_8)
destroy(this.uo_cajas)
destroy(this.em_calibre_desde)
destroy(this.em_calibre_hasta)
destroy(this.cbx_1)
destroy(this.uo_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.triggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.triggerEvent("linea_arriba")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.triggerEvent("pagina_arriba")

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.triggerEvent("pagina_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_especificaciones
integer taborder = 190
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_especificaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_especificaciones
integer y = 20
integer width = 2587
end type

type pb_2 from upb_salir within w_con_stock_especificaciones
integer x = 2697
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type pb_1 from upb_imprimir within w_con_stock_especificaciones
integer x = 2757
integer y = 164
integer width = 96
integer height = 84
integer taborder = 20
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_stock_especificaciones
boolean visible = false
integer x = 23
integer width = 494
integer height = 236
boolean bringtotop = true
string dataobject = "report_con_stock_especificaciones"
boolean livescroll = true
end type

type gb_3 from groupbox within w_con_stock_especificaciones
integer x = 1801
integer y = 128
integer width = 215
integer height = 136
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calibre"
end type

type gb_1 from groupbox within w_con_stock_especificaciones
integer x = 2016
integer y = 120
integer width = 270
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_stock_especificaciones
integer x = 5
integer y = 120
integer width = 1797
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_stock_especificaciones
integer x = 1083
integer y = 160
integer width = 265
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubForm."
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
uo_calidad.visible 	 = False
uo_almacen.visible    = false
uo_cajas.visible      = false
if uo_subformato.visible = True then
   uo_subformato.visible = False
else
	uo_subformato.visible = True
End if
end event

type cb_2 from commandbutton within w_con_stock_especificaciones
integer x = 2030
integer y = 160
integer width = 119
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;f_control(dw_1)
end event

type cb_3 from commandbutton within w_con_stock_especificaciones
integer x = 553
integer y = 160
integer width = 265
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubFam."
end type

event clicked;uo_familia.visible    = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible 	 = False
uo_almacen.visible    = false
uo_cajas.visible      = false
if uo_subfamilia.visible = True then
   uo_subfamilia.visible = False
else
	uo_subfamilia.visible = True
End if
end event

type uo_subformato from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 1029
integer y = 360
integer taborder = 160
boolean border = false
end type

on uo_subformato.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_con_stock_especificaciones
integer x = 288
integer y = 160
integer width = 265
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible 	 = False
uo_almacen.visible    = false
uo_cajas.visible      = false
if uo_familia.visible = True then
   uo_familia.visible = False
else
	uo_familia.visible = True
End if
end event

type cb_5 from commandbutton within w_con_stock_especificaciones
integer x = 818
integer y = 160
integer width = 265
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_subformato.visible = False
uo_calidad.visible 	 = False
uo_almacen.visible    = false
uo_cajas.visible      = false
if uo_formato.visible = True then
   uo_formato.visible = False
else
	uo_formato.visible = True
End if
end event

type cb_6 from commandbutton within w_con_stock_especificaciones
integer x = 1349
integer y = 160
integer width = 265
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_familia.visible	 = false
uo_almacen.visible    = false
uo_cajas.visible      = false
if uo_calidad.visible = True then
   uo_calidad.visible = False
else
	uo_calidad.visible = True
End if
end event

type uo_formato from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 754
integer y = 360
integer taborder = 90
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

type uo_subfamilia from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 485
integer y = 360
integer taborder = 150
boolean border = false
end type

on uo_subfamilia.destroy
call u_marca_lista::destroy
end on

type uo_familia from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 238
integer y = 360
integer taborder = 130
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type cb_7 from commandbutton within w_con_stock_especificaciones
integer x = 23
integer y = 160
integer width = 265
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Almacen"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible 	 = False
uo_familia.visible    = False
uo_cajas.visible      = false
if uo_almacen.visible = True then
	uo_almacen.visible=false
else
	uo_almacen.visible=true
End if
end event

type uo_calidad from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 1298
integer y = 360
integer taborder = 140
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type uo_almacen from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer y = 360
integer taborder = 180
boolean border = false
end type

on uo_almacen.destroy
call u_marca_lista::destroy
end on

type dw_1 from u_datawindow_consultas within w_con_stock_especificaciones
integer x = 9
integer y = 276
integer width = 2848
integer height = 1124
integer taborder = 200
string dataobject = "dw_con_stock_especificaciones"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_8 from commandbutton within w_con_stock_especificaciones
integer x = 1614
integer y = 160
integer width = 174
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cajas"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_familia.visible	 = false
uo_almacen.visible    = false
uo_calidad.visible    = false
uo_cajas.visible      = not(uo_cajas.visible)

end event

type uo_cajas from u_marca_lista within w_con_stock_especificaciones
event destroy ( )
boolean visible = false
integer x = 1545
integer y = 360
integer taborder = 170
boolean bringtotop = true
boolean border = false
end type

on uo_cajas.destroy
call u_marca_lista::destroy
end on

type em_calibre_desde from editmask within w_con_stock_especificaciones
integer x = 1810
integer y = 176
integer width = 87
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type em_calibre_hasta from editmask within w_con_stock_especificaciones
integer x = 1911
integer y = 176
integer width = 87
integer height = 64
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type cbx_1 from checkbox within w_con_stock_especificaciones
integer x = 2158
integer y = 168
integer width = 105
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "R"
boolean automatic = false
boolean lefttext = true
end type

event clicked;checked=not checked
if not checked then 
	dw_1.modify("Datawindow.header.1.height=18")
	dw_1.Object.Datawindow.detail.height='36'
	dw_listado.Object.Datawindow.detail.height='36'
	dw_listado.modify("Datawindow.header.1.height=18")
else
	dw_1.modify("Datawindow.header.1.height=0")
	dw_1.Object.Datawindow.detail.height='0'
	dw_listado.Object.Datawindow.detail.height='0'
	dw_listado.modify("Datawindow.header.1.height=0")
end if


end event

type uo_1 from u_manejo_datawindow within w_con_stock_especificaciones
integer x = 2277
integer y = 116
end type

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data=dw_1

end event

