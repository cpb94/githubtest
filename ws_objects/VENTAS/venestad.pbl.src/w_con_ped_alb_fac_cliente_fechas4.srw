$PBExportHeader$w_con_ped_alb_fac_cliente_fechas4.srw
$PBExportComments$Listado de albaranes por cliente
forward
global type w_con_ped_alb_fac_cliente_fechas4 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas4
end type
type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas4
end type
type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas4
end type
type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas4
end type
type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_5 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas4
end type
type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas4
end type
type cb_2 from commandbutton within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
type cbx_1 from checkbox within w_con_ped_alb_fac_cliente_fechas4
end type
type cbx_2 from checkbox within w_con_ped_alb_fac_cliente_fechas4
end type
type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas4
end type
type cbx_3 from checkbox within w_con_ped_alb_fac_cliente_fechas4
end type
type cbx_4 from checkbox within w_con_ped_alb_fac_cliente_fechas4
end type
type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas4
end type
type cbx_resumen from checkbox within w_con_ped_alb_fac_cliente_fechas4
end type
type gb_7 from groupbox within w_con_ped_alb_fac_cliente_fechas4
end type
end forward

global type w_con_ped_alb_fac_cliente_fechas4 from w_int_con_empresa
integer width = 3831
integer height = 3316
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
cb_2 cb_2
gb_6 gb_6
cbx_1 cbx_1
cbx_2 cbx_2
dw_detalle dw_detalle
cbx_3 cbx_3
cbx_4 cbx_4
dw_listado dw_listado
cbx_resumen cbx_resumen
gb_7 gb_7
end type
global w_con_ped_alb_fac_cliente_fechas4 w_con_ped_alb_fac_cliente_fechas4

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,total,donde,ejer
dec{2}    iva_ventas
Datetime  fecha1,fecha2,falb
dec       bruto,cambio,precio,dto1,dto2,bruto1,bruto2,fact, metros
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,articulo,calidad,albaran,cadena
datastore datos

data.setredraw(false)

data.Reset()

uo_series.visible = false

fecha1 = Datetime(Date(em_fechadesde.Text))
fecha2 = Datetime(Date(em_fechahasta.Text))

series = ""
for i=1 to uo_series.dw_marca.rowcount()
	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
		if series = "" then
			series = "'"+uo_series.dw_marca.getitemstring(i,"codigo")+"'"
		else
			series = series+",'"+uo_series.dw_marca.getitemstring(i,"codigo")+"'"
		end if
	end if	
next
if series = '' then
	messagebox("Aviso","Debe Marcar un serie, al menos")
else
	if uo_cliente.em_codigo.text <> "" then
		clientes = uo_cliente.em_codigo.text
	else
		clientes = "%"
	end if
	
	if cbx_3.checked = true then
		if cbx_4.checked = true then
			cadena = "No se incluyen las muestras. Se incluyen los Dtos. P.P. Se incluye el IVA"
		else
			cadena = "No se incluyen las muestras. Se incluyen los Dtos. P.P. IVA no incluido"
		end if
	else
		if cbx_4.checked = true then
			cadena = "No se incluyen las muestras. No se incluyen los Dtos. P.P. Se incluye el IVA"	
		else
			cadena = "No se incluyen las muestras. No se incluyen los Dtos. P.P. IVA no incluido"
		end if
	end if
	
	if cbx_1.checked = true then
		if cbx_3.checked = true then
			sel = "select venlialb.cliente,venlialb.serie, venlialb.albaran, venlialb.falbaran,sum(importe-impdtopp) bruto, venlialb.divisa, venlialb.iva, sum (formatos.ancho * formatos.largo * cantidad / 10000 ) metros "+&
					"from   venlialb, formatos "+&
					"where  venlialb.empresa = '"+codigo_empresa+"' "+&
					"and 	  venlialb.empresa = formatos.empresa "+&
					"and 	  venlialb.formato = formatos.codigo "+&
					"and    venlialb.cliente like '"+clientes+"' "+&
					"and    venlialb.serie in ("+series+") "+&
					"and    venlialb.falbaran between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
					"and    importe <> 0 "+&
					"and 	  ( ( albaran_deposito = 'N' ) or ( albaran_deposito is null ) or ( albaran_deposito = '' )) "+&
					"group  by venlialb.cliente,venlialb.serie,venlialb.albaran,venlialb.falbaran,venlialb.divisa,venlialb.iva"
			
		else
			sel = "select venlialb.cliente,venlialb.serie,venlialb.albaran,venlialb.falbaran,sum(importe) bruto, venlialb.divisa, venlialb.iva, sum (formatos.ancho * formatos.largo * cantidad / 10000 ) metros "+&
					"from   venlialb, formatos "+&
					"where  venlialb.empresa = '"+codigo_empresa+"' "+&
					"and 	  venlialb.empresa = formatos.empresa "+&
					"and 	  venlialb.formato = formatos.codigo "+&
					"and    venlialb.cliente like '"+clientes+"' "+&
					"and    venlialb.serie in ("+series+") "+&
					"and    venlialb.falbaran between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
					"and    importe <> 0 "+&
					"and 	  ( ( albaran_deposito = 'N' ) or ( albaran_deposito is null ) or ( albaran_deposito = '' )) "+&
					"group  by venlialb.cliente,venlialb.serie,venlialb.albaran,venlialb.falbaran,venlialb.divisa, venlialb.iva"
		end if
				
	//	datos = f_cargar_cursor(sel)	
		f_cargar_cursor_nuevo(sel, datos)
		
		total = datos.rowcount()
		
		for indice = 1 to total
			f_mensaje_proceso("Cargando Albaranes",indice,total)
			cliente = datos.object.venlialb_cliente[indice]
			serie   = datos.object.venlialb_serie[indice]
			bruto   = datos.object.bruto[indice]
			divisa  = datos.object.venlialb_divisa[indice]
			cambio  = f_cambio_moneda(divisa)						
			albaran = string(datos.object.venlialb_albaran[indice],"####")
			falb    = datos.object.venlialb_falbaran[indice]
			ejer    = year(date(falb))
			iva_ventas = datos.object.venlialb_iva[indice]
			metros  = datos.object.metros[indice] 
			if isnull(metros) then metros = 0
			if isnull(bruto) then bruto = 0
			bruto   = bruto / cambio
			donde   = data.find("albaran = '"+albaran+"'",1,data.rowcount())
			if donde > 0 then
				data.object.importe_albaranes[donde]   = data.object.importe_albaranes[donde] + bruto
				data.object.metros[donde]   				= data.object.metros[donde] + metros
				if cbx_4.checked = true then
					data.object.importe_iva[donde]         = data.object.importe_iva[donde] + ((bruto * iva_ventas) / 100)
				else
					data.object.importe_iva[donde]         = 0
				end if
			else
				donde = data.insertrow(0)
				data.object.empresa[donde]           = codigo_empresa
				data.object.serie[donde]             = serie
				data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
				data.object.cliente[donde]           = cliente
				data.object.albaran[donde]           = albaran
				data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
				data.object.importe_albaranes[donde] = bruto
				if cbx_4.checked = true then
					data.object.importe_iva[donde]    = (bruto * iva_ventas) / 100
				else
					data.object.importe_iva[donde]    = 0
				end if
				data.object.metros[donde]   			 = metros
				data.object.moneda[donde]            = moneda
				data.object.fecha_ini[donde]         = fecha1
				data.object.fecha_fin[donde]         = fecha2
				data.object.f_albaran[donde]         = falb
				data.object.nombre_fp[donde]         = f_nombre_carforpag(codigo_empresa,f_codpago_venalb(codigo_empresa,ejer,dec(albaran)))
				data.object.estado[donde]            = "   "
				data.object.cadena[donde]            = cadena
			end if
		next
		
		destroy datos
	end if
	
	if cbx_2.checked = true then
		//Cargamos los datos de las facturas
		if cbx_3.checked = true then
			sel = "select venlifac.cliente, venlifac.serie, venlifac.albaran, venlifac.falbaran, venlifac.factura,sum((importe-impdtopp) / cambio) bruto, venlifac.divisa, venlifac.iva, sum (formatos.ancho * formatos.largo * cantidad / 10000 ) metros  "+&
					"from   venlifac, formatos "+&
					"where  venlifac.empresa = '"+codigo_empresa+"' "+&
					"and 	  venlifac.empresa = formatos.empresa "+&
					"and 	  venlifac.formato = formatos.codigo "+&
					"and    venlifac.cliente like '"+clientes+"' "+&
					"and    venlifac.serie in ("+series+") "+&
					"and    venlifac.falbaran between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
					"and    importe <> 0"+&
					"and 	  ( ( factura_deposito = 'N' ) or ( factura_deposito is null ) or ( factura_deposito = '' )) "+&
					"group  by venlifac.cliente, venlifac.serie, venlifac.albaran, venlifac.falbaran,venlifac.factura, venlifac.divisa,cambio, venlifac.iva"
		else
			sel = "select venlifac.cliente, venlifac.serie, venlifac.albaran, venlifac.falbaran, venlifac.factura,sum(importe / cambio) bruto, venlifac.divisa, venlifac.iva, sum (formatos.ancho * formatos.largo * cantidad / 10000 ) metros  "+&
					"from   venlifac, formatos "+&
					"where  venlifac.empresa = '"+codigo_empresa+"' "+&
					"and 	  venlifac.empresa = formatos.empresa "+&
					"and 	  venlifac.formato = formatos.codigo "+&
					"and    venlifac.cliente like '"+clientes+"' "+&
					"and    venlifac.serie in ("+series+") "+&
					"and    venlifac.falbaran between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
					"and    importe <> 0"+&
					"and 	  ( ( factura_deposito = 'N' ) or ( factura_deposito is null ) or ( factura_deposito = '' )) "+&
					"group  by venlifac.cliente, venlifac.serie, venlifac.albaran, venlifac.falbaran, venlifac.factura, venlifac.divisa,cambio, venlifac.iva"
		end if			
	//	datos = f_cargar_cursor(sel)		
		f_cargar_cursor_nuevo(sel, datos)
		
		total = datos.rowcount()
		
		for indice = 1 to total
			f_mensaje_proceso("Cargando Facturas",indice,total)
			cliente 	= datos.object.venlifac_cliente[indice]
			serie   	= datos.object.venlifac_serie[indice]
			bruto   	= datos.object.bruto[indice]
			divisa  	= datos.object.venlifac_divisa[indice]
			albaran 	= string(datos.object.venlifac_albaran[indice],"####")
			falb    	= datos.object.venlifac_falbaran[indice]
			ejer    	= year(date(falb))
			fact    	= datos.object.venlifac_factura[indice]
			iva_ventas = datos.object.venlifac_iva[indice]
			metros 	= datos.object.metros[indice]
			//cambio  = datos.object.cambio[indice]
			if isnull(bruto) then bruto = 0
			//bruto   = bruto * cambio
			if isnull(metros) then metros = 0
			donde   = data.find("albaran = '"+albaran+"'",1,data.rowcount())
			if donde > 0 then
				data.object.importe_albaranes[donde]   	= data.object. importe_albaranes[donde] + bruto //MODIIFICADO PORQUE NO FUNCIONABA EL FACTURADO 04-2015
				data.object.metros[donde]   				= data.object.metros[donde] + metros
				if cbx_4.checked = true then
					data.object.importe_iva[donde]      = data.object.importe_iva[donde] + ((bruto*iva_ventas)/100)
				else
					data.object.importe_iva[donde]      = 0
				end if
			else
				donde = data.insertrow(0)
				data.object.empresa[donde]           = codigo_empresa
				data.object.serie[donde]             = serie
				data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
				data.object.cliente[donde]           = cliente
				data.object.albaran[donde]           = albaran
				data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
				data.object.importe_albaranes[donde] = bruto
				data.object.moneda[donde]            = moneda
				data.object.fecha_ini[donde]         = fecha1
				data.object.fecha_fin[donde]         = fecha2
				data.object.f_albaran[donde]         = falb
				data.object.nombre_fp[donde]         = f_nombre_carforpag(codigo_empresa,f_codpago_venfac(codigo_empresa,ejer,fact))
				data.object.estado[donde]            = "FAC"
				data.object.cadena[donde]            = cadena
				data.object.metros[donde]   			 = metros
				if cbx_4.checked = true then
					data.object.importe_iva[donde]       = (bruto*iva_ventas)/100
				else
					data.object.importe_iva[donde]       = 0
				end if
			end if
		next
		
		destroy datos
	end if
	
	//Calculamos Pedidos pendientes
	
	dec pedidos_pendientes
	
	select sum(total_neto/ cambio)
	into:pedidos_pendientes 
	from venped 
	where empresa = :codigo_empresa 
	and fpedido <= :fecha2;
	
	if isnull(pedidos_pendientes) then
		pedidos_pendientes = 0
	end if
	
	data.object.t_pedidos_pendientes.text = string(pedidos_pendientes,"###,###,###,##0")

	//Calculamos Pedidos de hoy
	data.object.t_pedidos_hoy.text = string(f_pedidos_de_hoy(codigo_empresa),"###,###,###,##0")

	//Calculamos el valor de stock en el muelle
	data.object.t_valor_stock_muelle.text = string(f_valor_stock_muelle(codigo_empresa),"###,###,###,##0")

	
	data.sort()
	data.setredraw(true)
end if
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Albaranes por Cliente (Sin consumo Depósito) "
This.title=istr_parametros.s_titulo_ventana
//em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
cbx_3.checked = false
cbx_4.checked = false
cbx_1.checked = true
cbx_2.checked = true

uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")

long li_x, il_nummarcas



il_nummarcas = uo_series.dw_marca.RowCount()
IF il_nummarcas = 0 THEN  Return

FOR li_x = 1 TO il_nummarcas
		uo_series.dw_marca.setitem(li_x,"marca","S")
NEXT

end event

on w_con_ped_alb_fac_cliente_fechas4.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.cb_2=create cb_2
this.gb_6=create gb_6
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.dw_detalle=create dw_detalle
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.dw_listado=create dw_listado
this.cbx_resumen=create cbx_resumen
this.gb_7=create gb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.uo_series
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.gb_6
this.Control[iCurrent+16]=this.cbx_1
this.Control[iCurrent+17]=this.cbx_2
this.Control[iCurrent+18]=this.dw_detalle
this.Control[iCurrent+19]=this.cbx_3
this.Control[iCurrent+20]=this.cbx_4
this.Control[iCurrent+21]=this.dw_listado
this.Control[iCurrent+22]=this.cbx_resumen
this.Control[iCurrent+23]=this.gb_7
end on

on w_con_ped_alb_fac_cliente_fechas4.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.cb_2)
destroy(this.gb_6)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.dw_detalle)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.dw_listado)
destroy(this.cbx_resumen)
destroy(this.gb_7)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_alb_fac_cliente_fechas4
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_alb_fac_cliente_fechas4
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_alb_fac_cliente_fechas4
integer y = 8
integer width = 3762
integer height = 92
end type

type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas4
integer x = 3593
integer y = 156
integer width = 128
integer height = 112
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas4
integer x = 3456
integer y = 156
integer width = 128
integer height = 112
integer taborder = 100
boolean originalsize = false
end type

event clicked;//f_control(dw_listado)
f_imprimir_datawindow(dw_detalle)

end event

type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas4
integer x = 27
integer y = 168
integer width = 302
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas4
integer x = 398
integer y = 168
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas4
integer x = 3159
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

event clicked; f_control(dw_detalle)

end event

type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 2313
integer y = 280
integer width = 1417
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Dtos.P.P. e IVA"
end type

type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 302
integer y = 280
integer width = 1243
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estado"
end type

type gb_5 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 14
integer y = 280
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

type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 9
integer y = 116
integer width = 690
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

type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas4
event destroy ( )
integer x = 722
integer y = 168
integer width = 2391
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

type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 704
integer y = 116
integer width = 2427
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

type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas4
integer x = 343
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

type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas4
event destroy ( )
boolean visible = false
integer x = 18
integer y = 444
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type cb_2 from commandbutton within w_con_ped_alb_fac_cliente_fechas4
integer x = 27
integer y = 320
integer width = 242
integer height = 112
integer taborder = 40
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

type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 3141
integer y = 116
integer width = 585
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

type cbx_1 from checkbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 352
integer y = 344
integer width = 773
integer height = 76
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
string text = "Pendientes de Facturar"
end type

type cbx_2 from checkbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 1097
integer y = 344
integer width = 389
integer height = 76
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
string text = "Facturados"
end type

type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas4
integer x = 5
integer y = 464
integer width = 3739
integer height = 2612
string dataobject = "dw_con_ped_alb_fac_cliente_fechas4"
boolean vscrollbar = true
end type

type cbx_3 from checkbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 2359
integer y = 344
integer width = 608
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Incluir Dtos. P.P."
end type

type cbx_4 from checkbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 3113
integer y = 344
integer width = 489
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Incluir IVA"
end type

type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas4
boolean visible = false
integer x = 2624
integer y = 20
integer width = 155
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas4"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_resumen from checkbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 1591
integer y = 340
integer width = 613
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subtotal por cliente"
end type

event clicked;if this.checked then
	dw_detalle.modify("DataWindow.Detail.height=0")
	dw_detalle.modify("DataWindow.Header.2.height=72")
else
	dw_detalle.modify("DataWindow.Detail.height=84")
	dw_detalle.modify("DataWindow.Header.2.height=0")
end if
end event

type gb_7 from groupbox within w_con_ped_alb_fac_cliente_fechas4
integer x = 1545
integer y = 280
integer width = 768
integer height = 164
integer taborder = 50
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

