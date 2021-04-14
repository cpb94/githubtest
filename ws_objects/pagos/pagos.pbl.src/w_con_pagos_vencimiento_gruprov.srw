$PBExportHeader$w_con_pagos_vencimiento_gruprov.srw
forward
global type w_con_pagos_vencimiento_gruprov from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_vencimiento_gruprov
end type
type cb_consulta from u_boton within w_con_pagos_vencimiento_gruprov
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento_gruprov
end type
type dw_listado from datawindow within w_con_pagos_vencimiento_gruprov
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento_gruprov
end type
type cb_2 from u_boton within w_con_pagos_vencimiento_gruprov
end type
type gb_cuenta from groupbox within w_con_pagos_vencimiento_gruprov
end type
type dw_1 from datawindow within w_con_pagos_vencimiento_gruprov
end type
type em_hasta from u_em_campo within w_con_pagos_vencimiento_gruprov
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento_gruprov
end type
type st_1 from statictext within w_con_pagos_vencimiento_gruprov
end type
type st_2 from statictext within w_con_pagos_vencimiento_gruprov
end type
type em_desde from u_em_campo within w_con_pagos_vencimiento_gruprov
end type
end forward

global type w_con_pagos_vencimiento_gruprov from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3694
integer height = 2160
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
cb_2 cb_2
gb_cuenta gb_cuenta
dw_1 dw_1
em_hasta em_hasta
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
em_desde em_desde
end type
global w_con_pagos_vencimiento_gruprov w_con_pagos_vencimiento_gruprov

type variables
String situaciond = "0"
String situacionh = "0"
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
DateTime fdesde,fhasta

dw_data.reset()
uo_tipo2.visible   = FALSE
dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()
dw_data.SetFilter(f_filtro())
dw_data.Filter()

fdesde = Datetime(Date(em_desde.text))
fhasta = Datetime(Date(em_hasta.text))

dw_data.Retrieve(codigo_empresa,fdesde,fhasta,situaciond,situacionh)
registros = dw_data.RowCount()

end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS POR VENCIMIENTOS AGRUPADOS POR TIPO PROVEEDOR"

dw_1.Setfocus()
em_hasta.text = String(Today(),"dd-mm-yy")
Integer x2,registros2
String var_codigo2,var_texto2,marca2,maxdoc = '90'
DataStore dw_comodin
dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'" + " and tipodoc < '"+maxdoc+"'")
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

f_activar_campo(em_desde)


end event

on w_con_pagos_vencimiento_gruprov.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.dw_1=create dw_1
this.em_hasta=create em_hasta
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.em_desde=create em_desde
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_tipo2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_desde
end on

on w_con_pagos_vencimiento_gruprov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.dw_1)
destroy(this.em_hasta)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_desde)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_vencimiento_gruprov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_vencimiento_gruprov
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_vencimiento_gruprov
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_vencimiento_gruprov
integer x = 3506
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_pagos_vencimiento_gruprov
integer x = 2322
integer y = 176
integer width = 293
integer height = 92
integer taborder = 50
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

DateTime	fdesde,fhasta

IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
ELSE
	IF em_hasta.text = "00-00-00" THEN
		MessageBox("ERROR","Debe introducir fecha",Exclamation!)
		f_activar_campo(em_hasta)
	ELSE
		fdesde = Datetime(Date(em_desde))
		fhasta = Datetime(Date(em_hasta))
		IF fdesde > fhasta THEN
			MessageBox("ERROR","La fecha Desde mayor que Hasta",Exclamation!)
			f_activar_campo(em_desde)
		END IF
		f_cargar(dw_1)
		f_activar_campo(em_desde)
	END IF
END IF

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento_gruprov
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
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(em_hasta)
end event

type dw_listado from datawindow within w_con_pagos_vencimiento_gruprov
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_vencimiento_gruprov"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento_gruprov
boolean visible = false
integer x = 1303
integer y = 320
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type cb_2 from u_boton within w_con_pagos_vencimiento_gruprov
event clicked pbm_bnclicked
integer x = 2030
integer y = 176
integer width = 293
integer height = 92
integer taborder = 40
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;if uo_tipo2.visible = true then
	uo_tipo2.visible = false
else
	uo_tipo2.visible = true
end if


end event

type gb_cuenta from groupbox within w_con_pagos_vencimiento_gruprov
integer x = 91
integer y = 120
integer width = 1134
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
string text = "VENCIMENTO"
end type

type dw_1 from datawindow within w_con_pagos_vencimiento_gruprov
integer x = 5
integer y = 308
integer width = 3621
integer height = 1628
string dataobject = "dw_con_pagos_vencimiento_provgrup"
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

type em_hasta from u_em_campo within w_con_pagos_vencimiento_gruprov
integer x = 891
integer y = 180
integer width = 293
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

event modified;call super::modified;DateTime	fdesde,fhasta

IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
END IF

IF em_hasta.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_hasta)
END IF

fdesde = Datetime(Date(em_desde))
fhasta = Datetime(Date(em_hasta))
IF fdesde > fhasta THEN
	MessageBox("ERROR","La fecha Desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_desde)
END IF
end event

type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento_gruprov
integer x = 1408
integer y = 172
integer width = 590
integer height = 456
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
end type

type st_1 from statictext within w_con_pagos_vencimiento_gruprov
integer x = 128
integer y = 192
integer width = 229
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

type st_2 from statictext within w_con_pagos_vencimiento_gruprov
integer x = 649
integer y = 192
integer width = 229
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
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_con_pagos_vencimiento_gruprov
event losefocus pbm_enkillfocus
integer x = 352
integer y = 180
integer width = 293
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;
IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
END IF
end event

