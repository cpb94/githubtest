$PBExportHeader$wi_mant_act_bajas.srw
forward
global type wi_mant_act_bajas from wi_mvent_con_empresa
end type
type dw_2 from u_datawindow_consultas within wi_mant_act_bajas
end type
type uo_ejercicio from u_ejercicio within wi_mant_act_bajas
end type
type em_elemento from u_em_campo within wi_mant_act_bajas
end type
type st_2 from statictext within wi_mant_act_bajas
end type
type em_importe from u_em_campo within wi_mant_act_bajas
end type
type st_3 from statictext within wi_mant_act_bajas
end type
type em_prov from u_em_campo within wi_mant_act_bajas
end type
type st_4 from statictext within wi_mant_act_bajas
end type
type em_fcompra from u_em_campo within wi_mant_act_bajas
end type
type st_elemento from statictext within wi_mant_act_bajas
end type
type em_bajas from u_em_campo within wi_mant_act_bajas
end type
type st_5 from statictext within wi_mant_act_bajas
end type
type em_acum from u_em_campo within wi_mant_act_bajas
end type
type st_6 from statictext within wi_mant_act_bajas
end type
type em_base from u_em_campo within wi_mant_act_bajas
end type
type st_7 from statictext within wi_mant_act_bajas
end type
type em_hvalor from u_em_campo within wi_mant_act_bajas
end type
type em_hbajas from u_em_campo within wi_mant_act_bajas
end type
type st_9 from statictext within wi_mant_act_bajas
end type
type em_hacum from u_em_campo within wi_mant_act_bajas
end type
type st_10 from statictext within wi_mant_act_bajas
end type
type st_11 from statictext within wi_mant_act_bajas
end type
type em_hbase from u_em_campo within wi_mant_act_bajas
end type
type st_12 from statictext within wi_mant_act_bajas
end type
type st_prov from statictext within wi_mant_act_bajas
end type
type st_8 from statictext within wi_mant_act_bajas
end type
end forward

global type wi_mant_act_bajas from wi_mvent_con_empresa
integer width = 2875
integer height = 1724
boolean titlebar = true
boolean controlmenu = true
boolean maxbox = true
windowtype windowtype = main!
dw_2 dw_2
uo_ejercicio uo_ejercicio
em_elemento em_elemento
st_2 st_2
em_importe em_importe
st_3 st_3
em_prov em_prov
st_4 st_4
em_fcompra em_fcompra
st_elemento st_elemento
em_bajas em_bajas
st_5 st_5
em_acum em_acum
st_6 st_6
em_base em_base
st_7 st_7
em_hvalor em_hvalor
em_hbajas em_hbajas
st_9 st_9
em_hacum em_hacum
st_10 st_10
st_11 st_11
em_hbase em_hbase
st_12 st_12
st_prov st_prov
st_8 st_8
end type
global wi_mant_act_bajas wi_mant_act_bajas

type variables
Integer		orden
DataStore	ds_elemento,ds_a1,ds_a2
end variables

forward prototypes
public subroutine f_proceso ()
end prototypes

public subroutine f_proceso ();
end subroutine

on wi_mant_act_bajas.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.uo_ejercicio=create uo_ejercicio
this.em_elemento=create em_elemento
this.st_2=create st_2
this.em_importe=create em_importe
this.st_3=create st_3
this.em_prov=create em_prov
this.st_4=create st_4
this.em_fcompra=create em_fcompra
this.st_elemento=create st_elemento
this.em_bajas=create em_bajas
this.st_5=create st_5
this.em_acum=create em_acum
this.st_6=create st_6
this.em_base=create em_base
this.st_7=create st_7
this.em_hvalor=create em_hvalor
this.em_hbajas=create em_hbajas
this.st_9=create st_9
this.em_hacum=create em_hacum
this.st_10=create st_10
this.st_11=create st_11
this.em_hbase=create em_hbase
this.st_12=create st_12
this.st_prov=create st_prov
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.em_elemento
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_importe
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_prov
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_fcompra
this.Control[iCurrent+10]=this.st_elemento
this.Control[iCurrent+11]=this.em_bajas
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.em_acum
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.em_base
this.Control[iCurrent+16]=this.st_7
this.Control[iCurrent+17]=this.em_hvalor
this.Control[iCurrent+18]=this.em_hbajas
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.em_hacum
this.Control[iCurrent+21]=this.st_10
this.Control[iCurrent+22]=this.st_11
this.Control[iCurrent+23]=this.em_hbase
this.Control[iCurrent+24]=this.st_12
this.Control[iCurrent+25]=this.st_prov
this.Control[iCurrent+26]=this.st_8
end on

on wi_mant_act_bajas.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.uo_ejercicio)
destroy(this.em_elemento)
destroy(this.st_2)
destroy(this.em_importe)
destroy(this.st_3)
destroy(this.em_prov)
destroy(this.st_4)
destroy(this.em_fcompra)
destroy(this.st_elemento)
destroy(this.em_bajas)
destroy(this.st_5)
destroy(this.em_acum)
destroy(this.st_6)
destroy(this.em_base)
destroy(this.st_7)
destroy(this.em_hvalor)
destroy(this.em_hbajas)
destroy(this.st_9)
destroy(this.em_hacum)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.em_hbase)
destroy(this.st_12)
destroy(this.st_prov)
destroy(this.st_8)
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Baja de Elementos de Amortización" 
	valor_empresa = True
	istr_parametros.s_listado        = "report_act_bajas"
   This.title = istr_parametros.s_titulo_ventana
   

	dw_2.SetTransObject(sqlca)

   // Si recibo el codigo lo visualizo
/*
	IF istr_parametros.i_nargumentos>1 THEN
		elemento = Dec(istr_parametros.s_argumentos[2])
		dw_2.Retrieve(codigo_empresa,elemento)
		f_baja()		
	End IF
	*/
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"elemento",dec(sle_valor.text))
end event

event ue_recuperar;call super::ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_bajas"

dw_1.Retrieve(codigo_empresa,dec(sle_valor.Text),orden)

CALL Super::ue_recuperar
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_bajas
integer x = 50
integer y = 1208
integer width = 2487
integer height = 336
string dataobject = "dwact_bajas"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_bajas
integer x = 9
integer y = 180
integer width = 320
string text = "Elemento"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_bajas
integer x = 2565
integer y = 788
integer width = 261
end type

event cb_insertar::clicked;String var_descripcion,cadena,cuenta,nulo,c1,c2,c3,c4,c5,c6,c7
Integer fila
Dec	valor,calculo,n1,n2,n3,n4
Boolean	editando
DateTime	fecha



fila = dw_1.GetRow() 
editando = False

IF fila <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 editando = True	
		 dw_1.AcceptText()
/*

	//	Validaciones
	
		 var_descripcion  = dw_1.GetItemString(fila,"descripcion")
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			f_mensaje("Aviso","Campo Descripción obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("descripcion")
			Return
		 END IF

		cadena = dw_1.GetItemString(fila,"familia")
		If not (isnull(cadena) or trim(cadena)='') then
			cadena = f_desc_familia(codigo_empresa,cadena)
				If cadena = '' then f_mensaje("Aviso","No existe la familia.")
		Else
			f_mensaje("Aviso","Campo Familia obligatorio.")
		End If
		If isnull(cadena) or trim(cadena)='' then
			dw_1.SetFocus()
			dw_1.SetColumn("familia")			
			Return
		End If
		
		valor = dw_1.GetItemDecimal(fila,"bien")
		If not (isnull(valor)) then
			if f_desc_bien(codigo_empresa,valor)='' then
				f_mensaje("Aviso","No existe el bien.")
				dw_1.SetFocus()
				dw_1.SetColumn("bien")			
				Return
			End If
		End If
		
		cadena = dw_1.GetItemString(fila,"tipo_bien")
		If not (isnull(cadena) or trim(cadena)='') then
			  SELECT act_tipobien.requiere_anyo, act_tipobien.tipo_bien  
				 INTO :c1,:c2  
				 FROM act_tipobien  
				WHERE ( act_tipobien.empresa = :codigo_empresa ) AND  
						( act_tipobien.tipo_bien = :cadena )   ;
				If SQLCA.SQLCode = 0 then
					If not (isnull(c1) or c1<>'S') then
						n1 = dw_1.GetItemdecimal(fila,"anyo_tipo")
						If isnull(n1) then
							f_mensaje("Aviso","El tipo de bien requiere año.")
							dw_1.SetFocus()
							dw_1.SetColumn("anyo_tipo")			
							Return
						end if
					End If 
				End If
		Else
			c3 = dw_1.GetItemString(fila,"clase_inmobilizado")
			If isnull(c3) or trim(c3)='' then
				f_mensaje("Aviso","El tipo de bien y la clase de inmobilizado no pueden ser nulos a la vez.")
				dw_1.SetFocus()
				dw_1.SetColumn("clase_inmobilizado")			
				Return
			end if
		End If

		valor = dw_1.GetItemDecimal(fila,"turnos")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Turnos obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("turnos")			
			Return
		end if
		
		cadena = dw_1.GetItemString(fila,"clase_amor")
		If isnull(cadena) or trim(cadena)='' then
			f_mensaje("Aviso","Campo Clase de Amortización obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("clase_amor")			
			Return
		end if
		
		valor = dw_1.GetItemDecimal(fila,"clase_inmobilizado")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Clase de Inmobilizado obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("clase_inmobilizado")			
			Return			
		Else			
			  SELECT act_clase.por_maxlineal,   
						act_clase.por_minlineal,   
						act_clase.cuenta_cargo,   
						act_clase.cuenta_abono  
				 INTO :n1,   
						:n2,   
						:c1,   
						:c2  
				 FROM act_clase  
				WHERE ( act_clase.empresa = :codigo_empresa ) AND  
						( act_clase.clase = :valor )   ;
				If SQLCA.SQLCode = 0 then										
					n3 = dw_1.GetItemDecimal(fila,"porcentaje_amor")
					if isnull(n3) then 
						dw_1.SetItem(fila,"porcentaje_amor",n1) // n1 <- porcentaje_amor
						If n1<>0 then
							dw_1.SetItem(fila,"anyos_amor",100/n1)
						Else
							dw_1.SetItem(fila,"anyos_amor",0)
						End If
						n3 = dw_1.GetItemDecimal(fila,"turnos")
						If not isnull(n3) and n3<>1 then
							n1 = n2 +((n1 - n2) * n3) // n1 <- porcentaje_amor
							dw_1.SetItem(fila,"porcentaje_amor",n1 ) 
						End If
						c3 = dw_1.GetItemString(fila,"clase_amor")
						If not isnull(c3) then
							If c3='R' then
								n2 = dw_1.GetItemDecimal(fila,"anyos_amor")
								If not isnull(n2) then
									If n2 < 5 then
										n1 = n1 * 3/2
									elseif n2 < 8 then
											n1 = n1 * 2
										 else
											n1 = n1 * 5/2
									end if	
									dw_1.SetItem(fila,"porcentaje_amor",n1 ) 								 
								End IF
							End if
						end IF					
					end if
				Else
					f_mensaje("Aviso","No existe la clase de inmobilizado.")
					dw_1.SetFocus()
					dw_1.SetColumn("clase_inmobilizado")					
					Return
				End If
				n4 = dw_1.GetItemDecimal(fila,"fiscal")
				if isnull(n3) then dw_1.SetItem(fila,"fiscal",n1)
				cuenta = dw_1.GetItemString(fila,"cuenta_cargo")
				If isnull(cuenta) or trim(cuenta)='' then dw_1.SetItem(fila,"cuenta_cargo",c1)
				cuenta = dw_1.GetItemString(fila,"cuenta_abono")
				If isnull(cuenta) or trim(cuenta)='' then dw_1.SetItem(fila,"cuenta_abono",c2)
		End If

		cuenta = dw_1.GetItemString(fila,"ctaproveedor")
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta del proveedor.")
			dw_1.SetFocus()
			dw_1.SetColumn("ctaproveedor")			
			Return
		end if
		
		cadena = dw_1.GetItemString(fila,"factura")
		If isnull(cadena) or trim(cadena) = ''then
			f_mensaje("Aviso","Campo Factura obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("factura")			
			Return
		end if
		
		fecha = dw_1.GetItemDateTime(fila,"fechacompra")
		If isnull(fecha) then
			f_mensaje("Aviso","Campo Fecha Compra obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("fechacompra")			
			Return
		end if
		
		valor = dw_1.GetItemDecimal(fila,"importe")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Importe obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("importe")			
			Return
		end if

		fecha = dw_1.GetItemDateTime(fila,"fechainamor")
		If isnull(fecha) then
			fecha = dw_1.GetItemDateTime(fila,"fechacompra")
			dw_1.SetItem(fila,"fechainamor",fecha)			
		end if

		valor = dw_1.GetItemDecimal(fila,"fiscal")
		If isnull(valor) then
			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")
			dw_1.SetItem(fila,"fiscal",valor)			
			Return
		end if
		
		valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")
		If isnull(valor) or valor = 0 then
			dw_1.SetItem(fila,"anyos_amor",0)			
		Else
			dw_1.SetItem(fila,"anyos_amor",100/valor)			
		End If

		fecha = dw_1.GetItemDateTime(fila,"fechainamor")		
		valor = dw_1.GetItemDecimal(fila,"anyo1amor")
		If isnull(valor) then dw_1.SetItem(fila,"anyo1amor",Year(date(fecha)))
		valor = dw_1.GetItemDecimal(fila,"mes1amor")
		If isnull(valor) then dw_1.SetItem(fila,"mes1amor",Month(date(fecha)))
		
		valor = dw_1.GetItemDecimal(fila,"anyo2amor")
		If isnull(valor) then 
			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
			If valor <>0 then
				n1 = 100 / valor
				n2 = n1 * valor
				If n2<100 then n1 = n1 + 1
				n3 = dw_1.GetItemDecimal(fila,"anyo1amor")				
				dw_1.SetItem(fila,"anyo2amor",n3 + n1)
			End If	
		End If

		valor = dw_1.GetItemDecimal(fila,"mes2amor")
		If isnull(valor) then 
			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
			valor = valor / 12
			If valor <> 0 then
				n1 = 100 / valor
				n2 = n1 * valor
				If n2<100 then n1 = n1 + 1
				n2 = dw_1.GetItemDecimal(fila,"anyo1amor")
				n3 = dw_1.GetItemDecimal(fila,"mes1amor")
				n4 = dw_1.GetItemDecimal(fila,"anyo2amor")
				valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
				If valor < 1 then
					valor = valor + 12
					n4 = n4 - 1 
					dw_1.SetItem(fila,"anyo2amor",n4)
				End If
				dw_1.SetItem(fila,"mes2amor",valor)			
			Else
				dw_1.SetItem(fila,"mes2amor",0)			
			End If
		End If
	
		cuenta = dw_1.GetItemString(fila,"cuenta_activo")
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de activo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_activo")			
			Return
		end if
		
		cuenta = dw_1.GetItemString(fila,"cuenta_cargo")
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de cargo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_cargo")			
			Return
		end if
		
		cuenta = dw_1.GetItemString(fila,"cuenta_abono")
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de abono.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_abono")			
			Return
		end if

		valor = dw_1.GetItemDecimal(fila,"cuota_amor")
		n1 = dw_1.GetItemDecimal(fila,"porcentaje_amor")
		If ((isnull(valor)) or (valor = 0)) and n1<>0 then
			cadena = dw_1.GetItemString(fila,"tipo_amor")
			n3 = dw_1.GetItemDecimal(fila,"importe")
			choose case cadena
				case 'A'
					valor = n3 * n1 /100
				case 'S'
					valor = (n3 * n1 /100)/2
				case 'T'
					valor = (n3 * n1 /100)/4
				case 'M'
					valor = (n3 * n1 /100)/12
			end choose
			dw_1.SetItem(fila,"cuota_amor",valor)						
		End If
*/		
	end if 
END IF



CALL super::Clicked

if not editando THEN //Inicializaciones
/*	dw_1.SetItem(dw_1.GetRow(),"clase_amor",'L')
	dw_1.SetItem(dw_1.GetRow(),"tipo_amor",'A')
	dw_1.SetItem(dw_1.GetRow(),"turnos",1)
	dw_1.SetItem(dw_1.GetRow(),"tipo_bien",'NO')
	SetNull(nulo)
	dw_1.SetItem(dw_1.GetRow(),"anyo_tipo", nulo) */
End If
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_bajas
integer x = 2560
integer y = 908
integer width = 265
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_bajas
integer x = 864
integer y = 276
integer width = 73
integer taborder = 60
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_bajas
integer x = 2565
integer y = 1040
integer width = 261
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_bajas
integer taborder = 70
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_bajas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_bajas
integer width = 2565
end type

type dw_2 from u_datawindow_consultas within wi_mant_act_bajas
integer x = 50
integer y = 716
integer width = 2487
integer height = 472
integer taborder = 0
string dataobject = "dw_con_act_bajas"
borderstyle borderstyle = styleraised!
end type

type uo_ejercicio from u_ejercicio within wi_mant_act_bajas
integer x = 2034
integer y = 172
integer taborder = 80
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type em_elemento from u_em_campo within wi_mant_act_bajas
integer x = 352
integer y = 176
integer width = 489
integer taborder = 10
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
   isle_campo        = This
end event

event modificado;call super::modificado;String 	cadena
DateTime	fecha
Integer	rr
Dec		valor,valor2,elemento

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.SetFocus()
	return
Else
	st_elemento.text = cadena
End If


// el elemento existe
cadena = "SELECT act_bienesdet.* FROM act_bienesdet " +& 
		   "WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
			"( act_bienesdet.elemento = "+ this.text +")"

//ds_elemento = f_cargar_cursor(cadena)  
f_cargar_cursor_nuevo(cadena, ds_elemento)

rr = ds_elemento.RowCount()

If rr<>1 then
	f_mensaje("Error","Se ha producido un error al buscar el elemento.")
	em_elemento.SetFocus()
	return	
End If

fecha = ds_elemento.GetItemDateTime(1,"fechabaja")

If not isnull(fecha) then 
	f_mensaje("Aviso","El elemento ha sido dado de baja.")
	em_elemento.SetFocus()
	return
End If
/*
sle_valor.SetFocus()
sle_valor.text = f_componer_familia()
If sle_valor.text <>'' then sle_valor.TriggerEvent("tecla_tabulador") */

elemento = Dec(em_elemento.text)

  SELECT sum(importe_amor)  
    INTO :valor
    FROM act_amortizaciones  
   WHERE ( act_amortizaciones.empresa = :codigo_empresa ) AND  
         ( act_amortizaciones.elemento = :elemento ) AND  
         ( act_amortizaciones.actualizado = 'S' )   ;

	If isnull(valor) then valor = 0 
	em_acum.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
  SELECT sum(ibajabase),sum(ibajaamor)
    INTO :valor,:valor2
    FROM act_bajas  
   WHERE ( act_bajas.empresa = :codigo_empresa ) AND  
         ( act_bajas.elemento = :elemento ) ;

	If isnull(valor) then valor = 0 
	em_bajas.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	If isnull(valor2) then valor2 = 0 

	em_prov.text = trim(ds_elemento.GetItemString(1,"ctaproveedor"))
	st_prov.text = f_nombre_contaplan(dec(uo_ejercicio.text),codigo_empresa,em_prov.text) 	
	fecha = ds_elemento.GetItemDateTime(1,"fechacompra")
	em_fcompra.text = String(fecha,"dd-mm-yyyy")
	em_importe.text = String(ds_elemento.GetItemDecimal(1,"importe"),f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
	valor = Dec(em_importe.text) - Dec(em_bajas.text) - Dec(em_acum.text) - valor2
	
	em_base.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
	
	dw_2.Retrieve(codigo_empresa,elemento)
	
	cadena = "SELECT act_bienesdet.* FROM act_bienesdet " +& 
				"WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
				"( act_bienesdet.elemento = "+ this.text +")"
	
	//ds_a1 = f_cargar_cursor(cadena)  //ds_a1 es el elemento
	f_cargar_cursor_nuevo(cadena, ds_a1)
	
	cadena = "SELECT act_bienesdet.* FROM act_bienesdet " +& 
				"WHERE ( act_bienesdet.empresa = '" + codigo_empresa + "') AND " +&
				"( act_bienesdet.elemento <> "+ this.text +") AND " +&
				"( act_bienesdet.padre = "+ this.text +")"
	
	//ds_a2 = f_cargar_cursor(cadena)  //ds_a2 es el hijo(si existe)
	f_cargar_cursor_nuevo(cadena, ds_a2)	
	rr = ds_a2.RowCount()
	
	// ** seguir por aquí
	// decidir en qué evento poner este código
	
	If rr>0 then
		elemento = ds_a2.GetItemDecimal(1,"elemento")
			
		  SELECT sum(importe_amor)  
			 INTO :valor
			 FROM act_amortizaciones  
			WHERE ( act_amortizaciones.empresa = :codigo_empresa ) AND  
					( act_amortizaciones.elemento = :elemento ) AND  
					( act_amortizaciones.actualizado = 'S' ) ;
			
			If isnull(valor) then valor = 0 
			em_hacum.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))
			valor = ds_a2.GetItemDecimal(1,"importe")
			em_hvalor.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

		  SELECT sum(ibajabase),sum(ibajaamor)
			 INTO :valor,:valor2
			 FROM act_bajas  
			WHERE ( act_bajas.empresa = :codigo_empresa ) AND  
					( act_bajas.elemento = :elemento ) ;
			If isnull(valor) then valor = 0 
			em_hbajas.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

			valor = Dec(em_hvalor.text) - Dec(em_hbajas.text) - Dec(em_hacum.text) - valor2
			em_hbase.text = String(valor,f_mascara_moneda(f_paramemp_moneda_emp( codigo_empresa )))

	End IF

f_proceso()

destroy ds_elemento
destroy ds_a1
destroy ds_a2
end event

type st_2 from statictext within wi_mant_act_bajas
integer x = 27
integer y = 280
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Importe Compra"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 507
integer y = 276
integer width = 334
integer taborder = 0
boolean bringtotop = true
boolean displayonly = true
end type

type st_3 from statictext within wi_mant_act_bajas
integer x = 23
integer y = 380
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_prov from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 352
integer y = 376
integer width = 480
integer taborder = 0
boolean bringtotop = true
boolean displayonly = true
end type

type st_4 from statictext within wi_mant_act_bajas
integer x = 1824
integer y = 376
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Compra"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fcompra from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2304
integer y = 372
integer width = 325
integer taborder = 0
boolean bringtotop = true
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
string displaydata = ""
end type

type st_elemento from statictext within wi_mant_act_bajas
integer x = 846
integer y = 176
integer width = 1129
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_bajas from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 393
integer y = 476
integer width = 361
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_5 from statictext within wi_mant_act_bajas
integer x = 41
integer y = 480
integer width = 306
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Imp. Bajas"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_acum from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1202
integer y = 480
integer width = 361
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_6 from statictext within wi_mant_act_bajas
integer x = 777
integer y = 480
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Amort. Acum."
alignment alignment = center!
boolean focusrectangle = false
end type

type em_base from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2016
integer y = 488
integer width = 361
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_7 from statictext within wi_mant_act_bajas
integer x = 1595
integer y = 492
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Base Amort."
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hvalor from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 507
integer y = 584
integer width = 361
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type em_hbajas from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1079
integer y = 584
integer width = 361
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_9 from statictext within wi_mant_act_bajas
integer x = 873
integer y = 596
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Bajas"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hacum from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1737
integer y = 584
integer width = 361
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_10 from statictext within wi_mant_act_bajas
integer x = 1454
integer y = 596
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "A. Acum."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within wi_mant_act_bajas
integer x = 2103
integer y = 588
integer width = 366
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Base Amort."
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hbase from u_em_campo within wi_mant_act_bajas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2469
integer y = 584
integer width = 361
integer taborder = 50
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type st_12 from statictext within wi_mant_act_bajas
integer x = 9
integer y = 596
integer width = 160
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hijo: "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prov from statictext within wi_mant_act_bajas
integer x = 841
integer y = 380
integer width = 997
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_8 from statictext within wi_mant_act_bajas
integer x = 151
integer y = 596
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Adquisición"
alignment alignment = center!
boolean focusrectangle = false
end type

