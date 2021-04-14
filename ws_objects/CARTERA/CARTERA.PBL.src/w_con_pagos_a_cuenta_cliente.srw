$PBExportHeader$w_con_pagos_a_cuenta_cliente.srw
forward
global type w_con_pagos_a_cuenta_cliente from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_a_cuenta_cliente
end type
type gb_3 from groupbox within w_con_pagos_a_cuenta_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_pagos_a_cuenta_cliente
end type
type gb_cuenta from groupbox within w_con_pagos_a_cuenta_cliente
end type
type st_1 from statictext within w_con_pagos_a_cuenta_cliente
end type
type dw_pagos_a_cuenta_pendientes from datawindow within w_con_pagos_a_cuenta_cliente
end type
type cb_consulta from commandbutton within w_con_pagos_a_cuenta_cliente
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_a_cuenta_cliente
end type
end forward

global type w_con_pagos_a_cuenta_cliente from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 3643
integer height = 2384
pb_2 pb_2
gb_3 gb_3
uo_cliente uo_cliente
gb_cuenta gb_cuenta
st_1 st_1
dw_pagos_a_cuenta_pendientes dw_pagos_a_cuenta_pendientes
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
end type
global w_con_pagos_a_cuenta_cliente w_con_pagos_a_cuenta_cliente

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public subroutine f_mostrar_pagos_a_cuenta_sin_asignar (datawindow data)
end prototypes

public subroutine f_mostrar_pagos_a_cuenta_sin_asignar (datawindow data);long   indice,total,donde
string cliente,sel
string factura,moneda,situacion,tipodoc,historico,cobrado,moneda_empresa
int    anyo,anyofra,linea_historico,orden,recibo
dec    cambio,divisas,importe
datetime fcobro,fvto

datastore datos

data.setredraw(false)
data.reset()

moneda_empresa = f_moneda_empresa(codigo_empresa)

if trim(uo_cliente.em_codigo.text) <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

sel = "SELECT cliente,anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,0 linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'N' historico "+&
		"FROM   carefectos "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       like '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'N' "+&
		"UNION "+&
      "SELECT cliente,anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,linea linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'S' historico "+&
		"FROM   carhistorico "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       like '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'N'"
		
		
datos = f_cargar_cursor(sel)	

total = datos.rowcount()

for indice = 1 to total
	cliente         = datos.object.cliente[indice]
	anyo            = datos.object.anyo[indice]
	anyofra         = datos.object.anyofra[indice]
	cambio          = datos.object.cambio[indice]
	divisas         = datos.object.divisas[indice]
	factura         = datos.object.factura[indice]
	fcobro          = datos.object.fcobro[indice]
	fvto            = datos.object.fvto[indice]
	importe         = datos.object.importe[indice]
	linea_historico = datos.object.linea_historico[indice]
	moneda          = datos.object.monedas[indice]
	orden           = datos.object.orden[indice]
	recibo          = datos.object.recibo[indice]
	situacion       = datos.object.situacion[indice]
	tipodoc         = datos.object.tipodoc[indice]
	historico       = datos.object.historico[indice]
	
	if situacion = "9" then
		cobrado = "S"
	else
		cobrado = "N"
	end if
	
	donde = data.insertrow(0)
	
	data.object.cliente[donde]         = cliente
	data.object.nombre_cliente[donde]  = f_razon_genter(codigo_empresa,"C",cliente)
	data.object.anyo[donde]            = anyo
	data.object.anyofra[donde]         = anyofra
	data.object.cambio[donde]          = cambio
	data.object.cobrado[donde]         = cobrado
	data.object.divisas[donde]         = divisas
	data.object.empresa[donde]         = codigo_empresa
	data.object.factura[donde]         = factura
	data.object.fcobro[donde]          = fcobro
	data.object.fvto[donde]            = fvto
	data.object.importe[donde]         = importe
	data.object.linea_historico[donde] = linea_historico 
	data.object.moneda[donde]          = moneda
	data.object.moneda_empresa[donde]  = moneda_empresa
	data.object.orden[donde]           = orden
	data.object.recibo[donde]          = recibo
	data.object.situacion[donde]       = situacion
	data.object.tipodoc[donde]         = tipodoc
	data.object.historico[donde]       = historico
	
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event open;call super::open;string moneda_empresa

This.title = "CONSULTA PAGOS A CUENTA PENDIENTES DE ASIGNAR"

f_activar_campo(uo_cliente.em_campo)

moneda_empresa = f_moneda_empresa(codigo_empresa)
end event

on w_con_pagos_a_cuenta_cliente.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.gb_3=create gb_3
this.uo_cliente=create uo_cliente
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_pagos_a_cuenta_pendientes=create dw_pagos_a_cuenta_pendientes
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.uo_cliente
this.Control[iCurrent+4]=this.gb_cuenta
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_pagos_a_cuenta_pendientes
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.pb_imprimir_preli
end on

on w_con_pagos_a_cuenta_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.gb_3)
destroy(this.uo_cliente)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_pagos_a_cuenta_pendientes)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_a_cuenta_cliente
integer x = 1061
integer y = 28
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_a_cuenta_cliente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_a_cuenta_cliente
integer x = 9
integer y = 8
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_con_pagos_a_cuenta_cliente
integer x = 3515
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type gb_3 from groupbox within w_con_pagos_a_cuenta_cliente
integer x = 2633
integer y = 84
integer width = 366
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_cliente from u_em_campo_2 within w_con_pagos_a_cuenta_cliente
event destroy ( )
integer x = 270
integer y = 124
integer width = 2341
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"

end event

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
end event

type gb_cuenta from groupbox within w_con_pagos_a_cuenta_cliente
integer x = 9
integer y = 84
integer width = 2624
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_con_pagos_a_cuenta_cliente
integer x = 37
integer y = 132
integer width = 233
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente :"
boolean focusrectangle = false
end type

type dw_pagos_a_cuenta_pendientes from datawindow within w_con_pagos_a_cuenta_cliente
integer x = 5
integer y = 232
integer width = 3621
integer height = 1992
boolean titlebar = true
string title = "Pagos a cuenta sin asignar"
string dataobject = "dw_con_pagos_a_cuenta_cliente1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenSheetWithParm(w_detalle_agrupado,lstr_param,Parent,3,Original!)


End If
end event

event clicked;dec  importe_pago_a_cuenta,importe_total_asignado
long indice,total

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)
	
	importe_pago_a_cuenta  = this.object.importe[row]
	
	importe_total_asignado = 0
	
end if

end event

type cb_consulta from commandbutton within w_con_pagos_a_cuenta_cliente
integer x = 2642
integer y = 116
integer width = 343
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;f_mostrar_pagos_a_cuenta_sin_asignar(dw_pagos_a_cuenta_pendientes)

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_a_cuenta_cliente
integer x = 3511
integer y = 120
integer width = 110
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "C:\bmp\imp32.bmp"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = uo_cliente.em_campo.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_pagos_a_cuenta_pendientes)
end event

