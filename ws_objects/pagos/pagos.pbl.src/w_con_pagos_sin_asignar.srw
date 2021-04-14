$PBExportHeader$w_con_pagos_sin_asignar.srw
forward
global type w_con_pagos_sin_asignar from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_sin_asignar
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_sin_asignar
end type
type cb_consulta from u_boton within w_con_pagos_sin_asignar
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_sin_asignar
end type
type dw_listado from datawindow within w_con_pagos_sin_asignar
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_sin_asignar
end type
type gb_2 from groupbox within w_con_pagos_sin_asignar
end type
type uo_proveedor from u_em_campo_2 within w_con_pagos_sin_asignar
end type
type cb_2 from u_boton within w_con_pagos_sin_asignar
end type
type gb_cuenta from groupbox within w_con_pagos_sin_asignar
end type
type st_1 from statictext within w_con_pagos_sin_asignar
end type
type pendiente from radiobutton within w_con_pagos_sin_asignar
end type
type cobrado from radiobutton within w_con_pagos_sin_asignar
end type
type dw_1 from datawindow within w_con_pagos_sin_asignar
end type
end forward

global type w_con_pagos_sin_asignar from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2926
integer height = 2172
pb_2 pb_2
uo_1 uo_1
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
gb_2 gb_2
uo_proveedor uo_proveedor
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
pendiente pendiente
cobrado cobrado
dw_1 dw_1
end type
global w_con_pagos_sin_asignar w_con_pagos_sin_asignar

type variables
String situacion
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,x2
String filtro,filtro1

filtro = ""
numero = uo_tipo2.dw_marca.RowCount()
IF  numero =0 Then return ""
FOR x2 = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	IF Trim(filtro) = "" Then
         	filtro1 = " tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " Or tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
String pro1,pro2

dw_data.reset()
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()
dw_data.SetFilter(f_filtro())
dw_data.Filter()


if trim(uo_proveedor.em_codigo.text)<>"" then
	pro1=uo_proveedor.em_codigo.text
	pro2=uo_proveedor.em_codigo.text
  else
	pro1="."
	pro2="Z"
End if

dw_data.Retrieve(codigo_empresa,pro1,pro2,situacion)


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA PAGOS POR PROVEEDOR"

dw_1.Setfocus()
Integer x2,registros2 
String var_codigo2,var_texto2,marca2
DataStore dw_comodin
dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'")
registros2=dw_comodin.RowCOunt()
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_comodin.GetItemString(x2,"tipodoc")
  var_texto2   = dw_comodin.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

situacion = "0"
f_activar_campo(uo_proveedor.em_campo)


end event

on w_con_pagos_sin_asignar.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.gb_2=create gb_2
this.uo_proveedor=create uo_proveedor
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.pendiente=create pendiente
this.cobrado=create cobrado
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_tipo2
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.uo_proveedor
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_cuenta
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.pendiente
this.Control[iCurrent+13]=this.cobrado
this.Control[iCurrent+14]=this.dw_1
end on

on w_con_pagos_sin_asignar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.gb_2)
destroy(this.uo_proveedor)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.pendiente)
destroy(this.cobrado)
destroy(this.dw_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_sin_asignar
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_sin_asignar
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_sin_asignar
integer x = 59
integer y = 12
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_sin_asignar
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_sin_asignar
integer x = 2240
integer y = 152
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_consulta from u_boton within w_con_pagos_sin_asignar
integer x = 1879
integer y = 216
integer width = 274
integer height = 72
integer taborder = 20
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_proveedor.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_sin_asignar
integer x = 2715
integer y = 196
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

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_proveedor.em_campo)
end event

type dw_listado from datawindow within w_con_pagos_sin_asignar
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_proveedor_sin_asignar"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_pagos_sin_asignar
boolean visible = false
integer x = 1125
integer y = 332
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type gb_2 from groupbox within w_con_pagos_sin_asignar
integer x = 1568
integer y = 180
integer width = 603
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_proveedor from u_em_campo_2 within w_con_pagos_sin_asignar
event destroy ( )
integer x = 23
integer y = 200
integer width = 1477
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 


end event

type cb_2 from u_boton within w_con_pagos_sin_asignar
event clicked pbm_bnclicked
integer x = 1582
integer y = 216
integer width = 293
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

end event

type gb_cuenta from groupbox within w_con_pagos_sin_asignar
integer x = 5
integer y = 112
integer width = 1527
integer height = 188
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_con_pagos_sin_asignar
integer x = 27
integer y = 144
integer width = 1486
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "P r o v e e d o r"
alignment alignment = center!
boolean focusrectangle = false
end type

type pendiente from radiobutton within w_con_pagos_sin_asignar
integer x = 1568
integer y = 124
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pdtes."
boolean checked = true
end type

event clicked;situacion = "0"
end event

type cobrado from radiobutton within w_con_pagos_sin_asignar
integer x = 1856
integer y = 124
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cobrado."
end type

event clicked;situacion = "1"
end event

type dw_1 from datawindow within w_con_pagos_sin_asignar
integer x = 338
integer y = 316
integer width = 2286
integer height = 1612
boolean bringtotop = true
string dataobject = "dw_con_pagos_proveedor_sin_asignar"
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

event rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

