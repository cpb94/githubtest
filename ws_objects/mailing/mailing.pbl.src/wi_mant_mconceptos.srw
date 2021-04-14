$PBExportHeader$wi_mant_mconceptos.srw
forward
global type wi_mant_mconceptos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_mconceptos
end type
type gb_1 from groupbox within wi_mant_mconceptos
end type
type dw_2 from datawindow within wi_mant_mconceptos
end type
type pb_1 from upb_salir within wi_mant_mconceptos
end type
end forward

global type wi_mant_mconceptos from wi_mvent_con_empresa
integer width = 2935
integer height = 1696
pb_calculadora pb_calculadora
gb_1 gb_1
dw_2 dw_2
pb_1 pb_1
end type
global wi_mant_mconceptos wi_mant_mconceptos

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "mconceptos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento conceptos mailing"
	istr_parametros.s_listado        = "report_conceptos"
   This.title = istr_parametros.s_titulo_ventana
	
	dw_2.SetTransobject(sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

   dw_2.Retrieve(codigo_empresa)	
	f_activar_campo(sle_valor)
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_mconceptos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
this.dw_2=create dw_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.pb_1
end on

on wi_mant_mconceptos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.pb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_mconceptos
integer x = 151
integer y = 336
integer width = 2345
integer height = 280
string dataobject = "dw_mconceptos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_mconceptos
integer x = 315
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_mconceptos
integer x = 1344
integer y = 212
integer width = 379
integer height = 80
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_mconceptos
integer x = 1723
integer y = 212
integer width = 379
integer height = 80
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_mconceptos
integer x = 617
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_mconceptos"
ue_titulo     =  "AYUDA SELECCION CONCETOS MAILING"
ue_filtro     =  ""
isle_campo    = This

dw_2.Retrieve(codigo_empresa)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_mconceptos
integer x = 2103
integer y = 212
integer width = 379
integer height = 80
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_mconceptos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_mconceptos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_mconceptos
integer width = 2149
end type

type pb_calculadora from u_calculadora within wi_mant_mconceptos
integer x = 878
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From mconceptos
 Where  mconceptos.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,mconceptos.codigo)+1)
  Into   :sle_valor.text
  From   mconceptos
  Where  mconceptos.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type gb_1 from groupbox within wi_mant_mconceptos
integer x = 1330
integer y = 176
integer width = 1166
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from datawindow within wi_mant_mconceptos
integer x = 151
integer y = 616
integer width = 2345
integer height = 808
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle conceptos Mailing"
string dataobject = "dw_lista_mconceptos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row=0 then return
String codigo
codigo = dw_2.GetItemString(row,"codigo")

sle_valor.text = codigo
parent.TriggerEvent("ue_recuperar")

end event

type pb_1 from upb_salir within wi_mant_mconceptos
integer x = 2779
integer y = 16
integer width = 110
integer height = 96
boolean originalsize = true
string picturename = "exit!"
end type

