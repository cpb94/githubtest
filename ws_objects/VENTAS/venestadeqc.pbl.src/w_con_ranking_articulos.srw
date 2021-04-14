$PBExportHeader$w_con_ranking_articulos.srw
forward
global type w_con_ranking_articulos from w_int_con_empresa
end type
type gb_100 from groupbox within w_con_ranking_articulos
end type
type gb_2 from groupbox within w_con_ranking_articulos
end type
type pb_1 from upb_salir within w_con_ranking_articulos
end type
type pb_2 from upb_imprimir within w_con_ranking_articulos
end type
type dw_detalle from datawindow within w_con_ranking_articulos
end type
type dw_listado from datawindow within w_con_ranking_articulos
end type
type em_fechadesde from u_em_campo within w_con_ranking_articulos
end type
type em_fechahasta from u_em_campo within w_con_ranking_articulos
end type
type cb_1 from commandbutton within w_con_ranking_articulos
end type
type gb_5 from groupbox within w_con_ranking_articulos
end type
type gb_1 from groupbox within w_con_ranking_articulos
end type
type st_1 from statictext within w_con_ranking_articulos
end type
type cb_2 from commandbutton within w_con_ranking_articulos
end type
type gb_6 from groupbox within w_con_ranking_articulos
end type
type rb_1 from radiobutton within w_con_ranking_articulos
end type
type rb_2 from radiobutton within w_con_ranking_articulos
end type
type uo_series from u_marca_lista within w_con_ranking_articulos
end type
type uo_pais from u_em_campo_2 within w_con_ranking_articulos
end type
type uo_provincia from u_em_campo_2 within w_con_ranking_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_ranking_articulos
end type
type gb_3 from groupbox within w_con_ranking_articulos
end type
type uo_agente from u_em_campo_2 within w_con_ranking_articulos
end type
type gb_4 from groupbox within w_con_ranking_articulos
end type
type gb_7 from groupbox within w_con_ranking_articulos
end type
type gb_9 from groupbox within w_con_ranking_articulos
end type
type uo_calidad from u_em_campo_2 within w_con_ranking_articulos
end type
type gb_11 from groupbox within w_con_ranking_articulos
end type
type ddlb_producto from dropdownlistbox within w_con_ranking_articulos
end type
end forward

global type w_con_ranking_articulos from w_int_con_empresa
integer width = 3520
integer height = 2020
gb_100 gb_100
gb_2 gb_2
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_5 gb_5
gb_1 gb_1
st_1 st_1
cb_2 cb_2
gb_6 gb_6
rb_1 rb_1
rb_2 rb_2
uo_series uo_series
uo_pais uo_pais
uo_provincia uo_provincia
uo_cliente uo_cliente
gb_3 gb_3
uo_agente uo_agente
gb_4 gb_4
gb_7 gb_7
gb_9 gb_9
uo_calidad uo_calidad
gb_11 gb_11
ddlb_producto ddlb_producto
end type
global w_con_ranking_articulos w_con_ranking_articulos

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,total,donde,vtotalpts,r,vtotalcant,reg
dec       por,porac,p_m, v_stock	
Datetime  fecha1,fecha2
dec       bruto,cambio,precio,total_fac,cantidad,importe
String    series,cliente,sel,serie,divisa,moneda = "1",clientes,tarifa,articulo,calidad,formato,nom_art,nom_for
string    paises,provincias,agentes,calidades
datastore datos

dw_detalle.Reset()
dw_listado.Reset()
data.setredraw(false)
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

if uo_cliente.em_codigo.text <> "" then
	clientes = uo_cliente.em_codigo.text
else
	clientes = "%"
end if

if uo_calidad.em_codigo.text <> "" then
	calidades = "calidad like '"+uo_calidad.em_codigo.text+"' "
else
	calidades = "(calidad like '%' or calidad is null) "
end if

if uo_pais.em_codigo.text <> "" then
	paises = uo_pais.em_codigo.text
else
	paises = "%"
end if
if uo_provincia.em_codigo.text <> "" then
	provincias = uo_provincia.em_codigo.text
else
	provincias = "%"
end if
if uo_agente.em_codigo.text <> "" then
	agentes = uo_agente.em_codigo.text
else
	agentes = "%"
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)

//Cargamos los datos de las facturas
if (ddlb_producto.text = 'Todo') or (ddlb_producto.text = '') or isnull(ddlb_producto.text) then
	sel = "select venlifac.articulo, venlifac.formato, venlifac.cliente, venlifac.serie, venlifac.importe, venlifac.cambio, venlifac.divisa, venlifac.cantidad, venlifac.calidad "+&
			"from   venlifac, art_codestadistico "+&
			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
			"and    art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			"and    venlifac.articulo =  art_codestadistico.codigo  "+&
			"and    venlifac.cliente like '"+clientes+"' "+&
			"and    venlifac.serie in ("+series+") "+&
			"and    venlifac.pais like '"+paises+"' "+&
			"and    venlifac.provincia like '"+provincias+"' "+&
			"and    venlifac.agente1 like '"+agentes+"' "+&
			"and    "+calidades+&
			"and    venlifac.ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "
			
//	sel = "select venlifac.articulo, venlifac.formato, venlifac.cliente, venlifac.serie, venlifac.importe, venlifac.cambio, venlifac.divisa, venlifac.cantidad, venlifac.calidad "+&
//			"from   venlifac "+&
//			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
//			"and    venlifac.cliente like '"+clientes+"' "+&
//			"and    venlifac.serie in ("+series+") "+&
//			"and    venlifac.pais like '"+paises+"' "+&
//			"and    venlifac.provincia like '"+provincias+"' "+&
//			"and    venlifac.agente1 like '"+agentes+"' "+&
//			"and    "+calidades+&
//			"and    venlifac.ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "

elseif ddlb_producto.text = 'Acabado' then
	sel = "select venlifac.articulo, venlifac.formato, venlifac.cliente, venlifac.serie, venlifac.importe, venlifac.cambio, venlifac.divisa, venlifac.cantidad, venlifac.calidad "+&
			"from   venlifac, art_codestadistico "+&
			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
			"and    art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			"and    venlifac.articulo =  art_codestadistico.codigo  "+&
			"and 		art_codestadistico.G2 <> 'N'  "+&
			"and 		art_codestadistico.G2 <> 'B'  "+&
			"and 		art_codestadistico.G2 <> 'Z'  "+&
			"and    venlifac.cliente like '"+clientes+"' "+&
			"and    venlifac.serie in ("+series+") "+&
			"and    venlifac.pais like '"+paises+"' "+&
			"and    venlifac.provincia like '"+provincias+"' "+&
			"and    venlifac.agente1 like '"+agentes+"' "+&
			"and    "+calidades+&
			"and    venlifac.ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "

elseif ddlb_producto.text = 'Intermedio' then
	sel = "select venlifac.articulo, venlifac.formato, venlifac.cliente, venlifac.serie, venlifac.importe, venlifac.cambio, venlifac.divisa, venlifac.cantidad, venlifac.calidad "+&
			"from   venlifac, art_codestadistico "+&
			"where  venlifac.empresa = '"+codigo_empresa+"' "+&
			"and    art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			"and    venlifac.articulo =  art_codestadistico.codigo  "+&
			"and 		((art_codestadistico.G2 = 'N') or (art_codestadistico.G2 = 'B') or (art_codestadistico.G2 = 'Z'))"+&
			"and    venlifac.cliente like '"+clientes+"' "+&
			"and    venlifac.serie in ("+series+") "+&
			"and    venlifac.pais like '"+paises+"' "+&
			"and    venlifac.provincia like '"+provincias+"' "+&
			"and    venlifac.agente1 like '"+agentes+"' "+&
			"and    "+calidades+&
			"and    venlifac.ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "			
end if
		
//datos = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()
total_fac = 0
reg = 0
if total = 0 then
	messagebox("Atención","No hay datos")
end if

for indice = 1 to total
	f_mensaje_proceso("Cargando Datos",indice,total)
	cliente  = datos.object.venlifac_cliente[indice]
	serie    = datos.object.venlifac_serie[indice]

	bruto    = datos.object.venlifac_importe[indice] / datos.object.venlifac_cambio[indice] 	
	divisa   = datos.object.venlifac_divisa[indice]
	cantidad = datos.object.venlifac_cantidad[indice]
	formato  = datos.object.venlifac_formato[indice]
	articulo = datos.object.venlifac_articulo[indice]
	cambio   = datos.object.venlifac_cambio[indice]
	calidad  = datos.object.venlifac_calidad[indice]
	total_fac = total_fac + bruto
	
	v_stock	= f_stock_articulo_sin_a(codigo_empresa, articulo, fecha2)
	
	if isnull(bruto) then bruto = 0
	donde   = data.find("articulo = '"+articulo+"'",1,data.rowcount())
	if donde > 0 then
		data.object.importe_facturas[donde]   = data.object.importe_facturas[donde] + bruto
		data.object.cantidad_piezas[donde]    = data.object.cantidad_piezas[donde]  + cantidad
	else
		donde = data.insertrow(0)
		reg = reg +1
		nom_art = f_nombre_articulo(codigo_empresa,articulo)
		if nom_art = "" or isnull(nom_art) then
			nom_art = "OTROS"
		end if
		nom_for = f_nombre_formato(codigo_empresa,formato) 
		if nom_for = "" or isnull(nom_for) then
			nom_for = "OTROS"
		end if
		data.object.empresa[donde]           = codigo_empresa
		data.object.nombre_articulo[donde]   = nom_art
		data.object.nombre_formato[donde]    = nom_for
		data.object.serie[donde]             = serie
		data.object.cliente[donde]           = cliente
		data.object.articulo[donde]          = articulo
		data.object.cantidad_piezas[donde]   = cantidad
		data.object.importe_facturas[donde]  = bruto
		data.object.divisa[donde]            = divisa
		data.object.cambio[donde]            = cambio
		data.object.fechad[donde]            = fecha1
		data.object.fechah[donde]            = fecha2
		data.object.stock[donde]             = v_stock
end if
next

IF reg <> 0 Then
	For r = 1 To reg
		f_mensaje_proceso("Realizando Cálculos",r,reg)
		vtotalpts  = data.GetItemNumber(r,"importe_facturas")
		vtotalcant = data.GetItemNumber(r,"cantidad_piezas")
		if total_fac = 0 then
			por = 0
		else
			por =  vtotalpts * 100 / total_fac
		end if
		if vtotalcant = 0 then
			p_m = 0
		else
			p_m =  vtotalpts / vtotalcant
		end if
		data.SetItem(r,"porcentaje",por)
		data.SetItem(r,"pm",p_m)
   Next
END IF

data.SetRedraw(TRUE)

if rb_1.checked = true then 
   data.SetSort("cantidad_piezas D")
else
	data.SetSort("importe_facturas D")
end if

data.sort()

porac = 0
IF reg <> 0 Then
	For r = 1 To reg
		f_mensaje_proceso("Realizando Cálculos",r,reg)
		por =  data.GetItemNumber(r,"porcentaje")
		porac = porac + por
		data.SetItem(r,"porcac",porac)
	Next
END IF

destroy datos
data.groupcalc()
data.setredraw(true)
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Ranking de Artículos"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")

ddlb_producto.text = 'Todo'
end event

on w_con_ranking_articulos.create
int iCurrent
call super::create
this.gb_100=create gb_100
this.gb_2=create gb_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_5=create gb_5
this.gb_1=create gb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.gb_6=create gb_6
this.rb_1=create rb_1
this.rb_2=create rb_2
this.uo_series=create uo_series
this.uo_pais=create uo_pais
this.uo_provincia=create uo_provincia
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.uo_agente=create uo_agente
this.gb_4=create gb_4
this.gb_7=create gb_7
this.gb_9=create gb_9
this.uo_calidad=create uo_calidad
this.gb_11=create gb_11
this.ddlb_producto=create ddlb_producto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_100
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.gb_6
this.Control[iCurrent+15]=this.rb_1
this.Control[iCurrent+16]=this.rb_2
this.Control[iCurrent+17]=this.uo_series
this.Control[iCurrent+18]=this.uo_pais
this.Control[iCurrent+19]=this.uo_provincia
this.Control[iCurrent+20]=this.uo_cliente
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.uo_agente
this.Control[iCurrent+23]=this.gb_4
this.Control[iCurrent+24]=this.gb_7
this.Control[iCurrent+25]=this.gb_9
this.Control[iCurrent+26]=this.uo_calidad
this.Control[iCurrent+27]=this.gb_11
this.Control[iCurrent+28]=this.ddlb_producto
end on

on w_con_ranking_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_100)
destroy(this.gb_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.gb_6)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.uo_series)
destroy(this.uo_pais)
destroy(this.uo_provincia)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.uo_agente)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.gb_9)
destroy(this.uo_calidad)
destroy(this.gb_11)
destroy(this.ddlb_producto)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ranking_articulos
integer x = 69
integer y = 1492
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ranking_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ranking_articulos
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type gb_100 from groupbox within w_con_ranking_articulos
integer x = 2875
integer y = 120
integer width = 425
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Prod."
end type

type gb_2 from groupbox within w_con_ranking_articulos
integer x = 2254
integer y = 120
integer width = 617
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordenado por"
end type

type pb_1 from upb_salir within w_con_ranking_articulos
integer x = 3237
integer y = 4
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ranking_articulos
integer x = 3200
integer y = 324
integer width = 128
integer height = 112
integer taborder = 130
boolean originalsize = false
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type dw_detalle from datawindow within w_con_ranking_articulos
integer y = 476
integer width = 3415
integer height = 1284
string dataobject = "dw_con_ranking_articulos"
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

type dw_listado from datawindow within w_con_ranking_articulos
boolean visible = false
integer x = 2528
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ranking_articulos"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_ranking_articulos
integer x = 27
integer y = 168
integer width = 293
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ranking_articulos
integer x = 384
integer y = 168
integer width = 306
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ranking_articulos
integer x = 2903
integer y = 324
integer width = 288
integer height = 112
integer taborder = 120
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

type gb_5 from groupbox within w_con_ranking_articulos
integer x = 9
integer y = 284
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

type gb_1 from groupbox within w_con_ranking_articulos
integer x = 9
integer y = 120
integer width = 699
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

type st_1 from statictext within w_con_ranking_articulos
integer x = 329
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

type cb_2 from commandbutton within w_con_ranking_articulos
integer x = 23
integer y = 324
integer width = 242
integer height = 112
integer taborder = 70
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

type gb_6 from groupbox within w_con_ranking_articulos
integer x = 2889
integer y = 284
integer width = 453
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

type rb_1 from radiobutton within w_con_ranking_articulos
integer x = 2263
integer y = 172
integer width = 311
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
long backcolor = 79741120
string text = "Cantidad"
end type

event clicked;if rb_2.checked then
	rb_2.checked = false
end if
end event

type rb_2 from radiobutton within w_con_ranking_articulos
integer x = 2565
integer y = 172
integer width = 288
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
string text = "Importe"
boolean checked = true
end type

event clicked;if rb_1.checked then
	rb_1.checked = false
end if
end event

type uo_series from u_marca_lista within w_con_ranking_articulos
event destroy ( )
boolean visible = false
integer x = 14
integer y = 456
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type uo_pais from u_em_campo_2 within w_con_ranking_articulos
event destroy ( )
integer x = 320
integer y = 336
integer width = 576
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_pais.em_campo.text = f_nombre_pais(uo_pais.em_codigo.text)



end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION PAISES"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = "" 	
valor_empresa = FALSE
end event

type uo_provincia from u_em_campo_2 within w_con_ranking_articulos
event destroy ( )
integer x = 951
integer y = 336
integer width = 859
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_provincia.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_provincia.em_campo.text = f_nombre_provincia(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)


end event

event getfocus;call super::getfocus;valor_empresa  = FALSE
ue_titulo    	= "AYUDA SELECCION DE PROVINCIAS"
ue_datawindow	= "dw_ayuda_provincias"
ue_filtro      = "pais = '" + uo_pais.em_codigo.text + "' "
end event

type uo_cliente from u_em_campo_2 within w_con_ranking_articulos
event destroy ( )
integer x = 745
integer y = 168
integer width = 1138
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

type gb_3 from groupbox within w_con_ranking_articulos
integer x = 718
integer y = 120
integer width = 1189
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

type uo_agente from u_em_campo_2 within w_con_ranking_articulos
event destroy ( )
integer x = 1888
integer y = 336
integer width = 859
integer taborder = 110
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)



end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venagentes"
ue_titulo     =  "AYUDA SELECCION AGENTES"
ue_filtro     =  ""
end event

type gb_4 from groupbox within w_con_ranking_articulos
integer x = 302
integer y = 284
integer width = 617
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "País"
end type

type gb_7 from groupbox within w_con_ranking_articulos
integer x = 928
integer y = 284
integer width = 914
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Provincia"
end type

type gb_9 from groupbox within w_con_ranking_articulos
integer x = 1861
integer y = 284
integer width = 914
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type uo_calidad from u_em_campo_2 within w_con_ranking_articulos
event destroy ( )
integer x = 1943
integer y = 168
integer width = 279
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_calidad.em_campo.text = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)


end event

event getfocus;call super::getfocus;valor_empresa  = TRUE
ue_titulo    	= "AYUDA SELECCION DE CALIDADES"
ue_datawindow	= "dw_ayuda_calidades"
ue_filtro      = ""
end event

type gb_11 from groupbox within w_con_ranking_articulos
integer x = 1920
integer y = 120
integer width = 320
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calidad"
end type

type ddlb_producto from dropdownlistbox within w_con_ranking_articulos
integer x = 2903
integer y = 180
integer width = 389
integer height = 364
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todo","Intermedio","Acabado"}
borderstyle borderstyle = stylelowered!
end type

