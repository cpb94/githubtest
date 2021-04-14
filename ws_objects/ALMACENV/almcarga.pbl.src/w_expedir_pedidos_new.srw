$PBExportHeader$w_expedir_pedidos_new.srw
forward
global type w_expedir_pedidos_new from w_int_con_empresa
end type
type pb_1 from upb_salir within w_expedir_pedidos_new
end type
type em_cliente from u_em_campo within w_expedir_pedidos_new
end type
type st_nomcliente from statictext within w_expedir_pedidos_new
end type
type cb_marcar_todo from u_boton within w_expedir_pedidos_new
end type
type st_operario from statictext within w_expedir_pedidos_new
end type
type uo_operario from u_em_campo_2 within w_expedir_pedidos_new
end type
type st_fecha from statictext within w_expedir_pedidos_new
end type
type em_fecha from u_em_campo within w_expedir_pedidos_new
end type
type st_albaran from statictext within w_expedir_pedidos_new
end type
type em_albaran from u_em_campo within w_expedir_pedidos_new
end type
type listar from radiobutton within w_expedir_pedidos_new
end type
type em_copias from u_em_campo within w_expedir_pedidos_new
end type
type st_copias from statictext within w_expedir_pedidos_new
end type
type cb_1 from u_boton within w_expedir_pedidos_new
end type
type dw_etiqueta_agencia from datawindow within w_expedir_pedidos_new
end type
type cb_informacion from commandbutton within w_expedir_pedidos_new
end type
type dw_consulta from u_datawindow_consultas within w_expedir_pedidos_new
end type
type dw_temporal from datawindow within w_expedir_pedidos_new
end type
type dw_albaranes from datawindow within w_expedir_pedidos_new
end type
type sle_articulo from singlelineedit within w_expedir_pedidos_new
end type
type dw_ubicaciones from datawindow within w_expedir_pedidos_new
end type
type dw_infor from datawindow within w_expedir_pedidos_new
end type
type dw_1 from datawindow within w_expedir_pedidos_new
end type
type orden_codigo from editmask within w_expedir_pedidos_new
end type
type gb_1 from groupbox within w_expedir_pedidos_new
end type
type gb_2 from groupbox within w_expedir_pedidos_new
end type
type gb_3 from groupbox within w_expedir_pedidos_new
end type
type st_1 from statictext within w_expedir_pedidos_new
end type
type pb_3 from picturebutton within w_expedir_pedidos_new
end type
type st_cmr from statictext within w_expedir_pedidos_new
end type
type em_cmr from u_em_campo within w_expedir_pedidos_new
end type
type dw_listado_cmr from datawindow within w_expedir_pedidos_new
end type
type dw_listado_vgm from datawindow within w_expedir_pedidos_new
end type
type dw_pedido from u_datawindow_consultas within w_expedir_pedidos_new
end type
type dw_detalle from u_datawindow_consultas within w_expedir_pedidos_new
end type
type t_preparado from statictext within w_expedir_pedidos_new
end type
end forward

global type w_expedir_pedidos_new from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 5966
integer height = 3156
string pointer = "Arrow!"
pb_1 pb_1
em_cliente em_cliente
st_nomcliente st_nomcliente
cb_marcar_todo cb_marcar_todo
st_operario st_operario
uo_operario uo_operario
st_fecha st_fecha
em_fecha em_fecha
st_albaran st_albaran
em_albaran em_albaran
listar listar
em_copias em_copias
st_copias st_copias
cb_1 cb_1
dw_etiqueta_agencia dw_etiqueta_agencia
cb_informacion cb_informacion
dw_consulta dw_consulta
dw_temporal dw_temporal
dw_albaranes dw_albaranes
sle_articulo sle_articulo
dw_ubicaciones dw_ubicaciones
dw_infor dw_infor
dw_1 dw_1
orden_codigo orden_codigo
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
st_1 st_1
pb_3 pb_3
st_cmr st_cmr
em_cmr em_cmr
dw_listado_cmr dw_listado_cmr
dw_listado_vgm dw_listado_vgm
dw_pedido dw_pedido
dw_detalle dw_detalle
t_preparado t_preparado
end type
global w_expedir_pedidos_new w_expedir_pedidos_new

type variables
Dec{0} paso,nueva_ln_pedido
Dec{2} peso, peso_neto
Dec{0}  var_anyo_albaran,veces
Dec{0} control_lineas = 0
Dec{0} lin_alb = 0
String  v_deposito,is_contenedor
String observaciones = "",dni=''
String precinto, matricula,formaenvio,is_remolque
Dec var_albaran[]
Dec var_peso_neto[]
Dec var_peso_bruto[]
Dec var_contador  = 1
dec{2} precio_portes = 0
dec bultos
String is_agencia,is_conductor,conductor 
Dec peso_neto_albaran, peso_bruto_albaran
String observaciones_albaran

str_albaranes_a_generar istr_albaranes_a_generar[],istr_albaranes_a_generar_vacio[]

string is_booking,is_metodo_verificacion_masa_bruta
dec    id_tara_contenedor
int    il_contador_array_albaranes
end variables

forward prototypes
public subroutine f_campos (boolean bool)
public subroutine f_salir ()
public function boolean f_proceso_pedidos (integer elemento)
public function boolean f_grabar_albaran (integer reg)
public function boolean f_control_existencias ()
public function boolean f_expedir_pedido (integer elemento)
public function boolean f_grabar_salida_ventas (integer elemento)
public subroutine f_todo ()
public subroutine f_marcar_linea (integer t)
public subroutine f_control_marcar_linea (integer t)
public subroutine f_desmarcar_linea (integer t)
public function boolean f_entrada_regularizacion (integer diferencia, string var_articulo, string var_calidad, string var_tono, integer var_calibre, string var_caja, string var_tipo_unidad, string var_tipo_pallet, string var_familia, string var_formato, string var_modelo, string var_sector)
public function boolean f_salida_regularizacion (integer diferencia, string var_articulo, string var_calidad, string var_tono, integer var_calibre, string var_caja, string var_tipo_unidad, string var_tipo_pallet, string var_familia, string var_formato, string var_modelo, string var_sector)
public subroutine f_salir2 ()
public function boolean f_control_ubicaciones (long var_anyo, long var_pedido, long var_linea)
protected subroutine f_expedir ()
public subroutine f_filtrar ()
public function integer f_calcula_albaranes_a_generar ()
public subroutine f_mostrar_bultos_linea (datawindow arg_datawindow, long arg_row)
end prototypes

public subroutine f_campos (boolean bool);dw_pedido.visible = bool
cb_marcar_todo.visible    = bool
st_operario.visible       = bool
uo_operario.visible       = bool
st_fecha.visible       = bool
em_fecha.visible       = bool
st_albaran.visible       = bool
em_albaran.visible       = bool
st_cmr.visible       = bool
em_cmr.visible       = bool

listar.visible = bool
st_copias.visible = bool
em_copias.visible = bool
st_1.visible = bool

IF bool Then
	em_cliente.enabled = FALSE
	sle_opcion_orden.enabled = FALSE
	em_cliente.TabOrder = 0
	sle_opcion_orden.TabOrder = 0
	f_activar_campo(uo_operario.em_campo)
ELSE
	em_cliente.enabled = TRUE
	sle_opcion_orden.enabled = TRUE
	em_cliente.TabOrder = 10
	sle_opcion_orden.TabOrder = 20
		f_activar_campo(em_cliente)
END IF
	
IF bool Then 
	paso= 2
ELSE
	paso = 1
END IF
end subroutine

public subroutine f_salir ();integer respuesta

cb_1.visible = TRUE
pb_1.visible = TRUE

f_campos(FALSE)
cb_informacion.visible = TRUE

dw_detalle.SetRow(1)
end subroutine

public function boolean f_proceso_pedidos (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido
Dec{0} var_anyo,var_orden,var_linea
string cadena
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga
Dec var_cantidad_carga
Integer var_bien
Long   posi,posi_aux

var_bien = 0
str_venliped linped
var_anyo       = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
var_pedido     = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
var_linea       = dw_pedido.GetItemNumber(elemento,"venliped_linea")
var_pallets_carga     = dw_pedido.GetItemNumber(elemento,"venliped_pallets")
var_cajas_carga       = dw_pedido.GetItemNumber(elemento,"venliped_cajas")
var_total_cajas_carga = dw_pedido.GetItemNumber(elemento,"venliped_total_cajas")
var_cantidad_carga    = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")

linped.empresa   =   codigo_empresa
linped.anyo      =   var_anyo
linped.pedido    =   var_pedido
linped.linea     =   var_linea

  SELECT venliped.empresa, venliped.anyo,         venliped.pedido, 		venliped.linea,   
         venliped.serie,   venliped.fpedido,      venliped.fentrega,   	venliped.fentrega_inicial,
         venliped.cliente, venliped.tipo_unidad,  venliped.articulo,   
         venliped.familia, venliped.formato,      venliped.modelo,   
         venliped.calidad, venliped.tonochar,     venliped.calibre,   
         venliped.precio,  venliped.precio_estand,venliped.cantidad,   
         venliped.pallets, venliped.total_cajas,  venliped.cajas,   
         venliped.dtocomer,venliped.dtoesp,       venliped.descripcion,   
         venliped.tipoiva, venliped.iva,          venliped.linfab,   
         venliped.provincia,venliped.pais,        venliped.zona,   
         venliped.tipolinea,venliped.texto1,      venliped.texto2,   
         venliped.texto3,   venliped.texto4,      venliped.referencia,   
         venliped.montajeartcal,     venliped.situacion, venliped.divisa,   
         venliped.metros_lineales,  venliped.peso, venliped.falta,   
         venliped.usuario,  venliped.tipo_pallet, venliped.caja,  
			venliped.importe,  venliped.descuento,venliped.importedto,    
			venliped.clase, venliped.sector, venliped.agente1,
			venliped.agente2, venliped.agente3,
			venliped.comision11,venliped.comision12,   
         venliped.comision21,venliped.comision22,venliped.comision31,   
         venliped.comision32, venliped.deposito, venliped.orden_preparacion,   
         venliped.cantidad_prepa,venliped.es_pico,venliped.numero_pico,   
         venliped.anyo_ent, venliped.nummov_ent,  venliped.anyo_sal,   
         venliped.nummov_sal,venliped.fila_ent,venliped.altura_ent,   
         venliped.operario_prepa,venliped.control_incremento,
			venliped.peso_neto,venliped.precio_aduana,venliped.control_descuentos,   
         venliped.control_comisiones,venliped.importe_aduana,
			venliped.bruto, venliped.precio_neto,
			venliped.precio_aduana_neto,venliped.descuento_aduana,   
         venliped.neto,venliped.impdtopp,venliped.ref_cli,   
         venliped.transportista,venliped.almacen_ent
    INTO :linped.empresa,:linped.anyo,:linped.pedido,:linped.linea,   
         :linped.serie,  :linped.fpedido, :linped.fentrega, :linped.fentrega_inicial,
			:linped.cliente,:linped.tipo_unidad,:linped.articulo,   
         :linped.familia,:linped.formato,:linped.modelo,   
         :linped.calidad,:linped.tonochar, :linped.calibre,   
         :linped.precio, :linped.precio_estand,:linped.cantidad,   
         :linped.pallets,:linped.total_cajas,:linped.cajas,   
         :linped.dtocomer,:linped.dtoesp,:linped.descripcion,   
         :linped.tipoiva,:linped.iva,:linped.linfab,:linped.provincia,   
         :linped.pais, :linped.zona,:linped.tipolinea,:linped.texto1,   
         :linped.texto2, :linped.texto3,:linped.texto4, :linped.referencia,   
         :linped.montajeartcal,:linped.situacion,:linped.divisa,   
         :linped.metros_lineales,:linped.peso, :linped.falta,   
         :linped.usuario,:linped.tipo_pallet,:linped.caja,:linped.importe,   
         :linped.descuento,:linped.importedto,:linped.clase,   
         :linped.sector,:linped.agente1,:linped.agente2,:linped.agente3,   
         :linped.comision11,:linped.comision12,:linped.comision21,   
         :linped.comision22,:linped.comision31,:linped.comision32,   
         :linped.deposito,:linped.orden_preparacion,
			:linped.cantidad_prepa,:linped.es_pico,:linped.numero_pico,   
         :linped.anyo_ent,:linped.nummov_ent,:linped.anyo_sal,   
         :linped.nummov_sal,:linped.fila_ent,:linped.altura_ent,   
         :linped.operario_prepa,:linped.control_incremento,   
         :linped.peso_neto,:linped.precio_aduana,   
         :linped.control_descuentos,:linped.control_comisiones,   
         :linped.importe_aduana,:linped.bruto,:linped.precio_neto,   
         :linped.precio_aduana_neto,:linped.descuento_aduana,   
         :linped.neto,:linped.impdtopp,:linped.ref_cli,   
         :linped.transportista,:linped.almacen_ent
    FROM venliped  
   WHERE ( venliped.empresa = :codigo_empresa ) AND  
         ( venliped.anyo    = :var_anyo_pedido ) AND  
         ( venliped.pedido  = :var_pedido ) AND  
         ( venliped.linea   = :var_linea_pedido )   ;
			IF SQLCA.SQLCODE = 100 Then var_bien = 1
			
IF IsNull(var_cantidad_carga) Then var_cantidad_carga = 0
linped.cantidad = linped.cantidad - var_cantidad_carga
 cadena=f_calculo_unidades_tipolin(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,linped.caja,&
                            0,&
                            0,&
                            linped.cantidad, linped.tipo_unidad)

posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	linped.pallets     = dec(Mid(cadena,1,posi - 1))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	linped.cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	linped.total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	linped.cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

IF linped.cantidad <> 0 then
	UPDATE venliped
	Set venliped.pallets     = :linped.pallets,
	    venliped.total_cajas = :linped.total_cajas,
	    venliped.cajas       = :linped.cajas,
	    venliped.cantidad    = :linped.cantidad
	   WHERE (venliped.empresa = :codigo_empresa )
		AND   (venliped.anyo    = :var_anyo_pedido )
		AND   (venliped.pedido  = :var_pedido )
		AND   (venliped.linea   = :var_linea_pedido );
		IF SQLCA.SQLCODE <> 0  Then 
			var_bien = 1
			f_mensaje("Error en datos(3)",sqlca.sqlerrtext)
		END IF
	IF Not f_actualizar_linea_venpedido(codigo_empresa,var_anyo_pedido,var_pedido,var_linea_pedido) Then var_bien = 1

	Select Max(venliped.linea) Into :linped.linea From venliped
	Where  venliped.empresa  = :codigo_empresa
	And    venliped.anyo     = :var_anyo_pedido
	And    venliped.pedido   = :var_pedido;
	linped.linea = linped.linea + 1

	linped.cantidad = var_cantidad_carga
	cadena=f_calculo_unidades_tipolin(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,linped.caja,&
                            0,&
                            0,&
                            linped.cantidad, linped.tipo_unidad)
                       
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		linped.pallets     = dec(Mid(cadena,1,posi - 1))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		linped.cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		linped.total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		linped.cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
	
	linped.situacion     = "P"
	nueva_ln_pedido= linped.linea
	IF Not f_insertar_venliped(linped)  Then 
		var_bien = 1
		f_mensaje("Error en datos en insercion ln pedido",sqlca.sqlerrtext)
	END IF
	IF Not f_actualizar_linea_venpedido(codigo_empresa,linped.anyo,linped.pedido,linped.linea) Then var_bien = 1
	
ELSE
	
	UPDATE venliped
	Set venliped.situacion     = "P"
	   WHERE (venliped.empresa = :codigo_empresa )
		AND   (venliped.anyo    = :var_anyo_pedido )
		AND   (venliped.pedido  = :var_pedido )
		AND   (venliped.linea   = :var_linea_pedido );
		IF SQLCA.SQLCODE <> 0  Then 
			var_bien = 1
			f_mensaje("Error en datos(2)",sqlca.sqlerrtext)
		END IF
END IF
IF Not f_actualizar_venpedido(codigo_empresa,var_anyo_pedido,var_pedido) Then var_bien = 1
UPDATE almlincargas
	Set  almlincargas.anyo_ped  = :var_anyo_pedido,
	     almlincargas.pedido    = :var_pedido,
		  almlincargas.linea_ped = :linped.linea,
		  almlincargas.situacion_pedido = "P"
		  
   Where almlincargas.empresa = :codigo_empresa
	And   almlincargas.anyo    = :var_anyo
	And   almlincargas.orden   = :var_orden
	And   almlincargas.linea   = :var_linea;
	IF SQLCA.SQLCODE <> 0  Then
		var_bien = 1
		f_mensaje("Error en datos (1)",sqlca.sqlerrtext)
	END IF
IF var_bien = 0 Then
	RETURN TRUE
ELSE
	RETURN FALSE
END IF



end function

public function boolean f_grabar_albaran (integer reg);// Lo duplico para tener los albaranes numerados de forma consecutiva sin contemplar las series.
Dec{0}   var_anyo,var_pedido,var_linea,bien,var_albaran1,var_albaran2,numero
str_venlialb lialb
str_venalb alb
Int expedicion_anyo
String expedicion_codigo

string serie = '1'

long ll_existe_linea_pedido_en_alb,ll_linea_albaran_a_agrupar,ll_cantidad_pzs_albaran_existe
dec  ld_cantidad_albaran_existe,ld_cantidad_facturar_existe
string cadena,ls_ventipolin_gestionar_en_piezas
long   posi_aux,posi

veces = veces +1

bien = 0
var_anyo     = dw_pedido.GetItemNumber(reg,"venliped_anyo")
var_pedido   = dw_pedido.GetItemNumber(reg,"venliped_pedido")
var_linea    = dw_pedido.GetItemNumber(reg,"venliped_linea")

//ORDEN DE CARGA
expedicion_anyo = dw_pedido.GetItemNumber(reg,"expedicion_anyo")
expedicion_codigo = dw_pedido.GetItemString(reg,"expedicion_codigo")

alb.expedicion_anyo = expedicion_anyo
alb.expedicion_codigo = expedicion_codigo

IF veces = 1 Then
	control_lineas = 0
	IF Dec(em_albaran.text) = 0 Then
		
		SELECT   venped.empresa,   
					venped.anyo,   
					venped.pedido,   
					venped.cliente,   
					venped.codpago,   
					venped.agente1,   
					venped.agente2,   
					venped.comision1,   
					venped.comision2,   
					venped.comision11,   
					venped.comision22,   
					venped.dtopp,   
					venped.dtoesp1,   
					venped.dtoesp2,   
					venped.dtoesp3,   
					venped.dtoesp4,   
					venped.tipodto1,   
					venped.tipodto2,   
					venped.tipodto3,   
					venped.tipodto4,   
					venped.explicaciondto1,   
					venped.explicaciondto2,   
					venped.explicaciondto3,   
					venped.explicaciondto4,   
					venped.tipoiva,   
					venped.iva,   
					venped.numpedcli,   
					venped.idioma,   
					venped.divisa,   
					venped.cambio,   
					venped.tarifa,   
					venped.ftarifa,   
					venped.fbloqueo,   
					venped.transportista,   
					venped.serie,   
					venped.zona,   
					venped.envio,   
					venped.correspondencia,   
					venped.domiciliacion,   
					venped.forma_envio,   
					venped.cod_entrega,   
					venped.usuario,   
					venped.tipo_portes,   
					venped.periodo_fac,    
					venped.usuario_pedido,   
					venped.agente3,   
					venped.comision31,   
					venped.comision32,   
					venped.veces,   
					venped.textcomercial1,   
					venped.textcomercial2,   
					venped.textaduanaesp1,   
					venped.textaduanaesp2,   
					venped.textaduanaext1,   
					venped.textaduanaext2,   
					venped.textopie1,   
					venped.textopie2,   
					venped.condicion,   
					venped.banco_de_cobro,   
					venped.porcentaje_aduana,   
					venped.bruto,   
					venped.importe_dto,   
					venped.total_neto,   
					venped.calculo_dto,   
					venped.fentrega,   
					venped.observaciones,
					venped.agrupa,
					venped.deposito,
					venped.almacen_deposito,
					venped.calculo_dtoesp,
					venped.agrupa_exp,
					venped.comision_fija1,
					venped.comision_fija2,
					venped.comision_fija3,
					venped.peso_bascula_kg
		INTO     :alb.empresa,   
					:alb.anyo_pedido_origen,   
					:alb.pedido_origen,   
					:alb.cliente,   
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
					:alb.numpedcli,   
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
					:alb.banco_de_cobro,   
					:alb.porcentaje_aduana,   
					:alb.bruto,   
					:alb.importe_dto,   
					:alb.total_neto,   
					:alb.calculo_dto,   
					:alb.fentrega,   
					:alb.observaciones,  
					:alb.agrupa,
					:alb.deposito,
					:alb.almacen_deposito,
					:alb.calculo_dtoesp,
					:lialb.agrupa_exp,
					:alb.comision_fija1,
					:alb.comision_fija2,
					:alb.comision_fija3,
					:alb.peso_bascula_kg
		FROM     venped  
		WHERE    venped.empresa = :codigo_empresa 
		AND		venped.anyo    = :var_anyo 
		AND		venped.pedido  = :var_pedido;
		
		
		//PESOS (NO Válido, se sabe a posteriori)
//		alb.peso = var_peso_bruto[var_contador]
//		alb.peso_neto = var_peso_neto[var_contador]
//		peso_bruto_albaran = alb.peso
//		peso_neto_albaran = alb.peso_neto			
			
		if reg = 1 then 
			observaciones_albaran = observaciones
		end if
		
		
		if sqlca.sqlcode <> 0 then
			f_mensaje("Selección de datos del pedido (generación del albarán)","Error: "+sqlca.sqlerrtext)
			bien = 1
		end if
				
		SELECT venparamalb.albaran   
		INTO   :var_albaran[var_contador] 
		FROM   venparamalb  
		WHERE  venparamalb.empresa = :codigo_empresa  
		And    venparamalb.anyo    = :var_anyo_albaran
		And    venparamalb.serie   = :serie;
		
		If Sqlca.Sqlcode = 100 Then
			INSERT INTO venparamalb
			            (empresa,
							 anyo,
							 albaran,
							 serie)  
			VALUES      (:codigo_empresa,
			             :var_anyo_albaran,
							 0,
							 :serie);
         messagebox("Atención","La serie a la que corresponde el albaran no tiene el contador activado.")							 
		END IF
		
		IF IsNull(var_albaran[var_contador]) Then var_albaran[var_contador] = 0
		var_albaran[var_contador] = var_albaran[var_contador] + 1
				
		Select  count(*) 
		Into    :numero 
		From    venalb
		Where   venalb.empresa    = :codigo_empresa
		And     venalb.anyo       = :var_anyo_albaran
		And     venalb.albaran    = :var_albaran[var_contador];
		
		If IsNull(numero) Then numero = 0
		IF numero = 0 Then
			Select  count(*) 
			Into    :numero
			From    venlifac
			Where   venlifac.empresa      = :codigo_empresa
			And     venlifac.anyo_albaran = :var_anyo_albaran
			And     venlifac.albaran      = :var_albaran[var_contador];
			
			If IsNull(numero) Then numero=0
		END IF
		If numero <> 0 Then
			f_grabar_incidencia(w_expedir_pedidos.title,"Proceso lento seleccion ultimo albaran")
			
			Select Max(venalb.albaran)  
			Into   :var_albaran1 
			From   venalb
			Where  venalb.empresa = :codigo_empresa
			And    venalb.anyo    = :var_anyo_albaran
			And    venalb.serie   = :serie;
			
			IF IsNull(var_albaran1) Then var_albaran1 = 0
			
			Select Max(venlifac.albaran)  
			Into   :var_albaran2 
			From   venlifac
			Where  venlifac.empresa      = :codigo_empresa
			And    venlifac.anyo_albaran = :var_anyo_albaran
			And    venlifac.serie        = :serie;
			
			IF IsNull(var_albaran2) Then var_albaran2 = 0
			
			var_albaran[var_contador] = var_albaran1
			IF var_albaran2 > var_albaran[var_contador] Then var_albaran[var_contador] = var_albaran2
			var_albaran[var_contador] = var_albaran[var_contador] + 1
		End If
		
		UPDATE venparamalb
		SET    albaran             = :var_albaran[var_contador]
		WHERE  venparamalb.empresa = :codigo_empresa
		And    venparamalb.anyo    = :var_anyo_albaran
		And    venparamalb.serie   = :serie;
		
		IF sqlca.sqlcode <> 0 then
			f_mensaje("Actualización de venparamalb","Error: "+sqlca.sqlerrtext)
		end if
		
		alb.empresa       = codigo_empresa
		alb.anyo          = var_anyo_albaran
		alb.albaran       = var_albaran[var_contador]		
		alb.falbaran      = DateTime(Date(em_fecha.text))
		alb.flistado      = DateTime(Today(),Now())
		alb.veces         = 1
		alb.falta         = DateTime(Today(),Now())
		alb.fcarga        = DateTime(Today())
		alb.deposito      = v_deposito
		alb.abono         = "N"
		alb.observaciones = observaciones
		alb.contenedor    = is_contenedor
		alb.precinto      = precinto
		alb.matricula		= matricula
		//
		alb.dni				= dni//f_venconductores_dni(codigo_empresa,is_agencia,is_conductor)
		alb.forma_envio   = formaenvio
		alb.bultos        = bultos
		alb.conductor     = conductor
		alb.transportista = is_agencia
		alb.venconductores_codigo = is_conductor
		alb.remolque      = is_remolque
		alb.usuario       = nombre_usuario 
		//
		//alb.operario_carga = uo_operario.em_codigo.text//No se utiliza en Tencer
		
		alb.booking = is_booking
		alb.tara_contenedor = id_tara_contenedor
		alb.metodo_verificacion_masa_bruta = is_metodo_verificacion_masa_bruta		
		//
		IF Not f_insertar_venalb(alb)  Then 
			bien = 1
			f_mensaje("Error al insertar albaran",sqlca.sqlErrtext)
		END IF	
		
		istr_albaranes_a_generar[il_contador_array_albaranes].anyo = alb.anyo
		istr_albaranes_a_generar[il_contador_array_albaranes].albaran = alb.albaran		
		
		//GRABAR código de albaran en O.C
		if not isnull(expedicion_codigo) and expedicion_codigo <> "" and bien = 0 then
			UPDATE expedicion 
			SET venalb_anyo = :var_anyo_albaran , venalb_albaran = :var_albaran[var_contador]
			WHERE empresa = :codigo_empresa AND anyo = :expedicion_anyo AND codigo = :expedicion_codigo;
		end if
	ELSE
  		var_albaran[var_contador] = Dec(em_albaran.text)
  		alb.empresa = codigo_empresa
  		alb.anyo    = var_anyo_albaran
  		alb.albaran = var_albaran[var_contador]
		  f_mensaje_proceso("Selecion Máxima linea",reg,dw_pedido.Rowcount())
		 Select Max(linea) Into :control_lineas From venlialb
		 Where  venlialb.empresa = :codigo_empresa
		 And    venlialb.anyo    = :var_anyo_albaran
		 And    venlialb.albaran = :var_albaran[var_contador];
		 IF IsNull(control_lineas) Then control_lineas = 0
		 
		istr_albaranes_a_generar[il_contador_array_albaranes].anyo = var_anyo_albaran
		istr_albaranes_a_generar[il_contador_array_albaranes].albaran = var_albaran[var_contador]		 		 
  	END IF
END IF

lialb.fcarga              = DateTime(Today())
lialb.anyo_pedido_origen  = var_anyo
lialb.pedido_origen       = var_pedido
lialb.linea_pedido_origen = var_linea
lialb.albaran             = var_albaran[var_contador]
lialb.anyo                = var_anyo_albaran
lialb.linea               = veces + control_lineas
lin_alb                   = lialb.linea
lialb.empresa             = codigo_empresa
lialb.falbaran            = DateTime(Date(em_fecha.text))
lialb.falta               = alb.falta

  SELECT venliped.serie,
		venliped.fentrega,  
		venliped.fentrega_inicial,  
		venliped.cliente,
		venliped.tipo_unidad,   
		venliped.articulo,   
		venliped.familia,
		venliped.subfamilia,
		venliped.formato,   
		venliped.subformato,
		venliped.modelo,   
		venliped.calidad,   
		venliped.tonochar,   
		venliped.calibre,   
		venliped.precio,   
		venliped.precio_estand,   
		venliped.cantidad,   
		venliped.pallets,   
		venliped.total_cajas,   
		venliped.cajas,   
		venliped.dtocomer,   
		venliped.dtoesp,   
		venliped.descripcion,   
		venliped.tipoiva,   
		venliped.iva,   
		venliped.linfab,   
		venliped.provincia,   
		venliped.pais,   
		venliped.zona,   
		venliped.tipolinea,   
		venliped.texto1,   
		venliped.texto2,   
		venliped.texto3,   
		venliped.texto4,   
		venliped.referencia,   
		venliped.montajeartcal,   
		venliped.situacion,   
		venliped.divisa,   
		venliped.metros_lineales,   
		venliped.peso,   
		venliped.falta,   
		venliped.usuario,   
		venliped.tipo_pallet,   
		venliped.caja,
		venliped.importe,   
		venliped.descuento,   
		venliped.importedto,   
		venliped.clase,   
		venliped.sector,   
		venliped.agente1,   
		venliped.agente2,   
		venliped.agente3,   
		venliped.comision11,   
		venliped.comision12,   
		venliped.comision21,   
		venliped.comision22,   
		venliped.comision31,   
		venliped.comision32,   
		venliped.deposito,   
		venliped.orden_preparacion,   
		venliped.cantidad_prepa,   
		venliped.es_pico,   
		venliped.numero_pico,   
		venliped.anyo_ent,   
		venliped.nummov_ent,   
		venliped.anyo_sal,   
		venliped.nummov_sal,   
		venliped.fila_ent,   
		venliped.altura_ent,   
		venliped.operario_prepa,   
		venliped.control_incremento,   
		venliped.peso_neto,   
		venliped.precio_aduana,   
		venliped.control_descuentos,   
		venliped.control_comisiones,   
		venliped.importe_aduana,   
		venliped.bruto,   
		venliped.precio_neto,   
		venliped.precio_aduana_neto,   
		venliped.descuento_aduana,   
		venliped.neto,   
		venliped.impdtopp,   
		venliped.ref_cli,   
		venliped.transportista,   
		venliped.almacen_ent  ,
		venliped.almacen_deposito,
		venliped.numpedcli,
		venliped.almacen_de_carga,
		venliped.dtoesp2,
		venliped.fpedido,
		venliped.anyo_proddiaria,
		venliped.contador_proddiaria,
		venliped.idioma,
		venliped.cantidad_original,
		venliped.linea_desdoblada_de,
		venliped.planificado,
		venliped.fecha_intr,
		venliped.tono_imprimir,
		venliped.calibre_imprimir,
		venliped.id_alm_orden_carga,
		venliped.ordenacion_orden_carga,
		venliped.bulto_desde_orden_carga,
		venliped.bulto_hasta_orden_carga,
		venliped.id_alm_orden_preparacion 
    INTO :lialb.serie,   
         :lialb.fentrega, 
			:lialb.fentrega_inicial,		
         :lialb.cliente,   
         :lialb.tipo_unidad,   
         :lialb.articulo,   
			:lialb.familia,   
			:lialb.subfamilia,
			:lialb.formato,   
			:lialb.subformato,   
			:lialb.modelo,   
			:lialb.calidad,   
			:lialb.tonochar,   
			:lialb.calibre,   
			:lialb.precio,   
			:lialb.precio_estand,   
			:lialb.cantidad,   
			:lialb.pallets,   
			:lialb.total_cajas,   
			:lialb.cajas,   
			:lialb.dtocomer,   
			:lialb.dtoesp,   
			:lialb.descripcion,   
			:lialb.tipoiva,   
			:lialb.iva,   
			:lialb.linfab,   
			:lialb.provincia,   
			:lialb.pais,   
			:lialb.zona,   
			:lialb.tipolinea,   
			:lialb.texto1,   
			:lialb.texto2,   
			:lialb.texto3,   
			:lialb.texto4,   
			:lialb.referencia,   
			:lialb.montajeartcal,   
			:lialb.situacion,   
			:lialb.divisa,   
			:lialb.metros_lineales,   
			:lialb.peso,   
			:lialb.falta,   
			:lialb.usuario,   
			:lialb.tipo_pallet,   
			:lialb.caja,
			:lialb.importe,   
			:lialb.descuento,   
			:lialb.importedto,   
			:lialb.clase,   
			:lialb.sector,   
			:lialb.agente1,   
			:lialb.agente2,   
			:lialb.agente3,   
			:lialb.comision11,   
			:lialb.comision12,   
			:lialb.comision21,   
			:lialb.comision22,   
			:lialb.comision31,   
			:lialb.comision32,   
			:lialb.deposito,   
			:lialb.orden_preparacion,   
			:lialb.cantidad_prepa,   
			:lialb.es_pico,   
			:lialb.numero_pico,   
			:lialb.anyo_ent,   
			:lialb.nummov_ent,   
			:lialb.anyo_sal,   
			:lialb.nummov_sal,   
			:lialb.fila_ent,   
			:lialb.altura_ent,   
			:lialb.operario_prepa,   
			:lialb.control_incremento,   
			:lialb.peso_neto,   
			:lialb.precio_aduana,   
			:lialb.control_descuentos,   
			:lialb.control_comisiones,   
			:lialb.importe_aduana,   
			:lialb.bruto,   
			:lialb.precio_neto,   
			:lialb.precio_aduana_neto,   
			:lialb.descuento_aduana,   
			:lialb.neto,   
			:lialb.impdtopp,   
			:lialb.ref_cli,   
			:lialb.transportista,   
			:lialb.almacen_ent,
			:lialb.almacen_deposito,
			:lialb.numpedcli,
			:lialb.almacen_de_carga,
			:lialb.dtoesp2,
			:lialb.fpedido_origen,
			:lialb.anyo_proddiaria,
			:lialb.contador_proddiaria,
			:lialb.idioma,
			:lialb.cantidad_original,
			:lialb.linea_desdoblada_de,
			:lialb.planificado,
			:lialb.fecha_linped,
			:lialb.tono_imprimir,
			:lialb.calibre_imprimir,
			:lialb.id_alm_orden_carga,
			:lialb.ordenacion_orden_carga,
			:lialb.bulto_desde_orden_carga,
			:lialb.bulto_hasta_orden_carga,
			:lialb.id_alm_orden_preparacion 
    FROM  venliped  
   WHERE  venliped.empresa = :codigo_empresa 
	AND    venliped.anyo    = :var_anyo
	AND    venliped.pedido  = :var_pedido 
	AND    venliped.linea   = :var_linea ;
	
	if sqlca.sqlcode <> 0 then
		f_mensaje("Selección de datos de líneas de pedido","Error: "+sqlca.sqlerrtext)
		bien = 1
	end if
			
			
lialb.falta = DateTime(Today(),Now())
lialb.usuario = nombre_usuario
lialb.pallets     = dw_pedido.GetItemNumber(reg,"venliped_pallets")
lialb.cajas       = dw_pedido.GetItemNumber(reg,"venliped_cajas")
lialb.total_cajas = dw_pedido.GetItemNumber(reg,"venliped_total_cajas")
lialb.cantidad    = dw_pedido.GetItemNumber(reg,"venliped_cantidad_facturar")
lialb.cantidad_pedido = dw_pedido.GetItemNumber(reg,"venliped_cantidad")
lialb.cantidad_pzs = dw_pedido.GetItemNumber(reg,"venliped_cantidad_pzs")
ls_ventipolin_gestionar_en_piezas = dw_pedido.GetItemString(reg,"ventipolin_gestionar_en_piezas")			

lialb.ubicacion   = f_componer_ubicacion(dw_pedido.GetItemString(reg,"almacen"), dw_pedido.GetItemString(reg,"zona"), dw_pedido.GetItemNumber(reg,"fila"), dw_pedido.GetItemNumber(reg,"altura"))
lialb.numpalet    = dw_pedido.GetItemNumber(reg,"venliped_numpalet")	

//CAMPOS GUARDADOS EN LAS LINEAS PARA PODER MOSTRAR EN CASO DE AGRUPACIÓN DE FACTURAS
lialb.contenedor  = is_contenedor
lialb.precinto		= precinto
lialb.matricula	= matricula
lialb.expedicion_anyo_venalb	= expedicion_anyo
lialb.expedicion_codigo_venalb	= expedicion_codigo
lialb.observaciones_venalb = observaciones_albaran 
lialb.forma_envio_venalb = formaenvio 
lialb.conductor_venalb = conductor 

if lialb.cliente = '1663' then
	lialb.deposito = 'S' //El cliente de promocion interna siempre genera un albaran de deposito
end if

//NO Válido, se sabe al finalizar el proceso
//lialb.peso_bruto_venalb = peso_bruto_albaran
//lialb.peso_neto_venalb = peso_neto_albaran
//lialb.bultos_venalb = bultos

//////////////////  RECÁLCULO DE LOS DESCUENTOS DESPUÉS DE MODIFICAR LA CANTIDAD A VENDER //////////////////////
//dec nuevo_bruto, nuevo_importedto
//
//nuevo_bruto = lialb.cantidad_pedido * lialb.precio
//lialb.bruto = nuevo_bruto
//nuevo_importedto = nuevo_bruto * (lialb.dtoesp / 100 )
//nuevo_bruto = nuevo_bruto - (nuevo_bruto *  (lialb.dtoesp / 100 ))
//lialb.importedto = nuevo_importedto + nuevo_bruto * (lialb.dtoesp2 / 100 )
//lialb.importe = nuevo_bruto - (nuevo_bruto * (lialb.dtoesp2 / 100 ))
//lialb.neto = lialb.importe

//////////////  FIN RECÁLCULO DE LOS DESCUENTOS DESPUÉS DE MODIFICAR LA CANTIDAD A VENDER /////////////////////

select isnull(count(*),0)
into   :ll_existe_linea_pedido_en_alb
from   venlilab
where  venlialb.empresa             = :lialb.empresa
and    venlialb.anyo                = :lialb.anyo
and    venlialb.albaran             = :lialb.albaran
and    venlialb.anyo_pedido_origen  = :lialb.anyo_pedido_origen
and    venlialb.pedido_origen       = :lialb.pedido_origen
and    venlialb.linea_pedido_origen = :lialb.linea_pedido_origen;

if ll_existe_linea_pedido_en_alb = 0 then
	IF Not f_insertar_venlialb(lialb) Then 
		bien = 1
		f_mensaje("Error al insertar albaranes",sqlca.sqlErrtext)
	END IF
else
	//updateamos la linea del albaran

	ll_linea_albaran_a_agrupar = 0

	select isnull(min(venlialb.linea),0)
	into   :ll_linea_albaran_a_agrupar
	from   venlilab
	where  venlialb.empresa             = :lialb.empresa
	and    venlialb.anyo                = :lialb.anyo
	and    venlialb.albaran             = :lialb.albaran	
	and    venlialb.anyo_pedido_origen  = :lialb.anyo_pedido_origen
	and    venlialb.pedido_origen       = :lialb.pedido_origen
	and    venlialb.linea_pedido_origen = :lialb.linea_pedido_origen
	and    venlialb.articulo            = :lialb.articulo
	and    venlialb.calidad             = :lialb.calidad
	and    venlialb.tonochar            = :lialb.tonochar
	and    venlialb.calibre             = :lialb.calibre
	and    venlialb.tipo_pallet         = :lialb.tipo_pallet
	and    venlialb.caja                = :lialb.caja;
	
	if ll_linea_albaran_a_agrupar = 0 then
		IF Not f_insertar_venlialb(lialb) Then 
			bien = 1
			f_mensaje("Error al insertar albaranes",sqlca.sqlErrtext)
		END IF		
	else
		//Retrasamos el contador de lineas
		veces = veces -1
		lialb.linea = ll_linea_albaran_a_agrupar
		
		ld_cantidad_albaran_existe = 0
		ll_cantidad_pzs_albaran_existe = 0
		
		select isnull(venlialb.cantidad,0),
				 isnull(venlialb.cantidad_pzs,0) 
		into   :ld_cantidad_albaran_existe, 
				 :ll_cantidad_pzs_albaran_existe 
		from   venlilab
		where  venlialb.empresa             = :lialb.empresa
		and    venlialb.anyo                = :lialb.anyo
		and    venlialb.albaran             = :lialb.albaran	
		and    venlialb.linea               = :lialb.linea;
						
		lialb.cantidad += ld_cantidad_albaran_existe
		lialb.cantidad_pzs += ll_cantidad_pzs_albaran_existe
		
		if trim(lialb.articulo) <> "" then
			cadena=f_calculo_unidades_tipolin(codigo_empresa,lialb.articulo,&
												 lialb.tipo_pallet,lialb.caja,&
												 0,&
												 0,&
												 lialb.cantidad, lialb.tipo_unidad)
										  
			posi_aux = 1
			posi = pos(cadena,"|",1)
			if posi <> 0 then
				lialb.pallets     = dec(Mid(cadena,1,posi - 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <> 0 then
				lialb.cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				lialb.total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			if ls_ventipolin_gestionar_en_piezas <> 'S' then
				posi = pos(cadena,"|",posi_aux)
				if posi <>0 then
					lialb.cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
			else
				lialb.cantidad   = f_conversion_piezas_cantidad(lialb.empresa,lialb.articulo,lialb.caja,lialb.cantidad_pzs)
			end if		
			
		else
			lialb.pallets       = 0
			lialb.cajas         = 0
			lialb.total_cajas   = 0
		end if
		
		//PESO
		if ls_ventipolin_gestionar_en_piezas <> 'S' then
			lialb.peso      = f_calculo_peso(codigo_empresa,lialb.articulo,lialb.tipo_pallet,lialb.cajas,lialb.total_cajas,lialb.pallets,lialb.cantidad,lialb.caja)
											
			lialb.peso_neto = f_calculo_peso_neto(codigo_empresa,lialb.articulo,lialb.cajas,lialb.total_cajas,lialb.cantidad,lialb.caja)		

		else
			lialb.peso      = f_calculo_peso_pzs(codigo_empresa,lialb.articulo,lialb.tipo_pallet,lialb.cajas,lialb.total_cajas,lialb.pallets,lialb.cantidad,lialb.caja)
											
			lialb.peso_neto = f_calculo_peso_neto_pzs(codigo_empresa,lialb.articulo,lialb.cajas,lialb.total_cajas,lialb.cantidad,lialb.caja)	
			
		end if		
		
		update venlialb
		set    venlialb.cantidad     = :lialb.cantidad,
				 venlialb.pallets      = :lialb.pallets,
				 venlialb.cajas        = :lialb.cajas,
				 venlialb.total_cajas  = :lialb.total_cajas,
				 venlialb.peso         = :lialb.peso,
				 venlialb.peso_neto    = :lialb.peso_neto,
				 venlialb.cantidad_pzs = :lialb.cantidad_pzs 
		where  venlialb.empresa             = :lialb.empresa
		and    venlialb.anyo                = :lialb.anyo
		and    venlialb.albaran             = :lialb.albaran	
		and    venlialb.linea               = :lialb.linea;
		
		if sqlca.sqlcode <> 0 then
			bien = 1
			f_mensaje("Error al updatear albaranes",sqlca.sqlErrtext)			
		end if
		
	end if
	
end if
//////////////////  RECÁLCULO DE LOS DESCUENTOS DESPUÉS DE MODIFICAR LA CANTIDAD //////////////////////
f_actualizar_linea_venalbaran(codigo_empresa,lialb.anyo,lialb.albaran,lialb.linea)

//Linea nueva con precio de portes
if bien = 0 and precio_portes<>0 then
	veces = veces + 1
	lialb.linea= veces + control_lineas
	lialb.tipolinea='5'
	lialb.descripcion= f_nombre_ventipolin(codigo_empresa,'5') + " Nº Alb. "+String(lialb.albaran,"###.###")
	lialb.tipo_unidad='0'
	lialb.articulo=''
	lialb.familia=''
	lialb.subfamilia=''
	lialb.formato=''
	lialb.subformato=''
	lialb.modelo=''
	lialb.calidad=''
	lialb.tonochar=''
	lialb.calibre=0
	lialb.precio=precio_portes
	setnull(lialb.precio_estand)
	lialb.cantidad=1
	setnull(lialb.pallets)
	setnull(lialb.total_cajas)
	setnull(lialb.cajas)
	setnull(lialb.dtocomer)
	setnull(lialb.dtoesp)
	setnull(lialb.dtoesp2)
	setnull(lialb.linfab)
	setnull(lialb.referencia)
	setnull(lialb.montajeartcal)
	lialb.situacion='C'
	setnull(lialb.metros_lineales)
	setnull(lialb.tipo_pallet)
	setnull(lialb.caja)
	lialb.importe=lialb.precio*lialb.cantidad
	setnull(lialb.descuento)
	setnull(lialb.importedto)
	//lialb.clase='V'
	lialb.sector='N'
	lialb.deposito='N'
	setnull(lialb.orden_preparacion)
	setnull(lialb.cantidad_prepa)
	lialb.es_pico='N'
	setnull(lialb.numero_pico)
	setnull(lialb.anyo_ent)
	setnull(lialb.nummov_ent)
	setnull(lialb.anyo_sal)
	setnull(lialb.nummov_sal)
	setnull(lialb.fila_ent)
	setnull(lialb.altura_ent)
	setnull(lialb.operario_prepa)
	lialb.control_incremento='S'
	lialb.peso_neto=0
	lialb.precio_aduana=precio_portes
	lialb.control_descuentos=f_descuento_ventipolin(codigo_empresa,'5')
	lialb.control_comisiones=f_comision_ventipolin(codigo_empresa,'5')
	lialb.importe_aduana=lialb.importe
	setnull(lialb.bruto)
	lialb.precio_neto=precio_portes
	lialb.precio_aduana_neto=precio_portes
	setnull(lialb.descuento_aduana)
	setnull(lialb.neto)
	setnull(lialb.impdtopp)
	setnull(lialb.almacen_ent)
	setnull(lialb.almacen_deposito)
	setnull(lialb.almacen_de_carga)
	lialb.cantidad    = 1
	lialb.cantidad_pedido = 1
	setnull(lialb.ubicacion)
	lialb.contenedor  = is_contenedor
	lialb.precinto		= precinto
	lialb.matricula	= matricula			
	precio_portes=0
	lialb.anyo_proddiaria = 0
	lialb.contador_proddiaria = 0

	IF Not f_insertar_venlialb(lialb) Then 
		bien = 1
		f_mensaje("Error al insertar albaranes (portes)",sqlca.sqlErrtext)
	END IF
	
end if

IF bien  = 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean f_control_existencias ();Dec bien,reg1,reg,var_anyo,var_linea,var_pedido,var_cantidad,var_cantidad2,var_linped, var_metros_caja
String var_referencia,var_tipo_pallet,var_situacion,var_articulo,var_caja, var_almacen, var_zona, var_tono, var_calidad, var_tipo_unidad
Int var_calibre, var_fila, var_altura
Long var_piezas_caja
bien = 0
reg1 = dw_pedido.RowCount()

For reg = 1 To reg1
	if f_control_almacen_ventipolin(codigo_empresa,dw_pedido.GetItemString(reg,"venliped_tipolinea"))="S" then
		IF dw_pedido.GetItemSTring(reg,"cmarcado")	= "X" AND dw_pedido.GetItemSTring(reg,"venliped_situacion") <> "F" Then
		
			var_anyo        = dw_pedido.GetItemNumber(reg,"venliped_anyo")
			var_pedido      = dw_pedido.GetItemNumber(reg,"venliped_pedido")
			var_linea       = dw_pedido.GetItemNumber(reg,"venliped_linea")
			var_almacen   = dw_pedido.GetItemSTring(reg,"almacen")
			var_zona   = dw_pedido.GetItemSTring(reg,"zona")
			var_fila   = dw_pedido.GetItemNumber(reg,"fila")
			var_altura   = dw_pedido.GetItemNumber(reg,"altura")
			var_calibre   = dw_pedido.GetItemNumber(reg,"venliped_calibre")
			var_tono  = dw_pedido.GetItemSTring(reg,"venliped_tonochar")
			var_calidad   = dw_pedido.GetItemSTring(reg,"venliped_calidad")
			var_tipo_unidad  = dw_pedido.GetItemSTring(reg,"venliped_tipo_unidad")
			var_piezas_caja = dw_pedido.GetItemNumber(reg,"almartcajas_piezascaja")
			var_metros_caja = dw_pedido.GetItemNumber(reg,"almartcajas_metroscaja")
		
			SELECT venliped.referencia,   
					 venliped.tipo_pallet, 
					 venliped.cantidad,venliped.situacion ,venliped.articulo,
					 venliped.caja
			  INTO :var_referencia,   
					 :var_tipo_pallet,:var_cantidad,   
					 :var_situacion,:var_articulo,:var_caja
			  FROM venliped  
			 WHERE venliped.empresa = :codigo_empresa 
				AND venliped.anyo    = :var_anyo 
				AND venliped.pedido  = :var_pedido 
				AND venliped.linea   = :var_linea;
			
			//ALAMACEN NUEVO 01/2014 
			IF IsNull(var_tipo_pallet) Then var_tipo_pallet = ""
			SELECT sum(cantidade - cantidads) INTO :var_cantidad2   FROM almacenmovimientos  
			WHERE  empresa     = :codigo_empresa 
			AND    almacen   = :var_almacen
			AND    zona  = :var_zona 
			AND    fila  = :var_fila
			AND    altura  = :var_altura
			AND    articulo= :var_articulo
			AND    calidad  = :var_calidad
			AND    tono  = :var_tono
			AND    calibre = :var_calibre
			AND    tipo_pallet = :var_tipo_pallet 
			AND    caja        = :var_caja;

			var_cantidad2 = dec(string(var_cantidad2,'###,###,###.##'))
			if var_tipo_unidad = "1"  and var_metros_caja <> 0  then
				var_cantidad2 = dec(string(round((var_cantidad2 / var_metros_caja) * var_piezas_caja,0),'###,###,###.##'))
			end if
			
			var_cantidad  = dec(string(var_cantidad ,'###,###,###.##'))

			iF var_cantidad2 < var_cantidad  or var_metros_caja = 0 Then
				f_mensaje("Control Stock Almacen","No hay suficiente Stock en la ubicación seleccionada o no está dado correctamente el encajado. Articulo: "+ f_nombre_articulo(codigo_empresa,var_articulo))
				Return false
			END IF
			//No se conempla la preparación del pedido
			/*
			IF var_situacion = "P" Then
					SELECT sum(existencias) INTO :var_cantidad2   FROM almlinubica  
					WHERE  almlinubica.empresa = :codigo_empresa 
					AND    almlinubica.anyo    = :var_anyo
					AND  	 almlinubica.pedido  = :var_pedido
					AND    almlinubica.linped  = :var_linea   ;
					var_cantidad2 = dec(string(var_cantidad2,'###,###,###.##'))
					var_cantidad  = dec(string(var_cantidad ,'###,###,###.##'))
					IF   var_cantidad2 <> var_cantidad  Then
						f_mensaje("Error","La cantidad Preparada no coincide"+ f_nombre_articulo(codigo_empresa,var_articulo))
						Return False
					END IF
			ELSE
					IF IsNull(var_tipo_pallet) Then var_tipo_pallet = ""
					SELECT sum(existencias) INTO :var_cantidad2   FROM almlinubica  
					WHERE  almlinubica.empresa     = :codigo_empresa 
					AND    almlinubica.ubicacion   = :var_ubicacion
					AND    almlinubica.referencia  = :var_referencia
					AND    almlinubica.tipo_pallet = :var_tipo_pallet 
					AND    almlinubica.caja        = :var_caja
					AND  	 almlinubica.pedido is null;
		
					var_cantidad2 = dec(string(var_cantidad2,'###,###,###.##'))
					var_cantidad  = dec(string(var_cantidad ,'###,###,###.##'))
	
					iF var_cantidad2 < var_cantidad  Then
						f_mensaje("Control Stock Almacen","No hay suficiente Stock a esta ubicacion: "+ &
						f_texto_ubicacion(var_ubicacion) + "   Articulo: "+ f_nombre_articulo(codigo_empresa,var_articulo))
						Return false
					END IF
			END IF
			*/
		END IF
	end if
Next
Return True
end function

public function boolean f_expedir_pedido (integer elemento);Dec{0} var_pedido,var_linea
Dec{0} var_anyo,nu,lineas_ordenes_carga
string cadena
Dec{6} var_cantidad_carga
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga, var_peso_bruto_linea, var_peso_neto_linea
Integer var_bien
Long   posi,posi_aux,var_cantidad_carga_pzs
string ls_ventipolin_gestionar_en_piezas

var_bien = 0
str_venliped linped
var_anyo              = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
var_pedido            = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
var_linea             = dw_pedido.GetItemNumber(elemento,"venliped_linea")
var_pallets_carga     = dw_pedido.GetItemNumber(elemento,"venliped_pallets")
var_cajas_carga       = dw_pedido.GetItemNumber(elemento,"venliped_cajas")
var_total_cajas_carga = dw_pedido.GetItemNumber(elemento,"venliped_total_cajas")
var_cantidad_carga    = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")
var_cantidad_carga_pzs = dw_pedido.GetItemNumber(elemento,"venliped_cantidad_pzs")
ls_ventipolin_gestionar_en_piezas = dw_pedido.GetItemString(elemento,"ventipolin_gestionar_en_piezas")

//linped.empresa   =   codigo_empresa
//linped.anyo      =   var_anyo
//linped.pedido    =   var_pedido
//linped.linea     =   var_linea
//
//  SELECT venliped.empresa, venliped.anyo,         venliped.pedido,venliped.linea,   
//         venliped.serie,   venliped.fpedido,      venliped.fentrega,  					venliped.fentrega_inicial, 
//         venliped.cliente, venliped.tipo_unidad,  venliped.articulo,   
//         venliped.familia, venliped.formato,      venliped.modelo,   
//         venliped.calidad, venliped.tonochar,     venliped.calibre,   
//         venliped.precio,  venliped.precio_estand,venliped.cantidad,   
//         venliped.pallets, venliped.total_cajas,  venliped.cajas,   
//         venliped.dtocomer,venliped.dtoesp,       venliped.descripcion,   
//         venliped.tipoiva, venliped.iva,          venliped.linfab,   
//         venliped.provincia,venliped.pais,        venliped.zona,   
//         venliped.tipolinea,venliped.texto1,      venliped.texto2,   
//         venliped.texto3,   venliped.texto4,      venliped.referencia,   
//         venliped.montajeartcal,     venliped.situacion, venliped.divisa,   
//         venliped.metros_lineales,  venliped.peso, venliped.falta,   
//         venliped.usuario,  venliped.tipo_pallet, venliped.caja,  
//			venliped.importe,  venliped.descuento,
//			venliped.importedto,    venliped.clase,   
//         venliped.sector, venliped.agente1,venliped.agente2,   
//         venliped.agente3,venliped.comision11,venliped.comision12,   
//         venliped.comision21,venliped.comision22,venliped.comision31,   
//         venliped.comision32, venliped.deposito, venliped.orden_preparacion,   
//         venliped.cantidad_prepa,venliped.es_pico,venliped.numero_pico,   
//         venliped.anyo_ent, venliped.nummov_ent,  venliped.anyo_sal,   
//         venliped.nummov_sal,venliped.fila_ent,venliped.altura_ent,   
//         venliped.operario_prepa,venliped.control_incremento,
//			venliped.peso_neto,venliped.precio_aduana,venliped.control_descuentos,   
//         venliped.control_comisiones,venliped.importe_aduana,
//			venliped.bruto, venliped.precio_neto,
//			venliped.precio_aduana_neto,venliped.descuento_aduana,   
//         venliped.neto,venliped.impdtopp,venliped.ref_cli,   
//         venliped.transportista,venliped.almacen_ent  
//    INTO :linped.empresa,:linped.anyo,:linped.pedido,:linped.linea,   
//         :linped.serie,  :linped.fpedido, :linped.fentrega, :linped.fentrega_inicial,
//			:linped.cliente,:linped.tipo_unidad,:linped.articulo,   
//         :linped.familia,:linped.formato,:linped.modelo,   
//         :linped.calidad,:linped.tonochar, :linped.calibre,   
//         :linped.precio, :linped.precio_estand,:linped.cantidad,   
//         :linped.pallets,:linped.total_cajas,:linped.cajas,   
//         :linped.dtocomer,:linped.dtoesp,:linped.descripcion,   
//         :linped.tipoiva,:linped.iva,:linped.linfab,:linped.provincia,   
//         :linped.pais, :linped.zona,:linped.tipolinea,:linped.texto1,   
//         :linped.texto2, :linped.texto3,:linped.texto4, :linped.referencia,   
//         :linped.montajeartcal,:linped.situacion,:linped.divisa,   
//         :linped.metros_lineales,:linped.peso, :linped.falta,   
//         :linped.usuario,:linped.tipo_pallet,:linped.caja,
//			:linped.importe,:linped.descuento,
//			:linped.importedto,:linped.clase,   
//         :linped.sector,:linped.agente1,:linped.agente2,:linped.agente3,   
//         :linped.comision11,:linped.comision12,:linped.comision21,   
//         :linped.comision22,:linped.comision31,:linped.comision32,   
//         :linped.deposito,:linped.orden_preparacion,
//			:linped.cantidad_prepa,:linped.es_pico,:linped.numero_pico,   
//         :linped.anyo_ent,:linped.nummov_ent,:linped.anyo_sal,   
//         :linped.nummov_sal,:linped.fila_ent,:linped.altura_ent,   
//         :linped.operario_prepa,:linped.control_incremento,   
//         :linped.peso_neto,:linped.precio_aduana,   
//         :linped.control_descuentos,:linped.control_comisiones,   
//         :linped.importe_aduana,:linped.bruto,:linped.precio_neto,   
//         :linped.precio_aduana_neto,:linped.descuento_aduana,   
//         :linped.neto,:linped.impdtopp,:linped.ref_cli,   
//         :linped.transportista,:linped.almacen_ent  
//    FROM venliped  
//   WHERE ( venliped.empresa = :codigo_empresa ) AND  
//         ( venliped.anyo    = :var_anyo) AND  
//         ( venliped.pedido  = :var_pedido ) AND  
//         ( venliped.linea   = :var_linea )   ;
//			IF SQLCA.SQLCODE = 100 Then var_bien = 1

if not(f_cargar_str_venliped(codigo_empresa,var_anyo,var_pedido,var_linea,linped)) then
	var_bien = 1
end if
			
IF IsNull(var_cantidad_carga) Then var_cantidad_carga = 0
linped.cantidad = linped.cantidad - var_cantidad_carga

IF IsNull(var_cantidad_carga_pzs) Then var_cantidad_carga_pzs = 0
linped.cantidad_pzs = linped.cantidad_pzs - var_cantidad_carga_pzs

if isnull(linped.articulo) then linped.articulo = ""

if trim(linped.articulo) <> "" then
	
	cadena=f_calculo_unidades_tipolin(codigo_empresa,linped.articulo,&
										 linped.tipo_pallet,linped.caja,&
										 0,&
										 0,&
										 linped.cantidad, linped.tipo_unidad)
								  
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		linped.pallets     = dec(Mid(cadena,1,posi - 1))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		linped.cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		linped.total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
	
	if ls_ventipolin_gestionar_en_piezas <> 'S' then
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			linped.cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
			posi_aux = posi + 1
		end if
	else
		linped.cantidad   = f_conversion_piezas_cantidad(linped.empresa,linped.articulo,linped.caja,linped.cantidad_pzs)
	end if
else
	linped.pallets       = 0
	linped.cajas         = 0
	linped.total_cajas   = 0
end if

linped.cantidad_facturar = linped.cantidad

//PESO
if ls_ventipolin_gestionar_en_piezas <> 'S' then
	var_peso_bruto_linea = f_calculo_peso(codigo_empresa,linped.articulo, linped.tipo_pallet, +&
									linped.cajas,linped.total_cajas,linped.pallets,linped.cantidad,linped.caja)
									
	var_peso_neto_linea = f_calculo_peso_neto(codigo_empresa,linped.articulo, +&
									linped.cajas,linped.total_cajas,linped.cantidad,linped.caja)
else
	var_peso_bruto_linea = f_calculo_peso_pzs(codigo_empresa,linped.articulo, linped.tipo_pallet, +&
									linped.cajas,linped.total_cajas,linped.pallets,linped.cantidad_pzs,linped.caja)
									
	var_peso_neto_linea = f_calculo_peso_neto_pzs(codigo_empresa,linped.articulo, +&
									linped.cajas,linped.total_cajas,linped.cantidad_pzs,linped.caja)	
end if

IF linped.tipo_unidad = "1" Then
	if f_facturar_metros_reales_venped(codigo_empresa,linped.anyo,linped.pedido) = "S" then
		linped.cantidad_facturar = f_cantidad_facturar_articulo(codigo_empresa,linped.articulo,linped.caja,linped.cantidad)
	end if
	
end if
// David
IF (linped.cantidad > 0 or linped.cantidad_pzs > 0) and 0 = 1 then
//IF linped.cantidad <> 0 then
// Fin David
	UPDATE venliped
	Set venliped.pallets           = :linped.pallets,
		venliped.total_cajas       = :linped.total_cajas,
		venliped.cajas             = :linped.cajas,
		venliped.cantidad          = :linped.cantidad,
		venliped.cantidad_facturar = :linped.cantidad_facturar,
		venliped.peso = :var_peso_bruto_linea,
		venliped.peso_neto = :var_peso_neto_linea,
		venliped.cantidad_pzs = :linped.cantidad_pzs 
	WHERE venliped.empresa = :codigo_empresa
	AND   venliped.anyo    = :var_anyo
	AND   venliped.pedido  = :var_pedido
	AND   venliped.linea   = :var_linea;

	IF SQLCA.SQLCODE <> 0  Then 
		var_bien = 1
		f_mensaje("Error en datos(3)",sqlca.sqlerrtext)
	END IF

	IF Not f_actualizar_linea_venpedido(codigo_empresa,var_anyo,var_pedido,var_linea) Then
		var_bien = 1
		f_mensaje("Error al actualizar linea de pedido",sqlca.sqlErrtext)
	END IF
	
	messagebox("¡Error!","No se puede expedir una linea de orden de carga parcialmente.")
	var_bien = 1
ELSE
		Delete from venliped
	   WHERE (venliped.empresa = :codigo_empresa )
		AND   (venliped.anyo    = :var_anyo )
		AND   (venliped.pedido  = :var_pedido )
		AND   (venliped.linea   = :var_linea);
		IF SQLCA.SQLCODE <> 0  Then 	
			var_bien = 1
			f_mensaje("Error al borrar la linea de pedido",sqlca.sqlErrtext)
		END IF
		
END IF

Select Count(*) 
Into :nu 
from venliped
WHERE venliped.empresa = :codigo_empresa 
AND   venliped.anyo    = :var_anyo 
AND   venliped.pedido  = :var_pedido;

iF Isnull(nu) Then nu = 0

IF nu = 0 Then
	Delete from venped
	WHERE venped.empresa = :codigo_empresa 
	AND   venped.anyo    = :var_anyo 
	AND   venped.pedido  = :var_pedido;
	
	IF SQLCA.SQLCODE <> 0  Then 	
		var_bien = 1
		f_mensaje("Error el borrar pedido",sqlca.sqlErrtext)
	END IF
ELSE
	UPDATE venped
	SET    venped.recalcular_packs = 'N'
	WHERE  venped.empresa = :codigo_empresa 
	AND    venped.anyo    = :var_anyo 
	AND    venped.pedido  = :var_pedido;	
	
	IF Not f_actualizar_venpedido(codigo_empresa,var_anyo,var_pedido) Then 
		var_bien = 1
		f_mensaje("Error al actualizar pedido",sqlca.sqlErrtext)
	END IF
END IF



IF var_bien = 0 Then
	RETURN TRUE
ELSE
	RETURN FALSE
END IF



end function

public function boolean f_grabar_salida_ventas (integer elemento);string var_tipolinea,var_tipo_pallet,var_situacion,var_deposito,var_cliente,var_almacen_deposito,var_caja,var_tipounidad,var_orden_carga
string var_articulo,var_calidad,var_tono,var_formato
long   var_pedido,var_linea
int    var_anyo,var_total_cajas,var_piezascaja,var_calibre
dec    var_metroscaja,var_cantidad_carga
long ll_indice,ll_total
string ls_sel
boolean lb_correcto = true
datastore ds_datos

str_movimiento_almacen lstr_movimiento_almacen

var_tipolinea = dw_pedido.GetItemSTring(elemento,"venliped_tipolinea")
if f_control_almacen_ventipolin(codigo_empresa,var_tipolinea) = "S" then
	var_tipo_pallet     = dw_pedido.GetItemSTring(elemento,"venliped_tipo_pallet")
	var_anyo            = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
	var_pedido          = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
	var_linea           = dw_pedido.GetItemNumber(elemento,"venliped_linea")
	var_situacion       = dw_pedido.GetItemString(elemento,"venliped_situacion")
	var_deposito        = dw_pedido.GetItemString(elemento,"venliped_deposito")
	var_cliente         = dw_pedido.GetItemString(elemento,"venliped_cliente")
	var_almacen_deposito= dw_pedido.GetItemString(elemento,"venliped_almacen_deposito")
	var_tipo_pallet     = dw_pedido.GetItemString(elemento,"venliped_tipo_pallet")
	var_caja            = dw_pedido.GetItemString(elemento,"venliped_caja")
	var_tipounidad      = dw_pedido.GetItemString(elemento,"venliped_tipo_unidad")
	var_total_cajas     = dw_pedido.GetItemNumber(elemento,"venliped_total_cajas")
	var_metroscaja      = dw_pedido.GetItemNumber(elemento,"almartcajas_metroscaja")
	var_piezascaja      = dw_pedido.GetItemNumber(elemento,"almartcajas_piezascaja")
	
	var_orden_carga = " "

	var_cantidad_carga    = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")
	var_articulo          = dw_pedido.GetItemSTring(elemento,"venliped_articulo")
	var_calidad           = dw_pedido.GetItemString(elemento,"venliped_calidad")
	var_tono              = dw_pedido.GetItemString(elemento,"venliped_tonochar")
	var_calibre           = dw_pedido.GetItemNumber(elemento,"venliped_calibre")
	var_formato =  dw_pedido.GetItemSTring(elemento,"venliped_formato")
	
	// cuando el articulo no es del sector
	/*ESTO PETA PARA LAS CAJAS MARCOS 28-01-2021 */
	//if trim(var_calidad) = "0"  or isnull(var_calidad) then var_calidad = ""
	if isnull(var_calidad) then var_calidad = ""
	/*************************/
	
	IF IsNull(var_tono)    Then var_tono    = "" 
	IF IsNull(var_calibre) Then var_calibre = 0 

	if var_linea = 4 then
		var_linea = var_linea
	end if

	ls_sel = "select almubimapa_codbar.almacen, "+&
				"       almubimapa_codbar.zona, "+&
				"       almubimapa_codbar.fila, "+&
				"       almubimapa_codbar.altura, "+&
				"       alm_bultos.id, "+&
				"       sum(venliped_reservas.cantidad) as cantidad "+&
				"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
				"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
				"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
				"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
				"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
				"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
				"and    venliped_reservas.anyo    = "+string(var_anyo,"###0")+" "+&
				"and    venliped_reservas.pedido  = "+string(var_pedido,"######0")+" "+&
				"and    venliped_reservas.linea   = "+string(var_linea,"###0")+" "+&
				"group by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id "+&
				"order by almubimapa_codbar.almacen, "+&
				"         almubimapa_codbar.zona, "+&
				"         almubimapa_codbar.fila, "+&
				"         almubimapa_codbar.altura, "+&
				"         alm_bultos.id "
	
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	if ll_total = 0 then
		messagebox("Error","No se encuentran las reservas de la linea del pedido "+string(var_anyo,"###0")+"/"+string(var_pedido,"######0")+"/"+string(var_linea,"###0"))
		lb_correcto = false
	else
		for ll_indice = 1 to ll_total
			
			lstr_movimiento_almacen.empresa            = codigo_empresa
			lstr_movimiento_almacen.articulo           = var_articulo
			lstr_movimiento_almacen.calidad            = var_calidad
			lstr_movimiento_almacen.tono               = var_tono
			lstr_movimiento_almacen.calibre            = var_calibre
			lstr_movimiento_almacen.tipo_pallet        = var_tipo_pallet
			lstr_movimiento_almacen.caja               = var_caja
			lstr_movimiento_almacen.cantidad           = (ds_datos.object.cantidad[ll_indice] * -1)
			lstr_movimiento_almacen.orden_carga_anyo   = 0
			lstr_movimiento_almacen.orden_carga_codigo = ""
			lstr_movimiento_almacen.orden_carga_linea  = 0
			if var_cliente = '1663' then
				//Promocion interna hace un traspaso de ubicacion
				lstr_movimiento_almacen.tipo_movimiento    = '102'
			else
				lstr_movimiento_almacen.tipo_movimiento    = '206'
			end if			
			lstr_movimiento_almacen.observaciones      = ""
			lstr_movimiento_almacen.almacen            = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
			lstr_movimiento_almacen.zona               = ds_datos.object.almubimapa_codbar_zona[ll_indice]
			lstr_movimiento_almacen.fila               = ds_datos.object.almubimapa_codbar_fila[ll_indice]
			lstr_movimiento_almacen.altura             = ds_datos.object.almubimapa_codbar_altura[ll_indice]
			lstr_movimiento_almacen.tercero            = ""
			lstr_movimiento_almacen.documento          = ""
			lstr_movimiento_almacen.fecha              = datetime(date(em_fecha.text))
			lstr_movimiento_almacen.id_ubicacion       = 0
			lstr_movimiento_almacen.id_alm_bultos		 = ds_datos.object.alm_bultos_id[ll_indice]
			
			lstr_movimiento_almacen.venliped_anyo      = var_anyo
			lstr_movimiento_almacen.venliped_pedido    = var_pedido
			lstr_movimiento_almacen.venliped_linea	    = var_linea
			
			if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
				lb_correcto = false
			else
				if var_cliente = '1663' then
					//Promocion interna hace un traspaso de ubicacion
					lstr_movimiento_almacen.empresa            = codigo_empresa
					lstr_movimiento_almacen.articulo           = var_articulo
					lstr_movimiento_almacen.calidad            = var_calidad
					lstr_movimiento_almacen.tono               = var_tono
					lstr_movimiento_almacen.calibre            = var_calibre
					lstr_movimiento_almacen.tipo_pallet        = var_tipo_pallet
					lstr_movimiento_almacen.caja               = var_caja
					lstr_movimiento_almacen.cantidad           = ds_datos.object.cantidad[ll_indice]
					lstr_movimiento_almacen.orden_carga_anyo   = 0
					lstr_movimiento_almacen.orden_carga_codigo = ''
					lstr_movimiento_almacen.orden_carga_linea  = 0
		
					lstr_movimiento_almacen.tipo_movimiento    = '103'
		
					lstr_movimiento_almacen.observaciones      = ""
					lstr_movimiento_almacen.almacen            = "6"
					lstr_movimiento_almacen.zona               = "ZZ"
					lstr_movimiento_almacen.fila               = 1
					lstr_movimiento_almacen.altura             = 1
					lstr_movimiento_almacen.tercero            = ""
					lstr_movimiento_almacen.documento          = ""
					lstr_movimiento_almacen.fecha              = datetime(date(em_fecha.text))
					
					select isnull(almubimapa_codbar.id,0),
							 isnull(almubimapa_codbar.id_alm_bultos,0) 
					into  :lstr_movimiento_almacen.id_ubicacion,
							:lstr_movimiento_almacen.id_alm_bultos 
					from  almubimapa_codbar 
					where almubimapa_codbar.empresa = :lstr_movimiento_almacen.empresa 
					and   almubimapa_codbar.almacen = :lstr_movimiento_almacen.almacen 
					and   almubimapa_codbar.zona    = :lstr_movimiento_almacen.zona 
					and	almubimapa_codbar.fila    = :lstr_movimiento_almacen.fila 
					and	almubimapa_codbar.altura  = :lstr_movimiento_almacen.altura;			
								
					lstr_movimiento_almacen.venliped_anyo      = 0
					lstr_movimiento_almacen.venliped_pedido    = 0
					lstr_movimiento_almacen.venliped_linea	    = 0
								
					if not(f_movimiento_almacen(lstr_movimiento_almacen)) then
						lb_correcto = false
					else
						//return true
					end if
				end if						
			end if			
		
		next
	end if
	
	destroy ds_datos
end if

Return lb_correcto
end function

public subroutine f_todo ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
Integer Contes
string ls_articulo

IF dw_detalle.RowCount() = 0 Then Return
FOR t = 1 To dw_detalle.RowCount()
	ls_articulo = dw_detalle.GetItemString(t,"venliped_articulo")
	if isnull(ls_articulo) then ls_articulo = ""
	IF dw_detalle.GetItemString(t,"venliped_situacion") = "F" and ls_articulo <> "" Then
		//Contes = MessageBox("Antención","Linea a Fabricar "+dw_detalle.GetItemString(t,"venliped_descripcion") , Exclamation!, YesNo!)
//		contes = 1
//		IF Contes = 1 then
//			f_marcar_linea(t)	
//		END IF
	ELSE
		f_marcar_linea(t)	
	END IF
NEXT

end subroutine

public subroutine f_marcar_linea (integer t);Dec{4}  num,d,var_cantidad,var_pallets,var_cajas
dec{4}  var_cantidadp,var_palletsp,var_cajasp
dec{4}  var_total_cajas,var_total_cajasp,var_cantidad_facturar
Dec{0}  var_pedido,var_linea,var_anyo,var_cantidad_pzs,var_cantidad_pzsp
Dec     var_hornos,var_calibre, var_peso_bruto_linea, var_peso_neto_linea
String  var_articulo,var_nombre,var_familia,var_formato,var_modelo,var_calidad,var_tono,var_sector,var_tipo_unidad,var_marcado
String  var_caja,var_tipo_pallet

dw_detalle.AcceptText()
//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo              = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido            = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea             = dw_detalle.GetItemNumber(t,"venliped_linea")
		var_cantidad          = dw_detalle.GetItemNumber(t,"venliped_cantidad")
		var_cantidad_pzs      = dw_detalle.GetItemNumber(t,"cantidad_pzs")
		
		var_pallets           = dw_detalle.GetItemNumber(t,"venliped_pallets")
		var_cajas             = dw_detalle.GetItemNumber(t,"venliped_cajas")		
		var_total_cajas       = dw_detalle.GetItemNumber(t,"venliped_total_cajas")		
		var_cantidad_facturar = dw_detalle.GetItemNumber(t,"venliped_cantidad_facturar")
		
		var_peso_bruto_linea = dw_detalle.GetItemNumber(t,"peso_bruto")
		var_peso_neto_linea = dw_detalle.GetItemNumber(t,"peso_neto")
		
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num = 0 Then
			Select cantidad,pallets,cajas,total_cajas,cantidad_pzs
			Into   :var_cantidadp,:var_palletsp,:var_cajasp,:var_total_cajasp,:var_cantidad_pzsp 
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			// David 
//			IF var_cantidadp < var_cantidad Then
//				f_mensaje("Error en introduccion de datos","La cantidad no puede superar al pedido")
//				dw_detalle.SetItem(t,"venliped_cantidad",var_cantidadp)
//				dw_detalle.SetItem(t,"venliped_pallets",var_palletsp)
//				dw_detalle.SetItem(t,"venliped_cajas",var_cajasp)
//				dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajasp)
//				return
//			END IF
			// Fin David
			if f_control_ubicaciones(var_anyo,var_pedido,var_linea) then
				dw_detalle.SetItem(t,"aux","V")
			else
				dw_detalle.SetItem(t,"aux","R")
			end if
			
			dw_detalle.SetColumn("marcado")
			dw_detalle.SetItem(t,"marcado","X")
			
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"pedido",var_pedido)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"linea",var_linea)
			//dw_temporal.SetItem(d,"cantidad",var_cantidad)
			dw_temporal.object.cantidad[d] = var_cantidad
			dw_temporal.object.cantidad_pzs[d] = var_cantidad_pzs
			dw_temporal.SetItem(d,"pallets",var_pallets)
			dw_temporal.SetItem(d,"cajas",var_cajas)
			dw_temporal.SetItem(d,"total_cajas",var_total_cajas)
			//dw_temporal.SetItem(d,"cantidad_facturar",var_cantidad_facturar)
			dw_temporal.object.cantidad_facturar[d] = var_cantidad_facturar
			dw_temporal.SetItem(d,"peso_bruto",var_peso_bruto_linea)
			dw_temporal.SetItem(d,"peso_neto",var_peso_neto_linea)
		END IF
//END IF

/*
//NO USADO EN NUEVO ALMACEN 01/2014
// Santiago.14/12/00. Movimiento automático de hornos

	var_hornos  = dw_detalle.GetItemNumber(t,"hornos")
	var_marcado = dw_detalle.GetItemString(t,"marcado")
	if var_hornos <> 0 and var_marcado = "X" then
		var_articulo    = dw_detalle.GetItemString(t,"venliped_articulo")
		var_nombre      = dw_detalle.GetItemString(t,"venliped_descripcion")
		var_calidad     = dw_detalle.GetItemString(t,"venliped_calidad")
		var_tono        = dw_detalle.GetItemString(t,"venliped_tonochar")
		var_calibre     = dw_detalle.GetItemNumber(t,"venliped_calibre")
		var_caja        = dw_detalle.GetItemString(t,"venliped_caja")
		var_tipo_unidad = dw_detalle.GetItemString(t,"venliped_tipo_unidad")
		var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		messagebox("Atención","Movimiento de HORNOS "+var_nombre)
		select familia,formato,modelo,sector
		into   :var_familia,:var_formato,:var_modelo,:var_sector
		from   articulos
		where  empresa = :codigo_empresa and
				 codigo  = :var_articulo;
		if not f_entrada_regularizacion(var_hornos,var_articulo,var_calidad,var_tono,var_calibre,var_caja,&
		       var_tipo_unidad,var_tipo_pallet,var_familia,var_formato,var_modelo,var_sector) then 
			 f_mensaje("Error","No se ha realizado el movimiento automático en almacén")
			 return
		end if
	end if
// Santiago.14/12/00. Movimiento automático de hornos
*/

end subroutine

public subroutine f_control_marcar_linea (integer t);Dec num,d
Dec{0}  var_pedido,var_linea,var_anyo
String articulo, oc_finalizada, unidad
Dec metroscaja
Int piezascaja
dw_detalle.AcceptText()
IF dw_detalle.GetItemString(t,"venliped_situacion") = "F" and dw_detalle.GetItemString(t,"venliped_articulo") <> "" Then
	messagebox("Atención","Linea a Fabricar "+dw_detalle.GetItemString(t,"venliped_descripcion"))
else
	//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
	IF dw_detalle.GetItemString(t,"marcado")= "" Then
	
		var_anyo        = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido      = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea       = dw_detalle.GetItemNumber(t,"venliped_linea")
		articulo = dw_detalle.GetItemString(t,"venliped_articulo")
			
		oc_finalizada = ""
		SELECT orden_carga.finalizada INTO :oc_finalizada FROM orden_carga INNER JOIN orden_carga_linea ON orden_carga.empresa = orden_carga_linea.empresa AND orden_carga.anyo = orden_carga_linea.anyo AND orden_carga.codigo = orden_carga_linea.codigo 
		WHERE orden_carga_linea.empresa = :codigo_empresa AND orden_carga_linea.venliped_anyo = :var_anyo AND orden_carga_linea.venliped_pedido = :var_pedido AND orden_carga_linea.venliped_linea = :var_linea;
		
		SELECT articulos.unidad, almarcajas.metroscaja, almarcajas.piezascaja INTO :unidad, :metroscaja, :piezascaja
		FROM articulos 
		INNER JOIN almarcajas ON almartcajas.empresa = articulos.empresa AND almartcajas.articulo = articulos.codigo  AND almartcajas.pordefecto = 'S' 
		WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :articulo;
		if isnull(piezascaja) then piezascaja = 0
		if isnull(metroscaja) then metroscaja = 0
		
		if oc_finalizada = "N" then
			MessageBox("Error", "No puede expedir el artículo "+articulo+" que esté en una orden de carga sin finalizar. Contacte con almacén.")
		else
			if unidad = "1" AND piezascaja = 0 and metroscaja = 0 then
				MessageBox("Error", "Debe indicar los metros caja y las piezas caja del artículo "+articulo)
			else
				f_marcar_linea(t)
			end if
		end if
		
	ELSE
		f_desmarcar_linea(t)
	END IF
	//END IF
	
END IF


end subroutine

public subroutine f_desmarcar_linea (integer t);Dec num,d,var_cantidad,var_pallets,var_cajas,var_total_cajas,var_cantidad_facturar
Dec{0}  var_pedido,var_linea,var_anyo
Dec     var_hornos,var_calibre
String  var_articulo,var_nombre,var_familia,var_formato,var_modelo,var_calidad,var_tono,var_sector,var_tipo_unidad,var_marcado
String  var_caja,var_tipo_pallet

// Santiago.14/12/00. Movimiento automático de hornos
	var_hornos  = dw_detalle.GetItemNumber(t,"hornos")
	var_marcado = dw_detalle.GetItemString(t,"marcado")
	if var_hornos <> 0 and var_marcado = "X" then
		var_articulo    = dw_detalle.GetItemString(t,"venliped_articulo")
		var_nombre      = dw_detalle.GetItemString(t,"venliped_descripcion")
		var_calidad     = dw_detalle.GetItemString(t,"venliped_calidad")
		var_tono        = dw_detalle.GetItemString(t,"venliped_tonochar")
		var_calibre     = dw_detalle.GetItemNumber(t,"venliped_calibre")
		var_caja        = dw_detalle.GetItemString(t,"venliped_caja")
		var_tipo_unidad = dw_detalle.GetItemString(t,"venliped_tipo_unidad")
		var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		messagebox("Atención","Movimiento de HORNOS "+var_nombre)
		select familia,formato,modelo,sector
		into   :var_familia,:var_formato,:var_modelo,:var_sector
		from   articulos
		where  empresa = :codigo_empresa and
				 codigo  = :var_articulo;
		if not f_salida_regularizacion(var_hornos,var_articulo,var_calidad,var_tono,var_calibre,var_caja,var_tipo_unidad,var_tipo_pallet,var_familia,var_formato,var_modelo,var_sector) then 
			 f_mensaje("Error","No se ha realizado el movimiento automático en almacén")
			 return
		end if
		dw_detalle.SetItem(t,"hornos",0)
	end if
// Santiago.14/12/00. Movimiento automático de hornos

//IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo   = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea  = dw_detalle.GetItemNumber(t,"venliped_linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num <>0 Then
			Select cantidad,
			       pallets,
					 cajas,
					 total_cajas,
					 cantidad_facturar
			Into   :var_cantidad,
			       :var_pallets,
					 :var_cajas,
					 :var_total_cajas,
					 :var_cantidad_facturar
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			dw_temporal.DeleteRow(num)
			dw_detalle.SetItem(t,"marcado","")
			dw_detalle.SetItem(t,"aux","")
			dw_detalle.SetItem(t,"venliped_cantidad",var_cantidad)
			dw_detalle.SetItem(t,"venliped_pallets",var_pallets)
			dw_detalle.SetItem(t,"venliped_cajas",var_cajas)
			dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajas)
			dw_detalle.SetItem(t,"venliped_cantidad_facturar",var_cantidad_facturar)
		END IF
//END IF





end subroutine

public function boolean f_entrada_regularizacion (integer diferencia, string var_articulo, string var_calidad, string var_tono, integer var_calibre, string var_caja, string var_tipo_unidad, string var_tipo_pallet, string var_familia, string var_formato, string var_modelo, string var_sector);//NO USADO EN ALMACEN NUEVO 01/2014
return false
/*
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis

Integer contador,grabado,salir,x1,control_bien
Dec{0} cur_pedido,cur_linea
Dec cur_existencias
String  cur_empresa,cur_tipo_pallet,cur_ubicacion


control_bien     = 0
movhis.empresa   =  codigo_empresa   
movhis.almacen   =  "1"
movhis.anyo      =  Year(Today())
f_mensaje_proceso("Buscando Nº Mov.",8,10)
movhis.nummov    =  f_almparam_nummov(codigo_empresa,movhis.anyo)
f_mensaje_proceso("Nº Mov. Ok",8,10)
movhis.origen    =  "2"   
movhis.articulo  = var_articulo
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "103"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = diferencia     
Else
	movhis.cantidade = 0      
End if
movhis.cantidads  = 0
movhis.precio     = 0
SetNull(movhis.codtercero)
SetNull(movhis.numdoc)
movhis.situacion  = "N"   
movhis.observaciones = "Expedición Directa (Hornos)"
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo
movhis.calidad  = var_calidad
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""
movhis.tonochar    = var_tono
movhis.calibre     = var_calibre
movhis.caja			 = var_caja
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet
movhis.sector      = var_sector   
f_mensaje_proceso("Insertando Mov.",8,10)
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
f_mensaje_proceso("Insertado Mov.",8,10)
f_mensaje_proceso("Actualiza Mov.",8,10)
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
f_mensaje_proceso("Mov. Act",8,10)

SELECT empresa,ubicacion,linea,existencias
INTO   :linubica.empresa, :linubica.ubicacion, :linubica.linea, :cur_existencias
FROM   almlinubica
WHERE  almlinubica.empresa     = :codigo_empresa
AND    almlinubica.referencia  = :movhis.referencia
AND    almlinubica.tipo_pallet = :movhis.tipo_pallet
AND    almlinubica.zona    = "P"
AND    almlinubica.altura  = 1
AND	 almlinubica.fila    = 1
AND    almlinubica.pedido  is null 
AND    almlinubica.observaciones like "Expedición Directa (Hornos)";

if isnull(linubica.ubicacion) or linubica.ubicacion = "" then
	linubica.empresa  = codigo_empresa  
	linubica.almacen  = "1"
	linubica.zona     = "P"
	linubica.fila     = 1
	linubica.altura   = 1
	IF IsNUll(linubica.altura) Then linubica.altura= 0
	linubica.articulo  = var_articulo
	linubica.familia   = var_familia 
	linubica.formato   = var_formato
	linubica.modelo    = var_modelo
	linubica.calidad   = var_calidad
	if isnull(linubica.calidad) or trim(linubica.calidad)="0" then linubica.calidad = ""
	linubica.tonochar    = var_tono
	linubica.calibre     = var_calibre
	linubica.caja		   = var_caja
	SetNull(linubica.anyo) 
	SetNull(linubica.pedido)
	SetNull(linubica.linped)
	SetNull(linubica.cliente)   
	linubica.ubicacion   = f_componer_ubicacion (linubica.almacen,linubica.zona,linubica.fila,linubica.altura)  
	linubica.tipo_unidad = var_tipo_unidad   
	linubica.referencia  = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
	linubica.f_alta= Datetime(Today(),Now())   
	IF var_tipo_unidad = "0" Then
		linubica.existencias  = diferencia
	Else
		linubica.existencias  = 0
	End If				
	linubica.tipo_pallet   = var_tipo_pallet
	linubica.sector        = var_sector
	linubica.observaciones = "Expedición Directa (Hornos)"
	
	cur_linea=0
	f_mensaje_proceso("Seleccion Ubica",8,10)
	
	SELECT almlinubica.empresa,almlinubica.ubicacion, max(almlinubica.linea)  
	INTO   :cur_empresa,:cur_ubicacion,:cur_linea  
	FROM   almlinubica  
	WHERE  (almlinubica.empresa   = :linubica.empresa ) AND  
			 (almlinubica.ubicacion = :linubica.ubicacion )   
	GROUP BY almlinubica.empresa,   
			  almlinubica.ubicacion  
	ORDER BY almlinubica.empresa ASC,   
			  almlinubica.ubicacion ASC  USING SQLCA;
			  
	f_mensaje_proceso("Fin Selec. Ubica",8,10)
	IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
	 cur_linea = 0 
	END IF
	
	cur_linea=cur_linea+1
	linubica.linea=cur_linea
	IF NOT f_insert_almlinubica(linubica) Then  control_bien=1
else
	cur_existencias = cur_existencias + diferencia
	UPDATE almlinubica  
	SET    existencias    = :cur_existencias
	WHERE almlinubica.empresa    =  :linubica.empresa
	AND   almlinubica.ubicacion  =  :linubica.ubicacion
	AND   almlinubica.linea      =  :linubica.linea;
	IF Sqlca.SqlCode <> 0 Then control_bien = 1
end if

//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden (movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = "P"
linubicahis.fila        = 1
linubicahis.altura      = 1
linubicahis.ubicacion   = linubica.ubicacion
linubicahis.cantidads   = movhis.cantidads
linubicahis.cantidade   = movhis.cantidade
linubicahis.articulo    = movhis.articulo
linubicahis.familia     = movhis.familia
linubicahis.formato     = movhis.formato
linubicahis.modelo      = movhis.modelo
linubicahis.calidad     = movhis.calidad
linubicahis.tonochar    = movhis.tonochar
linubicahis.calibre     = movhis.calibre
linubicahis.caja			= movhis.caja
linubicahis.fecha       = DateTime(Today())
linubicahis.tipomov     = "103"
linubicahis.tipo_unidad = movhis.tipo_unidad
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
linubicahis.observaciones = "Expedición Directa (Hornos)"
linubicahis.tipo_pallet = var_tipo_pallet
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

//var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF
*/
end function

public function boolean f_salida_regularizacion (integer diferencia, string var_articulo, string var_calidad, string var_tono, integer var_calibre, string var_caja, string var_tipo_unidad, string var_tipo_pallet, string var_familia, string var_formato, string var_modelo, string var_sector);//NO USADO EN ALMACEN NUEVO 01/2014
return false
/*
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis

Integer contador,grabado,salir,x1,control_bien
Dec{0} cur_pedido,cur_linea
Dec{2} cur_existencias
String  cur_empresa,cur_tipo_pallet,cur_ubicacion


control_bien     = 0
movhis.empresa   =  codigo_empresa   
movhis.almacen   =  "1"
movhis.anyo      =  Year(Today())
f_mensaje_proceso("Buscando Nº Mov.",8,10)
movhis.nummov    =  f_almparam_nummov(codigo_empresa,movhis.anyo)
f_mensaje_proceso("Nº Mov. Ok",8,10)
movhis.origen    =  "2"   
movhis.articulo  = var_articulo
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "102"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = 0     
Else
	movhis.cantidade = 0      
End if
movhis.cantidads  = diferencia
movhis.precio     = 0
SetNull(movhis.codtercero)
SetNull(movhis.numdoc)
movhis.situacion  = "N"   
movhis.observaciones = "Expedición Directa (Hornos)"
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo
movhis.calidad  = var_calidad
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""
movhis.tonochar    = var_tono
movhis.calibre     = var_calibre
movhis.caja			 = var_caja
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet
movhis.sector      = var_sector   
f_mensaje_proceso("Insertando Mov.",8,10)
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
f_mensaje_proceso("Insertado Mov.",8,10)
f_mensaje_proceso("Actualiza Mov.",8,10)
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
f_mensaje_proceso("Mov. Act",8,10)

SELECT empresa,ubicacion,linea,existencias
INTO   :linubica.empresa, :linubica.ubicacion, :linubica.linea, :cur_existencias
FROM   almlinubica
WHERE  almlinubica.empresa     = :codigo_empresa
AND    almlinubica.referencia  = :movhis.referencia
AND    almlinubica.tipo_pallet = :movhis.tipo_pallet
AND    almlinubica.zona    = "P"
AND    almlinubica.altura  = 1
AND	 almlinubica.fila    = 1
AND    almlinubica.pedido  is null 
AND    almlinubica.observaciones like "Expedición Directa (Hornos)";

if isnull(linubica.ubicacion) or linubica.ubicacion = "" then
	linubica.empresa  = codigo_empresa  
	linubica.almacen  = "1"
	linubica.zona     = "P"
	linubica.fila     = 1
	linubica.altura   = 1
	IF IsNUll(linubica.altura) Then linubica.altura= 0
	linubica.articulo  = var_articulo
	linubica.familia   = var_familia 
	linubica.formato   = var_formato
	linubica.modelo    = var_modelo
	linubica.calidad   = var_calidad
	if isnull(linubica.calidad) or trim(linubica.calidad)="0" then linubica.calidad = ""
	linubica.tonochar    = var_tono
	linubica.calibre     = var_calibre
	linubica.caja		   = var_caja
	SetNull(linubica.anyo) 
	SetNull(linubica.pedido)
	SetNull(linubica.linped)
	SetNull(linubica.cliente)   
	linubica.ubicacion   = f_componer_ubicacion (linubica.almacen,linubica.zona,linubica.fila,linubica.altura)  
	linubica.tipo_unidad = var_tipo_unidad   
	linubica.referencia  = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
	linubica.f_alta= Datetime(Today(),Now())   
	IF var_tipo_unidad = "0" Then
		linubica.existencias  = 0
	Else
		linubica.existencias  = 0
	End If				
	linubica.tipo_pallet   = var_tipo_pallet
	linubica.sector        = var_sector
	linubica.observaciones = "Expedición Directa (Hornos)"
	
	cur_linea=0
	f_mensaje_proceso("Seleccion Ubica",8,10)
	
	SELECT almlinubica.empresa,almlinubica.ubicacion, max(almlinubica.linea)  
	INTO   :cur_empresa,:cur_ubicacion,:cur_linea  
	FROM   almlinubica  
	WHERE  (almlinubica.empresa   = :linubica.empresa ) AND  
			 (almlinubica.ubicacion = :linubica.ubicacion )   
	GROUP BY almlinubica.empresa,   
			  almlinubica.ubicacion  
	ORDER BY almlinubica.empresa ASC,   
			  almlinubica.ubicacion ASC  USING SQLCA;
			  
	f_mensaje_proceso("Fin Selec. Ubica",8,10)
	IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
	 cur_linea = 0 
	END IF
	
	cur_linea=cur_linea+1
	linubica.linea=cur_linea
	IF NOT f_insert_almlinubica(linubica) Then  control_bien=1
else
	cur_existencias = cur_existencias - diferencia
	UPDATE almlinubica  
	SET    existencias    = :cur_existencias
	WHERE almlinubica.empresa    =  :linubica.empresa
	AND   almlinubica.ubicacion  =  :linubica.ubicacion
	AND   almlinubica.linea      =  :linubica.linea;
	IF Sqlca.SqlCode <> 0 Then control_bien = 1
end if

//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden (movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = "P"
linubicahis.fila        = 1
linubicahis.altura      = 1
linubicahis.ubicacion   = linubica.ubicacion
linubicahis.cantidads   = movhis.cantidads
linubicahis.cantidade   = movhis.cantidade
linubicahis.articulo    = movhis.articulo
linubicahis.familia     = movhis.familia
linubicahis.formato     = movhis.formato
linubicahis.modelo      = movhis.modelo
linubicahis.calidad     = movhis.calidad
linubicahis.tonochar    = movhis.tonochar
linubicahis.calibre     = movhis.calibre
linubicahis.caja			= movhis.caja
linubicahis.fecha       = DateTime(Today())
linubicahis.tipomov     = "102"
linubicahis.tipo_unidad = movhis.tipo_unidad
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
linubicahis.observaciones = "Expedición Directa (Hornos)"
linubicahis.tipo_pallet = var_tipo_pallet
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

//var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF
*/
end function

public subroutine f_salir2 ();integer respuesta

cb_1.visible = TRUE
pb_1.visible = TRUE

f_campos(FALSE)
cb_informacion.visible = TRUE

respuesta = MessageBox("Atención", "¿Quieres desmarcar las lineas? ", Exclamation!, YesNo!, 2)
IF respuesta = 1 THEN
 	dw_temporal.Reset()
	var_contador = 1
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text,long(orden_codigo.text))
END IF
dw_detalle.SetRow(1)
end subroutine

public function boolean f_control_ubicaciones (long var_anyo, long var_pedido, long var_linea);/*
String ubicacion_aux

Select almlinubica.ubicacion
into   :ubicacion_aux
From   almlinubica
Where  almlinubica.empresa = :codigo_empresa
And    almlinubica.anyo    = :var_anyo
And    almlinubica.pedido  = :var_pedido
And    almlinubica.linped  = :var_linea;
if isnull(ubicacion_aux) or trim(ubicacion_aux)="" then
	return false
else
	return true
end if
*/
//Almacen Nuevo - No se reserva para pedidos nada
return false
			
end function

protected subroutine f_expedir ();Integer reg,reg1,bien,v_calibre, pallets_extra, contador_anterior, var_bultos[], bultos_acumulados, bultos_linea
dec{2}  nuevo_peso, peso_neto_acumulado, peso_neto_linea, peso_bruto_acumulado, peso_bruto_linea, peso_pallet, peso_europallet,ld_peso_neto_original,ld_peso_bruto_original
Dec{0}  var_anyo,var_pedido,var_linea,ante_pedido,jj
Dec{6}  v_cantidad,v_cantidad_facturar,v_disponible
dec{6}  ld_factor_correccion_peso_neto, ld_factor_correccion_peso_bruto
dec ld_peso_bruto_total_modificado,ld_peso_neto_total_modificado
dec ld_diferencia_peso_bruto,ld_diferencia_peso_neto
dec ld_peso_bruto_maximo_linea
long ll_linea_a_modificar_peso
long    ll_ant_albaran,ll_albaran,ll_diferencia_pallets,ll_lineas_albaran,ll_total_lineas_albaran
long    ll_indice_lineas_alb,ll_pallets_a_anyadir_linea,ll_linea_albaran,ll_resultado_impresion
Dec nu
String  v_articulo,v_calidad,v_tipo_pallet,v_referencia,v_antedep,ub,&
		  var_agrupa,var_clase,ante_clase,v_caja,v_tono,v_moneda
String  men,ante_agrupa,var_tipolinea,transpor,imprimir_cmr,ls_codigo_cmr,transportista_char,imprimir_vgm,ls_sel
long    registros,ll_indice,ll_total
datetime v_fecha_linped

Boolean nuevo_albaran

datastore ds_datos

//-----------------------------------------------------------------------

registros = dw_pedido.Rowcount()
if registros = 0 then
   return
end if

peso      = Dec(dw_pedido.GetItemString(1,"total_peso"))
peso_neto = Dec(dw_pedido.GetItemString(1,"total_peso_neto"))

IF Dec(em_albaran.text) <> 0 Then
	peso      = peso + f_peso_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))
	peso_neto = peso_neto + f_peso_neto_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))	
	em_fecha.text = String(Date(f_fentrega_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))),"dd-mm-yy")
END IF

ld_peso_neto_original  = peso_neto
ld_peso_bruto_original = peso

tipo_array val,ida

ida.valor[1] = em_cliente.text

ll_total = upperbound(istr_albaranes_a_generar)

ida.valor[2] = string(ll_total)

//
string tipo_portes
tipo_portes=dw_pedido.object.venped_tipo_portes[1]
if tipo_portes='1' then
	v_moneda = f_moneda_cliente(codigo_empresa,em_cliente.text)
	if v_moneda = "7" then
		precio_portes=f_precio_portes_euros(codigo_empresa,dw_pedido.object.venped_transportista[1],peso)
	else
		precio_portes=f_precio_portes(codigo_empresa,dw_pedido.object.venped_transportista[1],peso)
	end if
else	
	precio_portes=0
end if
ida.valor[3] = string(precio_portes,"###,###,###.00")

transpor = dw_pedido.object.venped_transportista[1]
ida.valor[4] = transpor
//

for ll_indice = 1 to ll_total
	ida.valor[(ll_indice * 4)+1] = string(istr_albaranes_a_generar[ll_indice].peso_bruto_real)
	ida.valor[(ll_indice * 4)+2] = string(istr_albaranes_a_generar[ll_indice].peso_neto_real)
	ida.valor[(ll_indice * 4)+3] = string(istr_albaranes_a_generar[ll_indice].pallets_reales)
	ida.valor[(ll_indice * 4)+4] = string(istr_albaranes_a_generar[ll_indice].lineas_pedidos)
next

openWithParm(w_pedir_datos_expedicion,ida)

val =  message.powerObjectparm

IF val.valor[1] = "RETURN" Then Return

if not(isdate(em_fecha.text)) or year(date(em_fecha.text)) = 1900 then
	messagebox("Atención!!","Fecha no valida")
	return
end if

observaciones = val.valor[1]
peso          = Dec(val.valor[2])
is_contenedor = val.valor[3]
precinto      = val.valor[4]
matricula     = val.valor[5]
dni           = val.valor[6]
peso_neto     = Dec(val.valor[7])
is_remolque   = val.valor[8]
imprimir_cmr  = val.valor[9]
is_agencia    = val.valor[10]
is_conductor  = val.valor[11]

imprimir_vgm = val.valor[12]

is_booking = val.valor[13]
id_tara_contenedor = dec(val.valor[14])
is_metodo_verificacion_masa_bruta = val.valor[15]

precio_portes = dec(val.valor[16])
formaenvio    = val.valor[17]

//Gno

for ll_indice = 1 to ll_total
	istr_albaranes_a_generar[ll_indice].peso_bruto_modificado = dec(val.valor[13 + (ll_indice * 4)+2])
	istr_albaranes_a_generar[ll_indice].peso_neto_modificado  = dec(val.valor[13 + (ll_indice * 4)+3])
	istr_albaranes_a_generar[ll_indice].pallets_modificados   = dec(val.valor[13 + (ll_indice * 4)+4])
next
//Fin gno


/* Campos originales
observaciones = val.valor[1] V
nuevo_peso    = Dec(val.valor[2]) V
contenedor    = val.valor[3] V
precinto      = val.valor[4] V
matricula     = val.valor[5] V
dni			  = val.valor[6] X
precio_portes = dec(val.valor[7]) V
formaenvio    = val.valor[8] V
bultos        = dec(val.valor[9]) V
conductor     = val.valor[10] V
is_agencia    = val.valor[11] V
is_conductor  = val.valor[12] V
imprimir_cmr  = val.valor[13] V
is_remolque = val.valor[14] V 

IF ISNULL(precio_portes) then precio_portes=0
*/

//*
//string tipo_portes
//tipo_portes=dw_pedido.object.venped_tipo_portes[1]
//if tipo_portes='1' then
//	v_moneda = f_moneda_cliente(codigo_empresa,em_cliente.text)
//	if v_moneda = "7" then
//		precio_portes=f_precio_portes_euros(codigo_empresa,dw_pedido.object.venped_transportista[1],peso)
//	else
//		precio_portes=f_precio_portes(codigo_empresa,dw_pedido.object.venped_transportista[1],peso)
//	end if
//else	
//	precio_portes=0
//end if
//
//transpor=dw_pedido.object.venped_transportista[1]
//
//if isnull(transpor) then transpor=''
//
//ida.valor[1]=string(peso,"###,###.00")
//ida.valor[2]=string(precio_portes,"###,###,###.00")
//
//if transpor<>'' then
//	if f_tipo_ventransportista(codigo_empresa,transpor)='C' then
//		ida.valor[3] =f_cif_ventransportista(codigo_empresa,transpor)
//		ida.valor[4] =f_matricula_ventransportista(codigo_empresa,transpor)
//		ida.valor[10]=f_nombre_ventransportista(codigo_empresa,transpor)
//	else
//		ida.valor[3] =''
//		ida.valor[4] =''
//		ida.valor[10]=f_nombre_ventransportista(codigo_empresa,transpor)
//	end if
//end if
//
//
//openWithParm(w_pedir_datos_expedicion,ent)
//val =  message.powerObjectparm
//IF val.valor[1] = "RETURN" Then Return
//
//observaciones = val.valor[1]
//nuevo_peso    = Dec(val.valor[2])
//contenedor    = val.valor[3]
//precinto      = val.valor[4]
//matricula     = val.valor[5]
//dni			  = val.valor[6]
//precio_portes = dec(val.valor[7])
//formaenvio    = val.valor[8]
//bultos        = dec(val.valor[9])
//conductor     = val.valor[10]
//is_agencia    = val.valor[11]
//is_conductor  = val.valor[12]
//imprimir_cmr  = val.valor[13]
//is_remolque = val.valor[14]
//
//IF ISNULL(precio_portes) then precio_portes=0

IF Dec(em_albaran.text) <> 0 Then
	IF MessageBox("Proceso Generación albaranes","¿Desea acumular sobre el albaran seleccionado?",Question!,YesNo!) = 2 Then
		em_albaran.text = "0"
	END IF
END IF
reg1 = dw_pedido.RowCount()
For reg = 1 To reg1
	IF dw_pedido.GetItemSTring(reg,"cmarcado") = "X" Then

	ub  = dw_pedido.GetItemSTring(reg,"bultos") //dw_pedido.GetItemSTring(reg,"zona")
	var_tipolinea = dw_pedido.GetItemSTring(reg,"venliped_tipolinea")
		IF IsNUll(ub) or Trim(ub)= "" and f_control_almacen_ventipolin(codigo_empresa,var_tipolinea)="S" Then
			f_mensaje("Control ubicaciones asignadas","El articulo "+ f_nombre_articulo(codigo_empresa,dw_pedido.GetItemString(reg,"venliped_articulo")) + " No tiene ubicacion asignada")
			f_activar_campo(uo_operario.em_campo)
			Return 
		END IF
	END IF
NEXT

bien = 0

veces = 1
nuevo_albaran = false

peso_neto_acumulado = 0
peso_bruto_acumulado = 0
bultos_acumulados = 0
ll_ant_albaran= 0
SetNull(v_antedep)
IF Not f_bloquear_almacen(w_expedir_pedidos.title)  Then
IF Not f_bloquear_albaranes(w_expedir_pedidos.title)  Then
For reg = 1 To reg1
		
			f_mensaje_proceso("Procesando..:",reg,reg1)
			IF dw_pedido.GetItemSTring(reg,"cmarcado") = "X" Then
						var_anyo        = dw_pedido.GetItemNumber(reg,"venliped_anyo")
						var_pedido      = dw_pedido.GetItemNumber(reg,"venliped_pedido")
						var_linea       = dw_pedido.GetItemNumber(reg,"venliped_linea")
						v_articulo      = dw_pedido.GetItemString(reg,"venliped_articulo")
						var_clase       = dw_pedido.GetItemString(reg,"venliped_clase")
						IF ISNULL(var_clase) THEN var_clase = ""
						var_agrupa      = dw_pedido.GetItemString(reg,"venped_agrupa_exp")
						IF ISNULL(var_agrupa) THEN var_agrupa = ""
						v_calidad       = dw_pedido.GetItemString(reg,"venliped_calidad")
						v_tono          = dw_pedido.GetItemString(reg,"venliped_tonochar")
						v_calibre       = dw_pedido.GetItemNumber(reg,"venliped_calibre")
						v_tipo_pallet   = dw_pedido.GetItemString(reg,"venliped_tipo_pallet")
						v_caja          = dw_pedido.GetItemString(reg,"venliped_caja")
						v_cantidad      = dw_pedido.GetItemNumber(reg,"venliped_cantidad")
						
						if dw_pedido.object.venliped_cliente[reg] = '1663' then
							v_deposito = 'S' //El cliente de promocion interna siempre genera un albaran de deposito
						else
							v_deposito = dw_pedido.GetItemString(reg,"venliped_deposito")
						end if						
						
						v_fecha_linped  = dw_pedido.GetItemDateTime(reg,"venliped_fecha_intr")
						ll_albaran      = dw_pedido.object.albaran[reg]
						
						IF ISNULL(v_deposito) THEN v_deposito = ""
						//-------------------------------------------------------------------//
						// Control disponible   // 
						//-------------------------------------------------------------------//
						 v_referencia = f_componer_ref(v_articulo,v_calidad,v_tono,v_calibre)
						 //v_disponible = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,&
												  //v_referencia,v_tipo_pallet,v_caja)
			 
						//----------------------------------------------------------------------//
						
						//IF (ante_clase = "M" and var_clase <> "M") or (var_clase <> "M" and ((ante_agrupa <> var_agrupa and Not IsNull(ante_agrupa)) or (var_pedido <> ante_pedido and var_agrupa = "N") or (v_antedep <> v_deposito and Not IsNull(v_antedep)))) Then
						
//Este era el control antiguo del cambio de albaran						
//						IF (ante_clase <> var_clase) or (ante_agrupa <> var_agrupa) or ((var_pedido <> ante_pedido) and var_agrupa = "N") or (v_antedep <> v_deposito) Then
//							//--------------------------------------------------------//
//							//--------- Control inicio nuevo albaran------------------//
//							//--------------------------------------------------------//
//							
//							//Pesos y bultos
//							var_peso_neto[var_contador] = peso_neto_acumulado
//							var_peso_bruto[var_contador] = peso_bruto_acumulado
//							var_bultos[var_contador] = bultos_acumulados
//							peso_neto_acumulado = 0
//							peso_bruto_acumulado = 0
//							bultos_acumulados = 0
//							nuevo_albaran = true
//							
//							//Contadores y parametros antiguos
//							veces = 0
//							peso  = 0
//							var_contador = var_contador + 1
//
//						END IF
						
						//Nuevo control inicio nuevo albaran
						if ll_albaran <> ll_ant_albaran then
							veces = 0
							var_contador   = var_contador + 1	
							ll_ant_albaran = ll_albaran
							//Esta variable la utilizamos para saber en que posicion del array de albaranes estamos
							il_contador_array_albaranes = ll_albaran
							
							//Esto lo pongo como estaba antes porsi
							peso_neto_acumulado = 0
							peso_bruto_acumulado = 0
							bultos_acumulados = 0
							nuevo_albaran = true							
							
						end if												
												
						//calculo peso albarán
						peso_bruto_linea = dw_pedido.GetItemDecimal(reg,"venliped_peso")
						peso_neto_linea = dw_pedido.GetItemDecimal(reg,"venliped_peso_neto")
						peso_pallet = dw_pedido.GetItemDecimal(reg,"pallets_peso")
						pallets_extra = dw_pedido.GetItemNumber(reg,"orden_carga_linea_pallets_extra")
						
						if isnull(peso_neto_linea) then peso_neto_linea = 0
						peso_neto_acumulado += peso_neto_linea
						if isnull(peso_bruto_linea) then peso_bruto_linea = 0
						peso_bruto_acumulado += peso_bruto_linea
						if isnull(pallets_extra) or isnull(peso_pallet) then pallets_extra = 0
						if pallets_extra = 1 then
							peso_bruto_acumulado += peso_pallet
							bultos_acumulados ++
						end if
						bultos_linea = dw_pedido.GetItemNumber(reg,"venliped_pallets")
						if isnull(bultos_linea) then bultos_linea = 0
						bultos_acumulados += bultos_linea
						
						v_antedep   = v_deposito
						ante_agrupa = var_agrupa
						ante_pedido = var_pedido
						ante_clase  = var_clase
						
						f_mensaje_proceso("Grabando Albaran Ped("+STring(var_pedido,"########")+")",reg,reg1)
						IF Not f_grabar_albaran(reg) Then 
							f_mensaje("Error en datos","Error en funcion grabar albaran")
							bien = 1
							exit
						END IF
						
						//ORDEN CARGA - Tabla expediciones
						
						IF Not f_grabar_salida_ventas(reg)  Then 
							f_mensaje("Error en datos","Error en funcion grabar salida ventas "+sqlca.sqlerrtext)
							bien = 1
							exit
						END IF
//						IF v_deposito = "S" Then
//							var_albaran1 = var_albaran
//						Else	
//							var_albaran2 = var_albaran
//						END IF
						f_mensaje_proceso("Pasando pedido(His) Ped ("+STring(var_pedido,"########")+")",reg,reg1)
						

						Select isnull(count(*),0) Into :nu from venliped
						Where  empresa = :codigo_empresa
						And    anyo    = :var_anyo
						And    pedido  = :var_pedido
						And    linea   = :var_linea;
						
						IF IsNUll(nu) Then nu = 0
						
						IF nu = 0 Then 
							bien = 1
							f_mensaje("Error en datos","No existe la linea de pedido a  borrar")
						END IF
						
						f_mensaje_proceso("Borrando Ped("+STring(var_pedido,"########")+")",reg,reg1)
						IF Not f_expedir_pedido(reg) Then 
							bien = 1
							f_mensaje("Error al f_expedir_pedido",sqlca.sqlErrtext)
						END IF
						
//						 //CONTROL NUEVOS ALBARANES - Se procede a actualización de pesos y bultos
//						if nuevo_albaran and reg <> 1 then
//							contador_anterior = var_contador - 1
//							Update venalb
//							Set peso = :var_peso_bruto[contador_anterior], peso_neto = :var_peso_neto[contador_anterior], bultos = :var_bultos[contador_anterior]
//							Where empresa = :codigo_empresa
//							And   anyo    = :var_anyo_albaran
//							And   albaran = :var_albaran[contador_anterior];
//							IF SQLCA.SQLCODE <> 0 Then
//								f_mensaje("Error al modificar peso internos",sqlca.sqlerrtext)
//								bien = 1
//							END IF
//							
//							Update venlialb
//							Set peso_bruto_venalb = :var_peso_bruto[contador_anterior], peso_neto_venalb = :var_peso_neto[contador_anterior], bultos_venalb = :var_bultos[contador_anterior]
//							Where empresa = :codigo_empresa
//							And   anyo    = :var_anyo_albaran
//							And   albaran = :var_albaran[contador_anterior];
//							IF SQLCA.SQLCODE <> 0 Then
//								f_mensaje("Error al modificar peso internos",sqlca.sqlerrtext)
//								bien = 1
//							END IF
//							nuevo_albaran = false
//						end if
//						
//						if reg = reg1 then
//							var_peso_neto[var_contador] = peso_neto_acumulado
//							var_peso_bruto[var_contador] = peso_bruto_acumulado
//							var_bultos[var_contador] = bultos_acumulados
//							
//							Update venalb
//							Set peso = :var_peso_bruto[var_contador], peso_neto = :var_peso_neto[var_contador], bultos = :var_bultos[var_contador]
//							Where empresa = :codigo_empresa
//							And   anyo    = :var_anyo_albaran
//							And   albaran = :var_albaran[var_contador];
//							IF SQLCA.SQLCODE <> 0 Then
//								f_mensaje("Error al modificar peso internos",sqlca.sqlerrtext)
//								bien = 1
//							END IF
//							
//							Update venlialb
//							Set peso_bruto_venalb = :var_peso_bruto[var_contador], peso_neto_venalb = :var_peso_neto[var_contador], bultos_venalb = :var_bultos[var_contador]
//							Where empresa = :codigo_empresa
//							And   anyo    = :var_anyo_albaran
//							And   albaran = :var_albaran[var_contador];
//							IF SQLCA.SQLCODE <> 0 Then
//								f_mensaje("Error al modificar peso internos",sqlca.sqlerrtext)
//								bien = 1
//							END IF
//							
//						end if					
									
			END IF

Next 

//For jj = 1 To var_contador
//// NO USAMOS ESTA FUNCIÓN PORQUE EL PESO SE CALCULA DE FORMA DISTINTA
////	IF Not f_actualizar_venalbaran(codigo_empresa,var_anyo_albaran,var_albaran[jj]) Then 
////		bien = 1
////		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
////	END IF
//
//	IF Not ftc_actualizar_venalbaran_expedicion(codigo_empresa,var_anyo_albaran,var_albaran[jj]) Then 
//		bien = 1
//		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
//	END IF
//
//Next
//Recalculamos los datos de los albaranes

//For jj = 1 To var_contador
//	IF Not f_actualizar_venalbaran(codigo_empresa,var_anyo_albaran,var_albaran[jj]) Then 
//		bien = 1
//		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
//	END IF
//next

//ahora updatearemos los pesos segun el array de albaranes a generar
ll_total = upperbound(istr_albaranes_a_generar)

for jj = 1 to ll_total
	
	IF Not f_actualizar_venalbaran(codigo_empresa,istr_albaranes_a_generar[jj].anyo,istr_albaranes_a_generar[jj].albaran) Then 
		bien = 1
		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
	END IF
	
	//Hacemos los calculos de los factores de conversion para updatear los pesos por linea
	//Con esto tratamos de hacer que si se suman los pesos de las lineas coincidan con el de cabecera
	if istr_albaranes_a_generar[jj].peso_neto_real <> 0 then 
		//ld_factor_correccion_peso_neto  = istr_albaranes_a_generar[jj].peso_neto_modificado / istr_albaranes_a_generar[jj].peso_neto_real
		//Lo basaremos todo en el bruto
		ld_factor_correccion_peso_neto  = istr_albaranes_a_generar[jj].peso_neto_modificado / istr_albaranes_a_generar[jj].peso_bruto_real
	else
		ld_factor_correccion_peso_neto  = 1
	end if    
	
	if istr_albaranes_a_generar[jj].peso_bruto_real <> 0 then
		ld_factor_correccion_peso_bruto = istr_albaranes_a_generar[jj].peso_bruto_modificado / istr_albaranes_a_generar[jj].peso_bruto_real
	else
		ld_factor_correccion_peso_bruto = 1
	end if	
	
	if ld_factor_correccion_peso_neto <> 1 or ld_factor_correccion_peso_bruto <> 1 or istr_albaranes_a_generar[jj].peso_bruto_real = 0 then

		Update venalb
		Set    peso      = :istr_albaranes_a_generar[jj].peso_bruto_modificado,
				 peso_neto = :istr_albaranes_a_generar[jj].peso_neto_modificado
		Where  empresa = :codigo_empresa
		And    anyo    = :istr_albaranes_a_generar[jj].anyo
		And    albaran = :istr_albaranes_a_generar[jj].albaran;	
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
			bien = 1
		END IF
		
		//Lo basamos todo en el peso bruto 
		update venlialb
		set    peso      = round(peso * :ld_factor_correccion_peso_bruto,2),
				 peso_neto = round(peso * :ld_factor_correccion_peso_neto,2)
		Where  empresa = :codigo_empresa
		And    anyo    = :istr_albaranes_a_generar[jj].anyo
		And    albaran = :istr_albaranes_a_generar[jj].albaran;
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
			bien = 1
		else
			
			ld_peso_bruto_total_modificado = 0
			ld_peso_neto_total_modificado  = 0
			
			select sum(peso),
					 sum(peso_neto)
			into   :ld_peso_bruto_total_modificado,
					 :ld_peso_neto_total_modificado
			from   venlialb
			Where  empresa = :codigo_empresa
			And    anyo    = :istr_albaranes_a_generar[jj].anyo
			And    albaran = :istr_albaranes_a_generar[jj].albaran;
									
			if isnull(ld_peso_bruto_total_modificado) then ld_peso_bruto_total_modificado = 0
			if isnull(ld_peso_neto_total_modificado) then ld_peso_neto_total_modificado = 0
									
			ld_diferencia_peso_bruto = istr_albaranes_a_generar[jj].peso_bruto_modificado - ld_peso_bruto_total_modificado
			ld_diferencia_peso_neto  = istr_albaranes_a_generar[jj].peso_neto_modificado - ld_peso_neto_total_modificado
			
			//Buscaremos la linea con mas peso y la regularizaremos para que el peso total nos cuadre con la cabecera
			
			ld_peso_bruto_maximo_linea = 0
			
			select max(peso)
			into   :ld_peso_bruto_maximo_linea
			from   venlialb
			Where  empresa = :codigo_empresa
			And    anyo    = :istr_albaranes_a_generar[jj].anyo
			And    albaran = :istr_albaranes_a_generar[jj].albaran;			
			
			if isnull(ld_peso_bruto_maximo_linea) then ld_peso_bruto_maximo_linea = 0
			
			ll_linea_a_modificar_peso =  0
			
			select min(linea)
			into   :ll_linea_a_modificar_peso
			from   venlialb
			Where  empresa = :codigo_empresa
			And    anyo    = :istr_albaranes_a_generar[jj].anyo
			And    albaran = :istr_albaranes_a_generar[jj].albaran
			and    peso    = :ld_peso_bruto_maximo_linea;			
						
			if isnull(ll_linea_a_modificar_peso) then ll_linea_a_modificar_peso = 0
			
			if ll_linea_a_modificar_peso = 0 then
				select min(linea)
				into   :ll_linea_a_modificar_peso
				from   venlialb
				Where  empresa = :codigo_empresa
				And    anyo    = :istr_albaranes_a_generar[jj].anyo
				And    albaran = :istr_albaranes_a_generar[jj].albaran;		
				
				if isnull(ll_linea_a_modificar_peso) then ll_linea_a_modificar_peso = 0
			end if
			
			if ll_linea_a_modificar_peso > 0 then			
				update venlialb
				set    peso      = peso + :ld_diferencia_peso_bruto,
						 peso_neto = peso_neto + :ld_diferencia_peso_neto
				Where  empresa = :codigo_empresa
				And    anyo    = :istr_albaranes_a_generar[jj].anyo
				And    albaran = :istr_albaranes_a_generar[jj].albaran
				and    linea   = :ll_linea_a_modificar_peso;
				
				IF SQLCA.SQLCODE <> 0 Then
					f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
					bien = 1
				end if				
			end if
		END IF	
	end if
	//ahora debemos asignar los pallets
	//Si hemos indicado menos pallets que los reales quitaremos
	
	Update venalb
	Set    bultos = :istr_albaranes_a_generar[jj].pallets_modificados
	Where  empresa = :codigo_empresa
	And    anyo    = :istr_albaranes_a_generar[jj].anyo
	And    albaran = :istr_albaranes_a_generar[jj].albaran;		
	
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error al modificar bultos",sqlca.sqlerrtext)
		bien = 1
	end if					
	
	ll_diferencia_pallets = istr_albaranes_a_generar[jj].pallets_modificados - istr_albaranes_a_generar[jj].pallets_reales
	
	ll_lineas_albaran = 0
	
	select count(*)
	into   :ll_lineas_albaran
	from   venlialb
	Where  empresa = :codigo_empresa
	And    anyo    = :istr_albaranes_a_generar[jj].anyo
	And    albaran = :istr_albaranes_a_generar[jj].albaran;	
	
	if isnull(ll_lineas_albaran) then ll_lineas_albaran = 0
	
	if ll_lineas_albaran >0 then
		if ll_lineas_albaran = 1 then
			update venlialb
			set    pallets = pallets + :ll_diferencia_pallets
			Where  empresa = :codigo_empresa
			And    anyo    = :istr_albaranes_a_generar[jj].anyo
			And    albaran = :istr_albaranes_a_generar[jj].albaran;
			
			IF SQLCA.SQLCODE <> 0 Then
				f_mensaje("Error al modificar los pallets",sqlca.sqlerrtext)
				bien = 1
			END IF				
		else
			ls_sel = "select linea,pallets "+&
						"from   venlialb "+&
						"where  empresa = '"+codigo_empresa+"' "+&
						"and    anyo    = "+string(istr_albaranes_a_generar[jj].anyo,"###0")+" "+&
						"and    albaran = "+string(istr_albaranes_a_generar[jj].albaran,"########0")+" "+&
						"and    cantidad <> 0 "
						
			if ll_diferencia_pallets > 0 then
				ls_sel = ls_sel + "order by es_pico desc,pallets asc,cantidad desc"
			else
				ls_sel = ls_sel + "and pallets > 0 order by pallets desc,cantidad desc"
			end if
			
			ll_total_lineas_albaran = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
			
			if ll_diferencia_pallets > 0 then
				for ll_indice_lineas_alb = 1 to ll_total_lineas_albaran
					if ll_indice_lineas_alb = 1 then
						if ll_total_lineas_albaran < ll_diferencia_pallets then
							ll_pallets_a_anyadir_linea = (ll_diferencia_pallets - ll_total_lineas_albaran)+1
							ll_diferencia_pallets = ll_diferencia_pallets - ll_pallets_a_anyadir_linea
						else
							if ll_diferencia_pallets > 0 then
								ll_pallets_a_anyadir_linea = 1
							else
								ll_pallets_a_anyadir_linea = 0
							end if
							ll_diferencia_pallets = ll_diferencia_pallets - ll_pallets_a_anyadir_linea							
						end if
					else
						if ll_diferencia_pallets > 0 then
							ll_pallets_a_anyadir_linea = 1
						else
							ll_pallets_a_anyadir_linea = 0
						end if
						ll_diferencia_pallets = ll_diferencia_pallets - ll_pallets_a_anyadir_linea
					end if
					
					if ll_pallets_a_anyadir_linea > 0 then
						ll_linea_albaran = ds_datos.object.linea[ll_indice_lineas_alb]
						
						update venlialb
						set    pallets = pallets + :ll_pallets_a_anyadir_linea
						Where  empresa = :codigo_empresa
						And    anyo    = :istr_albaranes_a_generar[jj].anyo
						And    albaran = :istr_albaranes_a_generar[jj].albaran
						and    linea   = :ll_linea_albaran;
						
						IF SQLCA.SQLCODE <> 0 Then
							f_mensaje("Error al modificar los pallets",sqlca.sqlerrtext)
							bien = 1
						END IF	
					end if
				next
			else
				
			end if
			destroy ds_datos
		end if
	end if
Next

/* Cambio anterior de pesos y bultos
IF nuevo_peso <> 0 and var_contador <=2 Then
	Update venalb
	Set peso = :nuevo_peso, peso_neto = :peso_neto
	Where empresa = :codigo_empresa
	And   anyo    = :var_anyo_albaran
	And   albaran = :var_albaran[var_contador];
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
		bien = 1
	END IF
	
	Update venlialb
	Set peso_bruto_venalb = :nuevo_peso
	Where empresa = :codigo_empresa
	And   anyo    = :var_anyo_albaran
	And   albaran = :var_albaran[var_contador];
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error al modificar peso (lineas) ",sqlca.sqlerrtext)
		bien = 1
	END IF
	
END IF

if bultos <> 0  and var_contador <=2 then
	
	if nuevo_peso = 0 then
		SELECT peso INTO :peso_europallet 
		FROM pallets 
		WHERE empresa = :codigo_empresa AND codigo = '2';
		
		SELECT bultos, peso, peso_neto INTO :bultos_acumulados, :peso_bruto_acumulado
		FROM venalb 
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo_albaran
		And   albaran = :var_albaran[var_contador];
		
		peso_bruto_acumulado += ((bultos  - bultos_acumulados) * peso_europallet)
		
		Update venalb
		Set bultos = :bultos, peso = :peso_bruto_acumulado
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo_albaran
		And   albaran = :var_albaran[var_contador];
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar bultos manual ",sqlca.sqlerrtext)
			bien = 1
		END IF
		
		Update venlialb
		Set bultos_venalb = :bultos, peso_bruto_venalb = :peso_bruto_acumulado
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo_albaran
		And   albaran = :var_albaran[var_contador];
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar bultos manual (lineas) ",sqlca.sqlerrtext)
			bien = 1
		END IF
		
	else
		Update venalb
		Set bultos = :bultos
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo_albaran
		And   albaran = :var_albaran[var_contador];
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar bultos manual ",sqlca.sqlerrtext)
			bien = 1
		END IF
		
		Update venlialb
		Set bultos_venalb = :bultos 
		Where empresa = :codigo_empresa
		And   anyo    = :var_anyo_albaran
		And   albaran = :var_albaran[var_contador];
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar bultos manual (lineas) ",sqlca.sqlerrtext)
			bien = 1
		END IF
	end if
	
end if
*/

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso de datos","No se actualiza" + sqlca.sqlerrtext)
END IF

f_desbloquear_almacen(w_expedir_pedidos.title)
f_desbloquear_albaranes(w_expedir_pedidos.title)

cb_1.TriggerEvent(Clicked!)
IF bien = 0 Then
		em_albaran.text= STring(var_albaran[var_contador])
		IF listar.checked = TRUE Then
			str_parametros lstr_param
			lstr_param.i_nargumentos    = 3 + var_contador
			lstr_param.s_argumentos[2]=em_copias.text
			lstr_param.s_argumentos[3]=String(var_anyo_albaran)
			For jj = 1 To var_contador
			 lstr_param.s_argumentos[jj +3]=String(var_albaran[jj])						  
//						 setnull(var_albaran[jj])
			NEXT
//			OpenWithParm (w_lis_venalbaranes, lstr_param) 
		END IF
		if imprimir_cmr = "S" then
			ls_codigo_cmr = f_nuevo_cmr(codigo_empresa,var_anyo_albaran)
			em_cmr.text   = ls_codigo_cmr
			if trim(ls_codigo_cmr) <> "" then
				For jj = 1 To var_contador
					if not isnull(var_albaran[jj]) and not dec(var_albaran[jj]) = 0 then
						f_anyade_albaran_a_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,'V',var_anyo_albaran,var_albaran[jj])
					end if
				next				
			end if			
		end if

		if imprimir_vgm = "S" then
//			For jj = 1 To var_contador
//				if not isnull(var_albaran[jj]) and not dec(var_albaran[jj]) = 0 then
//					f_cargar_report_vgm(codigo_empresa,var_anyo_albaran,var_albaran[jj],dw_listado_vgm)
//					print(dw_listado_vgm)		
//				end if
//			next
			f_cargar_report_vgm_contenedor_booking(codigo_empresa,is_contenedor,is_booking,dw_listado_vgm)			
			print(dw_listado_vgm)		
		end if		

		long alb,cont,copias
		alb=var_albaran[var_contador]
		
		
//		if transpor<>'' then
//			if messagebox("Etiqueta de Agencia","¿Desea imprimir la etiqueta de agencia?",Information!,YesNo!,1)=1 then
////				dw_etiqueta_agencia.retrieve(codigo_empresa,var_anyo_albaran,alb)
//				lstr_param.i_nargumentos=3
//				lstr_param.s_argumentos[1]='Etiqueta de Agencia'
//				lstr_param.s_argumentos[2]='¿Cuantas copias desea imprimir?'
//				lstr_param.s_argumentos[3]='1'
//				lstr_param.s_argumentos[4]=''
//				openwithparm(w_inputbox,lstr_param)
//				copias = long(message.stringParm)
//				for cont=1 to copias
//					dw_etiqueta_agencia.insertrow(cont)
//					dw_etiqueta_agencia.object.empresa[cont]=codigo_empresa
//					dw_etiqueta_agencia.object.anyo[cont]=var_anyo_albaran
//					dw_etiqueta_agencia.object.albaran[cont]=alb
//				next
//				
//				f_imprimir_datawindow(dw_etiqueta_agencia)
//			end if
//		end if
		
END IF
uo_operario.em_campo.text = ""
uo_operario.em_codigo.text = ""
observaciones = ""
dw_temporal.Reset()
dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,em_cliente.text,long(orden_codigo.text))
dw_detalle.SetRow(1)
f_salir()
ELSE
	f_desbloquear_almacen(w_expedir_pedidos.title)
END IF
END IF
var_contador = 1

OpenWithParm (w_lis_venalbaranes, lstr_param)

if imprimir_cmr = "S" then
	f_imprimir_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,dw_listado_cmr)
end if
end subroutine

public subroutine f_filtrar ();string filtro

dw_detalle.setredraw(false)
dw_detalle.setfilter('')
dw_detalle.Filter()

//filtro = " 1 = 1 "

//if not isnull(orden_codigo.text) and orden_codigo.text <> '' and not isnull(orden_anyo.text) and orden_anyo.text <> '' then
//	filtro = filtro + upper ("expedicion_anyo = "+String(orden_anyo.text)+" and expedicion_codigo = '"+String(orden_codigo.text)+"' ")
//	
//	if not isnull(sle_articulo.text) and sle_articulo.text <> '' then
//		filtro = filtro + upper (" and venliped_descripcion like '%"+String(sle_articulo.text)+"%'")
//	end if
//else
//	filtro = " 1 = 0 "
//end if

dw_detalle.setfilter(filtro)
dw_detalle.Filter()
dw_detalle.setredraw(true)
end subroutine

public function integer f_calcula_albaranes_a_generar ();int  li_anyo_pedido,li_anyo_pedido_ant,li_pallets_linea_pedido
long ll_pedido,ll_pedido_ant,ll_indice,ll_total,ll_indice_albaranes
string ls_cliente,ls_deposito,ls_deposito_ant,ls_cliente_agrupa_ped,ls_cliente_agrupa_ref
string ls_muestras,ls_muestras_ant
boolean lb_separar_pedidos,lb_separar_referencias,lb_nuevo_albaran

str_venped lstr_venped,lstr_venped_ant

li_anyo_pedido_ant = 0
ll_pedido_ant      = 0

ll_total = dw_pedido.rowcount()

ll_indice_albaranes      = 0
istr_albaranes_a_generar = istr_albaranes_a_generar_vacio
ls_deposito_ant          = ""
ls_muestras_ant          = ""
ls_cliente               = em_cliente.text

select agrupa_exp,
		 agrupa_referencia
into   :ls_cliente_agrupa_ped,
		 :ls_cliente_agrupa_ref
from   venclientes
where  empresa = :codigo_empresa
and    codigo  = :ls_cliente;

if isnull(ls_cliente_agrupa_ped) then ls_cliente_agrupa_ped = ""
if isnull(ls_cliente_agrupa_ref) then ls_cliente_agrupa_ref = ""

if trim(ls_cliente_agrupa_ped) = "" then ls_cliente_agrupa_ped = "S"
if trim(ls_cliente_agrupa_ref) = "" then ls_cliente_agrupa_ref = "S"

if ls_cliente_agrupa_ped = "N" then
	lb_separar_pedidos     = true
	lb_separar_referencias = true
else
	lb_separar_pedidos = false
	if ls_cliente_agrupa_ref = "N" then
		lb_separar_referencias = true
	else
		lb_separar_referencias = false
	end if	
end if

for ll_indice = 1 to ll_total
	f_mensaje_proceso("calculando albaranes a generar",ll_indice,ll_total)
	if dw_pedido.object.cmarcado[ll_indice] = "X" then
		lb_nuevo_albaran = false
		ls_muestras    = dw_pedido.object.muestras[ll_indice]
		li_anyo_pedido = dw_pedido.object.venliped_anyo[ll_indice]
		ll_pedido      = dw_pedido.object.venliped_pedido[ll_indice]
		ls_deposito    = dw_pedido.object.venliped_deposito[ll_indice]
		
		if isnull(ls_deposito) then ls_deposito = ""
		if trim(ls_deposito) = "" then ls_deposito = "N"
		
		if trim(ls_deposito_ant) = "" then
			ls_deposito_ant = ls_deposito
		end if
		
		if ls_deposito <> ls_deposito_ant then
			ls_deposito_ant = ls_deposito
			lb_nuevo_albaran = true
		end if		
		
		if trim(ls_muestras_ant) = "" then
			ls_muestras_ant = ls_muestras
		end if
		
		if ls_muestras <> ls_muestras_ant then
			ls_muestras_ant = ls_muestras
			lb_nuevo_albaran = true
		end if		
		
		if li_anyo_pedido_ant = 0 then
			//El primer pedido ya genera un albaran
			li_anyo_pedido_ant = li_anyo_pedido
			ll_pedido_ant      = ll_pedido
			f_cargar_str_venped(codigo_empresa,li_anyo_pedido,ll_pedido,lstr_venped)
			f_inicializar_str_venped(lstr_venped)
			lstr_venped_ant = lstr_venped						
			lb_nuevo_albaran = true
		end if

		if li_anyo_pedido <> li_anyo_pedido_ant or ll_pedido <> ll_pedido_ant then
			li_anyo_pedido_ant = li_anyo_pedido
			ll_pedido_ant      = ll_pedido			
			lstr_venped_ant = lstr_venped
			f_cargar_str_venped(codigo_empresa,li_anyo_pedido,ll_pedido,lstr_venped)
			f_inicializar_str_venped(lstr_venped)			
			if lb_separar_pedidos then
				lb_nuevo_albaran = true
			end if
		end if
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.numpedcli <> lstr_venped_ant.numpedcli and lb_separar_referencias then
				lb_nuevo_albaran = true
			end if
		end if
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.tipoiva <> lstr_venped_ant.tipoiva then
				lb_nuevo_albaran = true
			end if
		end if				
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.codpago <> lstr_venped_ant.codpago then
				lb_nuevo_albaran = true
			end if
		end if					
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.tarifa <> lstr_venped_ant.tarifa then
				lb_nuevo_albaran = true
			end if
		end if							
	
		if not(lb_nuevo_albaran) then
			if lstr_venped.divisa <> lstr_venped_ant.divisa then
				lb_nuevo_albaran = true
			end if
		end if			
	
		if not(lb_nuevo_albaran) then
			if lstr_venped.cod_entrega <> lstr_venped_ant.cod_entrega then
				lb_nuevo_albaran = true
			end if
		end if			

		if not(lb_nuevo_albaran) then
			if lstr_venped.banco_de_cobro <> lstr_venped_ant.banco_de_cobro then
				lb_nuevo_albaran = true
			end if
		end if			

		if not(lb_nuevo_albaran) then
			if lstr_venped.agente1 <> lstr_venped_ant.agente1 then
				lb_nuevo_albaran = true
			end if
		end if		

		if not(lb_nuevo_albaran) then
			if lstr_venped.comision1 <> lstr_venped_ant.comision1 then
				lb_nuevo_albaran = true
			end if
		end if		
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.comision11 <> lstr_venped_ant.comision11 then
				lb_nuevo_albaran = true
			end if
		end if	
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.agente2 <> lstr_venped_ant.agente2 then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.comision2 <> lstr_venped_ant.comision2 then
				lb_nuevo_albaran = true
				
			end if
		end if		
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.comision22 <> lstr_venped_ant.comision22 then
				lb_nuevo_albaran = true
				
			end if
		end if	
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.agente3 <> lstr_venped_ant.agente3 then
				lb_nuevo_albaran = true
				
			end if
		end if			

		if not(lb_nuevo_albaran) then
			if lstr_venped.comision31 <> lstr_venped_ant.comision31 then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.comision32 <> lstr_venped_ant.comision32 then
				lb_nuevo_albaran = true
				
			end if
		end if					
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.dtopp <> lstr_venped_ant.dtopp then
				lb_nuevo_albaran = true
				
			end if
		end if				
				
		if not(lb_nuevo_albaran) then
			if lstr_venped.calculo_dto <> lstr_venped_ant.calculo_dto then
				lb_nuevo_albaran = true
			end if
		end if				
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.calculo_dtoesp <> lstr_venped_ant.calculo_dtoesp then
				lb_nuevo_albaran = true
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.dtoesp1 <> lstr_venped_ant.dtoesp1 then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.tipodto1 <> lstr_venped_ant.tipodto1 then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.dtoesp2 <> lstr_venped_ant.dtoesp2 then
				lb_nuevo_albaran = true
				
			end if
		end if		
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.tipodto2 <> lstr_venped_ant.tipodto2 then
				lb_nuevo_albaran = true
				
			end if
		end if					
	
		if not(lb_nuevo_albaran) then
			if lstr_venped.dtoesp3 <> lstr_venped_ant.dtoesp3 then
				lb_nuevo_albaran = true
				
			end if
		end if			

		if not(lb_nuevo_albaran) then
			if lstr_venped.tipodto3 <> lstr_venped_ant.tipodto3 then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.dtoesp4 <> lstr_venped_ant.dtoesp4 then
				lb_nuevo_albaran = true
				
			end if
		end if					

		if not(lb_nuevo_albaran) then
			if lstr_venped.tipodto4 <> lstr_venped_ant.tipodto4 then
				lb_nuevo_albaran = true
				
			end if
		end if		
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.envio <> lstr_venped_ant.envio then
				lb_nuevo_albaran = true
				
			end if
		end if			
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.correspondencia <> lstr_venped_ant.correspondencia then
				lb_nuevo_albaran = true
				
			end if
		end if				
		
		if not(lb_nuevo_albaran) then
			if lstr_venped.domiciliacion <> lstr_venped_ant.domiciliacion then
				lb_nuevo_albaran = true
				
			end if
		end if					

		if lb_nuevo_albaran then
			ll_indice_albaranes ++
			istr_albaranes_a_generar[ll_indice_albaranes].anyo                  = 0
			istr_albaranes_a_generar[ll_indice_albaranes].albaran               = 0
			istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real        = 0
			istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real       = 0
			istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_modificado  = 0
			istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_modificado = 0		
			istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales        = 0
			istr_albaranes_a_generar[ll_indice_albaranes].pallets_modificados   = 0
			istr_albaranes_a_generar[ll_indice_albaranes].lineas_pedidos        = 0
		end if
		
		
		li_pallets_linea_pedido =  dw_pedido.object.venliped_pallets[ll_indice]
		
		if isnull(li_pallets_linea_pedido) then li_pallets_linea_pedido = 0
		
		istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real        = istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real + dw_pedido.object.venliped_peso_neto[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real       = istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real + dw_pedido.object.venliped_peso[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_modificado  = istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real
		istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_modificado = istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real
		istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales        = istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales + li_pallets_linea_pedido// dw_pedido.object.venliped_pallets[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].pallets_modificados   = istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales
		istr_albaranes_a_generar[ll_indice_albaranes].lineas_pedidos ++
		
		dw_pedido.object.albaran[ll_indice] = ll_indice_albaranes
		
		lstr_venped_ant = lstr_venped
	end if	
next

return 0
end function

public subroutine f_mostrar_bultos_linea (datawindow arg_datawindow, long arg_row);string ls_almacen,ls_zona,ls_descripcion_reservas,ls_sel,ls_fila,ls_altura,ls_bulto,ls_cantidad,ls_ubicacion
int    li_anyo,li_linea,li_fila,li_altura
dec    ld_cantidad
long   ll_pedido,ll_bulto,ll_indice,ll_total
datastore ds_datos

li_anyo   = arg_datawindow.object.venliped_anyo[arg_row]
ll_pedido = arg_datawindow.object.venliped_pedido[arg_row]
li_linea  = arg_datawindow.object.venliped_linea[arg_row]

ls_sel = "select almubimapa_codbar.almacen, "+&
			"       almubimapa_codbar.zona, "+&
			"       almubimapa_codbar.fila, "+&
			"       almubimapa_codbar.altura, "+&
			"       alm_bultos.id, "+&
			"       sum(venliped_reservas.cantidad) as cantidad "+&
			"from   venliped_reservas,alm_bultos,alm_bultos_lineas,almubimapa_codbar "+&
			"where  venliped_reservas.empresa              = alm_bultos_lineas.empresa "+&
			"and    venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id "+&
			"and    alm_bultos_lineas.id_alm_bultos        = alm_bultos.id "+&
			"and    alm_bultos.id_ubicacion                = almubimapa_codbar.id "+&
			"and    venliped_reservas.empresa = '"+codigo_empresa+"' "+&
			"and    venliped_reservas.anyo    = "+string(li_anyo,"###0")+" "+&
			"and    venliped_reservas.pedido  = "+string(ll_pedido,"######0")+" "+&
			"and    venliped_reservas.linea   = "+string(li_linea,"###0")+" "+&
			"group by almubimapa_codbar.almacen, "+&
			"         almubimapa_codbar.zona, "+&
			"         almubimapa_codbar.fila, "+&
			"         almubimapa_codbar.altura, "+&
			"         alm_bultos.id "+&
			"order by almubimapa_codbar.almacen, "+&
			"         almubimapa_codbar.zona, "+&
			"         almubimapa_codbar.fila, "+&
			"         almubimapa_codbar.altura, "+&
			"         alm_bultos.id "

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	ls_almacen  = ds_datos.object.almubimapa_codbar_almacen[ll_indice]
	ls_zona     = ds_datos.object.almubimapa_codbar_zona[ll_indice]
	li_fila     = ds_datos.object.almubimapa_codbar_fila[ll_indice]
	li_altura   = ds_datos.object.almubimapa_codbar_altura[ll_indice]
	ll_bulto    = ds_datos.object.alm_bultos_id[ll_indice]
	ld_cantidad = ds_datos.object.cantidad[ll_indice]
	
	ls_almacen  = space(2 - len(ls_almacen)) + ls_almacen
	ls_zona     = space(2 - len(ls_zona)) + ls_zona
	ls_fila     = string(li_fila,"##0")
	ls_fila     = space(3 - len(ls_fila)) + ls_fila
	ls_altura   = string(li_altura,"#0")
	ls_altura   = space(2 - len(ls_altura)) + ls_altura
	ls_bulto    = string(ll_bulto,"0000000000")
	ls_cantidad = string(ld_cantidad,"######0.00")
	ls_cantidad = space(10 - len(ls_cantidad)) + ls_cantidad
	
	ls_ubicacion = ls_almacen+'-'+ls_zona+'-'+ls_fila+'-'+ls_altura
	
	if ll_indice = 1 then
		ls_descripcion_reservas = ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
	else
		ls_descripcion_reservas += "~n"+ls_ubicacion+' '+ls_bulto+' '+ls_cantidad
	end if
next

arg_datawindow.object.bultos[arg_row] = ls_descripcion_reservas

destroy ds_datos
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Expedicion directa de pedidos"
This.title=istr_parametros.s_titulo_ventana
paso = 1
em_fecha.text = String(Today(),"dd-mm-yy")
dw_1.SetTransObject(SQLCA)
dw_ubicaciones.SetTransObject(SQLCA)
dw_infor.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)
dw_consulta.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_pedido.SetTransObject(SQLCA)
dw_listado_vgm.SetTransObject(SQLCA)

//dw_etiqueta_agencia.settransobject(sqlca)
//f_mascara_columna(dw_detalle,"venliped_cantidad",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"venliped_cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"venliped_pallets",f_mascara_decimales(0))
f_activar_campo(em_cliente)

end event

on w_expedir_pedidos_new.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.cb_marcar_todo=create cb_marcar_todo
this.st_operario=create st_operario
this.uo_operario=create uo_operario
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.st_albaran=create st_albaran
this.em_albaran=create em_albaran
this.listar=create listar
this.em_copias=create em_copias
this.st_copias=create st_copias
this.cb_1=create cb_1
this.dw_etiqueta_agencia=create dw_etiqueta_agencia
this.cb_informacion=create cb_informacion
this.dw_consulta=create dw_consulta
this.dw_temporal=create dw_temporal
this.dw_albaranes=create dw_albaranes
this.sle_articulo=create sle_articulo
this.dw_ubicaciones=create dw_ubicaciones
this.dw_infor=create dw_infor
this.dw_1=create dw_1
this.orden_codigo=create orden_codigo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.st_1=create st_1
this.pb_3=create pb_3
this.st_cmr=create st_cmr
this.em_cmr=create em_cmr
this.dw_listado_cmr=create dw_listado_cmr
this.dw_listado_vgm=create dw_listado_vgm
this.dw_pedido=create dw_pedido
this.dw_detalle=create dw_detalle
this.t_preparado=create t_preparado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_cliente
this.Control[iCurrent+3]=this.st_nomcliente
this.Control[iCurrent+4]=this.cb_marcar_todo
this.Control[iCurrent+5]=this.st_operario
this.Control[iCurrent+6]=this.uo_operario
this.Control[iCurrent+7]=this.st_fecha
this.Control[iCurrent+8]=this.em_fecha
this.Control[iCurrent+9]=this.st_albaran
this.Control[iCurrent+10]=this.em_albaran
this.Control[iCurrent+11]=this.listar
this.Control[iCurrent+12]=this.em_copias
this.Control[iCurrent+13]=this.st_copias
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.dw_etiqueta_agencia
this.Control[iCurrent+16]=this.cb_informacion
this.Control[iCurrent+17]=this.dw_consulta
this.Control[iCurrent+18]=this.dw_temporal
this.Control[iCurrent+19]=this.dw_albaranes
this.Control[iCurrent+20]=this.sle_articulo
this.Control[iCurrent+21]=this.dw_ubicaciones
this.Control[iCurrent+22]=this.dw_infor
this.Control[iCurrent+23]=this.dw_1
this.Control[iCurrent+24]=this.orden_codigo
this.Control[iCurrent+25]=this.gb_1
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.gb_3
this.Control[iCurrent+28]=this.st_1
this.Control[iCurrent+29]=this.pb_3
this.Control[iCurrent+30]=this.st_cmr
this.Control[iCurrent+31]=this.em_cmr
this.Control[iCurrent+32]=this.dw_listado_cmr
this.Control[iCurrent+33]=this.dw_listado_vgm
this.Control[iCurrent+34]=this.dw_pedido
this.Control[iCurrent+35]=this.dw_detalle
this.Control[iCurrent+36]=this.t_preparado
end on

on w_expedir_pedidos_new.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.cb_marcar_todo)
destroy(this.st_operario)
destroy(this.uo_operario)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.st_albaran)
destroy(this.em_albaran)
destroy(this.listar)
destroy(this.em_copias)
destroy(this.st_copias)
destroy(this.cb_1)
destroy(this.dw_etiqueta_agencia)
destroy(this.cb_informacion)
destroy(this.dw_consulta)
destroy(this.dw_temporal)
destroy(this.dw_albaranes)
destroy(this.sle_articulo)
destroy(this.dw_ubicaciones)
destroy(this.dw_infor)
destroy(this.dw_1)
destroy(this.orden_codigo)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.pb_3)
destroy(this.st_cmr)
destroy(this.em_cmr)
destroy(this.dw_listado_cmr)
destroy(this.dw_listado_vgm)
destroy(this.dw_pedido)
destroy(this.dw_detalle)
destroy(this.t_preparado)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;IF paso  = 1 then
	f_cursor_arriba(dw_consulta)
ELSE
	f_cursor_arriba(dw_pedido)
END IF
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;IF paso  = 1 then
	f_cursor_abajo(dw_consulta)
ELSE
	f_cursor_abajo(dw_pedido)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF paso  = 1 then
	f_pagina_abajo(dw_consulta)
ELSE
	f_pagina_abajo(dw_pedido)
END IF
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;IF paso  = 1 then
	f_pagina_arriba(dw_consulta)
ELSE
	f_pagina_arriba(dw_pedido)
END IF
end event

event activate;call super::activate;w_expedir_pedidos = ventanas_activas[id_ventana_activa].ventana
end event

event timer;call super::timer;t_preparado.visible = not(t_preparado.visible) 
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_expedir_pedidos_new
integer x = 82
integer y = 1268
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_expedir_pedidos_new
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_expedir_pedidos_new
integer x = 55
integer y = 16
integer width = 4539
integer height = 80
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
end type

type pb_1 from upb_salir within w_expedir_pedidos_new
integer x = 5381
integer y = 100
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
end type

type em_cliente from u_em_campo within w_expedir_pedidos_new
integer x = 82
integer y = 172
integer width = 224
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;Int bloqueada_expedicion

st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
	IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
	em_cliente.text=""
END IF
//dw_consulta.Retrieve(codigo_empresa,em_cliente.text)

sle_articulo.text = ""
orden_codigo.text = ""

SELECT bloqueada_expedicion INTO :bloqueada_expedicion FROM venclientes WHERE empresa = :codigo_empresa AND codigo = :em_cliente.text;

if bloqueada_expedicion = 1 then
	MessageBox("Atención", "No se pueden expedir pedidos del cliente seleccionado hasta que los abonen por anticipado. Por favor, contacte previamente con administración.")
	em_cliente.text=""
	st_nomcliente.text = ""
	dw_detalle.reset()
	dw_temporal.Reset()
	return 2
else
	dw_detalle.setfilter("")
	dw_detalle.filter()
	
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text,long(orden_codigo.text))
	
	//Esto se hace en el retrieveend : f_filtrar()
	
	dw_detalle.SetRow(1)
	dw_temporal.Reset()
end if

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_expedir_pedidos_new
integer x = 325
integer y = 172
integer width = 1746
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type cb_marcar_todo from u_boton within w_expedir_pedidos_new
event clicked pbm_bnclicked
boolean visible = false
integer x = 2661
integer y = 2900
integer width = 343
integer height = 76
integer taborder = 0
string text = "Marca Todo"
end type

event clicked;call super::clicked;Integer reg
For reg = 1 To dw_pedido.rowCount()
	IF dw_pedido.GetItemString(reg,"venliped_situacion") <> "F" Then
		dw_pedido.SetItem(reg,"cmarcado","X")
		dw_pedido.ScrollToRow(reg)
	END IF
Next
end event

type st_operario from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 754
integer y = 2816
integer width = 677
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Operario"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_operario from u_em_campo_2 within w_expedir_pedidos_new
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 759
integer y = 2884
integer width = 672
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_operario.em_campo.text=f_nombre_almoperarios_abr(codigo_empresa,uo_operario.em_codigo.text)
IF Trim(uo_operario.em_campo.text)="" THEN 
 IF Trim(uo_operario.em_codigo.text) <> "" Then
	uo_operario.em_campo.SetFocus()
END IF
 uo_operario.em_campo.text  = ""
 uo_operario.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de operarios"
ue_datawindow = "dw_ayuda_operarios"
ue_filtro     = ""

end event

on uo_operario.destroy
call u_em_campo_2::destroy
end on

type st_fecha from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 1435
integer y = 2816
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Alb"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_expedir_pedidos_new
boolean visible = false
integer x = 1435
integer y = 2884
integer width = 297
integer height = 80
integer taborder = 60
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_albaran from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 1733
integer y = 2816
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "NºAlb"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF dw_albaranes.Retrieve(codigo_empresa,em_cliente.text) <> 0 Then
	dw_albaranes.visible = TRUE
END IF
end event

type em_albaran from u_em_campo within w_expedir_pedidos_new
boolean visible = false
integer x = 1733
integer y = 2884
integer width = 247
integer height = 80
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

type listar from radiobutton within w_expedir_pedidos_new
boolean visible = false
integer x = 2249
integer y = 2908
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Listar"
boolean checked = true
boolean automatic = false
end type

event clicked;
IF checked Then
	checKed = FALSE
ELSE
	checked = TRUE
END IF
end event

type em_copias from u_em_campo within w_expedir_pedidos_new
boolean visible = false
integer x = 2441
integer y = 2824
integer width = 183
integer height = 68
integer taborder = 70
string text = "3"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#0"
boolean spin = true
string displaydata = "~t/"
double increment = 1
end type

type st_copias from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 2254
integer y = 2824
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_expedir_pedidos_new
integer x = 5015
integer y = 2832
integer width = 288
integer height = 124
integer taborder = 0
string text = "C&ontinuar"
end type

event clicked;String var_ubicacion,var_referencia,var_tipo_pallet,var_tipolinea,var_caja, oc_finalizada, var_tipo_unidad
String var_almacen_de_carga, formato
Dec 	 var_cantidad,var_pallets,var_cajas,var_total_cajas,var_cantidad_facturar,total_marcado, var_peso_bruto_linea, var_peso_neto_linea, var_cantidad_unidad, var_metros_caja
dec    var_cantidad_pzs
Dec 	 t,var_anyo,var_pedido,var_linea,n
Long   total_consulta, var_piezas_caja
String articulo, zona, calidad, tono
Int calibre, fila, altura, hay_stock
Boolean error_oc = false
String var_oc_almacen_destino, var_oc_zona_destino 
Int var_oc_fila_destino, var_oc_altura_destino, expedicion_anyo, expedicion_anyo_anterior
Long i, ordenes_carga = 0, total_lineas_oc = 0
Boolean sin_ordenes_carga = false
String expedicion_codigo_anterior = "", expedicion_codigo

//VERIFICAMOS QUE SI SE HA MARCADO UNA ORDEN DE CARGA SE MARQUE TODA
i = 1
do while i <= dw_detalle.RowCount() and not error_oc
	if dw_detalle.object.marcado[i] = "X" then
		expedicion_codigo = dw_detalle.object.expedicion_codigo[i]
		expedicion_anyo = dw_detalle.object.expedicion_anyo[i]
		if not isnull(expedicion_codigo) and expedicion_codigo <> "" then
			ordenes_carga++
			if expedicion_codigo_anterior = "" then
				expedicion_codigo_anterior = expedicion_codigo
				expedicion_anyo_anterior = expedicion_anyo
			elseif expedicion_anyo_anterior <> expedicion_anyo or expedicion_codigo_anterior <> expedicion_codigo then
				error_oc = true
			end if
		else
			sin_ordenes_carga = true
		end if
	end if
	i++
loop

if error_oc then
	MessageBox("Error", "No puede mezclar ordenes de carga en la expedición.")
	return
else
	if ordenes_carga > 0 and sin_ordenes_carga then
		MessageBox("Error", "No puede expedir materiales que no estén incluidos en la orden de carga. Contacte con almacén.")
		return
	end if
	
	if ordenes_carga > 0 then
		 SELECT COUNT(*) 
		 INTO :total_lineas_oc 
		 FROM orden_carga_linea INNER JOIN orden_carga ON orden_carga.empresa = orden_carga_linea.empresa AND orden_carga.anyo = orden_carga_linea.anyo AND orden_carga.codigo = orden_carga_linea.codigo 
		 WHERE orden_carga.empresa           = :codigo_empresa 
		 AND   orden_carga.expedicion_anyo   = :expedicion_anyo 
		 AND   orden_carga.expedicion_codigo = :expedicion_codigo;
		 
		 if total_lineas_oc <> ordenes_carga then
			MessageBox("Error", "Debe seleccionar todas las lineas de la orden de carga para expedir.")
			return
		end if		 
	end if
end if

dw_pedido.SetRedraw(FALSE)

dw_pedido.Retrieve(codigo_empresa,em_cliente.text)

total_marcado = dw_temporal.RowCount()
if total_marcado = 0 or isnull(total_marcado) then
	messagebox("Atención","No hay nada marcado")
	return
end if

For t = 1 To dw_pedido.RowCount()
//	IF dw_pedido.GetItemString(t,"venliped_situacion") = "F" Then dw_pedido.SetItem(t,"cmarcado","")

	IF dw_pedido.GetItemString(t,"cmarcado") <> "F" and not error_oc Then
 		   dw_pedido.SetItem(t,"cmarcado","X")
			var_anyo        = dw_pedido.GetItemNumber(t,"venliped_anyo")
			var_pedido      = dw_pedido.GetItemNumber(t,"venliped_pedido")
			var_linea       = dw_pedido.GetItemNumber(t,"venliped_linea")
			var_referencia  = dw_pedido.GetItemSTring(t,"venliped_referencia")
			var_tipo_pallet = dw_pedido.GetItemString(t,"venliped_tipo_pallet")
			var_caja        = dw_pedido.GetItemString(t,"venliped_caja")
			var_tipolinea   = dw_pedido.GetItemString(t,"venliped_tipolinea")
			var_tipo_unidad = dw_pedido.GetItemString(t,"venliped_tipo_unidad")
			var_metros_caja = dw_pedido.GetItemNumber(t,"almartcajas_metroscaja")
			var_piezas_caja = dw_pedido.GetItemNumber(t,"almartcajas_piezascaja")
			
			calibre = dw_pedido.GetItemNumber(t,"venliped_calibre")
			calidad = dw_pedido.GetItemString(t,"venliped_calidad")
			tono = dw_pedido.GetItemString(t,"venliped_tonochar")
			formato = dw_pedido.GetItemString(t,"venliped_formato")
			
			articulo = dw_pedido.GetItemString(t,"venliped_articulo")
			
			n =  dw_temporal.find("anyo=" + String(var_anyo,"####") + "and pedido=" + String(var_pedido,"###############") + "and linea=" + String(var_linea,"############"),1,dw_temporal.RowCount())

			IF IsNULL(n) Then n = 0
			IF n = 0 Then
				dw_pedido.SetItem(t,"cok","N")
			ELSE
				
				var_cantidad          = round(dw_temporal.GetItemNumber(n,"cantidad"), ftc_decimales_articulo(codigo_empresa, articulo))//dw_pedido.object.venliped_cantidad[t]//
				var_cantidad_pzs      = dw_temporal.GetItemNumber(n,"cantidad_pzs")
				var_cajas             = dw_temporal.GetItemNumber(n,"cajas")// f_cajas_cantidad_tipolin(codigo_empresa,articulo,var_tipo_pallet,var_caja,var_cantidad,var_tipolinea)
				var_total_cajas       = dw_temporal.GetItemNumber(n,"total_cajas")//f_total_cajas_cantidad_tipolin(codigo_empresa,articulo,var_tipo_pallet,var_caja,var_cantidad,var_tipolinea)
				var_pallets           = dw_temporal.GetItemNumber(n,"pallets")//f_pallets_cantidad_tipolin(codigo_empresa,articulo,var_tipo_pallet,var_caja,var_cantidad,var_tipolinea)
								
				var_peso_bruto_linea  = dw_temporal.GetItemNumber(n,"peso_bruto") // f_calculo_peso(codigo_empresa,articulo,var_tipo_pallet,var_cajas,var_total_cajas,var_pallets,var_cantidad,var_caja)
				var_peso_neto_linea   = dw_temporal.GetItemNumber(n,"peso_neto") //f_calculo_peso_neto(codigo_empresa,articulo,var_cajas,var_total_cajas,var_cantidad,var_caja)				

				//  Sustituyo esta línea por la de abajo porque para mí siempre será la misma cantidad la que tengamos que expedir que la que tengamos que facturar.
//				var_cantidad_facturar = dw_temporal.GetItemNumber(n,"cantidad_facturar")
				var_cantidad_facturar = round(var_cantidad, ftc_decimales_articulo(codigo_empresa, articulo))
				//Esto se hacia asi antes de los bultos		
				dw_pedido.SetItem(t,"venliped_cantidad",var_cantidad)
				dw_pedido.SetItem(t,"venliped_cantidad_pzs",var_cantidad_pzs)
				dw_pedido.SetItem(t,"venliped_pallets",var_pallets)
				dw_pedido.SetItem(t,"venliped_cajas",var_cajas)
				dw_pedido.SetItem(t,"venliped_total_cajas",var_total_cajas)
				//Esto se hacia asi antes de los bultos
				dw_pedido.SetItem(t,"venliped_cantidad_facturar",var_cantidad_facturar)
				dw_pedido.SetItem(t,"venliped_peso",var_peso_bruto_linea)
				dw_pedido.SetItem(t,"venliped_peso_neto",var_peso_neto_linea)
				
				IF f_control_almacen_ventipolin(codigo_empresa,var_tipolinea) = "S" and (not isnull(articulo) and articulo <> "") then
					
					f_mostrar_bultos_linea(dw_pedido,t)
					
				END IF
				//dw_pedido.SetItem(t,"cubicacion",var_ubicacion)				
			END IF
		END IF		
NEXT
dw_pedido.SetFilter("cok = 'S'")
dw_pedido.Filter()
dw_pedido.sort()
f_calcula_albaranes_a_generar()
dw_pedido.sort()
dw_pedido.groupcalc()
dw_pedido.SetRedraw(TRUE)
cb_1.visible = FALSE
pb_1.visible = FALSE
cb_informacion.visible = FALSE
f_campos(TRUE)
em_albaran.text = ""
//dw_pedido.SetSort("suborden,venliped_deposito,venped_agrupa_exp,venliped_anyo,venliped_pedido,venliped_linea")
dw_pedido.Sort()
dw_pedido.SetRow(1)
dw_pedido.SelectRow(0,FALSE)
dw_pedido.SelectRow(1,TRUE)
//dw_pedido.SetFilter("cok = 'S'")
//dw_pedido.Filter()
//dw_pedido.SetRedraw(TRUE)
//cb_1.visible = FALSE
//pb_1.visible = FALSE
//cb_informacion.visible = FALSE
//f_campos(TRUE)
//em_albaran.text = ""
////dw_pedido.SetSort("suborden,venliped_deposito,venped_agrupa_exp,venliped_anyo,venliped_pedido,venliped_linea")
//dw_pedido.Sort()
//f_calcula_albaranes_a_generar()
//dw_pedido.SetRow(1)
//dw_pedido.SelectRow(0,FALSE)
//dw_pedido.SelectRow(1,TRUE)


end event

type dw_etiqueta_agencia from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 3163
integer y = 20
integer width = 169
integer height = 140
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_list_etiquetas_agencia"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_informacion from commandbutton within w_expedir_pedidos_new
integer x = 4677
integer y = 2832
integer width = 334
integer height = 124
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Información"
end type

event clicked;String var_tipo_pallet,var_caja
String var_almacen_de_carga
Dec{2} var_pallets,var_cajas,total_marcado,var_peso,var_peso_tot,peso_pallet,var_peso_linea
Dec var_cantidad
Long   t,var_numpalet,var_pallets_tot,numpallets[],limite

total_marcado = dw_temporal.RowCount()
if total_marcado = 0 or isnull(total_marcado) then
	messagebox("Atención","No hay nada marcado")
	return
end if

var_peso        = 0		
var_peso_tot    = 0
var_cantidad    = 0
var_cajas       = 0
var_pallets_tot = 0

For t = 1 To dw_detalle.RowCount()
	
	IF dw_detalle.GetItemString(t,"marcado") = "X" Then
		var_numpalet    = dw_detalle.GetItemNumber(t,"venliped_numpalet")
		var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
		
		select peso
		into :peso_pallet
		from pallets
		where empresa = :codigo_empresa and
				codigo  = :var_tipo_pallet;
				
		if isnull(peso_pallet) then peso_pallet = 0
		var_peso        = var_peso + dw_detalle.GetItemNumber(t,"venliped_peso")			
		var_peso_linea  = dw_detalle.GetItemNumber(t,"venliped_peso")			
		var_peso_tot    = var_peso_tot + var_peso_linea + peso_pallet
		var_cantidad    = var_cantidad + dw_detalle.GetItemNumber(t,"venliped_cantidad")
		var_cajas       = var_cajas + dw_detalle.GetItemNumber(t,"venliped_total_cajas")
		
		if (var_numpalet <> 0) and (not isnull(var_numpalet)) then
			limite = upperbound(numpallets)
			if var_numpalet > limite then
				var_pallets_tot = var_pallets_tot + 1
				numpallets[var_numpalet] = 1
			else
				if isnull(numpallets[var_numpalet]) or (numpallets[var_numpalet] = 0) then
					var_pallets_tot = var_pallets_tot + 1
					numpallets[var_numpalet] = 1
				end if
			end if
		end if
	END IF		
NEXT

dw_infor.insertrow(1)
dw_infor.SetItem(1,"peso_mer",var_peso)
dw_infor.SetItem(1,"peso_tot",var_peso_tot)
dw_infor.SetItem(1,"pallets_tot",var_pallets_tot)
dw_infor.SetItem(1,"cajas_tot",var_cajas)
dw_infor.SetItem(1,"piezas_tot",var_cantidad)
dw_detalle.enabled = FALSE
cb_informacion.enabled = FALSE
cb_1.enabled = FALSE
dw_infor.enabled   = TRUE
dw_infor.visible   = TRUE
dw_infor.SetFocus()
end event

type dw_consulta from u_datawindow_consultas within w_expedir_pedidos_new
boolean visible = false
integer x = 41
integer y = 308
integer width = 320
integer height = 1584
integer taborder = 0
string dataobject = "dw_expedir_pedidos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF This.GetRow() = 0 Then Return
	Dec anyo,pedido
anyo    = This.GetItemNumber(currentrow,"anyo")
pedido  = This.GetItemNumber(currentrow,"pedido")
dw_detalle.Retrieve(codigo_empresa,anyo,pedido)

end event

event retrieveend;call super::retrieveend;Dec anyo,pedido
IF RowCOunt() = 0 Then Return
anyo    = This.GetItemNumber(1,"anyo")
pedido  = This.GetItemNumber(1,"pedido")
IF This.RowCOUNT() <> 0 Then
	dw_detalle.Retrieve(codigo_empresa,anyo,pedido)
	SetRow(1)
END IF
end event

type dw_temporal from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 41
integer y = 1392
integer width = 1701
integer height = 660
string dataobject = "dw_expedicion_pedidos3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_albaranes from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 1874
integer y = 1564
integer width = 910
integer height = 484
string dataobject = "dw_int_preparacion_ordenes5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	Reset()
	visible = FALSE
	em_albaran.text = "0"
END IF
end event

event doubleclicked;IF row = 0 Then Return
em_albaran.text = String(GetItemNumber(row,"albaran"))
observaciones = f_observaciones_venalb(codigo_empresa,GetItemNumber(row,"anyo"),GetItemNumber(row,"albaran"))
em_fecha.text = String(Date(f_fentrega_venalb(codigo_empresa,GetItemNumber(row,"anyo"),Dec(em_albaran.text))))
Reset()
visible= FALSE
end event

type sle_articulo from singlelineedit within w_expedir_pedidos_new
integer x = 2181
integer y = 168
integer width = 1737
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;f_filtrar()
end event

type dw_ubicaciones from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 978
integer y = 540
integer width = 2030
integer height = 564
boolean titlebar = true
string title = "Asignacion de Ubicaciones."
string dataobject = "dw_expedicion_pedidos4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String ubi,var_zona,var_almacen, articulo, familia
Dec var_fila,var_altura,var_pedido, var_cantidad, var_cantidad_facturar

Dec var_anyo,var_orden,var_linea
IF row = 0 Then Return
IF dw_pedido.GetRow()= 0 Then Return
IF dw_pedido.GetItemString(dw_pedido.GetRow(),"venliped_situacion") = "P" Then Return
IF not isnull(dw_pedido.GetItemString(dw_pedido.GetRow(),"orden_carga_almacen_destino")) and dw_pedido.GetItemString(dw_pedido.GetRow(),"orden_carga_almacen_destino") <> "" Then 
	MessageBox("Error", "El material se ha preparado mediante una orden de preparación. No puede cambiar la ubicación.")
	Return
end if

var_almacen  = this.GetItemString(row,"almacenmovimientos_almacen")
var_zona     = this.GetItemString(row,"almacenmovimientos_zona")
var_fila     = this.GetItemNumber(row,"almacenmovimientos_fila")
var_altura   = this.GetItemNumber(row,"almacenmovimientos_altura")
var_cantidad = dec(this.GetItemNumber(row,"cantidad_unidad"))
var_cantidad_facturar = dw_pedido.GetItemNumber(dw_pedido.GetRow(),"venliped_cantidad_facturar")

if var_cantidad_facturar > var_cantidad then
	f_mensaje("Error en datos","Cantidad insuficiente")
	return
end if

//No se puede elegir material de P que esté ubicado en Muelle de distribución (Preparado con órdenes de carga)
//articulo = dw_pedido.object.venliped_articulo[dw_pedido.GetRow()]
//SELECT familia INTO :familia 
//FROM articulos 
//WHERE empresa = :codigo_empresa AND codigo = :articulo;
//if isnull(familia) then familia = "" 
if var_zona = "P" and var_fila >= 10 then
	MessageBox("Error", "No puede expedir material del muelle de distribución (1 P fila >= 10) que puede estar ya reservado. Contacte con almacén.")
	return
end if

IF f_ubi_exist(codigo_empresa,var_almacen,var_zona,var_fila,var_altura) Then
	//ALMACEN NUEVO 2014
	//ubi = f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura)
   	//dw_pedido.SetItem(dw_pedido.GetRow(),"cubicacion",ubi)
	dw_pedido.SetItem(dw_pedido.GetRow(),"almacen",var_almacen)
	dw_pedido.SetItem(dw_pedido.GetRow(),"zona",var_zona)
	dw_pedido.SetItem(dw_pedido.GetRow(),"fila",var_fila)
	dw_pedido.SetItem(dw_pedido.GetRow(),"altura",var_altura)
		Commit;
ELSE
	f_mensaje("Error en datos","La ubicacion no existe")
END IF
This.visible = FALSE
dw_pedido.enabled = TRUE

end event

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	dw_ubicaciones.visible = FALSE
	dw_pedido.enabled = TRUE
END IF
end event

type dw_infor from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 1216
integer y = 352
integer width = 1134
integer height = 952
boolean titlebar = true
string title = "Información"
string dataobject = "dw_informacion"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	This.visible = FALSE
	This.Reset()
	cb_informacion.enabled = TRUE
	cb_1.enabled = TRUE
	dw_detalle.enabled = TRUE
END IF

end event

type dw_1 from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 402
integer y = 580
integer width = 1115
integer height = 360
string dataobject = "dw_ubicaciones_articulo_nuevo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
case "pb_cerrar"
	this.visible = false
	dw_pedido.enabled = true
end choose	
end event

event doubleclicked;if row > 0 then
	dw_pedido.setitem(dw_pedido.getrow(),"venliped_tonochar",this.getitemstring(row,"tono"))
	dw_pedido.setitem(dw_pedido.getrow(),"venliped_calibre",this.getitemnumber(row,"calibre"))
	//dw_pedido.setitem(dw_pedido.getrow(),"venliped_referencia",this.getitemstring(row,"referencia"))
	dw_pedido.setitem(dw_pedido.getrow(),"venliped_referencia","")
	dw_pedido.accepttext()
end if
end event

type orden_codigo from editmask within w_expedir_pedidos_new
integer x = 4032
integer y = 168
integer width = 576
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "###############"
end type

event modified;int j
string situacion
boolean exito

exito = true


dw_detalle.Retrieve(codigo_empresa,em_cliente.text,long(orden_codigo.text))

for j = 1 to dw_detalle.rowcount()
    situacion = dw_detalle.object.venliped_situacion[j]
    IF situacion <> "P" then
		 timer(1)
		 exito = false
    end if
next

if exito = true then timer(0)
end event

type gb_1 from groupbox within w_expedir_pedidos_new
integer x = 3986
integer y = 92
integer width = 667
integer height = 192
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Orden de Carga"
end type

type gb_2 from groupbox within w_expedir_pedidos_new
integer x = 46
integer y = 96
integer width = 2075
integer height = 192
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cliente"
end type

type gb_3 from groupbox within w_expedir_pedidos_new
integer x = 2135
integer y = 96
integer width = 1833
integer height = 192
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Artículo"
end type

type st_1 from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 2670
integer y = 2828
integer width = 1385
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = "Con Nº de copias igual a 0 no se imprimirá el albarán"
boolean focusrectangle = false
end type

type pb_3 from picturebutton within w_expedir_pedidos_new
integer x = 5193
integer y = 100
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;if dw_pedido.rowcount() > 0 then
	
	dw_pedido.modify("expedir.visible = 0")
	dw_pedido.modify("salir.visible = 0")
	dw_pedido.modify("t_27.visible = 0")
	dw_pedido.modify("t_28.visible = 0")
	
	f_imprimir_datawindow(dw_pedido)
	
	dw_pedido.modify("expedir.visible = 1")
	dw_pedido.modify("salir.visible = 1")
	dw_pedido.modify("t_27.visible = 1")
	dw_pedido.modify("t_28.visible = 1")
end if
	
end event

type st_cmr from statictext within w_expedir_pedidos_new
boolean visible = false
integer x = 1979
integer y = 2816
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Nº CMR"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cmr from u_em_campo within w_expedir_pedidos_new
boolean visible = false
integer x = 1979
integer y = 2884
integer width = 247
integer height = 80
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

type dw_listado_cmr from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 5143
integer width = 183
integer height = 112
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "CMR"
string dataobject = "report_list_cmr"
boolean livescroll = true
end type

type dw_listado_vgm from datawindow within w_expedir_pedidos_new
boolean visible = false
integer x = 5335
integer width = 183
integer height = 112
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "VGM"
string dataobject = "dw_report_vgm"
boolean livescroll = true
end type

type dw_pedido from u_datawindow_consultas within w_expedir_pedidos_new
boolean visible = false
integer x = 41
integer y = 304
integer width = 5906
integer height = 2484
integer taborder = 0
string dataobject = "dw_expedicion_pedidos5_new"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Long i,j
Dec     var_anyo,var_pedido,var_linea,var_cajas,var_pallets,var_total_cajas,t,var_hornos,var_calibre, var_cantidad, stock, var_fila, var_altura, cantidad_lineas
String  var_articulo,var_nombre,var_familia,var_formato,var_modelo,var_calidad,var_tono,var_sector,var_tipo_unidad,var_marcado
String  var_caja,var_tipo_pallet
String var_almacen, var_zona, var_tipolinea

IF f_objeto_datawindow(This) = "salir" Then
	// Santiago.14/12/00. Movimiento automático de hornos
	FOR t = 1 TO dw_detalle.RowCount()
		var_hornos  = dw_detalle.GetItemNumber(t,"hornos")
		var_marcado = dw_detalle.GetItemString(t,"marcado")
		if var_hornos <> 0 and var_marcado = "X" then
			var_articulo    = dw_detalle.GetItemString(t,"venliped_articulo")
			var_nombre      = dw_detalle.GetItemString(t,"venliped_descripcion")
			var_calidad     = dw_detalle.GetItemString(t,"venliped_calidad")
			var_tono        = dw_detalle.GetItemString(t,"venliped_tonochar")
			var_calibre     = dw_detalle.GetItemNumber(t,"venliped_calibre")
			var_caja        = dw_detalle.GetItemString(t,"venliped_caja")
			var_tipo_unidad = dw_detalle.GetItemString(t,"venliped_tipo_unidad")
			var_tipo_pallet = dw_detalle.GetItemString(t,"venliped_tipo_pallet")
			var_formato = dw_detalle.GetItemString(t,"venliped_formato")

			select familia, modelo, sector
			into   :var_familia, :var_modelo, :var_sector
			from   articulos
			where  empresa = :codigo_empresa and
					 codigo  = :var_articulo;
			if not f_salida_regularizacion(var_hornos,var_articulo,var_calidad,var_tono,var_calibre,var_caja,var_tipo_unidad,var_tipo_pallet,var_familia,var_formato,var_modelo,var_sector) then 
				 f_mensaje("Error","No se ha realizado el movimiento automático en almacén")
				 return
			end if
		end if
	NEXT
// Santiago.14/12/00. Movimiento automático de hornos

 	f_salir2()
 	Return
END IF



//var_anyo_albaran = Year(Today())
var_anyo_albaran = year(date(em_fecha.text))
IF f_objeto_datawindow(This) = "expedir" Then
	IF Trim(uo_operario.em_codigo.text) = "" Then
		f_mensaje("Campo Obligatorio","Introduzca el Operario")
		f_activar_campo(uo_operario.em_campo)
		Return
	END IF
	
	//Control stock
	For i = 1 to dw_pedido.rowcount()
		var_almacen = dw_pedido.object.almacen[i]
		var_zona = dw_pedido.object.zona[i]
		var_fila = dw_pedido.object.fila[i]
		var_altura = dw_pedido.object.altura[i]
		var_articulo = dw_pedido.object.venliped_articulo[i]
		var_calidad = dw_pedido.object.venliped_calidad[i]
		var_tono = dw_pedido.object.venliped_tonochar[i]
		var_calibre = dw_pedido.object.venliped_calibre[i]
		var_cantidad = dw_pedido.object.venliped_cantidad_facturar[i]
		var_tipolinea = dw_pedido.object.venliped_tipolinea[i]
		var_formato = dw_pedido.object.venliped_formato[i]
		
		//No contemplar los artículos sin código o sin control de stock
		if f_control_almacen_ventipolin(codigo_empresa,var_tipolinea) = "S" and (not isnull(var_articulo) and var_articulo <> "") then
			/*
			stock = 0
			SELECT SUM(cantidade - cantidads) INTO :stock 		
			FROM almacenmovimientos 
			WHERE empresa = :codigo_empresa AND articulo = :var_articulo AND calidad = :var_calidad AND tono = :var_tono AND calibre = :var_calibre AND formato = :var_formato
			AND almacen = :var_almacen AND zona = :var_zona AND fila = :var_fila AND altura = :var_altura;
			if isnull(stock) then stock = 0
			
			//Se debe comprobar la cantidad total de material que se extrae de la misma ubicación (no solo linea a linea)
			//NO FUNCIONA CORRECTAMENTE, USO BUCLE: cantidad_lineas = dec(this.Describe("Evaluate('sum(if(venliped_articulo = '"+var_articulo+"' and almacen = '"+var_almacen+"' and zona = '"+var_zona+"' and fila = "+String(var_fila)+" and altura = "+String(var_altura)+", venliped_cantidad_facturar, 0))', 0)"))
			cantidad_lineas = 0
			For j = 1 to this.rowcount()
				if var_articulo = dw_pedido.object.venliped_articulo[j] and var_almacen = dw_pedido.object.almacen[j] and var_zona = dw_pedido.object.zona[j] and var_fila = dw_pedido.object.fila[j] and var_altura = dw_pedido.object.altura[j] &
				and var_calidad = dw_pedido.object.venliped_calidad[j] and var_tono = dw_pedido.object.venliped_tonochar[j] and var_calibre = dw_pedido.object.venliped_calibre[j] and var_formato = dw_pedido.object.venliped_formato[j] then
					cantidad_lineas += dw_pedido.object.venliped_cantidad_facturar[j]
				end if
			Next 
			
			//if stock < var_cantidad then
			if stock < cantidad_lineas then
				MessageBox("Error", "No hay stock disponible para el articulo "+var_articulo+" en la ubicación seleccionada. Se cancela la expedición.")
				return
			end if
			*/
		end if
	next
	
	dw_pedido.Accepttext()
	//dw_pedido.Update()
	//COMMIT;
 	//IF f_control_existencias() Then f_expedir()
	f_expedir()
   COMMIT;
 	Return
END IF



IF f_objeto_datawindow(This) = "pallet_menos" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_pedido.GetItemNumber(GetRow(),"venliped_anyo")		
		var_pedido = dw_pedido.GetItemNumber(GetRow(),"venliped_pedido")		
		var_linea = dw_pedido.GetItemNumber(GetRow(),"venliped_linea")		
		var_pallets = dw_pedido.GetItemNumber(GetRow(),"venliped_pallets")		
		if var_pallets = 0 or isnull(var_pallets) then return
		Update   venliped
		Set      venliped.pallets = pallets - 1
		Where    venliped.empresa = :codigo_empresa
		And      venliped.anyo    = :var_anyo
		And      venliped.pedido  = :var_pedido
		And      venliped.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"venliped_pallets",var_pallets -1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "pallet_mas" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_pedido.GetItemNumber(GetRow(),"venliped_anyo")		
		var_pedido = dw_pedido.GetItemNumber(GetRow(),"venliped_pedido")		
		var_linea = dw_pedido.GetItemNumber(GetRow(),"venliped_linea")		
		var_pallets = dw_pedido.GetItemNumber(GetRow(),"venliped_pallets")		
		Update   venliped
		Set      venliped.pallets = pallets + 1
		Where    venliped.empresa = :codigo_empresa
		And      venliped.anyo    = :var_anyo
		And      venliped.pedido   = :var_pedido
		And      venliped.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"venliped_pallets",var_pallets +1)
	 	Return
	END IF
END IF


IF f_objeto_datawindow(This) = "caja_mas" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_pedido.GetItemNumber(GetRow(),"venliped_anyo")		
		var_pedido = dw_pedido.GetItemNumber(GetRow(),"venliped_pedido")		
		var_linea = dw_pedido.GetItemNumber(GetRow(),"venliped_linea")		
		var_cajas = dw_pedido.GetItemNumber(GetRow(),"venliped_cajas")		
		var_total_cajas = dw_pedido.GetItemNumber(GetRow(),"venliped_total_cajas")		
		Update   venliped
		Set      venliped.cajas = cajas + 1,
		         venliped.total_cajas = total_cajas + 1
		Where    venliped.empresa  = :codigo_empresa
		And      venliped.anyo     = :var_anyo
		And      venliped.pedido   = :var_pedido
		And      venliped.linea    = :var_linea;
		Commit;
		SetItem(GetRow(),"venliped_cajas",var_cajas +1)
		SetItem(GetRow(),"venliped_total_cajas",var_total_cajas +1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "caja_menos" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_pedido.GetItemNumber(GetRow(),"venliped_anyo")		
		var_pedido = dw_pedido.GetItemNumber(GetRow(),"venliped_pedido")		
		var_linea = dw_pedido.GetItemNumber(GetRow(),"venliped_linea")		
		var_cajas = dw_pedido.GetItemNumber(GetRow(),"venliped_cajas")		
		var_total_cajas = dw_pedido.GetItemNumber(GetRow(),"venliped_total_cajas")		
      if var_total_cajas = 0 or isnull(var_total_cajas) then return
		Update   venliped		
		Set      venliped.cajas = cajas - 1,
		         venliped.total_cajas = total_cajas - 1
		Where    venliped.empresa = :codigo_empresa
		And      venliped.anyo    = :var_anyo
		And      venliped.pedido   = :var_pedido
		And      venliped.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"venliped_cajas",var_cajas -1)
		SetItem(GetRow(),"venliped_total_cajas",var_total_cajas -1)
	 	Return
	END IF
END IF




end event

event doubleclicked;IF row = 0  or IsNull(row)Then return
IF This.GetRow() = 0 Then Return
IF not isnull( this.object.expedicion_codigo[row]) and  this.object.expedicion_codigo[row] <> "" then
	messagebox("Atención","No puede desmarcar un artículo incluido en una orden de carga. Avise al almacén.")
	return
end if
IF f_valor_columna(This,GetRow(),"venliped_situacion") = "F" Then
	messagebox("Atención","Linea a Fabricar "+f_valor_columna(This,GetRow(),"venliped_descripcion"))
END IF
//IF dw_pedido.GetItemString(This.GetRow(),"venliped_situacion") <> "F" Then
IF f_valor_columna(This,GetRow(),"cmarcado") = "X" Then
	This.SetItem(GetRow(),"cmarcado","")
ELSE
	This.SetItem(GetRow(),"cmarcado","X")
END IF
//END IF
end event

event rbuttondown;call super::rbuttondown;String  var_calidad,var_tipo_pallet,var_articulo,var_caja,var_tipolin,var_tonochar, formato, var_tipo_unidad
string  var_almacen_de_carga
Dec{0}  var_tono,var_calibre,var_cantidad_facturar

IF GetRow()= 0 Then Return
IF This.GetItemString(GetRow(),"venliped_situacion") = "P" Then 
	Return
else
	return
	/*Esto ya no se puede hacer
	var_articulo    = This.GetItemString(GetRow(),"venliped_articulo") 
	var_calidad     = This.GetItemString(GetRow(),"venliped_calidad")  
	var_tipo_pallet = This.GetItemString(GetRow(),"venliped_tipo_pallet")  
	var_caja 		 = This.GetItemString(GetRow(),"venliped_caja")  
	var_calibre     = This.GetItemNumber(GetRow(),"venliped_calibre")  
	//var_tono        = This.GetItemNumber(GetRow(),"venliped_tono")  //Antiguo - NOOOOOO
	var_tonochar        = This.GetItemString(GetRow(),"venliped_tonochar")  
	var_tipolin		 = This.GetItemString(GetRow(),"venliped_tipolinea")  
	var_almacen_de_carga  = This.GetItemString(GetRow(),"venliped_almacen_de_carga")  
	var_cantidad_facturar = This.GetItemNumber(GetRow(),"venliped_cantidad_facturar")  
	formato		 = This.GetItemString(GetRow(),"venliped_formato")  
	var_tipo_unidad = This.GetItemString(GetRow(),"venliped_tipo_unidad")  
	this.enabled = FALSE
	
	dw_ubicaciones.visible = TRUE
	dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad,var_tonochar,var_calibre,var_tipo_pallet,var_caja,var_almacen_de_carga, formato,var_tipo_unidad)
	*/
end if
/*
if dw_ubicaciones.rowcount() = 0 then
	dw_ubicaciones.InsertRow(1)
	dw_ubicaciones.SetItem(1,"almalmacen_descripcion","1")
	dw_ubicaciones.SetItem(1,"almacenmovimientos_zona","P")
	dw_ubicaciones.SetItem(1,"almacenmovimientos_fila",1)
	dw_ubicaciones.SetItem(1,"almacenmovimientos_altura",1)
	dw_ubicaciones.SetItem(1,"cantidad",var_cantidad_facturar)
	//dw_ubicaciones.SetItem(1,"almlinubica_pedido","")
end if
*/
/*	
CHOOSE CASE f_objeto_datawindow(This)

	CASE "venliped_tonochar"
		dw_1.retrieve (codigo_empresa,var_articulo,var_calidad,var_tipo_pallet,var_caja,var_almacen_de_carga)
		if dw_1.rowcount() > 0 then
			dw_1.y = ypos 
			dw_1.visible = true
			dw_1.setfocus()
		else
			messagebox ("Atención","No hay existencias del articulo seleccionado")
			this.enabled = true
		end if
	CASE "venliped_calibre"
		dw_1.retrieve (codigo_empresa,var_articulo,var_calidad,var_tipo_pallet,var_caja,var_almacen_de_carga)
		if dw_1.rowcount() > 0 then
			dw_1.y = ypos 	
			dw_1.visible = true
			dw_1.setfocus()
		else
			messagebox ("Atención","No hay existencias del articulo seleccionado")
			this.enabled = true
		end if	
	CASE else	
		dw_ubicaciones.visible = TRUE
		dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre,var_tipo_pallet,var_caja,var_almacen_de_carga,var_tipo_unidad)
		if dw_ubicaciones.rowcount() = 0 then
			dw_ubicaciones.InsertRow(1)
			dw_ubicaciones.SetItem(1,"almalmacen_descripcion","1")
			dw_ubicaciones.SetItem(1,"almacenmovimientos_zona","P")
			dw_ubicaciones.SetItem(1,"almacenmovimientos_fila",1)
			dw_ubicaciones.SetItem(1,"almacenmovimientos_altura",1)
			dw_ubicaciones.SetItem(1,"cantidad",var_cantidad_facturar)
			//dw_ubicaciones.SetItem(1,"almlinubica_pedido","")
		end if
END CHOOSE
*/
end event

type dw_detalle from u_datawindow_consultas within w_expedir_pedidos_new
integer x = 41
integer y = 304
integer width = 5906
integer height = 2484
integer taborder = 30
string dataobject = "dw_expedir_pedidos2_new"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec    pallet,cajas,vanyo,vpedido,total_cajas,vlinea
string marcado
long   var_venliped_cantidad,var_hornos,fila
string var_situacion





if GetRow() = 0 tHEN Return
IF f_objeto_datawindow(This) = "todo" Then
	f_todo()
END IF
	
vanyo    = GetItemNumber(GetRow(),"venliped_anyo")
vpedido  = GetItemNumber(GetRow(),"venliped_pedido")
vlinea   = GetItemNumber(GetRow(),"venliped_linea")

IF f_objeto_datawindow(This) = "pallet_text" Then
	SetSort("")
	This.SetSort("venliped_numpalet")
	This.Sort( )
END IF

IF f_objeto_datawindow(This) = "pedido_text" Then
	SetSort("")
	This.SetSort("venliped_anyo,venliped_pedido,venliped_numpallet,venliped_descripcion")
	This.Sort( )
END IF


IF f_objeto_datawindow(This) = "palletmas" Then
	pallet = GetItemNumber(GetRow(),"venliped_pallets")
	pallet = pallet + 1
	SetItem(GetRow(),"venliped_pallets",pallet)
	Update  venliped
	Set   pallets   = :pallet
	Where empresa   = :codigo_empresa
	And   anyo      = :vanyo
	ANd   pedido    = :vpedido
	And   linea     = :vlinea;
END IF

IF f_objeto_datawindow(This) = "palletmenos" Then
	pallet = GetItemNumber(GetRow(),"venliped_pallets")
	IF pallet <> 0 Then 
			pallet = pallet - 1
			SetItem(GetRow(),"venliped_pallets",pallet)
			Update  venliped
			Set   pallets   = :pallet
			Where empresa   = :codigo_empresa
			And   anyo      = :vanyo
			ANd   pedido    = :vpedido
			And   linea     = :vlinea;
	END IF
END IF


IF f_objeto_datawindow(This) = "cajamenos" Then
	cajas        = GetItemNumber(GetRow(),"venliped_cajas")
	total_cajas = GetItemNumber(GetRow(),"venliped_total_cajas")
	IF cajas <> 0 Then 
			cajas        = cajas - 1
			total_cajas = total_cajas - 1
			SetItem(GetRow(),"venliped_cajas",cajas)
			SetItem(GetRow(),"venliped_total_cajas",total_cajas)
			Update  venliped
			Set   cajas         = :cajas,
			      total_cajas   = :total_cajas
			Where empresa   = :codigo_empresa
			And   anyo      = :vanyo
			ANd   pedido    = :vpedido
			And   linea     = :vlinea;
	END IF
END IF


IF f_objeto_datawindow(This) = "cajamas" Then
	cajas        = GetItemNumber(GetRow(),"venliped_cajas")
	total_cajas = GetItemNumber(GetRow(),"venliped_total_cajas")
				cajas        = cajas + 1
			total_cajas = total_cajas + 1
			SetItem(GetRow(),"venliped_cajas",cajas)
			SetItem(GetRow(),"venliped_total_cajas",total_cajas)
			Update  venliped
			Set   cajas         = :cajas,
			      total_cajas   = :total_cajas
			Where empresa   = :codigo_empresa
			And   anyo      = :vanyo
			ANd   pedido    = :vpedido
			And   linea     = :vlinea;

END IF
IF f_objeto_datawindow(This) = "preparar" Then
		IF  GetRow()= 0 Then Return
		str_parametros lstr_param
		lstr_param.i_nargumentos = 4
		lstr_param.s_argumentos[1]  = "w_expedir_pedidos"
		lstr_param.s_argumentos[2]  = String(GetItemNumber(GetRow(),"venliped_anyo"))
		lstr_param.s_argumentos[3]  = String(GetItemNumber(GetRow(),"venliped_pedido"))
		lstr_param.s_argumentos[4]  = String(GetItemNumber(GetRow(),"venliped_linea"))
		OpenWithParm(w_int_preparacion_pedido,lstr_param)
//		IF  Message.StringParm = "S" Then f_proceso()
END IF
IF f_objeto_datawindow(This) = "horno" Then
	fila = dw_detalle.GetRow()
	if fila = 0 then
		return
	end if
	var_situacion = dw_detalle.GetItemstring(fila,"venliped_situacion")
	if var_situacion = "P" then
		messagebox("Atención","Fila ya PREPARADA")
		return
	else
		tipo_array val,ent
		
		var_hornos   =  GetItemNumber(GetRow(),"venliped_cantidad")
		
		ent.valor[1] = String(GetItemNumber(GetRow(),"venliped_anyo"))
		ent.valor[2] = String(GetItemNumber(GetRow(),"venliped_pedido"))
		ent.valor[3] = String(GetItemNumber(GetRow(),"venliped_linea"))
		ent.valor[4] = GetItemString(GetRow(),"venliped_articulo")
		ent.valor[5] = GetItemString(GetRow(),"venliped_descripcion")
		ent.valor[6] = String(var_hornos,"###,###")
		
		openWithParm(w_pedir_datos_hornos,ent)
		
		val =  message.powerObjectparm
		IF val.valor[1] = "RETURN" Then Return
		var_hornos = dec(val.valor[1])
		var_venliped_cantidad = dw_detalle.GetItemNumber(fila,"venliped_cantidad")
		if var_hornos <> 0 and var_venliped_cantidad <> var_hornos then
			messagebox("Atención","La cantidad de HORNOS es diferente de la cantidad a expedir")
			return
		else
			SetItem(GetRow(),"hornos",var_hornos)
		end if
	end if
END IF

if row=0 then return
marcado = this.GetItemString(row,"marcado")

if marcado = "X" then
	This.SetTabOrder("venliped_pallets",0)	
	This.SetTabOrder("venliped_cajas",0)
	This.SetTabOrder("venliped_cantidad",0)	
else	
//	This.SetTabOrder("venliped_pallets",1)	
//	This.SetTabOrder("venliped_cajas",2)
//	This.SetTabOrder("venliped_cantidad",3)	
	This.SetTabOrder("venliped_pallets",0)	
	This.SetTabOrder("venliped_cajas",0)
	This.SetTabOrder("venliped_cantidad",0)		
End if	



dw_detalle.AcceptText()

COMMIT;
end event

event doubleclicked;long ll_donde,ll_total
string ls_find
boolean lb_recalcular_disponibles = false

if row > 0 then
	
	if dwo.name = 'disponible' and this.object.marcado[row] <> "X" then
		string ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja,ls_situacion
		int    li_anyo,li_linea,li_calibre
		long   ll_pedido
		dec    ld_disponible,ld_cantidad
		
		li_anyo        = this.object.venliped_anyo[row]
		ll_pedido      = this.object.venliped_pedido[row]
		li_linea       = this.object.venliped_linea[row]
		
		ls_articulo    = this.object.venliped_articulo[row]
		ls_calidad     = this.object.venliped_calidad[row]
		ls_tonochar    = this.object.venliped_tonochar[row]
		li_calibre     = this.object.venliped_calibre[row]
		ls_tipo_pallet = this.object.venliped_tipo_pallet[row]
		ls_caja        = this.object.venliped_caja[row]
		ld_cantidad    = this.object.venliped_cantidad[row]
		ls_situacion   = this.object.venliped_situacion[row]
		
		if ls_situacion = 'F' then
			ld_disponible = f_disponible_art_cal_to_ca_tp_c( codigo_empresa , ls_articulo , ls_calidad , ls_tonochar , li_calibre , ls_tipo_pallet , ls_caja )
			
			if ld_disponible >= ld_cantidad then
				update venliped
				set    venliped.situacion = 'C'
				where  venliped.empresa = :codigo_empresa
				and    venliped.anyo    = :li_anyo
				and    venliped.pedido  = :ll_pedido
				and    venliped.linea   = :li_linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
					this.object.venliped_situacion[row] = 'C'
					lb_recalcular_disponibles = true					
				end if
			else
				
			end if
		else
			if ls_situacion = 'C' then
				update venliped
				set    venliped.situacion = 'F'
				where  venliped.empresa = :codigo_empresa
				and    venliped.anyo    = :li_anyo
				and    venliped.pedido  = :ll_pedido
				and    venliped.linea   = :li_linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
					this.object.venliped_situacion[row] = 'F'
					lb_recalcular_disponibles = true
				end if				
			else
				//Situacion 'P' Preparado no hacemos nada
			end if
		end if
		
		if lb_recalcular_disponibles then
			//Recalculamos los disponibles
			ll_total = this.rowcount()
			
			this.object.disponible[row] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[row] ,&
																								this.object.venliped_articulo[row] ,&
																								this.object.venliped_calidad[row] ,&
																								this.object.venliped_tonochar[row] ,&
																								this.object.venliped_calibre[row] ,&
																								this.object.venliped_tipo_pallet[row] ,&
																								this.object.venliped_caja[row] )
																								
			ls_find = "venliped_articulo = '"+this.object.venliped_articulo[row]+"' and "+&
						 "venliped_calidad = '"+this.object.venliped_calidad[row]+"' and "+&
						 "venliped_tonochar = '"+this.object.venliped_tonochar[row]+"' and "+&
						 "venliped_calibre = "+string(this.object.venliped_calibre[row],"0")+" and "+&
						 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[row]+"' and "+&
						 "venliped_caja = '"+this.object.venliped_caja[row]+"' "
						 
			ll_donde = 0
			do
				ll_donde ++
				ll_donde = this.find(ls_find,ll_donde,ll_total)
				if ll_donde > 0 and ll_donde <> row then
					this.object.disponible[ll_donde] = this.object.disponible[row]
				end if
			loop while ll_donde > 0 and ll_donde < ll_total			
			
		end if
	else
		f_control_marcar_linea(row)
	end if
end if




end event

event retrieveend;call super::retrieveend;Integer t,n
Dec{0}  var_pedido,var_linea,var_anyo,var_cantidad,var_pallets,var_cajas,var_total_cajas
IF RowCount() = 0 Then return
For t = 1 To RowCount()
	var_anyo  = GetItemNumber(t,"venliped_anyo")
	var_pedido = GetItemNumber(t,"venliped_pedido")
	var_linea = GetItemNumber(t,"venliped_linea")
	n =  dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
	IF n<> 0 Then
		SetItem(t,"marcado","X")
		var_cantidad = dw_temporal.GetItemNumber(n,"cantidad")
		var_pallets  = dw_temporal.GetItemNumber(n,"pallets")
		var_cajas    = dw_temporal.GetItemNumber(n,"cajas")
		var_total_cajas    = dw_temporal.GetItemNumber(n,"total_cajas")
		SetItem(t,"venliped_cantidad", var_cantidad)
		SetItem(t,"venliped_pallets",  var_pallets)
		SetItem(t,"venliped_cajas",    var_cajas)
		SetItem(t,"venliped_total_cajas",  var_total_cajas)
	END IF
NEXT

long ll_indice,ll_total,ll_donde
string ls_find

ll_total = RowCount() //rowcount 

for ll_indice = 1 to ll_total
	if this.object.disponible[ll_indice] = -1 then
		this.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c( this.object.venliped_empresa[ll_indice] ,&
																							this.object.venliped_articulo[ll_indice] ,&
																							this.object.venliped_calidad[ll_indice] ,&
																							this.object.venliped_tonochar[ll_indice] ,&
																							this.object.venliped_calibre[ll_indice] ,&
																							this.object.venliped_tipo_pallet[ll_indice] ,&
																							this.object.venliped_caja[ll_indice] )
																							
		ls_find = "venliped_articulo = '"+this.object.venliped_articulo[ll_indice]+"' and "+&
					 "venliped_calidad = '"+this.object.venliped_calidad[ll_indice]+"' and "+&
					 "venliped_tonochar = '"+this.object.venliped_tonochar[ll_indice]+"' and "+&
					 "venliped_calibre = "+string(this.object.venliped_calibre[ll_indice],"0")+" and "+&
					 "venliped_tipo_pallet = '"+this.object.venliped_tipo_pallet[ll_indice]+"' and "+&
					 "venliped_caja = '"+this.object.venliped_caja[ll_indice]+"' "
					 
		ll_donde = ll_indice																					
		do
			ll_donde ++
			ll_donde = this.find(ls_find,ll_donde,ll_total)
			if ll_donde > 0 then
				this.object.disponible[ll_donde] = this.object.disponible[ll_indice]
			end if
		loop while ll_donde > 0 and ll_donde < ll_total
	end if
next

f_filtrar()
end event

event key;call super::key;Int row
string     cadena,var_articulo,var_tipo_pallet,var_caja,control_pico, var_tipo_unidad
Dec{0}     var_pallets,var_cajas,var_total_cajas,var_pallets_ant
Dec     var_cantidad,var_cantidad_facturar
long       var_anyo,var_pedido,posi,posi_aux

row = GetRow()
if row > 0 then
	if key = KeyTab! and GetItemString(row,"venliped_articulo") <> '' Then
		 AccepTtext()
		 var_anyo        =  GetItemNumber(row,"venliped_anyo")
		 var_pedido      =  GetItemNumber(row,"venliped_pedido")
		 var_pallets     =  GetItemNumber(row,"venliped_pallets")
		 var_cajas       =  GetItemNumber(row,"venliped_cajas")
		 var_cantidad    =  GetItemDecimal(row,"venliped_cantidad")
		 var_articulo    =  GetItemString(row,"venliped_articulo")
		 var_tipo_pallet =  GetItemString(row,"venliped_tipo_pallet")
		 var_caja        =  GetItemString(row,"venliped_caja")
		 control_pico    =  GetItemString(row,"venliped_es_pico")
		 var_tipo_unidad    =  GetItemString(row,"venliped_tipo_unidad")
		
		 if control_pico = "S" then 
			 var_pallets_ant = var_pallets
			 var_pallets = 0
		 End if
	
		 IF GetColumnName() = "venliped_cantidad" Then 
			var_pallets = 0
			var_cajas   = 0
		 END IF
		 
		 cadena=f_calculo_unidades_tipolin(codigo_empresa,var_articulo,&
											 var_tipo_pallet,var_caja,&
											 var_pallets,&
											 var_cajas,&
											 var_cantidad, var_tipo_unidad)
											 
		 posi_aux = 1
			posi = pos(cadena,"|",1)
			if posi <> 0 then
				var_pallets     = dec(Mid(cadena,1,posi - 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <> 0 then
				var_cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				var_total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				var_cantidad   = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if										 
									  
		 
		 if control_pico = "S" then var_pallets = var_pallets_ant
		 
		 SetItem(row,"venliped_pallets",var_pallets)
		 SetItem(row,"venliped_cajas",var_cajas)
		 SetItem(row,"venliped_total_cajas",var_total_cajas)
		 SetItem(row,"venliped_cantidad",var_cantidad)
		 
		var_cantidad_facturar = var_cantidad 
		
		if f_facturar_metros_reales_venped(codigo_empresa,var_anyo,var_pedido) = "S" then 
			if f_unidad_articulo(codigo_empresa,var_articulo) = "1" then
			var_cantidad_facturar = f_cantidad_facturar_articulo(codigo_empresa,&
												  var_articulo,&
												  var_caja,&
												  var_cantidad)
			end if	 
		end if
		SetItem(row,"venliped_cantidad_facturar",var_cantidad_facturar)
	END IF
end if
end event

event itemchanged;call super::itemchanged;string v_separar_bultos
dec piezas_pallet
long fila

if dwo.name = "venliped_cantidad" then
	str_venliped venliped
	
	f_cargar_str_venliped(codigo_empresa,this.object.venliped_anyo[row],this.object.venliped_pedido[row],this.object.venliped_linea[row],venliped)
	
	if isnull(venliped.articulo) then venliped.articulo = ""
	
	select separar_bultos
	into :v_separar_bultos
	from venclientes
	where empresa = :codigo_empresa
	and codigo = :em_cliente.text;
	
	//dw_detalle.accepttext()
	fila = row//dw_detalle.getrow()
	if v_separar_bultos = 'S' and trim(venliped.articulo) <> "" then
		piezas_pallet = f_piezas_por_pallet (dw_detalle.object.venliped_articulo[fila], &
									dw_detalle.object.venliped_caja[fila], &
									dw_detalle.object.venliped_tipo_pallet[fila])
									
		if dec(data) > piezas_pallet then
			messagebox("ATENCIÓN", "NO SE PUEDE PONER UNA CANTIDAD SUPERIOR A LA DE UN PALLET. ~n            INTRODUCIR UNA NUEVA LÍNEA DE PEDIDO")
			dw_detalle.setfocus()
			dw_detalle.SetRow(fila)
			dw_detalle.SetColumn("venliped_cantidad")
			return 2
		end if
	end if
		
	dec    cantidad_actualizar,ld_cantidad_original_linea
	long   posi_aux,posi,ll_nueva_linea
	string cadena
	
	
	cantidad_actualizar = dec(data)
	
	ld_cantidad_original_linea = this.object.venliped_cantidad[row]

	if cantidad_actualizar < ld_cantidad_original_linea then
		//Dividimos la linea
		ll_nueva_linea = f_dividir_linea_venliped (codigo_empresa, venliped.anyo, venliped.pedido, venliped.linea, (ld_cantidad_original_linea - cantidad_actualizar))
		if ll_nueva_linea <> 0 then
			commit using sqlca;
			
			if f_cargar_str_venliped(codigo_empresa,this.object.venliped_anyo[row],this.object.venliped_pedido[row],ll_nueva_linea,venliped) then
				this.object.venliped_pallets[row] = venliped.pallets
				this.object.venliped_total_cajas[row] = venliped.total_cajas
				this.object.venliped_cajas[row] = venliped.cajas
				this.object.venliped_linea[row] = venliped.linea
				this.object.venliped_es_pico[row] = venliped.es_pico
				this.object.venliped_cantidad_facturar[row] = venliped.cantidad_facturar
				this.object.venliped_peso[row] = venliped.peso
			else
				messagebox("Error","No se puede cargar la nueva linea")
				return 2
			end if
		else
			rollback using sqlca;
			return 2
		end if		
	else
		//Añadimos cantidad
		cadena = f_calculo_unidades_tipolin(venliped.empresa,venliped.articulo,&
										 venliped.tipo_pallet,&
										 venliped.caja,&
										 0,&
										 0,&
										 cantidad_actualizar,&
										 venliped.tipolinea)
		
		posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			venliped.pallets = dec(Mid(cadena,1,posi - 1))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			venliped.cajas = dec(Mid(cadena,posi_aux,posi - posi_aux ))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			venliped.total_cajas = dec(Mid(cadena,posi_aux,posi - posi_aux ))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			cantidad_actualizar = dec(Mid(cadena,posi_aux,posi - posi_aux ))
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			 venliped.metros_lineales = dec(Mid(cadena,posi_aux,posi - posi_aux ))
		end if		
			
		if venliped.cajas > 0 then
			venliped.es_pico = "S"
		else
			venliped.es_pico = "N"
		end if
		
		update venliped
		set    cantidad        		= :cantidad_actualizar,
				 cantidad_facturar 	= :cantidad_actualizar,
				 cantidad_original   = :cantidad_actualizar,
				 pallets         		= :venliped.pallets,
				 total_cajas     		= :venliped.total_cajas,
				 cajas           		= :venliped.cajas,
				 metros_lineales 		= :venliped.metros_lineales,
				 es_pico         		= :venliped.es_pico
		where  empresa = :venliped.empresa
		and    anyo    = :venliped.anyo
		and    pedido  = :venliped.pedido
		and    linea   = :venliped.linea;
	
	
		if sqlca.sqlcode <> 0 then
			rollback;
			return 2
		else
			f_actualizar_linea_venpedido(venliped.empresa,venliped.anyo,venliped.pedido,venliped.linea) 
			commit;
		end if				
	end if
end if

/*
	if actualizar_linea then

	end if
*/
end event

type t_preparado from statictext within w_expedir_pedidos_new
event timer pbm_timer
boolean visible = false
integer x = 521
integer y = 16
integer width = 1431
integer height = 96
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 33554432
string text = "HAY PEDIDOS NO PREPARADOS"
boolean focusrectangle = false
end type

