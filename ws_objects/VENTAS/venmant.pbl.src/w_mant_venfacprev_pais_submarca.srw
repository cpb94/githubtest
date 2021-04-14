$PBExportHeader$w_mant_venfacprev_pais_submarca.srw
forward
global type w_mant_venfacprev_pais_submarca from w_int_con_empresa
end type
type pb_1 from upb_salir within w_mant_venfacprev_pais_submarca
end type
type pb_2 from upb_imprimir within w_mant_venfacprev_pais_submarca
end type
type em_fechadesde from u_em_campo within w_mant_venfacprev_pais_submarca
end type
type em_fechahasta from u_em_campo within w_mant_venfacprev_pais_submarca
end type
type gb_5 from groupbox within w_mant_venfacprev_pais_submarca
end type
type cb_familias from commandbutton within w_mant_venfacprev_pais_submarca
end type
type gb_1 from groupbox within w_mant_venfacprev_pais_submarca
end type
type cb_1 from u_boton within w_mant_venfacprev_pais_submarca
end type
type cb_paises from commandbutton within w_mant_venfacprev_pais_submarca
end type
type cb_marcas from commandbutton within w_mant_venfacprev_pais_submarca
end type
type cb_submarcas from commandbutton within w_mant_venfacprev_pais_submarca
end type
type gb_3 from groupbox within w_mant_venfacprev_pais_submarca
end type
type uo_submarcas from u_marca_lista within w_mant_venfacprev_pais_submarca
end type
type uo_marcas from u_marca_lista within w_mant_venfacprev_pais_submarca
end type
type uo_familias from u_marca_lista within w_mant_venfacprev_pais_submarca
end type
type dw_detalle from u_datawindow_consultas within w_mant_venfacprev_pais_submarca
end type
type uo_agente from u_em_campo_2 within w_mant_venfacprev_pais_submarca
end type
type em_ejercicio from u_em_campo within w_mant_venfacprev_pais_submarca
end type
type cb_2 from commandbutton within w_mant_venfacprev_pais_submarca
end type
type uo_pais from u_em_campo_2 within w_mant_venfacprev_pais_submarca
end type
type pb_anyadir_pais from picturebutton within w_mant_venfacprev_pais_submarca
end type
type gb_2 from groupbox within w_mant_venfacprev_pais_submarca
end type
type gb_4 from groupbox within w_mant_venfacprev_pais_submarca
end type
type gb_6 from groupbox within w_mant_venfacprev_pais_submarca
end type
type uo_paises from u_marca_lista within w_mant_venfacprev_pais_submarca
end type
end forward

global type w_mant_venfacprev_pais_submarca from w_int_con_empresa
integer width = 4878
integer height = 3912
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_5 gb_5
cb_familias cb_familias
gb_1 gb_1
cb_1 cb_1
cb_paises cb_paises
cb_marcas cb_marcas
cb_submarcas cb_submarcas
gb_3 gb_3
uo_submarcas uo_submarcas
uo_marcas uo_marcas
uo_familias uo_familias
dw_detalle dw_detalle
uo_agente uo_agente
em_ejercicio em_ejercicio
cb_2 cb_2
uo_pais uo_pais
pb_anyadir_pais pb_anyadir_pais
gb_2 gb_2
gb_4 gb_4
gb_6 gb_6
uo_paises uo_paises
end type
global w_mant_venfacprev_pais_submarca w_mant_venfacprev_pais_submarca

type variables
string grafico = "N",is_sort_inicial,is_texto_t_descripcion,is_texto_t_pzs,is_texto_t_m2,is_texto_t_importe
int ii_grupo_desplegado,ii_max_grupos = 3
end variables

forward prototypes
public subroutine f_control_m2 (datawindow arg_datawindow)
public subroutine f_anyadir_pais (datawindow arg_datawindow, string arg_pais)
end prototypes

public subroutine f_control_m2 (datawindow arg_datawindow);string ls_codigo,ls_filtro,ls_filtro_paises,ls_filtro_agentes,ls_filtro_pavrev,ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_agente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_total,ll_ejercicio_presupuesto
datetime ldt_fecha_desde,ldt_fecha_hasta

datastore ds_datos

arg_datawindow.reset()
arg_datawindow.setredraw(false)
ls_sort_actual = arg_datawindow.describe("datawindow.table.sort")
arg_datawindow.setsort(is_sort_inicial)

uo_familias.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_submarcas.visible = false

ii_grupo_desplegado = 3

//if ddlb_promocion.text = "Todo" then
//	ls_filtro_articulos = ""
//else
//	if ddlb_promocion.text = "Si" then
//		ls_filtro_articulos = " AND     ( articulos.promocion = 'S' ) "
//	else
//		if ddlb_promocion.text = "No" then
			ls_filtro_articulos = " AND     ( articulos.promocion = 'N' ) "
//		else
//			ls_filtro_articulos = " AND 0 = 1 "
//		end if
//	end if	
//end if

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

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_familias.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_familias.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and familias.codigo in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and familias.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS FAMILIAS"	
	else
		ls_texto_filtro += "~nTODAS LAS FAMILIAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FAMILIAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFAMILIAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_marcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_marcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and marcas.codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and marcas.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS MARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS MARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "MARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_submarcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_submarcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and submarcas.codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and submarcas.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS SUBMARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS SUBMARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "SUBMARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nSUBMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de submarcas

if uo_agente.em_codigo.text <> "" then
	ls_filtro_agente = " and venagentes.agente = '"+uo_agente.em_codigo.text+"' "	
else
	ls_filtro_agente = ""
end if

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))
ll_ejercicio_presupuesto = dec(em_ejercicio.text)

ls_sel = "SELECT resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
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
			"       isnull(genter.pais,'') as paises_pais, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(articulos.familia,'') as familias_codigo, ~n"+&
			"		  isnull(familias.descripcion,'') as familias_descripcion, ~n"+&
			"		  isnull(articulos.marcas_codigo,'') as marcas_codigo, ~n"+&
			"		  isnull(marcas.descripcion,'') as marcas_descripcion, ~n"+&
			"		  isnull(articulos.submarcas_codigo,'') as submarcas_codigo, ~n"+&
			"		  isnull(submarcas.descripcion,'') as submarcas_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  sum(case when venlifac.tipo_unidad  = '1' then isnull(venlifac.cantidad,0) else isnull(venlifac.cantidad * (almartcajas.metroscaja / almartcajas.piezascaja),0) end) as m2, ~n"+&
			"		  convert(dec(16,2),sum((venlifac.neto - venlifac.impdtopp) / venfac.cambio)) as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       isnull(venagentes.agente,'') as venagentes_agente, ~n"+&
			"       isnull(venagentes.nombre,'') as venagentes_nombre ~n"+&
			" FROM venfac, ~n"+&
			"		 venlifac, ~n"+&
			"		 genter, ~n"+&
			"		 paises, ~n"+&
			"		 venagentes, ~n"+&
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
			"and   ( genter.pais = paises.pais ) ~n"+&
			"and   ( venfac.empresa = venagentes.empresa ) ~n"+&
			"and   ( venfac.agente1 = venagentes.agente ) ~n"+&
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
			ls_filtro_agente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_agentes+" ~n"+&
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
			"         genter.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    articulos.familia, ~n"+&
			"		    familias.descripcion, ~n"+&
			"		    articulos.marcas_codigo, ~n"+&
			"		    marcas.descripcion, ~n"+&
			"		    articulos.submarcas_codigo, ~n"+&
			"		    submarcas.descripcion, ~n"+&
			"         venagentes.agente, ~n"+&
			"         venagentes.nombre ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(genter.empresa,'') as empresa, ~n"+&
			"       isnull(genter.pais,'') as paises_pais, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(articulos.familia,'') as familias_codigo, ~n"+&
			"		  isnull(familias.descripcion,'') as familias_descripcion, ~n"+&
			"		  isnull(articulos.marcas_codigo,'') as marcas_codigo, ~n"+&
			"		  isnull(marcas.descripcion,'') as marcas_descripcion, ~n"+&
			"		  isnull(articulos.submarcas_codigo,'') as submarcas_codigo, ~n"+&
			"		  isnull(submarcas.descripcion,'') as submarcas_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       isnull(venagentes.agente,'') as venagentes_agente, ~n"+&
			"       isnull(venagentes.nombre,'') as venagentes_nombre ~n"+&
			" FROM genter, ~n"+&
			"      venclientes, ~n"+&
			"		 paises, ~n"+&
			"		 venagentes, ~n"+&
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
			"and   ( venclientes.empresa = venagentes.empresa ) ~n"+&
			"and   ( venclientes.agente1 = venagentes.agente ) ~n"+&
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
			ls_filtro_agente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_agentes+" ~n"+&
			ls_filtro_pavrev+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_formatos+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( genter.empresa = '"+codigo_empresa+"' ) ~n"+&
			ls_filtro_articulos+&
			" ) ~n"+&
			"GROUP BY genter.empresa, ~n"+&
			"         genter.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    articulos.familia, ~n"+&
			"		    familias.descripcion, ~n"+&
			"		    articulos.marcas_codigo, ~n"+&
			"		    marcas.descripcion, ~n"+&
			"		    articulos.submarcas_codigo, ~n"+&
			"		    submarcas.descripcion, ~n"+&
			"         venagentes.agente, ~n"+&
			"         venagentes.nombre ~n"+&
			"UNION ALL ~n"+&
         "SELECT isnull(venfacprev_pais_submarca.empresa,'') as empresa, ~n"+&
			"       isnull(venfacprev_pais_submarca.paises_pais,'') as paises_pais, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(venfacprev_pais_submarca.familias_codigo,'') as familias_codigo, ~n"+&
			"		  isnull(familias.descripcion,'') as familias_descripcion, ~n"+&
			"		  isnull(venfacprev_pais_submarca.marcas_codigo,'') as marcas_codigo, ~n"+&
			"		  isnull(marcas.descripcion,'') as marcas_descripcion, ~n"+&
			"		  isnull(venfacprev_pais_submarca.submarcas_codigo,'') as submarcas_codigo, ~n"+&
			"		  isnull(submarcas.descripcion,'') as submarcas_descripcion, ~n"+&
			"       sum(venfacprev_pais_submarca.prevision_precio_medio) as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       sum(venfacprev_pais_submarca.prevision_importe) as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       isnull(venagentes.agente,'') as venagentes_agente, ~n"+&
			"       isnull(venagentes.nombre,'') as venagentes_nombre ~n"+&
			" FROM venfacprev_pais_submarca, ~n"+&
			"		 paises, ~n"+&
			"		 venagentes, ~n"+&
			"		 familias, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas ~n"+&
			"WHERE ( venfacprev_pais_submarca.paises_pais  = paises.pais ) ~n"+&
			"and   ( venfacprev_pais_submarca.empresa      = venagentes.empresa ) ~n"+&
			"and   ( venfacprev_pais_submarca.venagentes_agente = venagentes.agente ) ~n"+&
			"and   ( venfacprev_pais_submarca.empresa   = familias.empresa ) ~n"+&
			"and   ( venfacprev_pais_submarca.familias_codigo = familias.codigo ) ~n"+&
			"and   ( venfacprev_pais_submarca.empresa   = marcas.empresa ) ~n"+&
			"and   ( venfacprev_pais_submarca.familias_codigo = marcas.familias_codigo ) ~n"+&
			"and   ( venfacprev_pais_submarca.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( venfacprev_pais_submarca.empresa = submarcas.empresa ) ~n"+&
			"and   ( venfacprev_pais_submarca.familias_codigo = submarcas.familias_codigo ) ~n"+&
			"and   ( venfacprev_pais_submarca.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( venfacprev_pais_submarca.submarcas_codigo = submarcas.codigo ) ~n"+&
			ls_filtro_agente+" ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_agentes+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( venfacprev_pais_submarca.empresa = '"+codigo_empresa+"' ) ~n"+&
			"and     ( venfacprev_pais_submarca.ejercicio = "+string(ll_ejercicio_presupuesto,"###0")+" ) ~n"+&			
			" ) ~n"+&
			"GROUP BY venfacprev_pais_submarca.empresa, ~n"+&
			"         venfacprev_pais_submarca.paises_pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    venfacprev_pais_submarca.familias_codigo, ~n"+&
			"		    familias.descripcion, ~n"+&
			"		    venfacprev_pais_submarca.marcas_codigo, ~n"+&
			"		    marcas.descripcion, ~n"+&
			"		    venfacprev_pais_submarca.submarcas_codigo, ~n"+&
			"		    submarcas.descripcion, ~n"+&
			"         venagentes.agente, ~n"+&
			"         venagentes.nombre ) as resultado ~n"+&
		   "GROUP BY resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda ~n"+&
		   "ORDER BY resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
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

public subroutine f_anyadir_pais (datawindow arg_datawindow, string arg_pais);string ls_codigo,ls_filtro,ls_filtro_paises,ls_filtro_agentes,ls_filtro_pavrev,ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_agente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_indice,ll_total,ll_ejercicio_presupuesto
datetime ldt_fecha_desde,ldt_fecha_hasta

str_venfacprev_pais_submarca istr_venfacprev_pais_submarca

datastore ds_datos

ii_grupo_desplegado = 3

arg_datawindow.setredraw(false)
uo_familias.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_submarcas.visible = false

ls_filtro_articulos = " AND     ( articulos.promocion = 'N' ) "

//Filtro de paises

ls_filtro_paises = " and paises.pais = '"+arg_pais+"' "

//Fin de filtro de paises

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_familias.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_familias.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and familias.codigo in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and familias.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS FAMILIAS"	
	else
		ls_texto_filtro += "~nTODAS LAS FAMILIAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FAMILIAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFAMILIAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_marcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_marcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and marcas.codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and marcas.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS MARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS MARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "MARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_submarcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_submarcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and submarcas.codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and submarcas.codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS SUBMARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS SUBMARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "SUBMARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nSUBMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de submarcas

if uo_agente.em_codigo.text <> "" then
	ls_filtro_agente = " and venagentes.agente = '"+uo_agente.em_codigo.text+"' "	
else
	ls_filtro_agente = ""
end if

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))
ll_ejercicio_presupuesto = dec(em_ejercicio.text)

ls_sel = "SELECT resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
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
			"(SELECT isnull(articulos.empresa,'') as empresa, ~n"+&
			"       isnull(paises.pais,'') as paises_pais, ~n"+&
			"       isnull(paises.nombre,'') as paises_descripcion, ~n"+&
			"		  isnull(familias.codigo,'') as familias_codigo, ~n"+&
			"		  isnull(familias.descripcion,'') as familias_descripcion, ~n"+&
			"		  isnull(marcas.codigo,'') as marcas_codigo, ~n"+&
			"		  isnull(marcas.descripcion,'') as marcas_descripcion, ~n"+&
			"		  isnull(submarcas.codigo,'') as submarcas_codigo, ~n"+&
			"		  isnull(submarcas.descripcion,'') as submarcas_descripcion, ~n"+&
			"       0.00 as prevision_precio_medio, ~n"+&
			"		  0.00 as m2, ~n"+&
			"		  0.00 as importe, ~n"+&
			"       0.00 as prevision_importe, ~n"+&
			"       0.00 as prevision_metros, ~n"+&
			"		  '€' as moneda, ~n"+&
			"		  '###,###,##0.00' as mascara_moneda, ~n"+&
			"       '' as venagentes_agente, ~n"+&
			"       '' as venagentes_nombre ~n"+&
			" FROM paises, ~n"+&
			"      articulos, ~n"+&
			"		 familias, ~n"+&
			"		 marcas, ~n"+&
			"		 submarcas ~n"+&
			"WHERE ( articulos.empresa   = familias.empresa ) ~n"+&
			"and   ( articulos.familia = familias.codigo ) ~n"+&
			"and   ( articulos.empresa   = marcas.empresa ) ~n"+&
			"and   ( articulos.familia = marcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
			"and   ( articulos.empresa = submarcas.empresa ) ~n"+&
			"and   ( articulos.familia = submarcas.familias_codigo ) ~n"+&
			"and   ( articulos.marcas_codigo = submarcas.marcas_codigo ) ~n"+&
			"and   ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
			ls_filtro_paises+" ~n"+&
			ls_filtro_familias+" ~n"+&
			ls_filtro_marcas+" ~n"+&
			ls_filtro_submarcas+" ~n"+&
			"and   ( ( articulos.empresa = '"+codigo_empresa+"' ) ) ~n"+&
			"GROUP BY articulos.empresa, ~n"+&
			"         paises.pais, ~n"+&
			"         paises.nombre, ~n"+&
			"		    familias.codigo, ~n"+&
			"		    familias.descripcion, ~n"+&
			"		    marcas.codigo, ~n"+&
			"		    marcas.descripcion, ~n"+&
			"		    submarcas.codigo, ~n"+&
			"		    submarcas.descripcion ) as resultado ~n"+&
		   "GROUP BY resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda ~n"+&
		   "ORDER BY resultado.empresa, ~n"+&
			"       resultado.paises_pais, ~n"+&
			"       resultado.paises_descripcion, ~n"+&
			"       resultado.familias_codigo, ~n"+&
			"       resultado.familias_descripcion, ~n"+&
			"       resultado.marcas_codigo, ~n"+&
			"       resultado.marcas_descripcion, ~n"+&
			"       resultado.submarcas_codigo, ~n"+&
			"       resultado.submarcas_descripcion, ~n"+&
			"       resultado.moneda, ~n"+&
			"       resultado.mascara_moneda "
			
//clipboard(ls_sel)
//messagebox("",ls_sel)

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

if ll_total > 0 then
	if ds_datos.RowsCopy(1,ll_total, Primary!, arg_datawindow, 1, Primary!) = 1 then
		for ll_indice = 1 to ll_total
			istr_venfacprev_pais_submarca.empresa                = ds_datos.object.empresa[ll_indice]
			istr_venfacprev_pais_submarca.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_pais_submarca.paises_pais            = ds_datos.object.paises_pais[ll_indice]
			istr_venfacprev_pais_submarca.familias_codigo        = ds_datos.object.familias_codigo[ll_indice]
			istr_venfacprev_pais_submarca.marcas_codigo          = ds_datos.object.marcas_codigo[ll_indice]
			istr_venfacprev_pais_submarca.submarcas_codigo       = ds_datos.object.submarcas_codigo[ll_indice]
			istr_venfacprev_pais_submarca.prevision_precio_medio = 0
			istr_venfacprev_pais_submarca.prevision_importe      = 0
			istr_venfacprev_pais_submarca.prevision_metros       = 0
			istr_venfacprev_pais_submarca.venagentes_agente      = uo_agente.em_codigo.text
			
			if f_insert_venfacprev_pais_submarca(istr_venfacprev_pais_submarca) then
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
uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")


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

on w_mant_venfacprev_pais_submarca.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_5=create gb_5
this.cb_familias=create cb_familias
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_paises=create cb_paises
this.cb_marcas=create cb_marcas
this.cb_submarcas=create cb_submarcas
this.gb_3=create gb_3
this.uo_submarcas=create uo_submarcas
this.uo_marcas=create uo_marcas
this.uo_familias=create uo_familias
this.dw_detalle=create dw_detalle
this.uo_agente=create uo_agente
this.em_ejercicio=create em_ejercicio
this.cb_2=create cb_2
this.uo_pais=create uo_pais
this.pb_anyadir_pais=create pb_anyadir_pais
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_6=create gb_6
this.uo_paises=create uo_paises
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.cb_familias
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_paises
this.Control[iCurrent+10]=this.cb_marcas
this.Control[iCurrent+11]=this.cb_submarcas
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.uo_submarcas
this.Control[iCurrent+14]=this.uo_marcas
this.Control[iCurrent+15]=this.uo_familias
this.Control[iCurrent+16]=this.dw_detalle
this.Control[iCurrent+17]=this.uo_agente
this.Control[iCurrent+18]=this.em_ejercicio
this.Control[iCurrent+19]=this.cb_2
this.Control[iCurrent+20]=this.uo_pais
this.Control[iCurrent+21]=this.pb_anyadir_pais
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_4
this.Control[iCurrent+24]=this.gb_6
this.Control[iCurrent+25]=this.uo_paises
end on

on w_mant_venfacprev_pais_submarca.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_5)
destroy(this.cb_familias)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_paises)
destroy(this.cb_marcas)
destroy(this.cb_submarcas)
destroy(this.gb_3)
destroy(this.uo_submarcas)
destroy(this.uo_marcas)
destroy(this.uo_familias)
destroy(this.dw_detalle)
destroy(this.uo_agente)
destroy(this.em_ejercicio)
destroy(this.cb_2)
destroy(this.uo_pais)
destroy(this.pb_anyadir_pais)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_6)
destroy(this.uo_paises)
end on

event ue_f5;f_control_m2(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_venfacprev_pais_submarca
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_venfacprev_pais_submarca
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_venfacprev_pais_submarca
integer x = 9
integer y = 8
integer width = 2336
integer height = 108
end type

type pb_1 from upb_salir within w_mant_venfacprev_pais_submarca
integer x = 4750
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_mant_venfacprev_pais_submarca
integer x = 4736
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

type em_fechadesde from u_em_campo within w_mant_venfacprev_pais_submarca
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

type em_fechahasta from u_em_campo within w_mant_venfacprev_pais_submarca
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

type gb_5 from groupbox within w_mant_venfacprev_pais_submarca
integer x = 2007
integer y = 108
integer width = 1189
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

type cb_familias from commandbutton within w_mant_venfacprev_pais_submarca
integer x = 2309
integer y = 152
integer width = 297
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_familias.visible = not(uo_familias.visible)
uo_marcas.visible = false
uo_paises.visible = false
uo_submarcas.visible = false
end event

type gb_1 from groupbox within w_mant_venfacprev_pais_submarca
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

type cb_1 from u_boton within w_mant_venfacprev_pais_submarca
integer x = 4347
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

type cb_paises from commandbutton within w_mant_venfacprev_pais_submarca
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

event clicked;uo_familias.visible = false
uo_marcas.visible = false
uo_paises.visible = not(uo_paises.visible)
uo_submarcas.visible = false
end event

type cb_marcas from commandbutton within w_mant_venfacprev_pais_submarca
integer x = 2601
integer y = 152
integer width = 297
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;uo_familias.visible = false
uo_marcas.visible = not(uo_marcas.visible)
uo_paises.visible = false
uo_submarcas.visible = false
end event

type cb_submarcas from commandbutton within w_mant_venfacprev_pais_submarca
integer x = 2889
integer y = 152
integer width = 297
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;uo_familias.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_submarcas.visible = not(uo_submarcas.visible)
end event

type gb_3 from groupbox within w_mant_venfacprev_pais_submarca
integer x = 4334
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

type uo_submarcas from u_marca_lista within w_mant_venfacprev_pais_submarca
event destroy ( )
boolean visible = false
integer x = 1865
integer y = 252
integer taborder = 160
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;dw_detalle.reset()
end event

type uo_marcas from u_marca_lista within w_mant_venfacprev_pais_submarca
event destroy ( )
boolean visible = false
integer x = 1577
integer y = 252
integer taborder = 150
boolean border = false
end type

on uo_marcas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;dw_detalle.reset()
end event

type uo_familias from u_marca_lista within w_mant_venfacprev_pais_submarca
event destroy ( )
boolean visible = false
integer x = 1285
integer y = 252
integer taborder = 120
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;dw_detalle.reset()
end event

type dw_detalle from u_datawindow_consultas within w_mant_venfacprev_pais_submarca
integer x = 5
integer y = 256
integer width = 4855
integer height = 3492
integer taborder = 110
string dataobject = "dw_mant_venfacprev_pais_submarca"
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

event itemchanged;call super::itemchanged;str_venfacprev_pais_submarca istr_venfacprev_pais_submarca

if uo_agente.em_codigo.text = "" then
	return 2
else
	choose case dwo.name
		case "prevision_precio_medio"
			istr_venfacprev_pais_submarca.empresa                = this.object.empresa[row]
			istr_venfacprev_pais_submarca.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_pais_submarca.paises_pais            = this.object.paises_pais[row]
			istr_venfacprev_pais_submarca.familias_codigo        = this.object.familias_codigo[row]
			istr_venfacprev_pais_submarca.marcas_codigo          = this.object.marcas_codigo[row]
			istr_venfacprev_pais_submarca.submarcas_codigo       = this.object.submarcas_codigo[row]
			istr_venfacprev_pais_submarca.prevision_precio_medio = dec(data)
			istr_venfacprev_pais_submarca.prevision_importe      = round(this.object.prevision_metros[row] * dec(data),2)
			istr_venfacprev_pais_submarca.prevision_metros       = this.object.prevision_metros[row]
			istr_venfacprev_pais_submarca.venagentes_agente      = uo_agente.em_codigo.text//this.object.venagentes_agente[row]
			
			if f_insert_venfacprev_pais_submarca(istr_venfacprev_pais_submarca) then
				commit;
				this.object.prevision_importe[row] = istr_venfacprev_pais_submarca.prevision_importe
			else
				rollback;
				return 2
			end if
		case "prevision_importe"
			istr_venfacprev_pais_submarca.empresa                = this.object.empresa[row]
			istr_venfacprev_pais_submarca.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_pais_submarca.paises_pais            = this.object.paises_pais[row]
			istr_venfacprev_pais_submarca.familias_codigo        = this.object.familias_codigo[row]
			istr_venfacprev_pais_submarca.marcas_codigo          = this.object.marcas_codigo[row]
			istr_venfacprev_pais_submarca.submarcas_codigo       = this.object.submarcas_codigo[row]
			istr_venfacprev_pais_submarca.prevision_precio_medio = this.object.prevision_precio_medio[row]
			istr_venfacprev_pais_submarca.prevision_importe      = dec(data)
			if this.object.prevision_precio_medio[row] <> 0 then
				istr_venfacprev_pais_submarca.prevision_metros       = round((dec(data) / this.object.prevision_precio_medio[row]),2)
			else
				istr_venfacprev_pais_submarca.prevision_metros       = 0
			end if
			istr_venfacprev_pais_submarca.venagentes_agente      = uo_agente.em_codigo.text//this.object.venagentes_agente[row]
			
			if f_insert_venfacprev_pais_submarca(istr_venfacprev_pais_submarca) then
				commit;
				this.object.prevision_metros[row] = istr_venfacprev_pais_submarca.prevision_metros
			else
				rollback;
				return 2
			end if		
		case "prevision_metros"
			istr_venfacprev_pais_submarca.empresa                = this.object.empresa[row]
			istr_venfacprev_pais_submarca.ejercicio              = dec(em_ejercicio.text)
			istr_venfacprev_pais_submarca.paises_pais            = this.object.paises_pais[row]
			istr_venfacprev_pais_submarca.familias_codigo        = this.object.familias_codigo[row]
			istr_venfacprev_pais_submarca.marcas_codigo          = this.object.marcas_codigo[row]
			istr_venfacprev_pais_submarca.submarcas_codigo       = this.object.submarcas_codigo[row]
			istr_venfacprev_pais_submarca.prevision_precio_medio = this.object.prevision_precio_medio[row]
			istr_venfacprev_pais_submarca.prevision_importe      = round((dec(data) * this.object.prevision_precio_medio[row]),2)
			istr_venfacprev_pais_submarca.prevision_metros       = dec(data)
			istr_venfacprev_pais_submarca.venagentes_agente      = uo_agente.em_codigo.text//this.object.venagentes_agente[row]
			
			if f_insert_venfacprev_pais_submarca(istr_venfacprev_pais_submarca) then
				commit;
				this.object.prevision_importe[row] = istr_venfacprev_pais_submarca.prevision_importe
			else
				rollback;
				return 2
			end if		
	end choose
end if
end event

type uo_agente from u_em_campo_2 within w_mant_venfacprev_pais_submarca
event destroy ( )
integer x = 562
integer y = 152
integer width = 1426
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;dw_detalle.reset()

this.em_campo.text=f_nombre_agente(codigo_empresa,this.em_codigo.text)

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Agentes"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type em_ejercicio from u_em_campo within w_mant_venfacprev_pais_submarca
integer x = 3369
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

type cb_2 from commandbutton within w_mant_venfacprev_pais_submarca
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

type uo_pais from u_em_campo_2 within w_mant_venfacprev_pais_submarca
event destroy ( )
integer x = 3625
integer y = 152
integer width = 608
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;long ll_donde

pb_anyadir_pais.enabled = false

uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
else
	ll_donde = dw_detalle.find("paises_pais = '"+uo_pais.em_codigo.text+"'",1,dw_detalle.rowcount())
	
	if ll_donde > 0 then
		uo_pais.em_campo.text=""
		uo_pais.em_codigo.text=""		
	else
		pb_anyadir_pais.enabled = true	
	end if
end if 
end event

event getfocus;call super::getfocus;int li_opciones,li_opciones_marcadas,li_indice
string ls_filtro,ls_texto_seleccion,ls_filtro_paises

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
		ls_filtro_paises = " #1 in ("+ls_filtro+") "
	else
		ls_filtro_paises = " #1 = "+ls_filtro+" "
	end if
end if

//Fin de filtro de paises

ue_titulo = "Selección de Paises"
ue_datawindow ="dw_ayuda_paises"
ue_filtro = ls_filtro_paises
valor_empresa = FALSE

end event

type pb_anyadir_pais from picturebutton within w_mant_venfacprev_pais_submarca
integer x = 4233
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
string picturename = "\Tencer_PB12\navigate_plus.png"
end type

event clicked;f_anyadir_pais(dw_detalle,uo_pais.em_codigo.text)

this.enabled = false
end event

type gb_2 from groupbox within w_mant_venfacprev_pais_submarca
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
string text = "Agente"
end type

type gb_4 from groupbox within w_mant_venfacprev_pais_submarca
integer x = 3200
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

type gb_6 from groupbox within w_mant_venfacprev_pais_submarca
integer x = 3616
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
string text = "Añadir Pais"
end type

type uo_paises from u_marca_lista within w_mant_venfacprev_pais_submarca
event destroy ( )
boolean visible = false
integer x = 992
integer y = 252
integer taborder = 140
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;dw_detalle.reset()
end event

