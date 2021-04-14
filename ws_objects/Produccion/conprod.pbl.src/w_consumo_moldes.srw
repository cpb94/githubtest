$PBExportHeader$w_consumo_moldes.srw
forward
global type w_consumo_moldes from w_int_con_empresa
end type
type gb_1 from groupbox within w_consumo_moldes
end type
type gb_8 from groupbox within w_consumo_moldes
end type
type pb_imprimir from upb_imprimir within w_consumo_moldes
end type
type dw_1 from datawindow within w_consumo_moldes
end type
type cb_1 from u_boton within w_consumo_moldes
end type
type cbx_1 from checkbox within w_consumo_moldes
end type
type cbx_2 from checkbox within w_consumo_moldes
end type
type pb_1 from upb_salir within w_consumo_moldes
end type
type r_1 from rectangle within w_consumo_moldes
end type
type st_total from statictext within w_consumo_moldes
end type
type uo_molde from u_em_campo_2 within w_consumo_moldes
end type
type em_fdesde from u_em_campo within w_consumo_moldes
end type
type em_fhasta from u_em_campo within w_consumo_moldes
end type
type gb_2 from groupbox within w_consumo_moldes
end type
type gb_7 from groupbox within w_consumo_moldes
end type
end forward

global type w_consumo_moldes from w_int_con_empresa
integer width = 3547
integer height = 3088
string title = "Consulta de artículos (cod. estadístico)"
gb_1 gb_1
gb_8 gb_8
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
pb_1 pb_1
r_1 r_1
st_total st_total
uo_molde uo_molde
em_fdesde em_fdesde
em_fhasta em_fhasta
gb_2 gb_2
gb_7 gb_7
end type
global w_consumo_moldes w_consumo_moldes

type variables
String orden_general
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string filtro, molde
string restriccion_global, restriccion_base, restriccion_molde
datetime desde, hasta

dw_1.reset()
if cbx_2.checked then
	dw_1.Modify("DataWindow.Trailer.4.Height=0") 
	dw_1.Modify("DataWindow.Detail.Height=0") 
end if

if uo_molde.em_codigo.text = "" or isnull(uo_molde.em_codigo.text) then
	molde = '%'
else
	molde = uo_molde.em_codigo.text
end if

filtro = ""
			
dw_1.SetFilter(filtro)
dw_1.Filter()

desde = datetime(date(em_fdesde.text))
hasta = datetime(date(em_fhasta.text))
dw_1.Retrieve(codigo_empresa,molde, desde, hasta )

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

end subroutine

on w_consumo_moldes.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_8=create gb_8
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.pb_1=create pb_1
this.r_1=create r_1
this.st_total=create st_total
this.uo_molde=create uo_molde
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.gb_2=create gb_2
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_8
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.cbx_2
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.r_1
this.Control[iCurrent+10]=this.st_total
this.Control[iCurrent+11]=this.uo_molde
this.Control[iCurrent+12]=this.em_fdesde
this.Control[iCurrent+13]=this.em_fhasta
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_7
end on

on w_consumo_moldes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_8)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.pb_1)
destroy(this.r_1)
destroy(this.st_total)
destroy(this.uo_molde)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.gb_2)
destroy(this.gb_7)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consumo de Moldes"
istr_parametros.s_listado        =   "dw_consumo_moldes"
This.title                       =   istr_parametros.s_titulo_ventana


em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy") 

em_fdesde.setfocus()

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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_consumo_moldes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_consumo_moldes
integer x = 3040
integer width = 178
integer height = 92
end type

type st_empresa from w_int_con_empresa`st_empresa within w_consumo_moldes
integer x = 37
integer y = 4
integer width = 3442
integer textsize = -8
end type

type gb_1 from groupbox within w_consumo_moldes
integer x = 50
integer y = 80
integer width = 782
integer height = 160
integer taborder = 10
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

type gb_8 from groupbox within w_consumo_moldes
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

type pb_imprimir from upb_imprimir within w_consumo_moldes
event clicked pbm_bnclicked
integer x = 3127
integer y = 120
integer taborder = 0
boolean originalsize = false
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_consumo_moldes
integer x = 32
integer y = 264
integer width = 3438
integer height = 2428
string dataobject = "dw_consumo_moldes"
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

type cb_1 from u_boton within w_consumo_moldes
integer x = 2798
integer y = 120
integer width = 315
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type cbx_1 from checkbox within w_consumo_moldes
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

type cbx_2 from checkbox within w_consumo_moldes
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

type pb_1 from upb_salir within w_consumo_moldes
integer x = 3269
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type r_1 from rectangle within w_consumo_moldes
integer linethickness = 4
long fillcolor = 12639424
integer x = 32
integer y = 2720
integer width = 3433
integer height = 76
end type

type st_total from statictext within w_consumo_moldes
integer x = 197
integer y = 2724
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

type uo_molde from u_em_campo_2 within w_consumo_moldes
event destroy ( )
integer x = 974
integer y = 140
integer width = 576
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_molde.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_molde

select descripcion
into :des_molde
from prodmoldes
where empresa = :codigo_empresa
and codigo = :uo_molde.em_codigo.text;

uo_molde.em_campo.text = des_molde
IF Trim(uo_molde.em_campo.text)="" THEN 
 IF Trim(uo_molde.em_codigo.text)<>"" Then uo_molde.em_campo.SetFocus()
 uo_molde.em_campo.text=""
 uo_molde.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de moldes"
ue_datawindow = "dw_ayuda_prodmoldes"
ue_filtro     = ""

end event

type em_fdesde from u_em_campo within w_consumo_moldes
integer x = 78
integer y = 136
integer width = 352
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_consumo_moldes
integer x = 453
integer y = 136
integer width = 352
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_2 from groupbox within w_consumo_moldes
integer x = 946
integer y = 80
integer width = 626
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Molde"
end type

type gb_7 from groupbox within w_consumo_moldes
integer x = 2775
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

