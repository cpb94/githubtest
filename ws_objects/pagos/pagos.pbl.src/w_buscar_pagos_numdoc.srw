$PBExportHeader$w_buscar_pagos_numdoc.srw
forward
global type w_buscar_pagos_numdoc from w_int_con_empresa
end type
type pb_2 from upb_salir within w_buscar_pagos_numdoc
end type
type em_fechadesde from u_em_campo within w_buscar_pagos_numdoc
end type
type gb_5 from groupbox within w_buscar_pagos_numdoc
end type
type gb_1 from groupbox within w_buscar_pagos_numdoc
end type
type cb_consulta from u_boton within w_buscar_pagos_numdoc
end type
type em_fechahasta from u_em_campo within w_buscar_pagos_numdoc
end type
type dw_1 from datawindow within w_buscar_pagos_numdoc
end type
type uo_cuenta from u_em_campo_2 within w_buscar_pagos_numdoc
end type
type gb_3 from groupbox within w_buscar_pagos_numdoc
end type
type uo_1 from u_manejo_datawindow within w_buscar_pagos_numdoc
end type
type em_cantidad_hasta from u_em_campo within w_buscar_pagos_numdoc
end type
type gb_2 from groupbox within w_buscar_pagos_numdoc
end type
end forward

global type w_buscar_pagos_numdoc from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3406
integer height = 1984
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_5 gb_5
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
dw_1 dw_1
uo_cuenta uo_cuenta
gb_3 gb_3
uo_1 uo_1
em_cantidad_hasta em_cantidad_hasta
gb_2 gb_2
end type
global w_buscar_pagos_numdoc w_buscar_pagos_numdoc

type variables
String ante_articulo,retrasos

int inst_orden
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);string cuenta
string cant
datetime d1,d2

d1 = datetime(date(em_fechadesde.text))
d2 = datetime(date(em_fechahasta.text))

if uo_cuenta.em_campo.text = "" then
	cuenta="%"
else
	cuenta= uo_cuenta.em_codigo.text
end if

if em_cantidad_hasta.text = "" then
	cant = "%"
else
	cant = em_cantidad_hasta.text
end if

 

data.retrieve(codigo_empresa, cuenta, d1, d2, cant)



end subroutine

event open;call super::open;This.title = " BUSCAR UN PAGO POR NUM TALÓN"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(MDY(12,31,Year(Today())))




em_cantidad_hasta.text = ""
dw_1.settransobject(sqlca)

end event

on w_buscar_pagos_numdoc.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_5=create gb_5
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.dw_1=create dw_1
this.uo_cuenta=create uo_cuenta
this.gb_3=create gb_3
this.uo_1=create uo_1
this.em_cantidad_hasta=create em_cantidad_hasta
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.uo_cuenta
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.em_cantidad_hasta
this.Control[iCurrent+12]=this.gb_2
end on

on w_buscar_pagos_numdoc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.dw_1)
destroy(this.uo_cuenta)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.em_cantidad_hasta)
destroy(this.gb_2)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_buscar_pagos_numdoc
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_buscar_pagos_numdoc
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_buscar_pagos_numdoc
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_buscar_pagos_numdoc
integer x = 3218
integer y = 16
integer height = 148
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_buscar_pagos_numdoc
integer x = 27
integer y = 188
integer width = 320
integer height = 80
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_5 from groupbox within w_buscar_pagos_numdoc
integer x = 2725
integer y = 116
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

type gb_1 from groupbox within w_buscar_pagos_numdoc
integer x = 9
integer y = 124
integer width = 690
integer height = 172
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "F.Vto "
end type

type cb_consulta from u_boton within w_buscar_pagos_numdoc
integer x = 2747
integer y = 168
integer width = 297
integer height = 96
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;
f_cargar(dw_1)


end event

type em_fechahasta from u_em_campo within w_buscar_pagos_numdoc
integer x = 357
integer y = 188
integer width = 320
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_1 from datawindow within w_buscar_pagos_numdoc
integer x = 9
integer y = 304
integer width = 3333
integer height = 1460
boolean bringtotop = true
string dataobject = "dw_buscar_pagos_numtalon"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

type uo_cuenta from u_em_campo_2 within w_buscar_pagos_numdoc
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 727
integer y = 188
integer width = 1074
integer height = 80
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_cuenta.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_cuenta.em_codigo.text)

IF Trim(uo_cuenta.em_campo.text)="" THEN 
 IF Trim(uo_cuenta.em_codigo.text)<>"" Then uo_cuenta.em_campo.SetFocus()
 uo_cuenta.em_campo.text=""
 uo_cuenta.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

on uo_cuenta.destroy
call u_em_campo_2::destroy
end on

type gb_3 from groupbox within w_buscar_pagos_numdoc
integer x = 709
integer y = 124
integer width = 1120
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Proveedor"
end type

type uo_1 from u_manejo_datawindow within w_buscar_pagos_numdoc
boolean visible = false
integer x = 2153
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

type em_cantidad_hasta from u_em_campo within w_buscar_pagos_numdoc
integer x = 1856
integer y = 184
integer width = 837
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type gb_2 from groupbox within w_buscar_pagos_numdoc
integer x = 1838
integer y = 120
integer width = 878
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Número de Talón"
end type

