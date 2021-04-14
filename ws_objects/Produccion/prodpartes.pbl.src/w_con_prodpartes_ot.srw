$PBExportHeader$w_con_prodpartes_ot.srw
forward
global type w_con_prodpartes_ot from w_int_con_empresa
end type
type gb_g from groupbox within w_con_prodpartes_ot
end type
type pb_imprimir from upb_imprimir within w_con_prodpartes_ot
end type
type gb_1 from groupbox within w_con_prodpartes_ot
end type
type gb_4 from groupbox within w_con_prodpartes_ot
end type
type em_fdesde from u_em_campo within w_con_prodpartes_ot
end type
type em_fhasta from u_em_campo within w_con_prodpartes_ot
end type
type dw_1 from datawindow within w_con_prodpartes_ot
end type
type gb_3 from groupbox within w_con_prodpartes_ot
end type
type ddlb_turnos from dropdownlistbox within w_con_prodpartes_ot
end type
type cb_1 from u_boton within w_con_prodpartes_ot
end type
type cbx_1 from checkbox within w_con_prodpartes_ot
end type
type cbx_2 from checkbox within w_con_prodpartes_ot
end type
type pb_1 from upb_salir within w_con_prodpartes_ot
end type
type gb_5 from groupbox within w_con_prodpartes_ot
end type
type uo_articulo from u_em_campo_2 within w_con_prodpartes_ot
end type
type uo_seccion from u_em_campo_2 within w_con_prodpartes_ot
end type
type uo_linea from u_em_campo_2 within w_con_prodpartes_ot
end type
type cb_2 from commandbutton within w_con_prodpartes_ot
end type
type dw_con_calidad_inkcid from datawindow within w_con_prodpartes_ot
end type
type uo_familia from u_em_campo_2 within w_con_prodpartes_ot
end type
type uo_operario from u_em_campo_2 within w_con_prodpartes_ot
end type
type uo_submarca from u_em_campo_2 within w_con_prodpartes_ot
end type
type uo_ccc from u_marca_lista within w_con_prodpartes_ot
end type
type cb_3 from u_boton within w_con_prodpartes_ot
end type
type uo_lote from u_em_campo_2 within w_con_prodpartes_ot
end type
type gb_2 from groupbox within w_con_prodpartes_ot
end type
type gb_6 from groupbox within w_con_prodpartes_ot
end type
type gb_7 from groupbox within w_con_prodpartes_ot
end type
type gb_8 from groupbox within w_con_prodpartes_ot
end type
end forward

global type w_con_prodpartes_ot from w_int_con_empresa
integer width = 6377
integer height = 3452
gb_g gb_g
pb_imprimir pb_imprimir
gb_1 gb_1
gb_4 gb_4
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_1 dw_1
gb_3 gb_3
ddlb_turnos ddlb_turnos
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_seccion uo_seccion
uo_linea uo_linea
cb_2 cb_2
dw_con_calidad_inkcid dw_con_calidad_inkcid
uo_familia uo_familia
uo_operario uo_operario
uo_submarca uo_submarca
uo_ccc uo_ccc
cb_3 cb_3
uo_lote uo_lote
gb_2 gb_2
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
end type
global w_con_prodpartes_ot w_con_prodpartes_ot

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string seccion, linea, turno, articulo, familia, operario, submarca, ccc, lote
datetime fecha1, fecha2

uo_ccc.visible =false

if cbx_2.checked then
	dw_1.Modify("DataWindow.Trailer.4.Height=0") 
	dw_1.Modify("DataWindow.Detail.Height=0") 
end if

fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_seccion.em_codigo.text = "" or isnull(uo_seccion.em_codigo.text) then
	seccion = "%"
else
	seccion = uo_seccion.em_codigo.text
end if

if uo_linea.em_codigo.text = "" or isnull(uo_linea.em_codigo.text) then
	linea = "%"
else
	linea = uo_linea.em_codigo.text
end if

 choose case ddlb_turnos.text
	case "Mañana"
		turno = "1"
	case "Tarde"
		turno = "2"
	case "Noche"
		turno = "3"
	case else
		turno = "%"		
end choose

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

if uo_familia.em_codigo.text = "" or isnull(uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

if uo_submarca.em_codigo.text = "" or isnull(uo_submarca.em_codigo.text) then
	submarca = "%"
else
	submarca = uo_submarca.em_codigo.text
end if

if uo_operario.em_codigo.text = "" or isnull(uo_operario.em_codigo.text) then
	operario = "%"
else
	operario = uo_operario.em_codigo.text
end if

if uo_lote.em_codigo.text = "" or isnull(uo_lote.em_codigo.text) then
	lote = "%"
else
	lote = uo_lote.em_codigo.text
end if


long ll_indice
string ls_filtro_ccc, ls_ccc
boolean sin = false

for ll_indice = 1 to uo_ccc.dw_marca.rowcount()
	if uo_ccc.dw_marca.getitemstring(ll_indice,"marca")="S" then
		
		ls_ccc = uo_ccc.dw_marca.getitemstring(ll_indice,"codigo")

		if ls_ccc = '' then 
			sin = true
		end if		
		
		if ls_filtro_ccc = "" then
			ls_filtro_ccc = "'"+ls_ccc+"'"
		else
			ls_filtro_ccc += ",'"+ls_ccc+"'"
		end if

	end if
next

if trim(ls_filtro_ccc) <> "" then
	ls_filtro_ccc = "articulos_colecciones_ccc in (" + ls_filtro_ccc + ")"
	if sin then
		ls_filtro_ccc = "( " + ls_filtro_ccc + " or isnull(articulos_colecciones_ccc) )"
	end if
	dw_1.setfilter(ls_filtro_ccc)
	dw_1.filter()
	
end if

dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo, familia, operario, submarca, lote)

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if










end subroutine

on w_con_prodpartes_ot.create
int iCurrent
call super::create
this.gb_g=create gb_g
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.gb_4=create gb_4
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_1=create dw_1
this.gb_3=create gb_3
this.ddlb_turnos=create ddlb_turnos
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_seccion=create uo_seccion
this.uo_linea=create uo_linea
this.cb_2=create cb_2
this.dw_con_calidad_inkcid=create dw_con_calidad_inkcid
this.uo_familia=create uo_familia
this.uo_operario=create uo_operario
this.uo_submarca=create uo_submarca
this.uo_ccc=create uo_ccc
this.cb_3=create cb_3
this.uo_lote=create uo_lote
this.gb_2=create gb_2
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_g
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.em_fdesde
this.Control[iCurrent+6]=this.em_fhasta
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.ddlb_turnos
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.cbx_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.gb_5
this.Control[iCurrent+15]=this.uo_articulo
this.Control[iCurrent+16]=this.uo_seccion
this.Control[iCurrent+17]=this.uo_linea
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.dw_con_calidad_inkcid
this.Control[iCurrent+20]=this.uo_familia
this.Control[iCurrent+21]=this.uo_operario
this.Control[iCurrent+22]=this.uo_submarca
this.Control[iCurrent+23]=this.uo_ccc
this.Control[iCurrent+24]=this.cb_3
this.Control[iCurrent+25]=this.uo_lote
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.gb_6
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.gb_8
end on

on w_con_prodpartes_ot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_g)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_1)
destroy(this.gb_3)
destroy(this.ddlb_turnos)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_seccion)
destroy(this.uo_linea)
destroy(this.cb_2)
destroy(this.dw_con_calidad_inkcid)
destroy(this.uo_familia)
destroy(this.uo_operario)
destroy(this.uo_submarca)
destroy(this.uo_ccc)
destroy(this.cb_3)
destroy(this.uo_lote)
destroy(this.gb_2)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
end on

event open;call super::open;integer permiso

istr_parametros.s_titulo_ventana =   "Consulta de Partes de Producción"
istr_parametros.s_listado        =   "dw_con_prodpartes_ot"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fdesde.text = em_fhasta.text 

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_con_calidad_inkcid.SetTransObject(SQLCA)

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
	case 1
//		cbx_facturacion.Visible = false
//		menu_planificacion.m_archivo.m_grabar.disable()
//		menu_planificacion.m_herramientas.m_borrarseleccin.disable()
//		menu_planificacion.m_herramientas.m_moverantes.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_herramientas.m_borrarot.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_procesos.disable()
//		menu_planificacion.m_procesos.m_generar1.disable()
//		menu_planificacion.m_seleccionar.disable()
//		menu_planificacion.m_listados.disable()
end choose


uo_ccc.f_cargar_datos("dw_ayuda_colecciones_ccc","%","","Codigo","Descripción")

uo_ccc.dw_marca.InsertRow(1)
uo_ccc.dw_marca.object.marca[1]  = 'S'
uo_ccc.dw_marca.object.codigo[1] = ''
uo_ccc.dw_marca.object.texto[1]  = 'SIN CCC'


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prodpartes_ot
integer x = 2313
integer y = 2232
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prodpartes_ot
boolean visible = false
integer x = 1253
integer y = 1752
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prodpartes_ot
integer x = 37
integer y = 8
integer width = 3749
integer textsize = -9
end type

type gb_g from groupbox within w_con_prodpartes_ot
integer x = 2263
integer y = 96
integer width = 379
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sección"
end type

type pb_imprimir from upb_imprimir within w_con_prodpartes_ot
event clicked pbm_bnclicked
integer x = 6226
integer y = 136
integer taborder = 0
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type gb_1 from groupbox within w_con_prodpartes_ot
integer x = 2647
integer y = 96
integer width = 608
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_4 from groupbox within w_con_prodpartes_ot
integer x = 1495
integer y = 96
integer width = 411
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Turno"
end type

type em_fdesde from u_em_campo within w_con_prodpartes_ot
integer x = 2656
integer y = 152
integer width = 288
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_prodpartes_ot
integer x = 2958
integer y = 152
integer width = 288
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_1 from datawindow within w_con_prodpartes_ot
integer x = 18
integer y = 276
integer width = 6281
integer height = 2932
string dataobject = "dw_con_prodpartes_ot"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event clicked;window lw_ventana
str_parametros lstr_param

integer n_argumentos = 3
string argumentos [3]

if dwo.name = 'b_coste' then 
	
	argumentos[1] = string(dw_1.object.prodpartes_ot_articulo[row])
	argumentos[2] = "Partes"
	argumentos[3] = string(dw_1.object.lote[row])
	
	lstr_param.i_nargumentos = n_argumentos
	
	lstr_param.s_argumentos = argumentos
	
	OpenWithParm(lw_ventana,lstr_param,"w_con_coste_articulo3")
	
	
end if
end event

type gb_3 from groupbox within w_con_prodpartes_ot
integer x = 1911
integer y = 96
integer width = 343
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Línea"
end type

type ddlb_turnos from dropdownlistbox within w_con_prodpartes_ot
integer x = 1509
integer y = 152
integer width = 384
integer height = 312
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Mañana","Tarde","Noche","Todos"}
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_boton within w_con_prodpartes_ot
integer x = 5870
integer y = 140
integer width = 347
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type cbx_1 from checkbox within w_con_prodpartes_ot
integer x = 5509
integer y = 40
integer width = 256
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
boolean lefttext = true
end type

event clicked;if cbx_1.checked = true then
	cbx_2.checked = false
	cbx_1.checked = true
	dw_1.Modify("DataWindow.Detail.Height=72")
else
	cbx_2.checked = true
	cbx_1.checked = false
	dw_1.Modify("DataWindow.Detail.Height=0")
end if
end event

type cbx_2 from checkbox within w_con_prodpartes_ot
integer x = 5815
integer y = 40
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumen"
boolean lefttext = true
end type

event clicked;if cbx_2.checked = true then
	cbx_1.checked = false
	cbx_2.checked = true
	dw_1.Modify("DataWindow.Detail.Height=0")
else
	cbx_1.checked = true
	cbx_2.checked = false
	dw_1.Modify("DataWindow.Detail.Height=72")
end if
end event

type pb_1 from upb_salir within w_con_prodpartes_ot
integer x = 6158
integer y = 12
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_con_prodpartes_ot
integer x = 23
integer y = 96
integer width = 1467
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 37
integer y = 152
integer width = 1440
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type uo_seccion from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 2277
integer y = 152
integer width = 352
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_seccion.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_seccion.em_campo.text=f_nombre_seccion_abr(codigo_empresa,uo_seccion.em_codigo.text)
IF Trim(uo_seccion.em_campo.text)="" THEN 
 IF Trim(uo_seccion.em_codigo.text)<>"" Then uo_seccion.em_campo.SetFocus()
 uo_seccion.em_campo.text=""
 uo_seccion.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de secciones"
ue_datawindow = "dw_ayuda_secciones"
ue_filtro     = ""

end event

type uo_linea from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 1925
integer y = 152
integer width = 315
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_linea.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_linea.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_linea.em_codigo.text)
IF Trim(uo_linea.em_campo.text)="" THEN 
 IF Trim(uo_linea.em_codigo.text)<>"" Then uo_linea.em_campo.SetFocus()
 uo_linea.em_campo.text=""
 uo_linea.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = "activo = 'S'"

end event

type cb_2 from commandbutton within w_con_prodpartes_ot
integer x = 5449
integer y = 144
integer width = 430
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calidad Inkcid"
end type

event clicked;datetime fechad, fechah

fechad = datetime(date(em_fdesde.text))
fechah = datetime(date(em_fhasta.text))

dw_con_calidad_inkcid.visible = not dw_con_calidad_inkcid.visible

if dw_con_calidad_inkcid.visible then
	dw_con_calidad_inkcid.retrieve(codigo_empresa, fechad, fechah )
else
	dw_con_calidad_inkcid.reset()
end if

/*
select /*articulos.descripcion ,buenas, malas */ sum(buenas), sum(malas) , 
sum (buenas * formatos.ancho * formatos.largo /10000), sum (malas * formatos.ancho * formatos.largo /10000)
from prodpartes_ot, articulos, art_codestadistico, formatos
where prodpartes_ot.empresa = articulos.empresa
and prodpartes_ot.art_encajado = articulos.codigo
and articulos.empresa = art_codestadistico.empresa
and articulos.codigo = art_codestadistico.codigo
and prodpartes_ot.empresa = formatos.empresa
and prodpartes_ot.formato = formatos.codigo
and art_codestadistico.inkcid = 'S'
and art_codestadistico.g4 = '3F'
and prodpartes_ot.operacion = '3'

*/
end event

type dw_con_calidad_inkcid from datawindow within w_con_prodpartes_ot
boolean visible = false
integer x = 1408
integer y = 276
integer width = 3278
integer height = 2940
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_calidad_inkcid"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if dwo.name = 'prodpartes_ot_buenas_t' then
	this.SetSort("buenas_articulo d")
	this.Sort()
end if

if dwo.name = 'prodpartes_ot_malas_t' then
	this.SetSort("malas_articulo d")
	this.Sort()
end if

if dwo.name = 'metros_buenas_t' then
	this.SetSort("m_buenas_articulo d")
	this.Sort()
end if

if dwo.name = 'metros_malas_t' then
	this.SetSort("m_malas_articulo d")
	this.Sort()
end if

if dwo.name = 't_calidad_piezas' then
	this.SetSort("calidad_piezas d")
	this.Sort()
end if

if dwo.name = 't_calidad_metros' then
	this.SetSort("calidad_metros d")
	this.Sort()
end if

end event

type uo_familia from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 3273
integer y = 152
integer width = 466
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text=f_nombre_familia(codigo_empresa,this.em_codigo.text)
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF

uo_submarca.em_campo.text=""
uo_submarca.em_codigo.text=""



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type uo_operario from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 4201
integer y = 152
integer width = 393
integer height = 80
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_operario.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;
uo_operario.em_campo.text=f_nombre_almoperarios_abr(codigo_empresa,uo_operario.em_codigo.text)
IF Trim(uo_operario.em_campo.text)="" THEN 
 IF Trim(uo_operario.em_codigo.text) <> "" Then
	uo_operario.em_campo.SetFocus()
END IF
 uo_operario.em_campo.text  = ""
 uo_operario.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de operarios"
ue_datawindow = "dw_ayuda_operarios"
ue_filtro     = ""

end event

type uo_submarca from u_em_campo_2 within w_con_prodpartes_ot
integer x = 3762
integer y = 152
integer width = 411
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Submarcas"
ue_datawindow = "dw_ayuda_submarcas"
if uo_familia.em_codigo.text <> "" then
	ue_filtro     = "familias_codigo = '"+uo_familia.em_codigo.text+"'"
else
	ue_filtro     = ""
end if

end event

event modificado;call super::modificado;this.em_campo.text=f_submarcas_descripcion(codigo_empresa,"","",this.em_codigo.text)
IF Trim(this.em_campo.text)="" THEN 
 IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
 this.em_campo.text=""
 this.em_codigo.text=""
END IF

end event

on uo_submarca.destroy
call u_em_campo_2::destroy
end on

type uo_ccc from u_marca_lista within w_con_prodpartes_ot
event destroy ( )
boolean visible = false
integer x = 4224
integer y = 292
integer width = 1454
integer height = 652
integer taborder = 170
boolean bringtotop = true
boolean border = false
end type

on uo_ccc.destroy
call u_marca_lista::destroy
end on

type cb_3 from u_boton within w_con_prodpartes_ot
integer x = 5042
integer y = 144
integer width = 430
integer height = 92
integer taborder = 0
boolean bringtotop = true
string text = "Sel CCC"
end type

event clicked;uo_ccc.visible = not(uo_ccc.visible)

end event

type uo_lote from u_em_campo_2 within w_con_prodpartes_ot
event destroy ( )
integer x = 4622
integer y = 152
integer width = 393
integer height = 80
integer taborder = 130
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_lote.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;

uo_lote.em_campo.text=uo_lote.em_codigo.text
IF Trim(uo_lote.em_campo.text)="" THEN 
 IF Trim(uo_lote.em_codigo.text) <> "" Then
	uo_lote.em_campo.SetFocus()
END IF
 uo_lote.em_campo.text  = ""
 uo_lote.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_titulo 	     = "AYUDA SELECCION DE LOTES"
ue_datawindow	  = "dw_ayuda_lotes"


if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	ue_filtro	  = ""
else
	ue_filtro	  = "articulo =  '"+uo_articulo.em_codigo.text+"' "
end if


end event

type gb_2 from groupbox within w_con_prodpartes_ot
integer x = 4192
integer y = 96
integer width = 411
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Operario"
end type

type gb_6 from groupbox within w_con_prodpartes_ot
integer x = 3259
integer y = 96
integer width = 489
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Familia"
end type

type gb_7 from groupbox within w_con_prodpartes_ot
integer x = 3753
integer y = 96
integer width = 434
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Submarca"
end type

type gb_8 from groupbox within w_con_prodpartes_ot
integer x = 4613
integer y = 96
integer width = 411
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lote"
end type

