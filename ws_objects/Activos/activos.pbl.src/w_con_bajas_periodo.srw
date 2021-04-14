$PBExportHeader$w_con_bajas_periodo.srw
forward
global type w_con_bajas_periodo from w_int_con_empresa
end type
type dw_1 from u_datawindow within w_con_bajas_periodo
end type
type cb_3 from u_boton within w_con_bajas_periodo
end type
type dw_listado from datawindow within w_con_bajas_periodo
end type
type st_8 from statictext within w_con_bajas_periodo
end type
type em_fechadesde from u_em_campo within w_con_bajas_periodo
end type
type st_9 from statictext within w_con_bajas_periodo
end type
type gb_1 from groupbox within w_con_bajas_periodo
end type
type em_fechahasta from u_em_campo within w_con_bajas_periodo
end type
type pb_1 from upb_imprimir within w_con_bajas_periodo
end type
type pb_2 from upb_salir within w_con_bajas_periodo
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

global type w_con_bajas_periodo from w_int_con_empresa
int X=14
int Y=32
int Width=3621
int Height=2088
boolean TitleBar=true
string Title=""
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_1 gb_1
em_fechahasta em_fechahasta
pb_1 pb_1
pb_2 pb_2
end type
global w_con_bajas_periodo w_con_bajas_periodo

type variables


end variables

on w_con_bajas_periodo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.pb_2
end on

on w_con_bajas_periodo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.pb_1)
destroy(this.pb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Bajas de un período" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

em_fechadesde.text = String(Date("01-01-" + String(Year(Today()))),"dd-mm-yy")
em_fechahasta.text = String(Today(),"dd-mm-yy")


dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_bajas_periodo
int TabOrder=80
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_bajas_periodo
int Width=3451
boolean BringToTop=true
end type

type dw_1 from u_datawindow within w_con_bajas_periodo
int X=23
int Y=352
int Width=3520
int Height=1596
int TabOrder=0
string DataObject="dw_con_bajas_periodo"
BorderStyle BorderStyle=StyleRaised!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_3 from u_boton within w_con_bajas_periodo
event clicked pbm_bnclicked
int X=2766
int Y=184
int Width=274
int Height=88
int TabOrder=70
string Text="&Consulta"
end type

event clicked;dw_1.Retrieve(codigo_empresa,DateTime(date(em_fechadesde.text)),DateTime(date(em_fechahasta.text)))

end event

type dw_listado from datawindow within w_con_bajas_periodo
int X=133
int Y=228
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
boolean BringToTop=true
string DataObject="report_bajas_periodo"
boolean LiveScroll=true
end type

type st_8 from statictext within w_con_bajas_periodo
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

type em_fechadesde from u_em_campo within w_con_bajas_periodo
int X=279
int Y=212
int Width=288
int Height=80
int TabOrder=50
boolean BringToTop=true
Alignment Alignment=Center!
string Mask="dd-mm-yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_9 from statictext within w_con_bajas_periodo
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

type gb_1 from groupbox within w_con_bajas_periodo
int X=27
int Y=148
int Width=1088
int Height=172
int TabOrder=40
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

type em_fechahasta from u_em_campo within w_con_bajas_periodo
int X=800
int Y=212
int Width=297
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

type pb_1 from upb_imprimir within w_con_bajas_periodo
int X=3168
int Y=180
int Width=146
int Height=132
int TabOrder=30
boolean BringToTop=true
string PictureName="c:\bmp\print.bmp"
boolean OriginalSize=false
end type

event clicked;dw_listado.Retrieve(codigo_empresa,DateTime(date(em_fechadesde.text)),DateTime(date(em_fechahasta.text)))
f_imprimir_datawindow(dw_listado)
end event

type pb_2 from upb_salir within w_con_bajas_periodo
int X=3314
int Y=180
int TabOrder=20
boolean BringToTop=true
string PictureName="c:\bmp\salir1.bmp"
end type

