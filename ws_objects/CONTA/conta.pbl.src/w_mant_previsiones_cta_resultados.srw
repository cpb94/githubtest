$PBExportHeader$w_mant_previsiones_cta_resultados.srw
forward
global type w_mant_previsiones_cta_resultados from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_previsiones_cta_resultados
end type
end forward

global type w_mant_previsiones_cta_resultados from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3749
integer height = 2196
pb_calculadora pb_calculadora
end type
global w_mant_previsiones_cta_resultados w_mant_previsiones_cta_resultados

on w_mant_previsiones_cta_resultados.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_previsiones_cta_resultados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Previsiones de Resultados"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contaprevresultado"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"ejercicio",sle_valor.text)

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_previsiones_cta_resultados
integer width = 3552
integer height = 1624
string dataobject = "dw_mant_previsiones_cta_resultados"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_previsiones_cta_resultados
integer x = 87
string text = "Ejercicio:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_previsiones_cta_resultados
integer x = 2363
integer y = 208
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_previsiones_cta_resultados
integer x = 2775
integer y = 208
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_previsiones_cta_resultados
integer x = 498
string mask = "####"
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodcolor"
ue_titulo      = "Ayuda selección de Colores"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_previsiones_cta_resultados
integer x = 3186
integer y = 208
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_previsiones_cta_resultados
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_previsiones_cta_resultados
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_previsiones_cta_resultados
integer x = 41
integer y = 36
integer width = 3552
end type

type pb_calculadora from u_calculadora within w_mant_previsiones_cta_resultados
integer x = 759
integer y = 204
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
	Integer registros
	Select count(*) 
	Into	 :registros
	From	 contaprevresultado
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
   	sle_valor.text="0001"
	ELSE
		Select max(convert(int, ejercicio)+1)
		Into   :sle_valor.text
		From   contaprevresultado
		Where  empresa = :codigo_empresa;
END IF
sle_valor.text = right("0000"+trim(sle_valor.text),4)
dw_1.triggerEvent("clicked")
  
end event

