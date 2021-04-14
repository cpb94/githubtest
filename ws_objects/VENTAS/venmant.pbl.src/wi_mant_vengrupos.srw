$PBExportHeader$wi_mant_vengrupos.srw
$PBExportComments$Mant. de gupos de clientes.
forward
global type wi_mant_vengrupos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_vengrupos
end type
end forward

global type wi_mant_vengrupos from wi_mvent_con_empresa
integer width = 2153
pb_calculadora pb_calculadora
end type
global wi_mant_vengrupos wi_mant_vengrupos

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de grupos"
	istr_parametros.s_listado        = "report_vengrupos"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
          This.TriggerEvent("ue_recuperar")
      END IF
  END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "vengrupos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_vengrupos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_vengrupos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vengrupos
integer x = 23
integer y = 336
integer width = 1504
integer height = 336
string dataobject = "dw_vengrupos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vengrupos
integer x = 155
integer y = 220
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vengrupos
integer x = 1632
integer y = 340
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vengrupos
integer x = 1632
integer y = 460
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vengrupos
integer x = 443
integer y = 216
integer height = 80
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_vengrupos"
ue_titulo     =  "AYUDA SELECCION GRUPOS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vengrupos
integer x = 1632
integer y = 580
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vengrupos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vengrupos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vengrupos
integer width = 2016
end type

type pb_calculadora from u_calculadora within wi_mant_vengrupos
integer x = 709
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From vengrupos
 Where  vengrupos.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,vengrupos.codigo)+1)
  Into   :sle_valor.text
  From   vengrupos
  Where  vengrupos.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

