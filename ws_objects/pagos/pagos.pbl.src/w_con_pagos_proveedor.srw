$PBExportHeader$w_con_pagos_proveedor.srw
forward
global type w_con_pagos_proveedor from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_proveedor
end type
type cb_consulta from u_boton within w_con_pagos_proveedor
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_proveedor
end type
type dw_listado from datawindow within w_con_pagos_proveedor
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_proveedor
end type
type gb_2 from groupbox within w_con_pagos_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_con_pagos_proveedor
end type
type cb_2 from u_boton within w_con_pagos_proveedor
end type
type gb_cuenta from groupbox within w_con_pagos_proveedor
end type
type st_1 from statictext within w_con_pagos_proveedor
end type
type dw_1 from datawindow within w_con_pagos_proveedor
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_proveedor
end type
type em_desde from u_em_campo within w_con_pagos_proveedor
end type
type em_hasta from u_em_campo within w_con_pagos_proveedor
end type
type st_2 from statictext within w_con_pagos_proveedor
end type
type st_3 from statictext within w_con_pagos_proveedor
end type
end forward

global type w_con_pagos_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3685
integer height = 2168
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
gb_2 gb_2
uo_proveedor uo_proveedor
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
dw_1 dw_1
ddlb_1 ddlb_1
em_desde em_desde
em_hasta em_hasta
st_2 st_2
st_3 st_3
end type
global w_con_pagos_proveedor w_con_pagos_proveedor

type variables
String situaciond,situacionh
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

dw_data.Retrieve(codigo_empresa,pro1,pro2,datetime(date(em_desde.text)),datetime(date(em_hasta.text)),situaciond,situacionh)


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA PAGOS POR PROVEEDOR"
//em_desde.text = String(mdy(1,1,year(today()))) //PILI - Enero 2013
em_desde.text = '01-01-01'
em_hasta.text = String(mdy(12,31,year(today())))


//dw_1.Setfocus()
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

situaciond = "0"
situacionh = '0'
ddlb_1.text = "Pendientes"

IF istr_parametros.i_nargumentos>1 THEN
	uo_proveedor.em_codigo.text=istr_parametros.s_argumentos[2]
	
	uo_proveedor.triggerevent("modificado")
	ddlb_1.text = "Pendientes/Emitidos"
	cb_consulta.TriggerEvent(clicked!)
	 
END IF

f_activar_campo(uo_proveedor.em_campo)


end event

on w_con_pagos_proveedor.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.gb_2=create gb_2
this.uo_proveedor=create uo_proveedor
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_tipo2
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.uo_proveedor
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.gb_cuenta
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.ddlb_1
this.Control[iCurrent+13]=this.em_desde
this.Control[iCurrent+14]=this.em_hasta
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
end on

on w_con_pagos_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.gb_2)
destroy(this.uo_proveedor)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_2)
destroy(this.st_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_proveedor
integer width = 2642
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type pb_2 from upb_salir within w_con_pagos_proveedor
integer x = 3506
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_pagos_proveedor
integer x = 3026
integer y = 216
integer width = 293
integer height = 72
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;call super::clicked;
CHOOSE CASE ddlb_1.text
	CASE "Pendientes"
		situaciond = '0'
		situacionh = '0'
	CASE "Emitidos"
		situaciond = '1'
		situacionh = '1'
	CASE "Pagados"
		situaciond = '2'
		situacionh = '2'
	CASE "Pendientes/Emitidos"
		situaciond = '0'
		situacionh = '1'
	CASE "Todos"
		situaciond = '0'
		situacionh = '2'
END CHOOSE

f_cargar(dw_1)
f_activar_campo(uo_proveedor.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_proveedor
integer x = 3506
integer y = 176
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

type dw_listado from datawindow within w_con_pagos_proveedor
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_proveedor"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_pagos_proveedor
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

type gb_2 from groupbox within w_con_pagos_proveedor
integer x = 3008
integer y = 92
integer width = 325
integer height = 220
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_proveedor from u_em_campo_2 within w_con_pagos_proveedor
event destroy ( )
integer x = 27
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

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

type cb_2 from u_boton within w_con_pagos_proveedor
event clicked pbm_bnclicked
integer x = 3026
integer y = 132
integer width = 293
integer height = 72
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

end event

type gb_cuenta from groupbox within w_con_pagos_proveedor
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

type st_1 from statictext within w_con_pagos_proveedor
integer x = 32
integer y = 148
integer width = 1486
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "P r o v e e d o r"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_pagos_proveedor
integer y = 316
integer width = 3616
integer height = 1612
boolean bringtotop = true
string dataobject = "dw_con_pagos_proveedor"
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

type ddlb_1 from dropdownlistbox within w_con_pagos_proveedor
integer x = 2377
integer y = 200
integer width = 544
integer height = 416
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
borderstyle borderstyle = stylelowered!
end type

type em_desde from u_em_campo within w_con_pagos_proveedor
integer x = 1573
integer y = 200
integer width = 325
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

type em_hasta from u_em_campo within w_con_pagos_proveedor
integer x = 1915
integer y = 200
integer width = 325
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

type st_2 from statictext within w_con_pagos_proveedor
integer x = 1527
integer y = 132
integer width = 347
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Vto"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_pagos_proveedor
integer x = 1888
integer y = 132
integer width = 347
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
string text = "."
alignment alignment = right!
boolean focusrectangle = false
end type

