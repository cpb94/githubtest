$PBExportHeader$w_con_packing_list_pedidos.srw
forward
global type w_con_packing_list_pedidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_packing_list_pedidos
end type
type pb_2 from upb_imprimir within w_con_packing_list_pedidos
end type
type st_2 from statictext within w_con_packing_list_pedidos
end type
type em_cliente from u_em_campo within w_con_packing_list_pedidos
end type
type st_nombre_cliente from statictext within w_con_packing_list_pedidos
end type
type dw_listado from datawindow within w_con_packing_list_pedidos
end type
type dw_detalle from u_datawindow_consultas within w_con_packing_list_pedidos
end type
type gb_3 from groupbox within w_con_packing_list_pedidos
end type
type gb_2 from groupbox within w_con_packing_list_pedidos
end type
type gb_1 from groupbox within w_con_packing_list_pedidos
end type
type rb_1 from radiobutton within w_con_packing_list_pedidos
end type
type rb_2 from radiobutton within w_con_packing_list_pedidos
end type
type cb_1 from commandbutton within w_con_packing_list_pedidos
end type
end forward

global type w_con_packing_list_pedidos from w_int_con_empresa
integer width = 3557
integer height = 1996
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
dw_listado dw_listado
dw_detalle dw_detalle
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
cb_1 cb_1
end type
global w_con_packing_list_pedidos w_con_packing_list_pedidos

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_cliente.text)
dw_detalle.SetRedraw(TRUE)
if rb_1.checked = true then 
   dw_detalle.SetSort("empresa A, anyo A,pedido A,articulos_descripcion A")
else
	dw_detalle.SetSort("empresa A, venliped_numpalet A,articulos_descripcion A")
end if
dw_detalle.sort()
dw_detalle.groupcalc()


end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Packing List de pedidos por Cliente"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
rb_2.checked = true
end event

event ue_listar;dw_report  = dw_detalle
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,em_cliente.text)
dw_report.sort()
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_packing_list_pedidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_cliente
this.Control[iCurrent+5]=this.st_nombre_cliente
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.cb_1
end on

on w_con_packing_list_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_packing_list_pedidos
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_packing_list_pedidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_packing_list_pedidos
integer x = 9
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_packing_list_pedidos
integer x = 3369
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_packing_list_pedidos
integer x = 1824
integer y = 280
integer width = 123
integer taborder = 60
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;PArent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_packing_list_pedidos
integer x = 41
integer y = 144
integer width = 238
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
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_con_packing_list_pedidos
integer x = 297
integer y = 140
integer width = 549
integer taborder = 10
long backcolor = 33551858
end type

event modificado;call super::modificado;long reg
 
st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
if Trim(st_nombre_cliente.text)="" Then
	IF len( st_nombre_cliente.text) <> 0 Then f_activar_campo(em_cliente)
	em_cliente.text = ""
	return
End If





 



end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""



 
        
end event

type st_nombre_cliente from statictext within w_con_packing_list_pedidos
integer x = 859
integer y = 140
integer width = 1367
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_packing_list_pedidos
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_pedidos_cliente"
boolean livescroll = true
end type

type dw_detalle from u_datawindow_consultas within w_con_packing_list_pedidos
integer x = 5
integer y = 416
integer width = 3465
integer height = 1324
integer taborder = 0
string dataobject = "dw_con_packing_list_pedidos"
boolean vscrollbar = true
end type

event ue_valores;ue_marca_linea = FALSE
end event

type gb_3 from groupbox within w_con_packing_list_pedidos
integer x = 1458
integer y = 236
integer width = 343
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_packing_list_pedidos
integer x = 55
integer y = 244
integer width = 1394
integer height = 144
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden"
end type

type gb_1 from groupbox within w_con_packing_list_pedidos
integer x = 1806
integer y = 236
integer width = 160
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_1 from radiobutton within w_con_packing_list_pedidos
integer x = 101
integer y = 296
integer width = 571
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por nº de pedido"
boolean lefttext = true
end type

type rb_2 from radiobutton within w_con_packing_list_pedidos
integer x = 741
integer y = 296
integer width = 571
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por nº de pallet"
boolean checked = true
boolean lefttext = true
end type

type cb_1 from commandbutton within w_con_packing_list_pedidos
integer x = 1477
integer y = 280
integer width = 306
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;f_control()
end event

