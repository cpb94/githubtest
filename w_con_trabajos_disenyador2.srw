$PBExportHeader$w_con_trabajos_disenyador.srw
forward
global type w_con_trabajos_disenyador from w_int_con_empresa
end type
type gb_7 from groupbox within w_con_trabajos_disenyador
end type
type gb_8 from groupbox within w_con_trabajos_disenyador
end type
type pb_imprimir from upb_imprimir within w_con_trabajos_disenyador
end type
type cb_1 from u_boton within w_con_trabajos_disenyador
end type
type cbx_1 from checkbox within w_con_trabajos_disenyador
end type
type cbx_2 from checkbox within w_con_trabajos_disenyador
end type
type pb_1 from upb_salir within w_con_trabajos_disenyador
end type
type uo_disenyador from u_em_campo_2 within w_con_trabajos_disenyador
end type
type cb_grabar from u_boton within w_con_trabajos_disenyador
end type
type dw_resumen from u_datawindow within w_con_trabajos_disenyador
end type
type dw_resumen_serie from u_datawindow within w_con_trabajos_disenyador
end type
type dw_1 from u_datawindow within w_con_trabajos_disenyador
end type
end forward

global type w_con_trabajos_disenyador from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 4517
integer height = 2688
string title = "Consulta de artículos (cod. estadístico)"
gb_7 gb_7
gb_8 gb_8
pb_imprimir pb_imprimir
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
pb_1 pb_1
uo_disenyador uo_disenyador
cb_grabar cb_grabar
dw_resumen dw_resumen
dw_resumen_serie dw_resumen_serie
dw_1 dw_1
end type
global w_con_trabajos_disenyador w_con_trabajos_disenyador

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string disenyador, filtro

if uo_disenyador.em_codigo.text = "" or isnull(uo_disenyador.em_codigo.text) then
	disenyador = "%"
else
	disenyador = uo_disenyador.em_codigo.text
end if
dw_1.retrieve (codigo_empresa, disenyador)
dw_resumen.retrieve (codigo_empresa)
dw_resumen_serie.retrieve (codigo_empresa)
//filtro = " not isnull(destrabajo_fecha_fin) "
////filtro = " destrabajo_fecha_fin <> NULL "
//
//dw_1.SetFilter(filtro)
//dw_1.Filter()


//string filtro, molde
//string restriccion_global, restriccion_base, restriccion_molde
//datetime desde, hasta
//
//dw_1.reset()
//if cbx_2.checked then
//	dw_1.Modify("DataWindow.Trailer.4.Height=0") 
//	dw_1.Modify("DataWindow.Detail.Height=0") 
//end if
//
//if uo_molde.em_codigo.text = "" or isnull(uo_molde.em_codigo.text) then
//	molde = '%'
//else
//	molde = uo_molde.em_codigo.text
//end if
//
//filtro = ""
//			
//dw_1.SetFilter(filtro)
//dw_1.Filter()
//
//desde = datetime(date(em_fdesde.text))
//hasta = datetime(date(em_fhasta.text))
//dw_1.Retrieve(codigo_empresa,molde, desde, hasta )
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//end if
//
end subroutine

on w_con_trabajos_disenyador.create
int iCurrent
call super::create
this.gb_7=create gb_7
this.gb_8=create gb_8
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.pb_1=create pb_1
this.uo_disenyador=create uo_disenyador
this.cb_grabar=create cb_grabar
this.dw_resumen=create dw_resumen
this.dw_resumen_serie=create dw_resumen_serie
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_7
this.Control[iCurrent+2]=this.gb_8
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.cbx_2
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.uo_disenyador
this.Control[iCurrent+9]=this.cb_grabar
this.Control[iCurrent+10]=this.dw_resumen
this.Control[iCurrent+11]=this.dw_resumen_serie
this.Control[iCurrent+12]=this.dw_1
end on

on w_con_trabajos_disenyador.destroy
call super::destroy
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.pb_1)
destroy(this.uo_disenyador)
destroy(this.cb_grabar)
destroy(this.dw_resumen)
destroy(this.dw_resumen_serie)
destroy(this.dw_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Trabajos por Diseñador"
istr_parametros.s_listado        =   "dw_con_trabajos_disenyador"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(FocusRect!)

dw_resumen.SetTransObject(SQLCA)
dw_resumen_serie.SetTransObject(SQLCA)



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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_trabajos_disenyador
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_trabajos_disenyador
integer x = 3040
integer width = 178
integer height = 92
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_trabajos_disenyador
integer x = 37
integer y = 4
integer width = 4407
integer height = 72
integer textsize = -8
fontcharset fontcharset = ansi!
end type

type gb_7 from groupbox within w_con_trabajos_disenyador
integer x = 69
integer y = 76
integer width = 1289
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Diseñador"
end type

type gb_8 from groupbox within w_con_trabajos_disenyador
boolean visible = false
integer x = 1554
integer y = 92
integer width = 686
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_imprimir from upb_imprimir within w_con_trabajos_disenyador
event clicked pbm_bnclicked
integer x = 4101
integer y = 124
integer taborder = 0
end type

event clicked;w_con_trabajos_disenyador.triggerEvent("ue_listar")

end event

type cb_1 from u_boton within w_con_trabajos_disenyador
integer x = 3735
integer y = 120
integer width = 315
integer height = 104
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)


end event

type cbx_1 from checkbox within w_con_trabajos_disenyador
boolean visible = false
integer x = 1929
integer y = 152
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
long backcolor = 67108864
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

type cbx_2 from checkbox within w_con_trabajos_disenyador
boolean visible = false
integer x = 1582
integer y = 152
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
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

type pb_1 from upb_salir within w_con_trabajos_disenyador
integer x = 4279
integer y = 108
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type uo_disenyador from u_em_campo_2 within w_con_trabajos_disenyador
event destroy ( )
integer x = 96
integer y = 136
integer width = 1239
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_disenyador.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_disenyador

select descripcion
into :des_disenyador
from tecnico_dis
where empresa = :codigo_empresa
and codigo = :uo_disenyador.em_codigo.text;

uo_disenyador.em_campo.text = des_disenyador
IF Trim(uo_disenyador.em_campo.text)="" THEN 
 IF Trim(uo_disenyador.em_codigo.text)<>"" Then uo_disenyador.em_campo.SetFocus()
 uo_disenyador.em_campo.text=""
 uo_disenyador.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Diseñador"
ue_datawindow = "dw_ayuda_tecnicos_dis"
ue_filtro     = ""

end event

type cb_grabar from u_boton within w_con_trabajos_disenyador
boolean visible = false
integer x = 3310
integer y = 124
integer width = 315
integer height = 104
integer taborder = 30
boolean bringtotop = true
string text = "Grabar"
end type

event clicked;

if messagebox("Pregunta", "¿Desea guardar los cambios?", Exclamation!, OKCancel!, 2) = 1 then
	dw_1.update()
end if

// MessageBox("Result", Abs(Distance), Exclamation!, OKCancel!, 2)

end event

type dw_resumen from u_datawindow within w_con_trabajos_disenyador
boolean visible = false
integer x = 553
integer y = 1996
integer width = 1710
integer height = 480
integer taborder = 30
string dataobject = "dw_con_trabajos_disenyador_resumen"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param

If row=0 Then Return



//IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
//END IF


end event

event itemchanged;string disenyador, solicitud, coleccion, pieza
long trabajo
datetime fecha

dw_1.update()
IF dwo.Name = "descoleccionsol_disenyador" THEN
	select descripcion
	into :disenyador
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_1.object.tecnico_dis_descripcion[row] = disenyador
END IF

IF dwo.Name = "destrabajo_fecha_necesidad" THEN
	solicitud = dw_1.object.destrabajo_solicitud[row]
	coleccion = dw_1.object.destrabajo_coleccion[row]
	pieza = dw_1.object.destrabajo_pieza[row]
	trabajo = dw_1.object.destrabajo_trabajo[row]
	fecha = dw_1.object.destrabajo_fecha_necesidad[row]
//	messagebox("", "SOLICITUD: "+SOLICITUD+"   COLECCION: "+COLECCION+&
//						"      PIEZA:"+PIEZA+ "      TRABAJO: "+STRING(TRABAJO)+"       FECHA: "+STRING(fecha))
	update destrabajo
	set fecha_necesidad = :fecha
	where empresa = :codigo_empresa
	and solicitud = :solicitud
	and coleccion = :coleccion
	and pieza = :pieza
	and trabajo = :trabajo;
	commit;
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_resumen_serie from u_datawindow within w_con_trabajos_disenyador
boolean visible = false
integer x = 2459
integer y = 1976
integer width = 1737
integer height = 480
integer taborder = 40
string dataobject = "dw_con_trabajos_disenyador_serie"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param

If row=0 Then Return



//IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
//END IF


end event

event itemchanged;string disenyador, solicitud, coleccion, pieza
long trabajo
datetime fecha

dw_1.update()
IF dwo.Name = "descoleccionsol_disenyador" THEN
	select descripcion
	into :disenyador
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_1.object.tecnico_dis_descripcion[row] = disenyador
END IF

IF dwo.Name = "destrabajo_fecha_necesidad" THEN
	solicitud = dw_1.object.destrabajo_solicitud[row]
	coleccion = dw_1.object.destrabajo_coleccion[row]
	pieza = dw_1.object.destrabajo_pieza[row]
	trabajo = dw_1.object.destrabajo_trabajo[row]
	fecha = dw_1.object.destrabajo_fecha_necesidad[row]
//	messagebox("", "SOLICITUD: "+SOLICITUD+"   COLECCION: "+COLECCION+&
//						"      PIEZA:"+PIEZA+ "      TRABAJO: "+STRING(TRABAJO)+"       FECHA: "+STRING(fecha))
	update destrabajo
	set fecha_necesidad = :fecha
	where empresa = :codigo_empresa
	and solicitud = :solicitud
	and coleccion = :coleccion
	and pieza = :pieza
	and trabajo = :trabajo;
	commit;
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_1 from u_datawindow within w_con_trabajos_disenyador
integer x = 37
integer y = 252
integer width = 4389
integer height = 2304
integer taborder = 20
string dataobject = "dw_con_trabajos_disenyador"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param

If row=0 Then Return



//IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
//END IF


end event

event itemchanged;string disenyador, solicitud, coleccion, pieza
long trabajo
datetime fecha

dw_1.update()
IF dwo.Name = "descoleccionsol_disenyador" THEN
	select descripcion
	into :disenyador
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_1.object.tecnico_dis_descripcion[row] = disenyador
END IF

IF dwo.Name = "destrabajo_fecha_necesidad" THEN
	solicitud = dw_1.object.destrabajo_solicitud[row]
	coleccion = dw_1.object.destrabajo_coleccion[row]
	pieza = dw_1.object.destrabajo_pieza[row]
	trabajo = dw_1.object.destrabajo_trabajo[row]
	fecha = dw_1.object.destrabajo_fecha_necesidad[row]
//	messagebox("", "SOLICITUD: "+SOLICITUD+"   COLECCION: "+COLECCION+&
//						"      PIEZA:"+PIEZA+ "      TRABAJO: "+STRING(TRABAJO)+"       FECHA: "+STRING(fecha))
	update destrabajo
	set fecha_necesidad = :fecha
	where empresa = :codigo_empresa
	and solicitud = :solicitud
	and coleccion = :coleccion
	and pieza = :pieza
	and trabajo = :trabajo;
	commit;
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "descoleccionsol_disenyador"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

