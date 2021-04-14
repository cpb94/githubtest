$PBExportHeader$w_mant_descoleccion.srw
forward
global type w_mant_descoleccion from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_descoleccion
end type
type r_1 from rectangle within w_mant_descoleccion
end type
end forward

global type w_mant_descoleccion from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2272
integer height = 1568
pb_calculadora pb_calculadora
r_1 r_1
end type
global w_mant_descoleccion w_mant_descoleccion

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

istr_parametros.s_titulo_ventana  = "Mantenimiento de colecciones"

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
//dw_1.setitem(dw_1.getrow(),"fecha",today())

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "descoleccion"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_descoleccion.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.r_1
end on

on w_mant_descoleccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.r_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_descoleccion
integer x = 41
integer y = 280
integer width = 2149
integer height = 1020
string dataobject = "dw_mant_descoleccion"
boolean border = true
end type

event dw_1::itemchanged;call super::itemchanged;string disenyador, comercial, solicitud, tecnico_lab

IF dwo.Name = "disenyador" THEN
	select descripcion
	into :disenyador
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;

	dw_1.object.tecnico_dis_descripcion[row] = disenyador

END IF

IF dwo.Name = "descoleccionsol_comercial" THEN
	select descripcion
	into :comercial
	from comercial
	where empresa = :codigo_empresa
	and codigo = :data;

	dw_1.object.comercial_descripcion[row] = comercial

END IF

IF dwo.Name = "descoleccionsol_tecnico_lab" THEN
	select descripcion
	into :tecnico_lab
	from tecnico_lab
	where empresa = :codigo_empresa
	and codigo = :data;

	dw_1.object.tecnico_lab_descripcion[row] = tecnico_lab

END IF

end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
CASE "disenyador"
	bus_titulo     = "VENTANA SELECCION DISEÑADORES "
	bus_datawindow = "dw_ayuda_tecnicos_dis"
	bus_filtro = ""
CASE "descoleccionsol_comercial"
	bus_titulo     = "VENTANA SELECCION COMERCIALES "
	bus_datawindow = "dw_ayuda_comercial"
	bus_filtro = ""
CASE "descoleccionsol_tecnico_lab"
	bus_titulo     = "VENTANA SELECCION TÉCNICOS "
	bus_datawindow = "dw_ayuda_tecnicos_lab"
	bus_filtro = ""
CASE ELSE
		SetNull(bus_campo)	
END CHOOSE

CALL Super::Key


end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
CASE "disenyador"
	bus_titulo     = "VENTANA SELECCION DISEÑADORES "
	bus_datawindow = "dw_ayuda_tecnicos_dis"
	bus_filtro = ""
CASE "descoleccionsol_comercial"
	bus_titulo     = "VENTANA SELECCION COMERCIALES "
	bus_datawindow = "dw_ayuda_comercial"
	bus_filtro = ""
CASE "descoleccionsol_tecnico_lab"
	bus_titulo     = "VENTANA SELECCION TÉCNICOS "
	bus_datawindow = "dw_ayuda_tecnicos_lab"
	bus_filtro = ""
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_descoleccion
integer x = 55
integer y = 156
integer width = 270
fontcharset fontcharset = ansi!
string facename = "Arial Narrow"
long textcolor = 16777215
long backcolor = 0
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_descoleccion
integer x = 983
integer y = 152
integer width = 389
end type

event cb_insertar::clicked;string campo, motivo
long numero
datawindow dato

IF dw_1.rowcount() > 0 THEN
	dw_1.accepttext()
	IF IsNull(dw_1.object.disenyador[dw_1.getrow()]) or Trim(String(dw_1.object.disenyador[dw_1.getrow()]))="" THEN
		  campo="disenyador"
		  motivo  = "(Campo Obligatorio) Introduzca el diseñador"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.descoleccionsol_comercial[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_comercial[dw_1.getrow()]))="" THEN
		  campo="descoleccionsol_comercial"
		  motivo  = "(Campo Obligatorio) Introduzca el comercial"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.descoleccionsol_grafica[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_grafica[dw_1.getrow()]))="" THEN
		  campo="descoleccionsol_grafica"
		  motivo  = "(Campo Obligatorio) Introduzca el gráfica"
		  dato = dw_1
		  numero = 1
	ELSEIF IsNull(dw_1.object.ambiente[dw_1.getrow()]) or Trim(String(dw_1.object.ambiente[dw_1.getrow()]))="" THEN
		  campo="ambiente"
		  motivo  = "(Campo Obligatorio) Introduzca el ambiente"
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

CALL Super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_descoleccion
integer x = 1376
integer y = 152
integer width = 389
end type

event cb_borrar::clicked;long total

select count(*) 
into :total
from desmodelo
where empresa = :codigo_empresa
and coleccion = :sle_valor.text;

if total > 0 then
	messagebox("Aviso", "No se puede borrar la coleccion porque tiene piezas asociadas")
	return
else
	delete from deshistorico 
	where empresa = :codigo_empresa 
	and coleccion = :sle_valor.text 
	using sqlca;
	
	if SQLCA.SQLCode = -1 then
		rollback using SQlCA;
		MessageBox("SQL error", SQLCA.SQLErrText)
	else
		commit using SQLCA;
	end if
/*	
	select count(*) 
	into :total
	from deshistorico
	where empresa = :codigo_empresa
	and solicitud = :sle_solicitud.text
	and coleccion = :sle_valor.text;
	if total > 0 then
		messagebox("Aviso", "No se puede borrar la coleccion porque quedan registros en el historico.")
		return
	end if
*/	
end if

CALL Super::clicked

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_descoleccion
integer x = 329
integer y = 152
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_descoleccion"
ue_titulo      = "AYUDA SELECCION DE COLECCIONES"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_descoleccion
integer x = 1769
integer y = 152
integer width = 389
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_descoleccion
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_descoleccion
integer x = 5
integer y = 16
integer height = 92
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_descoleccion
integer width = 2222
long textcolor = 255
end type

type pb_calculadora from u_calculadora within w_mant_descoleccion
integer x = 594
integer y = 144
integer taborder = 0
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   descoleccionsol
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   descoleccionsol
		Where  empresa = :codigo_empresa;
	END IF
	dw_1.triggerEvent("clicked")
end if
end event

type r_1 from rectangle within w_mant_descoleccion
integer linethickness = 4
integer x = 46
integer y = 132
integer width = 2144
integer height = 124
end type

