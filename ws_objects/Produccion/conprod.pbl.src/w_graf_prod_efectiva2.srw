$PBExportHeader$w_graf_prod_efectiva2.srw
forward
global type w_graf_prod_efectiva2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_graf_prod_efectiva2
end type
type pb_2 from upb_imprimir within w_graf_prod_efectiva2
end type
type cb_1 from commandbutton within w_graf_prod_efectiva2
end type
type gb_1 from groupbox within w_graf_prod_efectiva2
end type
type gb_6 from groupbox within w_graf_prod_efectiva2
end type
type em_fdesde from u_em_campo within w_graf_prod_efectiva2
end type
type em_fhasta from u_em_campo within w_graf_prod_efectiva2
end type
type dw_corte from datawindow within w_graf_prod_efectiva2
end type
type cbx_finde from checkbox within w_graf_prod_efectiva2
end type
type dw_mono from datawindow within w_graf_prod_efectiva2
end type
type dw_pvid from datawindow within w_graf_prod_efectiva2
end type
end forward

global type w_graf_prod_efectiva2 from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 5664
integer height = 3172
windowstate windowstate = maximized!
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_corte dw_corte
cbx_finde cbx_finde
dw_mono dw_mono
dw_pvid dw_pvid
end type
global w_graf_prod_efectiva2 w_graf_prod_efectiva2

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data, string seccion, boolean mostrar_texto)
end prototypes

public subroutine f_control (datawindow data, string seccion, boolean mostrar_texto);Datetime  fecha1,fecha2
string mes, cliente
dec{0} total_cenefas, total_bico, total_3f, total_4f, total_mold3f, total_mold4f, total_pedidos
dec{0} total_dec, total_esq, total_tacos
long fila_actual


data.SetTransObject(SQLCA)
data.Reset()
fecha1 = datetime(em_fdesde.text)
fecha2 = datetime(em_fhasta.text)



data.retrieve(codigo_empresa, fecha1, fecha2,seccion)
data.setredraw(false)		
if mostrar_texto then
	data.object.T1.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
end if


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_corte.reset()
dw_mono.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Producción Corte / Monococción "
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-01-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_graf_prod_efectiva2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_corte=create dw_corte
this.cbx_finde=create cbx_finde
this.dw_mono=create dw_mono
this.dw_pvid=create dw_pvid
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.em_fdesde
this.Control[iCurrent+7]=this.em_fhasta
this.Control[iCurrent+8]=this.dw_corte
this.Control[iCurrent+9]=this.cbx_finde
this.Control[iCurrent+10]=this.dw_mono
this.Control[iCurrent+11]=this.dw_pvid
end on

on w_graf_prod_efectiva2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_corte)
destroy(this.cbx_finde)
destroy(this.dw_mono)
destroy(this.dw_pvid)
end on

event ue_f5;f_control(dw_corte,'4', true)
f_control(dw_mono,'2', false)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_graf_prod_efectiva2
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_graf_prod_efectiva2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_graf_prod_efectiva2
integer x = 46
integer width = 5509
integer height = 80
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_graf_prod_efectiva2
integer x = 5408
integer y = 116
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_graf_prod_efectiva2
integer x = 5280
integer y = 116
integer taborder = 0
end type

event clicked;f_control(dw_corte,'4',true)
f_imprimir_datawindow(dw_corte)

f_control(dw_mono,'4', false)
f_imprimir_datawindow(dw_mono)


end event

type cb_1 from commandbutton within w_graf_prod_efectiva2
integer x = 4974
integer y = 116
integer width = 288
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;boolean mostrar_texto

mostrar_texto = True

if not cbx_finde.checked then
	dw_corte.DataObject = "dw_corte_laborales"
	dw_mono.DataObject = "dw_mono_laborales"
	dw_pvid.DataObject = "dw_pvid_laborales"
else
	dw_corte.DataObject = "dw_graf_prod_corte"
	dw_mono.DataObject = "dw_graf_prod_mono"
	dw_mono.DataObject = "dw_graf_prod_pvid"
end if

f_control(dw_corte, '4',mostrar_texto)
mostrar_texto = False
f_control(dw_mono, '2', mostrar_texto)
f_control(dw_pvid, '6', mostrar_texto)

end event

type gb_1 from groupbox within w_graf_prod_efectiva2
integer x = 82
integer y = 88
integer width = 896
integer height = 144
integer taborder = 50
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

type gb_6 from groupbox within w_graf_prod_efectiva2
integer x = 4955
integer y = 72
integer width = 590
integer height = 152
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_fdesde from u_em_campo within w_graf_prod_efectiva2
integer x = 119
integer y = 144
integer width = 402
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
boolean dropdownright = true
long calendartextcolor = 16711935
long calendartitletextcolor = 134217856
long calendartrailingtextcolor = 65535
long calendarbackcolor = 255
long calendartitlebackcolor = 32768
end type

type em_fhasta from u_em_campo within w_graf_prod_efectiva2
integer x = 553
integer y = 144
integer width = 366
integer height = 76
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_corte from datawindow within w_graf_prod_efectiva2
integer x = 18
integer y = 244
integer width = 5573
integer height = 832
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_graf_prod_corte"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_finde from checkbox within w_graf_prod_efectiva2
integer x = 1435
integer y = 144
integer width = 809
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Incluir fines de semana"
boolean lefttext = true
end type

type dw_mono from datawindow within w_graf_prod_efectiva2
integer x = 18
integer y = 1084
integer width = 5577
integer height = 852
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_graf_prod_mono"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pvid from datawindow within w_graf_prod_efectiva2
integer x = 23
integer y = 1944
integer width = 5568
integer height = 852
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_graf_prod_pvid"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

