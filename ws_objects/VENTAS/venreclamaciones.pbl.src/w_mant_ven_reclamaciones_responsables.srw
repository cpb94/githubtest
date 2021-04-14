﻿$PBExportHeader$w_mant_ven_reclamaciones_responsables.srw
$PBExportComments$Mant. Zonas comerciales
forward
global type w_mant_ven_reclamaciones_responsables from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_ven_reclamaciones_responsables
end type
end forward

global type w_mant_ven_reclamaciones_responsables from wi_mvent_con_empresa
integer width = 2446
integer height = 988
boolean resizable = true
pb_calculadora pb_calculadora
end type
global w_mant_ven_reclamaciones_responsables w_mant_ven_reclamaciones_responsables

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de responsables"
	istr_parametros.s_listado        = "report_responsables"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
      END IF
   END IF

	
end event

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venzonas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.object.empresa[1]         = codigo_empresa
dw_1.object.codigo[1]          = sle_valor.text
dw_1.object.descripcion[1]     = ""
dw_1.object.descripcion_abr[1] = ""
dw_1.object.clave_externa[1]   = ""
end event

on w_mant_ven_reclamaciones_responsables.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_ven_reclamaciones_responsables.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_ven_reclamaciones_responsables
integer x = 23
integer y = 240
integer width = 1938
integer height = 624
string dataobject = "dw_mant_ven_reclamaciones_responsables"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_ven_reclamaciones_responsables
integer x = 169
integer y = 140
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_ven_reclamaciones_responsables
integer x = 1970
integer y = 240
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_ven_reclamaciones_responsables
integer x = 1970
integer y = 360
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_ven_reclamaciones_responsables
integer x = 457
integer y = 128
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_ven_reclamaciones_responsables"
ue_titulo     =  "AYUDA SELECCION RESPONSABLES DE LA RECLAMACION"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_ven_reclamaciones_responsables
integer x = 1970
integer y = 480
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_ven_reclamaciones_responsables
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_ven_reclamaciones_responsables
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_ven_reclamaciones_responsables
integer width = 2816
end type

type pb_calculadora from u_calculadora within w_mant_ven_reclamaciones_responsables
integer x = 722
integer y = 128
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 
Select count(*) Into :registros From ven_reclamaciones_responsables
Where  ven_reclamaciones_responsables.empresa = :codigo_empresa;

IF registros=0  Then
	sle_valor.text="1"
ELSE
	Select max(convert(int,ven_reclamaciones_responsables.codigo)+1)
	Into   :sle_valor.text
	From  ven_reclamaciones_responsables
	Where ven_reclamaciones_responsables.empresa = :codigo_empresa;
END IF

dw_1.TriggerEvent("Clicked")
end event

