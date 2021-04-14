$PBExportHeader$w_con_coste_articulo2.srw
forward
global type w_con_coste_articulo2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_coste_articulo2
end type
type st_1 from statictext within w_con_coste_articulo2
end type
type dw_1 from datawindow within w_con_coste_articulo2
end type
type dw_listado from datawindow within w_con_coste_articulo2
end type
type pb_imprimir from upb_imprimir within w_con_coste_articulo2
end type
type pb_2 from upb_carpeta within w_con_coste_articulo2
end type
type uo_1 from u_em_campo_2 within w_con_coste_articulo2
end type
type cb_1 from u_boton within w_con_coste_articulo2
end type
type cbx_estructural from checkbox within w_con_coste_articulo2
end type
type cb_2 from commandbutton within w_con_coste_articulo2
end type
type cb_3 from commandbutton within w_con_coste_articulo2
end type
type em_fdesde from u_em_campo within w_con_coste_articulo2
end type
type em_fhasta from u_em_campo within w_con_coste_articulo2
end type
type st_2 from statictext within w_con_coste_articulo2
end type
type st_3 from statictext within w_con_coste_articulo2
end type
end forward

global type w_con_coste_articulo2 from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 4878
integer height = 3152
pb_1 pb_1
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
pb_2 pb_2
uo_1 uo_1
cb_1 cb_1
cbx_estructural cbx_estructural
cb_2 cb_2
cb_3 cb_3
em_fdesde em_fdesde
em_fhasta em_fhasta
st_2 st_2
st_3 st_3
end type
global w_con_coste_articulo2 w_con_coste_articulo2

type variables

end variables

on w_con_coste_articulo2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cbx_estructural=create cbx_estructural
this.cb_2=create cb_2
this.cb_3=create cb_3
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cbx_estructural
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.em_fdesde
this.Control[iCurrent+13]=this.em_fhasta
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
end on

on w_con_coste_articulo2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cbx_estructural)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Consulta del Coste de un Articulo"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)


em_fdesde.text =  '01-01-01'
em_fhasta.text = string(today(), "dd-mm-yy")


if istr_parametros.i_nargumentos >= 1 then
	

	uo_1.em_codigo.text = istr_parametros.s_argumentos[1]
		
	uo_1.ue_valor_anterior = f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
	
	uo_1.ue_valor = uo_1.em_codigo.text
	
	uo_1.triggerEvent("modificado")

	cb_1.event clicked()
		
END IF
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;//string articulo

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el artículo")
//	f_activar_campo(uo_1.em_campo)
//	return
////	articulo = "%"
//else
//	articulo = uo_1.em_codigo.text
//end if
//dw_1.Retrieve(codigo_empresa,articulo)
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_coste_articulo2
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_coste_articulo2
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_coste_articulo2
integer x = 27
integer y = 24
integer width = 4645
integer height = 84
end type

type pb_1 from upb_salir within w_con_coste_articulo2
integer x = 4695
integer y = 12
integer width = 123
integer height = 112
integer taborder = 0
end type

type st_1 from statictext within w_con_coste_articulo2
integer x = 32
integer y = 140
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_coste_articulo2
integer x = 32
integer y = 244
integer width = 4809
integer height = 2680
boolean bringtotop = true
string dataobject = "dw_con_coste_articulo2"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_coste_articulo2
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_coste_articulo2
event clicked pbm_bnclicked
integer x = 4709
integer y = 128
integer taborder = 0
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type pb_2 from upb_carpeta within w_con_coste_articulo2
integer x = 2373
integer y = 128
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;  f_activar_campo(uo_1.em_campo)
  str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="w_con_articulos_tencer"
  lstr_param.s_argumentos[2]= uo_1.em_codigo.text
  OpenWithParm(wi_mant_formatos,lstr_param)

end event

type uo_1 from u_em_campo_2 within w_con_coste_articulo2
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 136
integer width = 2030
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_coste_articulo2
integer x = 4384
integer y = 128
integer width = 315
integer height = 96
integer taborder = 30
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;str_escandallo escandallo[300]
datastore ds_operaciones
integer indice, k, piezascaja
string articulo, sel, formato, v_Articulo, v_tipooper, v_cliente, v_tarifa
long actual, i, v_ordenoperacion
decimal factor, velocidad, correccion_velocidad, v_velocidad_std, v_largo, v_ancho , v_coste
decimal {6} v_coste_fab, v_factor_operacion,  v_coste_mp, v_precio_Venta, coste_estr, v_coste_mp_mermas, v_coste_fab_mermas, metroscaja, v_coste_packing, v_coste_compras
decimal {6} piezas_m2, v_precio_m2

datetime v_fecha, desde, hasta
integer nivel
String unidad
str_costes costes

nivel = 0
v_fecha = datetime(RelativeDate ( today(), -365 ))
desde = datetime(em_fdesde.text)
hasta = datetime(em_fhasta.text)

dw_1.setredraw(false)

dw_1.reset()


SELECT TOP 1 articulos.unidad, almartcajas.metroscaja, isnull(almartcajas.piezascaja , 0)
INTO :unidad, :metroscaja, :piezascaja 
FROM articulos 
LEFT JOIN almartcajas ON articulos.empresa = almartcajas.empresa AND articulos.codigo = almartcajas.articulo AND almartcajas.pordefecto = 'S' 
WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :uo_1.em_codigo.text;

if piezascaja = 0 or metroscaja = 0 then
	piezas_m2 = 0
else
	piezas_m2 = 1 / (metroscaja / piezascaja)   //Piezas que tiene un m2 
end if

// CÁLCULO DEL PRECIO
coste_estr = 0

v_precio_Venta = f_precio_minimo (codigo_empresa, uo_1.em_codigo.text, '1')

// FIN CÁLCULO DEL PRECIO

v_precio_m2 = v_precio_venta

//PRECIO SEGÚN UNIDAD ARTICULO 01/10/2015 
if unidad = '1' THEN
	IF metroscaja <> 0 and piezascaja <> 0 then
		v_precio_Venta = v_precio_Venta / ((1 / metroscaja) * piezascaja)
	ELSE 
		v_precio_Venta = 0
	END IF
end if

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
	f_mensaje("Consulta de Artículos","Introduzca el artículo")
	f_activar_campo(uo_1.em_campo)
	return
else
	articulo = uo_1.em_codigo.text
end if

select formatos.abreviado
into :formato
from formatos, articulos
where formatos.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and articulos.formato = formatos.codigo
and articulos.codigo = :uo_1.em_codigo.text;


dw_1.object.t_articulo.text = string(uo_1.em_campo.text)+ "      (Cálculos realizados en "+lower(f_nombre_unidad(unidad))+")"
dw_1.object.t_formato.text = string(formato)

indice = 1
factor = 1
f_escandallo_factores(escandallo, articulo, indice, factor, nivel)

for k = 1 to indice
	if escandallo[k].version = '1' then
		costes = f_calculo_coste_elemento (codigo_empresa, escandallo[k].articulo)
		
		sel = " select art_ver_operaciones.articulo, art_ver_operaciones.orden,  "+& 
				" art_ver_operaciones.tipo_operacion as tipooper, art_ver_tipooperacion.correccion_velocidad, art_ver_tipooperacion.velocidad_Std, "+&
				" art_ver_tipooperacion.descripcion_abr, articulos.cliente , art_ver_tipooperacion.coste"+&
				" from art_ver_operaciones, art_ver_tipooperacion, articulos, art_versiones "+&
				" where art_ver_tipooperacion.empresa = '"+codigo_empresa+"' "+&
				" and art_ver_operaciones.empresa =  '"+codigo_empresa+"' "+&
				" and articulos.empresa =  '"+codigo_empresa+"' "+&
				" and art_ver_operaciones.tipo_operacion = art_Ver_tipooperacion.codigo "+&
				" and art_ver_operaciones.articulo = '"+escandallo[k].articulo+"' "+&
				" and art_ver_operaciones.articulo = articulos.codigo "+&
				" and art_ver_operaciones.empresa = art_versiones.empresa "+&
				" and art_ver_operaciones.articulo = art_versiones.articulo "+&
				" and art_ver_operaciones.version = art_versiones.version " +&
				" and art_versiones.version = '1' "+&
				" order by art_ver_operaciones.orden"
			
		f_cargar_cursor_nuevo(sel, ds_operaciones)
		
		for i = 1 to ds_operaciones.rowcount()
			v_articulo = ds_operaciones.object.art_ver_operaciones_articulo[i]
			v_ordenoperacion = long(ds_operaciones.object.art_ver_operaciones_orden[i])
			correccion_velocidad = ds_operaciones.object.art_ver_tipooperacion_correccion_velocidad[i]
			v_coste = ds_operaciones.object.art_ver_tipooperacion_coste[i] 
			v_tipooper = ds_operaciones.object.art_ver_operaciones_tipooper[i]
			v_coste_mp = costes.coste_mp
			v_coste_fab = costes.coste_fab
			v_coste_mp_mermas = costes.coste_mp_mermas
			v_coste_fab_mermas = costes.coste_fab_mermas
			v_coste_packing = costes.coste_packing
			v_coste_compras = costes.coste_compras
			
			v_cliente = ds_operaciones.object.articulos_cliente[i]
			
	/*		
			v_velocidad_std = ds_operaciones.object.art_ver_tipooperacion_velocidad_Std[i]
			velocidad = 0
		
			SELECT sum(prodpartes_ot.buenas ) / (sum( prodpartes_ot.segundos / 3600  ))
			INTO :velocidad
			FROM prodpartes_ot, art_ver_tipooperacion, articulos
			WHERE prodpartes_ot.empresa = art_ver_tipooperacion.empresa AND
			prodpartes_ot.operacion = art_ver_tipooperacion.codigo AND
			prodpartes_ot.empresa = articulos.empresa AND
			prodpartes_ot.articulo = articulos.codigo AND
			prodpartes_ot.empresa = 1 AND 
			prodpartes_ot.articulo = :v_articulo AND
			( prodpartes_ot.seccion <> '8' or ( prodpartes_ot.seccion = '8' and  prodpartes_ot.linea = '19' ) ) AND	 // Exluímos los partes del Pulmón
			prodpartes_ot.ordenoperacion = :v_ordenoperacion AND
			prodpartes_ot.segundos > 0 AND
			prodpartes_ot.version =1 AND
			prodpartes_ot.fecha >= :desde AND
			prodpartes_ot.fecha <= :hasta;			
			
			if velocidad = 0 or isnull(velocidad) then
				velocidad = v_velocidad_std * escandallo[k].factor 
			else
				velocidad = velocidad * escandallo[k].factor 
			end if
	*/		
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
			dec piezas_hora, coste_std, tipo_operacion
	
			SELECT sum(prodpartes_ot.buenas ) / (sum( prodpartes_ot.segundos / 3600  ))
			INTO :velocidad
			FROM prodpartes_ot, art_ver_tipooperacion, articulos
			WHERE prodpartes_ot.empresa = art_ver_tipooperacion.empresa AND
			prodpartes_ot.operacion = art_ver_tipooperacion.codigo AND
			prodpartes_ot.empresa = articulos.empresa AND
			prodpartes_ot.articulo = articulos.codigo AND
			prodpartes_ot.empresa = 1 AND 
			prodpartes_ot.articulo = :v_articulo AND
			( prodpartes_ot.seccion <> '8' or ( prodpartes_ot.seccion = '8' and  prodpartes_ot.linea = '19' ) ) AND	 // Exluímos los partes del Pulmón
			prodpartes_ot.ordenoperacion = :v_ordenoperacion AND
			prodpartes_ot.segundos > 0 AND
			prodpartes_ot.version =1 AND
			prodpartes_ot.ajuste <> 'S' AND
			prodpartes_ot.fecha >= :desde AND
			prodpartes_ot.fecha <= :hasta;			
			
			piezas_hora = velocidad // * 3600
			
			select coste, correccion_velocidad
			into :coste_std, :correccion_velocidad
			from art_ver_tipooperacion
			where	empresa = :codigo_empresa
			and codigo = :v_tipooper ;
			
			if piezas_hora = 0 or correccion_velocidad = 0 or isnull(piezas_hora) or isnull(correccion_velocidad) then 
				v_coste_fab = 0
			else
				v_coste_fab = ( coste_std / ( piezas_hora * correccion_velocidad ) )
			end if
			
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&			

// *****************************************************************************			
			
			v_coste_fab  = v_coste_fab / escandallo[k].factor
			v_coste_mp = v_coste_mp / escandallo[k].factor
			v_coste_fab_mermas  = v_coste_fab_mermas / escandallo[k].factor
			v_coste_mp_mermas = v_coste_mp_mermas / escandallo[k].factor
			v_coste_compras = v_coste_compras / escandallo[k].factor
			
			if isnull(v_coste_fab ) then v_coste_fab = 0
			if isnull(v_coste_mp ) then v_coste_mp = 0
			if isnull(v_coste_fab_mermas ) then v_coste_fab_mermas = 0
			if isnull(v_coste_mp_mermas ) then v_coste_mp_mermas = 0
			if isnull(v_coste_compras) then v_coste_compras = 0
			
// *****************************************************************************			
	
			actual = dw_1.insertrow(0)
			dw_1.object.cod_articulo[actual] = v_articulo
			dw_1.object.des_articulo[actual] = f_nombre_articulo (codigo_empresa, escandallo[k].articulo)
			dw_1.object.operacion[actual] = ds_operaciones.object.art_ver_tipooperacion_descripcion_abr[i]
			
			dw_1.object.velocidad[actual] = round(velocidad , 0) 
			dw_1.object.correccion[actual] = correccion_velocidad
			dw_1.object.coste_hora[actual] = v_coste
			
			if unidad = '1' then
				dw_1.object.coste_operacion[actual] = v_coste_fab * piezas_m2
				dw_1.object.importe_mp[actual] = v_coste_mp * piezas_m2
				dw_1.object.coste_fab_mermas[actual] = v_coste_fab_mermas * piezas_m2
				dw_1.object.coste_mp_mermas[actual] = v_coste_mp_mermas * piezas_m2
				dw_1.object.precio[actual] = v_precio_m2
				dw_1.object.coste_packing[actual] = v_coste_packing * piezas_m2
				dw_1.object.coste_compras[actual] = v_coste_compras * piezas_m2
				
			else
				dw_1.object.coste_operacion[actual] = v_coste_fab
				dw_1.object.importe_mp[actual] = v_coste_mp
				dw_1.object.coste_fab_mermas[actual] = v_coste_fab_mermas
				dw_1.object.coste_mp_mermas[actual] = v_coste_mp_mermas
				dw_1.object.precio[actual] = v_precio_venta
				dw_1.object.coste_packing[actual] = v_coste_packing 
				dw_1.object.coste_compras[actual] = v_coste_compras 

			end if

			dw_1.object.estructura[actual] = coste_estr
			dw_1.object.orden[actual] = k
		next
		destroy ds_operaciones
	end if			
next

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if



dw_1.groupcalc()
dw_1.setredraw(true)

destroy ds_operaciones

end event

type cbx_estructural from checkbox within w_con_coste_articulo2
integer x = 3675
integer y = 140
integer width = 544
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Coste Estructural"
boolean lefttext = true
end type

type cb_2 from commandbutton within w_con_coste_articulo2
boolean visible = false
integer x = 1902
integer y = 128
integer width = 416
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coste Prueba"
end type

event clicked;dec coste_mp , coste_fab

f_calculo_coste_articulo_mp_fab (codigo_empresa, uo_1.em_codigo.text, coste_mp, coste_fab, true)

messagebox ("FIN",STRING ( coste_mp + coste_fab))
end event

type cb_3 from commandbutton within w_con_coste_articulo2
boolean visible = false
integer x = 1554
integer y = 1860
integer width = 1957
integer height = 604
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Récalculo del coste de las mermas de todos los artículos."
end type

event clicked;datastore regs
string sel, articulo
long i
boolean correcto

connect using SQLCA;

sel =	" select distinct articulo as articulo from prodpartes_ot "+&
		" where ot_terminada = 'S' "+&
		" and operacion = '9' "
		
f_cargar_cursor_nuevo (sel, regs )
correcto = true
for i = 1 to regs.rowcount()
	articulo = regs.object.articulo[i]
	f_calculo_coste_mermas (codigo_empresa, articulo, '1')
	
	if SQLCA.SQLCode <> 0 then
		correcto = false
	end if
	f_mensaje_proceso ("Reg: ", i, regs.rowcount())
next

if not correcto then
	f_mensaje("Atención","Hubo un error al cálcular el coste. ")
	rollback using SQLCA;
else
	commit using SQLCA;	
end if




end event

type em_fdesde from u_em_campo within w_con_coste_articulo2
integer x = 2743
integer y = 144
integer width = 288
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_coste_articulo2
integer x = 3259
integer y = 144
integer width = 288
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_coste_articulo2
integer x = 2537
integer y = 156
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_coste_articulo2
integer x = 3035
integer y = 160
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

