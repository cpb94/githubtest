$PBExportHeader$w_con_stock_valorado_coste_nuevo.srw
forward
global type w_con_stock_valorado_coste_nuevo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_stock_valorado_coste_nuevo
end type
type dw_1 from u_datawindow_consultas within w_con_stock_valorado_coste_nuevo
end type
type em_fechadesde from u_em_campo within w_con_stock_valorado_coste_nuevo
end type
type st_titulo from statictext within w_con_stock_valorado_coste_nuevo
end type
type cb_2 from commandbutton within w_con_stock_valorado_coste_nuevo
end type
type pb_imprimir_preli from upb_imprimir within w_con_stock_valorado_coste_nuevo
end type
type ddlb_global from dropdownlistbox within w_con_stock_valorado_coste_nuevo
end type
type cbx_mermas from checkbox within w_con_stock_valorado_coste_nuevo
end type
type cbx_stock_obsoleto from checkbox within w_con_stock_valorado_coste_nuevo
end type
type st_1 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_2 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_3 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_4 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_5 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_6 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_7 from statictext within w_con_stock_valorado_coste_nuevo
end type
type uo_cliente from u_em_campo_2 within w_con_stock_valorado_coste_nuevo
end type
type st_8 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_9 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_10 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_11 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_12 from statictext within w_con_stock_valorado_coste_nuevo
end type
type st_13 from statictext within w_con_stock_valorado_coste_nuevo
end type
type gb_90 from groupbox within w_con_stock_valorado_coste_nuevo
end type
type gb_2 from groupbox within w_con_stock_valorado_coste_nuevo
end type
type ln_1 from line within w_con_stock_valorado_coste_nuevo
end type
type ln_2 from line within w_con_stock_valorado_coste_nuevo
end type
type ln_3 from line within w_con_stock_valorado_coste_nuevo
end type
end forward

global type w_con_stock_valorado_coste_nuevo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3497
integer height = 3392
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_titulo st_titulo
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
ddlb_global ddlb_global
cbx_mermas cbx_mermas
cbx_stock_obsoleto cbx_stock_obsoleto
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
uo_cliente uo_cliente
st_8 st_8
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
gb_90 gb_90
gb_2 gb_2
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_con_stock_valorado_coste_nuevo w_con_stock_valorado_coste_nuevo

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
This.title = " CONSULTA STOCK VALORADO CON COSTE DE PRODUCCIÓN "

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
end event

on w_con_stock_valorado_coste_nuevo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_titulo=create st_titulo
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.ddlb_global=create ddlb_global
this.cbx_mermas=create cbx_mermas
this.cbx_stock_obsoleto=create cbx_stock_obsoleto
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.uo_cliente=create uo_cliente
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.gb_90=create gb_90
this.gb_2=create gb_2
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_titulo
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.ddlb_global
this.Control[iCurrent+8]=this.cbx_mermas
this.Control[iCurrent+9]=this.cbx_stock_obsoleto
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.st_7
this.Control[iCurrent+17]=this.uo_cliente
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.st_10
this.Control[iCurrent+21]=this.st_11
this.Control[iCurrent+22]=this.st_12
this.Control[iCurrent+23]=this.st_13
this.Control[iCurrent+24]=this.gb_90
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.ln_1
this.Control[iCurrent+27]=this.ln_2
this.Control[iCurrent+28]=this.ln_3
end on

on w_con_stock_valorado_coste_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_titulo)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.ddlb_global)
destroy(this.cbx_mermas)
destroy(this.cbx_stock_obsoleto)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.uo_cliente)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.gb_90)
destroy(this.gb_2)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_valorado_coste_nuevo
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_valorado_coste_nuevo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_valorado_coste_nuevo
integer y = 20
integer width = 3397
integer textsize = -9
boolean italic = true
end type

type pb_2 from upb_salir within w_con_stock_valorado_coste_nuevo
integer x = 3301
integer y = 132
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

type dw_1 from u_datawindow_consultas within w_con_stock_valorado_coste_nuevo
integer x = 23
integer y = 248
integer width = 3383
integer height = 2528
integer taborder = 70
string dataobject = "dw_con_stock_valorado_coste_nuevo"
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

if dwo.name = "t_cliente" then
	this.setsort("cliente ASC")
	this.sort()
elseif dwo.name = "descripcion_t" then
	this.setsort("descripcion ASC")
	this.sort()
elseif dwo.name = "piezas_t" then
	this.setsort("piezas ASC")
	this.sort()
elseif dwo.name = "coste_t" then
	this.setsort("coste ASC")
	this.sort()
end if


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

type em_fechadesde from u_em_campo within w_con_stock_valorado_coste_nuevo
integer x = 265
integer y = 136
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_titulo from statictext within w_con_stock_valorado_coste_nuevo
integer x = 32
integer y = 112
integer width = 206
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Stock a Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_stock_valorado_coste_nuevo
event clicked pbm_bnclicked
integer x = 2862
integer y = 136
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

event clicked;string articulo, v_uso, sel, cliente
datetime fecha
long i, fila, total_movimientos
datastore regs
dec coste_mp, coste_fab, piezas, coste
boolean con_mermas

dw_1.SetTransObject(SQLCA)


dw_1.Reset()
//dw_1.SetRedraw(FALSE)

choose case ddlb_global.text
	case "Todo"
		v_uso = ' 1=1 ' 
	case ""
		v_uso = ' 1=1 ' 
	case "Acabado"
		v_uso = " articulos.uso = '3'  "
	case "Acabado + Intermedio"
		v_uso = " (articulos.uso = '3' or articulos.uso = '2' )  "
	case "Intermedio"
		v_uso = " articulos.uso = '2' "
	case "Base"
		v_uso = " articulos.uso = '1' "
end choose 


if cbx_stock_obsoleto.checked then
	fecha = DateTime(today())
	dw_1.object.t_titulo.text = "Obsoleto desde: "+em_fechadesde.text	
else
	fecha = DateTime(Date(em_fechadesde.text))
	dw_1.object.t_titulo.text = "Stock a Fecha: "+em_fechadesde.text	
end if

if uo_cliente.em_codigo.text = '' then
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text
end if


if uo_cliente.em_codigo.text = '' then
	sel = " select almmovhis.articulo, articulos.descripcion, articulos.uso, genter.razon, sum (almmovhis.cantidade - almmovhis.cantidads) as stock_piezas "+&
			" from almmovhis "+&
			" inner join articulos on almmovhis.empresa = articulos.empresa and almmovhis.articulo = articulos.codigo "+&
			" inner join art_codestadistico on  articulos.empresa = art_codestadistico.empresa and articulos.codigo = art_codestadistico.codigo "+&
			" left outer join genter on articulos.empresa = genter.empresa and articulos.cliente = genter.codigo and genter.tipoter = 'C' "+&
			" where  almmovhis.fechmov <= '"+string(fecha)+"' "+&
			" and almmovhis.empresa  = '"+codigo_empresa+"' "+&
			" and almmovhis.situacion <> 'A' "+&
			" and  ((art_codestadistico.G2 <> 'N')  or (art_codestadistico.G2 is null )) "+&
			" and "+v_uso+&
			" group by almmovhis.articulo,  articulos.descripcion, articulos.uso, genter.razon "+&
			" having sum (almmovhis.cantidade - almmovhis.cantidads) <> 0 "+&
			" order by stock_piezas desc "
else
	sel = " select almmovhis.articulo, articulos.descripcion, articulos.uso, genter.razon, sum (almmovhis.cantidade - almmovhis.cantidads) as stock_piezas "+&
			" from almmovhis "+&
			" inner join articulos on almmovhis.empresa = articulos.empresa and almmovhis.articulo = articulos.codigo "+&
			" inner join art_codestadistico on  articulos.empresa = art_codestadistico.empresa and articulos.codigo = art_codestadistico.codigo "+&
			" left outer join genter on articulos.empresa = genter.empresa and articulos.cliente = genter.codigo and genter.tipoter = 'C' "+&
			" where  almmovhis.fechmov <= '"+string(fecha)+"' "+&
			" and almmovhis.empresa  = '"+codigo_empresa+"' "+&
			" and almmovhis.situacion <> 'A' "+&
			" and  ((art_codestadistico.G2 <> 'N')  or (art_codestadistico.G2 is null )) "+&
			" and "+v_uso+&
			" and articulos.cliente like '"+cliente+"' "+&
			" group by almmovhis.articulo,  articulos.descripcion, articulos.uso, genter.razon "+&
			" having sum (almmovhis.cantidade - almmovhis.cantidads) <> 0 "+&
			" order by stock_piezas desc "
end if

f_cargar_cursor_nuevo (sel, regs)

if regs.rowcount() > 0 then
	for i = 1 to regs.rowcount()
		articulo = regs.object.almmovhis_articulo[i]

		coste_mp = 0
		coste_fab = 0
		if cbx_mermas.checked then
			con_mermas = true
		else
			con_mermas = false
		end if
		
		
		if cbx_stock_obsoleto.checked then
			fecha = DateTime(Date(em_fechadesde.text))
			select count(*)
			into :total_movimientos
			from almmovhis
			where articulo = :articulo
			and fechmov >= :fecha
			and ( tipomov = 206  
			or tipomov = 100
			or tipomov = 204
			or tipomov = 208
			or tipomov = 209 
			or tipomov = 1 );
			
			if isnull(total_movimientos) then total_movimientos = 0

			if total_movimientos = 0 then
				fila = dw_1.insertrow(0)
				dw_1.object.codigo[fila]  = articulo
				dw_1.object.descripcion[fila]  = regs.object.articulos_descripcion[i]
				dw_1.object.piezas[fila]  = regs.object.stock_piezas[i]	
				dw_1.object.cliente[fila]  = regs.object.genter_razon[i]	
				f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
				piezas = regs.object.stock_piezas[i]
				coste = ( coste_mp + coste_fab ) * piezas 
				dw_1.object.coste[fila] =  coste
				dw_1.ScrollToRow ( fila)
			end if
		else		
			fila = dw_1.insertrow(0)
			
			dw_1.object.codigo[fila]  = articulo
			dw_1.object.descripcion[fila]  = regs.object.articulos_descripcion[i]
			dw_1.object.piezas[fila]  = regs.object.stock_piezas[i]	
			dw_1.object.cliente[fila]  = regs.object.genter_razon[i]	
			
			choose case regs.object.articulos_uso[i]
				case "1"
					dw_1.object.uso[fila]  = "B"
				case "2"
					dw_1.object.uso[fila]  = "I"
				case "3"
					dw_1.object.uso[fila]  = "A"
			end choose			
			
//			coste_mp = 0
//			coste_fab = 0
//			if cbx_mermas.checked then
//				con_mermas = true
//			else
//				con_mermas = false
//			end if
			f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
			piezas = regs.object.stock_piezas[i]
			coste = ( coste_mp + coste_fab ) * piezas 
			dw_1.object.coste[fila] =  coste
			dw_1.ScrollToRow ( fila)
//			f_mensaje_proceso ("ARTÍCULO: "+string(articulo), i, regs.rowcount())
		end if
		f_mensaje_proceso ("ARTÍCULO: "+string(articulo), i, regs.rowcount())
		
	next
end if

	

end event

type pb_imprimir_preli from upb_imprimir within w_con_stock_valorado_coste_nuevo
event clicked pbm_bnclicked
integer x = 3173
integer y = 136
integer taborder = 10
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type ddlb_global from dropdownlistbox within w_con_stock_valorado_coste_nuevo
integer x = 617
integer y = 144
integer width = 571
integer height = 392
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
string item[] = {"Todo","Acabado","Acabado + Intermedio","Intermedio","Base"}
borderstyle borderstyle = stylelowered!
end type

type cbx_mermas from checkbox within w_con_stock_valorado_coste_nuevo
integer x = 1221
integer y = 164
integer width = 745
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
string text = "Tener en Cuenta mermas"
boolean checked = true
end type

type cbx_stock_obsoleto from checkbox within w_con_stock_valorado_coste_nuevo
integer x = 1221
integer y = 100
integer width = 745
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
string text = "Stock Obsoleto"
end type

event clicked;if cbx_stock_obsoleto.checked then 
	st_titulo.text = 'Obsoleto desde:' 
else 
	st_titulo.text = 'Stock a Fecha:'
end if

end event

type st_1 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 2804
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Entrada Producción"
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 2864
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Salida Ventas"
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 2924
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Salida Promoción"
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 2984
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Salida Preparación"
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 3044
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Salida Mercaderias"
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 681
integer y = 3104
integer width = 517
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "salida Producción"
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 114
integer y = 2936
integer width = 517
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mov. contemplados:"
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_stock_valorado_coste_nuevo
event destroy ( )
integer x = 1993
integer y = 144
integer width = 827
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type st_8 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 114
integer y = 2992
integer width = 517
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "(Stock Obsoleto)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 1362
integer y = 2808
integer width = 1947
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "* No contemplamos la base de cliente por tener valor 0 y no ser stock propio."
boolean focusrectangle = false
end type

type st_10 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 1362
integer y = 2900
integer width = 443
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217728
string text = "Tipo de Producción: "
boolean focusrectangle = false
end type

type st_11 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 1403
integer y = 2964
integer width = 288
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217728
string text = "A: Acabado"
boolean focusrectangle = false
end type

type st_12 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 1403
integer y = 3012
integer width = 288
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217728
string text = "I: Intermedio"
boolean focusrectangle = false
end type

type st_13 from statictext within w_con_stock_valorado_coste_nuevo
integer x = 1403
integer y = 3060
integer width = 288
integer height = 44
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217728
string text = "B: Base"
boolean focusrectangle = false
end type

type gb_90 from groupbox within w_con_stock_valorado_coste_nuevo
integer x = 594
integer y = 96
integer width = 608
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

type gb_2 from groupbox within w_con_stock_valorado_coste_nuevo
integer x = 1979
integer y = 96
integer width = 864
integer height = 140
integer taborder = 20
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

type ln_1 from line within w_con_stock_valorado_coste_nuevo
integer linethickness = 4
integer beginx = 654
integer beginy = 2800
integer endx = 654
integer endy = 3160
end type

type ln_2 from line within w_con_stock_valorado_coste_nuevo
integer linethickness = 4
integer beginx = 658
integer beginy = 2800
integer endx = 690
integer endy = 2800
end type

type ln_3 from line within w_con_stock_valorado_coste_nuevo
integer linethickness = 4
integer beginx = 654
integer beginy = 3160
integer endx = 690
integer endy = 3160
end type

