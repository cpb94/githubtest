$PBExportHeader$w_con_variacion_stock_coste_fabricacion_old.srw
forward
global type w_con_variacion_stock_coste_fabricacion_old from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_variacion_stock_coste_fabricacion_old
end type
type dw_1 from u_datawindow_consultas within w_con_variacion_stock_coste_fabricacion_old
end type
type em_fecha1 from u_em_campo within w_con_variacion_stock_coste_fabricacion_old
end type
type st_7 from statictext within w_con_variacion_stock_coste_fabricacion_old
end type
type cb_2 from commandbutton within w_con_variacion_stock_coste_fabricacion_old
end type
type pb_imprimir_preli from upb_imprimir within w_con_variacion_stock_coste_fabricacion_old
end type
type st_85 from statictext within w_con_variacion_stock_coste_fabricacion_old
end type
type em_fecha2 from u_em_campo within w_con_variacion_stock_coste_fabricacion_old
end type
type rb_entre_fechas from radiobutton within w_con_variacion_stock_coste_fabricacion_old
end type
type rb_total from radiobutton within w_con_variacion_stock_coste_fabricacion_old
end type
type st_mensaje from statictext within w_con_variacion_stock_coste_fabricacion_old
end type
type pb_1 from upb_imprimir within w_con_variacion_stock_coste_fabricacion_old
end type
type cbx_coste from checkbox within w_con_variacion_stock_coste_fabricacion_old
end type
type uo_familia from u_em_campo_2 within w_con_variacion_stock_coste_fabricacion_old
end type
type gb_1 from groupbox within w_con_variacion_stock_coste_fabricacion_old
end type
type gb_8 from groupbox within w_con_variacion_stock_coste_fabricacion_old
end type
end forward

global type w_con_variacion_stock_coste_fabricacion_old from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3639
integer height = 3676
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fecha1 em_fecha1
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
st_85 st_85
em_fecha2 em_fecha2
rb_entre_fechas rb_entre_fechas
rb_total rb_total
st_mensaje st_mensaje
pb_1 pb_1
cbx_coste cbx_coste
uo_familia uo_familia
gb_1 gb_1
gb_8 gb_8
end type
global w_con_variacion_stock_coste_fabricacion_old w_con_variacion_stock_coste_fabricacion_old

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

event open;call super::open;date fecha
dw_1.SetTransObject(sqlca)
string mes, anyo

This.title = " VARIACIÓN DE STOCK "

mes = string(month(today()))
anyo = string(year(today()))
fecha = date('01-'+mes+'-'+anyo)
//RelativeDate ( fecha, -1 )

em_fecha1.text=String(DateTime(RelativeDate ( fecha, -1 )),"dd-mm-yy")
em_fecha2.text=String(DateTime(Today()),"dd-mm-yy")

rb_total.checked = true
f_activar_campo(em_fecha1)

end event

on w_con_variacion_stock_coste_fabricacion_old.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fecha1=create em_fecha1
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_85=create st_85
this.em_fecha2=create em_fecha2
this.rb_entre_fechas=create rb_entre_fechas
this.rb_total=create rb_total
this.st_mensaje=create st_mensaje
this.pb_1=create pb_1
this.cbx_coste=create cbx_coste
this.uo_familia=create uo_familia
this.gb_1=create gb_1
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fecha1
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.st_85
this.Control[iCurrent+8]=this.em_fecha2
this.Control[iCurrent+9]=this.rb_entre_fechas
this.Control[iCurrent+10]=this.rb_total
this.Control[iCurrent+11]=this.st_mensaje
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.cbx_coste
this.Control[iCurrent+14]=this.uo_familia
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_8
end on

on w_con_variacion_stock_coste_fabricacion_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fecha1)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_85)
destroy(this.em_fecha2)
destroy(this.rb_entre_fechas)
destroy(this.rb_total)
destroy(this.st_mensaje)
destroy(this.pb_1)
destroy(this.cbx_coste)
destroy(this.uo_familia)
destroy(this.gb_1)
destroy(this.gb_8)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_variacion_stock_coste_fabricacion_old
integer x = 96
integer y = 704
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_variacion_stock_coste_fabricacion_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_variacion_stock_coste_fabricacion_old
integer y = 28
integer width = 3543
integer height = 84
end type

type pb_2 from upb_salir within w_con_variacion_stock_coste_fabricacion_old
integer x = 3442
integer y = 152
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

type dw_1 from u_datawindow_consultas within w_con_variacion_stock_coste_fabricacion_old
integer x = 46
integer y = 308
integer width = 3515
integer height = 3148
integer taborder = 80
string dataobject = "dw_variacion_stock_coste_fabricacion"
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

type em_fecha1 from u_em_campo within w_con_variacion_stock_coste_fabricacion_old
integer x = 393
integer y = 128
integer width = 311
integer height = 76
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_variacion_stock_coste_fabricacion_old
integer x = 50
integer y = 208
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha2 <="
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_variacion_stock_coste_fabricacion_old
event clicked pbm_bnclicked
integer x = 2821
integer y = 156
integer width = 425
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string sel, articulo
datastore datos
long i, total_regs
dec metros, piezas
dec coste_mp, coste_fab,  coste
boolean con_mermas
st_mensaje.visible = true
datetime fecha1, fecha2
long mes_en_curso, anyo_en_curso , total_dias_habiles_periodo , total_dias_habiles_mes_actual
Dec{2}  v_total_facturado, v_albaranes_pendientes, v_alb_mas_fac , importe1, importe2, importe_dep1, importe_dep2
dec  total, total_pventa
string tarifa

dw_1.object.t_fecha_importe1.text = em_fecha1.text
dw_1.object.t_fecha_piezas1.text = em_fecha1.text
dw_1.object.t_fecha_metros1.text = em_fecha1.text

dw_1.object.t_fecha_importe2.text = em_fecha2.text
dw_1.object.t_fecha_piezas2.text = em_fecha2.text
dw_1.object.t_fecha_metros2.text = em_fecha2.text


// ----------------------------------------------------------//
// Cálculo de stock a precio de venta	de nuestros almacenes //
// ----------------------------------------------------------//
importe1 = 0
/*
select sum ( (almmovhis.cantidade - almmovhis.cantidads) * venlintarifas.precio ) as importe_total
into :importe1
from almmovhis, articulos, venlintarifas
where almmovhis.empresa  = :codigo_empresa
and almmovhis.situacion <> 'A'
and ( articulos.uso = '2' or articulos.uso = '3' )
and articulos.empresa = :codigo_empresa
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = almmovhis.articulo
and almmovhis.fechmov <= :em_fecha1.text;
*/
select sum ( (almacenmovimientos.cantidade - almacenmovimientos.cantidads) * venlintarifas.precio ) as importe_total
into :importe1
from almacenmovimientos, articulos, venlintarifas
where almacenmovimientos.empresa  = :codigo_empresa
and ( articulos.uso = '2' or articulos.uso = '3' )
and articulos.empresa = :codigo_empresa
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = almacenmovimientos.articulo
and almacenmovimientos.fecha_mov <= :em_fecha1.text;

importe2 = 0
/*
select sum ( (almmovhis.cantidade - almmovhis.cantidads) * venlintarifas.precio ) as importe_total
into :importe2
from almmovhis, articulos, venlintarifas
where almmovhis.empresa  = :codigo_empresa
and almmovhis.situacion <> 'A'
and articulos.empresa = :codigo_empresa
and ( articulos.uso = '2' or articulos.uso = '3' )
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = almmovhis.articulo
and almmovhis.fechmov <= :em_fecha2.text;
*/
select sum ( (almacenmovimientos.cantidade - almacenmovimientos.cantidads) * venlintarifas.precio ) as importe_total
into :importe2
from almacenmovimientos, articulos, venlintarifas
where almacenmovimientos.empresa  = :codigo_empresa
and articulos.empresa = :codigo_empresa
and ( articulos.uso = '2' or articulos.uso = '3' )
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = almacenmovimientos.articulo
and almacenmovimientos.fecha_mov <= :em_fecha2.text;

// ------------------------------------------------//
// Cálculo de stock a precio de venta	de depósito //
// ------------------------------------------------//

importe_dep1 = 0
select sum ( (depmovhis.cantidade - depmovhis.cantidads) * venlintarifas.precio ) as importe_total
into :importe_dep1
from depmovhis, articulos, venlintarifas
where depmovhis.empresa  = :codigo_empresa
and depmovhis.situacion <> 'A'
and articulos.empresa = :codigo_empresa
and ( articulos.uso = '2' or articulos.uso = '3' )
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = depmovhis.articulo
and depmovhis.fechmov <= :em_fecha1.text;

importe_dep2 = 0
select sum ( (depmovhis.cantidade - depmovhis.cantidads) * venlintarifas.precio ) as importe_total
into :importe_dep2
from depmovhis, articulos, venlintarifas
where depmovhis.empresa  = :codigo_empresa
and depmovhis.situacion <> 'A'
and ( articulos.uso = '2' or articulos.uso = '3' )
and articulos.empresa = :codigo_empresa
and venlintarifas.empresa = :codigo_empresa
and venlintarifas.articulo = articulos.codigo
and venlintarifas.tarifa <> '5'
and venlintarifas.calidad = 1
and articulos.codigo = depmovhis.articulo
and depmovhis.fechmov <= :em_fecha2.text;

//---------------------------------------------------------//
// Calculamos variación para período 1 para el depósito.   //
//---------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Depósito a '+em_fecha1.text+'.......'

sel = " select depmovhis.articulo, ( sum(depmovhis.cantidade - depmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(depmovhis.cantidade - depmovhis.cantidads ) ) PIEZAS "+&
		" from depmovhis, articulos, formatos, art_codestadistico "+&
		" where depmovhis.empresa = articulos.empresa "+&
		" and depmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and depmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha1.text)), 'dd-mm-yyyy')+"' " +&
		" group by depmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(depmovhis.cantidade - depmovhis.cantidads ) <> 0 "
		
		
f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.depmovhis_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando Depósito a '+em_fecha1.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_deposito1[1] = coste
dw_1.object.piezas_deposito1[1] = piezas
dw_1.object.metros_deposito1[1] = metros

destroy datos

//---------------------------------------------------------//
// Calculamos variación para período 2 para el depósito.   //
//---------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Depósito a '+em_fecha2.text+'.......'

sel = " select depmovhis.articulo, ( sum(depmovhis.cantidade - depmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(depmovhis.cantidade - depmovhis.cantidads ) ) PIEZAS "+&
		" from depmovhis, articulos, formatos, art_codestadistico "+&
		" where depmovhis.empresa = articulos.empresa "+&
		" and depmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and depmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha2.text)), 'dd-mm-yyyy')+"' " +&
		" group by depmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(depmovhis.cantidade - depmovhis.cantidads ) <> 0 "
		
		
f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.depmovhis_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando Depósito a '+em_fecha2.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_deposito2[1] = coste
dw_1.object.piezas_deposito2[1] = piezas
dw_1.object.metros_deposito2[1] = metros

destroy datos




//--------------------------------------------------------------//
// Calculamos variación para período 1 e artículos intermedios. //
//--------------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Producto intermedio a '+em_fecha1.text+'.......'

/*
sel = " select almmovhis.articulo, ( sum(almmovhis.cantidade - almmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almmovhis.cantidade - almmovhis.cantidads ) ) PIEZAS "+&
		" from almmovhis, articulos, formatos, art_codestadistico "+&
		" where almmovhis.empresa = articulos.empresa "+&
		" and almmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and articulos.uso = '1'  "+&
		" and almmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha1.text)), 'dd-mm-yyyy')+"' " +&
		" group by almmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almmovhis.cantidade - almmovhis.cantidads ) <> 0 "
		*/
sel = " select almacenmovimientos.articulo, ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) ) PIEZAS "+&
		" from almacenmovimientos, articulos, formatos, art_codestadistico "+&
		" where almacenmovimientos.empresa = articulos.empresa "+&
		" and almacenmovimientos.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and articulos.uso = '1'  "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and almacenmovimientos.fecha_mov <= '"+string ( DateTime(Date(em_fecha1.text)), 'dd-mm-yyyy')+"' " +&
		" group by almacenmovimientos.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) <> 0 "				
		
		
f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.almacenmovimientos_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando producto intermedio a '+em_fecha1.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_base1[1] = coste
dw_1.object.piezas_base1[1] = piezas
dw_1.object.metros_base1[1] = metros

destroy datos

//--------------------------------------------------------------//
// Calculamos variación para período 2 e artículos intermedios. //
//--------------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Producto intermedio a '+em_fecha2.text+'.......'
/*
sel = " select almmovhis.articulo, ( sum(almmovhis.cantidade - almmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almmovhis.cantidade - almmovhis.cantidads ) ) PIEZAS "+&
		" from almmovhis, articulos, formatos, art_codestadistico "+&
		" where almmovhis.empresa = articulos.empresa "+&
		" and almmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and articulos.uso = '1'  "+&
		" and almmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha2.text)), 'dd-mm-yyyy')+"' " +&
		" group by almmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almmovhis.cantidade - almmovhis.cantidads ) <> 0 "
*/
sel = " select almacenmovimientos.articulo, ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) ) PIEZAS "+&
		" from almacenmovimientos, articulos, formatos, art_codestadistico "+&
		" where almacenmovimientos.empresa = articulos.empresa "+&
		" and almacenmovimientos.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and art_codestadistico.G2 <> 'N' "+&
		" and articulos.uso = '1'  "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and almacenmovimientos.fecha_mov <= '"+string ( DateTime(Date(em_fecha2.text)), 'dd-mm-yyyy')+"' " +&
		" group by almacenmovimientos.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) <> 0 "

f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.almacenmovimientos_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando producto intermedio a '+em_fecha2.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_base2[1] = coste
dw_1.object.piezas_base2[1] = piezas
dw_1.object.metros_base2[1] = metros

destroy datos

//-------------------------------------------------------------//
// Calculamos variación para período 1 y artículos terminados. //
//-------------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Producto terminado a '+em_fecha1.text+'.......'
/*
sel = " select almmovhis.articulo, ( sum(almmovhis.cantidade - almmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almmovhis.cantidade - almmovhis.cantidads ) ) PIEZAS "+&
		" from almmovhis, articulos, formatos "+&
		" where almmovhis.empresa = articulos.empresa "+&
		" and almmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and ( articulos.uso = '3' or articulos.uso = '2' ) "+&
		" and almmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha1.text)), 'dd-mm-yyyy')+"' " +&
		" group by almmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almmovhis.cantidade - almmovhis.cantidads ) <> 0 "
*/
sel = " select almacenmovimientos.articulo, ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) ) PIEZAS "+&
		" from almacenmovimientos, articulos, formatos "+&
		" where almacenmovimientos.empresa = articulos.empresa "+&
		" and almacenmovimientos.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and ( articulos.uso = '3' or articulos.uso = '2' ) "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and almacenmovimientos.fecha_mov <= '"+string ( DateTime(Date(em_fecha1.text)), 'dd-mm-yyyy')+"' " +&
		" group by almacenmovimientos.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) <> 0 "
		
f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.almacenmovimientos_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando producto terminado a '+em_fecha1.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_terminado1[1] = coste
dw_1.object.piezas_terminado1[1] = piezas
dw_1.object.metros_terminado1[1] = metros

destroy datos

//-------------------------------------------------------------//
// Calculamos variación para período 2 y artículos terminados. //
//-------------------------------------------------------------//

st_mensaje.text = 'Generando consulta de Producto terminado a '+em_fecha2.text+'.......'
/*
sel = " select almmovhis.articulo, ( sum(almmovhis.cantidade - almmovhis.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almmovhis.cantidade - almmovhis.cantidads ) ) PIEZAS "+&
		" from almmovhis, articulos, formatos "+&
		" where almmovhis.empresa = articulos.empresa "+&
		" and almmovhis.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and ( articulos.uso = '3' or articulos.uso = '2' ) "+&
		" and almmovhis.situacion <> 'A' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and fechmov <= '"+string ( DateTime(Date(em_fecha2.text)), 'dd-mm-yyyy')+"' " +&
		" group by almmovhis.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almmovhis.cantidade - almmovhis.cantidads ) <> 0 "
*/
sel = " select almacenmovimientos.articulo, ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) * formatos.ancho * formatos.largo  / 10000 ) METROS,   "+&
		" ( sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) ) PIEZAS "+&
		" from almacenmovimientos, articulos, formatos "+&
		" where almacenmovimientos.empresa = articulos.empresa "+&
		" and almacenmovimientos.articulo = articulos.codigo "+&
		" and articulos.empresa = formatos.empresa "+&
		" and articulos.formato = formatos.codigo "+&
		" and ( articulos.uso = '3' or articulos.uso = '2' ) "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and almacenmovimientos.fecha_mov <= '"+string ( DateTime(Date(em_fecha2.text)), 'dd-mm-yyyy')+"' " +&
		" group by almacenmovimientos.articulo, formatos.ancho, formatos.largo  "+&
		" having sum(almacenmovimientos.cantidade - almacenmovimientos.cantidads ) <> 0 "
		
f_cargar_cursor_nuevo ( sel, datos )	
metros = 0
piezas = 0
coste = 0
con_mermas = true
total_regs = datos.rowcount()
for i = 1 to total_regs
	articulo = datos.object.almacenmovimientos_articulo[i]
	metros += datos.object.metros[i]
	piezas += datos.object.piezas[i]
	coste_mp = 0 
	coste_fab = 0
	f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
	coste += ( coste_mp + coste_fab ) *  datos.object.piezas[i]

	st_mensaje.text = 'Calculando producto terminado a '+em_fecha2.text+': '+string(i)+" de "+string (total_regs)

next

dw_1.object.importe_terminado2[1] = coste
dw_1.object.piezas_terminado2[1] = piezas
dw_1.object.metros_terminado2[1] = metros

destroy datos

dw_1.object.dif_importe_deposito[1] = dw_1.object.importe_deposito2[1] - dw_1.object.importe_deposito1[1]
dw_1.object.dif_piezas_deposito[1] = dw_1.object.piezas_deposito2[1] - dw_1.object.piezas_deposito1[1]
dw_1.object.dif_metros_deposito[1] = dw_1.object.metros_deposito2[1] - dw_1.object.metros_deposito1[1]

dw_1.object.dif_importe_base[1] = dw_1.object.importe_base2[1] - dw_1.object.importe_base1[1]
dw_1.object.dif_piezas_base[1] =  dw_1.object.piezas_base2[1] - dw_1.object.piezas_base1[1]
dw_1.object.dif_metros_base[1] = dw_1.object.metros_base2[1] - dw_1.object.metros_base1[1]

dw_1.object.dif_importe_terminado[1] = dw_1.object.importe_terminado2[1] - dw_1.object.importe_terminado1[1]
dw_1.object.dif_piezas_terminado[1] = dw_1.object.piezas_terminado2[1] - dw_1.object.piezas_terminado1[1]
dw_1.object.dif_metros_terminado[1] = dw_1.object.metros_terminado2[1] - dw_1.object.metros_terminado1[1]  

dw_1.object.importe_total_tencer1[1] = dw_1.object.importe_base1[1] + dw_1.object.importe_terminado1[1]
dw_1.object.importe_total_tencer2[1] = dw_1.object.importe_base2[1] + dw_1.object.importe_terminado2[1]
dw_1.object.dif_importe_total_tencer[1] = dw_1.object.importe_total_tencer2[1] - dw_1.object.importe_total_tencer1[1]

dw_1.object.piezas_total_tencer1[1] = dw_1.object.piezas_base1[1] + dw_1.object.piezas_terminado1[1]
dw_1.object.piezas_total_tencer2[1] = dw_1.object.piezas_base2[1] + dw_1.object.piezas_terminado2[1]
dw_1.object.dif_piezas_total_tencer[1] = dw_1.object.piezas_total_tencer2[1] - dw_1.object.piezas_total_tencer1[1]

dw_1.object.metros_total_tencer1[1] = dw_1.object.metros_base1[1] + dw_1.object.metros_terminado1[1]
dw_1.object.metros_total_tencer2[1] = dw_1.object.metros_base2[1] + dw_1.object.metros_terminado2[1]
dw_1.object.dif_metros_total_tencer[1] = dw_1.object.metros_total_tencer2[1] - dw_1.object.metros_total_tencer1[1]

dw_1.object.importe_total1[1] = dw_1.object.importe_base1[1] + dw_1.object.importe_terminado1[1] + dw_1.object.importe_deposito1[1]
dw_1.object.importe_total2[1] = dw_1.object.importe_base2[1] + dw_1.object.importe_terminado2[1] + dw_1.object.importe_deposito2[1]
dw_1.object.dif_importe_total[1] = dw_1.object.importe_total2[1] - dw_1.object.importe_total1[1]  

dw_1.object.piezas_total1[1] = dw_1.object.piezas_base1[1] + dw_1.object.piezas_terminado1[1] + dw_1.object.piezas_deposito1[1]
dw_1.object.piezas_total2[1] = dw_1.object.piezas_base2[1] + dw_1.object.piezas_terminado2[1] + dw_1.object.piezas_deposito2[1]
dw_1.object.dif_piezas_total[1] = dw_1.object.piezas_total2[1] - dw_1.object.piezas_total1[1]

dw_1.object.metros_total1[1] = dw_1.object.metros_base1[1] + dw_1.object.metros_terminado1[1] + dw_1.object.metros_deposito1[1]
dw_1.object.metros_total2[1] = dw_1.object.metros_base2[1] + dw_1.object.metros_terminado2[1] + dw_1.object.metros_deposito2[1]
dw_1.object.dif_metros_total[1] = dw_1.object.metros_total2[1] - dw_1.object.metros_total1[1]  

dw_1.object.var_stock_pv[1] = importe2 - importe1 + importe_dep2 - importe_dep1

st_mensaje.visible = false



//------------------------------
// Calculo del resumen final
//------------------------------
fecha1      = DateTime(Date(em_fecha1.text))
fecha2      = DateTime(Date(em_fecha2.text)) 

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


// Total facturado
select sum(total_neto / cambio)
into :v_total_facturado 
from venfac
where empresa = :codigo_empresa
and ffactura >= :fecha1
and ffactura <= :fecha2;
//and tarifa like :tarifa;

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
	and venlialb.falbaran <= :fecha2;
//	and tarifa like :tarifa;
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
	and venlialb.falbaran <= :fecha2;
//	and tarifa like :tarifa;
end if


if isnull(v_albaranes_pendientes) then
	v_albaranes_pendientes = 0
end if

v_alb_mas_fac = v_total_facturado + v_albaranes_pendientes

dw_1.object.t_fechas.text = string(fecha1, "dd-mm-yy")+" - "+string(fecha2, "dd-mm-yy")

dw_1.object.total_facturas[1] = v_total_facturado
dw_1.object.total_albaranes[1] = v_albaranes_pendientes
dw_1.object.alb_fac[1] = v_alb_mas_fac

dw_1.object.total[1] = v_alb_mas_fac + dw_1.object.dif_importe_total[1]
if total_dias_habiles_periodo > 0 then
	total = dec (dw_1.object.total[1]) / total_dias_habiles_periodo * total_dias_habiles_mes_actual
	dw_1.object.prev_total[1] = total  
else
	dw_1.object.prev_total[1]  = 0
end if




dw_1.GroupCalc()
dw_1.SetRedraw(TRUE)









end event

type pb_imprimir_preli from upb_imprimir within w_con_variacion_stock_coste_fabricacion_old
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

type st_85 from statictext within w_con_variacion_stock_coste_fabricacion_old
integer x = 23
integer y = 132
integer width = 370
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha1 <="
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha2 from u_em_campo within w_con_variacion_stock_coste_fabricacion_old
integer x = 393
integer y = 208
integer width = 311
integer height = 76
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type rb_entre_fechas from radiobutton within w_con_variacion_stock_coste_fabricacion_old
integer x = 1271
integer y = 192
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
string text = "Entre Fechas"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type rb_total from radiobutton within w_con_variacion_stock_coste_fabricacion_old
integer x = 1723
integer y = 192
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
string text = "Total Pendientes"
borderstyle borderstyle = styleraised!
end type

type st_mensaje from statictext within w_con_variacion_stock_coste_fabricacion_old
boolean visible = false
integer x = 46
integer y = 3324
integer width = 3515
integer height = 132
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from upb_imprimir within w_con_variacion_stock_coste_fabricacion_old
integer x = 3264
integer y = 156
integer taborder = 20
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type cbx_coste from checkbox within w_con_variacion_stock_coste_fabricacion_old
integer x = 2290
integer y = 180
integer width = 466
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
string text = "Calcular Costes"
borderstyle borderstyle = styleraised!
end type

type uo_familia from u_em_campo_2 within w_con_variacion_stock_coste_fabricacion_old
event destroy ( )
integer x = 763
integer y = 180
integer width = 407
integer taborder = 90
boolean bringtotop = true
boolean border = true
long backcolor = 134217728
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_1 from groupbox within w_con_variacion_stock_coste_fabricacion_old
integer x = 1234
integer y = 132
integer width = 1029
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
string text = "Albaranes"
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within w_con_variacion_stock_coste_fabricacion_old
integer x = 741
integer y = 128
integer width = 471
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
string text = "Familia"
end type

