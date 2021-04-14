$PBExportHeader$w_con_recibos_agrupados.srw
$PBExportComments$€
forward
global type w_con_recibos_agrupados from w_int_con_empresa
end type
type st_cliente from statictext within w_con_recibos_agrupados
end type
type uo_cliente from u_em_campo_2 within w_con_recibos_agrupados
end type
type pb_1 from upb_salir within w_con_recibos_agrupados
end type
type pb_imprimir from upb_imprimir within w_con_recibos_agrupados
end type
type dw_listado from datawindow within w_con_recibos_agrupados
end type
type uo_manejo from u_manejo_datawindow within w_con_recibos_agrupados
end type
type dw_detalle from datawindow within w_con_recibos_agrupados
end type
type cb_1 from commandbutton within w_con_recibos_agrupados
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_agrupados
end type
type st_1 from statictext within w_con_recibos_agrupados
end type
type dw_carta from datawindow within w_con_recibos_agrupados
end type
end forward

global type w_con_recibos_agrupados from w_int_con_empresa
integer width = 3616
integer height = 3608
st_cliente st_cliente
uo_cliente uo_cliente
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
dw_detalle dw_detalle
cb_1 cb_1
pb_imprimir_preli pb_imprimir_preli
st_1 st_1
dw_carta dw_carta
end type
global w_con_recibos_agrupados w_con_recibos_agrupados

type variables

end variables

on w_con_recibos_agrupados.create
int iCurrent
call super::create
this.st_cliente=create st_cliente
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_1=create st_1
this.dw_carta=create dw_carta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cliente
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_carta
end on

on w_con_recibos_agrupados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_cliente)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.pb_imprimir_preli)
destroy(this.st_1)
destroy(this.dw_carta)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Recibos Agrupados"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
//dw_detalle.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)
dw_carta.SetTransObject(SQLCA)
uo_cliente.em_campo.setFocus()
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_listar;string fi=""

dw_listado.SetFilter(fi)
dw_listado.Filter()

if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"

if trim(uo_cliente.em_codigo.text)<>"" then
	fi = fi + " and cliente = '"+uo_cliente.em_codigo.text+"'"
End if

dw_listado.SetFilter(fi)
dw_listado.Filter()


dw_listado.Retrieve(codigo_empresa)
dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_agrupados
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_agrupados
integer taborder = 50
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_agrupados
integer width = 3589
end type

type st_cliente from statictext within w_con_recibos_agrupados
integer x = 18
integer y = 96
integer width = 1339
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "C l i e n t e"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_recibos_agrupados
integer x = 23
integer y = 168
integer width = 1339
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE CLIENTES"
		ue_datawindow = "dw_ayuda_clientes"
		ue_filtro     = ""
  		

end event

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)	
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 



end event

type pb_1 from upb_salir within w_con_recibos_agrupados
integer x = 3424
integer y = 172
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir from upb_imprimir within w_con_recibos_agrupados
integer x = 3264
integer y = 172
integer taborder = 0
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_agrupados
boolean visible = false
integer x = 160
integer y = 16
integer width = 270
integer height = 108
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_recibos_agrupados"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_recibos_agrupados
integer x = 2789
integer y = 124
integer width = 622
integer height = 156
end type

event valores;call super::valores;dw_data=dw_detalle
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_recibos_agrupados
integer x = 27
integer y = 304
integer width = 3543
integer height = 3088
string dataobject = "dw_con_recibos_agrupados"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;if row=0 then return
integer var_anyo,var_orden

 var_anyo =this.GetItemNumber(row,"anyo")
 var_orden=this.GetItemNumber(row,"orden")


	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(var_anyo)
   lstr_param.s_argumentos[3]=string(var_orden)

   OpenWithParm(w_detalle_agrupado,lstr_param)

end event

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

type cb_1 from commandbutton within w_con_recibos_agrupados
integer x = 1376
integer y = 168
integer width = 347
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;string fi=""
dw_detalle.SetFilter(fi)
dw_detalle.Filter()

if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if


if trim(uo_cliente.em_codigo.text)<>"" then
	fi = fi + " and cliente = '"+uo_cliente.em_codigo.text+"'"
End if

dw_detalle.SetFilter(fi)
dw_detalle.Filter()


dw_detalle.Retrieve(codigo_empresa)

f_activar_campo(uo_cliente.em_campo)
end event

type pb_imprimir_preli from picturebutton within w_con_recibos_agrupados
event clicked pbm_bnclicked
integer x = 2651
integer y = 176
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;long i,fila
string marca,emp
boolean alguno
dec anyo,orden
datetime fvto


alguno = false


if dw_detalle.rowcount() <= 0 then
	messagebox("Atención","No hay efectos o no se ha consultado")
	return
end if


f_mascara_columna(dw_carta,"divisas",f_mascara_decimales(2))
f_mascara_columna(dw_carta,"total",f_mascara_decimales(2))
f_mascara_columna(dw_carta,"total2",f_mascara_decimales(2))


for i = 1 to dw_detalle.rowcount()
	marca = dw_detalle.getitemstring(i,"punteado")
	if marca = "S" then
		alguno = true	
		
		emp = dw_detalle.getitemstring(i,"empresa")
		anyo = dw_detalle.getitemnumber(i,"anyo")		
		orden= dw_detalle.getitemnumber(i,"orden")		
		fvto = dw_detalle.getitemdatetime(i,"fvto")		
		
		if f_idioma_genter(codigo_empresa,'C',dw_detalle.object.cliente[i]) <> "1" then
			dw_carta.dataobject = "report_carta_detalle_agrupados_eng"
		else
			dw_carta.dataobject = "report_carta_detalle_agrupados"
		end if
		dw_carta.settransobject(sqlca)
		
		dw_carta.retrieve(emp,anyo,orden,fvto)
		
		f_imprimir_datawindow(dw_carta)	
		
	end if
next

if not alguno then
	messagebox("Atención","No hay efectos seleccionados")
end if
end event

type st_1 from statictext within w_con_recibos_agrupados
integer x = 2450
integer y = 192
integer width = 192
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Carta"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_carta from datawindow within w_con_recibos_agrupados
boolean visible = false
integer x = 709
integer y = 72
integer width = 640
integer height = 512
integer taborder = 32
boolean bringtotop = true
string dataobject = "report_carta_detalle_agrupados"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

