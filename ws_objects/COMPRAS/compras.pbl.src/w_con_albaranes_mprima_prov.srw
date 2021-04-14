$PBExportHeader$w_con_albaranes_mprima_prov.srw
$PBExportComments$€
forward
global type w_con_albaranes_mprima_prov from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_mprima_prov
end type
type dw_listado_primas from datawindow within w_con_albaranes_mprima_prov
end type
type pb_imprimir from upb_imprimir within w_con_albaranes_mprima_prov
end type
type em_fecha_desde from u_em_campo within w_con_albaranes_mprima_prov
end type
type em_fecha_hasta from u_em_campo within w_con_albaranes_mprima_prov
end type
type gb_4 from groupbox within w_con_albaranes_mprima_prov
end type
type gb_3 from groupbox within w_con_albaranes_mprima_prov
end type
type uo_proveedor from u_em_campo_2 within w_con_albaranes_mprima_prov
end type
type uo_prima from u_em_campo_2 within w_con_albaranes_mprima_prov
end type
type dw_primas from datawindow within w_con_albaranes_mprima_prov
end type
type gb_2 from groupbox within w_con_albaranes_mprima_prov
end type
type gb_1 from groupbox within w_con_albaranes_mprima_prov
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_mprima_prov
end type
type cb_1 from commandbutton within w_con_albaranes_mprima_prov
end type
end forward

global type w_con_albaranes_mprima_prov from w_int_con_empresa
integer x = 14
integer y = 48
integer width = 3634
integer height = 2056
string icon = "Application!"
pb_1 pb_1
dw_listado_primas dw_listado_primas
pb_imprimir pb_imprimir
em_fecha_desde em_fecha_desde
em_fecha_hasta em_fecha_hasta
gb_4 gb_4
gb_3 gb_3
uo_proveedor uo_proveedor
uo_prima uo_prima
dw_primas dw_primas
gb_2 gb_2
gb_1 gb_1
uo_manejo uo_manejo
cb_1 cb_1
end type
global w_con_albaranes_mprima_prov w_con_albaranes_mprima_prov

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Albaranes por M.Prima y Proveedor"
This.title=istr_parametros.s_titulo_ventana

dw_primas.SetTransObject(SQLCA)
dw_listado_primas.SetTransObject(SQLCA)

uo_proveedor.em_campo.setfocus()
em_fecha_desde.text = string(mdy(1,1,year(today())))
em_fecha_hasta.text = string(today())
end event

event ue_listar;string   proveedor,mprima
datetime fdesde,fhasta

proveedor = uo_proveedor.em_codigo.text
mprima    = uo_prima.em_codigo.text
fdesde    = datetime(date(em_fecha_desde.text))
fhasta    = datetime(date(em_fecha_hasta.text))

dw_listado_primas.Retrieve(codigo_empresa,proveedor,mprima,fdesde,fhasta)
f_imprimir_datawindow(dw_listado_primas)

end event

on w_con_albaranes_mprima_prov.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_primas=create dw_listado_primas
this.pb_imprimir=create pb_imprimir
this.em_fecha_desde=create em_fecha_desde
this.em_fecha_hasta=create em_fecha_hasta
this.gb_4=create gb_4
this.gb_3=create gb_3
this.uo_proveedor=create uo_proveedor
this.uo_prima=create uo_prima
this.dw_primas=create dw_primas
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_primas
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.em_fecha_desde
this.Control[iCurrent+5]=this.em_fecha_hasta
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.uo_proveedor
this.Control[iCurrent+9]=this.uo_prima
this.Control[iCurrent+10]=this.dw_primas
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.uo_manejo
this.Control[iCurrent+14]=this.cb_1
end on

on w_con_albaranes_mprima_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_primas)
destroy(this.pb_imprimir)
destroy(this.em_fecha_desde)
destroy(this.em_fecha_hasta)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.uo_proveedor)
destroy(this.uo_prima)
destroy(this.dw_primas)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_manejo)
destroy(this.cb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_primas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_primas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_mprima_prov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_mprima_prov
end type

event sle_opcion_orden::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_mprima_prov
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_albaranes_mprima_prov
integer x = 3465
integer y = 8
integer width = 123
integer height = 116
integer taborder = 0
end type

type dw_listado_primas from datawindow within w_con_albaranes_mprima_prov
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_albaranes_primas_prov"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_albaranes_mprima_prov
integer x = 3465
integer y = 144
integer width = 105
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;Parent.triggerevent("ue_listar")
f_activar_campo(uo_proveedor.em_campo)


end event

type em_fecha_desde from u_em_campo within w_con_albaranes_mprima_prov
integer x = 2217
integer y = 144
integer width = 270
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fecha_hasta from u_em_campo within w_con_albaranes_mprima_prov
integer x = 2501
integer y = 144
integer width = 274
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy!"
string displaydata = ""
end type

event modificado;call super::modificado;//dw_primas.Retrieve(codigo_empresa,em_proveedor.text,em_prima.text,datetime(date(string(em_fecha.text))),datetime(date(String(em_fecha2.text))))
end event

type gb_4 from groupbox within w_con_albaranes_mprima_prov
integer x = 2793
integer y = 100
integer width = 210
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_con_albaranes_mprima_prov
integer x = 2199
integer y = 100
integer width = 594
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha Albarán"
end type

type uo_proveedor from u_em_campo_2 within w_con_albaranes_mprima_prov
event destroy ( )
integer x = 18
integer y = 144
integer width = 1157
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text) = "" THEN 
	IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
END IF



end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
		ue_datawindow = "dw_ayuda_proveedores"
		ue_filtro     = ""

end event

type uo_prima from u_em_campo_2 within w_con_albaranes_mprima_prov
event destroy ( )
integer x = 1211
integer y = 144
integer width = 969
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_prima.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_prima.em_campo.text = f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
IF Trim(uo_prima.em_campo.text)="" THEN
	If Trim(uo_prima.em_codigo.text)<>"" THEN uo_prima.em_campo.SetFocus()
	uo_prima.em_campo.text=""
	uo_prima.em_codigo.text=""
END IF
end event

event getfocus;call super::getfocus;String proveedor

proveedor = uo_proveedor.em_codigo.text

ue_datawindow = "dw_ayuda_venmprima_compras"
ue_titulo     = "AYUDA SELECCION DE MATERIAS"
if trim(proveedor) <> "" then
	ue_filtro  = "proveedor = '" + proveedor+ "' or proveedor = '' OR IsNull(proveedor)"
else
	ue_filtro  = "" 
end if
valor_empresa = TRUE
end event

type dw_primas from datawindow within w_con_albaranes_mprima_prov
integer y = 252
integer width = 3589
integer height = 1596
string dataobject = "dw_con_albaranes_mprima_prov"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[3]=f_valor_columna(dw_primas,dw_primas.GetRow(),"comlinalb_anyo")
lstr_param.s_argumentos[2]= f_valor_columna(dw_primas,dw_primas.GetRow(),"comlinalb_albaran")
OpenWithParm(w_mant_comlinalb,lstr_param) 


end event

type gb_2 from groupbox within w_con_albaranes_mprima_prov
integer x = 1193
integer y = 100
integer width = 1006
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
end type

type gb_1 from groupbox within w_con_albaranes_mprima_prov
integer y = 100
integer width = 1193
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_mprima_prov
integer x = 2990
integer y = 96
integer width = 613
end type

event valores;call super::valores;dw_data=dw_primas
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_albaranes_mprima_prov
integer x = 2807
integer y = 140
integer width = 183
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;string   proveedor,mprima
datetime fdesde,fhasta

proveedor = uo_proveedor.em_codigo.text
mprima    = uo_prima.em_codigo.text
fdesde    = datetime(date(em_fecha_desde.text))
fhasta    = datetime(date(em_fecha_hasta.text))

dw_primas.Retrieve(codigo_empresa,proveedor,mprima,fdesde,fhasta)

end event

