$PBExportHeader$w_con_detalle_activos.srw
forward
global type w_con_detalle_activos from w_int_con_empresa
end type
type st_1 from statictext within w_con_detalle_activos
end type
type em_elemento from u_em_campo within w_con_detalle_activos
end type
type st_delemento from statictext within w_con_detalle_activos
end type
type dw_1 from u_datawindow within w_con_detalle_activos
end type
type cb_3 from u_boton within w_con_detalle_activos
end type
type dw_listado from datawindow within w_con_detalle_activos
end type
type pb_1 from upb_imprimir within w_con_detalle_activos
end type
type pb_2 from upb_salir within w_con_detalle_activos
end type
type gb_1 from groupbox within w_con_detalle_activos
end type
type rb_1 from radiobutton within w_con_detalle_activos
end type
type rb_2 from radiobutton within w_con_detalle_activos
end type
type rb_3 from radiobutton within w_con_detalle_activos
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

global type w_con_detalle_activos from w_int_con_empresa
int X=27
int Y=32
int Width=3602
int Height=2072
boolean TitleBar=true
string Title=""
st_1 st_1
em_elemento em_elemento
st_delemento st_delemento
dw_1 dw_1
cb_3 cb_3
dw_listado dw_listado
pb_1 pb_1
pb_2 pb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_con_detalle_activos w_con_detalle_activos

type variables


end variables

on w_con_detalle_activos.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_elemento=create em_elemento
this.st_delemento=create st_delemento
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_elemento
this.Control[iCurrent+3]=this.st_delemento
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.rb_3
end on

on w_con_detalle_activos.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_elemento)
destroy(this.st_delemento)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Detalle de Activos Fijos" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_detalle_activos
int TabOrder=60
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_detalle_activos
int Width=2757
boolean BringToTop=true
end type

type st_1 from statictext within w_con_detalle_activos
int X=37
int Y=204
int Width=325
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Elemento"
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

type em_elemento from u_em_campo within w_con_detalle_activos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
int X=361
int Y=200
int Width=393
int TabOrder=10
Alignment Alignment=Right!
string Mask="########"
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' and trim(this.text)<>'' then
	f_mensaje("Aviso","El elemento no existe.")
	em_elemento.SetFocus()
	return
Else
	st_delemento.text = cadena
End If
end event

type st_delemento from statictext within w_con_detalle_activos
int X=905
int Y=204
int Width=1129
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from u_datawindow within w_con_detalle_activos
int X=23
int Y=480
int Width=3483
int Height=1436
int TabOrder=0
string DataObject="dw_con_detalle_af"
BorderStyle BorderStyle=StyleRaised!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_3 from u_boton within w_con_detalle_activos
event clicked pbm_bnclicked
int X=2528
int Y=236
int Width=274
int Height=88
int TabOrder=50
string Text="&Consulta"
end type

event clicked;dw_1.SetFilter("")

IF trim(em_elemento.text)<>'' THEN
	dw_1.SetFilter("act_bienesdet_elemento = " + em_elemento.text )
	dw_1.Filter()
END IF

dw_1.SetRedraw(False)

dw_1.Retrieve(codigo_empresa)

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

type dw_listado from datawindow within w_con_detalle_activos
int X=133
int Y=228
int Width=494
int Height=360
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string DataObject="report_detalle_af"
boolean LiveScroll=true
end type

type pb_1 from upb_imprimir within w_con_detalle_activos
int X=2953
int Y=228
int Width=155
int Height=132
int TabOrder=20
boolean BringToTop=true
string PictureName="c:\bmp\print.bmp"
boolean OriginalSize=false
end type

event clicked;dw_listado.SetFilter("")

IF trim(em_elemento.text)<>'' THEN
	dw_listado.SetFilter("act_bienesdet_elemento = " + em_elemento.text )
	dw_listado.Filter()
END IF

dw_listado.SetRedraw(False)

dw_listado.Retrieve(codigo_empresa)

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

type pb_2 from upb_salir within w_con_detalle_activos
int X=3113
int Y=228
int TabOrder=30
boolean BringToTop=true
string PictureName="c:\bmp\salir1.bmp"
end type

type gb_1 from groupbox within w_con_detalle_activos
int X=242
int Y=300
int Width=1659
int Height=152
int TabOrder=50
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

type rb_1 from radiobutton within w_con_detalle_activos
int X=325
int Y=360
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

type rb_2 from radiobutton within w_con_detalle_activos
int X=827
int Y=360
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

type rb_3 from radiobutton within w_con_detalle_activos
int X=1371
int Y=360
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

