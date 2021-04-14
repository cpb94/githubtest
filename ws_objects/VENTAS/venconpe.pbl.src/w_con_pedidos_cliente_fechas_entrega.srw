$PBExportHeader$w_con_pedidos_cliente_fechas_entrega.srw
forward
global type w_con_pedidos_cliente_fechas_entrega from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_cliente_fechas_entrega
end type
type pb_2 from upb_imprimir within w_con_pedidos_cliente_fechas_entrega
end type
type dw_detalle from datawindow within w_con_pedidos_cliente_fechas_entrega
end type
type em_fechadesde from u_em_campo within w_con_pedidos_cliente_fechas_entrega
end type
type em_fechahasta from u_em_campo within w_con_pedidos_cliente_fechas_entrega
end type
type cb_continuar from commandbutton within w_con_pedidos_cliente_fechas_entrega
end type
type gb_4 from groupbox within w_con_pedidos_cliente_fechas_entrega
end type
type gb_1 from groupbox within w_con_pedidos_cliente_fechas_entrega
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_cliente_fechas_entrega
end type
type gb_3 from groupbox within w_con_pedidos_cliente_fechas_entrega
end type
type st_1 from statictext within w_con_pedidos_cliente_fechas_entrega
end type
type uo_series from u_marca_lista within w_con_pedidos_cliente_fechas_entrega
end type
type rb_detalle from radiobutton within w_con_pedidos_cliente_fechas_entrega
end type
type rb_resumen from radiobutton within w_con_pedidos_cliente_fechas_entrega
end type
type cbx_valorado from checkbox within w_con_pedidos_cliente_fechas_entrega
end type
type cbx_muestras from checkbox within w_con_pedidos_cliente_fechas_entrega
end type
type st_2 from statictext within w_con_pedidos_cliente_fechas_entrega
end type
type cb_3 from commandbutton within w_con_pedidos_cliente_fechas_entrega
end type
type cb_4 from commandbutton within w_con_pedidos_cliente_fechas_entrega
end type
end forward

global type w_con_pedidos_cliente_fechas_entrega from w_int_con_empresa
integer width = 4178
integer height = 3880
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_continuar cb_continuar
gb_4 gb_4
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
rb_detalle rb_detalle
rb_resumen rb_resumen
cbx_valorado cbx_valorado
cbx_muestras cbx_muestras
st_2 st_2
cb_3 cb_3
cb_4 cb_4
end type
global w_con_pedidos_cliente_fechas_entrega w_con_pedidos_cliente_fechas_entrega

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();long     i
Datetime fecha1,fecha2
String   cliente, filtro, nombre_empresa

dw_detalle.Reset()
uo_series.visible = false

fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente)

select nombre
into :nombre_empresa
from empresas
where empresa = :codigo_empresa;

dw_detalle.object.titulo.text = nombre_empresa





end subroutine

event close;call super::close;dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado de Pedidos Pendientes por Fecha de entrega"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,2001))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
end event

on w_con_pedidos_cliente_fechas_entrega.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_continuar=create cb_continuar
this.gb_4=create gb_4
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.cbx_valorado=create cbx_valorado
this.cbx_muestras=create cbx_muestras
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_continuar
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_series
this.Control[iCurrent+13]=this.rb_detalle
this.Control[iCurrent+14]=this.rb_resumen
this.Control[iCurrent+15]=this.cbx_valorado
this.Control[iCurrent+16]=this.cbx_muestras
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.cb_3
this.Control[iCurrent+19]=this.cb_4
end on

on w_con_pedidos_cliente_fechas_entrega.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_continuar)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.cbx_valorado)
destroy(this.cbx_muestras)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_cliente_fechas_entrega
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_cliente_fechas_entrega
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_cliente_fechas_entrega
integer x = 69
integer y = 8
integer width = 3877
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_cliente_fechas_entrega
integer x = 4023
integer width = 110
integer height = 96
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedidos_cliente_fechas_entrega
integer x = 3666
integer y = 180
integer width = 128
integer height = 108
integer taborder = 0
boolean originalsize = false
end type

event clicked;//long     i,indice_ser
//Datetime fecha1,fecha2
//String   series[1 to 20],cliente, filtro
//
//fecha1 = Datetime(Date(String(em_fechadesde.Text)))
//fecha2 = Datetime(Date(String(em_fechahasta.Text)))
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
//dw_listado.Retrieve(codigo_empresa,fecha1,fecha2,cliente,series)
//
//if cbx_sinfecha.checked then
//	filtro = ' isnull(fentrega)  '
//	dw_listado.SetFilter("")
//	dw_listado.SetFilter(filtro)
//	dw_listado.Filter()
//end if
//
//
f_imprimir_datawindow(dw_detalle)

end event

type dw_detalle from datawindow within w_con_pedidos_cliente_fechas_entrega
integer x = 50
integer y = 384
integer width = 4091
integer height = 3316
string dataobject = "dw_con_pedidos_cliente_fechas_entrega"
boolean vscrollbar = true
boolean border = false
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type em_fechadesde from u_em_campo within w_con_pedidos_cliente_fechas_entrega
integer x = 69
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

type em_fechahasta from u_em_campo within w_con_pedidos_cliente_fechas_entrega
integer x = 375
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

type cb_continuar from commandbutton within w_con_pedidos_cliente_fechas_entrega
integer x = 3365
integer y = 176
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

type gb_4 from groupbox within w_con_pedidos_cliente_fechas_entrega
integer x = 1938
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

type gb_1 from groupbox within w_con_pedidos_cliente_fechas_entrega
integer x = 55
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

type uo_cliente from u_em_campo_2 within w_con_pedidos_cliente_fechas_entrega
event destroy ( )
integer x = 681
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

type gb_3 from groupbox within w_con_pedidos_cliente_fechas_entrega
integer x = 667
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

type st_1 from statictext within w_con_pedidos_cliente_fechas_entrega
integer x = 334
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

type uo_series from u_marca_lista within w_con_pedidos_cliente_fechas_entrega
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type rb_detalle from radiobutton within w_con_pedidos_cliente_fechas_entrega
integer x = 1947
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
	
	detalle = TRUE
end if

end event

type rb_resumen from radiobutton within w_con_pedidos_cliente_fechas_entrega
integer x = 1947
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
	
	detalle = FALSE
	if not valorado then
		cbx_valorado.triggerevent(clicked!)
		cbx_valorado.checked = true
	end if
end if

end event

type cbx_valorado from checkbox within w_con_pedidos_cliente_fechas_entrega
integer x = 2272
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
	valorado = FALSE
end if

end event

type cbx_muestras from checkbox within w_con_pedidos_cliente_fechas_entrega
integer x = 2272
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
else
	dw_detalle.setfilter("clase = 'M'")
	dw_detalle.filter()		
	dw_detalle.groupcalc()
end if

muestras = not(muestras)
end event

type st_2 from statictext within w_con_pedidos_cliente_fechas_entrega
integer x = 32
integer y = 304
integer width = 2615
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Nota: Las líneas de pedido bloqueadas por falta de base del cliente no se mostrarán en este informe"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_con_pedidos_cliente_fechas_entrega
boolean visible = false
integer x = 3808
integer y = 136
integer width = 288
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mail"
end type

event clicked;string sel_pedidos, sel_clientes, sel_emails, lista_destinatarios, email, asunto, cuerpo_mensaje
datastore regs_email, regs_pedidos, regs_clientes
long  i, m, k
string anyo, pedido, linea, fpedido, des_articulo, des_formato, cantidad, numpedcli, fentrega_inicial, fentrega2, fentrega3, fentrega4, fentrega5, fecha_intr, cliente, des_cliente
string referencia_pedido, anyo_ant, pedido_ant, razon, cod_cliente, mensaje, des_unidad

if uo_cliente.em_codigo.text = '' then
	mensaje = "Se enviará la fechas de entrega a TODOS los clientes"
else
	mensaje = "Se enviará las fechas de entrega de "+uo_cliente.em_campo.text
end if

if messagebox ("Atención", mensaje, Question!,  OKCancel!) = 1 then
	if uo_cliente.em_codigo.text = '' then
		cod_cliente = '%'
	else
		cod_cliente = uo_cliente.em_codigo.text
	end if
	
	sel_clientes = 	"select distinct cliente "+&
						"from venliped "+&
						"inner join venclientes ON venliped.empresa = venclientes.empresa AND venliped.cliente = venclientes.codigo "+&
						"where venliped.bloqueado = '0' and cliente like '"+cod_cliente+"' AND venclientes.grupo <> '2' " //NO ENVIAR FECHAS A CLIENTES DE WOW
	f_cargar_cursor_nuevo (sel_clientes, regs_clientes)
	
	for m = 1 to regs_clientes.rowcount()
		cliente = regs_clientes.object.cliente[m]
		
		cuerpo_mensaje = "TENDENCIAS CERAMICAS S.L.U. ~n"
		cuerpo_mensaje = cuerpo_mensaje +"LISTADO DE FECHAS DE ENTREGA ~n ~n"
		
		sel_pedidos = "SELECT  venliped.anyo,   "+&
									" venliped.pedido, "+&   
									" venliped.linea, "+&   
									" venliped.fpedido, "+&   
									" venliped.descripcion, "+&   
									" formatos.abreviado, "+&   
									" venliped.tono, "+&   
									" venliped.calibre, "+&   
									" venliped.cantidad, "+&   
									" unidades.abreviado, "+&   
									" venped.numpedcli, "+&   
									" venliped.fentrega, "+&   
									" venliped.fentrega_inicial, "+&   
									" venliped.fecha_entrega2, "+&   
									" venliped.fecha_entrega3, "+&   
									" venliped.fecha_entrega4, "+&   
									" venliped.fecha_entrega5, "+&   
									" venliped.fecha_intr, "+&   
									" genter.razon "+&  
				" FROM venliped LEFT OUTER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido    "+&
									" LEFT OUTER JOIN  articulos ON  venliped.empresa = articulos.empresa and venliped.articulo = articulos.codigo    "+&
									" LEFT OUTER JOIN  genter ON  venliped.empresa = genter.empresa  and venliped.cliente  = genter.codigo  and genter.tipoter = 'C'    "+&
									" LEFT OUTER JOIN  formatos ON  articulos.empresa = formatos.empresa and articulos.formato = formatos.codigo   "+&
									" LEFT OUTER JOIN  unidades ON  venliped.tipo_unidad = unidades.codigo   "+&
				" WHERE  (  venliped.empresa = '"+codigo_empresa+"') AND   "+&
							" (  venliped.cliente = '"+cliente+"') AND   "+&
							" ( venliped.bloqueado = '0' )    "+&
				" ORDER BY venliped.fpedido , venliped.anyo, venliped.pedido, venliped.linea "
	
		f_cargar_cursor_nuevo (sel_pedidos, regs_pedidos)
		
	//	if regs_pedidos.rowcount() > 0 then
			for k = 1 to regs_pedidos.rowcount()
				if k <= 1 then
					anyo_ant = ''
					pedido_ant  =''
				else
					anyo_ant = string(regs_pedidos.object.venliped_anyo[k - 1])
					pedido_ant  = string(regs_pedidos.object.venliped_pedido[k - 1])
				end if
				anyo = string(regs_pedidos.object.venliped_anyo[k])
				if isnull (anyo ) then anyo = ""
				pedido = string(regs_pedidos.object.venliped_pedido[k])
				if isnull (pedido ) then pedido = ""
				linea = string(regs_pedidos.object.venliped_linea[k])
				if isnull (linea ) then linea = ""
				fpedido = string(regs_pedidos.object.venliped_fpedido[k], "dd-mm-yy")
				if isnull (fpedido) then fpedido = ""
				fecha_intr = string(regs_pedidos.object.venliped_fecha_intr[k], "dd-mm-yy")
				if isnull (fecha_intr ) then fecha_intr = ""
				des_articulo = f_ajustar_cadena(string(regs_pedidos.object.venliped_descripcion[k]), 30)
				if isnull (des_articulo ) then des_articulo = ""
				des_formato = f_ajustar_cadena(string(regs_pedidos.object.formatos_abreviado[k]), 10)
				if isnull (des_formato ) then des_formato = ""
				numpedcli = string(regs_pedidos.object.venped_numpedcli[k])
				if isnull (numpedcli) then numpedcli = ""
				cantidad = string(regs_pedidos.object.venliped_cantidad[k], "###,###,###")
				if isnull (cantidad) then cantidad = ""
				razon = regs_pedidos.object.genter_razon[k]
				if isnull (razon ) then razon = ""
				des_unidad = regs_pedidos.object.unidades_abreviado[k]
				if isnull (des_unidad ) then des_unidad = "" 
				
				if isnull(regs_pedidos.object.venliped_fentrega_inicial[k]) then
					fentrega_inicial = ''
				else
					fentrega_inicial = f_ajustar_cadena("~n"+"Fecha Entrega:      "+string(regs_pedidos.object.venliped_fentrega_inicial[k], "dd-mm-yy"), 35)
				end if
				
				if isnull(regs_pedidos.object.venliped_fecha_entrega2[k]) then
					fentrega2 = ''
				else
					fentrega2 = f_ajustar_cadena (string(regs_pedidos.object.venliped_fecha_entrega2[k], "dd-mm-yy"), 15)
				end if
		
				if isnull(regs_pedidos.object.venliped_fecha_entrega3[k]) then
					fentrega3 = ''
				else
					fentrega3 = f_ajustar_cadena (string(regs_pedidos.object.venliped_fecha_entrega3[k], "dd-mm-yy"), 15)
				end if
		
				if isnull(regs_pedidos.object.venliped_fecha_entrega4[k]) then
					fentrega4 = ''
				else
					fentrega4 = f_ajustar_cadena (string(regs_pedidos.object.venliped_fecha_entrega4[k], "dd-mm-yy"), 15)
				end if
				
				if isnull(regs_pedidos.object.venliped_fecha_entrega5[k]) then
					fentrega5 = ''
				else
					fentrega5 = f_ajustar_cadena (string(regs_pedidos.object.venliped_fecha_entrega5[k], "dd-mm-yy"), 15)
				end if
			
				if anyo = anyo_ant and pedido = pedido_ant then
					referencia_pedido = ''
				else
					referencia_pedido =	"___________________________________________________________________________"+&
													"~n"+"PEDIDO:             "+pedido+"/"+fpedido+"~n"+"SU REFERENCIA:      "+numpedcli+"~n ~n"
				end if
		
				cuerpo_mensaje = cuerpo_mensaje +referencia_pedido+fecha_intr+"    "+des_formato+" "+des_articulo+"   "+cantidad+"  "+des_unidad+" "+&
										+fentrega_inicial+"  "+fentrega2+"  "+fentrega3+"  "+fentrega4+"  "+fentrega5+"~n ~n"		
			next
			
			cuerpo_mensaje = cuerpo_mensaje + "~n ~n ~nTendencias Cerámicas S.L.  ~nTel. 964331910 ~nFax. 964331911~npedidos@tendenciasceramicas.com"
			
			sel_emails = " select email "+&
							" from venclientes_email "+&
							" where empresa = '"+codigo_empresa+"' "+&
							" and cliente = '"+cliente+"'  "+&
							" and tipo = 1 "
							
			f_cargar_cursor_nuevo (sel_emails, regs_email)
			
			lista_destinatarios = "pedidos@tendenciasceramicas.com"
			for i = 1 to regs_email.rowcount()
				if lista_destinatarios = '' then
					lista_destinatarios = regs_email.object.email[i]
				else
					lista_destinatarios = 	lista_destinatarios +", "+ regs_email.object.email[i]
				end if
			next
	
//			lista_destinatarios = "dmartinez@tendenciasceramicas.com"
			asunto = razon+": Fechas de Entrega "+string(today())
			if lista_destinatarios <> '' then			
				run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
						' -f "pedidos@tendenciasceramicas.com" -to  "'+lista_destinatarios+'" '+&
						' -subject "'+asunto+'" '+&
						' -body "'+cuerpo_mensaje+'" '+&
						' -u pedidos.tendenciasceramicas.com -pw #30Octubre', minimized!)
/*				
				run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
						' -f "pedidos@tendenciasceramicas.com" -to  "'+lista_destinatarios+'" '+&
						' -subject "'+asunto+'" '+&
						' -body "'+cuerpo_mensaje+'" '+&
						' -u pedidos.tendenciasceramicas.com -pw #30Octubre -attach c:\temp\1.bmp', minimized!)
*/						
			else
				messagebox ("Atención", razon+" No tiene dirección de correo.", Exclamation!,  OK!)
			end if
	//	end if			
		destroy regs_pedidos
	next
	
	destroy regs_email
	destroy regs_clientes
end if



end event

type cb_4 from commandbutton within w_con_pedidos_cliente_fechas_entrega
integer x = 3826
integer y = 180
integer width = 288
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "e-mail"
end type

event clicked;string sel_pedidos, sel_clientes, sel_emails, lista_destinatarios, email, asunto, cuerpo_mensaje
datastore regs_email, regs_pedidos, regs_clientes
long  i, m, k
string anyo, pedido, linea, fpedido, des_articulo, des_formato, cantidad, numpedcli, fentrega_inicial, fentrega2, fentrega3, fentrega4, fentrega5, fecha_intr, cliente, des_cliente
string referencia_pedido, anyo_ant, pedido_ant, razon, cod_cliente, mensaje, des_unidad
string ruta_completa

if uo_cliente.em_codigo.text = '' then
	mensaje = "Se enviará la fechas de entrega a TODOS los clientes que tengan dirección de correo para e-mail"
else
	mensaje = "Se enviará las fechas de entrega de "+uo_cliente.em_campo.text
end if

if messagebox ("Atención", mensaje, Question!,  OKCancel!) = 1 then
	if uo_cliente.em_codigo.text = '' then
		cod_cliente = '%'
	else
		cod_cliente = uo_cliente.em_codigo.text
	end if
	
	sel_clientes = 	" SELECT distinct venliped.cliente "+&
						" FROM venliped "+&
						" INNER JOIN venclientes ON venliped.empresa = venclientes.empresa AND venliped.cliente = venclientes.codigo "+&
						" INNER JOIN venclientes_email ON venliped.empresa = venclientes_email.empresa AND venliped.cliente = venclientes_email.cliente "+&
						" WHERE venliped.bloqueado = '0' "+&
						" AND venliped.cliente like '"+cod_cliente+"' "+&
						" AND venclientes_email.tipo = '1'  "
						
	f_cargar_cursor_nuevo (sel_clientes, regs_clientes)


	for m = 1 to regs_clientes.rowcount()
		uo_cliente.em_codigo.text = 	regs_clientes.object.venliped_cliente[m]
		cb_continuar.triggerevent (Clicked!)
		razon = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)		
		
		if dw_detalle.RowCount () > 0 then
			// Impresion de un PDF
			dw_detalle.Object.DataWindow.Export.PDF.Method = Distill!
//			dw_detalle.Object.DataWindow.Printer = "Microsoft Print to PDF"    //PDF Nombre de la impresora virtual
			dw_detalle.Object.DataWindow.Printer = "CutePDF Writer"    //PDF Nombre de la impresora virtual
			dw_detalle.Object.DataWindow.Export.PDF.Distill.CustomPostScript="YES"     // Permitir Postscript
//			dw_detalle.Modify("datawindow.Export.PDF.xslfop.print=NO")
			ruta_completa = "C:\TEMP"+"\"+uo_cliente.em_codigo.text+".pdf"
			dw_detalle.SaveAs(ruta_completa, PDF!, true) 
			
//			sleep (2)
			

			asunto = razon+". Fechas de Entrega "+string(today())

			cuerpo_mensaje = "Adjunto le remito las fechas de entrega.~n ~n ~nTendencias Cerámicas S.L.U.  ~nTel. 964331910 ~nFax. 964331911~npedidos@tendenciasceramicas.com"

			sel_emails = " select email "+&
							" from venclientes_email "+&
							" where empresa = '"+codigo_empresa+"' "+&
							" and cliente = '"+uo_cliente.em_codigo.text+"'  "+&
							" and tipo = 1 "
							
			f_cargar_cursor_nuevo (sel_emails, regs_email)
	
			lista_destinatarios = "pedidos@tendenciasceramicas.com"
			for i = 1 to regs_email.rowcount()
				if lista_destinatarios = '' then
					lista_destinatarios = regs_email.object.email[i]
				else
					lista_destinatarios = 	lista_destinatarios +", "+ regs_email.object.email[i]
				end if
			next

//			lista_destinatarios = "dmartinez@tendenciasceramicas.com"

			if lista_destinatarios <> '' then			
				run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
						' -f "pedidos@tendenciasceramicas.com" -to  "'+lista_destinatarios+'" '+&
						' -subject "'+asunto+'" '+&
						' -body "'+cuerpo_mensaje+'" '+&
						' -u pedidos.tendenciasceramicas.com -pw #30Octubre -attach c:\temp\'+uo_cliente.em_codigo.text+'.pdf', minimized!)
			end if
			sleep (1)
			FileDelete ( "c:\temp\"+uo_cliente.em_codigo.text+".pdf" )
		end if		
	next
	destroy regs_email
	destroy regs_clientes
end if



end event

