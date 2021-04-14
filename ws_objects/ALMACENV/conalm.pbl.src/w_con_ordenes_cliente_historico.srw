$PBExportHeader$w_con_ordenes_cliente_historico.srw
forward
global type w_con_ordenes_cliente_historico from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ordenes_cliente_historico
end type
type st_1 from statictext within w_con_ordenes_cliente_historico
end type
type em_cliente from u_em_campo within w_con_ordenes_cliente_historico
end type
type st_nomcliente from statictext within w_con_ordenes_cliente_historico
end type
type dw_listado from datawindow within w_con_ordenes_cliente_historico
end type
type pb_2 from upb_imprimir within w_con_ordenes_cliente_historico
end type
type st_2 from statictext within w_con_ordenes_cliente_historico
end type
type dw_detalle from datawindow within w_con_ordenes_cliente_historico
end type
type dw_consulta from u_datawindow_consultas within w_con_ordenes_cliente_historico
end type
end forward

global type w_con_ordenes_cliente_historico from w_int_con_empresa
integer width = 2930
integer height = 1644
pb_1 pb_1
st_1 st_1
em_cliente em_cliente
st_nomcliente st_nomcliente
dw_listado dw_listado
pb_2 pb_2
st_2 st_2
dw_detalle dw_detalle
dw_consulta dw_consulta
end type
global w_con_ordenes_cliente_historico w_con_ordenes_cliente_historico

type variables
string filtro,moneda

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta ordenes de carga por cliente Historico"
This.title=istr_parametros.s_titulo_ventana

dw_consulta.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)


//dw_report.SetTransObject(SQLCA)

end event

on w_con_ordenes_cliente_historico.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_cliente
this.Control[iCurrent+4]=this.st_nomcliente
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_detalle
this.Control[iCurrent+9]=this.dw_consulta
end on

on w_con_ordenes_cliente_historico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.dw_consulta)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_consulta)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_consulta)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ordenes_cliente_historico
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ordenes_cliente_historico
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_ordenes_cliente_historico
integer x = 27
integer y = 12
integer width = 2679
end type

type pb_1 from upb_salir within w_con_ordenes_cliente_historico
integer x = 2725
integer y = 8
integer width = 128
integer height = 112
integer taborder = 0
boolean default = true
string picturename = "exit!"
end type

type st_1 from statictext within w_con_ordenes_cliente_historico
integer x = 82
integer y = 164
integer width = 224
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
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_con_ordenes_cliente_historico
integer x = 329
integer y = 152
integer width = 411
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF
dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
dw_detalle.reset()
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_con_ordenes_cliente_historico
integer x = 750
integer y = 152
integer width = 1189
integer height = 76
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

type dw_listado from datawindow within w_con_ordenes_cliente_historico
boolean visible = false
integer x = 9
integer width = 389
integer height = 228
boolean bringtotop = true
string dataobject = "report_almcargashis_packing"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_ordenes_cliente_historico
integer x = 2688
integer y = 140
integer width = 123
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\print.bmp"
end type

event clicked;if dw_consulta.Rowcount()<>0 then 

		Integer registro,registros,reg,desde,hasta,bul,var_divisor
		Dec{0}  var_anyo,var_orden,var_linea
				
		var_anyo      = dw_consulta.GetItemNumber(dw_consulta.Getrow(),"anyo")
		var_orden     = dw_consulta.GetItemNumber(dw_consulta.Getrow(),"orden")
				
		dw_listado.Retrieve( codigo_empresa,var_anyo,var_orden )
		f_imprimir_datawindow(dw_listado) 
End if

f_activar_campo(em_cliente)
end event

type st_2 from statictext within w_con_ordenes_cliente_historico
integer x = 1975
integer y = 120
integer width = 709
integer height = 120
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Imprime Packing List de la orden marcada."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_con_ordenes_cliente_historico
event doubleclicked pbm_dwnlbuttondblclk
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 750
integer y = 252
integer width = 2117
integer height = 1160
string dataobject = "dw_con_ordenes_cliente1_historico"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_consulta from u_datawindow_consultas within w_con_ordenes_cliente_historico
integer y = 252
integer width = 750
integer height = 1160
integer taborder = 0
string dataobject = "dw_con_ordenes_cliente_historico"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF This.GetRow() = 0 Then Return
dw_detalle.Retrieve(codigo_empresa,Dec(f_valor_columna(This,This.GetRow(),"anyo")),Dec(f_valor_columna(This,this.GetRow(),"orden")))
end event

