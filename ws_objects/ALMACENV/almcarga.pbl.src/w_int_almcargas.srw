$PBExportHeader$w_int_almcargas.srw
forward
global type w_int_almcargas from wc_mantenimientos_tab
end type
type dw_ref from u_datawindow within pagina_1
end type
type dw_pedidos from u_datawindow_consultas within pagina_2
end type
type dw_lineas from u_datawindow_consultas within pagina_3
end type
type dw_pack from u_datawindow_consultas within pagina_4
end type
type uo_cliente from u_em_campo_2 within pagina_5
end type
type st_3 from statictext within pagina_5
end type
type dw_consulta from datawindow within pagina_5
end type
type pb_calculadora from u_calculadora within w_int_almcargas
end type
type pb_imprimir from upb_imprimir within w_int_almcargas
end type
type dw_report from datawindow within w_int_almcargas
end type
type gb_1 from groupbox within w_int_almcargas
end type
type cb_grabar from u_boton within w_int_almcargas
end type
type dw_proceso from datawindow within w_int_almcargas
end type
type em_anyo from u_em_campo within w_int_almcargas
end type
type em_referencia from u_em_campo within w_int_almcargas
end type
type st_2 from statictext within w_int_almcargas
end type
type dw_bandas from datawindow within w_int_almcargas
end type
type st_10 from statictext within w_int_almcargas
end type
type st_11 from statictext within w_int_almcargas
end type
type st_13 from statictext within w_int_almcargas
end type
type st_cantidad from statictext within w_int_almcargas
end type
type em_pallets from u_em_campo within w_int_almcargas
end type
type em_cajas from u_em_campo within w_int_almcargas
end type
type em_t_cajas from u_em_campo within w_int_almcargas
end type
type em_cantidad from u_em_campo within w_int_almcargas
end type
type st_20 from statictext within w_int_almcargas
end type
type st_21 from statictext within w_int_almcargas
end type
type st_22 from statictext within w_int_almcargas
end type
type em_peso_linea from u_em_campo within w_int_almcargas
end type
type em_peso_carga from u_em_campo within w_int_almcargas
end type
type em_peso_maximo from u_em_campo within w_int_almcargas
end type
type dw_packing from datawindow within w_int_almcargas
end type
type cb_todo from u_boton within w_int_almcargas
end type
type st_f2 from statictext within w_int_almcargas
end type
type st_6 from statictext within w_int_almcargas
end type
end forward

global type w_int_almcargas from wc_mantenimientos_tab
integer width = 2962
integer height = 1760
pb_calculadora pb_calculadora
pb_imprimir pb_imprimir
dw_report dw_report
gb_1 gb_1
cb_grabar cb_grabar
dw_proceso dw_proceso
em_anyo em_anyo
em_referencia em_referencia
st_2 st_2
dw_bandas dw_bandas
st_10 st_10
st_11 st_11
st_13 st_13
st_cantidad st_cantidad
em_pallets em_pallets
em_cajas em_cajas
em_t_cajas em_t_cajas
em_cantidad em_cantidad
st_20 st_20
st_21 st_21
st_22 st_22
em_peso_linea em_peso_linea
em_peso_carga em_peso_carga
em_peso_maximo em_peso_maximo
dw_packing dw_packing
cb_todo cb_todo
st_f2 st_f2
st_6 st_6
end type
global w_int_almcargas w_int_almcargas

type variables
Dec{2} ante_valor,linea_cantidad
String var_articulo,var_tipo_pallet,var_referencia,var_calidad,var_ubicacion,var_situacion
Dec{0}  var_pedido,var_linea_pedido,var_anyo_ped
String acceso,var_cliente
STring control_peso = "S"
end variables

forward prototypes
public subroutine f_campos (boolean bol)
public subroutine f_peso_linea ()
public subroutine f_grabar_picos (string empresa, decimal anyo, decimal pedido, integer pico)
public subroutine f_renumerar ()
public subroutine f_bandas ()
public subroutine f_marcar ()
public subroutine f_packing ()
public subroutine f_grabar_picos_todos (string empresa, decimal anyo, decimal pedido, integer pico)
public subroutine f_contador_ref ()
public subroutine f_renumerar_nuevo ()
end prototypes

public subroutine f_campos (boolean bol);	em_cajas.visible = bol
	em_cantidad.visible = bol
	em_pallets.visible = bol
	em_t_cajas.visible = bol
   em_peso_carga.visible = bol
	em_peso_linea.visible = bol
	em_peso_maximo.visible = bol
	st_10.visible = bol
	st_11.visible = bol
	st_13.visible = bol
	st_20.visible = bol
	st_21.visible = bol
	st_22.visible = bol
	st_cantidad.visible = bol
	cb_grabar.visible = bol
	cb_todo.visible = bol
	
IF bol Then	
 	em_peso_maximo.text =	String(f_pesomaximo_almcargaref(codigo_empresa, dec(em_anyo.text) ,f_valor_columna(dw_pag1,1,"cliente"),em_referencia.text),f_mascara_decimales(2))
	em_peso_carga.text  =   String(f_peso_bruto_almlincarga_matricula(codigo_empresa, dec(em_anyo.text) ,f_matricula_almcargas(codigo_empresa,Dec(em_anyo.text), Dec(sle_valor.text))),f_mascara_decimales(2))
END IF
end subroutine

public subroutine f_peso_linea ();String var_caja

if apartados.pagina_2.dw_pedidos.GetRow() > 0 then
	var_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"venliped_caja")
	em_peso_linea.text    = String(f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,Dec(em_cajas.text),Dec(em_t_cajas.text),Dec(em_pallets.text),Dec(em_cantidad.text),var_caja),f_mascara_decimales(2))
end if
end subroutine

public subroutine f_grabar_picos (string empresa, decimal anyo, decimal pedido, integer pico);Dec{4} var_anyo,var_orden,var_linea,var_linea_ped,var_pallets,var_calibre,var_cajas,var_total_cajas,var_cantidad,var_cantidad_ped,var_peso_bruto,var_peso_neto
String var_matricula,var_montajeartcal,var_tipo_unidad,var_usuario,&
  ubicacion1,var_es_pico,var_formato,var_situacion_pedido,var_sector,&
  var_caja,var_tono
Datetime var_fcarga,var_fecha_ped,var_forden
Integer registro,registros,var_numero_pico
registros = apartados.pagina_2.dw_pedidos.RowCount()
For registro  = 1 To registros
	var_pedido         = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"pedido"))
	var_anyo_ped       = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"anyo"))
	var_numero_pico    = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_numero_pico"))
	var_situacion_pedido = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_situacion")
	var_es_pico = "S"
	IF  anyo = var_anyo_ped and pedido=var_pedido and pico= var_numero_pico Then
		var_linea_ped = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"linea"))
		var_linea_pedido = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"linea"))
		var_situacion = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_situacion")
		var_anyo  = Dec(em_anyo.text)
		var_orden = Dec(sle_valor.text)
	Select Max(linea) Into :var_linea From almlincargas
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    orden   = :var_orden;
	iF IsNull(var_linea) Then var_linea = 0
	var_linea         = var_linea + 1
	var_articulo      = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"articulo")
	var_tipo_pallet   = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_tipo_pallet")
	var_caja          = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_caja")	
	var_calidad       = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"calidad")
	var_formato       = f_formato_articulo(codigo_empresa,var_articulo)
	var_referencia    = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"referencia")
	var_matricula     = f_valor_columna(dw_pag1,1,"matricula")
	var_cliente       = f_valor_columna(dw_pag1,1,"cliente")
	var_fcarga        = apartados.pagina_1.dw_ref.GetItemDateTime(1,"fcarga")
	var_forden        = dw_pag1.GetItemDateTime(1,"forden")
	var_fecha_ped     = apartados.pagina_2.dw_pedidos.getItemDatetime(registro,"fpedido")
	var_montajeartcal = f_componer_artcal(var_articulo,var_calidad)
	var_tono          = Trim(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"tonochar"))
	var_calibre       = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"calibre"))
	var_referencia    = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)   
	var_cajas         = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cajas"))
	var_total_cajas   = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"total_cajas"))
	var_cantidad      = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cantidad"))
	var_cantidad_ped  = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cantidad"))
	var_tipo_unidad   = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_tipo_unidad")
	var_usuario       = nombre_usuario
	var_pallets       = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"pallets"))
	var_sector = f_sector_articulo(codigo_empresa,var_articulo)
	if var_sector = "S" then
		var_peso_bruto                = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,var_cajas,var_total_cajas,var_pallets,var_cantidad,var_caja)
		var_peso_neto                 = f_calculo_peso_neto(codigo_empresa,var_articulo,var_cajas,var_total_cajas,var_cantidad,var_caja)
	else
		var_peso_bruto = 0
		var_peso_neto  = 0
	End if
	INSERT INTO almlincargas  
         ( empresa,   
           anyo,   
           orden,   
           linea,   
           matricula,   
           cliente,   
           fcarga,   
           anyo_ped,   
           pedido,   
           linea_ped,   
           fecha_ped,   
           articulo,   
           calidad,   
           montajeartcal,   
           tonochar,   
           calibre,   
           referencia,   
           tipo_pallet,   
           cajas,   
           total_cajas,   
           cantidad,   
           cantidad_ped,   
           tipo_unidad,   
           ubicacion,   
           usuario,   
           paldesde,   
           palhasta,   
           pallets,
			  peso_bruto,
			  peso_neto,
			  pico,
			  es_pico,
			  formato,
			  forden,
			  parcial,
			  imp_bandas,
			  marcado,
			  situacion_pedido,
			  caja)  
  VALUES ( :codigo_empresa,   
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
	        null,   
           :var_usuario,   
           null,   
           null,   
           :var_pallets,
  			  :var_peso_bruto,
			  :var_peso_neto,
			  :var_numero_pico,
			  :var_es_pico,
			  :var_formato,
			  :var_forden,
			  "N",
			  "N",
			  null,
			  :var_situacion_pedido,
			  :var_caja);

COMMIT;
END IF
Next
apartados.pagina_2.dw_pedidos.SetREDraw(FALSE)
apartados.pagina_2.dw_pedidos.SetReDraw(TRUE)
apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_2.dw_pedidos.triggerEvent(RowFocusChanged!)
end subroutine

public subroutine f_renumerar ();Integer registros,v_paldesde,v_palhasta,registro,v_pallets,anterior,v_pico,v_pico_ant
String  v_articulo,v_tipo_pallet,v_caja
Dec{4}  v_cantidad,acumulado
apartados.pagina_4.dw_pack.SetRedraw(FALSE)
registros = apartados.pagina_4.dw_pack.RowCOunt()
IF registros = 0 Then return
acumulado =0
anterior = 1
For registro     = 1 To registros
	v_pico    = Dec(f_valor_columna(apartados.pagina_4.dw_pack,registro,"almlincargas_pico"))
	iF IsNull(v_pico) Then v_pico = 0 
	
	v_articulo    = f_valor_columna(apartados.pagina_4.dw_pack,registro,"articulo")
	v_tipo_pallet = f_valor_columna(apartados.pagina_4.dw_pack,registro,"tipo_pallet")
	v_caja        = f_valor_columna(apartados.pagina_4.dw_pack,registro,"almlincargas_caja")	
	v_cantidad    = Dec(f_valor_columna(apartados.pagina_4.dw_pack,registro,"cantidad"))
	v_pallets     = f_calculo_pallets(codigo_empresa,v_articulo,v_tipo_pallet,v_caja,v_cantidad)
	iF IsNull(v_pallets)  or v_pallets = 0 Then v_pallets = 1
	IF v_pico <> 0 and v_pico = v_pico_ant Then v_pallets = 0
	acumulado = acumulado + v_pallets

	v_palhasta     = acumulado
	IF v_pallets = 0 then
		v_paldesde     = anterior 
	ELSE
		v_paldesde     = anterior + 1
	END IF
	iF registro = 1 Then v_paldesde = 1
	f_asignar_columna(apartados.pagina_4.dw_pack,registro,"paldesde",String(v_paldesde))
	f_asignar_columna(apartados.pagina_4.dw_pack,registro,"palhasta",String(v_palhasta))
	anterior = acumulado
	v_pico_ant = v_pico
next
apartados.pagina_4.dw_pack.SetRedraw(TRUE)
end subroutine

public subroutine f_bandas ();Integer registro,registros,reg,desde,hasta,bul,var_divisor
Dec{0}  var_anyo,var_orden,var_linea
String v_pais,v_ciudad,v_nombre_pais,v_razon,v_observaciones
dw_bandas.Reset()
dw_bandas.SetRedraw (FALSE)
dw_bandas.enabled =FALSE
var_anyo  = Dec(f_valor_columna(dw_pag1,1,"anyo"))
var_orden = Dec(f_valor_columna(dw_pag1,1,"orden"))

String var_matricula,var_bulto,ante_bulto,ante_bulto2,var_bulto2

var_cliente     = f_valor_columna(dw_pag1,1,"cliente")
v_observaciones = apartados.pagina_1.dw_ref.GetItemString(1,"observaciones_bandas")

var_matricula = f_valor_columna(dw_pag1,1,"matricula")
SetNull(ante_bulto)
reg = 0
registros = apartados.pagina_4.dw_pack.RowCount()
For registro = 1 To registros
	IF f_valor_columna(apartados.pagina_4.dw_pack,registro,"marcado")="X" Then
		var_bulto = f_valor_columna(apartados.pagina_4.dw_pack,registro,"paldesde")
		var_bulto2 = f_valor_columna(apartados.pagina_4.dw_pack,registro,"palhasta")
		IF ISNULL(ante_bulto)  or ante_bulto <> var_bulto Then 
	   	desde = dec(var_bulto)
		   hasta = dec(var_bulto2)
		   var_divisor = (hasta - desde) + 1
	   	For bul = desde To hasta
		     reg = reg +1
			  dw_bandas.InsertRow(reg)		
		Next
	END IF
	ante_bulto = var_bulto
	ante_bulto2 = var_bulto2
END IF
Next

v_razon    = f_valor_columna(apartados.pagina_1.dw_ref,1,"nombanda")
v_ciudad   = f_valor_columna(apartados.pagina_1.dw_ref,1,"pobbanda")
v_nombre_pais     = f_valor_columna(apartados.pagina_1.dw_ref,1,"paisbanda")

SetNull(ante_bulto)
reg = 0
For registro = 1 To registros
	IF f_valor_columna(apartados.pagina_4.dw_pack,registro,"marcado")="X" Then
		var_bulto  = f_valor_columna(apartados.pagina_4.dw_pack,registro,"paldesde")
		var_bulto2 = f_valor_columna(apartados.pagina_4.dw_pack,registro,"palhasta")
		IF ISNULL(ante_bulto)  or ante_bulto <> var_bulto Then 
		
	   	desde = dec(var_bulto)
		   hasta = dec(var_bulto2)
		   var_divisor = (hasta - desde) + 1
	   	For bul = desde To hasta
		     reg = reg +1
		     //dw_bandas.InsertRow(reg)		
		     f_asignar_columna(dw_bandas,reg,"empresa",codigo_empresa)
			  f_asignar_columna(dw_bandas,reg,"cliente",var_cliente)
			  f_asignar_columna(dw_bandas,reg,"ciudad",v_ciudad)
			  f_asignar_columna(dw_bandas,reg,"nombre_pais",v_nombre_pais)
			  f_asignar_columna(dw_bandas,reg,"razon",v_razon)
			  //f_asignar_columna(dw_bandas,reg,"pais",v_pais)
			  f_asignar_columna(dw_bandas,reg,"referencia",var_matricula)
			  f_asignar_columna(dw_bandas,reg,"bulto",String(bul))
			  f_asignar_columna(dw_bandas,reg,"paldesde",String(desde))
			  f_asignar_columna(dw_bandas,reg,"palhasta",String(hasta))
			  f_asignar_columna(dw_bandas,reg,"anyo",String(var_anyo))
			  f_asignar_columna(dw_bandas,reg,"orden",String(var_orden))
			  f_asignar_columna(dw_bandas,reg,"divisor",String(var_divisor))
			  f_asignar_columna(dw_bandas,reg,"observaciones",v_observaciones)
	      Next
	END IF
	ante_bulto = var_bulto
	ante_bulto2 = var_bulto2
 END IF
NEXT
dw_bandas.InsertRow(1)
dw_bandas.DeleteRow(1)
dw_bandas.SetRedraw (TRUE)
dw_bandas.enabled =TRUE


IF reg <> 0 Then
	   IF f_imprimir_datawindow(dw_bandas) Then
	   For registro = 1 To registros
	      IF f_valor_columna(apartados.pagina_4.dw_pack,registro,"marcado")="X" Then
		
      	   var_linea = Dec(f_valor_columna(apartados.pagina_4.dw_pack,registro,"linea"))
		
				UPDATE almlincargas  Set imp_bandas = "S"
				Where  almlincargas.empresa  =  :codigo_empresa
				And    almlincargas.anyo     =  :var_anyo
				And    almlincargas.orden    =  :var_orden
				And    almlincargas.linea    =  :var_linea;
				COMMIT;
			END IF
      Next
   END IF
END IF



end subroutine

public subroutine f_marcar ();Integer reg,reg1
apartados.pagina_4.dw_pack.SetRedraw(FALSE)
reg = apartados.pagina_4.dw_pack.rowCount()
For reg1 = 1 To reg
//	IF f_valor_columna(apartados.pagina_4.dw_pack,reg1,"almlincargas_imp_bandas") = "N" Then
		f_asignar_columna(apartados.pagina_4.dw_pack,reg1,"marcado","X")
//	END IF
Next
apartados.pagina_4.dw_pack.SetRedraw(TRUE)
end subroutine

public subroutine f_packing ();Integer registro,registros,reg,desde,hasta,bul,var_divisor
Dec{0}  var_anyo,var_orden,var_linea
var_anyo  = Dec(f_valor_columna(dw_pag1,1,"anyo"))
var_orden = Dec(f_valor_columna(dw_pag1,1,"orden"))
String var_matricula,var_bulto,ante_bulto,ante_bulto2,var_bulto2

var_matricula = f_valor_columna(dw_pag1,1,"matricula")
dw_packing.Retrieve(codigo_empresa,Dec(em_anyo.text),var_cliente,var_matricula)
f_imprimir_datawindow(dw_packing) 
	
end subroutine

public subroutine f_grabar_picos_todos (string empresa, decimal anyo, decimal pedido, integer pico);Dec{4} var_anyo,var_orden,var_linea,var_linea_ped,var_pallets,var_calibre,var_cajas,var_total_cajas,var_cantidad,var_cantidad_ped,var_peso_bruto,var_peso_neto
String var_matricula,var_montajeartcal,var_tipo_unidad,var_usuario,&
	ubicacion1,var_es_pico,var_formato,var_situacion_pedido,var_sector,&
	var_caja,var_tono
Datetime var_fcarga,var_fecha_ped,var_forden
Integer registro,registros,var_numero_pico
registros = apartados.pagina_2.dw_pedidos.RowCount()
For registro  = 1 To registros
	var_pedido         = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"pedido"))
	var_anyo_ped       = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"anyo"))
	var_numero_pico    = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_numero_pico"))
	var_situacion_pedido = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_situacion")
	var_es_pico = "S"
	IF pico= var_numero_pico Then
		var_linea_ped = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"linea"))
		var_linea_pedido = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"linea"))
		var_situacion = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_situacion")
		var_anyo  = Dec(em_anyo.text)
		var_orden = Dec(sle_valor.text)
	Select Max(linea) Into :var_linea From almlincargas
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    orden   = :var_orden;
	iF IsNull(var_linea) Then var_linea = 0
	var_linea = var_linea + 1
	var_articulo     = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"articulo")
	var_tipo_pallet  = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_tipo_pallet")
   var_caja         = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_caja")
	var_calidad      = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"calidad")
	var_formato      = f_formato_articulo(codigo_empresa,var_articulo)
	var_referencia   = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"referencia")
	var_matricula = f_valor_columna(dw_pag1,1,"matricula")
	var_cliente= f_valor_columna(dw_pag1,1,"cliente")
	var_fcarga= apartados.pagina_1.dw_ref.GetItemDateTime(1,"fcarga")
	var_forden= dw_pag1.GetItemDateTime(1,"forden")
	var_fecha_ped = apartados.pagina_2.dw_pedidos.getItemDatetime(registro,"fpedido")
	var_montajeartcal = f_componer_artcal(var_articulo,var_calidad)
	var_tono = Trim(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"tonochar"))
	var_calibre = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"calibre"))
	var_referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)   
	var_cajas  = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cajas"))
	var_total_cajas= Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"total_cajas"))
	var_cantidad= Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cantidad"))
	var_cantidad_ped = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"cantidad"))
	var_tipo_unidad  = f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"venliped_tipo_unidad")
	var_usuario      = nombre_usuario
	var_pallets      = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,registro,"pallets"))
	
	var_sector = f_sector_articulo(codigo_empresa,var_articulo)
	if var_sector = "S" then
		var_peso_bruto                = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,var_cajas,var_total_cajas,var_pallets,var_cantidad,var_caja)
		var_peso_neto                 = f_calculo_peso_neto(codigo_empresa,var_articulo,var_cajas,var_total_cajas,var_cantidad,var_caja)
	else
		var_peso_bruto = 0
		var_peso_neto  = 0
	End if

	INSERT INTO almlincargas  
         ( empresa,   
           anyo,   
           orden,   
           linea,   
           matricula,   
           cliente,   
           fcarga,   
           anyo_ped,   
           pedido,   
           linea_ped,   
           fecha_ped,   
           articulo,   
           calidad,   
           montajeartcal,   
           tonochar,   
           calibre,   
           referencia,   
           tipo_pallet,   
           cajas,   
           total_cajas,   
           cantidad,   
           cantidad_ped,   
           tipo_unidad,   
           ubicacion,   
           usuario,   
           paldesde,   
           palhasta,   
           pallets,
			  peso_bruto,
			  peso_neto,
			  pico,
			  es_pico,
			  formato,
			  forden,
			  parcial,
			  imp_bandas,
			  marcado,
			  situacion_pedido,
			  caja)  
  VALUES ( :codigo_empresa,   
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
	        null,   
           :var_usuario,   
           null,   
           null,   
           :var_pallets,
  			  :var_peso_bruto,
			  :var_peso_neto,
			  :var_numero_pico,
			  :var_es_pico,
			  :var_formato,
			  :var_forden,
			  "N",
			  "N",
			  null,
			  :var_situacion_pedido,
			  :var_caja);

COMMIT;
END IF
Next
apartados.pagina_2.dw_pedidos.SetREDraw(FALSE)
apartados.pagina_2.dw_pedidos.SetReDraw(TRUE)
apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_2.dw_pedidos.triggerEvent(RowFocusChanged!)
end subroutine

public subroutine f_contador_ref ();string cliente
IF cb_insertar.enabled = TRUE and wc_index = 1 Then
	dw_pag1.accepttext()
	cliente = dw_pag1.GetItemString(1,"cliente")
	if isnull(cliente) then cliente = ""
	if trim(cliente) = "" then
		messagebox("cliente",cliente)
	end if
	dw_pag1.SetItem(1,"matricula",String(f_almrefcontador(codigo_empresa,Dec(em_anyo.text),cliente)))
END IF
end subroutine

public subroutine f_renumerar_nuevo ();Integer registros,v_paldesde,v_palhasta,registro,v_pallets,anterior,v_pico,v_pico_ant
String  v_articulo,v_tipo_pallet,v_caja
Dec{4}  v_cantidad,acumulado
apartados.pagina_4.dw_pack.SetRedraw(FALSE)
registros = apartados.pagina_4.dw_pack.RowCOunt()
IF registros = 0 Then return
acumulado =0
anterior = 1
For registro     = 1 To registros
	v_paldesde = apartados.pagina_4.dw_pack.object.paldesde[registro]
	v_palhasta = apartados.pagina_4.dw_pack.object.palhasta[registro]
	
	if isnull(v_paldesde) then v_paldesde = 0
	if isnull(v_palhasta) then v_palhasta = 0
	
	if v_paldesde = 0 then
		apartados.pagina_4.dw_pack.object.paldesde[registro] = anterior
	else
		anterior = v_paldesde
	end if
	
	if v_palhasta = 0 then
		apartados.pagina_4.dw_pack.object.palhasta[registro] = anterior
	else
		anterior = v_palhasta
	end if
	
next
apartados.pagina_4.dw_pack.accepttext()
apartados.pagina_4.dw_pack.SetRedraw(TRUE)
end subroutine

event ue_valores;call super::ue_valores;pag1       = TRUE	
pag2       = TRUE	
pag3       = TRUE	
pag4       = TRUE	
pag5       = TRUE	
pag_act1   = TRUE
pag_act2   = FALSE
pag_act3   = FALSE
pag_act4   = FALSE
prin_pag1  =  TRUE

end event

on w_int_almcargas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.pb_imprimir=create pb_imprimir
this.dw_report=create dw_report
this.gb_1=create gb_1
this.cb_grabar=create cb_grabar
this.dw_proceso=create dw_proceso
this.em_anyo=create em_anyo
this.em_referencia=create em_referencia
this.st_2=create st_2
this.dw_bandas=create dw_bandas
this.st_10=create st_10
this.st_11=create st_11
this.st_13=create st_13
this.st_cantidad=create st_cantidad
this.em_pallets=create em_pallets
this.em_cajas=create em_cajas
this.em_t_cajas=create em_t_cajas
this.em_cantidad=create em_cantidad
this.st_20=create st_20
this.st_21=create st_21
this.st_22=create st_22
this.em_peso_linea=create em_peso_linea
this.em_peso_carga=create em_peso_carga
this.em_peso_maximo=create em_peso_maximo
this.dw_packing=create dw_packing
this.cb_todo=create cb_todo
this.st_f2=create st_f2
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_grabar
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.em_anyo
this.Control[iCurrent+8]=this.em_referencia
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_bandas
this.Control[iCurrent+11]=this.st_10
this.Control[iCurrent+12]=this.st_11
this.Control[iCurrent+13]=this.st_13
this.Control[iCurrent+14]=this.st_cantidad
this.Control[iCurrent+15]=this.em_pallets
this.Control[iCurrent+16]=this.em_cajas
this.Control[iCurrent+17]=this.em_t_cajas
this.Control[iCurrent+18]=this.em_cantidad
this.Control[iCurrent+19]=this.st_20
this.Control[iCurrent+20]=this.st_21
this.Control[iCurrent+21]=this.st_22
this.Control[iCurrent+22]=this.em_peso_linea
this.Control[iCurrent+23]=this.em_peso_carga
this.Control[iCurrent+24]=this.em_peso_maximo
this.Control[iCurrent+25]=this.dw_packing
this.Control[iCurrent+26]=this.cb_todo
this.Control[iCurrent+27]=this.st_f2
this.Control[iCurrent+28]=this.st_6
end on

on w_int_almcargas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.pb_imprimir)
destroy(this.dw_report)
destroy(this.gb_1)
destroy(this.cb_grabar)
destroy(this.dw_proceso)
destroy(this.em_anyo)
destroy(this.em_referencia)
destroy(this.st_2)
destroy(this.dw_bandas)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_13)
destroy(this.st_cantidad)
destroy(this.em_pallets)
destroy(this.em_cajas)
destroy(this.em_t_cajas)
destroy(this.em_cantidad)
destroy(this.st_20)
destroy(this.st_21)
destroy(this.st_22)
destroy(this.em_peso_linea)
destroy(this.em_peso_carga)
destroy(this.em_peso_maximo)
destroy(this.dw_packing)
destroy(this.cb_todo)
destroy(this.st_f2)
destroy(this.st_6)
end on

event ue_recuperar;//-------------------------------------------------
// Valores Para Funcion de bloqueo-----------------
//-------------------------------------------------

titulo        =  This.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  Trim(em_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]  =  criterio[1]+criterio[2]+criterio[3]
tabla[1]      = "almcarga"


em_referencia.text  = f_matricula_almcargas(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

IF dw_pag1.RowCOunt() <> 0 Then
	var_referencia = dw_pag1.GetItemSTring(1,"matricula")
	var_cliente    = f_valor_columna(dw_pag1,1,"cliente")
	dw_pag1.SetTabOrder("cliente",0)
	dw_pag1.SetTabOrder("matricula",0)
	apartados.pagina_1.dw_ref.retrieve(codigo_empresa,Dec(em_anyo.text),var_cliente,var_referencia)
	apartados.pagina_2.dw_pedidos.retrieve(codigo_empresa,var_cliente,Dec(em_anyo.text),Dec(sle_valor.text))
	IF	apartados.pagina_1.dw_ref.RowCount() = 0 Then
		apartados.pagina_1.dw_ref.InsertRow(1)
		apartados.pagina_1.dw_ref.SetItem(1,"empresa",codigo_empresa)
		apartados.pagina_1.dw_ref.SetItem(1,"anyo",Dec(em_anyo.text))
		apartados.pagina_1.dw_ref.SetItem(1,"referencia",var_referencia)
	END IF
 ELSE
	dw_pag1.SetTabOrder("cliente",10)
	dw_pag1.SetTabOrder("matricula",30)
END IF

apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_4.dw_pack.Retrieve(codigo_empresa,Dec(em_anyo.text),var_cliente,em_referencia.text)
f_activar_campo(sle_valor)		

CALL Super::ue_recuperar
control_peso = "S"

end event

event ue_inserta_fila;call super::ue_inserta_fila;iF len(f_valor_columna(dw_pag1,1,"empresa")) = 0 Then
	dw_pag1.SetTabOrder("cliente",10)
	dw_pag1.SetItem(1,"empresa",codigo_empresa)
	dw_pag1.SetItem(1,"anyo",Dec(em_anyo.text))
	dw_pag1.SetItem(1,"orden",Dec(sle_valor.text))
	dw_pag1.SetItem(1,"forden",DateTime(Today()))
	dw_pag1.SetItem(1,"usuario",nombre_usuario)
	apartados.pagina_1.dw_ref.Reset()
	apartados.pagina_2.dw_pedidos.Reset()
END IF








end event

event open;call super::open;titulo= " Preparación de ordenes de carga "
apartados.pagina_5.dw_consulta.SetTransObject(SQLCA)
This.title = titulo

// Se controla el nivel de acceso del usuario
   acceso = f_control_acceso(nombre_usuario)

f_mascara_columna(apartados.pagina_1.dw_ref,"pesomax",f_mascara_decimales(0))
f_mascara_columna(apartados.pagina_4.dw_pack,"paldesde",f_mascara_decimales(0))
f_mascara_columna(apartados.pagina_4.dw_pack,"palhasta",f_mascara_decimales(0))
dw_proceso.SetTransObject(SQLCA)
dw_bandas.SetTransObject(SQLCA)
apartados.pagina_1.dw_ref.SetTransObject(SQLCA)
apartados.pagina_2.dw_pedidos.SetTransObject(SQLCA)
apartados.pagina_4.dw_pack.SetTransObject(SQLCA)
apartados.pagina_3.dw_lineas.SetTransObject(SQLCA)
dw_packing.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
f_mascara_columna(apartados.pagina_2.dw_pedidos,"pallets","#,###")
f_mascara_columna(apartados.pagina_2.dw_pedidos,"cajas","#,###")
f_mascara_columna(apartados.pagina_2.dw_pedidos,"cantidad","###,###.00")
em_t_cajas.TabOrder = 0

 // Si recibo el codigo lo visualizo
   
	IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF len(sle_valor.text) <> 0  and len(em_anyo.text)<> 0 Then
       This.TriggerEvent("ue_recuperar")
		 f_activar_campo(sle_valor)
      END IF
   END IF
	
 f_campos(FALSE)
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
em_anyo.enabled = TRUE
pb_imprimir.visible	  = TRUE
apartados.pagina_5.visible = TRUE
st_f2.visible = TRUE

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
pb_imprimir.visible = FALSE
em_anyo.enabled = FALSE
apartados.pagina_5.visible = FALSE
st_f2.visible = FALSE
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;iF wc_index = 2 Then
	f_cursor_abajo(apartados.pagina_2.dw_pedidos)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;iF wc_index = 2 Then
	f_cursor_arriba(apartados.pagina_2.dw_pedidos)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;iF wc_index = 2 Then
	f_pagina_abajo(apartados.pagina_2.dw_pedidos)
END IF
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;iF wc_index = 2 Then
	f_pagina_arriba(apartados.pagina_2.dw_pedidos)
END IF
end event

event ue_f5;call super::ue_f5;iF wc_index = 2 then
	IF cb_insertar.enabled = TRUE Then	cb_grabar.TriggerEvent(Clicked!)
END IF
iF wc_index = 1 then	f_contador_ref()

end event

event ue_borra_fila;call super::ue_borra_fila;Dec{0}  var_anyo,var_orden,numero

var_anyo   = Dec(em_anyo.text)
var_orden  = Dec(sle_valor.text)

Delete from almlincargas
Where  empresa  = :codigo_empresa
And    anyo     = :var_anyo
And    orden    = :var_orden;



Select Count(*) Into :numero From almcargas
Where  almcargas.empresa     = :codigo_empresa 
And    almcargas.anyo        = :var_anyo
And    almcargas.matricula   = :var_referencia;
IF IsNull(numero) Then numero = 0
IF numero = 0 Then
	  DELETE FROM almcargaref  
   WHERE ( almcargaref.empresa = :codigo_empresa ) AND  
         ( almcargaref.anyo = :var_anyo ) AND  
         ( almcargaref.referencia = :var_referencia)   ;

END IF

Commit;

end event

event ue_actualiza_dw;call super::ue_actualiza_dw;String v_matricula
Dec{0} v_anyo,v_orden
apartados.pagina_1.dw_ref.Update()

v_matricula = dw_pag1.GetItemString(1,"matricula")
v_anyo      = Dec(em_anyo.text)
v_orden     = Dec(sle_valor.text)

Update almlincargas
Set    almlincargas.matricula = :v_matricula
Where  almlincargas.empresa   = :codigo_empresa
And    almlincargas.anyo      = :v_anyo
And    almlincargas.orden     = :v_orden;

COMMIT;
end event

event ue_f6;call super::ue_f6;iF wc_index = 2 then
	IF cb_insertar.enabled = TRUE Then		cb_todo.TriggerEvent(Clicked!)
END IF
end event

event ue_f2;call super::ue_f2;pb_calculadora.TriggerEvent(Clicked!)
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_int_almcargas
integer x = 2537
integer y = 156
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

event cb_salir::clicked;IF cb_insertar.enabled = TRUE Then	
f_campos(FALSE)
END IF
apartados.pagina_1.dw_ref.reset()
CALL Super::Clicked
end event

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_int_almcargas
integer x = 2231
integer y = 156
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;Dec{0} var_anyo,var_orden
var_anyo   = Dec(em_anyo.text)
var_orden = Dec(sle_valor.text)

if f_orden_impresa_sn(codigo_empresa,var_anyo,var_orden) then
   if acceso<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Esta orden esta impresa, usted no tiene acceso para borrar.")
		 f_activar_campo(sle_valor)
		 Return
	End if
End if

call super::clicked
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_int_almcargas
integer x = 1925
integer y = 156
integer width = 306
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;apartados.pagina_4.dw_pack.Update()

IF  cb_insertar.enabled = TRUE Then
		datawindow dato
		string var_refe,campo
		integer numero
		var_refe = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'matricula')	
		if isNull(var_refe) then var_refe    = ""
		if Trim(var_refe)="" then
			  campo="matricula"
			  dato = apartados.pagina_1.dw_pagina1
			  numero = 1
		End If
		
		IF Trim(campo)<>"" THEN
		  MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
		  apartados.SelectTab(numero)
		  dato.setfocus()
		  dato.SetColumn(campo)
		  Return
		END IF
End if

COMMIT;
CALL Super::Clicked



end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_int_almcargas
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_int_almcargas
integer height = 88
end type

event st_empresa::clicked;call super::clicked;str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_lis_venproformas,lstr_param)
 f_activar_campo(sle_valor)
end event

type sle_valor from wc_mantenimientos_tab`sle_valor within w_int_almcargas
integer x = 581
integer y = 156
integer width = 302
integer taborder = 40
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = ""
ue_datawindow = ""
ue_filtro     = ""
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_int_almcargas
integer x = 37
integer y = 160
integer width = 302
string text = "Orden:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_int_almcargas
integer x = 14
integer y = 256
integer width = 2871
integer height = 1284
boolean multiline = true
end type

event apartados::selectionchanged;call super::selectionchanged;Dec orden,var_orden,var_anyo
var_anyo   = Dec(em_anyo.text)
var_orden  = Dec(sle_valor.text)

CHOOSE CASE newindex
	CASE  2
			IF cb_insertar.enabled = TRUE   Then
				Select  orden Into :orden From almcargas
				Where almcargas.empresa = :codigo_empresa
				And   almcargas.anyo    = :var_anyo
				And   almcargas.orden   = :var_orden;
				IF SQLCA.SQLCODE = 100 Then
				    cb_insertar.TriggerEvent(Clicked!)
				  ELSE
				 	 f_campos(TRUE)
				END IF
			  END IF
			  IF cb_insertar.enabled = FALSE   Then
				apartados.TriggerEvent("pulsar_datawindow")
				apartados.pagina_2.dw_pedidos.SetFocus()
				IF apartados.pagina_2.dw_pedidos.RowCOunt() <> 0 Then	
					apartados.pagina_2.dw_pedidos.SetRow(1)
					apartados.pagina_2.dw_pedidos.SelectRow(0,FALSE)
					apartados.pagina_2.dw_pedidos.SelectRow(1,TRUE)
				END IF
				
			  END IF
		CASE  4
			 f_campos(FALSE)
			 apartados.pagina_4.dw_pack.Retrieve(codigo_empresa,Dec(em_anyo.text),var_cliente,em_referencia.text)
		CASE 5
			f_campos(FALSE)
			f_activar_campo(apartados.pagina_5.uo_cliente.em_campo)
		CASE ELSE 
			 f_campos(FALSE)
END CHOOSE




end event

event apartados::clicked;call super::clicked;iF apartados.pagina_3.dw_lineas.RowCount() <> 0 Then	
	apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
End if

iF apartados.pagina_2.dw_pedidos.RowCount() <> 0 Then	
		apartados.pagina_2.dw_pedidos.retrieve(codigo_empresa,f_valor_columna(dw_pag1,1,"cliente"),Dec(em_anyo.text),Dec(sle_valor.text))
		apartados.pagina_2.dw_pedidos.SetRow(1)
		apartados.pagina_2.dw_pedidos.SelectRow(0,FALSE)
	   apartados.pagina_2.dw_pedidos.SelectRow(1,TRUE)
END IF

end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 2834
integer height = 1156
string text = "Cabecera"
dw_ref dw_ref
end type

on pagina_1.create
this.dw_ref=create dw_ref
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ref
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_ref)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 73
integer y = 0
integer width = 2757
integer height = 512
string dataobject = "dw_int_almcargas1"
end type

event dw_pagina1::clicked;call super::clicked;
IF GetRow() = 0  Then return
str_parametros lstr_param
CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_cliente"
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_clientes2,lstr_param)  
CASE "pb_ref"
	f_contador_ref()
END CHOOSE


end event

event dw_pagina1::key;
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	
  CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
		
  CASE "matricula"
    IF Len(This.GetItemString(This.GetRow(),"cliente") ) <> 0 Then
 		bus_datawindow = "dw_ayuda_almcargas_matriculas"
		bus_filtro     = " cliente = '" +This.GetItemString(This.GetRow(),"cliente")+"'"
		bus_titulo = "VENTANA SELECCION DE REFERENCIAS"
    ELSE
		SetNull(bus_campo)
	END IF

  
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

IF KeyDown(KeyF5!)  THEN	f_contador_ref()



end event

event dw_pagina1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
  
  CASE "cliente"
		bus_titulo     = "VENTANA SELECCION CLIENTES"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
	CASE "matricula"
      IF Len(This.GetItemString(This.GetRow(),"cliente") ) <> 0 Then
 		   bus_datawindow = "dw_ayuda_almcargas_matriculas"
   		bus_filtro     = " cliente = '" +This.GetItemString(This.GetRow(),"cliente")+"'"
	   	bus_titulo = "VENTANA SELECCION DE REFERENCIAS"
		End if
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
     
       f_valores_numericos(This,"cliente")
	      
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;If This.getRow() = 0 Then  Return

Dec{4} var_anyo,var_orden
String var_matricula

var_anyo = DEC(em_anyo.text)


var_matricula = f_valor_columna(this,This.getRow(),"matricula")
var_cliente = f_valor_columna(this,This.getRow(),"cliente")

if trim(var_cliente) <> "" then
	
	IF len(var_matricula) <> 0 Then
		apartados.pagina_1.dw_ref.retrieve(codigo_empresa,var_anyo,f_valor_columna(dw_pag1,1,"cliente"),f_valor_columna(dw_pag1,1,"matricula"))
		iF apartados.pagina_1.dw_ref.RowCount() = 0 Then
			apartados.pagina_1.dw_ref.InsertRow(1)
			apartados.pagina_1.dw_ref.SetItem(1,"empresa",codigo_empresa)
			apartados.pagina_1.dw_ref.SetItem(1,"anyo",var_anyo)
			apartados.pagina_1.dw_ref.SetItem(1,"referencia",var_matricula)
			apartados.pagina_1.dw_ref.SetItem(1,"cliente",var_cliente)
		END IF
		
	END IF
end if
	


end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 2834
integer height = 1156
string text = "Lineas Pedido"
dw_pedidos dw_pedidos
end type

on pagina_2.create
this.dw_pedidos=create dw_pedidos
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pedidos
end on

on pagina_2.destroy
call super::destroy
destroy(this.dw_pedidos)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
boolean visible = false
integer x = 59
integer y = 92
integer width = 384
integer height = 260
boolean vscrollbar = true
end type

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"agente1")
       f_valores_numericos(This,"agente2")
       f_valores_numericos(This,"agente3")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 2834
integer height = 1156
string text = "Lineas Orden"
dw_lineas dw_lineas
end type

on pagina_3.create
this.dw_lineas=create dw_lineas
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lineas
end on

on pagina_3.destroy
call super::destroy
destroy(this.dw_lineas)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
boolean visible = false
integer x = 9
integer y = 0
integer width = 512
integer height = 176
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 2834
integer height = 1156
string text = "Packing List"
dw_pack dw_pack
end type

on pagina_4.create
this.dw_pack=create dw_pack
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pack
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_pack)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
boolean visible = false
integer x = 0
integer y = 0
integer width = 315
integer height = 40
boolean livescroll = false
end type

event dw_pagina4::doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"pedido"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 2834
integer height = 1156
string text = "Consulta"
uo_cliente uo_cliente
st_3 st_3
dw_consulta dw_consulta
end type

on pagina_5.create
this.uo_cliente=create uo_cliente
this.st_3=create st_3
this.dw_consulta=create dw_consulta
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.dw_consulta
end on

on pagina_5.destroy
call super::destroy
destroy(this.uo_cliente)
destroy(this.st_3)
destroy(this.dw_consulta)
end on

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
boolean visible = false
integer x = 0
integer y = 16
integer width = 2235
integer height = 1100
end type

event dw_pagina5::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina5::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_agente1"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)  
CASE "pb_agente2"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente3"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_cod_pago"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)
	CASE "pb_cod_entrega"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_vencondentrega,lstr_param)
END CHOOSE





end event

event dw_pagina5::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "pb_banco_cobro"
  		bus_datawindow = "dw_ayuda_carbancos"
 		bus_titulo = "VENTANA SELECCION BANCOS EMPRESA"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina5::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 2834
integer height = 1156
string text = ""
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer width = 2318
end type

event dw_pagina6::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina6::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param



lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
END CHOOSE





end event

event dw_pagina6::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 2834
integer height = 1156
string text = ""
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer width = 1911
integer height = 896
end type

event dw_pagina7::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina7::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_tarifa"
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
	OpenWithParm(wi_mant_ventarifas,lstr_param)
END CHOOSE





end event

event dw_pagina7::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 2834
integer height = 1156
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type dw_ref from u_datawindow within pagina_1
integer x = 50
integer y = 508
integer width = 2775
integer height = 652
integer taborder = 2
boolean bringtotop = true
string dataobject = "dw_int_almcargas5"
boolean border = false
end type

event clicked;call super::clicked;apartados.triggerEvent("pulsar_datawindow")
Str_parametros lstr_param


CHOOSE CASE f_objeto_datawindow(This)
 CASE "pb_tipo_transporte"
 	 lstr_param.i_nargumentos    = 2
	 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipo_transporte")
	 OpenWithParm(wi_mant_almtipotransportes,lstr_param)  
 CASE "pb_envio"
 	 lstr_param.i_nargumentos    = 2
  	 lstr_param.s_argumentos[2]=f_valor_columna(dw_pag1,dw_pag1.GetRow(),"cliente")
	 lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"envio")
	 OpenWithParm(wi_mant_venenvio,lstr_param)  
 CASE "pb_bandas"
      string var_cli,var_envio,var_pais,var_ciudad,var_nombre
	   
		var_cli   = dw_pag1.GetItemString(1,"cliente")
		var_envio = This.GetItemString(1,"envio")
		
		if Trim(var_envio)<>"" then
      	if MessageBox("!A t e n c i ó n ","¿Desea los datos del cliente?",Question!, YesNo!,1)=1 then
         	  var_nombre  = f_nombre_cliente(codigo_empresa,"C",var_cliente)
				  var_pais    = f_nombre_pais(f_pais_genter(codigo_empresa,"C",var_cli))
              var_ciudad  = f_nombre_poblacion(codigo_empresa,"C",var_cli)
              if trim(var_ciudad)="" then var_ciudad = f_nombre_provincia(f_pais_genter(codigo_empresa,"C",var_cliente),f_provincia_genter(codigo_empresa,"C",var_cliente))
			  else
			     var_nombre  = f_nombre_venenvio(codigo_empresa,var_cliente,var_envio)
				  var_pais    = f_nombre_pais(f_pais_venenvio(codigo_empresa,var_cli,var_envio))
              var_ciudad  = f_localidad_venenvio(codigo_empresa,var_cli,var_envio)
              if trim(var_ciudad)="" then var_ciudad = f_nombre_provincia(var_pais,f_provincia_venenvio(codigo_empresa,var_cliente,var_envio)) 
   		 End if
		 else
           	  var_nombre  = f_nombre_cliente(codigo_empresa,"C",var_cliente)
				  var_pais    = f_nombre_pais(f_pais_genter(codigo_empresa,"C",var_cli))
              var_ciudad  = f_nombre_poblacion(codigo_empresa,"C",var_cli)
              if trim(var_ciudad)="" then var_ciudad = f_nombre_provincia(f_pais_genter(codigo_empresa,"C",var_cliente),f_provincia_genter(codigo_empresa,"C",var_cliente))				
	   End if		
   	apartados.pagina_1.dw_ref.SetItem(1,"nombanda",var_nombre)
		apartados.pagina_1.dw_ref.SetItem(1,"pobbanda",var_ciudad)
		apartados.pagina_1.dw_ref.SetItem(1,"paisbanda",var_pais)
END CHOOSE


end event

event key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "tipo_transporte"
 		bus_datawindow = "dw_ayuda_almtipotransportes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE TIPOS DE TRANSPORTES"	
	CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_filtro     = "cliente = '" +dw_pag1.GetItemString(1,"cliente")+"'"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"	
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key


END IF




end event

event rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
  
 	CASE "tipo_transporte"
 		bus_datawindow = "dw_ayuda_almtipotransportes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE TIPOS DE TRANSPORTES"	
CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_filtro     = "cliente = '" +dw_pag1.GetItemString(1,"cliente")+"'"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"	
  
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event valores_numericos;call super::valores_numericos;f_valores_numericos(dw_ref,"tipo_transporte")
f_valores_numericos(dw_ref,"envio")
end event

event itemfocuschanged;call super::itemfocuschanged;Dec{4} var_peso
String  var_tipo_transporte
var_peso = Dec(f_valor_columna(this,This.getRow(),"pesomax"))
IF IsNull(var_peso) then var_peso = 0 
var_tipo_transporte = f_valor_columna(this,This.getRow(),"tipo_transporte")
IF var_peso = 0 Then
	var_peso = f_pesomax_almtipotransportes(codigo_empresa,var_tipo_transporte)
	f_asignar_columna(this,This.GetRow(),"pesomax",String(var_peso))
END IF


end event

type dw_pedidos from u_datawindow_consultas within pagina_2
integer width = 2821
integer height = 936
integer taborder = 2
string dataobject = "dw_int_almcargas2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() = 0 Then Return 

String v_caja

em_cantidad.text = f_valor_columna(This,GetRow(),"cantidad")
var_articulo     = f_valor_columna(This,GetRow(),"articulo")
var_pedido       = Dec(f_valor_columna(This,GetRow(),"pedido"))
var_linea_pedido = Dec(f_valor_columna(This,GetRow(),"linea"))
var_tipo_pallet  = f_valor_columna(This,GetRow(),"venliped_tipo_pallet")
v_caja         = f_valor_columna(This,GetRow(),"venliped_caja")
var_calidad      = f_valor_columna(This,GetRow(),"calidad")
var_referencia   = f_valor_columna(This,GetRow(),"venliped_referencia")
var_situacion    = f_valor_columna(This,GetRow(),"venliped_situacion")
em_pallets.text  = "0"
em_cajas.text    = "0"
em_t_cajas.text  = "0"
em_cantidad.text =  String(Dec(em_cantidad.text) - f_cantidad_almlincarga_lnpedido( codigo_empresa , Dec(f_valor_columna(This,GetRow(),"anyo")),  Dec(f_valor_columna(This,GetRow(),"pedido")) ,  Dec(f_valor_columna(This,GetRow(),"linea"))))
st_cantidad.text = f_nombre_unidad(f_valor_columna(This,GetRow(),"tipo_unidad"))
string cadena
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,&
									 v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text    = Trim(Mid(cadena,1,6))
 em_cajas.text      = Trim(Mid(cadena,7,6))
 em_t_cajas.text    = Trim(Mid(cadena,13,6))
 em_cantidad.text   = Trim(Mid(cadena,19,9))
 linea_cantidad =Dec(em_cantidad.text)
em_peso_carga.text  =   String(f_peso_bruto_almlincarga_matricula(codigo_empresa, dec(em_anyo.text) ,f_matricula_almcargas(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))),f_mascara_decimales(2))
f_peso_linea()
ScrollToRow(GetRow())
f_activar_campo(em_pallets)
end event

event clicked;call super::clicked;Integer ln 
String v_caja

ln = GetRow()
This.SetRedraw(FALSE)
IF cb_insertar.enabled = FALSE THEN
	Boolean bol
	wc_index = 2
	f_campos(TRUE)
	apartados.triggerevent("pulsar_datawindow")
END IF
   
IF f_objeto_datawindow(this) = "preparar" Then
	IF GetRow() = 0 Then Return
   
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Usted no tiene acceso para preparar la linea.")
			 Return
	End if
   
	str_parametros lstr_param
	lstr_param.i_nargumentos = 4
	lstr_param.s_argumentos[1]  = "w_int_almcargas"
	lstr_param.s_argumentos[2]  = String(GetItemNumber(GetRow(),"anyo"))
	lstr_param.s_argumentos[3]  = String(GetItemNumber(GetRow(),"pedido"))
	lstr_param.s_argumentos[4]  = String(GetItemNumber(GetRow(),"linea"))
	OpenWithParm(w_int_preparacion_pedido,lstr_param)
	
	IF  Message.StringParm = "S" Then 	
	    apartados.pagina_2.dw_pedidos.retrieve(codigo_empresa,f_valor_columna(dw_pag1,1,"cliente"),Dec(em_anyo.text),Dec(sle_valor.text))
		 apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
	END IF
	ScrollToRow(ln)
	This.SetRedraw(TRUE)
END IF
IF GetRow() = 0 Then Return 
em_cantidad.text  = f_valor_columna(This,GetRow(),"cantidad")
var_articulo      = f_valor_columna(This,GetRow(),"articulo")
var_pedido        = Dec(f_valor_columna(This,GetRow(),"pedido"))
var_linea_pedido        = Dec(f_valor_columna(This,GetRow(),"linea"))
var_tipo_pallet   = f_valor_columna(This,GetRow(),"venliped_tipo_pallet")
v_caja            = f_valor_columna(This,GetRow(),"venliped_caja")
var_calidad   = f_valor_columna(This,GetRow(),"calidad")
var_referencia   = f_valor_columna(This,GetRow(),"venliped_referencia")
var_situacion   = f_valor_columna(This,GetRow(),"venliped_situacion")
em_pallets.text  ="0"
em_cajas.text      ="0"
em_t_cajas.text    ="0"
em_cantidad.text  =  String(Dec(em_cantidad.text) - f_cantidad_almlincarga_lnpedido( codigo_empresa , Dec(f_valor_columna(This,GetRow(),"anyo")),  Dec(f_valor_columna(This,GetRow(),"pedido")) ,  Dec(f_valor_columna(This,GetRow(),"linea"))))
st_cantidad.text = f_nombre_unidad(f_valor_columna(This,GetRow(),"tipo_unidad"))
string cadena
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,&
									 v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text    = Trim(Mid(cadena,1,6))
 em_cajas.text      = Trim(Mid(cadena,7,6))
 em_t_cajas.text    = Trim(Mid(cadena,13,6))
 em_cantidad.text   = Trim(Mid(cadena,19,9))
 linea_cantidad     = Dec(em_cantidad.text)
em_peso_carga.text  = String(f_peso_bruto_almlincarga_matricula(codigo_empresa, dec(em_anyo.text) ,f_matricula_almcargas(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))),f_mascara_decimales(2))
f_peso_linea()
ScrollToRow(GetRow())
This.SetRedraw(TRUE)
f_activar_campo(em_pallets)
end event

type dw_lineas from u_datawindow_consultas within pagina_3
integer y = 8
integer width = 2834
integer height = 1104
integer taborder = 11
string dataobject = "dw_int_almcargas3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec{0} var_orden,var_linea,var_anyo,registros,reg,var_pallets,var_cajas,var_total_cajas
Dec{2} var_cantidad
string var_ubi,var_almacen_de_carga,var_caja

IF f_objeto_datawindow(this) = "borrar" Then
		
   var_anyo   = Dec(em_anyo.text)
   var_orden = Dec(sle_valor.text)

	if f_orden_impresa_sn(codigo_empresa,var_anyo,var_orden) then
		if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Esta orden esta impresa, usted no puede anular la asignación.")
			 Return
		End if
	End if
	
	IF This.RowCount() = 0 Then Return
	var_anyo  = Dec(f_valor_columna(This,This.GetRow(),"anyo"))
	var_orden = Dec(f_valor_columna(This,This.GetRow(),"orden"))
	var_linea = Dec(f_valor_columna(This,This.GetRow(),"linea"))
	var_pedido = Dec(f_valor_columna(This,This.GetRow(),"pedido"))
	Delete from almlincargas
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    orden   = :var_orden
	And    linea   = :var_linea;
	COMMIT;
	apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
END IF

CHOOSE CASE f_objeto_datawindow(this)
	CASE "asignar","asignar_pdtes"

        	registros = 	This.RowCount()
			IF registros = 0 Then Return
			
			var_anyo   = Dec(em_anyo.text)
			var_orden = Dec(sle_valor.text)
		
			if acceso<>"1" then
					 f_mensaje("! A t e n c i ó n ¡","Usted no puede asignar ubicaciones para su preparación.")
					 Return
			End if
			
			FOR reg = 1 to registros
				var_anyo         = GetItemNumber(reg,"anyo")
				var_orden        = GetItemNumber(reg,"orden")
				var_linea        = GetItemNumber(reg,"linea")
				var_referencia   = GetItemString(reg,"referencia")
				var_tipo_pallet  = GetItemString(reg,"tipo_pallet")
				var_caja         = GetItemString(reg,"almlincargas_caja")
				var_situacion    = GetItemString(reg,"almlincargas_situacion_pedido")
				var_anyo_ped     = GetItemNumber(reg,"anyo_ped")
				var_pedido       = GetItemNumber(reg,"pedido")
				var_cantidad     = GetItemNumber(reg,"cantidad")
				var_linea_pedido = GetItemNumber(reg,"linea_ped")
				var_almacen_de_carga = GetItemString(reg,"almlincargas_almacen_de_carga")
				var_ubi          = GetItemString(reg,"ubicacion")
				if isnull(var_ubi) then var_ubi = ""
				
				IF f_objeto_datawindow(this) = "asignar" Then
						  CHOOSE CASE var_situacion
								CASE "P","C",""
									if var_situacion = "P" then
										var_ubicacion = f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,var_tipo_pallet,var_anyo_ped,var_pedido,var_linea_pedido)
									 else
										//var_ubicacion = f_ubicacion_ref_pallet_caja_cantidad_alm(codigo_empresa,var_referencia,var_tipo_pallet,var_caja,var_cantidad,var_almacen_de_carga)
									End if
								CASE "F"
									var_ubicacion = ""
							END CHOOSE
							
							Update almlincargas 
							Set    almlincargas.ubicacion = :var_ubicacion
							Where  almlincargas.empresa = :codigo_empresa
							And    almlincargas.anyo    = :var_anyo
							And    almlincargas.orden   = :var_orden
							And    almlincargas.linea   = :var_linea;
							COMMIT;   
					Else
					      if var_ubi="" then
							 CHOOSE CASE var_situacion
								CASE "P","C",""
									if var_situacion = "P" then
										var_ubicacion = f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,var_tipo_pallet,var_anyo_ped,var_pedido,var_linea_pedido)
									 else
										
										//var_ubicacion = f_ubicacion_ref_pallet_caja_cantidad_alm(codigo_empresa,var_referencia,var_tipo_pallet,var_caja,var_cantidad,var_almacen_de_carga)
									End if
								CASE "F"
									var_ubicacion = ""
						 	  END CHOOSE
							
							  Update almlincargas 
							  Set    almlincargas.ubicacion = :var_ubicacion
							  Where  almlincargas.empresa = :codigo_empresa
							  And    almlincargas.anyo    = :var_anyo
							  And    almlincargas.orden   = :var_orden
							  And    almlincargas.linea   = :var_linea;
							  COMMIT;   
						End if
              End if
			Next
			apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

END CHOOSE



IF f_objeto_datawindow(This) = "pallet_menos" Then
	IF GetRow() <> 0  Then
		var_anyo = GetItemNumber(GetRow(),"anyo")		
		var_orden = GetItemNumber(GetRow(),"orden")		
		var_linea = GetItemNumber(GetRow(),"linea")		
		var_pallets = GetItemNumber(GetRow(),"almlincargas_pallets")		
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
		var_anyo = GetItemNumber(GetRow(),"anyo")		
		var_orden = GetItemNumber(GetRow(),"orden")		
		var_linea = GetItemNumber(GetRow(),"linea")		
		var_pallets = GetItemNumber(GetRow(),"almlincargas_pallets")		
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
		var_anyo        = GetItemNumber(GetRow(),"anyo")		
		var_orden       = GetItemNumber(GetRow(),"orden")		
		var_linea       = GetItemNumber(GetRow(),"linea")		
		var_cajas       = GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"total_cajas")		
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
		var_anyo        = GetItemNumber(GetRow(),"anyo")		
		var_orden       = GetItemNumber(GetRow(),"orden")		
		var_linea       = GetItemNumber(GetRow(),"linea")		
		var_cajas       = GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"total_cajas")		
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

event retrieveend;call super::retrieveend;SetRedraw(TRUE)
end event

event retrievestart;call super::retrievestart;SetRedraw(FALSE)
end event

type dw_pack from u_datawindow_consultas within pagina_4
integer y = 4
integer width = 2843
integer height = 1120
integer taborder = 2
boolean bringtotop = true
string dataobject = "dw_int_almcargas4"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;
Dec{0} v_pallets,v_orden,v_anyo_pedido,v_pedido,v_linea,v_linea_pedido,v_anyo
dec{0} var_pallets,var_linea,var_cajas,var_total_cajas,var_caj,var_tcaj,var_cant,var_pal,var_peso
String var_art,var_tp,var_tc
wc_index = 4

Dec{0} var_anyo,var_orden
var_anyo   = Dec(em_anyo.text)
var_orden = Dec(sle_valor.text)

iF cb_insertar.enabled = FALSE Then apartados.TriggerEvent("pulsar_datawindow")
iF cb_insertar.enabled = FALSE Then return
//IF This.RowCount() = 0 Then return
If row <> 0 Then 
	SetRow(row)
	Setcolumn("paldesde")
END IF
IF f_objeto_datawindow(This) = "renumerar" Then

	if f_orden_impresa_sn(codigo_empresa,var_anyo,var_orden) then
		if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Esta orden esta impresa, usted no puede renumerar los pallets.")
			 f_activar_campo(sle_valor)
			 Return
		End if
	End if
   f_renumerar_nuevo()
END IF

IF f_objeto_datawindow(This) = "marcar" Then
	f_marcar()
	Return
END IF
IF f_objeto_datawindow(This) = "impbandas" Then
	f_bandas()
	Return
END IF
IF f_objeto_datawindow(This) = "packing" Then
	f_packing()
	Return
END IF

IF f_objeto_datawindow(This) = "marcado" Then
	iF f_valor_columna(This,Row,"marcado") = "X" Then
		f_asignar_columna(This,Row,"marcado","")
	ELSE
		f_asignar_columna(This,Row,"marcado","X")
	END IF
	Return
END IF


IF f_objeto_datawindow(This) = "pallet_menos" Then
	IF GetRow() <> 0  Then
		var_anyo     = GetItemNumber(GetRow(),"anyo")		
		var_orden    = GetItemNumber(GetRow(),"orden")		
		var_linea    = GetItemNumber(GetRow(),"linea")		
		var_art      = GetItemString(GetRow(),"articulo")		
		var_pallets  = GetItemNumber(GetRow(),"almlincargas_pallets")		
		var_tp       = GetItemString(GetRow(),"tipo_pallet")		
		var_tc       = GetItemString(GetRow(),"almlincargas_caja")				
		var_caj      = GetItemNumber(GetRow(),"cajas")		
		var_tcaj     = GetItemNumber(GetRow(),"total_cajas")
		var_cant     = GetItemNumber(GetRow(),"cantidad")		
		
		if var_pallets = 0 or isnull(var_pallets) then return
		//calcula la linea
		var_peso = f_calculo_peso(codigo_empresa,var_art,var_tp,var_caj,var_tcaj,var_pallets - 1,var_cant,var_tc)
		
		Update   almlincargas
		Set      almlincargas.pallets    = pallets - 1,
 		         almlincargas.peso_bruto = :var_peso
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"almlincargas_pallets",var_pallets -1)
		SetItem(GetRow(),"almlincargas_peso_bruto",var_peso)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "pallet_mas" Then
	IF GetRow() <> 0  Then
		var_anyo    = GetItemNumber(GetRow(),"anyo")		
		var_orden   = GetItemNumber(GetRow(),"orden")		
		var_linea   = GetItemNumber(GetRow(),"linea")		
		var_pallets = GetItemNumber(GetRow(),"almlincargas_pallets")		
		var_art     = GetItemString(GetRow(),"articulo")		
		var_tp      = GetItemString(GetRow(),"tipo_pallet")		
		var_tc      = GetItemString(GetRow(),"almlincargas_caja")		
		var_caj     = GetItemNumber(GetRow(),"cajas")		
		var_tcaj    = GetItemNumber(GetRow(),"total_cajas")
		var_cant    = GetItemNumber(GetRow(),"cantidad")		
		
		//calcula la linea
		var_peso = f_calculo_peso(codigo_empresa,var_art,var_tp,var_caj,var_tcaj,var_pallets + 1,var_cant,var_tc)
		
		Update   almlincargas
		Set      almlincargas.pallets    = pallets + 1,
  		         almlincargas.peso_bruto = :var_peso
		Where    almlincargas.empresa = :codigo_empresa
		And      almlincargas.anyo    = :var_anyo
		And      almlincargas.orden   = :var_orden
		And      almlincargas.linea   = :var_linea;
		Commit;
		SetItem(GetRow(),"almlincargas_pallets",var_pallets +1)
		SetItem(GetRow(),"almlincargas_peso_bruto",var_peso)
	 	Return
	END IF
END IF



IF f_objeto_datawindow(This) = "caja_mas" Then
	IF GetRow() <> 0  Then
		var_anyo        = GetItemNumber(GetRow(),"anyo")		
		var_orden       = GetItemNumber(GetRow(),"orden")		
		var_linea       = GetItemNumber(GetRow(),"linea")		
		var_cajas       = GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"total_cajas")		
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
		SetItem(GetRow(),"almlincargas_peso_bruto",var_peso)
	 	Return
	END IF
END IF

IF f_objeto_datawindow(This) = "caja_menos" Then
	IF GetRow() <> 0  Then
		var_anyo        = GetItemNumber(GetRow(),"anyo")		
		var_orden       = GetItemNumber(GetRow(),"orden")		
		var_linea       = GetItemNumber(GetRow(),"linea")		
		var_cajas       = GetItemNumber(GetRow(),"cajas")		
		var_total_cajas = GetItemNumber(GetRow(),"total_cajas")		
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
		SetItem(GetRow(),"almlincargas_peso_bruto",var_peso)
	 	Return
	END IF
END IF




end event

event rowfocuschanged;call super::rowfocuschanged;If GetRow() = 0 Then Return
SetRow(GetRow())
Setcolumn("paldesde")
end event

event key;call super::key;IF Key = Keyf4! THEN
	if this.getrow() > 0 then
		IF MessageBox("Proceso Anulación","¿Desea anular la linea seleccionada?",Question!,YesNo!,2) = 1 Then
			this.deleterow(this.getrow())
		end if
	end if
end if




end event

type uo_cliente from u_em_campo_2 within pagina_5
integer x = 297
integer y = 40
integer width = 1957
integer taborder = 2
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF

dw_consulta.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within pagina_5
integer x = 37
integer y = 40
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
boolean focusrectangle = false
end type

type dw_consulta from datawindow within pagina_5
integer y = 152
integer width = 2825
integer height = 960
integer taborder = 41
boolean bringtotop = true
string dataobject = "dw_int_almcargas6"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row= 0 Then Return
Dec   anyo,orden
anyo = dw_consulta.GetItemNumber(row,"anyo")
orden = dw_consulta.GetItemNumber(row,"orden")
em_anyo.text   = String(anyo,"####")
sle_valor.text = String(orden,"#########")
apartados.GetParent().TriggerEvent("ue_recuperar")
apartados.SelectTab(1)
wc_index= 1
end event

type pb_calculadora from u_calculadora within w_int_almcargas
event clicked pbm_bnclicked
integer x = 887
integer y = 144
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
vtextalign vtextalign = multiline!
end type

event clicked;call super::clicked;IF Not visible Then Return 
dec{0} n_orden
Integer registros,numero,anyo
String  var_empresa

anyo = Integer(em_anyo.text)

  SELECT almparamord.empresa,almparamord.orden
    INTO :var_empresa,:registros  
    FROM almparamord  
   WHERE almparamord.empresa = :codigo_empresa  
   And   almparamord.anyo    = :anyo;
   If Sqlca.Sqlcode=100 Then
       INSERT INTO almparamord
              (empresa,anyo,orden)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros =registros + 1
   n_orden   = registros

   Select count(*) Into :numero From almcargas
   Where   almcargas.empresa   = :codigo_empresa
   And     almcargas.anyo      = :anyo
   And     almcargas.orden     = :n_orden;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((almcargas.orden)+1)
       Into   :sle_valor.text
       From   almcargas
       Where  almcargas.empresa = :codigo_empresa
       And    almcargas.anyo    = :anyo;
       registros= Integer(sle_valor.text)
   End If
   UPDATE almparamord
   SET    orden = :registros  
   WHERE  almparamord.empresa = :codigo_empresa
   And    almparamord.anyo    = :anyo;
   COMMIT;

   sle_valor.text=String(registros)
   apartados.TriggerEvent("pulsar_datawindow")


end event

type pb_imprimir from upb_imprimir within w_int_almcargas
integer x = 1010
integer y = 144
integer width = 123
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\print.bmp"
end type

event clicked;Dec{0}   var_anyo,var_orden
DateTime  fecha
string impresora
IF Trim(sle_valor.text) = "" THEN Return

str_parametros pa
Dec{0} anyo,orden
var_anyo   = Dec(em_anyo.text)
var_orden = Dec(sle_valor.text)

if f_orden_impresa_sn(codigo_empresa,var_anyo,var_orden) then
   if acceso<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Esta orden esta impresa, usted no tiene acceso para imprimir.")
		 f_activar_campo(sle_valor)
		 Return
	End if
End if

dw_report.Retrieve(codigo_empresa,var_anyo,var_orden)
pa.s_listado = dw_report.DataObject

//SELECT ven_usuimpre.impresora_preparacion
//INTO :impresora  FROM ven_usuimpre
//Where empresa = :codigo_empresa
//And   usuario = :nombre_usuario;
//
//dw_report.Modify("datawindow.printer = "+impresora)
//dw_report.Modify("datawindow.print.copies = 1")

IF f_imprimir_datawindow(dw_report) Then
	fecha = DateTime(Today(),Now())
	UPDATE almcargas  
     SET  almcargas.flistado = :fecha,   
          almcargas.veces    = veces + 1  
   WHERE (almcargas.empresa  = :codigo_empresa)
	AND   (almcargas.anyo     = :var_anyo )
	AND   (almcargas.orden    = :var_orden )   ;
	COMMIT;

END IF
dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
f_activar_campo(sle_valor)

end event

type dw_report from datawindow within w_int_almcargas
boolean visible = false
integer x = 498
integer y = 8
integer width = 494
integer height = 108
boolean bringtotop = true
string dataobject = "report_almcargas"
boolean livescroll = true
end type

type gb_1 from groupbox within w_int_almcargas
integer x = 1911
integer y = 120
integer width = 946
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_grabar from u_boton within w_int_almcargas
boolean visible = false
integer x = 1079
integer y = 1428
integer height = 76
integer taborder = 90
boolean bringtotop = true
string text = "F5 Grabar     "
end type

event clicked;str_almlincargas la
la.empresa = codigo_empresa
Integer  opcion,ln
String   busq

la.anyo     = Dec(em_anyo.text)
la.orden    = Dec(sle_valor.text)
la.anyo_ped = apartados.pagina_2.dw_pedidos.GetItemNumber(apartados.pagina_2.dw_pedidos.GetRow(),"anyo")
la.pedido   = apartados.pagina_2.dw_pedidos.GetItemNumber(apartados.pagina_2.dw_pedidos.GetRow(),"pedido")

if f_orden_impresa_sn(la.empresa,la.anyo,la.orden) and f_pedido_impreso(la.empresa,la.anyo_ped,la.pedido)  then
   if acceso<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Orden y pedido impresos, usted no puede asignar lineas.")
		 Return
	End if
End if

la.imp_bandas = "N"
la.es_pico    = "N"

iF cb_insertar.enabled = FALSE Then apartados.TriggerEvent("pulsar_datawindow")
iF cb_insertar.enabled = FALSE Then return
IF this.visible = FALSE Then Return
IF control_peso = "S" Then
	control_peso = "N"
	IF Dec(em_peso_maximo.text) <> 0 Then
		IF Dec(em_peso_maximo.text) < Dec(em_peso_carga.text) + Dec(em_peso_linea.text)  Then
			IF MessageBox("Peso superado","Peso en carga superior al Maximo",Question!,YesNo!) = 2 Then
			  f_activar_campo(em_pallets)
			  return
			END IF
		END IF
	END IF
END IF

la.pico = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"venliped_numero_pico"))
la.situacion_pedido = f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"venliped_situacion")
IF f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"venliped_es_pico")= "S" Then
		IF f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"venliped_situacion")= "P" Then
			la.es_pico = "S"
			tipo_array arg
			arg.valor[1]  = "¿Desea Marcar el resto de los picos?"
			arg.valor[11] = "Si,del pedido"
			arg.valor[12] = "Si,Todos"
			arg.valor[13] = "No" 

         opcion = f_opciones(arg)
			CHOOSE CASE opcion
   			 CASE 1
	         		 f_grabar_picos(codigo_empresa,Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"anyo")),&
				            		Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"pedido")),&
										la.pico)
										Return
	 			 CASE 2
		      		 f_grabar_picos_todos(codigo_empresa,Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"anyo")),&
 									   Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.GetRow(),"pedido")),&
									   la.pico)
										Return
				END CHOOSE
	  End IF
END IF

IF Dec(em_cantidad.text) = 0 or Dec(em_cantidad.text) > linea_cantidad Then
	f_mensaje("Error en cantidad","Introduzca la cantidad")
	f_activar_campo(em_cantidad)
	Return
END IF

la.anyo  = Dec(em_anyo.text)
la.orden = Dec(sle_valor.text)
Select Max(almlincargas.linea) Into :la.linea From almlincargas
Where  almlincargas.empresa = :la.empresa
And    almlincargas.anyo    = :la.anyo
And    almlincargas.orden   = :la.orden;
IF IsNull(la.linea) THEN la.linea = 0

la.linea         = la.linea + 1
la.matricula     = f_valor_columna(dw_pag1,1,"matricula")
la.cliente       = f_valor_columna(dw_pag1,1,"cliente")
la.fcarga        = apartados.pagina_1.dw_ref.GetItemDateTime(1,"fcarga")
la.forden        = dw_pag1.GetItemDateTime(1,"forden")
ln               = apartados.pagina_2.dw_pedidos.getRow()
la.anyo_ped      = apartados.pagina_2.dw_pedidos.getItemNumber(ln,"anyo")
la.pedido        = apartados.pagina_2.dw_pedidos.getItemNumber(ln,"pedido")
la.linea_ped     = apartados.pagina_2.dw_pedidos.getItemNumber(ln,"linea")
la.fecha_ped     = apartados.pagina_2.dw_pedidos.getItemDatetime(ln,"fpedido")
la.articulo      = apartados.pagina_2.dw_pedidos.getItemSTring(ln,"articulo")
la.calidad       = apartados.pagina_2.dw_pedidos.getItemSTring(ln,"calidad")
la.tipo_pallet   = apartados.pagina_2.dw_pedidos.getItemSTring(ln,"venliped_tipo_pallet")
la.caja          = apartados.pagina_2.dw_pedidos.getItemSTring(ln,"venliped_caja")
la.montajeartcal = f_componer_artcal(la.articulo,la.calidad)
la.tonochar      = apartados.pagina_2.dw_pedidos.getItemString(ln,"venliped_tonochar")
la.calibre       = apartados.pagina_2.dw_pedidos.getItemNumber(ln,"calibre")
la.referencia    = f_componer_ref(la.articulo,la.calidad,la.tonochar,la.calibre)   
la.cajas         = Dec(em_cajas.text)
la.total_cajas   = Dec(em_t_cajas.text)
la.cantidad      = Dec(em_cantidad.text)
la.parcial       = "N"
la.almacen_de_carga = apartados.pagina_2.dw_pedidos.getItemSTring(ln,"venliped_almacen_de_carga")

IF la.cantidad <> Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.getRow(),"cantidad")) Then
   IF la.es_pico = "S" Then 
		la.parcial = "S"	
	ELSE
		//---------------//
		// Pallet parcial//
		//---------------//
		busq = "venliped_referencia= '" + la.referencia + "' and venliped_es_pico = 'S' and cantidad > " + String(la.cantidad,"######")
		IF apartados.pagina_2.dw_pedidos.find(busq,1,apartados.pagina_2.dw_pedidos.RowCOunt()) <>0  Then
			IF messageBox("Existen picos a este material","Existen picos con este material ¿Asignar linea ?",Question!,YesNo!)= 2 Then
					f_activar_campo(em_cantidad)
				return
			END IF
		END IF
	END IF
END IF
la.cantidad_ped     = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.getRow(),"cantidad"))
la.deposito         = f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.getRow(),"venliped_deposito")
la.almacen_deposito = f_valor_columna(apartados.pagina_2.dw_pedidos,apartados.pagina_2.dw_pedidos.getRow(),"venliped_almacen_deposito")
la.usuario          = nombre_usuario
la.pallets          = Dec(em_pallets.text)

IF Not f_insert_almlincargas(la) Then f_mensaje("Error insert_almlinubic",sqlca.sqlerrtext)
COMMIT;
apartados.pagina_2.dw_pedidos.SetREDraw(FALSE)
apartados.pagina_2.dw_pedidos.SetReDraw(TRUE)
apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_2.dw_pedidos.triggerEvent(RowFocusChanged!)
end event

type dw_proceso from datawindow within w_int_almcargas
boolean visible = false
integer x = 2395
integer y = 8
integer width = 494
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica_referencia"
boolean livescroll = true
end type

type em_anyo from u_em_campo within w_int_almcargas
integer x = 343
integer y = 156
integer width = 233
integer taborder = 0
end type

type em_referencia from u_em_campo within w_int_almcargas
integer x = 2272
integer y = 268
integer width = 585
integer taborder = 0
boolean bringtotop = true
long textcolor = 128
boolean displayonly = true
string displaydata = ""
end type

type st_2 from statictext within w_int_almcargas
integer x = 2121
integer y = 276
integer width = 133
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Ref:"
boolean focusrectangle = false
end type

type dw_bandas from datawindow within w_int_almcargas
boolean visible = false
integer x = 1056
integer y = 12
integer width = 955
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_almcargas_bandas"
boolean livescroll = true
end type

type st_10 from statictext within w_int_almcargas
boolean visible = false
integer x = 23
integer y = 1340
integer width = 174
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_almcargas
boolean visible = false
integer x = 197
integer y = 1340
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_13 from statictext within w_int_almcargas
boolean visible = false
integer x = 443
integer y = 1340
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "T.Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cantidad from statictext within w_int_almcargas
boolean visible = false
integer x = 690
integer y = 1340
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_pallets from u_em_campo within w_int_almcargas
event modificado pbm_custom02
boolean visible = false
integer x = 23
integer y = 1416
integer width = 174
integer taborder = 60
boolean bringtotop = true
alignment alignment = right!
end type

event modificado;call super::modificado;string cadena,v_caja
v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"venliped_caja")
cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                          var_tipo_pallet,&
								  v_caja,&
                          integer(em_pallets.text),&
                          0,0)
                      
em_pallets.text      =TRIM(Mid(cadena,1,6))
em_cajas.text        =TRIM(Mid(cadena,7,6))
em_t_cajas.text      =TRIM(Mid(cadena,13,6))
em_cantidad.text     =TRIM(Mid(cadena,19,9))

f_peso_linea()
end event

type em_cajas from u_em_campo within w_int_almcargas
event modificado pbm_custom02
boolean visible = false
integer x = 197
integer y = 1416
integer width = 247
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
end type

event modificado;call super::modificado;string cadena,v_caja
v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"venliped_caja")
cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                          var_tipo_pallet,v_caja,&
                           integer(em_pallets.text),&
                           integer(em_cajas.text),&
                           0)
                      
em_pallets.text    = Trim(Mid(cadena,1,6))
em_cajas.text      = Trim(Mid(cadena,7,6))
em_t_cajas.text    = Trim(Mid(cadena,13,6))
em_cantidad.text   = Trim(Mid(cadena,19,9))
f_peso_linea()
end event

type em_t_cajas from u_em_campo within w_int_almcargas
boolean visible = false
integer x = 443
integer y = 1416
integer width = 247
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type em_cantidad from u_em_campo within w_int_almcargas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
boolean visible = false
integer x = 690
integer y = 1416
integer width = 343
integer taborder = 80
boolean bringtotop = true
alignment alignment = right!
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)

end event

event modificado;call super::modificado;If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_pallets.text=""
END  IF

 string cadena,v_caja
 v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"venliped_caja")
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text    = Trim(Mid(cadena,1,6))
 em_cajas.text      = Trim(Mid(cadena,7,6))
 em_t_cajas.text    = Trim(Mid(cadena,13,6))
 em_cantidad.text   = Trim(Mid(cadena,19,9))
f_peso_linea()
end event

type st_20 from statictext within w_int_almcargas
boolean visible = false
integer x = 1806
integer y = 1340
integer width = 315
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Peso Ln"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_21 from statictext within w_int_almcargas
boolean visible = false
integer x = 2126
integer y = 1340
integer width = 375
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Peso Carga"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_22 from statictext within w_int_almcargas
boolean visible = false
integer x = 2501
integer y = 1340
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Peso Max."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_peso_linea from u_em_campo within w_int_almcargas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
boolean visible = false
integer x = 1806
integer y = 1416
integer width = 315
integer taborder = 0
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
textcase textcase = anycase!
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
end event

event modificado;call super::modificado;If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_pallets.text=""
END  IF

 string cadena,v_caja
 v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"caja")
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text  =Mid(cadena,1,6)
 em_cajas.text      =Mid(cadena,7,6)
 em_t_cajas.text    =Mid(cadena,13,6)
 em_cantidad.text   =Mid(cadena,19,9)

end event

type em_peso_carga from u_em_campo within w_int_almcargas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
boolean visible = false
integer x = 2126
integer y = 1416
integer width = 375
integer taborder = 0
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
end event

event modificado;call super::modificado;If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_pallets.text=""
END  IF

 string cadena,v_caja
 v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"caja")
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text  =Mid(cadena,1,6)
 em_cajas.text      =Mid(cadena,7,6)
 em_t_cajas.text    =Mid(cadena,13,6)
 em_cantidad.text   =Mid(cadena,19,9)

end event

type em_peso_maximo from u_em_campo within w_int_almcargas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
boolean visible = false
integer x = 2501
integer y = 1416
integer width = 338
integer taborder = 0
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
end event

event modificado;call super::modificado;If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_pallets.text=""
END  IF

 string cadena,v_caja
 v_caja = apartados.pagina_2.dw_pedidos.GetItemString(apartados.pagina_2.dw_pedidos.GetRow(),"caja")
 cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
                            var_tipo_pallet,v_caja,&
                            integer(em_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text  =Mid(cadena,1,6)
 em_cajas.text      =Mid(cadena,7,6)
 em_t_cajas.text    =Mid(cadena,13,6)
 em_cantidad.text   =Mid(cadena,19,9)

end event

type dw_packing from datawindow within w_int_almcargas
boolean visible = false
integer x = 5
integer width = 494
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_almcargas_packing"
boolean livescroll = true
end type

type cb_todo from u_boton within w_int_almcargas
event clicked pbm_bnclicked
boolean visible = false
integer x = 1079
integer y = 1348
integer height = 80
integer taborder = 100
boolean bringtotop = true
string text = "F6 Todo Ped."
end type

event clicked;Integer  var_numero_pico,opcion,r,bien
String   busq,var_deposito,var_almacen_deposito
dateTime var_forden
String var_es_pico,var_formato,var_parcial,var_impbandas,var_situacion_pedido
str_almlincargas la
la.empresa = codigo_empresa
iF cb_insertar.enabled = FALSE Then apartados.TriggerEvent("pulsar_datawindow")
iF cb_insertar.enabled = FALSE Then return
IF this.visible = FALSE Then Return

Dec{0} varanyo,varorden,var_anyo,var_ped
varanyo    = Dec(em_anyo.text)
varorden   = Dec(sle_valor.text)
var_anyo   = apartados.pagina_2.dw_pedidos.GetItemNumber(apartados.pagina_2.dw_pedidos.GetRow(),"anyo")
var_ped    = apartados.pagina_2.dw_pedidos.GetItemNumber(apartados.pagina_2.dw_pedidos.GetRow(),"pedido")

if f_orden_impresa_sn(codigo_empresa,varanyo,varorden) and f_pedido_impreso(codigo_empresa,var_anyo,var_ped)  then
   if acceso<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Orden y pedido impresos, usted no puede asignar lineas.")
		 Return
	End if
End if


For r = 1 To apartados.pagina_2.dw_pedidos.RowCount()
	IF var_anyo   = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"anyo") and &
      var_ped    = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"pedido") Then

				var_impbandas        = "N"
				var_es_pico          = "N"
				var_numero_pico      = Dec(f_valor_columna(apartados.pagina_2.dw_pedidos,r,"venliped_numero_pico"))
				var_situacion_pedido = apartados.pagina_2.dw_pedidos.GetItemString(r,"venliped_situacion")
	         				
				Dec{4} var_orden,var_linea,var_pallets,var_tono,var_calibre,var_cajas,var_total_cajas,var_cantidad,var_cantidad_ped,var_peso_bruto,var_peso_neto,cant_linea
				String var_matricula,var_montajeartcal,var_tipo_unidad,var_usuario 
				Datetime var_fcarga,var_fecha_ped
			
				la.anyo  = Dec(em_anyo.text)
				la.orden = Dec(sle_valor.text)
				
				Select Max(almlincargas.linea) Into :la.linea From almlincargas
				Where  almlincargas.empresa = :codigo_empresa
				And    almlincargas.anyo    = :la.anyo
				And    almlincargas.orden   = :la.orden;
				iF IsNull(la.linea) Then la.linea = 0
							
				la.empresa          = codigo_empresa
				la.linea_ped        = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"linea")
				la.cantidad         = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"cantidad")
				cant_linea          = f_cantidad_almlincarga_lnpedido( codigo_empresa ,var_anyo,var_pedido ,  la.linea_ped)
				la.cantidad         = la.cantidad - cant_linea
            la.linea            = la.linea + 1
				la.pedido           = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"pedido")
				la.matricula        = f_valor_columna(dw_pag1,1,"matricula")
				la.cliente          = f_valor_columna(dw_pag1,1,"cliente")
				la.fcarga           = apartados.pagina_1.dw_ref.GetItemDateTime(1,"fcarga")
				la.forden           = dw_pag1.GetItemDateTime(1,"forden")
				la.tipo_pallet      = apartados.pagina_2.dw_pedidos.GetItemString(r,"venliped_tipo_pallet")
				la.caja             = apartados.pagina_2.dw_pedidos.GetItemString(r,"venliped_caja")
				la.anyo_ped         = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"anyo")
				la.fecha_ped        = apartados.pagina_2.dw_pedidos.GetItemDateTime(r,"fpedido")
				la.articulo         = apartados.pagina_2.dw_pedidos.GetItemString(r,"articulo")
				la.calidad          = apartados.pagina_2.dw_pedidos.GetItemString(r,"calidad")
				la.tonochar         = apartados.pagina_2.dw_pedidos.GetItemstring(r,"venliped_tonochar")
				la.calibre          = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"calibre")
				la.cajas            = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"cajas")
				la.total_cajas      = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"total_cajas")
				la.parcial          = "N"
				la.cantidad_ped     = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"cantidad")
				la.deposito         = f_valor_columna(apartados.pagina_2.dw_pedidos,r,"venliped_deposito")
				la.almacen_deposito = f_valor_columna(apartados.pagina_2.dw_pedidos,r,"venliped_almacen_deposito")
				la.usuario          = nombre_usuario
				la.pallets          = apartados.pagina_2.dw_pedidos.GetItemNumber(r,"pallets")
				la.situacion_pedido = apartados.pagina_2.dw_pedidos.GetItemString(r,"venliped_situacion")
				la.almacen_de_carga = apartados.pagina_2.dw_pedidos.getItemSTring(r,"venliped_almacen_de_carga")
				IF la.cantidad <> 0 Then
					IF la.pallets   = 0 Then la.es_pico = "S"
					IF Not f_insert_almlincargas(la) Then bien = 1
				END IF
	END IF
			
	f_mensaje_proceso("ASIGNANDO",r,apartados.pagina_2.dw_pedidos.RowCount())
Next
			
IF bien = 1 Then
		ROLLBACK;
		f_mensaje("Error en proceso","la operacion no se contabiliza")
	ELSE
		COMMIT;
			IF control_peso = "S" Then
				control_peso = "N"
				IF Dec(em_peso_maximo.text) <> 0 Then
					IF Dec(em_peso_maximo.text) < Dec(em_peso_carga.text) + Dec(em_peso_linea.text)  Then
						MessageBox("Peso superado","Peso en carga superior al Maximo",Exclamation!,Ok!) 
					END IF
				END IF
			END IF

END IF

apartados.pagina_2.dw_pedidos.SetREDraw(FALSE)
apartados.pagina_2.dw_pedidos.SetReDraw(TRUE)
apartados.pagina_3.dw_lineas.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_2.dw_pedidos.triggerEvent(RowFocusChanged!)
end event

type st_f2 from statictext within w_int_almcargas
integer x = 910
integer y = 128
integer width = 69
integer height = 40
boolean bringtotop = true
integer textsize = -5
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "F2"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_almcargas
integer x = 18
integer y = 144
integer width = 2523
integer height = 1272
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

