$PBExportHeader$w_con_extracto_cuenta_punteo.srw
$PBExportComments$€
forward
global type w_con_extracto_cuenta_punteo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_extracto_cuenta_punteo
end type
type em_fechadesde from u_em_campo within w_con_extracto_cuenta_punteo
end type
type gb_1 from groupbox within w_con_extracto_cuenta_punteo
end type
type cb_consulta from u_boton within w_con_extracto_cuenta_punteo
end type
type em_fechahasta from u_em_campo within w_con_extracto_cuenta_punteo
end type
type st_1 from statictext within w_con_extracto_cuenta_punteo
end type
type dw_listado from datawindow within w_con_extracto_cuenta_punteo
end type
type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta_punteo
end type
type dw_proceso2 from datawindow within w_con_extracto_cuenta_punteo
end type
type dw_1 from datawindow within w_con_extracto_cuenta_punteo
end type
type uo_cuenta from u_em_campo within w_con_extracto_cuenta_punteo
end type
type st_nom from statictext within w_con_extracto_cuenta_punteo
end type
type gb_cuenta from groupbox within w_con_extracto_cuenta_punteo
end type
type gb_2 from groupbox within w_con_extracto_cuenta_punteo
end type
type st_2 from statictext within w_con_extracto_cuenta_punteo
end type
type st_3 from statictext within w_con_extracto_cuenta_punteo
end type
type st_5 from statictext within w_con_extracto_cuenta_punteo
end type
type saldo from statictext within w_con_extracto_cuenta_punteo
end type
type saldo1 from statictext within w_con_extracto_cuenta_punteo
end type
type saldo2 from statictext within w_con_extracto_cuenta_punteo
end type
end forward

global type w_con_extracto_cuenta_punteo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 2200
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
dw_listado dw_listado
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
uo_cuenta uo_cuenta
st_nom st_nom
gb_cuenta gb_cuenta
gb_2 gb_2
st_2 st_2
st_3 st_3
st_5 st_5
saldo saldo
saldo1 saldo1
saldo2 saldo2
end type
global w_con_extracto_cuenta_punteo w_con_extracto_cuenta_punteo

type variables
String punta = "T"
end variables

forward prototypes
public subroutine f_saldos ()
public subroutine f_cargar (datawindow dw_data, string p)
end prototypes

public subroutine f_saldos ();Datetime fechad,fechah
integer ejer
dec vsaldo,vsaldo1,vsaldo2
String cta

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))

cta = uo_cuenta.text

vsaldo = f_saldo_cuenta(ejer,codigo_empresa,cta,fechad,fechah)
vsaldo1 = f_saldo_cuenta_punteado(ejer,codigo_empresa,cta,fechad,fechah)
vsaldo2 = vsaldo - vsaldo1


saldo.text  = String(vsaldo,f_mascara_decimales(0))
saldo1.text =String(vsaldo1,f_mascara_decimales(0))
saldo2.text =String(vsaldo2,f_mascara_decimales(0))
end subroutine

public subroutine f_cargar (datawindow dw_data, string p);punta = p
Integer registros
dw_data.SetTransObject(sqlca)
dw_data.reset()

tipo_array debe_haber
Datetime fechad,fechah
integer ejer
dec debe,haber,saldo_inicial
Integer ini

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))
registros = dw_data.Retrieve(codigo_empresa,fechad,fechah,uo_cuenta.text,p)
If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " EXTRACTO DE UNA CUENTA (PUNTEO)"

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

on w_con_extracto_cuenta_punteo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.uo_cuenta=create uo_cuenta
this.st_nom=create st_nom
this.gb_cuenta=create gb_cuenta
this.gb_2=create gb_2
this.st_2=create st_2
this.st_3=create st_3
this.st_5=create st_5
this.saldo=create saldo
this.saldo1=create saldo1
this.saldo2=create saldo2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.uo_cuenta
this.Control[iCurrent+12]=this.st_nom
this.Control[iCurrent+13]=this.gb_cuenta
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.saldo
this.Control[iCurrent+19]=this.saldo1
this.Control[iCurrent+20]=this.saldo2
end on

on w_con_extracto_cuenta_punteo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.uo_cuenta)
destroy(this.st_nom)
destroy(this.gb_cuenta)
destroy(this.gb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.saldo)
destroy(this.saldo1)
destroy(this.saldo2)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_con_extracto_cuenta_punteo = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_extracto_cuenta_punteo
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_extracto_cuenta_punteo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_extracto_cuenta_punteo
integer x = 5
integer y = 4
integer width = 2642
end type

type pb_2 from upb_salir within w_con_extracto_cuenta_punteo
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_con_extracto_cuenta_punteo
integer x = 41
integer y = 172
integer width = 279
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_extracto_cuenta_punteo
integer x = 5
integer y = 100
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

type cb_consulta from u_boton within w_con_extracto_cuenta_punteo
integer x = 2299
integer y = 156
integer width = 512
integer height = 88
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;f_cargar(dw_1,"N")
dw_1.visible   = TRUE
f_saldos()
end event

type em_fechahasta from u_em_campo within w_con_extracto_cuenta_punteo
integer x = 361
integer y = 172
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_extracto_cuenta_punteo
integer x = 320
integer y = 152
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

type dw_listado from datawindow within w_con_extracto_cuenta_punteo
boolean visible = false
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_con_extracto_cuenta_punteado"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta_punteo
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

type dw_proceso2 from datawindow within w_con_extracto_cuenta_punteo
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_extracto_cuenta_punteo
integer x = 5
integer y = 364
integer width = 2857
integer height = 1616
string dataobject = "dw_con_extracto_cuenta_punteo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 OR IsNull(row) THEN RETURN
	
str_parametros zstr_param
zstr_param.i_nargumentos=5
zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))

OpenWithParm(w_int_contaapun,zstr_param) 


end event

event rbuttondown;if row > 0 then
	IF object.punteado[row] = ""  OR IsNull(object.punteado[row])Then 	object.punteado[row] = "N"
	accepttext()
	IF object.punteado[row] = "N" Then
		object.punteado[row] = "S"
	ELSE
		object.punteado[row] = "N"
	END IF
	update()
	commit;
	f_Saldos()
end if
end event

event clicked;IF f_objeto_datawindow(This) = "punta" Then
	IF punta = "S" Then
		f_cargar(dw_1,"N")
		punta = "N"
	ELSE
		f_cargar(dw_1,"S")
		punta= "S"
	END IF
END IF
end event

type uo_cuenta from u_em_campo within w_con_extracto_cuenta_punteo
integer x = 686
integer y = 172
integer width = 457
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"

end event

event modificado;call super::modificado;st_nom.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta.text)
If Trim(st_nom.text)="" then
	st_nom.text=""
	uo_cuenta.text=""
	Return
end if 


end event

type st_nom from statictext within w_con_extracto_cuenta_punteo
integer x = 1152
integer y = 180
integer width = 1070
integer height = 72
boolean bringtotop = true
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

type gb_cuenta from groupbox within w_con_extracto_cuenta_punteo
integer x = 672
integer y = 100
integer width = 1582
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

type gb_2 from groupbox within w_con_extracto_cuenta_punteo
integer x = 2277
integer y = 116
integer width = 558
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_2 from statictext within w_con_extracto_cuenta_punteo
integer x = 23
integer y = 288
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Saldo Cuenta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_extracto_cuenta_punteo
integer x = 910
integer y = 288
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Saldo Punteado:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_extracto_cuenta_punteo
integer x = 1966
integer y = 288
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Saldo Puntear:"
alignment alignment = center!
boolean focusrectangle = false
end type

type saldo from statictext within w_con_extracto_cuenta_punteo
integer x = 379
integer y = 284
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type saldo1 from statictext within w_con_extracto_cuenta_punteo
integer x = 1353
integer y = 284
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type saldo2 from statictext within w_con_extracto_cuenta_punteo
integer x = 2359
integer y = 284
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

