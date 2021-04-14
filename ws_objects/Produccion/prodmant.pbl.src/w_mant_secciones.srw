$PBExportHeader$w_mant_secciones.srw
forward
global type w_mant_secciones from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_secciones
end type
end forward

global type w_mant_secciones from wi_mvent_con_empresa
integer width = 2802
integer height = 920
pb_calculadora pb_calculadora
end type
global w_mant_secciones w_mant_secciones

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_secciones.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_secciones.destroy
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


istr_parametros.s_titulo_ventana = "Mantenimiento de Secciones"
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
tabla         =  "prodsecciones"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_secciones
integer x = 37
integer y = 240
integer width = 2235
integer height = 420
string dataobject = "dw_secciones"
borderstyle borderstyle = stylelowered!
end type

event dw_1::losefocus;// No se permite introducir registros cuya descripción abreviada ya exista

string resultado, contenido

if (insercion = "S") then 
	contenido = dw_1.object.descripcion_abr[dw_1.getrow()]
	SELECT descripcion_abr 
	INTO :resultado
	FROM prodsecciones
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

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_calendarios"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_calendario'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"calendario")
   OpenWithParm(w_mant_calendarios,lstr_param)
END CHOOSE

end event

event dw_1::key;bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "calendario"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE CALENDARIOS"
	bus_datawindow = "dw_ayuda_calendarios"
	bus_filtro     = "" 	
END CHOOSE
CALL Super::Key


end event

event dw_1::rbuttondown;bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "calendario"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE CALENDARIOS"
	bus_datawindow = "dw_ayuda_calendarios"
	bus_filtro     = "" 
END CHOOSE
CALL Super::rbuttondown


end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_secciones
integer y = 124
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_secciones
integer x = 2345
integer y = 272
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_secciones
integer x = 2345
integer y = 376
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_secciones
integer y = 116
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SECCIONES"
ue_datawindow = "dw_ayuda_secciones"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_secciones
integer x = 2345
integer y = 480
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_secciones
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_secciones
integer x = 1289
integer y = 112
integer width = 357
integer height = 56
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_secciones
integer width = 2789
integer height = 76
end type

type pb_calculadora from u_calculadora within w_mant_secciones
integer x = 763
integer y = 112
integer width = 114
integer height = 100
integer taborder = 11
boolean originalsize = false
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   prodsecciones
Where  prodsecciones.empresa = :codigo_empresa;

IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,prodsecciones.codigo)+1)
	Into   :sle_valor.text
	From   prodsecciones
	Where  prodsecciones.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

