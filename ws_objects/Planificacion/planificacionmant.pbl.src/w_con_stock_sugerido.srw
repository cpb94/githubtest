$PBExportHeader$w_con_stock_sugerido.srw
forward
global type w_con_stock_sugerido from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_sugerido
end type
type dw_listado from datawindow within w_con_stock_sugerido
end type
type pb_imprimir_preli from picturebutton within w_con_stock_sugerido
end type
type dw_1 from datawindow within w_con_stock_sugerido
end type
type cb_1 from u_boton within w_con_stock_sugerido
end type
type uo_articulo from u_em_campo_2 within w_con_stock_sugerido
end type
type gb_4 from groupbox within w_con_stock_sugerido
end type
type gb_3 from groupbox within w_con_stock_sugerido
end type
type gb_67 from groupbox within w_con_stock_sugerido
end type
type uo_formato from u_em_campo_2 within w_con_stock_sugerido
end type
type uo_cliente from u_em_campo_2 within w_con_stock_sugerido
end type
end forward

global type w_con_stock_sugerido from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3579
integer height = 3400
pb_2 pb_2
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
cb_1 cb_1
uo_articulo uo_articulo
gb_4 gb_4
gb_3 gb_3
gb_67 gb_67
uo_formato uo_formato
uo_cliente uo_cliente
end type
global w_con_stock_sugerido w_con_stock_sugerido

type variables
String ante_articulo,retrasos,variable
String marcado = "1"
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string cliente, formato, articulo

dw_1.Setredraw(False)

if uo_cliente.em_codigo.text = "" then 
	cliente = "%"
else
	cliente = uo_cliente.em_codigo.text
end if
if uo_formato.em_codigo.text = "" then 
	formato = "%"
else
	formato = uo_formato.em_campo.text
end if

if uo_articulo.em_codigo.text = "" then 
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if


dw_1.Retrieve(codigo_empresa,cliente,formato, articulo)
dw_1.Setredraw(True)



end subroutine

event ue_listar;dw_report = dw_1
CALL Super::ue_listar
end event

event open;call super::open;String mascara

w_con_stock_sugerido = ventanas_activas[id_ventana_activa].ventana

dw_1.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = " Introducción Stock Sugerido"

//f_activar_campo(uo_articulo)


end event

on w_con_stock_sugerido.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_67=create gb_67
this.uo_formato=create uo_formato
this.uo_cliente=create uo_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_67
this.Control[iCurrent+10]=this.uo_formato
this.Control[iCurrent+11]=this.uo_cliente
end on

on w_con_stock_sugerido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_67)
destroy(this.uo_formato)
destroy(this.uo_cliente)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_sugerido
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_sugerido
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_sugerido
integer x = 27
integer y = 20
integer width = 3461
end type

type pb_2 from upb_salir within w_con_stock_sugerido
integer x = 3360
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
end type

type dw_listado from datawindow within w_con_stock_sugerido
boolean visible = false
integer x = 526
integer width = 160
integer height = 92
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_bloqueo_promocion"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_stock_sugerido
integer x = 3237
integer y = 156
integer width = 110
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;Parent.TriggerEvent("ue_listar")
end event

type dw_1 from datawindow within w_con_stock_sugerido
integer x = 23
integer y = 268
integer width = 3483
integer height = 2900
string dataobject = "dw_con_stock_sugerido"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This)= "marcado" Then
	IF marcado = "1" Then
		marcado = "0"
		This.SetFilter("marca= '*'")
		This.Filter()
	ELSE
		This.SetFilter("")
		This.Reset()
		marcado = "1"
		f_control()
	END IF

END IF
end event

type cb_1 from u_boton within w_con_stock_sugerido
integer x = 2811
integer y = 156
integer width = 411
integer height = 96
integer taborder = 70
string text = "&Continuar"
end type

event clicked;f_control()
//f_activar_campo(em_1)
end event

type uo_articulo from u_em_campo_2 within w_con_stock_sugerido
event destroy ( )
integer x = 1298
integer y = 172
integer width = 786
integer height = 72
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type gb_4 from groupbox within w_con_stock_sugerido
integer x = 393
integer y = 120
integer width = 873
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_stock_sugerido
integer x = 32
integer y = 120
integer width = 352
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formato"
end type

type gb_67 from groupbox within w_con_stock_sugerido
integer x = 1275
integer y = 120
integer width = 837
integer height = 140
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type uo_formato from u_em_campo_2 within w_con_stock_sugerido
event destroy ( )
integer x = 46
integer y = 172
integer width = 315
integer height = 68
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

IF Trim(uo_formato.em_campo.text)="" THEN 
 	IF Trim(uo_formato.em_codigo.text)<>"" Then 
		uo_formato.em_campo.SetFocus()
	END IF
 	uo_formato.em_campo.text=""
 	uo_formato.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de formatos"
ue_datawindow = "dw_ayuda_formatos"
ue_filtro     = ""

end event

type uo_cliente from u_em_campo_2 within w_con_stock_sugerido
event destroy ( )
integer x = 411
integer y = 172
integer width = 837
integer height = 68
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

