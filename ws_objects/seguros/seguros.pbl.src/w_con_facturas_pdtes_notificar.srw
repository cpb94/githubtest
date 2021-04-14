$PBExportHeader$w_con_facturas_pdtes_notificar.srw
forward
global type w_con_facturas_pdtes_notificar from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturas_pdtes_notificar
end type
type dw_listado_detalle from datawindow within w_con_facturas_pdtes_notificar
end type
type uo_1 from u_manejo_datawindow within w_con_facturas_pdtes_notificar
end type
type pb_2 from upb_imprimir within w_con_facturas_pdtes_notificar
end type
type rb_detalle from radiobutton within w_con_facturas_pdtes_notificar
end type
type rb_resumen from radiobutton within w_con_facturas_pdtes_notificar
end type
type dw_listado_resumen from datawindow within w_con_facturas_pdtes_notificar
end type
type cb_1 from u_boton within w_con_facturas_pdtes_notificar
end type
type dw_resumen from datawindow within w_con_facturas_pdtes_notificar
end type
type dw_detalle from datawindow within w_con_facturas_pdtes_notificar
end type
end forward

global type w_con_facturas_pdtes_notificar from w_int_con_empresa
integer width = 2926
integer height = 1660
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
uo_1 uo_1
pb_2 pb_2
rb_detalle rb_detalle
rb_resumen rb_resumen
dw_listado_resumen dw_listado_resumen
cb_1 cb_1
dw_resumen dw_resumen
dw_detalle dw_detalle
end type
global w_con_facturas_pdtes_notificar w_con_facturas_pdtes_notificar

type variables
string filtro,moneda
String tipo

end variables

event ue_listar;
IF tipo= "D" Then
	dw_report  = dw_listado_detalle
ELSE
	dw_report  = dw_listado_resumen
END IF
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa)	
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta facturas pendientes de notificar"
This.title=istr_parametros.s_titulo_ventana
tipo = "D"
dw_detalle.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"fra",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"ln_importe",f_mascara_decimales(0))
f_mascara_columna(dw_resumen,"total_importe",f_mascara_decimales(0))

f_mascara_columna(dw_detalle,"imp",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"imp_cli",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_imp_decla",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_imp_no_decla",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"imp_total",f_mascara_decimales(0))


dw_resumen.SetTransObject(SQLCA)



end event

on w_con_facturas_pdtes_notificar.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.uo_1=create uo_1
this.pb_2=create pb_2
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.dw_listado_resumen=create dw_listado_resumen
this.cb_1=create cb_1
this.dw_resumen=create dw_resumen
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.rb_detalle
this.Control[iCurrent+6]=this.rb_resumen
this.Control[iCurrent+7]=this.dw_listado_resumen
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_resumen
this.Control[iCurrent+10]=this.dw_detalle
end on

on w_con_facturas_pdtes_notificar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.uo_1)
destroy(this.pb_2)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.dw_listado_resumen)
destroy(this.cb_1)
destroy(this.dw_resumen)
destroy(this.dw_detalle)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturas_pdtes_notificar
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturas_pdtes_notificar
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturas_pdtes_notificar
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_facturas_pdtes_notificar
integer x = 2683
integer y = 4
integer width = 137
integer height = 120
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado_detalle from datawindow within w_con_facturas_pdtes_notificar
boolean visible = false
integer x = 101
integer width = 494
integer height = 152
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_facturas_pdtes_notificar3"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_facturas_pdtes_notificar
integer x = 14
integer y = 100
integer width = 622
integer height = 148
end type

event valores;call super::valores;IF tipo ="D" Then
	dw_data       = dw_detalle
ELSE
	dw_data       = dw_resumen
END IF
dw_data.SetTransObject(SQLCA)

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_con_facturas_pdtes_notificar
integer x = 489
integer y = 148
integer taborder = 0
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type rb_detalle from radiobutton within w_con_facturas_pdtes_notificar
integer x = 654
integer y = 148
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
boolean lefttext = true
end type

event clicked;This.ChecKed = TRUE
rb_resumen.ChecKed = FALSE
tipo = "D"
end event

type rb_resumen from radiobutton within w_con_facturas_pdtes_notificar
integer x = 960
integer y = 144
integer width = 325
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Resumen"
boolean lefttext = true
end type

event clicked;This.ChecKed = TRUE
rb_detalle.ChecKed = FALSE
tipo = "R"
end event

type dw_listado_resumen from datawindow within w_con_facturas_pdtes_notificar
boolean visible = false
integer x = 654
integer width = 494
integer height = 152
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_facturas_pdtes_notificar2"
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_facturas_pdtes_notificar
integer x = 1358
integer y = 140
integer width = 329
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "&Consultar"
end type

event clicked;call super::clicked;dw_detalle.Reset()
dw_resumen.Reset()
dw_detalle.visible = FALSE
dw_resumen.visible = FALSE
IF tipo = "D" then
	dw_detalle.visible = TRUE
	dw_detalle.Retrieve(codigo_empresa)	
END IF
IF tipo = "R" then
	dw_resumen.visible = TRUE
	dw_resumen.Retrieve(codigo_empresa)
END IF
end event

type dw_resumen from datawindow within w_con_facturas_pdtes_notificar
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
boolean visible = false
integer x = 9
integer y = 248
integer width = 2569
integer height = 1160
integer taborder = 30
string dataobject = "dw_facturas_pdtes_notificar2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from datawindow within w_con_facturas_pdtes_notificar
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
boolean visible = false
integer x = 5
integer y = 244
integer width = 2825
integer height = 1172
boolean bringtotop = true
string dataobject = "dw_facturas_pdtes_notificar3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param

IF row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=string(This.GetItemNumber(row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(row,"orden"))
  OpenWithParm(wi_mant_seglinventas,lstr_param) 
End if

end event

