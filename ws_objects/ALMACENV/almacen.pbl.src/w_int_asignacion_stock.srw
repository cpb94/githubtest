$PBExportHeader$w_int_asignacion_stock.srw
forward
global type w_int_asignacion_stock from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_asignacion_stock
end type
type st_1 from statictext within w_int_asignacion_stock
end type
type cb_continuar from u_boton within w_int_asignacion_stock
end type
type cb_1 from u_boton within w_int_asignacion_stock
end type
type st_2 from statictext within w_int_asignacion_stock
end type
type em_cantidad from u_em_campo within w_int_asignacion_stock
end type
type st_3 from statictext within w_int_asignacion_stock
end type
type st_4 from statictext within w_int_asignacion_stock
end type
type st_5 from statictext within w_int_asignacion_stock
end type
type em_total_cajas from u_em_campo within w_int_asignacion_stock
end type
type em_cajas from u_em_campo within w_int_asignacion_stock
end type
type em_pallets from u_em_campo within w_int_asignacion_stock
end type
type cb_bases_decorados from u_boton within w_int_asignacion_stock
end type
type gb_1 from groupbox within w_int_asignacion_stock
end type
type cb_2 from u_boton within w_int_asignacion_stock
end type
type st_listado from statictext within w_int_asignacion_stock
end type
type dw_listado from datawindow within w_int_asignacion_stock
end type
type gb_2 from groupbox within w_int_asignacion_stock
end type
type pb_listado from upb_imprimir within w_int_asignacion_stock
end type
type todas from radiobutton within w_int_asignacion_stock
end type
type fabricar from radiobutton within w_int_asignacion_stock
end type
type uo_articulo from u_em_campo_2 within w_int_asignacion_stock
end type
type dw_ubicaciones from datawindow within w_int_asignacion_stock
end type
type dw_pedidos from u_datawindow_consultas within w_int_asignacion_stock
end type
type dw_articulos from u_datawindow_consultas within w_int_asignacion_stock
end type
type cb_ventas from u_boton within w_int_asignacion_stock
end type
type st_formato from statictext within w_int_asignacion_stock
end type
type st_6 from statictext within w_int_asignacion_stock
end type
end forward

global type w_int_asignacion_stock from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3314
integer height = 1640
string title = "Consulta de Movimientos"
pb_2 pb_2
st_1 st_1
cb_continuar cb_continuar
cb_1 cb_1
st_2 st_2
em_cantidad em_cantidad
st_3 st_3
st_4 st_4
st_5 st_5
em_total_cajas em_total_cajas
em_cajas em_cajas
em_pallets em_pallets
cb_bases_decorados cb_bases_decorados
gb_1 gb_1
cb_2 cb_2
st_listado st_listado
dw_listado dw_listado
gb_2 gb_2
pb_listado pb_listado
todas todas
fabricar fabricar
uo_articulo uo_articulo
dw_ubicaciones dw_ubicaciones
dw_pedidos dw_pedidos
dw_articulos dw_articulos
cb_ventas cb_ventas
st_formato st_formato
st_6 st_6
end type
global w_int_asignacion_stock w_int_asignacion_stock

type variables
String ante_articulo,retrasos
datawindow dw_data
String donde,modo
end variables

forward prototypes
public subroutine f_pedidos (integer linea)
public function string f_ubicacion (string ubicacion)
public function string f_ubicaciones_referencia (string empresa, string referencia, string tipo_pallet)
public function boolean f_borrar_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea)
public subroutine f_control_ordenes (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea)
public subroutine f_asignar ()
public subroutine f_quitar ()
public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet)
end prototypes

public subroutine f_pedidos (integer linea);String v_articulo,v_calidad,v_tono
long   v_calibre

v_articulo = dw_articulos.GetItemSTring(linea,"articulo")
v_calidad  = dw_articulos.GetItemSTring(linea,"calidad")
v_tono     = dw_articulos.GetItemSTring(linea,"tono")
v_calibre  = dw_articulos.GetItemNumber(linea,"calibre")

if isnull(v_calidad) or trim(v_calidad) = "0" then v_calidad = ""

String sel
dw_pedidos.Setfilter("")
IF fabricar.checked Then 
	dw_pedidos.Setfilter("situacion = 'F'")
END IF
dw_pedidos.filter()
IF dw_pedidos.Retrieve(codigo_empresa,v_articulo,v_calidad,v_tono,v_calibre) <> 0 Then
	em_cantidad.text = String(dw_pedidos.GetItemNumber(1,"cantidad"))
	dw_pedidos.SetRow(1)
	dw_pedidos.SelectRow(1,TRUE)
ELSE
	em_cantidad.text = ""
END IF

if dw_articulos.rowcount()=0 or dw_articulos.getrow()=0 then return

//String v_tipo_pallet,v_caja
//String cadena
//
//v_tipo_pallet = dw_pedidos.GetItemString(1,"tipo_pallet")
//v_caja        = dw_pedidos.GetItemString(1,"venliped_caja")
//v_articulo    = dw_pedidos.GetItemString(1,"articulo")
//
//
//if isnull(v_articulo) or v_articulo='' then return
//
//cadena = f_calculo_unidades(codigo_empresa,v_articulo,&
//                            v_tipo_pallet,&
//									 v_caja,&
//                            0,&
//                            0,&
//                            Dec(em_cantidad.text))
//
//
//em_pallets.text     = Mid(cadena,1,6)
//em_cajas.text       = Mid(cadena,7,6)
//em_total_cajas.text = Mid(cadena,13,6)
//em_cantidad.text    = Mid(cadena,19,9)
end subroutine

public function string f_ubicacion (string ubicacion);String montaje,almacen,zona,fila,altura
almacen= Mid(ubicacion,1,5)
almacen = f_almacen_ubicacion(ubicacion)
zona    = f_zona_ubicacion(ubicacion)
fila   = String(f_fila_ubicacion(ubicacion))
altura = String(f_altura_ubicacion(ubicacion))

IF IsNull(fila) Then fila = "0"
IF IsNull(altura) or Trim(altura) = "" Then altura = "0"


IF Trim(altura) = "0"  Then
  altura = ""
Else
  altura = "/" + altura
End If
montaje = trim(almacen) + trim(zona) + Trim(fila) +  Trim(altura)

Return montaje
end function

public function string f_ubicaciones_referencia (string empresa, string referencia, string tipo_pallet);String montaje
montaje = f_ubicaciones_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet,2,"N")
Return montaje
end function

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
Dec{0} va_tono,va_calibre,va_pallets,va_total_cajas,va_cajas
String va_referencia,va_situacion,va_tipo_pallet,va_ubicacion

SetNull(va_ubicacion)
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
  SELECT venliped.tono,          venliped.calibre,   
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
	
	  UPDATE almlincargas  
     SET tono = :va_tono,   
         calibre = :va_calibre,   
         referencia       = :va_referencia,   
         tipo_pallet      = :va_tipo_pallet,   
         cajas            = :va_cajas,   
         total_cajas      = :va_total_cajas,   
         cantidad         = :va_cantidad,   
         cantidad_ped     = :va_cantidad,   
         ubicacion        = :va_ubicacion,   
         pallets          = :va_pallets,   
         situacion_pedido = :va_situacion 
Where  almlincargas.empresa    = :arg_empresa
And    almlincargas.anyo_ped   = :arg_anyo
And    almlincargas.pedido     = :arg_pedido
And    almlincargas.linea_ped  = :arg_linea;




Return 


end subroutine

public subroutine f_asignar ();String  anular_resto,texto,v_pallet,v_caja
str_almlincargas  la
Dec numero,vbien = 0,var_orden_preparacion
String cadena,control_ordenes
control_ordenes = "S"
anular_resto = "N"
Dec{4}  var_cantidad_preparar,var_cantidad_pedido,var_cantidad_stock,var_cantidad_pendiente,cantidad_anterior,vcan
Dec{0}  linea,v_pedido,v_anyo,v_linea,var_calibre,ultima,vanyo,vorden
string  var_referencia,var_articulo,var_calidad,var_tipo_pallet,var_caja,v_situacion,var_tono
Str_venliped ped
Long posi,posi_aux

linea          = dw_pedidos.GetRow()
IF linea       = 0 Then Return

v_situacion    = dw_pedidos.getItemString(linea,"situacion")
If v_situacion <> "F" Then Return
If v_situacion =  "P" Then Return

var_articulo   = dw_articulos.getItemString(dw_articulos.GetRow(),"articulo")
var_calidad    = dw_articulos.getItemString(dw_articulos.GetRow(),"calidad")
var_tono       = dw_articulos.getItemString(dw_articulos.GetRow(),"tono")
var_calibre    = dw_articulos.getItemnumber(dw_articulos.GetRow(),"calibre")
var_referencia = f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre)

IF f_sector_articulo(codigo_empresa,var_articulo) = "S" Then
	IF f_unidad_articulo(codigo_empresa,var_articulo) = "1" Then
		var_orden_preparacion = 1
	ELSE
		var_orden_preparacion = 2
	END IF
ELSE
	var_orden_preparacion = 4
END IF

v_pedido        = dw_pedidos.getItemnumber(linea,"pedido")
v_anyo          = dw_pedidos.getItemnumber(linea,"anyo")
v_linea         = dw_pedidos.getItemnumber(linea,"linea")
v_pallet        = dw_pedidos.getItemString(linea,"tipo_pallet")
v_caja          = dw_pedidos.getItemString(linea,"venliped_caja")
var_tipo_pallet = dw_pedidos.getItemString(linea,"tipo_pallet")
var_caja        = dw_pedidos.getItemString(linea,"venliped_caja")

// Control ordenes de carga
				
Select venliped.cantidad Into :cantidad_anterior From venliped
WHERE  venliped.empresa  =  :codigo_empresa 
AND    venliped.anyo     =  :v_anyo 
AND    venliped.pedido   =  :v_pedido 
AND    venliped.linea    =  :v_linea;
IF SQLCA.SQLCODE = 100 Then f_mensaje("Error en datos"," No existe linea de pedido")

texto = ""		

Select count(*) Into :numero From almlincargas
Where  almlincargas.empresa    = :codigo_empresa
And    almlincargas.anyo_ped   = :v_anyo
And    almlincargas.pedido     = :v_pedido
And    almlincargas.linea_ped  = :v_linea;
IF IsNull(numero) Then numero = 0

CHOOSE CASE numero
	CASE 1
      Select cantidad,anyo,orden Into :vcan,:vanyo,:vorden From almlincargas
		Where  almlincargas.empresa    = :codigo_empresa
		And    almlincargas.anyo_ped   = :v_anyo
		And    almlincargas.pedido     = :v_pedido
		And    almlincargas.linea_ped  = :v_linea;
		la.anyo = vanyo
		la.orden = vorden
		IF vcan = cantidad_anterior Then
			IF f_orden_impresa_sn(codigo_empresa,vanyo,vorden)  Then
					texto = "Orden : " +STring(vorden,"######") + " Listada (será modificada)"
			End IF
		ELSE
			texto = "Orden : " +STring(vorden,"######")+ "(Será eliminada)"
		END IF
	CASE 0
		   control_ordenes = "N" 
   CASE ELSE
		   texto = "Existen varias ordenes a esta linea de pedido (Serán eliminadas)"		
		   control_ordenes = "N" 
END CHOOSE

IF TRIM(texto) <> "" Then
    IF MessageBox("Control Ordenes",texto+"  ¿Continuar?",Question!,YesNo!)= 2 Then Return
END IF

la.empresa = codigo_empresa

IF control_ordenes = "S" Then
			
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

//------------------------------------------------------------------

var_cantidad_preparar  = Dec(em_cantidad.text)
var_cantidad_pedido    = dw_pedidos.getItemnumber(linea,"cantidad")
var_cantidad_stock     = f_disponible_articulo_calidad_tono_cali(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre)

IF var_cantidad_pedido < var_cantidad_preparar Then
	f_mensaje("Error en introduccion de datos","La cantidad no puede ser mayor al pedido ")
	Return
END IF

IF Not f_bloquear_almacen(w_int_asignacion_stock.title) Then
		IF var_cantidad_pedido = var_cantidad_preparar Then
			IF var_cantidad_preparar <= var_cantidad_stock Then
					cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
											 var_tipo_pallet,&
											 var_caja,&
											 0,&
											 0,&
											 var_cantidad_preparar)
				
				posi_aux = 1
				posi = pos(cadena,"|",1)
				if posi <> 0 then
					ped.pallets     = dec(Mid(cadena,1,posi - 1))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <> 0 then
					ped.cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <>0 then
					ped.total_cajas   = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <>0 then
					ped.cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
			
			 // Comprueba si se ha cambiado de pallet y tiene el mismo
			 // número de cajas por pallet
			 if var_tipo_pallet <> v_pallet then
			    if ped.pallets>=1 and ped.cajas<>0 then
	 	 	       IF MessageBox("Control cantidad","Hay un pico debido al cambio de pallet, ¿Desea borrarlo?",Question!,YesNo!)= 1 Then
							ped.total_cajas = ped.total_cajas - ped.cajas
							ped.cajas       = 0
							ped.cantidad    = f_calculo_unidades_cajas(codigo_empresa,var_articulo,var_caja,ped.total_cajas)
					      IF IsNull(var_articulo) Then var_articulo = ""
							IF Trim(var_articulo) = "" Then
								ped.peso      = 0
								ped.peso_neto = 0
							ELSE
								ped.peso      = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,ped.cajas,ped.total_cajas,ped.pallets,ped.cantidad,var_caja)
								ped.peso_neto = f_calculo_peso_neto(codigo_empresa,var_articulo,ped.cajas,ped.total_cajas,ped.cantidad,var_caja)
							END IF
			        else
							 // Linea nueva con el resto
							 dec cantidad_ant,tot_cajas_ant,pallets_ant,cajas_ant
							 
							 cantidad_ant  = ped.cantidad
							 tot_cajas_ant = ped.total_cajas 
							 pallets_ant   = ped.pallets
							 cajas_ant     = ped.cajas
							 
							 ped.cantidad    = f_calculo_unidades_cajas(codigo_empresa,var_articulo,var_caja,ped.cajas)
							 
							 select venliped.cliente,venliped.tipo_unidad,venliped.articulo,venliped.familia,venliped.formato,
							        venliped.modelo,venliped.calidad,venliped.descripcion,venliped.tipoiva,venliped.pais,venliped.tipolinea,
									  venliped.referencia,venliped.montajeartcal,venliped.usuario,venliped.serie,
									  venliped.precio,venliped.clase,venliped.sector,venliped.agente1,
									  venliped.agente2,venliped.agente3,venliped.comision11,venliped.comision12,
									  venliped.comision21,venliped.comision22,venliped.comision31,
									  venliped.comision32,venliped.deposito,venliped.control_incremento
									  
							   into :ped.cliente,:ped.tipo_unidad,:ped.articulo,:ped.familia,:ped.formato,
 								     :ped.modelo,:ped.calidad,:ped.descripcion,:ped.tipoiva,:ped.pais,:ped.tipolinea,
									  :ped.referencia,:ped.montajeartcal,:ped.usuario,:ped.serie,
									  :ped.precio,:ped.clase,:ped.sector,:ped.agente1,:ped.agente2,
									  :ped.agente3,:ped.comision11,:ped.comision12,:ped.comision21,
									  :ped.comision22,:ped.comision31,:ped.comision32,:ped.deposito,
									  :ped.control_incremento
						     from  venliped
				          Where  venliped.empresa   =   :codigo_empresa
							 And    venliped.anyo      =   :v_anyo
							 And    venliped.pedido    =   :v_pedido
							 And    venliped.linea     =   :v_linea;
							 if Sqlca.Sqlcode = 100 Then f_mensaje("Error en datos"," No existe linea de pedido")
									  
							 Select max(venliped.linea) Into :ultima From venliped
				          Where  venliped.empresa   =   :codigo_empresa
							 And    venliped.anyo      =   :v_anyo
							 And    venliped.pedido    =   :v_pedido;
							 IF ISNull(ultima) Then ultima=0
							 ultima = ultima +1
							 ped.caja                    = var_caja
							 ped.tipo_pallet             = var_tipo_pallet
							 ped.tipo_pallet_preparacion = var_tipo_pallet
							 ped.empresa     = codigo_empresa
							 ped.pedido      = v_pedido
							 ped.anyo        = v_anyo
							 ped.situacion   = "C"                      
							 ped.linea       = ultima
							 ped.pallets     = 0
							 ped.total_cajas = ped.cajas
	 						 ped.tonochar    = var_tono
						    ped.calibre     = var_calibre
							 ped.es_pico     = "N"
							 SetNUll(ped.numero_pico)
							 ped.referencia  = f_componer_ref(ped.articulo,ped.calidad,ped.tonochar,ped.calibre)
							 
							 IF Not  f_insertar_venliped(ped) Then
								f_mensaje("Error","Error al grabar el pedido")
							 END IF
							 
							 ped.total_cajas = tot_cajas_ant
							 ped.cajas       = cajas_ant
							 ped.cantidad    = cantidad_ant
							 ped.pallets     = pallets_ant
							 
							 ped.total_cajas = ped.total_cajas - ped.cajas
							 ped.cantidad    = f_calculo_unidades_cajas(codigo_empresa,var_articulo,var_caja,ped.total_cajas)
							 ped.cajas = 0
							 IF IsNull(var_articulo) Then var_articulo = ""
							 IF Trim(var_articulo) = "" Then
									ped.peso      = 0
									ped.peso_neto = 0
							  ELSE
									ped.peso      = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,ped.cajas,ped.total_cajas,ped.pallets,ped.cantidad,var_caja)
									ped.peso_neto = f_calculo_peso_neto(codigo_empresa,var_articulo,ped.cajas,ped.total_cajas,ped.cantidad,var_caja)
							 END IF
					  End if
			    End if
		    End if
				
			   IF IsNull(var_articulo) Then var_articulo = ""
				IF Trim(var_articulo) = "" Then
					ped.peso      = 0
					ped.peso_neto = 0
				ELSE
					ped.peso      = f_calculo_peso(codigo_empresa,var_articulo,var_tipo_pallet,ped.cajas,ped.total_cajas,ped.pallets,ped.cantidad,var_caja)
					ped.peso_neto = f_calculo_peso_neto(codigo_empresa,var_articulo,ped.cajas,ped.total_cajas,ped.cantidad,var_caja)
				END IF

				Update venliped
				Set    venliped.situacion         = "C",
				       venliped.orden_preparacion = :var_orden_preparacion,
						 venliped.tonochar          = :var_tono,
						 venliped.calibre           = :var_calibre,
						 venliped.referencia        = :var_referencia,
						 venliped.tipo_pallet       = :var_tipo_pallet,
						 venliped.caja              = :var_caja,
						 venliped.pallets           = :ped.pallets,
						 venliped.cajas             = :ped.cajas,
						 venliped.total_cajas       = :ped.total_cajas,
						 venliped.cantidad          = :ped.cantidad,
						 venliped.peso              = :ped.peso,
						 venliped.peso_neto         = :ped.peso_neto
				Where  venliped.empresa      = :codigo_empresa
				And    venliped.anyo         = :v_anyo
				And    venliped.pedido       = :v_pedido
				And    venliped.linea        = :v_linea;
				
				f_control_ordenes(codigo_empresa,v_anyo,v_pedido,v_linea)
				
			ELSE
				f_mensaje("No hay suficiente Stock ","No se puede asignar stock a este pedido")
				Return
			END IF
		ELSE
			IF messageBox("Linea asignada parcialmante","¿Quiere dejar el resto pendiente?",Question!,YesNo!) = 2 Then
				anular_resto = "S"
			END IF
			//-----------------------------------------------------------------//
			// ---------------------------Asignar Stock parcial----------------//
			//-----------------------------------------------------------------//
			ped = f_seleccion_venliped(codigo_empresa,v_anyo,v_pedido,v_linea)
			IF ped.pedido <> v_pedido or IsNull(ped.pedido) Then
				f_mensaje("Error","Error al leer el pedido")
			END IF
			
			cadena=f_calculo_unidades(codigo_empresa,var_articulo,&
											 var_tipo_pallet,&
											 var_caja,&
											 0,&
											 0,&
											 var_cantidad_preparar)
									  
			posi_aux = 1
			posi = pos(cadena,"|",1)
			if posi <> 0 then
				ped.pallets     = dec(Mid(cadena,1,posi - 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <> 0 then
				ped.cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				ped.total_cajas   = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				ped.cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
				posi_aux = posi + 1
			end if
			 
			 
			 
			 var_cantidad_pendiente = var_cantidad_pedido - ped.cantidad
				
				DELETE venliped
				Where  venliped.empresa   =  :codigo_empresa
				And    venliped.anyo      =  :v_anyo
				And    venliped.pedido    =  :v_pedido
				And    venliped.linea     =  :v_linea;
				
		 ped.situacion  = "C"                      
		 IF ped.cantidad > var_cantidad_stock Then ped.situacion = "F"                      
		
		 ped.tonochar   = var_tono
		 ped.calibre    = var_calibre
		 ped.referencia = var_referencia
		 ped.linea      = v_linea
		
		 IF Not f_insertar_venliped(ped) Then
			f_mensaje("Error","Error al grabar el pedido")
		 END IF
		 f_actualizar_linea_venpedido(ped.empresa,ped.anyo,ped.pedido,ped.linea)
		
		 IF control_ordenes = "S" Then
				Delete From almlincargas
				Where  almlincargas.empresa    = :codigo_empresa
				And    almlincargas.anyo_ped   = :v_anyo
				And    almlincargas.pedido     = :v_pedido
				And    almlincargas.linea_ped  = :v_linea;
				IF sqlca.sqlcode <> 0 Then vbien = 1
				
				Select max(almlincargas.linea) Into :la.linea
				From   almlincargas
				Where  almlincargas.empresa = :la.empresa
				And    almlincargas.anyo    = :la.anyo
				And    almlincargas.orden   = :la.orden;
				IF ISNULL(la.linea ) Then la.linea  = 0
				la.linea        = la.linea  +1
				la.anyo_ped     = ped.anyo
				la.pedido       = ped.pedido
				la.linea_ped    = ped.linea
				la.fecha_ped    = ped.fpedido
				la.articulo     = ped.articulo
				la.calidad      = ped.calidad
				la.tonochar     = ped.tonochar
				la.calibre      = ped.calibre
				la.tipo_pallet  = ped.tipo_pallet
				la.caja         = ped.caja
				la.cajas        = ped.cajas
				la.total_cajas  = ped.total_cajas
				la.cantidad     = ped.cantidad 
				la.cantidad_ped = ped.cantidad
				la.tipo_unidad  = ped.tipo_unidad
				SetNUll(la.ubicacion)
				la.usuario      = nombre_usuario
				la.imp_bandas   = "N"
				la.deposito     = ped.deposito
				la.situacion_pedido = ped.situacion
				la.almacen_deposito = ped.almacen_deposito
				
				If Not f_insert_almlincargas(la) Then f_mensaje("Error",sqlca.sqlerrtext)
				
		 END IF
				
		 IF anular_resto= "N" Then
				 //-------------------------------------------------//
				 // Grabar el resto de la linea como una nueva linea//
				 //-------------------------------------------------//
				 
				 Select max(venliped.linea) Into :ultima From venliped
				 Where  venliped.empresa   =   :ped.empresa
				 And    venliped.anyo      =   :ped.anyo
				 And    venliped.pedido    =   :ped.pedido;
				 IF ISNull(ultima) Then ultima=0
				 ultima = ultima +1
				 ped.linea = ultima
				 ped.cantidad = var_cantidad_pendiente
		
				 // nuevo, para controlar el fabricar
				 ped.situacion     = "F"                      
						
				 cadena = f_calculo_unidades(codigo_empresa,var_articulo,&
													 var_tipo_pallet,&
													 var_caja,&
													 0,&
													 0,&
													 ped.cantidad)
			   posi_aux = 1
				posi = pos(cadena,"|",1)
				if posi <> 0 then
					ped.pallets     = dec(Mid(cadena,1,posi - 1))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <> 0 then
					ped.cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <>0 then
					ped.total_cajas   = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
				
				posi = pos(cadena,"|",posi_aux)
				if posi <>0 then
					ped.cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
					posi_aux = posi + 1
				end if
				
			  ped.tonochar      = ""
			  ped.calibre       = 0
			  ped.es_pico       = "N"
			  SetNUll(ped.numero_pico)
			  IF ped.pallets = 0 Then ped.es_pico = "S"
			  ped.referencia = f_componer_ref(ped.articulo,ped.calidad,ped.tonochar,ped.calibre)
			  IF Not  f_insertar_venliped(ped) Then
					f_mensaje("Error","Error al grabar el pedido")
			  END IF
			  IF control_ordenes = "S" Then
					la.linea        = la.linea  +1
					la.anyo_ped     = ped.anyo
					la.pedido       = ped.pedido
					la.linea_ped    = ped.linea
					la.fecha_ped    = ped.fpedido
					la.articulo     = ped.articulo
					la.calidad      = ped.calidad
					la.tonochar     = ped.tonochar
					la.calibre      = ped.calibre
					la.tipo_pallet  = ped.tipo_pallet
					la.caja         = ped.caja
					la.cajas        = ped.cajas
					la.total_cajas  = ped.total_cajas
					la.cantidad     = ped.cantidad 
					la.cantidad_ped = ped.cantidad
					la.tipo_unidad  = ped.tipo_unidad
					SetNUll(la.ubicacion)
					la.usuario      = nombre_usuario
					la.imp_bandas   = "N"
					la.deposito     = ped.deposito
					la.situacion_pedido = ped.situacion
					la.almacen_deposito = ped.almacen_deposito
					If Not f_insert_almlincargas(la) Then  f_mensaje("Error",sqlca.sqlerrtext)
			END IF
			 
		  END IF
		  f_actualizar_venpedido(ped.empresa,ped.anyo,ped.pedido)
		
		END IF
		
		var_cantidad_stock = f_disponible_articulo_calidad_tono_cali(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre)
		
		dw_articulos.SetItem(dw_articulos.getRow(),"stock",var_cantidad_stock)
		modo = "2"
		
		f_desbloquear_almacen(w_int_asignacion_stock.title)
		
		COMMIT;
		
	   //f_listado_incidencias(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre,var_tipo_pallet)
		
		f_pedidos(dw_articulos.GetRow())
		
		dw_pedidos.ScrollToRow(linea)
END IF

end subroutine

public subroutine f_quitar ();Dec v_linea,v_anyo,v_pedido,linea,ln,var_cantidad_stock,cantidad_anterior,numero,vcan,vanyo,vorden
String  v_situacion,v_articulo,v_calidad,var_referencia,v_tipo_pallet,cri,texto,ante_tono,v_caja
Dec ante_calibre
linea = dw_pedidos.GetRow()
IF linea = 0 Then Return

v_pedido         = dw_pedidos.getItemNumber(linea,"pedido")
v_anyo           = dw_pedidos.getItemNumber(linea,"anyo")
v_linea          = dw_pedidos.getItemNumber(linea,"linea")
v_situacion      = dw_pedidos.getItemString(linea,"situacion")
v_articulo       = dw_pedidos.getItemString(linea,"articulo")
v_calidad        = dw_pedidos.getItemString(linea,"calidad")
ante_tono        = dw_pedidos.getItemString(linea,"venliped_tonochar")
ante_calibre     = dw_pedidos.getItemNumber(linea,"calibre")
v_tipo_pallet    = dw_pedidos.getItemString(linea,"tipo_pallet")
v_caja           = dw_pedidos.getItemString(linea,"venliped_caja")
var_referencia   = f_componer_ref(v_articulo,v_calidad,"",0)
IF v_situacion   = "F" Then Return
If v_situacion   = "P" Then Return


// Control ordenes de carga
				
Select venliped.cantidad Into :cantidad_anterior From venliped
WHERE  venliped.empresa  =  :codigo_empresa 
AND    venliped.anyo     =  :v_anyo 
AND    venliped.pedido   =  :v_pedido 
AND    venliped.linea    =  :v_linea;
IF SQLCA.SQLCODE = 100 Then f_mensaje("Error en datos","No existe linea de pedido")

texto = ""		
Select count(*) Into :numero From almlincargas
Where  almlincargas.empresa    = :codigo_empresa
And    almlincargas.anyo_ped   = :v_anyo
And    almlincargas.pedido     = :v_pedido
And    almlincargas.linea_ped  = :v_linea;
IF IsNull(numero) Then numero = 0

CHOOSE CASE numero
	CASE 1
      Select cantidad,anyo,orden Into :vcan,:vanyo,:vorden From almlincargas
		Where  almlincargas.empresa    = :codigo_empresa
		And    almlincargas.anyo_ped   = :v_anyo
		And    almlincargas.pedido     = :v_pedido
		And    almlincargas.linea_ped  = :v_linea;
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
IF MessageBox("Control Ordenes",texto+"  ¿Continuar?",Question!,YesNo!)= 2 Then Return
END IF
//------------------------------------------------------------------


IF Not f_bloquear_almacen(w_int_asignacion_stock.title) Then
		modo = "1"
		Update venliped
		Set    venliped.situacion =  "F",
			 	 venliped.orden_preparacion = 3,
		       venliped.tonochar  =  :ante_tono,
				 venliped.calibre   =  0,
				 venliped.referencia   =  :var_referencia				 
		Where  venliped.empresa      =  :codigo_empresa
		And    venliped.anyo         =  :v_anyo
		And    venliped.pedido       =  :v_pedido
		And    venliped.linea        =  :v_linea;
		f_control_ordenes(codigo_empresa,v_anyo,v_pedido,v_linea)
		// Fin control ordenes

		var_referencia = f_componer_ref(v_articulo,v_calidad,ante_tono,ante_calibre)
		
		cri = "articulo = '"+v_articulo+"' and calidad = '"+v_calidad+"' and tono = '"+ante_tono+"' and calibre = "+string(ante_calibre)+""
		
		ln = dw_articulos.find(cri,1,dw_articulos.RowCOunt())
		IF IsNull(ln) Then ln = 0
		IF ln <> 0 Then
			var_cantidad_stock = f_disponible_articulo_calidad_tono_cali(codigo_empresa,v_articulo,v_calidad,ante_tono,ante_calibre)
			dw_articulos.SetItem(ln,"stock",var_cantidad_stock)
		END IF
		f_desbloquear_almacen(w_int_asignacion_stock.title)
		COMMIT;
//		f_listado_incidencias(codigo_empresa,v_articulo,v_calidad,ante_tono,ante_calibre,v_tipo_pallet)
		f_pedidos(dw_articulos.GetRow())
		dw_pedidos.ScrollToRow(linea)
END IF
end subroutine

public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet);Integer re,re1,cont,j
String cliente,var_ubicaciones,var_referencia
Dec{0}  pedido,orden,var_pedido,anyo,linea
Dec cantidad
var_pedido = dw_pedidos.GetItemNumber(dw_pedidos.GetRow(),"pedido")
DateTime  fpedido,forden
var_referencia  = f_componer_ref(articulo,calidad,tono,calibre)
cont = 0
String sel
dataStore dw_pedidos2
Sel = &
" Select  venliped.anyo,    " + &
"         venliped.pedido,  " + & 
"         venliped.linea,   " + &
"         venliped.fpedido,   " + &
"         venliped.cliente,   " + &
"         venliped.linea,   " + &
"         venliped.cantidad,   " + &
"         venliped.situacion   " + &
"    FROM venliped,venped  " + &
"   WHERE ( venliped.empresa = venped.empresa ) and  " + &
"         ( venliped.anyo = venped.anyo ) and  " + &
"         ( venliped.pedido = venped.pedido ) and  " + &
"         ( ( venliped.empresa = '"+codigo_empresa+"' ) AND  " + &
"         ( venliped.articulo = '"+articulo+"' ) AND  " + &
"         ( venliped.calidad = '"+calidad+"' ) AND  " + &
"         ( venliped.tonochar = '"+Trim(tono)+"' ) AND  " + &
"         ( venliped.calibre = "+String(calibre,"#######0")+" ) AND " + & 
"         ( venliped.tipo_pallet = '"+tipo_pallet+"' ) AND  " + &
"         ( venped.flistado is not null ) )    " 

//dw_pedidos2 = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, dw_pedidos2)


re1 = dw_pedidos2.RowCount()
IF re1 <> 0 Then
	For re =1 To re1
		fpedido = dw_pedidos2.GetItemDateTime(re,"venliped_fpedido")
		pedido = dw_pedidos2.GetItemNumber(re,"venliped_pedido")
		anyo = dw_pedidos2.GetItemNumber(re,"venliped_anyo")
		linea = dw_pedidos2.GetItemNumber(re,"venliped_linea")
		cantidad = dw_pedidos2.GetItemNumber(re,"venliped_cantidad")
		cliente = dw_pedidos2.GetItemString(re,"venliped_cliente")
		IF pedido = var_pedido Then
			cont = cont +1
		  IF  dw_pedidos2.GetItemString(re,"venliped_situacion") <> "P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		  ELSE
				var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		  END IF
			dw_listado.InsertRow(cont)
			dw_listado.SetItem(cont,"empresa",empresa)
			dw_listado.SetItem(cont,"articulo",articulo)
			dw_listado.SetItem(cont,"calidad",calidad)
			IF modo = "1" Then
				dw_listado.SetItem(cont,"tonochar","")
				dw_listado.SetItem(cont,"calibre",0)
				dw_listado.SetItem(cont,"ubicacion","")
			Else
				dw_listado.SetItem(cont,"tono",tono)
				dw_listado.SetItem(cont,"calibre",calibre)
				dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
			EnD IF
			dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
			dw_listado.SetItem(cont,"cliente",cliente)
			dw_listado.SetItem(cont,"pedido",pedido)
			dw_listado.SetItem(cont,"cantidad",cantidad)
			dw_listado.SetItem(cont,"fpedido",fpedido)
		END IF
	Next
END IF

DataStore dw_ordenes
sel = &
" SELECT  almlincargas.anyo,   " +&
"         almlincargas.orden,   "+&
"         almlincargas.linea,   "+&
"         almlincargas.matricula," +&  
"         almlincargas.cliente,   "+&
"         almlincargas.fcarga,   "+&
"         almlincargas.anyo_ped,  " +&
"         almlincargas.pedido,   "+&
"         almlincargas.linea_ped, " +& 
"         almlincargas.fecha_ped,  " +&
"         almlincargas.cantidad,   "+&
"         almlincargas.cantidad_ped," +&  
"         almlincargas.forden,   "+&
"         almlincargas.situacion_pedido  "+&
"    FROM almlincargas  "+&
"   WHERE almlincargas.empresa     = '"+empresa+"'  AND  "+&
"         almlincargas.articulo    = '"+articulo+"'  AND " +&
"         almlincargas.calidad     = '"+calidad+"'  AND  "+&
"         almlincargas.tonochar    = '"+Trim(tono)+"'  AND  "+&
"         almlincargas.calibre     = "+String(calibre,"######0")+"  AND  "+&
"         almlincargas.tipo_pallet = '"+tipo_pallet+"'"

//dw_ordenes = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw_ordenes)


re1 = dw_ordenes.RowCount()
COMMIT;
IF re1 <> 0 Then
	For re =1 To re1
		fpedido = dw_ordenes.GetItemDateTime(re,"fecha_ped")
		cliente = dw_ordenes.GetItemstring(re,"cliente")
		orden = dw_ordenes.GetItemNumber(re,"orden")
		cantidad = dw_ordenes.GetItemNumber(re,"cantidad")
		forden = dw_ordenes.GetItemDateTime(re,"forden")
		pedido = dw_ordenes.GetItemNumber(re,"pedido")
		anyo = dw_ordenes.GetItemNumber(re,"anyo_ped")
		linea = dw_ordenes.GetItemNumber(re,"linea_ped")
		IF pedido = var_pedido Then
			cont = cont +1
		  IF  dw_ordenes.GetItemString(re,"situacion_pedido") <> "P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		  ELSE
				var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		  END IF
			dw_listado.InsertRow(cont)
			dw_listado.SetItem(cont,"empresa",empresa)
			dw_listado.SetItem(cont,"articulo",articulo)
			dw_listado.SetItem(cont,"calidad",calidad)
			IF modo = "1" Then
				dw_listado.SetItem(cont,"tonochar","")
				dw_listado.SetItem(cont,"calibre",0)
				dw_listado.SetItem(cont,"ubicacion","")
			Else
				dw_listado.SetItem(cont,"tonochar",tono)
				dw_listado.SetItem(cont,"calibre",calibre)
				dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
			EnD IF
			dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
			dw_listado.SetItem(cont,"pedido",pedido)
			dw_listado.SetItem(cont,"cantidad",cantidad)
			dw_listado.SetItem(cont,"fpedido",fpedido)
			dw_listado.SetItem(cont,"orden",orden)
			dw_listado.SetItem(cont,"forden",forden)
			dw_listado.SetItem(cont,"cliente",cliente)
		END IF
	Next
END IF
IF dw_listado.RowCount()<> 0 Then
	pb_listado.visible = TRUE
	st_listado.visible = TRUE
END IF
destroy dw_ordenes
destroy dw_pedidos2
end subroutine

event open;call super::open;String mascara
This.title = "ASIGNANCION DE SOCKS"
f_activar_campo(uo_articulo.em_campo)
dw_articulos.SetTransObject(SQLCA)
dw_ubicaciones.SetTransObject(SQLCA)
dw_pedidos.SetTransObject(SQLCA)

istr_parametros.s_titulo_ventana="Preparación pedido"
IF istr_parametros.i_nargumentos>1 Then 
	f_posicion_inicio(This)
	uo_articulo.em_codigo.text  = istr_parametros.s_argumentos[2]
	uo_articulo.em_campo.text  = f_nombre_articulo(codigo_empresa,istr_parametros.s_argumentos[2])
	uo_articulo.ue_valor_anterior = 	uo_articulo.em_campo.text
	IF Trim(uo_articulo.em_campo.text) <> "" Then	cb_continuar.TriggerEvent(Clicked!)
END IF



end event

on w_int_asignacion_stock.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.st_1=create st_1
this.cb_continuar=create cb_continuar
this.cb_1=create cb_1
this.st_2=create st_2
this.em_cantidad=create em_cantidad
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.em_total_cajas=create em_total_cajas
this.em_cajas=create em_cajas
this.em_pallets=create em_pallets
this.cb_bases_decorados=create cb_bases_decorados
this.gb_1=create gb_1
this.cb_2=create cb_2
this.st_listado=create st_listado
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.pb_listado=create pb_listado
this.todas=create todas
this.fabricar=create fabricar
this.uo_articulo=create uo_articulo
this.dw_ubicaciones=create dw_ubicaciones
this.dw_pedidos=create dw_pedidos
this.dw_articulos=create dw_articulos
this.cb_ventas=create cb_ventas
this.st_formato=create st_formato
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_cantidad
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.em_total_cajas
this.Control[iCurrent+11]=this.em_cajas
this.Control[iCurrent+12]=this.em_pallets
this.Control[iCurrent+13]=this.cb_bases_decorados
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.st_listado
this.Control[iCurrent+17]=this.dw_listado
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.pb_listado
this.Control[iCurrent+20]=this.todas
this.Control[iCurrent+21]=this.fabricar
this.Control[iCurrent+22]=this.uo_articulo
this.Control[iCurrent+23]=this.dw_ubicaciones
this.Control[iCurrent+24]=this.dw_pedidos
this.Control[iCurrent+25]=this.dw_articulos
this.Control[iCurrent+26]=this.cb_ventas
this.Control[iCurrent+27]=this.st_formato
this.Control[iCurrent+28]=this.st_6
end on

on w_int_asignacion_stock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.cb_continuar)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.em_cantidad)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_total_cajas)
destroy(this.em_cajas)
destroy(this.em_pallets)
destroy(this.cb_bases_decorados)
destroy(this.gb_1)
destroy(this.cb_2)
destroy(this.st_listado)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.pb_listado)
destroy(this.todas)
destroy(this.fabricar)
destroy(this.uo_articulo)
destroy(this.dw_ubicaciones)
destroy(this.dw_pedidos)
destroy(this.dw_articulos)
destroy(this.cb_ventas)
destroy(this.st_formato)
destroy(this.st_6)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_articulos)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_articulos)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_articulos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_articulos)
end event

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event ue_f6;call super::ue_f6;cb_ventas.TriggerEvent(Clicked!)
end event

event ue_f7;call super::ue_f7;cb_bases_decorados.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_int_asignacion_stock = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_asignacion_stock
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_asignacion_stock
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_asignacion_stock
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_int_asignacion_stock
integer x = 2715
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
end type

event clicked;IF dw_listado.RowCOunt() <> 0 Then
	f_mensaje("No se puede salir","Listar Incidencias")
	Return
END IF
Call Super::Clicked
end event

type st_1 from statictext within w_int_asignacion_stock
integer x = 37
integer y = 152
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Descripción:"
boolean focusrectangle = false
end type

type cb_continuar from u_boton within w_int_asignacion_stock
integer x = 2098
integer y = 144
integer height = 88
integer taborder = 20
string text = "F5 Continuar"
end type

event clicked;Dec{0}  re1,re2,calibre,contador,rel2,rel1
Dec{4}  stock,tt=0,exis,total_existencias,reservado
String  articulo,calidad,tipo_pallet,referencia,marca,caja
String  sel,sel2,art1,art2,dsitu,hsitu,tono

This.enabled =FALSE
dw_articulos.SetRedraw(FALSE)

IF fabricar.checked = true then 
	dsitu ="F"
	hsitu ="F"
  else
	dsitu ="."
	hsitu ="Z"
End if

IF Trim(uo_articulo.em_codigo.text) <> "" Then
	art1 = uo_articulo.em_codigo.text
	art2 = uo_articulo.em_codigo.text
ELSE
	art1 = "."
	art2 = "Z"
END IF

COMMIT;

Sel = &
" SELECT  venliped.articulo,   " +&
"         venliped.calidad, " +&
"         venliped.tonochar, " +&
"         venliped.calibre " +&
"   FROM  venliped "+&
"  WHERE  venliped.empresa   = '" + codigo_empresa + "'"+&
"    AND  venliped.situacion between '"+dsitu+"' and '" +hsitu+"'"+& 
"    AND  venliped.articulo between '"+art1+"' and '" +art2+"'"+& 
" GROUP BY venliped.articulo,  "     +&
"         venliped.calidad, " +&
"         venliped.tonochar, " +&
"         venliped.calibre " +&
" ORDER BY venliped.articulo ASC,  "  +&
"         venliped.calidad, "+&
"         venliped.tonochar, "+&
"         venliped.calibre "

contador = 0
dw_articulos.Reset()
dw_articulos.SetRedraw(False)
DataStore dw_proceso,dw_proceso1

//dw_proceso = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dw_proceso)


re2 = dw_proceso.RowCount()

IF re2 = 0 Then
	dw_articulos.Reset()
 ELSE
	FOR re1 = 1 To re2
		articulo    = dw_proceso.GetItemSTring(re1,"articulo")
		calidad     = dw_proceso.GetItemSTring(re1,"calidad")
		tono        = dw_proceso.GetItemSTring(re1,"tonochar")
		calibre     = dw_proceso.GetItemNumber(re1,"calibre")
		if isnull(calidad) then calidad = ""
		if isnull(calibre) then calibre = 0
		if fabricar.checked = False then
               sel = "select    almlinubica.empresa,    "+&
					      "          almlinubica.articulo, "+&
					      "          almlinubica.calidad, "+&
							"          almlinubica.calibre, "+&
							"          almlinubica.tonochar, Sum(almlinubica.existencias) existencias "+&
							" FROM     almlinubica "+&
					      "WHERE     almlinubica.empresa  = '" + codigo_empresa + "'"+&
							"  AND     almlinubica.articulo = '" + articulo + "'" +&
							"  AND     almlinubica.calidad  = '" + calidad + "'" +&
							"  AND     almlinubica.tonochar = '" + tono + "'" +&
							"  AND     almlinubica.calibre  = '" + string(calibre) + "'" +&
							"  AND     almlinubica.pedido is null" +&
							" GROUP BY almlinubica.empresa,     "+&
							"          almlinubica.articulo,  "+&
							"          almlinubica.calidad,  "+&
							"          almlinubica.tonochar, "+&
							"          almlinubica.calibre  "+&
							"ORDER BY  almlinubica.empresa,     "+&
							"          almlinubica.articulo,  "+&
                     "          almlinubica.calidad,  "+&							
							"          almlinubica.tonochar, "+&
							"          almlinubica.calibre "
							
					//dw_proceso1 = f_cargar_cursor2(sel)
					f_cargar_cursor_nuevo(sel, dw_proceso1)
					
					
					
                     rel2 = dw_proceso1.RowCount()
							if rel2<>0 then
							  for rel1=1 to rel2
 								   contador          = contador +1
									articulo          = dw_proceso1.GetItemString(rel1,"articulo")
									calidad           = dw_proceso1.GetItemString(rel1,"calidad")									
									total_existencias = dw_proceso1.GetItemNumber(rel1,"existencias")
									tono              = dw_proceso1.GetItemString(rel1,"tonochar")
									calibre           = dw_proceso1.GetItemNumber(rel1,"calibre")
								   
									reservado         = f_reservado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
									
									stock = total_existencias - reservado 
									// comprueba si tiene alguna observacion
									marca=""
//									if f_bloqueo_almlinubica_referencia(codigo_empresa,referencia,tipo_pallet) then marca="*"
			                  					
							      dw_articulos.InsertRow(contador)
									dw_articulos.SetiTem(contador,"empresa",codigo_empresa)
									dw_articulos.SetiTem(contador,"articulo",articulo)
									dw_articulos.SetiTem(contador,"calidad",calidad)
									dw_articulos.SetiTem(contador,"tono",tono)
									dw_articulos.SetiTem(contador,"calibre",calibre)
									dw_articulos.SetiTem(contador,"stock",stock)
									dw_articulos.SetiTem(contador,"nombre_articulo",f_nombre_articulo(codigo_empresa,articulo))
									dw_articulos.SetiTem(contador,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
									dw_articulos.SetiTem(contador,"marca",marca)
								Next
							End if
			 else
               sel = "select    almlinubica.empresa,    "+&
							"          almlinubica.articulo, "+&
							"          almlinubica.calidad, "+&
							"          almlinubica.calibre, "+&
							"          almlinubica.tonochar,Sum(existencias) existencias "+&
							" FROM     almlinubica "+&
					      "WHERE     almlinubica.empresa  = '" + codigo_empresa + "'"+&
							"  AND     almlinubica.articulo = '" + articulo + "'" +&
							"  AND     almlinubica.calidad  = '" + calidad + "'" +&
							"  AND     almlinubica.tonochar = '" + tono + "'" +&
							"  AND     almlinubica.calibre  = '" + string(calibre) + "'" +&
							"  AND     almlinubica.pedido   is null" +&
							" GROUP BY almlinubica.empresa,     "+&
							"          almlinubica.articulo,  "+&
							"          almlinubica.calidad,  "+&
							"          almlinubica.calibre,  "+&					
							"          almlinubica.tonochar,  "+&
							"          almlinubica.calibre  "+&
							"ORDER BY  almlinubica.empresa,     "+&
							"          almlinubica.articulo,  "+&
                     "          almlinubica.calidad,  "+&							
                     "          almlinubica.tonochar,  "+&
							"          almlinubica.calibre  "
							
							//dw_proceso1 = f_cargar_cursor2(sel)
							f_cargar_cursor_nuevo(sel, dw_proceso1)
							
							
                     rel2 = dw_proceso1.RowCount()
 							if rel2<>0 then 
							  for rel1=1 to rel2
 								  	articulo    = dw_proceso1.GetItemString(rel1,"articulo")
									calidad     = dw_proceso1.GetItemString(rel1,"calidad")							
									tono        = dw_proceso1.GetItemString(rel1,"tonochar")
									calibre     = dw_proceso1.GetItemNumber(rel1,"calibre")
									total_existencias = dw_proceso1.GetItemNumber(rel1,"existencias")
									
									reservado         = f_reservado_articulo_calidad_tono_cali(codigo_empresa,articulo,calidad,tono,calibre)
							
									stock = total_existencias - reservado 

																
//									IF stock >0 Then
											contador = contador +1
											// comprueba si tiene alguna observacion
									      marca=""
//									      if f_bloqueo_almlinubica_referencia(codigo_empresa,referencia,tipo_pallet) then marca="*"

											dw_articulos.InsertRow(contador)
											dw_articulos.SetiTem(contador,"empresa",codigo_empresa)
											dw_articulos.SetiTem(contador,"articulo",articulo)
											dw_articulos.SetiTem(contador,"calidad",calidad)
											dw_articulos.SetiTem(contador,"tono",tono)
											dw_articulos.SetiTem(contador,"calibre",calibre)
											dw_articulos.SetiTem(contador,"stock",stock)
											dw_articulos.SetiTem(contador,"nombre_articulo",f_nombre_articulo(codigo_empresa,articulo))
											dw_articulos.SetiTem(contador,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
											dw_articulos.SetiTem(contador,"marca",marca)
//              					End if
							   Next
				       End if
				End if
		f_contador_procesos(re1,re2)
	NEXT
END IF

dw_articulos.SetRedraw(True)
IF dw_articulos.RowCount() <> 0 Then
	f_pedidos(1)
	dw_articulos.SetRow(1)
END IF

f_activar_campo(uo_articulo.em_campo)
 
This.enabled =TRUE
dw_articulos.SetRedraw(TRUE)
COMMIT;

destroy dw_proceso
destroy dw_proceso1
end event

type cb_1 from u_boton within w_int_asignacion_stock
integer x = 2930
integer y = 236
integer width = 279
integer height = 68
integer taborder = 0
string text = "&Asignar"
end type

event clicked;f_asignar()
COMMIT;
end event

type st_2 from statictext within w_int_asignacion_stock
boolean visible = false
integer x = 2665
integer y = 1252
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_asignacion_stock
boolean visible = false
integer x = 2665
integer y = 1328
integer width = 256
integer height = 80
integer taborder = 80
integer textsize = -7
fontcharset fontcharset = ansi!
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "##,###.00"
end type

event modificado;call super::modificado;String v_articulo,v_tipo_pallet,v_caja
String cadena

v_tipo_pallet = dw_articulos.GetItemString(dw_articulos.GetRow(),"tipo_pallet")
v_caja        = dw_articulos.GetItemString(dw_articulos.GetRow(),"caja")
v_articulo    = dw_articulos.GetItemString(dw_articulos.GetRow(),"articulo")
cadena=f_calculo_unidades(codigo_empresa,v_articulo,&
                            v_tipo_pallet,&
									 v_caja,&
                            0,&
                            0,&
                            Dec(em_cantidad.text))
                       
 em_pallets.text      = Mid(cadena,1,6)
 em_cajas.text        = Mid(cadena,7,6)
 em_total_cajas.text  = Mid(cadena,13,6)
 em_cantidad.text     = Mid(cadena,19,9)
end event

type st_3 from statictext within w_int_asignacion_stock
boolean visible = false
integer x = 2446
integer y = 1252
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "T.Cajas"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_asignacion_stock
boolean visible = false
integer x = 2277
integer y = 1252
integer width = 169
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_asignacion_stock
boolean visible = false
integer x = 2085
integer y = 1252
integer width = 192
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Pallets"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_total_cajas from u_em_campo within w_int_asignacion_stock
event modificado pbm_custom02
boolean visible = false
integer x = 2446
integer y = 1328
integer width = 219
integer height = 80
integer taborder = 0
integer textsize = -7
fontcharset fontcharset = ansi!
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "##,##0"
end type

type em_cajas from u_em_campo within w_int_asignacion_stock
event modificado pbm_custom02
boolean visible = false
integer x = 2277
integer y = 1328
integer width = 169
integer height = 80
integer taborder = 70
integer textsize = -7
fontcharset fontcharset = ansi!
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##,##0"
end type

event modificado;call super::modificado;String cadena
String v_articulo,v_tipo_pallet,v_caja

v_tipo_pallet = dw_articulos.GetItemString(dw_articulos.GetRow(),"tipo_pallet")
v_caja        = dw_articulos.GetItemString(dw_articulos.GetRow(),"caja")
v_articulo    = dw_articulos.GetItemString(dw_articulos.GetRow(),"articulo")
cadena=f_calculo_unidades(codigo_empresa,v_articulo,&
                            v_tipo_pallet,&
									 v_caja,&
                            Dec(em_pallets.text),&
                            Dec(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text  =Mid(cadena,1,6)
 em_cajas.text      =Mid(cadena,7,6)
 em_total_cajas.text    =Mid(cadena,13,6)
 em_cantidad.text   =Mid(cadena,19,9)
end event

type em_pallets from u_em_campo within w_int_asignacion_stock
event modificado pbm_custom02
boolean visible = false
integer x = 2085
integer y = 1328
integer width = 192
integer height = 80
integer taborder = 60
integer textsize = -7
fontcharset fontcharset = ansi!
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##,##0"
string displaydata = "("
end type

event modificado;call super::modificado;String cadena
String v_articulo,v_tipo_pallet,v_caja

v_tipo_pallet = dw_articulos.GetItemString(dw_articulos.GetRow(),"tipo_pallet")
v_caja        = dw_articulos.GetItemString(dw_articulos.GetRow(),"caja")
v_articulo    = dw_articulos.GetItemString(dw_articulos.GetRow(),"articulo")
cadena=f_calculo_unidades(codigo_empresa,v_articulo,&
                            v_tipo_pallet,&
									 v_caja,&
                            Dec(em_pallets.text),&
                            Dec(em_cajas.text),&
                            Dec(em_cantidad.text))
                       
 em_pallets.text  =Mid(cadena,1,6)
 em_cajas.text      =Mid(cadena,7,6)
 em_total_cajas.text    =Mid(cadena,13,6)
 em_cantidad.text   =Mid(cadena,19,9)
end event

type cb_bases_decorados from u_boton within w_int_asignacion_stock
event clicked pbm_bnclicked
boolean visible = false
integer x = 1294
integer y = 1332
integer width = 402
integer height = 68
integer taborder = 0
string text = "F7 Bas/Decor"
end type

type gb_1 from groupbox within w_int_asignacion_stock
boolean visible = false
integer x = 1280
integer y = 1228
integer width = 430
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
end type

type cb_2 from u_boton within w_int_asignacion_stock
event clicked pbm_bnclicked
integer x = 2629
integer y = 236
integer width = 293
integer height = 68
integer taborder = 0
string text = "&Quitar"
end type

event clicked;call super::clicked;f_quitar()
COMMIT;
end event

type st_listado from statictext within w_int_asignacion_stock
boolean visible = false
integer x = 2075
integer y = 148
integer width = 544
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Listado Incidencias"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_int_asignacion_stock
boolean visible = false
integer width = 219
integer height = 100
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_int_movtraspasos5"
boolean livescroll = true
end type

type gb_2 from groupbox within w_int_asignacion_stock
integer x = 2615
integer y = 200
integer width = 613
integer height = 116
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_listado from upb_imprimir within w_int_asignacion_stock
event clicked pbm_bnclicked
boolean visible = false
integer x = 1979
integer y = 148
integer width = 96
integer height = 84
integer taborder = 40
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;String impresora,cadena,imp
Integer j
DateTime fecha
SetNull(fecha)
SELECT ven_usuimpre.impresora_preparacion INTO :impresora FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
imp=dw_listado.Describe("Datawindow.Printer")
IF imp <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
ELSE  
//	FOR j = 1 To 
//		 IF  dw_ordenes.GetItemString(re,"situacion_pedido") <> "P" Then
//			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
//		  ELSE
//				var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea,2,"S")
//		  END IF
		  
	dw_listado.SetRedraw(FALSE)
	dw_listado.SetRedraw(TRUE)
	IF dw_listado.RowCOunt() < 11 Then
		FOr j = 1 To 10
		dw_listado.InsertRow(dw_listado.RowCOunt()+1)
		dw_listado.SetItem(dw_listado.RowCOunt(),"empresa",codigo_empresa)
		dw_listado.SetItem(dw_listado.RowCOunt(),"fpedido",fecha)
	Next
	END IF
	IF dw_listado.Print(TRUE)= 1 Then
		dw_listado.Reset()
		st_listado.visible = FALSE
		pb_listado.visible = FALSE
	END IF
	
END IF


end event

type todas from radiobutton within w_int_asignacion_stock
integer x = 2007
integer y = 232
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Todas"
boolean checked = true
boolean lefttext = true
end type

type fabricar from radiobutton within w_int_asignacion_stock
integer x = 2281
integer y = 232
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fabricar"
boolean lefttext = true
end type

type uo_articulo from u_em_campo_2 within w_int_asignacion_stock
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 411
integer y = 144
integer width = 1138
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
st_formato.text = f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
dw_pedidos.Reset()
dw_articulos.Reset()



end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type dw_ubicaciones from datawindow within w_int_asignacion_stock
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
boolean visible = false
integer x = 407
integer y = 248
integer width = 2030
integer height = 760
integer taborder = 30
boolean titlebar = true
string title = "Consulta  Ubicaciones."
string dataobject = "dw_asignacion_stock4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	dw_ubicaciones.visible = FALSE
END IF
end event

type dw_pedidos from u_datawindow_consultas within w_int_asignacion_stock
integer x = 1285
integer y = 316
integer width = 1947
integer height = 1096
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_int_asignacion_stock2"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() = 0 Then Return 
em_cantidad.text = String(GetItemNumber(GetRow(),"cantidad"))

String v_articulo,v_tipo_pallet,v_caja
String cadena
Long   posi,posi_aux

v_tipo_pallet = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"tipo_pallet")
v_caja        = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"venliped_caja")
v_articulo    = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"articulo")

cadena=f_calculo_unidades(codigo_empresa,v_articulo,&
                            v_tipo_pallet,&
									 v_caja,&
                            0,&
                            0,&
                            Dec(em_cantidad.text))


posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_total_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

end event

event clicked;call super::clicked;//Dec vpedido,vanyo,vlinea
//IF GetRow() = 0 Then Return
//CHOOSE CASE f_objeto_datawindow(This)
//	CASE "borrar"
//     	If GetItemString(GetRow(),"situacion") <> "P" Then
//			IF MessageBox("Proceso borrado linea de pedido","¿Desea borrar la linea?",Question!,YesNo!)= 1 Then
//				vanyo   = GetItemNumber(GetRow(),"anyo")
//				vpedido = GetItemNumber(GetRow(),"pedido")
//				vlinea  = GetItemNumber(GetRow(),"linea")
//				Delete from venliped 
//				Where  venliped.empresa = :codigo_empresa
//				And    venliped.anyo    = :vanyo
//				And    venliped.pedido  = :vpedido
//				And    venliped.linea   = :vlinea;
//				f_actualizar_venpedido(codigo_empresa,vanyo,vpedido)
//				COMMIT;
//				dw_articulos.TriggerEvent(RowfocusChanged!)
//		   End if
//	   END IF
//	CASE "preparar"
//      	str_parametros lstr_param
//			lstr_param.i_nargumentos = 4
//			lstr_param.s_argumentos[1]  = "w_int_almcargas"
//			lstr_param.s_argumentos[2]  = String(GetItemNumber(GetRow(),"anyo"))
//			lstr_param.s_argumentos[3]  = String(GetItemNumber(GetRow(),"pedido"))
//			lstr_param.s_argumentos[4]  = String(GetItemNumber(GetRow(),"linea"))
//			OpenWithParm(w_int_preparacion_pedido,lstr_param)
//			
//			IF  Message.StringParm = "S" Then f_pedidos(dw_articulos.GetRow())
//		
//END CHOOSE
//		
//
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param)
End If
end event

type dw_articulos from u_datawindow_consultas within w_int_asignacion_stock
integer y = 316
integer width = 1280
integer height = 1096
integer taborder = 0
string dataobject = "dw_int_asignacion_stock5"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() = 0 Then Return
f_pedidos(GetRow())
end event

event rbuttondown;call super::rbuttondown;String  var_calidad,var_tipo_pallet,var_articulo,var_tono
Dec{0}  var_calibre
IF GetRow()= 0 Then Return
var_articulo    = This.GetItemString(GetRow(),"articulo") 
var_calidad     = This.GetItemString(GetRow(),"calidad")  
//var_tipo_pallet = This.GetItemString(GetRow(),"tipo_pallet")  
var_calibre     = This.GetItemNumber(GetRow(),"calibre")  
var_tono        = This.GetItemstring(GetRow(),"tono")  
if trim(var_calidad)="0" or isnull(var_calidad) then var_calidad = ""
dw_ubicaciones.visible = TRUE
dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad,var_tono,var_calibre)


end event

event clicked;call super::clicked;//if row=0 then return
//str_parametros valores
//CHOOSE CASE f_objeto_datawindow(This) 
//   CASE 'marca'
//    IF dw_articulos.getitemString(row,"marca") = "*" Then
//      valores.s_argumentos[1]=dw_articulos.getitemString(row,"referencia")
//      valores.s_argumentos[2]=dw_articulos.getitemString(row,"tipo_pallet")
//      OpenWithParm(w_observaciones_almlinubica,valores)  
//    END IF
//END CHOOSE

end event

type cb_ventas from u_boton within w_int_asignacion_stock
boolean visible = false
integer x = 1294
integer y = 1264
integer width = 402
integer height = 68
integer taborder = 11
integer textsize = -7
boolean enabled = false
string text = "F6 Ult. Ventas"
end type

event clicked;call super::clicked;str_parametros lstr_param
f_activar_campo(uo_articulo.em_campo)
IF dw_pedidos.GetRow() = 0 Then return
IF dw_articulos.GetRow() = 0 Then return

lstr_param.s_argumentos[1] = "w_int_asignacion_stock"
lstr_param.s_argumentos[2] = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"articulo")
lstr_param.s_argumentos[3] = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"calidad")
lstr_param.s_argumentos[4] = ""
lstr_param.s_argumentos[5] = ""
lstr_param.s_argumentos[6] = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"tipo_pallet") 
lstr_param.s_argumentos[7] = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"cliente") 
lstr_param.i_nargumentos = 7

OpenWithParm(w_con_ventas_articulos,lstr_param) 

end event

type st_formato from statictext within w_int_asignacion_stock
integer x = 1573
integer y = 144
integer width = 411
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_asignacion_stock
integer x = 41
integer y = 152
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

