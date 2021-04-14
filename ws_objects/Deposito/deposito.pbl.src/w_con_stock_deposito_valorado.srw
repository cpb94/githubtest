$PBExportHeader$w_con_stock_deposito_valorado.srw
forward
global type w_con_stock_deposito_valorado from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_deposito_valorado
end type
type dw_1 from u_datawindow_consultas within w_con_stock_deposito_valorado
end type
type em_fechadesde from u_em_campo within w_con_stock_deposito_valorado
end type
type st_7 from statictext within w_con_stock_deposito_valorado
end type
type cb_2 from commandbutton within w_con_stock_deposito_valorado
end type
type st_2 from statictext within w_con_stock_deposito_valorado
end type
type em_tarifa from u_em_campo within w_con_stock_deposito_valorado
end type
type sle_fecha from u_em_campo within w_con_stock_deposito_valorado
end type
type st_nombre_tarifa from statictext within w_con_stock_deposito_valorado
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_valorado
end type
type dw_listado from datawindow within w_con_stock_deposito_valorado
end type
type cbx_ocultar from checkbox within w_con_stock_deposito_valorado
end type
end forward

global type w_con_stock_deposito_valorado from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3346
integer height = 2240
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
st_2 st_2
em_tarifa em_tarifa
sle_fecha sle_fecha
st_nombre_tarifa st_nombre_tarifa
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
cbx_ocultar cbx_ocultar
end type
global w_con_stock_deposito_valorado w_con_stock_deposito_valorado

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
/*
DataStore movimientos
datastore pedidos


if uo_almacen.em_codigo.text <> "" then
	almacen_deposito = uo_almacen.em_codigo.text
else
	almacen_deposito = "%"
end if
*/
data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),em_tarifa.text)
data.SetRedraw(true)
/*
sel = "select articulo,calidad,tonochar,"+&
		"sum(cantidade - cantidads) stock "+&
		"from depmovhis "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   fechmov <= '"+String(Date(em_fechadesde.text),"mm/dd/yyyy")+"' "+&
		"and situacion <> 'A' "+&
		"and almacen like '"+almacen_deposito+"' "+&
		"group by articulo,calidad,tonochar"
movimientos = f_cargar_cursor(sel)		
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
		precio          = f_precio_articulo_venlintarifas_activa(codigo_empresa,em_tarifa.text,articulo,calidad)		
		valor           = stock * precio
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

*/


end subroutine

event open;call super::open;This.title = " CONSULTA STOCK DEPOSITO A FECHA "

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fechadesde.text = String(DateTime(Today()),"dd-mm-yy")
em_tarifa.text     = "5"
em_tarifa.TriggerEvent("Modificado")

f_activar_campo(em_fechadesde)
end event

on w_con_stock_deposito_valorado.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.sle_fecha=create sle_fecha
this.st_nombre_tarifa=create st_nombre_tarifa
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.cbx_ocultar=create cbx_ocultar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_tarifa
this.Control[iCurrent+8]=this.sle_fecha
this.Control[iCurrent+9]=this.st_nombre_tarifa
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.cbx_ocultar
end on

on w_con_stock_deposito_valorado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.sle_fecha)
destroy(this.st_nombre_tarifa)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.cbx_ocultar)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_deposito_valorado
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_deposito_valorado
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_deposito_valorado
integer y = 20
integer width = 3063
integer height = 88
end type

type pb_2 from upb_salir within w_con_stock_deposito_valorado
integer x = 3118
integer y = 8
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

type dw_1 from u_datawindow_consultas within w_con_stock_deposito_valorado
integer x = 23
integer y = 312
integer width = 3246
integer height = 1704
integer taborder = 50
string dataobject = "dw_con_stock_deposito_valorado"
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

event clicked;call super::clicked;//long  ll_fila_actual
//str_parametros valores
//String ls_objeto
//ll_fila_actual = row
//
//
//str_parametros lstr_param
//// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
//// el numero de fila en la Datawindow
//
//ls_objeto = dw_1.GetObjectAtPointer()
//ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
//lstr_param.i_nargumentos    = 2
//lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
//CHOOSE CASE ls_objeto
//  
//CASE 'valor'
//IF ll_fila_actual <> 0 THEN
//  IF dw_1.getitemString(ll_fila_actual,"valor") = "*" Then
//   valores.s_argumentos[1]=dw_1.getitemString(ll_fila_actual,"referencia")
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//   OpenWithParm(w_observaciones_almlinubica,valores)  
//  END IF
//END IF
//
//
//CASE ELSE
////IF ll_fila_actual <> 0  and devolver = "S" THEN
////   valores.s_argumentos[1]=uo_articulo.em_codigo.text
////	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
////	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
////	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
////	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
////	CloseWithReturn(Parent,valores)
////END IF
////
////
//
//END CHOOSE
//
//
//
//
//
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

type em_fechadesde from u_em_campo within w_con_stock_deposito_valorado
integer x = 457
integer y = 140
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_deposito_valorado
integer x = 18
integer y = 140
integer width = 448
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock a Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_deposito_valorado
event clicked pbm_bnclicked
integer x = 2802
integer y = 136
integer width = 297
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string tarifa

if cbx_ocultar.checked then
	dw_1.object.t_precio.visible = false
	dw_1.object.t_valor.visible = false
	dw_1.object.importe_total.visible = false
	dw_1.object.venlintarifas_precio.visible = false
	dw_1.object.suma_importes.visible = false
	dw_1.object.art_codestadistico_g2.visible = false
	dw_1.object.t_g2.visible = false

else
	dw_1.object.t_precio.visible = true
	dw_1.object.t_valor.visible = true
	dw_1.object.importe_total.visible = true
	dw_1.object.venlintarifas_precio.visible = true
	dw_1.object.suma_importes.visible = true
	dw_1.object.art_codestadistico_g2.visible = true
	dw_1.object.t_g2.visible = true
	
end if

Select descripcion
into :tarifa
from ventarifas
where empresa = :codigo_empresa
and codigo = :em_tarifa.text;

dw_1.object.t_tarifa.text = tarifa


if Trim(em_tarifa.text)="" then
	f_mensaje ("Campo obligatorio", "Introduzca la tarifa")
else
	f_cargar(dw_1)
End if


end event

type st_2 from statictext within w_con_stock_deposito_valorado
integer x = 773
integer y = 140
integer width = 206
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_con_stock_deposito_valorado
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 983
integer y = 136
integer width = 187
integer taborder = 20
string facename = "System"
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE TARIFAS"
 ue_datawindow = "dw_ayuda_ventarifas"
 ue_filtro     = ""
// isle_campo    = This
 ue_campo    = This
 
// f_control()
 
 IF istr_parametros.i_nargumentos>1 THEN
	 // sle_valor.text=istr_parametros.s_argumentos[5]	
    // em_articulo.text=istr_parametros.s_argumentos[4]
     em_tarifa.text=istr_parametros.s_argumentos[2]
     sle_fecha.text= istr_parametros.s_argumentos[3]
     f_no_nulo(em_tarifa)
     st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
     f_no_nulo(em_tarifa)     
     st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
	 // f_no_nulo(em_articulo)
    // em_articulo.TriggerEvent("modificado")
    // f_no_nulo(sle_valor)
    // sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
//     IF Trim(sle_valor.text)<>"" and Trim(sle_valor.text)<>"" THEN
//          f_control()
          f_activar_campo(em_tarifa) 
//     END IF
END IF

   
        
end event

event modificado;call super::modificado;
 
st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF


String tarifa,var_empresa,var_codigo
Datetime var_activa
tarifa =em_tarifa.text

SELECT ventarifas.empresa,ventarifas.codigo,ventarifas.activa,ventarifas.moneda
INTO  :var_empresa,:var_codigo,:var_activa,:var_moneda 
FROM   ventarifas  
WHERE (ventarifas.empresa = :codigo_empresa ) AND  
      (ventarifas.codigo  = :tarifa )   
ORDER BY  ventarifas.empresa ASC,ventarifas.codigo ASC;

f_mascara_columna(dw_1,"precio",f_mascara_precios_moneda(var_moneda))
//f_mascara_columna(dw_detalle,"precio",f_mascara_precios_moneda(var_moneda))

Date fecha
fecha = date(var_activa)
sle_fecha.text = String(fecha,"dd-mm-yy")


end event

type sle_fecha from u_em_campo within w_con_stock_deposito_valorado
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1175
integer y = 136
integer width = 311
integer taborder = 0
string facename = "System"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event getfocus;call super::getfocus;//isle_campo        = This
If sle_fecha.text = "00/00/00" Then
  em_tarifa.TriggerEvent("modificado")
END IF




end event

on modificado;call u_em_campo::modificado;Datetime fecha,fecha1
String   tarifa
fecha   = Datetime(Date(sle_fecha.text))
tarifa  = em_tarifa.text

  SELECT venmapatarifas.f_alta  
    INTO :fecha1  
    FROM venmapatarifas  
   WHERE ( venmapatarifas.empresa = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa = :tarifa ) AND  
         ( venmapatarifas.fecha = :fecha )   ;
  IF SQLCA.SQLCODE =100   THEN
      MessageBox("Tarifa no definida en el mapa","No existe la tarifa a esa fecha ",Exclamation!, OK!,1)
      em_tarifa.TriggerEvent("modificado")
      sle_fecha.SetFocus()
      RETURN
  END IF

end on

type st_nombre_tarifa from statictext within w_con_stock_deposito_valorado
integer x = 1490
integer y = 136
integer width = 1253
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_valorado
event clicked pbm_bnclicked
integer x = 3118
integer y = 124
integer taborder = 40
boolean originalsize = false
end type

event clicked;if Trim(em_tarifa.text)="" then
	f_mensaje ("Campo obligatorio", "Introduzca la tarifa")
else
	f_cargar(dw_listado)
	f_imprimir_datawindow(dw_1)
End if
	


end event

type dw_listado from datawindow within w_con_stock_deposito_valorado
boolean visible = false
integer x = 421
integer y = 484
integer width = 494
integer height = 360
boolean bringtotop = true
string dataobject = "report_con_stock_deposito_valorado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_ocultar from checkbox within w_con_stock_deposito_valorado
integer x = 2798
integer y = 220
integer width = 416
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar Valor"
borderstyle borderstyle = styleraised!
end type

