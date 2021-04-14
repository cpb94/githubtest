$PBExportHeader$w_con_pantallas_articulos.srw
forward
global type w_con_pantallas_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pantallas_articulos
end type
type st_1 from statictext within w_con_pantallas_articulos
end type
type dw_1 from datawindow within w_con_pantallas_articulos
end type
type dw_listado from datawindow within w_con_pantallas_articulos
end type
type pb_imprimir from upb_imprimir within w_con_pantallas_articulos
end type
type pb_2 from upb_carpeta within w_con_pantallas_articulos
end type
type uo_1 from u_em_campo_2 within w_con_pantallas_articulos
end type
type cb_1 from u_boton within w_con_pantallas_articulos
end type
end forward

global type w_con_pantallas_articulos from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 3314
integer height = 2424
pb_1 pb_1
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
pb_2 pb_2
uo_1 uo_1
cb_1 cb_1
end type
global w_con_pantallas_articulos w_con_pantallas_articulos

on w_con_pantallas_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.cb_1
end on

on w_con_pantallas_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Artículos por Pantalla"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;string formula

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	formula = "%"
else
	uo_1.em_codigo.text = uo_1.em_codigo.text
end if
dw_listado.Retrieve(codigo_empresa,uo_1.em_codigo.text)
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pantallas_articulos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pantallas_articulos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pantallas_articulos
integer y = 16
integer width = 3237
integer height = 84
integer textsize = -8
end type

type pb_1 from upb_salir within w_con_pantallas_articulos
integer x = 3104
integer y = 124
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_1 from statictext within w_con_pantallas_articulos
integer x = 18
integer y = 124
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pantalla:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_pantallas_articulos
integer x = 5
integer y = 232
integer width = 3246
integer height = 1960
boolean bringtotop = true
string dataobject = "dw_con_pantallas_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked; str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="w_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"art_ver_op_aplicaciones_articulo"))
  OpenWithParm(w_mant_articulos_tencer,lstr_param)

end event

type dw_listado from datawindow within w_con_pantallas_articulos
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_pantallas_articulos
event clicked pbm_bnclicked
integer x = 2976
integer y = 124
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


Parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type pb_2 from upb_carpeta within w_con_pantallas_articulos
integer x = 997
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;  f_activar_campo(uo_1.em_campo)
  str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_mant_prodpantallas"
  lstr_param.s_argumentos[2]= uo_1.em_codigo.text
  OpenWithParm(wi_mant_formatos,lstr_param)

end event

type uo_1 from u_em_campo_2 within w_con_pantallas_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 120
integer width = 663
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_pantalla

select descripcion
into :des_pantalla
from prodpantallas
where empresa = :codigo_empresa
and  codigo = :uo_1.em_codigo.text;

uo_1.em_campo.text = des_pantalla
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Pantallas"
ue_datawindow ="dw_ayuda_prodpantallas"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_pantallas_articulos
integer x = 2647
integer y = 124
integer width = 315
integer height = 96
integer taborder = 30
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string pantalla

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	pantalla = "%"
else
	pantalla = uo_1.em_campo.text
end if

dw_1.Retrieve(codigo_empresa,pantalla)

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
end event

