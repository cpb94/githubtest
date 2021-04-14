$PBExportHeader$wi_mant_act_ubicaciones.srw
forward
global type wi_mant_act_ubicaciones from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_act_ubicaciones
end type
end forward

global type wi_mant_act_ubicaciones from wi_mvent_con_empresa
integer width = 2615
integer height = 812
pb_calculadora pb_calculadora
end type
global wi_mant_act_ubicaciones wi_mant_act_ubicaciones

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_borrar_espacios ()
end prototypes

public subroutine f_borrar_espacios ();// Eliminamos los espacios
int linea
 
linea = dw_1.getrow()  
IF LINEA > 0 THEN
	dw_1.setitem(linea,"descripcion",trim(dw_1.getitemstring(linea,"descripcion")))	
end if

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Ubicaciones"
valor_empresa = True
istr_parametros.s_listado        = "report_act_ubicaciones"
This.title = istr_parametros.s_titulo_ventana

tipo_mantenimiento = 'C'

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF


end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"ubicacion",sle_valor.text)
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_ubicacion"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_act_ubicaciones.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_act_ubicaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_ubicaciones
integer x = 91
integer y = 352
integer width = 2025
integer height = 164
string dataobject = "dwact_ubicacion"
end type

event dw_1::clicked;call super::clicked;//f_borrar_espacios()
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_ubicaciones
integer x = 251
integer width = 315
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_ubicaciones
integer x = 2149
integer y = 348
end type

event cb_insertar::clicked;String var_descripcion

IF dw_1.GetRow() <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 dw_1.AcceptText()
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"descripcion"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"descripcion",".")
		 END IF
	end if
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_ubicaciones
integer x = 2149
integer y = 444
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_ubicaciones
integer x = 576
string mask = "!!!"
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_ubicacion"
   ue_titulo         = "AYUDA SELECCION UBICACIONES"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_ubicaciones
integer x = 2149
integer y = 536
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_ubicaciones
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_ubicaciones
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_ubicaciones
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_act_ubicaciones
integer x = 832
integer y = 212
integer taborder = 11
boolean originalsize = false
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros,maximo
 Select count(*) Into :registros From act_ubicacion
 Where  act_ubicacion.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(act_ubicacion.ubicacion)+1
  Into   :maximo
  From   act_ubicacion
  Where  act_ubicacion.empresa = :codigo_empresa;
  
  sle_valor.text = String(maximo)
END IF
 dw_1.TriggerEvent("Clicked")
end event

