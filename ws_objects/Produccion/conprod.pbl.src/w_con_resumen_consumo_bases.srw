$PBExportHeader$w_con_resumen_consumo_bases.srw
forward
global type w_con_resumen_consumo_bases from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_consumo_bases
end type
type pb_2 from upb_imprimir within w_con_resumen_consumo_bases
end type
type cb_1 from commandbutton within w_con_resumen_consumo_bases
end type
type gb_1 from groupbox within w_con_resumen_consumo_bases
end type
type gb_6 from groupbox within w_con_resumen_consumo_bases
end type
type dw_informe from datawindow within w_con_resumen_consumo_bases
end type
type em_fdesde from u_em_campo within w_con_resumen_consumo_bases
end type
type em_fhasta from u_em_campo within w_con_resumen_consumo_bases
end type
type dw_informe2 from datawindow within w_con_resumen_consumo_bases
end type
type st_1 from statictext within w_con_resumen_consumo_bases
end type
type uo_articulo from u_em_campo_2 within w_con_resumen_consumo_bases
end type
end forward

global type w_con_resumen_consumo_bases from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3657
integer height = 3296
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_informe2 dw_informe2
st_1 st_1
uo_articulo uo_articulo
end type
global w_con_resumen_consumo_bases w_con_resumen_consumo_bases

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long i
string articulo

if uo_articulo.em_codigo.text <> '' and not isnull (uo_articulo.em_codigo.text) then
	articulo = uo_articulo.em_codigo.text
else
	articulo = '%'
end if

dw_informe.retrieve(codigo_empresa, datetime(date(em_fdesde.text)), datetime(date(em_fhasta.text)), articulo)
dw_informe2.retrieve(codigo_empresa, datetime(date(em_fdesde.text)), datetime(date(em_fhasta.text)), articulo)

for i= 1 to dw_informe.rowcount()
	dw_informe2.object.diferencia_piezas[i] = dec(dw_informe.object.piezas_fabricadas[i]) - dec(dw_informe2.object.piezas_consumidas[i])
	dw_informe2.object.diferencia_metros[i] = dec(dw_informe.object.metros2_fabricados[i]) - dec(dw_informe2.object.metros2_consumidos[i])
	dw_informe2.object.total_diferencia_metros.text = string(dec(dw_informe.object.total_metros[i]) - dec(dw_informe2.object.total_metros[i]),"###,###,###")
	dw_informe2.object.total_diferencia_piezas.text = string(dec(dw_informe.object.total_piezas[i]) - dec(dw_informe2.object.total_piezas[i]),"###,###,###")
next

end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;
istr_parametros.s_titulo_ventana="Informe Resumen Consumo de Bases"
This.title=istr_parametros.s_titulo_ventana



em_fdesde.text =  "01-01-"+string(year(today()))
em_fhasta.text = string(today(),"dd-mm-yy")

dw_informe.settransobject(SQLCA)
dw_informe2.settransobject(SQLCA)
end event

on w_con_resumen_consumo_bases.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_informe2=create dw_informe2
this.st_1=create st_1
this.uo_articulo=create uo_articulo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.dw_informe2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.uo_articulo
end on

on w_con_resumen_consumo_bases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_informe2)
destroy(this.st_1)
destroy(this.uo_articulo)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_consumo_bases
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_consumo_bases
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_consumo_bases
integer x = 18
integer y = 12
integer width = 3589
integer height = 84
end type

type pb_1 from upb_salir within w_con_resumen_consumo_bases
integer x = 3474
integer y = 144
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_consumo_bases
integer x = 3351
integer y = 144
integer height = 100
integer taborder = 0
boolean originalsize = false
long backcolor = 12632256
end type

event clicked;f_imprimir_datawindow(dw_informe)


f_imprimir_datawindow(dw_informe2)

end event

type cb_1 from commandbutton within w_con_resumen_consumo_bases
integer x = 3008
integer y = 144
integer width = 338
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_resumen_consumo_bases
integer x = 14
integer y = 100
integer width = 800
integer height = 160
integer taborder = 20
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

type gb_6 from groupbox within w_con_resumen_consumo_bases
integer x = 2990
integer y = 100
integer width = 617
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_resumen_consumo_bases
integer x = 9
integer y = 276
integer width = 1477
integer height = 2784
boolean bringtotop = true
string dataobject = "dw_con_resumen_consumo_bases"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_resumen_consumo_bases
integer x = 41
integer y = 156
integer width = 361
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_resumen_consumo_bases
integer x = 425
integer y = 156
integer width = 361
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_informe2 from datawindow within w_con_resumen_consumo_bases
integer x = 1440
integer y = 276
integer width = 2167
integer height = 2784
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_con_resumen_consumo_bases2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_con_resumen_consumo_bases
integer x = 841
integer y = 164
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_resumen_consumo_bases
integer x = 1147
integer y = 152
integer width = 1568
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

