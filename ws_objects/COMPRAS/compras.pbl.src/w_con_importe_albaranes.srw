$PBExportHeader$w_con_importe_albaranes.srw
forward
global type w_con_importe_albaranes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_importe_albaranes
end type
type cb_consulta from u_boton within w_con_importe_albaranes
end type
type pb_imprimir_preli from picturebutton within w_con_importe_albaranes
end type
type dw_listado from datawindow within w_con_importe_albaranes
end type
type dw_1 from datawindow within w_con_importe_albaranes
end type
type gb_1 from groupbox within w_con_importe_albaranes
end type
type gb_vto from groupbox within w_con_importe_albaranes
end type
type st_4 from statictext within w_con_importe_albaranes
end type
type em_fhasta from editmask within w_con_importe_albaranes
end type
type em_fdesde from editmask within w_con_importe_albaranes
end type
type st_6 from statictext within w_con_importe_albaranes
end type
type ddlb_1 from dropdownlistbox within w_con_importe_albaranes
end type
type st_1 from statictext within w_con_importe_albaranes
end type
type cbx_resumido from checkbox within w_con_importe_albaranes
end type
end forward

global type w_con_importe_albaranes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3374
integer height = 3268
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
gb_1 gb_1
gb_vto gb_vto
st_4 st_4
em_fhasta em_fhasta
em_fdesde em_fdesde
st_6 st_6
ddlb_1 ddlb_1
st_1 st_1
cbx_resumido cbx_resumido
end type
global w_con_importe_albaranes w_con_importe_albaranes

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);String prov1,prov2,situ[]
DateTime	fec1,fec2


dw_data.SetTransObject(sqlca)
dw_data.reset()


fec1 = datetime(date(em_fdesde.text))
fec2 = datetime(date(em_fhasta.text))


str_paramemp em
em =f_paramemp(codigo_empresa) 

f_mascara_columna(dw_data,"ccant",f_mascara_decimales(2))
f_mascara_columna(dw_data,"total_cantidad",f_mascara_decimales(2))
f_mascara_columna(dw_data,"cimp",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))
f_mascara_columna(dw_data,"total_importe",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))
f_mascara_columna(dw_data,"total_general",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))

if ddlb_1.text = "Todos" then 
	situ[1] = "C"
	situ[2] = "N"
	situ[3] = "F"
end if


if ddlb_1.text = "Confirmados" then 
	situ[1] = "F"
	situ[2] = ""
	situ[3] = ""
end if

if ddlb_1.text = "Con C. Calidad" then 
	situ[1] = "C"
	situ[2] = ""
	situ[3] = ""

end if

if ddlb_1.text = "Sin C. Calidad" then 
	situ[1] = "N"
	situ[2] = ""
	situ[3] = ""

end if

if ddlb_1.text = "C. Calidad / Conf." then 
	situ[1] = "C"
	situ[2] = "F"
	situ[3] = ""

end if
dw_data.object.t_filtro.text = "Desde "+em_fdesde.text+" Hasta "+em_fhasta.text
dw_data.Retrieve(codigo_empresa,fec1,fec2,situ)
dw_data.groupcalc()

end subroutine

event open;call super::open;
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = "Albaranes Pendientes por Grupo"

em_fdesde.text = "01/"+ string(month(today())) +"/" + string(year(today()))
em_fhasta.text = string(today())


ddlb_1.text = "Todos"

f_activar_campo(em_fdesde)





end event

on w_con_importe_albaranes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_vto=create gb_vto
this.st_4=create st_4
this.em_fhasta=create em_fhasta
this.em_fdesde=create em_fdesde
this.st_6=create st_6
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cbx_resumido=create cbx_resumido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_vto
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.em_fdesde
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.ddlb_1
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.cbx_resumido
end on

on w_con_importe_albaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_vto)
destroy(this.st_4)
destroy(this.em_fhasta)
destroy(this.em_fdesde)
destroy(this.st_6)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cbx_resumido)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_importe_albaranes
integer x = 594
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_importe_albaranes
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_importe_albaranes
integer x = 64
integer y = 8
integer height = 96
end type

type pb_2 from upb_salir within w_con_importe_albaranes
integer x = 3191
integer y = 8
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_importe_albaranes
integer x = 2816
integer y = 152
integer width = 302
integer height = 148
integer taborder = 40
string text = "&Consulta"
end type

event clicked;dw_1.visible = false

if cbx_resumido.checked then
	dw_1.Object.DataWindow.detail.height = 0
else
	dw_1.Object.DataWindow.detail.height = 74
end if

f_cargar(dw_1)
if dw_1.rowcount() > 0 then
	dw_1.visible = true

else
		dw_1.visible = false	
end if
f_activar_campo(em_Fdesde)


end event

type pb_imprimir_preli from picturebutton within w_con_importe_albaranes
integer x = 3122
integer y = 148
integer width = 174
integer height = 148
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;//f_cargar(dw_listado)
//if dw_listado.rowcount() > 0 then
//	f_imprimir_datawindow(dw_listado)	
//end if


if dw_1.rowcount() > 0 then
	f_imprimir_datawindow(dw_1)	
end if
end event

type dw_listado from datawindow within w_con_importe_albaranes
boolean visible = false
integer x = 69
integer y = 120
integer width = 379
integer height = 112
string dataobject = "report_con_importe_albaranes"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_importe_albaranes
integer x = 114
integer y = 336
integer width = 3186
integer height = 2720
string dataobject = "dw_con_importe_albaranes_cuenta"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_importe_albaranes
integer x = 1166
integer y = 128
integer width = 873
integer height = 148
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_vto from groupbox within w_con_importe_albaranes
integer x = 64
integer y = 128
integer width = 1093
integer height = 148
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_4 from statictext within w_con_importe_albaranes
integer x = 78
integer y = 180
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Albarán :"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type em_fhasta from editmask within w_con_importe_albaranes
integer x = 841
integer y = 176
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;IF Date(em_Fdesde.text) > Date(em_Fhasta.text)   THEN
	MessageBox("ERROR EN FECHAS","La Fecha desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_Fhasta)
END IF
end event

type em_fdesde from editmask within w_con_importe_albaranes
integer x = 489
integer y = 176
integer width = 288
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_6 from statictext within w_con_importe_albaranes
integer x = 791
integer y = 172
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_con_importe_albaranes
integer x = 1454
integer y = 176
integer width = 558
integer height = 336
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Todos","Confirmados","Con C. Calidad","Sin C. Calidad","C. Calidad / Conf."}
end type

type st_1 from statictext within w_con_importe_albaranes
integer x = 1184
integer y = 184
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Situación:"
long bordercolor = 16711680
boolean focusrectangle = false
end type

type cbx_resumido from checkbox within w_con_importe_albaranes
integer x = 2446
integer y = 180
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumido"
boolean lefttext = true
end type

