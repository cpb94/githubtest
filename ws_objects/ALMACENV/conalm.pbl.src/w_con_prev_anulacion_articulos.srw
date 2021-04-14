$PBExportHeader$w_con_prev_anulacion_articulos.srw
forward
global type w_con_prev_anulacion_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_prev_anulacion_articulos
end type
type dw_listado from datawindow within w_con_prev_anulacion_articulos
end type
type uo_1 from u_manejo_datawindow within w_con_prev_anulacion_articulos
end type
type pb_2 from upb_imprimir within w_con_prev_anulacion_articulos
end type
type dw_articulos from u_datawindow_consultas within w_con_prev_anulacion_articulos
end type
type cbx_1 from checkbox within w_con_prev_anulacion_articulos
end type
type cbx_2 from checkbox within w_con_prev_anulacion_articulos
end type
type cbx_3 from checkbox within w_con_prev_anulacion_articulos
end type
type gb_1 from groupbox within w_con_prev_anulacion_articulos
end type
type cb_1 from u_boton within w_con_prev_anulacion_articulos
end type
end forward

global type w_con_prev_anulacion_articulos from w_int_con_empresa
integer width = 2889
integer height = 1644
pb_1 pb_1
dw_listado dw_listado
uo_1 uo_1
pb_2 pb_2
dw_articulos dw_articulos
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
gb_1 gb_1
cb_1 cb_1
end type
global w_con_prev_anulacion_articulos w_con_prev_anulacion_articulos

type variables
string filtro,anular,fin,ambos



end variables

forward prototypes
public subroutine f_control (datawindow data)
public function string f_filtro ()
end prototypes

public subroutine f_control (datawindow data);data.SetFilter(f_filtro())
data.Filter()

data.Retrieve(codigo_empresa)
end subroutine

public function string f_filtro ();String fil

fil = ""

if cbx_1.checked then
	fil = " prev_anular = 'S' "
end if

if cbx_2.checked then
	IF Trim(fil) = "" then
		fil = " IsDAte(String(fecha_fin)) "
	else
		fil = fil + " and IsDate(string(fecha_fin)) "
	end if
end if

if cbx_3.checked then
	IF Trim(fil) = "" then
		fil = " IsDate(String(fecha_anulado)) "
	else
		fil = fil + " and IsDAte(String(fecha_anulado)) "
	end if
end if


return fil
end function

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Artículos que está previsto Anular"
This.title=istr_parametros.s_titulo_ventana

dw_articulos.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

//f_control(dw_articulos)

end event

on w_con_prev_anulacion_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.uo_1=create uo_1
this.pb_2=create pb_2
this.dw_articulos=create dw_articulos
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_articulos
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.cbx_2
this.Control[iCurrent+8]=this.cbx_3
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cb_1
end on

on w_con_prev_anulacion_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.uo_1)
destroy(this.pb_2)
destroy(this.dw_articulos)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_articulos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_articulos)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prev_anulacion_articulos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prev_anulacion_articulos
integer taborder = 20
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prev_anulacion_articulos
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_prev_anulacion_articulos
integer x = 2679
integer y = 4
integer width = 123
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_con_prev_anulacion_articulos
boolean visible = false
integer x = 37
integer y = 44
integer width = 494
integer height = 124
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_articulos_prev_anular"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_prev_anulacion_articulos
integer x = 2158
integer y = 104
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_articulos
dw_data.SetTransObject(SQLCA)

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_con_prev_anulacion_articulos
integer x = 2633
integer y = 152
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_articulos from u_datawindow_consultas within w_con_prev_anulacion_articulos
integer x = 5
integer y = 300
integer width = 2798
integer height = 1104
integer taborder = 0
string dataobject = "dw_con_prev_anulacion_articulos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cbx_1 from checkbox within w_con_prev_anulacion_articulos
integer x = 160
integer y = 176
integer width = 462
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prev. Anular"
end type

type cbx_2 from checkbox within w_con_prev_anulacion_articulos
integer x = 658
integer y = 176
integer width = 489
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fin Produc."
end type

type cbx_3 from checkbox within w_con_prev_anulacion_articulos
integer x = 1184
integer y = 176
integer width = 489
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Anulado"
end type

type gb_1 from groupbox within w_con_prev_anulacion_articulos
integer x = 87
integer y = 108
integer width = 1646
integer height = 172
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from u_boton within w_con_prev_anulacion_articulos
integer x = 1765
integer y = 156
integer width = 361
integer height = 92
integer taborder = 11
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;f_control(dw_articulos)
end event

