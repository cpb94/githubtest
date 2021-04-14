$PBExportHeader$wi_mant_act_tipobien.srw
forward
global type wi_mant_act_tipobien from wi_mvent_con_empresa
end type
end forward

global type wi_mant_act_tipobien from wi_mvent_con_empresa
integer width = 2354
integer height = 936
end type
global wi_mant_act_tipobien wi_mant_act_tipobien

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

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Tipos de Amortización"
valor_empresa = True
istr_parametros.s_listado        = "report_act_tipobien"
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
   dw_1.setitem(dw_1.getrow(),"tipo_bien",sle_valor.text)
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_tipobien"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_act_tipobien.create
call super::create
end on

on wi_mant_act_tipobien.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_tipobien
integer x = 91
integer y = 352
integer width = 1559
integer height = 296
string dataobject = "dwact_tipobien"
end type

event dw_1::clicked;call super::clicked;//f_borrar_espacios()
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_tipobien
integer x = 251
integer width = 315
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_tipobien
integer x = 1682
integer y = 352
end type

event cb_insertar::clicked;String var_descripcion

IF dw_1.GetRow() <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 dw_1.AcceptText()
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"descripcion"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"descripcion",".")
		 END IF
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"requiere_anyo"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"requiere_anyo","N")
		 END IF
	end if
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_tipobien
integer x = 1682
integer y = 448
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_tipobien
integer x = 576
string mask = "!!"
string displaydata = ""
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_tipobien"
   ue_titulo         = "AYUDA SELECCION TIPOS BIENES"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_tipobien
integer x = 1682
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_tipobien
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_tipobien
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_tipobien
integer width = 2299
end type

