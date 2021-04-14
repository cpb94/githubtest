$PBExportHeader$w_con_amort_fiscal.srw
forward
global type w_con_amort_fiscal from w_int_con_empresa
end type
type dw_1 from u_datawindow within w_con_amort_fiscal
end type
type cb_3 from u_boton within w_con_amort_fiscal
end type
type dw_listado from datawindow within w_con_amort_fiscal
end type
type pb_1 from upb_imprimir within w_con_amort_fiscal
end type
type pb_2 from upb_salir within w_con_amort_fiscal
end type
type uo_ejercicio from u_ejercicio within w_con_amort_fiscal
end type
type gb_3 from groupbox within w_con_amort_fiscal
end type
type rb_4 from radiobutton within w_con_amort_fiscal
end type
type rb_5 from radiobutton within w_con_amort_fiscal
end type
type rb_6 from radiobutton within w_con_amort_fiscal
end type
type kk from structure within w_con_amort_fiscal
end type
end forward

type kk from structure
	string		empresa
	decimal {0}	elemento
	integer		amortizacion
	decimal {0}	ejercicio
	decimal {0}	clase_inmobilizado
	string		familia
	decimal {0}	bien
	decimal {0}	periodo
	string		tipo_amor
	decimal {0}	porcentaje_amor
	string		cuenta_activo
	string		cuenta_cargo
	string		cuenta_abono
	string		seccion
	string		centro_coste
	date		fecha_contable
	decimal {0}	asiento
	string		actualizado
	date		fecha_amor
	decimal {0}	importe_amor
	decimal {0}	importe_amorfis
	string		clase_amor
end type

global type w_con_amort_fiscal from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 2935
integer height = 2088
string title = "Amortización Fiscal"
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
pb_1 pb_1
pb_2 pb_2
uo_ejercicio uo_ejercicio
gb_3 gb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
end type
global w_con_amort_fiscal w_con_amort_fiscal

type variables


end variables

on w_con_amort_fiscal.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_ejercicio=create uo_ejercicio
this.gb_3=create gb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.uo_ejercicio
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_5
this.Control[iCurrent+10]=this.rb_6
end on

on w_con_amort_fiscal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_ejercicio)
destroy(this.gb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Amortización Fiscal" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)



end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_amort_fiscal
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_amort_fiscal
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_amort_fiscal
integer width = 2757
end type

type dw_1 from u_datawindow within w_con_amort_fiscal
integer x = 23
integer y = 340
integer width = 2830
integer height = 1572
integer taborder = 0
string dataobject = "dw_con_amort_fiscal"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_3 from u_boton within w_con_amort_fiscal
event clicked pbm_bnclicked
integer x = 2080
integer y = 180
integer width = 315
integer height = 132
integer taborder = 50
string text = "&Consulta"
end type

event clicked;String	act1,act2

If rb_4.checked then
	act1= 'S'
	act2 = 'S'
ElseIf rb_5.checked then
		act1= 'N'
		act2 = 'N'
	 ElseIf rb_6.checked then
			act1= 'S'
			act2 = 'N'	
End IF

dw_1.SetRedraw(False)

dw_1.Retrieve(codigo_empresa,dec(uo_ejercicio.em_ejercicio.text),act1,act2)

dw_1.SetRedraw(True)

end event

type dw_listado from datawindow within w_con_amort_fiscal
boolean visible = false
integer x = 133
integer y = 228
integer width = 494
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_amort_fiscal"
boolean livescroll = true
end type

type pb_1 from upb_imprimir within w_con_amort_fiscal
integer x = 2395
integer y = 180
integer width = 146
integer height = 132
integer taborder = 40
boolean bringtotop = true
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;String	act1,act2

If rb_4.checked then
	act1= 'S'
	act2 = 'S'
ElseIf rb_5.checked then
		act1= 'N'
		act2 = 'N'
	 ElseIf rb_6.checked then
			act1= 'S'
			act2 = 'N'	
End IF
dw_listado.SetRedraw(False)

dw_listado.Retrieve(codigo_empresa,dec(uo_ejercicio.em_ejercicio.text),act1,act2)

dw_listado.SetRedraw(True)

f_imprimir_datawindow(dw_listado)
end event

type pb_2 from upb_salir within w_con_amort_fiscal
integer x = 2542
integer y = 180
integer taborder = 30
boolean bringtotop = true
string picturename = "c:\bmp\salir1.bmp"
end type

type uo_ejercicio from u_ejercicio within w_con_amort_fiscal
integer x = 41
integer y = 180
integer taborder = 20
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type gb_3 from groupbox within w_con_amort_fiscal
integer x = 690
integer y = 148
integer width = 1312
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Amortización"
end type

type rb_4 from radiobutton within w_con_amort_fiscal
integer x = 718
integer y = 208
integer width = 494
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contabilizada"
boolean checked = true
end type

type rb_5 from radiobutton within w_con_amort_fiscal
integer x = 1211
integer y = 208
integer width = 494
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Planificación"
end type

type rb_6 from radiobutton within w_con_amort_fiscal
integer x = 1691
integer y = 208
integer width = 297
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ambas"
end type

