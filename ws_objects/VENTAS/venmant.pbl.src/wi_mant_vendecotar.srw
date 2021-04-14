$PBExportHeader$wi_mant_vendecotar.srw
$PBExportComments$Mant. Asignacion bases decorados (tarifas).
forward
global type wi_mant_vendecotar from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_vendecotar
end type
type st_nombre_decorado from statictext within wi_mant_vendecotar
end type
type dw_calidades from datawindow within wi_mant_vendecotar
end type
type uo_base from u_em_campo_2 within wi_mant_vendecotar
end type
type gb_1 from groupbox within wi_mant_vendecotar
end type
type uo_decorado from u_em_campo_2 within wi_mant_vendecotar
end type
type st_decorado from statictext within wi_mant_vendecotar
end type
type dw_2 from datawindow within wi_mant_vendecotar
end type
end forward

global type wi_mant_vendecotar from wi_mvent_con_empresa
integer width = 2866
integer height = 1568
st_almacen st_almacen
st_nombre_decorado st_nombre_decorado
dw_calidades dw_calidades
uo_base uo_base
gb_1 gb_1
uo_decorado uo_decorado
st_decorado st_decorado
dw_2 dw_2
end type
global wi_mant_vendecotar wi_mant_vendecotar

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,uo_base.em_codigo.text,sle_valor.Text)
dw_calidades.Retrieve(codigo_empresa,uo_base.em_codigo.text)

end subroutine

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_base.em_codigo.text))
criterio[2]   =  trim(uo_base.em_codigo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "vendecotar"


f_control()

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;uo_base.enabled=TRUE
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento  relacion Modelos a decorados"
istr_parametros.s_listado        = "report_vendecotar"
This.title=istr_parametros.s_titulo_ventana
dw_calidades.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)

f_activar_campo(uo_base.em_campo)
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"base",uo_base.em_codigo.text)
dw_1.setitem(dw_1.getrow(),"decorado",sle_valor.text)





end event

event ue_actualiza_dw;call super::ue_actualiza_dw;dw_calidades.Retrieve(codigo_empresa,uo_base.em_codigo.text)
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;uo_base.enabled=FALSE
end event

on wi_mant_vendecotar.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_decorado=create st_nombre_decorado
this.dw_calidades=create dw_calidades
this.uo_base=create uo_base
this.gb_1=create gb_1
this.uo_decorado=create uo_decorado
this.st_decorado=create st_decorado
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_decorado
this.Control[iCurrent+3]=this.dw_calidades
this.Control[iCurrent+4]=this.uo_base
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.uo_decorado
this.Control[iCurrent+7]=this.st_decorado
this.Control[iCurrent+8]=this.dw_2
end on

on wi_mant_vendecotar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_decorado)
destroy(this.dw_calidades)
destroy(this.uo_base)
destroy(this.gb_1)
destroy(this.uo_decorado)
destroy(this.st_decorado)
destroy(this.dw_2)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vendecotar
integer x = 649
integer y = 560
integer width = 562
integer height = 216
string dataobject = "dw_vendecotar1"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vendecotar
integer x = 27
integer y = 288
integer width = 311
integer height = 80
string text = "Decorado:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vendecotar
integer x = 146
integer y = 1200
integer width = 361
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vendecotar
integer x = 512
integer y = 1200
integer width = 361
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vendecotar
integer x = 366
integer y = 280
integer width = 480
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = "sector = 'S'"
isle_campo    = sle_valor


IF trim(uo_base.em_campo.text)= "" THEN f_activar_campo(uo_base.em_campo)
IF trim(sle_valor.text)  = "" THEN f_control()

end event

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_decorado.text=f_nombre_articulo(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_decorado.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vendecotar
integer x = 878
integer y = 1200
integer width = 361
boolean cancel = false
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vendecotar
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vendecotar
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vendecotar
integer width = 1847
end type

type st_almacen from statictext within wi_mant_vendecotar
integer x = 27
integer y = 180
integer width = 302
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Base:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_decorado from statictext within wi_mant_vendecotar
integer x = 855
integer y = 288
integer width = 745
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_calidades from datawindow within wi_mant_vendecotar
integer x = 119
integer y = 420
integer width = 1147
integer height = 756
boolean bringtotop = true
string dataobject = "dw_vendecotar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF  row = 0 Then Return
IF cb_insertar.enabled  =  TRUE Then Return

uo_base.em_codigo.text  =  This.GetItemString(row,"vendecotar_base")
sle_valor.text  =  This.GetItemString(Row,"vendecotar_decorado")
Parent.TriggerEvent("ue_recuperar")
sle_valor.TriggerEvent("modificado")
f_control()
f_activar_campo(sle_valor)
end event

type uo_base from u_em_campo_2 within wi_mant_vendecotar
event destroy ( )
integer x = 357
integer y = 156
integer width = 709
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_base.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
 ue_datawindow = "dw_ayuda_articulos"
 ue_filtro     = "sector = 'S'"
 isle_campo    = uo_base.em_campo
 
 sle_valor.Text = ""
 f_control()
   
 IF istr_parametros.i_nargumentos>1 THEN
	  uo_base.em_campo.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(uo_base.em_codigo)
     uo_base.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     IF Trim(sle_valor.text)<>"" and Trim(uo_base.em_codigo.text)<>"" THEN
          dw_1.retrieve(uo_base.em_codigo.text,sle_valor.text)
       
     END IF
     istr_parametros.i_nargumentos=0
 END IF







end event

event modificado;call super::modificado;uo_base.em_campo.text=f_nombre_articulo(codigo_empresa,uo_base.em_codigo.text)
IF Trim(uo_base.em_campo.text)="" THEN 
 IF Trim(uo_base.em_codigo.text)<>"" Then uo_base.em_campo.SetFocus()
 uo_base.em_campo.text=""
 uo_base.em_codigo.text=""
 Return
END IF
end event

type gb_1 from groupbox within wi_mant_vendecotar
integer x = 137
integer y = 1164
integer width = 1115
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_decorado from u_em_campo_2 within wi_mant_vendecotar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1833
integer y = 292
integer width = 709
end type

event modificado;call super::modificado;uo_decorado.em_campo.text=f_nombre_articulo(codigo_empresa,uo_decorado.em_codigo.text)

IF Trim(uo_decorado.em_campo.text)="" THEN 
 IF Trim(uo_decorado.em_codigo.text)<>"" Then uo_decorado.em_campo.SetFocus()
 uo_decorado.em_campo.text=""
 uo_decorado.em_codigo.text=""
 Return
END IF

dw_2.Retrieve(codigo_empresa,uo_decorado.em_codigo.text)
end event

event getfocus;call super::getfocus; uo_decorado.em_campo.text=""
 uo_decorado.em_codigo.text=""

 ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
 ue_datawindow = "dw_ayuda_articulos"
 ue_filtro     = "sector = 'S'"
 isle_campo      = uo_decorado.em_campo
	  

end event

on uo_decorado.destroy
call u_em_campo_2::destroy
end on

type st_decorado from statictext within wi_mant_vendecotar
integer x = 1833
integer y = 196
integer width = 709
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Consulta por Decorado"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_2 from datawindow within wi_mant_vendecotar
integer x = 1623
integer y = 416
integer width = 1147
integer height = 756
boolean bringtotop = true
string dataobject = "dw_vendecora"
boolean border = false
boolean livescroll = true
end type

event clicked;IF  row = 0 Then Return

uo_base.em_codigo.text  =  This.GetItemString(row,"vendecotar_base")
uo_base.TriggerEvent("modificado")
sle_valor.text = ""
f_control()
f_activar_campo(sle_valor)
end event

