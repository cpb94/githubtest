$PBExportHeader$w_mant_comtipo_proveedor.srw
forward
global type w_mant_comtipo_proveedor from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_comtipo_proveedor
end type
end forward

global type w_mant_comtipo_proveedor from wi_mvent_con_empresa
integer width = 2674
integer height = 856
string menuname = ""
pb_calculadora pb_calculadora
end type
global w_mant_comtipo_proveedor w_mant_comtipo_proveedor

on w_mant_comtipo_proveedor.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_comtipo_proveedor.destroy
call super::destroy
destroy(this.pb_calculadora)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "comtipo_proveedor"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Tipos de Proveedor"
//	istr_parametros.s_listado        = "report_venmateria"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_comtipo_proveedor
integer x = 64
integer y = 340
integer width = 2039
integer height = 340
string dataobject = "dw_mant_comtipo_proveedor"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_comtipo_proveedor
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_comtipo_proveedor
integer x = 2144
integer y = 336
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_comtipo_proveedor
integer x = 2139
integer y = 460
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_comtipo_proveedor
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comtipo_proveedor"
ue_titulo     =  "AYUDA SELECCION DE TIPOS DE PROVEEDOR"
ue_filtro     =  ""
isle_campo    = This
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_comtipo_proveedor
integer x = 2144
integer y = 588
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_comtipo_proveedor
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_comtipo_proveedor
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_comtipo_proveedor
end type

type pb_calculadora from u_calculadora within w_mant_comtipo_proveedor
integer x = 754
integer y = 208
integer taborder = 0
end type

event clicked;Integer registros

IF cb_insertar.enabled =TRUE THEN Return

Select count(*) 
Into   :registros 
From   comtipo_proveedor
Where  empresa = :codigo_empresa;

IF registros=0  Then
	sle_valor.text="1"
ELSE
	Select max(convert(int,codigo)+1)
	Into   :sle_valor.text
	From   comtipo_proveedor
	Where  empresa = :codigo_empresa;
END IF
dw_1.TriggerEvent("Clicked")
end event

