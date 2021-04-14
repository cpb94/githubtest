$PBExportHeader$w_con_diario_analitica.srw
$PBExportComments$€ Consulta/listado diario cuentas analitica
forward
global type w_con_diario_analitica from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_diario_analitica
end type
type cb_consulta from u_boton within w_con_diario_analitica
end type
type st_1 from statictext within w_con_diario_analitica
end type
type dw_listado from datawindow within w_con_diario_analitica
end type
type gb_2 from groupbox within w_con_diario_analitica
end type
type dw_1 from datawindow within w_con_diario_analitica
end type
type uo_perid from u_em_campo_2 within w_con_diario_analitica
end type
type uo_perih from u_em_campo_2 within w_con_diario_analitica
end type
type gb_1 from groupbox within w_con_diario_analitica
end type
type pb_imprimir_preli from picturebutton within w_con_diario_analitica
end type
end forward

global type w_con_diario_analitica from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2930
integer height = 2284
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
st_1 st_1
dw_listado dw_listado
gb_2 gb_2
dw_1 dw_1
uo_perid uo_perid
uo_perih uo_perih
gb_1 gb_1
pb_imprimir_preli pb_imprimir_preli
end type
global w_con_diario_analitica w_con_diario_analitica

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE


tipo_array debe_haber
Integer perid,perih, asiend, asienh
integer ejer
dec debe,haber,saldo_inicial
integer ini

perid=Dec(Trim(uo_perid.em_codigo.text))
perih=Dec(Trim(uo_perih.em_codigo.text))
ejer= f_ejercicio_activo(codigo_empresa)

IF perih = 0 OR IsNull(perih) THEN
	perih = 12
END IF

registros = dw_data.Retrieve(codigo_empresa,ejer,perid,perih)

If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " DIARIO CONTABLE CUENTAS ANALITICAS"

f_activar_campo(uo_perid.em_campo)


end event

on w_con_diario_analitica.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.dw_1=create dw_1
this.uo_perid=create uo_perid
this.uo_perih=create uo_perih
this.gb_1=create gb_1
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_perid
this.Control[iCurrent+8]=this.uo_perih
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.pb_imprimir_preli
end on

on w_con_diario_analitica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.uo_perid)
destroy(this.uo_perih)
destroy(this.gb_1)
destroy(this.pb_imprimir_preli)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_diario_analitica
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_diario_analitica
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_diario_analitica
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_diario_analitica
integer x = 2729
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_con_diario_analitica
integer x = 2144
integer y = 220
integer width = 270
integer height = 84
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

dw_1.visible   = TRUE
end event

type st_1 from statictext within w_con_diario_analitica
integer x = 512
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

type dw_listado from datawindow within w_con_diario_analitica
boolean visible = false
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_con_diario"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_diario_analitica
integer x = 2126
integer y = 184
integer width = 416
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_con_diario_analitica
integer x = 9
integer y = 364
integer width = 2857
integer height = 1708
string dataobject = "dw_con_diario_analitica"
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

type uo_perid from u_em_campo_2 within w_con_diario_analitica
event destroy ( )
integer x = 55
integer y = 228
integer width = 425
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_perid.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_perid.em_campo.text=f_nombre_mes(Dec(uo_perid.em_codigo.text))

IF Trim(uo_perid.em_campo.text)="" THEN 
 IF Trim(uo_perid.em_codigo.text)<>"" Then uo_perid.em_campo.SetFocus()
 uo_perid.em_campo.text=""
 uo_perid.em_codigo.text=""
END IF

end event

type uo_perih from u_em_campo_2 within w_con_diario_analitica
event destroy ( )
integer x = 585
integer y = 224
integer width = 425
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_perih.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_perih.em_campo.text=f_nombre_mes(Dec(uo_perih.em_codigo.text))

IF Trim(uo_perih.em_campo.text)="" THEN 
 IF Trim(uo_perih.em_codigo.text)<>"" Then uo_perih.em_campo.SetFocus()
 uo_perih.em_campo.text="Diciembre"
 uo_perih.em_codigo.text="12"
END IF
 IF Dec(Trim(uo_perih.em_codigo.text)) > Dec(Trim(uo_perih.em_codigo.text))THEN
	 uo_perih.em_campo.SetFocus()
END IF
end event

type gb_1 from groupbox within w_con_diario_analitica
integer x = 5
integer y = 164
integer width = 1024
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Período"
end type

type pb_imprimir_preli from picturebutton within w_con_diario_analitica
integer x = 2418
integer y = 216
integer width = 105
integer height = 88
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
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

