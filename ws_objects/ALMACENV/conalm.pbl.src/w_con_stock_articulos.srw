$PBExportHeader$w_con_stock_articulos.srw
$PBExportComments$Consulta del stock de un artículo
forward
global type w_con_stock_articulos from w_int_con_empresa
end type
type st_3 from statictext within w_con_stock_articulos
end type
type pb_2 from upb_salir within w_con_stock_articulos
end type
type dw_1 from u_datawindow_consultas within w_con_stock_articulos
end type
type dw_detalle from datawindow within w_con_stock_articulos
end type
type st_1 from statictext within w_con_stock_articulos
end type
type st_2 from statictext within w_con_stock_articulos
end type
type dw_recibir from datawindow within w_con_stock_articulos
end type
type st_tipo_unidad from statictext within w_con_stock_articulos
end type
type st_tipo_formato from statictext within w_con_stock_articulos
end type
type gb_7 from groupbox within w_con_stock_articulos
end type
type gb_6 from groupbox within w_con_stock_articulos
end type
type gb_1 from groupbox within w_con_stock_articulos
end type
type gb_2 from groupbox within w_con_stock_articulos
end type
type st_metros from statictext within w_con_stock_articulos
end type
type gb_3 from groupbox within w_con_stock_articulos
end type
type st_piezas from statictext within w_con_stock_articulos
end type
type st_4 from statictext within w_con_stock_articulos
end type
type gb_4 from groupbox within w_con_stock_articulos
end type
type st_5 from statictext within w_con_stock_articulos
end type
type st_peso from statictext within w_con_stock_articulos
end type
type gb_5 from groupbox within w_con_stock_articulos
end type
type st_6 from statictext within w_con_stock_articulos
end type
type st_7 from statictext within w_con_stock_articulos
end type
type dw_fabricar from datawindow within w_con_stock_articulos
end type
type dw_misma_descrip from u_datawindow_consultas within w_con_stock_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_stock_articulos
end type
type cb_reserva_linea from u_boton within w_con_stock_articulos
end type
type cb_reserva_general from u_boton within w_con_stock_articulos
end type
type cb_ventas from u_boton within w_con_stock_articulos
end type
type cb_bases_decorados from u_boton within w_con_stock_articulos
end type
end forward

global type w_con_stock_articulos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3342
integer height = 1756
string title = "Consulta de Movimientos"
st_3 st_3
pb_2 pb_2
dw_1 dw_1
dw_detalle dw_detalle
st_1 st_1
st_2 st_2
dw_recibir dw_recibir
st_tipo_unidad st_tipo_unidad
st_tipo_formato st_tipo_formato
gb_7 gb_7
gb_6 gb_6
gb_1 gb_1
gb_2 gb_2
st_metros st_metros
gb_3 gb_3
st_piezas st_piezas
st_4 st_4
gb_4 gb_4
st_5 st_5
st_peso st_peso
gb_5 gb_5
st_6 st_6
st_7 st_7
dw_fabricar dw_fabricar
dw_misma_descrip dw_misma_descrip
uo_articulo uo_articulo
cb_reserva_linea cb_reserva_linea
cb_reserva_general cb_reserva_general
cb_ventas cb_ventas
cb_bases_decorados cb_bases_decorados
end type
global w_con_stock_articulos w_con_stock_articulos

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_modificacion_art ()
end prototypes

public subroutine f_control ();String  referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad,caja,tono,articulo
dec{2}  existencias,disponible,preparado,reservado
Integer calibre,x1

dw_1.SetRedraw(False)
dw_fabricar.SetRedraw(False)
dw_recibir.SetRedraw(False)
dw_detalle.SetRedraw(False)

dw_1.SetFilter("")											  
dw_1.Filter()

IF dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text) = 0 Then 
	dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
	dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
	dw_detalle.reset()
	dw_1.SetRedraw(True)
	dw_fabricar.SetRedraw(True)
	dw_recibir.SetRedraw(True)											  
	Return
END IF

For x1 = 1 To dw_1.RowCount()
  articulo    = dw_1.GetItemString(x1,"articulo")
  existencias = dw_1.GetItemNumber(x1,"stock")
  calidad	  = dw_1.GetItemString(x1,"calidad")
  nombre_calidad     = f_nombre_calidad_abr(codigo_empresa,calidad)
  tono		         = dw_1.GetItemString(x1,"tonochar")
  calibre            = dw_1.GetItemNumber(x1,"calibre")
  dw_1.SetItem(x1,"codigo_calidad",calidad)
  dw_1.SetItem(x1,"calidadx",nombre_calidad)
  dw_1.SetItem(x1,"tonocharx",tono)
  dw_1.SetItem(x1,"calibre",calibre)
  reservado  = f_reservado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
  preparado  = f_preparado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
  disponible = existencias - reservado - preparado
  dw_1.SetItem(x1,"disponible",disponible)
  dw_1.SetItem(x1,"reservado",reservado)
  dw_1.SetItem(x1,"preparado",preparado)
//  IF f_observ_almlinubica(codigo_empresa,referencia,tipo_pallet)  Then
//   	dw_1.SetItem(x1,"valor","*")
//  END IF
End For

//***
//dw_1.SetFilter("disponible <> 0")											  
//dw_1.Filter()
//***

dw_1.SetRedraw(True)
dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
dw_detalle.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
                 
dw_fabricar.SetRedraw(True)
dw_recibir.SetRedraw(True)											  
dw_detalle.SetRedraw(True)



end subroutine

public function boolean f_modificacion_art ();String formato,tipo_unidad,descripcion,articulo,mascara

//Dec{4}  metros_caja,piezascaja,peso
articulo = uo_articulo.em_codigo.text

Select descripcion,formato,unidad//,metroscaja,piezascaja,pesopieza
Into   :descripcion,:formato,:tipo_unidad//,:metros_caja,:piezascaja,:peso
From   articulos
Where  articulos.empresa = :codigo_empresa
And    articulos.codigo  = :articulo;

uo_articulo.em_campo.text=descripcion

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 return TRUE
END IF
mascara = f_mascara_unidad(tipo_unidad)
f_mascara_columna(dw_1,"disponible",mascara)
f_mascara_columna(dw_1,"preparado",mascara)
f_mascara_columna(dw_1,"reservado",mascara)
f_mascara_columna(dw_1,"totcaldis",mascara)
f_mascara_columna(dw_1,"totcalpre",mascara)
f_mascara_columna(dw_1,"totcalres",mascara)
f_mascara_columna(dw_1,"totdis",mascara)
f_mascara_columna(dw_1,"totpre",mascara)
f_mascara_columna(dw_1,"totres",mascara)

IF Trim(uo_articulo.em_codigo.text)<>"" Then f_control()
st_tipo_unidad.text  = f_nombre_unidad(tipo_unidad)
st_tipo_formato.text = f_nombre_formato_abr(codigo_empresa,formato)
//st_metros.text       = string(metros_caja,"###,##0.00")
//st_piezas.text       = string(piezascaja,"###,##0")
//st_peso.text         = string(peso,"###.#00")

//String nuestra
//nuestra = f_ntra_descripcion_articulo(codigo_empresa, articulo)
//if IsNull(nuestra) then nuestra = ""
//if nuestra <> "" then
//	dw_misma_descrip.reset()
//	dw_misma_descrip.retrieve (codigo_empresa,nuestra)
//	if dw_misma_descrip.RowCount() > 1 then
//		dw_misma_descrip.visible = true
//	else
//		dw_misma_descrip.reset()
//	end if
//	Return TRUE
//end if
RETURN TRUE




end function

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_detalle.SetTransObject(sqlca)
dw_fabricar.SetTransObject(sqlca)
dw_recibir.SetTransObject(sqlca)
dw_misma_descrip.SetTransObject(sqlca)

devolver = "N"
This.title = " CONSULTA STOCKS POR ARTICULOS "
istr_parametros = Message.PowerObjectParm
cb_ventas.visible = FALSE
cb_bases_decorados.visible = FALSE

IF istr_parametros.i_nargumentos>1 THEN
	f_posicion_inicio(This)
   devolver = "S"
   cb_ventas.visible = TRUE
	cb_bases_decorados.visible = TRUE
	uo_articulo.em_codigo.text = istr_parametros.s_argumentos[2]
   uo_articulo.em_campo.text  = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
   var_calidad     =  istr_parametros.s_argumentos[3]
   var_tono        =   Trim(istr_parametros.s_argumentos[4])
   var_calibre     =   Integer(istr_parametros.s_argumentos[5])
   var_tipo_pallet =   istr_parametros.s_argumentos[6]
	var_caja        =   istr_parametros.s_argumentos[7]
   var_cliente     =   istr_parametros.s_argumentos[8]
	var_envio     =   istr_parametros.s_argumentos[9]
   uo_articulo.enabled = FALSE
   uo_articulo.TabOrder =0 

	f_modificacion_art()
    IF dw_1.RowCount() =0 Then
      IF dw_recibir.RowCount() =0 Then
       MessageBox("Articulo Sin Stock","No Hay Stock!!",Exclamation!, OK!,1)   
       CloseWithReturn(This,-1)
		 Return
      END IF
   END IF
    dw_1.Setfocus()
   Return
  END IF
  f_activar_campo(uo_articulo.em_campo)
end event

on w_con_stock_articulos.create
int iCurrent
call super::create
this.st_3=create st_3
this.pb_2=create pb_2
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
this.st_1=create st_1
this.st_2=create st_2
this.dw_recibir=create dw_recibir
this.st_tipo_unidad=create st_tipo_unidad
this.st_tipo_formato=create st_tipo_formato
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_metros=create st_metros
this.gb_3=create gb_3
this.st_piezas=create st_piezas
this.st_4=create st_4
this.gb_4=create gb_4
this.st_5=create st_5
this.st_peso=create st_peso
this.gb_5=create gb_5
this.st_6=create st_6
this.st_7=create st_7
this.dw_fabricar=create dw_fabricar
this.dw_misma_descrip=create dw_misma_descrip
this.uo_articulo=create uo_articulo
this.cb_reserva_linea=create cb_reserva_linea
this.cb_reserva_general=create cb_reserva_general
this.cb_ventas=create cb_ventas
this.cb_bases_decorados=create cb_bases_decorados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_recibir
this.Control[iCurrent+8]=this.st_tipo_unidad
this.Control[iCurrent+9]=this.st_tipo_formato
this.Control[iCurrent+10]=this.gb_7
this.Control[iCurrent+11]=this.gb_6
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.st_metros
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.st_piezas
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.st_peso
this.Control[iCurrent+21]=this.gb_5
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.st_7
this.Control[iCurrent+24]=this.dw_fabricar
this.Control[iCurrent+25]=this.dw_misma_descrip
this.Control[iCurrent+26]=this.uo_articulo
this.Control[iCurrent+27]=this.cb_reserva_linea
this.Control[iCurrent+28]=this.cb_reserva_general
this.Control[iCurrent+29]=this.cb_ventas
this.Control[iCurrent+30]=this.cb_bases_decorados
end on

on w_con_stock_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.dw_detalle)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_recibir)
destroy(this.st_tipo_unidad)
destroy(this.st_tipo_formato)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_metros)
destroy(this.gb_3)
destroy(this.st_piezas)
destroy(this.st_4)
destroy(this.gb_4)
destroy(this.st_5)
destroy(this.st_peso)
destroy(this.gb_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.dw_fabricar)
destroy(this.dw_misma_descrip)
destroy(this.uo_articulo)
destroy(this.cb_reserva_linea)
destroy(this.cb_reserva_general)
destroy(this.cb_ventas)
destroy(this.cb_bases_decorados)
end on

event activate;call super::activate;w_con_stock_articulos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_articulos
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_articulos
integer y = 20
integer width = 2587
integer height = 92
end type

type st_3 from statictext within w_con_stock_articulos
integer x = 91
integer y = 160
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_stock_articulos
integer x = 2747
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
string picturename = "exit!"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_stock_articulos
integer x = 14
integer y = 420
integer width = 1495
integer height = 732
integer taborder = 60
string dataobject = "dw_con_stock_articulos2"
boolean vscrollbar = true
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
//IF ll_fila_actual <> 0  then
//		Dec{4}  metroscaja,piezascaja,pesocaja
//		String v_caja
//		
//		v_caja = dw_1.GetItemString(row,"caja")
//		
//		Select metroscaja,piezascaja,pesocaja
//		Into   :metroscaja,:piezascaja,:pesocaja
//		From   almartcajas
//		Where  almartcajas.empresa  = :codigo_empresa
//		And    almartcajas.articulo = :uo_articulo.em_codigo.text
//		And    almartcajas.caja     = :var_caja ;
//		
//		st_metros.text       = string(metroscaja,"###,##0.00")
//		st_piezas.text       = string(piezascaja,"###,##0")
//		st_peso.text         = string(pesocaja,"###.#00")
//		
//end if
//
//
//END CHOOSE





end event

event rowfocuschanged;call super::rowfocuschanged;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"tipo_pallet"),&
//						  dw_1.GetItemString(dw_1.GetRow(),"caja"))
end event

event tecla_enter;//long  ll_fila_actual
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

event doubleclicked;//long ll_fila_actual
//str_parametros valores
//ll_fila_actual=row
//if devolver = "S" THEN
//	valores.s_argumentos[1]=uo_articulo.em_codigo.text
//	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"codigo_calidad")
//	valores.s_argumentos[3]=dw_1.getitemString(ll_fila_actual,"tonochar")
//	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
//	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
//	valores.s_argumentos[6]=dw_1.getitemString(ll_fila_actual,"caja")
//	CloseWithReturn(Parent,valores)
//end if

end event

type dw_detalle from datawindow within w_con_stock_articulos
integer x = 1527
integer y = 420
integer width = 1184
integer height = 732
boolean bringtotop = true
string dataobject = "dw_con_stock_articulos3"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if row=0 then return
str_parametros valores
CHOOSE CASE f_objeto_datawindow(This) 
   CASE 'marca'
    IF dw_detalle.getitemString(row,"marca") = "*" Then
      valores.s_argumentos[1]=dw_detalle.getitemString(row,"referencia")
      valores.s_argumentos[2]=dw_detalle.getitemString(row,"tipo_pallet")
		valores.s_argumentos[3]=dw_detalle.getitemString(row,"almlinubica_caja")
      OpenWithParm(w_observaciones_almlinubica,valores)
    END IF
END CHOOSE

end event

type st_1 from statictext within w_con_stock_articulos
integer x = 1673
integer y = 1164
integer width = 864
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "  Material a fabricar"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_stock_articulos
integer x = 14
integer y = 1164
integer width = 1659
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "  Material a recibir"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_recibir from datawindow within w_con_stock_articulos
integer x = 9
integer y = 1236
integer width = 1659
integer height = 292
boolean bringtotop = true
string dataobject = "dw_con_stock_articulos5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_tipo_unidad from statictext within w_con_stock_articulos
integer x = 411
integer y = 288
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type st_tipo_formato from statictext within w_con_stock_articulos
integer x = 832
integer y = 288
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_7 from groupbox within w_con_stock_articulos
boolean visible = false
integer x = 2729
integer y = 648
integer width = 512
integer height = 228
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_6 from groupbox within w_con_stock_articulos
integer x = 2729
integer y = 420
integer width = 512
integer height = 220
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_stock_articulos
integer x = 384
integer y = 248
integer width = 434
integer height = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type gb_2 from groupbox within w_con_stock_articulos
integer x = 809
integer y = 248
integer width = 379
integer height = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_metros from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1371
integer y = 288
integer width = 197
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_stock_articulos
boolean visible = false
integer x = 1362
integer y = 248
integer width = 279
integer height = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type st_piezas from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1650
integer y = 288
integer width = 128
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1778
integer y = 304
integer width = 78
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Pz"
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_con_stock_articulos
boolean visible = false
integer x = 1627
integer y = 248
integer width = 261
integer height = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
end type

type st_5 from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1568
integer y = 304
integer width = 64
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "m."
boolean focusrectangle = false
end type

type st_peso from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1902
integer y = 288
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_con_stock_articulos
boolean visible = false
integer x = 1893
integer y = 248
integer width = 357
integer height = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
end type

type st_6 from statictext within w_con_stock_articulos
boolean visible = false
integer x = 1211
integer y = 284
integer width = 151
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Caja"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_stock_articulos
boolean visible = false
integer x = 2075
integer y = 304
integer width = 165
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Kg/Caja"
boolean focusrectangle = false
end type

type dw_fabricar from datawindow within w_con_stock_articulos
integer x = 1673
integer y = 1236
integer width = 864
integer height = 292
boolean bringtotop = true
string dataobject = "dw_con_stock_articulos4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_misma_descrip from u_datawindow_consultas within w_con_stock_articulos
boolean visible = false
integer x = 837
integer y = 264
integer width = 1806
integer height = 624
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_articulos_ntra_descrip"
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if f_objeto_datawindow(This) = "pb_salir" then
	This.visible = false
end if
end event

event doubleclicked;String art

art = This.GetItemString(This.GetRow(),"codigo")

uo_articulo.em_codigo.text = art
uo_articulo.em_campo.text  = f_nombre_articulo(codigo_empresa, art)

f_modificacion_art()

This.visible = false
This.reset()
end event

type uo_articulo from u_em_campo_2 within w_con_stock_articulos
event destroy ( )
integer x = 389
integer y = 148
integer width = 2231
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;dw_detalle.reset()
f_modificacion_art() 
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

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""

end event

type cb_reserva_linea from u_boton within w_con_stock_articulos
integer x = 2747
integer y = 460
integer width = 480
integer height = 84
integer taborder = 0
boolean bringtotop = true
string text = "Reservas &Linea  "
end type

event clicked;str_parametros lstr_param
Integer   linea
f_activar_campo(uo_articulo.em_campo)
linea = dw_1.GetRow()
string var_pallet

IF linea = 0 Then   Return

var_calidad = dw_1.GetItemString(linea,"codigo_calidad")
//var_pallet  = dw_1.GetItemString(linea,"tipo_pallet")
if isnull(var_calidad) or trim(var_calidad)="0" then var_calidad =""
//if isnull(var_pallet) then var_pallet =""

lstr_param.s_argumentos[1] = "w_con_stock_articulos"
lstr_param.s_argumentos[2] = uo_articulo.em_codigo.text
lstr_param.s_argumentos[3] = var_calidad
lstr_param.s_argumentos[4] = dw_1.GetItemString(linea,"tonochar")
lstr_param.s_argumentos[5] = String(dw_1.GetItemNumber(linea,"calibre"))
//lstr_param.s_argumentos[6] = var_pallet
lstr_param.i_nargumentos = 5

OpenWithParm(w_con_reservas_articulos,lstr_param) 

end event

type cb_reserva_general from u_boton within w_con_stock_articulos
integer x = 2747
integer y = 544
integer width = 480
integer height = 84
integer taborder = 0
boolean bringtotop = true
string text = "Reserva &General"
end type

on clicked;call u_boton::clicked;str_parametros lstr_param
lstr_param.s_argumentos[1] = "w_con_stock_articulos"
lstr_param.s_argumentos[2] = uo_articulo.em_codigo.text
lstr_param.i_nargumentos = 2
f_activar_campo(uo_articulo.em_campo)
OpenWithParm(w_con_reservas_articulos,lstr_param)

end on

type cb_ventas from u_boton within w_con_stock_articulos
event clicked pbm_bnclicked
boolean visible = false
integer x = 2743
integer y = 688
integer width = 480
integer height = 84
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string text = "Ult. Ventas"
end type

event clicked;call super::clicked;str_parametros lstr_param
Integer   linea
f_activar_campo(uo_articulo.em_campo)
linea = dw_1.GetRow()

IF linea = 0 Then   Return
lstr_param.s_argumentos[1] = "w_con_stock_articulos"
lstr_param.s_argumentos[2] = uo_articulo.em_codigo.text
lstr_param.s_argumentos[3] = dw_1.GetItemString(linea,"codigo_calidad")
lstr_param.s_argumentos[4] = String(dw_1.GetItemNumber(linea,"tono"))
lstr_param.s_argumentos[5] = String(dw_1.GetItemNumber(linea,"calibre"))
lstr_param.s_argumentos[6] = dw_1.GetItemString(linea,"tipo_pallet")
lstr_param.s_argumentos[7] = var_cliente
lstr_param.s_argumentos[8] = var_envio
lstr_param.i_nargumentos = 8

OpenWithParm(w_con_ventas_articulos,lstr_param) 

end event

type cb_bases_decorados from u_boton within w_con_stock_articulos
event clicked pbm_bnclicked
boolean visible = false
integer x = 2743
integer y = 780
integer width = 480
integer height = 84
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string text = "Bases/Deco"
end type

