$PBExportHeader$w_mant_fechas_entrega.srw
forward
global type w_mant_fechas_entrega from wi_mvent_con_empresa
end type
end forward

global type w_mant_fechas_entrega from wi_mvent_con_empresa
integer width = 1719
integer height = 1984
end type
global w_mant_fechas_entrega w_mant_fechas_entrega

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_fechas_entrega.create
call super::create
end on

on w_mant_fechas_entrega.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Introdducción de Retrasos en Fechas de Entrega"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

end event

event ue_inserta_fila;//dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
//dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
//
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "art_cortes"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event activate;call super::activate;w_mant_fechas_entrega = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_fechas_entrega
integer x = 46
integer y = 316
integer width = 1586
integer height = 1440
string dataobject = "dw_fechas_entrega"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::losefocus;// No se permite introducir registros cuya descripción abreviada ya exista

string resultado, contenido

if (insercion = "S") then 
	contenido = dw_1.object.descripcion_abr[dw_1.getrow()]
	SELECT descripcion_abr 
	INTO :resultado
	FROM art_cortes 
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

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_fechas_entrega
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_fechas_entrega
integer x = 814
integer y = 212
integer width = 389
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_fechas_entrega
boolean visible = false
integer x = 1289
integer y = 452
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_fechas_entrega
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE ARTÍCULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_fechas_entrega
integer x = 1207
integer y = 212
integer width = 389
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_fechas_entrega
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_fechas_entrega
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_fechas_entrega
integer width = 1659
end type

