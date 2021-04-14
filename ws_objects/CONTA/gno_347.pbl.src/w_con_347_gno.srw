$PBExportHeader$w_con_347_gno.srw
$PBExportComments$Nacional
forward
global type w_con_347_gno from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_347_gno
end type
type pb_2 from upb_imprimir within w_con_347_gno
end type
type em_fechadesde from u_em_campo within w_con_347_gno
end type
type em_fechahasta from u_em_campo within w_con_347_gno
end type
type cb_1 from commandbutton within w_con_347_gno
end type
type gb_3 from groupbox within w_con_347_gno
end type
type gb_2 from groupbox within w_con_347_gno
end type
type gb_1 from groupbox within w_con_347_gno
end type
type dw_lineas from datawindow within w_con_347_gno
end type
type em_telefono_contacto from u_em_campo within w_con_347_gno
end type
type em_persona_contacto from u_em_campo within w_con_347_gno
end type
type st_1 from statictext within w_con_347_gno
end type
type st_2 from statictext within w_con_347_gno
end type
type em_justificante from u_em_campo within w_con_347_gno
end type
type ddlb_tipo_declaracion from dropdownlistbox within w_con_347_gno
end type
type st_justificante from statictext within w_con_347_gno
end type
type dw_cartas from datawindow within w_con_347_gno
end type
type pb_cartas from upb_imprimir within w_con_347_gno
end type
type st_3 from statictext within w_con_347_gno
end type
type gb_10 from groupbox within w_con_347_gno
end type
type pb_3 from picturebutton within w_con_347_gno
end type
type dw_listado from datawindow within w_con_347_gno
end type
type dw_detalle from datawindow within w_con_347_gno
end type
type dw_efectivo from datawindow within w_con_347_gno
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_347_gno from w_int_con_empresa
integer width = 4640
integer height = 3196
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_lineas dw_lineas
em_telefono_contacto em_telefono_contacto
em_persona_contacto em_persona_contacto
st_1 st_1
st_2 st_2
em_justificante em_justificante
ddlb_tipo_declaracion ddlb_tipo_declaracion
st_justificante st_justificante
dw_cartas dw_cartas
pb_cartas pb_cartas
st_3 st_3
gb_10 gb_10
pb_3 pb_3
dw_listado dw_listado
dw_detalle dw_detalle
dw_efectivo dw_efectivo
end type
global w_con_347_gno w_con_347_gno

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public function string f_tratar_nif (string arg_nif, string arg_tercero)
public subroutine f_grabar_disco ()
public function string f_relleno_cadena (string cadena, string relleno, string izq_der, integer longitud_cadena)
public function string f_tratar_razon (string arg_razon)
public subroutine f_tratar_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta)
public subroutine f_tratar_numero (ref string arg_numero)
public subroutine f_tratar_texto (ref string arg_texto)
public subroutine f_mod_2009 (datawindow data)
public subroutine f_modf_2009 (datawindow data)
public subroutine f_grabar_sisco_old ()
end prototypes

public subroutine f_control (datawindow data);string    libro_iva_ventas_nacional,libro_iva_compras_nacional
string    tipo_cuenta_libro_ventas,tipo_cuenta_libro_compras
string    formula_ventas,formula_compras,sel,formula_ventas_1t,formula_ventas_2t,formula_ventas_3t,formula_ventas_4t
string    formula_compras_1t,formula_compras_2t,formula_compras_3t,formula_compras_4t
string    tercero,tipoter,nif,nombre_tercero,moneda,error_nif
dec       importe_operaciones,irpf,importe_operaciones_1t,importe_operaciones_2t,importe_operaciones_3t,importe_operaciones_4t
datetime  fecha_desde,fecha_hasta
int       ejercicio
long      indice,total,donde

datastore operaciones

data.reset()
data.SetRedraw(false)

fecha_desde = datetime(date(em_fechadesde.text))
fecha_hasta = datetime(date(em_fechahasta.text))

data.retrieve(codigo_empresa,fecha_desde,fecha_hasta)

ejercicio   = year(date(fecha_desde))

moneda      = f_moneda_empresa(codigo_empresa) 

tipo_cuenta_libro_ventas   = f_tipo_cta_libro(ejercicio,codigo_empresa,libro_iva_ventas_nacional)
tipo_cuenta_libro_compras  = f_tipo_cta_libro(ejercicio,codigo_empresa,libro_iva_compras_nacional)

formula_ventas = " sum(haber - debe) + sum(imponible) "
formula_ventas_1t = " ,sum(case when datepart(mm,fapunte) between 1 and 3 then (haber - debe) + (imponible) else 0 end) as importe_operaciones_1t "
formula_ventas_2t = " ,sum(case when datepart(mm,fapunte) between 4 and 6 then (haber - debe) + (imponible) else 0 end) as importe_operaciones_2t "
formula_ventas_3t = " ,sum(case when datepart(mm,fapunte) between 7 and 9 then (haber - debe) + (imponible) else 0 end) as importe_operaciones_3t "
formula_ventas_4t = " ,sum(case when datepart(mm,fapunte) between 10 and 12 then (haber - debe) + (imponible) else 0 end) as importe_operaciones_4t "

formula_compras = " sum(debe - haber) + sum(imponible) "	
formula_compras_1t = " ,sum(case when datepart(mm,fapunte) between 1 and 3 then (debe - haber) + (imponible) else 0 end) as importe_operaciones_1t "
formula_compras_2t = " ,sum(case when datepart(mm,fapunte) between 4 and 6 then (debe - haber) + (imponible) else 0 end) as importe_operaciones_2t "
formula_compras_3t = " ,sum(case when datepart(mm,fapunte) between 7 and 9 then (debe - haber) + (imponible) else 0 end) as importe_operaciones_3t "
formula_compras_4t = " ,sum(case when datepart(mm,fapunte) between 10 and 12 then (debe - haber) + (imponible) else 0 end) as importe_operaciones_4t "	


Sel = " SELECT "+formula_ventas+" importe_operaciones,clipro,tipoter " +&
					formula_ventas_1t+&
					formula_ventas_2t+&
					formula_ventas_3t+&
					formula_ventas_4t+&
      " FROM   contaapun " +&
      " WHERE  empresa   = '"+codigo_empresa+"'" +&
      " AND    ejercicio = "+string(ejercicio,"####")+&
		" AND    tipoapu  IN (SELECT codigo from contalibros "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   tipo      = 'V' ) "+&
		" AND    tipoiva in (SELECT tipoiva from contaiva "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   incluir_en_modelo_347 = 'S' ) "+&		
		" AND    fapunte between '"+STring(Date(fecha_desde),gs_formato_fecha_cursores)+"' "+&
		 						 " and '"+STring(Date(fecha_hasta),gs_formato_fecha_cursores)+"' "+&
		" AND    clipro in ( SELECT codigo from genter "+&
								  "WHERE empresa = '"+codigo_empresa+"' "+&
								  "AND   tipoter = 'C' "+&
								  "AND   pais    in (select pais from paises where tipopais = 'N') ) "+&		
		" GROUP BY tipoter,clipro "+&
		" UNION "+&
      " SELECT "+formula_compras+" importe_operaciones,clipro,tipoter " +&
					formula_compras_1t+&
					formula_compras_2t+&
					formula_compras_3t+&
					formula_compras_4t+&				
      " FROM   contaapun " +&
      " WHERE  empresa   = '"+codigo_empresa+"'" +&
      " AND    ejercicio = "+string(ejercicio,"####")+&
		" AND    tipoapu  IN (SELECT codigo from contalibros "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   tipo      = 'C') "+&
		" AND    tipoiva in (SELECT tipoiva from contaiva "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   incluir_en_modelo_347 = 'S' ) "+&											
		" AND    fapunte between '"+STring(Date(fecha_desde),gs_formato_fecha_cursores)+"' "+&
		 						 " and '"+STring(Date(fecha_hasta),gs_formato_fecha_cursores)+"' "+&
		" AND    clipro in ( SELECT codigo from genter "+&
								  "WHERE empresa = '"+codigo_empresa+"' "+&
								  "AND   tipoter = 'P' "+&
								  "AND   pais    in (select pais from paises where tipopais = 'N') ) "+&		
		" AND   convert(char,asiento)+convert(char,mes) not in ( SELECT convert(char,asiento)+convert(char,mes) from contaapun "+&
										"WHERE  empresa = '"+codigo_empresa+"' "+&
										" AND   fapunte between '"+STring(Date(fecha_desde),gs_formato_fecha_cursores)+"' "+&
		 						 								" and '"+STring(Date(fecha_hasta),gs_formato_fecha_cursores)+"' "+&
										" AND   cuenta like '4751%')"+& 
		" GROUP BY tipoter,clipro "		
		
clipboard(sel)		
//Quitamos todo lo que tenga retenciones " AND   cuenta like '4751%')"+& 
f_mensaje_proceso("Obteniendo datos",0,100)		

f_cargar_cursor_transaccion(sqlca,operaciones,sel)		

f_mensaje_proceso("Obteniendo datos",50,100)		

total = operaciones.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando datos",total+indice,total*2)	
	tercero             = operaciones.object.clipro[indice]
	tipoter             = operaciones.object.tipoter[indice]
	importe_operaciones = operaciones.object.importe_operaciones[indice]
	importe_operaciones_1t = operaciones.object.importe_operaciones_1t[indice]
	importe_operaciones_2t = operaciones.object.importe_operaciones_2t[indice]
	importe_operaciones_3t = operaciones.object.importe_operaciones_3t[indice]
	importe_operaciones_4t = operaciones.object.importe_operaciones_4t[indice]
	
	if tipoter = "P" then
		irpf = 0
		
//		SELECT irpf
//		INTO   :irpf
//		FROM   comproveedores  
//		WHERE  empresa = :codigo_empresa
//		AND    codigo  = :tercero;
		
		if isnull(irpf) then irpf = 0		
	else
		irpf = 0
	end if
	
	if importe_operaciones > 3005.06 and irpf = 0 then
		nombre_tercero = f_razon_genter(codigo_empresa,tipoter,tercero)
		nif            = f_cif_genter(codigo_empresa,tipoter,tercero)
		if isnull(nif) then nif = ""
		nif            = f_tratar_nif(nif,nombre_tercero)
		
		if len(nif) <> 9 then
			error_nif = "S"
		else
			error_nif = "N"
		end if
		
		donde = data.insertrow(0)
		
		data.object.empresa[donde]             = codigo_empresa
		data.object.nombre_tercero[donde]      = nombre_tercero
		data.object.tercero[donde]             = tercero
		data.object.tipoter[donde]             = tipoter
		data.object.importe_operaciones[donde] = importe_operaciones
		data.object.nif[donde]                 = nif
		data.object.moneda[donde]              = moneda
		data.object.error_nif[donde]           = error_nif
		data.object.importe_operaciones_1t[donde] = importe_operaciones_1t
		data.object.importe_operaciones_2t[donde] = importe_operaciones_2t
		data.object.importe_operaciones_3t[donde] = importe_operaciones_3t
		data.object.importe_operaciones_4t[donde] = importe_operaciones_4t		
	end if
next

destroy operaciones

data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

public function string f_tratar_nif (string arg_nif, string arg_tercero);string var_nif,nuevo_nif,caracter
long   indice,total,asci,longitud_nif

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
	messagebox("Error en NIF ","El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
end if

return nuevo_nif
end function

public subroutine f_grabar_disco ();string  tipo_registro,modelo_declaracion,ejercicio,nif_declarante,razon_empresa,tipo_soporte
string  telefono_contacto,persona_contacto,numero_justificante,tipo_declaracion,justificante_anterior
string  numero_personas_entidades,importe_total_operaciones,numero_inmuebles,importe_total_inmuebles
string  blancos,sello_electronico,registro_declarante,lineas_defectuosas
string  nif_declarado,nif_representante,razon_declarado,tipo_hoja,codigo_provincia,codigo_pais
string  clave_codigo,importe_operaciones,operacion_seguro,arrendamiento_local,registro_declarado
string  fichero,ruta,ejer_corto,moneda_empresa,registro_presentacion_colectiva,importe_metalico,importe_metalico_dec
string  razon_social_del_presentador,nombre_via_publica,municipio,codigo_postal
string  nif_del_presentador,siglas_via_publica,numero,escalera,piso,puerta,domicilio_del_presentador,blancos2
string  total_declarantes,total_declarados,persona_con_quien_relacionarse,anyo_metalico,ls_signo
string  ls_importe_operaciones_1t,ls_importe_operaciones_2t,ls_importe_operaciones_3t,ls_importe_operaciones_4t
string  ls_importe_anual_trans_inmuebles,ls_importe_anual_trans_inmuebles_1t,ls_importe_anual_trans_inmuebles_2t,ls_importe_anual_trans_inmuebles_3t,ls_importe_anual_trans_inmuebles_4t
long    indice,total,donde,v_ejercicio,res,factor_conversion, total_registros
dec     importe_total
int     decimales_moneda_empresa
long ll_found
boolean bien = true
 
moneda_empresa           = f_moneda_empresa(codigo_empresa)
 
decimales_moneda_empresa = f_decimales_moneda(moneda_empresa)
 
factor_conversion = 1
 
for indice = 1 to decimales_moneda_empresa
 factor_conversion = factor_conversion * 10
next
 
dw_lineas.reset()
v_ejercicio = year(date(em_fechadesde.text))
total       = dw_detalle.rowcount()
 
razon_empresa       = f_tratar_razon(f_nombre_empresa(codigo_empresa))
razon_empresa       = f_relleno_cadena(razon_empresa," ","D",40)
 
select nombre,         domicilio,     ciudad,
   provincia,        codpostal,     cif,
   cl_domicilio,       nu_domicilio
into   :razon_social_del_presentador,:nombre_via_publica,  :municipio,
   :codigo_provincia,            :codigo_postal,       :nif_del_presentador,
   :siglas_via_publica,          :numero
from   empresas
where  empresa = :codigo_empresa;
 
escalera = ''
piso     = ''
puerta   = ''
 

//TIPO DE REGISTRO 1 : REGISTRO DECLARANTE
 
tipo_registro       = "1"
modelo_declaracion  = "347"
ejercicio           = string(v_ejercicio,"####")
nif_declarante      = f_tratar_nif(f_cif_empresa(codigo_empresa),f_nombre_empresa(codigo_empresa))
tipo_soporte        = "T"//"D"
telefono_contacto   = em_telefono_contacto.text
persona_contacto    = em_persona_contacto.text
persona_contacto    = f_relleno_cadena(persona_contacto," ","D",40)
numero_justificante = f_relleno_cadena("","0","I",13)
 
choose case ddlb_tipo_declaracion.text
 case "Normal"
  tipo_declaracion      = "  "
  justificante_anterior = f_relleno_cadena("","0","I",13)
 case "Complementaria"
  tipo_declaracion      = "C "
  justificante_anterior = f_relleno_cadena("","0","I",13)
 case "Sustitutiva"
  tipo_declaracion      = " S"
  justificante_anterior = f_relleno_cadena(em_justificante.text,"0","I",13)
end choose
 
numero_personas_entidades = string(total,"########")
numero_personas_entidades = f_relleno_cadena(numero_personas_entidades,"0","I",9)
 
for indice = 1 to total
 importe_total = importe_total + dw_detalle.object.importe_operaciones[indice]
next

 if importe_total < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if 

importe_total_operaciones = string(abs(importe_total) * factor_conversion,"##############")
importe_total_operaciones = ls_signo+f_relleno_cadena(importe_total_operaciones,"0","I",15)
 
numero_inmuebles          = f_relleno_cadena("","0","I",9)
importe_total_inmuebles   = " "+f_relleno_cadena("","0","I",15) //Blanco
blancos                   = f_relleno_cadena(""," ","D",205) //1 menos 
nif_representante         = f_relleno_cadena(""," ","D",9)
blancos2                  = f_relleno_cadena(""," ","D",88)
sello_electronico         = f_relleno_cadena(""," ","D",13)
 
registro_declarante = tipo_registro             +&
        modelo_declaracion        +&
        ejercicio                 +&
        nif_declarante            +&
        razon_empresa             +&
        tipo_soporte              +&
        telefono_contacto         +&
        persona_contacto          +&
        numero_justificante       +&
        tipo_declaracion          +&
        justificante_anterior     +&
        numero_personas_entidades +&
        importe_total_operaciones +&
        numero_inmuebles          +&
        importe_total_inmuebles   +&
        blancos                   +&
        nif_representante   +&
        blancos2      +&
        sello_electronico
 
donde = dw_lineas.insertrow(0)       
 
dw_lineas.object.linea[donde] = registro_declarante
 
if len(registro_declarante) <> 500 then
 bien = false
 lineas_defectuosas = string(donde,"####")+"("+string(len(registro_declarante),"###")+")"
end if
 
for indice = 1 to total
 f_mensaje_proceso("Procesando :",indice,total)
 // TIPO DE REGISTRO 2 : REGISTRO DE DECLARADO
 
 tipo_registro       = "2"
 modelo_declaracion  = "347"
 ejercicio           = string(v_ejercicio,"####") 
 nif_declarado       = dw_detalle.object.nif[indice]
 nif_representante   = f_relleno_cadena(""," ","D",9)
 razon_declarado     = f_tratar_razon(dw_detalle.object.nombre_tercero[indice])
 razon_declarado     = f_relleno_cadena(razon_declarado," ","D",40)
 tipo_hoja           = "D"
 codigo_provincia    = trim(f_provincia_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
 codigo_provincia    = f_relleno_cadena(codigo_provincia,"0","I",2)
 codigo_pais         = '  '//trim(f_pais_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
 codigo_pais         = f_relleno_cadena(codigo_pais," ","D",2)
 
 if dw_detalle.object.tipoter[indice] = "C" then
  clave_codigo = "B" //Entregas
 else
  clave_codigo = "A" //Adquisiciones
 end if
 
 if dw_detalle.object.importe_operaciones[indice] < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if 
 importe_operaciones = string(abs(dw_detalle.object.importe_operaciones[indice]) * factor_conversion,"###############")
 importe_operaciones = ls_signo+f_relleno_cadena(importe_operaciones,"0","I",15)
  
 operacion_seguro    = " "
 arrendamiento_local = " "
 
 ll_found= 0
 
 ll_found = dw_efectivo.Find("tercero = '" + dw_detalle.object.tercero[indice] + "'", 1, dw_efectivo.RowCount())
 
 if ll_found <> 0 then
  dec operacion
  importe_metalico   = string(dw_efectivo.object.importe_operaciones[ll_found])
  operacion    = truncate(dec(importe_metalico),2)
  importe_metalico  = string(truncate(operacion,0))
  importe_metalico_dec = string(TRUNCATE((operacion - dec(importe_metalico))*100,0))
  importe_metalico_dec = f_relleno_cadena(importe_metalico_dec,"0","I",2)
  importe_metalico   = f_relleno_cadena(importe_metalico,"0","I",13)
  anyo_metalico        = string(v_ejercicio,"0000")
 else
  importe_metalico     = '0000000000000'
  importe_metalico_dec = '00'
  anyo_metalico        = '0000'
 end if
 
 ls_importe_anual_trans_inmuebles = ' 0000000000000'+'00'
 
 if dw_detalle.object.importe_operaciones_1t[indice] < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if  
 ls_importe_operaciones_1t = string(abs(dw_detalle.object.importe_operaciones_1t[indice]) * factor_conversion,"###############")
 ls_importe_operaciones_1t = ls_signo + f_relleno_cadena(ls_importe_operaciones_1t,"0","I",15)
 
 if dw_detalle.object.importe_operaciones_2t[indice] < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if  
 ls_importe_operaciones_2t = string(abs(dw_detalle.object.importe_operaciones_2t[indice]) * factor_conversion,"###############")
 ls_importe_operaciones_2t = ls_signo + f_relleno_cadena(ls_importe_operaciones_2t,"0","I",15)
 
 if dw_detalle.object.importe_operaciones_3t[indice] < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if  
 ls_importe_operaciones_3t = string(abs(dw_detalle.object.importe_operaciones_3t[indice]) * factor_conversion,"###############")
 ls_importe_operaciones_3t = ls_signo + f_relleno_cadena(ls_importe_operaciones_3t,"0","I",15)
 
 if dw_detalle.object.importe_operaciones_4t[indice] < 0 then
 	ls_signo = 'N'
 else
	ls_signo = ' '
 end if  
 ls_importe_operaciones_4t = string(abs(dw_detalle.object.importe_operaciones_4t[indice]) * factor_conversion,"###############")
 ls_importe_operaciones_4t = ls_signo + f_relleno_cadena(ls_importe_operaciones_4t,"0","I",15)
 
 ls_importe_anual_trans_inmuebles_1t = ' 0000000000000'+'00'
 ls_importe_anual_trans_inmuebles_2t = ' 0000000000000'+'00'
 ls_importe_anual_trans_inmuebles_3t = ' 0000000000000'+'00'
 ls_importe_anual_trans_inmuebles_4t = ' 0000000000000'+'00'
 
//blancos = f_relleno_cadena(""," ","D",371)  //MUY ANTIGUO - Ya comentado 
//blancos = f_relleno_cadena(""," ","D",237) //Cambio modelo 347 - 2014
blancos = f_relleno_cadena(""," ","D",21) + '0000000000000'+'00'+ f_relleno_cadena(""," ","D",201) //Cambio modelo 347 - 2014

 
 registro_declarado = tipo_registro       +&
        modelo_declaracion  +&
        ejercicio           +&
        nif_declarante      +&
        nif_declarado       +&
        nif_representante   +&
        razon_declarado     +&
        tipo_hoja           +&
        codigo_provincia    +&
        codigo_pais         +&
        ' '       +&
        clave_codigo        +&
        importe_operaciones +&
        operacion_seguro    +&
        arrendamiento_local +&
        importe_metalico   +&
        importe_metalico_dec+&
        ls_importe_anual_trans_inmuebles+&
        anyo_metalico       +&
		  ls_importe_operaciones_1t+&
		  ls_importe_anual_trans_inmuebles_1t+&
		  ls_importe_operaciones_2t+&
		  ls_importe_anual_trans_inmuebles_2t+&
		  ls_importe_operaciones_3t+&
		  ls_importe_anual_trans_inmuebles_3t+&
		  ls_importe_operaciones_4t+&
		  ls_importe_anual_trans_inmuebles_4t+&		  
        blancos        
 
 donde = dw_lineas.insertrow(0)       
 
 dw_lineas.object.linea[donde] = registro_declarado
 
 total_registros = len(registro_declarado)
 if total_registros <> 500 then
  bien = false
  lineas_defectuosas = lineas_defectuosas + " " + string(donde,"####")+"("+string(len(registro_declarado),"###")+")"
 end if 
next
 
if not(bien) then
 if messagebox("Atención","Se han detectado errores el las lineas : "+lineas_defectuosas+"~n¿Desea grabar el fichero de todas formas?",StopSign!,YesNo!,1) = 1 then
  bien = true
 end if
end if
 
if bien then
 //if GetFileOpenName("Seleccione Directorio de la copia",ruta,fichero,"BMP","Texto (*.TXT),*.TXT") = 1 then
 // sle_ruta.text = ruta
 //end if
 ejer_corto = mid(ejercicio,3,2)
 //fichero    = "OP347" + ejer_corto+ ".TXT"
 ruta       = "OP347" + ejer_corto+ ".TXT"
 if GetFileSaveName("Fichero 347",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
  if dw_lineas.rowcount() > 0 then
   res = dw_lineas.saveas(ruta,text!,false)
   if res = -1 then messagebox("ERROR","Al grabar al disquete")
   if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
  end if  
 end if 
else
 messagebox("Error","Operación cancelada")
end if
 
 
end subroutine

public function string f_relleno_cadena (string cadena, string relleno, string izq_der, integer longitud_cadena);int l,i,k

cadena = upper(cadena)
cadena = trim(cadena)
l = len(cadena)
k = longitud_cadena - l

if l >= longitud_cadena then
	cadena = left(cadena,longitud_cadena)
else
	for i = 1 to k
		if izq_der = "I" then
			cadena = relleno + cadena
		else
			cadena = cadena + relleno
		end if
	next
end if

return cadena

end function

public function string f_tratar_razon (string arg_razon);string var_razon,nueva_razon,caracter,caracter_ant
long   indice,total,asci

var_razon    = Upper(trim(arg_razon))
nueva_razon  = ""
total        = len(var_razon)
caracter_ant = ""

for indice = 1 to total
	caracter = mid(var_razon,indice,1)
	
	choose case caracter
		case "Á"
			caracter = "A"
			caracter_ant = caracter
		case "É"
			caracter = "E"
			caracter_ant = caracter
		case "Í"
			caracter = "I"
			caracter_ant = caracter
		case "Ó"
			caracter = "O"
			caracter_ant = caracter
		case "Ú"
			caracter = "U"
			caracter_ant = caracter
		case "Ñ"
			caracter = char(209)
			caracter_ant = caracter
		case "Ç"
			caracter = char(199)
			caracter_ant = caracter
		case "(",")","º","ª"
			caracter = ""		
			caracter_ant = caracter
		case " "
			if caracter_ant = " " then
				caracter_ant = caracter
				caracter = ""		
			else
				caracter_ant = caracter
			end if
		case else
			if asc(caracter) < 32 or asc(caracter) > 128 then
				caracter = " "
				caracter_ant = caracter
			else
				caracter_ant = caracter
			end if
	end choose	
	nueva_razon  = nueva_razon + caracter	
next

return nueva_razon
end function

public subroutine f_tratar_campo (ref string arg_campo, string arg_tipo_campo, integer arg_pos_desde, integer arg_pos_hasta);int v_longitud_total,v_longitud,v_indice,v_longitud_relleno

if isnull(arg_campo) then arg_campo = ''

if arg_tipo_campo = "N" then
	//f_tratar_numero(arg_campo)
else
	//f_tratar_texto(arg_campo)
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
		case "Ñ"
			v_caracter = char(209)
		case "Ç"
			v_caracter = char(199)
		case "(",")","º","ª"
			v_caracter = ""		
		case else
			if asc(v_caracter) < 32 or asc(v_caracter) > 128 then
				v_caracter = " "
			end if
	end choose		
	
//	choose case v_caracter
//		case "Ñ"
//			v_caracter = char(209)
//		case "Ç"
//			v_caracter = char(199)
//		case "º","ª","°"
//			v_caracter = ""
//		case "(",")"
//			v_caracter = " "
//	end choose
	
	v_texto_tratado = v_texto_tratado + v_caracter
next

arg_texto = v_texto_tratado


end subroutine

public subroutine f_mod_2009 (datawindow data);
end subroutine

public subroutine f_modf_2009 (datawindow data);string    libro_iva_ventas_nacional,libro_iva_compras_nacional,factura
string    tipo_cuenta_libro_ventas,tipo_cuenta_libro_compras
string    formula_ventas,formula_compras,sel
string    tercero,tipoter,nif,nombre_tercero,moneda,error_nif
dec       importe_operaciones,irpf
datetime  fecha_desde,fecha_hasta
datetime ffactura
int       ejercicio
long      indice,total,donde

String cliproant,tipoterant
String clipro,nombre, lscif, lspoblacion, lscp
dec debeacum=0, haberacum=0, baseacum=0, ivaacum=0, totalacum=0

boolean efectivo

datastore operaciones

data.reset()
data.SetRedraw(false)

fecha_desde = datetime(date(em_fechadesde.text))
fecha_hasta = datetime(date(em_fechahasta.text))

data.retrieve(codigo_empresa,fecha_desde,fecha_hasta)

ejercicio   = year(date(fecha_desde))

moneda      = f_moneda_empresa(codigo_empresa) 

tipo_cuenta_libro_ventas   = f_tipo_cta_libro(ejercicio,codigo_empresa,libro_iva_ventas_nacional)

	formula_ventas = " haber - debe + imponible"


Sel = " SELECT "+formula_ventas+" importe_operaciones,clipro,tipoter,factura,ffactura " +&
      " FROM   contaapun " +&
      " WHERE  empresa   = '"+codigo_empresa+"'" +&
      " AND    ejercicio = "+string(ejercicio,"####")+&
		" AND    tipoapu  IN (SELECT codigo from contalibros "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   tipo      = 'V' ) "+&
		" AND    tipoiva in (SELECT tipoiva from contaiva "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   incluir_en_modelo_347 = 'S' ) "+&		
		" AND    fapunte between '"+STring(Date(fecha_desde),gs_formato_fecha_cursores )+"' "+&
		 						 " and '"+STring(Date(fecha_hasta),gs_formato_fecha_cursores )+"' "+&
		" AND    clipro in ( SELECT codigo from genter "+&
								  "WHERE empresa = '"+codigo_empresa+"' "+&
								  "AND   tipoter = 'C' "+&
								  "AND   pais    in (select pais from paises where tipopais = 'N') ) "+&		
		" order BY tipoter,clipro "
      		
		
clipboard(sel)		
//Quitamos todo lo que tenga retenciones " AND   cuenta like '4751%')"+& 
f_mensaje_proceso("Obteniendo datos",0,100)		

f_cargar_cursor_transaccion(sqlca,operaciones,sel)		

f_mensaje_proceso("Obteniendo datos",50,100)		

total = operaciones.rowcount()


for indice = 1 to total
	f_mensaje_proceso("Procesando datos",total+indice,total*2)	
	tercero             = operaciones.object.clipro[indice]
	tipoter             = operaciones.object.tipoter[indice]
	importe_operaciones = operaciones.object.importe_operaciones[indice]
	irpf = 0

	if cliproant <> tercero then
		if totalacum >= 6000 then
			nombre_tercero = f_razon_genter(codigo_empresa,tipoter,cliproant)
			nif            = f_cif_genter(codigo_empresa,tipoter,cliproant)
			if isnull(nif) then nif = ""
			nif            = f_tratar_nif(nif,nombre_tercero)
			
			if len(nif) <> 9 then
				error_nif = "S"
			else
				error_nif = "N"
			end if
			donde = data.insertrow(0)
			
			data.object.empresa[donde]             = codigo_empresa
			data.object.nombre_tercero[donde]      = nombre_tercero
			data.object.tercero[donde]             = cliproant
			data.object.tipoter[donde]             = tipoterant
			data.object.importe_operaciones[donde] = totalacum
			data.object.nif[donde]                 = nif
			data.object.moneda[donde]              = moneda
			data.object.error_nif[donde]           = error_nif
				
				
				
		End if
		
		totalacum=0

	end if
	factura  = operaciones.object.factura[indice]
	ffactura = operaciones.object.ffactura[indice]
	efectivo = f_347_forpag(codigo_empresa, tipoter, tercero, factura, ffactura)
	
	if efectivo then	
		nombre  = f_nombre_cliente(codigo_empresa,tipoter,tercero)
		totalacum = totalacum + importe_operaciones
//		messagebox(nombre, totalacum)	
	end if
	cliproant = tercero
	tipoterant = tipoter
Next

if totalacum >= 6000 then
	nombre_tercero = f_razon_genter(codigo_empresa,tipoter,cliproant)
	nif            = f_cif_genter(codigo_empresa,tipoter,cliproant)
	if isnull(nif) then nif = ""
	nif            = f_tratar_nif(nif,nombre_tercero)
	
	if len(nif) <> 9 then
		error_nif = "S"
	else
		error_nif = "N"
	end if
	donde = data.insertrow(0)
	
	data.object.empresa[donde]             = codigo_empresa
	data.object.nombre_tercero[donde]      = nombre_tercero
	data.object.tercero[donde]             = cliproant
	data.object.tipoter[donde]             = tipoterant
	data.object.importe_operaciones[donde] = totalacum
	data.object.nif[donde]                 = nif
	data.object.moneda[donde]              = moneda
	data.object.error_nif[donde]           = error_nif
				
				
				
End if


destroy operaciones

data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

public subroutine f_grabar_sisco_old ();string  tipo_registro,modelo_declaracion,ejercicio,nif_declarante,razon_empresa,tipo_soporte
string  telefono_contacto,persona_contacto,numero_justificante,tipo_declaracion,justificante_anterior
string  numero_personas_entidades,importe_total_operaciones,numero_inmuebles,importe_total_inmuebles
string  blancos,sello_electronico,registro_declarante,lineas_defectuosas
string  nif_declarado,nif_representante,razon_declarado,tipo_hoja,codigo_provincia,codigo_pais
string  clave_codigo,importe_operaciones,operacion_seguro,arrendamiento_local,registro_declarado
string  fichero,ruta,ejer_corto,moneda_empresa,registro_presentacion_colectiva,importe_metalico,importe_metalico_dec
string  razon_social_del_presentador,nombre_via_publica,municipio,codigo_postal
string  nif_del_presentador,siglas_via_publica,numero,escalera,piso,puerta,domicilio_del_presentador,blancos2
string  total_declarantes,total_declarados,persona_con_quien_relacionarse
long    indice,total,donde,v_ejercicio,res,factor_conversion
dec     importe_total
int     decimales_moneda_empresa
long ll_found
boolean bien = true

moneda_empresa           = f_moneda_empresa(codigo_empresa) 

decimales_moneda_empresa = f_decimales_moneda(moneda_empresa)

factor_conversion = 1

for indice = 1 to decimales_moneda_empresa
	factor_conversion = factor_conversion * 10
next

dw_lineas.reset()
v_ejercicio = year(date(em_fechadesde.text))
total       = dw_detalle.rowcount()

razon_empresa       = f_tratar_razon(f_nombre_empresa(codigo_empresa))
razon_empresa       = f_relleno_cadena(razon_empresa," ","D",40)

select nombre,									domicilio,					ciudad,
		 provincia,								codpostal,					cif,
		 cl_domicilio,							nu_domicilio
into   :razon_social_del_presentador,:nombre_via_publica,  :municipio,
		 :codigo_provincia,            :codigo_postal,       :nif_del_presentador,
		 :siglas_via_publica,          :numero
from   empresas
where  empresa = :codigo_empresa;

escalera = ''
piso     = ''
puerta   = ''

//TIPO DE REGISTRO 1 : REGISTRO DECLARANTE

tipo_registro       = "1"
modelo_declaracion  = "347"
ejercicio           = string(v_ejercicio,"####")
nif_declarante      = f_tratar_nif(f_cif_empresa(codigo_empresa),f_nombre_empresa(codigo_empresa))
tipo_soporte        = "D"
telefono_contacto   = em_telefono_contacto.text
persona_contacto    = em_persona_contacto.text
persona_contacto    = f_relleno_cadena(persona_contacto," ","D",40)
numero_justificante = f_relleno_cadena("","0","I",13)

choose case ddlb_tipo_declaracion.text
	case "Normal"
		tipo_declaracion      = "  "
		justificante_anterior = f_relleno_cadena("","0","I",13)
	case "Complementaria"
		tipo_declaracion      = "C "
		justificante_anterior = f_relleno_cadena("","0","I",13)
	case "Sustitutiva"
		tipo_declaracion      = " S"
		justificante_anterior = f_relleno_cadena(em_justificante.text,"0","I",13)
end choose

numero_personas_entidades = string(total,"########")
numero_personas_entidades = f_relleno_cadena(numero_personas_entidades,"0","I",9)

for indice = 1 to total
	importe_total = importe_total + dw_detalle.object.importe_operaciones[indice]
next
importe_total_operaciones = string(importe_total * factor_conversion,"##############")
importe_total_operaciones = f_relleno_cadena(importe_total_operaciones,"0","I",15)

numero_inmuebles          = f_relleno_cadena("","0","I",9)
importe_total_inmuebles   = f_relleno_cadena("","0","I",15)
blancos                   = f_relleno_cadena(""," ","D",207)
nif_representante   		  = f_relleno_cadena(""," ","D",9)
blancos2                  = f_relleno_cadena(""," ","D",88)
sello_electronico         = f_relleno_cadena(""," ","D",13)

registro_declarante = tipo_registro             +&
							 modelo_declaracion        +&
							 ejercicio                 +&
							 nif_declarante            +&
							 razon_empresa             +&
							 tipo_soporte              +&
							 telefono_contacto         +&
							 persona_contacto          +&
							 numero_justificante       +&
							 tipo_declaracion          +&
							 justificante_anterior     +&
							 numero_personas_entidades +&
							 importe_total_operaciones +&
							 numero_inmuebles          +&
							 importe_total_inmuebles   +&
							 blancos                   +&
							 nif_representante			+&
							 blancos2						+&
							 sello_electronico

donde = dw_lineas.insertrow(0)							

dw_lineas.object.linea[donde] = registro_declarante

if len(registro_declarante) <> 500 then
	bien = false
	lineas_defectuosas = string(donde,"####")+"("+string(len(registro_declarante),"###")+")"
end if

for indice = 1 to total
	f_mensaje_proceso("Procesando :",indice,total)
	// TIPO DE REGISTRO 2 : REGISTRO DE DECLARADO
	
	tipo_registro       = "2"
	modelo_declaracion  = "347"
	ejercicio           = string(v_ejercicio,"####")	
	nif_declarado       = dw_detalle.object.nif[indice]
	nif_representante   = f_relleno_cadena(""," ","D",9)
	razon_declarado     = f_tratar_razon(dw_detalle.object.nombre_tercero[indice])
	razon_declarado     = f_relleno_cadena(razon_declarado," ","D",40)
	tipo_hoja           = "D"
	codigo_provincia    = trim(f_provincia_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
	codigo_provincia    = f_relleno_cadena(codigo_provincia,"0","I",2)
	codigo_pais         = '  '//trim(f_pais_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
	codigo_pais         = f_relleno_cadena(codigo_pais," ","D",2)
	
	if dw_detalle.object.tipoter[indice] = "C" then
		clave_codigo = "B" //Entregas
	else
		clave_codigo = "A" //Adquisiciones
	end if
	
	importe_operaciones = string(dw_detalle.object.importe_operaciones[indice] * factor_conversion,"###############")
	importe_operaciones = f_relleno_cadena(importe_operaciones,"0","I",15)
	
	operacion_seguro    = " "
	arrendamiento_local = " "
	
	ll_found= 0

	ll_found = dw_efectivo.Find("tercero = '" + dw_detalle.object.tercero[indice] + "'", 1, dw_efectivo.RowCount())

	if ll_found <> 0 then
		dec operacion
		importe_metalico 		= string(dw_efectivo.object.importe_operaciones[ll_found])
		operacion				= truncate(dec(importe_metalico),2)
		importe_metalico		= string(truncate(operacion,0))
		importe_metalico_dec = string(TRUNCATE((operacion - dec(importe_metalico))*100,0))
		importe_metalico_dec = f_relleno_cadena(importe_metalico_dec,"0","I",2)
		importe_metalico  	= f_relleno_cadena(importe_metalico,"0","I",13)
	else
		importe_metalico     = '0000000000000'
		importe_metalico_dec = '00'
	end if
	blancos             = f_relleno_cadena(""," ","D",371)
	
	registro_declarado = tipo_registro       +&
								modelo_declaracion  +&
								ejercicio           +&
								nif_declarante      +&
								nif_declarado       +&
								nif_representante   +&
								razon_declarado     +&
								tipo_hoja           +&
								codigo_provincia    +&
								codigo_pais         +&
								' '					  +&
								clave_codigo        +&
								importe_operaciones +&
								operacion_seguro    +&
								arrendamiento_local +&
								importe_metalico	  +&
								importe_metalico_dec+&
								'0000000000000'	  +&
								'00'					  +&
								blancos								
	
	donde = dw_lineas.insertrow(0)							
	
	dw_lineas.object.linea[donde] = registro_declarado
	
	if len(registro_declarado) <> 500 then
		bien = false
		lineas_defectuosas = lineas_defectuosas + " " + string(donde,"####")+"("+string(len(registro_declarado),"###")+")"
	end if	
next

if not(bien) then
	if messagebox("Atención","Se han detectado errores el las lineas : "+lineas_defectuosas+"~n¿Desea grabar el fichero de todas formas?",StopSign!,YesNo!,1) = 1 then
		bien = true
	end if
end if

if bien then
	//if GetFileOpenName("Seleccione Directorio de la copia",ruta,fichero,"BMP","Texto (*.TXT),*.TXT") = 1 then
	//	sle_ruta.text = ruta
	//end if
	ejer_corto = mid(ejercicio,3,2)
	//fichero    = "OP347" + ejer_corto+ ".TXT"
	ruta       = "OP347" + ejer_corto+ ".TXT"
	if GetFileSaveName("Fichero 347",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
		if dw_lineas.rowcount() > 0 then
			res = dw_lineas.saveas(ruta,text!,false)
			if res = -1 then messagebox("ERROR","Al grabar al disquete")
			if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
		end if		
	end if	
else
	messagebox("Error","Operación cancelada")
end if


end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_efectivo.reset()
end event

event ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta 347"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_efectivo.settransobject(sqlca)

f_activar_campo(em_fechadesde)



end event

on w_con_347_gno.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_lineas=create dw_lineas
this.em_telefono_contacto=create em_telefono_contacto
this.em_persona_contacto=create em_persona_contacto
this.st_1=create st_1
this.st_2=create st_2
this.em_justificante=create em_justificante
this.ddlb_tipo_declaracion=create ddlb_tipo_declaracion
this.st_justificante=create st_justificante
this.dw_cartas=create dw_cartas
this.pb_cartas=create pb_cartas
this.st_3=create st_3
this.gb_10=create gb_10
this.pb_3=create pb_3
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.dw_efectivo=create dw_efectivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_lineas
this.Control[iCurrent+10]=this.em_telefono_contacto
this.Control[iCurrent+11]=this.em_persona_contacto
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_justificante
this.Control[iCurrent+15]=this.ddlb_tipo_declaracion
this.Control[iCurrent+16]=this.st_justificante
this.Control[iCurrent+17]=this.dw_cartas
this.Control[iCurrent+18]=this.pb_cartas
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.gb_10
this.Control[iCurrent+21]=this.pb_3
this.Control[iCurrent+22]=this.dw_listado
this.Control[iCurrent+23]=this.dw_detalle
this.Control[iCurrent+24]=this.dw_efectivo
end on

on w_con_347_gno.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_lineas)
destroy(this.em_telefono_contacto)
destroy(this.em_persona_contacto)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_justificante)
destroy(this.ddlb_tipo_declaracion)
destroy(this.st_justificante)
destroy(this.dw_cartas)
destroy(this.pb_cartas)
destroy(this.st_3)
destroy(this.gb_10)
destroy(this.pb_3)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.dw_efectivo)
end on

event ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_347_gno
integer x = 750
integer y = 2720
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_347_gno
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_347_gno
integer width = 4553
integer height = 84
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
end type

type pb_1 from upb_salir within w_con_347_gno
integer x = 4416
integer y = 160
integer width = 110
integer height = 96
integer taborder = 0
string powertiptext = "Salir"
end type

type pb_2 from upb_imprimir within w_con_347_gno
integer x = 4082
integer y = 160
integer taborder = 0
boolean originalsize = false
string powertiptext = "Imprimir"
end type

event clicked;//f_control(dw_listado)
//f_imprimir_datawindow(dw_listado)



u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = 'Modelo 347'
u_imp.isSubTitulo = "Fecha desde '"+em_fechadesde.text +"' Hasta '"+em_fechahasta.text+"'"
u_imp.ibLandscape = true
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_detalle)
end event

type em_fechadesde from u_em_campo within w_con_347_gno
integer x = 59
integer y = 160
integer width = 325
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fechahasta from u_em_campo within w_con_347_gno
integer x = 393
integer y = 160
integer width = 320
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type cb_1 from commandbutton within w_con_347_gno
integer x = 1294
integer y = 144
integer width = 215
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)
f_modf_2009(dw_efectivo)

end event

type gb_3 from groupbox within w_con_347_gno
integer x = 1275
integer y = 108
integer width = 251
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

type gb_2 from groupbox within w_con_347_gno
integer x = 768
integer y = 108
integer width = 489
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo declaración"
end type

type gb_1 from groupbox within w_con_347_gno
integer x = 37
integer y = 108
integer width = 695
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

type dw_lineas from datawindow within w_con_347_gno
boolean visible = false
integer x = 1445
integer y = 20
integer width = 626
integer height = 72
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_347_lineas_gno"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_telefono_contacto from u_em_campo within w_con_347_gno
integer x = 2066
integer y = 156
integer width = 306
integer height = 88
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "#########"
end type

type em_persona_contacto from u_em_campo within w_con_347_gno
integer x = 2875
integer y = 156
integer width = 974
integer height = 88
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_1 from statictext within w_con_347_gno
integer x = 1582
integer y = 172
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

type st_2 from statictext within w_con_347_gno
integer x = 2391
integer y = 172
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
string text = "Persona Contacto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_justificante from u_em_campo within w_con_347_gno
boolean visible = false
integer x = 1714
integer y = 168
integer width = 411
integer height = 88
integer taborder = 90
boolean bringtotop = true
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "#############"
end type

type ddlb_tipo_declaracion from dropdownlistbox within w_con_347_gno
integer x = 791
integer y = 160
integer width = 421
integer height = 344
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Normal"
boolean vscrollbar = true
string item[] = {"Normal","Complementaria","Sustitutiva"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "Sustitutiva" then
	st_justificante.visible = true
	em_justificante.visible = true
else
	st_justificante.visible = false
	em_justificante.visible = false
end if
end event

type st_justificante from statictext within w_con_347_gno
boolean visible = false
integer x = 1047
integer y = 184
integer width = 667
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
boolean enabled = false
string text = "Nº Justificante Declaración"
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_con_347_gno
boolean visible = false
integer x = 2501
integer y = 36
integer width = 101
integer height = 52
integer taborder = 40
string dataobject = "report_cartas_347_nuevo"
boolean livescroll = true
end type

type pb_cartas from upb_imprimir within w_con_347_gno
integer x = 4210
integer y = 160
integer taborder = 30
boolean originalsize = false
string powertiptext = "Cartas"
end type

event clicked;if dw_cartas.rowcount() < 1 then
	f_control(dw_cartas)
end if

f_imprimir_datawindow(dw_cartas)


end event

type st_3 from statictext within w_con_347_gno
integer x = 4192
integer y = 96
integer width = 169
integer height = 64
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
string text = "Cartas"
boolean focusrectangle = false
end type

type gb_10 from groupbox within w_con_347_gno
integer x = 1550
integer y = 108
integer width = 2345
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

type pb_3 from picturebutton within w_con_347_gno
integer x = 3963
integer y = 160
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Save!"
alignment htextalign = left!
string powertiptext = "Grabar"
end type

event clicked;
if messagebox("ATENCIÓN","La información se va a grabar en disquete~n¿Desea continuar?",question!,yesno!,1) = 1 then
	if len(em_telefono_contacto.text) = 9 then
		if len(em_persona_contacto.text) > 0 then
			f_grabar_disco()
		else
			messagebox("Atención","Debe rellenar el campo persona de contacto")	
			em_persona_contacto.setfocus()
		end if
	else
		messagebox("Atención","Debe rellenar el campo telefono de contacto")	
		em_telefono_contacto.setfocus()		
	end if
end if

end event

type dw_listado from datawindow within w_con_347_gno
boolean visible = false
integer x = 2400
integer y = 36
integer width = 1147
integer height = 64
boolean bringtotop = true
string dataobject = "report_con_347_gno"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_347_gno
integer y = 312
integer width = 4549
integer height = 1776
boolean titlebar = true
string title = "347"
string dataobject = "dw_con_347_gno"
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

type dw_efectivo from datawindow within w_con_347_gno
integer x = 14
integer y = 2120
integer width = 4539
integer height = 816
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "347 EFECTIVO"
string dataobject = "dw_con_347_gno"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

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

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

