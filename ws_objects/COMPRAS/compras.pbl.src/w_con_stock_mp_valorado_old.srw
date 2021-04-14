$PBExportHeader$w_con_stock_mp_valorado_old.srw
forward
global type w_con_stock_mp_valorado_old from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_mp_valorado_old
end type
type em_fechadesde from u_em_campo within w_con_stock_mp_valorado_old
end type
type st_7 from statictext within w_con_stock_mp_valorado_old
end type
type cb_2 from commandbutton within w_con_stock_mp_valorado_old
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_mp_valorado_old
end type
type dw_listado from datawindow within w_con_stock_mp_valorado_old
end type
type uo_productos from u_marca_lista within w_con_stock_mp_valorado_old
end type
type cb_3 from commandbutton within w_con_stock_mp_valorado_old
end type
type gb_1 from groupbox within w_con_stock_mp_valorado_old
end type
type cbx_valor from checkbox within w_con_stock_mp_valorado_old
end type
type cb_familias from commandbutton within w_con_stock_mp_valorado_old
end type
type uo_familias from u_marca_lista within w_con_stock_mp_valorado_old
end type
type gb_4 from groupbox within w_con_stock_mp_valorado_old
end type
type dw_1 from u_datawindow_consultas within w_con_stock_mp_valorado_old
end type
end forward

global type w_con_stock_mp_valorado_old from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 3436
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_productos uo_productos
cb_3 cb_3
gb_1 gb_1
cbx_valor cbx_valor
cb_familias cb_familias
uo_familias uo_familias
gb_4 gb_4
dw_1 dw_1
end type
global w_con_stock_mp_valorado_old w_con_stock_mp_valorado_old

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);string sel,mp,nombre_mp,nombre_familia,tipo_materia,familia, filtro
string nombre_tipo_materia,unidad,nombre_unidad,ubicacion_stock
string almacen,filtro_productos,proveedor,moneda_proveedor
long   indice,total,donde,grupo,productos_selecionados
dec    stock,precio,valor,stock_facturas,importe_total,cantidad_total
dec    importe,cantidad,cambio_moneda_proveedor
datetime fecha_ultimo_albaran,fecha_stock,ultima_fecha_albaran
boolean  salir
DataStore movimientos
datastore pedidos
string filtro_familias
long familias_seleccionadas


fecha_stock = DateTime(Date(em_fechadesde.text))

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,fecha_stock)

filtro_productos = ""
productos_selecionados = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_productos) = "" then
			filtro_productos = "'"+ uo_productos.dw_marca.getitemstring(indice,"codigo") +"'"
		else
			filtro_productos = filtro_productos+",'"+uo_productos.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
		productos_selecionados ++
	end if
next
if trim(filtro_productos) <> "" and productos_selecionados < uo_productos.dw_marca.rowcount() then
	filtro_productos = " and mp in(select codigo "+&
							 " from venmprima "+&
							 " where empresa = '"+codigo_empresa+"' "+&
							 " and tipo_materia in ("+filtro_productos+")) "
else
	filtro_productos = ""
end if	


//---------------------------------------------------------------------------------------------------------------
//									FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------
filtro_familias = ""
familias_seleccionadas = 0
for indice = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_familias) = "" then
			filtro_familias = "'"+ uo_familias.dw_marca.getitemstring(indice,"codigo") +"'"
		else
			filtro_familias = filtro_familias+",'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
		familias_seleccionadas ++
	end if
next
if trim(filtro_familias) <> "" and familias_seleccionadas < uo_familias.dw_marca.rowcount() then
	filtro_familias = " and mp in(select codigo "+&
							 " from venmprima "+&
							 " where empresa = '"+codigo_empresa+"' "+&
							 " and familia in ("+filtro_familias+")) "
else
	filtro_familias = ""
end if	
//---------------------------------------------------------------------------------------------------------------
//								FIN DEL FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------


	
sel = "select mp,"+&
		"sum(cantidade) - sum(cantidads) stock "+&
		"from commovhis "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   fechmov <= '"+String(Date(em_fechadesde.text),"dd/mm/yyyy")+"' "+&
		"and situacion <> 'A' "+&
		filtro_productos+&
		filtro_familias+&
		"group by mp"

f_cargar_cursor_nuevo(sel, movimientos)
total = movimientos.rowcount()

grupo           = 1
ubicacion_stock = "Fabrica"

for indice = 1 to total
	stock = movimientos.object.stock[indice]
	if stock <> 0 then
		mp        = movimientos.object.mp[indice]
	
		SELECT descripcion,
				 tipo_materia,
				 familia,
				 tipo_unidad
		INTO   :nombre_mp,
				 :tipo_materia,
				 :familia,
				 :unidad
		FROM   venmprima
		WHERE	 empresa = :codigo_empresa
		AND    codigo  = :mp;
				
		nombre_familia      = f_nombre_familia_compras(codigo_empresa,tipo_materia,familia)
		nombre_tipo_materia = f_nombre_materia(codigo_empresa,tipo_materia)
		nombre_unidad       = f_nombre_unimedida(unidad)
		
		salir = false
		importe_total  = 0
		cantidad_total = 0
		precio         = 0
		
		ultima_fecha_albaran = fecha_stock
		
		// Si la materia prima no tiene precio en la ficha de materias primas, no debe valorar el stock
		select max(precio)
		into   :precio
		from   comartpro
		where  empresa = :codigo_empresa
		and    mprima  = :mp;
		if isnull(precio) then precio = 0
		
		if precio > 0 then
			DO
				setnull(fecha_ultimo_albaran)
				select max(fecha_albaran)
				into   :fecha_ultimo_albaran
				from   comlinfac
				where  empresa = :codigo_empresa
				and    mprima  = :mp
				and    fecha_albaran <= :ultima_fecha_albaran;
		
				if not(isnull(fecha_ultimo_albaran)) &
					and year(date(fecha_ultimo_albaran)) <> 1900 then//& David 11-11-03
	//				and sqlca.sqlcode <> 0 then
	
					select sum((comlinfac.cantidad * comlinfac.precio)/comcabfac.cambio)
							,sum(comlinfac.cantidad)
					into   :importe,:cantidad
					from   comlinfac,comcabfac
					where  comlinfac.empresa = :codigo_empresa
					and    comlinfac.mprima  = :mp
					and    comlinfac.fecha_albaran = :fecha_ultimo_albaran
					and    comcabfac.empresa   = comlinfac.empresa
					and    comcabfac.anyo      = comlinfac.anyo   
					and    comcabfac.proveedor = comlinfac.proveedor
					and    comcabfac.factura   = comlinfac.factura;
					
					ultima_fecha_albaran = datetime(relativedate(date(fecha_ultimo_albaran), -1))
					
					importe_total  = importe_total + importe
					if isnull(importe_total) then importe_total = 0
					cantidad_total = cantidad_total + cantidad
					if isnull(cantidad_total) then cantidad_total = 0
					if cantidad_total >= stock then
						salir = true
					end if
				else
					salir = true
				end if
			LOOP WHILE NOT(salir)
		end if
		
		if cantidad_total > 0 then
			precio = importe_total / cantidad_total
		end if
		if precio <= 0 then
			//select min(precio)  David 10-11-03
			select max(precio)
			into   :precio
			from   comartpro
			where  empresa = :codigo_empresa
			and    mprima  = :mp;
			
			if isnull(precio) then precio = 0
			if precio > 0 then
				select min(proveedor)
				into   :proveedor
				from   comartpro
				where  empresa = :codigo_empresa
				and    mprima  = :mp
				and    precio  = :precio;
				
				if isnull(proveedor) then proveedor = ""
				
				if trim(proveedor) <> "" then
					moneda_proveedor = f_moneda_genter(codigo_empresa,"P",proveedor)
					
					cambio_moneda_proveedor = f_cambio_moneda(moneda_proveedor)
					
					if cambio_moneda_proveedor > 0 then
						precio = precio / cambio_moneda_proveedor
					end if
				end if
			end if			
		end if
		
		valor           = stock * precio
		
		donde           = data.insertrow(0)
		data.object.empresa[donde]             = codigo_empresa
		data.object.grupo[donde]               = grupo
		data.object.ubicacion_stock[donde]     = ubicacion_stock
		data.object.mp[donde]                  = mp
		data.object.nombre_mp[donde]           = nombre_mp
		data.object.nombre_familia[donde]      = nombre_familia
		data.object.nombre_tipo_materia[donde] = nombre_tipo_materia
		data.object.unidad[donde]              = unidad
		data.object.nombre_unidad[donde]       = nombre_unidad
		data.object.stock[donde]               = stock
		data.object.precio[donde]              = precio
		data.object.valor[donde]               = valor		
	end if
	f_mensaje_proceso("Procesando",indice,total)
next	

destroy movimientos	

if cbx_valor.checked then
	filtro = 	"valor <> 0"
	data.SetFilter(filtro)
	data.Filter()
	
end if
			

data.sort()		
data.GroupCalc()
data.SetRedraw(TRUE)		
end subroutine

event open;call super::open;long indice

This.title = " CONSULTA STOCK DE MATERIAS PRIMAS VALORADO "

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fechadesde.text = String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")

for indice =1 to uo_productos.dw_marca.rowcount()
	productos_marcados[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next


end event

on w_con_stock_mp_valorado_old.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_productos=create uo_productos
this.cb_3=create cb_3
this.gb_1=create gb_1
this.cbx_valor=create cbx_valor
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
this.gb_4=create gb_4
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_productos
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cbx_valor
this.Control[iCurrent+11]=this.cb_familias
this.Control[iCurrent+12]=this.uo_familias
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.dw_1
end on

on w_con_stock_mp_valorado_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_productos)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.cbx_valor)
destroy(this.cb_familias)
destroy(this.uo_familias)
destroy(this.gb_4)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_mp_valorado_old
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_mp_valorado_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_mp_valorado_old
integer y = 20
integer width = 2743
integer height = 84
end type

type pb_2 from upb_salir within w_con_stock_mp_valorado_old
integer x = 2766
integer y = 16
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

type em_fechadesde from u_em_campo within w_con_stock_mp_valorado_old
integer x = 1586
integer y = 140
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_mp_valorado_old
integer x = 1129
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

type cb_2 from commandbutton within w_con_stock_mp_valorado_old
event clicked pbm_bnclicked
integer x = 2400
integer y = 132
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

event clicked;uo_productos.visible = false
uo_familias.visible = false

f_cargar(dw_1)

end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_mp_valorado_old
event clicked pbm_bnclicked
integer x = 2761
integer y = 132
integer taborder = 10
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

	


end event

type dw_listado from datawindow within w_con_stock_mp_valorado_old
boolean visible = false
integer x = 1454
integer y = 1224
integer width = 494
integer height = 360
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_stock_mp_valorado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_productos from u_marca_lista within w_con_stock_mp_valorado_old
event destroy ( )
boolean visible = false
integer x = 69
integer y = 240
integer width = 1349
integer height = 656
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type cb_3 from commandbutton within w_con_stock_mp_valorado_old
integer x = 82
integer y = 132
integer width = 366
integer height = 92
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
uo_familias.visible = false

end event

type gb_1 from groupbox within w_con_stock_mp_valorado_old
integer x = 73
integer y = 92
integer width = 384
integer height = 140
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

type cbx_valor from checkbox within w_con_stock_mp_valorado_old
integer x = 1906
integer y = 144
integer width = 453
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo con valor"
boolean lefttext = true
end type

type cb_familias from commandbutton within w_con_stock_mp_valorado_old
integer x = 471
integer y = 132
integer width = 343
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

event clicked;long    indice,indice2,total2,indice3,donde
datastore familias
string  sel, producto, familia, tipo_producto_linea, codigo_familia
string  codigo_producto_familia, codigo_producto, descripcion_familia
boolean salir


for indice =1 to uo_productos.dw_marca.rowcount()
	if productos_marcados[indice] <> uo_productos.dw_marca.getitemstring(indice,"marca") then
		producto= uo_productos.dw_marca.getitemstring(indice,"codigo")		
		if productos_marcados[indice] = "S" then
			//Debemos eliminar las familias de ese tipo de materia	
			total2  = uo_familias.dw_marca.rowcount() 
			for indice2 = 1 to total2
				codigo_producto_familia = uo_familias.dw_marca.getitemstring(indice2,"codigo")		
				indice3 = 0
				codigo_producto = ""
				salir = false
				do 
					indice3 ++
					if mid(codigo_producto_familia,indice3,1) <> "/" then
						codigo_producto = codigo_producto + mid(codigo_producto_familia,indice3,1)
					else
						salir = true
					end if					
				loop until salir or indice3 = len(codigo_producto_familia)
				if codigo_producto = producto then
					uo_familias.dw_marca.deleterow(indice2)
					total2  = uo_familias.dw_marca.rowcount() 
					indice2 = indice2 -1
				end if
			next
		else
			//Debemos añadir las familias de ese tipo de materia			
			sel = "select familia,descripcion "+&
					"from venfamilias "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and tipo_materia = '"+producto+"'"
					
			//familias = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, familias)
			total2  = familias.rowcount()
			for indice2 = 1 to total2
				familia             = familias.object.familia[indice2]
				descripcion_familia = familias.object.descripcion[indice2] 
				donde = uo_familias.dw_marca.insertrow(uo_familias.dw_marca.rowcount()+1)
				uo_familias.dw_marca.setitem(donde,"codigo",familia)				
				uo_familias.dw_marca.setitem(donde,"texto", 'P:'+producto+' / '+descripcion_familia)				
			next
		end if
		productos_marcados[indice] = uo_productos.dw_marca.getitemstring(indice,"marca")
	end if
next
destroy familias
uo_productos.visible = false
uo_familias.visible     = not(uo_familias.visible)
end event

type uo_familias from u_marca_lista within w_con_stock_mp_valorado_old
event destroy ( )
boolean visible = false
integer x = 466
integer y = 240
integer width = 1362
integer height = 668
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type gb_4 from groupbox within w_con_stock_mp_valorado_old
integer x = 462
integer y = 92
integer width = 361
integer height = 140
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

type dw_1 from u_datawindow_consultas within w_con_stock_mp_valorado_old
integer x = 55
integer y = 248
integer width = 2825
integer height = 2992
integer taborder = 70
string dataobject = "dw_con_stock_mp_valorado"
boolean vscrollbar = true
boolean livescroll = false
end type

