$PBExportHeader$w_con_balance_analitica.srw
$PBExportComments$€
forward
global type w_con_balance_analitica from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_balance_analitica
end type
type em_fechadesde from u_em_campo within w_con_balance_analitica
end type
type gb_1 from groupbox within w_con_balance_analitica
end type
type cb_consulta from u_boton within w_con_balance_analitica
end type
type em_fechahasta from u_em_campo within w_con_balance_analitica
end type
type st_1 from statictext within w_con_balance_analitica
end type
type dw_listado from datawindow within w_con_balance_analitica
end type
type pb_imprimir_preli from picturebutton within w_con_balance_analitica
end type
type dw_1 from datawindow within w_con_balance_analitica
end type
type uo_tipo2 from u_marca_lista within w_con_balance_analitica
end type
type uo_cuenta from u_em_campo within w_con_balance_analitica
end type
type st_nom from statictext within w_con_balance_analitica
end type
type uo_cuenta2 from u_em_campo within w_con_balance_analitica
end type
type st_nom2 from statictext within w_con_balance_analitica
end type
type gb_cuenta from groupbox within w_con_balance_analitica
end type
type rb_nivel from radiobutton within w_con_balance_analitica
end type
end forward

global type w_con_balance_analitica from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2907
integer height = 2240
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_tipo2 uo_tipo2
uo_cuenta uo_cuenta
st_nom st_nom
uo_cuenta2 uo_cuenta2
st_nom2 st_nom2
gb_cuenta gb_cuenta
rb_nivel rb_nivel
end type
global w_con_balance_analitica w_con_balance_analitica

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String cta1,cta2
//dw_data.SetRedraw(FALSE)
iF Not rb_nivel.checked Then
	dw_1.DataObject = "dw_balance_analitica"
	dw_listado.DataObject = "report_balance_analitica"
ELSE
	dw_1.DataObject = "dw_balance_analitica_resumen"
	dw_listado.DataObject = "report_balance_analitica_resumen"
END IF
dw_listado.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
cta1 = uo_cuenta.text
cta2 = uo_cuenta2.text
IF Trim(cta1)= "" or IsNull(cta1) Then cta1 = "."
IF Trim(cta2)= "" or IsNull(cta2) Then cta2 = "Z"


dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE

Datetime fechad,fechah
integer ejer
dec debe,haber,saldo_inicial
integer ini

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))


registros = dw_data.Retrieve(codigo_empresa,fechad,fechah,f_digitos_analitica_primer_nivel(),cta1,cta2)
dw_data.SetSORT("coste,cuenta")
dw_data.Sort()
//dw_data.SetRedraw(TRUE)
dw_data.Groupcalc()

If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " BALANCE DE ANALITICA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
Date  fecha
long dia
em_fechahasta.text = String(Today(),"dd-mm-yy")





end event

on w_con_balance_analitica.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_tipo2=create uo_tipo2
this.uo_cuenta=create uo_cuenta
this.st_nom=create st_nom
this.uo_cuenta2=create uo_cuenta2
this.st_nom2=create st_nom2
this.gb_cuenta=create gb_cuenta
this.rb_nivel=create rb_nivel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.pb_imprimir_preli
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.uo_tipo2
this.Control[iCurrent+11]=this.uo_cuenta
this.Control[iCurrent+12]=this.st_nom
this.Control[iCurrent+13]=this.uo_cuenta2
this.Control[iCurrent+14]=this.st_nom2
this.Control[iCurrent+15]=this.gb_cuenta
this.Control[iCurrent+16]=this.rb_nivel
end on

on w_con_balance_analitica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_tipo2)
destroy(this.uo_cuenta)
destroy(this.st_nom)
destroy(this.uo_cuenta2)
destroy(this.st_nom2)
destroy(this.gb_cuenta)
destroy(this.rb_nivel)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_balance_analitica
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_balance_analitica
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_balance_analitica
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_balance_analitica
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_con_balance_analitica
integer x = 41
integer y = 224
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type gb_1 from groupbox within w_con_balance_analitica
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

type cb_consulta from u_boton within w_con_balance_analitica
integer x = 2469
integer y = 180
integer width = 265
integer height = 92
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;f_cargar(dw_1)
dw_1.visible   = TRUE
end event

type em_fechahasta from u_em_campo within w_con_balance_analitica
integer x = 361
integer y = 224
integer width = 279
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type st_1 from statictext within w_con_balance_analitica
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

type dw_listado from datawindow within w_con_balance_analitica
boolean visible = false
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_balance_analitica_resumen"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_balance_analitica
integer x = 2738
integer y = 180
integer width = 105
integer height = 88
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
dw_listado.visible = FALSE
end event

type dw_1 from datawindow within w_con_balance_analitica
integer y = 352
integer width = 2875
integer height = 1712
string dataobject = "dw_balance_analitica_resumen"
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
  
  IF zstr_param.s_argumentos[3] = "3" Then
	  OpenWithParm(w_int_facturas_recibidas,zstr_param) 
  END IF
  IF zstr_param.s_argumentos[3] = "2" Then
	  OpenWithParm(w_int_apuntes_general,zstr_param) 
  END IF
  IF zstr_param.s_argumentos[3] = "1" Then
	  OpenWithParm(w_int_contaapun,zstr_param) 
  END IF


end event

type uo_tipo2 from u_marca_lista within w_con_balance_analitica
event destroy ( )
boolean visible = false
integer x = 1435
integer y = 364
integer width = 1454
integer height = 652
integer taborder = 60
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type uo_cuenta from u_em_campo within w_con_balance_analitica
integer x = 677
integer y = 224
integer width = 302
integer height = 88
integer taborder = 50
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_costesplan_directo"
ue_filtro = "ejercicio = " + String(ejercicio_activo,"####")
end event

event modificado;call super::modificado;dw_1.RESET()
st_nom.text=f_nombre_costesplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta.text)



end event

type st_nom from statictext within w_con_balance_analitica
integer x = 983
integer y = 224
integer width = 576
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_cuenta2 from u_em_campo within w_con_balance_analitica
integer x = 1563
integer y = 224
integer width = 302
integer height = 88
integer taborder = 11
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_costesplan_directo"
ue_filtro = "ejercicio = " + String(ejercicio_activo,"####")
end event

event modificado;call super::modificado;dw_1.RESET()
st_nom2.text=f_nombre_costesplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta2.text)



end event

type st_nom2 from statictext within w_con_balance_analitica
integer x = 1870
integer y = 224
integer width = 576
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_cuenta from groupbox within w_con_balance_analitica
integer x = 667
integer y = 152
integer width = 1792
integer height = 180
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Rango de cuentas"
end type

type rb_nivel from radiobutton within w_con_balance_analitica
integer x = 2473
integer y = 276
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Nivel  1"
boolean automatic = false
boolean lefttext = true
end type

event clicked;IF checked  Then
	checked = FALSE
ELSE
	checked = TRUE
END IF
end event

