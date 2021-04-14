$PBExportHeader$w_con_stock_obsoleto.srw
forward
global type w_con_stock_obsoleto from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_obsoleto
end type
type dw_1 from u_datawindow_consultas within w_con_stock_obsoleto
end type
type em_fechadesde from u_em_campo within w_con_stock_obsoleto
end type
type st_7 from statictext within w_con_stock_obsoleto
end type
type cb_2 from commandbutton within w_con_stock_obsoleto
end type
type st_2 from statictext within w_con_stock_obsoleto
end type
type em_tarifa from u_em_campo within w_con_stock_obsoleto
end type
type sle_fecha from u_em_campo within w_con_stock_obsoleto
end type
type st_nombre_tarifa from statictext within w_con_stock_obsoleto
end type
type dw_fechas from datawindow within w_con_stock_obsoleto
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_obsoleto
end type
type uo_cliente from u_em_campo_2 within w_con_stock_obsoleto
end type
type gb_4 from groupbox within w_con_stock_obsoleto
end type
end forward

global type w_con_stock_obsoleto from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3506
integer height = 3108
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
dw_fechas dw_fechas
pb_imprimir_preli pb_imprimir_preli
uo_cliente uo_cliente
gb_4 gb_4
end type
global w_con_stock_obsoleto w_con_stock_obsoleto

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_modificacion_art ()
end prototypes

public subroutine f_control ();String  referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad
dec{2}  existencias,disponible,preparado,reservado
Integer tono,calibre,x1

//dw_1.SetRedraw(False)
//dw_fabricar.SetRedraw(False)
//dw_recibir.SetRedraw(False)
//dw_detalle.SetRedraw(False)
//
//IF dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text) = 0 Then 
//	dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//	dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//	dw_detalle.reset()
//	dw_1.SetRedraw(True)
//	dw_fabricar.SetRedraw(True)
//	dw_recibir.SetRedraw(True)											  
//	Return
//END IF
//
//For x1 = 1 To dw_1.RowCount()
//  referencia  = dw_1.GetItemString(x1,"referencia")
//  tipo_pallet = dw_1.GetItemString(x1,"tipo_pallet")
//  existencias = dw_1.GetItemNumber(x1,"stock")
//  calidad=f_referencia_codcalidad(referencia)
//  nombre_calidad    =f_nombre_calidad_abr(codigo_empresa,calidad)
//  nombre_tipo_pallet=f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
//  tono=f_referencia_tono(referencia)
//  calibre=f_referencia_calibre(referencia)
//  dw_1.SetItem(x1,"codigo_calidad",calidad)
//  dw_1.SetItem(x1,"calidad",nombre_calidad)
//  dw_1.SetItem(x1,"tono",tono)
//  dw_1.SetItem(x1,"calibre",calibre)
//  dw_1.SetItem(x1,"nombre_tipo_pallet",nombre_tipo_pallet)
//  reservado  = f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  preparado  = f_preparado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  disponible = existencias - reservado - preparado
//  dw_1.SetItem(x1,"disponible",disponible)
//  dw_1.SetItem(x1,"reservado",reservado)
//  dw_1.SetItem(x1,"preparado",preparado)
//  IF f_observ_almlinubica(codigo_empresa,referencia,tipo_pallet)  Then
//   dw_1.SetItem(x1,"valor","*")
//	END IF
//End For
//dw_1.SetRedraw(True)
//dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//
//Dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"tipo_pallet"))
//dw_fabricar.SetRedraw(True)
//dw_recibir.SetRedraw(True)											  
//dw_detalle.SetRedraw(True)
//											  
//
//
end subroutine

public function boolean f_modificacion_art ();
String formato,tipo_unidad,descripcion,articulo,mascara
Dec{4}  metros_caja,piezascaja,peso
//articulo = uo_articulo.em_codigo.text
//Select descripcion,formato,unidad,metroscaja,piezascaja,pesopieza
//Into   :descripcion,:formato,:tipo_unidad,:metros_caja,:piezascaja,:peso
//From   articulos
//Where  articulos.empresa = :codigo_empresa
//And    articulos.codigo  = :articulo;
//
//uo_articulo.em_campo.text=descripcion
//IF Trim(uo_articulo.em_campo.text)="" THEN 
// IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
// uo_articulo.em_campo.text=""
// uo_articulo.em_codigo.text=""
// return TRUE
//END IF
//mascara = f_mascara_unidad(tipo_unidad)
//f_mascara_columna(dw_1,"disponible",mascara)
//f_mascara_columna(dw_1,"preparado",mascara)
//f_mascara_columna(dw_1,"reservado",mascara)
//IF Trim(uo_articulo.em_codigo.text)<>"" Then f_control()
//st_tipo_unidad.text  = f_nombre_unidad(tipo_unidad)
//st_tipo_formato.text = f_nombre_formato_abr(codigo_empresa,formato)
//st_metros.text       = string(metros_caja,"###,##0.00")
//st_piezas.text       = string(piezascaja,"###,##0")
//st_peso.text         = string(peso,"###.#00")
Return TRUE

end function

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_fechas.SetTransObject(sqlca)
This.title = " CONSULTA STOCK OBSOLETO "
//istr_parametros = Message.PowerObjectParm

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")
f_activar_campo(em_fechadesde)
end event

on w_con_stock_obsoleto.create
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
this.dw_fechas=create dw_fechas
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_cliente=create uo_cliente
this.gb_4=create gb_4
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
this.Control[iCurrent+10]=this.dw_fechas
this.Control[iCurrent+11]=this.pb_imprimir_preli
this.Control[iCurrent+12]=this.uo_cliente
this.Control[iCurrent+13]=this.gb_4
end on

on w_con_stock_obsoleto.destroy
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
destroy(this.dw_fechas)
destroy(this.pb_imprimir_preli)
destroy(this.uo_cliente)
destroy(this.gb_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_obsoleto
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_obsoleto
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_obsoleto
integer y = 20
integer width = 3209
integer height = 92
integer textsize = -12
end type

type pb_2 from upb_salir within w_con_stock_obsoleto
integer x = 3255
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

type dw_1 from u_datawindow_consultas within w_con_stock_obsoleto
integer x = 14
integer y = 376
integer width = 3424
integer height = 2504
integer taborder = 0
string dataobject = "dw_con_stock_tarifa_cliente_nuevo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
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

event clicked;call super::clicked;long  ll_fila_actual
str_parametros valores
String ls_objeto
ll_fila_actual = row


str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE ls_objeto
  
CASE 'valor'
IF ll_fila_actual <> 0 THEN
  IF dw_1.getitemString(ll_fila_actual,"valor") = "*" Then
   valores.s_argumentos[1]=dw_1.getitemString(ll_fila_actual,"referencia")
	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
   OpenWithParm(w_observaciones_almlinubica,valores)  
  END IF
END IF


CASE ELSE
//IF ll_fila_actual <> 0  and devolver = "S" THEN
//   valores.s_argumentos[1]=uo_articulo.em_codigo.text
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
//	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
//	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
//	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//	CloseWithReturn(Parent,valores)
//END IF
//
//

END CHOOSE





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

type em_fechadesde from u_em_campo within w_con_stock_obsoleto
integer x = 942
integer y = 136
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_obsoleto
integer x = 37
integer y = 140
integer width = 901
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock sin movimientos desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_obsoleto
event clicked pbm_bnclicked
integer x = 2697
integer y = 132
integer width = 279
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string articulo,calidad,tarifa, cliente
dec    precio
Dec{0} li_stock,cont,pagina
Dec{2} li_subtotal
datetime fecha,fecha_tarifa


dw_1.SetTransObject(SQLCA)

fecha        = DateTime(Date(em_fechadesde.text))
tarifa       = em_tarifa.text
fecha_tarifa = DateTime(Date(sle_fecha.text))


		
if Trim(em_tarifa.text)="" then
	f_mensaje ("Campo obligatorio", "Introduzca la tarifa")
else
	dw_1.Reset()
	dw_1.SetRedraw(FALSE)
	
	f_mascara_columna(dw_1,"totalglobal",f_mascara_moneda(f_moneda_ventarifas( codigo_empresa , tarifa )) )	
	f_mascara_columna(dw_1,"cimporte",f_mascara_moneda(f_moneda_ventarifas( codigo_empresa , tarifa )) )


	if uo_cliente.em_codigo.text <> '' then
		cliente = uo_cliente.em_codigo.text 
	else
		cliente = '%'
	end if
	dw_1.Retrieve(codigo_empresa,tarifa,tarifa,fecha,fecha, cliente)


	dw_1.setfilter("")
	dw_1.filter()
		
	dw_1.GroupCalc()
	dw_1.SetRedraw(TRUE)
end if
		

end event

type st_2 from statictext within w_con_stock_obsoleto
integer x = 1271
integer y = 140
integer width = 215
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

type em_tarifa from u_em_campo within w_con_stock_obsoleto
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1490
integer y = 136
integer width = 201
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

dw_fechas.Retrieve(codigo_empresa,em_tarifa.text)
//IF istr_parametros.i_nargumentos<=1 Then
//dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
//END IF



end event

type sle_fecha from u_em_campo within w_con_stock_obsoleto
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1705
integer y = 136
integer width = 311
integer taborder = 30
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

type st_nombre_tarifa from statictext within w_con_stock_obsoleto
integer x = 2016
integer y = 132
integer width = 681
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_con_stock_obsoleto
event clicked pbm_dwnlbuttonclk
integer x = 2990
integer y = 136
integer width = 448
integer height = 224
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row =0 Then Return
//IF cb_insertar.enabled=TRUE THEN Return
sle_fecha.text  = String(Date(This.GetItemDateTime(row,"fecha")))
//f_control()
//dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
//f_activar_campo(em_articulo)
end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_obsoleto
event clicked pbm_bnclicked
integer x = 2862
integer y = 244
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type uo_cliente from u_em_campo_2 within w_con_stock_obsoleto
event destroy ( )
integer x = 69
integer y = 272
integer width = 1929
integer height = 80
integer taborder = 50
boolean bringtotop = true
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

type gb_4 from groupbox within w_con_stock_obsoleto
integer x = 46
integer y = 220
integer width = 1984
integer height = 152
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

