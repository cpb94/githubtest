$PBExportHeader$w_con_ventas_coste_mermas_articulos.srw
forward
global type w_con_ventas_coste_mermas_articulos from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_ventas_coste_mermas_articulos
end type
type gb_4 from groupbox within w_con_ventas_coste_mermas_articulos
end type
type pb_imprimir from upb_imprimir within w_con_ventas_coste_mermas_articulos
end type
type dw_1 from datawindow within w_con_ventas_coste_mermas_articulos
end type
type cb_1 from u_boton within w_con_ventas_coste_mermas_articulos
end type
type pb_1 from upb_salir within w_con_ventas_coste_mermas_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_ventas_coste_mermas_articulos
end type
type em_fdesde from u_em_campo within w_con_ventas_coste_mermas_articulos
end type
type em_fhasta from u_em_campo within w_con_ventas_coste_mermas_articulos
end type
type p_imagen from picture within w_con_ventas_coste_mermas_articulos
end type
type p_arrow from picture within w_con_ventas_coste_mermas_articulos
end type
type st_3 from statictext within w_con_ventas_coste_mermas_articulos
end type
type st_4 from statictext within w_con_ventas_coste_mermas_articulos
end type
type cbx_solo_coste_fabricacion from checkbox within w_con_ventas_coste_mermas_articulos
end type
type cbx_solo_articulos_cliente from checkbox within w_con_ventas_coste_mermas_articulos
end type
end forward

global type w_con_ventas_coste_mermas_articulos from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 4795
integer height = 3120
string title = "Consumo de bases"
gb_1 gb_1
gb_4 gb_4
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
uo_cliente uo_cliente
em_fdesde em_fdesde
em_fhasta em_fhasta
p_imagen p_imagen
p_arrow p_arrow
st_3 st_3
st_4 st_4
cbx_solo_coste_fabricacion cbx_solo_coste_fabricacion
cbx_solo_articulos_cliente cbx_solo_articulos_cliente
end type
global w_con_ventas_coste_mermas_articulos w_con_ventas_coste_mermas_articulos

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string filtro, articulo, cliente, descripcion
datetime fecha1, fecha2
long i, fila_Actual
dec coste, coste_mermas, piezas, importe
string sel
datastore datos
boolean solo_coste_fab

dw_1.reset()
fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.st_fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_cliente.em_campo.text <> "" and not isnull(uo_cliente.em_campo.text) then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

if cbx_solo_articulos_cliente.checked = true then
	

	sel = " select articulos.codigo, articulos.descripcion, articulos.cliente, genter.razon, sum(venlifac.cantidad) piezas, sum(venlifac.importe) importe "+&
			" from articulos, genter, venlifac, venfac "+&
			" where articulos.empresa = '"+codigo_empresa+"' "+&
			" and articulos.empresa = genter.empresa "+&
			" and articulos.cliente = genter.codigo "+&
			" and articulos.cliente like '"+cliente+"' "+&
			" and genter.tipoter = 'C' "+&
			" and articulos.empresa = venfac.empresa "+&
			" and articulos.cliente = venfac.cliente "+&
			" and articulos.codigo = venlifac.articulo "+&
			" and venfac.anyo = venlifac.anyo "+&		
			" and venfac.factura = venlifac.factura "+&
			" and venlifac.ffactura >= '"+em_fdesde.text+ "' "+&
			" and venlifac.ffactura <= '"+em_fhasta.text+ "' "+&
			" group by articulos.codigo, articulos.descripcion, articulos.cliente, genter.razon"
			
else
	
	sel =" select articulos.codigo, articulos.descripcion, venlifac.cliente, genter.razon, sum(venlifac.cantidad) piezas, sum(venlifac.importe) importe "+&
		" from articulos, genter, venlifac, venfac "+&
		" where articulos.empresa = '"+codigo_empresa+"' "+& 
		" and articulos.empresa = genter.empresa "+& 
		" and venlifac.cliente = genter.codigo "+& 
		" and venlifac.cliente like '"+cliente+"' "+&
		" and genter.tipoter = 'C' "+& 
		" and articulos.empresa = venfac.empresa "+& 
		" and venlifac.cliente = venfac.cliente "+& 
		" and articulos.codigo = venlifac.articulo "+& 
		" and venfac.anyo = venlifac.anyo "+& 
		" and venfac.factura = venlifac.factura "+& 
		" and venlifac.ffactura >= '"+em_fdesde.text+ "' "+&
     	" and venlifac.ffactura <= '"+em_fhasta.text+ "' "+&
		" group by articulos.codigo, articulos.descripcion, venlifac.cliente, genter.razon "
		
end if
			
			
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	articulo = datos.object.articulos_codigo[i]
	descripcion = datos.object.articulos_descripcion[i]
	cliente = datos.object.genter_razon[i]
	piezas = datos.object.piezas[i]
	importe = datos.object.importe[i]
	
	dw_1.object.articulo[i] = articulo
	dw_1.object.descripcion[i] = descripcion
	dw_1.object.cliente[i] = cliente
	dw_1.object.piezas[i] = piezas
	dw_1.object.importe[i] = importe
	coste = 0
	coste_mermas = 0
	if cbx_solo_coste_fabricacion.checked then
		solo_coste_fab = true
	else 
		solo_coste_fab = false
	end if
	f_calculo_coste_articulo_y_mermas (codigo_empresa, articulo, coste, coste_mermas, solo_coste_fab)
	dw_1.object.coste_u[i] =  coste
	dw_1.object.coste_mermas_u[i] = coste_mermas
	if coste <> 0 then
		dw_1.object.porcentaje_mermas[i] = coste_mermas / coste * 100
	else 
		dw_1.object.porcentaje_mermas[i] = 0
	end if
	
	f_mensaje_proceso ("Calculando costes...", i, datos.rowcount())
	
next

filtro = ""
dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.groupcalc()
dw_1.SetSort("importe D")
dw_1.Sort()

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if


destroy datos
end subroutine

on w_con_ventas_coste_mermas_articulos.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_4=create gb_4
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.uo_cliente=create uo_cliente
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.p_imagen=create p_imagen
this.p_arrow=create p_arrow
this.st_3=create st_3
this.st_4=create st_4
this.cbx_solo_coste_fabricacion=create cbx_solo_coste_fabricacion
this.cbx_solo_articulos_cliente=create cbx_solo_articulos_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.em_fdesde
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.p_imagen
this.Control[iCurrent+11]=this.p_arrow
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.cbx_solo_coste_fabricacion
this.Control[iCurrent+15]=this.cbx_solo_articulos_cliente
end on

on w_con_ventas_coste_mermas_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.uo_cliente)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.p_imagen)
destroy(this.p_arrow)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cbx_solo_coste_fabricacion)
destroy(this.cbx_solo_articulos_cliente)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta Ventas y Coste de Artículos por cliente"
istr_parametros.s_listado        =   "dw_1"
This.title                       =   istr_parametros.s_titulo_ventana

uo_cliente.setfocus()

em_fhasta.text = string(today(), "dd-mm-yy")
em_fdesde.text = "01-01-01"



dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(p_arrow)



end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ventas_coste_mermas_articulos
integer x = 997
integer y = 2344
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ventas_coste_mermas_articulos
integer x = 4037
integer y = 124
integer width = 142
integer height = 76
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ventas_coste_mermas_articulos
integer width = 4599
integer textsize = -8
end type

type gb_1 from groupbox within w_con_ventas_coste_mermas_articulos
integer x = 1989
integer y = 80
integer width = 617
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Factura"
end type

type gb_4 from groupbox within w_con_ventas_coste_mermas_articulos
integer x = 32
integer y = 76
integer width = 1943
integer height = 140
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

type pb_imprimir from upb_imprimir within w_con_ventas_coste_mermas_articulos
event clicked pbm_bnclicked
integer x = 4535
integer y = 108
integer taborder = 0
end type

event clicked;parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_con_ventas_coste_mermas_articulos
integer x = 41
integer y = 240
integer width = 4695
integer height = 2584
string dataobject = "dw_con_articulos_coste_mermas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event rowfocuschanged;
	

//p_imagen.PictureName = ""
//
//IF dw_1.GetRow() > 0 then
//	p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_1.object.desmodelo_modelo[dw_1.GetRow()]))
//
//else
//	p_imagen.PictureName = ""
//END IF
//	
//This.SelectRow(0, FALSE)	
//This.SelectRow ( currentrow, True )
	
end event

event clicked;
IF dwo.name= "importe_t" Then
	this.SetSort("importe D")
	this.Sort()
END IF
IF dwo.name= "porcentaje_mermas_t" Then
	this.filter()
	this.SetSort("porcentaje_mermas D")
	this.Sort()
END IF
IF dwo.name= "coste_total_mermas_t" Then
	this.filter()
	this.SetSort("total_con_mermas D")
	this.Sort()
END IF




end event

type cb_1 from u_boton within w_con_ventas_coste_mermas_articulos
integer x = 4233
integer y = 108
integer width = 288
integer height = 108
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_ventas_coste_mermas_articulos
integer x = 4635
integer y = 108
integer width = 114
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

type uo_cliente from u_em_campo_2 within w_con_ventas_coste_mermas_articulos
event destroy ( )
integer x = 50
integer y = 124
integer width = 1902
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type em_fdesde from u_em_campo within w_con_ventas_coste_mermas_articulos
integer x = 2007
integer y = 132
integer width = 288
integer height = 72
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_ventas_coste_mermas_articulos
integer x = 2304
integer y = 132
integer width = 288
integer height = 72
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type p_imagen from picture within w_con_ventas_coste_mermas_articulos
boolean visible = false
integer x = 3758
integer y = 2072
integer width = 832
integer height = 420
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type p_arrow from picture within w_con_ventas_coste_mermas_articulos
integer x = 466
integer y = 1788
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "VCRNext!"
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_ventas_coste_mermas_articulos
integer x = 3291
integer y = 248
integer width = 1349
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 16777215
string text = "No incluye facturas ajenas a la activdad."
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_ventas_coste_mermas_articulos
integer x = 3296
integer y = 304
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 16777215
string text = "Incluye todos los dtos excepto rappel y dtopp."
boolean focusrectangle = false
end type

type cbx_solo_coste_fabricacion from checkbox within w_con_ventas_coste_mermas_articulos
integer x = 2619
integer y = 120
integer width = 667
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
string text = "Sólo coste fabricación"
boolean checked = true
end type

type cbx_solo_articulos_cliente from checkbox within w_con_ventas_coste_mermas_articulos
integer x = 3305
integer y = 120
integer width = 672
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
string text = "Sólo articulos de cliente"
boolean checked = true
end type

