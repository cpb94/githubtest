$PBExportHeader$w_con_ped_alb_fac_cliente_fechas9.srw
$PBExportComments$Informe de facturación por fechas y grupos de clientes
forward
global type w_con_ped_alb_fac_cliente_fechas9 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas9
end type
type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas9
end type
type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas9
end type
type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas9
end type
type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas9
end type
type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas9
end type
type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas9
end type
type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas9
end type
type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas9
end type
type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas9
end type
type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas9
end type
type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas9
end type
type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas9
end type
type cbx_1 from checkbox within w_con_ped_alb_fac_cliente_fechas9
end type
end forward

global type w_con_ped_alb_fac_cliente_fechas9 from w_int_con_empresa
integer width = 3506
integer height = 1968
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_4 gb_4
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
gb_6 gb_6
cbx_1 cbx_1
end type
global w_con_ped_alb_fac_cliente_fechas9 w_con_ped_alb_fac_cliente_fechas9

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,total,donde
Datetime  fecha1,fecha2,fecha
dec{2}    bruto,cambio,precio,dto1,dto2,bruto1,bruto2,cantidad,metros,pm_cantidad,pm_metros
String    series,cliente,sel,serie,divisa,moneda = "7",clientes,tarifa,articulo,calidad,formato,cadena,grupo,pais
datastore datos

dw_detalle.Reset()
data.setredraw(false)

fecha1 = Datetime(Date(em_fechadesde.Text))
fecha2 = Datetime(Date(em_fechahasta.Text))

if uo_cliente.em_codigo.text <> "" then
	clientes = uo_cliente.em_codigo.text
else
	clientes = "%"
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2)



//if cbx_1.checked = true then
//	cadena = "No se incluyen muestras. Se incluyen los descuentos por Pronto Pago"
//	sel = "select cliente,serie,((importe / cambio) - impdtopp) bruto,divisa,ffactura,articulo,formato,precio,cantidad "+&
//			"from   venlifac "+&
//			"where  empresa = '"+codigo_empresa+"' "+&
//			"and    cliente like '"+clientes+"' "+&
//			"and    ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "
//else
//	cadena = "No se incluyen muestras. No se incluyen los descuentos por Pronto Pago"
//	sel = "select cliente,serie,(importe / cambio) bruto,divisa,ffactura,articulo,formato,precio,cantidad "+&
//			"from   venlifac "+&
//			"where  empresa = '"+codigo_empresa+"' "+&
//			"and    cliente like '"+clientes+"' "+&
//			"and    ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "
//end if

// David 27-11-01. Esto sustituye al bloque anterior comentado
if cbx_1.checked = true then
	cadena = "No se incluyen muestras. Se incluyen los descuentos por Pronto Pago"
	sel = "select cliente,serie,((importe / cambio) - impdtopp) bruto,divisa,ffactura,articulo,formato,precio,cantidad "+&
			"from   venlifac, art_codestadistico "+&
			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
			"and    art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			"and    venlifac.articulo = art_codestadistico.codigo "+&
			"and    art_codestadistico.G2 <> 'B' "+&
			"and    art_codestadistico.G2 <> 'Z' "+&
			"and    art_codestadistico.G2 <> 'N' "+&	
			"and    cliente like '"+clientes+"' "+&
			"and    ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "
else
	cadena = "No se incluyen muestras. No se incluyen los descuentos por Pronto Pago"
	sel = "select cliente,serie,(importe / cambio) bruto,divisa,ffactura,articulo,formato,precio,cantidad "+&
			"from   venlifac, art_codestadistico "+&
			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
			"and    art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			"and    venlifac.articulo = art_codestadistico.codigo "+&
			"and    art_codestadistico.G2 <> 'B' "+&
			"and    art_codestadistico.G2 <> 'Z' "+&
			"and    art_codestadistico.G2 <> 'N' "+&	
			"and    cliente like '"+clientes+"' "+&
			"and    ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "
end if
// Fin: David 27-11-01

		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Cargando Datos",indice,total)
	cliente  = datos.object.venlifac_cliente[indice]
	serie    = datos.object.venlifac_serie[indice]
	bruto    = datos.object.bruto[indice]
	divisa   = datos.object.venlifac_divisa[indice]
	fecha    = datos.object.venlifac_ffactura[indice]
	articulo = datos.object.venlifac_articulo[indice]
	formato  = datos.object.venlifac_formato[indice]
	precio   = datos.object.venlifac_precio[indice]
	cantidad = datos.object.venlifac_cantidad[indice]
	grupo    = f_grupo_venclientes(codigo_empresa,cliente)
	pais     = f_pais_genter(codigo_empresa,"C",cliente)
	if isnull(bruto) then bruto = 0
	choose case serie
		case "1"
			// Grandes cuentas Nacional
			if grupo = "2" then
				donde   = data.find("cliente = '"+cliente+"'",1,data.rowcount())
				if donde > 0 then
					data.object.importe[donde]   = data.object.importe[donde]+bruto
					data.object.cantidad[donde]  = data.object.cantidad[donde]+cantidad
					data.object.metros[donde]    = data.object.metros[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				else
					donde = data.insertrow(0)
					data.object.empresa[donde]           = codigo_empresa
					data.object.serie[donde]             = serie
					data.object.grupo[donde]             = grupo
					data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
					data.object.cliente[donde]           = cliente
					data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
					data.object.cadena[donde]            = cadena
					data.object.importe[donde]           = bruto
					data.object.cantidad[donde]          = cantidad
					data.object.pais[donde]              = pais
					data.object.metros[donde]            = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
					choose case cliente
						case "93"
							data.object.orden[donde]       = 101
						case "84"
							data.object.orden[donde]       = 102
						case else
							data.object.orden[donde]       = 103
					end choose
					data.object.moneda[donde]            = moneda
					data.object.fecha_ini[donde]         = fecha1
					data.object.fecha_fin[donde]         = fecha2
					data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
				end if
			else
				// Distribución Nacional
				donde   = data.find("grupo = '"+grupo+"'",1,data.rowcount())
				if donde > 0 then
					data.object.importe[donde]   = data.object.importe[donde]+bruto
					data.object.cantidad[donde]  = data.object.cantidad[donde]+cantidad
					data.object.metros[donde]    = data.object.metros[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				else
					donde = data.insertrow(0)
					data.object.empresa[donde]           = codigo_empresa
					data.object.serie[donde]             = serie
					data.object.grupo[donde]             = grupo
					data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
					data.object.cliente[donde]           = grupo
					data.object.nombre_cliente[donde]    = f_nombre_vengrupos(codigo_empresa,grupo)
					data.object.cadena[donde]            = cadena
					data.object.importe[donde]           = bruto
					data.object.cantidad[donde]          = cantidad
					data.object.pais[donde]              = pais
					data.object.metros[donde]            = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
					data.object.orden[donde]             = 0
					data.object.moneda[donde]            = moneda
					data.object.fecha_ini[donde]         = fecha1
					data.object.fecha_fin[donde]         = fecha2
					data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
				end if
			end if
		case "2"
			// Clientes Especiales : Studio One, Self, Barwolf
			if (grupo = "4" or grupo = "5" or grupo = "6") then
				donde   = data.find("grupo = '"+grupo+"'",1,data.rowcount())
				if donde > 0 then
					data.object.importe[donde]   = data.object.importe[donde]+bruto
					data.object.cantidad[donde]  = data.object.cantidad[donde]+cantidad
					data.object.metros[donde]    = data.object.metros[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				else
					donde = data.insertrow(0)
					data.object.empresa[donde]           = codigo_empresa
					data.object.serie[donde]             = serie
					data.object.grupo[donde]             = grupo
					data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
					data.object.cliente[donde]           = grupo
					data.object.nombre_cliente[donde]    = f_nombre_vengrupos(codigo_empresa,grupo)
					data.object.cadena[donde]            = cadena
					data.object.importe[donde]           = bruto
					data.object.cantidad[donde]          = cantidad
					data.object.pais[donde]              = pais
					data.object.metros[donde]            = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
					choose case cliente
						case "79"
							data.object.orden[donde]       = 201
						case "24"
							data.object.orden[donde]       = 202
						case "99"
							data.object.orden[donde]       = 203
						case else
							data.object.orden[donde]       = 204
					end choose
					data.object.moneda[donde]            = moneda
					data.object.fecha_ini[donde]         = fecha1
					data.object.fecha_fin[donde]         = fecha2
					data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
				end if
			else
				// Paises CEE
				donde   = data.find("pais = '"+pais+"'",1,data.rowcount())
				if donde > 0 then
					data.object.importe[donde]   = data.object.importe[donde]+bruto
					data.object.cantidad[donde]  = data.object.cantidad[donde]+cantidad
					data.object.metros[donde]    = data.object.metros[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				else
					donde = data.insertrow(0)
					data.object.empresa[donde]           = codigo_empresa
					data.object.serie[donde]             = serie
					data.object.grupo[donde]             = grupo
					data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
					data.object.cliente[donde]           = pais
					data.object.nombre_cliente[donde]    = f_nombre_pais(pais)
					data.object.cadena[donde]            = cadena
					data.object.importe[donde]           = bruto
					data.object.cantidad[donde]          = cantidad
					data.object.pais[donde]              = pais
					data.object.metros[donde]            = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
					data.object.orden[donde]             = 300
					data.object.moneda[donde]            = moneda
					data.object.fecha_ini[donde]         = fecha1
					data.object.fecha_fin[donde]         = fecha2
					data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
				end if
			end if
		case "3"
			// Paises NO CEE
			donde   = data.find("pais = '"+pais+"'",1,data.rowcount())
			if donde > 0 then
				data.object.importe[donde]   = data.object.importe[donde]+bruto
				data.object.cantidad[donde]  = data.object.cantidad[donde]+cantidad
				data.object.metros[donde]    = data.object.metros[donde]+f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
			else
				donde = data.insertrow(0)
				data.object.empresa[donde]           = codigo_empresa
				data.object.serie[donde]             = serie
				data.object.grupo[donde]             = grupo
				data.object.nombre_serie[donde]      = f_nombre_venseries(codigo_empresa,serie)
				data.object.cliente[donde]           = pais
				data.object.nombre_cliente[donde]    = f_nombre_pais(pais)
				data.object.cadena[donde]            = cadena
				data.object.importe[donde]           = bruto
				data.object.cantidad[donde]          = cantidad
				data.object.pais[donde]              = pais
				data.object.metros[donde]            = f_calculo_metros_cuadrados(codigo_empresa,articulo,cantidad)
				data.object.orden[donde]             = 400
				data.object.moneda[donde]            = moneda
				data.object.fecha_ini[donde]         = fecha1
				data.object.fecha_fin[donde]         = fecha2
				data.object.fecha_calculo[donde]     = string(fecha,"dd-mm-yy")
		end if
	end choose
next

total = data.rowcount()

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event close;call super::close;dw_detalle.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe Ventas por grupos de Clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
end event

on w_con_ped_alb_fac_cliente_fechas9.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_4=create gb_4
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.gb_6=create gb_6
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_series
this.Control[iCurrent+13]=this.gb_6
this.Control[iCurrent+14]=this.cbx_1
end on

on w_con_ped_alb_fac_cliente_fechas9.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.gb_6)
destroy(this.cbx_1)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_alb_fac_cliente_fechas9
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_alb_fac_cliente_fechas9
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_alb_fac_cliente_fechas9
integer x = 9
integer y = 8
integer width = 2560
integer height = 112
end type

type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas9
integer x = 3301
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas9
integer x = 2990
integer y = 332
integer width = 146
integer height = 112
integer taborder = 60
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_detalle)

end event

type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas9
integer x = 14
integer y = 480
integer width = 3378
integer height = 1224
string dataobject = "dw_con_ped_alb_fac_cliente_fechas2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas9
integer x = 27
integer y = 176
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

type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas9
integer x = 398
integer y = 176
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

type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas9
integer x = 2706
integer y = 332
integer width = 279
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;f_control(dw_detalle)
end event

type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas9
integer x = 2583
integer y = 116
integer width = 562
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas9
integer x = 9
integer y = 116
integer width = 690
integer height = 180
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

type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas9
event destroy ( )
integer x = 722
integer y = 176
integer width = 1829
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

type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas9
integer x = 704
integer y = 116
integer width = 1865
integer height = 180
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

type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas9
integer x = 343
integer y = 164
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

type uo_series from u_marca_lista within w_con_ped_alb_fac_cliente_fechas9
event destroy ( )
boolean visible = false
integer x = 690
integer y = 512
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas9
integer x = 2693
integer y = 292
integer width = 457
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

type cbx_1 from checkbox within w_con_ped_alb_fac_cliente_fechas9
integer x = 2619
integer y = 180
integer width = 498
integer height = 76
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
string text = " Incluir Dtos P.P."
boolean lefttext = true
end type

