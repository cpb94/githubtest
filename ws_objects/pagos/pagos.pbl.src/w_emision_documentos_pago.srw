$PBExportHeader$w_emision_documentos_pago.srw
forward
global type w_emision_documentos_pago from w_int_con_empresa
end type
type gb_tipo_pagare from groupbox within w_emision_documentos_pago
end type
type gb_1 from groupbox within w_emision_documentos_pago
end type
type pb_2 from upb_salir within w_emision_documentos_pago
end type
type st_2 from statictext within w_emision_documentos_pago
end type
type uo_banco from u_em_campo_2 within w_emision_documentos_pago
end type
type cb_consulta from u_boton within w_emision_documentos_pago
end type
type dw_transfer from datawindow within w_emision_documentos_pago
end type
type em_desde from u_em_campo within w_emision_documentos_pago
end type
type em_hasta from u_em_campo within w_emision_documentos_pago
end type
type st_3 from statictext within w_emision_documentos_pago
end type
type st_4 from statictext within w_emision_documentos_pago
end type
type uo_proveedor from u_em_campo_2 within w_emision_documentos_pago
end type
type st_provee from statictext within w_emision_documentos_pago
end type
type uo_tipodoc from u_em_campo_2 within w_emision_documentos_pago
end type
type dw_carta from datawindow within w_emision_documentos_pago
end type
type dw_1 from u_datawindow_consultas within w_emision_documentos_pago
end type
type dw_cheque from datawindow within w_emision_documentos_pago
end type
type dw_extracto from datawindow within w_emision_documentos_pago
end type
type em_fcarta from u_em_campo within w_emision_documentos_pago
end type
type st_9 from statictext within w_emision_documentos_pago
end type
type st_banco from statictext within w_emision_documentos_pago
end type
type dw_pagares from datawindow within w_emision_documentos_pago
end type
type rb_bcovalencia from radiobutton within w_emision_documentos_pago
end type
type rb_bcosabadell from radiobutton within w_emision_documentos_pago
end type
type rb_cam from radiobutton within w_emision_documentos_pago
end type
type st66 from statictext within w_emision_documentos_pago
end type
type pb_imprimir_pagare from picturebutton within w_emision_documentos_pago
end type
type pb_imprimir_cartas from picturebutton within w_emision_documentos_pago
end type
type st_5 from statictext within w_emision_documentos_pago
end type
type st_6 from statictext within w_emision_documentos_pago
end type
type pb_imprimir_documento from picturebutton within w_emision_documentos_pago
end type
type cb_1 from commandbutton within w_emision_documentos_pago
end type
type gb_3 from groupbox within w_emision_documentos_pago
end type
type gb_2 from groupbox within w_emision_documentos_pago
end type
type gb_4 from groupbox within w_emision_documentos_pago
end type
type cbx_transf_moneda_fra from checkbox within w_emision_documentos_pago
end type
type st_transf_moneda_fra from statictext within w_emision_documentos_pago
end type
type rb_bsch from radiobutton within w_emision_documentos_pago
end type
type rb_santander from radiobutton within w_emision_documentos_pago
end type
type rb_bancaja from radiobutton within w_emision_documentos_pago
end type
type rb_bco_popular from radiobutton within w_emision_documentos_pago
end type
type rb_bbva from radiobutton within w_emision_documentos_pago
end type
type dw_listado_pagos_emitidos from datawindow within w_emision_documentos_pago
end type
type pb_imprimir_pagos_emitidos from picturebutton within w_emision_documentos_pago
end type
type dw_detalle from datawindow within w_emision_documentos_pago
end type
type cbx_una_sola_carta_por_proveedor from checkbox within w_emision_documentos_pago
end type
type st_1 from statictext within w_emision_documentos_pago
end type
type rb_banesto from radiobutton within w_emision_documentos_pago
end type
type pb_n_68 from picturebutton within w_emision_documentos_pago
end type
type st_n68 from statictext within w_emision_documentos_pago
end type
type pb_n_34 from picturebutton within w_emision_documentos_pago
end type
type st_n34 from statictext within w_emision_documentos_pago
end type
type gb_5 from groupbox within w_emision_documentos_pago
end type
type rb_empresa from radiobutton within w_emision_documentos_pago
end type
type rb_matricial from radiobutton within w_emision_documentos_pago
end type
type rb_ibercaja from radiobutton within w_emision_documentos_pago
end type
type rb_cajaruralandorra from radiobutton within w_emision_documentos_pago
end type
type pb_sepa from picturebutton within w_emision_documentos_pago
end type
type st_7 from statictext within w_emision_documentos_pago
end type
end forward

global type w_emision_documentos_pago from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3703
integer height = 2196
gb_tipo_pagare gb_tipo_pagare
gb_1 gb_1
pb_2 pb_2
st_2 st_2
uo_banco uo_banco
cb_consulta cb_consulta
dw_transfer dw_transfer
em_desde em_desde
em_hasta em_hasta
st_3 st_3
st_4 st_4
uo_proveedor uo_proveedor
st_provee st_provee
uo_tipodoc uo_tipodoc
dw_carta dw_carta
dw_1 dw_1
dw_cheque dw_cheque
dw_extracto dw_extracto
em_fcarta em_fcarta
st_9 st_9
st_banco st_banco
dw_pagares dw_pagares
rb_bcovalencia rb_bcovalencia
rb_bcosabadell rb_bcosabadell
rb_cam rb_cam
st66 st66
pb_imprimir_pagare pb_imprimir_pagare
pb_imprimir_cartas pb_imprimir_cartas
st_5 st_5
st_6 st_6
pb_imprimir_documento pb_imprimir_documento
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
cbx_transf_moneda_fra cbx_transf_moneda_fra
st_transf_moneda_fra st_transf_moneda_fra
rb_bsch rb_bsch
rb_santander rb_santander
rb_bancaja rb_bancaja
rb_bco_popular rb_bco_popular
rb_bbva rb_bbva
dw_listado_pagos_emitidos dw_listado_pagos_emitidos
pb_imprimir_pagos_emitidos pb_imprimir_pagos_emitidos
dw_detalle dw_detalle
cbx_una_sola_carta_por_proveedor cbx_una_sola_carta_por_proveedor
st_1 st_1
rb_banesto rb_banesto
pb_n_68 pb_n_68
st_n68 st_n68
pb_n_34 pb_n_34
st_n34 st_n34
gb_5 gb_5
rb_empresa rb_empresa
rb_matricial rb_matricial
rb_ibercaja rb_ibercaja
rb_cajaruralandorra rb_cajaruralandorra
pb_sepa pb_sepa
st_7 st_7
end type
global w_emision_documentos_pago w_emision_documentos_pago

type variables
Date fpago
Dec num_talon
String  filtro = "N"

boolean marca_todos

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_todo_correcto ()
public subroutine f_imprimir_cheques ()
public subroutine f_pro (long linea)
public subroutine f_pro2 (long linea)
public function datetime f_maximo_fvto (string arg_proveedor, integer arg_linea)
public function boolean f_comprueba_numdocumento ()
public function boolean f_dividir_pagos_parciales ()
public function string f_tratar_texto_matricial (string arg_texto)
public subroutine f_grabar_norma_68_original ()
public function string f_tratar_nif (string arg_nif, string arg_tercero, string arg_pais)
public function string f_relleno_cadena (string cadena, string relleno, string izq_der, integer longitud_cadena)
public function string f_libre (integer posiciones)
protected subroutine f_grabar_norma_68 ()
protected subroutine f_grabar_norma34 ()
protected subroutine f_grabo_norma_34_sabadell ()
protected subroutine f_grabar_norma34_sepa ()
public function string f_facturas_linea_detalle (long arg_row)
protected subroutine f_grabar_norma34_sepa_xml ()
public subroutine f_tratar_texto (ref string arg_texto)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
string prove1,prove2
datetime fvto1,fvto2


if uo_proveedor.em_codigo.text = "" then
	prove1 = "."
	prove2 = "Z"
else
	prove1 = uo_proveedor.em_codigo.text 
	prove2 = uo_proveedor.em_codigo.text 
end if


fvto1 = datetime(date(em_desde.text))
fvto2 = datetime(date(em_hasta.text))


dw_data.reset()
dw_data.SetTransObject(sqlca)
dw_data.Retrieve(codigo_empresa,uo_tipodoc.em_codigo.text,prove1,prove2,fvto1,fvto2,uo_banco.em_codigo.text)
registros = dw_data.RowCount()


end subroutine

public subroutine f_todo_correcto ();Integer	i
String   banco,tipodoc

i = MessageBox("Impresión de Documentos","¿Esta el listado correcto?",Question!,YesNo!)
IF i = 1 THEN
	tipodoc   = Trim(uo_tipodoc.em_codigo.text)
	banco     = Trim(uo_banco.em_codigo.text)
	UPDATE carpagos SET situacion = '1'
	WHERE carpagos.empresa        = :codigo_empresa
	AND   carpagos.banco          = :banco
	AND   carpagos.tipodoc_pago   = :tipodoc
	AND   carpagos.situacion       = "0"
	AND   carpagos.num_talon <> "";
	COMMIT;
END IF
f_cargar(dw_1)
f_activar_campo(uo_banco.em_campo)
end subroutine

public subroutine f_imprimir_cheques ();Integer  ln, i
Dec{0}	num_talon_dec
Boolean  sin_talon = FALSE
String   ntalon, proveedor,banco,tipodoc
DateTime fec

ln = dw_1.RowCount()
FOR i = 1 TO ln
	ntalon = dw_1.GetItemString(i,"num_talon")
	IF Trim(ntalon) = "" OR IsNull(ntalon) THEN
		sin_talon = TRUE
		EXIT
	END IF
NEXT
String nomprov, marca
Dec{0} impor

tipodoc   = Trim(uo_tipodoc.em_codigo.text)
banco     = Trim(uo_banco.em_codigo.text)
IF sin_talon THEN
	num_talon = Dec(inputbox("Nº Cheque ","Introduzca El Nº de Cheque Inicial:","",""))	
	IF num_talon = 0 OR IsNull(num_talon) THEN
		MessageBox("ERROR","Ha introducido un Nº no válido",Exclamation!)
		RETURN
	END IF
	FOR i = 1 to ln
		marca = dw_1.GetItemString(i,"marca")
		
		IF marca <> "S" THEN CONTINUE
		
		ntalon = dw_1.GetItemString(i,"num_talon")
		IF Trim(ntalon) = "" OR IsNull(ntalon) THEN
			proveedor = dw_1.GetItemString(i,"proveedor")
			fec     	 = dw_1.GetItemDateTime(i,"fpago")
			ntalon    = String(num_talon)
			dw_1.SetItem(i,"num_talon",ntalon)
			UPDATE carpagos SET num_talon = :ntalon
   		WHERE carpagos.empresa        = :codigo_empresa
			AND   carpagos.banco          = :banco
			AND   carpagos.tipodoc_pago   = :tipodoc
			AND   carpagos.proveedor      = :proveedor
			AND   carpagos.fpago          = :fec
			AND   carpagos.situacion       = "0";
			COMMIT;
			num_talon = num_talon + 1
		END IF
	NEXT
END IF
f_cargar(dw_1)

f_todo_correcto()
end subroutine

public subroutine f_pro (long linea);Integer  donde,anyo
long     orden
string   prove,moneda,moneda_empresa,busqueda,agrupar
dec      importe_anterior,importe,divisas_anterior,divisas
datetime fvto,fvto_anterior

prove          = dw_1.getitemstring(linea,"proveedor")
fvto           = dw_1.getitemdatetime(linea,"fvto")
moneda         = dw_1.getitemstring(linea,"moneda")
moneda_empresa = f_moneda_empresa(codigo_empresa)
agrupar        = dw_1.getitemstring(linea,"carpagos_agrupar")
anyo           = dw_1.object.anyo[linea]
orden          = dw_1.object.orden[linea]

if agrupar = "S" then	
	busqueda = "proveedor ='"+prove+&
				  "' and string(fvto,'dd/mm/yy') = '"+string(fvto,"dd/mm/yy")+&
				  "' and moneda = '"+moneda+"' and anyo = 0 and orden = 0"
	
	donde = dw_detalle.find(busqueda,1,dw_detalle.RowCount())
else
	donde = 0	
end if

IF donde <= 0 Then
	donde = dw_detalle.RowCount() + 1
	dw_detalle.InsertRow(donde)
	importe_anterior = 0
	divisas_anterior = 0
	dw_detalle.SetItem(donde,"fvto",fvto)
else
	importe_anterior = dw_detalle.object.importe[donde]
	divisas_anterior = dw_detalle.object.divisas[donde]
END IF

dw_detalle.object.empresa[donde]        = codigo_empresa
dw_detalle.object.proveedor[donde]      = prove
dw_detalle.object.fcarta[donde]         = datetime(date(em_fcarta.text))
dw_detalle.object.moneda[donde]         = moneda
dw_detalle.object.moneda_empresa[donde] = moneda_empresa

fvto_anterior = dw_detalle.object.fvto[donde]

if fvto > fvto_anterior then
	dw_detalle.object.fvto[donde] = fvto
end if

importe = dw_1.object.carpagos_importe_a_pagar[linea]
divisas = dw_1.object.carpagos_divisas_a_pagar[linea]

importe = importe + importe_anterior
divisas = divisas + divisas_anterior

dw_detalle.object.importe[donde] = importe
dw_detalle.object.divisas[donde] = divisas

if agrupar = "S" then
	dw_detalle.object.anyo[donde]  = 0
	dw_detalle.object.orden[donde] = 0
else
	dw_detalle.object.anyo[donde]  = anyo 
	dw_detalle.object.orden[donde] = orden
end if

dw_detalle.object.imprimir[donde] = "S"


end subroutine

public subroutine f_pro2 (long linea);Integer  donde,anyo
long     orden
string   prove,moneda,busqueda,agrupar
dec      importe_anterior,importe,divisas_anterior,divisas
datetime fvto

prove   = dw_1.object.proveedor[linea]
fvto    = dw_1.object.fvto[linea]
moneda  = dw_1.object.moneda[linea]
agrupar = dw_1.getitemstring(linea,"carpagos_agrupar")
anyo    = dw_1.object.anyo[linea]
orden   = dw_1.object.orden[linea]
	
if agrupar = "S" then		
	busqueda = "proveedor ='"+prove+&
				  "' and string(fvto,'dd/mm/yy') = '"+string(fvto,"dd/mm/yy")+&
				  "' and moneda = '"+moneda+"' and anyo = 0 and orden = 0"
else	
	busqueda = "anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######")
end if
donde = dw_detalle.find(busqueda,1,dw_detalle.RowCount())

if donde > 0 then
	importe_anterior = dw_detalle.object.importe[donde]
	divisas_anterior = dw_detalle.object.divisas[donde]
	
	importe          = dw_1.object.carpagos_importe_a_pagar[linea]
	divisas          = dw_1.object.carpagos_divisas_a_pagar[linea]
	
	importe_anterior = importe_anterior - importe
	divisas_anterior = divisas_anterior - divisas
	
	if importe_anterior <= 0 then
		dw_detalle.deleterow(donde)
	else
		dw_detalle.object.importe[donde] = importe_anterior
		dw_detalle.object.divisas[donde] = divisas_anterior
		
		prove = dw_1.getitemstring(linea,"proveedor")
		dw_detalle.setitem(donde,"fvto",f_maximo_fvto(prove,linea))
	end if
end if









end subroutine

public function datetime f_maximo_fvto (string arg_proveedor, integer arg_linea);long i
datetime fvto,max_fvto
string prove

for i = 1 to dw_1.rowcount()
	// Todas las linea excepto la que estamos
	if i <> arg_linea then
		prove = dw_1.getitemstring(i,"proveedor")
		
		if prove = arg_proveedor then
			
			fvto = dw_1.getitemdatetime(i,"fvto")
			if isnull(max_fvto) then max_fvto = fvto
					
			if fvto > max_fvto then
				max_fvto = fvto	
			end if
		end if
	end if
next

return max_fvto


end function

public function boolean f_comprueba_numdocumento ();long    indice,total
string  documento
boolean bien = true

dw_detalle.accepttext()
total  = dw_detalle.rowcount()
indice = 0

if uo_tipodoc.em_codigo.text <> "6" then
	DO WHILE indice < total and bien
		indice ++
		documento = dw_detalle.object.documento[indice]
		if isnull(documento) then documento = ""
		if trim(documento) = "" then
			messagebox("Atención","Debe introducir todos los numeros de documento.")
			dw_detalle.selectrow(0,false)
			dw_detalle.selectrow(indice,true)
			dw_detalle.setrow(indice)
			dw_detalle.scrolltorow(indice)
			dw_detalle.setcolumn("documento")			
			bien = false
		end if
	LOOP
else
	//Las transferencias no tienen numero de documento
	for indice = 1 to total
		dw_detalle.object.documento[indice] = ""
	next
end if

return bien

end function

public function boolean f_dividir_pagos_parciales ();string  marca
int     anyo
long    indice,total,orden,ultima_orden
dec     importe,divisas,importe_a_pagar,divisas_a_pagar
boolean bien = true

str_carpagos carpagos

total = dw_1.rowcount()

for indice = 1 to total
	marca           = dw_1.object.marca[indice]
	importe         = dw_1.object.importe[indice]
	divisas         = dw_1.object.divisas[indice]
	importe_a_pagar = dw_1.object.carpagos_importe_a_pagar[indice]
	divisas_a_pagar = dw_1.object.carpagos_divisas_a_pagar[indice]
	
	if marca = "S" and importe <> importe_a_pagar then
		anyo  = dw_1.object.anyo[indice]
		orden = dw_1.object.orden[indice]
		
		SELECT carpagos.anyofra, 				carpagos.fra, 					carpagos.recibo, 
				 carpagos.ffra, 					carpagos.fvto, 				carpagos.fpago, 
				 carpagos.importe, 				carpagos.divisas, 			carpagos.moneda, 
				 carpagos.banco, 					carpagos.proveedor, 			carpagos.tipodoc, 
				 carpagos.codpago, 				carpagos.situacion, 			carpagos.cuenta, 
				 carpagos.femi, 					carpagos.num_talon, 			carpagos.asignar_banco, 
				 carpagos.tipodoc_pago, 		carpagos.cambio, 				carpagos.punteado, 
				 carpagos.concepto, 				carpagos.agrupado
		INTO   :carpagos.anyofra, 				:carpagos.fra, 				:carpagos.recibo, 
				 :carpagos.ffra, 					:carpagos.fvto, 				:carpagos.fpago, 
				 :carpagos.importe, 				:carpagos.divisas, 			:carpagos.moneda, 
				 :carpagos.banco, 				:carpagos.proveedor,	 		:carpagos.tipodoc, 
				 :carpagos.codpago, 				:carpagos.situacion, 		:carpagos.cuenta, 
				 :carpagos.femi, 					:carpagos.num_talon, 		:carpagos.asignar_banco, 
				 :carpagos.tipodoc_pago, 		:carpagos.cambio, 			:carpagos.punteado, 
				 :carpagos.concepto, 			:carpagos.agrupado 
		FROM   carpagos
		WHERE  carpagos.empresa = :codigo_empresa
		AND	 carpagos.anyo    = :anyo
		AND    carpagos.orden   = :orden;
		
		if carpagos.agrupado = "S" then
			bien = false
			messagebox("Atención","No se puede dividir un pago agrupado.")
		else
			
			Select  Max(carpagos.orden)
			Into 	  :ultima_orden
			From	  carpagos
			Where   carpagos.empresa = :codigo_empresa
			And     carpagos.anyo    = :anyo;
			
			IF IsNull(ultima_orden) Then ultima_orden = 0			
			
			ultima_orden ++
			
			carpagos.empresa = codigo_empresa
			carpagos.anyo    = anyo
			carpagos.orden   = ultima_orden
			
			carpagos.importe = importe - importe_a_pagar
			carpagos.divisas = divisas - divisas_a_pagar
			
			if not(f_insert_carpagos(carpagos)) then
				bien = false
			end if
			
			update carpagos
			set    importe = :importe_a_pagar,
					 divisas = :divisas_a_pagar
			where  empresa = :codigo_empresa
			and    anyo    = :anyo
			and    orden   = :orden;
			
			if sqlca.sqlcode <> 0 then
				bien = false
			end if
		end if
	end if
next

return bien
end function

public function string f_tratar_texto_matricial (string arg_texto);int    v_indice,v_total
string v_texto_tratado,v_caracter

v_total = len(trim(arg_texto))

arg_texto = trim(upper(arg_texto))

for v_indice = 1 to v_total
	v_caracter = mid(arg_texto,v_indice,1)
	
//	//Con esto quitamos las comillas dobles en los strings
//	if asc(v_caracter) = 34 then
//		v_caracter = ""
//	end if
//	
//	//Con esto quitamos los retornos
//	if asc(v_caracter) = 13 then
//		v_caracter = " "
//	end if
//	
//	if asc(v_caracter) = 10 then
//		v_caracter = " "
//	end if	
	
	choose case v_caracter
		case "Ñ"
			v_caracter = char(421)
	end choose
	
	v_texto_tratado = v_texto_tratado + v_caracter
next

return v_texto_tratado
end function

public subroutine f_grabar_norma_68_original ();//string registro, codigo_registro, codigo_operacion, entidad_ordenante, banco
//string numero_dato, fecha_envio, fecha_emision, entidad_destino, sucursal, concepto
//string cuenta, detalle_cargo, nombre_ordenante, domicilio_ordenante, plaza_ordenante
//string ref_beneficiario, importe, entidad_empleado, sucursal_empleado, signo
//string cuenta_empleado, gastos, clase_orden, nombre_beneficiario, mes, localidad, fvto_efecto
//string nombre_empresa, cif_empresa, cp_empresa, suma_importes, cp_beneficiario, ffra, ref_fra
//string numero_registros_ind, numero_total_reg, fichero, domicilio_beneficiario, pais, provincia
//string entidad_empresa, oficina_empresa, digito_control_empresa, cuenta_empresa , cod_iban, dc
//long   indice, total, numero_registros010, res
//dec    pagado, total_pagado
//datetime fvto
//
//total_pagado        = 0
//num_registros       = 0
//numero_registros010 = 0
//
//dw_norma_34.reset()
//
//total = dw_1.rowcount()
//
//if total > 0 then
//	
//	select nombre,empresas.cif,empresas.codpostal 
//	INTO   :nombre_empresa,:cif_empresa,:cp_empresa
//	FROM   empresas
//	WHERE  empresas.empresa = :codigo_empresa;
//	
//	banco = uo_banco.em_codigo.text
//	
//	SELECT carbancos.entidad,carbancos.oficina,
//			 carbancos.control,carbancos.nuestracta, iban, control
//	INTO   :entidad_empresa,:oficina_empresa,
//	       :digito_control_empresa,:cuenta_empresa,:cod_iban, :dc
//	FROM   carbancos
//	WHERE  carbancos.empresa = :codigo_empresa
//	AND	 carbancos.banco	= :banco;
//
//	//Creamos los 4 registros de cabecera
//	//Primero
//	codigo_registro   = "03"
//	codigo_operacion  = "59"
//	cif_empresa 		= f_tratar_cif(cif_empresa)
//	entidad_ordenante = f_relleno_cadena(cif_empresa," ","D",9)
//	numero_dato       = "001"
//	fecha_envio       = string(today(),"ddmmyy")
//	fecha_emision     = string(date(em_fcarta.text),"ddmmyy")	
//	entidad_destino   = f_relleno_cadena(entidad_empresa,"0","I",4)
//	sucursal          = f_relleno_cadena(oficina_empresa,"0","I",4)
//	cuenta            = f_relleno_cadena(cuenta_empresa,"0","I",10)
//	detalle_cargo     = "0"
//	
//	registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+f_libre(12)+numero_dato+fecha_envio+f_libre(9)+&
//				  cod_iban+entidad_destino+sucursal+dc+cuenta+f_libre(30)
//	f_inserto(registro)		
//	
//	long num_talon_dec, num_tal, dc_pago
//	string numero_pago
//	
//	SELECT MAX(Convert(Int,carpagos.num_talon)) 
//	INTO   :num_talon_dec 
//	FROM   carpagos
//	WHERE  carpagos.empresa       = :codigo_empresa
//	AND    carpagos.tipodoc_pago	= :uo_tipodoc.em_codigo.text;
//	
//	if isnull(num_talon_dec) then num_talon_dec = 0
//	
//	num_talon_dec = num_talon_dec + 1
//	
//	num_tal = Dec(inputbox("Nº Pagaré Impresion ","Introduzca El Nº de Pagaré Inicial:",String(num_talon_dec),""))	
//	
//	IF num_tal = 0 OR IsNull(num_tal) or num_tal > 999999 THEN
//		MessageBox("ERROR","Ha introducido un Nº no válido",Exclamation!)
//		RETURN
//	END IF	
//	
//	dc_pago = mod(dec('9000' + string(num_tal, "#######")), 7)	
//	
//	numero_pago = string(num_tal, "#######") + string(dc_pago, "#")
//	numero_pago = f_relleno_cadena(numero_pago,"0","I",8)
//	
//	//Segundo	
////	codigo_registro   = "06"
////	
////	numero_dato       = "002"	
////	registro = codigo_registro+codigo_operacion+entidad_ordenante+f_libre(12)+numero_dato+nombre_ordenante+f_libre(7)
////	f_inserto(registro)				  
////	//Tercero
////	numero_dato         = "003"
////	domicilio_ordenante = f_libre(36)
////	
////	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
////				  f_libre(12)+numero_dato+domicilio_ordenante+f_libre(7)
////	f_inserto(registro)				  	
////	//Cuarto
////	numero_dato         = "004"
////	plaza_ordenante     = f_libre(36)
////	
////	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
////				  f_libre(12)+numero_dato+plaza_ordenante+f_libre(7)
////	f_inserto(registro)				  
//	//Registros individuales	
//	codigo_registro   = "06"
//	codigo_operacion  = "59"
//	for indice = 1 to total
//		f_mensaje_proceso("Generando fichero",indice,total)
//		
//		
//		if dw_1.object.marca[indice] <> 'S' then continue
//		
//		numero_registros010 ++
//		
//		//Registro Primero - Cabecera Beneficiario 1
//		
//		ref_beneficiario    = dw_1.object.genter_cif[indice]
//		ref_beneficiario    = f_tratar_cif(ref_beneficiario)
//		ref_beneficiario    = f_relleno_cadena(ref_beneficiario," ","D",12)
//		nombre_beneficiario = dw_1.object.genter_razon[indice]
//		nombre_beneficiario = f_relleno_cadena(nombre_beneficiario," ","I",40)
//		
//		numero_dato       = "010"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  nombre_beneficiario+f_libre(29)
//		f_inserto(registro)				  				
//		
//		//Registro Segundo - Cabecera Beneficiario 2
//		
//		domicilio_beneficiario = dw_1.object.domici[indice]
//		domicilio_beneficiario = f_relleno_cadena(domicilio_beneficiario," ","I",45)
//				
//		numero_dato       = "011"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  domicilio_beneficiario+f_libre(24)
//		f_inserto(registro)		
//		
//		//Registro Tercero - Cabecera Beneficiario 3
//		
//		cp_beneficiario = dw_1.object.genter_cod_postal[indice]
//		cp_beneficiario = f_relleno_cadena(cp_beneficiario," ","D",5)		
//		localidad		 = dw_1.object.genter_localidad[indice]
//		localidad		 = f_relleno_cadena(localidad," ","I",40)			
//		
//		numero_dato       = "012"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  cp_beneficiario+localidad+f_libre(24)
//		f_inserto(registro)		
//		
//		//Registro Cuarto - Cabecera Beneficiario 4
//		
//		pais 		   	 = dw_1.object.paises_nombre[indice]
//		pais 				 = f_relleno_cadena(pais," ","I",20)	
//		provincia 		 = dw_1.object.provincias_nombre[indice]
//		provincia 		 = f_relleno_cadena(provincia," ","I",30)
//		cp_beneficiario = f_relleno_cadena(cp_beneficiario," ","D",9)	
//		
//		numero_dato       = "013"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  cp_beneficiario+provincia+pais+f_libre(10)
//		f_inserto(registro)	
//		
//		//Registro Quinto - Cabecera del Pago
//		
//		fvto 		    = dw_1.object.fvto[indice]
//		fvto_efecto  = string(fvto, "ddmmyyyy")
//		pagado       = dw_1.object.importe[indice]
//		total_pagado = total_pagado + pagado
//		importe      = string(abs(pagado)*100,"############")
//		importe      = f_relleno_cadena(importe," ","D",12)					
//		
//		numero_dato       = "014"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  numero_pago+fvto_efecto+importe+"0"+f_libre(40)
//		f_inserto(registro)	
//		
//		//Registro Sexto - Cabecera del Pago
//		
//		ref_fra = dw_1.object.ref_fra[indice]
//		ref_fra = f_relleno_cadena(ref_fra," ","I",12)					
//		ffra	  = string(dw_1.object.ffra[indice], "ddmmyyyy")
//		importe = f_relleno_cadena(string(dec(importe)),"0","I",12)
//		
//		if pagado < 0 then
//			signo = 'D'
//		else
//			signo = 'H'
//		end if
//		
//		concepto = "Pago Factura " + ref_fra
//		concepto = f_relleno_cadena(concepto," ","D",28)					
//		
//		numero_dato       = "015"
//		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
//					  numero_pago+ref_fra+ffra+importe+signo+concepto
//		f_inserto(registro)	
//
//	next	
//	//Registro de totales
//	codigo_registro      = "08"
//	codigo_operacion     = "59"
//	suma_importes        = string(total_pagado*100,"############")
//	suma_importes        = f_relleno_cadena(suma_importes,"0","I",12)
//	numero_total_reg     = string(dw_norma_34.rowcount()+1,"##########") 
//	numero_total_reg     = f_relleno_cadena(numero_total_reg,"0","I",10)
//	
//	
//	registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+f_libre(15)+suma_importes+numero_total_reg+f_libre(47)
//	f_inserto(registro)				  					
//end if
//
//mes = string(month(today()))
//
//if len(mes) = 1 then
//	mes = "0" + mes
//end if
//
//fichero = "68" + "-" + uo_proveedor.em_codigo.text + "-" + mes + Right(string(year(today())),2) + ".txt"
//
//fichero = "C:\REMESAS\" + fichero //em_directorio.text + 
//
//if dw_norma_34.rowcount() > 0 then
//	res = dw_norma_34.saveas(fichero, text!, false)
//	if res = -1 then 
//		f_mensaje("ERROR","Al grabar al disquete")
//	else
//		messagebox("", "Grabada norma 68 en disco con el nombre " + fichero)
//	end if
//end if
//
//
end subroutine

public function string f_tratar_nif (string arg_nif, string arg_tercero, string arg_pais);string var_nif,nuevo_nif,caracter,ls_codigo_pais_nif
long   indice,total,asci,longitud_nif

ls_codigo_pais_nif = ""

select codigo_pais_nif
into  :ls_codigo_pais_nif
from  paises
where pais = :arg_pais
using sqlca;

if isnull(ls_codigo_pais_nif) then ls_codigo_pais_nif = ""
ls_codigo_pais_nif = Upper(trim(ls_codigo_pais_nif))

IF ls_codigo_pais_nif = "GR" then
	//Grecia es un caso especial,el codigo iso no se corresponde con el codigo utilizado en el nif
	ls_codigo_pais_nif = "EL"
end if

var_nif = Upper(trim(arg_nif))

if trim(ls_codigo_pais_nif) <> "" and pos(var_nif,ls_codigo_pais_nif) > 0 then
	var_nif = Replace(var_nif,pos(var_nif,ls_codigo_pais_nif),len(ls_codigo_pais_nif),"")
end if

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

public function string f_libre (integer posiciones);int    indice
string libre = ""

for indice = 1 to posiciones
	libre = libre + " "
next

return libre
end function

protected subroutine f_grabar_norma_68 ();string registro, codigo_registro, codigo_operacion, entidad_ordenante, banco,ls_proveedor,ruta
string numero_dato, fecha_envio, fecha_emision, entidad_destino, sucursal, concepto
string cuenta, detalle_cargo, nombre_ordenante, domicilio_ordenante, plaza_ordenante
string ref_beneficiario, importe, entidad_empleado, sucursal_empleado, signo
string cuenta_empleado, gastos, clase_orden, nombre_beneficiario, mes, localidad, fvto_efecto
string nombre_empresa, cif_empresa, cp_empresa, suma_importes, cp_beneficiario, ffra, ref_fra
string numero_registros_ind, numero_total_reg, fichero, domicilio_beneficiario, pais, provincia
string entidad_empresa, oficina_empresa, digito_control_empresa, cuenta_empresa , cod_iban, dc
long   indice, total, numero_registros010, res,ll_donde,num_registros,anyo,orden,ll_donde_efecto
dec    pagado, total_pagado
datetime fvto
datastore lds_norma68

f_cargar_cursor_transaccion(sqlca,lds_norma68,"select space(100) as registro from empresas where 0 = 1 ")

total_pagado        = 0
num_registros       = 0
numero_registros010 = 0

lds_norma68.reset()

total = dw_detalle.rowcount()

if total > 0 then
	
	select nombre,empresas.cif,empresas.codpostal,pais 
	INTO   :nombre_empresa,:cif_empresa,:cp_empresa,:pais
	FROM   empresas
	WHERE  empresas.empresa = :codigo_empresa;
	
	banco = uo_banco.em_codigo.text
	
	SELECT carbancos.entidad,carbancos.oficina,
			 carbancos.control,carbancos.nuestracta, codigo_iban, control
	INTO   :entidad_empresa,:oficina_empresa,
	       :digito_control_empresa,:cuenta_empresa,:cod_iban, :dc
	FROM   carbancos
	WHERE  carbancos.empresa = :codigo_empresa
	AND	 carbancos.banco	= :banco;

	//Creamos los 4 registros de cabecera
	//Primero
	codigo_registro   = "03"
	codigo_operacion  = "59"
	cif_empresa 		= f_tratar_nif(cif_empresa,'EMPRESA',pais)
	entidad_ordenante = f_relleno_cadena(cif_empresa," ","D",9)
	numero_dato       = "001"
	fecha_envio       = string(today(),"ddmmyy")
	fecha_emision     = string(date(em_fcarta.text),"ddmmyy")	
	entidad_destino   = f_relleno_cadena(entidad_empresa,"0","I",4)
	sucursal          = f_relleno_cadena(oficina_empresa,"0","I",4)
	cuenta            = f_relleno_cadena(cuenta_empresa,"0","I",10)
	detalle_cargo     = "0"
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+f_libre(12)+numero_dato+fecha_envio+f_libre(9)+&
				  cod_iban+entidad_destino+sucursal+dc+cuenta+f_libre(30)
				  
	ll_donde = lds_norma68.insertrow(0)
	lds_norma68.object.registro[ll_donde] = registro
	//f_inserto(registro)		
	
	long num_talon_dec, num_tal, dc_pago
	string numero_pago
	
	SELECT max(Convert(Int,carpagos.num_talon)) 
	INTO   :num_talon_dec 
	FROM   carpagos
	WHERE  carpagos.empresa       = :codigo_empresa
	AND    carpagos.tipodoc_pago	= :uo_tipodoc.em_codigo.text;
	
	if isnull(num_talon_dec) then num_talon_dec = 0
	
	num_talon_dec = num_talon_dec + 1
	
	num_tal = Dec(inputbox("Nº Documento Impresion ","Introduzca El Nº de Documento Inicial:",String(num_talon_dec),""))	
	
	IF num_tal = 0 OR IsNull(num_tal) or num_tal > 999999 THEN
		MessageBox("ERROR","Ha introducido un Nº no válido",Exclamation!)
		RETURN
	END IF	
	
	dc_pago = mod(dec('9000' + string(num_tal, "#######")), 7)	
	
	numero_pago = string(num_tal, "#######") + string(dc_pago, "#")
	numero_pago = f_relleno_cadena(numero_pago,"0","I",8)
	
	//Segundo	
//	codigo_registro   = "06"
//	
//	numero_dato       = "002"	
//	registro = codigo_registro+codigo_operacion+entidad_ordenante+f_libre(12)+numero_dato+nombre_ordenante+f_libre(7)
//	f_inserto(registro)				  
//	//Tercero
//	numero_dato         = "003"
//	domicilio_ordenante = f_libre(36)
//	
//	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
//				  f_libre(12)+numero_dato+domicilio_ordenante+f_libre(7)
//	f_inserto(registro)				  	
//	//Cuarto
//	numero_dato         = "004"
//	plaza_ordenante     = f_libre(36)
//	
//	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
//				  f_libre(12)+numero_dato+plaza_ordenante+f_libre(7)
//	f_inserto(registro)				  
	//Registros individuales	
	codigo_registro   = "06"
	codigo_operacion  = "59"
	for indice = 1 to total
		f_mensaje_proceso("Generando fichero",indice,total)
		
		numero_registros010 ++
		
		//Registro Primero - Cabecera Beneficiario 1
		ls_proveedor        = dw_detalle.object.proveedor[indice]
		
		select isnull(genter.razon,''),
				 isnull(genter.cif,''),
				 isnull(genter.pais,''),
				 isnull(genter.cl_domicilio,'')+' '+isnull(genter.domicilio,'')+' '+isnull(genter.nu_domicilio,''),
				 isnull(genter.cod_postal,''),
				 isnull(genter.localidad,''),
				 isnull(genter.provincia,'')
		into   :nombre_beneficiario,
				 :ref_beneficiario,
				 :pais,
				 :domicilio_beneficiario,
				 :cp_beneficiario,
				 :localidad,
				 :provincia
		from   genter
		where  genter.empresa = :codigo_empresa
		and    genter.tipoter = 'P'
		and    genter.codigo  = :ls_proveedor;
		
		
		//ref_beneficiario    = dw_detalle.object.genter_cif[indice]
		ref_beneficiario    = f_tratar_nif(ref_beneficiario,nombre_beneficiario,pais) //f_tratar_nif(ref_beneficiario)
		ref_beneficiario    = f_relleno_cadena(ref_beneficiario," ","D",12)
		//nombre_beneficiario = dw_detalle.object.genter_razon[indice]
		nombre_beneficiario = f_relleno_cadena(nombre_beneficiario," ","I",40)
		
		numero_dato       = "010"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  nombre_beneficiario+f_libre(29)
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro					  
//		f_inserto(registro)				  				
		
		//Registro Segundo - Cabecera Beneficiario 2
		
		//domicilio_beneficiario = dw_detalle.object.domici[indice]
		domicilio_beneficiario = f_relleno_cadena(domicilio_beneficiario," ","I",45)
				
		numero_dato       = "011"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  domicilio_beneficiario+f_libre(24)
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro
		//f_inserto(registro)		
		
		//Registro Tercero - Cabecera Beneficiario 3
		
		//cp_beneficiario = dw_detalle.object.genter_cod_postal[indice]
		cp_beneficiario = f_relleno_cadena(cp_beneficiario," ","D",5)		
		//localidad		 = dw_detalle.object.genter_localidad[indice]
		localidad		 = f_relleno_cadena(localidad," ","I",40)			
		
		numero_dato       = "012"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  cp_beneficiario+localidad+f_libre(24)
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro
		//f_inserto(registro)		
		
		//Registro Cuarto - Cabecera Beneficiario 4
		
		provincia 		 = f_nombre_provincia(pais,provincia) //dw_detalle.object.provincias_nombre[indice]
		provincia 		 = f_relleno_cadena(provincia," ","I",30)
		pais 		   	 = f_nombre_pais(pais) //dw_detalle.object.paises_nombre[indice]
		pais 				 = f_relleno_cadena(pais," ","I",20)			
		cp_beneficiario = f_relleno_cadena(cp_beneficiario," ","D",9)	
		
		numero_dato       = "013"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  cp_beneficiario+provincia+pais+f_libre(10)
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro
		//f_inserto(registro)	
		
		//Registro Quinto - Cabecera del Pago
		
		fvto 		    = dw_detalle.object.fvto[indice]
		fvto_efecto  = string(fvto, "ddmmyyyy")
		pagado       = dw_detalle.object.importe[indice]
		total_pagado = total_pagado + pagado
		importe      = string(abs(pagado)*100,"############")
		importe      = f_relleno_cadena(importe," ","D",12)					
		
		numero_dato       = "014"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  numero_pago+fvto_efecto+importe+"0"+f_libre(40)
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro
		//f_inserto(registro)	
		
		//Registro Sexto - Cabecera del Pago
		
		importe = f_relleno_cadena(string(dec(importe)),"0","I",12)
		
		if pagado < 0 then
			signo = 'D'
		else
			signo = 'H'
		end if
		
		anyo       = dw_detalle.object.anyo[indice]
		orden      = dw_detalle.object.orden[indice]
		
		if anyo = 0 and orden = 0 then	
			//Efectos agrupados
			ffra	  = string(dw_detalle.object.fcarta[indice], "ddmmyyyy")
			ref_fra = "Agrupado"
		else
			ll_donde_efecto = dw_1.find("anyo = "+string(anyo,"###0")+" and orden = "+string(orden,"#####0"),1,dw_1.rowcount())
			
			if ll_donde_efecto > 0 then
				ffra	  = string(dw_1.object.ffra[ll_donde_efecto], "ddmmyyyy")
				ref_fra = dw_1.object.fra[ll_donde_efecto]						
			else
				ffra	  = string(dw_detalle.object.fcarta[indice], "ddmmyyyy")
				ref_fra = "*"				
			end if
		end if
		
		//ref_fra = dw_detalle.object.ref_fra[indice]
		ref_fra = f_relleno_cadena(ref_fra," ","I",12)					
		//ffra	  = string(dw_detalle.object.ffra[indice], "ddmmyyyy")		
		
		concepto = "Pago Factura " + ref_fra
		concepto = f_relleno_cadena(concepto," ","D",28)					
		
		numero_dato       = "015"
		registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+ref_beneficiario+numero_dato+&
					  numero_pago+ref_fra+ffra+importe+signo+concepto
					  
		ll_donde = lds_norma68.insertrow(0)
		lds_norma68.object.registro[ll_donde] = registro
		//f_inserto(registro)	

	next	
	//Registro de totales
	codigo_registro      = "08"
	codigo_operacion     = "59"
	suma_importes        = string(total_pagado*100,"############")
	suma_importes        = f_relleno_cadena(suma_importes,"0","I",12)
	numero_total_reg     = string(lds_norma68.rowcount()+1,"##########") 
	numero_total_reg     = f_relleno_cadena(numero_total_reg,"0","I",10)
	
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+"000"+f_libre(15)+suma_importes+numero_total_reg+f_libre(47)
	
	ll_donde = lds_norma68.insertrow(0)
	lds_norma68.object.registro[ll_donde] = registro
	//f_inserto(registro)				  					
end if

if lds_norma68.rowcount() > 0 then
	ruta       = "N68"+string(today(),"ddmmyyyy")+".TXT"
	if GetFileSaveName("Fichero 68",ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then	
		res = lds_norma68.saveas(fichero, text!, false)
		if res = -1 then 
			f_mensaje("ERROR","Al grabar al disquete")
		else
			messagebox("", "Grabada norma 68 en disco con el nombre " + fichero)
		end if
	end if
end if

destroy lds_norma68

end subroutine

protected subroutine f_grabar_norma34 ();string registro,codigo_registro,codigo_operacion,entidad_ordenante,banco
string numero_dato,fecha_envio,fecha_emision,entidad_destino,sucursal
string cuenta,detalle_cargo,nombre_ordenante,domicilio_ordenante,plaza_ordenante
string proveedor,empleado,ref_beneficiario,importe,entidad_empleado,sucursal_empleado
string cuenta_empleado,gastos,clase_orden,nombre_beneficiario,mes
string nombre_empresa,cif_empresa,cp_empresa,suma_importes,cp_beneficiario
string numero_registros_ind,numero_total_reg,fichero,domicilio_beneficiario
string entidad_empresa,oficina_empresa,digito_control_empresa,cuenta_empresa 
long   indice,total,numero_registros010,res,num_registros,ll_donde
dec    pagado,total_pagado
string ls_banco_proveedor, entidad_proveedor,sucursal_proveedor
string cuenta_proveedor,ls_fecha,ls_ruta,dc_proveedor,ls_vencimiento,ls_signo,concepto_documento

datastore lds_n_34

f_cargar_cursor_transaccion(sqlca,lds_n_34,"select space(100) as registro from empresas where 0 = 1 ")

total_pagado        = 0
num_registros       = 0
numero_registros010 = 0

total = dw_1.rowcount()

choose case uo_tipodoc.em_codigo.text
	case "6"
		//Transferencias
		codigo_operacion = "56"
	case "7"
		//Cheques bancarios
		codigo_operacion = "57"
	case "5"
		//Pagares
		codigo_operacion = "58"
	case else
		//Pagos certificados
		codigo_operacion = "59"
end choose

if total > 0 then
	SELECT empresas.nombre,empresas.cif,empresas.codpostal 
	INTO   :nombre_empresa,:cif_empresa,:cp_empresa
	FROM   empresas
	WHERE  empresas.empresa = :codigo_empresa;
	
	banco = uo_banco.em_codigo.text
	
	SELECT carbancos.entidad,carbancos.oficina,
			 carbancos.control,carbancos.nuestracta
	INTO   :entidad_empresa,:oficina_empresa,
	       :digito_control_empresa,:cuenta_empresa
	FROM   carbancos
	WHERE  carbancos.empresa = :codigo_empresa
	AND	 carbancos.banco	= :banco;

	//Creamos los 4 registros de cabecera
	//Primero
	codigo_registro   = "03"
	//En Pesetas
	//codigo_operacion  = "06"
	//En Euros
	//codigo_operacion  = "56"
	cif_empresa 		= f_tratar_nif(cif_empresa,"empresa",f_pais_empresa(codigo_empresa))
	entidad_ordenante = f_relleno_cadena(cif_empresa," ","I",10)
	numero_dato       = "001"
	fecha_envio       = string(today(),"ddmmyy")
	//fecha_emision     = string(date(em_fecha.text),"ddmmyy")	
	fecha_emision     = string(today(),"ddmmyy")
	entidad_destino   = f_relleno_cadena(entidad_empresa,"0","I",4)
	sucursal          = f_relleno_cadena(oficina_empresa,"0","I",4)
	cuenta            = f_relleno_cadena(cuenta_empresa,"0","I",10)
	detalle_cargo     = "0"
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
				  f_libre(12)+numero_dato+fecha_envio+fecha_emision+&
				  entidad_destino+sucursal+cuenta+detalle_cargo+f_libre(12)
				  
	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro

	//Segundo
	numero_dato       = "002"
	nombre_ordenante  = f_relleno_cadena(nombre_empresa," ","D",36)
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
				  f_libre(12)+numero_dato+nombre_ordenante+f_libre(7)

	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro
	
	//Tercero
	numero_dato         = "003"
	domicilio_ordenante = f_libre(36)
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
				  f_libre(12)+numero_dato+domicilio_ordenante+f_libre(7)

	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro
	
	//Cuarto
	numero_dato         = "004"
	plaza_ordenante     = f_libre(36)
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
				  f_libre(12)+numero_dato+plaza_ordenante+f_libre(7)

	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro
	
	//Registros individuales	
	codigo_registro   = "06"
	//En Pesetas
	//codigo_operacion  = "06"
	//En Euros	
	//codigo_operacion  = "56"
	
	for indice = 1 to total
		f_mensaje_proceso("Generando fichero",indice,total)
		if dw_1.object.marca[indice] = 'S' then
			//Primero
			numero_registros010 ++
			proveedor         = dw_1.object.proveedor[indice]
			ref_beneficiario  = f_cif_genter(codigo_empresa,'P',proveedor)
			ref_beneficiario  = f_tratar_nif(ref_beneficiario,proveedor,f_pais_genter(codigo_empresa,'P',proveedor))
			ref_beneficiario  = f_relleno_cadena(ref_beneficiario," ","I",12)
			numero_dato       = "010"
			pagado            = dw_1.object.importe[indice]
			total_pagado      = total_pagado + pagado
			importe           = string(pagado*100,"############")
			importe           = f_relleno_cadena(importe,"0","I",12)
					
			if codigo_operacion = "56" then		
				SELECT isnull(comproveedores.entidad,''),   
						 isnull(comproveedores.oficina,''),   
						 isnull(comproveedores.cuenta,''),
						 isnull(comproveedores.control,'')
				INTO   :entidad_proveedor,   
						 :sucursal_proveedor,   
						 :cuenta_proveedor,
						 :dc_proveedor
				FROM   comproveedores
				WHERE ( comproveedores.empresa = :codigo_empresa ) 
				AND   ( comproveedores.codigo  = :proveedor );	
				
				entidad_proveedor  = f_relleno_cadena(entidad_proveedor," ","D",4)
				sucursal_proveedor = f_relleno_cadena(sucursal_proveedor," ","D",4)
				cuenta_proveedor   = f_relleno_cadena(cuenta_proveedor," ","D",10)
				dc_proveedor       = f_relleno_cadena(dc_proveedor," ","D",2)				
				
				ls_vencimiento = ""
				ls_vencimiento = f_relleno_cadena(ls_vencimiento," ","D",6)
				ls_signo = " "
			else
				entidad_proveedor  = ""
				entidad_proveedor  = f_relleno_cadena(entidad_proveedor," ","D",4)
				sucursal_proveedor = ""
				sucursal_proveedor = f_relleno_cadena(sucursal_proveedor," ","D",4)
				cuenta_proveedor   = ""
				cuenta_proveedor   = f_relleno_cadena(cuenta_proveedor," ","D",10)
				dc_proveedor       = ""
				dc_proveedor       = f_relleno_cadena(dc_proveedor," ","D",2)
				
				ls_vencimiento = string(dw_1.object.fvto[indice],"ddmmyy")
				ls_signo = " "
			end if
			
			entidad_proveedor  = f_relleno_cadena(entidad_proveedor,"0","I",4)
			sucursal_proveedor = f_relleno_cadena(sucursal_proveedor,"0","I",4)
			cuenta_proveedor   = f_relleno_cadena(cuenta_proveedor,"0","I",10)
			gastos            = "1"
			clase_orden       = "9"//1 nomina 8 pension 9 otros
			
			registro = codigo_registro+codigo_operacion+entidad_ordenante+&
						  ref_beneficiario+numero_dato+importe+&
						  entidad_proveedor+sucursal_proveedor+cuenta_proveedor+&
						  gastos+clase_orden+ls_signo+dc_proveedor+ls_vencimiento+f_libre(1)
	
			ll_donde = lds_n_34.insertrow(0)	  
			lds_n_34.object.registro[ll_donde] = registro
		
			//Segundo
			numero_dato         = "011"
			nombre_beneficiario =  f_razon_genter(codigo_empresa,"P",proveedor) 
			nombre_beneficiario = f_relleno_cadena(nombre_beneficiario," ","D",36)
			
			registro = codigo_registro+codigo_operacion+entidad_ordenante+&
						  ref_beneficiario+numero_dato+nombre_beneficiario+f_libre(7)
	
			ll_donde = lds_n_34.insertrow(0)	  
			lds_n_34.object.registro[ll_donde] = registro
			
			//Tercero
			numero_dato         = "012"
			domicilio_beneficiario = f_domicilio_genter(codigo_empresa,proveedor, "P")
			domicilio_beneficiario = f_relleno_cadena(domicilio_beneficiario," ","D",36)
			
			registro = codigo_registro+codigo_operacion+entidad_ordenante+&
						  ref_beneficiario+numero_dato+domicilio_beneficiario+f_libre(7)
	
			ll_donde = lds_n_34.insertrow(0)	  
			lds_n_34.object.registro[ll_donde] = registro
			
			//Quinto
			numero_dato         = "014"
			cp_beneficiario = f_postal_genter(codigo_empresa,"P",proveedor)
			cp_beneficiario = f_relleno_cadena(cp_beneficiario," ","D",36)
			
			registro = codigo_registro+codigo_operacion+entidad_ordenante+&
						  ref_beneficiario+numero_dato+cp_beneficiario+f_libre(7)
	
			ll_donde = lds_n_34.insertrow(0)	  
			lds_n_34.object.registro[ll_donde] = registro
			
			//Sexto
			numero_dato        = "016"
			concepto_documento = "PAGO FRA "+dw_1.object.compute_factura[indice]
			concepto_documento = f_relleno_cadena(concepto_documento," ","D",36)
			
			registro = codigo_registro+codigo_operacion+entidad_ordenante+&
						  ref_beneficiario+numero_dato+concepto_documento+f_libre(7)
	
			ll_donde = lds_n_34.insertrow(0)	  
			lds_n_34.object.registro[ll_donde] = registro			
		end if
	next	
	//Registro de totales
	codigo_registro      = "08"
	//En Pesetas
	//codigo_operacion  = "06"
	//En Euros	
	//codigo_operacion     = "56"
	suma_importes        = string(total_pagado*100,"############")
	suma_importes        = f_relleno_cadena(suma_importes,"0","I",12)
	numero_registros_Ind = string(numero_registros010,"########") 
	numero_registros_Ind = f_relleno_cadena(numero_registros_Ind,"0","I",8)
	numero_total_reg     = string(num_registros+1,"##########") 
	numero_total_reg     = f_relleno_cadena(numero_total_reg,"0","I",10)
	
	registro = codigo_registro+codigo_operacion+entidad_ordenante+&
				  f_libre(15)+suma_importes+numero_registros_Ind+&
				  numero_total_reg+f_libre(13)

	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro
	
end if



ls_fecha = string(date(em_fcarta.text),"ddmmyyyy")
//fichero = "PAG"+uo_banco.em_codigo.text+ls_fecha 

//fichero = "A:\" + fichero //em_directorio.text + 

ls_ruta = "N34" + uo_banco.em_codigo.text+ls_fecha 
if GetFileSaveName("Fichero N34",ls_ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
	if lds_n_34.rowcount() > 0 then
		res = lds_n_34.saveas(fichero,text!,false)
		if res = -1 then f_mensaje("ERROR","Al grabar el fichero")
		if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
	end if		
end if	

destroy lds_n_34




end subroutine

protected subroutine f_grabo_norma_34_sabadell ();string nombre_empresa,cif_empresa,cp_empresa,banco,entidad_empresa,oficina_empresa,digito_control_empresa,cuenta_empresa,registro
string proveedor
string ls_tipo_lote,ls_codigo_registro,ls_nif_ordenante,ls_fecha_de_la_remesa,ls_fecha_de_pago,ls_banco_cargo_ordenante
string ls_oficina_cargo_ordenente,ls_cuenta_cargo_ordenente,ls_total_importe_cheques,ls_total_registros,ls_total_de_beneficiarios
string ls_forma_de_envio,ls_concepto_comun,ls_tipo_envio,ls_version,ls_nombre_ordenante,ls_direccion_ordenante,ls_codigo_postal
string ls_poblacion_empresa,ls_codigo_beneficiario,ls_importe_a_abonar,ls_nombre_beneficiario,ls_idioma,ls_direccion_beneficiario
string ls_fecha_vencimiento,ls_documento_barrado,ls_no_utilizado,ls_poblacion_beneficiario,ls_provincia_beneficiario,ls_fecha
string ls_ruta,fichero,ls_concepto,ls_facturas,ls_proveedor,ls_moneda,ls_marca,ls_prove,ls_moneda_fra,ls_fra
long ll_total_registros,ll_total_beneficiarios,indice,total,ll_donde,res,ll_indice2,ll_total2,ll_recibo
dec  ld_total_importe_cheques,pagado
datetime ldt_fecha_pago,ldt_fvto

datastore lds_n_34

f_cargar_cursor_transaccion(sqlca,lds_n_34,"select space(140) as registro from empresas where 0 = 1 ")

ld_total_importe_cheques = 0
ll_total_registros       = 0
ll_total_beneficiarios = 0

ll_total2 = dw_1.rowcount()
total = dw_detalle.rowcount()

if total > 0 then
	SELECT empresas.nombre,empresas.cif,empresas.codpostal 
	INTO   :nombre_empresa,:cif_empresa,:cp_empresa
	FROM   empresas
	WHERE  empresas.empresa = :codigo_empresa;
	
	banco = uo_banco.em_codigo.text
	
	SELECT carbancos.entidad,carbancos.oficina,
			 carbancos.control,carbancos.nuestracta
	INTO   :entidad_empresa,:oficina_empresa,
	       :digito_control_empresa,:cuenta_empresa
	FROM   carbancos
	WHERE  carbancos.empresa = :codigo_empresa
	AND	 carbancos.banco	= :banco;

	//Creamos los registros de cabecera
	//Primero
	choose case uo_tipodoc.em_codigo.text
		case "7"
			//Cheques bancarios
			ls_tipo_lote = "60"
		case "5"
			//Pagares
			ls_tipo_lote = "71"
		case else
			//Cheque cc
			ls_tipo_lote = "59"
	end choose	
	ls_codigo_registro         = "E"
	ls_nif_ordenante 		      = f_relleno_cadena(f_tratar_nif(cif_empresa,"empresa",f_pais_empresa(codigo_empresa))," ","D",10)
	ls_fecha_de_la_remesa      = string(today(),"yyyymmdd")
	ls_fecha_de_pago           = string(today(),"yyyymmdd")
	ls_banco_cargo_ordenante   = f_relleno_cadena(entidad_empresa,"0","I",4)
	ls_oficina_cargo_ordenente = f_relleno_cadena(oficina_empresa,"0","I",4)
	ls_cuenta_cargo_ordenente  = f_relleno_cadena(cuenta_empresa,"0","I",10)
	ls_total_importe_cheques   = f_relleno_cadena(string(ld_total_importe_cheques*100,"000000000000"),"0","I",12)
	ls_total_registros         = f_relleno_cadena(string(ll_total_registros,"00000000"),"0","I",8)
	ls_total_de_beneficiarios  = f_relleno_cadena(string(ll_total_beneficiarios,"00000000"),"0","I",8)
	ls_forma_de_envio          = "B" //B entrega al beneficiario/O distribucion a traves de la oficina
	ls_concepto_comun          = f_relleno_cadena("-"," ","I",60)
	ls_tipo_envio              = " " // En blanco por BS online,O distribucuion a traves de la oficina
	ls_version                 = "1"
	
	
	registro = ls_tipo_lote +&
  	           ls_codigo_registro +&
	           ls_nif_ordenante +&
	           ls_fecha_de_la_remesa +&
	           ls_fecha_de_pago +&
	           ls_banco_cargo_ordenante +&
	           ls_oficina_cargo_ordenente +&
	           ls_cuenta_cargo_ordenente +&
	           ls_total_importe_cheques +&
	           ls_total_registros +&
	           ls_total_de_beneficiarios +&
	           ls_forma_de_envio +&
	           ls_concepto_comun +&
	           ls_tipo_envio +&
	           ls_version
			
	//Esto lo hacemos al final para calcular los totales		
	ll_total_registros++
//	ll_donde = lds_n_34.insertrow(0)	  
//	lds_n_34.object.registro[ll_donde] = registro

	//Segundo
	ls_codigo_registro     = "O"
	ls_nombre_ordenante    = f_relleno_cadena(nombre_empresa," ","D",40)
	ls_direccion_ordenante = f_relleno_cadena(f_domicilio_empresa(codigo_empresa)," ","D",40)
	ls_codigo_postal       = f_relleno_cadena(cp_empresa,"0","I",5)
	ls_poblacion_empresa   = f_relleno_cadena(f_ciudad_empresa(codigo_empresa)," ","D",40)
	
	registro = ls_tipo_lote +&
  	           ls_codigo_registro +&
	           ls_nif_ordenante +&			
	           ls_nombre_ordenante +&	
	           ls_direccion_ordenante +&	
	           ls_codigo_postal +&	
	           ls_poblacion_empresa
					  
	ll_total_registros++					  
	ll_donde = lds_n_34.insertrow(0)	  
	lds_n_34.object.registro[ll_donde] = registro

	for indice = 1 to total
		f_mensaje_proceso("Generando fichero",indice,total)

		//Primero
		proveedor         = dw_detalle.object.proveedor[indice]
		pagado            = dw_detalle.object.importe[indice]
		
		ll_total_beneficiarios ++
		
		ls_codigo_registro     = "B"
		ls_codigo_beneficiario = f_cif_genter(codigo_empresa,'P',proveedor)
		ls_codigo_beneficiario = f_tratar_nif(ls_codigo_beneficiario,proveedor,f_pais_genter(codigo_empresa,'P',proveedor))
		ls_codigo_beneficiario = f_relleno_cadena(ls_codigo_beneficiario," ","I",12)
		ls_importe_a_abonar    = f_relleno_cadena(string(pagado*100,"0000000000"),"0","I",10)
		ls_nombre_beneficiario = f_relleno_cadena(f_razon_genter(codigo_empresa,"P",proveedor)," ","D",40)
		ls_idioma              = "01"
		ls_codigo_postal       = f_relleno_cadena(f_postal_genter(codigo_empresa,"P",proveedor),"0","I",5)
		ls_direccion_beneficiario = f_relleno_cadena(f_domicilio_genter(codigo_empresa,"P",proveedor)," ","D",40)
		if ls_tipo_lote = "71" then		
			ls_fecha_vencimiento = string(dw_detalle.object.fvto[indice],"yyyymmdd")
		else
			ls_fecha_vencimiento = f_relleno_cadena(""," ","D",8)
		end if
		ls_documento_barrado = "S"
		ls_no_utilizado      = f_relleno_cadena(""," ","D",17)
		
		ld_total_importe_cheques += pagado			
		
		registro = ls_tipo_lote +&
					  ls_codigo_registro +&
					  ls_codigo_beneficiario +&			
					  ls_importe_a_abonar +&	
					  ls_nombre_beneficiario +&	
					  ls_idioma +&	
					  ls_codigo_postal +&
					  ls_direccion_beneficiario +&
					  ls_fecha_vencimiento +&
					  ls_documento_barrado +&
					  ls_no_utilizado
			
		ll_total_registros++
		ll_donde = lds_n_34.insertrow(0)	  
		lds_n_34.object.registro[ll_donde] = registro
	
		//Segundo

		ls_codigo_registro        = "P"
		ls_poblacion_beneficiario = f_relleno_cadena(f_localidad_genter(codigo_empresa,"P",proveedor)," ","D",40)
		ls_provincia_beneficiario = f_relleno_cadena(f_nombre_provincia(f_pais_genter(codigo_empresa,"P",proveedor),f_provincia_genter(codigo_empresa,"P",proveedor))," ","D",20)
		ls_no_utilizado           = f_relleno_cadena(""," ","D",63)
		
		registro = ls_tipo_lote +&
					  ls_codigo_registro +&
					  ls_codigo_beneficiario +&
					  ls_poblacion_beneficiario +&
					  ls_provincia_beneficiario +&
					  ls_no_utilizado						  
		
		ll_total_registros++
		ll_donde = lds_n_34.insertrow(0)	  
		lds_n_34.object.registro[ll_donde] = registro			
		
		//Tercero
		ls_facturas    = ""
		ls_proveedor   = dw_detalle.object.proveedor[indice]
		ldt_fecha_pago = dw_detalle.object.fvto[indice]
		ls_moneda      = dw_detalle.object.moneda[indice]
		
		for ll_indice2 = 1 to ll_total2
			ls_marca = dw_1.getitemstring(ll_indice2,"marca")
			if ls_marca = "S" then
				ls_prove      = dw_1.object.proveedor[ll_indice2]
				ldt_fvto	     = dw_1.object.fvto[ll_indice2]
				ls_moneda_fra = dw_1.object.moneda[ll_indice2]
				
				if ls_prove = ls_proveedor and ldt_fecha_pago = ldt_fvto and ls_moneda = ls_moneda_fra then
					ls_fra 	 = dw_1.object.fra[ll_indice2]
					ll_recibo = dw_1.object.recibo[ll_indice2]
					
					ls_facturas += ls_fra+" Recibo "+string(ll_recibo,"###0")+", "
				end if
			end if
		next

		ls_codigo_registro        = "C"
		ls_concepto               = "PAGO FACTURA Nº "+ls_facturas
		ls_concepto               = f_relleno_cadena(ls_concepto," ","D",96)
		ls_no_utilizado           = f_relleno_cadena(""," ","D",3)
		
		registro = ls_tipo_lote +&
					  ls_codigo_registro +&
					  ls_codigo_beneficiario +&
					  ls_concepto +&
					  ls_no_utilizado						  
		
		ll_total_registros++
		ll_donde = lds_n_34.insertrow(0)	  
		lds_n_34.object.registro[ll_donde] = registro						

	next	


	//Aqui insertaremos el primer registro
	ls_codigo_registro         = "E"
	ls_nif_ordenante 		      = f_relleno_cadena(f_tratar_nif(cif_empresa,"empresa",f_pais_empresa(codigo_empresa))," ","D",10)
	ls_fecha_de_la_remesa      = string(today(),"yyyymmdd")
	ls_fecha_de_pago           = string(today(),"yyyymmdd")
	ls_banco_cargo_ordenante   = f_relleno_cadena(entidad_empresa,"0","I",4)
	ls_oficina_cargo_ordenente = f_relleno_cadena(oficina_empresa,"0","I",4)
	ls_cuenta_cargo_ordenente  = f_relleno_cadena(cuenta_empresa,"0","I",10)
	ls_total_importe_cheques   = f_relleno_cadena(string(ld_total_importe_cheques*100,"000000000000"),"0","I",12)
	ls_total_registros         = f_relleno_cadena(string(ll_total_registros,"00000000"),"0","I",8)
	ls_total_de_beneficiarios  = f_relleno_cadena(string(ll_total_beneficiarios,"00000000"),"0","I",8)
	ls_forma_de_envio          = "B" //B entrega al beneficiario/O distribucion a traves de la oficina
	ls_concepto_comun          = f_relleno_cadena("-"," ","I",60)
	ls_tipo_envio              = " " // En blanco por BS online,O distribucuion a traves de la oficina
	ls_version                 = "1"
	
	
	registro = ls_tipo_lote +&
  	           ls_codigo_registro +&
	           ls_nif_ordenante +&
	           ls_fecha_de_la_remesa +&
	           ls_fecha_de_pago +&
	           ls_banco_cargo_ordenante +&
	           ls_oficina_cargo_ordenente +&
	           ls_cuenta_cargo_ordenente +&
	           ls_total_importe_cheques +&
	           ls_total_registros +&
	           ls_total_de_beneficiarios +&
	           ls_forma_de_envio +&
	           ls_concepto_comun +&
	           ls_tipo_envio +&
	           ls_version
			
	ll_donde = lds_n_34.insertrow(1)	  
	lds_n_34.object.registro[ll_donde] = registro
	
end if

ls_fecha = string(date(em_fcarta.text),"ddmmyyyy")
//fichero = "PAG"+uo_banco.em_codigo.text+ls_fecha 

//fichero = "A:\" + fichero //em_directorio.text + 

ls_ruta = "N34" + uo_banco.em_codigo.text+ls_fecha 
if GetFileSaveName("Fichero N34",ls_ruta,fichero,"txt","Texto (*.TXT),*.TXT") = 1 then
	if lds_n_34.rowcount() > 0 then
		res = lds_n_34.saveas(fichero,text!,false)
		if res = -1 then f_mensaje("ERROR","Al grabar el fichero")
		if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
	end if		
end if	

destroy lds_n_34
end subroutine

protected subroutine f_grabar_norma34_sepa ();long ll_indice,ll_total,ll_donde
string ls_fomato_fecha = 'AAAAMMDD',ls_registro,ls_sel
datastore ds_norma_34

ls_sel = "select space(600) as registro from empresas where 0 = 1"

f_cargar_cursor_transaccion(sqlca,ds_norma_34,ls_sel)

//Registro de cabecera_ordenante
string ls_codigo_de_registro,ls_codigo_de_operacion,ls_version_cuaderno,ls_numero_de_dato
string ls_identificacion_del_ordenante_nif,ls_identificacion_del_ordenante_sufijo
string ls_fecha_de_creacion_del_fichero,ls_fecha_de_ejecucion_ordenes,ls_identificacion_de_la_cuenta_del_ordenante
string ls_cuenta_del_ordenante,ls_detalle_del_cargo,ls_nombre_del_ordenante,ls_direccion_del_ordenante1
string ls_direccion_del_ordenante2,ls_direccion_del_ordenante3,ls_pais_del_ordenante,ls_libre

string  ls_empresas_nombre,ls_empresas_cif,ls_empresas_cl_domicilio,ls_empresas_nu_domicilio,ls_empresas_domicilio
string  ls_empresas_ciudad,ls_empresas_codpostal,ls_empresas_pais,ls_empresas_provincia
string  ls_banco,ls_carbancos_codigo_swift

ls_banco = uo_banco.em_codigo.text

select isnull(empresas.nombre,''),
		 isnull(empresas.cif,''),
		 isnull(empresas.cl_domicilio,''),
		 isnull(empresas.nu_domicilio,''),
		 isnull(empresas.domicilio,''),
		 isnull(empresas.ciudad,''),
		 isnull(empresas.codpostal,''),
		 isnull(empresas.pais,''),
		 isnull(empresas.provincia,'')
into   :ls_empresas_nombre,
		 :ls_empresas_cif,
		 :ls_empresas_cl_domicilio,
		 :ls_empresas_nu_domicilio,
		 :ls_empresas_domicilio,
		 :ls_empresas_ciudad,
		 :ls_empresas_codpostal,
		 :ls_empresas_pais,
		 :ls_empresas_provincia
from   empresas
where  empresas.empresa = :codigo_empresa;

select isnull(carbancos.codigo_swift,'')
into   :ls_carbancos_codigo_swift
from   carbancos
where  carbancos.empresa = :codigo_empresa
and    carbancos.banco   = :ls_banco;

ls_codigo_de_registro                        = '01'
ls_codigo_de_operacion                       = 'ORD'
ls_version_cuaderno                          = '34145'
ls_numero_de_dato                            = '001'
ls_identificacion_del_ordenante_nif          = f_tratar_nif(ls_empresas_cif,'',f_pais_empresa(codigo_empresa))
ls_identificacion_del_ordenante_sufijo       = ''
ls_fecha_de_creacion_del_fichero             = string(today(),ls_fomato_fecha)
ls_fecha_de_ejecucion_ordenes                = string(date(em_fcarta.text),ls_fomato_fecha)
ls_identificacion_de_la_cuenta_del_ordenante = 'A'
ls_cuenta_del_ordenante                      = ls_carbancos_codigo_swift
ls_detalle_del_cargo                         = '1' //0 Sin detalle; 1 con detalle
ls_nombre_del_ordenante                      = ls_empresas_nombre
ls_direccion_del_ordenante1                  = ls_empresas_cl_domicilio+' '+ls_empresas_domicilio+' '+ls_empresas_nu_domicilio
ls_direccion_del_ordenante2                  = ls_empresas_codpostal+' '+ls_empresas_ciudad
ls_direccion_del_ordenante3                  = f_nombre_provincia(ls_empresas_pais,ls_empresas_provincia)
ls_pais_del_ordenante                        = f_clave_pais(ls_empresas_pais)
ls_libre                                     = ''

//Luego de cargar los campos los tratamos para ajustarlos
ls_codigo_de_registro                        = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
ls_codigo_de_operacion                       = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
ls_version_cuaderno                          = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
ls_numero_de_dato                            = f_relleno_cadena(ls_numero_de_dato,'0','I',3)
ls_identificacion_del_ordenante_nif          = f_relleno_cadena(ls_identificacion_del_ordenante_nif,' ','D',9)
ls_identificacion_del_ordenante_sufijo       = f_relleno_cadena(ls_identificacion_del_ordenante_sufijo,' ','D',3)
ls_fecha_de_creacion_del_fichero             = f_relleno_cadena(ls_fecha_de_creacion_del_fichero,'0','I',8)
ls_fecha_de_ejecucion_ordenes                = f_relleno_cadena(ls_fecha_de_ejecucion_ordenes,'0','I',8)
ls_identificacion_de_la_cuenta_del_ordenante = f_relleno_cadena(ls_identificacion_de_la_cuenta_del_ordenante,' ','D',1)
ls_cuenta_del_ordenante                      = f_relleno_cadena(ls_cuenta_del_ordenante,' ','D',34)
ls_detalle_del_cargo                         = f_relleno_cadena(ls_detalle_del_cargo,'0','I',1)
ls_nombre_del_ordenante                      = f_relleno_cadena(ls_nombre_del_ordenante,' ','D',70)
ls_direccion_del_ordenante1                  = f_relleno_cadena(ls_direccion_del_ordenante1,' ','D',50)
ls_direccion_del_ordenante2                  = f_relleno_cadena(ls_direccion_del_ordenante2,' ','D',50)
ls_direccion_del_ordenante3                  = f_relleno_cadena(ls_direccion_del_ordenante3,' ','D',40)
ls_pais_del_ordenante                        = f_relleno_cadena(ls_pais_del_ordenante,' ','D',2)
ls_libre                                     = f_relleno_cadena(ls_libre,' ','D',311)

ls_registro = ls_codigo_de_registro +&
				  ls_codigo_de_operacion +&
				  ls_version_cuaderno +&
				  ls_numero_de_dato +&
				  ls_identificacion_del_ordenante_nif +&
				  ls_identificacion_del_ordenante_sufijo +&
				  ls_fecha_de_creacion_del_fichero +&
				  ls_fecha_de_ejecucion_ordenes +&
				  ls_identificacion_de_la_cuenta_del_ordenante +&
				  ls_cuenta_del_ordenante +&
				  ls_detalle_del_cargo +&
				  ls_nombre_del_ordenante +&
				  ls_direccion_del_ordenante1 +&
				  ls_direccion_del_ordenante2 +&
				  ls_direccion_del_ordenante3 +&
				  ls_pais_del_ordenante +&
				  ls_libre
				  
ll_donde = ds_norma_34.insertrow(0)				  
ds_norma_34.object.registro[ll_donde] = ls_registro
/////
//Registro de cabecera de transferencias SEPA
ls_codigo_de_registro                        = '02'
ls_codigo_de_operacion                       = 'SCT'
ls_version_cuaderno                          = '34145'
ls_libre                                     = ''

//Luego de cargar los campos los tratamos para ajustarlos
ls_codigo_de_registro                        = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
ls_codigo_de_operacion                       = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
ls_version_cuaderno                          = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
ls_libre                                     = f_relleno_cadena(ls_libre,' ','D',578)

ls_registro = ls_codigo_de_registro +&
				  ls_codigo_de_operacion +&
				  ls_version_cuaderno +&
				  ls_identificacion_del_ordenante_nif +&
				  ls_identificacion_del_ordenante_sufijo +&
				  ls_libre
				  
ll_donde = ds_norma_34.insertrow(0)				  
ds_norma_34.object.registro[ll_donde] = ls_registro

//Registros individuales obligatorios
string ls_referencia_del_ordenante,ls_identificador_de_la_cuenta_del_beneficiario
string ls_cuenta_del_beneficiario,ls_importe_de_transferencia,ls_clave_de_gastos,ls_bic_entidad_beneficiario
string ls_nombre_del_beneficiario,ls_direccion_del_beneficiario1,ls_direccion_del_beneficiario2,ls_direccion_del_beneficiario3
string ls_pais_del_beneficiario,ls_concepto_enviado_por_el_ordenante_al_beneficiario,ls_identificacion_de_la_instruccion
string ls_tipo_de_transferencia,ls_proposito_de_la_transferencia

string ls_proveedor,ls_comproveedores_codigo_iban,ls_comproveedores_codigo_swift,ls_comproveedores_cif,ls_domiciliacion_proveedor
dec    ld_pagado,ld_total_pagado = 0

ll_total = dw_detalle.rowcount()
for ll_indice = 1 to ll_total
	ls_proveedor     = dw_detalle.object.proveedor[ll_indice]
	ld_pagado        = dw_detalle.object.importe[ll_indice]
	ld_total_pagado += ld_pagado
	
	select isnull(comproveedores.codigo_iban,''),
			 isnull(comproveedores.codigo_swift,''),
			 isnull(genter.cif,'')
	into   :ls_comproveedores_codigo_iban,
			 :ls_comproveedores_codigo_swift,
			 :ls_comproveedores_cif
	from   comproveedores,genter
	where  genter.empresa  = comproveedores.empresa
	and    genter.codigo   = comproveedores.codigo
	and    genter.empresa  = :codigo_empresa
	and    genter.codigo   = :ls_proveedor
	and    genter.tipoter  = 'P';
	
	ls_codigo_de_registro                                = '03'
	ls_codigo_de_operacion                               = 'SCT'
	ls_version_cuaderno                                  = '34145'	
	ls_numero_de_dato                                    = '002'
	ls_referencia_del_ordenante                          = f_tratar_nif(ls_comproveedores_cif,ls_proveedor,f_pais_genter(codigo_empresa,'P',ls_proveedor))
	ls_identificador_de_la_cuenta_del_beneficiario       = 'A'
	ls_cuenta_del_beneficiario                           = ls_comproveedores_codigo_iban
	ls_importe_de_transferencia                          = string(ld_pagado*100,"##########0")
	ls_clave_de_gastos                                   = '3'
	ls_bic_entidad_beneficiario                          = ls_comproveedores_codigo_swift
	ls_nombre_del_beneficiario                           = f_razon_genter(codigo_empresa,'P',ls_proveedor)
	ls_direccion_del_beneficiario1                       = ''
	ls_direccion_del_beneficiario2                       = ''
	ls_direccion_del_beneficiario3                       = ''
	ls_pais_del_beneficiario                             = ''
	ls_concepto_enviado_por_el_ordenante_al_beneficiario = 'PAGO FRA '+f_facturas_linea_detalle(ll_indice)
	ls_identificacion_de_la_instruccion                  = ''
	ls_tipo_de_transferencia                             = 'SUPP'
	ls_proposito_de_la_transferencia                     = 'SUPP'
	ls_libre                                             = ''
	
	//Luego de cargar los campos los tratamos para ajustarlos
	ls_codigo_de_registro                                = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
	ls_codigo_de_operacion                               = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
	ls_version_cuaderno                                  = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
	ls_numero_de_dato                                    = f_relleno_cadena(ls_numero_de_dato,'0','I',3)
	ls_referencia_del_ordenante                          = f_relleno_cadena(ls_referencia_del_ordenante,' ','D',35)
	ls_identificador_de_la_cuenta_del_beneficiario       = f_relleno_cadena(ls_identificador_de_la_cuenta_del_beneficiario,' ','D',1)
	ls_cuenta_del_beneficiario                           = f_relleno_cadena(ls_cuenta_del_beneficiario,' ','D',34)
	ls_importe_de_transferencia                          = f_relleno_cadena(ls_importe_de_transferencia,'0','I',11)
	ls_clave_de_gastos                                   = f_relleno_cadena(ls_clave_de_gastos,'0','I',1)
	ls_bic_entidad_beneficiario                          = f_relleno_cadena(ls_bic_entidad_beneficiario,' ','D',11)
	ls_nombre_del_beneficiario                           = f_relleno_cadena(ls_nombre_del_beneficiario,' ','D',70)
	ls_direccion_del_beneficiario1                       = f_relleno_cadena(ls_direccion_del_beneficiario1,' ','D',50)
	ls_direccion_del_beneficiario2                       = f_relleno_cadena(ls_direccion_del_beneficiario2,' ','D',50)
	ls_direccion_del_beneficiario3                       = f_relleno_cadena(ls_direccion_del_beneficiario3,' ','D',40)
	ls_pais_del_beneficiario                             = f_relleno_cadena(ls_pais_del_beneficiario,' ','D',2)
	ls_concepto_enviado_por_el_ordenante_al_beneficiario = f_relleno_cadena(ls_concepto_enviado_por_el_ordenante_al_beneficiario,' ','D',140)
	ls_identificacion_de_la_instruccion                  = f_relleno_cadena(ls_identificacion_de_la_instruccion,' ','D',35)
	ls_tipo_de_transferencia                             = f_relleno_cadena(ls_tipo_de_transferencia,' ','D',4)
	ls_proposito_de_la_transferencia                     = f_relleno_cadena(ls_proposito_de_la_transferencia,' ','D',4)
	ls_libre                                             = f_relleno_cadena(ls_libre,' ','D',99)
	
	ls_registro = ls_codigo_de_registro +&
					  ls_codigo_de_operacion +&
					  ls_version_cuaderno +&
					  ls_numero_de_dato +&
					  ls_referencia_del_ordenante +&
					  ls_identificador_de_la_cuenta_del_beneficiario +&
					  ls_cuenta_del_beneficiario +&
					  ls_importe_de_transferencia +&
					  ls_clave_de_gastos +&
					  ls_bic_entidad_beneficiario +&
					  ls_nombre_del_beneficiario +&
					  ls_direccion_del_beneficiario1 +&
					  ls_direccion_del_beneficiario2 +&
					  ls_direccion_del_beneficiario3 +&
					  ls_pais_del_beneficiario +&
					  ls_concepto_enviado_por_el_ordenante_al_beneficiario +&
					  ls_identificacion_de_la_instruccion +&
					  ls_tipo_de_transferencia +&
					  ls_proposito_de_la_transferencia +&
					  ls_libre
	
	ll_donde = ds_norma_34.insertrow(0)				  
	ds_norma_34.object.registro[ll_donde] = ls_registro	
		
next

//Registro de totales
string ls_total_importes,ls_numero_de_registros,ls_total_registros

ls_codigo_de_registro  = '04'
ls_codigo_de_operacion = 'SCT'
ls_total_importes      = string(ld_total_pagado*100,"################0")
ls_numero_de_registros = string(ll_total,"#######0")
ls_total_registros     = string(ll_total+2,"#########0")
ls_libre               = ''

ls_codigo_de_registro  = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
ls_codigo_de_operacion = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
ls_total_importes      = f_relleno_cadena(ls_total_importes,'0','I',17)
ls_numero_de_registros = f_relleno_cadena(ls_numero_de_registros,'0','I',8)
ls_total_registros     = f_relleno_cadena(ls_total_registros,'0','I',10)
ls_libre               = f_relleno_cadena(ls_libre,' ','D',560)

ls_registro = ls_codigo_de_registro +&
				  ls_codigo_de_operacion +&
				  ls_total_importes +&
				  ls_numero_de_registros +&
				  ls_total_registros +&
				  ls_libre

ll_donde = ds_norma_34.insertrow(0)				  
ds_norma_34.object.registro[ll_donde] = ls_registro	
/////
//Registro de totales general
ls_codigo_de_registro  = '99'
ls_codigo_de_operacion = 'ORD'
ls_total_importes      = string(ld_total_pagado*100,"################0")
ls_numero_de_registros = string(ll_total,"#######0")
ls_total_registros     = string(ll_total+4,"#########0")
ls_libre               = ''

ls_codigo_de_registro  = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
ls_codigo_de_operacion = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
ls_total_importes      = f_relleno_cadena(ls_total_importes,'0','I',17)
ls_numero_de_registros = f_relleno_cadena(ls_numero_de_registros,'0','I',8)
ls_total_registros     = f_relleno_cadena(ls_total_registros,'0','I',10)
ls_libre               = f_relleno_cadena(ls_libre,' ','D',560)

ls_registro = ls_codigo_de_registro +&
				  ls_codigo_de_operacion +&
				  ls_total_importes +&
				  ls_numero_de_registros +&
				  ls_total_registros +&
				  ls_libre

ll_donde = ds_norma_34.insertrow(0)				  
ds_norma_34.object.registro[ll_donde] = ls_registro	
/////

string ls_mes,ls_fichero,ls_fullname,ls_filename
long   ll_res


ls_fichero = "NORMA34"

IF GetFileSaveName ("Salvar N34", ls_fullname, ls_filename, "TXT", "Ficheros Texto (*.txt),*.txt") = 1 THEN

//	fichero = "A:\" + fichero //em_directorio.text + 
	
	if ds_norma_34.rowcount() > 0 then
	//	res = ds_norma_34.saveas(fichero,text!,false)
		ll_res = ds_norma_34.saveas(ls_fullname,text!,false)
//		if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
		if ll_res = -1 then f_mensaje("ERROR","Al grabar al fichero")
	end if
	
END IF

end subroutine

public function string f_facturas_linea_detalle (long arg_row);string   ls_proveedor,ls_proveedor_2,ls_documento,ls_moneda,ls_facturas,ls_marca,ls_moneda_fra,ls_agrupar,ls_factura
datetime ldt_fecha_pago,ldt_fvto,ldt_fecha_factura
long     ll_anyo,ll_orden,ll_indice

ls_proveedor   = dw_detalle.getitemstring(arg_row,"proveedor")
ldt_fecha_pago = dw_detalle.getitemdatetime(arg_row,"fvto")				
ls_documento   = dw_detalle.object.documento[arg_row]
ls_moneda      = dw_detalle.getitemstring(arg_row,"moneda")
ll_anyo        = dw_detalle.object.anyo[arg_row]
ll_orden       = dw_detalle.object.orden[arg_row]

if ll_anyo = 0 and ll_orden = 0 then
	for ll_indice = 1 to dw_1.rowcount()
						
		ls_proveedor_2 = dw_1.getitemstring(ll_indice,"proveedor")
		ldt_fvto      = dw_1.getitemdatetime(ll_indice,"fvto")
		ls_marca       = dw_1.getitemstring(ll_indice,"marca")
		ls_moneda_fra  = dw_1.getitemstring(ll_indice,"moneda")
		ls_agrupar     = dw_1.getitemstring(ll_indice,"carpagos_agrupar")
		//fecha_pago
		if ls_proveedor = ls_proveedor_2  and ls_marca = "S" and ldt_fecha_pago = ldt_fvto and ls_moneda = ls_moneda_fra and ls_agrupar = "S" then
			
			ls_factura        = dw_1.object.fra[ll_indice]
			ldt_fecha_factura = dw_1.object.ffra[ll_indice] 

			if trim(ls_facturas) = '' then
				ls_facturas = ls_factura //+"/"+string(year(date(ldt_fecha_factura)),'###0')
			else
				ls_facturas += ","+ls_factura //+"/"+string(year(date(ldt_fecha_factura)),'###0')
			end if
		end if
	next
else
	ll_indice = dw_1.find("anyo = "+string(ll_anyo,"####")+" and orden = "+string(ll_orden,"######"),1,dw_1.rowcount())
	
	if ll_indice > 0 then
		ls_factura        = dw_1.object.fra[ll_indice]
		ldt_fecha_factura = dw_1.object.ffra[ll_indice] 

		if trim(ls_facturas) = '' then
			ls_facturas = ls_factura//+"/"+string(year(date(ldt_fecha_factura)),'###0')
		else
			ls_facturas += ","+ls_factura//+"/"+string(year(date(ldt_fecha_factura)),'###0')
		end if					
	end if
end if

return ls_facturas
end function

protected subroutine f_grabar_norma34_sepa_xml ();//---------------------------------------------------------------------------------------------------------------------
//ADEUDOS DIRECTOS SEPA:
//---------------------------------------------------------------------------------------------------------------------

String lineaXML, linea, ls_proveedor, ls_domiciliacion , v_mandato, idAcreedor, moneda,ls_cif_empresa,ls_pais_empresa
long pos
boolean b_error
string sufijo,referencia_adeudo,nombre_fichero,ls_sufijo_mensajeid,ls_iban_correcto
string ls_comproveedores_codigo_iban,ls_comproveedores_codigo_swift,ls_comproveedores_cif
datetime ldt_fecha_pago,ldt_fecha_alta
datastore dw_core_b2b

f_cargar_cursor_transaccion(sqlca,dw_core_b2b,'select space(500) as linea from empresas where 0 = 1')

dw_core_b2b.SetTransObject(SQLCA) 
dw_core_b2b.Reset()

//
//	ls_proveedor     = dw_detalle.object.proveedor[ll_indice]
//	ld_importe        = dw_detalle.object.importe[ll_indice]
//	ld_total_importe += ld_importe
//	
//	select isnull(comproveedores.codigo_iban,''),
//			 isnull(comproveedores.codigo_swift,''),
//			 isnull(genter.cif,'')
//	into   :ls_comproveedores_codigo_iban,
//			 :ls_comproveedores_codigo_swift,
//			 :ls_comproveedores_cif
//	from   comproveedores,genter
//	where  genter.empresa  = comproveedores.empresa
//	and    genter.codigo   = comproveedores.codigo
//	and    genter.empresa  = :codigo_empresa
//	and    genter.codigo   = :ls_proveedor
//	and    genter.tipoter  = 'P';
//

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

//Encabezado
SetNull(lineaXML) 
lineaXML = "<?xml version='1.0' encoding='utf-8'?>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 


//Raíz
//---------------------------------------------------------------------------------------------------------------------
// xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'

SetNull(lineaXML) 
lineaXML = "<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.001.001.03'>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "<CstmrCdtTrfInitn>"
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
				idAcreedor = ls_cif_empresa+'000' //f_calcular_identificador_acreedor(ls_cif_empresa,ls_pais_empresa)
				linea = idAcreedor+ls_sufijo_mensajeid
				//Si la remesa es al descuento se añade el prefijo FSDD al identificador del mensaje
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
				numOperaciones = dw_detalle.RowCount()
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
				ctrlsum = dec(dw_detalle.describe('evaluate("sum(importe for all)",1)'))
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

for i = 1 to dw_detalle.RowCount()
	ls_proveedor     = dw_detalle.object.proveedor[i]
	ldt_fecha_pago  = datetime(date(em_fcarta.text))

	select isnull(comproveedores.codigo_iban,''),
			 isnull(comproveedores.codigo_swift,''),
			 isnull(genter.cif,'')
	into   :ls_comproveedores_codigo_iban,
			 :ls_comproveedores_codigo_swift,
			 :ls_comproveedores_cif
	from   comproveedores,genter
	where  genter.empresa  = comproveedores.empresa
	and    genter.codigo   = comproveedores.codigo
	and    genter.empresa  = :codigo_empresa
	and    genter.codigo   = :ls_proveedor
	and    genter.tipoter  = 'P';	
	
	//Información del pago
	SetNull(lineaXML) 
	lineaXML = "<PmtInf>"
	pos = dw_core_b2b.InsertRow(0) 
	dw_core_b2b.Object.linea[pos] = lineaXML 
	
		//Identificación de la información del pago
		//Referencia única, asignada por el presentador, para identificar inequívocamente el bloque de información del pago dentro del mensaje
			
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = upper('PAGO FRA '+f_facturas_linea_detalle(i))
		linea = left(linea,35)
		lineaXML = "<PmtInfId>" + linea + "</PmtInfId>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 35 ) then
			messagebox('Error', "Identificación de la información de pago : Longitud no puede ser > 35" + lineaXML)
			b_error = true
		end if
		
		//Método de pago: TRF o CHK
		SetNull(lineaXML) 	
		SetNull(linea) 
		linea = ''
		lineaXML = "<PmtMtd>TRF</PmtMtd>"								
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML 
		if (len( linea ) > 3 ) then
			messagebox('Error', "Método de pago : Longitud no puede ser > 2" + lineaXML)
			b_error = true
		end if
				
		//Fecha de cobro
		SetNull(lineaXML) 	
		SetNull(linea)
		linea = String(ldt_fecha_pago, "yyyy-mm-dd")//f_iso_date_con_guiones(datetime(date(String(dw_detalle.object.fvto[i], "yyyy-mm-dd"))))
		lineaXML = "<ReqdExctnDt>" + linea +  "</ReqdExctnDt>"						
		pos = dw_core_b2b.InsertRow(0) 
		dw_core_b2b.Object.linea[pos] = lineaXML
		if (len( linea ) > 10 ) then
				messagebox('Error', "Fecha de pago: Longitud no puede ser > 8" + lineaXML)
				b_error = true
		end if
			
		//Deudor
		SetNull(lineaXML) 
		lineaXML = "<Dbtr>"
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
								
			//Fin - Deudor
			SetNull(lineaXML) 
			lineaXML = "</Dbtr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
						
			//Cuenta del Deudor
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
					linea = f_carbancos_codigo_iban(codigo_empresa,uo_banco.em_codigo.text)
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
				
			
			// Fin -Cuenta del Deudor
			SetNull(lineaXML) 
			lineaXML = "</DbtrAcct>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 
			
			//Moneda - OPCIONAL
			
			//Entidad del Deudor
			SetNull(lineaXML) 
			lineaXML = "<DbtrAgt>"
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
					linea =  f_carbancos_codigo_swift(codigo_empresa,uo_banco.em_codigo.text)
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
				
				
			
			//Fin - Entidad del Deudor
			SetNull(lineaXML) 
			lineaXML = "</DbtrAgt>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

			SetNull(lineaXML) 
			lineaXML = "<ChrgBr>SLEV</ChrgBr>"
			pos = dw_core_b2b.InsertRow(0) 
			dw_core_b2b.Object.linea[pos] = lineaXML 

										
			//Información de la operación de adeudo directo [1..N]
			//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			SetNull(lineaXML) 
			lineaXML = "<CdtTrfTxInf>"
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
					referencia_adeudo = upper('PAGO FRA '+f_facturas_linea_detalle(I))
					linea = referencia_adeudo
					linea = left(linea,35)
					lineaXML = "<EndToEndId>" + linea +  "</EndToEndId>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 35 ) then
							messagebox('Error', "Operación de Transferencia - Identificación de extremo a extremo : Longitud no puede ser > 35 " + linea)
							b_error = true
					end if
					
				//Fin - Identificación del pago
				SetNull(lineaXML) 
				lineaXML = "</PmtId>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
				
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
				lineaXML = "<CtgyPurp>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
		
				SetNull(lineaXML) 	
				lineaXML = "<Cd>SUPP</Cd>" //Codigo para pago a proveedores
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
		
				SetNull(lineaXML) 	
				lineaXML = "</CtgyPurp>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
		
				SetNull(lineaXML) 	
				lineaXML = "</PmtTpInf>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 
												
				//Importe ordenado
				SetNull(lineaXML) 
				lineaXML = "<Amt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
				//Importe del adeudo directo expresado en euros (AT-06)
				SetNull(lineaXML) 	
				SetNull(linea)				
				linea =  f_sustituir(String(dw_detalle.object.importe[i], "########0.00"),',','.')
				moneda = 'EUR'//f_moneda_iso(String(dw_detalle.object.monedas[i]))
					//Atributo Ccy (moneda) es obligatorio
				lineaXML = "<InstdAmt Ccy='" + moneda + "'" + ">" + linea +  "</InstdAmt>"						
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML
				if (len( linea ) > 13 ) then //12 + separador decimal = 13
						messagebox('Error', "Operación de Adeudo Directo - Importe ordenado: Longitud no puede ser > 12 " + linea)
						b_error = true
				end if

				//Fin Importe ordenado
				SetNull(lineaXML) 
				lineaXML = "</Amt>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
												
												
				//Entidad del beneficiario
				if trim(ls_comproveedores_codigo_swift) <> "" and 0 = 1 then
					SetNull(lineaXML) 
					lineaXML = "<CdtrAgt>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
							
							//Identificación de la entidad
							SetNull(lineaXML) 
							lineaXML = "<FinInstnId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
							
							linea = ls_comproveedores_codigo_swift
							lineaXML = "<BIC>" + linea +  "</BIC>"						
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
							if (len( linea ) > 34 ) then
									messagebox('Error', "Cuenta del Beneficiario - IBAN : Longitud no puede ser > 34" + linea)
									b_error = true
							end if
	
							//Identificación de la entidad
							SetNull(lineaXML) 
							lineaXML = "</FinInstnId>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML
					
					//Fin - Entidad del beneficiario
					SetNull(lineaXML) 
					lineaXML = "</CdtrAgt>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 
				end if				
				//Beneficiario
				SetNull(lineaXML) 
				lineaXML = "<Cdtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML 		
				
					//Nombre
					SetNull(lineaXML) 	
					SetNull(linea)
					linea =  f_razon_genter(codigo_empresa,'P',ls_proveedor)
					f_tratar_texto(linea)
					lineaXML = "<Nm>" + linea +  "</Nm>"						
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
					if (len( linea ) > 70 ) then
							messagebox('Error', "Deudor - Nombre : Longitud no puede ser > 70" + linea)
							b_error = true
					end if
					
					
					//Identificacion Beneficiario
					SetNull(lineaXML) 
					lineaXML = "<Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 							

						//Persona fisica
						SetNull(lineaXML) 
						lineaXML = "<PrvtId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML 							
	
							//Otra
							SetNull(lineaXML) 
							lineaXML = "<Othr>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 							
		
								//Nif
								SetNull(lineaXML) 	
								SetNull(linea)
								linea =  ls_comproveedores_cif
								f_tratar_texto(linea)
								lineaXML = "<Id>" + linea +  "</Id>"						
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML
								if (len( linea ) > 35 ) then
										messagebox('Error', "Identificador Beneficiario : Longitud no puede ser > 70" + linea)
										b_error = true
								end if		
							
							
								SetNull(lineaXML) 	
								SetNull(linea)
								linea = "NIE"
								lineaXML = "<Issr>" + linea +  "</Issr>"						
								pos = dw_core_b2b.InsertRow(0) 
								dw_core_b2b.Object.linea[pos] = lineaXML
								if (len( linea ) > 35 ) then
										messagebox('Error', "Identificador Beneficiario : Longitud no puede ser > 70" + linea)
										b_error = true
								end if									
							
							//Fin Otra
							SetNull(lineaXML) 
							lineaXML = "</Othr>"
							pos = dw_core_b2b.InsertRow(0) 
							dw_core_b2b.Object.linea[pos] = lineaXML 							
						
						
						//Fin Persona fisica
						SetNull(lineaXML) 
						lineaXML = "</PrvtId>"
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML 							

					
					//Fin Identificacion Beneficiario
					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML 							
					
				//Fin - Beneficiario
				SetNull(lineaXML) 
				lineaXML = "</Cdtr>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
					
				//Cuenta del beneficiario
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
						linea = ls_comproveedores_codigo_iban						
						lineaXML = "<IBAN>" + linea +  "</IBAN>"						
						pos = dw_core_b2b.InsertRow(0) 
						dw_core_b2b.Object.linea[pos] = lineaXML
						if (len( linea ) > 34 ) then
								messagebox('Error', "Cuenta del Beneficiario - IBAN : Longitud no puede ser > 34" + linea)
								b_error = true
						end if

					SetNull(lineaXML) 
					lineaXML = "</Id>"
					pos = dw_core_b2b.InsertRow(0) 
					dw_core_b2b.Object.linea[pos] = lineaXML
				
				
				//Fin - Cuenta del beneficiario
				SetNull(lineaXML) 
				lineaXML = "</CdtrAcct>"
				pos = dw_core_b2b.InsertRow(0) 
				dw_core_b2b.Object.linea[pos] = lineaXML					
				
			
			//Información de la operación de adeudo directo
			SetNull(lineaXML) 
			lineaXML = "</CdtTrfTxInf>"
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
lineaXML = "</CstmrCdtTrfInitn>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 

SetNull(lineaXML) 
lineaXML = "</Document>"
pos = dw_core_b2b.InsertRow(0) 
dw_core_b2b.Object.linea[pos] = lineaXML 


string ls_fullname,ls_filename
long   ll_res

nombre_fichero = "TRANSFERENCIAS_"+uo_banco.em_codigo.text+em_fcarta.text+".xml" 
//nombre_fichero = em_directorio.text+"\N190" + string(em_banco.text) + string(integer(cab.remesa),"0000_core_xml.TXT") 
IF GetFileSaveName ("Salvar N34", ls_fullname, nombre_fichero, "XML", "Ficheros XML (*.xml),*.xml") = 1 THEN
	dw_core_b2b.SaveAs(ls_fullname, text!, FALSE)
	
	destroy dw_core_b2b
	
	if b_error then
		f_mensaje("Atención","El fichero se ha grabado con algún error. Corrija los errores. Nombre del archivo : "  )
	else
		f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : "+nombre_fichero  )
	end if 
end if

//long ll_indice,ll_total,ll_donde
//string ls_fomato_fecha = 'AAAAMMDD',ls_registro,ls_sel
//datastore ds_norma_34
//
//ls_sel = "select space(600) as registro from empresas where 0 = 1"
//
//f_cargar_cursor_transaccion(sqlca,ds_norma_34,ls_sel)
//
////Registro de cabecera_ordenante
//string ls_codigo_de_registro,ls_codigo_de_operacion,ls_version_cuaderno,ls_numero_de_dato
//string ls_identificacion_del_ordenante_nif,ls_identificacion_del_ordenante_sufijo
//string ls_fecha_de_creacion_del_fichero,ls_fecha_de_ejecucion_ordenes,ls_identificacion_de_la_cuenta_del_ordenante
//string ls_cuenta_del_ordenante,ls_detalle_del_cargo,ls_nombre_del_ordenante,ls_direccion_del_ordenante1
//string ls_direccion_del_ordenante2,ls_direccion_del_ordenante3,ls_pais_del_ordenante,ls_libre
//
//string  ls_empresas_nombre,ls_empresas_cif,ls_empresas_cl_domicilio,ls_empresas_nu_domicilio,ls_empresas_domicilio
//string  ls_empresas_ciudad,ls_empresas_codpostal,ls_empresas_pais,ls_empresas_provincia
//string  ls_banco,ls_carbancos_codigo_swift
//
//ls_banco = uo_banco.em_codigo.text
//
//select isnull(empresas.nombre,''),
//		 isnull(empresas.cif,''),
//		 isnull(empresas.cl_domicilio,''),
//		 isnull(empresas.nu_domicilio,''),
//		 isnull(empresas.domicilio,''),
//		 isnull(empresas.ciudad,''),
//		 isnull(empresas.codpostal,''),
//		 isnull(empresas.pais,''),
//		 isnull(empresas.provincia,'')
//into   :ls_empresas_nombre,
//		 :ls_empresas_cif,
//		 :ls_empresas_cl_domicilio,
//		 :ls_empresas_nu_domicilio,
//		 :ls_empresas_domicilio,
//		 :ls_empresas_ciudad,
//		 :ls_empresas_codpostal,
//		 :ls_empresas_pais,
//		 :ls_empresas_provincia
//from   empresas
//where  empresas.empresa = :codigo_empresa;
//
//select isnull(carbancos.codigo_swift,'')
//into   :ls_carbancos_codigo_swift
//from   carbancos
//where  carbancos.empresa = :codigo_empresa
//and    carbancos.banco   = :ls_banco;
//
//ls_codigo_de_registro                        = '01'
//ls_codigo_de_operacion                       = 'ORD'
//ls_version_cuaderno                          = '34145'
//ls_numero_de_dato                            = '001'
//ls_identificacion_del_ordenante_nif          = f_tratar_nif(ls_empresas_cif,'',f_pais_empresa(codigo_empresa))
//ls_identificacion_del_ordenante_sufijo       = ''
//ls_fecha_de_creacion_del_fichero             = string(today(),ls_fomato_fecha)
//ls_fecha_de_ejecucion_ordenes                = string(date(em_fcarta.text),ls_fomato_fecha)
//ls_identificacion_de_la_cuenta_del_ordenante = 'A'
//ls_cuenta_del_ordenante                      = ls_carbancos_codigo_swift
//ls_detalle_del_cargo                         = '1' //0 Sin detalle; 1 con detalle
//ls_nombre_del_ordenante                      = ls_empresas_nombre
//ls_direccion_del_ordenante1                  = ls_empresas_cl_domicilio+' '+ls_empresas_domicilio+' '+ls_empresas_nu_domicilio
//ls_direccion_del_ordenante2                  = ls_empresas_codpostal+' '+ls_empresas_ciudad
//ls_direccion_del_ordenante3                  = f_nombre_provincia(ls_empresas_pais,ls_empresas_provincia)
//ls_pais_del_ordenante                        = f_clave_pais(ls_empresas_pais)
//ls_libre                                     = ''
//
////Luego de cargar los campos los tratamos para ajustarlos
//ls_codigo_de_registro                        = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
//ls_codigo_de_operacion                       = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
//ls_version_cuaderno                          = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
//ls_numero_de_dato                            = f_relleno_cadena(ls_numero_de_dato,'0','I',3)
//ls_identificacion_del_ordenante_nif          = f_relleno_cadena(ls_identificacion_del_ordenante_nif,' ','D',9)
//ls_identificacion_del_ordenante_sufijo       = f_relleno_cadena(ls_identificacion_del_ordenante_sufijo,' ','D',3)
//ls_fecha_de_creacion_del_fichero             = f_relleno_cadena(ls_fecha_de_creacion_del_fichero,'0','I',8)
//ls_fecha_de_ejecucion_ordenes                = f_relleno_cadena(ls_fecha_de_ejecucion_ordenes,'0','I',8)
//ls_identificacion_de_la_cuenta_del_ordenante = f_relleno_cadena(ls_identificacion_de_la_cuenta_del_ordenante,' ','D',1)
//ls_cuenta_del_ordenante                      = f_relleno_cadena(ls_cuenta_del_ordenante,' ','D',34)
//ls_detalle_del_cargo                         = f_relleno_cadena(ls_detalle_del_cargo,'0','I',1)
//ls_nombre_del_ordenante                      = f_relleno_cadena(ls_nombre_del_ordenante,' ','D',70)
//ls_direccion_del_ordenante1                  = f_relleno_cadena(ls_direccion_del_ordenante1,' ','D',50)
//ls_direccion_del_ordenante2                  = f_relleno_cadena(ls_direccion_del_ordenante2,' ','D',50)
//ls_direccion_del_ordenante3                  = f_relleno_cadena(ls_direccion_del_ordenante3,' ','D',40)
//ls_pais_del_ordenante                        = f_relleno_cadena(ls_pais_del_ordenante,' ','D',2)
//ls_libre                                     = f_relleno_cadena(ls_libre,' ','D',311)
//
//ls_registro = ls_codigo_de_registro +&
//				  ls_codigo_de_operacion +&
//				  ls_version_cuaderno +&
//				  ls_numero_de_dato +&
//				  ls_identificacion_del_ordenante_nif +&
//				  ls_identificacion_del_ordenante_sufijo +&
//				  ls_fecha_de_creacion_del_fichero +&
//				  ls_fecha_de_ejecucion_ordenes +&
//				  ls_identificacion_de_la_cuenta_del_ordenante +&
//				  ls_cuenta_del_ordenante +&
//				  ls_detalle_del_cargo +&
//				  ls_nombre_del_ordenante +&
//				  ls_direccion_del_ordenante1 +&
//				  ls_direccion_del_ordenante2 +&
//				  ls_direccion_del_ordenante3 +&
//				  ls_pais_del_ordenante +&
//				  ls_libre
//				  
//ll_donde = ds_norma_34.insertrow(0)				  
//ds_norma_34.object.registro[ll_donde] = ls_registro
///////
////Registro de cabecera de transferencias SEPA
//ls_codigo_de_registro                        = '02'
//ls_codigo_de_operacion                       = 'SCT'
//ls_version_cuaderno                          = '34145'
//ls_libre                                     = ''
//
////Luego de cargar los campos los tratamos para ajustarlos
//ls_codigo_de_registro                        = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
//ls_codigo_de_operacion                       = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
//ls_version_cuaderno                          = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
//ls_libre                                     = f_relleno_cadena(ls_libre,' ','D',578)
//
//ls_registro = ls_codigo_de_registro +&
//				  ls_codigo_de_operacion +&
//				  ls_version_cuaderno +&
//				  ls_identificacion_del_ordenante_nif +&
//				  ls_identificacion_del_ordenante_sufijo +&
//				  ls_libre
//				  
//ll_donde = ds_norma_34.insertrow(0)				  
//ds_norma_34.object.registro[ll_donde] = ls_registro
//
////Registros individuales obligatorios
//string ls_referencia_del_ordenante,ls_identificador_de_la_cuenta_del_beneficiario
//string ls_cuenta_del_beneficiario,ls_importe_de_transferencia,ls_clave_de_gastos,ls_bic_entidad_beneficiario
//string ls_nombre_del_beneficiario,ls_direccion_del_beneficiario1,ls_direccion_del_beneficiario2,ls_direccion_del_beneficiario3
//string ls_pais_del_beneficiario,ls_concepto_enviado_por_el_ordenante_al_beneficiario,ls_identificacion_de_la_instruccion
//string ls_tipo_de_transferencia,ls_proposito_de_la_transferencia
//
//string ls_proveedor,ls_comproveedores_codigo_iban,ls_comproveedores_codigo_swift,ls_comproveedores_cif,ls_domiciliacion_proveedor
//dec    ld_importe,ld_total_importe = 0
//
//ll_total = dw_detalle.rowcount()
//for ll_indice = 1 to ll_total
//	ls_proveedor     = dw_detalle.object.proveedor[ll_indice]
//	ld_importe        = dw_detalle.object.importe[ll_indice]
//	ld_total_importe += ld_importe
//	
//	select isnull(comproveedores.codigo_iban,''),
//			 isnull(comproveedores.codigo_swift,''),
//			 isnull(genter.cif,'')
//	into   :ls_comproveedores_codigo_iban,
//			 :ls_comproveedores_codigo_swift,
//			 :ls_comproveedores_cif
//	from   comproveedores,genter
//	where  genter.empresa  = comproveedores.empresa
//	and    genter.codigo   = comproveedores.codigo
//	and    genter.empresa  = :codigo_empresa
//	and    genter.codigo   = :ls_proveedor
//	and    genter.tipoter  = 'P';
//	
//	ls_codigo_de_registro                                = '03'
//	ls_codigo_de_operacion                               = 'SCT'
//	ls_version_cuaderno                                  = '34145'	
//	ls_numero_de_dato                                    = '002'
//	ls_referencia_del_ordenante                          = f_tratar_nif(ls_comproveedores_cif,ls_proveedor,f_pais_genter(codigo_empresa,'P',ls_proveedor))
//	ls_identificador_de_la_cuenta_del_beneficiario       = 'A'
//	ls_cuenta_del_beneficiario                           = ls_comproveedores_codigo_iban
//	ls_importe_de_transferencia                          = string(ld_importe*100,"##########0")
//	ls_clave_de_gastos                                   = '3'
//	ls_bic_entidad_beneficiario                          = ls_comproveedores_codigo_swift
//	ls_nombre_del_beneficiario                           = f_razon_genter(codigo_empresa,'P',ls_proveedor)
//	ls_direccion_del_beneficiario1                       = ''
//	ls_direccion_del_beneficiario2                       = ''
//	ls_direccion_del_beneficiario3                       = ''
//	ls_pais_del_beneficiario                             = ''
//	ls_concepto_enviado_por_el_ordenante_al_beneficiario = 'PAGO FRA '+f_facturas_linea_detalle(ll_indice)
//	ls_identificacion_de_la_instruccion                  = ''
//	ls_tipo_de_transferencia                             = 'SUPP'
//	ls_proposito_de_la_transferencia                     = 'SUPP'
//	ls_libre                                             = ''
//	
//	//Luego de cargar los campos los tratamos para ajustarlos
//	ls_codigo_de_registro                                = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
//	ls_codigo_de_operacion                               = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
//	ls_version_cuaderno                                  = f_relleno_cadena(ls_version_cuaderno,'0','I',5)
//	ls_numero_de_dato                                    = f_relleno_cadena(ls_numero_de_dato,'0','I',3)
//	ls_referencia_del_ordenante                          = f_relleno_cadena(ls_referencia_del_ordenante,' ','D',35)
//	ls_identificador_de_la_cuenta_del_beneficiario       = f_relleno_cadena(ls_identificador_de_la_cuenta_del_beneficiario,' ','D',1)
//	ls_cuenta_del_beneficiario                           = f_relleno_cadena(ls_cuenta_del_beneficiario,' ','D',34)
//	ls_importe_de_transferencia                          = f_relleno_cadena(ls_importe_de_transferencia,'0','I',11)
//	ls_clave_de_gastos                                   = f_relleno_cadena(ls_clave_de_gastos,'0','I',1)
//	ls_bic_entidad_beneficiario                          = f_relleno_cadena(ls_bic_entidad_beneficiario,' ','D',11)
//	ls_nombre_del_beneficiario                           = f_relleno_cadena(ls_nombre_del_beneficiario,' ','D',70)
//	ls_direccion_del_beneficiario1                       = f_relleno_cadena(ls_direccion_del_beneficiario1,' ','D',50)
//	ls_direccion_del_beneficiario2                       = f_relleno_cadena(ls_direccion_del_beneficiario2,' ','D',50)
//	ls_direccion_del_beneficiario3                       = f_relleno_cadena(ls_direccion_del_beneficiario3,' ','D',40)
//	ls_pais_del_beneficiario                             = f_relleno_cadena(ls_pais_del_beneficiario,' ','D',2)
//	ls_concepto_enviado_por_el_ordenante_al_beneficiario = f_relleno_cadena(ls_concepto_enviado_por_el_ordenante_al_beneficiario,' ','D',140)
//	ls_identificacion_de_la_instruccion                  = f_relleno_cadena(ls_identificacion_de_la_instruccion,' ','D',35)
//	ls_tipo_de_transferencia                             = f_relleno_cadena(ls_tipo_de_transferencia,' ','D',4)
//	ls_proposito_de_la_transferencia                     = f_relleno_cadena(ls_proposito_de_la_transferencia,' ','D',4)
//	ls_libre                                             = f_relleno_cadena(ls_libre,' ','D',99)
//	
//	ls_registro = ls_codigo_de_registro +&
//					  ls_codigo_de_operacion +&
//					  ls_version_cuaderno +&
//					  ls_numero_de_dato +&
//					  ls_referencia_del_ordenante +&
//					  ls_identificador_de_la_cuenta_del_beneficiario +&
//					  ls_cuenta_del_beneficiario +&
//					  ls_importe_de_transferencia +&
//					  ls_clave_de_gastos +&
//					  ls_bic_entidad_beneficiario +&
//					  ls_nombre_del_beneficiario +&
//					  ls_direccion_del_beneficiario1 +&
//					  ls_direccion_del_beneficiario2 +&
//					  ls_direccion_del_beneficiario3 +&
//					  ls_pais_del_beneficiario +&
//					  ls_concepto_enviado_por_el_ordenante_al_beneficiario +&
//					  ls_identificacion_de_la_instruccion +&
//					  ls_tipo_de_transferencia +&
//					  ls_proposito_de_la_transferencia +&
//					  ls_libre
//	
//	ll_donde = ds_norma_34.insertrow(0)				  
//	ds_norma_34.object.registro[ll_donde] = ls_registro	
//		
//next
//
////Registro de totales
//string ls_total_importes,ls_numero_de_registros,ls_total_registros
//
//ls_codigo_de_registro  = '04'
//ls_codigo_de_operacion = 'SCT'
//ls_total_importes      = string(ld_total_importe*100,"################0")
//ls_numero_de_registros = string(ll_total,"#######0")
//ls_total_registros     = string(ll_total+2,"#########0")
//ls_libre               = ''
//
//ls_codigo_de_registro  = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
//ls_codigo_de_operacion = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
//ls_total_importes      = f_relleno_cadena(ls_total_importes,'0','I',17)
//ls_numero_de_registros = f_relleno_cadena(ls_numero_de_registros,'0','I',8)
//ls_total_registros     = f_relleno_cadena(ls_total_registros,'0','I',10)
//ls_libre               = f_relleno_cadena(ls_libre,' ','D',560)
//
//ls_registro = ls_codigo_de_registro +&
//				  ls_codigo_de_operacion +&
//				  ls_total_importes +&
//				  ls_numero_de_registros +&
//				  ls_total_registros +&
//				  ls_libre
//
//ll_donde = ds_norma_34.insertrow(0)				  
//ds_norma_34.object.registro[ll_donde] = ls_registro	
///////
////Registro de totales general
//ls_codigo_de_registro  = '99'
//ls_codigo_de_operacion = 'ORD'
//ls_total_importes      = string(ld_total_importe*100,"################0")
//ls_numero_de_registros = string(ll_total,"#######0")
//ls_total_registros     = string(ll_total+4,"#########0")
//ls_libre               = ''
//
//ls_codigo_de_registro  = f_relleno_cadena(ls_codigo_de_registro,'0','I',2)
//ls_codigo_de_operacion = f_relleno_cadena(ls_codigo_de_operacion,' ','D',3)
//ls_total_importes      = f_relleno_cadena(ls_total_importes,'0','I',17)
//ls_numero_de_registros = f_relleno_cadena(ls_numero_de_registros,'0','I',8)
//ls_total_registros     = f_relleno_cadena(ls_total_registros,'0','I',10)
//ls_libre               = f_relleno_cadena(ls_libre,' ','D',560)
//
//ls_registro = ls_codigo_de_registro +&
//				  ls_codigo_de_operacion +&
//				  ls_total_importes +&
//				  ls_numero_de_registros +&
//				  ls_total_registros +&
//				  ls_libre
//
//ll_donde = ds_norma_34.insertrow(0)				  
//ds_norma_34.object.registro[ll_donde] = ls_registro	
///////
//
//string ls_mes,ls_fichero,ls_fullname,ls_filename
//long   ll_res
//
//
//ls_fichero = "NORMA34"
//
//IF GetFileSaveName ("Salvar N34", ls_fullname, ls_filename, "TXT", "Ficheros Texto (*.txt),*.txt") = 1 THEN
//
////	fichero = "A:\" + fichero //em_directorio.text + 
//	
//	if ds_norma_34.rowcount() > 0 then
//	//	res = ds_norma_34.saveas(fichero,text!,false)
//		ll_res = ds_norma_34.saveas(ls_fullname,text!,false)
////		if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
//		if ll_res = -1 then f_mensaje("ERROR","Al grabar al fichero")
//	end if
//	
//END IF
//
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

event open;call super::open;String mascara,moneda_emp
int dec_moneda

dw_transfer.SetTransObject(sqlca)
dw_carta.SetTransObject(sqlca)
dw_cheque.SetTransObject(sqlca)
dw_pagares.SetTransObject(sqlca)
dw_listado_pagos_emitidos.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)

This.title = "EMISION PAGOS"

moneda_emp = f_paramemp_moneda_emp(codigo_empresa)
dec_moneda = f_decimales_moneda(moneda_emp)

f_mascara_columna(dw_carta,"importe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_carta,"total",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_carta,"total2",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_detalle,"total_cancelacion",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_detalle,"importe",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_1,"carpagos_importe_a_pagar",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"carpagos_divisas_a_pagar",f_mascara_decimales(2))

f_mascara_columna(dw_extracto,"importe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_extracto,"total",f_mascara_decimales(dec_moneda))


em_desde.text = "1/1/"+ string(year(today()))
em_hasta.text = string(today())
em_fcarta.text = string(today())
marca_todos = false
end event

on w_emision_documentos_pago.create
int iCurrent
call super::create
this.gb_tipo_pagare=create gb_tipo_pagare
this.gb_1=create gb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.uo_banco=create uo_banco
this.cb_consulta=create cb_consulta
this.dw_transfer=create dw_transfer
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
this.st_4=create st_4
this.uo_proveedor=create uo_proveedor
this.st_provee=create st_provee
this.uo_tipodoc=create uo_tipodoc
this.dw_carta=create dw_carta
this.dw_1=create dw_1
this.dw_cheque=create dw_cheque
this.dw_extracto=create dw_extracto
this.em_fcarta=create em_fcarta
this.st_9=create st_9
this.st_banco=create st_banco
this.dw_pagares=create dw_pagares
this.rb_bcovalencia=create rb_bcovalencia
this.rb_bcosabadell=create rb_bcosabadell
this.rb_cam=create rb_cam
this.st66=create st66
this.pb_imprimir_pagare=create pb_imprimir_pagare
this.pb_imprimir_cartas=create pb_imprimir_cartas
this.st_5=create st_5
this.st_6=create st_6
this.pb_imprimir_documento=create pb_imprimir_documento
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
this.cbx_transf_moneda_fra=create cbx_transf_moneda_fra
this.st_transf_moneda_fra=create st_transf_moneda_fra
this.rb_bsch=create rb_bsch
this.rb_santander=create rb_santander
this.rb_bancaja=create rb_bancaja
this.rb_bco_popular=create rb_bco_popular
this.rb_bbva=create rb_bbva
this.dw_listado_pagos_emitidos=create dw_listado_pagos_emitidos
this.pb_imprimir_pagos_emitidos=create pb_imprimir_pagos_emitidos
this.dw_detalle=create dw_detalle
this.cbx_una_sola_carta_por_proveedor=create cbx_una_sola_carta_por_proveedor
this.st_1=create st_1
this.rb_banesto=create rb_banesto
this.pb_n_68=create pb_n_68
this.st_n68=create st_n68
this.pb_n_34=create pb_n_34
this.st_n34=create st_n34
this.gb_5=create gb_5
this.rb_empresa=create rb_empresa
this.rb_matricial=create rb_matricial
this.rb_ibercaja=create rb_ibercaja
this.rb_cajaruralandorra=create rb_cajaruralandorra
this.pb_sepa=create pb_sepa
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_tipo_pagare
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_banco
this.Control[iCurrent+6]=this.cb_consulta
this.Control[iCurrent+7]=this.dw_transfer
this.Control[iCurrent+8]=this.em_desde
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.uo_proveedor
this.Control[iCurrent+13]=this.st_provee
this.Control[iCurrent+14]=this.uo_tipodoc
this.Control[iCurrent+15]=this.dw_carta
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.dw_cheque
this.Control[iCurrent+18]=this.dw_extracto
this.Control[iCurrent+19]=this.em_fcarta
this.Control[iCurrent+20]=this.st_9
this.Control[iCurrent+21]=this.st_banco
this.Control[iCurrent+22]=this.dw_pagares
this.Control[iCurrent+23]=this.rb_bcovalencia
this.Control[iCurrent+24]=this.rb_bcosabadell
this.Control[iCurrent+25]=this.rb_cam
this.Control[iCurrent+26]=this.st66
this.Control[iCurrent+27]=this.pb_imprimir_pagare
this.Control[iCurrent+28]=this.pb_imprimir_cartas
this.Control[iCurrent+29]=this.st_5
this.Control[iCurrent+30]=this.st_6
this.Control[iCurrent+31]=this.pb_imprimir_documento
this.Control[iCurrent+32]=this.cb_1
this.Control[iCurrent+33]=this.gb_3
this.Control[iCurrent+34]=this.gb_2
this.Control[iCurrent+35]=this.gb_4
this.Control[iCurrent+36]=this.cbx_transf_moneda_fra
this.Control[iCurrent+37]=this.st_transf_moneda_fra
this.Control[iCurrent+38]=this.rb_bsch
this.Control[iCurrent+39]=this.rb_santander
this.Control[iCurrent+40]=this.rb_bancaja
this.Control[iCurrent+41]=this.rb_bco_popular
this.Control[iCurrent+42]=this.rb_bbva
this.Control[iCurrent+43]=this.dw_listado_pagos_emitidos
this.Control[iCurrent+44]=this.pb_imprimir_pagos_emitidos
this.Control[iCurrent+45]=this.dw_detalle
this.Control[iCurrent+46]=this.cbx_una_sola_carta_por_proveedor
this.Control[iCurrent+47]=this.st_1
this.Control[iCurrent+48]=this.rb_banesto
this.Control[iCurrent+49]=this.pb_n_68
this.Control[iCurrent+50]=this.st_n68
this.Control[iCurrent+51]=this.pb_n_34
this.Control[iCurrent+52]=this.st_n34
this.Control[iCurrent+53]=this.gb_5
this.Control[iCurrent+54]=this.rb_empresa
this.Control[iCurrent+55]=this.rb_matricial
this.Control[iCurrent+56]=this.rb_ibercaja
this.Control[iCurrent+57]=this.rb_cajaruralandorra
this.Control[iCurrent+58]=this.pb_sepa
this.Control[iCurrent+59]=this.st_7
end on

on w_emision_documentos_pago.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_tipo_pagare)
destroy(this.gb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.uo_banco)
destroy(this.cb_consulta)
destroy(this.dw_transfer)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_proveedor)
destroy(this.st_provee)
destroy(this.uo_tipodoc)
destroy(this.dw_carta)
destroy(this.dw_1)
destroy(this.dw_cheque)
destroy(this.dw_extracto)
destroy(this.em_fcarta)
destroy(this.st_9)
destroy(this.st_banco)
destroy(this.dw_pagares)
destroy(this.rb_bcovalencia)
destroy(this.rb_bcosabadell)
destroy(this.rb_cam)
destroy(this.st66)
destroy(this.pb_imprimir_pagare)
destroy(this.pb_imprimir_cartas)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.pb_imprimir_documento)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.cbx_transf_moneda_fra)
destroy(this.st_transf_moneda_fra)
destroy(this.rb_bsch)
destroy(this.rb_santander)
destroy(this.rb_bancaja)
destroy(this.rb_bco_popular)
destroy(this.rb_bbva)
destroy(this.dw_listado_pagos_emitidos)
destroy(this.pb_imprimir_pagos_emitidos)
destroy(this.dw_detalle)
destroy(this.cbx_una_sola_carta_por_proveedor)
destroy(this.st_1)
destroy(this.rb_banesto)
destroy(this.pb_n_68)
destroy(this.st_n68)
destroy(this.pb_n_34)
destroy(this.st_n34)
destroy(this.gb_5)
destroy(this.rb_empresa)
destroy(this.rb_matricial)
destroy(this.rb_ibercaja)
destroy(this.rb_cajaruralandorra)
destroy(this.pb_sepa)
destroy(this.st_7)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_emision_documentos_pago
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_emision_documentos_pago
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_emision_documentos_pago
integer x = 9
integer y = 12
integer width = 2642
integer textsize = -12
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
end type

type gb_tipo_pagare from groupbox within w_emision_documentos_pago
boolean visible = false
integer x = 2875
integer y = 1220
integer width = 704
integer height = 720
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipo de Pagare"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_emision_documentos_pago
integer x = 9
integer y = 88
integer width = 2853
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_emision_documentos_pago
integer x = 3483
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type st_2 from statictext within w_emision_documentos_pago
integer x = 1115
integer y = 136
integer width = 233
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
string text = "T. Dmto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_banco from u_em_campo_2 within w_emision_documentos_pago
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2144
integer y = 244
integer width = 928
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
else
	rb_bancaja.checked     = false
	rb_bbva.checked        = false
	rb_bco_popular.checked = false
	rb_bcosabadell.checked = false
	rb_bcovalencia.checked = false
	rb_bsch.checked        = false
	rb_cam.checked         = false
	rb_empresa.checked     = false
	rb_matricial.checked   = false
	rb_santander.checked   = false
		
//	rb_matricial.checked   = true
//	rb_matricial.triggerevent(clicked!)

	rb_empresa.checked   = true
	rb_empresa.triggerevent(clicked!)
	
//	choose case this.em_codigo.text
//		case "15","50","7"
//			rb_bcosabadell.checked = true
//			rb_bcosabadell.triggerevent(clicked!)
//		case "6"
//			rb_bcovalencia.checked = true
//			rb_bcovalencia.triggerevent(clicked!)
//		case ""
//			rb_cam.checked         = true
//			rb_cam.triggerevent(clicked!)
//		case "17"
//			rb_bsch.checked        = true
//			rb_bsch.triggerevent(clicked!)
//		case "13"
//			rb_santander.checked   = true
//			rb_santander.triggerevent(clicked!)
//		case else
//			rb_bancaja.checked     = true	
//			rb_bancaja.triggerevent(clicked!)
//	end choose
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type cb_consulta from u_boton within w_emision_documentos_pago
integer x = 3113
integer y = 236
integer width = 480
integer height = 100
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;if datetime(date(em_desde.text)) > datetime(date(em_hasta.text)) then
	messagebox("No se puede continuar","La fecha desde ha de ser menor que la fecha hasta")
	em_desde.setfocus()
	return
end if

if uo_tipodoc.em_codigo.text = "" then
	messagebox("No se puede continuar","Debe seleccionar el tipo de documento")
	uo_tipodoc.setfocus()
	return
end if


if uo_banco.em_codigo.text = "" then
	messagebox("No se puede continuar","Debe seleccionar el banco")
	uo_banco.setfocus()
	return
end if



f_cargar(dw_1)
dw_detalle.reset()
f_activar_campo(uo_banco.em_campo)

end event

type dw_transfer from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 521
integer y = 24
integer width = 229
integer height = 76
boolean bringtotop = true
string dataobject = "report_emision_transfer"
boolean livescroll = true
end type

type em_desde from u_em_campo within w_emision_documentos_pago
integer x = 466
integer y = 128
integer width = 288
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type em_hasta from u_em_campo within w_emision_documentos_pago
integer x = 814
integer y = 128
integer width = 274
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type st_3 from statictext within w_emision_documentos_pago
integer x = 46
integer y = 136
integer width = 347
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
string text = "Vencimiento :"
boolean focusrectangle = false
end type

type st_4 from statictext within w_emision_documentos_pago
integer x = 759
integer y = 124
integer width = 46
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
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_emision_documentos_pago
event destroy ( )
integer x = 398
integer y = 244
integer width = 1426
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
 Return
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
		ue_datawindow = "dw_ayuda_proveedores"
		ue_filtro     = ""

end event

type st_provee from statictext within w_emision_documentos_pago
integer x = 69
integer y = 256
integer width = 297
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
string text = "Proveedor :"
boolean focusrectangle = false
end type

type uo_tipodoc from u_em_campo_2 within w_emision_documentos_pago
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1353
integer y = 128
integer width = 1481
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tipodoc.em_campo.text=f_nombre_cartipodoc(codigo_empresa,uo_tipodoc.em_codigo.text)
If Trim(uo_tipodoc.em_campo.text)="" then
	uo_tipodoc.em_campo.text=""
	uo_tipodoc.em_codigo.text=""
	Return
end if 
//transferencias
if uo_tipodoc.em_codigo.text = "6" then
	cbx_transf_moneda_fra.visible = true
	st_transf_moneda_fra.visible  = true
else
	cbx_transf_moneda_fra.visible = false
	st_transf_moneda_fra.visible  = false
end if

choose case uo_tipodoc.em_codigo.text
	case "10"
		pb_n_68.enabled = true
		st_n68.enabled  = true
		pb_n_34.enabled = false
		st_n34.enabled  = false				
	case "6","7","5"
		pb_n_68.enabled = false
		st_n68.enabled  = false
		pb_n_34.enabled = true
		st_n34.enabled  = true				
	case else
		pb_n_68.enabled = false
		st_n68.enabled  = false
		pb_n_34.enabled = false
		st_n34.enabled  = false		
end choose
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de tipos de documento"
ue_datawindow ="dw_ayuda_cartipodoc"

end event

on uo_tipodoc.destroy
call u_em_campo_2::destroy
end on

type dw_carta from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 1015
integer y = 24
integer width = 229
integer height = 76
boolean bringtotop = true
string dataobject = "report_carta_emision_pagos2"
boolean livescroll = true
end type

type dw_1 from u_datawindow_consultas within w_emision_documentos_pago
integer x = 5
integer y = 348
integer width = 3589
integer height = 776
integer taborder = 0
string dataobject = "dw_emision_documentos_pago"
boolean vscrollbar = true
end type

event key;IF  key  <> KeyEnter! Then
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

END IF



end event

event rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event clicked;call super::clicked;int i
if dwo.name = "marcados" then
	this.setcolumn("marca")
	if not marca_todos then			
		marca_todos = true
		dw_detalle.reset()
		for i = 1 to dw_1.rowcount()				
			dw_1.setitem(i,"marca","S")				
			f_pro(i)			
		next
	else
		dw_detalle.reset()
		marca_todos = false
		for i = 1 to dw_1.rowcount()				
			dw_1.setitem(i,"marca","N")							
			f_pro2(i)
		next
		
	end if

end if
end event

event itemchanged;dec    cambio,importe,divisas,nuevo_importe,nuevas_divisas
string moneda,moneda_empresa

cambio  = this.object.carpagos_cambio[row]
moneda  = this.object.moneda[row]
importe = this.object.importe[row]
divisas = this.object.divisas[row]

moneda_empresa = f_moneda_empresa(codigo_empresa)

choose case dwo.name
	case "carpagos_importe_a_pagar"
		nuevo_importe  = dec(data)
		if nuevo_importe <= importe then
			nuevas_divisas = dec(string(nuevo_importe * cambio,f_mascara_moneda(moneda)))
			this.object.carpagos_divisas_a_pagar[row] = nuevas_divisas
		else
			messagebox("Atención","Importe no valido")
			return 2
		end if
	case "carpagos_divisas_a_pagar"
		nuevas_divisas = dec(data)
		if nuevas_divisas <= divisas then
			nuevo_importe = dec(string(nuevas_divisas / cambio,f_mascara_moneda(moneda_empresa)))
			this.object.carpagos_importe_a_pagar[row] = nuevo_importe
		else
			messagebox("Atención","Importe no valido")
			return 2
		end if	
	case "marca"
		if data = "N" Then
			f_pro2(row)
		else		
			f_pro(row)		
		end if	
end choose
end event

event retrieveend;string proveedor
long   indice

if rowcount > 0 then
	for indice = 1 to rowcount
		proveedor = this.object.proveedor[indice]
		
		if proveedor = "4000099999" then
			//Varios no se agrupa
			this.object.carpagos_agrupar[indice] = "N"
		else
			this.object.carpagos_agrupar[indice] = "S"
		end if
	next
end if
end event

type dw_cheque from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 23
integer y = 24
integer width = 229
integer height = 76
boolean bringtotop = true
string dataobject = "report_emision_cheque"
boolean livescroll = true
end type

type dw_extracto from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 274
integer y = 20
integer width = 229
integer height = 76
boolean bringtotop = true
string dataobject = "report_resumen_pagos"
boolean livescroll = true
end type

type em_fcarta from u_em_campo within w_emision_documentos_pago
integer x = 3232
integer y = 128
integer width = 274
integer taborder = 50
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type st_9 from statictext within w_emision_documentos_pago
integer x = 2903
integer y = 140
integer width = 302
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
string text = "F. Docum."
alignment alignment = right!
boolean focusrectangle = false
end type

type st_banco from statictext within w_emision_documentos_pago
integer x = 1902
integer y = 256
integer width = 233
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
string text = "Banco :"
boolean focusrectangle = false
end type

type dw_pagares from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 768
integer y = 24
integer width = 229
integer height = 76
boolean bringtotop = true
string dataobject = "report_emision_pagares_empresa"
boolean livescroll = true
end type

type rb_bcovalencia from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1280
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bco Valencia"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_bcovalencia"

dw_pagares.SetTransObject(sqlca)
end event

type rb_bcosabadell from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1332
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bco Sabadell"
end type

event clicked;
//dw_pagares.dataobject = "report_emision_pagare_bcosabadell"
dw_pagares.dataobject = "report_emision_pagares_bcosabadell"

dw_pagares.SetTransObject(sqlca)
end event

type rb_cam from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1384
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CAM"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_cam"

dw_pagares.SetTransObject(sqlca)
end event

type st66 from statictext within w_emision_documentos_pago
integer x = 2875
integer y = 1144
integer width = 233
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Pagare"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;boolean visibles

visibles = gb_tipo_pagare.visible

visibles = not(visibles)

gb_tipo_pagare.visible = visibles
rb_bcosabadell.visible = visibles
rb_bcovalencia.visible = visibles
rb_cam.visible         = visibles
rb_bsch.visible        = visibles
//rb_santander.visible   = visibles
rb_bancaja.visible     = visibles
rb_bco_popular.visible = visibles
rb_bbva.visible        = visibles
rb_empresa.visible     = visibles
rb_ibercaja.visible    = visibles
rb_matricial.visible   = visibles
rb_banesto.visible     = visibles
rb_cajaruralandorra.visible     = visibles
end event

type pb_imprimir_pagare from picturebutton within w_emision_documentos_pago
integer x = 2875
integer y = 1220
integer width = 233
integer height = 192
integer taborder = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\imp32.bmp"
end type

event clicked;Integer  ln, i,anyo,posicion_busqueda,posicion_espacio
Boolean  sin_talon = FALSE,cancelar_impresion_matricial = false
String   documento,proveedor,banco,tipodoc,prove,marca,mon,fra
string   moneda,moneda_fra,moneda_empresa,texto_importe_escrito,texto_importe_escrito1,texto_importe_escrito2
DateTime fec,fvto,fecha_pago,ffra,fecha_emision
long     reg1,reg2,j,linea,orden,Job,aux,ll_recibo
dec      importe,importe_pagare
dec      pos_x_dia_vto,pos_y_dia_vto,pos_x_mes_vto,pos_y_mes_vto,pos_x_anyo_vto,pos_y_anyo_vto
dec		pos_x_importe_numero,pos_y_importe_numero,pos_x_razon_proveedor,pos_y_razon_proveedor
dec		pos_x_importe_letras1,pos_y_importe_letras1,pos_x_importe_letras2,pos_y_importe_letras2
dec		pos_x_dia_emision,pos_y_dia_emision,pos_x_mes_emision,pos_y_mes_emision
dec		pos_x_anyo_emision,pos_y_anyo_emision,margen_superior,margen_izquierdo,incremento_y
long     pos_x,pos_y,numero_impresion
string   texto_imprimir

tipodoc        = Trim(uo_tipodoc.em_codigo.text)
banco          = Trim(uo_banco.em_codigo.text)
moneda_empresa = f_moneda_empresa(codigo_empresa)

dw_detalle.accepttext()
//SELECT MAX(Convert(Int,carpagos.num_talon)) 
//INTO   :num_talon_dec 
//FROM   carpagos
//WHERE  carpagos.empresa      = :codigo_empresa
//AND    carpagos.tipodoc_pago = :tipodoc
//AND    carpagos.banco        = :banco;
//and    convert(int,num_talon) > 1000;

//num_talon_dec = num_talon_dec + 1
//num_talon     = Dec(inputbox("Nº Pagaré Impresion ","Introduzca El Nº de Pagaré Inicial:",String(num_talon_dec),""))	
//IF num_talon = 0 OR IsNull(num_talon) THEN
//	MessageBox("ERROR","Ha introducido un Nº no válido",Exclamation!)
//	RETURN
//END IF

if f_comprueba_numdocumento() then
	if rb_matricial.checked then
		select pos_x_dia_vto * equiv_mm_pos_impresora , 				pos_y_dia_vto * equiv_mm_pos_impresora , 
				 pos_x_mes_vto * equiv_mm_pos_impresora , 				pos_y_mes_vto * equiv_mm_pos_impresora , 
				 pos_x_anyo_vto * equiv_mm_pos_impresora , 				pos_y_anyo_vto * equiv_mm_pos_impresora , 
				 pos_x_importe_numero * equiv_mm_pos_impresora , 		pos_y_importe_numero * equiv_mm_pos_impresora ,
				 pos_x_razon_proveedor * equiv_mm_pos_impresora , 		pos_y_razon_proveedor * equiv_mm_pos_impresora , 
				 pos_x_importe_letras1 * equiv_mm_pos_impresora , 		pos_y_importe_letras1 * equiv_mm_pos_impresora , 
				 pos_x_importe_letras2 * equiv_mm_pos_impresora , 		pos_y_importe_letras2 * equiv_mm_pos_impresora , 
				 pos_x_dia_emision * equiv_mm_pos_impresora , 			pos_y_dia_emision * equiv_mm_pos_impresora , 
				 pos_x_mes_emision * equiv_mm_pos_impresora , 			pos_y_mes_emision * equiv_mm_pos_impresora , 
				 pos_x_anyo_emision * equiv_mm_pos_impresora , 			pos_y_anyo_emision * equiv_mm_pos_impresora , 
				 margen_superior * equiv_mm_pos_impresora , 				margen_izquierdo * equiv_mm_pos_impresora
		into   :pos_x_dia_vto, 													:pos_y_dia_vto, 
				 :pos_x_mes_vto, 													:pos_y_mes_vto, 
				 :pos_x_anyo_vto, 												:pos_y_anyo_vto, 
				 :pos_x_importe_numero, 										:pos_y_importe_numero, 
				 :pos_x_razon_proveedor, 										:pos_y_razon_proveedor, 
				 :pos_x_importe_letras1, 										:pos_y_importe_letras1, 
				 :pos_x_importe_letras2, 										:pos_y_importe_letras2, 
				 :pos_x_dia_emision, 											:pos_y_dia_emision, 
				 :pos_x_mes_emision, 											:pos_y_mes_emision, 
				 :pos_x_anyo_emision, 											:pos_y_anyo_emision, 
				 :margen_superior, 												:margen_izquierdo
		from   carpagos_plantilla_pagare		
		where  empresa = :codigo_empresa
		and    banco   = :banco; 
		
		if printsetup() = 1 then
			Job = PrintOpen()		
			
//			IF	PrintDefineFont(Job,8,"Arial (True Type)",-10, 400,Fixed!,Decorative!,FALSE,FALSE) = 1 then
//Funcionando	if PrintDefineFont(Job, 1, "Courier 10Cpi",-10, 700, Default!, Roman!,false,false) = 1 then
//Prueba1 PrintDefineFont(Job, 1, "16 cpi", -10, 400, Default!, AnyFont!, FALSE, FALSE)
//Prueba2 PrintDefineFont(Job, 1,"Helv",250,700, Variable!,Swiss!,FALSE,TRUE)

			if PrintDefineFont(Job, 1, "16 cpi", -10, 400, Default!, AnyFont!, FALSE, FALSE) = 1 then	
				PrintSetFont (Job,1)
			else
				cancelar_impresion_matricial = true
				PrintClose(Job)				
				messagebox("Atención!","Error al configurar la impresora")
			end if
		else
			cancelar_impresion_matricial = true
		end if
	end if
	
	reg1 = dw_detalle.rowcount()
	reg2 = dw_1.rowcount()
	dw_pagares.reset()
	if not(cancelar_impresion_matricial) then
		//numero_impresion = 0
		for i = 1 to reg1
			if dw_detalle.object.imprimir[i] = "S" then
//				numero_impresion ++
//				if numero_impresion = 5 then
//					numero_impresion = 1
//				end if
				
				proveedor      = dw_detalle.object.proveedor[i]
				fecha_pago     = dw_detalle.object.fvto[i]
				moneda         = dw_detalle.object.moneda[i]
				documento      = dw_detalle.object.documento[i]
//				anyo           = dw_detalle.object.anyo[i]
//				orden          = dw_detalle.object.orden[i]

				fecha_emision  = dw_detalle.object.fcarta[i]
				importe_pagare = dw_detalle.object.importe[i]				
				
				if rb_empresa.checked or rb_ibercaja.checked or rb_bbva.checked or rb_bsch.checked or rb_bcosabadell.checked then
					dw_pagares.Retrieve(codigo_empresa,uo_banco.em_codigo.text,uo_tipodoc.em_codigo.text,proveedor,documento,fecha_pago)
					
					for j = 1 to reg2 
						marca = dw_1.getitemstring(j,"marca")
						if marca = "S" then
							prove      = dw_1.object.proveedor[j]
							fvto	     = dw_1.object.fvto[j]
							moneda_fra = dw_1.object.moneda[j]
							
							if prove = proveedor and fecha_pago = fvto and moneda = moneda_fra then
								dw_1.object.num_talon[j] = documento
								
								linea     = dw_pagares.insertrow(0)
								importe 	 = dw_1.object.carpagos_importe_a_pagar[j]
								fra 		 = dw_1.object.fra[j]
								ffra 		 = dw_1.object.ffra[j]
								ll_recibo = dw_1.object.recibo[j]
								
								dw_pagares.object.fra[linea]           = fra
								dw_pagares.object.importe[linea]       = importe
								dw_pagares.object.ffra[linea]          = ffra
								dw_pagares.object.moneda[linea]        = moneda_fra
								dw_pagares.object.anyo[linea]          = anyo
								dw_pagares.object.orden[linea]         = orden						
								dw_pagares.object.fecha_emision[linea] = fecha_emision
								dw_pagares.object.recibo[linea]        = ll_recibo
							end if
						end if
					next
					f_imprimir_datawindow(dw_pagares)
				else	
					if rb_matricial.checked then
						
						//incremento_y = 3020 * (numero_impresion - 1)						
						//incremento_y = 3000 * (numero_impresion - 1)												

						pos_x = pos_x_dia_vto 
						pos_y = pos_y_dia_vto //+ incremento_y
						texto_imprimir = string(day(date(fecha_pago)),"##")
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_mes_vto
						pos_y = pos_y_mes_vto //+ incremento_y
						texto_imprimir = upper(f_nombre_mes(month(date(fecha_pago))))
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_anyo_vto
						pos_y = pos_y_anyo_vto //+ incremento_y
						texto_imprimir = string(year(date(fecha_pago)),"####")
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_importe_numero
						pos_y = pos_y_importe_numero //+ incremento_y
						texto_imprimir = "#"+Trim(String(importe_pagare,f_mascara_moneda(moneda_empresa)))+"#"
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_razon_proveedor
						pos_y = pos_y_razon_proveedor //+ incremento_y
						texto_imprimir = f_tratar_texto_matricial(f_razon_genter(codigo_empresa,"P",proveedor))
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						texto_importe_escrito = " #"+f_tratar_texto_matricial(trim(f_nombre_numero_con_decimales(importe_pagare,1,moneda_empresa)))+"#"
						aux = len(texto_importe_escrito)
						if len(texto_importe_escrito) <= 60 then
							texto_importe_escrito1 = texto_importe_escrito
							texto_importe_escrito2 = ""
						else
							posicion_busqueda = 60
							do
								posicion_busqueda --
								posicion_espacio = pos(texto_importe_escrito," ",posicion_busqueda)				
							loop until posicion_espacio > 0 and posicion_espacio <= 60							
							texto_importe_escrito1 = mid(texto_importe_escrito,1,posicion_espacio)
							texto_importe_escrito2 = mid(texto_importe_escrito,posicion_espacio+1,60)

						end if												
						
						pos_x = pos_x_importe_letras1
						pos_y = pos_y_importe_letras1 //+ incremento_y
						texto_imprimir = texto_importe_escrito1
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						pos_x = pos_x_importe_letras2
						pos_y = pos_y_importe_letras2 //+ incremento_y
						texto_imprimir = texto_importe_escrito2
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_dia_emision
						pos_y = pos_y_dia_emision //+ incremento_y
						texto_imprimir = string(day(date(fecha_emision)),"##")
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_mes_emision
						pos_y = pos_y_mes_emision //+ incremento_y
						texto_imprimir = upper(f_nombre_mes(month(date(fecha_emision))))
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//
						pos_x = pos_x_anyo_emision
						pos_y = pos_y_anyo_emision	//+ incremento_y
						texto_imprimir = string(year(date(fecha_emision)),"####")
						PrintText(Job,texto_imprimir,pos_x,pos_y)
						
						//if numero_impresion = 4 then
							printpage(job)
						//end if
					else
						linea = dw_pagares.insertrow(0)
						dw_pagares.object.empresa[linea]       = codigo_empresa
						dw_pagares.object.fpago[linea]         = fecha_pago
						dw_pagares.object.total[linea]         = importe_pagare
						dw_pagares.object.proveedor[linea]     = proveedor
						dw_pagares.object.moneda[linea]        = moneda_empresa
						dw_pagares.object.anyo[linea]          = anyo
						dw_pagares.object.orden[linea]         = orden
						dw_pagares.object.fecha_emision[linea] = fecha_emision
					end if
				end if
				//num_talon = num_talon + 1
				//dw_pagares.print()
			end if
		next	
		
//		if numero_impresion < 4 then
//			printpage(job)
//		end if
		
		if rb_matricial.checked then			
			PrintClose(Job)			
		else
			if not(rb_empresa.checked) and not(rb_ibercaja.checked) and not(rb_bbva.checked) and not (rb_bsch.checked) and not (rb_bcosabadell.checked) then
				f_imprimir_datawindow(dw_pagares)
			end if		
		end if	
	end if
end if
end event

type pb_imprimir_cartas from picturebutton within w_emision_documentos_pago
integer x = 3113
integer y = 1220
integer width = 233
integer height = 192
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\imp32.bmp"
end type

event clicked;long     i,j,fila,linea
string   marca,emp,prov,moneda_empresa,factura,proveedor,prove,num,nombre_documento
string   banco_proveedor,cuenta_bco_proveedor,documento,moneda,moneda_fra,agrupar
boolean  alguno
dec      anyo,orden,importe
datetime fdoc,fecha_pago,fvto,fcarta,la_ffra,la_fvto

if dw_detalle.rowcount() <= 0 then
	messagebox("No se puede continuar","No se han seleccionado efectos")
	return
end if

if uo_banco.em_codigo.text = "" then
	messagebox("No se puede continuar","Debe especificar el banco de pago")
	return
end if

nombre_documento = uo_tipodoc.em_campo.text

dw_detalle.accepttext()
for i = 1 to dw_detalle.rowcount()
	fdoc = dw_detalle.getitemdatetime(i,"fcarta")
	prov = dw_detalle.getitemstring(i,"proveedor")
	if not isdate(string(date(fdoc))) or isnull(fdoc) then
		messagebox("No se puede continuar","Fecha de documento no válida para el proveedor "+ f_nombre_proveedor(codigo_empresa,prov) )
		return		
		
	end if
	
next

alguno = false

moneda_empresa = f_paramemp_moneda_emp(codigo_empresa)

if f_comprueba_numdocumento() then

	if uo_tipodoc.em_codigo.text <> "6" then
		if cbx_una_sola_carta_por_proveedor.checked then
			dw_carta.dataobject = 'report_carta_emision_pagos_varios_doc'
			dw_carta.settransobject(sqlca)
			
			fcarta     = datetime(date(em_fcarta.text))
			
			dw_carta.reset()
			dw_carta.retrieve(codigo_empresa,fcarta,uo_banco.em_codigo.text,uo_tipodoc.em_codigo.text)			
			for i = 1 to dw_detalle.rowcount()
				if dw_detalle.object.imprimir[i] = "S" then				
					prove      = dw_detalle.getitemstring(i,"proveedor")
					fecha_pago = dw_detalle.getitemdatetime(i,"fvto")				
					documento  = dw_detalle.object.documento[i]
					moneda     = dw_detalle.getitemstring(i,"moneda")
					anyo       = dw_detalle.object.anyo[i]
					orden      = dw_detalle.object.orden[i]
					
					if anyo = 0 and orden = 0 then
						for j = 1 to dw_1.rowcount()
											
							proveedor  = dw_1.getitemstring(j,"proveedor")
							fvto	     = dw_1.getitemdatetime(j,"fvto")
							marca      = dw_1.getitemstring(j,"marca")
							moneda_fra = dw_1.getitemstring(j,"moneda")
							agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
							//fecha_pago
							if proveedor = prove  and marca = "S" and fecha_pago = fvto and moneda = moneda_fra and agrupar = "S" then
								
								dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
								dw_1.setitem(j,"num_talon",documento)						
								//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
								dw_1.setitem(j,"femi",fcarta)
								
								linea = dw_carta.insertrow(0)
								dw_carta.setitem( linea,"empresa", codigo_empresa)
								dw_carta.setitem( linea,"factura", dw_1.getitemstring(j,"fra"))
								dw_carta.setitem( linea,"recibo", dw_1.getitemnumber(j,"recibo"))	
								dw_carta.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
								dw_carta.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))			
								dw_carta.setitem( linea,"fvto", dw_1.getitemdatetime(j,"fvto"))			
								dw_carta.setitem( linea,"anyo", dw_1.getitemnumber(j,"anyo"))			
								dw_carta.setitem( linea,"divisas", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
								dw_carta.setitem( linea,"moneda", moneda_fra)			
								dw_carta.setitem( linea,"moneda_empresa", moneda_empresa)					
								dw_carta.setitem( linea,"anyo", anyo)
								dw_carta.setitem( linea,"orden", orden)
								dw_carta.setitem( linea,"fecha_emision",fcarta)
								dw_carta.setitem( linea,"documento",documento)
								dw_carta.setitem( linea,"proveedor",proveedor)
								dw_carta.setitem( linea,"nombre_proveedor",f_razon_genter(codigo_empresa,'P',proveedor))
							end if
						next
					else
						j = dw_1.find("anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######"),1,dw_1.rowcount())
						
						if j > 0 then
							proveedor  = dw_1.getitemstring(j,"proveedor")
							fvto	     = dw_1.getitemdatetime(j,"fvto")
							marca      = dw_1.getitemstring(j,"marca")
							moneda_fra = dw_1.getitemstring(j,"moneda")
								
							dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
							dw_1.setitem(j,"num_talon",documento)						
							//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
							dw_1.setitem(j,"femi",fcarta)
							
							linea = dw_carta.insertrow(0)
							dw_carta.setitem( linea,"empresa", codigo_empresa)
							dw_carta.setitem( linea,"factura", dw_1.getitemstring(j,"fra"))
							dw_carta.setitem( linea,"recibo", dw_1.getitemnumber(j,"recibo"))	
							dw_carta.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
							dw_carta.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))			
							dw_carta.setitem( linea,"fvto", dw_1.getitemdatetime(j,"fvto"))			
							dw_carta.setitem( linea,"anyo", dw_1.getitemnumber(j,"anyo"))			
							dw_carta.setitem( linea,"divisas", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
							dw_carta.setitem( linea,"moneda", moneda_fra)			
							dw_carta.setitem( linea,"moneda_empresa", moneda_empresa)
							dw_carta.setitem( linea,"anyo", anyo)
							dw_carta.setitem( linea,"orden", orden)					
							dw_carta.setitem( linea,"fecha_emision",fcarta)
							dw_carta.setitem( linea,"documento",documento)
							dw_carta.setitem( linea,"proveedor",proveedor)
							dw_carta.setitem( linea,"nombre_proveedor",f_razon_genter(codigo_empresa,'P',proveedor))						
						end if
					end if
				end if
			next
			dw_carta.sort()
			dw_carta.groupcalc()

			f_imprimir_datawindow(dw_carta)	

		else
			dw_carta.dataobject = 'report_carta_emision_pagos2'
			dw_carta.settransobject(sqlca)
			
			for i = 1 to dw_detalle.rowcount()
				if dw_detalle.object.imprimir[i] = "S" then				
					prove      = dw_detalle.getitemstring(i,"proveedor")
					fecha_pago = dw_detalle.getitemdatetime(i,"fvto")
					fcarta     = dw_detalle.getitemdatetime(i,"fcarta")
					documento  = dw_detalle.object.documento[i]
					moneda     = dw_detalle.getitemstring(i,"moneda")
					anyo       = dw_detalle.object.anyo[i]
					orden      = dw_detalle.object.orden[i]
					
					dw_carta.reset()
					dw_carta.retrieve(codigo_empresa,fcarta,prove,documento,uo_banco.em_codigo.text,uo_tipodoc.em_codigo.text,moneda)
					if anyo = 0 and orden = 0 then
						for j = 1 to dw_1.rowcount()
											
							proveedor  = dw_1.getitemstring(j,"proveedor")
							fvto	     = dw_1.getitemdatetime(j,"fvto")
							marca      = dw_1.getitemstring(j,"marca")
							moneda_fra = dw_1.getitemstring(j,"moneda")
							agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
							//fecha_pago
							if proveedor = prove  and marca = "S" and fecha_pago = fvto and moneda = moneda_fra and agrupar = "S" then
								
								dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
								dw_1.setitem(j,"num_talon",documento)						
								//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
								dw_1.setitem(j,"femi",fcarta)
								
								linea = dw_carta.insertrow(0)
								dw_carta.setitem( linea,"empresa", codigo_empresa)
								dw_carta.setitem( linea,"factura", dw_1.getitemstring(j,"fra"))
								dw_carta.setitem( linea,"recibo", dw_1.getitemnumber(j,"recibo"))	
								dw_carta.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
								dw_carta.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))			
								dw_carta.setitem( linea,"fvto", dw_1.getitemdatetime(j,"fvto"))			
								dw_carta.setitem( linea,"anyo", dw_1.getitemnumber(j,"anyo"))			
								dw_carta.setitem( linea,"divisas", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
								dw_carta.setitem( linea,"moneda", moneda_fra)			
								dw_carta.setitem( linea,"moneda_empresa", moneda_empresa)					
								dw_carta.setitem( linea,"anyo", anyo)
								dw_carta.setitem( linea,"orden", orden)
								dw_carta.setitem( linea,"fecha_emision",fcarta)
							end if
						next
					else
						j = dw_1.find("anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######"),1,dw_1.rowcount())
						
						if j > 0 then
							proveedor  = dw_1.getitemstring(j,"proveedor")
							fvto	     = dw_1.getitemdatetime(j,"fvto")
							marca      = dw_1.getitemstring(j,"marca")
							moneda_fra = dw_1.getitemstring(j,"moneda")
								
							dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
							dw_1.setitem(j,"num_talon",documento)						
							//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
							dw_1.setitem(j,"femi",fcarta)
							
							linea = dw_carta.insertrow(0)
							dw_carta.setitem( linea,"empresa", codigo_empresa)
							dw_carta.setitem( linea,"factura", dw_1.getitemstring(j,"fra"))
							dw_carta.setitem( linea,"recibo", dw_1.getitemnumber(j,"recibo"))	
							dw_carta.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
							dw_carta.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))			
							dw_carta.setitem( linea,"fvto", dw_1.getitemdatetime(j,"fvto"))			
							dw_carta.setitem( linea,"anyo", dw_1.getitemnumber(j,"anyo"))			
							dw_carta.setitem( linea,"divisas", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
							dw_carta.setitem( linea,"moneda", moneda_fra)			
							dw_carta.setitem( linea,"moneda_empresa", moneda_empresa)
							dw_carta.setitem( linea,"anyo", anyo)
							dw_carta.setitem( linea,"orden", orden)					
							dw_carta.setitem( linea,"fecha_emision",fcarta)
						end if
					end if
					dw_carta.sort()
					dw_carta.groupcalc()
					if i = 1 then
						f_imprimir_datawindow(dw_carta)	
					else
						dw_carta.print(false)
					end if
				end if
			next
		end if						
		
	else
		//Transferencias
		for i = 1 to dw_detalle.rowcount()
			prove                = dw_detalle.getitemstring(i,"proveedor")		
			banco_proveedor      = f_nombre_banco_comproveedor(codigo_empresa,prove)
			cuenta_bco_proveedor = f_cuenta_banco_comproveedor(codigo_empresa,prove)
			fecha_pago           = dw_detalle.getitemdatetime(i,"fvto")
			fcarta               = dw_detalle.getitemdatetime(i,"fcarta")			
			importe              = dw_detalle.getitemnumber(i,"importe")
			moneda               = dw_detalle.getitemstring(i,"moneda")		
			anyo                 = dw_detalle.object.anyo[i]
			orden                = dw_detalle.object.orden[i]
			
			dw_transfer.reset()
			dw_transfer.retrieve(codigo_empresa)
			if anyo = 0 and orden = 0 then
				for j = 1 to dw_1.rowcount()
									
					proveedor  = dw_1.getitemstring(j,"proveedor")
					fvto	     = dw_1.getitemdatetime(j,"fvto")
					marca      = dw_1.getitemstring(j,"marca")
					moneda_fra = dw_1.getitemstring(j,"moneda")
					agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
					//fecha_pago
					if proveedor = prove  and marca = "S" and fecha_pago = fvto and moneda = moneda_fra and agrupar = "S" then
						
						dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
						dw_1.setitem(j,"num_talon","")						
						//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
						dw_1.setitem(j,"femi",fcarta)
						
						linea = dw_transfer.insertrow(0)
						dw_transfer.setitem( linea,"empresa", codigo_empresa)
						dw_transfer.setitem( linea,"proveedor", proveedor)				
						dw_transfer.setitem( linea,"banco", uo_banco.em_codigo.text)
						dw_transfer.setitem( linea,"fra", dw_1.getitemstring(j,"fra"))				
						dw_transfer.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))	
						if cbx_transf_moneda_fra.checked then
							dw_transfer.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
							dw_transfer.setitem( linea,"moneda", moneda_fra)							
						else
							dw_transfer.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
							dw_transfer.setitem( linea,"moneda", moneda_empresa)	
						end if
						dw_transfer.setitem( linea,"banco_proveedor",banco_proveedor)	
						dw_transfer.setitem( linea,"cuenta_bco_proveedor",cuenta_bco_proveedor)	
					end if
				next
			else
				j = dw_1.find("anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######"),1,dw_1.rowcount())
				
				if j > 0 then
					proveedor  = dw_1.getitemstring(j,"proveedor")
					fvto	     = dw_1.getitemdatetime(j,"fvto")
					marca      = dw_1.getitemstring(j,"marca")
					moneda_fra = dw_1.getitemstring(j,"moneda")
						
					dw_1.setitem(j,"banco",uo_banco.em_codigo.text)
					dw_1.setitem(j,"num_talon","")						
					//dw_1.setitem(j,"referencia","T/ " + string(date(fcarta),"DD-MM-YY"))
					dw_1.setitem(j,"femi",fcarta)
					
					linea = dw_transfer.insertrow(0)
					dw_transfer.setitem( linea,"empresa", codigo_empresa)
					dw_transfer.setitem( linea,"proveedor", proveedor)				
					dw_transfer.setitem( linea,"banco", uo_banco.em_codigo.text)
					dw_transfer.setitem( linea,"fra", dw_1.getitemstring(j,"fra"))				
					dw_transfer.setitem( linea,"ffra", dw_1.getitemdatetime(j,"ffra"))	
					if cbx_transf_moneda_fra.checked then
						dw_transfer.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_divisas_a_pagar"))			
						dw_transfer.setitem( linea,"moneda", moneda_fra)							
					else
						dw_transfer.setitem( linea,"importe", dw_1.getitemnumber(j,"carpagos_importe_a_pagar"))			
						dw_transfer.setitem( linea,"moneda", moneda_empresa)	
					end if
					dw_transfer.setitem( linea,"banco_proveedor",banco_proveedor)	
					dw_transfer.setitem( linea,"cuenta_bco_proveedor",cuenta_bco_proveedor)	
				end if				
			end if
			dw_transfer.sort()
			dw_transfer.groupcalc()
			if i = 1 then
				f_imprimir_datawindow(dw_transfer)	
			else
				dw_transfer.print(false)
			end if			
		next
		
	end if
end if
end event

type st_5 from statictext within w_emision_documentos_pago
integer x = 3109
integer y = 1144
integer width = 233
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Carta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_emision_documentos_pago
integer x = 3342
integer y = 1144
integer width = 233
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cheque"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_imprimir_documento from picturebutton within w_emision_documentos_pago
integer x = 3342
integer y = 1220
integer width = 233
integer height = 192
integer taborder = 130
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\imp32.bmp"
end type

event clicked;long     i,dec_moneda,linea,j
string   proveedor,documento,moneda_empresa
dec      importe
datetime fdocumento,fvto

dec      pos_x_importe_numero,pos_y_importe_numero,pos_x_razon_proveedor,pos_y_razon_proveedor
dec		pos_x_importe_letras1,pos_y_importe_letras1,pos_x_importe_letras2,pos_y_importe_letras2
dec		pos_x_dia_emision,pos_y_dia_emision,pos_x_mes_emision,pos_y_mes_emision
dec		pos_x_anyo_emision,pos_y_anyo_emision,margen_superior,margen_izquierdo
string   banco,texto_imprimir,texto_importe_escrito,texto_importe_escrito1,texto_importe_escrito2,imprimir_de_fecha_emision
long     job,pos_x,pos_y,aux,posicion_busqueda,posicion_espacio
boolean  cancelar_impresion_matricial = false,lb_impresion_matricial = false

dw_detalle.accepttext()
//	case "5" 
//		dw_cheque.dataobject = "report_emision_pagos_pagare"		

choose case uo_tipodoc.em_codigo.text 
	case "7"
		//Cheques
//		if uo_banco.em_codigo.text = "10" then
//			//Sabadell
//			dw_cheque.dataobject = "report_emision_cheque_sabadell_matric"
//		else
//			dw_cheque.dataobject = "report_emision_cheque_matric"
//		end if				
		dw_cheque.dataobject = "report_emision_cheque"		
	case else
		messagebox("No se puede continuar","Sólo se pueden emitir cheques")
		return
end choose

dw_cheque.settransobject(sqlca)

if dw_detalle.rowcount() <= 0 then
	messagebox("No se puede continuar","No se han seleccionado efectos")
	return
end if

if uo_banco.em_codigo.text = "" then
	messagebox("No se puede continuar","Debe especificar el banco de pago")
	return
end if

banco          = uo_banco.em_codigo.text
moneda_empresa = f_moneda_empresa(codigo_empresa)
dec_moneda     = f_decimales_moneda(moneda_empresa)

dw_cheque.retrieve(codigo_empresa,uo_banco.em_codigo.text,dec_moneda)

dw_detalle.accepttext()

if f_comprueba_numdocumento() then
	if lb_impresion_matricial then
		select pos_x_importe_numero * equiv_mm_pos_impresora , 		pos_y_importe_numero * equiv_mm_pos_impresora ,
				 pos_x_razon_proveedor * equiv_mm_pos_impresora , 		pos_y_razon_proveedor * equiv_mm_pos_impresora , 
				 pos_x_importe_letras1 * equiv_mm_pos_impresora , 		pos_y_importe_letras1 * equiv_mm_pos_impresora , 
				 pos_x_importe_letras2 * equiv_mm_pos_impresora , 		pos_y_importe_letras2 * equiv_mm_pos_impresora , 
				 pos_x_dia_emision * equiv_mm_pos_impresora , 			pos_y_dia_emision * equiv_mm_pos_impresora , 
				 pos_x_mes_emision * equiv_mm_pos_impresora , 			pos_y_mes_emision * equiv_mm_pos_impresora , 
				 pos_x_anyo_emision * equiv_mm_pos_impresora , 			pos_y_anyo_emision * equiv_mm_pos_impresora , 
				 margen_superior * equiv_mm_pos_impresora , 				margen_izquierdo * equiv_mm_pos_impresora,
				 imprimir_de_fecha_emision
		into   :pos_x_importe_numero, 										:pos_y_importe_numero, 
				 :pos_x_razon_proveedor, 										:pos_y_razon_proveedor, 
				 :pos_x_importe_letras1, 										:pos_y_importe_letras1, 
				 :pos_x_importe_letras2, 										:pos_y_importe_letras2, 
				 :pos_x_dia_emision, 											:pos_y_dia_emision, 
				 :pos_x_mes_emision, 											:pos_y_mes_emision, 
				 :pos_x_anyo_emision, 											:pos_y_anyo_emision, 
				 :margen_superior, 												:margen_izquierdo,
				 :imprimir_de_fecha_emision
		from   carpagos_plantilla_cheque	
		where  empresa = :codigo_empresa
		and    banco   = :banco; 
		
		if printsetup() = 1 then
			Job = PrintOpen()		
			
			if PrintDefineFont(Job, 1, "Courier 10Cpi",-10, 700, Default!, Decorative!,false,false) = 1 then
				PrintSetFont (Job,1)
			else
				cancelar_impresion_matricial = true
				PrintClose(Job)				
				messagebox("Atención!","Error al configurar la impresora")
			end if
		else
			cancelar_impresion_matricial = true
		end if
	end if
	
	if not(cancelar_impresion_matricial) then
		for i = 1 to dw_detalle.rowcount()
			proveedor  = dw_detalle.getitemstring(i,"proveedor")
			importe    = dw_detalle.getitemnumber(i,"importe")
			fdocumento = dw_detalle.getitemdatetime(i,"fcarta")
			documento  = dw_detalle.getitemstring(i,"documento")
			fvto		  = dw_detalle.getitemdatetime(i,"fvto")						
			
			if lb_impresion_matricial then 
				//
				pos_x = pos_x_importe_numero
				pos_y = pos_y_importe_numero
				texto_imprimir = "#"+Trim(String(importe,f_mascara_moneda(moneda_empresa)))+"#"
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				//
				pos_x = pos_x_razon_proveedor
				pos_y = pos_y_razon_proveedor
				texto_imprimir = f_tratar_texto_matricial(f_razon_genter(codigo_empresa,"P",proveedor))
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				//
				texto_importe_escrito = " #"+f_tratar_texto_matricial(trim(f_nombre_numero_con_decimales(importe,1,moneda_empresa)))+"#"
				aux = len(texto_importe_escrito)
				if len(texto_importe_escrito) <= 60 then
					texto_importe_escrito1 = texto_importe_escrito
					texto_importe_escrito2 = ""
				else
					posicion_busqueda = 60
					do
						posicion_busqueda --
						posicion_espacio = pos(texto_importe_escrito," ",posicion_busqueda)				
					loop until posicion_espacio > 0 and posicion_espacio <= 60							
					texto_importe_escrito1 = mid(texto_importe_escrito,1,posicion_espacio)
					texto_importe_escrito2 = mid(texto_importe_escrito,posicion_espacio+1,60)
	
				end if												
				
				pos_x = pos_x_importe_letras1
				pos_y = pos_y_importe_letras1
				texto_imprimir = texto_importe_escrito1
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				pos_x = pos_x_importe_letras2
				pos_y = pos_y_importe_letras2
				texto_imprimir = texto_importe_escrito2
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				//
				pos_x = pos_x_dia_emision
				pos_y = pos_y_dia_emision
				if imprimir_de_fecha_emision = "S" then
					texto_imprimir = string(day(date(fdocumento)),"##") + " de"
				else
					texto_imprimir = string(day(date(fdocumento)),"##")
				end if
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				//
				pos_x = pos_x_mes_emision
				pos_y = pos_y_mes_emision
				texto_imprimir = upper(f_nombre_mes(month(date(fdocumento))))
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				//
				pos_x = pos_x_anyo_emision
				pos_y = pos_y_anyo_emision						
				texto_imprimir = string(year(date(fdocumento)),"####")
				PrintText(Job,texto_imprimir,pos_x,pos_y)
				
				printpage(job)						
			else
				linea = dw_cheque.insertrow(0)
				
				dw_cheque.setitem(linea,"proveedor",proveedor)
				dw_cheque.setitem(linea,"importe",importe)
				dw_cheque.setitem(linea,"fdocumento",fdocumento)
				dw_cheque.setitem(linea,"documento",documento)		
				dw_cheque.setitem(linea,"fvto",fvto)		
//				dw_cheque.setitem(linea,"moneda",moneda_empresa)
			end if
		next
		if lb_impresion_matricial then
			PrintClose(Job)
		end if
	end if
end if

if not(lb_impresion_matricial) then
	dw_cheque.GroupCalc()
	f_imprimir_datawindow(dw_cheque)
end if
end event

type cb_1 from commandbutton within w_emision_documentos_pago
integer x = 2875
integer y = 1420
integer width = 699
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;int      opci,dec_moneda,donde
long     i,j,cuantos
string   marca,emp,n_talon,proveedor,prove,agrupar,sel,moneda,moneda_fra
dec      anyo,orden,cantidad,anyo_efecto,nuevo_efecto
dec      anyo_max_fvto,orden_max_fvto,ultimo_anyo,ultimo_orden
datetime femision,fvto,max_fvto,fvto_selec
int      recibo
boolean  bien = true

str_carpagos carpagos
str_carpagosdetagrupado detagrupado

dw_detalle.accepttext()

opci = messagebox("Atención","¿Desea dar como emitidos los efectos seleccionados ?",question!,yesno!,1)
if opci = 2 then return

if f_dividir_pagos_parciales() then
	// para cada proveedor 
	for i = 1 to dw_detalle.rowcount()
		proveedor 	= dw_detalle.getitemstring(i,"proveedor")
		cuantos 		= 0	
		cantidad 	= 0
		n_talon		= dw_detalle.getitemstring(i,"documento")
		fvto_selec	= dw_detalle.getitemdatetime(i,"fvto")
		femision		= dw_detalle.getitemdatetime(i,"fcarta")
		anyo        = dw_detalle.object.anyo[i]
		orden       = dw_detalle.object.orden[i]
		moneda      = dw_detalle.object.moneda[i]							
					
		if anyo = 0 and orden = 0 then
			// Recorremos buscando el nº de efectos del proveedor
			for j = 1 to dw_1.rowcount()
				prove      = dw_1.getitemstring(j,"proveedor")
				fvto	     = dw_1.getitemdatetime(j,"fvto")
				marca      = dw_1.getitemstring(j,"marca")
				agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
				moneda_fra = dw_1.getitemstring(j,"moneda")
				
				if marca = "S"  and proveedor = prove and fvto_selec = fvto and moneda = moneda_fra and agrupar = "S" then			
					cuantos 		 = cuantos + 1					
					cantidad 	 = cantidad + dw_1.getitemnumber(j,"carpagos_importe_a_pagar")			
					ultimo_anyo  = dw_1.getitemnumber(j,"anyo")			
					ultimo_orden = dw_1.getitemnumber(j,"orden")			
				end if	
			next		
		else
			sel   = "anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######") 
			donde = dw_1.find(sel,1,dw_1.rowcount())
			
			if donde > 0 then
				cuantos 		 = 1					
				cantidad 	 = dw_1.getitemnumber(donde,"carpagos_importe_a_pagar")			
				ultimo_anyo  = anyo
				ultimo_orden = orden				
			end if
		end if
		
		
		// Si hay varios se hace un efecto agrupado por el total
		if cuantos > 1 then		
			anyo_efecto = year(date(em_hasta.text))		
			
			select max(orden) 
			into   :nuevo_efecto
			from 	 carpagos
			where  empresa	= :codigo_empresa
			and	 anyo		= :anyo_efecto;
			
			if isnull(nuevo_efecto) then nuevo_efecto = 0
			nuevo_efecto = nuevo_efecto + 1 
			
			//Pasamos todos los efectos de carpagos a carpagosdetagrupado
			detagrupado.empresa        = codigo_empresa
			detagrupado.anyo_agrupado  = anyo_efecto
			detagrupado.orden_agrupado = nuevo_efecto
			
			for j = 1 to dw_1.rowcount()
				prove      = dw_1.getitemstring(j,"proveedor")
				fvto	     = dw_1.getitemdatetime(j,"fvto")
				marca      = dw_1.getitemstring(j,"marca")
				agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
				moneda_fra = dw_1.getitemstring(j,"moneda")
				
				if marca = "S"  and proveedor = prove and fvto_selec = fvto and moneda = moneda_fra and agrupar = "S" then				
					detagrupado.anyo  = dw_1.getitemnumber(j,"anyo")
					detagrupado.orden = dw_1.getitemnumber(j,"orden")
					
					//Pasamos todos los efectos de carpagos a carpagosdetagrupado
					SELECT anyofra, 								fra, 								recibo,
							 ffra, 									fvto, 							fpago, 
							 importe, 								divisas, 						moneda, 
							 banco, 									proveedor, 						tipodoc, 
							 codpago, 								situacion, 						cuenta, 
							 femi, 									num_talon, 						asignar_banco, 
							 tipodoc_pago, 						cambio, 							punteado,
							 concepto
					INTO   :detagrupado.anyofra, 				:detagrupado.fra, 			:detagrupado.recibo,
							 :detagrupado.ffra, 					:detagrupado.fvto, 			:detagrupado.fpago,
							 :detagrupado.importe, 				:detagrupado.divisas, 		:detagrupado.moneda,
							 :detagrupado.banco, 				:detagrupado.proveedor, 	:detagrupado.tipodoc,
							 :detagrupado.codpago, 				:detagrupado.situacion, 	:detagrupado.cuenta,
							 :detagrupado.femi, 					:detagrupado.num_talon, 	:detagrupado.asignar_banco, 
							 :detagrupado.tipodoc_pago, 		:detagrupado.cambio, 		:detagrupado.punteado, 
							 :detagrupado.concepto
					FROM 	 carpagos
					WHERE  empresa = :codigo_empresa
					AND    anyo    = :detagrupado.anyo
					AND	 orden   = :detagrupado.orden;
					
					if sqlca.sqlcode <> 0 then
						bien = false
						messagebox("ERROR","Seleccionando los efectos a agrupar ~nEfecto"+string(detagrupado.orden,"######")+"/"+string(detagrupado.anyo,"####")+"~n"+sqlca.sqlerrtext)
					else
						detagrupado.num_talon = n_talon
						
						if not(f_insert_carpagosdetagrupado(detagrupado)) then
							bien = false
							messagebox("ERROR","Grabando el detalle del agrupado")
						end if
					end if		
					
					// Guardamos la clave del ultimo efecto				
					anyo_max_fvto 	= detagrupado.anyo
					orden_max_fvto	= detagrupado.orden														
					
				end if	
			next		
					
			// recogemos datos para el efecto agrupado				
			// a partir del ultimo efecto
			SELECT carpagos.fvto, 				carpagos.fpago, 		 	carpagos.moneda,
					 carpagos.banco, 				carpagos.proveedor,		carpagos.tipodoc,
					 carpagos.codpago, 			carpagos.situacion,	 	carpagos.cuenta,
					 carpagos.femi, 				carpagos.num_talon,	 	carpagos.asignar_banco,
					 carpagos.tipodoc_pago, 	carpagos.punteado, 		carpagos.concepto,
					 carpagos.cambio
			INTO   :carpagos.fvto, 				:carpagos.fpago, 		 	:carpagos.moneda,
					 :carpagos.banco, 			:carpagos.proveedor,		:carpagos.tipodoc,
					 :carpagos.codpago, 			:carpagos.situacion,	 	:carpagos.cuenta,
					 :carpagos.femi, 				:carpagos.num_talon,	 	:carpagos.asignar_banco,
					 :carpagos.tipodoc_pago, 	:carpagos.punteado,		:carpagos.concepto,
					 :carpagos.cambio
			FROM 	 carpagos
			WHERE  empresa = :codigo_empresa
			AND    anyo    = :anyo_max_fvto
			AND	 orden   = :orden_max_fvto;				
			
			if sqlca.sqlcode <> 0 then
				bien = false
				messagebox("ERROR","Creando el efecto agrupado~n"+sqlca.sqlerrtext)			
			end if		
	
			carpagos.empresa      = codigo_empresa
			carpagos.anyo		    =	anyo_efecto
			carpagos.orden		    =	nuevo_efecto		
			carpagos.anyofra      = year(today())
			carpagos.fra          = "AGRUPADO"
			carpagos.recibo       = 1
			carpagos.ffra         = datetime(today())
			carpagos.situacion    = "1"
			carpagos.importe      = cantidad
			dec_moneda            = f_decimales_moneda(carpagos.moneda)
			if isnull(carpagos.cambio) then carpagos.cambio = 0
			if carpagos.cambio = 0 then carpagos.cambio = 1
			carpagos.divisas      = round(carpagos.importe * carpagos.cambio,dec_moneda)
			carpagos.punteado     = "N"
			carpagos.agrupado     = "S"					
			carpagos.fvto         = fvto_selec
			carpagos.fpago        = fvto_selec
			carpagos.femi         = femision	
			carpagos.tipodoc_pago = carpagos.tipodoc
			carpagos.num_talon    = n_talon	
								
			if not f_insert_carpagos(carpagos) then
				bien = false
				messagebox("ERROR","Insertando el efecto agrupado")				
			else			
				//Borramos los efectos que hemos agrupado
				for j = 1 to dw_1.rowcount()
					prove      = dw_1.getitemstring(j,"proveedor")
					fvto	     = dw_1.getitemdatetime(j,"fvto")
					marca      = dw_1.getitemstring(j,"marca")
					agrupar    = dw_1.getitemstring(j,"carpagos_agrupar")
					moneda_fra = dw_1.getitemstring(j,"moneda")
					
					if marca = "S"  and proveedor = prove and fvto_selec = fvto and moneda = moneda_fra and agrupar = "S" then
						detagrupado.anyo  = dw_1.getitemnumber(j,"anyo")
						detagrupado.orden = dw_1.getitemnumber(j,"orden")
				
						delete carpagos
						where  empresa = :codigo_empresa
						and    anyo    = :detagrupado.anyo
						and	 orden   = :detagrupado.orden;
				
						if sqlca.sqlcode <> 0 then
							bien = false
							messagebox("ERROR","Borrando el efecto a agrupar")
						end if				
					end if	
				next								
			end if
		
		// hay un único efecto -> se actualiza
		else		
			Update carpagos
			set  	carpagos.situacion 	= "1",
					carpagos.banco		 	=	:uo_banco.em_codigo.text,
					carpagos.num_talon 	=	:n_talon,			
					carpagos.femi			=	:femision,
					carpagos.fvto			=	:fvto_selec
			where ( carpagos.empresa 	= 	:codigo_empresa )  
			and	( carpagos.anyo	 	=	:ultimo_anyo)  
			and	( carpagos.orden		=	:ultimo_orden);
	
			if sqlca.sqlcode <> 0 then 
				bien = false
				messagebox("Error", "Actualizando el efecto ")
			end if
			
		end if	
				
	next
else
	bien = false
end if

if bien then
	commit;
else
	rollback;
end if

f_cargar(dw_1)
dw_detalle.reset()
end event

type gb_3 from groupbox within w_emision_documentos_pago
integer x = 2862
integer y = 88
integer width = 731
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_emision_documentos_pago
integer x = 9
integer y = 204
integer width = 3095
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_emision_documentos_pago
integer x = 2866
integer y = 1108
integer width = 722
integer height = 412
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cbx_transf_moneda_fra from checkbox within w_emision_documentos_pago
boolean visible = false
integer x = 2880
integer y = 1532
integer width = 59
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type st_transf_moneda_fra from statictext within w_emision_documentos_pago
boolean visible = false
integer x = 2953
integer y = 1532
integer width = 622
integer height = 172
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Realizar la transferencia en la moneda de la factura"
boolean focusrectangle = false
end type

type rb_bsch from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1436
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Santander"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_bch"

dw_pagares.SetTransObject(sqlca)


end event

type rb_santander from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1488
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bco Santander"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_bco_santander"

dw_pagares.SetTransObject(sqlca)
end event

type rb_bancaja from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1484
integer width = 672
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bancaja"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_bancaja"

dw_pagares.SetTransObject(sqlca)
end event

type rb_bco_popular from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1540
integer width = 672
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bco Popular"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_bco_popular"

dw_pagares.SetTransObject(sqlca)
end event

type rb_bbva from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1596
integer width = 672
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BBVA"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagares_bbva" //"report_emision_pagare_bbva"

dw_pagares.SetTransObject(sqlca)
end event

type dw_listado_pagos_emitidos from datawindow within w_emision_documentos_pago
boolean visible = false
integer x = 2871
integer y = 20
integer width = 229
integer height = 76
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_pagos_emitidos"
boolean livescroll = true
end type

type pb_imprimir_pagos_emitidos from picturebutton within w_emision_documentos_pago
integer x = 2743
integer y = 1136
integer width = 105
integer height = 80
integer taborder = 150
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\imp32.bmp"
end type

event clicked;Integer  ln,i,efecto,anyo
String   numero_documento,proveedor,banco,tipodoc,prove,marca,mon,factura,agrupar
string   moneda,moneda_factura,nombre_proveedor,moneda_empresa
DateTime fecha_vencimiento_efecto,fecha_vto_documento,fecha_factura,fecha_emision
long     reg1,reg2,j,donde,orden
dec      importe,divisas

tipodoc        = Trim(uo_tipodoc.em_codigo.text)
banco          = Trim(uo_banco.em_codigo.text)
fecha_emision  = datetime(date(em_fcarta.text))
moneda_empresa = f_moneda_empresa(codigo_empresa)

dw_listado_pagos_emitidos.Retrieve(codigo_empresa,tipodoc,banco,fecha_emision)

if f_comprueba_numdocumento() then

	reg1 = dw_detalle.rowcount()
	reg2 = dw_1.rowcount()	
	
	for i = 1 to reg1
		proveedor           = dw_detalle.getitemstring(i,"proveedor")
		fecha_vto_documento = dw_detalle.getitemdatetime(i,"fvto")
		moneda              = dw_detalle.getitemstring(i,"moneda")
		numero_documento    = dw_detalle.object.documento[i]
		anyo                = dw_detalle.object.anyo[i]
		orden               = dw_detalle.object.orden[i]
						
		if anyo = 0 and orden = 0 then		
			nombre_proveedor    = f_razon_genter(codigo_empresa,"P",proveedor)
			for j = 1 to reg2 
				marca = dw_1.getitemstring(j,"marca")
				if marca = "S" then
					prove                    = dw_1.getitemstring(j,"proveedor")
					fecha_vencimiento_efecto = dw_1.getitemdatetime(j,"fvto")
					moneda_factura           = dw_1.getitemstring(j,"moneda")
					agrupar                  = dw_1.getitemstring(j,"carpagos_agrupar")
					
					if prove = proveedor and fecha_vto_documento = fecha_vencimiento_efecto and moneda = moneda_factura and agrupar = "S" then					
						efecto        = dw_1.object.recibo[j]					
						divisas       = dw_1.object.carpagos_divisas_a_pagar[j]
						importe 	     = dw_1.getitemnumber(j,"carpagos_importe_a_pagar")
						factura       = dw_1.getitemstring(j,"fra")
						fecha_factura = dw_1.getitemdatetime(j,"ffra")						
						
						donde    = dw_listado_pagos_emitidos.insertrow(0)
						dw_listado_pagos_emitidos.object.empresa[donde]           = codigo_empresa 
						dw_listado_pagos_emitidos.object.factura[donde]           = factura
						dw_listado_pagos_emitidos.object.fecha_factura[donde]     = fecha_factura
						dw_listado_pagos_emitidos.object.efecto[donde]            = efecto
						dw_listado_pagos_emitidos.object.fecha_vencimiento[donde] = fecha_vencimiento_efecto
						dw_listado_pagos_emitidos.object.numero_documento[donde]  = numero_documento
						dw_listado_pagos_emitidos.object.proveedor[donde]         = proveedor
						dw_listado_pagos_emitidos.object.nombre_proveedor[donde]  = nombre_proveedor
						dw_listado_pagos_emitidos.object.moneda_factura[donde]    = moneda_factura
						dw_listado_pagos_emitidos.object.divisas[donde]           = divisas
						dw_listado_pagos_emitidos.object.moneda_empresa[donde]    = moneda_empresa
						dw_listado_pagos_emitidos.object.importe[donde]           = importe
						dw_listado_pagos_emitidos.object.fecha_vto_documento[donde] = fecha_vto_documento
					end if
				end if
			next
		else
			//Solo para Exagres
			//nombre_proveedor = f_nombre_proveedor_carpagos(codigo_empresa,anyo,orden)
			
			j = dw_1.find("anyo = "+string(anyo,"####")+" and orden = "+string(orden,"######"),1,dw_1.rowcount())
			
			if j > 0 then
				prove                    = dw_1.getitemstring(j,"proveedor")
				fecha_vencimiento_efecto = dw_1.getitemdatetime(j,"fvto")
				moneda_factura           = dw_1.getitemstring(j,"moneda")				
				efecto                   = dw_1.object.recibo[j]					
				divisas                  = dw_1.object.carpagos_divisas_a_pagar[j]
				importe 	                = dw_1.getitemnumber(j,"carpagos_importe_a_pagar")
				factura                  = dw_1.getitemstring(j,"fra")
				fecha_factura            = dw_1.getitemdatetime(j,"ffra")						
				
				donde    = dw_listado_pagos_emitidos.insertrow(0)
				dw_listado_pagos_emitidos.object.empresa[donde]           = codigo_empresa 
				dw_listado_pagos_emitidos.object.factura[donde]           = factura
				dw_listado_pagos_emitidos.object.fecha_factura[donde]     = fecha_factura
				dw_listado_pagos_emitidos.object.efecto[donde]            = efecto
				dw_listado_pagos_emitidos.object.fecha_vencimiento[donde] = fecha_vencimiento_efecto
				dw_listado_pagos_emitidos.object.numero_documento[donde]  = numero_documento
				dw_listado_pagos_emitidos.object.proveedor[donde]         = proveedor
				dw_listado_pagos_emitidos.object.nombre_proveedor[donde]  = nombre_proveedor
				dw_listado_pagos_emitidos.object.moneda_factura[donde]    = moneda_factura
				dw_listado_pagos_emitidos.object.divisas[donde]           = divisas
				dw_listado_pagos_emitidos.object.moneda_empresa[donde]    = moneda_empresa
				dw_listado_pagos_emitidos.object.importe[donde]           = importe
				dw_listado_pagos_emitidos.object.fecha_vto_documento[donde] = fecha_vto_documento				
			end if
		end if
	next
	dw_listado_pagos_emitidos.sort()
	dw_listado_pagos_emitidos.groupcalc()
	f_imprimir_datawindow(dw_listado_pagos_emitidos)
end if







end event

type dw_detalle from datawindow within w_emision_documentos_pago
integer x = 5
integer y = 1128
integer width = 2853
integer height = 820
boolean titlebar = true
string title = "Documentos a Emitir"
string dataobject = "dw_pago_efectos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long indice,total,documento
boolean negativos = false

total = this.rowcount()

if total > 1 then
	if dwo.name = "pb_renumera" then
		if messagebox("Confirmación","¿Desea renumerar los documentos?",Question!,YesNo!,2) = 1 then
			this.accepttext()
			documento = dec(this.object.documento[1])
			
			if documento > 0 then
				for indice = 2 to total
					if this.object.importe[indice] > 0 then
						documento ++
						this.object.documento[indice] = string(documento,"##########")
					else
						negativos = true
					end if
				next
			else
				messagebox("Atención","Debe introducir el primer numero de documento")
			end if
		end if
	end if
end if

if negativos then
	messagebox("atención","Esta intentando emitir documentos en negativo")
end if
end event

type cbx_una_sola_carta_por_proveedor from checkbox within w_emision_documentos_pago
integer x = 2880
integer y = 1536
integer width = 59
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_1 from statictext within w_emision_documentos_pago
integer x = 2953
integer y = 1536
integer width = 613
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Imprimir una sola carta por proveedor."
boolean focusrectangle = false
end type

type rb_banesto from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1652
integer width = 672
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Banesto"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_banesto"

dw_pagares.SetTransObject(sqlca)
end event

type pb_n_68 from picturebutton within w_emision_documentos_pago
integer x = 2875
integer y = 1748
integer width = 233
integer height = 192
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "N 68"
string picturename = "C:\BMP\DISKSAVE.BMP"
string disabledname = "C:\bmp\prohibido.bmp"
string powertiptext = "N 68"
end type

event clicked;if messagebox("Generación de pagos domiciliados","¿Desea generar fichero de norma 68 ?", question!, yesno!, 1) = 1 then
	f_grabar_norma_68()
end if
end event

type st_n68 from statictext within w_emision_documentos_pago
integer x = 2926
integer y = 1864
integer width = 123
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "N 68"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;pb_n_68.event clicked()
end event

type pb_n_34 from picturebutton within w_emision_documentos_pago
integer x = 3104
integer y = 1748
integer width = 233
integer height = 192
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "N 68"
string picturename = "C:\BMP\DISKSAVE.BMP"
string disabledname = "C:\bmp\prohibido.bmp"
string powertiptext = "N 68"
end type

event clicked;string ls_tipodoc

ls_tipodoc = uo_tipodoc.em_campo.text

if messagebox("Generación de "+ls_tipodoc,"¿Desea generar fichero de norma 34 ?", question!, yesno!, 1) = 1 then
	if uo_tipodoc.em_codigo.text = "6" then
		//Transferencias
		f_grabar_norma34_sepa()
	else
		if uo_banco.em_codigo.text = "12" then
			f_grabo_norma_34_sabadell()
		else
			f_grabar_norma34()
		end if
	end if
end if
end event

type st_n34 from statictext within w_emision_documentos_pago
integer x = 3154
integer y = 1864
integer width = 123
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "N 34"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;pb_n_34.event clicked()
end event

type gb_5 from groupbox within w_emision_documentos_pago
integer x = 2866
integer y = 1496
integer width = 722
integer height = 452
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type rb_empresa from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1868
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Empresa"
boolean checked = true
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagares_empresa"

dw_pagares.SetTransObject(sqlca)
end event

type rb_matricial from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1816
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Matricial"
end type

event clicked;
if uo_banco.em_codigo.text = "16" then
	//Popular
	dw_pagares.dataobject = "report_emision_pagare_bcopopular_matric"
else
	//dw_pagares.dataobject = "report_emision_pagare_matric"
	dw_pagares.dataobject = "report_emision_pagare_matric_w2k"
end if

dw_pagares.SetTransObject(sqlca)

//dw_pagares.Object.DataWindow.Print.Quality = 4

end event

type rb_ibercaja from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1764
integer width = 672
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ibercaja"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagares_ibercaja"

dw_pagares.SetTransObject(sqlca)
end event

type rb_cajaruralandorra from radiobutton within w_emision_documentos_pago
boolean visible = false
integer x = 2894
integer y = 1708
integer width = 672
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Caja Rural"
end type

event clicked;
dw_pagares.dataobject = "report_emision_pagare_cajaruralandorra"

dw_pagares.SetTransObject(sqlca)
end event

type pb_sepa from picturebutton within w_emision_documentos_pago
integer x = 3342
integer y = 1748
integer width = 233
integer height = 192
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "N 68"
string picturename = "C:\BMP\DISKSAVE.BMP"
string disabledname = "C:\bmp\prohibido.bmp"
string powertiptext = "N 68"
end type

event clicked;string ls_tipodoc

ls_tipodoc = uo_tipodoc.em_campo.text

if uo_tipodoc.em_codigo.text = "6" then
	if messagebox("Generación de "+ls_tipodoc,"¿Desea generar fichero SEPA ?", question!, yesno!, 1) = 1 then	
		//Transferencias
		f_grabar_norma34_sepa_xml()
	end if
end if
end event

type st_7 from statictext within w_emision_documentos_pago
integer x = 3383
integer y = 1864
integer width = 137
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "SEPA"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;pb_sepa.event clicked()
end event

