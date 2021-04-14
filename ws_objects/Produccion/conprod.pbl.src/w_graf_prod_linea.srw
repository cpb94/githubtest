$PBExportHeader$w_graf_prod_linea.srw
forward
global type w_graf_prod_linea from w_int_con_empresa
end type
type pb_1 from upb_salir within w_graf_prod_linea
end type
type pb_2 from upb_imprimir within w_graf_prod_linea
end type
type cb_1 from commandbutton within w_graf_prod_linea
end type
type gb_1 from groupbox within w_graf_prod_linea
end type
type gb_6 from groupbox within w_graf_prod_linea
end type
type em_fdesde from u_em_campo within w_graf_prod_linea
end type
type em_fhasta from u_em_campo within w_graf_prod_linea
end type
type dw_linea from datawindow within w_graf_prod_linea
end type
type cbx_finde from checkbox within w_graf_prod_linea
end type
type uo_linea from u_em_campo_2 within w_graf_prod_linea
end type
type uo_1 from u_em_campo_2 within w_graf_prod_linea
end type
type uo_lineas from u_em_campo_2 within w_graf_prod_linea
end type
type gb_3 from groupbox within w_graf_prod_linea
end type
type gb_2 from groupbox within w_graf_prod_linea
end type
type gb_4 from groupbox within w_graf_prod_linea
end type
end forward

global type w_graf_prod_linea from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 4622
integer height = 2760
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_linea dw_linea
cbx_finde cbx_finde
uo_linea uo_linea
uo_1 uo_1
uo_lineas uo_lineas
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
end type
global w_graf_prod_linea w_graf_prod_linea

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



data.retrieve (codigo_empresa, fecha1, fecha2, uo_lineas.em_codigo.text)
data.setredraw(false)		
if mostrar_texto then
	data.object.T1.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
end if
data.object.T_linea.text = uo_lineas.em_campo.text


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Producción Frente a Producción efectiva"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-01-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_graf_prod_linea.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_linea=create dw_linea
this.cbx_finde=create cbx_finde
this.uo_linea=create uo_linea
this.uo_1=create uo_1
this.uo_lineas=create uo_lineas
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.em_fdesde
this.Control[iCurrent+7]=this.em_fhasta
this.Control[iCurrent+8]=this.dw_linea
this.Control[iCurrent+9]=this.cbx_finde
this.Control[iCurrent+10]=this.uo_linea
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.uo_lineas
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_4
end on

on w_graf_prod_linea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_linea)
destroy(this.cbx_finde)
destroy(this.uo_linea)
destroy(this.uo_1)
destroy(this.uo_lineas)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event ue_f5;f_control(dw_linea,'1', false)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_graf_prod_linea
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_graf_prod_linea
end type

type st_empresa from w_int_con_empresa`st_empresa within w_graf_prod_linea
integer x = 32
integer y = 12
integer width = 4498
integer height = 80
end type

type pb_1 from upb_salir within w_graf_prod_linea
integer x = 4343
integer y = 180
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_graf_prod_linea
integer x = 4224
integer y = 180
integer taborder = 70
end type

event clicked;f_control(dw_linea,'1', false)
f_imprimir_datawindow(dw_linea)


end event

type cb_1 from commandbutton within w_graf_prod_linea
integer x = 3872
integer y = 180
integer width = 343
integer height = 96
integer taborder = 60
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
	dw_linea.DataObject = "dw_graf_prod_linea_laborales"
else
	dw_linea.DataObject = "dw_graf_prod_linea"
end if

mostrar_texto = false

f_control(dw_linea, '1', mostrar_texto)

end event

type gb_1 from groupbox within w_graf_prod_linea
integer x = 32
integer y = 132
integer width = 759
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

type gb_6 from groupbox within w_graf_prod_linea
integer x = 3854
integer y = 140
integer width = 654
integer height = 160
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_fdesde from u_em_campo within w_graf_prod_linea
integer x = 55
integer y = 192
integer width = 357
integer height = 76
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_graf_prod_linea
integer x = 421
integer y = 192
integer width = 352
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_linea from datawindow within w_graf_prod_linea
integer x = 9
integer y = 312
integer width = 4521
integer height = 2212
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_graf_prod_linea"
boolean vscrollbar = true
boolean livescroll = true
end type

type cbx_finde from checkbox within w_graf_prod_linea
integer x = 1431
integer y = 192
integer width = 809
integer height = 76
integer taborder = 50
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

type uo_linea from u_em_campo_2 within w_graf_prod_linea
event destroy ( )
integer x = 814
integer y = 192
integer width = 530
integer taborder = 30
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

type uo_1 from u_em_campo_2 within w_graf_prod_linea
event destroy ( )
integer x = 814
integer y = 192
integer width = 530
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
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

type uo_lineas from u_em_campo_2 within w_graf_prod_linea
event destroy ( )
integer x = 814
integer y = 192
integer width = 530
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_lineas.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_lineas.em_campo.text = f_nombre_linea_abr(codigo_empresa,uo_lineas.em_codigo.text)
IF Trim(uo_lineas.em_campo.text)="" THEN 
 IF Trim(uo_lineas.em_codigo.text)<>"" Then uo_lineas.em_campo.SetFocus()
 uo_lineas.em_campo.text=""
 uo_lineas.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type gb_3 from groupbox within w_graf_prod_linea
integer x = 795
integer y = 132
integer width = 567
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

type gb_2 from groupbox within w_graf_prod_linea
integer x = 795
integer y = 132
integer width = 567
integer height = 160
integer taborder = 80
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

type gb_4 from groupbox within w_graf_prod_linea
integer x = 795
integer y = 132
integer width = 567
integer height = 160
integer taborder = 90
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

