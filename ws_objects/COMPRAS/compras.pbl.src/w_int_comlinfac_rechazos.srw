$PBExportHeader$w_int_comlinfac_rechazos.srw
forward
global type w_int_comlinfac_rechazos from w_int_con_empresa
end type
type uo_proveedor from u_em_campo_2 within w_int_comlinfac_rechazos
end type
type uo_manejo from u_manejo_datawindow within w_int_comlinfac_rechazos
end type
type gb_1 from groupbox within w_int_comlinfac_rechazos
end type
type cb_3 from commandbutton within w_int_comlinfac_rechazos
end type
type dw_1 from u_datawindow within w_int_comlinfac_rechazos
end type
type em_desde from u_em_campo within w_int_comlinfac_rechazos
end type
type em_hasta from u_em_campo within w_int_comlinfac_rechazos
end type
type gb_3 from groupbox within w_int_comlinfac_rechazos
end type
type uo_mprima from u_em_campo_2 within w_int_comlinfac_rechazos
end type
type gb_2 from groupbox within w_int_comlinfac_rechazos
end type
type pb_1 from upb_salir within w_int_comlinfac_rechazos
end type
type dw_listado from u_datawindow within w_int_comlinfac_rechazos
end type
type em_rechazo from u_em_campo within w_int_comlinfac_rechazos
end type
type gb_6 from groupbox within w_int_comlinfac_rechazos
end type
type gb_5 from groupbox within w_int_comlinfac_rechazos
end type
type rb_rechazos from radiobutton within w_int_comlinfac_rechazos
end type
type rb_abonos from radiobutton within w_int_comlinfac_rechazos
end type
end forward

shared variables
string pul='N'
end variables

global type w_int_comlinfac_rechazos from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2935
integer height = 2780
string icon = "Application!"
uo_proveedor uo_proveedor
uo_manejo uo_manejo
gb_1 gb_1
cb_3 cb_3
dw_1 dw_1
em_desde em_desde
em_hasta em_hasta
gb_3 gb_3
uo_mprima uo_mprima
gb_2 gb_2
pb_1 pb_1
dw_listado dw_listado
em_rechazo em_rechazo
gb_6 gb_6
gb_5 gb_5
rb_rechazos rb_rechazos
rb_abonos rb_abonos
end type
global w_int_comlinfac_rechazos w_int_comlinfac_rechazos

type variables
string estado
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Rechazar/Abonar Líneas de Facturas"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_desde.text=string(date(year(today()),1,1))
em_hasta.text=string(today())
em_rechazo.text=string(today())
f_activar_campo(uo_mprima.em_campo)
end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_int_comlinfac_rechazos.create
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
this.uo_mprima=create uo_mprima
this.gb_2=create gb_2
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.em_rechazo=create em_rechazo
this.gb_6=create gb_6
this.gb_5=create gb_5
this.rb_rechazos=create rb_rechazos
this.rb_abonos=create rb_abonos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_proveedor
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.em_desde
this.Control[iCurrent+7]=this.em_hasta
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.uo_mprima
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.em_rechazo
this.Control[iCurrent+14]=this.gb_6
this.Control[iCurrent+15]=this.gb_5
this.Control[iCurrent+16]=this.rb_rechazos
this.Control[iCurrent+17]=this.rb_abonos
end on

on w_int_comlinfac_rechazos.destroy
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
destroy(this.uo_mprima)
destroy(this.gb_2)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.em_rechazo)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.rb_rechazos)
destroy(this.rb_abonos)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_comlinfac_rechazos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_comlinfac_rechazos
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_comlinfac_rechazos
integer x = 9
integer y = 12
integer width = 2725
end type

type uo_proveedor from u_em_campo_2 within w_int_comlinfac_rechazos
integer x = 1458
integer y = 172
integer width = 786
integer height = 72
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

type uo_manejo from u_manejo_datawindow within w_int_comlinfac_rechazos
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

type gb_1 from groupbox within w_int_comlinfac_rechazos
integer x = 1435
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

type cb_3 from commandbutton within w_int_comlinfac_rechazos
integer x = 2688
integer y = 152
integer width = 174
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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
//if rb_abonos.checked then
//	dw_1.setfilter("comlinfac_rechazada = 'S' ")	
//else
//	dw_1.setfilter("comlinfac_abonada <> 'S' ")	
//end if

dw_1.Retrieve(codigo_empresa,fd,fh,mprima,prov)


dw_1.setredraw(false)
dw_1.filter()
dw_1.setsort("empresa,fecha_fac,proveedor,mprima")
dw_1.sort()
dw_1.groupcalc()
dw_1.setredraw(true)


end event

type dw_1 from u_datawindow within w_int_comlinfac_rechazos
integer y = 380
integer width = 2871
integer height = 2196
integer taborder = 80
string dataobject = "dw_int_comlinfac_rechazos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;string factura,proveedor,abonada,rechazada
long anyo,linea
datetime fecha_rechazada,fecha_abonada
if row > 0 then
	factura   = dw_1.object.factura[row]
	proveedor = dw_1.object.proveedor[row]
	anyo      = dw_1.object.anyo[row]
	linea     = dw_1.object.linea[row]
	rechazada = dw_1.object.comlinfac_rechazada[row]
	if isnull(rechazada) then rechazada = "N"
	abonada   = dw_1.object.comlinfac_abonada[row]
	if isnull(abonada) then abonada = "N"	
	if rb_rechazos.checked then
		if rechazada = "S" then
			if abonada <> "S" then
				
				update comlinfac
				set rechazada = "N",fecha_rechazo = null,
					 abonada   = "N",fecha_abono   = null				
				where empresa   = :codigo_empresa
				and   anyo      = :anyo
				and   proveedor = :proveedor
				and   factura   = :factura
				and   linea     = :linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("Atención","Error al modificar la linea")
				else
					commit;
				end if
			end if
		else
			fecha_rechazada = datetime(date(em_rechazo.text))			
			
			update comlinfac
			set rechazada = "S",fecha_rechazo = :fecha_rechazada,
				 abonada   = "N",fecha_abono   = null
			where empresa   = :codigo_empresa
			and   anyo      = :anyo
			and   proveedor = :proveedor
			and   factura   = :factura
			and   linea     = :linea;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("Atención","Error al modificar la linea")
			else
				commit;
			end if
			
		end if
	else
		if abonada = "S" then
			
			update comlinfac
			set abonada = "N",fecha_abono = null				 
			where empresa   = :codigo_empresa
			and   anyo      = :anyo
			and   proveedor = :proveedor
			and   factura   = :factura
			and   linea     = :linea;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("Atención","Error al modificar la linea")
			else
				commit;
			end if
		else
			fecha_abonada = datetime(date(em_rechazo.text))						
			
			update comlinfac
			set abonada = "S",fecha_abono = :fecha_abonada				 
			where empresa   = :codigo_empresa
			and   anyo      = :anyo
			and   proveedor = :proveedor
			and   factura   = :factura
			and   linea     = :linea;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				messagebox("Atención","Error al modificar la linea")
			else
				commit;
			end if
			
		end if

	end if
end if
cb_3.triggerevent(clicked!)
end event

type em_desde from u_em_campo within w_int_comlinfac_rechazos
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

type em_hasta from u_em_campo within w_int_comlinfac_rechazos
integer x = 288
integer y = 172
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type gb_3 from groupbox within w_int_comlinfac_rechazos
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

type uo_mprima from u_em_campo_2 within w_int_comlinfac_rechazos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 585
integer y = 172
integer width = 818
integer height = 72
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

type gb_2 from groupbox within w_int_comlinfac_rechazos
integer x = 562
integer y = 116
integer width = 869
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_int_comlinfac_rechazos
integer x = 2752
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type dw_listado from u_datawindow within w_int_comlinfac_rechazos
event clicked pbm_dwnlbuttonclk
integer x = 2770
integer y = 44
integer width = 87
integer height = 44
integer taborder = 20
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

type em_rechazo from u_em_campo within w_int_comlinfac_rechazos
integer x = 2345
integer y = 172
integer width = 261
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type gb_6 from groupbox within w_int_comlinfac_rechazos
integer x = 2277
integer y = 116
integer width = 398
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "F Rechaz."
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_int_comlinfac_rechazos
integer x = 2679
integer y = 112
integer width = 192
integer height = 156
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type rb_rechazos from radiobutton within w_int_comlinfac_rechazos
integer x = 27
integer y = 288
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Rechazos"
boolean checked = true
end type

event clicked;if this.checked then
	gb_6.text = "F Rechaz."
end if
end event

type rb_abonos from radiobutton within w_int_comlinfac_rechazos
integer x = 370
integer y = 288
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Abonos"
end type

event clicked;if this.checked then
	gb_6.text = "F Abono"
end if
end event

