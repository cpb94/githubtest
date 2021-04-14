$PBExportHeader$wi_mant_promcontador.srw
forward
global type wi_mant_promcontador from wi_mvent_con_empresa
end type
end forward

global type wi_mant_promcontador from wi_mvent_con_empresa
integer width = 2395
integer height = 1000
end type
global wi_mant_promcontador wi_mant_promcontador

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento contador pedidos promocion"
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
   sle_valor.text = STring(Year(Today()))
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))
      END IF
   END IF

	
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"anyo",integer(sle_valor.text))
  
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "promcontador"

dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))

CALL Super::ue_recuperar
end event

on wi_mant_promcontador.create
call super::create
end on

on wi_mant_promcontador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promcontador
integer y = 396
integer width = 1742
integer height = 336
string dataobject = "dw_promcontador"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promcontador
integer x = 151
integer y = 272
integer width = 251
string text = "Año"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promcontador
integer x = 1879
integer y = 388
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promcontador
integer x = 1874
integer y = 504
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promcontador
integer x = 411
integer y = 272
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_calidades"
ue_titulo      = "Tipos de Calidades"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promcontador
integer x = 1874
integer y = 628
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promcontador
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promcontador
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promcontador
integer width = 2249
end type

