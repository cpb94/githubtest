$PBExportHeader$w_mant_tecnicos_dis.srw
forward
global type w_mant_tecnicos_dis from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_tecnicos_dis
end type
end forward

global type w_mant_tecnicos_dis from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2574
integer height = 832
pb_calculadora pb_calculadora
end type
global w_mant_tecnicos_dis w_mant_tecnicos_dis

type variables

end variables

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Técnicos de Diseño"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "tecnico_dis"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_tecnicos_dis.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_tecnicos_dis.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_tecnicos_dis
integer x = 123
integer y = 292
integer width = 1806
integer height = 268
string dataobject = "dw_mant_tecnicos_dis"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_tecnicos_dis
integer x = 59
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_tecnicos_dis
integer x = 2011
integer y = 240
end type

event cb_insertar::clicked;String descrip
IF this.enabled then
	dw_1.accepttext()
	descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción del Técnico")
		dw_1.SetFocus()
		return
	end if
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_tecnicos_dis
integer x = 2011
integer y = 336
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_tecnicos_dis
integer x = 334
integer y = 172
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_tecnicos_dis"
ue_titulo      = "AYUDA SELECCION DE TÉCNICOS DE DISEÑO"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_tecnicos_dis
integer x = 2011
integer y = 432
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_tecnicos_dis
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_tecnicos_dis
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_tecnicos_dis
integer width = 2437
integer textsize = -12
end type

type pb_calculadora from u_calculadora within w_mant_tecnicos_dis
integer x = 599
integer y = 164
integer taborder = 0
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   tecnico_dis	
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   tecnico_dis
		Where  empresa = :codigo_empresa;
	END IF
	dw_1.triggerEvent("clicked")
end if
end event

