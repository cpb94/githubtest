$PBExportHeader$w_con_stock_deposito_valorado_coste.srw
forward
global type w_con_stock_deposito_valorado_coste from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_deposito_valorado_coste
end type
type dw_1 from u_datawindow_consultas within w_con_stock_deposito_valorado_coste
end type
type em_fechadesde from u_em_campo within w_con_stock_deposito_valorado_coste
end type
type st_7 from statictext within w_con_stock_deposito_valorado_coste
end type
type cb_2 from commandbutton within w_con_stock_deposito_valorado_coste
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_valorado_coste
end type
type ddlb_global from dropdownlistbox within w_con_stock_deposito_valorado_coste
end type
type gb_90 from groupbox within w_con_stock_deposito_valorado_coste
end type
end forward

global type w_con_stock_deposito_valorado_coste from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3227
integer height = 2648
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
ddlb_global ddlb_global
gb_90 gb_90
end type
global w_con_stock_deposito_valorado_coste w_con_stock_deposito_valorado_coste

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
//dw_fechas.SetTransObject(sqlca)
This.title = " CONSULTA STOCK DEPÓSITO VALORADO CON COSTE DE PRODUCCIÓN "

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
end event

on w_con_stock_deposito_valorado_coste.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.ddlb_global=create ddlb_global
this.gb_90=create gb_90
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.ddlb_global
this.Control[iCurrent+8]=this.gb_90
end on

on w_con_stock_deposito_valorado_coste.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.ddlb_global)
destroy(this.gb_90)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_deposito_valorado_coste
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_deposito_valorado_coste
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_deposito_valorado_coste
integer y = 20
integer width = 2775
integer textsize = -9
boolean italic = true
end type

type pb_2 from upb_salir within w_con_stock_deposito_valorado_coste
integer x = 2683
integer y = 128
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

type dw_1 from u_datawindow_consultas within w_con_stock_deposito_valorado_coste
integer x = 23
integer y = 244
integer width = 3104
integer height = 2140
integer taborder = 70
string dataobject = "dw_con_stock_deposito_valorado_coste"
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

type em_fechadesde from u_em_campo within w_con_stock_deposito_valorado_coste
integer x = 517
integer y = 136
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_stock_deposito_valorado_coste
integer x = 37
integer y = 140
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

type cb_2 from commandbutton within w_con_stock_deposito_valorado_coste
event clicked pbm_bnclicked
integer x = 2245
integer y = 132
integer width = 306
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string articulo, v_uso, filtro
datetime fecha
long i
dec coste_mp, coste_fab
dw_1.SetTransObject(SQLCA)

fecha        = DateTime(Date(em_fechadesde.text))
dw_1.Reset()
dw_1.SetRedraw(FALSE)

choose case ddlb_global.text
	case "Todo"
		v_uso = '1=1' 
	case ""
		v_uso = '1=1' 
	case "Acabado"
		v_uso = " articulos_uso = '3'  "
	case "Intermedio"
		v_uso = " articulos_uso = '2' "
	case "Base"
		v_uso = " articulos_uso = '1' "
end choose 

dw_1.Retrieve(codigo_empresa,fecha)
dw_1.setfilter(v_uso)
dw_1.filter()
	
dw_1.GroupCalc()

if dw_1.rowcount() > 0 then
	for i = 1 to dw_1.rowcount()
		coste_mp = 0 
		coste_fab = 0
		f_calculo_coste_articulo_mp_fab (codigo_empresa, dw_1.object.depmovhis_articulo[i], coste_mp, coste_fab, true)	
		dw_1.object.depmovhis_importe[i] = 	( coste_mp + coste_fab)	* dw_1.object.stock_piezas[i]	
		dw_1.object.coste_pieza[i] = ( coste_mp + coste_fab)
		f_mensaje_proceso ("ARTÍCULO: "+string(dw_1.object.depmovhis_articulo[i]), i, dw_1.rowcount())
	next
end if

	
dw_1.GroupCalc()
dw_1.SetRedraw(TRUE)


end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_deposito_valorado_coste
event clicked pbm_bnclicked
integer x = 2555
integer y = 132
integer taborder = 10
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type ddlb_global from dropdownlistbox within w_con_stock_deposito_valorado_coste
integer x = 855
integer y = 144
integer width = 361
integer height = 300
integer taborder = 10
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","Acabado","Intermedio","Base"}
borderstyle borderstyle = stylelowered!
end type

type gb_90 from groupbox within w_con_stock_deposito_valorado_coste
integer x = 841
integer y = 96
integer width = 389
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tipo Prod."
end type

