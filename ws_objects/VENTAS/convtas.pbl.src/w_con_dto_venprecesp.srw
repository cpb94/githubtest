$PBExportHeader$w_con_dto_venprecesp.srw
forward
global type w_con_dto_venprecesp from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_dto_venprecesp
end type
type st_1 from statictext within w_con_dto_venprecesp
end type
type dw_listado from datawindow within w_con_dto_venprecesp
end type
type uo_articulo from u_em_campo_2 within w_con_dto_venprecesp
end type
type dw_proceso2 from datawindow within w_con_dto_venprecesp
end type
type uo_tarifa from u_em_campo_2 within w_con_dto_venprecesp
end type
type em_precio from u_em_campo within w_con_dto_venprecesp
end type
type st_4 from statictext within w_con_dto_venprecesp
end type
type st_6 from statictext within w_con_dto_venprecesp
end type
type dw_proceso3 from datawindow within w_con_dto_venprecesp
end type
type dw_tar3 from u_datawindow_consultas within w_con_dto_venprecesp
end type
type cb_continuar from u_boton within w_con_dto_venprecesp
end type
type dw_proceso1 from datawindow within w_con_dto_venprecesp
end type
type st_pallets from statictext within w_con_dto_venprecesp
end type
type pb_2 from upb_salir within w_con_dto_venprecesp
end type
type pb_3 from upb_imprimir within w_con_dto_venprecesp
end type
type gb_5 from groupbox within w_con_dto_venprecesp
end type
type gb_4 from groupbox within w_con_dto_venprecesp
end type
type uo_calidad from u_em_campo_2 within w_con_dto_venprecesp
end type
type gb_3 from groupbox within w_con_dto_venprecesp
end type
type st_moneda from statictext within w_con_dto_venprecesp
end type
type cb_1 from commandbutton within w_con_dto_venprecesp
end type
type cb_2 from commandbutton within w_con_dto_venprecesp
end type
end forward

global type w_con_dto_venprecesp from w_int_con_empresa
integer width = 2848
integer height = 1680
pb_1 pb_1
st_1 st_1
dw_listado dw_listado
uo_articulo uo_articulo
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
gb_5 gb_5
gb_4 gb_4
uo_calidad uo_calidad
gb_3 gb_3
st_moneda st_moneda
cb_1 cb_1
cb_2 cb_2
end type
global w_con_dto_venprecesp w_con_dto_venprecesp

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

on w_con_dto_venprecesp.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_listado=create dw_listado
this.uo_articulo=create uo_articulo
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
this.gb_5=create gb_5
this.gb_4=create gb_4
this.uo_calidad=create uo_calidad
this.gb_3=create gb_3
this.st_moneda=create st_moneda
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_articulo
this.Control[iCurrent+5]=this.dw_proceso2
this.Control[iCurrent+6]=this.uo_tarifa
this.Control[iCurrent+7]=this.em_precio
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.dw_proceso3
this.Control[iCurrent+11]=this.dw_tar3
this.Control[iCurrent+12]=this.cb_continuar
this.Control[iCurrent+13]=this.dw_proceso1
this.Control[iCurrent+14]=this.st_pallets
this.Control[iCurrent+15]=this.pb_2
this.Control[iCurrent+16]=this.pb_3
this.Control[iCurrent+17]=this.gb_5
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.uo_calidad
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.st_moneda
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.cb_2
end on

on w_con_dto_venprecesp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.uo_articulo)
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
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.uo_calidad)
destroy(this.gb_3)
destroy(this.st_moneda)
destroy(this.cb_1)
destroy(this.cb_2)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_dto_venprecesp
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_dto_venprecesp
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_dto_venprecesp
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_dto_venprecesp
boolean visible = false
integer x = 2875
integer width = 128
integer height = 112
integer taborder = 0
end type

type st_1 from statictext within w_con_dto_venprecesp
integer x = 23
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
string text = "Tarifa:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_dto_venprecesp
boolean visible = false
integer x = 1742
integer width = 494
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_dto_cliente1"
boolean livescroll = true
end type

type uo_articulo from u_em_campo_2 within w_con_dto_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 41
integer y = 1316
integer width = 777
integer taborder = 30
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

type dw_proceso2 from datawindow within w_con_dto_venprecesp
boolean visible = false
integer x = 466
integer y = 12
integer width = 311
integer height = 88
boolean bringtotop = true
string dataobject = "dw_proceso_vendtofamforcli"
boolean livescroll = true
end type

type uo_tarifa from u_em_campo_2 within w_con_dto_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 247
integer y = 156
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

type em_precio from u_em_campo within w_con_dto_venprecesp
integer x = 1065
integer y = 1316
integer width = 320
integer taborder = 50
end type

event tecla_enter;call super::tecla_enter;IF Trim(uo_articulo.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
END IF

IF Trim(uo_calidad.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca la calidad")
	f_activar_campo(uo_calidad.em_campo)
	Return
END IF

String  v_tarifa,v_calidad,cod_articulo,v_moneda
Dec     numero,v_precio
DateTime  fecha
fecha = datetime(Today(),now())
cod_articulo = uo_articulo.em_codigo.text
IF IsNull(cod_articulo) Or Trim(cod_articulo) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
END IF
v_tarifa   = uo_tarifa.em_codigo.text
v_calidad  = uo_calidad.em_codigo.text
v_precio   = Dec(em_precio.text)

Select Count(*) Into :numero From venprecesp
Where   empresa  = :codigo_empresa
And     tarifa   = :v_tarifa
And     articulo = :cod_articulo
And     calidad  = :v_calidad ;

IF IsNull(numero) Then numero = 0
IF numero = 0 Then
  INSERT INTO venprecesp
         ( empresa,tarifa,moneda,articulo,calidad,precio)  
  VALUES ( :codigo_empresa,:v_tarifa,:v_moneda,:cod_articulo,:v_calidad,   
           :v_precio)  ;
			
ELSE
			Update  venprecesp
			Set     precio   = :v_precio
         Where   empresa  = :codigo_empresa
			And     tarifa   = :v_tarifa
			And     articulo = :cod_articulo
			And     calidad  = :v_calidad ;

END IF
COMMIT;

dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text)
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
f_activar_campo(uo_articulo.em_campo)



end event

type st_4 from statictext within w_con_dto_venprecesp
integer x = 41
integer y = 1244
integer width = 782
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

type st_6 from statictext within w_con_dto_venprecesp
integer x = 1065
integer y = 1244
integer width = 320
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

type dw_proceso3 from datawindow within w_con_dto_venprecesp
boolean visible = false
integer x = 809
integer y = 16
integer width = 288
integer height = 92
boolean bringtotop = true
string dataobject = "dw_proceso_vendtoartcli"
boolean livescroll = true
end type

type dw_tar3 from u_datawindow_consultas within w_con_dto_venprecesp
integer x = 14
integer y = 260
integer width = 1413
integer height = 952
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
	uo_calidad.em_codigo.text = dw_tar3.GetItemString(row,"calidad")
	uo_calidad.em_campo.text  = dw_tar3.GetItemString(row,"calidades_abreviado")
	f_activar_campo(uo_articulo.em_campo)
END IF

end event

event getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type cb_continuar from u_boton within w_con_dto_venprecesp
integer x = 2048
integer y = 140
integer width = 393
integer height = 96
integer taborder = 20
string text = "F5 Continuar"
end type

event clicked;call super::clicked;dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text)
f_activar_campo(uo_articulo.em_campo)

end event

type dw_proceso1 from datawindow within w_con_dto_venprecesp
boolean visible = false
integer x = 5
integer y = 8
integer width = 311
integer height = 88
boolean bringtotop = true
string dataobject = "dw_proceso_vendtofamcli"
boolean livescroll = true
end type

type st_pallets from statictext within w_con_dto_venprecesp
integer x = 823
integer y = 1244
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
string text = "Calidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_dto_venprecesp
integer x = 2683
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "EXIT!"
end type

type pb_3 from upb_imprimir within w_con_dto_venprecesp
integer x = 2441
integer y = 140
integer taborder = 0
string picturename = "PRINT!"
end type

event clicked;call super::clicked;w_con_dto_cliente.triggerEvent("ue_listar")
f_activar_campo(uo_tarifa.em_campo)

end event

type gb_5 from groupbox within w_con_dto_venprecesp
integer x = 1435
integer y = 1188
integer width = 439
integer height = 232
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_4 from groupbox within w_con_dto_venprecesp
integer x = 14
integer y = 92
integer width = 1998
integer height = 168
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type uo_calidad from u_em_campo_2 within w_con_dto_venprecesp
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 818
integer y = 1316
integer width = 247
integer taborder = 40
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

type gb_3 from groupbox within w_con_dto_venprecesp
integer x = 14
integer y = 1188
integer width = 1413
integer height = 232
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_moneda from statictext within w_con_dto_venprecesp
integer x = 1454
integer y = 156
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

type cb_1 from commandbutton within w_con_dto_venprecesp
integer x = 1454
integer y = 1320
integer width = 402
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Borrar linea"
end type

event clicked;String var_tarifa,var_articulo,var_calidad
var_tarifa   = uo_tarifa.em_codigo.text
var_articulo = uo_articulo.em_codigo.text
var_calidad  = uo_calidad.em_codigo.text

  DELETE FROM venprecesp  
   WHERE  venprecesp.empresa  = :codigo_empresa 
	  AND  venprecesp.tarifa   = :var_tarifa 
	  AND  venprecesp.articulo = :var_articulo 
	  AND  venprecesp.calidad  = :var_calidad   ;

commit ;

dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text)
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
f_activar_campo(uo_articulo.em_campo)

end event

type cb_2 from commandbutton within w_con_dto_venprecesp
event clicked pbm_bnclicked
integer x = 1454
integer y = 1232
integer width = 402
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Insertar"
end type

event clicked;dw_tar3.Retrieve(codigo_empresa,uo_tarifa.em_codigo.text)
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
f_activar_campo(uo_articulo.em_campo)

end event

