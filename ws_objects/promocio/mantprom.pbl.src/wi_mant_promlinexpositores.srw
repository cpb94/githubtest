$PBExportHeader$wi_mant_promlinexpositores.srw
$PBExportComments$Lineas tipo de paneles y clases de paneles por expositor
forward
global type wi_mant_promlinexpositores from wi_mvent_con_empresa
end type
type uo_expositor from u_em_campo_2 within wi_mant_promlinexpositores
end type
type st_3 from statictext within wi_mant_promlinexpositores
end type
type st_nombre_tipopanel from statictext within wi_mant_promlinexpositores
end type
type dw_paneles from u_datawindow_consultas within wi_mant_promlinexpositores
end type
type dw_detalle from datawindow within wi_mant_promlinexpositores
end type
end forward

global type wi_mant_promlinexpositores from wi_mvent_con_empresa
integer width = 2944
integer height = 1664
uo_expositor uo_expositor
st_3 st_3
st_nombre_tipopanel st_nombre_tipopanel
dw_paneles dw_paneles
dw_detalle dw_detalle
end type
global wi_mant_promlinexpositores wi_mant_promlinexpositores

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_expositor.em_codigo.text))
criterio[2]   =  trim(uo_expositor.em_codigo.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "promexpositores"

dw_1.Retrieve(codigo_empresa,uo_expositor.em_codigo.text,sle_valor.Text)

CALL Super::ue_recuperar

String var_medida=""

IF dw_1.GetRow()<>0 then
   var_medida = dw_1.GetItemString(dw_1.GetRow(),"medida")
End if
dw_detalle.Retrieve(codigo_empresa,var_medida)
end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de paneles por expositor"
	istr_parametros.s_listado        = "report_promlinexpositores"
   This.title = istr_parametros.s_titulo_ventana
   dw_paneles.SetTransObject(Sqlca)
	dw_detalle.SetTransObject(Sqlca)
	   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_expositor.em_codigo.text = istr_parametros.s_argumentos[2]
		uo_expositor.em_campo.text= f_nombre_promexpositores(codigo_empresa,uo_expositor.em_codigo.text)
		uo_expositor.TriggerEvent("modificado")
		sle_valor.text = istr_parametros.s_argumentos[3]
		istr_parametros.i_nargumentos = 0
		This.TriggerEvent("ue_recuperar")
		Return
   END IF
   

	
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",uo_expositor.em_codigo.text)
   dw_1.setitem(dw_1.getrow(),"tipo",sle_valor.text)
  
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;dw_paneles.enabled = FALSE
uo_expositor.enabled = FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;dw_paneles.enabled = TRUE
uo_expositor.enabled = TRUE
end event

on wi_mant_promlinexpositores.create
int iCurrent
call super::create
this.uo_expositor=create uo_expositor
this.st_3=create st_3
this.st_nombre_tipopanel=create st_nombre_tipopanel
this.dw_paneles=create dw_paneles
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_expositor
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_nombre_tipopanel
this.Control[iCurrent+4]=this.dw_paneles
this.Control[iCurrent+5]=this.dw_detalle
end on

on wi_mant_promlinexpositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_expositor)
destroy(this.st_3)
destroy(this.st_nombre_tipopanel)
destroy(this.dw_paneles)
destroy(this.dw_detalle)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promlinexpositores
integer x = 18
integer y = 292
integer width = 2377
integer height = 548
string dataobject = "dw_promlinexpositores"
end type

event dw_1::key; bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "medida"
      bus_titulo     = "VENTANA SELECCION MEDIDAS PANELES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_prommedidas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end event

event dw_1::rbuttondown; bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "medida"
      bus_titulo     = "VENTANA SELECCION MEDIDAS PANELES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_prommedidas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow


CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_medida'
   lstr_param.i_nargumentos    = 3
	lstr_param.s_argumentos[2]= sle_valor.text
	lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"medida")
   OpenWithParm(wi_mant_prommedidas,lstr_param)  
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promlinexpositores
integer x = 1285
integer y = 184
string text = "Tipo Panel:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promlinexpositores
integer x = 2427
integer y = 292
end type

event cb_insertar::clicked;call super::clicked;uo_expositor.TriggerEvent("modificado")
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promlinexpositores
integer x = 2427
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promlinexpositores
integer x = 1659
integer y = 172
integer taborder = 30
end type

event sle_valor::getfocus;call super::getfocus;IF Trim(uo_expositor.em_campo.text) = "" Then f_activar_campo(uo_expositor.em_campo)
ue_datawindow =  "dw_ayuda_promtipopanel"
ue_titulo     =  "AYUDA SELECCION TIPO PANELES"
ue_filtro     =  ""
isle_campo    = This



end event

event sle_valor::modificado;call super::modificado;st_nombre_tipopanel.text=f_nombre_tipopanel(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_tipopanel.text)="" THEN 
  IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
  sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promlinexpositores
integer x = 2427
integer y = 532
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promlinexpositores
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promlinexpositores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promlinexpositores
integer width = 2816
end type

type uo_expositor from u_em_campo_2 within wi_mant_promlinexpositores
integer x = 357
integer y = 176
integer width = 910
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_expositor.em_campo.text=f_nombre_promexpositores(codigo_empresa,uo_expositor.em_codigo.text)
IF Trim(uo_expositor.em_campo.text)="" THEN 
 IF Trim(uo_expositor.em_codigo.text)<>"" Then uo_expositor.em_campo.SetFocus()
 uo_expositor.em_campo.text=""
 uo_expositor.em_codigo.text=""
END IF
dw_paneles.Retrieve(codigo_empresa,uo_expositor.em_codigo.text)

 
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de expositores"
ue_datawindow = "dw_ayuda_promexpositores"
ue_filtro     = ""
end on

on uo_expositor.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_promlinexpositores
integer x = 50
integer y = 184
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Expositor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_tipopanel from statictext within wi_mant_promlinexpositores
integer x = 1929
integer y = 176
integer width = 914
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_paneles from u_datawindow_consultas within wi_mant_promlinexpositores
integer x = 23
integer y = 840
integer width = 1317
integer height = 560
integer taborder = 0
boolean titlebar = true
string title = "Tipos de panel por expositor"
string dataobject = "dw_promlinexpositores2"
boolean vscrollbar = true
end type

event clicked;call super::clicked;IF row =0 Then 
 f_activar_campo(uo_expositor.em_campo)
 Return
END IF

String var_medida

sle_valor.text = This.GetItemString(row,"tipo")
var_medida = This.GetItemString(Row,"medida")

dw_detalle.Retrieve(codigo_empresa,var_medida)

sle_valor.TriggerEvent("modificado")
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type dw_detalle from datawindow within wi_mant_promlinexpositores
integer x = 1344
integer y = 840
integer width = 1490
integer height = 560
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle clase de paneles "
string dataobject = "dw_con_promclasemedidas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

