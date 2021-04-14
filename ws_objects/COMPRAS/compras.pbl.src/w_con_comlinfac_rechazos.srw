$PBExportHeader$w_con_comlinfac_rechazos.srw
forward
global type w_con_comlinfac_rechazos from w_int_con_empresa
end type
type uo_proveedor from u_em_campo_2 within w_con_comlinfac_rechazos
end type
type uo_manejo from u_manejo_datawindow within w_con_comlinfac_rechazos
end type
type gb_1 from groupbox within w_con_comlinfac_rechazos
end type
type cb_3 from commandbutton within w_con_comlinfac_rechazos
end type
type dw_1 from u_datawindow within w_con_comlinfac_rechazos
end type
type em_desde from u_em_campo within w_con_comlinfac_rechazos
end type
type em_hasta from u_em_campo within w_con_comlinfac_rechazos
end type
type gb_3 from groupbox within w_con_comlinfac_rechazos
end type
type pb_1 from upb_salir within w_con_comlinfac_rechazos
end type
type dw_listado from u_datawindow within w_con_comlinfac_rechazos
end type
type gb_5 from groupbox within w_con_comlinfac_rechazos
end type
end forward

shared variables
string pul='N'
end variables

global type w_con_comlinfac_rechazos from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2967
integer height = 1804
string icon = "Application!"
uo_proveedor uo_proveedor
uo_manejo uo_manejo
gb_1 gb_1
cb_3 cb_3
dw_1 dw_1
em_desde em_desde
em_hasta em_hasta
gb_3 gb_3
pb_1 pb_1
dw_listado dw_listado
gb_5 gb_5
end type
global w_con_comlinfac_rechazos w_con_comlinfac_rechazos

type variables
string estado
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Líneas Rechazadas Pendientes de Abono"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_desde.text=string(date(year(today()),1,1))
em_hasta.text=string(today())


end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_con_comlinfac_rechazos.create
int iCurrent
call super::create
this.uo_proveedor=create uo_proveedor
this.uo_manejo=create uo_manejo
this.gb_1=create gb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.gb_3=create gb_3
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_proveedor
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.em_desde
this.Control[iCurrent+7]=this.em_hasta
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.gb_5
end on

on w_con_comlinfac_rechazos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_proveedor)
destroy(this.uo_manejo)
destroy(this.gb_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.gb_3)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.gb_5)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_comlinfac_rechazos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_comlinfac_rechazos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_comlinfac_rechazos
integer x = 41
integer y = 12
integer width = 2679
end type

type uo_proveedor from u_em_campo_2 within w_con_comlinfac_rechazos
integer x = 585
integer y = 172
integer width = 786
integer height = 72
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_con_comlinfac_rechazos
event valores pbm_custom01
boolean visible = false
integer x = 1646
integer y = 100
integer width = 613
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_con_comlinfac_rechazos
integer x = 562
integer y = 116
integer width = 837
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
borderstyle borderstyle = styleraised!
end type

type cb_3 from commandbutton within w_con_comlinfac_rechazos
integer x = 1417
integer y = 152
integer width = 174
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;datetime fd,fh
string prov

if not isdate(em_desde.text) then
	em_desde.setfocus()
	return
else
	fd=datetime(date(em_desde.text))
end if

if not isdate(em_hasta.text) then
	em_hasta.setfocus()
	return
else
	fh=datetime(date(em_hasta.text))
end if

if uo_proveedor.em_campo.text="" then
	prov="%"
else
	prov=uo_proveedor.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,fd,fh,prov)


dw_1.setredraw(false)
dw_1.filter()
dw_1.setsort("empresa,proveedor,fecha_fac,mprima")
dw_1.sort()
dw_1.groupcalc()
dw_1.setredraw(true)


end event

type dw_1 from u_datawindow within w_con_comlinfac_rechazos
integer y = 284
integer width = 2871
integer height = 1288
integer taborder = 60
string dataobject = "dw_con_comlinfac_rechazos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type em_desde from u_em_campo within w_con_comlinfac_rechazos
integer x = 18
integer y = 172
integer height = 72
integer taborder = 10
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type em_hasta from u_em_campo within w_con_comlinfac_rechazos
integer x = 288
integer y = 172
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type gb_3 from groupbox within w_con_comlinfac_rechazos
integer x = 5
integer y = 116
integer width = 553
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha"
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_con_comlinfac_rechazos
integer x = 2752
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type dw_listado from u_datawindow within w_con_comlinfac_rechazos
event clicked pbm_dwnlbuttonclk
integer x = 2770
integer y = 44
integer width = 87
integer height = 44
integer taborder = 30
string dataobject = "report_con_comlinfac_fechas"
boolean vscrollbar = true
end type

event clicked;call super::clicked;if isnull(dwo) or rowcount()=0 then return
long i
choose case dwo.name
	case "t_fecha"
		setredraw(false)
		modify("DataWindow.Trailer.1.Height = 0")
		modify("DataWindow.Trailer.2.Height = 0")
		setsort("empresa,fecha_fac,proveedor,mprima")
		sort()
		groupcalc()
		setredraw(true)
		
	case "t_prov"
		setredraw(false)
		modify("DataWindow.Trailer.1.Height = 65")
		modify("DataWindow.Trailer.2.Height = 65")
		for i=1 to rowcount()
			setitem(i,"grupo1",getitemstring(i,"proveedor"))
			setitem(i,"grupo2",getitemstring(i,"mprima"))
		next	
		setsort("empresa,proveedor,mprima,fecha_fac")
		sort()
		groupcalc()
		setredraw(true)

	case "t_prima"
		modify("DataWindow.Trailer.1.Height = 65")
		modify("DataWindow.Trailer.2.Height = 65")
		setredraw(false)
		for i=1 to rowcount()
			setitem(i,"grupo1",getitemstring(i,"mprima"))
			setitem(i,"grupo2",getitemstring(i,"proveedor"))
		next	
		setsort("empresa,mprima,proveedor,fecha_fac")
		sort()
		groupcalc()
		setredraw(true)
		
	case else
		
end choose
end event

type gb_5 from groupbox within w_con_comlinfac_rechazos
integer x = 1408
integer y = 112
integer width = 192
integer height = 156
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

