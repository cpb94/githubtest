$PBExportHeader$w_generacion_facturas.srw
forward
global type w_generacion_facturas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_generacion_facturas
end type
type st_1 from statictext within w_generacion_facturas
end type
type em_fecha from u_em_campo within w_generacion_facturas
end type
type st_4 from statictext within w_generacion_facturas
end type
type em_ffactura from u_em_campo within w_generacion_facturas
end type
type st_6 from statictext within w_generacion_facturas
end type
type dw_listado from u_datawindow_consultas within w_generacion_facturas
end type
type uo_cliente from u_em_campo_2 within w_generacion_facturas
end type
type st_3333 from statictext within w_generacion_facturas
end type
type em_anyo from u_em_campo within w_generacion_facturas
end type
type st_3 from statictext within w_generacion_facturas
end type
type em_factura from u_em_campo within w_generacion_facturas
end type
type st_nombre_serie from statictext within w_generacion_facturas
end type
type st_5 from statictext within w_generacion_facturas
end type
type cb_imprimir from u_boton within w_generacion_facturas
end type
type cb_continuar from u_boton within w_generacion_facturas
end type
type em_serie from u_em_campo within w_generacion_facturas
end type
type st_2 from statictext within w_generacion_facturas
end type
type gb_3 from groupbox within w_generacion_facturas
end type
type gb_2 from groupbox within w_generacion_facturas
end type
type gb_1 from groupbox within w_generacion_facturas
end type
type dw_ln_alb from datawindow within w_generacion_facturas
end type
type rb_semanal from radiobutton within w_generacion_facturas
end type
type rb_quincenal from radiobutton within w_generacion_facturas
end type
type rb_mensual from radiobutton within w_generacion_facturas
end type
type dw_fac from datawindow within w_generacion_facturas
end type
type dw_precartera from datawindow within w_generacion_facturas
end type
type dw_observa from u_datawindow_consultas within w_generacion_facturas
end type
type dw_facturas from u_datawindow_consultas within w_generacion_facturas
end type
end forward

global type w_generacion_facturas from w_int_con_empresa
integer x = 14
integer y = 32
integer width = 3561
integer height = 2540
pb_1 pb_1
st_1 st_1
em_fecha em_fecha
st_4 st_4
em_ffactura em_ffactura
st_6 st_6
dw_listado dw_listado
uo_cliente uo_cliente
st_3333 st_3333
em_anyo em_anyo
st_3 st_3
em_factura em_factura
st_nombre_serie st_nombre_serie
st_5 st_5
cb_imprimir cb_imprimir
cb_continuar cb_continuar
em_serie em_serie
st_2 st_2
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_ln_alb dw_ln_alb
rb_semanal rb_semanal
rb_quincenal rb_quincenal
rb_mensual rb_mensual
dw_fac dw_fac
dw_precartera dw_precartera
dw_observa dw_observa
dw_facturas dw_facturas
end type
global w_generacion_facturas w_generacion_facturas

type variables
String var_tipo_facturacion,list = "S"
Integer var_anyo,lin_fac
STring bloq = "N"
end variables

forward prototypes
public subroutine f_procesar ()
public function boolean f_lineas_factura (str_venalb alb, str_venfac fac)
public subroutine f_salir ()
public subroutine f_cargar (datawindow dw_data)
public function decimal f_siguiente_factura (decimal fac)
public subroutine f_cargar_precartera ()
public subroutine f_grabar_venfaccar (decimal anyo, decimal factura, string cliente, decimal importe, decimal divisas, string moneda)
public subroutine f_borrar_venfaccar (decimal anyo, decimal factura)
public function decimal f_peso_factura (long arg_factura)
public function decimal f_peso_neto_factura (long arg_factura)
end prototypes

public subroutine f_procesar ();IF messageBox("Proceso generacion de facturas","Desea continuar?",Question!,YesNo!) = 2 Then
	Return
END IF
Integer reg,reg1,bien
Dec{0} var_fac,antefac,n_factura,numero
String var_serie,cta

var_serie = em_serie.text
Str_venlifac  linfac
Str_venlialb  linalb
Str_venalb  alb
Str_venfac  fac
bien = 0

fac.anyo = Dec(em_anyo.text)
SetNull(antefac)
reg = dw_facturas.RowCount()
For reg1 = 1 To reg
	IF dw_facturas.GetItemNumber(reg1,"factura") >0 and  dw_facturas.GetItemString(reg1,"facturar")= "N" Then
		f_mensaje("Control generacion facturas","Existen lineas a no facturar con Nº facturas(Refrescar)")
		return
	END IF
	IF dw_facturas.GetItemNumber(reg1,"factura") < 0 and  dw_facturas.GetItemString(reg1,"facturar")= "S" Then
		f_mensaje("Control generacion facturas","Existen lineas a facturar sin Nº facturas(Refrescar)")
		Return
	END IF
NEXT

IF  reg  = 0 Then Return

IF Not f_bloquear_albaranes(w_generacion_facturas.title) Then
	
	FOR reg1 = 1 TO reg
		IF dw_facturas.GetItemString(reg1,"facturar") = "S" Then
			alb.empresa =  codigo_empresa
			alb.anyo    =  dw_facturas.GetItemNumber(reg1,"anyo")
			alb.albaran =  dw_facturas.GetItemNumber(reg1,"albaran")
			fac.factura =  dw_facturas.GetItemNumber(reg1,"factura")
			var_fac     = fac.factura
			
			if not(f_cargar_str_venalb(alb.empresa,alb.anyo,alb.albaran,alb)) then
				Bien = 1
			end if
			
//			Select falbaran 
//			Into :alb.falbaran 
//			from venalb
//			Where  empresa = :codigo_empresa
//			And    anyo    = :alb.anyo
//			And    albaran  = :alb.albaran;
			
			fac.falbaran = alb.falbaran
		
			IF IsNull(antefac) or antefac <> var_fac Then
//				SELECT  venalb.empresa, 			venalb.anyo,            venalb.albaran,   
//							venalb.falbaran,   		venalb.fentrega,        venalb.falta,   
//							venalb.cliente,    		venalb.flistado,        venalb.observaciones,   
//							venalb.codpago,    		venalb.agente1,         venalb.agente2,   
//							venalb.comision1,  		venalb.comision2,       venalb.comision11,   
//							venalb.comision22, 		venalb.dtopp,           venalb.dtoesp1,   
//							venalb.dtoesp2,    		venalb.dtoesp3,         venalb.dtoesp4,   
//							venalb.tipodto1,   		venalb.tipodto2,        venalb.tipodto3,   
//							venalb.tipodto4,   		venalb.explicaciondto1, venalb.explicaciondto2,   
//							venalb.explicaciondto3, venalb.explicaciondto4, venalb.tipoiva,   
//							venalb.iva,             venalb.idioma,
//							venalb.divisa,           venalb.cambio,          venalb.tarifa,   
//							venalb.ftarifa,          venalb.fbloqueo,        venalb.transportista,   
//							venalb.serie,            venalb.zona,            venalb.envio,   
//							venalb.correspondencia,  venalb.domiciliacion,   venalb.forma_envio,   
//							venalb.cod_entrega,      venalb.usuario,         venalb.tipo_portes,   
//							venalb.periodo_fac,      venalb.peso,            venalb.usuario_pedido,   
//							venalb.agente3,          venalb.comision31,      venalb.comision32,   
//							venalb.veces,            venalb.textcomercial1,  venalb.textcomercial2,   
//							venalb.textaduanaesp1,   venalb.textaduanaesp2,  venalb.textaduanaext1,   
//							venalb.textaduanaext2,   venalb.textopie1,       venalb.textopie2,   
//							venalb.condicion,        venalb.peso_neto,       venalb.banco_de_cobro,   
//							venalb.porcentaje_aduana,venalb.bruto,           venalb.importe_dto,   
//							venalb.total_neto,       venalb.calculo_dto,     venalb.anyo_pedido_origen,   
//							venalb.pedido_origen,    venalb.fcarga,          venalb.agrupa  ,venalb.contenedor,
//							venalb.precinto,			 venalb.matricula,		 venalb.bultos,  venalb.conductor,
//							venalb.comision_fija1,   venalb.comision_fija2,  venalb.comision_fija3, venalb.almacen_deposito, venalb.peso_bascula_kg, venalb.expedicion_anyo, venalb.expedicion_codigo
//				INTO 		:alb.empresa,            :alb.anyo,              :alb.albaran,   
//							:alb.falbaran,           :alb.fentrega,          :alb.falta,   
//							:alb.cliente,            :alb.flistado,          :alb.observaciones,   
//							:alb.codpago,            :alb.agente1,           :alb.agente2,   
//							:alb.comision1,          :alb.comision2,         :alb.comision11,   
//							:alb.comision22,         :alb.dtopp,             :alb.dtoesp1,   
//							:alb.dtoesp2,            :alb.dtoesp3,           :alb.dtoesp4,   
//							:alb.tipodto1,           :alb.tipodto2,          :alb.tipodto3,   
//							:alb.tipodto4,           :alb.explicaciondto1,   :alb.explicaciondto2,   
//							:alb.explicaciondto3,    :alb.explicaciondto4,   :alb.tipoiva,   
//							:alb.iva,                :alb.idioma,   
//							:alb.divisa,             :alb.cambio,            :alb.tarifa,   
//							:alb.ftarifa,            :alb.fbloqueo,          :alb.transportista,   
//							:alb.serie,              :alb.zona,              :alb.envio,   
//							:alb.correspondencia,    :alb.domiciliacion,     :alb.forma_envio,   
//							:alb.cod_entrega,        :alb.usuario,           :alb.tipo_portes,   
//							:alb.periodo_fac,        :alb.peso,              :alb.usuario_pedido,   
//							:alb.agente3,            :alb.comision31,        :alb.comision32,   
//							:alb.veces,              :alb.textcomercial1,    :alb.textcomercial2,   
//							:alb.textaduanaesp1,     :alb.textaduanaesp2,    :alb.textaduanaext1,   
//							:alb.textaduanaext2,     :alb.textopie1,         :alb.textopie2,   
//							:alb.condicion,          :alb.peso_neto,         :alb.banco_de_cobro,   
//							:alb.porcentaje_aduana,  :alb.bruto,             :alb.importe_dto,   
//							:alb.total_neto,         :alb.calculo_dto,       :alb.anyo_pedido_origen,   
//							:alb.pedido_origen,      :alb.fcarga,            :alb.agrupa  ,:alb.contenedor,
//							:alb.precinto,				 :alb.matricula,         :alb.bultos,
//							:alb.conductor,			 	:fac.comision_fija1,  :fac.comision_fija2,    
//							:fac.comision_fija3,			:alb.almacen_deposito, :alb.peso_bascula_kg, :alb.expedicion_anyo, :alb.expedicion_codigo
//				FROM  	venalb  
//				WHERE 	(venalb.empresa  = :alb.empresa)
//				AND   	(venalb.anyo     = :alb.anyo)
//				AND   	(venalb.albaran  = :alb.albaran);
									
					
//				IF SQLCA.SQLCODE <> 0 Then Bien = 1
				
				fac.empresa      = alb.empresa
				fac.anyo_albaran = alb.anyo
				fac.albaran      = alb.albaran
				fac.fentrega     = alb.fentrega
				fac.falta        = alb.falta
				fac.cliente      = alb.cliente
				fac.flistado     = alb.flistado
				         fac.observaciones= alb.observaciones
//				fac.observaciones = ""
				fac.observaciones_alb = alb.observaciones		
				fac.codpago      = alb.codpago
				fac.agente1      = alb.agente1
				fac.agente2      = alb.agente2
				fac.comision11   = alb.comision1
				fac.comision21   = alb.comision2
				fac.comision12   = alb.comision11
				fac.comision22   = alb.comision22
				fac.dtopp        = alb.dtopp
				fac.dtoesp1      = alb.dtoesp1
				fac.dtoesp2      = alb.dtoesp2
				fac.dtoesp3      = alb.dtoesp3
				fac.dtoesp4      = alb.dtoesp4
				fac.tipodto1     = alb.tipodto1
				fac.tipodto2     = alb.tipodto2
				fac.tipodto3     = alb.tipodto3
				fac.tipodto4     = alb.tipodto4
				fac.explicaciondto1 = alb.explicaciondto1
				fac.explicaciondto2 = alb.explicaciondto2
				fac.explicaciondto3 = alb.explicaciondto3
				fac.explicaciondto4 = alb.explicaciondto4
				fac.tipoiva        = alb.tipoiva
				fac.iva            = alb.iva
				//         fac.numpedcli    =alb.numpedcli
				fac.idioma         = alb.idioma
				fac.divisa         = alb.divisa
				fac.cambio         = f_cambio_moneda(fac.divisa)
				fac.tarifa         = alb.tarifa
				fac.ftarifa        = alb.ftarifa
				fac.fbloqueo       = alb.fbloqueo
				fac.transportista  = alb.transportista
				fac.serie          = alb.serie
				fac.zona           = alb.zona
				fac.envio          = alb.envio
				fac.correspondencia= alb.correspondencia
				fac.domiciliacion  = alb.domiciliacion
				fac.forma_envio    = alb.forma_envio
				fac.cod_entrega    = alb.cod_entrega
				fac.usuario        = alb.usuario
				fac.tipo_portes    = alb.tipo_portes
				fac.periodo_fac    = alb.periodo_fac
				
				fac.peso_bascula_kg    = alb.peso_bascula_kg
				fac.expedicion_anyo    = alb.expedicion_anyo
				fac.expedicion_codigo    = alb.expedicion_codigo
				
				//fac.peso           = alb.peso
				//fac.peso_neto      = alb.peso_neto			

				
				fac.peso           = f_peso_factura(fac.factura)
				fac.peso_neto      = f_peso_neto_factura(fac.factura)
				
				fac.usuario_pedido = alb.usuario_pedido
				fac.agente3        = alb.agente3
				fac.comision31     = alb.comision31
				fac.comision32     = alb.comision32
				fac.veces          = alb.veces
				fac.textcomercial1 = alb.textcomercial1
				fac.textcomercial2 = alb.textcomercial2
				fac.textaduanaesp1 = alb.textaduanaesp1
				fac.textaduanaesp2 = alb.textaduanaesp2
				fac.textaduanaext1 = alb.textaduanaext1
				fac.textaduanaext2 = alb.textaduanaext2
				fac.textopie1      = alb.textopie1
				fac.textopie2      = alb.textopie2
				fac.condicion      = alb.condicion         
				fac.banco_de_cobro = alb.banco_de_cobro
				fac.porcentaje_aduana = alb.porcentaje_aduana
				fac.bruto          = alb.bruto
				fac.importe_dto    = alb.importe_dto
				fac.total_neto     = alb.total_neto
				fac.calculo_dto    = alb.calculo_dto
				fac.anyo_pedido_origen = alb.anyo_pedido_origen
				fac.pedido_origen  = alb.pedido_origen
				fac.fcarga         = alb.fcarga
				fac.agrupa         = alb.agrupa
				fac.almacen_deposito = alb.almacen_deposito
				fac.ffactura       = DateTime(Date(em_ffactura.text))
				fac.actualizada    = "N"
				fac.contenedor = alb.contenedor
				fac.precinto   = alb.precinto
				//			fac.matricula  = alb.matricula
				fac.cartera        = dw_facturas.GetItemString(reg1,"cartera")
				fac.precartera     = dw_facturas.GetItemString(reg1,"precartera")
				IF fac.cartera = "N" Then fac.precartera = "N"
				cta = f_cuenta_genter(fac.empresa,"C",fac.cliente)
				IF fac.precartera = "S" Then
					update venfaccar 
					set facturado = "S",	  anyo       = :fac.anyo,	  factura    = :fac.factura
					Where empresa   = :fac.empresa
					And   cuenta    = :cta
					And   facturado = "N";
					IF SQLCA.SQLCODE <> 0 Then bien = 1
				END IF
				f_mensaje_proceso("Grabando Factura "+ STring(fac.factura,"######"),reg1,reg)			
				fac.marcada         = "N"
				fac.generar_recibos = "S"
				IF Not f_insert_venfac(fac) Then Bien = 1
				  lin_fac = 0
				END IF
				f_mensaje_proceso("Lineas Factura "+ STring(fac.factura,"######"),reg1,reg)
				IF Not f_lineas_factura(alb,fac) Then bien = 1
				antefac = var_fac
				f_mensaje_proceso("Borrando Albaran "+ STring(alb.albaran,"######"),reg1,reg)
	
				DELETE    FROM  venalb  
				WHERE venalb.empresa  = :alb.empresa
				AND   venalb.anyo     = :alb.anyo
				AND   venalb.albaran  = :alb.albaran using sqlca;
				IF SQLCA.SQLCODE <> 0 Then Bien = 1
	
				f_mensaje_proceso("Actualizando Cabecera "+ STring(fac.factura,"######"),reg1,reg)
				
				// Quitar de aquí porque se ejecuta por cada línea de factura, sólo debe ejecutarse una vez por cada factura.
				IF Not f_actualizar_venfactura_peso(fac.empresa,fac.anyo,fac.factura,"N") Then bien = 1
			END IF
			f_mensaje_proceso("Procesando Factura "+ STring(fac.factura,"######"),reg1,reg)
	NEXT

	UPDATE venparamfac
	SET     factura = :fac.factura
	Where   empresa = :codigo_empresa
	and     anyo   = :var_anyo
	And     serie  = :var_serie;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
					
	IF bien = 1 Then
		f_mensaje("Error en el proceso"," La operacion no se contabiliza" + sqlca.sqlerrtext)
		ROLLBACK;
	Else
		COMMIT;
	End if
	f_desbloquear_albaranes(w_generacion_facturas.title)
	
END IF
dw_facturas.Reset()
f_salir()
end subroutine

public function boolean f_lineas_factura (str_venalb alb, str_venfac fac);Integer reg,reg1,bien
Dec xlinea
String sel
str_venlifac lifac
bien = 0
dec bultos

reg = dw_ln_alb.Retrieve(alb.empresa,alb.anyo,alb.albaran)

dw_ln_alb.setsort(" empresa, anyo, albaran , linea  ")  // David 07-10-05

IF reg = 0 Then Return TRUE
For reg1 = 1 To reg
  lin_fac =  lin_fac  +  1
  lifac.empresa      =  alb.empresa
  lifac.anyo_albaran =  alb.anyo
  lifac.albaran      =  alb.albaran
  lifac.linea        =  dw_ln_alb.GetItemNumber(reg1,"linea")
  
  // David 26-05-2010
  select bultos
  into :bultos
  from venalb 
  where empresa = :alb.empresa
  and anyo = :alb.anyo
  and albaran = :alb.albaran;
  
//  lifac.bultos       =  alb.bultos
  lifac.bultos       =  bultos
  //lifac.conductor    =  alb.conductor
SELECT   venlialb.tipo_unidad,
			venlialb.articulo,   
         venlialb.familia,
			venlialb.subfamilia, 
			venlialb.formato,
			venlialb.subformato,
         venlialb.modelo,
         venlialb.calidad,   
         venlialb.tonochar,
			venlialb.calibre,   
         venlialb.precio,
         venlialb.precio_estand,   
         venlialb.cantidad,
			venlialb.pallets,   
         venlialb.total_cajas,
			venlialb.cajas,   
         venlialb.dtocomer,
			venlialb.dtoesp,   
         venlialb.descripcion,
			venlialb.linfab,   
         venlialb.provincia,
			venlialb.pais,   
         venlialb.zona,
			venlialb.tipolinea,   
         venlialb.texto1,
         venlialb.texto2,   
         venlialb.texto3,
         venlialb.texto4,   
         venlialb.referencia,
			venlialb.montajeartcal,   
         venlialb.situacion,
			venlialb.divisa,   
         venlialb.metros_lineales,
			venlialb.peso,   
         venlialb.falta,
			venlialb.usuario,   
         venlialb.importe,
			venlialb.tipo_pallet,   
			venlialb.caja,
         venlialb.descuento,
			venlialb.importedto,   
         venlialb.clase,
			venlialb.sector,   
         venlialb.deposito,
			venlialb.orden_preparacion,   
         venlialb.cantidad_prepa,
			venlialb.es_pico,   
         venlialb.numero_pico,
			venlialb.operario_prepa,   
         venlialb.peso_neto,
			venlialb.control_incremento,   
         venlialb.precio_aduana,
			venlialb.control_descuentos,   
         venlialb.control_comisiones,   
         venlialb.importe_aduana,   
         venlialb.bruto,   
         venlialb.precio_aduana_neto,   
         venlialb.precio_neto,   
         venlialb.descuento_aduana,   
         venlialb.neto,   
         venlialb.impdtopp,   
         venlialb.ref_cli,   
         venlialb.fcarga,   
         venlialb.envio,
			venlialb.contenedor,
			venlialb.numpedcli,
			venlialb.pedido_origen,
			venlialb.anyo_pedido_origen,
			venlialb.linea_pedido_origen,
			venlialb.falbaran,
			venlialb.ubicacion,
			venlialb.precinto,
			venlialb.matricula,
			venlialb.linea_pedido_origen,
			venlialb.anyo_alb_comp,
			venlialb.albaran_comp,
			venlialb.lin_alb_comp,
			venlialb.anyo_alb_otra,
			venlialb.albaran_otra,
			venlialb.lin_alb_otra,
			venlialb.cantidad_pedido,
			venlialb.almacen_de_carga,
			venlialb.fentrega,
			venlialb.fentrega_inicial,
			venlialb.dtoesp2,
			venlialb.fpedido_origen,
			venlialb.numpalet,
			venlialb.anyo_proddiaria,
			venlialb.contador_proddiaria,
			venlialb.idioma,
			venlialb.cantidad_original,
			venlialb.linea_desdoblada_de,
			venlialb.fecha_linped,
			venlialb.albaran_deposito,
			venlialb.peso_bruto_venalb,
			venlialb.peso_neto_venalb,
			venlialb.expedicion_anyo_venalb,
			venlialb.expedicion_codigo_venalb,
			venlialb.bultos_venalb,
			venlialb.observaciones_venalb,
			venlialb.forma_envio_venalb,
			venlialb.conductor_venalb,
			venlialb.tono_imprimir,
			venlialb.calibre_imprimir,
			venlialb.id_alm_orden_carga,
			venlialb.ordenacion_orden_carga,
			venlialb.bulto_desde_orden_carga,
			venlialb.bulto_hasta_orden_carga,
			venlialb.cantidad_pzs,
			venlialb.precio_pzs,
			venlialb.id_alm_orden_preparacion 
    INTO :lifac.tipo_unidad,   
         :lifac.articulo,   
         :lifac.familia,   
			:lifac.subfamilia,
         :lifac.formato,   
			:lifac.subformato,   
         :lifac.modelo,   
         :lifac.calidad,   
         :lifac.tonochar,   
         :lifac.calibre,   
         :lifac.precio,   
         :lifac.precio_estand,   
         :lifac.cantidad,   
         :lifac.pallets,   
         :lifac.total_cajas,   
         :lifac.cajas,   
         :lifac.dtocomer,   
         :lifac.dtoesp,   
         :lifac.descripcion,   
         :lifac.linfab,   
         :lifac.provincia,   
         :lifac.pais,   
         :lifac.zona,   
         :lifac.tipolinea,   
         :lifac.texto1,   
         :lifac.texto2,   
         :lifac.texto3,   
         :lifac.texto4,   
         :lifac.referencia,   
         :lifac.montajeartcal,   
         :lifac.situacion,   
         :lifac.divisa,   
         :lifac.metros_lineales,   
         :lifac.peso,   
         :lifac.falta,   
         :lifac.usuario,   
         :lifac.importe,   
         :lifac.tipo_pallet,   
			:lifac.caja,
         :lifac.descuento,   
         :lifac.importedto,   
         :lifac.clase,   
         :lifac.sector,   
         :lifac.deposito,   
         :lifac.orden_preparacion,   
         :lifac.cantidad_prepa,   
         :lifac.es_pico,   
         :lifac.numero_pico,   
         :lifac.operario_prepa,   
         :lifac.peso_neto,   
         :lifac.control_incremento,   
         :lifac.precio_aduana,   
         :lifac.control_descuentos,   
         :lifac.control_comisiones,   
         :lifac.importe_aduana,   
         :lifac.bruto,   
         :lifac.precio_aduana_neto,   
         :lifac.precio_aduana,   
         :lifac.descuento_aduana,   
         :lifac.neto,   
         :lifac.impdtopp,   
         :lifac.ref_cli,   
         :lifac.fcarga,   
         :lifac.envio,
			:lifac.contenedor,
			:lifac.numpedcli,
			:lifac.pedido_origen,
			:lifac.anyo_pedido_origen,
			:lifac.linea_pedido_origen,
			:lifac.falbaran,
			:lifac.ubicacion,
			:lifac.precinto,
			:lifac.matricula,
			:lifac.linea_pedido_origen,
			:lifac.anyo_alb_comp,
			:lifac.albaran_comp,
			:lifac.lin_alb_comp,
			:lifac.anyo_alb_otra,
			:lifac.albaran_otra,
			:lifac.lin_alb_otra,
			:lifac.cantidad_pedido,
			:lifac.almacen_de_carga,
			:lifac.fentrega,
			:lifac.fentrega_inicial,
			:lifac.dtoesp2,
			:lifac.fpedido_origen,
			:lifac.numpalet,
			:lifac.anyo_proddiaria,
			:lifac.contador_proddiaria,
			:lifac.idioma,
			:lifac.cantidad_original,
			:lifac.linea_desdoblada_de,
			:lifac.fecha_linped,
			:lifac.factura_deposito,
			:lifac.peso_bruto_venalb,
			:lifac.peso_neto_venalb,
			:lifac.expedicion_anyo_venalb,
			:lifac.expedicion_codigo_venalb,
			:lifac.bultos_venalb,
			:lifac.observaciones_venalb,
			:lifac.forma_envio_venalb,
			:lifac.conductor,
			:lifac.tono_imprimir,
			:lifac.calibre_imprimir,
			:lifac.id_alm_orden_carga,
			:lifac.ordenacion_orden_carga,
			:lifac.bulto_desde_orden_carga,
			:lifac.bulto_hasta_orden_carga,
			:lifac.cantidad_pzs,
			:lifac.precio_pzs,
			:lifac.id_alm_orden_preparacion 
FROM  venlialb  
WHERE ( venlialb.empresa = :lifac.empresa ) 
AND  	( venlialb.anyo = :lifac.anyo_albaran ) 
AND  	( venlialb.albaran = :lifac.albaran ) 
AND  	( venlialb.linea = :lifac.linea );

IF SQLCA.SQLCODE <> 0 Then  bien = 1

  
  lifac.serie         =  fac.serie
//  lifac.falbaran     =  fac.falbaran
//  lifac.fentrega     =  fac.fentrega
  lifac.cliente       =  fac.cliente
  lifac.tipoiva       =  fac.tipoiva
  lifac.iva           = fac.iva
  lifac.transportista = f_transportista_venalb(codigo_empresa,lifac.anyo_albaran,lifac.albaran)//fac.transportista
  lifac.venconductores_codigo = f_venconductores_codigo_albaran(codigo_empresa,lifac.anyo_albaran,lifac.albaran)//fac.transportista
  lifac.agente1       = fac.agente1 
  lifac.agente2       = fac.agente2
  lifac.agente3       = fac.agente3
  lifac.comision11    = fac.comision11
  lifac.comision12    = fac.comision12
  lifac.comision21    = fac.comision21
  lifac.comision22    = fac.comision22
  lifac.comision31    = fac.comision31
  lifac.comision32    = fac.comision32
  lifac.contenedor    = f_contenedor_albaran(codigo_empresa,lifac.anyo_albaran,lifac.albaran)
  lifac.precinto      = f_precinto_albaran(codigo_empresa,lifac.anyo_albaran,lifac.albaran)
  lifac.matricula     = f_matricula_albaran(codigo_empresa,lifac.anyo_albaran,lifac.albaran)  
  lifac.remolque      = f_remolque_albaran(codigo_empresa,lifac.anyo_albaran,lifac.albaran)  
  lifac.dni				 = f_dni_venalb(codigo_empresa,lifac.anyo_albaran,lifac.albaran) 
  lifac.ffactura      = fac.ffactura
  lifac.anyo          = fac.anyo
  lifac.factura       = fac.factura
  lifac.linea_factura = lin_fac
  lifac.observ_lin    = ""
  //Nuevo Paco Marin 29-09-2016
  lifac.peso_bruto_venalb = alb.peso
  lifac.peso_neto_venalb = alb.peso_neto
  lifac.expedicion_anyo_venalb = alb.expedicion_anyo
  lifac.expedicion_codigo_venalb = alb.expedicion_codigo
  lifac.bultos_venalb = alb.bultos
  lifac.observaciones_venalb = alb.observaciones
  lifac.forma_envio_venalb = alb.forma_envio
  lifac.venconductores_codigo = alb.venconductores_codigo
  lifac.remolque = alb.remolque
  lifac.booking = alb.booking
  lifac.tara_contenedor = alb.tara_contenedor
  lifac.metodo_verificacion_masa_bruta = alb.metodo_verificacion_masa_bruta
    
  IF Not f_insertar_venlifac(lifac) Then bien = 1
  IF Not f_actualizar_linea_venfac(lifac.empresa,lifac.anyo,lifac.factura,lifac.linea_factura) Then bien = 1
  
Next
DELETE    FROM  venlialb  
  WHERE (venlialb.empresa  = :alb.empresa)
	AND   (venlialb.anyo     = :alb.anyo)
	AND   (venlialb.albaran  = :alb.albaran);
	IF SQLCA.SQLCODE <> 0 Then 
		bien = 1
		f_mensaje("Error base de datos",sqlca.sqlerrtext)
	END IF
dw_ln_alb.Reset()	
IF bien = 0 Then
	return TRUE
ELSE
	return FALSE
END IF
end function

public subroutine f_salir ();   f_desbloquear("facturar",em_serie.text,w_generacion_facturas.title) 
	bloq = "N"
	COMMIT;
	cb_continuar.visible = TRUE
	dw_facturas.visible  = FALSE
	em_serie.text = ""
	st_nombre_serie.text = ""
	em_factura.text = ""
	dw_facturas.Reset()
	f_activar_campo(em_serie)
	em_serie.ue_ante_valor=""
end subroutine

public subroutine f_cargar (datawindow dw_data);f_cargar_precartera()
Integer reg,s1,g1,r1,f1,g2,nn,hh,sss,var_dia1,var_dia2,var_dia3
Dec{4}  var_total,importe_min,total_fac,total,var_cambio
Dec{0}   var_albaran,var_factura,decimales_moneda,tot_pre
String  var_cliente,var_fpago,var_moneda,var_agrupa,ante_cliente,ante_fpago,var_cartera,var_precartera,var_control_precartera
string var_cuenta,v_cod_pago,v_control,nombre_carforpag,nombre_cliente,nombre_moneda,cod_pagoparam,var_facturar,precartera
string cartera,facturar,ss
DateTime var_fecha
String var_cli[]
datastore dw_comodin

dec bultos



s1 = 0
var_fecha = DateTime(Date(em_fecha.text))
var_anyo  = Integer(em_anyo.text)
var_factura = Dec(em_factura.text)
SetNull(ante_cliente)
SetNull(ante_fpago)
var_cartera = "S"
dw_data.Reset()
dw_data.visible = FALSE
importe_min = f_importe_min_carparam(codigo_empresa,var_anyo)
var_tipo_facturacion = ""

IF rb_mensual.checked Then
	IF len(var_tipo_facturacion) <>0 Then var_tipo_facturacion= var_tipo_facturacion + ","
	var_tipo_facturacion = var_tipo_facturacion + "'M'"
END IF
IF rb_quincenal.checked Then
	IF len(var_tipo_facturacion) <>0 Then var_tipo_facturacion= var_tipo_facturacion + ","
	var_tipo_facturacion = var_tipo_facturacion + "'Q'"
END IF
IF rb_semanal.checked Then
	IF len(var_tipo_facturacion) <>0 Then var_tipo_facturacion= var_tipo_facturacion + ","
	var_tipo_facturacion = var_tipo_facturacion + "'S'"
END IF

var_tipo_facturacion = "("+var_tipo_facturacion+")"

String cri,cri2
cri2 = ""

IF Trim(uo_cliente.em_codigo.text) <> "" Then
	cri2 =   " AND    venalb.cliente = '"+ uo_cliente.em_codigo.text +"'"
END IF

cri = " SELECT *  FROM venalb "+&
			  " WHERE  venalb.empresa = '"+codigo_empresa+"'"+&
			  " AND    venalb.anyo    =  "+String(var_anyo)+&
			  " AND    venalb.serie = '"+ em_serie.text +"'"+cri2 +&
			  " AND    venalb.falbaran <= '"+String(var_fecha,"dd-mm-yyyy") +"'"+&
			  " AND    venalb.periodo_fac in  "+var_tipo_facturacion+&
			  " AND    venalb.deposito = 'N'   "+ &
			  " ORDER BY venalb.falbaran ASC, venalb.albaran ASC "
// David 20-08-01  Quieren que aparezcan en la factura los albaranes cuyo importe sea 0, por tanto eliminamos
// la condicion que hay a continuación:
//			  " and    venalb.total_neto <> 0 "+&				  

//dw_comodin= f_cargar_cursor(cri)

f_cargar_cursor_nuevo(cri, dw_comodin)
reg = dw_comodin.RowCount()
IF reg = 0 Then 
	f_salir()
	destroy dw_comodin
	return
END IF

FOR r1 = 1 To reg
	//David 25-05-2010
	bultos = dw_comodin.GetItemNumber(r1,"bultos")
	
	v_control = "N"
	var_albaran      = dw_comodin.GetItemNumber(r1,"albaran")
	var_fpago        = dw_comodin.GetItemString(r1,"codpago")
	var_moneda       = dw_comodin.GetItemString(r1,"divisa")
	decimales_moneda = f_decimales_moneda(var_moneda)
	nombre_moneda    = f_nombre_moneda_abr(var_moneda)
	var_agrupa       = dw_comodin.GetItemString(r1,"agrupa")
	var_facturar     = dw_comodin.GetItemString(r1,"facturar")
	If var_agrupa    = "" or IsNull(var_agrupa) Then var_agrupa = "N"
	var_cliente      = dw_comodin.GetItemString(r1,"cliente")
	nombre_carforpag = f_nombre_carforpag(codigo_empresa,var_fpago)
	nombre_cliente   = f_razon_genter(codigo_empresa,"C",var_cliente)
	total_fac        = f_importe_albaran(codigo_empresa,var_anyo,var_albaran)
	var_dia1         = f_diaspago1_venclientes(codigo_empresa,var_cliente)
	var_dia2         = f_diaspago2_venclientes(codigo_empresa,var_cliente)
	var_dia3         = f_diaspago3_venclientes(codigo_empresa,var_cliente)
	var_precartera	  = "N"
	var_cuenta 		  = f_cuenta_genter(codigo_empresa,"C",var_cliente)
	
	var_control_precartera =  f_control_precartera(codigo_empresa,var_cuenta) 
	
	s1 = dw_data.RowCOunt() +1
	//  Control orden agrupación de facturas
	//---------------------------------------
	IF dw_data.RowCount() <> 0 Then
		For g1 = 1 To dw_data.RowCount()
			IF var_agrupa = "S" Then
				IF dw_data.GetItemString(g1,"agrupar") = "S" Then
					IF dw_data.GetItemString(g1,"cliente") = var_cliente Then
						IF dw_data.GetItemString(g1,"fpago") = var_fpago Then
							 s1 = g1 +1
						END IF
					END IF
				END IF
			END IF
		Next
	END IF
	
	dw_data.InsertRow(s1)
	v_control = "N"
	dw_data.SetItem(s1,"control",v_control)
	dw_data.SetItem(s1,"empresa",codigo_empresa)
	dw_data.SetItem(s1,"anyo",var_anyo)
	dw_data.SetItem(s1,"albaran",var_albaran)
	dw_data.SetItem(s1,"fpago",var_fpago)
	dw_data.SetItem(s1,"agrupar",var_agrupa)
	dw_data.SetItem(s1,"facturar",var_facturar)
	dw_data.SetItem(s1,"moneda",var_moneda)
	var_cambio = f_cambio_moneda(var_moneda)
	dw_data.SetItem(s1,"nombre_moneda",nombre_moneda)
	dw_data.SetItem(s1,"decimales_moneda",decimales_moneda)
	dw_data.SetItem(s1,"cliente",var_cliente)
	dw_data.SetItem(s1,"nombre_cliente",nombre_cliente)
	dw_data.SetItem(s1,"nombre_carforpag",nombre_carforpag)
	dw_data.SetItem(s1,"importe",total_fac)
	dw_data.SetItem(s1,"control_precartera",var_control_precartera)
   dw_data.SetItem(s1,"precartera",var_precartera)
	dw_data.SetItem(s1,"cartera",var_cartera)
	dw_data.SetItem(s1,"d1",var_dia1)
	dw_data.SetItem(s1,"d2",var_dia2)
	dw_data.SetItem(s1,"d3",var_dia3)
	//David 25-05-2010
	dw_data.SetItem(s1,"bultos",bultos)

	
	f_mensaje_proceso("Procesando orden albaranes",r1,reg)
Next


dec{0} contador_nuevo
contador_nuevo=0
string control_fac,control_fac_ant
For f1 = 1 To dw_data.RowCOunt()		
	var_cliente  =  dw_data.GetItemString(f1,"cliente")
	control_fac  =  dw_data.GetItemString(f1,"facturar")
	if isnull(control_fac)then control_fac="N"
	IF f1 <> 1 Then
		control_fac_ant  =  dw_data.GetItemString(f1 - 1,"facturar")
		if isnull(control_fac_ant)then control_fac_ant="N"
		IF dw_data.GetItemSTring(f1,"agrupar") = "N"  Then
			if control_fac="S" then
				var_factura = f_siguiente_factura(var_factura)
			else
				contador_nuevo=contador_nuevo - 1
			end if
		ELSE
			IF dw_data.GetItemSTring(f1 - 1,"agrupar") = "N"  or &
				dw_data.GetItemSTring(f1,"cliente") <> dw_data.GetItemSTring(f1 - 1,"cliente") or &
				dw_data.GetItemSTring(f1,"fpago") <> dw_data.GetItemSTring(f1 - 1,"fpago") Then
				if control_fac="S" then
					var_factura = f_siguiente_factura(var_factura)
				else
					contador_nuevo=contador_nuevo - 1
				end if
			else
				if control_fac_ant<>control_fac then
					if control_fac="S" then
						var_factura = f_siguiente_factura(var_factura)
					else
						contador_nuevo=contador_nuevo - 1
					end if
				end if
			END IF
		END IF
	ELSE
		if control_fac="S" then
			var_factura = f_siguiente_factura(var_factura)
		else
			contador_nuevo=contador_nuevo - 1
		end if
	END IF
	if control_fac="S" then
		dw_data.SetItem(f1,"factura",var_factura)	
	else
		dw_data.SetItem(f1,"factura",contador_nuevo)	
	end if
		f_mensaje_proceso("Asignando Nº Fra",f1,dw_data.RowCOunt())
Next
		
// Generacion cartera Ficticia
For f1 = 1 To dw_data.RowCOunt()					
	var_cliente  =  dw_data.GetItemString(f1,"cliente")
	var_factura  =  dw_data.GetItemNumber(f1,"factura")
	total = 0
	For g1 = 1 To dw_data.RowCount()
		IF var_factura = dw_data.GetItemNumber(g1,"factura") Then
			total = total + dw_data.GetItemNumber(g1,"importe")
			var_fpago =  dw_data.GetItemSTring(g1,"fpago")
		END IF
	Next
		
	v_cod_pago = f_codpago_impfra_cliente(codigo_empresa,var_cliente,total)
     //For g1 = 1 To dw_data.RowCount()
	//	IF var_factura = dw_data.GetItemNumber(g1,"factura") Then
	IF Trim(v_cod_pago) <> "" and Not IsNull(v_cod_pago) Then
		v_control = "S"
		var_fpago = v_cod_pago
		dw_data.SetItem(f1,"fpago",v_cod_pago)
		dw_data.SetItem(f1,"control",v_control)
	END IF
	var_cuenta = f_cuenta_genter(codigo_empresa,"C",var_cliente)

	// Si no hay efectos salimos porque sino da un divide by zero chachi
	if f_efectos_carforpag(codigo_empresa,var_fpago)=0 then
		f_mensaje("Proceso de Actualización de Facturas","Los datos de la forma de pago ["+var_fpago+"] no son correctos. Ha de tener al menos un documento.")
		destroy dw_comodin
		Return
	end if
	if ((total)/f_efectos_carforpag(codigo_empresa,var_fpago)) * var_cambio < importe_min Then	
		// Marco las linea como cartera = No				
		IF f_control_precartera_cartipodoc(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,dw_data.GetItemString(f1,"fpago")))  = "S" Then
			 IF dw_data.GetItemSTring(f1,"facturar") = "S" Then
				  // Estos recibo no van a cartera grabaremos los recibos venfaccar
				  f_grabar_venfaccar(var_anyo,var_factura,var_cliente,dw_data.GetItemNumber(f1,"importe"),dw_data.GetItemNumber(f1,"importe") * var_cambio,dw_data.GetItemSTring(f1,"moneda"))								  								  
			 END IF
			 dw_data.SetItem(f1,"cartera","N")
			 dw_data.SetItem(f1,"precartera","N")
		END IF
	END IF
//  END IF
//	Next
	f_mensaje_proceso("Reconstruyendo cartera",f1,dw_data.RowCOunt())
Next
// Fin Generacion cartera Ficticia



Int bb
// Reconstruyendo acople pre_cartera
FOR g1 = 1 To dw_data.RowCount()
	total = 0
	var_factura = dw_data.getItemNumber(g1,"factura")
   	IF var_factura >0 then
		var_cliente = dw_data.getItemString(g1,"cliente")
		var_fpago   =  dw_data.GetItemSTring(g1,"fpago")
		For bb = 1 To dw_data.RowCount()
			IF var_factura = dw_data.GetItemNumber(bb,"factura") Then
				total       = total + dw_data.GetItemNumber(bb,"importe")
			END IF
		Next
		var_cuenta = f_cuenta_genter(codigo_empresa,"C",var_cliente)
		tot_pre    = f_total_venfaccar_cuenta(codigo_empresa,var_cuenta,dw_data.GetItemSTring(g1,"moneda"))

		IF dw_data.getItemSTring(g1,"cartera")= "N" Then total = 0
		
		// Los recibos de precartera ya estan asignados
		//-------------------------------------
		ss = "( cliente='"+var_cliente+"' and precartera='S' and factura <>"+ String(var_factura,'#########')+")"
		sss=dw_data.find(ss,1,dw_data.rowcount())
		if sss <> 0 Then tot_pre = 0
		//-------------------------------------
		IF var_cambio = 0 or IsNull(var_cambio) Then var_cambio = 1
		
		IF ((total+tot_pre)/f_efectos_carforpag(codigo_empresa,var_fpago)) * var_cambio < importe_min Then	
			// no recoge precartera
			// Marco las linea como cartera = No				
			if f_control_precartera_cartipodoc(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,dw_data.GetItemString(g1,"fpago")))  = "S" Then
				dw_data.SetItem(g1,"cartera","N")
				dw_data.SetItem(g1,"precartera","N")
			end if
		ELSE
			// si va recoge precartera
			var_cliente   = dw_data.getitemstring(g1,"cliente")
			IF dw_data.getItemString(g1,"precartera") = "N" Then
				ss = "( cliente='"+var_cliente+"' and precartera='S' and factura <>"+ String(var_factura,'#########')+")"
				sss=dw_data.find(ss,1,dw_data.rowcount())
				if sss>0 then
					precartera="N"	
				else
					if tot_pre <> 0 Then	
						precartera="S"
					else
						precartera="N"
					end if
					cartera = "S"
					facturar = "S"
					dw_data.SetItem(g1,"cartera",cartera)
					dw_data.SetItem(g1,"facturar",facturar)
					f_borrar_venfaccar(dw_data.getItemNumber(dw_data.GetRow(),"anyo"),dw_data.getItemNumber(g1,"factura"))
					dw_data.SetItem(g1,"facturar",facturar)
				end if
			ELSE
				precartera = "N"
			END IF
			dw_data.SetItem(g1,"precartera",precartera)
		END IF
	END IF
NEXT
// Fin Reconstruyendo acople pre_cartera

For g1 = 1 To dw_data.RowCount()
	var_cliente = dw_data.GetItemSTring(g1,"cliente")
	if not(f_elemento_en_array (var_cli[], var_cliente)) then
		var_cli[UpperBound(var_cli)+1] = var_cliente
	end if
	var_moneda      = dw_data.GetItemSTring(g1,"moneda")
	Select Count(*) Into :nn From venfaccar
	Where  empresa = :codigo_empresa
	And    cliente = :var_cliente
	And    moneda  = :var_moneda
	And    facturado = 'N';
	IF Isnull(nn) Then nn = 0
	IF nn <> 0 Then
		dw_data.SetItem(g1,"control_precartera","S")
	END IF
	f_mensaje_proceso("Control precartera",g1,dw_data.RowCOunt())
Next

dw_data.visible = TRUE

Integer conta, donde
String observa, cad
dw_observa.reset()

dw_observa.retrieve(codigo_empresa)
for conta = 1 to UpperBound(var_cli)
	select comentario 
	  into :observa
	  from venclientes
	 where venclientes.empresa = :codigo_empresa
	   and venclientes.codigo  = :var_cli[conta];

	if IsNull (observa) then observa = ""
	if trim(observa) <> "" then
		IF dw_observa.rowcount() = 0 then
			donde = dw_observa.InsertRow(0)
			cad = ""
		else
			donde = dw_observa.getrow()
			cad = dw_observa.GetItemString(donde, "observaciones")
			if IsNull(cad) then cad =""

		end if
		dw_observa.SetItem(donde, "empresa", codigo_empresa)
		dw_observa.SetItem(donde, "observaciones", cad + "Cliente "+f_razon_genter(codigo_empresa,"C",var_cli[conta])+": ~n"+ observa+Char(13))		
	end if
	
next
if dw_observa.rowcount() > 0 then 
	dw_observa.visible = true
   dw_observa.selectrow(0,false)
end if
IF dw_data.RowCount() = 0 Then f_salir()
	
destroy dw_comodin
	
end subroutine

public function decimal f_siguiente_factura (decimal fac);Dec r,r1,vanyo,numero


vanyo = Dec(em_anyo.text)
fac = fac +1
For r = fac To 4294967295
	
	Select Count(*) Into :numero From venfac
	Where  empresa = :codigo_empresa
	And    anyo    = :vanyo
	and    factura = :r;

	IF IsNUll(numero) Then numero = 0
	IF numero = 0 Then Return r
Next

end function

public subroutine f_cargar_precartera ();String    sel,vmoneda,vfac_orden,vcliente,vtipodoc,vsituacion,vcta,vserie
Dec vanyofac
datastore dw
Dec r,r1,vorden,vanyo,vfactura,vanyo_orden,vrecibo,vimporte,vdivisas,vlinea,contro
DateTime  vffra,vfvto

vserie = em_serie.text
Delete from venfaccar
where  empresa = :codigo_empresa
and    serie   = :vserie
and    facturado = "N";
COMMIT;

sel = " Select *" +&
		" From  carefectos " +&
		" Where empresa   = '"+codigo_empresa+"'"+&
		" And   situacion = '4'"
		
//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
r1 = dw.RowCount()
IF r1 =  0 Then 
	destroy dw
	Return
end if
	Select Max(venfaccar.linea) Into :vlinea from venfaccar
	Where  venfaccar.empresa = :codigo_empresa;
	IF IsNull(vlinea) Then vlinea = 0


For r = 1 To r1
	vlinea       = vlinea +1
	vanyo_orden  =  dw.GetItemNumber(r,"anyo")
	vorden       = dw.GetItemNumber(r,"orden")
	vrecibo      = dw.GetItemNumber(r,"recibo")
	vfac_orden   = dw.GetItemSTring(r,"factura")
	vanyofac     = dw.GetItemNumber(r,"anyofra")
	vimporte     = dw.GetItemNumber(r,"importe")
	vdivisas     = dw.GetItemNumber(r,"divisas")
	vmoneda      = dw.GetItemString(r,"monedas")
	vcta         = dw.GetItemString(r,"cuenta")
	vtipodoc     = dw.GetItemString(r,"tipodoc")
   vsituacion   = dw.GetItemString(r,"situacion")
	vcliente     = dw.GetItemString(r,"cliente")
	vffra        = dw.GetItemDateTime(r,"ffra")
	vfvto        = dw.GetItemDateTime(r,"fvto")
	SELECT count(*) Into :contro From venfaccar
	Where  empresa    = :codigo_empresa
	And    anyo_orden = :vanyo_orden
	And    orden = :vorden;
	IF IsNull(contro) Then contro = 0
	IF contro = 0 Then
	  INSERT INTO venfaccar  
     (empresa,linea,anyo,factura,anyo_orden,orden,fac_orden,importe,   
      divisas,moneda,facturado,cliente,recibo,tipodoc,situacion,
		fvto,ffra,cuenta,cartera,anyofac,serie)  
  	  VALUES (:codigo_empresa,:vlinea,:vanyo,:vfactura,:vanyo_orden,   
	          :vorden,:vfac_orden,:vimporte,:vdivisas,:vmoneda,'N',   
             :vcliente,:vrecibo,:vtipodoc,:vsituacion,:vfvto,:vffra,:vcta,"S",:vanyofac,:vserie);
				 IF sqlca.sqlcode <> 0 Then f_mensaje("garbar precartera Error",sqlca.sqlerrtext)
	 END IF
	 COMMIT;

Next

destroy dw
end subroutine

public subroutine f_grabar_venfaccar (decimal anyo, decimal factura, string cliente, decimal importe, decimal divisas, string moneda);IF factura < 0 Then Return
Dec linea
STring cuenta,fra,vserie
fra = string(factura,"#############")
cuenta = f_cuenta_genter(codigo_empresa,"C",cliente)
vserie = em_serie.text
Select max(venfaccar.linea) Into :linea From venfaccar
Where  empresa = :codigo_empresa;
IF ISNUll(linea) Then linea = 0
linea = linea +1
  
  
  
  
  INSERT INTO venfaccar  
  ( empresa,  linea,   
           anyo,   
           factura,   
           anyo_orden,   
           orden,   
           fac_orden,   
           importe,   
           divisas,   
           moneda,   
           facturado,   
           cliente,   
           ffra,   
           fvto,   
           recibo,   
           situacion,   
           tipodoc,   
           cuenta,
			  cartera,
			  anyofac,serie)  
  VALUES ( :codigo_empresa,   
           :linea,   
           :anyo,   
           :factura,   
           null,   
           :anyo,   
           :fra,   
           :importe,   
           :divisas,   
           :moneda,   
           'N',   
           :cliente,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :cuenta,
			  "N",
			  :anyo,:vserie)  ;
COMMIT;
end subroutine

public subroutine f_borrar_venfaccar (decimal anyo, decimal factura);Dec linea
STring cuenta,fra
IF factura = -1 Then Return

Delete  from venfaccar
Where empresa = :codigo_empresa
And   anyo    = :anyo
And   factura = :factura
and   cartera = "N";
COMMIT;
  
  
  
end subroutine

public function decimal f_peso_factura (long arg_factura);long indice,total,anyo,albaran
dec peso_albaran,peso_factura

peso_factura = 0
total = dw_facturas.RowCount()

For indice = 1 To total
	if dw_facturas.GetItemNumber(indice,"factura") = arg_factura then
		anyo    =  dw_facturas.GetItemNumber(indice,"anyo")
		albaran =  dw_facturas.GetItemNumber(indice,"albaran")
	
		Select peso 
		Into   :peso_albaran
		from   venalb
		Where  empresa = :codigo_empresa
		And    anyo    = :anyo
		And    albaran = :albaran;
		
		if isnull(peso_albaran) then peso_albaran = 0
		peso_factura = peso_factura + peso_albaran
	end if
next
return peso_factura
end function

public function decimal f_peso_neto_factura (long arg_factura);long indice,total,anyo,albaran
dec peso_albaran,peso_factura

peso_factura = 0
total = dw_facturas.RowCount()

For indice = 1 To total
	if dw_facturas.GetItemNumber(indice,"factura") = arg_factura then
		anyo    =  dw_facturas.GetItemNumber(indice,"anyo")
		albaran =  dw_facturas.GetItemNumber(indice,"albaran")
	
		Select peso_neto 
		Into   :peso_albaran
		from   venalb
		Where  empresa = :codigo_empresa
		And    anyo    = :anyo
		And    albaran = :albaran;
		
		if isnull(peso_albaran) then peso_albaran = 0
		peso_factura = peso_factura + peso_albaran
	end if
next
return peso_factura
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Generacion de facturas"
This.title=istr_parametros.s_titulo_ventana
dw_precartera.SetTransObject(SQLCA)
dw_ln_alb.SetTransObject(SQLCA)
dw_observa.SetTransObject(SQLCA)
em_fecha.text = String(Today())
var_tipo_facturacion = "S"
em_anyo.text = String(Year(Today()))
em_ffactura.text = String(Today())
dw_facturas.visible = FALSE
f_activar_campo(em_serie)
end event

on w_generacion_facturas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.em_fecha=create em_fecha
this.st_4=create st_4
this.em_ffactura=create em_ffactura
this.st_6=create st_6
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.st_3333=create st_3333
this.em_anyo=create em_anyo
this.st_3=create st_3
this.em_factura=create em_factura
this.st_nombre_serie=create st_nombre_serie
this.st_5=create st_5
this.cb_imprimir=create cb_imprimir
this.cb_continuar=create cb_continuar
this.em_serie=create em_serie
this.st_2=create st_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_ln_alb=create dw_ln_alb
this.rb_semanal=create rb_semanal
this.rb_quincenal=create rb_quincenal
this.rb_mensual=create rb_mensual
this.dw_fac=create dw_fac
this.dw_precartera=create dw_precartera
this.dw_observa=create dw_observa
this.dw_facturas=create dw_facturas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_fecha
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.em_ffactura
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.st_3333
this.Control[iCurrent+10]=this.em_anyo
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.em_factura
this.Control[iCurrent+13]=this.st_nombre_serie
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.cb_imprimir
this.Control[iCurrent+16]=this.cb_continuar
this.Control[iCurrent+17]=this.em_serie
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.dw_ln_alb
this.Control[iCurrent+23]=this.rb_semanal
this.Control[iCurrent+24]=this.rb_quincenal
this.Control[iCurrent+25]=this.rb_mensual
this.Control[iCurrent+26]=this.dw_fac
this.Control[iCurrent+27]=this.dw_precartera
this.Control[iCurrent+28]=this.dw_observa
this.Control[iCurrent+29]=this.dw_facturas
end on

on w_generacion_facturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_fecha)
destroy(this.st_4)
destroy(this.em_ffactura)
destroy(this.st_6)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.st_3333)
destroy(this.em_anyo)
destroy(this.st_3)
destroy(this.em_factura)
destroy(this.st_nombre_serie)
destroy(this.st_5)
destroy(this.cb_imprimir)
destroy(this.cb_continuar)
destroy(this.em_serie)
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_ln_alb)
destroy(this.rb_semanal)
destroy(this.rb_quincenal)
destroy(this.rb_mensual)
destroy(this.dw_fac)
destroy(this.dw_precartera)
destroy(this.dw_observa)
destroy(this.dw_facturas)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_facturas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_facturas)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_facturas)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_facturas)
end event

event close;call super::close;IF bloq = "S" Then
   f_desbloquear("facturar",em_serie.text,this.title) 
	bloq = "N"
	COMMIT;
END IF
end event

event activate;call super::activate;w_generacion_facturas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_generacion_facturas
integer taborder = 110
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_generacion_facturas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_generacion_facturas
integer x = 14
integer y = 8
integer width = 3241
integer height = 92
end type

type pb_1 from upb_salir within w_generacion_facturas
integer x = 3351
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

event clicked;IF bloq = "S" Then
   f_desbloquear("facturar",em_serie.text,w_generacion_facturas.title) 
	bloq = "N"
	COMMIT;
END IF
Call Super::Clicked
end event

type st_1 from statictext within w_generacion_facturas
integer x = 773
integer y = 268
integer width = 389
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
string text = "Fecha Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_generacion_facturas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1179
integer y = 268
integer width = 288
integer height = 80
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "h<"
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF




 



end event

type st_4 from statictext within w_generacion_facturas
integer x = 773
integer y = 408
integer width = 389
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
string text = "Fecha Fra:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_ffactura from u_em_campo within w_generacion_facturas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1179
integer y = 396
integer width = 288
integer taborder = 60
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF




 



end event

type st_6 from statictext within w_generacion_facturas
integer x = 73
integer y = 252
integer width = 261
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
string text = "Periodo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado from u_datawindow_consultas within w_generacion_facturas
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
event itemfocuschanged pbm_dwnitemchangefocus
event rbuttondown pbm_dwnrbuttondown
event rowfocuschanged pbm_dwnrowchange
event key pbm_dwnkey
event valores_numericos pbm_custom01
boolean visible = false
integer x = 2967
integer y = 44
integer width = 59
integer height = 96
integer taborder = 0
string dataobject = "dw_generacion_factura_listado"
boolean vscrollbar = true
end type

event clicked;call super::clicked;This.SetRow(row)
This.SetColumn("fpago")
Integer r1 
String var_fpago,var_agrupar
Dec{0} var_albaran
dw_facturas.AcceptText()
IF f_objeto_datawindow(dw_facturas)= "actualizar" Then
	For r1 = 1 To dw_facturas.RowCount()
		var_albaran = dw_facturas.GetItemNumber(r1,"albaran")
		var_fpago = dw_facturas.GetItemString(r1,"fpago")
		var_agrupar = dw_facturas.GetItemString(r1,"agrupar")
		Update venalb
		Set    venalb.codpago  = :var_fpago,
		       venalb.agrupa   = :var_agrupar
		Where  venalb.empresa  = :codigo_empresa
		And    venalb.anyo     = :var_anyo
		And    venalb.albaran  = :var_albaran;
		COMMIT;
			
		
	Next 
	cb_continuar.TriggerEvent(Clicked!)
End If

Integer   r,f
Dec       factura
String    cartera,precartera,facturar,agrupar


IF f_objeto_datawindow(dw_facturas) = "facturar" Then
	facturar = This.getItemString(This.GetRow(),"facturar")
	If facturar = "N" Then
		facturar = "S"
	ELse
		facturar = "N"
	End if
	This.SetItem(This.GetRow(),"facturar",facturar)
END IF

IF f_objeto_datawindow(This) = "agrupar" Then
	agrupar = This.getItemString(This.GetRow(),"agrupar")
	If agrupar = "N" Then
		agrupar = "S"
	ELse
		agrupar = "N"
	End if
	This.SetItem(This.GetRow(),"agrupar",agrupar)
END IF

IF f_objeto_datawindow(This) = "cartera" Then
	cartera = This.getItemString(This.GetRow(),"cartera")
	If cartera = "N" Then
		cartera = "S"
	ELse
		cartera = "N"
	End if
	This.SetItem(This.GetRow(),"cartera",cartera)
END IF


IF f_objeto_datawindow(This) = "precartera" Then
	precartera = This.getItemString(This.GetRow(),"precartera")
	If precartera = "N" Then
		precartera = "S"
	ELse
		precartera = "N"
	End if
	This.SetItem(This.GetRow(),"precartera",precartera)
END IF

This.AcceptText()

r    = This.GetRow()
factura    = This.GetItemNumber(r,"factura")
cartera    = This.GetItemString(r,"cartera")
precartera = This.GetItemString(r,"precartera")
r1   = This.RowCount()
IF r = 0 Then Return

For f = 1 To r1
	IF This.GetItemNumber(f,"factura") = factura Then
		This.SetItem(f,"cartera",cartera)
		This.SetItem(f,"precartera",precartera)
	END IF
Next

IF f_objeto_datawindow(dw_facturas)= "procesar" Then
		f_procesar()
		dw_facturas.Reset()
		f_salir()
END IF

IF f_objeto_datawindow(dw_facturas)= "salir" Then
	f_salir()
END IF


IF f_objeto_datawindow(This) = "consulta_precartera" Then 
	dw_precartera.Retrieve(codigo_empresa,f_cuenta_genter(codigo_empresa,"C",dw_facturas.GetItemString(dw_facturas.GetRow(),"cliente")))
	IF dw_precartera.RowCount()<> 0 Then
		dw_precartera.visible = TRUE
	Else
		f_mensaje("Este cliente no tiene recibos en precartera"," Pulse Ok")
	End If
 END IF

IF f_objeto_datawindow(dw_facturas)= "imprimir" Then
	
END IF
end event

event doubleclicked;call super::doubleclicked;
 
 str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If

end event

event itemfocuschanged;call super::itemfocuschanged;AcceptText()
SetItem(row,"nombre_carforpag",f_nombre_carforpag(codigo_empresa,GetItemString(row,"fpago")))
end event

event rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "fpago"
      bus_titulo     = "VENTANA SELECCION DE FORMAS DE PAGO"
 		bus_datawindow = "dw_ayuda_carforpag"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 
 
end event

event rowfocuschanged;call super::rowfocuschanged;This.SetRow(currentrow)
This.SetColumn("fpago")
end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "fpago"
      bus_titulo     = "VENTANA SELECCION DE FORMAS DE PAGO"
 		bus_datawindow = "dw_ayuda_carforpag"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(This,"fpago")
end event

type uo_cliente from u_em_campo_2 within w_generacion_facturas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 41
integer y = 592
integer width = 1435
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
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

type st_3333 from statictext within w_generacion_facturas
integer x = 41
integer y = 508
integer width = 1435
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
string text = "C l i e n t e"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_generacion_facturas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 343
integer y = 256
integer height = 80
integer taborder = 30
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF




 



end event

type st_3 from statictext within w_generacion_facturas
integer x = 37
integer y = 388
integer width = 297
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Ult. Fra.:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_fac.SetTRansObject(SQLCA)
IF dw_fac.Retrieve(codigo_empresa,Dec(em_anyo.text),em_serie.text) <> 0 Then
	dw_fac.visible= TRUE
END IF
end event

type em_factura from u_em_campo within w_generacion_facturas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 343
integer y = 388
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######0"
string displaydata = "~b"
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF




 



end event

type st_nombre_serie from statictext within w_generacion_facturas
integer x = 603
integer y = 160
integer width = 873
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_generacion_facturas
integer x = 1605
integer y = 248
integer width = 521
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Facturación"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_imprimir from u_boton within w_generacion_facturas
event clicked pbm_bnclicked
integer x = 1573
integer y = 596
integer height = 92
integer taborder = 120
string text = "&Imprimir"
end type

event clicked;call super::clicked;list = "S"
dw_listado.visible = TRUE
dec{0} n_factura
Integer registros,numero
String  var_empresa,var_serie
dw_facturas.Reset()
var_anyo  = Integer(em_anyo.text)
var_serie = em_serie.text
em_factura.text = STring(registros) 
f_cargar(dw_listado)
dw_listado.visible = FALSE
f_imprimir_datawindow(dw_listado)
	


end event

type cb_continuar from u_boton within w_generacion_facturas
integer x = 1573
integer y = 504
integer height = 92
integer taborder = 80
string text = "&Continuar"
end type

event clicked;list = "N"
bloq = "N"
dw_facturas.Reset()
IF Not f_bloquear("facturar",em_serie.text,w_generacion_facturas.title) Then
	bloq = "S"
	COMMIT;
	f_cargar(dw_facturas)
	IF dw_facturas.RowCount() =0 Then Return
	This.visible = FALSE
END IF


end event

type em_serie from u_em_campo within w_generacion_facturas
integer x = 343
integer y = 160
integer height = 80
integer taborder = 20
end type

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)

IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then
    em_serie.text=""
    f_activar_campo(em_serie)
    return
 End if
END IF


dec{0} n_factura
long registros,numero
String  var_empresa,var_serie
dw_facturas.Reset()
var_anyo  = Integer(em_anyo.text)
var_serie = em_serie.text

   Select factura Into :registros From  venparamfac
	 Where venparamfac.empresa = :codigo_empresa
	  And venparamfac.anyo   = :var_anyo
		And venparamfac.serie  = :var_serie;
		IF IsNUll(registros) Then registros = 0
		Select Count(*) Into :numero From venfac
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo
		And   factura = :registros +1 ;
		IF Isnull(numero) Then numero =0
		IF numero <> 0 Then
       Select max((venfac.factura))  Into   :registros  From   venfac
       Where  venfac.empresa = :codigo_empresa
       And    venfac.anyo    = :var_anyo
		 And    venfac.serie    = :var_serie ;
      	UPDATE venparamfac
            SET factura = :registros
			 Where venparamfac.empresa = :codigo_empresa
			   And venparamfac.anyo   = :var_anyo
				And venparamfac.serie  = :var_serie;
				COMMIT;
		END IF

	em_factura.text = STring(registros) 

 



end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

type st_2 from statictext within w_generacion_facturas
integer x = 160
integer y = 156
integer width = 174
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_generacion_facturas
integer x = 1559
integer y = 96
integer width = 1061
integer height = 368
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_generacion_facturas
integer x = 1559
integer y = 460
integer width = 434
integer height = 240
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_generacion_facturas
integer x = 9
integer y = 96
integer width = 1499
integer height = 608
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_ln_alb from datawindow within w_generacion_facturas
boolean visible = false
integer x = 2866
integer y = 36
integer width = 494
integer height = 136
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_generacion_facturas2"
boolean livescroll = true
end type

type rb_semanal from radiobutton within w_generacion_facturas
integer x = 2194
integer y = 172
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Semanal"
boolean checked = true
end type

type rb_quincenal from radiobutton within w_generacion_facturas
integer x = 2194
integer y = 244
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quincenal"
end type

type rb_mensual from radiobutton within w_generacion_facturas
integer x = 2194
integer y = 320
integer width = 325
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mensual"
end type

type dw_fac from datawindow within w_generacion_facturas
boolean visible = false
integer x = 361
integer y = 352
integer width = 1056
integer height = 1016
integer taborder = 100
string dataobject = "dw_generacion_factura2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 Or IsNull(row) Then Return
em_factura.text = String(GetItemNumber(row,"factura"),"##########")
Reset()
visible = FALSE
end event

event clicked;IF f_objeto_datawindow(This)= "salir" Then
	Reset()
	visible = FALSE
END IF
end event

type dw_precartera from datawindow within w_generacion_facturas
boolean visible = false
integer x = 192
integer y = 612
integer width = 2363
integer height = 560
string dataobject = "dw_con_generacion_facturas_precartera"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;This.Visible=False
This.Reset()
end event

type dw_observa from u_datawindow_consultas within w_generacion_facturas
boolean visible = false
integer y = 152
integer width = 3031
integer height = 1520
integer taborder = 90
boolean titlebar = true
string title = "Observaciones de los clientes"
string dataobject = "dw_observaciones"
boolean controlmenu = true
boolean hscrollbar = true
end type

event clicked;call super::clicked;this.selectrow(0,false)
end event

type dw_facturas from u_datawindow_consultas within w_generacion_facturas
boolean visible = false
integer x = 9
integer y = 112
integer width = 3479
integer height = 2188
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_generacion_factura"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "fpago"
      bus_titulo     = "VENTANA SELECCION DE FORMAS DE PAGO"
 		bus_datawindow = "dw_ayuda_carforpag"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event rbuttondown;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

event valores_numericos;//f_valores_numericos(This,"fpago")
end event

event clicked;call super::clicked;STring moneda
Integer   r,f
Dec       factura
String    cartera,precartera,facturar,agrupar

Dec{6} cambio

This.SetRow(row)
This.SetColumn("fpago")
Integer r1 
String var_fpago,var_agrupar,var_cartera,var_precartera,var_facturar,var_cliente
Dec{0} var_albaran
dw_facturas.AcceptText()


IF f_objeto_datawindow(dw_facturas)= "actualizar" Then
	For r1 = 1 To dw_facturas.RowCount()
		var_albaran = dw_facturas.GetItemNumber(r1,"albaran")
		var_fpago   = dw_facturas.GetItemString(r1,"fpago")
		var_agrupar = dw_facturas.GetItemString(r1,"agrupar")
		var_facturar    = dw_facturas.GetItemString(r1,"facturar")
		var_cartera      = dw_facturas.GetItemString(r1,"cartera")
		var_precartera = dw_facturas.GetItemString(r1,"precartera")
		Update venalb
		Set    venalb.codpago     = :var_fpago,
		       venalb.agrupa      = :var_agrupar,
				 venalb.cartera     = :var_cartera,
				 venalb.precartera  = :var_precartera,
				 venalb.facturar    = :var_facturar
		Where  venalb.empresa  = :codigo_empresa
		And    venalb.anyo     = :var_anyo
		And    venalb.albaran  = :var_albaran;
		IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
		COMMIT;
			
		
	Next 
	f_desbloquear("facturar",em_serie.text,w_generacion_facturas.title) 
	bloq = "N"
	COMMIT;
	cb_continuar.TriggerEvent(Clicked!)
End If


IF f_objeto_datawindow(dw_facturas) = "facturar" Then
	facturar = This.getItemString(This.GetRow(),"facturar")
	var_cliente =This.getItemString(This.GetRow(),"cliente")
	If facturar = "N" Then
		facturar = "S"
		moneda = This.getItemstring(This.GetRow(),"moneda")
		cambio = f_cambio_moneda(moneda)
		f_grabar_venfaccar(This.getItemNumber(This.GetRow(),"anyo"),This.getItemNumber(This.GetRow(),"factura"), &
								 This.getItemString(This.GetRow(),"cliente"),This.getItemNumber(This.GetRow(),"importe"), &
								 This.getItemNumber(This.GetRow(),"importe")* cambio,moneda)
	ELse
		facturar = "N"
		f_borrar_venfaccar(This.getItemNumber(This.GetRow(),"anyo"),This.getItemNumber(This.GetRow(),"factura"))
	End if
	This.SetItem(This.GetRow(),"facturar",facturar)
END IF

IF f_objeto_datawindow(This) = "agrupar" Then
	agrupar = This.getItemString(This.GetRow(),"agrupar")
	If agrupar = "N" Then
		agrupar = "S"
	ELse
		agrupar = "N"
	End if
	This.SetItem(This.GetRow(),"agrupar",agrupar)
END IF



IF f_objeto_datawindow(dw_facturas)= "procesar" Then
		f_procesar()
		
END IF

IF f_objeto_datawindow(dw_facturas)= "salir" Then
	f_salir()
END IF


IF f_objeto_datawindow(This) = "consulta_precartera" Then 
	dw_precartera.Retrieve(codigo_empresa,f_cuenta_genter(codigo_empresa,"C",dw_facturas.GetItemString(dw_facturas.GetRow(),"cliente")),dw_facturas.GetItemString(dw_facturas.GetRow(),"moneda"))
	IF dw_precartera.RowCount()<> 0 Then
		dw_precartera.visible = TRUE
	Else
		f_mensaje("Este cliente no tiene recibos en precartera"," Pulse Ok")
	End If
 END IF
 IF f_objeto_datawindow(This) = "imprimir" Then
	f_cargar(dw_listado)
	dw_listado.visible = FALSE
	dw_listado.Object.titulo_fecha.text=em_fecha.text
	dw_listado.setfilter("factura>0")
	dw_listado.filter()
   dw_listado.object.Datawindow.print.preview = "Yes"
	f_imprimir_datawindow(dw_listado)
END IF
	


	

end event

event rowfocuschanged;call super::rowfocuschanged;This.SetRow(currentrow)
This.SetColumn("fpago")
end event

event doubleclicked;call super::doubleclicked;STring moneda
Integer   r,f
Dec       factura
String    cartera,precartera,facturar,agrupar


Dec cambio

This.SetRow(row)
This.SetColumn("fpago")
Integer r1 
String var_fpago,var_agrupar,var_cartera,var_precartera,var_facturar,var_cliente
Dec{0} var_albaran
dw_facturas.AcceptText()





IF f_objeto_datawindow(This) = "cartera" Then
//Descomentar si se quiere volver a utlizar el control de precartera
//	cartera = This.getItemString(This.GetRow(),"cartera")
//	If cartera = "N" Then
//		cartera = "S"
//		facturar = "S"
//		f_borrar_venfaccar(This.getItemNumber(This.GetRow(),"anyo"),This.getItemNumber(This.GetRow(),"factura"))
//		This.SetItem(This.GetRow(),"facturar",facturar)
//	ELse
//		cartera = "N"
//		moneda = This.getItemstring(This.GetRow(),"moneda")
//		cambio = f_cambio_moneda(moneda)
//		f_grabar_venfaccar(This.getItemNumber(This.GetRow(),"anyo"),This.getItemNumber(This.GetRow(),"factura"),This.getItemString(This.GetRow(),"cliente"),This.getItemNumber(This.GetRow(),"importe"),This.getItemNumber(This.GetRow(),"importe")* cambio,moneda)
//	End if
//	This.SetItem(This.GetRow(),"cartera",cartera)
END IF


IF f_objeto_datawindow(This) = "precartera" Then
//Descomentar si se quiere volver a utlizar el control de precartera
//	precartera = This.getItemString(This.GetRow(),"precartera")
//	IF precartera = "N" and This.getItemString(This.GetRow(),"cartera")= "N" Then
//		return
//	END IF
//	var_cliente= this.getitemstring(This.GetRow(),"cliente")
//	If precartera = "N" Then
//		long sss
//		sss=this.find("( cliente='"+var_cliente+"' and precartera='S')",1,this.rowcount())
//		if sss>0 then
//			messagebox("Precartera asignada","Los recibos de precartera ya están asignados")
//			precartera="N"	
//		else
//			precartera="S"
//			cartera = "S"
//			facturar = "S"
//			This.SetItem(This.GetRow(),"cartera",cartera)
//			This.SetItem(This.GetRow(),"facturar",facturar)
//			f_borrar_venfaccar(This.getItemNumber(This.GetRow(),"anyo"),This.getItemNumber(This.GetRow(),"factura"))
//			This.SetItem(This.GetRow(),"facturar",facturar)
//		end if
//	ELse
//		precartera = "N"
//	End if
//	This.SetItem(This.GetRow(),"precartera",precartera)
END IF

This.AcceptText()
IF f_objeto_datawindow(This) = "precartera"  or  f_objeto_datawindow(This) = "cartera" Then
//Descomentar si se quiere volver a utlizar el control de precartera
//		r    = This.GetRow()
//		factura    = This.GetItemNumber(r,"factura")
//		cartera    = This.GetItemString(r,"cartera")
//		precartera = This.GetItemString(r,"precartera")
//		r1   = This.RowCount()
//		IF r = 0 Then Return
//		For f = 1 To r1
//			IF This.GetItemNumber(f,"factura") = factura Then
//				IF cartera = "S" and GetItemSTring(f,"cartera")= "N" Then
//						f_borrar_venfaccar(This.getItemNumber(f,"anyo"),This.getItemNumber(f,"factura"))
//						This.SetItem(f,"facturar","S")
//				END IF
//				IF cartera = "N" and GetItemSTring(f,"cartera")= "S" Then
//					moneda = This.getItemstring(f,"moneda")
//					cambio = f_cambio_moneda(moneda)
//					f_grabar_venfaccar(This.getItemNumber(f,"anyo"),This.getItemNumber(f,"factura"),This.getItemString(f,"cliente"),This.getItemNumber(f,"importe"),This.getItemNumber(f,"importe")* cambio,moneda)
//				END IF
//				This.SetItem(f,"cartera",cartera)
//				IF cartera = "N" Then precartera = "N"
//				This.SetItem(f,"precartera",precartera)
//			END IF
//		Next
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;AcceptText()
SetItem(row,"nombre_carforpag",f_nombre_carforpag(codigo_empresa,GetItemString(row,"fpago")))
end event

event editchanged;call super::editchanged;AcceptText()
SetItem(row,"nombre_carforpag",f_nombre_carforpag(codigo_empresa,GetItemString(row,"fpago")))
end event

event itemchanged;call super::itemchanged;AcceptText()
SetItem(row,"nombre_carforpag",f_nombre_carforpag(codigo_empresa,GetItemString(row,"fpago")))
end event

