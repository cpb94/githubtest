$PBExportHeader$w_int_movalm.srw
$PBExportComments$Proceso de introduccion movimientos almacen.
forward
global type w_int_movalm from w_int_con_empresa
end type
type st_13 from statictext within w_int_movalm
end type
type st_12 from statictext within w_int_movalm
end type
type st_11 from statictext within w_int_movalm
end type
type st_texto_cantidad from statictext within w_int_movalm
end type
type st_8 from statictext within w_int_movalm
end type
type st_7 from statictext within w_int_movalm
end type
type st_6 from statictext within w_int_movalm
end type
type st_5 from statictext within w_int_movalm
end type
type st_4 from statictext within w_int_movalm
end type
type st_3 from statictext within w_int_movalm
end type
type st_2 from statictext within w_int_movalm
end type
type st_9 from statictext within w_int_movalm
end type
type st_proveedor_etiqueta from statictext within w_int_movalm
end type
type st_nombre_proveedor from statictext within w_int_movalm
end type
type pb_1 from upb_salir within w_int_movalm
end type
type em_fecha from u_em_campo within w_int_movalm
end type
type sle_tipomov from u_em_campo within w_int_movalm
end type
type sle_numdoc from u_em_campo within w_int_movalm
end type
type em_tono from u_em_campo within w_int_movalm
end type
type em_calibre from u_em_campo within w_int_movalm
end type
type em_t_pallets from u_em_campo within w_int_movalm
end type
type em_cajas from u_em_campo within w_int_movalm
end type
type em_t_cajas from u_em_campo within w_int_movalm
end type
type em_cantidad from u_em_campo within w_int_movalm
end type
type sle_observaciones from u_em_campo within w_int_movalm
end type
type sle_proveedor from u_em_campo within w_int_movalm
end type
type cb_1 from u_boton within w_int_movalm
end type
type cb_4 from u_boton within w_int_movalm
end type
type cb_3 from u_boton within w_int_movalm
end type
type cb_borrar from u_boton within w_int_movalm
end type
type uo_articulo from u_em_campo_2 within w_int_movalm
end type
type uo_calidad from u_em_campo_2 within w_int_movalm
end type
type pb_calculadora from u_calculadora within w_int_movalm
end type
type p_proveedor from up_carpeta within w_int_movalm
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_movalm
end type
type pb_imprimir_preli from picturebutton within w_int_movalm
end type
type dw_listado from datawindow within w_int_movalm
end type
type st_10 from statictext within w_int_movalm
end type
type uo_caja from u_em_campo_2 within w_int_movalm
end type
type cb_5 from commandbutton within w_int_movalm
end type
type st_1 from statictext within w_int_movalm
end type
type cb_2 from u_boton within w_int_movalm
end type
type st_nombre_tipomov from statictext within w_int_movalm
end type
type st_formato from statictext within w_int_movalm
end type
type dw_stock_prod_terminado from datawindow within w_int_movalm
end type
type dw_stock_mat_prima from datawindow within w_int_movalm
end type
type dw_2 from datawindow within w_int_movalm
end type
type dw_compuesto from datawindow within w_int_movalm
end type
type dw_almlinubicahis from datawindow within w_int_movalm
end type
type dw_5 from datawindow within w_int_movalm
end type
type st_14 from statictext within w_int_movalm
end type
type dw_1 from datawindow within w_int_movalm
end type
type dw_4 from datawindow within w_int_movalm
end type
type dw_3 from datawindow within w_int_movalm
end type
type dw_ex from datawindow within w_int_movalm
end type
type pb_modificar from upb_papelera within w_int_movalm
end type
type pb_borrar from upb_papelera within w_int_movalm
end type
type st_tecla2 from statictext within w_int_movalm
end type
type pb_2 from picturebutton within w_int_movalm
end type
type st_tecla from statictext within w_int_movalm
end type
type st_15 from statictext within w_int_movalm
end type
end forward

global type w_int_movalm from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 5545
integer height = 2284
string icon = "\bmp\RINO.ICO"
st_13 st_13
st_12 st_12
st_11 st_11
st_texto_cantidad st_texto_cantidad
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_9 st_9
st_proveedor_etiqueta st_proveedor_etiqueta
st_nombre_proveedor st_nombre_proveedor
pb_1 pb_1
em_fecha em_fecha
sle_tipomov sle_tipomov
sle_numdoc sle_numdoc
em_tono em_tono
em_calibre em_calibre
em_t_pallets em_t_pallets
em_cajas em_cajas
em_t_cajas em_t_cajas
em_cantidad em_cantidad
sle_observaciones sle_observaciones
sle_proveedor sle_proveedor
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
cb_borrar cb_borrar
uo_articulo uo_articulo
uo_calidad uo_calidad
pb_calculadora pb_calculadora
p_proveedor p_proveedor
uo_tipo_pallet uo_tipo_pallet
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
st_10 st_10
uo_caja uo_caja
cb_5 cb_5
st_1 st_1
cb_2 cb_2
st_nombre_tipomov st_nombre_tipomov
st_formato st_formato
dw_stock_prod_terminado dw_stock_prod_terminado
dw_stock_mat_prima dw_stock_mat_prima
dw_2 dw_2
dw_compuesto dw_compuesto
dw_almlinubicahis dw_almlinubicahis
dw_5 dw_5
st_14 st_14
dw_1 dw_1
dw_4 dw_4
dw_3 dw_3
dw_ex dw_ex
pb_modificar pb_modificar
pb_borrar pb_borrar
st_tecla2 st_tecla2
pb_2 pb_2
st_tecla st_tecla
st_15 st_15
end type
global w_int_movalm w_int_movalm

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
public function boolean f_control_reservas_borrado ()
public function boolean f_control_reservas ()
public function long ver_movimientos ()
end prototypes

public subroutine f_control_tono_calibre (); control_tono     =  TRUE
 control_calibre  =  TRUE
 
//---------------------------------------------------------------
//      A peticion de JUANMA -- poder saldar stock negativo
//---------------------------------------------------------------
//IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
//   control_tono   =  FALSE
// 	em_tono.text       =  ""
//else
//	if uo_calidad.em_codigo.text = "2" then em_tono.text =  "0"
//	if em_tono.text= "" then	em_tono.text =  "1"
//END IF
//---------------------------------------------------------------


IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text    =  "0"
//else
//   if em_calibre.text="" then em_calibre.text    =  "1"
END IF  
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

String antealmacen
dec y1,longitudes
Date fecha
Dec numero,controles,x2,x1
Decimal{4} total_cantidad
string mensaje,nombre,campo
boolean compras_bloqueadas,continuar


controles   = 0
contador    = dw_1.Rowcount()
IF contador = 0 THEN
	MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
	Return
END IF

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
	if cod_sector = 'S' then // David 26-10-05
		dw_1.SetItem(x2,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,v_cantidad))
		v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
	end if
	
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
IF total_cantidad<>Dec(em_cantidad.text) THEN
	MessageBox("No Puedo Procesar","El total de unidades/metros no coinciden",Exclamation!, OK!,1)
	Return
END IF

pb_1.enabled = FALSE

if articulo_compuesto then
	IF Not f_bloquear_almacen_compras(w_int_movalm.title) Then
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
	IF Not f_bloquear_almacen(w_int_movalm.title) Then
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
		ubihis.anyo          = year(date(String(em_fecha.text)))
		ubihis.almacen       = v_almacen
		ubihis.articulo      = uo_articulo.em_codigo.text
		ubihis.calidad       = uo_calidad.em_codigo.text
		ubihis.tonochar      = Trim(em_tono.text)
		ubihis.calibre       = dec(em_calibre.text)
		// David 12-04-2006
		IF IsNUll(ubihis.calibre) Then ubihis.calibre = 0
		IF IsNUll(ubihis.tonochar)  Then ubihis.tonochar = ""
		ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
		ubihis.f_alta        = DateTime(Today(),now())
		ubihis.observaciones = sle_observaciones.text
		ubihis.tipomov       = sle_tipomov.text
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
		mov.cantidade  = Dec(em_cantidad.text)
		mov.cantidads  =0
		mov.precio     =0
		IF f_tipo_almtipomov(codigo_empresa,mov.tipomov)="P"  THEN
			mov.codtercero=sle_proveedor.text
		ELSE
			SetNull(mov.codtercero)
		END IF
		mov.numdoc        = sle_numdoc.text
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

			//dw_proceso = f_cargar_cursor2(sel)
			f_cargar_cursor_nuevo(sel, dw_proceso)						
			
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
					ubi.observaciones = sle_observaciones.text // David 19-07-01
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
		if articulo_compuesto then
			if not(f_procesar_salida_compuesto(mov.almacen,mov.anyo,mov.nummov)) then
				bien = 1
			end if
		end if
		if f_control_reservas() then
			bien = 0
		else
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
		f_desbloquear_almacen(w_int_movalm.title)
		pb_1.enabled = TRUE
		cb_3.TriggerEvent(Clicked!)
	END IF
	
	if articulo_compuesto then
		IF compras_bloqueadas Then
			f_desbloquear_almacen_compras(w_int_movalm.title)
		end if
	end if		
		
	// prueba para posicionarnos en el que se acaba de insertar
	//f_mensaje("expr","almmovhis_empresa='"+mov.empresa+"'"+" and almmovhis_articulo ='"+mov.articulo +"' and almmovhis_nummov="+String(mov.nummov))
	Long n
	n=dw_3.find("almmovhis_empresa='"+mov.empresa+"'"+" and almmovhis_articulo ='"+mov.articulo +"' and almmovhis_nummov="+String(mov.nummov),1,dw_3.rowcount())
	if n>0 then dw_3.ScrollToRow(n)
end if

destroy dw_proceso
end subroutine

public subroutine f_procesar_modificacion ();// Este procedimiento permite realizar modificaciones en entradas de
// almacén efectuadas en el pasado
//---------------------//
// Control Ubicaciones //
//---------------------//

String antealmacen
dec y1,longitudes
Date fecha
Dec numero,controles,x2,x1
Decimal{4} total_cantidad
string mensaje,nombre,campo
Integer resp

resp = MessageBox("Modificación de una entrada ","¿Está seguro de que desea modificar la cantidad de esta entrada de almacén?",Question!,YesNo!,1)
if resp = 2 then 
	return
end if

controles  = 0
contador = dw_1.Rowcount()
IF contador=0 THEN
 MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
 Return
END IF
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
 controles=1
 campo="almacen"
 mensaje=" Introduzca el almacén "
END IF

If x2 > 1 Then
 IF antealmacen<> v_almacen THEN
  campo="almacen"
  controles=1
  mensaje=" Todos los Movimientos deben de ubicarse en un mismo almacén "
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
 mensaje= "Introduzca la fila de la ubicación"
END IF

IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
 controles=1
 campo="altura"
 mensaje= "Introduzca la altura de la ubicación"
END IF

IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
 controles=1
 campo="cantidad"
 mensaje= "Introduzca la cantidad"
END IF

nombre=f_nombre_almacen(codigo_empresa,v_almacen)
IF (trim(nombre)="") and controles=0 THEN
  mensaje="El almacén no existe "
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
    mensaje= "La ubicación no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

IF controles=1 THEN
  MessageBox("Campo obligatorio en linea"+string(x2),mensaje,Exclamation!, OK!,1)
  dw_1.SetColumn(campo)
  dw_1.setRow(x2)
  dw_1.setfocus()
 Return
END IF
antealmacen = v_almacen
NEXT

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
IF total_cantidad<>Dec(em_cantidad.text) THEN
  MessageBox("No Puedo Procesar","El total de unidades/metros no coinciden",Exclamation!, OK!,1)
  Return
END IF

pb_1.enabled=FALSE




IF Not f_bloquear_almacen(w_int_movalm.title) Then
//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de modificación
//---------------------------------------------------------------------
// Contador de movimiento y orden de lineas de  ubicacion
   Dec contador_nummov,contador_orden 

// Valor de controles funcionamiento
   dec bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubihis.empresa       = codigo_empresa

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
 ubihis.tipomov       = sle_tipomov.text
 ubihis.tipo_pallet   = uo_tipo_pallet.em_codigo.text
 ubihis.caja          = uo_caja.em_codigo.text



  SELECT articulos.familia,articulos.formato,articulos.modelo,
  			articulos.unidad,articulos.sector
    INTO :ubihis.familia,:ubihis.formato,   
         :ubihis.modelo,:ubihis.tipo_unidad  ,:ubihis.sector
    FROM articulos  
   WHERE articulos.empresa= :ubihis.empresa
	AND   articulos.codigo = :ubihis.articulo ;
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
ubi.referencia =  mov.referencia
mov.f_alta     =  DateTime(Today(),now())
fecha          =  Date(String(em_fecha.text))
mov.anyo       =  year(fecha)
mov.origen     = "1"
mov.fechmov    = ubihis.fecha
mov.tipomov    = ubihis.tipomov
mov.cantidade  = Dec(em_cantidad.text)
mov.cantidads  =0
mov.precio     =0
IF f_tipo_almtipomov(codigo_empresa,mov.tipomov)="P"  THEN
  mov.codtercero=sle_proveedor.text
ELSE
  SetNull(mov.codtercero)
END IF
mov.numdoc        = sle_numdoc.text
mov.situacion     = "N"
mov.observaciones = sle_observaciones.text
SetNull(mov.punteado)
mov.antexist   =0

//// Valor movimiento historico
mov.empresa    =  ubihis.empresa
mov.almacen    =  ubihis.almacen
mov.anyo       =  dw_3.GetItemNumber(dw_3.GetRow(),"almmovhis_anyo")

mov.nummov     = dw_3.GetItemNumber(dw_3.GetRow(),"almmovhis_nummov")
ubihis.nummov  = mov.nummov

 contador = dw_1.Rowcount()

 FOR x2=1 TO contador
	  ubihis.orden      = dw_1.GetItemNumber(x2,"orden")
     ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")
     ubihis.usuario    = nombre_usuario
	  ubihis.almacen    = dw_1.GetItemString(x2,"almacen")
	  ubihis.zona       = dw_1.GetItemString(x2,"zona")
	  ubihis.fila       = dw_1.GetItemNumber(x2,"fila")
	  ubihis.altura     = dw_1.GetItemNumber(x2,"altura")	  
     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
     ubi.existencias     = ubihis.cantidade
     ubi.ubicacion       = ubihis.ubicacion
     //------------------------------------------------------------------
     // Modifico el historico de lineas de ubicacion por movimiento
     //------------------------------------------------------------------
	  update almlinubicahis
	     set cantidade = :ubihis.cantidade
		where empresa   = :codigo_empresa
		  and anyo      = :ubihis.anyo
		  and almacen   = :ubihis.almacen
		  and orden     = :ubihis.orden;
		  
		if sqlca.sqlcode <> 0 then 
			bien = 1
			f_mensaje ("Error al actualizar almlinubicahis", sqlca.sqlerrtext)
		end if

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

//dw_proceso = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dw_proceso)


registros = dw_proceso.RowCount()
dec grabado,salir
grabado=0
salir  =0
IF registros<>0 THEN
 FOR x1 = 1 To registros
  cur_empresa       =   codigo_empresa
  cur_almacen       =   f_almacen_ubicacion(ubi.ubicacion)
  cur_ubicacion     =   ubi.ubicacion
  cur_referencia    =   ubi.referencia
  cur_existencias   =   dw_proceso.GetItemNumber(x1,"existencias")
  //***
//  f_mensaje("cur_existencias",String(cur_existencias))
  
  ubi.existencias   =   cur_existencias - dw_1.GetItemDecimal(x2,"cant_anterior") + dw_1.GetItemDecimal(x2,"cantidad")
  //***
//  f_mensaje("ubi.existencias",String(ubi.existencias))

  cur_tipo_pallet   =   ubihis.tipo_pallet
  cur_linea         =   dw_proceso.GetItemNumber(x1,"linea")
  grabado = 1
     //ubi.existencias=ubi.existencias + cur_existencias
       UPDATE almlinubica  
       SET existencias   = :ubi.existencias
       WHERE  almlinubica.empresa   = :ubi.empresa 
		 AND    almlinubica.ubicacion = :ubi.ubicacion 
		 AND    almlinubica.linea     = :cur_linea  USING SQLCA;
       IF SQLCA.SQLCode<>0 THEN  
			bien=1
			f_mensaje("Error en actualización de almlinubica",sqlca.sqlerrtext)
			exit 
		end if
			
NEXT
END IF
IF grabado=0 THEN
    ubi.existencias   =  dw_1.GetItemDecimal(x2,"cantidad") - dw_1.GetItemDecimal(x2,"cant_anterior")
    cur_linea=0
    SELECT  max(almlinubica.linea)  INTO :cur_linea FROM almlinubica  
   WHERE   almlinubica.empresa   = :ubi.empresa 
	AND     almlinubica.ubicacion = :ubi.ubicacion;
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
    cur_linea = 0 
   END IF
    cur_linea=cur_linea+1
    ubi.linea=cur_linea
    SetNull(ubi.observaciones)
	 ubi.observaciones = sle_observaciones.text // David 18-07-01
    IF NOT f_insert_almlinubica(ubi) Then  bien=1

END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------
// el contador incrementa uno para cada linea
     contador_orden = contador_orden + 1
NEXT

 // Grabar el movimiento en el historico por el total de existencias
   update almmovhis
	   set cantidade = :mov.cantidade
	 where almmovhis.empresa =:codigo_empresa
	   and almmovhis.almacen =:mov.almacen
		and almmovhis.anyo    =:mov.anyo
		and almmovhis.nummov  =:mov.nummov;
		
	if sqlca.sqlcode <> 0 then
      f_mensaje("Error modificando almmovhis",sqlca.sqlerrtext)
      bien=1
   END IF
//****
//bien=1
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
  f_desbloquear_almacen(w_int_movalm.title)
pb_1.enabled=TRUE
cb_3.TriggerEvent(Clicked!)
END IF

destroy dw_proceso
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

SELECT  venmprima.familia,
		  	venmprima.tipo_unidad,  
		  	venmprima.envase
INTO    	:com_ubihis.familia,
        		:com_ubihis.tipo_unidad,
		  	:com_ubihis.envase
FROM    venmprima  
WHERE  (venmprima.empresa = :com_ubihis.empresa ) AND  
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
com_mov.numdoc      = sle_numdoc.text
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

//ubicaciones = f_cargar_cursor(sel)

f_cargar_cursor_nuevo(sel, ubicaciones)

registros   = ubicaciones.rowcount()
IF registros > 0 Then	
	FOR x1 = 1 To Registros
		cur_linea       		= ubicaciones.GetItemNumber(x1,"linea")
		cur_existencias 	= ubicaciones.GetItemNumber(x1,"existencias")
		cur_precio      		= ubicaciones.GetItemNumber(x1,"precio")
		
		//IF cur_precio = com_ubihis.precio then
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
		//END IF
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

if not(bien) then
	MessageBox("Atención","Error en salida "+f_nombre_mprima(codigo_empresa,com_ubi.mp),Exclamation!, OK!,1)
end if

destroy ubicaciones
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
mov.numdoc      = sle_numdoc.text
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
		"and  (pedido      is null or pedido = 0)"
		
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
			f_Cargar_cursor_nuevo(sel, ubicaciones)
			
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
				
				almlinubica.observaciones = sle_observaciones.text
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

public function boolean f_control_reservas_borrado ();String  articulo,sel,texto4
Long    registros,indice,anyo_pedido,pedido,linea
Boolean retorno
Datastore data

articulo = dw_3.getItemString(dw_3.GetRow(),"almmovhis_articulo")
texto4   = em_fecha.text+" "+sle_tipomov.text+" "+sle_numdoc.text
retorno  = true

Sel = " SELECT   anyo,pedido,linea,cantidad " + &
		" FROM     venliped " + &
		" WHERE    empresa    = '"+ codigo_empresa  + "'" +&
		" AND      articulo   = '"+ articulo + "'" +&
		" AND      situacion  = 'C' "+&
		" AND      texto4     = '"+texto4+"'"+&
		" ORDER BY fpedido "
		
//data       = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)

registros  = data.RowCount()

for indice = 1 to registros
	f_mensaje_proceso("Control de Reservas",indice,registros)
	anyo_pedido = data.getItemNumber(indice,"anyo")
	pedido      = data.getItemNumber(indice,"pedido")
	linea       = data.getItemNumber(indice,"linea")
	
	UPDATE venliped
	SET situacion = 'F',texto4 = ""
	WHERE venliped.anyo   = :anyo_pedido   AND
			venliped.pedido = :pedido AND
			venliped.linea  = :linea
	USING SQLCA;
	if SQLCA.Sqlcode = 0 then
		retorno = retorno and true
	else
		retorno = retorno and false
	end if
next
destroy data

return retorno
end function

public function boolean f_control_reservas ();String  articulo,sel,fecha,tipomov,numdoc
Long    cantidad,registros,indice,anyo_pedido,pedido,linea,cantidad_pedido
Boolean retorno
Datastore datos

articulo = uo_articulo.em_codigo.text
cantidad = dec(em_cantidad.text)
fecha    = em_fecha.text
tipomov  = sle_tipomov.text
numdoc   = sle_numdoc.text
retorno  = true

Sel = " SELECT   anyo,pedido,linea,cantidad " + &
		" FROM     venliped " + &
		" WHERE    empresa    = '"+ codigo_empresa  + "'" +&
		" AND      articulo  = '"+ articulo + "'" +&
		" AND      situacion  = 'F' "+&
		" ORDER BY fpedido "
		
//datos      = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, datos)

registros  = datos.RowCount()

for indice = 1 to registros
	f_mensaje_proceso("Control de Reservas",indice,registros)
	anyo_pedido = datos.getItemNumber(indice,"anyo")
	pedido = datos.getItemNumber(indice,"pedido")
	linea  = datos.getItemNumber(indice,"linea")
	cantidad_pedido = datos.getItemnumber(indice,"cantidad")
	if cantidad_pedido <= cantidad then
		cantidad = cantidad - cantidad_pedido
		UPDATE venliped
		SET situacion = 'C',texto4 = :fecha+" "+:tipomov+" "+:numdoc
		WHERE venliped.anyo   = :anyo_pedido   AND
				venliped.pedido = :pedido AND
				venliped.linea  = :linea
		USING SQLCA;
		if SQLCA.Sqlcode = 0 then
			retorno = retorno and true
		else
			retorno = retorno and false
		end if
	end if
next
destroy datos
return retorno
end function

public function long ver_movimientos ();Long resultado
resultado = 0
If Trim(sle_tipomov.text) = "" or Trim(sle_numdoc.text) = "" Then
  dw_3.Reset()
Else
  resultado = dw_3.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
End If

return resultado
end function

on ue_f5;call w_int_con_empresa::ue_f5;IF pb_calculadora.visible = FALSE Then Return
pb_calculadora.TriggerEvent(Clicked!)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Movimientos Entradas almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
em_fecha.text=string(today())
dw_2.Settransobject(SQLCA)
dw_ex.Settransobject(SQLCA)
dw_3.Settransobject(SQLCA)
dw_4.Settransobject(SQLCA)
dw_5.Settransobject(SQLCA)
dw_almlinubicahis.Settransobject(SQLCA)
dw_compuesto.Settransobject(SQLCA)
dw_stock_mat_prima.Settransobject(SQLCA)
dw_stock_prod_terminado.Settransobject(SQLCA)

end event

on w_int_movalm.create
int iCurrent
call super::create
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_texto_cantidad=create st_texto_cantidad
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_9=create st_9
this.st_proveedor_etiqueta=create st_proveedor_etiqueta
this.st_nombre_proveedor=create st_nombre_proveedor
this.pb_1=create pb_1
this.em_fecha=create em_fecha
this.sle_tipomov=create sle_tipomov
this.sle_numdoc=create sle_numdoc
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.em_t_pallets=create em_t_pallets
this.em_cajas=create em_cajas
this.em_t_cajas=create em_t_cajas
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.sle_proveedor=create sle_proveedor
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_borrar=create cb_borrar
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.pb_calculadora=create pb_calculadora
this.p_proveedor=create p_proveedor
this.uo_tipo_pallet=create uo_tipo_pallet
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.st_10=create st_10
this.uo_caja=create uo_caja
this.cb_5=create cb_5
this.st_1=create st_1
this.cb_2=create cb_2
this.st_nombre_tipomov=create st_nombre_tipomov
this.st_formato=create st_formato
this.dw_stock_prod_terminado=create dw_stock_prod_terminado
this.dw_stock_mat_prima=create dw_stock_mat_prima
this.dw_2=create dw_2
this.dw_compuesto=create dw_compuesto
this.dw_almlinubicahis=create dw_almlinubicahis
this.dw_5=create dw_5
this.st_14=create st_14
this.dw_1=create dw_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_ex=create dw_ex
this.pb_modificar=create pb_modificar
this.pb_borrar=create pb_borrar
this.st_tecla2=create st_tecla2
this.pb_2=create pb_2
this.st_tecla=create st_tecla
this.st_15=create st_15
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_13
this.Control[iCurrent+2]=this.st_12
this.Control[iCurrent+3]=this.st_11
this.Control[iCurrent+4]=this.st_texto_cantidad
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.st_proveedor_etiqueta
this.Control[iCurrent+14]=this.st_nombre_proveedor
this.Control[iCurrent+15]=this.pb_1
this.Control[iCurrent+16]=this.em_fecha
this.Control[iCurrent+17]=this.sle_tipomov
this.Control[iCurrent+18]=this.sle_numdoc
this.Control[iCurrent+19]=this.em_tono
this.Control[iCurrent+20]=this.em_calibre
this.Control[iCurrent+21]=this.em_t_pallets
this.Control[iCurrent+22]=this.em_cajas
this.Control[iCurrent+23]=this.em_t_cajas
this.Control[iCurrent+24]=this.em_cantidad
this.Control[iCurrent+25]=this.sle_observaciones
this.Control[iCurrent+26]=this.sle_proveedor
this.Control[iCurrent+27]=this.cb_1
this.Control[iCurrent+28]=this.cb_4
this.Control[iCurrent+29]=this.cb_3
this.Control[iCurrent+30]=this.cb_borrar
this.Control[iCurrent+31]=this.uo_articulo
this.Control[iCurrent+32]=this.uo_calidad
this.Control[iCurrent+33]=this.pb_calculadora
this.Control[iCurrent+34]=this.p_proveedor
this.Control[iCurrent+35]=this.uo_tipo_pallet
this.Control[iCurrent+36]=this.pb_imprimir_preli
this.Control[iCurrent+37]=this.dw_listado
this.Control[iCurrent+38]=this.st_10
this.Control[iCurrent+39]=this.uo_caja
this.Control[iCurrent+40]=this.cb_5
this.Control[iCurrent+41]=this.st_1
this.Control[iCurrent+42]=this.cb_2
this.Control[iCurrent+43]=this.st_nombre_tipomov
this.Control[iCurrent+44]=this.st_formato
this.Control[iCurrent+45]=this.dw_stock_prod_terminado
this.Control[iCurrent+46]=this.dw_stock_mat_prima
this.Control[iCurrent+47]=this.dw_2
this.Control[iCurrent+48]=this.dw_compuesto
this.Control[iCurrent+49]=this.dw_almlinubicahis
this.Control[iCurrent+50]=this.dw_5
this.Control[iCurrent+51]=this.st_14
this.Control[iCurrent+52]=this.dw_1
this.Control[iCurrent+53]=this.dw_4
this.Control[iCurrent+54]=this.dw_3
this.Control[iCurrent+55]=this.dw_ex
this.Control[iCurrent+56]=this.pb_modificar
this.Control[iCurrent+57]=this.pb_borrar
this.Control[iCurrent+58]=this.st_tecla2
this.Control[iCurrent+59]=this.pb_2
this.Control[iCurrent+60]=this.st_tecla
this.Control[iCurrent+61]=this.st_15
end on

on w_int_movalm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_texto_cantidad)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_9)
destroy(this.st_proveedor_etiqueta)
destroy(this.st_nombre_proveedor)
destroy(this.pb_1)
destroy(this.em_fecha)
destroy(this.sle_tipomov)
destroy(this.sle_numdoc)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.em_t_pallets)
destroy(this.em_cajas)
destroy(this.em_t_cajas)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.sle_proveedor)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_borrar)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.pb_calculadora)
destroy(this.p_proveedor)
destroy(this.uo_tipo_pallet)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.st_10)
destroy(this.uo_caja)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.st_nombre_tipomov)
destroy(this.st_formato)
destroy(this.dw_stock_prod_terminado)
destroy(this.dw_stock_mat_prima)
destroy(this.dw_2)
destroy(this.dw_compuesto)
destroy(this.dw_almlinubicahis)
destroy(this.dw_5)
destroy(this.st_14)
destroy(this.dw_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_ex)
destroy(this.pb_modificar)
destroy(this.pb_borrar)
destroy(this.st_tecla2)
destroy(this.pb_2)
destroy(this.st_tecla)
destroy(this.st_15)
end on

event ue_listar;Integer opc
tipo_array arg

arg.valor[1] = "Unidad de las cantidades en el listado"
arg.valor[11] = "Su unidad"
arg.valor[12] = "Metros cuad."
arg.valor[13] = "Cancelar"
opc = f_opciones (arg)

choose case opc 
	case 1 
		dw_listado.DataObject = "report_int_movalm"
	case 2
		dw_listado.DataObject = "report_int_movalm_m2"
	case 3
		return
end choose
dw_listado.SetTransObject(SQLCA)
dw_listado.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
dw_report = dw_listado
CALL Super::ue_listar
end event

event ue_f4;call super::ue_f4;IF pb_2.visible = FALSE Then Return
pb_2.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_int_movalm = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movalm
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movalm
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movalm
integer x = 5
integer y = 12
integer width = 5056
end type

type st_13 from statictext within w_int_movalm
integer x = 2322
integer y = 172
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Docu."
boolean focusrectangle = false
end type

type st_12 from statictext within w_int_movalm
integer x = 773
integer y = 172
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Mvto"
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_movalm
integer x = 18
integer y = 164
integer width = 192
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_movalm
integer x = 4160
integer y = 316
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_movalm
integer x = 3351
integer y = 316
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_movalm
integer x = 3849
integer y = 316
integer width = 306
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "T.Cajas"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_movalm
integer x = 3602
integer y = 316
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_movalm
integer x = 2830
integer y = 316
integer width = 512
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_movalm
integer x = 2139
integer y = 316
integer width = 210
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_movalm
integer x = 1925
integer y = 316
integer width = 210
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_movalm
integer x = 1673
integer y = 316
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movalm
integer x = 46
integer y = 496
integer width = 439
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
string text = "Observaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_proveedor_etiqueta from statictext within w_int_movalm
boolean visible = false
integer x = 3099
integer y = 160
integer width = 315
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
string text = "Proveedor"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_proveedor from statictext within w_int_movalm
boolean visible = false
integer x = 3913
integer y = 160
integer width = 923
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movalm
integer x = 5097
integer y = 16
integer width = 128
integer height = 108
integer taborder = 0
alignment htextalign = right!
end type

type em_fecha from u_em_campo within w_int_movalm
integer x = 247
integer y = 156
integer width = 347
integer taborder = 20
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

on modified;call u_em_campo::modified;ver_movimientos()
end on

type sle_tipomov from u_em_campo within w_int_movalm
integer x = 1074
integer y = 160
integer width = 288
integer taborder = 30
end type

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_almtipomov(codigo_empresa,sle_tipomov.text)
IF LEN(st_nombre_tipomov.text)=0 THEN 
   IF LEN(sle_tipomov.text)<>0 Then f_activar_campo(sle_tipomov)
   sle_tipomov.text="" 
   Return
END IF
IF f_interno_almtipomov(codigo_empresa,sle_tipomov.text)= "S" Or&
    f_codigo_real_almtipomov(codigo_empresa,sle_tipomov.text)<> "E"  Then
 sle_tipomov.text="" 
 st_nombre_tipomov.text = ""
END IF







ver_movimientos()

// Para Entradas de compras saco el proveedor

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) = "P"  THEN
  st_nombre_proveedor.visible  = TRUE
  sle_proveedor.visible        = TRUE
  st_proveedor_etiqueta.visible= TRUE
  p_proveedor.visible          = TRUE

  // recojo el proveedor en caso de compras
   integer registros
   string v_proveedor
   registros = dw_3.RowCount()
    IF registros >0 THEN
      v_proveedor = dw_3.GetItemString(1,"almmovhis_codtercero")
      sle_proveedor.text = v_proveedor
      st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
   END IF
ELSE
  st_nombre_proveedor.visible  = FALSE
  sle_proveedor.visible        = FALSE
  st_proveedor_etiqueta.visible= FALSE
  p_proveedor.visible          = FALSE
END IF
end event

on getfocus;call u_em_campo::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos"
ue_datawindow = "dw_ayuda_almtipomov_entradas"
ue_filtro     = "interno = 'N'"
end on

type sle_numdoc from u_em_campo within w_int_movalm
integer x = 2583
integer y = 164
integer taborder = 40
string mask = "######"
end type

event modificado;call super::modificado;Long movimientos

if ante_numdoc=sle_numdoc.text then return

if trim(sle_numdoc.text)<>"" then
   
   movimientos = ver_movimientos()
	
	if movimientos <= 0 then
		MessageBox("Error", "Número de documento no existente. ~nSi desea generar un nuevo número de documento, pulse F5. ~nSi desea recuperar el último número de documento generado, pulse F4.")
		return
	end if

   // recojo el proveedor en caso de compras
 
   IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
      integer registros
      string v_proveedor
      registros = dw_3.RowCount()
      IF registros >0 THEN
          v_proveedor = dw_3.GetItemString(1,"almmovhis_codtercero")
          sle_proveedor.text = v_proveedor
          st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
      END IF

   END IF

   pb_calculadora.visible = FALSE
	pb_2.visible = FALSE
	st_tecla.visible = FALSE
	st_tecla2.visible = FALSE
   
End If
end event

event getfocus;call super::getfocus;pb_calculadora.visible = TRUE
pb_2.visible = TRUE
st_tecla.visible = TRUE
st_tecla2.visible = TRUE

ante_numdoc = sle_numdoc.text
end event

type em_tono from u_em_campo within w_int_movalm
integer x = 1925
integer y = 392
integer width = 210
integer taborder = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
string mask = "!!!!"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type em_calibre from u_em_campo within w_int_movalm
integer x = 2139
integer y = 392
integer width = 210
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type em_t_pallets from u_em_campo within w_int_movalm
integer x = 3351
integer y = 392
integer width = 247
integer taborder = 170
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "PALLET"
end event

event modificado;call super::modificado;string cadena
long posi,posi_aux

//cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
//                          uo_tipo_pallet.em_codigo.text,&
//								  uo_caja.em_codigo.text,&
//                          integer(em_t_pallets.text),&
//                          integer(em_cajas.text),Dec(em_cantidad.text))
cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          	uo_tipo_pallet.em_codigo.text,&
						uo_caja.em_codigo.text,&
                          	integer(em_t_pallets.text),&
                          	0,&
						0)

posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_t_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

end event

type em_cajas from u_em_campo within w_int_movalm
integer x = 3598
integer y = 392
integer width = 247
integer taborder = 180
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "CAJAS"
end event

event modificado;call super::modificado;string cadena
long  posi,posi_aux

//cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
//                          uo_tipo_pallet.em_codigo.text,&
//								  uo_caja.em_codigo.text,&
//                           integer(em_t_pallets.text),&
//                           integer(em_cajas.text),&
//                           Dec(em_cantidad.text))
cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                           0,&
                           integer(em_cajas.text),&
                           0)
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_t_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

end event

type em_t_cajas from u_em_campo within w_int_movalm
integer x = 3845
integer y = 392
integer width = 311
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "TOTAL_CAJAS"
end event

type em_cantidad from u_em_campo within w_int_movalm
integer x = 4155
integer y = 392
integer width = 384
integer taborder = 200
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
situado= "CANTIDAD"
end event

event modificado;call super::modificado;
if cod_Sector = 'S' then   //David 29-10-05. NO quiero que haga ningún cálculo para los artículo que no sean del sector.

	If ante_valor<>Dec(em_cantidad.text) THEN
	 em_cajas.text=""
	 em_t_cajas.text=""
	 em_t_pallets.text=""
	END  IF
	
	 string cadena
	 long posi,posi_aux
	 
	// cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
	//                            uo_tipo_pallet.em_codigo.text,&
	//									 uo_caja.em_codigo.text,&
	//                            integer(em_t_pallets.text),&
	//                            integer(em_cajas.text),&
	//                            Dec(em_cantidad.text))
	 cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
										 uo_tipo_pallet.em_codigo.text,&
										 uo_caja.em_codigo.text,&
										 0,&
										 0,&
										 Dec(em_cantidad.text))
	
	posi_aux = 1
	posi = pos(cadena,"|",1)
	if posi <> 0 then
		em_t_pallets.text     = Mid(cadena,1,posi - 1)
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <> 0 then
		em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
		posi_aux = posi + 1
	end if
end if

if especial and Dec(em_cantidad.text) > ante_cant then
	f_mensaje("Modificación de líneas","Sólo se permiten modificaciones a la baja")
	f_activar_campo (em_cantidad)
	em_cantidad.text = String(ante_cant)
end if
end event

type sle_observaciones from u_em_campo within w_int_movalm
integer x = 539
integer y = 496
integer width = 3991
integer taborder = 210
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;situado= "OBSERVACIONES"
end event

type sle_proveedor from u_em_campo within w_int_movalm
boolean visible = false
integer x = 3447
integer y = 156
integer width = 357
integer taborder = 90
boolean bringtotop = true
end type

event modificado;call super::modificado;Integer x1 
st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
IF Trim(em_fecha.text)    = "" or IsNull(em_fecha.text) or &
   Trim(sle_numdoc.text)  = "" or IsNull(sle_numdoc.text) or&
   Trim(sle_tipomov.text) = "" or IsNull(sle_tipomov.text) THEN
   sle_proveedor.text     = ""
   Return
END IF

IF LEN(st_nombre_proveedor.text)=0 THEN 
   IF LEN(sle_tipomov.text)<>0 Then f_activar_campo(sle_proveedor)
   sle_proveedor.text="" 
   Return
END IF

IF Trim(sle_proveedor.text)=""  or  IsNull(sle_proveedor) THEN
	f_activar_campo(sle_proveedor)
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
   // controlo que los movimientos de compras ya introducidos a la factura
   // en curso pertenezcan al mismo codigo de proveedor
   String  v_proveedor
   Integer registros
   registros = dw_3.RowCount()
   IF registros >0 THEN
      v_proveedor = dw_3.GetItemString(1,"almmovhis_codtercero")
     
      IF trim(sle_proveedor.text)="" THEN
         sle_proveedor.text=v_proveedor
      END IF
      IF Trim(st_nombre_proveedor.text)="" THEN
         MessageBox("Mensaje","El proveedor no existe",Exclamation!,Ok!,1)
         sle_proveedor.text= v_proveedor
         st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
         sle_proveedor.Setfocus()
         Return
      END IF
      IF v_proveedor<>sle_proveedor.text or IsNull(v_proveedor) THEN
        integer opcion,bien
        opcion=MessageBox("Todas las lineas deben de ser al mismo proveedor","El proveedor no coincide con los demas movimientos ¿Validar?",Question!,YesNo!,2)
        
        CHOOSE CASE opcion
	     CASE 1 
              bien=0
              titulo        =  Parent.title
              longitud      =  len(trim(codigo_empresa))
              criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
              anyo          =  year(today())
              longitud      =  len(trim(string(anyo)))
              criterio[2]   =  trim(string(anyo))+space(20-longitud)
              v_almacen     =  dw_3.GetItemString(1,"almmovhis_almacen")
              longitud      =  len(trim(v_almacen))
              criterio[3]   =  trim(v_almacen)+space(20-longitud)
              seleccion     =  criterio[1]+criterio[2]+criterio[3]
              tabla         =  "almparam"
           IF NOT f_bloquear(tabla,seleccion,titulo) THEN 
              FOR x1=1 TO registros
               mov.empresa =codigo_empresa
               mov.almacen = v_almacen
               mov.anyo    = anyo
               mov.nummov  = dw_3.GetItemNumber(x1,"almmovhis_nummov")
               UPDATE almmovhis  
               SET codtercero= :sle_proveedor.text  
               WHERE (almmovhis.empresa = :mov.empresa ) AND  
                     (almmovhis.almacen = :mov.almacen ) AND  
                     (almmovhis.anyo    = :mov.anyo    ) AND  
                     (almmovhis.nummov  = :mov.nummov  ) USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN
                  bien=1
               END IF
             NEXT
             IF bien=0 THEN
                COMMIT USING SQLCA;
             ELSE
                ROLLBACK USING SQLCA;
                MessageBox("Error en base de datos","Error el procesar datos",Exclamation!,Ok!,2)
             END IF
             f_desbloquear(tabla,seleccion,titulo)
             ver_movimientos()
          ELSE
             sle_proveedor.text= v_proveedor
             st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
          END IF
        CASE 2 
             sle_proveedor.text= v_proveedor
             st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
        END CHOOSE

      END IF
   END IF
END IF
end event

event getfocus;call super::getfocus; ue_filtro = ""
 ue_titulo      = "Ayuda seleccion de proveedores" 
 ue_datawindow  = "dw_ayuda_proveedores"
 
 
end event

type cb_1 from u_boton within w_int_movalm
integer x = 4635
integer y = 316
integer width = 151
integer height = 128
integer taborder = 220
string text = "&OK"
end type

event clicked;//CONTROLES DE VALORES
boolean correcto
string mensaje
string v_tono, v_calibre
// piezas por conjunto
Dec{2} var_conjunto
Date ahora, fecha
Long respuesta

dw_1.reset()
correcto = True
IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

ahora = Date(Today())
fecha = Date(em_fecha.text)

if ahora <> fecha then
	respuesta = MessageBox("Atención Fecha","La fecha indicada ("+em_fecha.text+") no coincide con la actual ("+String(ahora)+"). Aun así, ¿desea continuar?",Question!, YesNo!,2)
	if respuesta = 2 then
	   em_fecha.SetFocus()
		return
	end if
end if

IF trim(sle_tipomov.text)=""  or IsNull(sle_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

st_nombre_tipomov.text=f_nombre_almtipomov(codigo_empresa,sle_tipomov.text)
IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
  st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
  IF trim(st_nombre_proveedor.text)="" or IsNull(st_nombre_proveedor.text) THEN
   mensaje="El proveedor no existe."
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_proveedor.Setfocus()
   RETURN
 END IF
END IF



IF trim(sle_numdoc.text)="" THEN
   mensaje="Introduzca el Numero de Dmto"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_numdoc.Setfocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

IF cod_sector = "S" THEN
	IF trim(uo_calidad.em_campo.text)="" THEN
		mensaje="Introduzca la calidad"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_calidad.em_campo.Setfocus()
		RETURN
	END IF
 
	// David 16-02-04 : Si el artículo lleva tono, obligará a ponerlo
	select tono, calibre 
	into :v_tono, :v_calibre
	from articulos
	where empresa = :codigo_empresa
	and codigo = :uo_articulo.em_codigo.text;

	IF v_tono = 'S' Then
		IF trim(em_tono.text)="" THEN
			mensaje="Introduzca el tono"
			MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
			em_tono.SetFocus()
			RETURN
		END IF
	ELSE
		IF trim(em_tono.text) <> "" THEN
			mensaje="El artículo no tiene gestión de tonos."
			MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
			em_tono.SetFocus()
			em_tono.text = ''
			RETURN
		END IF
	END IF

	IF v_calibre = 'S' Then
		IF trim(em_calibre.text) = "" or trim(em_calibre.text) = '0' THEN
			mensaje="Introduzca el calibre"
			MessageBox("Atención",mensaje,Exclamation!,OK!,1)
			em_calibre.SetFocus()
			RETURN
		END IF
	ELSE
		IF trim(em_calibre.text) <> "" and trim(em_calibre.text) <> "0" THEN
			mensaje="El artículo no tiene gestión de calibres."
			MessageBox("Atención",mensaje,Exclamation!,OK!,1)
			em_calibre.SetFocus()
			em_calibre.text = ''
			RETURN
		END IF
		
	END IF
	// Fin David 16-02-04 : Si el artículo lleva tono, obligará a ponerlo
	
	IF trim(uo_tipo_pallet.em_campo.text)="" THEN
		mensaje="Introduzca el tipo de pallet"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_tipo_pallet.Setfocus()
		RETURN
	END IF

	if dw_ex.rowcount() > 0 then 
		dw_ex.visible = false
		dw_ex.reset()
	end if

	string  codigo_articulo,codigo_pallet,codigo_formato,var_caja
	
	codigo_pallet=uo_tipo_pallet.em_codigo.text
	codigo_articulo=uo_articulo.em_codigo.text
	var_caja  = uo_caja.em_codigo.text
	
	SELECT 	articulos.empresa,articulos.codigo,   
				articulos.formato,conjunto  
	INTO 		:codigo_empresa,:codigo_articulo,   
				:codigo_formato,:var_conjunto  
	FROM 		articulos  
	WHERE 	(articulos.empresa = :codigo_empresa ) AND  
				(articulos.codigo  = :codigo_articulo )   
	ORDER BY articulos.empresa ASC,   
				articulos.codigo ASC,   
				articulos.formato ASC  USING SQLCA ;
	  
	
	SELECT 	palarticulo.codigo  
	INTO 		:codigo_pallet  
	FROM 		palarticulo  
	WHERE 	(palarticulo.empresa = :codigo_empresa ) AND  
				(palarticulo.articulo = :codigo_articulo ) AND  
				(palarticulo.codigo  = :codigo_pallet ) AND
				(palarticulo.caja  = :var_caja) USING SQLCA;

	IF SQLCA.SQLCode<>0 THEN
		mensaje="No Existe el Pallet al formato"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_tipo_pallet.em_campo.SetFocus()
		Return
	END  IF
END IF // fin control pertenece al sector

IF trim(em_cantidad.text)="" THEN
   mensaje="Introduzca nº total de cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

string codigo_real
String codigo_tipomov
codigo_tipomov=sle_tipomov.text

SELECT	almtipomov.codigo_real  
INTO 		:codigo_real  
FROM 		almtipomov  
WHERE 	(almtipomov.empresa = :codigo_empresa ) AND  
			(almtipomov.tipomov = :codigo_tipomov)  USING SQLCA  ;
			
IF codigo_real<>"E" THEN
   MessageBox("Tipo de Movimiento no valido","Solo se permiten movimiento de entradas ",Exclamation!, OK!,1)
   sle_tipomov.text=""
   sle_tipomov.Setfocus()
   Return	
END IF

IF cod_sector = "S" Then
	String codigo_calidad
	codigo_calidad= uo_calidad.em_codigo.text
	
	SELECT	almartcal.calidad  
	INTO 		:codigo_calidad  
	FROM 		almartcal  
	WHERE 	( almartcal.empresa   = :codigo_empresa ) AND  
				( almartcal.articulo  = :codigo_articulo ) AND  
				( almartcal.calidad  = :codigo_calidad ) USING SQLCA;
				
	IF SQLCA.SQLCode<>0 THEN
		MessageBox("Calidad no  valida","Esta calidad no esta definida para el articulo",Exclamation!, OK!,1)
		uo_calidad.em_campo.text        = ""
		uo_calidad.em_codigo.text = ""
		uo_calidad.em_campo.Setfocus()
		Return
	END IF
END IF

// Control piezas por conjunto
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
	IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
		MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
		f_activar_campo(em_cantidad)
		return
	END IF
END IF

if correcto then
	// desactivar claves
	em_cajas.enabled        = FALSE
	em_calibre.enabled      = FALSE
	em_fecha.enabled        = FALSE
	em_cantidad.enabled     = FALSE
	em_t_cajas.enabled      = FALSE
	em_t_pallets.enabled    = FALSE
	em_tono.enabled         = FALSE
	uo_articulo.em_campo.enabled    = FALSE
	uo_calidad.em_campo.enabled     = FALSE
	sle_numdoc.enabled      = FALSE
	uo_tipo_pallet.em_campo.enabled = FALSE
	uo_caja.em_campo.enabled = FALSE
	sle_tipomov.enabled     = FALSE
	sle_observaciones.enabled= FALSE
	sle_proveedor.enabled   = FALSE
	cb_1.enabled = FALSE
	
	dw_2.visible = FALSE
	dw_1.visible = TRUE
	dw_3.visible = FALSE
	dw_4.visible = TRUE
	cb_2.visible = TRUE
	cb_3.visible = TRUE
	cb_4.visible = TRUE
	cb_borrar.visible = TRUE
	pb_borrar.visible = FALSE
	pb_modificar.visible = FALSE
	
	dw_1.retrieve()
	contador=dw_1.Rowcount()
	string v_referencia
	v_referencia=f_componer_ref(uo_articulo.em_codigo.text,&
										 uo_calidad.em_codigo.text,Trim(em_tono.text),Integer(em_calibre.text))
	dw_4.retrieve(codigo_empresa,v_referencia)
	
	contador=contador+1
	
	if especial then
		// Modificación de entrada. Mostramos en esta dw las ubicaciones
		// en las que se hizo la entrada
		String sel
		datastore dd
		Dec{0} reg,registros
		
		sel = " SELECT * FROM almlinubicahis " +&
				" WHERE empresa = '" + codigo_empresa + "' " +&
				" AND   almacen = '" + ubihis.almacen + "'"+&
				" AND   anyo    = "  + String(ubihis.anyo,"####") +&
				" AND   nummov  = "  + String(ubihis.nummov,"######")

		f_cargar_cursor_nuevo(sel, dd)
			
		registros = dd.RowCount()
		for reg = 1 to registros
			dw_1.insertRow(reg)
			dw_1.setitem(reg,"cantidad",dd.GetitemNumber(reg,"cantidade"))
			dw_1.setitem(reg,"cant_anterior",dd.GetitemNumber(reg,"cantidade"))		
			dw_1.setitem(reg,"empresa",codigo_empresa)
			dw_1.setitem(reg,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,dd.GetItemString(reg,"articulo")))
			dw_1.setitem(reg,"orden",dd.GetItemNumber(reg,"orden"))
			dw_1.setitem(reg,"almacen",dd.GetItemString(reg,"almacen"))
			dw_1.setitem(reg,"zona",dd.GetItemString(reg,"zona"))
			dw_1.setitem(reg,"fila",dd.GetItemNumber(reg,"fila"))
			dw_1.setitem(reg,"altura",dd.GetItemNumber(reg,"altura"))		
			dw_1.SetTabOrder("almacen",0)
			dw_1.SetTabOrder("zona",0)
			dw_1.SetTabOrder("fila",0)
			dw_1.SetTabOrder("altura",0)		
			dw_1.SetTabOrder("cantidad",10)					
	
		next
		destroy dd		
	else
		// entrada normal
		dw_1.insertRow(contador)
		dw_1.setitem(contador,"cantidad",dec(em_cantidad.text))
		dw_1.setitem(contador,"empresa",codigo_empresa)
		dw_1.setitem(contador,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
	
		dw_1.SetTabOrder("almacen",10)
		dw_1.SetTabOrder("zona",20)
		dw_1.SetTabOrder("fila",30)
		dw_1.SetTabOrder("altura",40)		
		dw_1.SetTabOrder("cantidad",50)			
	
	end if
	dw_1.SetFocus()
	//***
end if

end event

type cb_4 from u_boton within w_int_movalm
boolean visible = false
integer x = 1271
integer y = 1288
integer width = 448
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;long    indice,total,donde
dec     cantidad,cantidad_articulo
boolean continuar
if cod_Sector = 'S' then  //David 26-10-05
	if articulo_compuesto then
		if dw_compuesto.rowcount() = 0 then
			dw_compuesto.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
			total = dw_compuesto.rowcount()
			for indice = 1 to total
				cantidad          = dw_compuesto.object.cantidad[indice]
				cantidad_articulo = dw_compuesto.object.cantidad_articulo[indice]
				dw_compuesto.object.cantidad_salida[indice] = cantidad * (dec(em_cantidad.text)/cantidad_articulo)
			next		
			//Si la caja tiene codigo de compras añadimos la linea de la caja		
			if f_codigo_compras_caja(codigo_empresa,uo_caja.em_codigo.text) <> "" then
				if dec(em_t_cajas.text) <> 0 then
					donde = dw_compuesto.insertrow(dw_compuesto.rowcount() +1)
					
					dw_compuesto.object.producto_terminado[donde] = "N"
					dw_compuesto.object.producto[donde]           = f_codigo_compras_caja(codigo_empresa,uo_caja.em_codigo.text)
					dw_compuesto.object.cantidad[donde]           = 1
					dw_compuesto.object.cantidad_articulo[donde]  = 1
					dw_compuesto.object.cantidad_salida[donde]    = dec(em_t_cajas.text)
					dw_compuesto.accepttext()
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

type cb_3 from u_boton within w_int_movalm
boolean visible = false
integer x = 850
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;em_cajas.enabled                = TRUE
em_calibre.enabled              = TRUE
em_fecha.enabled                = TRUE
em_cantidad.enabled             = TRUE
em_t_cajas.enabled              = TRUE
em_t_pallets.enabled            = TRUE
em_tono.enabled                 = TRUE
uo_articulo.em_campo.enabled    = TRUE
uo_calidad.em_campo.enabled     = TRUE
sle_numdoc.enabled              = TRUE
uo_tipo_pallet.em_campo.enabled = TRUE
uo_caja.em_campo.enabled        = TRUE
sle_tipomov.enabled             = TRUE
sle_observaciones.enabled       = TRUE
sle_proveedor.enabled           = TRUE
cb_1.enabled                    = TRUE
dw_4.visible                    = FALSE
dw_1.visible                    = FALSE
dw_3.visible                    = TRUE
cb_2.visible                    = FALSE
cb_3.visible                    = FALSE
cb_4.visible                    = FALSE
cb_borrar.visible               = FALSE
ver_movimientos()
em_cajas.text                   = ""
em_calibre.text                 = ""
em_cantidad.text                = ""
em_t_cajas.text                 = ""
em_t_pallets.text               = ""
em_tono.text                    = ""
uo_articulo.em_campo.text       = ""
uo_calidad.em_campo.text        = ""
uo_tipo_pallet.em_campo.text    = ""
uo_tipo_pallet.em_codigo.text   = ""
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
uo_articulo.em_campo.SetFocus()


end event

type cb_borrar from u_boton within w_int_movalm
boolean visible = false
integer x = 430
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
boolean bringtotop = true
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

type uo_articulo from u_em_campo_2 within w_int_movalm
integer x = 14
integer y = 392
integer width = 1650
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_cliente,var_formato, v_uso
long   lineas_compuesto
string encajados[]

uo_articulo.em_campo.text = Trim( f_nombre_articulo( codigo_empresa,uo_articulo.em_codigo.text ) )
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
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
SELECT articulos.familia,articulos.unidad,articulos.tono,articulos.calibre,articulos.sector,articulos.formato, uso
INTO :cod_familia,:var_tipo_unidad,:cod_tono,:cod_calibre,:cod_sector,:var_formato, :v_uso
FROM articulos  
WHERE articulos.empresa = :codigo_empresa
AND   articulos.codigo  = :codigo_articulo;

SELECT familias.empresa,familias.codigo
INTO :mov.empresa,:mov.familia
FROM familias  
WHERE familias.empresa = :codigo_empresa 
AND   familias.codigo  = :cod_familia ;

st_texto_cantidad.text=f_nombre_unidad(var_tipo_unidad)
st_formato.text = f_nombre_formato(codigo_empresa,var_formato)
em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))

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
	st_6.enabled           = TRUE
	st_7.enabled           = TRUE
	st_8.enabled           = TRUE
	uo_calidad.em_codigo.text     = ""
	uo_calidad.em_campo.text      = ""
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = "" 
	f_control_tono_calibre()
	// f_activar_campo(uo_calidad.em_campo)
ELSE
	em_cajas.enabled       = FALSE
	em_calibre.enabled     = FALSE
	em_t_cajas.enabled     = FALSE
	em_t_pallets.enabled   = FALSE
	em_tono.enabled        = FALSE
	uo_calidad.enabled     = FALSE
	uo_tipo_pallet.enabled = FALSE
	st_1.enabled           = FALSE
	st_2.enabled           = FALSE
	st_3.enabled           = FALSE
	st_4.enabled           = FALSE
	st_5.enabled           = FALSE
	st_6.enabled           = FALSE
	st_7.enabled           = FALSE
	st_8.enabled           = FALSE
	em_cajas.text          = ""
	em_calibre.text        = ""
	em_t_cajas.text        = "0"
	em_t_pallets.text      = "0"
	em_tono.text           = ""
	uo_calidad.em_codigo.text     = ""
	uo_calidad.em_campo.text      = ""
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = ""
END IF

If f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) = "C" Then
	var_cliente = sle_proveedor.text
Else
	var_cliente = ""
End If

IF len(Trim(uo_articulo.em_codigo.text))<> 0 Then
	if var_cliente <> "" then
		uo_tipo_pallet.em_codigo.text = f_pallet_palarticulo_cliente(codigo_empresa,uo_articulo.em_codigo.text,var_cliente)
		uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
	else
		uo_tipo_pallet.em_codigo.text = f_tipo_pallet_articulo(codigo_empresa,uo_articulo.em_codigo.text)
		uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)		
	end if
//	uo_caja.em_codigo.text        = f_caja_articulo_pallet(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text)
//	uo_caja.em_campo.text         = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)		
END IF

//IF len(Trim(uo_articulo.em_codigo.text))<> 0 Then
//uo_tipo_pallet.em_codigo.text = f_pallet_almartpallet_cliente(codigo_empresa,var_cliente,uo_articulo.em_codigo.text)
//uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
//END IF

// Control articulos compuestos

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
end if

// Fin control articulos compuestos

dw_2.visible = True
dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)

dw_5.reset()
if v_uso <> '1' then
	f_busca_encajados (uo_articulo.em_codigo.text,  encajados)
end if

if upperbound(encajados) = 0 then
	encajados[1] = uo_articulo.em_codigo.text
end if
dw_5.retrieve (codigo_empresa, encajados)




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type uo_calidad from u_em_campo_2 within w_int_movalm
integer x = 1669
integer y = 392
integer width = 251
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

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

event getfocus;call super::getfocus;valor_empresa=true
ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_almartcal"
ue_filtro     = "almartcal_articulo = '"+uo_articulo.em_codigo.text+"'"

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_calculadora from u_calculadora within w_int_movalm
boolean visible = false
integer x = 2834
integer y = 160
integer taborder = 0
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    =  codigo_empresa
alm_anyo       =  Year(Date(em_fecha.text))
alm_tipomov    =  sle_tipomov.text
alm_numdoc     =  Dec(sle_numdoc.text)

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
   ver_movimientos()
   sle_numdoc.SetFocus()
end event

type p_proveedor from up_carpeta within w_int_movalm
boolean visible = false
integer x = 3808
integer y = 160
integer width = 96
integer height = 76
end type

event clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos     = 3
lstr_param.s_argumentos[1]   = "w_int_movalm"
lstr_param.s_argumentos[2]   = "P"
lstr_param.s_argumentos[3]   = sle_proveedor.text

f_activar_campo(sle_proveedor)
OpenWithParm(wi_mant_clipro,lstr_param)  

end event

type uo_tipo_pallet from u_em_campo_2 within w_int_movalm
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 2825
integer y = 392
integer width = 517
integer taborder = 140
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

type pb_imprimir_preli from picturebutton within w_int_movalm
event clicked pbm_bnclicked
integer x = 622
integer y = 156
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
alignment htextalign = left!
end type

event clicked;Parent.TriggerEvent("ue_listar")
f_activar_campo(em_fecha)
end event

type dw_listado from datawindow within w_int_movalm
boolean visible = false
integer x = 672
integer width = 293
integer height = 72
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_int_movalm_m2"
boolean border = false
boolean livescroll = true
end type

type st_10 from statictext within w_int_movalm
integer x = 2354
integer y = 316
integer width = 462
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_movalm
event destroy ( )
integer x = 2354
integer y = 392
integer width = 462
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text = f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)=""  or IsNull(uo_caja.em_campo.text)THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then 
   uo_caja.em_campo.SetFocus()
 END IF
 uo_caja.em_campo.text  = ""
 uo_caja.em_codigo.text = ""
END IF
//Comprobamos si la caja tiene codigo de compras
//En ese caso marcamos el articulo como compuesto
if uo_caja.em_codigo.text <> "" then
	if f_codigo_compras_caja(codigo_empresa,uo_caja.em_codigo.text) <> "" then
		articulo_compuesto = true
	end if
end if

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas_sin_pallet"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"

end event

type cb_5 from commandbutton within w_int_movalm
integer x = 14
integer y = 316
integer width = 430
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type st_1 from statictext within w_int_movalm
integer x = 9
integer y = 316
integer width = 722
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
boolean enabled = false
string text = "Artículos"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type cb_2 from u_boton within w_int_movalm
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

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
total_pendiente = dec(em_cantidad.text)-total_cantidad

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

type st_nombre_tipomov from statictext within w_int_movalm
integer x = 1371
integer y = 160
integer width = 887
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_formato from statictext within w_int_movalm
integer x = 736
integer y = 316
integer width = 933
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_stock_prod_terminado from datawindow within w_int_movalm
boolean visible = false
integer x = 626
integer y = 160
integer width = 1353
integer height = 416
integer taborder = 150
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
long   lineas,calibre,posi,posi_aux
dec    cantidad_salida,precio

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	cantidad_salida = dw_compuesto.object.cantidad_salida[dw_compuesto.getrow()]
	tipo_pallet     = this.object.tipo_pallet[row]
	caja            = this.object.caja[row]
	producto        = dw_compuesto.object.producto[dw_compuesto.getrow()]
	
	cadena   = f_calculo_unidades(codigo_empresa,producto,tipo_pallet,caja,0,0,cantidad_salida)
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
		cantidad_salida     = dec(Mid(cadena,posi_aux,posi - posi_aux))
		posi_aux = posi + 1
	end if
				 
	
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

type dw_stock_mat_prima from datawindow within w_int_movalm
boolean visible = false
integer x = 343
integer y = 288
integer width = 1353
integer height = 416
integer taborder = 160
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

type dw_2 from datawindow within w_int_movalm
boolean visible = false
integer x = 2405
integer y = 816
integer width = 2414
integer height = 552
string dataobject = "dw_info_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_compuesto from datawindow within w_int_movalm
boolean visible = false
integer y = 528
integer width = 2862
integer height = 756
integer taborder = 110
boolean titlebar = true
string title = "Composición del articulo"
string dataobject = "dw_almcompuestoart_entradas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;string producto,tonochar,calidad,tipo_pallet,caja,ubicacion,cadena
long   lineas,calibre,posi,posi_aux
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
					cantidad_salida      = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
		
				
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

type dw_almlinubicahis from datawindow within w_int_movalm
boolean visible = false
integer y = 720
integer width = 1431
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
//  pb_borrar.visible=TRUE
//  pb_modificar.visible=TRUE
END IF
end event

type dw_5 from datawindow within w_int_movalm
integer x = 9
integer y = 1464
integer width = 5239
integer height = 612
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ver_pedidos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_14 from statictext within w_int_movalm
integer x = 5
integer y = 1384
integer width = 5243
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217747
string text = "Pedidos Pendientes"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_int_movalm
event key pbm_dwnkey
integer x = 32
integer y = 620
integer width = 1833
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

		// David 26-10-05. Surtitui la linea comentada por el if, para controlar que no haga cálculos en el caso de que
		// el artículo no sea del sector.
//		dw_1.SetItem(dw_1.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,var_cantidad))
		if cod_sector = 'S' Then
			dw_1.SetItem(dw_1.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text,var_cantidad))
		end if
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

event rbuttondown;str_parametros param
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

type dw_4 from datawindow within w_int_movalm
boolean visible = false
integer x = 1870
integer y = 672
integer width = 1125
integer height = 568
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

type dw_3 from datawindow within w_int_movalm
integer x = 9
integer y = 604
integer width = 5243
integer height = 764
string dataobject = "dw_int_almlinubi2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
string icon = "\bmp\RINO.ICO"
end type

event retrieveend;pb_borrar.visible = False
pb_modificar.visible = False
end event

event clicked;IF row<>0 THEN
 //***
 //f_mensaje("art",GetItemString(row,"almmovhis_articulo"))
 //***
 integer registros
 registros = dw_3.RowCount()
 IF registros>0 THEN
	This.SelectRow(0,FALSE)
	This.SelectRow(row,TRUE)
	
	ubihis.anyo    =  GetItemNumber(row,"almmovhis_anyo")
	ubihis.almacen =  GetItemString(row,"almmovhis_almacen")
	ubihis.nummov  =  GetItemNumber(row,"almmovhis_nummov")
	//f_mensaje ("anyo " + String(ubihis.anyo),"alm "+ubihis.almacen+" nummov "+String(ubihis.nummov))
	dw_almlinubicahis.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
 END IF
 if especial then

	if row = 0 Then Return
	
	uo_articulo.em_codigo.text = dw_3.GetItemString(row,"almmovhis_articulo")
	uo_articulo.em_campo.text  = f_nombre_articulo (codigo_empresa,uo_articulo.em_codigo.text)
	uo_calidad.em_codigo.text  = dw_3.GetItemString(row,"almmovhis_calidad")
	uo_calidad.em_campo.text   = f_nombre_calidad_abr (codigo_empresa,uo_calidad.em_codigo.text)
	em_tono.text 					= dw_3.GetItemString(row,"almmovhis_tonochar")
	em_calibre.text 				= String(dw_3.GetItemNumber(row,"almmovhis_calibre"))
	uo_caja.em_codigo.text  	= dw_3.GetItemString(row,"almmovhis_caja")
	uo_caja.em_campo.text      = f_nombre_caja_abr (codigo_empresa,uo_caja.em_codigo.text)
	uo_tipo_pallet.em_codigo.text= dw_3.GetItemString(row,"almmovhis_tipo_pallet")
	uo_tipo_pallet.em_campo.text = f_nombre_pallet_abr (codigo_empresa,uo_tipo_pallet.em_codigo.text)
	ante_cant						= dw_3.GetItemNumber(row,"almmovhis_cantidade")
	em_cantidad.text  			= String(ante_cant)
	em_cantidad.TriggerEvent("modificado")

 end if
END IF
end event

on doubleclicked; dw_almlinubicahis.visible=TRUE
end on

type dw_ex from datawindow within w_int_movalm
boolean visible = false
integer x = 754
integer y = 76
integer width = 2066
integer height = 288
integer taborder = 190
string dataobject = "dw_int_almlinubi5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;IF  rowcount <> 0 Then 
	visible = TRUE
ELSE
	visible = FALSE
END IF
end event

event doubleclicked;visible = FALSE
end event

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

type pb_modificar from upb_papelera within w_int_movalm
boolean visible = false
integer x = 2944
integer y = 544
integer width = 110
integer height = 96
integer taborder = 230
boolean enabled = false
boolean originalsize = false
string picturename = "c:\bmp\minus.bmp"
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

type pb_borrar from upb_papelera within w_int_movalm
boolean visible = false
integer x = 3063
integer y = 544
integer width = 123
integer height = 96
integer taborder = 130
boolean enabled = false
boolean originalsize = false
end type

event clicked;if dw_3.GetRow()=0 Then Return

dec        registros,x2,bien
string     cod_ubicacion,referencia
decimal{2} total_cantidad,mod_cantidad
dec{0}     mov_nummov,mov_anyo,movimientos_compras
String     mov_situacion,mov_almacen,mov_empresa
boolean    continuar 
dec        opcion

opcion = MessageBox("Proceso de borrado de datos","¿Borrar la entrada seleccionada?",question!, YesNo!,2)

IF opcion=2 THEN  Return

bien=0

registros = dw_almlinubicahis.RowCount()

IF registros  = 0 THEN  Return

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
				f_mensaje("Error","No hay stock para anular movimiento")
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
		messagebox("","f_anular")
		IF NOT f_anular_nummov(mov_empresa,mov_almacen,mov_anyo,mov_nummov) THEN
			f_mensaje("Error","Al anular el movimiento")
			bien=1
		END IF
		IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
			bien=1
			f_mensaje("Error","Al actualizar el movimiento")
		END IF
		//Deshacemos los movimientos de articulo compuesto si los hay
		if movimientos_compras > 0 then
			if not(f_anular_salida_mp(mov_almacen,mov_anyo,mov_nummov)) then bien = 1
		end if		
		if not(f_anular_salida_producto_terminado(mov_almacen,mov_anyo,mov_nummov)) then bien = 1		
		//Fin de deshacemos los movimientos de articulo compuesto si los hay
		if f_control_reservas_borrado() then
			bien = 0
		else
			bien = 1
		end if
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
	ver_movimientos()
END IF
uo_articulo.em_campo.SetFocus()
destroy dw_proceso
end event

type st_tecla2 from statictext within w_int_movalm
boolean visible = false
integer x = 2949
integer y = 96
integer width = 96
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F4"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_int_movalm
boolean visible = false
integer x = 2939
integer y = 160
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert!"
end type

event clicked;String alm_empresa,alm_tipomov
Dec alm_anyo,alm_numdoc

alm_empresa    =  codigo_empresa
alm_anyo       =  Year(Date(em_fecha.text))
alm_tipomov    =  sle_tipomov.text
alm_numdoc     =  Dec(sle_numdoc.text)

SELECT max(convert(dec,almmovhis.numdoc))
INTO   :alm_numdoc  
FROM   almmovhis  
WHERE  almmovhis.empresa  = :alm_empresa 
AND    almmovhis.anyo     = :alm_anyo 
AND    almmovhis.tipomov  = :alm_tipomov
AND    almmovhis.numdoc   between "0" and "999999999999999";
IF SQLCA.SQLCode<>0 THEN   alm_numdoc=0
IF IsNUll(alm_numdoc) Then alm_numdoc = 0

alm_numdoc      = alm_numdoc
if alm_numdoc = 0 then
	MessageBox("Info","No hay ningún número de documento generado para el año y el tipo de movimiento seleccionado. Por favor, pulse F5 para generar un nuevo número de documento.")
	return
end if
sle_numdoc.text = string(alm_numdoc,"#######")
ver_movimientos()
sle_numdoc.SetFocus()
end event

type st_tecla from statictext within w_int_movalm
boolean visible = false
integer x = 2839
integer y = 96
integer width = 101
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F5"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_15 from statictext within w_int_movalm
integer x = 14
integer y = 884
integer width = 5221
integer height = 1164
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

