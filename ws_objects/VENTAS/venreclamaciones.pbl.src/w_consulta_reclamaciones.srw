$PBExportHeader$w_consulta_reclamaciones.srw
forward
global type w_consulta_reclamaciones from w_int_con_empresa
end type
type pb_1 from upb_salir within w_consulta_reclamaciones
end type
type dw_listado4 from datawindow within w_consulta_reclamaciones
end type
type cb_1 from u_boton within w_consulta_reclamaciones
end type
type pb_imprimir from upb_imprimir within w_consulta_reclamaciones
end type
type cb_paises from commandbutton within w_consulta_reclamaciones
end type
type cb_provincias from commandbutton within w_consulta_reclamaciones
end type
type uo_provincias from u_marca_lista_3 within w_consulta_reclamaciones
end type
type cb_2 from commandbutton within w_consulta_reclamaciones
end type
type uo_agentes from u_marca_lista_3 within w_consulta_reclamaciones
end type
type em_top from u_em_campo within w_consulta_reclamaciones
end type
type dw_grafico_agentes from datawindow within w_consulta_reclamaciones
end type
type dw_grafico_sectores from datawindow within w_consulta_reclamaciones
end type
type uo_paises from u_marca_lista_3 within w_consulta_reclamaciones
end type
type em_fechadesde from u_em_campo within w_consulta_reclamaciones
end type
type em_fechahasta from u_em_campo within w_consulta_reclamaciones
end type
type uo_cliente from u_em_campo_2 within w_consulta_reclamaciones
end type
type gb_2 from groupbox within w_consulta_reclamaciones
end type
type gb_3 from groupbox within w_consulta_reclamaciones
end type
type apartados from tab within w_consulta_reclamaciones
end type
type pagina1 from userobject within apartados
end type
type dw_1 from u_datawindow_consultas within pagina1
end type
type pagina1 from userobject within apartados
dw_1 dw_1
end type
type pagina2 from userobject within apartados
end type
type dw_2 from u_datawindow_consultas within pagina2
end type
type pagina2 from userobject within apartados
dw_2 dw_2
end type
type pagina3 from userobject within apartados
end type
type dw_3 from u_datawindow_consultas within pagina3
end type
type pagina3 from userobject within apartados
dw_3 dw_3
end type
type pagina4 from userobject within apartados
end type
type dw_4 from u_datawindow_consultas within pagina4
end type
type pagina4 from userobject within apartados
dw_4 dw_4
end type
type pagina5 from userobject within apartados
end type
type dw_5 from u_datawindow_consultas within pagina5
end type
type pagina5 from userobject within apartados
dw_5 dw_5
end type
type pagina6 from userobject within apartados
end type
type dw_6 from u_datawindow_consultas within pagina6
end type
type pagina6 from userobject within apartados
dw_6 dw_6
end type
type apartados from tab within w_consulta_reclamaciones
pagina1 pagina1
pagina2 pagina2
pagina3 pagina3
pagina4 pagina4
pagina5 pagina5
pagina6 pagina6
end type
type cb_3 from commandbutton within w_consulta_reclamaciones
end type
type cb_4 from commandbutton within w_consulta_reclamaciones
end type
type uo_motivos from u_marca_lista_3 within w_consulta_reclamaciones
end type
type uo_causas from u_marca_lista_3 within w_consulta_reclamaciones
end type
type gb_1 from groupbox within w_consulta_reclamaciones
end type
end forward

global type w_consulta_reclamaciones from w_int_con_empresa
integer width = 3671
integer height = 2044
string title = "Consulta de Establecimientos"
pb_1 pb_1
dw_listado4 dw_listado4
cb_1 cb_1
pb_imprimir pb_imprimir
cb_paises cb_paises
cb_provincias cb_provincias
uo_provincias uo_provincias
cb_2 cb_2
uo_agentes uo_agentes
em_top em_top
dw_grafico_agentes dw_grafico_agentes
dw_grafico_sectores dw_grafico_sectores
uo_paises uo_paises
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
uo_cliente uo_cliente
gb_2 gb_2
gb_3 gb_3
apartados apartados
cb_3 cb_3
cb_4 cb_4
uo_motivos uo_motivos
uo_causas uo_causas
gb_1 gb_1
end type
global w_consulta_reclamaciones w_consulta_reclamaciones

type variables
string sort_tp[10]
boolean numerar_tp[10]
boolean numerado_tp[10]
boolean dw_principal[10]
end variables

forward prototypes
public subroutine f_carga_in ()
end prototypes

public subroutine f_carga_in ();long    indice,total,indice2,donde,opciones,opciones_marcadas,opciones_marcadas_no
string  filtrocliente,texto_seleccion_cliente,pais,descripcion,filtropaises,texto_seleccion_en,texto_seleccion_final
string  pais_anterior,codigo,provincia,agente,filtroagentes,filtroagentes_no,texto_seleccion_no_en,texto_seleccion_agente
string  caracter,agentes,provincias,motivo,filtromotivos,filtromotivos_no,texto_seleccion_motivo
string  causa,filtrocausas,filtrocausas_no,texto_seleccion_causa,ls_sel
boolean extrayendo_pais,extrayendo_provincia
datetime f_desde,f_hasta

string codigo_cliente,ls_cliente,ls_filtro_cliente,codigo_agente,codigo_articulo,articulo,codigo_calidad
string codigo_motivo,codigo_causa,codigo_pais,codigo_provincia
string codigo_unidad,unidad,mascara_unidad,moneda,mascara_moneda
dec    importe,cantidad

datastore ds_datos

if dw_principal[1]  then
	apartados.pagina1.dw_1.reset()
end if
if dw_principal[2]  then
	apartados.pagina2.dw_2.reset()
end if
if dw_principal[3]  then
	apartados.pagina3.dw_3.reset()
end if
if dw_principal[4]  then
	apartados.pagina4.dw_4.reset()
end if
if dw_principal[5]  then
	apartados.pagina5.dw_5.reset()
end if
if dw_principal[6]  then
	apartados.pagina6.dw_6.reset()
end if				

apartados.pagina1.dw_1.setredraw(false)
apartados.pagina2.dw_2.setredraw(false)
apartados.pagina3.dw_3.setredraw(false)
apartados.pagina4.dw_4.setredraw(false)
apartados.pagina5.dw_5.setredraw(false)
apartados.pagina6.dw_6.setredraw(false)

//
f_desde    = DateTime(Date(em_fechadesde.text))
f_hasta    = DateTime(Date(em_fechahasta.text))

if uo_cliente.em_codigo.text <> "" then
	filtrocliente = " and ven_reclamaciones.cliente = '"+uo_cliente.em_codigo.text+"' "
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
				filtroagentes = "and venclientes.agente1 in ("+filtroagentes+") "
				texto_seleccion_agente = "AGENTES : "+texto_seleccion_en
			end if
		else
			if trim(filtroagentes_no) <> "" then
				filtroagentes = "and venclientes.agente1 not in ("+filtroagentes_no+") "
				texto_seleccion_agente = "TODOS LOS AGENTES EXCEPTO "+texto_seleccion_no_en
			end if	
		end if
	else
		filtroagentes = ""
		texto_seleccion_agente = "TODOS LOS AGENTES"
	end if
	texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_agente
else
	filtropaises  = ""
	filtroagentes = ""
	
	texto_seleccion_final = texto_seleccion_cliente
end if

//Motivos

total = uo_motivos.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_motivos.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		motivo = uo_motivos.dw_marca.GetItemString(indice,"codigo")
		if filtromotivos = "" then
			filtromotivos = "'"+motivo+"'"
			texto_seleccion_en = uo_motivos.dw_marca.object.texto[indice]
		else
			filtromotivos = filtromotivos + ",'"+motivo+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_motivos.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		motivo = uo_motivos.dw_marca.GetItemString(indice,"codigo")
		if filtromotivos_no = "" then
			filtromotivos_no = "'"+motivo+"'"
			texto_seleccion_no_en = uo_motivos.dw_marca.object.texto[indice]
		else
			filtromotivos_no = filtromotivos_no + ",'"+motivo+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_motivos.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtromotivos) <> "" then
			filtromotivos = "and ven_reclamaciones.codigo_ven_reclamaciones_tipos in ("+filtromotivos+") "
			texto_seleccion_motivo = "motivos : "+texto_seleccion_en
		end if
	else
		if trim(filtromotivos_no) <> "" then
			filtromotivos = "and ven_reclamaciones.codigo_ven_reclamaciones_tipos not in ("+filtromotivos_no+") "
			texto_seleccion_motivo = "TODOS LOS MOTIVOS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtromotivos = ""
	texto_seleccion_motivo = "TODOS LOS MOTIVOS"
end if

texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_motivo
//Causas

total = uo_causas.dw_marca.RowCount()

opciones = total
opciones_marcadas = 0
opciones_marcadas_no = 0

for indice = 1 to total
	IF uo_causas.dw_marca.GetItemString(indice,"marca") = "S" THEN
		opciones_marcadas ++
		causa = uo_causas.dw_marca.GetItemString(indice,"codigo")
		if filtrocausas = "" then
			filtrocausas = "'"+causa+"'"
			texto_seleccion_en = uo_causas.dw_marca.object.texto[indice]
		else
			filtrocausas = filtrocausas + ",'"+causa+"'"
			texto_seleccion_en = texto_seleccion_en+";"+uo_causas.dw_marca.object.texto[indice]
		end if
	else
		opciones_marcadas_no ++
		causa = uo_causas.dw_marca.GetItemString(indice,"codigo")
		if filtrocausas_no = "" then
			filtrocausas_no = "'"+causa+"'"
			texto_seleccion_no_en = uo_causas.dw_marca.object.texto[indice]
		else
			filtrocausas_no = filtrocausas_no + ",'"+causa+"'"
			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_causas.dw_marca.object.texto[indice]
		end if		
	end if
next

if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
	if opciones_marcadas <= opciones_marcadas_no then
		if trim(filtrocausas) <> "" then
			filtrocausas = "and ven_reclamaciones.codigo_ven_reclamaciones_causa in ("+filtrocausas+") "
			texto_seleccion_causa = "causas : "+texto_seleccion_en
		end if
	else
		if trim(filtrocausas_no) <> "" then
			filtrocausas = "and ven_reclamaciones.codigo_ven_reclamaciones_causa not in ("+filtrocausas_no+") "
			texto_seleccion_causa = "TODAS LAS CAUSAS EXCEPTO "+texto_seleccion_no_en
		end if		
	end if
else
	filtrocausas = ""
	texto_seleccion_causa = "TODAS LAS CAUSAS"
end if	
texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_causa

ls_sel = "SELECT ven_reclamaciones.empresa, "+&
			"	ven_reclamaciones.cliente, "+&
			"	genter.razon, "+&
			"	ven_reclamaciones.reclamacion, "+&
			"	ven_reclamaciones.descripcion, "+&
			"	ven_reclamaciones.fecha, "+&     
			"	ven_reclamaciones.codigo_ven_reclamaciones_tipos, "+&
			"	ven_reclamaciones_tipos.descripcion, "+&
			"	ven_reclamaciones.codigo_ven_reclamaciones_situa, "+&
			"	ven_reclamaciones_situaciones.descripcion, "+&
			"	ven_reclamaciones.codigo_ven_reclamaciones_causa, "+&
			"	ven_reclamaciones_causas.descripcion, "+&
			"	ven_reclamaciones.cerrada, "+&
			"	ven_reclamaciones.ven_reclamaciones_respo_codigo, "+&
			"	ven_reclamaciones_responsables.descripcion, "+&
			"	venclientes.agente1, "+&
			"	venagentes.nombre, "+&
			"	ven_reclamaciones.telefonos_codigo, "+&
			"	telefonos.contacto "+&
		 	"FROM genter, "+&
			"	ven_reclamaciones, "+&
			"	ven_reclamaciones_causas, "+&
			"	ven_reclamaciones_responsables, "+&
			"	ven_reclamaciones_situaciones, "+&
			"	ven_reclamaciones_tipos, "+&
			"	venagentes, "+&
			"	venclientes, "+&
			"	telefonos, "+&
			"	paises, "+&
			"	provincias "+&
			"WHERE ( ven_reclamaciones.empresa                         = ven_reclamaciones_causas.empresa ) "+&
			"and   ( ven_reclamaciones.empresa                         = ven_reclamaciones_tipos.empresa ) "+&
			"and   ( ven_reclamaciones.empresa                         = genter.empresa ) "+&
			"and   ( ven_reclamaciones.empresa                         = venagentes.empresa ) "+&
			"and   ( ven_reclamaciones.empresa                        *= ven_reclamaciones_situaciones.empresa ) "+&
			"and   ( ven_reclamaciones.empresa                         = venclientes.empresa ) "+&
			"and   ( ven_reclamaciones.cliente                         = venclientes.codigo ) "+&
			"and   ( venclientes.agente1                               = venagentes.agente ) "+&
			"and   ( ven_reclamaciones.cliente                         = genter.codigo ) "+&
			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_causa  = ven_reclamaciones_causas.codigo ) "+&
			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_tipos  = ven_reclamaciones_tipos.codigo ) "+&
			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_situa *= ven_reclamaciones_situaciones.codigo ) "+&
			"and   ( ven_reclamaciones.empresa                        *= ven_reclamaciones_responsables.empresa ) "+&
			"and   ( ven_reclamaciones.ven_reclamaciones_respo_codigo *= ven_reclamaciones_responsables.codigo ) "+&
			"and   ( ven_reclamaciones.empresa                        *= telefonos.empresa ) "+&
			"and   ( ven_reclamaciones.telefonos_codigo               *= telefonos.telefono ) "+&
			"and   ( genter.tipoter                                   *= telefonos.tipoter ) "+&
			"and   ( ven_reclamaciones.cliente                        *= telefonos.codigo ) "+&
			"and   ( genter.pais                                       = paises.pais ) "+&
			"and   ( genter.provincia                                 *= provincias.provincia ) "+&
			"and   ( genter.pais                                      *= provincias.pais ) "+&
			"and   ( ( ven_reclamaciones.empresa = '"+codigo_empresa+"' ) ) "+&
			" and  ( ven_reclamaciones.fecha  between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"')" + &
			filtrocliente+&
			filtropaises+&
			filtroagentes+&
			filtromotivos+&
			filtrocausas
	
//		and   ( ( ven_reclamaciones.empresa = '' ) 
//		AND     ( ven_reclamaciones.cliente = '' ) 
//		AND     ( genter.pais in ('') ) 
//		AND     ( genter.provincia in ('') ) 
//		AND     ( venclientes.agente1 in ('') ) 
//		AND     ( ven_reclamaciones.codigo_ven_reclamaciones_tipos in ('') ) 
//

f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

total = ds_datos.rowcount()

if total > 0 then
	if dw_principal[1]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if
	if dw_principal[2]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if
	if dw_principal[3]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if
	if dw_principal[4]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if
	if dw_principal[5]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if
	if dw_principal[6]  then
		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
	end if				
end if

destroy ds_datos

for indice = 1 to 10
	numerado_tp[indice] = false
next

apartados.event selectionchanged(0,apartados.selectedtab)

apartados.pagina1.dw_1.setredraw(true)

end subroutine

event open;call super::open;datastore u_ds_datos
string ls_sel,ls_codigo,ls_texto
long ll_marcas,indice

istr_parametros.s_titulo_ventana="Consulta de Reclamaciones"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

//Cargamos los datos de las ventanas
dw_principal[1] = true
sort_tp[1] = apartados.pagina1.dw_1.Describe("DataWindow.Table.Sort")
numerar_tp[1] = false

dw_principal[2] = false
sort_tp[2] = apartados.pagina2.dw_2.Describe("DataWindow.Table.Sort")
numerar_tp[2] = false

dw_principal[3] = false
sort_tp[3] = apartados.pagina3.dw_3.Describe("DataWindow.Table.Sort")
numerar_tp[3] = false

dw_principal[4] = false
sort_tp[4] = apartados.pagina4.dw_4.Describe("DataWindow.Table.Sort")
numerar_tp[4] = false

dw_principal[5] = false
sort_tp[5] = apartados.pagina5.dw_5.Describe("DataWindow.Table.Sort")
numerar_tp[5] = false

dw_principal[6] = false
sort_tp[6] = apartados.pagina6.dw_6.Describe("DataWindow.Table.Sort")
numerar_tp[6] = false

apartados.pagina1.dw_1.SetTransObject(SQLCA)
//apartados.pagina1.dw_1.sharedata(apartados.pagina1.report_1)

apartados.pagina1.dw_1.sharedata(apartados.pagina2.dw_2)
//apartados.pagina1.dw_1.sharedata(apartados.pagina2.report_2)

apartados.pagina1.dw_1.sharedata(apartados.pagina3.dw_3)
//apartados.pagina1.dw_1.sharedata(apartados.pagina3.report_3)

//apartados.pagina4.dw_4.SetTransObject(SQLCA)
apartados.pagina1.dw_1.sharedata(apartados.pagina4.dw_4)
//apartados.pagina4.dw_4.sharedata(apartados.pagina4.report_4)

//apartados.pagina5.dw_5.SetTransObject(SQLCA)
apartados.pagina1.dw_1.sharedata(apartados.pagina5.dw_5)
//apartados.pagina5.dw_5.sharedata(apartados.pagina5.report_5)

//apartados.pagina6.dw_6.SetTransObject(SQLCA)
apartados.pagina1.dw_1.sharedata(apartados.pagina6.dw_6)
//apartados.pagina6.dw_6.sharedata(apartados.pagina6.report_6)

ls_sel = "select pais,nombre from paises where pais in(select pais from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C')order by nombre"
//ls_sel = "select pais,nombre from paises  order by nombre"

u_ds_datos			 = f_cargar_cursor(ls_sel)		
ll_marcas    = u_ds_datos.rowcount()

uo_paises.st_titulo1.text = "Codigo"
uo_paises.st_titulo2.text = "Pais"

for indice = 1 To ll_marcas
	ls_codigo  = u_ds_datos.object.pais[indice]
	ls_texto	  = u_ds_datos.object.nombre[indice]
	uo_paises.dw_marca.InsertRow(indice)
	uo_paises.dw_marca.object.marca[indice]  = "N"
	uo_paises.dw_marca.object.codigo[indice] = ls_codigo
	uo_paises.dw_marca.object.texto[indice]  = ls_texto
NEXT
destroy u_ds_datos

//Agentes
uo_agentes.f_cargar_datos("dw_ayuda_venagentes","","","Agente","Nombre")

//Motivos
uo_motivos.f_cargar_datos("dw_ayuda_ven_reclamaciones_tipos","","","Motivo","Nombre")

//Causas
uo_causas.f_cargar_datos("dw_ayuda_ven_reclamaciones_causas","","","Causa","Nombre")


end event

event ue_listar;long total
total = apartados.pagina1.dw_1.rowcount()
if total > 0 then
	apartados.pagina1.dw_1.rowscopy(1,total,Primary!,dw_listado4,1,Primary!)
	
	dw_report=dw_listado4
	CALL Super:: ue_listar
end if


end event

on w_consulta_reclamaciones.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado4=create dw_listado4
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.cb_paises=create cb_paises
this.cb_provincias=create cb_provincias
this.uo_provincias=create uo_provincias
this.cb_2=create cb_2
this.uo_agentes=create uo_agentes
this.em_top=create em_top
this.dw_grafico_agentes=create dw_grafico_agentes
this.dw_grafico_sectores=create dw_grafico_sectores
this.uo_paises=create uo_paises
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.gb_3=create gb_3
this.apartados=create apartados
this.cb_3=create cb_3
this.cb_4=create cb_4
this.uo_motivos=create uo_motivos
this.uo_causas=create uo_causas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.cb_paises
this.Control[iCurrent+6]=this.cb_provincias
this.Control[iCurrent+7]=this.uo_provincias
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.uo_agentes
this.Control[iCurrent+10]=this.em_top
this.Control[iCurrent+11]=this.dw_grafico_agentes
this.Control[iCurrent+12]=this.dw_grafico_sectores
this.Control[iCurrent+13]=this.uo_paises
this.Control[iCurrent+14]=this.em_fechadesde
this.Control[iCurrent+15]=this.em_fechahasta
this.Control[iCurrent+16]=this.uo_cliente
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.apartados
this.Control[iCurrent+20]=this.cb_3
this.Control[iCurrent+21]=this.cb_4
this.Control[iCurrent+22]=this.uo_motivos
this.Control[iCurrent+23]=this.uo_causas
this.Control[iCurrent+24]=this.gb_1
end on

on w_consulta_reclamaciones.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.dw_listado4)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.cb_paises)
destroy(this.cb_provincias)
destroy(this.uo_provincias)
destroy(this.cb_2)
destroy(this.uo_agentes)
destroy(this.em_top)
destroy(this.dw_grafico_agentes)
destroy(this.dw_grafico_sectores)
destroy(this.uo_paises)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.apartados)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.uo_motivos)
destroy(this.uo_causas)
destroy(this.gb_1)
end on

event ue_f5;call super::ue_f5;cb_1.triggerevent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_consulta_reclamaciones
integer x = 1280
integer y = 1056
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_consulta_reclamaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_consulta_reclamaciones
integer width = 2990
end type

type pb_1 from upb_salir within w_consulta_reclamaciones
integer x = 3502
integer y = 4
integer width = 128
integer height = 116
integer taborder = 180
end type

type dw_listado4 from datawindow within w_consulta_reclamaciones
boolean visible = false
integer x = 722
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_reclamaciones"
boolean livescroll = true
end type

type cb_1 from u_boton within w_consulta_reclamaciones
integer x = 3150
integer y = 288
integer width = 325
integer height = 124
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;call super::clicked;f_carga_in()



end event

type pb_imprimir from upb_imprimir within w_consulta_reclamaciones
integer x = 3479
integer y = 288
integer width = 142
integer height = 124
integer taborder = 160
boolean bringtotop = true
boolean originalsize = false
string picturename = "\bmp\IMP32.BMP"
string disabledname = "\bmp\IMP32_no.BMP"
end type

event clicked;call super::clicked;w_consulta_reclamaciones.triggerevent("ue_listar")

end event

type cb_paises from commandbutton within w_consulta_reclamaciones
integer x = 14
integer y = 300
integer width = 366
integer height = 96
integer taborder = 30
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
uo_agentes.visible    = false
uo_motivos.visible    = false
uo_causas.visible     = false

end event

type cb_provincias from commandbutton within w_consulta_reclamaciones
integer x = 384
integer y = 300
integer width = 366
integer height = 96
integer taborder = 40
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
uo_agentes.visible    = false
uo_motivos.visible    = false
uo_causas.visible     = false

end event

type uo_provincias from u_marca_lista_3 within w_consulta_reclamaciones
boolean visible = false
integer x = 384
integer y = 400
integer height = 664
integer taborder = 250
boolean bringtotop = true
end type

on uo_provincias.destroy
call u_marca_lista_3::destroy
end on

event itemchanged;//Cargamos los articulos de los paises seleccionados
DataStore postales,provincias
String    sel,codigo_postal,nombre_postal,marca,nombre_provincia
string    codigo_pais,nombre_pais,pais_provincia,codigo_provincia,ls_codigo_provincia
long      indice,total,donde

//
if data = "S" then
	
		codigo_provincia = uo_provincias.dw_marca.object.codigo[row]
		nombre_provincia=uo_provincias.dw_marca.object.texto[row]
		ls_codigo_provincia = f_get_token_der(codigo_provincia,"/")
		nombre_provincia= f_get_token_der(nombre_provincia,")")
		codigo_pais=  f_get_token(codigo_provincia,"/")
		// Sacamos los codigos postales de cada provincia
		sel = "Select  codpostal,ciudad "+&
			"from codpostales where pais = '"+codigo_pais+"'"+&
			"and provincia='"+ls_codigo_provincia+"'"
			f_cargar_cursor_transaccion(sqlca,postales,sel)
			total      = postales.rowcount()
			//Cargamos los codigos postales
			for indice =1 to total
				codigo_postal = postales.object.codpostal[indice]
				nombre_postal= postales.object.ciudad[indice]
				codigo_postal = codigo_pais+"/"+ls_codigo_provincia+"/"+codigo_postal
				nombre_postal = "("+nombre_provincia+") "+nombre_postal
//				donde = uo_postales.dw_marca.find("codigo = '"+codigo_postal+"'",1,uo_postales.dw_marca.rowcount())
//				if donde = 0 or isnull(donde) then
//					marca = "S"			
//					donde = uo_postales.dw_marca.InsertRow(0)
//					uo_postales.dw_marca.object.marca[donde]  = marca
//					uo_postales.dw_marca.object.codigo[donde] = codigo_postal
//					uo_postales.dw_marca.object.texto[donde]  = nombre_postal
//				end if	
//				
			next // postales
			
//			uo_postales.dw_marca.setsort("texto")
//			uo_postales.dw_marca.sort()
//	
//			uo_postales.st_titulo1.text = "Codigo"
//			uo_postales.st_titulo2.text = "Provincia/Localidad"		
	
		
else
		codigo_provincia = uo_provincias.dw_marca.object.codigo[row]
		ls_codigo_provincia = f_get_token_der(codigo_provincia,"/")
		codigo_pais=  f_get_token(codigo_provincia,"/")
		
		
		//  Para postales
		sel = "Select  codpostal,ciudad "+&
			"from codpostales where pais = '"+codigo_pais+"'"+&
			"and provincia='"+ls_codigo_provincia+"'"
			f_cargar_cursor_transaccion(sqlca,postales,sel)
			total      = postales.rowcount()
			for indice =1 to total
				codigo_postal = postales.object.codpostal[indice]
				codigo_postal = codigo_pais + "/" +ls_codigo_provincia+"/"+codigo_postal

//				donde = uo_postales.dw_marca.find("codigo = '"+codigo_postal+"'",1,uo_postales.dw_marca.rowcount())
//				if donde <> 0 then
//					uo_postales.dw_marca.deleterow(donde)
//				end if
			next
			
//				uo_postales.dw_marca.setsort("texto")
//				uo_postales.dw_marca.sort()
//	
//				uo_postales.st_titulo1.text = "Codigo"
//				uo_postales.st_titulo2.text = "Provincia/Localidad"		
		
	
	
//	codigo_pais = uo_paises.dw_marca.object.codigo[row]
//	nombre_pais = f_nombre_pais(codigo_pais)
//	
//	sel = "Select  provincia,nombre "+&
//			"from provincias where pais = '"+codigo_pais+"'"
//			
//	f_cargar_cursor_transaccion(sqlca,provincias,sel)
//	total      = provincias.rowcount()
//
//	for indice = 1 To total				
//		codigo_provincia = provincias.object.provincia[indice]
//		codigo_provincia = codigo_pais+"/"+codigo_provincia
//
//		donde = uo_provincias.dw_marca.find("codigo = '"+codigo_provincia+"'",1,uo_provincias.dw_marca.rowcount())
//		if donde <> 0 then
//			uo_provincias.dw_marca.deleterow(donde)
//		end if
//	next
//
//	uo_provincias.dw_marca.setsort("texto")
//	uo_provincias.dw_marca.sort()
//	
//	uo_provincias.st_titulo1.text = "Codigo"
//	uo_provincias.st_titulo2.text = "Pais/Provincia"			
end if
destroy postales
end event

type cb_2 from commandbutton within w_consulta_reclamaciones
integer x = 754
integer y = 300
integer width = 366
integer height = 96
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agentes"
end type

event clicked;
uo_agentes.visible     = not(uo_agentes.visible)
uo_provincias.visible  = false
uo_paises.visible      = false
uo_motivos.visible     = false
uo_causas.visible      = false
end event

type uo_agentes from u_marca_lista_3 within w_consulta_reclamaciones
boolean visible = false
integer x = 754
integer y = 400
integer height = 664
integer taborder = 170
boolean bringtotop = true
end type

on uo_agentes.destroy
call u_marca_lista_3::destroy
end on

type em_top from u_em_campo within w_consulta_reclamaciones
boolean visible = false
integer x = 2158
integer y = 328
integer width = 137
integer height = 76
integer taborder = 200
boolean bringtotop = true
end type

type dw_grafico_agentes from datawindow within w_consulta_reclamaciones
boolean visible = false
integer x = 2693
integer y = 20
integer width = 160
integer height = 72
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_est_crm_agentes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_grafico_sectores from datawindow within w_consulta_reclamaciones
boolean visible = false
integer x = 2496
integer y = 16
integer width = 137
integer height = 76
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_est_crm_sectores"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_paises from u_marca_lista_3 within w_consulta_reclamaciones
boolean visible = false
integer x = 14
integer y = 400
integer height = 664
integer taborder = 240
end type

on uo_paises.destroy
call u_marca_lista_3::destroy
end on

event itemchanged;//Cargamos los articulos de los paises seleccionados
DataStore provincias,postales
String    sel,codigo_provincia,nombre_provincia,marca
string    codigo_pais,nombre_pais,pais_provincia
string   codigo_postal,nombre_postal
long      indice,total,donde,total_pos,i


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
			//marca = "S"			
			donde = uo_provincias.dw_marca.InsertRow(0)
			uo_provincias.dw_marca.object.marca[donde]  = marca
			uo_provincias.dw_marca.object.codigo[donde] = codigo_provincia
			uo_provincias.dw_marca.object.texto[donde]  = nombre_provincia
		end if
//		// Sacamos los codigos postales de cada provincia
//		sel = "Select  codpostal,ciudad "+&
//			"from codpostales where pais = '"+codigo_pais+"'"+&
//			"and provincia='"+provincias.object.provincia[indice]+"'"
//			f_cargar_cursor_transaccion(sqlca,postales,sel)
//			total_pos      = postales.rowcount()
//			//Cargamos los codigos postales
//			for i =1 to total_pos
//				codigo_postal = postales.object.codpostal[i]
//				nombre_postal= postales.object.ciudad[i]
//				codigo_postal = codigo_provincia+"/"+codigo_postal
//				nombre_postal = "("+provincias.object.nombre[indice]+") "+nombre_postal
//				donde = uo_postales.dw_marca.find("codigo = '"+codigo_postal+"'",1,uo_postales.dw_marca.rowcount())
//		if donde = 0 or isnull(donde) then
//			marca = "S"			
//			donde = uo_postales.dw_marca.InsertRow(0)
//			uo_postales.dw_marca.object.marca[donde]  = marca
//			uo_postales.dw_marca.object.codigo[donde] = codigo_postal
//			uo_postales.dw_marca.object.texto[donde]  = nombre_postal
//		end if	
				
			//next // postales
			
//			uo_postales.dw_marca.setsort("texto")
//			uo_postales.dw_marca.sort()
//	
//			uo_postales.st_titulo1.text = "Codigo"
//			uo_postales.st_titulo2.text = "Provincia/Localidad"		
			
	next// provincias

	uo_provincias.dw_marca.setsort("texto")
	uo_provincias.dw_marca.sort()
	
	uo_provincias.st_titulo1.text = "Codigo"
	uo_provincias.st_titulo2.text = "Pais/Provincia"		
else
	
	// Desmarcar y borrar los que no están marcados
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
//		
//		//  Para postales
//		sel = "Select  codpostal,ciudad "+&
//			"from codpostales where pais = '"+codigo_pais+"'"+&
//			"and provincia='"+provincias.object.provincia[indice]+"'"
//			f_cargar_cursor_transaccion(sqlca,postales,sel)
//			total_pos      = postales.rowcount()
//			for i =1 to total_pos
//				codigo_postal = postales.object.codpostal[i]
//				codigo_postal = codigo_provincia+"/"+codigo_postal
//
//				donde = uo_postales.dw_marca.find("codigo = '"+codigo_postal+"'",1,uo_postales.dw_marca.rowcount())
//				if donde <> 0 then
//					uo_postales.dw_marca.deleterow(donde)
//				end if
//			next
//			
//				uo_postales.dw_marca.setsort("texto")
//				uo_postales.dw_marca.sort()
//	
//				uo_postales.st_titulo1.text = "Codigo"
//				uo_postales.st_titulo2.text = "Provincia/Localidad"		
//		
	next
//
	uo_provincias.dw_marca.setsort("texto")
	uo_provincias.dw_marca.sort()
	
	uo_provincias.st_titulo1.text = "Codigo"
	uo_provincias.st_titulo2.text = "Pais/Provincia"			
end if
destroy provincias
//destroy postales
//event destructor( )
end event

type em_fechadesde from u_em_campo within w_consulta_reclamaciones
integer x = 27
integer y = 152
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_consulta_reclamaciones
integer x = 370
integer y = 152
integer width = 320
integer taborder = 40
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type uo_cliente from u_em_campo_2 within w_consulta_reclamaciones
event destroy ( )
integer x = 727
integer y = 152
integer width = 1275
integer taborder = 50
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	cb_2.enabled = true
	Return
end if 

end event

event getfocus;call super::getfocus;
ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_2 from groupbox within w_consulta_reclamaciones
integer x = 5
integer y = 92
integer width = 699
integer height = 160
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo"
end type

type gb_3 from groupbox within w_consulta_reclamaciones
integer x = 704
integer y = 92
integer width = 1312
integer height = 160
integer taborder = 50
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

type apartados from tab within w_consulta_reclamaciones
event create ( )
event destroy ( )
integer y = 420
integer width = 3625
integer height = 1512
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
pagina1 pagina1
pagina2 pagina2
pagina3 pagina3
pagina4 pagina4
pagina5 pagina5
pagina6 pagina6
end type

on apartados.create
this.pagina1=create pagina1
this.pagina2=create pagina2
this.pagina3=create pagina3
this.pagina4=create pagina4
this.pagina5=create pagina5
this.pagina6=create pagina6
this.Control[]={this.pagina1,&
this.pagina2,&
this.pagina3,&
this.pagina4,&
this.pagina5,&
this.pagina6}
end on

on apartados.destroy
destroy(this.pagina1)
destroy(this.pagina2)
destroy(this.pagina3)
destroy(this.pagina4)
destroy(this.pagina5)
destroy(this.pagina6)
end on

event selectionchanged;long inicio_grupo,grupo,total_lineas,inicio_grupo_ant,indice
string fdesde,fhasta
fdesde=em_fechadesde.text	
fhasta=em_fechahasta.text
		
choose case newindex
	case 1
		apartados.pagina1.dw_1.setredraw(false)
		apartados.pagina1.dw_1.setsort(sort_tp[1])
		apartados.pagina1.dw_1.sort()
		apartados.pagina1.dw_1.groupcalc()
		
		if numerar_tp[1] and not numerado_tp[1] then
			numerado_tp[1] = true
			total_lineas = apartados.pagina1.dw_1.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = apartados.pagina1.dw_1.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					apartados.pagina1.dw_1.object.contador_ranking1[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
								
		apartados.pagina1.dw_1.setredraw(true)
	case 2
		apartados.pagina2.dw_2.setredraw(false)
		apartados.pagina2.dw_2.setsort(sort_tp[2])
		apartados.pagina2.dw_2.sort()
		apartados.pagina2.dw_2.groupcalc()
		
		if numerar_tp[2] and not numerado_tp[2] then
			numerado_tp[2] = true
			total_lineas = apartados.pagina2.dw_2.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = apartados.pagina2.dw_2.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					apartados.pagina2.dw_2.object.contador_ranking2[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
						
		apartados.pagina2.dw_2.setredraw(true)
		
	case 3
		apartados.pagina3.dw_3.setredraw(false)
		apartados.pagina3.dw_3.setsort(sort_tp[3])
		apartados.pagina3.dw_3.sort()
		apartados.pagina3.dw_3.groupcalc()
		
		if numerar_tp[3] and not numerado_tp[3] then
			numerado_tp[3] = true
			total_lineas = apartados.pagina3.dw_3.rowcount()
			inicio_grupo = 0
			grupo = 0
			do
				inicio_grupo = apartados.pagina3.dw_3.findgroupchange(inicio_grupo,1)
				
				if inicio_grupo > 0 then
					grupo ++
					apartados.pagina3.dw_3.object.contador_ranking3[inicio_grupo] = grupo
					inicio_grupo ++
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
				
		apartados.pagina3.dw_3.setredraw(true)
	case 4
		//
		apartados.pagina4.dw_4.setredraw(false)	
		
		apartados.pagina4.dw_4.setsort("pais A, codigo_pais A, provincia A, codigo_provincia A, agente A, codigo_agente A, cliente A, codigo_cliente A, familia A, codigo_familia A, formato A, codigo_formato A, articulo A, codigo_articulo A")
		apartados.pagina4.dw_4.sort()
		apartados.pagina4.dw_4.groupcalc()
		
		apartados.pagina4.dw_4.setsort("importe_pais D, pais A, codigo_pais A, importe_provincia D, provincia A, codigo_provincia A, importe_agente D, agente A, codigo_agente A, importe_cliente D, cliente A, codigo_cliente A, familia A, codigo_familia A, formato A, codigo_formato A, articulo A, codigo_articulo A")
		apartados.pagina4.dw_4.sort()
		
		if numerar_tp[4] and not numerado_tp[4] then
			numerado_tp[4] = true
			total_lineas = apartados.pagina4.dw_4.rowcount()
			inicio_grupo     = 0
			inicio_grupo_ant = 1
			grupo = 0
			do
				inicio_grupo = apartados.pagina4.dw_4.findgroupchange(inicio_grupo,1)								
				
				if inicio_grupo > 0 then
					grupo ++
					if grupo > 1 then
						for indice = inicio_grupo_ant to inicio_grupo
							apartados.pagina4.dw_4.object.contador_ranking4[indice] = grupo
						next
					end if					
					inicio_grupo ++
					inicio_grupo_ant = inicio_grupo
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		apartados.pagina4.dw_4.setredraw(true)				
	case 5
		//
		apartados.pagina5.dw_5.setredraw(false)	
		
		apartados.pagina5.dw_5.setsort("cliente A, codigo_cliente A, familia A, codigo_familia A, formato A, codigo_formato A, articulo A, codigo_articulo A")
		apartados.pagina5.dw_5.sort()
		apartados.pagina5.dw_5.groupcalc()
		
		apartados.pagina5.dw_5.setsort("importe_cliente D, cliente A, codigo_cliente A, importe_familia D, familia A, codigo_familia A, importe_formato D, formato A, codigo_formato A, importe_articulo D, articulo A, codigo_articulo A")
		apartados.pagina5.dw_5.sort()
		
		if numerar_tp[5] and not numerado_tp[5] then
			numerado_tp[5] = true
			total_lineas = apartados.pagina5.dw_5.rowcount()
			inicio_grupo     = 0
			inicio_grupo_ant = 1
			grupo = 0
			do
				inicio_grupo = apartados.pagina5.dw_5.findgroupchange(inicio_grupo,1)								
				
				if inicio_grupo > 0 then
					grupo ++
					if grupo > 1 then
						for indice = inicio_grupo_ant to inicio_grupo
							apartados.pagina5.dw_5.object.contador_ranking5[indice] = grupo
						next
					end if					
					inicio_grupo ++
					inicio_grupo_ant = inicio_grupo
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		apartados.pagina5.dw_5.setredraw(true)				
	case 6
		apartados.pagina6.dw_6.setredraw(false)	
		
		apartados.pagina6.dw_6.setsort("familia A, codigo_familia A, formato A, codigo_formato A, articulo A, codigo_articulo A, calidad A, codigo_calidad A")
		apartados.pagina6.dw_6.sort()
		apartados.pagina6.dw_6.groupcalc()
		
		apartados.pagina6.dw_6.setsort("importe_familia D, familia A, codigo_familia A, importe_formato D, formato A, codigo_formato A, importe_articulo D, articulo A, codigo_articulo A, calidad A, codigo_calidad A")
		//apartados.pagina6.dw_6.setsort("sum( importe for group 1) D, familia A, codigo_familia A, importe_formato D, formato A, codigo_formato A, importe_articulo D, articulo A, codigo_articulo A, calidad A, codigo_calidad A")
		
		apartados.pagina6.dw_6.sort()
						
//		apartados.pagina6.dw_6.groupcalc()
//		apartados.pagina6.dw_6.setsort(sort_tp[6])
//		apartados.pagina6.dw_6.sort()
//		apartados.pagina6.dw_6.groupcalc()
//		apartados.pagina6.dw_6.sort()		
		//MESSAGEBOX("",sort_tp[6])
		
		if numerar_tp[6] and not numerado_tp[6] then
			numerado_tp[6] = true
			total_lineas = apartados.pagina6.dw_6.rowcount()
			inicio_grupo     = 0
			inicio_grupo_ant = 1
			grupo = 0
			do
				inicio_grupo = apartados.pagina6.dw_6.findgroupchange(inicio_grupo,1)								
				
				if inicio_grupo > 0 then
					grupo ++
					if grupo > 1 then
						for indice = inicio_grupo_ant to inicio_grupo
							apartados.pagina6.dw_6.object.contador_ranking6[indice] = grupo
						next
					end if					
					inicio_grupo ++
					inicio_grupo_ant = inicio_grupo
				end if
			loop while inicio_grupo > 0 and inicio_grupo < total_lineas
		end if
		
		apartados.pagina6.dw_6.setredraw(true)					
end choose
end event

type pagina1 from userobject within apartados
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Cliente/Motivo/Causa"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on pagina1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on pagina1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_datawindow_consultas within pagina1
integer width = 3589
integer height = 1388
integer taborder = 21
string dataobject = "dw_consulta_reclamaciones1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type pagina2 from userobject within apartados
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Agente/Motivo/Causa"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on pagina2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on pagina2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_datawindow_consultas within pagina2
integer width = 3589
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_reclamaciones2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type pagina3 from userobject within apartados
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Motivo/Causa/Cliente"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on pagina3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on pagina3.destroy
destroy(this.dw_3)
end on

type dw_3 from u_datawindow_consultas within pagina3
integer width = 3589
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_reclamaciones3"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type pagina4 from userobject within apartados
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Responsable"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on pagina4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on pagina4.destroy
destroy(this.dw_4)
end on

type dw_4 from u_datawindow_consultas within pagina4
integer width = 3589
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_reclamaciones4"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type pagina5 from userobject within apartados
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Motivo/Causa/Origen"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on pagina5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on pagina5.destroy
destroy(this.dw_5)
end on

type dw_5 from u_datawindow_consultas within pagina5
integer width = 3589
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_reclamaciones5"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type pagina6 from userobject within apartados
integer x = 18
integer y = 104
integer width = 3589
integer height = 1392
long backcolor = 12632256
string text = "Sin definir"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on pagina6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on pagina6.destroy
destroy(this.dw_6)
end on

type dw_6 from u_datawindow_consultas within pagina6
integer width = 3589
integer height = 1388
integer taborder = 10
string dataobject = "dw_consulta_reclamaciones6"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

event sqlpreview;call super::sqlpreview;//messagebox("s", sqlsyntax)
end event

type cb_3 from commandbutton within w_consulta_reclamaciones
integer x = 1125
integer y = 300
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Motivos"
end type

event clicked;uo_agentes.visible    = false
uo_provincias.visible = false
uo_paises.visible     = false
uo_motivos.visible    = not(uo_motivos.visible)
uo_causas.visible     = false
end event

type cb_4 from commandbutton within w_consulta_reclamaciones
integer x = 1495
integer y = 300
integer width = 366
integer height = 96
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Causas"
end type

event clicked;uo_agentes.visible    = false
uo_provincias.visible = false
uo_paises.visible     = false
uo_motivos.visible    = false
uo_causas.visible     = not(uo_causas.visible)

end event

type uo_motivos from u_marca_lista_3 within w_consulta_reclamaciones
boolean visible = false
integer x = 1125
integer y = 400
integer height = 664
integer taborder = 260
boolean bringtotop = true
end type

on uo_motivos.destroy
call u_marca_lista_3::destroy
end on

type uo_causas from u_marca_lista_3 within w_consulta_reclamaciones
boolean visible = false
integer x = 1495
integer y = 400
integer height = 664
integer taborder = 180
boolean bringtotop = true
end type

on uo_causas.destroy
call u_marca_lista_3::destroy
end on

type gb_1 from groupbox within w_consulta_reclamaciones
integer y = 248
integer width = 2016
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Clasificación"
end type

