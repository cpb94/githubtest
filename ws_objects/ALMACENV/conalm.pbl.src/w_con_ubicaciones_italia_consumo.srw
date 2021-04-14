$PBExportHeader$w_con_ubicaciones_italia_consumo.srw
forward
global type w_con_ubicaciones_italia_consumo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ubicaciones_italia_consumo
end type
type pb_2 from upb_imprimir within w_con_ubicaciones_italia_consumo
end type
type dw_detalle from datawindow within w_con_ubicaciones_italia_consumo
end type
type dw_listado from datawindow within w_con_ubicaciones_italia_consumo
end type
type cb_1 from commandbutton within w_con_ubicaciones_italia_consumo
end type
type uo_series from u_marca_lista within w_con_ubicaciones_italia_consumo
end type
type gb_3 from groupbox within w_con_ubicaciones_italia_consumo
end type
type gb_1 from groupbox within w_con_ubicaciones_italia_consumo
end type
type gb_6 from groupbox within w_con_ubicaciones_italia_consumo
end type
type rb_1 from radiobutton within w_con_ubicaciones_italia_consumo
end type
type rb_2 from radiobutton within w_con_ubicaciones_italia_consumo
end type
type dw_listado_resumen from datawindow within w_con_ubicaciones_italia_consumo
end type
type uo_cliente from u_em_campo_2 within w_con_ubicaciones_italia_consumo
end type
end forward

global type w_con_ubicaciones_italia_consumo from w_int_con_empresa
integer width = 3529
integer height = 1832
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
cb_1 cb_1
uo_series uo_series
gb_3 gb_3
gb_1 gb_1
gb_6 gb_6
rb_1 rb_1
rb_2 rb_2
dw_listado_resumen dw_listado_resumen
uo_cliente uo_cliente
end type
global w_con_ubicaciones_italia_consumo w_con_ubicaciones_italia_consumo

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control2 (datawindow data)
end prototypes

public subroutine f_control (datawindow data);long      i,indice,indice2,total,total2,donde,fila,altura
dec       existencias
Datetime  fecha1,fecha2,fecha
String    cliente,sel,sel2,clientes,articulo,formato,nombre_art,zona

datastore datos,datos2

dw_detalle.Reset()
dw_listado.Reset()
data.setredraw(false)

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente)

sel = "select cliente,articulo,formato "+&
		"from   venlifac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente = '24' "+&
		"group  by cliente,articulo,formato"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	cliente  = datos.object.cliente[indice]
	articulo = datos.object.articulo[indice]
	formato  = datos.object.formato[indice]
	nombre_art = f_descripcion_almcliartdesc(codigo_empresa,cliente,articulo)
	if isnull(nombre_art) or trim(nombre_art) = "" then
		nombre_art = f_nombre_articulo(codigo_empresa,articulo)
	end if
	
	sel2 = "select zona,fila,altura,existencias "+&
		 	 "from   almlinubica "+&
			 "where  empresa = '"+codigo_empresa+"' "+&
			 "and    articulo = '"+articulo+"' "+&
			 "group  by zona,fila,altura,existencias"
			 
	//datos2 = f_cargar_cursor(sel2)
	f_cargar_cursor_nuevo(sel2, datos2)
	
	total2 = datos2.Rowcount()
	if total2 > 0 then
		for indice2 = 1 to total2
			zona   = datos2.object.zona[indice2]
			fila   = datos2.object.fila[indice2]
			altura = datos2.object.altura[indice2]
			existencias = datos2.object.existencias[indice2]
			if isnull(existencias) then existencias = 0
			donde  = data.find("articulo = '"+articulo+"' and zona = '"+zona+"' and fila = '"+string(fila)+"' and altura = '"+string(altura)+"'",1,data.rowcount())
			if donde = 0 then
				donde = data.insertrow(0)
				data.object.empresa[donde]           = codigo_empresa
				data.object.cliente[donde]           = cliente
				data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
				data.object.articulo[donde]          = articulo
				data.object.nombre_articulo[donde]   = nombre_art
				data.object.formato[donde]           = formato
				data.object.zona[donde]              = zona
				data.object.fila[donde]              = string(fila)
				data.object.altura[donde]            = string(altura)
				data.object.stock[donde]             = existencias
			else
				data.object.stock[donde]             = data.object.stock[donde] + existencias
			end if
		next
	end if
next

destroy datos
destroy datos2


data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_control2 (datawindow data);long      i,indice,indice2,total,total2,donde,fila,altura
dec       existencias
Datetime  fecha1,fecha2,fecha
String    cliente,sel,sel2,clientes,articulo,formato,nombre_art,zona

datastore datos,datos2

dw_detalle.Reset()
dw_listado.Reset()
data.setredraw(false)

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente)

sel = "select cliente,articulo,formato "+&
		"from   venlifac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente = '24' "+&
		"group  by cliente,articulo,formato"
		
//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)

total = datos.rowcount()

for indice = 1 to total
	cliente  = datos.object.cliente[indice]
	articulo = datos.object.articulo[indice]
	formato  = datos.object.formato[indice]
	nombre_art = f_descripcion_almcliartdesc(codigo_empresa,cliente,articulo)
	if isnull(nombre_art) or trim(nombre_art) = "" then
		nombre_art = f_nombre_articulo(codigo_empresa,articulo)
	end if
	
	sel2 = "select zona,fila,altura,existencias "+&
		 	 "from   almlinubica "+&
			 "where  empresa = '"+codigo_empresa+"' "+&
			 "and    articulo = '"+articulo+"' "+&
			 "group  by zona,fila,altura,existencias"
			 
//	datos2 = f_cargar_cursor(sel2)
	f_cargar_cursor_nuevo(sel2, datos2)
	
	total2 = datos2.Rowcount()
	if total2 > 0 then
		for indice2 = 1 to total2
			existencias = datos2.object.existencias[indice2]
			if isnull(existencias) then existencias = 0
			donde  = data.find("articulo = '"+articulo+"'",1,data.rowcount())
			if donde = 0 then
				donde = data.insertrow(0)
				data.object.empresa[donde]           = codigo_empresa
				data.object.cliente[donde]           = cliente
				data.object.nombre_cliente[donde]    = f_razon_genter(codigo_empresa,"C",cliente)
				data.object.articulo[donde]          = articulo
				data.object.nombre_articulo[donde]   = nombre_art
				data.object.formato[donde]           = formato
				data.object.zona[donde]              = ""
				data.object.fila[donde]              = ""
				data.object.altura[donde]            = ""
				data.object.stock[donde]             = existencias
			else
				data.object.stock[donde]             = data.object.stock[donde] + existencias
			end if
		next
	end if
next

destroy datos
destroy datos2


data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Informe Stocks Italia"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado_resumen.SetTransObject(SQLCA)
rb_2.checked = true


end event

on w_con_ubicaciones_italia_consumo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.uo_series=create uo_series
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_6=create gb_6
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_listado_resumen=create dw_listado_resumen
this.uo_cliente=create uo_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_series
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_6
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.dw_listado_resumen
this.Control[iCurrent+13]=this.uo_cliente
end on

on w_con_ubicaciones_italia_consumo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.uo_series)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_listado_resumen)
destroy(this.uo_cliente)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubicaciones_italia_consumo
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubicaciones_italia_consumo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubicaciones_italia_consumo
integer x = 9
integer y = 8
integer width = 3163
integer height = 112
end type

type pb_1 from upb_salir within w_con_ubicaciones_italia_consumo
integer x = 3278
integer y = 16
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ubicaciones_italia_consumo
integer x = 3040
integer y = 164
integer width = 128
integer height = 112
integer taborder = 20
boolean originalsize = false
end type

event clicked;if rb_2.checked then
	f_control2(dw_listado_resumen)	
	f_imprimir_datawindow(dw_listado_resumen)
else
	f_control(dw_listado)
	f_imprimir_datawindow(dw_listado)
end if


end event

type dw_detalle from datawindow within w_con_ubicaciones_italia_consumo
integer x = 14
integer y = 320
integer width = 3442
integer height = 1296
string dataobject = "dw_con_ubicaciones_italia_consumo"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_con_ubicaciones_italia_consumo
boolean visible = false
integer x = 37
integer y = 152
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_italia_consumo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_con_ubicaciones_italia_consumo
integer x = 2743
integer y = 164
integer width = 288
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if rb_2.checked then
	f_control2(dw_detalle)	
else
	f_control(dw_detalle)
end if


end event

type uo_series from u_marca_lista within w_con_ubicaciones_italia_consumo
event destroy ( )
boolean visible = false
integer x = 690
integer y = 512
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_3 from groupbox within w_con_ubicaciones_italia_consumo
integer x = 23
integer y = 124
integer width = 1129
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
string text = "Cliente"
end type

type gb_1 from groupbox within w_con_ubicaciones_italia_consumo
integer x = 1161
integer y = 124
integer width = 1554
integer height = 164
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_6 from groupbox within w_con_ubicaciones_italia_consumo
integer x = 2725
integer y = 124
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

type rb_1 from radiobutton within w_con_ubicaciones_italia_consumo
integer x = 1193
integer y = 184
integer width = 713
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
string text = "Detallado por ubicaciones"
boolean lefttext = true
end type

event clicked;if rb_2.checked then
	rb_1.checked = false
end if
end event

type rb_2 from radiobutton within w_con_ubicaciones_italia_consumo
integer x = 2181
integer y = 184
integer width = 325
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
string text = "Resumido"
boolean lefttext = true
end type

event clicked;if rb_1.checked then
	rb_2.checked = false
end if
end event

type dw_listado_resumen from datawindow within w_con_ubicaciones_italia_consumo
boolean visible = false
integer x = 297
integer y = 152
integer width = 160
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_italia_consumo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_con_ubicaciones_italia_consumo
event destroy ( )
integer x = 55
integer y = 180
integer width = 1056
integer taborder = 40
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

