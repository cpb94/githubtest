$PBExportHeader$w_con_venprecesp.srw
forward
global type w_con_venprecesp from w_int_con_empresa
end type
type st_1 from statictext within w_con_venprecesp
end type
type dw_listado from datawindow within w_con_venprecesp
end type
type dw_proceso2 from datawindow within w_con_venprecesp
end type
type uo_tarifa from u_em_campo_2 within w_con_venprecesp
end type
type em_precio from u_em_campo within w_con_venprecesp
end type
type st_4 from statictext within w_con_venprecesp
end type
type st_6 from statictext within w_con_venprecesp
end type
type dw_proceso3 from datawindow within w_con_venprecesp
end type
type dw_tar3 from u_datawindow_consultas within w_con_venprecesp
end type
type cb_continuar from u_boton within w_con_venprecesp
end type
type dw_proceso1 from datawindow within w_con_venprecesp
end type
type st_pallets from statictext within w_con_venprecesp
end type
type pb_2 from upb_salir within w_con_venprecesp
end type
type pb_3 from upb_imprimir within w_con_venprecesp
end type
type gb_4 from groupbox within w_con_venprecesp
end type
type uo_calidad from u_em_campo_2 within w_con_venprecesp
end type
type st_moneda from statictext within w_con_venprecesp
end type
type cb_1 from commandbutton within w_con_venprecesp
end type
type uo_cliente from u_em_campo_2 within w_con_venprecesp
end type
type st_7 from statictext within w_con_venprecesp
end type
type uo_articulo from u_em_campo_2 within w_con_venprecesp
end type
type st_8 from statictext within w_con_venprecesp
end type
type gb_6 from groupbox within w_con_venprecesp
end type
type st_9 from statictext within w_con_venprecesp
end type
type em_euros from u_em_campo within w_con_venprecesp
end type
type cb_2 from commandbutton within w_con_venprecesp
end type
type gb_3 from groupbox within w_con_venprecesp
end type
end forward

global type w_con_venprecesp from w_int_con_empresa
integer width = 2697
integer height = 1788
st_1 st_1
dw_listado dw_listado
dw_proceso2 dw_proceso2
uo_tarifa uo_tarifa
em_precio em_precio
st_4 st_4
st_6 st_6
dw_proceso3 dw_proceso3
dw_tar3 dw_tar3
cb_continuar cb_continuar
dw_proceso1 dw_proceso1
st_pallets st_pallets
pb_2 pb_2
pb_3 pb_3
gb_4 gb_4
uo_calidad uo_calidad
st_moneda st_moneda
cb_1 cb_1
uo_cliente uo_cliente
st_7 st_7
uo_articulo uo_articulo
st_8 st_8
gb_6 gb_6
st_9 st_9
em_euros em_euros
cb_2 cb_2
gb_3 gb_3
end type
global w_con_venprecesp w_con_venprecesp

type variables
String modo



end variables

event ue_listar;String filtro
dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa)

if trim(uo_tarifa.em_codigo.text)<>"" then
   filtro  = " tarifa = '" + uo_tarifa.em_codigo.text + "'"
End if

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta precios especiales"
This.title=istr_parametros.s_titulo_ventana
dw_listado.SetTransObject(SQLCA)
dw_tar3.SetTransObject(SQLCA)
dw_proceso3.SetTransObject(SQLCA)
f_activar_campo(uo_tarifa.em_campo)



end event

on w_con_venprecesp.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_listado=create dw_listado
this.dw_proceso2=create dw_proceso2
this.uo_tarifa=create uo_tarifa
this.em_precio=create em_precio
this.st_4=create st_4
this.st_6=create st_6
this.dw_proceso3=create dw_proceso3
this.dw_tar3=create dw_tar3
this.cb_continuar=create cb_continuar
this.dw_proceso1=create dw_proceso1
this.st_pallets=create st_pallets
this.pb_2=create pb_2
this.pb_3=create pb_3
this.gb_4=create gb_4
this.uo_calidad=create uo_calidad
this.st_moneda=create st_moneda
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_7=create st_7
this.uo_articulo=create uo_articulo
this.st_8=create st_8
this.gb_6=create gb_6
this.st_9=create st_9
this.em_euros=create em_euros
this.cb_2=create cb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.dw_proceso2
this.Control[iCurrent+4]=this.uo_tarifa
this.Control[iCurrent+5]=this.em_precio
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.dw_proceso3
this.Control[iCurrent+9]=this.dw_tar3
this.Control[iCurrent+10]=this.cb_continuar
this.Control[iCurrent+11]=this.dw_proceso1
this.Control[iCurrent+12]=this.st_pallets
this.Control[iCurrent+13]=this.pb_2
this.Control[iCurrent+14]=this.pb_3
this.Control[iCurrent+15]=this.gb_4
this.Control[iCurrent+16]=this.uo_calidad
this.Control[iCurrent+17]=this.st_moneda
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.uo_cliente
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.uo_articulo
this.Control[iCurrent+22]=this.st_8
this.Control[iCurrent+23]=this.gb_6
this.Control[iCurrent+24]=this.st_9
this.Control[iCurrent+25]=this.em_euros
this.Control[iCurrent+26]=this.cb_2
this.Control[iCurrent+27]=this.gb_3
end on

on w_con_venprecesp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.dw_proceso2)
destroy(this.uo_tarifa)
destroy(this.em_precio)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.dw_proceso3)
destroy(this.dw_tar3)
destroy(this.cb_continuar)
destroy(this.dw_proceso1)
destroy(this.st_pallets)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.gb_4)
destroy(this.uo_calidad)
destroy(this.st_moneda)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_7)
destroy(this.uo_articulo)
destroy(this.st_8)
destroy(this.gb_6)
destroy(this.st_9)
destroy(this.em_euros)
destroy(this.cb_2)
destroy(this.gb_3)
end on

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_tar3)		



end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_tar3)		


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_tar3)		


end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_tar3)		


end event

event activate;call super::activate;w_con_venprecesp = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_venprecesp
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_venprecesp
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_venprecesp
integer x = 14
integer y = 8
integer width = 2295
end type

type st_1 from statictext within w_con_venprecesp
integer x = 23
integer y = 156
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
string text = "Tarifa:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_venprecesp
boolean visible = false
integer x = 1742
integer width = 494
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_dto_cliente1"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_con_venprecesp
boolean visible = false
integer x = 466
integer y = 12
integer width = 311
integer height = 88
boolean bringtotop = true
string dataobject = "dw_proceso_vendtofamforcli"
boolean livescroll = true
end type

type uo_tarifa from u_em_campo_2 within w_con_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 247
integer y = 148
integer width = 1207
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_tarifa.em_campo.text=f_nombre_ventarifa(codigo_empresa,uo_tarifa.em_codigo.text)
If Trim(uo_tarifa.em_campo.text)="" then
	uo_tarifa.em_campo.text=""
	uo_tarifa.em_codigo.text=""
	Return
end if 
dw_tar3.reset()

st_moneda.text = f_nombre_moneda(f_moneda_ventarifas(codigo_empresa,uo_tarifa.em_codigo.text))
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Tarifas"
ue_datawindow ="dw_ayuda_ventarifas"
ue_filtro = ""
end event

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

type em_precio from u_em_campo within w_con_venprecesp
integer x = 928
integer y = 1448
integer width = 242
integer taborder = 60
end type

event modificado;call super::modificado;dec{2} var_precio,var_precio_euros
string  var_tarifa,var_moneda_tarifa

var_tarifa = uo_tarifa.em_campo.text
var_moneda_tarifa = f_moneda_ventarifas(codigo_empresa,var_tarifa)
var_precio = dec(em_precio.text)
if var_moneda_tarifa = "1" then
	var_precio_euros = var_precio / 166.386
else
	var_precio_euros = 0
end if

em_euros.text = string(var_precio_euros,"###,###.00")

end event

type st_4 from statictext within w_con_venprecesp
integer x = 27
integer y = 1376
integer width = 754
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_venprecesp
integer x = 928
integer y = 1376
integer width = 242
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_proceso3 from datawindow within w_con_venprecesp
boolean visible = false
integer x = 809
integer y = 16
integer width = 288
integer height = 92
boolean bringtotop = true
string dataobject = "dw_proceso_vendtoartcli"
boolean livescroll = true
end type

type dw_tar3 from u_datawindow_consultas within w_con_venprecesp
integer x = 14
integer y = 492
integer width = 2624
integer height = 844
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_venprecesp"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;This.SetFocus()

IF row <> 0 Then
	uo_articulo.em_codigo.text = dw_tar3.GetItemString(row,"articulo")
	uo_articulo.em_campo.text  = dw_tar3.GetItemString(row,"articulos_descripcion")
	uo_articulo.ue_valor_anterior = 	uo_articulo.em_campo.text 
	em_precio.text              = String(dw_tar3.GetItemNumber(row,"precio"))
	em_euros.text               = String(dw_tar3.GetItemNumber(row,"precio_euros"))
	uo_calidad.em_codigo.text = dw_tar3.GetItemString(row,"calidad")
	uo_calidad.em_campo.text  = dw_tar3.GetItemString(row,"calidades_abreviado")
	f_activar_campo(uo_articulo.em_campo)
END IF

end event

event getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

event rowfocuschanged;call super::rowfocuschanged;String  v_articulo,v_calidad
IF GetRow() = 0 Then Return
v_articulo =  GetItemSTring(GetRow(),"articulo")
v_calidad  =  GetItemSTring(GetRow(),"calidad")

end event

event retrieveend;IF rowcount = 1 Then
String  v_articulo,v_calidad
	SetRow(1)
	IF GetRow() = 0 Then Return
	v_articulo =  GetItemSTring(GetRow(),"articulo")
	v_calidad  =  GetItemSTring(GetRow(),"calidad")
	
END IF
end event

type cb_continuar from u_boton within w_con_venprecesp
integer x = 2048
integer y = 340
integer width = 393
integer height = 96
integer taborder = 30
string text = "F5 Continuar"
end type

event clicked;dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text,uo_cliente.em_codigo.text)
f_activar_campo(uo_articulo.em_campo)

end event

type dw_proceso1 from datawindow within w_con_venprecesp
boolean visible = false
integer x = 5
integer y = 8
integer width = 311
integer height = 88
boolean bringtotop = true
string dataobject = "dw_proceso_vendtofamcli"
boolean livescroll = true
end type

type st_pallets from statictext within w_con_venprecesp
integer x = 782
integer y = 1376
integer width = 142
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cal."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_venprecesp
integer x = 2450
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_3 from upb_imprimir within w_con_venprecesp
boolean visible = false
integer x = 2441
integer y = 340
integer taborder = 0
end type

event clicked;call super::clicked;w_con_dto_cliente.triggerEvent("ue_listar")
f_activar_campo(uo_tarifa.em_campo)

end event

type gb_4 from groupbox within w_con_venprecesp
integer x = 14
integer y = 92
integer width = 1998
integer height = 164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type uo_calidad from u_em_campo_2 within w_con_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 777
integer y = 1448
integer width = 146
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
If Trim(uo_calidad.em_campo.text)="" then
	uo_calidad.em_campo.text=""
	uo_calidad.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Calidades"
ue_datawindow ="dw_ayuda_calidades"
ue_filtro = ""
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type st_moneda from statictext within w_con_venprecesp
integer x = 1454
integer y = 148
integer width = 535
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_venprecesp
integer x = 1445
integer y = 1456
integer width = 233
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Borrar "
end type

event clicked;String var_tarifa,var_articulo,var_calidad,var_cliente
var_tarifa   = uo_tarifa.em_codigo.text
var_articulo = uo_articulo.em_codigo.text
var_calidad  = uo_calidad.em_codigo.text
var_cliente  = uo_cliente.em_codigo.text

  DELETE FROM venprecesp  
   WHERE  venprecesp.empresa  = :codigo_empresa 
	  AND  venprecesp.tarifa   = :var_tarifa 
	  AND  venprecesp.articulo = :var_articulo 
	  AND  venprecesp.calidad  = :var_calidad 
	  AND  venprecesp.cliente  = :var_cliente;
	  
  DELETE FROM venclipreesp  
   WHERE  venclipreesp.empresa  = :codigo_empresa 
	  AND  venclipreesp.tarifa   = :var_tarifa 
	  AND  venclipreesp.articulo = :var_articulo 
	  AND  venclipreesp.calidad  = :var_calidad
	  AND  venclipreesp.cliente  = :var_cliente;	  

commit ;

dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text,uo_cliente.em_codigo.text)
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
f_activar_campo(uo_articulo.em_campo)

end event

type uo_cliente from u_em_campo_2 within w_con_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 37
integer y = 344
integer width = 1952
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

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

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type st_7 from statictext within w_con_venprecesp
integer x = 37
integer y = 272
integer width = 1952
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 27
integer y = 1448
integer width = 750
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_8 from statictext within w_con_venprecesp
integer x = 928
integer y = 1376
integer width = 242
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_con_venprecesp
integer x = 14
integer y = 224
integer width = 1998
integer height = 216
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_9 from statictext within w_con_venprecesp
integer x = 1175
integer y = 1376
integer width = 247
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Euros"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_euros from u_em_campo within w_con_venprecesp
integer x = 1175
integer y = 1448
integer width = 242
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;dec{2} var_precio,var_precio_euros
string  var_tarifa,var_moneda_tarifa

var_tarifa = uo_tarifa.em_campo.text
var_moneda_tarifa = f_moneda_ventarifas(codigo_empresa,var_tarifa)
var_precio_euros = dec(em_euros.text)
if var_moneda_tarifa = "1" then
	var_precio = round(var_precio_euros * 166.386,0)
end if

em_precio.text = string(var_precio,"###,###.00")
end event

type cb_2 from commandbutton within w_con_venprecesp
event clicked pbm_bnclicked
integer x = 1449
integer y = 1376
integer width = 233
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Insertar"
end type

event clicked;String  v_tarifa,v_calidad,cod_articulo,v_moneda,v_cliente
Dec     numero
Dec{2}  v_precio,v_euros
DateTime  fecha

IF Trim(uo_articulo.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
END IF

IF Trim(uo_calidad.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca la calidad")
	f_activar_campo(uo_calidad.em_campo)
	Return
END IF

fecha = datetime(Today(),now())
cod_articulo = uo_articulo.em_codigo.text
v_tarifa   = uo_tarifa.em_codigo.text
v_calidad  = uo_calidad.em_codigo.text
v_cliente  = uo_cliente.em_codigo.text
v_precio   = Dec(em_precio.text)
v_euros    = Dec(em_euros.text)
v_moneda   = f_moneda_ventarifas(codigo_empresa,uo_tarifa.em_codigo.text)

Select Count(*) Into :numero From venprecesp
Where   empresa  = :codigo_empresa
And     tarifa   = :v_tarifa
And     articulo = :cod_articulo
And     cliente  = :v_cliente
And     calidad  = :v_calidad ;

IF IsNull(numero) Then numero = 0
IF numero = 0 Then
   INSERT INTO venprecesp
          ( empresa,tarifa,moneda,articulo,calidad,precio,cliente,precio_euros)  
   VALUES ( :codigo_empresa,:v_tarifa,:v_moneda,:cod_articulo,:v_calidad,:v_precio,:v_cliente,:v_euros);
	IF sqlca.sqlcode <> 0 Then messagebox("Error","Error al insertar en venprecesp")
			  
   INSERT INTO venclipreesp
          ( empresa,tarifa,articulo,calidad,cliente)  
   VALUES ( :codigo_empresa,:v_tarifa,:cod_articulo,:v_calidad,:v_cliente);
	IF sqlca.sqlcode <> 0 Then messagebox("Error","Error al insertar en venclipreesp")
ELSE
	Update  venprecesp
	Set     precio   = :v_precio
	Where   empresa  = :codigo_empresa
	And     tarifa   = :v_tarifa
	And     articulo = :cod_articulo
	And     calidad  = :v_calidad 
	And     cliente  = :v_cliente;
END IF
COMMIT;

dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text,uo_cliente.em_codigo.text)
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
f_activar_campo(uo_articulo.em_campo)
end event

type gb_3 from groupbox within w_con_venprecesp
integer x = 14
integer y = 1332
integer width = 1673
integer height = 216
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

