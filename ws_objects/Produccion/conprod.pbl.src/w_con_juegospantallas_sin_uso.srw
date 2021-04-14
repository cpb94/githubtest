$PBExportHeader$w_con_juegospantallas_sin_uso.srw
forward
global type w_con_juegospantallas_sin_uso from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_juegospantallas_sin_uso
end type
type dw_1 from u_datawindow_consultas within w_con_juegospantallas_sin_uso
end type
type em_fechadesde from u_em_campo within w_con_juegospantallas_sin_uso
end type
type st_7 from statictext within w_con_juegospantallas_sin_uso
end type
type cb_2 from commandbutton within w_con_juegospantallas_sin_uso
end type
type pb_imprimir_preli from upb_imprimir within w_con_juegospantallas_sin_uso
end type
type em_fechahasta from u_em_campo within w_con_juegospantallas_sin_uso
end type
type st_1 from statictext within w_con_juegospantallas_sin_uso
end type
type em_fechapartes from u_em_campo within w_con_juegospantallas_sin_uso
end type
type st_2 from statictext within w_con_juegospantallas_sin_uso
end type
end forward

global type w_con_juegospantallas_sin_uso from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3506
integer height = 3648
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
em_fechahasta em_fechahasta
st_1 st_1
em_fechapartes em_fechapartes
st_2 st_2
end type
global w_con_juegospantallas_sin_uso w_con_juegospantallas_sin_uso

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

This.title = " Pantallas Sin Uso "
//istr_parametros = Message.PowerObjectParm

em_fechadesde.text = "01-01-01"
em_fechahasta.text = String(DateTime(Today()),"dd-mm-yy")
em_fechapartes.text = "01-01-01"
f_activar_campo(em_fechadesde)
end event

on w_con_juegospantallas_sin_uso.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.em_fechapartes=create em_fechapartes
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_fechapartes
this.Control[iCurrent+10]=this.st_2
end on

on w_con_juegospantallas_sin_uso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.em_fechapartes)
destroy(this.st_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_juegospantallas_sin_uso
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_juegospantallas_sin_uso
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_juegospantallas_sin_uso
integer y = 12
integer width = 3438
integer height = 80
end type

type pb_2 from upb_salir within w_con_juegospantallas_sin_uso
integer x = 3296
integer y = 128
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_juegospantallas_sin_uso
integer x = 32
integer y = 260
integer width = 3424
integer height = 3172
integer taborder = 0
string dataobject = "dw_con_juegospantallas_sin_uso"
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

type em_fechadesde from u_em_campo within w_con_juegospantallas_sin_uso
integer x = 631
integer y = 136
integer width = 315
integer height = 80
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_7 from statictext within w_con_juegospantallas_sin_uso
integer x = 119
integer y = 144
integer width = 494
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Alta entre"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_juegospantallas_sin_uso
event clicked pbm_bnclicked
integer x = 2889
integer y = 128
integer width = 279
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string articulo,calidad
dec    precio, total_pantallas
Dec{0} li_stock,cont,pagina
Dec{2} li_subtotal
datetime fecha_desde, fecha_hasta, fechapartes



dw_1.SetTransObject(SQLCA)

fecha_desde        = DateTime(Date(em_fechadesde.text))
fecha_hasta        = DateTime(Date(em_fechahasta.text))
fechapartes      	 = DateTime(Date(em_fechapartes.text))

dw_1.Reset()
dw_1.SetRedraw(FALSE)



dw_1.Retrieve(codigo_empresa, fecha_desde, fecha_hasta, fechapartes)

select count(distinct juegopantallas)
into :total_pantallas
from art_ver_operaciones, articulos
where art_ver_operaciones.empresa = articulos.empresa
and art_ver_operaciones.articulo = articulos.codigo
and art_ver_operaciones.empresa = :codigo_empresa
and articulos.fecha_alta >= :fecha_desde
and articulos.fecha_alta <= :fecha_hasta
and articulos.fecha_anulado is null
and juegopantallas not in (
	select art_ver_operaciones.juegopantallas
	from prodpartes_ot, art_ver_operaciones
	where art_ver_operaciones.empresa = prodpartes_ot.empresa
	and art_ver_operaciones.articulo = prodpartes_ot.articulo
	and art_ver_operaciones.version = prodpartes_ot.version
	and art_ver_operaciones.orden =  prodpartes_ot.ordenoperacion
	and prodpartes_ot.fecha >= :fechapartes
	and juegopantallas is not null
	and juegopantallas <> '')
and juegopantallas <> '';


dw_1.object.total_pantallas.text = string(total_pantallas)

dw_1.setfilter("")
dw_1.filter()
	
dw_1.GroupCalc()
dw_1.SetRedraw(TRUE)


end event

type pb_imprimir_preli from upb_imprimir within w_con_juegospantallas_sin_uso
event clicked pbm_bnclicked
integer x = 3177
integer y = 128
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type em_fechahasta from u_em_campo within w_con_juegospantallas_sin_uso
integer x = 1029
integer y = 136
integer width = 315
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_1 from statictext within w_con_juegospantallas_sin_uso
integer x = 955
integer y = 140
integer width = 69
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
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechapartes from u_em_campo within w_con_juegospantallas_sin_uso
integer x = 2491
integer y = 136
integer width = 315
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_juegospantallas_sin_uso
integer x = 1573
integer y = 148
integer width = 859
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sin Partes a partir de:"
alignment alignment = right!
boolean focusrectangle = false
end type

