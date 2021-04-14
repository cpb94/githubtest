$PBExportHeader$w_int_notificacion.srw
forward
global type w_int_notificacion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_notificacion
end type
type dw_listado_detalle from datawindow within w_int_notificacion
end type
type pb_2 from upb_imprimir within w_int_notificacion
end type
type dw_detalle from datawindow within w_int_notificacion
end type
type uo_companyia from u_em_campo_2 within w_int_notificacion
end type
type ddlb_situacion from dropdownlistbox within w_int_notificacion
end type
type cb_borrar from u_boton within w_int_notificacion
end type
type gb_5 from groupbox within w_int_notificacion
end type
type gb_3 from groupbox within w_int_notificacion
end type
type cbx_cobrados from checkbox within w_int_notificacion
end type
type cbx_no_cobrados from checkbox within w_int_notificacion
end type
type em_anyo from u_em_campo within w_int_notificacion
end type
type uo_mes from u_em_campo_2 within w_int_notificacion
end type
type st_1 from statictext within w_int_notificacion
end type
type st_2 from statictext within w_int_notificacion
end type
type gb_4 from groupbox within w_int_notificacion
end type
type gb_1 from groupbox within w_int_notificacion
end type
type gb_2 from groupbox within w_int_notificacion
end type
end forward

global type w_int_notificacion from w_int_con_empresa
integer width = 2944
integer height = 1716
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
pb_2 pb_2
dw_detalle dw_detalle
uo_companyia uo_companyia
ddlb_situacion ddlb_situacion
cb_borrar cb_borrar
gb_5 gb_5
gb_3 gb_3
cbx_cobrados cbx_cobrados
cbx_no_cobrados cbx_no_cobrados
em_anyo em_anyo
uo_mes uo_mes
st_1 st_1
st_2 st_2
gb_4 gb_4
gb_1 gb_1
gb_2 gb_2
end type
global w_int_notificacion w_int_notificacion

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción notificaciones"

This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado_detalle.SetTransObject(SQLCA)

em_anyo.text = String(year(Today()))
uo_mes.em_codigo.text = String(Month(Today()) - 1 )

IF uo_mes.em_codigo.text = "0" Then
	uo_mes.em_codigo.text = "12"
	em_anyo.text = String(Dec(em_anyo.text) - 1)
END IF

uo_mes.em_campo.text        = f_nombre_mes(Dec(uo_mes.em_codigo.text))
uo_companyia.em_codigo.text = "1"
uo_companyia.triggerEvent("modificado")
f_activar_campo(uo_companyia.em_campo)


end event

on w_int_notificacion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.uo_companyia=create uo_companyia
this.ddlb_situacion=create ddlb_situacion
this.cb_borrar=create cb_borrar
this.gb_5=create gb_5
this.gb_3=create gb_3
this.cbx_cobrados=create cbx_cobrados
this.cbx_no_cobrados=create cbx_no_cobrados
this.em_anyo=create em_anyo
this.uo_mes=create uo_mes
this.st_1=create st_1
this.st_2=create st_2
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.uo_companyia
this.Control[iCurrent+6]=this.ddlb_situacion
this.Control[iCurrent+7]=this.cb_borrar
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.cbx_cobrados
this.Control[iCurrent+11]=this.cbx_no_cobrados
this.Control[iCurrent+12]=this.em_anyo
this.Control[iCurrent+13]=this.uo_mes
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on w_int_notificacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.uo_companyia)
destroy(this.ddlb_situacion)
destroy(this.cb_borrar)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.cbx_cobrados)
destroy(this.cbx_no_cobrados)
destroy(this.em_anyo)
destroy(this.uo_mes)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_notificacion
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_notificacion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_notificacion
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_notificacion
integer x = 2711
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_listado_detalle from datawindow within w_int_notificacion
boolean visible = false
integer x = 96
integer width = 562
integer height = 340
boolean bringtotop = true
string dataobject = "report_consulta_facturas_pdtes_notificar"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_int_notificacion
integer x = 2715
integer y = 272
integer width = 119
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;string   companyia,situacion,cobrado[1 to 2]
datetime fecha_desde,fecha_hasta

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text
situacion = ddlb_situacion.text

if cbx_cobrados.checked then
	cobrado[1]	 = "S"
end if

if cbx_no_cobrados.checked then
	cobrado[2]	 = "N"
end if

dw_listado_detalle.Retrieve(codigo_empresa,companyia,situacion,cobrado,fecha_desde,fecha_hasta)	
f_imprimir_datawindow(dw_listado_detalle)


end event

type dw_detalle from datawindow within w_int_notificacion
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 9
integer y = 388
integer width = 2834
integer height = 1064
string dataobject = "dw_int_notificacion1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then  return
String marca,valor,var_empresa

Dec{0} var_anyo,var_orden

var_empresa = f_valor_columna(dw_detalle,row,"empresa")
var_anyo    = Dec(f_valor_columna(dw_detalle,row,"anyo"))
var_orden   = dec(f_valor_columna(dw_detalle,row,"seglinventas_orden"))
//var_recibo  = Dec(f_valor_columna(dw_detalle,row,"recibo"))

IF row <> 0 then 
	if isnull(this.object.seglinventas_fecha_notificacion[row]) then
		IF f_valor_columna(dw_detalle,row,"declarado") = "N" Then
			marca = ""
			valor = "S"
		ELSE
			marca = "X"
			valor ="N"
		END IF
	
		f_asignar_columna(dw_detalle,row,"declarado",valor)
		
		Update seglinventas
		Set    seglinventas.declarado  = :valor			 
		Where  seglinventas.empresa    = :var_empresa
		And    seglinventas.anyo       = :var_anyo
		And    seglinventas.orden      = :var_orden;
		COMMIT;
	end if
END IF

end event

type uo_companyia from u_em_campo_2 within w_int_notificacion
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 27
integer y = 280
integer width = 1079
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_companyia.em_campo.text=f_nombre_segcompanyia(codigo_empresa,uo_companyia.em_codigo.text)
If Trim(uo_companyia.em_campo.text)="" then
	uo_companyia.em_campo.text=""
	uo_companyia.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de compañias"
ue_datawindow ="dw_ayuda_segcompanyias"
ue_filtro = ""

end event

on uo_companyia.destroy
call u_em_campo_2::destroy
end on

type ddlb_situacion from dropdownlistbox within w_int_notificacion
integer x = 1138
integer y = 280
integer width = 512
integer height = 384
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "No solicitado"
boolean allowedit = true
boolean vscrollbar = true
string item[] = {"No solicitado","Primera venta","Solicitado","Denegado","Concedido"}
borderstyle borderstyle = stylelowered!
end type

type cb_borrar from u_boton within w_int_notificacion
event clicked pbm_bnclicked
integer x = 2446
integer y = 272
integer width = 270
integer height = 96
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;string   companyia,situacion,cobrado[1 to 2]
datetime fecha_desde,fecha_hasta

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text
situacion = ddlb_situacion.text

if cbx_cobrados.checked then
	cobrado[1]	 = "S"
end if

if cbx_no_cobrados.checked then
	cobrado[2]	 = "N"
end if

dw_detalle.Retrieve(codigo_empresa,companyia,situacion,cobrado,fecha_desde,fecha_hasta)	


end event

type gb_5 from groupbox within w_int_notificacion
integer x = 1170
integer y = 92
integer width = 1673
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_int_notificacion
integer x = 2432
integer y = 232
integer width = 416
integer height = 148
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cbx_cobrados from checkbox within w_int_notificacion
integer x = 1664
integer y = 304
integer width = 334
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cobrados"
end type

type cbx_no_cobrados from checkbox within w_int_notificacion
integer x = 2002
integer y = 304
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Cobrados"
end type

type em_anyo from u_em_campo within w_int_notificacion
integer x = 183
integer y = 140
integer taborder = 20
end type

type uo_mes from u_em_campo_2 within w_int_notificacion
event getfocus pbm_custom04
event destroy ( )
integer x = 617
integer y = 140
integer width = 530
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mes.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_mes.em_campo.text=f_nombre_mes(Dec(uo_mes.em_codigo.text))
If Trim(uo_mes.em_campo.text)="" then
	uo_mes.em_campo.text=""
	uo_mes.em_codigo.text=""
	Return
end if 

end event

type st_1 from statictext within w_int_notificacion
integer x = 27
integer y = 152
integer width = 137
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_notificacion
integer x = 462
integer y = 152
integer width = 146
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Mes:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_int_notificacion
integer x = 14
integer y = 92
integer width = 1157
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_int_notificacion
integer x = 14
integer y = 232
integer width = 1111
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Compañia"
end type

type gb_2 from groupbox within w_int_notificacion
integer x = 1125
integer y = 232
integer width = 1307
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Situación"
end type

