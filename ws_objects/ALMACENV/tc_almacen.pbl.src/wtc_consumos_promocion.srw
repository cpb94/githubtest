$PBExportHeader$wtc_consumos_promocion.srw
forward
global type wtc_consumos_promocion from wt_padre_vacio
end type
type dw_detalle from datawindow within wtc_consumos_promocion
end type
type cb_1 from commandbutton within wtc_consumos_promocion
end type
type cbx_roturas from checkbox within wtc_consumos_promocion
end type
type cbx_ocultar_sin_consumo from checkbox within wtc_consumos_promocion
end type
type cbx_ocultar_detalle from checkbox within wtc_consumos_promocion
end type
type cb_2 from commandbutton within wtc_consumos_promocion
end type
type cb_3 from commandbutton within wtc_consumos_promocion
end type
end forward

global type wtc_consumos_promocion from wt_padre_vacio
integer width = 5001
integer height = 3760
dw_detalle dw_detalle
cb_1 cb_1
cbx_roturas cbx_roturas
cbx_ocultar_sin_consumo cbx_ocultar_sin_consumo
cbx_ocultar_detalle cbx_ocultar_detalle
cb_2 cb_2
cb_3 cb_3
end type
global wtc_consumos_promocion wtc_consumos_promocion

on wtc_consumos_promocion.create
int iCurrent
call super::create
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.cbx_roturas=create cbx_roturas
this.cbx_ocultar_sin_consumo=create cbx_ocultar_sin_consumo
this.cbx_ocultar_detalle=create cbx_ocultar_detalle
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cbx_roturas
this.Control[iCurrent+4]=this.cbx_ocultar_sin_consumo
this.Control[iCurrent+5]=this.cbx_ocultar_detalle
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
end on

on wtc_consumos_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.cbx_roturas)
destroy(this.cbx_ocultar_sin_consumo)
destroy(this.cbx_ocultar_detalle)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;dw_detalle.SetTransObject(SQLCA)
end event

type pb_salir from wt_padre_vacio`pb_salir within wtc_consumos_promocion
integer x = 4773
boolean originalsize = true
end type

type st_titulo from wt_padre_vacio`st_titulo within wtc_consumos_promocion
integer x = 32
end type

type p_logo from wt_padre_vacio`p_logo within wtc_consumos_promocion
integer x = 4402
end type

type dw_detalle from datawindow within wtc_consumos_promocion
integer x = 59
integer y = 264
integer width = 4873
integer height = 3284
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_consumos_promocion"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within wtc_consumos_promocion
integer x = 4352
integer y = 120
integer width = 402
integer height = 124
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;f_imprimir_datawindow(dw_detalle)
end event

type cbx_roturas from checkbox within wtc_consumos_promocion
integer x = 2962
integer y = 128
integer width = 526
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo Roturas"
end type

event clicked;
String filtro

if cbx_ocultar_sin_consumo.checked then
	filtro = " consumo_365 > 0 "
else 
	filtro = " 1 = 1 "
end if

if cbx_roturas.checked then
	filtro = filtro +" and total_dias < 90 "
end if

dw_detalle.SetFilter(filtro)
dw_detalle.Filter()


dw_detalle.setsort(" descripcion ASC, articulo ASC, articulo2 ASC")
dw_detalle.sort()
dw_detalle.GroupCalc()

end event

type cbx_ocultar_sin_consumo from checkbox within wtc_consumos_promocion
integer x = 2103
integer y = 132
integer width = 681
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar sin Consumo"
end type

event clicked;
String filtro

if cbx_ocultar_sin_consumo.checked then
	filtro = " consumo_365 > 0 "
else 
	filtro = " 1 = 1 "
end if

if cbx_roturas.checked then
	filtro = filtro +" and total_dias < 90 "
end if

dw_detalle.SetFilter(filtro)
dw_detalle.Filter()

dw_detalle.setsort(" descripcion ASC, articulo ASC, articulo2 ASC")
dw_detalle.sort()
dw_detalle.GroupCalc()

end event

type cbx_ocultar_detalle from checkbox within wtc_consumos_promocion
integer x = 1358
integer y = 136
integer width = 681
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar Detalle"
end type

event clicked;
if cbx_ocultar_detalle.checked then
	dw_detalle.Modify("DataWindow.Header.2.Height=0")
else 
	dw_detalle.Modify("DataWindow.Header.2.Height=64")
end if


end event

type cb_2 from commandbutton within wtc_consumos_promocion
integer x = 3936
integer y = 120
integer width = 402
integer height = 124
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string cod_articulo, des_articulo, art_descripcion_estr
string sel
datastore articulos
long i, total_articulos, m, k, fila
string uso, codigo_compras
str_escandallo vector_escandallo[300]
integer  indice , nivel, factor_acumulado
dec cantidad_30, cantidad_90, cantidad_365, stock, pedidos, stock_actual
String fecha_30, fecha_90, fecha_365, des_articulo2
String filtro

dw_detalle.Reset()

sel = " select codigo,  descripcion "+&
		" from articulos "+&
		" where articulos.empresa = '1' "+&
		" and articulos.uso = '3' "+&
		" and articulos.promocion = 'S' "+&
		" and articulos.fecha_anulado is null "			
//		+&
//		" and articulos.codigo = '107760' "
		
		
f_cargar_cursor_transaccion (SQLCA, articulos, sel)		

total_articulos = articulos.rowcount()


for i = 1 to total_articulos
	cod_articulo = articulos.object.codigo[i]
	des_articulo2 = articulos.object.descripcion[i]
	// Consumos del articulo analizado
	cantidad_30 = 0
	fecha_30 = string(relativeDate (today(), -30))
	select isnull(sum(cantidads) , 0 )
	into :cantidad_30
	from almacenmovimientos
	where articulo =  :cod_articulo
	and ( tipomov = '100' or tipomov = '206')
	and fecha_mov >= :fecha_30;

	cantidad_90 = 0
	fecha_90 = string(relativeDate (today(), -90))
	select isnull(sum(cantidads) , 0 )
	into :cantidad_90
	from almacenmovimientos
	where articulo =  :cod_articulo
	and ( tipomov = '100' or tipomov = '206')
	and fecha_mov >= :fecha_90;
	
	cantidad_365 = 0
	fecha_365 = string(relativeDate (today(), -365))
	select isnull(sum(cantidads) , 0 )
	into :cantidad_365
	from almacenmovimientos
	where articulo =  :cod_articulo
	and ( tipomov = '100' or tipomov = '206')
	and fecha_mov >= :fecha_365;
	
	pedidos = 0
	select isnull(sum(cantidad) , 0 )
	into :pedidos
	from venliped
	where empresa = :codigo_empresa
	and articulo =  :cod_articulo;
	
	select isnull(sum(cantidade - cantidads) , 0 )
	into :stock
	from almacenmovimientos
	where empresa = :codigo_empresa
	and articulo =  :cod_articulo;
	

	for m = 1 to 300
			setnull(vector_Escandallo[m].articulo)
			setnull(vector_Escandallo[m].version)
			setnull(vector_Escandallo[m].factor)
	next
	indice = 1
	factor_acumulado = 1
		
	f_escandallo_factores_con_sin_base(vector_Escandallo, cod_articulo, indice, factor_Acumulado, nivel, false)		
	for k=1 to indice -1
		select uso, isnull(codigo_compras, ''), descripcion
		into :uso, :codigo_compras, :art_descripcion_estr
		from articulos
		where codigo = :vector_Escandallo[k].articulo; 
		
		if uso = '3' and codigo_compras <> '' then
//			cantidad_30 = cantidad_30 * vector_Escandallo[k].factor
//			cantidad_90 = cantidad_90 * vector_Escandallo[k].factor
//			cantidad_365 = cantidad_365 * vector_Escandallo[k].factor
			
			select isnull(sum(cantidade - cantidads) , 0 )
			into :stock_actual
			from almacenmovimientos
			where empresa = :codigo_empresa
			and articulo =  :vector_Escandallo[k].articulo;
			

			fila = dw_detalle.insertrow(0)
			dw_detalle.object.articulo[fila] =vector_Escandallo[k].articulo
			dw_detalle.object.descripcion[fila] = art_descripcion_estr
			dw_detalle.object.articulo2[fila] = cod_articulo
			dw_detalle.object.descripcion2[fila] = des_articulo2
			dw_detalle.object.consumo_30[fila] = cantidad_30 * vector_Escandallo[k].factor
			dw_detalle.object.consumo_90[fila] = cantidad_90 * vector_Escandallo[k].factor
			dw_detalle.object.consumo_365[fila] = cantidad_365 * vector_Escandallo[k].factor
			dw_detalle.object.stock_actual[fila] = stock_actual
			dw_detalle.object.pedidos[fila] = pedidos
			dw_detalle.object.stock[fila] = stock

		end if
	next
	cantidad_30 = 0
	cantidad_90 = 0
	cantidad_365 = 0
	pedidos = 0
	
	f_mensaje_proceso ("Regs:", i ,total_articulos)
next

dw_detalle.setsort(" descripcion ASC, articulo ASC, articulo2 ASC")
dw_detalle.sort()
dw_detalle.GroupCalc()


destroy(articulos)
end event

type cb_3 from commandbutton within wtc_consumos_promocion
integer x = 3497
integer y = 124
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "MRP"
end type

event clicked;decimal necesidad = 0, necesidad_total = 0
f_recorrido_inverso( '2283', '1', necesidad)//, necesidad_total)
end event

