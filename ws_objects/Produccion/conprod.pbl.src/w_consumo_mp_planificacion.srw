$PBExportHeader$w_consumo_mp_planificacion.srw
forward
global type w_consumo_mp_planificacion from w_int_con_empresa
end type
type gb_8 from groupbox within w_consumo_mp_planificacion
end type
type pb_imprimir from upb_imprimir within w_consumo_mp_planificacion
end type
type dw_1 from datawindow within w_consumo_mp_planificacion
end type
type cb_1 from u_boton within w_consumo_mp_planificacion
end type
type cbx_1 from checkbox within w_consumo_mp_planificacion
end type
type cbx_2 from checkbox within w_consumo_mp_planificacion
end type
type pb_1 from upb_salir within w_consumo_mp_planificacion
end type
type r_1 from rectangle within w_consumo_mp_planificacion
end type
type st_total from statictext within w_consumo_mp_planificacion
end type
type gb_7 from groupbox within w_consumo_mp_planificacion
end type
end forward

global type w_consumo_mp_planificacion from w_int_con_empresa
integer width = 3950
integer height = 3400
string title = "Consulta de artículos (cod. estadístico)"
gb_8 gb_8
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
pb_1 pb_1
r_1 r_1
st_total st_total
gb_7 gb_7
end type
global w_consumo_mp_planificacion w_consumo_mp_planificacion

type variables
String orden_general
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);
end subroutine

on w_consumo_mp_planificacion.create
int iCurrent
call super::create
this.gb_8=create gb_8
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.pb_1=create pb_1
this.r_1=create r_1
this.st_total=create st_total
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_8
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.cbx_2
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.r_1
this.Control[iCurrent+9]=this.st_total
this.Control[iCurrent+10]=this.gb_7
end on

on w_consumo_mp_planificacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_8)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.pb_1)
destroy(this.r_1)
destroy(this.st_total)
destroy(this.gb_7)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Necesidades de Materias Primas de lo Planificado"
istr_parametros.s_listado        =   "dw_consumo_mp_planificacion"
This.title                       =   istr_parametros.s_titulo_ventana


dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(FocusRect!)


orden_general = "A"



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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_consumo_mp_planificacion
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_consumo_mp_planificacion
integer x = 3040
integer width = 178
integer height = 92
end type

type st_empresa from w_int_con_empresa`st_empresa within w_consumo_mp_planificacion
integer x = 37
integer y = 4
integer width = 3863
integer textsize = -8
end type

type gb_8 from groupbox within w_consumo_mp_planificacion
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

type pb_imprimir from upb_imprimir within w_consumo_mp_planificacion
event clicked pbm_bnclicked
integer x = 3625
integer y = 120
integer taborder = 0
boolean originalsize = false
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_consumo_mp_planificacion
integer x = 32
integer y = 264
integer width = 3877
integer height = 2872
string dataobject = "dw_consumo_mp_planificacion"
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

event retrieveend;st_total.text = ""
st_total.text = "Total: "+string(dw_1.Rowcount())
end event

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
	
	
	

end event

event clicked;string orden, filtro
orden = ''
if orden_general = "A" then
	orden_general = "D"
else
	orden_general = "A"
end if
choose case dwo.name
	case "t_molde"
		orden = "prodmoldes_descripcion "+orden_general
		dw_1.SetRedraw(false)
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_piezas"
		orden = "piezas "+orden_general
		dw_1.SetRedraw(false)
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_metros"
		orden = "metros "+orden_general
		dw_1.SetRedraw(false)
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_100"
		orden = "compute_3 "+orden_general
		dw_1.SetRedraw(false)
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
end choose
end event

type cb_1 from u_boton within w_consumo_mp_planificacion
integer x = 3296
integer y = 120
integer width = 315
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;dw_1.Retrieve(codigo_empresa)
dw_1.SetSort("venmprima_tipo_materia , venmprima_familia , venmprima_codigo" )
dw_1.Sort()
dw_1.GroupCalc()
end event

type cbx_1 from checkbox within w_consumo_mp_planificacion
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

type cbx_2 from checkbox within w_consumo_mp_planificacion
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

type pb_1 from upb_salir within w_consumo_mp_planificacion
integer x = 3767
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type r_1 from rectangle within w_consumo_mp_planificacion
integer linethickness = 4
long fillcolor = 12639424
integer x = 32
integer y = 3156
integer width = 3863
integer height = 76
end type

type st_total from statictext within w_consumo_mp_planificacion
integer x = 370
integer y = 3160
integer width = 3131
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_7 from groupbox within w_consumo_mp_planificacion
integer x = 3273
integer y = 76
integer width = 626
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

