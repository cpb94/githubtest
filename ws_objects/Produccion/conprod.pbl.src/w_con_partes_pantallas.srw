$PBExportHeader$w_con_partes_pantallas.srw
forward
global type w_con_partes_pantallas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_partes_pantallas
end type
type pb_2 from upb_imprimir within w_con_partes_pantallas
end type
type cb_1 from commandbutton within w_con_partes_pantallas
end type
type gb_1 from groupbox within w_con_partes_pantallas
end type
type gb_6 from groupbox within w_con_partes_pantallas
end type
type dw_informe from datawindow within w_con_partes_pantallas
end type
type em_fdesde from u_em_campo within w_con_partes_pantallas
end type
type em_fhasta from u_em_campo within w_con_partes_pantallas
end type
type uo_marco from u_em_campo_2 within w_con_partes_pantallas
end type
type ddlb_lab_prod from dropdownlistbox within w_con_partes_pantallas
end type
type ddlb_tens_desten from dropdownlistbox within w_con_partes_pantallas
end type
type ddlb_hilos from dropdownlistbox within w_con_partes_pantallas
end type
type gb_4 from groupbox within w_con_partes_pantallas
end type
type gb_2 from groupbox within w_con_partes_pantallas
end type
type gb_3 from groupbox within w_con_partes_pantallas
end type
type gb_5 from groupbox within w_con_partes_pantallas
end type
end forward

global type w_con_partes_pantallas from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3579
integer height = 3636
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
uo_marco uo_marco
ddlb_lab_prod ddlb_lab_prod
ddlb_tens_desten ddlb_tens_desten
ddlb_hilos ddlb_hilos
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
gb_5 gb_5
end type
global w_con_partes_pantallas w_con_partes_pantallas

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string marco, lab_prod, tens_desten, hilos, filtro


if uo_marco.em_codigo.text = '' then
	marco = '%'
else
	marco = uo_marco.em_codigo.text
end if

if ddlb_lab_prod.text = "Todo" then
	lab_prod= '%'
else
	lab_prod = ddlb_lab_prod.text
end if

if ddlb_tens_desten.text = "Todo" then
	tens_desten = "%"
else
	tens_desten = ddlb_tens_desten.text
end if

if ddlb_hilos.text = "Todo" then
	Hilos = "1 = 1 "
else
	hilos =  " prodpartespantallas_hilos =  "+ddlb_hilos.text
end if


data.SetTransObject(SQLCA)

data.retrieve(codigo_empresa, datetime(date(em_fdesde.text)), datetime(date(em_fhasta.text)), marco, lab_prod, tens_desten)

filtro = hilos

data.SetRedraw(false)
data.setfilter(filtro)
data.filter()
data.SetRedraw(true)

data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Resumen de Producción"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-09-01"
em_fhasta.text = string(today(),"dd-mm-yy")

ddlb_tens_desten.text = "Todo"
ddlb_lab_prod.text =  "Todo"
ddlb_hilos.text =  "Todo"


end event

on w_con_partes_pantallas.create
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
this.uo_marco=create uo_marco
this.ddlb_lab_prod=create ddlb_lab_prod
this.ddlb_tens_desten=create ddlb_tens_desten
this.ddlb_hilos=create ddlb_hilos
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.uo_marco
this.Control[iCurrent+10]=this.ddlb_lab_prod
this.Control[iCurrent+11]=this.ddlb_tens_desten
this.Control[iCurrent+12]=this.ddlb_hilos
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_5
end on

on w_con_partes_pantallas.destroy
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
destroy(this.uo_marco)
destroy(this.ddlb_lab_prod)
destroy(this.ddlb_tens_desten)
destroy(this.ddlb_hilos)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_5)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_partes_pantallas
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_partes_pantallas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_partes_pantallas
integer y = 8
integer width = 3538
integer height = 76
end type

type pb_1 from upb_salir within w_con_partes_pantallas
integer x = 3419
integer y = 136
integer width = 110
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_partes_pantallas
integer x = 3282
integer y = 136
integer taborder = 0
end type

event clicked;//f_control_copia(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_partes_pantallas
integer x = 2985
integer y = 136
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

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_partes_pantallas
integer x = 27
integer y = 96
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

type gb_6 from groupbox within w_con_partes_pantallas
integer x = 2967
integer y = 96
integer width = 585
integer height = 152
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

type dw_informe from datawindow within w_con_partes_pantallas
integer x = 9
integer y = 284
integer width = 3515
integer height = 3156
boolean bringtotop = true
string dataobject = "dw_con_partes_pantallas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_partes_pantallas
integer x = 59
integer y = 148
integer width = 357
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_partes_pantallas
integer x = 439
integer y = 148
integer width = 357
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type uo_marco from u_em_campo_2 within w_con_partes_pantallas
event destroy ( )
integer x = 901
integer y = 152
integer width = 585
integer height = 92
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_marco.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from prodtipomarcopantalla
where empresa = :codigo_empresa
and codigo = :uo_marco.em_codigo.text;

uo_marco.em_campo.text = descripcion

IF Trim(uo_marco.em_campo.text)="" THEN 
 	IF Trim(uo_marco.em_codigo.text)<>"" Then 
		uo_marco.em_campo.SetFocus()
	END IF
 	uo_marco.em_campo.text=""
 	uo_marco.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda Marcos Pantalla"
ue_datawindow = "dw_ayuda_marcospantalla"
ue_filtro     = ""

end event

type ddlb_lab_prod from dropdownlistbox within w_con_partes_pantallas
integer x = 2482
integer y = 148
integer width = 411
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Producción ","Laboratorio","Todo"}
borderstyle borderstyle = styleraised!
end type

type ddlb_tens_desten from dropdownlistbox within w_con_partes_pantallas
integer x = 2025
integer y = 148
integer width = 411
integer height = 352
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Tensada","Destensada","Todo"}
borderstyle borderstyle = styleraised!
end type

type ddlb_hilos from dropdownlistbox within w_con_partes_pantallas
integer x = 1659
integer y = 148
integer width = 311
integer height = 1032
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"2","10","15","21","32","36","48","62","71","90","120","140","Todo"}
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_con_partes_pantallas
integer x = 2007
integer y = 92
integer width = 448
integer height = 164
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tensada / Des"
end type

type gb_2 from groupbox within w_con_partes_pantallas
integer x = 882
integer y = 96
integer width = 622
integer height = 164
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Marco"
end type

type gb_3 from groupbox within w_con_partes_pantallas
integer x = 2464
integer y = 92
integer width = 448
integer height = 164
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lab. / Prod."
end type

type gb_5 from groupbox within w_con_partes_pantallas
integer x = 1632
integer y = 92
integer width = 366
integer height = 168
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Hilos"
end type

