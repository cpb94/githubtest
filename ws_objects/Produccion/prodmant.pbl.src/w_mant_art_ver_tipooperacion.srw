$PBExportHeader$w_mant_art_ver_tipooperacion.srw
forward
global type w_mant_art_ver_tipooperacion from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_art_ver_tipooperacion
end type
end forward

global type w_mant_art_ver_tipooperacion from wi_mvent_con_empresa
integer width = 2510
integer height = 888
pb_calculadora pb_calculadora
end type
global w_mant_art_ver_tipooperacion w_mant_art_ver_tipooperacion

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_art_ver_tipooperacion.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_art_ver_tipooperacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose


istr_parametros.s_titulo_ventana = "Mantenimiento de tipos de operaciones de artículos"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "art_ver_tipooperacion"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_art_ver_tipooperacion
integer x = 9
integer y = 304
integer width = 2427
integer height = 340
string dataobject = "dw_art_tipooperaciones"
end type

event dw_1::losefocus;// No se permite introducir registros cuya descripción abreviada ya exista

string resultado, contenido

if (insercion = "S") then 
	contenido = dw_1.object.descripcion_abr[dw_1.getrow()]
	SELECT descripcion_abr 
	INTO :resultado
	FROM art_ver_tipooperacion 
	WHERE descripcion_abr = :contenido and empresa = :codigo_empresa;
	if (resultado <> "") then	
		messagebox ("El código ya existe",resultado)
		dw_1.object.descripcion_abr[dw_1.getrow()] = ""
		dw_1.object.descripcion[dw_1.getrow()] = ""
		dw_1.Setfocus()
		dw_1.setcolumn("descripcion_abr")
	end if
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_art_ver_tipooperacion
integer x = 55
integer y = 180
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_art_ver_tipooperacion
integer x = 1179
integer y = 168
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_art_ver_tipooperacion
integer x = 1591
integer y = 168
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_art_ver_tipooperacion
integer x = 457
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE TIPO DE OPERACION DE ARTICULOS"
ue_datawindow = "dw_ayuda_art_ver_tipooperacion"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_art_ver_tipooperacion
integer x = 2007
integer y = 168
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_art_ver_tipooperacion
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_art_ver_tipooperacion
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_art_ver_tipooperacion
integer width = 2446
integer height = 84
end type

type pb_calculadora from u_calculadora within w_mant_art_ver_tipooperacion
integer x = 727
integer y = 168
integer width = 114
integer height = 100
integer taborder = 11
boolean originalsize = false
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   art_ver_tipooperacion
Where  art_ver_tipooperacion.empresa = :codigo_empresa;

IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,art_ver_tipooperacion.codigo)+1)
	Into   :sle_valor.text
	From   art_ver_tipooperacion
	Where  art_ver_tipooperacion.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

