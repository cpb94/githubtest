$PBExportHeader$w_con_prevision_pagos.srw
forward
global type w_con_prevision_pagos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_prevision_pagos
end type
type cb_consulta from u_boton within w_con_prevision_pagos
end type
type pb_imprimir_preli from picturebutton within w_con_prevision_pagos
end type
type dw_listado from datawindow within w_con_prevision_pagos
end type
type uo_tipo2 from u_marca_lista within w_con_prevision_pagos
end type
type cb_2 from u_boton within w_con_prevision_pagos
end type
type gb_cuenta from groupbox within w_con_prevision_pagos
end type
type st_1 from statictext within w_con_prevision_pagos
end type
type dw_1 from datawindow within w_con_prevision_pagos
end type
type em_hasta from u_em_campo within w_con_prevision_pagos
end type
type rb_prov from radiobutton within w_con_prevision_pagos
end type
end forward

global type w_con_prevision_pagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 2168
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
dw_1 dw_1
em_hasta em_hasta
rb_prov rb_prov
end type
global w_con_prevision_pagos w_con_prevision_pagos

type variables
String situacion= "0"
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
         	filtro1 = " tipodoc = " + "'" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " or tipodoc = " + "'"  + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
String filtrin
Datetime fdesde,fhasta
Date fecha

dw_data.reset()
uo_tipo2.visible   = FALSE
dw_data.SetTransObject(sqlca)
//dw_data.SetFilter("")
//registros = dw_data.Filter()
//filtrin = f_filtro()
//dw_data.SetFilter(filtrin)
//registros = dw_data.Filter()
//messagebox("filtro",string(registros))

fecha  = Date(em_hasta.text)
		// CONTROL de los Bisiestos
IF Month(fecha) = 2 AND Day(fecha) = 29 THEN
	fecha = MDY(Month(fecha),28,Year(fecha))
END IF

fdesde = DateTime(Date(em_hasta.text))
fhasta = DateTime(MDY(Month(fecha),Day(fecha),Year(fecha)+1))

dw_data.Retrieve(codigo_empresa,fdesde,fhasta)


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA PREVISION DE PAGOS"

dw_1.Setfocus()
em_hasta.text = String(Today(),"dd-mm-yy")
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

f_activar_campo(em_hasta)


end event

on w_con_prevision_pagos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_1=create dw_1
this.em_hasta=create em_hasta
this.rb_prov=create rb_prov
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_tipo2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.em_hasta
this.Control[iCurrent+11]=this.rb_prov
end on

on w_con_prevision_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.em_hasta)
destroy(this.rb_prov)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prevision_pagos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prevision_pagos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prevision_pagos
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_prevision_pagos
integer x = 2766
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_prevision_pagos
integer x = 1312
integer y = 156
integer width = 439
integer height = 72
integer taborder = 30
string text = "&Consulta"
end type

event clicked;call super::clicked;IF rb_prov.checked THEN
	dw_1.DataObject = "dw_con_previs_pagos_prov"
ELSE
	dw_1.DataObject = "dw_con_previs_pagos"
END IF
f_cargar(dw_1)
f_activar_campo(em_hasta)

end event

type pb_imprimir_preli from picturebutton within w_con_prevision_pagos
integer x = 2766
integer y = 128
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

event clicked;IF rb_prov.checked THEN
	dw_listado.DataObject = "report_con_previs_pagprov_t"
ELSE
	dw_listado.DataObject = "report_con_previs_pagos_t"
END IF

f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(em_hasta)
end event

type dw_listado from datawindow within w_con_prevision_pagos
boolean visible = false
integer y = 20
integer width = 379
integer height = 112
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_prevision_pagos
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

type cb_2 from u_boton within w_con_prevision_pagos
event clicked pbm_bnclicked
integer x = 846
integer y = 156
integer width = 439
integer height = 72
integer taborder = 20
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

end event

type gb_cuenta from groupbox within w_con_prevision_pagos
integer x = 91
integer y = 112
integer width = 1701
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_con_prevision_pagos
integer x = 119
integer y = 168
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
string text = "Vto. Desde.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_prevision_pagos
integer x = 5
integer y = 272
integer width = 2871
integer height = 1660
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "None!"
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

type em_hasta from u_em_campo within w_con_prevision_pagos
integer x = 471
integer y = 152
integer width = 325
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type rb_prov from radiobutton within w_con_prevision_pagos
integer x = 1865
integer y = 140
integer width = 553
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12632256
string text = "Tipos Proveedor"
boolean checked = true
boolean automatic = false
end type

event clicked;IF rb_prov.checked THEN
	rb_prov.checked = FALSE
ELSE
	rb_prov.checked = TRUE
END IF
end event

