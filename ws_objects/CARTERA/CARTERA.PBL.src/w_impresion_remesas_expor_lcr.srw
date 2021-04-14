$PBExportHeader$w_impresion_remesas_expor_lcr.srw
forward
global type w_impresion_remesas_expor_lcr from w_int_con_empresa
end type
type pb_1 from upb_salir within w_impresion_remesas_expor_lcr
end type
type em_banco from u_em_campo within w_impresion_remesas_expor_lcr
end type
type st_1 from statictext within w_impresion_remesas_expor_lcr
end type
type st_nombre_banco from statictext within w_impresion_remesas_expor_lcr
end type
type em_remesa from u_em_campo within w_impresion_remesas_expor_lcr
end type
type cb_consulta from commandbutton within w_impresion_remesas_expor_lcr
end type
type st_fecha from statictext within w_impresion_remesas_expor_lcr
end type
type em_anyorem from u_em_campo within w_impresion_remesas_expor_lcr
end type
type st_4 from statictext within w_impresion_remesas_expor_lcr
end type
type st_2 from statictext within w_impresion_remesas_expor_lcr
end type
type st_3 from statictext within w_impresion_remesas_expor_lcr
end type
type st_6 from statictext within w_impresion_remesas_expor_lcr
end type
type st_tipodoc from statictext within w_impresion_remesas_expor_lcr
end type
type pb_cartas from picturebutton within w_impresion_remesas_expor_lcr
end type
type st_7 from statictext within w_impresion_remesas_expor_lcr
end type
type pb_recibos from picturebutton within w_impresion_remesas_expor_lcr
end type
type dw_remesas from datawindow within w_impresion_remesas_expor_lcr
end type
type dw_1 from datawindow within w_impresion_remesas_expor_lcr
end type
type st_5 from statictext within w_impresion_remesas_expor_lcr
end type
type dw_cartas from datawindow within w_impresion_remesas_expor_lcr
end type
type dw_recibos from datawindow within w_impresion_remesas_expor_lcr
end type
type cb_marcar from commandbutton within w_impresion_remesas_expor_lcr
end type
type cb_desmarcar from commandbutton within w_impresion_remesas_expor_lcr
end type
type st_listo_pal_euro from statictext within w_impresion_remesas_expor_lcr
end type
type pb_disquete2 from picturebutton within w_impresion_remesas_expor_lcr
end type
type st_18 from statictext within w_impresion_remesas_expor_lcr
end type
type dw_disquete from datawindow within w_impresion_remesas_expor_lcr
end type
type dw_efectos_disq from datawindow within w_impresion_remesas_expor_lcr
end type
type em_directorio from u_em_campo within w_impresion_remesas_expor_lcr
end type
type st_9 from statictext within w_impresion_remesas_expor_lcr
end type
type dw_lcr from datawindow within w_impresion_remesas_expor_lcr
end type
type cb_lcr_riba from commandbutton within w_impresion_remesas_expor_lcr
end type
type dw_riba from datawindow within w_impresion_remesas_expor_lcr
end type
type cb_1 from commandbutton within w_impresion_remesas_expor_lcr
end type
type cbx_consultivo from checkbox within w_impresion_remesas_expor_lcr
end type
type cbx_financiacion from checkbox within w_impresion_remesas_expor_lcr
end type
type st_ribalcr from statictext within w_impresion_remesas_expor_lcr
end type
type pb_2 from picturebutton within w_impresion_remesas_expor_lcr
end type
type gb_1 from groupbox within w_impresion_remesas_expor_lcr
end type
end forward

global type w_impresion_remesas_expor_lcr from w_int_con_empresa
integer x = 18
integer y = 108
integer width = 3319
integer height = 2008
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
st_listo_pal_euro st_listo_pal_euro
pb_disquete2 pb_disquete2
st_18 st_18
dw_disquete dw_disquete
dw_efectos_disq dw_efectos_disq
em_directorio em_directorio
st_9 st_9
dw_lcr dw_lcr
cb_lcr_riba cb_lcr_riba
dw_riba dw_riba
cb_1 cb_1
cbx_consultivo cbx_consultivo
cbx_financiacion cbx_financiacion
st_ribalcr st_ribalcr
pb_2 pb_2
gb_1 gb_1
end type
global w_impresion_remesas_expor_lcr w_impresion_remesas_expor_lcr

type variables
string filtro

integer var_ejercicio
string es_nacional

string tipo_doc
end variables

forward prototypes
public subroutine f_grabo_disquete_19 (str_carremesas cab)
public function string f_cif (string par_cif)
public function string f_relleno_espacios (string cadena, integer v_longitud)
public subroutine f_grabar_disquete_lcr ()
public function string f_tipo_remesa (string arg_consultivo, string arg_financiacion)
public subroutine f_grabar_disquete_riba ()
public function string f_tipo_remesa_riba (string arg_consultivo, string arg_financiacion)
public subroutine f_grabo_disquete_ribalcr (str_carremesas cab)
end prototypes

public subroutine f_grabo_disquete_19 (str_carremesas cab);Integer oky,fila,i,numreg,numregop
String registro,nomemp,cifemp,cposemp,entidad,oficina,digcontrol,cuenta
String cli,nomcli,clicta,cliban,clisuc,clidig,codomic
String poscli,provcli,domcli,locli
Dec totimp
Boolean con_domic = FALSE
boolean hay_error = false
string sufijo 
//Pakito 27/12/01 Procedo a preparar la norma para que funcione en Euros 
dw_disquete.SetTransObject(SQLCA)
dw_efectos_disq.SetTransObject(SQLCA) 
dw_disquete.Reset()
dw_efectos_disq.Reset() 

SELECT empresas.nombre,empresas.cif,empresas.codpostal 
INTO :nomemp,:cifemp,:cposemp FROM empresas
WHERE empresas.empresa = :codigo_empresa; 

SELECT entidad,
		oficina,
		control,
		nuestracta
INTO :entidad,
		:oficina,
		:digcontrol,
		:cuenta
FROM carbancos
WHERE carbancos.empresa = :codigo_empresa
AND carbancos.banco = :cab.banco; 

choose case cab.banco
	case "24"
		sufijo = "001" /// Bankinter
	case "10"   //bancaja
		sufijo = "001"
	case "1", "16", '12'	//central hispano y la caixa y caja madrid y bbva
		sufijo = "001"	
	case "6"
		sufijo = "007"
	case "7"   //banesto
		sufijo = "001"
	case else
		sufijo = "000"
end choose

// ------ REGISTRO DE CABECERA (Hay 2) ----------
// ------ Presentador ------------
SetNull(registro) 
cifemp = f_cif(cifemp) 
//cifemp=right(cifemp,9)
cifemp = f_relleno_espacios(cifemp,9) 
IF LEN(cifemp) <> 9 then
messagebox("Error","El cif de la empresa tiene longitud <> 9 ")
hay_error = true
end if 
registro = "51" + "80" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + Space(6) 
nomemp = f_relleno_espacios(nomemp,40) 

if len(entidad) <> 4 then
messagebox("Error","El código de la entidad del banco " + &
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
messagebox(string(len(registro)), "* " + registro + " *")
hay_error = true
end if 
dw_disquete.SetItem(fila,"lini",registro) 

// -------------- Ordenante ------------- 

string fcargo

fcargo = string(date(inputbox("INTRODUZCA FECHA CARGO", "CARGO", string(cab.fremesa, "dd-mm-yy"), "ddmmyy")), "ddmmyy")

SetNull(registro) 
registro = "53" + "80" + cifemp + sufijo + String(cab.fremesa,"ddmmyy") + fcargo//String(cab.fremesa,"ddmmyy") 
registro = registro + nomemp + entidad + oficina + digcontrol + cuenta 
registro = registro + Space(8) + "01" + Space(10) + Space(40) 
registro = registro + space(2) + Space(9) +Space(3) 
fila = dw_disquete.InsertRow(0) 
if len(registro) <> 162 then
messagebox("Atención","El registro cabecera de ordenante no tiene longitud 162, tiene "+string(len(registro)))
hay_error = true
end if 
dw_disquete.Object.lini[fila] = registro 

// Ahora vamos a por las lineas del disquete. Una por cada Efecto 
string situacion[1 to 4]

//if cbx_confirmadas.checked then
//	situacion[1] = "1"
//	situacion[2] = "2"
//	situacion[3] = "5"
//	situacion[4] = "6"
//else
	situacion[1] = "1"
	situacion[2] = "6" // GESTION DE COBRO
	situacion[3] = "1"
	situacion[4] = "1"	
//end if

oky = dw_efectos_disq.Retrieve(codigo_empresa,cab.banco,cab.anyo,cab.remesa,cab.fremesa,situacion)

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
registro = "56" + "80" + cifemp + sufijo
registro = registro + f_relleno_espacios(dw_efectos_disq.Object.cuenta[i],12)

cli = dw_efectos_disq.Object.cliente[i]

SELECT genter.razon,genter.cod_postal,genter.provincia,
genter.domicilio,genter.localidad 
INTO :nomcli,:poscli,:provcli,:domcli,:locli FROM genter
WHERE genter.empresa = :codigo_empresa
AND genter.tipoter = "C"
AND genter.codigo = :cli;

string ibank

codomic = dw_efectos_disq.Object.domiciliacion[i]
IF Trim(codomic) <> "" AND Not IsNull(codomic) THEN
SELECT cuenta,entidad,oficina,control, iban INTO :clicta,:cliban,
:clisuc,:clidig, :ibank FROM vendomiciliacion
WHERE vendomiciliacion.empresa = :codigo_empresa
AND vendomiciliacion.cliente = :cli
AND vendomiciliacion.codigo = :codomic;
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

long cont
string resultado = ''

for cont = 1 to len(ibank)
	if mid(ibank, cont, 1) <> " " then
		resultado = resultado + mid(ibank, cont, 1)
	end if
next

ibank = resultado

registro = registro + f_relleno_espacios(nomcli,40)

// iban julio 2012 BEGUIN

registro = registro + ibank
//registro = registro + String(Dec(cliban),"0000")
//registro = registro + String(Dec(clisuc),"0000")
//IF Not con_domic OR IsNull(clidig) THEN
//registro = registro + "00"
//ELSE
//registro = registro + String(Dec(clidig),"00")
//END IF
//
//registro = registro + f_relleno_espacios(clicta,10)


//iban julio 2012 END

//Las cantidades se expresan en centimos
registro = registro + String(Dec(dw_efectos_disq.Object.importe[i]*100),"0000000000")

registro = registro + Space(16)

registro = registro + String(Dec(dw_efectos_disq.Object.anyo[i]),"0000") + "/" 

string str_fac
str_fac=dw_efectos_disq.Object.factura[i]
if dec(str_fac)=0 then
registro = registro + String(Dec(left(str_fac,len(str_fac)-1)),"0000000000")
else
registro = registro + String(Dec(str_fac),"0000000000")
end if

registro = registro + " "+String(dw_efectos_disq.Object.ffra[i],"ddmmyy")+space(18) 
registro = registro + space(2) 
fila = dw_disquete.InsertRow(0)

if len(registro) <> 162 then
messagebox("Atención","El registro obligatorio individual "+string(fila) +" no tiene longitud 162, tiene "+string(len(registro)))
hay_error = true
end if
dw_disquete.Object.lini[fila] = registro 
totimp = totimp + (dw_efectos_disq.Object.importe[i]*100)
numreg = numreg + 1
// numregop = numregop + 1
// 
// // --------------------- Registro Opcional -----------------------
// 
// SetNull(registro)
// registro = "06" + "71" + cifemp + sufijo 
// 
// registro = registro + f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)
// 
// registro = registro + "VTO. " + String(dw_efectos_disq.Object.fvto[i],"ddmmyy")
// registro = registro + " PTAS.: " + String(Dec(dw_efectos_disq.Object.importe[i]),"0000000000")
// registro = registro + " FRA Nro.: " + String(Dec(dw_efectos_disq.Object.factura[i]),"######")
// registro = registro + " de Fecha " + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
// registro = registro + " Cli.: " + String(Dec(dw_efectos_disq.Object.cliente[i]),"000000")
// registro = registro + Space(63)
// 
// fila = dw_disquete.InsertRow(0)
// 
// if len(registro) <> 162 then
// messagebox("Atención","El 1º registro opcional individual "+string(fila) +" no tiene longitud 162, tiene "+ string(len(registro)))
// hay_error = true 
// end if
// 
// dw_disquete.Object.lini[fila] = registro
//
// numregop = numregop + 1
// // ---------- Obligatorio si no hay domiciliacion bancaria ----------
// 
// SetNull(registro)
// 
// IF Not con_domic THEN
// registro = "06" + "76" + cifemp + sufijo
// registro = registro + f_relleno_espa(dw_efectos_disq.Object.cuenta[i],12)
// registro = registro + f_relleno_espa(domcli,40)
// registro = registro + f_relleno_espa(locli,35)
// registro = registro + f_relleno_espa(poscli,5)
// registro = registro + f_relleno_espa(locli,38)
// registro = registro + f_relleno_espa(provcli,2)
// registro = registro + String(Date(dw_efectos_disq.Object.ffra[i]),"ddmmyy")
// registro = registro + Space(8)
// 
// fila = dw_disquete.InsertRow(0)
//
// 
// if len(registro) <> 162 then
// messagebox("Atención","El registro obligatorio de domicilio "+string(fila) +" no tiene longitud 162")
// hay_error = true 
// end if
// 
// dw_disquete.Object.lini[fila] = registro
//
// numregop = numregop + 1
//
// END IF

NEXT 
// y por fin, el pie ------------------------------------ 
SetNull(registro) 
registro = "58" + "80" + cifemp + sufijo + Space(72)
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
registro = "59" + "80" + cifemp + sufijo + Space(52)
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
// Nombre del fichero REMxxxx siendo XXxx el banco y nº remesa 
string fichero
int res 
//fichero = "Recibos" 
fichero = "REM" + String(Dec(cab.banco),"000") + String(cab.remesa,"000")

fichero = em_directorio.text + fichero

if dw_disquete.rowcount() > 0 then
res = dw_disquete.saveas(fichero,text!,false)
if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
if res = 1 then 
if hay_error then
f_mensaje("Atención","El fichero se ha grabado co algún error. Corrija los errores. Nombre del archivo : " + fichero )
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

	if mid(trim(par_cif),l - 1,1) <> "-"  and &
		mid(trim(par_cif),2,1) <> "-"  then
		
		
		if asc(mid(trim(par_cif),1,1)) < 48 and &
			asc(mid(trim(par_cif),1,1)) > 57  then
			tipo = 3
			car_control = mid(trim(par_cif),1,1)
			codigo =  mid(trim(par_cif),2,l - 1)
	
		end if
		
		if asc(mid(trim(par_cif),1,1)) >= 48 and &
			asc(mid(trim(par_cif),1,1)) <= 57 then
			 
			
			tipo = 4
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
if tipo = 3 then return codigo + car_control 
if tipo = 4 then return car_control + codigo

if tipo = 0 then 
	f_mensaje("Error ","Tratando el NIF/CIF "+ par_cif )
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

public subroutine f_grabar_disquete_lcr ();//------------------------------------------------------------------------------------------------------------------------------
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



dw_lcr.SetTransObject(SQLCA)
dw_lcr.Reset()

tipo_remesa = f_tipo_Remesa(consultivo, financiacion)

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

pos = dw_lcr.InsertRow(0) 
dw_lcr.Object.linea[pos] = linea


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
		
		pos = dw_lcr.InsertRow(0) 
		dw_lcr.Object.linea[pos] = linea
		
	end if

next



idRemesa = em_remesa.text
nombre_fichero = "REM" + ""//f_rellena_ceros(em_banco.text,3) + f_rellena_ceros(idRemesa,3)+ "_LCR.TXT"
nombre_fichero = em_directorio.text + "LCR\" + nombre_fichero



dw_lcr.SaveAs(nombre_fichero, TEXT!, FALSE)


if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 
end subroutine

public function string f_tipo_remesa (string arg_consultivo, string arg_financiacion);string resultado

if arg_consultivo = 'N' and arg_financiacion = 'N' then 
	resultado = '76'
	return resultado
end if

if arg_consultivo = 'S' and arg_financiacion = 'N' then 
	resultado = '78'
	return resultado
end if

if arg_consultivo = 'N' and arg_financiacion = 'S' then 
	resultado = '80'
	return resultado
end if

if arg_consultivo = 'S' and arg_financiacion = 'S' then 
	resultado = '82'
	return resultado
end if


return resultado

end function

public subroutine f_grabar_disquete_riba ();//------------------------------------------------------------------------------------------------------------------------------
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



dw_lcr.SetTransObject(SQLCA)
dw_lcr.Reset()

tipo_remesa = f_tipo_Remesa_riba(consultivo, financiacion)

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

pos = dw_lcr.InsertRow(0) 
dw_lcr.Object.linea[pos] = linea


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
		
		pos = dw_lcr.InsertRow(0) 
		dw_lcr.Object.linea[pos] = linea
		
		
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
		
		
		pos = dw_lcr.InsertRow(0) 
		dw_lcr.Object.linea[pos] = linea
			
		
		if len(linea) <> 157 then
			messagebox("Error", "Detalle II de RIBA - linea " + String(i) + ": Longitud " + String(len(linea)) + " <> 157 ")
			b_error = true
		end if
		
	end if

next



idRemesa = em_remesa.text
nombre_fichero = "REM" + ""//f_rellena_ceros(em_banco.text,3) + f_rellena_ceros(idRemesa,3)+ "_RIBA.TXT"
nombre_fichero = em_directorio.text + "RIBA\" + nombre_fichero



dw_lcr.SaveAs(nombre_fichero, TEXT!, FALSE)


if b_error then
	f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo: " + nombre_fichero )
else
	f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo: "  + nombre_fichero )
end if 
end subroutine

public function string f_tipo_remesa_riba (string arg_consultivo, string arg_financiacion);string resultado

if arg_consultivo = 'N' and arg_financiacion = 'N' then 
	resultado = '77'
	return resultado
end if

if arg_consultivo = 'S' and arg_financiacion = 'N' then 
	resultado = '79'
	return resultado
end if

if arg_consultivo = 'N' and arg_financiacion = 'S' then 
	resultado = '81'
	return resultado
end if

if arg_consultivo = 'S' and arg_financiacion = 'S' then 
	resultado = '83'
	return resultado
end if


return resultado

end function

public subroutine f_grabo_disquete_ribalcr (str_carremesas cab);Integer li_indice_registros,li_registros,li_numero_total_efectos,li_indice_disquete,li_paises_remesa
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

ls_sel = "select space(348) as registro"

f_cargar_cursor_transaccion(sqlca,ds_disquete,ls_sel)

ls_banco       = em_banco.text
li_anyo_remesa = integer(em_anyorem.text)
ls_remesa      = em_remesa.text

//Datos para el registro de cabecera
/*
select isnull(carbancos.contrato_cedente_rem_exp,''),
		 isnull(carbancos.codigo_estadistico_bal_pag,'')
into   :ls_contrato_cedente,
		 :ls_codigo_estadistico_balanza_pagos
from   carbancos
where  carbancos.empresa = :codigo_empresa
and    carbancos.banco   = :em_banco.text;
*/


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
ls_contrato_cedente                 = "34"+space(13)
ls_fecha_creacion                   = string(year(today()),"0000")+string(month(today()),"00")+string(day(today()),"00")
ls_referencia_archivo               = em_banco.text+em_anyorem.text+em_remesa.text+space(16 - len(em_banco.text+em_anyorem.text+em_remesa.text))
ls_domiciliacion_pais               = "" //AD Andorra, FR Francia , IT Italia
ls_divisa_efectos                   = "EUR"
ls_codigo_estadistico_balanza_pagos = space(6)
ls_solicitud_anticipo               = "N"
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
	ls_solicitud_anticipo                 = "N"
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
	ls_nombre_librado                 = f_relleno_espacios(lstr_genter.razon,35)
	ls_domicilio_librado_direccion    = f_relleno_espacios(lstr_genter.cl_domicilio+" "+lstr_genter.domicilio+" "+lstr_genter.nu_domicilio,35)
	ls_domicilio_librado_poblacion    = f_relleno_espacios(lstr_genter.localidad,35)
	ls_domicilio_librado_provincia    = f_relleno_espacios(f_nombre_provincia(lstr_genter.pais,lstr_genter.provincia),35)
	ls_codigo_swift_entidad           = f_relleno_espacios(lstr_vendomiciliacion.codigo_swift,35)
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

fichero = "RIBALCR" + String(Dec(cab.banco),"00000") + String(cab.remesa,"000")

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

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Remesas de Exportación"
This.title=istr_parametros.s_titulo_ventana

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_recibos.SetTransObject(SQLCA)

cb_marcar.enabled = FALSE
cb_desmarcar.enabled = FALSE

es_nacional = 'N'

pb_cartas.enabled		= false
pb_recibos.enabled 	= false

em_directorio.text = "C:\REMESAS\"


em_anyorem.text 		= string(today(), 'yyyy')
end event

on w_impresion_remesas_expor_lcr.create
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
this.st_listo_pal_euro=create st_listo_pal_euro
this.pb_disquete2=create pb_disquete2
this.st_18=create st_18
this.dw_disquete=create dw_disquete
this.dw_efectos_disq=create dw_efectos_disq
this.em_directorio=create em_directorio
this.st_9=create st_9
this.dw_lcr=create dw_lcr
this.cb_lcr_riba=create cb_lcr_riba
this.dw_riba=create dw_riba
this.cb_1=create cb_1
this.cbx_consultivo=create cbx_consultivo
this.cbx_financiacion=create cbx_financiacion
this.st_ribalcr=create st_ribalcr
this.pb_2=create pb_2
this.gb_1=create gb_1
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
this.Control[iCurrent+24]=this.st_listo_pal_euro
this.Control[iCurrent+25]=this.pb_disquete2
this.Control[iCurrent+26]=this.st_18
this.Control[iCurrent+27]=this.dw_disquete
this.Control[iCurrent+28]=this.dw_efectos_disq
this.Control[iCurrent+29]=this.em_directorio
this.Control[iCurrent+30]=this.st_9
this.Control[iCurrent+31]=this.dw_lcr
this.Control[iCurrent+32]=this.cb_lcr_riba
this.Control[iCurrent+33]=this.dw_riba
this.Control[iCurrent+34]=this.cb_1
this.Control[iCurrent+35]=this.cbx_consultivo
this.Control[iCurrent+36]=this.cbx_financiacion
this.Control[iCurrent+37]=this.st_ribalcr
this.Control[iCurrent+38]=this.pb_2
this.Control[iCurrent+39]=this.gb_1
end on

on w_impresion_remesas_expor_lcr.destroy
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
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.st_listo_pal_euro)
destroy(this.pb_disquete2)
destroy(this.st_18)
destroy(this.dw_disquete)
destroy(this.dw_efectos_disq)
destroy(this.em_directorio)
destroy(this.st_9)
destroy(this.dw_lcr)
destroy(this.cb_lcr_riba)
destroy(this.dw_riba)
destroy(this.cb_1)
destroy(this.cbx_consultivo)
destroy(this.cbx_financiacion)
destroy(this.st_ribalcr)
destroy(this.pb_2)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_impresion_remesas_expor_lcr
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_impresion_remesas_expor_lcr
end type

type st_empresa from w_int_con_empresa`st_empresa within w_impresion_remesas_expor_lcr
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_impresion_remesas_expor_lcr
integer x = 3081
integer y = 8
integer height = 124
integer taborder = 0
end type

type em_banco from u_em_campo within w_impresion_remesas_expor_lcr
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

type st_1 from statictext within w_impresion_remesas_expor_lcr
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

type st_nombre_banco from statictext within w_impresion_remesas_expor_lcr
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

type em_remesa from u_em_campo within w_impresion_remesas_expor_lcr
integer x = 1440
integer y = 204
integer width = 398
integer taborder = 30
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
	AND   carremesas.naci_extra = 'E'
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

type cb_consulta from commandbutton within w_impresion_remesas_expor_lcr
integer x = 2519
integer y = 336
integer width = 329
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Consultar"
end type

event clicked;Long registros

registros = dw_1.retrieve(codigo_empresa,integer(em_anyorem.text),em_banco.text,integer(em_remesa.text),es_nacional)

IF registros > 0 THEN
	IF tipo_doc = "3" OR tipo_doc = '10' OR tipo_doc = '11' OR &
		tipo_doc = '12' THEN
		pb_recibos.enabled = TRUE
	END IF
	pb_cartas.enabled 	= TRUE
	cb_marcar.enabled 	= TRUE
	cb_desmarcar.enabled = TRUE
END IF


end event

type st_fecha from statictext within w_impresion_remesas_expor_lcr
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

type em_anyorem from u_em_campo within w_impresion_remesas_expor_lcr
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

type st_4 from statictext within w_impresion_remesas_expor_lcr
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

type st_2 from statictext within w_impresion_remesas_expor_lcr
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

dw_remesas.Retrieve(codigo_empresa,em_banco.text,Dec(em_anyorem.text))
end event

type st_3 from statictext within w_impresion_remesas_expor_lcr
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

type st_6 from statictext within w_impresion_remesas_expor_lcr
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
string text = "Tipo Documento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipodoc from statictext within w_impresion_remesas_expor_lcr
integer x = 2277
integer y = 208
integer width = 571
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

type pb_cartas from picturebutton within w_impresion_remesas_expor_lcr
integer x = 2638
integer y = 540
integer width = 183
integer height = 160
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\imp32.bmp"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;String cabecera
long i , result

cabecera= inputbox("Impresion Remesa","Desea Imprimir cabecera:","N","")

/*
oJO, la segunda vez que se imprime la carta no sale nada y no sé por qué
*/

dw_cartas.Reset()
result = dw_cartas.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text),cabecera)


/*
PACO 23-11-18
Se imprimirán sólo los efectos que hemos marcado en el dw dw_1
*/

if dw_1.RowCount() > 0 and dw_Cartas.RowCount() > 0 then
	
	for i = 1 to dw_1.RowCount()
		
		dw_cartas.object.libre[i] = dw_1.object.libre[i]
		
	next
	
	
	dw_cartas.setFilter(" libre = 'S' ")
	dw_cartas.Filter()
	
	
	
end if


/**/



f_imprimir_datawindow(dw_cartas)

end event

type st_7 from statictext within w_impresion_remesas_expor_lcr
integer x = 2537
integer y = 800
integer width = 379
integer height = 56
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

type pb_recibos from picturebutton within w_impresion_remesas_expor_lcr
integer x = 2638
integer y = 860
integer width = 183
integer height = 160
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\imp32.bmp"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;
CHOOSE CASE tipo_doc 
	CASE '3' 
		dw_recibos.DataObject = "report_lcr"	
	CASE '10' 
		dw_recibos.DataObject = "report_lcr"
	CASE '11'
		dw_recibos.DataObject = "report_lcr"
	CASE '12'	
		dw_recibos.DataObject = "report_lcr"
	CASE ELSE
	
END CHOOSE

dw_recibos.SetTransObject(SQLCA)
dw_recibos.Reset()
dw_recibos.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text))
f_imprimir_datawindow(dw_recibos)

end event

type dw_remesas from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 1207
integer y = 288
integer width = 997
integer height = 760
boolean bringtotop = true
string dataobject = "dw_con_impresion_remexp"
boolean livescroll = true
end type

event clicked;String tipodoc

IF dw_remesas.RowCount() > 0 THEN
	em_remesa.text   	 = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
	st_fecha.visible 	 = true
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
	tipo_doc				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
	tipodoc 				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
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

type dw_1 from datawindow within w_impresion_remesas_expor_lcr
integer y = 288
integer width = 2491
integer height = 1156
string dataobject = "dw_impresion_remesas_expor_lcr"
boolean vscrollbar = true
boolean livescroll = true
end type

event rbuttondown;//f_euros_pts(this)
end event

event clicked;
string controles

IF row = 0 Then Return

controles =  This.GetItemString(row,"libre")
IF controles = "S" THEN
  This.SetItem(row,"libre","N")
 ELSE
  This.SetItem(row,"libre","S")
 End If


end event

type st_5 from statictext within w_impresion_remesas_expor_lcr
integer x = 2537
integer y = 484
integer width = 379
integer height = 56
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Carta Banco"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 5
integer width = 453
integer height = 144
boolean bringtotop = true
string dataobject = "report_simul_remesas_expor"
boolean livescroll = true
end type

type dw_recibos from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 507
integer width = 393
integer height = 156
boolean bringtotop = true
boolean livescroll = true
end type

type cb_marcar from commandbutton within w_impresion_remesas_expor_lcr
integer x = 229
integer y = 1468
integer width = 366
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar"
end type

type cb_desmarcar from commandbutton within w_impresion_remesas_expor_lcr
integer x = 608
integer y = 1468
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

type st_listo_pal_euro from statictext within w_impresion_remesas_expor_lcr
boolean visible = false
integer width = 69
integer height = 84
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "€"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_disquete2 from picturebutton within w_impresion_remesas_expor_lcr
integer x = 2642
integer y = 1180
integer width = 174
integer height = 152
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\disksave.bmp"
string disabledname = "\bmp\disksave_no.bmp"
alignment htextalign = left!
end type

event clicked;Dec anyo_rem,reme
Integer oky
str_carremesas cab 
oky = MessageBox("GENERACIÓN DE REMESA","¿ Desea continuar ?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme = Dec(em_remesa.text)
	
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
	WHERE carremesas.empresa = :codigo_empresa
	AND carremesas.anyo = :anyo_rem
	AND carremesas.banco = :em_banco.text
	AND carremesas.naci_extra= "E"
	AND carremesas.remesa = :reme;
	
	f_grabo_disquete_19(cab)
end if
end event

type st_18 from statictext within w_impresion_remesas_expor_lcr
integer x = 2537
integer y = 1116
integer width = 379
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Norma 19"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_disquete from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 192
integer y = 568
integer width = 1344
integer height = 412
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_disquete"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_efectos_disq from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 1833
integer y = 1016
integer width = 494
integer height = 360
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_impresion_remesas_efec_disq2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_directorio from u_em_campo within w_impresion_remesas_expor_lcr
integer x = 1321
integer y = 1464
integer width = 1102
integer height = 88
integer taborder = 11
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

type st_9 from statictext within w_impresion_remesas_expor_lcr
integer x = 992
integer y = 1476
integer width = 334
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Directorio :"
boolean focusrectangle = false
end type

type dw_lcr from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 503
integer y = 1124
integer width = 411
integer height = 232
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_lcr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_lcr_riba from commandbutton within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 2021
integer y = 1576
integer width = 201
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "LCR"
end type

event clicked;f_grabar_disquete_lcr()
end event

type dw_riba from datawindow within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 955
integer y = 1116
integer width = 411
integer height = 232
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_riba"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 2021
integer y = 1728
integer width = 201
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RIBA"
end type

event clicked;f_grabar_disquete_riba()
end event

type cbx_consultivo from checkbox within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 1577
integer y = 1592
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Consultivo"
end type

type cbx_financiacion from checkbox within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 1577
integer y = 1736
integer width = 416
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Financiacion"
end type

type st_ribalcr from statictext within w_impresion_remesas_expor_lcr
integer x = 2537
integer y = 1432
integer width = 379
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Riba/Lcr"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_impresion_remesas_expor_lcr
integer x = 2642
integer y = 1492
integer width = 174
integer height = 152
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\disksave.bmp"
string disabledname = "\bmp\disksave_no.bmp"
alignment htextalign = left!
end type

event clicked;Dec anyo_rem,reme
Integer oky
str_carremesas cab 
oky = MessageBox("GENERACIÓN DE REMESA","¿ Desea continuar ?",Question!,YesNo!,1)
IF oky = 1 THEN
	anyo_rem = Dec(em_anyorem.text)
	reme = Dec(em_remesa.text)
	
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
	WHERE carremesas.empresa = :codigo_empresa
	AND carremesas.anyo = :anyo_rem
	AND carremesas.banco = :em_banco.text
	AND carremesas.naci_extra= "E"
	AND carremesas.remesa = :reme;
	
	f_grabo_disquete_ribalcr(cab)
end if
end event

type gb_1 from groupbox within w_impresion_remesas_expor_lcr
boolean visible = false
integer x = 1527
integer y = 1540
integer width = 786
integer height = 304
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "LCR/RIBA"
end type

