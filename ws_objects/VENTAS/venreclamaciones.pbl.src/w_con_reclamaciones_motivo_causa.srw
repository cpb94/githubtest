$PBExportHeader$w_con_reclamaciones_motivo_causa.srw
forward
global type w_con_reclamaciones_motivo_causa from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_reclamaciones_motivo_causa
end type
type pb_2 from upb_imprimir within w_con_reclamaciones_motivo_causa
end type
type dw_listado from datawindow within w_con_reclamaciones_motivo_causa
end type
type em_fechadesde from u_em_campo within w_con_reclamaciones_motivo_causa
end type
type em_fechahasta from u_em_campo within w_con_reclamaciones_motivo_causa
end type
type gb_1 from groupbox within w_con_reclamaciones_motivo_causa
end type
type cb_1 from commandbutton within w_con_reclamaciones_motivo_causa
end type
type uo_cliente from u_em_campo_2 within w_con_reclamaciones_motivo_causa
end type
type gb_2 from groupbox within w_con_reclamaciones_motivo_causa
end type
type cbx_mostrar_texto from checkbox within w_con_reclamaciones_motivo_causa
end type
type dw_detalle from datawindow within w_con_reclamaciones_motivo_causa
end type
type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_motivo_causa
end type
type cb_paises from commandbutton within w_con_reclamaciones_motivo_causa
end type
type uo_paises from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
end type
type cb_provincias from commandbutton within w_con_reclamaciones_motivo_causa
end type
type uo_provincias from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
end type
type cb_2 from commandbutton within w_con_reclamaciones_motivo_causa
end type
type uo_agentes from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
end type
type cb_3 from commandbutton within w_con_reclamaciones_motivo_causa
end type
type cb_4 from commandbutton within w_con_reclamaciones_motivo_causa
end type
type uo_causas from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
end type
type uo_motivos from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
end type
type cb_excel from commandbutton within w_con_reclamaciones_motivo_causa
end type
type dw_excel from datawindow within w_con_reclamaciones_motivo_causa
end type
end forward

global type w_con_reclamaciones_motivo_causa from w_int_con_empresa
integer width = 4361
integer height = 2704
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
uo_cliente uo_cliente
gb_2 gb_2
cbx_mostrar_texto cbx_mostrar_texto
dw_detalle dw_detalle
uo_manejo uo_manejo
cb_paises cb_paises
uo_paises uo_paises
cb_provincias cb_provincias
uo_provincias uo_provincias
cb_2 cb_2
uo_agentes uo_agentes
cb_3 cb_3
cb_4 cb_4
uo_causas uo_causas
uo_motivos uo_motivos
cb_excel cb_excel
dw_excel dw_excel
end type
global w_con_reclamaciones_motivo_causa w_con_reclamaciones_motivo_causa

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_carga_in (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string    v_reclamacion,v_moneda,v_nombre_moneda,v_mascara_moneda_divisa
string    sel, v_cliente, v_nombre_cliente, v_descripcion, v_texto
datetime  v_fecha_desde,v_fecha_hasta, v_ffactura_abono
long      indice,v_total,v_anyo_abono,v_factura_abono,  donde
decimal   v_importe_fra_proveedor,v_total_fra_pts
long    total,indice2,opciones,opciones_marcadas,opciones_marcadas_no
string  filtrocliente,texto_seleccion_cliente,pais,descripcion,filtropaises,texto_seleccion_en,texto_seleccion_final
string  pais_anterior,codigo,provincia,agente,filtroagentes,filtroagentes_no,texto_seleccion_no_en,texto_seleccion_agente
string  caracter,agentes,provincias,motivo,filtromotivos,filtromotivos_no,texto_seleccion_motivo
string  causa,filtrocausas,filtrocausas_no,texto_seleccion_causa,ls_sel
boolean extrayendo_pais,extrayendo_provincia
datetime f_desde,f_hasta

DataStore datos
data.reset()
data.SetRedraw(FALSE)

v_moneda                = f_moneda_empresa(codigo_empresa)
v_nombre_moneda         = f_nombre_moneda_abr(v_moneda)
v_mascara_moneda_divisa = f_mascara_moneda(v_moneda)


v_cliente        = uo_cliente.em_codigo.text

f_desde    = DateTime(Date(em_fechadesde.text))
f_hasta    = DateTime(Date(em_fechahasta.text))
//
if uo_cliente.em_codigo.text <> "" then
	filtrocliente = " and ven_reclamaciones.cliente = '"+uo_cliente.em_codigo.text+"' "
	texto_seleccion_cliente = "CLIENTE : "+uo_cliente.em_campo.text+" ~n"
else
	texto_seleccion_cliente = ""
	filtrocliente = ""
end if
//
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

//if trim(v_cliente) = "" then
//	v_cliente = "%"
//end if

//if cbx_mostrar_texto.checked then
//	sel = " select cliente,reclamacion,fecha,descripcion,texto"+&
//			" from   ven_reclamaciones "+&
//			" where  empresa =       '"+codigo_empresa+"' " +&
//			" and    cliente like    '"+v_cliente+"' " +&
//			" and    fecha   between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"' "
//else
//	sel = " select cliente,reclamacion,fecha,descripcion,'' texto"+&
//			" from   ven_reclamaciones "+&
//			" where  empresa =       '"+codigo_empresa+"' " +&
//			" and    cliente like    '"+v_cliente+"' " +&
//			" and    fecha   between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"' "	
//end if

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

f_cargar_cursor_transaccion(sqlca,datos,ls_sel)

v_total = datos.rowcount()				
For indice = 1 To v_total
		
	
	
	donde = data.InsertRow(0)
	data.object.empresa[donde]        	 = codigo_empresa	
	data.object.cliente[donde] 			 = datos.object.ven_reclamaciones_cliente[indice]
	data.object.nombre_cliente[donde] 	 = datos.object.genter_razon[indice]
	data.object.reclamacion[donde]     	 = datos.object.ven_reclamaciones_reclamacion[indice]
	data.object.nombre_reclamacion[donde]= datos.object.ven_reclamaciones_descripcion[indice]
	data.object.fecha_reclamacion[donde] = datos.object.ven_reclamaciones_fecha[indice]
	data.object.motivo[donde] 			    = datos.object.ven_reclamaciones_codigo_ven_reclamaciones_tipos[indice]
	data.object.nombre_motivo[donde]	    = datos.object.ven_reclamaciones_tipos_descripcion[indice]
	data.object.situacion[donde]   		 = datos.object.ven_reclamaciones_codigo_ven_reclamaciones_situa[indice]
	data.object.nombre_situacion[donde]  = datos.object.ven_reclamaciones_situaciones_descripcion[indice]
	data.object.causa[donde]   			 = datos.object.ven_reclamaciones_codigo_ven_reclamaciones_causa[indice]
	data.object.nombre_causa[donde]		 = datos.object.ven_reclamaciones_causas_descripcion[indice]
	data.object.cerrada[donde]				 =	datos.object.ven_reclamaciones_cerrada[indice]
	data.object.responsable[donde]		 =	datos.object.ven_reclamaciones_ven_reclamaciones_respo_codigo[indice]
	data.object.nombre_responsable[donde]=	datos.object.ven_reclamaciones_responsables_descripcion[indice]
	data.object.agente[donde]				 =	datos.object.venclientes_agente1[indice]
	data.object.nombre_agente[donde]		 =	datos.object.venagentes_nombre[indice]
	data.object.contacto[donde]			 =	datos.object.ven_reclamaciones_telefonos_codigo[indice]
	data.object.nombre_contacto[donde]	 =	datos.object.telefonos_contacto[indice]
	
	
	f_mensaje_proceso("Leyendo Reclamaciones",indice,datos.RowCount())	
Next

destroy datos
data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)
end subroutine

public subroutine f_carga_in (datawindow data);//long    indice,total,indice2,donde,opciones,opciones_marcadas,opciones_marcadas_no
//string  filtrocliente,texto_seleccion_cliente,pais,descripcion,filtropaises,texto_seleccion_en,texto_seleccion_final
//string  pais_anterior,codigo,provincia,agente,filtroagentes,filtroagentes_no,texto_seleccion_no_en,texto_seleccion_agente
//string  caracter,agentes,provincias,motivo,filtromotivos,filtromotivos_no,texto_seleccion_motivo
//string  causa,filtrocausas,filtrocausas_no,texto_seleccion_causa,ls_sel
//boolean extrayendo_pais,extrayendo_provincia
//datetime f_desde,f_hasta
//
//string codigo_cliente,ls_cliente,ls_filtro_cliente,codigo_agente,codigo_articulo,articulo,codigo_calidad
//string codigo_motivo,codigo_causa,codigo_pais,codigo_provincia
//string codigo_unidad,unidad,mascara_unidad,moneda,mascara_moneda
//dec    importe,cantidad
//
//datastore ds_datos
//
//if dw_principal[1]  then
//	apartados.pagina1.dw_1.reset()
//end if
//if dw_principal[2]  then
//	apartados.pagina2.dw_2.reset()
//end if
//if dw_principal[3]  then
//	apartados.pagina3.dw_3.reset()
//end if
//if dw_principal[4]  then
//	apartados.pagina4.dw_4.reset()
//end if
//if dw_principal[5]  then
//	apartados.pagina5.dw_5.reset()
//end if
//if dw_principal[6]  then
//	apartados.pagina6.dw_6.reset()
//end if				
//
//apartados.pagina1.dw_1.setredraw(false)
//apartados.pagina2.dw_2.setredraw(false)
//apartados.pagina3.dw_3.setredraw(false)
//apartados.pagina4.dw_4.setredraw(false)
//apartados.pagina5.dw_5.setredraw(false)
//apartados.pagina6.dw_6.setredraw(false)
//
////
//f_desde    = DateTime(Date(em_fechadesde.text))
//f_hasta    = DateTime(Date(em_fechahasta.text))
//
//if uo_cliente.em_codigo.text <> "" then
//	filtrocliente = " and ven_reclamaciones.cliente = '"+uo_cliente.em_codigo.text+"' "
//	texto_seleccion_cliente = "CLIENTE : "+uo_cliente.em_campo.text+" ~n"
//else
//	texto_seleccion_cliente = ""
//	filtrocliente = ""
//end if
//
//if filtrocliente = "" then
//	total = uo_paises.dw_marca.RowCount()
//	
//	opciones = total
//	opciones_marcadas = 0
//	
//	for indice = 1 to total
//		IF uo_paises.dw_marca.GetItemString(indice,"marca") = "S" THEN
//			
//			opciones_marcadas ++
//			pais        = uo_paises.dw_marca.GetItemString(indice,"codigo")
//			descripcion = uo_paises.dw_marca.object.texto[indice]
//			
//			if filtropaises = "" then
//				filtropaises = "(genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
//				texto_seleccion_en = descripcion
//			else
//				filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and (genter.provincia = '' or genter.provincia = null)) "
//				texto_seleccion_en = texto_seleccion_en + ";"+descripcion
//			end if
//		end if
//	next
//	
//	if opciones_marcadas = opciones or opciones_marcadas = 0 then
//		texto_seleccion_final = "TODOS LOS PAISES~n"
//	else
//		texto_seleccion_final = "PAISES : "+texto_seleccion_en + "~n"
//	end if
//	
//	total = uo_provincias.dw_marca.RowCount()
//	opciones = opciones + total
//	
//	IF total >0 Then
//		
//		pais_anterior = ""		
//		FOR indice = 1 To total
//			IF uo_provincias.dw_marca.GetItemString(indice,"marca") = "S" THEN
//				opciones_marcadas ++
//				codigo = uo_provincias.dw_marca.GetItemString(indice,"codigo")
//				extrayendo_pais = true			
//				pais = ""
//				provincia = ""
//				for indice2 = 1 to len(codigo)
//					caracter = mid(codigo,indice2,1)
//					if caracter <> "/" then
//						if extrayendo_pais then
//							pais = pais + caracter
//						else
//							provincia = provincia + caracter
//						end if
//					else
//						extrayendo_pais = false			
//					end if
//				next
//				if pais <> pais_anterior then
//					If pais_anterior = "" then
//						texto_seleccion_en = texto_seleccion_en + "PROVINCIAS : "
//					else
//						texto_seleccion_en = texto_seleccion_en + ")~n"
//					end if
//					pais_anterior = pais
//					texto_seleccion_en =  texto_seleccion_en + f_nombre_pais(pais) + "("
//				end if
//								
//				if filtropaises = "" then
//					filtropaises = "(genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
//					texto_seleccion_en =  texto_seleccion_en + f_nombre_provincia(pais,provincia)
//				else
//					filtropaises = filtropaises + "or (genter.pais = '"+pais+"' and genter.provincia = '"+provincia+"') "
//					texto_seleccion_en =  texto_seleccion_en + ";" + f_nombre_provincia(pais,provincia)
//				end if
//			end if
//		next
//	end if
//	
//	if opciones_marcadas = opciones or opciones_marcadas = 0 then
//		filtropaises = ""
//		texto_seleccion_final = "TODOS LOS PAISES Y PROVINCIAS"
//	else
//		if trim(filtropaises) <> "" then
//			filtropaises = "and ("+filtropaises+") "
//			texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_en
//		end if		
//	end if	
//
//	total = uo_agentes.dw_marca.RowCount()
//	
//	opciones = total
//	opciones_marcadas = 0
//	opciones_marcadas_no = 0
//	
//	for indice = 1 to total
//		IF uo_agentes.dw_marca.GetItemString(indice,"marca") = "S" THEN
//			opciones_marcadas ++
//			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
//			if filtroagentes = "" then
//				filtroagentes = "'"+agente+"'"
//				texto_seleccion_en = uo_agentes.dw_marca.object.texto[indice]
//			else
//				filtroagentes = filtroagentes + ",'"+agente+"'"
//				texto_seleccion_en = texto_seleccion_en+";"+uo_agentes.dw_marca.object.texto[indice]
//			end if
//		else
//			opciones_marcadas_no ++
//			agente = uo_agentes.dw_marca.GetItemString(indice,"codigo")
//			if filtroagentes_no = "" then
//				filtroagentes_no = "'"+agente+"'"
//				texto_seleccion_no_en = uo_agentes.dw_marca.object.texto[indice]
//			else
//				filtroagentes_no = filtroagentes_no + ",'"+agente+"'"
//				texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_agentes.dw_marca.object.texto[indice]
//			end if		
//		end if
//	next
//	
//	if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
//		if opciones_marcadas <= opciones_marcadas_no then
//			if trim(filtroagentes) <> "" then
//				filtroagentes = "and venclientes.agente1 in ("+filtroagentes+") "
//				texto_seleccion_agente = "AGENTES : "+texto_seleccion_en
//			end if
//		else
//			if trim(filtroagentes_no) <> "" then
//				filtroagentes = "and venclientes.agente1 not in ("+filtroagentes_no+") "
//				texto_seleccion_agente = "TODOS LOS AGENTES EXCEPTO "+texto_seleccion_no_en
//			end if	
//		end if
//	else
//		filtroagentes = ""
//		texto_seleccion_agente = "TODOS LOS AGENTES"
//	end if
//	texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_agente
//else
//	filtropaises  = ""
//	filtroagentes = ""
//	
//	texto_seleccion_final = texto_seleccion_cliente
//end if
//
////Motivos
//
//total = uo_motivos.dw_marca.RowCount()
//
//opciones = total
//opciones_marcadas = 0
//opciones_marcadas_no = 0
//
//for indice = 1 to total
//	IF uo_motivos.dw_marca.GetItemString(indice,"marca") = "S" THEN
//		opciones_marcadas ++
//		motivo = uo_motivos.dw_marca.GetItemString(indice,"codigo")
//		if filtromotivos = "" then
//			filtromotivos = "'"+motivo+"'"
//			texto_seleccion_en = uo_motivos.dw_marca.object.texto[indice]
//		else
//			filtromotivos = filtromotivos + ",'"+motivo+"'"
//			texto_seleccion_en = texto_seleccion_en+";"+uo_motivos.dw_marca.object.texto[indice]
//		end if
//	else
//		opciones_marcadas_no ++
//		motivo = uo_motivos.dw_marca.GetItemString(indice,"codigo")
//		if filtromotivos_no = "" then
//			filtromotivos_no = "'"+motivo+"'"
//			texto_seleccion_no_en = uo_motivos.dw_marca.object.texto[indice]
//		else
//			filtromotivos_no = filtromotivos_no + ",'"+motivo+"'"
//			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_motivos.dw_marca.object.texto[indice]
//		end if		
//	end if
//next
//
//if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
//	if opciones_marcadas <= opciones_marcadas_no then
//		if trim(filtromotivos) <> "" then
//			filtromotivos = "and ven_reclamaciones.codigo_ven_reclamaciones_tipos in ("+filtromotivos+") "
//			texto_seleccion_motivo = "motivos : "+texto_seleccion_en
//		end if
//	else
//		if trim(filtromotivos_no) <> "" then
//			filtromotivos = "and ven_reclamaciones.codigo_ven_reclamaciones_tipos not in ("+filtromotivos_no+") "
//			texto_seleccion_motivo = "TODOS LOS MOTIVOS EXCEPTO "+texto_seleccion_no_en
//		end if		
//	end if
//else
//	filtromotivos = ""
//	texto_seleccion_motivo = "TODOS LOS MOTIVOS"
//end if
//
//texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_motivo
////Causas
//
//total = uo_causas.dw_marca.RowCount()
//
//opciones = total
//opciones_marcadas = 0
//opciones_marcadas_no = 0
//
//for indice = 1 to total
//	IF uo_causas.dw_marca.GetItemString(indice,"marca") = "S" THEN
//		opciones_marcadas ++
//		causa = uo_causas.dw_marca.GetItemString(indice,"codigo")
//		if filtrocausas = "" then
//			filtrocausas = "'"+causa+"'"
//			texto_seleccion_en = uo_causas.dw_marca.object.texto[indice]
//		else
//			filtrocausas = filtrocausas + ",'"+causa+"'"
//			texto_seleccion_en = texto_seleccion_en+";"+uo_causas.dw_marca.object.texto[indice]
//		end if
//	else
//		opciones_marcadas_no ++
//		causa = uo_causas.dw_marca.GetItemString(indice,"codigo")
//		if filtrocausas_no = "" then
//			filtrocausas_no = "'"+causa+"'"
//			texto_seleccion_no_en = uo_causas.dw_marca.object.texto[indice]
//		else
//			filtrocausas_no = filtrocausas_no + ",'"+causa+"'"
//			texto_seleccion_no_en = texto_seleccion_no_en+";"+uo_causas.dw_marca.object.texto[indice]
//		end if		
//	end if
//next
//
//if opciones_marcadas <> opciones and opciones_marcadas <> 0 then
//	if opciones_marcadas <= opciones_marcadas_no then
//		if trim(filtrocausas) <> "" then
//			filtrocausas = "and ven_reclamaciones.codigo_ven_reclamaciones_causa in ("+filtrocausas+") "
//			texto_seleccion_causa = "causas : "+texto_seleccion_en
//		end if
//	else
//		if trim(filtrocausas_no) <> "" then
//			filtrocausas = "and ven_reclamaciones.codigo_ven_reclamaciones_causa not in ("+filtrocausas_no+") "
//			texto_seleccion_causa = "TODAS LAS CAUSAS EXCEPTO "+texto_seleccion_no_en
//		end if		
//	end if
//else
//	filtrocausas = ""
//	texto_seleccion_causa = "TODAS LAS CAUSAS"
//end if	
//texto_seleccion_final = texto_seleccion_final + "~n" + texto_seleccion_causa
//
//ls_sel = "SELECT ven_reclamaciones.empresa, "+&
//			"	ven_reclamaciones.cliente, "+&
//			"	genter.razon, "+&
//			"	ven_reclamaciones.reclamacion, "+&
//			"	ven_reclamaciones.descripcion, "+&
//			"	ven_reclamaciones.fecha, "+&     
//			"	ven_reclamaciones.codigo_ven_reclamaciones_tipos, "+&
//			"	ven_reclamaciones_tipos.descripcion, "+&
//			"	ven_reclamaciones.codigo_ven_reclamaciones_situa, "+&
//			"	ven_reclamaciones_situaciones.descripcion, "+&
//			"	ven_reclamaciones.codigo_ven_reclamaciones_causa, "+&
//			"	ven_reclamaciones_causas.descripcion, "+&
//			"	ven_reclamaciones.cerrada, "+&
//			"	ven_reclamaciones.ven_reclamaciones_respo_codigo, "+&
//			"	ven_reclamaciones_responsables.descripcion, "+&
//			"	venclientes.agente1, "+&
//			"	venagentes.nombre, "+&
//			"	ven_reclamaciones.telefonos_codigo, "+&
//			"	telefonos.contacto "+&
//		 	"FROM genter, "+&
//			"	ven_reclamaciones, "+&
//			"	ven_reclamaciones_causas, "+&
//			"	ven_reclamaciones_responsables, "+&
//			"	ven_reclamaciones_situaciones, "+&
//			"	ven_reclamaciones_tipos, "+&
//			"	venagentes, "+&
//			"	venclientes, "+&
//			"	telefonos, "+&
//			"	paises, "+&
//			"	provincias "+&
//			"WHERE ( ven_reclamaciones.empresa                         = ven_reclamaciones_causas.empresa ) "+&
//			"and   ( ven_reclamaciones.empresa                         = ven_reclamaciones_tipos.empresa ) "+&
//			"and   ( ven_reclamaciones.empresa                         = genter.empresa ) "+&
//			"and   ( ven_reclamaciones.empresa                         = venagentes.empresa ) "+&
//			"and   ( ven_reclamaciones.empresa                        *= ven_reclamaciones_situaciones.empresa ) "+&
//			"and   ( ven_reclamaciones.empresa                         = venclientes.empresa ) "+&
//			"and   ( ven_reclamaciones.cliente                         = venclientes.codigo ) "+&
//			"and   ( venclientes.agente1                               = venagentes.agente ) "+&
//			"and   ( ven_reclamaciones.cliente                         = genter.codigo ) "+&
//			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_causa  = ven_reclamaciones_causas.codigo ) "+&
//			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_tipos  = ven_reclamaciones_tipos.codigo ) "+&
//			"and   ( ven_reclamaciones.codigo_ven_reclamaciones_situa *= ven_reclamaciones_situaciones.codigo ) "+&
//			"and   ( ven_reclamaciones.empresa                        *= ven_reclamaciones_responsables.empresa ) "+&
//			"and   ( ven_reclamaciones.ven_reclamaciones_respo_codigo *= ven_reclamaciones_responsables.codigo ) "+&
//			"and   ( ven_reclamaciones.empresa                        *= telefonos.empresa ) "+&
//			"and   ( ven_reclamaciones.telefonos_codigo               *= telefonos.telefono ) "+&
//			"and   ( genter.tipoter                                   *= telefonos.tipoter ) "+&
//			"and   ( ven_reclamaciones.cliente                        *= telefonos.codigo ) "+&
//			"and   ( genter.pais                                       = paises.pais ) "+&
//			"and   ( genter.provincia                                 *= provincias.provincia ) "+&
//			"and   ( genter.pais                                      *= provincias.pais ) "+&
//			"and   ( ( ven_reclamaciones.empresa = '"+codigo_empresa+"' ) ) "+&
//			" and  ( ven_reclamaciones.fecha  between '"+STring(Date(em_fechadesde.text),formato_fecha_cursores)+"'  and '"+STring(Date(em_fechahasta.text),formato_fecha_cursores)+"')" + &
//			filtrocliente+&
//			filtropaises+&
//			filtroagentes+&
//			filtromotivos+&
//			filtrocausas
//	
////		and   ( ( ven_reclamaciones.empresa = '' ) 
////		AND     ( ven_reclamaciones.cliente = '' ) 
////		AND     ( genter.pais in ('') ) 
////		AND     ( genter.provincia in ('') ) 
////		AND     ( venclientes.agente1 in ('') ) 
////		AND     ( ven_reclamaciones.codigo_ven_reclamaciones_tipos in ('') ) 
////
//
//f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
//
//total = ds_datos.rowcount()
//
//if total > 0 then
//	if dw_principal[1]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if
//	if dw_principal[2]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if
//	if dw_principal[3]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if
//	if dw_principal[4]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if
//	if dw_principal[5]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if
//	if dw_principal[6]  then
//		ds_datos.rowscopy(1,total,Primary!,apartados.pagina1.dw_1,1,Primary!)
//	end if				
//end if
//
//destroy ds_datos
//
//for indice = 1 to 10
//	numerado_tp[indice] = false
//next
//
//apartados.event selectionchanged(0,apartados.selectedtab)
//
//apartados.pagina1.dw_1.setredraw(true)
//
end subroutine

event close;dw_detalle.reset()
dw_listado.reset()
end event

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta Total de Reclamaciones Motivo/Causa"
This.title         = istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_listado.SetTransObject(SQLCA)
dw_excel.SetTransObject(SQLCA)
string ls_sel, ls_codigo,ls_texto
long indice, ll_marcas
datastore u_ds_datos


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
	uo_paises.dw_marca.object.marca[indice]  = "S"
	uo_paises.dw_marca.object.codigo[indice] = ls_codigo
	uo_paises.dw_marca.object.texto[indice]  = ls_texto
	if ls_codigo = '1' then
		uo_paises.event itemchanged( indice, uo_paises.dw_marca.object.codigo, 'S')
	end if
NEXT
destroy u_ds_datos



//Agentes
uo_agentes.f_cargar_datos("dw_ayuda_venagentes","","","Agente","Nombre")
uo_agentes.cb_marcar.event clicked( )

//Motivos
uo_motivos.f_cargar_datos("dw_ayuda_ven_reclamaciones_tipos","","","Motivo","Nombre")
uo_motivos.cb_marcar.event clicked( )
//Causas
uo_causas.f_cargar_datos("dw_ayuda_ven_reclamaciones_causas","","","Causa","Nombre")
uo_causas.cb_marcar.event clicked( )

uo_provincias.cb_marcar.event clicked( )

if  cbx_mostrar_texto.checked then
	dw_detalle.Modify("DataWindow.Detail.Height='68'")
	dw_listado.Modify("DataWindow.Detail.Height='68'")
else
	dw_detalle.Modify("DataWindow.Detail.Height='0'")
	dw_listado.Modify("DataWindow.Detail.Height='0'")
end if


end event

on w_con_reclamaciones_motivo_causa.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.cbx_mostrar_texto=create cbx_mostrar_texto
this.dw_detalle=create dw_detalle
this.uo_manejo=create uo_manejo
this.cb_paises=create cb_paises
this.uo_paises=create uo_paises
this.cb_provincias=create cb_provincias
this.uo_provincias=create uo_provincias
this.cb_2=create cb_2
this.uo_agentes=create uo_agentes
this.cb_3=create cb_3
this.cb_4=create cb_4
this.uo_causas=create uo_causas
this.uo_motivos=create uo_motivos
this.cb_excel=create cb_excel
this.dw_excel=create dw_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.cbx_mostrar_texto
this.Control[iCurrent+11]=this.dw_detalle
this.Control[iCurrent+12]=this.uo_manejo
this.Control[iCurrent+13]=this.cb_paises
this.Control[iCurrent+14]=this.uo_paises
this.Control[iCurrent+15]=this.cb_provincias
this.Control[iCurrent+16]=this.uo_provincias
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.uo_agentes
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.cb_4
this.Control[iCurrent+21]=this.uo_causas
this.Control[iCurrent+22]=this.uo_motivos
this.Control[iCurrent+23]=this.cb_excel
this.Control[iCurrent+24]=this.dw_excel
end on

on w_con_reclamaciones_motivo_causa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.cbx_mostrar_texto)
destroy(this.dw_detalle)
destroy(this.uo_manejo)
destroy(this.cb_paises)
destroy(this.uo_paises)
destroy(this.cb_provincias)
destroy(this.uo_provincias)
destroy(this.cb_2)
destroy(this.uo_agentes)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.uo_causas)
destroy(this.uo_motivos)
destroy(this.cb_excel)
destroy(this.dw_excel)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;//f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_reclamaciones_motivo_causa
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_reclamaciones_motivo_causa
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_reclamaciones_motivo_causa
integer y = 4
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_reclamaciones_motivo_causa
integer x = 4142
integer y = 124
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_reclamaciones_motivo_causa
integer x = 4160
integer y = 276
integer taborder = 0
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)



end event

type dw_listado from datawindow within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 3067
integer y = 4
integer width = 297
integer height = 104
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_reclamaciones_motivo_causa"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_reclamaciones_motivo_causa
integer x = 50
integer y = 168
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_reclamaciones_motivo_causa
integer x = 393
integer y = 168
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_reclamaciones_motivo_causa
integer x = 32
integer y = 116
integer width = 699
integer height = 160
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

type cb_1 from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 3378
integer y = 264
integer width = 315
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_reclamaciones_motivo_causa
event destroy ( )
integer x = 750
integer y = 168
integer width = 1275
integer taborder = 40
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
	Return
end if 

end event

event getfocus;call super::getfocus;
ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_2 from groupbox within w_con_reclamaciones_motivo_causa
integer x = 731
integer y = 116
integer width = 1312
integer height = 160
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

type cbx_mostrar_texto from checkbox within w_con_reclamaciones_motivo_causa
integer x = 2048
integer y = 188
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detalle"
end type

event clicked;if this.checked then
	dw_detalle.Modify("DataWindow.Detail.Height='68'")
	dw_listado.Modify("DataWindow.Detail.Height='68'")
else
	dw_detalle.Modify("DataWindow.Detail.Height='0'")
	dw_listado.Modify("DataWindow.Detail.Height='0'")
end if
end event

type dw_detalle from datawindow within w_con_reclamaciones_motivo_causa
integer x = 27
integer y = 396
integer width = 4270
integer height = 2148
integer taborder = 60
string dataobject = "dw_con_reclamaciones_motivo_causa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

type uo_manejo from u_manejo_datawindow within w_con_reclamaciones_motivo_causa
integer x = 3685
integer y = 228
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_paises from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 46
integer y = 292
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
string text = "Paises"
end type

event clicked;uo_paises.visible     = not(uo_paises.visible)
uo_provincias.visible = false
uo_agentes.visible    = false
uo_motivos.visible    = false
uo_causas.visible     = false

end event

type uo_paises from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 46
integer y = 392
integer width = 1362
integer height = 664
integer taborder = 250
boolean bringtotop = true
end type

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

//	uo_provincias.dw_marca.setsort("texto")
//	uo_provincias.dw_marca.sort()
	
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

on uo_paises.destroy
call u_marca_lista_3::destroy
end on

type cb_provincias from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 416
integer y = 292
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
string text = "Provincias"
end type

event clicked;uo_paises.visible     = false
uo_provincias.visible = not(uo_provincias.visible)
uo_agentes.visible    = false
uo_motivos.visible    = false
uo_causas.visible     = false

end event

type uo_provincias from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 416
integer y = 392
integer height = 664
integer taborder = 260
boolean bringtotop = true
end type

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

on uo_provincias.destroy
call u_marca_lista_3::destroy
end on

type cb_2 from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 786
integer y = 292
integer width = 366
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

event clicked;
uo_agentes.visible     = not(uo_agentes.visible)
uo_provincias.visible  = false
uo_paises.visible      = false
uo_motivos.visible     = false
uo_causas.visible      = false
end event

type uo_agentes from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 786
integer y = 392
integer height = 664
integer taborder = 270
boolean bringtotop = true
end type

on uo_agentes.destroy
call u_marca_lista_3::destroy
end on

type cb_3 from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 1157
integer y = 292
integer width = 366
integer height = 96
integer taborder = 70
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

type cb_4 from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 1527
integer y = 292
integer width = 366
integer height = 96
integer taborder = 80
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

type uo_causas from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 1527
integer y = 392
integer height = 664
integer taborder = 280
boolean bringtotop = true
end type

on uo_causas.destroy
call u_marca_lista_3::destroy
end on

type uo_motivos from u_marca_lista_3 within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 1166
integer y = 396
integer height = 664
integer taborder = 270
boolean bringtotop = true
end type

on uo_motivos.destroy
call u_marca_lista_3::destroy
end on

type cb_excel from commandbutton within w_con_reclamaciones_motivo_causa
integer x = 2939
integer y = 268
integer width = 361
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exp. Excel"
end type

event clicked;int li_valor
string ls_nomdoc,ls_nom
li_valor = GetFileSaveName("Imprimir formato Excel", ls_nomdoc, ls_nom, "XLS", "Imprime (*.XLS),*.XLS")
IF li_valor = 1 THEN
	if dw_detalle.rowcount() > 0 then
		if cbx_mostrar_texto.checked then 
			uf_save_dw_as_excel(dw_detalle,ls_nomdoc)
		else
			dw_detalle.rowscopy(1, dw_detalle.rowcount(), Primary!, dw_excel, 1, Primary!)
			uf_save_dw_as_excel(dw_excel,ls_nomdoc)	
	end if
		
		f_mensaje("Guardar fichero","Fichero guardado en "+ls_nomdoc)
	end if
	
ELSE
	return
END IF


end event

type dw_excel from datawindow within w_con_reclamaciones_motivo_causa
boolean visible = false
integer x = 2505
integer width = 425
integer height = 212
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_con_reclamaciones_motivo_causa_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

