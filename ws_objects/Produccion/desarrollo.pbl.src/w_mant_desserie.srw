$PBExportHeader$w_mant_desserie.srw
forward
global type w_mant_desserie from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_desserie
end type
end forward

global type w_mant_desserie from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2309
integer height = 1576
pb_calculadora pb_calculadora
end type
global w_mant_desserie w_mant_desserie

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

istr_parametros.s_titulo_ventana  = "Mantenimiento de Series de Clientes"

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
dw_1.setitem(dw_1.getrow(),"tipo",'NULO')
dw_1.setitem(dw_1.getrow(),"aspecto",'NULO')


end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "desserie"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_desserie.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_desserie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_desserie
integer x = 101
integer y = 260
integer width = 2121
integer height = 1068
integer taborder = 20
string dataobject = "dw_mant_desserie"
end type

event dw_1::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "cliente"
		bus_titulo     = "AYUDA CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "genter.tipoter = 'C'" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event dw_1::rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "cliente"
		bus_titulo     = "AYUDA CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "genter.tipoter = 'C'" 

	CASE "comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event dw_1::itemchanged;call super::itemchanged;string cliente, comercial

IF dwo.Name = "cliente" THEN
//	select descripcion
//	into :cliente
//	from descliente
//	where empresa = :codigo_empresa
//	and codigo = :data;
	
	cliente = f_nombre_cliente (codigo_empresa, 'C', data)

	dw_1.object.genter_razon[row] = cliente

END IF


end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_desserie
integer y = 144
integer width = 242
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_desserie
integer x = 1006
integer y = 132
integer width = 402
end type

event cb_insertar::clicked;string motivo, controles, campo
long numero
datawindow dato

//IF Trim(dw_1.object.descripcion[dw_1.getrow()]) = "" or Trim(dw_1.object.descripcion[dw_1.getrow()])= ""  Then
////  campo   = uo_tipolinea.em_campo
//  motivo  = "(Campo Obligatorio) Introduzca la descripción de la serie"
//  controles = "S"
//END IF
//
//
//IF controles="S" THEN
//	 MessageBox("No se puede grabar la linea",motivo,Exclamation!, OK!,1)
////	 f_activar_campo(campo)
//	 Return
//END IF
//
////////////////////////////////////////////////////////////////////////////////////////////////
IF dw_1.rowcount() > 0 THEN
	dw_1.accepttext()
	IF IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()]))="" THEN
		  campo="descripcion"
		  motivo  = "(Campo Obligatorio) Introduzca la descripción de la serie"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.cliente[dw_1.getrow()]) or Trim(String(dw_1.object.cliente[dw_1.getrow()]))="" THEN
		  campo="cliente"
		  motivo  = "(Campo Obligatorio) Introduzca el cliente"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.ancho[dw_1.getrow()]) or Trim(String(dw_1.object.ancho[dw_1.getrow()]))="" THEN
		  campo="ancho"
		  motivo  = "(Campo Obligatorio) Introduzca el ancho de la serie"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.largo[dw_1.getrow()]) or Trim(String(dw_1.object.largo[dw_1.getrow()]))="" THEN
		  campo="largo"
		  motivo  = "(Campo Obligatorio) Introduzca el largo de la serie"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.tipo[dw_1.getrow()]) or Trim(String(dw_1.object.tipo[dw_1.getrow()]))="" THEN
		  campo="tipo"
		  motivo  = "(Campo Obligatorio) Introduzca el tipo de la serie"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.aspecto[dw_1.getrow()]) or Trim(String(dw_1.object.aspecto[dw_1.getrow()]))="" THEN
		  campo="aspecto"
		  motivo  = "(Campo Obligatorio) Introduzca el aspecto de la serie"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.desserie_rectificada[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_rectificada[dw_1.getrow()]))="" THEN
		  campo="desserie_rectificada"
		  motivo  = "(Campo Obligatorio) Introduzca si la serie es rectificada o no"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.desserie_hay_base[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_hay_base[dw_1.getrow()]))="" THEN
		  campo="desserie_hay_base"
		  motivo  = "(Campo Obligatorio) Introduzca si hay base o no"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.desserie_hay_cliches[dw_1.getrow()]) or Trim(String(dw_1.object.desserie_hay_cliches[dw_1.getrow()]))="" THEN
		  campo="desserie_hay_cliches"
		  motivo  = "(Campo Obligatorio) Introduzca si hay clichés o no"
		  dato = dw_1
		  numero = 1
	END IF
	
	IF Trim(campo)<>"" THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  Return
	END IF
END IF

Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_desserie
integer x = 1413
integer y = 132
integer width = 402
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_desserie
integer x = 343
integer y = 140
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_desserie"
ue_titulo      = "AYUDA SELECCION DE SERIES DE CLIENTES"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_desserie
integer x = 1819
integer y = 132
integer width = 402
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_desserie
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_desserie
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_desserie
integer x = 96
integer y = 24
integer width = 2126
end type

type pb_calculadora from u_calculadora within w_mant_desserie
integer x = 608
integer y = 132
integer taborder = 0
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   desserie	
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   desserie
		Where  empresa = :codigo_empresa;
	END IF
	dw_1.triggerEvent("clicked")
end if


end event

