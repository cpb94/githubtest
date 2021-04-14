$PBExportHeader$w_expedir_pedidos_cmr.srw
forward
global type w_expedir_pedidos_cmr from w_int_con_empresa
end type
type pb_1 from upb_salir within w_expedir_pedidos_cmr
end type
type st_1 from statictext within w_expedir_pedidos_cmr
end type
type em_cliente from u_em_campo within w_expedir_pedidos_cmr
end type
type st_nomcliente from statictext within w_expedir_pedidos_cmr
end type
type cb_marcar_todo from u_boton within w_expedir_pedidos_cmr
end type
type st_operario from statictext within w_expedir_pedidos_cmr
end type
type uo_operario from u_em_campo_2 within w_expedir_pedidos_cmr
end type
type st_fecha from statictext within w_expedir_pedidos_cmr
end type
type em_fecha from u_em_campo within w_expedir_pedidos_cmr
end type
type st_albaran from statictext within w_expedir_pedidos_cmr
end type
type em_albaran from u_em_campo within w_expedir_pedidos_cmr
end type
type listar from radiobutton within w_expedir_pedidos_cmr
end type
type em_copias from u_em_campo within w_expedir_pedidos_cmr
end type
type st_copias from statictext within w_expedir_pedidos_cmr
end type
type cb_1 from u_boton within w_expedir_pedidos_cmr
end type
type dw_temporal from datawindow within w_expedir_pedidos_cmr
end type
type dw_albaranes from datawindow within w_expedir_pedidos_cmr
end type
type dw_ubicaciones from datawindow within w_expedir_pedidos_cmr
end type
type dw_1 from datawindow within w_expedir_pedidos_cmr
end type
type cb_expedir_promocion from u_boton within w_expedir_pedidos_cmr
end type
type uo_zona_carga from u_em_campo_2 within w_expedir_pedidos_cmr
end type
type st_2 from statictext within w_expedir_pedidos_cmr
end type
type dw_pedido from u_datawindow_consultas within w_expedir_pedidos_cmr
end type
type dw_detalle from u_datawindow_consultas within w_expedir_pedidos_cmr
end type
type cbx_muestras from checkbox within w_expedir_pedidos_cmr
end type
type es_cliente from dropdownlistbox within w_expedir_pedidos_cmr
end type
type dw_consulta_muestras from u_datawindow_consultas within w_expedir_pedidos_cmr
end type
type dw_consulta from u_datawindow_consultas within w_expedir_pedidos_cmr
end type
type dw_listado_cmr from datawindow within w_expedir_pedidos_cmr
end type
type cb_2 from u_boton within w_expedir_pedidos_cmr
end type
type cb_3 from commandbutton within w_expedir_pedidos_cmr
end type
type cb_4 from commandbutton within w_expedir_pedidos_cmr
end type
type st_cmr from statictext within w_expedir_pedidos_cmr
end type
type em_cmr from u_em_campo within w_expedir_pedidos_cmr
end type
end forward

global type w_expedir_pedidos_cmr from w_int_con_empresa
integer width = 3607
integer height = 2032
pb_1 pb_1
st_1 st_1
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
dw_temporal dw_temporal
dw_albaranes dw_albaranes
dw_ubicaciones dw_ubicaciones
dw_1 dw_1
cb_expedir_promocion cb_expedir_promocion
uo_zona_carga uo_zona_carga
st_2 st_2
dw_pedido dw_pedido
dw_detalle dw_detalle
cbx_muestras cbx_muestras
es_cliente es_cliente
dw_consulta_muestras dw_consulta_muestras
dw_consulta dw_consulta
dw_listado_cmr dw_listado_cmr
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
st_cmr st_cmr
em_cmr em_cmr
end type
global w_expedir_pedidos_cmr w_expedir_pedidos_cmr

type variables
Dec{0} paso,nueva_ln_pedido,peso,peso_neto
Dec{0}  var_anyo_albaran,veces
Dec{0} control_lineas = 0
Dec{0} lin_alb = 0
String  v_deposito,contenedor
String observaciones = ""
String precinto, matricula,transportista_char,remolque,is_agencia,is_conductor
Dec    var_albaran[]
Dec    var_contador  = 0
long   il_contador_array_albaranes
boolean lb_cerrar_ventana = true
str_albaranes_a_generar istr_albaranes_a_generar[],istr_albaranes_a_generar_vacio[]


end variables

forward prototypes
public subroutine f_campos (boolean bool)
public subroutine f_salir ()
public function boolean f_proceso_pedidos (integer elemento)
public subroutine f_expedir ()
public function boolean f_grabar_albaran (integer reg)
public function boolean f_control_existencias ()
public function boolean f_expedir_pedido (integer elemento)
public function boolean f_grabar_salida_ventas (integer elemento)
public subroutine f_todo ()
public subroutine f_marcar_linea (integer t)
public subroutine f_control_marcar_linea (integer t)
public subroutine f_desmarcar_linea (integer t)
public subroutine f_nada ()
public function integer f_calcula_albaranes_a_generar ()
end prototypes

public subroutine f_campos (boolean bool);dw_pedido.visible = bool
cb_marcar_todo.visible    = bool
st_operario.visible       = bool
uo_operario.visible       = bool
st_fecha.visible       = bool
em_fecha.visible       = bool
st_albaran.visible       = bool
em_albaran.visible       = bool
st_cmr.visible           = bool
em_cmr.visible           = bool
listar.visible = bool
st_copias.visible = bool
em_copias.visible = bool
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

public subroutine f_salir ();cb_1.visible       = TRUE
f_campos(FALSE)
dw_temporal.Reset()
var_contador = 1
//dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
em_cliente.triggerevent("modificado")

end subroutine

public function boolean f_proceso_pedidos (integer elemento);Dec{0} var_pedido,var_anyo_pedido,var_linea_pedido
Dec{0} var_anyo,var_orden,var_linea
string cadena
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga,var_cantidad_carga
Integer var_bien

var_bien = 0
str_venliped linped

var_anyo              = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
var_pedido            = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
var_linea             = dw_pedido.GetItemNumber(elemento,"venliped_linea")
var_pallets_carga     = dw_pedido.GetItemNumber(elemento,"venliped_pallets")
var_cajas_carga       = dw_pedido.GetItemNumber(elemento,"venliped_cajas")
var_total_cajas_carga = dw_pedido.GetItemNumber(elemento,"venliped_total_cajas")
var_cantidad_carga    = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")

linped.empresa   =   codigo_empresa
linped.anyo      =   var_anyo
linped.pedido    =   var_pedido
linped.linea     =   var_linea

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
cadena = f_calculo_unidades(codigo_empresa,linped.articulo,linped.tipo_pallet,linped.caja,0,0,linped.cantidad)
                       
linped.pallets       = Dec(Mid(cadena,1,6))
linped.cajas         = Dec(Mid(cadena,7,6))
linped.total_cajas   = Dec(Mid(cadena,13,6))
linped.cantidad      = Dec(Mid(cadena,19,9))

IF linped.cantidad <> 0 then
	
	UPDATE venliped
	Set    venliped.pallets     = :linped.pallets,
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

	Select Max(venliped.linea) 
	Into   :linped.linea 
	From   venliped
	Where  venliped.empresa  = :codigo_empresa
	And    venliped.anyo     = :var_anyo_pedido
	And    venliped.pedido   = :var_pedido;
	
	linped.linea = linped.linea + 1

	linped.cantidad = var_cantidad_carga
	cadena          = f_calculo_unidades(codigo_empresa,linped.articulo,linped.tipo_pallet,linped.caja,0,0,linped.cantidad)
                       
	linped.pallets       = Dec(Mid(cadena,1,6))
	linped.cajas         = Dec(Mid(cadena,7,6))
	linped.total_cajas   = Dec(Mid(cadena,13,6))
	linped.cantidad      = Dec(Mid(cadena,19,9))
	linped.situacion     = "P"
	
	nueva_ln_pedido      = linped.linea
	
	IF Not f_insertar_venliped(linped)  Then 
		var_bien = 1
		f_mensaje("Error en datos en insercion ln pedido",sqlca.sqlerrtext)
	END IF
	IF Not f_actualizar_linea_venpedido(codigo_empresa,linped.anyo,linped.pedido,linped.linea) Then var_bien = 1
	
ELSE
	
	UPDATE venliped
	Set    venliped.situacion  = "P"
	WHERE  (venliped.empresa   = :codigo_empresa )
	AND    (venliped.anyo      = :var_anyo_pedido )
	AND    (venliped.pedido    = :var_pedido )
	AND    (venliped.linea     = :var_linea_pedido );
	
	IF SQLCA.SQLCODE <> 0  Then 
		var_bien = 1
		f_mensaje("Error en datos(2)",sqlca.sqlerrtext)
	END IF
	
END IF

IF Not f_actualizar_venpedido(codigo_empresa,var_anyo_pedido,var_pedido) Then var_bien = 1

UPDATE almlincargas
Set    almlincargas.anyo_ped         = :var_anyo_pedido,
	    almlincargas.pedido           = :var_pedido,
		 almlincargas.linea_ped        = :linped.linea,
		 almlincargas.situacion_pedido = "P"	  
Where  almlincargas.empresa          = :codigo_empresa
And    almlincargas.anyo             = :var_anyo
And    almlincargas.orden            = :var_orden
And    almlincargas.linea            = :var_linea;

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

public subroutine f_expedir ();Integer reg,reg1,bien,v_calibre
long    ll_indice,ll_total,ll_albaranes_promocion_en_cmr
Dec{0}  var_anyo,var_pedido,var_linea,nu,ante_pedido,jj
Dec{4}  v_cantidad //,v_disponible
dec{6}  ld_peso_neto_original,ld_peso_bruto_original
dec{6}  ld_factor_correccion_peso_neto, ld_factor_correccion_peso_bruto
String  v_articulo,v_calidad,v_tipo_pallet,v_referencia,v_antedep,ub,&
		  var_agrupa,var_clase,ante_clase,v_caja,v_tono
String  men,ante_agrupa,var_tipolinea,imprimir_cmr
string  ls_sel,ls_codigo_cmr
long    ll_ant_albaran,ll_albaran,ll_diferencia_pallets,ll_lineas_albaran,ll_total_lineas_albaran
long    ll_indice_lineas_alb,ll_pallets_a_anyadir_linea,ll_linea_albaran,ll_resultado_impresion
dec ld_peso_bruto_total_modificado,ld_peso_neto_total_modificado
dec ld_diferencia_peso_bruto,ld_diferencia_peso_neto
dec ld_peso_bruto_maximo_linea
long ll_linea_a_modificar_peso,ll_pallets_albaran
datastore ds_datos
//-----------------------------------------------------------------------

lb_cerrar_ventana = false	

var_contador = 0
ante_agrupa  = ""
ante_pedido  = 0
v_antedep    = ""
							
peso      = Dec(dw_pedido.GetItemString(1,"total_peso"))
peso_neto = Dec(dw_pedido.GetItemString(1,"total_peso_neto"))

//IF Dec(em_albaran.text) <> 0 Then
//	peso      = peso + f_peso_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))
//	peso_neto = peso_neto + f_peso_neto_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))	
//	em_fecha.text = String(Date(f_fentrega_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))),"dd-mm-yy")
//END IF
IF Dec(em_albaran.text) <> 0 Then
	ll_albaran = Dec(em_albaran.text)
	
	select venalb.peso,
			 venalb.peso_neto,
			 sum(venlialb.pallets)
	into   :peso,
			 :peso_neto,
			 :ll_pallets_albaran
	from   venalb,venlialb
	where  venalb.empresa = venlialb.empresa
	and    venalb.anyo    = venlialb.anyo
	and    venalb.albaran = venlialb.albaran
	and    venalb.empresa = :codigo_empresa
	and    venalb.anyo    = :var_anyo_albaran
	and    venalb.albaran = :ll_albaran
	group  by venalb.peso,venalb.peso_neto;
	
	if isnull(peso) then peso = 0
	if isnull(peso_neto) then peso_neto = 0
	if isnull(ll_pallets_albaran) then ll_pallets_albaran = 0
	
//	peso          = peso + f_peso_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))
//	peso_neto     = peso_neto + f_peso_neto_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))	
	em_fecha.text = String(Date(f_fentrega_venalb(codigo_empresa,var_anyo_albaran,Dec(em_albaran.text))),"dd-mm-yy")
	
	//Añadimos el peso del albaran sobre el que acumulamos al primer albaran a generar
	istr_albaranes_a_generar[1].peso_bruto_real  = istr_albaranes_a_generar[1].peso_bruto_real + peso
	istr_albaranes_a_generar[1].peso_neto_real	= istr_albaranes_a_generar[1].peso_neto_real + peso_neto
	istr_albaranes_a_generar[1	].pallets_reales = istr_albaranes_a_generar[1].pallets_reales + ll_pallets_albaran
END IF

ld_peso_neto_original  = peso_neto
ld_peso_bruto_original = peso

tipo_array val,ida

ida.valor[1]=em_cliente.text

ll_total = upperbound(istr_albaranes_a_generar)

ida.valor[2]=string(ll_total)

for ll_indice = 1 to ll_total
	ida.valor[(ll_indice * 4)+1] = string(istr_albaranes_a_generar[ll_indice].peso_bruto_real)
	ida.valor[(ll_indice * 4)+2] = string(istr_albaranes_a_generar[ll_indice].peso_neto_real)
	ida.valor[(ll_indice * 4)+3] = string(istr_albaranes_a_generar[ll_indice].pallets_reales)
	ida.valor[(ll_indice * 4)+4] = string(istr_albaranes_a_generar[ll_indice].lineas_pedidos)
next
 
//istr_albaranes_a_generar[ll_indice_albaranes].anyo                  = 0
//istr_albaranes_a_generar[ll_indice_albaranes].albaran               = 0
//istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real        = 0
//istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real       = 0
//istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_modificado  = 0
//istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_modificado = 0			

//openWithParm(w_pedir_datos_expedicion,STring(peso))
openWithParm(w_pedir_datos_expedicion,ida)

val =  message.powerObjectparm

IF val.valor[1] = "RETURN" Then 
	lb_cerrar_ventana = true	
	Return
end if

if not(isdate(em_fecha.text)) or year(date(em_fecha.text)) = 1900 then
	messagebox("Atención!!","Fecha no valida")
	lb_cerrar_ventana = true
	return
end if

observaciones = val.valor[1]
peso          = Dec(val.valor[2])
contenedor    = val.valor[3]
precinto      = val.valor[4]
matricula     = val.valor[5]
transportista_char = val.valor[6]
peso_neto     = Dec(val.valor[7])
remolque      = val.valor[8]
imprimir_cmr  = val.valor[9]
is_agencia    = val.valor[10]
is_conductor  = val.valor[11]
//Gno

for ll_indice = 1 to ll_total
	istr_albaranes_a_generar[ll_indice].peso_bruto_modificado = dec(val.valor[7 + (ll_indice * 4)+2])
	istr_albaranes_a_generar[ll_indice].peso_neto_modificado  = dec(val.valor[7 + (ll_indice * 4)+3])
	istr_albaranes_a_generar[ll_indice].pallets_modificados   = dec(val.valor[7 + (ll_indice * 4)+4])
next
//Fin gno

//Se hace al final del proceso
//if ld_peso_neto_original <> 0 then 
//	ld_factor_correccion_peso_neto  = peso_neto / ld_peso_neto_original 
//else
//	ld_factor_correccion_peso_neto  = 1
//end if    
//
//if ld_peso_bruto_original <> 0 then
//	ld_factor_correccion_peso_bruto = peso / ld_peso_bruto_original 
//else
//   ld_factor_correccion_peso_bruto = 1
//end if

IF Dec(em_albaran.text) <> 0 and ll_total = 1 Then
	IF MessageBox("Proceso Generación albaranes","¿Desea acumular sobre el albaran seleccionado?",Question!,YesNo!) = 2 Then
		em_albaran.text = "0"
	END IF
else
	if Dec(em_albaran.text) <> 0 and ll_total > 1 then
		MessageBox("Proceso Generación albaranes","Se va a generar mas de un albaran.~nNo se agrupara.",StopSign!)
	end if
	em_albaran.text = "0"
END IF
reg1 = dw_pedido.RowCount()
For reg = 1 To reg1
	IF dw_pedido.GetItemSTring(reg,"cmarcado") = "X" Then

	ub  = dw_pedido.GetItemSTring(reg,"cubicacion")
	var_tipolinea = dw_pedido.GetItemSTring(reg,"venliped_tipolinea")
		IF IsNUll(ub) or Trim(ub)= "" and f_control_almacen_ventipolin(codigo_empresa,var_tipolinea)="S" Then
			f_mensaje("Control ubicaciones asignadas","El articulo "+ f_nombre_articulo(codigo_empresa,dw_pedido.GetItemString(reg,"venliped_articulo")) + " No tiene ubicacion asignada")
			f_activar_campo(uo_operario.em_campo)
			lb_cerrar_ventana = true
			Return 
		END IF
	END IF
NEXT

bien  = 0
veces = 0

//SetNull(v_antedep)
IF Not f_bloquear_almacen(title)  Then
IF Not f_bloquear_albaranes(title)  Then
	ll_ant_albaran= 0
	
For reg = 1 To reg1
			f_mensaje_proceso("Procesando..:",reg,reg1)
			IF dw_pedido.GetItemSTring(reg,"cmarcado") = "X" Then
						var_anyo        = dw_pedido.GetItemNumber(reg,"venliped_anyo")
						var_pedido      = dw_pedido.GetItemNumber(reg,"venliped_pedido")
						var_linea       = dw_pedido.GetItemNumber(reg,"venliped_linea")
						v_articulo      = dw_pedido.GetItemString(reg,"venliped_articulo")
						var_clase       = dw_pedido.GetItemString(reg,"venliped_clase")
						var_agrupa      = dw_pedido.GetItemString(reg,"venped_agrupa_exp")
						v_calidad       = dw_pedido.GetItemString(reg,"venliped_calidad")
						v_tono          = dw_pedido.GetItemString(reg,"venliped_tonochar")
						v_calibre       = dw_pedido.GetItemNumber(reg,"venliped_calibre")
						v_tipo_pallet   = dw_pedido.GetItemString(reg,"venliped_tipo_pallet")
						v_caja          = dw_pedido.GetItemString(reg,"venliped_caja")
						v_cantidad      = dw_pedido.GetItemNumber(reg,"venliped_cantidad")
						v_deposito      = dw_pedido.GetItemString(reg,"venliped_deposito")
						ll_albaran      = dw_pedido.object.albaran[reg]
						//-------------------------------------------------------------------//
						// Control disponible   // 
						//-------------------------------------------------------------------//
						 v_referencia = f_componer_ref(v_articulo,v_calidad,v_tono,v_calibre)
						 //v_disponible = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,&
												  //v_referencia,v_tipo_pallet,v_caja)
						// no se controla disponible porque se permite stock
						// negativo.
												  
						//----------------------------------------------------------------------//
//						IF (ante_clase = "M" and var_clase <> "M") or &
//							(var_clase <> "M" and &
//							((ante_agrupa <> var_agrupa and Not IsNull(ante_agrupa)) or &
//							(var_pedido <> ante_pedido and var_agrupa = "N") or &
//							(v_antedep <> v_deposito and Not IsNull(v_antedep)))) Then
//						

//Control de cambio de albaranes obsoleto GNO P.M 24-11-2008
//						if isnull(var_agrupa) then var_agrupa = "N"
//						if isnull(v_deposito) then v_deposito = ""
//
//						IF (ante_agrupa <> var_agrupa) or &
//							(var_pedido <> ante_pedido and var_agrupa = "N") or &
//							(v_antedep <> v_deposito) Then
//							//--------------------------------------------------------//
//							//--------- Control inicio nuevo albaran------------------//
//							//--------------------------------------------------------//							
//							veces = 0
//							var_contador = var_contador + 1
//
//						END IF
//						v_antedep   = v_deposito
//						ante_agrupa = var_agrupa
//						ante_pedido = var_pedido
//						ante_clase  = var_clase
						
						//Nuevo control inicio nuevo albaran
						if ll_albaran <> ll_ant_albaran then
							veces = 0
							var_contador   = var_contador + 1	
							ll_ant_albaran = ll_albaran
							//Esta variable la utilizamos para saber en que posicion del array de albaranes estamos
							il_contador_array_albaranes = ll_albaran
						end if						
						
						f_mensaje_proceso("Grabando Albaran Ped("+STring(var_pedido,"########")+")",reg,reg1)
						IF Not f_grabar_albaran(reg) Then 
							f_mensaje("Error en datos","Error en funcion grabar albaran")
							bien = 1
							exit
						END IF
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
						

						Select count(*) 
						Into   :nu
						from   venliped
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
									
			END IF

Next 

//Recalculamos los datos de los albaranes
For jj = 1 To var_contador
	IF Not f_actualizar_venalbaran(codigo_empresa,var_anyo_albaran,var_albaran[jj]) Then 
		bien = 1
		f_mensaje("Error al actualizar albaranes",sqlca.sqlErrtext)
	END IF
next

//ahora updatearemos los pesos segun el array de albaranes a generar
ll_total = upperbound(istr_albaranes_a_generar)

for jj = 1 to ll_total
	//Hacemos los calculos de los factores de conversion para updatear los pesos por linea
	//Con esto tratamos de hacer que si se suman los pesos de las lineas coincidan con el de cabecera
	if istr_albaranes_a_generar[jj].peso_neto_real <> 0 then 
		ld_factor_correccion_peso_neto  = istr_albaranes_a_generar[jj].peso_neto_modificado / istr_albaranes_a_generar[jj].peso_neto_real
	else
		ld_factor_correccion_peso_neto  = 1
	end if    
	
	if istr_albaranes_a_generar[jj].peso_bruto_real <> 0 then
		ld_factor_correccion_peso_bruto = istr_albaranes_a_generar[jj].peso_bruto_modificado / istr_albaranes_a_generar[jj].peso_bruto_real
	else
		ld_factor_correccion_peso_bruto = 1
	end if	
	
	if ld_factor_correccion_peso_neto <> 1 or ld_factor_correccion_peso_bruto <> 1 then
		
//		Update venalb
//		Set    peso      = peso * :ld_factor_correccion_peso_bruto,
//				 peso_neto = peso_neto * :ld_factor_correccion_peso_neto
//		Where  empresa = :codigo_empresa
//		And    anyo    = :istr_albaranes_a_generar[jj].anyo
//		And    albaran = :istr_albaranes_a_generar[jj].albaran;

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
		
		update venlialb
		set    peso      = round(peso * :ld_factor_correccion_peso_bruto,2),
				 peso_neto = round(peso_neto * :ld_factor_correccion_peso_neto,2)
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

//Solo Modificamos el peso del albaran en caso de haber generado un solo albaran

//IF peso <> 0 AND var_contador = 1 Then	
//
//	Update venalb
//	Set    peso = peso * :ld_factor_correccion_peso_bruto,
//			 peso_neto = peso_neto * :ld_factor_correccion_peso_neto
//	Where  empresa = :codigo_empresa
//	And    anyo    = :var_anyo_albaran
//	And    albaran = :var_albaran[var_contador];
//	
//	IF SQLCA.SQLCODE <> 0 Then
//		f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
//		bien = 1
//	END IF
//	
//	update venlialb
//	set    peso = peso * :ld_factor_correccion_peso_bruto,
//			 peso_neto = peso_neto * :ld_factor_correccion_peso_neto
//	Where  empresa = :codigo_empresa
//	And    anyo    = :var_anyo_albaran
//	And    albaran = :var_albaran[var_contador];
//	
//	IF SQLCA.SQLCODE <> 0 Then
//		f_mensaje("Error al modificar peso",sqlca.sqlerrtext)
//		bien = 1
//	END IF
//END IF

IF bien = 0 Then
	COMMIT;	
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso de datos","No se actualiza" + sqlca.sqlerrtext)
END IF

f_desbloquear_almacen(title)
f_desbloquear_albaranes(title)
cb_1.TriggerEvent(Clicked!)
IF bien = 0 Then
		em_albaran.text= STring(var_albaran[var_contador])
		IF listar.checked = TRUE Then
			str_parametros lstr_param
			lstr_param.i_nargumentos   = 3 + var_contador
			lstr_param.s_argumentos[2] = em_copias.text
			lstr_param.s_argumentos[3] = String(var_anyo_albaran)
			For jj = 1 To var_contador
				lstr_param.s_argumentos[jj +3] = String(var_albaran[jj])
				
			NEXT
			ll_resultado_impresion = OpenWithParm(w_lis_venalbaranes,lstr_param)
		END IF
		if imprimir_cmr = "S" then
			ls_codigo_cmr = f_nuevo_cmr(codigo_empresa,var_anyo_albaran)
			em_cmr.text   = ls_codigo_cmr
			if trim(ls_codigo_cmr) <> "" then
				For jj = 1 To var_contador
					f_anyade_albaran_a_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,'V',var_anyo_albaran,var_albaran[jj])
				next				
			end if			
////			For jj = 1 To var_contador
////				f_carga_dw_cmr(codigo_empresa,var_anyo_albaran,var_albaran[jj],dw_listado_cmr)
////				f_imprimir_documento_usuario("cmrs",dw_listado_cmr)		
////			next
//		int cont
//			
//			For jj = 1 To var_contador
//				if jj = 1 then
//					f_carga_dw_cmr(codigo_empresa,var_anyo_albaran,'',dw_listado_cmr)
////				else
////					f_carga_dw_cmr(codigo_empresa,var_anyo_albaran,var_albaran[jj],dw_listado_cmr)
//				end if
//			next
//			for cont=1 to 4					
//				print(dw_listado_cmr)	
//			next			
//			
		end if
		For jj = 1 To var_contador
			lstr_param.s_argumentos[jj +3] = String(var_albaran[jj])
			setnull(var_albaran[jj])
		NEXT		
END IF

uo_operario.em_campo.text = ""
uo_operario.em_codigo.text = ""
observaciones = ""
dw_temporal.Reset()
dw_detalle.Reset()
dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
//f_salir()
ELSE
	f_desbloquear_almacen(title)
END IF
END IF

if dw_consulta_muestras.rowcount() > 0 then
	if messagebox("Cliente con promoción","¿Desea expedir la promoción del cliente?",Question!,YesNo!,1) = 1 then
//		if isvalid(w_expedicion_pedidos_promocion) then
//			close(w_expedicion_pedidos_promocion)
//			
//			lstr_param.i_nargumentos = 13
//			lstr_param.s_argumentos[2] = em_cliente.text
//			lstr_param.s_argumentos[3] = observaciones 
//			lstr_param.s_argumentos[4] = contenedor
//			lstr_param.s_argumentos[5] = precinto
//			lstr_param.s_argumentos[6] = matricula
//			lstr_param.s_argumentos[7] = transportista_char
//			lstr_param.s_argumentos[8] = remolque 
//			lstr_param.s_argumentos[9] = imprimir_cmr
//			lstr_param.s_argumentos[10] = is_agencia
//			lstr_param.s_argumentos[11] = is_conductor
//			lstr_param.s_argumentos[12] = ''
//			lstr_param.s_argumentos[13] = uo_operario.em_codigo.text
//			lstr_param.s_argumentos[14] = ls_codigo_cmr
//			
//			//OpenWithParm(w_expedicion_pedidos_promocion,lstr_param,5,Original!)				
//		else			
//			lstr_param.i_nargumentos = 13
//			lstr_param.s_argumentos[2] = em_cliente.text
//			lstr_param.s_argumentos[3] = observaciones 
//			lstr_param.s_argumentos[4] = contenedor
//			lstr_param.s_argumentos[5] = precinto
//			lstr_param.s_argumentos[6] = matricula
//			lstr_param.s_argumentos[7] = transportista_char
//			lstr_param.s_argumentos[8] = remolque 
//			lstr_param.s_argumentos[9] = imprimir_cmr
//			lstr_param.s_argumentos[10] = is_agencia
//			lstr_param.s_argumentos[11] = is_conductor
//			lstr_param.s_argumentos[12] = ''
//			lstr_param.s_argumentos[13] = uo_operario.em_codigo.text
//			lstr_param.s_argumentos[14] = ls_codigo_cmr
//			
//			//OpenSheetWithParm(w_expedicion_pedidos_promocion,lstr_param,ventana_padre,5,Original!)	
//			
//		end if
//		if imprimir_cmr = "S" then
//			SELECT isnull(ven_cmr_cabecera.albaranes_muestras,0)
//			INTO   :ll_albaranes_promocion_en_cmr
//			FROM   ven_cmr_cabecera
//			WHERE  ven_cmr_cabecera.empresa   = :codigo_empresa
//			AND    ven_cmr_cabecera.ejercicio = :var_anyo_albaran
//			AND    ven_cmr_cabecera.codigo    = :ls_codigo_cmr;	
//			
//			if ll_albaranes_promocion_en_cmr = 0 then
//				f_imprimir_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,dw_listado_cmr)
//			end if
//		end if		
	else
		if imprimir_cmr = "S" then
			f_imprimir_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,dw_listado_cmr)
		end if		
	end if
else
	if imprimir_cmr = "S" then
		f_imprimir_cmr(codigo_empresa,var_anyo_albaran,ls_codigo_cmr,dw_listado_cmr)
	end if
end if


lb_cerrar_ventana = true

if dw_consulta_muestras.rowcount() > 0 then
	
end if
end subroutine

public function boolean f_grabar_albaran (integer reg);Dec{0}   var_anyo,var_pedido,var_linea,bien,var_albaran1,var_albaran2,numero,var_anyo_exp,var_anyob
str_venlialb lialb
str_venalb alb

//veces = veces +1
//
//bien = 0
//var_anyo     = dw_pedido.GetItemNumber(reg,"venliped_anyo")
//var_pedido   = dw_pedido.GetItemNumber(reg,"venliped_pedido")
//var_linea    = dw_pedido.GetItemNumber(reg,"venliped_linea")
//var_anyob 	 = var_anyo_albaran - 45
//var_anyo_exp = var_anyo_albaran - 30
//
//IF veces = 1 Then
//	control_lineas = 0
//	IF Dec(em_albaran.text) = 0 Then
//																						
//		  SELECT venped.empresa,   
//					venped.anyo,   
//					venped.pedido,   
//					venped.cliente,   
//					venped.codpago,   
//					venped.agente1,   
//					venped.agente2,   
//					venped.comision1,   
//					venped.comision2,   
//					venped.comision11,   
//					venped.comision22,   
//					venped.dtopp,   
//					venped.dtoesp1,   
//					venped.dtoesp2,   
//					venped.dtoesp3,   
//					venped.dtoesp4,   
//					venped.tipodto1,   
//					venped.tipodto2,   
//					venped.tipodto3,   
//					venped.tipodto4,   
//					venped.explicaciondto1,   
//					venped.explicaciondto2,   
//					venped.explicaciondto3,   
//					venped.explicaciondto4,   
//					venped.tipoiva,   
//					venped.iva,   
//					venped.numpedcli,   
//					venped.idioma,   
//					venped.divisa,   
//					venped.cambio,   
//					venped.tarifa,   
//					venped.ftarifa,   
//					venped.fbloqueo,   
//					venped.transportista,   
//					venped.serie,   
//					venped.zona,   
//					venped.envio,   
//					venped.correspondencia,   
//					venped.domiciliacion,   
//					venped.forma_envio,   
//					venped.cod_entrega,   
//					venped.usuario,   
//					venped.tipo_portes,   
//					venped.periodo_fac,   
//					venped.peso,   
//					venped.usuario_pedido,   
//					venped.agente3,   
//					venped.comision31,   
//					venped.comision32,   
//					venped.veces,   
//					venped.textcomercial1,   
//					venped.textcomercial2,   
//					venped.textaduanaesp1,   
//					venped.textaduanaesp2,   
//					venped.textaduanaext1,   
//					venped.textaduanaext2,   
//					venped.textopie1,   
//					venped.textopie2,   
//					venped.condicion,   
//					venped.peso_neto,   
//					venped.banco_de_cobro,   
//					venped.porcentaje_aduana,   
//					venped.bruto,   
//					venped.importe_dto,   
//					venped.total_neto,   
//					venped.calculo_dto,   
//					venped.fentrega,   
//					venped.observaciones,
//					venped.agrupa,
//					venped.deposito,
//					venped.almacen_deposito,
//					venped.calculo_dtoesp,
//		         venped.agrupa_exp,
//					venped.hora_recepcion,
//					venped.es_cliente
//				 INTO :alb.empresa,   
//					:alb.anyo_pedido_origen,   
//					:alb.pedido_origen,   
//					:alb.cliente,   
//					:alb.codpago,   
//					:alb.agente1,   
//					:alb.agente2,   
//					:alb.comision1,   
//					:alb.comision2,   
//					:alb.comision11,   
//					:alb.comision22,   
//					:alb.dtopp,   
//					:alb.dtoesp1,   
//					:alb.dtoesp2,   
//					:alb.dtoesp3,   
//					:alb.dtoesp4,   
//					:alb.tipodto1,   
//					:alb.tipodto2,   
//					:alb.tipodto3,   
//					:alb.tipodto4,   
//					:alb.explicaciondto1,   
//					:alb.explicaciondto2,   
//					:alb.explicaciondto3,   
//					:alb.explicaciondto4,   
//					:alb.tipoiva,   
//					:alb.iva,   
//					:alb.numpedcli,   
//					:alb.idioma,   
//					:alb.divisa,   
//					:alb.cambio,   
//					:alb.tarifa,   
//					:alb.ftarifa,   
//					:alb.fbloqueo,   
//					:alb.transportista,   
//					:alb.serie,   
//					:alb.zona,   
//					:alb.envio,   
//					:alb.correspondencia,   
//					:alb.domiciliacion,   
//					:alb.forma_envio,   
//					:alb.cod_entrega,   
//					:alb.usuario,   
//					:alb.tipo_portes,   
//					:alb.periodo_fac,   
//					:alb.peso,   
//					:alb.usuario_pedido,   
//					:alb.agente3,   
//					:alb.comision31,   
//					:alb.comision32,   
//					:alb.veces,   
//					:alb.textcomercial1,   
//					:alb.textcomercial2,   
//					:alb.textaduanaesp1,   
//					:alb.textaduanaesp2,   
//					:alb.textaduanaext1,   
//					:alb.textaduanaext2,   
//					:alb.textopie1,   
//					:alb.textopie2,   
//					:alb.condicion,   
//					:alb.peso_neto,   
//					:alb.banco_de_cobro,   
//					:alb.porcentaje_aduana,   
//					:alb.bruto,   
//					:alb.importe_dto,   
//					:alb.total_neto,   
//					:alb.calculo_dto,   
//					:alb.fentrega,   
//					:alb.observaciones,  
//					:alb.agrupa,
//					:alb.deposito,
//					:alb.almacen_deposito,
//					:alb.calculo_dtoesp,
//					:lialb.agrupa_exp,
//					:alb.hora_recepcion,
//					:alb.es_cliente		
//			FROM   venped  
//			WHERE  venped.empresa = :codigo_empresa AND  
//					 venped.anyo    = :var_anyo AND  
//					 venped.pedido  = :var_pedido;
//			
//			if sqlca.sqlcode <> 0 then
//				f_mensaje("Selección de datos del pedido (generación del albarán)","Error: "+sqlca.sqlerrtext)
//				bien = 1
//			end if
//			
//			if alb.codpago = '84'  then
//				dec {0} contadorb,mincontadorb
//				
//				SELECT venparamalb.albaran   INTO :var_albaran[var_contador] 
//				 FROM venparamalb  
//				WHERE venparamalb.empresa = :codigo_empresa  
//				And   venparamalb.anyo    = :var_anyob;   //1960;
//				If Sqlca.Sqlcode=100 Then
//					//quieren que empiece cada año siguiendo:
//					//2005  -> 500000
//					//2006  -> 600000
//					//etc.. en el 2010, se lo tendrán que pensar pues será 1000000.
//					//Chaume lo sabe. Amparo. De momento, así queda 3/1/06
//					contadorb = 900000//(var_anyo_albaran - 2000)* 100000
//					
//					INSERT INTO venparamalb (empresa,anyo,albaran)  
//							 VALUES (:codigo_empresa,:var_anyob,:contadorb);  //500000
//					 var_albaran[var_contador] = contadorb   //500000
//				END IF
//				var_albaran[var_contador] ++
//				UPDATE venparamalb SET albaran = :var_albaran[var_contador]
//				WHERE  venparamalb.empresa = :codigo_empresa
//				And    venparamalb.anyo    = :var_anyob;   //1960;
//				alb.tipoiva 	= '101'   
//				alb.iva 		= 0 
//				
//			else
//				
//				if alb.serie = '1' then
//					SELECT venparamalb.albaran  
//					INTO   :var_albaran[var_contador] 
//					FROM   venparamalb  
//					WHERE  venparamalb.empresa = :codigo_empresa  
//					And    venparamalb.anyo    = :var_anyo_albaran;
//					
//					If Sqlca.Sqlcode=100 Then
//						 INSERT INTO venparamalb
//								  (empresa,anyo,albaran)  
//						 VALUES (:codigo_empresa,:var_anyo_albaran,0);
//					END IF
//				else
//					SELECT venparamalb.albaran  
//					INTO   :var_albaran[var_contador] 
//					FROM   venparamalb  
//					WHERE  venparamalb.empresa = :codigo_empresa  
//					And    venparamalb.anyo    = :var_anyo_exp;
//					
//					If Sqlca.Sqlcode=100 Then
//						 INSERT INTO venparamalb
//								  (empresa,anyo,albaran)  
//						 VALUES (:codigo_empresa,:var_anyo_exp,0);
//					END IF					
//				end if
//				IF IsNull(var_albaran[var_contador]) Then var_albaran[var_contador]=0
//				var_albaran[var_contador]=var_albaran[var_contador] + 1
//			
//				Select  count(*) 
//				Into    :numero
//				From    venalb
//				Where   venalb.empresa    = :codigo_empresa
//				And     venalb.anyo       = :var_anyo_albaran
//				And     venalb.albaran    = :var_albaran[var_contador];
//				
//				If IsNull(numero) Then numero=0
//				IF numero = 0 Then
//					Select  count(*)
//					Into    :numero 
//					From    venfac
//					Where   venfac.empresa       = :codigo_empresa
//					and     venfac.anyo_albaran  = :var_anyo_albaran
//					And     venfac.albaran       = :var_albaran[var_contador];
//					
//					If IsNull(numero) Then numero=0
//				END IF
//				If numero <> 0 Then
//					f_grabar_incidencia(title,"Proceso lento seleccion ultimo albaran")			
//					IF alb.codpago = '84'  THEN
//						Select  Max(albaran) Into :numero From venalb
//						Where   venalb.empresa    = :codigo_empresa
//						And     venalb.anyo       = :var_anyo_albaran
//						And     venalb.serie      = :alb.serie;	
//						
//						var_albaran[var_contador] = numero
//						var_albaran[var_contador] = var_albaran[var_contador] + 1
//					ELSE			
//						
//						mincontadorb = 900000//(var_anyo_albaran - 2000)* 100000
////						SELECT  Max(albaran) Into :numero From venalb
////						WHERE   venalb.empresa    = :codigo_empresa
////						AND     venalb.anyo       = :var_anyo_albaran
////						AND     venalb.serie      = :alb.serie
////						AND 	  venalb.albaran 	  < :mincontadorb;						
//						
//						Select Max(venalb.albaran)
//						Into   :var_albaran1 
//						From   venalb
//						Where  venalb.empresa = :codigo_empresa
//						And    venalb.anyo    = :var_anyo_albaran
//						and    venalb.albaran < :mincontadorb
//						and    venalb.serie   = :alb.serie;
//						
//						IF IsNull(var_albaran1) Then var_albaran1 = 0
//						
//						Select Max(venlifac.albaran)
//						Into   :var_albaran2 
//						From   venlifac
//						Where  venlifac.empresa         = :codigo_empresa
//						And    venlifac.anyo_albaran    = :var_anyo_albaran
//						and    venlifac.albaran         < :mincontadorb
//						and    venlifac.serie           = :alb.serie;
//						
//						IF IsNull(var_albaran2) Then var_albaran2 = 0
//						
//						var_albaran[var_contador] = var_albaran1
//						IF var_albaran2 > var_albaran[var_contador] Then var_albaran[var_contador] = var_albaran2
//						var_albaran[var_contador] = var_albaran[var_contador] + 1
//					end if
//				End If
//				
//				IF alb.codpago = '84'  THEN
//					UPDATE venparamalb
//					SET    albaran = :var_albaran[var_contador]
//					WHERE  venparamalb.empresa = :codigo_empresa
//					And    venparamalb.anyo    = :var_anyob;					
//				else
//					if alb.serie = '1' then
//						UPDATE venparamalb
//						SET    albaran = :var_albaran[var_contador]
//						WHERE  venparamalb.empresa = :codigo_empresa
//						And    venparamalb.anyo    = :var_anyo_albaran;						
//					else
//						UPDATE venparamalb
//						SET    albaran = :var_albaran[var_contador]
//						WHERE  venparamalb.empresa = :codigo_empresa
//						And    venparamalb.anyo    = :var_anyo_exp;						
//					end if
//				end if
//				
//				IF sqlca.sqlcode <> 0 then
//					f_mensaje("Actualización de venparamalb","Error: "+sqlca.sqlerrtext)
//				end if
//	
//			end if			
//			
//			alb.empresa = codigo_empresa
//			alb.anyo    = var_anyo_albaran
//			alb.albaran = var_albaran[var_contador]
//			alb.falbaran = DateTime(Date(em_fecha.text))
//			alb.flistado = DateTime(Today(),Now())
//			alb.veces = 1
//			alb.falta = DateTime(Today(),Now())
//			alb.fcarga   = DateTime(Today())
//			alb.deposito = v_deposito
//			alb.abono = "N"
//			if isnull(alb.observaciones) then alb.observaciones = ""
//			if trim(alb.observaciones) <> "" and trim(observaciones) <> "" then
//				alb.observaciones += "~n"	
//			end if
//			alb.observaciones += observaciones
//			alb.contenedor    = contenedor
//			alb.precinto      = precinto
//			alb.matricula		= matricula
//			alb.remolque      = remolque
//			alb.transportista_char = transportista_char
//			alb.operario_carga = uo_operario.em_codigo.text
//			alb.usuario       = nombre_usuario 
//			alb.transportista = is_agencia
//			alb.venconductores_codigo = is_conductor
//			
//			IF Not f_insertar_venalb(alb)  Then 
//				bien = 1
//				f_mensaje("Error al insertar albaran",sqlca.sqlErrtext)
//			END IF
//			
//			istr_albaranes_a_generar[il_contador_array_albaranes].anyo = alb.anyo
//			istr_albaranes_a_generar[il_contador_array_albaranes].albaran = alb.albaran
//			
//    ELSE
//		var_albaran[var_contador] = Dec(em_albaran.text)
//		alb.empresa = codigo_empresa
//		alb.anyo    = var_anyo_albaran
//		alb.albaran = var_albaran[var_contador]
//		f_mensaje_proceso("Selecion Máxima linea",reg,dw_pedido.Rowcount())
//		Select Max(linea) 
//		Into   :control_lineas 
//		From   venlialb
//		Where  venlialb.empresa = :codigo_empresa
//		And    venlialb.anyo    = :var_anyo_albaran
//		And    venlialb.albaran = :var_albaran[var_contador];
//		
//		IF IsNull(control_lineas) Then control_lineas = 0
//			
//		 
//		istr_albaranes_a_generar[il_contador_array_albaranes].anyo = var_anyo_albaran
//		istr_albaranes_a_generar[il_contador_array_albaranes].albaran = var_albaran[var_contador]		 
//  	END IF
//END IF
//
//lialb.fcarga              = DateTime(Today())
//lialb.anyo_pedido_origen  = var_anyo
//lialb.pedido_origen       = var_pedido
//lialb.linea_pedido_origen = var_linea
//lialb.albaran             = var_albaran[var_contador]
//lialb.anyo                = var_anyo_albaran
//lialb.linea               = veces + control_lineas
//lin_alb                   = lialb.linea
//lialb.empresa             = codigo_empresa
//lialb.falbaran            = DateTime(Date(em_fecha.text))
//lialb.falta               = alb.falta
//
//  SELECT venliped.serie,venliped.fentrega,   
//         venliped.cliente,venliped.tipo_unidad,   
//         venliped.articulo,   
//         venliped.familia,   
//         venliped.formato,   
//         venliped.modelo,   
//         venliped.calidad,   
//         venliped.tonochar,   
//         venliped.calibre,   
//         venliped.precio,   
//         venliped.precio_estand,   
//         venliped.cantidad,   
//         venliped.pallets,   
//         venliped.total_cajas,   
//         venliped.cajas,   
//         venliped.dtocomer,   
//         venliped.dtoesp,   
//         venliped.descripcion,   
//         venliped.tipoiva,   
//         venliped.iva,   
//         venliped.linfab,   
//         venliped.provincia,   
//         venliped.pais,   
//         venliped.zona,   
//         venliped.tipolinea,   
//         venliped.texto1,   
//         venliped.texto2,   
//         venliped.texto3,   
//         venliped.texto4,   
//         venliped.referencia,   
//         venliped.montajeartcal,   
//         venliped.situacion,   
//         venliped.divisa,   
//         venliped.metros_lineales,   
//         venliped.peso,   
//         venliped.falta,   
//         venliped.usuario,   
//         venliped.tipo_pallet,   
//			venliped.caja,
//         venliped.importe,   
//         venliped.descuento,   
//         venliped.importedto,   
//         venliped.clase,   
//         venliped.sector,   
//         venliped.agente1,   
//         venliped.agente2,   
//         venliped.agente3,   
//         venliped.comision11,   
//         venliped.comision12,   
//         venliped.comision21,   
//         venliped.comision22,   
//         venliped.comision31,   
//         venliped.comision32,   
//         venliped.deposito,   
//         venliped.orden_preparacion,   
//         venliped.cantidad_prepa,   
//         venliped.es_pico,   
//         venliped.numero_pico,   
//         venliped.anyo_ent,   
//         venliped.nummov_ent,   
//         venliped.anyo_sal,   
//         venliped.nummov_sal,   
//         venliped.fila_ent,   
//         venliped.altura_ent,   
//         venliped.operario_prepa,   
//         venliped.control_incremento,   
//         venliped.peso_neto,   
//         venliped.precio_aduana,   
//         venliped.control_descuentos,   
//         venliped.control_comisiones,   
//         venliped.importe_aduana,   
//         venliped.bruto,   
//         venliped.precio_neto,   
//         venliped.precio_aduana_neto,   
//         venliped.descuento_aduana,   
//         venliped.neto,   
//         venliped.impdtopp,   
//         venliped.ref_cli,   
//         venliped.transportista,   
//         venliped.almacen_ent  ,
//			venliped.almacen_deposito,
//			venliped.numpedcli,
//			venliped.ubicacion_preparado,
//			venliped.linea_pedido_original
//    INTO :lialb.serie,   
//         :lialb.fentrega,   
//         :lialb.cliente,   
//         :lialb.tipo_unidad,   
//         :lialb.articulo,   
//         :lialb.familia,   
//         :lialb.formato,   
//         :lialb.modelo,   
//         :lialb.calidad,   
//         :lialb.tonochar,   
//         :lialb.calibre,   
//         :lialb.precio,   
//         :lialb.precio_estand,   
//         :lialb.cantidad,   
//         :lialb.pallets,   
//         :lialb.total_cajas,   
//         :lialb.cajas,   
//         :lialb.dtocomer,   
//         :lialb.dtoesp,   
//         :lialb.descripcion,   
//         :lialb.tipoiva,   
//         :lialb.iva,   
//         :lialb.linfab,   
//         :lialb.provincia,   
//         :lialb.pais,   
//         :lialb.zona,   
//         :lialb.tipolinea,   
//         :lialb.texto1,   
//         :lialb.texto2,   
//         :lialb.texto3,   
//         :lialb.texto4,   
//         :lialb.referencia,   
//         :lialb.montajeartcal,   
//         :lialb.situacion,   
//         :lialb.divisa,   
//         :lialb.metros_lineales,   
//         :lialb.peso,   
//         :lialb.falta,   
//         :lialb.usuario_pedido,   
//         :lialb.tipo_pallet,   
//			:lialb.caja,
//         :lialb.importe,   
//         :lialb.descuento,   
//         :lialb.importedto,   
//         :lialb.clase,   
//         :lialb.sector,   
//         :lialb.agente1,   
//         :lialb.agente2,   
//         :lialb.agente3,   
//         :lialb.comision11,   
//         :lialb.comision12,   
//         :lialb.comision21,   
//         :lialb.comision22,   
//         :lialb.comision31,   
//         :lialb.comision32,   
//         :lialb.deposito,   
//         :lialb.orden_preparacion,   
//         :lialb.cantidad_prepa,   
//         :lialb.es_pico,   
//         :lialb.numero_pico,   
//         :lialb.anyo_ent,   
//         :lialb.nummov_ent,   
//         :lialb.anyo_sal,   
//         :lialb.nummov_sal,   
//         :lialb.fila_ent,   
//         :lialb.altura_ent,   
//         :lialb.operario_prepa,   
//         :lialb.control_incremento,   
//         :lialb.peso_neto,   
//         :lialb.precio_aduana,   
//         :lialb.control_descuentos,   
//         :lialb.control_comisiones,   
//         :lialb.importe_aduana,   
//         :lialb.bruto,   
//         :lialb.precio_neto,   
//         :lialb.precio_aduana_neto,   
//         :lialb.descuento_aduana,   
//         :lialb.neto,   
//         :lialb.impdtopp,   
//         :lialb.ref_cli,   
//         :lialb.transportista,   
//         :lialb.almacen_ent,
//         :lialb.almacen_deposito,
//         :lialb.numpedcli,
//			:lialb.ubicacion_preparado,
//			:lialb.linea_pedido_original
//    FROM  venliped  
//   WHERE  venliped.empresa = :codigo_empresa 
//	AND    venliped.anyo    = :var_anyo
//	AND    venliped.pedido  = :var_pedido 
//	AND    venliped.linea   = :var_linea ;
//	
//	if sqlca.sqlcode <> 0 then
//		f_mensaje("Selección de datos de líneas de pedido","Error: "+sqlca.sqlerrtext)
//		bien = 1
//	end if
//			
//lialb.falta       = DateTime(Today(),Now())
//lialb.usuario     = nombre_usuario
//lialb.pallets     = dw_pedido.GetItemNumber(reg,"venliped_pallets")
//lialb.cajas       = dw_pedido.GetItemNumber(reg,"venliped_cajas")
//lialb.total_cajas = dw_pedido.GetItemNumber(reg,"venliped_total_cajas")
//lialb.cantidad    = dw_pedido.GetItemNumber(reg,"venliped_cantidad")
//lialb.ubicacion   = dw_pedido.GetItemSTring(reg,"cubicacion")		
//lialb.contenedor  = contenedor
//lialb.precinto		= precinto
//lialb.matricula	= matricula
//lialb.remolque    = remolque
//
IF Not f_insertar_venlialb(lialb) Then 
	bien = 1
	f_mensaje("Error al insertar albaranes",sqlca.sqlErrtext)
END IF

IF bien  = 0 Then
	Return True
Else
	Return False
End If


end function

public function boolean f_control_existencias ();Dec bien,reg1,reg,var_anyo,var_linea,var_pedido,var_cantidad,var_cantidad2,var_linped
String var_ubicacion,var_referencia,var_tipo_pallet,var_situacion,var_articulo,var_caja,var_tipolinea,var_control_almacen
string ls_sel,ls_busqueda
long   ll_donde,ll_indice,ll_total
boolean lb_correcto = true
bien = 0
reg1 = dw_pedido.RowCount()

datastore ds_control_ubicaciones_sin_reservar

//Marcaremos las lineas con problemas seleccionandolas
dw_pedido.selectrow(0,false)

ls_sel = "select '' as ubicacion,"+&
			"       '' as referencia,"+&
			"       '' as tipo_pallet,"+&
			"       '' as caja,"+&
			"       0.000000 as existencias,"+&
			"       0.000000 as cantidad_expedir "+&
			"from empresas where 0 = 1"

f_cargar_cursor_transaccion(sqlca,ds_control_ubicaciones_sin_reservar,ls_sel)

for reg = 1 To reg1
	var_tipolinea = dw_pedido.object.venliped_tipolinea[reg]
	var_control_almacen = f_control_almacen_ventipolin(codigo_empresa,var_tipolinea)
	
	if var_control_almacen = "S" then
		if dw_pedido.GetItemSTring(reg,"cmarcado")	= "X" then
		
			var_anyo        = dw_pedido.object.venliped_anyo[reg]
			var_pedido      = dw_pedido.object.venliped_pedido[reg]
			var_linea       = dw_pedido.object.venliped_linea[reg]
			var_ubicacion   = dw_pedido.object.cubicacion[reg]
			var_cantidad	 = dw_pedido.object.venliped_cantidad[reg]
				 
			select venliped.referencia,   
					 venliped.tipo_pallet, 
					 venliped.situacion,
					 venliped.articulo,
					 venliped.caja
			into 	:var_referencia,   
					:var_tipo_pallet,
					:var_situacion,
					:var_articulo,
					:var_caja
			from   venliped  
			where  venliped.empresa = :codigo_empresa 
			and    venliped.anyo    = :var_anyo 
			and    venliped.pedido  = :var_pedido 
			and    venliped.linea   = :var_linea;
		
			if var_situacion = "P" then
				var_cantidad2 = 0
				
				select sum(existencias) 
				into  :var_cantidad2   
				from   almlinubica  
				where  almlinubica.empresa = :codigo_empresa 
				and    almlinubica.anyo    = :var_anyo
				and  	 almlinubica.pedido  = :var_pedido
				and    almlinubica.linped  = :var_linea   ;
				
				var_cantidad2 = dec(string(var_cantidad2,'###,###,###.##'))
				var_cantidad  = dec(string(var_cantidad ,'###,###,###.##'))
				
				if var_cantidad2 < var_cantidad  then
					messagebox("Error","La cantidad Preparada no coincide"+ f_nombre_articulo(codigo_empresa,var_articulo)+"~nPedido "+string(var_pedido,"#####0")+"/"+string(var_anyo,"###0"+" Linea "+string(var_linea,"###0")))
					lb_correcto = False
					dw_pedido.selectrow(reg,true)
				end if
			else
				if IsNull(var_tipo_pallet) then var_tipo_pallet = ""
				var_cantidad2 = 0
				
				select sum(existencias) 
				into  :var_cantidad2   
				from   almlinubica  
				where  almlinubica.empresa     = :codigo_empresa 
				and    almlinubica.ubicacion   = :var_ubicacion
				and    almlinubica.referencia  = :var_referencia
				and    almlinubica.tipo_pallet = :var_tipo_pallet 
				and    almlinubica.caja        = :var_caja
				and  	 almlinubica.pedido = null;
				
				var_cantidad2 = dec(string(var_cantidad2,'###,###,###.####'))
				var_cantidad  = dec(string(var_cantidad ,'###,###,###.####'))
				
				ls_busqueda = "ubicacion   = '"+var_ubicacion+"' and "+&
								  "referencia  = '"+var_referencia+"' and "+&
								  "tipo_pallet = '"+var_tipo_pallet+"' and "+&
								  "caja        = '"+var_caja+"'"
								  								  
				ll_donde = ds_control_ubicaciones_sin_reservar.find(ls_busqueda,1,ds_control_ubicaciones_sin_reservar.rowcount())
				
				if ll_donde > 0 then
					ds_control_ubicaciones_sin_reservar.object.existencias[ll_donde]      = var_cantidad2
					ds_control_ubicaciones_sin_reservar.object.cantidad_expedir[ll_donde] = ds_control_ubicaciones_sin_reservar.object.cantidad_expedir[ll_donde] + var_cantidad					
				else
					ll_donde = ds_control_ubicaciones_sin_reservar.insertrow(0)
					
					ds_control_ubicaciones_sin_reservar.object.ubicacion[ll_donde]        = var_ubicacion
					ds_control_ubicaciones_sin_reservar.object.referencia[ll_donde]       = var_referencia
					ds_control_ubicaciones_sin_reservar.object.tipo_pallet[ll_donde]      = var_tipo_pallet
					ds_control_ubicaciones_sin_reservar.object.caja[ll_donde]             = var_caja
					ds_control_ubicaciones_sin_reservar.object.existencias[ll_donde]      = var_cantidad2
					ds_control_ubicaciones_sin_reservar.object.cantidad_expedir[ll_donde] = var_cantidad
				end if
				
				if ds_control_ubicaciones_sin_reservar.object.existencias[ll_donde] < ds_control_ubicaciones_sin_reservar.object.cantidad_expedir[ll_donde] then
					messagebox("Error","La cantidad en ubicacion es menor que la salida a realizar~nArticulo "+ f_nombre_articulo(codigo_empresa,var_articulo)+"~nUbicacion "+f_ubicacion(var_ubicacion))
					lb_correcto = False
					dw_pedido.selectrow(reg,true)					
				end if
				
//				if var_cantidad2 < var_cantidad  then
//					f_mensaje("CONTROL STOCK ALMACEN","NO HAY SUFICIENTE STOCK DEL ARTICULO: "+ f_nombre_articulo(codigo_empresa,var_articulo)+" EN LA UBICACION "+var_ubicacion)
//					return false
//				end if

			end if
		end if
	end if
next

destroy ds_control_ubicaciones_sin_reservar

return lb_correcto
end function

public function boolean f_expedir_pedido (integer elemento);Dec{0} var_pedido,var_linea
Dec{0} var_anyo,nu
string cadena
Dec{2} var_pallets_carga,var_cajas_carga,var_total_cajas_carga,var_cantidad_carga
Integer var_bien
var_bien = 0
str_venliped linped
var_anyo       = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
var_pedido       = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
var_linea       = dw_pedido.GetItemNumber(elemento,"venliped_linea")
var_pallets_carga     = dw_pedido.GetItemNumber(elemento,"venliped_pallets")
var_cajas_carga       = dw_pedido.GetItemNumber(elemento,"venliped_cajas")
var_total_cajas_carga = dw_pedido.GetItemNumber(elemento,"venliped_total_cajas")
var_cantidad_carga    = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")

linped.empresa   =   codigo_empresa
linped.anyo      =   var_anyo
linped.pedido    =   var_pedido
linped.linea     =   var_linea

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
			venliped.importe,  venliped.descuento,
			venliped.importedto,    venliped.clase,   
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
			:linped.importe,:linped.descuento,
			:linped.importedto,:linped.clase,   
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
         ( venliped.anyo    = :var_anyo) AND  
         ( venliped.pedido  = :var_pedido ) AND  
         ( venliped.linea   = :var_linea )   ;
			IF SQLCA.SQLCODE = 100 Then var_bien = 1
			
IF IsNull(var_cantidad_carga) Then var_cantidad_carga = 0
linped.cantidad = linped.cantidad - var_cantidad_carga
cadena = f_calculo_unidades(codigo_empresa,linped.articulo,&
                            linped.tipo_pallet,linped.caja,&
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
		Into   :nu 
		from   venliped
	   WHERE  venliped.empresa = :codigo_empresa 
		AND    venliped.anyo    = :var_anyo 
		AND    venliped.pedido  = :var_pedido;
		
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

public function boolean f_grabar_salida_ventas (integer elemento);Dec{0}    var_pedido,var_anyo_pedido,var_linea_pedido,cur_pedido,cur_linea,contador_nummov,numero,var_fila,var_altura
DataStore dw_proceso2
Dec{0}    var_anyo,var_linea,contador,var_calibre
string    cadena,var_referencia,var_tipo_pallet,var_caja,&
			 var_articulo,var_calidad,cur_observaciones,cur_tipo_pallet,&
			 var_ubicacion,var_situacion,v_mas,var_deposito,var_almacen_deposito,&
			 v_almacen,var_cliente,var_almacen,var_zona,var_tipolinea,var_tono
Dec{2}    var_cantidad_carga,total_cantidad,cur_existencias,cantidad_pendiente,cantidad_borrada
boolean   var_bien = true
Date      fecha
Dec       ln
dec{4}    variable_nueva
String    sel
Integer   registros,x1
str_almmovhis        movhis
str_almlinubica      ubi
str_almlinubicahis   ubihis
str_depmovhis        depmovhis
str_deplinubica      deplinubica

var_tipolinea = dw_pedido.GetItemSTring(elemento,"venliped_tipolinea")
if f_control_almacen_ventipolin(codigo_empresa,var_tipolinea) = "S" then
	var_tipo_pallet      = dw_pedido.GetItemSTring(elemento,"venliped_tipo_pallet")
	var_anyo             = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
	var_pedido           = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
	var_linea            = dw_pedido.GetItemNumber(elemento,"venliped_linea")
	var_situacion        = dw_pedido.GetItemString(elemento,"venliped_situacion")
	var_deposito         = dw_pedido.GetItemString(elemento,"venliped_deposito")
	var_cliente          = dw_pedido.GetItemString(elemento,"venliped_cliente")
	var_almacen_deposito = dw_pedido.GetItemString(elemento,"venliped_almacen_deposito")
	var_tipo_pallet      = dw_pedido.GetItemString(elemento,"venliped_tipo_pallet")
	var_caja             = dw_pedido.GetItemString(elemento,"venliped_caja")
	var_ubicacion        = dw_pedido.GetItemString(elemento,"cubicacion")
	var_almacen          = f_almacen_ubicacion(var_ubicacion)
	var_zona             = f_zona_ubicacion(var_ubicacion)
	var_fila             = f_fila_ubicacion(var_ubicacion)
	var_altura           = f_altura_ubicacion(var_ubicacion)
	var_anyo_pedido      = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
	var_pedido           = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
	var_linea_pedido     = dw_pedido.GetItemNumber(elemento,"venliped_linea")
	var_cantidad_carga   = dw_pedido.GetItemNumber(elemento,"venliped_cantidad")
	var_articulo         = dw_pedido.GetItemSTring(elemento,"venliped_articulo")
	var_calidad          = dw_pedido.GetItemString(elemento,"venliped_calidad")
	var_tono             = dw_pedido.GetItemString(elemento,"venliped_tonochar")
	var_calibre          = dw_pedido.GetItemNumber(elemento,"venliped_calibre")
	
	// cuando el articulo no es del sector
	if trim(var_calidad) = "0"  or isnull(var_calidad) then var_calidad = ""
	
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
	 ubihis.fecha         = DateTime(date(em_fecha.text))
	 ubihis.f_alta        = DateTime(today(),now())
	 SetNull(ubihis.observaciones)
	 ubihis.tipo_pallet   = var_tipo_pallet
	 ubihis.caja          = var_caja
	 ubihis.sector        = f_sector_articulo(codigo_empresa,var_articulo)
	 SetNull(ubihis.nummov)
	
	SELECT articulos.familia,	articulos.formato,	articulos.modelo,	articulos.unidad  
	INTO 	 :ubihis.familia,		:ubihis.formato,		:ubihis.modelo,	:ubihis.tipo_unidad  
	FROM   articulos  
	WHERE  articulos.empresa = :ubihis.empresa
	AND    articulos.codigo  = :ubihis.articulo ;
	
	IF SQLCA.SQLCode<>0 THEN 
		var_bien = false
		f_mensaje("Error","El artículo no existe")
	END IF
	
	ubihis.referencia = var_referencia
	//Deberiamos separar las salidas de vtas de las salidas a deposito
	if var_deposito <> "S" then
		
		ubihis.tipomov    = ""//f_tipomov_movimientos(ubihis.empresa,var_tipolinea,"tipomov_almtipomov_exp","ventipolin","empresa","codigo")	
//		ubihis.tipomov    =  "206"
	else
		ubihis.tipomov    = ""//f_tipomov_movimientos(ubihis.empresa,var_tipolinea,"tipomov_almtipomov_exp_dep","ventipolin","empresa","codigo")	
//		ubihis.tipomov    = f_tipomov_movimientos(ubihis.empresa,var_tipolinea, &
//								"empresa","codigo","ventipolin","tipomov_almtipomov_exp_dep")		
//		ubihis.tipomov    =  "224"
	end if
	//
	ubi.empresa       =  ubihis.empresa
	ubi.almacen       =  ubihis.almacen
	ubi.articulo      =  ubihis.articulo
	ubi.familia       =  ubihis.familia
	ubi.formato       =  ubihis.formato
	ubi.modelo        =  ubihis.modelo
	ubi.calidad       =  ubihis.calidad
	ubi.tonochar      =  ubihis.tonochar
	ubi.calibre       =  ubihis.calibre
	ubi.tipo_pallet   = ubihis.tipo_pallet
	ubi.caja          = var_caja
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
	ubi.existencias   = total_cantidad
	ubi.ubicacion     = ubihis.ubicacion
	ubihis.orden      = f_almparam_numorden(codigo_empresa,Year(Today()))
	//-----------------------------------------------------------------------
	// Tambien Inserto en el Historico de Movimientos ( la Salida Gobal)
	//-----------------------------------------------------------------------
	movhis.empresa      =  ubihis.empresa  
	movhis.almacen      =  ubihis.almacen
	movhis.anyo         =  ubihis.anyo
	movhis.origen       =  "10"
	movhis.articulo     =  ubihis.articulo
	movhis.fechmov      =  ubihis.fecha
	movhis.tipomov      =  ubihis.tipomov
	movhis.cantidade    =  0
	movhis.cantidads    =  ubihis.cantidads
	movhis.precio       =  0
	movhis.codtercero   = em_cliente.text
	movhis.numdoc       = string(var_albaran[var_contador],"#######0")
	movhis.situacion    =  "N"
	SetNull(movhis.observaciones)
	SetNull( movhis.punteado)
	movhis.antexist     =    0
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
	movhis.caja         =  var_caja
	movhis.sector       =  ubihis.sector
	movhis.nummov       = f_almparam_nummov(movhis.empresa,Year(Today()))
	 
	// Grabar el movimiento en el histórico por el total de existencias
	IF NOT f_insert_almmovhis(movhis) Then
		MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
		var_bien = false
	END IF
	IF NOT f_actualiza_nummov(movhis.empresa,Year(Today()),movhis.nummov) THEN
		 MessageBox("Error en proceso","Actualizando nummov.",Exclamation!, OK!,1)
		 var_bien = false
	END IF
	ubihis.nummov = movhis.nummov
	
	//--------------------------------------------------------------------//
	//                   la salida global               //
	//--------------------------------------------------------------------//
	// En el historico de ubicaciones
	IF NOT f_insert_almlinubicahis(ubihis) THEN
		MessageBox("Error en proceso","Insertando en almlinubicahis",Exclamation!, OK!,1)
		var_bien = false
	END IF
	IF NOT f_actualiza_numorden(codigo_empresa,Year(Today()),ubihis.orden) THEN
		 MessageBox("Error en proceso","Actualizando numpedido.",Exclamation!, OK!,1)
		 var_bien = false
	END IF		
	//-------------------Fin insercion movhis salida global  ----------------\\
	
	IF dw_pedido.GetItemString(elemento,"venliped_situacion") = "P" Then
		ubi.anyo    = dw_pedido.GetItemNumber(elemento,"venliped_anyo")
		ubi.pedido  = dw_pedido.GetItemNumber(elemento,"venliped_pedido")
		ubi.linped  = dw_pedido.GetItemNumber(elemento,"venliped_linea")
	//	messagebox(ubi.empresa+" "+ubi.ubicacion+" "+ubi.referencia,string(ubi.anyo)+" "+string(ubi.pedido)+" "+string(ubi.linped)+" "+string(ubihis.cantidads))
		Select almlinubica.linea,
				 almlinubica.existencias 
		Into   :ln,
				 :variable_nueva 
		From   almlinubica
		Where  almlinubica.empresa    	  = :ubi.empresa
		And    almlinubica.ubicacion       = :ubi.ubicacion
		And    almlinubica.referencia 	  = :ubi.referencia
		And    almlinubica.anyo            = :ubi.anyo
		And    almlinubica.pedido          = :ubi.pedido
		And    almlinubica.linped          = :ubi.linped;
		
		IF Sqlca.sqlcode <> 0 Then 
			MessageBox("Seleccionando de almlinubica","Pedido"+String(ubi.pedido,"####0")+"/"+STring(ubi.linped,"####0")+ "" + sqlca.sqlerrtext,Exclamation!, OK!,1)
			var_bien = false
		ELSE
			if variable_nueva<>ubihis.cantidads then 
				if  variable_nueva<ubihis.cantidads then 
					MessageBox("Seleccionando de almlinubica","No coincide Cantidad Pedido"+String(ubi.pedido,"####0")+"/"+STring(ubi.linped,"####0"),Exclamation!, OK!,1)
					var_bien = false
				else
					UPDATE almlinubica
					sET    existencias = existencias - :ubihis.cantidads
					Where  almlinubica.empresa    	  = :ubi.empresa
					And    almlinubica.ubicacion       = :ubi.ubicacion
					And    almlinubica.linea           = :ln;
					IF SQLCA.SQLCODE <> 0 Then
						MessageBox("Error en proceso","Modificacion de almlinubica",Exclamation!, OK!,1)
						var_bien = false
					END IF
				end if
			else	
				Delete from almlinubica
				Where  almlinubica.empresa    	  = :ubi.empresa
				And    almlinubica.ubicacion       = :ubi.ubicacion
				And    almlinubica.linea           = :ln;
				IF SQLCA.SQLCODE <> 0 Then
					MessageBox("Error en proceso","Borrando de almlinubica",Exclamation!, OK!,1)
					var_bien = false
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
		
		sel =	 " Select linea,existencias from almlinubica" +&
				 " Where  empresa     = '" + ubi.empresa    +"'"+&
				 " And    ubicacion   = '" + ubi.ubicacion  +"'"+&
				 " And    referencia  = '" + ubi.referencia +"'"+&
				 " And    tipo_pallet = '" + ubi.tipo_pallet +"'"+&
				 " And    caja = '" + ubi.caja +"'"+&					  
				 " And    pedido is Null"

		dw_proceso2      = f_cargar_cursor2(sel)
		registros        = dw_proceso2.RowCount()
		cantidad_borrada = 0
		IF registros <> 0 THEN
			FOR x1=1 To registros
				cur_linea         =  dw_proceso2.GetItemNumber(x1,"linea")
				cur_existencias   =  dw_proceso2.GetItemNumber(x1,"existencias")
				cantidad_pendiente = total_cantidad - cantidad_borrada
				IF cantidad_pendiente = 0 THEN   EXIT
				IF cantidad_pendiente >= cur_existencias THEN 
					cantidad_borrada = cantidad_borrada + cur_existencias
					DELETE FROM almlinubica  
					WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
							( almlinubica.ubicacion = :ubi.ubicacion ) AND  
							( almlinubica.linea     = :cur_linea ) USING SQLCA;
					IF SQLCA.SQLCode<>0 THEN
						MessageBox("Error en proceso","Borrando de almlinubica",Exclamation!, OK!,1)
						var_bien = false
					END IF
				ELSE
					cur_existencias = cur_existencias - cantidad_pendiente
					cantidad_borrada = cantidad_borrada + cantidad_pendiente

					UPDATE almlinubica  
					SET    existencias   = :cur_existencias
					WHERE  almlinubica.empresa   = :ubi.empresa 
					AND    almlinubica.ubicacion = :ubi.ubicacion 
					AND  	 almlinubica.linea     = :cur_linea ;
						
					IF SQLCA.SQLCode<>0 THEN
						MessageBox("Error en proceso","Borrando de almlinubica",Exclamation!, OK!,1)
						var_bien = false
						EXIT
					END IF
				 END IF
			NEXT
		END IF
		IF cantidad_borrada <> total_cantidad THEN
			//var_bien = false
			//f_mensaje("Error",STring(cantidad_borrada)+ "<>" + STring(total_cantidad)+"  Cantidad Borrada no es igual ARTICULO:"+f_nombre_articulo(codigo_empresa,ubi.articulo))
			SetNUll(ubi.linea)
			String ubica = "00001A    000100"

			Select Max(linea) 
			Into   :ubi.linea 
			From   almlinubica
			Where  empresa   = :codigo_empresa
			And    ubicacion = :ubi.ubicacion;
			
			IF IsNUll(ubi.linea) Then ubi.linea = 0
			ubi.linea = ubi.linea +1
			SetNull(ubi.pedido)
			SetNull(ubi.anyo)
			SetNull(ubi.linped)
			SetNull(ubi.cliente)
			ubi.existencias = cantidad_borrada - total_cantidad
			IF Not f_insert_almlinubica(ubi) Then var_bien = false
		END IF
	END IF
	
	IF var_deposito = "S" Then
		///-----------------------------------------------------------------
		///---------   Grabar   entrada en el almacen de deposito   --------
		///-----------------------------------------------------------------
		IF IsNull(var_almacen_deposito) or Trim(var_almacen_deposito)= "" Then
			var_bien = false
			f_mensaje("Error en entrada de depositos","No hay almacen de deposito en la linea de carga")
		END IF
		// --------------------------------------------------------------------
		// ---------------------- Empezamos -----------------------------------
		// --------------------------------------------------------------------
		v_almacen = var_almacen_deposito
		IF IsNull(v_almacen) or Trim(v_almacen)= "" Then
			f_mensaje("Error de datos"," Este cliente no tiene almacen de deposito asignado")
			var_bien = false
		END IF
				
		depmovhis.empresa       = codigo_empresa
		depmovhis.almacen       = v_almacen
		depmovhis.anyo          = year(today())
		depmovhis.nummov        = f_depparam_nummov(codigo_empresa,depmovhis.anyo)
		depmovhis.articulo      = ubi.articulo
		depmovhis.fechmov       = DateTime(date(em_fecha.text))
//		depmovhis.tipomov       = f_tipomov_movimientos(ubihis.empresa,var_tipolinea, &
//											"empresa","codigo","ventipolin","tipomov_almtipomov_exp_dep")	
		depmovhis.tipomov       = ""//f_tipomov_movimientos(ubihis.empresa,var_tipolinea,"tipomov_deptipomov_exp_dep","ventipolin","empresa","codigo")	 //f_tipomov_movimientos(ubihis.empresa,var_tipolinea, &
		depmovhis.cantidade     = total_cantidad
		depmovhis.cantidads     = 0
		depmovhis.precio        = 0
		depmovhis.codtercero    = var_cliente
		depmovhis.numdoc        = string(var_albaran[var_contador],"##########0")
		depmovhis.situacion     = "N"
		depmovhis.observaciones = ""
		setnull(depmovhis.punteado)
		depmovhis.antexist      = 0
		depmovhis.familia       = ubi.familia
		depmovhis.formato       = ubi.formato
		depmovhis.modelo        = ubi.modelo
		depmovhis.calidad       = ubi.calidad
		depmovhis.tono          = 0
		depmovhis.calibre       = ubi.calibre
		depmovhis.tipo_unidad   = ubi.tipo_unidad
		depmovhis.referencia    = ubi.referencia
		depmovhis.f_alta        = DateTime(Today(),now())
		depmovhis.usuario       = nombre_usuario
		depmovhis.tipo_pallet   = ubi.tipo_pallet
		depmovhis.tipo          = ""
		depmovhis.caja          = ubi.caja
		depmovhis.tonochar      = ubi.tonochar
		
		deplinubica.empresa     = codigo_empresa
		deplinubica.almacen     = depmovhis.almacen
		deplinubica.linea       = 0
		deplinubica.articulo    = depmovhis.articulo
		deplinubica.familia     = depmovhis.familia
		deplinubica.formato     = depmovhis.formato
		deplinubica.modelo      = depmovhis.modelo
		deplinubica.calidad     = depmovhis.calidad
		deplinubica.tono        = depmovhis.tono
		deplinubica.calibre     = depmovhis.calibre
		deplinubica.existencias = depmovhis.cantidade
		deplinubica.cliente     = depmovhis.codtercero
		deplinubica.tipo_unidad = depmovhis.tipo_unidad
		deplinubica.referencia  = depmovhis.referencia
		deplinubica.f_alta      = depmovhis.f_alta
		deplinubica.tipo_pallet = depmovhis.tipo_pallet
		deplinubica.caja        = depmovhis.caja
		deplinubica.tonochar    = depmovhis.tonochar
		
		numero = 0
		
		select Count(*) 
		into   :numero 
		from   deplinubica  
		where  deplinubica.empresa     = :deplinubica.empresa 
		and    deplinubica.almacen     = :deplinubica.almacen
		and    deplinubica.articulo    = :deplinubica.articulo
		and    deplinubica.calidad     = :deplinubica.calidad
		and    deplinubica.tonochar    = :deplinubica.tonochar
		and    deplinubica.calibre     = :deplinubica.calibre
		and    deplinubica.tipo_pallet = :deplinubica.tipo_pallet 
		and    deplinubica.caja        = :deplinubica.caja;
		
		if isnull(numero) then numero = 0
		
		if numero > 1 then
			messagebox("Error","Lineas duplicadas en deposito")
			var_bien = false
		end if
		
//		IF numero <> 0 Then
		if numero = 1 then
			update deplinubica  
			set    existencias = deplinubica.existencias + :deplinubica.existencias
			where  deplinubica.empresa     = :deplinubica.empresa 
			and    deplinubica.almacen     = :deplinubica.almacen
			and    deplinubica.articulo    = :deplinubica.articulo
			and    deplinubica.calidad     = :deplinubica.calidad
			and    deplinubica.tonochar    = :deplinubica.tonochar
			and    deplinubica.calibre     = :deplinubica.calibre
			and    deplinubica.tipo_pallet = :deplinubica.tipo_pallet 
			and    deplinubica.caja        = :deplinubica.caja;
			
			if sqlca.sqlcode <> 0 then
				messagebox("Error",sqlca.sqlerrtext)
				var_bien = false
			end if
		else
			select max(deplinubica.linea)
			into   :cur_linea  
			from   deplinubica  
			where  deplinubica.empresa = :deplinubica.empresa
			and    deplinubica.almacen = :deplinubica.almacen;
			
			if isnull(cur_linea) then cur_linea = 0 
			cur_linea    = cur_linea + 1
			deplinubica.linea = cur_linea
			
			if not f_insert_deplinubica(deplinubica) then
				f_mensaje("Error","Al insertar en deplinubica")
				var_bien = false
			end if
			//-----------------------Fin Grabación Lineas de Ubicacion--------------
		end if
		// Grabar el movimiento en el historico por el total de existencias
		if not f_insert_depmovhis(depmovhis) then
			MessageBox("Error en proceso","Grabando depmovhis",Exclamation!, OK!,1)
			var_bien = false
		end if
		if not f_actualiza_depnummov(depmovhis.empresa,depmovhis.anyo,depmovhis.nummov) then
			MessageBox("Error en proceso","Actualizando contador depmovhis",Exclamation!, OK!,1)
			var_bien = false
		end if
	end if
end if

Destroy dw_proceso2

return var_bien
end function

public subroutine f_todo ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.RowCount() = 0 Then Return
FOR t = 1 To dw_detalle.RowCount()
		f_marcar_linea(t)	
NEXT

end subroutine

public subroutine f_marcar_linea (integer t);Dec{4} num,d,var_cantidad,var_pallets,var_cajas,var_cantidadp,var_palletsp,var_cajasp,var_total_cajas,var_total_cajasp
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo   = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea  = dw_detalle.GetItemNumber(t,"venliped_linea")
		var_cantidad  = dw_detalle.GetItemNumber(t,"venliped_cantidad")
		var_pallets   = dw_detalle.GetItemNumber(t,"venliped_pallets")
		var_cajas     = dw_detalle.GetItemNumber(t,"venliped_cajas")		
		var_total_cajas     = dw_detalle.GetItemNumber(t,"venliped_total_cajas")		
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num = 0 Then
			Select cantidad,pallets,cajas,total_cajas
			Into   :var_cantidadp,:var_palletsp,:var_cajasp,:var_total_cajasp
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			IF var_cantidadp<var_cantidad Then
				f_mensaje("Error en introduccion de datos","La cantidad no puede superar al pedido")
				dw_detalle.SetItem(t,"venliped_cantidad",var_cantidadp)
				dw_detalle.SetItem(t,"venliped_pallets",var_palletsp)
				dw_detalle.SetItem(t,"venliped_cajas",var_cajasp)
				dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajasp)
				return
			END IF
			dw_detalle.SetColumn("marcado")
			dw_detalle.SetItem(t,"marcado","X")
			d= dw_temporal.RowCOunt() +1
			dw_temporal.InsertRow(d)
			dw_temporal.SetItem(d,"pedido",var_pedido)
			dw_temporal.SetItem(d,"anyo",var_anyo)
			dw_temporal.SetItem(d,"linea",var_linea)
			dw_temporal.SetItem(d,"cantidad",var_cantidad)
			dw_temporal.SetItem(d,"pallets",var_pallets)
			dw_temporal.SetItem(d,"cajas",var_cajas)
			dw_temporal.SetItem(d,"total_cajas",var_total_cajas)
		END IF
END IF


end subroutine

public subroutine f_control_marcar_linea (integer t);Dec num,d
Dec{0}  var_pedido,var_linea,var_anyo
dw_detalle.AcceptText()
IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		IF dw_detalle.GetItemString(t,"marcado")= "" Then
			f_marcar_linea(t)
		ELSE
			f_desmarcar_linea(t)
		END IF
END IF


end subroutine

public subroutine f_desmarcar_linea (integer t);Dec num,d,var_cantidad,var_pallets,var_cajas,var_total_cajas
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.GetItemString(t,"venliped_situacion")<> "F" Then
		var_anyo   = dw_detalle.GetItemNumber(t,"venliped_anyo")
		var_pedido = dw_detalle.GetItemNumber(t,"venliped_pedido")
		var_linea  = dw_detalle.GetItemNumber(t,"venliped_linea")
		num = dw_temporal.find("anyo=" + String(var_anyo) + "and pedido=" + String(var_pedido) + "and linea=" + String(var_linea),1,dw_temporal.RowCount())
		IF num <>0 Then
			Select cantidad,pallets,cajas,total_cajas
			Into   :var_cantidad,:var_pallets,:var_cajas,:var_total_cajas
			From   venliped
			Where  venliped.empresa = :codigo_empresa
			And    venliped.anyo    = :var_anyo
			And    venliped.pedido  = :var_pedido
			And    venliped.linea   = :var_linea;
			dw_temporal.DeleteRow(num)
			dw_detalle.SetItem(t,"marcado","")
			dw_detalle.SetItem(t,"venliped_cantidad",var_cantidad)
			dw_detalle.SetItem(t,"venliped_pallets",var_pallets)
			dw_detalle.SetItem(t,"venliped_cajas",var_cajas)
			dw_detalle.SetItem(t,"venliped_total_cajas",var_total_cajas)
		END IF
END IF



end subroutine

public subroutine f_nada ();Dec t,num,d
Dec{0}  var_pedido,var_linea,var_anyo
IF dw_detalle.RowCount() = 0 Then Return
FOR t = 1 To dw_detalle.RowCount()
		f_desmarcar_linea(t)	
NEXT

end subroutine

public function integer f_calcula_albaranes_a_generar ();int  li_anyo_pedido,li_anyo_pedido_ant
long ll_pedido,ll_pedido_ant,ll_indice,ll_total,ll_indice_albaranes
string ls_cliente,ls_deposito,ls_deposito_ant,ls_cliente_agrupa_ped,ls_cliente_agrupa_ref
boolean lb_separar_pedidos,lb_separar_referencias,lb_nuevo_albaran

str_venped lstr_venped,lstr_venped_ant

li_anyo_pedido_ant = 0
ll_pedido_ant      = 0

ll_total = dw_pedido.rowcount()

ll_indice_albaranes      = 0
istr_albaranes_a_generar = istr_albaranes_a_generar_vacio
ls_deposito_ant          = ""
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
		
		if li_anyo_pedido_ant = 0 then
			//El primer pedido ya genera un albaran
			li_anyo_pedido_ant = li_anyo_pedido
			ll_pedido_ant      = ll_pedido
			//f_cargar_str_venped(codigo_empresa,li_anyo_pedido,ll_pedido,lstr_venped)
			//f_inicializar_str_venped(lstr_venped)
			lstr_venped_ant = lstr_venped						
			lb_nuevo_albaran = true
		end if

		if li_anyo_pedido <> li_anyo_pedido_ant or ll_pedido <> ll_pedido_ant then
			li_anyo_pedido_ant = li_anyo_pedido
			ll_pedido_ant      = ll_pedido			
			lstr_venped_ant = lstr_venped
			//f_cargar_str_venped(codigo_empresa,li_anyo_pedido,ll_pedido,lstr_venped)
			//f_inicializar_str_venped(lstr_venped)			
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
		
		istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real        = istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real + dw_pedido.object.venliped_peso_neto[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real       = istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real + dw_pedido.object.venliped_peso[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_modificado  = istr_albaranes_a_generar[ll_indice_albaranes].peso_neto_real
		istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_modificado = istr_albaranes_a_generar[ll_indice_albaranes].peso_bruto_real
		istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales        = istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales + dw_pedido.object.venliped_pallets[ll_indice]
		istr_albaranes_a_generar[ll_indice_albaranes].pallets_modificados   = istr_albaranes_a_generar[ll_indice_albaranes].pallets_reales
		istr_albaranes_a_generar[ll_indice_albaranes].lineas_pedidos ++
		
		dw_pedido.object.albaran[ll_indice] = ll_indice_albaranes
		
		lstr_venped_ant = lstr_venped
	end if	
next

return 0
end function

event open;call super::open;istr_parametros.s_titulo_ventana = "Expedicion directa de pedidos"
This.title    = istr_parametros.s_titulo_ventana
paso          = 1
em_fecha.text = String(Today(),"dd-mm-yy")
uo_zona_carga.em_codigo.text = "1"

uo_zona_carga.triggerevent("modificado")

//uo_almacen.em_campo.text  = f_nombre_almacen(codigo_empresa,uo_almacen.em_codigo.text)
es_cliente.text = "Cliente"

dw_1.SetTransObject(SQLCA)
dw_ubicaciones.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)
dw_consulta.SetTransObject(SQLCA)
dw_consulta_muestras.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_pedido.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"venliped_cantidad",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"venliped_cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"venliped_total_cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"venliped_pallets",f_mascara_decimales(0))
f_activar_campo(em_cliente)
 

end event

on w_expedir_pedidos_cmr.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
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
this.dw_temporal=create dw_temporal
this.dw_albaranes=create dw_albaranes
this.dw_ubicaciones=create dw_ubicaciones
this.dw_1=create dw_1
this.cb_expedir_promocion=create cb_expedir_promocion
this.uo_zona_carga=create uo_zona_carga
this.st_2=create st_2
this.dw_pedido=create dw_pedido
this.dw_detalle=create dw_detalle
this.cbx_muestras=create cbx_muestras
this.es_cliente=create es_cliente
this.dw_consulta_muestras=create dw_consulta_muestras
this.dw_consulta=create dw_consulta
this.dw_listado_cmr=create dw_listado_cmr
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_cmr=create st_cmr
this.em_cmr=create em_cmr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_cliente
this.Control[iCurrent+4]=this.st_nomcliente
this.Control[iCurrent+5]=this.cb_marcar_todo
this.Control[iCurrent+6]=this.st_operario
this.Control[iCurrent+7]=this.uo_operario
this.Control[iCurrent+8]=this.st_fecha
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.st_albaran
this.Control[iCurrent+11]=this.em_albaran
this.Control[iCurrent+12]=this.listar
this.Control[iCurrent+13]=this.em_copias
this.Control[iCurrent+14]=this.st_copias
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_temporal
this.Control[iCurrent+17]=this.dw_albaranes
this.Control[iCurrent+18]=this.dw_ubicaciones
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.cb_expedir_promocion
this.Control[iCurrent+21]=this.uo_zona_carga
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.dw_pedido
this.Control[iCurrent+24]=this.dw_detalle
this.Control[iCurrent+25]=this.cbx_muestras
this.Control[iCurrent+26]=this.es_cliente
this.Control[iCurrent+27]=this.dw_consulta_muestras
this.Control[iCurrent+28]=this.dw_consulta
this.Control[iCurrent+29]=this.dw_listado_cmr
this.Control[iCurrent+30]=this.cb_2
this.Control[iCurrent+31]=this.cb_3
this.Control[iCurrent+32]=this.cb_4
this.Control[iCurrent+33]=this.st_cmr
this.Control[iCurrent+34]=this.em_cmr
end on

on w_expedir_pedidos_cmr.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.st_1)
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
destroy(this.dw_temporal)
destroy(this.dw_albaranes)
destroy(this.dw_ubicaciones)
destroy(this.dw_1)
destroy(this.cb_expedir_promocion)
destroy(this.uo_zona_carga)
destroy(this.st_2)
destroy(this.dw_pedido)
destroy(this.dw_detalle)
destroy(this.cbx_muestras)
destroy(this.es_cliente)
destroy(this.dw_consulta_muestras)
destroy(this.dw_consulta)
destroy(this.dw_listado_cmr)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_cmr)
destroy(this.em_cmr)
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

event closequery;call super::closequery;if lb_cerrar_ventana then
	return 0
else
	return 1
end if

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_expedir_pedidos_cmr
integer x = 608
integer y = 664
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_expedir_pedidos_cmr
integer taborder = 80
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_expedir_pedidos_cmr
integer width = 3433
end type

type pb_1 from upb_salir within w_expedir_pedidos_cmr
integer x = 3461
integer y = 8
integer width = 119
integer height = 108
integer taborder = 0
end type

type st_1 from statictext within w_expedir_pedidos_cmr
integer x = 146
integer y = 132
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_expedir_pedidos_cmr
integer x = 384
integer y = 120
integer width = 411
integer taborder = 60
end type

event modificado;call super::modificado;//long pedidos_promocion
//
//st_nomcliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
//if Trim(st_nomcliente.text) = "" then
//	if Trim(st_nomcliente.text) <> "" then f_activar_campo(em_cliente)
//	em_cliente.text = ""	
//	cb_expedir_promocion.visible = false
//else
//	select count(*)
//	into   :pedidos_promocion
//	from   promped
//	where  empresa      = :codigo_empresa
//	and    tipo_cliente = 'S'
//	and    cliente      = :em_cliente.text
//	and    ((situacion = 'P') or (tipo = '2' and situacion = 'S' and exp_cargado = 'N'));
//	
//	if isnull(pedidos_promocion) then pedidos_promocion = 0
//	
//	if pedidos_promocion > 0 then
//		cb_expedir_promocion.visible = true
//		messagebox("Atención","Cliente con pedidos de promoción.")
//	else
//		cb_expedir_promocion.visible = false
//	end if
//end if
//
//dw_detalle.reset()
//dw_consulta.Retrieve(codigo_empresa,em_cliente.text)
//dw_temporal.Reset()
//
//
//
long   pedidos_promocion,pedidos_muestras
int    li_num_copias_albaran
string filtro_serie,mensaje,escli 
st_nomcliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	

if es_cliente.text = "Contacto" then
	escli = 'N'
	st_nomcliente.text = f_nombre_vencliproforma(codigo_empresa,em_cliente.text)
else
	escli = 'S'
end if

if Trim(st_nomcliente.text) = "" then
	if Trim(st_nomcliente.text) <> "" then f_activar_campo(em_cliente)
	em_cliente.text = ""	
	cb_expedir_promocion.visible = false
else
	if escli = 'S' then
		select isnull(num_copias_albaran,0)
		into   :li_num_copias_albaran
		from   venclientes
		where  empresa      = :codigo_empresa
		and    codigo      = :em_cliente.text;
		
		if isnull(li_num_copias_albaran) then li_num_copias_albaran = 0
		
		em_copias.text = string(li_num_copias_albaran,"#0")
		
		select count(*)
		into   :pedidos_promocion
		from   promped
		where  empresa      = :codigo_empresa
		and    tipo_cliente = 'S'
		and    cliente      = :em_cliente.text
		and    ((situacion = 'P') or (tipo = '2' and situacion = 'S' and exp_cargado = 'N'));
		
		if isnull(pedidos_promocion) then pedidos_promocion = 0
		
		if pedidos_promocion > 0 then
			cb_expedir_promocion.visible = true
			messagebox("Atención","Cliente con pedidos de promoción.")
		else
			cb_expedir_promocion.visible = false
		end if
	else
		li_num_copias_albaran = 4
		
		em_copias.text = string(li_num_copias_albaran,"#0")		
	end if
end if

if cbx_muestras.checked then
	filtro_serie = "venped_serie = '6'"
else
	filtro_serie = "venped_serie <> '6'"
end if


dw_detalle.reset()
dw_consulta.setfilter(filtro_serie)
dw_consulta.filter()
dw_consulta.Retrieve(codigo_empresa,em_cliente.text,escli)

//dw_consulta_muestras.reset()
//dw_consulta_muestras.setfilter("venped_serie = '6'")
//dw_consulta_muestras.filter()
//dw_consulta_muestras.Retrieve(codigo_empresa,em_cliente.text, escli)
dw_consulta_muestras.Retrieve(codigo_empresa,em_cliente.text)
dw_temporal.Reset()


end event

event getfocus;call super::getfocus;string escli

if es_cliente.text = "Contacto" then
	escli = 'N'
else
	escli = 'S'
end if

if escli = 'S' then
	ue_titulo     = "AYUDA SELECCION CLIENTES"
	ue_datawindow = "dw_ayuda_clientes"
	ue_filtro     = "" 		
else
	ue_titulo     = "AYUDA SELECCION CONTACTOS"
	ue_datawindow = "dw_ayuda_vencliproforma"
	ue_filtro     = "" 		
end if
end event

type st_nomcliente from statictext within w_expedir_pedidos_cmr
integer x = 805
integer y = 124
integer width = 1184
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_marcar_todo from u_boton within w_expedir_pedidos_cmr
event clicked pbm_bnclicked
boolean visible = false
integer x = 3237
integer y = 1668
integer width = 343
integer height = 76
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
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

type st_operario from statictext within w_expedir_pedidos_cmr
boolean visible = false
integer x = 265
integer y = 1676
integer width = 677
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Operario"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_operario from u_em_campo_2 within w_expedir_pedidos_cmr
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 265
integer y = 1744
integer width = 672
integer height = 80
integer taborder = 90
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

type st_fecha from statictext within w_expedir_pedidos_cmr
boolean visible = false
integer x = 942
integer y = 1676
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Alb"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_expedir_pedidos_cmr
boolean visible = false
integer x = 942
integer y = 1744
integer width = 297
integer height = 80
integer taborder = 100
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_albaran from statictext within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1239
integer y = 1676
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

type em_albaran from u_em_campo within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1239
integer y = 1744
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

type listar from radiobutton within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1513
integer y = 1768
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type em_copias from u_em_campo within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1705
integer y = 1684
integer width = 183
integer height = 72
integer taborder = 110
string text = "0"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "##"
boolean spin = true
string displaydata = "("
end type

type st_copias from statictext within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1518
integer y = 1684
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_expedir_pedidos_cmr
integer x = 2112
integer y = 1668
integer width = 663
integer height = 76
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&ontinuar"
end type

event clicked;dw_pedido.SetRedraw(FALSE)
STring var_ubicacion,var_referencia,var_tipo_pallet,var_tipolinea,var_caja,var_zona_carga,var_articulo
Dec var_cantidad,var_pallets,var_cajas,var_total_cajas,var_peso,var_peso_neto
IF dw_consulta.GetRow() = 0 Then Return

dw_pedido.Retrieve(codigo_empresa,em_cliente.text)
Dec t,var_anyo,var_pedido,var_linea,n

var_zona_carga = uo_zona_carga.em_codigo.text

For t = 1 To dw_pedido.RowCount()
	IF dw_pedido.GetItemString(t,"venliped_situacion") = "F" Then dw_pedido.SetItem(t,"cmarcado","")
	IF dw_pedido.GetItemString(t,"cmarcado") <> "F" Then
 		   dw_pedido.SetItem(t,"cmarcado","X")
			var_anyo        = dw_pedido.object.venliped_anyo[t]
			var_pedido      = dw_pedido.object.venliped_pedido[t]
			var_linea       = dw_pedido.object.venliped_linea[t]
			var_referencia  = dw_pedido.object.venliped_referencia[t]
			var_articulo    = dw_pedido.object.venliped_articulo[t]
			var_tipo_pallet = dw_pedido.object.venliped_tipo_pallet[t]
			var_caja        = dw_pedido.object.venliped_caja[t]
			var_tipolinea   = dw_pedido.object.venliped_tipolinea[t]
			
			if isnull(var_tipo_pallet) then var_tipo_pallet = ""
			if isnull(var_caja)        then var_caja = ""
			
			n =  dw_temporal.find("anyo=" + String(var_anyo,"####") + "and pedido=" + String(var_pedido,"###############") + "and linea=" + String(var_linea,"############"),1,dw_temporal.RowCount())
			IF IsNULL(n) Then n = 0
			IF n = 0 Then
				dw_pedido.SetItem(t,"cok","N")
			ELSE
				var_cantidad    = dw_temporal.object.cantidad[n]
				var_cajas       = dw_temporal.object.cajas[n]
			   var_total_cajas = dw_temporal.object.total_cajas[n]
				var_pallets     = dw_temporal.object.pallets[n]

				//falte el control de peso en caso que no expidamos toda la cantidad
				var_peso      = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,var_cajas,var_total_cajas,var_pallets,var_cantidad,var_caja)
				var_peso_neto = f_calculo_peso_neto(codigo_empresa,var_articulo,var_cajas,var_total_cajas,var_cantidad,var_caja)
				//
				
				dw_pedido.object.venliped_cantidad[t]    = var_cantidad
				dw_pedido.object.venliped_pallets[t]     = var_pallets
				dw_pedido.object.venliped_cajas[t]       = var_cajas
				dw_pedido.object.venliped_total_cajas[t] = var_total_cajas
				dw_pedido.object.venliped_peso[t]        = var_peso
				dw_pedido.object.venliped_peso_neto[t]   = var_peso_neto		

				IF f_control_almacen_ventipolin(codigo_empresa,var_tipolinea)="S" then
					IF dw_pedido.GetItemString(t,"venliped_situacion") = "P" Then
						var_ubicacion = ""//f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,var_tipo_pallet,var_caja,var_anyo,var_pedido,var_linea)
					Else
						IF IsNull(var_tipo_pallet) Then  var_tipo_pallet = ""
						//***Devuelve una ubicación si solo existe una posible en el almacen
						var_ubicacion = ""//f_ubicacion_ref_pallet_caja_cantidad_zc(codigo_empresa,var_referencia,var_tipo_pallet,var_caja,var_cantidad,var_zona_carga)
						//var_ubicacion = ""
					END IF
				END IF

				dw_pedido.SetItem(t,"cubicacion",var_ubicacion)
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
f_campos(TRUE)
em_albaran.text = ""
//dw_pedido.SetSort("suborden,venliped_deposito,venped_agrupa_exp,venliped_anyo,venliped_pedido,venliped_linea")
//dw_pedido.Sort()
dw_pedido.SetRow(1)
dw_pedido.SelectRow(0,FALSE)
dw_pedido.SelectRow(1,TRUE)


end event

type dw_temporal from datawindow within w_expedir_pedidos_cmr
boolean visible = false
integer x = 3109
integer y = 4
integer width = 128
integer height = 112
boolean bringtotop = true
string dataobject = "dw_expedicion_pedidos3"
boolean livescroll = true
end type

type dw_albaranes from datawindow within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1147
integer y = 1188
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

type dw_ubicaciones from datawindow within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1495
integer y = 740
integer width = 1774
integer height = 564
boolean bringtotop = true
boolean titlebar = true
string title = "Asignacion de Ubicaciones."
string dataobject = "dw_expedicion_pedidos4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String ubi,var_zona,var_almacen
Dec var_fila,var_altura,var_pedido,var_cantidad_expedir,var_cantidad_ubicacion
Dec var_anyo,var_orden,var_linea

IF row = 0 Then Return
IF dw_pedido.GetRow()= 0 Then Return
IF dw_pedido.GetItemString(dw_pedido.GetRow(),"venliped_situacion") = "P" Then Return

var_cantidad_expedir   = dw_pedido.object.venliped_cantidad[dw_pedido.getrow()]
var_cantidad_ubicacion = this.object.almlinubica_existencias[row]

if var_cantidad_expedir > var_cantidad_ubicacion then
	messagebox("¡Error!","No hay suficientes existencias en la ubicacion")
else
	var_almacen  = GetItemString(row,"almlinubica_almacen")
	var_zona     = GetItemString(row,"zona")
	var_fila     = GetItemNumber(row,"fila")
	var_altura   = GetItemNumber(row,"altura")
	
	ubi = f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura)
	
	IF f_ubi_exist(codigo_empresa,var_almacen,var_zona,var_fila,var_altura) Then
		dw_pedido.SetItem(dw_pedido.GetRow(),"cubicacion",ubi)
		Commit;
	ELSE
		f_mensaje("Error en datos","La ubicacion no existe")
	END IF
	This.visible = FALSE
	dw_pedido.enabled = TRUE
end if


end event

event clicked;string ls_ubicacion_agrupamos
long   ll_donde,ll_row_pedido
dec    ld_cantidad_pedido
str_parametros str
dwobject ldwo_dwo
str_parametros valores

IF f_objeto_datawindow(This) = "salir" Then
	dw_ubicaciones.visible = FALSE
	dw_pedido.enabled = TRUE
END IF

IF f_objeto_datawindow(This) = "agrupar" Then
	String  var_calidad,var_tipo_pallet,var_articulo,var_caja,var_tonochar,var_tipolin,var_zona_carga
	Dec{0}  var_calibre
	IF THIS.rowCOUNT() = 0 Then Return
	ll_row_pedido = dw_pedido.getrow()
	if ll_row_pedido > 0 then
		var_articulo    = dw_pedido.GetItemString(ll_row_pedido,"venliped_articulo") 
		var_calidad     = dw_pedido.GetItemString(ll_row_pedido,"venliped_calidad")  
		var_tipo_pallet = dw_pedido.GetItemString(ll_row_pedido,"venliped_tipo_pallet")  
		var_caja 		 = dw_pedido.GetItemString(ll_row_pedido,"venliped_caja")  
		var_calibre     = dw_pedido.GetItemNumber(ll_row_pedido,"venliped_calibre")  
		var_tonochar    = dw_pedido.GetItemstring(ll_row_pedido,"venliped_tonochar")  
		var_zona_carga	 = "%"
		ld_cantidad_pedido = dw_pedido.object.venliped_cantidad[ll_row_pedido]
	else
		var_articulo    = ""
		var_calidad     = ""
		var_tipo_pallet = ""
		var_caja 		 = ""
		var_calibre     = 0
		var_tonochar    = ""
		var_zona_carga	 = ""	
		ld_cantidad_pedido = 0
	end if
	str.s_argumentos[1]= "w_expedir_ordenes_carga"
	str.s_argumentos[2]= var_articulo
	str.s_argumentos[3]= var_calidad
	str.s_argumentos[4]= var_tipo_pallet
	str.s_argumentos[5]= var_caja
	str.s_argumentos[6]= string(var_calibre,"#0")
	str.s_argumentos[7]= var_tonochar
	str.s_argumentos[8]= var_zona_carga
	str.s_argumentos[9]= string(ld_cantidad_pedido)
	
	str.i_nargumentos = 9
	//OpenWithParm(w_agrupa_ubicaciones,str)
	
	if Message.DoubleParm <> -1  then
		if isvalid(Message) then
			valores = Message.PowerObjectParm
			ls_ubicacion_agrupamos = valores.s_argumentos[1]	
		end if
	end if
	
	dw_pedido.event rbuttondown(0,0,dw_pedido.getrow(),ldwo_dwo)
	
	this.selectrow(0,false)
	
	if trim(ls_ubicacion_agrupamos) <> "" and this.rowcount() > 0 then
		ll_donde = this.find("almlinubica_ubicacion = '"+ls_ubicacion_agrupamos+"'",1,this.rowcount())
		
		if ll_donde > 0 then
			this.selectrow(ll_donde,true)
			this.scrolltorow(ll_donde)
		end if
	end if
	//Open(w_agrupa_ubicaciones)
	//VAR_ZONA_CARGA = UO_ZONA_CARGA.EM_CODIGO.TEXT
	
	//IF ISNULL(var_zona_carga) THEN var_zona_carga=""	
END IF
end event

type dw_1 from datawindow within w_expedir_pedidos_cmr
boolean visible = false
integer x = 2967
integer y = 4
integer width = 114
integer height = 108
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ubicaciones_articulo_nuevo"
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
case "pb_cerrar"
	this.visible = false
	dw_pedido.enabled = true
end choose	
end event

event doubleclicked;if row > 0 then
	dw_pedido.setitem(dw_pedido.getrow(),"venliped_tonochar",this.getitemstring(this.getrow(),"almlinubica_tonochar"))
	dw_pedido.setitem(dw_pedido.getrow(),"venliped_calibre",this.getitemnumber(this.getrow(),"almlinubica_calibre"))
end if
end event

type cb_expedir_promocion from u_boton within w_expedir_pedidos_cmr
boolean visible = false
integer x = 3040
integer y = 124
integer width = 539
integer height = 80
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Expedir Promoción"
end type

event clicked;str_parametros lstr_param
lstr_param.i_nargumentos   = 2
lstr_param.s_argumentos[2] = em_cliente.text
//OpenSheetWithParm(w_expedicion_pedidos_promocion,lstr_param,ventana_padre,5,Original!)
end event

type uo_zona_carga from u_em_campo_2 within w_expedir_pedidos_cmr
event destroy ( )
integer x = 2382
integer y = 120
integer width = 608
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_zona_carga.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = ""//f_descripcion_alm_zona_carga(codigo_empresa,this.em_codigo.text)

if Trim(this.em_campo.text) = "" then
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	return
end if 

end event

event getfocus;call super::getfocus;
ue_titulo     = "Selección de Zonas de carga"
ue_datawindow = "dw_ayuda_alm_zonas_carga"
ue_filtro     = ""

end event

type st_2 from statictext within w_expedir_pedidos_cmr
integer x = 1952
integer y = 132
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Zona Carga:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_pedido from u_datawindow_consultas within w_expedir_pedidos_cmr
boolean visible = false
integer x = 9
integer y = 224
integer width = 3579
integer height = 1444
integer taborder = 0
string dataobject = "dw_expedicion_pedidos5"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec var_anyo,var_pedido,var_linea,var_cajas,var_pallets,var_total_cajas

IF f_objeto_datawindow(This) = "salir" Then
 	f_salir()
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
	dw_pedido.Accepttext()
	dw_pedido.Update()
	COMMIT;
	f_calcula_albaranes_a_generar()
 	IF f_control_existencias() Then f_expedir()
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
		//this.settaborder("venliped_pallets",50)
		this.setcolumn("venliped_pallets")
		this.setrow(getrow())
		this.settext(string(var_pallets -1))
		//this.settaborder("venliped_pallets",0)		
		
		//SetItem(GetRow(),"venliped_pallets",var_pallets -1)
		this.accepttext()
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
		
		//this.settaborder("venliped_pallets",50)
		this.setcolumn("venliped_pallets")
		this.setrow(getrow())
		this.settext(string(var_pallets +1))	
		//this.settaborder("venliped_pallets",0)	
		
		//SetItem(GetRow(),"venliped_pallets",var_pallets +1)
		this.accepttext()
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
		var_anyo   = dw_pedido.GetItemNumber(GetRow(),"venliped_anyo")		
		var_pedido = dw_pedido.GetItemNumber(GetRow(),"venliped_pedido")		
		var_linea  = dw_pedido.GetItemNumber(GetRow(),"venliped_linea")		
		var_cajas  = dw_pedido.GetItemNumber(GetRow(),"venliped_cajas")		
		var_total_cajas    = dw_pedido.GetItemNumber(GetRow(),"venliped_total_cajas")		
      if var_total_cajas = 0 or isnull(var_total_cajas) then return
		Update   venliped		
		Set      venliped.cajas = cajas - 1,
		         venliped.total_cajas = total_cajas - 1
		Where    venliped.empresa = :codigo_empresa
		And      venliped.anyo    = :var_anyo
		And      venliped.pedido  = :var_pedido
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

if dwo.name = 'cmarcado' then
	IF dw_pedido.GetItemString(This.GetRow(),"venliped_situacion") <> "F" Then
		IF f_valor_columna(This,GetRow(),"cmarcado") = "X" Then
			//this.settaborder("cmarcado",50)
			this.setcolumn("cmarcado")
			this.settext("")
			//this.settaborder("cmarcado",0)
			//this.accepttext( )
			//This.SetItem(GetRow(),"cmarcado","")
		ELSE
			//this.settaborder("cmarcado",50)
			this.setcolumn("cmarcado")
			this.settext("X")
			//this.settaborder("cmarcado",0)
			//this.accepttext( )		
			//This.SetItem(GetRow(),"cmarcado","X")
		END IF
	END IF
end if
end event

event rbuttondown;call super::rbuttondown;String  var_calidad,var_tipo_pallet,var_articulo,var_caja,var_tonochar,var_tipolin,var_zona_carga
Dec{0}  var_calibre

IF row = 0 Then Return
IF This.GetItemString(row,"venliped_situacion") = "P" Then Return
var_articulo    = This.GetItemString(row,"venliped_articulo") 
var_calidad     = This.GetItemString(row,"venliped_calidad")  
var_tipo_pallet = This.GetItemString(row,"venliped_tipo_pallet")  
var_caja 		 = This.GetItemString(row,"venliped_caja")  
var_calibre     = This.GetItemNumber(row,"venliped_calibre")  
var_tonochar    = This.GetItemstring(row,"venliped_tonochar")  
var_tipolin		 = This.GetItemString(row,"venliped_tipolinea")  

var_zona_carga = uo_zona_carga.em_codigo.text

CHOOSE CASE f_objeto_datawindow(This)

CASE "venliped_tonochar"
	dw_1.retrieve (codigo_empresa,var_articulo,var_calidad,var_tipo_pallet,var_caja)
	if dw_1.rowcount() > 0 then
		dw_1.y = ypos 
		dw_1.visible = true
		dw_1.setfocus()
	else
		messagebox ("Atención","No hay existencias del articulo seleccionado")
	end if
CASE "venliped_calibre"
	dw_1.retrieve (codigo_empresa,var_articulo,var_calidad,var_tipo_pallet,var_caja)
	if dw_1.rowcount() > 0 then
		dw_1.y = ypos 	
		dw_1.visible = true
		dw_1.setfocus()
	else
		messagebox ("Atención","No hay existencias del articulo seleccionado")
	end if	
CASE else	
	this.enabled = FALSE
	dw_ubicaciones.visible = TRUE
	dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad,var_tonochar,var_calibre,var_tipo_pallet,var_caja,var_zona_carga)

end choose
end event

event itemchanged;call super::itemchanged;string  ls_linea_marcada
long    ll_albaran,ll_pallets_linea,ll_pallets_ant,ll_diferencia_pallets
decimal ld_peso_neto_linea,ld_peso_bruto_linea

choose case dwo.name
	case 'cmarcado'
		ls_linea_marcada    = data
		ll_albaran          = this.object.albaran[row]
		ld_peso_neto_linea  = this.object.venliped_peso_neto[row]
		ld_peso_bruto_linea = this.object.venliped_peso[row]
		ll_pallets_linea    = this.object.venliped_pallets[row]
		
		if ls_linea_marcada = 'X' then
			istr_albaranes_a_generar[ll_albaran].peso_neto_real  = istr_albaranes_a_generar[ll_albaran].peso_neto_real + ld_peso_neto_linea
			istr_albaranes_a_generar[ll_albaran].peso_bruto_real = istr_albaranes_a_generar[ll_albaran].peso_bruto_real + ld_peso_bruto_linea
			istr_albaranes_a_generar[ll_albaran].pallets_reales  = istr_albaranes_a_generar[ll_albaran].pallets_reales + ll_pallets_linea
			istr_albaranes_a_generar[ll_albaran].lineas_pedidos ++
		else
			istr_albaranes_a_generar[ll_albaran].peso_neto_real  = istr_albaranes_a_generar[ll_albaran].peso_neto_real - ld_peso_neto_linea
			istr_albaranes_a_generar[ll_albaran].peso_bruto_real = istr_albaranes_a_generar[ll_albaran].peso_bruto_real - ld_peso_bruto_linea			
			istr_albaranes_a_generar[ll_albaran].pallets_reales  = istr_albaranes_a_generar[ll_albaran].pallets_reales - ll_pallets_linea
			istr_albaranes_a_generar[ll_albaran].lineas_pedidos --
		end if
		
		istr_albaranes_a_generar[ll_albaran].peso_neto_modificado  = istr_albaranes_a_generar[ll_albaran].peso_neto_real
		istr_albaranes_a_generar[ll_albaran].peso_bruto_modificado = istr_albaranes_a_generar[ll_albaran].peso_bruto_real		
		istr_albaranes_a_generar[ll_albaran].pallets_modificados   = istr_albaranes_a_generar[ll_albaran].pallets_reales
	case 'venliped_pallets'
		ll_pallets_linea = dec(data)
		
		if this.object.cmarcado[row] = "X" then
			ll_albaran            = this.object.albaran[row]
			ll_pallets_ant        = this.object.venliped_pallets[row]
			ll_diferencia_pallets = ll_pallets_linea - ll_pallets_ant
			
			istr_albaranes_a_generar[ll_albaran].pallets_reales  = istr_albaranes_a_generar[ll_albaran].pallets_reales + ll_diferencia_pallets
			istr_albaranes_a_generar[ll_albaran].pallets_modificados   = istr_albaranes_a_generar[ll_albaran].pallets_reales
		end if
		
end choose
end event

type dw_detalle from u_datawindow_consultas within w_expedir_pedidos_cmr
integer x = 471
integer y = 224
integer width = 3122
integer height = 1444
integer taborder = 10
string dataobject = "dw_expedir_pedidos_cmr2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec pallet,cajas,vanyo,vpedido,total_cajas,vlinea
string marcado


if GetRow() = 0 tHEN Return
IF f_objeto_datawindow(This) = "todo" Then
	f_todo()
END IF
IF f_objeto_datawindow(This) = "nada" Then
	f_nada()
END IF
	
vanyo    = GetItemNumber(GetRow(),"venliped_anyo")
vpedido  = GetItemNumber(GetRow(),"venliped_pedido")
vlinea   = GetItemNumber(GetRow(),"venliped_linea")

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
		lstr_param.s_argumentos[1]  = "w_expedir_pedidos_cmr"
		lstr_param.s_argumentos[2]  = String(GetItemNumber(GetRow(),"venliped_anyo"))
		lstr_param.s_argumentos[3]  = String(GetItemNumber(GetRow(),"venliped_pedido"))
		lstr_param.s_argumentos[4]  = String(GetItemNumber(GetRow(),"venliped_linea"))
		//OpenSheetWithParm(w_int_preparacion_pedido,lstr_param,ventana_padre,5,original!)
//		IF  Message.StringParm = "S" Then f_proceso()
END IF

if row=0 then return
marcado = this.GetItemString(row,"marcado")

if marcado = "X" then
	This.SetTabOrder("venliped_pallets",0)	
	This.SetTabOrder("venliped_cajas",0)
	This.SetTabOrder("venliped_cantidad",0)	
else
	This.SetTabOrder("venliped_pallets",1)	
	This.SetTabOrder("venliped_cajas",2)
	This.SetTabOrder("venliped_cantidad",3)	
End if	




COMMIT;
end event

event doubleclicked;IF row = 0 Then Return
f_control_marcar_linea(row)
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




end event

event key;call super::key;//Int row
//row = GetRow()
//if key = KeyTab! Then
//	 string     cadena,var_articulo,var_tipo_pallet,var_caja,control_pico
//	 Dec{0}     var_pallets,var_cajas,var_total_cajas,var_pallets_ant
//	 Dec{2}     var_cantidad
//	 AccepTtext()
//	 var_pallets     =  GetItemNumber(row,"venliped_pallets")
//	 var_cajas       =  GetItemNumber(row,"venliped_cajas")
//	 var_cantidad    =  GetItemNumber(row,"venliped_cantidad")
//	 var_articulo    =  GetItemString(row,"venliped_articulo")
//	 var_tipo_pallet =  GetItemString(row,"venliped_tipo_pallet")
//	 var_caja        =  GetItemString(row,"venliped_caja")
//	 control_pico    =  GetItemString(row,"venliped_es_pico")
//	
// 	 if control_pico = "S" then 
//		 var_pallets_ant = var_pallets
//		 var_pallets = 0
//	 End if
//
//	 IF GetColumnName() = "venliped_cantidad" Then 
//		var_pallets = 0
//		var_cajas   = 0
//	 END IF
//	 
//	 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
//										 var_tipo_pallet,var_caja,&
//										 var_pallets,&
//										 var_cajas,&
//										 var_cantidad)
//								  
//	 var_pallets       = Dec(Trim(Mid(cadena,1,6)))
//	 var_cajas         = Dec(Trim(Mid(cadena,7,6)))
//	 var_total_cajas   = Dec(Trim(Mid(cadena,13,6)))
//	 var_cantidad      = Dec(Trim(Mid(cadena,19,9)))
//
//	 if control_pico = "S" then var_pallets = var_pallets_ant
//	 
//	 SetItem(row,"venliped_pallets",var_pallets)
//	 SetItem(row,"venliped_cajas",var_cajas)
//	 SetItem(row,"venliped_total_cajas",var_total_cajas)
//	 SetItem(row,"venliped_cantidad",var_cantidad)
//END IF
end event

event rbuttondown;call super::rbuttondown;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"venliped_anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"venliped_pedido"))
  OpenSheetWithParm(w_int_venped,lstr_param,Parent,3,Original!) 
	IF ISVALID(w_int_venped) then
		w_int_venped.cb_lineas.triggerevent(clicked!)
	end if
End If
end event

event itemchanged;call super::itemchanged;string     cadena,var_articulo,var_tipo_pallet,var_caja,control_pico,ls_dividir_picos
Dec{0}     var_pallets,var_cajas,var_total_cajas,var_pallets_ant
Dec{2}     var_cantidad
boolean    lb_recalcular_cantidad = false
choose case dwo.name
	case "venliped_pallets"
		var_pallets     =  dec(data)
		var_cajas       =  GetItemNumber(row,"venliped_cajas")
		var_cantidad    =  GetItemNumber(row,"venliped_cantidad")
		lb_recalcular_cantidad = true
	case "venliped_cajas"
		var_pallets     =  GetItemNumber(row,"venliped_pallets")
		var_cajas       =  dec(data)
		var_cantidad    =  GetItemNumber(row,"venliped_cantidad")
		lb_recalcular_cantidad = true
	case "venliped_cantidad"
		var_pallets     =  0
		var_cajas       =  0
		var_cantidad    =  dec(data)	
		lb_recalcular_cantidad = true
end choose

if lb_recalcular_cantidad then
	select dividir_picos 
	into  :ls_dividir_picos
	from  paramemp
	where empresa = :codigo_empresa;
	
	if isnull(ls_dividir_picos) or ls_dividir_picos="" then ls_dividir_picos='S'
	
	var_articulo    =  GetItemString(row,"venliped_articulo")
	var_tipo_pallet =  GetItemString(row,"venliped_tipo_pallet")
	var_caja        =  GetItemString(row,"venliped_caja")
	control_pico    =  GetItemString(row,"venliped_es_pico")
	
	if control_pico = "S" and ls_dividir_picos = 'S' then 
		var_pallets_ant = var_pallets
		var_pallets = 0
	End if
	
	cadena = f_calculo_unidades(codigo_empresa,var_articulo,&
									 var_tipo_pallet,var_caja,&
									 var_pallets,&
									 var_cajas,&
									 var_cantidad)
							  
	var_pallets       = Dec(Trim(Mid(cadena,1,6)))
	var_cajas         = Dec(Trim(Mid(cadena,7,6)))
	var_total_cajas   = Dec(Trim(Mid(cadena,13,6)))
	var_cantidad      = Dec(Trim(Mid(cadena,19,9)))
	
	if control_pico = "S" and ls_dividir_picos = 'S' then var_pallets = var_pallets_ant
	 
	SetItem(row,"venliped_pallets",var_pallets)
	SetItem(row,"venliped_cajas",var_cajas)
	SetItem(row,"venliped_total_cajas",var_total_cajas)
	SetItem(row,"venliped_cantidad",var_cantidad)
end if
end event

type cbx_muestras from checkbox within w_expedir_pedidos_cmr
integer x = 3049
integer y = 124
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Muestras"
end type

event clicked;if cbx_muestras.checked then
	es_cliente.visible = true
else
	es_cliente.text	 = "Cliente"
	es_cliente.visible = FALSE	
end if
em_cliente.triggerevent("modificado")
end event

type es_cliente from dropdownlistbox within w_expedir_pedidos_cmr
boolean visible = false
integer y = 120
integer width = 379
integer height = 228
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Cliente","Contacto"}
borderstyle borderstyle = stylelowered!
end type

type dw_consulta_muestras from u_datawindow_consultas within w_expedir_pedidos_cmr
integer y = 1208
integer width = 471
integer height = 460
integer taborder = 0
string dataobject = "dw_pedidos_promocion_para_expedicion"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;//IF This.GetRow() = 0 Then Return
//	Dec anyo,pedido
//anyo    = This.GetItemNumber(currentrow,"anyo")
//pedido  = This.GetItemNumber(currentrow,"pedido")
//dw_detalle.Retrieve(codigo_empresa,anyo,pedido)
//
end event

event retrieveend;//Dec anyo,pedido
//IF RowCOunt() = 0 Then Return
//anyo    = This.GetItemNumber(1,"anyo")
//pedido  = This.GetItemNumber(1,"pedido")
//IF This.RowCOUNT() <> 0 Then
//	dw_detalle.Retrieve(codigo_empresa,anyo,pedido)
//	SetRow(1)
//END IF
end event

type dw_consulta from u_datawindow_consultas within w_expedir_pedidos_cmr
integer y = 224
integer width = 471
integer height = 988
integer taborder = 30
string dataobject = "dw_expedir_pedidos_cmr"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;call super::retrieveend;Dec anyo,pedido
IF RowCOunt() = 0 Then Return
anyo    = This.GetItemNumber(1,"anyo")
pedido  = This.GetItemNumber(1,"pedido")
IF This.RowCOUNT() <> 0 Then
	dw_detalle.Retrieve(codigo_empresa,anyo,pedido)
	SetRow(1)
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF This.GetRow() = 0 Then Return
	Dec anyo,pedido
anyo    = This.GetItemNumber(currentrow,"anyo")
pedido  = This.GetItemNumber(currentrow,"pedido")
dw_detalle.Retrieve(codigo_empresa,anyo,pedido)

end event

type dw_listado_cmr from datawindow within w_expedir_pedidos_cmr
boolean visible = false
integer x = 3259
integer y = 4
integer width = 128
integer height = 112
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_list_cmr"
boolean livescroll = true
end type

type cb_2 from u_boton within w_expedir_pedidos_cmr
boolean visible = false
integer x = 2775
integer y = 1668
integer width = 462
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Desmarcar Todo"
end type

event clicked;call super::clicked;Integer reg
For reg = 1 To dw_pedido.rowCount()
	IF dw_pedido.GetItemString(reg,"venliped_situacion") = "F" Then
		dw_pedido.SetItem(reg,"cmarcado","")
		dw_pedido.ScrollToRow(reg)
	END IF
Next
end event

type cb_3 from commandbutton within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1765
integer y = 1668
integer width = 343
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "stock"
end type

event clicked;IF This.enabled = FALSE Then RETURN

str_parametros valores
Long		i
Dec		disponible,tono,calibre
String	referencia

setnull(Message.PowerObjectParm)

i = dw_detalle.getrow()

str_parametros str
str.s_argumentos[1]= parent.title
str.s_argumentos[2]= dw_detalle.GetItemString(i,"venliped_articulo")
str.s_argumentos[3]=	dw_detalle.GetItemString(i,"venliped_calidad")
str.s_argumentos[6]= dw_detalle.GetItemString(i,"venliped_tipo_pallet")
str.s_argumentos[7]= dw_detalle.GetItemString(i,"venliped_cliente")
str.s_argumentos[8]= dw_detalle.GetItemString(dw_detalle.getrow(),"venliped_envio")
str.i_nargumentos = 8

OpenWithParm(w_con_stock_articulos,str)

IF Message.Doubleparm <> -1 THEN
	str = Message.PowerObjectParm
	
	IF str.s_argumentos[5] <> dw_detalle.Object.venliped_tipo_pallet[i] THEN
		Messagebox("ERROR","NO puede cambiar aquí el tipo de palet. Debe ir al pedido !")
		RETURN 0
	END IF
	
	IF str.s_argumentos[2] <> dw_detalle.Object.venliped_calidad[i] THEN
		Messagebox("ERROR","NO puede cambiar aquí la calidad. Debe ir al pedido !")
		RETURN 0
	END IF
	
	tono    = Dec(str.s_argumentos[3])
	calibre = Dec(str.s_argumentos[4])
	
	// Miramos el disponible y ponemos el pedido en situacion normal.
	referencia  = f_componer_ref(dw_detalle.Object.venliped_articulo[i],&
										 dw_detalle.Object.venliped_calidad[i],string(tono),calibre)
	disponible = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,&
						  referencia,dw_detalle.Object.venliped_tipo_pallet[i],dw_detalle.Object.venliped_caja[i])
	IF dw_detalle.Object.venliped_situacion[i] <> 'F' AND tono 		= dw_detalle.Object.venliped_tono[i] &
														  AND calibre 	= dw_detalle.Object.venliped_calibre[i] THEN
		disponible = disponible + dw_detalle.Object.venliped_cantidad[i]
	END IF
	IF disponible < dw_detalle.Object.venliped_cantidad[i] THEN
		Messagebox("ATENCIÓN","Solo hay disponible " + String(disponible,"###,##0") )
		RETURN 0
	END IF
	
	dw_detalle.Object.venliped_tono[i]    	= tono
	dw_detalle.Object.venliped_calibre[i] 	= calibre
	dw_detalle.Object.venliped_referencia[i]= referencia
	dw_detalle.Object.venliped_situacion[i] = 'C'
	IF dw_detalle.Update() = 1 THEN
		COMMIT;
	ELSE
		ROLLBACK;
//		sle_valor.TRiggerEvent("modificado")
		Messagebox("ERROR","No puedo actualizar la situacion del pedido !")
		RETURN 0
	END IF
END IF


end event

type cb_4 from commandbutton within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1417
integer y = 1668
integer width = 343
integer height = 76
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Desdoblar"
end type

event clicked;Long		i
Dec		anyo_ped,ped,linped,cantiped,cantiord,cantires
String	selecci,cadena
DataStore	ds_p
str_venliped	l

dw_detalle.AcceptText()

i = dw_detalle.GetRow()

anyo_ped	= dw_detalle.Object.venliped_anyo[i]
ped		= dw_detalle.Object.venliped_pedido[i]
linped	= dw_detalle.Object.venliped_linea[i]
cantiord	= dw_detalle.Object.venliped_cantidad[i]

SELECT cantidad INTO :cantiped FROM venliped
WHERE venliped.empresa	= :codigo_empresa
AND	venliped.anyo		= :anyo_ped
AND	venliped.pedido	= :ped
AND	venliped.linea		= :linped;
IF SQLCA.SQLCode <> 0 THEN
	Messagebox("ERROR","No puedo leer la linea de pedido. " + SQLCA.SQLerrtext)
	RETURN 0
END IF

//Miramos si la linea ha sido modificada
cantires = Round(cantiped - cantiord,2)

IF cantires < 0 THEN
	Messagebox("ERROR","La cantidad en orden es superior a la del pedido. Debe modificar el pedido !")
	RETURN 0
END IF

IF cantires = 0 THEN
	Messagebox("ERROR","La cantidad NO ha sido modificada. NO se desdobla !")
	RETURN 0
END IF

// Desdoblamos la linea en dos

selecci = "SELECT * FROM venliped " +&
				"WHERE venliped.empresa	= '" + codigo_empresa + "' " +&
				"AND venliped.anyo = " + String(anyo_ped,"####" ) + " " +&
				"AND venliped.pedido = " + String(ped,"####") + " " +&
				"AND venliped.linea	= " + String(linped,"####")
ds_p = f_cargar_cursor(selecci)
IF ds_p.RowCount() = 1 THEN
	// Tenemos la linea tal y como está en pedido
	l = ds_p.Object.Data[1]
	l.cantidad = Round(cantiord,2)

	cadena = f_calculo_unidades(codigo_empresa,l.articulo,l.tipo_pallet,'0',0,0,l.cantidad)
	//Si son metros se puede redondear
	l.pallets       = Dec(Trim(Mid(cadena,1,6)))
	l.cajas         = Dec(Trim(Mid(cadena,7,6)))
	l.total_cajas   = Dec(Trim(Mid(cadena,13,6)))
	l.cantidad      = Dec(Trim(Mid(cadena,19,9)))			

	// Por los redondeos de m2 volvemos a calcular
	cantires = cantiped - l.cantidad
		
	DELETE FROM venliped
	WHERE venliped.empresa	= :codigo_empresa
	AND	venliped.anyo		= :anyo_ped
	AND	venliped.pedido	= :ped
	AND	venliped.linea		= :linped;
	IF SQLCA.SQLCode = 0 THEN
		IF Not f_insertar_venliped(l) THEN
			MessageBox("ERROR","NO puedo borrar la línea de pedido !")
			ROLLBACK;
			Destroy(ds_p)
			
			RETURN 0	
		END IF
		IF Not f_actualizar_linea_venpedido(codigo_empresa,l.anyo,l.pedido,l.linea) THEN
			MessageBox("ERROR","NO puedo actualizar la línea de pedido !")
			ROLLBACK;
			Destroy(ds_p)
			
			RETURN 0
		END IF

		// Actualizamos la orden. Si existe
		UPDATE almlincargas SET cantidad = :l.cantidad, pallets = :l.pallets, cajas = :l.cajas,
								total_cajas = :l.total_cajas, peso_neto = :l.peso_neto
		WHERE almlincargas.empresa		= :codigo_empresa
		AND	almlincargas.anyo_ped	= :anyo_ped
		AND	almlincargas.pedido			= :ped
		AND	almlincargas.linea_ped	= :linped;
		// Creamos la linea con lo que queda
		SELECT Max(linea) INTO :l.linea FROM venliped
		WHERE venliped.empresa	= :codigo_empresa
		AND	venliped.anyo		= :anyo_ped
		AND	venliped.pedido	= :ped;
		l.linea ++
		l.cantidad = cantires
		l.tono = 0				//Amparo, pongo a 0 para que todo lo que sea "A Fabricar" aparezca
		l.calibre = 0			//bien en existencias de almacén. Y añado la referencia... 14/03/06
		IF Trim(l.articulo) <> "" and Not Isnull(l.articulo) Then
			l.referencia      = f_componer_ref(l.articulo,l.calidad,string(l.tono),l.calibre)
		ELSE
			l.referencia      = ""
		END IF
		
//		SetNull(l.tono)  
//		SetNull(l.calibre)
		l.situacion = "F"
		cadena = f_calculo_unidades(codigo_empresa,l.articulo,l.tipo_pallet,'0',0,0,l.cantidad)
				
		//Si son metros se puede redondear
		l.pallets       = Dec(Trim(Mid(cadena,1,6)))
		l.cajas         = Dec(Trim(Mid(cadena,7,6)))
		l.total_cajas   = Dec(Trim(Mid(cadena,13,6)))
		l.cantidad      = Dec(Trim(Mid(cadena,19,9)))
		IF f_insertar_venliped(l) THEN
			IF Not f_actualizar_linea_venpedido(codigo_empresa,l.anyo,l.pedido,l.linea) THEN
				MessageBox("ERROR","NO puedo actualizar la 2ª línea de pedido !")
				ROLLBACK;
			END IF
			f_actualizar_venpedido(codigo_empresa,l.anyo,l.pedido)
			COMMIT;
		ELSE
			ROLLBACK;
		END IF
		Destroy(ds_p)
		
	ELSE
		MessageBox("ERROR","NO puedo actualizar la línea de pedido !")
		ROLLBACK;
		Destroy(ds_p)
		
	END IF
ELSE
	Messagebox("ERROR","Hay más de una linea de pedido !")
END IF
Destroy(ds_p)

em_cliente.triggerevent("modificado")
end event

type st_cmr from statictext within w_expedir_pedidos_cmr
boolean visible = false
integer x = 987
integer y = 1836
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

type em_cmr from u_em_campo within w_expedir_pedidos_cmr
boolean visible = false
integer x = 1239
integer y = 1828
integer width = 247
integer height = 80
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

