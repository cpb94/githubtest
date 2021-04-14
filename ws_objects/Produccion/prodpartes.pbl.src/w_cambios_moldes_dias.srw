$PBExportHeader$w_cambios_moldes_dias.srw
forward
global type w_cambios_moldes_dias from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_cambios_moldes_dias
end type
type gb_1 from groupbox within w_cambios_moldes_dias
end type
type em_fdesde from u_em_campo within w_cambios_moldes_dias
end type
type em_fhasta from u_em_campo within w_cambios_moldes_dias
end type
type dw_1 from datawindow within w_cambios_moldes_dias
end type
type gb_3 from groupbox within w_cambios_moldes_dias
end type
type cb_1 from u_boton within w_cambios_moldes_dias
end type
type pb_1 from upb_salir within w_cambios_moldes_dias
end type
type gb_5 from groupbox within w_cambios_moldes_dias
end type
type uo_articulo from u_em_campo_2 within w_cambios_moldes_dias
end type
type uo_molde from u_em_campo_2 within w_cambios_moldes_dias
end type
type uo_dias from u_em_campo_2 within w_cambios_moldes_dias
end type
type gb_6 from groupbox within w_cambios_moldes_dias
end type
end forward

global type w_cambios_moldes_dias from w_int_con_empresa
integer width = 3456
integer height = 3108
pb_imprimir pb_imprimir
gb_1 gb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_1 dw_1
gb_3 gb_3
cb_1 cb_1
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_molde uo_molde
uo_dias uo_dias
gb_6 gb_6
end type
global w_cambios_moldes_dias w_cambios_moldes_dias

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_calcular_cambios ()
end prototypes

public subroutine f_control (datawindow data);string molde, linea, turno, articulo, filtro, seccion
datetime fecha1, fecha2

fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_molde.em_codigo.text = "" or isnull(uo_molde.em_codigo.text) then
	molde = "%"
else
	molde = uo_molde.em_codigo.text
end if

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if













end subroutine

public subroutine f_calcular_cambios ();datastore reg

string consulta



consulta = ""
end subroutine

on w_cambios_moldes_dias.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_1=create dw_1
this.gb_3=create gb_3
this.cb_1=create cb_1
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_molde=create uo_molde
this.uo_dias=create uo_dias
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.em_fdesde
this.Control[iCurrent+4]=this.em_fhasta
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.gb_5
this.Control[iCurrent+10]=this.uo_articulo
this.Control[iCurrent+11]=this.uo_molde
this.Control[iCurrent+12]=this.uo_dias
this.Control[iCurrent+13]=this.gb_6
end on

on w_cambios_moldes_dias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_1)
destroy(this.gb_3)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_molde)
destroy(this.uo_dias)
destroy(this.gb_6)
end on

event open;call super::open;integer permiso

istr_parametros.s_titulo_ventana =   "Consulta de Partes de Producción y calidades"
istr_parametros.s_listado        =   "dw_con_prodpartes_calidad"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

em_fdesde.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fhasta.text  = string(RelativeDate(today(), - 1),"dd-mm-yy")

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)


uo_dias.em_campo.text = "15"

/*
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

*/


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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambios_moldes_dias
integer taborder = 100
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambios_moldes_dias
boolean visible = false
integer x = 2062
integer y = 1796
integer width = 178
integer height = 48
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambios_moldes_dias
integer width = 3250
integer textsize = -8
end type

type pb_imprimir from upb_imprimir within w_cambios_moldes_dias
event clicked pbm_bnclicked
integer x = 3109
integer y = 148
integer taborder = 0
end type

event clicked;

PArent.triggerEvent("ue_listar")



end event

type gb_1 from groupbox within w_cambios_moldes_dias
integer x = 896
integer y = 84
integer width = 837
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type em_fdesde from u_em_campo within w_cambios_moldes_dias
integer x = 914
integer y = 144
integer width = 361
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_cambios_moldes_dias
integer x = 1298
integer y = 144
integer width = 361
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_1 from datawindow within w_cambios_moldes_dias
integer x = 27
integer y = 312
integer width = 3232
integer height = 2588
string dataobject = "dw_cambios_moldes_dias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event clicked;
string ordenar



choose case dwo.name
		
	case "ot_t"
		
		ordenar = "prodpartes_ot_ot desc"
		
	case "codigo_articulo_t"
		
		ordenar = "prodpartes_ot_articulo desc"
		
	case "descripcion_t"
	
		ordenar = "articulos_descripcion desc"
	
	case "formato_t"
	
		ordenar = "formatos_abreviado desc"
	
	case "operacion_t"
	
		ordenar = "art_ver_tipooperacion_descripcion_abr desc"
	
	case "buenas_ot"

		ordenar = "buenas asc"
	
	case "malas_ot"
	
		ordenar = "malas asc"
	
	case "calidad_ot"
	
		ordenar = "calidad desc"
		
end choose


this.setsort(ordenar)

this.sort()
end event

type gb_3 from groupbox within w_cambios_moldes_dias
integer x = 603
integer y = 84
integer width = 283
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Molde"
end type

type cb_1 from u_boton within w_cambios_moldes_dias
integer x = 2615
integer y = 152
integer width = 379
integer height = 88
integer taborder = 90
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_cambios_moldes_dias
integer x = 3287
integer y = 20
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_cambios_moldes_dias
integer x = 23
integer y = 84
integer width = 576
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within w_cambios_moldes_dias
event destroy ( )
integer x = 46
integer y = 140
integer width = 526
integer taborder = 10
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

type uo_molde from u_em_campo_2 within w_cambios_moldes_dias
event destroy ( )
integer x = 622
integer y = 144
integer width = 247
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_molde.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_molde.em_campo.text=f_nombre_molde(codigo_empresa,uo_molde.em_codigo.text)

IF Trim(uo_molde.em_campo.text)="" THEN 
 IF Trim(uo_molde.em_codigo.text)<>"" Then uo_molde.em_campo.SetFocus()
 uo_molde.em_campo.text=""
 uo_molde.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type uo_dias from u_em_campo_2 within w_cambios_moldes_dias
event destroy ( )
integer x = 1915
integer y = 148
integer width = 247
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_dias.destroy
call u_em_campo_2::destroy
end on

type gb_6 from groupbox within w_cambios_moldes_dias
integer x = 1742
integer y = 84
integer width = 585
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Días entre cambios"
end type

