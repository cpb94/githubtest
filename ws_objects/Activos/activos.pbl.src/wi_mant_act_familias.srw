$PBExportHeader$wi_mant_act_familias.srw
forward
global type wi_mant_act_familias from wi_mvent_con_empresa
end type
type uo_ejercicio from u_ejercicio within wi_mant_act_familias
end type
type st_2 from statictext within wi_mant_act_familias
end type
type st_3 from statictext within wi_mant_act_familias
end type
type st_4 from statictext within wi_mant_act_familias
end type
type em_1 from u_em_campo within wi_mant_act_familias
end type
type em_2 from u_em_campo within wi_mant_act_familias
end type
type em_3 from u_em_campo within wi_mant_act_familias
end type
type em_4 from u_em_campo within wi_mant_act_familias
end type
type st_7 from statictext within wi_mant_act_familias
end type
type st_8 from statictext within wi_mant_act_familias
end type
type st_6 from statictext within wi_mant_act_familias
end type
type st_5 from statictext within wi_mant_act_familias
end type
type cb_1 from commandbutton within wi_mant_act_familias
end type
type st_c from statictext within wi_mant_act_familias
end type
end forward

global type wi_mant_act_familias from wi_mvent_con_empresa
integer width = 2661
integer height = 1276
uo_ejercicio uo_ejercicio
st_2 st_2
st_3 st_3
st_4 st_4
em_1 em_1
em_2 em_2
em_3 em_3
em_4 em_4
st_7 st_7
st_8 st_8
st_6 st_6
st_5 st_5
cb_1 cb_1
st_c st_c
end type
global wi_mant_act_familias wi_mant_act_familias

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public function string f_componer_familia ()
public subroutine f_borrar_siguientes (integer digito)
end prototypes

public function string f_componer_familia ();String cadena

If isnull(em_1.text) or em_1.text="" then 
	em_1.SetFocus()
	return ''
End If

If isnull(em_2.text) or em_2.text="" then 
	em_2.SetFocus()
	return ''
End If

If isnull(em_3.text) then 
	em_3.SetFocus()
	return ''
End If

If isnull(em_4.text) then 
	em_4.SetFocus()
	return ''
End If

cadena = em_1.text + em_2.text + string(dec(em_3.text),"00") + string(dec(em_4.text),"00") 

return cadena
end function

public subroutine f_borrar_siguientes (integer digito);If digito < 2 then
	em_2.text = ''
	st_6.text = ''
End If

If digito < 3 then
	em_3.text = ''
	st_7.text = ''
End If

If digito < 4 then
	em_4.text = ''
	st_8.text = ''	
End If

dw_1.Reset()
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento De Familias"
valor_empresa = True
tipo_mantenimiento = 'C'
istr_parametros.s_listado        = "report_act_familias"
This.title = istr_parametros.s_titulo_ventana
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

st_1.text = f_desc_digito_familia(codigo_empresa,1)
st_2.text = f_desc_digito_familia(codigo_empresa,2)
st_3.text = f_desc_digito_familia(codigo_empresa,3)
st_4.text = f_desc_digito_familia(codigo_empresa,4)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF


end event

event ue_inserta_fila;call super::ue_inserta_fila;String cadena

cadena = sle_valor.text
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"familia",cadena)
dw_1.setitem(dw_1.getrow(),"campo1",mid(cadena,1,1))
dw_1.setitem(dw_1.getrow(),"campo2",mid(cadena,2,1))
dw_1.setitem(dw_1.getrow(),"campo3",mid(cadena,3,2))
dw_1.setitem(dw_1.getrow(),"campo4",mid(cadena,5,2))

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_familias"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_act_familias.create
int iCurrent
call super::create
this.uo_ejercicio=create uo_ejercicio
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.em_1=create em_1
this.em_2=create em_2
this.em_3=create em_3
this.em_4=create em_4
this.st_7=create st_7
this.st_8=create st_8
this.st_6=create st_6
this.st_5=create st_5
this.cb_1=create cb_1
this.st_c=create st_c
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ejercicio
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.em_3
this.Control[iCurrent+8]=this.em_4
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.st_c
end on

on wi_mant_act_familias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_ejercicio)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cb_1)
destroy(this.st_c)
end on

event ue_activa_claves;call super::ue_activa_claves;em_1.displayonly = False
em_2.displayonly = False
em_3.displayonly = False
em_4.displayonly = False
/*
em_1.enabled = False
em_2.enabled = False
em_3.enabled = False
em_4.enabled = False
*/
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;em_1.displayonly = True
em_2.displayonly = True
em_3.displayonly = True
em_4.displayonly = True
/*
em_1.enabled = True
em_2.enabled = True
em_3.enabled = True
em_4.enabled = True
*/
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_familias
integer x = 37
integer y = 624
integer width = 2107
integer height = 428
string dataobject = "dwact_familias"
end type

event dw_1::clicked;call super::clicked;String cuenta
str_parametros lstr_param

If isnull(dwo) then return

Choose case dwo.name
	case "pb_activo"
		cuenta = trim(GetItemString(GetRow(),"cuenta_activo"))
		lstr_param.i_nargumentos    = 3
		lstr_param.s_argumentos[1]  = "wi_mant_act_familias"		
		lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
		lstr_param.s_argumentos[3]  = cuenta
		OpenWithParm(wi_mant_contaplan,lstr_param)
	case "pb_cargo"
		cuenta = trim(GetItemString(GetRow(),"cuenta_cargo"))
		lstr_param.i_nargumentos    = 3
		lstr_param.s_argumentos[1]  = "wi_mant_act_familias"		
		lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
		lstr_param.s_argumentos[3]  = cuenta
		OpenWithParm(wi_mant_contaplan,lstr_param)
	case "pb_abono"
		cuenta = trim(GetItemString(GetRow(),"cuenta_abono"))
		lstr_param.i_nargumentos    = 3
		lstr_param.s_argumentos[1]  = "wi_mant_act_familias"		
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
	CASE "cuenta_activo","cuenta_cargo","cuenta_abono"
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
	CASE "cuenta_activo","cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;Dec	valor
String cuenta

choose case dwo.name
		
	case 'cuenta_cargo'
		cuenta = trim(GetItemString(GetRow(),"cuenta_activo"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de activo.")
				SetColumn("cuenta_activo")			
			end if
		End If
	case 'cuenta_abono'
		cuenta = trim(GetItemString(GetRow(),"cuenta_cargo"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de cargo.")
				SetColumn("cuenta_cargo")			
			end if
		End If
	case 'tiempoamor'
		cuenta = trim(GetItemString(GetRow(),"cuenta_abono"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de abono.")
				SetColumn("cuenta_abono")			
			end if
		End If
end choose		
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_familias
integer x = 123
integer y = 128
integer width = 667
string text = "Código"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_familias
integer x = 2194
integer y = 636
end type

event cb_insertar::clicked;String var_descripcion,cadena,cuenta
Integer fila
Dec	valor,calculo
Boolean	editando

fila = dw_1.GetRow() 
editando = False

IF fila <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 editando = True	
		 dw_1.AcceptText()
		 var_descripcion  = trim(dw_1.GetItemString(fila,"descripcion"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(fila,"descripcion",".")
		 END IF
 		 cuenta = trim(dw_1.GetItemString(fila,"cuenta_activo"))
	 	 If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
				f_mensaje("Aviso","No existe la cuenta de activo.")
				dw_1.SetFocus()
				dw_1.SetColumn("cuenta_activo")		
				return
			end if
		 End If
//		 cuenta = trim(dw_1.GetItemString(fila,"cuenta_cargo"))
//		 If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de cargo.")
//				dw_1.SetFocus()
//				dw_1.SetColumn("cuenta_cargo")			
//				return
//			end if
//		 End If
//		 cuenta = trim(dw_1.GetItemString(fila,"cuenta_abono"))
//		 If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de abono.")
//				dw_1.SetFocus()
//				dw_1.SetColumn("cuenta_abono")			
//				return
//			end if
//		 End If
		 cadena  = trim(dw_1.GetItemString(fila,"tipo_amor"))
		 If Trim(cadena) = ""   or ISNULL(cadena)Then
			dw_1.SetItem(fila,"tipo_amor","M")
		 END IF
		 cadena  = trim(dw_1.GetItemString(fila,"clase_amor"))
		 If Trim(cadena) = ""   or ISNULL(cadena)Then
			dw_1.SetItem(fila,"clase_amor","L")
		 END IF
	end if
END IF

CALL super::Clicked

if editando THEN 
	em_1.SetFocus()
Else
	dw_1.SetItem(dw_1.GetRow(),"tipo_amor",'M')
	dw_1.SetItem(dw_1.GetRow(),"clase_amor",'L')
End If
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_familias
integer x = 2194
integer y = 744
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_familias
integer x = 800
integer y = 524
integer width = 325
integer taborder = 0
boolean displayonly = true
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_familias"
   ue_titulo         = "AYUDA SELECCION FAMILIAS"
   ue_filtro         = ""
   isle_campo        = This
end event

event sle_valor::busqueda;call super::busqueda;String cadena

cadena = sle_valor.text

If not isnull(cadena) and cadena<>''then
	em_1.text = mid(cadena,1,1)
	em_1.TriggerEvent(modified!)
	em_2.text = mid(cadena,2,1)
	em_2.TriggerEvent(modified!)
	em_3.text = mid(cadena,3,2)
	em_3.TriggerEvent(modified!)
	em_4.text = mid(cadena,5,2)
	em_4.TriggerEvent(modified!)
End If
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_familias
integer x = 2194
integer y = 860
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_familias
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_familias
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_familias
integer y = 12
integer width = 2299
end type

type uo_ejercicio from u_ejercicio within wi_mant_act_familias
integer x = 1847
integer y = 120
integer taborder = 70
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_2 from statictext within wi_mant_act_familias
integer x = 123
integer y = 224
integer width = 667
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
string text = "Código"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_act_familias
integer x = 123
integer y = 320
integer width = 667
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
string text = "Código"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_act_familias
integer x = 128
integer y = 420
integer width = 667
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
string text = "Código"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from u_em_campo within wi_mant_act_familias
integer x = 805
integer y = 128
integer width = 87
integer taborder = 10
string mask = "#"
boolean autoskip = true
string displaydata = ""
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_fcampo1"
   ue_titulo         = "AYUDA SELECCION 1er DIGITO FAMILIA"
   ue_filtro         = ""
   isle_campo        = This
end event

event rbuttondown;If not this.displayonly then call super::rbuttondown
end event

event tecla_enter;If not this.displayonly then call super::tecla_enter
end event

event modified;f_borrar_siguientes(1)

st_5.text = f_digitos_familia(codigo_empresa,1,integer(em_1.text))
end event

event modificado;call super::modificado;//f_borrar_siguientes(1)
//
//st_5.text = f_digitos_familia(codigo_empresa,1,integer(em_1.text))
end event

type em_2 from u_em_campo within wi_mant_act_familias
integer x = 805
integer y = 224
integer width = 87
integer taborder = 20
boolean bringtotop = true
string mask = "#"
boolean autoskip = true
string displaydata = ""
end type

event modificado;call super::modificado;//f_borrar_siguientes(2)
//
//st_6.text = f_digitos_familia(codigo_empresa,2,integer(em_2.text))
end event

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_fcampo2"
   ue_titulo         = "AYUDA SELECCION 2º DIGITO"
   ue_filtro         = ""
   isle_campo        = This
end event

event tecla_enter;If not this.displayonly then call super::tecla_enter
end event

event rbuttondown;If not this.displayonly then call super::rbuttondown
end event

event modified;f_borrar_siguientes(2)

st_6.text = f_digitos_familia(codigo_empresa,2,integer(em_2.text))
end event

type em_3 from u_em_campo within wi_mant_act_familias
integer x = 805
integer y = 324
integer width = 142
integer taborder = 30
boolean bringtotop = true
string mask = "##"
boolean autoskip = true
end type

event modificado;call super::modificado;//f_borrar_siguientes(3)
//
//st_7.text = f_digitos_familia(codigo_empresa,3,integer(em_3.text))
end event

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_fcampo3"
   ue_titulo         = "AYUDA SELECCION 3er DIGITO"
   ue_filtro         = ""
   isle_campo        = This
end event

event rbuttondown;If not this.displayonly then call super::rbuttondown
end event

event tecla_enter;If not this.displayonly then call super::tecla_enter
end event

event modified;f_borrar_siguientes(3)

st_7.text = f_digitos_familia(codigo_empresa,3,integer(em_3.text))
end event

type em_4 from u_em_campo within wi_mant_act_familias
integer x = 805
integer y = 416
integer width = 142
integer taborder = 40
boolean bringtotop = true
string mask = "##"
string displaydata = ""
end type

event modificado;call super::modificado;//f_borrar_siguientes(4)
//
//st_8.text = f_digitos_familia(codigo_empresa,4,integer(em_4.text))
end event

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_fcampo4"
   ue_titulo         = "AYUDA SELECCION 4º y 5º DIGITO"
   ue_filtro         = ""
   isle_campo        = This
end event

event rbuttondown;If not this.displayonly then call super::rbuttondown
end event

event tecla_enter;If not this.displayonly then call super::tecla_enter
end event

event modified;f_borrar_siguientes(4)

st_8.text = f_digitos_familia(codigo_empresa,4,integer(em_4.text))
end event

type st_7 from statictext within wi_mant_act_familias
integer x = 955
integer y = 320
integer width = 841
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

type st_8 from statictext within wi_mant_act_familias
integer x = 955
integer y = 416
integer width = 841
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

type st_6 from statictext within wi_mant_act_familias
integer x = 955
integer y = 224
integer width = 841
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

type st_5 from statictext within wi_mant_act_familias
integer x = 955
integer y = 128
integer width = 841
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

type cb_1 from commandbutton within wi_mant_act_familias
integer x = 1161
integer y = 524
integer width = 329
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "&Componer"
end type

event clicked;sle_valor.SetFocus()
sle_valor.text = f_componer_familia()
If sle_valor.text <>'' then sle_valor.TriggerEvent("tecla_tabulador")
end event

type st_c from statictext within wi_mant_act_familias
integer x = 128
integer y = 524
integer width = 667
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
string text = "Código de la Familia"
alignment alignment = right!
boolean focusrectangle = false
end type

