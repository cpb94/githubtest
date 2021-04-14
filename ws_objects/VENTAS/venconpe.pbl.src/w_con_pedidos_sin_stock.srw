$PBExportHeader$w_con_pedidos_sin_stock.srw
forward
global type w_con_pedidos_sin_stock from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_sin_stock
end type
type dw_listado from datawindow within w_con_pedidos_sin_stock
end type
type cb_1 from u_boton within w_con_pedidos_sin_stock
end type
type pb_2 from upb_imprimir within w_con_pedidos_sin_stock
end type
type dw_detalle from datawindow within w_con_pedidos_sin_stock
end type
end forward

global type w_con_pedidos_sin_stock from w_int_con_empresa
integer width = 2903
integer height = 1668
pb_1 pb_1
dw_listado dw_listado
cb_1 cb_1
pb_2 pb_2
dw_detalle dw_detalle
end type
global w_con_pedidos_sin_stock w_con_pedidos_sin_stock

type variables
string filtro
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer   r ,r1
String    tono,selec,articulo,calidad,tipo_pallet,familia,formato,caja
Integer   calibre
Dec{2} cantidad,stock
datastore dw_comodin

selec = " Select familia,formato,articulo,calidad,tonochar,calibre,tipo_pallet,caja,Sum(cantidad) cantidad From venliped" + &
        " Where  empresa = '1'And situacion <> 'F'  "+ &
		  " Group by familia,formato,articulo,calidad,tonochar,calibre,tipo_pallet,caja" + &
  		  " Order by familia,formato,articulo,calidad,tonochar,calibre,tipo_pallet,caja" 
//dw_comodin = f_cargar_cursor(selec)
f_cargar_cursor_nuevo(selec, dw_comodin)

dw_comodin.Retrieve()
r = 0
dw_data.SetRedraw(FALSE)
For r = 1 To dw_comodin.RowCount()
	familia = dw_comodin.object.familia[r]
	formato = dw_comodin.object.formato[r]
	cantidad = dw_comodin.object.cantidad[r]
   articulo = dw_comodin.object.articulo[r]
	calidad  = dw_comodin.object.calidad[r]
	tipo_pallet  = dw_comodin.object.tipo_pallet[r]
	caja     = dw_comodin.object.caja[r]
	tono     = dw_comodin.object.tonochar[r]
	calibre  = dw_comodin.object.calibre[r]
	stock    = f_stock_referencia_tipo_pallet_caja(codigo_empresa,f_componer_ref(articulo,calidad,tono,calibre),tipo_pallet,caja) 
	IF stock < cantidad  Then
		r1 = r1 +1 
		dw_data.InsertRow(r1)
		dw_data.object.familia[r1] = familia 
		dw_data.object.formato[r1] = formato
		dw_data.object.empresa[r1] = codigo_empresa
		dw_data.object.articulo[r1] = articulo
		dw_data.object.calidad[r1] = calidad
		dw_data.object.tono[r1] = tono
		dw_data.object.calibre[r1] = calibre
		dw_data.object.tipo_pallet[r1] = tipo_pallet
		dw_data.object.caja[r1] = caja
		dw_data.object.reservado[r1] = cantidad
		dw_data.object.stock[r1] = stock
	END IF
	f_contador_procesos(r,dw_comodin.RowCount())
Next
dw_data.SetRedraw(TRUE)

destroy dw_comodin
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por cliente sin Stock"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

on w_con_pedidos_sin_stock.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_detalle
end on

on w_con_pedidos_sin_stock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_sin_stock
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_sin_stock
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_sin_stock
integer x = 9
integer y = 16
integer width = 2693
integer height = 104
end type

type pb_1 from upb_salir within w_con_pedidos_sin_stock
integer x = 2729
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type dw_listado from datawindow within w_con_pedidos_sin_stock
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_pedidos_sin_stock"
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_pedidos_sin_stock
integer x = 18
integer y = 148
integer height = 92
integer taborder = 10
string text = "&Continuar"
end type

event clicked;call super::clicked;f_cargar(dw_detalle)
end event

type pb_2 from upb_imprimir within w_con_pedidos_sin_stock
integer x = 434
integer y = 148
integer width = 105
integer height = 88
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_detalle from datawindow within w_con_pedidos_sin_stock
integer x = 5
integer y = 248
integer width = 2825
integer height = 1168
integer taborder = 30
string dataobject = "dw_con_pedidos_sin_stock"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

