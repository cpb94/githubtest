$PBExportHeader$wi_mant_labcontadores.srw
forward
global type wi_mant_labcontadores from wi_mvent_con_empresa
end type
end forward

global type wi_mant_labcontadores from wi_mvent_con_empresa
integer width = 2267
integer height = 1248
end type
global wi_mant_labcontadores wi_mant_labcontadores

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Contadores de Laboratorio"
istr_parametros.s_listado        = ""
This.title = istr_parametros.s_titulo_ventana
sle_valor.text = String(Year(Today()))
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
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "lab_param"

dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))

CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",Integer(sle_valor.text))
end event

on wi_mant_labcontadores.create
call super::create
end on

on wi_mant_labcontadores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_labcontadores
integer x = 18
integer y = 336
integer width = 1403
integer height = 348
string dataobject = "dw_labcontadores"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_labcontadores
integer x = 73
integer y = 220
integer width = 283
string text = "Año:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_labcontadores
integer x = 1586
integer y = 332
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_labcontadores
integer x = 1586
integer y = 440
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_labcontadores
integer x = 370
integer y = 208
integer height = 92
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_labcontadores
integer x = 1586
integer y = 548
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_labcontadores
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_labcontadores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_labcontadores
integer width = 2135
end type

