$PBExportHeader$w_con_pedidos_fabricar.srw
forward
global type w_con_pedidos_fabricar from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_fabricar
end type
type pb_2 from upb_imprimir within w_con_pedidos_fabricar
end type
type dw_listado from datawindow within w_con_pedidos_fabricar
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar
end type
type cb_1 from commandbutton within w_con_pedidos_fabricar
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_fabricar
end type
type gb_2 from groupbox within w_con_pedidos_fabricar
end type
type uo_articulo from u_em_campo_2 within w_con_pedidos_fabricar
end type
type gb_1 from groupbox within w_con_pedidos_fabricar
end type
type uo_familia from u_marca_lista within w_con_pedidos_fabricar
end type
type cb_4 from commandbutton within w_con_pedidos_fabricar
end type
type dw_detalle from datawindow within w_con_pedidos_fabricar
end type
end forward

global type w_con_pedidos_fabricar from w_int_con_empresa
integer width = 2921
integer height = 1656
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
uo_manejo uo_manejo
cb_1 cb_1
uo_cliente uo_cliente
gb_2 gb_2
uo_articulo uo_articulo
gb_1 gb_1
uo_familia uo_familia
cb_4 cb_4
dw_detalle dw_detalle
end type
global w_con_pedidos_fabricar w_con_pedidos_fabricar

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);data.Reset()
string cliente,articulo,familias[]
long   indice_fam,i

uo_familia.visible = false

if uo_articulo.em_campo.text="" then
	articulo="%"	
else
	articulo=uo_articulo.em_codigo.text
end if

if uo_cliente.em_campo.text="" then
	cliente="%"
else
	cliente=uo_cliente.em_codigo.text
end if
indice_fam = 1
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		familias[indice_fam] = uo_familia.dw_marca.getitemstring(i,"codigo")
		indice_fam ++
	end if	
next
data.Retrieve(codigo_empresa,cliente,articulo,familias)

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido a Fabricar"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
end event

on w_con_pedidos_fabricar.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.uo_articulo=create uo_articulo
this.gb_1=create gb_1
this.uo_familia=create uo_familia
this.cb_4=create cb_4
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.uo_articulo
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_familia
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.dw_detalle
end on

on w_con_pedidos_fabricar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.uo_articulo)
destroy(this.gb_1)
destroy(this.uo_familia)
destroy(this.cb_4)
destroy(this.dw_detalle)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_fabricar
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_fabricar
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_fabricar
integer x = 41
integer width = 2427
end type

type pb_1 from upb_salir within w_con_pedidos_fabricar
integer x = 2720
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_fabricar
integer x = 2720
integer y = 136
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;dw_listado.visible =True
f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
dw_listado.visible =False

end event

type dw_listado from datawindow within w_con_pedidos_fabricar
boolean visible = false
integer x = 23
integer y = 16
integer width = 41
integer height = 40
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_con_pedidos_fabricar"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_fabricar
integer x = 2240
integer y = 92
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_pedidos_fabricar
integer x = 2039
integer y = 128
integer width = 206
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 OK"
end type

event clicked; f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_pedidos_fabricar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 23
integer y = 144
integer width = 841
integer height = 72
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_pedidos_fabricar
integer x = 5
integer y = 100
integer width = 882
integer height = 136
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type uo_articulo from u_em_campo_2 within w_con_pedidos_fabricar
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 905
integer y = 144
integer width = 841
integer height = 76
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF

end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_con_pedidos_fabricar
integer x = 887
integer y = 100
integer width = 882
integer height = 136
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Artículo"
end type

type uo_familia from u_marca_lista within w_con_pedidos_fabricar
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
integer taborder = 60
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_con_pedidos_fabricar
integer x = 1774
integer y = 128
integer width = 265
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_familia.visible = not(uo_familia.visible)

end event

type dw_detalle from datawindow within w_con_pedidos_fabricar
integer x = 5
integer y = 244
integer width = 2834
integer height = 1168
string dataobject = "dw_con_pedidos_fabricar"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

