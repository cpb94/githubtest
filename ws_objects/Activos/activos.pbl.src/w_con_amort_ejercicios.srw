$PBExportHeader$w_con_amort_ejercicios.srw
forward
global type w_con_amort_ejercicios from w_int_con_empresa
end type
type dw_1 from u_datawindow within w_con_amort_ejercicios
end type
type cb_3 from u_boton within w_con_amort_ejercicios
end type
type dw_listado from datawindow within w_con_amort_ejercicios
end type
type pb_1 from upb_imprimir within w_con_amort_ejercicios
end type
type pb_2 from upb_salir within w_con_amort_ejercicios
end type
type gb_3 from groupbox within w_con_amort_ejercicios
end type
type gb_2 from groupbox within w_con_amort_ejercicios
end type
type rb_1 from radiobutton within w_con_amort_ejercicios
end type
type rb_2 from radiobutton within w_con_amort_ejercicios
end type
type rb_3 from radiobutton within w_con_amort_ejercicios
end type
type rb_4 from radiobutton within w_con_amort_ejercicios
end type
type rb_5 from radiobutton within w_con_amort_ejercicios
end type
type rb_6 from radiobutton within w_con_amort_ejercicios
end type
type uo_ejercicio from u_ejercicio within w_con_amort_ejercicios
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

global type w_con_amort_ejercicios from w_int_con_empresa
int X=5
int Y=16
int Width=3621
int Height=2072
boolean TitleBar=true
string Title=""
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
pb_1 pb_1
pb_2 pb_2
gb_3 gb_3
gb_2 gb_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
uo_ejercicio uo_ejercicio
end type
global w_con_amort_ejercicios w_con_amort_ejercicios

type variables


end variables

on w_con_amort_ejercicios.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.uo_ejercicio=create uo_ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.rb_4
this.Control[iCurrent+12]=this.rb_5
this.Control[iCurrent+13]=this.rb_6
this.Control[iCurrent+14]=this.uo_ejercicio
end on

on w_con_amort_ejercicios.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.uo_ejercicio)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Amortización por Ejercicios" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_amort_ejercicios
int TabOrder=70
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_amort_ejercicios
int Width=2757
boolean BringToTop=true
end type

type dw_1 from u_datawindow within w_con_amort_ejercicios
int X=23
int Y=488
int Width=3525
int Height=1432
int TabOrder=0
string DataObject="dw_con_amort_ejercicios"
BorderStyle BorderStyle=StyleRaised!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_3 from u_boton within w_con_amort_ejercicios
event clicked pbm_bnclicked
int X=2811
int Y=164
int Width=334
int Height=128
int TabOrder=60
string Text="&Consulta"
end type

event clicked;String	cont,plan

If rb_4.checked then
	cont= 'S'
	plan = 'N'
ElseIf rb_5.checked then
		cont= 'N'
		plan = 'S'
	 ElseIf rb_6.checked then
			cont= 'S'
			plan = 'S'	
End IF

dw_1.SetRedraw(False)

dw_1.Retrieve(codigo_empresa,dec(uo_ejercicio.em_ejercicio.text),cont,plan)

If rb_1.checked then 
	dw_1.modify("datawindow.header.1.height = 64")
	dw_1.modify("datawindow.trailer.1.height = 64")
	dw_1.modify("datawindow.header.2.height = 0")
	dw_1.modify("datawindow.trailer.2.height = 0")
	dw_1.modify("datawindow.header.3.height = 0")
	dw_1.modify("datawindow.trailer.3.height = 0")
ElseIf rb_2.checked then 
		dw_1.modify("datawindow.header.1.height = 0")
		dw_1.modify("datawindow.trailer.1.height = 0")
		dw_1.modify("datawindow.header.2.height = 64")
		dw_1.modify("datawindow.trailer.2.height = 64")
		dw_1.modify("datawindow.header.3.height = 0")
		dw_1.modify("datawindow.trailer.3.height = 0")
	ElseIf rb_3.checked then 
			dw_1.modify("datawindow.header.1.height = 0")
			dw_1.modify("datawindow.trailer.1.height = 0")
			dw_1.modify("datawindow.header.2.height = 0")
			dw_1.modify("datawindow.trailer.2.height = 0")
			dw_1.modify("datawindow.header.3.height = 64")
			dw_1.modify("datawindow.trailer.3.height = 64")
End If

dw_1.SetRedraw(True)

end event

type dw_listado from datawindow within w_con_amort_ejercicios
int X=133
int Y=228
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
boolean BringToTop=true
string DataObject="report_amort_ejercicios"
boolean LiveScroll=true
end type

type pb_1 from upb_imprimir within w_con_amort_ejercicios
int X=3214
int Y=160
int Width=146
int Height=132
int TabOrder=50
boolean BringToTop=true
string PictureName="c:\bmp\print.bmp"
boolean OriginalSize=false
end type

event clicked;String	cont,plan

If rb_4.checked then
	cont= 'S'
	plan = 'N'
ElseIf rb_5.checked then
		cont= 'N'
		plan = 'S'
	 ElseIf rb_6.checked then
			cont= 'S'
			plan = 'S'	
End IF

dw_listado.SetRedraw(False)

dw_listado.Retrieve(codigo_empresa,dec(uo_ejercicio.em_ejercicio.text),cont,plan)

If rb_1.checked then 
	dw_listado.modify("datawindow.header.1.height = 64")
	dw_listado.modify("datawindow.trailer.1.height = 64")
	dw_listado.modify("datawindow.header.2.height = 0")
	dw_listado.modify("datawindow.trailer.2.height = 0")
	dw_listado.modify("datawindow.header.3.height = 0")
	dw_listado.modify("datawindow.trailer.3.height = 0")
ElseIf rb_2.checked then 
		dw_listado.modify("datawindow.header.1.height = 0")
		dw_listado.modify("datawindow.trailer.1.height = 0")
		dw_listado.modify("datawindow.header.2.height = 64")
		dw_listado.modify("datawindow.trailer.2.height = 64")
		dw_listado.modify("datawindow.header.3.height = 0")
		dw_listado.modify("datawindow.trailer.3.height = 0")
	ElseIf rb_3.checked then 
			dw_listado.modify("datawindow.header.1.height = 0")
			dw_listado.modify("datawindow.trailer.1.height = 0")
			dw_listado.modify("datawindow.header.2.height = 0")
			dw_listado.modify("datawindow.trailer.2.height = 0")
			dw_listado.modify("datawindow.header.3.height = 64")
			dw_listado.modify("datawindow.trailer.3.height = 64")
End If

dw_listado.SetRedraw(True)

f_imprimir_datawindow(dw_listado)
end event

type pb_2 from upb_salir within w_con_amort_ejercicios
int X=3360
int Y=160
int TabOrder=20
boolean BringToTop=true
string PictureName="c:\bmp\salir1.bmp"
end type

type gb_3 from groupbox within w_con_amort_ejercicios
int X=1522
int Y=320
int Width=1312
int Height=152
int TabOrder=30
string Text="Amortización"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_con_amort_ejercicios
int X=14
int Y=320
int Width=1458
int Height=152
int TabOrder=40
string Text="Totales"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_con_amort_ejercicios
int X=46
int Y=380
int Width=494
int Height=76
boolean BringToTop=true
string Text="Por C. Activo"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_con_amort_ejercicios
int X=512
int Y=380
int Width=494
int Height=76
boolean BringToTop=true
string Text="Por C. Cargo"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_con_amort_ejercicios
int X=965
int Y=380
int Width=494
int Height=76
boolean BringToTop=true
string Text="Por C. Abono"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_con_amort_ejercicios
int X=1550
int Y=380
int Width=494
int Height=76
boolean BringToTop=true
string Text="Contabilizada"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_5 from radiobutton within w_con_amort_ejercicios
int X=2043
int Y=380
int Width=494
int Height=76
boolean BringToTop=true
string Text="Planificación"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_6 from radiobutton within w_con_amort_ejercicios
int X=2523
int Y=380
int Width=297
int Height=76
boolean BringToTop=true
string Text="Ambas"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_ejercicio from u_ejercicio within w_con_amort_ejercicios
int X=41
int Y=168
int TabOrder=50
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

