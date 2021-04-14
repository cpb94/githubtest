﻿$PBExportHeader$w_mant_venfacprev_cliente.srw
forward
global type w_mant_venfacprev_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_mant_venfacprev_cliente
end type
type pb_2 from upb_imprimir within w_mant_venfacprev_cliente
end type
type em_fechadesde from u_em_campo within w_mant_venfacprev_cliente
end type
type em_fechahasta from u_em_campo within w_mant_venfacprev_cliente
end type
type gb_5 from groupbox within w_mant_venfacprev_cliente
end type
type gb_1 from groupbox within w_mant_venfacprev_cliente
end type
type cb_1 from u_boton within w_mant_venfacprev_cliente
end type
type cb_paises from commandbutton within w_mant_venfacprev_cliente
end type
type gb_3 from groupbox within w_mant_venfacprev_cliente
end type
type uo_cliente from u_em_campo_2 within w_mant_venfacprev_cliente
end type
type em_ejercicio from u_em_campo within w_mant_venfacprev_cliente
end type
type cb_2 from commandbutton within w_mant_venfacprev_cliente
end type
type uo_cliente_anyadir from u_em_campo_2 within w_mant_venfacprev_cliente
end type
type pb_anyadir_pais from picturebutton within w_mant_venfacprev_cliente
end type
type gb_2 from groupbox within w_mant_venfacprev_cliente
end type
type gb_4 from groupbox within w_mant_venfacprev_cliente
end type
type gb_6 from groupbox within w_mant_venfacprev_cliente
end type
type uo_paises from u_marca_lista within w_mant_venfacprev_cliente
end type
type dw_export_excel from datawindow within w_mant_venfacprev_cliente
end type
type dw_detalle from u_datawindow_consultas within w_mant_venfacprev_cliente
end type
type cb_exportar from u_boton within w_mant_venfacprev_cliente
end type
type cb_importar from u_boton within w_mant_venfacprev_cliente
end type
type dw_import_excel from datawindow within w_mant_venfacprev_cliente
end type
type gb_excel from groupbox within w_mant_venfacprev_cliente
end type
end forward

global type w_mant_venfacprev_cliente from w_int_con_empresa
integer width = 4878
integer height = 3912
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_5 gb_5
gb_1 gb_1
cb_1 cb_1
cb_paises cb_paises
gb_3 gb_3
uo_cliente uo_cliente
em_ejercicio em_ejercicio
cb_2 cb_2
uo_cliente_anyadir uo_cliente_anyadir
pb_anyadir_pais pb_anyadir_pais
gb_2 gb_2
gb_4 gb_4
gb_6 gb_6
uo_paises uo_paises
dw_export_excel dw_export_excel
dw_detalle dw_detalle
cb_exportar cb_exportar
cb_importar cb_importar
dw_import_excel dw_import_excel
gb_excel gb_excel
end type
global w_mant_venfacprev_cliente w_mant_venfacprev_cliente

type variables
string grafico = "N",is_sort_inicial,is_texto_t_descripcion,is_texto_t_pzs,is_texto_t_m2,is_texto_t_importe
int ii_grupo_desplegado,ii_max_grupos = 1
end variables

forward prototypes
public subroutine f_anyadir_cliente (datawindow arg_datawindow, string arg_pais)
protected subroutine f_control_m2 (datawindow arg_datawindow)
end prototypes

public subroutine f_anyadir_cliente (datawindow arg_datawindow, string arg_pais);string ls_codigo,ls_filtro,ls_filtro_cliente,ls_filtro_agentes,ls_filtro_pavrev,ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_agente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_indice,ll_total,ll_ejercicio_presupuesto,ll_donde
datetime ldt_fecha_desde,ldt_fecha_hasta

str_venfacprev_cliente istr_venfacprev_cliente

datastore ds_datos

ii_grupo_desplegado = 1

arg_datawindow.setredraw(false)
uo_paises.visible = false

ls_filtro_articulos = " AND     ( articulos.promocion = 'N' ) "

//Filtro de paises

ls_filtro_cliente = " and genter.codigo = '"+arg_pais+"' "

//Fin de filtro de paises

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))
ll_ejercicio_presupuesto = dec(em_ejercicio.text)

ls_sel = "SELECT resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       isnull(sum(resultado.prevision_precio_medio),0) as prevision_precio_medio, ~n"+&
			"       isnull(sum(resultado.m2),0) as m2, ~n"+&
			"       isnull(sum(resultado.importe),0) as importe, ~n"+&
			"       isnull(sum(resultado.prevision_importe),0) as prevision_importe, ~n"+&
			"       case when isnull(sum(resultado.prevision_precio_medio),0) <> 0 then isnull(sum(resultado.prevision_importe),0) / isnull(sum(resultado.prevision_precio_medio),0) else 0 end as prevision_metros, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			"FROM ~n"+&
			"(SELECT isnull(venfac.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(genter.codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  sum(case when venlifac.tipo_unidad  = '1' then isnull(venlifac.cantidad,0) else isnull(venlifac.cantidad * (almartcajas.metroscaja / almartcajas.piezascaja),0) end) as m2, ~n"+&
			"		  convert(dec(16,2),sum((venlifac.neto - venlifac.impdtopp) / venfac.cambio)) as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM venfac, ~n"+&
			"		 venlifac, ~n"+&
			"		 genter, ~n"+&
			"		 paises, ~n"+&
			"		 articulos, ~n"+&
			"		 familias, ~n"+&
			"		 formatos, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas, ~n"+&
			"      art_codestadistico, ~n"+&
			"      almartcajas ~n"+&
			"WHERE ( venfac.empresa = venlifac.empresa ) ~n"+&
			"and   ( venfac.anyo = venlifac.anyo ) ~n"+&
			"and   ( venfac.factura = venlifac.factura ) ~n"+&
			"and   ( venfac.empresa = genter.empresa ) ~n"+&
			"and   ( venfac.cliente = genter.codigo ) ~n"+&
			"and   ( genter.tipoter = 'C' ) ~n"+&
			"and   ( genter.activo  = 'S' ) ~n"+&
			"and   ( genter.pais = paises.pais ) ~n"+&
			"and   ( venlifac.empresa = articulos.empresa ) ~n"+&
			"and   ( venlifac.articulo = articulos.codigo ) ~n"+&
			"and   ( articulos.empresa = familias.empresa ) ~n"+&
			"and   ( articulos.familia = familias.codigo ) ~n"+&
			"and   ( articulos.empresa = formatos.empresa ) ~n"+&
			"and   ( articulos.formato = formatos.codigo ) ~n"+&
			"and   ( articulos.empresa = marcas.empresa ) ~n"+&
			"and   ( articulos.familia = marcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( articulos.empresa = submarcas.empresa ) ~n"+&
			"and   ( articulos.familia = submarcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
			"and   ( articulos.empresa = art_codestadistico.empresa ) ~n"+&
			"and   ( articulos.codigo = art_codestadistico.codigo ) ~n"+&
			"and   ( articulos.empresa = almartcajas.empresa ) ~n"+&
			"and   ( articulos.codigo  = almartcajas.articulo ) ~n"+&
			"and   ( venlifac.caja     = almartcajas.caja ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			ls_filtro_pavrev+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_formatos+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( venfac.empresa = '"+codigo_empresa+"' ) ~n"+&
			"AND     ( venlifac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' ) ~n"+&
			ls_filtro_articulos+&
			" ) ~n"+&
			"GROUP BY venfac.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    genter.codigo, ~n"+&
			"		    genter.razon ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(genter.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(genter.codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM genter, ~n"+&
			"      venclientes, ~n"+&
			"		 paises, ~n"+&
			"		 articulos, ~n"+&
			"		 familias, ~n"+&
			"		 formatos, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas, ~n"+&
			"      art_codestadistico ~n"+&
			"WHERE ( genter.tipoter      = 'C' ) ~n"+&
			"and   ( genter.pais         = paises.pais ) ~n"+&
			"and   ( genter.empresa      = venclientes.empresa ) ~n"+&
			"and   ( genter.codigo       = venclientes.codigo ) ~n"+&
			"and   ( genter.activo       = 'S' ) ~n"+&
			"and   ( genter.empresa      = articulos.empresa ) ~n"+&
			"and   ( articulos.empresa   = familias.empresa ) ~n"+&
			"and   ( articulos.familia   = familias.codigo ) ~n"+&
			"and   ( articulos.empresa   = formatos.empresa ) ~n"+&
			"and   ( articulos.formato   = formatos.codigo ) ~n"+&
			"and   ( articulos.empresa   = marcas.empresa ) ~n"+&
			"and   ( articulos.familia   = marcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( articulos.empresa = submarcas.empresa ) ~n"+&
			"and   ( articulos.familia = submarcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
			"and   ( articulos.empresa = art_codestadistico.empresa ) ~n"+&
			"and   ( articulos.codigo = art_codestadistico.codigo ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			ls_filtro_pavrev+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_formatos+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( genter.empresa = '"+codigo_empresa+"' ) ~n"+&
			ls_filtro_articulos+&
			" ) ~n"+&
			"GROUP BY genter.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    genter.codigo, ~n"+&
			"		    genter.razon ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(venfacprev_cliente.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(venfacprev_cliente.genter_codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       sum(venfacprev_cliente.prevision_precio_medio) as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       sum(venfacprev_cliente.prevision_importe) as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM venfacprev_cliente, ~n"+&
			"      genter, ~n"+&
			"      venclientes, ~n"+&
			"		 paises ~n"+&
			"WHERE ( venfacprev_cliente.empresa        = genter.empresa ) ~n"+&
			"and   ( 'C'                               = genter.tipoter ) ~n"+&
			"and   ( venfacprev_cliente.genter_codigo  = genter.codigo ) ~n"+&
			"and   ( genter.activo                     = 'S' ) ~n"+&
			"and   ( venfacprev_cliente.empresa        = venclientes.empresa ) ~n"+&
			"and   ( venfacprev_cliente.genter_codigo  = venclientes.codigo ) ~n"+&
			"and   ( genter.pais                       = paises.pais ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			"and   ( ( venfacprev_cliente.empresa = '"+codigo_empresa+"' ) ~n"+&
			"and     ( venfacprev_cliente.ejercicio = "+string(ll_ejercicio_presupuesto,"###0")+" ) ~n"+&			
			" ) ~n"+&
			"GROUP BY venfacprev_cliente.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    venfacprev_cliente.genter_codigo, ~n"+&
			"		    genter.razon ) as resultado ~n"+&
		   "GROUP BY resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda ~n"+&
		   "ORDER BY resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda "
			
//clipboard(ls_sel)
//messagebox("",ls_sel)

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

if ll_total > 0 then
	if ds_datos.RowsCopy(1,ll_total, Primary!, arg_datawindow, 1, Primary!) = 1 then
		for ll_indice = 1 to ll_total
			istr_venfacprev_cliente.empresa                = ds_datos.object.empresa[ll_indice]
			istr_venfacprev_cliente.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_cliente.genter_codigo          = ds_datos.object.genter_codigo[ll_indice]
			istr_venfacprev_cliente.prevision_precio_medio = 0
			istr_venfacprev_cliente.prevision_importe      = 0
			istr_venfacprev_cliente.prevision_metros       = 0
			//istr_venfacprev_cliente.venagentes_agente    = ""
			
			if f_insert_venfacprev_cliente(istr_venfacprev_cliente) then
				commit;
			else
				rollback;
			end if		
		next
	end if	
end if

arg_datawindow.sort()
arg_datawindow.groupcalc()

arg_datawindow.setredraw(true)

if ll_total > 0 then
	ll_donde = arg_datawindow.find("genter_codigo = '"+ds_datos.object.genter_codigo[1]+"'",1,arg_datawindow.rowcount())
	
	if ll_donde > 0 then
		arg_datawindow.setrow(ll_donde)
		arg_datawindow.scrolltorow(ll_donde)
	end if
end if

destroy ds_datos
end subroutine

protected subroutine f_control_m2 (datawindow arg_datawindow);string ls_codigo,ls_filtro,ls_filtro_paises,ls_filtro_clientes,ls_filtro_pavrev,ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_cliente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_total,ll_ejercicio_presupuesto
datetime ldt_fecha_desde,ldt_fecha_hasta

datastore ds_datos

arg_datawindow.reset()
arg_datawindow.setredraw(false)
ls_sort_actual = arg_datawindow.describe("datawindow.table.sort")
arg_datawindow.setsort(is_sort_inicial)

uo_paises.visible = false

ii_grupo_desplegado = 1

ls_filtro_articulos = " AND     ( articulos.promocion = 'N' ) "

//Filtro de paises
li_opciones = uo_paises.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_paises.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_paises.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_paises.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_paises.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_paises.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_paises = " and paises.pais in ("+ls_filtro+") "
	else
		ls_filtro_paises = " and paises.pais = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS PAISES"	
	else
		ls_texto_filtro += "~nTODOS LOS PAISES"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAISES : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nPAISES : "+ls_texto_seleccion
	end if				
end if	

//Fin de filtro de paises

if uo_cliente.em_codigo.text <> "" then
	ls_filtro_cliente = " and genter.codigo = '"+uo_cliente.em_codigo.text+"' "	
else
	ls_filtro_cliente = ""
end if

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))
ll_ejercicio_presupuesto = dec(em_ejercicio.text)

ls_sel = "SELECT resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       isnull(sum(resultado.prevision_precio_medio),0) as prevision_precio_medio, ~n"+&
			"       isnull(sum(resultado.m2),0) as m2, ~n"+&
			"       isnull(sum(resultado.importe),0) as importe, ~n"+&
			"       isnull(sum(resultado.prevision_importe),0) as prevision_importe, ~n"+&
			"       case when isnull(sum(resultado.prevision_precio_medio),0) <> 0 then isnull(sum(resultado.prevision_importe),0) / isnull(sum(resultado.prevision_precio_medio),0) else 0 end as prevision_metros, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			"FROM ~n"+&
			"(SELECT isnull(venfac.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(genter.codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  sum(case when venlifac.tipo_unidad  = '1' then isnull(venlifac.cantidad,0) else isnull(venlifac.cantidad * (almartcajas.metroscaja / almartcajas.piezascaja),0) end) as m2, ~n"+&
			"		  convert(dec(16,2),sum((venlifac.neto - venlifac.impdtopp) / venfac.cambio)) as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM venfac, ~n"+&
			"		 venlifac, ~n"+&
			"		 genter, ~n"+&
			"		 paises, ~n"+&
			"		 articulos, ~n"+&
			"		 familias, ~n"+&
			"		 formatos, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas, ~n"+&
			"      art_codestadistico, ~n"+&
			"      almartcajas ~n"+&
			"WHERE ( venfac.empresa = venlifac.empresa ) ~n"+&
			"and   ( venfac.anyo = venlifac.anyo ) ~n"+&
			"and   ( venfac.factura = venlifac.factura ) ~n"+&
			"and   ( venfac.empresa = genter.empresa ) ~n"+&
			"and   ( venfac.cliente = genter.codigo ) ~n"+&
			"and   ( genter.tipoter = 'C' ) ~n"+&
			"and   ( genter.activo  = 'S' ) ~n"+&
			"and   ( genter.pais = paises.pais ) ~n"+&
			"and   ( venlifac.empresa = articulos.empresa ) ~n"+&
			"and   ( venlifac.articulo = articulos.codigo ) ~n"+&
			"and   ( articulos.empresa = familias.empresa ) ~n"+&
			"and   ( articulos.familia = familias.codigo ) ~n"+&
			"and   ( articulos.empresa = formatos.empresa ) ~n"+&
			"and   ( articulos.formato = formatos.codigo ) ~n"+&
			"and   ( articulos.empresa = marcas.empresa ) ~n"+&
			"and   ( articulos.familia = marcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( articulos.empresa = submarcas.empresa ) ~n"+&
			"and   ( articulos.familia = submarcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
			"and   ( articulos.empresa = art_codestadistico.empresa ) ~n"+&
			"and   ( articulos.codigo = art_codestadistico.codigo ) ~n"+&
			"and   ( articulos.empresa = almartcajas.empresa ) ~n"+&
			"and   ( articulos.codigo  = almartcajas.articulo ) ~n"+&
			"and   ( venlifac.caja     = almartcajas.caja ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_clientes+" ~n"+&
			ls_filtro_pavrev+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_formatos+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( venfac.empresa = '"+codigo_empresa+"' ) ~n"+&
			"AND     ( venlifac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' ) ~n"+&
			ls_filtro_articulos+&
			" ) ~n"+&
			"GROUP BY venfac.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    genter.codigo, ~n"+&
			"		    genter.razon ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(genter.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(genter.codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM genter, ~n"+&
			"      venclientes, ~n"+&
			"		 paises, ~n"+&
			"		 articulos, ~n"+&
			"		 familias, ~n"+&
			"		 formatos, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas, ~n"+&
			"      art_codestadistico ~n"+&
			"WHERE ( genter.tipoter      = 'C' ) ~n"+&
			"and   ( genter.pais         = paises.pais ) ~n"+&
			"and   ( genter.empresa      = venclientes.empresa ) ~n"+&
			"and   ( genter.codigo       = venclientes.codigo ) ~n"+&
			"and   ( genter.activo       = 'S' ) ~n"+&
			"and   ( genter.empresa      = articulos.empresa ) ~n"+&
			"and   ( articulos.empresa   = familias.empresa ) ~n"+&
			"and   ( articulos.familia   = familias.codigo ) ~n"+&
			"and   ( articulos.empresa   = formatos.empresa ) ~n"+&
			"and   ( articulos.formato   = formatos.codigo ) ~n"+&
			"and   ( articulos.empresa   = marcas.empresa ) ~n"+&
			"and   ( articulos.familia   = marcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( articulos.empresa = submarcas.empresa ) ~n"+&
			"and   ( articulos.familia = submarcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
			"and   ( articulos.empresa = art_codestadistico.empresa ) ~n"+&
			"and   ( articulos.codigo = art_codestadistico.codigo ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_clientes+" ~n"+&
			ls_filtro_pavrev+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_formatos+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( genter.empresa = '"+codigo_empresa+"' ) ~n"+&
			ls_filtro_articulos+&
			" ) ~n"+&
			"GROUP BY genter.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    genter.codigo, ~n"+&
			"		    genter.razon ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(venfacprev_cliente.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_codigo, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(venfacprev_cliente.genter_codigo,'') as genter_codigo, ~n"+&
			"		  isnull(genter.razon,'') as genter_descripcion, ~n"+&
			"       sum(venfacprev_cliente.prevision_precio_medio) as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       sum(venfacprev_cliente.prevision_importe) as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM venfacprev_cliente, ~n"+&
			"      genter, ~n"+&
			"      venclientes, ~n"+&
			"		 paises ~n"+&
			"WHERE ( venfacprev_cliente.empresa        = genter.empresa ) ~n"+&
			"and   ( 'C'                               = genter.tipoter ) ~n"+&
			"and   ( venfacprev_cliente.genter_codigo  = genter.codigo ) ~n"+&
			"and   ( genter.activo                     = 'S' ) ~n"+&
			"and   ( venfacprev_cliente.empresa        = venclientes.empresa ) ~n"+&
			"and   ( venfacprev_cliente.genter_codigo  = venclientes.codigo ) ~n"+&
			"and   ( genter.pais                       = paises.pais ) ~n"+&
			ls_filtro_cliente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_clientes+" ~n"+&
			"and   ( ( venfacprev_cliente.empresa = '"+codigo_empresa+"' ) ~n"+&
			"and     ( venfacprev_cliente.ejercicio = "+string(ll_ejercicio_presupuesto,"###0")+" ) ~n"+&			
			" ) ~n"+&
			"GROUP BY venfacprev_cliente.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    venfacprev_cliente.genter_codigo, ~n"+&
			"		    genter.razon ) as resultado ~n"+&
		   "GROUP BY resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda ~n"+&
		   "ORDER BY resultado.empresa, ~n"+&
			"       resultado.paises_codigo, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.genter_codigo, ~n"+&
			"       resultado.genter_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda "
			
//clipboard(ls_sel)
//messagebox("",ls_sel)

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

if ll_total > 0 then
	arg_datawindow.object.data = ds_datos.object.data
end if

arg_datawindow.sort()
arg_datawindow.groupcalc()

arg_datawindow.setsort(ls_sort_actual)
arg_datawindow.sort()
arg_datawindow.modify("t_filtro.text= '"+ls_texto_filtro+"'")
//arg_datawindow.groupcalc()

arg_datawindow.setredraw(true)

destroy ds_datos
end subroutine

event close;call super::close;dw_detalle.reset()
end event

event open;call super::open;string ls_mascara_moneda,ls_mascara_metros

istr_parametros.s_titulo_ventana = "Presupuestos Pais/Submarca"

This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())

dw_detalle.SetTransObject(SQLCA)

valor_empresa = FALSE
uo_paises.f_cargar_datos("dw_ayuda_paises","%","","Pais","Descripción")
valor_empresa = TRUE

dw_detalle.ue_marca_linea=false

is_sort_inicial        = dw_detalle.describe("datawindow.table.sort")
is_texto_t_descripcion = dw_detalle.describe("t_descripcion.text")
is_texto_t_pzs         = dw_detalle.describe("t_pzs.text")
is_texto_t_m2          = dw_detalle.describe("t_m2.text")
is_texto_t_importe     = dw_detalle.describe("t_importe.text")

//dw_detalle.setsort("importe_g1 D,importe_g2 D,importe_g3 D,importe_g4 D,importe D,"+is_sort_inicial)
//dw_detalle.modify("t_importe.text='"+is_texto_t_importe+" \/'")

//nivel1_descripcion A nivel1_codigo A nivel2_descripcion A nivel2_codigo A nivel3_descripcion A nivel3_codigo A nivel4_descripcion A nivel4_codigo A detalle_descripcion A detalle_codigo A

em_ejercicio.text = string(year(today()),em_ejercicio.mask)

ls_mascara_moneda = f_mascara_moneda(f_moneda_empresa(codigo_empresa))
ls_mascara_metros = f_mascara_unidad('1')

f_mascara_columna(dw_detalle,"prevision_precio_medio",ls_mascara_moneda)
f_mascara_columna(dw_detalle,"prevision_precio_importe",ls_mascara_moneda)
f_mascara_columna(dw_detalle,"prevision_precio_metros",ls_mascara_metros)

f_activar_campo(em_fechadesde)



end event

on w_mant_venfacprev_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_5=create gb_5
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_paises=create cb_paises
this.gb_3=create gb_3
this.uo_cliente=create uo_cliente
this.em_ejercicio=create em_ejercicio
this.cb_2=create cb_2
this.uo_cliente_anyadir=create uo_cliente_anyadir
this.pb_anyadir_pais=create pb_anyadir_pais
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_6=create gb_6
this.uo_paises=create uo_paises
this.dw_export_excel=create dw_export_excel
this.dw_detalle=create dw_detalle
this.cb_exportar=create cb_exportar
this.cb_importar=create cb_importar
this.dw_import_excel=create dw_import_excel
this.gb_excel=create gb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_paises
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.em_ejercicio
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.uo_cliente_anyadir
this.Control[iCurrent+14]=this.pb_anyadir_pais
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_6
this.Control[iCurrent+18]=this.uo_paises
this.Control[iCurrent+19]=this.dw_export_excel
this.Control[iCurrent+20]=this.dw_detalle
this.Control[iCurrent+21]=this.cb_exportar
this.Control[iCurrent+22]=this.cb_importar
this.Control[iCurrent+23]=this.dw_import_excel
this.Control[iCurrent+24]=this.gb_excel
end on

on w_mant_venfacprev_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_paises)
destroy(this.gb_3)
destroy(this.uo_cliente)
destroy(this.em_ejercicio)
destroy(this.cb_2)
destroy(this.uo_cliente_anyadir)
destroy(this.pb_anyadir_pais)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_6)
destroy(this.uo_paises)
destroy(this.dw_export_excel)
destroy(this.dw_detalle)
destroy(this.cb_exportar)
destroy(this.cb_importar)
destroy(this.dw_import_excel)
destroy(this.gb_excel)
end on

event ue_f5;f_control_m2(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_venfacprev_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_venfacprev_cliente
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_venfacprev_cliente
integer x = 9
integer y = 8
integer width = 2336
integer height = 108
end type

type pb_1 from upb_salir within w_mant_venfacprev_cliente
integer x = 4750
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_mant_venfacprev_cliente
integer x = 3863
integer y = 152
integer width = 105
integer height = 84
integer taborder = 0
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
boolean originalsize = false
long backcolor = 12632256
end type

event clicked;call super::clicked;
string lsModify, lsTotalPaginas
string lsResultado,isTitulo,isSubTitulo
string lsAltoHeaderOriginal = "650", lsAltoHeader
string lsalto, campo, lsY, lsX
long llalto, i, llY, llX, llIncrLandScape=700
string lsStringObjetos, lsObjeto
string lsBanda, lsBanda6
boolean ibCabecera = true,ibLandScape = false
blob datos
long ld_zoom
// Recepciono los datos de la datawindow
dw_detalle.getfullstate(datos)

ld_zoom = dec(dw_detalle.Object.DataWindow.Zoom)

isTitulo    = parent.title
isSubTitulo =  "Ventas Desde '"+em_fechadesde.text +"' hasta '"+em_fechahasta.text+"' Previsión "+em_ejercicio.text
//ld_zoom = dec(dw_detalle.Object.DataWindow.Zoom)

// El alto del dw_detalle es 650 + el alto de la cabecera de la dw ( dw_detalle )
lsAltoHeader = lsAltoHeaderOriginal
lsAltoHeader = string(long(lsAltoHeader) + long(dw_detalle.describe("datawindow.header.height")))

//Paso 1.- Poner el fondo dw a blanco
dw_detalle.modify("datawindow.color=16777215")
dw_detalle.modify("datawindow.summary.height=70")
dw_detalle.modify("datawindow.footer.height=80" )

//Paso 2.- Todos los objetos de la datawindow 

lsStringObjetos = dw_detalle.Describe ("datawindow.objects")
Do 
	lsObjeto = gf_get_token (lsStringObjetos, "~t")
	
	// Quitar la leyenda DOBLE CLICK ( Es necesario que el objeto empiece por "t_pie..."
	if left(lsObjeto, 5) = "t_pie" then
		dw_detalle.modify(lsObjeto+".visible=0")
	end if
	// Todos los objetos
//	lsResultado=dw_detalle.modify(lsObjeto+".color=0")
//	lsResultado=dw_detalle.modify(lsObjeto+".background.mode=2")
//	lsResultado=dw_detalle.modify(lsObjeto+".background.color=16777215")	

	// Especificacion por banda	
	lsBanda = dw_detalle.Describe(lsobjeto+".band")
	lsBanda6 = left(lsBanda, 6)
	CHOOSE CASE lsBanda6
		CASE "detail"
		CASE "footer"
			dw_detalle.setposition(lsObjeto, "summary", true)
//			lsResultado=dw_detalle.modify(lsObjeto+".border=2")
		CASE "header"
			// Es un grupo
			if pos(lsBanda, ".") > 0 then
				lsResultado=dw_detalle.modify(lsObjeto+".font.weight=~"700~"")
			else
			// Es la cabecera
				lsResultado=dw_detalle.modify(lsObjeto+".border=2")
//				lsResultado=dw_detalle.modify(lsObjeto+".background.color=12632256")				
				lsAlto = dw_detalle.describe(lsObjeto+".height")
				lsY = dw_detalle.describe(lsObjeto+".Y")
	
				llalto = long(lsalto)
				llY = long(lsY)
				//llalto = integer(lsAltoHeader) - llalto + llY - 20
				llAlto = integer(lsAltoHeaderOriginal) - 20 + llY
				lsResultado=dw_detalle.modify(lsObjeto+".Y="+string(llalto))
			end if
		CASE "summar"
		CASE "traile"
			// Es un pie de grupo
			if pos(lsBanda, ".") > 0 then
				lsResultado=dw_detalle.modify(lsObjeto+".font.weight=~"700~"")
			// Es el pie
			else
			end if
		CASE "foregr"
		CASE "backgr"
	END CHOOSE
Loop Until lsStringObjetos = ""
//Paso 2.- Poner la cabecera y titulos
if ibCabecera then
	// Cambiar el alto de la banda HEADER
	lsModify = "datawindow.header.height="+lsAltoHeader
	lsResultado=dw_detalle.modify(lsModify)
	lsModify = "datawindow.header.color='536870912'"
	lsResultado=dw_detalle.modify(lsModify)

	// Crear el bitmap con el logo de la empresa
	string fichero
	fichero = f_imagen_cabecera_empresa(codigo_empresa)
   lsModify="create compute(band=Header alignment='0' border='0'" + &
			   " height.autosize=No moveable=0 resizeable=0 x='14' y='4' height='308' width='571' " + &
				" name=logo expression='bitmap(~""+fichero+"~")' background.mode='0')"
	lsResultado = dw_detalle.Modify(lsModify)

	// Crear el nombre de la empresa
	lsModify = "create text(band=header alignment=~"1~" text=~""+f_nombre_empresa(codigo_empresa)+"~" border=~"0~" color=~"0~" x=~"869~" y=~"18~" height=~"116~" width=~"2418~" html.valueishtml=~"0~"  name=t_nombre visible=~"1~"  font.face=~"Arial~" font.height=~"-18~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=dw_detalle.modify(lsModify)	

	// Crear la fecha del listado
	lsModify = "create compute(band=header alignment=~"1~" expression='~"Fecha : ~" + string( today(), ~"dd-mm-yyyy~" )' border=~"0~" color=~"0~" x=~"2231~" y=~"156~" height=~"64~" width=~"1056~" format=~"[general]~" html.valueishtml=~"0~"  name=t_fecha visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=dw_detalle.modify(lsModify)	
	
	// Crear la hora del listado
	lsModify = "create compute(band=header alignment=~"1~" expression='~"Hora   :     ~" + String(now(), ~"hh:mm:ss~")' border=~"0~" color=~"0~" x=~"2231~" y=~"216~" height=~"68~" width=~"1056~" format=~"[general]~" html.valueishtml=~"0~"  name=t_hora visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=dw_detalle.modify(lsModify)	
	
end if
if isTitulo <> "" then	
	lsModify = "create text(band=header alignment=~"2~" text=~""+isTitulo+"~" border=~"2~" color=~"0~" x=~"20~" y=~"368~" height=~"80~" width=~"3346~" html.valueishtml=~"0~"  name=t_titulo visible=~"1~"  font.face=~"Arial~" font.height=~"-12~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=dw_detalle.modify(lsModify)	
end if
if isSubTitulo <> "" then
	lsModify = "create text(band=header alignment=~"2~" text=~""+isSubTitulo+"~" border=~"0~" color=~"0~" x=~"20~" y=~"484~" height=~"60~" width=~"3346~" html.valueishtml=~"0~"  name=t_subtitulo visible=~"1~"  resizeable=1  font.face=~"Arial~" font.height=~"-9~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=dw_detalle.modify(lsModify)	
end if

// Añadir el campo compute total_paginas
lsModify = "create compute(band=header alignment='0' expression='pageCount()' visible=~"0~" border='0' color='16777215' x='19' y='288' height='57' width='563' format='[general]'  name=total_paginas  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )"
lsResultado=dw_detalle.modify(lsModify)

// Añadir el campo compute pie_pagina
if ibLandScape then
	lsModify = "create compute(band=footer alignment=~"2~" expression=~"'Página ' + page() + ' de ' + pageCount()~"border=~"2~" color=~"0~" x=~"50~" y=~"4~" height=~"56~" width=~"4500~" format=~"[general]~" html.valueishtml=~"0~"  name=pie_pagina visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"	
else
	lsModify = "create compute(band=footer alignment=~"2~" expression=~"'Página ' + page() + ' de ' + pageCount()~"border=~"2~" color=~"0~" x=~"20~" y=~"4~" height=~"56~" width=~"3346~" format=~"[general]~" html.valueishtml=~"0~"  name=pie_pagina visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
end if
lsResultado=dw_detalle.modify(lsModify)

// Landscape
if ibLandscape = true then
	// Nombre de empresa
	lsY = dw_detalle.describe("t_nombre.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("t_nombre.X="+string(llY))

	// Titulo
	lsY = dw_detalle.describe("t_titulo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("t_titulo.X="+string(llY))

	// Subtitulo
	lsY = dw_detalle.describe("t_subtitulo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("t_subtitulo.X="+string(llY))

	// Fecha
	lsY = dw_detalle.describe("t_fecha.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("t_fecha.X="+string(llY))

	// Hora
	lsY = dw_detalle.describe("t_hora.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("t_hora.X="+string(llY))

	// Logo
	lsY = dw_detalle.describe("logo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	dw_detalle.modify("logo.X="+string(llY))
	
	// Landscape
	dw_detalle.modify("datawindow.print.orientation=1")
	
end if
IF dw_detalle.rowcount() > 0 then
	dw_detalle.Object.DataWindow.Zoom = ld_zoom 
	f_imprimir_datawindow(dw_detalle)
end if

dw_detalle.Object.DataWindow.Zoom = 100

dw_detalle.settransobject(sqlca)
dw_detalle.setfullstate(datos)
end event

type em_fechadesde from u_em_campo within w_mant_venfacprev_cliente
integer x = 18
integer y = 152
integer width = 256
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;dw_detalle.reset()
end event

type em_fechahasta from u_em_campo within w_mant_venfacprev_cliente
integer x = 274
integer y = 152
integer width = 256
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;dw_detalle.reset()
end event

type gb_5 from groupbox within w_mant_venfacprev_cliente
integer x = 2007
integer y = 108
integer width = 315
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_mant_venfacprev_cliente
integer x = 5
integer y = 108
integer width = 539
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fechas Ventas"
end type

type cb_1 from u_boton within w_mant_venfacprev_cliente
integer x = 3474
integer y = 152
integer width = 384
integer height = 84
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F5 Consultar"
end type

event clicked;f_control_m2(dw_detalle)
end event

type cb_paises from commandbutton within w_mant_venfacprev_cliente
integer x = 2016
integer y = 152
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Paises"
end type

event clicked;uo_paises.visible = not(uo_paises.visible)
end event

type gb_3 from groupbox within w_mant_venfacprev_cliente
integer x = 3461
integer y = 108
integer width = 521
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_mant_venfacprev_cliente
event destroy ( )
integer x = 562
integer y = 152
integer width = 1426
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;dw_detalle.reset()

this.em_campo.text=f_nombre_cliente(codigo_empresa,'C',this.em_codigo.text)

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

type em_ejercicio from u_em_campo within w_mant_venfacprev_cliente
integer x = 2496
integer y = 152
integer width = 233
integer taborder = 80
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

event modified;call super::modified;dw_detalle.reset()
end event

type cb_2 from commandbutton within w_mant_venfacprev_cliente
integer x = 4151
integer width = 457
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Chequeo Cajas"
end type

event clicked;//select *
//from   venlifac 
//where  venlifac.empresa = '1' 
//and    venlifac.ffactura between '01-01-2016' and '30-11-2016' 
//and    isnull(venlifac.articulo,'') <> ''
//and not exists(select almartcajas.articulo,
//							 almartcajas.caja
//					from   almartcajas
//					where  almartcajas.empresa = venlifac.empresa
//					and    almartcajas.articulo = venlifac.articulo
//					and    almartcajas.caja = venlifac.caja);
end event

type uo_cliente_anyadir from u_em_campo_2 within w_mant_venfacprev_cliente
event destroy ( )
integer x = 2752
integer y = 152
integer width = 608
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente_anyadir.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;long ll_donde

pb_anyadir_pais.enabled = false

this.em_campo.text=f_nombre_cliente(codigo_empresa,'C',this.em_codigo.text)

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
else
	ll_donde = dw_detalle.find("genter_codigo = '"+this.em_codigo.text+"'",1,dw_detalle.rowcount())
	
	if ll_donde > 0 then
		this.em_campo.text=""
		this.em_codigo.text=""		
	else
		pb_anyadir_pais.enabled = true	
	end if
end if 
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
valor_empresa = true

end event

type pb_anyadir_pais from picturebutton within w_mant_venfacprev_cliente
integer x = 3360
integer y = 144
integer width = 91
integer height = 96
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "C:\Tencer_PB12\navigate_plus.png"
string disabledname = "C:\Tencer_PB12\navigate_plus.png"
end type

event clicked;f_anyadir_cliente(dw_detalle,uo_cliente_anyadir.em_codigo.text)

this.enabled = false
end event

type gb_2 from groupbox within w_mant_venfacprev_cliente
integer x = 549
integer y = 108
integer width = 1454
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_4 from groupbox within w_mant_venfacprev_cliente
integer x = 2327
integer y = 108
integer width = 411
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Presupuestar"
end type

type gb_6 from groupbox within w_mant_venfacprev_cliente
integer x = 2743
integer y = 108
integer width = 713
integer height = 136
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Añadir Cliente"
end type

type uo_paises from u_marca_lista within w_mant_venfacprev_cliente
event destroy ( )
boolean visible = false
integer x = 955
integer y = 252
integer taborder = 140
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;dw_detalle.reset()
end event

type dw_export_excel from datawindow within w_mant_venfacprev_cliente
boolean visible = false
integer x = 2418
integer width = 635
integer height = 112
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Export Excel"
string dataobject = "dw_mant_venfacprev_cliente_excel"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from u_datawindow_consultas within w_mant_venfacprev_cliente
integer x = 5
integer y = 256
integer width = 4855
integer height = 3492
integer taborder = 110
string dataobject = "dw_mant_venfacprev_cliente"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if dwo.name = 't_replegar' then
	if ii_grupo_desplegado > 0 then		
		this.CollapseLevel(ii_grupo_desplegado)
		ii_grupo_desplegado --
	end if
else
	if dwo.name = 't_desplegar' then
		if ii_grupo_desplegado < ii_max_grupos	then	
			ii_grupo_desplegado ++
			this.expandlevel(ii_grupo_desplegado)
		end if
	end if
end if
end event

event itemchanged;call super::itemchanged;str_venfacprev_cliente istr_venfacprev_cliente

//if uo_agente.em_codigo.text = "" then
//	return 2
//else
	choose case dwo.name
		case "prevision_precio_medio"
			istr_venfacprev_cliente.empresa                = this.object.empresa[row]
			istr_venfacprev_cliente.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_cliente.genter_codigo          = this.object.genter_codigo[row]
			istr_venfacprev_cliente.prevision_precio_medio = dec(data)
			istr_venfacprev_cliente.prevision_importe      = round(this.object.prevision_metros[row] * dec(data),2)
			istr_venfacprev_cliente.prevision_metros       = this.object.prevision_metros[row]
			
			if f_insert_venfacprev_cliente(istr_venfacprev_cliente) then
				commit;
				this.object.prevision_importe[row] = istr_venfacprev_cliente.prevision_importe
			else
				rollback;
				return 2
			end if
		case "prevision_importe"
			istr_venfacprev_cliente.empresa                = this.object.empresa[row]
			istr_venfacprev_cliente.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_cliente.genter_codigo          = this.object.genter_codigo[row]
			istr_venfacprev_cliente.prevision_precio_medio = this.object.prevision_precio_medio[row]
			istr_venfacprev_cliente.prevision_importe      = dec(data)
			if this.object.prevision_precio_medio[row] <> 0 then
				istr_venfacprev_cliente.prevision_metros       = round((dec(data) / this.object.prevision_precio_medio[row]),2)
			else
				istr_venfacprev_cliente.prevision_metros       = 0
			end if
			
			if f_insert_venfacprev_cliente(istr_venfacprev_cliente) then
				commit;
				this.object.prevision_metros[row] = istr_venfacprev_cliente.prevision_metros
			else
				rollback;
				return 2
			end if		
		case "prevision_metros"
			istr_venfacprev_cliente.empresa                = this.object.empresa[row]
			istr_venfacprev_cliente.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_cliente.genter_codigo          = this.object.genter_codigo[row]
			istr_venfacprev_cliente.prevision_precio_medio = this.object.prevision_precio_medio[row]
			istr_venfacprev_cliente.prevision_importe      = round((dec(data) * this.object.prevision_precio_medio[row]),2)
			istr_venfacprev_cliente.prevision_metros       = dec(data)
			
			if f_insert_venfacprev_cliente(istr_venfacprev_cliente) then
				commit;
				this.object.prevision_importe[row] = istr_venfacprev_cliente.prevision_importe
			else
				rollback;
				return 2
			end if		
	end choose
//end if
end event

type cb_exportar from u_boton within w_mant_venfacprev_cliente
integer x = 3995
integer y = 152
integer width = 384
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;call super::clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_detalle.rowcount()

if ll_registros > 0 then
	dw_export_excel.reset()
	dw_export_excel.object.data = dw_detalle.object.data
	
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

type cb_importar from u_boton within w_mant_venfacprev_cliente
integer x = 4425
integer y = 152
integer width = 384
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Importar"
end type

event clicked;call super::clicked;long ll_columnas = 8 , ll_fila_desde = 3,ll_total_detalle
string lsFichero, lsPath

lsPath    = ""
lsFichero = ""

ll_total_detalle = dw_detalle.rowcount()

if ll_total_detalle > 0 then

	// Obtener nombre del fichero --> Dicho fichero EXCEL no debe tener cabecera en las columnas ¡¡¡
	If getfilesavename ('Fichero EXCEL',lsPath,lsFichero,'XLS','XLS Files (*.XLS), *.XLS') = 1 then
		dw_export_excel.reset()
		
		SetPointer(HourGlass!)
			
		u_excel uo_excel
		uo_excel = create u_excel
		if not uo_excel.f_importar_libreoffice ( dw_import_excel, lsPath, ll_columnas , ll_fila_desde ) then
			//Error!!
		else
			//dw_import_excel.visible = true
			long ll_indice,ll_total,ll_donde
			string ls_cliente
			decimal ld_prevision_metros,ld_prevision_precio_medio,ld_prevision_importe
			ll_total = dw_import_excel.rowcount()
			
			for ll_indice = 1 to ll_total
				f_mensaje_proceso("Importando",ll_indice,ll_total)
				
				ls_cliente                = dw_import_excel.object.genter_codigo[ll_indice]
				ld_prevision_metros       = dw_import_excel.object.prevision_metros[ll_indice]
				ld_prevision_precio_medio = dw_import_excel.object.prevision_precio_medio[ll_indice]
				ld_prevision_importe      = dw_import_excel.object.prevision_importe[ll_indice]
				
				ll_donde = dw_detalle.find("genter_codigo = '"+ls_cliente+"'",1,ll_total_detalle)
				
				if ll_donde > 0 then				
					dw_detalle.object.prevision_metros[ll_donde]       = ld_prevision_metros
					dw_detalle.object.prevision_precio_medio[ll_donde] = ld_prevision_precio_medio
					dw_detalle.object.prevision_importe[ll_donde]      = ld_prevision_importe
					
					dw_detalle.event itemchanged(ll_donde,dw_detalle.object.prevision_precio_medio,string(dw_detalle.object.prevision_precio_medio[ll_donde]))
				end if
			next
			
		end if
		destroy uo_excel	
	end if

else
	messagebox("Error","Debe consultar los datos antes de hacer la importación")
end if
end event

type dw_import_excel from datawindow within w_mant_venfacprev_cliente
boolean visible = false
integer x = 3072
integer width = 635
integer height = 112
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Import Excel"
string dataobject = "dw_mant_venfacprev_cliente_excel_import"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_excel from groupbox within w_mant_venfacprev_cliente
integer x = 3986
integer y = 108
integer width = 869
integer height = 136
integer taborder = 120
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

