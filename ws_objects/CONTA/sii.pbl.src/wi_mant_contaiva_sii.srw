$PBExportHeader$wi_mant_contaiva_sii.srw
forward
global type wi_mant_contaiva_sii from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_contaiva_sii
end type
type uo_ejercicio from u_ejercicio within wi_mant_contaiva_sii
end type
type gb_1 from groupbox within wi_mant_contaiva_sii
end type
end forward

global type wi_mant_contaiva_sii from wi_mvent_con_empresa
integer width = 3643
integer height = 2020
pb_calculadora pb_calculadora
uo_ejercicio uo_ejercicio
gb_1 gb_1
end type
global wi_mant_contaiva_sii wi_mant_contaiva_sii

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;
   istr_parametros.s_titulo_ventana  = "Mantenimiento de tipos de iva"
	istr_parametros.s_listado         = "report_contaiva"
   This.title = istr_parametros.s_titulo_ventana
   uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         This.TriggerEvent("ue_recuperar")
      END IF
   END IF

end event

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[3]   =  trim(uo_ejercicio.em_ejercicio.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contaiva"

dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
uo_ejercicio.enabled = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"tipoiva",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"ejercicio",Integer(uo_ejercicio.em_ejercicio.text))
// dw_1.setitem(dw_1.getrow(),"incluir_modelo_340","N")

end event

on wi_mant_contaiva_sii.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.uo_ejercicio=create uo_ejercicio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.gb_1
end on

on wi_mant_contaiva_sii.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.uo_ejercicio)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
uo_ejercicio.enabled = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaiva_sii
integer x = 5
integer y = 244
integer width = 3625
integer height = 1692
string dataobject = "dw_contaiva_sii"
end type

event dw_1::key;if KeyDown(KeyEnter!) or KeyDown(KeyTab!) then
	bus_filtro = ""
	bus_campo  = this.GetColumnName()
	choose case bus_campo
		case "ctaiva"
			bus_titulo     = "VENTANA SELECCION DE CUENTAS "
			bus_datawindow = "dw_ayuda_contaplan"
			bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
		case "recargo"
			bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS "
			bus_datawindow = "dw_ayuda_contaiva"
			bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
		case "libro"
			bus_titulo     = "VENTANA SELECCION DE LIBROS DE IVAS "
			bus_datawindow = "dw_ayuda_contalibros"
			bus_filtro     = "ejercicio" + uo_ejercicio.em_ejercicio.text
		case "iva_rectificativo_equivalente"
			bus_datawindow = "dw_ayuda_contaiva"
			bus_filtro     = "ejercicio = "+String(dec(uo_ejercicio.em_ejercicio.text),"####")+" "+&
								  "and tipoiva <> '"+sle_valor.text+"'"
			bus_titulo     = "VENTANA SELECCION DE TIPOS DE IVA"		
		CASE "contaiva_tipoiva_autorep"
			bus_datawindow  = "dw_ayuda_contaiva"
			bus_titulo      = "AYUDA SELECCION TIPOS DE IVA"
			bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text +" and tipoiva <> '"+sle_valor.text+"'"
		CASE "contaiva_tipoiva_autosop"
			bus_datawindow  = "dw_ayuda_contaiva"
			bus_titulo      = "AYUDA SELECCION TIPOS DE IVA"
			bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text +" and tipoiva <> '"+sle_valor.text+"'"					
			
		case else
			SetNull(bus_campo)
	end choose
	call super::Key 
END IF

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contaiva"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_ctaiva'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=uo_ejercicio.em_ejercicio.text
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"ctaiva")
   OpenSheetWithParm(wi_mant_contaplan,lstr_param,ventana_padre,5,Original!) 
CASE 'pb_libro'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"libro")
   OpenSheetWithParm(wi_mant_contalibros,lstr_param,ventana_padre,5,Original!)
 
 
END CHOOSE





end event

event dw_1::rbuttondown;bus_filtro = ""
bus_campo  = this.GetColumnName()
choose case bus_campo
	case "ctaiva"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan"
		bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
	case "recargo"
		bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS "
		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro     = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
	case "libro"
		bus_titulo     = "VENTANA SELECCION DE LIBROS DE IVAS "
		bus_datawindow = "dw_ayuda_contalibros"
		bus_filtro     = "ejercicio" + uo_ejercicio.em_ejercicio.text
	case "iva_rectificativo_equivalente"
		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro     = "ejercicio = "+String(dec(uo_ejercicio.em_ejercicio.text),"####")+" "+&
							  "and tipoiva <> '"+sle_valor.text+"'"
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE IVA"	
	CASE "contaiva_tipoiva_autorep"
		bus_datawindow  = "dw_ayuda_contaiva"
		bus_titulo      = "AYUDA SELECCION TIPOS DE IVA"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text +" and tipoiva <> '"+sle_valor.text+"'"
	CASE "contaiva_tipoiva_autosop"
		bus_datawindow  = "dw_ayuda_contaiva"
		bus_titulo      = "AYUDA SELECCION TIPOS DE IVA"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text +" and tipoiva <> '"+sle_valor.text+"'"				
	case else
		SetNull(bus_campo)
end choose
call super::rbuttondown


end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"ctaiva")
f_valores_numericos(dw_1,"recargo")
end on

event dw_1::itemchanged;int     ejercicio
dec     porcentaje_iva,porcentaje_iva_rectificativo_equivalente
string  iva_rectificativo_equivalente,nombre_campo
string  ls_tipo_libro
string  ls_valores_sii_clave
string  ls_valores_sii_causa_exencion
string  ls_valores_sii_tipo_no_exenta
boolean correcto = true

choose case dwo.name	
	case "iva_rectificativo_equivalente"
		if isnumber(data) then
			iva_rectificativo_equivalente = data
			
			if isnull(iva_rectificativo_equivalente) then iva_rectificativo_equivalente = ""
			
			if iva_rectificativo_equivalente <> "" then
				ejercicio      = this.object.ejercicio[row]
				porcentaje_iva = this.object.iva[row]
				
				select iva
				into   :porcentaje_iva_rectificativo_equivalente
				from   contaiva
				where  ejercicio = :ejercicio
				and    empresa   = :codigo_empresa
				and    tipoiva   = :iva_rectificativo_equivalente;
				
				if sqlca.sqlcode <> 0 then
					correcto = false
					messagebox("Error!!","No hay datos del iva rectificativo")
				else
					if porcentaje_iva_rectificativo_equivalente <> porcentaje_iva then
						correcto = false
						messagebox("Error!!","No se corresponden los % de iva")
					end if
				end if
			end if
		end if
	case "iva"
		porcentaje_iva = dec(data)
		iva_rectificativo_equivalente = this.object.iva_rectificativo_equivalente[row]
		
		if isnull(iva_rectificativo_equivalente) then iva_rectificativo_equivalente = ""
		
		if iva_rectificativo_equivalente <> "" then
			ejercicio      = this.object.ejercicio[row]			
			
			select iva
			into   :porcentaje_iva_rectificativo_equivalente
			from   contaiva
			where  ejercicio = :ejercicio
			and    empresa   = :codigo_empresa
			and    tipoiva   = :iva_rectificativo_equivalente;
			
			if sqlca.sqlcode <> 0 then
				correcto = false
				messagebox("Error!!","No hay datos del iva rectificativo")
			else
				if porcentaje_iva_rectificativo_equivalente <> porcentaje_iva then
					correcto = false
					messagebox("Error!!","No se corresponden los % de iva")
				end if
			end if
		end if
	case "libro"
		ls_tipo_libro = f_contalibros_tipo(this.object.ejercicio[row],this.object.empresa[row],data)
		
		if ls_tipo_libro = 'V' then
			//Ventas L3.1 Clave de regimen especial o trascendencia en facturas expedidas
			ls_valores_sii_clave =  "Operacion de regimen general.~t01"+&
											"/Exportacion.~t02"+&
											"/Operaciones a las que se aplique el regimen especial de bienes usados, objetos de arte, antiguedades y objetos de coleccion.~t03"+&
											"/Regimen especial del oro de inversion.~t04"+&
											"/Regimen especial de las agencias de viajes.~t05"+&
											"/Regimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
											"/Regimen especial del criterio de caja.~t07"+&
											"/Operaciones sujetas al IPSI // IGIC (Impuesto sobre la Produccion, los Servicios y la Importacion // Impuesto General Indirecto Canario).~t08"+&
											"/Facturacion de las prestaciones de servicios de agencias de viaje que actuan como mediadoras en nombre y por cuenta ajena (D.A.4a RD1619//2012).~t09"+&
											"/Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial.....~t10"+&										
											"/Operaciones de arrendamiento de local de negocio sujetas a retencion.~t11"+&
											"/Operaciones de arrendamiento de local de negocio no sujetos a retencion.~t12"+&
											"/Operaciones de arrendamiento de local de negocio sujetas y no sujetas a retencion.~t13"+&
											"/Factura con IVA pendiente de devengo en certificaciones de obra cuyo destinatario sea una Administracion Publica.~t14"+&
											"/Factura con IVA pendiente de devengo en operaciones de tracto sucesivo.~t15"+&
											"/Primer semestre 2017.~t16"
											
											//"/Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que realicen estas funciones de cobro.~t10"+&										
		else
			//Compras L3.2 Clave de regimen especial o trascendencia en facturas recibidas
			ls_valores_sii_clave =  "Operación de régimen general.~t01"+&
											"/Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca.~t02"+&
											"/Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección.~t03"+&
											"/Régimen especial del oro de inversión.~t04"+&
											"/Régimen especial de las agencias de viajes.~t05"+&
											"/Régimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
											"/Régimen especial del criterio de caja.~t07"+&
											"/Operaciones sujetas al IPSI // IGIC (Impuesto sobre la Producción, los Servicios y la Importación // Impuesto General Indirecto Canario).~t08"+&
											"/Adquisiciones intracomunitarias de bienes y prestaciones de servicios.~t09"+&
											"/Operaciones de arrendamiento de local de negocio.~t12"+&
											"/Factura correspondiente a una importación (informada sin asociar a un DUA).~t13"+&
											"/Primer semestre 2017.~t14"		
		end if
		
		this.Object.sii_clave.Values = ls_valores_sii_clave
	
		if ls_tipo_libro = 'V' then
			this.modify("sii_exenta.visible = true")
			this.modify("t_sii_exenta.visible = true")			
			this.modify("sii_tipo_no_exenta.visible = false")
			this.modify("t_sii_tipo_no_exenta.visible = false")	
			this.modify("sii_causa_exencion.visible = false")
			this.modify("t_sii_causa_exencion.visible = false")				
		else
			this.modify("sii_exenta.visible = false")
			this.modify("t_sii_exenta.visible = false")			
			this.modify("sii_tipo_no_exenta.visible = false")
			this.modify("t_sii_tipo_no_exenta.visible = false")	
			this.modify("sii_causa_exencion.visible = false")
			this.modify("t_sii_causa_exencion.visible = false")		
		end if
	
	case "sii_exenta"
		if data = 'S' then
			this.modify("sii_tipo_no_exenta.visible = false")
			this.modify("t_sii_tipo_no_exenta.visible = false")
			
			ls_valores_sii_causa_exencion =  "/Exenta por el artículo 20~tE1"+&
														"/Exenta por el artículo 21~tE2"+&
														"/Exenta por el artículo 22~tE3"+&
														"/Exenta por artículo 23 y 24~tE4"+&
														"/Exenta por el artículo 25~tE5"+&
														"/Exenta por Otros~tE6"
			
			this.Object.sii_causa_exencion.Values = ls_valores_sii_causa_exencion
			
			this.modify("sii_causa_exencion.visible = true")
			this.modify("t_sii_causa_exencion.visible = true")			
		else
			this.modify("sii_causa_exencion.visible = false")
			this.modify("t_sii_causa_exencion.visible = false")						
			
			ls_valores_sii_tipo_no_exenta =  "/No exenta- Sin inversion sujeto pasivo~tS1"+&
														"/No exenta - Con Inversion sujeto pasivo~tS2"+&
														"/No exenta - Sin inversion sujeto pasivo y con Inversion sujeto pasivo~tS3"
			
			this.Object.sii_tipo_no_exenta.Values = ls_valores_sii_tipo_no_exenta		
			
			this.modify("sii_tipo_no_exenta.visible = true")
			this.modify("t_sii_tipo_no_exenta.visible = true")			
		end if		
end choose

if not(correcto) then
	return 2
end if
	

end event

event dw_1::retrieveend;call super::retrieveend;string ls_valores_sii_clave
string ls_valores_sii_causa_exencion
string ls_valores_sii_tipo_no_exenta
string ls_tipo_libro,ls_valor_inicial

if rowcount > 0 then

	ls_tipo_libro = f_contalibros_tipo(this.object.ejercicio[rowcount],this.object.empresa[rowcount],this.object.libro[rowcount])
	
	if ls_tipo_libro = 'V' then
		//Ventas L3.1 Clave de regimen especial o trascendencia en facturas expedidas
		ls_valores_sii_clave =  "Operacion de regimen general.~t01"+&
										"/Exportacion.~t02"+&
										"/Operaciones a las que se aplique el regimen especial de bienes usados, objetos de arte, antiguedades y objetos de coleccion.~t03"+&
										"/Regimen especial del oro de inversion.~t04"+&
										"/Regimen especial de las agencias de viajes.~t05"+&
										"/Regimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
										"/Regimen especial del criterio de caja.~t07"+&
										"/Operaciones sujetas al IPSI // IGIC (Impuesto sobre la Produccion, los Servicios y la Importacion // Impuesto General Indirecto Canario).~t08"+&
										"/Facturacion de las prestaciones de servicios de agencias de viaje que actuan como mediadoras en nombre y por cuenta ajena (D.A.4a RD1619//2012).~t09"+&
										"/Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial.....~t10"+&										
										"/Operaciones de arrendamiento de local de negocio sujetas a retencion.~t11"+&
										"/Operaciones de arrendamiento de local de negocio no sujetos a retencion.~t12"+&
										"/Operaciones de arrendamiento de local de negocio sujetas y no sujetas a retencion.~t13"+&
										"/Factura con IVA pendiente de devengo en certificaciones de obra cuyo destinatario sea una Administracion Publica.~t14"+&
										"/Factura con IVA pendiente de devengo en operaciones de tracto sucesivo.~t15"+&
										"/Primer semestre 2017.~t16"
										
										//"/Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que realicen estas funciones de cobro.~t10"+&										
	else
		//Compras L3.2 Clave de regimen especial o trascendencia en facturas recibidas
		ls_valores_sii_clave =  "Operación de régimen general.~t01"+&
										"/Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca.~t02"+&
										"/Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección.~t03"+&
										"/Régimen especial del oro de inversión.~t04"+&
										"/Régimen especial de las agencias de viajes.~t05"+&
										"/Régimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
										"/Régimen especial del criterio de caja.~t07"+&
										"/Operaciones sujetas al IPSI // IGIC (Impuesto sobre la Producción, los Servicios y la Importación // Impuesto General Indirecto Canario).~t08"+&
										"/Adquisiciones intracomunitarias de bienes y prestaciones de servicios.~t09"+&
										"/Operaciones de arrendamiento de local de negocio.~t12"+&
										"/Factura correspondiente a una importación (informada sin asociar a un DUA).~t13"+&
										"/Primer semestre 2017.~t14"		
	end if
	
	this.Object.sii_clave.Values = ls_valores_sii_clave
	
	if ls_tipo_libro = 'V' then
		this.modify("sii_exenta.visible = true")
		this.modify("t_sii_exenta.visible = true")			
		
		if this.object.sii_exenta[rowcount] = 'S' then
			this.modify("sii_tipo_no_exenta.visible = false")
			this.modify("t_sii_tipo_no_exenta.visible = false")
			
			ls_valores_sii_causa_exencion =  "/Exenta por el artículo 20~tE1"+&
														"/Exenta por el artículo 21~tE2"+&
														"/Exenta por el artículo 22~tE3"+&
														"/Exenta por artículo 23 y 24~tE4"+&
														"/Exenta por el artículo 25~tE5"+&
														"/Exenta por Otros~tE6"
			
			this.Object.sii_causa_exencion.Values = ls_valores_sii_causa_exencion
			
			this.modify("sii_causa_exencion.visible = true")
			this.modify("t_sii_causa_exencion.visible = true")			
		else
			this.modify("sii_causa_exencion.visible = false")
			this.modify("t_sii_causa_exencion.visible = false")						
			
			ls_valores_sii_tipo_no_exenta =  "/No exenta- Sin inversion sujeto pasivo~tS1"+&
														"/No exenta - Con Inversion sujeto pasivo~tS2"+&
														"/No exenta - Sin inversion sujeto pasivo y con Inversion sujeto pasivo~tS3"
			
			this.Object.sii_tipo_no_exenta.Values = ls_valores_sii_tipo_no_exenta		
			
			this.modify("sii_tipo_no_exenta.visible = true")
			this.modify("t_sii_tipo_no_exenta.visible = true")			
		end if
	else				
		this.modify("sii_exenta.visible = false")
		this.modify("t_sii_exenta.visible = false")			
		this.modify("sii_tipo_no_exenta.visible = false")
		this.modify("t_sii_tipo_no_exenta.visible = false")	
		this.modify("sii_causa_exencion.visible = false")
		this.modify("t_sii_causa_exencion.visible = false")					
	end if
	
else
	ls_valor_inicial = this.Object.libro.Initial
	
	if isnull(ls_valor_inicial) then ls_valor_inicial = ""	
	
	if ls_valor_inicial <> "" then
		ls_tipo_libro = f_contalibros_tipo(f_ejercicio_activo(codigo_empresa),codigo_empresa,ls_valor_inicial)
		
		if ls_tipo_libro = 'V' then
			//Ventas L3.1 Clave de regimen especial o trascendencia en facturas expedidas
			ls_valores_sii_clave =  "Operacion de regimen general.~t01"+&
											"/Exportacion.~t02"+&
											"/Operaciones a las que se aplique el regimen especial de bienes usados, objetos de arte, antiguedades y objetos de coleccion.~t03"+&
											"/Regimen especial del oro de inversion.~t04"+&
											"/Regimen especial de las agencias de viajes.~t05"+&
											"/Regimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
											"/Regimen especial del criterio de caja.~t07"+&
											"/Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Produccion, los Servicios y la Importacion / Impuesto General Indirecto Canario).~t08"+&
											"/Facturacion de las prestaciones de servicios de agencias de viaje que actuan como mediadoras en nombre y por cuenta ajena (D.A.4a RD1619/2012).~t09"+&
											"/Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que realicen estas funciones de cobro.~t10"+&
											"/Operaciones de arrendamiento de local de negocio sujetas a retencion.~t11"+&
											"/Operaciones de arrendamiento de local de negocio no sujetos a retencion.~t12"+&
											"/Operaciones de arrendamiento de local de negocio sujetas y no sujetas a retencion.~t13"+&
											"/Factura con IVA pendiente de devengo en certificaciones de obra cuyo destinatario sea una Administracion Publica.~t14"+&
											"/Factura con IVA pendiente de devengo en operaciones de tracto sucesivo.~t15"+&
											"/Primer semestre 2017.~t16"
		else
			//Compras L3.2 Clave de regimen especial o trascendencia en facturas recibidas
			ls_valores_sii_clave =  "Operación de régimen general.~t01"+&
											"/Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca.~t02"+&
											"/Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección.~t03"+&
											"/Régimen especial del oro de inversión.~t04"+&
											"/Régimen especial de las agencias de viajes.~t05"+&
											"/Régimen especial grupo de entidades en IVA (Nivel Avanzado).~t06"+&
											"/Régimen especial del criterio de caja.~t07"+&
											"/Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Producción, los Servicios y la Importación / Impuesto General Indirecto Canario).~t08"+&
											"/Adquisiciones intracomunitarias de bienes y prestaciones de servicios.~t09"+&
											"/Operaciones de arrendamiento de local de negocio.~t12"+&
											"/Factura correspondiente a una importación (informada sin asociar a un DUA).~t13"+&
											"/Primer semestre 2017.~t14"		
		end if
		
		this.Object.sii_clave.Values = ls_valores_sii_clave
		
		if ls_tipo_libro = 'V' then
			ls_valor_inicial = this.Object.sii_exenta.Initial
			
			if isnull(ls_valor_inicial) then ls_valor_inicial = ""	
			
			if ls_valor_inicial = 'S' then
				this.modify("sii_tipo_no_exenta.visible = false")
				this.modify("t_sii_tipo_no_exenta.visible = false")
				
				ls_valores_sii_causa_exencion =  "/Exenta por el artículo 20~tE1"+&
															"/Exenta por el artículo 21~tE2"+&
															"/Exenta por el artículo 22~tE3"+&
															"/Exenta por artículo 23 y 24~tE4"+&
															"/Exenta por el artículo 25~tE5"+&
															"/Exenta por Otros~tE6"
				
				this.Object.sii_causa_exencion.Values = ls_valores_sii_causa_exencion
				
				this.modify("sii_causa_exencion.visible = true")
				this.modify("t_sii_causa_exencion.visible = true")			
			else
				this.modify("sii_causa_exencion.visible = false")
				this.modify("t_sii_causa_exencion.visible = false")						
				
				ls_valores_sii_tipo_no_exenta =  "/No exenta- Sin inversion sujeto pasivo~tS1"+&
															"/No exenta - Con Inversion sujeto pasivo~tS2"+&
															"/No exenta - Sin inversion sujeto pasivo y con Inversion sujeto pasivo~tS3"
				
				this.Object.sii_tipo_no_exenta.Values = ls_valores_sii_tipo_no_exenta		
				
				this.modify("sii_tipo_no_exenta.visible = true")
				this.modify("t_sii_tipo_no_exenta.visible = true")			
			end if
		else				
			this.modify("sii_exenta.visible = false")
			this.modify("t_sii_exenta.visible = false")			
			this.modify("sii_tipo_no_exenta.visible = false")
			this.modify("t_sii_tipo_no_exenta.visible = false")	
			this.modify("sii_causa_exencion.visible = false")
			this.modify("t_sii_causa_exencion.visible = false")					
		end if		
		
	end if
end if
/*

*/
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaiva_sii
integer x = 201
integer y = 140
integer width = 270
string text = "Tipo iva"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaiva_sii
integer x = 1143
integer y = 144
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaiva_sii
integer x = 1550
integer y = 144
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaiva_sii
integer x = 507
integer y = 136
integer width = 370
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_contaiva"
ue_titulo      = "AYUDA SELECCION TIPOS DE IVA"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaiva_sii
integer x = 1957
integer y = 144
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaiva_sii
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaiva_sii
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaiva_sii
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_contaiva_sii
integer x = 919
integer y = 128
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled = TRUE THEN
  Return
END IF

 Integer registros,var_ejercicio
 var_ejercicio = Integer(uo_ejercicio.em_ejercicio.text)

 Select count(*) Into :registros
 From   contaiva
 Where  contaiva.ejercicio = :var_ejercicio
 and    contaiva.empresa   = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,contaiva.tipoiva)+1) Into   :sle_valor.text
  From   contaiva
  Where  contaiva.ejercicio = :var_ejercicio
  and    contaiva.empresa   = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

type uo_ejercicio from u_ejercicio within wi_mant_contaiva_sii
integer x = 2898
integer y = 148
integer height = 452
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type gb_1 from groupbox within wi_mant_contaiva_sii
integer x = 1129
integer y = 108
integer width = 1248
integer height = 132
integer taborder = 11
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

