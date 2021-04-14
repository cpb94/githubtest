$PBExportHeader$w_con_comlinfac_fechas.srw
forward
global type w_con_comlinfac_fechas from w_int_con_empresa
end type
type uo_proveedor from u_em_campo_2 within w_con_comlinfac_fechas
end type
type uo_manejo from u_manejo_datawindow within w_con_comlinfac_fechas
end type
type gb_5 from groupbox within w_con_comlinfac_fechas
end type
type gb_1 from groupbox within w_con_comlinfac_fechas
end type
type cb_3 from commandbutton within w_con_comlinfac_fechas
end type
type dw_1 from u_datawindow within w_con_comlinfac_fechas
end type
type em_desde from u_em_campo within w_con_comlinfac_fechas
end type
type em_hasta from u_em_campo within w_con_comlinfac_fechas
end type
type gb_3 from groupbox within w_con_comlinfac_fechas
end type
type pb_imp from upb_imprimir within w_con_comlinfac_fechas
end type
type uo_mprima from u_em_campo_2 within w_con_comlinfac_fechas
end type
type gb_2 from groupbox within w_con_comlinfac_fechas
end type
type pb_1 from upb_salir within w_con_comlinfac_fechas
end type
type dw_listado from u_datawindow within w_con_comlinfac_fechas
end type
type gb_7 from groupbox within w_con_comlinfac_fechas
end type
end forward

shared variables
string pul='N'
end variables

global type w_con_comlinfac_fechas from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 4475
integer height = 2468
string icon = "Application!"
uo_proveedor uo_proveedor
uo_manejo uo_manejo
gb_5 gb_5
gb_1 gb_1
cb_3 cb_3
dw_1 dw_1
em_desde em_desde
em_hasta em_hasta
gb_3 gb_3
pb_imp pb_imp
uo_mprima uo_mprima
gb_2 gb_2
pb_1 pb_1
dw_listado dw_listado
gb_7 gb_7
end type
global w_con_comlinfac_fechas w_con_comlinfac_fechas

type variables
string estado
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Facturas"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_desde.text=string(date(year(today()),1,1))
em_hasta.text=string(today())
f_activar_campo(uo_mprima.em_campo)
end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_con_comlinfac_fechas.create
int iCurrent
call super::create
this.uo_proveedor=create uo_proveedor
this.uo_manejo=create uo_manejo
this.gb_5=create gb_5
this.gb_1=create gb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.gb_3=create gb_3
this.pb_imp=create pb_imp
this.uo_mprima=create uo_mprima
this.gb_2=create gb_2
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_proveedor
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.em_hasta
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.pb_imp
this.Control[iCurrent+11]=this.uo_mprima
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.dw_listado
this.Control[iCurrent+15]=this.gb_7
end on

on w_con_comlinfac_fechas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_proveedor)
destroy(this.uo_manejo)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.gb_3)
destroy(this.pb_imp)
destroy(this.uo_mprima)
destroy(this.gb_2)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.gb_7)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_comlinfac_fechas
integer x = 544
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_comlinfac_fechas
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_comlinfac_fechas
integer width = 4101
integer height = 96
integer textsize = -12
long textcolor = 8388608
end type

type uo_proveedor from u_em_campo_2 within w_con_comlinfac_fechas
integer x = 2514
integer y = 156
integer width = 1527
integer taborder = 50
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

type uo_manejo from u_manejo_datawindow within w_con_comlinfac_fechas
event valores pbm_custom01
boolean visible = false
integer x = 1417
integer y = 348
integer width = 613
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_5 from groupbox within w_con_comlinfac_fechas
integer x = 4073
integer y = 96
integer width = 146
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_comlinfac_fechas
integer x = 2501
integer y = 100
integer width = 1559
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
borderstyle borderstyle = styleraised!
end type

type cb_3 from commandbutton within w_con_comlinfac_fechas
integer x = 4082
integer y = 132
integer width = 128
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;datetime fd,fh
string mprima,prov

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

if uo_mprima.em_campo.text="" then
	mprima="%"
else
	mprima=uo_mprima.em_codigo.text
end if

if uo_proveedor.em_campo.text="" then
	prov="%"
else
	prov=uo_proveedor.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,fd,fh,mprima,prov)

//estado="FECHA"
//dw_1.setredraw(false)
//dw_1.modify("DataWindow.Trailer.1.Height = 0")
//dw_1.modify("DataWindow.Trailer.2.Height = 0")
//dw_1.setsort("empresa,fecha_fac,proveedor,mprima")
//dw_1.sort()
//dw_1.groupcalc()
//dw_1.setredraw(true)


end event

type dw_1 from u_datawindow within w_con_comlinfac_fechas
integer x = 18
integer y = 268
integer width = 4384
integer height = 1988
integer taborder = 60
string dataobject = "dw_con_comlinfac_fechas"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;//if isnull(dwo) or rowcount()=0 then return
//long i
//choose case dwo.name
//	case "t_fecha"
//		estado="FECHA"
//		setredraw(false)
//		modify("DataWindow.Trailer.1.Height = 0")
//		modify("DataWindow.Trailer.2.Height = 0")
//		setsort("empresa,fecha_fac,proveedor,mprima")
//		sort()
//		groupcalc()
//		setredraw(true)
//		
//	case "t_prov"
//		estado="PROV"		
//		setredraw(false)
//		modify("DataWindow.Trailer.1.Height = 65")
//		modify("DataWindow.Trailer.2.Height = 65")
//		for i=1 to rowcount()
//			setitem(i,"grupo1",getitemstring(i,"proveedor"))
//			setitem(i,"grupo2",getitemstring(i,"mprima"))
//		next	
//		setsort("empresa,proveedor,mprima,fecha_fac")
//		sort()
//		groupcalc()
//		setredraw(true)
//
//	case "t_prima"
//		estado="MP"		
//		modify("DataWindow.Trailer.1.Height = 65")
//		modify("DataWindow.Trailer.2.Height = 65")
//		setredraw(false)
//		for i=1 to rowcount()
//			setitem(i,"grupo1",getitemstring(i,"mprima"))
//			setitem(i,"grupo2",getitemstring(i,"proveedor"))
//		next	
//		setsort("empresa,mprima,proveedor,fecha_fac")
//		sort()
//		groupcalc()
//		setredraw(true)
//		
//	case else
//		
//end choose
end event

type em_desde from u_em_campo within w_con_comlinfac_fechas
integer x = 18
integer y = 156
integer width = 274
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type em_hasta from u_em_campo within w_con_comlinfac_fechas
integer x = 297
integer y = 156
integer width = 274
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type gb_3 from groupbox within w_con_comlinfac_fechas
integer y = 100
integer width = 585
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha"
borderstyle borderstyle = styleraised!
end type

type pb_imp from upb_imprimir within w_con_comlinfac_fechas
event clicked pbm_bnclicked
integer x = 4229
integer y = 132
integer width = 128
integer height = 112
integer taborder = 20
boolean originalsize = false
string picturename = "print!"
end type

event clicked;datetime fd,fh
string mprima,prov

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

if uo_mprima.em_campo.text="" then
	mprima="%"
else
	mprima=uo_mprima.em_codigo.text
end if

if uo_proveedor.em_campo.text="" then
	prov="%"
else
	prov=uo_proveedor.em_codigo.text
end if

dw_listado.Retrieve(codigo_empresa,fd,fh,mprima,prov)

long i
choose case estado
	case "FECHA"
		dw_listado.modify("DataWindow.Trailer.1.Height = 0")
		dw_listado.modify("DataWindow.Trailer.2.Height = 0")		
		dw_listado.setsort("empresa,fecha_fac,proveedor,mprima")
		dw_listado.sort()
		dw_listado.groupcalc()
		
	case "PROV"		
		dw_listado.modify("DataWindow.Trailer.1.Height = 65")
		dw_listado.modify("DataWindow.Trailer.2.Height = 65")
		for i=1 to dw_listado.rowcount()
			dw_listado.setitem(i,"grupo1",dw_listado.getitemstring(i,"proveedor"))
			dw_listado.setitem(i,"grupo2",dw_listado.getitemstring(i,"mprima"))
		next	
		dw_listado.setsort("empresa,proveedor,mprima,fecha_fac")
		dw_listado.sort()
		dw_listado.groupcalc()

	case "MP"		
		dw_listado.modify("DataWindow.Trailer.1.Height = 65")
		dw_listado.modify("DataWindow.Trailer.2.Height = 65")		
		for i=1 to dw_listado.rowcount()
			dw_listado.setitem(i,"grupo1",dw_listado.getitemstring(i,"mprima"))
			dw_listado.setitem(i,"grupo2",dw_listado.getitemstring(i,"proveedor"))
		next	
		dw_listado.setsort("empresa,mprima,proveedor,fecha_fac")
		dw_listado.sort()
		dw_listado.groupcalc()
		
	case else
		
end choose

f_imprimir_datawindow(dw_listado)

end event

type uo_mprima from u_em_campo_2 within w_con_comlinfac_fechas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 603
integer y = 156
integer width = 1865
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mprima.em_campo.text=f_nombre_mprima(codigo_empresa,uo_mprima.em_codigo.text)
If Trim(uo_mprima.em_campo.text)="" Then
	If Trim(uo_mprima.em_codigo.text)<>"" then uo_mprima.em_campo.SetFocus()
	uo_mprima.em_campo.text=""
	uo_mprima.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima2"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_mprima.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_comlinfac_fechas
integer x = 585
integer y = 100
integer width = 1897
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_con_comlinfac_fechas
integer x = 4247
integer width = 123
integer height = 116
integer taborder = 0
end type

type dw_listado from u_datawindow within w_con_comlinfac_fechas
event clicked pbm_dwnlbuttonclk
integer x = 4142
integer y = 16
integer width = 82
integer height = 84
integer taborder = 0
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

type gb_7 from groupbox within w_con_comlinfac_fechas
integer x = 4219
integer y = 96
integer width = 146
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

