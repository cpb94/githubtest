$PBExportHeader$w_con_stock_nueva.srw
forward
global type w_con_stock_nueva from w_int_con_empresa
end type
type gb_2 from groupbox within w_con_stock_nueva
end type
type pb_2 from upb_salir within w_con_stock_nueva
end type
type dw_listado from datawindow within w_con_stock_nueva
end type
type cb_1 from commandbutton within w_con_stock_nueva
end type
type cb_2 from commandbutton within w_con_stock_nueva
end type
type uo_formato from u_marca_lista within w_con_stock_nueva
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_nueva
end type
type dw_consulta from datawindow within w_con_stock_nueva
end type
type uo_1 from u_manejo_datawindow within w_con_stock_nueva
end type
type cb_3 from commandbutton within w_con_stock_nueva
end type
type uo_familia from u_marca_lista within w_con_stock_nueva
end type
end forward

global type w_con_stock_nueva from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1640
string title = "Consulta de Movimientos"
gb_2 gb_2
pb_2 pb_2
dw_listado dw_listado
cb_1 cb_1
cb_2 cb_2
uo_formato uo_formato
pb_imprimir_preli pb_imprimir_preli
dw_consulta dw_consulta
uo_1 uo_1
cb_3 cb_3
uo_familia uo_familia
end type
global w_con_stock_nueva w_con_stock_nueva

type variables
String ante_articulo,retrasos
int como
end variables

forward prototypes
public subroutine f_totales (string tipo, long donde)
public function string f_filtro2 ()
public function decimal f_cantidad_articulo_pedidos_situacion (string empresa, string articulo, string caja, string situacion)
public function decimal f_stock_articulo (string empresa, string articulo, string caja)
end prototypes

public subroutine f_totales (string tipo, long donde);//dec{2} reservado,preparado,fabricar
//string referencia,tipo_pallet
//if tipo="S" then
//  referencia = dw_consulta.getitemstring(donde,"referencia")
//  tipo_pallet= dw_consulta.getitemstring(donde,"tipo_pallet") 
//  reservado  = f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  preparado  = f_preparado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  fabricar   = f_fabricar_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//else
//  reservado  = 0
//  preparado  = 0
//  fabricar   = 0
//end if
//	
//  dw_consulta.SetItem(donde,"reservado",reservado)
//  dw_consulta.SetItem(donde,"preparado",preparado)
//  dw_consulta.SetItem(donde,"fabricar",fabricar)
end subroutine

public function string f_filtro2 ();string filtro
//if rb_1.checked then
//	filtro="(disponible >= "+string(dec(em_cuanto.text),"##############0")+")"
//else
//	filtro="(disponible < "+string(dec(em_cuanto.text),"##############0")+")"
//end if
return filtro
end function

public function decimal f_cantidad_articulo_pedidos_situacion (string empresa, string articulo, string caja, string situacion);dec resultado

select sum(cantidad)
into   :resultado
from   venliped 
where  empresa   = :empresa
and    articulo  = :articulo
and    caja      = :caja
and    situacion = :situacion;

if isnull(resultado) then resultado = 0

return resultado
end function

public function decimal f_stock_articulo (string empresa, string articulo, string caja);dec resultado

select sum(existencias)
into   :resultado
from   almlinubica 
where   empresa = :empresa
and    articulo = :articulo
and        caja = :caja;


if isnull(resultado) then resultado = 0

return resultado
end function

event open;call super::open;dw_consulta.SetTransObject(sqlca)
//dw_listado.SetTransObject(sqlca)
dw_consulta.Sharedata(dw_listado)
This.title = " CONSULTA STOCK POR FAMILIAS Y FORMATOS"

uo_formato.f_cargar_datos("dw_ayuda_formatos","","","formato","Descripción")
uo_familia.f_cargar_datos("dw_ayuda_familias","","","familia","Descripción")





end event

on w_con_stock_nueva.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_formato=create uo_formato
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_consulta=create dw_consulta
this.uo_1=create uo_1
this.cb_3=create cb_3
this.uo_familia=create uo_familia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_formato
this.Control[iCurrent+7]=this.pb_imprimir_preli
this.Control[iCurrent+8]=this.dw_consulta
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.uo_familia
end on

on w_con_stock_nueva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_formato)
destroy(this.pb_imprimir_preli)
destroy(this.dw_consulta)
destroy(this.uo_1)
destroy(this.cb_3)
destroy(this.uo_familia)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_nueva
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_nueva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_nueva
integer y = 20
integer width = 2377
end type

type gb_2 from groupbox within w_con_stock_nueva
integer x = 1189
integer y = 128
integer width = 1083
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_stock_nueva
integer x = 2729
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado from datawindow within w_con_stock_nueva
boolean visible = false
integer x = 133
integer width = 494
integer height = 156
boolean bringtotop = true
string dataobject = "report_con_stock_formatos_nueva"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_stock_nueva
integer x = 1554
integer y = 168
integer width = 352
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;uo_familia.visible = False
if uo_formato.visible = True then
   uo_formato.visible = False
else
	uo_formato.visible = True
End if
end event

type cb_2 from commandbutton within w_con_stock_nueva
event clicked pbm_bnclicked
integer x = 1906
integer y = 168
integer width = 352
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string formatos[1 to 50],familias[1 to 50],tipounidad
long   i,indice_for,indice_fam,total,donde,indice
string articulo,caja,nombre_familias
dec{2} reservado,preparado,fabricar,stock,pedidos

for i=1 to 50
	formatos[i]=""
	familias[i]=""
next
indice_for = 1
for i=1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		formatos[indice_for] = uo_formato.dw_marca.getitemstring(i,"codigo")
		indice_for ++
	end if
next
indice_fam = 1
nombre_familias = ""
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		familias[indice_fam] = uo_familia.dw_marca.getitemstring(i,"codigo")
		indice_fam ++
		if nombre_familias = "" then
			nombre_familias = f_nombre_familia(codigo_empresa,familias[indice_fam -1])
		else
			nombre_familias = nombre_familias+","+f_nombre_familia(codigo_empresa,familias[indice_fam -1])
		end if
	end if	
next
if (indice_fam -1) = uo_familia.dw_marca.rowcount() then
	nombre_familias = "De todas las familias"
end if
uo_formato.visible = false
uo_familia.visible = false
dw_consulta.reset()
dw_consulta.setfilter("")
dw_consulta.SetRedraw(FALSE)

f_mensaje_proceso("Espere Por Favor ",0,100)
dw_consulta.retrieve(codigo_empresa,formatos,familias,nombre_familias)
dw_listado.retrieve(codigo_empresa,formatos,familias,nombre_familias)
total = dw_consulta.rowcount()
for indice = 1 to total
	articulo   = dw_consulta.object.codigo[indice]
	caja       = dw_consulta.object.almartcajas_caja[indice]
	stock      = f_stock_articulo(codigo_empresa,articulo,caja)
	if stock < 0 then stock = 0	
	reservado  = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,caja,"C")
	preparado  = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,caja,"P")
	fabricar   = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,caja,"F")
	
	pedidos = reservado + preparado + fabricar
	
	dw_consulta.object.reservado[indice] = reservado
	dw_consulta.object.preparado[indice] = preparado

	fabricar = stock - pedidos
	if fabricar < 0 then
		fabricar = fabricar * -1
	else
		fabricar = 0
	end if
	dw_consulta.object.total[indice]    = stock
	dw_consulta.object.fabricar[indice] = fabricar
	dw_consulta.object.pedidos[indice]  = pedidos
	dw_consulta.object.articulos_nombre_familias[indice] = nombre_familias
next
dw_consulta.setfilter("(reservado <> 0) or (preparado <> 0) or (total <> 0) or (fabricar <> 0) or (pedidos <> 0)")
dw_consulta.filter()
dw_consulta.sort()
dw_consulta.groupcalc()
dw_consulta.SetRedraw(TRUE)


f_mensaje_proceso("Espere Por Favor ",100,100)

end event

type uo_formato from u_marca_lista within w_con_stock_nueva
event destroy ( )
boolean visible = false
integer x = 1531
integer y = 268
boolean bringtotop = true
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

type pb_imprimir_preli from upb_imprimir within w_con_stock_nueva
integer x = 2743
integer y = 172
integer width = 101
integer height = 84
integer taborder = 10
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;//string formatos[1 to 50],tipounidad
//long i,indice,total,donde
//string articulo
//dec{2} reservado,preparado,fabricar,stock,pedidos
//
//for i=1 to 50
//	formatos[i]=""
//next
//indice = 1
//for i=1 to uo_formato.dw_marca.rowcount()
//	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
//		formatos[indice]=uo_formato.dw_marca.getitemstring(i,"codigo")
//		indice ++
//	end if
//next
//uo_formato.visible=false
//dw_listado.reset()
//dw_listado.setfilter("")
//dw_listado.SetRedraw(FALSE)
//
//f_mensaje_proceso("Espere Por Favor ",0,100)
//dw_listado.retrieve(codigo_empresa,formatos)
//total = dw_listado.rowcount()
//for indice = 1 to total
//	articulo   = dw_listado.object.codigo[indice]
//	stock      = f_stock_articulo(codigo_empresa,articulo)
//	if stock < 0 then stock = 0	
//	reservado  = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,"C")
//	preparado  = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,"P")
//	fabricar   = f_cantidad_articulo_pedidos_situacion(codigo_empresa,articulo,"F")
//	
//	pedidos = reservado + preparado + fabricar
//	
//	dw_listado.SetItem(indice,"reservado",reservado)
//	dw_listado.SetItem(indice,"preparado",preparado)
//	
//	fabricar = stock - pedidos
//	if fabricar < 0 then
//		fabricar = fabricar * -1
//	else
//		fabricar = 0
//	end if
//	dw_listado.SetItem(indice,"total",stock)
//	dw_listado.SetItem(indice,"fabricar",fabricar)
//	dw_listado.SetItem(indice,"pedidos",pedidos)
//next
//dw_listado.setfilter("(reservado <> 0) or (preparado <> 0) or (total <> 0) or (fabricar <> 0) or (pedidos <> 0)")
//dw_listado.filter()
//dw_listado.sort()
//dw_listado.groupcalc()
//dw_listado.SetRedraw(TRUE)
//
//
//f_mensaje_proceso("Espere Por Favor ",100,100)
if dw_consulta.rowcount() > 0 then
	f_imprimir_datawindow(dw_listado)
else
	messagebox("Atención","Consulta sin datos")
end if

end event

type dw_consulta from datawindow within w_con_stock_nueva
integer y = 276
integer width = 2880
integer height = 1148
string dataobject = "dw_con_stock_formatos_nueva"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_1 from u_manejo_datawindow within w_con_stock_nueva
integer x = 2267
integer y = 124
integer width = 617
integer height = 168
end type

event valores;call super::valores;dw_data = dw_consulta
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_3 from commandbutton within w_con_stock_nueva
integer x = 1202
integer y = 168
integer width = 352
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_formato.visible = False
if uo_familia.visible = True then
   uo_familia.visible = False
else
	uo_familia.visible = True
End if
end event

type uo_familia from u_marca_lista within w_con_stock_nueva
event destroy ( )
boolean visible = false
integer x = 183
integer y = 268
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

