$PBExportHeader$w_con_ventas_familia_marca_submarca_3grupos.srw
forward
global type w_con_ventas_familia_marca_submarca_3grupos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ventas_familia_marca_submarca_3grupos
end type
type pb_2 from upb_imprimir within w_con_ventas_familia_marca_submarca_3grupos
end type
type em_fechadesde from u_em_campo within w_con_ventas_familia_marca_submarca_3grupos
end type
type em_fechahasta from u_em_campo within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_5 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_cliente from u_em_campo_2 within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_familias from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_formatos from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_familias from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_formatos from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_2 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_1 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_1 from u_boton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_paises from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_2 from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_pavrev from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_marcas from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type cb_submarcas from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_marcas from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_submarcas from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_3 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type dw_detalle from u_datawindow_consultas within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_pavrev from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_agentes from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type uo_paises from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
end type
type rb_pais from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type rb_agente from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type rb_cliente from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
end type
type ddlb_promocion from dropdownlistbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_4 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
type gb_6 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
end type
end forward

global type w_con_ventas_familia_marca_submarca_3grupos from w_int_con_empresa
integer width = 4910
integer height = 3912
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_5 gb_5
uo_cliente uo_cliente
cb_familias cb_familias
cb_formatos cb_formatos
uo_familias uo_familias
uo_formatos uo_formatos
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
cb_paises cb_paises
cb_2 cb_2
cb_pavrev cb_pavrev
cb_marcas cb_marcas
cb_submarcas cb_submarcas
uo_marcas uo_marcas
uo_submarcas uo_submarcas
gb_3 gb_3
dw_detalle dw_detalle
uo_pavrev uo_pavrev
uo_agentes uo_agentes
uo_paises uo_paises
rb_pais rb_pais
rb_agente rb_agente
rb_cliente rb_cliente
ddlb_promocion ddlb_promocion
gb_4 gb_4
gb_6 gb_6
end type
global w_con_ventas_familia_marca_submarca_3grupos w_con_ventas_familia_marca_submarca_3grupos

type variables
string grafico = "N", is_sort_inicial, is_texto_t_descripcion, is_texto_t_pzs, is_texto_t_m2, is_texto_t_importe
int ii_grupo_desplegado, ii_max_grupos = 3
end variables

forward prototypes
public subroutine f_control_m2 (datawindow arg_datawindow)
public subroutine f_control_m2_old (datawindow arg_datawindow)
end prototypes

public subroutine f_control_m2 (datawindow arg_datawindow);string ls_codigo,ls_filtro, ls_filtro_paises, ls_filtro_agentes, ls_filtro_pavrev, ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_cliente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_total
datetime ldt_fecha_desde,ldt_fecha_hasta

datastore ds_datos

arg_datawindow.reset()
arg_datawindow.setredraw(false)
ls_sort_actual = arg_datawindow.describe("datawindow.table.sort")
arg_datawindow.setsort(is_sort_inicial)

uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

ii_grupo_desplegado = 0

if ddlb_promocion.text = "Todo" then
	ls_filtro_articulos = ""
else
	if ddlb_promocion.text = "Si" then
		//ls_filtro_articulos = " AND     ( articulos.promocion = 'S' ) "
		ls_filtro_articulos = " AND     ( venlifac.tipolinea in ('4','9') ) "
	else
		if ddlb_promocion.text = "No" then
			//ls_filtro_articulos = " AND     ( articulos.promocion <> 'S' ) "
			ls_filtro_articulos = " AND     ( venlifac.tipolinea not in ('4','9') ) "
		else
			ls_filtro_articulos = " AND 0 = 1 "
		end if
	end if	
end if

arg_datawindow.modify("t_descripcion.text = 'Familia/Marca/Submarca'")

ls_campos_select = "		  articulos.familia, ~n"+&
						"		  familias.descripcion, ~n"+&
						"		  articulos.marcas_codigo, ~n"+&
						"		  marcas.descripcion, ~n"+&
						"		  articulos.submarcas_codigo, ~n"+&
						"		  submarcas.descripcion, ~n"
						
ls_campos_group_by = "		   articulos.familia, ~n"+&
							"		    familias.descripcion, ~n"+&
							"		    articulos.marcas_codigo, ~n"+&
							"		    marcas.descripcion, ~n"+&
							"		    articulos.submarcas_codigo, ~n"+&
							"		    submarcas.descripcion, ~n"


if uo_cliente.em_codigo.text <> "" then
	ls_filtro_cliente = " and genter.codigo = '"+uo_cliente.em_codigo.text+"' "	
else
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
			ls_filtro_paises = " and genter.pais in ("+ls_filtro+") "
		else
			ls_filtro_paises = " and genter.pais = "+ls_filtro+" "
		end if
	end if
	
	if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
		ls_filtro_paises = ""
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
end if

//Filtro de agentes
li_opciones = uo_agentes.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_agentes.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_agentes.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_agentes.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_agentes.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_agentes.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_agentes = " and venfac.agente1 in ("+ls_filtro+") "
	else
		ls_filtro_agentes = " and venfac.agente1 = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_agentes = ""
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS AGENTES"	
	else
		ls_texto_filtro += "~nTODOS LOS AGENTES"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "AGENTES : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nAGENTES : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de agentes

//Filtro de pavrev
li_opciones = uo_pavrev.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_pavrev.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_pavrev.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_pavrev.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') in ("+ls_filtro+") "
	else
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_pavrev = ""
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAVIMENTO Y REVESTIMIENTO"	
	else
		ls_texto_filtro += "~nPAVIMENTO Y REVESTIMIENTO"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = ls_texto_seleccion
	else
		ls_texto_filtro += "~n"+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de pavrev

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
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_familias = ""
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
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_marcas = ""
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
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_submarcas = ""
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

//Filtro de formatos
li_opciones = uo_formatos.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_formatos.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_formatos.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_formatos.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_formatos = " and articulos.formato in ("+ls_filtro+") "
	else
		ls_filtro_formatos = " and articulos.formato = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	ls_filtro_formatos = ""
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS FORMATOS"	
	else
		ls_texto_filtro += "~nTODOS LOS FORMATOS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FORMATOS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFORMATOS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de formatos
datetime ldt_fecha_desde_ant,ldt_fecha_hasta_ant

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))

ldt_fecha_desde_ant = datetime(f_misma_fecha_ejercicio_anterior(date(ldt_fecha_desde)))
ldt_fecha_hasta_ant = datetime(f_misma_fecha_ejercicio_anterior(date(ldt_fecha_hasta)))

arg_datawindow.modify("t_periodo_ant.text = '"+string(ldt_fecha_desde_ant,"dd-mm-yyyy")+" "+string(ldt_fecha_hasta_ant,"dd-mm-yyyy")+"'")
arg_datawindow.modify("t_periodo.text = '"+string(ldt_fecha_desde,"dd-mm-yyyy")+" "+string(ldt_fecha_hasta,"dd-mm-yyyy")+"'")

ls_sel = "SELECT venfac.empresa, ~n"+&
ls_campos_select+&
"		  venlifac.articulo, ~n"+&
"		  articulos.descripcion, ~n"+&
"		  sum(case when venlifac.tipo_unidad <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as pzs, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as m2, ~n"+&
"		  convert(dec(16,2),sum(case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then (venlifac.neto - venlifac.impdtopp ) / venfac.cambio else 0 end )) as importe, ~n"+&
"		  sum(case when venlifac.tipo_unidad  <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp ) / venfac.cambio) else 0 end else 0 end) as importe_pzs, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp ) / venfac.cambio) else 0 end else 0 end) as importe_m2, ~n"+&
"		  sum(case when venlifac.tipo_unidad <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as pzs_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as m2_ant, ~n"+&
"		  convert(dec(16,2),sum(case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then (venlifac.neto - venlifac.impdtopp ) / venfac.cambio else 0 end )) as importe_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp ) / venfac.cambio) else 0 end else 0 end) as importe_pzs_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp ) / venfac.cambio) else 0 end else 0 end) as importe_m2_ant, ~n"+&
"		  '€' as moneda, ~n"+&
"		  '###,###,##0' as mascara_moneda, ~n"+&
"		  '###,###,##0.00' as mascara_precios_moneda ~n"+&
" FROM venfac ~n"+&
" 	INNER JOIN venlifac On ( venfac.empresa = venlifac.empresa ) ~n"+&
"	and   ( venfac.anyo = venlifac.anyo ) ~n"+&
"	and   ( venfac.factura = venlifac.factura ) ~n"+&
" 	INNER JOIN genter ON ( venfac.empresa = genter.empresa ) ~n"+&
"	and   ( venfac.cliente = genter.codigo ) ~n"+&
"	and   ( genter.tipoter = 'C' ) ~n"+&
"  	INNER JOIN paises ON  ( genter.pais = paises.pais ) ~n"+&
" 	LEFT OUTER JOIN venagentes ON  ( venfac.empresa = venagentes.empresa ) ~n"+&
"	and   ( venfac.agente1 = venagentes.agente ) ~n"+&
"   INNER JOIN articulos ON   ( venlifac.empresa = articulos.empresa ) ~n"+&
"	and   ( venlifac.articulo = articulos.codigo ) ~n"+&
" 	LEFT OUTER JOIN familias ON   ( articulos.empresa = familias.empresa ) ~n"+&
"	and   ( articulos.familia = familias.codigo ) ~n"+&
"   LEFT OUTER JOIN formatos ON  ( articulos.empresa = formatos.empresa ) ~n"+&
"	and   ( articulos.formato = formatos.codigo ) ~n"+&
" 	LEFT OUTER JOIN marcas ON ( articulos.empresa =  marcas.empresa ) ~n"+&
"	and    ( articulos.marcas_codigo = marcas.codigo ) ~n"+&
" 	LEFT OUTER JOIN submarcas ON  ( articulos.empresa =  submarcas.empresa ) ~n"+&
"	and    ( articulos.submarcas_codigo = submarcas.codigo ) ~n"+&
"	LEFT OUTER JOIN art_codestadistico ON  ( articulos.empresa = art_codestadistico.empresa ) ~n"+&
"	and   ( articulos.codigo = art_codestadistico.codigo ) ~n"+&
"where   ( ( venfac.empresa = '"+codigo_empresa+"' ) ~n"+&
"AND     ( venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' or venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' ) ~n"+&
"and    ltrim(rtrim(venlifac.tipolinea)) not in('3','17') ~n"+&
ls_filtro_cliente+" ~n"+&
ls_filtro_paises+" ~n"+&
ls_filtro_agentes+" ~n"+&
ls_filtro_pavrev+" ~n"+&
ls_filtro_familias+" ~n"+&
ls_filtro_formatos+" ~n"+&
ls_filtro_marcas+" ~n"+&
ls_filtro_submarcas+" ~n"+&
ls_filtro_articulos+&
" ) ~n"+&
"GROUP BY venfac.empresa, ~n"+&
ls_campos_group_by+&
"		    venlifac.articulo, ~n"+&
"		    articulos.descripcion, ~n"+&
"		    venlifac.tipo_unidad "

//"and    ltrim(rtrim(venlifac.tipolinea)) not in('3','4','9','17') ~n"+&
//clipboard(ls_sel)

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

if ll_total > 0 then
	arg_datawindow.object.data = ds_datos.object.data
end if
destroy ds_datos

arg_datawindow.sort()
arg_datawindow.groupcalc()

arg_datawindow.setsort ( ls_sort_actual )
arg_datawindow.setredraw(true)
arg_datawindow.sort()
arg_datawindow.modify("t_filtro.text= '"+ls_texto_filtro+"'")
//arg_datawindow.groupcalc()
end subroutine

public subroutine f_control_m2_old (datawindow arg_datawindow);string ls_codigo,ls_filtro, ls_filtro_paises, ls_filtro_agentes, ls_filtro_pavrev, ls_filtro_familias,ls_filtro_formatos,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_cliente
string ls_sel,ls_campos_select,ls_campos_group_by,ls_filtro_articulos,ls_sort_actual,ls_texto_seleccion,ls_texto_filtro
integer li_indice,li_opciones,li_opciones_marcadas
long    ll_total
datetime ldt_fecha_desde,ldt_fecha_hasta

datastore ds_datos

arg_datawindow.reset()
arg_datawindow.setredraw(false)
ls_sort_actual = arg_datawindow.describe("datawindow.table.sort")
arg_datawindow.setsort(is_sort_inicial)

uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

ii_grupo_desplegado = 0

if ddlb_promocion.text = "Todo" then
	ls_filtro_articulos = ""
else
	if ddlb_promocion.text = "Si" then
		ls_filtro_articulos = " AND     ( articulos.promocion = 'S' ) "
	else
		if ddlb_promocion.text = "No" then
			ls_filtro_articulos = " AND     ( articulos.promocion = 'N' ) "
		else
			ls_filtro_articulos = " AND 0 = 1 "
		end if
	end if	
end if


arg_datawindow.modify("t_descripcion.text = 'Familia/Marca/Submarca'")

ls_campos_select = "		  articulos.familia, ~n"+&
						"		  familias.descripcion, ~n"+&
						"		  articulos.marcas_codigo, ~n"+&
						"		  marcas.descripcion, ~n"+&
						"		  articulos.submarcas_codigo, ~n"+&
						"		  submarcas.descripcion, ~n"
						
ls_campos_group_by = "		   articulos.familia, ~n"+&
							"		    familias.descripcion, ~n"+&
							"		    articulos.marcas_codigo, ~n"+&
							"		    marcas.descripcion, ~n"+&
							"		    articulos.submarcas_codigo, ~n"+&
							"		    submarcas.descripcion, ~n"




//if rb_pais.checked then
//	arg_datawindow.modify("t_descripcion.text = 'Pais/Familia/Marca/Submarca'")
//	
//	ls_campos_select = "		  genter.pais, ~n"+&
//							"		  paises.nombre, ~n"+&
//							"		  articulos.familia, ~n"+&
//							"		  familias.descripcion, ~n"+&
//							"		  articulos.marcas_codigo, ~n"+&
//							"		  marcas.descripcion, ~n"+&
//							"		  articulos.submarcas_codigo, ~n"+&
//							"		  submarcas.descripcion, ~n"
//							
//	ls_campos_group_by = "		    genter.pais, ~n"+&
//								"		    paises.nombre, ~n"+&
//								"		    articulos.familia, ~n"+&
//								"		    familias.descripcion, ~n"+&
//								"		    articulos.marcas_codigo, ~n"+&
//								"		    marcas.descripcion, ~n"+&
//								"		    articulos.submarcas_codigo, ~n"+&
//								"		    submarcas.descripcion, ~n"
//else
//	if rb_cliente.checked then
//		arg_datawindow.modify("t_descripcion.text = 'Cliente/Familia/Marca/Submarca'")
//		
//		ls_campos_select = "		  genter.codigo, ~n"+&
//								"		  genter.razon, ~n"+&
//								"		  articulos.familia, ~n"+&
//								"		  familias.descripcion, ~n"+&
//								"		  articulos.marcas_codigo, ~n"+&
//								"		  marcas.descripcion, ~n"+&
//								"		  articulos.submarcas_codigo, ~n"+&
//								"		  submarcas.descripcion, ~n"
//								
//		ls_campos_group_by = "		    genter.codigo, ~n"+&
//									"		    genter.razon, ~n"+&
//									"		    articulos.familia, ~n"+&
//									"		    familias.descripcion, ~n"+&
//									"		    articulos.marcas_codigo, ~n"+&
//									"		    marcas.descripcion, ~n"+&
//									"		    articulos.submarcas_codigo, ~n"+&
//									"		    submarcas.descripcion, ~n"							
//	else
//		arg_datawindow.modify("t_descripcion.text = 'Agente/Familia/Marca/Submarca'")
//		
//		ls_campos_select = "		  venfac.agente1, ~n"+&
//								"		  venagentes.nombre, ~n"+&
//								"		  articulos.familia, ~n"+&
//								"		  familias.descripcion, ~n"+&
//								"		  articulos.marcas_codigo, ~n"+&
//								"		  marcas.descripcion, ~n"+&
//								"		  articulos.submarcas_codigo, ~n"+&
//								"		  submarcas.descripcion, ~n"
//								
//		ls_campos_group_by = "		    venfac.agente1, ~n"+&
//									"		    venagentes.nombre, ~n"+&
//									"		    articulos.familia, ~n"+&
//									"		    familias.descripcion, ~n"+&
//									"		    articulos.marcas_codigo, ~n"+&
//									"		    marcas.descripcion, ~n"+&
//									"		    articulos.submarcas_codigo, ~n"+&
//									"		    submarcas.descripcion, ~n"																
//	end if							
//end if

if uo_cliente.em_codigo.text <> "" then
	ls_filtro_cliente = " and genter.codigo = '"+uo_cliente.em_codigo.text+"' "	
else
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
			ls_filtro_paises = " and genter.pais in ("+ls_filtro+") "
		else
			ls_filtro_paises = " and genter.pais = "+ls_filtro+" "
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
end if

//Filtro de agentes
li_opciones = uo_agentes.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_agentes.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_agentes.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_agentes.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_agentes.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_agentes.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_agentes = " and venfac.agente1 in ("+ls_filtro+") "
	else
		ls_filtro_agentes = " and venfac.agente1 = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS AGENTES"	
	else
		ls_texto_filtro += "~nTODOS LOS AGENTES"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "AGENTES : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nAGENTES : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de agentes

//Filtro de pavrev
li_opciones = uo_pavrev.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_pavrev.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_pavrev.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_pavrev.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') in ("+ls_filtro+") "
	else
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAVIMENTO Y REVESTIMIENTO"	
	else
		ls_texto_filtro += "~nPAVIMENTO Y REVESTIMIENTO"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = ls_texto_seleccion
	else
		ls_texto_filtro += "~n"+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de pavrev

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
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
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
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
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
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
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

//Filtro de formatos
li_opciones = uo_formatos.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_formatos.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_formatos.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_formatos.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_formatos = " and articulos.formato in ("+ls_filtro+") "
	else
		ls_filtro_formatos = " and articulos.formato = "+ls_filtro+" "
	end if
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS FORMATOS"	
	else
		ls_texto_filtro += "~nTODOS LOS FORMATOS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FORMATOS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFORMATOS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de formatos
datetime ldt_fecha_desde_ant,ldt_fecha_hasta_ant

ldt_fecha_desde = DateTime(Date(em_fechadesde.text))
ldt_fecha_hasta = DateTime(Date(em_fechahasta.text))

ldt_fecha_desde_ant = datetime(f_misma_fecha_ejercicio_anterior(date(ldt_fecha_desde)))
ldt_fecha_hasta_ant = datetime(f_misma_fecha_ejercicio_anterior(date(ldt_fecha_hasta)))

arg_datawindow.modify("t_periodo_ant.text = '"+string(ldt_fecha_desde_ant,"dd-mm-yyyy")+" "+string(ldt_fecha_hasta_ant,"dd-mm-yyyy")+"'")
arg_datawindow.modify("t_periodo.text = '"+string(ldt_fecha_desde,"dd-mm-yyyy")+" "+string(ldt_fecha_hasta,"dd-mm-yyyy")+"'")

ls_sel = "SELECT venfac.empresa, ~n"+&
ls_campos_select+&
"		  venlifac.articulo, ~n"+&
"		  articulos.descripcion, ~n"+&
"		  sum(case when venlifac.tipo_unidad <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as pzs, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as m2, ~n"+&
"		  convert(dec(16,2),sum(case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then (venlifac.neto - venlifac.impdtopp) / venfac.cambio else 0 end )) as importe, ~n"+&
"		  sum(case when venlifac.tipo_unidad  <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end else 0 end) as importe_pzs, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end else 0 end) as importe_m2, ~n"+&
"		  sum(case when venlifac.tipo_unidad <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as pzs_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then isnull(venlifac.cantidad,0) else 0 end else 0 end) as m2_ant, ~n"+&
"		  convert(dec(16,2),sum(case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then (venlifac.neto - venlifac.impdtopp) / venfac.cambio else 0 end )) as importe_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  <> '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end else 0 end) as importe_pzs_ant, ~n"+&
"		  sum(case when venlifac.tipo_unidad  = '1' then case when venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end else 0 end) as importe_m2_ant, ~n"+&
"		  '€' as moneda, ~n"+&
"		  '###,###,##0' as mascara_moneda, ~n"+&
"		  '###,###,##0.00' as mascara_precios_moneda ~n"+&
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
"      art_codestadistico ~n"+&
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
ls_filtro_cliente+" ~n"+&
ls_filtro_paises+" ~n"+&
ls_filtro_agentes+" ~n"+&
ls_filtro_pavrev+" ~n"+&
ls_filtro_familias+" ~n"+&
ls_filtro_formatos+" ~n"+&
ls_filtro_marcas+" ~n"+&
ls_filtro_submarcas+" ~n"+&
"and   ( ( venfac.empresa = '"+codigo_empresa+"' ) ~n"+&
"AND     ( venfac.ffactura between '"+string(ldt_fecha_desde,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,gs_formato_fecha_cursores)+"' or venfac.ffactura between '"+string(ldt_fecha_desde_ant,gs_formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta_ant,gs_formato_fecha_cursores)+"' ) ~n"+&
ls_filtro_articulos+&
" ) ~n"+&
"GROUP BY venfac.empresa, ~n"+&
ls_campos_group_by+&
"		    venlifac.articulo, ~n"+&
"		    articulos.descripcion, ~n"+&
"		    venlifac.tipo_unidad "

/*
ls_sel = "SELECT venfac.empresa, ~n"+&
ls_campos_select+&
"		  venlifac.articulo, ~n"+&
"		  articulos.descripcion, ~n"+&
"		  sum(case when articulos.unidad <> '1' then isnull(venlifac.cantidad,0) else 0 end) as pzs, ~n"+&
"		  sum(case when articulos.unidad = '1' then venlifac.cantidad else 0 end) as m2, ~n"+&
"		  convert(dec(16,2),sum((venlifac.neto - venlifac.impdtopp) / venfac.cambio)) as importe, ~n"+&
"		  sum(case when articulos.unidad <> '1' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end) as importe_pzs, ~n"+&
"		  sum(case when articulos.unidad = '1' then ((venlifac.neto - venlifac.impdtopp) / venfac.cambio) else 0 end) as importe_m2, ~n"+&
"		  '€' as moneda, ~n"+&
"		  '###,###,##0.00' as mascara_moneda ~n"+&
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
"      art_codestadistico ~n"+&
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
ls_filtro_cliente+" ~n"+&
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
ls_campos_group_by+&
"		    venlifac.articulo, ~n"+&
"		    articulos.descripcion, ~n"+&
"		    articulos.unidad"
*/
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

event open;call super::open;istr_parametros.s_titulo_ventana = "Ventas por Familia,Marca y Submarca 3 Grupos"

This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())

dw_detalle.SetTransObject(SQLCA)

valor_empresa = FALSE
uo_paises.f_cargar_datos("dw_ayuda_paises","%","","Pais","Descripción")
valor_empresa = TRUE
uo_agentes.f_cargar_datos("dw_ayuda_venagentes","%","","Agente","Descripción")
uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_formatos.f_cargar_datos("dw_ayuda_formatos","%","","Formato","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_pavrev.f_cargar_datos("dw_ayuda_pavrev","%","","PavRev","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")


dw_detalle.ue_marca_linea=false

is_sort_inicial        = dw_detalle.describe("datawindow.table.sort")
is_texto_t_descripcion = dw_detalle.describe("t_descripcion.text")
is_texto_t_pzs         = dw_detalle.describe("t_pzs.text")
is_texto_t_m2          = dw_detalle.describe("t_m2.text")
is_texto_t_importe     = dw_detalle.describe("t_importe.text")

dw_detalle.setsort("importe_g1_2 D,importe_g2_2 D,importe_g3_2 D, importe D,"+is_sort_inicial)
dw_detalle.modify("t_importe.text='"+is_texto_t_importe+" \/'")

//nivel1_descripcion A nivel1_codigo A nivel2_descripcion A nivel2_codigo A nivel3_descripcion A nivel3_codigo A nivel4_descripcion A nivel4_codigo A detalle_descripcion A detalle_codigo A

f_activar_campo(em_fechadesde)



end event

on w_con_ventas_familia_marca_submarca_3grupos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_5=create gb_5
this.uo_cliente=create uo_cliente
this.cb_familias=create cb_familias
this.cb_formatos=create cb_formatos
this.uo_familias=create uo_familias
this.uo_formatos=create uo_formatos
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_paises=create cb_paises
this.cb_2=create cb_2
this.cb_pavrev=create cb_pavrev
this.cb_marcas=create cb_marcas
this.cb_submarcas=create cb_submarcas
this.uo_marcas=create uo_marcas
this.uo_submarcas=create uo_submarcas
this.gb_3=create gb_3
this.dw_detalle=create dw_detalle
this.uo_pavrev=create uo_pavrev
this.uo_agentes=create uo_agentes
this.uo_paises=create uo_paises
this.rb_pais=create rb_pais
this.rb_agente=create rb_agente
this.rb_cliente=create rb_cliente
this.ddlb_promocion=create ddlb_promocion
this.gb_4=create gb_4
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.cb_familias
this.Control[iCurrent+8]=this.cb_formatos
this.Control[iCurrent+9]=this.uo_familias
this.Control[iCurrent+10]=this.uo_formatos
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_paises
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.cb_pavrev
this.Control[iCurrent+17]=this.cb_marcas
this.Control[iCurrent+18]=this.cb_submarcas
this.Control[iCurrent+19]=this.uo_marcas
this.Control[iCurrent+20]=this.uo_submarcas
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.dw_detalle
this.Control[iCurrent+23]=this.uo_pavrev
this.Control[iCurrent+24]=this.uo_agentes
this.Control[iCurrent+25]=this.uo_paises
this.Control[iCurrent+26]=this.rb_pais
this.Control[iCurrent+27]=this.rb_agente
this.Control[iCurrent+28]=this.rb_cliente
this.Control[iCurrent+29]=this.ddlb_promocion
this.Control[iCurrent+30]=this.gb_4
this.Control[iCurrent+31]=this.gb_6
end on

on w_con_ventas_familia_marca_submarca_3grupos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_5)
destroy(this.uo_cliente)
destroy(this.cb_familias)
destroy(this.cb_formatos)
destroy(this.uo_familias)
destroy(this.uo_formatos)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_paises)
destroy(this.cb_2)
destroy(this.cb_pavrev)
destroy(this.cb_marcas)
destroy(this.cb_submarcas)
destroy(this.uo_marcas)
destroy(this.uo_submarcas)
destroy(this.gb_3)
destroy(this.dw_detalle)
destroy(this.uo_pavrev)
destroy(this.uo_agentes)
destroy(this.uo_paises)
destroy(this.rb_pais)
destroy(this.rb_agente)
destroy(this.rb_cliente)
destroy(this.ddlb_promocion)
destroy(this.gb_4)
destroy(this.gb_6)
end on

event ue_f5;f_control_m2(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ventas_familia_marca_submarca_3grupos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ventas_familia_marca_submarca_3grupos
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ventas_familia_marca_submarca_3grupos
integer x = 9
integer y = 8
integer width = 2336
integer height = 108
end type

type pb_1 from upb_salir within w_con_ventas_familia_marca_submarca_3grupos
integer x = 4782
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ventas_familia_marca_submarca_3grupos
integer x = 4768
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
boolean ibCabecera = true,ibLandScape = true
blob datos
long ld_zoom
// Recepciono los datos de la datawindow
dw_detalle.getfullstate(datos)

ld_zoom = dec(dw_detalle.Object.DataWindow.Zoom)

isTitulo    = parent.title
isSubTitulo =  "Desde '"+em_fechadesde.text +"' hasta '"+em_fechahasta.text+"' "+uo_cliente.em_campo.text
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

ii_grupo_desplegado = 0
end event

type em_fechadesde from u_em_campo within w_con_ventas_familia_marca_submarca_3grupos
integer x = 18
integer y = 152
integer width = 274
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ventas_familia_marca_submarca_3grupos
integer x = 293
integer y = 152
integer width = 274
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_5 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 1472
integer y = 108
integer width = 2043
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

type uo_cliente from u_em_campo_2 within w_con_ventas_familia_marca_submarca_3grupos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 599
integer y = 152
integer width = 855
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;this.em_campo.text=f_razon_genter(codigo_empresa,'C',this.em_codigo.text)

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_venclientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type cb_familias from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 2345
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
string text = "Familias"
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = not(uo_familias.visible)
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_formatos from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 3209
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
string text = "Formatos"
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = not(uo_formatos.visible)
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type uo_familias from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 1285
integer y = 252
integer taborder = 100
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type uo_formatos from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 2149
integer y = 252
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type gb_2 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 585
integer y = 108
integer width = 882
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

type gb_1 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 5
integer y = 108
integer width = 576
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fechas"
end type

type cb_1 from u_boton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 4379
integer y = 152
integer width = 384
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F5 Consultar"
end type

event clicked;f_control_m2(dw_detalle)
end event

type cb_paises from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 1481
integer y = 152
integer width = 297
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Paises"
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = not(uo_paises.visible)
uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_2 from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 1769
integer y = 152
integer width = 297
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agentes"
end type

event clicked;uo_agentes.visible = not(uo_agentes.visible)
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_pavrev from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 2057
integer y = 152
integer width = 297
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pav./Rev."
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = not(uo_pavrev.visible)
uo_submarcas.visible = false
end event

type cb_marcas from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 2638
integer y = 152
integer width = 297
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = not(uo_marcas.visible)
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_submarcas from commandbutton within w_con_ventas_familia_marca_submarca_3grupos
integer x = 2926
integer y = 152
integer width = 297
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;uo_agentes.visible = false
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_paises.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = not(uo_submarcas.visible)
end event

type uo_marcas from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 1577
integer y = 252
integer taborder = 120
boolean bringtotop = true
boolean border = false
end type

on uo_marcas.destroy
call u_marca_lista::destroy
end on

type uo_submarcas from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 1865
integer y = 252
integer taborder = 130
boolean bringtotop = true
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

type gb_3 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 4366
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

type dw_detalle from u_datawindow_consultas within w_con_ventas_familia_marca_submarca_3grupos
integer y = 380
integer width = 4901
integer height = 3368
integer taborder = 90
string dataobject = "dw_con_ventas_familia_marca_submarca_3grupos"
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
	else
		choose case dwo.name				
			case "t_descripcion"
				dw_detalle.setsort(is_sort_inicial)
				dw_detalle.sort()
				dw_detalle.groupcalc()
				dw_detalle.modify("t_descripcion.text='"+is_texto_t_descripcion+" \/'")				
				dw_detalle.modify("t_pzs.text='"+is_texto_t_pzs+"'")	
				dw_detalle.modify("t_m2.text='"+is_texto_t_m2+"'")	
				dw_detalle.modify("t_importe.text='"+is_texto_t_importe+"'")	
				dw_detalle.sort()
				dw_detalle.groupcalc()
			case "t_pzs"
//				dw_detalle.setsort(is_sort_inicial)
//				dw_detalle.sort()
//				dw_detalle.groupcalc()
//				dw_detalle.setsort("pzs_g1 D,pzs_g2 D,pzs_g3 D,pzs_g4 D,pzs D,"+is_sort_inicial)
//				dw_detalle.modify("t_descripcion.text='"+is_texto_t_descripcion+"'")				
//				dw_detalle.modify("t_pzs.text='"+is_texto_t_pzs+" \/'")	
//				dw_detalle.modify("t_m2.text='"+is_texto_t_m2+"'")	
//				dw_detalle.modify("t_importe.text='"+is_texto_t_importe+"'")					
//				dw_detalle.sort()
//				dw_detalle.groupcalc()
			case "t_m2"
				dw_detalle.setsort(is_sort_inicial)
				dw_detalle.sort()
				dw_detalle.groupcalc()				
				dw_detalle.setsort("m2_g1 D,m2_g2 D,m2_g3 D, m2 D,"+is_sort_inicial)
				dw_detalle.modify("t_descripcion.text='"+is_texto_t_descripcion+"'")				
				dw_detalle.modify("t_pzs.text='"+is_texto_t_pzs+"'")	
				dw_detalle.modify("t_m2.text='"+is_texto_t_m2+" \/'")	
				dw_detalle.modify("t_importe.text='"+is_texto_t_importe+"'")					
				dw_detalle.sort()
				dw_detalle.groupcalc()
			case "t_importe"
				dw_detalle.setsort(is_sort_inicial)
				dw_detalle.sort()
				dw_detalle.groupcalc()				
				dw_detalle.setsort("importe_g1_2 D,importe_g2_2 D,importe_g3_2 D, importe D,"+is_sort_inicial)
				dw_detalle.modify("t_descripcion.text='"+is_texto_t_descripcion+"'")				
				dw_detalle.modify("t_pzs.text='"+is_texto_t_pzs+"'")	
				dw_detalle.modify("t_m2.text='"+is_texto_t_m2+"'")	
				dw_detalle.modify("t_importe.text='"+is_texto_t_importe+" \/'")	
				dw_detalle.sort()
				dw_detalle.groupcalc()
		end choose		
	end if	
end if
end event

type uo_pavrev from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 997
integer y = 252
integer taborder = 130
boolean border = false
end type

on uo_pavrev.destroy
call u_marca_lista::destroy
end on

type uo_agentes from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 709
integer y = 252
integer taborder = 120
boolean border = false
end type

on uo_agentes.destroy
call u_marca_lista::destroy
end on

type uo_paises from u_marca_lista within w_con_ventas_familia_marca_submarca_3grupos
event destroy ( )
boolean visible = false
integer x = 421
integer y = 252
integer taborder = 110
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

type rb_pais from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
boolean visible = false
integer x = 3534
integer y = 160
integer width = 251
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pais"
boolean checked = true
end type

type rb_agente from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
boolean visible = false
integer x = 3534
integer y = 224
integer width = 251
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
end type

type rb_cliente from radiobutton within w_con_ventas_familia_marca_submarca_3grupos
boolean visible = false
integer x = 3534
integer y = 288
integer width = 251
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
end type

type ddlb_promocion from dropdownlistbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 3968
integer y = 156
integer width = 357
integer height = 376
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "No"
string item[] = {"Si","No","Todo"}
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
boolean visible = false
integer x = 3520
integer y = 108
integer width = 393
integer height = 264
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Agrupar por:"
end type

type gb_6 from groupbox within w_con_ventas_familia_marca_submarca_3grupos
integer x = 3950
integer y = 108
integer width = 393
integer height = 264
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Promoción:"
end type

