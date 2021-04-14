$PBExportHeader$w_mant_fechas_entrega_iniciales.srw
forward
global type w_mant_fechas_entrega_iniciales from wi_mvent_con_empresa
end type
end forward

global type w_mant_fechas_entrega_iniciales from wi_mvent_con_empresa
integer width = 3666
integer height = 1940
end type
global w_mant_fechas_entrega_iniciales w_mant_fechas_entrega_iniciales

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_fechas_entrega_iniciales.create
call super::create
end on

on w_mant_fechas_entrega_iniciales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Introducción de Fechas de Entrega"
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

event activate;call super::activate;w_mant_fechas_entrega_iniciales = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_fechas_entrega_iniciales
integer x = 46
integer y = 248
integer width = 3529
integer height = 1440
string dataobject = "dw_fechas_entrega_iniciales"
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

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_fechas_entrega_iniciales
integer y = 148
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_fechas_entrega_iniciales
integer x = 2770
integer y = 136
integer width = 389
end type

event cb_insertar::clicked;long i
if dw_1.RowCount() > 0 then
	dw_1.accepttext()
	for i = 1 to dw_1.Rowcount() 
		if string(dw_1.object.venliped_fecha_entrega5[i], "dd-mm-yyyy") <> '00-00-0000' and not isnull(dw_1.object.venliped_fecha_entrega5[i]) then
			dw_1.object.venliped_fentrega[i] = dw_1.object.venliped_fecha_entrega5[i] 
		elseif string(dw_1.object.venliped_fecha_entrega4[i], "dd-mm-yyyy") <> '00-00-0000' and not isnull(dw_1.object.venliped_fecha_entrega4[i]) then
			dw_1.object.venliped_fentrega[i] = dw_1.object.venliped_fecha_entrega4[i] 
		elseif string(dw_1.object.venliped_fecha_entrega3[i], "dd-mm-yyyy") <> '00-00-0000' and not isnull(dw_1.object.venliped_fecha_entrega3[i]) then
			dw_1.object.venliped_fentrega[i] = dw_1.object.venliped_fecha_entrega3[i] 
		elseif string(dw_1.object.venliped_fecha_entrega2[i], "dd-mm-yyyy") <> '00-00-0000' and not isnull(dw_1.object.venliped_fecha_entrega2[i]) then
			dw_1.object.venliped_fentrega[i] = dw_1.object.venliped_fecha_entrega2[i] 
		else 
			dw_1.object.venliped_fentrega[i] = dw_1.object.venliped_fentrega_inicial[i] 
		end if
	next
end if

 CALL Super::clicked

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_fechas_entrega_iniciales
boolean visible = false
integer x = 1696
integer y = 1068
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_fechas_entrega_iniciales
integer y = 144
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE ARTÍCULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_fechas_entrega_iniciales
integer x = 3163
integer y = 136
integer width = 389
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_fechas_entrega_iniciales
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_fechas_entrega_iniciales
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_fechas_entrega_iniciales
integer y = 12
integer width = 3561
end type

