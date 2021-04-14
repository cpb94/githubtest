$PBExportHeader$w_con_diario_mov.srw
forward
global type w_con_diario_mov from w_int_con_empresa
end type
type dw_1 from u_datawindow within w_con_diario_mov
end type
type cb_3 from u_boton within w_con_diario_mov
end type
type dw_listado from datawindow within w_con_diario_mov
end type
type st_8 from statictext within w_con_diario_mov
end type
type em_fechadesde from u_em_campo within w_con_diario_mov
end type
type st_9 from statictext within w_con_diario_mov
end type
type gb_3 from groupbox within w_con_diario_mov
end type
type gb_2 from groupbox within w_con_diario_mov
end type
type gb_1 from groupbox within w_con_diario_mov
end type
type em_fechahasta from u_em_campo within w_con_diario_mov
end type
type pb_1 from upb_imprimir within w_con_diario_mov
end type
type pb_2 from upb_salir within w_con_diario_mov
end type
type rb_1 from radiobutton within w_con_diario_mov
end type
type rb_2 from radiobutton within w_con_diario_mov
end type
type rb_3 from radiobutton within w_con_diario_mov
end type
type rb_4 from radiobutton within w_con_diario_mov
end type
type rb_5 from radiobutton within w_con_diario_mov
end type
type rb_6 from radiobutton within w_con_diario_mov
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

global type w_con_diario_mov from w_int_con_empresa
int X=46
int Y=32
int Width=3054
int Height=2152
boolean TitleBar=true
string Title=""
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
em_fechahasta em_fechahasta
pb_1 pb_1
pb_2 pb_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
end type
global w_con_diario_mov w_con_diario_mov

type variables


end variables

on w_con_diario_mov.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.pb_1=create pb_1
this.pb_2=create pb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.em_fechahasta
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.rb_1
this.Control[iCurrent+14]=this.rb_2
this.Control[iCurrent+15]=this.rb_3
this.Control[iCurrent+16]=this.rb_4
this.Control[iCurrent+17]=this.rb_5
this.Control[iCurrent+18]=this.rb_6
end on

on w_con_diario_mov.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Diario de Movimientos" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

em_fechadesde.text = String(Date("01-01-" + String(Year(Today()))),"dd-mm-yy")
em_fechahasta.text = String(Today(),"dd-mm-yy")


dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_diario_mov
int TabOrder=90
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_diario_mov
int Width=2757
boolean BringToTop=true
end type

type dw_1 from u_datawindow within w_con_diario_mov
int X=18
int Y=520
int Width=2949
int Height=1476
int TabOrder=0
string DataObject="dw_con_diario_mov"
BorderStyle BorderStyle=StyleRaised!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_3 from u_boton within w_con_diario_mov
event clicked pbm_bnclicked
int X=2171
int Y=196
int Width=274
int Height=88
int TabOrder=80
string Text="&Consulta"
end type

event clicked;String	act1,act2

If rb_4.checked then
	act1 = 'S'
	act2 = 'S'
ElseIf rb_5.checked then
		act1 = 'N'
		act2 = 'N'
	 ElseIf rb_6.checked then
			act1 = 'S'
			act2 = 'N'	
End IF


dw_1.SetRedraw(False)

dw_1.Retrieve(codigo_empresa,DateTime(date(em_fechadesde.text)),DateTime(date(em_fechahasta.text)),act1,act2)

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

type dw_listado from datawindow within w_con_diario_mov
int X=133
int Y=228
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
boolean BringToTop=true
string DataObject="report_diario_mov"
boolean LiveScroll=true
end type

type st_8 from statictext within w_con_diario_mov
int X=571
int Y=216
int Width=233
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Hasta"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fechadesde from u_em_campo within w_con_diario_mov
int X=279
int Y=212
int Width=288
int Height=80
int TabOrder=60
boolean BringToTop=true
Alignment Alignment=Center!
string Mask="dd-mm-yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_9 from statictext within w_con_diario_mov
int X=41
int Y=216
int Width=233
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Desde"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_con_diario_mov
int X=1536
int Y=336
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

type gb_2 from groupbox within w_con_diario_mov
int X=27
int Y=336
int Width=1495
int Height=152
int TabOrder=20
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

type gb_1 from groupbox within w_con_diario_mov
int X=27
int Y=148
int Width=1088
int Height=172
int TabOrder=50
string Text="Fechas"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fechahasta from u_em_campo within w_con_diario_mov
int X=800
int Y=212
int Width=297
int Height=80
int TabOrder=70
boolean BringToTop=true
Alignment Alignment=Center!
string Mask="dd-mm-yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type pb_1 from upb_imprimir within w_con_diario_mov
int X=2574
int Y=192
int Width=146
int Height=132
int TabOrder=40
boolean BringToTop=true
string PictureName="c:\bmp\print.bmp"
boolean OriginalSize=false
end type

event clicked;String	act1,act2

dw_listado.SetRedraw(False)

If rb_4.checked then
	act1 = 'S'
	act2 = 'S'
ElseIf rb_5.checked then
		act1 = 'N'
		act2 = 'N'
	 ElseIf rb_6.checked then
			act1 = 'S'
			act2 = 'N'	
End IF


dw_listado.Retrieve(codigo_empresa,DateTime(date(em_fechadesde.text)),DateTime(date(em_fechahasta.text)),act1,act2)

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

type pb_2 from upb_salir within w_con_diario_mov
int X=2720
int Y=192
int TabOrder=30
boolean BringToTop=true
string PictureName="c:\bmp\salir1.bmp"
end type

type rb_1 from radiobutton within w_con_diario_mov
int X=69
int Y=396
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

type rb_2 from radiobutton within w_con_diario_mov
int X=544
int Y=396
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

type rb_3 from radiobutton within w_con_diario_mov
int X=1024
int Y=396
int Width=480
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

type rb_4 from radiobutton within w_con_diario_mov
int X=1563
int Y=396
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

type rb_5 from radiobutton within w_con_diario_mov
int X=2057
int Y=396
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

type rb_6 from radiobutton within w_con_diario_mov
int X=2537
int Y=396
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

