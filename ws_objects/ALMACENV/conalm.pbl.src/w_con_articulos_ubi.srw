$PBExportHeader$w_con_articulos_ubi.srw
$PBExportComments$Consulta de Artículos en una Ubicación
forward
global type w_con_articulos_ubi from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_articulos_ubi
end type
type pb_imprimir_preli from picturebutton within w_con_articulos_ubi
end type
type st_3 from statictext within w_con_articulos_ubi
end type
type uo_1 from u_manejo_datawindow within w_con_articulos_ubi
end type
type dw_listado from datawindow within w_con_articulos_ubi
end type
type uo_tipo from u_marca_lista within w_con_articulos_ubi
end type
type cb_1 from u_boton within w_con_articulos_ubi
end type
type dw_1 from datawindow within w_con_articulos_ubi
end type
type st_4 from statictext within w_con_articulos_ubi
end type
type st_5 from statictext within w_con_articulos_ubi
end type
type cb_continuar from u_boton within w_con_articulos_ubi
end type
type sle_zona from singlelineedit within w_con_articulos_ubi
end type
type sle_fila from singlelineedit within w_con_articulos_ubi
end type
type sle_altura from singlelineedit within w_con_articulos_ubi
end type
type uo_cliente from u_em_campo_2 within w_con_articulos_ubi
end type
type cbx_valorado from checkbox within w_con_articulos_ubi
end type
type gb_7 from groupbox within w_con_articulos_ubi
end type
end forward

global type w_con_articulos_ubi from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5042
integer height = 3280
string title = "Consulta artículos por ubicación"
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
st_3 st_3
uo_1 uo_1
dw_listado dw_listado
uo_tipo uo_tipo
cb_1 cb_1
dw_1 dw_1
st_4 st_4
st_5 st_5
cb_continuar cb_continuar
sle_zona sle_zona
sle_fila sle_fila
sle_altura sle_altura
uo_cliente uo_cliente
cbx_valorado cbx_valorado
gb_7 gb_7
end type
global w_con_articulos_ubi w_con_articulos_ubi

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string is_filtro=""
String filtro="",filtro1=""
Integer numero, x1, y1
string zona, fila, altura
string cliente

if not cbx_valorado.checked then
	dw_1.Dataobject = 'dw_con_articulos_ubi_old' 
else
	dw_1.Dataobject = 'dw_con_articulos_ubi' 
end if

dw_1.SetTransObject (SQLCA)

numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then 
	filtro = ' 1 = 1 '
	messagebox ("Aviso", "Debe introducir un almacén")
else
	FOR x1 = 1 To numero
		IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
			y1=y1+1
			IF Trim(filtro) = "" Then
				filtro1 = " almlinubica_almacen = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
			 Else
				filtro1 = " Or almlinubica_almacen = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
			End If
			filtro = filtro  + filtro1
		END IF
	NEXT
end if
filtro  = "(" + filtro + ") and ( almlinubica_existencias <> 0 ) and ( genter_tipoter = 'C' or isnull (genter_tipoter)  or genter_tipoter =  '') "

//////////////////////////////////////////////

dw_1.setredraw(false) 
if uo_cliente.em_codigo.text <> '' and not isnull(uo_cliente.em_codigo.text) then
	cliente = " and genter_codigo = '"+uo_cliente.em_codigo.text+"' "
else
	cliente = ""
end if

filtro = filtro + cliente 

dw_1.SetFilter(filtro)
dw_1.Filter()


dw_1.setredraw(true) 




dw_1.SetFilter(filtro)
dw_1.Filter()


//dw_1.Retrieve ( codigo_empresa,uo_zona.em_codigo.text,dec (uo_fila.em_codigo.text), dec (uo_altura.em_codigo.text ) )
dw_1.Retrieve ( codigo_empresa,sle_zona.text,dec (sle_fila.text), dec (sle_altura.text ) )


end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = "Consulta artículos por ubicación"

uo_tipo.f_cargar_datos("dw_ayuda_almacenes","","","Código","Descripción")

sle_zona.text = 'P'
sle_fila.text = '1'
sle_altura.text = '1'

//f_activar_campo(sle_zona)


end event

on w_con_articulos_ubi.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_3=create st_3
this.uo_1=create uo_1
this.dw_listado=create dw_listado
this.uo_tipo=create uo_tipo
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_4=create st_4
this.st_5=create st_5
this.cb_continuar=create cb_continuar
this.sle_zona=create sle_zona
this.sle_fila=create sle_fila
this.sle_altura=create sle_altura
this.uo_cliente=create uo_cliente
this.cbx_valorado=create cbx_valorado
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_tipo
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.cb_continuar
this.Control[iCurrent+12]=this.sle_zona
this.Control[iCurrent+13]=this.sle_fila
this.Control[iCurrent+14]=this.sle_altura
this.Control[iCurrent+15]=this.uo_cliente
this.Control[iCurrent+16]=this.cbx_valorado
this.Control[iCurrent+17]=this.gb_7
end on

on w_con_articulos_ubi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_3)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.uo_tipo)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cb_continuar)
destroy(this.sle_zona)
destroy(this.sle_fila)
destroy(this.sle_altura)
destroy(this.uo_cliente)
destroy(this.cbx_valorado)
destroy(this.gb_7)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_articulos_ubi
integer x = 91
integer y = 1292
integer width = 1019
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_articulos_ubi
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_articulos_ubi
integer y = 20
integer width = 4745
integer height = 84
end type

type pb_2 from upb_salir within w_con_articulos_ubi
integer x = 4800
integer y = 32
integer width = 128
integer height = 112
integer taborder = 0
end type

type pb_imprimir_preli from picturebutton within w_con_articulos_ubi
integer x = 4069
integer y = 176
integer width = 110
integer height = 96
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

event clicked;//dw_listado.Retrieve(codigo_empresa,uo_zona.em_codigo.text,dec(uo_fila.em_codigo.text),dec(uo_altura.em_codigo.text))
//f_imprimir_datawindow(dw_listado)

f_imprimir_datawindow(dw_1)

end event

type st_3 from statictext within w_con_articulos_ubi
integer x = 416
integer y = 128
integer width = 178
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Zona"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_1 from u_manejo_datawindow within w_con_articulos_ubi
integer x = 3593
integer y = 132
integer width = 617
integer height = 168
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_articulos_ubi
boolean visible = false
integer x = 2107
integer y = 172
integer width = 174
integer height = 132
boolean bringtotop = true
string dataobject = "report_con_articulos_ubi"
boolean livescroll = true
end type

type uo_tipo from u_marca_lista within w_con_articulos_ubi
boolean visible = false
integer x = 37
integer y = 312
integer width = 1454
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_1 from u_boton within w_con_articulos_ubi
event clicked pbm_bnclicked
integer x = 3237
integer y = 176
integer width = 347
integer height = 92
integer taborder = 40
string text = "&Continuar"
end type

event clicked;call super::clicked;uo_tipo.visible = False
f_control()
end event

type dw_1 from datawindow within w_con_articulos_ubi
integer x = 50
integer y = 320
integer width = 4951
integer height = 2744
string dataobject = "dw_con_articulos_ubi"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_4 from statictext within w_con_articulos_ubi
integer x = 613
integer y = 128
integer width = 178
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Fila"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_articulos_ubi
integer x = 814
integer y = 128
integer width = 178
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Altura"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_continuar from u_boton within w_con_articulos_ubi
integer x = 73
integer y = 184
integer width = 334
integer height = 92
integer taborder = 40
boolean bringtotop = true
string text = "&Almacenes"
end type

event clicked;call super::clicked;if uo_tipo.visible = TRUE then
	uo_tipo.visible = False
 else
	uo_tipo.visible = TRUE
End if

end event

type sle_zona from singlelineedit within w_con_articulos_ubi
integer x = 421
integer y = 196
integer width = 169
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_fila from singlelineedit within w_con_articulos_ubi
integer x = 613
integer y = 196
integer width = 174
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_altura from singlelineedit within w_con_articulos_ubi
integer x = 814
integer y = 196
integer width = 169
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_con_articulos_ubi
event destroy ( )
integer x = 1029
integer y = 180
integer width = 2098
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type cbx_valorado from checkbox within w_con_articulos_ubi
integer x = 4274
integer y = 200
integer width = 649
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Valorado"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_con_articulos_ubi
integer x = 1006
integer y = 128
integer width = 2158
integer height = 160
integer taborder = 50
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

