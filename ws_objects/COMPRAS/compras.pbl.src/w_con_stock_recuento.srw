$PBExportHeader$w_con_stock_recuento.srw
forward
global type w_con_stock_recuento from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_recuento
end type
type dw_1 from u_datawindow_consultas within w_con_stock_recuento
end type
type em_fechadesde from u_em_campo within w_con_stock_recuento
end type
type st_7 from statictext within w_con_stock_recuento
end type
type cb_2 from commandbutton within w_con_stock_recuento
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_recuento
end type
type uo_productos from u_marca_lista within w_con_stock_recuento
end type
type cb_3 from commandbutton within w_con_stock_recuento
end type
type cbx_control_almacen from checkbox within w_con_stock_recuento
end type
type gb_1 from groupbox within w_con_stock_recuento
end type
end forward

global type w_con_stock_recuento from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2871
integer height = 2212
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
uo_productos uo_productos
cb_3 cb_3
cbx_control_almacen cbx_control_almacen
gb_1 gb_1
end type
global w_con_stock_recuento w_con_stock_recuento

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);datetime fecha_stock
string  filtro, control_almacen
long   indice, filtro_productos, productos_selecionados
string productos[]

fecha_stock = DateTime(Date(em_fechadesde.text))

data.object.t_fecha.text = string(fecha_stock, 'dd-mm-yyy')

productos_selecionados = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
			productos[indice] = uo_productos.dw_marca.getitemstring(indice,"codigo")
			productos_selecionados ++
	end if
next

if productos_selecionados > 0 then
	data.Reset()
	data.SetRedraw(FALSE)
	
	if cbx_control_almacen.checked then
		control_almacen = 'S'
	else 
		control_almacen = '%'
	end if
	

	data.SetFilter("venmprima_control_almacen like '"+control_almacen+"'")
	data.filter ()
	
	data.Retrieve(codigo_empresa,fecha_stock, productos )
	data.SetRedraw(TRUE)
else
	messagebox("Aviso","Seleccione, al menos, un tipo de producto")
end if




end subroutine

event open;call super::open;This.title = " CONSULTA STOCK DE MATERIAS PRIMAS "

dw_1.SetTransObject(sqlca)

em_fechadesde.text = String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")
end event

on w_con_stock_recuento.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_productos=create uo_productos
this.cb_3=create cb_3
this.cbx_control_almacen=create cbx_control_almacen
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.uo_productos
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cbx_control_almacen
this.Control[iCurrent+10]=this.gb_1
end on

on w_con_stock_recuento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_productos)
destroy(this.cb_3)
destroy(this.cbx_control_almacen)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_recuento
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_recuento
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_recuento
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_stock_recuento
integer x = 2642
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_stock_recuento
integer x = 96
integer y = 236
integer width = 2693
integer height = 1748
integer taborder = 70
string dataobject = "dw_con_stock_recuento"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type em_fechadesde from u_em_campo within w_con_stock_recuento
integer x = 1083
integer y = 140
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_recuento
integer x = 626
integer y = 144
integer width = 448
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock a Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_recuento
event clicked pbm_bnclicked
integer x = 2281
integer y = 128
integer width = 361
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_cargar(dw_1)

end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_recuento
event clicked pbm_bnclicked
integer x = 2642
integer y = 128
integer taborder = 10
boolean originalsize = false
end type

event clicked;f_cargar(dw_1)
f_imprimir_datawindow(dw_1)

	


end event

type uo_productos from u_marca_lista within w_con_stock_recuento
event destroy ( )
boolean visible = false
integer x = 160
integer y = 244
integer width = 1349
integer height = 656
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type cb_3 from commandbutton within w_con_stock_recuento
integer x = 169
integer y = 124
integer width = 411
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos"
end type

event clicked;uo_productos.visible = not(uo_productos.visible)

end event

type cbx_control_almacen from checkbox within w_con_stock_recuento
integer x = 1467
integer y = 144
integer width = 759
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Sólo con Control Almacén"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_stock_recuento
integer x = 160
integer y = 84
integer width = 430
integer height = 156
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

