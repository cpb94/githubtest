$PBExportHeader$w_con_stock_fam_form.srw
forward
global type w_con_stock_fam_form from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_fam_form
end type
type dw_1 from u_datawindow_consultas within w_con_stock_fam_form
end type
type em_fechadesde from u_em_campo within w_con_stock_fam_form
end type
type st_7 from statictext within w_con_stock_fam_form
end type
type cb_2 from commandbutton within w_con_stock_fam_form
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_fam_form
end type
type cb_detalle from u_boton within w_con_stock_fam_form
end type
type dw_listado from u_datawindow_consultas within w_con_stock_fam_form
end type
type gb_1 from groupbox within w_con_stock_fam_form
end type
type st_1 from statictext within w_con_stock_fam_form
end type
type em_desde from u_em_campo within w_con_stock_fam_form
end type
type st_2 from statictext within w_con_stock_fam_form
end type
type em_hasta from u_em_campo within w_con_stock_fam_form
end type
end forward

global type w_con_stock_fam_form from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 1544
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
cb_detalle cb_detalle
dw_listado dw_listado
gb_1 gb_1
st_1 st_1
em_desde em_desde
st_2 st_2
em_hasta em_hasta
end type
global w_con_stock_fam_form w_con_stock_fam_form

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public function boolean f_modificacion_art ()
public function string f_filtro ()
public subroutine f_control (datawindow data)
end prototypes

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

public function string f_filtro ();String filtro
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

return filtro
end function

public subroutine f_control (datawindow data);String fil, art
Dec{0} li_stock,li_subtotal,cont,pagina,registros
if em_fechadesde.text="00-00-00" then
	f_mensaje ("Campo obligatorio", "Introduzca la fecha")
else
	data.Reset()
	data.SetRedraw(FALSE)
	data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)))
	registros = data.RowCount()

	for cont=1 to registros
		art = data.GetItemString(cont,"articulos_codigo")
		//li_stock=f_stock_articulo(codigo_empresa,art,DateTime(Date(em_fechadesde.text)))
		li_stock=f_stock_articulo(codigo_empresa,art)
		
		data.SetItem(cont,"cstock",f_conversion_cantidad_piezas_old(codigo_empresa, art,li_stock))
		f_mensaje_proceso("Procesando",cont,data.RowCount())
	next
	fil = f_filtro()
	if IsNull(fil) or Trim(fil)="" then
		fil = "cstock<>0"
	else
		fil = "cstock<>0 and "+f_filtro()
	end if
	data.SetFilter(fil)

	data.Filter()
	data.GroupCalc()
	data.SetRedraw(TRUE)
end if
end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = " CONSULTA STOCK POR FAMILIA Y FORMATO "
//istr_parametros = Message.PowerObjectParm

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
end event

on w_con_stock_fam_form.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_detalle=create cb_detalle
this.dw_listado=create dw_listado
this.gb_1=create gb_1
this.st_1=create st_1
this.em_desde=create em_desde
this.st_2=create st_2
this.em_hasta=create em_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.cb_detalle
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.em_desde
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_hasta
end on

on w_con_stock_fam_form.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_detalle)
destroy(this.dw_listado)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.em_desde)
destroy(this.st_2)
destroy(this.em_hasta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_fam_form
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_fam_form
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_fam_form
integer y = 20
integer width = 2587
integer height = 92
end type

type pb_2 from upb_salir within w_con_stock_fam_form
integer x = 2450
integer y = 132
integer width = 128
integer height = 112
integer taborder = 70
string picturename = "exit!"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_stock_fam_form
integer y = 320
integer width = 2825
integer height = 1008
integer taborder = 0
string dataobject = "dw_con_stock_fam_form"
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

type em_fechadesde from u_em_campo within w_con_stock_fam_form
integer x = 562
integer y = 164
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_fam_form
integer x = 37
integer y = 164
integer width = 494
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

type cb_2 from commandbutton within w_con_stock_fam_form
event clicked pbm_bnclicked
integer x = 1870
integer y = 136
integer width = 361
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_control (dw_1)
end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_fam_form
event clicked pbm_bnclicked
integer x = 2272
integer y = 136
integer taborder = 60
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;//dw_listado.Object.Datawindow.Data = dw_1.Object.Datawindow.Data
f_control(dw_listado)

f_imprimir_datawindow(dw_listado)

end event

type cb_detalle from u_boton within w_con_stock_fam_form
integer x = 1870
integer y = 216
integer width = 361
integer height = 80
integer taborder = 50
boolean bringtotop = true
string text = "Resumen"
end type

event clicked;if cb_detalle.text = "Detalle" then
	dw_1.modify("datawindow.detail.height=65")
	dw_listado.modify("datawindow.detail.height=69")
	cb_detalle.text = "Resumen"
else
	dw_1.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	cb_detalle.text = "Detalle"
end if
end event

type dw_listado from u_datawindow_consultas within w_con_stock_fam_form
boolean visible = false
integer x = 777
integer y = 328
integer taborder = 0
boolean bringtotop = true
string dataobject = "report_con_stock_fam_form"
end type

type gb_1 from groupbox within w_con_stock_fam_form
integer x = 1006
integer y = 116
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

type st_1 from statictext within w_con_stock_fam_form
integer x = 1033
integer y = 192
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

type em_desde from u_em_campo within w_con_stock_fam_form
integer x = 1207
integer y = 180
integer width = 187
integer taborder = 20
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type st_2 from statictext within w_con_stock_fam_form
integer x = 1413
integer y = 192
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

type em_hasta from u_em_campo within w_con_stock_fam_form
integer x = 1573
integer y = 180
integer width = 187
integer taborder = 30
boolean bringtotop = true
end type

