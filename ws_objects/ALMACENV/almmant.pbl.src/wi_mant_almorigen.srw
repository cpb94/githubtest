$PBExportHeader$wi_mant_almorigen.srw
$PBExportComments$Mantenimiento de origenes.
forward
global type wi_mant_almorigen from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_almorigen
end type
end forward

global type wi_mant_almorigen from wi_mvent_con_empresa
integer width = 2395
integer height = 1108
pb_calculadora pb_calculadora
end type
global wi_mant_almorigen wi_mant_almorigen

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Origenes de movimientos"
	istr_parametros.s_listado         = "report_almorigen"
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

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"origen",sle_valor.text)
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "almorigen"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on wi_mant_almorigen.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_almorigen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almorigen
integer y = 384
integer width = 1742
integer height = 384
string dataobject = "dw_almorigen"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almorigen
integer x = 288
integer y = 256
integer width = 251
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almorigen
integer x = 1874
integer y = 384
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almorigen
integer x = 1874
integer y = 504
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almorigen
integer x = 549
integer y = 252
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_almorigen"
ue_titulo      = "AYUDA SELECCION DE ORIGENES DE MOVIMIENTOS"
ue_filtro      = ""
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almorigen
integer x = 1874
integer y = 628
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almorigen
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almorigen
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almorigen
integer width = 2249
end type

type pb_calculadora from u_calculadora within wi_mant_almorigen
integer x = 814
integer y = 248
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   almorigen
 Where  almorigen.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,almorigen.origen)+1)
  Into   :sle_valor.text
  From   almorigen
  Where  almorigen.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

