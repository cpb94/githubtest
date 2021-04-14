$PBExportHeader$w_con_variacion_stock_coste_fabricacion.srw
forward
global type w_con_variacion_stock_coste_fabricacion from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_variacion_stock_coste_fabricacion
end type
type em_fecha1 from u_em_campo within w_con_variacion_stock_coste_fabricacion
end type
type st_7 from statictext within w_con_variacion_stock_coste_fabricacion
end type
type pb_imprimir_preli from upb_imprimir within w_con_variacion_stock_coste_fabricacion
end type
type st_85 from statictext within w_con_variacion_stock_coste_fabricacion
end type
type em_fecha2 from u_em_campo within w_con_variacion_stock_coste_fabricacion
end type
type st_mensaje from statictext within w_con_variacion_stock_coste_fabricacion
end type
type cbx_coste from checkbox within w_con_variacion_stock_coste_fabricacion
end type
type cb_consulta from commandbutton within w_con_variacion_stock_coste_fabricacion
end type
type dw_datos from datawindow within w_con_variacion_stock_coste_fabricacion
end type
type cb_1 from commandbutton within w_con_variacion_stock_coste_fabricacion
end type
type sle_art from singlelineedit within w_con_variacion_stock_coste_fabricacion
end type
type pb_3 from upb_imprimir within w_con_variacion_stock_coste_fabricacion
end type
type ddlb_promocion from dropdownlistbox within w_con_variacion_stock_coste_fabricacion
end type
type cbx_art_sin_familia from checkbox within w_con_variacion_stock_coste_fabricacion
end type
end forward

global type w_con_variacion_stock_coste_fabricacion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5083
integer height = 3620
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fecha1 em_fecha1
st_7 st_7
pb_imprimir_preli pb_imprimir_preli
st_85 st_85
em_fecha2 em_fecha2
st_mensaje st_mensaje
cbx_coste cbx_coste
cb_consulta cb_consulta
dw_datos dw_datos
cb_1 cb_1
sle_art sle_art
pb_3 pb_3
ddlb_promocion ddlb_promocion
cbx_art_sin_familia cbx_art_sin_familia
end type
global w_con_variacion_stock_coste_fabricacion w_con_variacion_stock_coste_fabricacion

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

This.title = " VARIACIÓN DE STOCK "

mes = string(month(today()))
anyo = string(year(today()))
fecha = date('01-'+mes+'-'+anyo)
//RelativeDate ( fecha, -1 )

em_fecha1.text=String(DateTime(RelativeDate ( fecha, -1 )),"dd-mm-yy")
em_fecha2.text=String(DateTime(Today()),"dd-mm-yy")


f_activar_campo(em_fecha1)

ddlb_promocion.text = "Stock sin Promoción"
end event

on w_con_variacion_stock_coste_fabricacion.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fecha1=create em_fecha1
this.st_7=create st_7
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_85=create st_85
this.em_fecha2=create em_fecha2
this.st_mensaje=create st_mensaje
this.cbx_coste=create cbx_coste
this.cb_consulta=create cb_consulta
this.dw_datos=create dw_datos
this.cb_1=create cb_1
this.sle_art=create sle_art
this.pb_3=create pb_3
this.ddlb_promocion=create ddlb_promocion
this.cbx_art_sin_familia=create cbx_art_sin_familia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fecha1
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.st_85
this.Control[iCurrent+6]=this.em_fecha2
this.Control[iCurrent+7]=this.st_mensaje
this.Control[iCurrent+8]=this.cbx_coste
this.Control[iCurrent+9]=this.cb_consulta
this.Control[iCurrent+10]=this.dw_datos
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.sle_art
this.Control[iCurrent+13]=this.pb_3
this.Control[iCurrent+14]=this.ddlb_promocion
this.Control[iCurrent+15]=this.cbx_art_sin_familia
end on

on w_con_variacion_stock_coste_fabricacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fecha1)
destroy(this.st_7)
destroy(this.pb_imprimir_preli)
destroy(this.st_85)
destroy(this.em_fecha2)
destroy(this.st_mensaje)
destroy(this.cbx_coste)
destroy(this.cb_consulta)
destroy(this.dw_datos)
destroy(this.cb_1)
destroy(this.sle_art)
destroy(this.pb_3)
destroy(this.ddlb_promocion)
destroy(this.cbx_art_sin_familia)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_variacion_stock_coste_fabricacion
integer x = 96
integer y = 704
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_variacion_stock_coste_fabricacion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_variacion_stock_coste_fabricacion
integer x = 18
integer y = 16
integer width = 5019
integer height = 84
integer textsize = -11
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_variacion_stock_coste_fabricacion
integer x = 4864
integer y = 136
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

type em_fecha1 from u_em_campo within w_con_variacion_stock_coste_fabricacion
integer x = 480
integer y = 160
integer width = 311
integer height = 76
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_variacion_stock_coste_fabricacion
integer x = 850
integer y = 160
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha2 <="
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir_preli from upb_imprimir within w_con_variacion_stock_coste_fabricacion
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

type st_85 from statictext within w_con_variacion_stock_coste_fabricacion
integer x = 110
integer y = 160
integer width = 370
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha1 <="
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha2 from u_em_campo within w_con_variacion_stock_coste_fabricacion
integer x = 1193
integer y = 160
integer width = 311
integer height = 76
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type st_mensaje from statictext within w_con_variacion_stock_coste_fabricacion
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

type cbx_coste from checkbox within w_con_variacion_stock_coste_fabricacion
integer x = 1609
integer y = 160
integer width = 466
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Calcular Costes"
borderstyle borderstyle = styleraised!
end type

type cb_consulta from commandbutton within w_con_variacion_stock_coste_fabricacion
integer x = 4302
integer y = 136
integer width = 402
integer height = 96
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
long i, total_regs
string articulo
dec {6} coste_mp, coste_fab, coste_packing, coste_compras, coste_historico, v_total_facturado , v_albaranes_pendientes
boolean mermas = true
long piezas_a, piezas_b
datetime fecha1, fecha2
string filtro_promocion, restriccion_sin_familia 
time inicio, ahora, fin

inicio = now()

st_mensaje.visible = true
dw_datos.object.t_titulo.text = ''

choose case ddlb_promocion.text 

case 'Stock sin Promoción'
	filtro_promocion = "ART.promocion <> 'S'"
	dw_datos.object.t_titulo.text =  dw_datos.object.t_titulo.text + " ( Stock sin Promoción )"   

case 'Stock sólo Promoción'
	filtro_promocion = "ART.promocion = 'S'"
	dw_datos.object.t_titulo.text =  dw_datos.object.t_titulo.text + " ( Stock sólo Promoción )"   
end choose

if cbx_art_sin_familia.checked then
	restriccion_sin_familia = " 1= 1  "
else
	restriccion_sin_familia = "ART.familia <> '0'  "
end if

fecha1 = DateTime(Date(em_fecha1.text))
fecha2 = DateTime(Date(em_fecha2.text))

dw_datos.object.stock_metros_a_t.text = em_fecha1.text
dw_datos.object.stock_metros_b_t.text = em_fecha2.text
dw_datos.object.stock_precio_vta_a_t.text = em_fecha1.text
dw_datos.object.stock_precio_vta_b_t.text = em_fecha2.text
dw_datos.object.precio_m2_a.text = em_fecha1.text
dw_datos.object.precio_m2_b.text = em_fecha2.text
dw_datos.object.stock_coste_a_t.text = em_fecha1.text
dw_datos.object.stock_coste_b_t.text = em_fecha2.text
dw_datos.object.euros_m2_coste_a_t.text = em_fecha1.text
dw_datos.object.euros_m2_coste_b_t.text = em_fecha2.text

sel = " select ART.uso "+&
		" , almusos.descripcion "+&
		" , ART.familia "+&
		" , familias.descripcion "+&
		" , ART.marcas_codigo "+&
		" , marcas.descripcion "+&
		" , ART.submarcas_codigo "+&
		" , submarcas.descripcion "+&
		" , ART.codigo "+&
		" , ART.descripcion "+&
		" , formatos.ancho "+&
		" , formatos.largo "+&
		" , isnull ( sum( 	CASE WHEN almacenmovimientos.fecha_mov <= '"+em_fecha1.text+"' "+&
		"						THEN  almacenmovimientos.cantidade - almacenmovimientos.cantidads "+&
		"						ELSE 0 END), 0 )  AS stock_piezas_A "+&
		" , isnull ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads), 0 ) AS stock_piezas_B "+&
		" , isnull ( sum( 	CASE WHEN almacenmovimientos.fecha_mov <= '"+em_fecha1.text+"'  "+&
		" 						THEN  (almacenmovimientos.cantidade - almacenmovimientos.cantidads) * formatos.ancho * formatos.largo  / 10000 "+&
		" 						ELSE 0 END), 0 )  AS stock_metros_A "+&
		" , isnull (sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads)* formatos.ancho * formatos.largo  / 10000, 0) AS stock_metros_B "+&
		" , (	SELECT isnull (sum (	CASE WHEN ART2.unidad = '0'  "+&
		" 										THEN (almacenmovimientos.cantidade - almacenmovimientos.cantidads)   "+&
		" 										ELSE (( (almacenmovimientos.cantidade - almacenmovimientos.cantidads) / av.piezascaja) * av.metroscaja)  END "+&
		"	 								*	CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0 "+&
		" 										THEN isnull(ventarifas_precios.precio,0)  "+&
		" 										ELSE isnull(ventarifas_precios_packs.precio,0)  "+&
		" 										END  "+&
		"										) , 0) "+&
		" 		FROM almacenmovimientos "+&
		" 		LEFT OUTER JOIN articulos ART2 ON almacenmovimientos.empresa = ART2.empresa AND almacenmovimientos.articulo = ART2.codigo "+&
		" 		LEFT OUTER JOIN ventarifas_precios ON ventarifas_precios.articulos_codigo = ART2.codigo and ventarifas_precios.empresa = ART2.empresa "+&
		" 		LEFT OUTER JOIN ventarifas_precios_packs ON ventarifas_precios_packs.articulos_codigo = ART2.codigo and ventarifas_precios_packs.empresa = ART2.empresa "+&
		" 		LEFT OUTER JOIN almartcajas av ON almacenmovimientos.empresa = av.empresa AND almacenmovimientos.articulo = av.articulo AND almacenmovimientos.caja = av.caja "+&
		" 		WHERE almacenmovimientos.empresa = ART.empresa AND almacenmovimientos.articulo = ART.codigo "+&
		" 			AND  ( ventarifas_precios.ventarifas_codigo = 		 (	SELECT top 1 B.ventarifas_codigo "+&
		"																						FROM ventarifas_precios B "+&
		"																						WHERE b.articulos_codigo = ART.codigo "+&
		"																						AND B.empresa = ART.empresa "+&
		"																						AND B.ventarifas_codigo <> '5' "+&
		"																						AND B.calidades_codigo = '1' "+&
		"																						ORDER BY B.precio asc)  "+&
		"																						OR ventarifas_precios.ventarifas_codigo IS NULL)  "+&
		" 			AND  ( ventarifas_precios_packs.ventarifas_codigo = ( 	SELECT top 1 B2.ventarifas_codigo "+&
		"																						FROM ventarifas_precios_packs B2 "+&
		"																						WHERE B2.articulos_codigo = ART.codigo "+&
		"																						AND B2.empresa = ART.empresa "+&
		"																						AND B2.ventarifas_codigo <> '5' "+&
		"																						AND B2.calidades_codigo = '1' "+&
		"																						ORDER BY B2.precio asc)  "+&
		"																						OR ventarifas_precios_packs.ventarifas_codigo IS NULL)  "+&
		" 			AND ( ventarifas_precios.calidades_codigo = '1'  OR ventarifas_precios_packs.calidades_codigo = '1' ) "+&					
		" 			AND almacenmovimientos.fecha_mov <=  '"+em_fecha1.text+"' ) AS stock_precio_vta_A "+&
		" , ( 	SELECT isnull (sum (	CASE WHEN ART2.unidad = '0'  "+&
		" 										THEN (almacenmovimientos.cantidade - almacenmovimientos.cantidads)   "+&
		" 										ELSE (( (almacenmovimientos.cantidade - almacenmovimientos.cantidads) / av.piezascaja) * av.metroscaja)  END  "+&
		"	 								*	CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0 "+&
		" 										THEN isnull(ventarifas_precios.precio,0)  "+&
		" 										ELSE isnull(ventarifas_precios_packs.precio,0)  "+&
		" 										END  "+&
		"										) , 0) "+&
		" 		FROM almacenmovimientos "+&
		" 		LEFT OUTER JOIN articulos ART2 ON almacenmovimientos.empresa = ART2.empresa AND almacenmovimientos.articulo = ART2.codigo "+&
		" 		LEFT OUTER JOIN ventarifas_precios ON ventarifas_precios.articulos_codigo = ART2.codigo and ventarifas_precios.empresa = ART2.empresa "+&
		" 		LEFT OUTER JOIN ventarifas_precios_packs ON ventarifas_precios_packs.articulos_codigo = ART2.codigo and ventarifas_precios_packs.empresa = ART2.empresa "+&
		" 		LEFT OUTER JOIN almartcajas av ON almacenmovimientos.empresa = av.empresa AND almacenmovimientos.articulo = av.articulo AND almacenmovimientos.caja = av.caja "+&
		" 		WHERE almacenmovimientos.empresa = ART.empresa AND almacenmovimientos.articulo = ART.codigo "+&
		" 			AND (ventarifas_precios.ventarifas_codigo = ( SELECT TOP 1 C.ventarifas_codigo "+&
		"																		FROM ventarifas_precios C  "+&
		"																		WHERE C.articulos_codigo = ART.codigo  "+&
		"																		AND C.empresa = ART.empresa  "+&
		"																		AND C.ventarifas_codigo <> '5'   "+&
		"																		AND  C.calidades_codigo = '1'  "+&
		"																		ORDER BY C.precio ASC) "+&
		"																		OR ventarifas_precios.ventarifas_codigo IS NULL)  "+&
		" 			AND (ventarifas_precios_packs.ventarifas_codigo = ( SELECT TOP 1 C2.ventarifas_codigo "+&
		"																		FROM ventarifas_precios_packs C2 "+&
		"																		WHERE C2.articulos_codigo = ART.codigo "+&
		"																		AND C2.empresa = ART.empresa "+&
		"																		AND C2.ventarifas_codigo <> '5'  "+&
		"																		AND C2.calidades_codigo = '1' "+&
		"																		ORDER BY C2.precio ASC) "+&
		"																		OR ventarifas_precios_packs.ventarifas_codigo IS NULL)  "+&		
		" 			AND ( ventarifas_precios.calidades_codigo = '1'  OR ventarifas_precios_packs.calidades_codigo = '1' ) "+&			
		" 			AND almacenmovimientos.fecha_mov <=  '"+em_fecha2.text+"' ) AS stock_precio_vta_B "+&
		" , 0 AS coste_A "+&
		" , 0 AS coste_b "+&
" FROM articulos ART "+&
" LEFT OUTER JOIN familias on ART.empresa = familias.empresa and ART.familia = familias.codigo "+&
" LEFT OUTER JOIN marcas on ART.empresa = marcas.empresa and ART.marcas_codigo = marcas.codigo "+&
" LEFT OUTER JOIN submarcas on ART.empresa = submarcas.empresa and ART.submarcas_codigo = submarcas.codigo "+&
" INNER JOIN formatos on ART.empresa = formatos.empresa and ART.formato = formatos.codigo "+&
" INNER JOIN almacenmovimientos on ART.empresa = almacenmovimientos.empresa and almacenmovimientos.articulo = ART.codigo "+&
" INNER JOIN almusos on ART.empresa = almusos.empresa and almusos.codigo = ART.uso "+&
" INNER JOIN art_codestadistico on ART.empresa = art_codestadistico.empresa and ART.codigo = art_codestadistico.codigo "+&
" WHERE "+filtro_promocion+&
" 	  AND  fecha_mov <= '"+em_fecha2.text+"' "+&
" 	  AND  "+restriccion_sin_familia+&
" 	  AND  ( art_codestadistico.g2  <> 'N' or art_codestadistico.g2 is null)  "+&
" GROUP BY ART.uso, "+&
"			almusos.descripcion,  "+&
"			ART.empresa,  "+&
" 			ART.familia,  "+&
" 			familias.descripcion,  "+&
" 			ART.marcas_codigo,  "+&
" 			marcas.descripcion,  "+&
" 			ART.submarcas_codigo,  "+&
" 			submarcas.descripcion,  "+&
" 			ART.codigo,  "+&
" 			ART.descripcion, "+& 
" 			formatos.ancho,  "+&
" 			formatos.largo, "+&
" 			ART.unidad "+&
" 	HAVING (isnull (sum( CASE WHEN almacenmovimientos.fecha_mov <= '"+em_fecha1.text+"'  "+&
" 	 					  		THEN  almacenmovimientos.cantidade - almacenmovimientos.cantidads "+&
" 						  		ELSE 0 END), 0 )  <> 0 or isnull ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads), 0 )  <> 0 )"+&
" 	ORDER BY familias.descripcion,marcas.descripcion, submarcas.descripcion,ART.descripcion  desc "



st_mensaje.text = "Calculando Stocks ... "

f_cargar_cursor_nuevo (sel, consulta)

dw_datos.object.data = consulta.object.data
dw_datos.Sort()
dw_datos.GroupCalc()

if cbx_coste.checked then
	total_regs = dw_datos.RowCount()

	for i = 1 to total_regs
		articulo = dw_datos.object.cod_articulo[i]
		piezas_a = dw_datos.object.stock_piezas_A[i]
		piezas_b = dw_datos.object.stock_piezas_B[i]
		coste_mp = 0
		coste_fab = 0
		coste_packing = 0
		coste_compras = 0
		


		coste_historico =  ftc_calculo_coste_articulo_hist ( codigo_empresa, articulo, 1, fecha1, coste_fab, coste_mp, coste_packing, coste_compras)

		dw_datos.object.coste_a[i] = piezas_a * coste_historico

		f_calculo_coste_articulo_mp_fab_packing_compras(codigo_empresa, articulo, coste_mp, coste_fab, mermas, coste_packing, coste_compras )

		dw_datos.object.coste_b[i] = piezas_b * ( coste_mp + coste_fab + coste_compras + coste_packing )

		ahora = now()

		if mod (i, 10 ) = 0 then
			fin = Relativetime (inicio, ( SecondsAfter ( inicio, ahora ) / i ) * total_regs)
		end if
		st_mensaje.text = string(i)+" de "+string(total_regs)+"           Inicio: "+String(Inicio)+"   Fin"+String(fin)
		if mod (i, 10 ) = 0 then
			parent.SetRedraw(true)
		end if
		
	next
end if
destroy consulta
st_mensaje.visible = false

// Total facturado
v_total_facturado = f_total_facturado_entre_fechas (codigo_empresa, datetime(RelativeDate(date(fecha1), 1)), fecha2)
v_albaranes_pendientes = f_albaranes_pendientes (codigo_empresa, fecha2)

dw_datos.object.t_total_albaranes.text = string(v_albaranes_pendientes, "###,###,##0")
dw_datos.object.t_total_facturas.text = string(v_total_facturado, "###,###,##0")
dw_datos.object.t_alb_mas_fac.text = string (v_total_facturado + v_albaranes_pendientes, "###,###,##0")

dw_datos.object.alb_fac_var_pvp.text = string (v_total_facturado + v_albaranes_pendientes + dw_datos.object.total_var_precio_vta[1], "###,###,##0" )
dw_datos.object.alb_fac_var_coste_fab.text = string (v_total_facturado + v_albaranes_pendientes + dw_datos.object.total_var_coste_fab[1], "###,###,##0" )

end event

type dw_datos from datawindow within w_con_variacion_stock_coste_fabricacion
integer x = 14
integer y = 268
integer width = 5019
integer height = 3140
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_valor_stock_y_produccion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type cb_1 from commandbutton within w_con_variacion_stock_coste_fabricacion
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

type sle_art from singlelineedit within w_con_variacion_stock_coste_fabricacion
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

type pb_3 from upb_imprimir within w_con_variacion_stock_coste_fabricacion
integer x = 4727
integer y = 136
integer taborder = 70
boolean bringtotop = true
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_datos)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type ddlb_promocion from dropdownlistbox within w_con_variacion_stock_coste_fabricacion
integer x = 3387
integer y = 140
integer width = 878
integer height = 260
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Georgia"
boolean sorted = false
string item[] = {"Stock sin Promoción","Stock sólo Promoción"}
borderstyle borderstyle = stylelowered!
end type

type cbx_art_sin_familia from checkbox within w_con_variacion_stock_coste_fabricacion
integer x = 2231
integer y = 156
integer width = 823
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Art. sin familia"
end type

