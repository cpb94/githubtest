$PBExportHeader$w_confirmacion_remesas.srw
$PBExportComments$€
forward
global type w_confirmacion_remesas from w_int_con_empresa
end type
type gb_5 from groupbox within w_confirmacion_remesas
end type
type pb_1 from upb_salir within w_confirmacion_remesas
end type
type em_banco from u_em_campo within w_confirmacion_remesas
end type
type st_1 from statictext within w_confirmacion_remesas
end type
type st_nombre_banco from statictext within w_confirmacion_remesas
end type
type dw_1 from datawindow within w_confirmacion_remesas
end type
type st_2 from statictext within w_confirmacion_remesas
end type
type em_remesa from u_em_campo within w_confirmacion_remesas
end type
type cb_1 from commandbutton within w_confirmacion_remesas
end type
type em_tipo_remesa from u_em_campo within w_confirmacion_remesas
end type
type st_3 from statictext within w_confirmacion_remesas
end type
type st_4 from statictext within w_confirmacion_remesas
end type
type rb_1 from radiobutton within w_confirmacion_remesas
end type
type rb_2 from radiobutton within w_confirmacion_remesas
end type
type cb_2 from commandbutton within w_confirmacion_remesas
end type
type gb_3 from groupbox within w_confirmacion_remesas
end type
type gb_2 from groupbox within w_confirmacion_remesas
end type
type gb_1 from groupbox within w_confirmacion_remesas
end type
type st_5 from statictext within w_confirmacion_remesas
end type
type st_fecha from statictext within w_confirmacion_remesas
end type
type dw_2 from datawindow within w_confirmacion_remesas
end type
type st_6 from statictext within w_confirmacion_remesas
end type
type em_anyo from editmask within w_confirmacion_remesas
end type
type gb_4 from groupbox within w_confirmacion_remesas
end type
type st_7 from statictext within w_confirmacion_remesas
end type
type st_8 from statictext within w_confirmacion_remesas
end type
type st_9 from statictext within w_confirmacion_remesas
end type
type em_fcontable from editmask within w_confirmacion_remesas
end type
type st_10 from statictext within w_confirmacion_remesas
end type
type st_11 from statictext within w_confirmacion_remesas
end type
type st_12 from statictext within w_confirmacion_remesas
end type
end forward

global type w_confirmacion_remesas from w_int_con_empresa
integer width = 2953
integer height = 1620
gb_5 gb_5
pb_1 pb_1
em_banco em_banco
st_1 st_1
st_nombre_banco st_nombre_banco
dw_1 dw_1
st_2 st_2
em_remesa em_remesa
cb_1 cb_1
em_tipo_remesa em_tipo_remesa
st_3 st_3
st_4 st_4
rb_1 rb_1
rb_2 rb_2
cb_2 cb_2
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
st_5 st_5
st_fecha st_fecha
dw_2 dw_2
st_6 st_6
em_anyo em_anyo
gb_4 gb_4
st_7 st_7
st_8 st_8
st_9 st_9
em_fcontable em_fcontable
st_10 st_10
st_11 st_11
st_12 st_12
end type
global w_confirmacion_remesas w_confirmacion_remesas

type variables
string filtro

integer var_ejercicio
string es_nacional,is_naci_extra,is_nacional
string inst_tipodoc
end variables

forward prototypes
public subroutine f_fecha_remesa ()
public subroutine f_socorro ()
end prototypes

public subroutine f_fecha_remesa ();// Obtenemos la fecha de la remesa
datetime fecha_remesa

dec{2} la_remesa,el_anyo

la_remesa = dec(em_remesa.text)

el_anyo =	dec(em_anyo.text)

select distinct fremesa into :fecha_remesa
from carefectos
where (empresa = :codigo_empresa) and 
		(nacional = :is_nacional) and 
		(banco = :em_banco.text) and
		(anyo_remesa = :el_anyo) and
		(remesa = :la_remesa ); 
		
if sqlca.sqlcode = 0 then
	st_fecha.text = string(date(fecha_remesa))
	st_5.visible = true
	
else
	st_fecha.text = ""	
	st_5.visible = false
end if

end subroutine

public subroutine f_socorro ();////******************************************************************
//// CONTROLES DE DATOS 
////******************************************************************
//// Control de los campos introducidos
//
//IF em_tipo_remesa.text = "" OR em_anyo.text ="" OR em_remesa.text = "" THEN
//	
//	messagebox("Atención","Debe introducir los datos de :  Banco, Remesa, Año y Tipo de remesa ")
//	RETURN
//END IF
//
//// Control de la dw : debe haberse consultado
//
//IF dw_1.rowcount() <= 0 THEN
//	messagebox("Atención","No existe remesa, no se ha hecho la consulta o la remesa ya ha sido cnfirmada",Exclamation!)
//	RETURN
//END IF
//
////*********************************************************************
//// Ejercicio
////*********************************************************************
//
//dec{2} ejer_act
//datetime f_contable
//f_contable =	datetime(date(em_fcontable.text))
//ejer_act = year(date(em_fcontable.text))
//
//// ********************************************************************
//// OBTENEMOS TOTAL REMESA
//// ********************************************************************
//long total_remesa
//
//total_remesa = dw_1.getitemnumber(1,"total")
//
////*********************************************************************
//// EN LA VARIABLE INSTANCIA inst_tipodoc EL TIPO DE DOCUMENTO
//// *********************************************************************
//int anyo_int,rem_int
//DateTime	fremesa
//
//anyo_int = integer(em_anyo.text)
//rem_int = integer (em_remesa.text )		
//
//SELECT carremesas.tipodoc,carremesas.fremesa INTO :inst_tipodoc,:fremesa
//FROM carremesas 
//WHERE carremesas.empresa = :codigo_empresa
//AND	carremesas.anyo = :anyo_int
//AND	carremesas.banco = :em_banco.text
//AND	carremesas.naci_extra = "N"
//AND	carremesas.remesa = :rem_int USING SQLCA;
//
//
////**********************************************************************
////	CODIFICACIÓN POSIBILIDADES CONFIRMACIÓN DE REMESA
////**********************************************************************
//
///*	Caso 1 : remesa a gestión de cobro
//	Caso 2 : remesa a riesgo y con liquidación
//	Caso 3 : remesa a riesgo y sin liquidación
//*/
//
//
//int caso,continuar
//
//IF em_tipo_remesa.text = "2" THEN
//	caso = 1	
//ELSE
//	IF rb_1.checked = TRUE THEN caso = 2
//	IF rb_2.checked = TRUE THEN caso = 3	
//END IF
//
//
////**********************************************************************
//// ESTRUCTURA PARA EL ASIENTO
////**********************************************************************
//
//Str_contaapun apu  
//
//dec{2} el_anyo,la_remesa,el_saldo,total_saldo
//string la_cuenta,el_banco
//int error_num, num_apunte,i
//boolean res 		
//
//el_anyo = dec(em_anyo.text)
//la_remesa = dec(em_remesa.text)
//el_banco 	= Trim(em_banco.text)
//
//
//// Datos comunes a todos los apuntes
//
//num_apunte		=	0	// inicialmente 0, se incrementa con cada apunte
//apu.ejercicio 	=	int(ejer_act)
//apu.empresa 	=	codigo_empresa
//apu.origen		=	f_diario_contagene(codigo_empresa,"13")	
//apu.asiento		=	f_ultimo_asiento(ejer_act,codigo_empresa,month(date(f_contable)),apu.origen)
//apu.fapunte		=	f_contable
//	
//setnull(apu.diario)
//Setnull(apu.tipoapu)
//setnull(apu.documento)
//setnull(apu.factura)
//setnull(apu.ffactura)
//setnull(apu.imponible)
//setnull(apu.tipoiva)
//setnull(apu.iva)
//setnull(apu.divisas)
//setnull(apu.deducible)
//setnull(apu.actualizado)
//setnull(apu.listado)
//setnull(apu.registro)
//
//setnull(apu.tipoter)
//setnull(apu.clipro)
//setnull(apu.conciliado)
//setnull(apu.nif)
//setnull(apu.punteado)
//// la fvalOR es la fapunte
//apu.fvalOR	= apu.fapunte
//setnull(apu.docpunteo)
//setnull(apu.coste)
//setnull(apu.fregistro)
//
//apu.cambio	=	1
//apu.moneda	=	"1"
//apu.mes		=	month(date(f_contable))
//
//
//
////*********************************************************************+
////		CONFIRMACIÓN REMESAS
////**********************************************************************
//
//// no hay error 
//error_num = 0
//
//
//choose case caso
//	
//	
//	//*********************************************************************
//	// Remesa a gestión de cobros
//	//**********************************************************************
//	case 1
//		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " + st_4.text  +" ?" ,question!,yesno!,1)
//		IF continuar = 2 THEN
//			// No continuar
//			RETURN
//		ELSE
//			// Actualización del efecto en carpagos a la nueva situación 6, gestión de cobro
//			// Comprobamos si hay valORes
//			int registros
//			SELECT count(*) INTO :registros FROM carefectos
//			WHERE carefectos.empresa 		= :codigo_empresa
//			AND	carefectos.banco			= :el_banco
//			AND	carefectos.anyo_remesa 	= :el_anyo
//			AND	carefectos.remesa 		= :la_remesa
//			AND	carefectos.nacional 		= 'S'
//			AND	carefectos.situacion 	= "1";
//			
//			IF registros > 0 THEN
//				UPDATE carefectos  SET situacion = "6"  
//				WHERE carefectos.empresa 		= :codigo_empresa
//				AND	carefectos.banco			= :el_banco
//				AND	carefectos.anyo_remesa = :el_anyo
//				AND	carefectos.remesa 		= :la_remesa
//				AND	carefectos.nacional 	= 'S'
//				AND	carefectos.situacion 	= "1";
//						
//			// Cambiamos la situación de la remesa en CarRemesas
//			// Ahora es remesa confirmada sin gastos 
//			// El tipo de la remesa es "G" (Gestión de Cobro)
//			
//			UPDATE carremesas  SET situacion = "2",tiporem = :em_tipo_remesa.text
//			WHERE	carremesas.empresa 		= :codigo_empresa
//			AND	carremesas.anyo 			= :anyo_int
//			AND	carremesas.banco 			= :el_banco
//			AND	carremesas.naci_extra 	= "N"
//			AND	carremesas.remesa 		= :rem_int;
//			// No hay Apuntes contables													
//			ELSE
//				error_num = 1					
//			END IF
//		END IF
//		
//	//*********************************************************************
//	// Remesa al descuento(riesgo) con liquidación
//	//**********************************************************************	
//		
//	case 2  
//		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " +  st_4.text + " con liquidación" + " ?", question!,yesno!,1)
//		IF continuar = 2 THEN
//			// No continuar
//			RETURN
//		ELSE
//			// Comprobamos si hay valORes en la remesa antes de hacer update
//			
//			SELECT count(*) INTO :registros FROM carefectos
//			WHERE carefectos.empresa 		= :codigo_empresa
//			AND	carefectos.banco			= :el_banco
//			AND	carefectos.anyo_remesa 	= :el_anyo
//			AND	carefectos.remesa 		= :la_remesa
//			AND	carefectos.nacional 		= 'S'
//			AND	carefectos.situacion 	= "1";
//			
//			IF registros > 0 THEN
//				// Pasamos a situación de riesgo en cartera			
//				UPDATE carefectos  SET situacion = "5"  
//				WHERE carefectos.empresa 		= :codigo_empresa
//				AND	carefectos.banco			= :el_banco
//				AND	carefectos.anyo_remesa 	= :el_anyo
//				AND	carefectos.remesa 		= :la_remesa
//				AND	carefectos.nacional 		= 'S'
//				AND	carefectos.situacion 	= "1";
//				//*******************************************************
//				// Liquidación
//				//*******************************************************
//				//Pedimos los datos de gastos en otra pantalla
//								
//				// Estructura para el pase de parámetros
//				str_imput_gastos datos,datos_salida
//				
//				datos.banco 		= em_banco.text
//				datos.anyo 			= integer(em_anyo.text)
//				datos.remesa 		= integer(em_remesa.text)
//				datos.naci_extra 	= "N"
//				datos.tipodoc 		= inst_tipodoc
//				
//				// Visible el apunte al banco
//				datos.visible_importe = true
//				// Sí se hace cálculo de intereses
//				datos.calcula_intereses = true
//				
//				
//				// Pasamos los efectos de la remesa a la estructura datos
//				int k
//				
//				datos.num_efectos = dw_1.rowcount() 
//				fOR k = 1 to datos.num_efectos
//					datos.efectos_orden[k] 	 = dw_1.getitemnumber(k,"orden") 
//					datos.efectos_fvto[k] 	 = dw_1.getitemdatetime(k,"fvto")
//					datos.efectos_importe[k] = dw_1.getitemnumber(k,"importe")
//				next
//				
//				// Pantalla para obtener los gastos			
//				openwithparm(w_input_gastos,datos)
//				
//				datos_salida = Message.powerobjectparm 
//				
//				IF datos_salida.correcto = false THEN 
//					messagebox("Atención","No se ha confirmado la remesa")
//					rollback;
//					RETURN
//				END IF
//											
//				
//				dec importe_banco,gastos_rem,suma_comprob
//				boolean todo
//				// el usuario puede introducir en importe remesa el total
//				// de la remesa o el total descontANDo los gastos,
//				// lo comprobamos aquí
//				IF dec(total_remesa) = datos_salida.importe_salida THEN
//					// si ha puesto el total descontamos los gastos
//					// siempre que los gastos no superen el importe
//					IF datos_salida.total_gastos > datos_salida.importe_salida THEN						
//						error_num = 6
//					ELSE
//						todo = true
//						importe_banco = datos_salida.importe_salida - datos_salida.total_gastos
//						gastos_rem = datos_salida.total_gastos
//					END IF
//				ELSE
//					// ya descontados los gastos
//					todo = false
//					importe_banco = datos_salida.importe_salida 
//					gastos_rem = datos_salida.total_gastos
//				END IF
//				
//				
//				// La suma de importe remesa y gastos ha de ser el total remesa
//				suma_comprob = importe_banco + gastos_rem
//				
//				IF suma_comprob <> dec(total_remesa) THEN
//					error_num = 5										
//				END IF
//				// Cambiamos la situación de la remesa en CarRemesas.
//				// AhORa es remesa confirmada con gastos
//				// El tipo de la remesa es riesgo.
//				// Escribimos el total de gastos en "CARREMESAS"
//				
//				anyo_int = integer(em_anyo.text)
//				rem_int = integer (em_remesa.text )
//				
//				UPDATE carremesas  
//				SET situacion = "3",tiporem = :em_tipo_remesa.text,totgastos = :gastos_rem  
//				WHERE	(carremesas.empresa 		= :codigo_empresa) AND
//						(carremesas.banco			= :el_banco) AND
//						(carremesas.anyo 			= :anyo_int ) AND
//						(carremesas.naci_extra 	= "N") AND
//						(carremesas.remesa 		= :rem_int);
//				
//				
//				//**********************************************************		
//				//Apuntes contables
//				//**********************************************************
//				
//				
//				//*******************************************************
//				// 1. Apuntes al banco
//				// Hacemos un apunte pOR el importe y otro pOR los gastos
//				//********************************************************
//				
//				// Apunte por importe de la remesa
//				apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
//				apu.concepto	= f_concepto_contagene(codigo_empresa,"13")	
//				apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"13")+ " " + EM_REMESA.TEXT
//				apu.origen		= f_diario_contagene(codigo_empresa,"13")
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= DateTime(date(fremesa))
//				
//				IF f_dh_contagene(codigo_empresa,"13")= "D" THEN
//					IF todo THEN
//						apu.debe		=	dec(total_remesa)
//						apu.haber	=	0
//					ELSE
//						apu.debe		=	importe_banco
//						apu.haber	=	0
//					END IF 
//				ELSE
//					IF todo THEN
//						apu.debe		=	0
//						apu.haber	=	dec(total_remesa)
//					ELSE
//						apu.debe 	=	0
//						apu.haber	=	importe_banco
//					END IF
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 7
//				END IF
//				// Apunte a banco pOR los gastos. sólo si hay gastos y si se
//				// introdujo el total del importe sin descontar los gastos
//				IF gastos_rem > 0 THEN
//					IF todo THEN
//						apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
//						apu.concepto	=	f_concepto_contagene(codigo_empresa,"14")	
//						apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"14")+ " "+ EM_REMESA.TEXT
//						apu.origen		=	f_diario_contagene(codigo_empresa,"14")	
//						
//						IF f_dh_contagene(codigo_empresa,"14")= "D" THEN
//							apu.debe		=	gastos_rem
//							apu.haber	=	0
//						ELSE
//							apu.debe		=	0
//							apu.haber	=	gastos_rem
//						END IF	
//						
//						num_apunte		=	num_apunte +1
//						apu.apunte		=	num_apunte	
//						apu.orden_apunte=	num_apunte
//						res = f_insert_contaapun(apu) 
//						IF res = false THEN
//							error_num = 8
//						END IF
//					
//					END IF
//					
//					//******************************************************
//					// 2. Apunte a las cuentas de gastos. Obtenidas en ventana
//					//    auxiliar
//					//********************************************************
//				
//				
//					// Apunte a la cuenta de intereses
//					IF datos_salida.intereses > 0 THEN
//						apu.cuenta 		=	datos_salida.cta_intereses
//						apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
//						apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ " Nº "+ EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//						apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
//						
//						IF f_dh_contagene(codigo_empresa,"19")= "D" THEN
//							apu.debe		=	datos_salida.intereses
//							apu.haber	=	0
//						ELSE
//							apu.debe		=	0
//							apu.haber	=	datos_salida.intereses
//						END IF	
//						
//						num_apunte		=	num_apunte +1
//						apu.apunte		=	num_apunte	
//						apu.orden_apunte	=	num_apunte
//						res = f_insert_contaapun(apu) 
//						IF res = false THEN
//							error_num = 16
//						END IF
//						// Comprobamos si tiene analitica
//						IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
//							str_costesapu	coste
//							IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
//								coste.coste		  = f_coste_contagene(codigo_empresa,"19")
//								coste.empresa    = codigo_empresa
//								coste.ejercicio  = int(ejer_act)
//								coste.origen     = apu.origen
//								coste.fapunte    = apu.fapunte
//								coste.mes        = apu.mes
//								coste.asiento    = apu.asiento
//								coste.apunte     = apu.apunte
//								coste.debe		  = apu.debe
//								coste.haber		  = apu.haber
//								coste.concepto   = apu.concepto
//								coste.ampliacion = apu.ampliacion
//								coste.cuenta     = apu.cuenta
//								res = f_insert_costesapu(coste)
//								IF res = false THEN
//									error_num = 17
//								END IF
//							END IF
//						END IF
//					END IF
//						
//					// Apunte para el resto de gastos
//					fOR i= 1 to datos_salida.num_gastos
//						
//						// Sólo si hay gasto
//						IF datos_salida.gastos[i] > 0 THEN
//							apu.cuenta 		=	datos_salida.cuentas[i]
//							apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
//							apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ " Nº "+ EM_REMESA.TEXT +" "  + f_nombre_banco_abr(codigo_empresa,el_banco)
//							apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
//							
//							IF f_dh_contagene(codigo_empresa,"19")= "D" THEN
//								apu.debe		=	datos_salida.gastos[i]
//								apu.haber	=	0
//							ELSE
//								apu.debe		=	0
//								apu.haber	=	datos_salida.gastos[i]
//							END IF	
//							
//							num_apunte		=	num_apunte +1
//							apu.apunte		=	num_apunte	
//							apu.orden_apunte	=	num_apunte
//							res = f_insert_contaapun(apu) 
//							IF res = false THEN
//								error_num = 16
//							END IF
//										// Comprobamos si tiene analitica
//							IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
//								IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
//									coste.coste		  = f_coste_contagene(codigo_empresa,"19")
//									coste.empresa    = codigo_empresa
//									coste.ejercicio  = int(ejer_act)
//									coste.origen     = apu.origen
//									coste.fapunte    = apu.fapunte
//									coste.mes        = apu.mes
//									coste.asiento    = apu.asiento
//									coste.apunte     = apu.apunte
//									coste.debe		  = apu.debe
//									coste.haber		  = apu.haber
//									coste.concepto   = apu.concepto
//									coste.ampliacion = apu.ampliacion
//									coste.cuenta     = apu.cuenta
//									res = f_insert_costesapu(coste)
//									IF res = false THEN
//										error_num = 17
//									END IF
//								END IF
//							END IF
//						END IF
//					next
//					
//					
//			
//				END IF
//				
//				//*************************
//				// 3. Apunte a los clientes
//				//*************************
//								
//				// para cada cliente
//				fOR i = 1 to dw_1.rowcount()
//					
//					apu.cuenta 		= 	dw_1.getitemstring(i,"cuenta")	
//					apu.concepto	=	f_concepto_contagene(codigo_empresa,"15")	
//					apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDatetime(i,"fvto")),"dd/mm/yy")
//					apu.documento	=	dw_1.getitemstring(i,"factura")
//					apu.ffactura	=	dw_1.getitemdatetime(i,"ffra")
//					apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
//					
//					IF f_dh_contagene(codigo_empresa,"15")= "D" THEN
//						apu.debe		=	dw_1.getitemnumber(i,"importe")
//						apu.haber	=	0
//					ELSE
//						apu.debe		=	0
//						apu.haber	=	dw_1.getitemnumber(i,"importe")
//					END IF	
//					
//					num_apunte		=	num_apunte +1
//					apu.apunte		=	num_apunte	
//					apu.orden_apunte	=	num_apunte
//					res = f_insert_contaapun(apu) 
//					IF res = false THEN
//						error_num = 9
//						EXIT
//					END IF
//				next
//				
//				//******************************
//				// 4. Apunte al riesgo del banco
//				//******************************
//				
//				// obtenemos la cuenta de riesgo componiENDola
//				// con la que se obtiene de la tabla contagene
//				// y el código del banco
//				
//				string cta_gene
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"16")
//				apu.cuenta		=  f_comp_cta_riesgo(cta_gene,em_banco.text)
//					
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"16")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"16")+ " " + EM_REMESA.TEXT
//				
//				apu.documento 	= Trim(em_remesa.text)
//								
//				apu.ffactura	= fremesa
//				apu.origen		=	f_diario_contagene(codigo_empresa,"16")	
//				
//				IF f_dh_contagene(codigo_empresa,"16")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 10
//				END IF
//				
//				//********************************
//				// 5. Apunte al riesgo de clientes 
//				//********************************
//				//*Pako
//				apu.cuenta 		=	f_cuenta_contagene(codigo_empresa,"17")
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"17")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//				apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
//				
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= fremesa
//				
//				IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 11
//				END IF
//			// no hay registros	
//			ELSE
//				error_num = 2				
//			
//			END IF // condición hay registros
//		END IF // condición de continuar
//
//	//*********************************************************************
//	// Remesa al descuento(riesgo) sin liquidación
//	//**********************************************************************		
//		
//	
//	case 3  	
//		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " + st_4.text + " sin liquidación"  + " ?",question!,yesno!,1)
//		IF continuar = 2 THEN
//			// No continuar
//			RETURN
//		ELSE			
//			// Comprobamos si hay valORes en la remesa antes de hacer update
//			
//			SELECT count(*) INTO :registros FROM carefectos
//			WHERE (carefectos.empresa 		= :codigo_empresa) AND
//					(carefectos.anyo_remesa = :el_anyo) AND
//					(carefectos.banco			= :el_banco) AND
//					(carefectos.remesa 		= :la_remesa) AND
//					(carefectos.nacional 	= 'S') AND
//					(carefectos.situacion 	= "1");
//			
//			IF registros > 0 THEN
//				// Pasamos a situación de riesgo en cartera			
//				
//				UPDATE carefectos  SET situacion = "5"  
//				WHERE (carefectos.empresa = :codigo_empresa) AND
//						(carefectos.anyo_remesa = :el_anyo) AND
//						(carefectos.banco			= :el_banco) AND
//						(carefectos.remesa = :la_remesa) AND
//						(carefectos.nacional = 'S') AND
//						(carefectos.situacion 	= "1");
//				
//				
//				
//				// cambiamos la situación de la remesa en CarRemesas
//				// AhORa es remesa confirmada sin gastos
//								
//				anyo_int = integer(em_anyo.text)
//				rem_int = integer (em_remesa.text )		
//						
//						
//				UPDATE carremesas  
//				SET situacion = "2",tiporem = :em_tipo_remesa.text  
//				WHERE	(carremesas.empresa 		= :codigo_empresa) AND
//						(carremesas.anyo 			= :anyo_int ) AND
//						(carremesas.banco			= :el_banco) AND
//						(carremesas.naci_extra 	= "N") AND
//						(carremesas.remesa 		= :rem_int);
//				
//				
//					
//				//**********************************************************		
//				//Apuntes contables
//				//**********************************************************
//				
//				
//				//*******************
//				// 1. Apunte al banco
//				//*******************
//				apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"13")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"13")+" "+EM_REMESA.TEXT
//				apu.origen		=	f_diario_contagene(codigo_empresa,"13")	
//				apu.documento	= 	Trim(em_remesa.text)
//				apu.ffactura	= 	fremesa
//				
//				IF f_dh_contagene(codigo_empresa,"13")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 12
//				END IF
//				
//				
//				
//				
//				//*************************
//				// 2. Apunte a los clientes
//				//*************************
//								
//				// para cada cliente
//				fOR i = 1 to dw_1.rowcount()
//						
//					apu.cuenta = dw_1.getitemstring(i,"cuenta")	
//					apu.concepto	=	f_concepto_contagene(codigo_empresa,"15")	
//					apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDateTime(i,"fvto")),"dd/mm/yy")
//					apu.documento	=	dw_1.getitemstring(i,"factura")
//					SetNull(apu.ffactura)
//					
//					apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
//					
//					IF f_dh_contagene(codigo_empresa,"15")= "D" THEN
//						apu.debe		=	dw_1.getitemnumber(i,"importe")
//						apu.haber	=	0
//					ELSE
//						apu.debe		=	0
//						apu.haber	=	dw_1.getitemnumber(i,"importe")
//					END IF	
//					
//					num_apunte		=	num_apunte +1
//					apu.apunte		=	num_apunte	
//					apu.orden_apunte	=	num_apunte
//					res = f_insert_contaapun(apu) 
//					IF res = false THEN
//						exit
//	
//						error_num = 13
//					END IF
//					
//				next
//				
//				
//				
//				//******************************
//				// 3. Apunte al riesgo del banco
//				//******************************
//				
//				// obtenemos la cuenta de riesgo componiENDola
//				// con la que se obtiene de la tabla contagene
//				// y el código del banco
//				
//				
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"16")
//				apu.cuenta		=  f_comp_cta_riesgo(cta_gene,em_banco.text)
//				
//				
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"16")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"16")+ " Nº "+ EM_REMESA.TEXT
//				apu.ffactura	= 	DateTime(date(st_fecha.text))
//				SetNull(apu.documento)
//				apu.origen		=	f_diario_contagene(codigo_empresa,"16")	
//				
//				apu.documento	= 	Trim(em_remesa.text)
//				apu.ffactura	= 	fremesa
//				
//				
//				IF f_dh_contagene(codigo_empresa,"16")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 14
//				END IF
//				
//				//********************************
//				// 4. Apunte al riesgo de clientes 
//				//********************************
//				//*Pako
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"17")
//				apu.cuenta 		=	f_comp_cta_riesgo(cta_gene,)
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"17")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//				
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= fremesa
//			
//				apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
//				
//				IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 15
//				END IF
//				
//		
//			// no hay registros			
//			ELSE
//				error_num = 3					
//			END IF		
//						
//		END IF
//
//END choose
//
//
//
//
//
//
////*******************************************************************
//// Comprobación de los errores
////*******************************************************************
//
//IF error_num = 0 THEN
//	f_mensaje("BIEN","La remesa ha sido confirmada")
//	
//	//limpiamos pantalla
//	dw_1.reset()
//	em_remesa.text = ""
//	st_5.visible = false
//	st_fecha.text = ""
//	
//	commit;
//	RETURN
//
//ELSE
//	rollback;
//	choose case error_num
//			
//		case 1
//			f_mensaje("Atención","error al actualizar la situación de la remesa " + &
//						"a la situación GESTIÓN DE COBRO")
//			
//		case 2
//			f_mensaje("ATENCIÓN","error al actualizar la situación de la remesa " + &
//						"a la situación REMESA AL DESCUENTO (CON LIQUIDACIÓN)")
//		case 3
//			f_mensaje("Atención","error al actualizar la situación de la remesa " + &
//						"a la situación REMESA AL DESCUENTO (CON LIQUIDACIÓN)")
//		
//		case 5
//			f_mensaje("ATENCIÓN","Las cantidades introducidas de importe y gastos " +&
//						" no coinciden con el total de la remesa")
//		case 6
//			f_mensaje("ATENCIÓN","Los gastos introducidas superan el importe de la remesa ")
//						
//		
//		case 7
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS,remesa al descuento con liquidación ")
//		
//		case 8
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS (GASTOS),remesa al descuento con liquidación ")
//		
//		case 9
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a CLIENTES,remesa al descuento con liquidación ")
//		
//		case 10
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO BANCOS,remesa al descuento con liquidación ")
//		
//		case 11
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO CLIENTES,remesa al descuento con liquidación ")
//		
//		case 12
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS,remesa al descuento sin liquidación ")
//		
//		case 13
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a CLIENTES,remesa al descuento sin liquidación ")
//		
//		case 14
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO BANCOS,remesa al descuento sin liquidación ")
//		
//		case 15
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO CLIENTES,remesa al descuento sin liquidación ")
//		
//		case 16
//			f_mensaje("ATENCIÓN","error al hacer el apunte contable a la cuenta GASTOS BANCARIOS,remesa al descuento con liquidación ")
//		case 17
//			f_mensaje("ATENCIÓN","error al hacer el apunte de analítica a la cuenta GASTOS BANCARIOS,remesa al descuento con liquidación ")
//		
//	END choose
//	
//END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Confirmación de Remesas"
This.title=istr_parametros.s_titulo_ventana

es_nacional = 'S'
is_naci_extra = 'N'
is_nacional = 'S'
rb_1.checked = false
rb_2.checked = true
st_5.visible = true

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.visible = false

em_anyo.text = string(year(today()))
em_fcontable.text = string(today())
end event

on w_confirmacion_remesas.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.pb_1=create pb_1
this.em_banco=create em_banco
this.st_1=create st_1
this.st_nombre_banco=create st_nombre_banco
this.dw_1=create dw_1
this.st_2=create st_2
this.em_remesa=create em_remesa
this.cb_1=create cb_1
this.em_tipo_remesa=create em_tipo_remesa
this.st_3=create st_3
this.st_4=create st_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_2=create cb_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_5=create st_5
this.st_fecha=create st_fecha
this.dw_2=create dw_2
this.st_6=create st_6
this.em_anyo=create em_anyo
this.gb_4=create gb_4
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.em_fcontable=create em_fcontable
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.em_banco
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_nombre_banco
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_remesa
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.em_tipo_remesa
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.rb_1
this.Control[iCurrent+14]=this.rb_2
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.st_fecha
this.Control[iCurrent+21]=this.dw_2
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.em_anyo
this.Control[iCurrent+24]=this.gb_4
this.Control[iCurrent+25]=this.st_7
this.Control[iCurrent+26]=this.st_8
this.Control[iCurrent+27]=this.st_9
this.Control[iCurrent+28]=this.em_fcontable
this.Control[iCurrent+29]=this.st_10
this.Control[iCurrent+30]=this.st_11
this.Control[iCurrent+31]=this.st_12
end on

on w_confirmacion_remesas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_5)
destroy(this.pb_1)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.st_nombre_banco)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.em_remesa)
destroy(this.cb_1)
destroy(this.em_tipo_remesa)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.st_fecha)
destroy(this.dw_2)
destroy(this.st_6)
destroy(this.em_anyo)
destroy(this.gb_4)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.em_fcontable)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_confirmacion_remesas
integer x = 2610
integer y = 16
integer width = 219
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_confirmacion_remesas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_confirmacion_remesas
integer x = 9
integer y = 4
integer width = 2427
integer height = 88
end type

type gb_5 from groupbox within w_confirmacion_remesas
integer x = 2066
integer y = 1208
integer width = 576
integer height = 172
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Asiento"
end type

type pb_1 from upb_salir within w_confirmacion_remesas
integer x = 2464
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type em_banco from u_em_campo within w_confirmacion_remesas
integer x = 997
integer y = 120
integer width = 293
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

type st_1 from statictext within w_confirmacion_remesas
integer x = 722
integer y = 132
integer width = 274
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
string text = "Banco :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_confirmacion_remesas
integer x = 1303
integer y = 124
integer width = 1527
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_confirmacion_remesas
integer x = 18
integer y = 324
integer width = 2825
integer height = 732
boolean bringtotop = true
string dataobject = "dw_confir_remesas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_confirmacion_remesas
integer x = 709
integer y = 224
integer width = 288
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 12632256
string text = "Remesa "
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if em_anyo.text = "" or em_banco.text = "" then
	f_mensaje("Atención","Debe introducir los datos de Banco y Año")
	
	return
end if

int num_remesas 
// remesas en situaciones 0 (simulación) o 1 (listada)
num_remesas =dw_2.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),is_naci_extra,"2")
if num_remesas > 0 then 
	dw_2.visible = true
else
	f_mensaje("Atención","No hay remesas pendientes para el Año : " + em_anyo.text + & 
				" y el Banco : " +st_nombre_banco.text)
								
	dw_1.reset()
	em_remesa.text = ""
	st_5.visible = false
	st_fecha.text = ""
end if
end event

type em_remesa from u_em_campo within w_confirmacion_remesas
integer x = 1001
integer y = 224
integer width = 293
integer taborder = 20
long backcolor = 16777215
alignment alignment = right!
end type

type cb_1 from commandbutton within w_confirmacion_remesas
integer x = 2464
integer y = 232
integer width = 375
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

event clicked;String	situ,tiporem
Int		elanyo
Dec{0}	laremesa

//dw_2.enabled = FALSE
dw_2.visible = FALSE

f_fecha_remesa()
elanyo   = Dec(em_anyo.text)
laremesa = Dec(em_remesa.text)

SELECT carremesas.situacion,carremesas.tiporem INTO :situ,:tiporem FROM carremesas
WHERE carremesas.empresa 	 = :codigo_empresa
AND   carremesas.anyo	 	 = :elanyo
AND   carremesas.banco	 	 = :em_banco.text
AND   carremesas.naci_extra = :is_naci_extra
AND   carremesas.remesa		 = :laremesa USING SQLCA;

IF situ > '1' THEN
	MessageBox("REMESAS","La remesa ya ha sido confirmada.Si desea introducir gastos vaya a Liquidar",Exclamation!)
	f_activar_campo(em_remesa)
	RETURN
END IF
//messagebox("tipo remesa",tiporem)
em_tipo_remesa.text = tiporem
st_4.text = f_nombre_cartiporem(codigo_empresa,em_tipo_remesa.text)

dw_1.retrieve(codigo_empresa,elanyo,em_banco.text,laremesa,is_nacional)



end event

type em_tipo_remesa from u_em_campo within w_confirmacion_remesas
integer x = 768
integer y = 1128
integer width = 224
integer height = 88
integer taborder = 50
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE TIPO DE REMESA"
ue_datawindow ="dw_ayuda_CARTIPOREM"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_4.text = f_nombre_cartiporem(codigo_empresa,em_tipo_remesa.text)



// Para las remesas a gestión no hay liquidación ni apuntes contables
// Se hacen en la pantalla  "liquidación de remesas"

if em_tipo_remesa.text = "2" then
	
	rb_1.enabled = false
	rb_2.enabled = false
	em_fcontable.enabled = false

else
	
	rb_1.enabled = true
	rb_2.enabled = true	
	em_fcontable.enabled = true
end if
end event

type st_3 from statictext within w_confirmacion_remesas
integer x = 187
integer y = 1132
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo de Remesa :"
boolean focusrectangle = false
end type

type st_4 from statictext within w_confirmacion_remesas
integer x = 160
integer y = 1232
integer width = 974
integer height = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_confirmacion_remesas
integer x = 1243
integer y = 1192
integer width = 174
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
string text = "Sí"
boolean lefttext = true
end type

type rb_2 from radiobutton within w_confirmacion_remesas
integer x = 1243
integer y = 1268
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
string text = "No"
boolean lefttext = true
end type

type cb_2 from commandbutton within w_confirmacion_remesas
integer x = 2194
integer y = 1080
integer width = 352
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "&Procesar"
end type

event clicked;string var_cliente
string cta_gene,cta_cliente
//******************************************************************
// CONTROLES DE DATOS 
//******************************************************************
// Control de los campos introducidos

IF em_tipo_remesa.text = "" OR em_anyo.text ="" OR em_remesa.text = "" THEN
	
	messagebox("Atención","Debe introducir los datos de :  Banco, Remesa, Año y Tipo de remesa ")
	RETURN
END IF

// Control de la dw : debe haberse consultado

IF dw_1.rowcount() <= 0 THEN
	messagebox("Atención","No existe remesa, no se ha hecho la consulta o la remesa ya ha sido cnfirmada",Exclamation!)
	RETURN
END IF

//*********************************************************************
// Ejercicio
//*********************************************************************

dec{2} ejer_act
datetime f_contable
String mes
Int bloqueo

f_contable =	datetime(date(em_fcontable.text))
ejer_act = year(date(em_fcontable.text))

CHOOSE CASE month(date(em_fcontable.text))
	CASE 1 
		SELECT enero INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 2
		SELECT febrero INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 3
		SELECT marzo INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 4
		SELECT abril INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 5
		SELECT mayo INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 6
		SELECT junio INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 7
		SELECT julio INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 8
		SELECT agosto INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 9
		SELECT septiembre INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 10
		SELECT octubre INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 11
		SELECT noviembre INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
	CASE 12
		SELECT diciembre INTO :bloqueo FROM contabloq WHERE empresa = :codigo_empresa AND ejercicio = :ejer_act;
END CHOOSE

if bloqueo <> 1 then
	messagebox("Atención","No se puede confirmar la remesa en un mes cerrado.",Exclamation!)
	RETURN
end if

// ********************************************************************
// OBTENEMOS TOTAL REMESA
// ********************************************************************
dec total_remesa

total_remesa = dw_1.getitemnumber(1,"total")

//*********************************************************************
// EN LA VARIABLE INSTANCIA inst_tipodoc EL TIPO DE DOCUMENTO
// *********************************************************************
int anyo_int,rem_int
DateTime	fremesa

anyo_int = integer(em_anyo.text)
rem_int = integer (em_remesa.text )		

SELECT carremesas.tipodoc,carremesas.fremesa INTO :inst_tipodoc,:fremesa
FROM carremesas 
WHERE carremesas.empresa = :codigo_empresa
AND	carremesas.anyo = :anyo_int
AND	carremesas.banco = :em_banco.text
AND	carremesas.naci_extra = :is_naci_extra
AND	carremesas.remesa = :rem_int USING SQLCA;


//**********************************************************************
//	CODIFICACIÓN POSIBILIDADES CONFIRMACIÓN DE REMESA
//**********************************************************************

/*	Caso 1 : remesa a gestión de cobro
	Caso 2 : remesa a riesgo y con liquidación
	Caso 3 : remesa a riesgo y sin liquidación
*/


int caso,continuar

IF em_tipo_remesa.text = "2" THEN
	caso = 1	
ELSE
	IF rb_1.checked = TRUE THEN caso = 2
	IF rb_2.checked = TRUE THEN caso = 3	
END IF


//**********************************************************************
// ESTRUCTURA PARA EL ASIENTO
//**********************************************************************

Str_contaapun apu  

dec{2} el_anyo,la_remesa,el_saldo,total_saldo
string la_cuenta,el_banco
int error_num, num_apunte,i
boolean res 		

el_anyo = dec(em_anyo.text)
la_remesa = dec(em_remesa.text)
el_banco 	= Trim(em_banco.text)


// Datos comunes a todos los apuntes

num_apunte		=	0	// inicialmente 0, se incrementa con cada apunte
apu.ejercicio 	=	int(ejer_act)
apu.empresa 	=	codigo_empresa
apu.origen		=	f_diario_contagene(codigo_empresa,"13")	
apu.asiento		=	f_ultimo_asiento(ejer_act,codigo_empresa,month(date(f_contable)),apu.origen)
apu.fapunte		=	f_contable
	
setnull(apu.diario)
Setnull(apu.tipoapu)
setnull(apu.documento)
setnull(apu.factura)
setnull(apu.ffactura)
setnull(apu.imponible)
setnull(apu.tipoiva)
setnull(apu.iva)
setnull(apu.divisas)
setnull(apu.deducible)
setnull(apu.actualizado)
setnull(apu.listado)
setnull(apu.registro)

setnull(apu.tipoter)
setnull(apu.clipro)
setnull(apu.conciliado)
setnull(apu.nif)
setnull(apu.punteado)
// la fvalOR es la fapunte
apu.fvalOR	= apu.fapunte
setnull(apu.docpunteo)
setnull(apu.coste)
setnull(apu.fregistro)

apu.cambio	=	1
apu.moneda	=	f_moneda_empresa(codigo_empresa)
apu.mes		=	month(date(f_contable))



//*********************************************************************+
//		CONFIRMACIÓN REMESAS
//**********************************************************************

// no hay error 
error_num = 0


choose case caso
	
	
	//*********************************************************************
	// Remesa a gestión de cobros
	//**********************************************************************
	case 1
		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " + st_4.text  +" ?" ,question!,yesno!,1)
		IF continuar = 2 THEN
			// No continuar
			RETURN
		ELSE
			// Actualización del efecto en carpagos a la nueva situación 6, gestión de cobro
			// Comprobamos si hay valORes
			int registros
			SELECT count(*) INTO :registros FROM carefectos
			WHERE carefectos.empresa 		= :codigo_empresa
			AND	carefectos.banco			= :el_banco
			AND	carefectos.anyo_remesa 	= :el_anyo
			AND	carefectos.remesa 		= :la_remesa
			AND	carefectos.nacional 		= :is_nacional
			AND	carefectos.situacion 	= "1";
			
			IF registros > 0 THEN
				UPDATE carefectos  SET situacion = "6"  
				WHERE carefectos.empresa 		= :codigo_empresa
				AND	carefectos.banco			= :el_banco
				AND	carefectos.anyo_remesa = :el_anyo
				AND	carefectos.remesa 		= :la_remesa
				AND	carefectos.nacional 	= :is_nacional
				AND	carefectos.situacion 	= "1";
						
			// Cambiamos la situación de la remesa en CarRemesas
			// Ahora es remesa confirmada sin gastos 
			// El tipo de la remesa es "G" (Gestión de Cobro)
			
			UPDATE carremesas  SET situacion = "2",tiporem = :em_tipo_remesa.text
			WHERE	carremesas.empresa 		= :codigo_empresa
			AND	carremesas.anyo 			= :anyo_int
			AND	carremesas.banco 			= :el_banco
			AND	carremesas.naci_extra 	= :is_naci_extra
			AND	carremesas.remesa 		= :rem_int;
			
			
			//Lo quitamos el 30-01-2017 Paco Marin
//			//**********************************************************		
//			//Apuntes contables
//			//**********************************************************				
//			
//			//*************************
//			// 1. Apunte a los clientes
//			//*************************
//							
//			// para cada cliente
//			fOR i = 1 to dw_1.rowcount()
//
//				cta_cliente    =  dw_1.getitemstring(i,"cuenta")
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"17")
//				//Lo quitamos el 30-01-2017 Paco Marin
//				// Santiago - 9/8/2000
//				// Cambio de la cuenta del cliente por la de Efectos
//				// Comerciales en Cartera (4310)
//				//f_venclientes_cuenta_ecc(codigo_empresa,dw_1.getitemstring(i,"cliente"))
//				//Lo quitamos el 30-01-2017 Paco Marin
//				apu.cuenta 		=	f_cuenta_genter(codigo_empresa,"C",dw_1.getitemstring(i,"cliente"))
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
//				apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDateTime(i,"fvto")),"dd/mm/yy")
//				apu.documento	=	dw_1.getitemstring(i,"factura")
//				SetNull(apu.ffactura)
//				
//				apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
//				
//				IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
//					apu.debe		=	dw_1.getitemnumber(i,"importe")
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dw_1.getitemnumber(i,"importe")
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					exit
//	
//					error_num = 13
//				END IF
//				
//				//********************************
//				// 4. Apunte al riesgo de clientes 
//				//********************************
//				//*Pako
//				// Santiago - 9/8/2000
//				// Cambio de la cuenta del cliente por la de Efectos
//				// Comerciales Descontados (4312)
//				// cta_cliente    =  dw_1.getitemstring(i,"cuenta")
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"56")
//				apu.cuenta 		=	f_venclientes_cuenta_ecgc(codigo_empresa,dw_1.getitemstring(i,"cliente"))//f_comp_cta_riesgo_431x(cta_gene,cta_cliente)
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"56")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"56")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//				
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= fremesa
//			
//				apu.origen		=	f_diario_contagene(codigo_empresa,"56")	
//				
//				IF f_dh_contagene(codigo_empresa,"56")= "D" THEN
//					apu.debe		=	dw_1.getitemnumber(i,"importe")
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dw_1.getitemnumber(i,"importe")
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 15
//				END IF
//										
//			next	
//	
//      	//**********************************************************		
//			//Fin Apuntes contables
//			//**********************************************************
			//Lo quitamos el 30-01-2017 Paco Marin
			
			ELSE
				error_num = 1					
			END IF
		END IF
		
	//*********************************************************************
	// Remesa al descuento(riesgo) con liquidación
	//**********************************************************************	
		
	case 2  
		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " +  st_4.text + " con liquidación" + " ?", question!,yesno!,1)
		IF continuar = 2 THEN
			// No continuar
			RETURN
		ELSE
			// Comprobamos si hay valORes en la remesa antes de hacer update
			
			SELECT count(*) INTO :registros FROM carefectos
			WHERE carefectos.empresa 		= :codigo_empresa
			AND	carefectos.banco			= :el_banco
			AND	carefectos.anyo_remesa 	= :el_anyo
			AND	carefectos.remesa 		= :la_remesa
			AND	carefectos.nacional 		= :is_nacional
			AND	carefectos.situacion 	= "1";
			
			IF registros > 0 THEN
				// Pasamos a situación de riesgo en cartera			
				UPDATE carefectos  SET situacion = "5"  
				WHERE carefectos.empresa 		= :codigo_empresa
				AND	carefectos.banco			= :el_banco
				AND	carefectos.anyo_remesa 	= :el_anyo
				AND	carefectos.remesa 		= :la_remesa
				AND	carefectos.nacional 		= :is_nacional
				AND	carefectos.situacion 	= "1";
				//*******************************************************
				// Liquidación
				//*******************************************************
				//Pedimos los datos de gastos en otra pantalla
								
				// Estructura para el pase de parámetros
				str_imput_gastos datos,datos_salida
				
				datos.banco 		= em_banco.text
				datos.anyo 			= integer(em_anyo.text)
				datos.remesa 		= integer(em_remesa.text)
				datos.naci_extra 	= is_naci_extra
				datos.tipodoc 		= inst_tipodoc
				
				// Visible el apunte al banco
				datos.visible_importe = true
				// Sí se hace cálculo de intereses
				datos.calcula_intereses = true
				
				
				// Pasamos los efectos de la remesa a la estructura datos
				int k
				
				datos.num_efectos = dw_1.rowcount() 
				fOR k = 1 to datos.num_efectos
					datos.efectos_orden[k] 	 = dw_1.getitemnumber(k,"orden") 
					datos.efectos_fvto[k] 	 = dw_1.getitemdatetime(k,"fvto")
					datos.efectos_importe[k] = dw_1.getitemnumber(k,"importe")
				next
				
				// Pantalla para obtener los gastos			
				openwithparm(w_input_gastos,datos)
				
				datos_salida = Message.powerobjectparm 
				
				IF datos_salida.correcto = false THEN 
					messagebox("Atención","No se ha confirmado la remesa")
					rollback;
					RETURN
				END IF
											
				
				dec importe_banco,gastos_rem,suma_comprob
				boolean todo
				// el usuario puede introducir en importe remesa el total
				// de la remesa o el total descontANDo los gastos,
				// lo comprobamos aquí
				IF total_remesa = datos_salida.importe_salida THEN
					// si ha puesto el total descontamos los gastos
					// siempre que los gastos no superen el importe
					IF datos_salida.total_gastos > datos_salida.importe_salida THEN						
						error_num = 6
					ELSE
						todo = true
						importe_banco = datos_salida.importe_salida - datos_salida.total_gastos
						gastos_rem = datos_salida.total_gastos
					END IF
				ELSE
					// ya descontados los gastos
					todo = false
					importe_banco = datos_salida.importe_salida 
					gastos_rem = datos_salida.total_gastos
				END IF
				
				
				// La suma de importe remesa y gastos ha de ser el total remesa
				suma_comprob = importe_banco + gastos_rem
				
				IF suma_comprob <> total_remesa THEN
					error_num = 5										
				END IF
				// Cambiamos la situación de la remesa en CarRemesas.
				// AhORa es remesa confirmada con gastos
				// El tipo de la remesa es riesgo.
				// Escribimos el total de gastos en "CARREMESAS"
				
				anyo_int = integer(em_anyo.text)
				rem_int = integer (em_remesa.text )
				
				UPDATE carremesas  
				SET situacion = "3",tiporem = :em_tipo_remesa.text,totgastos = :gastos_rem  
				WHERE	(carremesas.empresa 		= :codigo_empresa) AND
						(carremesas.banco			= :el_banco) AND
						(carremesas.anyo 			= :anyo_int ) AND
						(carremesas.naci_extra 	= :is_naci_extra) AND
						(carremesas.remesa 		= :rem_int);
				
				
				//**********************************************************		
				//Apuntes contables
				//**********************************************************
				
				
				//*******************************************************
				// 1. Apuntes al banco
				// Hacemos un apunte pOR el importe y otro pOR los gastos
				//********************************************************
				
				// Apunte por importe de la remesa
				apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
				apu.concepto	= f_concepto_contagene(codigo_empresa,"13")	
				apu.ampliacion	= "Rem "+em_remesa.text+ " / " + String(Date(fremesa),"dd/mm/yy")
										
				apu.origen		= f_diario_contagene(codigo_empresa,"13")
				apu.documento 	= Trim(em_remesa.text)
				apu.ffactura	= DateTime(date(fremesa))
				
				IF f_dh_contagene(codigo_empresa,"13")= "D" THEN
					IF todo THEN
						apu.debe		=	total_remesa
						apu.haber	=	0
					ELSE
						apu.debe		=	importe_banco
						apu.haber	=	0
					END IF 
				ELSE
					IF todo THEN
						apu.debe		=	0
						apu.haber	=	total_remesa
					ELSE
						apu.debe 	=	0
						apu.haber	=	importe_banco
					END IF
				END IF	
				
				apu.clipro = dw_1.getitemstring(i,"cliente")
				apu.tipoter = 'C'
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 7
				END IF
				// Apunte a banco pOR los gastos. sólo si hay gastos y si se
				// introdujo el total del importe sin descontar los gastos
				IF gastos_rem > 0 THEN
					IF todo THEN
						apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
						apu.concepto	=	f_concepto_contagene(codigo_empresa,"14")	
						apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"14")+ " "+ EM_REMESA.TEXT
						apu.origen		=	f_diario_contagene(codigo_empresa,"14")	
						
						IF f_dh_contagene(codigo_empresa,"14")= "D" THEN
							apu.debe		=	gastos_rem
							apu.haber	=	0
						ELSE
							apu.debe		=	0
							apu.haber	=	gastos_rem
						END IF	
						
						apu.clipro = dw_1.getitemstring(i,"cliente")
						apu.tipoter = 'C'
						
						num_apunte		=	num_apunte +1
						apu.apunte		=	num_apunte	
						apu.orden_apunte=	num_apunte
						res = f_insert_contaapun(apu) 
						IF res = false THEN
							error_num = 8
						END IF
					
					END IF
					
					//******************************************************
					// 2. Apunte a las cuentas de gastos. Obtenidas en ventana
					//    auxiliar
					//********************************************************
				
				
					// Apunte a la cuenta de intereses
					IF datos_salida.intereses > 0 THEN
						apu.cuenta 		=	datos_salida.cta_intereses
						apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
						apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ " Nº "+ EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
						apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
						
						IF f_dh_contagene(codigo_empresa,"19")= "D" THEN
							apu.debe		=	datos_salida.intereses
							apu.haber	=	0
						ELSE
							apu.debe		=	0
							apu.haber	=	datos_salida.intereses
						END IF	
						
						apu.clipro = dw_1.getitemstring(i,"cliente")
						apu.tipoter = 'C'
						
						num_apunte		=	num_apunte +1
						apu.apunte		=	num_apunte	
						apu.orden_apunte	=	num_apunte
						res = f_insert_contaapun(apu) 
						IF res = false THEN
							error_num = 16
						END IF
						// Comprobamos si tiene analitica
						IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
							str_costesapu	coste
							IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
								coste.coste		  = f_coste_contagene(codigo_empresa,"19")
								coste.empresa    = codigo_empresa
								coste.ejercicio  = int(ejer_act)
								coste.origen     = apu.origen
								coste.fapunte    = apu.fapunte
								coste.mes        = apu.mes
								coste.asiento    = apu.asiento
								coste.apunte     = apu.apunte
								coste.debe		  = apu.debe
								coste.haber		  = apu.haber
								coste.concepto   = apu.concepto
								coste.ampliacion = apu.ampliacion
								coste.cuenta     = apu.cuenta
								res = f_insert_costesapu(coste)
								IF res = false THEN
									error_num = 17
								END IF
							END IF
						END IF
					END IF
						
					// Apunte para el resto de gastos
					fOR i= 1 to datos_salida.num_gastos
						
						// Sólo si hay gasto
						IF datos_salida.gastos[i] > 0 THEN
							apu.cuenta 		=	datos_salida.cuentas[i]
							apu.concepto	=	f_concepto_contagene(codigo_empresa,"19")	
							apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"19")+ " Nº "+ EM_REMESA.TEXT +" "  + f_nombre_banco_abr(codigo_empresa,el_banco)
							apu.origen		=	f_diario_contagene(codigo_empresa,"19")	
							
							IF f_dh_contagene(codigo_empresa,"19")= "D" THEN
								apu.debe		=	datos_salida.gastos[i]
								apu.haber	=	0
							ELSE
								apu.debe		=	0
								apu.haber	=	datos_salida.gastos[i]
							END IF	
							
							apu.clipro = dw_1.getitemstring(i,"cliente")
							apu.tipoter = 'C'
							
							num_apunte		=	num_apunte +1
							apu.apunte		=	num_apunte	
							apu.orden_apunte	=	num_apunte
							res = f_insert_contaapun(apu) 
							IF res = false THEN
								error_num = 16
							END IF
										// Comprobamos si tiene analitica
							IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
								IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
									coste.coste		  = f_coste_contagene(codigo_empresa,"19")
									coste.empresa    = codigo_empresa
									coste.ejercicio  = int(ejer_act)
									coste.origen     = apu.origen
									coste.fapunte    = apu.fapunte
									coste.mes        = apu.mes
									coste.asiento    = apu.asiento
									coste.apunte     = apu.apunte
									coste.debe		  = apu.debe
									coste.haber		  = apu.haber
									coste.concepto   = apu.concepto
									coste.ampliacion = apu.ampliacion
									coste.cuenta     = apu.cuenta
									res = f_insert_costesapu(coste)
									IF res = false THEN
										error_num = 17
									END IF
								END IF
							END IF
						END IF
					next
					
					
			
				END IF
				
				//*************************
				// 3. Apunte a los clientes
				//*************************
								
				// para cada cliente
				fOR i = 1 to dw_1.rowcount()
					//Lo quitamos el 30-01-2017 Paco Marin
					// Santiago - 9/8/2000
					// Cambio de la cuenta del cliente por la de Efectos
					// Comerciales en Cartera (4310)
					//f_venclientes_cuenta_ecc(codigo_empresa,dw_1.getitemstring(i,"cliente"))
					//Lo quitamos el 30-01-2017 Paco Marin
					
					cta_cliente    =  dw_1.getitemstring(i,"cuenta")
					cta_gene			=	f_cuenta_contagene(codigo_empresa,"17")
					apu.cuenta 		=	f_cuenta_genter(codigo_empresa,"C",dw_1.getitemstring(i,"cliente"))
					//apu.cuenta 		= 	dw_1.getitemstring(i,"cuenta")	
					apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
					apu.ampliacion	=	"Rem "+em_remesa.text+ " Vto. " + String(Date(dw_1.GetItemDatetime(i,"fvto")),"dd/mm/yy")+&
											" "+f_nombre_banco_abr(codigo_empresa,em_banco.text)
					apu.documento	=	dw_1.getitemstring(i,"factura")
					apu.ffactura	=	dw_1.getitemdatetime(i,"ffra")
					apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
					
					IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
						apu.debe		=	dw_1.getitemnumber(i,"importe")
						apu.haber	=	0
					ELSE
						apu.debe		=	0
						apu.haber	=	dw_1.getitemnumber(i,"importe")
					END IF
					
					apu.clipro = dw_1.getitemstring(i,"cliente")
					apu.tipoter = 'C'
					
					num_apunte		=	num_apunte +1
					apu.apunte		=	num_apunte	
					apu.orden_apunte	=	num_apunte
					res = f_insert_contaapun(apu) 
					IF res = false THEN
						error_num = 9
						EXIT
					END IF
					//********************************
					// 5. Apunte al riesgo de clientes 
					//********************************
					//*Pako
					// Santiago - 9/8/2000
					// Cambio de la cuenta del cliente por la de Efectos
					// Comerciales Descontados (4311)
					//var_cliente    =  dw_1.getitemstring(i,"cliente")
					//cta_cliente    =  f_cuenta_clientes(codigo_empresa,"cuenta")
					cta_gene			=	f_cuenta_contagene(codigo_empresa,"15")
					apu.cuenta 		=	f_venclientes_cuenta_ecd(codigo_empresa,dw_1.getitemstring(i,"cliente"))//f_comp_cta_riesgo_431x(cta_gene,cta_cliente)
					apu.concepto	=	f_concepto_contagene(codigo_empresa,"15")	
					apu.ampliacion	=	"Rem "+em_remesa.text+ " Vto. " + String(Date(dw_1.GetItemDatetime(i,"fvto")),"dd/mm/yy")+&
											" "+f_nombre_banco_abr(codigo_empresa,em_banco.text)
					apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
					
					apu.documento 	= dw_1.getitemstring(i,"factura")
					apu.ffactura	= dw_1.getitemdatetime(i,"ffra")
					
					
				
					IF f_dh_contagene(codigo_empresa,"15")= "D" THEN
						apu.debe		=	dw_1.getitemnumber(i,"importe")
						apu.haber	=	0
					ELSE
						apu.debe		=	0
						apu.haber	=	dw_1.getitemnumber(i,"importe")
					END IF	
					
					apu.clipro = dw_1.getitemstring(i,"cliente")
					apu.tipoter = 'C'
					
					num_apunte		=	num_apunte +1
					apu.apunte		=	num_apunte	
					apu.orden_apunte	=	num_apunte
					res = f_insert_contaapun(apu) 
					IF res = false THEN
						error_num = 11
					END IF
					
				next
				
				//******************************
				// 4. Apunte al riesgo del banco
				//******************************
				
				// obtenemos la cuenta de riesgo componiENDola
				// con la que se obtiene de la tabla contagene
				// y el código del banco
				

//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"16")
//				apu.cuenta		=  f_comp_cta_riesgo(cta_gene,em_banco.text)
				// apunte cuenta riesgo por banco parametrizada por banco
				apu.cuenta		=  f_cta_riesgo_carbancos(codigo_empresa,em_banco.text)
					
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"16")	
				apu.ampliacion	=	"Rem "+em_remesa.text+ " / " + String(Date(fremesa),"dd/mm/yy")

				
				apu.documento 	=  em_remesa.text
				apu.ffactura	=  fremesa
				apu.origen		=	f_diario_contagene(codigo_empresa,"16")	
				
				IF f_dh_contagene(codigo_empresa,"16")= "D" THEN
					apu.debe		=	total_remesa
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	total_remesa
				END IF
				
				apu.clipro = dw_1.getitemstring(i,"cliente")
				apu.tipoter = 'C'
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 10
				END IF
				
//				//********************************
//				// 5. Apunte al riesgo de clientes por el total de remesa
//				//********************************
//				//*Pako
//				apu.cuenta 		=	f_cuenta_contagene(codigo_empresa,"17")
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"17")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//				apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
//				
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= fremesa
//				
//				IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 11
//				END IF
			// no hay registros	
			ELSE
				error_num = 2				
			
			END IF // condición hay registros
		END IF // condición de continuar

	//*********************************************************************
	// Remesa al descuento(riesgo) sin liquidación
	//**********************************************************************		
		
	
	case 3  	
		continuar = messagebox("Atención","¿ Desea confirmar la remesa a " + st_4.text + " sin liquidación"  + " ?",question!,yesno!,1)
		IF continuar = 2 THEN
			// No continuar
			RETURN
		ELSE			
			// Comprobamos si hay valORes en la remesa antes de hacer update
			
			SELECT count(*) INTO :registros FROM carefectos
			WHERE (carefectos.empresa 		= :codigo_empresa) AND
					(carefectos.anyo_remesa = :el_anyo) AND
					(carefectos.banco			= :el_banco) AND
					(carefectos.remesa 		= :la_remesa) AND
					(carefectos.nacional 	= :is_nacional) AND
					(carefectos.situacion 	= "1");
			
			IF registros > 0 THEN
				// Pasamos a situación de riesgo en cartera			
				
				UPDATE carefectos  SET situacion = "5"  
				WHERE (carefectos.empresa = :codigo_empresa) AND
						(carefectos.anyo_remesa = :el_anyo) AND
						(carefectos.banco			= :el_banco) AND
						(carefectos.remesa = :la_remesa) AND
						(carefectos.nacional = :is_nacional) AND
						(carefectos.situacion 	= "1");
				
				
				
				// cambiamos la situación de la remesa en CarRemesas
				// AhORa es remesa confirmada sin gastos
								
				anyo_int = integer(em_anyo.text)
				rem_int = integer (em_remesa.text )		
						
						
				UPDATE carremesas  
				SET situacion = "2",tiporem = :em_tipo_remesa.text  
				WHERE	(carremesas.empresa 		= :codigo_empresa) AND
						(carremesas.anyo 			= :anyo_int ) AND
						(carremesas.banco			= :el_banco) AND
						(carremesas.naci_extra 	= :is_naci_extra) AND
						(carremesas.remesa 		= :rem_int);
				
				
					
				//**********************************************************		
				//Apuntes contables
				//**********************************************************
				
				
				//*******************
				// 1. Apunte al banco
				//*******************
				apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"13")	
				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"13")+" "+EM_REMESA.TEXT
				apu.origen		=	f_diario_contagene(codigo_empresa,"13")	
				apu.documento	= 	Trim(em_remesa.text)
				apu.ffactura	= 	fremesa
				
				IF f_dh_contagene(codigo_empresa,"13")= "D" THEN
					apu.debe		=	total_remesa
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	total_remesa
				END IF	
				
				apu.clipro = dw_1.getitemstring(i,"cliente")
				apu.tipoter = 'C'
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 12
				END IF
				
				
				
				
				//*************************
				// 2. Apunte a los clientes
				//*************************
								
				// para cada cliente
				fOR i = 1 to dw_1.rowcount()
					// Santiago - 9/8/2000
					// Cambio de la cuenta del cliente por la de Efectos
					// Comerciales en Cartera (4310)
					cta_cliente    =  dw_1.getitemstring(i,"cuenta")	
					cta_gene			=	f_cuenta_contagene(codigo_empresa,"17")
					apu.cuenta 		=	f_cuenta_genter(codigo_empresa,"C",dw_1.getitemstring(i,"cliente"))//f_venclientes_cuenta_ecc(codigo_empresa,dw_1.getitemstring(i,"cliente"))//f_comp_cta_riesgo_431x(cta_gene,cta_cliente)
					apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
					apu.ampliacion	=	f_nombre_cartipodoc(codigo_empresa,dw_1.GetItemString(i,"tipodoc")) + " Vto. " + String(Date(dw_1.GetItemDateTime(i,"fvto")),"dd/mm/yy")
					apu.documento	=	dw_1.getitemstring(i,"factura")
					SetNull(apu.ffactura)
					
					apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
					
					IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
						apu.debe		=	dw_1.getitemnumber(i,"importe")
						apu.haber	=	0
					ELSE
						apu.debe		=	0
						apu.haber	=	dw_1.getitemnumber(i,"importe")
					END IF
					
					apu.clipro = dw_1.getitemstring(i,"cliente")
					apu.tipoter = 'C'
					
					num_apunte		=	num_apunte +1
					apu.apunte		=	num_apunte	
					apu.orden_apunte	=	num_apunte
					res = f_insert_contaapun(apu) 
					IF res = false THEN
						exit
	
						error_num = 13
					END IF
					
					//********************************
					// 4. Apunte al riesgo de clientes 
					//********************************
					//*Pako
					// Santiago - 9/8/2000
					// Cambio de la cuenta del cliente por la de Efectos
					// Comerciales Descontados (4311)
					//cta_cliente    =  dw_1.getitemstring(i,"cuenta")
					cta_gene			=	f_cuenta_contagene(codigo_empresa,"15")
					apu.cuenta 		=	f_venclientes_cuenta_ecd(codigo_empresa,dw_1.getitemstring(i,"cliente"))//f_comp_cta_riesgo_431x(cta_gene,cta_cliente)
					apu.concepto	=	f_concepto_contagene(codigo_empresa,"15")	
					apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"15")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
					
					apu.documento 	= Trim(em_remesa.text)
					apu.ffactura	= fremesa
				
					apu.origen		=	f_diario_contagene(codigo_empresa,"15")	
					
					IF f_dh_contagene(codigo_empresa,"15")= "D" THEN
						apu.debe		=	dw_1.getitemnumber(i,"importe")
						apu.haber	=	0
					ELSE
						apu.debe		=	0
						apu.haber	=	dw_1.getitemnumber(i,"importe")
					END IF
					
					apu.clipro = dw_1.getitemstring(i,"cliente")
					apu.tipoter = 'C'
					
					num_apunte		=	num_apunte +1
					apu.apunte		=	num_apunte	
					apu.orden_apunte	=	num_apunte
					res = f_insert_contaapun(apu) 
					IF res = false THEN
						error_num = 15
					END IF
											
				next
				
				
				
				//******************************
				// 3. Apunte al riesgo del banco
				//******************************
				
				// obtenemos la cuenta de riesgo componiENDola
				// con la que se obtiene de la tabla contagene
				// y el código del banco
				
				
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"16")
//				apu.cuenta		=  f_comp_cta_riesgo(cta_gene,em_banco.text)
				apu.cuenta		=  f_cta_riesgo_carbancos(codigo_empresa,em_banco.text)
				
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"16")	
				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"16")+ " " + EM_REMESA.TEXT
				apu.ffactura	= 	DateTime(date(st_fecha.text))
				SetNull(apu.documento)
				apu.origen		=	f_diario_contagene(codigo_empresa,"16")	
				
				apu.documento	= 	Trim(em_remesa.text)
				apu.ffactura	= 	fremesa
				
				
				IF f_dh_contagene(codigo_empresa,"16")= "D" THEN
					apu.debe		=	total_remesa
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	total_remesa
				END IF
				
				apu.clipro = dw_1.getitemstring(i,"cliente")
				apu.tipoter = 'C'
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 14
				END IF
				
//				//********************************
//				// 4. Apunte al riesgo de clientes por el total de la remesa
//				//********************************
//				//*Pako
//				cta_gene			=	f_cuenta_contagene(codigo_empresa,"17")
//				apu.cuenta 		=	f_comp_cta_riesgo(cta_gene,var_cliente)
//				apu.concepto	=	f_concepto_contagene(codigo_empresa,"17")	
//				apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"17")+ " " + EM_REMESA.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
//				
//				apu.documento 	= Trim(em_remesa.text)
//				apu.ffactura	= fremesa
//			
//				apu.origen		=	f_diario_contagene(codigo_empresa,"17")	
//				
//				IF f_dh_contagene(codigo_empresa,"17")= "D" THEN
//					apu.debe		=	dec(total_remesa)
//					apu.haber	=	0
//				ELSE
//					apu.debe		=	0
//					apu.haber	=	dec(total_remesa)
//				END IF	
//				
//				num_apunte		=	num_apunte +1
//				apu.apunte		=	num_apunte	
//				apu.orden_apunte	=	num_apunte
//				res = f_insert_contaapun(apu) 
//				IF res = false THEN
//					error_num = 15
//				END IF
//				
//		
			// no hay registros			
			ELSE
				error_num = 3					
			END IF		
						
		END IF

END choose






//*******************************************************************
// Comprobación de los errores
//*******************************************************************

IF error_num = 0 THEN
	f_mensaje("BIEN","La remesa ha sido confirmada")
	//limpiamos pantalla
	dw_1.reset()
	em_remesa.text = ""
	st_5.visible = false
	st_fecha.text = ""
	st_10.text = string(apu.asiento,"###,###")
	st_11.text = string(apu.mes,"##")
	commit;
	RETURN
ELSE
	rollback;
	choose case error_num
			
		case 1
			f_mensaje("Atención","error al actualizar la situación de la remesa " + &
						"a la situación GESTIÓN DE COBRO")
			
		case 2
			f_mensaje("ATENCIÓN","error al actualizar la situación de la remesa " + &
						"a la situación REMESA AL DESCUENTO (CON LIQUIDACIÓN)")
		case 3
			f_mensaje("Atención","error al actualizar la situación de la remesa " + &
						"a la situación REMESA AL DESCUENTO (CON LIQUIDACIÓN)")
		
		case 5
			f_mensaje("ATENCIÓN","Las cantidades introducidas de importe y gastos " +&
						" no coinciden con el total de la remesa")
		case 6
			f_mensaje("ATENCIÓN","Los gastos introducidas superan el importe de la remesa ")
						
		
		case 7
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS,remesa al descuento con liquidación ")
		
		case 8
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS (GASTOS),remesa al descuento con liquidación ")
		
		case 9
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a CLIENTES,remesa al descuento con liquidación ")
		
		case 10
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO BANCOS,remesa al descuento con liquidación ")
		
		case 11
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO CLIENTES,remesa al descuento con liquidación ")
		
		case 12
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a BANCOS,remesa al descuento sin liquidación ")
		
		case 13
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a CLIENTES,remesa al descuento sin liquidación ")
		
		case 14
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO BANCOS,remesa al descuento sin liquidación ")
		
		case 15
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a RIESGO CLIENTES,remesa al descuento sin liquidación ")
		
		case 16
			f_mensaje("ATENCIÓN","error al hacer el apunte contable a la cuenta GASTOS BANCARIOS,remesa al descuento con liquidación ")
		case 17
			f_mensaje("ATENCIÓN","error al hacer el apunte de analítica a la cuenta GASTOS BANCARIOS,remesa al descuento con liquidación ")
		
	END choose
	
END IF
end event

type gb_3 from groupbox within w_confirmacion_remesas
integer x = 2039
integer y = 1036
integer width = 626
integer height = 360
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_confirmacion_remesas
integer x = 1179
integer y = 1036
integer width = 398
integer height = 360
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type gb_1 from groupbox within w_confirmacion_remesas
integer x = 133
integer y = 1036
integer width = 1042
integer height = 360
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type st_5 from statictext within w_confirmacion_remesas
integer x = 1317
integer y = 244
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fecha from statictext within w_confirmacion_remesas
integer x = 1559
integer y = 236
integer width = 343
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_confirmacion_remesas
boolean visible = false
integer x = 37
integer y = 328
integer width = 2706
integer height = 608
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ayuda_remesas"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)

CASE "remesa","fremesa","importe","nom_tipodoc","nombre_tipo_remesa"
	em_remesa.text = string(getitemnumber(row,"remesa"))
	st_fecha.text  = string(date(getitemdatetime(row,"fremesa")))
	em_fcontable.text = string(date(getitemdatetime(row,"fremesa")))
	inst_tipodoc   = getitemstring(row,"tipodoc")
	em_tipo_remesa.text = getitemstring(row,"tiporem")
	em_tipo_remesa.TriggerEvent("modificado")
	dw_2.visible = false
	st_10.text = ""
	st_11.text = ""
	if st_fecha.text <> "" then		
		st_5.visible = true		
	end if
	dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_remesa.text),is_nacional)
end choose
end event

type st_6 from statictext within w_confirmacion_remesas
integer x = 18
integer y = 180
integer width = 379
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
string text = "Año remesa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from editmask within w_confirmacion_remesas
integer x = 402
integer y = 176
integer width = 197
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type gb_4 from groupbox within w_confirmacion_remesas
integer x = 1582
integer y = 1036
integer width = 453
integer height = 360
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
end type

type st_7 from statictext within w_confirmacion_remesas
integer x = 1221
integer y = 1100
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Liquidación :"
boolean focusrectangle = false
end type

type st_8 from statictext within w_confirmacion_remesas
integer x = 1637
integer y = 1104
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_confirmacion_remesas
integer x = 1641
integer y = 1172
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Contable :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fcontable from editmask within w_confirmacion_remesas
integer x = 1646
integer y = 1256
integer width = 288
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type st_10 from statictext within w_confirmacion_remesas
integer x = 2373
integer y = 1272
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_11 from statictext within w_confirmacion_remesas
integer x = 2094
integer y = 1272
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_12 from statictext within w_confirmacion_remesas
integer x = 2299
integer y = 1272
integer width = 69
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

