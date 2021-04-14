$PBExportHeader$w_int_preparacion_ordenes.srw
forward
global type w_int_preparacion_ordenes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_preparacion_ordenes
end type
type st_1 from statictext within w_int_preparacion_ordenes
end type
type em_cliente from u_em_campo within w_int_preparacion_ordenes
end type
type st_nomcliente from statictext within w_int_preparacion_ordenes
end type
type cb_1 from u_boton within w_int_preparacion_ordenes
end type
type uo_almacen_cargas from u_em_campo_2 within w_int_preparacion_ordenes
end type
type st_almacen_cargas from statictext within w_int_preparacion_ordenes
end type
type dw_consulta from u_datawindow_consultas within w_int_preparacion_ordenes
end type
type cb_marcar_todo from u_boton within w_int_preparacion_ordenes
end type
type uo_zona_cargas from u_em_campo_2 within w_int_preparacion_ordenes
end type
type st_zona_cargas from statictext within w_int_preparacion_ordenes
end type
type st_fila_cargas from statictext within w_int_preparacion_ordenes
end type
type em_fila_cargas from u_em_campo within w_int_preparacion_ordenes
end type
type em_altura_cargas from u_em_campo within w_int_preparacion_ordenes
end type
type st_altura_cargas from statictext within w_int_preparacion_ordenes
end type
type st_operario from statictext within w_int_preparacion_ordenes
end type
type uo_operario from u_em_campo_2 within w_int_preparacion_ordenes
end type
type st_fecha from statictext within w_int_preparacion_ordenes
end type
type em_fecha from u_em_campo within w_int_preparacion_ordenes
end type
type st_albaran from statictext within w_int_preparacion_ordenes
end type
type em_albaran from u_em_campo within w_int_preparacion_ordenes
end type
type listar from radiobutton within w_int_preparacion_ordenes
end type
type em_copias from u_em_campo within w_int_preparacion_ordenes
end type
type st_copias from statictext within w_int_preparacion_ordenes
end type
type dw_temporal from datawindow within w_int_preparacion_ordenes
end type
type dw_ubicaciones from datawindow within w_int_preparacion_ordenes
end type
type dw_albaranes from datawindow within w_int_preparacion_ordenes
end type
type dw_orden from u_datawindow_consultas within w_int_preparacion_ordenes
end type
type dw_detalle from datawindow within w_int_preparacion_ordenes
end type
type st_6 from statictext within w_int_preparacion_ordenes
end type
end forward

global type w_int_preparacion_ordenes from w_int_con_empresa
integer width = 2985
integer height = 1680
pb_1 pb_1
st_1 st_1
em_cliente em_cliente
st_nomcliente st_nomcliente
cb_1 cb_1
uo_almacen_cargas uo_almacen_cargas
st_almacen_cargas st_almacen_cargas
dw_consulta dw_consulta
cb_marcar_todo cb_marcar_todo
uo_zona_cargas uo_zona_cargas
st_zona_cargas st_zona_cargas
st_fila_cargas st_fila_cargas
em_fila_cargas em_fila_cargas
em_altura_cargas em_altura_cargas
st_altura_cargas st_altura_cargas
st_operario st_operario
uo_operario uo_operario
st_fecha st_fecha
em_fecha em_fecha
st_albaran st_albaran
em_albaran em_albaran
listar listar
em_copias em_copias
st_copias st_copias
dw_temporal dw_temporal
dw_ubicaciones dw_ubicaciones
dw_albaranes dw_albaranes
dw_orden dw_orden
dw_detalle dw_detalle
st_6 st_6
end type
global w_int_preparacion_ordenes w_int_preparacion_ordenes

type variables
String var_almacen,var_zona,var_almacen_cargas,var_zona_cargas,var_ubicacion_cargas
Dec{0} var_fila,var_altura,var_fila_cargas,var_altura_cargas,paso,nueva_ln_pedido
DateTime var_fecha_carga
Dec{0}  var_anyo_albaran,veces,control_lineas = 0
String  v_deposito,contenedor,precinto,matricula
String observaciones= "",dni=''
Dec peso
Dec var_albaran[]
Dec var_contador= 1
end variables

forward prototypes
public subroutine f_campos (boolean bool)
public subroutine f_salir ()
public subroutine f_proceso ()
public function boolean f_proceso_pedidos (integer elemento)
public function boolean f_grabar_salida (integer elemento)
public function boolean f_grabar_entrada (integer elemento)
public subroutine f_expedir ()
public function boolean f_grabar_albaran (integer reg)
public subroutine f_preparar ()
public function boolean f_pase_carga (integer reg)
public function boolean f_control_existencias ()
public function boolean f_expedir_pedido (integer elemento)
public function boolean f_grabar_salida_ventas (integer elemento)
end prototypes

public subroutine f_campos (boolean bool);dw_orden.visible = bool
st_almacen_cargas.visible = bool
em_altura_cargas.visible  = bool
em_fila_cargas.visible    = bool
st_altura_cargas.visible  = bool
st_zona_cargas.visible    = bool
st_fila_cargas.visible    = bool
st_zona_cargas.visible    = bool
uo_zona_cargas.visible    = bool
uo_almacen_cargas.visible = bool
cb_marcar_todo.visible    = bool
st_operario.visible       = bool
uo_operario.visible       = bool
st_fecha.visible       = bool
em_fecha.visible       = bool
st_albaran.visible       = bool
em_albaran.visible       = bool
listar.visible = bool
st_copias.visible = bool
em_copias.visible = bool
IF bool Then
	em_cliente.enabled = FALSE
	sle_opcion_orden.enabled = FALSE
	em_cliente.TabOrder = 0
	sle_opcion_orden.TabOrder = 0
	f_activar_campo(uo_zona_cargas.em_campo)
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

public subroutine f_salir ();cb_1.visible       = TRUE
 f_campos(FALSE)
 dw_temporal.Reset()
 dw_detalle.Reset()
 dw_consulta.Retrieve(codigo_empresa,em_cliente.text)

end subroutine

public subroutine f_proceso ();
Integer reg,reg1,bien
Dec{0}  var_anyo,var_orden,var_linea

var_almacen_cargas  = uo_almacen_cargas.em_codigo.text
var_zona_cargas     = uo_zona_cargas.em_codigo.text
var_fila_cargas     = Dec(em_fila_cargas.text)
var_altura_cargas   = Dec(em_altura_cargas.text)
IF f_ubi_exist(codigo_empresa,var_almacen_cargas,var_zona_cargas,var_fila_cargas,var_altura_cargas) Then
	var_ubicacion_cargas = f_componer_ubicacion(var_almacen_cargas,var_zona_cargas,var_fila_cargas,var_altura_cargas)
  ELSE
	f_mensaje("Error en datos","La ubicacion  de cargas no existe")
	f_activar_campo(uo_zona_cargas.em_campo)
	Return
END IF
IF Not f_bloquear_almacen(w_int_preparacion_ordenes.title) Then
bien = 0
reg1 = dw_orden.RowCount()
For reg = 1 To reg1

IF f_valor_columna(dw_orden,reg,"marcado")	= "X" Then

var_anyo        = dw_orden.GetItemNumber(reg,"anyo")
var_orden       = dw_orden.GetItemNumber(reg,"orden")
var_linea       = dw_orden.GetItemNumber(reg,"linea")
	UPDATE almlincargas  
   SET ubicacion = :var_ubicacion_cargas  
   WHERE ( almlincargas.empresa = :codigo_empresa ) AND  
         ( almlincargas.anyo    = :var_anyo ) AND  
         ( almlincargas.orden   = :var_orden ) AND  
         ( almlincargas.linea   = :var_linea )   ;
			IF SQLCA.SQLCODE<>0 then bien = 1
	f_mensaje_proceso("Procesando pedidos",reg,reg1)			
	IF Not   f_proceso_pedidos(reg) Then  
		bien   = 1
		f_mensaje("Error","Error procesando pedido")
	END IF
	f_mensaje_proceso("Procesando Salida",reg,reg1)			
	IF Not 	f_grabar_salida(reg)   Then   
		bien   = 1
		f_mensaje("Error","Error al grabar la salida")
	END IF
	f_mensaje_proceso("Procesando Entrada",reg,reg1)			
	IF Not 	f_grabar_entrada(reg)  Then  
		bien   = 1
		f_mensaje("Error","Error al grabar la entrada")
	END IF
END IF

Next 
IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso de datos","No se actualiza" + sqlca.sqlerrtext)
END IF
f_desbloquear_almacen(w_int_preparacion_ordenes.title)
cb_1.TriggerEvent(Clicked!)
END IF
end subroutine

public function boolean f_proceso_pedidos (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido
Dec{0} var_anyo,var_orden,var_linea
string cadena
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga,var_cantidad_carga
Integer var_bien
var_bien = 0
str_venliped linped

var_anyo              = Dec(f_valor_columna(dw_orden,elemento,"anyo"))
var_orden             = Dec(f_valor_columna(dw_orden,elemento,"orden"))
var_linea             = Dec(f_valor_columna(dw_orden,elemento,"linea"))
var_anyo_pedido       = Dec(f_valor_columna(dw_orden,elemento,"anyo_ped"))
var_pedido            = Dec(f_valor_columna(dw_orden,elemento,"pedido"))
var_linea_pedido      = Dec(f_valor_columna(dw_orden,elemento,"linea_ped"))
var_pallets_carga     = Dec(f_valor_columna(dw_orden,elemento,"almlincargas_pallets"))
var_cajas_carga       = Dec(f_valor_columna(dw_orden,elemento,"cajas"))
var_total_cajas_carga = Dec(f_valor_columna(dw_orden,elemento,"total_cajas"))
var_cantidad_carga    = Dec(f_valor_columna(dw_orden,elemento,"cantidad"))

linped.empresa   =   codigo_empresa
linped.anyo      =   var_anyo_pedido
linped.pedido    =   var_pedido
linped.linea     =   var_linea_pedido

  SELECT venliped.empresa, venliped.anyo,         venliped.pedido,venliped.linea,   
         venliped.serie,   venliped.fpedido,      venliped.fentrega,   
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
			venliped.importe,   
         venliped.descuento,venliped.importedto,    venliped.clase,   
         venliped.sector, venliped.agente1,venliped.agente2,   
         venliped.agente3,venliped.comision11,venliped.comision12,   
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
         :linped.serie,  :linped.fpedido, :linped.fentrega,
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
         :linped.usuario,:linped.tipo_pallet,:linped.caja,
			:linped.importe,   
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
 cadena=f_calculo_unidades(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,&
									 linped.caja,&
                            0,&
                            0,&
                            linped.cantidad)
                       
linped.pallets       = Dec(Mid(cadena,1,6))
linped.cajas         = Dec(Mid(cadena,7,6))
linped.total_cajas   = Dec(Mid(cadena,13,6))
linped.cantidad      = Dec(Mid(cadena,19,9))
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
	 cadena=f_calculo_unidades(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,&
                            linped.caja,&
									 0,&
                            0,&
                            linped.cantidad)
                       
	linped.pallets       = Dec(Mid(cadena,1,6))
	linped.cajas         = Dec(Mid(cadena,7,6))
	linped.total_cajas   = Dec(Mid(cadena,13,6))
	linped.cantidad      = Dec(Mid(cadena,19,9))
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
	dw_orden.setitem(elemento,"linea_ped",linped.linea)
	RETURN TRUE
ELSE
	RETURN FALSE
END IF



end function

public function boolean f_grabar_salida (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido,cur_pedido,cur_linea
Dec{0} var_anyo,var_orden,var_linea,contador,var_calibre
string cadena,var_referencia,var_tipo_pallet,var_articulo,var_calidad,&
  cur_observaciones,cur_tipo_pallet,var_ubicacion,var_situacion,v_mas,&
  var_tono
Dec{2} var_cantidad_carga,total_cantidad,cur_existencias,cantidad_pendiente,cantidad_borrada
Integer var_bien

str_almmovhis        movhis
str_almlinubica      ubi
str_almlinubicahis   ubihis

var_bien        = 0
var_tipo_pallet = f_valor_columna(dw_orden,elemento,"tipo_pallet")
var_anyo        = dw_orden.GetItemNumber(elemento,"anyo")
var_orden       = dw_orden.GetItemNumber(elemento,"orden")
var_linea       = dw_orden.GetItemNumber(elemento,"linea")
var_situacion   = dw_orden.GetItemString(elemento,"almlincargas_situacion_pedido")
var_tipo_pallet = dw_orden.GetItemString(elemento,"tipo_pallet")
var_ubicacion   = dw_orden.GetItemString(elemento,"ubicacion")
var_almacen     = f_almacen_ubicacion(var_ubicacion)
var_zona        = f_zona_ubicacion(var_ubicacion)
var_fila        = f_fila_ubicacion(var_ubicacion)
var_altura      = f_altura_ubicacion(var_ubicacion)

var_anyo_pedido       = dw_orden.GeTItemNumber(elemento,"anyo_ped")
var_pedido            = dw_orden.GeTItemNumber(elemento,"pedido")
var_linea_pedido      = dw_orden.GeTItemNumber(elemento,"linea_ped")
var_cantidad_carga    = dw_orden.GeTItemNumber(elemento,"cantidad")
var_articulo          = dw_orden.GeTItemString(elemento,"articulo")
var_calidad           = dw_orden.GeTItemString(elemento,"calidad")
var_tono              = dw_orden.GeTItemString(elemento,"tonochar")
var_calibre           = dw_orden.GeTItemNumber(elemento,"calibre")

// cuando no es del sector
if trim(var_calidad)="0" OR IsNull(var_calidad) then var_calidad = ""
IF IsNull(var_tono)    Then var_tono    = "" 
IF IsNull(var_calibre) Then var_calibre = 0 
var_referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)


//----------------------//
// Grabar Salida almacen//
//----------------------//
 total_cantidad        = var_cantidad_carga
 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Today())
 ubihis.almacen       = var_almacen
 ubihis.articulo      = var_articulo
 ubihis.calidad       = var_calidad
 ubihis.tonochar      = var_tono
 ubihis.calibre       = var_calibre
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = DateTime(today(),now())
 SetNull(ubihis.observaciones )
 ubihis.tipo_pallet   = var_tipo_pallet
 ubihis.sector        = f_sector_articulo(codigo_empresa,var_articulo)
 SetNull(ubihis.nummov)

SELECT articulos.familia,
		 articulos.subfamilia,
		 articulos.formato,
		 articulos.subformato,
		 articulos.modelo,
		 articulos.unidad  
INTO   :ubihis.familia,
		 :ubihis.subfamilia,
		 :ubihis.formato,
		 :ubihis.subformato,
		 :ubihis.modelo,
		 :ubihis.tipo_unidad  
FROM   articulos  
WHERE (articulos.empresa = :ubihis.empresa )
AND	(articulos.codigo  = :ubihis.articulo);

IF SQLCA.SQLCode<>0 THEN 
	var_bien=1
	f_mensaje("Error","Seleccion articulo")
END IF

ubihis.referencia = var_referencia
ubihis.tipomov    =  "204"
ubi.empresa       =  ubihis.empresa
ubi.almacen       =  ubihis.almacen
ubi.articulo      =  ubihis.articulo
ubi.familia       =  ubihis.familia
ubi.subfamilia    =  ubihis.subfamilia
ubi.formato       =  ubihis.formato
ubi.subformato    =  ubihis.subformato
ubi.modelo        =  ubihis.modelo
ubi.calidad       =  ubihis.calidad
ubi.tonochar      =  ubihis.tonochar
ubi.calibre       =  ubihis.calibre
ubi.tipo_pallet   = ubihis.tipo_pallet
ubi.sector        = ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad   =  ubihis.tipo_unidad
ubi.referencia    =  ubihis.referencia
ubi.f_alta        =  DateTime(today(),now())
ubihis.zona       = var_zona
ubihis.fila       = var_fila
ubihis.altura     = var_altura
ubihis.cantidads  = total_cantidad
ubihis.cantidade  = 0

ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
ubi.zona          = ubihis.zona
ubi.fila          = ubihis.fila
ubi.altura        = ubihis.altura
ubi.existencias   = ubihis.cantidade
ubi.ubicacion     = ubihis.ubicacion
ubihis.orden      = f_almparam_numorden(codigo_empresa,Year(Today()))
//-----------------------------------------------------------------------
// Tambien Inserto en el Historico de Movimientos ( la Salida Gobal)
//-----------------------------------------------------------------------
 movhis.empresa   =  ubihis.empresa  
 movhis.almacen   =  ubihis.almacen
 movhis.anyo      =  ubihis.anyo
 movhis.origen    =  "6"
 movhis.articulo  =  ubihis.articulo
 movhis.fechmov   =  ubihis.fecha
 movhis.tipomov   =  ubihis.tipomov
 movhis.cantidade =  0
 movhis.cantidads =  ubihis.cantidads
 movhis.precio    =  0
 movhis.codtercero = em_cliente.text
 movhis.numdoc    = String(var_pedido,"##########")
 movhis.situacion =  "N"
 SetNull(movhis.observaciones)
 SetNull( movhis.punteado)
 movhis.antexist  =    0
 movhis.familia   =  ubihis.familia
 movhis.subfamilia=  ubihis.subfamilia
 movhis.formato   =  ubihis.formato
 movhis.subformato=  ubihis.subformato
 movhis.modelo    =  ubihis.modelo
 movhis.calidad   =  ubihis.calidad
 movhis.tonochar  =  ubihis.tonochar
 movhis.calibre   =  ubihis.calibre
 movhis.tipo_unidad  =  ubihis.tipo_unidad
 movhis.referencia   =  ubihis.referencia
 movhis.f_alta    =  ubihis.f_alta
 movhis.usuario   =  ubihis.usuario
 movhis.tipo_pallet  =  ubihis.tipo_pallet
 movhis.sector    =  ubihis.sector
 movhis.nummov    = f_almparam_nummov(movhis.empresa,Year(Today()))
 // Grabar el movimiento en el histrorico por el total de existencias
   IF NOT f_insert_almmovhis(movhis) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      var_bien=1
   END IF
   IF NOT f_actualiza_nummov(movhis.empresa,Year(Today()),movhis.nummov) THEN
       var_bien=1
		 f_mensaje("Error","Al actualizar almmvohis")
   END IF
 ubihis.nummov = movhis.nummov
//--------------------------------------------------------------------//
//                   la salida global               //
//--------------------------------------------------------------------//
  // En el historico de ubicaciones
   IF NOT f_insert_almlinubicahis(ubihis) THEN  
		var_bien=1
		f_mensaje("Error","Error en insercion linubicahis")
	END IF
   IF NOT f_actualiza_numorden(codigo_empresa,Year(Today()),ubihis.orden) THEN
       var_bien=1
		 f_mensaje("Error","Error al actualizar numero de orden")
   END IF
   
//-------------------Fin insercion movhis salida global  ----------------\\
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------
DataStore dw
String    sel
IF var_situacion = "P" Then
	sel = " Select    *   From almlinubica " +&
		   " Where  empresa  = '" + ubi.empresa   + "'" +&
		   " And    anyo     = " + STRING(var_anyo_pedido,"#####")  +&
		   " And    pedido   = " + STRING(var_pedido,"#####")  +&
		   " And    linped   = " + STRING(var_linea_pedido,"#####")  

ELSE
sel = " Select    *   From almlinubica " +&
		" Where  empresa      = '" + ubi.empresa   + "'" +&
		" And    ubicacion    = '" + ubi.ubicacion + "'" +&
		" And    referencia   = '" + ubi.referencia + "'" +&
		" And    tipo_pallet  = '" + ubi.tipo_pallet + "'" +&
		" And    pedido       is null "
END IF
		
// dw = f_cargar_cursor2(sel)
 f_cargar_cursor_nuevo(sel, dw)
 
 Integer registros,x1
 registros=dw.RowCount()
 cantidad_borrada=0
 IF registros = 0 Then 
	var_bien = 1
	f_mensaje("Error","Al articulo "+f_nombre_articulo(ubi.empresa,ubi.articulo)+" se le ha cambiado la ubicación")
END IF

 IF registros<>0 THEN
  FOR x1=1 To registros
	IF dw.GetItemString(x1,"ubicacion") <> ubi.ubicacion Then
		var_bien = 1
		f_mensaje("Error","INtegridad")
	END IF
	  cur_existencias   =  dw.GetItemNumber(x1,"existencias")
	  cur_linea         =  dw.GetItemNumber(x1,"linea")
	  IF cur_existencias < total_cantidad Then
//	  f_mensaje("alm",dw.GetItemString(x1,"almacen"))
//	  f_mensaje("zo",dw.GetItemString(x1,"zona"))
//   f_mensaje("fi",String( dw.GetItemNumber(x1,"fila")))
//   f_mensaje("al",String(dw.GetItemNumber(x1,"altura")))
//   f_mensaje("linea",String(dw.GetItemNumber(x1,"linea")))
//	  f_mensaje("Error","No Hay suficiente Stock al Articulo: "+f_nombre_articulo(codigo_empresa,ubi.articulo)+ " UBICACION: " + ubi.ubicacion+ " CANT:" + STring(total_cantidad)+" EXISTE:" + STring(cur_existencias))
		f_mensaje("Error","Falta stock"+ f_nombre_articulo(codigo_empresa,ubi.articulo))
		var_bien = 1
   	Exit
	  END IF

     IF total_cantidad = cur_existencias THEN 
         DELETE FROM almlinubica  
         WHERE almlinubica.empresa   = :ubi.empresa 
			AND   almlinubica.ubicacion = :ubi.ubicacion 
			AND   almlinubica.linea     = :cur_linea  USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN 
				var_bien=1
				 f_mensaje("Error","Error borrar ubicacion")
			END IF
     ELSE
		// No se puede reubicar lineas de pedidos preparadas parcialmente
		IF var_situacion= "P" Then
			f_mensaje("Error","No Se pueden reubicar linea preparadas parcialmente Articulo: "+f_nombre_articulo(codigo_empresa,ubi.articulo)+ " UBICACION: " + ubi.ubicacion)
			var_bien = 1
		END IF
          UPDATE almlinubica  
         SET almlinubica.existencias = almlinubica.existencias - :total_cantidad
         WHERE almlinubica.empresa   = :ubi.empresa 
			AND   almlinubica.ubicacion = :ubi.ubicacion 
			AND   almlinubica.linea     = :cur_linea USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN 
						 f_mensaje("Error","Al modificar almlinubica")
						 var_bien=1
					END IF
    END IF

NEXT
END IF

destroy dw

IF var_bien = 1 then 
	Return FALSE
Else
	Return TRUE
End If
end function

public function boolean f_grabar_entrada (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido,cantidad_borrada,cur_pedido,cur_linea
Dec{0} var_anyo,var_orden,var_linea,contador,var_calibre
string cadena,var_referencia,var_tipo_pallet,var_articulo,var_calidad,&
	cur_observaciones,cur_tipo_pallet,var_ubicacion,var_situacion,&
	v_mas,var_operario,var_tono
Dec{2} var_cantidad_carga,total_cantidad,cur_existencias,cantidad_pendiente
Integer var_bien

var_bien = 0
str_almmovhis        movhis
str_almlinubica      ubi
str_almlinubicahis   ubihis

var_anyo           = dw_orden.GetItemNumber(elemento,"anyo")
var_tipo_pallet    = dw_orden.GetItemString(elemento,"tipo_pallet")
var_orden          = dw_orden.GetItemNumber(elemento,"orden")
var_linea          = dw_orden.GetItemNumber(elemento,"linea")
var_situacion      = dw_orden.GetItemString(elemento,"almlincargas_situacion_pedido")
var_almacen        = var_almacen_cargas
var_zona           = var_zona_cargas
var_fila           = var_fila_cargas
var_altura         = var_altura_cargas
var_ubicacion      = f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura)
var_anyo_pedido    = Dec(f_valor_columna(dw_orden,elemento,"anyo_ped"))
var_pedido         = dw_orden.GetItemNumber(elemento,"pedido")
var_linea_pedido   = dw_orden.GetItemNumber(elemento,"linea_ped")
var_cantidad_carga = Dec(f_valor_columna(dw_orden,elemento,"cantidad"))
var_articulo       = f_valor_columna(dw_orden,elemento,"articulo")
var_calidad        = f_valor_columna(dw_orden,elemento,"calidad")
var_tono           = Trim(f_valor_columna(dw_orden,elemento,"tonochar"))
var_calibre        = Dec(f_valor_columna(dw_orden,elemento,"calibre"))

IF IsNull(var_tono) Then var_tono = "" 
IF IsNull(var_calibre) Then var_calibre = 0 
If IsNull(var_calidad) or Trim(var_calidad)="0" then var_calidad = ""

var_referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)


//----------------------//
// Grabar Entrada almacen//
//----------------------//
 total_cantidad        = var_cantidad_carga
 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Today())
 ubihis.almacen       = var_almacen
 ubihis.articulo      = var_articulo
 ubihis.calidad       = var_calidad
 ubihis.tonochar      = var_tono
 ubihis.calibre       = var_calibre
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = DateTime(today(),now())
 SetNull(ubihis.observaciones )
 ubihis.tipo_pallet   = var_tipo_pallet
 ubihis.sector        = f_sector_articulo(codigo_empresa,var_articulo)
 SetNull(ubihis.nummov)

  SELECT articulos.familia,articulos.formato,articulos.modelo,
         articulos.unidad  
    INTO :ubihis.familia,:ubihis.formato,:ubihis.modelo,
	      :ubihis.tipo_unidad  
    FROM articulos  
   WHERE (articulos.empresa = :ubihis.empresa ) AND  
         (articulos.codigo = :ubihis.articulo );
			IF SQLCA.SQLCode<>0 THEN var_bien=1
ubihis.referencia   = var_referencia
ubihis.tipomov="205"
ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.formato    =  ubihis.formato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
ubi.tipo_pallet = ubihis.tipo_pallet
ubi.sector      = ubihis.sector
ubi.anyo        = var_anyo_pedido


ubi.cliente = f_cliente_venped(codigo_empresa,var_anyo_pedido,var_pedido)
ubi.tipo_unidad  =  ubihis.tipo_unidad
ubi.referencia   =  ubihis.referencia
ubi.f_alta       =  DateTime(today(),now())
ubihis.zona      = var_zona
ubihis.fila      = var_fila
ubihis.altura    = var_altura
ubihis.cantidads = 0
ubihis.cantidade = total_cantidad
ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                   ubihis.fila,ubihis.altura)
ubi.zona         = ubihis.zona
ubi.fila         = ubihis.fila
ubi.altura       = ubihis.altura
ubi.existencias  = ubihis.cantidade
ubi.ubicacion    = ubihis.ubicacion
ubihis.orden     = f_almparam_numorden(codigo_empresa,Year(Today()))
//-----------------------------------------------------------------------
// Tambien Inserto en el Historico de Movimientos ( la Entrada Gobal)
//-----------------------------------------------------------------------
 movhis.empresa  =  ubihis.empresa  
 movhis.almacen  =  ubihis.almacen
 movhis.anyo     =  ubihis.anyo
 movhis.origen   =  "6"
 movhis.articulo =  ubihis.articulo
 movhis.fechmov  =  ubihis.fecha
 movhis.tipomov  =  ubihis.tipomov
 movhis.cantidade=  ubihis.cantidade
 movhis.cantidads=  0
 movhis.precio   =  0
 movhis.codtercero = em_cliente.text
 movhis.numdoc   = String(var_pedido,"########")
 movhis.situacion=  "N"
 SetNull(movhis.observaciones)
 SetNull( movhis.punteado)
 movhis.antexist =    0
 movhis.familia      =  ubihis.familia
 movhis.formato      =  ubihis.formato
 movhis.modelo       =  ubihis.modelo
 movhis.calidad      =  ubihis.calidad
 movhis.tonochar     =  ubihis.tonochar
 movhis.calibre      =  ubihis.calibre
 movhis.tipo_unidad  =  ubihis.tipo_unidad
 movhis.referencia   =  ubihis.referencia
 movhis.f_alta       =  ubihis.f_alta
 movhis.usuario      =  ubihis.usuario
 movhis.tipo_pallet  =  ubihis.tipo_pallet
 movhis.sector  =  ubihis.sector
 movhis.nummov = f_almparam_nummov(movhis.empresa,Year(Today()))
 var_operario  =  uo_operario.em_codigo.text
 var_fila = Dec(em_fila_cargas.text)
 var_altura = Dec(em_altura_cargas.text)
   UPDATE venliped  
     SET almacen_ent = :movhis.almacen,   
         anyo_ent = :movhis.anyo,   
         nummov_ent = :movhis.nummov,   
			fila_ent   =:var_fila,
			altura_ent =:var_altura,
         operario_prepa = :var_operario  
   WHERE ( venliped.empresa = :codigo_empresa ) AND  
         ( venliped.anyo = :var_anyo_pedido ) AND  
         ( venliped.pedido = :var_pedido ) AND  
         ( venliped.linea = :var_linea_pedido )   ;
			IF SQLCA.SQLCODE = 100 Then 
				f_mensaje("Error "," La linea del pedido no existe")
				var_bien = 1
			END IF
			
ubi.pedido = var_pedido 
ubi.linped = var_linea_pedido
// Grabar el movimiento en el histrorico por el total de existencias
   IF NOT f_insert_almmovhis(movhis) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      var_bien=1
   END IF
   IF NOT f_actualiza_nummov(movhis.empresa,Year(Today()),movhis.nummov) THEN
       var_bien=1
   END IF
   ubihis.nummov = movhis.nummov
//--------------------------------------------------------------------
  // En el historico de ubicaciones
   IF NOT f_insert_almlinubicahis(ubihis) THEN   var_bien=1
   IF NOT f_actualiza_numorden(codigo_empresa,Year(Today()),ubihis.orden) THEN
       var_bien=1
   END IF
   
//-------------------Fin insercion movhis entrada global  ----------------\\

//----------------------------------------------
// Inserto en las ubicaciones correspondientes
//----------------------------------------------

         ubi.empresa  = codigo_empresa
  	 	   ubi.almacen  = var_almacen_cargas
         ubi.zona     = var_zona_cargas
         ubi.fila     = var_fila_cargas
         ubi.altura   = var_altura_cargas
			Select max(linea) Into :ubi.linea From  almlinubica
			Where  almlinubica.empresa   = :codigo_empresa
			And    almlinubica.ubicacion = :ubi.ubicacion;
			IF IsNull(ubi.linea) Then ubi.linea = 0
			ubi.linea = ubi.linea + 1
	
         ubi.linea       = ubi.linea +1
         ubi.articulo    = movhis.articulo
         ubi.familia     = movhis.familia
         ubi.formato     = movhis.formato
         ubi.modelo      = movhis.modelo
         ubi.calidad     = movhis.calidad
         ubi.tonochar    = movhis.tonochar
         ubi.calibre     = movhis.calibre
         ubi.existencias = total_cantidad
         ubi.ubicacion   = ubi.ubicacion
         ubi.tipo_unidad = movhis.tipo_unidad
         ubi.referencia  = movhis.referencia
         ubi.f_alta      = DateTime(Today(),Now())
         SetNull(ubi.observaciones)
         ubi.tipo_pallet = movhis.tipo_pallet
         ubi.sector      = movhis.sector
         ubi.externo     = movhis.externo
IF Not f_insert_almlinubica(ubi) Then var_bien = 1
IF var_bien = 1 then 
	Return FALSE
Else
	Return TRUE
End If
end function

public subroutine f_expedir ();Integer reg,reg1,bien,v_calibre,ln
dec     nuevo_peso
Dec{0}  var_anyo,var_orden,var_linea,nu
Dec{0}  var_pedido,var_anyo_pedido,var_linea_pedido,jj,ante_pedido
Dec{4}  v_cantidad,v_disponible
String  v_articulo,v_calidad,v_tipo_pallet,v_referencia,v_antedep,ub,&
	ante_agrupa,var_agrupa,var_clase,ante_clase,v_tono
string v_caja	
peso = Dec(dw_orden.GetItemString(1,"total_peso"))
IF Dec(em_albaran.text) <> 0 Then
	peso = peso + f_peso_venalb(codigo_empresa,var_anyo_albaran,var_albaran[var_contador])
END IF
tipo_array val
openWithParm(w_pedir_datos_expedicion,STring(peso))
val =  message.powerObjectparm
IF val.valor[1] = "RETURN" Then Return

observaciones = val.valor[1]
nuevo_peso    = Dec(val.valor[2])
if peso = nuevo_peso then
	nuevo_peso = 0
end if
contenedor    = val.valor[3]
precinto      = val.valor[4]
matricula     = val.valor[5]
dni			  = val.valor[6]

IF IsNull(peso) Then peso =0
IF Dec(em_albaran.text) <> 0 Then
	IF MessageBox("Proceso Generación albaranes","¿Desea acumular sobre el albaran seleccionado?",Question!,YesNo!) = 2 Then
		em_albaran.text = "0"
	END IF
END IF
reg1 = dw_orden.RowCount()
For reg = 1 To reg1
	IF dw_orden.GetItemSTring(reg,"marcado")= "X" Then
				ub  = dw_orden.GetItemSTring(reg,"ubicacion")
				IF IsNUll(ub) or Trim(ub)= "" Then
					f_mensaje("Control ubicaciones asignadas","El articulo "+ f_nombre_articulo(codigo_empresa,dw_orden.GetItemString(reg,"articulo")) + " No tiene ubicacion asignada")
					f_activar_campo(uo_operario.em_campo)
					Return 
				END IF
	END IF
NEXT
//dw_orden.SetSort("almlincargas_deposito")
//dw_orden.Sort()
bien = 0

veces = 0
SetNull(v_antedep)
IF Not f_bloquear_almacen(w_int_preparacion_ordenes.title) Then
IF Not f_bloquear_albaranes(w_int_preparacion_ordenes.title) Then
For reg = 1 To reg1
			f_mensaje_proceso("Procesando..:",reg,reg1)
			IF f_valor_columna(dw_orden,reg,"marcado") = "X" Then
						var_anyo        = dw_orden.GetItemNumber(reg,"anyo")
						var_agrupa      = dw_orden.GetItemString(reg,"venped_agrupa_exp")
						var_clase       = dw_orden.GetItemString(reg,"venliped_clase")
						var_orden       = dw_orden.GetItemNumber(reg,"orden")
						var_linea       = dw_orden.GetItemNumber(reg,"linea")
						v_articulo      = dw_orden.GetItemString(reg,"articulo")
						v_calidad       = dw_orden.GetItemString(reg,"calidad")
						v_tono          = dw_orden.GetItemString(reg,"tonochar")
						v_calibre       = dw_orden.GetItemNumber(reg,"calibre")
						v_tipo_pallet   = dw_orden.GetItemString(reg,"tipo_pallet")
						v_caja          = dw_orden.GetItemString(reg,"almlincargas_caja")
						v_cantidad      = dw_orden.GetItemNumber(reg,"cantidad")
						var_anyo_pedido  = dw_orden.GetItemNumber(reg,"anyo_ped")
						var_pedido       = dw_orden.GetItemNumber(reg,"pedido")
						var_linea_pedido = dw_orden.GetItemNumber(reg,"linea_ped")
						v_deposito       = dw_orden.GetItemString(reg,"almlincargas_deposito")
						//-------------------------------------------------------------------//
						// Control disponible//
						//-------------------------------------------------------------------//
						 v_referencia = f_componer_ref(v_articulo,v_calidad,v_tono,v_calibre)
						 v_disponible = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,&
												  v_referencia,v_tipo_pallet,v_caja)
												  
											  
												  
						//----------------------------------------------------------------------//
						//IF dw_orden.GetItemString(reg,"situacion") <> "P" Then 
						//	f_mensaje("Control Temporal"," No se pueden expedir linea no preparadas")
						//	Return
						//END IF
						
						//IF (ante_clase = "M" and var_clase <> "M") or (var_clase <> "M" and ((ante_agrupa <> var_agrupa and Not IsNull(ante_agrupa)) or (var_pedido <> ante_pedido and var_agrupa = "N") or (v_antedep <> v_deposito and Not IsNull(v_antedep)))) Then
						IF (ante_agrupa <> var_agrupa) or ((var_pedido <> ante_pedido) and var_agrupa = "N") or (v_antedep <> v_deposito) Then
							veces = 0
							peso  = 0
							var_contador = var_contador +1
						END IF
						
						v_antedep   = v_deposito
						ante_agrupa = var_agrupa
						ante_pedido = var_pedido
						ante_clase  = var_clase
												
						var_fecha_carga =  dw_orden.GetItemDateTime(reg,"fcarga")
						f_mensaje_proceso("Grabando ALbaran Ped("+STring(var_pedido,"########")+")",reg,reg1)
						
						IF Not	f_grabar_albaran(reg)        Then 
							f_mensaje("Error en datos","Error en funcion grabar albaran")
							bien = 1
							exit
						END IF
						
						IF Not   f_grabar_salida_ventas(reg)  Then 
							f_mensaje("Error en datos","Error en funcion grabar salida ventas "+sqlca.sqlerrtext)
							bien = 1
							exit
						END IF


						f_mensaje_proceso("Pasando Orden(His) Ped("+STring(var_pedido,"########")+")",reg,reg1)
						
						IF Not f_pase_carga(reg)    Then  
							bien = 1
							f_mensaje("Error en datos","Error en funcion pase carga")
							exit
						END IF

						Select venliped.cantidad Into :nu from venliped
						Where  empresa = :codigo_empresa
						And    anyo    = :var_anyo_pedido
						And    pedido  = :var_pedido
						And    linea   = :var_linea_pedido;
						IF IsNUll(nu) Then nu = 0
						IF nu = 0 Then 
							bien = 1
							f_mensaje("Error en datos","No existe la line de pedido a  borrar")
						END IF
						f_mensaje_proceso("Borrando Ped("+STring(var_pedido,"########")+")",reg,reg1)
						IF Not f_expedir_pedido(reg) Then bien = 1
									
			END IF

Next 

// Borrando Resto de Ordenes
For reg = 1 To reg1
	f_mensaje_proceso("Borrando resto de Ordenes.:",reg,reg1)
	IF f_valor_columna(dw_orden,reg,"marcado") = "X" Then
				var_anyo    = dw_orden.GetItemNumber(reg,"anyo")
				var_orden   = dw_orden.GetItemNumber(reg,"orden")
				var_linea   = dw_orden.GetItemNumber(reg,"linea")
				Delete from almlincargas
				Where  almlincargas.empresa = :codigo_empresa
				And    almlincargas.anyo    = :var_anyo
				And    almlincargas.orden   = :var_orden
				And    almlincargas.linea   = :var_linea;
				
				Select Count(*) Into :ln From almlincargas
				Where  almlincargas.empresa = :codigo_empresa
				And    almlincargas.anyo    = :var_anyo
				And    almlincargas.orden   = :var_orden;
				IF ln = 0 Then 
						Delete from almcargas
						Where  almcargas.empresa = :codigo_empresa
						And    almcargas.anyo    = :var_anyo
						And    almcargas.orden   = :var_orden;
				END IF
	END IF
NExt

For jj = 1 To var_contador
	IF Not f_actualizar_venalbaran(codigo_empresa,var_anyo_albaran,var_albaran[jj]) Then 
		bien = 1
		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
	END IF
Next

// Modificamos el peso si se cambia en la pantalla de datos
IF nuevo_peso <> 0 Then
	Update venalb
	Set peso = :nuevo_peso
	Where empresa = :codigo_empresa
	And   anyo    = :var_anyo_albaran
	And   albaran = :var_albaran[var_contador];
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
		bien = 1
	END IF
END IF



IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso de datos","No se actualiza" + sqlca.sqlerrtext)
END IF
f_desbloquear_almacen(w_int_preparacion_ordenes.title)
f_desbloquear_albaranes(w_int_preparacion_ordenes.title)

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
						 setnull(var_albaran[jj])						 
				    NEXT
					 OpenWithParm(w_lis_venalbaranes,lstr_param)
		END IF
	END IF
uo_operario.em_campo.text = ""
uo_operario.em_codigo.text = ""
observaciones = ""
ELSE
	f_desbloquear_almacen(w_int_preparacion_ordenes.title)
END IF
END IF
var_contador = 1
f_salir()
end subroutine

public function boolean f_grabar_albaran (integer reg);Dec{0}   var_anyo_pedido,var_pedido,var_linea_pedido,bien,var_albaran1,var_albaran2,numero
str_venlialb lialb
str_venalb alb
veces = veces +1
bien = 0
var_anyo_pedido          = dw_orden.GetItemNumber(reg,"anyo_ped")
var_pedido               = dw_orden.GetItemNumber(reg,"pedido")
var_linea_pedido         = dw_orden.GetItemNumber(reg,"linea_ped")
IF veces = 1 Then
	control_lineas = 0
	IF Dec(em_albaran.text) = 0 Then

		  SELECT venped.empresa,   
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
					venped.peso,   
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
					venped.peso_neto,   
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
					venped.comision_fija3
			 INTO :alb.empresa,   
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
					:alb.fentrega,   
					:alb.observaciones,  
					:alb.agrupa,
					:alb.deposito,
					:alb.almacen_deposito,
					:alb.calculo_dtoesp,
					:lialb.agrupa_exp,
					:alb.comision_fija1,
					:alb.comision_fija2,
					:alb.comision_fija3
			FROM   venped  
			WHERE  venped.empresa = :codigo_empresa AND  
					 venped.anyo    = :var_anyo_pedido AND  
					 venped.pedido  = :var_pedido;
					 
		if sqlca.sqlcode <> 0 then
			f_mensaje("Selección de datos del pedido (generación del albarán)","Error: "+sqlca.sqlerrtext)
			bien = 1
		end if					 
					 
		SELECT venparamalb.albaran   
		INTO   :var_albaran[var_contador] 
		FROM   venparamalb  
		WHERE  venparamalb.empresa = :codigo_empresa  
		And    venparamalb.anyo    = :var_anyo_albaran
		And    venparamalb.serie   = :alb.serie;
		
		If Sqlca.Sqlcode = 100 Then
			INSERT INTO venparamalb
			            (empresa,
							 anyo,
							 albaran,
							 serie)  
			VALUES      (:codigo_empresa,
			             :var_anyo_albaran,
							 0,
							 :alb.serie);
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
			f_grabar_incidencia(w_int_preparacion_ordenes.title,"Proceso lento seleccion ultimo albaran")
			
			Select Max(venalb.albaran)  
			Into   :var_albaran1 
			From   venalb
			Where  venalb.empresa = :codigo_empresa
			And    venalb.anyo    = :var_anyo_albaran
			And    venalb.serie   = :alb.serie;
			
			IF IsNull(var_albaran1) Then var_albaran1 = 0
			
			Select Max(venlifac.albaran)  
			Into   :var_albaran2 
			From   venlifac
			Where  venlifac.empresa      = :codigo_empresa
			And    venlifac.anyo_albaran = :var_anyo_albaran
			And    venlifac.serie        = :alb.serie;
			
			IF IsNull(var_albaran2) Then var_albaran2 = 0
			
			var_albaran[var_contador] = var_albaran1
			IF var_albaran2 > var_albaran[var_contador] Then var_albaran[var_contador] = var_albaran2
			var_albaran[var_contador] = var_albaran[var_contador] + 1
			//Comprobamos de nuevo si existe el albaran calculado 
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
			if numero > 0 then
				messagebox("Error","Atención se ha calculado un nº de albaran que ya existe("+&
								string(alb.anyo,"#,###")+"/"+string(alb.albaran,"###,###,##0")+")"+&
								"~nAvise al administrador del sistema.")
				bien = 1								
			end if
			//Final de la comprobación
			
		End If
		
		UPDATE venparamalb
		SET    albaran             = :var_albaran[var_contador]
		WHERE  venparamalb.empresa = :codigo_empresa
		And    venparamalb.anyo    = :var_anyo_albaran
		And    venparamalb.serie   = :alb.serie;
		
		IF sqlca.sqlcode <> 0 then
			f_mensaje("Actualización de venparamalb","Error: "+sqlca.sqlerrtext)
		end if
					 
			alb.empresa = codigo_empresa
			alb.anyo    = var_anyo_albaran
			alb.albaran = var_albaran[var_contador]					 
			alb.falbaran = DateTime(Date(em_fecha.text))
			alb.flistado = DateTime(Today(),Now())
			alb.veces = 1
			alb.falta = DateTime(Today(),Now())
			alb.fcarga             = var_fecha_carga
			alb.deposito = v_deposito
			alb.abono = "N"
			alb.observaciones = observaciones
			alb.contenedor    = contenedor		
			alb.precinto      = precinto
			alb.matricula		= matricula			
			alb.dni				= dni
			
			IF Not f_insertar_venalb(alb)	Then 				
				bien = 1
				messagebox("Error","f_insertar_venalb "+string(alb.anyo,"#,###")+"/"+string(alb.albaran,"###,###,##0"))
			end if
			
		
    ELSE
  		var_albaran[var_contador] = Dec(em_albaran.text)
  		alb.empresa = codigo_empresa
  		alb.anyo    = var_anyo_albaran
  		alb.albaran = var_albaran[var_contador]
		 Select Max(linea) Into :control_lineas From venlialb
		 Where  venlialb.empresa = :codigo_empresa
		 And    venlialb.anyo    = :var_anyo_albaran
		 And    venlialb.albaran = :var_albaran[var_contador];
		 IF IsNull(control_lineas) Then control_lineas = 0
  	END IF
END IF

lialb.fcarga             = var_fecha_carga
lialb.anyo_pedido_origen = var_anyo_pedido
lialb.pedido_origen      = var_pedido
lialb.albaran = var_albaran[var_contador]
lialb.anyo = var_anyo_albaran
lialb.linea = veces + control_lineas
lialb.empresa = codigo_empresa
lialb.falbaran = DateTime(Date(em_fecha.text))
lialb.falta = alb.falta
  SELECT venliped.serie,venliped.fentrega,   
         venliped.cliente,venliped.tipo_unidad,   
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
			venliped.dtoesp2
    INTO :lialb.serie,   
         :lialb.fentrega,   
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
			:lialb.dtoesp2
    FROM  venliped  
   WHERE  venliped.empresa = :codigo_empresa 
	AND    venliped.anyo    = :var_anyo_pedido 
	AND    venliped.pedido  = :var_pedido 
	AND    venliped.linea   = :var_linea_pedido ;
			
lialb.falta           = DateTime(Today(),Now())
lialb.usuario         = nombre_usuario
lialb.pallets         = Dec(f_valor_columna(dw_orden,reg,"almlincargas_pallets"))
lialb.cajas           = Dec(f_valor_columna(dw_orden,reg,"cajas"))
lialb.total_cajas     = Dec(f_valor_columna(dw_orden,reg,"total_cajas"))
lialb.cantidad        = Dec(f_valor_columna(dw_orden,reg,"almlincargas_cantidad_facturar"))
lialb.cantidad_pedido = Dec(f_valor_columna(dw_orden,reg,"cantidad"))
lialb.ubicacion       = f_valor_columna(dw_orden,reg,"ubicacion")		
lialb.contenedor      = contenedor
lialb.precinto		    = precinto
lialb.matricula	    = matricula
IF Not f_insertar_venlialb(lialb) Then 
	bien = 1
	messagebox("Error","f_insertar_venlialb")
end if
IF bien  = 0 Then
	Return True
Else
	Return False
End If


end function

public subroutine f_preparar ();IF dw_orden.GetRow() = 0 Then Return
str_parametros lstr_param
lstr_param.i_nargumentos = 4
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
lstr_param.s_argumentos[2]  = String(dw_orden.GetItemNumber(dw_orden.GetRow(),"anyo_ped"))
lstr_param.s_argumentos[3]  = String(dw_orden.GetItemNumber(dw_orden.GetRow(),"pedido"))
lstr_param.s_argumentos[4]  = String(dw_orden.GetItemNumber(dw_orden.GetRow(),"linea_ped"))
OpenWithParm(w_int_preparacion_pedido,lstr_param)
IF  Message.StringParm = "S" Then f_proceso()

end subroutine

public function boolean f_pase_carga (integer reg);Dec{0}  var_anyo,var_orden,var_linea,bien,var_calibre,var_total_cajas,var_linea_his
String var_externo,var_articulo,var_montajeartcal,var_calidad,var_referencia,var_tipo_pallet,var_empresa,var_matricula
String var_cliente,var_usuario,var_observaciones,var_tipo_unidad,var_tono
String var_ubicacion,var_es_pico,var_parcial,var_formato,var_imp_bandas,var_marcado,var_situacion_pedido
String var_modelo,var_familia,vartipomov,var_sector,var_tipomov,var_situacion
DateTime  var_fecha_ped,var_forden,var_flistado,var_fcarga,var_fecha,var_f_alta
Dec{0} var_numero,var_anyo_ped,var_pedido,var_linea_ped,var_cajas,var_paldesde,var_palhasta,var_nummov
Dec{0} var_pallets,var_pico,varnummov
Dec{2} var_cantidad,var_cantidad_ped,var_peso_bruto,var_peso_neto,var_cantidads,var_cantidade



bien = 0

var_anyo        = dw_orden.GetItemNumber(reg,"anyo")
var_orden       = dw_orden.GetItemNumber(reg,"orden")
var_linea       = dw_orden.GetItemNumber(reg,"linea")
var_numero = 0
  SELECT Count(*)   INTO :var_numero   FROM almcargashis
	 Where almcargashis.empresa  = :codigo_empresa
	 And   almcargashis.anyo     = :var_anyo
	 And   almcargashis.orden    = :var_orden;
	 IF IsNull(var_numero) Then var_numero = 0
IF var_numero = 0 Then
  SELECT almcargas.empresa,almcargas.anyo,almcargas.orden,
         almcargas.matricula,almcargas.forden,almcargas.cliente,   
         almcargas.flistado,almcargas.observaciones,almcargas.usuario  
    INTO :var_empresa,:var_anyo,:var_orden,:var_matricula,:var_forden,   
         :var_cliente,:var_flistado,:var_observaciones,:var_usuario  
    FROM  almcargas 
	 Where almcargas.empresa  = :codigo_empresa
	 And   almcargas.anyo     = :var_anyo
	 And   almcargas.orden    = :var_orden;
    INSERT INTO almcargashis  
           (empresa,anyo,orden,matricula,forden,cliente,flistado,observaciones,usuario )  
    VALUES (:var_empresa,:var_anyo,:var_orden,:var_matricula,:var_forden,:var_cliente,:var_flistado,:var_observaciones,:var_usuario );
			  IF SQLCA.SQLCODE <> 0 Then 
				f_mensaje("Error en proceso","Error el pasar la grabar la orden en el,historico")
				bien = 1
			END IF
END IF
  SELECT almlincargas.empresa,   
         almlincargas.anyo,   
         almlincargas.orden,   
         almlincargas.linea,   
         almlincargas.matricula,   
         almlincargas.cliente,   
         almlincargas.fcarga,   
         almlincargas.anyo_ped,   
         almlincargas.pedido,   
         almlincargas.linea_ped,   
         almlincargas.fecha_ped,   
         almlincargas.articulo,   
         almlincargas.calidad,   
         almlincargas.montajeartcal,   
         almlincargas.tonochar,   
         almlincargas.calibre,   
         almlincargas.referencia,   
         almlincargas.tipo_pallet,   
         almlincargas.cajas,   
         almlincargas.total_cajas,   
         almlincargas.cantidad,   
         almlincargas.cantidad_ped,   
         almlincargas.tipo_unidad,   
         almlincargas.ubicacion,   
         almlincargas.usuario,   
         almlincargas.paldesde,   
         almlincargas.palhasta,   
         almlincargas.pallets,   
         almlincargas.peso_bruto,   
         almlincargas.peso_neto,   
         almlincargas.pico,   
         almlincargas.es_pico,   
         almlincargas.formato,   
         almlincargas.forden,   
         almlincargas.parcial,   
         almlincargas.imp_bandas,   
         almlincargas.marcado,   
         almlincargas.situacion_pedido  
    INTO :var_empresa,   
         :var_anyo,   
         :var_orden,   
         :var_linea,   
         :var_matricula,   
         :var_cliente,   
         :var_fcarga,   
         :var_anyo_ped,   
         :var_pedido,   
         :var_linea_ped,   
         :var_fecha_ped,   
         :var_articulo,   
         :var_calidad,   
         :var_montajeartcal,   
         :var_tono,   
         :var_calibre,   
         :var_referencia,   
         :var_tipo_pallet,   
         :var_cajas,   
         :var_total_cajas,   
         :var_cantidad,   
         :var_cantidad_ped,   
         :var_tipo_unidad,   
         :var_ubicacion,   
         :var_usuario,   
         :var_paldesde,   
         :var_palhasta,   
         :var_pallets,   
         :var_peso_bruto,   
         :var_peso_neto,   
         :var_pico,   
         :var_es_pico,   
         :var_formato,   
         :var_forden,   
         :var_parcial,   
         :var_imp_bandas,   
         :var_marcado,   
         :var_situacion_pedido  
    FROM almlincargas  
   WHERE ( almlincargas.empresa = :codigo_empresa ) AND  
         ( almlincargas.anyo = :var_anyo ) AND  
         ( almlincargas.orden = :var_orden ) AND  
         ( almlincargas.linea = :var_linea )   ;
			IF SQLCA.SQLCODE = 100 Then 
				bien = 1
				f_mensaje("Error en proceso (integridad)","No existe la linea orden"+ "Empresa.:" + codigo_empresa+" Orden.:" + String(var_anyo) + "/" + String(var_orden)+  "Ln.:" + String(var_linea))
			END IF
			Select Max(almlincargashis.linea) Into :var_linea_his
			From   almlincargashis  
		   WHERE  almlincargashis.empresa = :codigo_empresa
			AND    almlincargashis.anyo    = :var_anyo 
			AND    almlincargashis.orden   = :var_orden; 
			IF IsNull(var_linea_his) Then var_linea_his = 0
			var_linea_his = var_linea_his + 1
    INSERT INTO almlincargashis  
         ( empresa,anyo,orden,linea,matricula,cliente,fcarga,anyo_ped,   
           pedido,linea_ped,fecha_ped,articulo,calidad,montajeartcal,   
           tonochar,calibre,referencia,tipo_pallet,cajas,total_cajas,   
           cantidad,cantidad_ped,tipo_unidad,ubicacion,usuario,   
           paldesde,palhasta,pallets,peso_bruto,peso_neto,pico,   
           es_pico,formato,forden,parcial,imp_bandas,marcado,   
           situacion_pedido)  
  VALUES ( :var_empresa,:var_anyo,:var_orden,:var_linea_his,:var_matricula,   
           :var_cliente,:var_fcarga,:var_anyo_ped,:var_pedido,:var_linea_ped,   
           :var_fecha_ped,:var_articulo,:var_calidad,:var_montajeartcal,   
           :var_tono,:var_calibre,:var_referencia,:var_tipo_pallet,   
           :var_cajas,:var_total_cajas,:var_cantidad,:var_cantidad_ped,   
           :var_tipo_unidad,:var_ubicacion,:var_usuario,   
           :var_paldesde,   
           :var_palhasta,   
           :var_pallets,   
           :var_peso_bruto,   
           :var_peso_neto,   
           :var_pico,   
           :var_es_pico,   
           :var_formato,   
           :var_forden,   
           :var_parcial,   
           :var_imp_bandas,   
           :var_marcado,   
           :var_situacion_pedido )  ;
			  IF SQLCA.SQLCODE <> 0 Then 
				Bien = 1
				f_mensaje("Error en proceso","Error el pasar la grabar la orden en el,historico")
				END IF

   DELETE FROM almlincargas  
   WHERE ( almlincargas.empresa = :codigo_empresa ) AND  
         ( almlincargas.anyo = :var_anyo ) AND  
         ( almlincargas.orden = :var_orden ) AND  
         ( almlincargas.linea = :var_linea )   ;
			IF SQLCA.SQLCODE <> 0 Then 
				bien = 1
				f_mensaje("Error en proceso","Error borrar la orden en el historico")
			END IF

			
IF bien = 0 Then
	Return True
ELse
	Return False
End If



end function

public function boolean f_control_existencias ();Dec bien,reg1,reg,var_anyo,var_orden,var_linea,var_pedido,var_anyo_ped,var_linea_ped,var_cantidad,var_cantidad2,var_linped
String var_ubicacion,var_referencia,var_tipo_pallet,var_situacion,var_articulo
bien = 0
reg1 = dw_orden.RowCount()
For reg = 1 To reg1

IF f_valor_columna(dw_orden,reg,"marcado")	= "X" Then
var_anyo        = dw_orden.GetItemNumber(reg,"anyo")
var_orden       = dw_orden.GetItemNumber(reg,"orden")
var_linea       = dw_orden.GetItemNumber(reg,"linea")
  SELECT almlincargas.anyo_ped,almlincargas.pedido,
  			almlincargas.linea_ped,almlincargas.referencia,   
         almlincargas.tipo_pallet,almlincargas.ubicacion,   
         almlincargas.cantidad,almlincargas.situacion_pedido ,almlincargas.articulo
    INTO :var_anyo_ped,:var_pedido,:var_linea_ped, :var_referencia,   
         :var_tipo_pallet,:var_ubicacion,:var_cantidad,   
         :var_situacion,:var_articulo
    FROM almlincargas  
   WHERE  almlincargas.empresa = :codigo_empresa 
	AND    almlincargas.anyo = :var_anyo 
	AND    almlincargas.orden = :var_orden 
	AND    almlincargas.linea = :var_linea;
	if isnull(var_ubicacion) then
		messagebox("Linea "+string(var_linea,"#######")+ " sin ubicación","Articulo: "+ f_nombre_articulo(codigo_empresa,var_articulo)+" cantidad: "+string(var_cantidad,"############.##"))
		return false
	end if
	IF var_situacion = "P" Then
			SELECT sum(existencias) INTO :var_cantidad2   FROM almlinubica  
			WHERE  almlinubica.empresa = :codigo_empresa 
			AND    almlinubica.ubicacion = :var_ubicacion
			AND    almlinubica.referencia = :var_referencia
			AND    almlinubica.tipo_pallet = :var_tipo_pallet 
			AND    almlinubica.anyo = :var_anyo_ped 
			AND  	 almlinubica.pedido = :var_pedido
			AND    almlinubica.linped = :var_linped    ;
			iF   var_cantidad2 <> var_cantidad  Then
				f_mensaje("Error","La cantidad Preparada no coincide"+ f_nombre_articulo(codigo_empresa,var_articulo))
				Return False
			END IF
	ELSE
			SELECT sum(existencias) INTO :var_cantidad2   FROM almlinubica  
			WHERE  almlinubica.empresa     = :codigo_empresa 
			AND    almlinubica.ubicacion   = :var_ubicacion
			AND    almlinubica.referencia  = :var_referencia
			AND    almlinubica.tipo_pallet = :var_tipo_pallet 
			AND  	 almlinubica.pedido is null;
         IF IsNull(var_cantidad2) Then var_cantidad2 = 0 
			iF   var_cantidad2 < var_cantidad  Then
				if isnull(var_ubicacion) then var_ubicacion=""
				f_mensaje("Control Stock Almacen","No hay suficiente Stock a esta ubicacion: "+ f_texto_ubicacion(var_ubicacion) + "   Articulo: "+ f_nombre_articulo(codigo_empresa,var_articulo))
				Return False
			END IF
	END IF
END IF
Next
Return True
end function

public function boolean f_expedir_pedido (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido
Dec{0} var_anyo,var_orden,var_linea
string cadena
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga
dec{2} var_cantidad_carga,var_cantidad_facturar_carga
Integer var_bien
var_bien = 0
str_venliped linped
var_anyo       = dw_orden.GetItemNumber(elemento,"anyo")
var_orden       = dw_orden.GetItemNumber(elemento,"orden")
var_linea       = dw_orden.GetItemNumber(elemento,"linea")

var_anyo_pedido       = dw_orden.GetItemNumber(elemento,"anyo_ped")
var_pedido            = dw_orden.GetItemNumber(elemento,"pedido")
var_linea_pedido      = dw_orden.GetItemNumber(elemento,"linea_ped")
var_pallets_carga     = dw_orden.GetItemNumber(elemento,"almlincargas_pallets")
var_cajas_carga       = dw_orden.GetItemNumber(elemento,"cajas")
var_total_cajas_carga = dw_orden.GetItemNumber(elemento,"total_cajas")
var_cantidad_carga    = dw_orden.GetItemNumber(elemento,"cantidad")
var_cantidad_facturar_carga = dw_orden.GetItemNumber(elemento,"almlincargas_cantidad_facturar")
linped.empresa   =   codigo_empresa
linped.anyo      =   var_anyo_pedido
linped.pedido    =   var_pedido
linped.linea     =   var_linea_pedido

  SELECT venliped.empresa, venliped.anyo,         venliped.pedido,venliped.linea,   
         venliped.serie,   venliped.fpedido,      venliped.fentrega,   
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
			venliped.importe,   
         venliped.descuento,venliped.importedto,    venliped.clase,   
         venliped.sector, venliped.agente1,venliped.agente2,   
         venliped.agente3,venliped.comision11,venliped.comision12,   
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
         venliped.transportista,venliped.almacen_ent,
			venliped.cantidad_facturar
    INTO :linped.empresa,:linped.anyo,:linped.pedido,:linped.linea,   
         :linped.serie,  :linped.fpedido, :linped.fentrega,
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
         :linped.usuario,:linped.tipo_pallet,:linped.caja,
			:linped.importe,   
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
         :linped.transportista,:linped.almacen_ent,
			:linped.cantidad_facturar
    FROM venliped  
   WHERE ( venliped.empresa = :codigo_empresa ) AND  
         ( venliped.anyo    = :var_anyo_pedido ) AND  
         ( venliped.pedido  = :var_pedido ) AND  
         ( venliped.linea   = :var_linea_pedido )   ;
			IF SQLCA.SQLCODE = 100 Then var_bien = 1
			
IF IsNull(var_cantidad_carga) Then var_cantidad_carga = 0
linped.cantidad          = linped.cantidad - var_cantidad_carga
linped.cantidad_facturar = linped.cantidad_facturar - var_cantidad_facturar_carga
cadena=f_calculo_unidades(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,&
									 linped.caja,&
                            0,&
                            0,&
                            linped.cantidad)
                       
linped.pallets       = Dec(Mid(cadena,1,6))
linped.cajas         = Dec(Mid(cadena,7,6))
linped.total_cajas   = Dec(Mid(cadena,13,6))
linped.cantidad      = Dec(Mid(cadena,19,9))
IF linped.cantidad <> 0 then
	
	UPDATE venliped
	Set venliped.pallets           = :linped.pallets,
		 venliped.total_cajas       = :linped.total_cajas,
		 venliped.cajas             = :linped.cajas,
		 venliped.cantidad          = :linped.cantidad,
		 venliped.cantidad_facturar = :linped.cantidad_facturar
	WHERE (venliped.empresa = :codigo_empresa )
	AND   (venliped.anyo    = :var_anyo_pedido )
	AND   (venliped.pedido  = :var_pedido )
	AND   (venliped.linea   = :var_linea_pedido );
	
	IF SQLCA.SQLCODE <> 0  Then 
		var_bien = 1
		f_mensaje("Error en datos(3)",sqlca.sqlerrtext)
	END IF
	IF Not f_actualizar_linea_venpedido(codigo_empresa,var_anyo_pedido,var_pedido,var_linea_pedido) Then var_bien = 1
ELSE
		Delete from venliped
	   WHERE (venliped.empresa = :codigo_empresa )
		AND   (venliped.anyo    = :var_anyo_pedido )
		AND   (venliped.pedido  = :var_pedido )
		AND   (venliped.linea   = :var_linea_pedido );
		IF SQLCA.SQLCODE <> 0  Then 	var_bien = 1
END IF
IF Not f_actualizar_venpedido(codigo_empresa,var_anyo_pedido,var_pedido) Then var_bien = 1
IF var_bien = 0 Then
	RETURN TRUE
ELSE
	RETURN FALSE
END IF



end function

public function boolean f_grabar_salida_ventas (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido,cur_pedido,cur_linea,contador_nummov,numero
DataStore dw_proceso2
Dec{0} var_anyo,var_orden,var_linea,contador,var_calibre
string cadena,var_referencia,var_tipo_pallet,var_articulo,var_calidad,&
  cur_observaciones,cur_tipo_pallet,var_ubicacion,var_situacion,&
  v_mas,var_deposito,var_almacen_deposito,v_almacen,var_cliente,var_tono
string var_caja
Dec{2} var_cantidad_carga,total_cantidad,cur_existencias,cantidad_pendiente,cantidad_borrada
Integer var_bien
Date fecha
Dec ln
str_almmovhis        movhis
str_almlinubica      ubi
str_almlinubicahis   ubihis
str_depmovhis        depmov
str_deplinubica      depubi

var_bien = 0
var_tipo_pallet      = dw_orden.GetItemSTring(elemento,"tipo_pallet")
var_caja             = dw_orden.GetItemSTring(elemento,"almlincargas_caja")
var_anyo             = dw_orden.GetItemNumber(elemento,"anyo")
var_orden            = dw_orden.GetItemNumber(elemento,"orden")
var_linea            = dw_orden.GetItemNumber(elemento,"linea")
var_situacion        = dw_orden.GetItemString(elemento,"almlincargas_situacion_pedido")
var_deposito         = dw_orden.GetItemString(elemento,"almlincargas_deposito")
var_cliente          = dw_orden.GetItemString(elemento,"cliente")
var_almacen_deposito = dw_orden.GetItemString(elemento,"almlincargas_almacen_deposito")
var_tipo_pallet      = dw_orden.GetItemString(elemento,"tipo_pallet")
var_ubicacion        = dw_orden.GetItemString(elemento,"ubicacion")
var_almacen          = f_almacen_ubicacion(var_ubicacion)
var_zona             = f_zona_ubicacion(var_ubicacion)
var_fila             = f_fila_ubicacion(var_ubicacion)
var_altura           = f_altura_ubicacion(var_ubicacion)

var_anyo_pedido      = dw_orden.GetItemNumber(elemento,"anyo_ped")
var_pedido           = dw_orden.GetItemNumber(elemento,"pedido")
var_linea_pedido     = dw_orden.GetItemNumber(elemento,"linea_ped")
var_cantidad_carga   = dw_orden.GetItemNumber(elemento,"cantidad")
var_articulo         = dw_orden.GetItemSTring(elemento,"articulo")
var_calidad          = dw_orden.GetItemString(elemento,"calidad")
var_tono             = dw_orden.GetItemString(elemento,"tonochar")
var_calibre          = dw_orden.GetItemNumber(elemento,"calibre")

if trim(var_calidad) = "0" or isnull(var_calidad) then var_calidad = ""

IF IsNull(var_tono)    Then var_tono    = ""
IF IsNull(var_calibre) Then var_calibre = 0 
var_referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)



//----------------------//
// Grabar Salida almacen//
//----------------------//
 total_cantidad       = var_cantidad_carga
 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Today())
 ubihis.almacen       = var_almacen
 ubihis.articulo      = var_articulo
 ubihis.calidad       = var_calidad
 ubihis.tonochar      = var_tono
 ubihis.calibre       = var_calibre
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = DateTime(today(),now())
 SetNull(ubihis.observaciones )
 ubihis.tipo_pallet   = var_tipo_pallet
 ubihis.caja          = var_caja
 ubihis.sector        = f_sector_articulo(codigo_empresa,var_articulo)
 SetNull(ubihis.nummov)

SELECT articulos.familia,
		 articulos.subfamilia,
		 articulos.formato,
		 articulos.subformato,
		 articulos.modelo,
		 articulos.unidad  
INTO   :ubihis.familia,
		 :ubihis.subfamilia,
		 :ubihis.formato,
		 :ubihis.subformato,
		 :ubihis.modelo,
		 :ubihis.tipo_unidad  
FROM   articulos  
WHERE  articulos.empresa = :ubihis.empresa
AND    articulos.codigo  = :ubihis.articulo;

IF SQLCA.SQLCode<>0 THEN 
	var_bien=1
	f_mensaje("Error","El articulo no existe")
END IF

ubihis.referencia   = var_referencia
ubihis.tipomov =  "206"
ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.subfamilia =  ubihis.subfamilia
ubi.formato    =  ubihis.formato
ubi.subformato =  ubihis.subformato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
ubi.tipo_pallet = ubihis.tipo_pallet
ubi.caja        = ubihis.caja
ubi.sector      = ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad  = ubihis.tipo_unidad
ubi.referencia   = ubihis.referencia
ubi.f_alta       = DateTime(today(),now())
ubihis.zona      = var_zona
ubihis.fila      = var_fila
ubihis.altura    = var_altura
ubihis.cantidads = total_cantidad
ubihis.cantidade = 0

ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
ubi.zona         = ubihis.zona
ubi.fila         = ubihis.fila
ubi.altura       = ubihis.altura
ubi.existencias  = total_cantidad
ubi.ubicacion    = ubihis.ubicacion
ubihis.orden     = f_almparam_numorden(codigo_empresa,Year(Today()))
//-----------------------------------------------------------------------
// Tambien Inserto en el Historico de Movimientos ( la Salida Gobal)
//-----------------------------------------------------------------------
 movhis.empresa    =  ubihis.empresa  
 movhis.almacen    =  ubihis.almacen
 movhis.anyo       =  ubihis.anyo
 movhis.origen     =  "6"
 movhis.articulo   =  ubihis.articulo
 movhis.fechmov    =  ubihis.fecha
 movhis.tipomov    =  ubihis.tipomov
 movhis.cantidade  =  0
 movhis.cantidads  =  ubihis.cantidads
 movhis.precio     =  0
 movhis.codtercero = em_cliente.text
 movhis.numdoc     = STring(var_albaran[var_contador],"######")
 movhis.situacion  =  "N"
 SetNull(movhis.observaciones)
 SetNull( movhis.punteado)
 movhis.antexist   =    0
 movhis.familia    =  ubihis.familia
 movhis.subfamilia =  ubihis.subfamilia
 movhis.formato    =  ubihis.formato
 movhis.subformato =  ubihis.subformato
 movhis.modelo     =  ubihis.modelo
 movhis.calidad    =  ubihis.calidad
 movhis.tonochar   =  ubihis.tonochar
 movhis.calibre    =  ubihis.calibre
 movhis.tipo_unidad=  ubihis.tipo_unidad
 movhis.referencia =  ubihis.referencia
 movhis.f_alta     =  ubihis.f_alta
 movhis.usuario    =  ubihis.usuario
 movhis.tipo_pallet=  ubihis.tipo_pallet
 movhis.caja       =  ubihis.caja
 movhis.sector     =  ubihis.sector
 movhis.nummov     = f_almparam_nummov(movhis.empresa,Year(Today()))
 // Grabar el movimiento en el histrorico por el total de existencias
   IF NOT f_insert_almmovhis(movhis) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      var_bien=1
   END IF
   IF NOT f_actualiza_nummov(movhis.empresa,Year(Today()),movhis.nummov) THEN
       MessageBox("Error en proceso","Actualizando nummov.",Exclamation!, OK!,1)
		 var_bien=1
   END IF
 ubihis.nummov = movhis.nummov
//--------------------------------------------------------------------//
//                   la salida global               //
//--------------------------------------------------------------------//
  // En el historico de ubicaciones
   IF NOT f_insert_almlinubicahis(ubihis) THEN
      MessageBox("Error en proceso","Insertando en almlinubicahis",Exclamation!, OK!,1)
		var_bien=1
	END IF
   IF NOT f_actualiza_numorden(codigo_empresa,Year(Today()),ubihis.orden) THEN
       MessageBox("Error en proceso","Actualizando numorden.",Exclamation!, OK!,1)
       var_bien=1
   END IF
   
//-------------------Fin insercion movhis salida global  ----------------\\
dec{4} variable_nueva
IF dw_orden.GetItemString(elemento,"almlincargas_situacion_pedido") = "P" Then
	ubi.anyo    = dw_orden.GetItemNumber(elemento,"anyo_ped")
	ubi.pedido  = dw_orden.GetItemNumber(elemento,"pedido")
	ubi.linped  = dw_orden.GetItemNumber(elemento,"linea_ped")

	Select almlinubica.linea,almlinubica.existencias Into :ln,:variable_nueva From almlinubica
	Where  almlinubica.empresa    	  = :ubi.empresa
	And    almlinubica.ubicacion       = :ubi.ubicacion
	And    almlinubica.referencia 	  = :ubi.referencia
	And    almlinubica.anyo            = :ubi.anyo
	And    almlinubica.pedido          = :ubi.pedido
	And    almlinubica.linped          = :ubi.linped;
	IF Sqlca.sqlcode <> 0 Then 
		MessageBox("Seleccionando de almlinubica","Pedido"+String(ubi.pedido,"#####")+"/"+STring(ubi.linped,"#####")+ "" + sqlca.sqlerrtext,Exclamation!, OK!,1)
		var_bien = 1
	ELSE
		if variable_nueva<>ubihis.cantidads then 
			if  variable_nueva<ubihis.cantidads then 
				MessageBox("Seleccionando de almlinubica","No coincide Cantidad Pedido"+String(ubi.pedido,"#####")+"/"+STring(ubi.linped,"#####"),Exclamation!, OK!,1)
				var_bien = 1
			else
				UPDATE almlinubica
				sET existencias = existencias - :ubihis.cantidads
				Where  almlinubica.empresa    	  = :ubi.empresa
				And    almlinubica.ubicacion       = :ubi.ubicacion
				And    almlinubica.linea           = :ln;
				IF SQLCA.SQLCODE <> 0 Then
					MessageBox("Error en proceso","Modificacion de almlinubica",Exclamation!, OK!,1)
					var_bien = 1
				END IF
			end if
		else	
			Delete from almlinubica
			Where  almlinubica.empresa    	  = :ubi.empresa
			And    almlinubica.ubicacion       = :ubi.ubicacion
			And    almlinubica.linea           = :ln;
			IF SQLCA.SQLCODE <> 0 Then
				MessageBox("Error en proceso","Borrando de almlinubica" + sqlca.sqlerrtext,Exclamation!, OK!,1)
				var_bien = 1
			END IF
		END IF
	END IF
	
ELSE
			//---------------------------------------------------
			// LIneas No reservadas
			//----------------------------------------------
			// Borro en las ubicaciones correspondientes
			//----------------------------------------------
			ubi.tipo_pallet = ubihis.tipo_pallet
			ubi.caja = ubihis.caja
			 String sel
			 sel = " Select linea,existencias from almlinubica" +&
			       " Where  empresa     = '" + ubi.empresa    +"'"+&
					 " And    ubicacion   = '" + ubi.ubicacion  +"'"+&
					 " And    referencia  = '" + ubi.referencia +"'"+&
 					 " And    tipo_pallet = '" + ubi.tipo_pallet +"'"+&
					 " And    caja        = '" + ubi.caja +"'"+&
					 " And    pedido is Null"
			 Integer registros,x1

//			 dw_proceso2 = f_cargar_cursor2(sel)
			 f_cargar_cursor_nuevo(sel, dw_proceso2)
			 
			 dw_proceso2.Retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubi.tipo_pallet)
			 registros=dw_proceso2.RowCount()
			 cantidad_borrada=0
			 IF registros<>0 THEN
			  FOR x1=1 To registros
				cur_linea         =  dw_proceso2.GetItemNumber(x1,"linea")
				cur_existencias   =  dw_proceso2.GetItemNumber(x1,"existencias")
				  cantidad_pendiente = total_cantidad - cantidad_borrada
				  IF cantidad_pendiente=0 THEN   EXIT
				  IF cantidad_pendiente >= cur_existencias THEN 
						cantidad_borrada = cantidad_borrada + cur_existencias
						DELETE FROM almlinubica  
						WHERE almlinubica.empresa   = :ubi.empresa 
						AND  	almlinubica.ubicacion = :ubi.ubicacion 
						AND  	almlinubica.linea     = :cur_linea USING SQLCA;
						IF SQLCA.SQLCode<>0 THEN
					      MessageBox("Error en proceso","Borrando de almlinubica2"+ sqlca.sqlerrtext,Exclamation!, OK!,1)
							var_bien=1
						END IF
				  ELSE
						cur_existencias  = cur_existencias - cantidad_pendiente
						cantidad_borrada = cantidad_borrada + cantidad_pendiente

						UPDATE almlinubica  
						SET    existencias   = :cur_existencias
						WHERE  almlinubica.empresa   = :ubi.empresa 
						AND    almlinubica.ubicacion = :ubi.ubicacion 
						AND  	 almlinubica.linea     = :cur_linea ;
						
								IF SQLCA.SQLCode<>0 THEN
							      MessageBox("Error en proceso","Borrando de almlinubica",Exclamation!, OK!,1)
									var_bien=1
									EXIT
								END IF
				 END IF
			NEXT
			END IF
			IF cantidad_borrada <> total_cantidad THEN
				var_bien=1
				f_mensaje("Error",STring(cantidad_borrada)+ "<>" + STring(total_cantidad)+"  Cantidad Borrada no es igual ARTICULO:"+f_nombre_articulo(codigo_empresa,ubi.articulo))
			END IF
END IF



IF var_deposito = "S" Then
///-----------------------------------------------------------------
///---------   Grabar   entrada en el almacen de deposito   --------
///-----------------------------------------------------------------

	IF IsNull(var_almacen_deposito) or Trim(var_almacen_deposito)= "" Then
		var_bien = 1
		f_mensaje("Error en entrada de depositos","No hay almacen de deposito en la linea de carga")
	END IF
	// --------------------------------------------------------------------
	// ---------------------- Empezamos -----------------------------------
	// --------------------------------------------------------------------
	v_almacen = var_almacen_deposito
	IF IsNull(v_almacen) or Trim(v_almacen)= "" Then
		f_mensaje("Error de datos"," Este cliente no tiene almacen de deposito asignado")
		var_bien = 1
	END IF
 depmov.usuario       = nombre_usuario
 depubi.empresa       = codigo_empresa
 depubi.almacen       = v_almacen
 depubi.articulo      = ubi.articulo
 depubi.familia       = ubi.familia
 depubi.subfamilia    = ubi.subfamilia
 depubi.formato       = ubi.formato
 depubi.subformato    = ubi.subformato
 depubi.modelo        = ubi.modelo
 depubi.calidad       = ubi.calidad
 depubi.tonochar      = ubi.tonochar
 depubi.calibre       = ubi.calibre
 depubi.f_alta        = ubi.f_alta
 depubi.tipo_pallet   = ubi.tipo_pallet
 depubi.tipo_pallet   = ubi.caja
 depubi.tipo_unidad   = ubi.tipo_unidad
 depubi.referencia    = ubi.referencia     
 depubi.cliente       = var_cliente
 depubi.f_alta        = ubi.f_alta
// Valor movimiento historico
depmov.empresa     =  depubi.empresa
depmov.almacen     =  depubi.almacen
depmov.articulo    =  depubi.articulo
depmov.familia     =  depubi.familia
depmov.subfamilia  =  depubi.subfamilia
depmov.formato     =  depubi.formato
depmov.subformato  =  depubi.subformato
depmov.modelo      =  depubi.modelo
depmov.calidad     =  depubi.calidad
depmov.tonochar    =  depubi.tonochar
depmov.calibre     =  depubi.calibre
depmov.tipo_unidad =  depubi.tipo_unidad
depmov.tipo_pallet =  depubi.tipo_pallet
depmov.caja        =  depubi.caja
depmov.referencia  =  depubi.referencia
depmov.f_alta        =  DateTime(Today(),now())
fecha                =  Today()
depmov.anyo          =  year(fecha)
depmov.fechmov       = DateTime(fecha)
depmov.tipomov       = "1"
depmov.cantidade     = total_cantidad
depmov.cantidads     = 0
depmov.precio        = 0
depmov.codtercero    = var_cliente
depmov.numdoc        = STRING(var_albaran[var_contador],"###########")
depmov.situacion     = "N"
depmov.observaciones = ""
SetNull(depmov.punteado)
depmov.antexist   =0

  contador_nummov= f_depparam_nummov(codigo_empresa,Year(fecha))
  depmov.nummov     = contador_nummov
  depubi.existencias  = total_cantidad
  
       Select Count(*) Into :numero From  deplinubica  
       WHERE  deplinubica.empresa         = :depubi.empresa 
		 ANd    deplinubica.almacen         = :depubi.almacen
		 AND    deplinubica.referencia      = :depubi.referencia
		 AND    deplinubica.tipo_pallet     = :depubi.tipo_pallet 
		 AND    deplinubica.caja            = :depubi.caja 
		 USING SQLCA;
		 IF IsNull(numero) Then numero = 0
		 IF numero > 1 Then f_mensaje("Error","lineas duplicadas")
     IF numero <> 0 Then
     UPDATE deplinubica  
       SET existencias   = deplinubica.existencias + :depubi.existencias,   
       f_alta            = :depubi.f_alta
       WHERE  deplinubica.empresa         = :depubi.empresa 
		 ANd    deplinubica.almacen         = :depubi.almacen
		 AND    deplinubica.referencia      = :depubi.referencia
		 AND    deplinubica.tipo_pallet     = :depubi.tipo_pallet 
		 AND    deplinubica.caja            = :depubi.caja
		 USING SQLCA;
       IF SQLCA.SQLCode<>0 THEN  
			f_mensaje("Error",sqlca.sqlerrtext)
			var_bien=1
		END IF
	ELSE
	SELECT  max(deplinubica.linea)    INTO  :cur_linea  
    FROM   deplinubica  
   WHERE  deplinubica.empresa   = :depubi.empresa
	AND    deplinubica.almacen = :depubi.almacen;
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
    cur_linea = 0 
   END IF
    cur_linea=cur_linea+1
    depubi.linea=cur_linea
    IF NOT f_insert_deplinubica(depubi) Then 
		f_mensaje("Error","Al insertar en deplinubica")
		var_bien=1
	END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------
END IF
 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_depmovhis(depmov) Then
      MessageBox("Error en proceso","Grabando depmovhis",Exclamation!, OK!,1)
      var_bien=1
   END IF
   IF NOT f_actualiza_depnummov(depmov.empresa,Year(fecha),depmov.nummov) THEN
		   MessageBox("Error en proceso","Actualizando contador depmovhis",Exclamation!, OK!,1)
      var_bien=1
   END IF
END IF


destroy dw_proceso2

IF var_bien = 1 then 	
	Return FALSE
Else
	Return TRUE
End If
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Expedición de Ordenes de carga"
This.title=istr_parametros.s_titulo_ventana
paso = 1
em_fecha.text = String(Today(),"dd-mm-yy")
dw_ubicaciones.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)
dw_consulta.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_orden.SetTransObject(SQLCA)

uo_almacen_cargas.em_codigo.text    = f_almacen_venparametros(codigo_empresa)
uo_zona_cargas.em_codigo.text       = f_zona_venparametros(codigo_empresa)
uo_zona_cargas.em_campo.text        = f_nombre_zona_abr(codigo_empresa,uo_almacen_cargas.em_codigo.text,uo_zona_cargas.em_codigo.text)
uo_zona_cargas.ue_valor_anterior    = uo_zona_cargas.em_campo.text
uo_almacen_cargas.em_campo.text     = f_nombre_almacen(codigo_empresa,uo_almacen_cargas.em_codigo.text)
uo_almacen_cargas.ue_valor_anterior = uo_almacen_cargas.em_campo.text
end event

on w_int_preparacion_ordenes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.cb_1=create cb_1
this.uo_almacen_cargas=create uo_almacen_cargas
this.st_almacen_cargas=create st_almacen_cargas
this.dw_consulta=create dw_consulta
this.cb_marcar_todo=create cb_marcar_todo
this.uo_zona_cargas=create uo_zona_cargas
this.st_zona_cargas=create st_zona_cargas
this.st_fila_cargas=create st_fila_cargas
this.em_fila_cargas=create em_fila_cargas
this.em_altura_cargas=create em_altura_cargas
this.st_altura_cargas=create st_altura_cargas
this.st_operario=create st_operario
this.uo_operario=create uo_operario
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.st_albaran=create st_albaran
this.em_albaran=create em_albaran
this.listar=create listar
this.em_copias=create em_copias
this.st_copias=create st_copias
this.dw_temporal=create dw_temporal
this.dw_ubicaciones=create dw_ubicaciones
this.dw_albaranes=create dw_albaranes
this.dw_orden=create dw_orden
this.dw_detalle=create dw_detalle
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_cliente
this.Control[iCurrent+4]=this.st_nomcliente
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_almacen_cargas
this.Control[iCurrent+7]=this.st_almacen_cargas
this.Control[iCurrent+8]=this.dw_consulta
this.Control[iCurrent+9]=this.cb_marcar_todo
this.Control[iCurrent+10]=this.uo_zona_cargas
this.Control[iCurrent+11]=this.st_zona_cargas
this.Control[iCurrent+12]=this.st_fila_cargas
this.Control[iCurrent+13]=this.em_fila_cargas
this.Control[iCurrent+14]=this.em_altura_cargas
this.Control[iCurrent+15]=this.st_altura_cargas
this.Control[iCurrent+16]=this.st_operario
this.Control[iCurrent+17]=this.uo_operario
this.Control[iCurrent+18]=this.st_fecha
this.Control[iCurrent+19]=this.em_fecha
this.Control[iCurrent+20]=this.st_albaran
this.Control[iCurrent+21]=this.em_albaran
this.Control[iCurrent+22]=this.listar
this.Control[iCurrent+23]=this.em_copias
this.Control[iCurrent+24]=this.st_copias
this.Control[iCurrent+25]=this.dw_temporal
this.Control[iCurrent+26]=this.dw_ubicaciones
this.Control[iCurrent+27]=this.dw_albaranes
this.Control[iCurrent+28]=this.dw_orden
this.Control[iCurrent+29]=this.dw_detalle
this.Control[iCurrent+30]=this.st_6
end on

on w_int_preparacion_ordenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.cb_1)
destroy(this.uo_almacen_cargas)
destroy(this.st_almacen_cargas)
destroy(this.dw_consulta)
destroy(this.cb_marcar_todo)
destroy(this.uo_zona_cargas)
destroy(this.st_zona_cargas)
destroy(this.st_fila_cargas)
destroy(this.em_fila_cargas)
destroy(this.em_altura_cargas)
destroy(this.st_altura_cargas)
destroy(this.st_operario)
destroy(this.uo_operario)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.st_albaran)
destroy(this.em_albaran)
destroy(this.listar)
destroy(this.em_copias)
destroy(this.st_copias)
destroy(this.dw_temporal)
destroy(this.dw_ubicaciones)
destroy(this.dw_albaranes)
destroy(this.dw_orden)
destroy(this.dw_detalle)
destroy(this.st_6)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;IF paso  = 1 then
	f_cursor_arriba(dw_consulta)
ELSE
	f_cursor_arriba(dw_orden)
END IF
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;IF paso  = 1 then
	f_cursor_abajo(dw_consulta)
ELSE
	f_cursor_abajo(dw_orden)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF paso  = 1 then
	f_pagina_abajo(dw_consulta)
ELSE
	f_pagina_abajo(dw_orden)
END IF
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;IF paso  = 1 then
	f_pagina_arriba(dw_consulta)
ELSE
	f_pagina_arriba(dw_orden)
END IF
end event

event activate;call super::activate;w_int_preparacion_ordenes = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_preparacion_ordenes
integer y = 700
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_preparacion_ordenes
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_preparacion_ordenes
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_preparacion_ordenes
integer x = 2725
integer y = 8
integer width = 119
integer height = 108
integer taborder = 0
end type

type st_1 from statictext within w_int_preparacion_ordenes
integer x = 5
integer y = 132
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_int_preparacion_ordenes
integer x = 256
integer y = 120
integer width = 411
integer taborder = 20
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF
dw_detalle.Reset()
dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
dw_temporal.Reset()

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_int_preparacion_ordenes
integer x = 672
integer y = 128
integer width = 1189
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_int_preparacion_ordenes
integer x = 2510
integer y = 1356
integer width = 343
integer height = 64
integer taborder = 0
string text = "Continuar"
end type

event clicked;call super::clicked;
IF dw_consulta.GetRow() = 0 Then Return
dw_orden.Retrieve(codigo_empresa,em_cliente.text)

Dec t,var_anyo,var_orden,var_linea,n
For t = 1 To dw_orden.RowCount()
	IF dw_orden.GetItemString(t,"situacion") = "F" Then dw_orden.SetItem(t,"marcado","")
	var_anyo   = dw_orden.GetItemNumber(t,"anyo")
	var_orden  = dw_orden.GetItemNumber(t,"orden")
	var_linea  = dw_orden.GetItemNumber(t,"linea")
	n =  dw_temporal.find("anyo=" + String(var_anyo,"####") + "and orden=" + String(var_orden,"###############") + "and linea=" + String(var_linea,"############"),1,dw_temporal.RowCount())
	IF IsNULL(n) Then n = 0
	IF n = 0 Then		dw_orden.SetItem(t,"cok","N")

NEXT
dw_orden.SetFilter("cok = 'S'")
dw_orden.Filter()
cb_1.visible = FALSE
f_campos(TRUE)
em_albaran.text = ""
f_activar_campo(uo_operario.em_campo)
dw_orden.SetSort("suborden,venped_deposito,venped_agrupa_exp,anyo_ped,pedido,linea_ped")
dw_orden.Sort()
dw_orden.SetRow(1)
dw_orden.SelectRow(0,FALSE)
dw_orden.SelectRow(1,TRUE)

end event

type uo_almacen_cargas from u_em_campo_2 within w_int_preparacion_ordenes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 9
integer y = 1352
integer width = 411
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_almacen_cargas.em_campo.text=f_nombre_almacen_abr(codigo_empresa,uo_almacen_cargas.em_codigo.text)
IF Trim(uo_almacen_cargas.em_campo.text)="" THEN 
 IF Trim(uo_almacen_cargas.em_codigo.text) <> "" Then
	uo_almacen_cargas.em_campo.SetFocus()
END IF
 uo_almacen_cargas.em_campo.text  = ""
 uo_almacen_cargas.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de almacenes"
ue_datawindow = "dw_ayuda_almacenes"
ue_filtro     = ""

end event

on uo_almacen_cargas.destroy
call u_em_campo_2::destroy
end on

type st_almacen_cargas from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 9
integer y = 1284
integer width = 411
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "ALMACEN"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_consulta from u_datawindow_consultas within w_int_preparacion_ordenes
integer y = 224
integer width = 434
integer height = 1052
integer taborder = 0
string dataobject = "dw_int_preparacion_ordenes"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF This.GetRow() = 0 Then Return
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text,f_valor_columna(This,GetRow(),"matricula"))
end event

event retrieveend;call super::retrieveend;IF This.RowCOUNT() <> 0 Then
	dw_detalle.Retrieve(codigo_empresa,em_cliente.text,f_valor_columna(This,1,"matricula"))
	SetRow(1)
END IF
end event

type cb_marcar_todo from u_boton within w_int_preparacion_ordenes
event clicked pbm_bnclicked
boolean visible = false
integer x = 2510
integer y = 1292
integer width = 343
integer height = 64
integer taborder = 0
string text = "Marca Todo"
end type

event clicked;call super::clicked;Integer reg
For reg = 1 To dw_orden.rowCount()
	IF dw_orden.GetItemString(reg,"almlincargas_situacion_pedido") <> "F" Then
		f_asignar_columna(dw_orden,reg,"marcado","X")
		dw_orden.ScrollToRow(reg)
	END IF
Next
end event

type uo_zona_cargas from u_em_campo_2 within w_int_preparacion_ordenes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 421
integer y = 1352
integer width = 142
integer height = 80
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_zona_cargas.em_campo.text=f_nombre_zona_abr(codigo_empresa,uo_almacen_cargas.em_codigo.text,uo_zona_cargas.em_codigo.text)
IF Trim(uo_zona_cargas.em_campo.text)="" THEN 
 IF Trim(uo_zona_cargas.em_codigo.text) <> "" Then
	uo_zona_cargas.em_campo.SetFocus()
END IF
 uo_zona_cargas.em_campo.text  = ""
 uo_zona_cargas.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de zonas"
ue_datawindow = "dw_ayuda_almubizonas"
ue_filtro     = "almacen = '" + uo_almacen_cargas.em_codigo.text + "'"

end event

on uo_zona_cargas.destroy
call u_em_campo_2::destroy
end on

type st_zona_cargas from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 421
integer y = 1284
integer width = 142
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Zn"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_fila_cargas from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 562
integer y = 1284
integer width = 137
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Fil"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fila_cargas from u_em_campo within w_int_preparacion_ordenes
boolean visible = false
integer x = 558
integer y = 1352
integer width = 137
integer height = 80
integer taborder = 60
alignment alignment = center!
end type

type em_altura_cargas from u_em_campo within w_int_preparacion_ordenes
boolean visible = false
integer x = 695
integer y = 1352
integer width = 142
integer height = 80
integer taborder = 70
boolean bringtotop = true
alignment alignment = center!
end type

type st_altura_cargas from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 699
integer y = 1284
integer width = 137
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Al"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_operario from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 837
integer y = 1284
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

type uo_operario from u_em_campo_2 within w_int_preparacion_ordenes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 837
integer y = 1352
integer width = 672
integer height = 80
integer taborder = 80
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

type st_fecha from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 1513
integer y = 1284
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

type em_fecha from u_em_campo within w_int_preparacion_ordenes
boolean visible = false
integer x = 1513
integer y = 1352
integer width = 297
integer height = 80
integer taborder = 90
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_albaran from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 1810
integer y = 1284
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

type em_albaran from u_em_campo within w_int_preparacion_ordenes
boolean visible = false
integer x = 1810
integer y = 1352
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

type listar from radiobutton within w_int_preparacion_ordenes
boolean visible = false
integer x = 2085
integer y = 1376
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

type em_copias from u_em_campo within w_int_preparacion_ordenes
boolean visible = false
integer x = 2277
integer y = 1292
integer width = 183
integer height = 68
integer taborder = 10
string text = "1"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
boolean spin = true
string displaydata = "("
end type

type st_copias from statictext within w_int_preparacion_ordenes
boolean visible = false
integer x = 2089
integer y = 1292
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

type dw_temporal from datawindow within w_int_preparacion_ordenes
boolean visible = false
integer x = 1513
integer y = 12
integer width = 1102
integer height = 228
string dataobject = "dw_int_preparacion_ordenes3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_ubicaciones from datawindow within w_int_preparacion_ordenes
boolean visible = false
integer x = 352
integer y = 484
integer width = 2030
integer height = 564
boolean titlebar = true
string title = "Asignacion de Ubicaciones."
string dataobject = "dw_int_preparacion_ordenes4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String ubi

Dec var_anyo,var_orden,var_linea
IF row = 0 Then Return
IF dw_orden.GetRow()= 0 Then Return
IF dw_orden.GetItemString(dw_orden.GetRow(),"almlincargas_situacion_pedido") = "P" Then Return
var_almacen  = GetItemString(row,"almlinubica_almacen")
var_zona     = GetItemString(row,"zona")
var_fila     = GetItemNumber(row,"fila")
var_altura   = GetItemNumber(row,"altura")
var_anyo   = dw_orden.GetItemNumber(dw_orden.GetRow(),"anyo")
var_orden   = dw_orden.GetItemNumber(dw_orden.GetRow(),"orden")
var_linea  = dw_orden.GetItemNumber(dw_orden.GetRow(),"linea")
ubi = f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura)
IF f_ubi_exist(codigo_empresa,var_almacen,var_zona,var_fila,var_altura) Then
   	f_asignar_columna(dw_orden,dw_orden.GetRow(),"ubicacion",ubi)
		Update   almlincargas
		Set      almlincargas.ubicacion = :ubi
		Where    almlincargas.empresa  = :codigo_empresa
		And      almlincargas.anyo     = :var_anyo
		And      almlincargas.orden    = :var_orden
		And      almlincargas.linea    = :var_linea;
		Commit;
ELSE
	f_mensaje("Error en datos","La ubicacion no existe")
END IF
This.visible = FALSE
dw_orden.enabled = TRUE

end event

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	dw_ubicaciones.visible = FALSE
	dw_orden.enabled = TRUE
END IF
end event

type dw_albaranes from datawindow within w_int_preparacion_ordenes
boolean visible = false
integer x = 1970
integer y = 948
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
Reset()
visible= FALSE
end event

type dw_orden from u_datawindow_consultas within w_int_preparacion_ordenes
boolean visible = false
integer y = 224
integer width = 2866
integer height = 1052
integer taborder = 0
string dataobject = "dw_int_preparacion_ordenes2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec var_anyo,var_orden,var_linea,var_cajas,var_pallets,var_total_cajas
IF f_objeto_datawindow(This) = "salir" Then
 	f_salir()
 	Return
END IF

IF f_objeto_datawindow(This) = "procesar" Then
	IF f_control_existencias() Then	f_proceso()
 	Return
END IF


var_anyo_albaran = Year(Today())
IF f_objeto_datawindow(This) = "expedir" Then
	IF Trim(uo_operario.em_codigo.text) = "" Then
		f_mensaje("Campo Obligatorio","Introduzca el Operario")
		f_activar_campo(uo_operario.em_campo)
		Return
	END IF
 	IF f_control_existencias() Then f_expedir()
	 dw_temporal.Reset()
 	Return
END IF

IF f_objeto_datawindow(This) = "preparar" Then
 	f_preparar()
 	Return
END IF


IF f_objeto_datawindow(This) = "pallet_menos" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_orden.GetItemNumber(GetRow(),"anyo")		
		var_orden = dw_orden.GetItemNumber(GetRow(),"orden")		
		var_linea = dw_orden.GetItemNumber(GetRow(),"linea")		
		var_pallets = dw_orden.GetItemNumber(GetRow(),"almlincargas_pallets")		
		if var_pallets = 0 or isnull(var_pallets) then return
		Update   almlincargas
		Set      almlincargas.pallets = pallets - 1
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"almlincargas_pallets",var_pallets -1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "pallet_mas" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_orden.GetItemNumber(GetRow(),"anyo")		
		var_orden = dw_orden.GetItemNumber(GetRow(),"orden")		
		var_linea = dw_orden.GetItemNumber(GetRow(),"linea")		
		var_pallets = dw_orden.GetItemNumber(GetRow(),"almlincargas_pallets")		
		Update   almlincargas
		Set      almlincargas.pallets = pallets + 1
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"almlincargas_pallets",var_pallets +1)
	 	Return
	END IF
END IF



IF f_objeto_datawindow(This) = "caja_mas" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_orden.GetItemNumber(GetRow(),"anyo")		
		var_orden = dw_orden.GetItemNumber(GetRow(),"orden")		
		var_linea = dw_orden.GetItemNumber(GetRow(),"linea")		
		var_cajas = dw_orden.GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = dw_orden.GetItemNumber(GetRow(),"total_cajas")		
		Update   almlincargas
		Set      almlincargas.cajas = cajas + 1,
		         almlincargas.total_cajas = total_cajas + 1
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"cajas",var_cajas +1)
		SetItem(GetRow(),"total_cajas",var_total_cajas +1)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "caja_menos" Then
	IF GetRow() <> 0  Then
		var_anyo = dw_orden.GetItemNumber(GetRow(),"anyo")		
		var_orden = dw_orden.GetItemNumber(GetRow(),"orden")		
		var_linea = dw_orden.GetItemNumber(GetRow(),"linea")		
		var_cajas = dw_orden.GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = dw_orden.GetItemNumber(GetRow(),"total_cajas")		
      if var_total_cajas = 0 or isnull(var_total_cajas) then return
		Update   almlincargas		
		Set      almlincargas.cajas = cajas - 1,
		         almlincargas.total_cajas = total_cajas - 1
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"cajas",var_cajas -1)
		SetItem(GetRow(),"total_cajas",var_total_cajas -1)
	 	Return
	END IF
END IF




end event

event rowfocuschanged;call super::rowfocuschanged;IF dw_orden.GetRow() <> 0 Then
	var_almacen = f_almacen_ubicacion(f_valor_columna(dw_orden,dw_orden.GetRow(),"ubicacion"))
	var_zona    = f_zona_ubicacion(f_valor_columna(dw_orden,dw_orden.GetRow(),"ubicacion"))
	var_fila    = f_fila_ubicacion(f_valor_columna(dw_orden,dw_orden.GetRow(),"ubicacion"))
	var_altura  = f_altura_ubicacion(f_valor_columna(dw_orden,dw_orden.GetRow(),"ubicacion"))
ELSE
	var_almacen = ""
	var_zona    = ""
	var_fila    = 0
	var_altura  = 0
END IF

end event

event doubleclicked;call super::doubleclicked;IF row = 0  or IsNull(row)Then return
IF This.GetRow() = 0 Then Return
IF dw_orden.GetItemString(This.GetRow(),"almlincargas_situacion_pedido") <> "F" Then
	IF f_valor_columna(This,GetRow(),"marcado") = "X" Then
		f_asignar_columna(This,GetRow(),"marcado","")
	ELSE
		f_asignar_columna(This,GetRow(),"marcado","X")
	END IF
END IF
end event

event rbuttondown;call super::rbuttondown;String  var_calidad,var_tipo_pallet,var_articulo,var_almacen_de_carga
string  var_tono,var_caja
Dec{0}  var_calibre
IF GetRow()= 0 Then Return
IF This.GetItemString(GetRow(),"almlincargas_situacion_pedido") = "P" Then Return
var_articulo    = This.GetItemString(GetRow(),"articulo") 
var_calidad     = This.GetItemString(GetRow(),"calidad")  
var_tipo_pallet = This.GetItemString(GetRow(),"tipo_pallet")  
var_caja        = This.GetItemString(GetRow(),"almlincargas_caja") 
var_calibre     = This.GetItemNumber(GetRow(),"calibre")  
var_tono        = This.GetItemString(GetRow(),"tonochar")  
var_almacen_de_carga = This.GetItemString(GetRow(),"almlincargas_almacen_de_carga")  
this.enabled = FALSE
dw_ubicaciones.visible = TRUE
dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre,var_tipo_pallet,var_caja,var_almacen_de_carga)


end event

type dw_detalle from datawindow within w_int_preparacion_ordenes
event doubleclicked pbm_dwnlbuttondblclk
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 434
integer y = 224
integer width = 2418
integer height = 1052
string dataobject = "dw_int_preparacion_ordenes1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 Then Return
Dec t,num,d
Dec{0}  var_orden,var_linea,var_anyo
IF RowCount() = 0 Then return
   t = GetRow()
		var_anyo  = GetItemNumber(t,"anyo")
		var_orden = GetItemNumber(t,"orden")
		var_linea = GetItemNumber(t,"linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and orden=" + String(var_orden) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num= 0 Then
			SetItem(t,"marcado","X")
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"orden",var_orden)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"linea",var_linea)
		ELSE
			SetItem(t,"marcado","")
			dw_temporal.DeleteRow(num)
		END IF

  

end event

event retrieveend;Integer t
Dec{0}  var_orden,var_linea,var_anyo
IF RowCount() = 0 Then return
For t = 1 To RowCount()
	var_anyo  = GetItemNumber(t,"anyo")
	var_orden = GetItemNumber(t,"orden")
	var_linea = GetItemNumber(t,"linea")
	IF dw_temporal.find("anyo=" + String(var_anyo) + "and orden=" + String(var_orden) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())<> 0 Then
		SetItem(t,"marcado","X")
	END IF
NEXT
end event

event clicked;Dec t,num,d
Dec{0}  var_orden,var_linea,var_anyo

IF f_objeto_datawindow(dw_detalle) = "todo" Then
IF RowCount() = 0 Then Return
FOR t = 1 To RowCount()
		var_anyo  = GetItemNumber(t,"anyo")
		var_orden = GetItemNumber(t,"orden")
		var_linea = GetItemNumber(t,"linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and orden=" + String(var_orden) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num = 0 Then
			SetItem(t,"marcado","X")
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"orden",var_orden)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"linea",var_linea)
		END IF

NEXT
END IF
end event

type st_6 from statictext within w_int_preparacion_ordenes
integer y = 112
integer width = 3122
integer height = 300
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

