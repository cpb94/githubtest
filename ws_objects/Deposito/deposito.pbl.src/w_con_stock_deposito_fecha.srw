$PBExportHeader$w_con_stock_deposito_fecha.srw
forward
global type w_con_stock_deposito_fecha from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_deposito_fecha
end type
type dw_1 from u_datawindow_consultas within w_con_stock_deposito_fecha
end type
type em_fechadesde from u_em_campo within w_con_stock_deposito_fecha
end type
type st_7 from statictext within w_con_stock_deposito_fecha
end type
type cb_2 from commandbutton within w_con_stock_deposito_fecha
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_fecha
end type
type dw_listado from datawindow within w_con_stock_deposito_fecha
end type
type uo_almacen from u_em_campo_2 within w_con_stock_deposito_fecha
end type
type st_8 from statictext within w_con_stock_deposito_fecha
end type
end forward

global type w_con_stock_deposito_fecha from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 1644
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_almacen uo_almacen
st_8 st_8
end type
global w_con_stock_deposito_fecha w_con_stock_deposito_fecha

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);string sel,articulo,calidad,tono,nombre_articulo,nombre_familia
string nombre_formato,unidad,nombre_unidad,nombre_calidad
string almacen_deposito
long   indice,total,donde
dec    stock,precio,valor
DataStore movimientos
datastore pedidos

if uo_almacen.em_codigo.text <> "" then
	almacen_deposito = uo_almacen.em_codigo.text
else
	almacen_deposito = "%"
end if

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),almacen_deposito)

sel = "select articulo,calidad,tonochar,"+&
		"sum(cantidade - cantidads) stock "+&
		"from depmovhis "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   fechmov <= '"+String(Date(em_fechadesde.text),"mm/dd/yyyy")+"' "+&
		"and situacion <> 'A' "+&
		"and almacen like '"+almacen_deposito+"' "+&
		"group by articulo,calidad,tonochar"

//movimientos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, movimientos)
total = movimientos.rowcount()

for indice = 1 to total
	stock = movimientos.object.stock[indice]
	if stock <> 0 then
		articulo = movimientos.object.articulo[indice]
		calidad  = movimientos.object.calidad[indice]
		tono     = movimientos.object.tonochar[indice] 
		nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
		nombre_calidad  = f_nombre_calidad_abr(codigo_empresa,calidad)
		nombre_familia  = f_nombre_familia(codigo_empresa,f_familia_articulo(codigo_empresa,articulo))
		nombre_formato  = f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,articulo))
		unidad          = f_unidad_articulo(codigo_empresa,articulo)
		nombre_unidad   = f_nombre_unidad_abr(unidad)
		//precio          = f_precio_articulo_venlintarifas_activa(codigo_empresa,em_tarifa.text,articulo,calidad)		
		//valor           = stock * precio
		donde           = data.insertrow(0)
		data.object.articulo[donde]        = articulo
		data.object.nombre_articulo[donde] = nombre_articulo
		data.object.nombre_familia[donde]  = nombre_familia
		data.object.nombre_formato[donde]  = nombre_formato
		data.object.calidad[donde]         = calidad
		data.object.nombre_calidad[donde]  = nombre_calidad
		data.object.unidad[donde]          = unidad
		data.object.nombre_unidad[donde]   = nombre_unidad
		data.object.tono[donde]            = tono
		data.object.stock[donde]           = stock
		data.object.pendiente[donde]       = 0
		data.object.precio[donde]          = precio
		data.object.valor[donde]           = valor		
	end if
	f_mensaje_proceso("Procesando",indice,total)
next	
	
data.sort()		
data.GroupCalc()
data.SetRedraw(TRUE)		

destroy movimientos
destroy pedidos




end subroutine

event open;call super::open;This.title = " CONSULTA STOCK DEPOSITO A FECHA "

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fechadesde.text = String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
end event

on w_con_stock_deposito_fecha.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_almacen=create uo_almacen
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_almacen
this.Control[iCurrent+9]=this.st_8
end on

on w_con_stock_deposito_fecha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_almacen)
destroy(this.st_8)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_deposito_fecha
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_deposito_fecha
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_deposito_fecha
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_stock_deposito_fecha
integer x = 2747
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_stock_deposito_fecha
integer y = 240
integer width = 2871
integer height = 1180
integer taborder = 50
string dataobject = "dw_con_stock_deposito_fecha"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"codigo_tipo_pallet"))
//
//if dw_1.Rowcount()<>0 then 
//   dw_1.SetRow(1)
//   dw_1.SelectRow(1,true)
//end if
end event

event clicked;call super::clicked;ue_marca_linea = true
end event

event rowfocuschanged;call super::rowfocuschanged;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"tipo_pallet"))
end event

event tecla_enter;call super::tecla_enter;//long  ll_fila_actual
//str_parametros valores
//ll_fila_actual = dw_1.GetRow()
//IF ll_fila_actual <> 0  and devolver = "S" THEN
//   valores.s_argumentos[1]=uo_articulo.em_codigo.text
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
//	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
//	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
//	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//	CloseWithReturn(Parent,valores)
//END IF
end event

event key;call super::key;//contro = "S"
end event

type em_fechadesde from u_em_campo within w_con_stock_deposito_fecha
integer x = 416
integer y = 140
integer width = 311
integer height = 80
integer taborder = 10
fontcharset fontcharset = ansi!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_deposito_fecha
integer x = 32
integer y = 140
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock a Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_deposito_fecha
event clicked pbm_bnclicked
integer x = 2382
integer y = 132
integer width = 361
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
string text = "Consulta"
end type

event clicked;
f_cargar(dw_1)



end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_fecha
event clicked pbm_bnclicked
integer x = 2743
integer y = 132
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean originalsize = false
end type

event clicked;
f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

	


end event

type dw_listado from datawindow within w_con_stock_deposito_fecha
boolean visible = false
integer x = 421
integer y = 484
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "report_con_stock_deposito_fecha"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_almacen from u_em_campo_2 within w_con_stock_deposito_fecha
event destroy ( )
integer x = 978
integer y = 140
integer width = 1298
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_almacen.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_depalmacen(codigo_empresa,this.em_codigo.text)
If Trim(this.em_campo.text) = "" then
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_depalmacenes"
ue_titulo     = "AYUDA SELECCION DE ALMACENES"
ue_filtro     = ""

end event

type st_8 from statictext within w_con_stock_deposito_fecha
integer x = 745
integer y = 144
integer width = 233
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Deposito:"
boolean focusrectangle = false
end type

