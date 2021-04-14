$PBExportHeader$wi_quitar_formato_articulos.srw
forward
global type wi_quitar_formato_articulos from w_int_con_empresa
end type
type dw_listado from datawindow within wi_quitar_formato_articulos
end type
type cb_1 from u_boton within wi_quitar_formato_articulos
end type
type dw_1 from datawindow within wi_quitar_formato_articulos
end type
type pb_1 from upb_salir within wi_quitar_formato_articulos
end type
end forward

global type wi_quitar_formato_articulos from w_int_con_empresa
integer width = 3547
integer height = 1632
dw_listado dw_listado
cb_1 cb_1
dw_1 dw_1
pb_1 pb_1
end type
global wi_quitar_formato_articulos wi_quitar_formato_articulos

on wi_quitar_formato_articulos.create
int iCurrent
call super::create
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_1
end on

on wi_quitar_formato_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Quitar Formato de Descripción de Artículos"
istr_parametros.s_listado        =   "report_articulos1"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)


end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_quitar_formato_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_quitar_formato_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_quitar_formato_articulos
end type

type dw_listado from datawindow within wi_quitar_formato_articulos
boolean visible = false
integer width = 521
integer height = 208
boolean bringtotop = true
string dataobject = "report_articulos1"
boolean livescroll = true
end type

type cb_1 from u_boton within wi_quitar_formato_articulos
integer x = 2295
integer y = 32
integer width = 347
integer height = 116
integer taborder = 20
boolean bringtotop = true
string text = "Quitar"
end type

event clicked;string art_codigo,art_descrip,sel
long   total,i
datastore datos

dw_1.Retrieve(codigo_empresa)


sel = "select * "+&
		"from   articulos "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"order  by codigo"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for i = 1 to total
	art_codigo  = datos.object.codigo[i]
	art_descrip = f_nuevo_nombre_articulo(codigo_empresa,art_codigo)
	update articulos
	set descripcion = :art_descrip, cuenta = :art_descrip
	where codigo = :art_codigo;
	commit;
next

destroy datos
end event

type dw_1 from datawindow within wi_quitar_formato_articulos
integer x = 32
integer y = 164
integer width = 3415
integer height = 1236
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_quitar_formato_articulos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from upb_salir within wi_quitar_formato_articulos
integer x = 2706
integer y = 28
integer height = 116
integer taborder = 0
boolean bringtotop = true
end type

