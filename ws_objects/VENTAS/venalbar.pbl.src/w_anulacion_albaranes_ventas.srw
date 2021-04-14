$PBExportHeader$w_anulacion_albaranes_ventas.srw
forward
global type w_anulacion_albaranes_ventas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_anulacion_albaranes_ventas
end type
type st_2 from statictext within w_anulacion_albaranes_ventas
end type
type dw_listado from datawindow within w_anulacion_albaranes_ventas
end type
type uo_cliente from u_em_campo_2 within w_anulacion_albaranes_ventas
end type
type gb_1 from groupbox within w_anulacion_albaranes_ventas
end type
type cb_continuar from commandbutton within w_anulacion_albaranes_ventas
end type
type dw_detalle from u_datawindow_consultas within w_anulacion_albaranes_ventas
end type
type cb_marcar from commandbutton within w_anulacion_albaranes_ventas
end type
type dw_detalle2 from u_datawindow_consultas within w_anulacion_albaranes_ventas
end type
type cb_procesar from commandbutton within w_anulacion_albaranes_ventas
end type
type cb_desmarcar from commandbutton within w_anulacion_albaranes_ventas
end type
type dw_proceso_alb from datawindow within w_anulacion_albaranes_ventas
end type
type gb_2 from groupbox within w_anulacion_albaranes_ventas
end type
type gb_3 from groupbox within w_anulacion_albaranes_ventas
end type
end forward

global type w_anulacion_albaranes_ventas from w_int_con_empresa
integer width = 4594
integer height = 3176
pb_1 pb_1
st_2 st_2
dw_listado dw_listado
uo_cliente uo_cliente
gb_1 gb_1
cb_continuar cb_continuar
dw_detalle dw_detalle
cb_marcar cb_marcar
dw_detalle2 dw_detalle2
cb_procesar cb_procesar
cb_desmarcar cb_desmarcar
dw_proceso_alb dw_proceso_alb
gb_2 gb_2
gb_3 gb_3
end type
global w_anulacion_albaranes_ventas w_anulacion_albaranes_ventas

type variables
Dec  d
String otra_empresa
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_detalle (integer reg)
public subroutine f_anular ()
public function boolean f_entrada_almacen (str_venliped l, string ubicacion)
public function boolean f_salida_almacen_deposito (string empresa, string almacen, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja, decimal cantidad, long albaran, string cliente)
end prototypes

public subroutine f_control ();STring   cli1,cli2
dw_detalle.Reset()
dw_detalle2.Reset()

IF uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	cli1 = '%'
else
	cli1 = 	uo_cliente.em_codigo.text
end if


dw_detalle.Retrieve(codigo_empresa,cli1)
f_activar_campo(uo_cliente.em_campo)


end subroutine

public subroutine f_detalle (integer reg);IF reg = 0 Then Return
IF dw_detalle.RowCount() = 0 Then Return
dw_detalle2.Retrieve(codigo_empresa,dw_detalle.GetItemNumber(reg,"anyo"),dw_detalle.GetItemNumber(reg,"albaran"))
end subroutine

public subroutine f_anular ();Dec  r,r1,anyo,albaran,linea,bien,pedido,anyo_ped,numero
String ubicacion
Dec{0} var_anyo_otra, var_albaran_otra, var_lin_alb_otra
Dec{0} var_anyo_comp, var_albaran_comp, var_lin_alb_comp
long   ll_pallets_albaran

Str_venliped l
Str_venped p
l.empresa = codigo_empresa
bien = 0 
r1 = dw_detalle2.RowCount()	
IF Not f_bloquear_albaranes(w_anulacion_albaranes_ventas.title) Then
// Proceso de Anulacion albaranes
For r = 1 To r1
	IF dw_detalle2.GetItemSTring(r,"cmarca") = "S" Then
		// Proceso linea a anular
		anyo      = dw_detalle2.GetItemNumber(r,"venlialb_anyo")
		albaran   = dw_detalle2.GetItemNumber(r,"venlialb_albaran")
		linea     = dw_detalle2.GetItemNumber(r,"venlialb_linea")
		anyo_ped  = dw_detalle2.GetItemNumber(r,"venlialb_anyo_pedido_origen")
		pedido    = dw_detalle2.GetItemNumber(r,"venlialb_pedido_origen")
		
		  SELECT     venlialb.serie,  venlialb.falbaran, venlialb.fentrega,   
         venlialb.cliente,        venlialb.tipo_unidad,  venlialb.articulo,   
         venlialb.familia,        venlialb.formato,      venlialb.modelo,   
         venlialb.calidad,        venlialb.tonochar,     venlialb.calibre,   
         venlialb.precio,         venlialb.precio_estand,venlialb.cantidad,   
         venlialb.pallets,        venlialb.total_cajas,  venlialb.cajas,   
         venlialb.dtocomer,       venlialb.dtoesp,       venlialb.descripcion,   
         venlialb.tipoiva,        venlialb.iva,          venlialb.linfab,   
         venlialb.provincia,      venlialb.pais,         venlialb.zona,   
         venlialb.tipolinea,      venlialb.texto1,       venlialb.texto2,   
         venlialb.texto3,         venlialb.texto4,       venlialb.referencia,   
         venlialb.montajeartcal,  venlialb.situacion,    venlialb.divisa,   
         venlialb.metros_lineales,venlialb.peso,         venlialb.falta,   
         venlialb.usuario, venlialb.tipo_pallet,  
		venlialb.caja,           venlialb.importe,   
         venlialb.descuento,      venlialb.importedto,   venlialb.clase,   
         venlialb.sector,         venlialb.agente1,      venlialb.agente2,   
         venlialb.agente3,        venlialb.comision11,   venlialb.comision12,   
         venlialb.comision21,     venlialb.comision22,   venlialb.comision31,   
         venlialb.comision32,     venlialb.deposito,     venlialb.orden_preparacion,   
         venlialb.cantidad_prepa, venlialb.es_pico,      venlialb.numero_pico,   
         venlialb.anyo_ent,       venlialb.nummov_ent,   venlialb.anyo_sal,   
         venlialb.nummov_sal,     venlialb.fila_ent,     venlialb.altura_ent,   
         venlialb.operario_prepa, venlialb.control_incremento,   
         venlialb.peso_neto,      venlialb.precio_aduana,   
         venlialb.control_descuentos,venlialb.control_comisiones,   
         venlialb.importe_aduana,    venlialb.bruto,     venlialb.precio_neto,   
         venlialb.precio_aduana_neto,venlialb.descuento_aduana,   
         venlialb.neto,           venlialb.impdtopp,     venlialb.ref_cli,   
         venlialb.transportista,  venlialb.almacen_ent,   
         venlialb.anyo_pedido_origen,venlialb.pedido_origen,   
         venlialb.almacen_deposito,  venlialb.envio ,    venlialb.ubicacion, venlialb.almacen_de_carga,
			venlialb.cantidad_original, venlialb.planificado, venlialb.fecha_linped, 
			venlialb.dtoesp2,		venlialb.tono_imprimir,		venlialb.calibre_imprimir,
			venlialb.id_alm_orden_carga,	venlialb.ordenacion_orden_carga,	venlialb.bulto_desde_orden_carga, 
			venlialb.bulto_hasta_orden_carga,
			venlialb.cantidad_pzs,
			venlialb.precio_pzs,
			venlialb.id_alm_orden_preparacion 
    INTO :l.serie,          :l.fpedido,       :l.fentrega,     :l.cliente,
			:l.tipo_unidad,    :l.articulo,      :l.familia,      :l.formato,
			:l.modelo,         :l.calidad,       :l.tonochar,     :l.calibre,   
         :l.precio,         :l.precio_estand, :l.cantidad,     :l.pallets,   
         :l.total_cajas,    :l.cajas,         :l.dtocomer,     :l.dtoesp,   
         :l.descripcion,    :l.tipoiva,       :l.iva,          :l.linfab,   
         :l.provincia,      :l.pais,          :l.zona,         :l.tipolinea,   
         :l.texto1,         :l.texto2,        :l.texto3,       :l.texto4,   
         :l.referencia,     :l.montajeartcal, :l.situacion,    :l.divisa,   
         :l.metros_lineales,:l.peso,          :l.falta,        :l.usuario,   
         :l.tipo_pallet,    :l.caja,          :l.importe,       
			:l.descuento,      :l.importedto,   
         :l.clase,          :l.sector,        :l.agente1,      :l.agente2,   
         :l.agente3,        :l.comision11,    :l.comision12,   :l.comision21,   
         :l.comision22,     :l.comision31,    :l.comision32,   :l.deposito,   
         :l.orden_preparacion,   :l.cantidad_prepa,     :l.es_pico, 
			:l.numero_pico,         :l.anyo_ent,           :l.nummov_ent,   
         :l.anyo_sal,            :l.nummov_sal,         :l.fila_ent,   
         :l.altura_ent,          :l.operario_prepa,     :l.control_incremento,   
         :l.peso_neto,           :l.precio_aduana,      :l.control_descuentos,   
         :l.control_comisiones,  :l.importe_aduana,     :l.bruto,   
         :l.precio_neto,         :l.precio_aduana_neto, :l.descuento_aduana,   
         :l.neto,                :l.impdtopp,           :l.ref_cli,   
         :l.transportista,       :l.almacen_ent,        :l.anyo,   
         :l.pedido,              :l.almacen_deposito,   :l.envio  ,:ubicacion,
			:l.almacen_de_carga, 	:l.cantidad_original, 	:l.planificado, :l.fecha_intr,
			:l.dtoesp2,					:l.tono_imprimir,			:l.calibre_imprimir,
			:l.id_alm_orden_carga,	:l.ordenacion_orden_carga,	:l.bulto_desde_orden_carga, 
			:l.bulto_hasta_orden_carga,
			:l.cantidad_pzs,
			:l.precio_pzs,
			:l.id_alm_orden_preparacion 
   FROM venlialb  
   WHERE venlialb.empresa  = :codigo_empresa 
	AND   venlialb.anyo     = :anyo 
	AND   venlialb.albaran  = :albaran 
	AND   venlialb.linea    = :linea;
	IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("seleccion venlialb Error",SQLCA.SQLERRTEXT)
		bien = 1
	END IF
	
	if l.pedido>0  and not isnull(l.pedido) then
		Select Count(*) Into :numero From venped
		Where  venped.empresa = :codigo_empresa
		And    venped.anyo    = :l.anyo
		And    venped.pedido  = :l.pedido;
		IF IsNUll(numero) Then numero = 0
		IF numero = 0 Then
			// no existe la cabecera del pedido
						p.almacen_de_Carga = l.almacen_de_carga	
						  SELECT venalb.empresa,venalb.falbaran,venalb.fentrega,venalb.falta,   
								venalb.cliente,venalb.flistado,venalb.observaciones,
								venalb.codpago,venalb.agente1,venalb.agente2,venalb.comision1,   
								venalb.comision2,venalb.comision11,venalb.comision22,   
								venalb.dtopp,venalb.dtoesp1,venalb.dtoesp2,venalb.dtoesp3,   
								venalb.dtoesp4,venalb.tipodto1,venalb.tipodto2,venalb.tipodto3,   
								venalb.tipodto4,venalb.explicaciondto1,venalb.explicaciondto2,   
								venalb.explicaciondto3,venalb.explicaciondto4,venalb.tipoiva,   
								venalb.iva,venalb.numpedcli,venalb.idioma,venalb.divisa,   
								venalb.cambio,venalb.tarifa,venalb.ftarifa,venalb.fbloqueo,   
								venalb.transportista,venalb.serie,venalb.zona,venalb.envio,   
								venalb.correspondencia,venalb.domiciliacion,venalb.forma_envio,   
								venalb.cod_entrega,venalb.usuario,venalb.tipo_portes,   
								venalb.periodo_fac,venalb.peso,venalb.usuario,   
								venalb.agente3,venalb.comision31,venalb.comision32,venalb.veces,   
								venalb.textcomercial1,venalb.textcomercial2,venalb.textaduanaesp1,   
								venalb.textaduanaesp2,venalb.textaduanaext1,venalb.textaduanaext2,   
								venalb.textopie1,venalb.textopie2,venalb.condicion,venalb.peso_neto,   
								venalb.banco_de_cobro,venalb.porcentaje_aduana,venalb.bruto,   
								venalb.importe_dto,venalb.total_neto, venalb.calculo_dto,   
								venalb.agrupa,venalb.deposito,venalb.almacen_deposito,
								venalb.calculo_dtoesp, venalb.peso_bascula_kg, venalb.usuario_pedido
								INTO :p.empresa,:p.fpedido,:p.fentrega,:p.falta,:p.cliente,   
								:p.flistado,:p.observaciones, :p.codpago,:p.agente1,   
								:p.agente2,:p.comision1,:p.comision2,:p.comision11,:p.comision22,   
								:p.dtopp,:p.dtoesp1,:p.dtoesp2,:p.dtoesp3,:p.dtoesp4,:p.tipodto1,   
								:p.tipodto2,:p.tipodto3,:p.tipodto4,:p.explicaciondto1,:p.explicaciondto2,   
								:p.explicaciondto3, :p.explicaciondto4,:p.tipoiva,:p.iva,:p.numpedcli,   
								:p.idioma,:p.divisa, :p.cambio,  :p.tarifa, :p.ftarifa, :p.fbloqueo,   
								:p.transportista,  :p.serie, :p.zona, :p.envio,:p.correspondencia,   
								:p.domiciliacion,:p.forma_envio, :p.cod_entrega,  :p.usuario,   
								:p.tipo_portes,  :p.periodo_fac,  :p.peso,  :p.usuario,   
								:p.agente3,    :p.comision31,   :p.comision32,     :p.veces,   
								:p.textcomercial1,     :p.textcomercial2,    :p.textaduanaesp1,   
								:p.textaduanaesp2,        :p.textaduanaext1,          :p.textaduanaext2,   
								:p.textopie1,         :p.textopie2,           :p.condicion,   
								:p.peso_neto,           :p.banco_de_cobro,    :p.porcentaje_aduana,   
								:p.bruto,           :p.importe_dto,           :p.total_neto,   
								:p.calculo_dto,     :p.agrupa,           :p.deposito,   
								:p.almacen_deposito,  :p.calculo_dtoesp, :p.peso_bascula_kg, :p.usuario_pedido
					
	   				FROM venalb  
						WHERE venalb.empresa = :codigo_empresa 
						AND   venalb.anyo    = :anyo 
						AND   venalb.albaran = :albaran  ;
								IF SQLCA.SQLCODE <> 0 Then 
									bien = 1
									f_mensaje("sele venalbError",SQLCA.SQLERRTEXT)
								END IF
							p.usuario        = l.usuario
							p.usuario = l.usuario
							p.anyo           = l.anyo
							p.pedido         = l.pedido
							p.es_proforma    = 'N'
							p.numpedcli      = l.ref_cli
							
							select isnull(venclientes.agrupa,'N'),
									 isnull(venclientes.agrupa_exp,'N')
							into   :p.agrupa,
									 :p.agrupa_exp
							from   venclientes
							where  venclientes.empresa = :p.empresa
							and    venclientes.codigo  = :p.cliente;
							
		 					p.recalcular_packs = 'N'
							 
							IF Not f_insertar_venped(p) Then 
								bien = 1
								f_mensaje("Error",SQLCA.SQLERRTEXT)
							END IF
	   END IF
	
	   Select Max(venliped.linea) Into :l.linea From venliped
		Where  venliped.empresa  = :codigo_empresa
		And    venliped.anyo     = :l.anyo
		And    venliped.pedido   = :l.pedido;
		IF IsNull(l.linea) Then l.linea = 0
		l.linea = l.linea  + 1
		//** Al anular un albarán las líneas del pedido que se generan
		// han de tener la situación a C (para que las puedan modificar)
		l.situacion = "C"
		l.tipo_pallet_preparacion = l.tipo_pallet
		l.bloqueado = 'N'
		l.esta_fabricado = 'S'
		IF bien = 0 and Not f_insertar_venliped(l) Then 
			bien = 1
			f_mensaje("insertar venliped Error",SQLCA.SQLERRTEXT)
		END IF
		iF bien = 0 and Not f_actualizar_linea_venpedido(l.empresa,l.anyo,l.pedido,l.linea)	 Then
			bien = 1
			f_mensaje("actualizar linea pedido Error",SQLCA.SQLERRTEXT)
		END IF
     End if
	 // solo hacemos entrada de almacén de los tipos de línea
	 // que tienen control de almacén... porque si no falla...
	 If bien = 0 and f_control_almacen_ventipolin(codigo_empresa,l.tipolinea)="S" then
		 IF bien = 0 and Not f_entrada_almacen(l,ubicacion) Then 
				bien = 1
				f_mensaje("insertar venliped Error",SQLCA.SQLERRTEXT)
		 END IF
		 if bien = 0 and l.deposito = "S" then
			if isnull(l.almacen_deposito) then l.almacen_deposito = ""
			if trim(l.almacen_deposito) = "" then
				l.almacen_deposito = f_depalmacen_cliente(codigo_empresa,l.cliente)
			end if
			
		 	if bien = 0 and not(f_salida_almacen_deposito(codigo_empresa,l.almacen_deposito,l.articulo,l.calidad,l.tonochar,l.calibre,l.tipo_pallet,l.caja,l.cantidad,albaran,l.cliente)) then
				bien = 1				
			end if
		end if
	 end if
	 
	 if bien = 0 then 

		// borro la línea del albarán de ventas de esta empresa
		Delete  From  venlialb
		Where   venlialb.empresa = :codigo_empresa
		And     venlialb.anyo    = :anyo
		And     venlialb.albaran = :albaran
		And     venlialb.linea   = :linea;
		IF SQLCA.SQLCODE <> 0 Then
			bien = 1
			f_mensaje("delete venlialb Error",SQLCA.SQLERRTEXT)
		END IF
		
		Select  count(*) Into :linea From venlialb
		Where   venlialb.empresa = :codigo_empresa
		And     venlialb.anyo    = :anyo
		And     venlialb.albaran = :albaran;
		IF IsNull(linea) Then linea = 0
		IF linea = 0 Then
			// si no quedan líneas, borro la cabecera del albarán
			Delete from venalb
			Where  venalb.empresa = :codigo_empresa
			And    venalb.anyo    = :anyo
			And    venalb.albaran = :albaran;
			IF SQLCA.SQLCODE <> 0 Then
				bien = 1
				f_mensaje("delete venalb Error",SQLCA.SQLERRTEXT)
			END IF
		ELSE
			// si quedan líneas, actualizo
			select sum(isnull(venlialb.pallets,0))
			into   :ll_pallets_albaran
			from   venlialb
			Where  venlialb.empresa = :codigo_empresa
			And    venlialb.anyo    = :anyo
			And    venlialb.albaran = :albaran;
		
			Update venalb
			Set    venalb.bultos = :ll_pallets_albaran
			Where  venalb.empresa = :codigo_empresa
			And    venalb.anyo    = :anyo
			And    venalb.albaran = :albaran;				
			
			IF SQLCA.SQLCODE <> 0 Then
				bien = 1
				f_mensaje("Update venalb Error",SQLCA.SQLERRTEXT)
			END IF			
			
			IF bien = 0 and Not f_actualizar_venalbaran(codigo_empresa,anyo,albaran)	 Then
				bien = 1
				f_mensaje("actualizar venalb Error",sqlca.sqlerrtext)
			END IF
		END IF
		
	end if
		
	END IF
	
	f_mensaje_proceso("Procesando",r,r1)
Next

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error Datos","La Operacion no se contabiliza")
END IF
f_desbloquear_albaranes(w_anulacion_albaranes_ventas.title)
cb_continuar.TriggerEvent(Clicked!)
END IF
end subroutine

public function boolean f_entrada_almacen (str_venliped l, string ubicacion);Dec var_metroscaja, cantidad_piezas
Datetime ahora 
Int v_piezascaja
string ls_gestionar_en_piezas
boolean lb_gestionar_en_piezas

str_movimiento_almacen lstr_movimiento_almacen

ahora = Datetime(Today())

SELECT  ventipolin.gestionar_en_piezas  
INTO   :ls_gestionar_en_piezas
FROM   ventipolin  
WHERE (ventipolin.empresa = :codigo_empresa)
AND   (ventipolin.codigo  = :l.tipolinea);

if ls_gestionar_en_piezas = 'S' then
	lb_gestionar_en_piezas = true
else	
	lb_gestionar_en_piezas = false
end if

//ATENCIÓN - EL ALMACEN SIEMPRE TRABAJA EN PIEZAS - CONVERSIÓN METROS/PIEZAS
SELECT metroscaja, piezascaja 
INTO   :var_metroscaja, :v_piezascaja
FROM   almartcajas 
WHERE  empresa = :codigo_empresa 
AND    articulo = :l.articulo 
AND    caja = :l.caja;

if isnull(var_metroscaja) then var_metroscaja = 0
if isnull(v_piezascaja) then v_piezascaja = 0

if l.tipo_unidad = "1" and not(lb_gestionar_en_piezas) then //metros
	if v_piezascaja <> 0 then
		cantidad_piezas = truncate(l.cantidad / var_metroscaja,0)
		cantidad_piezas = cantidad_piezas * v_piezascaja
		cantidad_piezas = truncate(cantidad_piezas,0)
		l.cantidad      = cantidad_piezas
	else
		MessageBox("Error alta del artículo", "Atención, encajado mal definido. Faltan piezas / caja para poder anular.")
		return false
	end if
else
	if lb_gestionar_en_piezas then
		l.cantidad = l.cantidad_pzs
	end if
end if

lstr_movimiento_almacen.empresa            = codigo_empresa//dw_movimientos.object.empresa[dw_movimientos.getrow()]
lstr_movimiento_almacen.articulo           = l.articulo
lstr_movimiento_almacen.calidad            = l.calidad
lstr_movimiento_almacen.tono               = l.tonochar
lstr_movimiento_almacen.calibre            = l.calibre
lstr_movimiento_almacen.tipo_pallet        = l.tipo_pallet
lstr_movimiento_almacen.caja               = l.caja
lstr_movimiento_almacen.cantidad           = l.cantidad
lstr_movimiento_almacen.orden_carga_anyo   = 0
lstr_movimiento_almacen.orden_carga_codigo = ""
lstr_movimiento_almacen.orden_carga_linea  = 0
lstr_movimiento_almacen.tipo_movimiento    = "104"
lstr_movimiento_almacen.observaciones      = ""
lstr_movimiento_almacen.almacen            = "1"
lstr_movimiento_almacen.zona               = "P"
lstr_movimiento_almacen.fila               = 2
lstr_movimiento_almacen.altura             = 1
lstr_movimiento_almacen.tercero            = ""
lstr_movimiento_almacen.documento          = ""
lstr_movimiento_almacen.fecha              = ahora
lstr_movimiento_almacen.id_ubicacion       = 0
lstr_movimiento_almacen.id_alm_bultos		 = 0

//Introduce pallet a pallet
if f_movimiento_almacen(lstr_movimiento_almacen) then
	return true
else
	return false
end if

/*******************************/
/*
String  var_familia, var_formato, var_tipounidad, var_subformato, var_subfamilia, var_modelo
Dec var_metroscaja, cantidad_piezas
Datetime ahora 
Int v_piezascaja
ahora = Datetime(Today(),Now())
str_almacenmovimientos movimiento_nuevo
 
//ALMACEN NUEVO 01/2014
//ANULACIONES FIJADAS EN 1 P 2 1
movimiento_nuevo.empresa = codigo_empresa
movimiento_nuevo.tipomov = "104"
movimiento_nuevo.usuario = nombre_usuario
movimiento_nuevo.almacen = "1"
movimiento_nuevo.zona = "P"
movimiento_nuevo.fila = 2
movimiento_nuevo.altura = 1
movimiento_nuevo.articulo = l.articulo	
movimiento_nuevo.calidad = l.calidad
movimiento_nuevo.tono = l.tonochar
movimiento_nuevo.calibre = l.calibre
movimiento_nuevo.fecha_mov = ahora
movimiento_nuevo.orden = 0
movimiento_nuevo.fecha_intr = ahora
movimiento_nuevo.tipo_pallet = l.tipo_pallet
movimiento_nuevo.caja = l.caja

SELECT articulos.familia, articulos.formato, articulos.unidad, articulos.subformato, articulos.subfamilia, articulos.modelo 
INTO   :var_familia, :var_formato, :var_tipounidad, :var_subformato, :var_subfamilia, :var_modelo
FROM   articulos  
WHERE  articulos.empresa = :codigo_empresa
AND    articulos.codigo = :l.articulo;
 
IF SQLCA.SQLCode<>0 THEN 
	f_mensaje("Error","El artículo no existe")
	return false
END IF

movimiento_nuevo.familia = var_familia
movimiento_nuevo.formato = var_formato
movimiento_nuevo.tipo_unidad = "0" //EL ALMACEN SIEMPRE TRABAJA EN PIEZAS

movimiento_nuevo.origen = ''
//movimiento_nuevo.nummov = ''
//movimiento_nuevo.observaciones = ""
movimiento_nuevo.trazabilidad = ""	

//ATENCIÓN - EL ALMACEN SIEMPRE TRABAJA EN PIEZAS - CONVERSIÓN METROS/PIEZAS
SELECT metroscaja, piezascaja INTO :var_metroscaja, :v_piezascaja
FROM almartcajas 
WHERE empresa = :codigo_empresa AND articulo = :l.articulo AND caja = :l.caja;
if isnull(var_metroscaja) then var_metroscaja = 0
if isnull(v_piezascaja) then v_piezascaja = 0
if l.tipo_unidad = "1" then //metros
	if  v_piezascaja <> 0 then
		cantidad_piezas = truncate(l.cantidad / var_metroscaja,0)
		cantidad_piezas = cantidad_piezas * v_piezascaja
		cantidad_piezas = truncate(cantidad_piezas,0)
		l.cantidad =  cantidad_piezas
	else
		MessageBox("Error alta del artículo", "Atención, encajado mal definido. Faltan piezas / caja para poder anular.")
		return false
	end if
end if

movimiento_nuevo.cantidade = l.cantidad
movimiento_nuevo.cantidads = 0

if ftc_movimiento_almacen(movimiento_nuevo, sqlca) = 0 then
	return true 
else
	return false 
end if
*/
end function

public function boolean f_salida_almacen_deposito (string empresa, string almacen, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja, decimal cantidad, long albaran, string cliente);Integer vbien = 0
Int anyo
Str_deplinubica  ubi
Str_depmovhis    mov
string codigo_articulo
String codigo_calidad

codigo_articulo   = articulo
codigo_calidad    = calidad
ubi.empresa       = codigo_empresa
mov.anyo          = year(Today())
mov.usuario       = nombre_usuario
ubi.almacen       = almacen
ubi.articulo      = articulo
ubi.calidad       = calidad
ubi.tonochar      = tono
ubi.calibre       = calibre
mov.fechmov       = DateTime(Today())
mov.f_alta        = Datetime(today(),now())
mov.observaciones = ""
mov.tipomov       = "9"
ubi.tipo_pallet   = tipo_pallet
ubi.caja          = caja
mov.numdoc        = string(albaran,"######")

SELECT  articulos.familia,
		  articulos.formato,
		  articulos.modelo,
		  articulos.unidad  
INTO    :ubi.familia,
		  :ubi.formato,
		  :ubi.modelo, 
		  :ubi.tipo_unidad  
FROM    articulos  
WHERE   articulos.empresa = :ubi.empresa 
AND     articulos.codigo  = :ubi.articulo;

IF SQLCA.SQLCode<>0 THEN vbien = 1

ubi.referencia   = f_componer_ref(ubi.articulo,&
										  ubi.calidad,ubi.tonochar,&
										  ubi.calibre)

ubi.cliente          = cliente
ubi.f_alta           = DateTime(today(),now())
mov.cantidads        = cantidad
mov.cantidade        = 0
ubi.existencias      = mov.cantidads
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.cantidade        = 0
mov.codtercero       = cliente
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist         = 0      
mov.familia          = ubi.familia
mov.formato          = ubi.formato
mov.modelo           = ubi.modelo
mov.calidad          = ubi.calidad
mov.tonochar         = ubi.tonochar
mov.calibre          = ubi.calibre
mov.tipo_unidad      = ubi.tipo_unidad
mov.tipo_pallet      = ubi.tipo_pallet
mov.caja             = ubi.caja
mov.referencia       = ubi.referencia
mov.f_alta           = DateTime(today(),now())
mov.nummov           = f_depparam_nummov(codigo_empresa,Year(Today()))

decimal{4} cur_existencias
long       ultima_linea,lineas

Select sum(deplinubica.existencias),count(*),max(linea)
Into   :cur_existencias,:lineas,:ultima_linea
From   deplinubica
Where  deplinubica.empresa     = :codigo_empresa
And    deplinubica.almacen     = :almacen 
And    deplinubica.referencia  = :ubi.referencia
And    deplinubica.tipo_pallet = :ubi.tipo_pallet
and    deplinubica.caja        = :ubi.caja;

if SQLCA.SQLCODE = 0 Then
	if isnull(lineas) then lineas = 0
	if isnull(ultima_linea) then ultima_linea = 0
		
	if lineas > 1 then
		delete deplinubica
		Where  deplinubica.empresa     = :codigo_empresa
		And    deplinubica.almacen     = :almacen 
		And    deplinubica.referencia  = :ubi.referencia
		And    deplinubica.tipo_pallet = :ubi.tipo_pallet
		and    deplinubica.caja        = :ubi.caja
		and    deplinubica.linea       < :ultima_linea;
		
		iF sqlca.sqlcode <> 0 Then 
			vbien = 1
			messagebox("Error","Actualizando stock de deposito.")
		else		
			update deplinubica
			set    deplinubica.existencias = :cur_existencias
			Where  deplinubica.empresa     = :codigo_empresa
			And    deplinubica.almacen     = :almacen 
			And    deplinubica.referencia  = :ubi.referencia
			And    deplinubica.tipo_pallet = :ubi.tipo_pallet
			and    deplinubica.caja        = :ubi.caja
			and    deplinubica.linea       = :ultima_linea;
			
			iF sqlca.sqlcode <> 0 Then 
				vbien = 1
				messagebox("Error","Actualizando stock de deposito.")
			end if			
		end if
	end if
	
	if cur_existencias > mov.cantidads then
		Update deplinubica
		Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
		Where  deplinubica.empresa     = :codigo_empresa
		And    deplinubica.almacen     = :almacen 
		And    deplinubica.referencia  = :ubi.referencia
		And    deplinubica.tipo_pallet = :ubi.tipo_pallet
		and    deplinubica.caja        = :ubi.caja;
		
		iF sqlca.sqlcode <> 0 Then vbien = 1
	else
		if cur_existencias = mov.cantidads then
			delete deplinubica
			Where  deplinubica.empresa     = :codigo_empresa
			And    deplinubica.almacen     = :almacen 
			And    deplinubica.referencia  = :ubi.referencia
			And    deplinubica.tipo_pallet = :ubi.tipo_pallet
			and    deplinubica.caja        = :ubi.caja;
			
			iF sqlca.sqlcode <> 0 Then vbien = 1
		else
			messagebox("Error","No existe suficiente stock en deposito")
			vbien = 1			
		end if		
	end if
else
	messagebox("Error","En la selección del stock de deposito")
	vbien = 1			
end if

IF NOT f_insert_depmovhis(mov) Then vbien=1

IF NOT f_actualiza_depnummov(codigo_empresa,Year(Today()),mov.nummov) THEN
	vbien = 1
END IF

IF vbien = 0  Then
	Return True
Else
	f_mensaje("Error en salida almacen de deposito",sqlca.sqlerrtext)
	Return False
End IF
end function

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;IF d= 1 Then
	f_pagina_arriba(dw_detalle)
ELSE
	f_pagina_arriba(dw_detalle2)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;IF d= 1 Then
	f_cursor_arriba(dw_detalle)
ELSE
	f_cursor_arriba(dw_detalle2)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF d= 1 Then
	f_pagina_abajo(dw_detalle)
ELSE
	f_pagina_abajo(dw_detalle2)
END IF
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Anulacion de albaranes de ventas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle2.SetTransObject(SQLCA)
dw_proceso_alb.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)

otra_empresa = f_mercaderia_empresa(codigo_empresa)
end event

on w_anulacion_albaranes_ventas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.cb_continuar=create cb_continuar
this.dw_detalle=create dw_detalle
this.cb_marcar=create cb_marcar
this.dw_detalle2=create dw_detalle2
this.cb_procesar=create cb_procesar
this.cb_desmarcar=create cb_desmarcar
this.dw_proceso_alb=create dw_proceso_alb
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_continuar
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.cb_marcar
this.Control[iCurrent+9]=this.dw_detalle2
this.Control[iCurrent+10]=this.cb_procesar
this.Control[iCurrent+11]=this.cb_desmarcar
this.Control[iCurrent+12]=this.dw_proceso_alb
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
end on

on w_anulacion_albaranes_ventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cb_continuar)
destroy(this.dw_detalle)
destroy(this.cb_marcar)
destroy(this.dw_detalle2)
destroy(this.cb_procesar)
destroy(this.cb_desmarcar)
destroy(this.dw_proceso_alb)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;IF d= 1 Then
	f_cursor_abajo(dw_detalle)
ELSE
	f_cursor_abajo(dw_detalle2)
END IF
end event

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_anulacion_albaranes_ventas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_anulacion_albaranes_ventas
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_anulacion_albaranes_ventas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_anulacion_albaranes_ventas
integer width = 4517
end type

type pb_1 from upb_salir within w_anulacion_albaranes_ventas
integer x = 4393
integer y = 132
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_anulacion_albaranes_ventas
integer x = 18
integer y = 136
integer width = 238
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
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_anulacion_albaranes_ventas
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_albaranes_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_anulacion_albaranes_ventas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 136
integer width = 1650
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_detalle.reset()
dw_detalle2.reset()
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_anulacion_albaranes_ventas
integer x = 9
integer y = 88
integer width = 1947
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_continuar from commandbutton within w_anulacion_albaranes_ventas
integer x = 3941
integer y = 132
integer width = 379
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type dw_detalle from u_datawindow_consultas within w_anulacion_albaranes_ventas
integer x = 5
integer y = 248
integer width = 1792
integer height = 2568
integer taborder = 0
string dataobject = "dw_anulacion_albaranes_ventas"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;d = 1
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

event rowfocuschanged;call super::rowfocuschanged;f_detalle(currentrow)
end event

event retrieveend;call super::retrieveend;IF rowcount = 1 Then f_detalle(1)
end event

type cb_marcar from commandbutton within w_anulacion_albaranes_ventas
event clicked pbm_bnclicked
integer x = 1819
integer y = 2848
integer width = 402
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Procesar"
boolean cancel = true
end type

event clicked;
if MessageBox("! A v i s o ¡","Este proceso pasa las líneas seleccionadas a pedido y borra el albarán, ¿Desea continuar?",Exclamation!, YesNo!,1)=1 then  
	f_anular()
end if
end event

type dw_detalle2 from u_datawindow_consultas within w_anulacion_albaranes_ventas
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
integer x = 1792
integer y = 248
integer width = 2738
integer height = 2568
integer taborder = 0
string dataobject = "dw_anulacion_albaranes_ventas2"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;d = 2
end event

type cb_procesar from commandbutton within w_anulacion_albaranes_ventas
integer x = 4128
integer y = 2848
integer width = 357
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Marcar todo"
end type

event clicked;String autom
if dw_detalle2.RowCount()<>0 then
	int Xx
	for Xx=1 to dw_detalle2.RowCount()
		autom = dw_detalle2.GetItemString(Xx,"venlialb_automatico")
		if IsNull(autom) then autom = ""
		if autom <> "S" then
			dw_detalle2.SetItem(Xx,"cmarca",'S')
		end if
	next
End if
end event

type cb_desmarcar from commandbutton within w_anulacion_albaranes_ventas
event clicked pbm_bnclicked
integer x = 3758
integer y = 2848
integer width = 357
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Desmarcar"
end type

event clicked;if dw_detalle2.RowCount()<>0 then
	int Xx
	for Xx=1 to dw_detalle2.RowCount()
		dw_detalle2.SetItem(Xx,"cmarca",'N')
	next
End if
end event

type dw_proceso_alb from datawindow within w_anulacion_albaranes_ventas
boolean visible = false
integer x = 544
integer y = 392
integer width = 494
integer height = 360
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_anula_alb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_anulacion_albaranes_ventas
integer x = 1792
integer y = 2808
integer width = 2738
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_anulacion_albaranes_ventas
integer x = 3913
integer y = 92
integer width = 613
integer height = 144
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

