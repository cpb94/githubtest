$PBExportHeader$w_precio_liquidacion.srw
forward
global type w_precio_liquidacion from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_precio_liquidacion
end type
type dw_1 from datawindow within w_precio_liquidacion
end type
type cb_1 from u_boton within w_precio_liquidacion
end type
type pb_1 from upb_salir within w_precio_liquidacion
end type
type gb_5 from groupbox within w_precio_liquidacion
end type
type uo_articulo from u_em_campo_2 within w_precio_liquidacion
end type
type uo_familia from u_em_campo_2 within w_precio_liquidacion
end type
type uo_tarifa from u_em_campo_2 within w_precio_liquidacion
end type
type ddlb_liquidado from dropdownlistbox within w_precio_liquidacion
end type
type uo_submarca from u_em_campo_2 within w_precio_liquidacion
end type
type cb_exportar from u_boton within w_precio_liquidacion
end type
type dw_export_excel from datawindow within w_precio_liquidacion
end type
type gb_6 from groupbox within w_precio_liquidacion
end type
type gb_3 from groupbox within w_precio_liquidacion
end type
type gb_4 from groupbox within w_precio_liquidacion
end type
type gb_8 from groupbox within w_precio_liquidacion
end type
type gb_excel from groupbox within w_precio_liquidacion
end type
end forward

global type w_precio_liquidacion from w_int_con_empresa
integer width = 6391
integer height = 4016
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_familia uo_familia
uo_tarifa uo_tarifa
ddlb_liquidado ddlb_liquidado
uo_submarca uo_submarca
cb_exportar cb_exportar
dw_export_excel dw_export_excel
gb_6 gb_6
gb_3 gb_3
gb_4 gb_4
gb_8 gb_8
gb_excel gb_excel
end type
global w_precio_liquidacion w_precio_liquidacion

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);
string articulo, familia, tarifa,consulta, submarca, liquidacion

long i

datastore registros


if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

if ddlb_liquidado.text = 'S' then
	liquidacion = " AND almartcal.fecha_liquidacion is not null"
elseif ddlb_liquidado.text = 'N' then
	liquidacion = " AND almartcal.fecha_liquidacion is null"
else
	liquidacion = " "
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

if uo_tarifa.em_codigo.text = "" or isnull(uo_tarifa.em_codigo.text) then
	tarifa = "%"
else
	tarifa = uo_tarifa.em_codigo.text
end if

/*

consulta = "SELECT    "+&
"         venlintarifas.articulo , "+&
"         articulos.descripcion, "+&
"         venlintarifas.formato ,  "+&
"		 venlintarifas.calidad, "+&
"		 calidades.descripcion, "+&
"         formatos.descripcion , "+&
"         isnull( CASE "+&
"		WHEN formatos.ancho * formatos.largo = 0 "+&
"		THEN 0 "+&
"		ELSE "+&
"			 ( isnull(articulos_coste.coste_acum_mp, 0) "+&
"			  + isnull(articulos_coste.coste_acum_fab, 0) "+&
"			  + isnull(articulos_coste.coste_acum_packing, 0) "+&  
"			  + isnull(articulos_coste.coste_acum_compras, 0) ) * ( 1 / ( formatos.ancho * formatos.largo  / 10000 ) ) "+&
"		END , 0) AS coste, "+&
"         venlintarifas.tarifa , "+&
"         ventarifas.descripcion , "+&
"         venlintarifas.precio ,   "+&
" 		 isnull(sum(  alm_bultos_lineas.cantidad * formatos.ancho * formatos.largo / 10000),0)  as stock_m2, "+&
"		 isnull(articulos.porcentaje_dotacion,0) as articulos_porcentaje_dotacion, "+&
"         almartcal.fecha_liquidacion , "+&
"		 isnull(almartcal.porcentaje_liquidacion,0) as almartcal_porcentaje_liquidacion, "+&
 "		 isnull(almartcal.precio_liquidacion,0) as almartcal_precio_liquidacion  "+&
" FROM venlintarifas  "+&
" LEFT JOIN articulos ON venlintarifas.empresa = articulos.empresa AND venlintarifas.articulo  = articulos.codigo "+&
" LEFT JOIN formatos ON venlintarifas.empresa = formatos.empresa AND venlintarifas.formato  = formatos.codigo "+&
" LEFT JOIN ventarifas ON venlintarifas.empresa = ventarifas.empresa AND venlintarifas.tarifa = ventarifas.codigo "+&
" LEFT JOIN articulos_coste on venlintarifas.empresa = articulos_coste.empresa and venlintarifas.articulo = articulos_coste.articulo "+&
" LEFT JOIN alm_bultos_lineas on venlintarifas.empresa =  alm_bultos_lineas.empresa and venlintarifas.articulo = alm_bultos_lineas.articulo and venlintarifas.calidad = alm_bultos_lineas.calidad "+&
" LEFT JOIN calidades on venlintarifas.empresa = calidades.empresa and venlintarifas.calidad = calidades.codigo "+&
" LEFT JOIN almartcal on venlintarifas.empresa = almartcal.empresa and venlintarifas.articulo = almartcal.articulo and venlintarifas.calidad = almartcal.calidad "+&
" WHERE ( venlintarifas.empresa = '"+codigo_empresa+"' ) AND  "+&
"      ( venlintarifas.listar = 'S' ) AND "+&
"      ( isnull(articulos_coste.fecha,0) = isnull((select max(fecha) "+& 
"								from articulos_coste "+&
"								where articulos_coste.empresa = venlintarifas.empresa and articulos_coste.articulo = venlintarifas.articulo ),0)	) AND "+&
"	  ( isnull(venlintarifas.articulo,0) like '"+articulo+"') AND "+&
"     ( isnull(venlintarifas.tarifa,0) <> '5' ) AND " +&
"	  ( isnull(venlintarifas.tarifa,0) like '"+tarifa+"' ) AND "+&
"	  ( isnull(articulos.familia,0) like '"+familia+"' ) AND "+&
"	  ( isnull(articulos.submarcas_codigo,0) like '"+submarca+"') "+&
+liquidacion+&
" group by  venlintarifas.articulo ,articulos.descripcion, venlintarifas.calidad, calidades.descripcion, "+&
" venlintarifas.formato ,formatos.descripcion ,venlintarifas.tarifa , ventarifas.descripcion , venlintarifas.precio , "+&
" articulos.porcentaje_dotacion, "+&
" almartcal.fecha_liquidacion ,almartcal.porcentaje_liquidacion, almartcal.precio_liquidacion "+&
" ,formatos.ancho , formatos.largo , articulos_coste.coste_acum_mp , articulos_coste.coste_acum_fab "+&
" ,articulos_coste.coste_acum_packing , articulos_coste.coste_acum_compras "+&
" order by convert (integer,venlintarifas.articulo) " 

*/

consulta = "SELECT    "+&
"         ventarifas_precios.articulos_codigo , "+&
"         articulos.descripcion, "+&
"         articulos.formato, "+&
"         formatos.descripcion , "+&
"		 ventarifas_precios.calidades_codigo, "+&
"		 calidades.descripcion, "+&
"         isnull( CASE "+&
"		WHEN formatos.ancho * formatos.largo = 0 "+&
"		THEN 0 "+&
"		ELSE "+&
"			 ( isnull(articulos_coste.coste_acum_mp, 0) "+&
"			  + isnull(articulos_coste.coste_acum_fab, 0) "+&
"			  + isnull(articulos_coste.coste_acum_packing, 0)   "+&
"			  + isnull(articulos_coste.coste_acum_compras, 0) ) * ( 1 / ( formatos.ancho * formatos.largo  / 10000 ) ) "+&
"		END , 0) AS coste, "+&
"         ventarifas_precios.ventarifas_codigo , "+&
"         ventarifas.descripcion , "+&
"         ventarifas_precios.precio ,   "+&
" 		 isnull(sum(  alm_bultos_lineas.cantidad * formatos.ancho * formatos.largo / 10000),0)  as stock_m2, "+&
"		 isnull(articulos.porcentaje_dotacion,0) as articulos_porcentaje_dotacion, "+&
"         almartcal.fecha_liquidacion , "+&
"		 isnull(almartcal.porcentaje_liquidacion,0) as almartcal_porcentaje_liquidacion, "+&
" 		 isnull(almartcal.precio_liquidacion,0) as almartcal_precio_liquidacion  "+&
" FROM ventarifas_precios "+&
" LEFT JOIN articulos ON ventarifas_precios.empresa = articulos.empresa AND ventarifas_precios.articulos_codigo  = articulos.codigo "+&
" LEFT JOIN formatos ON ventarifas_precios.empresa = formatos.empresa AND articulos.formato  = formatos.codigo "+&
" LEFT JOIN ventarifas ON ventarifas_precios.empresa = ventarifas.empresa AND ventarifas_precios.ventarifas_codigo = ventarifas.codigo "+&
" LEFT JOIN articulos_coste on ventarifas_precios.empresa = articulos_coste.empresa and ventarifas_precios.articulos_codigo = articulos_coste.articulo "+&
" LEFT JOIN alm_bultos_lineas on ventarifas_precios.empresa =  alm_bultos_lineas.empresa and ventarifas_precios.articulos_codigo = alm_bultos_lineas.articulo and ventarifas_precios.calidades_codigo = alm_bultos_lineas.calidad "+&
" LEFT JOIN calidades on ventarifas_precios.empresa = calidades.empresa and ventarifas_precios.calidades_codigo = calidades.codigo "+&
" LEFT JOIN almartcal on ventarifas_precios.empresa = almartcal.empresa and ventarifas_precios.articulos_codigo = almartcal.articulo and ventarifas_precios.calidades_codigo = almartcal.calidad "+&
" WHERE ( ventarifas_precios.empresa = '1' ) AND  "+&
"      ( isnull(articulos_coste.fecha,0) = isnull((select max(fecha)  "+&
"								from articulos_coste "+&
"								where articulos_coste.empresa = ventarifas_precios.empresa and articulos_coste.articulo = ventarifas_precios.articulos_codigo ),0)	) AND "+&
"	  ( isnull(ventarifas_precios.articulos_codigo,0) like '"+articulo+"') AND "+&
"     ( isnull(ventarifas_precios.ventarifas_codigo,0) <> '5' ) AND  "+&
"	  ( isnull(ventarifas_precios.ventarifas_codigo,0) like '"+tarifa+"' ) AND "+&
"	  ( isnull(articulos.familia,0) like '"+familia+"' ) AND "+&
"	  ( isnull(articulos.submarcas_codigo,0) like '"+submarca+"') AND "+&
"	  ventarifas_precios.ventarifas_activa = ventarifas.activa  "+&
 +liquidacion+&
" group by  ventarifas_precios.articulos_codigo ,articulos.descripcion, ventarifas_precios.calidades_codigo, calidades.descripcion, "+&
" articulos.formato ,formatos.descripcion ,ventarifas_precios.ventarifas_codigo , ventarifas.descripcion , ventarifas_precios.precio , "+&
" articulos.porcentaje_dotacion, "+&
" almartcal.fecha_liquidacion ,almartcal.porcentaje_liquidacion, almartcal.precio_liquidacion "+&
" ,formatos.ancho , formatos.largo , articulos_coste.coste_acum_mp , articulos_coste.coste_acum_fab "+&
" ,articulos_coste.coste_acum_packing , articulos_coste.coste_acum_compras "+&
"order by convert (integer,ventarifas_precios.articulos_codigo)  "



dw_1.reset()

f_cargar_cursor_nuevo (consulta, registros)


/*

if registros.rowcount() > 0 then
	dw_1.object.data = registros.object.data
end if

*/

//LO HE HECHO ASÍ PORQUE DE LA FORMA DE ARRIBA NO FUNCIONABA	

for i=1 to registros.rowcount()
	
	dw_1.object.articulo[i] = registros.object.ventarifas_precios_articulos_codigo[i]
	dw_1.object.articulo_des[i] = registros.object. articulos_descripcion[i]
	dw_1.object.formato[i] = registros.object. articulos_formato[i]
	dw_1.object.formato_des[i] = registros.object.formatos_descripcion[i]
	dw_1.object.calidad[i] = registros.object.ventarifas_precios_calidades_codigo[i]
	dw_1.object.calidad_des[i] = registros.object.calidades_descripcion[i]
	dw_1.object.coste[i] = registros.object.coste[i]
	dw_1.object.tarifa[i] = registros.object.  ventarifas_precios_ventarifas_codigo[i]
	dw_1.object.tarifa_des[i] = registros.object.ventarifas_descripcion[i]
	dw_1.object.precio[i] = registros.object.ventarifas_precios_precio[i]
	dw_1.object.stock_m2[i] = registros.object.stock_m2[i]
	dw_1.object.porcentaje_dotacion[i] = registros.object.articulos_porcentaje_dotacion[i]
	dw_1.object.fecha_liquidacion[i] = registros.object.almartcal_fecha_liquidacion[i]
	dw_1.object.porcentaje_liquidacion[i] = registros.object.almartcal_porcentaje_liquidacion[i]
	dw_1.object.precio_liquidacion[i] = registros.object.almartcal_precio_liquidacion[i]
	
NEXT 

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

destroy registros









end subroutine

on w_precio_liquidacion.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_familia=create uo_familia
this.uo_tarifa=create uo_tarifa
this.ddlb_liquidado=create ddlb_liquidado
this.uo_submarca=create uo_submarca
this.cb_exportar=create cb_exportar
this.dw_export_excel=create dw_export_excel
this.gb_6=create gb_6
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_8=create gb_8
this.gb_excel=create gb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.uo_familia
this.Control[iCurrent+8]=this.uo_tarifa
this.Control[iCurrent+9]=this.ddlb_liquidado
this.Control[iCurrent+10]=this.uo_submarca
this.Control[iCurrent+11]=this.cb_exportar
this.Control[iCurrent+12]=this.dw_export_excel
this.Control[iCurrent+13]=this.gb_6
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_4
this.Control[iCurrent+16]=this.gb_8
this.Control[iCurrent+17]=this.gb_excel
end on

on w_precio_liquidacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_familia)
destroy(this.uo_tarifa)
destroy(this.ddlb_liquidado)
destroy(this.uo_submarca)
destroy(this.cb_exportar)
destroy(this.dw_export_excel)
destroy(this.gb_6)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_8)
destroy(this.gb_excel)
end on

event open;call super::open;integer permiso
string hoy
date fecha_utilizada


istr_parametros.s_titulo_ventana =   "Consulta Stock en liquidación"
istr_parametros.s_listado        =   "dw_precio_liquidacion"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()



uo_tarifa.em_codigo.text = "120"
uo_tarifa.triggerevent("modificado")
ddlb_liquidado.text = "S"


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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_precio_liquidacion
integer x = 2313
integer y = 2232
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_precio_liquidacion
boolean visible = false
integer x = 1253
integer y = 1752
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within w_precio_liquidacion
integer x = 37
integer y = 8
integer width = 4997
integer textsize = -9
end type

type pb_imprimir from upb_imprimir within w_precio_liquidacion
event clicked pbm_bnclicked
integer x = 5682
integer y = 224
integer width = 119
integer height = 112
integer taborder = 0
boolean originalsize = false
string powertiptext = "Imprimir"
end type

event clicked;//Parent.triggerEvent("ue_listar")
String new_sql
if dw_1.rowcount() > 0 then
	f_imprimir_datawindow(dw_1)
end if
end event

type dw_1 from datawindow within w_precio_liquidacion
integer x = 27
integer y = 360
integer width = 6295
integer height = 3464
string dataobject = "dw_precio_liquidacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string filtro
long fila_seleccionada



filtro = ""

fila_seleccionada = dw_1.getselectedrow(0)

if fila_seleccionada <> 0 then
	
	dw_1.selectrow(fila_seleccionada,false)
	
end if

if row <> 0 then

	dw_1.selectrow(row,true)
	
end if


choose case dwo.name
		

	case "articulo_t"
		
		filtro = "articulo_des asc"
		
	case "formato_t"
		
		filtro = "formato asc"
		
	case "coste_t"
		
		filtro = "coste desc"
		
	case "precio_t"
		
		filtro = "precio desc"
		
	case "fecha_liquidacion_t"
		
		filtro = "fecha_liquidacion desc"
		
	case "porcentaje_liquidacion_t"
		
		filtro = "porcentaje_liquidacion desc"
		
	case "precio_liquidacion_t"
		
		filtro = "precio_liquidacion desc"
		
	case "tarifa_t"
		
		filtro = "tarifa_des asc"
		
	case "stock_m2_t"
		
		filtro = "stock_m2 desc"
		
	case "porcentaje_dotacion_t"
		
		filtro = "porcentaje_dotacion desc"
				
		
end choose


this.setsort(filtro)

this.sort()

end event

event itemchanged;decimal valor, porcentaje_liquidacion, precio_liquidacion
string articulo, calidad
datetime fecha_liquidacion


valor = dec(data)

if dwo.name = "porcentaje_liquidacion" and (not isnull(data) or data <> "")   then
	
	precio_liquidacion = (dw_1.object.precio[row] * (100-valor)) / 100
	dw_1.object.precio_liquidacion[row] = precio_liquidacion
	dw_1.object.porcentaje_liquidacion[row] = valor
	//if isnull(dw_1.object.fecha_liquidacion[row]) then
	if isnull(dw_1.object.fecha_liquidacion[row]) and valor <> 0 then
		dw_1.object.fecha_liquidacion[row] = date(today())
	end if
end if

if dwo.name = "precio_liquidacion" and (not isnull(data) or data <> "") then
	
	porcentaje_liquidacion =  100 - ((valor / dw_1.object.precio[row] ) * 100 )
	dw_1.object.porcentaje_liquidacion[row] = porcentaje_liquidacion
	dw_1.object.precio_liquidacion[row] = valor
	//if isnull(dw_1.object.fecha_liquidacion[row]) then
	if isnull(dw_1.object.fecha_liquidacion[row]) and valor <> 0 then	
		dw_1.object.fecha_liquidacion[row] = date(today())
	end if
end if

dw_1.accepttext()

articulo = dw_1.object.articulo[row]

porcentaje_liquidacion = dw_1.object.porcentaje_liquidacion[row]

fecha_liquidacion = dw_1.object.fecha_liquidacion[row]

precio_liquidacion = dw_1.object.precio_liquidacion[row]

calidad = dw_1.object.calidad[row]

//update articulos set porcentaje_liquidacion = :porcentaje_liquidacion, fecha_liquidacion = :fecha_liquidacion where empresa = :codigo_empresa and codigo = :articulo using SQLCA;

update almartcal set porcentaje_liquidacion = :porcentaje_liquidacion, fecha_liquidacion = :fecha_liquidacion, precio_liquidacion = :precio_liquidacion where empresa = :codigo_empresa and articulo = :articulo and calidad =:calidad using SQLCA;


if SQLCA.sqlcode <> 0 then
	rollback;
	messagebox("Error","Ha habido un problema al introducir el registro en la base de datos")
else
	commit;	
end if
end event

type cb_1 from u_boton within w_precio_liquidacion
integer x = 5957
integer y = 240
integer width = 361
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_precio_liquidacion
integer x = 5806
integer y = 224
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_precio_liquidacion
integer x = 23
integer y = 172
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

type uo_articulo from u_em_campo_2 within w_precio_liquidacion
event destroy ( )
integer x = 37
integer y = 228
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

type uo_familia from u_em_campo_2 within w_precio_liquidacion
event destroy ( )
integer x = 2304
integer y = 228
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

type uo_tarifa from u_em_campo_2 within w_precio_liquidacion
event destroy ( )
integer x = 1152
integer y = 228
integer width = 635
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;this.em_campo.text=f_nombre_ventarifa(codigo_empresa,this.em_codigo.text)
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tarifas"
ue_datawindow = "dw_ayuda_ventarifas"
ue_filtro     = ""

end event

type ddlb_liquidado from dropdownlistbox within w_precio_liquidacion
integer x = 1874
integer y = 220
integer width = 352
integer height = 348
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

type uo_submarca from u_em_campo_2 within w_precio_liquidacion
event destroy ( )
integer x = 2816
integer y = 228
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

type cb_exportar from u_boton within w_precio_liquidacion
integer x = 5303
integer y = 244
integer width = 347
integer height = 84
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;call super::clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_1.rowcount()

if ll_registros > 0 then
	dw_export_excel.reset()
	dw_export_excel.object.data = dw_1.object.data
	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
		uf_save_dw_as_excel(dw_export_excel,ls_ruta_fichero)
		
	end if

//	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
//		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)
//		
//		guardaraexcel2(dw_export_excel,ls_ruta_fichero)
//	end if

end if

end event

type dw_export_excel from datawindow within w_precio_liquidacion
boolean visible = false
integer x = 4430
integer y = 176
integer width = 635
integer height = 112
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Export Excel"
string dataobject = "dw_precio_liquidacion"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within w_precio_liquidacion
integer x = 2286
integer y = 172
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

type gb_3 from groupbox within w_precio_liquidacion
integer x = 1138
integer y = 172
integer width = 658
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tarifa"
end type

type gb_4 from groupbox within w_precio_liquidacion
integer x = 1829
integer y = 164
integer width = 443
integer height = 164
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "En Liquidación"
end type

type gb_8 from groupbox within w_precio_liquidacion
integer x = 2798
integer y = 172
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

type gb_excel from groupbox within w_precio_liquidacion
integer x = 5294
integer y = 200
integer width = 366
integer height = 136
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Excel"
end type

