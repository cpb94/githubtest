$PBExportHeader$w_con_stock_mp_producto.srw
forward
global type w_con_stock_mp_producto from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_mp_producto
end type
type dw_1 from datawindow within w_con_stock_mp_producto
end type
type cb_1 from commandbutton within w_con_stock_mp_producto
end type
type pb_imprimir from upb_imprimir within w_con_stock_mp_producto
end type
type dw_listado from datawindow within w_con_stock_mp_producto
end type
type gb_4 from groupbox within w_con_stock_mp_producto
end type
type gb_3 from groupbox within w_con_stock_mp_producto
end type
type gb_2 from groupbox within w_con_stock_mp_producto
end type
type gb_1 from groupbox within w_con_stock_mp_producto
end type
type cbx_valorado from checkbox within w_con_stock_mp_producto
end type
type uo_productos from u_marca_lista within w_con_stock_mp_producto
end type
type cb_2 from commandbutton within w_con_stock_mp_producto
end type
end forward

global type w_con_stock_mp_producto from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2907
integer height = 1612
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
dw_1 dw_1
cb_1 cb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
cbx_valorado cbx_valorado
uo_productos uo_productos
cb_2 cb_2
end type
global w_con_stock_mp_producto w_con_stock_mp_producto

type variables
boolean detalle = false
string ante_articulo
end variables

forward prototypes
public subroutine f_actualiza_precios ()
end prototypes

public subroutine f_actualiza_precios ();long    indice,total,lineas_precios
string  mp,sel
dec     precio
boolean bien = true

datastore almacen

sel = "select distinct(mp) mp from comlinubica "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and (precio = 0 or precio is null)"
		
//almacen = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, almacen)

total = almacen.rowcount()

if total > 0 then
	for indice = 1 to total
		f_mensaje_proceso("Actualizando Precios:",indice,total)
		mp = almacen.object.mp[indice]
		lineas_precios = 0
		
		select count(*)
		into   :lineas_precios
		from   comartpro
		where  empresa = :codigo_empresa
		and    mprima  = :mp;
		
		if isnull(lineas_precios) then lineas_precios = 0
		if lineas_precios = 1 then
			select precio
			into   :precio
			from   comartpro
			where  empresa = :codigo_empresa
			and    mprima  = :mp;
			
			if isnull(precio) then precio = 0
			
			update comlinubica
			set    precio  = :precio
			where  empresa = :codigo_empresa
			and    mp      = :mp
			and    (precio = 0 or precio is null);

			if sqlca.sqlcode <> 0 then
				bien = false
			end if
		end if
	next
	if bien then
		commit;
	else
		rollback;
		messagebox("Error","La operacion no se actualiza")
	end if	
end if

destroy almacen
end subroutine

event open;call super::open;
This.title = " CONSULTA STOCKS DE MATERIAS PRIMAS POR PRODUCTOS"
istr_parametros = Message.PowerObjectParm

f_actualiza_precios()

uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")
end event

on w_con_stock_mp_producto.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cbx_valorado=create cbx_valorado
this.uo_productos=create uo_productos
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cbx_valorado
this.Control[iCurrent+11]=this.uo_productos
this.Control[iCurrent+12]=this.cb_2
end on

on w_con_stock_mp_producto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cbx_valorado)
destroy(this.uo_productos)
destroy(this.cb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_mp_producto
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_mp_producto
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_mp_producto
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_stock_mp_producto
integer x = 2747
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
end type

type dw_1 from datawindow within w_con_stock_mp_producto
integer y = 272
integer width = 2857
integer height = 1136
boolean bringtotop = true
string dataobject = "dw_con_stock_mp_producto"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if detalle then
	this.modify("datawindow.detail.height = 0")
	dw_listado.modify("datawindow.detail.height = 0")
else	
	this.modify("datawindow.detail.height = 68")
	dw_listado.modify("datawindow.detail.height = 68")
end if
detalle = not(detalle)
end event

type cb_1 from commandbutton within w_con_stock_mp_producto
integer x = 1262
integer y = 140
integer width = 411
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string var_producto[]
long   indice,indice_array

uo_productos.visible = false

if cbx_valorado.checked then
	dw_1.dataobject = "dw_con_stock_mp_producto_valorado"
else
	dw_1.dataobject = "dw_con_stock_mp_producto"
end if

dw_1.SetTransObject(sqlca)

indice_array = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		indice_array ++		
		var_producto[indice_array] = uo_productos.dw_marca.getitemstring(indice,"codigo")
	end if
next

if indice_array > 0 then
	dw_1.retrieve(codigo_empresa,var_producto)
end if
end event

type pb_imprimir from upb_imprimir within w_con_stock_mp_producto
integer x = 2715
integer y = 140
integer width = 133
integer height = 108
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;string var_producto[]
long   indice,indice_array

uo_productos.visible = false

if cbx_valorado.checked then
	dw_listado.dataobject = "report_con_stock_mp_producto_valorado"
else
	dw_listado.dataobject = "report_con_stock_mp_producto"
end if

dw_listado.SetTransObject(sqlca)

indice_array = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		indice_array ++		
		var_producto[indice_array] = uo_productos.dw_marca.getitemstring(indice,"codigo")
	end if
next

if indice_array > 0 then
	dw_listado.retrieve(codigo_empresa,var_producto)
	f_imprimir_datawindow(dw_listado)
end if

end event

type dw_listado from datawindow within w_con_stock_mp_producto
boolean visible = false
integer x = 1874
integer y = 12
integer width = 686
integer height = 420
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_con_stock_mp_producto"
boolean livescroll = true
end type

type gb_4 from groupbox within w_con_stock_mp_producto
integer x = 453
integer y = 100
integer width = 626
integer height = 156
integer taborder = 60
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

type gb_3 from groupbox within w_con_stock_mp_producto
integer x = 2706
integer y = 100
integer width = 151
integer height = 156
integer taborder = 50
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

type gb_2 from groupbox within w_con_stock_mp_producto
integer x = 1253
integer y = 100
integer width = 430
integer height = 156
integer taborder = 40
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

type gb_1 from groupbox within w_con_stock_mp_producto
integer x = 23
integer y = 100
integer width = 430
integer height = 156
integer taborder = 60
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

type cbx_valorado from checkbox within w_con_stock_mp_producto
integer x = 475
integer y = 156
integer width = 576
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Listado Valorado"
end type

type uo_productos from u_marca_lista within w_con_stock_mp_producto
event destroy ( )
boolean visible = false
integer x = 27
integer y = 268
integer width = 1362
integer height = 668
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type cb_2 from commandbutton within w_con_stock_mp_producto
integer x = 32
integer y = 140
integer width = 411
integer height = 108
integer taborder = 70
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

