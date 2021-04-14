$PBExportHeader$w_generar_calendarios.srw
forward
global type w_generar_calendarios from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_generar_calendarios
end type
end forward

global type w_generar_calendarios from wi_mvent_con_empresa
integer width = 2651
integer height = 804
pb_calculadora pb_calculadora
end type
global w_generar_calendarios w_generar_calendarios

type variables
boolean volver_a_descripcion_abr
end variables

on w_generar_calendarios.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_generar_calendarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		cb_insertar.visible = false
		cb_borrar.visible = false
		pb_calculadora.visible = false
end choose



istr_parametros.s_titulo_ventana = "Mantenimiento calendarios"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)


end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodcalendarios"

dw_1.Retrieve(sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event activate;call super::activate;w_generar_calendarios = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_generar_calendarios
integer x = 46
integer y = 328
integer width = 1998
integer height = 192
string dataobject = "dw_generar_calendarios"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_generar_calendarios
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_generar_calendarios
integer x = 2094
integer y = 240
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_generar_calendarios
integer x = 2098
integer y = 364
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_generar_calendarios
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE CALENDARIOS"
ue_datawindow = "dw_ayuda_calendarios"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = false

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_generar_calendarios
integer x = 2098
integer y = 472
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_generar_calendarios
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_generar_calendarios
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_generar_calendarios
integer x = 9
integer width = 2642
integer height = 84
end type

type pb_calculadora from u_calculadora within w_generar_calendarios
integer x = 763
integer y = 204
integer width = 114
integer height = 100
integer taborder = 11
boolean originalsize = false
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   prodcalendarios;

IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,codigo)+1)
	Into   :sle_valor.text
	From   prodcalendarios;
END IF
dw_1.triggerEvent("clicked")
  
end event

