$PBExportHeader$w_impresion_remesas_expor.srw
forward
global type w_impresion_remesas_expor from w_int_con_empresa
end type
type pb_1 from upb_salir within w_impresion_remesas_expor
end type
type em_banco from u_em_campo within w_impresion_remesas_expor
end type
type st_1 from statictext within w_impresion_remesas_expor
end type
type st_nombre_banco from statictext within w_impresion_remesas_expor
end type
type em_remesa from u_em_campo within w_impresion_remesas_expor
end type
type cb_consulta from commandbutton within w_impresion_remesas_expor
end type
type st_fecha from statictext within w_impresion_remesas_expor
end type
type em_anyorem from u_em_campo within w_impresion_remesas_expor
end type
type st_4 from statictext within w_impresion_remesas_expor
end type
type st_2 from statictext within w_impresion_remesas_expor
end type
type st_3 from statictext within w_impresion_remesas_expor
end type
type st_6 from statictext within w_impresion_remesas_expor
end type
type st_tipodoc from statictext within w_impresion_remesas_expor
end type
type pb_cartas from picturebutton within w_impresion_remesas_expor
end type
type st_7 from statictext within w_impresion_remesas_expor
end type
type pb_recibos from picturebutton within w_impresion_remesas_expor
end type
type dw_remesas from datawindow within w_impresion_remesas_expor
end type
type dw_1 from datawindow within w_impresion_remesas_expor
end type
type st_5 from statictext within w_impresion_remesas_expor
end type
type dw_cartas from datawindow within w_impresion_remesas_expor
end type
type dw_recibos from datawindow within w_impresion_remesas_expor
end type
type cbx_1 from checkbox within w_impresion_remesas_expor
end type
type st_8 from statictext within w_impresion_remesas_expor
end type
type pb_disquete from picturebutton within w_impresion_remesas_expor
end type
type dw_efectos_disq from datawindow within w_impresion_remesas_expor
end type
type dw_disquete from datawindow within w_impresion_remesas_expor
end type
type em_directorio from u_em_campo within w_impresion_remesas_expor
end type
type st_10 from statictext within w_impresion_remesas_expor
end type
type pb_disquete_n32 from picturebutton within w_impresion_remesas_expor
end type
type pb_2 from picturebutton within w_impresion_remesas_expor
end type
type st_11 from statictext within w_impresion_remesas_expor
end type
type pb_3 from picturebutton within w_impresion_remesas_expor
end type
type pb_4 from picturebutton within w_impresion_remesas_expor
end type
type cbx_consultivo from checkbox within w_impresion_remesas_expor
end type
type cbx_financiacion from checkbox within w_impresion_remesas_expor
end type
type st_12 from statictext within w_impresion_remesas_expor
end type
type pb_5 from picturebutton within w_impresion_remesas_expor
end type
type pb_6 from picturebutton within w_impresion_remesas_expor
end type
type st_13 from statictext within w_impresion_remesas_expor
end type
end forward

global type w_impresion_remesas_expor from w_int_con_empresa
integer x = 5
integer y = 48
integer width = 3488
integer height = 2304
pb_1 pb_1
em_banco em_banco
st_1 st_1
st_nombre_banco st_nombre_banco
em_remesa em_remesa
cb_consulta cb_consulta
st_fecha st_fecha
em_anyorem em_anyorem
st_4 st_4
st_2 st_2
st_3 st_3
st_6 st_6
st_tipodoc st_tipodoc
pb_cartas pb_cartas
st_7 st_7
pb_recibos pb_recibos
dw_remesas dw_remesas
dw_1 dw_1
st_5 st_5
dw_cartas dw_cartas
dw_recibos dw_recibos
cbx_1 cbx_1
st_8 st_8
pb_disquete pb_disquete
dw_efectos_disq dw_efectos_disq
dw_disquete dw_disquete
em_directorio em_directorio
st_10 st_10
pb_disquete_n32 pb_disquete_n32
pb_2 pb_2
st_11 st_11
pb_3 pb_3
pb_4 pb_4
cbx_consultivo cbx_consultivo
cbx_financiacion cbx_financiacion
st_12 st_12
pb_5 pb_5
pb_6 pb_6
st_13 st_13
end type
global w_impresion_remesas_expor w_impresion_remesas_expor

type variables
string filtro

integer var_ejercicio
string es_nacional,is_naci_extra,is_nacional

string tipo_doc
end variables

forward prototypes
public subroutine f_grabo_disquete (str_carremesas cab)
public function string f_cif (string par_cif)
public function string f_relleno_espacios (string cadena, integer v_longitud)
public subroutine f_grabo_disquete_n_32 (str_carremesas cab)
public function string f_relleno_ceros_izq (string cadena, integer v_longitud)
public subroutine f_grabo_disquete_19 (str_carremesas cab)
public subroutine f_grabo_disquete_19_sepa (str_carremesas cab)
public subroutine f_grabo_disquete_19_sepa_21122015 (str_carremesas cab)
public function string f_relleno_ceros (string cadena, integer v_longitud)
public subroutine f_grabo_disquete_19_sepa_xml (str_carremesas cab)
public subroutine f_tratar_texto (ref string arg_texto)
public subroutine core (str_carremesas cab)
public subroutine f_grabo_disquete_19_sepa_core_xml (str_carremesas cab)
public subroutine f_grabo_disquete_19_sepa_b2b_xml (str_carremesas cab)
public subroutine f_grabo_disquete_lcr ()
public subroutine f_grabo_disquete_riba ()
public subroutine f_grabo_disquete_ribalcr ()
end prototypes

public subroutine f_grabo_disquete (str_carremesas cab);Integer		oky,fila,i,numreg,numregop
String		registro,nomemp,cifemp,cposemp,entidad,oficina,digcontrol,cuenta
String		cli,nomcli,clicta,cliban,clisuc,clidig,codomic
String		poscli,provcli,domcli,locli
Dec			totimp
Boolean		con_domic = FALSE
boolean 		hay_error = false

dw_disquete.SetTransObject(SQLCA)
dw_efectos_disq.SetTransObject(SQLCA)

dw_disquete.Reset()
dw_efectos_disq.Reset()

SELECT empresas.nombre,empresas.cif,empresas.codpostal 
		INTO :nomemp,:cifemp,:cposemp FROM empresas
WHERE empresas.empresa = :codigo_empresa;

SELECT carbancos.entidad,carbancos.oficina,carbancos.control,carbancos.nuestracta
		INTO :entidad,:oficina,:digcontrol,:cuenta FROM carbancos
WHERE carbancos.empresa = :codigo_empresa
AND	carbancos.banco	= :cab.banco;


string sufijo

//if cab.banco = "9" then
//	sufijo = "501"
//else
	sufijo = "000"
//end if

// ------ REGISTRO DE CABECERA (Hay 2) ----------
// ------ Presentador ------------
SetNull(registro)

cifemp = f_cif(cifemp)
cifemp = f_relleno_espacios(cifemp,9)

IF LEN(cifemp) <> 9 then
	messagebox("Error","El cif de la empresa tiene longitud <> 9 ")
	hay_error = true
end if

//registro = "01" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "
registro = "51" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "

nomemp = f_relleno_espacios(nomemp,40)

if len(entidad) <> 4 then
	messagebox("Error","El código de la entidad del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(oficina) <> 4 then
	messagebox("Error","El código de la oficina del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(digcontrol) <> 2 then
	messagebox("Error","El dígito de control del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 2 cifras")
	hay_error = true			
end if


if len(cuenta) <> 10 then
	messagebox("Error","La cuenta del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 10 cifras")
	hay_error = true			
end if

registro = registro + nomemp + Space(20) + entidad + oficina + Space(12)

registro = registro + Space(11) + Space(43)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	messagebox("Atención","El registro cabecera de presentador no tiene longitud 162, tiene "+ string(len(registro)))
	hay_error = true
end if

dw_disquete.SetItem(fila,"lini",registro)


// -------------- Ordenante -------------

SetNull(registro)

//registro = "03" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "
registro = "53" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "

registro = registro + nomemp + entidad + oficina + digcontrol + cuenta

registro = registro + Space(8) + "06" + Space(10) + Space(40) 

registro = registro +space(2) + Space(9) +Space(3)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	messagebox("Atención","El registro cabecera de ordenante no tiene longitud 162")
	hay_error = true
end if

dw_disquete.Object.lini[fila] = registro


// Ahora vamos a por las lineas del disquete. Una por cada Efecto

oky = dw_efectos_disq.Retrieve(codigo_empresa,cab.banco,cab.anyo,cab.remesa,cab.fremesa)

IF oky = 0 THEN
	f_mensaje("ERROR","No hay Efectos para grabar en el disquete")
	RETURN
END IF

totimp = 0
numreg = 0
numregop = 0

FOR i = 1 TO oky
	SetNull(registro)
	con_domic = FALSE
	// ----------------- Registro Obligatorio ----------------------
	//registro = "06" + "70" + cifemp + sufijo
	registro = "56" + "70" + cifemp + sufijo
	registro = registro + f_relleno_espacios(dw_efectos_disq.Object.cuenta[i],12)
	
	cli = dw_efectos_disq.Object.cliente[i]
	
	SELECT genter.razon,genter.cod_postal,genter.provincia,
			genter.domicilio,genter.localidad 
			INTO :nomcli,:poscli,:provcli,:domcli,:locli FROM genter
	WHERE genter.empresa = :codigo_empresa
	AND	genter.tipoter = "C"
	AND	genter.codigo  = :cli;
	
	codomic = dw_efectos_disq.Object.domiciliacion[i]
	IF Trim(codomic) <> "" AND	Not IsNull(codomic) THEN
			SELECT cuenta,entidad,oficina,control INTO :clicta,:cliban,
							:clisuc,:clidig FROM vendomiciliacion
			WHERE vendomiciliacion.empresa = :codigo_empresa
			AND	vendomiciliacion.cliente = :cli
			AND	vendomiciliacion.codigo  = :codomic;
			IF SQLCA.SQLCode <> 0 THEN
				cliban = "0000"
				clisuc = "0000"
// Pedro no quiere que aparezcan los dos asteriscos 20-03-07. David			
//				clidig = "**" 	
				clidig = "00"
				clicta = "0000000000"
			ELSE
				con_domic = TRUE
												
			END IF
			
	ELSE
			cliban = "0000"
			clisuc = "0000"
// Pedro no quiere que aparezcan los dos asteriscos 20-03-07				
//			clidig = "**"
			clidig = "00"
			clicta = "0000000000"
	END IF
	
	registro = registro + f_relleno_espacios(nomcli,40)
	
	registro = registro + String(Dec(cliban),"0000")
	registro = registro + String(Dec(clisuc),"0000")
	IF Not con_domic OR IsNull(clidig) THEN
// Pedro no quiere que aparezcan los dos asteriscos 20-03-07				
//		registro = registro + "**"
		registro = registro + "00"
	ELSE
		registro = registro + String(Dec(clidig),"00")
	END IF
	
	registro = registro + f_relleno_espacios(clicta,10)
	
	registro = registro + String(dw_efectos_disq.Object.importe[i] * 100,"0000000000")
	
	registro = registro + Space(5)
	
	registro = registro + String(Dec(dw_efectos_disq.Object.anyo[i]),"0000") + "/" 
	registro = registro + String(Dec(dw_efectos_disq.Object.factura[i]),"000000")
	
	registro = registro + f_relleno_espacios(nomcli,40)

	registro = registro + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
	
	registro = registro + "  "

	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 162 then
		messagebox("Atención","El registro obligatorio individual "+string(fila) +" del cliente "+nomcli+" no tiene longitud 162")
		hay_error = true
	end if
	dw_disquete.Object.lini[fila] = registro

	totimp = totimp + (dw_efectos_disq.Object.importe[i] * 100)
	numreg = numreg + 1
	numregop = numregop + 1
	
	// --------------------- Registro Opcional -----------------------
	
	SetNull(registro)
	//registro = "06" + "71" + cifemp + sufijo 
	registro = "56" + "71" + cifemp + sufijo 
	
	registro = registro + f_relleno_espacios(dw_efectos_disq.Object.cuenta[i],12)
	
	registro = registro + "VTO. " + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
	registro = registro + " EUROS: " + String(Dec(dw_efectos_disq.Object.importe[i]),"0000000.00")
	registro = registro + " FRA Nr.: " + String(Dec(dw_efectos_disq.Object.factura[i]),"0000000") // + "/" + String(Dec(dw_efectos_disq.Object.recibo[i]),"00")
	registro = registro + " de Fecha " + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
	registro = registro + " Cli.: " + String(Dec(dw_efectos_disq.Object.cliente[i]),"000000")
	registro = registro + Space(59)
	
	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 162 then
		messagebox("Atención","El 1º registro opcional individual "+string(fila) +" no tiene longitud 162, tiene "+ string(len(registro)))
		hay_error = true		
	end if
	
	dw_disquete.Object.lini[fila] = registro

	numregop = numregop + 1
	// ---------- Obligatorio si no hay domiciliacion bancaria ----------
	
	SetNull(registro)
	
	IF Not con_domic THEN
		//registro = "06" + "76" + cifemp + sufijo
		registro = "56" + "76" + cifemp + sufijo
		registro = registro + f_relleno_espacios(dw_efectos_disq.Object.cuenta[i],12)
		registro = registro + f_relleno_espacios(domcli,40)
		registro = registro + f_relleno_espacios(locli,35)
		registro = registro + f_relleno_espacios(poscli,5)
		registro = registro + f_relleno_espacios(locli,38)
		registro = registro + f_relleno_espacios(provcli,2)
		registro = registro + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
		registro = registro + Space(8)
		
		fila = dw_disquete.InsertRow(0)

		
		if len(registro) <> 162 then
			messagebox("Atención","El registro obligatorio de domicilio "+string(fila) +" no tiene longitud 162")
			hay_error = true			
		end if
		
		dw_disquete.Object.lini[fila] = registro

		numregop = numregop + 1

	END IF
	
NEXT

// y por fin, el pie ------------------------------------

SetNull(registro)

//registro = "08" + "70" + cifemp + sufijo + Space(72)
registro = "58" + "70" + cifemp + sufijo + Space(72)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numregop + 2,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)

dw_disquete.Object.lini[fila] = registro

if len(registro) <> 162 then
		messagebox("Atención","El registro total cliente ordenante "+string(fila) +" no tiene longitud 162")
		hay_error = true	
end if



// ---------- Total Cliente Ordenante ---------------
SetNull(registro)

//registro = "09" + "70" + cifemp + sufijo + Space(52)
registro = "59" + "70" + cifemp + sufijo + Space(52)
registro = registro + "0001" + Space(16)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numregop + 4,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
		messagebox("Atención","El registro total general "+string(fila) +" no tiene longitud 162")
		hay_error = true	
end if

dw_disquete.Object.lini[fila] = registro

string fichero
int res 

fichero = "N58" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")

fichero = em_directorio.text + "\" + fichero

if dw_disquete.rowcount() > 0 then
	res = dw_disquete.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if hay_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

end subroutine

public function string f_cif (string par_cif);int l,i,j,tipo
char car
boolean salir
string codigo,car_control

tipo = 0

l = len(trim(par_cif))

if mid(trim(par_cif),l - 1,1) = "-" then
	//es un nif
	tipo = 1 
	car_control = mid(trim(par_cif),l,1)
	codigo =  mid(trim(par_cif),1,l - 2)
end if

if mid(trim(par_cif),2,1) = "-" then
	//es un cif
	tipo = 2
	car_control = mid(trim(par_cif),1,1)
	codigo =  mid(trim(par_cif),3,l - 2)
end if

if tipo = 0 then
	if mid(trim(par_cif),l - 1,1) <> "-"  and mid(trim(par_cif),2,1) <> "-"  then
		// no hay guiones
		if asc(mid(trim(par_cif),1,1)) < 48 or asc(mid(trim(par_cif),1,1)) > 57  then
			// es un cif
			tipo = 2
			car_control = mid(trim(par_cif),1,1)
			codigo =  mid(trim(par_cif),2,l - 1)
		end if
		if asc(mid(trim(par_cif),1,1)) >= 48 and asc(mid(trim(par_cif),1,1)) <= 57 then
			// es un nif
			tipo = 1
			car_control = mid(trim(par_cif),l,1)
			codigo =  mid(trim(par_cif),1,l - 1)
		end if
	end if	
end if

// El código ha de ser de 8 caracteres
if len(codigo) < 8 then 
	j = 8 - len(codigo)	
	for i = 1 to j
		codigo =  "0" + codigo
	next
end if

if tipo = 1 then return codigo + car_control 
if tipo = 2 then return car_control + codigo
if tipo = 0 then 
	f_mensaje("Error ","Tratando el NIF/CIF "+ par_cif )
	return "XXXXXXXXX"
end if

end function

public function string f_relleno_espacios (string cadena, integer v_longitud);int l,i,k

cadena = upper(cadena)

l = len(cadena)
k = v_longitud - l

if l >= v_longitud then
	cadena = left(cadena,v_longitud)
else
	for i = 1 to k
		cadena = cadena + " "	
	next
end if

return cadena

end function

public subroutine f_grabo_disquete_n_32 (str_carremesas cab);Integer		oky,fila,i,numreg,numregop
String		registro,nomemp,cifemp,cposemp,entidad,oficina,digcontrol,cuenta,cedente,tipod,aceptado
String		cli,nomcli,clicta,cliban,clisuc,clidig,codomic,fecha_libra
String		poscli,provcli,domcli,locli,cl_dom
Dec			totimp
Boolean		con_domic = FALSE
boolean 		hay_error = false
Date        hoy

dw_disquete.SetTransObject(SQLCA)
dw_efectos_disq.SetTransObject(SQLCA)

dw_disquete.Reset()
dw_efectos_disq.Reset()

SELECT empresas.nombre,empresas.cif,empresas.codpostal 
		INTO :nomemp,:cifemp,:cposemp FROM empresas
WHERE empresas.empresa = :codigo_empresa;

SELECT carbancos.entidad,carbancos.oficina,carbancos.control,carbancos.nuestracta
		INTO :entidad,:oficina,:digcontrol,:cuenta FROM carbancos
WHERE carbancos.empresa = :codigo_empresa
AND	carbancos.banco	= :cab.banco;

hoy = Today()

// ------ REGISTRO GENERAL DEL SOPORTE ----------

SetNull(registro)

cifemp = f_cif(cifemp)
cifemp = f_relleno_espacios(cifemp,9)

IF LEN(cifemp) <> 9 then
	messagebox("Error","El cif de la empresa tiene longitud <> 9 ")
	hay_error = true
end if

registro = "02" + "15" + "  " + String(hoy,"ddmmyy") + "0001" + space(12)

if len(entidad) <> 4 then
	messagebox("Error","El código de la entidad del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(oficina) <> 4 then
	messagebox("Error","El código de la oficina del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(digcontrol) <> 2 then
	messagebox("Error","El dígito de control del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 2 cifras")
	hay_error = true			
end if


if len(cuenta) <> 10 then
	messagebox("Error","La cuenta del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 10 cifras")
	hay_error = true			
end if

registro = registro + space(15) + space(8) + entidad + oficina + Space(6)

registro = registro + Space(61) + Space(24)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 150 then
	messagebox("Atención","El registro cabecera de presentador no tiene longitud 150, tiene "+ string(len(registro)))
	hay_error = true
end if

dw_disquete.SetItem(fila,"lini",registro)


// -------------- CABECERA DE REMESA -------------

SetNull(registro)

cedente = "005665420500367"

registro = "11" + "15" + "  " + String(hoy,"ddmmyy") + "0001" + space(12)

registro = registro + cedente + "1"

registro = registro + Space(21) + entidad + oficina + digcontrol + cuenta + entidad + oficina + digcontrol + cuenta + entidad + oficina + digcontrol + cuenta + Space(25)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 150 then
	messagebox("Atención","El registro cabecera de remesa no tiene longitud 150")
	hay_error = true
end if

dw_disquete.SetItem(fila,"lini",registro)

// Ahora vamos a por las lineas del disquete. Una por cada Efecto

oky = dw_efectos_disq.Retrieve(codigo_empresa,cab.banco,cab.anyo,cab.remesa,cab.fremesa)

IF oky = 0 THEN
	f_mensaje("ERROR","No hay Efectos para grabar en el disquete")
	RETURN
END IF

totimp = 0
numreg = 0
numregop = 0

FOR i = 1 TO oky
	con_domic = FALSE
	cli = dw_efectos_disq.Object.cliente[i]
	
	SELECT genter.razon,genter.cod_postal,genter.provincia,
			genter.domicilio,genter.localidad,genter.cl_domicilio 
			INTO :nomcli,:poscli,:provcli,:domcli,:locli,:cl_dom FROM genter
	WHERE genter.empresa = :codigo_empresa
	AND	genter.tipoter = "C"
	AND	genter.codigo  = :cli;
	
	IF isnull(cl_dom) THEN
		cl_dom = ""
	END IF
	IF isnull(poscli) THEN
		poscli = provcli+"000"
	END IF
	
	codomic = dw_efectos_disq.Object.domiciliacion[i]
	IF Trim(codomic) <> "" AND	Not IsNull(codomic) THEN
			SELECT cuenta,entidad,oficina,control INTO :clicta,:cliban,
							:clisuc,:clidig FROM vendomiciliacion
			WHERE vendomiciliacion.empresa = :codigo_empresa
			AND	vendomiciliacion.cliente = :cli
			AND	vendomiciliacion.codigo  = :codomic;
			IF SQLCA.SQLCode <> 0 THEN
				cliban = "0000"
				clisuc = "0000"
				clidig = "00"
				clicta = "0000000000"
			ELSE
				con_domic = TRUE
			END IF
	ELSE
			cliban = "0000"
			clisuc = "0000"
			clidig = "00"
			clicta = "0000000000"
	END IF
	tipod = "2"
//	CHOOSE CASE dw_efectos_disq.Object.tipodoc[i]
//		CASE "2"
//			tipod     = "1"
//		CASE "3"
//			tipod     = "3"
//		CASE else
//			tipod     = "2"
//	END CHOOSE
	aceptado = "2"
//	IF pos(dw_efectos_disq.Object.fpago[i],"D",1) <> 0 THEN
//		aceptado    = "1"
//	ELSE
//		aceptado    = "2"
//	END IF
	fecha_libra = string(dw_efectos_disq.Object.ffra[i],"ddmmyy")
	
	// ----------------- REGISTRO INDIVIDUAL (I) ----------------------
	SetNull(registro)
	
	registro = "25" + "15" + "  "
	registro = registro + f_relleno_ceros_izq(string(i,"####"),15) + String(hoy,"ddmmyy") + "0001"
	registro = registro + left(poscli,2) + space(9) + f_relleno_espacios(locli,20) + space(25)
	registro = registro + String(Dec(dw_efectos_disq.Object.importe[i]),"000000000")
	registro = registro + Space(15)
	registro = registro + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
	registro = registro + space(33)
	
	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 150 then
		messagebox("Atención","El registro individual (I)"+string(fila) +" del cliente "+nomcli+" no tiene longitud 150")
		hay_error = true
	end if

	dw_disquete.SetItem(fila,"lini",registro)

	totimp = totimp + dw_efectos_disq.Object.importe[i]
	numreg = numreg + 1
	numregop = numregop + 1
	
	// --------------------- REGISTRO INDIVIDUAL (II) -----------------------
	SetNull(registro)
		
	registro = "26" + "15" + "  " + f_relleno_ceros_izq(string(i,"####"),15) + space(2)
	registro = registro + tipod + fecha_libra + aceptado + "0" + cliban + clisuc + clidig + clicta
	registro = registro + f_relleno_espacios(nomemp,34) + f_relleno_espacios(nomcli,34) + space(20) + space(10)
	
	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 150 then
		messagebox("Atención","El Registro individual (II)"+string(fila) +" no tiene longitud 150, tiene "+ string(len(registro)))
		hay_error = true		
	end if
	
	dw_disquete.SetItem(fila,"lini",registro)
	
	numregop = numregop + 1
	
	// ---------- REGISTRO INDIVIDUAL (III) ----------
	
	SetNull(registro)
	
	registro = "27" + "15" + "  " 
	registro = registro + f_relleno_ceros_izq(string(i,"####"),15) + "  "
	registro = registro + f_relleno_espacios(cl_dom+" "+domcli,34)
	registro = registro + f_relleno_espacios(poscli,5)
	registro = registro + f_relleno_espacios(locli,20)
	registro = registro + left(poscli,2) + space(7) + space(59)
	
	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 150 then
		messagebox("Atención","El registro individual (III) "+string(fila) +" no tiene longitud 150")
		hay_error = true			
	end if
	
	dw_disquete.SetItem(fila,"lini",registro)

	numregop = numregop + 1
	
NEXT

// --- REGISTRO FIN DE REMESA ---

SetNull(registro)

registro = "71" + "15" + "  " + String(hoy,"ddmmyy") + "0001" + space(12) + space(37) + space(10)
registro = registro + String(totimp,"0000000000") + Space(10) + Space(36)
registro = registro + String(numregop + 2,"0000000")
registro = registro + String(numreg,"000000")
registro = registro + Space(6)

fila = dw_disquete.InsertRow(0)

dw_disquete.SetItem(fila,"lini",registro)

if len(registro) <> 150 then
		messagebox("Atención","El registro fin de remesa "+string(fila) +" no tiene longitud 150")
		hay_error = true	
end if

// --- REGISTRO FIN DE CINTA ---

SetNull(registro)

registro = "98" + "15" + Space(71)
registro = registro + String(totimp,"0000000000") + Space(41) + "00001"
registro = registro + String(numregop + 4,"0000000")
registro = registro + String(numreg,"000000")
registro = registro + Space(6)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 150 then
		messagebox("Atención","El registro fin de cinta "+string(fila) +" no tiene longitud 150")
		hay_error = true	
end if

dw_disquete.SetItem(fila,"lini",registro)

string fichero
int res 

fichero = "N32" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")

fichero = em_directorio.text + "\" + fichero

if dw_disquete.rowcount() > 0 then
	res = dw_disquete.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if hay_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

end subroutine

public function string f_relleno_ceros_izq (string cadena, integer v_longitud);int l,i,k

cadena = upper(trim(cadena))
l = len(cadena)
k = v_longitud - l

if l >= v_longitud then
	cadena = left(cadena,v_longitud)
else
	for i = 1 to k
		cadena = "0" + cadena
	next
end if

return cadena

end function

public subroutine f_grabo_disquete_19 (str_carremesas cab);Integer		oky,fila,i,numreg,numregop
String		registro,nomemp,cifemp,cposemp,entidad,oficina,digcontrol,cuenta
String		cli,nomcli,clicta,cliban,clisuc,clidig,codomic
String		poscli,provcli,domcli,locli
Dec			totimp
Boolean		con_domic = FALSE
boolean 		hay_error = false

dw_disquete.SetTransObject(SQLCA)
dw_efectos_disq.SetTransObject(SQLCA)

dw_disquete.Reset()
dw_efectos_disq.Reset()

SELECT empresas.nombre,	
		 empresas.cif,	
		 empresas.codpostal 
INTO   :nomemp,
		 :cifemp,
		 :cposemp 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

cifemp = f_cif(cifemp)
cifemp = f_relleno_espacios(cifemp,9)

string sufijo

SELECT carbancos.entidad,				carbancos.oficina,
		 carbancos.control,				carbancos.nuestracta,
		 carbancos.sufijo_n19
INTO 	 :entidad,							:oficina,
		 :digcontrol,						:cuenta,
		 :sufijo
FROM  carbancos
WHERE carbancos.empresa = :codigo_empresa
AND	carbancos.banco	= :cab.banco;


if isnull(sufijo) or trim(sufijo) = "" then	
	sufijo = "000"
end if


// ------ REGISTRO DE CABECERA (Hay 2) ----------
// ------ Presentador ------------
SetNull(registro)


// MODIFICACIONES PARA EL EURO
// LOS REGISTROS COMIENZAN POR 5
// LOS IMPORTES * 100
STRING ini = "5"
dec{2} importe



IF LEN(cifemp) <> 9 then
	messagebox("Error","El cif de la empresa tiene longitud <> 9 ")
	hay_error = true
end if

registro = ini + "1" + "80" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "

nomemp = f_relleno_espa(nomemp,40)

if len(entidad) <> 4 then
	messagebox("Error","El código de la entidad del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(entidad) <> 4 then
	messagebox("Error","El código de la oficina del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 4 cifras")
	hay_error = true			
end if


if len(digcontrol) <> 2 then
	messagebox("Error","El dígito de control del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 2 cifras")
	hay_error = true			
end if


if len(cuenta) <> 10 then
	messagebox("Error","La cuenta del banco " + &
				f_nombre_banco(codigo_empresa,cab.banco) + " ha de tener 10 cifras")
	hay_error = true			
end if

registro = registro + nomemp + Space(20) + entidad + oficina + Space(12)

registro = registro + Space(11) + Space(43)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	messagebox("Atención","El registro cabecera de presentador no tiene longitud 162, tiene "+ string(len(registro)))
	hay_error = true
end if

dw_disquete.SetItem(fila,"lini",registro)


// -------------- Ordenante -------------

SetNull(registro)

registro = ini + "3" + "80" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + String(cab.fremesa,"ddmmyy")



registro = registro + nomemp + entidad + oficina + digcontrol + cuenta

registro = registro + Space(8) + "01" + Space(10) + Space(40) 

registro = registro +space(2) + Space(9) +Space(3)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	messagebox("Atención","El registro cabecera de ordenante no tiene longitud 162")
	hay_error = true
end if

dw_disquete.Object.lini[fila] = registro


// Ahora vamos a por las lineas del disquete. Una por cada Efecto

oky = dw_efectos_disq.Retrieve(codigo_empresa,cab.banco,cab.anyo,cab.remesa,cab.fremesa)

IF oky = 0 THEN
	f_mensaje("ERROR","No hay Efectos para grabar en el disquete")
	RETURN
END IF

totimp = 0
numreg = 0
numregop = 0

FOR i = 1 TO oky
	SetNull(registro)
	con_domic = FALSE
	// ----------------- Registro Obligatorio ----------------------
	registro = ini + "6" + "80" + cifemp + sufijo
	registro = registro + f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)
	
	cli = dw_efectos_disq.Object.cliente[i]
	
	SELECT genter.razon,			genter.cod_postal,
			 genter.provincia,   genter.domicilio,
			 genter.localidad 
	INTO   :nomcli,				:poscli,		
			 :provcli,				:domcli,
			 :locli 
	FROM   genter
	WHERE  genter.empresa = :codigo_empresa
	AND	 genter.tipoter = "C"
	AND	 genter.codigo  = :cli;
	
	codomic = dw_efectos_disq.Object.domiciliacion[i]
	IF Trim(codomic) <> "" AND	Not IsNull(codomic) THEN
			SELECT cuenta,			entidad,
					 oficina,		control
			INTO 	 :clicta,		:cliban,
					 :clisuc,		:clidig 
		   FROM 	 vendomiciliacion
			WHERE  vendomiciliacion.empresa = :codigo_empresa
			AND	 vendomiciliacion.cliente = :cli
			AND	 vendomiciliacion.codigo  = :codomic;
			
			IF SQLCA.SQLCode <> 0 THEN
				cliban = "0000"
				clisuc = "0000"
				clidig = "**"
				clicta = "0000000000"
			ELSE
				con_domic = TRUE												
			END IF
			
	ELSE
			cliban = "0000"
			clisuc = "0000"
			clidig = "**"
			clicta = "0000000000"
	END IF
	
	registro = registro + f_relleno_espa(nomcli,40)
	
	registro = registro + String(Dec(cliban),"0000")
	registro = registro + String(Dec(clisuc),"0000")
	IF Not con_domic OR IsNull(clidig) THEN
		registro = registro + "**"
	ELSE
		registro = registro + String(Dec(clidig),"00")
	END IF
	
	registro = registro + f_relleno_espa(clicta,10)
	
	importe  = dw_efectos_disq.Object.importe[i] * 100 // importe * 100
	registro = registro + String(importe,"0000000000")
	
	registro = registro + Space(16)
	
	registro = registro + String(Dec(dw_efectos_disq.Object.anyo[i]),"0000") + "/" 
	registro = registro + String(Dec(dw_efectos_disq.Object.factura[i]),"000000")
	
	registro = registro + " "+String(dw_efectos_disq.Object.ffra[i],"ddmmyy")+space(22)

	registro = registro + space(8)

	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 162 then
		messagebox("Atención","El registro obligatorio individual "+string(fila) +" no tiene longitud 162")
		hay_error = true
	end if
	dw_disquete.Object.lini[fila] = registro

	totimp = totimp + importe // acumulamos (ya  * 100)
	numreg = numreg + 1

NEXT

// y por fin, el pie ------------------------------------

SetNull(registro)

registro = ini + "8" + "80" + cifemp + sufijo + Space(72)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numreg + 2,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)

dw_disquete.Object.lini[fila] = registro

if len(registro) <> 162 then
		messagebox("Atención","El registro total cliente ordenante "+string(fila) +" no tiene longitud 162")
		hay_error = true	
end if



// ---------- Total Cliente Ordenante ---------------
SetNull(registro)

registro = ini + "9" + "80" + cifemp + sufijo + Space(52)
registro = registro + "0001" + Space(16)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numreg + 4,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
		messagebox("Atención","El registro total general "+string(fila) +" no tiene longitud 162")
		hay_error = true	
end if

dw_disquete.Object.lini[fila] = registro


string ruta,fichero
int res 

//fichero = "N190" + string(em_banco.text) + string(integer(cab.remesa),"0000") 

if not hay_error then
	
	ruta = em_directorio.text+"N190" + string(em_banco.text) + string(integer(cab.remesa),"0000") 
	messagebox ("", ruta)
	//fichero = "" //em_directorio.text+"\"+"N190" + string(em_banco.text) + string(integer(cab.remesa),"0000") 
	//ruta       = "N190" + string(em_banco.text) + string(integer(cab.remesa),"0000") 
	//if GetFileSaveName("Fichero N48",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
		if dw_disquete.rowcount() > 0 then
			res = dw_disquete.saveas(ruta,text!,false)
			if res = -1 then messagebox("ERROR","Al grabar el fichero")
			if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + ruta )
		end if		
	//end if	
else
	messagebox("Error","Operación cancelada,fichero con errores")
end if

end subroutine

public subroutine f_grabo_disquete_19_sepa (str_carremesas cab);//------------------------------------------------------------------------------------------------------------------------------
//INFORMACIÓN GENERAL

//La longitud de los registros del fichero es de 600 caracteres

//El fichero, dentro de cada bloque de acreedor, deberá estar clasificado, en orden ascendente, por
	//-Código de registro
	//-Referencia del adeudo
	//-Número de dato
	
	
//Los campos numéricos irán ajustados a la derecha y completados con ceros a la izquierda, cuando sea necesario.
//Los campos alfanuméricos irán ajustados a la izquierda y completados con espacios en blanco a la derecha cuando sea necesario.
//-------------------------------------------------------------------------------------------------------------------------------

String linea, iban_presentador, nombre_presentador, nombre_fichero,ls_cliente,ls_domiciliacion
string ls_identificador_acreedor,ls_cif_empresa,ls_pais_empresa,concepto
datetime ldt_fecha_cobro_anterior,ldt_fecha_cobro
boolean b_error
long pos,ll_numero_adeudos_fecha_vto,ll_total_registros = 0
dec  ld_importe_adeudos_fecha_vto
integer i

datastore ds_core_b2b


SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

ds_core_b2b = f_cargar_cursor('select space(600) as linea from empresas where 0 = 1')

linea = ''

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de cabecera de presentador
	//Código REgistro: 01
	//Nº Dato: 001
//-------------------------------------------------------------------------------------------------------------------------------
String hoy, idFichero, hora, oficina_receptora, idRemesa
time ahora


ds_core_b2b.SetTransObject(SQLCA)
ds_core_b2b.Reset()


linea = linea + '01' 																												//Código de registro
linea = linea + '19143'																												//Versión del cuaderno
linea = linea + '001'																												//Número de dato
iban_presentador = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
ls_identificador_acreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)

linea = linea + ls_identificador_acreedor		
if len(ls_identificador_acreedor) > 35 then
	messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
	b_error = true
else
	if len(ls_identificador_acreedor) < 35 then
		linea = linea + Space( 35 - len(ls_identificador_acreedor))
	end if
end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño
nombre_presentador = f_nombre_empresa(codigo_empresa)
if len(nombre_presentador) > 70 then
	messagebox("Error", "Nombre del presentador: Longitud no puede ser > 70 " + nombre_presentador)
	b_error = true
else
	if len(nombre_presentador) < 70 then
		linea = linea + Space( 70 - len(nombre_presentador))
	end if
end if
linea = linea + nombre_presentador 																								//Nombre del presentador


hoy = String(YEAR(today())) + f_relleno_ceros(String(MONTH(today())),2) + f_relleno_ceros(String(DAY(today())),2)
linea = linea + hoy																													//Fecha de creación del fichero AAAAMMDD


hora = String(now(), "HHMMSSfffff")
idRemesa = em_remesa.text
idFichero = "PRE" + hoy + hora + f_relleno_ceros(idRemesa, 13)

linea = linea + idFichero 																											//Identificación del fichero
linea = linea + mid(iban_presentador, 5, 4)	//4 primeros digitos de la cuenta									//Entidad receptora
oficina_receptora = f_carbancos_oficina(codigo_empresa, em_banco.text)
linea = linea + oficina_receptora																								//Oficina receptora

linea = linea + Space(434) //Los huecos libres los rellenamos con espacios



if len(linea) <> 600 then
	messagebox("Error", "Cabecera - Longitud " + String(len(linea)) + "<> 600 ")
	b_error = true
end if

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

String fecha_cobro, IBAN, referencia_adeudo, mandato, tipo_adeudo, importe, fecha_mandato, entidad_deudor, nombre_deudor,cuenta_deudor
Dec total_importes

total_importes = 0 

//mandato = em_banco.text+em_anyorem.text+em_remesa.text //Referencia unica del mandato

//NOTA: cada efecto es un adeudo, no agrupo por fecha
//la dw debe estar ordenanada por fvto

ll_total_registros = 0

ll_numero_adeudos_fecha_vto  = 0
ld_importe_adeudos_fecha_vto = 0
	
for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	ldt_fecha_cobro  = dw_1.object.fvto[i]
	
	if i = 1 or ldt_fecha_cobro_anterior <> ldt_fecha_cobro then
		if i = 1 then
			ldt_fecha_cobro_anterior = ldt_fecha_cobro
		end if
		
		if ldt_fecha_cobro_anterior <> ldt_fecha_cobro then
			//Primero guardamos el registro de totales de la fecha de cobro anterior
			//-------------------------------------------------------------------------------------------------------------------------------
			//Registro de total acreedor n fecha n
				//Código Registro: 04
				//Nº Dato: --
			//-------------------------------------------------------------------------------------------------------------------------------
			setNull(linea)
			
			linea = "04"		
			linea = linea + ls_identificador_acreedor		
			if len(ls_identificador_acreedor) > 35 then
				messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
				b_error = true
			else
				if len(ls_identificador_acreedor) < 35 then
					linea = linea + Space( 35 - len(ls_identificador_acreedor))
				end if
			end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño		//Código de registro
			
		//	linea +=  iban_presentador																									//Identificador del acreedor
		//	if len(iban_presentador) < 35 then
		//		linea = linea + Space( 35 - len(iban_presentador))
		//	end if
						
			fecha_cobro = String(ldt_fecha_cobro_anterior, "yyyymmdd")
			
			linea += fecha_cobro																											//Fecha de cobro
			linea += f_relleno_ceros(string(ld_importe_adeudos_fecha_vto * 100,"################0"), 17)																					//Total de importes - DUDA???
							
			linea += f_relleno_ceros(string(ll_numero_adeudos_fecha_vto,"#######0"), 8) 			//Número de adeudos
							
			linea += f_relleno_ceros(string(ll_numero_adeudos_fecha_vto+2,"#########0"), 10)		//Total de registros: Adeudos + 2
		
			linea += Space(520)																											//Libre
			
			pos = ds_core_b2b.InsertRow(0) 
			
			ll_total_registros ++
			
			ds_core_b2b.Object.linea[pos] = linea
	
			ll_numero_adeudos_fecha_vto  = 0
			ld_importe_adeudos_fecha_vto = 0		
			
			//Inicializamosm las variables del grupo
			ll_numero_adeudos_fecha_vto  = 0
			ld_importe_adeudos_fecha_vto = 0			
			ldt_fecha_cobro_anterior = ldt_fecha_cobro
		end if
		//----------------------------------------------------1 ---------------------------------------------------------------------------
		//Registro de cabecera de acreedor i fecha fecha[i]
			//Código REgistro: 02
			//Nº Dato: 002
		//-------------------------------------------------------------------------------------------------------------------------------
		setNull(linea)
		
		linea = "02"																														//Código de registro
		linea = linea + '19143'																											//Versión del cuaderno
		linea = linea + '002' 																											//Número de dato
		//linea = linea + iban_presentador																								//Identificador del acreedor (AT-02)
	//	if len(iban_presentador) < 35 then
	//		linea = linea + Space( 35 - len(iban_presentador))
	//	end if
		
		linea = linea + ls_identificador_acreedor		
		if len(ls_identificador_acreedor) > 35 then
			messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
			b_error = true
		else
			if len(ls_identificador_acreedor) < 35 then
				linea = linea + Space( 35 - len(ls_identificador_acreedor))
			end if
		end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño	
		
		fecha_cobro = String(dw_1.object.fvto[i], "yyyymmdd")
		if len(fecha_cobro) > 8 then
			messagebox("Error", "Fecha de cobro operación " + String(i) + " : Identificación del acreedor - Longitud no puede ser > 8 " + fecha_cobro)
			b_error = true
		end if
		linea = linea + fecha_cobro																									//Fecha de cobro
		linea = linea + nombre_presentador																							//Nombre del acreedor
		if len(nombre_presentador) < 70 then
			linea = linea + Space( 70 - len(nombre_presentador))
		end if
		
		//Campos opcionales. Total 142 caracteres
		
		linea = linea + Space(142)
		
		IBAN = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
		linea = linea + IBAN
		if len(IBAN) > 34 then																											//Cuenta del acreedor
			messagebox("Error", "Cabecera de Acreedor - IBAN: Longitud no puede ser > 34 " + IBAN)
			b_error = true
		else
			if len(IBAN) < 34 then
				linea = linea + Space( 34 - len(IBAN))
			end if
		end if
		
		linea = linea + Space(301)
		
		if len(linea) <> 600 then
			messagebox("Error", "Cabecera de Acreedor - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
			b_error = true
		end if
		
		pos = ds_core_b2b.InsertRow(0) 
		
		ll_total_registros ++
		
		ds_core_b2b.Object.linea[pos] = linea
		
	end if
	
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registros individuales - Por cada Adeudo Directo debe existir un registro obligatorio
		//Código REgistro: 03
		//Nº Dato: 003
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	fecha_cobro = String(dw_1.object.fvto[i], "yyyymmdd")
	
	linea = "03"																														//Código de registro
	linea = linea + '19143'																											//Versión del cuaderno
	linea = linea + '003' 			
	referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") + String(Dec(dw_1.Object.factura[i]),"000000")+ String(Dec(dw_1.Object.recibo[i]),"00")
	
	linea = linea + referencia_adeudo	//VALOR???????																		//Referencia del adeudo (AT-10)
	if len(referencia_adeudo) > 35 then
		messagebox("Error", "Registro individual - Adeudo - linea " + String(i) + ": Longitud " + String(len(referencia_adeudo)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(referencia_adeudo) )
	end if
	
	mandato = ls_cliente
	
	linea = linea + mandato			//VALOR????																								//Referencia única del mandato
	if len(mandato) > 35 then
		messagebox("Error", "Registro individual - Mandato - linea " + String(i) + ": Longitud " + String(len(mandato)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(mandato) )
	end if
	
	//Tipo de adeudo
	//Código de cuatro letras que indica si el adeudo directo responde a una operación de pago único o de pagos recurrentes
	//Valores: FNAL, FRST, OOFF, RCUR
	tipo_adeudo = 'OOFF'		//OJO: modificar
	linea = linea + tipo_adeudo
	
	//Categoría de propósito - OPCIONAL
	linea = linea + Space(4)
	
	//Importe del adeudo
	total_importes += Dec(dw_1.Object.importe[i])
	importe = String(Dec(dw_1.Object.importe[i])*100,"00000000000")
	linea = linea + importe
	
	//Fecha de firma del mandato
	fecha_mandato = '20140101'					//OJO modificar
	linea = linea + fecha_mandato
	
	//Entidad del deudor - 11 chars
	entidad_deudor = f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += entidad_deudor
	if len(entidad_deudor) > 11 then
		messagebox("Error", "Registro individual - Entidad del deudor - linea " + String(i) + ": Longitud " + String(len(entidad_deudor)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 11 - len(entidad_deudor) )
	end if
	
	//Nombre del deudor - 70 chars
	nombre_deudor = f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
	linea += nombre_deudor
	if len(nombre_deudor) > 70 then
		messagebox("Error", "Registro individual - Nombre del deudor - linea " + String(i) + ": Longitud " + String(len(nombre_deudor)) + " > 70 ")
		b_error = true
	else
		linea = linea + Space( 70 - len(nombre_deudor) )
	end if
	
	//campos opcionales
	linea = linea + Space(214)

	//Identificador de la cuenta del deudor - A = IBAN
	linea += 'A'
	
	//Cuenta del deudor - 34 chars
	cuenta_deudor =  f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += cuenta_deudor
	if len(cuenta_deudor) > 34 then
		messagebox("Error", "Registro individual - Cuenta del deudor - linea " + String(i) + ": Longitud " + String(len(cuenta_deudor)) + " > 34 ")
		b_error = true
	else
		linea = linea + Space( 34 - len(cuenta_deudor) )
	end if
	
	linea = linea + Space(4)
	
	concepto = String(Dec(dw_1.Object.anyofra[i]),"0000") + String(Dec(dw_1.Object.factura[i]),"000000")+ String(Dec(dw_1.Object.recibo[i]),"00")
	linea += concepto
	if len(concepto) > 140 then
		messagebox("Error", "Registro individual - concepto - linea " + String(i) + ": Longitud " + String(len(concepto)) + " > 140 ")
		b_error = true
	else
		linea = linea + Space( 140 - len(concepto) )
	end if
		
	//campos opcionales
	linea = linea + Space(19)
	
		
	if len(linea) <> 600 then
		messagebox("Error", "Registro Individual - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
		b_error = true
	end if
	
	
	pos = ds_core_b2b.InsertRow(0) 
	
	ll_total_registros ++
	
	ds_core_b2b.Object.linea[pos] = linea
	
	ll_numero_adeudos_fecha_vto ++
	ld_importe_adeudos_fecha_vto += dw_1.Object.importe[i]
	
	if i = dw_1.RowCount() then
		//-------------------------------------------------------------------------------------------------------------------------------
		//Registro de total acreedor n fecha n
			//Código Registro: 04
			//Nº Dato: --
		//-------------------------------------------------------------------------------------------------------------------------------
		setNull(linea)
		
		linea = "04"		
		linea = linea + ls_identificador_acreedor		
		if len(ls_identificador_acreedor) > 35 then
			messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
			b_error = true
		else
			if len(ls_identificador_acreedor) < 35 then
				linea = linea + Space( 35 - len(ls_identificador_acreedor))
			end if
		end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño		//Código de registro
		
	//	linea +=  iban_presentador																									//Identificador del acreedor
	//	if len(iban_presentador) < 35 then
	//		linea = linea + Space( 35 - len(iban_presentador))
	//	end if
		
		linea += fecha_cobro																											//Fecha de cobro
		linea += f_relleno_ceros(string(ld_importe_adeudos_fecha_vto * 100,"################0"), 17)																					//Total de importes - DUDA???
						
		linea += f_relleno_ceros(string(ll_numero_adeudos_fecha_vto,"#######0"), 8) 			//Número de adeudos
						
		linea += f_relleno_ceros(string(ll_numero_adeudos_fecha_vto+2,"#########0"), 10)		//Total de registros: Adeudos + 2
	
		linea += Space(520)																											//Libre
		
		pos = ds_core_b2b.InsertRow(0) 
		
		ll_total_registros ++
		
		ds_core_b2b.Object.linea[pos] = linea

		ll_numero_adeudos_fecha_vto  = 0
		ld_importe_adeudos_fecha_vto = 0		

	end if
	
next

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de total acreedor n
		//Código REgistro: 05
		//Nº Dato: --
//-------------------------------------------------------------------------------------------------------------------------------
setNull(linea)

i = dw_1.RowCount()

linea = "05"																													//Código de registro
//linea +=  iban_presentador																									//Identificador del acreedor
//if len(iban_presentador) < 35 then
//	linea = linea + Space( 35 - len(iban_presentador))
//end if
linea = linea + ls_identificador_acreedor		
if len(ls_identificador_acreedor) > 35 then
	messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
	b_error = true
else
	if len(ls_identificador_acreedor) < 35 then
		linea = linea + Space( 35 - len(ls_identificador_acreedor))
	end if
end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño	
	
linea += String(total_importes*100,"00000000000000000")															//Total de importes

linea += f_relleno_ceros(String(i), 8)																					//Número de adeudos

linea += f_relleno_ceros(String((ll_total_registros)+1), 10)																				//Total de registros
	
//Libre

linea += Space(528)
	
pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

	

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de total acreedor n
	//Código Registro: 99
	//Nº Dato: --
//-------------------------------------------------------------------------------------------------------------------------------
setNull(linea)

linea = "99"																													//Código de registro
linea += String(total_importes*100,"00000000000000000")															//Total de importes general


linea += f_relleno_ceros(String(i), 8)																					//Número de adeudos

linea += f_relleno_ceros(String((ll_total_registros)+3), 10)																			//Total de registros

//Libre

linea += Space(563)

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

nombre_fichero = "C:\REMESAS\REM" + f_relleno_ceros(em_banco.text,3) + f_relleno_ceros(idRemesa,3)+ "_core.TXT"
//nombre_fichero = em_directorio.text + "CORE\" + nombre_fichero

ds_core_b2b.SaveAs(nombre_fichero, TEXT!, FALSE)

if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 

destroy ds_core_b2b
end subroutine

public subroutine f_grabo_disquete_19_sepa_21122015 (str_carremesas cab);//------------------------------------------------------------------------------------------------------------------------------
//INFORMACIÓN GENERAL

//La longitud de los registros del fichero es de 600 caracteres

//El fichero, dentro de cada bloque de acreedor, deberá estar clasificado, en orden ascendente, por
	//-Código de registro
	//-Referencia del adeudo
	//-Número de dato
	
	
//Los campos numéricos irán ajustados a la derecha y completados con ceros a la izquierda, cuando sea necesario.
//Los campos alfanuméricos irán ajustados a la izquierda y completados con espacios en blanco a la derecha cuando sea necesario.
//-------------------------------------------------------------------------------------------------------------------------------

String linea, iban_presentador, nombre_presentador, nombre_fichero,ls_cliente,ls_domiciliacion
string ls_identificador_acreedor,ls_cif_empresa,ls_pais_empresa,concepto
boolean b_error
long pos
integer i

datastore ds_core_b2b


SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

ds_core_b2b = f_cargar_cursor('select space(600) as linea from empresas where 0 = 1')

linea = ''

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de cabecera de presentador
	//Código REgistro: 01
	//Nº Dato: 001
//-------------------------------------------------------------------------------------------------------------------------------
String hoy, idFichero, hora, oficina_receptora, idRemesa
time ahora


ds_core_b2b.SetTransObject(SQLCA)
ds_core_b2b.Reset()


linea = linea + '01' 																												//Código de registro
linea = linea + '19143'																												//Versión del cuaderno
linea = linea + '001'																												//Número de dato
iban_presentador = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
ls_identificador_acreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)

linea = linea + ls_identificador_acreedor		
if len(ls_identificador_acreedor) > 35 then
	messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
	b_error = true
else
	if len(ls_identificador_acreedor) < 35 then
		linea = linea + Space( 35 - len(ls_identificador_acreedor))
	end if
end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño
nombre_presentador = f_nombre_empresa(codigo_empresa)
if len(nombre_presentador) > 70 then
	messagebox("Error", "Nombre del presentador: Longitud no puede ser > 70 " + nombre_presentador)
	b_error = true
else
	if len(nombre_presentador) < 70 then
		linea = linea + Space( 70 - len(nombre_presentador))
	end if
end if
linea = linea + nombre_presentador 																								//Nombre del presentador


hoy = String(YEAR(today())) + f_relleno_ceros_izq(String(MONTH(today())),2) + f_relleno_ceros_izq(String(DAY(today())),2)
linea = linea + hoy																													//Fecha de creación del fichero AAAAMMDD


hora = String(now(), "HHMMSSfffff")
idRemesa = em_remesa.text
idFichero = "PRE" + hoy + hora + f_relleno_ceros_izq(idRemesa, 13)

linea = linea + idFichero 																											//Identificación del fichero
linea = linea + mid(iban_presentador, 5, 4)	//4 primeros digitos de la cuenta									//Entidad receptora
oficina_receptora = f_carbancos_oficina(codigo_empresa, em_banco.text)
linea = linea + oficina_receptora																								//Oficina receptora

linea = linea + Space(434) //Los huecos libres los rellenamos con espacios



if len(linea) <> 600 then
	messagebox("Error", "Cabecera - Longitud " + String(len(linea)) + "<> 600 ")
	b_error = true
end if

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

String fecha_cobro, IBAN, referencia_adeudo, mandato, tipo_adeudo, importe, fecha_mandato, entidad_deudor, nombre_deudor,cuenta_deudor
Dec total_importes

total_importes = 0 

//mandato = em_banco.text+em_anyorem.text+em_remesa.text //Referencia unica del mandato

//NOTA: cada efecto es un adeudo, no agrupo por fecha

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registro de cabecera de acreedor i fecha fecha[i]
		//Código REgistro: 02
		//Nº Dato: 002
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "02"																														//Código de registro
	linea = linea + '19143'																											//Versión del cuaderno
	linea = linea + '002' 																											//Número de dato
	//linea = linea + iban_presentador																								//Identificador del acreedor (AT-02)
//	if len(iban_presentador) < 35 then
//		linea = linea + Space( 35 - len(iban_presentador))
//	end if
	
	linea = linea + ls_identificador_acreedor		
	if len(ls_identificador_acreedor) > 35 then
		messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
		b_error = true
	else
		if len(ls_identificador_acreedor) < 35 then
			linea = linea + Space( 35 - len(ls_identificador_acreedor))
		end if
	end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño	
	
	fecha_cobro = String(dw_1.object.fvto[i], "yyyymmdd")
	if len(fecha_cobro) > 8 then
		messagebox("Error", "Fecha de cobro operación " + String(i) + " : Identificación del acreedor - Longitud no puede ser > 8 " + fecha_cobro)
		b_error = true
	end if
	linea = linea + fecha_cobro																									//Fecha de cobro
	linea = linea + nombre_presentador																							//Nombre del acreedor
	if len(nombre_presentador) < 70 then
		linea = linea + Space( 70 - len(nombre_presentador))
	end if
	
	//Campos opcionales. Total 142 caracteres
	
	linea = linea + Space(142)
	
	IBAN = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
	linea = linea + IBAN
	if len(IBAN) > 34 then																											//Cuenta del acreedor
		messagebox("Error", "Cabecera de Acreedor - IBAN: Longitud no puede ser > 34 " + IBAN)
		b_error = true
	else
		if len(IBAN) < 34 then
			linea = linea + Space( 34 - len(IBAN))
		end if
	end if
	
	linea = linea + Space(301)
	
	if len(linea) <> 600 then
		messagebox("Error", "Cabecera de Acreedor - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
		b_error = true
	end if
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea
	
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registros individuales - Por cada Adeudo Directo debe existir un registro obligatorio
		//Código REgistro: 03
		//Nº Dato: 003
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "03"																														//Código de registro
	linea = linea + '19143'																											//Versión del cuaderno
	linea = linea + '003' 			
	referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") + String(Dec(dw_1.Object.factura[i]),"000000")+ String(Dec(dw_1.Object.recibo[i]),"00")
	
	linea = linea + referencia_adeudo	//VALOR???????																		//Referencia del adeudo (AT-10)
	if len(referencia_adeudo) > 35 then
		messagebox("Error", "Registro individual - Adeudo - linea " + String(i) + ": Longitud " + String(len(referencia_adeudo)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(referencia_adeudo) )
	end if
	
	mandato = ls_cliente
	
	linea = linea + mandato			//VALOR????																								//Referencia única del mandato
	if len(mandato) > 35 then
		messagebox("Error", "Registro individual - Mandato - linea " + String(i) + ": Longitud " + String(len(mandato)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(mandato) )
	end if
	
	//Tipo de adeudo
	//Código de cuatro letras que indica si el adeudo directo responde a una operación de pago único o de pagos recurrentes
	//Valores: FNAL, FRST, OOFF, RCUR
	tipo_adeudo = 'OOFF'		//OJO: modificar
	linea = linea + tipo_adeudo
	
	//Categoría de propósito - OPCIONAL
	linea = linea + Space(4)
	
	//Importe del adeudo
	total_importes += Dec(dw_1.Object.importe[i])
	importe = String(Dec(dw_1.Object.importe[i])*100,"00000000000")
	linea = linea + importe
	
	//Fecha de firma del mandato
	fecha_mandato = '19000101'					//OJO modificar
	linea = linea + fecha_mandato
	
	//Entidad del deudor - 11 chars
	entidad_deudor = f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += entidad_deudor
	if len(entidad_deudor) > 11 then
		messagebox("Error", "Registro individual - Entidad del deudor - linea " + String(i) + ": Longitud " + String(len(entidad_deudor)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 11 - len(entidad_deudor) )
	end if
	
	//Nombre del deudor - 70 chars
	nombre_deudor = f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
	linea += nombre_deudor
	if len(nombre_deudor) > 70 then
		messagebox("Error", "Registro individual - Nombre del deudor - linea " + String(i) + ": Longitud " + String(len(nombre_deudor)) + " > 70 ")
		b_error = true
	else
		linea = linea + Space( 70 - len(nombre_deudor) )
	end if
	
	//campos opcionales
	linea = linea + Space(214)

	//Identificador de la cuenta del deudor - A = IBAN
	linea += 'A'
	
	//Cuenta del deudor - 34 chars
	cuenta_deudor =  f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += cuenta_deudor
	if len(cuenta_deudor) > 34 then
		messagebox("Error", "Registro individual - Cuenta del deudor - linea " + String(i) + ": Longitud " + String(len(cuenta_deudor)) + " > 34 ")
		b_error = true
	else
		linea = linea + Space( 34 - len(cuenta_deudor) )
	end if
	
	linea = linea + Space(4)
	
	concepto = String(Dec(dw_1.Object.anyofra[i]),"0000") + String(Dec(dw_1.Object.factura[i]),"000000")+ String(Dec(dw_1.Object.recibo[i]),"00")
	linea += concepto
	if len(concepto) > 140 then
		messagebox("Error", "Registro individual - concepto - linea " + String(i) + ": Longitud " + String(len(concepto)) + " > 140 ")
		b_error = true
	else
		linea = linea + Space( 140 - len(concepto) )
	end if
		
	//campos opcionales
	linea = linea + Space(19)
	
		
	if len(linea) <> 600 then
		messagebox("Error", "Registro Individual - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
		b_error = true
	end if
	
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea
	
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registro de total acreedor n fecha n
		//Código Registro: 04
		//Nº Dato: --
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "04"		
	linea = linea + ls_identificador_acreedor		
	if len(ls_identificador_acreedor) > 35 then
		messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
		b_error = true
	else
		if len(ls_identificador_acreedor) < 35 then
			linea = linea + Space( 35 - len(ls_identificador_acreedor))
		end if
	end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño		//Código de registro
	
//	linea +=  iban_presentador																									//Identificador del acreedor
//	if len(iban_presentador) < 35 then
//		linea = linea + Space( 35 - len(iban_presentador))
//	end if
	
	linea += fecha_cobro																											//Fecha de cobro
	linea += f_relleno_ceros_izq(importe, 17)																					//Total de importes - DUDA???
	
	linea += "00000001" 																											//Número de adeudos: 1
	linea += "0000000003"																										//Total de registros: 3

	linea += Space(520)																											//Libre
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea


	
next

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de total acreedor n
		//Código REgistro: 05
		//Nº Dato: --
//-------------------------------------------------------------------------------------------------------------------------------
setNull(linea)

i = dw_1.RowCount()

linea = "05"																													//Código de registro
//linea +=  iban_presentador																									//Identificador del acreedor
//if len(iban_presentador) < 35 then
//	linea = linea + Space( 35 - len(iban_presentador))
//end if
linea = linea + ls_identificador_acreedor		
if len(ls_identificador_acreedor) > 35 then
	messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + ls_identificador_acreedor)
	b_error = true
else
	if len(ls_identificador_acreedor) < 35 then
		linea = linea + Space( 35 - len(ls_identificador_acreedor))
	end if
end if//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño	
	
linea += String(total_importes*100,"00000000000000000")															//Total de importes

linea += f_relleno_ceros_izq(String(i), 8)																					//Número de adeudos

linea += f_relleno_ceros_izq(String((i * 3)+1), 10)																				//Total de registros
	
//Libre

linea += Space(528)
	
pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

	

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de total acreedor n
	//Código Registro: 99
	//Nº Dato: --
//-------------------------------------------------------------------------------------------------------------------------------
setNull(linea)

linea = "99"																													//Código de registro
linea += String(total_importes*100,"00000000000000000")															//Total de importes general


linea += f_relleno_ceros_izq(String(i), 8)																					//Número de adeudos

linea += f_relleno_ceros_izq(String((i * 3)+3), 10)																			//Total de registros

//Libre

linea += Space(563)

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

nombre_fichero = "C:\REMESAS\REM" + f_relleno_ceros_izq(em_banco.text,3) + f_relleno_ceros_izq(idRemesa,3)+ "_core.TXT"
//nombre_fichero = em_directorio.text + "CORE\" + nombre_fichero

ds_core_b2b.SaveAs(nombre_fichero, TEXT!, FALSE)

if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 

destroy ds_core_b2b




/*
//------------------------------------------------------------------------------------------------------------------------------
//INFORMACIÓN GENERAL

//La longitud de los registros del fichero es de 600 caracteres

//El fichero, dentro de cada bloque de acreedor, deberá estar clasificado, en orden ascendente, por
	//-Código de registro
	//-Referencia del adeudo
	//-Número de dato
	
	
//Los campos numéricos irán ajustados a la derecha y completados con ceros a la izquierda, cuando sea necesario.
//Los campos alfanuméricos irán ajustados a la izquierda y completados con espacios en blanco a la derecha cuando sea necesario.
//-------------------------------------------------------------------------------------------------------------------------------

String linea, iban_presentador, nombre_presentador, nombre_fichero,ls_cliente,ls_domiciliacion
boolean b_error
long pos
integer i

datastore ds_core_b2b

f_cargar_cursor_transaccion(sqlca,ds_core_b2b,'select space(600) as linea from empresas where 0 = 1')

linea = ''

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de cabecera de presentador
	//Código REgistro: 01
	//Nº Dato: 001
//-------------------------------------------------------------------------------------------------------------------------------
String hoy, idFichero, hora, oficina_receptora, idRemesa
time ahora


ds_core_b2b.SetTransObject(SQLCA)
ds_core_b2b.Reset()


linea = linea + '01' 																												//Código de registro
linea = linea + '19143'																												//Versión del cuaderno
linea = linea + '001'																												//Número de dato
iban_presentador = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
if len(iban_presentador) > 35 then
	messagebox("Error", "Identificación del presentador: Longitud no puede ser > 35 " + iban_presentador)
	b_error = true
else
	if len(iban_presentador) < 35 then
		linea = linea + Space( 35 - len(iban_presentador))
	end if
end if

linea = linea + iban_presentador																									//Identificador del presentador: 35 caracteres, acompletar con espacios si no llega al tamaño
nombre_presentador = f_nombre_empresa(codigo_empresa)
if len(nombre_presentador) > 70 then
	messagebox("Error", "Nombre del presentador: Longitud no puede ser > 70 " + nombre_presentador)
	b_error = true
else
	if len(nombre_presentador) < 70 then
		linea = linea + Space( 70 - len(nombre_presentador))
	end if
end if
linea = linea + nombre_presentador 																								//Nombre del presentador


hoy = String(YEAR(today())) + f_relleno_ceros_izq(String(MONTH(today())),2) + f_relleno_ceros_izq(String(DAY(today())),2)
linea = linea + hoy																													//Fecha de creación del fichero AAAAMMDD


hora = String(now(), "HHMMSSfffff")
idRemesa = em_remesa.text
idFichero = "PRE" + hoy + hora + f_relleno_ceros_izq(idRemesa, 13)

linea = linea + idFichero 																											//Identificación del fichero
linea = linea + mid(iban_presentador, 5, 4)	//4 primeros digitos de la cuenta									//Entidad receptora
oficina_receptora = f_carbancos_oficina(codigo_empresa, em_banco.text)
linea = linea + oficina_receptora																								//Oficina receptora

linea = linea + Space(434) //Los huecos libres los rellenamos con espacios



if len(linea) <> 600 then
	messagebox("Error", "Cabecera - Longitud " + String(len(linea)) + "<> 600 ")
	b_error = true
end if

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

String fecha_cobro, IBAN, referencia_adeudo, mandato, tipo_adeudo, importe, fecha_mandato, entidad_deudor, nombre_deudor,cuenta_deudor
Dec total_importes

total_importes = 0 

//NOTA: cada efecto es un adeudo, no agrupo por fecha

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registro de cabecera de acreedor i fecha fecha[i]
		//Código REgistro: 02
		//Nº Dato: 002
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "02"																														//Código de registro
	linea = linea + '19143'																											//Versión del cuaderno
	linea = linea + '002' 																											//Número de dato
	linea = linea + iban_presentador																								//Identificador del acreedor (AT-02)
	if len(iban_presentador) < 35 then
		linea = linea + Space( 35 - len(iban_presentador))
	end if
	fecha_cobro = String(dw_1.object.fvto[i], "yyyymmdd")
	if len(fecha_cobro) > 8 then
		messagebox("Error", "Fecha de cobro operación " + String(i) + " : Identificación del acreedor - Longitud no puede ser > 8 " + fecha_cobro)
		b_error = true
	end if
	linea = linea + fecha_cobro																									//Fecha de cobro
	linea = linea + nombre_presentador																							//Nombre del acreedor
	if len(nombre_presentador) < 70 then
		linea = linea + Space( 70 - len(nombre_presentador))
	end if
	
	//Campos opcionales. Total 142 caracteres
	
	linea = linea + Space(142)
	
	IBAN = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
	linea = linea + IBAN
	if len(IBAN) > 34 then																											//Cuenta del acreedor
		messagebox("Error", "Cabecera de Acreedor - IBAN: Longitud no puede ser > 34 " + IBAN)
		b_error = true
	else
		if len(IBAN) < 34 then
			linea = linea + Space( 34 - len(IBAN))
		end if
	end if
	
	linea = linea + Space(301)
	
	if len(linea) <> 600 then
		messagebox("Error", "Cabecera de Acreedor - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
		b_error = true
	end if
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea
	
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registros individuales - Por cada Adeudo Directo debe existir un registro obligatorio
		//Código REgistro: 03
		//Nº Dato: 003
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "03"																														//Código de registro
	linea = linea + '19143'																											//Versión del cuaderno
	linea = linea + '003' 			
	referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") + "/" + String(Dec(dw_1.Object.factura[i]),"000000")+ "/" + String(Dec(dw_1.Object.recibo[i]),"00")
	
	linea = linea + referencia_adeudo	//VALOR???????																		//Referencia del adeudo (AT-10)
	if len(referencia_adeudo) > 35 then
		messagebox("Error", "Registro individual - Adeudo - linea " + String(i) + ": Longitud " + String(len(referencia_adeudo)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(referencia_adeudo) )
	end if
	
	linea = linea + mandato			//VALOR????																								//Referencia única del mandato
	if len(mandato) > 35 then
		messagebox("Error", "Registro individual - Mandato - linea " + String(i) + ": Longitud " + String(len(mandato)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 35 - len(mandato) )
	end if
	
	//Tipo de adeudo
	//Código de cuatro letras que indica si el adeudo directo responde a una operación de pago único o de pagos recurrentes
	//Valores: FNAL, FRST, OOFF, RCUR
	tipo_adeudo = 'OOFF'		//OJO: modificar
	linea = linea + tipo_adeudo
	
	//Categoría de propósito - OPCIONAL
	linea = linea + Space(4)
	
	//Importe del adeudo
	total_importes += Dec(dw_1.Object.importe[i])
	importe = String(Dec(dw_1.Object.importe[i])*100,"00000000000")
	linea = linea + importe
	
	//Fecha de firma del mandato
	fecha_mandato = '19000101'					//OJO modificar
	linea = linea + fecha_mandato
	
	//Entidad del deudor - 11 chars
	entidad_deudor = f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += entidad_deudor
	if len(entidad_deudor) > 11 then
		messagebox("Error", "Registro individual - Entidad del deudor - linea " + String(i) + ": Longitud " + String(len(entidad_deudor)) + " > 35 ")
		b_error = true
	else
		linea = linea + Space( 11 - len(entidad_deudor) )
	end if
	
	//Nombre del deudor - 70 chars
	nombre_deudor = f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
	linea += nombre_deudor
	if len(nombre_deudor) > 70 then
		messagebox("Error", "Registro individual - Nombre del deudor - linea " + String(i) + ": Longitud " + String(len(nombre_deudor)) + " > 70 ")
		b_error = true
	else
		linea = linea + Space( 70 - len(nombre_deudor) )
	end if
	
	//campos opcionales
	linea = linea + Space(214)

	//Identificador de la cuenta del deudor - A = IBAN
	linea += 'A'
	
	//Cuenta del deudor - 34 chars
	cuenta_deudor =  f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
	linea += cuenta_deudor
	if len(cuenta_deudor) > 34 then
		messagebox("Error", "Registro individual - Cuenta del deudor - linea " + String(i) + ": Longitud " + String(len(cuenta_deudor)) + " > 34 ")
		b_error = true
	else
		linea = linea + Space( 34 - len(cuenta_deudor) )
	end if
	
	//campos opcionales
	linea = linea + Space(163)
	
		
	if len(linea) <> 600 then
		messagebox("Error", "Registro Individual - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 600 ")
		b_error = true
	end if
	
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea
	
	//-------------------------------------------------------------------------------------------------------------------------------
	//Registro de total acreedor n fecha n
		//Código Registro: 04
		//Nº Dato: --
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "04"																													//Código de registro
	linea +=  iban_presentador																									//Identificador del acreedor
	if len(iban_presentador) < 35 then
		linea = linea + Space( 35 - len(iban_presentador))
	end if
	
	linea += fecha_cobro																											//Fecha de cobro
	linea += f_relleno_ceros_izq(importe, 17)																					//Total de importes - DUDA???
	
	linea += "00000001" 																											//Número de adeudos: 1
	linea += "0000000003"																										//Total de registros: 3

	linea += Space(520)																											//Libre
	
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea


	//-------------------------------------------------------------------------------------------------------------------------------
	//Registro de total acreedor n
			//Código REgistro: 05
			//Nº Dato: --
	//-------------------------------------------------------------------------------------------------------------------------------
	setNull(linea)
	
	linea = "05"																													//Código de registro
	linea +=  iban_presentador																									//Identificador del acreedor
	if len(iban_presentador) < 35 then
		linea = linea + Space( 35 - len(iban_presentador))
	end if
		
	linea += String(total_importes*100,"00000000000000000")															//Total de importes
	
	linea += f_relleno_ceros_izq(String(i), 8)																					//Número de adeudos
	
	linea += f_relleno_ceros_izq(String((i * 3)+1), 10)																			//Total de registros
		
	//Libre
	
	linea += Space(528)
		
	pos = ds_core_b2b.InsertRow(0) 
	ds_core_b2b.Object.linea[pos] = linea
	
next


	

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de total acreedor n
	//Código Registro: 99
	//Nº Dato: --
//-------------------------------------------------------------------------------------------------------------------------------
setNull(linea)

linea = "99"																													//Código de registro
linea += String(total_importes*100,"00000000000000000")															//Total de importes general


linea += f_relleno_ceros_izq(String(i), 8)																					//Número de adeudos

linea += f_relleno_ceros_izq(String((i * 3)+3), 10)																			//Total de registros

//Libre

linea += Space(563)

pos = ds_core_b2b.InsertRow(0) 
ds_core_b2b.Object.linea[pos] = linea

nombre_fichero = "REM" + f_relleno_ceros_izq(em_banco.text,3) + f_relleno_ceros_izq(idRemesa,3)+ "_core.TXT"
//nombre_fichero = em_directorio.text + "CORE\" + nombre_fichero

ds_core_b2b.SaveAs(nombre_fichero, TEXT!, FALSE)

if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 

destroy ds_core_b2b
*/
end subroutine

public function string f_relleno_ceros (string cadena, integer v_longitud);int l,i,k

cadena = upper(trim(cadena))
l = len(cadena)
k = v_longitud - l

if l >= v_longitud then
	cadena = left(cadena,v_longitud)
else
	for i = 1 to k
		cadena = "0" + cadena
	next
end if

return cadena

end function

public subroutine f_grabo_disquete_19_sepa_xml (str_carremesas cab);//---------------------------------------------------------------------------------------------------------------------
//ADEUDOS DIRECTOS SEPA:
//---------------------------------------------------------------------------------------------------------------------

String lineaXML, linea, ls_cliente, ls_domiciliacion , v_mandato, idAcreedor, moneda,ls_cif_empresa,ls_pais_empresa
long pos
boolean b_error,lb_carefectos_es_frst
string sufijo,referencia_adeudo,nombre_fichero,ls_sufijo_mensajeid,ls_iban_correcto
datetime ldt_fecha_cobro,ldt_fecha_alta
datastore dw_core_b2b

f_cargar_cursor_transaccion(sqlca,dw_core_b2b,'select space(500) as linea from empresas where 0 = 1')

dw_core_b2b.SetTransObject(SQLCA) 
dw_core_b2b.Reset()

ldt_fecha_alta = datetime(today(),now())

ls_sufijo_mensajeid = ""
ls_sufijo_mensajeid += string(year(date(ldt_fecha_alta)),"0000")
ls_sufijo_mensajeid += string(month(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(day(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(hour(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(minute(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(second(time(ldt_fecha_alta)),"00")	

/*
seleccionamos Los datos de la empresa
*/

SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

//Raíz
//---------------------------------------------------------------------------------------------------------------------
// xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'

SetNull(lineaXML) 
lineaXML = "<?xml version='1.0' encoding='utf-8'?>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Cabecera
//---------------------------------------------------------------------------------------------------------------------

SetNull(lineaXML) 
lineaXML = "<GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

				//Identificación del mensaje
				//Referencia asignada por la parte iniciadora y enviada a la siguiente parte de la cadena para identificar el mensaje de forma inequívoca
				//Identificador del acreedor en la entidad bancaria a la que se remite:

						//ES (código país) + 13 (dígitos control) + sufijo + NIF


						//Cada entidad bancaria tiene un sufijo diferente para el mismo cliente,
						//por lo que reemplazamos el sufijo de la consulta por el que le toca según el banco
					
				SetNull(lineaXML) 
				idAcreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)
				linea = idAcreedor+ls_sufijo_mensajeid
				//Si la remesa es al descuento se añade el prefijo FSDD al identificador del mensaje
				if cab.tiporem = '1' then
					linea = 'FSDD'+linea
				end if
				lineaXML = "<MsgId>" + linea + "</MsgId>" 											
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if ( len( linea ) < 1 or len( linea ) > 35 ) then
						messagebox('Error', "Identificación del mensaje: Longitud debe estar entre 1 y  35 " + linea)
						b_error = true
				end if
				
				
				
				SetNull(lineaXML) 
				linea = string(today(),'yyyy-mm-dd')+'T'+string(now(),'hh:mm:ss') //f_obtener_iso_datetime(datetime(today(),now()))
				lineaXML = "<CreDtTm>" + linea +  "</CreDtTm>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 19 ) then
						messagebox('Error', "Fecha y hora de creación: Longitud no puede ser > 19 " + linea)
						b_error = true
				end if
				
				
				SetNull(lineaXML) 
				integer numOperaciones
				numOperaciones = dw_1.RowCount()
				linea = String(numOperaciones)
				lineaXML = "<NbOfTxs>" + linea +  "</NbOfTxs>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Número de operaciones: Longitud no puede ser > 15")
						b_error = true
				end if
						
				SetNull(lineaXML) 
				dec ctrlsum
				ctrlsum = dec(dw_1.describe('evaluate("sum(importe for all)",1)'))
				linea = f_sustituir(String(ctrlsum,'#########0.00'),',','.')
				lineaXML = "<CtrlSum>" + linea +  "</CtrlSum>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Control Sum: Longitud no puede ser > 15")
						b_error = true
				end if						
						
				SetNull(lineaXML) 	
				lineaXML = "<InitgPty>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
								
								SetNull(lineaXML) 
								linea = f_nombre_empresa(codigo_empresa)
								f_tratar_texto(linea)
								lineaXML = "<Nm>" + linea + "</Nm>"									
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								if (len( linea ) > 70 ) then
									messagebox('Error', "Nombre de la Parte Iniciadora: Longitud no puede ser > 70")
									b_error = true
								end if
								
								
								SetNull(lineaXML) 	
								lineaXML = "<Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
											
											SetNull(lineaXML) 	
											lineaXML = "<OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 

												SetNull(lineaXML) 	
												lineaXML = "<Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 
														
														
														SetNull(lineaXML) 	
														linea =  idAcreedor //ls_cif_empresa
														lineaXML = "<Id>" + linea + "</Id>"//"<BICOrBEI>" + linea + "</BICOrBEI>"										
														pos = dw_core_b2b.InsertRow(0) 
														dw_core_b2b.Object.linea[pos] = lineaXML 
														if (len( linea ) > 35 ) then
															//messagebox('Error', "BIC o BEI de la parte identificadora: Longitud no puede ser > 11")
															messagebox('Error', "Id de la parte identificadora: Longitud no puede ser > 35")
															b_error = true
														end if
														
												SetNull(lineaXML) 	
												lineaXML = "</Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 														
																									
											SetNull(lineaXML)
											SetNull(linea) 
											lineaXML = "</OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 
											
											// Persona Física
											
//											f_obtener_persona_fisica()
								
								
								
								SetNull(lineaXML) 	
								lineaXML = "</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				
				SetNull(lineaXML) 	
				lineaXML = "</InitgPty>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				


SetNull(lineaXML) 
lineaXML = "</GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Fin-Cabecera
//---------------------------------------------------------------------------------------------------------------------

//*********************************************************************************************************************
//Información del pago
//---------------------------------------------------------------------------------------------------------------------
//*********************************************************************************************************************

//Para cada pago repetir

int i

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	ldt_fecha_cobro  = dw_1.object.fvto[i]
	
	lb_carefectos_es_frst = f_carefectos_es_frst(codigo_empresa,dw_1.object.anyo[i],dw_1.object.orden[i])
	
	//Información del pago
	SetNull(lineaXML) 
	lineaXML = "<PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
		//Identificación de la información del pago
		//Referencia única, asignada por el presentador, para identificar inequívocamente el bloque de información del pago dentro del mensaje
		
			//Utilizamos código factura: codigo
			
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = dw_1.object.factura[i]
		lineaXML = "<PmtInfId>" + linea + "</PmtInfId>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 35 ) then
			messagebox('Error', "Identificación de la información de pago : Longitud no puede ser > 35" + lineaXML)
			b_error = true
		end if
		
		//Método de pago: DD
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<PmtMtd>DD</PmtMtd>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Método de pago : Longitud no puede ser > 2" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<NbOfTxs>1</NbOfTxs>" //1 Efecto por referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Efectos por referencia > 2" + lineaXML)
			b_error = true
		end if

		SetNull(lineaXML) 	
		SetNull(linea) 
		linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
		lineaXML = "<CtrlSum>"+linea+"</CtrlSum>" //Importe efecto referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 15 ) then
			messagebox('Error', "Importe efecto referencia > 15" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		lineaXML = "<PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>SEPA</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>COR1</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		
		SetNull(lineaXML) 	
		if lb_carefectos_es_frst then
			lineaXML = "<SeqTp>FRST</SeqTp>"
		else
			lineaXML = "<SeqTp>RCUR</SeqTp>"
		end if	
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		//Fecha de cobro
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = String(ldt_fecha_cobro, "yyyy-mm-dd")//f_iso_date_con_guiones(datetime(date(String(dw_1.object.fvto[i], "yyyy-mm-dd"))))
		lineaXML = "<ReqdColltnDt>" + linea +  "</ReqdColltnDt>"						
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML
		if (len( linea ) > 10 ) then
				messagebox('Error', "Fecha de cobro: Longitud no puede ser > 8" + lineaXML)
				b_error = true
		end if
			

		//Acreedor
		SetNull(lineaXML) 
		lineaXML = "<Cdtr>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Nombre
				SetNull(lineaXML) 
				SetNull(linea)
				linea =  f_nombre_empresa(codigo_empresa)
				f_tratar_texto(linea)
				lineaXML = "<Nm>" + linea +  "</Nm>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 70 ) then
						messagebox('Error', "Acreedor - Nombre: Longitud no puede ser > 70 " + linea)
						b_error = true
				end if
								
			//Fin - Acreedor
			SetNull(lineaXML) 
			lineaXML = "</Cdtr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
						
			//Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			
				//Identificación
				SetNull(lineaXML) 
				lineaXML = "<Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//IBAN
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
					lineaXML = "<IBAN>" + linea +  "</IBAN>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 34 ) then
							messagebox('Error', "Cuenta Acreedor IBAN : Longitud no puede ser > 34 " + linea)
							b_error = true
					end if
				
				//Fin - Identificación
				SetNull(lineaXML) 
				lineaXML = "</Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
			
			// Fin -Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			//Moneda - OPCIONAL
			
			//Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "<FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//BIC
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_carbancos_codigo_swift(codigo_empresa, em_banco.text)
					lineaXML = "<BIC>" + linea +  "</BIC>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 11 ) then
							messagebox('Error', "Entidad del Acreedor - BIC: Longitud no puede ser > 11" + linea)
							b_error = true
					end if
					
				
				
				//Fin = Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "</FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
				
			
			//Fin - Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			SetNull(lineaXML) 
			lineaXML = "<ChrgBr>SLEV</ChrgBr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			//************************************************************************************************************
			//Identificación del acreedor
					//ESte campo debe estar en este apartado o en el bloque de "Información de la operación de adeudo directo"
			SetNull(lineaXML) 
			lineaXML = "<CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

					
					//Id
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
							//Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "<PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
							
							
								//Otra						
								SetNull(lineaXML) 
								lineaXML = "<Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
										//Id
										SetNull(lineaXML) 	
										SetNull(linea)
										linea = idAcreedor
										lineaXML = "<Id>" + linea +  "</Id>"						
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML
										if (len( linea ) > 35 ) then
													messagebox('Error', "Operación de Adeudo Directo - Identificación del acreedor (Identificación): Longitud no puede ser > 35 " + linea)
													b_error = true
										end if																				
								
										//Nuevo 29-03-2016 indicado por Bankia
										SetNull(lineaXML) 	
										lineaXML = "<SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														

											SetNull(lineaXML) 	
											lineaXML = "<Prtry>SEPA</Prtry>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 														

										SetNull(lineaXML) 	
										lineaXML = "</SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														
										//Fin de nuevo 29-03-2016 indicado por Bankia																						
								
								//Fin - Otra						
								SetNull(lineaXML) 
								lineaXML = "</Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
							
							
							//Fin - Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "</PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
					//Fin - Id
					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
				


									
			//Fin - Identificación del acreedor				
			SetNull(lineaXML) 
			lineaXML = "</CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 										
										
										
										
										
			//Información de la operación de adeudo directo [1..N]
			//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			SetNull(lineaXML) 
			lineaXML = "<DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "<PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//Identificación de la instrucción OPTIONAL
					
					//Identificación de extremo a extremo													//??????
					//Identificación única asignada por la parte iniciadora para identificar inequívocamente cada operación (AT-10). Esta referencia se transmite de extremo a extremo, sin cambios, a lo largo de toda la cadena de pago.
					SetNull(lineaXML) 	
					SetNull(linea)
					referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") +"/"+ dw_1.Object.factura[i] +"/"+ String(Dec(dw_1.Object.recibo[i]),"00")
					linea = referencia_adeudo
					lineaXML = "<EndToEndId>" + linea +  "</EndToEndId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 35 ) then
							messagebox('Error', "Operación de Adeudo Directo - Identificación de extremo a extremo : Longitud no puede ser > 35 " + linea)
							b_error = true
					end if
					
				//Fin - Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "</PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Importe ordenado
				//Importe del adeudo directo expresado en euros (AT-06)
				SetNull(lineaXML) 	
				SetNull(linea)				
				linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
				moneda = 'EUR'//f_moneda_iso(String(dw_1.object.monedas[i]))
					//Atributo Ccy (moneda) es obligatorio
				lineaXML = "<InstdAmt Ccy='" + moneda + "'" + ">" + linea +  "</InstdAmt>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 13 ) then //12 + separador decimal = 13
						messagebox('Error', "Operación de Adeudo Directo - Importe ordenado: Longitud no puede ser > 12 " + linea)
						b_error = true
				end if
				
				SetNull(lineaXML) 
				lineaXML = "<DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
				SetNull(lineaXML) 
				lineaXML = "<MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_cuenta_genter(codigo_empresa,"C",ls_cliente)//Referencia del mandato
					lineaXML = "<MndtId>" + linea +  "</MndtId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 20 ) then
							messagebox('Error', "Referencia del mandato > 20 " + linea)
							b_error = true
					end if
					
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  "2009-10-31"//Fecha del mandato
					lineaXML = "<DtOfSgntr>" + linea +  "</DtOfSgntr>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 10 ) then
							messagebox('Error', "Fecha del mandato > 10 " + linea)
							b_error = true
					end if					
					
				SetNull(lineaXML) 
				lineaXML = "</MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				

				SetNull(lineaXML) 
				lineaXML = "</DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
								
				//Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
						
						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "<FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						
						If cab.naci_extra = 'E' then
							//BIC del cliente
							SetNull(lineaXML) 
							lineaXML = "<BIC>"+ f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)+"</BIC>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
						else
							//Nuevo 29-03-2016 indicado por Bankia
							SetNull(lineaXML) 	
							lineaXML = "<Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
	
								SetNull(lineaXML) 	
								lineaXML = "<Id>NOTPROVIDED</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 														
	
							SetNull(lineaXML) 	
							lineaXML = "</Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
							//Fin de nuevo 29-03-2016 indicado por Bankia																					
						end if

						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "</FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
				
				//Fin - Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Deudor
				SetNull(lineaXML) 
				lineaXML = "<Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
					//Nombre
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
					f_tratar_texto(linea)
					lineaXML = "<Nm>" + linea +  "</Nm>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 70 ) then
							messagebox('Error', "Deudor - Nombre : Longitud no puede ser > 70" + linea)
							b_error = true
					end if
					
				//Fin - Deudor
				SetNull(lineaXML) 
				lineaXML = "</Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
					
				//Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//Identificación
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML					
					
						//IBAN
						SetNull(lineaXML) 	
						SetNull(linea)
						linea = f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
						if is_naci_extra = 'N' then
							if not(f_chequear_iban(linea,ls_iban_correcto)) then
								if messagebox("IBAN Incorrecto",f_razon_genter(codigo_empresa,'C',ls_cliente)+"~nIncorrecto : "+linea+"~nCorrecto : "+ls_iban_correcto+"~n¿Desea sustituir en IBAN incorrecto por el calculado?",Question!,YesNo!,1) = 1 then
									linea = ls_iban_correcto
									messagebox("Sustituido!","Debe modificar la domiciliación del cliente con el IBAN correcto.")
								end if
							end if
						end if
						
						lineaXML = "<IBAN>" + linea +  "</IBAN>"						
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						if (len( linea ) > 34 ) then
								messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
								b_error = true
						end if

					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
				
				
				//Fin - Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
				
				//Información del remitente
				SetNull(lineaXML) 
				lineaXML = "<RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML								
				
					//Información no estructurada
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_nombre_empresa(codigo_empresa)+" Fra "+dw_1.object.factura[i]+" de fecha "+string(dw_1.object.ffra[i],"dd/mm/yyyy")+" vto "+string(dw_1.object.fvto[i],"dd/mm/yyyy")+" "+f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')+"Eur"
					f_tratar_texto(linea)
					lineaXML = "<Ustrd>" + linea +  "</Ustrd>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 140 ) then
							messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
							b_error = true
					end if				
				
				//Fin de información del remitente
				SetNull(lineaXML) 
				lineaXML = "</RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML												
					
//								//BIC
//								SetNull(lineaXML) 	
//								SetNull(linea)
//								linea =  f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
//								lineaXML = "<BIC>" + linea +  "</BIC>"						
//								pos = dw_core_b2b.InsertRow(0) 
//								dw_core_b2b.Object.linea[pos] = lineaXML
//								if (len( linea ) > 11 ) then
//										messagebox('Error', "Entidad del deudor - BIC : Longitud no puede ser > 11 " + linea)
//										b_error = true
//								end if
							

			
			//Información de la operación de adeudo directo
			SetNull(lineaXML) 
			lineaXML = "</DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			
			
	SetNull(lineaXML) 
	lineaXML = "</PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
	
	
	
next

//Fin - Información del pago
//---------------------------------------------------------------------------------------------------------------------



//Pie - Cierre etiqueta Raíz
SetNull(lineaXML) 
lineaXML = "</CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "</Document>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

string fichero
int res 

fichero = "N19COR1SEPA" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")+".XML"

fichero = em_directorio.text + "\" + fichero

if dw_core_b2b.rowcount() > 0 then
	res = dw_core_b2b.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if b_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

destroy dw_core_b2b
end subroutine

public subroutine f_tratar_texto (ref string arg_texto);string ls_nuevo_texto,caracter,caracter_ant
long   indice,total,asci

ls_nuevo_texto  = ""
total        = len(arg_texto)
caracter_ant = ""

for indice = 1 to total
	caracter = mid(arg_texto,indice,1)
	
	choose case caracter
		case '´'
			caracter = '&apos;'
			caracter_ant = caracter			
		case '`'
			caracter = '&apos;'
			caracter_ant = caracter								
		case '&'
			caracter = '&amp;'
			caracter_ant = caracter			
		case '>'
			caracter = '&gt;'
			caracter_ant = caracter								
		case '<'
			caracter = '&lt;'
			caracter_ant = caracter					
		case '"'
			caracter = '&quot;'
			caracter_ant = caracter								
		case 'Á'
			caracter = 'A'
			caracter_ant = caracter
		case 'É'
			caracter = 'E'
			caracter_ant = caracter
		case 'Í'
			caracter = 'I'
			caracter_ant = caracter
		case 'Ó'
			caracter = 'O'
			caracter_ant = caracter
		case 'Ú'
			caracter = 'U'
			caracter_ant = caracter
		case 'Ñ'
			caracter = 'N'
			caracter_ant = caracter
		case 'Ç'
			caracter = 'C'
			caracter_ant = caracter			
		case 'á'
			caracter = 'a'
			caracter_ant = caracter
		case 'é'
			caracter = 'e'
			caracter_ant = caracter
		case 'í'
			caracter = 'i'
			caracter_ant = caracter
		case 'ó'
			caracter = 'o'
			caracter_ant = caracter
		case 'ú'
			caracter = 'u'
			caracter_ant = caracter
		case 'ñ'
			caracter = 'n'
			caracter_ant = caracter
		case 'ç'
			caracter = 'c'
			caracter_ant = caracter						
		case 'º','ª'
			caracter = ''		
			caracter_ant = caracter
		case ' '
			if caracter_ant = ' ' then
				caracter_ant = caracter
				caracter = ''		
			else
				caracter_ant = caracter
			end if
		case else
			if asc(caracter) < 32 or asc(caracter) > 128 then
				caracter = ' '
				caracter_ant = caracter
			else
				caracter_ant = caracter
			end if
	end choose	
	ls_nuevo_texto  = ls_nuevo_texto + caracter	
next


arg_texto = ls_nuevo_texto

end subroutine

public subroutine core (str_carremesas cab);//---------------------------------------------------------------------------------------------------------------------
//ADEUDOS DIRECTOS SEPA:
//---------------------------------------------------------------------------------------------------------------------

String lineaXML, linea, ls_cliente, ls_domiciliacion , v_mandato, idAcreedor, moneda,ls_cif_empresa,ls_pais_empresa
long pos
boolean b_error
string sufijo,referencia_adeudo,nombre_fichero,ls_sufijo_mensajeid,ls_iban_correcto
datetime ldt_fecha_cobro,ldt_fecha_alta
datastore dw_core_b2b

f_cargar_cursor_transaccion(sqlca,dw_core_b2b,'select space(500) as linea from empresas where 0 = 1')

dw_core_b2b.SetTransObject(SQLCA) 
dw_core_b2b.Reset()

ldt_fecha_alta = datetime(today(),now())

ls_sufijo_mensajeid = ""
ls_sufijo_mensajeid += string(year(date(ldt_fecha_alta)),"0000")
ls_sufijo_mensajeid += string(month(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(day(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(hour(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(minute(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(second(time(ldt_fecha_alta)),"00")	

/*
seleccionamos Los datos de la empresa
*/

SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

//Raíz
//---------------------------------------------------------------------------------------------------------------------
// xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'

SetNull(lineaXML) 
lineaXML = "<?xml version='1.0' encoding='utf-8'?>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Cabecera
//---------------------------------------------------------------------------------------------------------------------

SetNull(lineaXML) 
lineaXML = "<GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

				//Identificación del mensaje
				//Referencia asignada por la parte iniciadora y enviada a la siguiente parte de la cadena para identificar el mensaje de forma inequívoca
				//Identificador del acreedor en la entidad bancaria a la que se remite:

						//ES (código país) + 13 (dígitos control) + sufijo + NIF


						//Cada entidad bancaria tiene un sufijo diferente para el mismo cliente,
						//por lo que reemplazamos el sufijo de la consulta por el que le toca según el banco
					
				SetNull(lineaXML) 
				idAcreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)
				linea = idAcreedor+ls_sufijo_mensajeid
				//Si la remesa es al descuento se añade el prefijo FSDD al identificador del mensaje
				if cab.tiporem = '1' then
					linea = 'FSDD'+linea
				end if
				lineaXML = "<MsgId>" + linea + "</MsgId>" 											
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if ( len( linea ) < 1 or len( linea ) > 35 ) then
						messagebox('Error', "Identificación del mensaje: Longitud debe estar entre 1 y  35 " + linea)
						b_error = true
				end if
				
				
				
				SetNull(lineaXML) 
				linea = string(today(),'yyyy-mm-dd')+'T'+string(now(),'hh:mm:ss') //f_obtener_iso_datetime(datetime(today(),now()))
				lineaXML = "<CreDtTm>" + linea +  "</CreDtTm>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 19 ) then
						messagebox('Error', "Fecha y hora de creación: Longitud no puede ser > 19 " + linea)
						b_error = true
				end if
				
				
				SetNull(lineaXML) 
				integer numOperaciones
				numOperaciones = dw_1.RowCount()
				linea = String(numOperaciones)
				lineaXML = "<NbOfTxs>" + linea +  "</NbOfTxs>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Número de operaciones: Longitud no puede ser > 15")
						b_error = true
				end if
						
				SetNull(lineaXML) 
				dec ctrlsum
				ctrlsum = dec(dw_1.describe('evaluate("sum(importe for all)",1)'))
				linea = f_sustituir(String(ctrlsum,'#########0.00'),',','.')
				lineaXML = "<CtrlSum>" + linea +  "</CtrlSum>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Control Sum: Longitud no puede ser > 15")
						b_error = true
				end if						
						
				SetNull(lineaXML) 	
				lineaXML = "<InitgPty>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
								
								SetNull(lineaXML) 
								linea = f_nombre_empresa(codigo_empresa)
								f_tratar_texto(linea)
								lineaXML = "<Nm>" + linea + "</Nm>"									
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								if (len( linea ) > 70 ) then
									messagebox('Error', "Nombre de la Parte Iniciadora: Longitud no puede ser > 70")
									b_error = true
								end if
								
								
								SetNull(lineaXML) 	
								lineaXML = "<Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
											
											SetNull(lineaXML) 	
											lineaXML = "<OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 

												SetNull(lineaXML) 	
												lineaXML = "<Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 
														
														
														SetNull(lineaXML) 	
														linea =  idAcreedor //ls_cif_empresa
														lineaXML = "<Id>" + linea + "</Id>"//"<BICOrBEI>" + linea + "</BICOrBEI>"										
														pos = dw_core_b2b.InsertRow(0) 
														dw_core_b2b.Object.linea[pos] = lineaXML 
														if (len( linea ) > 35 ) then
															//messagebox('Error', "BIC o BEI de la parte identificadora: Longitud no puede ser > 11")
															messagebox('Error', "Id de la parte identificadora: Longitud no puede ser > 35")
															b_error = true
														end if
														
												SetNull(lineaXML) 	
												lineaXML = "</Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 														
																									
											SetNull(lineaXML)
											SetNull(linea) 
											lineaXML = "</OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 
											
											// Persona Física
											
//											f_obtener_persona_fisica()
								
								
								
								SetNull(lineaXML) 	
								lineaXML = "</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				
				SetNull(lineaXML) 	
				lineaXML = "</InitgPty>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				


SetNull(lineaXML) 
lineaXML = "</GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Fin-Cabecera
//---------------------------------------------------------------------------------------------------------------------

//*********************************************************************************************************************
//Información del pago
//---------------------------------------------------------------------------------------------------------------------
//*********************************************************************************************************************

//Para cada pago repetir

int i

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	ldt_fecha_cobro  = dw_1.object.fvto[i]
	
	//Información del pago
	SetNull(lineaXML) 
	lineaXML = "<PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
		//Identificación de la información del pago
		//Referencia única, asignada por el presentador, para identificar inequívocamente el bloque de información del pago dentro del mensaje
		
			//Utilizamos código factura: codigo
			
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = dw_1.object.factura[i]
		lineaXML = "<PmtInfId>" + linea + "</PmtInfId>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 35 ) then
			messagebox('Error', "Identificación de la información de pago : Longitud no puede ser > 35" + lineaXML)
			b_error = true
		end if
		
		//Método de pago: DD
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<PmtMtd>DD</PmtMtd>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Método de pago : Longitud no puede ser > 2" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<NbOfTxs>1</NbOfTxs>" //1 Efecto por referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Efectos por referencia > 2" + lineaXML)
			b_error = true
		end if

		SetNull(lineaXML) 	
		SetNull(linea) 
		linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
		lineaXML = "<CtrlSum>"+linea+"</CtrlSum>" //Importe efecto referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 15 ) then
			messagebox('Error', "Importe efecto referencia > 15" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		lineaXML = "<PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>SEPA</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>COR1</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<SeqTp>RCUR</SeqTp>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		//Fecha de cobro
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = String(ldt_fecha_cobro, "yyyy-mm-dd")//f_iso_date_con_guiones(datetime(date(String(dw_1.object.fvto[i], "yyyy-mm-dd"))))
		lineaXML = "<ReqdColltnDt>" + linea +  "</ReqdColltnDt>"						
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML
		if (len( linea ) > 10 ) then
				messagebox('Error', "Fecha de cobro: Longitud no puede ser > 8" + lineaXML)
				b_error = true
		end if
			

		//Acreedor
		SetNull(lineaXML) 
		lineaXML = "<Cdtr>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Nombre
				SetNull(lineaXML) 
				SetNull(linea)
				linea =  f_nombre_empresa(codigo_empresa)
				f_tratar_texto(linea)
				lineaXML = "<Nm>" + linea +  "</Nm>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 70 ) then
						messagebox('Error', "Acreedor - Nombre: Longitud no puede ser > 70 " + linea)
						b_error = true
				end if
								
			//Fin - Acreedor
			SetNull(lineaXML) 
			lineaXML = "</Cdtr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
						
			//Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			
				//Identificación
				SetNull(lineaXML) 
				lineaXML = "<Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//IBAN
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
					lineaXML = "<IBAN>" + linea +  "</IBAN>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 34 ) then
							messagebox('Error', "Cuenta Acreedor IBAN : Longitud no puede ser > 34 " + linea)
							b_error = true
					end if
				
				//Fin - Identificación
				SetNull(lineaXML) 
				lineaXML = "</Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
			
			// Fin -Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			//Moneda - OPCIONAL
			
			//Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "<FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//BIC
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_carbancos_codigo_swift(codigo_empresa, em_banco.text)
					lineaXML = "<BIC>" + linea +  "</BIC>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 11 ) then
							messagebox('Error', "Entidad del Acreedor - BIC: Longitud no puede ser > 11" + linea)
							b_error = true
					end if
					
				
				
				//Fin = Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "</FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
				
			
			//Fin - Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			SetNull(lineaXML) 
			lineaXML = "<ChrgBr>SLEV</ChrgBr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			//************************************************************************************************************
			//Identificación del acreedor
					//ESte campo debe estar en este apartado o en el bloque de "Información de la operación de adeudo directo"
			SetNull(lineaXML) 
			lineaXML = "<CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

					
					//Id
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
							//Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "<PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
							
							
								//Otra						
								SetNull(lineaXML) 
								lineaXML = "<Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
										//Id
										SetNull(lineaXML) 	
										SetNull(linea)
										linea = idAcreedor
										lineaXML = "<Id>" + linea +  "</Id>"						
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML
										if (len( linea ) > 35 ) then
													messagebox('Error', "Operación de Adeudo Directo - Identificación del acreedor (Identificación): Longitud no puede ser > 35 " + linea)
													b_error = true
										end if																				
								
										//Nuevo 29-03-2016 indicado por Bankia
										SetNull(lineaXML) 	
										lineaXML = "<SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														

											SetNull(lineaXML) 	
											lineaXML = "<Prtry>SEPA</Prtry>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 														

										SetNull(lineaXML) 	
										lineaXML = "</SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														
										//Fin de nuevo 29-03-2016 indicado por Bankia																						
								
								//Fin - Otra						
								SetNull(lineaXML) 
								lineaXML = "</Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
							
							
							//Fin - Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "</PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
					//Fin - Id
					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
				


									
			//Fin - Identificación del acreedor				
			SetNull(lineaXML) 
			lineaXML = "</CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 										
										
										
										
										
			//Información de la operación de adeudo directo [1..N]
			//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			SetNull(lineaXML) 
			lineaXML = "<DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "<PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//Identificación de la instrucción OPTIONAL
					
					//Identificación de extremo a extremo													//??????
					//Identificación única asignada por la parte iniciadora para identificar inequívocamente cada operación (AT-10). Esta referencia se transmite de extremo a extremo, sin cambios, a lo largo de toda la cadena de pago.
					SetNull(lineaXML) 	
					SetNull(linea)
					referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") +"/"+ dw_1.Object.factura[i] +"/"+ String(Dec(dw_1.Object.recibo[i]),"00")
					linea = referencia_adeudo
					lineaXML = "<EndToEndId>" + linea +  "</EndToEndId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 35 ) then
							messagebox('Error', "Operación de Adeudo Directo - Identificación de extremo a extremo : Longitud no puede ser > 35 " + linea)
							b_error = true
					end if
					
				//Fin - Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "</PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Importe ordenado
				//Importe del adeudo directo expresado en euros (AT-06)
				SetNull(lineaXML) 	
				SetNull(linea)				
				linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
				moneda = 'EUR'//f_moneda_iso(String(dw_1.object.monedas[i]))
					//Atributo Ccy (moneda) es obligatorio
				lineaXML = "<InstdAmt Ccy='" + moneda + "'" + ">" + linea +  "</InstdAmt>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 13 ) then //12 + separador decimal = 13
						messagebox('Error', "Operación de Adeudo Directo - Importe ordenado: Longitud no puede ser > 12 " + linea)
						b_error = true
				end if
				
				SetNull(lineaXML) 
				lineaXML = "<DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
				SetNull(lineaXML) 
				lineaXML = "<MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_cuenta_genter(codigo_empresa,"C",ls_cliente)//Referencia del mandato
					lineaXML = "<MndtId>" + linea +  "</MndtId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 20 ) then
							messagebox('Error', "Referencia del mandato > 20 " + linea)
							b_error = true
					end if
					
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  "2009-10-31"//Fecha del mandato
					lineaXML = "<DtOfSgntr>" + linea +  "</DtOfSgntr>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 10 ) then
							messagebox('Error', "Fecha del mandato > 10 " + linea)
							b_error = true
					end if					
					
				SetNull(lineaXML) 
				lineaXML = "</MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				

				SetNull(lineaXML) 
				lineaXML = "</DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
								
				//Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
						
						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "<FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						
						If cab.naci_extra = 'E' then
							//BIC del cliente
							SetNull(lineaXML) 
							lineaXML = "<BIC>"+ f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)+"</BIC>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
						else
							//Nuevo 29-03-2016 indicado por Bankia
							SetNull(lineaXML) 	
							lineaXML = "<Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
	
								SetNull(lineaXML) 	
								lineaXML = "<Id>NOTPROVIDED</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 														
	
							SetNull(lineaXML) 	
							lineaXML = "</Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
							//Fin de nuevo 29-03-2016 indicado por Bankia																					
						end if

						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "</FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
				
				//Fin - Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Deudor
				SetNull(lineaXML) 
				lineaXML = "<Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
					//Nombre
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
					f_tratar_texto(linea)
					lineaXML = "<Nm>" + linea +  "</Nm>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 70 ) then
							messagebox('Error', "Deudor - Nombre : Longitud no puede ser > 70" + linea)
							b_error = true
					end if
					
				//Fin - Deudor
				SetNull(lineaXML) 
				lineaXML = "</Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
					
				//Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//Identificación
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML					
					
						//IBAN
						SetNull(lineaXML) 	
						SetNull(linea)
						linea = f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
						if is_naci_extra = 'N' then
							if not(f_chequear_iban(linea,ls_iban_correcto)) then
								if messagebox("IBAN Incorrecto",f_razon_genter(codigo_empresa,'C',ls_cliente)+"~nIncorrecto : "+linea+"~nCorrecto : "+ls_iban_correcto+"~n¿Desea sustituir en IBAN incorrecto por el calculado?",Question!,YesNo!,1) = 1 then
									linea = ls_iban_correcto
									messagebox("Sustituido!","Debe modificar la domiciliación del cliente con el IBAN correcto.")
								end if
							end if
						end if
						
						lineaXML = "<IBAN>" + linea +  "</IBAN>"						
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						if (len( linea ) > 34 ) then
								messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
								b_error = true
						end if

					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
				
				
				//Fin - Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
				
				//Información del remitente
				SetNull(lineaXML) 
				lineaXML = "<RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML								
				
					//Información no estructurada
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_nombre_empresa(codigo_empresa)+" Fra "+dw_1.object.factura[i]+" de fecha "+string(dw_1.object.ffra[i],"dd/mm/yyyy")+" vto "+string(dw_1.object.fvto[i],"dd/mm/yyyy")+" "+f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')+"Eur"
					f_tratar_texto(linea)
					lineaXML = "<Ustrd>" + linea +  "</Ustrd>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 140 ) then
							messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
							b_error = true
					end if				
				
				//Fin de información del remitente
				SetNull(lineaXML) 
				lineaXML = "</RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML												
					
//								//BIC
//								SetNull(lineaXML) 	
//								SetNull(linea)
//								linea =  f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
//								lineaXML = "<BIC>" + linea +  "</BIC>"						
//								pos = dw_core_b2b.InsertRow(0) 
//								dw_core_b2b.Object.linea[pos] = lineaXML
//								if (len( linea ) > 11 ) then
//										messagebox('Error', "Entidad del deudor - BIC : Longitud no puede ser > 11 " + linea)
//										b_error = true
//								end if
							

			
			//Información de la operación de adeudo directo
			SetNull(lineaXML) 
			lineaXML = "</DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			
			
	SetNull(lineaXML) 
	lineaXML = "</PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
	
	
	
next

//Fin - Información del pago
//---------------------------------------------------------------------------------------------------------------------



//Pie - Cierre etiqueta Raíz
SetNull(lineaXML) 
lineaXML = "</CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "</Document>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

string fichero
int res 

fichero = "N19SEPA" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")+".XML"

fichero = em_directorio.text + "\" + fichero

if dw_core_b2b.rowcount() > 0 then
	res = dw_core_b2b.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if b_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

destroy dw_core_b2b
end subroutine

public subroutine f_grabo_disquete_19_sepa_core_xml (str_carremesas cab);//---------------------------------------------------------------------------------------------------------------------
//ADEUDOS DIRECTOS SEPA:
//---------------------------------------------------------------------------------------------------------------------

String lineaXML, linea, ls_cliente, ls_domiciliacion , v_mandato, idAcreedor, moneda,ls_cif_empresa,ls_pais_empresa
long pos
boolean b_error,lb_carefectos_es_frst
string sufijo,referencia_adeudo,nombre_fichero,ls_sufijo_mensajeid,ls_iban_correcto
datetime ldt_fecha_cobro,ldt_fecha_alta
datastore dw_core_b2b

f_cargar_cursor_transaccion(sqlca,dw_core_b2b,'select space(500) as linea from empresas where 0 = 1')

dw_core_b2b.SetTransObject(SQLCA) 
dw_core_b2b.Reset()

ldt_fecha_alta = datetime(today(),now())

ls_sufijo_mensajeid = ""
ls_sufijo_mensajeid += string(year(date(ldt_fecha_alta)),"0000")
ls_sufijo_mensajeid += string(month(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(day(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(hour(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(minute(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(second(time(ldt_fecha_alta)),"00")	

/*
seleccionamos Los datos de la empresa
*/

SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

//Raíz
//---------------------------------------------------------------------------------------------------------------------
// xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'

SetNull(lineaXML) 
lineaXML = "<?xml version='1.0' encoding='utf-8'?>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Cabecera
//---------------------------------------------------------------------------------------------------------------------

SetNull(lineaXML) 
lineaXML = "<GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

				//Identificación del mensaje
				//Referencia asignada por la parte iniciadora y enviada a la siguiente parte de la cadena para identificar el mensaje de forma inequívoca
				//Identificador del acreedor en la entidad bancaria a la que se remite:

						//ES (código país) + 13 (dígitos control) + sufijo + NIF


						//Cada entidad bancaria tiene un sufijo diferente para el mismo cliente,
						//por lo que reemplazamos el sufijo de la consulta por el que le toca según el banco
					
				SetNull(lineaXML) 
				idAcreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)
				linea = idAcreedor+ls_sufijo_mensajeid
				//Si la remesa es al descuento se añade el prefijo FSDD al identificador del mensaje
				if cab.tiporem = '1' then
					linea = 'FSDD'+linea
				end if
				lineaXML = "<MsgId>" + linea + "</MsgId>" 											
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if ( len( linea ) < 1 or len( linea ) > 35 ) then
						messagebox('Error', "Identificación del mensaje: Longitud debe estar entre 1 y  35 " + linea)
						b_error = true
				end if
				
				
				
				SetNull(lineaXML) 
				linea = string(today(),'yyyy-mm-dd')+'T'+string(now(),'hh:mm:ss') //f_obtener_iso_datetime(datetime(today(),now()))
				lineaXML = "<CreDtTm>" + linea +  "</CreDtTm>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 19 ) then
						messagebox('Error', "Fecha y hora de creación: Longitud no puede ser > 19 " + linea)
						b_error = true
				end if
				
				
				SetNull(lineaXML) 
				integer numOperaciones
				numOperaciones = dw_1.RowCount()
				linea = String(numOperaciones)
				lineaXML = "<NbOfTxs>" + linea +  "</NbOfTxs>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Número de operaciones: Longitud no puede ser > 15")
						b_error = true
				end if
						
				SetNull(lineaXML) 
				dec ctrlsum
				ctrlsum = dec(dw_1.describe('evaluate("sum(importe for all)",1)'))
				linea = f_sustituir(String(ctrlsum,'#########0.00'),',','.')
				lineaXML = "<CtrlSum>" + linea +  "</CtrlSum>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Control Sum: Longitud no puede ser > 15")
						b_error = true
				end if						
						
				SetNull(lineaXML) 	
				lineaXML = "<InitgPty>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
								
								SetNull(lineaXML) 
								linea = f_nombre_empresa(codigo_empresa)
								f_tratar_texto(linea)
								lineaXML = "<Nm>" + linea + "</Nm>"									
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								if (len( linea ) > 70 ) then
									messagebox('Error', "Nombre de la Parte Iniciadora: Longitud no puede ser > 70")
									b_error = true
								end if
								
								
								SetNull(lineaXML) 	
								lineaXML = "<Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
											
											SetNull(lineaXML) 	
											lineaXML = "<OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 

												SetNull(lineaXML) 	
												lineaXML = "<Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 
														
														
														SetNull(lineaXML) 	
														linea =  idAcreedor //ls_cif_empresa
														lineaXML = "<Id>" + linea + "</Id>"//"<BICOrBEI>" + linea + "</BICOrBEI>"										
														pos = dw_core_b2b.InsertRow(0) 
														dw_core_b2b.Object.linea[pos] = lineaXML 
														if (len( linea ) > 35 ) then
															//messagebox('Error', "BIC o BEI de la parte identificadora: Longitud no puede ser > 11")
															messagebox('Error', "Id de la parte identificadora: Longitud no puede ser > 35")
															b_error = true
														end if
														
												SetNull(lineaXML) 	
												lineaXML = "</Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 														
																									
											SetNull(lineaXML)
											SetNull(linea) 
											lineaXML = "</OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 
											
											// Persona Física
											
//											f_obtener_persona_fisica()
								
								
								
								SetNull(lineaXML) 	
								lineaXML = "</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				
				SetNull(lineaXML) 	
				lineaXML = "</InitgPty>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				


SetNull(lineaXML) 
lineaXML = "</GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Fin-Cabecera
//---------------------------------------------------------------------------------------------------------------------

//*********************************************************************************************************************
//Información del pago
//---------------------------------------------------------------------------------------------------------------------
//*********************************************************************************************************************

//Para cada pago repetir

int i

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	ldt_fecha_cobro  = dw_1.object.fvto[i]
	
	lb_carefectos_es_frst = f_carefectos_es_frst(codigo_empresa,dw_1.object.anyo[i],dw_1.object.orden[i])
	
	//Información del pago
	SetNull(lineaXML) 
	lineaXML = "<PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
		//Identificación de la información del pago
		//Referencia única, asignada por el presentador, para identificar inequívocamente el bloque de información del pago dentro del mensaje
		
			//Utilizamos código factura: codigo
			
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = dw_1.object.factura[i]
		lineaXML = "<PmtInfId>" + linea + "</PmtInfId>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 35 ) then
			messagebox('Error', "Identificación de la información de pago : Longitud no puede ser > 35" + lineaXML)
			b_error = true
		end if
		
		//Método de pago: DD
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<PmtMtd>DD</PmtMtd>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Método de pago : Longitud no puede ser > 2" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<NbOfTxs>1</NbOfTxs>" //1 Efecto por referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Efectos por referencia > 2" + lineaXML)
			b_error = true
		end if

		SetNull(lineaXML) 	
		SetNull(linea) 
		linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
		lineaXML = "<CtrlSum>"+linea+"</CtrlSum>" //Importe efecto referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 15 ) then
			messagebox('Error', "Importe efecto referencia > 15" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		lineaXML = "<PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>SEPA</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>CORE</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		if lb_carefectos_es_frst then
			lineaXML = "<SeqTp>FRST</SeqTp>"
		else
			lineaXML = "<SeqTp>RCUR</SeqTp>"
		end if	
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		//Fecha de cobro
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = String(ldt_fecha_cobro, "yyyy-mm-dd")//f_iso_date_con_guiones(datetime(date(String(dw_1.object.fvto[i], "yyyy-mm-dd"))))
		lineaXML = "<ReqdColltnDt>" + linea +  "</ReqdColltnDt>"						
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML
		if (len( linea ) > 10 ) then
				messagebox('Error', "Fecha de cobro: Longitud no puede ser > 8" + lineaXML)
				b_error = true
		end if
			

		//Acreedor
		SetNull(lineaXML) 
		lineaXML = "<Cdtr>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Nombre
				SetNull(lineaXML) 
				SetNull(linea)
				linea =  f_nombre_empresa(codigo_empresa)
				f_tratar_texto(linea)
				lineaXML = "<Nm>" + linea +  "</Nm>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 70 ) then
						messagebox('Error', "Acreedor - Nombre: Longitud no puede ser > 70 " + linea)
						b_error = true
				end if
								
			//Fin - Acreedor
			SetNull(lineaXML) 
			lineaXML = "</Cdtr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
						
			//Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			
				//Identificación
				SetNull(lineaXML) 
				lineaXML = "<Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//IBAN
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
					lineaXML = "<IBAN>" + linea +  "</IBAN>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 34 ) then
							messagebox('Error', "Cuenta Acreedor IBAN : Longitud no puede ser > 34 " + linea)
							b_error = true
					end if
				
				//Fin - Identificación
				SetNull(lineaXML) 
				lineaXML = "</Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
			
			// Fin -Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			//Moneda - OPCIONAL
			
			//Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "<FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//BIC
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_carbancos_codigo_swift(codigo_empresa, em_banco.text)
					lineaXML = "<BIC>" + linea +  "</BIC>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 11 ) then
							messagebox('Error', "Entidad del Acreedor - BIC: Longitud no puede ser > 11" + linea)
							b_error = true
					end if
					
				
				
				//Fin = Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "</FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
				
			
			//Fin - Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			SetNull(lineaXML) 
			lineaXML = "<ChrgBr>SLEV</ChrgBr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			//************************************************************************************************************
			//Identificación del acreedor
					//ESte campo debe estar en este apartado o en el bloque de "Información de la operación de adeudo directo"
			SetNull(lineaXML) 
			lineaXML = "<CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

					
					//Id
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
							//Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "<PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
							
							
								//Otra						
								SetNull(lineaXML) 
								lineaXML = "<Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
										//Id
										SetNull(lineaXML) 	
										SetNull(linea)
										linea = idAcreedor
										lineaXML = "<Id>" + linea +  "</Id>"						
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML
										if (len( linea ) > 35 ) then
													messagebox('Error', "Operación de Adeudo Directo - Identificación del acreedor (Identificación): Longitud no puede ser > 35 " + linea)
													b_error = true
										end if																				
								
										//Nuevo 29-03-2016 indicado por Bankia
										SetNull(lineaXML) 	
										lineaXML = "<SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														

											SetNull(lineaXML) 	
											lineaXML = "<Prtry>SEPA</Prtry>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 														

										SetNull(lineaXML) 	
										lineaXML = "</SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														
										//Fin de nuevo 29-03-2016 indicado por Bankia																						
								
								//Fin - Otra						
								SetNull(lineaXML) 
								lineaXML = "</Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
							
							
							//Fin - Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "</PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
					//Fin - Id
					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
				


									
			//Fin - Identificación del acreedor				
			SetNull(lineaXML) 
			lineaXML = "</CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 										
										
										
										
										
			//Información de la operación de adeudo directo [1..N]
			//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			SetNull(lineaXML) 
			lineaXML = "<DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "<PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//Identificación de la instrucción OPTIONAL
					
					//Identificación de extremo a extremo													//??????
					//Identificación única asignada por la parte iniciadora para identificar inequívocamente cada operación (AT-10). Esta referencia se transmite de extremo a extremo, sin cambios, a lo largo de toda la cadena de pago.
					SetNull(lineaXML) 	
					SetNull(linea)
					referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") +"/"+ dw_1.Object.factura[i] +"/"+ String(Dec(dw_1.Object.recibo[i]),"00")
					linea = referencia_adeudo
					lineaXML = "<EndToEndId>" + linea +  "</EndToEndId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 35 ) then
							messagebox('Error', "Operación de Adeudo Directo - Identificación de extremo a extremo : Longitud no puede ser > 35 " + linea)
							b_error = true
					end if
					
				//Fin - Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "</PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Importe ordenado
				//Importe del adeudo directo expresado en euros (AT-06)
				SetNull(lineaXML) 	
				SetNull(linea)				
				linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
				moneda = 'EUR'//f_moneda_iso(String(dw_1.object.monedas[i]))
					//Atributo Ccy (moneda) es obligatorio
				lineaXML = "<InstdAmt Ccy='" + moneda + "'" + ">" + linea +  "</InstdAmt>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 13 ) then //12 + separador decimal = 13
						messagebox('Error', "Operación de Adeudo Directo - Importe ordenado: Longitud no puede ser > 12 " + linea)
						b_error = true
				end if
				
				SetNull(lineaXML) 
				lineaXML = "<DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
				SetNull(lineaXML) 
				lineaXML = "<MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_cuenta_genter(codigo_empresa,"C",ls_cliente)//Referencia del mandato
					lineaXML = "<MndtId>" + linea +  "</MndtId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 20 ) then
							messagebox('Error', "Referencia del mandato > 20 " + linea)
							b_error = true
					end if
					
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  "2009-10-31"//Fecha del mandato
					lineaXML = "<DtOfSgntr>" + linea +  "</DtOfSgntr>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 10 ) then
							messagebox('Error', "Fecha del mandato > 10 " + linea)
							b_error = true
					end if					
					
				SetNull(lineaXML) 
				lineaXML = "</MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				

				SetNull(lineaXML) 
				lineaXML = "</DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
								
				//Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
						
						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "<FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						
						If cab.naci_extra = 'E' then
							//BIC del cliente
							SetNull(lineaXML) 
							lineaXML = "<BIC>"+ f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)+"</BIC>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
						else
							//Nuevo 29-03-2016 indicado por Bankia
							SetNull(lineaXML) 	
							lineaXML = "<Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
	
								SetNull(lineaXML) 	
								lineaXML = "<Id>NOTPROVIDED</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 														
	
							SetNull(lineaXML) 	
							lineaXML = "</Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
							//Fin de nuevo 29-03-2016 indicado por Bankia																					
						end if

						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "</FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
				
				//Fin - Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Deudor
				SetNull(lineaXML) 
				lineaXML = "<Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
					//Nombre
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
					f_tratar_texto(linea)
					lineaXML = "<Nm>" + linea +  "</Nm>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 70 ) then
							messagebox('Error', "Deudor - Nombre : Longitud no puede ser > 70" + linea)
							b_error = true
					end if
					
				//Fin - Deudor
				SetNull(lineaXML) 
				lineaXML = "</Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
					
				//Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//Identificación
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML					
					
						//IBAN
						SetNull(lineaXML) 	
						SetNull(linea)
						linea = f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
						if is_naci_extra = 'N' then
							if not(f_chequear_iban(linea,ls_iban_correcto)) then
								if messagebox("IBAN Incorrecto",f_razon_genter(codigo_empresa,'C',ls_cliente)+"~nIncorrecto : "+linea+"~nCorrecto : "+ls_iban_correcto+"~n¿Desea sustituir en IBAN incorrecto por el calculado?",Question!,YesNo!,1) = 1 then
									linea = ls_iban_correcto
									messagebox("Sustituido!","Debe modificar la domiciliación del cliente con el IBAN correcto.")
								end if
							end if
						end if
						
						lineaXML = "<IBAN>" + linea +  "</IBAN>"						
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						if (len( linea ) > 34 ) then
								messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
								b_error = true
						end if

					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
				
				
				//Fin - Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
				
				//Información del remitente
				SetNull(lineaXML) 
				lineaXML = "<RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML								
				
					//Información no estructurada
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_nombre_empresa(codigo_empresa)+" Fra "+dw_1.object.factura[i]+" de fecha "+string(dw_1.object.ffra[i],"dd/mm/yyyy")+" vto "+string(dw_1.object.fvto[i],"dd/mm/yyyy")+" "+f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')+"Eur"
					f_tratar_texto(linea)
					lineaXML = "<Ustrd>" + linea +  "</Ustrd>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 140 ) then
							messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
							b_error = true
					end if				
				
				//Fin de información del remitente
				SetNull(lineaXML) 
				lineaXML = "</RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML												
					
//								//BIC
//								SetNull(lineaXML) 	
//								SetNull(linea)
//								linea =  f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
//								lineaXML = "<BIC>" + linea +  "</BIC>"						
//								pos = dw_core_b2b.InsertRow(0) 
//								dw_core_b2b.Object.linea[pos] = lineaXML
//								if (len( linea ) > 11 ) then
//										messagebox('Error', "Entidad del deudor - BIC : Longitud no puede ser > 11 " + linea)
//										b_error = true
//								end if
							

			
			//Información de la operación de adeudo directo
			SetNull(lineaXML) 
			lineaXML = "</DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			
			
	SetNull(lineaXML) 
	lineaXML = "</PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
	
	
	
next

//Fin - Información del pago
//---------------------------------------------------------------------------------------------------------------------



//Pie - Cierre etiqueta Raíz
SetNull(lineaXML) 
lineaXML = "</CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "</Document>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

string fichero
int res 

fichero = "N19CORESEPA" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")+".XML"

fichero = em_directorio.text + "\" + fichero

if dw_core_b2b.rowcount() > 0 then
	res = dw_core_b2b.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if b_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

destroy dw_core_b2b
end subroutine

public subroutine f_grabo_disquete_19_sepa_b2b_xml (str_carremesas cab);//---------------------------------------------------------------------------------------------------------------------
//ADEUDOS DIRECTOS SEPA:
//---------------------------------------------------------------------------------------------------------------------

String lineaXML, linea, ls_cliente, ls_domiciliacion , v_mandato, idAcreedor, moneda,ls_cif_empresa,ls_pais_empresa
long pos
boolean b_error,lb_carefectos_es_frst
string sufijo,referencia_adeudo,nombre_fichero,ls_sufijo_mensajeid,ls_iban_correcto
datetime ldt_fecha_cobro,ldt_fecha_alta
datastore dw_core_b2b

f_cargar_cursor_transaccion(sqlca,dw_core_b2b,'select space(500) as linea from empresas where 0 = 1')

dw_core_b2b.SetTransObject(SQLCA) 
dw_core_b2b.Reset()

ldt_fecha_alta = datetime(today(),now())

ls_sufijo_mensajeid = ""
ls_sufijo_mensajeid += string(year(date(ldt_fecha_alta)),"0000")
ls_sufijo_mensajeid += string(month(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(day(date(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(hour(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(minute(time(ldt_fecha_alta)),"00")
ls_sufijo_mensajeid += string(second(time(ldt_fecha_alta)),"00")	

/*
seleccionamos Los datos de la empresa
*/

SELECT empresas.cif,	
		 empresas.pais 
INTO   :ls_cif_empresa,
		 :ls_pais_empresa 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

if isnull(ls_cif_empresa) then ls_cif_empresa = ''
if isnull(ls_pais_empresa) then ls_pais_empresa = ''

//Raíz
//---------------------------------------------------------------------------------------------------------------------
// xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'

SetNull(lineaXML) 
lineaXML = "<?xml version='1.0' encoding='utf-8'?>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Cabecera
//---------------------------------------------------------------------------------------------------------------------

SetNull(lineaXML) 
lineaXML = "<GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

				//Identificación del mensaje
				//Referencia asignada por la parte iniciadora y enviada a la siguiente parte de la cadena para identificar el mensaje de forma inequívoca
				//Identificador del acreedor en la entidad bancaria a la que se remite:

						//ES (código país) + 13 (dígitos control) + sufijo + NIF


						//Cada entidad bancaria tiene un sufijo diferente para el mismo cliente,
						//por lo que reemplazamos el sufijo de la consulta por el que le toca según el banco
					
				SetNull(lineaXML) 
				idAcreedor = f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)
				linea = idAcreedor+ls_sufijo_mensajeid
				//Si la remesa es al descuento se añade el prefijo FSDD al identificador del mensaje
				if cab.tiporem = '1' then
					linea = 'FSDD'+linea
				end if
				lineaXML = "<MsgId>" + linea + "</MsgId>" 											
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if ( len( linea ) < 1 or len( linea ) > 35 ) then
						messagebox('Error', "Identificación del mensaje: Longitud debe estar entre 1 y  35 " + linea)
						b_error = true
				end if
				
				
				
				SetNull(lineaXML) 
				linea = string(today(),'yyyy-mm-dd')+'T'+string(now(),'hh:mm:ss') //f_obtener_iso_datetime(datetime(today(),now()))
				lineaXML = "<CreDtTm>" + linea +  "</CreDtTm>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 19 ) then
						messagebox('Error', "Fecha y hora de creación: Longitud no puede ser > 19 " + linea)
						b_error = true
				end if
				
				
				SetNull(lineaXML) 
				integer numOperaciones
				numOperaciones = dw_1.RowCount()
				linea = String(numOperaciones)
				lineaXML = "<NbOfTxs>" + linea +  "</NbOfTxs>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Número de operaciones: Longitud no puede ser > 15")
						b_error = true
				end if
						
				SetNull(lineaXML) 
				dec ctrlsum
				ctrlsum = dec(dw_1.describe('evaluate("sum(importe for all)",1)'))
				linea = f_sustituir(String(ctrlsum,'#########0.00'),',','.')
				lineaXML = "<CtrlSum>" + linea +  "</CtrlSum>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				if (len( linea ) > 15 ) then
						messagebox('Error', "Control Sum: Longitud no puede ser > 15")
						b_error = true
				end if						
						
				SetNull(lineaXML) 	
				lineaXML = "<InitgPty>" 							
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
								
								SetNull(lineaXML) 
								linea = f_nombre_empresa(codigo_empresa)
								f_tratar_texto(linea)
								lineaXML = "<Nm>" + linea + "</Nm>"									
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								if (len( linea ) > 70 ) then
									messagebox('Error', "Nombre de la Parte Iniciadora: Longitud no puede ser > 70")
									b_error = true
								end if
								
								
								SetNull(lineaXML) 	
								lineaXML = "<Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
											
											SetNull(lineaXML) 	
											lineaXML = "<OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 

												SetNull(lineaXML) 	
												lineaXML = "<Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 
														
														
														SetNull(lineaXML) 	
														linea =  idAcreedor //ls_cif_empresa
														lineaXML = "<Id>" + linea + "</Id>"//"<BICOrBEI>" + linea + "</BICOrBEI>"										
														pos = dw_core_b2b.InsertRow(0) 
														dw_core_b2b.Object.linea[pos] = lineaXML 
														if (len( linea ) > 35 ) then
															//messagebox('Error', "BIC o BEI de la parte identificadora: Longitud no puede ser > 11")
															messagebox('Error', "Id de la parte identificadora: Longitud no puede ser > 35")
															b_error = true
														end if
														
												SetNull(lineaXML) 	
												lineaXML = "</Othr>" 							
												pos = dw_core_b2b.InsertRow(0) 
												dw_core_b2b.Object.linea[pos] = lineaXML 														
																									
											SetNull(lineaXML)
											SetNull(linea) 
											lineaXML = "</OrgId>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 
											
											// Persona Física
											
//											f_obtener_persona_fisica()
								
								
								
								SetNull(lineaXML) 	
								lineaXML = "</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				
				SetNull(lineaXML) 	
				lineaXML = "</InitgPty>" 								
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				
				


SetNull(lineaXML) 
lineaXML = "</GrpHdr>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

//Fin-Cabecera
//---------------------------------------------------------------------------------------------------------------------

//*********************************************************************************************************************
//Información del pago
//---------------------------------------------------------------------------------------------------------------------
//*********************************************************************************************************************

//Para cada pago repetir

int i

for i = 1 to dw_1.RowCount()
	ls_cliente       = dw_1.object.cliente[i]
	ls_domiciliacion = dw_1.object.domiciliacion[i]
	ldt_fecha_cobro  = dw_1.object.fvto[i]
	
	lb_carefectos_es_frst = f_carefectos_es_frst(codigo_empresa,dw_1.object.anyo[i],dw_1.object.orden[i])
	
	//Información del pago
	SetNull(lineaXML) 
	lineaXML = "<PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
		//Identificación de la información del pago
		//Referencia única, asignada por el presentador, para identificar inequívocamente el bloque de información del pago dentro del mensaje
		
			//Utilizamos código factura: codigo
			
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = dw_1.object.factura[i]
		lineaXML = "<PmtInfId>" + linea + "</PmtInfId>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 35 ) then
			messagebox('Error', "Identificación de la información de pago : Longitud no puede ser > 35" + lineaXML)
			b_error = true
		end if
		
		//Método de pago: DD
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<PmtMtd>DD</PmtMtd>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Método de pago : Longitud no puede ser > 2" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<NbOfTxs>1</NbOfTxs>" //1 Efecto por referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 2 ) then
			messagebox('Error', "Efectos por referencia > 2" + lineaXML)
			b_error = true
		end if

		SetNull(lineaXML) 	
		SetNull(linea) 
		linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
		lineaXML = "<CtrlSum>"+linea+"</CtrlSum>" //Importe efecto referencia
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 15 ) then
			messagebox('Error', "Importe efecto referencia > 15" + lineaXML)
			b_error = true
		end if
		
		SetNull(lineaXML) 	
		lineaXML = "<PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>SEPA</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</SvcLvl>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "<Cd>B2B</Cd>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</LclInstrm>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		if lb_carefectos_es_frst then
			lineaXML = "<SeqTp>FRST</SeqTp>"
		else
			lineaXML = "<SeqTp>RCUR</SeqTp>"
		end if	
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		SetNull(lineaXML) 	
		lineaXML = "</PmtTpInf>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 

		//Fecha de cobro
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = String(ldt_fecha_cobro, "yyyy-mm-dd")//f_iso_date_con_guiones(datetime(date(String(dw_1.object.fvto[i], "yyyy-mm-dd"))))
		lineaXML = "<ReqdColltnDt>" + linea +  "</ReqdColltnDt>"						
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML
		if (len( linea ) > 10 ) then
				messagebox('Error', "Fecha de cobro: Longitud no puede ser > 8" + lineaXML)
				b_error = true
		end if
			

		//Acreedor
		SetNull(lineaXML) 
		lineaXML = "<Cdtr>"
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Nombre
				SetNull(lineaXML) 
				SetNull(linea)
				linea =  f_nombre_empresa(codigo_empresa)
				f_tratar_texto(linea)
				lineaXML = "<Nm>" + linea +  "</Nm>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 70 ) then
						messagebox('Error', "Acreedor - Nombre: Longitud no puede ser > 70 " + linea)
						b_error = true
				end if
								
			//Fin - Acreedor
			SetNull(lineaXML) 
			lineaXML = "</Cdtr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
						
			//Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			
				//Identificación
				SetNull(lineaXML) 
				lineaXML = "<Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//IBAN
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_carbancos_codigo_iban(codigo_empresa, em_banco.text)
					lineaXML = "<IBAN>" + linea +  "</IBAN>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 34 ) then
							messagebox('Error', "Cuenta Acreedor IBAN : Longitud no puede ser > 34 " + linea)
							b_error = true
					end if
				
				//Fin - Identificación
				SetNull(lineaXML) 
				lineaXML = "</Id>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
			
			// Fin -Cuenta del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			//Moneda - OPCIONAL
			
			//Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "<CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "<FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//BIC
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_carbancos_codigo_swift(codigo_empresa, em_banco.text)
					lineaXML = "<BIC>" + linea +  "</BIC>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 11 ) then
							messagebox('Error', "Entidad del Acreedor - BIC: Longitud no puede ser > 11" + linea)
							b_error = true
					end if
					
				
				
				//Fin = Identificación de la entidad
				SetNull(lineaXML) 
				lineaXML = "</FinInstnId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
				
			
			//Fin - Entidad del Acreedor
			SetNull(lineaXML) 
			lineaXML = "</CdtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			SetNull(lineaXML) 
			lineaXML = "<ChrgBr>SLEV</ChrgBr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			//************************************************************************************************************
			//Identificación del acreedor
					//ESte campo debe estar en este apartado o en el bloque de "Información de la operación de adeudo directo"
			SetNull(lineaXML) 
			lineaXML = "<CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

					
					//Id
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
							//Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "<PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
							
							
								//Otra						
								SetNull(lineaXML) 
								lineaXML = "<Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
										//Id
										SetNull(lineaXML) 	
										SetNull(linea)
										linea = idAcreedor
										lineaXML = "<Id>" + linea +  "</Id>"						
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML
										if (len( linea ) > 35 ) then
													messagebox('Error', "Operación de Adeudo Directo - Identificación del acreedor (Identificación): Longitud no puede ser > 35 " + linea)
													b_error = true
										end if																				
								
										//Nuevo 29-03-2016 indicado por Bankia
										SetNull(lineaXML) 	
										lineaXML = "<SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														

											SetNull(lineaXML) 	
											lineaXML = "<Prtry>SEPA</Prtry>" 							
											pos = dw_core_b2b.InsertRow(0) 
											dw_core_b2b.Object.linea[pos] = lineaXML 														

										SetNull(lineaXML) 	
										lineaXML = "</SchmeNm>" 							
										pos = dw_core_b2b.InsertRow(0) 
										dw_core_b2b.Object.linea[pos] = lineaXML 														
										//Fin de nuevo 29-03-2016 indicado por Bankia																						
								
								//Fin - Otra						
								SetNull(lineaXML) 
								lineaXML = "</Othr>"
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 
								
							
							
							//Fin - Identificación Privada
							SetNull(lineaXML) 
							lineaXML = "</PrvtId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 
					
					
					//Fin - Id
					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
				


									
			//Fin - Identificación del acreedor				
			SetNull(lineaXML) 
			lineaXML = "</CdtrSchmeId>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 										
										
										
										
										
			//Información de la operación de adeudo directo [1..N]
			//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			SetNull(lineaXML) 
			lineaXML = "<DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
				//Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "<PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
					//Identificación de la instrucción OPTIONAL
					
					//Identificación de extremo a extremo													//??????
					//Identificación única asignada por la parte iniciadora para identificar inequívocamente cada operación (AT-10). Esta referencia se transmite de extremo a extremo, sin cambios, a lo largo de toda la cadena de pago.
					SetNull(lineaXML) 	
					SetNull(linea)
					referencia_adeudo =  String(Dec(dw_1.Object.anyofra[i]),"0000") +"/"+ dw_1.Object.factura[i] +"/"+ String(Dec(dw_1.Object.recibo[i]),"00")
					linea = referencia_adeudo
					lineaXML = "<EndToEndId>" + linea +  "</EndToEndId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 35 ) then
							messagebox('Error', "Operación de Adeudo Directo - Identificación de extremo a extremo : Longitud no puede ser > 35 " + linea)
							b_error = true
					end if
					
				//Fin - Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "</PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Importe ordenado
				//Importe del adeudo directo expresado en euros (AT-06)
				SetNull(lineaXML) 	
				SetNull(linea)				
				linea =  f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')
				moneda = 'EUR'//f_moneda_iso(String(dw_1.object.monedas[i]))
					//Atributo Ccy (moneda) es obligatorio
				lineaXML = "<InstdAmt Ccy='" + moneda + "'" + ">" + linea +  "</InstdAmt>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 13 ) then //12 + separador decimal = 13
						messagebox('Error', "Operación de Adeudo Directo - Importe ordenado: Longitud no puede ser > 12 " + linea)
						b_error = true
				end if
				
				SetNull(lineaXML) 
				lineaXML = "<DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
				SetNull(lineaXML) 
				lineaXML = "<MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
				
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_cuenta_genter(codigo_empresa,"C",ls_cliente)//Referencia del mandato
					lineaXML = "<MndtId>" + linea +  "</MndtId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 20 ) then
							messagebox('Error', "Referencia del mandato > 20 " + linea)
							b_error = true
					end if
					
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  "2009-10-31"//Fecha del mandato
					lineaXML = "<DtOfSgntr>" + linea +  "</DtOfSgntr>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 10 ) then
							messagebox('Error', "Fecha del mandato > 10 " + linea)
							b_error = true
					end if					
					
				SetNull(lineaXML) 
				lineaXML = "</MndtRltdInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				

				SetNull(lineaXML) 
				lineaXML = "</DrctDbtTx>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 				
								
				//Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
						
						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "<FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						
						If cab.naci_extra = 'E' then
							//BIC del cliente
							SetNull(lineaXML) 
							lineaXML = "<BIC>"+ f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)+"</BIC>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
						else
							//Nuevo 29-03-2016 indicado por Bankia
							SetNull(lineaXML) 	
							lineaXML = "<Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
	
								SetNull(lineaXML) 	
								lineaXML = "<Id>NOTPROVIDED</Id>" 							
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML 														
	
							SetNull(lineaXML) 	
							lineaXML = "</Othr>" 							
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 														
							//Fin de nuevo 29-03-2016 indicado por Bankia																					
						end if

						//Identificación de la entidad
						SetNull(lineaXML) 
						lineaXML = "</FinInstnId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
				
				//Fin - Entidad del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAgt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
				//Deudor
				SetNull(lineaXML) 
				lineaXML = "<Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
					//Nombre
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i])
					f_tratar_texto(linea)
					lineaXML = "<Nm>" + linea +  "</Nm>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 70 ) then
							messagebox('Error', "Deudor - Nombre : Longitud no puede ser > 70" + linea)
							b_error = true
					end if
					
				//Fin - Deudor
				SetNull(lineaXML) 
				lineaXML = "</Dbtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
					
				//Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "<DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				
					//Identificación
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML					
					
						//IBAN
						SetNull(lineaXML) 	
						SetNull(linea)
						linea = f_vendomiciliacion_codigo_iban(codigo_empresa,ls_cliente,ls_domiciliacion)
						if is_naci_extra = 'N' then
							if not(f_chequear_iban(linea,ls_iban_correcto)) then
								if messagebox("IBAN Incorrecto",f_razon_genter(codigo_empresa,'C',ls_cliente)+"~nIncorrecto : "+linea+"~nCorrecto : "+ls_iban_correcto+"~n¿Desea sustituir en IBAN incorrecto por el calculado?",Question!,YesNo!,1) = 1 then
									linea = ls_iban_correcto
									messagebox("Sustituido!","Debe modificar la domiciliación del cliente con el IBAN correcto.")
								end if
							end if
						end if
						
						lineaXML = "<IBAN>" + linea +  "</IBAN>"						
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						if (len( linea ) > 34 ) then
								messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
								b_error = true
						end if

					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
				
				
				//Fin - Cuenta del deudor
				SetNull(lineaXML) 
				lineaXML = "</DbtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
				
				//Información del remitente
				SetNull(lineaXML) 
				lineaXML = "<RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML								
				
					//Información no estructurada
					SetNull(lineaXML) 	
					SetNull(linea)
					linea = f_nombre_empresa(codigo_empresa)+" Fra "+dw_1.object.factura[i]+" de fecha "+string(dw_1.object.ffra[i],"dd/mm/yyyy")+" vto "+string(dw_1.object.fvto[i],"dd/mm/yyyy")+" "+f_sustituir(String(dw_1.object.importe[i], "########0.00"),',','.')+"Eur"
					f_tratar_texto(linea)
					lineaXML = "<Ustrd>" + linea +  "</Ustrd>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 140 ) then
							messagebox('Error', "Cuenta del Deudor - IBAN : Longitud no puede ser > 34" + linea)
							b_error = true
					end if				
				
				//Fin de información del remitente
				SetNull(lineaXML) 
				lineaXML = "</RmtInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML												
					
//								//BIC
//								SetNull(lineaXML) 	
//								SetNull(linea)
//								linea =  f_vendomiciliacion_codigo_swift(codigo_empresa,ls_cliente,ls_domiciliacion)
//								lineaXML = "<BIC>" + linea +  "</BIC>"						
//								pos = dw_core_b2b.InsertRow(0) 
//								dw_core_b2b.Object.linea[pos] = lineaXML
//								if (len( linea ) > 11 ) then
//										messagebox('Error', "Entidad del deudor - BIC : Longitud no puede ser > 11 " + linea)
//										b_error = true
//								end if
							

			
			//Información de la operación de adeudo directo
			SetNull(lineaXML) 
			lineaXML = "</DrctDbtTxInf>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			
			
	SetNull(lineaXML) 
	lineaXML = "</PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
	
	
	
next

//Fin - Información del pago
//---------------------------------------------------------------------------------------------------------------------



//Pie - Cierre etiqueta Raíz
SetNull(lineaXML) 
lineaXML = "</CstmrDrctDbtInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "</Document>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

string fichero
int res 

fichero = "N19B2BSEPA" + String(Dec(cab.banco),"00") + String(cab.remesa,"000")+".XML"

fichero = em_directorio.text + "\" + fichero

if dw_core_b2b.rowcount() > 0 then
	res = dw_core_b2b.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if b_error then
			f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
		end if	
	end if	
end if

destroy dw_core_b2b
end subroutine

public subroutine f_grabo_disquete_lcr ();//------------------------------------------------------------------------------------------------------------------------------
//INFORMACIÓN GENERAL

//La longitud de los registros del fichero es de 157 caracteres. Excepto la de cabecera que tiene 153

//1 registro de cabecera y 2 registros de detalle por cada efecto. El segundo registro es opcional
//Todos los caracteres serán ASCII
//Todos los campos no obligatorios que no vengan informados deben ser inicializados con espacios
	//si se trata de campos alfanuméricos o ceros si están definidios como numéricos


//Hasta completar el tamaño de cada campo, los valores se completarán con espacios a la derecha
	//si son alfanuméricos. En el caso de numéricos, el campo se completará con ceros a la izquierda
	
	//Los campos que contengan una fecha serán definidos como numéricos de 8 posiciones: ddmmaaaa
//-------------------------------------------------------------------------------------------------------------------------------

String linea, iban_presentador, nombre_presentador, nombre_fichero, tipo_remesa, nombre_banco
String hoy, idFichero, hora, oficina_receptora, idRemesa, nombre_cliente, consultivo, financiacion, iban_cliente
boolean b_error
long pos
integer i
time ahora
date fecha_proceso, fecha_vto

String importe
Dec total_importes

iban_presentador = f_iban_banco(codigo_empresa, em_banco.text)

if iban_presentador = '' then
	messagebox("Error", "IBAN DEL PRESENTADOR VACÍO")
	b_error = true
end if

if cbx_consultivo.checked then 
	consultivo = 'S'
else
	consultivo = 'N'
end if

if cbx_financiacion.checked then 
	financiacion = 'S'
else
	financiacion = 'N'
end if

linea = ''

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de cabecera 
	//Tipo remesa: LCR 76, 78, 80, 82
	//Tipo Registro: 001
//-------------------------------------------------------------------------------------------------------------------------------

dw_disquete.SetTransObject(SQLCA)
dw_disquete.Reset()

tipo_remesa = ""//f_tipo_Remesa(consultivo, financiacion)

linea = linea + tipo_remesa 																									//Tipo Remesa
linea = linea + '01'																												//Tipo registro
linea = linea + 'EUR'																											//Divisa Remesa


linea = linea + right(iban_presentador, len(iban_presentador) - 4)												//CCC Sociedad


fecha_proceso = today() //Fecha proceso sólo son válidas fechas entre [hoy y (hoy + 60)] . La comprobación sobra porque siempre será correcta

if fecha_proceso < today() or fecha_proceso > RelativeDate(today(), 60) then
	b_error = true
	messagebox("Error", "La fecha de proceso no es válida. Debe estar entre " + string(today(), 'dd/m/yy') + ' y ' + string(RelativeDate(today(), 60), 'dd/mm/yy'))
else
	linea = linea + string(fecha_proceso, 'ddmmyyyy')
end if
//

linea = linea + consultivo																										//Consultivo S/N
linea = linea + financiacion																									//Financiación S/N

linea = linea + Space(8) //Libre

//Divisa financiación. Sólo se informa si el campo Financiación = 'S'
/*if financiacion = 'S' then*/
	linea = linea + 'EUR'
/*else
	linea = linea + Space(3)
end if*/



linea = linea + ""//f_rellena_ceros(string(dw_1.RowCount()), 6) //Número efectos. Longitud: 6

total_importes = Dec("0.00")

for i = 1 to dw_1.RowCount()
	if dw_1.Object.libre[i] = 'S' then
		total_importes += dw_1.Object.importe[i]
	end if
next


linea = linea + string(total_importes*100,"0000000000000000")//Importe total. 14+2

linea = linea + ""//f_rellena_espacios(f_nombre_empresa(codigo_empresa), 31)//Nombre sociedad ord. Longitud 31

linea = linea + Space(52)

						

if len(linea) <> 153 then
	messagebox("Error", "Cabecera - Longitud " + String(len(linea)) + " <> 153 ")
	b_error = true
end if

pos = dw_disquete.InsertRow(0) 
dw_disquete.Object.linea[pos] = linea


//NOTA: cada efecto es un adeudo, no agrupo por fecha

for i = 1 to dw_1.RowCount()

	if dw_1.Object.libre[i] = 'S' then
		//-------------------------------------------------------------------------------------------------------------------------------
		//Registro de detalle LCR
			//Tipo REgistro: 02
		//-------------------------------------------------------------------------------------------------------------------------------
		linea = ''
		
		linea = tipo_remesa																											//Tipo Remesa
		linea = linea + '02'																											//Tipo Registro
		linea = linea + 'EUR' 																										//Divisa
		
		
		//Ojo. Hay clientes que no tienen ibank y sólo tienen cuenta
		iban_cliente = ""//f_quitar_espacios(f_iban_domiciliacion(codigo_empresa, long(dw_1.object.cliente[i])))
		
		iban_cliente = right(iban_cliente, len(iban_cliente) - 4)
		
		linea = linea + ""//f_rellena_espacios(iban_cliente, 23) 																//RIB Cliente. Longitud 23
		
		nombre_cliente = f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i]) 							//Nombre Cliente
		
		
		
		/*
		OJO con la longitud de nombre cliente  y banco cliente.
		SEgún el pdf debe ser tamaño 31, pero así no me coincide el total a 157.
		Para que el total sea 157, estos dos campos deben tener tamaño 35
		
		*/
		
		
		
		if len(nombre_cliente) > 35 then
			messagebox("Error", "Registro de detalle LCR - Nombre del cliente - linea " + String(i) + ": Longitud " + String(len(nombre_cliente)) + " > 35 ")
			b_error = true
			//Cortamos hasta 35
			linea = linea + left(nombre_cliente, 35)
		else
			linea += nombre_cliente
			linea = linea + Space( 35 - len(nombre_cliente) )
		end if
	
		nombre_banco = ""//f_nombrebanco_domiciliacion(codigo_empresa, long(dw_1.object.cliente[i]))
	
		//Nombre Banco
		if len(nombre_banco) > 35 then
			messagebox("Error", "Registro de detalle LCR - Nombre del banco - linea " + String(i) + ": Longitud " + String(len(nombre_banco)) + " > 35 ")
			b_error = true
			//Cortamos hasta 35
			linea += left(nombre_banco, 35)
		else
			linea += nombre_banco
			linea = linea + Space( 35 - len(nombre_banco) )
		end if
	
		linea = linea + Space(16)
		
	
		//Número Factura
		//Hay que controlar longitud porque para facturas agrupadas es más largo de lo normal
		string aux2, aux3
		if len(string(dw_1.object.factura[i]))>10 then
			aux2 = string(dw_1.object.factura[i])
			aux3 = left(f_reemplazar(aux2, '/', ''), 10)
			linea = linea + aux3
			messagebox("Atención", "Longitud de número de factura demasiado larga:" + aux2 + "~nSe ha acotado a: " + aux3)
		else
			linea = linea +  ""//f_rellena_ceros(string(dw_1.object.factura[i]),10)
		end if
		
	
		linea = linea +  String(dw_1.object.ffra[i], 'ddmmyyyy')	//Fecha Factura
		importe = String(Dec(dw_1.Object.importe[i])*100,"00000000000000")
		linea = linea + importe//Importe Factura
			
		fecha_vto = date(dw_1.object.fvto[i]) //FEcha vto. Ha de ser posterior a la fecha de proceso + 15 días
			
		if fecha_vto <= RelativeDate(fecha_proceso, 15) then
				linea += Space(8)
				b_error = true
				messagebox("Error!", "La fecha de vto debe ser posterior a la fecha de proceso más 15 días - Linea " + string(i))
		else
			linea = linea + string(fecha_vto, 'ddmmyyyy')			
		end if
		
		
		linea = linea + 'N' //Aceptado S/N
	
		
		if len(linea) <> 157 then
			messagebox("Error", "Detalle de LCR - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 157 ")
			b_error = true
		end if
		
		pos = dw_disquete.InsertRow(0) 
		dw_disquete.Object.linea[pos] = linea
		
	end if

next

idRemesa = em_remesa.text
nombre_fichero = "REM" + ""//f_rellena_ceros(em_banco.text,3) + f_rellena_ceros(idRemesa,3)+ "_LCR.TXT"
nombre_fichero = em_directorio.text + "LCR\" + nombre_fichero

dw_disquete.SaveAs(nombre_fichero, TEXT!, FALSE)


if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 
end subroutine

public subroutine f_grabo_disquete_riba ();//------------------------------------------------------------------------------------------------------------------------------
//INFORMACIÓN GENERAL  - RIBA

//La longitud de los registros del fichero es de 157 caracteres. Excepto la de cabecera que tiene 153

//1 registro de cabecera y 2 registros de detalle por cada efecto. El segundo registro es opcional
//Todos los caracteres serán ASCII
//Todos los campos no obligatorios que no vengan informados deben ser inicializados con espacios
	//si se trata de campos alfanuméricos o ceros si están definidios como numéricos


//Hasta completar el tamaño de cada campo, los valores se completarán con espacios a la derecha
	//si son alfanuméricos. En el caso de numéricos, el campo se completará con ceros a la izquierda
	
	//Los campos que contengan una fecha serán definidos como numéricos de 8 posiciones: ddmmaaaa
//-------------------------------------------------------------------------------------------------------------------------------

String linea, iban_presentador, nombre_presentador, nombre_fichero, tipo_remesa, nombre_banco, aux, nif, poblacion_cliente, cp_cliente
String hoy, idFichero, hora, oficina_receptora, idRemesa, nombre_cliente, consultivo, financiacion, iban_cliente, direccion_cliente
boolean b_error
long pos
integer i
time ahora
date fecha_proceso, fecha_vto

String fecha_cobro, referencia_adeudo, mandato, tipo_adeudo, importe, fecha_mandato, entidad_deudor, nombre_deudor,cuenta_deudor
Dec total_importes


iban_presentador = f_iban_banco(codigo_empresa, em_banco.text)

if iban_presentador = '' then
	messagebox("Error", "IBAN DEL PRESENTADOR VACÍO")
	b_error = true
end if

if cbx_consultivo.checked then 
	consultivo = 'S'
else
	consultivo = 'N'
end if


if cbx_financiacion.checked then 
	financiacion = 'S'
else
	financiacion = 'N'
end if

linea = ''

//-------------------------------------------------------------------------------------------------------------------------------
//Registro de cabecera 
	//Tipo remesa: RIBA 77, 79, 81, 83
	//Tipo Registro: 001
//-------------------------------------------------------------------------------------------------------------------------------

dw_disquete.SetTransObject(SQLCA)
dw_disquete.Reset()

tipo_remesa = ""//f_tipo_Remesa_riba(consultivo, financiacion)

linea = linea + tipo_remesa 																									//Tipo Remesa
linea = linea + '01'																												//Tipo registro
linea = linea + 'EUR'																											//Divisa Remesa


linea = linea + right(iban_presentador, len(iban_presentador) - 4)												//CCC Sociedad


fecha_proceso = today() //Fecha proceso sólo son válidas fechas entre [hoy y (hoy + 60)] . La comprobación sobra porque siempre será correcta

if fecha_proceso < today() or fecha_proceso > RelativeDate(today(), 60) then
	b_error = true
	messagebox("Error", "La fecha de proceso no es válida. Debe estar entre " + string(today(), 'dd/m/yy') + ' y ' + string(RelativeDate(today(), 60), 'dd/mm/yy'))
else
	linea = linea + string(fecha_proceso, 'ddmmyyyy')
end if
//

linea = linea + consultivo																										//Consultivo S/N
linea = linea + financiacion																									//Financiación S/N

linea = linea + Space(8) //Libre

//Divisa financiación. Sólo se informa si el campo Financiación = 'S'
/*if financiacion = 'S' then*/
	linea = linea + 'EUR'
/*else
	linea = linea + Space(3)
end if*/



linea = linea + ""//f_rellena_ceros(string(dw_1.RowCount()), 6) //Número efectos. Longitud: 6

total_importes = Dec("0.00")

for i = 1 to dw_1.RowCount()
	if dw_1.Object.libre[i] = 'S' then
		total_importes += dw_1.Object.importe[i]
	end if
	
next


linea = linea + string(total_importes*100,"0000000000000000")//Importe total. 14+2

linea = linea + ""//f_rellena_espacios(f_nombre_empresa(codigo_empresa), 31)//Nombre sociedad ord. Longitud 31

linea = linea + Space(52)

						

if len(linea) <> 153 then
	messagebox("Error", "Cabecera - Longitud " + String(len(linea)) + "<> 153 ")
	b_error = true
end if

pos = dw_disquete.InsertRow(0) 
dw_disquete.Object.linea[pos] = linea


//NOTA: cada efecto es un adeudo, no agrupo por fecha

for i = 1 to dw_1.RowCount()

	if dw_1.Object.libre[i] = 'S' then
	
		//-------------------------------------------------------------------------------------------------------------------------------
		//Registro de detalle RIBA
			//Tipo REgistro: 02
		//-------------------------------------------------------------------------------------------------------------------------------
		linea = ''
		
		linea = tipo_remesa																											//Tipo Remesa
		linea = linea + '02'																											//Tipo Registro
		linea = linea + 'EUR' 																										//Divisa
		
		
		
		iban_cliente = ""//f_quitar_espacios(f_iban_domiciliacion(codigo_empresa, long(dw_1.object.cliente[i])))
		
		aux = right(iban_cliente, len(iban_cliente) - 5)
		
		if aux = '' then
			linea += Space(5)
		else
			linea = linea + left(aux, 5) 																								//ABI (banco) cliente
		end if
		
	
		
		aux = right(aux, len(aux) - 5)
		
		if aux = '' then
			linea += Space(5)
		else
			linea = linea + left(aux, 5)																								//CAB cliente
		end if
		
	
		
		
		linea = linea + Space(13)
		
		nombre_cliente = f_nombre_cliente(codigo_empresa, "C", dw_1.object.cliente[i]) 							//Nombre Cliente
		
		/*
		OJO con la longitud de nombre cliente  y banco cliente.
		SEgún el pdf debe ser tamaño 31, pero así no me coincide el total a 157.
		Para que el total sea 157, estos dos campos deben tener tamaño 35
		Pero al pasar al subir el archivo a la web, da un error. Dice que el tamaño debe ser 30.
		Después de consultarlo a la oficina me dicen que pruebe con 30 de alfanuméricos + 5 espacios
		PArece ser que esto sólo pasa en RIBA
		*/
		
	
		if len(nombre_cliente) > 30 then
			messagebox("Error", "Registro de detalle RIBA - Nombre del cliente - linea " + String(i) + ": Longitud " + String(len(nombre_cliente)) + " > 30 ")
			b_error = true
			//Cortamos hasta 30
			linea += left(nombre_cliente, 30)
			linea += Space(5)
		else
			linea += nombre_cliente
			linea = linea + Space( 35 - len(nombre_cliente) )
		end if
	
	
		nombre_banco = ""//f_nombrebanco_domiciliacion(codigo_empresa, long(dw_1.object.cliente[i]))
	
		//Nombre Banco
		if len(nombre_banco) > 30 then
			messagebox("Error", "Registro de detalle RIBA - Nombre del banco - linea " + String(i) + ": Longitud " + String(len(nombre_banco)) + " > 30 ")
			b_error = true
			//Cortamos hasta 30
			linea += left(nombre_banco, 30)
			linea += Space(5)
		else
			linea += nombre_banco
			linea = linea + Space( 35 - len(nombre_banco) )
		end if
	
	 
		nif = ""//f_nif_genter(codigo_empresa, "C", dw_1.object.cliente[i])
		
		if pos(nif, 'IT') > 0 then
			nif = replace(nif, pos(nif, 'IT'), 2, '')
		end if
		
		if pos(nif, '-') > 0 then
			nif = replace(nif, pos(nif, '-'), 1, '')
		end if
		
		linea = linea + ""//f_rellena_espacios(nif, 16)																			//Código Fiscal Sin IT
		
		//Número Factura
		//Hay que controlar longitud porque para facturas agrupadas es más largo de lo normal
		string aux2, aux3
		if len(string(dw_1.object.factura[i]))>10 then
			aux2 = string(dw_1.object.factura[i])
			aux3 = left(f_reemplazar(aux2, '/', ''), 10)
			linea = linea + aux3
			messagebox("Atención", "Longitud de número de factura demasiado larga:" + aux2 + "~nSe ha acotado a: " + aux3)
		else
			linea = linea +  ""//f_rellena_ceros(string(dw_1.object.factura[i]),10)
		end if
		
		
		linea = linea +  String(dw_1.object.ffra[i], 'ddmmyyyy')															//Fecha Factura
		importe = String(Dec(dw_1.Object.importe[i])*100,"00000000000000")
		linea = linea + importe																										//Importe Factura
			
		fecha_vto = date(dw_1.object.fvto[i]) 																					//FEcha vto. Ha de ser posterior a la fecha de proceso + 15 días
			
		if fecha_vto <= RelativeDate(fecha_proceso, 20) then
				linea += Space(8)
				b_error = true
				messagebox("Error!", "La fecha de vto debe ser posterior a la fecha de proceso más 20 días - Linea " + string(i))
		else
			linea = linea + string(fecha_vto, 'ddmmyyyy')			
		end if
		
		
		linea = linea + Space(1) //Libre 
		
		if len(linea) <> 157 then
			messagebox("Error", "Detalle de RIBA - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 157 ")
			b_error = true
		end if
		
		pos = dw_disquete.InsertRow(0) 
		dw_disquete.Object.linea[pos] = linea
		
		
		//-------------------------------------------------------------------------------------------------------------------------------
		//Registro de detalle RIBA
			//Tipo Registro: 03
		//-------------------------------------------------------------------------------------------------------------------------------
		linea = ''
		
		linea = tipo_remesa																											//Tipo Remesa
		linea = linea + '03'																											//Tipo Registro
		
		
		/*
		OJO con el tamaño de registro que a lo mejor es 30 + 5 espacios como el nombre y dirección
		*/
		
		//Dirección cliente
		direccion_cliente = f_domicilio_genter(codigo_empresa, "C", dw_1.object.cliente[i])
		if len(direccion_cliente) > 35 then
			messagebox("Error", "Registro de detalle RIBA - Dirección del cliente - linea " + String(i) + ": Longitud " + String(len(direccion_cliente)) + " > 35 ")
			b_error = true
			//Cortamos hasta 35
			linea += left(direccion_cliente, 35)
		else
			linea += direccion_cliente
			linea = linea + Space( 35 - len(direccion_cliente) )
		end if
		
		
		//Población cliente
		poblacion_cliente = f_localidad_genter(codigo_empresa, "C", dw_1.object.cliente[i])
		if len(poblacion_cliente) > 35 then
			messagebox("Error", "Registro de detalle RIBA - Población del cliente - linea " + String(i) + ": Longitud " + String(len(poblacion_cliente)) + " > 35 ")
			b_error = true
			//Cortamos
			linea += left(poblacion_cliente, 35)
		else
			linea += poblacion_cliente
			linea = linea + Space( 35 - len(poblacion_cliente) )
		end if
		
		//Código Postal cliente
		cp_cliente = ""//f_genter_codpostal(codigo_empresa, "C", dw_1.object.cliente[i])
		if len(cp_cliente) > 5 then
			messagebox("Error", "Registro de detalle RIBA - Código Postal del cliente - linea " + String(i) + ": Longitud " + String(len(cp_cliente)) + " > 5 ")
			b_error = true
			linea += Space(5)
		else
			linea += cp_cliente
			linea = linea + Space( 5 - len(cp_cliente) )
		end if
		
		
		linea = linea + Space(78)
		
		
		pos = dw_disquete.InsertRow(0) 
		dw_disquete.Object.linea[pos] = linea
			
		
		if len(linea) <> 157 then
			messagebox("Error", "Detalle II de RIBA - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 157 ")
			b_error = true
		end if
		
	end if

next

idRemesa = em_remesa.text
nombre_fichero = "REM" + ""//f_rellena_ceros(em_banco.text,3) + f_rellena_ceros(idRemesa,3)+ "_RIBA.TXT"
nombre_fichero = em_directorio.text + "RIBA\" + nombre_fichero

dw_disquete.SaveAs(nombre_fichero, TEXT!, FALSE)

if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 
end subroutine

public subroutine f_grabo_disquete_ribalcr ();Integer li_indice_registros,li_registros,li_numero_total_efectos,li_indice_disquete,li_paises_remesa
boolean hay_error = false

string  ls_banco,ls_remesa
integer li_anyo_remesa

string ls_sel,ls_registro

//Remesa electronica de exportacion LCR/RIBA (Francia,Italia,Andorra)
string ls_cliente,ls_domiciliacion,ls_factura
int    li_anyo_factura
dec    ld_importe,ld_importe_todos_efectos = 0
datetime ldt_fecha_factura,ldt_fecha_vencimiento

str_genter lstr_genter		
str_vendomiciliacion lstr_vendomiciliacion

//Registro cabecera
string ls_codigo_registro,ls_contrato_cedente,ls_fecha_creacion,ls_referencia_archivo,ls_domiciliacion_pais,ls_divisa_efectos
string ls_codigo_estadistico_balanza_pagos,ls_solicitud_anticipo,ls_libre
				  
//Registro datos generales
string ls_numero_orden_efecto,ls_referencia_cliente_para_efecto,ls_tipo_efecto,ls_fecha_vencimiento_efecto
string ls_importe_parte_entera,ls_importe_parte_decimal,ls_indicador_aceptacion,ls_concepto_estadistico_balanza_pagos
string ls_numero_factura,ls_fecha_factura

//Registro datos librado
string ls_codigo_identificacion_librado,ls_tipo_formato_cuenta_librado,ls_numero_cuenta_librado,ls_nombre_librado
string ls_domicilio_librado_direccion,ls_domicilio_librado_poblacion,ls_domicilio_librado_provincia
string ls_codigo_swift_entidad,ls_nombre_entidad,ls_domicilio_entidad_direccion,ls_domicilio_entidad_poblacion,ls_domicilio_entidad_provincia_cp

//Registro confeccion recibo (Solo Andorra)
string linea1_texto_recibo,linea2_texto_recibo,linea3_texto_recibo,linea4_texto_recibo
			
//Registro de totales
string ls_numero_total_efectos,ls_importe_todos_efectos_parte_entera,ls_importe_todos_efectos_parte_decimal
				  
datastore ds_disquete

ls_sel = "select space(348) as registro where 0 = 1"

f_cargar_cursor_transaccion(sqlca,ds_disquete,ls_sel)

ls_banco       = em_banco.text
li_anyo_remesa = integer(em_anyorem.text)
ls_remesa      = em_remesa.text

//Datos para el registro de cabecera

select isnull(carbancos.contrato_cedente_rem_exp,''),
		 isnull(carbancos.codigo_estadistico_bal_pag,'')
into   :ls_contrato_cedente,
		 :ls_codigo_estadistico_balanza_pagos
from   carbancos
where  carbancos.empresa = :codigo_empresa
and    carbancos.banco   = :em_banco.text;

SELECT count(distinct(paises.codigo_iso)) 
INTO   :li_paises_remesa
FROM   carefectos,   
		 genter,   
		 carremesas,   
		 paises  
WHERE ( genter.empresa         = carefectos.empresa ) 
AND   ( genter.codigo          = carefectos.cliente ) 
AND   ( carefectos.empresa     = carremesas.empresa ) 
AND   ( carefectos.banco       = carremesas.banco ) 
AND   ( carefectos.remesa      = carremesas.remesa ) 
AND   ( carefectos.anyo_remesa = carremesas.anyo ) 
AND   ( carefectos.nacional    = ( case when carremesas.naci_extra = 'E' then 'N' else 'S' end ) )
AND   ( paises.pais            = genter.pais ) 
AND ( ( genter.tipoter         = 'C' ) 
AND   ( carremesas.empresa     = :codigo_empresa ) 
AND   ( carremesas.banco       = :ls_banco ) 
AND   ( carremesas.anyo        = :li_anyo_remesa ) 
AND   ( carremesas.remesa      = :ls_remesa ) 
AND   ( carremesas.naci_extra  = 'E' ) );

if li_paises_remesa = 1 then
	SELECT paises.codigo_iso  
	INTO   :ls_domiciliacion_pais  
	FROM   carefectos,   
			 genter,   
			 carremesas,   
			 paises  
	WHERE ( genter.empresa         = carefectos.empresa ) 
	AND   ( genter.codigo          = carefectos.cliente ) 
	AND   ( carefectos.empresa     = carremesas.empresa ) 
	AND   ( carefectos.banco       = carremesas.banco ) 
	AND   ( carefectos.remesa      = carremesas.remesa ) 
	AND   ( carefectos.anyo_remesa = carremesas.anyo ) 
	AND   ( carefectos.nacional    = ( case when carremesas.naci_extra = 'E' then 'N' else 'S' end ) )
	AND   ( paises.pais            = genter.pais ) 
	AND ( ( genter.tipoter         = 'C' ) 
	AND   ( carremesas.empresa     = :codigo_empresa ) 
	AND   ( carremesas.banco       = :ls_banco ) 
	AND   ( carremesas.anyo        = :li_anyo_remesa ) 
	AND   ( carremesas.remesa      = :ls_remesa ) 
	AND   ( carremesas.naci_extra  = 'E' ) );
	
	if ls_domiciliacion_pais <> "AD" and ls_domiciliacion_pais <> "FR" and ls_domiciliacion_pais <> "IT" then
		messagebox("¡Error!","No se puede generar una remesa RIBA/LCR de pais distinto a Andorra,Francia o Italia")
		hay_error = true			
	end if
else
	//Error remesa de varios paises
	messagebox("¡Error!","No se puede generar una remesa RIBA/LCR de mas de un pais")
	hay_error = true	
	
	ls_domiciliacion_pais = "  "
end if

//Registro cabecera
ls_codigo_registro                  = "10"
ls_contrato_cedente                 = f_relleno_espacios(ls_contrato_cedente,15)
ls_fecha_creacion                   = string(year(today()),"0000")+string(month(today()),"00")+string(day(today()),"00")
ls_referencia_archivo               = em_banco.text+em_anyorem.text+em_remesa.text+space(16 - len(em_banco.text+em_anyorem.text+em_remesa.text))
//ls_domiciliacion_pais               = "" //AD Andorra, FR Francia , IT Italia
ls_divisa_efectos                   = "EUR"
ls_codigo_estadistico_balanza_pagos = f_relleno_espacios(ls_codigo_estadistico_balanza_pagos,6)
if cbx_financiacion.checked then
	ls_solicitud_anticipo                 = "S"
else
	ls_solicitud_anticipo                 = "N"
end if
ls_libre                            = space(295)

ls_registro = ls_codigo_registro+&
				  ls_contrato_cedente+&
				  ls_fecha_creacion+&
				  ls_referencia_archivo+&
				  ls_domiciliacion_pais+&
				  ls_divisa_efectos+&
				  ls_codigo_estadistico_balanza_pagos+&
				  ls_solicitud_anticipo+&
				  ls_libre
		
li_indice_disquete = ds_disquete.InsertRow(0)

if len(ls_registro) <> 348 then
	messagebox("¡Error!","Registro cabecera "+string(li_indice_disquete) +" no tiene longitud 348")
	hay_error = true
end if

ds_disquete.Object.registro[li_indice_disquete] = ls_registro		

li_registros = dw_1.rowcount()

for li_indice_registros = 1 to li_registros
	ls_cliente            = dw_1.Object.cliente[li_indice_registros]
	ls_domiciliacion      = dw_1.Object.domiciliacion[li_indice_registros]
	li_anyo_factura       = dw_1.Object.anyofra[li_indice_registros]
	ls_factura            = dw_1.Object.factura[li_indice_registros]
	ld_importe            = dw_1.Object.importe[li_indice_registros]
	
	ld_importe_todos_efectos += ld_importe
	
	ldt_fecha_factura     = dw_1.Object.ffra[li_indice_registros]
	ldt_fecha_vencimiento = dw_1.Object.fvto[li_indice_registros]
	
	if not(f_cargar_str_genter(codigo_empresa,'C',ls_cliente,lstr_genter)) then
		messagebox("¡Error!","Datos de cliente erroneos.~nCodigo Cliente "+ls_cliente)
		hay_error = true
	end if
	f_inicializar_str_genter(lstr_genter)

	if isnull(ls_domiciliacion) then ls_domiciliacion = ""
	
	if trim(ls_domiciliacion) <> "" then
		if not(f_cargar_str_vendomiciliacion(codigo_empresa,ls_cliente,ls_domiciliacion,lstr_vendomiciliacion)) then
			messagebox("¡Error!","Datos de domiciliacion erroneos.~nCodigo Cliente "+ls_cliente+"~nDomiciliacion "+ls_domiciliacion)
			hay_error = true			
		end if
		f_inicializar_str_vendomiciliacion(lstr_vendomiciliacion)
	else
		messagebox("¡Error!","Efecto sin datos de domiciliacion.~nCliente "+lstr_genter.razon)
		hay_error = true
	end if
		
	//Registro datos generales
	ls_codigo_registro                    = "20"
	ls_numero_orden_efecto                = string(li_indice_registros,"0000")
	ls_referencia_cliente_para_efecto     = f_relleno_espacios(ls_factura,35)
	ls_tipo_efecto                        = "" //REC recibos,LET letras y ademas para Francia LCR recibos/letras y BOR billetes a la orden
	if ls_domiciliacion_pais = "FR" then //Asumimos que siempre son recibos
		ls_tipo_efecto                     = "LCR"
	else
		ls_tipo_efecto                     = "REC"
	end if
	ls_fecha_vencimiento_efecto           = string(year(date(ldt_fecha_vencimiento)),"0000")+string(month(date(ldt_fecha_vencimiento)),"00")+string(day(date(ldt_fecha_vencimiento)),"00")
	ls_importe_parte_entera               = left(string(ld_importe,"000000000.00"),9)
	ls_importe_parte_decimal              = right(string(ld_importe,"000000000.00"),2)
	if ls_domiciliacion_pais = "FR" then //Informar unicamente si el pais es francia y de tipo lcr
		ls_indicador_aceptacion            = "N"
	else
		ls_indicador_aceptacion            = " "
	end if
	ls_concepto_estadistico_balanza_pagos = space(6)
	ls_numero_factura                     = f_relleno_espacios(ls_factura,16)
	ls_fecha_factura                      = string(year(date(ldt_fecha_factura)),"0000")+string(month(date(ldt_fecha_factura)),"00")+string(day(date(ldt_fecha_factura)),"00")
	if cbx_financiacion.checked then
		ls_solicitud_anticipo                 = "S"
	else
		ls_solicitud_anticipo                 = "N"
	end if
	ls_libre                              = space(253)
		
	ls_registro = ls_codigo_registro+&
					  ls_numero_orden_efecto+&
					  ls_referencia_cliente_para_efecto+&
					  ls_tipo_efecto+&
					  ls_fecha_vencimiento_efecto+&
					  ls_importe_parte_entera+&
					  ls_importe_parte_decimal+&
					  ls_indicador_aceptacion+&
					  ls_concepto_estadistico_balanza_pagos+&
					  ls_numero_factura+&
					  ls_fecha_factura+&
					  ls_solicitud_anticipo+&
					  ls_libre	
	
	li_indice_disquete = ds_disquete.InsertRow(0)
	
	if len(ls_registro) <> 348 then
		messagebox("¡Error!","Registro datos generales "+string(li_indice_disquete) +" no tiene longitud 348")
		hay_error = true
	end if
	
	ds_disquete.Object.registro[li_indice_disquete] = ls_registro		

	//Registro datos librado
	
	ls_codigo_registro                = "21"
	ls_numero_orden_efecto            = string(li_indice_registros,"0000")
	ls_codigo_identificacion_librado  = f_relleno_espacios(lstr_genter.cif,14)
	ls_tipo_formato_cuenta_librado    = "I" //I iban,N no iban
	ls_numero_cuenta_librado          = f_relleno_espacios(lstr_vendomiciliacion.codigo_iban,35)
	ls_nombre_librado                 = f_relleno_espacios(left(lstr_genter.razon,35),35)
	ls_domicilio_librado_direccion    = trim(lstr_genter.cl_domicilio+" "+lstr_genter.domicilio+" "+lstr_genter.nu_domicilio)
	ls_domicilio_librado_direccion    = f_relleno_espacios(left(ls_domicilio_librado_direccion,35),35)
	ls_domicilio_librado_poblacion    = f_relleno_espacios(lstr_genter.localidad,35)
	ls_domicilio_librado_provincia    = f_relleno_espacios(f_nombre_provincia(lstr_genter.pais,lstr_genter.provincia),35)
	ls_codigo_swift_entidad           = f_relleno_espacios(lstr_vendomiciliacion.codigo_swift,12)
	ls_nombre_entidad                 = space(35)
	ls_domicilio_entidad_direccion    = space(35)
	ls_domicilio_entidad_poblacion    = space(35)
	ls_domicilio_entidad_provincia_cp = space(35) 
	
	ls_registro = ls_codigo_registro+&
					  ls_numero_orden_efecto+&
					  ls_codigo_identificacion_librado+&
					  ls_tipo_formato_cuenta_librado+&
					  ls_numero_cuenta_librado+&
					  ls_nombre_librado+&
					  ls_domicilio_librado_direccion+&
					  ls_domicilio_librado_poblacion+&
					  ls_domicilio_librado_provincia+&
					  ls_codigo_swift_entidad+&
					  ls_nombre_entidad+&
					  ls_domicilio_entidad_direccion+&
					  ls_domicilio_entidad_poblacion+&
					  ls_domicilio_entidad_provincia_cp

	li_indice_disquete = ds_disquete.InsertRow(0)
	
	if len(ls_registro) <> 348 then
		messagebox("¡Error!","Registro datos librado "+string(li_indice_disquete) +" no tiene longitud 348")
		hay_error = true
	end if
	
	ds_disquete.Object.registro[li_indice_disquete] = ls_registro			

	if ls_domiciliacion_pais = "AD" then 
		//Registro confeccion recibo (Solo Andorra)
		
		ls_codigo_registro     = "23"
		ls_numero_orden_efecto = string(li_indice_registros,"0000")
		linea1_texto_recibo    = space(78)
		linea2_texto_recibo    = space(78)
		linea3_texto_recibo    = space(78)
		linea4_texto_recibo    = space(78)
		ls_libre               = space(30)
		
		ls_registro = ls_codigo_registro+&
						  ls_numero_orden_efecto+&
						  linea1_texto_recibo+&
						  linea2_texto_recibo+&
						  linea3_texto_recibo+&
						  linea4_texto_recibo+&
						  ls_libre
		
		li_indice_disquete = ds_disquete.InsertRow(0)
		
		if len(ls_registro) <> 348 then
			messagebox("¡Error!","Registro confeccion recibo "+string(li_indice_disquete) +" no tiene longitud 348")
			hay_error = true
		end if
		
		ds_disquete.Object.registro[li_indice_disquete] = ls_registro				
	end if	
next

//Registro de totales
		
ls_codigo_registro                     = "30"
ls_numero_total_efectos                = string(li_registros,"000000000")
ls_importe_todos_efectos_parte_entera  = left(string(ld_importe_todos_efectos,"000000000.00"),9)
ls_importe_todos_efectos_parte_decimal = right(string(ld_importe_todos_efectos,"000000000.00"),2)
ls_libre                               = space(326)		
		
ls_registro = ls_codigo_registro+&
				  ls_numero_total_efectos+&
				  ls_importe_todos_efectos_parte_entera+&
				  ls_importe_todos_efectos_parte_decimal+&
				  ls_libre				

li_indice_disquete = ds_disquete.InsertRow(0)

if len(ls_registro) <> 348 then
	messagebox("¡Error!","Registro de totales "+string(li_indice_disquete) +" no tiene longitud 348")
	hay_error = true
end if

ds_disquete.Object.registro[li_indice_disquete] = ls_registro			

string fichero
int res 

fichero = "RIBALCR" + String(Dec(ls_banco),"00000") + String(dec(ls_remesa),"000")

fichero = em_directorio.text + "\" + fichero

if ds_disquete.rowcount() > 0 then
	res = ds_disquete.saveas(fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then 
		if hay_error then
			f_mensaje("¡ATENCIÓN!","El fichero se ha grabado con algún error. Corrija los errores.~nNombre del archivo : " + fichero )
		else
			f_mensaje("CORRECTO","La información se ha grabado correctamente.~nNombre del archivo : " + fichero )
		end if	
	end if	
end if

end subroutine

event open;call super::open;

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_recibos.SetTransObject(SQLCA)


em_anyorem.text = string(year(today()))
es_nacional = 'N'
is_naci_extra = 'E'
is_nacional = 'N'

if is_naci_extra = 'N' then
	istr_parametros.s_titulo_ventana="Impresión de Remesas Nacional"
else
	istr_parametros.s_titulo_ventana="Impresión de Remesas Exportacion"
end if
This.title=istr_parametros.s_titulo_ventana

pb_cartas.enabled	= false
pb_recibos.enabled 	=	 false
pb_disquete.enabled 	=	 true

cbx_1.checked = true

str_paramemp em
em = f_paramemp(codigo_empresa)

//em_directorio.text = em.directorio_remesas
//em_directorio.text = "\\AMAZONAS\USUARIOS\ADMINISTRACION\Pedro\REMESAS\"
em_directorio.text = "\\amazonas\USUARIOS\ADMINISTRACION\partunyedo\REMESAS N58-DESDE ABRIL 2014"


end event

on w_impresion_remesas_expor.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_banco=create em_banco
this.st_1=create st_1
this.st_nombre_banco=create st_nombre_banco
this.em_remesa=create em_remesa
this.cb_consulta=create cb_consulta
this.st_fecha=create st_fecha
this.em_anyorem=create em_anyorem
this.st_4=create st_4
this.st_2=create st_2
this.st_3=create st_3
this.st_6=create st_6
this.st_tipodoc=create st_tipodoc
this.pb_cartas=create pb_cartas
this.st_7=create st_7
this.pb_recibos=create pb_recibos
this.dw_remesas=create dw_remesas
this.dw_1=create dw_1
this.st_5=create st_5
this.dw_cartas=create dw_cartas
this.dw_recibos=create dw_recibos
this.cbx_1=create cbx_1
this.st_8=create st_8
this.pb_disquete=create pb_disquete
this.dw_efectos_disq=create dw_efectos_disq
this.dw_disquete=create dw_disquete
this.em_directorio=create em_directorio
this.st_10=create st_10
this.pb_disquete_n32=create pb_disquete_n32
this.pb_2=create pb_2
this.st_11=create st_11
this.pb_3=create pb_3
this.pb_4=create pb_4
this.cbx_consultivo=create cbx_consultivo
this.cbx_financiacion=create cbx_financiacion
this.st_12=create st_12
this.pb_5=create pb_5
this.pb_6=create pb_6
this.st_13=create st_13
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_banco
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_nombre_banco
this.Control[iCurrent+5]=this.em_remesa
this.Control[iCurrent+6]=this.cb_consulta
this.Control[iCurrent+7]=this.st_fecha
this.Control[iCurrent+8]=this.em_anyorem
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_tipodoc
this.Control[iCurrent+14]=this.pb_cartas
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.pb_recibos
this.Control[iCurrent+17]=this.dw_remesas
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.dw_cartas
this.Control[iCurrent+21]=this.dw_recibos
this.Control[iCurrent+22]=this.cbx_1
this.Control[iCurrent+23]=this.st_8
this.Control[iCurrent+24]=this.pb_disquete
this.Control[iCurrent+25]=this.dw_efectos_disq
this.Control[iCurrent+26]=this.dw_disquete
this.Control[iCurrent+27]=this.em_directorio
this.Control[iCurrent+28]=this.st_10
this.Control[iCurrent+29]=this.pb_disquete_n32
this.Control[iCurrent+30]=this.pb_2
this.Control[iCurrent+31]=this.st_11
this.Control[iCurrent+32]=this.pb_3
this.Control[iCurrent+33]=this.pb_4
this.Control[iCurrent+34]=this.cbx_consultivo
this.Control[iCurrent+35]=this.cbx_financiacion
this.Control[iCurrent+36]=this.st_12
this.Control[iCurrent+37]=this.pb_5
this.Control[iCurrent+38]=this.pb_6
this.Control[iCurrent+39]=this.st_13
end on

on w_impresion_remesas_expor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.st_nombre_banco)
destroy(this.em_remesa)
destroy(this.cb_consulta)
destroy(this.st_fecha)
destroy(this.em_anyorem)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_tipodoc)
destroy(this.pb_cartas)
destroy(this.st_7)
destroy(this.pb_recibos)
destroy(this.dw_remesas)
destroy(this.dw_1)
destroy(this.st_5)
destroy(this.dw_cartas)
destroy(this.dw_recibos)
destroy(this.cbx_1)
destroy(this.st_8)
destroy(this.pb_disquete)
destroy(this.dw_efectos_disq)
destroy(this.dw_disquete)
destroy(this.em_directorio)
destroy(this.st_10)
destroy(this.pb_disquete_n32)
destroy(this.pb_2)
destroy(this.st_11)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.cbx_consultivo)
destroy(this.cbx_financiacion)
destroy(this.st_12)
destroy(this.pb_5)
destroy(this.pb_6)
destroy(this.st_13)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_impresion_remesas_expor
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_impresion_remesas_expor
end type

type st_empresa from w_int_con_empresa`st_empresa within w_impresion_remesas_expor
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_impresion_remesas_expor
integer x = 3351
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type em_banco from u_em_campo within w_impresion_remesas_expor
integer x = 23
integer y = 204
integer width = 187
integer taborder = 10
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_1 from statictext within w_impresion_remesas_expor
integer x = 18
integer y = 128
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_impresion_remesas_expor
integer x = 215
integer y = 208
integer width = 818
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_remesa from u_em_campo within w_impresion_remesas_expor
integer x = 1440
integer y = 204
integer width = 398
integer taborder = 30
fontcharset fontcharset = ansi!
long backcolor = 16777215
alignment alignment = center!
end type

event modified;datetime fecha_rem
dec{2} anyo_rem, rem
string tipo_remesa


dw_1.reset()
pb_cartas.enabled = false
pb_recibos.enabled = false

anyo_rem = dec(em_anyorem.text)
tipo_remesa = ""

if em_remesa.text <> "" then
	
	rem = dec(em_remesa.text)
	
	setnull(fecha_rem)
	setnull(tipo_doc)
	setnull(tipo_remesa)
	
	SELECT carremesas.fremesa,carremesas.tipodoc,carremesas.tiporem
	  INTO :fecha_rem,:tipo_doc,:tipo_remesa
	  FROM carremesas
	WHERE carremesas.empresa = :codigo_empresa
	AND	carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND   carremesas.naci_extra = :is_naci_extra
	AND	carremesas.remesa		 = :rem USING SQLCA;
	
	IF SQLCA.SQLCode = 100 THEN
		MessageBox("Impresión de Remesas","No existe la Remesa",Exclamation!)
		em_remesa.text = ""
		f_activar_campo(em_remesa)
	END IF
	
//	if isnull(tipo_doc) then
//		tipo_doc = ""
//		st_tipodoc.text = ""
//	else
		st_tipodoc.text = f_nombre_cartiporem(codigo_empresa,tipo_remesa)	
//	end if

	if isnull(tipo_remesa) or tipo_remesa = "" then
		tipo_remesa = ""
		st_tipodoc.text = ""
	else
		st_tipodoc.text   = trim(f_nombre_cartiporem(codigo_empresa, tipo_remesa ))
	end if
	
	if isnull(fecha_rem) then	
		st_fecha.visible = false	
	else
		st_fecha.visible = true
		st_fecha.text = string(date(fecha_rem))
	end if
	
	cb_consulta.TriggerEvent(clicked!)
		
end if
end event

type cb_consulta from commandbutton within w_impresion_remesas_expor
integer x = 2853
integer y = 128
integer width = 617
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Consultar"
end type

event clicked;int registros
registros = dw_1.retrieve(codigo_empresa,integer(em_anyorem.text),em_banco.text,integer(em_remesa.text),is_nacional)

if registros > 0 then
	
	if tipo_doc = "3" then pb_recibos.enabled = true
	pb_cartas.enabled = true

end if


end event

type st_fecha from statictext within w_impresion_remesas_expor
integer x = 1838
integer y = 204
integer width = 430
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyorem from u_em_campo within w_impresion_remesas_expor
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1038
integer y = 204
integer width = 398
integer taborder = 20
long backcolor = 16777215
alignment alignment = center!
end type

event losefocus;call super::losefocus;IF em_anyorem.text = "" THEN
	f_activar_campo(em_anyorem)
END IF
end event

type st_4 from statictext within w_impresion_remesas_expor
integer x = 1038
integer y = 128
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Año Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_impresion_remesas_expor
integer x = 1440
integer y = 128
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 15780518
string text = "Nº Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF Trim(em_banco.text) = "" THEN f_activar_campo(em_banco)

IF Trim(em_anyorem.text) = "" THEN em_anyorem.SetFocus()

dw_remesas.visible = TRUE

dw_1.reset()

dw_remesas.Retrieve(codigo_empresa,em_banco.text,Dec(em_anyorem.text),is_nacional)
end event

type st_3 from statictext within w_impresion_remesas_expor
integer x = 1833
integer y = 128
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Fecha Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_impresion_remesas_expor
integer x = 2272
integer y = 128
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Tipo Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipodoc from statictext within w_impresion_remesas_expor
integer x = 2277
integer y = 208
integer width = 1179
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_cartas from picturebutton within w_impresion_remesas_expor
integer x = 155
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\imp32.bmp"
string disabledname = "c:\bmp\print.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;String cabecera
cabecera= inputbox("Impresion Remesa","Desea Imprimir cabecera:","N","")
dw_cartas.Reset()
dw_cartas.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text),cabecera,is_nacional)
f_imprimir_datawindow(dw_cartas)

end event

type st_7 from statictext within w_impresion_remesas_expor
boolean visible = false
integer x = 2478
integer y = 700
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Recibos"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_recibos from picturebutton within w_impresion_remesas_expor
boolean visible = false
integer x = 2597
integer y = 808
integer width = 142
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "print!"
string disabledname = "\bmp\print.bmp"
alignment htextalign = left!
end type

event clicked;// Sólo imprimimos recibos
// Si se pulsa preimpreso cambiamos el report

if cbx_1.checked then
	dw_recibos.DataObject = "report_impresion_remesas_preimp"
else
	dw_recibos.DataObject = "report_emision_remesas_norm"
end if
	
dw_recibos.SetTransObject(SQLCA)

dw_recibos.Reset()
dw_recibos.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text))
f_imprimir_datawindow(dw_recibos)

end event

type dw_remesas from datawindow within w_impresion_remesas_expor
boolean visible = false
integer x = 919
integer y = 288
integer width = 1499
integer height = 760
boolean bringtotop = true
string dataobject = "dw_con_simul_remesas2"
boolean livescroll = true
end type

event clicked;String tipodoc

IF row > 0 THEN
	em_remesa.text   	 = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
	st_fecha.visible 	 = true
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
	//tipo_doc				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
	//tipodoc 				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
	st_tipodoc.text 	 = f_nombre_cartipodoc(codigo_empresa,tipodoc)
	dw_remesas.visible = FALSE
	dw_remesas.Reset()
	pb_cartas.enabled  = false
	pb_recibos.enabled = false
	
	IF em_remesa.text <> "" THEN
		cb_consulta.TriggerEvent(clicked!)
	ELSE
		f_activar_campo(em_remesa)
	END IF
END IF
end event

type dw_1 from datawindow within w_impresion_remesas_expor
integer x = 18
integer y = 284
integer width = 3442
integer height = 1600
string dataobject = "dw_impresion_remesas"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_5 from statictext within w_impresion_remesas_expor
integer x = 23
integer y = 1896
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Carta al Banco"
boolean border = true
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_impresion_remesas_expor
boolean visible = false
integer width = 453
integer height = 144
boolean bringtotop = true
string dataobject = "report_simul_remesas"
boolean livescroll = true
end type

type dw_recibos from datawindow within w_impresion_remesas_expor
boolean visible = false
integer x = 507
integer width = 393
integer height = 152
boolean bringtotop = true
string dataobject = "report_impresion_remesas_preimp"
boolean livescroll = true
end type

type cbx_1 from checkbox within w_impresion_remesas_expor
boolean visible = false
integer x = 2446
integer y = 980
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Preimpreso"
end type

type st_8 from statictext within w_impresion_remesas_expor
integer x = 471
integer y = 1896
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Norma 58 €"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_disquete from picturebutton within w_impresion_remesas_expor
integer x = 558
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "    €"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
alignment htextalign = left!
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("GENERACIÓN DE REMESA EN DISQUETE","¿ Desea continuar ?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	f_grabo_disquete(cab)
END IF
end event

type dw_efectos_disq from datawindow within w_impresion_remesas_expor
boolean visible = false
integer x = 1833
integer y = 1016
integer width = 494
integer height = 360
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_efec_disq"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_disquete from datawindow within w_impresion_remesas_expor
boolean visible = false
integer x = 462
integer y = 952
integer width = 1344
integer height = 412
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_disquete"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type em_directorio from u_em_campo within w_impresion_remesas_expor
integer x = 2464
integer y = 1980
integer width = 997
integer taborder = 40
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
end type

event modified;call super::modified;datetime fecha_rem
dec{2} anyo_rem, rem


dw_1.reset()
pb_cartas.enabled = false
pb_recibos.enabled = false

anyo_rem = dec(em_anyorem.text)

if em_remesa.text <> "" then
	
	rem = dec(em_remesa.text)
	
	setnull(fecha_rem)
	setnull(tipo_doc)
	
	SELECT carremesas.fremesa,carremesas.tipodoc INTO :fecha_rem,:tipo_doc
																FROM carremesas
	WHERE carremesas.empresa = :codigo_empresa
	AND	carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND   carremesas.naci_extra = 'N'
	AND	carremesas.remesa		 = :rem USING SQLCA;
	
	IF SQLCA.SQLCode = 100 THEN
		MessageBox("Impresión de Remesas","No existe la Remesa",Exclamation!)
		em_remesa.text = ""
		f_activar_campo(em_remesa)
	END IF
	
	if isnull(tipo_doc) then
		tipo_doc = ""
		st_tipodoc.text = ""
	else
		st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,string(tipo_doc))	
	end if
	
	if isnull(fecha_rem) then	
		st_fecha.visible = false	
	else
		st_fecha.visible = true
		st_fecha.text = string(date(fecha_rem))
	end if
	
	cb_consulta.TriggerEvent(clicked!)
		
end if
end event

type st_10 from statictext within w_impresion_remesas_expor
integer x = 827
integer y = 1896
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Norma 32"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_disquete_n32 from picturebutton within w_impresion_remesas_expor
integer x = 914
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("GENERACIÓN DE REMESA EN DISQUETE","¿ Desea continuar ?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	f_grabo_disquete_n_32(cab)
END IF
end event

type pb_2 from picturebutton within w_impresion_remesas_expor
integer x = 1184
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "COR1"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
long textcolor = 65535
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (SEPA)","¿Desea Continuar?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	//f_grabo_disquete_19(cab)
	
	f_grabo_disquete_19_sepa_xml(cab)
END IF
end event

type st_11 from statictext within w_impresion_remesas_expor
integer x = 1184
integer y = 1896
integer width = 507
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "SEPA XML"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_3 from picturebutton within w_impresion_remesas_expor
integer x = 1349
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CORE"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
long textcolor = 65535
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (SEPA)","¿Desea Continuar?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	//f_grabo_disquete_19(cab)
	
	f_grabo_disquete_19_sepa_core_xml(cab)
END IF
end event

type pb_4 from picturebutton within w_impresion_remesas_expor
integer x = 1518
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "B2B"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
long textcolor = 65535
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (SEPA)","¿Desea Continuar?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	//f_grabo_disquete_19(cab)
	
	f_grabo_disquete_19_sepa_b2b_xml(cab)
END IF
end event

type cbx_consultivo from checkbox within w_impresion_remesas_expor
boolean visible = false
integer x = 1714
integer y = 1988
integer width = 384
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Consultivo"
end type

type cbx_financiacion from checkbox within w_impresion_remesas_expor
integer x = 1714
integer y = 2056
integer width = 384
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Financiacion"
end type

type st_12 from statictext within w_impresion_remesas_expor
integer x = 1696
integer y = 1896
integer width = 763
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "RIBA/LCR"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_5 from picturebutton within w_impresion_remesas_expor
integer x = 2107
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RIBA"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
long textcolor = 65535
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (RIBA)","¿Desea Continuar?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	f_grabo_disquete_ribalcr()
END IF
end event

type pb_6 from picturebutton within w_impresion_remesas_expor
integer x = 2277
integer y = 1972
integer width = 174
integer height = 152
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "LCR"
string picturename = "c:\bmp\disksave.bmp"
string disabledname = "c:\bmp\disksave_no.bmp"
long textcolor = 65535
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (LCR)","¿Desea Continuar?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme     = Dec(em_remesa.text)
	
	SELECT carremesas.empresa,carremesas.anyo,carremesas.banco,
			 carremesas.naci_extra,carremesas.remesa,carremesas.fremesa,
			 carremesas.tipodoc,carremesas.situacion,carremesas.moneda,
			 carremesas.importe,carremesas.divisas,carremesas.totgastos,
			 carremesas.tiporem 
			 INTO :cab.empresa,:cab.anyo,:cab.banco,
			 :cab.naci_extra,:cab.remesa,:cab.fremesa,
			 :cab.tipodoc,:cab.situacion,:cab.moneda,
			 :cab.importe,:cab.divisas,:cab.totgastos,
			 :cab.tiporem 
			 FROM carremesas
	WHERE carremesas.empresa 	= :codigo_empresa
	AND   carremesas.anyo		= :anyo_rem
	AND	carremesas.banco		= :em_banco.text
	AND	carremesas.naci_extra= :is_naci_extra
	AND	carremesas.remesa		= :reme;
	
	f_grabo_disquete_ribalcr()
END IF
end event

type st_13 from statictext within w_impresion_remesas_expor
integer x = 2464
integer y = 1896
integer width = 997
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "DIRECTORIO"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

