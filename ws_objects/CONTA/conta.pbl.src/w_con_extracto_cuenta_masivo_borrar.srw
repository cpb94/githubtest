$PBExportHeader$w_con_extracto_cuenta_masivo_borrar.srw
forward
global type w_con_extracto_cuenta_masivo_borrar from w_int_con_empresa
end type
type gb_3 from groupbox within w_con_extracto_cuenta_masivo_borrar
end type
type pb_2 from upb_salir within w_con_extracto_cuenta_masivo_borrar
end type
type em_fechadesde from u_em_campo within w_con_extracto_cuenta_masivo_borrar
end type
type gb_1 from groupbox within w_con_extracto_cuenta_masivo_borrar
end type
type cb_consulta from u_boton within w_con_extracto_cuenta_masivo_borrar
end type
type em_fechahasta from u_em_campo within w_con_extracto_cuenta_masivo_borrar
end type
type st_1 from statictext within w_con_extracto_cuenta_masivo_borrar
end type
type cb_concepto from u_boton within w_con_extracto_cuenta_masivo_borrar
end type
type dw_listado from datawindow within w_con_extracto_cuenta_masivo_borrar
end type
type gb_2 from groupbox within w_con_extracto_cuenta_masivo_borrar
end type
type pb_imprimir_preli from picturebutton within w_con_extracto_cuenta_masivo_borrar
end type
type uo_1 from u_manejo_datawindow within w_con_extracto_cuenta_masivo_borrar
end type
type rb_si from radiobutton within w_con_extracto_cuenta_masivo_borrar
end type
type rb_no from radiobutton within w_con_extracto_cuenta_masivo_borrar
end type
type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta_masivo_borrar
end type
type dw_proceso2 from datawindow within w_con_extracto_cuenta_masivo_borrar
end type
type dw_1 from datawindow within w_con_extracto_cuenta_masivo_borrar
end type
type gb_cuenta from groupbox within w_con_extracto_cuenta_masivo_borrar
end type
type em_cuenta1 from u_em_campo within w_con_extracto_cuenta_masivo_borrar
end type
type st_2 from statictext within w_con_extracto_cuenta_masivo_borrar
end type
type em_cuenta2 from u_em_campo within w_con_extracto_cuenta_masivo_borrar
end type
type cb_detalle from u_boton within w_con_extracto_cuenta_masivo_borrar
end type
end forward

global type w_con_extracto_cuenta_masivo_borrar from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2196
string title = "Consulta de Movimientos"
gb_3 gb_3
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
cb_concepto cb_concepto
dw_listado dw_listado
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
rb_si rb_si
rb_no rb_no
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
gb_cuenta gb_cuenta
em_cuenta1 em_cuenta1
st_2 st_2
em_cuenta2 em_cuenta2
cb_detalle cb_detalle
end type
global w_con_extracto_cuenta_masivo_borrar w_con_extracto_cuenta_masivo_borrar

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_cadena ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_cadena ();Integer numero,registros,x1
String cadena,cadena1
Dec marcados
marcados = 0
cadena = ""
numero = uo_tipo2.dw_marca.RowCount()
IF numero =0  Then return ""

	FOR x1 = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(x1,"marca") = "S" THEN
			marcados = marcados +1
      	
      	IF Trim(cadena) = "" Then
         	cadena = "'" + uo_tipo2.dw_marca.GetItemString(x1,"codigo") + "'"
      	Else
         	cadena = cadena +",'" + uo_tipo2.dw_marca.GetItemString(x1,"codigo") + "'"
      	End If
  		END IF
	NEXT
				cadena = "(" + cadena + ")"
return cadena
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
uo_tipo2.visible  = FALSE

string con[100]
Integer numero,i,j=0

numero = uo_tipo2.dw_marca.RowCount()
IF numero <> 0  Then 
	FOR i = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(i,"marca") = "S" THEN
      j=j+1
		con[j]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
		END IF
	NEXT
	IF j=0 THEN
		FOR i = 1 To numero
   		con[i]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
			j=numero
		NEXT
	END IF
	FOR i = j+1 TO 20
		con[i]=""
	NEXT
END IF
	
Datetime fechad,fechah
integer ejer
dec debe,haber,saldo_inicial
integer ini

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))

if rb_si.checked=true then
	ini=1
else
	ini=0
end if


registros = dw_data.Retrieve(codigo_empresa,fechad,fechah,em_cuenta1.text,em_cuenta2.text,ini,con)

If registros = 0 Then Return


end subroutine

event open;call super::open;This.title = " EXTRACTO DE UNA CUENTA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"codigo")
  var_texto2   = dw_proceso2.GetItemString(x2,"descripcion")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Concepto"
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(em_fechadesde)


end event

on w_con_extracto_cuenta_masivo_borrar.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.cb_concepto=create cb_concepto
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.rb_si=create rb_si
this.rb_no=create rb_no
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.gb_cuenta=create gb_cuenta
this.em_cuenta1=create em_cuenta1
this.st_2=create st_2
this.em_cuenta2=create em_cuenta2
this.cb_detalle=create cb_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_concepto
this.Control[iCurrent+9]=this.dw_listado
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.pb_imprimir_preli
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.rb_si
this.Control[iCurrent+14]=this.rb_no
this.Control[iCurrent+15]=this.uo_tipo2
this.Control[iCurrent+16]=this.dw_proceso2
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.gb_cuenta
this.Control[iCurrent+19]=this.em_cuenta1
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.em_cuenta2
this.Control[iCurrent+22]=this.cb_detalle
end on

on w_con_extracto_cuenta_masivo_borrar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.cb_concepto)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.rb_si)
destroy(this.rb_no)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.gb_cuenta)
destroy(this.em_cuenta1)
destroy(this.st_2)
destroy(this.em_cuenta2)
destroy(this.cb_detalle)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_con_extracto_cuenta_masivo_borrar = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_extracto_cuenta_masivo_borrar
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_extracto_cuenta_masivo_borrar
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_extracto_cuenta_masivo_borrar
integer y = 16
integer width = 2642
end type

type gb_3 from groupbox within w_con_extracto_cuenta_masivo_borrar
integer x = 1979
integer y = 152
integer width = 274
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Iniciales"
end type

type pb_2 from upb_salir within w_con_extracto_cuenta_masivo_borrar
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_con_extracto_cuenta_masivo_borrar
integer x = 37
integer y = 224
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_extracto_cuenta_masivo_borrar
integer x = 5
integer y = 152
integer width = 658
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_extracto_cuenta_masivo_borrar
integer x = 2565
integer y = 152
integer width = 283
integer height = 72
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.visible   = TRUE

end event

type em_fechahasta from u_em_campo within w_con_extracto_cuenta_masivo_borrar
integer x = 361
integer y = 224
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_extracto_cuenta_masivo_borrar
integer x = 320
integer y = 204
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_concepto from u_boton within w_con_extracto_cuenta_masivo_borrar
event clicked pbm_bnclicked
integer x = 2290
integer y = 152
integer width = 274
integer height = 72
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Tipos"
end type

event clicked;call super::clicked;dw_1.visible=false
uo_tipo2.visible=true
end event

type dw_listado from datawindow within w_con_extracto_cuenta_masivo_borrar
boolean visible = false
integer x = 14
integer y = 72
integer width = 334
integer height = 116
boolean bringtotop = true
string dataobject = "report_con_extracto_cta_masivo"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_extracto_cuenta_masivo_borrar
integer x = 2277
integer y = 116
integer width = 585
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_con_extracto_cuenta_masivo_borrar
integer x = 2738
integer y = 252
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;IF cb_detalle.Text = "Resumen" Then
	dw_listado.DataObject = "report_con_extracto_cta_masivo_resumen"
else
	dw_listado.DataObject = "report_con_extracto_cta_masivo"
end if


f_cargar(dw_listado)
dw_listado.visible = FALSE
f_imprimir_datawindow(dw_listado)

end event

type uo_1 from u_manejo_datawindow within w_con_extracto_cuenta_masivo_borrar
integer x = 2263
integer y = 208
integer width = 608
integer height = 160
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type rb_si from radiobutton within w_con_extracto_cuenta_masivo_borrar
integer x = 2039
integer y = 204
integer width = 142
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sí"
boolean checked = true
end type

type rb_no from radiobutton within w_con_extracto_cuenta_masivo_borrar
integer x = 2039
integer y = 260
integer width = 142
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No"
end type

type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta_masivo_borrar
boolean visible = false
integer x = 1435
integer y = 364
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_con_extracto_cuenta_masivo_borrar
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_extracto_cuenta_masivo_borrar
integer y = 360
integer width = 2857
integer height = 1612
string dataobject = "dw_con_extracto_cuenta_masivo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
  
  OpenWithParm(w_int_contaapun,zstr_param) 

end event

type gb_cuenta from groupbox within w_con_extracto_cuenta_masivo_borrar
integer x = 672
integer y = 152
integer width = 891
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

type em_cuenta1 from u_em_campo within w_con_extracto_cuenta_masivo_borrar
integer x = 690
integer y = 224
integer width = 384
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
string mask = ""
string displaydata = "~b"
end type

type st_2 from statictext within w_con_extracto_cuenta_masivo_borrar
integer x = 1093
integer y = 204
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cuenta2 from u_em_campo within w_con_extracto_cuenta_masivo_borrar
integer x = 1138
integer y = 224
integer width = 384
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
string mask = ""
string displaydata = ""
end type

type cb_detalle from u_boton within w_con_extracto_cuenta_masivo_borrar
event clicked pbm_bnclicked
integer x = 1586
integer y = 208
integer width = 288
integer height = 92
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Detalle"
end type

event clicked;call super::clicked;IF Text = "Resumen" Then
	text = "Detalle"
			dw_1.Modify("DataWindow.Detail.Height=81")
Else
	text = "Resumen"
			dw_1.Modify("DataWindow.Detail.Height=0")
End If



end event

