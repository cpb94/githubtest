$PBExportHeader$w_con_meses_de_ventas_stock.srw
forward
global type w_con_meses_de_ventas_stock from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_meses_de_ventas_stock
end type
type pb_imprimir_preli from upb_imprimir within w_con_meses_de_ventas_stock
end type
type st_mensaje from statictext within w_con_meses_de_ventas_stock
end type
type cb_consulta from commandbutton within w_con_meses_de_ventas_stock
end type
type dw_datos from datawindow within w_con_meses_de_ventas_stock
end type
type cb_1 from commandbutton within w_con_meses_de_ventas_stock
end type
type sle_art from singlelineedit within w_con_meses_de_ventas_stock
end type
type pb_3 from upb_imprimir within w_con_meses_de_ventas_stock
end type
type sle_meses from singlelineedit within w_con_meses_de_ventas_stock
end type
type st_1 from statictext within w_con_meses_de_ventas_stock
end type
type ddlb_periodo from dropdownlistbox within w_con_meses_de_ventas_stock
end type
type st_2 from statictext within w_con_meses_de_ventas_stock
end type
end forward

global type w_con_meses_de_ventas_stock from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4539
integer height = 3620
string title = "Meses de Ventas con el Stock Actual"
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
st_mensaje st_mensaje
cb_consulta cb_consulta
dw_datos dw_datos
cb_1 cb_1
sle_art sle_art
pb_3 pb_3
sle_meses sle_meses
st_1 st_1
ddlb_periodo ddlb_periodo
st_2 st_2
end type
global w_con_meses_de_ventas_stock w_con_meses_de_ventas_stock

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public function boolean f_modificacion_art ()
end prototypes

public function boolean f_modificacion_art ();
String formato,tipo_unidad,descripcion,articulo,mascara
Dec{4}  metros_caja,piezascaja,peso
//articulo = uo_articulo.em_codigo.text
//Select descripcion,formato,unidad,metroscaja,piezascaja,pesopieza
//Into   :descripcion,:formato,:tipo_unidad,:metros_caja,:piezascaja,:peso
//From   articulos
//Where  articulos.empresa = :codigo_empresa
//And    articulos.codigo  = :articulo;
//
//uo_articulo.em_campo.text=descripcion
//IF Trim(uo_articulo.em_campo.text)="" THEN 
// IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
// uo_articulo.em_campo.text=""
// uo_articulo.em_codigo.text=""
// return TRUE
//END IF
//mascara = f_mascara_unidad(tipo_unidad)
//f_mascara_columna(dw_1,"disponible",mascara)
//f_mascara_columna(dw_1,"preparado",mascara)
//f_mascara_columna(dw_1,"reservado",mascara)
//IF Trim(uo_articulo.em_codigo.text)<>"" Then f_control()
//st_tipo_unidad.text  = f_nombre_unidad(tipo_unidad)
//st_tipo_formato.text = f_nombre_formato_abr(codigo_empresa,formato)
//st_metros.text       = string(metros_caja,"###,##0.00")
//st_piezas.text       = string(piezascaja,"###,##0")
//st_peso.text         = string(peso,"###.#00")
Return TRUE

end function

event open;call super::open;date fecha
string mes, anyo


dw_datos.SetTransObject(sqlca)

This.title = " Meses de Ventas a Partir del Stock "

ddlb_periodo.text = "Todos"


//f_activar_campo(em_fecha1)

end event

on w_con_meses_de_ventas_stock.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_mensaje=create st_mensaje
this.cb_consulta=create cb_consulta
this.dw_datos=create dw_datos
this.cb_1=create cb_1
this.sle_art=create sle_art
this.pb_3=create pb_3
this.sle_meses=create sle_meses
this.st_1=create st_1
this.ddlb_periodo=create ddlb_periodo
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.st_mensaje
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.dw_datos
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.sle_art
this.Control[iCurrent+8]=this.pb_3
this.Control[iCurrent+9]=this.sle_meses
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.ddlb_periodo
this.Control[iCurrent+12]=this.st_2
end on

on w_con_meses_de_ventas_stock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_mensaje)
destroy(this.cb_consulta)
destroy(this.dw_datos)
destroy(this.cb_1)
destroy(this.sle_art)
destroy(this.pb_3)
destroy(this.sle_meses)
destroy(this.st_1)
destroy(this.ddlb_periodo)
destroy(this.st_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_meses_de_ventas_stock
integer x = 96
integer y = 704
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_meses_de_ventas_stock
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_meses_de_ventas_stock
integer x = 18
integer y = 16
integer width = 7419
integer height = 84
integer textsize = -11
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_meses_de_ventas_stock
integer x = 4315
integer y = 116
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type pb_imprimir_preli from upb_imprimir within w_con_meses_de_ventas_stock
event clicked pbm_bnclicked
boolean visible = false
integer x = 4146
integer y = 24
integer taborder = 100
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_datos)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type st_mensaje from statictext within w_con_meses_de_ventas_stock
boolean visible = false
integer x = 46
integer y = 3324
integer width = 3355
integer height = 132
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 19474154
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_consulta from commandbutton within w_con_meses_de_ventas_stock
integer x = 3717
integer y = 116
integer width = 402
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string sel
datastore consulta
string filtro_periodo
date ahora, fecha_anterior

ahora = today()
fecha_anterior = RelativeDate ( ahora, - integer(sle_meses.text) * 30 )

dw_datos.object.t_meses.text =  sle_meses.text

choose case ddlb_periodo.text
	case "Dentro del periodo"
		filtro_periodo = " articulos.fecha_alta >= '"+string(fecha_anterior, "dd-mm-yyyy")+"' "
		
	case "Anterior al periodo"
		filtro_periodo = " articulos.fecha_alta <= '"+string(fecha_anterior, "dd-mm-yyyy")+"' "
		
	case else		
		filtro_periodo = " 1 = 1 "
end choose



sel = " SELECT	"+sle_meses.text+" meses_calc, "+&
		" articulos.familia, "+&
		" familias.descripcion, "+&
		" articulos.marcas_codigo, "+&
		" marcas.descripcion, "+&
		" articulos.submarcas_codigo, "+&
		" submarcas.descripcion, "+&
		" c1.cod_articulo,  "+&
		" c1.des_articulo,  "+&
		" formatos.abreviado, "+&
		" c1.stock as stock_piezas, "+&
		" c1.precio as precio, "+&
		"  CASE WHEN articulos.unidad = '0'  "+&
		" 			THEN  c1.stock * c1.precio  "+&
		" 			WHEN articulos.unidad = '1'  "+&
		" 			THEN ( (c1.stock  * (formatos.ancho * formatos.largo) ) / 10000 ) * c1.precio "+&
		" 		END as stock_a_pv, "+&
		" (c1.stock * formatos.ancho * formatos.largo ) / 10000 as stock_m2, "+&
		" sum (	CASE WHEN venlifac.tipo_unidad = '0'  "+&
		" 					THEN venlifac.cantidad  "+&
		" 					WHEN venlifac.tipo_unidad = '1'   "+&
		" 					THEN(venlifac.cantidad  / almartcajas.metroscaja  ) * almartcajas.piezascaja  "+&
		" 			END) as cantidad_piezas, "+&
		" ISNULL ( sum (	CASE WHEN venlifac.tipo_unidad = '0'  "+&
		" 					THEN ( venlifac.cantidad * formatos.ancho * formatos.largo ) / 10000 "+&
		" 					WHEN venlifac.tipo_unidad = '1'  "+&
		" 					THEN (venlifac.cantidad  / almartcajas.metroscaja  ) * almartcajas.piezascaja * (( formatos.ancho * formatos.largo ) / 10000) "+&
		" 			END   ), 0) "+&
		" + ISNULL ( sum ( CASE WHEN venlialb.tipo_unidad = '0'  "+&
		"						THEN ( venlialb.cantidad * formatos.ancho * formatos.largo ) / 10000 "+&
		"						WHEN venlialb.tipo_unidad = '1'  "+&
		"						THEN (venlialb.cantidad  / almartcajas.metroscaja  ) * almartcajas.piezascaja * (( formatos.ancho * formatos.largo ) / 10000) "+&
		"			END   ) , 0 ) as cantidad_m2, "+&
		" sum ( ( venlifac.neto - venlifac.impdtopp ) / venlifac.cambio) "+&
		" + isnull (sum ( ( venlialb.neto - venlialb.impdtopp ) / venalb.cambio), 0 )as ventas_periodo "+&
" FROM "+&
		" ( SELECT almacenmovimientos.empresa as empresa,  "+&
		" 	almacenmovimientos.articulo as cod_articulo,  "+&
		" 	articulos.descripcion as des_articulo, "+&
		" 	ventarifas_precios.precio as precio, "+&
		" 	sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads ) as stock "+&
		" 	FROM almacenmovimientos "+&
		" 	INNER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
		" 	INNER JOIN ventarifas_precios ON articulos.empresa = ventarifas_precios.empresa AND articulos.codigo = ventarifas_precios.articulos_codigo "+&
		" 			AND ventarifas_precios.ventarifas_codigo = (	SELECT TOP 1 tar.ventarifas_codigo "+&
		" 																		FROM ventarifas_precios tar "+&
		" 																		WHERE tar.empresa = ventarifas_precios.empresa "+&
		" 																		AND tar.articulos_codigo = ventarifas_precios.articulos_codigo "+&
		" 																		AND tar.ventarifas_codigo <> '5' "+&
		" 																		ORDER BY tar.precio ASC )  "+&
		" WHERE articulos.uso = '3' "+&
		" AND articulos.promocion <> 'S' "+&
		" AND almacenmovimientos.empresa = '1' "+&
		" GROUP BY almacenmovimientos.empresa,  "+&
		" 	almacenmovimientos.articulo,  "+&
		" 	articulos.descripcion, "+&
		" 	ventarifas_precios.precio "+&
		" HAVING sum (almacenmovimientos.cantidade - almacenmovimientos.cantidads ) > 0 ) as c1 "+&
" LEFT OUTER JOIN venlifac ON c1.empresa = venlifac.empresa AND c1.cod_articulo = venlifac.articulo  "+&
" LEFT OUTER JOIN venlialb ON c1.empresa = venlialb.empresa AND c1.cod_articulo = venlialb.articulo "+& 
" LEFT OUTER JOIN venalb ON venalb.empresa = venlialb.empresa AND venalb.anyo = venlialb.anyo AND venalb.albaran = venlialb.albaran "+&
" INNER JOIN almartcajas ON venlifac.empresa = almartcajas.empresa AND venlifac.articulo = almartcajas.articulo AND venlifac.caja = almartcajas.caja  "+&
" INNER JOIN formatos ON venlifac.empresa = formatos.empresa AND venlifac.formato = formatos.codigo "+&
" INNER JOIN articulos ON c1.empresa = articulos.empresa AND c1.cod_articulo = articulos.codigo "+&
" INNER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo "+&
" INNER JOIN marcas ON articulos.empresa = marcas.empresa AND articulos.marcas_codigo = marcas.codigo "+&
" INNER JOIN submarcas ON articulos.empresa = submarcas.empresa AND articulos.submarcas_codigo = submarcas.codigo "+&
" WHERE  ( ffactura BETWEEN '"+string(fecha_anterior, "dd-mm-yyyy")+"' AND '"+string(ahora, "dd-mm-yyyy")+"' or venlifac.ffactura IS NULL ) "+&
" AND ( venlialb.falbaran BETWEEN '"+string(fecha_anterior, "dd-mm-yyyy")+"' AND '"+string(ahora, "dd-mm-yyyy")+"' or venlialb.falbaran IS NULL )"+&
" AND "+filtro_periodo+ &
" GROUP BY articulos.familia, "+&
" 		familias.descripcion, "+&
" 		articulos.marcas_codigo, "+&
" 		marcas.descripcion, "+&
" 		articulos.submarcas_codigo, "+&
" 		submarcas.descripcion, "+&
" 		articulos.unidad, "+&
" 		c1.cod_articulo,  "+&
" 		c1.des_articulo,  "+&
" 		formatos.abreviado, "+&
" 		formatos.ancho, "+&
" 		formatos.largo, "+&
" 		c1.stock, "+&
" 		c1.precio "+&
" ORDER BY familias.descripcion, "+&
" 		marcas.descripcion, "+&
" 		submarcas.descripcion, "+&
" 		cantidad_m2 DESC "


f_cargar_cursor_nuevo (sel, consulta)

dw_datos.object.data = consulta.object.data

dw_datos.Sort()
dw_datos.GroupCalc()

destroy consulta






end event

type dw_datos from datawindow within w_con_meses_de_ventas_stock
integer x = 14
integer y = 268
integer width = 4448
integer height = 3140
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_meses_de_ventas_stock"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type cb_1 from commandbutton within w_con_meses_de_ventas_stock
boolean visible = false
integer x = 5047
integer y = 128
integer width = 841
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asignar Marcas y Submarcas"
end type

event clicked;datastore datos
long i, total_regs 
string sel
string articulo, marca, submarca
str_escandallo vector_escandallo[300]
int indice, m, k
decimal factor_acumulado = 1
int nivel = 0

sel = " select codigo, marcas_codigo, submarcas_codigo from articulos where uso = '3' and promocion <> 'S' and codigo = '"+sle_art.text+"'"
		
f_cargar_cursor_nuevo ( sel, datos )	
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = ''
	marca = ''
	submarca = ''
	
	articulo = datos.object.codigo[i]
	marca = datos.object.marcas_codigo[i]
	submarca = datos.object.submarcas_codigo[i]
	
	
	indice = 1
	for m = 1 to 300
		setnull(vector_Escandallo[m].articulo)
		setnull(vector_Escandallo[m].version)
		setnull(vector_Escandallo[m].factor)
	next

	f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, true)
	
	for k=1 to indice
		if vector_Escandallo[k].nivel > 1 then
			update articulos set marcas_codigo = :marca , submarcas_codigo = :submarca
			where codigo = :vector_Escandallo[k].articulo;
		end if
	next
	
	commit using sqlca;	
	st_mensaje.text = 'Actualizando '+string(i)+" de "+string (total_regs)
next


destroy datos






end event

type sle_art from singlelineedit within w_con_meses_de_ventas_stock
boolean visible = false
integer x = 7794
integer y = 24
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type pb_3 from upb_imprimir within w_con_meses_de_ventas_stock
integer x = 4151
integer y = 116
integer width = 146
integer height = 128
integer taborder = 70
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_datos)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type sle_meses from singlelineedit within w_con_meses_de_ventas_stock
integer x = 608
integer y = 144
integer width = 178
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "12"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_1 from statictext within w_con_meses_de_ventas_stock
integer x = 82
integer y = 152
integer width = 517
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Meses de Ventas:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_periodo from dropdownlistbox within w_con_meses_de_ventas_stock
integer x = 2409
integer y = 136
integer width = 846
integer height = 376
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Georgia"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todos","Dentro del periodo","Anterior al periodo"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_meses_de_ventas_stock
integer x = 1166
integer y = 156
integer width = 1202
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha de alta de los atículos analizados:"
alignment alignment = center!
boolean focusrectangle = false
end type

