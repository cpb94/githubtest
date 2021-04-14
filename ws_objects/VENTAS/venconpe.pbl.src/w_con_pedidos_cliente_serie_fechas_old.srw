$PBExportHeader$w_con_pedidos_cliente_serie_fechas_old.srw
$PBExportComments$Pedidos pendientes por fecha
forward
global type w_con_pedidos_cliente_serie_fechas_old from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_cliente_serie_fechas_old
end type
type pb_2 from upb_imprimir within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fechadesde from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fechahasta from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type cb_1 from commandbutton within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_1 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_3 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type st_1 from statictext within w_con_pedidos_cliente_serie_fechas_old
end type
type cb_2 from commandbutton within w_con_pedidos_cliente_serie_fechas_old
end type
type rb_detalle from radiobutton within w_con_pedidos_cliente_serie_fechas_old
end type
type rb_resumen from radiobutton within w_con_pedidos_cliente_serie_fechas_old
end type
type cbx_valorado from checkbox within w_con_pedidos_cliente_serie_fechas_old
end type
type cbx_muestras from checkbox within w_con_pedidos_cliente_serie_fechas_old
end type
type cbx_sinfecha from checkbox within w_con_pedidos_cliente_serie_fechas_old
end type
type ddlb_tipopedido from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fecha_intr1 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fecha_intr2 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type st_2 from statictext within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_2 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type dw_detalle from datawindow within w_con_pedidos_cliente_serie_fechas_old
end type
type uo_series from u_marca_lista within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fecha_entrega1 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type em_fecha_entrega2 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
end type
type st_3 from statictext within w_con_pedidos_cliente_serie_fechas_old
end type
type ddlb_estado from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
end type
type ddlb_esta_fabricado from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
end type
type cbx_promo from checkbox within w_con_pedidos_cliente_serie_fechas_old
end type
type uo_familia from u_em_campo_2 within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_7 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_8 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_9 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_6 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
type dw_listado from datawindow within w_con_pedidos_cliente_serie_fechas_old
end type
type cbx_situacion from checkbox within w_con_pedidos_cliente_serie_fechas_old
end type
type hpb_estado from hprogressbar within w_con_pedidos_cliente_serie_fechas_old
end type
type st_situacion from statictext within w_con_pedidos_cliente_serie_fechas_old
end type
type gb_4 from groupbox within w_con_pedidos_cliente_serie_fechas_old
end type
end forward

global type w_con_pedidos_cliente_serie_fechas_old from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 3794
integer height = 3944
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
cb_2 cb_2
rb_detalle rb_detalle
rb_resumen rb_resumen
cbx_valorado cbx_valorado
cbx_muestras cbx_muestras
cbx_sinfecha cbx_sinfecha
ddlb_tipopedido ddlb_tipopedido
em_fecha_intr1 em_fecha_intr1
em_fecha_intr2 em_fecha_intr2
st_2 st_2
gb_2 gb_2
dw_detalle dw_detalle
uo_series uo_series
em_fecha_entrega1 em_fecha_entrega1
em_fecha_entrega2 em_fecha_entrega2
st_3 st_3
ddlb_estado ddlb_estado
ddlb_esta_fabricado ddlb_esta_fabricado
cbx_promo cbx_promo
uo_familia uo_familia
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
gb_6 gb_6
dw_listado dw_listado
cbx_situacion cbx_situacion
hpb_estado hpb_estado
st_situacion st_situacion
gb_4 gb_4
end type
global w_con_pedidos_cliente_serie_fechas_old w_con_pedidos_cliente_serie_fechas_old

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();long     i,indice_ser
Datetime fecha1,fecha2, fecha_intr1, fecha_intr2
String   series[1 to 20],cliente, filtro, tipopedido, filtro_bloq, filtro2

dw_listado.visible = true

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))
fecha_intr1 = Datetime(Date(String(em_fecha_intr1.Text)))
fecha_intr2 = Datetime(Date(String(em_fecha_intr2.Text)))

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

if ddlb_tipopedido.text = "TODOS" or ddlb_tipopedido.text = "" then
	tipopedido = "%"
end if
if ddlb_tipopedido.text = "DEPOSITO" then
	tipopedido = "S"
end if
if ddlb_tipopedido.text = "NORMAL" then
	tipopedido = "N"
end if

dw_listado.Retrieve(codigo_empresa, fecha1, fecha2, cliente, series, tipopedido)

/*
IF ddlb_estado.text = "BLOQUEADO" THEN
	filtro = " venliped_bloqueado = '1' " 
ELSEIF  ddlb_estado.text = "DISPONIBLE" THEN
	filtro = " venliped_bloqueado = '0' " 
ELSE 
	filtro = " 1 = 1 "
END IF
*/
IF ddlb_estado.text = "BLOQUEADO" THEN
	filtro = " venped_es_proforma = 'N' AND venliped_bloqueado = '1' " 
ELSEIF  ddlb_estado.text = "DISPONIBLE" THEN
	filtro = " venped_es_proforma = 'N' AND venliped_bloqueado = '0' " 
ELSEIF  ddlb_estado.text = "PROFORMA" THEN
	filtro = " venped_es_proforma = 'S' " 
ELSE 
	//filtro = " 1 = 1  "
	filtro = " venped_es_proforma = 'N' " 
END IF

IF ddlb_estado.text <> "BLOQUEADO" THEN
	IF not isnull(em_fecha_intr1.Text) AND em_fecha_intr2.Text <> '00-00-00' &
	AND em_fecha_intr1.Text <> "" AND em_fecha_intr1.Text <> '00-00-00' &
	AND not isnull(em_fecha_intr2.Text) AND em_fecha_intr2.Text <> "" THEN
		filtro_bloq = " venliped_fecha_intr >= "+String(fecha_intr1,"yyyy-mm-dd 00:00:00")+" AND venliped_fecha_intr <= "+String(fecha_intr2,"yyyy-mm-dd 23:59:59")+ " "
		IF ddlb_estado.text = "TODOS" THEN
			filtro = filtro + " AND ((" + filtro_bloq + ") OR venliped_bloqueado = '1') "
		ELSE
			filtro = filtro + " AND " +filtro_bloq
		END IF
	END IF
END IF

if cbx_sinfecha.checked then
	filtro = filtro + ' and isnull(fentrega) '//+' AND '+tipopedido
end if

if isnull(em_fecha_entrega1.Text) or isnull(em_fecha_entrega2.Text)  &
	or em_fecha_entrega1.Text = '00-00-00' or em_fecha_entrega2.Text = '00-00-00' &
	or em_fecha_entrega1.Text = '' or em_fecha_entrega2.Text = '' then
	filtro2 = ""
else
	filtro2 = " and fentrega >= "+string(Date(em_fecha_entrega1.text),"yyyy-mm-dd")+ &
				" and fentrega <= "+string(Date(em_fecha_entrega2.text),"yyyy-mm-dd")
end if

if uo_familia.em_codigo.text <> "" then
	filtro = filtro + " and articulos_familia = '" + uo_familia.em_codigo.text + "' "
end if

if not cbx_promo.checked then
	filtro = filtro + " and articulos_promocion = 'N' "
end if

dw_listado.SetRedraw(false)
dw_listado.SetFilter("")
dw_listado.SetFilter(filtro+filtro2)
dw_listado.Filter()
dw_listado.Groupcalc()
dw_listado.SetRedraw(true)
uo_series.visible = false
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Listado de Pedidos Pendientes"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
em_fecha_intr1.text = String(MDY(01,01,Year(Today())))
em_fecha_intr2.text = String(Today())

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")


ddlb_tipopedido.text = "TODOS"
ddlb_estado.text = "DISPONIBLE"
ddlb_esta_fabricado.text = "TODOS"
end event

on w_con_pedidos_cliente_serie_fechas_old.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.cbx_valorado=create cbx_valorado
this.cbx_muestras=create cbx_muestras
this.cbx_sinfecha=create cbx_sinfecha
this.ddlb_tipopedido=create ddlb_tipopedido
this.em_fecha_intr1=create em_fecha_intr1
this.em_fecha_intr2=create em_fecha_intr2
this.st_2=create st_2
this.gb_2=create gb_2
this.dw_detalle=create dw_detalle
this.uo_series=create uo_series
this.em_fecha_entrega1=create em_fecha_entrega1
this.em_fecha_entrega2=create em_fecha_entrega2
this.st_3=create st_3
this.ddlb_estado=create ddlb_estado
this.ddlb_esta_fabricado=create ddlb_esta_fabricado
this.cbx_promo=create cbx_promo
this.uo_familia=create uo_familia
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
this.gb_6=create gb_6
this.dw_listado=create dw_listado
this.cbx_situacion=create cbx_situacion
this.hpb_estado=create hpb_estado
this.st_situacion=create st_situacion
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.rb_detalle
this.Control[iCurrent+12]=this.rb_resumen
this.Control[iCurrent+13]=this.cbx_valorado
this.Control[iCurrent+14]=this.cbx_muestras
this.Control[iCurrent+15]=this.cbx_sinfecha
this.Control[iCurrent+16]=this.ddlb_tipopedido
this.Control[iCurrent+17]=this.em_fecha_intr1
this.Control[iCurrent+18]=this.em_fecha_intr2
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.dw_detalle
this.Control[iCurrent+22]=this.uo_series
this.Control[iCurrent+23]=this.em_fecha_entrega1
this.Control[iCurrent+24]=this.em_fecha_entrega2
this.Control[iCurrent+25]=this.st_3
this.Control[iCurrent+26]=this.ddlb_estado
this.Control[iCurrent+27]=this.ddlb_esta_fabricado
this.Control[iCurrent+28]=this.cbx_promo
this.Control[iCurrent+29]=this.uo_familia
this.Control[iCurrent+30]=this.gb_7
this.Control[iCurrent+31]=this.gb_8
this.Control[iCurrent+32]=this.gb_9
this.Control[iCurrent+33]=this.gb_6
this.Control[iCurrent+34]=this.dw_listado
this.Control[iCurrent+35]=this.cbx_situacion
this.Control[iCurrent+36]=this.hpb_estado
this.Control[iCurrent+37]=this.st_situacion
this.Control[iCurrent+38]=this.gb_4
end on

on w_con_pedidos_cliente_serie_fechas_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.cbx_valorado)
destroy(this.cbx_muestras)
destroy(this.cbx_sinfecha)
destroy(this.ddlb_tipopedido)
destroy(this.em_fecha_intr1)
destroy(this.em_fecha_intr2)
destroy(this.st_2)
destroy(this.gb_2)
destroy(this.dw_detalle)
destroy(this.uo_series)
destroy(this.em_fecha_entrega1)
destroy(this.em_fecha_entrega2)
destroy(this.st_3)
destroy(this.ddlb_estado)
destroy(this.ddlb_esta_fabricado)
destroy(this.cbx_promo)
destroy(this.uo_familia)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
destroy(this.gb_6)
destroy(this.dw_listado)
destroy(this.cbx_situacion)
destroy(this.hpb_estado)
destroy(this.st_situacion)
destroy(this.gb_4)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_cliente_serie_fechas_old
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_cliente_serie_fechas_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_cliente_serie_fechas_old
integer x = 32
integer y = 8
integer width = 3698
integer height = 76
end type

type pb_1 from upb_salir within w_con_pedidos_cliente_serie_fechas_old
integer x = 3575
integer y = 140
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
end type

type pb_2 from upb_imprimir within w_con_pedidos_cliente_serie_fechas_old
integer x = 3575
integer y = 316
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;
f_imprimir_datawindow(dw_listado)

end event

type em_fechadesde from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 46
integer y = 156
integer width = 247
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 334
integer y = 156
integer width = 247
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_pedidos_cliente_serie_fechas_old
integer x = 3278
integer y = 152
integer width = 283
integer height = 112
integer taborder = 150
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

type gb_1 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 32
integer y = 96
integer width = 567
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Pedido"
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_cliente_serie_fechas_old
event destroy ( )
integer x = 1742
integer y = 156
integer width = 846
integer taborder = 70
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

type gb_3 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1728
integer y = 96
integer width = 882
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

type st_1 from statictext within w_con_pedidos_cliente_serie_fechas_old
integer x = 293
integer y = 144
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

type cb_2 from commandbutton within w_con_pedidos_cliente_serie_fechas_old
integer x = 3278
integer y = 324
integer width = 283
integer height = 112
integer taborder = 140
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

type rb_detalle from radiobutton within w_con_pedidos_cliente_serie_fechas_old
integer x = 1307
integer y = 332
integer width = 265
integer height = 52
integer taborder = 90
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
	dw_detalle.modify("datawindow.header.2.height=100")
	
	dw_listado.modify("datawindow.detail.height=76")
	dw_listado.modify("datawindow.header.2.height=100")
	detalle = TRUE
end if

end event

type rb_resumen from radiobutton within w_con_pedidos_cliente_serie_fechas_old
integer x = 1307
integer y = 392
integer width = 329
integer height = 52
integer taborder = 100
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

type cbx_valorado from checkbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1705
integer y = 332
integer width = 306
integer height = 52
integer taborder = 110
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
boolean lefttext = true
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
	dw_detalle.modify("linea5.visible = 1")
	dw_detalle.modify("texto1.visible = 1")
	dw_detalle.modify("texto2.visible = 1")
	dw_detalle.modify("texto3.visible = 1")	
	dw_detalle.modify("texto4.visible = 1")
	dw_detalle.modify("texto5.visible = 1")
	dw_detalle.modify("texto6.visible = 1")
	dw_detalle.modify("texto7.visible = 1")
	dw_detalle.modify("pts.visible = 1")
	dw_detalle.modify("total_pts.visible = 1")

	
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
	
	dw_listado.modify("pts.visible = 1")
	dw_listado.modify("total_pts.visible = 1")
//	dw_detalle.modify("texto_fecha_ent.visible = 1")
	
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
	dw_detalle.modify("linea5.visible = 0")
	dw_detalle.modify("texto1.visible = 0")
	dw_detalle.modify("texto2.visible = 0")
	dw_detalle.modify("texto3.visible = 0")	
	dw_detalle.modify("texto4.visible = 0")
	dw_detalle.modify("texto5.visible = 0")
	dw_detalle.modify("texto6.visible = 0")
	dw_detalle.modify("texto7.visible = 0")
	
	dw_detalle.modify("pts.visible = 0")
	dw_detalle.modify("total_pts.visible = 0")
//	dw_detalle.modify("texto_fecha_ent.visible = 0")
	
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
	dw_listado.modify("pts.visible = 0")
	dw_listado.modify("total_pts.visible = 0")
	
	valorado = FALSE
end if

end event

type cbx_muestras from checkbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1687
integer y = 392
integer width = 325
integer height = 52
integer taborder = 120
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
boolean lefttext = true
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

type cbx_sinfecha from checkbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 2126
integer y = 384
integer width = 526
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sin Fecha Entrega"
boolean lefttext = true
end type

type ddlb_tipopedido from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 2779
integer y = 332
integer width = 379
integer height = 316
integer taborder = 130
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"TODOS","DEPOSITO","NORMAL"}
borderstyle borderstyle = stylelowered!
end type

type em_fecha_intr1 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 617
integer y = 156
integer width = 247
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fecha_intr2 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 905
integer y = 156
integer width = 238
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_pedidos_cliente_serie_fechas_old
integer x = 864
integer y = 152
integer width = 46
integer height = 68
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

type gb_2 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 603
integer y = 96
integer width = 558
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Introducción"
end type

type dw_detalle from datawindow within w_con_pedidos_cliente_serie_fechas_old
boolean visible = false
integer x = 4055
integer y = 1060
integer width = 923
integer height = 1868
string dataobject = "dw_con_pedidos_cliente_serie_fechas"
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

type uo_series from u_marca_lista within w_con_pedidos_cliente_serie_fechas_old
event destroy ( )
boolean visible = false
integer x = 2208
integer y = 436
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type em_fecha_entrega1 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 1179
integer y = 156
integer width = 247
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fecha_entrega2 from u_em_campo within w_con_pedidos_cliente_serie_fechas_old
integer x = 1467
integer y = 156
integer width = 238
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_3 from statictext within w_con_pedidos_cliente_serie_fechas_old
integer x = 1422
integer y = 148
integer width = 46
integer height = 68
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

type ddlb_estado from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 2656
integer y = 164
integer width = 567
integer height = 512
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"TODOS","DISPONIBLE","BLOQUEADO","PROFORMA"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_esta_fabricado from dropdownlistbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 681
integer y = 344
integer width = 535
integer height = 276
integer taborder = 90
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"S","N","TODOS"}
borderstyle borderstyle = stylelowered!
end type

type cbx_promo from checkbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 2094
integer y = 324
integer width = 558
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Promoción"
boolean checked = true
boolean lefttext = true
end type

type uo_familia from u_em_campo_2 within w_con_pedidos_cliente_serie_fechas_old
event destroy ( )
integer x = 69
integer y = 332
integer width = 544
integer taborder = 80
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_7 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1166
integer y = 96
integer width = 558
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Entrega"
end type

type gb_8 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 2610
integer y = 96
integer width = 649
integer height = 164
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estado del pedido"
end type

type gb_9 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 27
integer y = 276
integer width = 608
integer height = 244
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Familia"
end type

type gb_6 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 635
integer y = 276
integer width = 613
integer height = 244
integer taborder = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fabricado"
end type

type dw_listado from datawindow within w_con_pedidos_cliente_serie_fechas_old
integer x = 14
integer y = 532
integer width = 3753
integer height = 3232
string dataobject = "report_con_pedidos_cliente_serie_fechas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

event retrieveend;String articulo, situacion
Double pedidos, stock
Long i, esta
Dec anyo, pedido, linea

if cbx_situacion.checked = true then
	dw_listado.visible = false
	dw_listado.setredraw(false)
	hpb_estado.visible = true
	st_situacion.visible = true
	hpb_estado.position = 0
	hpb_estado.Maxposition = dw_listado.rowcount()
	For i = 1 to dw_listado.rowcount()
		situacion = ""
		articulo = dw_listado.object.articulos_codigo[i]
		anyo = dw_listado.object.anyo[i]
		pedido = dw_listado.object.pedido[i]
		linea = dw_listado.object.linea[i]
		if not isnull(articulo) and articulo <> "" then
			pedidos = 0
			stock = 0			
			esta = 0
			
			SELECT COUNT(*) INTO :esta
			FROM orden_carga_linea 
			INNER JOIN orden_carga ON orden_carga.empresa = orden_carga_linea.empresa AND orden_carga.anyo = orden_carga_linea.anyo AND orden_carga.codigo = orden_carga_linea.codigo 
			WHERE orden_carga.finalizada = 'S' 
			AND orden_carga_linea.empresa = :codigo_empresa 
			AND orden_carga_linea.venliped_anyo = :anyo
			AND orden_carga_linea.venliped_pedido = :pedido
			AND orden_carga_linea.venliped_linea = :linea;
			 if esta > 0 then
				situacion = "P"
			else
				esta = 0
				SELECT COUNT(*) INTO :esta
				FROM orden_carga_linea 
				INNER JOIN orden_carga ON orden_carga.empresa = orden_carga_linea.empresa AND orden_carga.anyo = orden_carga_linea.anyo AND orden_carga.codigo = orden_carga_linea.codigo 
				WHERE orden_carga.finalizada = 'N' 
				AND orden_carga_linea.empresa = :codigo_empresa 
				AND orden_carga_linea.venliped_anyo = :anyo
				AND orden_carga_linea.venliped_pedido = :pedido
				AND orden_carga_linea.venliped_linea = :linea;
				if esta > 0 then
					situacion = "" 
				else
					SELECT sum(v1.cantidad) INTO :pedidos
					FROM venliped v1 
					INNER JOIN venped vp1 ON v1.empresa = vp1.empresa AND v1.anyo = vp1.anyo AND v1.pedido = vp1.pedido 
					WHERE v1.empresa = :codigo_empresa AND v1.articulo = :articulo AND vp1.es_proforma = 'N';
					
					SELECT sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads) INTO :stock
					FROM almacenmovimientos 
					WHERE almacenmovimientos.empresa = :codigo_empresa AND almacenmovimientos.articulo = :articulo;
					
					if pedidos > stock then
						situacion = "F"
					end if
				end if
			end if			
		end if	
		dw_listado.object.situacion[i] = situacion
		hpb_estado.StepIt ()
	Next
	dw_listado.visible = true
	hpb_estado.visible = false
	st_situacion.visible = false
	dw_listado.setredraw(true)
end if
end event

type cbx_situacion from checkbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1317
integer y = 452
integer width = 695
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Situación Líneas"
boolean lefttext = true
boolean righttoleft = true
end type

type hpb_estado from hprogressbar within w_con_pedidos_cliente_serie_fechas_old
boolean visible = false
integer x = 27
integer y = 532
integer width = 3739
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

type st_situacion from statictext within w_con_pedidos_cliente_serie_fechas_old
boolean visible = false
integer x = 494
integer y = 708
integer width = 1202
integer height = 256
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 553648127
string text = "POR FAVOR ESPERE. OBTENIENDO SITUACIÓN"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_con_pedidos_cliente_serie_fechas_old
integer x = 1248
integer y = 276
integer width = 2007
integer height = 244
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

