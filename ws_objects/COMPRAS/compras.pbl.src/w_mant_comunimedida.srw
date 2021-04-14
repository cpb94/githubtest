$PBExportHeader$w_mant_comunimedida.srw
forward
global type w_mant_comunimedida from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_comunimedida
end type
end forward

global type w_mant_comunimedida from wi_mvent_con_empresa
integer width = 2651
integer height = 988
string icon = "\bmp\RINO.ICO"
pb_calculadora pb_calculadora
end type
global w_mant_comunimedida w_mant_comunimedida

on w_mant_comunimedida.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_comunimedida.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(sle_valor.text))
criterio[1]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]
tabla         = "comunimedida"

dw_1.Retrieve(sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open; istr_parametros.s_titulo_ventana = "Mantenimiento de Unidades de Medida"
//	istr_parametros.s_listado        = "report_venmateria"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;  dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_comunimedida
integer y = 336
integer width = 2039
integer height = 392
string dataobject = "dw_comunimedida"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_comunimedida
integer x = 178
integer width = 306
string text = "Codigo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_comunimedida
integer x = 2153
integer y = 332
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_comunimedida
integer x = 2153
integer y = 460
string text = "&Borrar  "
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_comunimedida
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comunimedida"
ue_titulo     =  "AYUDA SELECCION DE UNIDADES DE MEDIDA"
ue_filtro     =  ""
isle_campo    = This
valor_empresa = false
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_comunimedida
integer x = 2153
integer y = 592
fontcharset fontcharset = defaultcharset!
string text = "&Salir    "
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_comunimedida
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_comunimedida
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_comunimedida
integer x = 23
integer y = 40
integer height = 100
integer textsize = -14
fontcharset fontcharset = defaultcharset!
long textcolor = 128
end type

type pb_calculadora from u_calculadora within w_mant_comunimedida
integer x = 759
integer y = 208
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From comunimedida;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,comunimedida.codigo)+1)
  Into   :sle_valor.text
  From  comunimedida;
  END IF
 dw_1.TriggerEvent("Clicked")
end event

