$PBExportHeader$w_con_pedidos_con_stock.srw
$PBExportComments$Pedidos pendientes por fecha
forward
global type w_con_pedidos_con_stock from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_con_stock
end type
type pb_2 from upb_imprimir within w_con_pedidos_con_stock
end type
type em_fechadesde from u_em_campo within w_con_pedidos_con_stock
end type
type em_fechahasta from u_em_campo within w_con_pedidos_con_stock
end type
type cb_1 from commandbutton within w_con_pedidos_con_stock
end type
type gb_1 from groupbox within w_con_pedidos_con_stock
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_con_stock
end type
type gb_3 from groupbox within w_con_pedidos_con_stock
end type
type st_1 from statictext within w_con_pedidos_con_stock
end type
type gb_6 from groupbox within w_con_pedidos_con_stock
end type
type em_fecha_intr1 from u_em_campo within w_con_pedidos_con_stock
end type
type em_fecha_intr2 from u_em_campo within w_con_pedidos_con_stock
end type
type st_2 from statictext within w_con_pedidos_con_stock
end type
type gb_2 from groupbox within w_con_pedidos_con_stock
end type
type dw_detalle from datawindow within w_con_pedidos_con_stock
end type
end forward

global type w_con_pedidos_con_stock from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 4626
integer height = 2812
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
gb_6 gb_6
em_fecha_intr1 em_fecha_intr1
em_fecha_intr2 em_fecha_intr2
st_2 st_2
gb_2 gb_2
dw_detalle dw_detalle
end type
global w_con_pedidos_con_stock w_con_pedidos_con_stock

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();long i, j, k, fila
Datetime fecha1,fecha2, fecha_intr1, fecha_intr2, v_fpedido
String  cliente, articulo
string sel, sel2
datastore datos, datos2
str_escandallo escandallo[300]
integer indice, nivel
decimal factor, v_cantidad, v_existencias
integer v_anyo, v_pedido, v_linea, v_calibre, v_fila, v_altura
string v_descripcion, v_formato_abr, v_tono, v_almacen, v_zona, v_cliente_pedido
string cod_cli_ped

dw_detalle.Reset()
fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))
fecha_intr1 = Datetime(Date(String(em_fecha_intr1.Text)))
fecha_intr2 = Datetime(Date(String(em_fecha_intr2.Text)))

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

dw_detalle.object.t_titulo.text = "Pedidos y Stock entre fechas de introducción del pedido: "+em_fecha_intr1.Text+" y "+em_fecha_intr2.Text

sel = " select venliped.articulo, venliped.anyo, venliped.pedido, venliped.linea, venliped.fpedido, venliped.descripcion, "+&
		" venliped.tonochar, venliped.calibre,  venliped.cantidad, venliped.cliente "+&
		" from venliped "+&
		" where venliped.empresa = '"+codigo_empresa+"' "+&
		" and venliped.cliente like '"+cliente+"' "+&
		" and venliped.fpedido >= '"+em_fechadesde.text+"' "+&
		" and venliped.fpedido <= '"+em_fechahasta.text+"' "+&
		" and venliped.fecha_intr >= '"+em_fecha_intr1.text+"' "+&
		" and venliped.fecha_intr <= '"+em_fecha_intr2.text+"' "+&
		" order by venliped.cliente, venliped.articulo "

f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	articulo = datos.object.articulo[i]
	indice = 1
	factor = 1
	nivel = 0

	
	fila = dw_detalle.insertrow(0)
	dw_detalle.object.descripcion[fila] = '------------------------------------------------------------------'
	
	cod_cli_ped = datos.object.cliente[i]
	
	select razon 
	into :v_cliente_pedido
	from genter 
	where empresa = :codigo_empresa
	and codigo = :cod_cli_ped
	and tipoter = 'C';


	
	f_escandallo_factores (escandallo, articulo, indice, factor, nivel)
	j= 1
	do while j < indice and not isnull (escandallo[j].articulo)
		
		
/*		QUITADO POR EL CAMBIO DE TABLAS DE ALMACEN
		sel2 = 	" select articulos.codigo, articulos.descripcion, formatos.abreviado, almlinubica.almacen, almlinubica.zona, almlinubica.fila, "+&
					" almlinubica.altura, almlinubica.existencias, formatos.abreviado, articulos.uso, almlinubica.ubicacion, "+&
					" almlinubica.linea, almlinubica.tonochar, almlinubica.calibre "+&
					" from articulos, formatos, almlinubica "+&
					" where articulos.empresa = formatos.empresa "+&
					" and articulos.formato = formatos.codigo "+&
					" and articulos.empresa *= almlinubica.empresa "+&
					" and articulos.codigo *= almlinubica.articulo "+&
					" and articulos.uso <> '1' "+&
					" and articulos.control_Stock = 'S' "+&
					" and articulos.codigo = '"+escandallo[j].articulo+"' "
*/
		sel2 = 	" select articulos.codigo, articulos.descripcion, formatos.abreviado, almacenmovimientos.almacen, almacenmovimientos.zona, almacenmovimientos.fila, "+&
					" almacenmovimientos.altura, sum ( almacenmovimientos.cantidade - cantidads ) as existencias, formatos.abreviado, articulos.uso, "+&
					" almacenmovimientos.tono, almacenmovimientos.calibre "+&
					" from articulos, formatos, almacenmovimientos "+&
					" where articulos.empresa = formatos.empresa "+&
					" and articulos.formato = formatos.codigo "+&
					" and articulos.empresa *= almacenmovimientos.empresa "+&
					" and articulos.codigo *= almacenmovimientos.articulo "+&
					" and articulos.uso <> '1' "+&
					" and articulos.control_Stock = 'S' "+&
					" and articulos.codigo = '"+escandallo[j].articulo+"' "+&
					" group by articulos.codigo, articulos.descripcion, formatos.abreviado, almacenmovimientos.almacen, almacenmovimientos.zona, almacenmovimientos.fila, "+&
					" almacenmovimientos.altura,  formatos.abreviado, articulos.uso, "+&
					" almacenmovimientos.tono, almacenmovimientos.calibre "+&
					" having sum ( almacenmovimientos.cantidade - cantidads ) <> 0 "
		
		f_cargar_cursor_nuevo (sel2, datos2)
		for k = 1 to datos2.rowcount()
			fila = dw_detalle.insertrow(0)
			dw_detalle.object.empresa[fila] = codigo_empresa
			dw_detalle.object.codigo[fila] = escandallo[j].articulo
			dw_detalle.object.descripcion[fila] = datos2.object.articulos_descripcion[k]
			dw_detalle.object.formato[fila] = datos2.object.formatos_abreviado[k]
			dw_detalle.object.tono[fila] = datos.object.tonochar[i]
			dw_detalle.object.calibre[fila] = datos.object.calibre[i]
			
			dw_detalle.object.piezas[fila] = datos.object.cantidad[i]
			
			dw_detalle.object.almacen[fila] = datos2.object.almacenmovimientos_almacen[k]
			dw_detalle.object.zona[fila] = datos2.object.almacenmovimientos_zona[k]
			dw_detalle.object.fila[fila] = datos2.object.almacenmovimientos_fila[k]
			dw_detalle.object.altura[fila] = datos2.object.almacenmovimientos_altura[k]
			dw_detalle.object.anyo[fila] = datos.object.anyo[i]
			dw_detalle.object.pedido[fila] = datos.object.pedido[i]
			dw_detalle.object.linea[fila] = datos.object.linea[i]
			dw_detalle.object.cliente[fila] = v_cliente_pedido
			dw_detalle.object.existencias[fila] = datos2.object.existencias[k]
			dw_detalle.object.uso[fila] = datos2.object.articulos_uso[k]
		//	dw_detalle.object.ubicacion[fila] = datos2.object.almlinubica_ubicacion[k]
//			dw_detalle.object.ubi_linea[fila] = datos2.object.almlinubica_linea[k]
			dw_detalle.object.tono_stock[fila] = datos2.object.almacenmovimientos_tono[k]
			dw_detalle.object.calibre_stock[fila] = datos2.object.almacenmovimientos_calibre[k]
		next
		j++
	loop
	f_mensaje_proceso ("Registro: "+string(i)+" de "+string(datos.rowcount()), i, datos.rowcount())
next
destroy datos
destroy datos2

end subroutine

event close;call super::close;dw_detalle.reset()
//dw_listado.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado de Pedidos Pendientes con Stock"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
//em_fecha_intr1.text = String(MDY(01,01,Year(Today())))
em_fecha_intr1.text = String(Today())
em_fecha_intr2.text = String(Today())

dw_detalle.SetTransObject(SQLCA)
//dw_listado.SetTransObject(SQLCA)

end event

on w_con_pedidos_con_stock.create
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
this.gb_6=create gb_6
this.em_fecha_intr1=create em_fecha_intr1
this.em_fecha_intr2=create em_fecha_intr2
this.st_2=create st_2
this.gb_2=create gb_2
this.dw_detalle=create dw_detalle
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
this.Control[iCurrent+10]=this.gb_6
this.Control[iCurrent+11]=this.em_fecha_intr1
this.Control[iCurrent+12]=this.em_fecha_intr2
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.dw_detalle
end on

on w_con_pedidos_con_stock.destroy
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
destroy(this.gb_6)
destroy(this.em_fecha_intr1)
destroy(this.em_fecha_intr2)
destroy(this.st_2)
destroy(this.gb_2)
destroy(this.dw_detalle)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_con_stock
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_con_stock
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_con_stock
integer width = 4302
integer height = 84
end type

type pb_1 from upb_salir within w_con_pedidos_con_stock
integer x = 4393
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedidos_con_stock
integer x = 4389
integer y = 148
integer width = 128
integer height = 112
integer taborder = 0
boolean originalsize = false
end type

event clicked;//long     i,indice_ser
//Datetime fecha1,fecha2, fecha1i, fecha2i
//String   series[1 to 20],cliente, filtro, tipopedido
//
//fecha1 = Datetime(Date(String(em_fechadesde.Text)))
//fecha2 = Datetime(Date(String(em_fechahasta.Text)))
//fecha1i = Datetime(Date(String(em_fecha_intr1.Text)))
//fecha2i = Datetime(Date(String(em_fecha_intr2.Text)))
//
//indice_ser = 1
//for i=1 to uo_series.dw_marca.rowcount()
//	if uo_series.dw_marca.getitemstring(i,"marca")="S" then
//		series[indice_ser] = uo_series.dw_marca.getitemstring(i,"codigo")
//		indice_ser ++
//	end if	
//next
//
//if uo_cliente.em_codigo.text <> "" then 
//	cliente = uo_cliente.em_codigo.text
//else
//	cliente = "%"
//end if
//
//if ddlb_tipopedido.text = "TODOS" or ddlb_tipopedido.text = "" then
//	tipopedido = "%"
//end if
//if ddlb_tipopedido.text = "DEPOSITO" then
//	tipopedido = "S"
//end if
//if ddlb_tipopedido.text = "NORMAL" then
//	tipopedido = "N"
//end if
//
//dw_listado.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series, tipopedido, fecha1i, fecha2i)
//
//if cbx_sinfecha.checked then
//	filtro = ' isnull(fentrega) '//+' AND '+tipopedido
//	dw_detalle.SetRedraw(false)
//	dw_detalle.SetFilter("")
//	dw_detalle.SetFilter(filtro)
//	dw_detalle.Filter()
//	dw_detalle.Groupcalc()
//	dw_detalle.SetRedraw(true)
//end if

f_imprimir_datawindow(dw_detalle)

end event

type em_fechadesde from u_em_campo within w_con_pedidos_con_stock
integer x = 23
integer y = 160
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

type em_fechahasta from u_em_campo within w_con_pedidos_con_stock
integer x = 311
integer y = 160
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

type cb_1 from commandbutton within w_con_pedidos_con_stock
integer x = 4105
integer y = 148
integer width = 279
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

event clicked; f_control()

end event

type gb_1 from groupbox within w_con_pedidos_con_stock
integer x = 9
integer y = 100
integer width = 576
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

type uo_cliente from u_em_campo_2 within w_con_pedidos_con_stock
event destroy ( )
integer x = 1193
integer y = 152
integer width = 1614
integer taborder = 50
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

type gb_3 from groupbox within w_con_pedidos_con_stock
integer x = 1179
integer y = 100
integer width = 1650
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

type st_1 from statictext within w_con_pedidos_con_stock
integer x = 270
integer y = 148
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

type gb_6 from groupbox within w_con_pedidos_con_stock
integer x = 4087
integer y = 108
integer width = 439
integer height = 164
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_fecha_intr1 from u_em_campo within w_con_pedidos_con_stock
integer x = 613
integer y = 160
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

type em_fecha_intr2 from u_em_campo within w_con_pedidos_con_stock
integer x = 901
integer y = 160
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

type st_2 from statictext within w_con_pedidos_con_stock
integer x = 859
integer y = 156
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

type gb_2 from groupbox within w_con_pedidos_con_stock
integer x = 599
integer y = 100
integer width = 571
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

type dw_detalle from datawindow within w_con_pedidos_con_stock
integer x = 14
integer y = 288
integer width = 4526
integer height = 2284
string dataobject = "dw_con_pedidos_con_stock"
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

