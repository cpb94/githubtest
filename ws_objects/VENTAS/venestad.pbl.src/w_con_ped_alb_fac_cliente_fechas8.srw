$PBExportHeader$w_con_ped_alb_fac_cliente_fechas8.srw
$PBExportComments$Informe de rotaciones
forward
global type w_con_ped_alb_fac_cliente_fechas8 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas8
end type
type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas8
end type
type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas8
end type
type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas8
end type
type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas8
end type
type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas8
end type
type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type uo_articulo from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type uo_calidad from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_9 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type uo_serie from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_10 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
type rb_1 from radiobutton within w_con_ped_alb_fac_cliente_fechas8
end type
type rb_2 from radiobutton within w_con_ped_alb_fac_cliente_fechas8
end type
type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
end type
type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas8
end type
end forward

global type w_con_ped_alb_fac_cliente_fechas8 from w_int_con_empresa
integer width = 3694
integer height = 1820
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
uo_articulo uo_articulo
gb_3 gb_3
st_1 st_1
gb_6 gb_6
uo_calidad uo_calidad
gb_9 gb_9
uo_serie uo_serie
gb_10 gb_10
rb_1 rb_1
rb_2 rb_2
uo_cliente uo_cliente
gb_4 gb_4
end type
global w_con_ped_alb_fac_cliente_fechas8 w_con_ped_alb_fac_cliente_fechas8

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      indice,total,donde,indice_x,total_x
Datetime  fecha1,fecha2
dec{2}    cantidad,stock,stock_reservado,stock_preparado
String    calidad,sel,sel0,articulo,articulos,calidades,formato,series,codigo,format,filtro, cliente

datastore datos,datos0

dw_detalle.Reset()
dw_listado.Reset()
data.setredraw(false)

fecha1 = Datetime(Date(em_fechadesde.Text))
fecha2 = Datetime(Date(em_fechahasta.Text))

if uo_articulo.em_codigo.text <> "" then
	articulos = uo_articulo.em_codigo.text
else
	articulos = "%"
end if

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

if uo_calidad.em_codigo.text <> "" then
	calidades = "calidad like '"+uo_calidad.em_codigo.text+"' "
else
	calidades = "(calidad like '%' or calidad is null) "
end if
if uo_serie.em_codigo.text <> "" then
	series = uo_serie.em_codigo.text
else
	series = "%"
end if


if rb_1.checked then filtro = ""
if rb_2.checked then filtro = "and control_stock = 'S'"

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,articulos)
//Cargamos los datos de los articulos
sel0 = "select codigo,formato "+&
		 "from   articulos "+&
		 "where  empresa = '"+codigo_empresa+"' "+&
		 "and    cliente like '"+cliente+"' "+&
		 "and    codigo like '"+articulos+"' "+&
		 filtro

//datos0 = f_cargar_cursor(sel0)		
f_cargar_cursor_nuevo(sel0, datos0)
total_x = datos0.rowcount()
if total_x = 0 then
	messagebox("Atención","No hay datos")
	destroy datos0
	return
end if
for indice_x = 1 to total_x
	f_mensaje_proceso("Cargando Datos",indice_x,total_x)
	codigo    = datos0.object.codigo[indice_x]
	format    = datos0.object.formato[indice_x]
	
	//Cargamos los datos de las facturas
	sel = "select cantidad,calidad,formato,articulo "+&
			"from   venlifac "+&
			"where  empresa = '"+codigo_empresa+"' "+&
			"and    articulo = '"+codigo+"' "+&
			"and    serie like '"+series+"' "+&
			"and    ffactura between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
			"and    "+calidades
		
//	datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)
	total = datos.rowcount()
	if total = 0 then
		donde = data.insertrow(0)
		data.object.empresa[donde]            = codigo_empresa
		data.object.articulo[donde]           = codigo
		data.object.nombre_articulo[donde]    = f_nombre_articulo(codigo_empresa,codigo)
		data.object.formato[donde]            = format
		data.object.nombre_formato[donde]     = f_nombre_formato(codigo_empresa,format)
		data.object.fecha_ini[donde]          = fecha1
		data.object.fecha_fin[donde]          = fecha2
		data.object.cantidad_facturas[donde]  = 0
		data.object.stock[donde]              = f_stock_articulo_calidad(codigo_empresa,codigo,"1") + f_stock_articulo_calidad(codigo_empresa,codigo,"2")
	else
		for indice = 1 to total
			articulo    = datos.object.articulo[indice]
			cantidad    = datos.object.cantidad[indice]
			calidad     = datos.object.calidad[indice]
			formato     = datos.object.formato[indice]
			
			donde   = data.find("articulo = '"+articulo+"'",1,data.rowcount())
			if donde > 0 then
				data.object.cantidad_facturas[donde]  = data.object.cantidad_facturas[donde] + cantidad
			else
				donde = data.insertrow(0)
				data.object.empresa[donde]            = codigo_empresa
				data.object.articulo[donde]           = articulo
				data.object.nombre_articulo[donde]    = f_nombre_articulo(codigo_empresa,articulo)
				data.object.formato[donde]            = formato
				data.object.nombre_formato[donde]     = f_nombre_formato(codigo_empresa,formato)
				data.object.fecha_ini[donde]          = fecha1
				data.object.fecha_fin[donde]          = fecha2
				data.object.cantidad_facturas[donde]  = cantidad
				data.object.stock[donde]              = f_stock_articulo_calidad(codigo_empresa,articulo,calidad)
			end if
		next
		
	end if
next
total = data.rowcount()
for indice = 1 to total
	f_mensaje_proceso("Realizando Cálculos",indice,total)
	articulo = data.GetItemstring(indice,"articulo")
	cantidad = data.GetItemNumber(indice,"cantidad_facturas") / 3
	data.object.cantidad_facturas[indice]  = cantidad
	stock    = data.GetItemNumber(indice,"stock")
	stock_reservado = f_reservado_articulo_calidad(codigo_empresa,articulo,calidad)
	stock_preparado = f_preparado_articulo_calidad(codigo_empresa,articulo,calidad)
	stock = stock - stock_reservado - stock_preparado
	data.object.stock[indice]              = stock
	if cantidad <> 0 then
		data.object.rotacion[indice]  = stock / cantidad
	else
		data.object.rotacion[indice] = -1
	end if
next

destroy datos0
destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Rotaciones"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
end event

on w_con_ped_alb_fac_cliente_fechas8.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_articulo=create uo_articulo
this.gb_3=create gb_3
this.st_1=create st_1
this.gb_6=create gb_6
this.uo_calidad=create uo_calidad
this.gb_9=create gb_9
this.uo_serie=create uo_serie
this.gb_10=create gb_10
this.rb_1=create rb_1
this.rb_2=create rb_2
this.uo_cliente=create uo_cliente
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_articulo
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.gb_6
this.Control[iCurrent+14]=this.uo_calidad
this.Control[iCurrent+15]=this.gb_9
this.Control[iCurrent+16]=this.uo_serie
this.Control[iCurrent+17]=this.gb_10
this.Control[iCurrent+18]=this.rb_1
this.Control[iCurrent+19]=this.rb_2
this.Control[iCurrent+20]=this.uo_cliente
this.Control[iCurrent+21]=this.gb_4
end on

on w_con_ped_alb_fac_cliente_fechas8.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_articulo)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.gb_6)
destroy(this.uo_calidad)
destroy(this.gb_9)
destroy(this.uo_serie)
destroy(this.gb_10)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.uo_cliente)
destroy(this.gb_4)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ped_alb_fac_cliente_fechas8
integer x = 73
integer y = 1404
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ped_alb_fac_cliente_fechas8
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ped_alb_fac_cliente_fechas8
integer x = 9
integer y = 4
integer width = 3314
integer height = 112
end type

type pb_1 from upb_salir within w_con_ped_alb_fac_cliente_fechas8
integer x = 3483
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_ped_alb_fac_cliente_fechas8
integer x = 3291
integer y = 164
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type dw_detalle from datawindow within w_con_ped_alb_fac_cliente_fechas8
integer x = 18
integer y = 460
integer width = 3570
integer height = 1112
string dataobject = "dw_con_ped_alb_fac_cliente_fechas8"
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

type dw_listado from datawindow within w_con_ped_alb_fac_cliente_fechas8
boolean visible = false
integer x = 2610
integer y = 160
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas8"
boolean livescroll = true
end type

type em_fechadesde from u_em_campo within w_con_ped_alb_fac_cliente_fechas8
integer x = 27
integer y = 168
integer width = 302
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ped_alb_fac_cliente_fechas8
integer x = 398
integer y = 168
integer width = 279
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;string   dia,mes,anyo
datetime fecha
integer  mes_inicial

dia = string(day(date(em_fechahasta.text)),"##")
mes_inicial = month(date(em_fechahasta.text))-3

if mes_inicial <= 0 then
	mes  = string(mes_inicial + 12,"##")
	anyo = string(year(date(em_fechahasta.text))-1,"####")
else
	mes  = string(mes_inicial,"##")
	anyo = string(year(date(em_fechahasta.text)),"####")
end if
fecha = datetime(date(dia+"/"+mes+"/"+anyo))
em_fechadesde.text = String(fecha,"dd-mm-yy")
end event

type cb_1 from commandbutton within w_con_ped_alb_fac_cliente_fechas8
integer x = 2994
integer y = 164
integer width = 288
integer height = 104
integer taborder = 70
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

type gb_2 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 2587
integer y = 280
integer width = 1001
integer height = 164
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Opciones de artículos"
end type

type gb_1 from groupbox within w_con_ped_alb_fac_cliente_fechas8
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

type uo_articulo from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
event destroy ( )
integer x = 722
integer y = 168
integer width = 1829
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Artículos"
ue_datawindow  = "dw_ayuda_articulos_almcliartdesc"
ue_filtro = ""
end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type gb_3 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 704
integer y = 116
integer width = 1865
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Artículo"
end type

type st_1 from statictext within w_con_ped_alb_fac_cliente_fechas8
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

type gb_6 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 2976
integer y = 124
integer width = 457
integer height = 156
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_calidad from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
event destroy ( )
integer x = 2597
integer y = 168
integer width = 279
integer taborder = 60
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

type gb_9 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 2578
integer y = 116
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

type uo_serie from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
event destroy ( )
integer x = 1719
integer y = 332
integer width = 827
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_10 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 1701
integer y = 280
integer width = 869
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type rb_1 from radiobutton within w_con_ped_alb_fac_cliente_fechas8
integer x = 2624
integer y = 336
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean lefttext = true
end type

event clicked;if rb_2.checked then
	rb_2.checked = false
end if
end event

type rb_2 from radiobutton within w_con_ped_alb_fac_cliente_fechas8
integer x = 2962
integer y = 336
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo control stock"
boolean lefttext = true
end type

event clicked;if rb_1.checked then
	rb_1.checked = false
end if
end event

type uo_cliente from u_em_campo_2 within w_con_ped_alb_fac_cliente_fechas8
event destroy ( )
integer x = 37
integer y = 332
integer width = 1637
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_4 from groupbox within w_con_ped_alb_fac_cliente_fechas8
integer x = 18
integer y = 280
integer width = 1673
integer height = 160
integer taborder = 20
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

