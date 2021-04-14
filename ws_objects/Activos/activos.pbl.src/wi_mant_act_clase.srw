$PBExportHeader$wi_mant_act_clase.srw
forward
global type wi_mant_act_clase from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_act_clase
end type
type uo_ejercicio from u_ejercicio within wi_mant_act_clase
end type
end forward

global type wi_mant_act_clase from wi_mvent_con_empresa
integer width = 2670
integer height = 1416
pb_calculadora pb_calculadora
uo_ejercicio uo_ejercicio
end type
global wi_mant_act_clase wi_mant_act_clase

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento Clases de Inmovilizado"
valor_empresa = True
istr_parametros.s_listado        = "report_act_clase"
This.title = istr_parametros.s_titulo_ventana
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))
	END IF
END IF


end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"clase",integer(sle_valor.text))
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_clase"

dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))

CALL Super::ue_recuperar
end event

on wi_mant_act_clase.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.uo_ejercicio=create uo_ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.uo_ejercicio
end on

on wi_mant_act_clase.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.uo_ejercicio)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_clase
integer x = 87
integer y = 552
integer width = 2510
integer height = 656
string dataobject = "dwact_clase"
end type

event dw_1::clicked;call super::clicked;String cuenta
str_parametros lstr_param

If isnull(dwo) then return

Choose case dwo.name
	case "cargo"
		cuenta = trim(GetItemString(GetRow(),"cuenta_cargo"))
		lstr_param.i_nargumentos    = 3
		lstr_param.s_argumentos[1]  = "wi_mant_act_clase"		
		lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
		lstr_param.s_argumentos[3]  = cuenta
		OpenWithParm(wi_mant_contaplan,lstr_param) 
	case "abono"
		cuenta = trim(GetItemString(GetRow(),"cuenta_abono"))
		lstr_param.i_nargumentos    = 3
		lstr_param.s_argumentos[1]  = "wi_mant_act_clase"		
		lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
		lstr_param.s_argumentos[3]  = cuenta
		OpenWithParm(wi_mant_contaplan,lstr_param)
end choose
end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown


end event

event itemchanged;Dec	valor,calculo
String cuenta

choose case dwo.name
	case 'periodo_maximo'
		valor = dec(data)
		calculo = 100 / valor
		SetItem(GetRow(),"por_minlineal",calculo)
		
	case 'por_maxlineal'
		valor = dec(data)
		calculo = 100 / valor
		SetItem(GetRow(),"periodo_minimo",calculo)
		
	case 'cuenta_cargo'
		cuenta = data
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de cargo.")
			SetColumn("cuenta_cargo")			
		end if
	case 'cuenta_abono'
		cuenta = data
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de abono.")
			SetColumn("cuenta_abono")			
		end if
end choose		
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_clase
integer x = 201
integer width = 315
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_clase
integer x = 1303
integer y = 392
end type

event cb_insertar::clicked;String var_descripcion,cuenta
Integer fila
Dec	valor,valor2,calculo

fila = dw_1.GetRow() 

IF fila <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 dw_1.AcceptText()

		valor = dw_1.GetItemDecimal(fila,"periodo_maximo")
		If not isnull(valor) and valor<>0 then
			calculo = 100 / valor
			dw_1.SetItem(fila,"por_minlineal",calculo)
		End If

		valor = dw_1.GetItemDecimal(fila,"por_maxlineal")
		If not isnull(valor) and valor<>0 then
			calculo = 100 / valor
			dw_1.SetItem(fila,"periodo_minimo",calculo)
		End If

		// Comprobamos que periodo_minimo < periodo_maximo
		valor = dw_1.GetItemDecimal(fila,"periodo_maximo")
		valor2 = dw_1.GetItemDecimal(fila,"periodo_minimo")
		If valor2 > valor then
			f_mensaje("Aviso","El período mínimo no puede ser inferior al período máximo.")
			dw_1.SetFocus()
			dw_1.SetColumn("periodo_maximo")			
			return
		End If

		cuenta = trim(dw_1.GetItemString(fila,"cuenta_cargo"))
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de cargo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_cargo")			
			return
		end if

		cuenta = trim(dw_1.GetItemString(fila,"cuenta_abono"))
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de abono.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_abono")			
			return
		end if

	end if
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_clase
integer x = 1746
integer y = 392
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_clase
integer x = 526
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_clase"
   ue_titulo         = "AYUDA SELECCION CLASES INMOBILIZADO"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_clase
integer x = 2190
integer y = 392
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_clase
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_clase
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_clase
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_act_clase
integer x = 791
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From act_clase
 Where  act_clase.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  
  dec maxim
  long maxim_long
  
  Select max(act_clase.clase)
  Into   :maxim
  From   act_clase
  Where  act_clase.empresa = :codigo_empresa;
  
  maxim_long = long(maxim) + 1
 
  sle_valor.text = string(maxim_long)
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type uo_ejercicio from u_ejercicio within wi_mant_act_clase
integer x = 1157
integer y = 204
integer taborder = 31
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

