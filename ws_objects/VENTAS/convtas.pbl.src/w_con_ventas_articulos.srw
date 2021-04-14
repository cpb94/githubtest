$PBExportHeader$w_con_ventas_articulos.srw
forward
global type w_con_ventas_articulos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_ventas_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_ventas_articulos
end type
type st_4 from statictext within w_con_ventas_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_ventas_articulos
end type
type st_5 from statictext within w_con_ventas_articulos
end type
type st_6 from statictext within w_con_ventas_articulos
end type
type st_7 from statictext within w_con_ventas_articulos
end type
type st_8 from statictext within w_con_ventas_articulos
end type
type uo_calidad from u_em_campo_2 within w_con_ventas_articulos
end type
type em_tono from u_em_campo within w_con_ventas_articulos
end type
type st_11 from statictext within w_con_ventas_articulos
end type
type uo_tipo_pallet from u_em_campo_2 within w_con_ventas_articulos
end type
type cb_1 from u_boton within w_con_ventas_articulos
end type
type em_calibre from u_em_campo within w_con_ventas_articulos
end type
type dw_detalle from datawindow within w_con_ventas_articulos
end type
end forward

global type w_con_ventas_articulos from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 2971
integer height = 3844
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_articulo uo_articulo
st_4 st_4
uo_cliente uo_cliente
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
uo_calidad uo_calidad
em_tono em_tono
st_11 st_11
uo_tipo_pallet uo_tipo_pallet
cb_1 cb_1
em_calibre em_calibre
dw_detalle dw_detalle
end type
global w_con_ventas_articulos w_con_ventas_articulos

type variables
String	is_codigo,ante_articulo
String  devolver,var_envio
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_filtros (datastore dw)
end prototypes

public subroutine f_control ();dw_detalle.reset()
String articulo,calidad,tipo_pallet,tipo_unidad,situacion,sel,cliente,divisa
Dec{0} pedido,albaran,factura,tono,calibre,contador
Dec{2} cantidad,precio
DateTime fecha
Integer r1,r
Datastore dw
contador = 0
articulo = uo_articulo.em_codigo.text
cliente  = uo_cliente.em_codigo.text
Sel = " SELECT venliped.pedido,venliped.articulo,venliped.calidad,venliped.tipo_pallet,venliped.tono,venliped.calibre,venliped.cantidad,venliped.fpedido,venliped.tipo_unidad,venliped.situacion,venliped.precio,venliped.divisa " + &
      " FROM venliped " +&   
		" INNER JOIN venped on venliped.pedido = venped.pedido and venliped.empresa = venped.empresa " +&
		" WHERE  venliped.empresa  ='"+ STring(codigo_empresa) + "'" + &
		" AND    venliped.cliente  ='"+ STring(cliente)  + "'" + &
		" AND    venliped.articulo ='"+ STring(articulo) + "'" +&
		" AND    venped.es_proforma != 'S' " +&
		" ORDER BY venliped.fpedido Desc"
		

//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
f_filtros(dw)
r1 = dw.RowCOunt()
For r = 1 To r1
	contador    = contador + 1
	pedido      = dw.GetItemNumber(r,"pedido")
	articulo    = dw.GetItemString(r,"articulo")
	calidad     = dw.GetItemString(r,"calidad")
	tipo_pallet = dw.GetItemString(r,"tipo_pallet")
	tipo_unidad = dw.GetItemString(r,"tipo_unidad")
	tono     = dw.GetItemNumber(r,"tono")
	calibre  = dw.GetItemNumber(r,"calibre")
	cantidad = dw.GetItemNumber(r,"cantidad")
	fecha    = dw.GetItemDateTime(r,"fpedido")
	situacion= dw.GetItemString(r,"situacion")
	precio   = dw.GetItemNumber(r,"precio")
	divisa   = dw.GetItemString(r,"divisa")
	
	dw_detalle.InsertRow(contador)
	dw_detalle.SetItem(contador,"pedido",pedido)
	dw_detalle.SetItem(contador,"articulo",articulo)
	dw_detalle.SetItem(contador,"nombre_articulo",f_nombre_articulo(codigo_empresa,articulo))
	dw_detalle.SetItem(contador,"calidad",calidad)
	dw_detalle.SetItem(contador,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	dw_detalle.SetItem(contador,"divisa",f_nombre_moneda_abr(divisa))
	dw_detalle.SetItem(contador,"tono",tono)
	dw_detalle.SetItem(contador,"calibre",calibre)
	dw_detalle.SetItem(contador,"tipo_pallet",tipo_pallet)
	dw_detalle.SetItem(contador,"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	dw_detalle.SetItem(contador,"cantidad",cantidad)
	dw_detalle.SetItem(contador,"fecha",fecha)
	dw_detalle.SetItem(contador,"tipo_unidad",tipo_unidad)
	dw_detalle.SetItem(contador,"nombre_tipo_unidad",f_nombre_unidad_abr(tipo_unidad))
	dw_detalle.SetItem(contador,"situacion",situacion)
	dw_detalle.SetItem(contador,"precio",precio)
Next


Sel = " SELECT albaran,articulo,calidad,tipo_pallet,tono,calibre,cantidad,falbaran,tipo_unidad,situacion,precio,divisa From venlialb  " + &
      " WHERE  venlialb.empresa  ='"+ STring(codigo_empresa) + "'" + &
		" AND    venlialb.cliente  ='"+ STring(cliente)  + "'" + &
		" AND    venlialb.articulo ='"+ STring(articulo) + "'" +&
		" ORDER BY falbaran desc"

//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
f_filtros(dw)
r1 = dw.RowCount()
For r = 1 To r1
	contador    = contador + 1
	albaran      = dw.GetItemNumber(r,"albaran")
	articulo    = dw.GetItemString(r,"articulo")
	calidad     = dw.GetItemString(r,"calidad")
	tipo_pallet = dw.GetItemString(r,"tipo_pallet")
	tono        = dw.GetItemNumber(r,"tono")
	calibre     = dw.GetItemNumber(r,"calibre")
	cantidad    = dw.GetItemNumber(r,"cantidad")
	fecha    = dw.GetItemDateTime(r,"falbaran")
	tipo_unidad = dw.GetItemString(r,"tipo_unidad")
	precio      = dw.GetItemNumber(r,"precio")
	divisa   = dw.GetItemString(r,"divisa")
	dw_detalle.InsertRow(contador)
	dw_detalle.SetItem(contador,"albaran",albaran)
	dw_detalle.SetItem(contador,"articulo",articulo)
	dw_detalle.SetItem(contador,"nombre_articulo",f_nombre_articulo(codigo_empresa,articulo))
	dw_detalle.SetItem(contador,"calidad",calidad)
	dw_detalle.SetItem(contador,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	dw_detalle.SetItem(contador,"divisa",f_nombre_moneda_abr(divisa))
	dw_detalle.SetItem(contador,"tono",tono)
	dw_detalle.SetItem(contador,"calibre",calibre)
	dw_detalle.SetItem(contador,"tipo_pallet",tipo_pallet)
	dw_detalle.SetItem(contador,"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	dw_detalle.SetItem(contador,"cantidad",cantidad)
	dw_detalle.SetItem(contador,"fecha",fecha)
	dw_detalle.SetItem(contador,"tipo_unidad",tipo_unidad)
	dw_detalle.SetItem(contador,"nombre_tipo_unidad",f_nombre_unidad_abr(tipo_unidad))
   dw_detalle.SetItem(contador,"situacion","")
	dw_detalle.SetItem(contador,"precio",precio)
Next



Sel = " SELECT factura,articulo,calidad,tipo_pallet,tono,calibre,cantidad,ffactura,tipo_unidad,situacion,precio,divisa From venlifac      " + &
      " WHERE  venlifac.empresa  ='"+ STring(codigo_empresa) + "'" + &
		" AND    venlifac.cliente  ='"+ STring(cliente)  + "'" + &
		" AND    venlifac.articulo ='"+ STring(articulo) + "'" +&
		" ORDER BY ffactura desc"

//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
f_filtros(dw)
r1 = dw.RowCount()
For r = 1 To r1
	contador    = contador + 1
	factura     = dw.GetItemNumber(r,"factura")
	articulo    = dw.GetItemString(r,"articulo")
	calidad     = dw.GetItemString(r,"calidad")
	tipo_pallet = dw.GetItemString(r,"tipo_pallet")
	tipo_unidad = dw.GetItemString(r,"tipo_unidad")
	tono        = dw.GetItemNumber(r,"tono")
	calibre     = dw.GetItemNumber(r,"calibre")
	cantidad    = dw.GetItemNumber(r,"cantidad")
	fecha       = dw.GetItemDateTime(r,"ffactura")
	precio      = dw.GetItemNumber(r,"precio")
	divisa      = dw.GetItemString(r,"divisa")
	dw_detalle.InsertRow(contador)
	dw_detalle.SetItem(contador,"factura",factura)
	dw_detalle.SetItem(contador,"articulo",articulo)
	dw_detalle.SetItem(contador,"nombre_articulo",f_nombre_articulo(codigo_empresa,articulo))
	dw_detalle.SetItem(contador,"calidad",calidad)
	dw_detalle.SetItem(contador,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	dw_detalle.SetItem(contador,"divisa",f_nombre_moneda_abr(divisa))
	dw_detalle.SetItem(contador,"tono",tono)
	dw_detalle.SetItem(contador,"calibre",calibre)
	dw_detalle.SetItem(contador,"tipo_pallet",tipo_pallet)
	dw_detalle.SetItem(contador,"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	dw_detalle.SetItem(contador,"cantidad",cantidad)
	dw_detalle.SetItem(contador,"fecha",fecha)
	dw_detalle.SetItem(contador,"tipo_unidad",tipo_unidad)
	dw_detalle.SetItem(contador,"nombre_tipo_unidad",f_nombre_unidad_abr(tipo_unidad))
   dw_detalle.SetItem(contador,"situacion","")
	dw_detalle.SetItem(contador,"precio",precio)
Next

destroy dw
end subroutine

public subroutine f_filtros (datastore dw);string is_filtro=""
String referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad
dec{2}  existencias,disponible,preparado,reservado
Integer tono,calibre
is_filtro = ""
IF Trim(var_envio) <> "" Then
   IF Trim(is_filtro)<>"" Then 
      is_filtro =  is_filtro + " and "
   END IF
   is_filtro=is_filtro + "envio = '" + var_envio + "'"
END IF
IF Trim(uo_calidad.em_codigo.text) <> "" Then
   IF Trim(is_filtro)<>"" Then 
      is_filtro =  is_filtro + " and "
   END IF
   is_filtro=is_filtro + "calidad = '" + uo_calidad.em_codigo.text + "'"
END IF
IF Trim(uo_tipo_pallet.em_codigo.text) <> "" Then
    IF Trim(is_filtro)<> ""  Then
       is_filtro =  is_filtro + " and "
    END IF
    is_filtro= is_filtro + "tipo_pallet = '" + uo_tipo_pallet.em_codigo.text + "'"
END IF
IF Not IsNull(em_tono.text) and Dec(em_tono.text) <>0 Then
    IF Trim(is_filtro) <> ""  Then 
       is_filtro =  is_filtro + " and "
    END IF
    is_filtro=is_filtro + "tono = " + em_tono.text
END IF
IF Not IsNull(em_calibre.text) and Dec(em_calibre.text) <>0 Then
    IF Trim(is_filtro) <> ""  Then
        is_filtro =  is_filtro + " and "
    END IF
    is_filtro=is_filtro + "calibre = " + em_calibre.text
END IF

dw.SetFilter(is_filtro)
dw.Filter()


end subroutine

event open;call super::open;devolver = "N"
This.title = " CONSULTA VENTAS POR ARTICULO CLIENTE"
istr_parametros = Message.PowerObjectParm
IF istr_parametros.i_nargumentos>1 THEN
	f_posicion_inicio(This)
   devolver = "S"
   uo_articulo.em_codigo.text    =   istr_parametros.s_argumentos[2]
   uo_articulo.em_campo.text     =   f_nombre_articulo(codigo_empresa,   uo_articulo.em_codigo.text)
   uo_calidad.em_codigo.text     =   istr_parametros.s_argumentos[3]
	uo_calidad.em_campo.text      =   f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
//   em_tono.text                  =   istr_parametros.s_argumentos[4]
//   em_calibre.text               =   istr_parametros.s_argumentos[5]
   uo_tipo_pallet.em_codigo.text =   istr_parametros.s_argumentos[6]
   uo_tipo_pallet.em_campo.text  =   f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
   uo_cliente.em_codigo.text     =   istr_parametros.s_argumentos[7]
   var_envio                     =   istr_parametros.s_argumentos[8]
	uo_cliente.em_campo.text      =   f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	uo_articulo.enabled           =   FALSE
   uo_articulo.TabOrder          =   0 
   
   f_control()
   
   IF dw_detalle.RowCount() =0 Then
       MessageBox("Articulo sin ventas","No Hay lineas ",Exclamation!, OK!,1)   
       CloseWithReturn(This,-1)
		 Return
   END IF
   Return
  END IF
  f_activar_campo(uo_cliente.em_campo)
end event

on w_con_ventas_articulos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_articulo=create uo_articulo
this.st_4=create st_4
this.uo_cliente=create uo_cliente
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.uo_calidad=create uo_calidad
this.em_tono=create em_tono
this.st_11=create st_11
this.uo_tipo_pallet=create uo_tipo_pallet
this.cb_1=create cb_1
this.em_calibre=create em_calibre
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_articulo
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_7
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.uo_calidad
this.Control[iCurrent+10]=this.em_tono
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.uo_tipo_pallet
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.em_calibre
this.Control[iCurrent+15]=this.dw_detalle
end on

on w_con_ventas_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_articulo)
destroy(this.st_4)
destroy(this.uo_cliente)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.uo_calidad)
destroy(this.em_tono)
destroy(this.st_11)
destroy(this.uo_tipo_pallet)
destroy(this.cb_1)
destroy(this.em_calibre)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ventas_articulos
integer taborder = 80
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ventas_articulos
integer y = 16
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ventas_articulos
integer x = 9
integer y = 8
integer width = 2587
end type

type pb_2 from upb_salir within w_con_ventas_articulos
integer x = 2830
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type uo_articulo from u_em_campo_2 within w_con_ventas_articulos
integer x = 1051
integer y = 208
integer width = 910
integer height = 76
integer taborder = 20
boolean border = true
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_con_ventas_articulos
integer x = 9
integer y = 132
integer width = 1042
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_ventas_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 9
integer y = 208
integer width = 1042
integer height = 76
integer taborder = 10
boolean border = true
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF





end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_con_ventas_articulos
integer x = 1051
integer y = 132
integer width = 910
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_ventas_articulos
integer x = 1961
integer y = 132
integer width = 137
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_ventas_articulos
integer x = 2098
integer y = 132
integer width = 105
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_8 from statictext within w_con_ventas_articulos
integer x = 2203
integer y = 132
integer width = 91
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_calidad from u_em_campo_2 within w_con_ventas_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1961
integer y = 208
integer width = 133
integer height = 76
integer taborder = 30
boolean border = true
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de calidad"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type em_tono from u_em_campo within w_con_ventas_articulos
integer x = 2094
integer y = 208
integer width = 114
integer height = 76
integer taborder = 40
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = ""
end type

type st_11 from statictext within w_con_ventas_articulos
integer x = 2295
integer y = 132
integer width = 146
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_tipo_pallet from u_em_campo_2 within w_con_ventas_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 2299
integer y = 208
integer width = 146
integer height = 76
integer taborder = 60
boolean border = true
end type

event modificado;call super::modificado;uo_tipo_pallet.em_campo.text=f_nombre_pallet(codigo_empresa,uo_tipo_pallet.em_codigo.text)
IF Trim(uo_tipo_pallet.em_campo.text)="" THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then uo_tipo_pallet.em_campo.SetFocus()
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF

end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
ante_articulo = uo_articulo.em_codigo.text
end on

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_ventas_articulos
integer x = 2619
integer y = 204
integer width = 338
integer height = 84
integer taborder = 70
string text = "&Continuar"
end type

event clicked;call super::clicked;f_control()
COMMIT;
end event

type em_calibre from u_em_campo within w_con_ventas_articulos
integer x = 2208
integer y = 208
integer width = 91
integer height = 76
integer taborder = 50
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = "~r"
end type

type dw_detalle from datawindow within w_con_ventas_articulos
integer x = 5
integer y = 296
integer width = 2953
integer height = 3368
string dataobject = "dw_con_ventas_articulo4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

