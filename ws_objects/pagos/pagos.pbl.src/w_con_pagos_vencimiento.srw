$PBExportHeader$w_con_pagos_vencimiento.srw
forward
global type w_con_pagos_vencimiento from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_vencimiento
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_vencimiento
end type
type cb_consulta from u_boton within w_con_pagos_vencimiento
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento
end type
type dw_listado from datawindow within w_con_pagos_vencimiento
end type
type cb_2 from u_boton within w_con_pagos_vencimiento
end type
type gb_cuenta from groupbox within w_con_pagos_vencimiento
end type
type st_1 from statictext within w_con_pagos_vencimiento
end type
type dw_1 from datawindow within w_con_pagos_vencimiento
end type
type em_hasta from u_em_campo within w_con_pagos_vencimiento
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento
end type
type em_desde from u_em_campo within w_con_pagos_vencimiento
end type
type st_2 from statictext within w_con_pagos_vencimiento
end type
end forward

global type w_con_pagos_vencimiento from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3680
integer height = 2152
pb_2 pb_2
uo_1 uo_1
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
dw_1 dw_1
em_hasta em_hasta
ddlb_1 ddlb_1
uo_tipo2 uo_tipo2
em_desde em_desde
st_2 st_2
end type
global w_con_pagos_vencimiento w_con_pagos_vencimiento

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

fhasta = Datetime(Date(em_hasta.text))
fdesde = Datetime(Date(em_desde.text))
dw_data.Setredraw(False)
dw_data.Retrieve(codigo_empresa,fdesde,fhasta,situaciond,situacionh)
dw_data.Setredraw(True)
registros = dw_data.RowCount()

end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS POR VENCIMIENTOS"

dw_1.Setfocus()
em_hasta.text = String(Today(),"dd-mm-yy")
//fechainicio=01,year(today)
em_desde.text = String(Today(),"dd-mm-yy")
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

on w_con_pagos_vencimiento.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_1=create dw_1
this.em_hasta=create em_hasta
this.ddlb_1=create ddlb_1
this.uo_tipo2=create uo_tipo2
this.em_desde=create em_desde
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.em_hasta
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.uo_tipo2
this.Control[iCurrent+13]=this.em_desde
this.Control[iCurrent+14]=this.st_2
end on

on w_con_pagos_vencimiento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.em_hasta)
destroy(this.ddlb_1)
destroy(this.uo_tipo2)
destroy(this.em_desde)
destroy(this.st_2)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_vencimiento
integer x = 594
integer y = 792
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_vencimiento
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_vencimiento
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_vencimiento
integer x = 3506
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_vencimiento
integer x = 3013
integer y = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_consulta from u_boton within w_con_pagos_vencimiento
integer x = 1883
integer y = 204
integer width = 293
integer height = 72
integer taborder = 50
string text = "&Consulta"
end type

event clicked;Dec        j,asto
DateTime   ffra
String     fra,cta

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
//
//For j = 1 To dw_1.RowCount()
//	ffra  =  dw_1.Object.ffra[j]
//	fra   =  dw_1.Object.fra[j]
//	cta   =  dw_1.Object.cuenta[j]
//	asto  =  f_contaapun_asiento(codigo_empresa,ffra,cta,fra)
//	dw_1.Object.asto[j] = asto
//	f_mensaje_proceso("Asignando Asiento:",j,dw_1.RowCOunt())
//Next
f_activar_campo(em_desde)

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento
integer x = 3488
integer y = 192
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
f_activar_campo(em_desde)
end event

type dw_listado from datawindow within w_con_pagos_vencimiento
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_vencimiento"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_pagos_vencimiento
event clicked pbm_bnclicked
integer x = 1586
integer y = 204
integer width = 293
integer height = 72
integer taborder = 40
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

end event

type gb_cuenta from groupbox within w_con_pagos_vencimiento
integer x = 91
integer y = 156
integer width = 2139
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_con_pagos_vencimiento
integer x = 443
integer y = 120
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
string text = "Vto. Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_pagos_vencimiento
integer x = 5
integer y = 308
integer width = 3616
integer height = 1624
string dataobject = "dw_con_pagos_vencimiento"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;

str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param) 
End If
end event

event rbuttondown;Dec  asiento,ejer
Datetime fapunte,ffra
STring cta,fra
IF row = 0 or IsNUll(row) Then return


   ffra  =  dw_1.Object.ffra[row]
	fra   =  dw_1.Object.fra[row]
	cta   =  dw_1.Object.cuenta[row]
  
SELECT ejercicio,asiento,fapunte INTO :ejer,:asiento,:fapunte FROM contaapun
WHERE empresa     = :codigo_empresa
AND   ffactura   = :ffra
and   cuenta      =:cta
and   documento     =:fra
and   origen = '3';

IF IsNull(asiento) THEN asiento = 0
	


	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(ejer)
 	zstr_param.s_argumentos[3]="3"
 	zstr_param.s_argumentos[4]=string(date(fapunte))
	zstr_param.s_argumentos[5]=string(asiento)
  
  OpenWithParm(w_int_contaapun,zstr_param) 
end event

type em_hasta from u_em_campo within w_con_pagos_vencimiento
integer x = 471
integer y = 196
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

type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento
integer x = 914
integer y = 192
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

type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento
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

type em_desde from u_em_campo within w_con_pagos_vencimiento
integer x = 128
integer y = 196
integer width = 325
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

type st_2 from statictext within w_con_pagos_vencimiento
integer x = 82
integer y = 120
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
string text = "Vto. Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

