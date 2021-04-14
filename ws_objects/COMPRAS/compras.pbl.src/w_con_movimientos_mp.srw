$PBExportHeader$w_con_movimientos_mp.srw
forward
global type w_con_movimientos_mp from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_movimientos_mp
end type
type uo_mp from u_em_campo_2 within w_con_movimientos_mp
end type
type cb_1 from commandbutton within w_con_movimientos_mp
end type
type pb_imprimir from upb_imprimir within w_con_movimientos_mp
end type
type dw_listado from datawindow within w_con_movimientos_mp
end type
type gb_5 from groupbox within w_con_movimientos_mp
end type
type gb_3 from groupbox within w_con_movimientos_mp
end type
type gb_2 from groupbox within w_con_movimientos_mp
end type
type gb_1 from groupbox within w_con_movimientos_mp
end type
type em_fdesde from u_em_campo within w_con_movimientos_mp
end type
type em_fhasta from u_em_campo within w_con_movimientos_mp
end type
type gb_4 from groupbox within w_con_movimientos_mp
end type
type cb_2 from commandbutton within w_con_movimientos_mp
end type
type uo_tipo from u_marca_lista within w_con_movimientos_mp
end type
type dw_1 from datawindow within w_con_movimientos_mp
end type
end forward

global type w_con_movimientos_mp from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4059
integer height = 2456
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
uo_mp uo_mp
cb_1 cb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
gb_4 gb_4
cb_2 cb_2
uo_tipo uo_tipo
dw_1 dw_1
end type
global w_con_movimientos_mp w_con_movimientos_mp

type variables
boolean detalle = false
string ante_articulo
end variables

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = " CONSULTA MOVIMIENTOS DE MATERIAS PRIMAS "
istr_parametros = Message.PowerObjectParm

uo_tipo.f_cargar_datos("dw_ayuda_comtipomov","","","Movimiento","Descripción")

f_activar_campo(uo_mp.em_campo)
end event

on w_con_movimientos_mp.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_mp=create uo_mp
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.gb_4=create gb_4
this.cb_2=create cb_2
this.uo_tipo=create uo_tipo
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_mp
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.em_fdesde
this.Control[iCurrent+11]=this.em_fhasta
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.uo_tipo
this.Control[iCurrent+15]=this.dw_1
end on

on w_con_movimientos_mp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_mp)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.gb_4)
destroy(this.cb_2)
destroy(this.uo_tipo)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_movimientos_mp
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_movimientos_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_movimientos_mp
integer y = 8
integer width = 3835
integer height = 88
end type

type pb_2 from upb_salir within w_con_movimientos_mp
integer x = 3858
integer y = 8
integer width = 114
integer height = 104
integer taborder = 0
end type

type uo_mp from u_em_campo_2 within w_con_movimientos_mp
integer x = 37
integer y = 152
integer width = 1614
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de materias primas"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""
ante_articulo = uo_mp.em_codigo.text
end event

on uo_mp.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_mprima( codigo_empresa , this.em_codigo.text )

If Trim( this.em_campo.text ) = "" Then
	If Trim( this.em_codigo.text ) <> "" then this.em_campo.SetFocus()
	this.em_campo.text  = ""
	this.em_codigo.text = ""
end if
end event

type cb_1 from commandbutton within w_con_movimientos_mp
integer x = 3461
integer y = 136
integer width = 343
integer height = 112
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string   var_mp,tipos_mov[]
datetime f_desde,f_hasta
long     indice,total,ind_array
uo_tipo.visible = false

if uo_mp.em_codigo.text = "" then
	var_mp = "%"
else
	var_mp = uo_mp.em_codigo.text
end if
f_desde = datetime(date(em_fdesde.text))
f_hasta = datetime(date(em_fhasta.text))

ind_array = 1
total     = uo_tipo.dw_marca.RowCount()
tipos_mov = {""}

FOR indice = 1 To total
   IF uo_tipo.dw_marca.GetItemString(indice,"marca") = "S" THEN
		tipos_mov[ind_array] = uo_tipo.dw_marca.GetItemString(indice,"codigo")
      ind_array ++
   END IF
NEXT

dw_1.retrieve(codigo_empresa,var_mp,f_desde,f_hasta,tipos_mov)
end event

type pb_imprimir from upb_imprimir within w_con_movimientos_mp
integer x = 3826
integer y = 136
integer width = 133
integer height = 112
integer taborder = 50
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;string   var_mp,tipos_mov[]
datetime f_desde,f_hasta
long     indice,total,ind_array
uo_tipo.visible = false

if uo_mp.em_codigo.text = "" then
	var_mp = "%"
else
	var_mp = uo_mp.em_codigo.text
end if
f_desde = datetime(date(em_fdesde.text))
f_hasta = datetime(date(em_fhasta.text))

ind_array = 1
total     = uo_tipo.dw_marca.RowCount()
tipos_mov = {""}

FOR indice = 1 To total
   IF uo_tipo.dw_marca.GetItemString(indice,"marca") = "S" THEN
		tipos_mov[ind_array] = uo_tipo.dw_marca.GetItemString(indice,"codigo")
      ind_array ++
   END IF
NEXT

dw_listado.retrieve(codigo_empresa,var_mp,f_desde,f_hasta,tipos_mov)

f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_movimientos_mp
boolean visible = false
integer x = 1874
integer y = 12
integer width = 443
integer height = 140
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_movimientos_mp"
boolean livescroll = true
end type

type gb_5 from groupbox within w_con_movimientos_mp
integer x = 2967
integer y = 100
integer width = 489
integer height = 156
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_con_movimientos_mp
integer x = 3817
integer y = 96
integer width = 151
integer height = 160
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_con_movimientos_mp
integer x = 3451
integer y = 96
integer width = 361
integer height = 160
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_movimientos_mp
integer x = 14
integer y = 100
integer width = 1664
integer height = 156
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materia Prima"
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_movimientos_mp
integer x = 1710
integer y = 152
integer width = 379
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
string displaydata = "$Œç<pïMˆïM"
end type

type em_fhasta from u_em_campo within w_con_movimientos_mp
integer x = 2130
integer y = 152
integer width = 366
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
string displaydata = "˜"
end type

type gb_4 from groupbox within w_con_movimientos_mp
integer x = 1687
integer y = 100
integer width = 832
integer height = 156
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_con_movimientos_mp
integer x = 2976
integer y = 136
integer width = 462
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipos de mov."
end type

event clicked;uo_tipo.visible = not(uo_tipo.visible)

end event

type uo_tipo from u_marca_lista within w_con_movimientos_mp
boolean visible = false
integer x = 1166
integer y = 284
integer width = 1358
integer height = 664
integer taborder = 40
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_movimientos_mp
integer x = 5
integer y = 272
integer width = 3977
integer height = 1940
string dataobject = "dw_con_movimientos_mp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if detalle then
	this.modify("datawindow.detail.height = 0")
	dw_listado.modify("datawindow.detail.height = 0")
else	
	this.modify("datawindow.detail.height = 68")
	dw_listado.modify("datawindow.detail.height = 68")
end if
detalle = not(detalle)
end event

