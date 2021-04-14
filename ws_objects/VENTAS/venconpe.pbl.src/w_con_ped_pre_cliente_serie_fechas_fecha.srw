$PBExportHeader$w_con_ped_pre_cliente_serie_fechas_fecha.srw
$PBExportComments$Listado de preparación por fechas
forward
global type w_con_ped_pre_cliente_serie_fechas_fecha from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type pb_2 from upb_imprimir within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type dw_listado from datawindow within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type em_fechadesde from u_em_campo within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type em_fechahasta from u_em_campo within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type cb_1 from commandbutton within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type gb_5 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type gb_4 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type gb_1 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type uo_cliente from u_em_campo_2 within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type gb_3 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type st_1 from statictext within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type cb_2 from commandbutton within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type rb_detalle from radiobutton within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type rb_resumen from radiobutton within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type cbx_valorado from checkbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type cbx_muestras from checkbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type gb_6 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type dw_detalle from datawindow within w_con_ped_pre_cliente_serie_fechas_fecha
end type
type uo_series from u_marca_lista within w_con_ped_pre_cliente_serie_fechas_fecha
end type
end forward

global type w_con_ped_pre_cliente_serie_fechas_fecha from w_int_con_empresa
integer x = 5
integer y = 16
integer width = 3909
integer height = 2192
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
cb_2 cb_2
rb_detalle rb_detalle
rb_resumen rb_resumen
cbx_valorado cbx_valorado
cbx_muestras cbx_muestras
gb_6 gb_6
dw_detalle dw_detalle
uo_series uo_series
end type
global w_con_ped_pre_cliente_serie_fechas_fecha w_con_ped_pre_cliente_serie_fechas_fecha

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();long     i,indice_ser
Datetime fecha1,fecha2
String   series[1 to 20],cliente

dw_detalle.Reset()
uo_series.visible = false

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

indice_ser = 1
for i=1 to uo_series.dw_marca.rowcount()
	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
		series[indice_ser] = uo_series.dw_marca.getitemstring(i,"codigo")
		indice_ser ++
	end if	
next

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if
dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Listado de Preparación de Pedidos Pendientes entre Fechas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
end event

on w_con_ped_pre_cliente_serie_fechas_fecha.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.cbx_valorado=create cbx_valorado
this.cbx_muestras=create cbx_muestras
this.gb_6=create gb_6
this.dw_detalle=create dw_detalle
this.uo_series=create uo_series
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.rb_detalle
this.Control[iCurrent+15]=this.rb_resumen
this.Control[iCurrent+16]=this.cbx_valorado
this.Control[iCurrent+17]=this.cbx_muestras
this.Control[iCurrent+18]=this.gb_6
this.Control[iCurrent+19]=this.dw_detalle
this.Control[iCurrent+20]=this.uo_series
end on

on w_con_ped_pre_cliente_serie_fechas_fecha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.cbx_valorado)
destroy(this.cbx_muestras)
destroy(this.gb_6)
destroy(this.dw_detalle)
destroy(this.uo_series)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 82
integer y = 1372
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_pre_cliente_serie_fechas_fecha
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 3657
integer y = 28
integer width = 119
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 3154
integer y = 156
integer width = 128
integer height = 112
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
end type

event clicked;long     i,indice_ser
Datetime fecha1,fecha2
String   series[1 to 20],cliente

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

indice_ser = 1
for i=1 to uo_series.dw_marca.rowcount()
	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
		series[indice_ser] = uo_series.dw_marca.getitemstring(i,"codigo")
		indice_ser ++
	end if	
next

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if
dw_listado.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_ped_pre_cliente_serie_fechas_fecha
boolean visible = false
integer x = 2555
integer y = 24
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_pre_cli_serie_fechas_fech"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 23
integer y = 168
integer width = 270
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 329
integer y = 168
integer width = 270
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2857
integer y = 156
integer width = 288
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control()

end event

type gb_5 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2569
integer y = 116
integer width = 270
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 1893
integer y = 116
integer width = 677
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones"
end type

type gb_1 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 9
integer y = 116
integer width = 613
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type uo_cliente from u_em_campo_2 within w_con_ped_pre_cliente_serie_fechas_fecha
event destroy ( )
integer x = 635
integer y = 168
integer width = 1234
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_3 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 622
integer y = 116
integer width = 1271
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type st_1 from statictext within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 288
integer y = 156
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2583
integer y = 156
integer width = 242
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Series"
end type

event clicked;uo_series.visible = not(uo_series.visible)
end event

type rb_detalle from radiobutton within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 1902
integer y = 168
integer width = 265
integer height = 52
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle"
boolean checked = true
end type

event clicked;
if not detalle then
	dw_detalle.modify("datawindow.detail.height=76")
	dw_detalle.modify("datawindow.header.2.height=68")
	
	dw_listado.modify("datawindow.detail.height=76")
	dw_listado.modify("datawindow.header.2.height=68")
	detalle = TRUE
end if

end event

type rb_resumen from radiobutton within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 1902
integer y = 216
integer width = 329
integer height = 52
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
end type

event clicked;
if detalle then
	dw_detalle.modify("datawindow.detail.height=0")
	dw_detalle.modify("datawindow.header.2.height=0")
	
	dw_listado.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.header.2.height=0")

	detalle = FALSE
	if not valorado then
		cbx_valorado.triggerevent(clicked!)
		cbx_valorado.checked = true
	end if
end if

end event

type cbx_valorado from checkbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2226
integer y = 168
integer width = 306
integer height = 52
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Valorado"
boolean checked = true
end type

event clicked;if not valorado then
	dw_detalle.modify("s_precio.visible = 1")
	dw_detalle.modify("importe.visible = 1")
	dw_detalle.modify("total1.visible = 1")
	dw_detalle.modify("total2.visible = 1")
	dw_detalle.modify("total3.visible = 1")
	dw_detalle.modify("monedas_abreviado.visible = 1")
	dw_detalle.modify("monedas_abreviado1.visible = 1")
	dw_detalle.modify("monedas_abreviado2.visible = 1")
	dw_detalle.modify("descuento.visible = 1")	
	dw_detalle.modify("descuento2.visible = 1")		
	dw_detalle.modify("linea1.visible = 1")
	dw_detalle.modify("linea2.visible = 1")
	dw_detalle.modify("linea3.visible = 1")	
	dw_detalle.modify("linea4.visible = 1")
	dw_detalle.modify("texto1.visible = 1")
	dw_detalle.modify("texto2.visible = 1")
	dw_detalle.modify("texto3.visible = 1")	
	dw_detalle.modify("texto4.visible = 1")
	dw_detalle.modify("texto5.visible = 1")
	dw_detalle.modify("texto6.visible = 1")
	dw_detalle.modify("texto7.visible = 1")
	
	dw_listado.modify("s_precio.visible = 1")
	dw_listado.modify("importe.visible = 1")
	dw_listado.modify("total1.visible = 1")
	dw_listado.modify("total2.visible = 1")
	dw_listado.modify("total3.visible = 1")	
	dw_listado.modify("monedas_abreviado.visible = 1")
	dw_listado.modify("monedas_abreviado1.visible = 1")
	dw_listado.modify("monedas_abreviado2.visible = 1")
	dw_listado.modify("descuento.visible = 1")	
	dw_listado.modify("descuento2.visible = 1")			
	dw_listado.modify("linea1.visible = 1")
	dw_listado.modify("linea2.visible = 1")
	dw_listado.modify("linea3.visible = 1")	
	dw_listado.modify("linea4.visible = 1")
	dw_listado.modify("texto1.visible = 1")
	dw_listado.modify("texto2.visible = 1")
	dw_listado.modify("texto3.visible = 1")	
	dw_listado.modify("texto4.visible = 1")
	dw_listado.modify("texto5.visible = 1")
	dw_listado.modify("texto6.visible = 1")
	dw_listado.modify("texto7.visible = 1")
	
	valorado = TRUE
else
	dw_detalle.modify("s_precio.visible = 0")
	dw_detalle.modify("importe.visible = 0")
	dw_detalle.modify("total1.visible = 0")
	dw_detalle.modify("total2.visible = 0")
	dw_detalle.modify("total3.visible = 0")
	dw_detalle.modify("monedas_abreviado.visible = 0")	
	dw_detalle.modify("monedas_abreviado1.visible = 0")
	dw_detalle.modify("monedas_abreviado2.visible = 0")
	dw_detalle.modify("descuento.visible = 0")	
	dw_detalle.modify("descuento2.visible = 0")			
	dw_detalle.modify("linea1.visible = 0")
	dw_detalle.modify("linea2.visible = 0")
	dw_detalle.modify("linea3.visible = 0")	
	dw_detalle.modify("linea4.visible = 0")
	dw_detalle.modify("texto1.visible = 0")
	dw_detalle.modify("texto2.visible = 0")
	dw_detalle.modify("texto3.visible = 0")	
	dw_detalle.modify("texto4.visible = 0")
	dw_detalle.modify("texto5.visible = 0")
	dw_detalle.modify("texto6.visible = 0")
	dw_detalle.modify("texto7.visible = 0")
	
	dw_listado.modify("s_precio.visible = 0")
	dw_listado.modify("importe.visible = 0")
	dw_listado.modify("total1.visible = 0")
	dw_listado.modify("total2.visible = 0")
	dw_listado.modify("total3.visible = 0")
	dw_listado.modify("monedas_abreviado.visible = 0")	
	dw_listado.modify("monedas_abreviado1.visible = 0")
	dw_listado.modify("monedas_abreviado2.visible = 0")
	dw_listado.modify("descuento.visible = 0")	
	dw_listado.modify("descuento2.visible = 0")				
	dw_listado.modify("linea1.visible = 0")
	dw_listado.modify("linea2.visible = 0")
	dw_listado.modify("linea3.visible = 0")	
	dw_listado.modify("linea4.visible = 0")
	dw_listado.modify("texto1.visible = 0")
	dw_listado.modify("texto2.visible = 0")
	dw_listado.modify("texto3.visible = 0")	
	dw_listado.modify("texto4.visible = 0")
	dw_listado.modify("texto5.visible = 0")
	dw_listado.modify("texto6.visible = 0")
	dw_listado.modify("texto7.visible = 0")
	
	valorado = FALSE
end if

end event

type cbx_muestras from checkbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2226
integer y = 216
integer width = 325
integer height = 52
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Muestras"
end type

event clicked;if muestras then
	dw_detalle.setfilter("")
	dw_detalle.filter()	
	dw_detalle.groupcalc()
	dw_listado.setfilter("")
	dw_listado.filter()
else
	dw_detalle.setfilter("clase = 'M'")
	dw_detalle.filter()		
	dw_detalle.groupcalc()
	dw_listado.setfilter("clase = 'M'")
	dw_listado.filter()	
end if

muestras = not(muestras)
end event

type gb_6 from groupbox within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 2839
integer y = 116
integer width = 457
integer height = 164
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_detalle from datawindow within w_con_ped_pre_cliente_serie_fechas_fecha
integer x = 5
integer y = 272
integer width = 3785
integer height = 1680
string dataobject = "dw_con_ped_pre_cliente_serie_fechas_fech"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type uo_series from u_marca_lista within w_con_ped_pre_cliente_serie_fechas_fecha
event destroy ( )
boolean visible = false
integer x = 1477
integer y = 280
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

