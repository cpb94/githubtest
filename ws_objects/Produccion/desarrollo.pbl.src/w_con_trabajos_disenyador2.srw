$PBExportHeader$w_con_trabajos_disenyador2.srw
forward
global type w_con_trabajos_disenyador2 from w_int_con_empresa
end type
type gb_7 from groupbox within w_con_trabajos_disenyador2
end type
type gb_8 from groupbox within w_con_trabajos_disenyador2
end type
type pb_imprimir from upb_imprimir within w_con_trabajos_disenyador2
end type
type cb_1 from u_boton within w_con_trabajos_disenyador2
end type
type cbx_1 from checkbox within w_con_trabajos_disenyador2
end type
type cbx_2 from checkbox within w_con_trabajos_disenyador2
end type
type pb_1 from upb_salir within w_con_trabajos_disenyador2
end type
type uo_disenyador from u_em_campo_2 within w_con_trabajos_disenyador2
end type
type cb_grabar from u_boton within w_con_trabajos_disenyador2
end type
type dw_resumen from u_datawindow within w_con_trabajos_disenyador2
end type
type dw_resumen_serie from u_datawindow within w_con_trabajos_disenyador2
end type
type uo_tecnico from u_em_campo_2 within w_con_trabajos_disenyador2
end type
type uo_cliente from u_em_campo_2 within w_con_trabajos_disenyador2
end type
type uo_comercial from u_em_campo_2 within w_con_trabajos_disenyador2
end type
type gb_1 from groupbox within w_con_trabajos_disenyador2
end type
type gb_2 from groupbox within w_con_trabajos_disenyador2
end type
type gb_3 from groupbox within w_con_trabajos_disenyador2
end type
type st_16 from statictext within w_con_trabajos_disenyador2
end type
type ddlb_inkcid from dropdownlistbox within w_con_trabajos_disenyador2
end type
type r_1 from rectangle within w_con_trabajos_disenyador2
end type
type dw_1 from u_datawindow within w_con_trabajos_disenyador2
end type
end forward

global type w_con_trabajos_disenyador2 from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 5079
integer height = 3680
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
uo_tecnico uo_tecnico
uo_cliente uo_cliente
uo_comercial uo_comercial
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
st_16 st_16
ddlb_inkcid ddlb_inkcid
r_1 r_1
dw_1 dw_1
end type
global w_con_trabajos_disenyador2 w_con_trabajos_disenyador2

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string disenyador, filtro, tecnico, inkcid

dw_1.setredraw(false) 

if	ddlb_inkcid.text = 'TODOS' or ddlb_inkcid.text = '' then
	inkcid = '%'
else
	inkcid = ddlb_inkcid.text
end if

dw_1.retrieve (codigo_empresa, inkcid)
dw_resumen.retrieve (codigo_empresa)
dw_resumen_serie.retrieve (codigo_empresa)


filtro = ' 1 = 1 '
if uo_cliente.em_codigo.text <> '' and not isnull(uo_cliente.em_codigo.text) then
	filtro = filtro + " and desserie_cliente = '"+uo_cliente.em_codigo.text+"' "
end if
if uo_tecnico.em_codigo.text <> '' and not isnull(uo_tecnico.em_codigo.text) then
	filtro = filtro + " and destrabajo2_tecnico_lab = '"+uo_tecnico.em_codigo.text+"' "
end if
if uo_comercial.em_codigo.text <> '' and not isnull(uo_comercial.em_codigo.text) then
	filtro = filtro + " and destrabajo2_comercial = '"+uo_comercial.em_codigo.text+"' "
end if

if uo_disenyador.em_codigo.text <> '' and not isnull(uo_disenyador.em_codigo.text) then
	filtro = filtro + " and destrabajo2_tecnico_dis = '"+uo_disenyador.em_codigo.text+"' "
end if

dw_1.SetFilter(filtro)
dw_1.Filter()

dw_1.setredraw(true) 

end subroutine

on w_con_trabajos_disenyador2.create
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
this.uo_tecnico=create uo_tecnico
this.uo_cliente=create uo_cliente
this.uo_comercial=create uo_comercial
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.st_16=create st_16
this.ddlb_inkcid=create ddlb_inkcid
this.r_1=create r_1
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
this.Control[iCurrent+12]=this.uo_tecnico
this.Control[iCurrent+13]=this.uo_cliente
this.Control[iCurrent+14]=this.uo_comercial
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.st_16
this.Control[iCurrent+19]=this.ddlb_inkcid
this.Control[iCurrent+20]=this.r_1
this.Control[iCurrent+21]=this.dw_1
end on

on w_con_trabajos_disenyador2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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
destroy(this.uo_tecnico)
destroy(this.uo_cliente)
destroy(this.uo_comercial)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.st_16)
destroy(this.ddlb_inkcid)
destroy(this.r_1)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_trabajos_disenyador2
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_trabajos_disenyador2
integer x = 3040
integer width = 178
integer height = 92
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_trabajos_disenyador2
integer x = 37
integer width = 5280
end type

type gb_7 from groupbox within w_con_trabajos_disenyador2
integer x = 1024
integer y = 76
integer width = 910
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Técnico"
end type

type gb_8 from groupbox within w_con_trabajos_disenyador2
boolean visible = false
integer x = 2688
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

type pb_imprimir from upb_imprimir within w_con_trabajos_disenyador2
event clicked pbm_bnclicked
integer x = 4635
integer y = 116
integer taborder = 0
boolean originalsize = false
end type

event clicked;PArent.triggerEvent("ue_listar")

end event

type cb_1 from u_boton within w_con_trabajos_disenyador2
integer x = 4370
integer y = 116
integer width = 256
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)


end event

type cbx_1 from checkbox within w_con_trabajos_disenyador2
boolean visible = false
integer x = 3090
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

type cbx_2 from checkbox within w_con_trabajos_disenyador2
boolean visible = false
integer x = 2743
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

type pb_1 from upb_salir within w_con_trabajos_disenyador2
integer x = 4741
integer y = 116
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type uo_disenyador from u_em_campo_2 within w_con_trabajos_disenyador2
event destroy ( )
integer x = 96
integer y = 128
integer width = 891
integer height = 88
integer taborder = 10
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

type cb_grabar from u_boton within w_con_trabajos_disenyador2
boolean visible = false
integer x = 3447
integer y = 124
integer width = 315
integer height = 96
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

type dw_resumen from u_datawindow within w_con_trabajos_disenyador2
integer x = 64
integer y = 2440
integer width = 1710
integer height = 1048
integer taborder = 80
string dataobject = "dw_con_trabajos_disenyador_resumen2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
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

type dw_resumen_serie from u_datawindow within w_con_trabajos_disenyador2
integer x = 1774
integer y = 2440
integer width = 1710
integer height = 1048
integer taborder = 90
string dataobject = "dw_con_trabajos_disenyador_serie2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
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

type uo_tecnico from u_em_campo_2 within w_con_trabajos_disenyador2
integer x = 1051
integer y = 128
integer width = 859
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_tecnico

select descripcion
into :des_tecnico
from tecnico_lab
where empresa = :codigo_empresa
and codigo = :uo_tecnico.em_codigo.text;

uo_tecnico.em_campo.text = des_tecnico
If Trim(uo_tecnico.em_campo.text)="" then
	uo_tecnico.em_campo.text=""
	uo_tecnico.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Técnicos de Laboratorio"
ue_datawindow ="dw_ayuda_tecnicos_lab"
ue_filtro = ""
end event

on uo_tecnico.destroy
call u_em_campo_2::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_trabajos_disenyador2
integer x = 2939
integer y = 128
integer width = 887
integer height = 92
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_cliente


des_cliente = f_nombre_cliente (codigo_empresa, 'C', uo_cliente.em_codigo.text)

uo_cliente.em_campo.text = des_cliente
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = "tipoter = 'C'"
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type uo_comercial from u_em_campo_2 within w_con_trabajos_disenyador2
integer x = 1970
integer y = 128
integer width = 914
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_comercial

select descripcion
into :des_comercial
from comercial
where empresa = :codigo_empresa
and codigo = :uo_comercial.em_codigo.text;

uo_comercial.em_campo.text = des_comercial
If Trim(uo_comercial.em_campo.text)="" then
	uo_comercial.em_campo.text=""
	uo_comercial.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Comerciales"
ue_datawindow ="dw_ayuda_comercial"
ue_filtro = ""
end event

on uo_comercial.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_con_trabajos_disenyador2
integer x = 69
integer y = 76
integer width = 942
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Diseñador"
end type

type gb_2 from groupbox within w_con_trabajos_disenyador2
integer x = 2912
integer y = 76
integer width = 937
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_trabajos_disenyador2
integer x = 1943
integer y = 76
integer width = 965
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Comercial"
end type

type st_16 from statictext within w_con_trabajos_disenyador2
integer x = 3872
integer y = 132
integer width = 192
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
boolean enabled = false
string text = "Inkcid:"
alignment alignment = right!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type ddlb_inkcid from dropdownlistbox within w_con_trabajos_disenyador2
integer x = 4078
integer y = 128
integer width = 265
integer height = 344
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"TODOS","S","N"}
end type

type r_1 from rectangle within w_con_trabajos_disenyador2
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 16777215
integer x = 64
integer y = 2256
integer width = 4910
integer height = 1236
end type

type dw_1 from u_datawindow within w_con_trabajos_disenyador2
integer x = 64
integer y = 248
integer width = 4910
integer height = 2152
integer taborder = 100
string dataobject = "dw_con_trabajos_disenyador3"
boolean vscrollbar = true
boolean border = false
end type

event clicked;str_parametros lstr_param

If row=0 Then Return

this.SetRow(row)



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

event doubleclicked;call super::doubleclicked;string laboratorio, grupo
Long id_ventana



str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="w_con_trabajos_disenyador2"
lstr_param.s_argumentos[2]=String(dw_1.GetItemString(row,"desmodelo_modelo"))

select v_grupo
into: grupo
from usuarios 
where v_usuario = :nombre_usuario;

//laboratorio = dw_1.object.destrabajos2_laboratorio[This.GetRow()]

if grupo = '6' then
	id_ventana = f_menu_ventana_esta_abierta("w_mant_desmodelos_laboratorio")
	if id_ventana <> -1 then
		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de laboratorio, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
			close(w_mant_desmodelos_laboratorio)
			OpenWithParm(w_mant_desmodelos_laboratorio,lstr_param)
		else
			ventanas_activas[id_ventana].ventana.bringtotop = true
		end if
	else
		OpenWithParm(w_mant_desmodelos_laboratorio,lstr_param)
	end if
else
	
	lstr_param.s_argumentos[1] = String(dw_1.GetItemString(This.GetRow(),"desmodelo_modelo"))
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "w_con_trabajos_disenyador2"
	lstr_param.resultado = ''
	lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"desmodelo_modelo"))
	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo")
	if id_ventana <> -1 then
		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de diseño, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
			close(wtc_trabajos_disenyo)
			OpenWithParm(wtc_trabajos_disenyo,lstr_param)
		else
			ventanas_activas[id_ventana].ventana.bringtotop = true
		end if
	else
		OpenWithParm(wtc_trabajos_disenyo,lstr_param)
	end if
end if
end event

