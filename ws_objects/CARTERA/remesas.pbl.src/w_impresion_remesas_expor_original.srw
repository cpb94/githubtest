$PBExportHeader$w_impresion_remesas_expor_original.srw
forward
global type w_impresion_remesas_expor_original from w_int_con_empresa
end type
type pb_1 from upb_salir within w_impresion_remesas_expor_original
end type
type em_banco from u_em_campo within w_impresion_remesas_expor_original
end type
type st_1 from statictext within w_impresion_remesas_expor_original
end type
type st_nombre_banco from statictext within w_impresion_remesas_expor_original
end type
type em_remesa from u_em_campo within w_impresion_remesas_expor_original
end type
type cb_consulta from commandbutton within w_impresion_remesas_expor_original
end type
type st_fecha from statictext within w_impresion_remesas_expor_original
end type
type em_anyorem from u_em_campo within w_impresion_remesas_expor_original
end type
type st_4 from statictext within w_impresion_remesas_expor_original
end type
type st_2 from statictext within w_impresion_remesas_expor_original
end type
type st_3 from statictext within w_impresion_remesas_expor_original
end type
type st_6 from statictext within w_impresion_remesas_expor_original
end type
type st_tipodoc from statictext within w_impresion_remesas_expor_original
end type
type pb_cartas from picturebutton within w_impresion_remesas_expor_original
end type
type st_7 from statictext within w_impresion_remesas_expor_original
end type
type pb_recibos from picturebutton within w_impresion_remesas_expor_original
end type
type dw_remesas from datawindow within w_impresion_remesas_expor_original
end type
type dw_1 from datawindow within w_impresion_remesas_expor_original
end type
type st_5 from statictext within w_impresion_remesas_expor_original
end type
type dw_cartas from datawindow within w_impresion_remesas_expor_original
end type
type dw_recibos from datawindow within w_impresion_remesas_expor_original
end type
type st_11 from statictext within w_impresion_remesas_expor_original
end type
type pb_2 from picturebutton within w_impresion_remesas_expor_original
end type
type st_9 from statictext within w_impresion_remesas_expor_original
end type
type em_directorio from u_em_campo within w_impresion_remesas_expor_original
end type
end forward

global type w_impresion_remesas_expor_original from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 2958
integer height = 2324
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
st_11 st_11
pb_2 pb_2
st_9 st_9
em_directorio em_directorio
end type
global w_impresion_remesas_expor_original w_impresion_remesas_expor_original

type variables
string filtro

integer var_ejercicio
string es_nacional

string tipo_doc
end variables

forward prototypes
public subroutine f_grabo_disquete_19_sepa_xml (str_carremesas cab)
public subroutine f_tratar_texto (ref string arg_texto)
end prototypes

public subroutine f_grabo_disquete_19_sepa_xml (str_carremesas cab);//---------------------------------------------------------------------------------------------------------------------
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
						//if not(f_chequear_iban(linea,ls_iban_correcto)) then
//							if messagebox("IBAN Incorrecto",f_razon_genter(codigo_empresa,'C',ls_cliente)+"~nIncorrecto : "+linea+"~nCorrecto : "+ls_iban_correcto+"~n¿Desea sustituir en IBAN incorrecto por el calculado?",Question!,YesNo!,1) = 1 then
//								linea = ls_iban_correcto
//								messagebox("Sustituido!","Debe modificar la domiciliación del cliente con el IBAN correcto.")
//							end if
						//end if
						
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

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Remesas de Exportación"
This.title=istr_parametros.s_titulo_ventana

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_recibos.SetTransObject(SQLCA)

em_anyorem.text = string(year(today()))

es_nacional = 'N'

pb_cartas.enabled		= false
pb_recibos.enabled 	= false

em_directorio.text = "\\amazonas\USUARIOS\ADMINISTRACION\partunyedo\REMESAS N58-DESDE ABRIL 2014"

end event

on w_impresion_remesas_expor_original.create
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
this.st_11=create st_11
this.pb_2=create pb_2
this.st_9=create st_9
this.em_directorio=create em_directorio
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
this.Control[iCurrent+22]=this.st_11
this.Control[iCurrent+23]=this.pb_2
this.Control[iCurrent+24]=this.st_9
this.Control[iCurrent+25]=this.em_directorio
end on

on w_impresion_remesas_expor_original.destroy
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
destroy(this.st_11)
destroy(this.pb_2)
destroy(this.st_9)
destroy(this.em_directorio)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_impresion_remesas_expor_original
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_impresion_remesas_expor_original
end type

type st_empresa from w_int_con_empresa`st_empresa within w_impresion_remesas_expor_original
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_impresion_remesas_expor_original
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type em_banco from u_em_campo within w_impresion_remesas_expor_original
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

type st_1 from statictext within w_impresion_remesas_expor_original
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

type st_nombre_banco from statictext within w_impresion_remesas_expor_original
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

type em_remesa from u_em_campo within w_impresion_remesas_expor_original
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

type cb_consulta from commandbutton within w_impresion_remesas_expor_original
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
		tipo_doc = '12' or tipo_doc = "14" THEN
		pb_recibos.enabled = TRUE
	END IF
	pb_cartas.enabled 	= TRUE

END IF


end event

type st_fecha from statictext within w_impresion_remesas_expor_original
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

type em_anyorem from u_em_campo within w_impresion_remesas_expor_original
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

type st_4 from statictext within w_impresion_remesas_expor_original
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

type st_2 from statictext within w_impresion_remesas_expor_original
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

type st_3 from statictext within w_impresion_remesas_expor_original
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

type st_6 from statictext within w_impresion_remesas_expor_original
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

type st_tipodoc from statictext within w_impresion_remesas_expor_original
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

type pb_cartas from picturebutton within w_impresion_remesas_expor_original
integer x = 2615
integer y = 648
integer width = 146
integer height = 124
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;String cabecera
cabecera= inputbox("Impresion Remesa","Desea Imprimir cabecera:","N","")
dw_cartas.Reset()
dw_cartas.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text),cabecera)
f_imprimir_datawindow(dw_cartas)

end event

type st_7 from statictext within w_impresion_remesas_expor_original
integer x = 2523
integer y = 936
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

type pb_recibos from picturebutton within w_impresion_remesas_expor_original
integer x = 2615
integer y = 1012
integer width = 146
integer height = 124
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;


CHOOSE CASE tipo_doc 
	CASE '3',"10","11","12" 
		dw_recibos.DataObject = "report_lcr"	
	case "14"
		dw_recibos.DataObject = "report_impresion_remesas_preimp_italia"
	case else
	   dw_recibos.DataObject = "report_lcr"	
END CHOOSE

dw_recibos.SetTransObject(SQLCA)
dw_recibos.Reset()
dw_recibos.Retrieve(codigo_empresa,Dec(em_anyorem.text),em_banco.text,Dec(em_remesa.text))
f_imprimir_datawindow(dw_recibos)

end event

type dw_remesas from datawindow within w_impresion_remesas_expor_original
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
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(Row,"fremesa")),"dd-mm-yy")
	tipo_doc				 = dw_remesas.GetItemString(ROW,"tipodoc")
	tipodoc 				 = dw_remesas.GetItemString(Row,"tipodoc")
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

type dw_1 from datawindow within w_impresion_remesas_expor_original
integer y = 288
integer width = 2491
integer height = 1772
string dataobject = "dw_impresion_remesas_expor"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_5 from statictext within w_impresion_remesas_expor_original
integer x = 2501
integer y = 576
integer width = 379
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Carta Banco"
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_impresion_remesas_expor_original
boolean visible = false
integer x = 5
integer width = 453
integer height = 144
boolean bringtotop = true
string dataobject = "report_simul_remesas_expor"
boolean livescroll = true
end type

type dw_recibos from datawindow within w_impresion_remesas_expor_original
boolean visible = false
integer x = 507
integer width = 393
integer height = 156
boolean bringtotop = true
boolean livescroll = true
end type

type st_11 from statictext within w_impresion_remesas_expor_original
integer x = 2514
integer y = 1828
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
string text = "SEPA XML"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_impresion_remesas_expor_original
integer x = 2601
integer y = 1904
integer width = 174
integer height = 152
integer taborder = 110
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
	AND	carremesas.naci_extra= "E"
	AND	carremesas.remesa		= :reme;
	
	//f_grabo_disquete_19(cab)
	
	f_grabo_disquete_19_sepa_xml(cab)
END IF
end event

type st_9 from statictext within w_impresion_remesas_expor_original
integer x = 1509
integer y = 2080
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

type em_directorio from u_em_campo within w_impresion_remesas_expor_original
integer x = 1838
integer y = 2068
integer width = 1102
integer taborder = 50
boolean bringtotop = true
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

