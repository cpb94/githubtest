$PBExportHeader$w_con_349_gno.srw
$PBExportComments$Intracomunitarios
forward
global type w_con_349_gno from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_349_gno
end type
type pb_2 from upb_imprimir within w_con_349_gno
end type
type em_fechadesde from u_em_campo within w_con_349_gno
end type
type em_fechahasta from u_em_campo within w_con_349_gno
end type
type dw_listado from datawindow within w_con_349_gno
end type
type cb_1 from commandbutton within w_con_349_gno
end type
type gb_3 from groupbox within w_con_349_gno
end type
type uo_cliente from u_em_campo_2 within w_con_349_gno
end type
type gb_2 from groupbox within w_con_349_gno
end type
type cb_2 from commandbutton within w_con_349_gno
end type
type gb_1 from groupbox within w_con_349_gno
end type
type cb_3 from u_boton within w_con_349_gno
end type
type dw_lineas from datawindow within w_con_349_gno
end type
type dw_proceso from datawindow within w_con_349_gno
end type
type em_telefono_contacto from u_em_campo within w_con_349_gno
end type
type em_persona_contacto from u_em_campo within w_con_349_gno
end type
type st_1 from statictext within w_con_349_gno
end type
type st_2 from statictext within w_con_349_gno
end type
type pb_4 from picturebutton within w_con_349_gno
end type
type dw_detalle from datawindow within w_con_349_gno
end type
type gb_10 from groupbox within w_con_349_gno
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_349_gno from w_int_con_empresa
integer width = 3607
integer height = 1916
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_3 gb_3
uo_cliente uo_cliente
gb_2 gb_2
cb_2 cb_2
gb_1 gb_1
cb_3 cb_3
dw_lineas dw_lineas
dw_proceso dw_proceso
em_telefono_contacto em_telefono_contacto
em_persona_contacto em_persona_contacto
st_1 st_1
st_2 st_2
pb_4 pb_4
dw_detalle dw_detalle
gb_10 gb_10
end type
global w_con_349_gno w_con_349_gno

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data, string gg)
public function string f_tratar_nif (string arg_nif, string arg_codigo_pais, string arg_tercero)
public subroutine f_graba_soporte_magnetico ()
public subroutine f_trata_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta)
public subroutine f_tratar_texto (ref string arg_texto)
public subroutine f_tratar_numero (ref string arg_numero)
public subroutine f_carga_dw (datawindow arg_dw)
public subroutine f_graba_soporte_magnetico_cristal ()
public subroutine f_graba_soporte_magnetico_old ()
public subroutine f_cargar_dw_detalle (datawindow arg_dw)
end prototypes

public subroutine f_control (datawindow data, string gg);DateTime f1,f2
Dec ii,i,importe,c
String factura,pais
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))
string cli1,cli2,serie1,serie2,nif,pr,razon_cliente,moneda_empresa,cuenta
cli1 = char(1)
cli2 = char(255)

data.setredraw(false)
data.SetSort("")
data.Sort()

moneda_empresa = f_moneda_empresa(codigo_empresa)

serie1 = 'C'
serie2 = 'C'

IF Trim(uo_cliente.em_codigo.text) <> "" Then
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF
data.retrieve(codigo_empresa,f1,f2,cli1,cli2,serie1,serie2)

iF gg = "S" Then
	// Agregar compras
	
	String sel
	
	sel = " Select nif,clipro,factura,imponible from contaapun  " +&
			" Where  ejercicio = " +STring(Year(date(f1)),"####")+&
			" And    empresa   = '" +codigo_empresa+"'"+&
			" And    fapunte between '" + String(Date(em_fechadesde.text),formato_fecha_cursores) + "' and '" + String(Date(em_fechahasta.text),formato_fecha_cursores) +"'"+&
			" And    tipoapu = '4' "+&
			" And    tipoter = 'P'"+&
			" And    cuenta  LIKE '472%' "
			
	DataStore	dw_intra
	dw_intra = f_cargar_cursor(sel)
	
	For ii = 1 To dw_intra.RowCount()
		i ++
		nif     = trim(dw_intra.Object.nif[ii])
		pr      = dw_intra.Object.clipro[ii]
		pais    = f_pais_genter(codigo_empresa,"P",pr)
		cuenta  = f_cuenta_genter(codigo_empresa,"P",pr)
		
		//Quitamos los agentes
		if left(cuenta,4) <> "4104" then
			importe = dw_intra.Object.imponible[ii]
			if f_tipo_pais(pais) = "C" then
				c = data.insertrow(0)
				factura = (dw_intra.Object.factura[ii])
				data.Object.facturac[c]        = factura
				data.Object.paises_nombre[c]   = f_nombre_pais(pais)
				data.Object.empresa[c]         = codigo_empresa
				data.Object.cliente[c]         = pr
				data.Object.genter_cif[c]      = nif
				data.Object.tti[c]             = "P"
				data.Object.total_fac[c]       = importe
				data.Object.total_fac_pts[c]   = importe
				data.Object.divisa[c]          = moneda_empresa
			end if
		end if
	Next
END IF
data.setredraw(true)
data.SetSort("genter_cif")
data.Sort()
data.GroupCalc()
destroy dw_intra
end subroutine

public function string f_tratar_nif (string arg_nif, string arg_codigo_pais, string arg_tercero);string var_nif,nuevo_nif,caracter
long   indice,total,asci,longitud_nif
boolean nif_alfanumerico

if isnull(arg_nif) then arg_nif = ""

choose case arg_codigo_pais
	case "ES","AT","FR","GB","NL","IE","CY"
		nif_alfanumerico = TRUE
	case else
		nif_alfanumerico = false
end choose

var_nif = Upper(trim(arg_nif))
nuevo_nif = ""
total = len(var_nif)
for indice = 1 to total
	caracter = mid(var_nif,indice,1)
	asci     = asc(caracter)
	if (asci >= 65 and asci <= 90 and nif_alfanumerico) or (asci >= 48 and asci <= 57) then
		nuevo_nif = nuevo_nif + caracter
	end if
next

if mid(nuevo_nif,1,2) = arg_codigo_pais then
	nuevo_nif = mid(nuevo_nif,3,len(nuevo_nif)- 2)
end if

choose case arg_codigo_pais
	case "ES"
		longitud_nif = 9
	case "DE"
		longitud_nif = 9
	case "AT"
		longitud_nif = 9
	case "BE"
		longitud_nif = 9
	case "DK"
		longitud_nif = 8
	case "FI"
		longitud_nif = 8
	case "FR"
		longitud_nif = 11
	case "EL"
		longitud_nif = 9
	case "GB"
		longitud_nif = 0
	case "NL"
		longitud_nif = 12
	case "IT"
		longitud_nif = 11
	case "IE"
		longitud_nif = 8
	case "LU"
		longitud_nif = 8
	case "PT"
		longitud_nif = 9
	case "SE"
		longitud_nif = 12	
	case else
		longitud_nif = -1
end choose

if longitud_nif > 0 then
	if len(nuevo_nif) <> longitud_nif then	
		messagebox("Error en NIF "+arg_codigo_pais,"El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
	end if
else
	if longitud_nif = 0 then
		//Malditos Ingleses
		choose case arg_codigo_pais
			case "GB"
				if len(nuevo_nif) <> 5 and len(nuevo_nif) <> 9 and len(nuevo_nif) <> 12 then	
					messagebox("Error en NIF "+arg_codigo_pais,"El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
				end if		
			case "LT"		
				if len(nuevo_nif) <> 9 and len(nuevo_nif) <> 12 then	
					messagebox("Error en NIF "+arg_codigo_pais,"El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
				end if		
			case "CZ"		
				if len(nuevo_nif) <> 8 and len(nuevo_nif) <> 9 and len(nuevo_nif) <> 10 then	
					messagebox("Error en NIF "+arg_codigo_pais,"El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
				end if		
			case "SK"		
				if len(nuevo_nif) <> 9 and len(nuevo_nif) <> 10 then	
					messagebox("Error en NIF "+arg_codigo_pais,"El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
				end if		
		end choose
	end if
end if
return nuevo_nif
end function

public subroutine f_graba_soporte_magnetico ();string   v_linea,v_sel
long     v_indice,v_total,v_donde
datetime v_fecha_desde,v_fecha_hasta
datastore ds_datos
//
string v_tipo_registro,v_modelo_de_presentacion,v_ejercicio,v_nif_del_presentador,v_razon_social_del_presentador
string v_domicilio_del_presentador,v_total_declarantes,v_total_entidades_relacionadas,v_tipo_soporte
string v_telefono_contacto,v_persona_contacto
string v_persona_con_quien_relacionarse,v_periodo,v_blancos,v_sello_electronico
string v_siglas_via_publica,v_nombre_via_publica,v_numero,v_escalera,v_piso,v_puerta,v_codigo_postal
string v_municipio,v_codigo_provincia
string v_modelo_declaracion,v_nif_del_declarante,v_razon_social_del_declarante,v_numero_de_justificante_declaracion
string v_declaracion_complementaria_sustitutiva,v_numero_justificante_declaracion_anterior
string v_numero_total_operadores,v_importe_operaciones_intracomunitarias,v_numero_total_operadores_con_rectificaciones
string v_importe_rectificaciones
string v_nif_operador_comunitario,v_razon_social_operador_intracomunitario,v_clave_operacion,v_base_imponible,v_blancos2
string v_codigo_pais,v_tipoter,v_clipro,v_cuenta_operador_intracomunitario
dec    v_base_imponible_decimal,v_base_imponible_rectificada_decimal,v_base_imponible_declarada_anteriormente_decimal
string v_rectificaciones,v_ejercicio_rectificacion,v_periodo_rectificacion,v_base_imponible_rectificada
string v_base_imponible_declarada_anteriormente,v_blancos3,ls_indicador_cambio_periodicidad,ls_nif_representante_legal
datetime v_fecha_desde_periodo_rectificacion,v_fecha_hasta_periodo_rectificacion
dec      v_numero_total_operadores_decimal,v_importe_operaciones_intracomunitarias_decimal
dec      v_numero_total_operadores_con_rectificaciones_decimal,v_importe_rectificaciones_decimal
int      li_mes_desde,li_mes_hasta

str_parametros datos_rectificacion
tipo_array rectificacion
 
dw_lineas.reset()
 
v_fecha_desde = datetime(date(em_fechadesde.text))
v_fecha_hasta = datetime(date(em_fechahasta.text))
 
li_mes_desde = month(date(em_fechadesde.text))
li_mes_hasta = month(date(em_fechahasta.text))
 
if year(date(v_fecha_desde)) <> year(date(v_fecha_hasta)) then 
 f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
 return
end if
 
if v_fecha_desde > v_fecha_hasta then
 f_mensaje("Atención","Fecha desde mayor que fecha hasta")
 return
end if
 
if trim(em_telefono_contacto.text) = "" then
 f_mensaje("Atención","Debe introducir el telefono de contacto.")
 return 
else
 if len(em_telefono_contacto.text) <> 9 then
  f_mensaje("Atención","El telefono de contacto debe ser de 9 digitos.")
  return   
 end if
end if
 
if trim(em_persona_contacto.text) = "" then
 f_mensaje("Atención","Debe introducir la Persona de contacto.")
 return 
end if
 
v_ejercicio                      = string(year(date(em_fechahasta.text)),"0000")

if li_mes_desde = li_mes_hasta or li_mes_desde+1 = li_mes_hasta then
	//Mensual
	v_periodo = string(li_mes_hasta,"00")
	if li_mes_desde = li_mes_hasta then
		ls_indicador_cambio_periodicidad = " "
	else
		if li_mes_hasta = 2 or li_mes_hasta = 5 or li_mes_hasta = 8 or li_mes_hasta = 11 then
			ls_indicador_cambio_periodicidad = "X"
		else
			ls_indicador_cambio_periodicidad = " "
		end if
	end if
else
	if li_mes_desde = 1 and li_mes_hasta = 12 then
		//Anual
		v_periodo = "0A"
		ls_indicador_cambio_periodicidad = " "
	else
		
		//Trimestral
		ls_indicador_cambio_periodicidad = " "
		if month(date(em_fechadesde.text)) >=1 Then v_periodo = "1T"
		if month(date(em_fechadesde.text)) >3 Then v_periodo = "2T"
		if month(date(em_fechadesde.text)) >6 Then v_periodo = "3T"
		if month(date(em_fechadesde.text)) >9 Then v_periodo = "4T"
	end if
end if 

select nombre,         domicilio,     ciudad,
   provincia,        codpostal,     cif,
   cl_domicilio,       nu_domicilio
into   :v_razon_social_del_presentador,:v_nombre_via_publica,  :v_municipio,
   :v_codigo_provincia,            :v_codigo_postal,       :v_nif_del_presentador,
   :v_siglas_via_publica,          :v_numero
from   empresas
where  empresa = :codigo_empresa;
 
v_escalera = ''
v_piso     = ''
v_puerta   = ''
 
v_nif_del_presentador            = f_tratar_nif(v_nif_del_presentador,"ES",v_razon_social_del_presentador)
f_trata_campo(v_nif_del_presentador,'A',9,17)
v_nif_del_declarante              = v_nif_del_presentador
 
v_sel = "SELECT sum(contaapun.imponible) imponible, "+&
     "contaapun.tipoter, "+&
     "contaapun.clipro, "+&
     "genter.razon, "+&
     "genter.cif, "+&
     "genter.pais, "+& 
     "genter.cuenta, "+& 
     "paises.clave "+&
    "FROM contaapun, "+&   
    "genter, "+&
    "paises "+&
    "WHERE ( contaapun.empresa = genter.empresa ) "+&
    "AND   ( contaapun.tipoter = genter.tipoter ) "+&
    "AND   ( contaapun.clipro = genter.codigo ) "+&
    "AND   ( genter.pais = paises.pais ) "+&
    "AND   (( contaapun.empresa = '"+codigo_empresa+"') "+&
    "AND   ( contaapun.fapunte between '"+string(v_fecha_desde,formato_fecha_cursores)+"' and '"+string(v_fecha_hasta,formato_fecha_cursores)+"' ) "+&
    "AND   ( contaapun.fapunte >= paises.fecha_ingreso_cee ) "+&
    "AND   ( paises.tipopais = 'C' ) "+&
    "AND     tipoiva in (SELECT tipoiva from contaiva "+&
             "WHERE ejercicio = "+string(dec(v_ejercicio),"####")+" "+&
             "AND   empresa   = '"+codigo_empresa+"' " +&
             "AND   incluir_modelo_en_349 = 'S' )) "+&
    "GROUP BY contaapun.tipoter, "+&
    "contaapun.clipro, "+&
    "genter.razon, "+&
    "genter.cif, "+&
    "genter.pais, "+& 
    "genter.cuenta, "+& 
    "paises.clave "+&
    "ORDER BY contaapun.tipoter,"+&
    "genter.razon"
  
f_cargar_cursor_transaccion(sqlca,ds_datos,v_sel)
 
v_total = ds_datos.rowcount()
 
v_numero_total_operadores_decimal = 0
 
v_importe_operaciones_intracomunitarias_decimal = 0
 
v_numero_total_operadores_con_rectificaciones_decimal = 0
 
v_importe_rectificaciones_decimal = 0
 
for v_indice = 1 to v_total
 f_mensaje_proceso('Calculando',v_indice,v_total)
 v_cuenta_operador_intracomunitario = ds_datos.object.genter_cuenta[v_indice]
 if left(v_cuenta_operador_intracomunitario,4) <> "4101" or 1 = 1 then
  //No es un agente
  v_base_imponible_decimal                 = ds_datos.object.imponible[v_indice]
  if v_base_imponible_decimal <> 0 then
   if v_base_imponible_decimal > 0 then
    v_numero_total_operadores_decimal ++
    
    v_importe_operaciones_intracomunitarias_decimal += v_base_imponible_decimal
    //C) TIPO DE REGISTRO 2:REGISTRO DE OPERADOR INTRACOMUNITARIO
    v_tipo_registro      = '2'
    v_modelo_declaracion = '349'
    v_blancos            = ''
    f_trata_campo(v_blancos,'A',18,75)
    
    v_nif_operador_comunitario               = ds_datos.object.genter_cif[v_indice]
    v_codigo_pais                            = ds_datos.object.paises_clave[v_indice]
    v_razon_social_operador_intracomunitario = ds_datos.object.genter_razon[v_indice]
    
	 //Nifs griegos no utilizan el codigo iso
	 if v_codigo_pais = "GR" then v_codigo_pais = "EL"
	 
    v_nif_operador_comunitario               = v_codigo_pais + f_tratar_nif(v_nif_operador_comunitario,v_codigo_pais,v_razon_social_operador_intracomunitario)
    f_trata_campo(v_nif_operador_comunitario,'A',76,92) 
    
    f_trata_campo(v_razon_social_operador_intracomunitario,'A',93,132) 
    
    v_tipoter                                = ds_datos.object.contaapun_tipoter[v_indice]
    choose case v_tipoter
     case "C"
      //Clientes
      //Entregas intracomunitarias exentas.
      v_clave_operacion = "E"
     case "P"
      //Proveedores        
		if left(v_cuenta_operador_intracomunitario,4) = "4101" then
			//Agentes adquisiciones de servicios
			v_clave_operacion = "I"
		else
			//Adquisiciones intracomunitarias sujetas. 
      	v_clave_operacion = "A"
		end if
    end choose 
    
    v_base_imponible                         = string(v_base_imponible_decimal * 100,"############0")
    f_trata_campo(v_base_imponible,'N',134,146)
    
    v_blancos2           = ''
    f_trata_campo(v_blancos2,'A',147,500)
    
    v_linea  = v_tipo_registro +&
         v_modelo_declaracion +&
         v_ejercicio +&
         v_nif_del_declarante +& 
         v_blancos +&
         v_nif_operador_comunitario +&
         v_razon_social_operador_intracomunitario +&
         v_clave_operacion +&
         v_base_imponible +&
         v_blancos2
         
    v_donde = dw_lineas.insertrow(0)
    
    dw_lineas.Object.linea[v_donde] = v_linea       
   else
    v_numero_total_operadores_con_rectificaciones_decimal ++   
    //C) TIPO DE REGISTRO 2:REGISTRO DE OPERADOR INTRACOMUNITARIO (CON RECTIFICACIONES)
    v_tipo_registro      = '2'
    v_modelo_declaracion = '349'
    v_blancos            = ''
    f_trata_campo(v_blancos,'A',18,75)
    
    v_nif_operador_comunitario               = ds_datos.object.genter_cif[v_indice]
    v_codigo_pais                            = ds_datos.object.paises_clave[v_indice]
    v_razon_social_operador_intracomunitario = ds_datos.object.genter_razon[v_indice]
    
    v_nif_operador_comunitario               = v_codigo_pais + f_tratar_nif(v_nif_operador_comunitario,v_codigo_pais,v_razon_social_operador_intracomunitario)
    f_trata_campo(v_nif_operador_comunitario,'A',76,92) 
    
    f_trata_campo(v_razon_social_operador_intracomunitario,'A',93,132) 
    
    v_tipoter                                = ds_datos.object.contaapun_tipoter[v_indice]
    v_clipro                                 = ds_datos.object.contaapun_clipro[v_indice]
    choose case v_tipoter
     case "C"
      //Clientes
      //Entregas intracomunitarias exentas.
      v_clave_operacion = "E"
     case "P"
      //Proveedores
      //Adquisiciones intracomunitarias sujetas.   
		if left(v_cuenta_operador_intracomunitario,4) = "4101" then
			//Agentes adquisiciones de servicios
			v_clave_operacion = "I"
		else
			//Adquisiciones intracomunitarias sujetas. 
      	v_clave_operacion = "A"
		end if
    end choose 
       
    v_blancos2           = ''
    f_trata_campo(v_blancos2,'A',134,146)
       
    //REGISTRO DE RECTIFICACIONES
    datos_rectificacion.s_argumentos[1] = String(v_ejercicio)
    datos_rectificacion.s_argumentos[2] = v_periodo
    datos_rectificacion.s_argumentos[3] = v_razon_social_operador_intracomunitario
    datos_rectificacion.s_argumentos[4] = string(v_base_imponible_decimal,"###,###,###,##0.00")
  
    openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
  
    rectificacion = message.powerObjectparm
    v_ejercicio_rectificacion = rectificacion.valor[1]
    v_periodo_rectificacion   = rectificacion.valor[2]
    if v_ejercicio_rectificacion = "RETURN" then
     //continuar = false
    else
     choose case v_periodo_rectificacion
      case "12"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),dec(v_periodo_rectificacion),1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion)+1,1,1),-1))
      case "0A"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),1,1))
       v_fecha_hasta_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),12,31))		 
      case "1T"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),1,1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),4,1),-1))
      case "2T"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),4,1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),7,1),-1))      
      case "3T"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),7,1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),10,1),-1))      
      case "4T"
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),10,1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion)+1,1,1),-1))            
      case else
       v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),dec(v_periodo_rectificacion),1))
       v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),dec(v_periodo_rectificacion)+1,1),-1))					 
     end choose
 
     SELECT sum(contaapun.imponible) 
     INTO   :v_base_imponible_declarada_anteriormente_decimal
     FROM   contaapun 
     WHERE  empresa = :codigo_empresa
     AND    tipoter = :v_tipoter
     AND    clipro  = :v_clipro
     AND    fapunte between :v_fecha_desde_periodo_rectificacion and :v_fecha_hasta_periodo_rectificacion
       AND     tipoiva in (SELECT tipoiva from contaiva 
                WHERE ejercicio = :v_ejercicio_rectificacion
                AND   empresa   = :codigo_empresa
                AND   incluir_en_modelo_349 = 'S' );     
     //AND    tipoapu in('3','4','9');
     
     if isnull(v_base_imponible_declarada_anteriormente_decimal) then v_base_imponible_declarada_anteriormente_decimal = 0
	  
		if v_base_imponible_declarada_anteriormente_decimal = 0 then
			messagebox("Atención","En el periodo seleccionado no se han encontrado operaciones con "+v_razon_social_operador_intracomunitario)
		end if
     
     v_base_imponible_rectificada_decimal = v_base_imponible_declarada_anteriormente_decimal + v_base_imponible_decimal
     
     v_importe_rectificaciones_decimal += v_base_imponible_rectificada_decimal
     
     f_trata_campo(v_ejercicio_rectificacion,'N',147,150)
     f_trata_campo(v_periodo_rectificacion,'A',151,152)
     
     v_base_imponible_rectificada = string(v_base_imponible_rectificada_decimal * 100,"############0")
     f_trata_campo(v_base_imponible_rectificada,'N',153,165)
     
     v_base_imponible_declarada_anteriormente = string(v_base_imponible_declarada_anteriormente_decimal * 100,"############0")
     f_trata_campo(v_base_imponible_declarada_anteriormente,'N',166,178)
     
     v_rectificaciones = v_ejercicio_rectificacion +&
             v_periodo_rectificacion +&
             v_base_imponible_rectificada +&
             v_base_imponible_declarada_anteriormente
     
     f_trata_campo(v_rectificaciones,'A',147,178)
     
     v_blancos3           = ''
     f_trata_campo(v_blancos3,'A',179,500)    
     
     v_linea  = v_tipo_registro +&
          v_modelo_declaracion +&
          v_ejercicio +&
          v_nif_del_declarante +& 
          v_blancos +&
          v_nif_operador_comunitario +&
          v_razon_social_operador_intracomunitario +&
          v_clave_operacion +&
          v_blancos2 +&
          v_rectificaciones +&
          v_blancos3
          
     v_donde = dw_lineas.insertrow(0)
     
     dw_lineas.Object.linea[v_donde] = v_linea           
    end if         
   end if
  end if
 end if
next
 
destroy ds_datos
 
//A) TIPO DE REGISTRO 0:REGISTRO DEL PRESENTADOR
 
v_tipo_registro                  = "0"
v_modelo_de_presentacion         = "349"
 
v_razon_social_del_presentador   = v_razon_social_del_presentador
f_trata_campo(v_razon_social_del_presentador,'A',18,57)
 
f_trata_campo(v_siglas_via_publica,'A',58,59)
f_trata_campo(v_nombre_via_publica,'A',60,79)
f_trata_campo(v_numero,'N',80,84)
f_trata_campo(v_escalera,'A',85,86)
f_trata_campo(v_piso,'A',87,88)
f_trata_campo(v_puerta,'A',89,90)
f_trata_campo(v_codigo_postal,'N',91,95)
f_trata_campo(v_municipio,'A',96,107)
f_trata_campo(v_codigo_provincia,'N',108,109)
 
v_domicilio_del_presentador      = v_siglas_via_publica+&
             v_nombre_via_publica+&
             v_numero+&
             v_escalera+&
             v_piso+&
             v_puerta+&
             v_codigo_postal+&
             v_municipio+&
             v_codigo_provincia
 
v_total_declarantes              = "1"
f_trata_campo(v_total_declarantes,'N',110,114)
 
v_total_entidades_relacionadas   = ""
f_trata_campo(v_total_entidades_relacionadas,'N',115,123)
 
v_tipo_soporte                   = " "//Cambia en 2020 "D"
 
v_telefono_contacto              = em_telefono_contacto.text
f_trata_campo(v_telefono_contacto,'N',125,133)
v_persona_contacto               = em_persona_contacto.text
f_trata_campo(v_persona_contacto,'A',134,173)
v_persona_con_quien_relacionarse = v_telefono_contacto + v_persona_contacto
 
v_blancos                        = ''
f_trata_campo(v_blancos,'A',176,237)
 
v_sello_electronico              = ''
f_trata_campo(v_sello_electronico,'A',238,250)
 
v_linea  = v_tipo_registro +&
     v_modelo_de_presentacion +&
     v_ejercicio +&
     v_nif_del_presentador +&
     v_razon_social_del_presentador +&
     v_domicilio_del_presentador +&
       v_total_declarantes +&
      v_total_entidades_relacionadas +&
     v_tipo_soporte +&
     v_persona_con_quien_relacionarse +&
     v_periodo +&
     v_blancos +&
     v_sello_electronico
 
//Para un solo declarante no se graba el registro de presentador
//v_donde = dw_lineas.insertrow(1)
 
//dw_lineas.Object.linea[v_donde] = v_linea
 
//B) TIPO DE REGISTRO 1:REGISTRO DE DECLARANTE
 
v_tipo_registro                               = '1'
v_modelo_declaracion                          = '349'
v_nif_del_declarante                          = v_nif_del_presentador
f_trata_campo(v_nif_del_declarante,'A',9,17)
 
v_razon_social_del_declarante                 = v_razon_social_del_presentador
f_trata_campo(v_razon_social_del_declarante,'A',18,57)
 
v_numero_de_justificante_declaracion          = '3430000000000'
f_trata_campo(v_numero_de_justificante_declaracion,'N',108,120)
 
v_declaracion_complementaria_sustitutiva      = ''
f_trata_campo(v_declaracion_complementaria_sustitutiva,'A',121,122)
 
v_numero_justificante_declaracion_anterior    = ''
f_trata_campo(v_numero_justificante_declaracion_anterior,'N',123,135)
 
v_numero_total_operadores                     = string(v_numero_total_operadores_decimal,"############0")
f_trata_campo(v_numero_total_operadores,'N',138,146)
 
v_importe_operaciones_intracomunitarias       = string(v_importe_operaciones_intracomunitarias_decimal * 100,"##############0")
f_trata_campo(v_importe_operaciones_intracomunitarias,'N',147,161)
 
v_numero_total_operadores_con_rectificaciones = string(v_numero_total_operadores_con_rectificaciones_decimal,"############0")
f_trata_campo(v_numero_total_operadores_con_rectificaciones,'N',162,170)
 
v_importe_rectificaciones                     = string(v_importe_rectificaciones_decimal * 100,"##############0")
f_trata_campo(v_importe_rectificaciones,'N',171,185)
 
v_blancos                                     = ''
f_trata_campo(v_blancos,'A',187,390)
 
ls_nif_representante_legal = ''
f_trata_campo(ls_nif_representante_legal,'A',391,399)

v_blancos2 = ''
f_trata_campo(v_blancos2,'A',400,487)
 
v_sello_electronico              = ''
f_trata_campo(v_sello_electronico,'A',488,500) 
 
v_linea  = v_tipo_registro +&
     v_modelo_declaracion +&
     v_ejercicio +&
     v_nif_del_declarante +&
     v_razon_social_del_declarante +&
     v_tipo_soporte +&
     v_persona_con_quien_relacionarse +&
     v_numero_de_justificante_declaracion +&
     v_declaracion_complementaria_sustitutiva +&
     v_numero_justificante_declaracion_anterior +&
     v_periodo +&
     v_numero_total_operadores +&
     v_importe_operaciones_intracomunitarias +&
     v_numero_total_operadores_con_rectificaciones +&
     v_importe_rectificaciones +& 
	  ls_indicador_cambio_periodicidad +&
     v_blancos +&
	  ls_nif_representante_legal +&
	  v_blancos2 +&
     v_sello_electronico
   
v_donde = dw_lineas.insertrow(1)
 
dw_lineas.Object.linea[v_donde] = v_linea  
 
// *********************************************************************
// GRABAR A DISQUETE
// *********************************************************************
 

// Nombre del fichero OPXX siendo XX el ejercicio
 
string v_ruta,v_fichero
int res 
 
v_fichero = "CE"+v_ejercicio
 
if dw_lineas.rowcount() > 0 then   
 if GetFileSaveName("Guardar Diferencias",v_ruta,v_fichero,"","Todos lo ficheros (*.*),*.*") = 1 then
  res = dw_lineas.saveas(v_fichero,text!,false)
  if res = -1 then 
   messagebox("ERROR","Al grabar al disquete")
  else
   messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " +v_fichero ) 
  end if
 end if
end if
end subroutine

public subroutine f_trata_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta);int v_longitud_total,v_longitud,v_indice,v_longitud_relleno

if isnull(arg_campo) then arg_campo = ''

if arg_tipo_campo = "N" then
	f_tratar_numero(arg_campo)
else
	f_tratar_texto(arg_campo)
end if

v_longitud_total = (arg_pos_hasta - arg_pos_desde) + 1

v_longitud         = len(arg_campo)
v_longitud_relleno = v_longitud_total - v_longitud

if v_longitud > v_longitud_total then
	arg_campo = left(arg_campo,v_longitud_total)
else
	for v_indice = 1 to v_longitud_relleno
		if arg_tipo_campo = "N" then
			arg_campo = '0' + arg_campo
		else
			arg_campo = arg_campo + ' '
		end if
	next
end if
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
		case "Ä"
			v_caracter = "A"			
		case "Ë"
			v_caracter = "E"
		case "Ï"
			v_caracter = "I"
		case "Ö"
			v_caracter = "O"
		case "Ü"
			v_caracter = "U"
		case "Á"
			v_caracter = "A"
		case "É"
			v_caracter = "E"
		case "Í"
			v_caracter = "I"
		case "Ó"
			v_caracter = "O"
		case "Ú"
			v_caracter = "U"
		case "À"
			v_caracter = "A"
		case "È"
			v_caracter = "E"
		case "Ì"
			v_caracter = "I"
		case "Ò"
			v_caracter = "O"
		case "Ù"
			v_caracter = "U"			
		case "Â"
			v_caracter = "A"
		case "Ê"
			v_caracter = "E"
		case "Î"
			v_caracter = "I"
		case "Ô"
			v_caracter = "O"
		case "Û"
			v_caracter = "U"						
	end choose
	
	v_texto_tratado = v_texto_tratado + v_caracter
next

arg_texto = v_texto_tratado


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

public subroutine f_carga_dw (datawindow arg_dw);string   v_linea,v_sel,v_periodo,v_cuenta_operador_intracomunitario,v_cif,v_codigo_pais,v_tipoter,v_pais
string   v_nombre_pais,v_moneda_empresa,v_clipro,v_razon,v_mascara_moneda_empresa,v_nombre_moneda_empresa
long     v_indice,v_total,v_donde,v_ejercicio
dec{2}	v_base_imponible
datetime v_fecha_desde,v_fecha_hasta
datastore ds_datos

arg_dw.reset()
arg_dw.setredraw(false)

v_fecha_desde = datetime(date(em_fechadesde.text))
v_fecha_hasta = datetime(date(em_fechahasta.text))

if year(date(v_fecha_desde)) <> year(date(v_fecha_hasta)) then 
	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
	return
end if

if v_fecha_desde > v_fecha_hasta then
	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
	return
end if

v_ejercicio = year(date(em_fechahasta.text))
if month(date(em_fechadesde.text)) >=1 Then v_periodo = "1T"
if month(date(em_fechadesde.text)) >3 Then v_periodo = "2T"
if month(date(em_fechadesde.text)) >6 Then v_periodo = "3T"
if month(date(em_fechadesde.text)) >9 Then v_periodo = "4T"

v_sel = "SELECT sum(contaapun.imponible) imponible, "+&
					"contaapun.tipoter, "+&
					"contaapun.clipro, "+&
					"genter.razon, "+&
					"genter.cif, "+&
					"genter.pais, "+& 
					"genter.cuenta, "+& 
					"paises.nombre, "+&
					"paises.pais "+&
		  "FROM contaapun, "+&   
		  "genter, "+&
		  "paises "+&
		  "WHERE ( contaapun.empresa = genter.empresa ) "+&
		  "AND   ( contaapun.tipoter = genter.tipoter ) "+&
		  "AND   ( contaapun.clipro = genter.codigo ) "+&
		  "AND   ( genter.pais = paises.pais ) "+&
		  "AND   (( contaapun.empresa = '"+codigo_empresa+"') "+&
		  "AND   ( contaapun.fapunte between '"+string(v_fecha_desde,formato_fecha_cursores)+"' and '"+string(v_fecha_hasta,formato_fecha_cursores)+"' ) "+&
		  "AND   ( contaapun.fapunte >= paises.fecha_ingreso_cee ) "+&
		  "AND   ( paises.tipopais = 'C' ) "+&
		  "AND     tipoiva in (SELECT tipoiva from contaiva "+&
		  							  "WHERE ejercicio = "+string(v_ejercicio,"####")+" "+&
		  							  "AND   empresa   = '"+codigo_empresa+"' " +&
		  							  "AND   incluir_modelo_en_349 = 'S' )) " +&
		  "GROUP BY contaapun.tipoter, "+&
		  "contaapun.clipro, "+&
		  "genter.razon, "+&
		  "genter.cif, "+&
		  "genter.pais, "+& 
		  "genter.cuenta, "+& 
		  "paises.nombre, "+&
		  "paises.pais "+&
		  "ORDER BY contaapun.tipoter,"+&
		  "genter.razon"
		
//clipboard(v_sel)		
		
f_cargar_cursor_transaccion(sqlca,ds_datos,v_sel)

v_total = ds_datos.rowcount()

v_moneda_empresa         = f_moneda_empresa(codigo_empresa)
v_mascara_moneda_empresa = f_mascara_moneda(v_moneda_empresa)
v_nombre_moneda_empresa  = f_nombre_moneda_abr(v_moneda_empresa)

for v_indice = 1 to v_total
	f_mensaje_proceso('Calculando',v_indice,v_total)
	v_cuenta_operador_intracomunitario = ds_datos.object.genter_cuenta[v_indice]
	if left(v_cuenta_operador_intracomunitario,4) <> "4101" or 1 = 1 then
		//No es un agente
		v_base_imponible					        = ds_datos.object.imponible[v_indice]
		v_cif							              = ds_datos.object.genter_cif[v_indice]
		v_nombre_pais                         = ds_datos.object.paises_nombre[v_indice]
		v_tipoter                             = ds_datos.object.contaapun_tipoter[v_indice]
		v_clipro										  = ds_datos.object.contaapun_clipro[v_indice]
		v_razon										  = ds_datos.object.genter_razon[v_indice]
		v_pais										  = ds_datos.object.paises_pais[v_indice]
		
		v_donde			     				        = arg_dw.insertrow(0)
		
		arg_dw.object.empresa[v_donde]        = codigo_empresa
   	arg_dw.object.tipoter[v_donde]        = v_tipoter
		arg_dw.object.clipro[v_donde]         = v_clipro
   	arg_dw.object.razon[v_donde]          = v_razon
		arg_dw.object.base_imponible[v_donde] = v_base_imponible
		arg_dw.object.moneda[v_donde]         = v_nombre_moneda_empresa
		arg_dw.object.cif[v_donde]            = v_cif
		arg_dw.object.mascara_moneda[v_donde] = v_mascara_moneda_empresa
		arg_dw.object.ejercicio[v_donde]      = v_ejercicio
		arg_dw.object.periodo[v_donde]        = v_periodo
		arg_dw.object.nombre_pais[v_donde]    = v_nombre_pais
		arg_dw.object.pais[v_donde]           = v_pais
		
	end if
next

destroy ds_datos

arg_dw.sort()
arg_dw.groupcalc()
arg_dw.setredraw(true)
end subroutine

public subroutine f_graba_soporte_magnetico_cristal ();//dw_proceso.SetTransObject(SQLCA)
//
//f_control(dw_proceso,"N")
//
//Dec op ,i,fila,ii,dimporte
//Dec ej1,ej2
//String importe,tri,pro,pr,var_telefono_contacto,var_persona_contacto
//STring razon,ejercicio,nif,razon_cliente,cl,cif,pais
//str_parametros datos_rectificacion
//tipo_array rectificacion
//string ejercicio_rectificacion,periodo
//long   donde
//boolean continuar = true
//string linea[]
//
//
//DataStore  dw_intra
//op = messagebox("ATENCIÓN","La información se va a grabar en disquete Según BOE 2000"  + &
//		" ¿Desea continuar?",question!,yesno!,1 )
//if op = 2 then return
//
//tri = "1T"
//iF Month(Date(em_fechadesde.text))  >1  Then tri = "1T"
//iF Month(date(em_fechadesde.text))  >3  Then tri = "2T"
//iF Month(date(em_fechadesde.text))  >6  Then tri = "3T"
//iF Month(date(em_fechadesde.text))  >9  Then tri = "4T"
//
//ej1 = year(date(em_fechadesde.text))
//ej2 = year(date(em_fechahasta.text))
//if ej1 <> ej2 then 
//	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
//	return
//end if
//
//if date(em_fechadesde.text) > date(em_fechahasta.text) then
//	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
//	return
//end if
//
//var_telefono_contacto = em_telefono_contacto.text
//var_persona_contacto  = em_persona_contacto.text
//
//if trim(var_telefono_contacto) = "" then
//	f_mensaje("Atención","Debe introducir el telefono de contacto.")
//	return	
//else
//	if len(var_telefono_contacto) <> 9 then
//		f_mensaje("Atención","El telefono de contacto debe ser de 9 digitos.")
//		return			
//	end if
//end if
//
//if trim(var_persona_contacto) = "" then
//	f_mensaje("Atención","Debe introducir la Persona de contacto.")
//	return	
//else
//	var_persona_contacto = trim(var_persona_contacto)
//	var_persona_contacto = var_persona_contacto+space(40 - len(var_persona_contacto))
//end if
//
//ejercicio = string(year(date(em_fechahasta.text)))
//
//pro = f_provincia_empresa(codigo_empresa)
//
//razon = f_nombre_empresa(codigo_empresa)
//razon = f_razon(razon)	
//cif   = f_tratar_nif(f_cif_empresa(codigo_empresa),"ES",razon)
//
//
////linea[upperbound(linea)+1]  = "1349"+String(ejercicio)+cif+razon+"D"+&
////			var_telefono_contacto+var_persona_contacto+SPACE(15)+&
////			SPACE(13)+tri +space(9)+space(15)+space(9)+space(15)+space(52)+space(13)
//
//linea[upperbound(linea)+1]  = "1349"+String(ejercicio)+cif+razon+"D"+&
//			var_telefono_contacto+var_persona_contacto+ "0000000000000" + SPACE(2)+&
//			"0000000000000" + tri + "000000000" + "000000000000000"+"000000000"+ &
//			"000000000000000"+space(52)+space(13)
//
//
//for i = 1 to dw_proceso.rowcount()  
//	if continuar then
//		cliente       = dw_proceso.getitemstring(i,"cliente")
////		if cliente <> f_codigo_cliente_empresa(codigo_empresa) then
//			if isnull(cliente) then cliente = ""
//			razon_cliente = f_razon_genter(codigo_empresa,"C",dw_proceso.getitemstring(i,"cliente"))+ Space(40)
//			razon_cliente = f_limpiar_razon(razon_cliente)
//			if isnull(razon_cliente) then razon_cliente = ""
//			if len(razon_cliente) < 40 then
//				razon_cliente = razon_cliente + Space(40 - len(razon_cliente))
//			else
//				razon_cliente = Mid(razon_cliente,1,40)		
//			end if		
//			clave         = dw_proceso.getitemstring(i,"paises_clave")
//			if isnull(clave) then clave = ""
//			nif           = trim(f_cif_genter(codigo_empresa,"C",dw_proceso.getitemstring(i,"cliente")))
//			if isnull(nif) then nif = ""
//			nif           = f_tratar_nif(nif,clave,razon_cliente)
//			if len(nif) < 12 then
//				nif = nif + space(12 - len(nif))	
//			else
//				nif = Mid(nif,1,12)		
//			end if
//
//			importe        = String(dw_proceso.getitemnumber(i,"total_fac_pts")*100,"0000000000000")
//			dimporte       = dw_proceso.getitemnumber(i,"total_fac_pts")
//
//			cl    = "E"
//
//			if dimporte >= 0 Then 
//				
//				linea[upperbound(linea)+1]  = "2349"+String(ejercicio)+cif+space(58)+&
//						+Trim(clave)+Mid(nif,1,15)+space(15 - len(Mid(nif,1,15)))+&
//						+razon_cliente+Trim(cl)+Mid(importe,1,13)+space(104)
//			else
//				// El importe negativo supone una rectificación sobre un periodo anterior
//		
//				datos_rectificacion.s_argumentos[1] = String(ejercicio)
//				datos_rectificacion.s_argumentos[2] = tri
//				datos_rectificacion.s_argumentos[3] = trim(razon_cliente)
//				datos_rectificacion.s_argumentos[4] = string(dimporte,"###########0.00")
//		
//				openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
//		
//				rectificacion = message.powerObjectparm
//				ejercicio_rectificacion = rectificacion.valor[1]
//				periodo                 = rectificacion.valor[2]
//				if ejercicio_rectificacion = "RETURN" then
//					continuar = false
//				end if			
//
//				importe = String(ABS(dimporte) * 100,"0000000000000")
//				
//				linea[upperbound(linea)+1]  = "2349"+String(ejercicio)+cif+space(58)+&
//						+Trim(clave)+Mid(nif,1,15)+space(15 - len(Mid(nif,1,15)))+&
//						+razon_cliente+Trim(cl)+space(13)+ejercicio_rectificacion+periodo+&
//						"0000000000000"+Mid(importe,1,13)+space(72)
//			END IF
////		end if
//	end if
//Next
//
//if continuar then
//	String sel
//	
//	sel = " Select nif,clipro,sum(imponible) imponible from contaapun  " +&
//			" Where  ejercicio = " +ejercicio+&
//			" And    empresa   = '" +codigo_empresa+"'"+&
//			" And    fapunte between '" + String(Date(em_fechadesde.text),"dd/mm/YYYY") + "' and '" + String(Date(em_fechahasta.text),"dd/mm/YYYY") +"'"+&
//			" And    tipoapu = '4'"+&
//			" And    tipoter = 'P'"+&
//			" And    cuenta  LIKE '472%'" +&
//			" Group by nif,clipro"
//		
//	dw_intra = f_cargar_cursor(sel)
//
//	For ii = 1 To dw_intra.RowCount()	
//		pr    = dw_intra.Object.clipro[ii]	
//		if isnull(pr) then pr = ""
//		pais  = f_pais_genter(codigo_empresa,"P",pr)
//		if isnull(pais) then pais = ""
//		if f_tipo_pais(pais) = "C" and f_distribuidor_genter(codigo_empresa,"P",pr)="S" then		
//			razon_cliente = trim(f_razon_genter(codigo_empresa,"P",pr))
//			razon_cliente = f_limpiar_razon(razon_cliente)
//			if isnull(razon_cliente) then razon_cliente = ""
//			if len(razon_cliente) < 40 then
//				razon_cliente = razon_cliente + Space(40 - len(razon_cliente))
//			else
//				razon_cliente = Mid(razon_cliente,1,40)		
//			end if	
//			clave = f_clave_pais(pais)
//			if isnull(clave) then clave = ""
//			nif   = trim(dw_intra.Object.nif[ii])
//			if isnull(nif) then nif = ""
//			nif   = f_tratar_nif(nif,clave,razon_cliente)
//			if len(nif) < 12 then
//				nif = nif + space(12 - len(nif))	
//			else
//				nif = Mid(nif,1,12)		
//			end if
//			
//			importe       = string(dw_intra.Object.imponible[ii]*100,"0000000000000")
//			dimporte      = dw_intra.Object.imponible[ii]
//			
//			cl    = "A"
//			
//			if dimporte >= 0 Then 
//				
//				linea[upperbound(linea)+1]  = "2349"+String(ejercicio)+cif+space(58)+&
//						+Trim(clave)+Mid(nif,1,15)+space(15 - len(Mid(nif,1,15)))+&
//						+razon_cliente+Trim(cl)+Mid(importe,1,13)+space(104)
//			else
//				// El importe negativo supone una rectificación sobre un periodo anterior
//		
//				datos_rectificacion.s_argumentos[1] = String(ejercicio)
//				datos_rectificacion.s_argumentos[2] = tri
//				datos_rectificacion.s_argumentos[3] = trim(razon_cliente)
//				datos_rectificacion.s_argumentos[4] = string(dimporte,"###########0")
//		
//				openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
//		
//				rectificacion = message.powerObjectparm
//				ejercicio_rectificacion = rectificacion.valor[1]
//				periodo                 = rectificacion.valor[2]
//				if ejercicio_rectificacion = "RETURN" then
//					continuar = false
//				end if			
//
//				importe = String(ABS(dimporte) * 100,"0000000000000")
//				
//				linea[upperbound(linea)+1]  = "2349"+String(ejercicio)+cif+space(58)+&
//						+Trim(clave)+Mid(nif,1,15)+space(15 - len(Mid(nif,1,15)))+&
//						+razon_cliente+Trim(cl)+space(13)+ejercicio_rectificacion+periodo+&
//						"0000000000000"+Mid(importe,1,13)+space(72)
//			END IF
//		end if
//	Next
//
//	
//	//Grabo DATAWINDOW
//	
//	for i=1 to upperbound(linea) 
//		if trim(linea[i]) <> "" then
//			donde = dw_lineas.insertrow(0)
//			dw_lineas.Object.linea[donde] = linea[i]
//		end if
//	next
//
//
//	
//	// *********************************************************************
//	// GRABAR A DISQUETE
//	// *********************************************************************
//	
//	
//	// Nombre del fichero OPXX siendo XX el ejercicio
//	
//	
//	String ls_path, ejer_corto, fichero
//	Int li_rc,res
//
//	ejer_corto = mid(ejercicio,3,2)
//	fichero = "OP349" + ejer_corto+ ".TXT"
//
//	ls_path =  "" 
//	li_rc = GetFileSaveName ("Guardar fichero en", fichero, ls_path, "TXT", "Files TXT (*.TXT),*.TXT","C:\My Documents", 32770)
//	
//	IF li_rc = 1 THEN
//		if dw_lineas.rowcount() > 0 then
//			//res = dw_lineas.saveas("a:\" + fichero,text!,false) 
//			res = dw_lineas.saveas(ls_path,text!,false)
//			if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
//			if res = 1 then f_mensaje("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
//		end if		
//	ELSE
//		Messagebox("ERROR","No ha elegido destino para guardar el fichero")
//	END IF 
//ELSE
//	Messagebox("Atención","Operación cancelada")	
//END IF 
//
//setpointer(arrow!)
end subroutine

public subroutine f_graba_soporte_magnetico_old ();string   v_linea,v_sel
long     v_indice,v_total,v_donde
datetime v_fecha_desde,v_fecha_hasta
datastore ds_datos
//
string v_tipo_registro,v_modelo_de_presentacion,v_ejercicio,v_nif_del_presentador,v_razon_social_del_presentador
string v_domicilio_del_presentador,v_total_declarantes,v_total_entidades_relacionadas,v_tipo_soporte
string v_telefono_contacto,v_persona_contacto
string v_persona_con_quien_relacionarse,v_periodo,v_blancos,v_sello_electronico
string v_siglas_via_publica,v_nombre_via_publica,v_numero,v_escalera,v_piso,v_puerta,v_codigo_postal
string v_municipio,v_codigo_provincia
string v_modelo_declaracion,v_nif_del_declarante,v_razon_social_del_declarante,v_numero_de_justificante_declaracion
string v_declaracion_complementaria_sustitutiva,v_numero_justificante_declaracion_anterior
string v_numero_total_operadores,v_importe_operaciones_intracomunitarias,v_numero_total_operadores_con_rectificaciones
string v_importe_rectificaciones
string v_nif_operador_comunitario,v_razon_social_operador_intracomunitario,v_clave_operacion,v_base_imponible,v_blancos2
string v_codigo_pais,v_tipoter,v_clipro,v_cuenta_operador_intracomunitario
dec    v_base_imponible_decimal,v_base_imponible_rectificada_decimal,v_base_imponible_declarada_anteriormente_decimal
string v_rectificaciones,v_ejercicio_rectificacion,v_periodo_rectificacion,v_base_imponible_rectificada
string v_base_imponible_declarada_anteriormente,v_blancos3
datetime v_fecha_desde_periodo_rectificacion,v_fecha_hasta_periodo_rectificacion
dec      v_numero_total_operadores_decimal,v_importe_operaciones_intracomunitarias_decimal
dec      v_numero_total_operadores_con_rectificaciones_decimal,v_importe_rectificaciones_decimal

str_parametros datos_rectificacion
tipo_array rectificacion

v_fecha_desde = datetime(date(em_fechadesde.text))
v_fecha_hasta = datetime(date(em_fechahasta.text))

if year(date(v_fecha_desde)) <> year(date(v_fecha_hasta)) then 
	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
	return
end if

if v_fecha_desde > v_fecha_hasta then
	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
	return
end if

if trim(em_telefono_contacto.text) = "" then
	f_mensaje("Atención","Debe introducir el telefono de contacto.")
	return	
else
	if len(em_telefono_contacto.text) <> 9 then
		f_mensaje("Atención","El telefono de contacto debe ser de 9 digitos.")
		return			
	end if
end if

if trim(em_persona_contacto.text) = "" then
	f_mensaje("Atención","Debe introducir la Persona de contacto.")
	return	
end if

v_ejercicio                      = string(year(date(em_fechahasta.text)),"0000")
if month(date(em_fechadesde.text)) >=1 Then v_periodo = "1T"
if month(date(em_fechadesde.text)) >3 Then v_periodo = "2T"
if month(date(em_fechadesde.text)) >6 Then v_periodo = "3T"
if month(date(em_fechadesde.text)) >9 Then v_periodo = "4T"

select nombre,									domicilio,					ciudad,
		 provincia,								codpostal,					cif,
		 cl_domicilio,							nu_domicilio
into   :v_razon_social_del_presentador,:v_nombre_via_publica,  :v_municipio,
		 :v_codigo_provincia,            :v_codigo_postal,       :v_nif_del_presentador,
		 :v_siglas_via_publica,          :v_numero
from   empresas
where  empresa = :codigo_empresa;

v_escalera = ''
v_piso     = ''
v_puerta   = ''

v_nif_del_presentador            = f_tratar_nif(v_nif_del_presentador,"ES",v_razon_social_del_presentador)
f_trata_campo(v_nif_del_presentador,'A',9,17)
v_nif_del_declarante              = v_nif_del_presentador

v_sel = "SELECT sum(contaapun.imponible) imponible, "+&
					"contaapun.tipoter, "+&
					"contaapun.clipro, "+&
					"genter.razon, "+&
					"genter.cif, "+&
					"genter.pais, "+& 
					"genter.cuenta, "+& 
					"paises.codigo_pais_nif "+&
		  "FROM contaapun, "+&   
		  "genter, "+&
		  "paises "+&
		  "WHERE ( contaapun.empresa = genter.empresa ) "+&
		  "AND   ( contaapun.tipoter = genter.tipoter ) "+&
		  "AND   ( contaapun.clipro = genter.codigo ) "+&
		  "AND   ( genter.pais = paises.pais ) "+&
		  "AND   (( contaapun.empresa = '"+codigo_empresa+"') "+&
		  "AND   ( contaapun.fapunte between '"+string(v_fecha_desde,formato_fecha_cursores)+"' and '"+string(v_fecha_hasta,formato_fecha_cursores)+"' ) "+&
		  "AND   ( contaapun.fapunte >= paises.fecha_ingreso_cee ) "+&
		  "AND   ( paises.tipopais = 'C' ) "+&
		  "AND     tipoiva in (SELECT tipoiva from contaiva "+&
		  							  "WHERE ejercicio = "+string(dec(v_ejercicio),"####")+" "+&
		  							  "AND   empresa   = '"+codigo_empresa+"' " +&
		  							  "AND   incluir_modelo_en_349 = 'S' )) "+&
		  "GROUP BY contaapun.tipoter, "+&
		  "contaapun.clipro, "+&
		  "genter.razon, "+&
		  "genter.cif, "+&
		  "genter.pais, "+& 
		  "genter.cuenta, "+& 
		  "paises.codigo_pais_nif "+&
		  "ORDER BY contaapun.tipoter,"+&
		  "genter.razon"
		
f_cargar_cursor_transaccion(sqlca,ds_datos,v_sel)

v_total = ds_datos.rowcount()

v_numero_total_operadores_decimal = 0

v_importe_operaciones_intracomunitarias_decimal = 0

v_numero_total_operadores_con_rectificaciones_decimal = 0

v_importe_rectificaciones_decimal = 0

for v_indice = 1 to v_total
	f_mensaje_proceso('Calculando',v_indice,v_total)
	v_cuenta_operador_intracomunitario = ds_datos.object.genter_cuenta[v_indice]
	if left(v_cuenta_operador_intracomunitario,4) <> "4101" then
		//No es un agente
		v_base_imponible_decimal                 = ds_datos.object.imponible[v_indice]
		if v_base_imponible_decimal <> 0 then
			if v_base_imponible_decimal > 0 then
				v_numero_total_operadores_decimal ++
				
				v_importe_operaciones_intracomunitarias_decimal += v_base_imponible_decimal
				//C) TIPO DE REGISTRO 2:REGISTRO DE OPERADOR INTRACOMUNITARIO
				v_tipo_registro      = '2'
				v_modelo_declaracion = '349'
				v_blancos            = ''
				f_trata_campo(v_blancos,'A',18,75)
				
				v_nif_operador_comunitario               = ds_datos.object.genter_cif[v_indice]
				v_codigo_pais                            = ds_datos.object.paises_codigo_pais_nif[v_indice]
				v_razon_social_operador_intracomunitario = ds_datos.object.genter_razon[v_indice]
				
				v_nif_operador_comunitario               = v_codigo_pais + f_tratar_nif(v_nif_operador_comunitario,v_codigo_pais,v_razon_social_operador_intracomunitario)
				f_trata_campo(v_nif_operador_comunitario,'A',76,92)	
				
				f_trata_campo(v_razon_social_operador_intracomunitario,'A',93,132)	
				
				v_tipoter                                = ds_datos.object.contaapun_tipoter[v_indice]
				choose case v_tipoter
					case "C"
						//Clientes
						//Entregas intracomunitarias exentas.
						v_clave_operacion = "E"
					case "P"
						//Proveedores
						//Adquisiciones intracomunitarias sujetas.			
						v_clave_operacion = "A"
				end choose	
				
				v_base_imponible                         = string(v_base_imponible_decimal * 100,"############0")
				f_trata_campo(v_base_imponible,'N',134,146)
				
				v_blancos2           = ''
				f_trata_campo(v_blancos2,'A',147,250)
				
				v_linea  = v_tipo_registro +&
							  v_modelo_declaracion +&
							  v_ejercicio +&
							  v_nif_del_declarante +&	
							  v_blancos +&
							  v_nif_operador_comunitario +&
							  v_razon_social_operador_intracomunitario +&
							  v_clave_operacion +&
							  v_base_imponible +&
							  v_blancos2
							  
				v_donde = dw_lineas.insertrow(0)
				
				dw_lineas.Object.linea[v_donde] = v_linea					  
			else
				v_numero_total_operadores_con_rectificaciones_decimal ++			
				//C) TIPO DE REGISTRO 2:REGISTRO DE OPERADOR INTRACOMUNITARIO (CON RECTIFICACIONES)
				v_tipo_registro      = '2'
				v_modelo_declaracion = '349'
				v_blancos            = ''
				f_trata_campo(v_blancos,'A',18,75)
				
				v_nif_operador_comunitario               = ds_datos.object.genter_cif[v_indice]
				v_codigo_pais                            = ds_datos.object.paises_codigo_pais_nif[v_indice]
				v_razon_social_operador_intracomunitario = ds_datos.object.genter_razon[v_indice]
				
				v_nif_operador_comunitario               = v_codigo_pais + f_tratar_nif(v_nif_operador_comunitario,v_codigo_pais,v_razon_social_operador_intracomunitario)
				f_trata_campo(v_nif_operador_comunitario,'A',76,92)	
				
				f_trata_campo(v_razon_social_operador_intracomunitario,'A',93,132)	
				
				v_tipoter                                = ds_datos.object.contaapun_tipoter[v_indice]
				v_clipro                                 = ds_datos.object.contaapun_clipro[v_indice]
				choose case v_tipoter
					case "C"
						//Clientes
						//Entregas intracomunitarias exentas.
						v_clave_operacion = "E"
					case "P"
						//Proveedores
						//Adquisiciones intracomunitarias sujetas.			
						v_clave_operacion = "A"
				end choose	
							
				v_blancos2           = ''
				f_trata_campo(v_blancos2,'A',134,146)
							
				//REGISTRO DE RECTIFICACIONES
				datos_rectificacion.s_argumentos[1] = String(v_ejercicio)
				datos_rectificacion.s_argumentos[2] = v_periodo
				datos_rectificacion.s_argumentos[3] = v_razon_social_operador_intracomunitario
				datos_rectificacion.s_argumentos[4] = string(v_base_imponible_decimal,"###,###,###,##0.00")
		
				openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
		
				rectificacion = message.powerObjectparm
				v_ejercicio_rectificacion = rectificacion.valor[1]
				v_periodo_rectificacion   = rectificacion.valor[2]
				if v_ejercicio_rectificacion = "RETURN" then
					//continuar = false
				else
					choose case v_periodo_rectificacion
						case "1T"
							v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),1,1))
							v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),4,1),-1))
						case "2T"
							v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),4,1))
							v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),7,1),-1))						
						case "3T"
							v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),7,1))
							v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion),10,1),-1))						
						case "4T"
							v_fecha_desde_periodo_rectificacion = datetime(date(dec(v_ejercicio_rectificacion),10,1))
							v_fecha_hasta_periodo_rectificacion = datetime(relativedate(date(dec(v_ejercicio_rectificacion)+1,1,1),-1))												
					end choose
	
					SELECT sum(contaapun.imponible) 
					INTO   :v_base_imponible_declarada_anteriormente_decimal
					FROM   contaapun 
					WHERE  empresa = :codigo_empresa
					AND    tipoter = :v_tipoter
					AND    clipro  = :v_clipro
					AND    fapunte between :v_fecha_desde_periodo_rectificacion and :v_fecha_hasta_periodo_rectificacion
					AND    tipoapu in('3','4','9');
					
					if isnull(v_base_imponible_declarada_anteriormente_decimal) then v_base_imponible_declarada_anteriormente_decimal = 0
					
					v_base_imponible_rectificada_decimal = v_base_imponible_declarada_anteriormente_decimal + v_base_imponible_decimal
					
					v_importe_rectificaciones_decimal += v_base_imponible_rectificada_decimal
					
					f_trata_campo(v_ejercicio_rectificacion,'N',147,150)
					f_trata_campo(v_periodo_rectificacion,'A',151,152)
					
					v_base_imponible_rectificada = string(v_base_imponible_rectificada_decimal * 100,"############0")
					f_trata_campo(v_base_imponible_rectificada,'N',153,165)
					
					v_base_imponible_declarada_anteriormente = string(v_base_imponible_declarada_anteriormente_decimal * 100,"############0")
					f_trata_campo(v_base_imponible_declarada_anteriormente,'N',166,178)
					
					v_rectificaciones = v_ejercicio_rectificacion +&
											  v_periodo_rectificacion +&
											  v_base_imponible_rectificada +&
											  v_base_imponible_declarada_anteriormente
					
					f_trata_campo(v_rectificaciones,'A',147,178)
					
					v_blancos3           = ''
					f_trata_campo(v_blancos3,'A',179,250)				
					
					v_linea  = v_tipo_registro +&
								  v_modelo_declaracion +&
								  v_ejercicio +&
								  v_nif_del_declarante +&	
								  v_blancos +&
								  v_nif_operador_comunitario +&
								  v_razon_social_operador_intracomunitario +&
								  v_clave_operacion +&
								  v_blancos2 +&
								  v_rectificaciones +&
								  v_blancos3
								  
					v_donde = dw_lineas.insertrow(0)
					
					dw_lineas.Object.linea[v_donde] = v_linea					  				
				end if									
			end if
		end if
	end if
next

destroy ds_datos

//A) TIPO DE REGISTRO 0:REGISTRO DEL PRESENTADOR

v_tipo_registro                  = "0"
v_modelo_de_presentacion         = "349"

v_razon_social_del_presentador   = v_razon_social_del_presentador
f_trata_campo(v_razon_social_del_presentador,'A',18,57)

f_trata_campo(v_siglas_via_publica,'A',58,59)
f_trata_campo(v_nombre_via_publica,'A',60,79)
f_trata_campo(v_numero,'N',80,84)
f_trata_campo(v_escalera,'A',85,86)
f_trata_campo(v_piso,'A',87,88)
f_trata_campo(v_puerta,'A',89,90)
f_trata_campo(v_codigo_postal,'N',91,95)
f_trata_campo(v_municipio,'A',96,107)
f_trata_campo(v_codigo_provincia,'N',108,109)

v_domicilio_del_presentador      = v_siglas_via_publica+&
											  v_nombre_via_publica+&
											  v_numero+&
											  v_escalera+&
											  v_piso+&
											  v_puerta+&
											  v_codigo_postal+&
											  v_municipio+&
											  v_codigo_provincia

v_total_declarantes              = "1"
f_trata_campo(v_total_declarantes,'N',110,114)

v_total_entidades_relacionadas   = ""
f_trata_campo(v_total_entidades_relacionadas,'N',115,123)

v_tipo_soporte                   = "D"

v_telefono_contacto              = em_telefono_contacto.text
f_trata_campo(v_telefono_contacto,'N',125,133)
v_persona_contacto               = em_persona_contacto.text
f_trata_campo(v_persona_contacto,'A',134,173)
v_persona_con_quien_relacionarse = v_telefono_contacto + v_persona_contacto

v_blancos                        = ''
f_trata_campo(v_blancos,'A',176,237)

v_sello_electronico              = ''
f_trata_campo(v_sello_electronico,'A',238,250)

v_linea  = v_tipo_registro +&
			  v_modelo_de_presentacion +&
			  v_ejercicio +&
			  v_nif_del_presentador +&
			  v_razon_social_del_presentador +&
			  v_domicilio_del_presentador +&
  			  v_total_declarantes +&
		 	  v_total_entidades_relacionadas +&
			  v_tipo_soporte +&
			  v_persona_con_quien_relacionarse +&
			  v_periodo +&
			  v_blancos +&
			  v_sello_electronico
	
//Para un solo declarante no se graba el registro de presentador
//v_donde = dw_lineas.insertrow(1)

//dw_lineas.Object.linea[v_donde] = v_linea

//B) TIPO DE REGISTRO 1:REGISTRO DE DECLARANTE

v_tipo_registro                               = '1'
v_modelo_declaracion                          = '349'
v_nif_del_declarante                          = v_nif_del_presentador
f_trata_campo(v_nif_del_declarante,'A',9,17)

v_razon_social_del_declarante                 = v_razon_social_del_presentador
f_trata_campo(v_razon_social_del_declarante,'A',18,57)

v_numero_de_justificante_declaracion          = '0000000000000'
f_trata_campo(v_numero_de_justificante_declaracion,'N',108,120)

v_declaracion_complementaria_sustitutiva      = ''
f_trata_campo(v_declaracion_complementaria_sustitutiva,'A',121,122)

v_numero_justificante_declaracion_anterior    = ''
f_trata_campo(v_numero_justificante_declaracion_anterior,'N',123,135)

v_numero_total_operadores                     = string(v_numero_total_operadores_decimal,"############0")
f_trata_campo(v_numero_total_operadores,'N',138,146)

v_importe_operaciones_intracomunitarias       = string(v_importe_operaciones_intracomunitarias_decimal * 100,"##############0")
f_trata_campo(v_importe_operaciones_intracomunitarias,'N',147,161)

v_numero_total_operadores_con_rectificaciones = string(v_numero_total_operadores_con_rectificaciones_decimal,"############0")
f_trata_campo(v_numero_total_operadores_con_rectificaciones,'N',162,170)

v_importe_rectificaciones                     = string(v_importe_rectificaciones_decimal * 100,"##############0")
f_trata_campo(v_importe_rectificaciones,'N',171,185)

v_blancos                                     = ''
f_trata_campo(v_blancos,'A',186,237)

v_linea  = v_tipo_registro +&
			  v_modelo_declaracion +&
			  v_ejercicio +&
			  v_nif_del_declarante +&
			  v_razon_social_del_declarante +&
			  v_tipo_soporte +&
			  v_persona_con_quien_relacionarse +&
			  v_numero_de_justificante_declaracion +&
			  v_declaracion_complementaria_sustitutiva +&
			  v_numero_justificante_declaracion_anterior +&
			  v_periodo +&
			  v_numero_total_operadores +&
			  v_importe_operaciones_intracomunitarias +&
			  v_numero_total_operadores_con_rectificaciones +&
			  v_importe_rectificaciones +&			  
			  v_blancos +&
			  v_sello_electronico
			
v_donde = dw_lineas.insertrow(1)

dw_lineas.Object.linea[v_donde] = v_linea		

// *********************************************************************
// GRABAR A DISQUETE
// *********************************************************************


// Nombre del fichero OPXX siendo XX el ejercicio

string v_ruta,v_fichero
int res 

v_fichero = "349"+v_ejercicio+v_periodo

if dw_lineas.rowcount() > 0 then			
	if GetFileSaveName("Guardar Diferencias",v_ruta,v_fichero,"","Todos lo ficheros (*.*),*.*") = 1 then
		res = dw_lineas.saveas(v_fichero,text!,false)
		if res = -1 then 
			messagebox("ERROR","Al grabar al disquete")
		else
			messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " +v_fichero )	
		end if
	end if
end if
end subroutine

public subroutine f_cargar_dw_detalle (datawindow arg_dw);string   v_linea,v_sel,v_periodo,v_cuenta_operador_intracomunitario,v_cif,v_codigo_pais,v_tipoter,v_pais
string   v_nombre_pais,v_moneda_empresa,v_clipro,v_razon,v_mascara_moneda_empresa,v_nombre_moneda_empresa,ls_factura
long     v_indice,v_total,v_donde,v_ejercicio
dec{2}	v_base_imponible
datetime v_fecha_desde,v_fecha_hasta,ldt_ffactura,ldt_fregistro
datastore ds_datos

arg_dw.reset()
arg_dw.setredraw(false)

v_fecha_desde = datetime(date(em_fechadesde.text))
v_fecha_hasta = datetime(date(em_fechahasta.text))

if year(date(v_fecha_desde)) <> year(date(v_fecha_hasta)) then 
	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
	return
end if

if v_fecha_desde > v_fecha_hasta then
	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
	return
end if

v_ejercicio = year(date(em_fechahasta.text))

v_sel = "SELECT sum(contaapun.imponible) imponible, "+&
					"contaapun.tipoter, "+&
					"contaapun.clipro, "+&
					"genter.razon, "+&
					"genter.cif, "+&
					"genter.pais, "+& 
					"genter.cuenta, "+& 
					"paises.nombre, "+&
					"paises.pais, "+&
					"contaapun.factura, "+&
					"contaapun.ffactura, "+&
					"contaapun.fregistro "+&
		  "FROM contaapun, "+&   
		  "genter, "+&
		  "paises "+&
		  "WHERE ( contaapun.empresa = genter.empresa ) "+&
		  "AND   ( contaapun.tipoter = genter.tipoter ) "+&
		  "AND   ( contaapun.clipro = genter.codigo ) "+&
		  "AND   ( genter.pais = paises.pais ) "+&
		  "AND   (( contaapun.empresa = '"+codigo_empresa+"') "+&
		  "AND   ( contaapun.fapunte between '"+string(v_fecha_desde,formato_fecha_cursores)+"' and '"+string(v_fecha_hasta,formato_fecha_cursores)+"' ) "+&
		  "AND   ( contaapun.fapunte >= paises.fecha_ingreso_cee ) "+&
		  "AND   ( paises.tipopais = 'C' ) "+&
		  "AND     tipoiva in (SELECT tipoiva from contaiva "+&
		  							  "WHERE ejercicio = "+string(v_ejercicio,"####")+" "+&
		  							  "AND   empresa   = '"+codigo_empresa+"' " +&
		  							  "AND   incluir_modelo_en_349 = 'S' )) " +&
		  "GROUP BY contaapun.tipoter, "+&
		  "contaapun.clipro, "+&
		  "genter.razon, "+&
		  "genter.cif, "+&
		  "genter.pais, "+& 
		  "genter.cuenta, "+& 
		  "paises.nombre, "+&
		  "paises.pais, "+&
		  "contaapun.factura, "+&
		  "contaapun.ffactura, "+&
		  "contaapun.fregistro "+&
		  "ORDER BY contaapun.tipoter,"+&
		  "genter.razon"
		
//clipboard(v_sel)		
		
f_cargar_cursor_transaccion(sqlca,ds_datos,v_sel)

v_total = ds_datos.rowcount()

v_moneda_empresa         = f_moneda_empresa(codigo_empresa)
v_mascara_moneda_empresa = f_mascara_moneda(v_moneda_empresa)
v_nombre_moneda_empresa  = f_nombre_moneda_abr(v_moneda_empresa)

for v_indice = 1 to v_total
	f_mensaje_proceso('Calculando',v_indice,v_total)
	v_cuenta_operador_intracomunitario = ds_datos.object.genter_cuenta[v_indice]
	if left(v_cuenta_operador_intracomunitario,4) <> "4101" or 1 = 1 then
		//No es un agente
		v_base_imponible					        = ds_datos.object.imponible[v_indice]
		v_cif							              = ds_datos.object.genter_cif[v_indice]
		v_nombre_pais                         = ds_datos.object.paises_nombre[v_indice]
		v_tipoter                             = ds_datos.object.contaapun_tipoter[v_indice]
		v_clipro										  = ds_datos.object.contaapun_clipro[v_indice]
		v_razon										  = ds_datos.object.genter_razon[v_indice]
		v_pais										  = ds_datos.object.paises_pais[v_indice]
		ls_factura                            = ds_datos.object.contaapun_factura[v_indice]
		ldt_ffactura                          = ds_datos.object.contaapun_ffactura[v_indice]
		ldt_fregistro                         = ds_datos.object.contaapun_fregistro[v_indice]
		v_donde			     				        = arg_dw.insertrow(0)
		
		arg_dw.object.empresa[v_donde]        = codigo_empresa
   	arg_dw.object.tipoter[v_donde]        = v_tipoter
		arg_dw.object.clipro[v_donde]         = v_clipro
   	arg_dw.object.razon[v_donde]          = v_razon
		arg_dw.object.base_imponible[v_donde] = v_base_imponible
		arg_dw.object.moneda[v_donde]         = v_nombre_moneda_empresa
		arg_dw.object.cif[v_donde]            = v_cif
		arg_dw.object.mascara_moneda[v_donde] = v_mascara_moneda_empresa
		arg_dw.object.ejercicio[v_donde]      = v_ejercicio
		arg_dw.object.periodo[v_donde]        = v_periodo
		arg_dw.object.nombre_pais[v_donde]    = v_nombre_pais
		arg_dw.object.pais[v_donde]           = v_pais
		arg_dw.object.factura[v_donde]        = ls_factura
		arg_dw.object.ffactura[v_donde]       = ldt_ffactura
		arg_dw.object.fregistro[v_donde]      = ldt_fregistro
	end if
next

destroy ds_datos

arg_dw.sort()
arg_dw.groupcalc()
arg_dw.setredraw(true)
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Modelo 349"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

//f_mascara_columna(dw_detalle,"total",f_mascara_decimales(0))
//f_mascara_columna(dw_detalle,"porcentaje",f_mascara_decimales(2))
//f_mascara_columna(dw_detalle,"total_pts",f_mascara_decimales(0))
//f_mascara_columna(dw_detalle,"tot_pts1",f_mascara_decimales(0))
//f_mascara_columna(dw_detalle,"tot_pts2",f_mascara_decimales(0))
//f_mascara_columna(dw_detalle,"tot_pts3",f_mascara_decimales(0))
//f_mascara_columna(dw_detalle,"tot_pts4",f_mascara_decimales(0))
//f_mascara_columna(dw_listado,"total",f_mascara_decimales(2))
//f_mascara_columna(dw_listado,"porcentaje",f_mascara_decimales(2))
//f_mascara_columna(dw_listado,"total_pts",f_mascara_decimales(0))
//f_mascara_columna(dw_listado,"tot_pts1",f_mascara_decimales(0))
//f_mascara_columna(dw_listado,"tot_pts2",f_mascara_decimales(0))
//f_mascara_columna(dw_listado,"tot_pts3",f_mascara_decimales(0))
//f_mascara_columna(dw_listado,"tot_pts4",f_mascara_decimales(0))

f_activar_campo(em_fechadesde)



end event

on w_con_349_gno.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_3=create gb_3
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.cb_2=create cb_2
this.gb_1=create gb_1
this.cb_3=create cb_3
this.dw_lineas=create dw_lineas
this.dw_proceso=create dw_proceso
this.em_telefono_contacto=create em_telefono_contacto
this.em_persona_contacto=create em_persona_contacto
this.st_1=create st_1
this.st_2=create st_2
this.pb_4=create pb_4
this.dw_detalle=create dw_detalle
this.gb_10=create gb_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.dw_lineas
this.Control[iCurrent+14]=this.dw_proceso
this.Control[iCurrent+15]=this.em_telefono_contacto
this.Control[iCurrent+16]=this.em_persona_contacto
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.pb_4
this.Control[iCurrent+20]=this.dw_detalle
this.Control[iCurrent+21]=this.gb_10
end on

on w_con_349_gno.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.cb_3)
destroy(this.dw_lineas)
destroy(this.dw_proceso)
destroy(this.em_telefono_contacto)
destroy(this.em_persona_contacto)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_4)
destroy(this.dw_detalle)
destroy(this.gb_10)
end on

event ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_f5;f_control(dw_detalle,"S")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_349_gno
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_349_gno
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_349_gno
integer width = 2359
integer height = 108
end type

type pb_1 from upb_salir within w_con_349_gno
integer x = 3451
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_349_gno
integer x = 3429
integer y = 152
integer taborder = 0
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = "MODELO 349"
u_imp.isSubTitulo = "DESDE '"+em_fechadesde.text +"' HASTA '"+em_fechahasta.text+"'"
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_detalle)

end event

type em_fechadesde from u_em_campo within w_con_349_gno
integer x = 32
integer y = 168
integer width = 256
integer height = 80
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_349_gno
integer x = 306
integer y = 168
integer width = 256
integer height = 80
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_349_gno
boolean visible = false
integer x = 2382
integer y = 8
integer width = 645
integer height = 108
string dataobject = "report_con_349"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_349_gno
integer x = 2848
integer y = 152
integer width = 288
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;dw_detalle.dataobject = "dw_con_349"
f_carga_dw(dw_detalle)

end event

type gb_3 from groupbox within w_con_349_gno
integer x = 2830
integer y = 112
integer width = 754
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_con_349_gno
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 599
integer y = 168
integer width = 1527
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,'C',uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_349_gno
integer x = 585
integer y = 112
integer width = 1559
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

type cb_2 from commandbutton within w_con_349_gno
integer x = 3136
integer y = 152
integer width = 288
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;dw_detalle.dataobject = "dw_con_349_detalle"
f_cargar_dw_detalle(dw_detalle)


//if detalle then
//	dw_detalle.modify("datawindow.detail.height=0")
//	dw_detalle.modify("datawindow.trailer.2.height=0")
//	dw_listado.modify("datawindow.detail.height=0")
//	dw_listado.modify("datawindow.trailer.2.height=0")
//	cb_2.text="Detalle"
//else
//	dw_detalle.modify("datawindow.detail.height=77")
//	dw_detalle.modify("datawindow.trailer.2.height=77")
//	dw_listado.modify("datawindow.detail.height=77")
//	dw_listado.modify("datawindow.trailer.2.height=77")
//	cb_2.text="Resumen"
//end if
//
//detalle=not detalle
end event

type gb_1 from groupbox within w_con_349_gno
integer x = 18
integer y = 112
integer width = 562
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type cb_3 from u_boton within w_con_349_gno
boolean visible = false
integer x = 2400
integer y = 304
integer width = 430
integer height = 108
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Grabar"
end type

event clicked;dw_proceso.SetTransObject(SQLCA)

f_control(dw_proceso,"N")

Dec op ,i,fila,ii,dimporte
Dec ej1,ej2
String cliente,importe,tri,pro,signo,pr,var_telefono_contacto,var_persona_contacto
STring razon,ejercicio,nif,razon_cliente,linea,cl,cif,pais,moneda_empresa
str_parametros datos_rectificacion
tipo_array rectificacion
string ejercicio_rectificacion,periodo,cuenta
long   donde
boolean continuar = true

DataStore  dw_intra

op = messagebox("ATENCIÓN","La información se va a grabar en disquete Segun BOE 01/04/99"  + &
		" ¿Desea continuar?",question!,yesno!,1 )
if op = 2 then return

moneda_empresa = f_moneda_empresa(codigo_empresa)

signo = ""
tri = "1T"
iF Month(Date(em_fechadesde.text))  >1 Then 	tri = "1T"
iF Month(date(em_fechadesde.text))  >3  Then tri = "2T"
iF Month(date(em_fechadesde.text))  >6  Then tri = "3T"
iF Month(date(em_fechadesde.text))  >9  Then tri = "4T"

ej1 = year(date(em_fechadesde.text))
ej2 = year(date(em_fechahasta.text))
if ej1 <> ej2 then 
	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
	return
end if

if date(em_fechadesde.text) > date(em_fechahasta.text) then
	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
	return
end if

var_telefono_contacto = em_telefono_contacto.text
var_persona_contacto  = em_persona_contacto.text

if trim(var_telefono_contacto) = "" then
	f_mensaje("Atención","Debe introducir el telefono de contacto.")
	return	
else
	if len(var_telefono_contacto) <> 9 then
		f_mensaje("Atención","El telefono de contacto debe ser de 9 digitos.")
		return			
	end if
end if

if trim(var_persona_contacto) = "" then
	f_mensaje("Atención","Debe introducir la Persona de contacto.")
	return	
else
	var_persona_contacto = trim(var_persona_contacto)
	var_persona_contacto = var_persona_contacto+space(40 - len(var_persona_contacto))
end if

ejercicio = string(year(date(em_fechahasta.text)))

pro = f_provincia_empresa(codigo_empresa)

razon = f_nombre_empresa(codigo_empresa)
cif   = f_tratar_nif(f_cif_empresa(codigo_empresa),"ES",razon)


linea  = "1349"+String(ejercicio)+tri+pro+cif+razon+&
			SPACE(74)+&
			var_telefono_contacto+var_persona_contacto
			
donde = dw_lineas.insertrow(0)
messagebox(string(len(linea)),"")

dw_lineas.Object.linea[donde] = linea

for i = 1 to dw_proceso.rowcount()  
	if continuar then
		cliente       = dw_proceso.getitemstring(i,"cliente")
		//if cliente <> f_codigo_cliente_empresa(codigo_empresa) then
			if isnull(cliente) then cliente = ""
			razon_cliente = f_razon_genter(codigo_empresa,"C",dw_proceso.getitemstring(i,"cliente"))+ Space(40)
			if isnull(razon_cliente) then razon_cliente = ""
			if len(razon_cliente) < 40 then
				razon_cliente = razon_cliente + Space(40 - len(razon_cliente))
			else
				razon_cliente = Mid(razon_cliente,1,40)		
			end if		
			clave         = dw_proceso.getitemstring(i,"paises_clave")
			if isnull(clave) then clave = ""
			nif           = trim(f_cif_genter(codigo_empresa,"C",dw_proceso.getitemstring(i,"cliente")))
			if isnull(nif) then nif = ""
			nif           = f_tratar_nif(nif,clave,razon_cliente)
			if len(nif) < 12 then
				nif = nif + space(12 - len(nif))	
			else
				nif = Mid(nif,1,12)		
			end if
			if moneda_empresa = "1" then
				dimporte       = round(dw_proceso.getitemnumber(i,"total_fac_pts") / 166.386,2)
				importe        = String(dimporte*100,"############0")				
			else
				dimporte       = dw_proceso.getitemnumber(i,"total_fac_pts")
				importe        = String(dimporte*100,"############0")				
			end if
		
			if dimporte >= 0 Then 
				cl    = "1"
				signo = ""
				ejercicio_rectificacion = ""
				periodo                 = ""
			else
				// El importe negativo supone una rectificación sobre un periodo anterior
		
				datos_rectificacion.s_argumentos[1] = String(ejercicio)
				datos_rectificacion.s_argumentos[2] = tri
				datos_rectificacion.s_argumentos[3] = trim(razon_cliente)
				datos_rectificacion.s_argumentos[4] = string(dimporte,"###,###,###,##0.00")
		
				openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
		
				rectificacion = message.powerObjectparm
				ejercicio_rectificacion = rectificacion.valor[1]
				periodo                 = rectificacion.valor[2]
				if ejercicio_rectificacion = "RETURN" then
					continuar = false
				end if			
				cl    = "3"
				signo = "-"
				importe = String((dimporte * (-1)*100),"############0")
			END IF
			importe = Space(13 - len(Trim(importe))) + Trim(importe )	
			
			linea  = "2349"+String(ejercicio)+tri+pro+cif+Trim(cl)+Trim(clave)+Mid(nif,1,12)+Mid(razon_cliente,1,40)+Mid(importe,1,13)+" "+signo+ejercicio_rectificacion+periodo
			if trim(linea) <> "" then
				donde = dw_lineas.insertrow(0)
				dw_lineas.Object.linea[donde] = linea
			end if
		//end if
	end if
Next

if continuar then
	String sel
	
	sel = " Select clipro,sum(imponible) imponible from contaapun  " +&
			" Where  ejercicio = " +ejercicio+&
			" And    empresa   = '" +codigo_empresa+"'"+&
			" And    fapunte between '" + String(Date(em_fechadesde.text),formato_fecha_cursores) + "' and '" + String(Date(em_fechahasta.text),formato_fecha_cursores) +"'"+&
			" And    tipoapu = '4'"+&
			" And    tipoter = 'P'"+&
			" And    cuenta  LIKE '472%'" +&
			" Group by clipro"
		
	dw_intra = f_cargar_cursor(sel)
	signo = ""
	For ii = 1 To dw_intra.RowCount()	
		pr    = dw_intra.Object.clipro[ii]	
		if isnull(pr) then pr = ""
		pais   = f_pais_genter(codigo_empresa,"P",pr)
		if isnull(pais) then pais = ""
		cuenta = f_cuenta_genter(codigo_empresa,"P",pr)
		
		//Quitamos los agentes
		if left(cuenta,4) <> "4104" then				
			if f_tipo_pais(pais) = "C" then		
				razon_cliente = trim(f_razon_genter(codigo_empresa,"P",pr))
				if isnull(razon_cliente) then razon_cliente = ""
				if len(razon_cliente) < 40 then
					razon_cliente = razon_cliente + Space(40 - len(razon_cliente))
				else
					razon_cliente = Mid(razon_cliente,1,40)		
				end if	
				clave = f_clave_pais(pais)
				if isnull(clave) then clave = ""
				nif   = trim(f_cif_genter(codigo_empresa,"P",pr))
				if isnull(nif) then nif = ""
				nif   = f_tratar_nif(nif,clave,razon_cliente)
				if len(nif) < 12 then
					nif = nif + space(12 - len(nif))	
				else
					nif = Mid(nif,1,12)		
				end if
				
				if moneda_empresa = "1" then
					dimporte      = round(dw_intra.Object.imponible[ii]/166.386,2)
					importe       = string(dimporte*100,"############0")				
				else
					dimporte      = dw_intra.Object.imponible[ii]
					importe       = string(dimporte*100,"############0")				
				end if
	/////////			
				if dimporte >= 0 Then 
					cl    = "2"
					signo = ""
					ejercicio_rectificacion = ""
					periodo                 = ""
				else
					// El importe negativo supone una rectificación sobre un periodo anterior
			
					datos_rectificacion.s_argumentos[1] = String(ejercicio)
					datos_rectificacion.s_argumentos[2] = tri
					datos_rectificacion.s_argumentos[3] = trim(razon_cliente)
					datos_rectificacion.s_argumentos[4] = string(dimporte,"###,###,###,##0.00")
			
					openWithParm(w_pedir_trimestre_rectificacion_349,datos_rectificacion)
			
					rectificacion = message.powerObjectparm
					ejercicio_rectificacion = rectificacion.valor[1]
					periodo                 = rectificacion.valor[2]
					if ejercicio_rectificacion = "RETURN" then
						continuar = false
					end if			
					cl    = "4"
					signo = "-"
					importe = String((dimporte * (-1)*100),"############0")
				END IF
				importe = Space(13 - len(Trim(importe))) + Trim(importe )					
	////////			
				linea = "2349"+String(ejercicio)+tri+pro+cif+cl+Trim(clave)+Mid(nif,1,12)+razon_cliente+Mid(importe,1,13)+" "+signo+ejercicio_rectificacion+periodo
				if trim(linea) <> "" then
					donde = dw_lineas.insertrow(0)
					dw_lineas.Object.linea[donde] = linea
				end if
			end if
		end if
	Next
	
	// *********************************************************************
	// GRABAR A DISQUETE
	// *********************************************************************
	
	
	// Nombre del fichero OPXX siendo XX el ejercicio
	
	string ejer_corto,fichero
	int res 
	
	ejer_corto = mid(ejercicio,3,2)
	fichero = "OP349" + ejer_corto+ ".TXT"
	
	if dw_lineas.rowcount() > 0 then
		res = dw_lineas.saveas("a:\" + fichero,text!,false) /** Sustituida x:\ por a:\ **/
		if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
		if res = 1 then f_mensaje("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
	end if		
else
	messagebox("Atención","Operación cancelada")	
end if

setpointer(arrow!)
end event

type dw_lineas from datawindow within w_con_349_gno
boolean visible = false
integer x = 827
integer y = 216
integer width = 494
integer height = 360
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_349"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_proceso from datawindow within w_con_349_gno
boolean visible = false
integer x = 1518
integer y = 48
integer width = 494
integer height = 360
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso349"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_telefono_contacto from u_em_campo within w_con_349_gno
integer x = 530
integer y = 320
integer width = 306
integer height = 80
integer taborder = 70
boolean bringtotop = true
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "#########"
end type

type em_persona_contacto from u_em_campo within w_con_349_gno
integer x = 1330
integer y = 320
integer width = 1056
integer height = 80
integer taborder = 80
boolean bringtotop = true
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_1 from statictext within w_con_349_gno
integer x = 46
integer y = 328
integer width = 485
integer height = 60
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
string text = "Telefono Contacto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_349_gno
integer x = 846
integer y = 328
integer width = 485
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Persona Contacto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_4 from picturebutton within w_con_349_gno
integer x = 3429
integer y = 304
integer width = 142
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\disksave.bmp"
end type

event clicked;f_graba_soporte_magnetico()
end event

type dw_detalle from datawindow within w_con_349_gno
integer y = 428
integer width = 3589
integer height = 1408
string dataobject = "dw_con_349_detalle"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

event clicked;//IF f_objeto_datawindow(This)= "grafico" Then
//	IF grafico = "N" Then
//		grafico = "S"
//		this.Object.elgrafico.x = 0
//		this.Object.elgrafico.y = 0
//		this.Object.elgrafico.height = 1100
//		this.Object.elgrafico.width = 3031
//		this.Object.elgrafico.visible = 1
//	ELSE
//		grafico = "N"
//		this.Object.elgrafico.visible = 0
//	END IF
//
//END IF
end event

type gb_10 from groupbox within w_con_349_gno
integer x = 18
integer y = 264
integer width = 3566
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Soporte Magnetico"
end type

