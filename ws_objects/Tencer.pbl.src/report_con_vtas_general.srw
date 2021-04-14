$PBExportHeader$report_con_vtas_general.srw
forward
global type report_con_vtas_general from w_int_con_empresa
end type
type pb_1 from upb_salir within report_con_vtas_general
end type
type pb_2 from upb_imprimir within report_con_vtas_general
end type
type em_fechadesde from u_em_campo within report_con_vtas_general
end type
type em_fechahasta from u_em_campo within report_con_vtas_general
end type
type dw_listado from datawindow within report_con_vtas_general
end type
type cb_1 from commandbutton within report_con_vtas_general
end type
type gb_7 from groupbox within report_con_vtas_general
end type
type gb_5 from groupbox within report_con_vtas_general
end type
type gb_4 from groupbox within report_con_vtas_general
end type
type gb_3 from groupbox within report_con_vtas_general
end type
type gb_11 from groupbox within report_con_vtas_general
end type
type gb_1 from groupbox within report_con_vtas_general
end type
type st_1 from statictext within report_con_vtas_general
end type
type cb_familias from commandbutton within report_con_vtas_general
end type
type cb_formatos from commandbutton within report_con_vtas_general
end type
type cb_provincias from commandbutton within report_con_vtas_general
end type
type uo_cliente from u_em_campo_2 within report_con_vtas_general
end type
type gb_2 from groupbox within report_con_vtas_general
end type
type cb_paises from commandbutton within report_con_vtas_general
end type
type cb_agentes from commandbutton within report_con_vtas_general
end type
type cb_calidades from commandbutton within report_con_vtas_general
end type
type cb_series from commandbutton within report_con_vtas_general
end type
type cb_conceptos from commandbutton within report_con_vtas_general
end type
type uo_familias from u_marca_lista within report_con_vtas_general
end type
type uo_formatos from u_marca_lista within report_con_vtas_general
end type
type uo_calidades from u_marca_lista within report_con_vtas_general
end type
type uo_conceptos from u_marca_lista within report_con_vtas_general
end type
type uo_series from u_marca_lista within report_con_vtas_general
end type
type uo_provincias from u_marca_lista within report_con_vtas_general
end type
type uo_paises from u_marca_lista within report_con_vtas_general
end type
type tab_agrupaciones from tab within report_con_vtas_general
end type
type tp_1 from userobject within tab_agrupaciones
end type
type dw_1 from datawindow within tp_1
end type
type tp_1 from userobject within tab_agrupaciones
dw_1 dw_1
end type
type tp_2 from userobject within tab_agrupaciones
end type
type dw_2 from datawindow within tp_2
end type
type tp_2 from userobject within tab_agrupaciones
dw_2 dw_2
end type
type tp_3 from userobject within tab_agrupaciones
end type
type dw_3 from datawindow within tp_3
end type
type tp_3 from userobject within tab_agrupaciones
dw_3 dw_3
end type
type tp_4 from userobject within tab_agrupaciones
end type
type dw_4 from datawindow within tp_4
end type
type tp_4 from userobject within tab_agrupaciones
dw_4 dw_4
end type
type tp_5 from userobject within tab_agrupaciones
end type
type dw_5 from datawindow within tp_5
end type
type tp_5 from userobject within tab_agrupaciones
dw_5 dw_5
end type
type tp_6 from userobject within tab_agrupaciones
end type
type dw_6 from datawindow within tp_6
end type
type tp_6 from userobject within tab_agrupaciones
dw_6 dw_6
end type
type tab_agrupaciones from tab within report_con_vtas_general
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
tp_4 tp_4
tp_5 tp_5
tp_6 tp_6
end type
type cbx_solo_articulos from checkbox within report_con_vtas_general
end type
type cb_area_manager from commandbutton within report_con_vtas_general
end type
type uo_area_manager from u_marca_lista within report_con_vtas_general
end type
type uo_agentes from u_marca_lista within report_con_vtas_general
end type
type dw_listado3 from datawindow within report_con_vtas_general
end type
end forward

global type report_con_vtas_general from w_int_con_empresa
integer width = 3607
integer height = 1916
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_7 gb_7
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_11 gb_11
gb_1 gb_1
st_1 st_1
cb_familias cb_familias
cb_formatos cb_formatos
cb_provincias cb_provincias
uo_cliente uo_cliente
gb_2 gb_2
cb_paises cb_paises
cb_agentes cb_agentes
cb_calidades cb_calidades
cb_series cb_series
cb_conceptos cb_conceptos
uo_familias uo_familias
uo_formatos uo_formatos
uo_calidades uo_calidades
uo_conceptos uo_conceptos
uo_series uo_series
uo_provincias uo_provincias
uo_paises uo_paises
tab_agrupaciones tab_agrupaciones
cbx_solo_articulos cbx_solo_articulos
cb_area_manager cb_area_manager
uo_area_manager uo_area_manager
uo_agentes uo_agentes
dw_listado3 dw_listado3
end type
global report_con_vtas_general report_con_vtas_general

type variables
string filtro,grafico = "N",texto_seleccion_final
boolean detalle
string sort_tp[10]
boolean numerar_tp[10]
boolean numerado_tp[10]
boolean ib_visible_muestra_grupo[7]
boolean ib_visible_oculta_grupo[7]
end variables

forward prototypes
public subroutine f_cargar_in ()
public function string f_prepara_texto_explicativo (string arg_texto_a_preparar)
public subroutine f_prepara_dw_para_impresion (ref datawindow arg_datawindow)
public subroutine f_cargar_in_old ()
end prototypes

public subroutine f_cargar_in ();long    indice,total,indice2,donde,opciones,opciones_marcadas,opciones_marcadas_no
string  codigo,pais,provincia,caracter,serie,agente,familia,formato,calidad,tipolinea
string  filtropaises,filtroseries,filtroagentes,filtrofamilias,filtroformatos,filtrocalidades,filtroconceptos
string  filtroseries_no,filtroagentes_no,filtrofamilias_no,filtroformatos_no,filtrocalidades_no,filtroconceptos_no
string  filtrocliente,areamanager,filtroareamanager,filtroareamanager_no
string  sel
string  texto_seleccion,texto_seleccion_en,texto_seleccion_no_en,descripcion,pais_anterior
string  texto_seleccion_pais,texto_seleccion_provincia,texto_seleccion_serie,texto_seleccion_agente,texto_seleccion_area_manager
string  texto_seleccion_familia,texto_seleccion_formato,texto_seleccion_calidad,texto_seleccion_concepto,texto_seleccion_cliente
boolean extrayendo_pais
datetime f_desde,f_hasta

string codigo_cliente,cliente,codigo_agente,codigo_articulo,articulo,codigo_calidad
string codigo_familia,codigo_formato,codigo_pais,codigo_provincia
string codigo_unidad,unidad,mascara_unidad,moneda,mascara_moneda,moneda_empresa
dec    importe,cantidad

datastore ds_ventas_articulos,ds_ventas_conceptos,ds_ventas_articulos_no_sector

time hora_inicio,hora_fin

hora_inicio = now()

tab_agrupaciones.tp_1.dw_1.reset()
tab_agrupaciones.tp_1.dw_1.setredraw(false)
tab_agrupaciones.tp_2.dw_2.setredraw(false)
tab_agrupaciones.tp_3.dw_3.setredraw(false)
tab_agrupaciones.tp_4.dw_4.setredraw(false)
tab_agrupaciones.tp_5.dw_5.setredraw(false)
tab_agrupaciones.tp_6.dw_6.setredraw(false)

f_desde = datetime(date(em_fechadesde.text))
f_hasta = datetime(date(em_fechahasta.text))

moneda_empresa = f_moneda_empresa(codigo_empresa)
moneda         = f_nombre_moneda_abr(moneda_empresa)
mascara_moneda = f_mascara_moneda(moneda_empresa)

texto_seleccion = ""
texto_seleccion_en = ""
texto_seleccion_no_en = ""

if uo_cliente.em_codigo.text <> "" then
	filtrocliente = " and venfac.cliente = '"+uo_cliente.em_codigo.text+"' "
	texto_seleccion_cliente = "CLIENTE : "+uo_cliente.em_campo.text+" ~n"
else
	texto_seleccion_cliente = ""
	filtrocliente = ""
end if

if filtrocliente = "" then
	total = uo_paises.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	
	for indice = 1 to total
		IF uo_paises.dw_marca.GetItemString(indice,"marca") = "S" THEN
			
			opciones_marcadas ++
			pais        = uo_paises.dw_marca.GetItemString(indice,"codigo")
			descripcion = uo_paises.dw_marca.object.texto[indice]
			
			if filtropaises = "" then
				filtropaises = "(genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
				texto_seleccion_en = descripcion
			else
				filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
				texto_seleccion_en = texto_seleccion_en + ";"+descripcion
			end if
		end if
	next
	
	if opciones_marcadas = opciones or opciones_marcadas = 0 then
		texto_seleccion_final = "TODOS LOS PAISES~n"
	else
		texto_seleccion_final = "PAISES : "+texto_seleccion_en + "~n"
	end if
	
	total = uo_provincias.dw_marca.RowCount()
	opciones = opciones + total
	
	IF total >0 Then
		
		pais_anterior = ""		
		FOR indice = 1 To total
			IF uo_provincias.dw_marca.GetItemString(indice,"marca") = "S" THEN
				opciones_marcadas ++
				codigo = uo_provincias.dw_marca.GetItemString(indice,"codigo")
				extrayendo_pais = true			
				pais = ""
				provincia = ""
				for indice2 = 1 to len(codigo)
					caracter = mid(codigo,indice2,1)
					if caracter <> "/" then
						if extrayendo_pais then
							pais = pais + caracter
						else
							provincia = provincia + caracter
						end if
					else
						extrayendo_pais = false			
					end if
				next
				if pais <> pais_anterior then
					If pais_anterior = "" then
						texto_seleccion_en = texto_seleccion_en + "PROVINCIAS : "
					else
						texto_seleccion_en = texto_seleccion_en + ")~n"
					end if
					pais_anterior = pais
					texto_seleccion_en =  texto_seleccion_en + f_nombre_pais(pais) + "("
				end if
								
				if filtropaises = "" then
					filtropaises = "(genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
					texto_seleccion_en =  texto_seleccion_en + f_nombre_provincia(pais,provincia)
				else
					filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
					texto_seleccion_en =  texto_seleccion_en + ";" + f_nombre_provincia(pais,provincia)
				end if
			end if
		next
	end if
	
	if opciones_marcadas = opciones or opciones_marcadas = 0 then
		filtropaises = ""
		texto_seleccion_final = "TODOS LOS PAISES Y PROVINCIAS"
	else
		if trim(filtropaises) <> "" then
			filtropaises = "and ("+filtropaises+") "
			texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_en
		end if		
	end if	
		
	//Series
	
	total = uo_series.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_series.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			serie = uo_series.dw_marca.GetItemString(indice,"codigo")
			if filtroseries = "" then
				filtroseries = "'"+serie+"'"
				texto_seleccion_en = uo_series.dw_marca.object.texto[indice]
			else
				filtroseries = filtroseries + ",'"+serie+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_series.dw_marca.object.texto[indice]
			end if		
		else
			opciones_marcadas_no ++
			serie = uo_series.dw_marca.GetItemString(indice,"codigo")
			if filtroseries_no = "" then
				filtroseries_no = "'"+serie+"'"
				texto_seleccion_no_en = uo_series.dw_marca.object.texto[indice]
			else
				filtroseries_no = filtroseries_no + ",'"+serie+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_series.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroseries) <> "" then
				filtroseries = "and venfac.serie in("+filtroseries+") "
				texto_seleccion_serie = "SERIES : "+texto_seleccion_en
			end if
		else
			if trim(filtroseries_no) <> "" then
				filtroseries = "and venfac.serie not in("+filtroseries_no+") "
				texto_seleccion_serie = "TODAS LAS SERIES EXCEPTO "+texto_seleccion_no_en
			end if		
		end if
	else
		filtroseries = ""
		texto_seleccion_serie = "TODAS LAS SERIES"
	end if
	texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_serie
	//Agentes
	
	total = uo_agentes.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_agentes.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
			if filtroagentes = "" then
				filtroagentes = "'"+agente+"'"
				texto_seleccion_en = uo_agentes.dw_marca.object.texto[indice]
			else
				filtroagentes = filtroagentes + ",'"+agente+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_agentes.dw_marca.object.texto[indice]
			end if
		else
			opciones_marcadas_no ++
			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
			if filtroagentes_no = "" then
				filtroagentes_no = "'"+agente+"'"
				texto_seleccion_no_en = uo_agentes.dw_marca.object.texto[indice]
			else
				filtroagentes_no = filtroagentes_no + ",'"+agente+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_agentes.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroagentes) <> "" then
				filtroagentes = "and venfac.agente1 in ("+filtroagentes+") "
				texto_seleccion_agente = "AGENTES : "+texto_seleccion_en
			end if
		else
			if trim(filtroagentes_no) <> "" then
				filtroagentes = "and venfac.agente1 not in ("+filtroagentes_no+") "
				texto_seleccion_agente = "TODOS LOS AGENTES EXCEPTO "+texto_seleccion_no_en
			end if	
		end if
	else
		filtroagentes = ""
		texto_seleccion_agente = "TODOS LOS AGENTES"
	end if
	texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_agente
	//Area_manager
	
	total = uo_area_manager.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_area_manager.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			areamanager = uo_area_manager.dw_marca.GetItemString(indice,"codigo")
			if filtroareamanager = "" then
				filtroareamanager = "'"+areamanager+"'"
				texto_seleccion_en = uo_area_manager.dw_marca.object.texto[indice]
			else
				filtroareamanager = filtroareamanager + ",'"+areamanager+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_area_manager.dw_marca.object.texto[indice]
			end if
		else
			opciones_marcadas_no ++
			areamanager = uo_area_manager.dw_marca.GetItemString(indice,"codigo")
			if filtroareamanager_no = "" then
				filtroareamanager_no = "'"+areamanager+"'"
				texto_seleccion_no_en = uo_area_manager.dw_marca.object.texto[indice]
			else
				filtroareamanager_no = filtroareamanager_no + ",'"+areamanager+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_area_manager.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroareamanager) <> "" then
				filtroareamanager = "and paises.jefe_area in ("+filtroareamanager+") "
				texto_seleccion_area_manager = "AREA MANAGER : "+texto_seleccion_en
			end if
		else
			if trim(filtroareamanager_no) <> "" then
				filtroareamanager = "and paises.jefe_area not in ("+filtroareamanager_no+") "
				texto_seleccion_area_manager = "TODOS LOS AREA MANAGER EXCEPTO "+texto_seleccion_no_en
			end if	
		end if
	else
		filtroareamanager = ""
		texto_seleccion_area_manager = "TODOS LOS AREA MANAGER"
	end if
	texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_area_manager
else
	filtropaises  = ""
	filtroseries  = ""
	filtroagentes = ""
	filtroareamanager = ""
	
	texto_seleccion_final = texto_seleccion_cliente
end if

//Familias

total = uo_familias.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_familias.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		familia = uo_familias.dw_marca.GetItemString(indice,"codigo")
		if filtrofamilias = "" then
			filtrofamilias = "'"+familia+"'"
			texto_seleccion_en = uo_familias.dw_marca.object.texto[indice]
		else
			filtrofamilias = filtrofamilias + ",'"+familia+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_familias.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		familia = uo_familias.dw_marca.GetItemString(indice,"codigo")
		if filtrofamilias_no = "" then
			filtrofamilias_no = "'"+familia+"'"
			texto_seleccion_no_en = uo_familias.dw_marca.object.texto[indice]
		else
			filtrofamilias_no = filtrofamilias_no + ",'"+familia+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_familias.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtrofamilias) <> "" then
			filtrofamilias = "and articulos.familia in ("+filtrofamilias+") "
			texto_seleccion_familia = "FAMILIAS : "+texto_seleccion_en
		end if
	else
		if trim(filtrofamilias_no) <> "" then
			filtrofamilias = "and articulos.familia not in ("+filtrofamilias_no+") "
			texto_seleccion_familia = "TODAS LAS FAMILIAS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtrofamilias = ""
	texto_seleccion_familia = "TODAS LAS FAMILIAS"
end if

texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_familia
//Formatos

total = uo_formatos.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_formatos.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		formato = uo_formatos.dw_marca.GetItemString(indice,"codigo")
		if filtroformatos = "" then
			filtroformatos = "'"+formato+"'"
			texto_seleccion_en = uo_formatos.dw_marca.object.texto[indice]
		else
			filtroformatos = filtroformatos + ",'"+formato+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_formatos.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		formato = uo_formatos.dw_marca.GetItemString(indice,"codigo")
		if filtroformatos_no = "" then
			filtroformatos_no = "'"+formato+"'"
			texto_seleccion_no_en = uo_formatos.dw_marca.object.texto[indice]
		else
			filtroformatos_no = filtroformatos_no + ",'"+formato+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_formatos.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtroformatos) <> "" then
			filtroformatos = "and articulos.formato in ("+filtroformatos+") "
			texto_seleccion_formato = "FORMATOS : "+texto_seleccion_en
		end if
	else
		if trim(filtroformatos_no) <> "" then
			filtroformatos = "and articulos.formato not in ("+filtroformatos_no+") "
			texto_seleccion_formato = "TODOS LOS FORMATOS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtroformatos = ""
	texto_seleccion_formato = "TODOS LOS FORMATOS"
end if	
texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_formato
//Calidades

total = uo_calidades.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_calidades.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		calidad = uo_calidades.dw_marca.GetItemString(indice,"codigo")
		if filtrocalidades = "" then
			filtrocalidades = "'"+calidad+"'"
			texto_seleccion_en = uo_calidades.dw_marca.object.texto[indice]
		else
			filtrocalidades = filtrocalidades + ",'"+calidad+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_calidades.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		calidad = uo_calidades.dw_marca.GetItemString(indice,"codigo")
		if filtrocalidades_no = "" then
			filtrocalidades_no = "'"+calidad+"'"
			texto_seleccion_no_en = uo_calidades.dw_marca.object.texto[indice]
		else
			filtrocalidades_no = filtrocalidades_no + ",'"+calidad+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_calidades.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtrocalidades) <> "" then
			filtrocalidades = "and venlifac.calidad in ("+filtrocalidades+") "
			texto_seleccion_calidad = "CALIDADES : "+texto_seleccion_en
		end if
	else
		if trim(filtrocalidades_no) <> "" then
			filtrocalidades = "and venlifac.calidad not in ("+filtrocalidades_no+") "
			texto_seleccion_calidad = "TODAS LAS CALIDADES EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtrocalidades = ""
	texto_seleccion_calidad = "TODAS LAS CALIDADES"
end if
texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_calidad
//Conceptos (Tipos de linea)

total = uo_conceptos.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_conceptos.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		tipolinea = uo_conceptos.dw_marca.GetItemString(indice,"codigo")
		if filtroconceptos = "" then
			filtroconceptos = "'"+tipolinea+"'"
			texto_seleccion_en = uo_conceptos.dw_marca.object.texto[indice]
		else
			filtroconceptos = filtroconceptos + ",'"+tipolinea+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_conceptos.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		tipolinea = uo_conceptos.dw_marca.GetItemString(indice,"codigo")
		if filtroconceptos_no = "" then
			filtroconceptos_no = "'"+tipolinea+"'"
			texto_seleccion_no_en = uo_conceptos.dw_marca.object.texto[indice]
		else
			filtroconceptos_no = filtroconceptos_no + ",'"+tipolinea+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_conceptos.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtroconceptos) <> "" then
			filtroconceptos = "and venlifac.tipolinea in ("+filtroconceptos+") "
			texto_seleccion_concepto = "CONCEPTOS : "+texto_seleccion_en
		end if
	else
		if trim(filtroconceptos_no) <> "" then
			filtroconceptos = "and venlifac.tipolinea not in ("+filtroconceptos_no+") "
			texto_seleccion_concepto = "TODOS LOS CONCEPTOS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtroconceptos = ""
	texto_seleccion_concepto = "TODOS LOS CONCEPTOS"
end if
texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_concepto

texto_seleccion_final = f_prepara_texto_explicativo(texto_seleccion_final)


sel = "select venfac.cliente,"+&
		"       genter.razon,"+&
		"       venfac.agente1,"+&
		"       venagentes.nombre,"+&		
		"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
		"       venlifac.articulo,"+&
		"       articulos.descripcion,"+&		
		"       venlifac.calidad,"+&
		"       calidades.abreviado,"+&		
		"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
		"       articulos.familia,"+&
		"       familias.descripcion,"+&		
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       genter.pais,"+&
		"       paises.nombre,"+&		
		"       genter.provincia,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       '###,###,###,##0'+substring('.000000',1,(unidades.decimales/unidades.decimales+1)+unidades.decimales),"+&
		"       '"+moneda+"',"+&
		"       '"+mascara_moneda+"', "+&
		"       1,1,1,1,1,1 "+&
		"from   venfac,"+&
		"       venlifac,"+&
		"       genter,"+&
		"       venagentes,"+&
		"       articulos,"+&
		"       calidades,"+&
		"       formatos,"+&
		"       familias,"+&
		"       paises,"+&
		"       provincias,"+&
		"       unidades "+&
   	"where ( venfac.empresa    = venlifac.empresa ) "+&
		"and   ( venfac.anyo       = venlifac.anyo ) "+&
		"and   ( venfac.factura    = venlifac.factura ) "+&
		"and   ( venfac.empresa    = venagentes.empresa ) "+&
		"and   ( venfac.agente1    = venagentes.agente ) "+&
		"and   ( venfac.empresa    = genter.empresa ) "+&
		"and   ( venfac.cliente    = genter.codigo ) "+&
		"and   ( genter.pais       = paises.pais ) "+&
		"and   ( genter.provincia *= provincias.provincia ) "+&
		"and   ( genter.pais      *= provincias.pais ) "+&
		"and   ( genter.tipoter    = 'C' ) "+&
		"and   ( venlifac.empresa  = calidades.empresa ) "+&
		"and   ( venlifac.empresa  = familias.empresa ) "+&
		"and   ( venlifac.empresa  = formatos.empresa ) "+&		
		"and   ( venlifac.empresa  = articulos.empresa ) "+&
		"and   ( venlifac.articulo = articulos.codigo ) "+&
		"and   ( venlifac.calidad  = calidades.codigo ) "+&
		"and   ( articulos.familia = familias.codigo ) "+&		
		"and   ( articulos.formato = formatos.codigo ) "+&
		"and   ( articulos.unidad  = unidades.codigo ) "+&
		"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
		"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
		filtrocliente+&
		filtropaises+&
		filtroseries+&
		filtroagentes+&
		filtroareamanager+&
		filtrofamilias+&
		filtroformatos+&
		filtrocalidades+&
		filtroconceptos+&
		" "+&
		"group by venfac.cliente,"+&
		"       venfac.agente1,"+&
		"       venlifac.articulo,"+&
		"       venlifac.calidad,"+&
		"       genter.razon,"+&
		"       venagentes.nombre,"+&
		"       articulos.descripcion,"+&
		"       articulos.familia,"+&
		"       articulos.formato,"+&
		"       calidades.abreviado,"+&
		"       formatos.abreviado,"+&
		"       familias.descripcion,"+&
		"       genter.pais,"+&
		"       genter.provincia,"+&
		"       paises.nombre,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       unidades.decimales "


f_cargar_cursor_transaccion(sqlca,ds_ventas_articulos,sel)

total = ds_ventas_articulos.rowcount()

if total > 0 then
	ds_ventas_articulos.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
end if

destroy ds_ventas_articulos

sel = "select venfac.cliente,"+&
		"       genter.razon,"+&
		"       venfac.agente1,"+&
		"       venagentes.nombre,"+&		
		"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
		"       venlifac.articulo,"+&
		"       articulos.descripcion,"+&		
		"       venlifac.calidad,"+&
		"       '',"+&		
		"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
		"       articulos.familia,"+&
		"       familias.descripcion,"+&		
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       genter.pais,"+&
		"       paises.nombre,"+&		
		"       genter.provincia,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       '###,###,###,##0'+substring('.000000',1,(unidades.decimales/unidades.decimales+1)+unidades.decimales),"+&
		"       '"+moneda+"',"+&
		"       '"+mascara_moneda+"', "+&
		"       1,1,1,1,1,1 "+&
		"from   venfac,"+&
		"       venlifac,"+&
		"       genter,"+&
		"       venagentes,"+&
		"       articulos,"+&
		"       formatos,"+&
		"       familias,"+&
		"       paises,"+&
		"       provincias,"+&
		"       unidades "+&
   	"where ( venfac.empresa    = venlifac.empresa ) "+&
		"and   ( venfac.anyo       = venlifac.anyo ) "+&
		"and   ( venfac.factura    = venlifac.factura ) "+&
		"and   ( venfac.empresa    = venagentes.empresa ) "+&
		"and   ( venfac.agente1    = venagentes.agente ) "+&
		"and   ( venfac.empresa    = genter.empresa ) "+&
		"and   ( venfac.cliente    = genter.codigo ) "+&
		"and   ( genter.pais       = paises.pais ) "+&
		"and   ( genter.provincia *= provincias.provincia ) "+&
		"and   ( genter.pais      *= provincias.pais ) "+&
		"and   ( genter.tipoter    = 'C' ) "+&
		"and   ( venlifac.empresa  = familias.empresa ) "+&
		"and   ( venlifac.empresa  = formatos.empresa ) "+&		
		"and   ( venlifac.empresa  = articulos.empresa ) "+&
		"and   ( venlifac.articulo = articulos.codigo ) "+&
		"and   ( venlifac.calidad  = null or venlifac.calidad = '') "+&
		"and   ( articulos.familia = familias.codigo ) "+&		
		"and   ( articulos.formato = formatos.codigo ) "+&
		"and   ( articulos.unidad  = unidades.codigo ) "+&
		"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
		"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
		filtrocliente+&
		filtropaises+&
		filtroseries+&
		filtroagentes+&
		filtroareamanager+&
		filtrofamilias+&
		filtroformatos+&
		filtroconceptos+&
		" "+&
		"group by venfac.cliente,"+&
		"       venfac.agente1,"+&
		"       venlifac.articulo,"+&
		"       venlifac.calidad,"+&
		"       genter.razon,"+&
		"       venagentes.nombre,"+&
		"       articulos.descripcion,"+&
		"       articulos.familia,"+&
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       familias.descripcion,"+&
		"       genter.pais,"+&
		"       genter.provincia,"+&
		"       paises.nombre,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       unidades.decimales "

f_cargar_cursor_transaccion(sqlca,ds_ventas_articulos_no_sector,sel)

total = ds_ventas_articulos_no_sector.rowcount()

if total > 0 then
	ds_ventas_articulos_no_sector.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
end if

destroy ds_ventas_articulos_no_sector

if not(cbx_solo_articulos.checked) then
	
	sel = "select venfac.cliente,"+&
			"       genter.razon,"+&
			"       venfac.agente1,"+&
			"       venagentes.nombre,"+&		
			"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&		
			"       '',"+&
			"       '',"+&		
			"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&		
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&
			"       genter.pais,"+&
			"       paises.nombre,"+&		
			"       genter.provincia,"+&
			"       provincias.nombre,"+&
			"       '',"+&
			"       'UDS',"+&
			"       '###,###,###,##0',"+&
			"       '"+moneda+"',"+&
			"       '"+mascara_moneda+"', "+&		
			"       1,1,1,1,1,1 "+&
			"from   venfac,"+&
			"       venlifac,"+&
			"       genter,"+&
			"       venagentes,"+&
			"       ventipolin,"+&
			"       paises,"+&
			"       provincias "+&
			"where ( venfac.empresa    = venlifac.empresa ) "+&
			"and   ( venfac.anyo       = venlifac.anyo ) "+&
			"and   ( venfac.factura    = venlifac.factura ) "+&
			"and   ( venfac.empresa    = venagentes.empresa ) "+&
			"and   ( venfac.agente1    = venagentes.agente ) "+&
			"and   ( venfac.empresa    = genter.empresa ) "+&
			"and   ( venfac.cliente    = genter.codigo ) "+&
			"and   ( genter.pais       = paises.pais ) "+&
			"and   ( genter.provincia *= provincias.provincia ) "+&
			"and   ( genter.pais      *= provincias.pais ) "+&
			"and   ( genter.tipoter    = 'C' ) "+&
			"and   ( venlifac.empresa  = ventipolin.empresa ) "+&
			"and   ( venlifac.tipolinea = ventipolin.codigo ) "+&
			"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
			"and     venlifac.articulo in('',null) "+&
			"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
			filtrocliente+&
			filtropaises+&
			filtroseries+&
			filtroagentes+&
			filtroareamanager+&
			filtroconceptos+&
			" "+&
			"group by venfac.cliente,"+&
			"       venfac.agente1,"+&
			"       venlifac.tipolinea,"+&
			"       genter.razon,"+&
			"       venagentes.nombre,"+&
			"       ventipolin.descripcion,"+&
			"       genter.pais,"+&
			"       genter.provincia,"+&
			"       paises.nombre,"+&
			"       provincias.nombre "

	f_cargar_cursor_transaccion(sqlca,ds_ventas_conceptos,sel)

	total = ds_ventas_conceptos.rowcount()
	
	if total > 0 then
		ds_ventas_conceptos.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
	end if
end if

destroy ds_ventas_conceptos

for indice = 1 to 10
	numerado_tp[indice] = false
next

tab_agrupaciones.SelectTab(1)
tab_agrupaciones.tp_1.dw_1.sort()
tab_agrupaciones.tp_1.dw_1.groupcalc()
tab_agrupaciones.tp_1.dw_1.setredraw(true)

tab_agrupaciones.tp_1.dw_1.modify("datawindow.header.2.height='64 ~t if(codigo_pais=~~'11~~',64,0)'")

hora_fin = now()

//messagebox("",string(hora_inicio)+"/"+string(hora_fin))

end subroutine

public function string f_prepara_texto_explicativo (string arg_texto_a_preparar);long   pos_corto_string,longitud_texto,max_caracteres,pos_coma,contador,pos_puntoycoma
string texto_a_preparar,texto_preparado

max_caracteres = 40

//**PREPARAMOS EL TEXTO EXPLICATIVO DE LA CONSULTA**

texto_a_preparar = arg_texto_a_preparar
longitud_texto   = len(texto_a_preparar)
pos_corto_string = 1

if longitud_texto > max_caracteres then	
	pos_puntoycoma = pos(texto_a_preparar,';',pos_corto_string)
	do
		if mid(texto_a_preparar,max_caracteres - contador,1) = ";" then
			texto_preparado  = texto_preparado + mid(texto_a_preparar,1,pos_puntoycoma - 1) + "~n"
			texto_a_preparar = mid(texto_a_preparar,pos_puntoycoma + 1,longitud_texto)
			longitud_texto   = len(texto_a_preparar)
			contador         = 0
		else
			contador ++
		end if
		
		if pos_puntoycoma = 0 then
			texto_preparado  = texto_a_preparar
			texto_a_preparar = ""
		end if
	loop while (pos_puntoycoma > 0) and (longitud_texto > max_caracteres)
	
	texto_preparado  = texto_preparado + texto_a_preparar	
else
	texto_preparado = texto_a_preparar	
end if

//Buscamos el primer punto y coma desde la posición máxima hacia atrás , cortamos el texto y seguimos el proceso
//hasta obtener un texto separado en líneas de menor longitud del máximo

//if longitud_texto > max_caracteres then	
//	do
//		if mid(texto_a_preparar,max_caracteres - contador,1) = ";" then
//			texto_preparado  = texto_preparado + mid(texto_a_preparar,1,max_caracteres - contador - 1) + "~n"
//			texto_a_preparar = mid(texto_a_preparar,max_caracteres - contador + 1,longitud_texto)
//			longitud_texto   = len(texto_a_preparar)
//			contador         = 0
//		else
//			contador ++
//		end if
//		
//		if contador = max_caracteres then
//			texto_preparado  = texto_a_preparar
//			texto_a_preparar = ""
//		end if
//	loop while (contador < max_caracteres) and (longitud_texto > max_caracteres)
//	
//	texto_preparado  = texto_preparado + texto_a_preparar
//else
//	texto_preparado = texto_a_preparar
//end if


return texto_preparado

//**PREPARAMOS EL TEXTO EXPLICATIVO DE LA CONSULTA**
end function

public subroutine f_prepara_dw_para_impresion (ref datawindow arg_datawindow);string modstring,ls_visible,ls_resultado
int    li_indice_grupo

//Ocultamos todos los botones que muestran u ocultan grupos
for li_indice_grupo = 2 to 7
	modstring = ' pb_muestra_grupo'+string(li_indice_grupo,"0")+'.visible '
	ls_visible = arg_datawindow.describe(modstring)
	if ls_visible = '1' then
		modstring = ' pb_muestra_grupo'+string(li_indice_grupo,"0")+'.visible = 0 '
		arg_datawindow.Modify(modstring)
		ib_visible_muestra_grupo[li_indice_grupo] = true
	else
		ib_visible_muestra_grupo[li_indice_grupo] = false
	end if
	
	modstring = ' pb_oculta_grupo'+string(li_indice_grupo,"0")+'.visible '
	ls_visible = arg_datawindow.describe(modstring)
	if ls_visible = '1' then
		modstring = ' pb_oculta_grupo'+string(li_indice_grupo,"0")+'.visible = 0 '
		arg_datawindow.Modify(modstring)
		ib_visible_oculta_grupo[li_indice_grupo] = true
	else
		ib_visible_oculta_grupo[li_indice_grupo] = false
	end if	
	
next

//Creamos el total paginas
modstring = 'create compute(band=header alignment="0" expression="pagecount()+1"border="0" color="16777215" x="1682" y="36" height="72" width="270" format="[general]" html.valueishtml="0"  name=total_paginas visible="1"  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" )'
arg_datawindow.Modify(modstring)

////Numero de pagina al pie
modstring = 'create text(band=footer alignment="0" text="Página" border="0" color="0" x="9" y="4" height="48" width="183" html.valueishtml="0"  name=t_1 visible="1"  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
arg_datawindow.Modify(modstring)

modstring = 'create compute(band=footer alignment="0" expression="page()+1"border="0" color="0" x="206" y="4" height="48" width="261" format="[General]" html.valueishtml="0"  name=compute_9 visible="1"  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" )'
arg_datawindow.Modify(modstring)

arg_datawindow.sort()
arg_datawindow.groupcalc()
end subroutine

public subroutine f_cargar_in_old ();long    indice,total,indice2,donde,opciones,opciones_marcadas,opciones_marcadas_no
string  codigo,pais,provincia,caracter,serie,agente,familia,formato,calidad,tipolinea
string  filtropaises,filtroseries,filtroagentes,filtrofamilias,filtroformatos,filtrocalidades,filtroconceptos
string  filtroseries_no,filtroagentes_no,filtrofamilias_no,filtroformatos_no,filtrocalidades_no,filtroconceptos_no
string  filtrocliente,areamanager,filtroareamanager,filtroareamanager_no
string  sel
string  texto_seleccion,texto_seleccion_en,texto_seleccion_no_en,descripcion,pais_anterior
string  texto_seleccion_pais,texto_seleccion_provincia,texto_seleccion_serie,texto_seleccion_agente,texto_seleccion_area_manager
string  texto_seleccion_familia,texto_seleccion_formato,texto_seleccion_calidad,texto_seleccion_concepto,texto_seleccion_cliente
boolean extrayendo_pais
datetime f_desde,f_hasta

string codigo_cliente,cliente,codigo_agente,codigo_articulo,articulo,codigo_calidad
string codigo_familia,codigo_formato,codigo_pais,codigo_provincia
string codigo_unidad,unidad,mascara_unidad,moneda,mascara_moneda,moneda_empresa
dec    importe,cantidad

datastore ds_ventas_articulos,ds_ventas_conceptos,ds_ventas_articulos_no_sector

time hora_inicio,hora_fin

hora_inicio = now()

tab_agrupaciones.tp_1.dw_1.reset()
tab_agrupaciones.tp_1.dw_1.setredraw(false)
tab_agrupaciones.tp_2.dw_2.setredraw(false)
tab_agrupaciones.tp_3.dw_3.setredraw(false)
tab_agrupaciones.tp_4.dw_4.setredraw(false)
tab_agrupaciones.tp_5.dw_5.setredraw(false)
tab_agrupaciones.tp_6.dw_6.setredraw(false)

f_desde = datetime(date(em_fechadesde.text))
f_hasta = datetime(date(em_fechahasta.text))

moneda_empresa = f_moneda_empresa(codigo_empresa)
moneda         = f_nombre_moneda_abr(moneda_empresa)
mascara_moneda = f_mascara_moneda(moneda_empresa)

texto_seleccion = ""
texto_seleccion_en = ""
texto_seleccion_no_en = ""

if uo_cliente.em_codigo.text <> "" then
	filtrocliente = " and venfac.cliente = '"+uo_cliente.em_codigo.text+"' "
	texto_seleccion_cliente = "CLIENTE : "+uo_cliente.em_campo.text+" ~n"
else
	texto_seleccion_cliente = ""
	filtrocliente = ""
end if



if filtrocliente = "" then
	total = uo_paises.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	
	for indice = 1 to total
		IF uo_paises.dw_marca.GetItemString(indice,"marca") = "S" THEN
			
			opciones_marcadas ++
			pais        = uo_paises.dw_marca.GetItemString(indice,"codigo")
			descripcion = uo_paises.dw_marca.object.texto[indice]
			
			if filtropaises = "" then
				filtropaises = "(genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
				texto_seleccion_en = descripcion
			else
				filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
				texto_seleccion_en = texto_seleccion_en + ";"+descripcion
			end if
		end if
	next
	
	if opciones_marcadas = opciones then
		texto_seleccion_en = "TODOS LOS PAISES~n"
	else
		texto_seleccion_en = "PAISES : "+texto_seleccion_en + "~n"
	end if
	
	total = uo_provincias.dw_marca.RowCount()
	opciones = opciones + total
	

	IF total >0 Then
		
		pais_anterior = ""		
		FOR indice = 1 To total
			IF uo_provincias.dw_marca.GetItemString(indice,"marca") = "S" THEN
				opciones_marcadas ++
				codigo = uo_provincias.dw_marca.GetItemString(indice,"codigo")
				extrayendo_pais = true			
				pais = ""
				provincia = ""
				for indice2 = 1 to len(codigo)
					caracter = mid(codigo,indice2,1)
					if caracter <> "/" then
						if extrayendo_pais then
							pais = pais + caracter
						else
							provincia = provincia + caracter
						end if
					else
						extrayendo_pais = false			
					end if
				next
				if pais <> pais_anterior then
					If pais_anterior = "" then
						texto_seleccion_en = texto_seleccion_en + "PROVINCIAS : "
					else
						texto_seleccion_en = texto_seleccion_en + ")~n"
					end if
					pais_anterior = pais
					texto_seleccion_en =  texto_seleccion_en + f_nombre_pais(pais) + "("
				end if
				
				
				if filtropaises = "" then
					filtropaises = "(genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
					texto_seleccion_en =  texto_seleccion_en + f_nombre_provincia(pais,provincia)
				else
					filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
					texto_seleccion_en =  texto_seleccion_en + ";" + f_nombre_provincia(pais,provincia)
				end if
			end if
		next
	end if
	
	if opciones_marcadas <> opciones then
		if trim(filtropaises) <> "" then
			filtropaises = "and ("+filtropaises+") "
		end if
	else
		filtropaises = ""
		texto_seleccion_en = "TODOS LOS PAISES Y PROVINCIAS"
	end if
	
	texto_seleccion = texto_seleccion + texto_seleccion_en + "~n"
	
		
	//Series
	
	total = uo_series.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_series.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			serie = uo_series.dw_marca.GetItemString(indice,"codigo")
			if filtroseries = "" then
				filtroseries = "'"+serie+"'"
				texto_seleccion_en = uo_series.dw_marca.object.texto[indice]
			else
				filtroseries = filtroseries + ",'"+serie+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_series.dw_marca.object.texto[indice]
			end if		
		else
			opciones_marcadas_no ++
			serie = uo_series.dw_marca.GetItemString(indice,"codigo")
			if filtroseries_no = "" then
				filtroseries_no = "'"+serie+"'"
				texto_seleccion_no_en = uo_series.dw_marca.object.texto[indice]
			else
				filtroseries_no = filtroseries_no + ",'"+serie+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_series.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroseries) <> "" then
				filtroseries = "and venfac.serie in("+filtroseries+") "
				texto_seleccion_serie = "SERIES : "+texto_seleccion_en
			end if
		else
			if trim(filtroseries_no) <> "" then
				filtroseries = "and venfac.serie not in("+filtroseries_no+") "
				texto_seleccion_serie = "TODAS LAS SERIES EXCEPTO "+texto_seleccion_no_en
			end if		
		end if
	else
		filtroseries = ""
		texto_seleccion_serie = "TODAS LAS SERIES"
	end if
	
	//Agentes
	
	total = uo_agentes.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_agentes.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
			if filtroagentes = "" then
				filtroagentes = "'"+agente+"'"
				texto_seleccion_en = uo_agentes.dw_marca.object.texto[indice]
			else
				filtroagentes = filtroagentes + ",'"+agente+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_agentes.dw_marca.object.texto[indice]
			end if
		else
			opciones_marcadas_no ++
			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
			if filtroagentes_no = "" then
				filtroagentes_no = "'"+agente+"'"
				texto_seleccion_no_en = uo_agentes.dw_marca.object.texto[indice]
			else
				filtroagentes_no = filtroagentes_no + ",'"+agente+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_agentes.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroagentes) <> "" then
				filtroagentes = "and venfac.agente1 in ("+filtroagentes+") "
				texto_seleccion_agente = "AGENTES : "+texto_seleccion_en
			end if
		else
			if trim(filtroagentes_no) <> "" then
				filtroagentes = "and venfac.agente1 not in ("+filtroagentes_no+") "
				texto_seleccion_agente = "TODOS LOS AGENTES EXCEPTO "+texto_seleccion_no_en
			end if	
		end if
	else
		filtroagentes = ""
		texto_seleccion_agente = "TODOS LOS AGENTES"
	end if
	
	//Area_manager
	
	total = uo_area_manager.dw_marca.RowCount()
	
	opciones = total
	opciones_marcadas = 0
	opciones_marcadas_no = 0
	
	for indice = 1 to total
		IF uo_area_manager.dw_marca.GetItemString(indice,"marca") = "S" THEN
			opciones_marcadas ++
			areamanager = uo_area_manager.dw_marca.GetItemString(indice,"codigo")
			if filtroareamanager = "" then
				filtroareamanager = "'"+areamanager+"'"
				texto_seleccion_en = uo_area_manager.dw_marca.object.texto[indice]
			else
				filtroareamanager = filtroareamanager + ",'"+areamanager+"'"
				texto_seleccion_en = texto_seleccion_en+";"+uo_area_manager.dw_marca.object.texto[indice]
			end if
		else
			opciones_marcadas_no ++
			areamanager = uo_area_manager.dw_marca.GetItemString(indice,"codigo")
			if filtroareamanager_no = "" then
				filtroareamanager_no = "'"+areamanager+"'"
				texto_seleccion_no_en = uo_area_manager.dw_marca.object.texto[indice]
			else
				filtroareamanager_no = filtroareamanager_no + ",'"+areamanager+"'"
				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_area_manager.dw_marca.object.texto[indice]
			end if		
		end if
	next
	
	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
		if opciones_marcadas <= opciones_marcadas_no then
			if trim(filtroareamanager) <> "" then
				filtroareamanager = "and paises.jefe_area in ("+filtroareamanager+") "
				texto_seleccion_area_manager = "AREA MANAGER : "+texto_seleccion_en
			end if
		else
			if trim(filtroareamanager_no) <> "" then
				filtroareamanager = "and paises.jefe_area not in ("+filtroareamanager_no+") "
				texto_seleccion_area_manager = "TODOS LOS AREA MANAGER EXCEPTO "+texto_seleccion_no_en
			end if	
		end if
	else
		filtroareamanager = ""
		texto_seleccion_area_manager = "TODOS LOS AREA MANAGER"
	end if	
else
	filtropaises  = ""
	filtroseries  = ""
	filtroagentes = ""
	filtroareamanager = ""
end if

//Familias

total = uo_familias.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_familias.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		familia = uo_familias.dw_marca.GetItemString(indice,"codigo")
		if filtrofamilias = "" then
			filtrofamilias = "'"+familia+"'"
			texto_seleccion_en = uo_familias.dw_marca.object.texto[indice]
		else
			filtrofamilias = filtrofamilias + ",'"+familia+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_familias.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		familia = uo_familias.dw_marca.GetItemString(indice,"codigo")
		if filtrofamilias_no = "" then
			filtrofamilias_no = "'"+familia+"'"
			texto_seleccion_no_en = uo_familias.dw_marca.object.texto[indice]
		else
			filtrofamilias_no = filtrofamilias_no + ",'"+familia+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_familias.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtrofamilias) <> "" then
			filtrofamilias = "and articulos.familia in ("+filtrofamilias+") "
			texto_seleccion_familia = "FAMILIAS : "+texto_seleccion_en
		end if
	else
		if trim(filtrofamilias_no) <> "" then
			filtrofamilias = "and articulos.familia not in ("+filtrofamilias_no+") "
			texto_seleccion_familia = "TODAS LAS FAMILIAS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtrofamilias = ""
	texto_seleccion_familia = "TODAS LAS FAMILIAS"
end if

//Formatos

total = uo_formatos.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_formatos.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		formato = uo_formatos.dw_marca.GetItemString(indice,"codigo")
		if filtroformatos = "" then
			filtroformatos = "'"+formato+"'"
			texto_seleccion_en = uo_formatos.dw_marca.object.texto[indice]
		else
			filtroformatos = filtroformatos + ",'"+formato+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_formatos.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		formato = uo_formatos.dw_marca.GetItemString(indice,"codigo")
		if filtroformatos_no = "" then
			filtroformatos_no = "'"+formato+"'"
			texto_seleccion_no_en = uo_formatos.dw_marca.object.texto[indice]
		else
			filtroformatos_no = filtroformatos_no + ",'"+formato+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_formatos.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtroformatos) <> "" then
			filtroformatos = "and articulos.formato in ("+filtroformatos+") "
			texto_seleccion_formato = "FORMATOS : "+texto_seleccion_en
		end if
	else
		if trim(filtroformatos_no) <> "" then
			filtroformatos = "and articulos.formato not in ("+filtroformatos_no+") "
			texto_seleccion_formato = "TODOS LOS FORMATOS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtroformatos = ""
	texto_seleccion_formato = "TODOS LOS FORMATOS"
end if	

//Calidades

total = uo_calidades.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_calidades.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		calidad = uo_calidades.dw_marca.GetItemString(indice,"codigo")
		if filtrocalidades = "" then
			filtrocalidades = "'"+calidad+"'"
			texto_seleccion_en = uo_calidades.dw_marca.object.texto[indice]
		else
			filtrocalidades = filtrocalidades + ",'"+calidad+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_calidades.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		calidad = uo_calidades.dw_marca.GetItemString(indice,"codigo")
		if filtrocalidades_no = "" then
			filtrocalidades_no = "'"+calidad+"'"
			texto_seleccion_no_en = uo_calidades.dw_marca.object.texto[indice]
		else
			filtrocalidades_no = filtrocalidades_no + ",'"+calidad+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_calidades.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtrocalidades) <> "" then
			filtrocalidades = "and venlifac.calidad in ("+filtrocalidades+") "
			texto_seleccion_calidad = "CALIDADES : "+texto_seleccion_en
		end if
	else
		if trim(filtrocalidades_no) <> "" then
			filtrocalidades = "and venlifac.calidad not in ("+filtrocalidades_no+") "
			texto_seleccion_calidad = "TODAS LAS CALIDADES EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtrocalidades = ""
	texto_seleccion_calidad = "TODAS LAS CALIDADES"
end if
//Conceptos (Tipos de linea)

total = uo_conceptos.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_conceptos.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		tipolinea = uo_conceptos.dw_marca.GetItemString(indice,"codigo")
		if filtroconceptos = "" then
			filtroconceptos = "'"+tipolinea+"'"
			texto_seleccion_en = uo_conceptos.dw_marca.object.texto[indice]
		else
			filtroconceptos = filtroconceptos + ",'"+tipolinea+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_conceptos.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		tipolinea = uo_conceptos.dw_marca.GetItemString(indice,"codigo")
		if filtroconceptos_no = "" then
			filtroconceptos_no = "'"+tipolinea+"'"
			texto_seleccion_no_en = uo_conceptos.dw_marca.object.texto[indice]
		else
			filtroconceptos_no = filtroconceptos_no + ",'"+tipolinea+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_conceptos.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtroconceptos) <> "" then
			filtroconceptos = "and venlifac.tipolinea in ("+filtroconceptos+") "
			texto_seleccion_concepto = "CONCEPTOS : "+texto_seleccion_en
		end if
	else
		if trim(filtroconceptos_no) <> "" then
			filtroconceptos = "and venlifac.tipolinea not in ("+filtroconceptos_no+") "
			texto_seleccion_concepto = "TODOS LOS CONCEPTOS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtroconceptos = ""
	texto_seleccion_concepto = "TODOS LOS CONCEPTOS"
end if
//
//messagebox("texto_seleccion_cliente",texto_seleccion_cliente)
//messagebox("texto_seleccion",texto_seleccion)
//messagebox("texto_seleccion_serie",texto_seleccion_serie)
//messagebox("texto_seleccion_agente",texto_seleccion_agente)
//messagebox("texto_seleccion_area_manager",texto_seleccion_area_manager)
//messagebox("texto_seleccion_familia",texto_seleccion_familia)
//messagebox("texto_seleccion_formato",texto_seleccion_formato)
//messagebox("texto_seleccion_calidad",texto_seleccion_calidad)
//messagebox("texto_seleccion_concepto",texto_seleccion_concepto)

//texto_seleccion_formato = f_prepara_texto_explicativo(texto_seleccion_formato)
//messagebox("texto_seleccion_formato",texto_seleccion_formato)


//+replicate('0',unidades.decimales)

sel = "select venfac.cliente,"+&
		"       genter.razon,"+&
		"       venfac.agente1,"+&
		"       venagentes.nombre,"+&		
		"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
		"       venlifac.articulo,"+&
		"       articulos.descripcion,"+&		
		"       venlifac.calidad,"+&
		"       calidades.abreviado,"+&		
		"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
		"       articulos.familia,"+&
		"       familias.descripcion,"+&		
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       genter.pais,"+&
		"       paises.nombre,"+&		
		"       genter.provincia,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       '###,###,###,##0'+substring('.000000',1,(unidades.decimales/unidades.decimales+1)+unidades.decimales),"+&
		"       '"+moneda+"',"+&
		"       '"+mascara_moneda+"', "+&
		"       1,1,1,1,1,1 "+&
		"from   venfac,"+&
		"       venlifac,"+&
		"       genter,"+&
		"       venagentes,"+&
		"       articulos,"+&
		"       calidades,"+&
		"       formatos,"+&
		"       familias,"+&
		"       paises,"+&
		"       provincias,"+&
		"       unidades "+&
   	"where ( venfac.empresa    = venlifac.empresa ) "+&
		"and   ( venfac.anyo       = venlifac.anyo ) "+&
		"and   ( venfac.factura    = venlifac.factura ) "+&
		"and   ( venfac.empresa    = venagentes.empresa ) "+&
		"and   ( venfac.agente1    = venagentes.agente ) "+&
		"and   ( venfac.empresa    = genter.empresa ) "+&
		"and   ( venfac.cliente    = genter.codigo ) "+&
		"and   ( genter.pais       = paises.pais ) "+&
		"and   ( genter.provincia *= provincias.provincia ) "+&
		"and   ( genter.pais      *= provincias.pais ) "+&
		"and   ( genter.tipoter    = 'C' ) "+&
		"and   ( venlifac.empresa  = calidades.empresa ) "+&
		"and   ( venlifac.empresa  = familias.empresa ) "+&
		"and   ( venlifac.empresa  = formatos.empresa ) "+&		
		"and   ( venlifac.empresa  = articulos.empresa ) "+&
		"and   ( venlifac.articulo = articulos.codigo ) "+&
		"and   ( venlifac.calidad  = calidades.codigo ) "+&
		"and   ( articulos.familia = familias.codigo ) "+&		
		"and   ( articulos.formato = formatos.codigo ) "+&
		"and   ( articulos.unidad  = unidades.codigo ) "+&
		"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
		"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
		filtrocliente+&
		filtropaises+&
		filtroseries+&
		filtroagentes+&
		filtroareamanager+&
		filtrofamilias+&
		filtroformatos+&
		filtrocalidades+&
		filtroconceptos+&
		" "+&
		"group by venfac.cliente,"+&
		"       venfac.agente1,"+&
		"       venlifac.articulo,"+&
		"       venlifac.calidad,"+&
		"       genter.razon,"+&
		"       venagentes.nombre,"+&
		"       articulos.descripcion,"+&
		"       articulos.familia,"+&
		"       articulos.formato,"+&
		"       calidades.abreviado,"+&
		"       formatos.abreviado,"+&
		"       familias.descripcion,"+&
		"       genter.pais,"+&
		"       genter.provincia,"+&
		"       paises.nombre,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       unidades.decimales "


f_cargar_cursor_transaccion(sqlca,ds_ventas_articulos,sel)

total = ds_ventas_articulos.rowcount()

if total > 0 then
	ds_ventas_articulos.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
end if

destroy ds_ventas_articulos

sel = "select venfac.cliente,"+&
		"       genter.razon,"+&
		"       venfac.agente1,"+&
		"       venagentes.nombre,"+&		
		"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
		"       venlifac.articulo,"+&
		"       articulos.descripcion,"+&		
		"       venlifac.calidad,"+&
		"       '',"+&		
		"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
		"       articulos.familia,"+&
		"       familias.descripcion,"+&		
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       genter.pais,"+&
		"       paises.nombre,"+&		
		"       genter.provincia,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       '###,###,###,##0'+substring('.000000',1,(unidades.decimales/unidades.decimales+1)+unidades.decimales),"+&
		"       '"+moneda+"',"+&
		"       '"+mascara_moneda+"', "+&
		"       1,1,1,1,1,1 "+&
		"from   venfac,"+&
		"       venlifac,"+&
		"       genter,"+&
		"       venagentes,"+&
		"       articulos,"+&
		"       formatos,"+&
		"       familias,"+&
		"       paises,"+&
		"       provincias,"+&
		"       unidades "+&
   	"where ( venfac.empresa    = venlifac.empresa ) "+&
		"and   ( venfac.anyo       = venlifac.anyo ) "+&
		"and   ( venfac.factura    = venlifac.factura ) "+&
		"and   ( venfac.empresa    = venagentes.empresa ) "+&
		"and   ( venfac.agente1    = venagentes.agente ) "+&
		"and   ( venfac.empresa    = genter.empresa ) "+&
		"and   ( venfac.cliente    = genter.codigo ) "+&
		"and   ( genter.pais       = paises.pais ) "+&
		"and   ( genter.provincia *= provincias.provincia ) "+&
		"and   ( genter.pais      *= provincias.pais ) "+&
		"and   ( genter.tipoter    = 'C' ) "+&
		"and   ( venlifac.empresa  = familias.empresa ) "+&
		"and   ( venlifac.empresa  = formatos.empresa ) "+&		
		"and   ( venlifac.empresa  = articulos.empresa ) "+&
		"and   ( venlifac.articulo = articulos.codigo ) "+&
		"and   ( venlifac.calidad  = null or venlifac.calidad = '') "+&
		"and   ( articulos.familia = familias.codigo ) "+&		
		"and   ( articulos.formato = formatos.codigo ) "+&
		"and   ( articulos.unidad  = unidades.codigo ) "+&
		"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
		"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
		filtrocliente+&
		filtropaises+&
		filtroseries+&
		filtroagentes+&
		filtroareamanager+&
		filtrofamilias+&
		filtroformatos+&
		filtroconceptos+&
		" "+&
		"group by venfac.cliente,"+&
		"       venfac.agente1,"+&
		"       venlifac.articulo,"+&
		"       venlifac.calidad,"+&
		"       genter.razon,"+&
		"       venagentes.nombre,"+&
		"       articulos.descripcion,"+&
		"       articulos.familia,"+&
		"       articulos.formato,"+&
		"       formatos.abreviado,"+&
		"       familias.descripcion,"+&
		"       genter.pais,"+&
		"       genter.provincia,"+&
		"       paises.nombre,"+&
		"       provincias.nombre,"+&
		"       articulos.unidad,"+&
		"       unidades.abreviado,"+&
		"       unidades.decimales "

f_cargar_cursor_transaccion(sqlca,ds_ventas_articulos_no_sector,sel)

total = ds_ventas_articulos_no_sector.rowcount()

if total > 0 then
	ds_ventas_articulos_no_sector.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
end if

destroy ds_ventas_articulos_no_sector

if not(cbx_solo_articulos.checked) then
	
	sel = "select venfac.cliente,"+&
			"       genter.razon,"+&
			"       venfac.agente1,"+&
			"       venagentes.nombre,"+&		
			"       convert(decimal(16,6),sum(venlifac.neto / venfac.cambio)) importe,"+&
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&		
			"       '',"+&
			"       '',"+&		
			"       convert(decimal(16,6),sum(venlifac.cantidad)) ,"+&
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&		
			"       venlifac.tipolinea,"+&
			"       ventipolin.descripcion,"+&
			"       genter.pais,"+&
			"       paises.nombre,"+&		
			"       genter.provincia,"+&
			"       provincias.nombre,"+&
			"       '',"+&
			"       'UDS',"+&
			"       '###,###,###,##0',"+&
			"       '"+moneda+"',"+&
			"       '"+mascara_moneda+"', "+&		
			"       1,1,1,1,1,1 "+&
			"from   venfac,"+&
			"       venlifac,"+&
			"       genter,"+&
			"       venagentes,"+&
			"       ventipolin,"+&
			"       paises,"+&
			"       provincias "+&
			"where ( venfac.empresa    = venlifac.empresa ) "+&
			"and   ( venfac.anyo       = venlifac.anyo ) "+&
			"and   ( venfac.factura    = venlifac.factura ) "+&
			"and   ( venfac.empresa    = venagentes.empresa ) "+&
			"and   ( venfac.agente1    = venagentes.agente ) "+&
			"and   ( venfac.empresa    = genter.empresa ) "+&
			"and   ( venfac.cliente    = genter.codigo ) "+&
			"and   ( genter.pais       = paises.pais ) "+&
			"and   ( genter.provincia *= provincias.provincia ) "+&
			"and   ( genter.pais      *= provincias.pais ) "+&
			"and   ( genter.tipoter    = 'C' ) "+&
			"and   ( venlifac.empresa  = ventipolin.empresa ) "+&
			"and   ( venlifac.tipolinea = ventipolin.codigo ) "+&
			"and   ( venfac.empresa = '"+codigo_empresa+"' "+&
			"and     venlifac.articulo in('',null) "+&
			"and     venfac.ffactura between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"') "+&
			filtrocliente+&
			filtropaises+&
			filtroseries+&
			filtroagentes+&
			filtroareamanager+&
			filtroconceptos+&
			" "+&
			"group by venfac.cliente,"+&
			"       venfac.agente1,"+&
			"       venlifac.tipolinea,"+&
			"       genter.razon,"+&
			"       venagentes.nombre,"+&
			"       ventipolin.descripcion,"+&
			"       genter.pais,"+&
			"       genter.provincia,"+&
			"       paises.nombre,"+&
			"       provincias.nombre "

	f_cargar_cursor_transaccion(sqlca,ds_ventas_conceptos,sel)

	total = ds_ventas_conceptos.rowcount()
	
	if total > 0 then
		ds_ventas_conceptos.rowscopy(1,total,Primary!,tab_agrupaciones.tp_1.dw_1,1,Primary!)
	end if
end if

destroy ds_ventas_conceptos

for indice = 1 to 10
	numerado_tp[indice] = false
next

tab_agrupaciones.SelectTab(1)
tab_agrupaciones.tp_1.dw_1.sort()
tab_agrupaciones.tp_1.dw_1.groupcalc()
tab_agrupaciones.tp_1.dw_1.setredraw(true)

tab_agrupaciones.tp_1.dw_1.modify("datawindow.header.2.height='64 ~t if(codigo_pais=~~'11~~',64,0)'")

hora_fin = now()

//messagebox("",string(hora_inicio)+"/"+string(hora_fin))

end subroutine

event close;//dw_detalle_normal.reset()
tab_agrupaciones.tp_1.dw_1.reset()
dw_listado.reset()
end event

event open;call super::open;string    sel,codigo,texto,marca
long      nummarcas,indice
datastore datos

//Preparamos la ventana
istr_parametros.s_titulo_ventana="Estadisticas generales de Ventas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())

//dw_detalle_normal.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado3.SetTransObject(SQLCA)


//Cargamos los datos de las ventanas

sort_tp[1] = tab_agrupaciones.tp_1.dw_1.Describe("DataWindow.Table.Sort")
numerar_tp[1] = false
sort_tp[2] = tab_agrupaciones.tp_2.dw_2.Describe("DataWindow.Table.Sort")
numerar_tp[2] = false
sort_tp[3] = tab_agrupaciones.tp_3.dw_3.Describe("DataWindow.Table.Sort")
numerar_tp[3] = false
sort_tp[4] = tab_agrupaciones.tp_4.dw_4.Describe("DataWindow.Table.Sort")
numerar_tp[4] = true
sort_tp[5] = tab_agrupaciones.tp_5.dw_5.Describe("DataWindow.Table.Sort")
numerar_tp[5] = true
sort_tp[6] = tab_agrupaciones.tp_6.dw_6.Describe("DataWindow.Table.Sort")
numerar_tp[6] = true


tab_agrupaciones.tp_1.dw_1.SetTransObject(SQLCA)
tab_agrupaciones.tp_1.dw_1.sharedata(tab_agrupaciones.tp_2.dw_2)
tab_agrupaciones.tp_1.dw_1.sharedata(tab_agrupaciones.tp_3.dw_3)
tab_agrupaciones.tp_1.dw_1.sharedata(tab_agrupaciones.tp_4.dw_4)
tab_agrupaciones.tp_1.dw_1.sharedata(tab_agrupaciones.tp_5.dw_5)
tab_agrupaciones.tp_1.dw_1.sharedata(tab_agrupaciones.tp_6.dw_6)

//

//Paises
sel = "select pais,nombre from paises where pais in(select pais from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C')order by nombre"

datos			 = f_cargar_cursor(sel)		
nummarcas    = datos.rowcount()

uo_paises.st_titulo1.text = "Codigo"
uo_paises.st_titulo2.text = "Pais"

for indice = 1 To nummarcas
	codigo  = datos.object.pais[indice]
	texto	  = datos.object.nombre[indice]
	uo_paises.dw_marca.InsertRow(indice)
	uo_paises.dw_marca.object.marca[indice]  = "N"
	uo_paises.dw_marca.object.codigo[indice] = codigo
	uo_paises.dw_marca.object.texto[indice]  = texto
NEXT
destroy datos

//Agentes
sel = "select 	agente,nombre "+&
		"from   	venagentes "+&
		"where   empresa = '"+codigo_empresa+"' "+&
		"order 	by nombre"

datos			 = f_cargar_cursor(sel)		
nummarcas    = datos.rowcount()

uo_agentes.st_titulo1.text = "Codigo"
uo_agentes.st_titulo2.text = "Nombre"

for indice = 1 To nummarcas
	codigo  = datos.object.agente[indice]
	texto	  = datos.object.nombre[indice]
	uo_agentes.dw_marca.InsertRow(indice)
	uo_agentes.dw_marca.object.marca[indice]  = "N"
	uo_agentes.dw_marca.object.codigo[indice] = codigo
	uo_agentes.dw_marca.object.texto[indice]  = texto
NEXT
destroy datos

//Area Manager
sel = "select 	codigo,descripcion "+&
		"from   	venjefearea "+&
		"where   empresa = '"+codigo_empresa+"' "+&
		"order 	by codigo"

datos			 = f_cargar_cursor(sel)		
nummarcas    = datos.rowcount()

uo_area_manager.st_titulo1.text = "Codigo"
uo_area_manager.st_titulo2.text = "Nombre"

for indice = 1 To nummarcas
	codigo  = datos.object.codigo[indice]
	texto	  = datos.object.descripcion[indice]
	uo_area_manager.dw_marca.InsertRow(indice)
	uo_area_manager.dw_marca.object.marca[indice]  = "N"
	uo_area_manager.dw_marca.object.codigo[indice] = codigo
	uo_area_manager.dw_marca.object.texto[indice]  = texto
NEXT
destroy datos

//Familias
uo_familias.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")

//Formatos
uo_formatos.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")

//Series
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")

//Calidades
uo_calidades.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")

//Conceptos (Tipos de linea)
uo_conceptos.f_cargar_datos("dw_ayuda_ventipolin","","","Tipo Linea","Descripción")

f_activar_campo(em_fechadesde)


end event

on report_con_vtas_general.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_7=create gb_7
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_11=create gb_11
this.gb_1=create gb_1
this.st_1=create st_1
this.cb_familias=create cb_familias
this.cb_formatos=create cb_formatos
this.cb_provincias=create cb_provincias
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.cb_paises=create cb_paises
this.cb_agentes=create cb_agentes
this.cb_calidades=create cb_calidades
this.cb_series=create cb_series
this.cb_conceptos=create cb_conceptos
this.uo_familias=create uo_familias
this.uo_formatos=create uo_formatos
this.uo_calidades=create uo_calidades
this.uo_conceptos=create uo_conceptos
this.uo_series=create uo_series
this.uo_provincias=create uo_provincias
this.uo_paises=create uo_paises
this.tab_agrupaciones=create tab_agrupaciones
this.cbx_solo_articulos=create cbx_solo_articulos
this.cb_area_manager=create cb_area_manager
this.uo_area_manager=create uo_area_manager
this.uo_agentes=create uo_agentes
this.dw_listado3=create dw_listado3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_7
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_11
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.cb_familias
this.Control[iCurrent+15]=this.cb_formatos
this.Control[iCurrent+16]=this.cb_provincias
this.Control[iCurrent+17]=this.uo_cliente
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.cb_paises
this.Control[iCurrent+20]=this.cb_agentes
this.Control[iCurrent+21]=this.cb_calidades
this.Control[iCurrent+22]=this.cb_series
this.Control[iCurrent+23]=this.cb_conceptos
this.Control[iCurrent+24]=this.uo_familias
this.Control[iCurrent+25]=this.uo_formatos
this.Control[iCurrent+26]=this.uo_calidades
this.Control[iCurrent+27]=this.uo_conceptos
this.Control[iCurrent+28]=this.uo_series
this.Control[iCurrent+29]=this.uo_provincias
this.Control[iCurrent+30]=this.uo_paises
this.Control[iCurrent+31]=this.tab_agrupaciones
this.Control[iCurrent+32]=this.cbx_solo_articulos
this.Control[iCurrent+33]=this.cb_area_manager
this.Control[iCurrent+34]=this.uo_area_manager
this.Control[iCurrent+35]=this.uo_agentes
this.Control[iCurrent+36]=this.dw_listado3
end on

on report_con_vtas_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_11)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.cb_familias)
destroy(this.cb_formatos)
destroy(this.cb_provincias)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.cb_paises)
destroy(this.cb_agentes)
destroy(this.cb_calidades)
destroy(this.cb_series)
destroy(this.cb_conceptos)
destroy(this.uo_familias)
destroy(this.uo_formatos)
destroy(this.uo_calidades)
destroy(this.uo_conceptos)
destroy(this.uo_series)
destroy(this.uo_provincias)
destroy(this.uo_paises)
destroy(this.tab_agrupaciones)
destroy(this.cbx_solo_articulos)
destroy(this.cb_area_manager)
destroy(this.uo_area_manager)
destroy(this.uo_agentes)
destroy(this.dw_listado3)
end on

event ue_f5;cb_1.triggerevent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within report_con_vtas_general
integer taborder = 230
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within report_con_vtas_general
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within report_con_vtas_general
integer width = 2359
integer height = 108
end type

type pb_1 from upb_salir within report_con_vtas_general
integer x = 3451
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within report_con_vtas_general
integer x = 3451
integer y = 156
integer taborder = 220
end type

event clicked;//blob blob_traspaso
//f_control(dw_listado_normal)
//f_imprimir_datawindow(dw_listado_normal)
//

//dw_listado.retrieve(codigo_empresa,parent.title,texto_seleccion_final)
//dw_listado.print(false)

choose case tab_agrupaciones.selectedtab
	case 1
		f_prepara_dw_para_impresion(tab_agrupaciones.tp_1.dw_1)
		f_imprimir_datawindow(tab_agrupaciones.tp_1.dw_1)
		//tab_agrupaciones.tp_1.dw_1.print(true)
	case 2
		tab_agrupaciones.tp_2.dw_2.print(true)
	case 3
		tab_agrupaciones.tp_3.dw_3.print(true)
	case 4
		tab_agrupaciones.tp_4.dw_4.print(true)
	case 5
		tab_agrupaciones.tp_5.dw_5.print(true)		
	case 6
		tab_agrupaciones.tp_6.dw_6.print(true)				
end choose

//blob blob_traspaso
//Datawindowchild dw_hija_listado
//
//choose case tab_agrupaciones.selectedtab
//	case 1
//		if dw_listado.getchild('prueba',dw_hija_listado) <> -1 then	
//			messagebox("","Bien")
////			dw_hija_listado.report = tab_agrupaciones.tp_1.dw_1.dataobject
////			dw_hija_listado.settransobject(sqlca)
//			tab_agrupaciones.tp_1.dw_1.GetFullState(blob_traspaso)
////			dw_hija_listado.SetFullState(blob_traspaso)
//		end if
//	case 2
//		if dw_listado.getchild('prueba',dw_hija_listado) <> -1 then	
//			messagebox("","Bien")
////			dw_hija_listado.dataobject = tab_agrupaciones.tp_2.dw_2.dataobject
////			dw_hija_listado.settransobject(sqlca)
//			tab_agrupaciones.tp_2.dw_2.getfullstate(blob_traspaso)
////			dw_hija_listado.setfullstate(blob_traspaso)
//		end if
//	case 3
//		tab_agrupaciones.tp_3.dw_3.print(true)
//	case 4
//		tab_agrupaciones.tp_4.dw_4.print(true)
//	case 5
//		tab_agrupaciones.tp_5.dw_5.print(true)		
//	case 6
//		tab_agrupaciones.tp_6.dw_6.print(true)				
//end choose
//
//f_imprimir_datawindow(dw_listado)
////
////createdw
end event

type em_fechadesde from u_em_campo within report_con_vtas_general
integer x = 27
integer y = 172
integer width = 256
integer height = 80
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within report_con_vtas_general
integer x = 334
integer y = 172
integer width = 256
integer height = 80
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within report_con_vtas_general
boolean visible = false
integer x = 2377
integer y = 8
integer width = 146
integer height = 100
string dataobject = "report_cabecera_con_vtas_comp_general"
boolean livescroll = true
end type

type cb_1 from commandbutton within report_con_vtas_general
integer x = 3173
integer y = 156
integer width = 279
integer height = 104
integer taborder = 200
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_cargar_in()

end event

type gb_7 from groupbox within report_con_vtas_general
integer x = 1979
integer y = 116
integer width = 411
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within report_con_vtas_general
integer x = 1179
integer y = 276
integer width = 823
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within report_con_vtas_general
integer x = 9
integer y = 276
integer width = 1170
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Region:"
end type

type gb_3 from groupbox within report_con_vtas_general
integer x = 3159
integer y = 116
integer width = 434
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_11 from groupbox within report_con_vtas_general
integer x = 2002
integer y = 276
integer width = 1179
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo:"
end type

type gb_1 from groupbox within report_con_vtas_general
integer y = 116
integer width = 613
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Fra:"
end type

type st_1 from statictext within report_con_vtas_general
integer x = 283
integer y = 168
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_familias from commandbutton within report_con_vtas_general
integer x = 2016
integer y = 332
integer width = 384
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = not(uo_familias.visible)
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false
end event

type cb_formatos from commandbutton within report_con_vtas_general
integer x = 2400
integer y = 332
integer width = 384
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = not(uo_formatos.visible)
uo_calidades.visible  = false
uo_conceptos.visible  = false
end event

type cb_provincias from commandbutton within report_con_vtas_general
integer x = 407
integer y = 332
integer width = 384
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Provincias"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = not(uo_provincias.visible)
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false

////Cargamos los articulos de los paises seleccionados
//DataStore provincias
//String    sel,paises,pais,codigo_provincia,nombre_provincia,marca
//string    codigo_pais,nombre_pais,pais_provincia
//long      indice,total,indice2,total2,donde
//
//
//if uo_provincias.visible then
//	//sacamos los paises de los que debemos obtener las provincias
//	
//	total  = uo_paises.dw_marca.rowcount()
//	paises = ""
//	for indice = 1 to total
//		pais = uo_paises.dw_marca.object.codigo[indice]
//		if uo_paises.dw_marca.object.marca[indice] = "S" then
//			if trim(paises) = "" then
//				paises = "'"+pais+"'"
//			else
//				paises = paises+",'"+pais+"'"
//			end if
//		else
//			indice2 = 1
//			total2 = uo_provincias.dw_marca.rowcount()
//			do while indice2 <= total2
//				codigo_provincia = uo_provincias.dw_marca.object.codigo[indice2]			
//				pais_provincia   = Left(codigo_provincia,Pos(codigo_provincia,"/") -1)			
//				if pais_provincia = pais then
//					uo_provincias.dw_marca.deleterow(indice2)
//				else
//					indice2 ++
//				end if
//				total2 = uo_provincias.dw_marca.rowcount()			
//			loop 
//		end if
//	next
//	sel = "Select  pais,provincia,nombre "+&
//			"from provincias where pais in ("+paises+")"
//	provincias = f_cargar_cursor(sel)
//	total      = provincias.RowCOunt()
//	If total > 0 THEN
//		FOR indice = 1 To total
//			codigo_pais      = provincias.GetItemString(indice,"pais")
//			nombre_pais      = f_nombre_pais(codigo_pais)
//			codigo_provincia = provincias.GetItemString(indice,"provincia")
//			nombre_provincia = provincias.GetItemString(indice,"nombre")
//			codigo_provincia = codigo_pais+"/"+codigo_provincia
//			nombre_provincia = "("+nombre_pais+") "+nombre_provincia
//			donde = uo_provincias.dw_marca.find("codigo = '"+codigo_provincia+"'",1,uo_provincias.dw_marca.rowcount())
//			if donde = 0 or isnull(donde) then
//				marca = "S"			
//				donde = uo_provincias.dw_marca.InsertRow(0)
//				uo_provincias.dw_marca.object.marca[donde]  = marca
//				uo_provincias.dw_marca.object.codigo[donde] = codigo_provincia
//				uo_provincias.dw_marca.object.texto[donde]  = nombre_provincia
//			end if
//		NEXT
//	END IF
//	uo_provincias.dw_marca.setsort("texto")
//	uo_provincias.dw_marca.sort()
//	
//	uo_provincias.st_titulo1.text = "Codigo"
//	uo_provincias.st_titulo2.text = "Pais/Provincia"		
//
//end if
//destroy provincias
end event

type uo_cliente from u_em_campo_2 within report_con_vtas_general
event destroy ( )
integer x = 640
integer y = 180
integer width = 1326
integer height = 72
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text= f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text) = "" then
	uo_cliente.em_campo.text  = ""
	uo_cliente.em_codigo.text = ""
	cb_paises.enabled     = true
	cb_provincias.enabled = true
	cb_series.enabled     = true
	cb_agentes.enabled    = true
else
	cb_paises.enabled     = false
	cb_provincias.enabled = false
	cb_series.enabled     = false
	cb_agentes.enabled    = false	
	uo_paises.visible     = false
	uo_provincias.visible = false
	uo_series.visible     = false
	uo_agentes.visible    = false
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

type gb_2 from groupbox within report_con_vtas_general
integer x = 613
integer y = 116
integer width = 1367
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente:"
end type

type cb_paises from commandbutton within report_con_vtas_general
integer x = 23
integer y = 332
integer width = 384
integer height = 96
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

event clicked;uo_paises.visible     = not(uo_paises.visible)
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false

end event

type cb_agentes from commandbutton within report_con_vtas_general
integer x = 1193
integer y = 332
integer width = 384
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agentes"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = not(uo_agentes.visible)
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false
end event

type cb_calidades from commandbutton within report_con_vtas_general
integer x = 2784
integer y = 332
integer width = 384
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = not(uo_calidades.visible)
uo_conceptos.visible  = false
end event

type cb_series from commandbutton within report_con_vtas_general
integer x = 791
integer y = 332
integer width = 379
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Series"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = not(uo_series.visible)
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false
end event

type cb_conceptos from commandbutton within report_con_vtas_general
integer x = 1993
integer y = 164
integer width = 384
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Conceptos"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = false
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = not(uo_conceptos.visible)
end event

type uo_familias from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 1390
integer y = 428
integer width = 1349
integer height = 656
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type uo_formatos from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 1669
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 140
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type uo_calidades from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 1947
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 150
boolean bringtotop = true
boolean border = false
end type

on uo_calidades.destroy
call u_marca_lista::destroy
end on

type uo_conceptos from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 2226
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 160
boolean bringtotop = true
boolean border = false
end type

on uo_conceptos.destroy
call u_marca_lista::destroy
end on

type uo_series from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 567
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 210
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type uo_provincias from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 288
integer y = 428
integer width = 1349
integer height = 656
boolean border = false
end type

on uo_provincias.destroy
call u_marca_lista::destroy
end on

type uo_paises from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 9
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 130
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

event itemchanged;//Cargamos los articulos de los paises seleccionados
DataStore provincias
String    sel,codigo_provincia,nombre_provincia,marca
string    codigo_pais,nombre_pais,pais_provincia
long      indice,total,donde


if data = "S" then
	//sacamos los paises de los que debemos obtener las provincias
	
	codigo_pais = uo_paises.dw_marca.object.codigo[row]
	nombre_pais = f_nombre_pais(codigo_pais)
	
	sel = "Select  provincia,nombre "+&
			"from provincias where pais = '"+codigo_pais+"'"
			
	f_cargar_cursor_transaccion(sqlca,provincias,sel)
	total      = provincias.rowcount()

	for indice = 1 To total				
		codigo_provincia = provincias.object.provincia[indice]
		nombre_provincia = provincias.object.nombre[indice]
		codigo_provincia = codigo_pais+"/"+codigo_provincia
		nombre_provincia = "("+nombre_pais+") "+nombre_provincia
		donde = uo_provincias.dw_marca.find("codigo = '"+codigo_provincia+"'",1,uo_provincias.dw_marca.rowcount())
		if donde = 0 or isnull(donde) then
			marca = "S"			
			donde = uo_provincias.dw_marca.InsertRow(0)
			uo_provincias.dw_marca.object.marca[donde]  = marca
			uo_provincias.dw_marca.object.codigo[donde] = codigo_provincia
			uo_provincias.dw_marca.object.texto[donde]  = nombre_provincia
		end if
	next

	uo_provincias.dw_marca.setsort("texto")
	uo_provincias.dw_marca.sort()
	
	uo_provincias.st_titulo1.text = "Codigo"
	uo_provincias.st_titulo2.text = "Pais/Provincia"		
else
	codigo_pais = uo_paises.dw_marca.object.codigo[row]
	nombre_pais = f_nombre_pais(codigo_pais)
	
	sel = "Select  provincia,nombre "+&
			"from provincias where pais = '"+codigo_pais+"'"
			
	f_cargar_cursor_transaccion(sqlca,provincias,sel)
	total      = provincias.rowcount()

	for indice = 1 To total				
		codigo_provincia = provincias.object.provincia[indice]
		codigo_provincia = codigo_pais+"/"+codigo_provincia

		donde = uo_provincias.dw_marca.find("codigo = '"+codigo_provincia+"'",1,uo_provincias.dw_marca.rowcount())
		if donde <> 0 then
			uo_provincias.dw_marca.deleterow(donde)
		end if
	next

	uo_provincias.dw_marca.setsort("texto")
	uo_provincias.dw_marca.sort()
	
	uo_provincias.st_titulo1.text = "Codigo"
	uo_provincias.st_titulo2.text = "Pais/Provincia"			
end if
destroy provincias
end event

type tab_agrupaciones from tab within report_con_vtas_general
event create ( )
event destroy ( )
integer x = 9
integer y = 456
integer width = 3570
integer height = 1376
integer taborder = 190
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
tp_4 tp_4
tp_5 tp_5
tp_6 tp_6
end type

on tab_agrupaciones.create
this.tp_1=create tp_1
this.tp_2=create tp_2
this.tp_3=create tp_3
this.tp_4=create tp_4
this.tp_5=create tp_5
this.tp_6=create tp_6
this.Control[]={this.tp_1,&
this.tp_2,&
this.tp_3,&
this.tp_4,&
this.tp_5,&
this.tp_6}
end on

on tab_agrupaciones.destroy
destroy(this.tp_1)
destroy(this.tp_2)
destroy(this.tp_3)
destroy(this.tp_4)
destroy(this.tp_5)
destroy(this.tp_6)
end on

event selectionchanged;long inicio_grupo,grupo,total_lineas
		
choose case newindex
	case 1
		tab_agrupaciones.tp_1.dw_1.setredraw(false)
		tab_agrupaciones.tp_1.dw_1.setsort(sort_tp[1])
		tab_agrupaciones.tp_1.dw_1.sort()
		tab_agrupaciones.tp_1.dw_1.groupcalc()
		
		if numerar_tp[1] and not numerado_tp[1] then
			numerado_tp[1] = true
			total_lineas = tab_agrupaciones.tp_1.dw_1.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_1.dw_1.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_1.dw_1.object.contador_ranking1[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
								
		tab_agrupaciones.tp_1.dw_1.setredraw(true)
	case 2
		tab_agrupaciones.tp_2.dw_2.setredraw(false)
		tab_agrupaciones.tp_2.dw_2.setsort(sort_tp[2])
		tab_agrupaciones.tp_2.dw_2.sort()
		tab_agrupaciones.tp_2.dw_2.groupcalc()
		
		if numerar_tp[2] and not numerado_tp[2] then
			numerado_tp[2] = true
			total_lineas = tab_agrupaciones.tp_2.dw_2.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_2.dw_2.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_2.dw_2.object.contador_ranking2[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
						
		tab_agrupaciones.tp_2.dw_2.setredraw(true)
	case 3
		tab_agrupaciones.tp_3.dw_3.setredraw(false)
		tab_agrupaciones.tp_3.dw_3.setsort(sort_tp[3])
		tab_agrupaciones.tp_3.dw_3.sort()
		tab_agrupaciones.tp_3.dw_3.groupcalc()
		
		if numerar_tp[3] and not numerado_tp[3] then
			numerado_tp[3] = true
			total_lineas = tab_agrupaciones.tp_3.dw_3.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_3.dw_3.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_3.dw_3.object.contador_ranking3[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
				
		tab_agrupaciones.tp_3.dw_3.setredraw(true)
	case 4
		tab_agrupaciones.tp_4.dw_4.setredraw(false)
		tab_agrupaciones.tp_4.dw_4.groupcalc()
		tab_agrupaciones.tp_4.dw_4.setsort(sort_tp[4])
		tab_agrupaciones.tp_4.dw_4.sort()
		tab_agrupaciones.tp_4.dw_4.groupcalc()
		
		if numerar_tp[4] and not numerado_tp[4] then
			numerado_tp[4] = true
			total_lineas = tab_agrupaciones.tp_4.dw_4.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_4.dw_4.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_4.dw_4.object.contador_ranking4[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		tab_agrupaciones.tp_4.dw_4.setredraw(true)		
	case 5
		
		tab_agrupaciones.tp_5.dw_5.setredraw(false)			
		tab_agrupaciones.tp_5.dw_5.groupcalc()
		tab_agrupaciones.tp_5.dw_5.setsort(sort_tp[5])
		tab_agrupaciones.tp_5.dw_5.sort()
		tab_agrupaciones.tp_5.dw_5.groupcalc()
		
		if numerar_tp[5] and not numerado_tp[5] then
			numerado_tp[5] = true
			total_lineas = tab_agrupaciones.tp_5.dw_5.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_5.dw_5.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_5.dw_5.object.contador_ranking5[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		tab_agrupaciones.tp_5.dw_5.setredraw(true)			
	case 6
		tab_agrupaciones.tp_6.dw_6.setredraw(false)			
		tab_agrupaciones.tp_6.dw_6.groupcalc()
		tab_agrupaciones.tp_6.dw_6.setsort(sort_tp[6])
		tab_agrupaciones.tp_6.dw_6.sort()
		tab_agrupaciones.tp_6.dw_6.groupcalc()
		
		MESSAGEBOX("",sort_tp[6])
		
		if numerar_tp[6] and not numerado_tp[6] then
			numerado_tp[6] = true
			total_lineas = tab_agrupaciones.tp_6.dw_6.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = tab_agrupaciones.tp_6.dw_6.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					tab_agrupaciones.tp_6.dw_6.object.contador_ranking6[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		tab_agrupaciones.tp_6.dw_6.setredraw(true)					
end choose
end event

type tp_1 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Pais/Provincia/Agente/Cliente"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tp_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tp_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tp_1
integer width = 3538
integer height = 1252
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_con_vtas_general1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
	case "pb_muestra_grupo6"
		this.modify("datawindow.header.6.height=64")
		this.modify("pb_muestra_grupo6.visible=0")		
	case "pb_oculta_grupo6"
		this.modify("datawindow.header.6.height=0")
		this.modify("pb_muestra_grupo6.visible=1")
	case "pb_muestra_grupo7"
		this.modify("datawindow.header.7.height=64")
		this.modify("pb_muestra_grupo7.visible=0")		
	case "pb_oculta_grupo7"
		this.modify("datawindow.header.7.height=0")
		this.modify("pb_muestra_grupo7.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type tp_2 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Agente/Pais/Provincia/cliente"
long tabtextcolor = 8388608
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tp_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tp_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tp_2
integer y = 4
integer width = 3538
integer height = 1252
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_vtas_general2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
	case "pb_muestra_grupo6"
		this.modify("datawindow.header.6.height=64")
		this.modify("pb_muestra_grupo6.visible=0")		
	case "pb_oculta_grupo6"
		this.modify("datawindow.header.6.height=0")
		this.modify("pb_muestra_grupo6.visible=1")
	case "pb_muestra_grupo7"
		this.modify("datawindow.header.7.height=64")
		this.modify("pb_muestra_grupo7.visible=0")		
	case "pb_oculta_grupo7"
		this.modify("datawindow.header.7.height=0")
		this.modify("pb_muestra_grupo7.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type tp_3 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Cliente/Familia/Formato"
long tabtextcolor = 8388608
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tp_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tp_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tp_3
integer y = 4
integer width = 3538
integer height = 1252
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_vtas_general3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type tp_4 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Ranking Pais/Provincia/Agente/Cliente"
long tabtextcolor = 128
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tp_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tp_4.destroy
destroy(this.dw_4)
end on

type dw_4 from datawindow within tp_4
integer width = 3534
integer height = 1256
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_con_vtas_general4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type tp_5 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Ranking Clientes"
long tabtextcolor = 128
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tp_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tp_5.destroy
destroy(this.dw_5)
end on

type dw_5 from datawindow within tp_5
integer width = 3534
integer height = 1256
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_vtas_general5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type tp_6 from userobject within tab_agrupaciones
integer x = 18
integer y = 104
integer width = 3534
integer height = 1256
long backcolor = 80269524
string text = "Ranking Familia/Formato/Articulo"
long tabtextcolor = 128
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tp_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tp_6.destroy
destroy(this.dw_6)
end on

type dw_6 from datawindow within tp_6
integer width = 3534
integer height = 1256
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_vtas_general6"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
choose case dwo.name
	case "pb_muestra_grupo2"
		this.modify("datawindow.header.2.height=64")
		this.modify("pb_muestra_grupo2.visible=0")
	case "pb_oculta_grupo2"
		this.modify("datawindow.header.2.height=0")
		this.modify("pb_muestra_grupo2.visible=1")
	case "pb_muestra_grupo3"
		this.modify("datawindow.header.3.height=64")
		this.modify("pb_muestra_grupo3.visible=0")		
	case "pb_oculta_grupo3"
		this.modify("datawindow.header.3.height=0")
		this.modify("pb_muestra_grupo3.visible=1")
	case "pb_muestra_grupo4"
		this.modify("datawindow.header.4.height=64")
		this.modify("pb_muestra_grupo4.visible=0")		
	case "pb_oculta_grupo4"
		this.modify("datawindow.header.4.height=0")
		this.modify("pb_muestra_grupo4.visible=1")
	case "pb_muestra_grupo5"
		this.modify("datawindow.header.5.height=64")
		this.modify("pb_muestra_grupo5.visible=0")		
	case "pb_oculta_grupo5"
		this.modify("datawindow.header.5.height=0")
		this.modify("pb_muestra_grupo5.visible=1")
end choose

//f_cargar_cliente(string(object.venclientes_codigo[long(mid(string(getobjectatpointer()), pos(getobjectatpointer(), "~t"), 4))]))

end event

type cbx_solo_articulos from checkbox within report_con_vtas_general
integer x = 3191
integer y = 380
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Solo Articulos"
end type

type cb_area_manager from commandbutton within report_con_vtas_general
integer x = 1577
integer y = 332
integer width = 411
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Area Manag."
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = false
uo_series.visible     = false
uo_agentes.visible    = false
uo_area_manager.visible = not(uo_area_manager.visible)
uo_familias.visible   = false
uo_formatos.visible   = false
uo_calidades.visible  = false
uo_conceptos.visible  = false
end event

type uo_area_manager from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 846
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 170
boolean border = false
end type

on uo_area_manager.destroy
call u_marca_lista::destroy
end on

type uo_agentes from u_marca_lista within report_con_vtas_general
event destroy ( )
boolean visible = false
integer x = 846
integer y = 428
integer width = 1349
integer height = 656
integer taborder = 180
boolean border = false
end type

on uo_agentes.destroy
call u_marca_lista::destroy
end on

type dw_listado3 from datawindow within report_con_vtas_general
integer x = 2629
integer y = 40
integer width = 416
integer height = 184
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "report_con_vtas_general1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

