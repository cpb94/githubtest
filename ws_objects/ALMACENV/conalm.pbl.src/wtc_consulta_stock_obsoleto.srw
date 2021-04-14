$PBExportHeader$wtc_consulta_stock_obsoleto.srw
forward
global type wtc_consulta_stock_obsoleto from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within wtc_consulta_stock_obsoleto
end type
type gb_1 from groupbox within wtc_consulta_stock_obsoleto
end type
type dw_1 from datawindow within wtc_consulta_stock_obsoleto
end type
type cb_1 from u_boton within wtc_consulta_stock_obsoleto
end type
type pb_1 from upb_salir within wtc_consulta_stock_obsoleto
end type
type gb_5 from groupbox within wtc_consulta_stock_obsoleto
end type
type uo_articulo from u_em_campo_2 within wtc_consulta_stock_obsoleto
end type
type uo_familia from u_em_campo_2 within wtc_consulta_stock_obsoleto
end type
type em_alta from u_em_campo within wtc_consulta_stock_obsoleto
end type
type uo_uso from u_em_campo_2 within wtc_consulta_stock_obsoleto
end type
type ddlb_promocion from dropdownlistbox within wtc_consulta_stock_obsoleto
end type
type ddlb_factura from dropdownlistbox within wtc_consulta_stock_obsoleto
end type
type st_1 from statictext within wtc_consulta_stock_obsoleto
end type
type sle_meses_m2 from singlelineedit within wtc_consulta_stock_obsoleto
end type
type ddlb_unidad from dropdownlistbox within wtc_consulta_stock_obsoleto
end type
type uo_submarca from u_em_campo_2 within wtc_consulta_stock_obsoleto
end type
type pb_excel from upb_imprimir within wtc_consulta_stock_obsoleto
end type
type ddlb_dotacion from dropdownlistbox within wtc_consulta_stock_obsoleto
end type
type em_liquidacion_desde from u_em_campo within wtc_consulta_stock_obsoleto
end type
type em_dotacion_desde from u_em_campo within wtc_consulta_stock_obsoleto
end type
type em_liquidacion_hasta from u_em_campo within wtc_consulta_stock_obsoleto
end type
type em_dotacion_hasta from u_em_campo within wtc_consulta_stock_obsoleto
end type
type gb_6 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_2 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_3 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_4 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_7 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_8 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_9 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_10 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_11 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_12 from groupbox within wtc_consulta_stock_obsoleto
end type
type gb_13 from groupbox within wtc_consulta_stock_obsoleto
end type
end forward

global type wtc_consulta_stock_obsoleto from w_int_con_empresa
integer width = 6222
integer height = 4064
pb_imprimir pb_imprimir
gb_1 gb_1
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_familia uo_familia
em_alta em_alta
uo_uso uo_uso
ddlb_promocion ddlb_promocion
ddlb_factura ddlb_factura
st_1 st_1
sle_meses_m2 sle_meses_m2
ddlb_unidad ddlb_unidad
uo_submarca uo_submarca
pb_excel pb_excel
ddlb_dotacion ddlb_dotacion
em_liquidacion_desde em_liquidacion_desde
em_dotacion_desde em_dotacion_desde
em_liquidacion_hasta em_liquidacion_hasta
em_dotacion_hasta em_dotacion_hasta
gb_6 gb_6
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
gb_10 gb_10
gb_11 gb_11
gb_12 gb_12
gb_13 gb_13
end type
global wtc_consulta_stock_obsoleto wtc_consulta_stock_obsoleto

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);
string articulo, familia, uso, promocion, meses, hoy, consulta, meses_stock, unidad, submarca, dotacion, filtro_dotacion_desde, filtro_dotacion_hasta, filtro_liquidacion_desde, filtro_liquidacion_hasta
date  fecha_alta, fecha_factura, fecha_dotacion_desde, fecha_dotacion_hasta,fecha_liquidacion_desde, fecha_liquidacion_hasta
integer periodo_facturacion
datastore registros


if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if


if uo_submarca.em_codigo.text = "" or isnull(uo_submarca.em_codigo.text) then
	submarca = "%"
else
	submarca = uo_submarca.em_codigo.text
end if

if uo_familia.em_codigo.text = "" or isnull(uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

if uo_uso.em_codigo.text = "" or isnull(uo_uso.em_codigo.text) then
	uso = "%"
else
	uso = uo_uso.em_codigo.text
end if

if ddlb_promocion.text = "Todos" then
	promocion = "%"
else
	promocion = ddlb_promocion.text
end if

choose case ddlb_unidad.text
	
	case "Piezas" 
		
		unidad = "0"
		
	case "Metros"
		
		unidad = "1"
		
	case else
		
		unidad = "%"
	
end choose

choose case ddlb_dotacion.text
		
	case "Todos"
		
		dotacion = " and isnull(articulos.porcentaje_dotacion,0) like '%' "
		
	case "Dotados"
		
		dotacion = " and isnull(porcentaje_dotacion,0) > 0 "
		
	case "No dotados"
		
		dotacion = " and porcentaje_dotacion is null "
		
		
end choose

meses = ddlb_factura.text

periodo_facturacion = integer(meses)

fecha_alta = date(em_alta.text)

hoy = string(date(today()))

select dateadd(month,-:periodo_facturacion,:hoy) as date into :fecha_factura from empresas where empresa = :codigo_empresa using SQLCA;

//CONTROLES DE FECHAS

if em_dotacion_desde.text = "" or isnull(em_dotacion_desde.text) or em_dotacion_desde.text = "00-00-00" then
	filtro_dotacion_desde = ""
else
	fecha_dotacion_desde = date(em_dotacion_desde.text)
	filtro_dotacion_desde = " and articulos.fecha_dotacion >= '"+string(fecha_dotacion_desde)+"' "
end if

if em_dotacion_hasta.text = "" or isnull(em_dotacion_hasta.text) or em_dotacion_hasta.text = "00-00-00" then
	filtro_dotacion_hasta = ""
else
	fecha_dotacion_hasta = date(em_dotacion_hasta.text)
	filtro_dotacion_hasta = " and articulos.fecha_dotacion <= '"+string(fecha_dotacion_hasta)+"' "
end if

if em_liquidacion_desde.text = "" or isnull(em_liquidacion_desde.text) or em_liquidacion_desde.text = "00-00-00" then
	filtro_liquidacion_desde = ""
else
	fecha_liquidacion_desde = date(em_liquidacion_desde.text)
	filtro_liquidacion_desde = " and articulos.fecha_liquidacion >= '"+string(fecha_liquidacion_desde)+"' "
end if

if em_liquidacion_hasta.text = "" or isnull(em_liquidacion_hasta.text) or em_liquidacion_hasta.text = "00-00-00" then
	filtro_liquidacion_hasta = ""
else
	fecha_liquidacion_hasta = date(em_liquidacion_hasta.text)
	filtro_liquidacion_hasta = " and articulos.fecha_liquidacion <= '"+string(fecha_liquidacion_hasta)+"' "
end if


consulta = " select articulos.codigo as articulo "+&
" , articulos.descripcion as articulo_des "+&
" , F.abreviado as formato "+&
" , isnull( ( select sum ( ( venlifac.neto - venlifac.impdtopp ) / venlifac.cambio ) 	"+&
"	from venlifac "+&
"	where articulos.empresa = venlifac.empresa and articulos.codigo = venlifac.articulo "+&
"	and venlifac.ffactura >= '"+string(fecha_factura)+"' ), 0 ) as ventas "+&
" ,isnull( CASE "+&
"	WHEN F.ancho * F.largo = 0 "+&
"	THEN 0 "+&
"	ELSE "+&
"		 ( isnull(articulos_coste.coste_acum_mp, 0) "+&
"		  + isnull(articulos_coste.coste_acum_fab, 0) "+&
"		  + isnull(articulos_coste.coste_acum_packing, 0) "+& 
"		  + isnull(articulos_coste.coste_acum_compras, 0) ) * ( 1 / ( F.ancho * F.largo  / 10000 ) ) "+&
"	END , 0) AS coste_por_M2 "+&
" , isnull (( select 	( CASE articulos.unidad "+& 			
"				WHEN '1' 	"+&		
"				THEN sum(venlifac.cantidad) "+&
"				WHEN '0' "+&
"				THEN sum(venlifac.cantidad) * ( F.ancho * F.largo  / 10000 ) "+&
"			END ) "+&
"	from venlifac "+&
"	where articulos.empresa = venlifac.empresa and articulos.codigo = venlifac.articulo "+&
"	and venlifac.ffactura >= '"+string(fecha_factura)+"' ) , 0 ) as m2_vendidos "+&
" , isnull( ( select ( CASE articulos.unidad "+&
"				WHEN '1' "+&
"				then sum(venlifac.cantidad) / "+meses+" "+&
"				WHEN '0' "+&
"				THEN (sum(venlifac.cantidad) * (F.ancho * F.largo / 10000 )) / "+meses+" "+&
"			END ) "+&
"	from venlifac "+&
"	where articulos.empresa = venlifac.empresa and articulos.codigo = venlifac.articulo "+&
"	and venlifac.ffactura >= '"+string(fecha_factura)+"' ), 0 ) as m2_mes "+&
" , sum(  alm_bultos_lineas.cantidad * F.ancho * F.largo / 10000)  as m2_stock "+&
" , isnull( articulos.porcentaje_dotacion,0.0) "+&
" , articulos.fecha_liquidacion "+&
" , articulos.fecha_dotacion "+&
" from articulos "+&
" INNER JOIN articulos_coste on articulos.empresa = articulos_coste.empresa and articulos.codigo = articulos_coste.articulo  "+&
" inner join alm_bultos_lineas on articulos.empresa =  alm_bultos_lineas.empresa and articulos.codigo = alm_bultos_lineas.articulo "+&	 
" inner join formatos as F on articulos.empresa = F.empresa  and articulos.formato = F.codigo  "+&				 
" where alm_bultos_lineas.articulo = articulos.codigo and alm_bultos_lineas.empresa = '"+codigo_empresa+"' "+&  	
" and articulos_coste.fecha = (	select max(fecha) "+&
"								from articulos_coste "+&
"								where articulos_coste.empresa = articulos.empresa and articulos_coste.articulo = articulos.codigo )	"+&
" and articulos.promocion like '"+promocion+"' "+&
" and articulos.uso like '"+uso+"' "+&
" and articulos.familia like '"+familia+"' "+&	
" and articulos.fecha_alta <= '"+string(fecha_alta)+"' "+&
+filtro_liquidacion_desde+&
+filtro_liquidacion_hasta+&
+filtro_dotacion_desde+&
+filtro_dotacion_hasta+&
" and articulos.fecha_anulado is null	"+&	
" and articulos.unidad like '"+unidad+"' "+&
" and articulos.codigo like '"+articulo+"' "+&
" and articulos.submarcas_codigo like '"+submarca+"' "+&
+dotacion+&
+" group by articulos.empresa "+&
" , articulos.codigo "+&
" , articulos.descripcion "+&
" , F.abreviado "+&
" , F.ancho "+&
" , F.largo "+&
" , articulos.unidad "+&
" , isnull(articulos_coste.coste_acum_mp, 0) "+&
" , isnull(articulos_coste.coste_acum_fab, 0) "+&
" , isnull(articulos_coste.coste_acum_packing, 0) "+&
" , isnull(articulos_coste.coste_acum_compras, 0) "+&
", articulos.porcentaje_dotacion "+&
", articulos.fecha_liquidacion "+&
", articulos.fecha_dotacion "+&
" order by m2_stock desc "



dw_1.reset()

f_cargar_cursor_nuevo (consulta, registros)

if registros.rowcount() > 0 then
	dw_1.object.data = registros.object.data
end if

meses_stock=sle_meses_m2.text

dw_1.setfilter("m2_meses_stock >= "+meses_stock+" ")

dw_1.filter()


if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

destroy registros









end subroutine

on wtc_consulta_stock_obsoleto.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_familia=create uo_familia
this.em_alta=create em_alta
this.uo_uso=create uo_uso
this.ddlb_promocion=create ddlb_promocion
this.ddlb_factura=create ddlb_factura
this.st_1=create st_1
this.sle_meses_m2=create sle_meses_m2
this.ddlb_unidad=create ddlb_unidad
this.uo_submarca=create uo_submarca
this.pb_excel=create pb_excel
this.ddlb_dotacion=create ddlb_dotacion
this.em_liquidacion_desde=create em_liquidacion_desde
this.em_dotacion_desde=create em_dotacion_desde
this.em_liquidacion_hasta=create em_liquidacion_hasta
this.em_dotacion_hasta=create em_dotacion_hasta
this.gb_6=create gb_6
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
this.gb_10=create gb_10
this.gb_11=create gb_11
this.gb_12=create gb_12
this.gb_13=create gb_13
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.uo_familia
this.Control[iCurrent+9]=this.em_alta
this.Control[iCurrent+10]=this.uo_uso
this.Control[iCurrent+11]=this.ddlb_promocion
this.Control[iCurrent+12]=this.ddlb_factura
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.sle_meses_m2
this.Control[iCurrent+15]=this.ddlb_unidad
this.Control[iCurrent+16]=this.uo_submarca
this.Control[iCurrent+17]=this.pb_excel
this.Control[iCurrent+18]=this.ddlb_dotacion
this.Control[iCurrent+19]=this.em_liquidacion_desde
this.Control[iCurrent+20]=this.em_dotacion_desde
this.Control[iCurrent+21]=this.em_liquidacion_hasta
this.Control[iCurrent+22]=this.em_dotacion_hasta
this.Control[iCurrent+23]=this.gb_6
this.Control[iCurrent+24]=this.gb_2
this.Control[iCurrent+25]=this.gb_3
this.Control[iCurrent+26]=this.gb_4
this.Control[iCurrent+27]=this.gb_7
this.Control[iCurrent+28]=this.gb_8
this.Control[iCurrent+29]=this.gb_9
this.Control[iCurrent+30]=this.gb_10
this.Control[iCurrent+31]=this.gb_11
this.Control[iCurrent+32]=this.gb_12
this.Control[iCurrent+33]=this.gb_13
end on

on wtc_consulta_stock_obsoleto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_familia)
destroy(this.em_alta)
destroy(this.uo_uso)
destroy(this.ddlb_promocion)
destroy(this.ddlb_factura)
destroy(this.st_1)
destroy(this.sle_meses_m2)
destroy(this.ddlb_unidad)
destroy(this.uo_submarca)
destroy(this.pb_excel)
destroy(this.ddlb_dotacion)
destroy(this.em_liquidacion_desde)
destroy(this.em_dotacion_desde)
destroy(this.em_liquidacion_hasta)
destroy(this.em_dotacion_hasta)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
destroy(this.gb_10)
destroy(this.gb_11)
destroy(this.gb_12)
destroy(this.gb_13)
end on

event open;call super::open;integer permiso
string hoy
date fecha_utilizada


istr_parametros.s_titulo_ventana =   "Consulta de Costes de obsoltetos"
istr_parametros.s_listado        =   "dwtc_consulta_stock_obsoleto"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

hoy = string(date(today()))

select dateadd(month,-24,:hoy) as date into :fecha_utilizada from empresas where empresa = :codigo_empresa using SQLCA;

em_alta.text = string(fecha_utilizada)

ddlb_factura.text = "24"

uo_familia.em_codigo.text = "2"
uo_familia.triggerevent("modificado")
uo_uso.em_codigo.text = "3"
uo_uso.triggerevent("modificado")
ddlb_promocion.text = "N"
ddlb_unidad.text = "Todas"
ddlb_dotacion.text = "Todos"
sle_meses_m2.text = "0"

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)






end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wtc_consulta_stock_obsoleto
integer x = 2313
integer y = 2232
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wtc_consulta_stock_obsoleto
boolean visible = false
integer x = 1253
integer y = 1752
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within wtc_consulta_stock_obsoleto
integer x = 37
integer y = 8
integer width = 3749
integer textsize = -9
end type

type pb_imprimir from upb_imprimir within wtc_consulta_stock_obsoleto
event clicked pbm_bnclicked
integer x = 5801
integer y = 44
integer width = 119
integer height = 112
integer taborder = 0
boolean originalsize = false
string powertiptext = "Imprimir"
end type

event clicked;//Parent.triggerEvent("ue_listar")


if dw_1.rowcount() > 0 then
	
	f_imprimir_datawindow(dw_1)
	
end if
end event

type gb_1 from groupbox within wtc_consulta_stock_obsoleto
integer x = 2469
integer y = 92
integer width = 457
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo fac >="
end type

type dw_1 from datawindow within wtc_consulta_stock_obsoleto
integer x = 27
integer y = 424
integer width = 6103
integer height = 3424
string dataobject = "dwtc_consulta_stock_obsoleto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event clicked;string filtro


filtro = ""


choose case dwo.name
		
	case "articulo_t"
		
		filtro = "articulo_des asc"
		
	case "formato_t"
		
		filtro = "formato asc"
		
	case "ventas_t"
		
		filtro = "ventas desc"
		
	case "euros_m2_t"
		
		filtro = "euros_m2 desc"
		
	case "euros_pzs_t"
		
		filtro = "euros_pzs desc"
		
	case "coste_en_m2_t"
		
		filtro = "coste_en_m2 desc"
		
	case "coste_x_m2_t"
		
		filtro = "coste_por_m2 desc"
		
	case "coste_en_pzs_t"
		
		filtro = "coste_en_pzs desc"
		
	case "coste_x_pzs_t"
		
		filtro = "coste_por_pzs desc"
		
	case "m2_vendidos_t"
		
		filtro = "m2_vendidos desc"
		
	case "pzs_vendidas_t"
		
		filtro = "pzs_vendidas desc"
		
	case "m2_al_mes_t"
		
		filtro = "m2_mes desc"
		
	case "pzs_al_mes_t"
		
		filtro = "pzs_mes desc"
		
	case "m2_stock_t"
		
		filtro = "m2_stock desc"
		
	case "pzs_stock_t"
		
		filtro = "pzs_stock desc"
		
	case "meses_de_stock_m2_t"
		
		filtro = "m2_meses_stock desc"

	case "meses_de_stock_pzs_t" 
		
		filtro = "pzs_meses_stock desc"
		
	case "porcentaje_dot_t"
		
		filtro = "porcentaje_dotacion desc"
		
	case "precio_liq_t"
		
		filtro = "precio_liq desc"
		
	case "precio_total_liq_t"
		
		filtro = "total_liq desc"
		
	case "fecha_dotacion_t"
		
		filtro = "fecha_dotacion desc"
		
	case "fecha_liquidacion_t"
		
		filtro = "fecha_liquidacion desc"
		
end choose


this.setsort(filtro)

this.sort()

end event

type cb_1 from u_boton within wtc_consulta_stock_obsoleto
integer x = 5678
integer y = 176
integer width = 361
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within wtc_consulta_stock_obsoleto
integer x = 5925
integer y = 44
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within wtc_consulta_stock_obsoleto
integer x = 23
integer y = 96
integer width = 1102
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within wtc_consulta_stock_obsoleto
event destroy ( )
integer x = 37
integer y = 152
integer width = 1074
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type uo_familia from u_em_campo_2 within wtc_consulta_stock_obsoleto
event destroy ( )
integer x = 2962
integer y = 148
integer width = 466
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text=f_nombre_familia(codigo_empresa,this.em_codigo.text)
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type em_alta from u_em_campo within wtc_consulta_stock_obsoleto
integer x = 2002
integer y = 152
integer width = 352
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type uo_uso from u_em_campo_2 within wtc_consulta_stock_obsoleto
event destroy ( )
integer x = 1143
integer y = 152
integer width = 329
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_uso.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;this.em_campo.text=f_nombre_almusos(codigo_empresa,this.em_codigo.text)
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de usos"
ue_datawindow = "dw_ayuda_almusos"
ue_filtro     = ""

end event

type ddlb_promocion from dropdownlistbox within wtc_consulta_stock_obsoleto
integer x = 1573
integer y = 156
integer width = 279
integer height = 356
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string item[] = {"S","N","Todos"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_factura from dropdownlistbox within wtc_consulta_stock_obsoleto
integer x = 2537
integer y = 152
integer width = 311
integer height = 336
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean sorted = false
string item[] = {"6 ","12 ","18 ","24","30 ","36 ","42","48"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within wtc_consulta_stock_obsoleto
integer x = 4347
integer y = 152
integer width = 530
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Meses de stock >="
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_meses_m2 from singlelineedit within wtc_consulta_stock_obsoleto
integer x = 4905
integer y = 136
integer width = 105
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type ddlb_unidad from dropdownlistbox within wtc_consulta_stock_obsoleto
integer x = 3991
integer y = 148
integer width = 311
integer height = 336
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean sorted = false
string item[] = {"Piezas","Metros","Todas"}
borderstyle borderstyle = stylelowered!
end type

type uo_submarca from u_em_campo_2 within wtc_consulta_stock_obsoleto
event destroy ( )
integer x = 3465
integer y = 148
integer width = 466
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_submarca.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion into :descripcion from submarcas where codigo = :this.em_codigo.text and empresa = :codigo_empresa;
this.em_campo.text=descripcion
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de familias"
ue_datawindow = "dw_ayuda_submarcas"
ue_filtro     = ""

end event

type pb_excel from upb_imprimir within wtc_consulta_stock_obsoleto
integer x = 5678
integer y = 44
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "C:\bmp\Export-Excel.bmp"
string powertiptext = "Exportar a Excel"
end type

event clicked;call super::clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_1.rowcount()

if ll_registros > 0 then
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then

		uf_save_dw_as_excel(dw_1,ls_ruta_fichero)
		
	end if

end if

end event

type ddlb_dotacion from dropdownlistbox within wtc_consulta_stock_obsoleto
integer x = 110
integer y = 316
integer width = 311
integer height = 336
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean sorted = false
string item[] = {"Todos","Dotados","No dotados"}
borderstyle borderstyle = stylelowered!
end type

type em_liquidacion_desde from u_em_campo within wtc_consulta_stock_obsoleto
integer x = 613
integer y = 320
integer width = 507
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_dotacion_desde from u_em_campo within wtc_consulta_stock_obsoleto
integer x = 2089
integer y = 320
integer width = 503
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_liquidacion_hasta from u_em_campo within wtc_consulta_stock_obsoleto
integer x = 1321
integer y = 320
integer width = 507
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_dotacion_hasta from u_em_campo within wtc_consulta_stock_obsoleto
integer x = 2743
integer y = 320
integer width = 503
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_6 from groupbox within wtc_consulta_stock_obsoleto
integer x = 2944
integer y = 92
integer width = 489
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Familia"
end type

type gb_2 from groupbox within wtc_consulta_stock_obsoleto
integer x = 1234
integer y = 260
integer width = 695
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha liquidación Hasta"
end type

type gb_3 from groupbox within wtc_consulta_stock_obsoleto
integer x = 1129
integer y = 96
integer width = 366
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Uso"
end type

type gb_4 from groupbox within wtc_consulta_stock_obsoleto
integer x = 1527
integer y = 96
integer width = 375
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Promoción"
end type

type gb_7 from groupbox within wtc_consulta_stock_obsoleto
integer x = 3950
integer y = 92
integer width = 389
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Unidad"
end type

type gb_8 from groupbox within wtc_consulta_stock_obsoleto
integer x = 3447
integer y = 92
integer width = 489
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Colección"
end type

type gb_9 from groupbox within wtc_consulta_stock_obsoleto
integer x = 69
integer y = 260
integer width = 389
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Dotación"
end type

type gb_10 from groupbox within wtc_consulta_stock_obsoleto
integer x = 1920
integer y = 92
integer width = 526
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha alta art  <="
end type

type gb_11 from groupbox within wtc_consulta_stock_obsoleto
integer x = 2011
integer y = 260
integer width = 654
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha dotación Desde"
end type

type gb_12 from groupbox within wtc_consulta_stock_obsoleto
integer x = 512
integer y = 260
integer width = 709
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha liquidación Desde"
end type

type gb_13 from groupbox within wtc_consulta_stock_obsoleto
integer x = 2670
integer y = 260
integer width = 640
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha dotación Hasta"
end type

