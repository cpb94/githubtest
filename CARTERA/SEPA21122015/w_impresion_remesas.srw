$PBExportHeader$w_impresion_remesas_new.srw
$PBExportComments$Impresión Remesas
forward
global type w_impresion_remesas_new from w_int_con_empresa
end type
type pb_1 from upb_salir within w_impresion_remesas_new
end type
type em_banco from u_em_campo within w_impresion_remesas_new
end type
type st_1 from statictext within w_impresion_remesas_new
end type
type st_nombre_banco from statictext within w_impresion_remesas_new
end type
type em_remesa from u_em_campo within w_impresion_remesas_new
end type
type cb_consulta from commandbutton within w_impresion_remesas_new
end type
type st_fecha from statictext within w_impresion_remesas_new
end type
type em_anyorem from u_em_campo within w_impresion_remesas_new
end type
type st_4 from statictext within w_impresion_remesas_new
end type
type st_2 from statictext within w_impresion_remesas_new
end type
type st_3 from statictext within w_impresion_remesas_new
end type
type st_6 from statictext within w_impresion_remesas_new
end type
type st_tipodoc from statictext within w_impresion_remesas_new
end type
type pb_cartas from picturebutton within w_impresion_remesas_new
end type
type st_7 from statictext within w_impresion_remesas_new
end type
type pb_recibos from picturebutton within w_impresion_remesas_new
end type
type dw_remesas from datawindow within w_impresion_remesas_new
end type
type dw_1 from datawindow within w_impresion_remesas_new
end type
type st_5 from statictext within w_impresion_remesas_new
end type
type dw_cartas from datawindow within w_impresion_remesas_new
end type
type dw_recibos from datawindow within w_impresion_remesas_new
end type
type cb_marcar from commandbutton within w_impresion_remesas_new
end type
type cb_desmarcar from commandbutton within w_impresion_remesas_new
end type
type dw_bancaja from datawindow within w_impresion_remesas_new
end type
type dw_2 from datawindow within w_impresion_remesas_new
end type
type dw_disquete from datawindow within w_impresion_remesas_new
end type
type dw_efectos_disq from datawindow within w_impresion_remesas_new
end type
type pb_disquete from picturebutton within w_impresion_remesas_new
end type
type st_8 from statictext within w_impresion_remesas_new
end type
type pb_disquete_19 from picturebutton within w_impresion_remesas_new
end type
type rr_1 from roundrectangle within w_impresion_remesas_new
end type
type st_91 from statictext within w_impresion_remesas_new
end type
type st_92 from statictext within w_impresion_remesas_new
end type
end forward

global type w_impresion_remesas_new from w_int_con_empresa
integer x = 18
integer y = 108
integer width = 2880
integer height = 1592
boolean minbox = true
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
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
dw_bancaja dw_bancaja
dw_2 dw_2
dw_disquete dw_disquete
dw_efectos_disq dw_efectos_disq
pb_disquete pb_disquete
st_8 st_8
pb_disquete_19 pb_disquete_19
rr_1 rr_1
st_91 st_91
st_92 st_92
end type
global w_impresion_remesas_new w_impresion_remesas_new

type variables
string filtro

integer var_ejercicio
string es_nacional
string tipo_remesa
string tipo_doc
end variables

forward prototypes
public subroutine f_grabo_disquete (str_carremesas cab)
public function string f_relleno_ceros (string numero, integer longi)
public subroutine f_grabo_disquete_19 (str_carremesas cab)
public subroutine f_grabo_disquete_19_sepa (str_carremesas cab)
end prototypes

public subroutine f_grabo_disquete (str_carremesas cab);Integer		oky,fila,i,numreg,numregop
String		registro,nomemp,cifemp,cposemp,entidad,oficina,digcontrol,cuenta
String		cli,nomcli,clicta,cliban,clisuc,clidig,codomic
String		poscli,provcli,domcli,locli,referencia,factura, ine
Dec			totimp
Boolean		con_domic = FALSE
string sufijo
boolean errores
string fichero,ruta
int res 

errores = false

dw_disquete.SetTransObject(SQLCA)
dw_efectos_disq.SetTransObject(SQLCA)

dw_disquete.Reset()
dw_efectos_disq.Reset()

SELECT 	empresas.nombre,			empresas.cif_norma_58,
			empresas.codpostal 
INTO 		:nomemp,						:cifemp,
			:cposemp
FROM empresas
WHERE empresas.empresa = :codigo_empresa;


SELECT carbancos.entidad,			carbancos.oficina,
		 carbancos.control,			carbancos.nuestracta,
		 cod_norm_58
INTO   :entidad,						:oficina,
		 :digcontrol,					:cuenta,
		 :sufijo
FROM  carbancos
WHERE carbancos.empresa = :codigo_empresa
AND	carbancos.banco	= :cab.banco;

if entidad = '0081' then
	ine = '999999999'
else
	ine = space(9)
end if

if isnull(sufijo) then sufijo = ""
if trim(sufijo) = "" then sufijo = "000"

if len(sufijo) < 3 then
	sufijo = f_relleno_ceros(sufijo,3)
end if

if isnull(entidad) then entidad      = ""
if isnull(oficina) then oficina      = ""
if isnull(digcontrol) then digcontrol = ""
if isnull(cuenta) then cuenta = ""

entidad = trim(entidad)
oficina = trim(oficina)
digcontrol = trim(digcontrol)
cuenta = trim(cuenta)

if len(entidad) <> 4 then
	errores = true
	messagebox("Error","Código C.C.C. del banco NO válido")
end if

if len(oficina) <> 4 then
	errores = true
	messagebox("Error","Código C.C.C. del banco NO válido")
end if
if len(digcontrol) <> 2 then
	errores = true
	messagebox("Error","Código C.C.C. del banco NO válido")
end if
if len(cuenta) <> 10 then
	errores = true
	messagebox("Error","Código C.C.C. del banco NO válido")
end if


// ------ REGISTRO DE CABECERA (Hay 2) ----------
// ------ Presentador ------------
SetNull(registro)

cifemp = f_relleno_espa(cifemp,9)
if len(cifemp) <> 9 then	
	errores = true
	messagebox("Error","Cif de la empresa con longitud <> 9")
end if


//MODIFICACIONES PARA EL EURO
// LOS REGISTROS COMIENZAN POR 5
//LOS IMPORTES MULTIPLICADOS POR 100

STRING ini = "5"
dec{2} importe




registro = ini + "1" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "

nomemp = f_relleno_espa(nomemp,40)

if len(nomemp) <> 40 then 
	errores = true
	messagebox("Error","Longitud del nombre de la empresa NO válida")
end if

registro = registro + nomemp + Space(20) + entidad + oficina + Space(12)

registro = registro + Space(11) + Space(43)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	errores = true
	messagebox("Error","Registro Cabecera de Presentador de longitud <> 162")
end if

dw_disquete.SetItem(fila,"lini",registro)

// -------------- Ordenante -------------

SetNull(registro)

registro = ini + "3" + "70" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + "      "

cuenta = f_relleno_espa(cuenta,10)

registro = registro + nomemp + entidad + oficina + digcontrol + cuenta

registro = registro + Space(8) + "06" + Space(10) + Space(40) + Space(2) + ine + Space(3)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	errores = true
	messagebox("Error","Registro Cabecera de Ordenante de longitud <> 162 " + string(len(registro)))
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
	registro = ini + "6" + "70" + cifemp + sufijo 
	
	referencia = f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)	
	cli = dw_efectos_disq.Object.cliente[i]
	
	if trim(referencia) = "" then
		referencia = f_cuenta_genter(codigo_empresa,"C",cli)
		referencia = f_relleno_espa(referencia,12)	
	end if
	
	if len(referencia)  <> 12 then
		messagebox("Error","Código de referencia del cliente " + nomcli + " de longitud <> 12")
		errores = true		
	end if
	
	registro = registro + referencia	
	
	SELECT genter.razon,				genter.cod_postal,
			 genter.provincia,		genter.domicilio,
			 genter.localidad 
	INTO 	 :nomcli,					:poscli,
			 :provcli,					:domcli,
			 :locli
   FROM	 genter
	WHERE  genter.empresa = :codigo_empresa
	AND	 genter.tipoter = "C"
	AND	 genter.codigo  = :cli;
	
	if isnull(nomcli) then nomcli = ""
	if isnull(poscli) then poscli = ""
	if isnull(provcli) then provcli = ""	
	if isnull(domcli) then domcli = ""	
	if isnull(locli) then locli = ""
	
	codomic = dw_efectos_disq.Object.domiciliacion[i]
	IF Trim(codomic) <> "" AND	Not IsNull(codomic) THEN
			
			SELECT cuenta,					entidad,
					 oficina,				control
			INTO 	 :clicta,				:cliban,
					 :clisuc,				:clidig
			FROM vendomiciliacion
			WHERE vendomiciliacion.empresa = :codigo_empresa
			AND	vendomiciliacion.cliente = :cli
			AND	vendomiciliacion.codigo  = :codomic;
			
			
			if isnull(clicta) then clicta = ""
			if isnull(cliban) then cliban = ""
			if isnull(clisuc) then clisuc = ""
			if isnull(clidig) then clidig = ""
			
			
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
	
	// La longitud máxima para la razon del cliente es 40
	nomcli = mid(nomcli,1,40)
	registro = registro + f_relleno_espa(nomcli,40)
	
	registro = registro + String(Dec(cliban),"0000")
	registro = registro + String(Dec(clisuc),"0000")
	IF Not con_domic OR IsNull(clidig) THEN
		registro = registro + "00"
	ELSE
		registro = registro + String(Dec(clidig),"00")
	END IF
	
	clicta = f_relleno_espa(clicta,10)
	if len(clicta) <> 10 then
		messagebox("Atención","No es correcta la C.C.C. del cliente : " + nomcli)
		errores = true
	end if	
	
	if len(cliban) <> 4 then
		messagebox("Atención","No es correcta la C.C.C. del cliente : " + nomcli)		
		errores = true
	end if	
	if len(clisuc) <> 4 then
		messagebox("Atención","No es correcta la C.C.C. del cliente : " + nomcli)		
		errores = true
	end if		
	if len(clidig) <> 2 then		
		messagebox("Atención","No es correcta la C.C.C. del cliente : " + nomcli)		
		errores = true
	end if		
	
	registro = registro + clicta
	
	importe  = dw_efectos_disq.Object.importe[i] * 100 // los importes * 100
	registro = registro + String(importe,"0000000000")
	
	registro = registro + Space(6)
	
	registro = registro + String(Dec(dw_efectos_disq.Object.anyo[i]),"0000") + "/" 
	registro = registro + String(Dec(dw_efectos_disq.Object.orden[i]),"00000")
	
	registro = registro + f_relleno_espa(nomcli,40)

	registro = registro + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
	
	registro = registro + space(2)
	
	
	if len(registro) <> 162 then
		errores = true
		messagebox("Error","Registro Obligatorio cliente "+ nomcli  + "de longitud <> 162 ( " + string(len(registro)) + " )")
	end if
	
	
	fila = dw_disquete.InsertRow(0)

	dw_disquete.Object.lini[fila] = registro

	totimp = totimp + importe // acumulamos (ya * 100)
	numreg = numreg + 1
	numregop = numregop + 1
	
	// --------------------- Registro Opcional -----------------------
	
	SetNull(registro)
	registro = ini + "6" + "71" + cifemp + sufijo 
	
	registro = registro + f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)
	string concepto_2,concepto_3
		
	concepto_2 = "VTO. " + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
	// EL IMPORTE EN EUROS (NO SE MULTIPLICA * 100)
	concepto_2 = concepto_2 + " EUROS: " + String(Dec(dw_efectos_disq.Object.importe[i]),"0000000.00") 
	concepto_2 = concepto_2 + " FRA Nro.: "
	
	if len(concepto_2) <> 40 then
		messagebox("Error","Concepto segundo registro 1 opcional <> 40 del cliente "+ nomcli)
		errores = true
	end if
	
	factura = String(Dec(dw_efectos_disq.Object.factura[i]),"000000")
	
	if isnull(factura) then factura = ""
	
	if len(factura) <> 6 then factura = "AGRUPA"
	
	concepto_3 = factura
	
	concepto_3 = concepto_3 +" de Fecha " + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
	concepto_3 = concepto_3 +" Cli.: " + String(Dec(dw_efectos_disq.Object.cliente[i]),"000000")
	concepto_3 = concepto_3 + space(5)	
	
	if len(concepto_3) <> 40 then
		messagebox("Error","Concepto tercero registro 1º opcional <> 40 del cliente ( " + string(len(concepto_3))+" ) "  + nomcli )
		errores = true
	end if
	
	registro = registro + concepto_2 + concepto_3 + Space(40) + space(14)
	
	fila = dw_disquete.InsertRow(0)
	
	if len(registro) <> 162 then
		errores = true
		messagebox("Error","Registro primero opcional del cliente "+ nomcli  + "de longitud <> 162 ( " + string(len(registro)) + " )")
	end if
	
	dw_disquete.Object.lini[fila] = registro

	numregop = numregop + 1
	// ---------- Obligatorio si no hay domiciliacion bancaria ----------
	
	SetNull(registro)
	
	IF Not con_domic THEN
		registro = ini + "6" + "76" + cifemp + sufijo
		registro = registro + f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)
		registro = registro + f_relleno_espa(domcli,40)
		registro = registro + f_relleno_espa(locli,35)
		registro = registro + f_relleno_espa(poscli,5)
		registro = registro + f_relleno_espa(locli,38)
		registro = registro + f_relleno_espa(provcli,2)
		registro = registro + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
		registro = registro + Space(8)
		
		fila = dw_disquete.InsertRow(0)

		dw_disquete.Object.lini[fila] = registro
		
		if len(registro) <> 162 then
			errores = true
			messagebox("Error","Registro Obligatorio de domicilio del cliente "+ nomcli  + "de longitud <> 162")
		end if
		
		
		numregop = numregop + 1

	END IF
	
NEXT

// y por fin, el pie ------------------------------------

SetNull(registro)

registro = ini + "8" + "70" + cifemp + sufijo + Space(72)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numregop + 2,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)


if len(registro) <> 162 then
	errores = true
	messagebox("Error","Registro Total del ordenante de longitud <> 162")
end if
dw_disquete.Object.lini[fila] = registro

// ---------- Total Cliente Ordenante ---------------
SetNull(registro)

registro = ini + "9" + "70" + cifemp + sufijo + Space(52)
registro = registro + "0001" + Space(16)
registro = registro + String(totimp,"0000000000") + Space(6)
registro = registro + String(numreg,"0000000000")
registro = registro + String(numregop + 4,"0000000000")
registro = registro + Space(38)

fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
	errores = true
	messagebox("Error","Registro Total general de longitud <> 162")
end if
dw_disquete.Object.lini[fila] = registro

// Nombre del fichero REMxxxx siendo XXxx el banco y nº remesa

if not errores then

	ruta       = "REM" + String(Dec(cab.banco),"000") + String(cab.remesa,"000")
	if GetFileSaveName("Fichero N48",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
		if dw_disquete.rowcount() > 0 then
			res = dw_disquete.saveas(ruta,text!,false)
			if res = -1 then messagebox("ERROR","Al grabar el fichero")
			if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
		end if		
	end if	
else
	messagebox("Error","Operación cancelada")
end if
end subroutine

public function string f_relleno_ceros (string numero, integer longi);int l,i,k
String	num_s

num_s = String(numero)

l = len(num_s)
k = longi - l

FOR i = 1 TO k
	num_s = "0" + num_s
NEXT

RETURN num_s

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
		 empresas.cif_norma_58,	
		 empresas.codpostal 
INTO   :nomemp,
		 :cifemp,
		 :cposemp 
FROM 	 empresas
WHERE  empresas.empresa = :codigo_empresa;

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

	ruta       = "N190" + string(em_banco.text) + string(integer(cab.remesa),"0000") 
	if GetFileSaveName("Fichero N48",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
		if dw_disquete.rowcount() > 0 then
			res = dw_disquete.saveas(ruta,text!,false)
			if res = -1 then messagebox("ERROR","Al grabar el fichero")
			if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
		end if		
	end if	
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

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Remesas"
This.title=istr_parametros.s_titulo_ventana

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_recibos.SetTransObject(SQLCA)

cb_marcar.visible = FALSE
cb_desmarcar.visible = FALSE

es_nacional = 'S'

pb_cartas.enabled	= false
pb_recibos.enabled 	=	 false

em_anyorem.text = string(year(today()))
end event

on w_impresion_remesas_new.create
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
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
this.dw_bancaja=create dw_bancaja
this.dw_2=create dw_2
this.dw_disquete=create dw_disquete
this.dw_efectos_disq=create dw_efectos_disq
this.pb_disquete=create pb_disquete
this.st_8=create st_8
this.pb_disquete_19=create pb_disquete_19
this.rr_1=create rr_1
this.st_91=create st_91
this.st_92=create st_92
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
this.Control[iCurrent+22]=this.cb_marcar
this.Control[iCurrent+23]=this.cb_desmarcar
this.Control[iCurrent+24]=this.dw_bancaja
this.Control[iCurrent+25]=this.dw_2
this.Control[iCurrent+26]=this.dw_disquete
this.Control[iCurrent+27]=this.dw_efectos_disq
this.Control[iCurrent+28]=this.pb_disquete
this.Control[iCurrent+29]=this.st_8
this.Control[iCurrent+30]=this.pb_disquete_19
this.Control[iCurrent+31]=this.rr_1
this.Control[iCurrent+32]=this.st_91
this.Control[iCurrent+33]=this.st_92
end on

on w_impresion_remesas_new.destroy
call super::destroy
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
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.dw_bancaja)
destroy(this.dw_2)
destroy(this.dw_disquete)
destroy(this.dw_efectos_disq)
destroy(this.pb_disquete)
destroy(this.st_8)
destroy(this.pb_disquete_19)
destroy(this.rr_1)
destroy(this.st_91)
destroy(this.st_92)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_impresion_remesas_new
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_impresion_remesas_new
end type

type st_empresa from w_int_con_empresa`st_empresa within w_impresion_remesas_new
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_impresion_remesas_new
integer x = 2738
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type em_banco from u_em_campo within w_impresion_remesas_new
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

type st_1 from statictext within w_impresion_remesas_new
integer x = 18
integer y = 128
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_impresion_remesas_new
integer x = 215
integer y = 208
integer width = 818
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_remesa from u_em_campo within w_impresion_remesas_new
integer x = 1440
integer y = 204
integer width = 398
integer taborder = 40
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

type cb_consulta from commandbutton within w_impresion_remesas_new
boolean visible = false
integer x = 2482
integer y = 336
integer width = 329
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;int registros
registros = dw_1.retrieve(codigo_empresa,integer(em_anyorem.text),em_banco.text,integer(em_remesa.text),es_nacional)

if registros > 0 then
	
	if tipo_doc = "3" then pb_recibos.enabled = true
	pb_cartas.enabled = true
	cb_marcar.visible= false
	cb_desmarcar.visible= false
end if


end event

type st_fecha from statictext within w_impresion_remesas_new
integer x = 1838
integer y = 204
integer width = 430
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyorem from u_em_campo within w_impresion_remesas_new
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1033
integer y = 204
integer width = 398
integer taborder = 30
long backcolor = 16777215
alignment alignment = center!
end type

event losefocus;call super::losefocus;IF em_anyorem.text = "" THEN
	f_activar_campo(em_anyorem)
END IF
end event

type st_4 from statictext within w_impresion_remesas_new
integer x = 1038
integer y = 128
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Año Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_impresion_remesas_new
integer x = 1440
integer y = 128
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
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

dw_remesas.Retrieve(codigo_empresa,em_banco.text,Dec(em_anyorem.text))
end event

type st_3 from statictext within w_impresion_remesas_new
integer x = 1833
integer y = 128
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Fecha Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_impresion_remesas_new
integer x = 2272
integer y = 128
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Tipo Documento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipodoc from statictext within w_impresion_remesas_new
integer x = 2277
integer y = 208
integer width = 571
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_cartas from picturebutton within w_impresion_remesas_new
integer x = 2551
integer y = 452
integer width = 174
integer height = 152
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\bmp\imp32.bmp"
string disabledname = "\bmp\imp32_no.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;String cabecera
cabecera= inputbox("Impresion Remesa","Desea Imprimir cabecera:","N","")
dw_cartas.Reset()
dw_cartas.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text),cabecera)
f_imprimir_datawindow(dw_cartas)

end event

type st_7 from statictext within w_impresion_remesas_new
integer x = 2464
integer y = 652
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

type pb_recibos from picturebutton within w_impresion_remesas_new
integer x = 2555
integer y = 740
integer width = 174
integer height = 152
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\bmp\imp32.bmp"
string disabledname = "\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;
dw_recibos.Reset()
dw_recibos.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text))
f_imprimir_datawindow(dw_recibos)

end event

type dw_remesas from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 919
integer y = 300
integer width = 1499
integer height = 760
boolean bringtotop = true
string dataobject = "dw_con_simul_remesas2"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;String tipodoc

if row = 0 then return

IF dw_remesas.RowCount() > 0 THEN
	em_remesa.text   	 = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
	st_fecha.visible 	 = true
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
	tipo_doc				 = dw_remesas.GetItemString(row,"tipodoc")
	tipodoc 				 = dw_remesas.GetItemString(row,"tipodoc")
	if isnull(tipo_doc) then
		tipo_doc = ""
		st_tipodoc.text = ""
	else
		st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,string(tipo_doc))	
	end if
	
	
	//st_tipodoc.text 	 = f_nombre_cartipodoc(codigo_empresa,tipodoc)
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

type dw_1 from datawindow within w_impresion_remesas_new
integer x = 23
integer y = 292
integer width = 2400
integer height = 992
string dataobject = "dw_impresion_remesas_new"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_5 from statictext within w_impresion_remesas_new
integer x = 2432
integer y = 372
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
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 5
integer width = 453
integer height = 144
boolean bringtotop = true
string dataobject = "report_simul_remesas"
boolean livescroll = true
end type

type dw_recibos from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 507
integer width = 393
integer height = 156
boolean bringtotop = true
string dataobject = "report_simulacion_remesa1_preimpreso"
boolean livescroll = true
end type

type cb_marcar from commandbutton within w_impresion_remesas_new
boolean visible = false
integer x = 23
integer y = 1284
integer width = 366
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar"
end type

type cb_desmarcar from commandbutton within w_impresion_remesas_new
boolean visible = false
integer x = 393
integer y = 1288
integer width = 366
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desmarcar"
end type

type dw_bancaja from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 983
integer y = 40
integer width = 453
integer height = 144
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_simul_remesas_bancaja"
boolean livescroll = true
end type

type dw_2 from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 2053
integer y = 112
integer width = 494
integer height = 360
integer taborder = 50
string dataobject = "report_remesas_bancaja"
boolean livescroll = true
end type

type dw_disquete from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 320
integer y = 1040
integer width = 494
integer height = 360
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_new_disquete"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_efectos_disq from datawindow within w_impresion_remesas_new
boolean visible = false
integer x = 864
integer y = 1036
integer width = 494
integer height = 360
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_new_efec_disq"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_disquete from picturebutton within w_impresion_remesas_new
integer x = 2473
integer y = 1172
integer width = 165
integer height = 152
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\disksave.bmp"
alignment htextalign = left!
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA SOPORTE MAGNÉTICO (NORMA 58)","¿Desea Continuar?",Question!,YesNo!,1)
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
	AND	carremesas.naci_extra= "N"
	AND	carremesas.remesa		= :reme;		
	
	f_grabo_disquete(cab)
END IF
end event

type st_8 from statictext within w_impresion_remesas_new
integer x = 2459
integer y = 1020
integer width = 379
integer height = 136
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 12632256
boolean enabled = false
string text = "Soporte Magnético €"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_disquete_19 from picturebutton within w_impresion_remesas_new
integer x = 2661
integer y = 1172
integer width = 165
integer height = 152
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\disksave.bmp"
alignment htextalign = left!
end type

event clicked;Dec	anyo_rem,reme
Integer	oky
str_carremesas cab

oky = MessageBox("REMESA EN SOPORTE MAGNÉTICO (NORMA 19)","¿Desea Continuar?",Question!,YesNo!,1)
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
	AND	carremesas.naci_extra= "N"
	AND	carremesas.remesa		= :reme;
	
	f_grabo_disquete_19_sepa(cab)
END IF


end event

type rr_1 from roundrectangle within w_impresion_remesas_new
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 12632256
integer x = 2441
integer y = 984
integer width = 416
integer height = 432
integer cornerheight = 40
integer cornerwidth = 46
end type

type st_91 from statictext within w_impresion_remesas_new
integer x = 2501
integer y = 1332
integer width = 123
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 12632256
boolean enabled = false
string text = "58"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_92 from statictext within w_impresion_remesas_new
integer x = 2688
integer y = 1332
integer width = 123
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 12632256
boolean enabled = false
string text = "19"
alignment alignment = center!
boolean focusrectangle = false
end type
