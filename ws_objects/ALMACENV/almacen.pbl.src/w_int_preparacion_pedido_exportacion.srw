$PBExportHeader$w_int_preparacion_pedido_exportacion.srw
$PBExportComments$Preparacion de Pedidos
forward
global type w_int_preparacion_pedido_exportacion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_preparacion_pedido_exportacion
end type
type st_pedido from statictext within w_int_preparacion_pedido_exportacion
end type
type em_pedido from u_em_campo within w_int_preparacion_pedido_exportacion
end type
type st_anyo from statictext within w_int_preparacion_pedido_exportacion
end type
type em_anyo from u_em_campo within w_int_preparacion_pedido_exportacion
end type
type st_etiqueta_operario from statictext within w_int_preparacion_pedido_exportacion
end type
type sle_operario from singlelineedit within w_int_preparacion_pedido_exportacion
end type
type sle_operario_nombre from singlelineedit within w_int_preparacion_pedido_exportacion
end type
type cb_salir from u_boton within w_int_preparacion_pedido_exportacion
end type
type gb_2 from groupbox within w_int_preparacion_pedido_exportacion
end type
type uo_almacen from u_em_campo_2 within w_int_preparacion_pedido_exportacion
end type
type cb_preparar from u_boton within w_int_preparacion_pedido_exportacion
end type
type dw_proceso from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_movhis from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_proceso_ubi from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_almlinubicahis from datawindow within w_int_preparacion_pedido_exportacion
end type
type cb_continuar from u_boton within w_int_preparacion_pedido_exportacion
end type
type cb_stock from u_boton within w_int_preparacion_pedido_exportacion
end type
type cb_borrar_pedido from u_boton within w_int_preparacion_pedido_exportacion
end type
type dw_detalle from datawindow within w_int_preparacion_pedido_exportacion
end type
type gb_1 from groupbox within w_int_preparacion_pedido_exportacion
end type
type cb_modificar from u_boton within w_int_preparacion_pedido_exportacion
end type
type st_fecha from statictext within w_int_preparacion_pedido_exportacion
end type
type st_cliente from statictext within w_int_preparacion_pedido_exportacion
end type
type st_1 from statictext within w_int_preparacion_pedido_exportacion
end type
type uo_cliente from u_em_campo_2 within w_int_preparacion_pedido_exportacion
end type
type pb_imprimir from upb_imprimir within w_int_preparacion_pedido_exportacion
end type
type cb_procesar from u_boton within w_int_preparacion_pedido_exportacion
end type
type cb_3 from u_boton within w_int_preparacion_pedido_exportacion
end type
type cb_borrar from u_boton within w_int_preparacion_pedido_exportacion
end type
type cb_insertat from u_boton within w_int_preparacion_pedido_exportacion
end type
type dw_desubi from u_datawindow within w_int_preparacion_pedido_exportacion
end type
type gb_3 from groupbox within w_int_preparacion_pedido_exportacion
end type
type dw_preparacion from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_conubi from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_pedidos from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_des from datawindow within w_int_preparacion_pedido_exportacion
end type
type dw_consulta from u_datawindow within w_int_preparacion_pedido_exportacion
end type
end forward

global type w_int_preparacion_pedido_exportacion from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 3712
integer height = 2188
pb_1 pb_1
st_pedido st_pedido
em_pedido em_pedido
st_anyo st_anyo
em_anyo em_anyo
st_etiqueta_operario st_etiqueta_operario
sle_operario sle_operario
sle_operario_nombre sle_operario_nombre
cb_salir cb_salir
gb_2 gb_2
uo_almacen uo_almacen
cb_preparar cb_preparar
dw_proceso dw_proceso
dw_movhis dw_movhis
dw_proceso_ubi dw_proceso_ubi
dw_almlinubicahis dw_almlinubicahis
cb_continuar cb_continuar
cb_stock cb_stock
cb_borrar_pedido cb_borrar_pedido
dw_detalle dw_detalle
gb_1 gb_1
cb_modificar cb_modificar
st_fecha st_fecha
st_cliente st_cliente
st_1 st_1
uo_cliente uo_cliente
pb_imprimir pb_imprimir
cb_procesar cb_procesar
cb_3 cb_3
cb_borrar cb_borrar
cb_insertat cb_insertat
dw_desubi dw_desubi
gb_3 gb_3
dw_preparacion dw_preparacion
dw_conubi dw_conubi
dw_pedidos dw_pedidos
dw_des dw_des
dw_consulta dw_consulta
end type
global w_int_preparacion_pedido_exportacion w_int_preparacion_pedido_exportacion

type variables
String filtro,var_referencia,var_tipo_unidad,var_situacion
Integer registros,contado,suborden,anyo
String  var_articulo,var_formato,var_calidad,var_tipo_pallet,var_sector,codigo_almacen,codigo_zona,var_es_pico,var_tipo_pallet_entrada,var_conexion,var_tipo_pallet_preparacion,var_caja,var_tono
Dec{0} var_calibre,var_pedido,var_periodo,var_pallets,var_cajas,var_total_cajas,var_orden_preparacion,var_linea_pedido,var_numpalet,var_anyo_proddiaria,var_contador_proddiaria
Dec{0} total_piezas,var_linea,var_unidades,codigo_fila,codigo_altura,codigo_pico,var_numero_pico
Dec{2} var_cantidad,var_metros,var_cantidad_preparada,var_cantidad_prepa
String codigo_operario,procesando,bloqueado,var_operario_prepa,var_familia,var_modelo
Dec{0}  var_fila_ent,var_altura_ent,var_mov_ent,var_mov_sal,ante_numpalet
String v_almacen,v_zona,campo_anterior,ante_situ
Integer v_fila,v_altura,bien
Dec{2} v_cantidad,v_tot,ante_pallets,ante_cajas,ante_cantidad
Dec{0} var_cantidad_original,var_linea_desdoblada_de
String   var_idioma
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo_linea (integer elemento)
public subroutine f_des_activa ()
public subroutine f_procesar ()
public subroutine f_resto ()
public function boolean f_procesar2 ()
public subroutine f_despreparar ()
public function boolean f_grabar_entrada ()
public function boolean f_grabar_salida ()
public subroutine f_cargar ()
public subroutine f_procesar_desubi ()
public subroutine f_cambio_linea (integer row)
public function boolean f_borrar_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea)
public subroutine f_control_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea)
public function boolean f_salir ()
public function boolean f_insertar ()
public function boolean f_grabar_entrada_regularizacion ()
public function boolean f_salir2 ()
public function boolean f_grabar_entrada_regularizacion2 (decimal diferencia)
public function boolean f_grabar_salida_regularizacion (decimal diferencia)
public function boolean f_grabar_entrada_regularizacion3 (decimal diferencia)
public function boolean f_busca_mov (string referencia)
public subroutine f_procesar_desubi2 ()
public subroutine f_desdoblar_nueva (long reg)
public function boolean f_desdoblar_linea (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_cantidad, decimal arg_numpalet, decimal arg_original)
end prototypes

public subroutine f_control ();//----------------------------------------//
// cargo los datos de la pantalla inicial //
//----------------------------------------//
Dec{0}  pedido,periodo
DateTime   fecha
periodo = Dec(em_anyo.text)
pedido  = Dec(em_pedido.text)
IF var_conexion = "N" Then
	if f_pedido_existe_sn(codigo_empresa,periodo,pedido) = "N" Then
		f_mensaje(" A t e n c i ó n ","El pedido no existe")
	   f_activar_campo(em_pedido)
	   Return
	END IF	
//	If f_pedido_impreso_sn(codigo_empresa,periodo,pedido) = "N" Then
//	  f_mensaje(" No se puede preparar el pedido","Este pedido no esta impreso")
//	  f_activar_campo(em_pedido)
//	  Return
//	END IF	
END IF

// Valores Para Funcion de bloqueo
longitud     =  len(trim(codigo_empresa))
criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
longitud     =  len(Trim(em_anyo.text))
criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
longitud     =  len(Trim(em_pedido.text))
criterio[3]  =  trim(em_pedido.text)+space(20-longitud)
seleccion    =  criterio[1]+criterio[2]+criterio[3]
tabla        = "venped"
IF f_bloquear(tabla,seleccion,titulo) THEN
	f_activar_campo(em_pedido)
	Return
ELSE
	bloqueado = "S"
END IF	
COMMIT;

procesando  = "S"
dw_consulta.reset()
SetNull(codigo_operario)
st_cliente.text =f_razon_genter(codigo_empresa,"C",f_cliente_venped(codigo_empresa,periodo,pedido))

fecha = f_fpedido_venped(codigo_empresa,periodo,pedido)

st_fecha.text = String(Date(fecha),"dd-mm-yyyy")
if trim(st_cliente.text)<>"" then st_cliente.text ="("+trim(st_cliente.text)+")"
dw_consulta.visible = FALSE
suborden= 0

f_cargar()

IF var_conexion = "S" Then
	dw_consulta.Setfilter("")
	dw_consulta.filter()
	dw_consulta.Setfilter("linea=" + String(var_linea_pedido))
	dw_consulta.filter()
END IF
IF dw_consulta.RowCount() <> 0 Then
	 gb_1.visible             		= TRUE
	 cb_preparar.visible       	= TRUE	
	 cb_preparar.enabled      	 	= TRUE	
	 cb_borrar_pedido.visible 		= TRUE	
	 cb_stock.visible          	= TRUE	
	 cb_borrar_pedido.enabled  	= TRUE	
	 cb_stock.enabled          	= TRUE	
	 cb_modificar.visible			= TRUE
	 cb_modificar.enabled			= TRUE
	 cb_continuar.enabled 			= FALSE
	 cb_salir.visible          	= TRUE	
	 dw_consulta.enabled       	= TRUE
	 em_pedido.enabled         	= FALSE
	 em_anyo.enabled           	= FALSE
	 uo_cliente.em_campo.enabled 	= FALSE
	 st_1.enabled              	= FALSE
	 dw_consulta.SetFocus()
	 dw_consulta.SetRow(1)
Else 
	 f_desbloquear(tabla,seleccion,titulo)
	 bloqueado = "N"
	 COMMIT;
END IF 
ante_cantidad = 0
procesando  = "N"
dw_consulta.SetSort("")
//dw_consulta.SetSort("empresa,anyo,pedido,orden,suborden")
dw_consulta.SetSort("empresa,nombre_formato,nombre_articulo")
dw_consulta.Sort()
dw_consulta.visible = TRUE

pb_1.cancel = False
cb_salir.cancel = True

end subroutine

public subroutine f_calculo_linea (integer elemento);Dec{2} metros,unidades,cajas,total_cajas,pallets,cantidad,pal,cj,cajas_aux,total_cajas_aux,pallets_aux
Dec{0} num_palet,pedido,linea
String tipo_unidad,articulo,control_pico,tipo_pallet,cadena,caja
Integer ano
Long    posi,posi_aux

dw_consulta.Accepttext()

articulo       = dw_consulta.GetItemString(elemento,"articulo")
if isnull(articulo) or articulo='' then return

tipo_unidad    = f_unidad_articulo(codigo_empresa,articulo)
metros         = dw_consulta.GetItemNumber(elemento,"metros")
unidades       = dw_consulta.GetItemNumber(elemento,"unidades")
cajas          = dw_consulta.GetItemNumber(elemento,"cajas")
total_cajas    = dw_consulta.GetItemNumber(elemento,"total_cajas")
pallets        = dw_consulta.GetItemNumber(elemento,"pallets")
num_palet      = dw_consulta.GetItemNumber(elemento,"npalet")

IF IsNUll(pallets)   Then pallets   = 0
IF IsNUll(cajas)     Then cajas     = 0
IF IsNUll(unidades)  Then unidades  = 0
IF IsNUll(metros)    Then metros    = 0
IF IsNUll(num_palet) Then num_palet = 0

control_pico   = dw_consulta.GetItemString(elemento,"es_pico")
tipo_pallet    = dw_consulta.GetItemString(elemento,"tipo_pallet")
caja           = dw_consulta.GetItemString(elemento,"caja")

IF IsNUll(ante_cantidad) Then ante_cantidad = 0
IF IsNull(cajas)         THEN cajas         = 0
IF IsNull(total_cajas)   THEN total_cajas   = 0
IF IsNull(pallets)       THEN pallets       = 0
IF IsNull(unidades)      THEN unidades      = 0
IF IsNull(metros)        THEN metros        = 0
// 1 -> metros 0 -> Unidades
If tipo_unidad = "1" Then
	cantidad = metros
ELSE
	cantidad = unidades
END IF

IF ante_pallets= pallets and ante_cajas = cajas and cantidad = ante_cantidad and num_palet = ante_numpalet Then Return
IF ante_pallets= pallets and ante_cajas = cajas Then
	pallets = 0
	cajas   = 0
ELSE
	IF control_pico = "S" Then
		IF ante_cajas <> cajas  Then
			//-
			If tipo_unidad = "1" Then
				unidades = 0
				metros   = 0
			END IF
			//-
		END IF
	ELSE
		unidades = 0
		metros   = 0
	END IF
END IF

IF control_pico = "S" Then
	pal = 0
	IF tipo_unidad = "0" Then
		cj = 0
	ELSE
		cj = cajas
	END IF
ELSE
	pal = pallets
	cj = cajas
End If

// Calculo de cantidades
cadena = f_calculo_unidades(codigo_empresa,articulo,tipo_pallet,caja,pal,cj,cantidad)
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	pallets_aux     = dec(Mid(cadena,1,posi - 1))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	cajas_aux       = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	total_cajas_aux  = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

IF control_pico = "S" Then
	pallets      = dw_consulta.GetItemNumber(elemento,"pallets")
	IF tipo_unidad = "0" Then
		cajas = dw_consulta.GetItemNumber(elemento,"cajas")
		total_cajas = dw_consulta.GetItemNumber(elemento,"cajas")
	ELSE
		cajas          = cajas_aux
		total_cajas    = total_cajas_aux
		pallets        = pallets_aux	
	END IF
Else
	cajas          = cajas_aux
	total_cajas    = total_cajas_aux
	pallets        = pallets_aux
End If

If tipo_unidad = "1" Then
	metros = cantidad
	unidades = f_calculo_total_piezas(codigo_empresa,articulo,caja,metros)
ELSE
	metros = 0
	unidades = cantidad
END IF
// Modificación del nº de palet si ha cambiado
IF ante_numpalet <> num_palet then
	pedido = dw_consulta.GetItemNumber(elemento,"pedido")
	linea  = dw_consulta.GetItemNumber(elemento,"linea")
	ano    = dw_consulta.GetItemNumber(elemento,"anyo")
	
	UPDATE venliped  
	SET    numpalet =  :num_palet   
	WHERE  (venliped.empresa     = :codigo_empresa ) AND  
			 (venliped.anyo        = :ano )            AND  
			 (venliped.pedido      = :pedido )         AND  
			 (venliped.linea       = :linea );
			 IF Sqlca.SqlCode <> 0 Then 
				messagebox("Atención","No se ha podido actualizar el Nº de palet")
		    Else
				COMMIT;
			 end if
END IF
dw_consulta.SetItem(elemento,"pallets",pallets)
dw_consulta.SetItem(elemento,"total_cajas",total_cajas)
dw_consulta.SetItem(elemento,"cajas",cajas)
dw_consulta.SetItem(elemento,"metros",metros)
dw_consulta.SetItem(elemento,"npalet",num_palet)

IF control_pico = "S" Then
	IF  ante_cajas <> cajas  Then
		 dw_consulta.SetItem(elemento,"unidades",unidades)
//		 dw_consulta.SetItem(elemento,"metros",metros)
	END IF
ELSE
   dw_consulta.SetItem(elemento,"unidades",unidades)
// dw_consulta.SetItem(elemento,"metros",metros)
END IF


dw_consulta.AcceptText()	

If tipo_unidad = "1" Then
	ante_cantidad = metros
Else
	ante_cantidad = unidades
END IF
ante_pallets = pallets
ante_cajas   = cajas
end subroutine

public subroutine f_des_activa ();cb_preparar.enabled      = FALSE
cb_salir.enabled         = FALSE
cb_stock.enabled         = FALSE
cb_borrar_pedido.enabled = FALSE
dw_consulta.enabled      = FALSE
em_anyo.enabled          = FALSE
em_pedido.enabled        = FALSE
pb_1.enabled             = FALSE
//cb_modificar.enabled     = FALSE
//uo_almacen.enabled       = FALSE
pb_imprimir.enabled = FALSE



end subroutine

public subroutine f_procesar ();Dec{2} cantidad,total_cantidad,total_marcado,total_pedido,cantidad_marcada
Integer elemento
String situacion

	dw_preparacion.AcceptText()
	situacion =  dw_preparacion.GetItemString(dw_preparacion.GetRow(),"situacion")
	IF dw_preparacion.GetRow() = 0 Then Return 
	 cantidad_marcada       =  dw_preparacion.GetItemNumber(dw_preparacion.GetRow(),"cantidad_marcada")
	 If IsNull(cantidad_marcada) Then cantidad_marcada = 0
	 cantidad       =  dw_preparacion.GetItemNumber(dw_preparacion.GetRow(),"cantidad")
	 If IsNull(cantidad) Then cantidad = 0
	 total_marcado  =  dw_preparacion.GetItemNumber(1,"total_marcado")
	 total_pedido   =  dw_preparacion.GetItemNumber(1,"total_pedido")
	 
	 IF Trim(situacion) = "" or IsNull(situacion) Then
		 IF cantidad_marcada = cantidad Then
			situacion = "X" 
		 ELse
			 IF cantidad_marcada > cantidad Then 
				 situacion = "X" 
				 cantidad_marcada= cantidad
				 dw_preparacion.SetItem(dw_preparacion.GetRow(),"cantidad_marcada",cantidad_marcada)
			ELSE
				situacion = "P"
			END IF	 
			
		 ENd  IF
		 If cantidad_marcada = 0 Then situacion = ""
	 Else
		cantidad_marcada = 0
		situacion = ""
		dw_preparacion.SetItem(dw_preparacion.GetRow(),"cantidad_marcada",cantidad_marcada)
		dw_preparacion.SetItem(dw_preparacion.GetRow(),"situacion",situacion)
		
		dw_preparacion.setcolumn("cantidad_marcada")
		
	 END IF	
	 
	 dw_preparacion.SetItem(dw_preparacion.GetRow(),"situacion",situacion)
	 dw_preparacion.TriggerEvent(rowfocuschanged!)
	 f_resto()
	 dw_preparacion.AcceptText()
	 total_marcado  =  dw_preparacion.GetItemNumber(1,"total_marcado")
	 total_pedido   =  dw_preparacion.GetItemNumber(1,"total_pedido")
	 If total_pedido = total_marcado Then 
	 IF Not f_bloquear_almacen(w_int_preparacion_pedido_exportacion.title) Then
		f_mensaje_proceso("Procesando",1,10)
		IF f_procesar2() Then
			COMMIT;
		Else
			ROLLBACK;
			f_mensaje("Error durante el proceso","Proceso finalizado con problemas "+ sqlca.sqlerrtext)
		End If	
		f_desbloquear(tabla,seleccion,titulo)
		COMMIT;
		f_desbloquear_almacen(w_int_preparacion_pedido_exportacion.title)
	 	END IF
		f_mensaje_proceso("Fin proceso",10,10)
		f_salir()
	 END IF	

	 
	
	

end subroutine

public subroutine f_resto (); Dec{2} total_marcado,total_pedido,elemento
 String situacion
 total_marcado =  dw_preparacion.GetItemNumber(1,"total_marcado") 
 total_pedido  =  dw_preparacion.GetItemNumber(1,"total_pedido") 
 For elemento = 1 To dw_preparacion.RowCount()
	situacion = dw_preparacion.GetItemString(elemento,"situacion")
	If Trim(situacion) = "" Then
      dw_preparacion.SetItem(elemento,"cantidad_marcada",total_pedido - total_marcado   )
   END IF 
 Next
 
end subroutine

public function boolean f_procesar2 ();//-----------------------------------------------//
// realiza las sentencias sql preparacion linea -//
//-----------------------------------------------//
Dec{0} pedido,periodo,linea,anyo_prepa,nummov_prepa,control_bien
String es_pico,articulo,tipo_unidad,tipo_pallet,situacion,el_almacen,calidad,referencia,v_tono,tipo_caja
Dec{2} cantidad_marcada,cantidad_prepa,pico_prepa,numero_pico,cantidad_pedido,el_anyo,e_cantidad,e_cajas,e_total_cajas,e_pallets,e_peso,e_peso_neto
Dec{0} v_calibre,e_numpalet,e_anyo_proddiaria,e_contador_proddiaria
str_venliped ped

control_bien =  0
el_anyo      =  Year(today())
el_almacen   =  uo_almacen.em_codigo.text

pedido       = Dec(em_pedido.text)
periodo      = Dec(em_anyo.text)
linea        = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
es_pico      = dw_consulta.GetItemString(dw_consulta.GetRow(),"es_pico")
numero_pico  = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"pico")
v_tono       = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")
v_calibre    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")
articulo     = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
calidad      = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")

if isnull(calidad) or trim(calidad)="0" then calidad = ""

tipo_pallet  = dw_consulta.GetItemString(dw_consulta.GetRow(),"tipo_pallet")
tipo_caja    = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")
tipo_unidad  = f_unidad_articulo(codigo_empresa,articulo)
IF tipo_unidad  = "0" Then
  cantidad_marcada = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
Else
  cantidad_marcada = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
END IF	
e_cantidad     = cantidad_marcada
e_pallets      =dw_consulta.GetItemNumber(dw_consulta.GetRow(),"pallets")
e_cajas        =dw_consulta.GetItemNumber(dw_consulta.GetRow(),"cajas")
e_total_cajas  =dw_consulta.GetItemNumber(dw_consulta.GetRow(),"total_cajas")
e_numpalet     =dw_consulta.GetItemNumber(dw_consulta.GetRow(),"npalet")
e_anyo_proddiaria = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"anyo_proddiaria")
e_contador_proddiaria = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"contador_proddiaria")
IF isnull(e_numpalet) then e_numpalet = 0
IF isnull(e_anyo_proddiaria) then e_anyo_proddiaria = 0
IF isnull(e_contador_proddiaria) then e_contador_proddiaria = 0

if (e_anyo_proddiaria = 0) and (e_contador_proddiaria = 0) then
	SELECT venliped.anyo_proddiaria,venliped.contador_proddiaria  
	INTO  :e_anyo_proddiaria,:e_contador_proddiaria
   FROM  venliped  
   WHERE ( venliped.empresa  = :codigo_empresa ) AND  
         ( venliped.anyo     = :periodo)         AND  
         ( venliped.pedido   = :pedido)          AND
			( venliped.articulo = :articulo);
   
	IF isnull(e_anyo_proddiaria) then e_anyo_proddiaria = 0
	IF isnull(e_contador_proddiaria) then e_contador_proddiaria = 0
end if

  SELECT  venliped.cantidad,venliped.cantidad_prepa,  
          venliped.numero_pico,venliped.fila_ent,
   		 venliped.altura_ent
	INTO  :ped.cantidad,:ped.cantidad_prepa,  
			:ped.numero_pico,:ped.fila_ent,
   		:ped.altura_ent
    FROM venliped  
   WHERE ( venliped.empresa = :codigo_empresa ) AND  
         ( venliped.anyo    = :periodo)         AND  
         ( venliped.pedido  = :pedido)          AND   
         ( venliped.linea   = :linea);
   IF SQLCA.SQLCODE = 100 Then control_bien = 1	
	
	// Entrada
	//----------------------------
	 f_mensaje_proceso("Entrada Alm",6,10)
	IF Not f_grabar_entrada()  Then control_bien =1
	
	// Salida
	//----------------------------
	 f_mensaje_proceso("Salida Alm",8,10)
	IF Not f_grabar_salida()   Then control_bien =1
	
	
	IF IsNull(ped.cantidad_prepa) Then ped.cantidad_prepa = 0
   ped.cantidad_prepa = cantidad_marcada
	ped.situacion = "P"

//--------------------------------//
// Primero se modificará el pedido//
//--------------------------------//
	 ped.numero_pico    = numero_pico
 	 ped.fila_ent       = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"fila")
	 ped.altura_ent     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"altura")
	 ped.operario_prepa = dw_consulta.GetItemString(dw_consulta.GetRow(),"operario")
	 e_peso             = f_calculo_peso(codigo_empresa,articulo,var_tipo_pallet_entrada,e_cajas,e_total_cajas,e_pallets,e_cantidad,tipo_caja)
	 e_peso_neto        = f_calculo_peso_neto(codigo_empresa,articulo,e_cajas,e_total_cajas,e_cantidad,tipo_caja)
 	 IF ISNull(ped.altura_ent) Then  ped.altura_ent=0
    IF IsNull(v_tono)     Then v_tono    = ""
    IF IsNull(v_calibre)  Then v_calibre = 0
	 referencia    =  f_componer_ref(articulo,calidad,v_tono,v_calibre)
	  	 f_mensaje_proceso("Modificar pedido",8,10)
	  UPDATE venliped  
     SET situacion         =  :ped.situacion,   
         cantidad_prepa    =  :ped.cantidad_prepa,   
         numero_pico       =  :ped.numero_pico,
			fila_ent          =  :ped.fila_ent,
			altura_ent        =  :ped.altura_ent,
         operario_prepa    =  :ped.operario_prepa,
			tipo_pallet       =  :var_tipo_pallet_entrada,
			almacen_ent       =  :el_almacen,
			anyo_ent          =  :el_anyo,
			nummov_ent        =  :var_mov_ent,
			anyo_sal          =  :el_anyo,
			nummov_sal        =  :var_mov_sal,
			tonochar          =  :v_tono,
			calibre           =  :v_calibre,
			pallets           =  :e_pallets,
			cajas             =  :e_cajas,
			total_cajas       =  :e_total_cajas,
			cantidad          =  :e_cantidad,
			referencia        =  :referencia,
			cantidad_facturar =  :e_cantidad,
			numpalet          =  :e_numpalet,
			peso              =  :e_peso,
			peso_neto         =  :e_peso_neto,
			anyo_proddiaria   =  :e_anyo_proddiaria,
			contador_proddiaria   =  :e_contador_proddiaria
   WHERE (venliped.empresa     = :codigo_empresa ) AND  
         (venliped.anyo        = :periodo )        AND  
         (venliped.pedido      = :pedido )         AND  
         (venliped.linea       = :linea );
			IF Sqlca.SqlCode <> 0 Then control_bien = 1
			f_control_ordenes(codigo_empresa,periodo,pedido,linea)
			

IF Not f_actualizar_linea_venpedido(codigo_empresa,periodo,pedido,linea) Then control_bien = 1
IF Not f_actualizar_venpedido(codigo_empresa,periodo,pedido)              Then control_bien = 1
IF control_bien = 0 Then
 dw_consulta.SetItem(dw_consulta.GetRow(),"preparado","S")
 Return TRUE
ELSE 
 Return FALSE
END IF	

end function

public subroutine f_despreparar ();String v_articulo,v_calidad,v_tipo_pallet,cod_ubicacion,referencia,v_tipo_unidad,v_tono
Dec{0}  v_calibre,x2

bien  = 0
v_articulo     = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"articulo")
v_calidad      = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"calidad")
v_tono         = Trim(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"tono"))
v_calibre      = Dec(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"calibre"))
var_referencia = f_componer_ref(v_articulo,v_calidad,v_tono,v_calibre)
												  
IF dw_conubi.retrieve(codigo_empresa,var_referencia) = 0 Then												  
//	f_mensaje("No se puede despreparar la linea ", "El material ha sido reubicado")
//	Return
END IF


// Desubicar la linea
dw_desubi.InsertRow(1)
dw_desubi.SetItem(1,"empresa",codigo_empresa)
v_articulo    = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"articulo")
v_tipo_unidad = f_unidad_articulo(codigo_empresa,v_articulo)
IF  v_tipo_unidad = "1" Then
   v_tot = Dec(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"metros"))
Else
   v_tot = Dec(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"unidades"))
END IF

dw_desubi.SetItem(1,"cantidad",v_tot)
dw_desubi.SetItem(1,"empresa",codigo_empresa)
dw_desubi.SetItem(1,"tipo_unidad",v_tipo_unidad)

cb_borrar.visible    = TRUE
cb_procesar.visible  = TRUE
cb_3.visible         = TRUE
cb_insertat.visible  = TRUE
dw_desubi.visible    = TRUE
dw_conubi.visible    = TRUE
dw_consulta.enabled  = FALSE

dw_desubi.SetFocus()
dw_desubi.SetRow(1)
dw_desubi.SetColumn("almacen")

end subroutine

public function boolean f_grabar_entrada ();Integer contador,grabado,salir,x1,control_bien
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis
Dec{0} cur_pedido,cur_linea
Dec{2} cur_existencias
String  cur_empresa,cur_tipo_pallet,cur_ubicacion


control_bien     = 0
movhis.empresa   =  codigo_empresa   
movhis.almacen   =  uo_almacen.em_codigo.text
movhis.anyo      =  Year(Today())
f_mensaje_proceso("Buscando Nº Mov.",8,10)
movhis.nummov    =  f_almparam_nummov(codigo_empresa,movhis.anyo)
f_mensaje_proceso("Nº Mov. Ok",8,10)
movhis.origen    =  "2"   
movhis.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "205"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")       
Else
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")       
End if
movhis.cantidads  = 0
movhis.precio     = 0
movhis.codtercero = f_cliente_venped (codigo_empresa,Integer(em_anyo.text),Dec(em_pedido.text))
movhis.numdoc     = em_pedido.text
movhis.situacion  = "N"   
SeTNull(movhis.observaciones)   
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo

movhis.calidad  = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""

movhis.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
movhis.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
movhis.caja			 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet_entrada
movhis.sector      = var_sector   
f_mensaje_proceso("Insertando Mov.",8,10)
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
f_mensaje_proceso("Insertado Mov.",8,10)
f_mensaje_proceso("Actualiza Mov.",8,10)
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
f_mensaje_proceso("Mov. Act",8,10)


linubica.empresa  = codigo_empresa  
linubica.almacen  = uo_almacen.em_codigo.text  
linubica.zona     = codigo_zona
linubica.fila     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"fila")
linubica.altura   = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"altura")
IF IsNUll(linubica.altura) Then linubica.altura= 0
linubica.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
linubica.familia   = var_familia 
linubica.formato   = var_formato
linubica.modelo    = var_modelo

linubica.calidad   = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")
if isnull(linubica.calidad) or trim(linubica.calidad)="0" then linubica.calidad = ""

linubica.tonochar  = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")
linubica.calibre   = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")
linubica.caja		 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
linubica.anyo      = Integer(em_anyo.text) 
linubica.pedido    = Dec(em_pedido.text)
linubica.linped    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
linubica.cliente   = f_cliente_venped(linubica.empresa,linubica.anyo,linubica.pedido)   
linubica.ubicacion  =f_componer_ubicacion (linubica.almacen,linubica.zona,linubica.fila,linubica.altura)  
linubica.tipo_unidad= var_tipo_unidad   
linubica.referencia    = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
linubica.f_alta= Datetime(Today(),Now())   
IF var_tipo_unidad = "0" Then
	linubica.existencias = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
Else
	linubica.existencias  = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
End If				

linubica.observaciones = f_observaciones_zona_fila_altura_ref(linubica.empresa,linubica.referencia,linubica.ubicacion)
linubica.tipo_pallet   =var_tipo_pallet_entrada
linubica.sector = var_sector
		

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

//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden (movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = linubica.zona
linubicahis.fila        = linubica.fila
linubicahis.altura      = linubica.altura
linubicahis.ubicacion   = linubica.ubicacion
linubicahis.cantidads   = movhis.cantidads
linubicahis.cantidade   = movhis.cantidade
linubicahis.articulo    = linubica.articulo
linubicahis.familia     = linubica.familia
linubicahis.formato     = linubica.formato
linubicahis.modelo      = linubica.modelo
linubicahis.calidad     = linubica.calidad
linubicahis.tonochar    = linubica.tonochar
linubicahis.calibre     = linubica.calibre
linubicahis.caja			= linubica.caja
linubicahis.fecha       = DateTime(Today())
linubicahis.tipomov     = "205"
linubicahis.tipo_unidad = movhis.tipo_unidad
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
SetNull(linubicahis.observaciones)
linubicahis.tipo_pallet = var_tipo_pallet_entrada
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF


end function

public function boolean f_grabar_salida ();Integer control_bien,contador,registro
str_almmovhis        movhis
str_almlinubica      linubica
str_almlinubicahis   linubicahis
String cur_referencia
Dec{2} cur_existencias,cantidad_marcada
control_bien = 0

         movhis.empresa      =  codigo_empresa   
         movhis.almacen      =  uo_almacen.em_codigo.text
         movhis.anyo         =  Year(Today())
         movhis.nummov       =  f_almparam_nummov(codigo_empresa,movhis.anyo)
		   linubicahis.orden   =  f_almparam_numorden (movhis.empresa,movhis.anyo)
         movhis.origen       =  "2"   
         movhis.articulo     = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
         movhis.fechmov      = DateTime(Today())   
         movhis.tipomov      = "204"   
  		   movhis.cantidade    = 0
			movhis.precio       = 0
         movhis.codtercero   = f_cliente_venped (codigo_empresa,Integer(em_anyo.text),Dec(em_pedido.text))
         movhis.numdoc       = em_pedido.text
         movhis.situacion    = "N"   
         SeTNull(movhis.observaciones)   
         SetNull(movhis.punteado)
         movhis.antexist    = 0   
			movhis.familia     = var_familia 
         movhis.formato     = var_formato 
         movhis.modelo      = var_modelo
         
			movhis.calidad     = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
			if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""
			
         movhis.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
         movhis.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
			movhis.caja			 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   
         movhis.tipo_unidad = var_tipo_unidad   
         movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
         movhis.f_alta      = DateTime(Today(),Now())   
         movhis.usuario     = nombre_usuario   
         movhis.tipo_pallet = dw_consulta.GetItemString(dw_consulta.GetRow(),"tipo_pallet")   
         movhis.sector      = var_sector   
       
 
		
		
		
   //---------------//
  // Des_ubicacion //
 //---------------//
 
    linubica.empresa   = codigo_empresa
    linubica.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
    linubica.familia   = var_familia
    linubica.formato   = var_formato
    linubica.modelo    = var_modelo
    
	 linubica.calidad   = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")
	 if isnull(linubica.calidad) or trim(linubica.calidad)="0" then linubica.calidad = ""
	 
    linubica.tonochar  = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")
    linubica.calibre   = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")
	 linubica.caja		  = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")
    linubica.anyo      = Integer(em_anyo.text)
    linubica.pedido    = Dec(em_anyo.text)
    linubica.linped    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
    linubica.cliente   = f_cliente_venped(codigo_empresa,linubica.anyo,linubica.pedido)
    linubica.referencia  = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
    
    

 
contador = dw_preparacion.RowCount()
IF contador = 0 Then control_bien = 1
For registro = 1 To contador
  linubica.almacen     = dw_preparacion.GetItemString(registro,"almacen")  
  linubica.zona        = dw_preparacion.GetItemString(registro,"zona")
  linubica.fila        = dw_preparacion.GetItemNumber(registro,"fila")
  linubica.altura      = dw_preparacion.GetItemNumber(registro,"altura")
  linubica.linea       = dw_preparacion.GetItemNumber(registro,"linea")
  linubica.ubicacion   = dw_preparacion.GetItemString(registro,"ubicacion")  
  cantidad_marcada     = dw_preparacion.GetItemNumber(registro,"cantidad_marcada")
  movhis.cantidads = cantidad_marcada
  movhis.almacen   = linubica.almacen
  SELECT almlinubica.referencia,almlinubica.existencias  
  INTO   :cur_referencia,:cur_existencias  
  FROM   almlinubica  
  WHERE almlinubica.empresa    = :linubica.empresa
  AND   almlinubica.ubicacion  = :linubica.ubicacion
  AND   almlinubica.linea      = :linubica.linea;
  IF Sqlca.SqlCode <> 0 Then control_bien = 1
  IF cantidad_marcada <> 0 Then
  IF linubica.referencia <> cur_referencia Then control_bien = 1
  cur_existencias = cur_existencias - cantidad_marcada
  IF cur_existencias < 0 Then control_bien = 1
  IF cur_existencias = 0 Then
	DELETE FROM almlinubica  
   WHERE almlinubica.empresa   = :linubica.empresa
	AND   almlinubica.ubicacion = :linubica.ubicacion
	AND   almlinubica.linea     = :linubica.linea;
	IF Sqlca.SqlCode <> 0 Then control_bien = 1
  Else
  UPDATE almlinubica  
   SET existencias    = :cur_existencias  
   WHERE almlinubica.empresa    =  :linubica.empresa
	AND   almlinubica.ubicacion  =  :linubica.ubicacion
	AND   almlinubica.linea      =  :linubica.linea;
   IF Sqlca.SqlCode <> 0 Then control_bien = 1			
  END IF	
  
  
  
//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
         linubicahis.empresa     = movhis.empresa
         linubicahis.anyo        = movhis.anyo
         linubicahis.almacen     = linubica.almacen
         linubicahis.nummov      = movhis.nummov
         linubicahis.zona        = linubica.zona
         linubicahis.fila        = linubica.fila
         linubicahis.altura      = linubica.altura
         linubicahis.ubicacion   = linubica.ubicacion
         linubicahis.cantidads   = cantidad_marcada
         linubicahis.cantidade   = 0
         linubicahis.articulo    = linubica.articulo
         linubicahis.familia     = linubica.familia
         linubicahis.formato     = linubica.formato
         linubicahis.modelo      = linubica.modelo
         linubicahis.calidad     = linubica.calidad
         linubicahis.tonochar    = linubica.tonochar
         linubicahis.calibre     = linubica.calibre
			linubicahis.caja			= linubica.caja
         linubicahis.fecha       = DateTime(Today())
         linubicahis.tipomov     = "204"
         linubicahis.tipo_unidad = movhis.tipo_unidad
         linubicahis.tipo_pallet = movhis.tipo_pallet
         linubicahis.referencia  = movhis.referencia
         linubicahis.f_alta      = movhis.f_alta
         linubicahis.usuario     = movhis.usuario
         SetNull(linubicahis.observaciones)
         linubicahis.sector      = var_sector
		  IF Not f_insert_almmovhis(movhis) Then control_bien = 1
			IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
			linubicahis.orden = linubicahis.orden +1
			movhis.nummov = movhis.nummov +1
		END IF
Next	
IF Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
var_mov_sal=movhis.nummov 
If control_bien = 0 Then
	Return True
Else
	Return False
End If




	
	


end function

public subroutine f_cargar ();Dec{0}  pedido,periodo


dw_consulta.Reset()

periodo    = Dec(em_anyo.text)
pedido     = Dec(em_pedido.text)

registros  = dw_proceso.Retrieve(codigo_empresa,periodo,pedido)

For contado = 1 To registros
	 total_piezas =0
	 var_articulo      = dw_proceso.GetItemString(contado,"articulo") 
	 var_linea         = dw_proceso.GetItemNumber(contado,"linea")
	 var_sector        = dw_proceso.GetItemString(contado,"sector")
	 var_calidad       = dw_proceso.GetItemString(contado,"calidad")
	 var_formato       = dw_proceso.GetItemString(contado,"formato")
	 var_referencia    = dw_proceso.GetItemString(contado,"referencia")
	 var_tipo_pallet   = dw_proceso.GetItemString(contado,"tipo_pallet")
	 var_caja          = dw_proceso.GetItemString(contado,"caja")
	 var_tipo_pallet_preparacion = dw_proceso.GetItemString(contado,"tipo_pallet_preparacion")
	 var_tono                 = dw_proceso.GetItemString(contado,"tonochar")
	 var_calibre              = dw_proceso.GetItemNumber(contado,"calibre")
	 var_situacion            = dw_proceso.GetItemString(contado,"situacion")
	 var_tipo_unidad          = dw_proceso.GetItemString(contado,"tipo_unidad")
	 var_periodo              = dw_proceso.GetItemNumber(contado,"anyo")
	 var_pedido               = dw_proceso.GetItemNumber(contado,"pedido")
	 var_orden_preparacion    = dw_proceso.GetItemNumber(contado,"orden_preparacion")
	 var_es_pico              = dw_proceso.GetItemString(contado,"es_pico")
	 var_numero_pico          = dw_proceso.GetItemNumber(contado,"numero_pico")
	 var_cantidad_prepa       = dw_proceso.GetItemNumber(contado,"cantidad_prepa")
	 var_fila_ent             = dw_proceso.GetItemNumber(contado,"fila_ent")
	 var_altura_ent           = dw_proceso.GetItemNumber(contado,"altura_ent")
	 var_operario_prepa       = dw_proceso.GetItemString(contado,"operario_prepa")
	 var_numpalet             = dw_proceso.GetItemNumber(contado,"numpalet")
	 var_anyo_proddiaria      = dw_proceso.GetItemNumber(contado,"anyo_proddiaria")
	 var_contador_proddiaria  = dw_proceso.GetItemNumber(contado,"contador_proddiaria")
	 var_cantidad_original    = dw_proceso.GetItemNumber(contado,"cantidad_original")
	 var_linea_desdoblada_de  = dw_proceso.GetItemNumber(contado,"linea_desdoblada_de")
	 var_idioma               = dw_proceso.GetItemString(contado,"idioma")
	 
	 IF Trim(var_articulo) <> "" THEN
		 If IsNull(var_pallets) Then var_pallets = 0
		 var_pallets     = dw_proceso.GetItemNumber(contado,"pallets")
		 var_total_cajas = dw_proceso.GetItemNumber(contado,"total_cajas")
		 var_cajas       = dw_proceso.GetItemNumber(contado,"cajas")
		 var_cantidad  =   dw_proceso.GetItemNumber(contado,"cantidad")
		 IF var_tipo_unidad = "1"  Then
			var_metros      = var_cantidad
			var_unidades    = var_total_cajas * f_piezascaja_articulo(codigo_empresa,var_articulo,var_caja)
		 ELSE
			var_metros   = 0
			var_unidades = var_cantidad
		 END IF
		 IF var_sector = "S" Then
			 IF var_situacion = "F" Then
				 var_orden_preparacion = 3
			 ELSE
				 IF var_tipo_unidad = "1" Then
					 var_orden_preparacion = 1
				 ELSE
					 var_orden_preparacion = 2
				 END IF
			 END IF
		  ELSE
			var_orden_preparacion = 4
		 END IF
		 suborden = suborden + 1
		 total_piezas =  total_piezas + var_unidades 
		 IF Not f_insertar() Then f_mensaje("","Error")
	 END IF
NEXT

If dw_consulta.rowcount()<> 0 Then
	IF f_unidad_articulo(codigo_empresa,dw_consulta.GetItemString(1,"articulo")) = "1" Then
		ante_cantidad = dw_consulta.GetItemNumber(1,"metros")
	ELSE
		ante_cantidad   = dw_consulta.GetItemNumber(1,"unidades")
	END IF
	ante_cajas          = dw_consulta.GetItemNumber(1,"cajas")
	ante_pallets        = dw_consulta.GetItemNumber(1,"pallets")
	ante_numpalet       = dw_consulta.GetItemNumber(1,"npalet")
	IF IsNUll(ante_pallets)    Then ante_pallets  = 0
	IF IsNUll(ante_cajas)      Then ante_cajas    = 0
	IF IsNUll(ante_cantidad)   Then ante_cantidad = 0
	IF IsNUll(ante_numpalet)   Then ante_numpalet = 0
	f_cambio_linea(1)
	dw_consulta.SetRow(1)
	
END IF
end subroutine

public subroutine f_procesar_desubi ();str_almlinubicahis ubihis
str_almlinubica ubi
str_almmovhis mov
str_venliped ped

Datastore desu

String sel,aux_zona
String v_calidad,v_tipo_pallet,v_caja,cod_ubicacion,referencia,var_pallet_entrada
Dec{0} x1,y2
Dec{0} periodo,pedido,linea,anyoent,nummovent  
Dec{2} cantidad_preparada,total_cantidad,mod_cantidad
String es_pico,v_tipo_unidad,almacenent
String antealmacen,v_articulo
Dec    y1,longitudes,w_cont,v_calibre
Date   fecha
Dec    numero,controles,x2
string mensaje,nombre,campo,v_tono
Integer aux_fila,aux_altura

var_pallet_entrada  = dw_desubi.GetItemString(1,"tipo_pallet")	
periodo  = Dec(em_anyo.text)
pedido   = Dec(em_pedido.text)
linea    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")

 SELECT  venliped.cantidad_prepa, venliped.numero_pico, 
         venliped.anyo_ent,       venliped.nummov_ent,
			venliped.anyo_sal,       venliped.nummov_sal,            
         venliped.fila_ent,       venliped.altura_ent,
         venliped.es_pico,        venliped.pallets,
         venliped.numero_pico
  INTO   :ped.cantidad_prepa,    :ped.numero_pico,               
         :ped.anyo_ent,          :ped.nummov_ent,
			:ped.anyo_sal, 			:ped.nummov_sal,         
         :ped.fila_ent,          :ped.altura_ent,
         :ped.es_pico,           :ped.pallets,
         :ped.numero_pico
   FROM   venliped  
   WHERE (venliped.empresa = :codigo_empresa) 
	AND   (venliped.anyo    = :periodo)
	AND   (venliped.pedido  = :pedido)
   AND   (venliped.linea   = :linea);
	If Sqlca.SqlCode = 100 then 
		f_mensaje("Error en proceso","La linea: "+ String(linea) + " Del pedido: " + String(pedido) + "No existe")
		bien = 1
	END IF
	
v_articulo     = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"articulo")
v_calidad      = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"calidad")
v_tipo_pallet  = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"tipo_pallet")
v_caja         = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"caja")
v_tono         = Trim(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"tono"))
v_calibre      = Dec(f_valor_columna(dw_consulta,dw_consulta.GetRow(),"calibre"))
controles      = 0
if isnull(v_calidad) or trim(v_calidad)="0" then v_calidad = ""

w_cont = dw_desubi.Rowcount()
dw_desubi.Accepttext()
FOR x2=1 TO w_cont
 v_almacen     = dw_desubi.GetItemString(x2,"almacen")	
 v_zona        = dw_desubi.GetItemString(x2,"zona")	
 v_tipo_pallet = dw_desubi.GetItemString(x2,"tipo_pallet")	
// v_caja        = dw_desubi.GetItemString(x2,"caja")	
 v_fila        = dw_desubi.GetItemNumber(x2,"fila")	
 v_altura      = dw_desubi.GetItemNumber(x2,"altura")	
 v_cantidad    = dw_desubi.GetItemDecimal(x2,"cantidad")	
 IF IsNull(v_fila)   Then v_fila = 0
 IF IsNull(v_altura) Then v_altura = 0
 // Redondeo la cantidad 
// dw_desubi.SetItem(x2,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,v_articulo,var_caja,v_cantidad))
// v_cantidad   = dw_desubi.GetItemDecimal(x2,"cantidad")	

IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
 controles=1
 campo="almacen"
 mensaje=" Introduzca el almacen "
END IF

If x2 > 1 Then
 IF antealmacen<> v_almacen THEN
  campo="almacen"
  controles=1
  mensaje=" Todos los Movimientos Deben de ubicarse en un mismo almacen "
 END IF
END IF

IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
 controles=1
 campo="zona"
 mensaje=" Introduzca la zona "
END IF

IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
 controles=1
 campo="fila"
 mensaje= "Introduzca la fila de la ubicacion"
END IF

IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
 controles=1
 campo="altura"
 mensaje= "Introduzca la altura de la ubicacion"
END IF

IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
 controles=1
 campo="cantidad"
 mensaje= "Introduzca la cantidad"
END IF

if f_sector_articulo(codigo_empresa,v_articulo)="S" THEN
		IF (trim(v_tipo_pallet)="" or IsNull(v_tipo_pallet)) and controles=0 THEN
				 controles=1
				 campo="tipo_pallet"
				 mensaje=" Introduzca el tipo de pallet "
			else
				// Controlamos si el pallet pertenece al articulo
				
				if f_pallet_palarticulo(codigo_empresa,v_articulo,v_tipo_pallet,v_caja)= False then
				    controles = 1 
					 campo="tipo_pallet"
				    mensaje=" El tipo de pallet no corresponde al artículo"
			   End if	
		END IF
	else
      setnull(v_tipo_pallet)
End if

nombre=f_nombre_almacen(codigo_empresa,v_almacen)
IF (trim(nombre)="") and controles=0 THEN
  mensaje="El almacen no existe "
  controles=1
  campo="almacen"
END IF

nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
IF (trim(nombre)="") and controles=0 THEN
   mensaje="La zona no existe"
   controles=1
   campo="zona"
END IF

 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

IF controles=1 THEN
  MessageBox("Campo obligatorio en linea"+string(x2),mensaje,Exclamation!, OK!,1)
  dw_desubi.SetColumn(campo)
  dw_desubi.setRow(x2)
  dw_desubi.setfocus()
 Return
END IF
antealmacen = v_almacen
NEXT

total_cantidad   = dw_desubi.GetItemNumber(1,"total_cantidad")
IF total_cantidad<>v_tot THEN
  MessageBox("No Puedo Procesar","El total de unidades/metros no coinciden",Exclamation!, OK!,1)
  Return
END IF

pb_1.enabled=FALSE

//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------
// w_cont de movimiento y orden de lineas de  ubicacion
   Dec w_cont_nummov,w_cont_orden 

// Valor de controles funcionamiento
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubihis.usuario       = nombre_usuario
 mov.usuario          = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Today())
 ubihis.almacen       = v_almacen
 ubihis.articulo      = v_articulo
 ubihis.calidad       = v_calidad
 ubihis.tonochar      = v_tono
 ubihis.calibre       = v_calibre
 IF IsNull(ubihis.altura) Then ubihis.altura = 0
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = DateTime(Today(),now())
 ubihis.observaciones = ""
 ubihis.tipomov       = "207"
 ubihis.tipo_pallet   = var_pallet_entrada
 ubihis.caja = var_caja



  SELECT articulos.empresa,articulos.codigo,articulos.familia,   
         articulos.formato,articulos.modelo,articulos.unidad,
         articulos.sector
    INTO :ubihis.empresa,:ubihis.articulo,:ubihis.familia,:ubihis.formato,   
         :ubihis.modelo,:ubihis.tipo_unidad  ,:ubihis.sector
    FROM articulos  
   WHERE (articulos.empresa= :ubihis.empresa ) AND  
         (articulos.codigo = :ubihis.articulo )   ;

IF SQLCA.SQLCode<>0 THEN bien=1
 ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                      ubihis.calidad,&
                                      ubihis.tonochar,ubihis.calibre)

ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.formato    =  ubihis.formato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
ubi.tipo_pallet=  ubihis.tipo_pallet
ubi.caja       =  ubihis.caja
ubi.sector     =  ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad=  ubihis.tipo_unidad
ubi.referencia =  ubihis.referencia
ubi.f_alta     =  Datetime(today(),now())
// Valor movimiento historico
mov.empresa    =  ubihis.empresa
mov.almacen    =  ubihis.almacen
mov.articulo   =  ubihis.articulo
mov.familia    =  ubihis.familia
mov.formato    =  ubihis.formato
mov.modelo     =  ubihis.modelo
mov.calidad    =  ubihis.calidad
mov.tonochar   =  ubihis.tonochar
mov.calibre    =  ubihis.calibre
mov.tipo_unidad=  ubihis.tipo_unidad
mov.tipo_pallet=  ubihis.tipo_pallet
mov.caja       =  ubihis.caja
mov.sector     =  ubihis.sector
mov.referencia =  ubihis.referencia
mov.f_alta     =  DateTime(Today(),now())
fecha          =  Today()
mov.anyo       =  year(fecha)
mov.origen     = "1"
mov.fechmov    = ubihis.fecha
mov.tipomov    = ubihis.tipomov
mov.cantidade  = v_tot
mov.cantidads  =0
mov.precio     =0
SetNull(mov.codtercero)
mov.numdoc        = em_pedido.text
mov.situacion     = "N"
mov.observaciones = ""
SetNull(mov.punteado)
mov.antexist   =0


 // Variable utilizada para montaje observaciones en lineas de ubicacion
  String var_observaciones
//-------------------------------------------------------------------
  w_cont_nummov  = f_almparam_nummov(codigo_empresa,Year(fecha))
  w_cont_orden   = f_almparam_numorden(codigo_empresa,Year(fecha))
  mov.nummov     = w_cont_nummov
  ubihis.nummov  = w_cont_nummov
  ubihis.orden   = w_cont_orden
  w_cont = dw_desubi.Rowcount()

  FOR x2=1 TO w_cont
     ubihis.zona       = dw_desubi.GetItemString(x2,"zona")	
     ubihis.fila       = dw_desubi.GetItemNumber(x2,"fila")	
     ubihis.altura     = dw_desubi.GetItemNumber(x2,"altura")	
	  IF IsNull(ubihis.altura) Then ubihis.altura = 0
     ubihis.cantidade  = dw_desubi.GetItemDecimal(x2,"cantidad")	
     ubihis.orden      = w_cont_orden
     ubihis.nummov     = w_cont_nummov
     ubihis.observaciones  = mov.observaciones
     ubihis.f_alta     = DateTime(Today(),now())
     ubihis.usuario    = nombre_usuario
     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,ubihis.fila,ubihis.altura)
     ubihis.cantidads    = 0
     ubi.zona            = ubihis.zona
     ubi.fila            = ubihis.fila
     ubi.altura          = ubihis.altura
     ubi.existencias     = ubihis.cantidade
     ubi.ubicacion       = ubihis.ubicacion
     //------------------------------------------------------------------
     // Inserto en el historico de lineas de ubicacion por movimiento
     //------------------------------------------------------------------
     ubihis.observaciones =  ""
     IF Not f_insert_almlinubicahis(ubihis) Then  bien=1
    
//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
      String cur_empresa,cur_almacen
      Dec cur_pedido,cur_linea,cur_anyo
      decimal{4}  cur_existencias
      string  cur_referencia,cur_ubicacion,cur_observaciones,cur_tipo_pallet
     
//----------------------------------------------------------
// Busco si hay linea este articulo sin reservar
//---------------------------------------------------------
registros=dw_proceso_ubi.Retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubi.tipo_pallet)
Dec grabado,salir
grabado=0
salir  =0
IF registros<>0 THEN
 FOR x1 = 1 To registros
  cur_empresa       =   dw_proceso_ubi.GetItemString(x1,"empresa")
  cur_almacen       =   dw_proceso_ubi.GetItemString(x1,"almacen")
  cur_ubicacion     =   dw_proceso_ubi.GetItemString(x1,"ubicacion")
  cur_referencia    =   dw_proceso_ubi.GetItemString(x1,"referencia")
  cur_pedido        =   dw_proceso_ubi.GetItemNumber(x1,"pedido")
  cur_linea         =   dw_proceso_ubi.GetItemNumber(x1,"linea")
  cur_existencias   =   dw_proceso_ubi.GetItemNumber(x1,"existencias")
  cur_observaciones =   dw_proceso_ubi.GetItemString(x1,"observaciones")
  cur_tipo_pallet   =   dw_proceso_ubi.getItemString(x1,"tipo_pallet")
  IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet=ubihis.tipo_pallet) THEN
     grabado = 1
     ubi.existencias=ubi.existencias + cur_existencias
     mov.observaciones =  mov.observaciones+space(30-len(mov.observaciones)) 
     var_observaciones =  mov.observaciones
       UPDATE almlinubica  
       SET existencias   = :ubi.existencias,   
       f_alta            = :ubi.f_alta,
       observaciones     = :var_observaciones
       WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
             ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
             ( almlinubica.linea     = :cur_linea ) USING SQLCA;
             IF SQLCA.SQLCode<>0 THEN  bien=1
       EXIT
  END IF
NEXT
END IF
IF grabado=0 THEN
    cur_linea=0
    SELECT max(almlinubica.linea)  INTO :cur_linea   FROM  almlinubica  
    WHERE   almlinubica.empresa   = :ubi.empresa
	 AND     almlinubica.ubicacion = :ubi.ubicacion;
    IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
       cur_linea = 0 
    END IF
    cur_linea=cur_linea+1
    ubi.linea=cur_linea
    ubi.observaciones=f_observaciones_zona_fila_altura_ref(ubi.empresa,ubi.referencia,ubi.ubicacion)
    
    IF NOT f_insert_almlinubica(ubi) Then  bien=1
	 
END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------
// el w_cont incrementa uno para cada linea
     w_cont_orden = w_cont_orden + 1
NEXT

 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_almmovhis(mov) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF NOT f_actualiza_nummov(mov.empresa,Year(fecha),mov.nummov) THEN
      bien=1
   END IF
   IF NOT f_actualiza_numorden(ubihis.empresa,Year(fecha),ubihis.orden) THEN
      bien=1
   END IF
	


periodo  = Dec(em_anyo.text)
pedido   = Dec(em_pedido.text)
linea    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
IF bien = 0 Then
 v_almacen     =  almacenent
 ubi.f_alta = DateTime(Today(),now())
   //-------------------------------------------------------------
   // Busco si hay lineas este articulo  reservaDAS
   //-------------------------------------------------------------
Select empresa,almacen,ubicacion,referencia,tipo_pallet,
		 anyo,pedido,linea,linped,existencias
Into   :ubi.empresa,:ubi.almacen,:ubi.ubicacion,:ubi.referencia,:ubi.tipo_pallet,
		 :ubi.anyo,:ubi.pedido,:ubi.linea,:ubi.linped,:ubi.existencias
From  almlinubica
Where empresa =  :codigo_empresa
ANd   anyo    =  :periodo
And   pedido  =  :pedido
ANd   linped  =  :linea;
IF SQLCA.SQLCODE <> 0 Then 
	bien = 1
	f_mensaje("Error f_procesar_desubi", sqlca.sqlerrtext)
END IF
          DELETE FROM almlinubica  
          WHERE (almlinubica.empresa   = :ubi.empresa) AND  
                (almlinubica.ubicacion = :ubi.ubicacion) AND  
                (almlinubica.linea     = :ubi.linea) USING SQLCA;
          IF SQLCA.SQLCode<>0 THEN  bien=1


  //-----------------------------------------------//
  // Grabar movimiento como anulada preparacion//
  //----------------------------------------------//
  mov.nummov = f_almparam_nummov(codigo_empresa,Year(fecha))
  ubihis.orden = f_almparam_numorden(codigo_empresa,Year(fecha))
  ubihis.nummov      = mov.nummov
  ubihis.ubicacion   = ubi.ubicacion
  ubihis.cantidade   =  ubihis.cantidade * (-1)
  mov.cantidade      = mov.cantidade * (-1)
  mov.tipo_pallet    = ubi.tipo_pallet
  ubihis.tipo_pallet = ubi.tipo_pallet
  mov.caja           = ubi.caja
  ubihis.caja        = ubi.caja
  IF NOT f_insert_almmovhis(mov) Then
	
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF Not f_insert_almlinubicahis(ubihis) Then  bien=1
   IF NOT f_actualiza_nummov(mov.empresa,Year(fecha),mov.nummov) THEN
      bien=1
   END IF
   IF NOT f_actualiza_numorden(ubihis.empresa,Year(fecha),ubihis.orden) THEN
      bien=1
   END IF  
  

  
  


//-------------------------------------------------------------------
//-------------  Fin anulacion de la entrada-------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------



es_pico  = dw_consulta.GetItemString(dw_consulta.GetRow(),"es_pico")
IF f_unidad_articulo(codigo_empresa,dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")) = "0" Then
	cantidad_preparada =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
Else
	cantidad_preparada =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
END IF

 
	IF IsNull(ped.cantidad_prepa) then ped.cantidad_prepa= 0
	
   SetNull(ped.numero_pico)
   SetNull(ped.anyo_ent)
   SetNull(ped.nummov_ent)
   SetNull(ped.anyo_sal)
   SetNull(ped.nummov_sal)
   SetNull(ped.fila_ent)
   SetNull(ped.altura_ent)
   SetNull(ped.operario_prepa)
	IF ped.es_pico = "S" Then ped.pallets = 0
     SetNull(ped.numero_pico)


ped.cantidad_prepa = ped.cantidad_prepa - cantidad_preparada
ped.situacion="C"

  UPDATE venliped  
     SET cantidad_prepa  = :ped.cantidad_prepa,   
	      tipo_pallet     = :var_pallet_entrada,
			caja            = :var_caja,
         anyo_ent        = :ped.anyo_ent,   
         nummov_ent      = :ped.nummov_ent,   
         anyo_sal        = :ped.anyo_sal,   
         nummov_sal      = :ped.nummov_sal,   
         fila_ent        = :ped.fila_ent,   
         altura_ent      = :ped.altura_ent,   
         operario_prepa  = :ped.operario_prepa,   
      	situacion       = :ped.situacion,
			pallets         = :ped.pallets,
			numero_pico     = :ped.numero_pico,
			numpalet        = 0,
			tipo_pallet_preparacion = :var_pallet_entrada
			
   WHERE (venliped.empresa   = :codigo_empresa)
	AND   (venliped.anyo      = :periodo)
	AND   (venliped.pedido    = :pedido)
	AND   (venliped.linea     = :linea);
	If Sqlca.SqlCode <> 0 Then 
		f_mensaje("Error en proceso",SQLCA.SQLErrtext)
		bien = 1
	END IF
	f_control_ordenes(codigo_empresa,periodo,pedido,linea)
END IF 	

  CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza "+sqlca.sqlerrtext,Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza "+sqlca.sqlerrtext,Exclamation!, OK!,1)
  END CHOOSE

procesando = "S"
f_cargar()
procesando = "N"
pb_1.enabled=TRUE
cb_3.TriggerEvent(Clicked!)

end subroutine

public subroutine f_cambio_linea (integer row);IF procesando = "S" Then Return
If row = 0          Then Return
Dec{0} v_anyo,v_pedido,v_linea
v_anyo    = dw_consulta.GetItemNumber(row,"anyo")
v_pedido  = dw_consulta.GetItemNumber(row,"pedido")
v_linea   = dw_consulta.GetItemNumber(row,"linea")

String  var_operario,preparado,articulo,familia,tipo_unidad
Dec{0} var_altura,var_fila,var_pico

preparado  = dw_consulta.GetItemString(row,"preparado")
IF preparado = "S" Then
   cb_preparar.text = "F5 Despre."
   dw_consulta.SetTabOrder("operario",10)
   dw_consulta.SetTabOrder("fila",0)
   dw_consulta.SetTabOrder("altura",0)
   dw_consulta.SetTabOrder("pico",0)
	dw_consulta.SetTabOrder("pallets",0)
	dw_consulta.SetTabOrder("cajas",0)
	dw_consulta.SetTabOrder("metros",0)
	dw_consulta.SetTabOrder("unidades",0)
	dw_consulta.SetTabOrder("tono",0)
	dw_consulta.SetTabOrder("calibre",0)
	dw_consulta.SetTabOrder("tipo_pallet",0)
//	dw_consulta.SetTabOrder("tipo_pallet_entrada",0)

ELSE	
	cb_preparar.text = "F5 Preparar"
	dw_consulta.SetTabOrder("operario",10)
	dw_consulta.SetTabOrder("fila",20)
	dw_consulta.SetTabOrder("altura",30)
	dw_consulta.SetTabOrder("pico",40)
	dw_consulta.SetTabOrder("pallets",50)
	dw_consulta.SetTabOrder("cajas",60)
	dw_consulta.SetTabOrder("metros",70)
	dw_consulta.SetTabOrder("unidades",80)
	dw_consulta.SetTabOrder("tono",0)
	dw_consulta.SetTabOrder("calibre",0)
	dw_consulta.SetTabOrder("tipo_pallet",110)
	dw_consulta.SetTabOrder("tipo_pallet_entrada",120)

	dw_consulta.AcceptText()
	
   var_operario =	  dw_consulta.GetItemString(row,"operario")
   var_altura   =	  dw_consulta.GetItemNumber(row,"altura")
	var_fila     =	  dw_consulta.GetItemNumber(row,"fila")
	var_pico     =	  dw_consulta.GetItemNumber(row,"pico")
	IF Trim(String(var_altura))<> "" and Not IsNull(var_altura) Then codigo_altura = var_altura
	IF Trim(String(var_fila))  <> "" and Not IsNull(var_fila)   Then codigo_fila   = var_fila
	IF Trim(String(var_pico))  <> "" and Not IsNull(var_pico)   Then codigo_pico   = var_pico
	IF Trim(codigo_operario) = "" or IsNull(codigo_operario) Then 
		If Trim(var_operario) <> ""  and Not Isnull(var_operario) then
	   	codigo_operario = var_operario
   	End If
	END IF

	var_es_pico  =  dw_consulta.GetItemString(row,"es_pico")
	articulo     =  dw_consulta.GetItemString(row,"articulo")
	familia      =  f_familia_articulo(codigo_empresa,articulo)
	tipo_unidad  =  f_unidad_articulo(codigo_empresa,articulo)
	
	If tipo_unidad = "0" Then
		dw_consulta.SetTabOrder("metros",0)
		dw_consulta.SetTabOrder("unidades",90)
	Else
		dw_consulta.SetTabOrder("metros",80)
		dw_consulta.SetTabOrder("unidades",0)
	END IF	
	IF var_es_pico = "S" Then
		dw_consulta.SetTabOrder("pico",40)
	Else
		dw_consulta.SetTabOrder("pico",0)
	End If	
END IF

sle_operario.text= dw_consulta.GetItemString(row,"operario")
sle_operario_nombre.text= f_nombre_almoperarios_abr(codigo_empresa,sle_operario.text)
st_etiqueta_operario.text= "Operario:"
end subroutine

public function boolean f_borrar_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea);Delete  From    almlincargas  
WHERE   almlincargas.empresa    = :arg_empresa
AND     almlincargas.anyo_ped   = :arg_anyo
AND     almlincargas.pedido     = :arg_pedido
AND     almlincargas.linea_ped  = :arg_linea;
IF SQLCA.SQLCODE <> 0 Then Return FALSE
Return TRUE

end function

public subroutine f_control_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea);Dec{0} numero
Dec{4} ord_cantidad,va_cantidad
Dec{0} va_calibre,va_pallets,va_total_cajas,va_cajas
String va_referencia,va_situacion,va_tipo_pallet,va_ubicacion,va_tono


Select count(*) Into :numero From almlincargas
Where  almlincargas.empresa    = :arg_empresa
And    almlincargas.anyo_ped   = :arg_anyo
And    almlincargas.pedido     = :arg_pedido
And    almlincargas.linea_ped  = :arg_linea;
IF IsNull(numero) Then numero = 0
IF numero = 0 Then Return 
IF numero > 1 Then
	f_borrar_ordenes(arg_empresa,arg_anyo,arg_pedido,arg_linea)
	Return 
END IF

Select sum(cantidad) Into :ord_cantidad From almlincargas
Where  almlincargas.empresa    = :arg_empresa
And    almlincargas.anyo_ped   = :arg_anyo
And    almlincargas.pedido     = :arg_pedido
And    almlincargas.linea_ped  = :arg_linea;

IF IsNUll(ord_cantidad) Then ord_cantidad = 0
  SELECT venliped.tonochar,          venliped.calibre,   
         venliped.cantidad,      venliped.pallets,   
         venliped.total_cajas,   venliped.cajas,   
         venliped.referencia,    venliped.situacion,   
         venliped.tipo_pallet  
    INTO :va_tono,:va_calibre,:va_cantidad,:va_pallets,:va_total_cajas,   
         :va_cajas,:va_referencia,:va_situacion,:va_tipo_pallet  
    FROM venliped  
   WHERE venliped.empresa = :arg_empresa
	AND   venliped.anyo    = :arg_anyo
	AND   venliped.pedido  = :arg_pedido
	AND   venliped.linea   = :arg_linea;
	
	IF ord_cantidad <> va_cantidad Then
		f_borrar_ordenes(arg_empresa,arg_anyo,arg_pedido,arg_linea)
		Return
	END IF
	
	IF va_situacion = "P" Then
	  SELECT almlinubica.ubicacion   INTO :va_ubicacion  FROM almlinubica  
	   WHERE almlinubica.empresa = :arg_empresa 
		AND   almlinubica.anyo    = :arg_anyo
		AND   almlinubica.pedido  = :arg_pedido
		AND   almlinubica.linped  = :arg_linea;
	END IF
	
//	  if f_sector_articulo(codigo_empresa,la.articulo)="S" then
//			la.peso_bruto   = f_calculo_peso(codigo_empresa,la.articulo,la.tipo_pallet,la.cajas,la.total_cajas,la.pallets,la.cantidad)
//			la.peso_neto    = f_calculo_peso_neto(la.empresa,la.articulo,la.cajas,la.total_cajas,la.cantidad)
//     Else
//			la.peso_bruto   = 0
//			la.peso_neto    = 0
//     End if
// 
	  
 	  UPDATE almlincargas  
     SET tonochar     = :va_tono,   
         calibre      = :va_calibre,   
         referencia   = :va_referencia,   
         tipo_pallet  = :va_tipo_pallet,   
         cajas        = :va_cajas,   
         total_cajas  = :va_total_cajas,   
         cantidad     = :va_cantidad,   
         cantidad_ped = :va_cantidad,   
         ubicacion    = :va_ubicacion,   
         pallets      = :va_pallets,   
         situacion_pedido = :va_situacion 
  Where  almlincargas.empresa    = :arg_empresa
  And    almlincargas.anyo_ped   = :arg_anyo
  And    almlincargas.pedido     = :arg_pedido
  And    almlincargas.linea_ped  = :arg_linea;

Return 


end subroutine

public function boolean f_salir ();cb_3.enabled                = TRUE
cb_preparar.enabled         = TRUE
cb_salir.enabled            = TRUE
cb_stock.enabled            = TRUE
cb_borrar_pedido.enabled    = TRUE
dw_consulta.enabled         = TRUE
uo_almacen.enabled          = TRUE
dw_preparacion.visible      = FALSE
uo_cliente.em_campo.enabled = TRUE
pb_imprimir.enabled         = TRUE
st_1.enabled                = TRUE
cb_modificar.enabled        = TRUE
dw_consulta.SetFocus()
Return TRUE
end function

public function boolean f_insertar ();String preparado,var_descripcion
Dec{2} cantidad_linea
long donde

suborden = suborden +1
If var_tipo_unidad = "0" Then
  	cantidad_linea =  var_unidades
ELSE
  	cantidad_linea =  var_metros
END IF

IF var_situacion = "P" Then
 	preparado = "S"
ELSE	
 	preparado = "N"
END IF

donde =	dw_consulta.insertrow(0)
dw_consulta.SetItem(donde,"suborden",    suborden)
dw_consulta.SetItem(donde,"empresa",    codigo_empresa)
dw_consulta.SetItem(donde,"articulo",   var_articulo)
dw_consulta.SetItem(donde,"formato",    var_formato)
dw_consulta.SetItem(donde,"calidad",    var_calidad)
dw_consulta.SetItem(donde,"tono",   var_tono)
dw_consulta.SetItem(donde,"calibre",    var_calibre)
dw_consulta.SetItem(donde,"tipo_pallet",var_tipo_pallet)
dw_consulta.SetItem(donde,"tipo_pallet_entrada",var_tipo_pallet_preparacion)
dw_consulta.SetItem(donde,"pedido",     var_pedido)
dw_consulta.SetItem(donde,"anyo",       var_periodo)
dw_consulta.SetItem(donde,"pallets",    var_pallets)
dw_consulta.SetItem(donde,"cajas",      var_cajas)
dw_consulta.SetItem(donde,"total_cajas",var_total_cajas)
dw_consulta.SetItem(donde,"unidades",   var_unidades)
dw_consulta.SetItem(donde,"metros",     var_metros)
dw_consulta.SetItem(donde,"linea",      var_linea)
dw_consulta.SetItem(donde,"fila",      var_fila_ent)
dw_consulta.SetItem(donde,"altura",    var_altura_ent)
dw_consulta.SetItem(donde,"preparado", preparado)
dw_consulta.SetItem(donde,"es_pico",   var_es_pico)
dw_consulta.SetItem(donde,"orden",     var_orden_preparacion)
dw_consulta.SetItem(donde,"pico",      var_numero_pico)
dw_consulta.SetItem(donde,"operario",   var_operario_prepa)
dw_consulta.SetItem(donde,"situacion",   var_situacion)
dw_consulta.SetItem(donde,"caja",   var_caja)
dw_consulta.SetItem(donde,"npalet",   var_numpalet)
dw_consulta.SetItem(donde,"hornos",   0)
dw_consulta.SetItem(donde,"anyo_proddiaria",   var_anyo_proddiaria)
dw_consulta.SetItem(donde,"contador_proddiaria",   var_contador_proddiaria)
dw_consulta.SetItem(donde,"cantidad_original",   var_cantidad_original)
dw_consulta.SetItem(donde,"linea_desdoblada_de",   var_linea_desdoblada_de)
dw_consulta.SetItem(donde,"idioma",   var_idioma)
dw_consulta.SetItem(donde,"nombre_formato",f_nombre_formato_abr(codigo_empresa,var_formato))

if trim(var_idioma) = "0" or isnull(var_idioma) then
	var_descripcion = f_nombre_articulo(codigo_empresa,var_articulo)
else
   var_descripcion = f_descripcion_almcliartdesc2(codigo_empresa,f_cliente_venped(codigo_empresa,var_periodo,var_pedido),var_articulo,dec(var_idioma))
end if	

dw_consulta.SetItem(donde,"nombre_articulo",var_descripcion)

Return TRUE
end function

public function boolean f_grabar_entrada_regularizacion ();Integer contador,grabado,salir,x1,control_bien
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis
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
movhis.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "103"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")       
Else
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")       
End if
movhis.cantidads  = 0
movhis.precio     = 0
SetNull(movhis.codtercero)
SetNull(movhis.numdoc)
movhis.situacion  = "N"   
movhis.observaciones = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo

movhis.calidad  = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""

movhis.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
movhis.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
movhis.caja			 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet_entrada
movhis.sector      = var_sector   
f_mensaje_proceso("Insertando Mov.",8,10)
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
f_mensaje_proceso("Insertado Mov.",8,10)
f_mensaje_proceso("Actualiza Mov.",8,10)
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
f_mensaje_proceso("Mov. Act",8,10)

linubica.empresa  = codigo_empresa  
linubica.almacen  = "1"
linubica.zona     = codigo_zona
linubica.fila     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"fila")
linubica.altura   = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"altura")
IF IsNUll(linubica.altura) Then linubica.altura= 0
linubica.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
linubica.familia   = var_familia 
linubica.formato   = var_formato
linubica.modelo    = var_modelo
linubica.calidad   = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")
if isnull(linubica.calidad) or trim(linubica.calidad)="0" then linubica.calidad = ""
linubica.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")
linubica.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")
linubica.caja		   = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
Setnull(linubica.anyo) 
Setnull(linubica.pedido)
Setnull(linubica.linped)
Setnull(linubica.cliente)  
linubica.ubicacion   = f_componer_ubicacion (linubica.almacen,linubica.zona,linubica.fila,linubica.altura)  
linubica.tipo_unidad = var_tipo_unidad   
linubica.referencia  = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
linubica.f_alta= Datetime(Today(),Now())   
IF var_tipo_unidad = "0" Then
	linubica.existencias = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
Else
	linubica.existencias  = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
End If				
linubica.tipo_pallet   = var_tipo_pallet_entrada
linubica.sector        = var_sector
linubica.observaciones = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)

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

//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//

linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden (movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = linubica.zona
linubicahis.fila        = linubica.fila
linubicahis.altura      = linubica.altura
linubicahis.ubicacion   = linubica.ubicacion
linubicahis.cantidads   = movhis.cantidads
linubicahis.cantidade   = movhis.cantidade
linubicahis.articulo    = linubica.articulo
linubicahis.familia     = linubica.familia
linubicahis.formato     = linubica.formato
linubicahis.modelo      = linubica.modelo
linubicahis.calidad     = linubica.calidad
linubicahis.tonochar    = linubica.tonochar
linubicahis.calibre     = linubica.calibre
linubicahis.caja			= linubica.caja
linubicahis.fecha       = DateTime(Today())
linubicahis.tipomov     = "103"
linubicahis.tipo_unidad = movhis.tipo_unidad
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
linubicahis.observaciones = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
linubicahis.tipo_pallet = var_tipo_pallet_entrada
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden(linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF


end function

public function boolean f_salir2 ();String referencia,var_observaciones
Long   var_hornos,var_anyo_mov

cb_3.enabled                = TRUE
cb_preparar.enabled         = TRUE
cb_salir.enabled            = TRUE
cb_stock.enabled            = TRUE
cb_borrar_pedido.enabled    = TRUE
dw_consulta.enabled         = TRUE
uo_almacen.enabled          = TRUE
dw_preparacion.visible      = FALSE
uo_cliente.em_campo.enabled = TRUE
pb_imprimir.enabled         = TRUE
st_1.enabled                = TRUE
cb_modificar.enabled        = TRUE

referencia   = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)
var_hornos   = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"hornos")
var_anyo_mov = year(today())

if var_hornos <> 0 then
	var_observaciones = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
else	
	var_observaciones = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
end if
	
DELETE FROM almmovhis
WHERE almmovhis.nummov = :var_mov_ent and almmovhis.anyo = :var_anyo_mov
USING SQLCA;

DELETE FROM almlinubicahis
WHERE almlinubicahis.nummov = :var_mov_ent and almlinubicahis.anyo = :var_anyo_mov
USING SQLCA;

DELETE FROM almlinubica  
WHERE (almlinubica.empresa       = :codigo_empresa) AND  
		(almlinubica.almacen       = "1") AND  
		(almlinubica.zona          = "P") AND  
		(almlinubica.fila          = 1) AND
		(almlinubica.altura        = 1) AND
		(almlinubica.referencia    = :referencia) AND
		(almlinubica.observaciones like :var_observaciones)
USING SQLCA;
		
IF SQLCA.SQLCode<>0 THEN
   dw_consulta.SetFocus()
   Return TRUE
Else
	Return FALSE
END IF
end function

public function boolean f_grabar_entrada_regularizacion2 (decimal diferencia);Integer contador,grabado,salir,x1,control_bien
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis
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
movhis.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "103"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = diferencia     
Else
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")       
End if
movhis.cantidads  = 0
movhis.precio     = 0
SetNull(movhis.codtercero)
SetNull(movhis.numdoc)
movhis.situacion  = "N"   
movhis.observaciones = "Automático"
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo

movhis.calidad  = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""

movhis.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
movhis.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
movhis.caja			 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet_entrada
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
AND    almlinubica.observaciones like "Automático";

cur_existencias = cur_existencias + diferencia

UPDATE almlinubica  
SET    existencias    = :cur_existencias
WHERE almlinubica.empresa    =  :linubica.empresa
AND   almlinubica.ubicacion  =  :linubica.ubicacion
AND   almlinubica.linea      =  :linubica.linea;
IF Sqlca.SqlCode <> 0 Then control_bien = 1

if isnull(linubica.ubicacion) or linubica.ubicacion = "" then
	linubica.ubicacion  =f_componer_ubicacion (movhis.almacen,codigo_zona,1,1)  
	messagebox("Atención",linubica.ubicacion)
end if
//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden (movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = codigo_zona
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
linubicahis.observaciones = "Automático"
linubicahis.tipo_pallet = var_tipo_pallet_entrada
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF


end function

public function boolean f_grabar_salida_regularizacion (decimal diferencia);Integer control_bien,contador,registro
str_almmovhis        movhis
str_almlinubica      linubica
str_almlinubicahis   linubicahis
String cur_referencia,var_observaciones
Dec{2} cur_existencias,cantidad_marcada,cur_linea
Long   anyo_pedido,pedido,linea
control_bien = 0

anyo_pedido     =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"anyo")
pedido          =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"pedido")
linea           =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")

movhis.empresa      = codigo_empresa   
movhis.almacen      = uo_almacen.em_codigo.text
movhis.anyo         = Year(Today())
movhis.nummov       = f_almparam_nummov(codigo_empresa,movhis.anyo)
linubicahis.orden   = f_almparam_numorden (movhis.empresa,movhis.anyo)
movhis.origen       = "2"   
movhis.articulo     = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
movhis.fechmov      = DateTime(Today())   
movhis.tipomov      = "102"
movhis.cantidads    = abs(diferencia)
movhis.cantidade    = 0
movhis.precio       = 0
movhis.codtercero   = f_cliente_venped (codigo_empresa,Integer(em_anyo.text),Dec(em_pedido.text))
movhis.numdoc       = ""
movhis.situacion    = "N"   
movhis.observaciones= "Automático "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
SetNull(movhis.punteado)
movhis.antexist     = 0   
movhis.familia      = var_familia 
movhis.formato      = var_formato 
movhis.modelo       = var_modelo
movhis.calidad      = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""
movhis.tonochar     = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
movhis.calibre      = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
movhis.caja			  = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   
movhis.tipo_unidad  = var_tipo_unidad   
movhis.referencia   = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta       = DateTime(Today(),Now())   
movhis.usuario      = nombre_usuario   
movhis.tipo_pallet  = dw_consulta.GetItemString(dw_consulta.GetRow(),"tipo_pallet")   
movhis.sector       = var_sector   
		
   //---------------//
  // Des_ubicacion //
 //---------------//

SELECT empresa,ubicacion,linea,existencias
INTO   :linubica.empresa, :linubica.ubicacion, :linubica.linea, :cur_existencias
FROM   almlinubica
WHERE  almlinubica.empresa     = :codigo_empresa
AND    almlinubica.referencia  = :movhis.referencia
AND    almlinubica.tipo_pallet = :movhis.tipo_pallet
AND    almlinubica.zona    = "P"
AND    almlinubica.altura  = 1
AND	 almlinubica.fila    = 1
AND	 almlinubica.anyo    = :anyo_pedido
AND	 almlinubica.pedido  = :pedido
AND    almlinubica.linped  = :linea;


cur_existencias = cur_existencias - diferencia

if cur_existencias = 0 then
	DELETE 
	FROM almlinubica  
	WHERE almlinubica.empresa    =  :linubica.empresa
	AND   almlinubica.ubicacion  =  :linubica.ubicacion
	AND   almlinubica.linea      =  :linubica.linea;
	IF Sqlca.SqlCode <> 0 Then control_bien = 1
else
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
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = codigo_zona
linubicahis.fila        = 1
linubicahis.altura      = 1
linubicahis.ubicacion   = linubica.ubicacion
linubicahis.cantidads   = abs(diferencia)
linubicahis.cantidade   = 0
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
linubicahis.tipo_pallet = movhis.tipo_pallet
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
linubicahis.observaciones = "Automático "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
linubicahis.sector      = var_sector
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
linubicahis.orden = linubicahis.orden +1
movhis.nummov = movhis.nummov +1
		
IF Not f_actualiza_numorden (linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
var_mov_sal=movhis.nummov 
If control_bien = 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean f_grabar_entrada_regularizacion3 (decimal diferencia);Integer contador,grabado,salir,x1,control_bien
str_almlinubica    linubica
str_almlinubicahis linubicahis
str_almmovhis      movhis
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
movhis.articulo  = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")   
movhis.fechmov   = DateTime(Today())   
movhis.tipomov   = "998"   
IF var_tipo_unidad ="0" Then
	movhis.cantidade = diferencia     
Else
	movhis.cantidade = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")       
End if
movhis.cantidads  = 0
movhis.precio     = 0
SetNull(movhis.codtercero)
SetNull(movhis.numdoc)
movhis.situacion  = "N"   
movhis.observaciones = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
SetNull(movhis.punteado)
movhis.antexist = 0   
movhis.familia  = var_familia 
movhis.formato  = var_formato 
movhis.modelo   = var_modelo

movhis.calidad  = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")   
if isnull(movhis.calidad) or trim(movhis.calidad)="0" then movhis.calidad = ""

movhis.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")   
movhis.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")   
movhis.caja			 = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
movhis.tipo_unidad = var_tipo_unidad   
movhis.referencia  = f_componer_ref (movhis.articulo,movhis.calidad,movhis.tonochar,movhis.calibre)
movhis.f_alta      = DateTime(Today(),Now())   
movhis.usuario     = nombre_usuario   
movhis.tipo_pallet = var_tipo_pallet_entrada
movhis.sector      = var_sector   
f_mensaje_proceso("Insertando Mov.",8,10)
IF Not f_insert_almmovhis(movhis) Then control_bien = 1
f_mensaje_proceso("Insertado Mov.",8,10)
f_mensaje_proceso("Actualiza Mov.",8,10)
IF Not f_actualiza_nummov(movhis.empresa,movhis.anyo,movhis.nummov) Then control_bien = 1
f_mensaje_proceso("Mov. Act",8,10)

linubica.empresa     = codigo_empresa  
linubica.almacen     = "1"
linubica.zona        = codigo_zona
linubica.fila        = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"fila")
linubica.altura      = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"altura")
linubica.articulo    = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
linubica.familia     = var_familia 
linubica.formato     = var_formato
linubica.modelo      = var_modelo
linubica.calidad     = dw_consulta.GetItemString(dw_consulta.GetRow(),"calidad")
linubica.tonochar    = dw_consulta.GetItemString(dw_consulta.GetRow(),"tono")
linubica.calibre     = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"calibre")
linubica.caja		   = dw_consulta.GetItemString(dw_consulta.GetRow(),"caja")   			
Setnull(linubica.anyo)
Setnull(linubica.pedido) 
Setnull(linubica.linped) 
Setnull(linubica.cliente)   
linubica.ubicacion   = f_componer_ubicacion (linubica.almacen,linubica.zona,linubica.fila,linubica.altura)  
linubica.tipo_unidad = var_tipo_unidad   
linubica.referencia  = f_componer_ref (linubica.articulo,linubica.calidad,linubica.tonochar,linubica.calibre)
linubica.f_alta= Datetime(Today(),Now())   
IF var_tipo_unidad = "0" Then
	linubica.existencias  = diferencia
Else
	linubica.existencias  = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
End If				
linubica.tipo_pallet   = var_tipo_pallet_entrada
linubica.sector        = var_sector
linubica.observaciones = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)

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

//---------------------------------//
// Grabar Historico de ubicaciones //
//---------------------------------//
linubicahis.empresa     = movhis.empresa
linubicahis.anyo        = movhis.anyo
linubicahis.almacen     = movhis.almacen
linubicahis.orden       = f_almparam_numorden(movhis.empresa,movhis.anyo)
linubicahis.nummov      = movhis.nummov
linubicahis.zona        = codigo_zona
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
linubicahis.tipomov     = "998"
linubicahis.tipo_unidad = movhis.tipo_unidad
linubicahis.referencia  = movhis.referencia
linubicahis.f_alta      = movhis.f_alta
linubicahis.usuario     = movhis.usuario
linubicahis.observaciones = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
linubicahis.tipo_pallet = var_tipo_pallet_entrada
linubicahis.sector      = var_sector
IF Not f_insert_almlinubicahis(linubicahis) Then control_bien = 1
if Not f_actualiza_numorden(linubicahis.empresa,linubicahis.anyo,linubicahis.orden) Then control_bien = 1

var_mov_ent=  movhis.nummov
IF control_bien = 0 Then
	Return TRUE
Else
	Return FALSE
END IF
end function

public function boolean f_busca_mov (string referencia);String aux_obs1,aux_obs2,sel
Long   total
datastore datos

aux_obs1 = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
aux_obs2 = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)

sel = "select * "+&
		"from almmovhis "+&
		"where empresa = '"+codigo_empresa+"' and "+&
      "      articulo = '"+referencia+"' and "+&
		"      (observaciones like '"+aux_obs1+"' or observaciones like '"+aux_obs2+"')"
		
//datos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, datos)


total = datos.RowCount()
		
if total = 0 then
	destroy datos
	return false
else
	destroy datos
	return true
end if
		
end function

public subroutine f_procesar_desubi2 ();str_venliped ped
String v_calidad,v_tipo_pallet,v_caja,cod_ubicacion,referencia,var_pallet_entrada
Dec{0} periodo,pedido,linea,anyoent,nummovent  
Dec{2} cantidad_preparada,total_cantidad,mod_cantidad
String es_pico,v_tipo_unidad,almacenent
String antealmacen,v_articulo
Dec    y1,longitudes,w_cont,v_calibre
Date   fecha
Dec    numero,controles,x2
string mensaje,nombre,campo,v_tono
Integer aux_fila,aux_altura

periodo  = Dec(em_anyo.text)
pedido   = Dec(em_pedido.text)
linea    = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
var_pallet_entrada  = dw_consulta.GetItemString(dw_consulta.GetRow(),"tipo_pallet")	

SELECT  venliped.cantidad_prepa, venliped.numero_pico, 
		venliped.anyo_ent,       venliped.nummov_ent,
		venliped.anyo_sal,       venliped.nummov_sal,            
		venliped.fila_ent,       venliped.altura_ent,
		venliped.es_pico,        venliped.pallets,
		venliped.numero_pico
INTO   :ped.cantidad_prepa,    :ped.numero_pico,               
		:ped.anyo_ent,          :ped.nummov_ent,
		:ped.anyo_sal, 			:ped.nummov_sal,         
		:ped.fila_ent,          :ped.altura_ent,
		:ped.es_pico,           :ped.pallets,
		:ped.numero_pico
FROM   venliped  
WHERE (venliped.empresa = :codigo_empresa) 
AND   (venliped.anyo    = :periodo)
AND   (venliped.pedido  = :pedido)
AND   (venliped.linea   = :linea);
If Sqlca.SqlCode = 100 then 
	f_mensaje("Error en proceso","La linea: "+ String(linea) + " Del pedido: " + String(pedido) + "No existe")
	bien = 1
END IF
	
es_pico  = dw_consulta.GetItemString(dw_consulta.GetRow(),"es_pico")
IF f_unidad_articulo(codigo_empresa,dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")) = "0" Then
	cantidad_preparada =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
Else
	cantidad_preparada =  dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
END IF

IF IsNull(ped.cantidad_prepa) then ped.cantidad_prepa= 0
	
SetNull(ped.numero_pico)
SetNull(ped.anyo_ent)
SetNull(ped.nummov_ent)
SetNull(ped.anyo_sal)
SetNull(ped.nummov_sal)
SetNull(ped.fila_ent)
SetNull(ped.altura_ent)
SetNull(ped.operario_prepa)
IF ped.es_pico = "S" Then ped.pallets = 0
SetNull(ped.numero_pico)

ped.cantidad_prepa = ped.cantidad_prepa - cantidad_preparada
ped.situacion = "C"

UPDATE venliped  
  SET cantidad_prepa  = :ped.cantidad_prepa,   
		tipo_pallet     = :var_pallet_entrada,
		caja            = :var_caja,
		anyo_ent        = :ped.anyo_ent,   
		nummov_ent      = :ped.nummov_ent,   
		anyo_sal        = :ped.anyo_sal,   
		nummov_sal      = :ped.nummov_sal,   
		fila_ent        = :ped.fila_ent,   
		altura_ent      = :ped.altura_ent,   
		operario_prepa  = :ped.operario_prepa,   
		situacion       = :ped.situacion,
		pallets         = :ped.pallets,
		numero_pico     = :ped.numero_pico,
		numpalet        = 0,
		tipo_pallet_preparacion = :var_pallet_entrada
		
WHERE (venliped.empresa   = :codigo_empresa)
AND   (venliped.anyo      = :periodo)
AND   (venliped.pedido    = :pedido)
AND   (venliped.linea     = :linea);
If Sqlca.SqlCode <> 0 Then 
	f_mensaje("Error en proceso",SQLCA.SQLErrtext)
	bien = 1
END IF
f_control_ordenes(codigo_empresa,periodo,pedido,linea)

CHOOSE CASE bien
CASE 1
  ROLLBACK USING SQLCA;
  MessageBox("Fin de proceso","Error en proceso no se actualiza "+sqlca.sqlerrtext,Exclamation!, OK!,1)
CASE 0
  COMMIT USING SQLCA;
CASE ELSE
  ROLLBACK USING SQLCA;
  MessageBox("Fin de proceso","Error en proceso no se actualiza "+sqlca.sqlerrtext,Exclamation!, OK!,1)
END CHOOSE

procesando = "S"
f_cargar()
procesando = "N"
pb_1.enabled=TRUE
cb_3.TriggerEvent(Clicked!)

end subroutine

public subroutine f_desdoblar_nueva (long reg);Dec    disponible
String articulo,caja,calidad,tono,tipo_pallet,tipo_unidad,referencia,situacion,control_pico
Long   calibre,pico,pallets,pedido,linea,cantidad_des,cantidad_org,cantidad_anterior,cantidad,unidades,cajas,cantidad_ped
Dec    numero,vbien = 0
String cadena,control_ordenes
Long i,total,registro,cantidad_desglose,metros,total_cajas,linea_aux,numpalet_aux,posi,posi_aux
str_venliped      ln  
str_almlincargas  la

registro = dw_consulta.GetRow()

var_tipo_pallet_entrada = dw_consulta.GetItemString(registro,"tipo_pallet_entrada")
pallets = dw_consulta.GetItemnumber(registro,"pallets")
IF IsNull(pallets) Then pallets = 0

articulo        =  dw_consulta.GetItemString(registro,"articulo")
caja				 =  dw_consulta.GetItemString(registro,"caja")
calidad         =  dw_consulta.GetItemString(registro,"calidad")
tono            =  dw_consulta.GetItemString(registro,"tono")
calibre         =  dw_consulta.GetItemNumber(registro,"calibre")
pico            =  dw_consulta.GetItemNumber(registro,"pico")
tipo_pallet     =  dw_consulta.GetItemString(registro,"tipo_pallet")
var_articulo    =  articulo
var_tipo_pallet =  tipo_pallet
tipo_unidad     =  f_unidad_articulo(codigo_empresa,articulo)
referencia      =  f_componer_ref(articulo,calidad,tono,calibre)
anyo            =  dw_consulta.GetItemNumber(registro,"anyo")
pedido          =  dw_consulta.GetItemNumber(registro,"pedido")
linea           =  dw_consulta.GetItemNumber(registro,"linea")
cantidad_desglose =  dw_des.GetItemNumber(reg,"cant_desdoblada")
cantidad_org    =  dw_des.GetItemNumber(reg,"cant_original")
cantidad_ped    =  dw_des.GetItemNumber(reg,"cant_pedido")
numpalet_aux    =  dw_des.GetItemNumber(reg,"numpalet")

//-----------------------------------------------//
//----------- Control Disponible ----------------//
//-----------------------------------------------//

disponible = f_disponible_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
iF IsNUll(disponible) Then disponible = 0				 
situacion = "C"
If disponible  < cantidad_org Then
	situacion = "F"
END IF

//------Control Desdoble ordenes-----//
f_control_ordenes(codigo_empresa,anyo,pedido,linea)
IF situacion = "F" Then 
		tono = "0"
		calibre = 0
END IF

cadena       = f_calculo_unidades(codigo_empresa,articulo,var_tipo_pallet,caja,0,0,cantidad_desglose)
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	pallets     = dec(Mid(cadena,1,posi - 1))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	total_cajas  = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

if reg = 1 then
	UPDATE venliped  
	SET    tonochar    = :tono,   
			 calibre     = :calibre,   
			 cantidad    = :cantidad,   
			 pallets     = :pallets,   
			 total_cajas = :total_cajas,   
			 cajas       = :cajas,   
			 referencia  = :referencia,   
			 tipo_pallet_preparacion = :var_tipo_pallet_entrada,
			 tipo_pallet = :var_tipo_pallet,
			 situacion   = :situacion,
			 cantidad_facturar = :cantidad,
			 cantidad_original = :cantidad_ped,
			 numpalet          = :numpalet_aux
	 WHERE venliped.empresa = :codigo_empresa 
		AND  venliped.anyo    = :anyo 
		AND  venliped.pedido  = :pedido 
		AND  venliped.linea   = :linea ;
end if

dw_preparacion.reset()
SetNull(codigo_altura)
SetNull(codigo_fila)
SetNull(codigo_pico)
SetNull(codigo_operario)

if reg > 1 then
	f_desdoblar_linea(codigo_empresa,anyo,pedido,linea,cantidad_desglose,numpalet_aux,cantidad_ped)
end if
IF Not f_actualizar_linea_venpedido(codigo_empresa,anyo,pedido,linea) Then f_mensaje("Error desbloblar linea",sqlca.sqlErrtext)
IF Not f_actualizar_venpedido(codigo_empresa,anyo,pedido) Then f_mensaje("Error desbloblar linea",sqlca.sqlErrtext)
COMMIT;
end subroutine

public function boolean f_desdoblar_linea (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_cantidad, decimal arg_numpalet, decimal arg_original);Dec disponible
str_venliped     ln  
str_almlincargas  la
Dec numero,vbien = 0
String cadena,control_ordenes
Long  posi,posi_aux

control_ordenes = "S"

la.empresa = codigo_empresa

Select count(*) Into :numero From almlincargas
Where  almlincargas.empresa    = :arg_empresa
And    almlincargas.anyo_ped   = :arg_anyo
And    almlincargas.pedido     = :arg_pedido
And    almlincargas.linea_ped  = :arg_linea;
IF IsNull(numero) Then numero = 0

IF numero = 0 Then control_ordenes = "N" 
IF numero > 1 Then control_ordenes = "N"

IF control_ordenes = "S" Then
		Select almlincargas.anyo,almlincargas.orden 
		Into   :la.anyo,:la.orden From almlincargas
		Where  almlincargas.empresa    = :arg_empresa
		And    almlincargas.anyo_ped   = :arg_anyo
		And    almlincargas.pedido     = :arg_pedido
		And    almlincargas.linea_ped  = :arg_linea;
		IF sqlca.sqlcode <> 0 Then vbien = 1
			
	  SELECT almcargas.matricula,almcargas.forden INTO :la.matricula,:la.forden FROM almcargas  
		WHERE almcargas.empresa = :la.empresa
		AND   almcargas.anyo    = :la.anyo 
		AND   almcargas.orden   = :la.orden ;
		IF sqlca.sqlcode <> 0 Then vbien = 1

	  SELECT almcargaref.fcarga, almcargaref.cliente  
	  INTO  :la.fcarga, :la.cliente  
	  FROM  almcargaref  
	  WHERE almcargaref.empresa    = :la.empresa
	  AND   almcargaref.anyo       = :la.anyo
	  AND   almcargaref.referencia = :la.matricula;
	  IF sqlca.sqlcode <> 0 Then vbien = 1
END IF

SELECT venliped.empresa, venliped.anyo, venliped.pedido,  venliped.linea,   
         venliped.serie, venliped.fpedido,  venliped.fentrega,  venliped.cliente,   
         venliped.tipo_unidad, venliped.articulo,  venliped.familia, venliped.formato,   
         venliped.modelo,venliped.calidad,venliped.tonochar, venliped.calibre,   
         venliped.precio, venliped.precio_estand, venliped.cantidad, venliped.pallets,   
         venliped.total_cajas, venliped.cajas,     venliped.dtocomer,   
         venliped.dtoesp,   venliped.descripcion,   
         venliped.tipoiva,  venliped.iva,   
         venliped.linfab,   venliped.provincia,     venliped.pais,   
         venliped.zona,     venliped.tipolinea,     venliped.texto1,   
         venliped.texto2,   venliped.texto3,        venliped.texto4,   
         venliped.referencia,  venliped.montajeartcal,   venliped.situacion,   
         venliped.divisa,      venliped.metros_lineales, venliped.peso,   
         venliped.falta,       venliped.usuario,      venliped.tipo_pallet,
			venliped.caja,
         venliped.importe,     venliped.descuento,    venliped.importedto,   
         venliped.clase,       venliped.sector,       venliped.agente1,   
         venliped.agente2,     venliped.agente3,      venliped.comision11,   
         venliped.comision12,  venliped.comision21,   venliped.comision22,   
         venliped.comision31,  venliped.comision32,   venliped.deposito,   
         venliped.orden_preparacion,        venliped.cantidad_prepa,     venliped.es_pico,   
         venliped.numero_pico,  venliped.anyo_ent,
			venliped.nummov_ent,   venliped.anyo_sal,  venliped.nummov_sal,   
         venliped.fila_ent,  venliped.altura_ent,   
         venliped.operario_prepa,    venliped.control_incremento,   
         venliped.peso_neto,       venliped.precio_aduana,   
         venliped.control_descuentos,  venliped.control_comisiones,   
         venliped.importe_aduana,  venliped.bruto,  venliped.precio_neto,   
         venliped.precio_aduana_neto, venliped.descuento_aduana,   
         venliped.neto,  venliped.impdtopp,   
         venliped.ref_cli,    venliped.transportista,   
         venliped.almacen_ent,     venliped.tipo_pallet_preparacion,   
         venliped.almacen_deposito, venliped.envio, venliped.idioma
			INTO  :ln.empresa,:ln.anyo,:ln.pedido,:ln.linea,:ln.serie,   
		         :ln.fpedido,:ln.fentrega,:ln.cliente,:ln.tipo_unidad,   
		         :ln.articulo,:ln.familia,:ln.formato,:ln.modelo,   
		         :ln.calidad,:ln.tonochar,:ln.calibre,:ln.precio,:ln.precio_estand,   
		         :ln.cantidad,:ln.pallets,:ln.total_cajas,:ln.cajas,:ln.dtocomer,   
		         :ln.dtoesp,:ln.descripcion,:ln.tipoiva,:ln.iva,:ln.linfab,   
		         :ln.provincia,:ln.pais,:ln.zona,:ln.tipolinea,:ln.texto1,   
		         :ln.texto2,:ln.texto3,:ln.texto4,:ln.referencia,:ln.montajeartcal,   
		         :ln.situacion,:ln.divisa, :ln.metros_lineales, :ln.peso,   
		         :ln.falta, :ln.usuario, :ln.tipo_pallet, :ln.caja,
					:ln.importe,   
			      :ln.descuento,  :ln.importedto, :ln.clase,  :ln.sector,   
		         :ln.agente1,  :ln.agente2, :ln.agente3,  :ln.comision11,   
		         :ln.comision12, :ln.comision21, :ln.comision22, :ln.comision31,   
		         :ln.comision32, :ln.deposito,    :ln.orden_preparacion,   
         :ln.cantidad_prepa,   
         :ln.es_pico,   
         :ln.numero_pico,   
         :ln.anyo_ent,   
         :ln.nummov_ent,   
         :ln.anyo_sal,   
         :ln.nummov_sal,   
         :ln.fila_ent,   
         :ln.altura_ent,   
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
         :ln.almacen_ent,   
         :ln.tipo_pallet_preparacion,   
         :ln.almacen_deposito,   
         :ln.envio,
			:ln.idioma
    FROM  venliped  
	 Where venliped.empresa  = :arg_empresa
	 And   venliped.anyo     = :arg_anyo
	 And   venliped.pedido   = :arg_pedido
	 And   venliped.linea    = :arg_linea;
	 IF sqlca.sqlcode <> 0 Then vbien = 1

	 disponible = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,&
					  ln.referencia,ln.tipo_pallet,ln.caja)
    IF disponible < arg_cantidad Then ante_situ= "F"
	 
	 IF ante_situ = "F" Then
			 ln.situacion = "F"
			 ln.tonochar  = "0"
			 ln.calibre = 0
	 END IF
	 
	 Select Max(linea) Into :ln.linea   FROM  venliped  
	 Where venliped.empresa  = :arg_empresa
	 And   venliped.anyo     = :arg_anyo
	 And   venliped.pedido   = :arg_pedido;
	 
	 IF control_ordenes = "S" Then
		Delete From almlincargas
		Where  almlincargas.empresa    = :arg_empresa
		And    almlincargas.anyo_ped   = :arg_anyo
		And    almlincargas.pedido     = :arg_pedido
		And    almlincargas.linea_ped  = :arg_linea;
		IF sqlca.sqlcode <> 0 Then vbien = 1
		Select max(almlincargas.linea) Into :la.linea
		From   almlincargas
		Where  almlincargas.empresa = :la.empresa
		And    almlincargas.anyo    = :la.anyo
		And    almlincargas.orden   = :la.orden;
		IF ISNULL(la.linea ) Then la.linea  = 0
		la.linea       = la.linea  +1
		la.anyo_ped    = arg_anyo
		la.pedido      = arg_pedido
		la.linea_ped   = arg_linea
		la.fecha_ped   = ln.fpedido
		la.articulo    = ln.articulo
		la.cliente     = ln.cliente
		la.calidad     = ln.calidad
		la.pallets     = ln.pallets
		la.tonochar    = ln.tonochar
		la.calibre     = ln.calibre
		la.tipo_pallet = ln.tipo_pallet
		la.caja        = ln.caja
		la.cajas       = ln.cajas
		la.total_cajas = ln.total_cajas
		la.cantidad    = ln.cantidad 
		la.cantidad_ped= ln.cantidad
		la.tipo_unidad = ln.tipo_unidad
		SetNUll(la.ubicacion)
		la.usuario     = nombre_usuario
		la.imp_bandas  = "N"
		la.deposito    = ln.deposito
		la.situacion_pedido = ln.situacion
		la.almacen_deposito = ln.almacen_deposito
		If Not f_insert_almlincargas(la) Then vbien = 1
	END IF
	 
	 
	ln.linea = ln.linea +1

   ln.cantidad = arg_cantidad
   IF ln.cantidad <> 0 Then
			// Calculo de cantidades
			cadena          =f_calculo_unidades(ln.empresa,ln.articulo,ln.tipo_pallet,ln.caja,0,0,ln.cantidad)
			posi_aux = 1
			posi = pos(cadena,"|",1)
			if posi <> 0 then
				ln.pallets     = dec(Mid(cadena,1,posi - 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <> 0 then
				ln.cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				ln.total_cajas  = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				ln.cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			IF control_ordenes = "S" Then
				la.linea        = la.linea +1
				la.linea_ped    = ln.linea
				la.cantidad     = ln.cantidad
				la.cantidad_ped = ln.cantidad
				la.pallets      = ln.pallets
				la.cajas        = ln.cajas
				la.total_cajas  = ln.total_cajas
				IF Not f_insert_almlincargas(la) Then vbien = 1
			End if
			// Santiago 03-10-00 No hay control de picos
			//ln.es_pico = "S"
			ln.es_pico = "N"
			// Santiago 03-10-00 No hay control de picos
			ln.numpalet = arg_numpalet
			ln.anyo_proddiaria = 0
			ln.contador_proddiaria = 0
			ln.cantidad_original = arg_original
			ln.linea_desdoblada_de = arg_linea
			IF Not f_insertar_venliped(ln) Then 
				f_mensaje("Error desbloblar linea",sqlca.sqlErrtext)
				vbien = 1
			END IF
			IF Not f_actualizar_linea_venpedido(ln.empresa,ln.anyo,ln.pedido,ln.linea) Then 
				f_mensaje("Error desbloblar linea",sqlca.sqlErrtext)
				vbien = 1
			END IF
	END IF
	IF vbien = 0 Then Return True
	Return False
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Preparación pedido Exportación"
This.title=istr_parametros.s_titulo_ventana
titulo = This.title
dw_consulta.enabled = FALSE
bloqueado = "N"
dw_consulta.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_conubi.SetTransObject(SQLCA)
dw_almlinubicahis.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_des.SetTransObject(SQLCA)

dw_proceso_ubi.SetTransObject(SQLCA)
dw_preparacion.SetTransObject(SQLCA)
em_anyo.text  =  String(Year(Today()))
var_conexion= "N"
IF istr_parametros.i_nargumentos>1 Then 
	em_anyo.text         = istr_parametros.s_argumentos[2]
	em_pedido.text       = istr_parametros.s_argumentos[3]
	var_linea_pedido     = Dec(istr_parametros.s_argumentos[4])
	var_conexion = "S"
	f_posicion_inicio(This)
	cb_continuar.TriggerEvent(Clicked!)
END IF


dw_consulta.SetRowFocusIndicator(Hand!)
dw_preparacion.SetRowFocusIndicator(Hand!)
dw_des.SetRowFocusIndicator(Hand!)

SELECT venparametros.almacen,venparametros.zona
INTO   :codigo_almacen,:codigo_zona  
FROM   venparametros  
WHERE  venparametros.empresa = :codigo_empresa   ;
uo_almacen.em_codigo.text = codigo_almacen
uo_almacen.em_campo.text  = f_nombre_almacen_abr(codigo_empresa,codigo_almacen)

//f_mascara_columna(dw_consulta,"pallets","##")
//f_mascara_columna(dw_consulta,"cajas","###")
//f_mascara_columna(dw_consulta,"metros","#,###.00")
//f_mascara_columna(dw_consulta,"unidades","##,###")
//f_mascara_columna(dw_consulta,"tono","##")
//f_mascara_columna(dw_consulta,"calibre","#")

f_activar_campo(em_pedido)
end event

on w_int_preparacion_pedido_exportacion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_pedido=create st_pedido
this.em_pedido=create em_pedido
this.st_anyo=create st_anyo
this.em_anyo=create em_anyo
this.st_etiqueta_operario=create st_etiqueta_operario
this.sle_operario=create sle_operario
this.sle_operario_nombre=create sle_operario_nombre
this.cb_salir=create cb_salir
this.gb_2=create gb_2
this.uo_almacen=create uo_almacen
this.cb_preparar=create cb_preparar
this.dw_proceso=create dw_proceso
this.dw_movhis=create dw_movhis
this.dw_proceso_ubi=create dw_proceso_ubi
this.dw_almlinubicahis=create dw_almlinubicahis
this.cb_continuar=create cb_continuar
this.cb_stock=create cb_stock
this.cb_borrar_pedido=create cb_borrar_pedido
this.dw_detalle=create dw_detalle
this.gb_1=create gb_1
this.cb_modificar=create cb_modificar
this.st_fecha=create st_fecha
this.st_cliente=create st_cliente
this.st_1=create st_1
this.uo_cliente=create uo_cliente
this.pb_imprimir=create pb_imprimir
this.cb_procesar=create cb_procesar
this.cb_3=create cb_3
this.cb_borrar=create cb_borrar
this.cb_insertat=create cb_insertat
this.dw_desubi=create dw_desubi
this.gb_3=create gb_3
this.dw_preparacion=create dw_preparacion
this.dw_conubi=create dw_conubi
this.dw_pedidos=create dw_pedidos
this.dw_des=create dw_des
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_pedido
this.Control[iCurrent+3]=this.em_pedido
this.Control[iCurrent+4]=this.st_anyo
this.Control[iCurrent+5]=this.em_anyo
this.Control[iCurrent+6]=this.st_etiqueta_operario
this.Control[iCurrent+7]=this.sle_operario
this.Control[iCurrent+8]=this.sle_operario_nombre
this.Control[iCurrent+9]=this.cb_salir
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.uo_almacen
this.Control[iCurrent+12]=this.cb_preparar
this.Control[iCurrent+13]=this.dw_proceso
this.Control[iCurrent+14]=this.dw_movhis
this.Control[iCurrent+15]=this.dw_proceso_ubi
this.Control[iCurrent+16]=this.dw_almlinubicahis
this.Control[iCurrent+17]=this.cb_continuar
this.Control[iCurrent+18]=this.cb_stock
this.Control[iCurrent+19]=this.cb_borrar_pedido
this.Control[iCurrent+20]=this.dw_detalle
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.cb_modificar
this.Control[iCurrent+23]=this.st_fecha
this.Control[iCurrent+24]=this.st_cliente
this.Control[iCurrent+25]=this.st_1
this.Control[iCurrent+26]=this.uo_cliente
this.Control[iCurrent+27]=this.pb_imprimir
this.Control[iCurrent+28]=this.cb_procesar
this.Control[iCurrent+29]=this.cb_3
this.Control[iCurrent+30]=this.cb_borrar
this.Control[iCurrent+31]=this.cb_insertat
this.Control[iCurrent+32]=this.dw_desubi
this.Control[iCurrent+33]=this.gb_3
this.Control[iCurrent+34]=this.dw_preparacion
this.Control[iCurrent+35]=this.dw_conubi
this.Control[iCurrent+36]=this.dw_pedidos
this.Control[iCurrent+37]=this.dw_des
this.Control[iCurrent+38]=this.dw_consulta
end on

on w_int_preparacion_pedido_exportacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_pedido)
destroy(this.em_pedido)
destroy(this.st_anyo)
destroy(this.em_anyo)
destroy(this.st_etiqueta_operario)
destroy(this.sle_operario)
destroy(this.sle_operario_nombre)
destroy(this.cb_salir)
destroy(this.gb_2)
destroy(this.uo_almacen)
destroy(this.cb_preparar)
destroy(this.dw_proceso)
destroy(this.dw_movhis)
destroy(this.dw_proceso_ubi)
destroy(this.dw_almlinubicahis)
destroy(this.cb_continuar)
destroy(this.cb_stock)
destroy(this.cb_borrar_pedido)
destroy(this.dw_detalle)
destroy(this.gb_1)
destroy(this.cb_modificar)
destroy(this.st_fecha)
destroy(this.st_cliente)
destroy(this.st_1)
destroy(this.uo_cliente)
destroy(this.pb_imprimir)
destroy(this.cb_procesar)
destroy(this.cb_3)
destroy(this.cb_borrar)
destroy(this.cb_insertat)
destroy(this.dw_desubi)
destroy(this.gb_3)
destroy(this.dw_preparacion)
destroy(this.dw_conubi)
destroy(this.dw_pedidos)
destroy(this.dw_des)
destroy(this.dw_consulta)
end on

event close;call super::close;IF bloqueado = "S" Then
longitud     =  len(trim(codigo_empresa))
criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
longitud     =  len(Trim(em_anyo.text))
criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
longitud     =  len(Trim(em_pedido.text))
criterio[3]  =  trim(em_pedido.text)+space(20-longitud)
seleccion    =  criterio[1]+criterio[2]+criterio[3]
tabla        = "venped"
f_desbloquear(tabla,seleccion,titulo)
bloqueado = "N"
COMMIT;
END IF
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_consulta)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_consulta)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_consulta)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_cursor_arriba(dw_consulta)
end event

event activate;call super::activate;w_int_preparacion_pedido_exportacion = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_preparacion_pedido_exportacion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_preparacion_pedido_exportacion
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_pedido)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_preparacion_pedido_exportacion
end type

type pb_1 from upb_salir within w_int_preparacion_pedido_exportacion
integer x = 3529
integer y = 32
integer width = 123
integer height = 108
integer taborder = 0
end type

event clicked;IF cb_salir.visible = TRUE Then
	cb_salir.TriggerEvent(Clicked!)
ELSE
	CALL Super::Clicked
END IF

end event

type st_pedido from statictext within w_int_preparacion_pedido_exportacion
integer x = 590
integer y = 144
integer width = 59
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_int_preparacion_pedido_exportacion
integer x = 640
integer y = 148
integer height = 76
integer taborder = 10
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pedidos"
ue_datawindow = "dw_ayuda_preparacion_pedidos"
ue_filtro     = " venped_anyo  =  " + em_anyo.text

pb_1.cancel = True
cb_salir.cancel = False

end event

type st_anyo from statictext within w_int_preparacion_pedido_exportacion
integer x = 101
integer y = 152
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pedido"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_preparacion_pedido_exportacion
integer x = 352
integer y = 148
integer width = 233
integer height = 76
integer taborder = 0
boolean bringtotop = true
end type

type st_etiqueta_operario from statictext within w_int_preparacion_pedido_exportacion
integer x = 91
integer y = 1864
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_operario from singlelineedit within w_int_preparacion_pedido_exportacion
integer x = 375
integer y = 1864
integer width = 187
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_operario_nombre from singlelineedit within w_int_preparacion_pedido_exportacion
integer x = 562
integer y = 1864
integer width = 603
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type cb_salir from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 2144
integer y = 1368
integer width = 352
integer height = 64
integer taborder = 0
string text = "Esc Salir"
boolean cancel = true
end type

event clicked;dw_consulta.reset()
dw_consulta.enabled = FALSE
em_anyo.enabled = TRUE
em_pedido.enabled = TRUE
longitud     =  len(trim(codigo_empresa))
criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
longitud     =  len(Trim(em_anyo.text))
criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
longitud     =  len(Trim(em_pedido.text))
criterio[3]  =  trim(em_pedido.text)+space(20-longitud)
seleccion    =  criterio[1]+criterio[2]+criterio[3]
tabla        = "venped"
f_desbloquear(tabla,seleccion,titulo)
bloqueado = "N"
COMMIT;
This.visible = False

pb_1.enabled = TRUE
cb_continuar.enabled  = TRUE
uo_cliente.em_campo.enabled = TRUE
st_1.enabled = TRUE
pb_imprimir.enabled = TRUE
cb_preparar.visible  = FALSE
cb_preparar.enabled  = FALSE	
cb_borrar_pedido.visible  = FALSE
cb_stock.visible  = FALSE	
cb_borrar_pedido.enabled  = FALSE
cb_stock.enabled  = FALSE	
cb_modificar.visible  = FALSE	

IF var_conexion = "S" Then
	CloseWithReturn(Parent, "S")
  ELSE
	f_activar_campo(em_pedido)
END IF

end event

type gb_2 from groupbox within w_int_preparacion_pedido_exportacion
integer x = 78
integer y = 1832
integer width = 1102
integer height = 116
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_almacen from u_em_campo_2 within w_int_preparacion_pedido_exportacion
integer x = 1193
integer y = 1864
integer width = 558
integer height = 72
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_almacen.em_campo.text=f_nombre_almacen_abr(codigo_empresa,uo_almacen.em_codigo.text)

IF Trim(uo_almacen.em_campo.text)="" THEN 
 IF Trim(uo_almacen.em_codigo.text)<>"" Then uo_almacen.em_campo.SetFocus()
 uo_almacen.em_campo.text=""
 uo_almacen.em_codigo.text=""
END IF

codigo_almacen = uo_almacen.em_codigo.text 
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de almacenes"
ue_datawindow = "dw_ayuda_almacenes"
ue_filtro     = ""
end event

on uo_almacen.destroy
call u_em_campo_2::destroy
end on

type cb_preparar from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 2501
integer y = 1300
integer width = 343
integer height = 132
integer taborder = 0
boolean bringtotop = true
string text = "F5 Preparar"
end type

event clicked;Integer total_reg,numero,registro,fila,altura,calibre,pallets,pico,linea,conta
String  preparado,calidad,nombre_operario,cod_operario,articulo,familia,control_pico,tipo_pallet,tipo_unidad,referencia,ubicacion,tono,aux_observaciones
Dec{2}  metros,unidades,pedido,cantidad,disponible,aux_existencias,aux_unidades,diferencia,diferencia2,aux_unidades2
Long    var_hornos
String  sel,aux_obs1,aux_obs2

dw_consulta.AcceptText()
registro  = dw_consulta.GetRow()

DataStore d
If registro  =  0 Then  Return

preparado       =  dw_consulta.GetItemString(registro,"preparado")
articulo        =  dw_consulta.GetItemString(registro,"articulo")
calidad         =  dw_consulta.GetItemString(registro,"calidad")
tono            =  dw_consulta.GetItemString(registro,"tono")
calibre         =  dw_consulta.GetItemNumber(registro,"calibre")
tipo_pallet     =  dw_consulta.GetItemString(registro,"tipo_pallet")
var_articulo    =  articulo
var_tipo_pallet =  tipo_pallet
tipo_unidad     =  f_unidad_articulo(codigo_empresa,articulo)
referencia      =  f_componer_ref(articulo,calidad,tono,calibre)
anyo            =  dw_consulta.GetItemNumber(registro,"anyo")
pedido          =  dw_consulta.GetItemNumber(registro,"pedido")
linea           =  dw_consulta.GetItemNumber(registro,"linea")
var_hornos      =  dw_consulta.GetItemNumber(registro,"hornos")

SELECT count(*)   INTO :numero     FROM almlincargas  
WHERE almlincargas.empresa = :codigo_empresa 
AND   almlincargas.anyo_ped = :anyo 
AND   almlincargas.pedido = :pedido 
AND   almlincargas.linea_ped = :linea;

if IsNull(numero) Then numero = 0

IF numero <> 0 Then 
	If MessageBox("Existen Ordenes a esta linea","La orden se borrar ¿Desea Continuar?",Question!,YesNo!)= 2 Then
		Return
	END IF
END IF
//// Santiago 22/03/01			
////-- Rev COnt--(frank)
//IF preparado = "S" Then
//		// santiago. Control del disponible solo si no hay mov. automáticos
//		if not f_busca_mov(articulo) then
//			//-----------------------------------------------//
//			//----------- Control Disponible ----------------//
//			//-----------------------------------------------//
//			Select venliped.cantidad Into :cantidad From venliped
//			WHERE  venliped.empresa  =  :codigo_empresa 
//			AND    venliped.anyo     =  :anyo 
//			AND    venliped.pedido   =  :pedido 
//			AND    venliped.linea    =  :linea;
//			
//			disponible = f_disponible_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
//							 
//			IF f_unidad_articulo(codigo_empresa,articulo) = "1" Then
//				cantidad = metros -  cantidad
//			ELSE
//				cantidad = unidades - cantidad
//			END IF
//			IF disponible < cantidad Then 				 
//				f_mensaje("No se puede modificar la linea","No Hay suficiente disponible")
//				Return
//			END IF
//		end if
//END IF
//// Santiago 22/03/01			

// Empieza el proceso//
//-------------------//
dw_preparacion.reset()
SetNull(codigo_altura)
SetNull(codigo_fila)
SetNull(codigo_pico)
SetNull(codigo_operario)

f_calculo_linea(dw_consulta.GetRow())

fila            =  dw_consulta.GetItemNumber(registro,"fila")
altura          =  dw_consulta.GetItemNumber(registro,"altura")
tono            =  dw_consulta.GetItemString(registro,"tono")
calibre         =  dw_consulta.GetItemNumber(registro,"calibre")
articulo        =  dw_consulta.GetItemString(registro,"articulo")
pico            =  dw_consulta.GetItemNumber(registro,"pico")
tipo_pallet     =  dw_consulta.GetItemString(registro,"tipo_pallet")
var_articulo    = articulo
var_tipo_pallet = tipo_pallet
var_tipo_pallet_entrada = dw_consulta.GetItemString(registro,"tipo_pallet_entrada")
var_caja        =  dw_consulta.GetItemString(registro,"caja")
calidad         =  dw_consulta.GetItemString(registro,"calidad")
metros          =  dw_consulta.GetItemNumber(registro,"metros")
unidades        =  dw_consulta.GetItemNumber(registro,"unidades")

SELECT articulos.familia,articulos.formato,articulos.modelo,   
       articulos.unidad,articulos.sector  
INTO :var_familia,   
     :var_formato,   
     :var_modelo,   
     :var_tipo_unidad,   
     :var_sector  
FROM articulos  
WHERE ( articulos.empresa = :codigo_empresa ) AND  
      ( articulos.codigo = :articulo )   ;

familia      = var_familia
tipo_unidad  = var_tipo_unidad

IF preparado = "S" Then
   // para DES_prepararar un material
   f_des_activa()
	if f_busca_mov(articulo) then
		// Hemos encontrado un mov. automático
		if not f_grabar_salida_regularizacion(unidades) then 
			f_mensaje("Error","NO se ha despreparado el movimiento automático en almacén")
			return
		end if
		f_procesar_desubi2()
	else
		dw_desubi.Reset()
		f_despreparar()
	end if
   dw_consulta.SetItem(registro,"npalet","")
   dw_consulta.SetItem(registro,"hornos",0)
   Return
Else	
	IF tipo_pallet = "2" and dw_consulta.GetItemString(registro,"es_pico")= "S" Then
	   IF MessageBox("Preparación pico","El pico se prepara en Pallet Normal? ",Question!,YesNo!,1)	=1 Then var_tipo_pallet_entrada = "1"
	END IF
END IF	

// Para preparar un material
If IsNull(altura)   then  altura   = 0
If IsNull(tono)     then  tono     = "0"
If IsNull(calibre)  then  calibre  = 0
If IsNull(metros)   then  metros   = 0
If IsNull(unidades) then  unidades = 0
 
cod_operario    = dw_consulta.GetItemString(registro,"operario")
nombre_operario = f_nombre_almoperarios_abr(codigo_empresa,cod_operario)
 
If Trim(cod_operario) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el operario")
	dw_consulta.SetColumn("operario")
	dw_consulta.SetFocus()
	Return
END IF	
  
If dw_consulta.GetItemString(registro,"es_pico")= "S" Then
	IF dw_consulta.GetItemNumber(registro,"pallets") > 1 and Not IsNull(dw_consulta.GetItemNumber(registro,"pallets")) Then
		f_mensaje("Error en Introducion de datos","Linea de picos solo puede tener un pallet")
		dw_consulta.SetColumn("pallets")
		dw_consulta.SetFocus()
		Return
   END IF	
END IF

If Trim(nombre_operario) = "" Then
		f_mensaje("Campo Obligatorio","El operario no existe")
   	dw_consulta.SetColumn("operario")
		dw_consulta.SetFocus()
		Return
END IF	
 
IF Not f_ubi_exist(codigo_empresa,codigo_almacen,codigo_zona,fila,altura)Then
		f_mensaje("Camp Obligatorio","Esta ubicacion no esta contemplada en el mapa de ubicaciones")
		dw_consulta.SetColumn("fila")
		dw_consulta.SetFocus()
		Return
End If	
  
if f_sector_articulo(codigo_empresa,articulo)="S" then
		 IF f_control_tono_artcal(codigo_empresa,articulo,calidad )  Then
			 If tono = "" Then
				 f_mensaje("Campo Obligatorio","Introduzca el tono")
				 dw_consulta.SetColumn("tono")
				 dw_consulta.SetFocus()
				 Return
			  END IF	
		 END IF
		 IF f_control_calibre_artcal(codigo_empresa,articulo,calidad)  Then
			 If calibre = 0 Then
				 f_mensaje("Campo Obligatorio","Introduzca el calibre")
				 dw_consulta.SetColumn("calibre")
				 dw_consulta.SetFocus()
				 Return
			  END IF	
		 END IF
		 control_pico = dw_consulta.GetItemString(registro,"es_pico")
		 pallets = dw_consulta.GetItemnumber(registro,"pallets")
		 IF IsNull(pallets) Then pallets = 0
			  IF control_pico = "S" then
				 If pico =0 or IsNull(pico)  Then
					 f_mensaje("Campo Obligatorio","Introduzca del pico")
					 dw_consulta.SetColumn("pico")
					 dw_consulta.SetFocus()
					 Return
				  END IF	
		 END IF	  
			 
		 IF control_pico = "S" then
			 If pallets >1 Then
				 f_mensaje("Error en introduccion de datos","No pueden ser mas de un pallet en picos")
				 dw_consulta.SetColumn("pallets")
				 dw_consulta.SetFocus()
				 Return
			  END IF	
		 END IF	  
			 
		 IF tipo_unidad = "1" then
			 If metros = 0 then
				 f_mensaje("Campo Obligatorio","Introduzca los metros")
				 dw_consulta.SetColumn("metros")
				 dw_consulta.SetFocus()
				 Return
			  END IF
		 END IF	  
			
		 IF tipo_unidad = "0" then
			 If unidades = 0 then
				 f_mensaje("Campo Obligatorio","Introduzca las unidades")
				 dw_consulta.SetColumn("unidades")
				 dw_consulta.SetFocus()
				 Return
			  END IF
		 END IF
			
		 IF Trim(f_nombre_pallet_abr(codigo_empresa,tipo_pallet)) = "" Then tipo_pallet = ""
		 IF Trim(f_nombre_calidad_abr(codigo_empresa,calidad))    = "" Then calidad = ""
			
		 If Trim(tipo_pallet) = ""  or IsNull(tipo_pallet) Then
			f_mensaje("Campo Obligatorio","Introduzca el tipo de pallet")
			dw_consulta.SetColumn("tipo_pallet")
			dw_consulta.SetFocus()
			Return
		 END IF	
		  
		 If Trim(calidad) = ""  or IsNull(calidad) Then
			f_mensaje("Campo Obligatorio","Introduzca la calidad")
			dw_consulta.SetColumn("calidad")
			dw_consulta.SetFocus()
			Return
		 END IF	
End if

referencia = f_componer_ref(articulo,calidad,tono,calibre)

if var_hornos <> 0 then
	 // Santiago. 29/11/00. Movimientos automáticos en almacén DESDE HORNOS
	 if var_hornos <> unidades then
		 f_mensaje("Distinta cantidad","Hay distinta cantidad en unidades a preparar y en hornos")
		 dw_consulta.SetColumn("unidades")
		 dw_consulta.SetFocus()
		 Return
	 end if
	 f_mensaje("HORNOS","Se realizará un movimiento automático en almacén")
	 aux_observaciones = "Automático HORNOS "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
	 if not f_grabar_entrada_regularizacion3(var_hornos) then 
		 f_mensaje("Error","NO se ha realizado el movimiento automático de HORNOS en almacén")
		 return
	 end if
	 // Volvemos a hacer el proceso de selección para seguir con la preparación
	 Sel = " SELECT almlinubica.*   FROM almlinubica  " +&
	 " WHERE almlinubica.empresa     ='"+codigo_empresa +"'" +&
	 " AND   almlinubica.referencia  ='" +referencia    +"'" +&
	 " AND   almlinubica.pedido  is null" +&
	 " Order by zona,altura,fila"

//	 d= f_cargar_cursor(sel)
	 f_cargar_cursor_nuevo(sel, d)
	 
	 total_reg = d.RowCOunt()
	 // Santiago. 29/11/00. Movimientos automáticos en almacén DESDE HORNOS
else
	// Santiago.25/10/00
	// Primero miro si hay stock en las ubicaciones
	Sel = " SELECT almlinubica.*   FROM almlinubica  " +&
	" WHERE almlinubica.empresa     ='"+codigo_empresa +"'" +&
	" AND   almlinubica.referencia  ='" +referencia    +"'" +&
	" AND   almlinubica.pedido  is null "
	
	//d= f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel,d)
	
	total_reg = d.RowCOunt()
	IF total_reg =0 THEN
		f_mensaje("NO HAY STOCK","Se realizará un movimiento automático en almacén")
		aux_observaciones = "Automático SIN STOCK "+trim(em_anyo.text)+trim(em_pedido.text)+trim(string(dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea"),"####"))+trim(nombre_usuario)
		if not f_grabar_entrada_regularizacion() then 
		   f_mensaje("Error","NO se ha realizar el movimiento automático en almacén")
			return
		end if
		// Volvemos a hacer el proceso de selección para seguir con la preparación
		Sel = " SELECT almlinubica.*   FROM almlinubica  " +&
		" WHERE almlinubica.empresa     ='"+codigo_empresa +"'" +&
		" AND   almlinubica.referencia  ='" +referencia    +"'" +&
		" AND   almlinubica.pedido is null" +&
		" Order by zona,fila,altura"
		
		//d= f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, d)
		
		total_reg = d.RowCOunt()
		// Santiago. 16/10/00. Movimientos automáticos en almacén si no hay disponible
	END IF
END IF

conta = 0
For numero = 1 To total_reg
	IF d.GetItemString(numero,"externo") = "S" Then
	  conta= conta +1
	  dw_preparacion.InsertRow(conta)
	  ubicacion   = d.GetItemString(numero,"ubicacion")
	  linea       = d.GetItemNumber(numero,"linea")
	  dw_preparacion.SetItem(conta,"empresa",codigo_empresa)
	  dw_preparacion.SetItem(conta,"almacen",d.GetItemString(numero,"almacen"))
	  dw_preparacion.SetItem(conta,"zona",d.GetItemString(numero,"zona"))
	  dw_preparacion.SetItem(conta,"fila",d.GetItemNumber(numero,"fila"))		  
	  dw_preparacion.SetItem(conta,"altura",d.GetItemNumber(numero,"altura"))		  
	  dw_preparacion.SetItem(conta,"tipo_unidad",d.GetItemString(numero,"tipo_unidad"))		  
	  dw_preparacion.SetItem(conta,"tipo_pallet",d.GetItemString(numero,"tipo_pallet"))		  
	  dw_preparacion.SetItem(conta,"cantidad",d.GetItemNumber(numero,"existencias"))		  
	  dw_preparacion.SetItem(conta,"ubicacion",d.GetItemString(numero,"ubicacion"))
	  dw_preparacion.SetItem(conta,"linea",d.GetItemNumber(numero,"linea"))
	  
	  IF d.GetItemString(numero,"tipo_unidad") = "1" Then
		  dw_preparacion.SetItem(conta,"cantidad_marcada",dw_consulta.GetItemNumber(registro,"metros"))		  
		  dw_preparacion.SetItem(conta,"total_pedido",dw_consulta.GetItemNumber(registro,"metros"))		  
	  ELSE
		  dw_preparacion.SetItem(conta,"cantidad_marcada",dw_consulta.GetItemNumber(registro,"unidades"))		  
		  dw_preparacion.SetItem(conta,"total_pedido",dw_consulta.GetItemNumber(registro,"unidades"))		  
	  END IF
	  dw_preparacion.SetItem(conta,"situacion","")
	END IF
Next	  

IF dw_preparacion.RowCount() = 0 Then
	 f_mensaje("No Existe Disponible","No hay suficiente stock o esta en almacen regulador.")
	 dw_consulta.SetColumn("tono")
	 dw_consulta.SetFocus()
	 Return
END IF		 
f_des_activa()		
dw_preparacion.visible   = TRUE
dw_preparacion.SetFocus()
dw_preparacion.SetRow(1)
dw_preparacion.SetColumn("cantidad_marcada")

dw_consulta.SetColumn("operario")
dw_consulta.SetFocus()

destroy d
end event

type dw_proceso from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer width = 110
integer height = 156
boolean bringtotop = true
string dataobject = "dw_proceso_venliped"
borderstyle borderstyle = styleraised!
end type

type dw_movhis from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 357
integer width = 155
integer height = 140
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubicahis"
boolean livescroll = true
end type

type dw_proceso_ubi from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 608
integer y = 8
integer width = 155
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type dw_almlinubicahis from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 503
integer y = 4
integer width = 96
integer height = 152
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubicahis"
boolean livescroll = true
end type

type cb_continuar from u_boton within w_int_preparacion_pedido_exportacion
integer x = 901
integer y = 148
integer width = 325
integer height = 76
integer taborder = 20
string text = "&Continuar"
end type

event clicked; f_control()

end event

type cb_stock from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
integer x = 1847
integer y = 1808
integer width = 375
integer height = 64
integer taborder = 0
boolean enabled = false
string text = "&Ver stock"
end type

event clicked;call super::clicked;IF This.enabled = False Then Return
dw_consulta.SetFocus()
dw_consulta.SetColumn("operario")
IF f_valor_columna(dw_consulta,dw_consulta.GetRow(),"preparado") = "S" Then
	f_mensaje("No se puede asignar tono o calibre","La linea preparada no se manipular, ¡Despreparar!")
	Return
END IF
Integer e_tono,e_calibre
String  e_tipo_pallet,e_articulo,e_calidad
IF This.enabled = FALSE Then RETURN
str_parametros str
str_parametros valores
e_articulo    = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"articulo")
e_calidad     = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"calidad")
e_tipo_pallet = f_valor_columna(dw_consulta,dw_consulta.GetRow(),"tipo_pallet")
str.s_argumentos[1]= "w_int_venliped"
str.s_argumentos[2]= e_articulo 
str.s_argumentos[3]= e_calidad
//str.s_argumentos[6]= e_tipo_pallet

str.i_nargumentos = 6
OpenWithParm(w_con_stock_articulos,str)
       IF Message.DoubleParm=-1  THEN 
			Return
       ELSE
          valores       = Message.PowerObjectParm
          e_articulo    = valores.s_argumentos[1]
	   	 e_calidad     = valores.s_argumentos[2]
		    e_tono        = Dec(valores.s_argumentos[3])
		    e_calibre     = Dec(valores.s_argumentos[4])
          e_tipo_pallet = valores.s_argumentos[5]
        END IF
   
	 f_asignar_columna(dw_consulta,dw_consulta.GetRow(),"articulo",e_articulo)
    f_asignar_columna(dw_consulta,dw_consulta.GetRow(),"calidad",e_calidad)
    f_asignar_columna(dw_consulta,dw_consulta.GetRow(),"tono",String(e_tono))
	 f_asignar_columna(dw_consulta,dw_consulta.GetRow(),"calibre",String(e_calibre))
	 f_asignar_columna(dw_consulta,dw_consulta.GetRow(),"tipo_pallet",e_tipo_pallet)

end event

type cb_borrar_pedido from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
integer x = 2222
integer y = 1808
integer width = 352
integer height = 64
integer taborder = 0
boolean enabled = false
string text = "Borrar Ln"
end type

event clicked;call super::clicked;Dec{0} e_pedido,e_anyo,e_linea,var_bien,lineas
var_bien = 0
dw_consulta.SetColumn("operario")
IF f_valor_columna(dw_consulta,dw_consulta.GetRow(),"preparado") = "S" Then
	f_mensaje("No se puede borrar la linea","La linea preparada no se manipular, ¡Despreparar!")
	Return
END IF

IF This.enabled = False Then Return
IF MessageBox("Proceso de borrado linea de pedido","¿Desea Borrar la linea de pedido?",Question!,YesNo!) = 1 Then
	e_pedido = Dec(em_pedido.text)
	e_anyo   = Dec(em_anyo.text)
	e_linea  = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"linea")
	
	// Si hay lineas en ordenes nos avisara
	Select count(*) into :lineas  From    almlincargas  
	WHERE   almlincargas.empresa    = :codigo_empresa
	AND     almlincargas.anyo_ped   = :e_anyo
	AND     almlincargas.pedido     = :e_pedido
	AND     almlincargas.linea_ped  = :e_linea;

	if lineas<>0 then
	   IF MessageBox("Borrado lineas en ordenes","El proceso borrara "+sTring(lineas,'###')+" linea/s en ordenes,¿Desea continuar?",Question!,YesNo!) = 2 Then Return
	End if
		
	dw_consulta.DeleteRow(dw_consulta.GetRow())

	Delete from   venliped
	Where  venliped.empresa = :codigo_empresa
	And    venliped.anyo    = :e_anyo
	And    venliped.pedido  = :e_pedido
	And    venliped.linea   = :e_linea;
	IF sqlca.sqlcode <> 0 then bien = 1
   IF Not(f_borrar_ordenes(codigo_empresa,e_anyo,e_pedido,e_linea))   Then 
		f_mensaje("Error","al borrar ordenes")
		bien = 1
	END IF
	IF Not f_actualizar_venpedido(codigo_empresa,e_anyo,e_pedido)    Then
		bien = 1
		f_mensaje("Error","al actualizar el pedido")
	END IF
   IF bien = 0 Then
		COMMIT;
	ELSE
		f_mensaje("Error",sqlca.sqlerrtext)
		ROLLBACK;
	END IF
ELSE
	Return
END IF


end event

type dw_detalle from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 773
integer y = 4
integer width = 110
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_venliped"
boolean livescroll = true
end type

type gb_1 from groupbox within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 1760
integer y = 1264
integer width = 1097
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_modificar from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
integer x = 1847
integer y = 1876
integer width = 375
integer height = 64
integer taborder = 0
boolean bringtotop = true
string text = "&Desdoblar"
end type

event clicked;Dec    total_reg,numero,registro,fila,altura,calibre,pallets,pico,linea,cantidad_desglose,vcan,vanyo,vorden
String preparado,calidad,nombre_operario,cod_operario,articulo,familia,control_pico,tipo_pallet,tipo_unidad,referencia,ubicacion,texto,situacion,tono,cadena,caja,vnumpalet,var_cliente,estado,idioma_aux
Dec    metros,unidades,cajas,total_cajas,var_anyo,cantidad,pedido,disponible,cantidda,cantidad_anterior,cantidad_pedido,cantidad_a_preparar
int    opcion

registro  = dw_consulta.GetRow()
dw_consulta.AcceptText()

estado =  dw_consulta.GetItemString(registro,"preparado")
if estado = "S" then
	messagebox("Atención","La línea está preparada")
	return
end if

var_tipo_pallet_entrada = dw_consulta.GetItemString(registro,"tipo_pallet_entrada")
pallets = dw_consulta.GetItemnumber(registro,"pallets")
IF IsNull(pallets) Then pallets = 0

articulo        =  dw_consulta.GetItemString(registro,"articulo")
caja				 =  dw_consulta.GetItemString(registro,"caja")
calidad         =  dw_consulta.GetItemString(registro,"calidad")
tono            =  dw_consulta.GetItemString(registro,"tono")
calibre         =  dw_consulta.GetItemNumber(registro,"calibre")
pico            =  dw_consulta.GetItemNumber(registro,"pico")
tipo_pallet     =  dw_consulta.GetItemString(registro,"tipo_pallet")
var_articulo    =  articulo
var_tipo_pallet =  tipo_pallet
tipo_unidad     =  f_unidad_articulo(codigo_empresa,articulo)
referencia      =  f_componer_ref(articulo,calidad,tono,calibre)
anyo            =  dw_consulta.GetItemNumber(registro,"anyo")
pedido          =  dw_consulta.GetItemNumber(registro,"pedido")
linea           =  dw_consulta.GetItemNumber(registro,"linea")
idioma_aux      =  dw_consulta.GetItemString(registro,"idioma")
if tipo_unidad = "1" then
	metros   =  dw_consulta.GetItemNumber(registro,"metros")
	cantidad_a_preparar = metros
else
	unidades =  dw_consulta.GetItemNumber(registro,"unidades")
	cantidad_a_preparar = unidades
end if
		
Select venliped.cantidad,venliped.situacion,venliped.numpalet,venliped.cliente
Into  :cantidad_pedido,:ante_situ,:vnumpalet,:var_cliente
From   venliped
WHERE  venliped.empresa  =  :codigo_empresa 
AND    venliped.anyo     =  :anyo 
AND    venliped.pedido   =  :pedido 
AND    venliped.linea    =  :linea;
IF SQLCA.SQLCODE = 100 Then 
	f_mensaje("Error en datos"," No existe linea de pedido")
End If
texto = ""		

Select count(*) Into :numero From almlincargas
Where  almlincargas.empresa    = :codigo_empresa
And    almlincargas.anyo_ped   = :anyo
And    almlincargas.pedido     = :pedido
And    almlincargas.linea_ped  = :linea;
IF IsNull(numero) Then numero = 0

CHOOSE CASE numero
	CASE 1
      Select cantidad,anyo,orden Into :vcan,:vanyo,:vorden From almlincargas
		Where  almlincargas.empresa    = :codigo_empresa
		And    almlincargas.anyo_ped   = :anyo
		And    almlincargas.pedido     = :pedido
		And    almlincargas.linea_ped  = :linea;
		IF vcan = cantidad_anterior Then
			IF f_orden_impresa_sn(codigo_empresa,vanyo,vorden)  Then
					texto = "Orden : " +STring(vorden,"######") + " Listada (será modificada)"
			End IF
		ELSE
			texto = "Orden : " +STring(vorden,"######")+ "(Será eliminada)"
		END IF
	CASE 0
   CASE ELSE
		texto = "Existen varias ordenes a esta linea de pedido (Serán eliminadas)"		
END CHOOSE

IF TRIM(texto) <> "" Then
	f_mensaje("Control ordenes",texto)
END IF

if f_sector_articulo(codigo_empresa,articulo)="S" then
	  IF situacion <>"F" THEN
			IF f_control_tono_artcal(codigo_empresa,articulo,calidad) Then
				 If tono = "" Then
					 f_mensaje("Campo Obligatorio","Introduzca el tono")
					 dw_consulta.SetColumn("tono")
					 dw_consulta.SetFocus()
					 Return
				  END IF	
			END IF
	
			IF f_control_calibre_artcal(codigo_empresa,articulo,calidad) Then
				 If calibre = 0 Then
					 f_mensaje("Campo Obligatorio","Introduzca el calibre")
					 dw_consulta.SetColumn("calibre")
					 dw_consulta.SetFocus()
					 Return
				  END IF	
			END IF
	  END IF
End if

IF control_pico = "S" then
 If pallets >1 Then
	 f_mensaje("Error en introduccion de datos","No pueden ser mas de un pallet en picos")
	 dw_consulta.SetColumn("pallets")
	 dw_consulta.SetFocus()
	 Return
  END IF	
END IF	  
	 
IF tipo_unidad = "1" then
 If metros = 0 then
	 f_mensaje("Campo Obligatorio","Introduzca los metros")
	 dw_consulta.SetColumn("metros")
	 dw_consulta.SetFocus()
	 Return
  END IF
END IF	  
		
IF tipo_unidad = "0" then
 If unidades = 0 then
	 f_mensaje("Campo Obligatorio","Introduzca las unidades")
	 dw_consulta.SetColumn("unidades")
	 dw_consulta.SetFocus()
	 Return
  END IF
END IF
IF Trim(f_nombre_pallet_abr(codigo_empresa,tipo_pallet)) = "" Then tipo_pallet = ""
IF Trim(f_nombre_calidad_abr(codigo_empresa,calidad))    = "" Then calidad = ""
	 
if f_sector_articulo(codigo_empresa,articulo)="S" then
	If Trim(calidad) = ""  or IsNull(calidad) Then
		f_mensaje("Campo Obligatorio","Introduzca la calidad")
		dw_consulta.SetColumn("calidad")
		dw_consulta.SetFocus()
		Return
	END IF	
End if

// Santiago. 23/03/01. Nueva forma de desdoblar líneas
dw_consulta.enabled = FALSE
f_des_activa()
cb_modificar.enabled = FALSE
dw_des.insertrow(1)
dw_des.setitem(1,"empresa",codigo_empresa)
dw_des.setitem(1,"cliente",var_cliente)
dw_des.setitem(1,"linea_pedido",linea)
dw_des.setitem(1,"pedido",pedido)
dw_des.setitem(1,"anyo",anyo)
dw_des.setitem(1,"articulo",articulo)
dw_des.setitem(1,"situacion",ante_situ)
dw_des.setitem(1,"linea",1)
dw_des.setitem(1,"cant_pedido",cantidad_pedido)
dw_des.setitem(1,"cant_original",cantidad_a_preparar)
dw_des.setitem(1,"cant_desdoblada",cantidad_a_preparar)
dw_des.setitem(1,"numpalet",vnumpalet)
dw_des.setitem(1,"ubicacion","")
dw_des.setitem(1,"idioma",idioma_aux)
dw_des.ScrollToRow(1)
dw_des.SetColumn("cant_desdoblada")
dw_des.visible = TRUE
end event

type st_fecha from statictext within w_int_preparacion_pedido_exportacion
integer x = 2487
integer y = 148
integer width = 366
integer height = 76
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

type st_cliente from statictext within w_int_preparacion_pedido_exportacion
integer x = 1230
integer y = 148
integer width = 1253
integer height = 76
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

type st_1 from statictext within w_int_preparacion_pedido_exportacion
integer x = 901
integer y = 228
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Pedidos Cliente:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;STring cli1,cli2
IF Trim(uo_cliente.em_codigo.text) = "" Then
	cli1 = "."
	cli2 = "Z"
ELSE
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF
dw_pedidos.SetTransObject(SQLCA)
IF dw_pedidos.Retrieve(codigo_empresa,cli1,cli2) <> 0 Then
	dw_pedidos.visible = TRUE
END IF
end event

type uo_cliente from u_em_campo_2 within w_int_preparacion_pedido_exportacion
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1431
integer y = 228
integer width = 1298
integer height = 80
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

type pb_imprimir from upb_imprimir within w_int_preparacion_pedido_exportacion
integer x = 2729
integer y = 228
integer width = 96
integer height = 80
integer taborder = 30
boolean originalsize = false
end type

event clicked;call super::clicked;str_parametros lstr_param

 // control de imprimir
 Integer veces
 veces = f_veces_venped(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
 if veces>0 then
	 if f_nivel_usuario(nombre_usuario)<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Usted no tiene acceso para volver a imprimirlo.")
		 f_activar_campo(em_pedido)
		 Return
	End if
END IF

 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=em_pedido.text
 f_activar_campo(em_pedido)
 OpenWithParm(w_list_preparacion_pedido,lstr_param)

end event

type cb_procesar from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 1371
integer y = 784
integer width = 457
integer height = 84
integer taborder = 0
string text = "&Procesar"
end type

event clicked;Long donde

donde = dw_consulta.GetRow()

dw_desubi.AcceptTExt()
IF Not f_bloquear_almacen(w_int_preparacion_pedido_exportacion.title) Then
	f_procesar_desubi()
	dw_consulta.Setfocus()
	dw_consulta.SetRow(donde)
	dw_consulta.ScrollToRow(donde)
	dw_consulta.SetSort("empresa,nombre_formato,nombre_articulo")
	dw_consulta.Setcolumn("operario")
	f_desbloquear_almacen(w_int_preparacion_pedido_exportacion.title)
END IF
end event

type cb_3 from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 923
integer y = 784
integer width = 448
integer height = 84
integer taborder = 0
string text = "&Salir"
end type

event clicked;Long donde

donde = dw_consulta.GetRow()

cb_borrar.visible    = FALSE
cb_procesar.visible  = FALSE
cb_3.visible         = FALSE
cb_insertat.visible  = FALSE
dw_consulta.enabled  = TRUE
dw_desubi.visible    = FALSE
dw_conubi.visible    = FALSE
pb_1.enabled         = TRUE
cb_stock.enabled     = TRUE
cb_salir.enabled     = TRUE
cb_preparar.enabled  = TRUE
cb_modificar.enabled  = TRUE
cb_borrar_pedido.enabled = TRUE
pb_imprimir.enabled  = True
dw_consulta.Setfocus()
dw_consulta.SetRow(donde)
dw_consulta.ScrollToRow(donde)
dw_consulta.Setcolumn("operario")
dw_consulta.SetSort("empresa,nombre_formato,nombre_articulo")


end event

type cb_borrar from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 471
integer y = 784
integer width = 453
integer height = 84
integer taborder = 0
string text = "&Borrar"
end type

event clicked;call super::clicked;integer fila,cont 

fila=dw_desubi.getrow()
IF fila >1 THEN
    cont=fila - 1
Else
	cont = 1
	IF dw_desubi.RowCOunt() = 0 Then cont = 0
END IF
IF fila<>0 THEN
 dw_desubi.DeleteRow(dw_desubi.getRow())
 dw_desubi.setrowfocusIndicator(Hand!)
 dw_desubi.SetColumn("almacen")
 IF cont <> 0 Then
 	dw_desubi.setRow(cont)
 END IF
 dw_desubi.setfocus()
END IF


end event

type cb_insertat from u_boton within w_int_preparacion_pedido_exportacion
event clicked pbm_bnclicked
boolean visible = false
integer x = 9
integer y = 784
integer width = 462
integer height = 84
integer taborder = 0
string text = "&Insertar"
end type

event clicked;integer numero,controles,cont
Dec{2} total_pendiente,total_cantidad
String ante_almacen
string mensaje,nombre,campo,caja
controles=0
cont=dw_desubi.Rowcount()
var_articulo = f_valor_columna(dw_consulta,dw_consulta.getRow(),"articulo")
caja = f_valor_columna(dw_consulta,dw_consulta.getRow(),"caja")
dw_desubi.Accepttext()
IF cont<>0 THEN
 v_almacen  = dw_desubi.GetItemString(cont,"almacen")	
 v_zona     = dw_desubi.GetItemString(cont,"zona")	
 v_fila     = dw_desubi.GetItemNumber(cont,"fila")	
 v_altura   = dw_desubi.GetItemNumber(cont,"altura")	
 v_cantidad = dw_desubi.GetItemDecimal(cont,"cantidad")	
 dw_desubi.SetItem(cont,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,var_articulo,caja,v_cantidad))
 v_cantidad = dw_desubi.GetItemDecimal(cont,"cantidad")	

 
 IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
  controles=1
  campo="almacen"
  mensaje=" Introduzca el almacen " 
 END IF

 
 IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
  controles=1
  campo="zona"
  mensaje=" Introduzca la zona "
 END IF
 IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
  controles=1
  campo="fila"
  mensaje= "Introduzca la fila de la ubicacion"
 END IF
 IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
  controles=1
  campo="altura"
  mensaje= "Introduzca la altura de la ubicacion"
 END IF
 IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
  controles=1
  campo="cantidad"
  mensaje= "Introduzca la cantidad"
 END IF

 nombre=f_nombre_almacen(codigo_empresa,v_almacen)
 IF (trim(nombre)="") and controles=0 THEN
   mensaje="El almacen no existe "
   controles=1
   campo="almacen"
 END IF

 nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
 IF (trim(nombre)="") and controles=0 THEN
    mensaje="La zona no existe"
    controles=1
    campo="zona"
 END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

 IF controles=1 THEN
  MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
  dw_desubi.SetColumn(campo)
  dw_desubi.setRow(cont)
  dw_desubi.setfocus()
  Return
 END IF
END IF

cont=cont+1
dw_desubi.InsertRow(cont)

total_cantidad   = dw_desubi.GetItemNumber(1,"total_cantidad")
total_pendiente = dec(f_valor_columna(dw_proceso,dw_proceso.GetRow(),"cantidad"))-total_cantidad
dw_desubi.setitem(cont,"cantidad",total_pendiente)
dw_desubi.setitem(cont,"empresa",codigo_empresa)
dw_desubi.setitem(1,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,var_articulo))
IF cont > 1 THEN
    dw_desubi.setitem(cont,"almacen",v_almacen)
END  IF

dw_desubi.setrowfocusIndicator(Hand!)
IF cont=1 THEN
  dw_desubi.SetColumn("almacen")
ELSE
dw_desubi.SetColumn("zona")
END IF
dw_desubi.setRow(cont)
dw_desubi.setfocus()





end event

type dw_desubi from u_datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 9
integer y = 312
integer width = 1819
integer height = 472
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_int_preparacion_pedido3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;dw_desubi.AcceptText()
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "tipo_pallet"
	   String articulo
		articulo = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
		valor_empresa = TRUE
		bus_titulo     = "Ayuda seleccion de pallets"
      bus_datawindow = "dw_ayuda_almartpallets_abr"
      bus_filtro     = "almartpallet_articulo = '" + articulo+ "'"
	CASE "almacen"
		valor_empresa = TRUE
      bus_titulo    = "VENTANA SELECCION DE TIPO DE ALMACEN "
      bus_filtro    = ""
		bus_datawindow  = "dw_ayuda_almacenes"
   CASE "zona"
	   valor_empresa  = TRUE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ZONA "
 		bus_datawindow =  "dw_ayuda_almubizonas"
      bus_filtro     = "almacen='" + This.GetItemString(This.GetRow(),"almacen") + "'"
CASE "cantidad"
   // Redondeo a cantidad 
//   var_cantidad = dw_desubi.GetItemNumber(dw_desubi.GetRow(),"cantidad")
//   dw_desubi.SetItem(dw_desubi.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,var_articulo,var_caja,var_cantidad))
	SetNull(bus_campo)
            
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF
end event

event rbuttondown;dw_desubi.AcceptText()
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "tipo_pallet"
	   String articulo
		articulo = dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")
		valor_empresa = TRUE
		bus_titulo     = "Ayuda seleccion de pallets"
      bus_datawindow = "dw_ayuda_almartpallets_abr"
      bus_filtro     = "almartpallet_articulo = '" + articulo+ "'"
	CASE "almacen"
		valor_empresa = TRUE
      bus_titulo    = "VENTANA SELECCION DE TIPO DE ALMACEN "
      bus_filtro            = ""
		bus_datawindow  = "dw_ayuda_almacenes"
	CASE "zona"
	   valor_empresa = TRUE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ZONA "
 		bus_datawindow   =  "dw_ayuda_almubizonas"
      bus_filtro            = "almacen='" + &
                                   This.GetItemString(This.GetRow(),"almacen") + "'"
CASE "cantidad"
   // Redondeo a cantidad 
//     var_cantidad = dw_desubi.GetItemNumber(dw_desubi.GetRow(),"cantidad")
//   dw_desubi.SetItem(dw_desubi.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,var_articulo,var_caja,var_cantidad))
	SetNull(bus_campo)
            
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type gb_3 from groupbox within w_int_preparacion_pedido_exportacion
integer x = 1184
integer y = 1804
integer width = 585
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Almacen"
end type

type dw_preparacion from datawindow within w_int_preparacion_pedido_exportacion
event key pbm_dwnkey
boolean visible = false
integer x = 1829
integer y = 312
integer width = 1371
integer height = 680
string dataobject = "dw_int_preparacion_pedido2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;
IF key = KeyF5! Then 
	This.Accepttext()
	String cadena
	Long posi,posi_aux
	IF This.GetRow() <> 0 Then
	   cadena=f_calculo_unidades(codigo_empresa,var_articulo,var_tipo_pallet,var_caja,&
                                 0,0,This.getItemNumber(This.GetRow(),"cantidad_marcada"))
                       
     posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			This.SetItem(This.GetRow(),"cantidad_marcada",round(dec(Mid(cadena,posi_aux,posi - posi_aux)),0))
			posi_aux = posi + 1
		end if
	END IF
	This.Accepttext()
	f_procesar()
	END IF
IF key = KeyEscape! Then f_salir2()

end event

event rowfocuschanged;String situacion
IF currentRow = 0 Then Return
situacion = dw_preparacion.GetItemString(currentrow,"situacion") 
IF Trim(situacion)= "" or IsNull(situacion)  Then
	 dw_preparacion.SetTabOrder("cantidad_marcada",10)
Else
    dw_preparacion.SetTabOrder("cantidad_marcada",0)
END IF
f_resto()
end event

event clicked;This.Accepttext()
String cadena
Long   posi,posi_aux

IF This.GetRow() <> 0 Then
   cadena=f_calculo_unidades(codigo_empresa,var_articulo,var_tipo_pallet,var_caja,&
                                 0,0,This.getItemNumber(This.GetRow(),"cantidad_marcada"))
	posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			This.SetItem(This.GetRow(),"cantidad_marcada",round(dec(Mid(cadena,posi_aux,posi - posi_aux)),0))
			posi_aux = posi + 1
		end if
                       
     
END IF
This.Accepttext()
If dwo.name ="proceso" Then f_procesar()
IF dwo.name= "salir"   Then f_salir2()
end event

event itemfocuschanged;String cadena
dec  cant
Long posi,posi_aux

This.Accepttext()
IF This.GetRow() <> 0 Then
	cant = This.getItemNumber(This.GetRow(),"cantidad_marcada")
   cadena=f_calculo_unidades(codigo_empresa,var_articulo,var_tipo_pallet,var_caja,&
                                0,0,cant)
   posi_aux = 1
		posi = pos(cadena,"|",1)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <> 0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			posi_aux = posi + 1
		end if
		
		posi = pos(cadena,"|",posi_aux)
		if posi <>0 then
			This.SetItem(This.GetRow(),"cantidad_marcada",round(dec(Mid(cadena,posi_aux,posi - posi_aux)),0))
			posi_aux = posi + 1
		end if
END IF
This.Accepttext()
end event

type dw_conubi from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 1829
integer y = 312
integer width = 1033
integer height = 556
string dataobject = "dw_int_preparacion_pedido4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if row=0 then return
If dw_desubi.GetRow() <> 1 Then Return
String e_almacen,e_zona,tp
Dec{0} e_fila,e_altura
IF dw_desubi.GetRow() <> 0 Then
	
	e_almacen = f_valor_columna(This,row,"almacen")
	e_zona    = f_valor_columna(This,row,"zona")
	e_fila    = Dec(f_valor_columna(This,row,"fila"))
	e_altura  = Dec(f_valor_columna(This,row,"altura"))
	tp  = f_valor_columna(This,row,"tipo_pallet")
	
	f_asignar_columna(dw_desubi,dw_desubi.GetRow(),"almacen",e_almacen)
	f_asignar_columna(dw_desubi,dw_desubi.GetRow(),"tipo_pallet",tp)
	f_asignar_columna(dw_desubi,dw_desubi.GetRow(),"zona",e_zona)
	f_asignar_columna(dw_desubi,dw_desubi.GetRow(),"fila",String(e_fila))
	f_asignar_columna(dw_desubi,dw_desubi.GetRow(),"altura",String(e_altura))
	dw_desubi.SetFocus()
	dw_desubi.SetRow(dw_desubi.GetRow())
	dw_desubi.SetColumn("almacen")
	
END IF


end event

type dw_pedidos from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 489
integer y = 232
integer width = 2240
integer height = 708
integer taborder = 40
string dataobject = "dw_int_preparacion_pedido5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 Then Return
em_anyo.text    = String(GetItemNumber(row,"anyo"),"####")
em_pedido.text  = String(GetItemNumber(row,"pedido"),"####")
Reset()
Visible = FALSE
f_activar_campo(em_pedido)
end event

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	Reset()
	This.visible = FALSE
	f_activar_campo(em_pedido)
END IF
end event

type dw_des from datawindow within w_int_preparacion_pedido_exportacion
boolean visible = false
integer x = 649
integer y = 320
integer width = 1920
integer height = 960
integer taborder = 50
boolean titlebar = true
string title = "Desdoblar Líneas"
string dataobject = "dw_desdoblar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Long   donde,i,total,registro,anyo_aux,pedido,linea,linea_aux,var_linea_max,cantidad_aux,var_original,var_desdoblada,var_cantidad_pedido,cant_total
String var_situ,var_cliente,articulo_aux,tipo_unidad,idioma_aux

IF f_objeto_datawindow(This) = "salir" or f_objeto_datawindow(This) = "ok" Then
	if f_objeto_datawindow(This) = "ok" then
		dw_des.AcceptText()
		registro     = dw_consulta.GetRow()	
		anyo_aux     = dw_consulta.GetItemNumber(registro,"anyo")
		pedido       = dw_consulta.GetItemNumber(registro,"pedido")
		linea        = dw_consulta.GetItemNumber(registro,"linea")
		articulo_aux = dw_consulta.GetItemString(registro,"articulo")
		idioma_aux   = dw_consulta.GetItemString(registro,"idioma")
		tipo_unidad  = f_unidad_articulo(codigo_empresa,articulo_aux) 
		if tipo_unidad = "1" then
			var_original = dw_consulta.GetItemNumber(registro,"metros")
		else
			var_original = dw_consulta.GetItemNumber(registro,"unidades")
		end if
			
		Select venliped.situacion,venliped.cliente,venliped.cantidad
		Into   :var_situ,:var_cliente,:var_cantidad_pedido
		From   venliped
		WHERE  venliped.empresa  =  :codigo_empresa 
		AND    venliped.anyo     =  :anyo_aux 
		AND    venliped.pedido   =  :pedido 
		AND    venliped.linea    =  :linea;
		IF SQLCA.SQLCODE = 100 Then 
			f_mensaje("Error en datos"," No existe linea de pedido")
			dw_des.SetRow(1)
		End If
		cant_total = 0
		for i = 1 to dw_des.RowCount()
			cant_total = cant_total + dw_des.GetItemNumber(i,"cant_desdoblada")
		next
		if cant_total > var_original then
			messagebox("Atención","Hay demasiada cantidad")
			return
		end if
		linea_aux = 0
		var_linea_max = 0
		cantidad_aux = 0
		for i = 1 to dw_des.RowCount()
			linea_aux = dw_des.GetItemNumber(i,"linea")
			if linea_aux > var_linea_max then
				var_linea_max = linea_aux
			end if
			cantidad_aux = cantidad_aux + dw_des.GetItemNumber(i,"cant_desdoblada")
		next
		var_linea_max  = var_linea_max + 1
		var_desdoblada = var_original - cantidad_aux
		if var_desdoblada > 0 then
			donde = This.insertrow(0)
			dw_des.SetItem(donde,"empresa",codigo_empresa)
			dw_des.SetItem(donde,"cliente",var_cliente)
			dw_des.SetItem(donde,"anyo",anyo_aux)
			dw_des.SetItem(donde,"pedido",pedido)
			dw_des.SetItem(donde,"linea_pedido",linea)
			dw_des.SetItem(donde,"articulo",articulo_aux)
			dw_des.SetItem(donde,"situacion",var_situ)
			dw_des.SetItem(donde,"linea",var_linea_max)
			dw_des.SetItem(donde,"cant_pedido",var_cantidad_pedido)
			dw_des.SetItem(donde,"cant_original",var_original)
			dw_des.SetItem(donde,"cant_desdoblada",var_desdoblada)
			dw_des.SetItem(donde,"numpalet",0)
			dw_des.SetItem(donde,"ubicacion","")
			dw_des.SetItem(donde,"idioma",idioma_aux)
		end if
		for i = 1 to dw_des.RowCount()
			f_desdoblar_nueva(i)
		next
		dw_consulta.visible = False
		dw_consulta.reset()
		procesando = "S"
		f_cargar()
		dw_consulta.SetSort("")
		dw_consulta.SetSort("empresa,nombre_formato,nombre_articulo")
		dw_consulta.Sort()
		dw_consulta.visible = TRUE
		f_cambio_linea(registro)
		dw_consulta.setrow(registro)
		dw_consulta.scrolltorow(registro)
		procesando = "N"
	end if
	This.visible = FALSE
	This.Reset()
	cb_modificar.enabled 	 = TRUE
	cb_preparar.enabled      = TRUE
	cb_salir.enabled         = TRUE
	cb_stock.enabled         = TRUE
	cb_borrar_pedido.enabled = TRUE
	dw_consulta.enabled      = TRUE
	em_anyo.enabled          = TRUE
	em_pedido.enabled        = TRUE
	pb_1.enabled             = TRUE
	pb_imprimir.enabled 		 = TRUE
	dw_consulta.visible      = TRUE
END IF
IF f_objeto_datawindow(This) = "insertar" Then
	registro  = dw_consulta.GetRow()	
	anyo_aux  =  dw_consulta.GetItemNumber(registro,"anyo")
	pedido    =  dw_consulta.GetItemNumber(registro,"pedido")
	linea     =  dw_consulta.GetItemNumber(registro,"linea")
	articulo_aux = dw_consulta.GetItemString(registro,"articulo")
	tipo_unidad  = f_unidad_articulo(codigo_empresa,articulo_aux) 
	idioma_aux  = dw_consulta.GetItemString(registro,"idioma")
	if tipo_unidad = "1" then
		var_original = dw_consulta.GetItemNumber(registro,"metros")
	else
		var_original = dw_consulta.GetItemNumber(registro,"unidades")
	end if	
	
	Select venliped.situacion,venliped.cliente,venliped.cantidad
	Into   :var_situ,:var_cliente,:var_cantidad_pedido
	From   venliped
	WHERE  venliped.empresa  =  :codigo_empresa 
	AND    venliped.anyo     =  :anyo_aux 
	AND    venliped.pedido   =  :pedido 
	AND    venliped.linea    =  :linea;
	IF SQLCA.SQLCODE = 100 Then 
		f_mensaje("Error en datos"," No existe linea de pedido")
	End If
	linea_aux = 0
	var_linea_max = 0
	cantidad_aux = 0
	for i = 1 to dw_des.RowCount()
		linea_aux = dw_des.GetItemNumber(i,"linea")
		if linea_aux > var_linea_max then
			var_linea_max = linea_aux
		end if
		cantidad_aux = cantidad_aux + dw_des.GetItemNumber(i,"cant_desdoblada")
	next
	var_linea_max  = var_linea_max + 1
	var_desdoblada = var_original - cantidad_aux
	if var_desdoblada > 0 then
		donde = This.insertrow(0)
		dw_des.SetItem(donde,"empresa",codigo_empresa)
		dw_des.SetItem(donde,"cliente",var_cliente)
		dw_des.SetItem(donde,"anyo",anyo_aux)
		dw_des.SetItem(donde,"pedido",pedido)
		dw_des.SetItem(donde,"linea_pedido",linea)
		dw_des.SetItem(donde,"articulo",articulo_aux)
		dw_des.SetItem(donde,"situacion",var_situ)
		dw_des.SetItem(donde,"linea",var_linea_max)
		dw_des.SetItem(donde,"cant_pedido",var_cantidad_pedido)
		dw_des.SetItem(donde,"cant_original",var_original)
		dw_des.SetItem(donde,"cant_desdoblada",var_desdoblada)
		dw_des.SetItem(donde,"numpalet",0)
		dw_des.SetItem(donde,"ubicacion","")
		dw_des.SetItem(donde,"idioma",idioma_aux)
		dw_des.SetRow(donde)
		dw_des.ScrollToRow(donde)
		dw_des.SetColumn("cant_desdoblada")
	end if
END IF
IF f_objeto_datawindow(This) = "borrar" Then
	donde = dw_des.Getrow()
	dw_des.deleterow(donde)
END IF
end event

type dw_consulta from u_datawindow within w_int_preparacion_pedido_exportacion
integer x = 9
integer y = 316
integer width = 3630
integer height = 1472
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_int_preparacion_pedido1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event key;IF Key = Keyf5! Then cb_preparar.TriggerEvent(Clicked!)
 bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "operario"
      bus_titulo     = "VENTANA SELECCION DE OPERARIOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_operarios"
	CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_calidades"		 
	CASE "tipo_pallet_entrada"
      bus_titulo     = "VENTANA SELECCION DE PALLETS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_pallets"		 		 
  	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 


end event

event rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "operario"
      bus_titulo     = "VENTANA SELECCION DE OPERARIOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_operarios"
	CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_calidades"		 
	CASE "tipo_pallet_entrada"
      bus_titulo     = "VENTANA SELECCION DE PALLETS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_pallets"		 		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 


end event

event rowfocuschanged;call super::rowfocuschanged;String  var_operario,preparado
Dec{0}  var_altura,var_fila,var_pico,r

IF procesando = "S" Then Return
If currentrow = 0   Then Return
if rowcount() = 0   Then Return
r = currentrow - 1
IF r = 0 Then Return

preparado    = dw_consulta.GetItemString(currentrow,"preparado")
var_es_pico  = dw_consulta.GetItemString(currentrow,"es_pico")
IF preparado = "N" Then
		var_operario =	  dw_consulta.GetItemString(currentrow,"operario")
	   var_altura   =	  dw_consulta.GetItemNumber(currentrow,"altura")
	   var_fila     =	  dw_consulta.GetItemNumber(currentrow,"fila")
	   var_pico     =	  dw_consulta.GetItemNumber(currentrow,"pico")
		var_es_pico  =	  dw_consulta.GetItemString(currentrow,"es_pico")
		
		codigo_operario =	  dw_consulta.GetItemString(r,"operario")
	   codigo_altura   =	  dw_consulta.GetItemNumber(r,"altura")
	   codigo_fila     =	  dw_consulta.GetItemNumber(r,"fila")
		codigo_pico  =	  dw_consulta.GetItemDecimal(r,"pico")
	   IF Trim(codigo_operario) <> "" and Not isNull(codigo_operario) Then
			IF Trim(var_operario) = "" or  isNull(var_operario) Then
 			  dw_consulta.SetItem(currentrow,"operario",codigo_operario)
	   	END IF 
	   END IF
		IF codigo_altura <> 0 and Not isNull(codigo_altura) Then
			IF var_altura = 0 or  isNull(var_altura) Then
			  dw_consulta.SetItem(currentrow,"altura",codigo_altura)
   		END IF
	   END IF
		IF codigo_fila <> 0 and Not isNull(codigo_fila) Then
			IF var_fila = 0 or  isNull(var_fila) Then
			  dw_consulta.SetItem(currentrow,"fila",codigo_fila)
			END IF
	   END IF
		If var_es_pico = "S" Then
   		IF codigo_pico <> 0 and Not isNull(codigo_pico) Then
				if var_pico = 0 or  isNull(var_pico) Then
		   	  dw_consulta.SetItem(currentrow,"pico",codigo_pico)
			END IF 
	      END IF
   	END IF
END IF
 
IF f_unidad_articulo(codigo_empresa,dw_consulta.GetItemString(dw_consulta.GetRow(),"articulo")) = "1" Then
	ante_cantidad = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"metros")
ELSE
	ante_cantidad = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"unidades")
END IF
ante_cajas          = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"cajas")
ante_pallets        = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"pallets")
ante_numpalet       = dw_consulta.GetItemNumber(dw_consulta.GetRow(),"npalet")
IF IsNUll(ante_pallets)  Then ante_pallets  = 0
IF IsNUll(ante_cajas)    Then ante_cajas    = 0
IF IsNUll(ante_cantidad) Then ante_cantidad = 0
IF IsNUll(ante_numpalet) Then ante_numpalet = 0
IF GetRow() <> 0 Then f_cambio_linea(GetRow())
end event

event itemfocuschanged;call super::itemfocuschanged;AcceptText()
IF GetRow() = 0 Then Return
if rowcount()=0 then return
if isnull(row) or row=0 then return
f_calculo_linea(row)
f_cambio_linea(row)

end event

