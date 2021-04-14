$PBExportHeader$w_con_incremento_stock_tarifa_cliente.srw
forward
global type w_con_incremento_stock_tarifa_cliente from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_incremento_stock_tarifa_cliente
end type
type dw_1 from u_datawindow_consultas within w_con_incremento_stock_tarifa_cliente
end type
type em_fechadesde from u_em_campo within w_con_incremento_stock_tarifa_cliente
end type
type st_7 from statictext within w_con_incremento_stock_tarifa_cliente
end type
type cb_2 from commandbutton within w_con_incremento_stock_tarifa_cliente
end type
type st_2 from statictext within w_con_incremento_stock_tarifa_cliente
end type
type em_tarifa from u_em_campo within w_con_incremento_stock_tarifa_cliente
end type
type sle_fecha from u_em_campo within w_con_incremento_stock_tarifa_cliente
end type
type st_nombre_tarifa from statictext within w_con_incremento_stock_tarifa_cliente
end type
type dw_fechas from datawindow within w_con_incremento_stock_tarifa_cliente
end type
type pb_imprimir_preli from upb_imprimir within w_con_incremento_stock_tarifa_cliente
end type
type st_85 from statictext within w_con_incremento_stock_tarifa_cliente
end type
type em_fechadesde2 from u_em_campo within w_con_incremento_stock_tarifa_cliente
end type
type rb_entre_fechas from radiobutton within w_con_incremento_stock_tarifa_cliente
end type
type rb_total from radiobutton within w_con_incremento_stock_tarifa_cliente
end type
type gb_1 from groupbox within w_con_incremento_stock_tarifa_cliente
end type
end forward

global type w_con_incremento_stock_tarifa_cliente from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3973
integer height = 2508
string menuname = ""
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
st_85 st_85
em_fechadesde2 em_fechadesde2
rb_entre_fechas rb_entre_fechas
rb_total rb_total
gb_1 gb_1
end type
global w_con_incremento_stock_tarifa_cliente w_con_incremento_stock_tarifa_cliente

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public function boolean f_modificacion_art ()
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

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_fechas.SetTransObject(sqlca)
This.title = "Consulta Stock Valorado"

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")
em_fechadesde2.text=String(DateTime(Today()),"dd-mm-yy")

rb_total.checked = true
f_activar_campo(em_fechadesde)

end event

on w_con_incremento_stock_tarifa_cliente.create
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
this.st_85=create st_85
this.em_fechadesde2=create em_fechadesde2
this.rb_entre_fechas=create rb_entre_fechas
this.rb_total=create rb_total
this.gb_1=create gb_1
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
this.Control[iCurrent+12]=this.st_85
this.Control[iCurrent+13]=this.em_fechadesde2
this.Control[iCurrent+14]=this.rb_entre_fechas
this.Control[iCurrent+15]=this.rb_total
this.Control[iCurrent+16]=this.gb_1
end on

on w_con_incremento_stock_tarifa_cliente.destroy
call super::destroy
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
destroy(this.st_85)
destroy(this.em_fechadesde2)
destroy(this.rb_entre_fechas)
destroy(this.rb_total)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_incremento_stock_tarifa_cliente
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_incremento_stock_tarifa_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_incremento_stock_tarifa_cliente
integer y = 28
integer width = 3781
integer height = 84
end type

type pb_2 from upb_salir within w_con_incremento_stock_tarifa_cliente
integer x = 3826
integer y = 24
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

type dw_1 from u_datawindow_consultas within w_con_incremento_stock_tarifa_cliente
integer x = 46
integer y = 368
integer width = 2999
integer height = 1968
integer taborder = 80
string dataobject = "dw_incrementos_stock"
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

type em_fechadesde from u_em_campo within w_con_incremento_stock_tarifa_cliente
integer x = 526
integer y = 136
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_incremento_stock_tarifa_cliente
integer x = 933
integer y = 144
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

type cb_2 from commandbutton within w_con_incremento_stock_tarifa_cliente
event clicked pbm_bnclicked
integer x = 2839
integer y = 132
integer width = 425
integer height = 140
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;datastore registros
string articulo,calidad,tarifa, sel
dec    precio, total, total_pventa
Dec{0} li_stock,cont,pagina, metros, piezas, total_expedido
Dec{2} li_subtotal, v_total_facturado, v_albaranes_pendientes, v_alb_mas_fac 
datetime fecha1, fecha2,fecha_tarifa
long i, total_dias_habiles_periodo, total_dias_habiles_mes_actual, mes_en_curso, anyo_en_curso 

fecha1      = DateTime(Date(em_fechadesde.text))
fecha2      = DateTime(Date(em_fechadesde2.text)) 
tarifa       = em_tarifa.text
fecha_tarifa = DateTime(Date(sle_fecha.text))

if Trim(em_tarifa.text)="" then
	f_mensaje ("Campo obligatorio", "Introduzca la tarifa")
else
	dw_1.Reset()
	dw_1.SetRedraw(FALSE)
	
	DataWindowChild dwchild_a, dwchild_b
	dw_1.GetChild("dw_a", dwchild_a)
	dw_1.GetChild("dw_b", dwchild_b)
	
	dwchild_a.SettransObject(SQLCA)
	dwchild_b.SettransObject(SQLCA)
	dwchild_a.Retrieve(codigo_empresa,tarifa,tarifa,fecha1,fecha2)
	dwchild_b.Retrieve(codigo_empresa,tarifa,tarifa,fecha1,fecha2)

	if dwchild_a.rowcount() >0 and dwchild_b.rowcount() > 0 then
	
		dw_1.object.dif_imp_base.text = 	string(round(dwchild_b.GetItemdecimal(1,"total_importe_base") -	dwchild_a.GetItemdecimal(1,"total_importe_base"), 2), "###,###,###,##0.00" )
		dw_1.object.dif_imp_term.text = string(round(dwchild_b.GetItemdecimal(1,"total_importe_term") - dwchild_a.GetItemdecimal(1,"total_importe_term"), 2), "###,###,###,##0.00"  )
		dw_1.object.dif_imp_global.text = string(round(dwchild_b.GetItemdecimal(1,"total_importe") - dwchild_a.GetItemdecimal(1,"total_importe"), 2), "###,###,###,##0.00"  )
		
		dw_1.object.dif_piezas_base.text = string(round(dwchild_b.GetItemdecimal(1,"total_piezas_base") - dwchild_a.GetItemdecimal(1,"total_piezas_base"), 2), "###,###,###,##0"  )
		dw_1.object.dif_piezas_term.text = string(round(dwchild_b.GetItemdecimal(1,"total_piezas_term") - dwchild_a.GetItemdecimal(1,"total_piezas_term"), 2), "###,###,###,##0"  )
		dw_1.object.dif_piezas_global.text = string(round(dwchild_b.GetItemdecimal(1,"total_piezas") - dwchild_a.GetItemdecimal(1,"total_piezas"), 2), "###,###,###,##0"  )
	
		dw_1.object.dif_metros_base.text = string(round(dwchild_b.GetItemdecimal(1,"total_metros_base") - dwchild_a.GetItemdecimal(1,"total_metros_base"), 2), "###,###,###,##0"  )
		dw_1.object.dif_metros_term.text = string(round(dwchild_b.GetItemdecimal(1,"total_metros_term") - dwchild_a.GetItemdecimal(1,"total_metros_term"), 2), "###,###,###,##0"  )
		dw_1.object.dif_metros_global.text = string(round(dwchild_b.GetItemdecimal(1,"total_metros") - dwchild_a.GetItemdecimal(1,"total_metros"), 2), "###,###,###,##0"  )
		
		metros = 0
		piezas = 0
		dw_1.object.importe_dep1.text = string(round(f_calculo_importe_deposito (fecha1, tarifa, piezas, metros), 2), "###,###,###,##0" )
		dw_1.object.metros_dep1.text = string(round(metros, 0), "###,###,###,##0"  )
		dw_1.object.piezas_dep1.text = string(round(piezas, 0), "###,###,###,##0"  )
	
		metros = 0
		piezas = 0
		dw_1.object.importe_dep2.text = string(round(f_calculo_importe_deposito (fecha2, tarifa, piezas, metros), 2), "###,###,###,##0" )
		dw_1.object.metros_dep2.text = string(round(metros, 0), "###,###,###,##0"  )
		dw_1.object.piezas_dep2.text = string(round(piezas, 0), "###,###,###,##0"  )
	
		dw_1.object.tot_importe1.text = 	string(round(dwchild_a.GetItemdecimal(1,"total_importe"), 2) + dec(dw_1.object.importe_dep1.text) , "###,###,###,##0.00" )
		dw_1.object.tot_piezas1.text = 	string(round(dwchild_a.GetItemdecimal(1,"total_piezas"), 2) + dec(dw_1.object.piezas_dep1.text) , "###,###,###,##0" )
		dw_1.object.tot_metros1.text = 	string(round(dwchild_a.GetItemdecimal(1,"total_metros"), 2) + dec(dw_1.object.metros_dep1.text) , "###,###,###,##0" )
	
		dw_1.object.tot_importe2.text = 	string(round(dwchild_b.GetItemdecimal(1,"total_importe"), 2) + dec(dw_1.object.importe_dep2.text) , "###,###,###,##0.00" )
		dw_1.object.tot_piezas2.text = 	string(round(dwchild_b.GetItemdecimal(1,"total_piezas"), 2) + dec(dw_1.object.piezas_dep2.text) , "###,###,###,##0" )
		dw_1.object.tot_metros2.text = 	string(round(dwchild_b.GetItemdecimal(1,"total_metros"), 2) + dec(dw_1.object.metros_dep2.text) , "###,###,###,##0" )
	
		dw_1.object.dif_importe_dep.text = 	string(round(dec(dw_1.object.importe_dep2.text) - dec(dw_1.object.importe_dep1.text), 2), "###,###,###,##0" )
		dw_1.object.dif_piezas_dep.text = 	string(round(dec(dw_1.object.piezas_dep2.text) - dec(dw_1.object.piezas_dep1.text), 2), "###,###,###,##0" )
		dw_1.object.dif_metros_dep.text = 	string(round(dec(dw_1.object.metros_dep2.text) - dec(dw_1.object.metros_dep1.text), 2), "###,###,###,##0" )
	
		dw_1.object.dif_importe.text = 	string(round(dec(dw_1.object.tot_importe2.text) - dec(dw_1.object.tot_importe1.text), 2), "###,###,###,##0" )
		dw_1.object.dif_piezas.text = 	string(round(dec(dw_1.object.tot_piezas2.text) - dec(dw_1.object.tot_piezas1.text), 2), "###,###,###,##0" )
		dw_1.object.dif_metros.text = 	string(round(dec(dw_1.object.tot_metros2.text) - dec(dw_1.object.tot_metros1.text), 2), "###,###,###,##0" )
	end if

	fecha1 = datetime(RelativeDate ( date(fecha1), 1 ))
	
	mes_en_curso = month(today())
	anyo_en_curso = year(today())
	select count(*)
	into :total_dias_habiles_periodo
	from prodmeses
	where empresa = :codigo_empresa
	and fecha >= :fecha1
	and fecha <= :fecha2
	and calendario = '5'
	and horas > 0;
	
	select count(*)
	into :total_dias_habiles_mes_Actual
	from prodmeses
	where empresa = :codigo_empresa
	and mes = :mes_en_curso
	and anyo = :anyo_en_curso
	and calendario = '5'
	and horas > 0;
	
//	messagebox("", string (total_dias_habiles_periodo)+'       '+ string(total_dias_habiles_mes_Actual))
	
	if tarifa = '5' then tarifa = '%'
	
	// Total facturado
	select sum(total_neto / cambio)
	into :v_total_facturado 
	from venfac
	where empresa = :codigo_empresa
	and ffactura >= :fecha1
	and ffactura <= :fecha2
	and tarifa like :tarifa;
	
	if isnull(v_total_facturado) then
		v_total_facturado = 0
	end if
	
	// Albaranes pendientes
	if rb_total.checked then
		select sum(venlialb.neto / monedas.euros)
		into :v_albaranes_pendientes
		from venlialb, monedas, venalb
		where venlialb.empresa = :codigo_empresa
		and venlialb.divisa = monedas.moneda
		and venlialb.empresa = venalb.empresa
		and venlialb.albaran = venalb.albaran
		and venlialb.anyo = venalb.anyo
		and venlialb.deposito <> 'S'
		and venlialb.falbaran <= :fecha2
		and tarifa like :tarifa;
	end if
	if rb_entre_fechas.checked then
		select sum(venlialb.neto / monedas.euros)
		into :v_albaranes_pendientes
		from venlialb, monedas, venalb
		where venlialb.empresa = :codigo_empresa
		and venlialb.divisa = monedas.moneda
		and venlialb.empresa = venalb.empresa
		and venlialb.albaran = venalb.albaran
		and venlialb.anyo = venalb.anyo
		and venlialb.deposito <> 'S'
		and venlialb.falbaran >= :fecha1
		and venlialb.falbaran <= :fecha2
		and tarifa like :tarifa;
	end if
	
	
	
	if isnull(v_albaranes_pendientes) then
		v_albaranes_pendientes = 0
	end if
	
	v_alb_mas_fac = v_total_facturado + v_albaranes_pendientes

	dw_1.object.t_fechas.text = string(fecha1, "dd-mm-yy")+" - "+string(fecha2, "dd-mm-yy")
	
	dw_1.object.total_facturas.text = string(round(v_total_facturado, 2), "###,###,###,##0.00"  )
	dw_1.object.total_albaranes.text = string(round(v_albaranes_pendientes, 2), "###,###,###,##0.00"  )
	dw_1.object.alb_fac.text = string(round(v_alb_mas_fac, 2), "###,###,###,##0.00"  )

	dw_1.object.total.text = string(round(v_alb_mas_fac + dec (dw_1.object.dif_importe.text) , 2), "###,###,###,##0.00"  )
	if total_dias_habiles_periodo > 0 then
		total = dec (dw_1.object.total.text) / total_dias_habiles_periodo * total_dias_habiles_mes_actual
		dw_1.object.prev_total.text = string(round(  total  , 2), "###,###,###,##0.00"  )
	else
		dw_1.object.prev_total.text  = '0'
	end if
	IF tarifa = '5' OR tarifa = '%' THEN
		dw_1.object.total_pventa.text = string(round(v_alb_mas_fac + dec (dw_1.object.dif_imp_term.text)/0.75 + &
																					 	 dec (dw_1.object.dif_importe_dep.text)/0.75, 2), "###,###,###,##0.00"  )
	else																						
		dw_1.object.total_pventa.text = string(round(v_alb_mas_fac + dec (dw_1.object.dif_imp_term.text) + &
 																					 	 dec (dw_1.object.dif_importe_dep.text), 2), "###,###,###,##0.00"  )	
	END IF																					

	if total_dias_habiles_periodo > 0 then
		total_pventa = dec (dw_1.object.total_pventa.text) / total_dias_habiles_periodo * total_dias_habiles_mes_actual
		dw_1.object.prev_total_pventa.text = string(round(  total_pventa  , 2), "###,###,###,##0.00"  )
	else
		dw_1.object.prev_total_pventa.text = '0'
	end if
	
	dw_1.GroupCalc()
	dw_1.SetRedraw(TRUE)
end if


end event

type st_2 from statictext within w_con_incremento_stock_tarifa_cliente
integer x = 37
integer y = 260
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

type em_tarifa from u_em_campo within w_con_incremento_stock_tarifa_cliente
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 274
integer y = 256
integer taborder = 30
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

type sle_fecha from u_em_campo within w_con_incremento_stock_tarifa_cliente
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 562
integer y = 256
integer width = 311
integer taborder = 50
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

type st_nombre_tarifa from statictext within w_con_incremento_stock_tarifa_cliente
integer x = 942
integer y = 244
integer width = 1047
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_con_incremento_stock_tarifa_cliente
event clicked pbm_dwnlbuttonclk
integer x = 3337
integer y = 140
integer width = 599
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

type pb_imprimir_preli from upb_imprimir within w_con_incremento_stock_tarifa_cliente
event clicked pbm_bnclicked
boolean visible = false
integer x = 4146
integer y = 24
integer taborder = 100
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type st_85 from statictext within w_con_incremento_stock_tarifa_cliente
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

type em_fechadesde2 from u_em_campo within w_con_incremento_stock_tarifa_cliente
integer x = 1445
integer y = 140
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type rb_entre_fechas from radiobutton within w_con_incremento_stock_tarifa_cliente
integer x = 2103
integer y = 180
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Entre Fechas"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type rb_total from radiobutton within w_con_incremento_stock_tarifa_cliente
integer x = 2103
integer y = 252
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Total Pendientes"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_incremento_stock_tarifa_cliente
integer x = 2053
integer y = 116
integer width = 617
integer height = 228
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Albaranes"
borderstyle borderstyle = styleraised!
end type

