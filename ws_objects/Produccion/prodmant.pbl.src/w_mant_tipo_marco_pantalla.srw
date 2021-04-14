$PBExportHeader$w_mant_tipo_marco_pantalla.srw
forward
global type w_mant_tipo_marco_pantalla from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_tipo_marco_pantalla
end type
type dw_listado from datawindow within w_mant_tipo_marco_pantalla
end type
type pb_1 from picturebutton within w_mant_tipo_marco_pantalla
end type
end forward

global type w_mant_tipo_marco_pantalla from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2249
integer height = 1596
pb_calculadora pb_calculadora
dw_listado dw_listado
pb_1 pb_1
end type
global w_mant_tipo_marco_pantalla w_mant_tipo_marco_pantalla

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

dw_listado.SetTransObject(SQLCA)

istr_parametros.s_titulo_ventana  = "Mantenimiento de Tipos de Marcos de Pantallas"

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
tabla         =  "prodtipomarcopantalla"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_tipo_marco_pantalla.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_listado=create dw_listado
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_1
end on

on w_mant_tipo_marco_pantalla.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_listado)
destroy(this.pb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_tipo_marco_pantalla
integer x = 41
integer y = 284
integer width = 2094
integer height = 1040
string dataobject = "dw_mant_tipo_marco_pantalla"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_tipo_marco_pantalla
integer x = 14
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_tipo_marco_pantalla
integer x = 919
integer y = 172
integer width = 347
end type

event cb_insertar::clicked;String descrip
IF this.enabled then
	dw_1.accepttext()
	descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción del cliente")
		dw_1.SetFocus()
		return
	end if
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_tipo_marco_pantalla
integer x = 1280
integer y = 172
integer width = 347
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_tipo_marco_pantalla
integer x = 288
integer y = 172
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodtipomarcopantallas"
ue_titulo      = "AYUDA SELECCION DE TIPO DE MARCO"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_tipo_marco_pantalla
integer x = 1641
integer y = 172
integer width = 347
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_tipo_marco_pantalla
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_tipo_marco_pantalla
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_tipo_marco_pantalla
integer width = 2126
integer textsize = -12
end type

type pb_calculadora from u_calculadora within w_mant_tipo_marco_pantalla
integer x = 553
integer y = 164
integer taborder = 0
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   prodtipomarcopantalla	
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   prodtipomarcopantalla
		Where  empresa = :codigo_empresa;
	END IF
	dw_1.triggerEvent("clicked")
end if
end event

type dw_listado from datawindow within w_mant_tipo_marco_pantalla
boolean visible = false
integer x = 1211
integer y = 640
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_listado_prodtipomarcopantallas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_mant_tipo_marco_pantalla
integer x = 2016
integer y = 172
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;dw_listado.retrieve(codigo_empresa)
f_imprimir_datawindow(dw_listado)
end event

