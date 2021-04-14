$PBExportHeader$wi_mant_act_amortizaciones.srw
forward
global type wi_mant_act_amortizaciones from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_act_amortizaciones
end type
type em_elemento from u_em_campo within wi_mant_act_amortizaciones
end type
type st_2 from statictext within wi_mant_act_amortizaciones
end type
type st_elemento from statictext within wi_mant_act_amortizaciones
end type
end forward

global type wi_mant_act_amortizaciones from wi_mvent_con_empresa
integer width = 2871
integer height = 1620
string title = "Mantenimiento de Amortizaciones"
pb_calculadora pb_calculadora
em_elemento em_elemento
st_2 st_2
st_elemento st_elemento
end type
global wi_mant_act_amortizaciones wi_mant_act_amortizaciones

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
Boolean	requiere_anyo
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Amortizaciones" 
	valor_empresa = True
	istr_parametros.s_listado        = "report_act_amortizaciones"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,dec(em_elemento.text),integer(sle_valor.Text))
      END IF
   END IF

	
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
em_elemento.enabled = True
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
em_elemento.enabled = False
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"elemento",dec(em_elemento.text))
dw_1.setitem(dw_1.getrow(),"amortizacion",integer(sle_valor.text))

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_amortizaciones"

dw_1.Retrieve(codigo_empresa,dec(em_elemento.text),integer(sle_valor.Text))

CALL Super::ue_recuperar
end event

on wi_mant_act_amortizaciones.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.em_elemento=create em_elemento
this.st_2=create st_2
this.st_elemento=create st_elemento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.em_elemento
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_elemento
end on

on wi_mant_act_amortizaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.em_elemento)
destroy(this.st_2)
destroy(this.st_elemento)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_amortizaciones
integer x = 23
integer y = 368
integer width = 2821
integer height = 1068
string dataobject = "dwact_amortizaciones"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;Dec	valor,n1,n2,n3,n4,n_ant,ejercicio
String cuenta,cadena,c1,c2,c3,c4,c5,c6,c7,c_ant
DateTime	fecha


choose case dwo.name

	case 'bien'
		cadena = trim(GetItemString(Row,"familia"))
		If not (isnull(cadena) or trim(cadena)='') then
			if f_desc_familia(codigo_empresa,cadena)='' then
				f_mensaje("Aviso","No existe la familia.")
				SetColumn("familia")			
			end if
		End If
		
	case 'tipo_amort'
		valor = GetItemDecimal(row,"bien")
		If not (isnull(valor)) then
			if f_desc_bien(codigo_empresa,valor)='' then
				f_mensaje("Aviso","No existe el bien.")
				SetColumn("bien")			
			End If
		End If
		
		
	case 'ctaproveedor'
		valor = GetItemDecimal(row,"clase_inmobilizado")
		If not isnull(valor) then
			if f_desc_clase(codigo_empresa,valor)='' then
				f_mensaje("Aviso","No existe la clase de inmobilizado.")
				SetColumn("clase_inmobilizado")					
			end if
		End If
		
	case 'cuenta_cargo'	
		cuenta = trim(GetItemString(Row,"cuenta_activo"))
		ejercicio = GetItemDecimal(Row,"ejercicio")
		If isnull(ejercicio) then ejercicio = f_ejercicio_activo(codigo_empresa)
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de activo.")
				SetColumn("cuenta_activo")			
			end if
		End If
		
	case 'cuenta_abono'
		ejercicio = GetItemDecimal(Row,"ejercicio")
		If isnull(ejercicio) then ejercicio = f_ejercicio_activo(codigo_empresa)
		cuenta = trim(GetItemString(Row,"cuenta_cargo"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de cargo.")
				SetColumn("cuenta_cargo")			
			end if
		End If
		
	case 'cuota_amor'
		ejercicio = GetItemDecimal(Row,"ejercicio")
		If isnull(ejercicio) then ejercicio = f_ejercicio_activo(codigo_empresa)
		cuenta = trim(GetItemString(Row,"cuenta_abono"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de abono.")
				SetColumn("cuenta_abono")			
			end if
		End If
				
end choose		
end event

event dw_1::key;String	ejercicio

ejercicio = String(GetItemDecimal(GetRow(),"ejercicio"))

If isnull(ejercicio) or ejercicio = '' then ejercicio = String(f_ejercicio_activo(codigo_empresa))
	

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
 		bus_datawindow = "dw_ayuda_act_familias"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "bien"
      bus_titulo     = "AYUDA SELECCION DE BIENES"
 		bus_datawindow = "dw_ayuda_act_bienes"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "clase_inmobilizado"
      bus_titulo     = "AYUDA SELECCION DE CLASES DE INMOBILIZADO"
 		bus_datawindow = "dw_ayuda_act_clase"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "ctaproveedor","cuenta_activo","cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_filtro      = "ejercicio = " + ejercicio
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::rbuttondown;String	ejercicio

ejercicio = String(GetItemDecimal(GetRow(),"ejercicio"))

If isnull(ejercicio) or ejercicio = '' then ejercicio = String(f_ejercicio_activo(codigo_empresa))
	
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
 		bus_datawindow = "dw_ayuda_act_familias"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "bien"
      bus_titulo     = "AYUDA SELECCION DE BIENES"
 		bus_datawindow = "dw_ayuda_act_bienes"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
//	CASE "tipo_bien"
//      bus_titulo     = "AYUDA SELECCION DE TIPOS DE BIENES"
// 		bus_datawindow = "dw_ayuda_act_tipobien"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "clase_inmobilizado"
      bus_titulo     = "AYUDA SELECCION DE CLASES DE INMOBILIZADO"
 		bus_datawindow = "dw_ayuda_act_clase"
		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "ctaproveedor","cuenta_activo","cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_filtro      = "ejercicio = " + ejercicio
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_amortizaciones
integer x = 293
integer y = 248
integer width = 398
string text = "Amortización"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_amortizaciones
integer x = 1902
integer y = 240
integer width = 302
end type

event cb_insertar::clicked;String 	cadena,cuenta
Integer 	fila,i1
Dec		valor,ejercicio,n6,n12,d1
Boolean	editando
DateTime	fecha
String	c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c13

fila = dw_1.GetRow() 
editando = False

IF fila <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 editando = True	
		 dw_1.AcceptText()

	//	Validaciones

		d1 = dec(em_elemento.text)
		i1 = dec(sle_valor.text)

		SELECT act_amortizaciones.actualizado  
		 INTO :cadena  
		 FROM act_amortizaciones  
		WHERE ( act_amortizaciones.empresa = :codigo_empresa ) AND  
				( act_amortizaciones.elemento = :d1 ) AND  
				( act_amortizaciones.amortizacion = :i1 )   ;
				
		 If Trim(cadena) = 'S' Then
			f_mensaje("Aviso","NO DEBE modificar una amortización ya actualizada. Se le permite realizar modificaciones, pero en ese caso puede dejar los datos inconsistentes!")
//			Return
//		 Else
//			f_mensaje("debug",cadena)
		 END IF

		cadena = trim(dw_1.GetItemString(fila,"familia"))
		If not (isnull(cadena) or trim(cadena)='') then
			cadena = f_desc_familia(codigo_empresa,cadena)
				If cadena = '' then f_mensaje("Aviso","No existe la familia.")
		End If
		
// David	06-02-2013	 Lo  comento porque nunca rellenamos el campo bien 
/*		
		valor = dw_1.GetItemDecimal(fila,"bien")
		If not (isnull(valor)) then
			if f_desc_bien(codigo_empresa,valor)='' then
				f_mensaje("Aviso","No existe el bien.")
				dw_1.SetFocus()
				dw_1.SetColumn("bien")			
				Return
			End If
		End If
*/
		ejercicio = dw_1.GetItemDecimal(dw_1.GetRow(),"ejercicio")
		If isnull(ejercicio) then ejercicio = f_ejercicio_activo(codigo_empresa)

		cuenta = trim(dw_1.GetItemString(fila,"cuenta_activo"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de activo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_activo")			
			Return
		end if
		
		cuenta = trim(dw_1.GetItemString(fila,"cuenta_cargo"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de cargo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_cargo")			
			Return
		end if
		
		cuenta = trim(dw_1.GetItemString(fila,"cuenta_abono"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(ejercicio,codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de abono.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_abono")			
			Return
		end if
		
	end if 
END IF

CALL super::Clicked

if not editando THEN //Inicializaciones
	fila = dw_1.GetRow() 
	valor = dec(em_elemento.text)

	dw_1.SetItem(fila,"empresa",codigo_empresa)
	dw_1.SetItem(fila,"elemento",valor)
	
	  SELECT act_bienesdet.clase_inmobilizado,   
         act_bienesdet.familia,   
         act_bienesdet.bien,   
         act_bienesdet.tipo_amor,   
         act_bienesdet.clase_amor,   
         act_bienesdet.porcentaje_amor,   
         act_bienesdet.cuenta_activo,   
         act_bienesdet.cuenta_cargo,   
         act_bienesdet.cuenta_abono,   
         act_bienesdet.seccion,   
         act_bienesdet.centro_coste,
			act_bienesdet.fechacompra,
			act_bienesdet.importe,
			act_bienesdet.ctaproveedor
    INTO :c1,   
         :c2,   
         :c3,   
         :c4,   
         :c5,   
         :n6,   
         :c7,   
         :c8,   
         :c9,   
         :c10,   
         :c11,
			:fecha,
			:n12,
			:c13
    FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :codigo_empresa ) AND  
         ( act_bienesdet.elemento = :valor )   ;


	c1 = trim(c1)
   c2	= trim(c2)   
   c3 = trim(c3)  
   c4 = trim(c4)  
   c5 = trim(c5)     
   c7 = trim(c7)  
   c8 = trim(c8)  
   c9 = trim(c9)  
   c10= trim(c10)   
   c11= trim(c11)	
	c13= trim(c13)


	If sqlca.sqlcode= 0 then
		dw_1.SetItem(fila,"empresa",codigo_empresa)
		dw_1.SetItem(fila,"elemento",valor)		
		If not isnull(c1) then dw_1.SetItem(fila,"clase_inmobilizado",c1)
		If not isnull(c2) then dw_1.SetItem(fila,"familia",c2)		
		If not isnull(c3) then dw_1.SetItem(fila,"bien",c3)
		If not isnull(c4) then dw_1.SetItem(fila,"tipo_amor",c4)		
		If not isnull(c5) then dw_1.SetItem(fila,"clase_amor",c5)
		If not isnull(n6) then dw_1.SetItem(fila,"porcentaje_amor",n6)		
		If not isnull(c7) then dw_1.SetItem(fila,"cuenta_activo",c7)
		If not isnull(c8) then dw_1.SetItem(fila,"cuenta_cargo",c8)		
		If not isnull(c9) then dw_1.SetItem(fila,"cuenta_abono",c9)
		If not isnull(c10) then dw_1.SetItem(fila,"seccion",c10)		
		If not isnull(c11) then dw_1.SetItem(fila,"centro_coste",c11)		
		If not isnull(fecha) then dw_1.SetItem(fila,"act_bienesdet_fechacompra",fecha)
		If not isnull(n12) then dw_1.SetItem(fila,"act_bienesdet_importe",n12)		
		If not isnull(c13) then dw_1.SetItem(fila,"act_bienesdet_ctaproveedor",c13)		
	End If
	
End If
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_amortizaciones
integer x = 2213
integer y = 240
integer width = 302
end type

event cb_borrar::clicked;String actualizado

IF not isnull(sle_valor.text) and trim(sle_valor.text)<>'' then
	actualizado = trim(dw_1.GetItemString(dw_1.GetRow(),"actualizado")	)
	If not isnull(actualizado) and actualizado='S' then
		f_mensaje("Error","La amortización no puede borrarse porque ha sido actualizada.")
		return
	Else		
		call super::clicked
	End If 
End If 
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_amortizaciones
integer x = 704
integer y = 248
integer width = 206
integer taborder = 20
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = ""
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = ""
   ue_titulo         = ""
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_amortizaciones
integer x = 2523
integer y = 240
integer width = 302
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_amortizaciones
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_amortizaciones
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_amortizaciones
integer y = 20
integer width = 2811
end type

type pb_calculadora from u_calculadora within wi_mant_act_amortizaciones
integer x = 919
integer y = 248
integer taborder = 0
end type

event clicked;Integer 	registros
Dec		elemento

elemento = Dec(em_elemento.text)

IF cb_insertar.enabled=TRUE THEN Return
 Select count(*) Into :registros From act_amortizaciones
 Where  act_amortizaciones.empresa = :codigo_empresa and act_amortizaciones.elemento = :elemento;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  
  Select max(act_amortizaciones.amortizacion+1)
  Into   :sle_valor.text
  From   act_amortizaciones
  Where  act_amortizaciones.empresa = :codigo_empresa and act_amortizaciones.elemento = :elemento;
END IF
 dw_1.TriggerEvent("Clicked")
end event

type em_elemento from u_em_campo within wi_mant_act_amortizaciones
integer x = 699
integer y = 140
integer width = 425
integer taborder = 10
boolean bringtotop = true
end type

event modificado;call super::modificado;st_elemento.text = f_desc_bienesdet(codigo_empresa,dec(em_elemento.text))
end event

type st_2 from statictext within wi_mant_act_amortizaciones
integer x = 402
integer y = 144
integer width = 288
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
string text = "Elemento"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_elemento from statictext within wi_mant_act_amortizaciones
integer x = 1129
integer y = 144
integer width = 1033
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

