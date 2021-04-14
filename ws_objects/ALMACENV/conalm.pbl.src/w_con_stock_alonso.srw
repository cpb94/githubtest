$PBExportHeader$w_con_stock_alonso.srw
forward
global type w_con_stock_alonso from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_alonso
end type
type dw_1 from u_datawindow_consultas within w_con_stock_alonso
end type
type cb_2 from commandbutton within w_con_stock_alonso
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_alonso
end type
type dw_listado from datawindow within w_con_stock_alonso
end type
type gb_6 from groupbox within w_con_stock_alonso
end type
type gb_1 from groupbox within w_con_stock_alonso
end type
type gb_4 from groupbox within w_con_stock_alonso
end type
type gb_2 from groupbox within w_con_stock_alonso
end type
type uo_familia from u_em_campo_2 within w_con_stock_alonso
end type
type em_cuanto from u_em_campo within w_con_stock_alonso
end type
type ddlb_1 from dropdownlistbox within w_con_stock_alonso
end type
type gb_3 from groupbox within w_con_stock_alonso
end type
type uo_formato from u_em_campo_2 within w_con_stock_alonso
end type
type cb_1 from commandbutton within w_con_stock_alonso
end type
type uo_calidad from u_marca_lista within w_con_stock_alonso
end type
type st_1 from statictext within w_con_stock_alonso
end type
type em_desde from u_em_campo within w_con_stock_alonso
end type
type st_2 from statictext within w_con_stock_alonso
end type
type em_hasta from u_em_campo within w_con_stock_alonso
end type
type em_tono from u_em_campo within w_con_stock_alonso
end type
type cbx_conjunto from checkbox within w_con_stock_alonso
end type
end forward

global type w_con_stock_alonso from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2935
integer height = 1620
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
gb_6 gb_6
gb_1 gb_1
gb_4 gb_4
gb_2 gb_2
uo_familia uo_familia
em_cuanto em_cuanto
ddlb_1 ddlb_1
gb_3 gb_3
uo_formato uo_formato
cb_1 cb_1
uo_calidad uo_calidad
st_1 st_1
em_desde em_desde
st_2 st_2
em_hasta em_hasta
em_tono em_tono
cbx_conjunto cbx_conjunto
end type
global w_con_stock_alonso w_con_stock_alonso

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
Integer como
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_modificacion_art ()
public function string f_filtro ()
end prototypes

public subroutine f_control ();//String  referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad
//dec{2}  existencias,disponible,preparado,reservado
//Integer tono,calibre,x1

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

public function string f_filtro ();String filtro = ""

// Cantidad
if (IsNull(ddlb_1.text) or (Trim(ddlb_1.text) <> "")) and (IsNull(em_cuanto.text) or (Trim(em_cuanto.text) <> "")) then
	filtro = filtro + " cexistencias " + Trim(ddlb_1.text) + " " + Trim(em_cuanto.text) + " "
end if

// Iniciales. Desde
if Trim(em_desde.text) <> "" then
	if filtro = "" then
		filtro = " articulos_descripcion >= '" + Trim(em_desde.text) + "' "		
	else
		filtro = filtro + " and articulos_descripcion >= '" + Trim(em_desde.text) + "' "
	end if
end if

// Iniciales. Hasta
if Trim(em_hasta.text) <> "" then
	if filtro = "" then
		filtro = " articulos_descripcion <= '" + Trim(em_hasta.text) + "Z' "		
	else
		filtro = filtro + " and articulos_descripcion <= '" + Trim(em_hasta.text) + "Z' "
	end if
end if

// Familia
if Trim(uo_familia.em_codigo.text) <> "" then
	if filtro = "" then
		filtro = " familia = '" + Trim(uo_familia.em_codigo.text) + "'"		
	else
		filtro = filtro + " and familia = '" + Trim(uo_familia.em_codigo.text) + "'"
	end if
end if

// Formato
if Trim(uo_formato.em_codigo.text) <> "" then
	if filtro ="" then
		filtro = " formato = '" + Trim(uo_formato.em_codigo.text) + "'"	
	else
		filtro = filtro + " and formato = '" + Trim(uo_formato.em_codigo.text) + "'"
	end if
end if

// Tono
//if Trim(em_tono.text) <> "" then
//	if filtro ="" then
//		filtro = " tonochar = '" + Trim(em_tono.text) + "'"	
//	else
//		filtro = filtro + " and tonochar = '" + Trim(em_tono.text) + "'"
//	end if
//end if

// Consulta de datos de la empresa actual, o de todas
if not(cbx_conjunto.checked) then
	if filtro ="" then
		filtro = " empresa = '" + codigo_empresa + "'"	
	else
		filtro = filtro + " and empresa = '" + codigo_empresa + "'"
	end if
end if


return filtro
end function

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = "CONSULTA STOCK"

// Se utiliza para el boton de marcar ó desmarcar
   como = 0
   //cb_3.text ="&Marcar"
/////////////////////////////////////////////////	

uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")
uo_calidad.dw_marca.SetItem(1,"marca","S")
end event

on w_con_stock_alonso.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.gb_6=create gb_6
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_2=create gb_2
this.uo_familia=create uo_familia
this.em_cuanto=create em_cuanto
this.ddlb_1=create ddlb_1
this.gb_3=create gb_3
this.uo_formato=create uo_formato
this.cb_1=create cb_1
this.uo_calidad=create uo_calidad
this.st_1=create st_1
this.em_desde=create em_desde
this.st_2=create st_2
this.em_hasta=create em_hasta
this.em_tono=create em_tono
this.cbx_conjunto=create cbx_conjunto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.gb_6
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.uo_familia
this.Control[iCurrent+11]=this.em_cuanto
this.Control[iCurrent+12]=this.ddlb_1
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.uo_formato
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.uo_calidad
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.em_desde
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.em_hasta
this.Control[iCurrent+21]=this.em_tono
this.Control[iCurrent+22]=this.cbx_conjunto
end on

on w_con_stock_alonso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.uo_familia)
destroy(this.em_cuanto)
destroy(this.ddlb_1)
destroy(this.gb_3)
destroy(this.uo_formato)
destroy(this.cb_1)
destroy(this.uo_calidad)
destroy(this.st_1)
destroy(this.em_desde)
destroy(this.st_2)
destroy(this.em_hasta)
destroy(this.em_tono)
destroy(this.cbx_conjunto)
end on

event activate;call super::activate;w_con_stock_alonso = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_alonso
integer taborder = 130
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_alonso
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_alonso
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_stock_alonso
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

type dw_1 from u_datawindow_consultas within w_con_stock_alonso
integer x = 5
integer y = 476
integer width = 2848
integer height = 948
integer taborder = 140
string dataobject = "dw_con_stock_alonso"
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

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=7
  lstr_param.s_argumentos[2]=This.GetItemString(Row,"almlinubica_articulo")
  lstr_param.s_argumentos[3]=This.GetItemString(Row,"almlinubica_calidad")
  lstr_param.s_argumentos[4]=String(This.GetItemNumber(Row,"almlinubica_tono"))
  lstr_param.s_argumentos[5]=String(This.GetItemNumber(Row,"almlinubica_calibre"))
  lstr_param.s_argumentos[6]=This.GetItemString(Row,"almlinubica_tipo_pallet")  
  lstr_param.s_argumentos[7]=This.GetItemString(Row,"almlinubica_caja")    
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_con_movarticulos_tipo,lstr_param) 
End If
end event

type cb_2 from commandbutton within w_con_stock_alonso
event clicked pbm_bnclicked
integer x = 2162
integer y = 224
integer width = 361
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_1.Reset()
dw_1.SetRedraw(FALSE)

dw_1.SetFilter(f_filtro())
dw_1.Filter()

uo_calidad.visible=false
string calidades[1 to 20]
string tono
long i

for i=1 to 20
	calidades[i]=""
next

for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next
if Trim(em_tono.text) = "" or IsNull(em_tono.text) then
	tono = '%'
else
	tono = Trim(em_tono.text) + '%'
end if

dw_1.Retrieve(calidades,tono)

//dw_1.GroupCalc()
dw_1.SetRedraw(TRUE)

end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_alonso
event clicked pbm_bnclicked
integer x = 2565
integer y = 196
integer taborder = 100
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;
dw_listado.Reset()
dw_listado.SetRedraw(FALSE)

dw_listado.SetFilter(f_filtro())
dw_listado.Filter()

uo_calidad.visible=false
string calidades[1 to 20]
string tono
long i

for i=1 to 20
	calidades[i]=""
next

for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next

if Trim(em_tono.text)="" or IsNull(em_tono.text) then
	tono = "%"
else 
	tono = Trim(em_tono.text) +"%"
end if

dw_listado.Retrieve(calidades,tono)
//dw_listado.GroupCalc()
dw_listado.SetRedraw(TRUE)

f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_stock_alonso
boolean visible = false
integer x = 64
integer y = 88
integer width = 512
integer height = 228
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_stock_alonso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_con_stock_alonso
integer x = 2153
integer y = 300
integer width = 315
integer height = 172
integer taborder = 110
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Tono"
end type

type gb_1 from groupbox within w_con_stock_alonso
integer x = 1353
integer y = 300
integer width = 791
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Iniciales"
end type

type gb_4 from groupbox within w_con_stock_alonso
integer x = 5
integer y = 300
integer width = 1349
integer height = 176
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Formato"
end type

type gb_2 from groupbox within w_con_stock_alonso
integer x = 800
integer y = 124
integer width = 1349
integer height = 176
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Familia"
end type

type uo_familia from u_em_campo_2 within w_con_stock_alonso
integer x = 841
integer y = 192
integer width = 1266
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)
If Trim(uo_familia.em_campo.text)="" then
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
	Return
end if 
//dw_1.Retrieve(codigo_empresa,uo_familia.em_codigo.text)
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_familias"
ue_filtro = ""
end event

on uo_familia.destroy
call u_em_campo_2::destroy
end on

type em_cuanto from u_em_campo within w_con_stock_alonso
integer x = 421
integer y = 196
integer width = 320
integer height = 80
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "1"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "######0"
end type

type ddlb_1 from dropdownlistbox within w_con_stock_alonso
integer x = 96
integer y = 192
integer width = 247
integer height = 404
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"<","<=",">=",">","<>"}
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_con_stock_alonso
integer y = 120
integer width = 795
integer height = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 12632256
string text = "Cantidad"
end type

type uo_formato from u_em_campo_2 within w_con_stock_alonso
event destroy ( )
integer x = 46
integer y = 368
integer width = 1266
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato(codigo_empresa,uo_formato.em_codigo.text)
If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 
//dw_1.Retrieve(codigo_empresa,uo_formato.em_codigo.text)
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

type cb_1 from commandbutton within w_con_stock_alonso
integer x = 2162
integer y = 144
integer width = 361
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;if uo_calidad.visible= True then
   uo_calidad.visible = False
else
	uo_calidad.visible= True
End if
end event

type uo_calidad from u_marca_lista within w_con_stock_alonso
event destroy ( )
boolean visible = false
integer x = 1179
integer y = 304
integer taborder = 120
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type st_1 from statictext within w_con_stock_alonso
integer x = 1381
integer y = 376
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Desde"
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_con_stock_alonso
integer x = 1554
integer y = 364
integer width = 187
integer height = 88
integer taborder = 50
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type st_2 from statictext within w_con_stock_alonso
integer x = 1760
integer y = 376
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Hasta"
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_con_stock_alonso
integer x = 1920
integer y = 364
integer width = 187
integer height = 88
integer taborder = 60
boolean bringtotop = true
end type

type em_tono from u_em_campo within w_con_stock_alonso
integer x = 2190
integer y = 364
integer width = 233
integer height = 88
integer taborder = 60
boolean bringtotop = true
string mask = "!!!!"
end type

type cbx_conjunto from checkbox within w_con_stock_alonso
integer x = 2510
integer y = 352
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Conjunto"
end type

