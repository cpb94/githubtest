$PBExportHeader$w_con_ubicaciones_pantallas_prod.srw
forward
global type w_con_ubicaciones_pantallas_prod from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ubicaciones_pantallas_prod
end type
type dw_1 from datawindow within w_con_ubicaciones_pantallas_prod
end type
type pb_imprimir from upb_imprimir within w_con_ubicaciones_pantallas_prod
end type
type cb_1 from u_boton within w_con_ubicaciones_pantallas_prod
end type
type sle_ubicaciond from singlelineedit within w_con_ubicaciones_pantallas_prod
end type
type st_1 from statictext within w_con_ubicaciones_pantallas_prod
end type
type sle_ubicacionh from singlelineedit within w_con_ubicaciones_pantallas_prod
end type
type st_2 from statictext within w_con_ubicaciones_pantallas_prod
end type
end forward

global type w_con_ubicaciones_pantallas_prod from w_int_con_empresa
integer x = 187
integer y = 4
integer width = 2912
integer height = 3372
pb_1 pb_1
dw_1 dw_1
pb_imprimir pb_imprimir
cb_1 cb_1
sle_ubicaciond sle_ubicaciond
st_1 st_1
sle_ubicacionh sle_ubicacionh
st_2 st_2
end type
global w_con_ubicaciones_pantallas_prod w_con_ubicaciones_pantallas_prod

on w_con_ubicaciones_pantallas_prod.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.sle_ubicaciond=create sle_ubicaciond
this.st_1=create st_1
this.sle_ubicacionh=create sle_ubicacionh
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.sle_ubicaciond
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_ubicacionh
this.Control[iCurrent+8]=this.st_2
end on

on w_con_ubicaciones_pantallas_prod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.sle_ubicaciond)
destroy(this.st_1)
destroy(this.sle_ubicacionh)
destroy(this.st_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Ubcaciones de Pantallas de Producción"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)


sle_ubicaciond.text = '1'
sle_ubicacionh.text = '999999'
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubicaciones_pantallas_prod
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubicaciones_pantallas_prod
integer x = 73
integer y = 132
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubicaciones_pantallas_prod
integer width = 2816
integer height = 80
end type

type pb_1 from upb_salir within w_con_ubicaciones_pantallas_prod
integer x = 2693
integer y = 124
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_1 from datawindow within w_con_ubicaciones_pantallas_prod
integer x = 9
integer y = 228
integer width = 2839
integer height = 2912
boolean bringtotop = true
string dataobject = "dw_con_ubicaciones_pantallas_prod"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_imprimir from upb_imprimir within w_con_ubicaciones_pantallas_prod
event clicked pbm_bnclicked
integer x = 2578
integer y = 124
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF

PArent.triggerEvent("ue_listar")
//f_activar_campo(uo_1.em_campo)
end event

type cb_1 from u_boton within w_con_ubicaciones_pantallas_prod
integer x = 2258
integer y = 124
integer width = 315
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string filtro

filtro = ''

if sle_ubicaciond.text = '' or isnull(sle_ubicaciond.text) or sle_ubicacionh.text = '' or isnull(sle_ubicacionh.text)  then
	filtro = ''
else
	filtro = " ubicacion >= "+sle_ubicaciond.text+ " and ubicacion <= "+sle_ubicacionh.text
end if

dw_1.Retrieve(codigo_empresa)

dw_1.setfilter (filtro)
dw_1.filter()

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if



end event

type sle_ubicaciond from singlelineedit within w_con_ubicaciones_pantallas_prod
integer x = 731
integer y = 140
integer width = 261
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type st_1 from statictext within w_con_ubicaciones_pantallas_prod
integer x = 50
integer y = 136
integer width = 663
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Desde Ubicación:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ubicacionh from singlelineedit within w_con_ubicaciones_pantallas_prod
integer x = 1307
integer y = 140
integer width = 261
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type st_2 from statictext within w_con_ubicaciones_pantallas_prod
integer x = 1029
integer y = 136
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

