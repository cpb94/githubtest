$PBExportHeader$wi_mant_calidades.srw
$PBExportComments$Mant. calidades.
forward
global type wi_mant_calidades from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_calidades
end type
end forward

global type wi_mant_calidades from wi_mvent_con_empresa
integer width = 2354
integer height = 1024
pb_calculadora pb_calculadora
end type
global wi_mant_calidades wi_mant_calidades

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"incremento","N")
	dw_1.setitem(dw_1.getrow(),"tono","S")
	dw_1.setitem(dw_1.getrow(),"calibre","S")
end event

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Calidades"
	istr_parametros.s_listado        = "report_calidades"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "calidades"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on wi_mant_calidades.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_calidades.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_calidades
integer x = 59
integer y = 336
integer width = 1778
integer height = 464
string dataobject = "dw_calidades"
end type

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipoalm"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almtipoalm"
   CASE "codcli"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = "tipoter ='C'"
 		bus_datawindow = "dw_ayuda_clipro"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_calidades
integer x = 302
integer width = 283
string text = "Calidad"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_calidades
integer x = 1861
integer y = 332
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_calidades
integer x = 1861
integer y = 452
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_calidades
integer x = 590
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_calidades"
ue_titulo     =  "AYUDA SELECCION DE CALIDADES"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_calidades
integer x = 1861
integer y = 572
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_calidades
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_calidades
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_calidades
integer width = 2149
end type

type pb_calculadora from u_calculadora within wi_mant_calidades
integer x = 855
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From calidades
 Where  calidades.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,calidades.codigo)+1)
  Into   :sle_valor.text
  From   calidades
  Where  calidades.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

