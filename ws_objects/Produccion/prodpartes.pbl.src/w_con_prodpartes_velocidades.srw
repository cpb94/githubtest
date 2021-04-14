$PBExportHeader$w_con_prodpartes_velocidades.srw
forward
global type w_con_prodpartes_velocidades from w_int_con_empresa
end type
type gb_98 from groupbox within w_con_prodpartes_velocidades
end type
type gb_56 from groupbox within w_con_prodpartes_velocidades
end type
type gb_g from groupbox within w_con_prodpartes_velocidades
end type
type pb_imprimir from upb_imprimir within w_con_prodpartes_velocidades
end type
type gb_1 from groupbox within w_con_prodpartes_velocidades
end type
type gb_4 from groupbox within w_con_prodpartes_velocidades
end type
type em_fdesde from u_em_campo within w_con_prodpartes_velocidades
end type
type em_fhasta from u_em_campo within w_con_prodpartes_velocidades
end type
type dw_1 from datawindow within w_con_prodpartes_velocidades
end type
type gb_3 from groupbox within w_con_prodpartes_velocidades
end type
type ddlb_turnos from dropdownlistbox within w_con_prodpartes_velocidades
end type
type cb_1 from u_boton within w_con_prodpartes_velocidades
end type
type pb_1 from upb_salir within w_con_prodpartes_velocidades
end type
type gb_5 from groupbox within w_con_prodpartes_velocidades
end type
type uo_articulo from u_em_campo_2 within w_con_prodpartes_velocidades
end type
type uo_seccion from u_em_campo_2 within w_con_prodpartes_velocidades
end type
type uo_linea from u_em_campo_2 within w_con_prodpartes_velocidades
end type
type uo_version from u_em_campo_2 within w_con_prodpartes_velocidades
end type
type uo_operacion from u_em_campo_2 within w_con_prodpartes_velocidades
end type
type sle_mayor from singlelineedit within w_con_prodpartes_velocidades
end type
type sle_menor from singlelineedit within w_con_prodpartes_velocidades
end type
type st_2 from statictext within w_con_prodpartes_velocidades
end type
type st_3 from statictext within w_con_prodpartes_velocidades
end type
type cb_2 from u_boton within w_con_prodpartes_velocidades
end type
end forward

global type w_con_prodpartes_velocidades from w_int_con_empresa
integer width = 4562
integer height = 3156
gb_98 gb_98
gb_56 gb_56
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
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_seccion uo_seccion
uo_linea uo_linea
uo_version uo_version
uo_operacion uo_operacion
sle_mayor sle_mayor
sle_menor sle_menor
st_2 st_2
st_3 st_3
cb_2 cb_2
end type
global w_con_prodpartes_velocidades w_con_prodpartes_velocidades

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string seccion, linea, turno, articulo, v_version, operacion
datetime fecha1, fecha2

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

if uo_version.em_codigo.text = "" or isnull(uo_version.em_codigo.text) then
	v_version = "%"
else
	v_version = uo_version.em_codigo.text
end if

if uo_operacion.em_codigo.text = "" or isnull(uo_operacion.em_codigo.text) then
	operacion = "%"
else
	operacion = uo_operacion.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo, v_version, operacion)

if sle_mayor.text <> '' and sle_menor.text <> '' then
	dw_1.setfilter("velocidad > "+sle_mayor.text+" and velocidad < "+sle_menor.text)
	dw_1.filter()
end if

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if










end subroutine

on w_con_prodpartes_velocidades.create
int iCurrent
call super::create
this.gb_98=create gb_98
this.gb_56=create gb_56
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
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_seccion=create uo_seccion
this.uo_linea=create uo_linea
this.uo_version=create uo_version
this.uo_operacion=create uo_operacion
this.sle_mayor=create sle_mayor
this.sle_menor=create sle_menor
this.st_2=create st_2
this.st_3=create st_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_98
this.Control[iCurrent+2]=this.gb_56
this.Control[iCurrent+3]=this.gb_g
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.ddlb_turnos
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.gb_5
this.Control[iCurrent+15]=this.uo_articulo
this.Control[iCurrent+16]=this.uo_seccion
this.Control[iCurrent+17]=this.uo_linea
this.Control[iCurrent+18]=this.uo_version
this.Control[iCurrent+19]=this.uo_operacion
this.Control[iCurrent+20]=this.sle_mayor
this.Control[iCurrent+21]=this.sle_menor
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.cb_2
end on

on w_con_prodpartes_velocidades.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_98)
destroy(this.gb_56)
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
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_seccion)
destroy(this.uo_linea)
destroy(this.uo_version)
destroy(this.uo_operacion)
destroy(this.sle_mayor)
destroy(this.sle_menor)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_2)
end on

event open;call super::open;integer permiso

istr_parametros.s_titulo_ventana =   "Consulta de Partes de Producción y Velocidades"
istr_parametros.s_listado        =   "dw_con_prodpartes_velocidades"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

em_fdesde.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fhasta.text  = string(RelativeDate(today(), - 1),"dd-mm-yy")

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)

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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prodpartes_velocidades
integer taborder = 100
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prodpartes_velocidades
boolean visible = false
integer x = 2062
integer y = 1796
integer width = 178
integer height = 48
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prodpartes_velocidades
integer width = 3474
integer textsize = -8
end type

type gb_98 from groupbox within w_con_prodpartes_velocidades
integer x = 960
integer y = 84
integer width = 247
integer height = 160
integer taborder = 110
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Op."
end type

type gb_56 from groupbox within w_con_prodpartes_velocidades
integer x = 603
integer y = 84
integer width = 347
integer height = 160
integer taborder = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver."
end type

type gb_g from groupbox within w_con_prodpartes_velocidades
integer x = 1856
integer y = 84
integer width = 279
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sección"
end type

type pb_imprimir from upb_imprimir within w_con_prodpartes_velocidades
event clicked pbm_bnclicked
integer x = 4119
integer y = 132
integer taborder = 0
end type

event clicked;

PArent.triggerEvent("ue_listar")



end event

type gb_1 from groupbox within w_con_prodpartes_velocidades
integer x = 2139
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

type gb_4 from groupbox within w_con_prodpartes_velocidades
integer x = 1211
integer y = 84
integer width = 352
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turno"
end type

type em_fdesde from u_em_campo within w_con_prodpartes_velocidades
integer x = 2158
integer y = 144
integer width = 361
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_prodpartes_velocidades
integer x = 2542
integer y = 144
integer width = 361
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_1 from datawindow within w_con_prodpartes_velocidades
integer x = 27
integer y = 312
integer width = 4489
integer height = 2664
string dataobject = "dw_con_prodpartes_velocidades"
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

type gb_3 from groupbox within w_con_prodpartes_velocidades
integer x = 1568
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
string text = "Línea"
end type

type ddlb_turnos from dropdownlistbox within w_con_prodpartes_velocidades
integer x = 1230
integer y = 144
integer width = 320
integer height = 312
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Mañana","Tarde","Noche","Todos"}
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_boton within w_con_prodpartes_velocidades
integer x = 3666
integer y = 76
integer width = 379
integer height = 88
integer taborder = 90
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_prodpartes_velocidades
integer x = 4361
integer y = 36
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_con_prodpartes_velocidades
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

type uo_articulo from u_em_campo_2 within w_con_prodpartes_velocidades
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

type uo_seccion from u_em_campo_2 within w_con_prodpartes_velocidades
event destroy ( )
integer x = 1874
integer y = 144
integer width = 242
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

type uo_linea from u_em_campo_2 within w_con_prodpartes_velocidades
event destroy ( )
integer x = 1586
integer y = 144
integer width = 247
integer taborder = 50
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
ue_filtro     = ""

end event

type uo_version from u_em_campo_2 within w_con_prodpartes_velocidades
event destroy ( )
integer x = 622
integer y = 140
integer width = 311
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_version.destroy
call u_em_campo_2::destroy
end on

event modificado;string v_version

select descripcion
into :v_version
from art_versiones
where empresa = :codigo_empresa
and articulo = :uo_articulo.em_codigo.text
and version = :uo_version.em_codigo.text;

uo_version.em_campo.text =v_version

//IF Trim(uo_version.em_campo.text)="" THEN 
// IF Trim(uo_version.em_codigo.text)<>"" Then uo_version.em_campo.SetFocus()
// uo_version.em_campo.text=""
// uo_version.em_codigo.text=""
//END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Versiones"
ue_datawindow = "dw_ayuda_versiones"
ue_filtro     = ""
ue_filtro     = "articulo = '"+uo_articulo.em_codigo.text+"'"

end event

type uo_operacion from u_em_campo_2 within w_con_prodpartes_velocidades
event destroy ( )
integer x = 974
integer y = 140
integer width = 219
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_operacion.destroy
call u_em_campo_2::destroy
end on

event modificado;string v_operacion

select art_ver_tipooperacion.descripcion_abr
into :v_operacion
from art_ver_operaciones, art_ver_tipooperacion
where art_ver_operaciones.empresa = :codigo_empresa
and art_ver_tipooperacion.empresa = :codigo_empresa
and  art_ver_operaciones.tipo_operacion = art_ver_tipooperacion.codigo 
and art_ver_operaciones.articulo = :uo_articulo.em_codigo.text
and art_ver_operaciones.version = :uo_version.em_codigo.text
and art_ver_operaciones.orden = :uo_operacion.em_codigo.text;

uo_operacion.em_campo.text =v_operacion

IF Trim(uo_operacion.em_campo.text)="" THEN 
 	IF Trim(uo_operacion.em_codigo.text)<>"" Then uo_operacion.em_campo.SetFocus()
 	uo_operacion.em_campo.text=""
 	uo_operacion.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Operaciones"
ue_datawindow = "dw_ayuda_operaciones"
ue_filtro     = ""
ue_filtro     = "articulo = '"+uo_articulo.em_codigo.text+"' and version = '"+uo_version.em_codigo.text+"'"
//ue_filtro     = "version = '"+uo_version.em_codigo.text+"'"

end event

type sle_mayor from singlelineedit within w_con_prodpartes_velocidades
integer x = 3273
integer y = 84
integer width = 297
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_menor from singlelineedit within w_con_prodpartes_velocidades
integer x = 3273
integer y = 172
integer width = 297
integer height = 80
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_prodpartes_velocidades
integer x = 3026
integer y = 180
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vel. < :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_prodpartes_velocidades
integer x = 3017
integer y = 96
integer width = 242
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vel. > :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from u_boton within w_con_prodpartes_velocidades
integer x = 3666
integer y = 172
integer width = 379
integer height = 88
integer taborder = 100
boolean bringtotop = true
string text = "Grabar"
end type

event clicked;decimal segundos
integer i
time v_horainicio
time v_horafin

if MessageBox("Atención", "¿Desea Guardar los Cambios?", Exclamation!, YesNo!, 2) = 1 then
	dw_1.AcceptText()
	
	for i = 1 to dw_1.Rowcount() 
		if isnull(time(dw_1.object.prodpartes_ot_horainicio[i]) ) then	v_horainicio = time(00:00:00)	else	v_horainicio = time(dw_1.object.prodpartes_ot_horainicio[i])	
		if isnull(time(dw_1.object.prodpartes_ot_horafin[i])) then	v_horafin = time(00:00:00)	else	v_horafin = time(dw_1.object.prodpartes_ot_horafin[i])
		
		if secondsafter (v_horainicio, v_horafin) >= 0 then
			segundos = secondsafter (v_horainicio, v_horafin)
		else 
			segundos = secondsafter (v_horainicio, 23:59:59) + secondsafter (00:00:00, v_horafin)
		end if
		dw_1.object.prodpartes_ot_segundos[i] = segundos
	next
	
	if dw_1.update()<>1 then
		f_mensaje("Atención","Hubo un error al grabar")
		rollback;
	else
		commit;
	end if
end if


end event

