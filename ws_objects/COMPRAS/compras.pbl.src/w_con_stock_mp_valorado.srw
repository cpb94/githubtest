$PBExportHeader$w_con_stock_mp_valorado.srw
forward
global type w_con_stock_mp_valorado from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_mp_valorado
end type
type em_fechadesde from u_em_campo within w_con_stock_mp_valorado
end type
type st_7 from statictext within w_con_stock_mp_valorado
end type
type cb_2 from commandbutton within w_con_stock_mp_valorado
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_mp_valorado
end type
type dw_listado from datawindow within w_con_stock_mp_valorado
end type
type uo_productos from u_marca_lista within w_con_stock_mp_valorado
end type
type cbx_valor from checkbox within w_con_stock_mp_valorado
end type
type uo_familias from u_marca_lista within w_con_stock_mp_valorado
end type
type dw_1 from u_datawindow_consultas within w_con_stock_mp_valorado
end type
type dw_seleccion from u_seleccion2 within w_con_stock_mp_valorado
end type
type cb_1 from commandbutton within w_con_stock_mp_valorado
end type
type gb_2 from groupbox within w_con_stock_mp_valorado
end type
end forward

global type w_con_stock_mp_valorado from w_int_con_empresa
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
cbx_valor cbx_valor
uo_familias uo_familias
dw_1 dw_1
dw_seleccion dw_seleccion
cb_1 cb_1
gb_2 gb_2
end type
global w_con_stock_mp_valorado w_con_stock_mp_valorado

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
str_res_consumo resultado


fecha_stock = DateTime(Date(em_fechadesde.text))

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,fecha_stock)

/*
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

	
sel = "select mp "+&
		"sum(cantidade) - sum(cantidads) stock "+&
		"from commovhis "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   fechmov <= '"+String(Date(em_fechadesde.text),"dd/mm/yyyy")+"' "+&
		"and situacion <> 'A' "+&
		filtro_productos+&
		filtro_familias+&
		"group by mp"
		
		*/

filtro = dw_seleccion.devolver_resultado()

if filtro = "" then
	MessageBox("Atención", "Debe seleccionar un filtro")
	return
end if
		
sel = "SELECT venmprima.codigo "+&
		"FROM venmprima "+&
		"INNER JOIN venfamilias  ON venmprima.empresa = venfamilias.empresa AND venmprima.tipo_materia = venfamilias.tipo_materia AND venmprima.familia = venfamilias.familia "+&
		"INNER JOIN venmateria ON venfamilias.empresa = venmateria.empresa and venfamilias.tipo_materia = venmateria.codigo  "+&
		"WHERE "+filtro

f_cargar_cursor_nuevo(sel, movimientos)
total = movimientos.rowcount()

grupo           = 1
ubicacion_stock = "Fabrica"

for indice = 1 to total
	mp        = movimientos.object.venmprima_codigo[indice]
	
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
	
	resultado  = ftc_calculo_consumo_mp(fecha_stock, mp)
	//hay que preparar la estructura que devuelve los valores correctos
		
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
	
	
	data.object.stock[donde]               = resultado.stock
	data.object.precio[donde]              = resultado.precio
	data.object.valor[donde]               = resultado.valor		

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
String consulta_seleccion

This.title = " CONSULTA STOCK DE MATERIAS PRIMAS VALORADO "

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fechadesde.text = String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)

dw_seleccion.visible = false
dw_seleccion.SetTransObject(SQLCA)
consulta_seleccion =   "SELECT venmateria.codigo,   "+&
							  "       venmateria.descripcion,   "+&
	 						  "       venfamilias.familia,  "+&
						     "	    venfamilias.descripcion,   "+&
							  "       0 as seleccionado   "+&
							  "FROM  venfamilias,   "+&
							  "       venmateria  "+&
							  "WHERE ( venfamilias.empresa = venmateria.empresa ) and  "+&
							  "      ( venfamilias.tipo_materia = venmateria.codigo ) "+&
							  "ORDER BY CONVERT(Integer,venmateria.codigo) ASC, CONVERT(Integer,venfamilias.familia) ASC"

dw_seleccion.SetSQLSelect(consulta_seleccion)
dw_seleccion.retrieve()

/*
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")

for indice =1 to uo_productos.dw_marca.rowcount()
	productos_marcados[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next
*/


end event

on w_con_stock_mp_valorado.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_productos=create uo_productos
this.cbx_valor=create cbx_valor
this.uo_familias=create uo_familias
this.dw_1=create dw_1
this.dw_seleccion=create dw_seleccion
this.cb_1=create cb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_productos
this.Control[iCurrent+8]=this.cbx_valor
this.Control[iCurrent+9]=this.uo_familias
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_seleccion
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_con_stock_mp_valorado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_productos)
destroy(this.cbx_valor)
destroy(this.uo_familias)
destroy(this.dw_1)
destroy(this.dw_seleccion)
destroy(this.cb_1)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_mp_valorado
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_mp_valorado
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_mp_valorado
integer y = 20
integer width = 2743
integer height = 84
end type

type pb_2 from upb_salir within w_con_stock_mp_valorado
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

type em_fechadesde from u_em_campo within w_con_stock_mp_valorado
integer x = 1586
integer y = 140
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_mp_valorado
integer x = 1015
integer y = 144
integer width = 535
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock a Fecha <="
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_mp_valorado
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

type pb_imprimir_preli from upb_imprimir within w_con_stock_mp_valorado
event clicked pbm_bnclicked
integer x = 2761
integer y = 132
integer taborder = 10
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

	


end event

type dw_listado from datawindow within w_con_stock_mp_valorado
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

type uo_productos from u_marca_lista within w_con_stock_mp_valorado
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

type cbx_valor from checkbox within w_con_stock_mp_valorado
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

type uo_familias from u_marca_lista within w_con_stock_mp_valorado
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

type dw_1 from u_datawindow_consultas within w_con_stock_mp_valorado
integer x = 55
integer y = 248
integer width = 2825
integer height = 2992
integer taborder = 70
string dataobject = "dw_con_stock_mp_valorado"
boolean vscrollbar = true
boolean livescroll = false
end type

type dw_seleccion from u_seleccion2 within w_con_stock_mp_valorado
boolean visible = false
integer x = 55
integer y = 228
integer height = 948
integer taborder = 80
boolean bringtotop = true
end type

type cb_1 from commandbutton within w_con_stock_mp_valorado
integer x = 64
integer y = 132
integer width = 562
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos / Familias"
end type

event clicked;//uo_productos.visible = not(uo_productos.visible)
//uo_familias.visible = false

dw_seleccion.visible = not(dw_seleccion.visible)

end event

type gb_2 from groupbox within w_con_stock_mp_valorado
integer x = 55
integer y = 92
integer width = 585
integer height = 140
integer taborder = 30
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

