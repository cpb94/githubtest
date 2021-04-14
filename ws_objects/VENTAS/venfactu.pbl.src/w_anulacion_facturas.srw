$PBExportHeader$w_anulacion_facturas.srw
forward
global type w_anulacion_facturas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_anulacion_facturas
end type
type dw_listado from datawindow within w_anulacion_facturas
end type
type uo_cliente from u_em_campo_2 within w_anulacion_facturas
end type
type gb_1 from groupbox within w_anulacion_facturas
end type
type dw_1 from datawindow within w_anulacion_facturas
end type
type dw_detalle from u_datawindow_consultas within w_anulacion_facturas
end type
end forward

global type w_anulacion_facturas from w_int_con_empresa
integer width = 2949
integer height = 1676
pb_1 pb_1
dw_listado dw_listado
uo_cliente uo_cliente
gb_1 gb_1
dw_1 dw_1
dw_detalle dw_detalle
end type
global w_anulacion_facturas w_anulacion_facturas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_procesar ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end subroutine

public subroutine f_procesar ();Dec var_anyo,var_factura,var_linea
Dec ro,r,con
Boolean bien
bien  = TRUE
Long no_existe_albaran
DataStore  dd
String sel, actualizada,ls_venconductores_codigo,ls_remolque,ls_matricula

str_venlialb ln
str_venalb   alb


ro = dw_detalle.GetRow()
var_anyo     = dw_detalle.GetItemNumber(ro,"anyo")
var_factura  = dw_detalle.GetItemNumber(ro,"factura")

IF MessageBox("Proceso Anulación de Facturas","¿Desea anular la factura seleccionada?",Question!,YesNo!,2) = 2 Then Return

no_existe_albaran = 0
SELECT COUNT(*) INTO :no_existe_albaran FROM venfac
WHERE venfac.empresa       = :codigo_empresa 
	AND   venfac.anyo          = :var_anyo 
	AND   venfac.factura       = :var_factura AND (venfac.albaran IS NULL OR venfac.albaran = 0);
if no_existe_albaran > 0 then
	MessageBox("Error Borrado", "La factura "+String(var_factura)+" no procede de un albarán. Borrela del mantenimiento de facturas.")
	return
	destroy dd
end if

no_existe_albaran = 0
SELECT COUNT(*) INTO :no_existe_albaran FROM venlifac
WHERE venlifac.empresa       = :codigo_empresa 
	AND   venlifac.anyo          = :var_anyo 
	AND   venlifac.factura       = :var_factura AND (venlifac.albaran IS NULL OR venlifac.albaran = 0);
	
if no_existe_albaran > 0 then
	MessageBox("Error Borrado", "No se puede eliminar la factura "+String(var_factura)+" por no contener datos del albarán en alguna de sus lineas")
	return
	destroy dd
end if

SELECT venfac.observaciones,venfac.codpago,   
		         venfac.agente1, venfac.agente2, 
		         venfac.comision11,   
      		   venfac.comision21,   
		         venfac.comision12,   
					venfac.comision22,   
					venfac.dtopp,   
					venfac.dtoesp1,   
					venfac.dtoesp2,   
					venfac.dtoesp3,   
					venfac.dtoesp4,   
					venfac.tipodto1,   
					venfac.tipodto2,   
					venfac.tipodto3,   
					venfac.tipodto4,   
					venfac.explicaciondto1,   
					venfac.explicaciondto2,   
					venfac.explicaciondto3,   
					venfac.explicaciondto4,   
					venfac.tipoiva,   
					venfac.iva,   
					venfac.idioma,   
					venfac.divisa,   
					venfac.cambio,   
					venfac.tarifa,   
					venfac.ftarifa,   
					venfac.fbloqueo,   
					venfac.transportista,   
					venfac.serie,   
					venfac.zona,   
					venfac.envio,   
					venfac.correspondencia,   
					venfac.domiciliacion,   
					venfac.forma_envio,   
					venfac.cod_entrega,   
					venfac.usuario,   
					venfac.tipo_portes,   
					venfac.periodo_fac,   
					venfac.peso,   
					venfac.usuario_pedido,   
					venfac.agente3,   
					venfac.comision31,   
					venfac.comision32,   
					venfac.veces,   
					venfac.textcomercial1,   
					venfac.textcomercial2,   
					venfac.textaduanaesp1,   
					venfac.textaduanaesp2,   
					venfac.textaduanaext1,   
					venfac.textaduanaext2,   
					venfac.textopie1,   
					venfac.textopie2,   
					venfac.condicion,   
					venfac.peso_neto,   
					venfac.banco_de_cobro,   
					venfac.porcentaje_aduana,   
					venfac.bruto,   
					venfac.importe_dto,   
					venfac.total_neto,   
					venfac.calculo_dto,   
					venfac.anyo_pedido_origen,   
					venfac.pedido_origen,   
					venfac.fcarga,   
					venfac.anyo,   
					venfac.agrupa,   
					venfac.contenedor,   
					venfac.dtoesp,   
					venfac.calculo_dtoesp,
					venfac.almacen_deposito,
					venfac.actualizada,
					venfac.peso_bascula_kg,
					venfac.expedicion_anyo,
					venfac.expedicion_codigo
    INTO :alb.observaciones,   
         :alb.codpago,   
         :alb.agente1,   
         :alb.agente2,   
         :alb.comision1,   
         :alb.comision2,   
         :alb.comision11,   
         :alb.comision22,   
         :alb.dtopp,   
         :alb.dtoesp1,   
         :alb.dtoesp2,   
         :alb.dtoesp3,   
         :alb.dtoesp4,   
         :alb.tipodto1,   
         :alb.tipodto2,   
         :alb.tipodto3,   
         :alb.tipodto4,   
         :alb.explicaciondto1,   
         :alb.explicaciondto2,   
         :alb.explicaciondto3,   
         :alb.explicaciondto4,   
         :alb.tipoiva,   
         :alb.iva,   
         :alb.idioma,   
         :alb.divisa,   
         :alb.cambio,   
         :alb.tarifa,   
         :alb.ftarifa,   
         :alb.fbloqueo,   
         :alb.transportista,   
         :alb.serie,   
         :alb.zona,   
         :alb.envio,   
         :alb.correspondencia,   
         :alb.domiciliacion,   
         :alb.forma_envio,   
         :alb.cod_entrega,   
         :alb.usuario,   
         :alb.tipo_portes,   
         :alb.periodo_fac,   
         :alb.peso,   
         :alb.usuario_pedido,   
         :alb.agente3,   
         :alb.comision31,   
         :alb.comision32,   
         :alb.veces,   
         :alb.textcomercial1,   
         :alb.textcomercial2,   
         :alb.textaduanaesp1,   
         :alb.textaduanaesp2,   
         :alb.textaduanaext1,   
         :alb.textaduanaext2,   
         :alb.textopie1,   
         :alb.textopie2,   
         :alb.condicion,   
         :alb.peso_neto,   
         :alb.banco_de_cobro,   
         :alb.porcentaje_aduana,   
         :alb.bruto,   
         :alb.importe_dto,   
         :alb.total_neto,   
         :alb.calculo_dto,   
         :alb.anyo_pedido_origen,   
         :alb.pedido_origen,   
         :alb.fcarga,   
         :alb.anyo,   
         :alb.agrupa,   
	      :alb.contenedor,   
         :alb.dtoesp,   
         :alb.calculo_dto, 
			:alb.almacen_deposito,
			:actualizada,
			:alb.peso_bascula_kg,
			:alb.expedicion_anyo,
			:alb.expedicion_codigo
    FROM venfac  
   WHERE ( venfac.empresa = :codigo_empresa ) AND  
         ( venfac.anyo = :var_anyo ) AND  
         ( venfac.factura = :var_factura )   ;
		IF SQLCA.SQLCODE <>  0 Then bien = FALSE
		
if actualizada = "S" then
	MessageBox("Error Borrado", "No se puede eliminar la factura "+String(var_factura)+" por estar contabilizada.")
	return
	destroy dd
end if
		
		
	// Si no informamos este campo, después no se puede facturar el albarán
	alb.deposito="N"

sel = " Select linea_factura from venlifac "+&
		" Where empresa = '" + codigo_empresa +"'" +&
		" And   anyo    =  " + String(var_anyo,"####") + &
		" And   factura =  " + String(var_factura,"###########")
		
//dd = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, dd)
IF dd.RowCount() = 0  Then bien = FALSE
		  

For r = 1 To dd.RowCount()
	var_linea = dd.GetItemNumber(r,"linea_factura")
	  SELECT venlifac.empresa,   
         venlifac.anyo_albaran,   
         venlifac.albaran,   
         venlifac.linea,   
         venlifac.serie,   
         venlifac.falbaran,   
         venlifac.fentrega,   
         venlifac.cliente,   
         venlifac.tipo_unidad,   
         venlifac.articulo,   
         venlifac.familia,   
         venlifac.formato,   
         venlifac.modelo,   
         venlifac.calidad,   
         venlifac.tonochar,   
         venlifac.calibre,   
         venlifac.precio,   
         venlifac.precio_estand,   
         venlifac.cantidad,   
         venlifac.pallets,   
         venlifac.total_cajas,   
         venlifac.cajas,   
         venlifac.dtocomer,   
         venlifac.dtoesp,   
         venlifac.descripcion,   
         venlifac.tipoiva,   
         venlifac.iva,   
         venlifac.linfab,   
         venlifac.provincia,   
         venlifac.pais,   
         venlifac.zona,   
         venlifac.tipolinea,   
         venlifac.texto1,   
         venlifac.texto2,   
         venlifac.texto3,   
         venlifac.texto4,   
         venlifac.referencia,   
         venlifac.montajeartcal,   
         venlifac.situacion,   
         venlifac.divisa,   
         venlifac.metros_lineales,   
         venlifac.peso,   
         venlifac.falta,   
         venlifac.usuario,   
         venlifac.tipo_pallet,   
         venlifac.caja,			
         venlifac.importe,   
         venlifac.descuento,   
         venlifac.importedto,   
         venlifac.clase,   
         venlifac.sector,   
         venlifac.agente1,   
         venlifac.agente2,   
         venlifac.agente3,   
         venlifac.comision11,   
         venlifac.comision12,   
         venlifac.comision21,   
         venlifac.comision22,   
         venlifac.comision31,   
         venlifac.comision32,   
         venlifac.deposito,   
         venlifac.orden_preparacion,   
         venlifac.cantidad_prepa,   
         venlifac.es_pico,   
         venlifac.numero_pico,   
         venlifac.operario_prepa,   
         venlifac.control_incremento,   
         venlifac.peso_neto,   
         venlifac.precio_aduana,   
         venlifac.control_descuentos,   
         venlifac.control_comisiones,   
         venlifac.importe_aduana,   
         venlifac.bruto,   
         venlifac.precio_neto,   
         venlifac.precio_aduana_neto,   
         venlifac.descuento_aduana,   
         venlifac.neto,   
         venlifac.impdtopp,   
         venlifac.ref_cli,   
         venlifac.transportista,   
         venlifac.pedido_origen,   
         venlifac.fcarga,   
         venlifac.envio,   
         venlifac.contenedor,   
         venlifac.numpedcli,   
         venlifac.anyo_pedido_origen,
			venlifac.ubicacion,
			venlifac.linea_pedido_origen,
			venlifac.anyo_alb_comp,
			venlifac.albaran_comp,
			venlifac.lin_alb_comp,
			venlifac.anyo_alb_otra,
			venlifac.albaran_otra,
			venlifac.lin_alb_otra,
			venlifac.cantidad_pedido,
			venlifac.almacen_de_carga,
			venlifac.dtoesp2,
			venlifac.fpedido_origen,
			venlifac.numpalet,
			venlifac.anyo_proddiaria,
			venlifac.contador_proddiaria,
			venlifac.idioma,
			venlifac.cantidad_original,
			venlifac.linea_desdoblada_de,
			venlifac.fecha_linped,
			venlifac.factura_deposito,
			venlifac.peso_bruto_venalb,
			venlifac.peso_neto_venalb,
			venlifac.expedicion_anyo_venalb,
			venlifac.expedicion_codigo_venalb,
			venlifac.bultos_venalb,
			venlifac.observaciones_venalb,
			venlifac.forma_envio_venalb,
			venlifac.matricula,
			venlifac.precinto,
			venlifac.conductor,
			venlifac.venconductores_codigo,
			venlifac.remolque,
			venlifac.tono_imprimir,
			venlifac.calibre_imprimir,
			venlifac.id_alm_orden_carga,
			venlifac.ordenacion_orden_carga,
			venlifac.bulto_desde_orden_carga,
			venlifac.bulto_hasta_orden_carga,
			venlifac.cantidad_pzs,
			venlifac.precio_pzs,
			venlifac.id_alm_orden_preparacion 
    INTO :ln.empresa,   
         :ln.anyo,   
         :ln.albaran,   
         :ln.linea,   
         :ln.serie,   
         :ln.falbaran,   
         :ln.fentrega,   
         :ln.cliente,   
         :ln.tipo_unidad,   
         :ln.articulo,   
         :ln.familia,   
         :ln.formato,   
         :ln.modelo,   
         :ln.calidad,   
         :ln.tonochar,   
         :ln.calibre,   
         :ln.precio,   
         :ln.precio_estand,   
         :ln.cantidad,   
         :ln.pallets,   
         :ln.total_cajas,   
         :ln.cajas,   
         :ln.dtocomer,   
         :ln.dtoesp,   
         :ln.descripcion,   
         :ln.tipoiva,   
         :ln.iva,   
         :ln.linfab,   
         :ln.provincia,   
         :ln.pais,   
         :ln.zona,   
         :ln.tipolinea,   
         :ln.texto1,   
         :ln.texto2,   
         :ln.texto3,   
         :ln.texto4,   
         :ln.referencia,   
         :ln.montajeartcal,   
         :ln.situacion,   
         :ln.divisa,   
         :ln.metros_lineales,   
         :ln.peso,   
         :ln.falta,   
         :ln.usuario,   
         :ln.tipo_pallet,   
         :ln.caja,			
         :ln.importe,   
         :ln.descuento,   
         :ln.importedto,   
         :ln.clase,   
         :ln.sector,   
         :ln.agente1,   
         :ln.agente2,   
         :ln.agente3,   
         :ln.comision11,   
         :ln.comision12,   
         :ln.comision21,   
         :ln.comision22,   
         :ln.comision31,   
         :ln.comision32,   
         :ln.deposito,   
         :ln.orden_preparacion,   
         :ln.cantidad_prepa,   
         :ln.es_pico,   
         :ln.numero_pico,   
         :ln.operario_prepa,   
         :ln.control_incremento,   
         :ln.peso_neto,   
         :ln.precio_aduana,   
         :ln.control_descuentos,   
         :ln.control_comisiones,   
         :ln.importe_aduana,   
         :ln.bruto,   
         :ln.precio_neto,   
         :ln.precio_aduana_neto,   
         :ln.descuento_aduana,   
         :ln.neto,   
         :ln.impdtopp,   
         :ln.ref_cli,   
         :ln.transportista,   
         :ln.pedido_origen,   
         :ln.fcarga,   
         :ln.envio,   
         :ln.contenedor,   
         :ln.numpedcli,   
         :ln.anyo_pedido_origen,
			:ln.ubicacion,
			:ln.linea_pedido_origen,
			:ln.anyo_alb_comp,
			:ln.albaran_comp,
			:ln.lin_alb_comp,
			:ln.anyo_alb_otra,
			:ln.albaran_otra,
			:ln.lin_alb_otra,
			:ln.cantidad_pedido,
			:ln.almacen_de_carga,
			:ln.dtoesp2,
			:ln.fpedido_origen,
			:ln.numpalet,
			:ln.anyo_proddiaria,
			:ln.contador_proddiaria,
			:ln.idioma,
			:ln.cantidad_original,
			:ln.linea_desdoblada_de,
			:ln.fecha_linped,
			:ln.albaran_deposito, 
			:ln.peso_bruto_venalb,
			:ln.peso_neto_venalb,
			:ln.expedicion_anyo_venalb,
			:ln.expedicion_codigo_venalb,
			:ln.bultos_venalb,
			:ln.observaciones_venalb,
			:ln.forma_envio_venalb,
			:ls_matricula,
			:ln.precinto,
			:ln.conductor_venalb,
			:ls_venconductores_codigo,
			:ls_remolque,
			:ln.tono_imprimir,
			:ln.calibre_imprimir,
			:ln.id_alm_orden_carga,
			:ln.ordenacion_orden_carga,
			:ln.bulto_desde_orden_carga,
			:ln.bulto_hasta_orden_carga,
			:ln.cantidad_pzs,
			:ln.precio_pzs,
			:ln.id_alm_orden_preparacion 
    FROM venlifac  
   WHERE venlifac.empresa       = :codigo_empresa 
	AND   venlifac.anyo          = :var_anyo 
	AND   venlifac.factura       = :var_factura 
	AND   venlifac.linea_factura = :var_linea;
	IF SQLCA.SQLCODE <>  0 Then 
		bien = FALSE
	END IF
	alb.empresa = codigo_empresa
	alb.anyo = ln.anyo
	alb.albaran= ln.albaran
	alb.falbaran = ln.falbaran
	alb.fentrega = ln.fentrega
	alb.falta = DateTime(Today(),Now())
	ln.falta = DateTime(Today(),Now())
	alb.cliente     = ln.cliente
	//alb.numpedcli   = ln.numpedcli
	alb.contenedor  = ln.contenedor
	alb.precinto = ln.precinto
	alb.matricula = ls_matricula
	alb.remolque = ls_remolque
	alb.transportista = ln.transportista
	alb.venconductores_codigo = ls_venconductores_codigo
	
	ln.situacion = "C"
	
	Select Count(*) Into :con From venalb
	Where  venalb.empresa = :ln.empresa
	And    venalb.anyo    = :ln.anyo
	And    venalb.albaran = :ln.albaran;
	IF IsNull(con) Then con= 0
	IF con = 0 Then
		IF Not f_insertar_venalb(alb) Then bien = FALSE	
	END IF
	IF IsNull(ln.deposito) Then ln.deposito = "N"
	IF Not f_insertar_venlialb(ln) Then bien = FALSE	
	IF Not f_actualizar_linea_venalbaran(ln.empresa,ln.anyo,ln.albaran,ln.linea) Then bien = FALSE	
	IF Not f_actualizar_venalbaran(ln.empresa,ln.anyo,ln.albaran) Then bien = FALSE	
	
	Delete from venlifac
	 WHERE venlifac.empresa = :codigo_empresa
	 AND   venlifac.anyo    = :var_anyo 
	 AND   venlifac.factura = :var_factura
 	 AND   venlifac.linea_factura   = :var_linea;
	IF SQLCA.SQLCODE <>  0 Then bien = FALSE
f_mensaje_proceso("Procesando",r,dd.RowCOunt())
Next
	Delete from venfac
		 WHERE venfac.empresa = :codigo_empresa
		 AND   venfac.anyo    = :var_anyo 
		 AND   venfac.factura = :var_factura;
 		IF SQLCA.SQLCODE <>  0 Then bien = FALSE
		 
		 
IF bien Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La Operacion no se actualiza")
END IF

destroy dd

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Anulacion Facturas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on w_anulacion_facturas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.uo_cliente
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_detalle
end on

on w_anulacion_facturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_detalle)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
f_cursor_abajo(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_anulacion_facturas
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_anulacion_facturas
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_anulacion_facturas
integer x = 9
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_anulacion_facturas
integer x = 2715
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_anulacion_facturas
boolean visible = false
integer x = 1957
integer y = 92
integer width = 160
integer height = 252
boolean bringtotop = true
string dataobject = "report_con_factura_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_anulacion_facturas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 55
integer y = 184
integer width = 1783
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_1.Reset()
dw_detalle.Reset()
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_anulacion_facturas
integer x = 5
integer y = 100
integer width = 1879
integer height = 196
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type dw_1 from datawindow within w_anulacion_facturas
integer x = 928
integer y = 316
integer width = 1934
integer height = 1128
boolean bringtotop = true
string dataobject = "dw_anulacion_facturas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(this)= "procesar" Then
	f_procesar()
	f_control()
END IF
	
end event

type dw_detalle from u_datawindow_consultas within w_anulacion_facturas
integer y = 316
integer width = 928
integer height = 1128
integer taborder = 0
string dataobject = "dw_anulacion_facturas"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;Integer linea
long altura=0,c

IF dw_detalle.RowCount()=0 then return
linea = currentrow

dec v_factura,v_anyo
v_factura = dw_detalle.getItemNumber(linea,"factura")
v_anyo    = dw_detalle.getItemNumber(linea,"anyo")

dw_1.reset()
dw_1.retrieve(codigo_empresa,v_anyo,v_factura)

end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF rowCount() = 0 Then Return
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

event retrieveend;call super::retrieveend;//
//IF rowcount = 0 Then Return
//SetRow(1)
//dec v_factura,v_anyo
//v_factura=dw_detalle.getItemNumber(1,"factura")
//v_anyo=dw_detalle.getItemNumber(1,"anyo")
//dw_1.reset()
//dw_1.retrieve(codigo_empresa,v_anyo,v_factura)
//
end event

