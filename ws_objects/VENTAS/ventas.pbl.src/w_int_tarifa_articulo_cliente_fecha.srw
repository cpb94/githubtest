$PBExportHeader$w_int_tarifa_articulo_cliente_fecha.srw
forward
global type w_int_tarifa_articulo_cliente_fecha from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_tarifa_articulo_cliente_fecha
end type
type st_1 from statictext within w_int_tarifa_articulo_cliente_fecha
end type
type uo_articulo from u_em_campo_2 within w_int_tarifa_articulo_cliente_fecha
end type
type st_2 from statictext within w_int_tarifa_articulo_cliente_fecha
end type
type uo_cliente from u_em_campo_2 within w_int_tarifa_articulo_cliente_fecha
end type
type dw_listado4 from datawindow within w_int_tarifa_articulo_cliente_fecha
end type
type pb_imprimir from upb_imprimir within w_int_tarifa_articulo_cliente_fecha
end type
type dw_1 from datawindow within w_int_tarifa_articulo_cliente_fecha
end type
type cb_1 from commandbutton within w_int_tarifa_articulo_cliente_fecha
end type
type cb_2 from commandbutton within w_int_tarifa_articulo_cliente_fecha
end type
type cb_3 from commandbutton within w_int_tarifa_articulo_cliente_fecha
end type
type cb_4 from commandbutton within w_int_tarifa_articulo_cliente_fecha
end type
type dw_2 from datawindow within w_int_tarifa_articulo_cliente_fecha
end type
end forward

global type w_int_tarifa_articulo_cliente_fecha from w_int_con_empresa
integer x = 46
integer y = 48
integer width = 2350
integer height = 2048
pb_1 pb_1
st_1 st_1
uo_articulo uo_articulo
st_2 st_2
uo_cliente uo_cliente
dw_listado4 dw_listado4
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_2 dw_2
end type
global w_int_tarifa_articulo_cliente_fecha w_int_tarifa_articulo_cliente_fecha

type variables
string filtro,tipocon
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text, uo_cliente.em_codigo.text)
//f_activar_campo(uo_articulo.em_campo)
dw_2.reset()
dw_2.retrieve(codigo_empresa, uo_cliente.em_codigo.text)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Tarifas por artículo cliente y fecha"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
//uo_pais.em_codigo.text = "11"

//uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_cliente.em_campo.SetFocus()
dw_listado4.SetTransObject(SQLCA)

//tipocon = 'T' // opcion de todos los clientes
end event

event ue_listar;//filtro = ""
//
//filtro = " genter_activo = '" + tipocon + "' "
//
////if tipocon = 'T' then filtro = ""
//
//if Trim(uo_provincia.em_codigo.text)<>"" then 
//	if trim(filtro)="" then 
//    	filtro = " provincia = '" + uo_provincia.em_codigo.text + "'"
//	else
//		filtro = filtro +"and "+" provincia = '" + uo_provincia.em_codigo.text + "'" 
//   end if
//End if
//
//IF TRIM(filtro)<>"" THEN
// dw_listado4.SetFilter(filtro)
// dw_listado4.Filter()
//END IF
//
dw_2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
dw_report=dw_2
CALL Super::ue_listar
end event

on w_int_tarifa_articulo_cliente_fecha.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.st_2=create st_2
this.uo_cliente=create uo_cliente
this.dw_listado4=create dw_listado4
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.dw_listado4
this.Control[iCurrent+7]=this.pb_imprimir
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.dw_2
end on

on w_int_tarifa_articulo_cliente_fecha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.st_2)
destroy(this.uo_cliente)
destroy(this.dw_listado4)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;
f_cursor_arriba(dw_1)
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_tarifa_articulo_cliente_fecha
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_tarifa_articulo_cliente_fecha
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_tarifa_articulo_cliente_fecha
integer y = 8
integer width = 2249
integer height = 84
end type

type pb_1 from upb_salir within w_int_tarifa_articulo_cliente_fecha
integer x = 2139
integer y = 112
integer width = 114
integer height = 96
integer taborder = 0
end type

type st_1 from statictext within w_int_tarifa_articulo_cliente_fecha
integer x = 41
integer y = 204
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_int_tarifa_articulo_cliente_fecha
integer x = 306
integer y = 200
integer width = 1349
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa, uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF

f_control()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro      = ""
valor_empresa = true

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_int_tarifa_articulo_cliente_fecha
integer x = 41
integer y = 104
integer width = 251
integer height = 76
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

type uo_cliente from u_em_campo_2 within w_int_tarifa_articulo_cliente_fecha
integer x = 306
integer y = 108
integer width = 1349
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF

f_control()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro      = ""
valor_empresa = true

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type dw_listado4 from datawindow within w_int_tarifa_articulo_cliente_fecha
boolean visible = false
integer x = 37
integer y = 4
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_ventas"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_int_tarifa_articulo_cliente_fecha
integer x = 2139
integer y = 896
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;Parent.triggerevent("ue_listar")
end event

type dw_1 from datawindow within w_int_tarifa_articulo_cliente_fecha
event doubleclicked pbm_dwnlbuttondblclk
integer x = 302
integer y = 324
integer width = 1664
integer height = 532
integer taborder = 40
string dataobject = "dw_int_tarifa_articulo_cliente_fecha"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

type cb_1 from commandbutton within w_int_tarifa_articulo_cliente_fecha
integer x = 1682
integer y = 112
integer width = 453
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()

end event

type cb_2 from commandbutton within w_int_tarifa_articulo_cliente_fecha
integer x = 1403
integer y = 404
integer width = 453
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;long fila

if uo_articulo.em_codigo.text <> '' and uo_cliente.em_codigo.text <> '' then	
	fila = dw_1.InsertRow(0)
	dw_1.object.tarifaartclifecha_empresa[fila] = codigo_empresa
	dw_1.object.tarifaartclifecha_articulo[fila] = uo_articulo.em_codigo.text
	dw_1.object.tarifaartclifecha_cliente[fila] = uo_cliente.em_codigo.text
	
	dw_1.ScrollToRow(fila)
	dw_1.setfocus()
else
	uo_cliente.em_campo.SetFocus()

end if
end event

type cb_3 from commandbutton within w_int_tarifa_articulo_cliente_fecha
integer x = 1403
integer y = 500
integer width = 453
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;dw_1.DeleteRow(0)


end event

type cb_4 from commandbutton within w_int_tarifa_articulo_cliente_fecha
integer x = 1403
integer y = 600
integer width = 453
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;dw_1.update()

f_control()
end event

type dw_2 from datawindow within w_int_tarifa_articulo_cliente_fecha
integer x = 82
integer y = 892
integer width = 2039
integer height = 888
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_tarifas_articulos_clientes"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 


end event

