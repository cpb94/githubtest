$PBExportHeader$w_buscar_asiento.srw
$PBExportComments$€
forward
global type w_buscar_asiento from w_int_con_empresa
end type
type pb_2 from upb_salir within w_buscar_asiento
end type
type em_fechadesde from u_em_campo within w_buscar_asiento
end type
type gb_5 from groupbox within w_buscar_asiento
end type
type gb_4 from groupbox within w_buscar_asiento
end type
type gb_1 from groupbox within w_buscar_asiento
end type
type cb_consulta from u_boton within w_buscar_asiento
end type
type em_fechahasta from u_em_campo within w_buscar_asiento
end type
type dw_1 from datawindow within w_buscar_asiento
end type
type uo_origen from u_em_campo_2 within w_buscar_asiento
end type
type gb_3 from groupbox within w_buscar_asiento
end type
type ddlb_1 from dropdownlistbox within w_buscar_asiento
end type
type st_1 from statictext within w_buscar_asiento
end type
type st_2 from statictext within w_buscar_asiento
end type
type st_3 from statictext within w_buscar_asiento
end type
type st_4 from statictext within w_buscar_asiento
end type
type gb_2 from groupbox within w_buscar_asiento
end type
type em_cantidad_desde from editmask within w_buscar_asiento
end type
type em_cantidad_hasta from editmask within w_buscar_asiento
end type
type uo_1 from u_manejo_datawindow within w_buscar_asiento
end type
type uo_ejercicio from u_ejercicio within w_buscar_asiento
end type
type pb_imprimir_preli from picturebutton within w_buscar_asiento
end type
type dw_listado from datawindow within w_buscar_asiento
end type
end forward

global type w_buscar_asiento from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2912
integer height = 2204
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
dw_1 dw_1
uo_origen uo_origen
gb_3 gb_3
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
gb_2 gb_2
em_cantidad_desde em_cantidad_desde
em_cantidad_hasta em_cantidad_hasta
uo_1 uo_1
uo_ejercicio uo_ejercicio
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
end type
global w_buscar_asiento w_buscar_asiento

type variables
String ante_articulo,retrasos

int inst_orden
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);long orig1,orig2
dec cant1,cant2,cant3,cant4
datetime d1,d2

d1 = datetime(date(em_fechadesde.text))
d2 = datetime(date(em_fechahasta.text))

if uo_origen.em_campo.text = "" then
	orig1 = 0
	orig2 = 9999
else
	orig1 = long(uo_origen.em_codigo.text)
	orig2 = long(uo_origen.em_codigo.text)	
end if

if ddlb_1.text = "Debe" then
	cant1 = dec(em_cantidad_desde.text)
	cant2 = dec(em_cantidad_hasta.text)
	// Si sólo DEBE ponemos un intervalo imposible (desde 1 hasta -1)
	cant3 = 1
	cant4 = -1
end if

if ddlb_1.text = "Haber" then
	cant1 = 1
	cant2 = -1
	cant3 = dec(em_cantidad_desde.text)
	cant4 = dec(em_cantidad_hasta.text)
	
end if

if ddlb_1.text = "Ambos" then
	cant1 = dec(em_cantidad_desde.text)
	cant2 = dec(em_cantidad_hasta.text)
	cant3 = dec(em_cantidad_desde.text)
	cant4 = dec(em_cantidad_hasta.text)
	
end if


data.retrieve(codigo_empresa,dec(uo_ejercicio.em_ejercicio.text),d1,d2,orig1,orig2,cant1,cant2,cant3,cant4)



end subroutine

event open;call super::open;This.title = " EXTRACTO DE UNA CUENTA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

ddlb_1.text = "Debe"
em_cantidad_desde.text = "1"
em_cantidad_hasta.text = "1"


dw_1.settransobject(sqlca)
dw_listado.settransobject(sqlca)
end event

on w_buscar_asiento.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.dw_1=create dw_1
this.uo_origen=create uo_origen
this.gb_3=create gb_3
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.gb_2=create gb_2
this.em_cantidad_desde=create em_cantidad_desde
this.em_cantidad_hasta=create em_cantidad_hasta
this.uo_1=create uo_1
this.uo_ejercicio=create uo_ejercicio
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_consulta
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.uo_origen
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.em_cantidad_desde
this.Control[iCurrent+18]=this.em_cantidad_hasta
this.Control[iCurrent+19]=this.uo_1
this.Control[iCurrent+20]=this.uo_ejercicio
this.Control[iCurrent+21]=this.pb_imprimir_preli
this.Control[iCurrent+22]=this.dw_listado
end on

on w_buscar_asiento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.dw_1)
destroy(this.uo_origen)
destroy(this.gb_3)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_2)
destroy(this.em_cantidad_desde)
destroy(this.em_cantidad_hasta)
destroy(this.uo_1)
destroy(this.uo_ejercicio)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_buscar_asiento
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_buscar_asiento
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_buscar_asiento
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_buscar_asiento
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_buscar_asiento
integer x = 306
integer y = 188
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_5 from groupbox within w_buscar_asiento
integer x = 1829
integer y = 300
integer width = 343
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_buscar_asiento
integer x = 1435
integer y = 300
integer width = 393
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_buscar_asiento
integer x = 59
integer y = 120
integer width = 1070
integer height = 180
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha "
end type

type cb_consulta from u_boton within w_buscar_asiento
integer x = 1851
integer y = 356
integer width = 311
integer height = 92
integer taborder = 70
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)


end event

type em_fechahasta from u_em_campo within w_buscar_asiento
integer x = 814
integer y = 184
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_1 from datawindow within w_buscar_asiento
integer x = 55
integer y = 476
integer width = 2779
integer height = 1476
boolean bringtotop = true
string dataobject = "dw_buscar_apunte"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;if row <= 0 then return
	

str_parametros zstr_param
zstr_param.i_nargumentos=5
zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"ejercicio"))
zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"origen")
zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))

OpenWithParm(w_int_contaapun,zstr_param) 

end event

type uo_origen from u_em_campo_2 within w_buscar_asiento
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1152
integer y = 188
integer width = 937
integer height = 80
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_origen.destroy
call u_em_campo_2::destroy
end on

type gb_3 from groupbox within w_buscar_asiento
integer x = 1134
integer y = 120
integer width = 983
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Origen"
end type

type ddlb_1 from dropdownlistbox within w_buscar_asiento
integer x = 1449
integer y = 360
integer width = 366
integer height = 300
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Debe","Haber","Ambos"}
end type

type st_1 from statictext within w_buscar_asiento
integer x = 73
integer y = 192
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_buscar_asiento
integer x = 603
integer y = 188
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_buscar_asiento
integer x = 73
integer y = 364
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_buscar_asiento
integer x = 754
integer y = 368
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_buscar_asiento
integer x = 59
integer y = 300
integer width = 1371
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cantidad"
end type

type em_cantidad_desde from editmask within w_buscar_asiento
integer x = 283
integer y = 360
integer width = 466
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,##0.00"
end type

type em_cantidad_hasta from editmask within w_buscar_asiento
integer x = 942
integer y = 360
integer width = 466
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,##0.00"
end type

type uo_1 from u_manejo_datawindow within w_buscar_asiento
integer x = 2181
integer y = 308
integer width = 608
integer height = 160
boolean bringtotop = true
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_ejercicio from u_ejercicio within w_buscar_asiento
integer x = 2144
integer y = 188
integer width = 635
integer height = 260
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type pb_imprimir_preli from picturebutton within w_buscar_asiento
integer x = 2661
integer y = 356
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;F_CARGAR(DW_LISTADO)
if dw_listado.rowcount() > 0 then
	f_imprimir_datawindow(dw_listado)
end if
end event

type dw_listado from datawindow within w_buscar_asiento
boolean visible = false
integer x = 23
integer y = 92
integer width = 320
integer height = 360
boolean bringtotop = true
string dataobject = "report_buscar_apunte"
boolean livescroll = true
end type

