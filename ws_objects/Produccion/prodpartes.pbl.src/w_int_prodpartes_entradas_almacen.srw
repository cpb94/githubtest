$PBExportHeader$w_int_prodpartes_entradas_almacen.srw
forward
global type w_int_prodpartes_entradas_almacen from w_int_con_empresa
end type
type st_texto from statictext within w_int_prodpartes_entradas_almacen
end type
type st_5 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_4 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_3 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_2 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_9 from statictext within w_int_prodpartes_entradas_almacen
end type
type pb_1 from upb_salir within w_int_prodpartes_entradas_almacen
end type
type em_tono from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type em_calibre from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type sle_observaciones from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type cb_1 from u_boton within w_int_prodpartes_entradas_almacen
end type
type cb_3 from u_boton within w_int_prodpartes_entradas_almacen
end type
type uo_articulo from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type uo_calidad from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type pb_borrar from upb_papelera within w_int_prodpartes_entradas_almacen
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type pb_imprimir_preli from picturebutton within w_int_prodpartes_entradas_almacen
end type
type dw_listado from datawindow within w_int_prodpartes_entradas_almacen
end type
type dw_4 from datawindow within w_int_prodpartes_entradas_almacen
end type
type st_10 from statictext within w_int_prodpartes_entradas_almacen
end type
type uo_caja from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type st_1 from statictext within w_int_prodpartes_entradas_almacen
end type
type pb_modificar from upb_papelera within w_int_prodpartes_entradas_almacen
end type
type dw_stock_mat_prima from datawindow within w_int_prodpartes_entradas_almacen
end type
type dw_stock_prod_terminado from datawindow within w_int_prodpartes_entradas_almacen
end type
type uo_operario from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type st_operario from statictext within w_int_prodpartes_entradas_almacen
end type
type st_tipoparte from statictext within w_int_prodpartes_entradas_almacen
end type
type ddlb_turnos from dropdownlistbox within w_int_prodpartes_entradas_almacen
end type
type st_turno from statictext within w_int_prodpartes_entradas_almacen
end type
type em_fecha from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type st_fecha from statictext within w_int_prodpartes_entradas_almacen
end type
type st_texto_cantidad from statictext within w_int_prodpartes_entradas_almacen
end type
type st_texto_cantidad2 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_entrada from statictext within w_int_prodpartes_entradas_almacen
end type
type em_cantidad_entrada from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type st_texto_tiempo from statictext within w_int_prodpartes_entradas_almacen
end type
type em_cantidad_salida from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type dw_2 from datawindow within w_int_prodpartes_entradas_almacen
end type
type cb_4 from u_boton within w_int_prodpartes_entradas_almacen
end type
type cb_borrar from u_boton within w_int_prodpartes_entradas_almacen
end type
type cb_2 from u_boton within w_int_prodpartes_entradas_almacen
end type
type dw_1 from datawindow within w_int_prodpartes_entradas_almacen
end type
type dw_compuesto from datawindow within w_int_prodpartes_entradas_almacen
end type
type dw_almlinubicahis from datawindow within w_int_prodpartes_entradas_almacen
end type
type dw_3 from datawindow within w_int_prodpartes_entradas_almacen
end type
type em_t_pallets from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type em_cajas from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type em_t_cajas from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type st_7 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_6 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_8 from statictext within w_int_prodpartes_entradas_almacen
end type
type dw_ex from datawindow within w_int_prodpartes_entradas_almacen
end type
type pb_calculadora from u_calculadora within w_int_prodpartes_entradas_almacen
end type
type sle_numdoc from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type st_documento from statictext within w_int_prodpartes_entradas_almacen
end type
type uo_tipoparte from u_em_campo_2 within w_int_prodpartes_entradas_almacen
end type
type em_minutos from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type em_horas from u_em_campo within w_int_prodpartes_entradas_almacen
end type
type st_11 from statictext within w_int_prodpartes_entradas_almacen
end type
type st_12 from statictext within w_int_prodpartes_entradas_almacen
end type
type dw_incidencias from u_datawindow_consultas within w_int_prodpartes_entradas_almacen
end type
type st_13 from statictext within w_int_prodpartes_entradas_almacen
end type
end forward

global type w_int_prodpartes_entradas_almacen from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 3657
integer height = 2208
string icon = "\bmp\RINO.ICO"
st_texto st_texto
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_9 st_9
pb_1 pb_1
em_tono em_tono
em_calibre em_calibre
sle_observaciones sle_observaciones
cb_1 cb_1
cb_3 cb_3
uo_articulo uo_articulo
uo_calidad uo_calidad
pb_borrar pb_borrar
uo_tipo_pallet uo_tipo_pallet
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_4 dw_4
st_10 st_10
uo_caja uo_caja
st_1 st_1
pb_modificar pb_modificar
dw_stock_mat_prima dw_stock_mat_prima
dw_stock_prod_terminado dw_stock_prod_terminado
uo_operario uo_operario
st_operario st_operario
st_tipoparte st_tipoparte
ddlb_turnos ddlb_turnos
st_turno st_turno
em_fecha em_fecha
st_fecha st_fecha
st_texto_cantidad st_texto_cantidad
st_texto_cantidad2 st_texto_cantidad2
st_entrada st_entrada
em_cantidad_entrada em_cantidad_entrada
st_texto_tiempo st_texto_tiempo
em_cantidad_salida em_cantidad_salida
dw_2 dw_2
cb_4 cb_4
cb_borrar cb_borrar
cb_2 cb_2
dw_1 dw_1
dw_compuesto dw_compuesto
dw_almlinubicahis dw_almlinubicahis
dw_3 dw_3
em_t_pallets em_t_pallets
em_cajas em_cajas
em_t_cajas em_t_cajas
st_7 st_7
st_6 st_6
st_8 st_8
dw_ex dw_ex
pb_calculadora pb_calculadora
sle_numdoc sle_numdoc
st_documento st_documento
uo_tipoparte uo_tipoparte
em_minutos em_minutos
em_horas em_horas
st_11 st_11
st_12 st_12
dw_incidencias dw_incidencias
st_13 st_13
end type
global w_int_prodpartes_entradas_almacen w_int_prodpartes_entradas_almacen

type variables
//str_parametros  istr_parametros
   integer contador,v_altura,v_fila,anyo
  decimal{4} v_cantidad
  decimal{4} ante_valor, ante_cant
  String v_almacen,v_zona,cod_sector
  string ante_numdoc
  String situado
  Boolean  control_tono,control_calibre
// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis       mov
// Especial: modificación de entradas
Boolean especial = false
Boolean articulo_compuesto = false
string numero_documento
boolean pedir_caja,pedir_calibre,pedir_calidad
boolean pedir_cantidad_entrada,pedir_tiempo,pedir_tipo_pallet
boolean pedir_tono,genera_entrada_almacen
string entrada_en_unidad_articulo
string salida_en_unidad_articulo
string unidad_entrada,unidad_salida
dec cantidad_salida_unidad_articulo
end variables

forward prototypes
public subroutine f_control_tono_calibre ()
public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones)
public subroutine f_procesar_entrada ()
public subroutine f_procesar_modificacion ()
public function boolean f_control_compuesto ()
public function boolean f_procesar_salida_compuesto (string arg_almacen, integer arg_anyo, long arg_nummov)
public function boolean f_salida_materia_prima (long indice, string arg_almacen, integer arg_anyo, long arg_nummov)
public function boolean f_salida_producto_terminado (long indice, string arg_almacen, integer arg_anyo, integer arg_nummov)
public function boolean f_anular_salida_mp (string arg_almacen, integer arg_anyo, long arg_nummov)
public function boolean f_anular_salida_producto_terminado (string arg_almacen, integer arg_anyo, long arg_nummov)
public subroutine f_consulta ()
public function boolean f_grabar_parte_produccion (string arg_almacen, integer arg_anyo, decimal arg_nummov)
public function boolean f_borrar_parte_produccion (long arg_linea)
public subroutine f_campos_segun_tipoparte ()
public subroutine f_vacia_campos ()
end prototypes

public subroutine f_control_tono_calibre ();control_tono     =  TRUE
control_calibre  =  TRUE
 
IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_tono   =  FALSE
 	em_tono.text   =  ""
else
	if uo_calidad.em_codigo.text = "2" then em_tono.text =  "0"
	if em_tono.text = "" then	em_tono.text =  "1"
END IF


IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text =  "0"
else
   if em_calibre.text = "" then em_calibre.text    =  "1"
END IF  

if not(pedir_tono) then
	em_tono.text =  ""
end if
if not(pedir_calibre) then
	em_calibre.text =  ""
end if
end subroutine

public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones);Integer orden
DateTime   fecha
Select Max(orden) Into :orden From almlinubica_observaciones
Where  almlinubica_observaciones.empresa   = :codigo_empresa
And    almlinubica_observaciones.ubicacion = :ubicacion
And    almlinubica_observaciones.linea     = :linea;
IF IsNull(orden) Then orden = 0
orden = orden +1
fecha = DateTime(Today(),Now())
  INSERT INTO almlinubica_observaciones  
         ( empresa,   
           ubicacion,   
           linea,   
           orden,   
           fecha,   
           usuario,   
           observaciones )  
  VALUES ( :empresa,   
           :ubicacion,   
           :linea,   
           :orden,   
           :fecha,   
           :nombre_usuario,   
           :observaciones )  ;
		




end subroutine

public subroutine f_procesar_entrada ();//---------------------//
// Control Ubicaciones //
//---------------------//

String     antealmacen
dec        y1,longitudes
Date       fecha
int        v_anyo
Dec        numero,controles,x2,x1,alm_numdoc
Decimal{4} total_cantidad
string     mensaje,nombre,campo
boolean    compras_bloqueadas,continuar

controles   = 0
contador    = dw_1.Rowcount()
IF contador = 0 THEN
	MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
	Return
END IF

if dec(sle_numdoc.text) = 0 then
	v_anyo = year(date(em_fecha.text))
	
	SELECT max(convert(dec,almmovhis.numdoc))
	INTO   :alm_numdoc  
	FROM   almmovhis  
	WHERE  almmovhis.empresa  = :codigo_empresa
	AND    almmovhis.anyo     = :v_anyo 
	AND    almmovhis.tipomov  = "1"
	AND    almmovhis.numdoc   between "0" and "999999999999999";
	
	IF SQLCA.SQLCode <> 0 THEN   alm_numdoc = 0
	IF IsNUll(alm_numdoc) Then alm_numdoc = 0
	
	alm_numdoc       = alm_numdoc + 1
	numero_documento = string(alm_numdoc,"#######")
	sle_numdoc.text  = numero_documento
else
	numero_documento = sle_numdoc.text
end if
dw_1.Accepttext()

FOR x2=1 TO contador
	v_almacen    = dw_1.GetItemString(x2,"almacen")	
	v_zona       = dw_1.GetItemString(x2,"zona")	
	v_fila       = dw_1.GetItemNumber(x2,"fila")	
	v_altura     = dw_1.GetItemNumber(x2,"altura")	
	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
	IF IsNull(v_fila)   Then v_fila = 0
	IF IsNull(v_altura) Then v_altura = 0
	// Redondeo la cantidad 
	dw_1.SetItem(x2,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,v_cantidad))
	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
		
	IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
		controles = 1
		campo     = "almacen"
		mensaje   = " Introduzca el almacen "
	END IF
	
	If x2 > 1 Then
		IF antealmacen<> v_almacen THEN
			campo     = "almacen"
			controles = 1
			mensaje   = " Todos los Movimientos Deben de ubicarse en un mismo almacen "
		END IF
	END IF
	
	IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
		controles = 1
		campo     = "zona"
		mensaje   = " Introduzca la zona "
	END IF
	
	IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
		controles = 1
		campo     = "fila"
		mensaje   = "Introduzca la fila de la ubicacion"
	END IF
	
	IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
		controles = 1
		campo     = "altura"
		mensaje   = "Introduzca la altura de la ubicacion"
	END IF
	
	IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
		controles = 1
		campo     = "cantidad"
		mensaje   = "Introduzca la cantidad"
	END IF
	
	nombre = f_nombre_almacen(codigo_empresa,v_almacen)
	IF (trim(nombre)="") and controles=0 THEN
		mensaje   = "El almacen no existe "
		controles = 1
		campo    = "almacen"
	END IF
	
	nombre = f_nombre_zona(codigo_empresa,v_almacen,v_zona)
	IF (trim(nombre)="") and controles=0 THEN
		mensaje   = "La zona no existe"
		controles = 1
		campo     = "zona"
	END IF
	
	IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
		mensaje   = "La ubicacion no esta contemplada en el mapa de ubicaciones"
		controles = 1
		campo     = "almacen"
	END IF
	
	IF controles = 1 THEN
		MessageBox("Campo obligatorio en linea"+string(x2),mensaje,Exclamation!, OK!,1)
		dw_1.SetColumn(campo)
		dw_1.setRow(x2)
		dw_1.setfocus()
		Return
	END IF
	antealmacen = v_almacen
NEXT

total_cantidad = dec(string(dw_1.GetItemNumber(1,"total_cantidad"),f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))))

IF total_cantidad <> cantidad_salida_unidad_articulo THEN
	MessageBox("No Puedo Procesar","Los totales no coinciden",Exclamation!, OK!,1)
	Return
END IF

pb_1.enabled = FALSE

if articulo_compuesto then
	IF Not f_bloquear_almacen_compras(w_int_prodpartes_entradas_almacen.title) Then
		compras_bloqueadas = true
		continuar          = true
	else
		compras_bloqueadas = false
		continuar          = false
	end if
else
	continuar = true
end if		

if continuar then
	IF Not f_bloquear_almacen(w_int_prodpartes_entradas_almacen.title) Then
		//---------------------------------------------------------------------
		// Despues de todos los controles empezamos el proceso de inserción
		//---------------------------------------------------------------------
		// Contador de movimiento y orden de lineas de  ubicacion
		Dec contador_nummov,contador_orden 
		
		// Valor de controles funcionamiento
		dec bien
		//------------------------------------------------------------------------
		// Valores fijos para todos los casos
		//------------------------------------------------------------------------
		ubihis.usuario       = nombre_usuario
		mov.usuario          = nombre_usuario
		ubihis.empresa       = codigo_empresa
		ubihis.anyo          = year(date(em_fecha.text))
		ubihis.almacen       = v_almacen
		ubihis.articulo      = uo_articulo.em_codigo.text
		ubihis.calidad       = uo_calidad.em_codigo.text
		ubihis.tonochar      = Trim(em_tono.text)
		ubihis.calibre       = dec(em_calibre.text)
		IF IsNUll(ubihis.calibre) Then ubihis.calibre = 0
		IF IsNUll(ubihis.tonochar)  Then ubihis.tonochar = ""
		ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
		ubihis.f_alta        = DateTime(Today(),now())
		ubihis.observaciones = sle_observaciones.text
		ubihis.tipomov       = "1" //Entrada de producción
		ubihis.tipo_pallet   = uo_tipo_pallet.em_codigo.text
		ubihis.caja          = uo_caja.em_codigo.text
		setnull(ubihis.comp_almacen)
		setnull(ubihis.comp_anyo)
		setnull(ubihis.comp_nummov)
		setnull(mov.comp_almacen)
		setnull(mov.comp_anyo)
		setnull(mov.comp_nummov)

		
		
		SELECT articulos.familia,
				 articulos.formato,
				 articulos.modelo,
				 articulos.unidad,
				 articulos.sector
		INTO   :ubihis.familia,
				 :ubihis.formato,   
				 :ubihis.modelo,
				 :ubihis.tipo_unidad,
				 :ubihis.sector
		FROM   articulos  
		WHERE  articulos.empresa= :ubihis.empresa
		AND    articulos.codigo = :ubihis.articulo;
		
		IF SQLCA.SQLCode <> 0 THEN bien = 1
		ubihis.referencia   = f_componer_ref(ubihis.articulo,&
														 ubihis.calidad,&
														 ubihis.tonochar,&
														 ubihis.calibre)
		
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
		ubi.referencia = mov.referencia
		mov.f_alta     =  DateTime(Today(),now())
		fecha          =  Date(String(em_fecha.text))
		mov.anyo       =  year(fecha)
		mov.origen     = "1"
		mov.fechmov    = ubihis.fecha
		mov.tipomov    = ubihis.tipomov
		mov.cantidade  = cantidad_salida_unidad_articulo
		mov.cantidads  =0
		mov.precio     =0
		SetNull(mov.codtercero)
		mov.numdoc        = numero_documento
		mov.situacion     = "N"
		mov.observaciones = sle_observaciones.text
		SetNull(mov.punteado)
		mov.antexist   =0
		// Variable utilizada para montaje observaciones en lineas de ubicacion
		String var_observaciones
		//-------------------------------------------------------------------
		contador_nummov= f_almparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
		contador_orden = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
		mov.nummov     = contador_nummov
		ubihis.nummov  = contador_nummov
		ubihis.orden   = contador_orden
		contador = dw_1.Rowcount()
		
		FOR x2=1 TO contador
			ubihis.zona       = dw_1.GetItemString(x2,"zona")	
			ubihis.fila       = dw_1.GetItemNumber(x2,"fila")	
			ubihis.altura     = dw_1.GetItemNumber(x2,"altura")	
			IF IsNull(ubihis.altura) Then ubihis.altura = 0
			ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")	
			ubihis.orden      = contador_orden
			ubihis.nummov     = contador_nummov
			ubihis.observaciones  = mov.observaciones
			ubihis.f_alta     = DateTime(Today(),now())
			ubihis.usuario    = nombre_usuario
			ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
				 ubihis.fila,ubihis.altura)
			ubihis.cantidads    = 0
			ubi.zona            = ubihis.zona
			ubi.fila            = ubihis.fila
			ubi.altura          = ubihis.altura
			ubi.existencias     = ubihis.cantidade
			ubi.ubicacion       = ubihis.ubicacion
			//------------------------------------------------------------------
			// Inserto en el historico de lineas de ubicacion por movimiento
			//------------------------------------------------------------------
			ubihis.observaciones =  String(today(),"dd/mm/yy") + "-" + sle_observaciones.text  
			IF Not f_insert_almlinubicahis(ubihis) Then  bien=1
			
			
			//-----------------------------------------------------------------------
			// Variables para cargar el cursor
			//-----------------------------------------------------------------------
			String cur_empresa,cur_almacen
			dec cur_pedido,cur_linea,cur_anyo
			decimal{4}  cur_existencias
			string  cur_referencia,cur_ubicacion,cur_tipo_pallet
			
			//----------------------------------------------------------
			// Busco si hay linea este articulo sin reservar
			//---------------------------------------------------------
			dec registros
			String sel
			DataStore dw_proceso 
			Sel = " SELECT   linea,existencias  " + &
					" FROM     almlinubica  " + &
					" WHERE    almlinubica.empresa    = '"+ codigo_empresa  + "'" +&
					" AND      almlinubica.ubicacion  = '"+ ubi.ubicacion + "'" +&
					" AND      almlinubica.referencia = '"+ ubi.referencia + "'" + &
					" AND      almlinubica.tipo_pallet= '"+ ubihis.tipo_pallet + "'" + &
					" AND      almlinubica.caja       = '"+ ubihis.caja + "'" + &
					" AND      almlinubica.pedido is null "
			dw_proceso = f_cargar_cursor2(sel)
			registros  = dw_proceso.RowCount()
			dec grabado,salir
			grabado = 0
			salir   = 0
			IF registros<>0 THEN
				FOR x1 = 1 To registros
					cur_empresa       = codigo_empresa
					cur_almacen       = f_almacen_ubicacion(ubi.ubicacion)
					cur_ubicacion     = ubi.ubicacion
					cur_referencia    = ubi.referencia
					IF Not IsNull(sle_observaciones.text) and Trim(sle_observaciones.text) <> "" Then
						f_insertar_observaciones(codigo_empresa,cur_ubicacion,cur_linea,sle_observaciones.text)
					END IF
					cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")
					cur_tipo_pallet   = ubihis.tipo_pallet
					cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
					grabado = 1
					ubi.existencias   = ubi.existencias + cur_existencias
					
					UPDATE almlinubica  
					SET existencias   = :ubi.existencias,   
					f_alta            = :ubi.f_alta
					WHERE  almlinubica.empresa   = :ubi.empresa 
					AND    almlinubica.ubicacion = :ubi.ubicacion 
					AND    almlinubica.linea     = :cur_linea  USING SQLCA;
					
					IF SQLCA.SQLCode<>0 THEN  bien = 1
					EXIT
				NEXT
			END IF
			IF grabado=0 THEN
				cur_linea = 0
				SELECT  max(almlinubica.linea)
				INTO    :cur_linea 
				FROM    almlinubica  
				WHERE   almlinubica.empresa   = :ubi.empresa 
				AND     almlinubica.ubicacion = :ubi.ubicacion;
				
				IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
					cur_linea = 0 
				END IF
				
				cur_linea = cur_linea + 1
				ubi.linea = cur_linea
				SetNull(ubi.observaciones)
				IF Not IsNull(sle_observaciones.text) and Trim(sle_observaciones.text) <> "" Then
					f_insertar_observaciones(codigo_empresa,ubi.ubicacion,ubi.linea,sle_observaciones.text)
				END IF
				IF NOT f_insert_almlinubica(ubi) Then  bien=1			
			END IF
			//-----------------------Fin Grabación Lineas de Ubicacion--------------
			// el contador incrementa uno para cada linea
			contador_orden = contador_orden + 1
		NEXT
		
		// Grabar el movimiento en el historico por el total de existencias
		IF NOT f_insert_almmovhis(mov) Then
			MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
			bien=1
		END IF
		IF NOT f_actualiza_nummov(mov.empresa,Year(Date(em_fecha.text)),mov.nummov) THEN
			bien=1
		END IF
		IF NOT f_actualiza_numorden(ubihis.empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
			bien=1
		END IF
		//Grabamos el parte de producción
		if not(f_grabar_parte_produccion(mov.almacen,mov.anyo,mov.nummov)) then
			bien = 1
		end if
		if articulo_compuesto then
			if not(f_procesar_salida_compuesto(mov.almacen,mov.anyo,mov.nummov)) then
				bien = 1
			end if
		end if
		CHOOSE CASE bien
			CASE 1
				ROLLBACK USING SQLCA;
				MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
			CASE 0
				COMMIT USING SQLCA;		
			CASE ELSE
				ROLLBACK USING SQLCA;
				MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
		END CHOOSE
		f_desbloquear_almacen(w_int_prodpartes_entradas_almacen.title)
		pb_1.enabled = TRUE
		cb_3.TriggerEvent(Clicked!)
	END IF
	
	if articulo_compuesto then
		IF compras_bloqueadas Then
			f_desbloquear_almacen_compras(w_int_prodpartes_entradas_almacen.title)
		end if
	end if		
		
	Long n
	n=dw_3.find("empresa='"+mov.empresa+"'"+" and articulo ='"+mov.articulo +"' and movimiento_nummov="+String(mov.nummov),1,dw_3.rowcount())
	if n>0 then dw_3.ScrollToRow(n)
end if
end subroutine

public subroutine f_procesar_modificacion ();//// Este procedimiento permite realizar modificaciones en entradas de
//// almacén efectuadas en el pasado
////---------------------//
//// Control Ubicaciones //
////---------------------//
//
//String antealmacen
//dec y1,longitudes
//Date fecha
//Dec numero,controles,x2,x1
//Decimal{4} total_cantidad
//string mensaje,nombre,campo
//Integer resp
//
//resp = MessageBox("Modificación de una entrada ","¿Está seguro de que desea modificar la cantidad de esta entrada de almacén?",Question!,YesNo!,1)
//if resp = 2 then return
//
//controles  = 0
//contador = dw_1.Rowcount()
//IF contador=0 THEN
// MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
// Return
//END IF
//dw_1.Accepttext()
//
//FOR x2=1 TO contador
// v_almacen    = dw_1.GetItemString(x2,"almacen")	
// v_zona       = dw_1.GetItemString(x2,"zona")	
// v_fila       = dw_1.GetItemNumber(x2,"fila")	
// v_altura     = dw_1.GetItemNumber(x2,"altura")	
// v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
// IF IsNull(v_fila)   Then v_fila = 0
// IF IsNull(v_altura) Then v_altura = 0
// // Redondeo la cantidad 
// dw_1.SetItem(x2,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,v_cantidad))
// v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
// 
//
//
//IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
// controles=1
// campo="almacen"
// mensaje=" Introduzca el almacén "
//END IF
//
//If x2 > 1 Then
// IF antealmacen<> v_almacen THEN
//  campo="almacen"
//  controles=1
//  mensaje=" Todos los Movimientos deben de ubicarse en un mismo almacén "
// END IF
//END IF
//
//IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
// controles=1
// campo="zona"
// mensaje=" Introduzca la zona "
//END IF
//
//IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
// controles=1
// campo="fila"
// mensaje= "Introduzca la fila de la ubicación"
//END IF
//
//IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
// controles=1
// campo="altura"
// mensaje= "Introduzca la altura de la ubicación"
//END IF
//
//IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
// controles=1
// campo="cantidad"
// mensaje= "Introduzca la cantidad"
//END IF
//
//nombre=f_nombre_almacen(codigo_empresa,v_almacen)
//IF (trim(nombre)="") and controles=0 THEN
//  mensaje="El almacén no existe "
//  controles=1
//  campo="almacen"
//END IF
//
//nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
//IF (trim(nombre)="") and controles=0 THEN
//   mensaje="La zona no existe"
//   controles=1
//   campo="zona"
//END IF
//
// IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
//    mensaje= "La ubicación no esta contemplada en el mapa de ubicaciones"
//    controles=1
//    campo="almacen"
// END IF

//
//IF controles=1 THEN
//  MessageBox("Campo obligatorio en linea"+string(x2),mensaje,Exclamation!, OK!,1)
//  dw_1.SetColumn(campo)
//  dw_1.setRow(x2)
//  dw_1.setfocus()
// Return
//END IF
//antealmacen = v_almacen
//NEXT
//
//total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
//IF total_cantidad<>Dec(em_cantidad.text) THEN
//  MessageBox("No Puedo Procesar","El total de unidades/metros no coinciden",Exclamation!, OK!,1)
//  Return
//END IF
//
//pb_1.enabled=FALSE
//
//
//
//
//IF Not f_bloquear_almacen(w_int_movalm.title) Then
////---------------------------------------------------------------------
//// Despues de todos los controles empezamos el proceso de modificación
////---------------------------------------------------------------------
//// Contador de movimiento y orden de lineas de  ubicacion
//   Dec contador_nummov,contador_orden 
//
//// Valor de controles funcionamiento
//   dec bien
////------------------------------------------------------------------------
//// Valores fijos para todos los casos
////------------------------------------------------------------------------
// ubihis.empresa       = codigo_empresa
//
// ubihis.almacen       = v_almacen
// ubihis.articulo      = uo_articulo.em_codigo.text
// ubihis.calidad       = uo_calidad.em_codigo.text
// ubihis.tonochar      = Trim(em_tono.text)
// ubihis.calibre       = dec(em_calibre.text)
// IF IsNUll(ubihis.calibre) Then ubihis.calibre = 0
// IF IsNUll(ubihis.tonochar)  Then ubihis.tonochar = ""
// ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
// ubihis.f_alta        = DateTime(Today(),now())
// ubihis.observaciones = sle_observaciones.text
// ubihis.tipomov       = sle_tipomov.text
// ubihis.tipo_pallet   = uo_tipo_pallet.em_codigo.text
// ubihis.caja          = uo_caja.em_codigo.text
//
//
//
//  SELECT articulos.familia,articulos.formato,articulos.modelo,
//  			articulos.unidad,articulos.sector
//    INTO :ubihis.familia,:ubihis.formato,   
//         :ubihis.modelo,:ubihis.tipo_unidad  ,:ubihis.sector
//    FROM articulos  
//   WHERE articulos.empresa= :ubihis.empresa
//	AND   articulos.codigo = :ubihis.articulo ;
//IF SQLCA.SQLCode<>0 THEN bien=1
// ubihis.referencia   = f_componer_ref(ubihis.articulo,&
//                                      ubihis.calidad,&
//                                      ubihis.tonochar,ubihis.calibre)
//
//ubi.empresa    =  ubihis.empresa
//ubi.almacen    =  ubihis.almacen
//ubi.articulo   =  ubihis.articulo
//ubi.familia    =  ubihis.familia
//ubi.formato    =  ubihis.formato
//ubi.modelo     =  ubihis.modelo
//ubi.calidad    =  ubihis.calidad
//ubi.tonochar   =  ubihis.tonochar
//ubi.calibre    =  ubihis.calibre
//ubi.tipo_pallet=  ubihis.tipo_pallet
//ubi.caja       =  ubihis.caja
//ubi.sector     =  ubihis.sector
//SetNull(ubi.anyo)
//SetNull(ubi.pedido) 
//SetNull(ubi.linped)
//SetNull(ubi.cliente)
//ubi.tipo_unidad=  ubihis.tipo_unidad
//ubi.referencia =  ubihis.referencia
//ubi.f_alta     =  Datetime(today(),now())
//// Valor movimiento historico
//mov.empresa    =  ubihis.empresa
//mov.almacen    =  ubihis.almacen
//mov.articulo   =  ubihis.articulo
//mov.familia    =  ubihis.familia
//mov.formato    =  ubihis.formato
//mov.modelo     =  ubihis.modelo
//mov.calidad    =  ubihis.calidad
//mov.tonochar   =  ubihis.tonochar
//mov.calibre    =  ubihis.calibre
//mov.tipo_unidad=  ubihis.tipo_unidad
//mov.tipo_pallet=  ubihis.tipo_pallet
//mov.caja       =  ubihis.caja
//mov.sector     =  ubihis.sector
//mov.referencia =  ubihis.referencia
//ubi.referencia =  mov.referencia
//mov.f_alta     =  DateTime(Today(),now())
//fecha          =  Date(String(em_fecha.text))
//mov.anyo       =  year(fecha)
//mov.origen     = "1"
//mov.fechmov    = ubihis.fecha
//mov.tipomov    = ubihis.tipomov
//mov.cantidade  = Dec(em_cantidad.text)
//mov.cantidads  =0
//mov.precio     =0
//IF f_tipo_almtipomov(codigo_empresa,mov.tipomov)="P"  THEN
//  mov.codtercero=sle_proveedor.text
//ELSE
//  SetNull(mov.codtercero)
//END IF
//mov.numdoc        = sle_numdoc.text
//mov.situacion     = "N"
//mov.observaciones = sle_observaciones.text
//SetNull(mov.punteado)
//mov.antexist   =0
//
////// Valor movimiento historico
//mov.empresa    =  ubihis.empresa
//mov.almacen    =  ubihis.almacen
//mov.anyo       =  dw_3.GetItemNumber(dw_3.GetRow(),"almmovhis_anyo")
//
//mov.nummov     = dw_3.GetItemNumber(dw_3.GetRow(),"almmovhis_nummov")
//ubihis.nummov  = mov.nummov
//
// contador = dw_1.Rowcount()
//
// FOR x2=1 TO contador
//	  ubihis.orden      = dw_1.GetItemNumber(x2,"orden")
//     ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")
//     ubihis.usuario    = nombre_usuario
//	  ubihis.almacen    = dw_1.GetItemString(x2,"almacen")
//	  ubihis.zona       = dw_1.GetItemString(x2,"zona")
//	  ubihis.fila       = dw_1.GetItemNumber(x2,"fila")
//	  ubihis.altura     = dw_1.GetItemNumber(x2,"altura")	  
//     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//                                              ubihis.fila,ubihis.altura)
//     ubi.existencias     = ubihis.cantidade
//     ubi.ubicacion       = ubihis.ubicacion
//     //------------------------------------------------------------------
//     // Modifico el historico de lineas de ubicacion por movimiento
//     //------------------------------------------------------------------
//	  update almlinubicahis
//	     set cantidade = :ubihis.cantidade
//		where empresa   = :codigo_empresa
//		  and anyo      = :ubihis.anyo
//		  and almacen   = :ubihis.almacen
//		  and orden     = :ubihis.orden;
//		  
//		if sqlca.sqlcode <> 0 then 
//			bien = 1
//			f_mensaje ("Error al actualizar almlinubicahis", sqlca.sqlerrtext)
//		end if
//
////-----------------------------------------------------------------------
//// Variables para cargar el cursor
////-----------------------------------------------------------------------
//      String cur_empresa,cur_almacen
//      dec cur_pedido,cur_linea,cur_anyo
//      decimal{4}  cur_existencias
//      string  cur_referencia,cur_ubicacion,cur_tipo_pallet
//     
////----------------------------------------------------------
//// Busco si hay linea este articulo sin reservar
////---------------------------------------------------------
//dec registros
//String sel
//DataStore dw_proceso 
//Sel = " SELECT   linea,existencias  " + &
//      " FROM     almlinubica  " + &
//      " WHERE    almlinubica.empresa    = '"+ codigo_empresa  + "'" +&
//		" AND      almlinubica.ubicacion  = '"+ ubi.ubicacion + "'" +&
//		" AND      almlinubica.referencia = '"+ ubi.referencia + "'" + &
//		" AND      almlinubica.tipo_pallet= '"+ ubihis.tipo_pallet + "'" + &
//		" AND      almlinubica.caja       = '"+ ubihis.caja + "'" + &
//		" AND      almlinubica.pedido is null "
//dw_proceso = f_cargar_cursor2(sel)
//registros = dw_proceso.RowCount()
//dec grabado,salir
//grabado=0
//salir  =0
//IF registros<>0 THEN
// FOR x1 = 1 To registros
//  cur_empresa       =   codigo_empresa
//  cur_almacen       =   f_almacen_ubicacion(ubi.ubicacion)
//  cur_ubicacion     =   ubi.ubicacion
//  cur_referencia    =   ubi.referencia
//  cur_existencias   =   dw_proceso.GetItemNumber(x1,"existencias")
//  //***
////  f_mensaje("cur_existencias",String(cur_existencias))
//  
//  ubi.existencias   =   cur_existencias - dw_1.GetItemDecimal(x2,"cant_anterior") + dw_1.GetItemDecimal(x2,"cantidad")
//  //***
////  f_mensaje("ubi.existencias",String(ubi.existencias))
//
//  cur_tipo_pallet   =   ubihis.tipo_pallet
//  cur_linea         =   dw_proceso.GetItemNumber(x1,"linea")
//  grabado = 1
//     //ubi.existencias=ubi.existencias + cur_existencias
//       UPDATE almlinubica  
//       SET existencias   = :ubi.existencias
//       WHERE  almlinubica.empresa   = :ubi.empresa 

//		 AND    almlinubica.ubicacion = :ubi.ubicacion 
//		 AND    almlinubica.linea     = :cur_linea  USING SQLCA;
//       IF SQLCA.SQLCode<>0 THEN  
//			bien=1
//			f_mensaje("Error en actualización de almlinubica",sqlca.sqlerrtext)
//			exit 
//		end if
//			
//NEXT
//END IF
//IF grabado=0 THEN
//    ubi.existencias   =  dw_1.GetItemDecimal(x2,"cantidad") - dw_1.GetItemDecimal(x2,"cant_anterior")
//    cur_linea=0
//    SELECT  max(almlinubica.linea)  INTO :cur_linea FROM almlinubica  
//   WHERE   almlinubica.empresa   = :ubi.empresa 
//	AND     almlinubica.ubicacion = :ubi.ubicacion;
//   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
//    cur_linea = 0 
//   END IF
//    cur_linea=cur_linea+1
//    ubi.linea=cur_linea
//    SetNull(ubi.observaciones)
//    IF NOT f_insert_almlinubica(ubi) Then  bien=1
//
//END IF
////-----------------------Fin Grabación Lineas de Ubicacion--------------
//// el contador incrementa uno para cada linea
//     contador_orden = contador_orden + 1
//NEXT
//
// // Grabar el movimiento en el historico por el total de existencias
//   update almmovhis
//	   set cantidade = :mov.cantidade
//	 where almmovhis.empresa =:codigo_empresa
//	   and almmovhis.almacen =:mov.almacen
//		and almmovhis.anyo    =:mov.anyo
//		and almmovhis.nummov  =:mov.nummov;
//		
//	if sqlca.sqlcode <> 0 then
//      f_mensaje("Error modificando almmovhis",sqlca.sqlerrtext)
//      bien=1
//   END IF
////****
////bien=1
//  CHOOSE CASE bien
//	CASE 1
//     ROLLBACK USING SQLCA;
//     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
//	CASE 0
//     COMMIT USING SQLCA;
//   CASE ELSE
//     ROLLBACK USING SQLCA;
//     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
//  END CHOOSE
//  f_desbloquear_almacen(w_int_movalm.title)
//pb_1.enabled=TRUE
//cb_3.TriggerEvent(Clicked!)
//END IF
//
end subroutine

public function boolean f_control_compuesto ();long    indice,total
boolean correcto = true
string  ubicacion

total  = dw_compuesto.rowcount()
indice = 1

if total > 0 then
	do			
		ubicacion = dw_compuesto.object.ubicacion[indice]
		if isnull(ubicacion) then ubicacion = ""
		if trim(ubicacion) = "" then
			dw_compuesto.selectrow(0,false)
			dw_compuesto.selectrow(indice,true)
			correcto = false
			messagebox("Atención","Para procesar la entrada debe asignar todas la ubicaciones.")
		end if	
		indice ++
	loop while indice <= total and correcto
end if

return correcto
end function

public function boolean f_procesar_salida_compuesto (string arg_almacen, integer arg_anyo, long arg_nummov);long    indice,total
boolean correcto = true
string  ubicacion

total  = dw_compuesto.rowcount()
indice = 1

if total > 0 then
	do			
		if dw_compuesto.object.cantidad_salida[indice] > 0 then
			if dw_compuesto.object.producto_terminado[indice] = "S" then
				if not(f_salida_producto_terminado(indice,arg_almacen,arg_anyo,arg_nummov)) then
					correcto = false
				end if			
			else
				if not(f_salida_materia_prima(indice,arg_almacen,arg_anyo,arg_nummov)) then
					correcto = false
				end if						
			end if
		end if
		indice ++
	loop while indice <= total and correcto
end if

return correcto
end function

public function boolean f_salida_materia_prima (long indice, string arg_almacen, integer arg_anyo, long arg_nummov);boolean   bien = true
datastore ubicaciones
string    sel
dec       cur_precio
str_comlinubicahis com_ubihis
str_comlinubica    com_ubi
str_commovhis      com_mov
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
com_ubihis.usuario       = nombre_usuario
com_ubihis.empresa       = codigo_empresa
com_ubihis.anyo          = year(date(String(em_fecha.text)))
com_ubihis.mp		       = dw_compuesto.object.producto[indice]
com_ubihis.calidad       = dw_compuesto.object.calidad[indice]
com_ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
com_ubihis.f_alta        = Datetime(today(),now())
com_ubihis.observaciones = sle_observaciones.text
com_ubihis.tipomov       = "6"
com_ubihis.ubicacion     = dw_compuesto.object.ubicacion[indice]
com_ubihis.almacen       = f_almacen_ubicacion(com_ubihis.ubicacion)
com_ubihis.zona          = f_zona_ubicacion(com_ubihis.ubicacion)
com_ubihis.fila          = f_fila_ubicacion(com_ubihis.ubicacion)
com_ubihis.altura        = f_altura_ubicacion(com_ubihis.ubicacion)
com_ubihis.cantidads     = dw_compuesto.object.cantidad_salida[indice]
com_ubihis.cantidade     = 0
com_ubihis.precio        = dw_compuesto.object.precio[indice]
//Cargamos los datos que relacionan 
//la salida de mp con la entrada que realizamos
com_ubihis.comp_almacen  = arg_almacen
com_ubihis.comp_anyo     = arg_anyo
com_ubihis.comp_nummov   = arg_nummov
com_mov.comp_almacen     = arg_almacen
com_mov.comp_anyo        = arg_anyo
com_mov.comp_nummov      = arg_nummov
//
SELECT  venmprima.familia,
		  venmprima.tipo_unidad,  
		  venmprima.envase
INTO    :com_ubihis.familia,
        :com_ubihis.tipo_unidad,
		  :com_ubihis.envase
FROM    venmprima  
WHERE   (venmprima.empresa = :com_ubihis.empresa ) AND  
        (venmprima.codigo  = :com_ubihis.mp ) ;

com_ubihis.cantidads = dec(string(com_ubihis.cantidads,f_mascara_unidad_compras(com_ubihis.tipo_unidad)))

IF SQLCA.SQLCode<>0 THEN 
	f_mensaje("selección de datos de la mp","Error: "+sqlca.sqlerrtext)
	bien = false
END IF

com_ubi.empresa     = com_ubihis.empresa
com_ubi.almacen     = com_ubihis.almacen
com_ubi.mp		     = com_ubihis.mp
com_ubi.familia     = com_ubihis.familia
com_ubi.calidad     = com_ubihis.calidad
com_ubi.envase      = com_ubihis.envase
com_ubi.tipo_unidad = com_ubihis.tipo_unidad
com_ubi.f_alta      = DateTime(today(),now())
com_ubi.zona        = com_ubihis.zona
com_ubi.fila        = com_ubihis.fila
com_ubi.altura      = com_ubihis.altura
com_ubi.existencias = com_ubihis.cantidads
com_ubi.ubicacion   = com_ubihis.ubicacion
com_mov.empresa     = com_ubihis.empresa
com_mov.almacen     = com_ubihis.almacen
com_mov.anyo        = com_ubihis.anyo
com_mov.origen      = "4" //***?????
com_mov.mp		    = com_ubihis.mp
com_mov.fechmov     = com_ubihis.fecha
com_mov.tipomov     = com_ubihis.tipomov
com_mov.cantidade   = com_ubihis.cantidade
com_mov.cantidads   = com_ubihis.cantidads
com_mov.codtercero  = ""
com_mov.numdoc      = numero_documento
com_mov.situacion   = "N"
com_mov.observaciones = com_ubihis.observaciones
com_mov.familia       = com_ubihis.familia
com_mov.calidad       = com_ubihis.calidad
com_mov.tipo_unidad   = com_ubihis.tipo_unidad
com_mov.f_alta        = DateTime(today(),now())
//-------------------------------------------------------------------
v_almacen         = com_ubihis.almacen
com_ubihis.orden      = f_comparam_numorden(codigo_empresa,Year(date(em_fecha.text)))
com_ubihis.nummov     = f_comparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
com_mov.nummov        = com_ubihis.nummov    
// Variables para cargar el cursor

dec cur_pedido,cur_linea,cur_anyo
String  cur_empresa,cur_almacen

decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada
string  cur_referencia,cur_ubicacion,cur_tipo_pallet,cur_caja

// Primero actualizo la salida global //
//-------------------------------------//
// En el historico de ubicaciones
IF NOT f_insert_comlinubicahis(com_ubihis) Then  
	bien = false
	f_mensaje("Insertar en comlinubicahis","Error: "+sqlca.sqlerrtext)
END IF
IF NOT f_actualiza_numorden_compras(codigo_empresa,Year(Date(em_fecha.text)),com_ubihis.orden) THEN
	bien = false
	f_mensaje("Función f_actualiza_numorden_compras","Error: "+sqlca.sqlerrtext)
END IF
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------

dec Registros,x1 = 0

sel = "select linea,existencias,precio "+&
		"from   comlinubica "+&
		"where  empresa   = '"+codigo_empresa+"' "+&
		"and    ubicacion = '"+com_ubi.ubicacion+"' "+&
		"and    mp        = '"+com_ubi.mp+"' "+&
		"and    calidad   = '"+com_ubi.calidad+"'"
		
cantidad_borrada = 0
ubicaciones = f_cargar_cursor(sel)
registros   = ubicaciones.rowcount()
If registros > 0 Then	
	For x1 = 1 To Registros
		cur_linea       = ubicaciones.GetItemNumber(x1,"linea")
		cur_existencias = ubicaciones.GetItemNumber(x1,"existencias")
		cur_precio      = ubicaciones.GetItemNumber(x1,"precio")
		
		if cur_precio = com_ubihis.precio then
			cantidad_pendiente = com_ubihis.cantidads - cantidad_borrada
			IF cantidad_pendiente = 0 THEN   EXIT
			IF cantidad_pendiente >= cur_existencias THEN 
				cantidad_borrada = cantidad_borrada + cur_existencias
				
				DELETE FROM comlinubica
				WHERE ( comlinubica.empresa   = :com_ubi.empresa ) AND  
						( comlinubica.ubicacion = :com_ubi.ubicacion ) AND  
						( comlinubica.linea     = :cur_linea );
						
				IF SQLCA.SQLCode<>0 THEN 
					bien = false
					f_mensaje("Borrando de comlinubica","Error: "+sqlca.sqlerrtext)
				END IF
			ELSE
				cur_existencias  = cur_existencias - cantidad_pendiente
				cantidad_borrada = cantidad_borrada + cantidad_pendiente
				
				UPDATE comlinubica  
				SET    existencias = :cur_existencias  
				WHERE  (comlinubica.empresa   = :com_ubi.empresa ) AND  
						 (comlinubica.ubicacion = :com_ubi.ubicacion ) AND  
						 (comlinubica.linea     = :cur_linea );
						 
				IF SQLCA.SQLCode<>0 THEN 
					bien = false
					f_mensaje("Actualizando comlinubica","Error: "+sqlca.sqlerrtext)
				END IF
			END IF		
		end if
	NEXT
END IF

IF cantidad_borrada <> com_ubihis.cantidads THEN  
	bien = false
	messagebox(" ERROR "," cantidad borrada <> cantidad salida ")
END IF

// Grabo el movimiento en el historico
IF NOT f_insert_commovhis(com_mov) Then 
	bien = false
	f_mensaje("Función f_insert_commovhis","Error: "+sqlca.sqlerrtext)
END IF
IF NOT f_actualiza_nummov_compras(com_mov.empresa,com_mov.anyo,com_mov.nummov) THEN  
	bien = false
	f_mensaje("Función f_actualiza_nummov_compras","Error: "+sqlca.sqlerrtext)
END IF

destroy ubicaciones
if not(bien) then
	MessageBox("Atención","Error en salida "+f_nombre_mprima(codigo_empresa,com_ubi.mp),Exclamation!, OK!,1)
end if
return bien
end function

public function boolean f_salida_producto_terminado (long indice, string arg_almacen, integer arg_anyo, integer arg_nummov);boolean   bien= true
datastore ubicaciones
string    sel,var_sector
dec       cur_linea
decimal   cur_existencias,cantidad_pendiente,cantidad_borrada
dec       Registros,x1 = 0

ubihis.usuario       = nombre_usuario
ubihis.empresa       = codigo_empresa
ubihis.anyo          = year(date(String(em_fecha.text)))	
ubihis.articulo      = dw_compuesto.object.producto[indice]
ubihis.calidad       = dw_compuesto.object.calidad[indice]
ubihis.tonochar      = dw_compuesto.object.tono[indice]
ubihis.calibre       = dw_compuesto.object.calibre[indice]
ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
ubihis.f_alta        = Datetime(today(),now())
ubihis.observaciones = sle_observaciones.text
ubihis.tipomov       = "218"
ubihis.tipo_pallet   = dw_compuesto.object.tipo_pallet[indice]
ubihis.caja          = dw_compuesto.object.caja[indice]	
ubihis.ubicacion     = dw_compuesto.object.ubicacion[indice]
ubihis.almacen       = f_almacen_ubicacion(ubihis.ubicacion)
ubihis.zona          = f_zona_ubicacion(ubihis.ubicacion)
ubihis.fila          = f_fila_ubicacion(ubihis.ubicacion)
ubihis.altura        = f_altura_ubicacion(ubihis.ubicacion)
ubihis.cantidads     = dw_compuesto.object.cantidad_salida[indice]
ubihis.cantidade     = 0		
//Cargamos los datos que relacionan 
//la salida de mp con la entrada que realizamos
ubihis.comp_almacen  = arg_almacen
ubihis.comp_anyo     = arg_anyo
ubihis.comp_nummov   = arg_nummov
mov.comp_almacen     = arg_almacen
mov.comp_anyo        = arg_anyo
mov.comp_nummov      = arg_nummov
//

SELECT  articulos.familia,   
		  articulos.formato,
		  articulos.modelo,
		  articulos.unidad  
INTO 	  :ubihis.familia,
		  :ubihis.formato,   
		  :ubihis.modelo,
		  :ubihis.tipo_unidad  
FROM    articulos  
WHERE   (articulos.empresa = :ubihis.empresa )
AND  	  (articulos.codigo  = :ubihis.articulo ) ;

var_sector    = f_sector_familia(codigo_empresa,ubihis.familia)
ubihis.sector = var_sector
mov.sector    = ""

IF SQLCA.SQLCode <> 0 THEN bien = false
ubihis.referencia   = f_componer_ref(ubihis.articulo,&
												 ubihis.calidad,&
												 ubihis.tonochar,&
												 ubihis.calibre)
ubi.empresa     = ubihis.empresa
ubi.almacen     = ubihis.almacen
ubi.articulo    = ubihis.articulo
ubi.familia     = ubihis.familia
ubi.formato     = ubihis.formato
ubi.modelo      = ubihis.modelo
ubi.calidad     = ubihis.calidad
ubi.tonochar    = ubihis.tonochar
ubi.calibre     = ubihis.calibre
ubi.tipo_pallet = ubihis.tipo_pallet
ubi.caja        = ubihis.caja
ubi.sector      = ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad = ubihis.tipo_unidad
ubi.referencia  = ubihis.referencia
ubi.f_alta      = DateTime(today(),now())
ubi.zona        = ubihis.zona
ubi.fila        = ubihis.fila
ubi.altura      = ubihis.altura
ubi.existencias = ubihis.cantidads
ubi.ubicacion   = ubihis.ubicacion

mov.empresa     = ubihis.empresa
mov.almacen     = ubihis.almacen
mov.anyo        = ubihis.anyo
mov.origen      = "4"
mov.articulo    = ubihis.articulo
mov.fechmov     = ubihis.fecha
mov.tipomov     = ubihis.tipomov
mov.cantidade   = ubihis.cantidade
mov.cantidads   = ubihis.cantidads
mov.codtercero  = ""
mov.numdoc      = numero_documento
mov.situacion   = "N"
mov.observaciones = ubihis.observaciones
SetNull(mov.punteado)
mov.antexist    = 0     
mov.familia     = ubihis.familia
mov.formato     = ubihis.formato
mov.modelo      = ubihis.modelo
mov.calidad     = ubihis.calidad
mov.tonochar    = ubihis.tonochar
mov.calibre     = ubihis.calibre
mov.tipo_unidad = ubihis.tipo_unidad
mov.tipo_pallet = ubihis.tipo_pallet
mov.caja        = ubihis.caja
mov.referencia  = ubihis.referencia
mov.f_alta      = DateTime(today(),now())	
v_almacen       = mov.almacen

ubihis.orden    = f_almparam_numorden(codigo_empresa,Year(date(em_fecha.text)))
ubihis.nummov   = f_almparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
mov.nummov      = ubihis.nummov    
IF NOT f_insert_almlinubicahis(ubihis) Then  bien = false
IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
	bien = false
END IF
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------
sel = "select linea,existencias "+&
		"from almlinubica "+&
		"where empresa     = '"+ubi.empresa+"' "+&
		"and   ubicacion   = '"+ubi.ubicacion+"' "+&
		"and   referencia  = '"+ubi.referencia+"' "+&
		"and   tipo_pallet = '"+ubi.tipo_pallet+"' "+&
		"and   caja        = '"+ubi.caja+"' "+&
		"and  (pedido      is  null or pedido = 0)"
		
//ubicaciones = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, ubicaciones)
registros   = ubicaciones.rowcount()
cantidad_borrada = 0
If registros > 0 Then
	For x1 = 1 To Registros
		cur_linea       =  ubicaciones.GetItemNumber(x1,"linea")
		cur_existencias =  ubicaciones.GetItemNumber(x1,"existencias")
		
		cantidad_pendiente = ubihis.cantidads - cantidad_borrada
		
		IF cantidad_pendiente = 0 THEN   EXIT
		
		IF cantidad_pendiente >= cur_existencias THEN 
			cantidad_borrada = cantidad_borrada + cur_existencias
			
			DELETE FROM almlinubica
			WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
					( almlinubica.ubicacion = :ubi.ubicacion ) AND  
					( almlinubica.linea     = :cur_linea ) USING SQLCA;
					
			IF SQLCA.SQLCode<>0 THEN bien = false
		ELSE
			cur_existencias  = cur_existencias - cantidad_pendiente
			cantidad_borrada = cantidad_borrada + cantidad_pendiente
			
			UPDATE almlinubica  
			SET    existencias = :cur_existencias  
			WHERE  (almlinubica.empresa   = :ubi.empresa ) AND  
					 (almlinubica.ubicacion = :ubi.ubicacion ) AND  
					 (almlinubica.linea     = :cur_linea )USING SQLCA;
					 
			IF SQLCA.SQLCode<>0 THEN bien = false
		END IF			
	NEXT
END IF

IF cantidad_borrada <> ubihis.cantidads THEN  bien = false
	
// Grabo el movimiento en el historico
IF NOT f_insert_almmovhis(mov) Then bien = false
IF NOT f_actualiza_nummov(mov.empresa,mov.anyo,mov.nummov) THEN  bien = false
if not(bien) then
	MessageBox("Atención","Error en salida "+f_nombre_articulo(codigo_empresa,ubi.articulo),Exclamation!, OK!,1)
end if

destroy ubicaciones

return bien
end function

public function boolean f_anular_salida_mp (string arg_almacen, integer arg_anyo, long arg_nummov);string    sel
long      indice,total,registros,x1,cur_linea,nueva_linea
dec       cur_existencias,cur_precio
boolean   bien,grabado
str_comlinubicahis comlinubicahis
str_commovhis      commovhis
str_comlinubica    comlinubica
datastore historico_ubi,ubicaciones

bien = true
//Deshacemos los movimientos del historico de ubicaciones si los hay
sel = "select * from comlinubicahis "+&
		"where  empresa      = '"+codigo_empresa+"' "+&
		"and    comp_almacen = '"+arg_almacen+"' "+&
		"and    comp_anyo    = "+string(arg_anyo)+" "+&
		"and    comp_nummov  = "+string(arg_nummov)
		
//historico_ubi = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, historico_ubi)
total         = historico_ubi.rowcount()

if total > 0  then
	for indice = 1 to total
		comlinubicahis.empresa     = codigo_empresa
		comlinubicahis.anyo        = year(today())
		comlinubicahis.almacen     = historico_ubi.object.almacen[indice]
		comlinubicahis.orden       = f_comparam_numorden(codigo_empresa,comlinubicahis.anyo)
		comlinubicahis.nummov      = f_comparam_nummov(codigo_empresa,comlinubicahis.anyo)
		comlinubicahis.zona        = historico_ubi.object.zona[indice]
		comlinubicahis.fila        = historico_ubi.object.fila[indice]
		comlinubicahis.altura      = historico_ubi.object.altura[indice]
		comlinubicahis.ubicacion   = historico_ubi.object.ubicacion[indice]
		comlinubicahis.cantidads   = historico_ubi.object.cantidade[indice]
		comlinubicahis.cantidade   = historico_ubi.object.cantidads[indice]
		comlinubicahis.mp          = historico_ubi.object.mp[indice]
		comlinubicahis.familia     = historico_ubi.object.familia[indice]
		comlinubicahis.calidad     = historico_ubi.object.calidad[indice]
		comlinubicahis.tipomov     = "7"
		comlinubicahis.tipo_unidad = historico_ubi.object.tipo_unidad[indice]
		comlinubicahis.f_alta      = datetime(today(),now())
		comlinubicahis.usuario     = nombre_usuario
		setnull(comlinubicahis.observaciones)
		setnull(comlinubicahis.externo)
		comlinubicahis.envase      = historico_ubi.object.envase[indice]
		comlinubicahis.situacion   = "N"
		comlinubicahis.fecha       = datetime(today())
		comlinubicahis.precio      = historico_ubi.object.precio[indice]
		setnull(comlinubicahis.comp_almacen)
		setnull(comlinubicahis.comp_anyo)
		setnull(comlinubicahis.comp_nummov)
		IF Not f_insert_comlinubicahis(comlinubicahis) Then 
			messagebox("Error en proceso","Grabando comlinubicahis",Exclamation!, OK!,1)
			bien = false
		else
			//Hacemos la entrada de la mp en su ubicacion			
			Sel = " SELECT   linea,existencias,precio " + &
					" FROM     comlinubica  " + &
					" WHERE    comlinubica.empresa   = '"+codigo_empresa+"'" +&
					" AND      comlinubica.ubicacion = '"+comlinubicahis.ubicacion+"'"+&
					" AND      comlinubica.mp        = '"+comlinubicahis.mp+"'" +&
					" AND      comlinubica.calidad   = '"+comlinubicahis.calidad+"'" 								
			
			//ubicaciones = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, ubicaciones)
			registros   = ubicaciones.RowCount()				
			grabado = false

			IF registros > 0 THEN
				FOR x1 = 1 To registros
					cur_existencias = ubicaciones.GetItemNumber(x1,"existencias")					
					cur_linea       = ubicaciones.GetItemNumber(x1,"linea")
					cur_precio      = ubicaciones.GetItemNumber(x1,"precio")
					
					if cur_precio = comlinubicahis.precio then					
						cur_existencias = cur_existencias + comlinubicahis.cantidade
					
						UPDATE comlinubica  
						SET    existencias = :cur_existencias,
								 f_alta      = :comlinubicahis.f_alta
						WHERE  comlinubica.empresa   = :comlinubicahis.empresa 
						AND    comlinubica.ubicacion = :comlinubicahis.ubicacion 
						AND    comlinubica.linea     = :cur_linea;
						IF SQLCA.SQLCode <> 0 THEN bien = false
						grabado = true
						EXIT						
					end if
				NEXT
			END IF
			IF not(grabado) THEN

				comlinubica.empresa     = comlinubicahis.empresa
				comlinubica.almacen     = comlinubicahis.almacen
				comlinubica.zona        = comlinubicahis.zona				
				comlinubica.fila        = comlinubicahis.fila				
				comlinubica.altura      = comlinubicahis.altura
				comlinubica.ubicacion   = comlinubicahis.ubicacion
				
				SELECT  max(comlinubica.linea)
				INTO    :nueva_linea 
				FROM    comlinubica  
				WHERE   comlinubica.empresa   = :comlinubica.empresa 
				AND     comlinubica.ubicacion = :comlinubica.ubicacion;
				IF IsNull(nueva_linea) THEN
					nueva_linea = 0 
				END IF
				nueva_linea ++
								
				comlinubica.linea       = nueva_linea
				comlinubica.mp          = comlinubicahis.mp
				comlinubica.familia     = comlinubicahis.familia
				comlinubica.calidad     = comlinubicahis.calidad
				comlinubica.existencias = comlinubicahis.cantidade				
				comlinubica.tipo_unidad = comlinubicahis.tipo_unidad
				comlinubica.f_alta      = datetime(today())
				setnull(comlinubica.observaciones)
				setnull(comlinubica.externo)
				comlinubica.envase      = comlinubicahis.envase
				comlinubica.precio      = comlinubicahis.precio
				IF NOT f_insert_comlinubica(comlinubica) Then bien = false
			END IF			
			ubicaciones.reset()			
			//Final de Hacemos la entrada de la mp en su ubicacion	
			
			//Grabamos el movimiento en el historico de movimientos
			commovhis.empresa       = comlinubicahis.empresa
			commovhis.almacen       = comlinubicahis.almacen
			commovhis.anyo          = comlinubicahis.anyo
			commovhis.nummov        = comlinubicahis.nummov
			setnull(commovhis.origen)
			commovhis.mp            = comlinubicahis.mp
			commovhis.fechmov       = comlinubicahis.fecha
			commovhis.tipomov       = comlinubicahis.tipomov
			commovhis.cantidade     = comlinubicahis.cantidade
			commovhis.cantidads     = comlinubicahis.cantidads
			commovhis.precio        = comlinubicahis.precio
			setnull(commovhis.codtercero)
			setnull(commovhis.numdoc)
			commovhis.situacion     = comlinubicahis.situacion
			commovhis.observaciones = comlinubicahis.observaciones
			commovhis.familia       = comlinubicahis.familia
			commovhis.calidad       = comlinubicahis.calidad
			commovhis.tipo_unidad   = comlinubicahis.tipo_unidad
			commovhis.f_alta        = comlinubicahis.f_alta
			commovhis.usuario       = comlinubicahis.usuario
			commovhis.externo       = comlinubicahis.externo
			commovhis.envase        = comlinubicahis.envase
			commovhis.comp_almacen  = comlinubicahis.comp_almacen
			commovhis.comp_anyo     = comlinubicahis.comp_anyo
			commovhis.comp_nummov   = comlinubicahis.comp_nummov
			IF NOT f_insert_commovhis(commovhis) Then
				MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
				bien = false
			END IF			
			//Fin de Grabamos el movimiento en el historico de movimientos
			IF NOT f_actualiza_nummov_compras(codigo_empresa,comlinubicahis.anyo,comlinubicahis.nummov) THEN
				bien = false
			END IF

			IF NOT f_actualiza_numorden_compras(codigo_empresa,comlinubicahis.anyo,comlinubicahis.orden) THEN
				bien = false
			END IF						
		end if		
	next
end if

destroy historico_ubi
destroy ubicaciones

return bien
end function

public function boolean f_anular_salida_producto_terminado (string arg_almacen, integer arg_anyo, long arg_nummov);string    sel
long      indice,total,registros,x1,cur_linea,nueva_linea
dec       cur_existencias
boolean   bien,grabado
str_almlinubicahis almlinubicahis
str_almmovhis      almmovhis
str_almlinubica    almlinubica
datastore historico_ubi,ubicaciones

bien = true
//Deshacemos los movimientos del historico de ubicaciones si los hay
sel = "select * from almlinubicahis "+&
		"where  empresa      = '"+codigo_empresa+"' "+&
		"and    comp_almacen = '"+arg_almacen+"' "+&
		"and    comp_anyo    = "+string(arg_anyo)+" "+&
		"and    comp_nummov  = "+string(arg_nummov)
		
//historico_ubi = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, historico_ubi)
total         = historico_ubi.rowcount()

if total > 0  then
	for indice = 1 to total

		almlinubicahis.empresa     = codigo_empresa
		almlinubicahis.anyo        = year(today())
		almlinubicahis.almacen     = historico_ubi.object.almacen[indice]
		almlinubicahis.orden       = f_almparam_numorden(codigo_empresa,almlinubicahis.anyo)
		almlinubicahis.nummov      = f_almparam_nummov(codigo_empresa,almlinubicahis.anyo)
		almlinubicahis.zona        = historico_ubi.object.zona[indice]
		almlinubicahis.fila        = historico_ubi.object.fila[indice]
		almlinubicahis.altura      = historico_ubi.object.altura[indice]
		almlinubicahis.ubicacion   = historico_ubi.object.ubicacion[indice]
		almlinubicahis.cantidads   = historico_ubi.object.cantidade[indice]
		almlinubicahis.cantidade   = historico_ubi.object.cantidads[indice]
		almlinubicahis.articulo    = historico_ubi.object.articulo[indice]
		almlinubicahis.familia     = historico_ubi.object.familia[indice]
		almlinubicahis.formato     = historico_ubi.object.formato[indice]
		almlinubicahis.modelo      = historico_ubi.object.modelo[indice]
		almlinubicahis.calidad     = historico_ubi.object.calidad[indice]
		almlinubicahis.calibre     = historico_ubi.object.calibre[indice]
		almlinubicahis.fecha       = datetime(today())
		almlinubicahis.tipomov     = "219"
		almlinubicahis.tipo_unidad = historico_ubi.object.tipo_unidad[indice]
		almlinubicahis.referencia  = historico_ubi.object.referencia[indice]
		almlinubicahis.f_alta      = datetime(today(),now())
		almlinubicahis.usuario     = nombre_usuario
		setnull(almlinubicahis.observaciones)
		almlinubicahis.tipo_pallet = historico_ubi.object.tipo_pallet[indice]
		almlinubicahis.sector      = historico_ubi.object.sector[indice]
		almlinubicahis.externo     = historico_ubi.object.externo[indice]
		almlinubicahis.situacion   = "N"
		almlinubicahis.caja        = historico_ubi.object.caja[indice]
		almlinubicahis.tonochar    = historico_ubi.object.tonochar[indice]
		setnull(almlinubicahis.comp_almacen)
		setnull(almlinubicahis.comp_anyo)
		setnull(almlinubicahis.comp_nummov)
		IF Not f_insert_almlinubicahis(almlinubicahis) Then 
			messagebox("Error en proceso","Grabando comlinubicahis",Exclamation!, OK!,1)
			bien = false
		else
			//Hacemos la entrada del producto terminado en su ubicacion			
			Sel = " SELECT   linea,existencias " + &
					" FROM     almlinubica  " + &
					" WHERE    almlinubica.empresa    = '"+codigo_empresa+"'" +&
					" AND      almlinubica.ubicacion  = '"+almlinubicahis.ubicacion+"'" +&
					" AND      almlinubica.articulo   = '"+almlinubicahis.articulo+"'" +&
					" AND      almlinubica.calidad    = '"+almlinubicahis.calidad+"'" +& 								
					" AND      almlinubica.tonochar   = '"+almlinubicahis.tonochar+"'" +&								
					" AND      almlinubica.calibre    =  "+string(almlinubicahis.calibre)+"" +&								
					" AND      almlinubica.tipo_pallet = '"+almlinubicahis.tipo_pallet+"'" +&								
					" AND      almlinubica.caja       = '"+almlinubicahis.caja+"'"
			//ubicaciones = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, ubicaciones)
			registros   = ubicaciones.RowCount()				
			grabado     = false

			IF registros > 0 THEN
				FOR x1 = 1 To registros
					cur_existencias = ubicaciones.GetItemNumber(x1,"existencias")					
					cur_linea       = ubicaciones.GetItemNumber(x1,"linea")					
					cur_existencias = cur_existencias + almlinubicahis.cantidade
				
					UPDATE almlinubica
					SET    existencias = :cur_existencias,
							 f_alta      = :almlinubicahis.f_alta
					WHERE  almlinubica.empresa   = :almlinubicahis.empresa 
					AND    almlinubica.ubicacion = :almlinubicahis.ubicacion 
					AND    almlinubica.linea     = :cur_linea;
					IF SQLCA.SQLCode <> 0 THEN bien = false
					grabado = true
					EXIT						
				NEXT
			END IF
			IF not(grabado) THEN
				
				almlinubica.empresa     = almlinubicahis.empresa
				almlinubica.almacen     = almlinubicahis.almacen
				almlinubica.zona        = almlinubicahis.zona
				almlinubica.fila        = almlinubicahis.fila
				almlinubica.altura      = almlinubicahis.altura
				almlinubica.ubicacion   = almlinubicahis.ubicacion
				
				SELECT  max(almlinubica.linea)
				INTO    :nueva_linea 
				FROM    almlinubica
				WHERE   almlinubica.empresa   = :almlinubica.empresa 
				AND     almlinubica.ubicacion = :almlinubica.ubicacion;
				IF IsNull(nueva_linea) THEN
					nueva_linea = 0 
				END IF
				nueva_linea ++
								
				almlinubica.linea       = nueva_linea
				almlinubica.articulo    = almlinubicahis.articulo
				almlinubica.familia     = almlinubicahis.familia
				almlinubica.formato     = almlinubicahis.formato
				almlinubica.modelo      = almlinubicahis.modelo
				almlinubica.calidad     = almlinubicahis.calidad
				almlinubica.calibre     = almlinubicahis.calibre
				almlinubica.existencias = almlinubicahis.cantidade
				almlinubica.anyo        = almlinubicahis.anyo
				setnull(almlinubica.pedido)
				setnull(almlinubica.linped)
				setnull(almlinubica.cliente)
				almlinubica.tipo_unidad = almlinubicahis.tipo_unidad
				almlinubica.referencia  = almlinubicahis.referencia
				almlinubica.f_alta      = almlinubicahis.f_alta
				setnull(almlinubica.observaciones)
				almlinubica.tipo_pallet = almlinubicahis.tipo_pallet
				almlinubica.sector      = almlinubicahis.sector
				almlinubica.externo     = almlinubicahis.externo
				almlinubica.caja        = almlinubicahis.caja
				almlinubica.tonochar    = almlinubicahis.tonochar
				
				IF NOT f_insert_almlinubica(almlinubica) Then bien = false
			END IF			
			ubicaciones.reset()			
			//Final de Hacemos la entrada del producto terminado en su ubicacion	
			
			//Grabamos el movimiento en el historico de movimientos
			almmovhis.empresa     = almlinubicahis.empresa
			almmovhis.almacen     = almlinubicahis.almacen
			almmovhis.anyo        = almlinubicahis.anyo
			almmovhis.nummov      = almlinubicahis.nummov
			setnull(almmovhis.origen)
			almmovhis.articulo    = almlinubicahis.articulo
			almmovhis.fechmov     = almlinubicahis.fecha
			almmovhis.tipomov     = almlinubicahis.tipomov
			almmovhis.cantidade   = almlinubicahis.cantidade
			almmovhis.cantidads   = almlinubicahis.cantidads
			setnull(almmovhis.precio)
			setnull(almmovhis.codtercero)
			setnull(almmovhis.numdoc)
			almmovhis.situacion   = "N"
			setnull(almmovhis.observaciones)
			setnull(almmovhis.punteado)
			almmovhis.antexist    = 0
			almmovhis.familia     = almlinubicahis.familia
			almmovhis.formato     = almlinubicahis.formato
			almmovhis.modelo      = almlinubicahis.modelo
			almmovhis.calidad     = almlinubicahis.calidad
			almmovhis.calibre     = almlinubicahis.calibre
			almmovhis.tipo_unidad = almlinubicahis.tipo_unidad
			almmovhis.referencia  = almlinubicahis.referencia
			almmovhis.f_alta      = almlinubicahis.f_alta
			almmovhis.usuario     = almlinubicahis.usuario
			almmovhis.tipo_pallet = almlinubicahis.tipo_pallet
			almmovhis.sector      = almlinubicahis.sector
			almmovhis.externo     = almlinubicahis.externo
			setnull(almmovhis.tipo)
			almmovhis.caja        = almlinubicahis.caja
			almmovhis.tonochar    = almlinubicahis.tonochar
			setnull(almmovhis.comp_almacen)
			setnull(almmovhis.comp_anyo)
			setnull(almmovhis.comp_nummov)
			IF NOT f_insert_almmovhis(almmovhis) Then
				MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
				bien = false
			END IF			
			//Fin de Grabamos el movimiento en el historico de movimientos
			IF NOT f_actualiza_nummov(codigo_empresa,almlinubicahis.anyo,almlinubicahis.nummov) THEN
				bien = false
			END IF
			IF NOT f_actualiza_numorden(codigo_empresa,almlinubicahis.anyo,almlinubicahis.orden) THEN
				bien = false
			END IF						
		end if		
	next
end if

destroy historico_ubi
destroy ubicaciones

return bien
end function

public subroutine f_consulta ();string operario,turno,tipoparte
datetime fecha

fecha=datetime(date(em_fecha.text))

if isnull(fecha) or year(date(fecha))=1900 then
	return
end if

operario=uo_operario.em_codigo.text
if operario='' then 
	return
end if

tipoparte=uo_tipoparte.em_codigo.text
if tipoparte='' then 
	return
end if

choose case ddlb_turnos.text
	case 'Mañana'
		turno='M'
	case 'Tarde'
		turno='T'
	case 'Noche'
		turno='N'
end choose

dw_3.retrieve(codigo_empresa,operario,tipoparte,fecha,turno)	
end subroutine

public function boolean f_grabar_parte_produccion (string arg_almacen, integer arg_anyo, decimal arg_nummov);string   operario,tipoparte,turno,articulo,comentarios,caja,tipo_pallet,tono
string   calidad,tarifa,var_cliente,moneda_tarifa
datetime fecha,var_fvto
long     contad,calibre
dec      buenas,malas,var_dto,precio_tarifa,tiempo,precio_unidad_articulo,precio_salida,precio_malas
dec      buenas_unidad_articulo,malas_unidad_articulo,cantidad_entrada_unidad_articulo,precio
dec      cantidad_entrada,cambio
long     horas,minutos

operario     = uo_operario.em_codigo.text
tipoparte    = uo_tipoparte.em_codigo.text
fecha        = datetime(date(em_fecha.text))
choose case ddlb_turnos.text
	case 'Mañana'
		turno='M'
	case 'Tarde'
		turno='T'
	case 'Noche'
		turno='N'
end choose
//Seleccionamos el maximo contador del parte
select max(contador)
into   :contad
from   prodpartes
where  empresa   = :codigo_empresa
and    operario  = :operario
and    tipoparte = :tipoparte
and    fecha     = :fecha
and    turno     = :turno;

if isnull(contad) then contad = 0
contad ++

articulo     = uo_articulo.em_codigo.text

buenas                 = dec(em_cantidad_salida.text)
buenas_unidad_articulo = cantidad_salida_unidad_articulo

//Si la cantidad de salida no la introducimos en la unidad del articulo
// hacemos la conversion.
if entrada_en_unidad_articulo = "S" then
	cantidad_entrada_unidad_articulo = dec(em_cantidad_entrada.text)
else
	cantidad_entrada_unidad_articulo = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
										uo_articulo.em_codigo.text,&
										unidad_entrada,&
										dec(em_cantidad_entrada.text))
end if

if pedir_cantidad_entrada then
	cantidad_entrada      = dec(em_cantidad_entrada.text)
	malas                 = 0
	malas_unidad_articulo = cantidad_entrada_unidad_articulo - cantidad_salida_unidad_articulo
else
	cantidad_entrada      = 0
	malas                 = dec(em_cantidad_entrada.text)
	malas_unidad_articulo = cantidad_entrada_unidad_articulo	
end if
comentarios  = sle_observaciones.text
caja         = uo_caja.em_codigo.text
tipo_pallet  = uo_tipo_pallet.em_codigo.text
tono         = em_tono.text
calibre      = dec(em_calibre.text)
calidad      = uo_calidad.em_codigo.text
horas        = dec(em_horas.text)
minutos      = dec(em_minutos.text)
tiempo		 = (horas * 60) + minutos

//Select dto,fvto,cliente
//Into   :var_dto,:var_fvto,:var_cliente
//from   articulos
//Where  empresa = :codigo_empresa
//And    codigo  = :articulo;
//
//if isnull(var_dto) then var_dto = 0
//IF var_fvto >= fecha Then
	var_dto = 0
//END IF
tarifa = f_tarifa_venclientes(codigo_empresa,var_cliente)
precio_tarifa = f_precio_articulo_venlintarifas_activa(codigo_empresa,tarifa,articulo,calidad)
moneda_tarifa = f_moneda_ventarifas(codigo_empresa,tarifa)
cambio 		  = f_cambio_moneda(moneda_tarifa)

precio        = precio_tarifa - ((precio_tarifa / 100) * var_dto)
precio_unidad_articulo = precio
if buenas <> 0 then
	precio_salida = precio * (buenas_unidad_articulo / buenas)
else
	precio_salida = precio
end if

if malas = 0 then
	precio_malas  = precio
else
	precio_malas  = precio * (malas_unidad_articulo / malas)
end if

insert into prodpartes
	(empresa,
	 operario,
	 tipoparte,
	 fecha,
	 turno,
	 contador,
	 articulo,
	 buenas,
	 malas,
	 cantidad_entrada,
	 buenas_unidad_articulo,
	 malas_unidad_articulo,
	 comentarios,
	 caja,
	 tipo_pallet,
	 tono,
	 calibre,
	 movimiento_almacen,
	 movimiento_anyo,
	 movimiento_nummov,
	 precio_unidad_articulo,
	 tiempo,
	 calidad,
	 precio_salida,
	 precio_malas,
	 moneda,
	 cambio)
values
	(:codigo_empresa,
	 :operario,
	 :tipoparte,
	 :fecha,
	 :turno,
	 :contad,
	 :articulo,
	 :buenas,
	 :malas,
	 :cantidad_entrada,
	 :buenas_unidad_articulo,
	 :malas_unidad_articulo,
	 :comentarios,
	 :caja,
	 :tipo_pallet,
	 :tono,
	 :calibre,
	 :arg_almacen,
	 :arg_anyo,
	 :arg_nummov,
	 :precio_unidad_articulo,
	 :tiempo,
	 :calidad,
	 :precio_salida,
	 :precio_malas,
	 :moneda_tarifa,
	 :cambio);
	 
if sqlca.sqlcode <> 0 then
	messagebox("Atención","Se ha producido el siguiente error al grabar el parte:~n"+sqlca.sqlerrtext)
	return false
else
	return true
end if
end function

public function boolean f_borrar_parte_produccion (long arg_linea);string   operario,tipoparte,turno
datetime fecha
long     contad

operario     = dw_3.object.operario[arg_linea]
tipoparte    = dw_3.object.tipoparte[arg_linea]
fecha        = dw_3.object.fecha[arg_linea]
turno        = dw_3.object.turno[arg_linea]
contad       = dw_3.object.contador[arg_linea]

delete 
from  prodpartesdefectos
where empresa   = :codigo_empresa 
and	operario  = :operario 
and	tipoparte = :tipoparte 
and	fecha     = :fecha 
and	turno     = :turno 
and	contador  = :contad;
		
if sqlca.sqlcode <> 0 then
	messagebox("Atención","Se ha producido el siguiente error al borrar el parte:~n"+sqlca.sqlerrtext)
	return false
else	
	delete prodpartes
	where  empresa   = :codigo_empresa 
	and	 operario  = :operario 
	and	 tipoparte = :tipoparte 
	and	 fecha     = :fecha 
	and	 turno     = :turno 
	and	 contador  = :contad;
		 
	if sqlca.sqlcode <> 0 then
		messagebox("Atención","Se ha producido el siguiente error al borrar el parte:~n"+sqlca.sqlerrtext)
		return false
	else
		return true
	end if
end if




end function

public subroutine f_campos_segun_tipoparte ();string tipoparte

tipoparte = uo_tipoparte.em_codigo.text

if f_genera_entrada_almacen_tipoparte(codigo_empresa,tipoparte) = "S" then
	genera_entrada_almacen = true
	pb_calculadora.visible = true	
	sle_numdoc.visible     = true
	em_cajas.enabled       = true
	em_t_cajas.enabled     = true
	em_t_pallets.enabled   = true
else
	genera_entrada_almacen = false
	pb_calculadora.visible = false	
	sle_numdoc.visible     = false	
	em_cajas.enabled       = false
	em_t_cajas.enabled     = false
	em_t_pallets.enabled   = false
end if

if f_pedir_caja_tipoparte(codigo_empresa,tipoparte) = "S" then
	uo_caja.enabled = true
	pedir_caja      = true
else
	uo_caja.enabled = false
	pedir_caja      = false
end if

if f_pedir_calibre_tipoparte(codigo_empresa,tipoparte) = "S" then
	em_calibre.enabled = true
	pedir_calibre      = true
else
	em_calibre.enabled = false
	pedir_calibre      = false
end if

if f_pedir_calidad_tipoparte(codigo_empresa,tipoparte) = "S" then
	uo_calidad.enabled = true
	pedir_calidad      = true
else
	uo_calidad.enabled = false
	pedir_calidad      = false
end if

if f_pedir_cantidad_entrada_tipoparte(codigo_empresa,tipoparte) = "S" then
	st_entrada.text        = "Entrada"
	pedir_cantidad_entrada = true
else
	st_entrada.text        = "Malas"
	pedir_cantidad_entrada = false
end if

if f_pedir_tiempo_tipoparte(codigo_empresa,tipoparte) = "S" then
	em_horas.enabled   = true
	em_minutos.enabled = true
	pedir_tiempo       = true
else
	em_horas.enabled   = false
	em_minutos.enabled = false
	em_horas.text      = ""
	em_minutos.text    = ""
	pedir_tiempo       = false
end if

if f_pedir_tipo_pallet_tipoparte(codigo_empresa,tipoparte) = "S" then
	uo_tipo_pallet.enabled = true
	pedir_tipo_pallet      = true
else
	uo_tipo_pallet.enabled = false
	pedir_tipo_pallet      = false
end if

if f_pedir_tono_tipoparte(codigo_empresa,tipoparte) = "S" then
	em_tono.enabled = true
	pedir_tono      = true
else
	em_tono.enabled = false
	pedir_tono      = false
end if

select entrada_en_unidad_articulo,
		 salida_en_unidad_articulo,
		 unidad_entrada,
		 unidad_salida
into   :entrada_en_unidad_articulo,
		 :salida_en_unidad_articulo,
		 :unidad_entrada,
		 :unidad_salida
from   prodtipopartes
where  empresa = :codigo_empresa
and    codigo  = :tipoparte;

if salida_en_unidad_articulo = "N" then
	st_texto_cantidad.text  = f_nombre_unidad_parte_abr(codigo_empresa,unidad_salida)
	em_cantidad_salida.Setmask(DecimalMask!,"###,###,##0")
end if
if entrada_en_unidad_articulo = "N" then
	st_texto_cantidad2.text  = f_nombre_unidad_parte_abr(codigo_empresa,unidad_entrada)
	em_cantidad_entrada.Setmask(DecimalMask!,"###,###,##0")
end if


end subroutine

public subroutine f_vacia_campos ();uo_operario.em_campo.enabled    = TRUE
uo_tipoparte.em_campo.enabled   = TRUE
ddlb_turnos.enabled             = TRUE
em_cantidad_entrada.enabled     = TRUE
em_cajas.enabled                = TRUE
em_calibre.enabled              = TRUE
em_fecha.enabled                = TRUE
em_cantidad_salida.enabled      = TRUE
em_cantidad_entrada.enabled     = TRUE
em_t_cajas.enabled              = TRUE
em_horas.enabled					  = TRUE
em_minutos.enabled				  = TRUE
em_t_pallets.enabled            = TRUE
em_tono.enabled                 = TRUE
uo_articulo.em_campo.enabled    = TRUE
uo_calidad.em_campo.enabled     = TRUE
uo_tipo_pallet.em_campo.enabled = TRUE
uo_caja.em_campo.enabled        = TRUE
sle_observaciones.enabled       = TRUE
cb_1.enabled                    = TRUE
dw_4.visible                    = FALSE
dw_1.visible                    = FALSE
dw_3.visible                    = TRUE
cb_2.visible                    = FALSE
cb_3.visible                    = FALSE
cb_4.visible                    = FALSE
cb_borrar.visible               = FALSE
f_consulta()
em_cajas.text                   = ""
em_calibre.text                 = ""
em_cantidad_salida.text         = ""
em_cantidad_entrada.text        = ""
em_t_cajas.text                 = ""
em_t_pallets.text               = ""
em_tono.text                    = ""
uo_articulo.em_campo.text       = ""
uo_calidad.em_campo.text        = ""
uo_tipo_pallet.em_campo.text    = ""
uo_tipo_pallet.em_codigo.text   = ""
em_horas.text					  	  = ""
em_minutos.text					  = ""
uo_caja.em_campo.text           = ""
uo_caja.em_codigo.text          = ""
uo_calidad.em_codigo.text       = ""
uo_articulo.em_codigo.text      = ""
sle_observaciones.text          = ""
dw_compuesto.reset()
dw_compuesto.visible            = false
dw_stock_mat_prima.visible      = false
dw_stock_prod_terminado.visible = false
cb_2.enabled                    = true
cb_borrar.enabled               = true


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción de Partes con Entradas de almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
dw_incidencias.visible=false
em_fecha.text=string(today())
dw_2.Settransobject(SQLCA)
dw_3.Settransobject(SQLCA)
dw_4.Settransobject(SQLCA)
dw_ex.Settransobject(SQLCA)
dw_incidencias.Settransobject(SQLCA)
dw_almlinubicahis.Settransobject(SQLCA)
dw_compuesto.Settransobject(SQLCA)
dw_stock_mat_prima.Settransobject(SQLCA)
dw_stock_prod_terminado.Settransobject(SQLCA)
uo_tipoparte.em_campo.setfocus()

end event

on w_int_prodpartes_entradas_almacen.create
int iCurrent
call super::create
this.st_texto=create st_texto
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_9=create st_9
this.pb_1=create pb_1
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.sle_observaciones=create sle_observaciones
this.cb_1=create cb_1
this.cb_3=create cb_3
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.pb_borrar=create pb_borrar
this.uo_tipo_pallet=create uo_tipo_pallet
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_4=create dw_4
this.st_10=create st_10
this.uo_caja=create uo_caja
this.st_1=create st_1
this.pb_modificar=create pb_modificar
this.dw_stock_mat_prima=create dw_stock_mat_prima
this.dw_stock_prod_terminado=create dw_stock_prod_terminado
this.uo_operario=create uo_operario
this.st_operario=create st_operario
this.st_tipoparte=create st_tipoparte
this.ddlb_turnos=create ddlb_turnos
this.st_turno=create st_turno
this.em_fecha=create em_fecha
this.st_fecha=create st_fecha
this.st_texto_cantidad=create st_texto_cantidad
this.st_texto_cantidad2=create st_texto_cantidad2
this.st_entrada=create st_entrada
this.em_cantidad_entrada=create em_cantidad_entrada
this.st_texto_tiempo=create st_texto_tiempo
this.em_cantidad_salida=create em_cantidad_salida
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_borrar=create cb_borrar
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_compuesto=create dw_compuesto
this.dw_almlinubicahis=create dw_almlinubicahis
this.dw_3=create dw_3
this.em_t_pallets=create em_t_pallets
this.em_cajas=create em_cajas
this.em_t_cajas=create em_t_cajas
this.st_7=create st_7
this.st_6=create st_6
this.st_8=create st_8
this.dw_ex=create dw_ex
this.pb_calculadora=create pb_calculadora
this.sle_numdoc=create sle_numdoc
this.st_documento=create st_documento
this.uo_tipoparte=create uo_tipoparte
this.em_minutos=create em_minutos
this.em_horas=create em_horas
this.st_11=create st_11
this.st_12=create st_12
this.dw_incidencias=create dw_incidencias
this.st_13=create st_13
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_texto
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.em_tono
this.Control[iCurrent+9]=this.em_calibre
this.Control[iCurrent+10]=this.sle_observaciones
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.uo_calidad
this.Control[iCurrent+15]=this.pb_borrar
this.Control[iCurrent+16]=this.uo_tipo_pallet
this.Control[iCurrent+17]=this.pb_imprimir_preli
this.Control[iCurrent+18]=this.dw_listado
this.Control[iCurrent+19]=this.dw_4
this.Control[iCurrent+20]=this.st_10
this.Control[iCurrent+21]=this.uo_caja
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.pb_modificar
this.Control[iCurrent+24]=this.dw_stock_mat_prima
this.Control[iCurrent+25]=this.dw_stock_prod_terminado
this.Control[iCurrent+26]=this.uo_operario
this.Control[iCurrent+27]=this.st_operario
this.Control[iCurrent+28]=this.st_tipoparte
this.Control[iCurrent+29]=this.ddlb_turnos
this.Control[iCurrent+30]=this.st_turno
this.Control[iCurrent+31]=this.em_fecha
this.Control[iCurrent+32]=this.st_fecha
this.Control[iCurrent+33]=this.st_texto_cantidad
this.Control[iCurrent+34]=this.st_texto_cantidad2
this.Control[iCurrent+35]=this.st_entrada
this.Control[iCurrent+36]=this.em_cantidad_entrada
this.Control[iCurrent+37]=this.st_texto_tiempo
this.Control[iCurrent+38]=this.em_cantidad_salida
this.Control[iCurrent+39]=this.dw_2
this.Control[iCurrent+40]=this.cb_4
this.Control[iCurrent+41]=this.cb_borrar
this.Control[iCurrent+42]=this.cb_2
this.Control[iCurrent+43]=this.dw_1
this.Control[iCurrent+44]=this.dw_compuesto
this.Control[iCurrent+45]=this.dw_almlinubicahis
this.Control[iCurrent+46]=this.dw_3
this.Control[iCurrent+47]=this.em_t_pallets
this.Control[iCurrent+48]=this.em_cajas
this.Control[iCurrent+49]=this.em_t_cajas
this.Control[iCurrent+50]=this.st_7
this.Control[iCurrent+51]=this.st_6
this.Control[iCurrent+52]=this.st_8
this.Control[iCurrent+53]=this.dw_ex
this.Control[iCurrent+54]=this.pb_calculadora
this.Control[iCurrent+55]=this.sle_numdoc
this.Control[iCurrent+56]=this.st_documento
this.Control[iCurrent+57]=this.uo_tipoparte
this.Control[iCurrent+58]=this.em_minutos
this.Control[iCurrent+59]=this.em_horas
this.Control[iCurrent+60]=this.st_11
this.Control[iCurrent+61]=this.st_12
this.Control[iCurrent+62]=this.dw_incidencias
this.Control[iCurrent+63]=this.st_13
end on

on w_int_prodpartes_entradas_almacen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_texto)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.sle_observaciones)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.pb_borrar)
destroy(this.uo_tipo_pallet)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_4)
destroy(this.st_10)
destroy(this.uo_caja)
destroy(this.st_1)
destroy(this.pb_modificar)
destroy(this.dw_stock_mat_prima)
destroy(this.dw_stock_prod_terminado)
destroy(this.uo_operario)
destroy(this.st_operario)
destroy(this.st_tipoparte)
destroy(this.ddlb_turnos)
destroy(this.st_turno)
destroy(this.em_fecha)
destroy(this.st_fecha)
destroy(this.st_texto_cantidad)
destroy(this.st_texto_cantidad2)
destroy(this.st_entrada)
destroy(this.em_cantidad_entrada)
destroy(this.st_texto_tiempo)
destroy(this.em_cantidad_salida)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_borrar)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_compuesto)
destroy(this.dw_almlinubicahis)
destroy(this.dw_3)
destroy(this.em_t_pallets)
destroy(this.em_cajas)
destroy(this.em_t_cajas)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_8)
destroy(this.dw_ex)
destroy(this.pb_calculadora)
destroy(this.sle_numdoc)
destroy(this.st_documento)
destroy(this.uo_tipoparte)
destroy(this.em_minutos)
destroy(this.em_horas)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.dw_incidencias)
destroy(this.st_13)
end on

event ue_listar;//Integer opc
//tipo_array arg
//
//arg.valor[1] = "Unidad de las cantidades en el listado"
//arg.valor[11] = "Su unidad"
//arg.valor[12] = "Metros cuad."
//arg.valor[13] = "Cancelar"
//opc = f_opciones (arg)
//
//choose case opc 
//	case 1 
//		dw_listado.DataObject = "report_int_movalm"
//	case 2
//		dw_listado.DataObject = "report_int_movalm_m2"
//	case 3
//		return
//end choose
//dw_listado.SetTransObject(SQLCA)
//dw_listado.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
//dw_report = dw_listado
//CALL Super::ue_listar
end event

event ue_cursor_abajo;dw_3.ScrollToRow(dw_3.rowcount())
end event

event ue_cursor_arriba;dw_3.ScrollToRow(0)
end event

event ue_pagina_abajo;dw_3.ScrollNextPage()
end event

event ue_pagina_arriba;dw_3.ScrollPriorPage()
end event

event activate;call super::activate;w_int_prodpartes_entradas_almacen = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_prodpartes_entradas_almacen
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_prodpartes_entradas_almacen
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_prodpartes_entradas_almacen
integer x = 123
integer y = 24
integer width = 2656
integer height = 108
end type

type st_texto from statictext within w_int_prodpartes_entradas_almacen
integer x = 2473
integer y = 336
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Salida"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1650
integer y = 408
integer width = 105
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1381
integer y = 408
integer width = 96
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1239
integer y = 408
integer width = 142
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "To."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1129
integer y = 408
integer width = 110
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_prodpartes_entradas_almacen
integer x = 5
integer y = 576
integer width = 448
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Observaciones"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_prodpartes_entradas_almacen
integer x = 3451
integer y = 200
integer width = 110
integer height = 96
integer taborder = 0
alignment htextalign = right!
end type

type em_tono from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 1239
integer y = 484
integer width = 142
integer taborder = 90
string mask = "!!!!"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type em_calibre from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 1381
integer y = 484
integer width = 96
integer taborder = 100
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "0"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type sle_observaciones from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 457
integer y = 580
integer width = 2263
integer taborder = 200
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;situado= "OBSERVACIONES"
end event

type cb_1 from u_boton within w_int_prodpartes_entradas_almacen
integer x = 2843
integer y = 576
integer width = 370
integer height = 92
integer taborder = 210
string text = "&OK"
end type

event clicked;//CONTROLES DE VALORES
boolean correcto
string mensaje
// piezas por conjunto
Dec{2} var_conjunto
correcto = True

if trim(uo_operario.em_codigo.text) = '' then 
   mensaje="Introduzca el operario"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_operario.em_campo.SetFocus()
   RETURN
end if

if trim(uo_tipoparte.em_codigo.text) = '' then 
   mensaje="Introduzca el tipo de parte"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_tipoparte.em_campo.SetFocus()
   RETURN
end if

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

IF cod_sector = "S" THEN
	IF trim(uo_calidad.em_campo.text) = "" and pedir_calidad THEN
		mensaje="Introduzca la calidad"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_calidad.em_campo.Setfocus()
		RETURN
	END IF
 
	IF control_tono and pedir_tono Then
		IF trim(em_tono.text)="" THEN
			mensaje="Introduzca el tono"
			MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
			em_tono.SetFocus()
			RETURN
		END IF
	END IF

	IF control_calibre and pedir_calibre Then
		IF trim(em_calibre.text) = "" and pedir_calibre THEN
			mensaje="Introduzca el calibre"
			MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
			em_calibre.SetFocus()
			RETURN
		END IF
	END IF

	IF trim(uo_tipo_pallet.em_campo.text) = "" and pedir_tipo_pallet THEN
		mensaje="Introduzca el tipo de pallet"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_tipo_pallet.Setfocus()
		RETURN
	END IF

	string  codigo_articulo,codigo_pallet,codigo_formato,var_caja
	
	codigo_pallet   = uo_tipo_pallet.em_codigo.text
	codigo_articulo = uo_articulo.em_codigo.text
	var_caja        = uo_caja.em_codigo.text

	SELECT articulos.empresa,articulos.codigo,   
			 articulos.formato,conjunto  
	INTO   :codigo_empresa,:codigo_articulo,   
			 :codigo_formato,:var_conjunto  
	FROM   articulos  
	WHERE  (articulos.empresa = :codigo_empresa ) 
	AND    (articulos.codigo  = :codigo_articulo );
  

	SELECT palarticulo.codigo  
	INTO   :codigo_pallet  
	FROM   palarticulo  
	WHERE  (palarticulo.empresa = :codigo_empresa ) AND  
			 (palarticulo.articulo = :codigo_articulo ) AND  
			 (palarticulo.codigo  = :codigo_pallet ) AND
			 (palarticulo.caja  = :var_caja);

	IF SQLCA.SQLCode <> 0 and pedir_tipo_pallet THEN
		mensaje="No Existe el Pallet al formato"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_tipo_pallet.em_campo.SetFocus()
		Return
	END  IF
END IF // fin control pertenece al sector

//IF trim(em_cantidad_salida.text)="" THEN
//   mensaje="Introduzca nº total de cantidad"
//   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//   em_cantidad_salida.SetFocus()
//   RETURN
//END IF

string codigo_real
String codigo_tipomov
codigo_tipomov = "1"

IF cod_sector = "S" and pedir_calidad Then
	String codigo_calidad
	codigo_calidad= uo_calidad.em_codigo.text
	
	SELECT almartcal.calidad  
	INTO   :codigo_calidad  
	FROM   almartcal  
	WHERE ( almartcal.empresa   = :codigo_empresa ) AND  
			( almartcal.articulo  = :codigo_articulo ) AND  
			( almartcal.calidad  = :codigo_calidad ) USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox("Calidad no  valida","Esta calidad no esta definida para el articulo",Exclamation!, OK!,1)
		uo_calidad.em_campo.text        = ""
		uo_calidad.em_codigo.text = ""
		uo_calidad.em_campo.Setfocus()
		Return
	END IF
END IF

// Control piezas por conjunto
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
	IF (Dec(String(Dec(em_cantidad_salida.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad_salida.text) Then
		MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad ha de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
		f_activar_campo(em_cantidad_salida)
		return
	END IF
END IF

long horas,minutos

horas   = dec(em_horas.text)
minutos = dec(em_minutos.text)

if pedir_tiempo then
	if horas = 0 and minutos = 0 then
		MessageBox("Atención","Debe introducir el tiempo empleado en la producción",Exclamation!, OK!,1)
		f_activar_campo(em_horas)
		return		
	end if
end if

if pedir_cantidad_entrada then
	if dec(em_cantidad_entrada.text) < dec(em_cantidad_salida.text) then
		MessageBox("Atención","La cantidad de entrada debe ser mayo o igual que la salida.",Exclamation!, OK!,1)
		f_activar_campo(em_cantidad_entrada)
		return				
	end if
end if

string var_almacen
long   var_anyo,var_nummov
dec   cantidad_salida
cantidad_salida = dec(em_cantidad_salida.text)

if correcto then
	
	//Si la cantidad de salida no la introducimos en la unidad del articulo
	// hacemos la conversion.
	if salida_en_unidad_articulo = "S" then
		cantidad_salida_unidad_articulo = dec(em_cantidad_salida.text)
	else
		cantidad_salida_unidad_articulo = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
											uo_articulo.em_codigo.text,&
											unidad_salida,&
											dec(em_cantidad_salida.text))
	end if
		
	if not(genera_entrada_almacen) or cantidad_salida = 0 then
		setnull(var_almacen)
		setnull(var_anyo)
		setnull(var_nummov)
		if f_grabar_parte_produccion(var_almacen,var_anyo,var_nummov) then
			commit;
			f_vacia_campos()
		else
			rollback;
		end if
		f_consulta()
		uo_articulo.em_campo.SetFocus()
	else
		// desactivar claves
		uo_operario.em_campo.enabled    = FALSE	
		uo_tipoparte.em_campo.enabled   = FALSE	
		ddlb_turnos.enabled             = FALSE
		em_cantidad_entrada.enabled     = FALSE	
		em_cajas.enabled                = FALSE
		em_calibre.enabled              = FALSE
		em_fecha.enabled                = FALSE
		em_cantidad_salida.enabled      = FALSE
		em_horas.enabled					  = FALSE
		em_minutos.enabled				  = FALSE
		em_t_cajas.enabled              = FALSE
		em_t_pallets.enabled            = FALSE
		em_tono.enabled                 = FALSE
		uo_articulo.em_campo.enabled    = FALSE
		uo_calidad.em_campo.enabled     = FALSE
		uo_tipo_pallet.em_campo.enabled = FALSE
		uo_caja.em_campo.enabled        = FALSE
		sle_observaciones.enabled       = FALSE
		cb_1.enabled                    = FALSE	
		dw_2.visible                    = FALSE
		dw_1.visible                    = TRUE
		dw_3.visible                    = FALSE
		dw_ex.visible                   = FALSE
		dw_4.visible                    = TRUE
		cb_2.visible                    = TRUE
		cb_3.visible                    = TRUE
		cb_4.visible                    = TRUE
		cb_borrar.visible               = TRUE
		pb_borrar.visible               = FALSE
		pb_modificar.visible            = FALSE
		
		dw_1.retrieve()
		contador = dw_1.Rowcount()
		string v_referencia
		
		v_referencia = f_componer_ref(uo_articulo.em_codigo.text,&
											 uo_calidad.em_codigo.text,Trim(em_tono.text),Integer(em_calibre.text))
		dw_4.retrieve(codigo_empresa,v_referencia)
		
		contador = contador+1
		
		dw_1.insertRow(contador)

		dw_1.setitem(contador,"cantidad",cantidad_salida_unidad_articulo)
		dw_1.setitem(contador,"empresa",codigo_empresa)
		dw_1.setitem(contador,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
	
		dw_1.SetTabOrder("almacen",10)
		dw_1.SetTabOrder("zona",20)
		dw_1.SetTabOrder("fila",30)
		dw_1.SetTabOrder("altura",40)		
		dw_1.SetTabOrder("cantidad",50)			
		
		dw_1.SetFocus()
		//***
	end if
end if

end event

type cb_3 from u_boton within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 850
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;f_vacia_campos()
uo_articulo.em_campo.SetFocus()
end event

type uo_articulo from u_em_campo_2 within w_int_prodpartes_entradas_almacen
integer y = 484
integer width = 1129
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_cliente,caja_compras
long   lineas_compuesto

uo_articulo.em_campo.text=Trim(f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text) = "" THEN 
	IF Trim(uo_articulo.em_codigo.text) <> "" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
END IF

// Selecciono abreviado del la unidad del articulo
string  codigo_articulo,texto_unidad,cod_familia

codigo_articulo = uo_articulo.em_codigo.text
mov.articulo    = codigo_articulo
// Selecciono si la familia tiene tono y calibre
string cod_tono,cod_calibre

SELECT articulos.familia,
		 articulos.unidad,
		 articulos.tono,
		 articulos.calibre,
		 articulos.sector
INTO   :cod_familia,
		 :var_tipo_unidad,
		 :cod_tono,
		 :cod_calibre,
		 :cod_sector  
FROM   articulos  
WHERE  articulos.empresa = :codigo_empresa
AND    articulos.codigo  = :codigo_articulo;

SELECT familias.empresa,familias.codigo
INTO   :mov.empresa,:mov.familia
FROM   familias  
WHERE  familias.empresa = :codigo_empresa 
AND    familias.codigo  = :cod_familia ;

st_texto_cantidad.text  = f_nombre_unidad(var_tipo_unidad)
st_texto_cantidad2.text = f_nombre_unidad(var_tipo_unidad)
em_cantidad_salida.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))
em_cantidad_entrada.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))

IF cod_sector = "S" THEN
	em_cajas.enabled       = TRUE
	em_calibre.enabled     = TRUE
	em_t_cajas.enabled     = TRUE
	em_t_pallets.enabled   = TRUE
	em_tono.enabled        = TRUE
	uo_calidad.enabled     = TRUE
	uo_tipo_pallet.enabled = TRUE
	st_1.enabled           = TRUE
	st_2.enabled           = TRUE
	st_3.enabled           = TRUE
	st_4.enabled           = TRUE
	st_5.enabled           = TRUE
	// st_6.enabled           = TRUE
	// st_7.enabled           = TRUE
	// st_8.enabled           = TRUE
	uo_calidad.em_codigo.text     = ""
	uo_calidad.em_campo.text      = ""
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = "" 
	f_control_tono_calibre()
	// f_activar_campo(uo_calidad.em_campo)
ELSE
	// em_cajas.enabled       = FALSE
	em_calibre.enabled     = FALSE
	em_t_cajas.enabled     = FALSE
	// em_t_pallets.enabled   = FALSE
	em_tono.enabled        = FALSE
	uo_calidad.enabled     = FALSE
	uo_tipo_pallet.enabled = FALSE
	st_1.enabled           = FALSE
	st_2.enabled           = FALSE
	st_3.enabled           = FALSE
	st_4.enabled           = FALSE
	st_5.enabled           = FALSE
	// st_6.enabled           = FALSE
	// st_7.enabled           = FALSE
	// st_8.enabled           = FALSE
	// em_cajas.text          = ""
	em_calibre.text               = ""
	em_t_cajas.text               = "0"
	// em_t_pallets.text      = "0"
	em_tono.text                  = ""
	uo_calidad.em_codigo.text     = ""
	uo_calidad.em_campo.text      = ""
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = ""
END IF

f_campos_segun_tipoparte()
em_cantidad_salida.text  = ''
em_cantidad_entrada.text = ''

if len(Trim(uo_articulo.em_codigo.text))<> 0 Then
	if pedir_tipo_pallet then 
		uo_tipo_pallet.em_codigo.text = f_tipo_pallet_articulo(codigo_empresa,uo_articulo.em_codigo.text)
		uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)		
	end if
	if pedir_caja then
		uo_caja.em_codigo.text        = f_caja_articulo_pallet(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text)
		uo_caja.em_campo.text         = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)
	end if
end if

// Control articulos compuestos
if genera_entrada_almacen then
	select count(*)
	into   :lineas_compuesto
	from   almcompuestoart
	where  empresa  = :codigo_empresa
	and    articulo = :uo_articulo.em_codigo.text;
	
	if isnull(lineas_compuesto) then lineas_compuesto = 0
	
	if lineas_compuesto > 0 then
		articulo_compuesto = true
	else
		articulo_compuesto = false
		if uo_caja.em_codigo.text <> "" then
			select codigo_compras
			into   :caja_compras
			from   almcajas
			where  empresa = :codigo_empresa
			and    codigo  = :uo_caja.em_codigo.text;
			
			if isnull(caja_compras) then caja_compras = ""
			if trim(caja_compras) <> "" then
				articulo_compuesto = true
			end if
		end if
	end if
	
	// Fin control articulos compuestos
else
	articulo_compuesto = false
end if

dw_2.visible = True
dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_prodpartes_entradas_almacen
integer x = 1129
integer y = 484
integer width = 110
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then
	uo_calidad.em_campo.SetFocus()
END IF
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF
f_control_tono_calibre()
dw_ex.retrieve(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
if dw_ex.rowcount() > 0 then 
	dw_ex.visible = true
end if

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_borrar from upb_papelera within w_int_prodpartes_entradas_almacen
integer x = 2720
integer y = 572
integer width = 123
integer height = 96
integer taborder = 0
boolean originalsize = false
end type

event clicked;if dw_3.GetRow() = 0 Then Return

dec        registros,x2,bien
string     cod_ubicacion,referencia
decimal{2} total_cantidad,mod_cantidad
dec{0}     mov_nummov,mov_anyo,movimientos_compras
String     mov_situacion,mov_almacen,mov_empresa
boolean    continuar 
dec        opcion

opcion = MessageBox("Proceso de borrado de datos","¿Borrar el parte seleccionado?",question!, YesNo!,2)

IF opcion=2 THEN  Return

bien=0

registros = dw_almlinubicahis.RowCount()

IF registros  = 0 THEN  
	if not(f_borrar_parte_produccion(dw_3.GetRow())) then
		bien = 1
	end if
	CHOOSE CASE bien
		CASE 1
			ROLLBACK USING SQLCA;
			MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
		CASE 0
			COMMIT USING SQLCA;
		CASE ELSE
			ROLLBACK USING SQLCA;
			MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	END CHOOSE	
	f_consulta()
else
	v_almacen     =  dw_almlinubicahis.GetItemString(1,"almacen") 
	titulo        =  Parent.title
	longitud      =  len(trim(codigo_empresa))
	criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
	anyo          =  dw_almlinubicahis.GetItemNumber(1,"anyo") 
	longitud      =  len(trim(string(anyo)))
	criterio[2]   =  trim(string(anyo))+space(20-longitud)
	seleccion     =  criterio[1]+criterio[2]
	tabla         =  "almparam"
	
	IF NOT f_bloquear(tabla,seleccion,titulo) THEN
		COMMIT Using SQLCA; //Solucion nivel insolacion
		
		mov_nummov     = dw_almlinubicahis.GetItemNumber(1,"nummov") 
		mov_almacen    = dw_almlinubicahis.GetItemString(1,"almacen") 
		mov_empresa    = dw_almlinubicahis.GetItemString(1,"empresa")	
		mov_anyo       = dw_almlinubicahis.GetItemNumber(1,"anyo")	
		
		//Compruebo si debo bloquear compras	
		select count(*) 
		into   :movimientos_compras
		from   commovhis
		where  empresa      = :codigo_empresa
		and    comp_almacen = :mov_almacen
		and    comp_anyo    = :mov_anyo
		and    comp_nummov  = :mov_nummov;
		
		if isnull(movimientos_compras) then movimientos_compras = 0
		if movimientos_compras > 0 then
			IF Not f_bloquear_almacen_compras(titulo) Then
				continuar = true	
			else
				continuar = false
			end if
		else
			continuar = true
		end if
		//Fin comprobacion bloqueo compras
		if continuar then
			ubi.f_alta = DateTime(Today(),now())
				
			ubihis.orden = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
		
			FOR x2=1 TO registros
				referencia      	 = dw_almlinubicahis.GetItemString(x2,"referencia") 
				cod_ubicacion 		 = dw_almlinubicahis.GetItemString(x2,"ubicacion") 
				ubihis.tipo_pallet = dw_almlinubicahis.GetItemString(x2,"tipo_pallet") 
				ubihis.caja        = dw_almlinubicahis.GetItemString(x2,"caja") 
				total_cantidad   	 = dw_almlinubicahis.GetItemDecimal(x2,"cantidade")	
				
				//-------------------------------------------------------------
				// Busco si hay lineas este articulo sin reservar
				//-------------------------------------------------------------
				
				dec elementos 
				dec grabado,y2
				grabado=0
				String sel
				DataStore dw_proceso 
				Sel = " SELECT   linea,existencias  " + &
						" FROM     almlinubica  " + &
						" WHERE    almlinubica.empresa     = '"+ codigo_empresa  + "'" +&
						" AND      almlinubica.ubicacion   = '"+ cod_ubicacion + "'" +&
						" AND      almlinubica.referencia  = '"+ referencia + "'" + &
						" AND      almlinubica.tipo_pallet = '"+ ubihis.tipo_pallet + "'" + &
						" AND      almlinubica.caja        = '"+ ubihis.caja + "'" + &
						" AND      almlinubica.pedido is null "
				
				//dw_proceso = f_cargar_cursor2(sel)
				f_cargar_cursor_nuevo(sel, dw_proceso)
				
				elementos  = dw_proceso.RowCOunt()
				IF elementos = 0 Then
					bien = 1
					f_mensaje("Error","No Stock para anularmovimiento")
				ELSE
					FOR y2= 1 to elementos		
						ubi.empresa     =  codigo_empresa
						ubi.almacen     =  f_almacen_ubicacion(cod_ubicacion)
						ubi.ubicacion   =  cod_ubicacion
						ubi.referencia  =  referencia
						ubi.linea       =  dw_proceso.GetItemNumber(y2,"linea")
						ubi.existencias =  dw_proceso.GetItemNumber(y2,"existencias")
						
						IF IsNull(ubi.existencias) THEN ubi.existencias = 0
						IF ubi.existencias <= total_cantidad THEN				
							DELETE FROM almlinubica  
							WHERE almlinubica.empresa   = :ubi.empresa
							AND   almlinubica.ubicacion = :ubi.ubicacion
							AND   almlinubica.linea     = :ubi.linea ;
							
							IF SQLCA.SQLCode<>0 THEN  
								bien=1
								f_mensaje("Error","Al borrar ubicaciones")
							END IF
							total_cantidad = total_cantidad - ubi.existencias
						ELSE
							UPDATE almlinubica
							SET    existencias = existencias - :total_cantidad,   
									 f_alta      = :ubi.f_alta  
							WHERE almlinubica.empresa   = :ubi.empresa 
							AND   almlinubica.ubicacion = :ubi.ubicacion 
							AND   almlinubica.linea     = :ubi.linea USING SQLCA;
							IF SQLCA.SQLCode<>0 THEN    
								bien=1
								f_mensaje("Error","Al modificar ubicaciones")
							END IF
							total_cantidad = 0
						END IF
						IF total_cantidad = 0 THEN Exit
					NEXT
				END IF
				IF total_cantidad <> 0 THEN   
					bien=1
					f_mensaje("Error", "Falta cantidad para anular")
				END IF
				ubihis.orden = ubihis.orden +1 
			NEXT
			
			//-------------------------------------------------------
			// Borro el movimiento del historico
			//-------------------------------------------------------
			
			IF NOT f_anular_nummov(mov_empresa,mov_almacen,mov_anyo,mov_nummov) THEN
				f_mensaje("Error","Al anular el movimiento")
				bien=1
			END IF
			IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
				bien=1
				f_mensaje("Error","Al actualizar el movimiento")
			END IF
			//Borramos el parte de producción
			if not(f_borrar_parte_produccion(dw_3.GetRow())) then
				bien = 1
			end if
			//Deshacemos los movimientos de articulo compuesto si los hay
			if movimientos_compras > 0 then
				if not(f_anular_salida_mp(mov_almacen,mov_anyo,mov_nummov)) then bien = 1
			end if		
			if not(f_anular_salida_producto_terminado(mov_almacen,mov_anyo,mov_nummov)) then bien = 1		
			//Fin de deshacemos los movimientos de articulo compuesto si los hay
			CHOOSE CASE bien
				CASE 1
					ROLLBACK USING SQLCA;
					MessageBox("Fin de proceso","No Puedo borrar el movimiento, el material ha sido reubicado",Exclamation!, OK!,1)
				CASE 0
					COMMIT USING SQLCA;
				CASE ELSE
					ROLLBACK USING SQLCA;
					MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
			END CHOOSE
			if movimientos_compras > 0 then
				f_desbloquear_almacen_compras(titulo)
			end if
		end if			
		f_desbloquear(tabla,seleccion,titulo)
		COMMIT;
		f_consulta()
	END IF
end if
uo_articulo.em_campo.SetFocus()
destroy dw_proceso
end event

type uo_tipo_pallet from u_em_campo_2 within w_int_prodpartes_entradas_almacen
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1650
integer y = 484
integer width = 105
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tipo_pallet.em_campo.text=f_nombre_palarticulocaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
   uo_tipo_pallet.em_campo.SetFocus()
 END IF
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 

end event

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

type pb_imprimir_preli from picturebutton within w_int_prodpartes_entradas_almacen
event clicked pbm_bnclicked
boolean visible = false
integer x = 3072
integer y = 200
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;Parent.TriggerEvent("ue_listar")
f_activar_campo(em_fecha)
end event

type dw_listado from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 672
integer width = 293
integer height = 72
boolean bringtotop = true
string dataobject = "report_int_movalm_m2"
boolean border = false
boolean livescroll = true
end type

type dw_4 from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 1714
integer y = 716
integer width = 1125
integer height = 568
boolean bringtotop = true
string dataobject = "dw_int_almlinubi3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF dw_1.GetRow() <> 0 and This.GetRow()<> 0  Then
	dw_1.SetItem(dw_1.GetRow(),"almacen",This.GetItemSTring(This.getRow(),"almacen"))
	dw_1.SetItem(dw_1.GetRow(),"zona",This.GetItemSTring(This.getRow(),"zona"))
	dw_1.SetItem(dw_1.GetRow(),"fila",This.GetItemNumber(This.getRow(),"fila"))
	dw_1.SetItem(dw_1.GetRow(),"altura",This.GetItemNumber(This.getRow(),"altura"))
END IF
end event

type st_10 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1477
integer y = 408
integer width = 174
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_prodpartes_entradas_almacen
event destroy ( )
integer x = 1477
integer y = 484
integer width = 174
integer taborder = 110
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)=""  or IsNull(uo_caja.em_campo.text)THEN 
	IF Trim(uo_caja.em_codigo.text)<>"" Then 
		uo_caja.em_campo.SetFocus()
	END IF
	uo_caja.em_campo.text=""
	uo_caja.em_codigo.text=""
END IF
string caja_compras
if not(articulo_compuesto) then
	if uo_caja.em_codigo.text <> "" then
		select codigo_compras
		into   :caja_compras
		from   almcajas
		where  empresa = :codigo_empresa
		and    codigo  = :uo_caja.em_codigo.text;
		
		if isnull(caja_compras) then caja_compras = ""
		if trim(caja_compras) <> "" then
			articulo_compuesto = true
		end if
	end if
end if
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '"+uo_articulo.em_codigo.text+"'"

end event

type st_1 from statictext within w_int_prodpartes_entradas_almacen
integer x = 5
integer y = 408
integer width = 1125
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type pb_modificar from upb_papelera within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 2606
integer y = 556
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = false
string picturename = "\bmp\minus.bmp"
end type

event clicked;Boolean habilita 
if especial then
	especial = false
	habilita =true
	cb_3.TriggerEvent("clicked")
else
	if not (f_pedir_clave("2")) then return

	especial = true
	habilita = false
end if

uo_articulo.enabled    = habilita
uo_calidad.enabled     = habilita
em_tono.enabled        = habilita
em_calibre.enabled     = habilita
uo_caja.enabled        = habilita
uo_tipo_pallet.enabled = habilita

end event

type dw_stock_mat_prima from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 343
integer y = 288
integer width = 1353
integer height = 416
boolean bringtotop = true
boolean titlebar = true
string title = "Ubicaciones Materias Primas"
string dataobject = "dw_con_stock_mat_prima"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

event doubleclicked;string producto,tonochar,calidad,tipo_pallet,caja,ubicacion
long   lineas,calibre
dec    cantidad_salida,precio

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	cantidad_salida = dw_compuesto.object.cantidad_salida[dw_compuesto.getrow()]
	if this.object.existencias[row] >= cantidad_salida then
		precio    = this.object.precio[row]
		ubicacion = this.object.ubicacion[row]
		calidad   = this.object.calidad[row]
		
		dw_compuesto.object.precio[dw_compuesto.getrow()]    = precio
		dw_compuesto.object.calidad[dw_compuesto.getrow()]   = calidad
		dw_compuesto.object.ubicacion[dw_compuesto.getrow()] = ubicacion
	end if
end if
end event

type dw_stock_prod_terminado from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 361
integer y = 288
integer width = 1353
integer height = 416
integer taborder = 220
boolean titlebar = true
string title = "Ubicaciones Productos Terminados"
string dataobject = "dw_con_stock_prod_terminado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

event doubleclicked;string producto,tonochar,calidad,tipo_pallet,caja,ubicacion,cadena
long   lineas,calibre
dec    cantidad_salida,precio

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	cantidad_salida = dw_compuesto.object.cantidad_salida[dw_compuesto.getrow()]
	tipo_pallet     = this.object.tipo_pallet[row]
	caja            = this.object.caja[row]
	producto        = dw_compuesto.object.producto[dw_compuesto.getrow()]
	
	cadena   = f_calculo_unidades(codigo_empresa,producto,tipo_pallet,caja,0,0,cantidad_salida)
					  
	cantidad_salida = dec(Mid(cadena,19,9))
	
	if this.object.existencias[row] >= cantidad_salida then
		tonochar    = this.object.tonochar[row]
		calibre     = this.object.calibre[row]
		calidad     = this.object.calidad[row]
		ubicacion   = this.object.ubicacion[row]
		
		dw_compuesto.object.tono[dw_compuesto.getrow()]        = tonochar
		dw_compuesto.object.calibre[dw_compuesto.getrow()]     = calibre
		dw_compuesto.object.calidad[dw_compuesto.getrow()]     = calidad
		dw_compuesto.object.tipo_pallet[dw_compuesto.getrow()] = tipo_pallet
		dw_compuesto.object.caja[dw_compuesto.getrow()]        = caja
		dw_compuesto.object.ubicacion[dw_compuesto.getrow()]   = ubicacion
		dw_compuesto.object.cantidad_salida[dw_compuesto.getrow()] = cantidad_salida
	end if
end if
end event

type uo_operario from u_em_campo_2 within w_int_prodpartes_entradas_almacen
event destroy ( )
integer x = 558
integer y = 240
integer width = 814
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_operario.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_operario.em_campo.text=f_nombre_almoperarios_abr(codigo_empresa,uo_operario.em_codigo.text)
IF Trim(uo_operario.em_campo.text)="" THEN 
 IF Trim(uo_operario.em_codigo.text) <> "" Then
	uo_operario.em_campo.SetFocus()
END IF
 uo_operario.em_campo.text  = ""
 uo_operario.em_codigo.text = ""
END IF

f_consulta()
f_vacia_campos()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de operarios"
ue_datawindow = "dw_ayuda_operarios"
ue_filtro     = ""

end event

type st_operario from statictext within w_int_prodpartes_entradas_almacen
integer x = 558
integer y = 156
integer width = 814
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Operario"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipoparte from statictext within w_int_prodpartes_entradas_almacen
integer x = 9
integer y = 156
integer width = 549
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Tipo Parte"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_turnos from dropdownlistbox within w_int_prodpartes_entradas_almacen
integer x = 1371
integer y = 240
integer width = 384
integer height = 312
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Mañana"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Mañana","Tarde","Noche"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;f_consulta()
f_vacia_campos()
end event

type st_turno from statictext within w_int_prodpartes_entradas_almacen
integer x = 1371
integer y = 156
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Turno"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 1755
integer y = 240
integer width = 306
integer height = 88
integer taborder = 40
boolean bringtotop = true
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;f_consulta()
f_vacia_campos()
end event

type st_fecha from statictext within w_int_prodpartes_entradas_almacen
integer x = 1755
integer y = 156
integer width = 306
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_prodpartes_entradas_almacen
integer x = 2473
integer y = 408
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Piezas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_cantidad2 from statictext within w_int_prodpartes_entradas_almacen
integer x = 2802
integer y = 408
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Piezas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_entrada from statictext within w_int_prodpartes_entradas_almacen
integer x = 2802
integer y = 336
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Entrada"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad_entrada from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 2802
integer y = 484
integer width = 325
integer taborder = 170
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;ante_valor = Dec(this.text)
situado    = "em_cantidad_malas"
end event

type st_texto_tiempo from statictext within w_int_prodpartes_entradas_almacen
integer x = 3127
integer y = 408
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Tiempo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad_salida from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 2473
integer y = 484
integer width = 325
integer taborder = 160
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;ante_valor = Dec(this.text)
situado= "CANTIDAD"
end event

event modificado;call super::modificado;string cadena
dec    cantidad

If ante_valor<>Dec(this.text) THEN
	em_cajas.text     = ""
	em_t_cajas.text   = ""
	em_t_pallets.text = ""
END  IF

if genera_entrada_almacen then
	if salida_en_unidad_articulo = "S" then
		cantidad = Dec(this.text)
	else
		cantidad = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
											uo_articulo.em_codigo.text,&
											unidad_salida,&
											Dec(this.text))
	end if
	cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
									 uo_tipo_pallet.em_codigo.text,&
									 uo_caja.em_codigo.text,&
									 integer(em_t_pallets.text),&
									 integer(em_cajas.text),&
									 cantidad)
								  
	em_t_pallets.text = Mid(cadena,1,6)
	em_cajas.text     = Mid(cadena,7,6)
	em_t_cajas.text   = Mid(cadena,13,6)
	if salida_en_unidad_articulo = "S" then
		this.text = Mid(cadena,19,9)
	end if
end if

//if especial and Dec(this.text) > ante_cant then
//f_mensaje("Modificación de líneas","Sólo se permiten modificaciones a la baja")
//f_activar_campo (this)
//this.text = String(ante_cant)
//end if
end event

type dw_2 from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 567
integer y = 1544
integer width = 2414
integer height = 364
string dataobject = "dw_info_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_4 from u_boton within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 1271
integer y = 1288
integer width = 448
integer height = 88
integer taborder = 0
string text = "&Procesar"
end type

event clicked;string  caja_compras
long    indice,total,donde
dec     cantidad,cantidad_articulo
boolean continuar

if articulo_compuesto then
	
	
	if dw_compuesto.rowcount() = 0 then
		dw_compuesto.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
		total = dw_compuesto.rowcount()
		for indice = 1 to total
			cantidad          = dw_compuesto.object.cantidad[indice]
			cantidad_articulo = dw_compuesto.object.cantidad_articulo[indice]
			dw_compuesto.object.cantidad_salida[indice] = cantidad * (cantidad_salida_unidad_articulo / cantidad_articulo)
		next				
		if uo_caja.em_codigo.text <> "" then
			select codigo_compras
			into   :caja_compras
			from   almcajas
			where  empresa = :codigo_empresa
			and    codigo  = :uo_caja.em_codigo.text;
			
			if isnull(caja_compras) then caja_compras = ""
			if trim(caja_compras) <> "" then
				donde = dw_compuesto.insertrow(total +1)
				dw_compuesto.object.empresa[donde] = codigo_empresa
				dw_compuesto.object.producto_terminado[donde] = "N" 
				dw_compuesto.object.producto[donde] = caja_compras
				dw_compuesto.object.cantidad_salida[donde] = dec(em_t_cajas.text)
				dw_compuesto.object.cantidad[indice] = 1
				dw_compuesto.object.cantidad_articulo[indice] = f_piezascaja_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)
			end if
		end if
		dw_compuesto.visible = true
		cb_2.enabled      = false
		cb_borrar.enabled = false
	else
		if f_control_compuesto() then
			continuar = true
			cb_2.enabled      = true
			cb_borrar.enabled = true
		else
			continuar = false
		end if		
	end if
else		
	continuar = true
end if
if continuar then
	if especial then
		//f_procesar_modificacion()
	else
		f_procesar_entrada()
	end if
end if


end event

type cb_borrar from u_boton within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 430
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
string text = "&Borrar"
end type

event clicked;call super::clicked;integer fila
fila=dw_1.getrow()
IF contador=fila THEN
  IF contador<>1 THEN
    contador=contador - 1
  END IF
END IF
IF fila<>0 THEN
 dw_1.DeleteRow(dw_1.getRow())
 dw_1.setrowfocusIndicator(Hand!)
 dw_1.SetColumn("almacen")
 dw_1.setRow(contador)
 dw_1.setfocus()
END IF

end event

type cb_2 from u_boton within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 18
integer y = 1288
integer width = 411
integer height = 88
integer taborder = 0
string text = "&Insertar"
end type

event clicked;integer numero,controles
Dec{2} total_cantidad,total_pendiente
String ante_almacen
string mensaje,nombre,campo
controles=0
contador=dw_1.Rowcount()
dw_1.Accepttext()

IF contador<>0 THEN
 v_almacen  = dw_1.GetItemString(contador,"almacen")	
 v_zona     = dw_1.GetItemString(contador,"zona")	
 v_fila     = dw_1.GetItemNumber(contador,"fila")	
 v_altura   = dw_1.GetItemNumber(contador,"altura")	
 v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	
 // Cuadro la cantidad
 dw_1.SetItem(contador,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,v_cantidad))
 v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	
 
 IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
  controles=1
  campo="almacen"
  mensaje=" Introduzca el almacen " 
 END IF

 IF contador>1 THEN
    ante_almacen  = dw_1.GetItemString(contador - 1,"almacen")	
    IF ante_almacen<> v_almacen THEN
       controles = 1
       campo   = "almacen"
       mensaje = "Esta entrada a de ubicarse en el mismo almacen "
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
  dw_1.SetColumn(campo)
  dw_1.setRow(contador)
  dw_1.setfocus()
  Return
 END IF
END IF

contador=contador+1
dw_1.InsertRow(contador)

total_cantidad  = dw_1.GetItemNumber(1,"total_cantidad")

total_pendiente = cantidad_salida_unidad_articulo - total_cantidad

dw_1.setitem(contador,"cantidad",total_pendiente)
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(contador,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
IF contador > 1 THEN
    dw_1.setitem(contador,"almacen",v_almacen)
END  IF

dw_1.setrowfocusIndicator(Hand!)
IF contador=1 THEN
  dw_1.SetColumn("almacen")
ELSE
dw_1.SetColumn("zona")
END IF
dw_1.setRow(contador)
dw_1.setfocus()





end event

type dw_1 from datawindow within w_int_prodpartes_entradas_almacen
event key pbm_dwnkey
boolean visible = false
integer x = 23
integer y = 720
integer width = 1691
integer height = 564
string dataobject = "dw_int_almlinubi1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;str_parametros param
String bus_campo,bus_cadena
dw_1.AcceptText()
param.b_empresa = TRUE
param.s_nom_datawindow   =  ""

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 param.s_criterio_busqueda=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		param.s_nom_datawindow   =  "dw_ayuda_almacenes"
      param.s_filtro            = ""
CASE "zona"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ZONA "
 		param.s_nom_datawindow   =  "dw_ayuda_almubizonas"
      param.s_filtro            = "almacen='" + &
                                   This.GetItemString(This.GetRow(),"almacen") + "'"
CASE "cantidad"
   // Redondeo a cantidad 
   Dec{2} var_cantidad
   var_cantidad = dw_1.GetItemNumber(dw_1.GetRow(),"cantidad")
   dw_1.SetItem(dw_1.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,var_cantidad))
	SetNull(bus_campo)
            
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return
  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""

IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
  param.s_criterio_busqueda  = bus_cadena
  OpenWithParm(w_busquedas,param)

  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()
END IF
END IF


end event

event rbuttondown; str_parametros param
 String bus_campo,bus_cadena

 param.b_empresa = TRUE
 
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      param.s_titulo_ayuda    = "VENTANA SELECCION DE TIPO DE ALMACENES"
 		param.s_nom_datawindow  = "dw_ayuda_almacenes"
   CASE "zona"
      param.s_titulo_ayuda   = "VENTANA SELECCION DE ZONAS"
      param.s_nom_datawindow = "dw_ayuda_almubizonas"
      param.s_filtro         = "almacen ='"+This.GetItemString(This.GetRow(),"almacen")+"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
  
  OpenWithParm(w_busquedas,param)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
    SetColumn(This.GetColumn())
    This.SetRow(This.getrow())
    This.Setfocus()

end event

type dw_compuesto from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer y = 528
integer width = 2862
integer height = 756
boolean titlebar = true
string title = "Composición del articulo"
string dataobject = "dw_almcompuestoart_entradas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;string producto,tonochar,calidad,tipo_pallet,caja,ubicacion,cadena
long   lineas,calibre
dec    cantidad_salida,precio

dw_stock_prod_terminado.visible = false
dw_stock_prod_terminado.reset()
dw_stock_mat_prima.visible = false
dw_stock_mat_prima.reset()

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	producto        = this.object.producto[row]
	cantidad_salida = this.object.cantidad_salida[row]
	if this.object.producto_terminado[row] = "S" then
		dw_stock_prod_terminado.retrieve(codigo_empresa,producto)
		lineas = dw_stock_prod_terminado.rowcount()
		if lineas > 0 then			
			if lineas = 1 then
				tipo_pallet = dw_stock_prod_terminado.object.tipo_pallet[1]
				caja        = dw_stock_prod_terminado.object.caja[1]
				
				cadena   = f_calculo_unidades(codigo_empresa,producto,tipo_pallet,caja,0,0,cantidad_salida)
								  
				cantidad_salida = dec(Mid(cadena,19,9))
				
				if dw_stock_prod_terminado.object.existencias[1] >= cantidad_salida then
					//Asignamos automaticamente la unica ubicacion
					tonochar    = dw_stock_prod_terminado.object.tonochar[1]
					calibre     = dw_stock_prod_terminado.object.calibre[1]
					calidad     = dw_stock_prod_terminado.object.calidad[1]
					ubicacion   = dw_stock_prod_terminado.object.ubicacion[1]
					
					this.object.tono[row]        = tonochar
					this.object.calibre[row]     = calibre
					this.object.calidad[row]     = calidad
					this.object.tipo_pallet[row] = tipo_pallet
					this.object.caja[row]        = caja
					this.object.ubicacion[row]   = ubicacion
					this.object.cantidad_salida[row] = cantidad_salida
				else
					dw_stock_prod_terminado.BringToTop = TRUE
					dw_stock_prod_terminado.visible = true
					dw_stock_prod_terminado.setfocus()										
				end if
			else
				dw_stock_prod_terminado.BringToTop = TRUE
				dw_stock_prod_terminado.visible = true
				dw_stock_prod_terminado.setfocus()
			end if
		else
			messagebox("Atención","No hay stock de este articulo en almacen.")
		end if
	else
		dw_stock_mat_prima.retrieve(codigo_empresa,producto)
		lineas = dw_stock_mat_prima.rowcount()		
		if lineas > 0 then			
			if lineas = 1 then
				if dw_stock_mat_prima.object.existencias[1] >= cantidad_salida then
					//Asignamos automaticamente la unica ubicacion	
					calidad   = dw_stock_mat_prima.object.calidad[1]
					precio    = dw_stock_mat_prima.object.precio[1]
					ubicacion = dw_stock_mat_prima.object.ubicacion[1]
					
					this.object.calidad[row]   = calidad
					this.object.precio[row]    = precio
					this.object.ubicacion[row] = ubicacion
				else
					dw_stock_mat_prima.BringToTop = TRUE
					dw_stock_mat_prima.visible = true
					dw_stock_mat_prima.setfocus()										
				end if				
			else
				dw_stock_mat_prima.BringToTop = TRUE
				dw_stock_mat_prima.visible = true
				dw_stock_mat_prima.setfocus()
			end if
		else
			messagebox("Atención","No hay stock de esta materia prima en almacen.")
		end if		
	end if
end if
end event

event clicked;dw_stock_prod_terminado.visible = false
dw_stock_prod_terminado.reset()
dw_stock_mat_prima.visible = false
dw_stock_mat_prima.reset()

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

type dw_almlinubicahis from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer y = 720
integer width = 1413
integer height = 684
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_almlinubi4"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event retrievestart;pb_borrar.visible=FALSE
pb_modificar.visible=FALSE
end event

event retrieveend;IF dw_3.RowCount()>0 THEN
  pb_borrar.visible=TRUE
  //pb_modificar.visible=TRUE
END IF
end event

type dw_3 from datawindow within w_int_prodpartes_entradas_almacen
integer y = 672
integer width = 3355
integer height = 1184
string dataobject = "dw_con_prodpartes_entradas_almacen"
boolean vscrollbar = true
string icon = "\BMP\sichar.ico"
borderstyle borderstyle = styleraised!
end type

event retrieveend;pb_borrar.visible = False
pb_modificar.visible = False

end event

event clicked;integer registros

IF row > 0 THEN

	registros = dw_3.RowCount()
	IF registros>0 THEN
		This.SelectRow(0,FALSE)
		This.SelectRow(row,TRUE)		
		This.SetRow(row)
		ubihis.anyo    =  GetItemNumber(row,"movimiento_anyo")
		ubihis.almacen =  GetItemString(row,"movimiento_almacen")
		ubihis.nummov  =  GetItemNumber(row,"movimiento_nummov")	
		dw_almlinubicahis.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
	END IF
//	if especial then	
//		if row = 0 Then Return		
//		uo_articulo.em_codigo.text = dw_3.GetItemString(row,"articulo")
//		uo_articulo.em_campo.text  = f_nombre_articulo (codigo_empresa,uo_articulo.em_codigo.text)
//		uo_calidad.em_codigo.text  = dw_3.GetItemString(row,"calidad")
//		uo_calidad.em_campo.text   = f_nombre_calidad_abr (codigo_empresa,uo_calidad.em_codigo.text)
//		em_tono.text 					= dw_3.GetItemString(row,"tonochar")
//		em_calibre.text 				= String(dw_3.GetItemNumber(row,"calibre"))
//		uo_caja.em_codigo.text  	= dw_3.GetItemString(row,"caja")
//		uo_caja.em_campo.text      = f_nombre_caja_abr (codigo_empresa,uo_caja.em_codigo.text)
//		uo_tipo_pallet.em_codigo.text= dw_3.GetItemString(row,"tipo_pallet")
//		uo_tipo_pallet.em_campo.text = f_nombre_pallet_abr (codigo_empresa,uo_tipo_pallet.em_codigo.text)
//		ante_cant						= dw_3.GetItemNumber(row,"cantidade")
//		em_cantidad.text  			= String(ante_cant)
//		em_cantidad.TriggerEvent("modificado")	
//	end if
END IF
end event

on doubleclicked; dw_almlinubicahis.visible=TRUE
end on

event rbuttondown;if row=0 then return
if rowcount()=0 then return

string operario,turno,tipoparte
datetime fecha
int cont

fecha=datetime(date(em_fecha.text))

if isnull(fecha) or year(date(fecha))=1900 then
	return
end if

operario=uo_operario.em_codigo.text
if operario='' then 
	return
end if

tipoparte=uo_tipoparte.em_codigo.text
if tipoparte='' then 
	return
end if

choose case ddlb_turnos.text
	case 'Mañana'
		turno='M'
	case 'Tarde'
		turno='T'
	case 'Noche'
		turno='N'
end choose

cont=dw_3.object.contador[row]

dw_3.setrow(row)

dw_incidencias.retrieve(codigo_empresa,operario,tipoparte,fecha,turno,cont)	
dw_incidencias.visible = true
//f_activar(false)
end event

event itemchanged;dec    cantidad_entrada,malas,malas_unidad_articulo,buenas_unidad_articulo
dec    entrada_unidad_articulo
string articulo,tipoparte

if row > 0 then
	
	tipoparte              = this.object.tipoparte[row]
	buenas_unidad_articulo = this.object.buenas_unidad_articulo[row]
	articulo               = this.object.articulo[row]
	
	select entrada_en_unidad_articulo,
			 unidad_entrada
	into   :entrada_en_unidad_articulo,
			 :unidad_entrada
	from   prodtipopartes
	where  empresa = :codigo_empresa
	and    codigo  = :tipoparte;
		
	choose case dwo.name
		case "cantidad_entrada"
			cantidad_entrada = dec(data)
			if entrada_en_unidad_articulo = "S" then
				entrada_unidad_articulo = cantidad_entrada
			else
				entrada_unidad_articulo = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
													articulo,&
													unidad_entrada,&
													cantidad_entrada)
			end if			
			if entrada_unidad_articulo >= buenas_unidad_articulo then
				this.object.malas_unidad_articulo[row] = entrada_unidad_articulo - buenas_unidad_articulo
			else
				messagebox("Atención","La entrada debe ser mayor o igual a la salida.")
				return 1				
			end if
		case "malas"
			malas = dec(data)
			if entrada_en_unidad_articulo = "S" then
				malas_unidad_articulo = malas
			else
				malas_unidad_articulo = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
													articulo,&
													unidad_entrada,&
													malas)
			end if						
			this.object.malas_unidad_articulo[row] = entrada_unidad_articulo - buenas_unidad_articulo			
	end choose

end if

if this.update(true) = 1 then
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar.")
	f_consulta()
end if
end event

event itemerror;return 1
end event

type em_t_pallets from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 1755
integer y = 484
integer width = 160
integer taborder = 130
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "PALLET"
end event

event modificado;call super::modificado;string cadena
dec    cantidad

if salida_en_unidad_articulo = "S" then
	cantidad = Dec(em_cantidad_salida.text)
else
	cantidad = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
										uo_articulo.em_codigo.text,&
										unidad_salida,&
										Dec(em_cantidad_salida.text))
end if

cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),cantidad)

em_t_pallets.text       = Mid(cadena,1,6)
em_cajas.text           = Mid(cadena,7,6)
em_t_cajas.text         = Mid(cadena,13,6)
if salida_en_unidad_articulo = "S" then
	em_cantidad_salida.text = Mid(cadena,19,9)
else
	em_cantidad_salida.text = string (f_convertir_unid_art_a_cantidad_parte(codigo_empresa,&
										uo_articulo.em_codigo.text,&
										unidad_salida,&
										Dec(Mid(cadena,19,9))))
	
end if


end event

type em_cajas from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 1915
integer y = 484
integer width = 242
integer taborder = 140
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "CAJAS"
end event

event modificado;call super::modificado;string cadena
dec    cantidad

if salida_en_unidad_articulo = "S" then
	cantidad = Dec(em_cantidad_salida.text)
else
	cantidad = f_convertir_cantidad_parte_a_unid_art(codigo_empresa,&
										uo_articulo.em_codigo.text,&
										unidad_salida,&
										Dec(em_cantidad_salida.text))
end if

cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),cantidad)

em_t_pallets.text       = Mid(cadena,1,6)
em_cajas.text           = Mid(cadena,7,6)
em_t_cajas.text         = Mid(cadena,13,6)
if salida_en_unidad_articulo = "S" then
	em_cantidad_salida.text = Mid(cadena,19,9)
else
	em_cantidad_salida.text = string (f_convertir_unid_art_a_cantidad_parte(codigo_empresa,&
										uo_articulo.em_codigo.text,&
										unidad_salida,&
										Dec(Mid(cadena,19,9))))
	
end if


end event

type em_t_cajas from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 2158
integer y = 484
integer width = 311
integer taborder = 150
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "TOTAL_CAJAS"
end event

type st_7 from statictext within w_int_prodpartes_entradas_almacen
integer x = 2162
integer y = 408
integer width = 311
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "T.Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1915
integer y = 408
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_prodpartes_entradas_almacen
integer x = 1755
integer y = 408
integer width = 160
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_ex from datawindow within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 343
integer y = 664
integer width = 2501
integer height = 408
boolean bringtotop = true
boolean titlebar = true
string title = "Existencias en Almacen"
string dataobject = "dw_int_almlinubi5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string calidad,tono,tipo_pallet,caja
long calibre
if row > 0 then
	calidad     = this.object.almlinubica_calidad[row]
	tono        = this.object.almlinubica_tonochar[row]
	calibre     = this.object.almlinubica_calibre[row]
	tipo_pallet = this.object.almlinubica_tipo_pallet[row]
	caja        = this.object.almlinubica_caja[row]
	uo_calidad.em_codigo.text     = calidad
	uo_calidad.em_campo.text      = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
	em_tono.text                  = tono
	em_calibre.text               = string(calibre)
	uo_caja.em_codigo.text        = caja
	uo_caja.em_campo.text         = f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)	
	uo_tipo_pallet.em_codigo.text = tipo_pallet
	uo_tipo_pallet.em_campo.text  = f_nombre_palarticulocaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)
	em_cajas.setfocus()
end if


end event

event doubleclicked;visible = FALSE
em_cajas.setfocus()
end event

event retrieveend;IF  rowcount <> 0 Then 
	visible = TRUE
ELSE
	visible = FALSE
END IF
end event

type pb_calculadora from u_calculadora within w_int_prodpartes_entradas_almacen
boolean visible = false
integer x = 2327
integer y = 240
integer width = 101
integer height = 84
integer taborder = 50
boolean originalsize = false
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    = codigo_empresa
alm_anyo       = Year(Date(em_fecha.text))
alm_tipomov    = "1" //Entradas Produccion
alm_numdoc     = Dec(sle_numdoc.text)

SELECT max(convert(dec,almmovhis.numdoc))
INTO   :alm_numdoc  
FROM   almmovhis  
WHERE  almmovhis.empresa  = :alm_empresa 
AND    almmovhis.anyo     = :alm_anyo 
AND    almmovhis.tipomov  = :alm_tipomov
AND    almmovhis.numdoc   between "0" and "999999999999999";
IF SQLCA.SQLCode<>0 THEN   alm_numdoc=0
IF IsNUll(alm_numdoc) Then alm_numdoc = 0

alm_numdoc      = alm_numdoc + 1
sle_numdoc.text = string(alm_numdoc,"#######")
sle_numdoc.SetFocus()
end event

type sle_numdoc from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 2071
integer y = 240
integer height = 88
integer taborder = 60
string mask = "######"
end type

event getfocus;call super::getfocus;pb_calculadora.visible = TRUE

ante_numdoc = sle_numdoc.text
end event

event modificado;call super::modificado;if ante_numdoc = sle_numdoc.text then return

if trim(sle_numdoc.text) <> "" then   
   pb_calculadora.visible = false   
End If
end event

type st_documento from statictext within w_int_prodpartes_entradas_almacen
integer x = 2062
integer y = 156
integer width = 366
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Documento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_tipoparte from u_em_campo_2 within w_int_prodpartes_entradas_almacen
event destroy ( )
integer x = 5
integer y = 240
integer width = 549
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipoparte.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tipoparte.em_campo.text = f_nombre_prodtipopartes(codigo_empresa,uo_tipoparte.em_codigo.text)

IF Trim(uo_tipoparte.em_campo.text) = "" THEN 
	IF Trim(uo_tipoparte.em_codigo.text) <> "" Then
		uo_tipoparte.em_campo.SetFocus()
	END IF
	uo_tipoparte.em_campo.text  = ""
	uo_tipoparte.em_codigo.text = ""
ELSE
	f_campos_segun_tipoparte()
END IF

f_consulta()
f_vacia_campos()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de partes"
ue_datawindow = "dw_ayuda_prodtipopartes"
ue_filtro     = ""

end event

type em_minutos from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 3287
integer y = 484
integer width = 101
integer taborder = 190
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

type em_horas from u_em_campo within w_int_prodpartes_entradas_almacen
integer x = 3127
integer y = 484
integer width = 101
integer taborder = 180
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

type st_11 from statictext within w_int_prodpartes_entradas_almacen
integer x = 3232
integer y = 492
integer width = 46
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
boolean enabled = false
string text = "H"
boolean focusrectangle = false
end type

type st_12 from statictext within w_int_prodpartes_entradas_almacen
integer x = 3392
integer y = 492
integer width = 55
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
boolean enabled = false
string text = "m"
boolean focusrectangle = false
end type

type dw_incidencias from u_datawindow_consultas within w_int_prodpartes_entradas_almacen
integer x = 919
integer y = 692
integer width = 1125
integer height = 556
integer taborder = 0
string dataobject = "dw_int_prodpartesdefectos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;string operario,turno,tipoparte
datetime fecha
long donde,contad,cont

choose case dwo.name
	case "t_grabar"
		if dw_incidencias.update()<>1 then
			f_mensaje("Atención","Hubo un error al grabar")
		else
			f_mensaje("Ok","Información grabada correctamente")
		end if
		this.visible = false
	case "t_borrar"
		dw_incidencias.deleterow(dw_incidencias.getrow())
	case "t_insertar"
		
		fecha=datetime(date(em_fecha.text))
		
		if isnull(fecha) or year(date(fecha))=1900 then
			return
		end if
		
		operario=uo_operario.em_codigo.text
		if operario='' then 
			return
		end if
		
		tipoparte=uo_tipoparte.em_codigo.text
		if tipoparte='' then 
			return
		end if
		
		choose case ddlb_turnos.text
			case 'Mañana'
				turno='M'
			case 'Tarde'
				turno='T'
			case 'Noche'
				turno='N'
		end choose
		
		donde=dw_incidencias.insertrow(0)
		
		contad=dw_3.object.contador[dw_3.getrow()]
		
		dw_incidencias.object.empresa[donde]=codigo_empresa
		dw_incidencias.object.tipoparte[donde]=tipoparte
		dw_incidencias.object.operario[donde]=operario
		dw_incidencias.object.turno[donde]=turno
		dw_incidencias.object.fecha[donde]=fecha
		dw_incidencias.object.contador[donde]=contad
		
		dw_incidencias.setfocus()
		dw_incidencias.scrolltorow(donde)
		dw_incidencias.setcolumn("tipodefecto")		
	case "t_salir"
		if dw_incidencias.modifiedcount()<>0 or dw_incidencias.deletedcount()<>0 then
			if messagebox("Atención","Hay lineas sin grabar. ¿Está seguro que desea salir?",information!,YesNo!,2)=1 then
				this.visible = false
			end if
		else
			this.visible = false
		end if		
end choose
end event

event rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodefecto"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DEFECTOS"
 		bus_datawindow = "dw_ayuda_prodtipodefectos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

event key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodefecto"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DEFECTOS"
 		bus_datawindow = "dw_ayuda_prodtipodefectos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

type st_13 from statictext within w_int_prodpartes_entradas_almacen
integer y = 156
integer width = 3355
integer height = 1832
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

