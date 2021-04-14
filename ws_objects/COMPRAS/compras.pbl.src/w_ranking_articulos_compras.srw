$PBExportHeader$w_ranking_articulos_compras.srw
forward
global type w_ranking_articulos_compras from w_int_con_empresa
end type
type uo_proveedor from u_em_campo_2 within w_ranking_articulos_compras
end type
type uo_manejo from u_manejo_datawindow within w_ranking_articulos_compras
end type
type gb_5 from groupbox within w_ranking_articulos_compras
end type
type gb_1 from groupbox within w_ranking_articulos_compras
end type
type cb_3 from commandbutton within w_ranking_articulos_compras
end type
type dw_1 from u_datawindow within w_ranking_articulos_compras
end type
type em_desde from u_em_campo within w_ranking_articulos_compras
end type
type em_hasta from u_em_campo within w_ranking_articulos_compras
end type
type gb_3 from groupbox within w_ranking_articulos_compras
end type
type pb_imp from upb_imprimir within w_ranking_articulos_compras
end type
type uo_mprima from u_em_campo_2 within w_ranking_articulos_compras
end type
type gb_2 from groupbox within w_ranking_articulos_compras
end type
type pb_1 from upb_salir within w_ranking_articulos_compras
end type
type dw_listado from u_datawindow within w_ranking_articulos_compras
end type
type gb_7 from groupbox within w_ranking_articulos_compras
end type
type cb_tipos_materias from commandbutton within w_ranking_articulos_compras
end type
type cb_familias from commandbutton within w_ranking_articulos_compras
end type
type uo_productos from u_marca_lista within w_ranking_articulos_compras
end type
type uo_familias from u_marca_lista within w_ranking_articulos_compras
end type
end forward

shared variables
string pul='N'
end variables

global type w_ranking_articulos_compras from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 3689
integer height = 3968
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
cb_tipos_materias cb_tipos_materias
cb_familias cb_familias
uo_productos uo_productos
uo_familias uo_familias
end type
global w_ranking_articulos_compras w_ranking_articulos_compras

type variables
string estado
boolean detalle = false
string ante_articulo
string tipos_materias_marcadas[]
end variables

event open;call super::open;long indice

istr_parametros.s_titulo_ventana="Ranking Artículos Compras"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
em_desde.text=string(date(year(today()),1,1))
em_hasta.text=string(today())
///////////////
istr_parametros = Message.PowerObjectParm
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Codigo","Tipo de materia")

for indice =1 to uo_productos.dw_marca.rowcount()
	tipos_materias_marcadas[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next
///////////////////
f_activar_campo(uo_mprima.em_campo)


end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_ranking_articulos_compras.create
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
this.cb_tipos_materias=create cb_tipos_materias
this.cb_familias=create cb_familias
this.uo_productos=create uo_productos
this.uo_familias=create uo_familias
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
this.Control[iCurrent+16]=this.cb_tipos_materias
this.Control[iCurrent+17]=this.cb_familias
this.Control[iCurrent+18]=this.uo_productos
this.Control[iCurrent+19]=this.uo_familias
end on

on w_ranking_articulos_compras.destroy
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
destroy(this.cb_tipos_materias)
destroy(this.cb_familias)
destroy(this.uo_productos)
destroy(this.uo_familias)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_ranking_articulos_compras
integer x = 544
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_ranking_articulos_compras
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_ranking_articulos_compras
integer width = 3392
integer height = 92
boolean italic = true
end type

type uo_proveedor from u_em_campo_2 within w_ranking_articulos_compras
integer x = 2039
integer y = 152
integer width = 1253
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

type uo_manejo from u_manejo_datawindow within w_ranking_articulos_compras
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

type gb_5 from groupbox within w_ranking_articulos_compras
integer x = 3310
integer y = 96
integer width = 146
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ranking_articulos_compras
integer x = 2025
integer y = 96
integer width = 1285
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

type cb_3 from commandbutton within w_ranking_articulos_compras
integer x = 3319
integer y = 132
integer width = 128
integer height = 112
integer taborder = 100
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
string filtro_productos, filtro_familias
long productos_selecionados , familias_seleccionadas 

string var_proveedor,array_productos[], array_familias[]
string var_tipo_materia,var_familia,var_codigo_familia,var_filtro_familia
long   indice_array,indice,total


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

uo_familias.visible = false
uo_productos.visible = false

if uo_proveedor.em_codigo.text = "" then
	var_proveedor = "%"
else
	var_proveedor = uo_proveedor.em_codigo.text
end if

//---------------------------------------------------------------------------------------------------------------
//									FILTRO DE PRODUCTOS
//---------------------------------------------------------------------------------------------------------------

filtro_productos = ""
productos_selecionados = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_productos) = "" then
			filtro_productos = "'"+ uo_productos.dw_marca.getitemstring(indice,"codigo") +"'"
//			array_productos[indice] = ""
		else
			filtro_productos = filtro_productos+",'"+uo_productos.dw_marca.getitemstring(indice,"codigo")+"'"
//			array_productos[indice] = uo_productos.dw_marca.getitemstring(indice,"codigo")
		end if
		productos_selecionados ++
		array_productos[productos_selecionados ] = uo_productos.dw_marca.getitemstring(indice,"codigo")
		
	end if
next

//---------------------------------------------------------------------------------------------------------------
//								FIN DEL FILTRO DE PRODUCTOS
//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
//									FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------
filtro_familias = ""
familias_seleccionadas = 0
for indice = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_familias) = "" then
			filtro_familias = "'"+ uo_familias.dw_marca.getitemstring(indice,"codigo") +"'"
//			array_familias[indice] = ""
		else
			filtro_familias = filtro_familias+",'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
//			array_familias[indice] = uo_familias.dw_marca.getitemstring(indice,"codigo")
		end if
		
		long pos_barra
		pos_barra = Pos(uo_familias.dw_marca.getitemstring(indice,"codigo"), "/")

		familias_seleccionadas ++
//		array_familias[familias_seleccionadas] = uo_familias.dw_marca.getitemstring(indice,"codigo")
		array_familias[familias_seleccionadas] = Mid(uo_familias.dw_marca.getitemstring(indice,"codigo"), pos_barra + 1)		
	end if
next


//---------------------------------------------------------------------------------------------------------------
//								FIN DEL FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------

total = dw_1.retrieve(codigo_empresa, fd, fh, mprima, prov, array_productos, array_familias)


//	dw_1.setfilter("venmprima.familia in("+filtro_familias+" )" )
//	dw_1.filter()
//	dw_1.sort()
//	dw_1.groupcalc()
//	dw_1.setredraw(true)
//	dw_1.filter()
//	dw_1.sort()
//	dw_1.groupcalc()
//	dw_1.setredraw(true)
//


/*

indice_array = 0
var_filtro_familia = ""


for indice = 1 to uo_tipo_materia.dw_marca.rowcount()
	if uo_tipo_materia.dw_marca.getitemstring(indice,"marca") = "S" then
		indice_array ++
		array_tipo_materias[indice_array] = uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")
		if var_filtro_familia = "" then
			var_filtro_familia = "'"+uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")+"/'"
		else
			var_filtro_familia = var_filtro_familia+",'"+uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")+"/'"
		end if
   end if
next

for indice = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice,"marca") = "S" then
		indice_array ++
		array_tipo_materias[indice_array] = uo_familias.dw_marca.getitemstring(indice,"codigo")
		if var_filtro_familia = "" then
			var_filtro_familia = "'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		else
			var_filtro_familia = var_filtro_familia+",'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
   end if
next

//	total = dw_1.retrieve(codigo_empresa,fd,fh,mprima,prov,array_tipo_materias)

if indice_array > 0 then
	dw_1.setfilter("")
	dw_1.setredraw(false)

	total = dw_1.retrieve(codigo_empresa,fd,fh,mprima,prov,array_tipo_materias)
	if total > 0 then
		for indice = 1 to total
			var_tipo_materia   = dw_1.object.venmprima_tipo_materia[indice]
			if isnull(var_tipo_materia) then 
				var_tipo_materia = ""
				dw_1.object.venmprima_tipo_materia[indice] = ""
			end if
			var_familia        = dw_1.object.venmprima_familia[indice]
			if isnull(var_familia) then 
				var_familia = ""
				dw_1.object.venmprima_familia[indice] = ""
			end if
			var_codigo_familia = var_tipo_materia+"/"+var_familia
//			dw_1.object.comcabfac_codigo_familia[indice] = var_codigo_familia
		next
	end if	
	dw_1.setfilter("venmprima.familia in("+var_filtro_familia+")")
//	dw_1.setfilter("comcabfac_codigo_familia in("+var_filtro_familia+")")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
	dw_1.setredraw(true)
else
	messagebox("Atención","Debe seleccionar al menos un tipo de materia")
end if



//dw_1.setredraw(false)
////dw_1.groupcalc()
//dw_1.setsort("importe_total_calc D")
//dw_1.sort()
//dw_1.setredraw(true)

//estado="FECHA"
//dw_1.setredraw(false)
//dw_1.modify("DataWindow.Trailer.1.Height = 0")
//dw_1.modify("DataWindow.Trailer.2.Height = 0")
//dw_1.setsort("empresa,fecha_fac,proveedor,mprima")
//dw_1.sort()
//dw_1.groupcalc()
//dw_1.setredraw(true)

*/
end event

type dw_1 from u_datawindow within w_ranking_articulos_compras
integer x = 9
integer y = 348
integer width = 3598
integer height = 3400
integer taborder = 50
string dataobject = "dw_ranking_articulos_compras"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;

if isnull(dwo) or rowcount()=0 then return
long i
choose case dwo.name
	case "st_cantidad"
		setredraw(false)
		setsort("cantidad D")
		sort()
		groupcalc()
		setredraw(true)
	case "st_importe"
		setredraw(false)
		setsort("importe D")
		sort()
		groupcalc()
		setredraw(true)
		
end choose		


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

type em_desde from u_em_campo within w_ranking_articulos_compras
integer x = 18
integer y = 152
integer width = 274
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type em_hasta from u_em_campo within w_ranking_articulos_compras
integer x = 297
integer y = 152
integer width = 274
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type gb_3 from groupbox within w_ranking_articulos_compras
integer y = 96
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

type pb_imp from upb_imprimir within w_ranking_articulos_compras
event clicked pbm_bnclicked
integer x = 3465
integer y = 132
integer width = 128
integer height = 112
integer taborder = 0
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

//dw_listado.Retrieve(codigo_empresa,fd,fh,mprima,prov)



f_imprimir_datawindow(dw_1)

end event

type uo_mprima from u_em_campo_2 within w_ranking_articulos_compras
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 603
integer y = 152
integer width = 1408
integer taborder = 30
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

type gb_2 from groupbox within w_ranking_articulos_compras
integer x = 585
integer y = 96
integer width = 1440
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

type pb_1 from upb_salir within w_ranking_articulos_compras
integer x = 3483
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type dw_listado from u_datawindow within w_ranking_articulos_compras
event clicked pbm_dwnlbuttonclk
integer x = 3383
integer y = 72
integer width = 87
integer height = 44
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

type gb_7 from groupbox within w_ranking_articulos_compras
integer x = 3456
integer y = 96
integer width = 146
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_tipos_materias from commandbutton within w_ranking_articulos_compras
integer x = 2651
integer y = 256
integer width = 466
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipos Materias"
end type

event clicked;uo_familias.visible = false
uo_productos.visible = not(uo_productos.visible)

end event

type cb_familias from commandbutton within w_ranking_articulos_compras
integer x = 3122
integer y = 256
integer width = 466
integer height = 88
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;long    indice,indice2,total2,indice3,donde
datastore familias
string  sel,tipo_materia,familia,tipo_materia_linea,codigo_familia
string  codigo_materia_familia,codigo_materia,descripcion_familia
boolean salir

for indice =1 to uo_productos.dw_marca.rowcount()
	if tipos_materias_marcadas[indice] <> uo_productos.dw_marca.getitemstring(indice,"marca") then
		tipo_materia = uo_productos.dw_marca.getitemstring(indice,"codigo")		
		if tipos_materias_marcadas[indice] = "S" then
			//Debemos eliminar las familias de ese tipo de materia	
			total2  = uo_familias.dw_marca.rowcount() 
			for indice2 = 1 to total2
				codigo_materia_familia = uo_familias.dw_marca.getitemstring(indice2,"codigo")		
				indice3 = 0
				codigo_materia = ""
				salir = false
				do 
					indice3 ++
					if mid(codigo_materia_familia,indice3,1) <> "/" then
						codigo_materia = codigo_materia + mid(codigo_materia_familia,indice3,1)
					else
						salir = true
					end if					
				loop until salir or indice3 = len(codigo_materia_familia)
				if codigo_materia = tipo_materia then
					uo_familias.dw_marca.deleterow(indice2)
					total2  = uo_familias.dw_marca.rowcount() 
					indice2 = indice2 -1
				end if
			next
		else
			//Debemos añadir las familias de ese tipo de materia			
			sel = "select familia,descripcion "+&
					"from venfamilias "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and tipo_materia = '"+tipo_materia+"'"
					
			//familias = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, familias)
			total2  = familias.rowcount()
			for indice2 = 1 to total2
				familia             = familias.object.familia[indice2]
				descripcion_familia = familias.object.descripcion[indice2] 
				donde = uo_familias.dw_marca.insertrow(uo_familias.dw_marca.rowcount()+1)
				uo_familias.dw_marca.setitem(donde,"codigo",tipo_materia+"/"+familia)				
				uo_familias.dw_marca.setitem(donde,"texto",descripcion_familia)				
			next
		end if
		tipos_materias_marcadas[indice] = uo_productos.dw_marca.getitemstring(indice,"marca")
	end if
next
destroy familias
uo_productos.visible = false
uo_familias.visible     = not(uo_familias.visible)
end event

type uo_productos from u_marca_lista within w_ranking_articulos_compras
event destroy ( )
boolean visible = false
integer x = 1824
integer y = 352
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type uo_familias from u_marca_lista within w_ranking_articulos_compras
event destroy ( )
boolean visible = false
integer x = 2254
integer y = 352
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

