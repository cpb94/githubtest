$PBExportHeader$w_mant_muestras.srw
forward
global type w_mant_muestras from wi_mvent_con_empresa
end type
end forward

global type w_mant_muestras from wi_mvent_con_empresa
integer height = 948
end type
global w_mant_muestras w_mant_muestras

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_muestras.create
call super::create
end on

on w_mant_muestras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
end choose


istr_parametros.s_titulo_ventana = "Mantenimiento de Muestras"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

end event

event ue_inserta_fila;//dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
//dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "articulos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_muestras
integer x = 69
integer y = 276
integer width = 2226
integer height = 468
string dataobject = "dw_mant_muestras"
borderstyle borderstyle = stylelowered!
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_muestras
integer x = 73
integer y = 156
integer width = 265
integer height = 68
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_muestras
integer x = 1435
integer y = 160
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_muestras
boolean visible = false
integer x = 2341
integer y = 332
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_muestras
integer x = 325
integer y = 148
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA ARTICULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_muestras
integer x = 1851
integer y = 160
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_muestras
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_muestras
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_muestras
integer x = 27
integer y = 36
integer width = 2304
integer height = 84
integer textsize = -12
end type

