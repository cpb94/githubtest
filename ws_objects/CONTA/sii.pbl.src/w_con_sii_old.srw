$PBExportHeader$w_con_sii_old.srw
forward
global type w_con_sii_old from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_sii_old
end type
type cb_consultar from commandbutton within w_con_sii_old
end type
type gb_1 from groupbox within w_con_sii_old
end type
type cb_enviar from u_boton within w_con_sii_old
end type
type gb_3 from groupbox within w_con_sii_old
end type
type pb_2 from upb_imprimir within w_con_sii_old
end type
type em_fecha_desde from u_em_campo within w_con_sii_old
end type
type em_fecha_hasta from u_em_campo within w_con_sii_old
end type
type cb_1 from u_boton within w_con_sii_old
end type
type p_calendario from picture within w_con_sii_old
end type
type cbx_pruebas from checkbox within w_con_sii_old
end type
type cbx_reenviar from checkbox within w_con_sii_old
end type
type p_refrescar_dia from picture within w_con_sii_old
end type
type dw_calendario from u_datawindow within w_con_sii_old
end type
type dw_detalle from datawindow within w_con_sii_old
end type
type str_fichero_respuesta from structure within w_con_sii_old
end type
end forward

type str_fichero_respuesta from structure
	string		nif_empresa
	long		ejercicio
	string		factura
	string		tipoter
	string		nif_o_codigo_tercero
	datetime		fecha_envio
	string		fichero_envio
	string		resultado
end type

shared variables
boolean detalle=true
end variables

global type w_con_sii_old from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 4617
integer height = 2752
pb_1 pb_1
cb_consultar cb_consultar
gb_1 gb_1
cb_enviar cb_enviar
gb_3 gb_3
pb_2 pb_2
em_fecha_desde em_fecha_desde
em_fecha_hasta em_fecha_hasta
cb_1 cb_1
p_calendario p_calendario
cbx_pruebas cbx_pruebas
cbx_reenviar cbx_reenviar
p_refrescar_dia p_refrescar_dia
dw_calendario dw_calendario
dw_detalle dw_detalle
end type
global w_con_sii_old w_con_sii_old

type variables
str_contasii_parametros istr_contasii_parametros
datastore ids_cuentas_fras_recibidas
datastore ids_cuentas_fras_emitidas
datastore ids_importe_servicios_fras_emitidas
string Is_IDVersionSii = '1.0'
string Is_IDVersionSii_Pruebas = '0.7'
end variables

forward prototypes
public subroutine f_control (datawindow data)
public function string f_tratar_razon (string arg_razon)
public subroutine f_tratar_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta)
public subroutine f_tratar_numero (ref string arg_numero)
public subroutine f_tratar_texto (ref string arg_texto)
public function string f_tratar_nif (string arg_nif, string arg_tercero, string arg_pais)
public subroutine sii_alta_factura_emitida ()
public subroutine sii_alta_entrega_bienes_prestacion_servi ()
public subroutine sii_alta_facturas_bienes_inversion ()
public subroutine sii_alta_facturas_registro_operaciones_i ()
public subroutine sii_alta_cobros_metalico ()
public subroutine sii_alta_facturas_simplificadas ()
public subroutine sii_alta_factura_rectificativa_sustituci ()
public subroutine sii_alta_factura_rectificativa_diferenci ()
public subroutine sii_baja_factura ()
public subroutine sii_libro_registro_expedidas ()
public function long f_sii_facturas_expedidas ()
public subroutine f_cargar_cuentas_fras_recibidas ()
public subroutine f_cargar_cuentas_fras_emitidas ()
public function string f_descripcion_operacion_factura_emitida (string arg_empresa, string arg_cliente, string arg_factura, datetime arg_ffactura)
public function string f_descripcion_operacion_factura_recibida (string arg_empresa, string arg_proveedor, string arg_factura, datetime arg_ffactura)
public subroutine f_cargar_importe_servicios_fras_emitidas ()
public subroutine f_procesar_facturas_dia (datetime arg_dia)
public function string sii_alta_facturas_emitidas (datastore ds_datos, string arg_es_un_reenvio)
public function string sii_alta_facturas_recibidas (datastore ds_datos, string arg_es_un_reenvio)
end prototypes

public subroutine f_control (datawindow data);datetime ldt_fecha_desde,ldt_fecha_hasta
long     ll_indice,ll_total,ll_ejercicio,ll_donde
long     ll_indice_tipos_impositivos,ll_total_tipos_impositivos
string   ls_moneda_empresa,sel,ls_formula_ventas,ls_formula_compras,ls_venfac_serie,ls_sel,ls_filtro
string   ls_tipoiva_recargo
integer  li_decimales_moneda_empresa
dec{2}   ld_importe_servicios
boolean  lb_correcto  = true

datastore ds_tipos_impositivos_factura

str_contasii lstr_contasii
str_contasii_tiposimpositivos lstr_contasii_tiposimpositivos

ls_moneda_empresa           = f_moneda_empresa(codigo_empresa)
li_decimales_moneda_empresa = f_decimales_moneda(ls_moneda_empresa)
	
datastore ds_operaciones

data.reset()
data.SetRedraw(false)

f_mascara_columna(data,'importetotal',f_mascara_moneda(ls_moneda_empresa))
f_mascara_columna(data,'fechaexpedicion','dd-mm-yyyy')
f_mascara_columna(data,'fechaoperacion','dd-mm-yyyy')
f_mascara_columna(data,'fecharegcontable','dd-mm-yyyy')

f_cargar_cuentas_fras_emitidas()
f_cargar_cuentas_fras_recibidas()
f_cargar_importe_servicios_fras_emitidas()

ldt_fecha_desde = datetime(date(em_fecha_desde.text))
ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))

ll_ejercicio   = year(date(ldt_fecha_desde))

ls_formula_ventas  = " sum( contaapun.haber - contaapun.debe ) + sum( contaapun.imponible ) "
ls_formula_compras = " sum( contaapun.debe - contaapun.haber ) + sum( contaapun.imponible ) "	
							
Sel = " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.sii_clave,'') as sii_clave,"+&
		"        sum(contaapun.imponible) as imponible,"+&
		"        sum(contaapun.debe) as debe,"+&
		"        sum(contaapun.haber) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.registro,0) as registro,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'V' ) "+&
		" AND    contaapun.tipoiva in  (SELECT contaiva.tipoiva from contaiva "+&
		"                               WHERE  contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contaiva.incluir_en_sii = 'S' ) "+&		
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                            and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY contaapun.tipoter,"+&
		"        contaapun.clipro,"+&
		"        contaiva.sii_clave,"+&
		"        contaapun.factura,"+&
		"        contaapun.registro,"+&
		"        contaapun.ffactura,"+&
		"        contaapun.fapunte "+&
	   " UNION "+&
      " SELECT contaapun.tipoter as tipoter,"+&
		"        contaapun.clipro as clipro,"+&
		"        contaiva.sii_clave as sii_clave,"+&
		"        sum(contaapun.imponible) as imponible,"+&
		"        sum(contaapun.debe) as debe,"+&
		"        sum(contaapun.haber) as haber,"+&
		"        contaapun.factura as factura,"+&
		"        contaapun.registro as registro,"+&
		"        contaapun.ffactura as ffactura,"+&
		"        contaapun.fapunte as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&		
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'C') "+&
		" AND    contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
		"                              WHERE   contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                              AND     contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                              AND     contaiva.incluir_en_sii = 'S' ) "+&											
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                          and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY contaapun.tipoter,"+&
		"        contaapun.clipro,"+&
		"        contaiva.sii_clave,"+&
		"        contaapun.factura,"+&
		"        contaapun.registro,"+&
		"        contaapun.ffactura,"+&
		"        contaapun.fapunte "+&		
		" ORDER BY contaapun.tipoter, contaapun.clipro, contaapun.ffactura"							
							
f_mensaje_proceso("Obteniendo datos",0,100)		

ll_total = f_cargar_cursor_transaccion(sqlca,ds_operaciones,sel)		

Sel = " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.tipoiva,'') as tipoiva,"+&
		"        isnull(contaiva.sii_exenta,'') as sii_exenta,"+&
		"        isnull(contaiva.sii_causa_exencion,'') as sii_causa_exencion,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') as sii_tipo_no_exenta,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) as sii_tipo_impositivo,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) as sii_cuota_deducible,"+&
		"        isnull(contaapun.imponible,0) as imponible,"+&
		"        isnull(contaapun.debe,0) as debe,"+&
		"        isnull(contaapun.haber,0) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.registro,0) as registro,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'V' ) "+&
		" AND    contaapun.tipoiva in  (SELECT contaiva.tipoiva from contaiva "+&
		"                               WHERE  contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contaiva.incluir_en_sii = 'S' ) "+&		
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                            and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
	   " UNION "+&
      " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.tipoiva,'') as tipoiva,"+&
		"        isnull(contaiva.sii_exenta,'') as sii_exenta,"+&
		"        isnull(contaiva.sii_causa_exencion,'') as sii_causa_exencion,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') as sii_tipo_no_exenta,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) as sii_tipo_impositivo,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) as sii_cuota_deducible,"+&
		"        isnull(contaapun.imponible,0) as imponible,"+&
		"        isnull(contaapun.debe,0) as debe,"+&
		"        isnull(contaapun.haber,0) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.registro,0) as registro,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&		
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'C') "+&
		" AND    contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
		"                              WHERE   contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                              AND     contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                              AND     contaiva.incluir_en_sii = 'S' ) "+&											
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                          and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" ORDER BY contaapun.tipoter, contaapun.clipro, contaapun.ffactura"					

f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos_factura,sel)

IF ll_total > 0 then	
	for ll_indice = 1 to ll_total
		f_mensaje_proceso("Procesando datos",ll_indice,ll_total)	
				
		lstr_contasii.empresa              = codigo_empresa
		lstr_contasii.ejercicio            = year(date(ds_operaciones.object.ffactura[ll_indice]))
		lstr_contasii.factura              = ds_operaciones.object.factura[ll_indice]
		lstr_contasii.tipoter              = ds_operaciones.object.tipoter[ll_indice]
		lstr_contasii.tercero              = ds_operaciones.object.clipro[ll_indice]
		lstr_contasii.numseriefactura      = ds_operaciones.object.factura[ll_indice]
		lstr_contasii.fechaexpedicion      = ds_operaciones.object.ffactura[ll_indice]
		lstr_contasii.fechaoperacion       = ds_operaciones.object.ffactura[ll_indice]
		lstr_contasii.fecharegcontable     = ds_operaciones.object.fapunte[ll_indice]
		
		if lstr_contasii.tipoter = 'C' then
			//Facturas expedidas
			ls_venfac_serie = f_serie_venfac(lstr_contasii.empresa,lstr_contasii.ejercicio,long(lstr_contasii.factura))
			
			lstr_contasii.tipofactura          = f_venseries_sii_tipo_factura_emitida(lstr_contasii.empresa,ls_venfac_serie) //Factura
			if date(lstr_contasii.fecharegcontable) < date('01-07-2017') then
				lstr_contasii.clave                = '16'
			else
				lstr_contasii.clave                = ds_operaciones.object.sii_clave[ll_indice]//f_contaiva_sii_clave(lstr_contasii.ejercicio,lstr_contasii.empresa,ds_operaciones.object.tipoiva[ll_indice])
			end if
			lstr_contasii.descripcionoperacion = f_descripcion_operacion_factura_emitida(lstr_contasii.empresa,lstr_contasii.tercero,lstr_contasii.factura,lstr_contasii.fechaexpedicion)
			lstr_contasii.importetotal         = 0
			lstr_contasii.situacioninmueble    = ""
			lstr_contasii.referenciacatastral  = ""
		else
			//facturas recibidas
			lstr_contasii.tipofactura          = "F1" //Factura
			if date(lstr_contasii.fecharegcontable) < date('01-07-2017') then
				lstr_contasii.clave                = '14'
			else			
				lstr_contasii.clave                = ds_operaciones.object.sii_clave[ll_indice]//f_contaiva_sii_clave(lstr_contasii.ejercicio,lstr_contasii.empresa,ds_operaciones.object.tipoiva[ll_indice])
			end if
			lstr_contasii.descripcionoperacion = f_descripcion_operacion_factura_recibida(lstr_contasii.empresa,lstr_contasii.tercero,lstr_contasii.factura,lstr_contasii.fechaexpedicion)
			lstr_contasii.importetotal         = 0
			lstr_contasii.situacioninmueble    = ""
			lstr_contasii.referenciacatastral  = ""			
		end if
		
		//Detalle tipos impositivos
		
		ls_filtro = "tipoter = '"+lstr_contasii.tipoter+"' "+&
						"and clipro = '"+lstr_contasii.tercero+"' "+&
						"and factura = '"+lstr_contasii.numseriefactura+"' "+&
						"and date(ffactura) = date('"+string(lstr_contasii.fechaexpedicion,'dd-mm-yyyy')+"')"
		
		ds_tipos_impositivos_factura.setfilter(ls_filtro)
		ds_tipos_impositivos_factura.filter()
		
		ll_total_tipos_impositivos = ds_tipos_impositivos_factura.rowcount()
		
		for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos
			
			lstr_contasii_tiposimpositivos.empresa   = lstr_contasii.empresa
			lstr_contasii_tiposimpositivos.ejercicio = lstr_contasii.ejercicio
			lstr_contasii_tiposimpositivos.factura   = lstr_contasii.factura
			lstr_contasii_tiposimpositivos.tipoter   = lstr_contasii.tipoter
			lstr_contasii_tiposimpositivos.tercero   = lstr_contasii.tercero
			lstr_contasii_tiposimpositivos.tipoiva   = ds_tipos_impositivos_factura.object.tipoiva[ll_indice_tipos_impositivos]
			
			if lstr_contasii_tiposimpositivos.tipoter = 'C' then
			//Emitidas
				lstr_contasii_tiposimpositivos.exenta               = ds_tipos_impositivos_factura.object.sii_exenta[ll_indice_tipos_impositivos]
				if lstr_contasii_tiposimpositivos.exenta <> "S" then			
					lstr_contasii_tiposimpositivos.tiponoexenta      = ds_tipos_impositivos_factura.object.sii_tipo_no_exenta[ll_indice_tipos_impositivos]
					lstr_contasii_tiposimpositivos.causaexencion     = ""					
				else
					lstr_contasii_tiposimpositivos.tiponoexenta      = ""
					lstr_contasii_tiposimpositivos.causaexencion     = ds_tipos_impositivos_factura.object.sii_causa_exencion[ll_indice_tipos_impositivos]
				end if	
				
			else
			//Recibidas
				lstr_contasii_tiposimpositivos.exenta               = ds_tipos_impositivos_factura.object.sii_exenta[ll_indice_tipos_impositivos]
				if lstr_contasii_tiposimpositivos.exenta <> "S" then			
					lstr_contasii_tiposimpositivos.tiponoexenta      = ds_tipos_impositivos_factura.object.sii_tipo_no_exenta[ll_indice_tipos_impositivos]
					lstr_contasii_tiposimpositivos.causaexencion     = ""
				else
					lstr_contasii_tiposimpositivos.tiponoexenta      = ""
					lstr_contasii_tiposimpositivos.causaexencion     = ds_tipos_impositivos_factura.object.sii_causa_exencion[ll_indice_tipos_impositivos]
				end if											
			end if
			
			if lstr_contasii_tiposimpositivos.tipoter = 'C' then
				//Vamos a buscar la parte que corresponde a servicios
				if ll_total_tipos_impositivos = 1 then
					//Solo lo haremos si hay un unico tipo de iva
					ls_filtro = "anyo = "+string(lstr_contasii_tiposimpositivos.ejercicio,"###0")+" "+&
									"and factura = '"+lstr_contasii_tiposimpositivos.factura+"' "
									
					ll_donde = ids_importe_servicios_fras_emitidas.find(ls_filtro,1,ids_importe_servicios_fras_emitidas.rowcount())				
					
					if ll_donde > 0 then
						ld_importe_servicios = ids_importe_servicios_fras_emitidas.object.importe_servicios[ll_donde]
					else
						ld_importe_servicios = 0
					end if
				else
					ld_importe_servicios = 0
				end if
			else
				ld_importe_servicios = 0
			end if 
						
			lstr_contasii_tiposimpositivos.entrega_o_servicio = 'E'
			lstr_contasii_tiposimpositivos.tipoimpositivo = ds_tipos_impositivos_factura.object.sii_tipo_impositivo[ll_indice_tipos_impositivos]
			lstr_contasii_tiposimpositivos.baseimponible  = ds_tipos_impositivos_factura.object.imponible[ll_indice_tipos_impositivos]
			lstr_contasii_tiposimpositivos.baseimponible -= ld_importe_servicios
			lstr_contasii_tiposimpositivos.cuota          = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tipoimpositivo,li_decimales_moneda_empresa)
			
			ls_tipoiva_recargo = f_contaiva_recargo(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,lstr_contasii_tiposimpositivos.tipoiva)
			
			if ls_tipoiva_recargo <> "" then
				lstr_contasii_tiposimpositivos.tiporecargoequivalencia = f_iva_contaiva(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,ls_tipoiva_recargo)
				lstr_contasii_tiposimpositivos.cuotarecargo = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tiporecargoequivalencia,li_decimales_moneda_empresa)							
			else
				lstr_contasii_tiposimpositivos.tiporecargoequivalencia = 0
				lstr_contasii_tiposimpositivos.cuotarecargo = 0
			end if
			
			lstr_contasii.importetotal += lstr_contasii_tiposimpositivos.baseimponible + lstr_contasii_tiposimpositivos.cuota + lstr_contasii_tiposimpositivos.cuotarecargo
			
			if lstr_contasii_tiposimpositivos.baseimponible > 0 then
				if not f_insert_contasii_tiposimpositivos(lstr_contasii_tiposimpositivos) then
					lb_correcto = false
				end if
			end if
			
			if ld_importe_servicios > 0 then
				//Detalle servicios facturados
				lstr_contasii_tiposimpositivos.entrega_o_servicio = 'S'
				lstr_contasii_tiposimpositivos.tipoimpositivo = ds_tipos_impositivos_factura.object.sii_tipo_impositivo[ll_indice_tipos_impositivos]
				lstr_contasii_tiposimpositivos.baseimponible  = ld_importe_servicios
				lstr_contasii_tiposimpositivos.cuota          = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tipoimpositivo,li_decimales_moneda_empresa)
				
				ls_tipoiva_recargo = f_contaiva_recargo(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,lstr_contasii_tiposimpositivos.tipoiva)
				
				if ls_tipoiva_recargo <> "" then
					lstr_contasii_tiposimpositivos.tiporecargoequivalencia = f_iva_contaiva(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,ls_tipoiva_recargo)
					lstr_contasii_tiposimpositivos.cuotarecargo = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tiporecargoequivalencia,li_decimales_moneda_empresa)							
				else
					lstr_contasii_tiposimpositivos.tiporecargoequivalencia = 0
					lstr_contasii_tiposimpositivos.cuotarecargo = 0
				end if
				
				lstr_contasii.importetotal += lstr_contasii_tiposimpositivos.baseimponible + lstr_contasii_tiposimpositivos.cuota + lstr_contasii_tiposimpositivos.cuotarecargo
				
				if not f_insert_contasii_tiposimpositivos(lstr_contasii_tiposimpositivos) then
					lb_correcto = false
				end if				
			end if
			
		next
				
		if not(f_insert_contasii(lstr_contasii)) then
			lb_correcto = false
		end if				
				
	next		
	
	if not(lb_correcto) then
		messagebox("Error generación SII", "El proceso no se actualiza")
		rollback;
	else		
		commit;
		messagebox("Mensaje del sistema", "El proceso de generacion de datos SII ha sido correcto")
		dw_detalle.SetRedraw(TRUE)
	end if
		
else
	messagebox ( "Atención" , " No hay registros en el periodo seleccionado.")
	f_mensaje_proceso("",100,100)	
	f_activar_campo(em_fecha_desde)
	return
end if

destroy ds_operaciones
destroy ds_tipos_impositivos_factura

data.retrieve(codigo_empresa,ldt_fecha_desde,ldt_fecha_hasta)

//data.Sort()
//data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

public function string f_tratar_razon (string arg_razon);string var_razon,nueva_razon,caracter,caracter_ant
long   indice,total,asci

var_razon    = Upper(trim(arg_razon))
nueva_razon  = ""
total        = len(var_razon)
caracter_ant = ''

for indice = 1 to total
	caracter = mid(var_razon,indice,1)
	
	choose case caracter
		case "Á"
			caracter = "A"
		case "É"
			caracter = "E"
		case "Í"
			caracter = "I"
		case "Ó"
			caracter = "O"
		case "Ú"
			caracter = "U"
		case "Ñ"
			caracter = char(209)
		case "Ç"
			caracter = char(199)
		case "(",")","º","ª"
			caracter = " "					
		case "-"
			caracter = " "
		case " "
			if caracter_ant = ' ' then
				caracter_ant = caracter
				caracter = ""		
			else
				caracter_ant = caracter
			end if
	end choose	
	caracter_ant = caracter
	nueva_razon  = nueva_razon + caracter	
next

return nueva_razon
end function

public subroutine f_tratar_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta);int v_longitud_total,v_longitud,v_indice,v_longitud_relleno

if isnull(arg_campo) then arg_campo = ''

if arg_tipo_campo = "N" then
	//f_tratar_numero(arg_campo)
else
	f_tratar_texto(arg_campo)
end if

v_longitud_total = (arg_pos_hasta - arg_pos_desde) + 1

v_longitud         = len(arg_campo)
v_longitud_relleno = v_longitud_total - v_longitud

if v_longitud > v_longitud_total then
	arg_campo = left(arg_campo,v_longitud_total)
else
//	for v_indice = 1 to v_longitud_relleno
//		if arg_tipo_campo = "N" then
//			arg_campo = '0' + arg_campo
//		else
//			arg_campo = arg_campo + ' '
//		end if
//	next
end if
end subroutine

public subroutine f_tratar_numero (ref string arg_numero);int    v_indice,v_total
string v_numero_tratado,v_caracter

v_total = len(trim(arg_numero))

arg_numero = trim(upper(arg_numero))

for v_indice = 1 to v_total
	v_caracter = mid(arg_numero,v_indice,1)
	
	if not(asc(v_caracter) >= 48 and asc(v_caracter) <= 57) then
		v_caracter = ''
	end if
	
	v_numero_tratado = v_numero_tratado + v_caracter
next

arg_numero = v_numero_tratado
end subroutine

public subroutine f_tratar_texto (ref string arg_texto);int    v_indice,v_total
string v_texto_tratado,v_caracter

v_total = len(trim(arg_texto))

arg_texto = trim(upper(arg_texto))

for v_indice = 1 to v_total
	v_caracter = mid(arg_texto,v_indice,1)
	
	//Con esto quitamos las comillas dobles en los strings
	if asc(v_caracter) = 34 then
		v_caracter = ""
	end if
	
	choose case v_caracter
		case "Ñ"
			v_caracter = char(209)
		case "Ç"
			v_caracter = char(199)
		case "º","ª","°"
			v_caracter = ""
		case "(",")"
			v_caracter = " "
		case "&"
			v_caracter = "&amp;"						
	end choose
	
	v_texto_tratado = v_texto_tratado + v_caracter
next

arg_texto = v_texto_tratado


end subroutine

public function string f_tratar_nif (string arg_nif, string arg_tercero, string arg_pais);string var_nif,nuevo_nif,caracter,ls_codigo_iso
long   indice,total,asci,longitud_nif

ls_codigo_iso = ""

select isnull(codigo_iso,'')
into  :ls_codigo_iso
from  paises
where pais = :arg_pais
using sqlca;

if isnull(ls_codigo_iso) then ls_codigo_iso = ""
ls_codigo_iso = Upper(trim(ls_codigo_iso))

var_nif = Upper(trim(arg_nif))

nuevo_nif = ""
total = len(var_nif)
for indice = 1 to total
	caracter = mid(var_nif,indice,1)
	asci     = asc(caracter)
	if (asci >= 48 and asci <= 90) and caracter <> "-" then
		nuevo_nif = nuevo_nif + caracter
	end if
next

longitud_nif = 9
		
if len(nuevo_nif) <> longitud_nif then	
	//messagebox("Error en NIF ","El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
end if

return nuevo_nif
end function

public subroutine sii_alta_factura_emitida ();//8.1. Operativa: Alta de una factura 
//8.1.1. Alta de facturas en el libro de registro de Facturas Emitidas 
//8.1.1.1.Ejemplo mensaje XML de alta  
 
long   ll_donde 
string ls_linea_xml
datawindow arg_datawindow 
 
//Variables
string ls_IDVersionSii = '0.6'
string ls_Titular_NombreRazon = 'EMPRESAYYYYY'
string ls_Titular_NIF = 'N0041746I'
string ls_TipoComunicacion = 'A0' 
string ls_PeriodoImpositivo_Ejercicio = '2017'
string ls_PeriodoImpositivo_Periodo = '03'
string ls_IDEmisorFactura_NIF = 'A84532501'
string ls_NumSerieFacturaEmisor = '000000000002'
string ls_FechaExpedicionFacturaEmisor = '01-03-2017'
string ls_TipoFactura = 'F1'
//string ls_FechaOperacion = '01-03-2016'
string ls_ClaveRegimenEspecialOTrascendencia = '01'
string ls_ImporteTotal = '26.70'
string ls_DescripcionOperacion = 'Objeto de la factura'
string ls_Contraparte_NombreRazon = 'EMPRESAXXX'
string ls_Contraparte_NIF = 'A84532501'

string ls_IDOtro_CodigoPais //Código del país asociado al emisor de la factura Alfanumérico(2) (ISO 3166-1 alpha-2 codes) L17
string ls_IDOtro_IDType     //Clave para establecer el tipo de identificación en el pais de residencia Alfanumérico(2) L4
string ls_IDOtro_ID         //Número de identificación en el país de residencia Alfanumérico(20)

string ls_TipoNoExenta = 'S1'
string ls_CausaExencion = 'E4'
string ls_DesgloseIVA_TipoImpositivo = '21'
string ls_DesgloseIVA_BaseImponible = '22.07'
string ls_DesgloseIVA_CuotaRepercutida = '4.63'
string ls_DesgloseIVA_TipoRecargoEquivalencia = '0'
string ls_DesgloseIVA_CuotaRecargoEquivalencia = '0'
 
ls_linea_xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">' 
ll_donde     = arg_datawindow.insertrow(0)
arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml

	ls_linea_xml = '<soapenv:Header/>' 
	ll_donde     = arg_datawindow.insertrow(0)
	arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml
	
	ls_linea_xml = '<soapenv:Body>' 
	ll_donde     = arg_datawindow.insertrow(0)
	arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml	
	
		ls_linea_xml = '<siiLR:SuministroLRFacturasEmitidas>' 
		ll_donde     = arg_datawindow.insertrow(0)
		arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml	
		
			ls_linea_xml = '<sii:Cabecera>' 
			ll_donde     = arg_datawindow.insertrow(0)
			arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
			
				ls_linea_xml = '<sii:IDVersionSii>'+ls_IDVersionSii+'</sii:IDVersionSii>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml					
				
				ls_linea_xml = '<sii:Titular>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
				
					ls_linea_xml = '<sii:NombreRazon>'+ls_Titular_NombreRazon+'</sii:NombreRazon>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:NIF>'+ls_Titular_NIF+'</sii:NIF>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml											
				
				ls_linea_xml = '</sii:Titular>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
				
				ls_linea_xml = '<sii:TipoComunicacion>'+ls_TipoComunicacion+'</sii:TipoComunicacion>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml								
			
			ls_linea_xml = '</sii:Cabecera>' 
			ll_donde     = arg_datawindow.insertrow(0)
			arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml				
			
			ls_linea_xml = '<siiLR:RegistroLRFacturasEmitidas>' 
			ll_donde     = arg_datawindow.insertrow(0)
			arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml					
		
				ls_linea_xml = '<sii:PeriodoImpositivo>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml				
				
					ls_linea_xml = '<sii:Ejercicio>'+ls_PeriodoImpositivo_Ejercicio+'</sii:Ejercicio>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
					
					ls_linea_xml = '<sii:Periodo>'+ls_PeriodoImpositivo_Periodo+'</sii:Periodo>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
								
				ls_linea_xml = '</sii:PeriodoImpositivo>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
				
				ls_linea_xml = '<siiLR:IDFactura>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
				
					ls_linea_xml = '<sii:IDEmisorFactura>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
					
						ls_linea_xml = '<sii:NIF>'+ls_IDEmisorFactura_NIF+'</sii:NIF>' 
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
					
					ls_linea_xml = '</sii:IDEmisorFactura>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml								
				
					ls_linea_xml = '<sii:NumSerieFacturaEmisor>'+ls_NumSerieFacturaEmisor+'</sii:NumSerieFacturaEmisor>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:FechaExpedicionFacturaEmisor>'+ls_FechaExpedicionFacturaEmisor+'</sii:FechaExpedicionFacturaEmisor>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml																						
				
				ls_linea_xml = '</siiLR:IDFactura>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
				
				ls_linea_xml = '<siiLR:FacturaExpedida>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		

					ls_linea_xml = '<sii:TipoFactura>'+ls_TipoFactura+'</sii:TipoFactura>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		
				
					ls_linea_xml = '<sii:ClaveRegimenEspecialOTrascendencia>'+ls_ClaveRegimenEspecialOTrascendencia+'</sii:ClaveRegimenEspecialOTrascendencia>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:ImporteTotal>'+ls_ImporteTotal+'</sii:ImporteTotal>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
					
					ls_linea_xml = '<sii:DescripcionOperacion>'+ls_DescripcionOperacion+'</sii:DescripcionOperacion>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
					
					ls_linea_xml = '<sii:Contraparte>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
					
						ls_linea_xml = '<sii:NombreRazon>'+ls_Contraparte_NombreRazon+'</sii:NombreRazon>' 
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml								
						
						ls_linea_xml = '<sii:NIF>'+ls_Contraparte_NIF+'</sii:NIF>' 
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml				
						
						//Nif para España y IDOtro para resto de paises
						
						ls_linea_xml = '<sii:IDOtro>'
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
						
							ls_linea_xml = '<sii:CodigoPais>'+ls_IDOtro_CodigoPais+'</sii:CodigoPais>' 
							ll_donde     = arg_datawindow.insertrow(0)
							arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
							
							ls_linea_xml = '<sii:IDType>'+ls_IDOtro_IDType+'</sii:IDType>' 
							ll_donde     = arg_datawindow.insertrow(0)
							arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		
							
							ls_linea_xml = '<sii:ID>'+ls_IDOtro_ID+'</sii:ID>' 
							ll_donde     = arg_datawindow.insertrow(0)
							arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml									
						
						ls_linea_xml = '</sii:IDOtro>'
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
						
						//Nif para España y IDOtro para resto de paises
						
					ls_linea_xml = '</sii:Contraparte>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml								
					
					ls_linea_xml = '<sii:TipoDesglose>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		
					
						ls_linea_xml = '<sii:DesgloseFactura>' 
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
					
							ls_linea_xml = '<sii:Sujeta>' 
							ll_donde     = arg_datawindow.insertrow(0)
							arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml							
							
								/*
								<sii:Exenta>
									<sii:CausaExencion>E4</sii:CausaExencion>
									<sii:BaseImponible>50</sii:BaseImponible>
								</sii:Exenta>							
								*/
								
								ls_linea_xml = '<sii:NoExenta>' 
								ll_donde     = arg_datawindow.insertrow(0)
								arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml									
								
									ls_linea_xml = '<sii:TipoNoExenta>'+ls_TipoNoExenta+'</sii:TipoNoExenta>' 
									ll_donde     = arg_datawindow.insertrow(0)
									arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml											
							
									ls_linea_xml = '<sii:DesgloseIVA>' 
									ll_donde     = arg_datawindow.insertrow(0)
									arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		
									
										ls_linea_xml = '<sii:DetalleIVA>' 
										ll_donde     = arg_datawindow.insertrow(0)
										arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml											
										
											ls_linea_xml = '<sii:TipoImpositivo>'+ls_DesgloseIVA_TipoImpositivo+'</sii:TipoImpositivo>' 
											ll_donde     = arg_datawindow.insertrow(0)
											arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml											
											
											ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
											ll_donde     = arg_datawindow.insertrow(0)
											arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml	
											
											ls_linea_xml = '<sii:CuotaRepercutida>'+ls_DesgloseIVA_CuotaRepercutida+'</sii:CuotaRepercutida>' 
											ll_donde     = arg_datawindow.insertrow(0)
											arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml	
											
											ls_linea_xml = '<sii:TipoRecargoEquivalencia>'+ls_DesgloseIVA_TipoRecargoEquivalencia+'</sii:TipoRecargoEquivalencia>' 
											ll_donde     = arg_datawindow.insertrow(0)
											arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml	
											
											ls_linea_xml = '<sii:CuotaRecargoEquivalencia>'+ls_DesgloseIVA_CuotaRecargoEquivalencia+'</sii:CuotaRecargoEquivalencia>' 
											ll_donde     = arg_datawindow.insertrow(0)
											arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml												
										//**	
									
										ls_linea_xml = '</sii:DetalleIVA>' 
										ll_donde     = arg_datawindow.insertrow(0)
										arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml											
									
									ls_linea_xml = '</sii:DesgloseIVA>' 
									ll_donde     = arg_datawindow.insertrow(0)
									arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml																				
								
								ls_linea_xml = '</sii:NoExenta>' 
								ll_donde     = arg_datawindow.insertrow(0)
								arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
							
							ls_linea_xml = '</sii:Sujeta>' 
							ll_donde     = arg_datawindow.insertrow(0)
							arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
						
						ls_linea_xml = '</sii:DesgloseFactura>' 
						ll_donde     = arg_datawindow.insertrow(0)
						arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml			
						
					ls_linea_xml = '</sii:TipoDesglose>' 
					ll_donde     = arg_datawindow.insertrow(0)
					arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml										
				
				ls_linea_xml = '</siiLR:FacturaExpedida>' 
				ll_donde     = arg_datawindow.insertrow(0)
				arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml					
				
			ls_linea_xml = '</siiLR:RegistroLRFacturasEmitidas>' 
			ll_donde     = arg_datawindow.insertrow(0)
			arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml									
		
		ls_linea_xml = '</siiLR:SuministroLRFacturasEmitidas>' 
		ll_donde     = arg_datawindow.insertrow(0)
		arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		
	
	ls_linea_xml = '</soapenv:Body>' 
	ll_donde     = arg_datawindow.insertrow(0)
	arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml		

ls_linea_xml = '</soapenv:Envelope>' 
ll_donde     = arg_datawindow.insertrow(0)
arg_datawindow.object.linea_xml[ll_donde] = ls_linea_xml
 
//XML de entrada: 
/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
	<soapenv:Header/>
	<soapenv:Body>
		<siiLR:SuministroLRFacturasEmitidas>
			<sii:Cabecera>
				<sii:IDVersionSii>0.6</sii:IDVersionSii>
				<sii:Titular>
					<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
					<sii:NIF>A84532501</sii:NIF>
				</sii:Titular>
				<sii:TipoComunicacion>A0</sii:TipoComunicacion>
			</sii:Cabecera>
			<siiLR:RegistroLRFacturasEmitidas>
				<sii:PeriodoImpositivo>
					<sii:Ejercicio>2015</sii:Ejercicio>
					<sii:Periodo>01</sii:Periodo>
				</sii:PeriodoImpositivo>
				<siiLR:IDFactura>
					<sii:IDEmisorFactura>
						<sii:NIF>A84532501</sii:NIF>
					</sii:IDEmisorFactura>
					<sii:NumSerieFacturaEmisor>01</sii:NumSerieFacturaEmisor>
					<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
				</siiLR:IDFactura>
				<siiLR:FacturaExpedida>
					<sii:TipoFactura>F1</sii:TipoFactura>
					<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
					<sii:ImporteTotal>26.70</sii:ImporteTotal>
					<sii:DescripcionOperacion>CompraXXXXXXX</sii:DescripcionOperacion>
					<sii:Contraparte>
						<sii:NombreRazon>EMPRESAYYYYYYYY</sii:NombreRazon>
						<sii:NIF>94234500B</sii:NIF>
					</sii:Contraparte>
					<sii:TipoDesglose>
						<sii:DesgloseFactura>
							<sii:Sujeta>
								<sii:NoExenta>
									<sii:TipoNoExenta>S1</sii:TipoNoExenta>
									<sii:DesgloseIVA>
										<sii:DetalleIVA>
											<sii:TipoImpositivo>21</sii:TipoImpositivo>
											<sii:BaseImponible>22.07</sii:BaseImponible>
											<sii:CuotaRepercutida>4.63</sii:CuotaRepercutida>
											<sii:TipoRecargoEquivalencia>0</sii:TipoRecargoEquivalencia>
											<sii:CuotaRecargoEquivalencia>0</sii:CuotaRecargoEquivalencia>
										</sii:DetalleIVA>
									</sii:DesgloseIVA>
								</sii:NoExenta>
							</sii:Sujeta>
						</sii:DesgloseFactura>
					</sii:TipoDesglose>
				</siiLR:FacturaExpedida>
			</siiLR:RegistroLRFacturasEmitidas>
			<siiLR:RegistroLRFacturasEmitidas>
				<sii:PeriodoImpositivo>
					<sii:Ejercicio>2015</sii:Ejercicio>
					<sii:Periodo>05</sii:Periodo>
				</sii:PeriodoImpositivo>
				<siiLR:IDFactura>
					<sii:IDEmisorFactura>
						<sii:NIF>A84532501</sii:NIF>
					</sii:IDEmisorFactura>
					<sii:NumSerieFacturaEmisor>02</sii:NumSerieFacturaEmisor>
					<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
				</siiLR:IDFactura>
				<siiLR:FacturaExpedida>
					<sii:TipoFactura>F2</sii:TipoFactura>
					<sii:ClaveRegimenEspecialOTrascendencia>08</sii:ClaveRegimenEspecialOTrascendencia>
					<sii:ImporteTotal>50</sii:ImporteTotal>
					<sii:DescripcionOperacion>CompraYYYYYYYYYYYYYYYYYYYYY</sii:DescripcionOperacion>
					<sii:EmitidaPorTerceros>S</sii:EmitidaPorTerceros>
					<sii:TipoDesglose>
						<sii:DesgloseFactura>
							<sii:Sujeta>
								<sii:Exenta>
									<sii:CausaExencion>E4</sii:CausaExencion>
									<sii:BaseImponible>50</sii:BaseImponible>
								</sii:Exenta>
							</sii:Sujeta>
						</sii:DesgloseFactura>
					</sii:TipoDesglose>
				</siiLR:FacturaExpedida>
			</siiLR:RegistroLRFacturasEmitidas>
		</siiLR:SuministroLRFacturasEmitidas>
	</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_entrega_bienes_prestacion_servi ();//8.1. Operativa: Alta de una factura 
//8.1.1. Alta de facturas en el libro de registro de Facturas Emitidas 
//8.1.1.2.Ejemplo mensaje XML de alta con desglose en entrega de bienes y prestación de servicio

//XML de entrada: 
/*	
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
	xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
	<soapenv:Header/>
	<soapenv:Body>
		<siiLR:SuministroLRFacturasEmitidas>
			<sii:Cabecera>
				<sii:IDVersionSii>0.6</sii:IDVersionSii>
				<sii:Titular>
					<sii:NombreRazon>EMPRESAXXX</sii:NombreRazon>
					<sii:NIF>A84532501</sii:NIF>
				</sii:Titular>
				<sii:TipoComunicacion>A0</sii:TipoComunicacion>
			</sii:Cabecera>
			<siiLR:RegistroLRFacturasEmitidas>
				<sii:PeriodoImpositivo>
					<sii:Ejercicio>2017</sii:Ejercicio>
					<sii:Periodo>01</sii:Periodo>
				</sii:PeriodoImpositivo>
				<siiLR:IDFactura>
					<sii:IDEmisorFactura>
						<sii:NIF>89890001K</sii:NIF>
						</sii:IDEmisorFactura>
					<sii:NumSerieFacturaEmisor>00000000001</sii:NumSerieFacturaEmisor>
					<sii:FechaExpedicionFacturaEmisor>02-01-2017</sii:FechaExpedicionFacturaEmisor>
				</siiLR:IDFactura>
				<siiLR:FacturaExpedida>
					<sii:TipoFactura>F1</sii:TipoFactura>
					<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
					<sii:DescripcionOperacion>CASO PRUEBA</sii:DescripcionOperacion>
					<sii:Contraparte>
						<sii:NombreRazon>EMPRESAYYYYY</sii:NombreRazon>
						<sii:NIF>N0041746I</sii:NIF>
					</sii:Contraparte>
					<sii:TipoDesglose>
						<sii:DesgloseTipoOperacion>
							<sii:PrestacionServicios>
								<sii:Sujeta>
									<sii:NoExenta>
										<sii:TipoNoExenta>S1</sii:TipoNoExenta>
										<sii:DesgloseIVA>
											<!--1 to 6 repetitions:-->
											<sii:DetalleIVA>
												<sii:TipoImpositivo>21</sii:TipoImpositivo>
												<sii:BaseImponible>118.5</sii:BaseImponible>
												<sii:CuotaRepercutida>31.5</sii:CuotaRepercutida>
											</sii:DetalleIVA>
										</sii:DesgloseIVA>
									</sii:NoExenta>
								</sii:Sujeta>
							</sii:PrestacionServicios>
							<sii:Entrega>
								<sii:Sujeta>
									<sii:NoExenta>
									<sii:TipoNoExenta>S2</sii:TipoNoExenta>
									<sii:DesgloseIVA>
										<sii:DetalleIVA>
											<sii:TipoImpositivo>21</sii:TipoImpositivo>
											<sii:BaseImponible>74.34</sii:BaseImponible>
											<sii:CuotaRepercutida>15.61</sii:CuotaRepercutida>
										</sii:DetalleIVA>
									</sii:DesgloseIVA>
									</sii:NoExenta>
								</sii:Sujeta>
							</sii:Entrega>
						</sii:DesgloseTipoOperacion>
					</sii:TipoDesglose>
				</siiLR:FacturaExpedida>
			</siiLR:RegistroLRFacturasEmitidas>
		</siiLR:SuministroLRFacturasEmitidas>
	</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_facturas_bienes_inversion ();//8.1. Operativa: Alta de una factura 
//8.1.3. Alta de facturas en el libro de registro de Bienes de Inversión
//8.1.3.1.Ejemplo mensaje XML de alta
 
//XML de entrada: 
/*	
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:sum="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sum1="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<sum:SuministroLRBienesInversion>
<sum1:Cabecera>
<sum1:IDVersionSii>0.6</sum1:IDVersionSii>
<sum1:Titular>
<sum1:NombreRazon>EMPRESAYYYYY</sum1:NombreRazon>
<sum1:NIF>N0041746I</sum1:NIF>
</sum1:Titular>
<sum1:TipoComunicacion>A0</sum1:TipoComunicacion>
</sum1:Cabecera>
<sum:RegistroLRBienesInversion>
<sum1:PeriodoImpositivo>
<sum1:Ejercicio>2017</sum1:Ejercicio>
<sum1:Periodo>0A</sum1:Periodo>
</sum1:PeriodoImpositivo>
<sum:IDFactura>
<sum1:IDEmisorFactura>
<sum1:NombreRazon>EMPRESAXXX</sum1:NombreRazon>
<sum1:NIF>A84532501</sum1:NIF>
</sum1:IDEmisorFactura>
<sum1:NumSerieFacturaEmisor>1</sum1:NumSerieFacturaEmisor>
<sum1:FechaExpedicionFacturaEmisor>05-03-2017</sum1:FechaExpedicionFacturaEmisor>
</sum:IDFactura>
<sum:BienesInversion>
<sum1:IdentificacionBien>A1</sum1:IdentificacionBien>
<sum1:FechaInicioUtilizacion>01-01-2017</sum1:FechaInicioUtilizacion>
<sum1:ProrrataAnualDefinitiva>10</sum1:ProrrataAnualDefinitiva>
</sum:BienesInversion>
</sum:RegistroLRBienesInversion>
</sum:SuministroLRBienesInversion>
</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_facturas_registro_operaciones_i ();//8.1. Operativa: Alta de una factura 
//8.1.4. Alta de facturas en el libro de registro de Operaciones Intracomunitarias
//8.1.4.1.Ejemplo mensaje XML de alta
 
//XML de entrada: 
/*	
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:sum="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sum1="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<sum:SuministroLRDetOperacionIntracomunitaria>
<sum1:Cabecera>
<sum1:IDVersionSii>0.6</sum1:IDVersionSii>
<sum1:Titular>
<sum1:NombreRazon>EMPRESAYYYYY</sum1:NombreRazon>
<sum1:NIF>N0041746I</sum1:NIF>
</sum1:Titular>
<sum1:TipoComunicacion>A0</sum1:TipoComunicacion>
</sum1:Cabecera>
<sum:RegistroLRDetOperacionIntracomunitaria>
<sum1:PeriodoImpositivo>
<sum1:Ejercicio>2017</sum1:Ejercicio>
<sum1:Periodo>02</sum1:Periodo>
</sum1:PeriodoImpositivo>
<sum:IDFactura>
<sum1:IDEmisorFactura>
<sum1:NombreRazon>EMPRESAYYYYY</sum1:NombreRazon>
<sum1:NIF>N0041746I</sum1:NIF>
</sum1:IDEmisorFactura>
<sum1:NumSerieFacturaEmisor>00001</sum1:NumSerieFacturaEmisor>
<sum1:FechaExpedicionFacturaEmisor>01-01-2017</sum1:FechaExpedicionFacturaEmisor>
</sum:IDFactura>
<sum:Contraparte>
<sum1:NombreRazon>EMPRESAXXX</sum1:NombreRazon>
<sum1:NIF>A84532501</sum1:NIF>
</sum:Contraparte>
<sum:OperacionIntracomunitaria>
<sum1:TipoOperacion>A</sum1:TipoOperacion>
<sum1:ClaveDeclarado>D</sum1:ClaveDeclarado>
<sum1:EstadoMiembro>FR</sum1:EstadoMiembro>
<sum1:DescripcionBienes>Descripcion</sum1:DescripcionBienes>
<sum1:DireccionOperador>Direccion</sum1:DireccionOperador>
</sum:OperacionIntracomunitaria>
</sum:RegistroLRDetOperacionIntracomunitaria>
</sum:SuministroLRDetOperacionIntracomunitaria>
</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_cobros_metalico ();//8.1. Operativa: Alta de una factura 
//8.1.5. Alta de Cobros en metálico
//La información para estas operaciones se va a agrupar respecto de cada persona o entidad (contraparte) 
//con la que hubieran efectuados las operaciones
//8.1.5.1.Ejemplo mensaje XML de alta
 
//XML de entrada: 
/*	
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRCobrosMetalico>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAYYYYY</sii:NombreRazon>
<sii:NIF>N0041746I</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRCobrosMetalico>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2017</sii:Ejercicio>
<sii:Periodo>0A</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:Contraparte>
<sii:NombreRazon>EMPRESAXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</siiLR:Contraparte>
<siiLR:ImporteTotal>6130.56</siiLR:ImporteTotal>
</siiLR:RegistroLRCobrosMetalico>
</siiLR:SuministroLRCobrosMetalico>
</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_facturas_simplificadas ();//8.1. Operativa: Alta de una factura 
//8.1.7. Alta de asientos resumen de facturas simplificadas
//8.1.7.1.Ejemplo mensaje XML de alta de asiento resumen
//<NumSerieFacturaEmisor>: Contiene el Nº Serie+Nº Factura de la primera factura del asiento resumen
//<NumSerieFacturaEmisorResumenFin>: Contiene el Nº Serie+Nº Factura de la factura final del asiento resumen
 
//XML de entrada: 
/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRFacturasEmitidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2015</sii:Ejercicio>
<sii:Periodo>01</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>00001</sii:NumSerieFacturaEmisor>
<sii:NumSerieFacturaEmisorResumenFin>00100</sii:NumSerieFacturaEmisorResumenFin>
<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
<siiLR:FacturaExpedida>
<sii:TipoFactura>F4</sii:TipoFactura>
<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
<sii:DescripcionOperacion>Factura</sii:DescripcionOperacion>
<sii:TipoDesglose>
<sii:DesgloseFactura>
<sii:Sujeta>
<sii:NoExenta>
<sii:TipoNoExenta>S2</sii:TipoNoExenta>
<sii:DesgloseIVA>
<sii:DetalleIVA>
<sii:TipoImpositivo>21</sii:TipoImpositivo>
<sii:BaseImponible>118.5</sii:BaseImponible>
<sii:CuotaRepercutida>31.5</sii:CuotaRepercutida>
<sii:TipoRecargoEquivalencia>0</sii:TipoRecargoEquivalencia>
<sii:CuotaRecargoEquivalencia>0</sii:CuotaRecargoEquivalencia>
</sii:DetalleIVA>
</sii:DesgloseIVA>
</sii:NoExenta>
</sii:Sujeta>
</sii:DesgloseFactura>
</sii:TipoDesglose>
</siiLR:FacturaExpedida>
</siiLR:RegistroLRFacturasEmitidas>
</siiLR:SuministroLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/

end subroutine

public subroutine sii_alta_factura_rectificativa_sustituci ();//8.1. Operativa: Alta de una factura 
//8.1.8. Alta Factura Rectificativa por sustitución “S” en el Libro de registro Facturas Expedidas

//Cuando la rectificación se haga por “sustitución” se deberá informar de la rectificación efectuada señalando igualmente el importe de dicha
//rectificación. Esta información se podrá realizar:
//- Opción 1: Informando de un nuevo registro en el que se indiquen los importes correctos tras la rectificación en los campos “base imponible”,
//“cuota” y en su caso “recargo” y a su vez de los importes rectificados respecto de la factura original en los campos “base rectificada”, “cuota
//rectificada” y en su caso “recargo rectificado”.
//- Opción 2: Informando de un nuevo registro en el que se indiquen los importes correctos tras la rectificación en los campos “base imponible”,
//“cuota” y en su caso “recargo” y de otro registro en el que se informe de los importes rectificados.
//8.1.8.1.Ejemplo mensaje XML de alta de factura rectificativa por sustitución “Opción 1”
 
//Ejemplo: La factura nº1 de base imponible 1.000 € y cuota 210 € va a ser objeto de rectificación.
//OPCIÓN 1: La modificación por sustitución supondría emitir una factura rectificativa con base imponible de 800 € y cuota 168, en la que se indicará que la rectificación
//realizada es de 1000 € por la base imponible rectificada y 210 € por la cuota rectificada.
//- Se informará de dos campos adicionales con "la base rectificada" (1.000) y la "cuota rectificada" (210), con independencia de su signo.
//- Importe total: se indicará el importe final válido 968.
//- Desglose IVA: base imponible: 800, cuota repercutida 168. 
 
//XML de entrada: 
/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRFacturasEmitidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2015</sii:Ejercicio>
<sii:Periodo>03</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>0000000000025</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>15-04-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
<siiLR:FacturaExpedida>
<sii:TipoFactura>R1</sii:TipoFactura>
<sii:TipoRectificativa>S</sii:TipoRectificativa>
<sii:ImporteRectificacion>
<sii:BaseRectificada>1000</sii:BaseRectificada>
<sii:CuotaRectificada>210</sii:CuotaRectificada>
</sii:ImporteRectificacion>
<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
<sii:ImporteTotal>968</sii:ImporteTotal>
<sii:DescripcionOperacion>Objeto FACTURA</sii:DescripcionOperacion>
<sii:EmitidaPorTerceros>S</sii:EmitidaPorTerceros>
<sii:Contraparte>
<sii:NombreRazon>EMPRESAYYYYYYYY</sii:NombreRazon>
<sii:NIF>94234500B</sii:NIF>
</sii:Contraparte>
<sii:TipoDesglose>
<sii:DesgloseFactura>
<sii:Sujeta>
<sii:NoExenta>
<sii:TipoNoExenta>S2</sii:TipoNoExenta>
<sii:DesgloseIVA>
<sii:DetalleIVA>
<sii:TipoImpositivo>21</sii:TipoImpositivo>
<sii:BaseImponible>800</sii:BaseImponible>
<sii:CuotaRepercutida>168</sii:CuotaRepercutida>
</sii:DetalleIVA>
</sii:DesgloseIVA>
</sii:NoExenta>
</sii:Sujeta>
</sii:DesgloseFactura>
</sii:TipoDesglose>
</siiLR:FacturaExpedida>
</siiLR:RegistroLRFacturasEmitidas>
</siiLR:SuministroLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/

//8.1.8.2.Ejemplo mensaje XML de alta de factura rectificativa por sustitución “Opción 2”
//OPCIÓN 2: La modificación por sustitución supondría emitir dos facturas: una factura con base imponible de -1000 € y una factura rectificativa en la que se indicará que
//la base imponible es de 800 €.
//En la primera factura los campos y claves a consignar en el Libro registro de Facturas Expedidas son:
//- Tipo Comunicación: A0
//- Tipo Factura: F1
//- Desglose IVA: se indicará el importe que se rectifica (base imponible: (-1.000), cuota repercutida (-210).)
//-
//XML de entrada de la primera factura

/*
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRFacturasEmitidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2015</sii:Ejercicio>
<sii:Periodo>01</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>01</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
<siiLR:FacturaExpedida>
<sii:TipoFactura>F1</sii:TipoFactura>
<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
<sii:ImporteTotal>-1210</sii:ImporteTotal>
<sii:DescripcionOperacion>CompraXXXXXXX</sii:DescripcionOperacion>
<sii:Contraparte>
<sii:NombreRazon>EMPRESAYYYYYYYY</sii:NombreRazon>
<sii:NIF>94234500B</sii:NIF>
</sii:Contraparte>
<sii:TipoDesglose>
<sii:DesgloseFactura>
<sii:Sujeta>
<sii:NoExenta>
<sii:TipoNoExenta>S1</sii:TipoNoExenta>
<sii:DesgloseIVA>
<sii:DetalleIVA>
<sii:TipoImpositivo>21</sii:TipoImpositivo>
<sii:BaseImponible>-1000</sii:BaseImponible>
<sii:CuotaRepercutida>-210</sii:CuotaRepercutida>
</sii:DetalleIVA>
</sii:DesgloseIVA>
</sii:NoExenta>
</sii:Sujeta>
</sii:DesgloseFactura>
</sii:TipoDesglose>
</siiLR:FacturaExpedida>
</siiLR:RegistroLRFacturasEmitidas>
</siiLR:SuministroLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/

//En la segunda de las facturas los campos y claves a consignar en el Libro registro de Facturas Expedidas son:
//- Tipo Comunicación: A0
//- Tipo Factura: Rx
//- Tipo Rectificativa: S
//- Importe Rectificación: se informará de dos campos adicionales con “la base rectificada” 0 y la “cuota rectificada” 0.
//- Importe total: se indicará el importe final válido 968
//- Desglose IVA: base imponible: 800, cuota repercutida 168
//XML de entrada de la segunda factura:

/*
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRFacturasEmitidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2015</sii:Ejercicio>
<sii:Periodo>01</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>0000000000030</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>20-01-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
<siiLR:FacturaExpedida>
<sii:TipoFactura>R1</sii:TipoFactura>
<sii:TipoRectificativa>S</sii:TipoRectificativa>
<sii:ImporteRectificacion>
<sii:BaseRectificada>0</sii:BaseRectificada>
<sii:CuotaRectificada>0</sii:CuotaRectificada>
</sii:ImporteRectificacion>
<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
<sii:ImporteTotal>968</sii:ImporteTotal>
<sii:DescripcionOperacion>Objeto FACTURA</sii:DescripcionOperacion>
<sii:EmitidaPorTerceros>S</sii:EmitidaPorTerceros>
<sii:Contraparte>
<sii:NombreRazon>EMPRESAYYYYYYYY</sii:NombreRazon>
<sii:NIF>94234500B</sii:NIF>
</sii:Contraparte>
<sii:TipoDesglose>
<sii:DesgloseFactura>
<sii:Sujeta>
<sii:NoExenta>
<sii:TipoNoExenta>S1</sii:TipoNoExenta>
<sii:DesgloseIVA>
<sii:DetalleIVA>
<sii:TipoImpositivo>21</sii:TipoImpositivo>
<sii:BaseImponible>800</sii:BaseImponible>
<sii:CuotaRepercutida>168</sii:CuotaRepercutida>
</sii:DetalleIVA>
</sii:DesgloseIVA>
</sii:NoExenta>
</sii:Sujeta>
</sii:DesgloseFactura>
</sii:TipoDesglose>
</siiLR:FacturaExpedida>
</siiLR:RegistroLRFacturasEmitidas>
</siiLR:SuministroLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/
end subroutine

public subroutine sii_alta_factura_rectificativa_diferenci ();//8.1. Operativa: Alta de una factura 
//8.1.9. Alta Factura Rectificativa por diferencias “I” en el Libro de registro de Facturas Expedidas

//El registro de esta rectificación por “diferencias” se realizará informando con un ALTA de una nueva factura e informando en el campo de tipo
//de factura de que se trata de una “factura rectificativa” y en el campo tipo de factura rectificativa de que es “por diferencia”. En este caso no se
//debe rellenar los importes sustituidos en los campos de la “base rectificada” y “cuota rectificada” que sí son exigibles al informar de una
//rectificación por sustitución. Opcional identificar las facturas rectificadas.
//8.1.9.1.Ejemplo mensaje XML de alta de factura rectificativa por diferencias
//Ejemplo operativa:
//La factura nº1 de base imponible 1.000 € y cuota 210 € va a ser objeto de rectificación.
//La modificación por diferencias supondría emitir una factura con base imponible de -200 €.
//Los campos y claves a consignar en el Libro registro de Facturas Expedidas son:
//- Tipo Comunicación: A0
//- Tipo Factura: Rx
//- Tipo Rectificativa: I
//- Importe total: se indicará el importe total de la rectificación -242.
//- Desglose IVA: base imponible: -200, cuota repercutida – 42.
//XML de entrada

/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:SuministroLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>XXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
<sii:TipoComunicacion>A0</sii:TipoComunicacion>
</sii:Cabecera>
<siiLR:RegistroLRFacturasEmitidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2015</sii:Ejercicio>
<sii:Periodo>03</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>000000000000000000300000000002000000000000000000000000000026</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>15-02-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
<siiLR:FacturaExpedida>
<sii:TipoFactura>R2</sii:TipoFactura>
<sii:TipoRectificativa>I</sii:TipoRectificativa>
<sii:FacturasRectificadas>
<sii:IDFacturaRectificada>
<sii:NumSerieFacturaEmisor>00000000000000000000000500002000000000000000000000000000014</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>01-03-2015</sii:FechaExpedicionFacturaEmisor>
</sii:IDFacturaRectificada>
</sii:FacturasRectificadas>
<sii:ClaveRegimenEspecialOTrascendencia>05</sii:ClaveRegimenEspecialOTrascendencia>
<sii:ImporteTotal>-242</sii:ImporteTotal>
<sii:DescripcionOperacion>Objeto FACTURA</sii:DescripcionOperacion>
<sii:EmitidaPorTerceros>N</sii:EmitidaPorTerceros>
<sii:Contraparte>
<sii:NombreRazon>YYY</sii:NombreRazon>
<sii:NIF>A84532502</sii:NIF>
</sii:Contraparte>
<sii:TipoDesglose>
<sii:DesgloseFactura>
<sii:Sujeta>
<sii:NoExenta>
<sii:TipoNoExenta>S2</sii:TipoNoExenta>
<sii:DesgloseIVA>
<sii:DetalleIVA>
<sii:TipoImpositivo>21</sii:TipoImpositivo>
<sii:BaseImponible>-200</sii:BaseImponible>
<sii:CuotaRepercutida>-42</sii:CuotaRepercutida>
</sii:DetalleIVA>
</sii:DesgloseIVA>
</sii:NoExenta>
</sii:Sujeta>
</sii:DesgloseFactura>
</sii:TipoDesglose>
</siiLR:FacturaExpedida>
</siiLR:RegistroLRFacturasEmitidas>
</siiLR:SuministroLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/
end subroutine

public subroutine sii_baja_factura ();//8.1. Operativa: Alta de una factura 
//8.1.10. Baja de una Factura enviada anteriormente que no procede
//En la baja de una factura deberá informarse el ejercicio y periodo de la baja.

//8.1.10.1.Ejemplo mensaje XML de baja de una factura

//XML de entrada

/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd"
xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
<soapenv:Header/>
<soapenv:Body>
<siiLR:BajaLRFacturasEmitidas>
<sii:Cabecera>
<sii:IDVersionSii>0.6</sii:IDVersionSii>
<sii:Titular>
<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
<sii:NIF>A84532501</sii:NIF>
</sii:Titular>
</sii:Cabecera>
<siiLR:RegistroLRBajaExpedidas>
<sii:PeriodoImpositivo>
<sii:Ejercicio>2016</sii:Ejercicio>
<sii:Periodo>10</sii:Periodo>
</sii:PeriodoImpositivo>
<siiLR:IDFactura>
<sii:IDEmisorFactura>
<sii:NIF>A84532501</sii:NIF>
</sii:IDEmisorFactura>
<sii:NumSerieFacturaEmisor>000000000000000000000000000001000000000000000000000000000001</sii:NumSerieFacturaEmisor>
<sii:FechaExpedicionFacturaEmisor>08-05-2015</sii:FechaExpedicionFacturaEmisor>
</siiLR:IDFactura>
</siiLR:RegistroLRBajaExpedidas>
</siiLR:BajaLRFacturasEmitidas>
</soapenv:Body>
</soapenv:Envelope>
*/
end subroutine

public subroutine sii_libro_registro_expedidas ();//string IDVersionSii,Titular_NombreRazon,Titular_Nif,TipoComunicacion
//int    PeriodoImpositivo_Ejercicio
//string PeriodImpositivo_Periodo,IDFactura_IDEmisorFactura_NIF,IDFactura_NumSerieFacturaEmisor,IDFactura_NumSerieFacturaEmisorResumenFin
//date   IDFactura_FechaExpedicionFacuraEmisor
//string FacturaExpedida_TipoFactura,FacturaExpedida_TipoRectificativa
//string IDFacturaAgrupada_NumSerieFacturaEmisor,
//date   IDFacturaAgrupada_FechaExpedicionFacturaEmisor
//string IDFacturaRectificada_NumSerieFacturaEmisor
//date   IDFacturaRectificada_FechaExpedicionFacturaEmisor
//dec(2) ImporteRectificacion_BaseRectificada,ImporteRectificacion_CuotaRectificada,ImporteRectificacion_CuotaRecargoRectificado
//date   FacturaExpedida_FechaOperacion
//string FacturaExpedida_CaveRegimenEspecialOTrascendencia
//
//
end subroutine

public function long f_sii_facturas_expedidas ();long     ll_registros,ll_row
datetime ldt_fecha_alta
string   ls_nombre_fichero = "FACTURAS_EXPEDIDAS",ls_sufijo_fichero,ls_ruta,ls_fichero
string   ls_linea
int      li_resultado

datastore lds_fichero_xml

f_cargar_cursor_transaccion(sqlca,lds_fichero_xml,'select space(500) as linea from empresas where 0 = 1')

//
ls_linea = '<?xml version="1.0" encoding="UTF-8"?>'
ll_row = lds_fichero_xml.InsertRow(0) 
lds_fichero_xml.Object.linea[ll_row] = ls_linea 

ls_linea = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">'
ll_row = lds_fichero_xml.InsertRow(0) 
lds_fichero_xml.Object.linea[ll_row] = ls_linea 

	ls_linea = '<soapenv:Header/>'
	ll_row = lds_fichero_xml.InsertRow(0) 
	lds_fichero_xml.Object.linea[ll_row] = ls_linea 

	ls_linea = '<soapenv:Body>'
	ll_row = lds_fichero_xml.InsertRow(0) 
	lds_fichero_xml.Object.linea[ll_row] = ls_linea 
		
		ls_linea = '<siiLR:SuministroLRFacturasEmitidas>'
		ll_row = lds_fichero_xml.InsertRow(0) 
		lds_fichero_xml.Object.linea[ll_row] = ls_linea 	
	
			ls_linea = '<sii:Cabecera>'
			ll_row = lds_fichero_xml.InsertRow(0) 
			lds_fichero_xml.Object.linea[ll_row] = ls_linea 		
			
				ls_linea = '<sii:IDVersionSii>0.6</sii:IDVersionSii>'
				ll_row = lds_fichero_xml.InsertRow(0) 
				lds_fichero_xml.Object.linea[ll_row] = ls_linea 			
				
				ls_linea = '<sii:Titular>'
				ll_row = lds_fichero_xml.InsertRow(0) 
				lds_fichero_xml.Object.linea[ll_row] = ls_linea 		
				
					ls_linea = '<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>'
					ll_row = lds_fichero_xml.InsertRow(0) 
					lds_fichero_xml.Object.linea[ll_row] = ls_linea 	
					
					ls_linea = '<sii:NIF>A84532501</sii:NIF>'
					ll_row = lds_fichero_xml.InsertRow(0) 
					lds_fichero_xml.Object.linea[ll_row] = ls_linea 							
				
				ls_linea = '/<sii:Titular>'
				ll_row = lds_fichero_xml.InsertRow(0) 
				lds_fichero_xml.Object.linea[ll_row] = ls_linea 	
				
				ls_linea = '<sii:TipoComunicacion>A0</sii:TipoComunicacion>'
				ll_row = lds_fichero_xml.InsertRow(0) 
				lds_fichero_xml.Object.linea[ll_row] = ls_linea 					
			
			ls_linea = '</sii:Cabecera>'
			ll_row = lds_fichero_xml.InsertRow(0) 
			lds_fichero_xml.Object.linea[ll_row] = ls_linea 					
		
			ls_linea = '<siiLR:RegistroLRFacturasEmitidas>'
			ll_row = lds_fichero_xml.InsertRow(0) 
			lds_fichero_xml.Object.linea[ll_row] = ls_linea 			
			
			//*
			ls_linea = ''
			ll_row = lds_fichero_xml.InsertRow(0) 
			lds_fichero_xml.Object.linea[ll_row] = ls_linea 						
			
			
			ls_linea = '</siiLR:RegistroLRFacturasEmitidas>'
			ll_row = lds_fichero_xml.InsertRow(0) 
			lds_fichero_xml.Object.linea[ll_row] = ls_linea 								
			
		ls_linea = '</siiLR:SuministroLRFacturasEmitidas>'
		ll_row = lds_fichero_xml.InsertRow(0) 
		lds_fichero_xml.Object.linea[ll_row] = ls_linea 			
	
	ls_linea = '</soapenv:Body>'
	ll_row = lds_fichero_xml.InsertRow(0) 
	lds_fichero_xml.Object.linea[ll_row] = ls_linea 	

ls_linea = '</soapenv:Envelope>'
ll_row = lds_fichero_xml.InsertRow(0) 
lds_fichero_xml.Object.linea[ll_row] = ls_linea 

/*	
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">
	<soapenv:Header/>
	<soapenv:Body>
		<siiLR:SuministroLRFacturasEmitidas>
			<sii:Cabecera>
				<sii:IDVersionSii>0.6</sii:IDVersionSii>
				<sii:Titular>
					<sii:NombreRazon>EMPRESAXXXX</sii:NombreRazon>
					<sii:NIF>A84532501</sii:NIF>
				</sii:Titular>
				<sii:TipoComunicacion>A0</sii:TipoComunicacion>
			</sii:Cabecera>
			<siiLR:RegistroLRFacturasEmitidas>
				<sii:PeriodoImpositivo>
					<sii:Ejercicio>2015</sii:Ejercicio>
					<sii:Periodo>01</sii:Periodo>
				</sii:PeriodoImpositivo>
				<siiLR:IDFactura>
					<sii:IDEmisorFactura>
						<sii:NIF>A84532501</sii:NIF>
					</sii:IDEmisorFactura>
					<sii:NumSerieFacturaEmisor>01</sii:NumSerieFacturaEmisor>
					<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
				</siiLR:IDFactura>
				<siiLR:FacturaExpedida>
					<sii:TipoFactura>F1</sii:TipoFactura>
					<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia>
					<sii:ImporteTotal>26.70</sii:ImporteTotal>
					<sii:DescripcionOperacion>CompraXXXXXXX</sii:DescripcionOperacion>
					<sii:Contraparte>
						<sii:NombreRazon>EMPRESAYYYYYYYY</sii:NombreRazon>
						<sii:NIF>94234500B</sii:NIF>
					</sii:Contraparte>
					<sii:TipoDesglose>
						<sii:DesgloseFactura>
							<sii:Sujeta>
								<sii:NoExenta>
									<sii:TipoNoExenta>S1</sii:TipoNoExenta>
									<sii:DesgloseIVA>
										<sii:DetalleIVA>
											<sii:TipoImpositivo>21</sii:TipoImpositivo>
											<sii:BaseImponible>22.07</sii:BaseImponible>
											<sii:CuotaRepercutida>4.63</sii:CuotaRepercutida>
											<sii:TipoRecargoEquivalencia>0</sii:TipoRecargoEquivalencia>
											<sii:CuotaRecargoEquivalencia>0</sii:CuotaRecargoEquivalencia>
										</sii:DetalleIVA>
									</sii:DesgloseIVA>
								</sii:NoExenta>
							</sii:Sujeta>
						</sii:DesgloseFactura>
					</sii:TipoDesglose>
				</siiLR:FacturaExpedida>
			</siiLR:RegistroLRFacturasEmitidas>
			<siiLR:RegistroLRFacturasEmitidas>
				<sii:PeriodoImpositivo>
					<sii:Ejercicio>2015</sii:Ejercicio>
					<sii:Periodo>05</sii:Periodo>
				</sii:PeriodoImpositivo>
				<siiLR:IDFactura>
					<sii:IDEmisorFactura>
						<sii:NIF>A84532501</sii:NIF>
					</sii:IDEmisorFactura>
					<sii:NumSerieFacturaEmisor>02</sii:NumSerieFacturaEmisor>
					<sii:FechaExpedicionFacturaEmisor>15-01-2015</sii:FechaExpedicionFacturaEmisor>
				</siiLR:IDFactura>
				<siiLR:FacturaExpedida>
					<sii:TipoFactura>F2</sii:TipoFactura>
					<sii:ClaveRegimenEspecialOTrascendencia>08</sii:ClaveRegimenEspecialOTrascendencia>
					<sii:ImporteTotal>50</sii:ImporteTotal>
					<sii:DescripcionOperacion>CompraYYYYYYYYYYYYYYYYYYYYY</sii:DescripcionOperacion>
					<sii:EmitidaPorTerceros>S</sii:EmitidaPorTerceros>
					<sii:TipoDesglose>
						<sii:DesgloseFactura>
							<sii:Sujeta>
								<sii:Exenta>
									<sii:CausaExencion>E4</sii:CausaExencion>
									<sii:BaseImponible>50</sii:BaseImponible>
								</sii:Exenta>
							</sii:Sujeta>
						</sii:DesgloseFactura>
					</sii:TipoDesglose>
				</siiLR:FacturaExpedida>
			</siiLR:RegistroLRFacturasEmitidas>
		</siiLR:SuministroLRFacturasEmitidas>
	</soapenv:Body>
</soapenv:Envelope>
*/

//Grabar el fichero
ldt_fecha_alta = datetime(today(),now())

ls_sufijo_fichero = ""
ls_sufijo_fichero += string(year(date(ldt_fecha_alta)),"0000")
ls_sufijo_fichero += string(month(date(ldt_fecha_alta)),"00")
ls_sufijo_fichero += string(day(date(ldt_fecha_alta)),"00")
ls_sufijo_fichero += string(hour(time(ldt_fecha_alta)),"00")
ls_sufijo_fichero += string(minute(time(ldt_fecha_alta)),"00")
ls_sufijo_fichero += string(second(time(ldt_fecha_alta)),"00")	

//ls_ruta = ls_nombre_fichero+ls_sufijo_fichero+".XML"
//ls_ruta = 
////if GetFileSaveName("Fichero 19 XML",ls_ruta,ls_fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
//	if ll_registros > 0 then
//		li_resultado = lds_fichero_xml.saveas(ls_ruta,text!,false)
//		
//		if li_resiltado = 1 then
//			ScriptConversion.vbs
//			ls_run = 'wscript.exe "ScriptConversion.vbs" "'+ls_ruta+'" "'+ls_ruta+'"'
//		end if
////		if li_resultado = -1 then messagebox("ERROR","Al grabar el fichero")
////		if li_resultado = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + ls_fichero )
//	end if		
////end if	

//if b_error then
//	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : "  )
//else
//	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : "+nombre_fichero  )
//end if 

destroy lds_fichero_xml

return ll_registros
end function

public subroutine f_cargar_cuentas_fras_recibidas ();string ls_sel
datetime ldt_fecha_desde,ldt_fecha_hasta

ldt_fecha_desde = datetime(date(em_fecha_desde.text))
ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))

ls_sel =   "select isnull(apuntes_factura.empresa,'') as empresa, "+&
			  "		 isnull(apuntes_factura.clipro,'') as proveedor, "+&
			  "		 isnull(apuntes_factura.factura,'') as factura, "+&
			  "		 isnull(apuntes_factura.ffactura,apuntes_factura.ffactura) as ffactura, "+&
			  "		 apuntes_factura.base_imponible_factura, "+&
			  "		 substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+") as cuenta, "+&
			  "       isnull(contaplan.titulo,'') as titulo_cuenta, "+&
			  "		 sum(contaapun.debe - contaapun.haber) as importe_cuenta "+&
			  "from   contaapun, "+&
			  "		(  select contaapun.ejercicio as ejercicio, "+&
			  "					 contaapun.empresa as empresa, "+&
			  "					 contaapun.asiento as asiento, "+&
			  "					 contaapun.origen as origen, "+&
			  "					 contaapun.mes as mes, "+&
			  "					 contaapun.tipoter as tipoter, "+&
			  "					 contaapun.clipro as clipro, "+&
			  "					 isnull(genter.cuenta,'') as cuenta_proveedor, "+&
			  "					 contaapun.factura as factura, "+&
			  "					 contaapun.ffactura as ffactura, "+&
			  "					 sum(contaapun.imponible) as base_imponible_factura "+&
			  "			from   contaapun, "+&
			  "					 genter "+&
			  "			where  contaapun.empresa = genter.empresa "+&
			  "			and    contaapun.tipoter = genter.tipoter "+&
			  "			and    contaapun.clipro  = genter.codigo "+&
			  "			and    contaapun.empresa = '"+codigo_empresa+"' "+&
			  "			and    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' and '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
			  "			and    isnull(contaapun.tipoapu,'') in (select contalibros.codigo "+&
			  "																 from   contalibros "+&
			  "																 where  contalibros.empresa   = contaapun.empresa "+&
			  "																 and    contalibros.tipo      = 'C' "+&
			  "																 and    contalibros.ejercicio = contaapun.ejercicio) "+&
			  "			group by contaapun.ejercicio, "+&
			  "					 contaapun.empresa, "+&
			  "					 contaapun.asiento, "+&
			  "					 contaapun.origen, "+&
			  "					 contaapun.mes, "+&
			  "					 contaapun.tipoter, "+&
			  "					 contaapun.clipro, "+&
			  "					 isnull(genter.cuenta,''), "+&
			  "					 contaapun.factura, "+&
			  "					 contaapun.ffactura ) as apuntes_factura, "+&
			  "		contaplan "+&
			  "where contaapun.ejercicio = apuntes_factura.ejercicio "+&
			  "and	contaapun.empresa   = apuntes_factura.empresa "+&
			  "and	contaapun.asiento   = apuntes_factura.asiento "+&
			  "and	contaapun.origen    = apuntes_factura.origen "+&
			  "and	contaapun.mes       = apuntes_factura.mes "+&
			  "and   contaapun.ejercicio = contaplan.ejercicio "+&
			  "and   contaapun.empresa   = contaplan.empresa "+&
			  "and   substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+") = contaplan.cuenta "+&
			  "and ( contaapun.cuenta not like '400%' and contaapun.cuenta not like '410%' and contaapun.cuenta not like '523%' and contaapun.cuenta not like '173%' )  "+&
			  "and   isnull(contaapun.tipoapu,'') = '' "+&
			  "group by apuntes_factura.empresa, "+&
			  "			apuntes_factura.clipro, "+&
			  "			apuntes_factura.factura, "+&
			  "			apuntes_factura.ffactura, "+&
			  "			substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+"), "+&
			  "         contaplan.titulo, "+&
 			  "			apuntes_factura.base_imponible_factura "+&		
			  "order by apuntes_factura.empresa, "+&
			  "			apuntes_factura.clipro, "+&
			  "			apuntes_factura.factura, "+&
			  "			apuntes_factura.ffactura, "+&
			  "			substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+"), "+&
			  "         contaplan.titulo "

f_cargar_cursor_transaccion(sqlca,ids_cuentas_fras_recibidas,ls_sel)
end subroutine

public subroutine f_cargar_cuentas_fras_emitidas ();string ls_sel
datetime ldt_fecha_desde,ldt_fecha_hasta

ldt_fecha_desde = datetime(date(em_fecha_desde.text))
ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))

ls_sel =   "select isnull(apuntes_factura.empresa,'') as empresa, "+&
			  "		 isnull(apuntes_factura.clipro,'') as cliente, "+&
			  "		 isnull(apuntes_factura.factura,'') as factura, "+&
			  "		 isnull(apuntes_factura.ffactura,apuntes_factura.ffactura) as ffactura, "+&
			  "		 apuntes_factura.base_imponible_factura, "+&
			  "		 substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+") as cuenta, "+&
			  "       isnull(contaplan.titulo,'') as titulo_cuenta, "+&
			  "		 sum(contaapun.debe - contaapun.haber) as importe_cuenta "+&
			  "from   contaapun, "+&
			  "		(  select contaapun.ejercicio as ejercicio, "+&
			  "					 contaapun.empresa as empresa, "+&
			  "					 contaapun.asiento as asiento, "+&
			  "					 contaapun.origen as origen, "+&
			  "					 contaapun.mes as mes, "+&
			  "					 contaapun.tipoter as tipoter, "+&
			  "					 contaapun.clipro as clipro, "+&
			  "					 genter.cuenta as cuenta_proveedor, "+&
			  "					 contaapun.factura as factura, "+&
			  "					 contaapun.ffactura as ffactura, "+&
			  "					 sum(contaapun.imponible) as base_imponible_factura "+&
			  "			from   contaapun, "+&
			  "					 genter "+&
			  "			where  contaapun.empresa = genter.empresa "+&
			  "			and    contaapun.tipoter = genter.tipoter "+&
			  "			and    contaapun.clipro  = genter.codigo "+&
			  "			and    contaapun.empresa = '"+codigo_empresa+"' "+&
			  "			and    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' and '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
			  "			and    isnull(contaapun.tipoapu,'') in (select contalibros.codigo "+&
			  "																 from   contalibros "+&
			  "																 where  contalibros.empresa   = contaapun.empresa "+&
			  "																 and    contalibros.tipo      = 'V' "+&
			  "																 and    contalibros.ejercicio = contaapun.ejercicio) "+&
			  "			group by contaapun.ejercicio, "+&
			  "					 contaapun.empresa, "+&
			  "					 contaapun.asiento, "+&
			  "					 contaapun.origen, "+&
			  "					 contaapun.mes, "+&
			  "					 contaapun.tipoter, "+&
			  "					 contaapun.clipro, "+&
			  "					 genter.cuenta, "+&
			  "					 contaapun.factura, "+&
			  "					 contaapun.ffactura ) as apuntes_factura, "+&
			  "		contaplan "+&
			  "where contaapun.ejercicio = apuntes_factura.ejercicio "+&
			  "and	contaapun.empresa   = apuntes_factura.empresa "+&
			  "and	contaapun.asiento   = apuntes_factura.asiento "+&
			  "and	contaapun.origen    = apuntes_factura.origen "+&
			  "and	contaapun.mes       = apuntes_factura.mes "+&
			  "and   contaapun.ejercicio = contaplan.ejercicio "+&
			  "and   contaapun.empresa   = contaplan.empresa "+&
			  "and   substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+") = contaplan.cuenta "+&
			  "and	contaapun.cuenta   <> apuntes_factura.cuenta_proveedor "+&
			  "and   isnull(contaapun.tipoapu,'') = '' "+&
			  "group by apuntes_factura.empresa, "+&
			  "			apuntes_factura.clipro, "+&
			  "			apuntes_factura.factura, "+&
			  "			apuntes_factura.ffactura, "+&
			  "			substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+"), "+&
			  "         contaplan.titulo, "+&
 			  "			apuntes_factura.base_imponible_factura "+&		
			  "order by apuntes_factura.empresa, "+&
			  "			apuntes_factura.clipro, "+&
			  "			apuntes_factura.factura, "+&
			  "			apuntes_factura.ffactura, "+&
			  "			substring(contaapun.cuenta,1,"+string(istr_contasii_parametros.digitos_descripcion_operacion,"#0")+"), "+&
			  "         contaplan.titulo "

f_cargar_cursor_transaccion(sqlca,ids_cuentas_fras_emitidas,ls_sel)
end subroutine

public function string f_descripcion_operacion_factura_emitida (string arg_empresa, string arg_cliente, string arg_factura, datetime arg_ffactura);int li_indice,li_total
string ls_filtro
string ls_descripcion_operacion

ls_filtro = "empresa = '"+arg_empresa+"' and "+&
				"cliente = '"+arg_cliente+"' and "+&
				"factura = '"+arg_factura+"' "//and "+&
				//"string(ffactura,'dd-mm-yyyy') = '"+string(arg_ffactura,'dd-mm-yyyy')+"'"
				
ids_cuentas_fras_emitidas.setfilter(ls_filtro)
ids_cuentas_fras_emitidas.filter()

li_total = ids_cuentas_fras_emitidas.rowcount()

for li_indice = 1 to li_total
	if li_indice = 1 then
		ls_descripcion_operacion = ids_cuentas_fras_emitidas.object.titulo_cuenta[li_indice]
	else
		ls_descripcion_operacion += ","+ids_cuentas_fras_emitidas.object.titulo_cuenta[li_indice]
	end if
next

ls_descripcion_operacion = upper(ls_descripcion_operacion)

if trim(ls_descripcion_operacion) = "" then ls_descripcion_operacion = "MUESTRAS"

return ls_descripcion_operacion
end function

public function string f_descripcion_operacion_factura_recibida (string arg_empresa, string arg_proveedor, string arg_factura, datetime arg_ffactura);int li_indice,li_total
string ls_filtro
string ls_descripcion_operacion

ls_filtro = "empresa = '"+arg_empresa+"' and "+&
				"proveedor = '"+arg_proveedor+"' and "+&
				"factura = '"+arg_factura+"' "//and "+&
				//"ffactura = date('"+string(arg_ffactura,'dd-mm-yyyy')+"')"
				
ids_cuentas_fras_recibidas.setfilter(ls_filtro)
ids_cuentas_fras_recibidas.filter()

li_total = ids_cuentas_fras_recibidas.rowcount()

for li_indice = 1 to li_total
	if li_indice = 1 then
		ls_descripcion_operacion = ids_cuentas_fras_recibidas.object.titulo_cuenta[li_indice]
	else
		ls_descripcion_operacion += ","+ids_cuentas_fras_recibidas.object.titulo_cuenta[li_indice]
	end if
next

return ls_descripcion_operacion
end function

public subroutine f_cargar_importe_servicios_fras_emitidas ();string ls_sel
datetime ldt_fecha_desde,ldt_fecha_hasta

ldt_fecha_desde = datetime(date(em_fecha_desde.text))
ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))

ls_sel =   "SELECT lineas_factura_cuenta.empresa as empresa, "+&	
			  "		 datepart(yyyy,lineas_factura_cuenta.ffactura) as anyo, "+&	
			  "		 lineas_factura_cuenta.cliente as cliente, "+&	
			  "		 lineas_factura_cuenta.factura as factura, "+&
			  "		 sum(case when lineas_factura_cuenta.cuenta like '"+istr_contasii_parametros.cuenta_prestacion_servicios+"%' then lineas_factura_cuenta.importe else 0 end) as importe_servicios, "+&
			  "		 sum(case when lineas_factura_cuenta.cuenta not like '"+istr_contasii_parametros.cuenta_prestacion_servicios+"%' then lineas_factura_cuenta.importe else 0 end) as importe_no_servicios, "+&
			  "		 sum(lineas_factura_cuenta.importe) as importe_factura, "+&
			  "		 (sum(case when lineas_factura_cuenta.cuenta like '"+istr_contasii_parametros.cuenta_prestacion_servicios+"%' then lineas_factura_cuenta.importe else 0 end) * 100) / sum(lineas_factura_cuenta.importe) as porcentaje_servicios, "+&
			  "		 (sum(case when lineas_factura_cuenta.cuenta not like '"+istr_contasii_parametros.cuenta_prestacion_servicios+"%' then lineas_factura_cuenta.importe else 0 end) * 100) / sum(lineas_factura_cuenta.importe) as porcentaje_no_servicios "+&
			  "FROM  (select apuntes_factura.empresa as empresa, "+&
			  "		 apuntes_factura.clipro as cliente, "+&
			  "		 apuntes_factura.factura as factura, "+&
			  "		 apuntes_factura.ffactura as ffactura, "+&
			  "		 apuntes_factura.base_imponible_factura, "+&
			  "		 contaapun.cuenta as cuenta, "+&
			  "		 sum(contaapun.haber - contaapun.debe) as importe "+&
			  "		 from   contaapun, "+&
			  "		       ( select contaapun.ejercicio as ejercicio, "+&
			  "		                contaapun.empresa as empresa, "+&
			  "		                contaapun.asiento as asiento, "+&
			  "		                contaapun.origen as origen, "+&
			  "		                contaapun.mes as mes, "+&
			  "		                contaapun.tipoter as tipoter, "+&
			  "		                contaapun.clipro as clipro, "+&
			  "		                genter.cuenta as cuenta_cliente, "+&
			  "		                contaapun.factura as factura, "+&
			  "		                contaapun.ffactura as ffactura, "+&
			  "		                sum(contaapun.imponible) as base_imponible_factura "+&
			  "		         from   contaapun, "+&
			  "		                genter "+&
			  "		         where  contaapun.empresa = genter.empresa "+&
			  "		         and    contaapun.tipoter = genter.tipoter "+&
			  "		         and    contaapun.clipro  = genter.codigo "+&
			  "			      and    contaapun.empresa = '"+codigo_empresa+"' "+&
			  "			      and    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' and '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&			  
			  "		         and    isnull(contaapun.tipoapu,'') in (select contalibros.codigo "+&
			  "		                                                 from   contalibros "+&
			  "		                                                 where  contalibros.empresa   = contaapun.empresa "+&
			  "		                                                 and    contalibros.tipo      = 'V' "+&
			  "		                                                 and    contalibros.ejercicio = contaapun.ejercicio) "+&
			  "		         group by contaapun.ejercicio, "+&
			  "		                  contaapun.empresa, "+&
			  "		                  contaapun.asiento, "+&
			  "		                  contaapun.origen, "+&
			  "		                  contaapun.mes, "+&
			  "		                  contaapun.tipoter, "+&
			  "		                  contaapun.clipro, "+&
			  "		                  genter.cuenta, "+&
			  "		                  contaapun.factura, "+&
			  "		                  contaapun.ffactura ) as apuntes_factura "+&
			  "		 where contaapun.ejercicio = apuntes_factura.ejercicio "+&
			  "		 and	contaapun.empresa   = apuntes_factura.empresa "+&
			  "		 and	contaapun.asiento   = apuntes_factura.asiento "+&
			  "		 and	contaapun.origen    = apuntes_factura.origen "+&
			  "		 and	contaapun.mes       = apuntes_factura.mes "+&
			  "		 and	contaapun.cuenta   <> apuntes_factura.cuenta_cliente "+&
			  "		 and   isnull(contaapun.tipoapu,'') = '' "+&
			  "		 group by apuntes_factura.empresa, "+&
			  "		          apuntes_factura.clipro, "+&
			  "		          apuntes_factura.factura, "+&
			  "		          apuntes_factura.ffactura, "+&
			  "		          apuntes_factura.base_imponible_factura, "+&
			  "		          contaapun.cuenta ) as lineas_factura_cuenta "+&
			  "group by lineas_factura_cuenta.empresa, "+&
			  "		   datepart(yyyy,lineas_factura_cuenta.ffactura), "+&
			  "		   lineas_factura_cuenta.cliente, "+&
			  "		   lineas_factura_cuenta.factura "+&
			  "having sum(case when lineas_factura_cuenta.cuenta like '"+istr_contasii_parametros.cuenta_prestacion_servicios+"%' then lineas_factura_cuenta.importe else 0 end) <> 0 "

//clipboard(ls_sel)
//messagebox("",ls_sel)
//
f_cargar_cursor_transaccion(sqlca,ids_importe_servicios_fras_emitidas,ls_sel)
end subroutine

public subroutine f_procesar_facturas_dia (datetime arg_dia);datetime ldt_fecha_desde,ldt_fecha_hasta
long     ll_indice,ll_total,ll_ejercicio,ll_donde,ll_existe_registro,ll_indice_eliminadas,ll_total_eliminadas	
long     ll_indice_tipos_impositivos,ll_total_tipos_impositivos,ll_facturas_dia_sii
string   ls_moneda_empresa,sel,ls_formula_ventas,ls_formula_compras,ls_venfac_serie,ls_sel,ls_filtro
string   ls_tipoiva_recargo,ls_razon,ls_pais
integer  li_decimales_moneda_empresa,li_enviada_correcta
dec{2}   ld_importe_servicios
boolean  lb_correcto  = true

str_contasii_calendario lstr_contasii_calendario

lstr_contasii_calendario.empresa             = codigo_empresa
lstr_contasii_calendario.fecha               = arg_dia
lstr_contasii_calendario.facturas_enviadas   = 0
lstr_contasii_calendario.facturas_recibidas  = 0
lstr_contasii_calendario.bienes_de_inversion = 0
lstr_contasii_calendario.cobros_en_metalico  = 0

datastore ds_tipos_impositivos_factura

str_contasii lstr_contasii
str_contasii_tiposimpositivos lstr_contasii_tiposimpositivos

ls_moneda_empresa           = f_moneda_empresa(codigo_empresa)
li_decimales_moneda_empresa = f_decimales_moneda(ls_moneda_empresa)
	
datastore ds_operaciones
datastore ds_facturas_eliminadas

f_cargar_cuentas_fras_emitidas()
f_cargar_cuentas_fras_recibidas()
f_cargar_importe_servicios_fras_emitidas()

ldt_fecha_desde = arg_dia
ldt_fecha_hasta = arg_dia

ll_ejercicio   = year(date(ldt_fecha_desde))

ls_formula_ventas  = " sum( contaapun.haber - contaapun.debe ) + sum( contaapun.imponible ) "
ls_formula_compras = " sum( contaapun.debe - contaapun.haber ) + sum( contaapun.imponible ) "	
						
Sel = "  SELECT contasii.empresa,"+&
		"		  contasii.tipoter,"+&
		"		  contasii.tercero,"+&
		"		  contasii.ejercicio,"+&
		"		  contasii.factura,"+&
		"		  contasii.fecharegcontable "+&
		" FROM   contasii "+&
		" WHERE  contasii.empresa   = '"+codigo_empresa+"' "+&
		" AND    datepart(yy,contasii.fecharegcontable) = "+string(ll_ejercicio,"####")+" "+&
		" AND    not exists ( SELECT * "+&
		"                    FROM  contaapun "+&
		"                    WHERE contaapun.empresa = contasii.empresa "+&
		"                    AND   contaapun.factura = contasii.factura "+&
		"                    AND   contaapun.tipoter = contasii.tipoter "+&
		"                    AND   contaapun.clipro  = contasii.tercero "+&
		"                    AND   contaapun.fapunte = contasii.fecharegcontable "+&
		"						   AND   contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
		"																 WHERE   contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"																 AND     contaiva.empresa   = '"+codigo_empresa+"' "+&
		"																 AND     contaiva.incluir_en_sii = 'S' ) )"
		
ll_total_eliminadas = f_cargar_cursor_transaccion(sqlca,ds_facturas_eliminadas,sel)		
						
for ll_indice_eliminadas = 1 to ll_total_eliminadas	
	lstr_contasii.empresa              = codigo_empresa
	lstr_contasii.ejercicio            = ds_facturas_eliminadas.object.ejercicio[ll_indice_eliminadas]
	lstr_contasii.factura              = ds_facturas_eliminadas.object.factura[ll_indice_eliminadas]
	lstr_contasii.tipoter              = ds_facturas_eliminadas.object.tipoter[ll_indice_eliminadas]
	lstr_contasii.tercero              = ds_facturas_eliminadas.object.tercero[ll_indice_eliminadas]
	lstr_contasii.fecharegcontable     = ds_facturas_eliminadas.object.fecharegcontable[ll_indice_eliminadas]
	
	li_enviada_correcta = 0
	
	SELECT isnull(count(*),0)
	INTO   :li_enviada_correcta
	FROM   contasii_envios	
	WHERE  contasii_envios.empresa   = :lstr_contasii.empresa
	AND    contasii_envios.ejercicio = :lstr_contasii.ejercicio
	AND    contasii_envios.factura   = :lstr_contasii.factura
	AND    contasii_envios.tipoter   = :lstr_contasii.tipoter
	AND    contasii_envios.tercero   = :lstr_contasii.tercero
	AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO';
	
	if li_enviada_correcta = 0 then
		delete contasii_tiposimpositivos
		where  contasii_tiposimpositivos.empresa   = :lstr_contasii.empresa
		and    contasii_tiposimpositivos.ejercicio = :lstr_contasii.ejercicio
		and    contasii_tiposimpositivos.factura   = :lstr_contasii.factura
		and    contasii_tiposimpositivos.tipoter   = :lstr_contasii.tipoter
		and    contasii_tiposimpositivos.tercero   = :lstr_contasii.tercero;		
		
		if sqlca.sqlcode <> 0 then
			lb_correcto = false
			messagebox("¡Atención!","Error al eliminar un registro.")
		else
			delete contasii
			where  contasii.empresa   = :lstr_contasii.empresa
			and    contasii.ejercicio = :lstr_contasii.ejercicio
			and    contasii.factura   = :lstr_contasii.factura
			and    contasii.tipoter   = :lstr_contasii.tipoter
			and    contasii.tercero   = :lstr_contasii.tercero;		
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
				messagebox("¡Atención!","Error al eliminar un registro.")
			end if			
		end if
	else
		lb_correcto = false
		messagebox("¡Atención!","Se ha eliminado una factura ya registrada en SII.~nDatos de factura: "+string(lstr_contasii.ejercicio,"###0")+"/"+lstr_contasii.factura+"/"+lstr_contasii.tipoter+"/"+lstr_contasii.tercero+"~nConsulte al administrador del sistema.")
	end if
next
						
Sel = " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.sii_clave,'') as sii_clave,"+&
		"        sum(contaapun.imponible) as imponible,"+&
		"        sum(contaapun.debe) as debe,"+&
		"        sum(contaapun.haber) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'V' ) "+&
		" AND    contaapun.tipoiva in  (SELECT contaiva.tipoiva from contaiva "+&
		"                               WHERE  contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contaiva.incluir_en_sii = 'S' ) "+&		
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                            and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY contaapun.tipoter,"+&
		"        contaapun.clipro,"+&
		"        contaiva.sii_clave,"+&
		"        contaapun.factura,"+&
		"        contaapun.ffactura,"+&
		"        contaapun.fapunte "+&
	   " UNION ALL "+&
      " SELECT contaapun.tipoter as tipoter,"+&
		"        contaapun.clipro as clipro,"+&
		"        contaiva.sii_clave as sii_clave,"+&
		"        sum(contaapun.imponible) as imponible,"+&
		"        sum(contaapun.debe) as debe,"+&
		"        sum(contaapun.haber) as haber,"+&
		"        contaapun.factura as factura,"+&
		"        contaapun.ffactura as ffactura,"+&
		"        contaapun.fapunte as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&		
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'C') "+&
		" AND    contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
		"                              WHERE   contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                              AND     contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                              AND     contaiva.incluir_en_sii = 'S' ) "+&											
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                          and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY contaapun.tipoter,"+&
		"        contaapun.clipro,"+&
		"        contaiva.sii_clave,"+&
		"        contaapun.factura,"+&
		"        contaapun.ffactura,"+&
		"        contaapun.fapunte "+&		
		" ORDER BY contaapun.tipoter, contaapun.clipro, contaapun.ffactura"							
							
f_mensaje_proceso("Obteniendo datos",0,100)		

ll_total = f_cargar_cursor_transaccion(sqlca,ds_operaciones,sel)		

Sel = " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.tipoiva,'') as tipoiva,"+&
		"        isnull(contaiva.sii_exenta,'') as sii_exenta,"+&
		"        isnull(contaiva.sii_causa_exencion,'') as sii_causa_exencion,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') as sii_tipo_no_exenta,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) as sii_tipo_impositivo,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) as sii_cuota_deducible,"+&
		"        isnull(sum(contaapun.imponible),0) as imponible,"+&
		"        isnull(sum(contaapun.debe),0) as debe,"+&
		"        isnull(sum(contaapun.haber),0) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'V' ) "+&
		" AND    contaapun.tipoiva in  (SELECT contaiva.tipoiva from contaiva "+&
		"                               WHERE  contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contaiva.incluir_en_sii = 'S' ) "+&		
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                            and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY isnull(contaapun.tipoter,'') ,"+&
		"        isnull(contaapun.clipro,'') ,"+&
		"        isnull(contaiva.tipoiva,'') ,"+&
		"        isnull(contaiva.sii_exenta,'') ,"+&
		"        isnull(contaiva.sii_causa_exencion,'') ,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') ,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) ,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) ,"+&
		"        isnull(contaapun.factura,'') ,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) ,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte)  "+&				
	   " UNION ALL "+&
      " SELECT isnull(contaapun.tipoter,'') as tipoter,"+&
		"        isnull(contaapun.clipro,'') as clipro,"+&
		"        isnull(contaiva.tipoiva,'') as tipoiva,"+&
		"        isnull(contaiva.sii_exenta,'') as sii_exenta,"+&
		"        isnull(contaiva.sii_causa_exencion,'') as sii_causa_exencion,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') as sii_tipo_no_exenta,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) as sii_tipo_impositivo,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) as sii_cuota_deducible,"+&
		"        isnull(sum(contaapun.imponible),0) as imponible,"+&
		"        isnull(sum(contaapun.debe),0) as debe,"+&
		"        isnull(sum(contaapun.haber),0) as haber,"+&
		"        isnull(contaapun.factura,'') as factura,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) as ffactura,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte) as fapunte,"+&
		"        0.00 as importe_metalico,"+&
		"        0 as ejercicio_metalico  " +&
      " FROM   contaapun, " +&
		"        contaiva "+&
      " WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
      " AND    contaapun.ejercicio = "+string(ll_ejercicio,"####")+&
		" AND    contaapun.empresa   = contaiva.empresa "+&
		" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
		" AND    contaapun.ejercicio = contaiva.ejercicio "+&		
		" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
		"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
		"                               AND    contalibros.tipo      = 'C') "+&
		" AND    contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
		"                              WHERE   contaiva.ejercicio = "+string(ll_ejercicio,"####")+" "+&
		"                              AND     contaiva.empresa   = '"+codigo_empresa+"' " +&
		"                              AND     contaiva.incluir_en_sii = 'S' ) "+&											
		" AND    contaapun.fapunte between '"+STring(Date(ldt_fecha_desde),formato_fecha_cursores)+"' "+&
		"                          and     '"+STring(Date(ldt_fecha_hasta),formato_fecha_cursores)+"' "+&
		" GROUP BY isnull(contaapun.tipoter,'') ,"+&
		"        isnull(contaapun.clipro,'') ,"+&
		"        isnull(contaiva.tipoiva,'') ,"+&
		"        isnull(contaiva.sii_exenta,'') ,"+&
		"        isnull(contaiva.sii_causa_exencion,'') ,"+&
		"        isnull(contaiva.sii_tipo_no_exenta,'') ,"+&
		"        isnull(contaiva.sii_tipo_impositivo,contaiva.iva) ,"+&
		"        isnull(contaiva.sii_cuota_deducible,0) ,"+&
		"        isnull(contaapun.factura,'') ,"+&
		"        isnull(contaapun.ffactura,contaapun.ffactura) ,"+&
		"        isnull(contaapun.fapunte,contaapun.fapunte)  "+&		
		" ORDER BY contaapun.tipoter, contaapun.clipro, contaapun.ffactura"					

f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos_factura,sel)

IF ll_total > 0 then	
	for ll_indice = 1 to ll_total
		f_mensaje_proceso(string(arg_dia,'dd-mm-yyyy'),ll_indice,ll_total)		
				
		lstr_contasii.empresa              = codigo_empresa
		lstr_contasii.ejercicio            = year(date(ds_operaciones.object.ffactura[ll_indice]))
		lstr_contasii.factura              = ds_operaciones.object.factura[ll_indice]
		lstr_contasii.tipoter              = ds_operaciones.object.tipoter[ll_indice]
		lstr_contasii.tercero              = ds_operaciones.object.clipro[ll_indice]
		lstr_contasii.numseriefactura      = ds_operaciones.object.factura[ll_indice]
		lstr_contasii.fechaexpedicion      = ds_operaciones.object.ffactura[ll_indice]
		lstr_contasii.fechaoperacion       = ds_operaciones.object.ffactura[ll_indice]
		lstr_contasii.fecharegcontable     = ds_operaciones.object.fapunte[ll_indice]
		
		//ID
		ls_razon = f_razon_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
		ls_pais  = f_pais_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
		
		lstr_contasii.id_tercero = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
		lstr_contasii.id_tercero = f_tratar_nif(lstr_contasii.id_tercero,ls_razon,ls_pais)		
		
		if isnull(lstr_contasii.id_tercero) then lstr_contasii.id_tercero = ""
		if lstr_contasii.id_tercero = "" then lstr_contasii.id_tercero = lstr_contasii.tercero
		//ID
		
		if lstr_contasii.tipoter = 'C' then
			//Facturas expedidas
			lstr_contasii_calendario.facturas_enviadas ++
			
			ls_venfac_serie = f_serie_venfac(lstr_contasii.empresa,lstr_contasii.ejercicio,long(lstr_contasii.factura))
			
			lstr_contasii.tipofactura          = f_venseries_sii_tipo_factura_emitida(lstr_contasii.empresa,ls_venfac_serie) //Factura
			if date(lstr_contasii.fecharegcontable) < date('01-07-2017') then
				lstr_contasii.clave                = '16'
			else
				lstr_contasii.clave                = ds_operaciones.object.sii_clave[ll_indice]//f_contaiva_sii_clave(lstr_contasii.ejercicio,lstr_contasii.empresa,ds_operaciones.object.tipoiva[ll_indice])
			end if
			lstr_contasii.descripcionoperacion = f_descripcion_operacion_factura_emitida(lstr_contasii.empresa,lstr_contasii.tercero,lstr_contasii.factura,lstr_contasii.fechaexpedicion)
			lstr_contasii.importetotal         = 0
			lstr_contasii.situacioninmueble    = ""
			lstr_contasii.referenciacatastral  = ""
		else
			//facturas recibidas
			lstr_contasii_calendario.facturas_recibidas ++
			
			lstr_contasii.tipofactura          = "F1" //Factura
			if date(lstr_contasii.fecharegcontable) < date('01-07-2017') then
				lstr_contasii.clave                = '14'
			else			
				lstr_contasii.clave                = ds_operaciones.object.sii_clave[ll_indice]//f_contaiva_sii_clave(lstr_contasii.ejercicio,lstr_contasii.empresa,ds_operaciones.object.tipoiva[ll_indice])
			end if
			lstr_contasii.descripcionoperacion = f_descripcion_operacion_factura_recibida(lstr_contasii.empresa,lstr_contasii.tercero,lstr_contasii.factura,lstr_contasii.fechaexpedicion)
			lstr_contasii.importetotal         = 0
			lstr_contasii.situacioninmueble    = ""
			lstr_contasii.referenciacatastral  = ""			
		end if
		
		//Comprobamos si ya existe el registro
		ll_existe_registro = 0
		select isnull(count(*),0)
		into   :ll_existe_registro
		from   contasii
		where  contasii.empresa   = :lstr_contasii.empresa
		and    contasii.ejercicio = :lstr_contasii.ejercicio
		and    contasii.factura   = :lstr_contasii.factura
		and    contasii.tipoter   = :lstr_contasii.tipoter
		and    contasii.tercero   = :lstr_contasii.tercero;
		
		if ll_existe_registro > 0 then
			//Borramos el detalle de los tipos impositivos
			delete contasii_tiposimpositivos
			where  contasii_tiposimpositivos.empresa   = :lstr_contasii.empresa
			and    contasii_tiposimpositivos.ejercicio = :lstr_contasii.ejercicio
			and    contasii_tiposimpositivos.factura   = :lstr_contasii.factura
			and    contasii_tiposimpositivos.tipoter   = :lstr_contasii.tipoter
			and    contasii_tiposimpositivos.tercero   = :lstr_contasii.tercero;
		end if
		//
		
		//Detalle tipos impositivos
		
		ls_filtro = "tipoter = '"+lstr_contasii.tipoter+"' "+&
						"and clipro = '"+lstr_contasii.tercero+"' "+&
						"and factura = '"+lstr_contasii.numseriefactura+"' "+&
						"and date(ffactura) = date('"+string(lstr_contasii.fechaexpedicion,'dd-mm-yyyy')+"')"
		
		ds_tipos_impositivos_factura.setfilter(ls_filtro)
		ds_tipos_impositivos_factura.filter()
		
		ll_total_tipos_impositivos = ds_tipos_impositivos_factura.rowcount()
		
		for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos
			
			lstr_contasii_tiposimpositivos.empresa   = lstr_contasii.empresa
			lstr_contasii_tiposimpositivos.ejercicio = lstr_contasii.ejercicio
			lstr_contasii_tiposimpositivos.factura   = lstr_contasii.factura
			lstr_contasii_tiposimpositivos.tipoter   = lstr_contasii.tipoter
			lstr_contasii_tiposimpositivos.tercero   = lstr_contasii.tercero
			lstr_contasii_tiposimpositivos.tipoiva   = ds_tipos_impositivos_factura.object.tipoiva[ll_indice_tipos_impositivos]
			
			if lstr_contasii_tiposimpositivos.tipoter = 'C' then
			//Emitidas
				lstr_contasii_tiposimpositivos.exenta               = ds_tipos_impositivos_factura.object.sii_exenta[ll_indice_tipos_impositivos]
				if lstr_contasii_tiposimpositivos.exenta <> "S" then			
					lstr_contasii_tiposimpositivos.tiponoexenta      = ds_tipos_impositivos_factura.object.sii_tipo_no_exenta[ll_indice_tipos_impositivos]
					lstr_contasii_tiposimpositivos.causaexencion     = ""					
				else
					lstr_contasii_tiposimpositivos.tiponoexenta      = ""
					lstr_contasii_tiposimpositivos.causaexencion     = ds_tipos_impositivos_factura.object.sii_causa_exencion[ll_indice_tipos_impositivos]
				end if	
				
				if lstr_contasii_tiposimpositivos.tiponoexenta = "S2" then
					lstr_contasii_tiposimpositivos.isp = "S"
				else
					lstr_contasii_tiposimpositivos.isp = "N"
				end if								
				
			else
			//Recibidas
				lstr_contasii_tiposimpositivos.exenta               = ds_tipos_impositivos_factura.object.sii_exenta[ll_indice_tipos_impositivos]
				if lstr_contasii_tiposimpositivos.exenta <> "S" then			
					lstr_contasii_tiposimpositivos.tiponoexenta      = ds_tipos_impositivos_factura.object.sii_tipo_no_exenta[ll_indice_tipos_impositivos]
					lstr_contasii_tiposimpositivos.causaexencion     = ""
				else
					lstr_contasii_tiposimpositivos.tiponoexenta      = ""
					lstr_contasii_tiposimpositivos.causaexencion     = ds_tipos_impositivos_factura.object.sii_causa_exencion[ll_indice_tipos_impositivos]
				end if		
				
				lstr_contasii_tiposimpositivos.isp = f_contaiva_sii_isp(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,lstr_contasii_tiposimpositivos.tipoiva)
				
			end if
			
			if lstr_contasii_tiposimpositivos.tipoter = 'C' then
				//Vamos a buscar la parte que corresponde a servicios
				if ll_total_tipos_impositivos = 1 then
					//Solo lo haremos si hay un unico tipo de iva
					ls_filtro = "anyo = "+string(lstr_contasii_tiposimpositivos.ejercicio,"###0")+" "+&
									"and factura = '"+lstr_contasii_tiposimpositivos.factura+"' "
									
					ll_donde = ids_importe_servicios_fras_emitidas.find(ls_filtro,1,ids_importe_servicios_fras_emitidas.rowcount())				
					
					if ll_donde > 0 then
						ld_importe_servicios = ids_importe_servicios_fras_emitidas.object.importe_servicios[ll_donde]
					else
						ld_importe_servicios = 0
					end if
				else
					ld_importe_servicios = 0
				end if
			else				
				if lstr_contasii.clave = '09' then
					//Debemos buscar tambien los servicios si hay inversion de sujeto pasivo
					//Si es una factura intracomunitaria debemos comprobar el importe de los servicios que se declaran con isp
					ld_importe_servicios = 0
				else
					ld_importe_servicios = 0
				end if
			end if 
						
			lstr_contasii_tiposimpositivos.entrega_o_servicio = 'E'
			lstr_contasii_tiposimpositivos.tipoimpositivo = ds_tipos_impositivos_factura.object.sii_tipo_impositivo[ll_indice_tipos_impositivos]
			lstr_contasii_tiposimpositivos.baseimponible  = ds_tipos_impositivos_factura.object.imponible[ll_indice_tipos_impositivos]
			lstr_contasii_tiposimpositivos.baseimponible -= ld_importe_servicios
			lstr_contasii_tiposimpositivos.cuota          = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tipoimpositivo,li_decimales_moneda_empresa)
			
			ls_tipoiva_recargo = f_contaiva_recargo(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,lstr_contasii_tiposimpositivos.tipoiva)
			
			if ls_tipoiva_recargo <> "" then
				lstr_contasii_tiposimpositivos.tiporecargoequivalencia = f_iva_contaiva(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,ls_tipoiva_recargo)
				lstr_contasii_tiposimpositivos.cuotarecargo = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tiporecargoequivalencia,li_decimales_moneda_empresa)							
			else
				lstr_contasii_tiposimpositivos.tiporecargoequivalencia = 0
				lstr_contasii_tiposimpositivos.cuotarecargo = 0
			end if
			
			lstr_contasii.importetotal += lstr_contasii_tiposimpositivos.baseimponible + lstr_contasii_tiposimpositivos.cuota + lstr_contasii_tiposimpositivos.cuotarecargo
			
			if lstr_contasii_tiposimpositivos.baseimponible <> 0 or (ld_importe_servicios = 0 and ll_total_tipos_impositivos = 1) then
				if not f_insert_contasii_tiposimpositivos(lstr_contasii_tiposimpositivos) then
					lb_correcto = false
				end if
			end if
			
			if ld_importe_servicios <> 0 then
				//Detalle servicios facturados
				lstr_contasii_tiposimpositivos.entrega_o_servicio = 'S'
				lstr_contasii_tiposimpositivos.tipoimpositivo = ds_tipos_impositivos_factura.object.sii_tipo_impositivo[ll_indice_tipos_impositivos]
				lstr_contasii_tiposimpositivos.baseimponible  = ld_importe_servicios
				lstr_contasii_tiposimpositivos.cuota          = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tipoimpositivo,li_decimales_moneda_empresa)
				
				ls_tipoiva_recargo = f_contaiva_recargo(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,lstr_contasii_tiposimpositivos.tipoiva)
				
				if ls_tipoiva_recargo <> "" then
					lstr_contasii_tiposimpositivos.tiporecargoequivalencia = f_iva_contaiva(lstr_contasii_tiposimpositivos.ejercicio,lstr_contasii_tiposimpositivos.empresa,ls_tipoiva_recargo)
					lstr_contasii_tiposimpositivos.cuotarecargo = round((lstr_contasii_tiposimpositivos.baseimponible / 100) * lstr_contasii_tiposimpositivos.tiporecargoequivalencia,li_decimales_moneda_empresa)							
				else
					lstr_contasii_tiposimpositivos.tiporecargoequivalencia = 0
					lstr_contasii_tiposimpositivos.cuotarecargo = 0
				end if
				
				lstr_contasii.importetotal += lstr_contasii_tiposimpositivos.baseimponible + lstr_contasii_tiposimpositivos.cuota + lstr_contasii_tiposimpositivos.cuotarecargo
				
				if not f_insert_contasii_tiposimpositivos(lstr_contasii_tiposimpositivos) then
					lb_correcto = false
				end if				
			end if
			
		next
				
		if ll_existe_registro > 0 then
			//Updateamos
			UPDATE contasii
			SET    contasii.numseriefactura      = :lstr_contasii.numseriefactura, 
					 contasii.fechaexpedicion      = :lstr_contasii.fechaexpedicion, 
					 contasii.fechaoperacion       = :lstr_contasii.fechaoperacion, 
					 contasii.fecharegcontable     = :lstr_contasii.fecharegcontable, 
					 contasii.tipofactura          = :lstr_contasii.tipofactura, 
					 contasii.clave                = :lstr_contasii.clave, 
					 contasii.descripcionoperacion = :lstr_contasii.descripcionoperacion, 
					 contasii.importetotal         = :lstr_contasii.importetotal,
					 contasii.id_tercero           = :lstr_contasii.id_tercero
			WHERE  contasii.empresa              = :lstr_contasii.empresa
			AND    contasii.ejercicio            = :lstr_contasii.ejercicio
			AND    contasii.factura              = :lstr_contasii.factura
			AND    contasii.tipoter              = :lstr_contasii.tipoter
			AND    contasii.tercero              = :lstr_contasii.tercero; 
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
			end if
		else
			//Insertamos
			if not(f_insert_contasii(lstr_contasii)) then
				lb_correcto = false
			end if				
		end if		
	next		
	
	//Vamos con las facturas que se han eliminado o cambiado de dia
	
	//
	
	//Cuantas recibidas bien?
	select isnull(count(*),0) 
	into   :lstr_contasii_calendario.facturas_recibidas_bien
	from   contasii 
	where  contasii.empresa = :lstr_contasii_calendario.empresa 
	and    contasii.fecharegcontable = :lstr_contasii_calendario.fecha 
	and    contasii.tipoter = 'P'
	and    exists (SELECT contasii_envios.resultado_envio 
						FROM   contasii_envios 
						WHERE  contasii_envios.empresa   = contasii.empresa 
						AND    contasii_envios.ejercicio = contasii.ejercicio 
						AND    contasii_envios.factura   = contasii.factura 
						AND    contasii_envios.tipoter   = contasii.tipoter 
						AND    contasii_envios.tercero   = contasii.tercero 
						AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' );		
						
	//Cuantas emitidas bien?
	select isnull(count(*),0) 
	into   :lstr_contasii_calendario.facturas_enviadas_bien
	from   contasii 
	where  contasii.empresa = :lstr_contasii_calendario.empresa 
	and    contasii.fecharegcontable = :lstr_contasii_calendario.fecha 
	and    contasii.tipoter = 'C'
	and    exists (SELECT contasii_envios.resultado_envio 
						FROM   contasii_envios 
						WHERE  contasii_envios.empresa   = contasii.empresa 
						AND    contasii_envios.ejercicio = contasii.ejercicio 
						AND    contasii_envios.factura   = contasii.factura 
						AND    contasii_envios.tipoter   = contasii.tipoter 
						AND    contasii_envios.tercero   = contasii.tercero 
						AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' );									
	
	update contasii_calendario
	set    contasii_calendario.facturas_enviadas   = :lstr_contasii_calendario.facturas_enviadas,
			 contasii_calendario.facturas_recibidas  = :lstr_contasii_calendario.facturas_recibidas,
			 contasii_calendario.bienes_de_inversion = :lstr_contasii_calendario.bienes_de_inversion,
			 contasii_calendario.cobros_en_metalico  = :lstr_contasii_calendario.cobros_en_metalico, 
			 contasii_calendario.facturas_enviadas_bien   = :lstr_contasii_calendario.facturas_enviadas_bien,
			 contasii_calendario.facturas_recibidas_bien  = :lstr_contasii_calendario.facturas_recibidas_bien,
			 contasii_calendario.bienes_de_inversion_bien = :lstr_contasii_calendario.bienes_de_inversion_bien,
			 contasii_calendario.cobros_en_metalico_bien  = :lstr_contasii_calendario.cobros_en_metalico_bien 
	where  contasii_calendario.empresa = :lstr_contasii_calendario.empresa
	and    contasii_calendario.fecha   = :lstr_contasii_calendario.fecha;
		
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
	end if		
		
	if not(lb_correcto) then
		messagebox("Error generación SII", "El proceso no se actualiza")
		rollback;
	else		
		commit;
	end if
		
else
	//Sin registros
	//Borramos las facturas si las hubiese y actualizamos el calendario
	select isnull(count(*),0)
	into   :ll_facturas_dia_sii
	from   contasii
	where  contasii.empresa = :lstr_contasii_calendario.empresa
	and    contasii.fecharegcontable = :lstr_contasii_calendario.fecha;
	
	if ll_facturas_dia_sii > 0 then
		messagebox("Error generación SII", "Revise el dia "+string(lstr_contasii_calendario.fecha,'dd-mm-yyyy')+" hay facturas registradas  que no existen.")
	else
		update contasii_calendario
		set    contasii_calendario.facturas_enviadas   = 0,
				 contasii_calendario.facturas_recibidas  = 0,
				 contasii_calendario.bienes_de_inversion = 0,
				 contasii_calendario.cobros_en_metalico  = 0, 
				 contasii_calendario.facturas_enviadas_bien   = 0,
				 contasii_calendario.facturas_recibidas_bien  = 0,
				 contasii_calendario.bienes_de_inversion_bien = 0,
				 contasii_calendario.cobros_en_metalico_bien  = 0 
		where  contasii_calendario.empresa = :lstr_contasii_calendario.empresa
		and    contasii_calendario.fecha   = :lstr_contasii_calendario.fecha;
			
		if sqlca.sqlcode <> 0 then
			messagebox("Error generación SII", "El proceso no se actualiza")
			rollback;
		else
			commit;
		end if		
	end if
	
	f_mensaje_proceso("",100,100)	
end if

destroy ds_operaciones
destroy ds_tipos_impositivos_factura
destroy ds_facturas_eliminadas

end subroutine

public function string sii_alta_facturas_emitidas (datastore ds_datos, string arg_es_un_reenvio);//8.1. Operativa: Alta de una factura 
//8.1.1. Alta de facturas en el libro de registro de Facturas Emitidas 
//8.1.1.1.Ejemplo mensaje XML de alta  
 
long   ll_donde 
string ls_linea_xml
string ls_nombre_fichero,ls_nombre_fichero_utf8,ls_run
string ls_sel
datastore lds_fichero 
 
//Variables
string ls_IDVersionSii
string ls_Titular_NombreRazon
string ls_Titular_NIF
string ls_TipoComunicacion
string ls_PeriodoImpositivo_Ejercicio
string ls_PeriodoImpositivo_Periodo
string ls_IDEmisorFactura_NIF
string ls_NumSerieFacturaEmisor
string ls_FechaExpedicionFacturaEmisor
string ls_TipoFactura
string ls_FechaOperacion
string ls_ClaveRegimenEspecialOTrascendencia
string ls_ImporteTotal
string ls_DescripcionOperacion
string ls_Contraparte_NombreRazon
string ls_Contraparte_NIF

string ls_IDOtro_CodigoPais //Código del país asociado al emisor de la factura Alfanumérico(2) (ISO 3166-1 alpha-2 codes) L17
string ls_IDOtro_IDType     //Clave para establecer el tipo de identificación en el pais de residencia Alfanumérico(2) L4
string ls_IDOtro_ID         //Número de identificación en el país de residencia Alfanumérico(20)

string ls_TipoNoExenta
string ls_CausaExencion
string ls_DesgloseIVA_TipoImpositivo
string ls_DesgloseIVA_BaseImponible
string ls_DesgloseIVA_CuotaRepercutida
string ls_DesgloseIVA_TipoRecargoEquivalencia
string ls_DesgloseIVA_CuotaRecargoEquivalencia
 
string ls_codigo_pais,ls_pais_tercero,ls_tipo_pais_tercero
long   ll_indice,ll_total
long   ll_indice_tipos_impositivos,ll_total_tipos_impositivos
datastore ds_tipos_impositivos

str_contasii lstr_contasii

datetime ldt_fecha_alta
string   ls_fecha_hora_envio

ldt_fecha_alta = datetime(today(),now())

ls_fecha_hora_envio = right(string(year(date(ldt_fecha_alta)),"0000"),4)
ls_fecha_hora_envio = ls_fecha_hora_envio + string(month(date(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(day(date(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(hour(time(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(minute(time(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(second(time(ldt_fecha_alta)),"00")		

if cbx_pruebas.checked then
	ls_IDVersionSii = Is_IDVersionSii_Pruebas
else
	ls_IDVersionSii = Is_IDVersionSii
end if

/*A0 Alta de facturas/registro
A1 Modificación de facturas/registros (errores registrales)
A4 Modificación Factura Régimen de Viajeros*/
if arg_es_un_reenvio = 'S' then
	ls_TipoComunicacion = 'A1'
else
	ls_TipoComunicacion = 'A0'
end if

f_cargar_cursor_transaccion(sqlca,lds_fichero,'select space(500) as linea_xml from empresas where 0 = 1')

select isnull(empresas.nombre,''),
		 isnull(empresas.cif,''),
		 isnull(empresas.pais,'')
into   :ls_Titular_NombreRazon,
		 :ls_Titular_NIF,
		 :ls_codigo_pais
from   empresas
where  empresa = :codigo_empresa;

 
ls_Titular_NIF = f_tratar_nif(ls_Titular_NIF,ls_Titular_NombreRazon,ls_codigo_pais)
f_tratar_campo(ls_Titular_NombreRazon,'A',1,40)

ls_IDEmisorFactura_NIF = ls_Titular_NIF

ls_PeriodoImpositivo_Ejercicio = string(year(date(em_fecha_desde.text)),'###0')
ls_PeriodoImpositivo_Periodo = string(month(date(em_fecha_desde.text)),'00')

ls_linea_xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">' 
ll_donde     = lds_fichero.insertrow(0)
lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml

	ls_linea_xml = '<soapenv:Header/>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml
	
	ls_linea_xml = '<soapenv:Body>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
	
		ls_linea_xml = '<siiLR:SuministroLRFacturasEmitidas>' 
		ll_donde     = lds_fichero.insertrow(0)
		lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
		
			ls_linea_xml = '<sii:Cabecera>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
			
				ls_linea_xml = '<sii:IDVersionSii>'+ls_IDVersionSii+'</sii:IDVersionSii>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
				
				ls_linea_xml = '<sii:Titular>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
				
					ls_linea_xml = '<sii:NombreRazon>'+ls_Titular_NombreRazon+'</sii:NombreRazon>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:NIF>'+ls_Titular_NIF+'</sii:NIF>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml											
				
				ls_linea_xml = '</sii:Titular>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
				
				ls_linea_xml = '<sii:TipoComunicacion>'+ls_TipoComunicacion+'</sii:TipoComunicacion>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
			
			ls_linea_xml = '</sii:Cabecera>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
			
			//Factura a Factura
			for ll_indice = 1 to ds_datos.rowcount()
				lstr_contasii.empresa = ds_datos.object.empresa[ll_indice]
				lstr_contasii.ejercicio = ds_datos.object.ejercicio[ll_indice]
				lstr_contasii.factura = ds_datos.object.factura[ll_indice]
				lstr_contasii.tipoter = ds_datos.object.tipoter[ll_indice]
				lstr_contasii.tercero = ds_datos.object.tercero[ll_indice]
				
				f_cargar_str_contasii(lstr_contasii.empresa,lstr_contasii.ejercicio,lstr_contasii.factura,lstr_contasii.tipoter,lstr_contasii.tercero,lstr_contasii)
				/*
				lstr_contasii.numseriefactura
				lstr_contasii.fechaexpedicion
				lstr_contasii.fechaoperacion
				lstr_contasii.fecharegcontable
				lstr_contasii.tipofactura
				lstr_contasii.clave
				lstr_contasii.descripcionoperacion
				lstr_contasii.importetotal
				lstr_contasii.situacioninmueble
				lstr_contasii.referenciacatastral
				*/
				ls_PeriodoImpositivo_Ejercicio = string(year(date(lstr_contasii.fecharegcontable)),"###0")
				ls_PeriodoImpositivo_Periodo   = string(month(date(lstr_contasii.fecharegcontable)),"00")
				
				ls_NumSerieFacturaEmisor       = lstr_contasii.numseriefactura
				
				ls_FechaExpedicionFacturaEmisor = string(lstr_contasii.fechaexpedicion,"dd-mm-yyyy")
				
				ls_TipoFactura                  = lstr_contasii.tipofactura
				ls_ClaveRegimenEspecialOTrascendencia = lstr_contasii.clave
				ls_ImporteTotal                       = f_sust(String(lstr_contasii.importetotal,'#########0.00'),',','.')
				ls_DescripcionOperacion               = lstr_contasii.descripcionoperacion
				
				ls_Contraparte_NombreRazon = f_razon_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
				f_tratar_campo(ls_Contraparte_NombreRazon,'A',1,40)
				
				ls_pais_tercero      = f_pais_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
				ls_tipo_pais_tercero = f_tipo_pais(ls_pais_tercero)
				
				if ls_tipo_pais_tercero = 'N' then
					//Nacional
					ls_Contraparte_NIF = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
					ls_Contraparte_NIF = f_tratar_nif(ls_Contraparte_NIF,ls_Contraparte_NombreRazon,ls_pais_tercero)
				else
					select isnull(codigo_iso,'') 
					into  :ls_IDOtro_CodigoPais
					from  paises
					where pais = :ls_pais_tercero;		
					
					if ls_tipo_pais_tercero = 'C' then
						//Comunitario
						ls_IDOtro_IDType     = '02'
						ls_IDOtro_ID         = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
						ls_IDOtro_ID         = f_tratar_nif(ls_IDOtro_ID,ls_Contraparte_NombreRazon,ls_pais_tercero)
					else
						ls_IDOtro_IDType     = '06'
						ls_IDOtro_ID         = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
						ls_IDOtro_ID         = f_tratar_nif(ls_IDOtro_ID,ls_Contraparte_NombreRazon,ls_pais_tercero)
						if isnull(ls_IDOtro_ID) or trim(ls_IDOtro_ID) = '' then ls_IDOtro_ID = lstr_contasii.tercero
					end if
				end if				
				
			ls_linea_xml = '<siiLR:RegistroLRFacturasEmitidas>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
		
				ls_linea_xml = '<sii:PeriodoImpositivo>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
				
					ls_linea_xml = '<sii:Ejercicio>'+ls_PeriodoImpositivo_Ejercicio+'</sii:Ejercicio>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
					
					ls_linea_xml = '<sii:Periodo>'+ls_PeriodoImpositivo_Periodo+'</sii:Periodo>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
								
				ls_linea_xml = '</sii:PeriodoImpositivo>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
				
				ls_linea_xml = '<siiLR:IDFactura>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
				
					ls_linea_xml = '<sii:IDEmisorFactura>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
					
						ls_linea_xml = '<sii:NIF>'+ls_IDEmisorFactura_NIF+'</sii:NIF>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
					
					ls_linea_xml = '</sii:IDEmisorFactura>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
				
					ls_linea_xml = '<sii:NumSerieFacturaEmisor>'+ls_NumSerieFacturaEmisor+'</sii:NumSerieFacturaEmisor>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:FechaExpedicionFacturaEmisor>'+ls_FechaExpedicionFacturaEmisor+'</sii:FechaExpedicionFacturaEmisor>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																						
				
				ls_linea_xml = '</siiLR:IDFactura>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
				
				ls_linea_xml = '<siiLR:FacturaExpedida>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		

					ls_linea_xml = '<sii:TipoFactura>'+ls_TipoFactura+'</sii:TipoFactura>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
				
					if left(ls_TipoFactura,1) = 'R' then
						//Es una rectificativa,  para nosotros siempre será por diferencia
						/*Por sustitucion
						
						Cuando la rectificación se haga por “sustitución” se deberá informar de la rectificación efectuada señalando igualmente el importe de dicha
						rectificación. Esta información se podrá realizar:
						- Opción 1: Informando de un nuevo registro en el que se indiquen los importes correctos tras la rectificación en los campos “base imponible”,
						“cuota” y en su caso “recargo” y a su vez de los importes rectificados respecto de la factura original en los campos “base rectificada”, “cuota
						rectificada” y en su caso “recargo rectificado”.
						- Opción 2: Informando de un nuevo registro en el que se indiquen los importes correctos tras la rectificación en los campos “base imponible”,
						“cuota” y en su caso “recargo” y de otro registro en el que se informe de los importes rectificados.

						<sii:TipoFactura>R1</sii:TipoFactura>
						<sii:TipoRectificativa>S</sii:TipoRectificativa>
						<sii:ImporteRectificacion>
						<sii:BaseRectificada>1000</sii:BaseRectificada>
						<sii:CuotaRectificada>210</sii:CuotaRectificada>
						</sii:ImporteRectificacion>
						<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia> */
						
						/*Por diferencias
						
						El registro de esta rectificación por “diferencias” se realizará informando con un ALTA de una nueva factura e informando en el campo de tipo
						de factura de que se trata de una “factura rectificativa” y en el campo tipo de factura rectificativa de que es “por diferencia”. En este caso no se
						debe rellenar los importes sustituidos en los campos de la “base rectificada” y “cuota rectificada” que sí son exigibles al informar de una
						rectificación por sustitución. Opcional identificar las facturas rectificadas.	
						
						<sii:TipoFactura>R2</sii:TipoFactura>
						<sii:TipoRectificativa>I</sii:TipoRectificativa>
						<sii:FacturasRectificadas>
						<sii:IDFacturaRectificada>
						<sii:NumSerieFacturaEmisor>00000000000000000000000500002000000000000000000000000000014</sii:NumSerieFacturaEmisor>
						<sii:FechaExpedicionFacturaEmisor>01-04-2017</sii:FechaExpedicionFacturaEmisor>
						</sii:IDFacturaRectificada>
						</sii:FacturasRectificadas>
						<sii:ClaveRegimenEspecialOTrascendencia>01</sii:ClaveRegimenEspecialOTrascendencia> */
						
						ls_linea_xml = '<sii:TipoRectificativa>I</sii:TipoRectificativa>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
						
						//En principio unicamente indicamos que sustituye por diferencias
					end if
					
					ls_linea_xml = '<sii:ClaveRegimenEspecialOTrascendencia>'+ls_ClaveRegimenEspecialOTrascendencia+'</sii:ClaveRegimenEspecialOTrascendencia>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
					
					ls_linea_xml = '<sii:ImporteTotal>'+ls_ImporteTotal+'</sii:ImporteTotal>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
					ls_linea_xml = '<sii:DescripcionOperacion>'+ls_DescripcionOperacion+'</sii:DescripcionOperacion>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
					//Datos inmueble si los hay
					if lstr_contasii.referenciacatastral <> '' then
						ls_linea_xml = '<sii:DatosInmueble>'
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
						
							ls_linea_xml = '<sii:DetalleInmueble>'
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
							
								ls_linea_xml = '<sii:SituacionInmueble>'+lstr_contasii.situacioninmueble+'<sii:SituacionInmueble>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
								
								ls_linea_xml = '<sii:ReferenciaCatastral>'+lstr_contasii.referenciacatastral+'<sii:ReferenciaCatastral>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
							
							ls_linea_xml = '</sii:DetalleInmueble>'
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
						
						ls_linea_xml = '</sii:DatosInmueble>'
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
					end if
					
					ls_linea_xml = '<sii:Contraparte>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
					//Nif para España y IDOtro para resto de paises
					if ls_tipo_pais_tercero = 'N' then
						ls_linea_xml = '<sii:NombreRazon>'+ls_Contraparte_NombreRazon+'</sii:NombreRazon>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
						
						ls_linea_xml = '<sii:NIF>'+ls_Contraparte_NIF+'</sii:NIF>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
					else					
						ls_linea_xml = '<sii:NombreRazon>'+ls_Contraparte_NombreRazon+'</sii:NombreRazon>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
						
						ls_linea_xml = '<sii:IDOtro>'
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
						
							ls_linea_xml = '<sii:CodigoPais>'+ls_IDOtro_CodigoPais+'</sii:CodigoPais>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
							
							ls_linea_xml = '<sii:IDType>'+ls_IDOtro_IDType+'</sii:IDType>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
							
							ls_linea_xml = '<sii:ID>'+ls_IDOtro_ID+'</sii:ID>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
						
						ls_linea_xml = '</sii:IDOtro>'
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
					end if	
						
					ls_linea_xml = '</sii:Contraparte>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
					
					ls_linea_xml = '<sii:TipoDesglose>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
					
						ls_linea_xml = '<sii:DesgloseTipoOperacion>' //'<sii:DesgloseFactura>' Siempre desglosamos el tipo de opercion
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
						ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
									"			 contasii_tiposimpositivos.tipoimpositivo, "+&
									"         contasii_tiposimpositivos.exenta, "+&
									"			 contasii_tiposimpositivos.tiponoexenta, "+&
									"			 contasii_tiposimpositivos.causaexencion, "+&
									"			 contasii_tiposimpositivos.baseimponible, "+&
									"			 contasii_tiposimpositivos.cuota, "+&
									"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
									"			 contasii_tiposimpositivos.cuotarecargo "+&
									"	FROM   contasii_tiposimpositivos "+&
									"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
									"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
									"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
									"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
									"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
									"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'S' "+&																
									"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
									
						ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)
						
						if ll_total_tipos_impositivos > 0 then
							//Hay Servicios
							ls_linea_xml = '<sii:PrestacionServicios>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
							
								//Primero los servicios Sujetos													
								ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
											"			 contasii_tiposimpositivos.tipoimpositivo, "+&
											"         contasii_tiposimpositivos.exenta, "+&
											"			 contasii_tiposimpositivos.tiponoexenta, "+&
											"			 contasii_tiposimpositivos.causaexencion, "+&
											"			 contasii_tiposimpositivos.baseimponible, "+&
											"			 contasii_tiposimpositivos.cuota, "+&
											"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
											"			 contasii_tiposimpositivos.cuotarecargo "+&
											"	FROM   contasii_tiposimpositivos "+&
											"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
											"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
											"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
											"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
											"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
											"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'S' "+&	
											"  AND    contasii_tiposimpositivos.causaexencion not in('N1','N2') "+&
											"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
											
								ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)							
								//
								ls_linea_xml = '<sii:Sujeta>' //Siempre seran sujetas
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
								
								ds_tipos_impositivos.setfilter("exenta = 'S'")
								ds_tipos_impositivos.filter()
								ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
								
								if ll_total_tipos_impositivos > 0 then
									//Hay Servicios exentos
									ls_linea_xml = '<sii:Exenta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
									
									for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos
										ls_CausaExencion = ds_tipos_impositivos.object.causaexencion[ll_indice_tipos_impositivos]
										ls_linea_xml = '<sii:CausaExencion>'+ls_CausaExencion+'</sii:CausaExencion>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																														
										ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
										ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
									next
									ls_linea_xml = '</sii:Exenta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
									
								end if
								
								ds_tipos_impositivos.setfilter("exenta = 'N'")
								ds_tipos_impositivos.filter()
								ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
								
								if ll_total_tipos_impositivos > 0 then
									//Hay Servicios no exentos
									ls_linea_xml = '<sii:NoExenta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
										ls_TipoNoExenta = ds_tipos_impositivos.object.tiponoexenta[1] //Revisar
										ls_linea_xml = '<sii:TipoNoExenta>'+ls_TipoNoExenta+'</sii:TipoNoExenta>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
														
										ls_linea_xml = '<sii:DesgloseIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
										
											//*********************************										
											
											for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos												
																
													ls_linea_xml = '<sii:DetalleIVA>'
													ll_donde     = lds_fichero.insertrow(0)
													lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																										
													
														ls_DesgloseIVA_TipoImpositivo = f_sust(String(ds_tipos_impositivos.object.tipoimpositivo[ll_indice_tipos_impositivos],'#########0.00'),',','.')
														ls_linea_xml = '<sii:TipoImpositivo>'+ls_DesgloseIVA_TipoImpositivo+'</sii:TipoImpositivo>' 
														ll_donde     = lds_fichero.insertrow(0)
														lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
														
														ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
														ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
														ll_donde     = lds_fichero.insertrow(0)
														lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
														
														ls_DesgloseIVA_CuotaRepercutida = f_sust(String(ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos],'#########0.00'),',','.')
														ls_linea_xml = '<sii:CuotaRepercutida>'+ls_DesgloseIVA_CuotaRepercutida+'</sii:CuotaRepercutida>' 
														ll_donde     = lds_fichero.insertrow(0)
														lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
														
														if ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos] > 0 then
															ls_DesgloseIVA_TipoRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos],'#########0.00'),',','.')
															ls_linea_xml = '<sii:TipoRecargoEquivalencia>'+ls_DesgloseIVA_TipoRecargoEquivalencia+'</sii:TipoRecargoEquivalencia>' 
															ll_donde     = lds_fichero.insertrow(0)
															lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
															
															ls_DesgloseIVA_CuotaRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos],'#########0.00'),',','.')														
															ls_linea_xml = '<sii:CuotaRecargoEquivalencia>'+ls_DesgloseIVA_CuotaRecargoEquivalencia+'</sii:CuotaRecargoEquivalencia>' 
															ll_donde     = lds_fichero.insertrow(0)
															lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
														end if
													ls_linea_xml = '</sii:DetalleIVA>'
													ll_donde     = lds_fichero.insertrow(0)
													lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																					
											next
											
										ls_linea_xml = '</sii:DesgloseIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
										
									ls_linea_xml = '</sii:NoExenta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
									
								end if								
							
								ls_linea_xml = '</sii:Sujeta>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml											
								//Fin de Primero los servicios Sujetos
								
								//	Ahora las No sujetas																					
								ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
											"			 contasii_tiposimpositivos.tipoimpositivo, "+&
											"         contasii_tiposimpositivos.exenta, "+&
											"			 contasii_tiposimpositivos.tiponoexenta, "+&
											"			 contasii_tiposimpositivos.causaexencion, "+&
											"			 contasii_tiposimpositivos.baseimponible, "+&
											"			 contasii_tiposimpositivos.cuota, "+&
											"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
											"			 contasii_tiposimpositivos.cuotarecargo "+&
											"	FROM   contasii_tiposimpositivos "+&
											"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
											"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
											"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
											"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
											"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
											"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'S' "+&	
											"  AND    contasii_tiposimpositivos.causaexencion in('N1','N2') "+&
											"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
											
								ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)							
								//
								if ll_total_tipos_impositivos > 0 then
									ls_linea_xml = '<sii:NoSujeta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
									
									ds_tipos_impositivos.setfilter("causaexencion = 'N1'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios ImportePorArticulos7_14_Otros	
										for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos																																								
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:ImportePorArticulos7_14_Otros>'+ls_DesgloseIVA_BaseImponible+'</sii:ImportePorArticulos7_14_Otros>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
										next						
										
									end if
									
									ds_tipos_impositivos.setfilter("causaexencion = 'N2'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios ImporteTAIReglasLocalizacion												
										for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos																																								
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:ImporteTAIReglasLocalizacion>'+ls_DesgloseIVA_BaseImponible+'</sii:ImporteTAIReglasLocalizacion>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
										next					
																														
									end if								
								
									ls_linea_xml = '</sii:NoSujeta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml											
								end if
								// Fin de Ahora las No sujetas
								
							ls_linea_xml = '</sii:PrestacionServicios>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
						end if
						
						destroy ds_tipos_impositivos
												
						ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
									"			 contasii_tiposimpositivos.tipoimpositivo, "+&
									"         contasii_tiposimpositivos.exenta, "+&
									"			 contasii_tiposimpositivos.tiponoexenta, "+&
									"			 contasii_tiposimpositivos.causaexencion, "+&
									"			 contasii_tiposimpositivos.baseimponible, "+&
									"			 contasii_tiposimpositivos.cuota, "+&
									"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
									"			 contasii_tiposimpositivos.cuotarecargo "+&
									"	FROM   contasii_tiposimpositivos "+&
									"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
									"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
									"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
									"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
									"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
									"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'E' "+&	
									"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
									
						ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)
						
						if ll_total_tipos_impositivos > 0 then
							//Hay Entregas
							ls_linea_xml = '<sii:Entrega>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
								//Primero las entregas Sujetas		
								ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
											"			 contasii_tiposimpositivos.tipoimpositivo, "+&
											"         contasii_tiposimpositivos.exenta, "+&
											"			 contasii_tiposimpositivos.tiponoexenta, "+&
											"			 contasii_tiposimpositivos.causaexencion, "+&
											"			 contasii_tiposimpositivos.baseimponible, "+&
											"			 contasii_tiposimpositivos.cuota, "+&
											"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
											"			 contasii_tiposimpositivos.cuotarecargo "+&
											"	FROM   contasii_tiposimpositivos "+&
											"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
											"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
											"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
											"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
											"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
											"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'E' "+&	
											"  AND    contasii_tiposimpositivos.causaexencion not in('N1','N2') "+&
											"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
											
								ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)								
								
								if ll_total_tipos_impositivos > 0 then
									ls_linea_xml = '<sii:Sujeta>' //Siempre seran sujetas
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
									
									ds_tipos_impositivos.setfilter("exenta = 'S'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios exentos
										ls_linea_xml = '<sii:Exenta>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
										
										for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos
											ls_CausaExencion = ds_tipos_impositivos.object.causaexencion[ll_indice_tipos_impositivos]
											ls_linea_xml = '<sii:CausaExencion>'+ls_CausaExencion+'</sii:CausaExencion>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																															
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
										next
										ls_linea_xml = '</sii:Exenta>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
										
									end if
									
									ds_tipos_impositivos.setfilter("exenta = 'N'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios no exentos
										ls_linea_xml = '<sii:NoExenta>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											ls_TipoNoExenta = ds_tipos_impositivos.object.tiponoexenta[1] //Revisar
											ls_linea_xml = '<sii:TipoNoExenta>'+ls_TipoNoExenta+'</sii:TipoNoExenta>'
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
															
											ls_linea_xml = '<sii:DesgloseIVA>'
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											
												//*********************************										
												
												for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos												
																	
														ls_linea_xml = '<sii:DetalleIVA>'
														ll_donde     = lds_fichero.insertrow(0)
														lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																										
														
															ls_DesgloseIVA_TipoImpositivo = f_sust(String(ds_tipos_impositivos.object.tipoimpositivo[ll_indice_tipos_impositivos],'#########0.00'),',','.')
															ls_linea_xml = '<sii:TipoImpositivo>'+ls_DesgloseIVA_TipoImpositivo+'</sii:TipoImpositivo>' 
															ll_donde     = lds_fichero.insertrow(0)
															lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
															
															ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
															ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
															ll_donde     = lds_fichero.insertrow(0)
															lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
															
															ls_DesgloseIVA_CuotaRepercutida = f_sust(String(ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos],'#########0.00'),',','.')
															ls_linea_xml = '<sii:CuotaRepercutida>'+ls_DesgloseIVA_CuotaRepercutida+'</sii:CuotaRepercutida>' 
															ll_donde     = lds_fichero.insertrow(0)
															lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
															
															if ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos] > 0 then
																ls_DesgloseIVA_TipoRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos],'#########0.00'),',','.')
																ls_linea_xml = '<sii:TipoRecargoEquivalencia>'+ls_DesgloseIVA_TipoRecargoEquivalencia+'</sii:TipoRecargoEquivalencia>' 
																ll_donde     = lds_fichero.insertrow(0)
																lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
																
																ls_DesgloseIVA_CuotaRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos],'#########0.00'),',','.')														
																ls_linea_xml = '<sii:CuotaRecargoEquivalencia>'+ls_DesgloseIVA_CuotaRecargoEquivalencia+'</sii:CuotaRecargoEquivalencia>' 
																ll_donde     = lds_fichero.insertrow(0)
																lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
															end if
														ls_linea_xml = '</sii:DetalleIVA>'
														ll_donde     = lds_fichero.insertrow(0)
														lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																						
												next
												
											ls_linea_xml = '</sii:DesgloseIVA>'
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
											
										ls_linea_xml = '</sii:NoExenta>' 
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
										
									end if								
								
									ls_linea_xml = '</sii:Sujeta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
								end if
								//Fin de Primero las entregas Sujetas
								//	Ahora las No sujetas																					
								ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
											"			 contasii_tiposimpositivos.tipoimpositivo, "+&
											"         contasii_tiposimpositivos.exenta, "+&
											"			 contasii_tiposimpositivos.tiponoexenta, "+&
											"			 contasii_tiposimpositivos.causaexencion, "+&
											"			 contasii_tiposimpositivos.baseimponible, "+&
											"			 contasii_tiposimpositivos.cuota, "+&
											"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
											"			 contasii_tiposimpositivos.cuotarecargo "+&
											"	FROM   contasii_tiposimpositivos "+&
											"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
											"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
											"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
											"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
											"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
											"	AND	 contasii_tiposimpositivos.entrega_o_servicio = 'E' "+&	
											"  AND    contasii_tiposimpositivos.causaexencion in('N1','N2') "+&
											"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
											
								ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)							
								//
								if ll_total_tipos_impositivos > 0 then
									ls_linea_xml = '<sii:NoSujeta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
									
									ds_tipos_impositivos.setfilter("causaexencion = 'N1'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios ImportePorArticulos7_14_Otros	
										for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos																																								
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:ImportePorArticulos7_14_Otros>'+ls_DesgloseIVA_BaseImponible+'</sii:ImportePorArticulos7_14_Otros>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
										next						
										
									end if
									
									ds_tipos_impositivos.setfilter("causaexencion = 'N2'")
									ds_tipos_impositivos.filter()
									ll_total_tipos_impositivos = ds_tipos_impositivos.rowcount()
									
									if ll_total_tipos_impositivos > 0 then
										//Hay Servicios ImporteTAIReglasLocalizacion												
										for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos																																								
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:ImporteTAIReglasLocalizacion>'+ls_DesgloseIVA_BaseImponible+'</sii:ImporteTAIReglasLocalizacion>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
										next					
																														
									end if								
								
									ls_linea_xml = '</sii:NoSujeta>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml											
								end if
								// Fin de Ahora las No sujetas								
																
							ls_linea_xml = '</sii:Entrega>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
						end if						
						
						destroy ds_tipos_impositivos					
						
						ls_linea_xml = '</sii:DesgloseTipoOperacion>' //'</sii:DesgloseFactura>' Siempre desglosamos el tipo de opercion 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
						
					ls_linea_xml = '</sii:TipoDesglose>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
				
				ls_linea_xml = '</siiLR:FacturaExpedida>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
				
			ls_linea_xml = '</siiLR:RegistroLRFacturasEmitidas>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
		next
		//fin de Factura a Factura
	
		ls_linea_xml = '</siiLR:SuministroLRFacturasEmitidas>' 
		ll_donde     = lds_fichero.insertrow(0)
		lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
		
	ls_linea_xml = '</soapenv:Body>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		

ls_linea_xml = '</soapenv:Envelope>' 
ll_donde     = lds_fichero.insertrow(0)
lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml
 
if arg_es_un_reenvio = 'S' then
	ls_nombre_fichero = istr_contasii_parametros.directorio_ficheros+"\EMITIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+'_REENVIADAS'+ls_fecha_hora_envio+'.XML'
else
	ls_nombre_fichero = istr_contasii_parametros.directorio_ficheros+"\EMITIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+ls_fecha_hora_envio+'.XML'
end if 

if lds_fichero.rowcount() > 0 then
	if lds_fichero.saveas(ls_nombre_fichero,text!,false,EncodingUTF8!) = -1 then 
		messagebox("ERROR","AL GRABAR EL FICHERO")
		ls_nombre_fichero = ''
	else
//		POWER12 YA CODIFICA EN UTF8		
//		if arg_es_un_reenvio = 'S' then
//			ls_nombre_fichero_utf8 = istr_contasii_parametros.directorio_ficheros+"\EMITIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+'_REENVIADAS'+ls_fecha_hora_envio+'UTF8.XML'
//		else
//			ls_nombre_fichero_utf8 = istr_contasii_parametros.directorio_ficheros+"\EMITIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+ls_fecha_hora_envio+'UTF8.XML'
//		end if		
//		
//		ls_run = 'wscript.exe "'+istr_contasii_parametros.directorio_ficheros+'\COM\ScriptConversion.vbs" "'+ls_nombre_fichero+'" "'+ls_nombre_fichero_utf8+'"'
//						
//		if run(ls_run) = 1 then				
//			Sleep(1) //Esperamos 1 segundos la respuesta										
//			
//			if fileexists(ls_nombre_fichero_utf8) then		
//				ls_nombre_fichero = ls_nombre_fichero_utf8
//			end if
//		end if
	end if
else
	ls_nombre_fichero = ''
end if		

return ls_nombre_fichero 
end function

public function string sii_alta_facturas_recibidas (datastore ds_datos, string arg_es_un_reenvio);//8.1. Operativa: Alta de una factura 
//8.1.2. Alta de facturas en el libro de registro de Facturas Recibidas
//8.1.2.1.Ejemplo mensaje XML de alta
//Ejemplo de mensaje con el desglose de la inversión del sujeto pasivo y el desglose del resto de la operación.
 
long   ll_donde 
string ls_linea_xml,ls_sel,ls_nombre_fichero,ls_nombre_fichero_utf8,ls_run
datastore lds_fichero 

//Variables
string ls_IDVersionSii
string ls_Titular_NombreRazon
string ls_Titular_NIF
string ls_TipoComunicacion
string ls_PeriodoImpositivo_Ejercicio
string ls_PeriodoImpositivo_Periodo
string ls_IDEmisorFactura_NIF
string ls_NumSerieFacturaEmisor
string ls_FechaExpedicionFacturaEmisor
string ls_TipoFactura = 'F1' 		/*F1 Factura
											  F2 Factura Simplificada (ticket)
											  R1 Factura Rectificativa (Art 80.1 y 80.2 y error fundado en derecho)
											  R2 Factura Rectificativa (Art. 80.3)
											  R3 Factura Rectificativa (Art. 80.4)
											  R4 Factura Rectificativa (Resto)
											  R5 Factura Rectificativa en facturas simplificadas
											  F3 Factura emitida en sustitución de facturas simplificadas facturadas y declaradas
											  F4 Asiento resumen de facturas*/
											  
string ls_TipoRectificativa = '' /*S Por sustitución
											  I Por diferencias*/
												
string ls_FechaOperacion
string ls_ClaveRegimenEspecialOTrascendencia       /*01 Operación de régimen común
																	  02 Exportación
																	  03 Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección (135-139 LIVA)
																	  04 Régimen especial oro de inversión
																	  05 Régimen especial agencias de viajes
																	  06 Régimen especial grupo de entidades en IVA (Nivel Avanzado)
																	  07 Régimen especial criterio de caja
																	  08 Operaciones sujetas al IPSI / IGIC
																	  09 Facturación de las prestaciones de servicios de agencias de viaje que actúan como mediadoras en nombre y por cuenta ajena (D.A.4ª RD1619/2012) 
																	  10 Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que realicen estas funciones de cobro
																	  11 Operaciones de arrendamiento de local de negocio sujetas a retención
																	  12 Operaciones de arrendamiento de local de negocio no sujetos a retención
																	  13 Operaciones de arrendamiento de local de negocio sujetas y no sujetas a retención
																	  14 Factura con IVA pendiente de devengo (certificaciones de obra cuyo destinatario sea una Administración Pública)
																	  15 Factura con IVA pendiente de devengo - operaciones de tracto sucesivo*/

string ls_DescripcionOperacion
string ls_InversionSujetoPasivo_TipoImpositivo
string ls_InversionSujetoPasivo_BaseImponible
string ls_InversionSujetoPasivo_CuotaSoportada
string ls_DesgloseIVA_TipoImpositivo
string ls_DesgloseIVA_BaseImponible
string ls_DesgloseIVA_CuotaSoportada
string ls_DesgloseIVA_TipoRecargoEquivalencia
string ls_DesgloseIVA_CuotaRecargoEquivalencia
string ls_Contraparte_NombreRazon
string ls_Contraparte_NIF
string ls_FechaRegContable
string ls_CuotaDeducible

string ls_IDOtro_CodigoPais //Código del país asociado al emisor de la factura Alfanumérico(2) (ISO 3166-1 alpha-2 codes) L17
string ls_IDOtro_IDType     //Clave para establecer el tipo de identificación en el pais de residencia Alfanumérico(2) L4
string ls_IDOtro_ID         //Número de identificación en el país de residencia Alfanumérico(20)

string ls_codigo_pais,ls_pais_tercero,ls_tipo_pais_tercero,ls_filtro_tipos
long   ll_indice,ll_total
long   ll_indice_tipos_impositivos,ll_total_tipos_impositivos
dec    ld_cuota_deducible

datastore ds_tipos_impositivos

str_contasii lstr_contasii

datetime ldt_fecha_alta
string   ls_fecha_hora_envio

ldt_fecha_alta = datetime(today(),now())

ls_fecha_hora_envio = right(string(year(date(ldt_fecha_alta)),"0000"),4)
ls_fecha_hora_envio = ls_fecha_hora_envio + string(month(date(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(day(date(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(hour(time(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(minute(time(ldt_fecha_alta)),"00")
ls_fecha_hora_envio = ls_fecha_hora_envio + string(second(time(ldt_fecha_alta)),"00")		

if cbx_pruebas.checked then
	ls_IDVersionSii = Is_IDVersionSii_Pruebas
else
	ls_IDVersionSii = Is_IDVersionSii
end if

/*A0 Alta de facturas/registro
A1 Modificación de facturas/registros (errores registrales)
A4 Modificación Factura Régimen de Viajeros*/
if arg_es_un_reenvio = 'S' then
	ls_TipoComunicacion = 'A1'
else
	ls_TipoComunicacion = 'A0'
end if

f_cargar_cursor_transaccion(sqlca,lds_fichero,'select space(500) as linea_xml from empresas where 0 = 1')

select isnull(empresas.nombre,''),
		 isnull(empresas.cif,''),
		 isnull(empresas.pais,'')
into   :ls_Titular_NombreRazon,
		 :ls_Titular_NIF,
		 :ls_codigo_pais
from   empresas
where  empresa = :codigo_empresa;

ls_Titular_NIF = f_tratar_nif(ls_Titular_NIF,ls_Titular_NombreRazon,ls_codigo_pais)
f_tratar_campo(ls_Titular_NombreRazon,'A',1,40)

ls_linea_xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:siiLR="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroLR.xsd" xmlns:sii="https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroInformacion.xsd">' 
ll_donde     = lds_fichero.insertrow(0)
lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	

	ls_linea_xml = '<soapenv:Header/>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
	
	ls_linea_xml = '<soapenv:Body>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
	
		ls_linea_xml = '<siiLR:SuministroLRFacturasRecibidas>' 
		ll_donde     = lds_fichero.insertrow(0)
		lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
		
			ls_linea_xml = '<sii:Cabecera>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
			
				ls_linea_xml = '<sii:IDVersionSii>'+ls_IDVersionSii+'</sii:IDVersionSii>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
				
				ls_linea_xml = '<sii:Titular>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
				
					ls_linea_xml = '<sii:NombreRazon>'+ls_Titular_NombreRazon+'</sii:NombreRazon>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
					ls_linea_xml = '<sii:NIF>'+ls_Titular_NIF+'</sii:NIF>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
				
				ls_linea_xml = '</sii:Titular>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
				
				ls_linea_xml = '<sii:TipoComunicacion>'+ls_TipoComunicacion+'</sii:TipoComunicacion>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
			
			ls_linea_xml = '</sii:Cabecera>' 
			ll_donde     = lds_fichero.insertrow(0)
			lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
			
			//Factura a Factura
			for ll_indice = 1 to ds_datos.rowcount()
				lstr_contasii.empresa = ds_datos.object.empresa[ll_indice]
				lstr_contasii.ejercicio = ds_datos.object.ejercicio[ll_indice]
				lstr_contasii.factura = ds_datos.object.factura[ll_indice]
				lstr_contasii.tipoter = ds_datos.object.tipoter[ll_indice]
				lstr_contasii.tercero = ds_datos.object.tercero[ll_indice]
				
				f_cargar_str_contasii(lstr_contasii.empresa,lstr_contasii.ejercicio,lstr_contasii.factura,lstr_contasii.tipoter,lstr_contasii.tercero,lstr_contasii)
				/*
				lstr_contasii.numseriefactura
				lstr_contasii.fechaexpedicion
				lstr_contasii.fechaoperacion
				lstr_contasii.fecharegcontable
				lstr_contasii.tipofactura
				lstr_contasii.clave
				lstr_contasii.descripcionoperacion
				lstr_contasii.importetotal
				lstr_contasii.situacioninmueble
				lstr_contasii.referenciacatastral
				*/
				ls_PeriodoImpositivo_Ejercicio = string(year(date(lstr_contasii.fecharegcontable)),"###0")
				ls_PeriodoImpositivo_Periodo   = string(month(date(lstr_contasii.fecharegcontable)),"00")
				
				ls_NumSerieFacturaEmisor       = lstr_contasii.numseriefactura
				
				ls_FechaExpedicionFacturaEmisor = string(lstr_contasii.fechaexpedicion,"dd-mm-yyyy")
				ls_FechaRegContable             = string(lstr_contasii.fecharegcontable,"dd-mm-yyyy")
				ls_FechaOperacion               = string(lstr_contasii.fechaoperacion,"dd-mm-yyyy")
				
				ls_TipoFactura                  = lstr_contasii.tipofactura
				ls_ClaveRegimenEspecialOTrascendencia = lstr_contasii.clave
				//No es obligatorio ls_ImporteTotal                       = f_sust(String(lstr_contasii.importetotal,'#########0.00'),',','.')
				ls_DescripcionOperacion               = lstr_contasii.descripcionoperacion
				
				ls_Contraparte_NombreRazon = f_razon_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
				f_tratar_campo(ls_Contraparte_NombreRazon,'A',1,40)
				
				ls_pais_tercero      = f_pais_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
				ls_tipo_pais_tercero = f_tipo_pais(ls_pais_tercero)
				
				if ls_tipo_pais_tercero = 'N' then
					//Nacional
					ls_IDEmisorFactura_NIF = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
					ls_IDEmisorFactura_NIF = f_tratar_nif(ls_IDEmisorFactura_NIF,ls_Contraparte_NombreRazon,ls_pais_tercero)
					ls_Contraparte_NIF     = ls_IDEmisorFactura_NIF
				else
					select isnull(codigo_iso,'') 
					into  :ls_IDOtro_CodigoPais
					from  paises
					where pais = :ls_pais_tercero;		
					
					if ls_tipo_pais_tercero = 'C' then
						//Comunitario
						ls_IDOtro_IDType     = '02'
						ls_IDOtro_ID         = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
						ls_IDOtro_ID         = f_tratar_nif(ls_IDOtro_ID,ls_Contraparte_NombreRazon,ls_pais_tercero)
					else
						ls_IDOtro_IDType     = '06'
						ls_IDOtro_ID         = f_cif_genter(lstr_contasii.empresa,lstr_contasii.tipoter,lstr_contasii.tercero)
						ls_IDOtro_ID         = f_tratar_nif(ls_IDOtro_ID,ls_Contraparte_NombreRazon,ls_pais_tercero)
						if isnull(ls_IDOtro_ID) or trim(ls_IDOtro_ID) = '' then ls_IDOtro_ID = lstr_contasii.tercero
					end if
				end if			
				
				ls_linea_xml = '<siiLR:RegistroLRFacturasRecibidas>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
				
					ls_linea_xml = '<sii:PeriodoImpositivo>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
					
						ls_linea_xml = '<sii:Ejercicio>'+ls_PeriodoImpositivo_Ejercicio+'</sii:Ejercicio>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml					
						
						ls_linea_xml = '<sii:Periodo>'+ls_PeriodoImpositivo_Periodo+'</sii:Periodo>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
					ls_linea_xml = '</sii:PeriodoImpositivo>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
					
					ls_linea_xml = '<siiLR:IDFactura>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
					
						ls_linea_xml = '<sii:IDEmisorFactura>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
													
							//Nif para España y IDOtro para resto de paises
							if ls_tipo_pais_tercero = 'N' then									
								ls_linea_xml = '<sii:NIF>'+ls_IDEmisorFactura_NIF+'</sii:NIF>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
							else													
								ls_linea_xml = '<sii:IDOtro>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
								
									ls_linea_xml = '<sii:CodigoPais>'+ls_IDOtro_CodigoPais+'</sii:CodigoPais>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
									
									ls_linea_xml = '<sii:IDType>'+ls_IDOtro_IDType+'</sii:IDType>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
									
									ls_linea_xml = '<sii:ID>'+ls_IDOtro_ID+'</sii:ID>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
								
								ls_linea_xml = '</sii:IDOtro>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
							end if	
							
						ls_linea_xml = '</sii:IDEmisorFactura>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
						
						ls_linea_xml = '<sii:NumSerieFacturaEmisor>'+ls_NumSerieFacturaEmisor+'</sii:NumSerieFacturaEmisor>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
						
						ls_linea_xml = '<sii:FechaExpedicionFacturaEmisor>'+ls_FechaExpedicionFacturaEmisor+'</sii:FechaExpedicionFacturaEmisor>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml								
						
					ls_linea_xml = '</siiLR:IDFactura>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
					
					ls_linea_xml = '<siiLR:FacturaRecibida>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
					
						ls_linea_xml = '<sii:TipoFactura>'+ls_TipoFactura+'</sii:TipoFactura>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
						
						ls_linea_xml = '<sii:FechaOperacion>'+ls_FechaOperacion+'</sii:FechaOperacion>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
						
						ls_linea_xml = '<sii:ClaveRegimenEspecialOTrascendencia>'+ls_ClaveRegimenEspecialOTrascendencia+'</sii:ClaveRegimenEspecialOTrascendencia>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
						
						ls_linea_xml = '<sii:DescripcionOperacion>'+ls_DescripcionOperacion+'</sii:DescripcionOperacion>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																					
						
						ls_linea_xml = '<sii:DesgloseFactura>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
						
							//////////////////
							ld_cuota_deducible = 0
							
							//ISP
										
							ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
										"			 contasii_tiposimpositivos.tipoimpositivo, "+&
										"         contasii_tiposimpositivos.exenta, "+&
										"			 contasii_tiposimpositivos.tiponoexenta, "+&
										"			 contasii_tiposimpositivos.causaexencion, "+&
										"			 contasii_tiposimpositivos.baseimponible, "+&
										"			 contasii_tiposimpositivos.cuota, "+&
										"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
										"			 contasii_tiposimpositivos.cuotarecargo "+&
										"	FROM   contasii_tiposimpositivos "+&
										"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
										"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
										"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
										"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
										"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&		
										"  AND    contasii_tiposimpositivos.isp     = 'S' "+&
										"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"										
										
							ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)	
							
							if ll_total_tipos_impositivos > 0 then
							
								ls_linea_xml = '<sii:InversionSujetoPasivo>' // 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																											
								
								for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos												
										ld_cuota_deducible += ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos]
										ld_cuota_deducible += ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos]
										
										ls_linea_xml = '<sii:DetalleIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																										
										
											ls_DesgloseIVA_TipoImpositivo = f_sust(String(ds_tipos_impositivos.object.tipoimpositivo[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:TipoImpositivo>'+ls_DesgloseIVA_TipoImpositivo+'</sii:TipoImpositivo>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											
											ls_DesgloseIVA_CuotaSoportada = f_sust(String(ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:CuotaSoportada>'+ls_DesgloseIVA_CuotaSoportada+'</sii:CuotaSoportada>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
											
											if ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos] > 0 then
												ls_DesgloseIVA_TipoRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos],'#########0.00'),',','.')
												ls_linea_xml = '<sii:TipoRecargoEquivalencia>'+ls_DesgloseIVA_TipoRecargoEquivalencia+'</sii:TipoRecargoEquivalencia>' 
												ll_donde     = lds_fichero.insertrow(0)
												lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
												
												ls_DesgloseIVA_CuotaRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos],'#########0.00'),',','.')														
												ls_linea_xml = '<sii:CuotaRecargoEquivalencia>'+ls_DesgloseIVA_CuotaRecargoEquivalencia+'</sii:CuotaRecargoEquivalencia>' 
												ll_donde     = lds_fichero.insertrow(0)
												lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
											end if
										ls_linea_xml = '</sii:DetalleIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																		
								next
								
								destroy ds_tipos_impositivos
								
								ls_linea_xml = '</sii:InversionSujetoPasivo>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																							
								
								//ISP
							end if
							
							//NO ISP
							ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
										"			 contasii_tiposimpositivos.tipoimpositivo, "+&
										"         contasii_tiposimpositivos.exenta, "+&
										"			 contasii_tiposimpositivos.tiponoexenta, "+&
										"			 contasii_tiposimpositivos.causaexencion, "+&
										"			 contasii_tiposimpositivos.baseimponible, "+&
										"			 contasii_tiposimpositivos.cuota, "+&
										"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
										"			 contasii_tiposimpositivos.cuotarecargo "+&
										"	FROM   contasii_tiposimpositivos "+&
										"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
										"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
										"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
										"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
										"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&		
										"  AND    contasii_tiposimpositivos.isp     = 'N' "+&
										"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"										

										
							ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)	
							
							if ll_total_tipos_impositivos > 0 then
							
								ls_linea_xml = '<sii:DesgloseIVA>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml											
								
								for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos												
										ld_cuota_deducible += ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos]
										ld_cuota_deducible += ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos]
										
										ls_linea_xml = '<sii:DetalleIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																										
										
											ls_DesgloseIVA_TipoImpositivo = f_sust(String(ds_tipos_impositivos.object.tipoimpositivo[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:TipoImpositivo>'+ls_DesgloseIVA_TipoImpositivo+'</sii:TipoImpositivo>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											
											ls_DesgloseIVA_BaseImponible = f_sust(String(ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:BaseImponible>'+ls_DesgloseIVA_BaseImponible+'</sii:BaseImponible>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
											
											ls_DesgloseIVA_CuotaSoportada = f_sust(String(ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos],'#########0.00'),',','.')
											ls_linea_xml = '<sii:CuotaSoportada>'+ls_DesgloseIVA_CuotaSoportada+'</sii:CuotaSoportada>' 
											ll_donde     = lds_fichero.insertrow(0)
											lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
											
											if ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos] > 0 then
												ls_DesgloseIVA_TipoRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.tiporecargoequivalencia[ll_indice_tipos_impositivos],'#########0.00'),',','.')
												ls_linea_xml = '<sii:TipoRecargoEquivalencia>'+ls_DesgloseIVA_TipoRecargoEquivalencia+'</sii:TipoRecargoEquivalencia>' 
												ll_donde     = lds_fichero.insertrow(0)
												lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml	
												
												ls_DesgloseIVA_CuotaRecargoEquivalencia = f_sust(String(ds_tipos_impositivos.object.cuotarecargo[ll_indice_tipos_impositivos],'#########0.00'),',','.')														
												ls_linea_xml = '<sii:CuotaRecargoEquivalencia>'+ls_DesgloseIVA_CuotaRecargoEquivalencia+'</sii:CuotaRecargoEquivalencia>' 
												ll_donde     = lds_fichero.insertrow(0)
												lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
											end if
										ls_linea_xml = '</sii:DetalleIVA>'
										ll_donde     = lds_fichero.insertrow(0)
										lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml												
																		
								next
								
								destroy ds_tipos_impositivos
								
								ls_linea_xml = '</sii:DesgloseIVA>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																																				
								
								//NO ISP
							end if														
							//////////////////
							
							ls_CuotaDeducible = f_sust(String(ld_Cuota_Deducible,'#########0.00'),',','.')														
															
						//*************************************
						
						ls_linea_xml = '</sii:DesgloseFactura>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml							
					
						ls_linea_xml = '<sii:Contraparte>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
						
							ls_linea_xml = '<sii:NombreRazon>'+ls_Contraparte_NombreRazon+'</sii:NombreRazon>' 
							ll_donde     = lds_fichero.insertrow(0)
							lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
							
							//Nif para España y IDOtro para resto de paises
							if ls_tipo_pais_tercero = 'N' then									
								ls_linea_xml = '<sii:NIF>'+ls_Contraparte_NIF+'</sii:NIF>' 
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				
							else													
								ls_linea_xml = '<sii:IDOtro>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml										
								
									ls_linea_xml = '<sii:CodigoPais>'+ls_IDOtro_CodigoPais+'</sii:CodigoPais>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
									
									ls_linea_xml = '<sii:IDType>'+ls_IDOtro_IDType+'</sii:IDType>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
									
									ls_linea_xml = '<sii:ID>'+ls_IDOtro_ID+'</sii:ID>' 
									ll_donde     = lds_fichero.insertrow(0)
									lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml									
								
								ls_linea_xml = '</sii:IDOtro>'
								ll_donde     = lds_fichero.insertrow(0)
								lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml			
							end if																					
							
						ls_linea_xml = '</sii:Contraparte>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																								
							
						ls_linea_xml = '<sii:FechaRegContable>'+ls_FechaRegContable+'</sii:FechaRegContable>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml		
						
						ls_linea_xml = '<sii:CuotaDeducible>'+ls_CuotaDeducible+'</sii:CuotaDeducible>' 
						ll_donde     = lds_fichero.insertrow(0)
						lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml																
																						
					ls_linea_xml = '</siiLR:FacturaRecibida>' 
					ll_donde     = lds_fichero.insertrow(0)
					lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
				
				ls_linea_xml = '</siiLR:RegistroLRFacturasRecibidas>' 
				ll_donde     = lds_fichero.insertrow(0)
				lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml													
				
			next
			//Factura a Factura
		
		ls_linea_xml = '</siiLR:SuministroLRFacturasRecibidas>' 
		ll_donde     = lds_fichero.insertrow(0)
		lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml						
	
	ls_linea_xml = '</soapenv:Body>' 
	ll_donde     = lds_fichero.insertrow(0)
	lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml				

ls_linea_xml = '</soapenv:Envelope>'
ll_donde     = lds_fichero.insertrow(0)
lds_fichero.object.linea_xml[ll_donde] = ls_linea_xml

if arg_es_un_reenvio = 'S' then
	ls_nombre_fichero = istr_contasii_parametros.directorio_ficheros+"\RECIBIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+'_REENVIADAS'+ls_fecha_hora_envio+'.XML'
else
	ls_nombre_fichero = istr_contasii_parametros.directorio_ficheros+"\RECIBIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+ls_fecha_hora_envio+'.XML'
end if

if lds_fichero.rowcount() > 0 then
	if lds_fichero.saveas(ls_nombre_fichero,text!,false,EncodingUTF8!) = -1 then 
		messagebox("ERROR","AL GRABAR EL FICHERO")
		ls_nombre_fichero = ''
	else
//		POWER12 YA CODIFICA EN UTF8
//		if arg_es_un_reenvio = 'S' then
//			ls_nombre_fichero_utf8 = istr_contasii_parametros.directorio_ficheros+"\RECIBIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+'_REENVIADAS'+ls_fecha_hora_envio+'UTF8.XML'
//		else
//			ls_nombre_fichero_utf8 = istr_contasii_parametros.directorio_ficheros+"\RECIBIDAS"+string(date(em_fecha_hasta.text),'dd-mm-yyyy')+ls_fecha_hora_envio+'UTF8.XML'
//		end if
//		ls_run = 'wscript.exe "'+istr_contasii_parametros.directorio_ficheros+'\COM\ScriptConversion.vbs" "'+ls_nombre_fichero+'" "'+ls_nombre_fichero_utf8+'"'
//						
//		if run(ls_run) = 1 then				
//			Sleep(1) //Esperamos 1 segundos la respuesta										
//			
//			if fileexists(ls_nombre_fichero_utf8) then		
//				ls_nombre_fichero = ls_nombre_fichero_utf8
//			end if
//		end if
	end if
else
	ls_nombre_fichero = ''
end if		

return ls_nombre_fichero 

end function

event close;call super::close;dw_detalle.reset()
end event

event ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event open;call super::open;str_contasii_calendario lstr_contasii_calendario
datetime ldt_inicio_ejercicio,ldt_final_ejercicio,ldt_dia
long     ll_ejercicio_actual,ll_registos_calendario,ll_dia_ejercicio,ll_dias_ejercicio
long     ll_dia,ll_total_dias_a_procesar
string   sel
boolean  lb_correcto

datastore ds_dias_a_procesar

pointer oldpointer

istr_parametros.s_titulo_ventana = "SII"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

ll_ejercicio_actual = year(today()) //2016

select isnull(count(*),0)
into   :ll_registos_calendario
from   contasii_calendario
where  contasii_calendario.empresa = :codigo_empresa
and    datepart(yyyy,contasii_calendario.fecha) = :ll_ejercicio_actual;

if ll_registos_calendario = 0 then
	oldpointer = SetPointer(HourGlass!)
	//Creamos el calendario
	ldt_inicio_ejercicio = datetime(mdy(1,1,ll_ejercicio_actual))
	ldt_final_ejercicio  = datetime(mdy(12,31,ll_ejercicio_actual))
	
	ll_dias_ejercicio = DaysAfter (date(ldt_inicio_ejercicio),date(ldt_final_ejercicio)) +1
	
	lb_correcto = true
	
	lstr_contasii_calendario.empresa                  = codigo_empresa
	lstr_contasii_calendario.fecha                    = ldt_inicio_ejercicio
	lstr_contasii_calendario.facturas_enviadas        = 0
	lstr_contasii_calendario.facturas_recibidas       = 0
	lstr_contasii_calendario.bienes_de_inversion      = 0
	lstr_contasii_calendario.cobros_en_metalico       = 0
	lstr_contasii_calendario.facturas_enviadas_bien   = 0
	lstr_contasii_calendario.facturas_recibidas_bien  = 0
	lstr_contasii_calendario.bienes_de_inversion_bien = 0
	lstr_contasii_calendario.cobros_en_metalico_bien  = 0
	
	for ll_dia_ejercicio = 1 to ll_dias_ejercicio
		if not(f_insert_contasii_calendario(lstr_contasii_calendario)) then
			lb_correcto = false
		end if
		lstr_contasii_calendario.fecha = datetime(relativedate(date(lstr_contasii_calendario.fecha),1))
	next
		
	if lb_correcto then
		commit;
	else
		rollback;
	end if
	
	SetPointer(oldpointer)
end if

if not(f_cargar_str_contasii_parametros(codigo_empresa,istr_contasii_parametros)) then
	messagebox("¡Atención!","No se han podido cargar los parametros del SII")
	cb_consultar.enabled = false
	cb_enviar.enabled    = false
	/*
	istr_contasii_parametros.empresa
	istr_contasii_parametros.directorio_ficheros
	istr_contasii_parametros.fichero_certificado
	istr_contasii_parametros.password_certificado
	istr_contasii_parametros.cuenta_prestacion_servicios
	istr_contasii_parametros.digitos_descripcion_operacion
	*/
else
	//Cargamos las facturas que hay en contabilidad
	
	oldpointer = SetPointer(HourGlass!)
	
	Sel = " SELECT isnull(contaapun.fapunte,contaapun.fapunte) as fapunte "+&
			" FROM   contaapun, " +&
			"        contaiva "+&
			" WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
			" AND    contaapun.ejercicio = "+string(ll_ejercicio_actual,"####")+&
			" AND    contaapun.empresa   = contaiva.empresa "+&
			" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
			" AND    contaapun.ejercicio = contaiva.ejercicio "+&
			" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
			"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio_actual,"####")+" "+&
			"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
			"                               AND    contalibros.tipo      = 'V' ) "+&
			" AND    contaapun.tipoiva in  (SELECT contaiva.tipoiva from contaiva "+&
			"                               WHERE  contaiva.ejercicio = "+string(ll_ejercicio_actual,"####")+" "+&
			"                               AND    contaiva.empresa   = '"+codigo_empresa+"' " +&
			"                               AND    contaiva.incluir_en_sii = 'S' ) "+&	
			" AND   not exists ( SELECT * "+&
			"                    FROM  contasii "+&
			"                    WHERE contasii.empresa = contaapun.empresa "+&
			"                    AND   contasii.factura = contaapun.factura "+&
			"                    AND   contasii.tipoter = contaapun.tipoter "+&
			"                    AND   contasii.tercero = contaapun.clipro "+&
			"                    AND   contasii.fecharegcontable = contaapun.fapunte )"+&
			" GROUP BY contaapun.fapunte "+&
			" UNION "+&
			" SELECT isnull(contaapun.fapunte,contaapun.fapunte) as fapunte "+&
			" FROM   contaapun, " +&
			"        contaiva "+&
			" WHERE  contaapun.empresa   = '"+codigo_empresa+"'" +&
			" AND    contaapun.ejercicio = "+string(ll_ejercicio_actual,"####")+&
			" AND    contaapun.empresa   = contaiva.empresa "+&
			" AND    contaapun.tipoiva   = contaiva.tipoiva "+&
			" AND    contaapun.ejercicio = contaiva.ejercicio "+&		
			" AND    contaapun.tipoapu  IN (SELECT contalibros.codigo from contalibros "+&
			"                               WHERE  contalibros.ejercicio = "+string(ll_ejercicio_actual,"####")+" "+&
			"                               AND    contalibros.empresa   = '"+codigo_empresa+"' " +&
			"                               AND    contalibros.tipo      = 'C') "+&
			" AND    contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
			"                              WHERE   contaiva.ejercicio = "+string(ll_ejercicio_actual,"####")+" "+&
			"                              AND     contaiva.empresa   = '"+codigo_empresa+"' " +&
			"                              AND     contaiva.incluir_en_sii = 'S' ) "+&				
			" AND   not exists ( SELECT * "+&
			"                    FROM  contasii "+&
			"                    WHERE contasii.empresa = contaapun.empresa "+&
			"                    AND   contasii.factura = contaapun.factura "+&
			"                    AND   contasii.tipoter = contaapun.tipoter "+&
			"                    AND   contasii.tercero = contaapun.clipro "+&
			"                    AND   contasii.fecharegcontable = contaapun.fapunte )"+&		
			" GROUP BY contaapun.fapunte "+&		
			" UNION "+&
			" SELECT isnull(contasii.fecharegcontable,contasii.fecharegcontable) as fapunte "+&
			" FROM   contasii "+&
			" WHERE  contasii.empresa   = '"+codigo_empresa+"' "+&
			" AND    datepart(yy,contasii.fecharegcontable) = "+string(ll_ejercicio_actual,"####")+" "+&
			" AND    not exists ( SELECT * "+&
			"                    FROM  contaapun "+&
			"                    WHERE contaapun.empresa = contasii.empresa "+&
			"                    AND   contaapun.factura = contasii.factura "+&
			"                    AND   contaapun.tipoter = contasii.tipoter "+&
			"                    AND   contaapun.clipro  = contasii.tercero "+&
			"                    AND   contaapun.fapunte = contasii.fecharegcontable "+&
			"						   AND   contaapun.tipoiva in (SELECT  contaiva.tipoiva from contaiva "+&
			"																 WHERE   contaiva.ejercicio = "+string(ll_ejercicio_actual,"####")+" "+&
			"																 AND     contaiva.empresa   = '"+codigo_empresa+"' "+&
			"																 AND     contaiva.incluir_en_sii = 'S' ) ) "+&
			" GROUP BY contasii.fecharegcontable "+&
			" UNION "+&
			" SELECT contasii_calendario.fecha "+&
			" FROM   contasii_calendario "+&
			" WHERE  contasii_calendario.empresa = '"+codigo_empresa+"' "+&
			" AND    datepart(yy,contasii_calendario.fecha) = "+string(ll_ejercicio_actual,"####")+" "+&
			" AND  ( contasii_calendario.facturas_enviadas > 0 or contasii_calendario.facturas_recibidas > 0 ) "+&
			" AND   not exists ( SELECT * "+&
			"                    FROM contasii "+&
			"                    WHERE contasii.empresa = contasii_calendario.empresa "+&
			"                    AND   contasii.fecharegcontable = contasii_calendario.fecha ) "+&						
			" ORDER BY fapunte"	
			
	ll_total_dias_a_procesar = f_cargar_cursor_transaccion(sqlca,ds_dias_a_procesar,Sel)
	
	for ll_dia = 1 to ll_total_dias_a_procesar
		ldt_dia = ds_dias_a_procesar.object.fapunte[ll_dia]
		f_mensaje_proceso(string(ldt_dia,'dd-mm-yyyy'),ll_dia,ll_total_dias_a_procesar)	
		em_fecha_desde.text = string(ldt_dia,em_fecha_desde.mask)
		em_fecha_hasta.text = string(ldt_dia,em_fecha_hasta.mask)
		f_procesar_facturas_dia(ldt_dia)
	next
	
	destroy ds_dias_a_procesar
	
	SetPointer(oldpointer)
	//	
	
	dw_calendario.SetTransObject(SQLCA)
	dw_calendario.retrieve(codigo_empresa,year(today()))
	
	//Vamos a cargar o actualizar el calendario del sii
	//SELECT contasii_calendario.empresa,
	//contasii_calendario.fecha,
	//contasii_calendario.facturas_enviadas,
	//contasii_calendario.facturas_recibidas,
	//contasii_calendario.bienes_de_inversion,
	//contasii_calendario.cobros_en_metalico,
	//contasii_calendario.facturas_enviadas_bien,
	//contasii_calendario.facturas_recibidas_bien,
	//contasii_calendario.bienes_de_inversion_bien,
	//contasii_calendario.cobros_en_metalico_bien 
	//FROM contasii_calendario	
end if
end event

on w_con_sii_old.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_consultar=create cb_consultar
this.gb_1=create gb_1
this.cb_enviar=create cb_enviar
this.gb_3=create gb_3
this.pb_2=create pb_2
this.em_fecha_desde=create em_fecha_desde
this.em_fecha_hasta=create em_fecha_hasta
this.cb_1=create cb_1
this.p_calendario=create p_calendario
this.cbx_pruebas=create cbx_pruebas
this.cbx_reenviar=create cbx_reenviar
this.p_refrescar_dia=create p_refrescar_dia
this.dw_calendario=create dw_calendario
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_enviar
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.em_fecha_desde
this.Control[iCurrent+8]=this.em_fecha_hasta
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.p_calendario
this.Control[iCurrent+11]=this.cbx_pruebas
this.Control[iCurrent+12]=this.cbx_reenviar
this.Control[iCurrent+13]=this.p_refrescar_dia
this.Control[iCurrent+14]=this.dw_calendario
this.Control[iCurrent+15]=this.dw_detalle
end on

on w_con_sii_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_consultar)
destroy(this.gb_1)
destroy(this.cb_enviar)
destroy(this.gb_3)
destroy(this.pb_2)
destroy(this.em_fecha_desde)
destroy(this.em_fecha_hasta)
destroy(this.cb_1)
destroy(this.p_calendario)
destroy(this.cbx_pruebas)
destroy(this.cbx_reenviar)
destroy(this.p_refrescar_dia)
destroy(this.dw_calendario)
destroy(this.dw_detalle)
end on

event ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_f5;f_control(dw_detalle)
end event

event closequery;call super::closequery;destroy ids_cuentas_fras_recibidas
destroy ids_cuentas_fras_emitidas
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_sii_old
integer x = 992
integer y = 0
integer height = 84
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_sii_old
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_sii_old
integer width = 3451
integer height = 108
end type

type pb_1 from upb_salir within w_con_sii_old
integer x = 4485
integer y = 4
integer width = 119
integer height = 100
integer taborder = 0
end type

type cb_consultar from commandbutton within w_con_sii_old
integer x = 2821
integer y = 152
integer width = 334
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;
//f_control(dw_detalle)

datetime ldt_fecha_desde,ldt_fecha_hasta
string   ls_moneda_empresa
integer  li_decimales_moneda_empresa

pointer oldpointer
oldpointer = SetPointer(HourGlass!)

ls_moneda_empresa           = f_moneda_empresa(codigo_empresa)
li_decimales_moneda_empresa = f_decimales_moneda(ls_moneda_empresa)
	
dw_calendario.visible = false
	
dw_detalle.reset()
dw_detalle.SetRedraw(false)

f_mascara_columna(dw_detalle,'importetotal',f_mascara_moneda(ls_moneda_empresa))
f_mascara_columna(dw_detalle,'fechaexpedicion','dd-mm-yyyy')
f_mascara_columna(dw_detalle,'fechaoperacion','dd-mm-yyyy')
f_mascara_columna(dw_detalle,'fecharegcontable','dd-mm-yyyy')

ldt_fecha_desde = datetime(date(em_fecha_desde.text))
ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))

dw_detalle.retrieve(codigo_empresa,ldt_fecha_desde,ldt_fecha_hasta)

dw_detalle.SetRedraw(true)

SetPointer(oldpointer)
end event

type gb_1 from groupbox within w_con_sii_old
integer x = 9
integer y = 112
integer width = 667
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Fechas"
end type

type cb_enviar from u_boton within w_con_sii_old
integer x = 3159
integer y = 152
integer width = 334
integer height = 96
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Enviar"
end type

event clicked;datetime ldt_fecha_desde,ldt_fecha_hasta,ldt_fecha_alta
string   ls_sel,ls_fichero_emitidas,ls_fichero_emitidas_sin_extension,ls_fichero_recibidas,ls_fichero_recibidas_sin_extension
string   ls_ejecutable,ls_tipo_fichero,ls_fichero_respuesta,ls_directorio_activo,ls_directorio_de_envio,ls_fecha_hora_envio
long     ll_indice,ll_total
boolean  lb_correcto = true
string   ls_sel_respuesta,ls_mensaje,ls_mensajes_error
long     ll_resultado_importacion,ll_indice_respuesta,ll_total_respuesta,ll_registros_con_errores
str_fichero_respuesta lstr_fichero_respuesta
str_contasii_envios   lstr_contasii_envios
datastore ds_datos
datastore ds_datos_respuesta

str_contasii_calendario lstr_contasii_calendario

if messagebox("ATENCIÓN","Se va a proceder a enviar su registro de IVA a la AEAT~n¿Desea continuar?",question!,yesno!,1) = 1 then
	
	ls_fecha_hora_envio = right(string(year(date(ldt_fecha_alta)),"0000"),4)
	ls_fecha_hora_envio = ls_fecha_hora_envio + string(month(date(ldt_fecha_alta)),"00")
	ls_fecha_hora_envio = ls_fecha_hora_envio + string(day(date(ldt_fecha_alta)),"00")
	ls_fecha_hora_envio = ls_fecha_hora_envio + string(hour(time(ldt_fecha_alta)),"00")
	ls_fecha_hora_envio = ls_fecha_hora_envio + string(minute(time(ldt_fecha_alta)),"00")
	ls_fecha_hora_envio = ls_fecha_hora_envio + string(second(time(ldt_fecha_alta)),"00")		
		
	ls_directorio_activo = f_directorio_activo()
	ls_directorio_de_envio = istr_contasii_parametros.directorio_ficheros+'\COM'
	
	if not(f_activar_directorio(ls_directorio_de_envio)) then
		messagebox("Atención!","No se puede activar el directorio de envio.")
	else
	
		ldt_fecha_desde = datetime(date(em_fecha_desde.text))
		ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))
		
		lstr_contasii_calendario.empresa             = codigo_empresa
		lstr_contasii_calendario.fecha               = ldt_fecha_desde
		lstr_contasii_calendario.facturas_enviadas_bien   = 0
		lstr_contasii_calendario.facturas_recibidas_bien  = 0
		lstr_contasii_calendario.bienes_de_inversion_bien = 0
		lstr_contasii_calendario.cobros_en_metalico_bien  = 0		
		
		ll_registros_con_errores = 0
		ls_mensajes_error = ''
		lstr_contasii_envios.fecha_envio     = datetime(today(),now())
		
		ls_sel = "select contasii.empresa,"+&
					"       contasii.ejercicio,"+&
					"       contasii.factura,"+&
					"       contasii.tipoter,"+&
					"       contasii.tercero "+&
					"from   contasii "+&
					"where  contasii.empresa = '"+codigo_empresa+"' "+&
					"and    contasii.fecharegcontable between '"+string(ldt_fecha_desde,formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,formato_fecha_cursores)+"' "+&
					"and    not exists (SELECT contasii_envios.resultado_envio "+&
					"                    FROM   contasii_envios "+&
					"                    WHERE  contasii_envios.empresa   = contasii.empresa "+&
					"                    AND    contasii_envios.ejercicio = contasii.ejercicio "+&
					"                    AND    contasii_envios.factura   = contasii.factura "+&
					"                    AND    contasii_envios.tipoter   = contasii.tipoter "+&
					"                    AND    contasii_envios.tercero   = contasii.tercero "+&
					"                    AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' ) "+&
					"order by contasii.tipoter, "+&
					"         contasii.factura"
					
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		if ll_total > 0 then
			//Empezaremos con las facturas emitidas
			ds_datos.setfilter("tipoter = 'C'")
			ds_datos.filter()
			
			ll_total = ds_datos.rowcount()
			
			if ll_total > 0 then
				ls_fichero_emitidas = sii_alta_facturas_emitidas(ds_datos,'N')
				
				if trim(ls_fichero_emitidas) <> "" then
					ls_fichero_emitidas_sin_extension = left(ls_fichero_emitidas,len(ls_fichero_emitidas)-4) 
					ls_tipo_fichero                   = 'E' //E Emitidas/R Recibidas/B Bienes Inversión
					
					ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_emitidas_sin_extension+' '+ls_tipo_fichero+' '+string(ll_total,'###0')
					
					//messagebox('ls_ejecutable',ls_ejecutable)
					
					if run(ls_ejecutable) = 1 then				
						Sleep(10) //Esperamos 10 segundos la respuesta										
						
						ls_fichero_respuesta = ls_fichero_emitidas_sin_extension+'_RESP.TXT'
						
						if fileexists(ls_fichero_respuesta) then
							//Importamos el fichero en un datastore 
							//B12331377	2016	20001	C	10224	23/06/2017 0:00:00	c:\sii\EMITIDAS04-01-2016	Incorrecto:No existe el Registro
							ls_sel_respuesta = 'Select space(9) as nif_empresa,'+&
													 '       0        as ejercicio,'+&
													 '       space(15) as factura,'+&
													 '       space(1) as tipoter,'+&
													 '       space(20) as nif_o_codigo_tercero,'+&
													 '       getdate() as fecha_envio,'+&
													 '       space(255) as fichero_envio,'+&
													 '       space(500) as resultado '+&
													 'from   empresas where 0 = 1'
													 
							f_cargar_cursor_transaccion(sqlca,ds_datos_respuesta,ls_sel_respuesta)
							
							ll_resultado_importacion = ds_datos_respuesta.ImportFile(ls_fichero_respuesta)
							
							if ll_resultado_importacion < 1 then
								choose case ll_resultado_importacion
									case 0  
										ls_mensaje = "End of file; too many rows"
									case -1  
										ls_mensaje = "No rows"
									case -2  
										ls_mensaje = "Empty file"
									case -3  
										ls_mensaje = "Invalid argument"
									case -4  
										ls_mensaje = "Invalid input"
									case -5  
										ls_mensaje = "Could not open the file"
									case -6  
										ls_mensaje = "Could not close the file"
									case -7  
										ls_mensaje = "Error reading the text"
									case -8  
										ls_mensaje = "Not a TXT file"
									case -9  
										ls_mensaje = "The user canceled the import"
									case -10 
										ls_mensaje = "Unsupported dBase file format (not version 2 or 3)"
								end choose			
								messagebox("ERROR", "Se produjo un error al importar el resultado "+ls_fichero_respuesta+"~n"+ls_mensaje)							
							else
								ds_datos_respuesta.setfilter('not(isnull(nif_empresa))')
								ds_datos_respuesta.filter()
								
								ll_total_respuesta = ds_datos_respuesta.rowcount()
								
								for ll_indice_respuesta = 1 to ll_total_respuesta 													
									lstr_fichero_respuesta.nif_empresa          = ds_datos_respuesta.object.nif_empresa[ll_indice_respuesta]
									lstr_fichero_respuesta.ejercicio            = ds_datos_respuesta.object.ejercicio[ll_indice_respuesta]
									lstr_fichero_respuesta.factura              = ds_datos_respuesta.object.factura[ll_indice_respuesta]
									lstr_fichero_respuesta.tipoter              = ds_datos_respuesta.object.tipoter[ll_indice_respuesta]
									lstr_fichero_respuesta.nif_o_codigo_tercero = ds_datos_respuesta.object.nif_o_codigo_tercero[ll_indice_respuesta]
									lstr_fichero_respuesta.fecha_envio          = ds_datos_respuesta.object.fecha_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.fichero_envio        = ds_datos_respuesta.object.fichero_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.resultado				  = ds_datos_respuesta.object.resultado[ll_indice_respuesta]
									
									lstr_contasii_envios.empresa         = codigo_empresa
									lstr_contasii_envios.ejercicio       = lstr_fichero_respuesta.ejercicio
									lstr_contasii_envios.factura         = lstr_fichero_respuesta.factura
									lstr_contasii_envios.tipoter         = lstr_fichero_respuesta.tipoter
									lstr_contasii_envios.tercero         = lstr_fichero_respuesta.nif_o_codigo_tercero									
									lstr_contasii_envios.fichero_envio   = lstr_fichero_respuesta.fichero_envio
									lstr_contasii_envios.resultado_envio = lstr_fichero_respuesta.resultado
									
									if upper(trim(lstr_contasii_envios.resultado_envio)) = upper('Incorrecto:Factura duplicada') then
										lstr_contasii_envios.resultado_envio = 'Correcto'
									end if
									
									if left(upper(trim(lstr_contasii_envios.resultado_envio)),8) = upper('Correcto') then
										lstr_contasii_calendario.facturas_enviadas_bien ++
									else
										ll_registros_con_errores ++
										ls_mensajes_error += trim(lstr_contasii_envios.resultado_envio)+'~n'
									end if
									
									lstr_contasii_envios.tercero = ''
									
									select isnull(contasii.tercero,'')
									into   :lstr_contasii_envios.tercero
									from   contasii
									where  contasii.empresa   = :lstr_contasii_envios.empresa
									and    contasii.ejercicio = :lstr_contasii_envios.ejercicio
									and    contasii.factura   = :lstr_contasii_envios.factura
									and    contasii.tipoter   = :lstr_contasii_envios.tipoter 
									and    contasii.id_tercero = :lstr_fichero_respuesta.nif_o_codigo_tercero
									and    contasii.fecharegcontable = :ldt_fecha_desde;
									
									if not(f_insert_contasii_envios(lstr_contasii_envios)) then
										lb_correcto = false
									end if
								next
							end if							
						else
							messagebox('Atención','No se ha reciido el fichero de respuesta')
						end if
					else
						messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
						ll_registros_con_errores = ll_total
					end if
				else
					messagebox("Atención","No se ha podido generar el fichero de facturas emitidas.")
					ll_registros_con_errores = ll_total
				end if
			end if
			
			//Recibidas
			ds_datos.setfilter("tipoter = 'P'")
			ds_datos.filter()
			
			ll_total = ds_datos.rowcount()
			
			if ll_total > 0 then
				ls_fichero_recibidas = sii_alta_facturas_recibidas(ds_datos,'N')
				
				if trim(ls_fichero_recibidas) <> "" then
					ls_fichero_recibidas_sin_extension = left(ls_fichero_recibidas,len(ls_fichero_recibidas)-4) 
					ls_tipo_fichero                   = 'R' //E Emitidas/R Recibidas/B Bienes Inversión	
					
					ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_recibidas_sin_extension+' '+ls_tipo_fichero+' '+string(ll_total,'###0')
					
					//messagebox('ls_ejecutable',ls_ejecutable)
					
					if run(ls_ejecutable) = 1 then				
						Sleep(10) //Esperamos 10 segundos la respuesta
						
						ls_fichero_respuesta = ls_fichero_recibidas_sin_extension+'_RESP.TXT'
						
						if fileexists(ls_fichero_respuesta) then
							//Importamos el fichero en un datastore 
							//B12331377	2016	20001	C	10224	23/06/2017 0:00:00	c:\sii\EMITIDAS04-01-2016	Incorrecto:No existe el Registro
							ls_sel_respuesta = 'Select space(9) as nif_empresa,'+&
													 '       0        as ejercicio,'+&
													 '       space(15) as factura,'+&
													 '       space(1) as tipoter,'+&
													 '       space(20) as nif_o_codigo_tercero,'+&
													 '       getdate() as fecha_envio,'+&
													 '       space(255) as fichero_envio,'+&
													 '       space(500) as resultado '+&
													 'from   empresas where 0 = 1'
													 
							f_cargar_cursor_transaccion(sqlca,ds_datos_respuesta,ls_sel_respuesta)
							
							ll_resultado_importacion = ds_datos_respuesta.ImportFile(ls_fichero_respuesta)
							
							if ll_resultado_importacion < 1 then
								choose case ll_resultado_importacion
									case 0  
										ls_mensaje = "End of file; too many rows"
									case -1  
										ls_mensaje = "No rows"
									case -2  
										ls_mensaje = "Empty file"
									case -3  
										ls_mensaje = "Invalid argument"
									case -4  
										ls_mensaje = "Invalid input"
									case -5  
										ls_mensaje = "Could not open the file"
									case -6  
										ls_mensaje = "Could not close the file"
									case -7  
										ls_mensaje = "Error reading the text"
									case -8  
										ls_mensaje = "Not a TXT file"
									case -9  
										ls_mensaje = "The user canceled the import"
									case -10 
										ls_mensaje = "Unsupported dBase file format (not version 2 or 3)"
								end choose			
								messagebox("ERROR", "Se produjo un error al importar el resultado "+ls_fichero_respuesta+"~n"+ls_mensaje)							
							else
								ds_datos_respuesta.setfilter('not(isnull(nif_empresa))')
								ds_datos_respuesta.filter()
								
								ll_total_respuesta = ds_datos_respuesta.rowcount()
								
								for ll_indice_respuesta = 1 to ll_total_respuesta 													
									lstr_fichero_respuesta.nif_empresa          = ds_datos_respuesta.object.nif_empresa[ll_indice_respuesta]
									lstr_fichero_respuesta.ejercicio            = ds_datos_respuesta.object.ejercicio[ll_indice_respuesta]
									lstr_fichero_respuesta.factura              = ds_datos_respuesta.object.factura[ll_indice_respuesta]
									lstr_fichero_respuesta.tipoter              = ds_datos_respuesta.object.tipoter[ll_indice_respuesta]
									lstr_fichero_respuesta.nif_o_codigo_tercero = ds_datos_respuesta.object.nif_o_codigo_tercero[ll_indice_respuesta]
									lstr_fichero_respuesta.fecha_envio          = ds_datos_respuesta.object.fecha_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.fichero_envio        = ds_datos_respuesta.object.fichero_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.resultado				  = ds_datos_respuesta.object.resultado[ll_indice_respuesta]
									
									lstr_contasii_envios.empresa         = codigo_empresa
									lstr_contasii_envios.ejercicio       = lstr_fichero_respuesta.ejercicio
									lstr_contasii_envios.factura         = lstr_fichero_respuesta.factura
									lstr_contasii_envios.tipoter         = lstr_fichero_respuesta.tipoter
									lstr_contasii_envios.tercero         = lstr_fichero_respuesta.nif_o_codigo_tercero									
									lstr_contasii_envios.fichero_envio   = lstr_fichero_respuesta.fichero_envio
									lstr_contasii_envios.resultado_envio = lstr_fichero_respuesta.resultado
									
									if upper(trim(lstr_contasii_envios.resultado_envio)) = upper('Incorrecto:Factura duplicada') then
										lstr_contasii_envios.resultado_envio = 'Correcto'
									end if									
									
									if left(upper(trim(lstr_contasii_envios.resultado_envio)),8) = upper('Correcto') then
										lstr_contasii_calendario.facturas_recibidas_bien ++
									else
										ll_registros_con_errores ++	
										ls_mensajes_error += trim(lstr_contasii_envios.resultado_envio)+'~n'
									end if
									
									lstr_contasii_envios.tercero = ''
									
									select isnull(contasii.tercero,'')
									into   :lstr_contasii_envios.tercero
									from   contasii
									where  contasii.empresa   = :lstr_contasii_envios.empresa
									and    contasii.ejercicio = :lstr_contasii_envios.ejercicio
									and    contasii.factura   = :lstr_contasii_envios.factura
									and    contasii.tipoter   = :lstr_contasii_envios.tipoter 
									and    contasii.id_tercero = :lstr_fichero_respuesta.nif_o_codigo_tercero
									and    contasii.fecharegcontable = :ldt_fecha_desde;
									
									if not(f_insert_contasii_envios(lstr_contasii_envios)) then
										lb_correcto = false
									end if
								next
							end if														
						else
							messagebox('Atención','No se ha reciido el fichero de respuesta')
						end if					
					else
						messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
						ll_registros_con_errores += ll_total
					end if
				else
					messagebox("Atención","No se ha podido generar el fichero de facturas recibidas.")
					ll_registros_con_errores += ll_total
				end if			
			end if		
			
		else
			messagebox("Atención!","No hay datos para enviar.")
		end if
		
		destroy ds_datos
		
		if cbx_reenviar.checked then
			//Reenviamos las ya correctas
			ls_sel = "select contasii.empresa,"+&
						"       contasii.ejercicio,"+&
						"       contasii.factura,"+&
						"       contasii.tipoter,"+&
						"       contasii.tercero "+&
						"from   contasii "+&
						"where  contasii.empresa = '"+codigo_empresa+"' "+&
						"and    contasii.fecharegcontable between '"+string(ldt_fecha_desde,formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,formato_fecha_cursores)+"' "+&
						"and    exists (SELECT contasii_envios.resultado_envio "+&
						"               FROM   contasii_envios "+&
						"               WHERE  contasii_envios.empresa   = contasii.empresa "+&
						"               AND    contasii_envios.ejercicio = contasii.ejercicio "+&
						"               AND    contasii_envios.factura   = contasii.factura "+&
						"               AND    contasii_envios.tipoter   = contasii.tipoter "+&
						"               AND    contasii_envios.tercero   = contasii.tercero "+&
						"               AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' ) "+&
						"order by contasii.tipoter, "+&
						"         contasii.factura"
						
			ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
			
			if ll_total > 0 then
				//Empezaremos con las facturas emitidas
				ds_datos.setfilter("tipoter = 'C'")
				ds_datos.filter()
				
				ll_total = ds_datos.rowcount()
				
				if ll_total > 0 then
					ls_fichero_emitidas = sii_alta_facturas_emitidas(ds_datos,'S')
					
					if trim(ls_fichero_emitidas) <> "" then
						ls_fichero_emitidas_sin_extension = left(ls_fichero_emitidas,len(ls_fichero_emitidas)-4) 
						ls_tipo_fichero                   = 'E' //E Emitidas/R Recibidas/B Bienes Inversión
						
						ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_emitidas_sin_extension+' '+ls_tipo_fichero+' '+string(ll_total,'###0')
						
						//messagebox('ls_ejecutable',ls_ejecutable)
						
						if run(ls_ejecutable) = 1 then				
							Sleep(10) //Esperamos 10 segundos la respuesta										
							
							ls_fichero_respuesta = ls_fichero_emitidas_sin_extension+'_RESP.TXT'
							
							if fileexists(ls_fichero_respuesta) then
								//Importamos el fichero en un datastore 
								//B12331377	2016	20001	C	10224	23/06/2017 0:00:00	c:\sii\EMITIDAS04-01-2016	Incorrecto:No existe el Registro
								ls_sel_respuesta = 'Select space(9) as nif_empresa,'+&
														 '       0        as ejercicio,'+&
														 '       space(15) as factura,'+&
														 '       space(1) as tipoter,'+&
														 '       space(20) as nif_o_codigo_tercero,'+&
														 '       getdate() as fecha_envio,'+&
														 '       space(255) as fichero_envio,'+&
														 '       space(500) as resultado '+&
														 'from   empresas where 0 = 1'
														 
								f_cargar_cursor_transaccion(sqlca,ds_datos_respuesta,ls_sel_respuesta)
								
								ll_resultado_importacion = ds_datos_respuesta.ImportFile(ls_fichero_respuesta)
								
								if ll_resultado_importacion < 1 then
									choose case ll_resultado_importacion
										case 0  
											ls_mensaje = "End of file; too many rows"
										case -1  
											ls_mensaje = "No rows"
										case -2  
											ls_mensaje = "Empty file"
										case -3  
											ls_mensaje = "Invalid argument"
										case -4  
											ls_mensaje = "Invalid input"
										case -5  
											ls_mensaje = "Could not open the file"
										case -6  
											ls_mensaje = "Could not close the file"
										case -7  
											ls_mensaje = "Error reading the text"
										case -8  
											ls_mensaje = "Not a TXT file"
										case -9  
											ls_mensaje = "The user canceled the import"
										case -10 
											ls_mensaje = "Unsupported dBase file format (not version 2 or 3)"
									end choose			
									messagebox("ERROR", "Se produjo un error al importar el resultado "+ls_fichero_respuesta+"~n"+ls_mensaje)							
								else
									ds_datos_respuesta.setfilter('not(isnull(nif_empresa))')
									ds_datos_respuesta.filter()
									
									ll_total_respuesta = ds_datos_respuesta.rowcount()
									
									for ll_indice_respuesta = 1 to ll_total_respuesta 													
										lstr_fichero_respuesta.nif_empresa          = ds_datos_respuesta.object.nif_empresa[ll_indice_respuesta]
										lstr_fichero_respuesta.ejercicio            = ds_datos_respuesta.object.ejercicio[ll_indice_respuesta]
										lstr_fichero_respuesta.factura              = ds_datos_respuesta.object.factura[ll_indice_respuesta]
										lstr_fichero_respuesta.tipoter              = ds_datos_respuesta.object.tipoter[ll_indice_respuesta]
										lstr_fichero_respuesta.nif_o_codigo_tercero = ds_datos_respuesta.object.nif_o_codigo_tercero[ll_indice_respuesta]
										lstr_fichero_respuesta.fecha_envio          = ds_datos_respuesta.object.fecha_envio[ll_indice_respuesta]
										lstr_fichero_respuesta.fichero_envio        = ds_datos_respuesta.object.fichero_envio[ll_indice_respuesta]
										lstr_fichero_respuesta.resultado				  = ds_datos_respuesta.object.resultado[ll_indice_respuesta]
										
										lstr_contasii_envios.empresa         = codigo_empresa
										lstr_contasii_envios.ejercicio       = lstr_fichero_respuesta.ejercicio
										lstr_contasii_envios.factura         = lstr_fichero_respuesta.factura
										lstr_contasii_envios.tipoter         = lstr_fichero_respuesta.tipoter
										lstr_contasii_envios.tercero         = lstr_fichero_respuesta.nif_o_codigo_tercero									
										lstr_contasii_envios.fichero_envio   = lstr_fichero_respuesta.fichero_envio
										lstr_contasii_envios.resultado_envio = lstr_fichero_respuesta.resultado
										
										if upper(trim(lstr_contasii_envios.resultado_envio)) = upper('Incorrecto:Factura duplicada') then
											lstr_contasii_envios.resultado_envio = 'Correcto'
										end if										
										
										if left(upper(trim(lstr_contasii_envios.resultado_envio)),8) = upper('Correcto') then
											lstr_contasii_calendario.facturas_enviadas_bien ++
										else
											ll_registros_con_errores ++
											ls_mensajes_error += trim(lstr_contasii_envios.resultado_envio)+'~n'
										end if
										
										lstr_contasii_envios.tercero = ''
										
										select isnull(contasii.tercero,'')
										into   :lstr_contasii_envios.tercero
										from   contasii
										where  contasii.empresa   = :lstr_contasii_envios.empresa
										and    contasii.ejercicio = :lstr_contasii_envios.ejercicio
										and    contasii.factura   = :lstr_contasii_envios.factura
										and    contasii.tipoter   = :lstr_contasii_envios.tipoter 
										and    contasii.id_tercero = :lstr_fichero_respuesta.nif_o_codigo_tercero
										and    contasii.fecharegcontable = :ldt_fecha_desde;
										
										if not(f_insert_contasii_envios(lstr_contasii_envios)) then
											lb_correcto = false
										end if
									next
								end if							
							else
								messagebox('Atención','No se ha reciido el fichero de respuesta')
							end if
						else
							messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
							ll_registros_con_errores = ll_total
						end if
					else
						messagebox("Atención","No se ha podido generar el fichero de facturas emitidas.")
						ll_registros_con_errores = ll_total
					end if
				end if
				
				//Recibidas
				ds_datos.setfilter("tipoter = 'P'")
				ds_datos.filter()
				
				ll_total = ds_datos.rowcount()
				
				if ll_total > 0 then
					ls_fichero_recibidas = sii_alta_facturas_recibidas(ds_datos,'S')
					
					if trim(ls_fichero_recibidas) <> "" then
						ls_fichero_recibidas_sin_extension = left(ls_fichero_recibidas,len(ls_fichero_recibidas)-4) 
						ls_tipo_fichero                   = 'R' //E Emitidas/R Recibidas/B Bienes Inversión	
						
						ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_recibidas_sin_extension+' '+ls_tipo_fichero+' '+string(ll_total,'###0')
						
						//messagebox('ls_ejecutable',ls_ejecutable)
						
						if run(ls_ejecutable) = 1 then				
							Sleep(10) //Esperamos 10 segundos la respuesta
							
							ls_fichero_respuesta = ls_fichero_recibidas_sin_extension+'_RESP.TXT'
							
							if fileexists(ls_fichero_respuesta) then
								//Importamos el fichero en un datastore 
								//B12331377	2016	20001	C	10224	23/06/2017 0:00:00	c:\sii\EMITIDAS04-01-2016	Incorrecto:No existe el Registro
								ls_sel_respuesta = 'Select space(9) as nif_empresa,'+&
														 '       0        as ejercicio,'+&
														 '       space(15) as factura,'+&
														 '       space(1) as tipoter,'+&
														 '       space(20) as nif_o_codigo_tercero,'+&
														 '       getdate() as fecha_envio,'+&
														 '       space(255) as fichero_envio,'+&
														 '       space(500) as resultado '+&
														 'from   empresas where 0 = 1'
														 
								f_cargar_cursor_transaccion(sqlca,ds_datos_respuesta,ls_sel_respuesta)
								
								ll_resultado_importacion = ds_datos_respuesta.ImportFile(ls_fichero_respuesta)
								
								if ll_resultado_importacion < 1 then
									choose case ll_resultado_importacion
										case 0  
											ls_mensaje = "End of file; too many rows"
										case -1  
											ls_mensaje = "No rows"
										case -2  
											ls_mensaje = "Empty file"
										case -3  
											ls_mensaje = "Invalid argument"
										case -4  
											ls_mensaje = "Invalid input"
										case -5  
											ls_mensaje = "Could not open the file"
										case -6  
											ls_mensaje = "Could not close the file"
										case -7  
											ls_mensaje = "Error reading the text"
										case -8  
											ls_mensaje = "Not a TXT file"
										case -9  
											ls_mensaje = "The user canceled the import"
										case -10 
											ls_mensaje = "Unsupported dBase file format (not version 2 or 3)"
									end choose			
									messagebox("ERROR", "Se produjo un error al importar el resultado "+ls_fichero_respuesta+"~n"+ls_mensaje)							
								else
									ds_datos_respuesta.setfilter('not(isnull(nif_empresa))')
									ds_datos_respuesta.filter()
									
									ll_total_respuesta = ds_datos_respuesta.rowcount()
									
									for ll_indice_respuesta = 1 to ll_total_respuesta 													
										lstr_fichero_respuesta.nif_empresa          = ds_datos_respuesta.object.nif_empresa[ll_indice_respuesta]
										lstr_fichero_respuesta.ejercicio            = ds_datos_respuesta.object.ejercicio[ll_indice_respuesta]
										lstr_fichero_respuesta.factura              = ds_datos_respuesta.object.factura[ll_indice_respuesta]
										lstr_fichero_respuesta.tipoter              = ds_datos_respuesta.object.tipoter[ll_indice_respuesta]
										lstr_fichero_respuesta.nif_o_codigo_tercero = ds_datos_respuesta.object.nif_o_codigo_tercero[ll_indice_respuesta]
										lstr_fichero_respuesta.fecha_envio          = ds_datos_respuesta.object.fecha_envio[ll_indice_respuesta]
										lstr_fichero_respuesta.fichero_envio        = ds_datos_respuesta.object.fichero_envio[ll_indice_respuesta]
										lstr_fichero_respuesta.resultado				  = ds_datos_respuesta.object.resultado[ll_indice_respuesta]
										
										lstr_contasii_envios.empresa         = codigo_empresa
										lstr_contasii_envios.ejercicio       = lstr_fichero_respuesta.ejercicio
										lstr_contasii_envios.factura         = lstr_fichero_respuesta.factura
										lstr_contasii_envios.tipoter         = lstr_fichero_respuesta.tipoter
										lstr_contasii_envios.tercero         = lstr_fichero_respuesta.nif_o_codigo_tercero									
										lstr_contasii_envios.fichero_envio   = lstr_fichero_respuesta.fichero_envio
										lstr_contasii_envios.resultado_envio = lstr_fichero_respuesta.resultado
										
										if upper(trim(lstr_contasii_envios.resultado_envio)) = upper('Incorrecto:Factura duplicada') then
											lstr_contasii_envios.resultado_envio = 'Correcto'
										end if										
										
										if left(upper(trim(lstr_contasii_envios.resultado_envio)),8) = upper('Correcto') then
											lstr_contasii_calendario.facturas_recibidas_bien ++
										else
											ll_registros_con_errores ++	
											ls_mensajes_error += trim(lstr_contasii_envios.resultado_envio)+'~n'
										end if
										
										lstr_contasii_envios.tercero = ''
										
										select isnull(contasii.tercero,'')
										into   :lstr_contasii_envios.tercero
										from   contasii
										where  contasii.empresa   = :lstr_contasii_envios.empresa
										and    contasii.ejercicio = :lstr_contasii_envios.ejercicio
										and    contasii.factura   = :lstr_contasii_envios.factura
										and    contasii.tipoter   = :lstr_contasii_envios.tipoter 
										and    contasii.id_tercero = :lstr_fichero_respuesta.nif_o_codigo_tercero
										and    contasii.fecharegcontable = :ldt_fecha_desde;
										
										if not(f_insert_contasii_envios(lstr_contasii_envios)) then
											lb_correcto = false
										end if
									next
								end if														
							else
								messagebox('Atención','No se ha reciido el fichero de respuesta')
							end if					
						else
							messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
							ll_registros_con_errores += ll_total
						end if
					else
						messagebox("Atención","No se ha podido generar el fichero de facturas recibidas.")
						ll_registros_con_errores += ll_total
					end if			
				end if		
				
			else
				messagebox("Atención!","No hay datos para enviar.")
			end if
			
			destroy ds_datos	
			//Fin de Reenviamos las ya correctas
		end if		
		
		//Cuantas recibidas bien?
		select isnull(count(*),0) 
		into   :lstr_contasii_calendario.facturas_recibidas_bien
		from   contasii 
		where  contasii.empresa = :lstr_contasii_calendario.empresa 
		and    contasii.fecharegcontable = :lstr_contasii_calendario.fecha 
		and    contasii.tipoter = 'P'
		and    exists (SELECT contasii_envios.resultado_envio 
							FROM   contasii_envios 
							WHERE  contasii_envios.empresa   = contasii.empresa 
							AND    contasii_envios.ejercicio = contasii.ejercicio 
							AND    contasii_envios.factura   = contasii.factura 
							AND    contasii_envios.tipoter   = contasii.tipoter 
							AND    contasii_envios.tercero   = contasii.tercero 
							AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' );		
							
		//Cuantas emitidas bien?
		select isnull(count(*),0) 
		into   :lstr_contasii_calendario.facturas_enviadas_bien
		from   contasii 
		where  contasii.empresa = :lstr_contasii_calendario.empresa 
		and    contasii.fecharegcontable = :lstr_contasii_calendario.fecha 
		and    contasii.tipoter = 'C'
		and    exists (SELECT contasii_envios.resultado_envio 
							FROM   contasii_envios 
							WHERE  contasii_envios.empresa   = contasii.empresa 
							AND    contasii_envios.ejercicio = contasii.ejercicio 
							AND    contasii_envios.factura   = contasii.factura 
							AND    contasii_envios.tipoter   = contasii.tipoter 
							AND    contasii_envios.tercero   = contasii.tercero 
							AND    substring(upper(contasii_envios.resultado_envio),1,8) = 'CORRECTO' );									
		
		update contasii_calendario
		set    contasii_calendario.facturas_enviadas_bien   = :lstr_contasii_calendario.facturas_enviadas_bien,
				 contasii_calendario.facturas_recibidas_bien  = :lstr_contasii_calendario.facturas_recibidas_bien,
				 contasii_calendario.bienes_de_inversion_bien = :lstr_contasii_calendario.bienes_de_inversion_bien,
				 contasii_calendario.cobros_en_metalico_bien  = :lstr_contasii_calendario.cobros_en_metalico_bien 
		where  contasii_calendario.empresa = :lstr_contasii_calendario.empresa
		and    contasii_calendario.fecha   = :lstr_contasii_calendario.fecha;
		
		if sqlca.sqlcode <> 0 then
			lb_correcto = false
		end if		
		
		if lb_correcto then
			commit;
			dw_calendario.retrieve(codigo_empresa,year(today()))
		else
			rollback;
			messagebox("Atención","Se ha producido un error al grabar.")
		end if
		
		if ll_registros_con_errores > 0 then
			messagebox("Atención","Se han producido errores al registrar.~n"+ls_mensajes_error)
		else
			if lb_correcto then messagebox("Atención","Registro realizado correctamente.")
		end if
		
		f_activar_directorio(ls_directorio_activo)	
	end if
	dw_calendario.retrieve(codigo_empresa,year(today()))
	
	dw_detalle.retrieve(codigo_empresa,ldt_fecha_desde,ldt_fecha_hasta)	
end if
end event

type gb_3 from groupbox within w_con_sii_old
integer x = 2674
integer y = 112
integer width = 1746
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_2 from upb_imprimir within w_con_sii_old
integer x = 4485
integer y = 148
integer taborder = 0
end type

event clicked;//if dw_detalle.rowcount() > 0 then
//
//	dw_detalle.RowsCopy(dw_detalle.getRow(), dw_detalle.RowCount(), Primary!, dw_listado, 1, Primary!)
//
//
//	f_imprimir_datawindow(dw_listado)
//	
//else
//	messagebox ("Aviso", "No hay registros seleccionados")
//end if
u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "Fecha desde '"+em_fecha_desde.text +"' Hasta '"+em_fecha_hasta.text+"'"
u_imp.ibLandscape = true
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_detalle)


end event

type em_fecha_desde from u_em_campo within w_con_sii_old
integer x = 23
integer y = 160
integer width = 297
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "œ"
end type

event modified;call super::modified;if date(this.text) >= date('01-07-2017') then
	em_fecha_hasta.text = this.text
end if
end event

type em_fecha_hasta from u_em_campo within w_con_sii_old
integer x = 357
integer y = 160
integer width = 306
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event modified;call super::modified;if date(this.text) >= date('01-07-2017') then
	em_fecha_desde.text = this.text
end if
end event

type cb_1 from u_boton within w_con_sii_old
boolean visible = false
integer x = 3525
integer width = 448
integer height = 96
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Leer Respuesta"
end type

event clicked;call super::clicked;datetime ldt_fecha_desde,ldt_fecha_hasta
string   ls_sel,ls_fichero_emitidas,ls_fichero_emitidas_sin_extension,ls_fichero_recibidas,ls_fichero_recibidas_sin_extension
string   ls_ejecutable,ls_tipo_fichero,ls_fichero_respuesta,ls_directorio_activo,ls_directorio_de_envio
long     ll_indice,ll_total
string   ls_sel_respuesta,ls_mensaje
long     ll_indice_respuesta,ll_total_respuesta,ll_resultado_importacion
str_fichero_respuesta lstr_fichero_respuesta

datastore ds_datos
datastore ds_datos_respuesta


if messagebox("ATENCIÓN","Se va a proceder a enviar su registro de IVA a la AEAT~n¿Desea continuar?",question!,yesno!,1) = 1 then
	ls_directorio_activo = f_directorio_activo()
	ls_directorio_de_envio = istr_contasii_parametros.directorio_ficheros+'\COM'
	
	if not(f_activar_directorio(ls_directorio_de_envio)) then
		messagebox("Atención!","No se puede activar el directorio de envio.")
	else
	
		ldt_fecha_desde = datetime(date(em_fecha_desde.text))
		ldt_fecha_hasta = datetime(date(em_fecha_hasta.text))
		
		ls_sel = "select contasii.empresa,"+&
					"       contasii.ejercicio,"+&
					"       contasii.factura,"+&
					"       contasii.tipoter,"+&
					"       contasii.tercero "+&
					"from   contasii "+&
					"where  contasii.empresa = '"+codigo_empresa+"' "+&
					"and    contasii.fecharegcontable between '"+string(ldt_fecha_desde,formato_fecha_cursores)+"' and '"+string(ldt_fecha_hasta,formato_fecha_cursores)+"' "+&
					"order by contasii.tipoter, "+&
					"         contasii.factura"
					
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		if ll_total > 0 then
			//Empezaremos con las facturas emitidas
			ds_datos.setfilter("tipoter = 'C'")
			ds_datos.filter()
			
			ll_total = ds_datos.rowcount()
			
			if ll_total > 0 then
				ls_fichero_emitidas = sii_alta_facturas_emitidas(ds_datos,'N')
				
				if trim(ls_fichero_emitidas) <> "" then
					ls_fichero_emitidas_sin_extension = left(ls_fichero_emitidas,len(ls_fichero_emitidas)-4) 
					ls_tipo_fichero                   = 'E' //E Emitidas/R Recibidas/B Bienes Inversión
					
					ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_emitidas_sin_extension+' '+ls_tipo_fichero
					
					//messagebox('ls_ejecutable',ls_ejecutable)
					
					//if run(ls_ejecutable) = 1 then	
					if 1 = 1 then
						Sleep(10) //Esperamos 10 segundos la respuesta										
						
						ls_fichero_respuesta = ls_fichero_emitidas_sin_extension+'_RESP.TXT'
						
						if fileexists(ls_fichero_respuesta) then
							//Importamos el fichero en un datastore 
							//B12331377	2016	20001	C	10224	23/06/2017 0:00:00	c:\sii\EMITIDAS04-01-2016	Incorrecto:No existe el Registro
							ls_sel_respuesta = 'Select space(9) as nif_empresa,'+&
													 '       0        as ejercicio,'+&
													 '       space(15) as factura,'+&
													 '       space(1) as tipoter,'+&
													 '       space(20) as nif_o_codigo_tercero,'+&
													 '       getdate() as fecha_envio,'+&
													 '       space(255) as fichero_envio,'+&
													 '       space(500) as resultado '+&
													 'from   empresas where 0 = 1'
													 
							f_cargar_cursor_transaccion(sqlca,ds_datos_respuesta,ls_sel_respuesta)
							
							ll_resultado_importacion = ds_datos_respuesta.ImportFile(ls_fichero_respuesta)
							
							if ll_resultado_importacion < 1 then
								choose case ll_resultado_importacion
									case 0  
										ls_mensaje = "End of file; too many rows"
									case -1  
										ls_mensaje = "No rows"
									case -2  
										ls_mensaje = "Empty file"
									case -3  
										ls_mensaje = "Invalid argument"
									case -4  
										ls_mensaje = "Invalid input"
									case -5  
										ls_mensaje = "Could not open the file"
									case -6  
										ls_mensaje = "Could not close the file"
									case -7  
										ls_mensaje = "Error reading the text"
									case -8  
										ls_mensaje = "Not a TXT file"
									case -9  
										ls_mensaje = "The user canceled the import"
									case -10 
										ls_mensaje = "Unsupported dBase file format (not version 2 or 3)"
								end choose			
								messagebox("ERROR", "Se produjo un error al importar el resultado "+ls_fichero_respuesta+"~n"+ls_mensaje)							
							else
								ds_datos_respuesta.setfilter('not(isnull(nif_empresa))')
								ds_datos_respuesta.filter()
								
								ll_total_respuesta = ds_datos_respuesta.rowcount()
								
								for ll_indice_respuesta = 1 to ll_total_respuesta 													
									lstr_fichero_respuesta.nif_empresa          = ds_datos_respuesta.object.nif_empresa[ll_indice_respuesta]
									lstr_fichero_respuesta.ejercicio            = ds_datos_respuesta.object.ejercicio[ll_indice_respuesta]
									lstr_fichero_respuesta.factura              = ds_datos_respuesta.object.factura[ll_indice_respuesta]
									lstr_fichero_respuesta.tipoter              = ds_datos_respuesta.object.tipoter[ll_indice_respuesta]
									lstr_fichero_respuesta.nif_o_codigo_tercero = ds_datos_respuesta.object.nif_o_codigo_tercero[ll_indice_respuesta]
									lstr_fichero_respuesta.fecha_envio          = ds_datos_respuesta.object.fecha_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.fichero_envio        = ds_datos_respuesta.object.fichero_envio[ll_indice_respuesta]
									lstr_fichero_respuesta.resultado				  = ds_datos_respuesta.object.resultado[ll_indice_respuesta]
								next
							end if
						else
							messagebox('Atención','No se ha recibido el fichero de respuesta')
						end if
					else
						messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
					end if
				else
					messagebox("Atención","No se ha podido generar el fichero de facturas emitidas.")
				end if
			end if
			
			//Recibidas
			ds_datos.setfilter("tipoter = 'P'")
			ds_datos.filter()
			
			ll_total = ds_datos.rowcount()
			
			if ll_total > 0 then
				ls_fichero_recibidas = sii_alta_facturas_recibidas(ds_datos,'N')
				
				if trim(ls_fichero_recibidas) <> "" then
					ls_fichero_recibidas_sin_extension = left(ls_fichero_recibidas,len(ls_fichero_recibidas)-4) 
					ls_tipo_fichero                   = 'R' //E Emitidas/R Recibidas/B Bienes Inversión	
					
					ls_ejecutable = istr_contasii_parametros.directorio_ficheros+'\COM\SII '+istr_contasii_parametros.fichero_certificado+' '+istr_contasii_parametros.password_certificado+' '+ls_fichero_recibidas_sin_extension+' '+ls_tipo_fichero
					
					//messagebox('ls_ejecutable',ls_ejecutable)
					
					//if run(ls_ejecutable) = 1 then				
					if 1 = 1 then
						Sleep(10) //Esperamos 10 segundos la respuesta
						
						ls_fichero_respuesta = ls_fichero_emitidas_sin_extension+'_RESP.TXT'
						
						if fileexists(ls_fichero_respuesta) then
							//Importamos el fichero en un datastore 
							
						else
							messagebox('Atención','No se ha reciido el fichero de respuesta')
						end if					
					else
						messagebox("Atención","Se ha producido un error al llamar al módulo de comunicación.")
					end if
				else
					messagebox("Atención","No se ha podido generar el fichero de facturas recibidas.")
				end if			
			end if		
			
		else
			messagebox("Atención!","No hay datos para enviar.")
		end if
		
		destroy ds_datos
		
		f_activar_directorio(ls_directorio_activo)	
	end if
end if

end event

type p_calendario from picture within w_con_sii_old
integer x = 690
integer y = 152
integer width = 110
integer height = 96
boolean bringtotop = true
string picturename = "C:\bmp\Calendar-Search.jpg"
boolean focusrectangle = false
end type

event clicked;dw_calendario.visible = not(dw_calendario.visible)
	
end event

type cbx_pruebas from checkbox within w_con_sii_old
integer x = 3506
integer y = 172
integer width = 306
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pruebas"
end type

type cbx_reenviar from checkbox within w_con_sii_old
integer x = 3835
integer y = 172
integer width = 567
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reenviar Correctas"
end type

type p_refrescar_dia from picture within w_con_sii_old
integer x = 2688
integer y = 152
integer width = 110
integer height = 96
boolean bringtotop = true
string picturename = "C:\BMP\db-Refresh.jpg"
boolean focusrectangle = false
end type

event clicked;datetime ldt_dia
pointer oldpointer
	
if messagebox("ATENCIÓN","Se va a proceder a regenerar los registros del dia seleccionado~n¿Desea continuar?",question!,yesno!,1) = 1 then

	oldpointer = SetPointer(HourGlass!)

	ldt_dia = datetime(date(em_fecha_desde.text))
	f_procesar_facturas_dia(ldt_dia)
	
	dw_calendario.retrieve(codigo_empresa,year(date(ldt_dia)))
	
	cb_consultar.event clicked()
	
	SetPointer(oldpointer)
end if
end event

type dw_calendario from u_datawindow within w_con_sii_old
integer x = 5
integer y = 272
integer width = 4599
integer height = 2316
integer taborder = 10
string dataobject = "dw_con_sii_calendario_old"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;datetime ldt_dia

choose case dwo.name
	case 'lunes'	
		ldt_dia = this.object.lunes[row]
	case 'martes'	
		ldt_dia = this.object.martes[row]
	case 'miercoles'	
		ldt_dia = this.object.miercoles[row]
	case 'jueves'	
		ldt_dia = this.object.jueves[row]
	case 'viernes'	
		ldt_dia = this.object.viernes[row]
	case 'sabado'	
		ldt_dia = this.object.sabado[row]
	case 'domingo'		
		ldt_dia = this.object.domingo[row]
end choose

if not isnull(ldt_dia) then
	em_fecha_desde.text = string(ldt_dia,em_fecha_desde.mask)
	em_fecha_hasta.text = string(ldt_dia,em_fecha_hasta.mask)
	
	cb_consultar.event clicked()
end if
end event

type dw_detalle from datawindow within w_con_sii_old
integer x = 5
integer y = 272
integer width = 4599
integer height = 2316
string dataobject = "dw_con_sii_old"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;//long fila
//if dwo.name = "t_insertar" then
//	datetime fecha_desde, fecha_hasta
//	//dw_1.reset()
//	dw_1.insertrow(1)
//	dw_1.object.empresa[1] = codigo_empresa
//	dw_1.object.tipo[1] = left(ddlb_tipo_declaracion.text,1)
//   dw_1.object.anyo[1] =  year(date(em_fecha_desde.text))
//	dw_1.visible = true
//	dw_1.setfocus()
//	dw_1.setcolumn("tipoter")
//	
//	this.setrow(1)
//	this.event rowfocuschanged(1)
//end if
//
//if dwo.name = "t_editar" then
//	
//	//dw_1.reset()
//	//dw_1.insertrow(1)
//	fila = dw_detalle.getrow()	
////	dw_detalle.rowscopy(fila, fila, primary!, dw_1, 1, Primary!)
////	dw_1.setitemstatus(fila, 0, Primary!, DataModified!)
//	dw_1.scrolltorow(fila)
//	dw_1.visible = true
//	dw_1.setfocus()
//	dw_1.setcolumn("tipoter")
//	
//	
//end if
//
end event

event rowfocuschanged;If This.GetRow() = 0 Then Return
This.SelectRow(0,FALSE)
This.SelectRow(This.GetRow(),TRUE)

end event

event retrieveend;long ll_row,ll_indice_tipos_impositivos,ll_total_tipos_impositivos
string ls_sel,ls_tipos_impositivos,ls_resultado_envio,ls_moneda
string ls_base_imponible,ls_tipo_impositivo,ls_cuota,ls_nombre_moneda,ls_mascara_moneda,ls_mascara_tipoimpositivo

str_contasii lstr_contasii
str_contasii_tiposimpositivos lstr_contasii_tiposimpositivos
str_contasii_envios lstr_contasii_envios

datastore ds_tipos_impositivos

this.setredraw(false)

ls_moneda = f_moneda_empresa(codigo_empresa)
ls_nombre_moneda = f_nombre_moneda_abr(ls_moneda)
ls_mascara_moneda = f_mascara_moneda(ls_moneda)
ls_mascara_tipoimpositivo = "##0.0"

for ll_row = 1 to rowcount				
	f_mensaje_proceso('Recuperando',ll_row,rowcount)
	lstr_contasii.empresa = this.object.empresa[ll_row]
	lstr_contasii.ejercicio = this.object.ejercicio[ll_row]
	lstr_contasii.factura = this.object.factura[ll_row]
	lstr_contasii.tipoter = this.object.tipoter[ll_row]
	lstr_contasii.tercero = this.object.tercero[ll_row]			
	
	ls_sel = "  SELECT contasii_tiposimpositivos.tipoiva, "+&
				"			 contasii_tiposimpositivos.tipoimpositivo, "+&
				"         contasii_tiposimpositivos.exenta, "+&
				"			 contasii_tiposimpositivos.tiponoexenta, "+&
				"			 contasii_tiposimpositivos.causaexencion, "+&
				"			 contasii_tiposimpositivos.baseimponible, "+&
				"			 contasii_tiposimpositivos.cuota, "+&
				"			 contasii_tiposimpositivos.tiporecargoequivalencia, "+&
				"			 contasii_tiposimpositivos.cuotarecargo, "+&
				"         contasii_tiposimpositivos.entrega_o_servicio "+&
				"	FROM   contasii_tiposimpositivos "+&
				"	WHERE  contasii_tiposimpositivos.empresa = '"+lstr_contasii.empresa+"' "+&
				"	AND	 contasii_tiposimpositivos.ejercicio = "+string(lstr_contasii.ejercicio,"###0")+" "+&
				"	AND	 contasii_tiposimpositivos.factura = '"+lstr_contasii.factura+"' "+&
				"	AND	 contasii_tiposimpositivos.tipoter = '"+lstr_contasii.tipoter+"' "+&
				"	AND	 contasii_tiposimpositivos.tercero = '"+lstr_contasii.tercero+"' "+&
				"  ORDER BY contasii_tiposimpositivos.tipoimpositivo"
				
	ll_total_tipos_impositivos = f_cargar_cursor_transaccion(sqlca,ds_tipos_impositivos,ls_sel)

	ls_tipos_impositivos = ""
	
	for ll_indice_tipos_impositivos = 1 to ll_total_tipos_impositivos		
		lstr_contasii_tiposimpositivos.baseimponible       = ds_tipos_impositivos.object.baseimponible[ll_indice_tipos_impositivos]
		lstr_contasii_tiposimpositivos.tipoimpositivo = ds_tipos_impositivos.object.tipoimpositivo[ll_indice_tipos_impositivos]
		lstr_contasii_tiposimpositivos.cuota = ds_tipos_impositivos.object.cuota[ll_indice_tipos_impositivos]
		
		ls_base_imponible  = string(lstr_contasii_tiposimpositivos.baseimponible,ls_mascara_moneda)+ls_nombre_moneda
		ls_base_imponible  = Space(12 - len(ls_base_imponible))+ls_base_imponible
		ls_tipo_impositivo = string(lstr_contasii_tiposimpositivos.tipoimpositivo,ls_mascara_tipoimpositivo)+' %'
		ls_tipo_impositivo = Space(7 - len(ls_tipo_impositivo))+ls_tipo_impositivo
		ls_cuota           = string(lstr_contasii_tiposimpositivos.cuota,ls_mascara_moneda)+ls_nombre_moneda
		ls_cuota           = Space(11 - len(ls_cuota))+ls_cuota
		
		if ls_tipos_impositivos = "" then
			ls_tipos_impositivos = ls_base_imponible+ls_tipo_impositivo+ls_cuota
		else
			ls_tipos_impositivos = '~n'+ls_base_imponible+ls_tipo_impositivo+ls_cuota//'~n---------------~n'+ls_base_imponible+'~n'+ls_tipo_impositivo+'~n'+ls_cuota
		end if
	next
	
	destroy ds_tipos_impositivos
	
	lstr_contasii_envios.fichero_envio   = ""
	lstr_contasii_envios.resultado_envio = ""
	
	SELECT contasii_envios.fecha_envio,
			 isnull(contasii_envios.fichero_envio,''),
			 isnull(contasii_envios.resultado_envio,'') 
	INTO   :lstr_contasii_envios.fecha_envio,
			 :lstr_contasii_envios.fichero_envio,
			 :lstr_contasii_envios.resultado_envio 			 
	FROM   contasii_envios	
	WHERE  contasii_envios.empresa   = :lstr_contasii.empresa
	AND    contasii_envios.ejercicio = :lstr_contasii.ejercicio
	AND    contasii_envios.factura   = :lstr_contasii.factura
	AND    contasii_envios.tipoter   = :lstr_contasii.tipoter
	AND    contasii_envios.tercero   = :lstr_contasii.tercero
   AND    contasii_envios.fecha_envio = (SELECT MAX(contasii_envios_ultimo.fecha_envio) 
														FROM   contasii_envios as contasii_envios_ultimo	
														WHERE  contasii_envios_ultimo.empresa   = contasii_envios.empresa
														AND    contasii_envios_ultimo.ejercicio = contasii_envios.ejercicio
														AND    contasii_envios_ultimo.factura   = contasii_envios.factura
														AND    contasii_envios_ultimo.tipoter   = contasii_envios.tipoter
														AND    contasii_envios_ultimo.tercero   = contasii_envios.tercero);	
		
	if lstr_contasii_envios.resultado_envio <> "" then
		ls_resultado_envio = string(lstr_contasii_envios.fecha_envio,"dd-mm-yyyy hh:mm")+" "+lstr_contasii_envios.resultado_envio
	else
		ls_resultado_envio = ""
	end if
	
	this.object.tipos_impositivos[ll_row] = ls_tipos_impositivos
	this.object.resultado_envio[ll_row] = ls_resultado_envio
	
	if ls_resultado_envio = "" then
		this.object.correcto[ll_row] = 'N'
		this.object.incorrecto[ll_row] = 'N'		
	else
		if pos(upper(ls_resultado_envio),'INCORRECTO') > 0 then
			this.object.correcto[ll_row] = 'N'
			this.object.incorrecto[ll_row] = 'S'			
		else
			this.object.correcto[ll_row] = 'S'
			this.object.incorrecto[ll_row] = 'N'			
		end if
	end if
next

this.setredraw(true)
end event

