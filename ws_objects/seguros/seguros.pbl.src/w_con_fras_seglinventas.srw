$PBExportHeader$w_con_fras_seglinventas.srw
forward
global type w_con_fras_seglinventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_fras_seglinventas
end type
type dw_listado_detalle from datawindow within w_con_fras_seglinventas
end type
type st_6 from statictext within w_con_fras_seglinventas
end type
type uo_cliente from u_em_campo_2 within w_con_fras_seglinventas
end type
type uo_1 from u_manejo_datawindow within w_con_fras_seglinventas
end type
type dw_detalle from u_datawindow_consultas within w_con_fras_seglinventas
end type
type pb_2 from upb_imprimir within w_con_fras_seglinventas
end type
type cobrado from radiobutton within w_con_fras_seglinventas
end type
end forward

global type w_con_fras_seglinventas from w_int_con_empresa
integer width = 2885
integer height = 2048
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
st_6 st_6
uo_cliente uo_cliente
uo_1 uo_1
dw_detalle dw_detalle
pb_2 pb_2
cobrado cobrado
end type
global w_con_fras_seglinventas w_con_fras_seglinventas

type variables
string filtro,moneda,var_tipo


end variables

forward prototypes
public subroutine f_proceso ()
end prototypes

public subroutine f_proceso ();dw_detalle.Reset()
dw_detalle.SetFilter("")
dw_detalle.Filter()
IF cobrado.checked= TRUE Then
	dw_detalle.SetFilter("situacion = '4'")
	dw_detalle.Filter()
END IF
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
end subroutine

event ue_listar;
dw_report  = dw_listado_detalle
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Cansulta facturas declaradas por clientes"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)


end event

on w_con_fras_seglinventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.st_6=create st_6
this.uo_cliente=create uo_cliente
this.uo_1=create uo_1
this.dw_detalle=create dw_detalle
this.pb_2=create pb_2
this.cobrado=create cobrado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.cobrado
end on

on w_con_fras_seglinventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.st_6)
destroy(this.uo_cliente)
destroy(this.uo_1)
destroy(this.dw_detalle)
destroy(this.pb_2)
destroy(this.cobrado)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_fras_seglinventas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_fras_seglinventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_fras_seglinventas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_fras_seglinventas
integer x = 2702
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_listado_detalle from datawindow within w_con_fras_seglinventas
boolean visible = false
integer x = 96
integer width = 494
integer height = 92
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_fras_clientes"
boolean livescroll = true
end type

type st_6 from statictext within w_con_fras_seglinventas
integer y = 140
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_fras_seglinventas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 265
integer y = 136
integer width = 1399
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
f_proceso()
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type uo_1 from u_manejo_datawindow within w_con_fras_seglinventas
integer x = 2158
integer y = 92
integer taborder = 40
end type

event valores;call super::valores;dw_data = dw_detalle
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from u_datawindow_consultas within w_con_fras_seglinventas
integer x = 5
integer y = 248
integer width = 2834
integer height = 1568
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_con_fras_seglinventas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param

IF row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=string(This.GetItemNumber(row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(row,"orden"))
  OpenWithParm(wi_mant_seglinventas,lstr_param) 
End if

end event

type pb_2 from upb_imprimir within w_con_fras_seglinventas
event clicked pbm_bnclicked
integer x = 2638
integer y = 140
integer width = 101
integer height = 84
integer taborder = 20
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type cobrado from radiobutton within w_con_fras_seglinventas
integer x = 1714
integer y = 144
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Cobrado"
boolean automatic = false
boolean lefttext = true
end type

event clicked;IF Checked = TRUE Then
	Checked = FALSE
ELSE
	Checked = TRUE
END IF
f_proceso()
end event

