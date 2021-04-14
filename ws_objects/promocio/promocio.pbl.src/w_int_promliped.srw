$PBExportHeader$w_int_promliped.srw
forward
global type w_int_promliped from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_promliped
end type
type st_2 from statictext within w_int_promliped
end type
type em_pedido from u_em_campo within w_int_promliped
end type
type st_3 from statictext within w_int_promliped
end type
type st_texto_cantidad from statictext within w_int_promliped
end type
type st_22 from statictext within w_int_promliped
end type
type em_cliente from u_em_campo within w_int_promliped
end type
type st_nombre_cliente from statictext within w_int_promliped
end type
type em_anyo from u_em_campo within w_int_promliped
end type
type gb_1 from groupbox within w_int_promliped
end type
type gb_2 from groupbox within w_int_promliped
end type
type gb_3 from groupbox within w_int_promliped
end type
type em_situacion from u_em_campo within w_int_promliped
end type
type st_texto_cantidad2 from statictext within w_int_promliped
end type
type st_articulo from statictext within w_int_promliped
end type
type em_cantidad_articulo from u_em_campo within w_int_promliped
end type
type st_panel from statictext within w_int_promliped
end type
type em_cantidad_panel from u_em_campo within w_int_promliped
end type
type uo_articulo from u_em_campo_2 within w_int_promliped
end type
type dw_proceso2 from datawindow within w_int_promliped
end type
type cb_grabar_articulo from u_boton within w_int_promliped
end type
type cb_borrar_articulo from u_boton within w_int_promliped
end type
type dw_articulo from datawindow within w_int_promliped
end type
type cb_preparar_panel from u_boton within w_int_promliped
end type
type cb_borrar_panel from u_boton within w_int_promliped
end type
type cb_insertar_panel from u_boton within w_int_promliped
end type
type cb_preparar_paneles from u_boton within w_int_promliped
end type
type cb_grabar_panel from u_boton within w_int_promliped
end type
type cb_seleccion_panel from u_boton within w_int_promliped
end type
type gb_6 from groupbox within w_int_promliped
end type
type st_clase_panel from statictext within w_int_promliped
end type
type uo_clase_panel from u_em_campo_2 within w_int_promliped
end type
type cb_reponer from u_boton within w_int_promliped
end type
type gb_4 from groupbox within w_int_promliped
end type
type cb_insertar_articulo from u_boton within w_int_promliped
end type
type gb_5 from groupbox within w_int_promliped
end type
type gb_7 from groupbox within w_int_promliped
end type
type volcado from u_boton within w_int_promliped
end type
type dw_control from datawindow within w_int_promliped
end type
type uo_panel from u_em_campo_2 within w_int_promliped
end type
type dw_detalle from datawindow within w_int_promliped
end type
type dw_mapa from datawindow within w_int_promliped
end type
end forward

global type w_int_promliped from w_int_con_empresa
integer width = 2926
integer height = 2008
boolean maxbox = false
windowtype windowtype = popup!
pb_1 pb_1
st_2 st_2
em_pedido em_pedido
st_3 st_3
st_texto_cantidad st_texto_cantidad
st_22 st_22
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
em_anyo em_anyo
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
em_situacion em_situacion
st_texto_cantidad2 st_texto_cantidad2
st_articulo st_articulo
em_cantidad_articulo em_cantidad_articulo
st_panel st_panel
em_cantidad_panel em_cantidad_panel
uo_articulo uo_articulo
dw_proceso2 dw_proceso2
cb_grabar_articulo cb_grabar_articulo
cb_borrar_articulo cb_borrar_articulo
dw_articulo dw_articulo
cb_preparar_panel cb_preparar_panel
cb_borrar_panel cb_borrar_panel
cb_insertar_panel cb_insertar_panel
cb_preparar_paneles cb_preparar_paneles
cb_grabar_panel cb_grabar_panel
cb_seleccion_panel cb_seleccion_panel
gb_6 gb_6
st_clase_panel st_clase_panel
uo_clase_panel uo_clase_panel
cb_reponer cb_reponer
gb_4 gb_4
cb_insertar_articulo cb_insertar_articulo
gb_5 gb_5
gb_7 gb_7
volcado volcado
dw_control dw_control
uo_panel uo_panel
dw_detalle dw_detalle
dw_mapa dw_mapa
end type
global w_int_promliped w_int_promliped

type variables
string filtro,bloqueado,var_cliente,var_pais,situacion,var_usuario_pedido,var_panel,reposicion,var_tipo_cliente,acceso
dec{0} var_pedido,var_anyo
str_promlinped 	linped

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_control2 ()
public subroutine f_control_campos ()
public subroutine f_calculo_linea (integer var_linea, integer var_orden)
public subroutine f_calculo_pedido ()
public subroutine f_grabar_panel (string vpanel, decimal var_cantidad)
end prototypes

public subroutine f_control ();dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido)
f_control2()
dw_control.Retrieve(codigo_empresa,var_anyo,var_pedido,linped.tipo_expositor,reposicion)
end subroutine

public subroutine f_control2 ();If dw_detalle.GetRow() = 0 Then Return
dw_articulo.Retrieve(codigo_empresa,var_anyo,var_pedido,dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea"))
end subroutine

public subroutine f_control_campos ();IF situacion= "PANEL" Then
	cb_grabar_articulo.enabled    =  FALSE
	cb_borrar_articulo.enabled    =  FALSE
	cb_insertar_articulo.enabled  =  FALSE
	cb_borrar_panel.enabled       =  TRUE
 	cb_insertar_panel.enabled     =  TRUE
   cb_seleccion_panel.enabled    =  TRUE
   cb_preparar_panel.enabled     =  TRUE
   cb_preparar_paneles.enabled   =  TRUE
  	cb_grabar_panel.enabled       =  TRUE
 ELSE
	cb_grabar_articulo.enabled    =  TRUE
	cb_borrar_articulo.enabled    =  TRUE
	cb_insertar_articulo.enabled  =  TRUE
	cb_borrar_panel.enabled       =  FALSE
	cb_insertar_panel.enabled     =  FALSE
	cb_seleccion_panel.enabled    =  FALSE
	cb_grabar_panel.enabled       =  FALSE
   cb_preparar_panel.enabled     =  FALSE
   cb_preparar_paneles.enabled   =  FALSE
END IF
end subroutine

public subroutine f_calculo_linea (integer var_linea, integer var_orden);String calidad,var_empresa,var_articulo,var_calidad,var_clase,var_tipo_panel,var_medida,var_expositor,var_tipo,var_tipo_expositor,var_medidas
Dec{2} var_peso,var_piezas,var_precio,var_cantidad,var_peso_panel,var_coste_panel,var_venta_panel,var_coste_manipulacion
Dec{2}  var_coste,var_venta

  SELECT promlindetallped.articulo,   
         promlindetallped.calidad,   
         promlindetallped.piezas  
    INTO :var_articulo,:var_calidad,:var_piezas  
    FROM promlindetallped  
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo = :var_anyo ) AND  
         ( promlindetallped.pedido = :var_pedido ) AND  
         ( promlindetallped.linea = :var_linea ) AND  
         ( promlindetallped.orden = :var_orden );

iF SQLCA.SQLCODE = 0 Then
If f_unidad_articulo(codigo_empresa,var_articulo) ="1" Then
//  var_cantidad = f_conversion_piezas_cantidad(codigo_empresa,var_articulo,var_piezas)
End If
var_peso    = f_peso_articulo(codigo_empresa,var_articulo)

  SELECT almartcal.empresa,almartcal.articulo,   
         almartcal.calidad, almartcal.precio  
    INTO :var_empresa,:var_articulo,   
         :var_calidad,:var_precio  
    FROM almartcal  
   WHERE ( almartcal.empresa = :codigo_empresa ) AND  
         ( almartcal.articulo = :var_articulo ) AND  
         ( almartcal.calidad = :var_calidad )   ;

  SELECT articulos.empresa,   
         articulos.codigo,   
         articulos.precio_coste  
    INTO :var_empresa,   
         :var_articulo,   
         :var_coste  
    FROM articulos  
   WHERE ( articulos.empresa = :codigo_empresa ) AND  
         ( articulos.codigo = :var_articulo )   ;

IF IsNull(var_coste) Then var_coste = 0
IF IsNull(var_peso)  Then var_peso  = 0
var_coste  = var_coste * var_cantidad
var_venta  = var_venta * var_cantidad
var_peso   = var_peso  * var_piezas
  UPDATE promlindetallped  
     SET peso = :var_peso,   
         coste = :var_coste,   
         venta = :var_venta  
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo = :var_anyo ) AND  
         ( promlindetallped.pedido = :var_pedido ) AND  
         ( promlindetallped.linea = :var_linea ) AND  
         ( promlindetallped.orden = :var_orden )   ;
	END IF			
	
	
	
   Select Sum(peso),sum(coste),sum(venta)
	Into   :var_peso,:var_coste,:var_venta
	From    promlindetallped
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo    = :var_anyo ) AND  
         ( promlindetallped.pedido  = :var_pedido ) AND  
         ( promlindetallped.linea   = :var_linea );
	
	
	
	
	
	
	

	
	Select tipo_expositor,tipo_panel,expositor,tipo,clase_panel 
	Into   :var_tipo_expositor,:var_tipo_panel,:var_expositor,:var_tipo,:var_clase
	From   promlinped
	Where  promlinped.empresa = :codigo_empresa
	And    promlinped.anyo    = :var_anyo
	And    promlinped.pedido  = :var_pedido
	And    promlinped.linea   = :var_linea;
	
IF var_tipo = "2" Then
	var_medidas     = f_medida_promlinexpositores(codigo_empresa,var_tipo_expositor,var_tipo_panel)
	var_peso_panel  = f_peso_promclasemedidas(codigo_empresa,linped.clase_panel,var_medidas)
	var_coste_panel = f_preciocoste_promclasemedidas(codigo_empresa,var_clase,var_medidas)
	var_venta_panel = f_precioventa_promclasemedidas(codigo_empresa,var_clase,var_medidas)
	var_coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medidas)
	var_cantidad= 1
ELSE
	var_peso_panel  = f_pesopanel_promparam(codigo_empresa)
	var_coste_panel = f_costepanel_promparam(codigo_empresa)
	var_venta_panel = f_pventapanel_promparam(codigo_empresa)
	var_coste_manipulacion = 0
END IF	
	
	  UPDATE promlinped  
     SET  peso_material  = :var_peso,   
          coste_material = :var_coste,   
          venta_material = :var_venta  ,
			 peso_panel     = :var_peso_panel,
          coste_panel    = :var_coste_panel,
          venta_panel    = :var_venta_panel,
			 coste_manipulacion = :var_coste_manipulacion
			 
			 
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo = :var_anyo ) AND  
         ( promlinped.pedido = :var_pedido ) AND  
         ( promlinped.linea = :var_linea )   ;


COMMIT;
f_calculo_pedido()


end subroutine

public subroutine f_calculo_pedido ();Dec{2} var_peso_material,var_coste_panel,var_venta_panel,var_peso_panel,var_coste_manipulacion
Dec{2} var_coste_material,var_venta_material

			
   Select Sum(peso_material*cantidad),sum(coste_material*cantidad),sum(venta_material*cantidad) ,
  	       Sum(peso_panel*cantidad)  , sum(coste_panel * cantidad),
			 sum(venta_panel*cantidad) , sum(coste_manipulacion * cantidad) 
	Into :var_peso_material,:var_coste_material,:var_venta_material,
 	     :var_peso_panel,:var_coste_panel,:var_venta_panel,
			:var_coste_manipulacion
	From promlinped
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo    = :var_anyo ) AND  
         ( promlinped.pedido  = :var_pedido );

			IF IsNull(var_peso_material)   Then var_peso_material   = 0
			IF IsNull(var_coste_panel)     Then var_coste_panel     = 0
			IF IsNull(var_venta_material)  Then var_venta_material  = 0
			IF IsNull(var_peso_panel)      Then var_peso_panel      = 0
			IF IsNull(var_coste_material)  Then var_coste_material  = 0
			IF IsNull(var_venta_panel)     Then var_venta_panel     = 0
			IF IsNull(var_coste_manipulacion)     Then var_coste_manipulacion  = 0
		

	  UPDATE promped  
     SET peso_material  = :var_peso_material,   
         coste_material = :var_coste_material,   
         venta_material = :var_venta_material,
	      peso_paneles  = :var_peso_panel,   
         coste_paneles = :var_coste_panel,   
         venta_paneles = :var_venta_panel,
			coste_manipulacion = :var_coste_manipulacion,
			promped.peso_total  = :var_peso_material + :var_peso_panel  + promped.peso_expositor ,
         promped.coste_total = :var_coste_material+ :var_coste_panel + promped.coste_expositor + :var_coste_manipulacion,   
         promped.venta_total = :var_venta_material+ :var_venta_panel + promped.venta_expositor + :var_coste_manipulacion  
   WHERE ( promped.empresa  = :codigo_empresa ) AND  
         ( promped.anyo     = :var_anyo ) AND  
         ( promped.pedido   = :var_pedido );


COMMIT;


end subroutine

public subroutine f_grabar_panel (string vpanel, decimal var_cantidad);Dec{0} var_canpantipo,var_canpantipoped
Integer registro,registro2,registros2,bien,total1,total2
String var_medidas

IF dw_control.RowCount() <> 0 Then
	IF dw_control.visible = TRUE Then
		total1 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total1"))
		total2 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total2"))
		IF total1 = total2 Then
			f_mensaje("Expositor Completo","No se pueden cargar mas lineas")
			f_activar_campo(uo_panel.em_campo)
			return
		END IF
	END IF
END IF

 // control de insertar
 
 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para insertar.")
			 Return
	End if
 End if

str_promlindetallped detalle
IF Trim(vpanel)<> "" Then
bien =0	
registro = dw_detalle.find("panel = '" + vpanel+"'" ,1,dw_detalle.RowCount())	
If registro <> 0 then
IF MessageBox("Existen mas lineas al mismo panel","¿Desea grabar la linea?",Question!,YesNo!)= 2 Then
	dw_detalle.ScrollToRow(registro)
	Return
END IF	
END IF
linped.empresa   = codigo_empresa
linped.anyo      = var_anyo
linped.pedido    = var_pedido
linped.panel     = vpanel
linped.clase_panel    = uo_clase_panel.em_codigo.text
linped.usuario_pedido = var_usuario_pedido
linped.usuario        = nombre_usuario
linped.tipo_panel     = f_tipo_panel_prompaneles(codigo_empresa,linped.panel)
IF dw_control.visible = TRUE Then
	IF reposicion= "N" Then
	 var_canpantipo = f_total_tipo_paneles_expositor(codigo_empresa,linped.tipo_expositor,linped.tipo_panel)
	ELSE
	 var_canpantipo =f_total_tipo_prompedreposicion(codigo_empresa,var_anyo,var_pedido,linped.tipo_panel)
	END IF
 IF var_canpantipo  = 0 Then
	f_mensaje("No se puede grabar la linea","Este tipo de panel no esta contemplado en el expositor: "+f_nombre_promexpositores(codigo_empresa,linped.tipo_expositor))
	f_activar_campo(uo_panel.em_campo)
	Return
 Else	
	IF linped.reposicion = "N" Then
		Select sum(cantidad) Into :var_canpantipoped From promlinped
		Where  promlinped.empresa    = :codigo_empresa
		And    promlinped.anyo          = :var_anyo
		And    promlinped.pedido        = :var_pedido
		And    promlinped.tipo_panel    = :linped.tipo_panel;
		IF var_canpantipoped >= var_canpantipo Then
			f_mensaje("No se puede grabar la linea","Expositor completo en paneles de este tipo ")
			f_activar_campo(uo_panel.em_campo)
			Return
		END IF
	END IF
 END IF
END IF
linped.cantidad  = var_cantidad
linped.situacion = "C"
Select max(promlinped.linea) Into :linped.linea From promlinped
Where  promlinped.empresa   = :codigo_empresa
And    promlinped.anyo      = :var_anyo
And    promlinped.pedido    = :var_pedido;
If IsNull(linped.linea) Then linped.linea = 0
   linped.linea = linped.linea + 1
	linped.peso_material  = f_pesomaterial_prompaneles(codigo_empresa,linped.panel)
	linped.coste_material = f_costematerial_prompaneles(codigo_empresa,linped.panel)
	linped.venta_material = f_pventamaterial_prompaneles(codigo_empresa,linped.panel)
IF linped.tipo = "2" Then
	var_medidas = f_medida_prompaneles(codigo_empresa,linped.panel)
	linped.peso_panel  = f_peso_promclasemedidas(codigo_empresa,linped.clase_panel,var_medidas)
	linped.coste_panel = f_preciocoste_promclasemedidas(codigo_empresa,linped.clase_panel,var_medidas)
	linped.venta_panel = f_precioventa_promclasemedidas(codigo_empresa,linped.clase_panel,var_medidas)
	linped.coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medidas)
	linped.cantidad= 1
ELSE
	linped.peso_panel  = f_pesopanel_promparam(codigo_empresa)
	linped.coste_panel = f_costepanel_promparam(codigo_empresa)
	linped.venta_panel = f_pventapanel_promparam(codigo_empresa)
	linped.coste_manipulacion = 0
END IF	
linped.numserie = f_numserie_promped(linped.empresa,linped.anyo,linped.pedido)
  INSERT INTO promlinped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           cliente,
			  tipo_cliente,
           pais,   
           tipo,   
           reposicion,   
           panel,   
           cantidad,   
           peso_panel,   
           coste_panel,   
           venta_panel,   
           peso_material,   
           coste_material,   
           venta_material,
			  usuario,
			  usuario_pedido,
			  situacion,
			  control_libre,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor,
			  tipo_panel,
			  clase_panel,
			  coste_manipulacion,
			  numserie,
			  cambio_composicion)  
  VALUES ( :linped.empresa,   
           :linped.anyo,   
           :linped.pedido,   
           :linped.linea,   
           :linped.cliente,   
			  :linped.tipo_cliente,
           :linped.pais,   
           :linped.tipo,   
           :linped.reposicion,   
           :linped.panel,   
           :linped.cantidad,   
           :linped.peso_panel,   
           :linped.coste_panel,   
           :linped.venta_panel,   
           :linped.peso_material,   
           :linped.coste_material,   
           :linped.venta_material,
  			  :linped.usuario,
			  :linped.usuario_pedido,
			  :linped.situacion,
  			  :linped.control_libre,
			  :linped.f_pedido,
			  :linped.f_entrega,
			  :linped.agente1,
			  :linped.agente2,
			  :linped.agente3,
			  :linped.tipo_expositor,
			  :linped.expositor,
			  :linped.tipo_panel,
  			  :linped.clase_panel,
			  :linped.coste_manipulacion,
			  :linped.numserie,
			  "N");
			  IF sqlca.SqlCode <> 0 then
				f_mensaje("Error en base de datos",sqlca.sqlerrtext)
				bien = 1
			END IF
		  
	  registros2 =  dw_proceso2.Retrieve(codigo_empresa,linped.panel)
	  IF registros2 <> 0 THEN
		FOR registro2 = 1 To registros2
			detalle.empresa = codigo_empresa
			detalle.anyo    = linped.anyo
			detalle.pedido  = linped.pedido
			detalle.linea   = linped.linea
			detalle.orden   = registro2
			detalle.panel   = linped.panel
			detalle.articulo = dw_proceso2.GetItemString(registro2,"articulo")
			detalle.calidad  = dw_proceso2.GetItemString(registro2,"calidad")
			detalle.montajeartcal  = dw_proceso2.GetItemString(registro2,"montajeartcal")
			detalle.piezas         = dw_proceso2.GetItemDecimal(registro2,"piezas")
			detalle.usuario        = linped.usuario
			detalle.usuario_pedido = linped.usuario_pedido
			detalle.observaciones=""
			detalle.peso= dw_proceso2.GetItemDecimal(registro2,"peso")
			detalle.coste= dw_proceso2.GetItemDecimal(registro2,"coste")
			detalle.venta= dw_proceso2.GetItemDecimal(registro2,"pventa")
			detalle.pais     = linped.pais
			detalle.cliente  = linped.cliente
			  INSERT INTO promlindetallped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           orden,   
           panel,   
           articulo,   
           calidad,   
           montajeartcal,   
           piezas,   
           usuario,   
           usuario_pedido,   
           observaciones,   
           peso,   
           coste,   
           venta,   
           pais,   
           cliente,
			  tipo,
			  reposicion,
			  situacion,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor)  
  VALUES ( :detalle.empresa,   
           :detalle.anyo,   
           :detalle.pedido,   
           :detalle.linea,   
           :detalle.orden,   
           :detalle.panel,   
           :detalle.articulo,   
           :detalle.calidad,   
           :detalle.montajeartcal,   
           :detalle.piezas,   
           :detalle.usuario,   
           :detalle.usuario_pedido,   
           :detalle.observaciones,   
           :detalle.peso,   
           :detalle.coste,   
           :detalle.venta,   
           :detalle.pais,   
           :detalle.cliente,
  			  :detalle.tipo,
			  :detalle.reposicion,
			  :detalle.situacion,
			  :detalle.f_pedido,
			  :detalle.f_entrega,
			  :detalle.agente1,
			  :detalle.agente2,
			  :detalle.agente3,
			  :detalle.tipo_expositor,
			  :detalle.expositor);
			  IF sqlca.Sqlcode<> 0 Then 
				   f_mensaje("Error en base de datos",SQLCA.SQLERRTEXT)
					bien = 1
					Exit
  			  END IF
		NEXT
	  END IF		
	

	If bien = 0 then
		  COMMIT;
	ELSE
		  ROLLBACK;
		  f_mensaje("Error en proceso de datos"," No se pudo grabar el detalle del expositor")
	END IF
END IF
end subroutine

event open;call super::open;istr_parametros = Message.PowerObjectParm
istr_parametros.s_titulo_ventana="Introducción lineas de pedido promocion"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_control.SetTransObject(SQLCA)
dw_detalle.SetRowFocusIndicator(Hand!)

dw_articulo.SetTransObject(SQLCA)
dw_mapa.SetTransObject(SQLCA)
dw_articulo.SetRowFocusIndicator(Hand!)

// Se controla el nivel de acceso del usuario
   acceso = f_control_acceso(nombre_usuario)

em_cantidad_panel.text = "1"

IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_pedido.text = istr_parametros.s_argumentos[3]	
     reposicion     = istr_parametros.s_argumentos[4]	
	  var_anyo   = Dec(em_anyo.text)
     var_pedido = Dec(em_pedido.text)
     istr_parametros.i_nargumentos=0
END IF

 // control campos visibles
 
 if acceso = "1" then
	 	 gb_4.visible                = TRUE
   	 cb_preparar_paneles.visible = TRUE
	    cb_preparar_panel.visible   = TRUE
	else
   	 gb_4.visible                = FALSE
   	 cb_preparar_paneles.visible = FALSE
	    cb_preparar_panel.visible   = FALSE
 End if
 
IF reposicion = "S" Then
	gb_7.visible         = True
	cb_reponer.visible   = True	
 ELSE
	gb_7.visible       = False
	cb_reponer.visible = False	
END IF

var_anyo   = Dec(em_anyo.text)
var_pedido = Dec(em_pedido.text)


Select promped.cliente,promped.pais,promped.usuario_pedido,promped.tipo, 
       promped.reposicion,promped.fpedido,promped.fentrega,
		 promped.agente1,promped.agente2,promped.agente3,promped.tipo_expositor,
		 promped.expositor,promped.clase_panel,promped.tipo_cliente
Into   :var_cliente,:var_pais,:var_usuario_pedido,:linped.tipo,
       :linped.reposicion,:linped.f_pedido,:linped.f_entrega,
		 :linped.agente1,:linped.agente2,:linped.agente3,
		 :linped.tipo_expositor,:linped.expositor,
		 :linped.clase_panel,:var_tipo_cliente
From   promped
Where  promped.empresa  = :codigo_empresa
And    promped.anyo     = :var_anyo
And    promped.pedido   = :var_pedido;

linped.cliente         = var_cliente   
linped.pais            = var_pais 
linped.usuario_pedido  = var_usuario_pedido
linped.tipo_cliente    = var_tipo_cliente

em_cliente.text = var_cliente
IF var_tipo_cliente = "N" Then
	st_nombre_cliente.text = f_nombre_vencliproforma(codigo_empresa,var_cliente)
ELSE
	st_nombre_cliente.text = f_razon_genter(codigo_empresa,"C",var_cliente)
END IF

If linped.tipo = "1" Then
	var_panel = "S"
	em_cantidad_panel.enabled     = TRUE
	dw_control.visible            = FALSE
	uo_clase_panel.visible        = FALSE
	uo_clase_panel.em_codigo.text = ""
	uo_clase_panel.em_campo.text  = ""
	volcado.visible = TRUE
 ELse
	var_panel= "N"
	em_cantidad_panel.enabled     = FALSE
	em_cantidad_panel.visible     = FALSE
	uo_clase_panel.visible        = TRUE
	em_cantidad_panel.text        = "1"
	uo_clase_panel.em_codigo.text = linped.clase_panel
	uo_clase_panel.em_campo.text  = f_nombre_clasepanel_abr(codigo_empresa,linped.clase_panel)
	st_texto_cantidad2.visible    = FALSE
	dw_control.visible            = TRUE
	volcado.visible = FALSE
END IF
uo_clase_panel.ue_valor_anterior = uo_clase_panel.em_campo.text
f_control()
f_activar_campo(uo_panel.em_campo)
end event

event close;call super::close; longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(em_pedido.text))
 criterio[3]  =  trim(em_pedido.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "promped"
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT;
 w_int_prompedidos.control_lineas = "N"

 
end event

event ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

on w_int_promliped.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_pedido=create em_pedido
this.st_3=create st_3
this.st_texto_cantidad=create st_texto_cantidad
this.st_22=create st_22
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.em_anyo=create em_anyo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.em_situacion=create em_situacion
this.st_texto_cantidad2=create st_texto_cantidad2
this.st_articulo=create st_articulo
this.em_cantidad_articulo=create em_cantidad_articulo
this.st_panel=create st_panel
this.em_cantidad_panel=create em_cantidad_panel
this.uo_articulo=create uo_articulo
this.dw_proceso2=create dw_proceso2
this.cb_grabar_articulo=create cb_grabar_articulo
this.cb_borrar_articulo=create cb_borrar_articulo
this.dw_articulo=create dw_articulo
this.cb_preparar_panel=create cb_preparar_panel
this.cb_borrar_panel=create cb_borrar_panel
this.cb_insertar_panel=create cb_insertar_panel
this.cb_preparar_paneles=create cb_preparar_paneles
this.cb_grabar_panel=create cb_grabar_panel
this.cb_seleccion_panel=create cb_seleccion_panel
this.gb_6=create gb_6
this.st_clase_panel=create st_clase_panel
this.uo_clase_panel=create uo_clase_panel
this.cb_reponer=create cb_reponer
this.gb_4=create gb_4
this.cb_insertar_articulo=create cb_insertar_articulo
this.gb_5=create gb_5
this.gb_7=create gb_7
this.volcado=create volcado
this.dw_control=create dw_control
this.uo_panel=create uo_panel
this.dw_detalle=create dw_detalle
this.dw_mapa=create dw_mapa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_pedido
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_texto_cantidad
this.Control[iCurrent+6]=this.st_22
this.Control[iCurrent+7]=this.em_cliente
this.Control[iCurrent+8]=this.st_nombre_cliente
this.Control[iCurrent+9]=this.em_anyo
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.em_situacion
this.Control[iCurrent+14]=this.st_texto_cantidad2
this.Control[iCurrent+15]=this.st_articulo
this.Control[iCurrent+16]=this.em_cantidad_articulo
this.Control[iCurrent+17]=this.st_panel
this.Control[iCurrent+18]=this.em_cantidad_panel
this.Control[iCurrent+19]=this.uo_articulo
this.Control[iCurrent+20]=this.dw_proceso2
this.Control[iCurrent+21]=this.cb_grabar_articulo
this.Control[iCurrent+22]=this.cb_borrar_articulo
this.Control[iCurrent+23]=this.dw_articulo
this.Control[iCurrent+24]=this.cb_preparar_panel
this.Control[iCurrent+25]=this.cb_borrar_panel
this.Control[iCurrent+26]=this.cb_insertar_panel
this.Control[iCurrent+27]=this.cb_preparar_paneles
this.Control[iCurrent+28]=this.cb_grabar_panel
this.Control[iCurrent+29]=this.cb_seleccion_panel
this.Control[iCurrent+30]=this.gb_6
this.Control[iCurrent+31]=this.st_clase_panel
this.Control[iCurrent+32]=this.uo_clase_panel
this.Control[iCurrent+33]=this.cb_reponer
this.Control[iCurrent+34]=this.gb_4
this.Control[iCurrent+35]=this.cb_insertar_articulo
this.Control[iCurrent+36]=this.gb_5
this.Control[iCurrent+37]=this.gb_7
this.Control[iCurrent+38]=this.volcado
this.Control[iCurrent+39]=this.dw_control
this.Control[iCurrent+40]=this.uo_panel
this.Control[iCurrent+41]=this.dw_detalle
this.Control[iCurrent+42]=this.dw_mapa
end on

on w_int_promliped.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_pedido)
destroy(this.st_3)
destroy(this.st_texto_cantidad)
destroy(this.st_22)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.em_anyo)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.em_situacion)
destroy(this.st_texto_cantidad2)
destroy(this.st_articulo)
destroy(this.em_cantidad_articulo)
destroy(this.st_panel)
destroy(this.em_cantidad_panel)
destroy(this.uo_articulo)
destroy(this.dw_proceso2)
destroy(this.cb_grabar_articulo)
destroy(this.cb_borrar_articulo)
destroy(this.dw_articulo)
destroy(this.cb_preparar_panel)
destroy(this.cb_borrar_panel)
destroy(this.cb_insertar_panel)
destroy(this.cb_preparar_paneles)
destroy(this.cb_grabar_panel)
destroy(this.cb_seleccion_panel)
destroy(this.gb_6)
destroy(this.st_clase_panel)
destroy(this.uo_clase_panel)
destroy(this.cb_reponer)
destroy(this.gb_4)
destroy(this.cb_insertar_articulo)
destroy(this.gb_5)
destroy(this.gb_7)
destroy(this.volcado)
destroy(this.dw_control)
destroy(this.uo_panel)
destroy(this.dw_detalle)
destroy(this.dw_mapa)
end on

event ue_f2;call super::ue_f2;If situacion = "PANEL" Then
	cb_insertar_panel.Triggerevent(Clicked!)
ELSE
	cb_insertar_articulo.Triggerevent(Clicked!)
END IF
end event

event ue_f4;call super::ue_f4;If situacion = "PANEL" Then
	cb_borrar_panel.Triggerevent(Clicked!)
ELSE
	cb_borrar_articulo.Triggerevent(Clicked!)
END IF
end event

event ue_f3;call super::ue_f3;If situacion = "ARTICULO" Then
	cb_grabar_articulo.Triggerevent(Clicked!)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;IF situacion = "PANEL" Then
	If dw_detalle.GetRow() = 0 Then Return
	If dw_detalle.GetRow() - 1 >= 0 Then
	   dw_detalle.ScrollToRow(dw_detalle.GetRow() - 1)
   END IF
Else
	If dw_articulo.GetRow() = 0 Then Return
	If dw_articulo.GetRow() - 1 >= 0 Then
	   dw_articulo.ScrollToRow(dw_articulo.GetRow() - 1)
   END IF
END IF
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;IF situacion = "PANEL" Then
	If dw_detalle.GetRow() = 0 Then Return
	If dw_detalle.GetRow() + 1 <= dw_detalle.RowCOunt() Then
	   dw_detalle.ScrollToRow(dw_detalle.GetRow() + 1)
   END IF
Else
	If dw_articulo.GetRow() = 0 Then Return
	If dw_articulo.GetRow() + 1 <= dw_articulo.RowCOunt() Then
	   dw_articulo.ScrollToRow(dw_articulo.GetRow() + 1)
   END IF
END IF


end event

event ue_f5;call super::ue_f5;If situacion = "PANEL" Then
	cb_seleccion_panel.Triggerevent(Clicked!)
END IF
end event

event ue_f7;call super::ue_f7;If situacion = "PANEL" Then
	cb_preparar_paneles.Triggerevent(Clicked!)
END IF
end event

event ue_f6;call super::ue_f6;If situacion = "PANEL" Then
	cb_preparar_panel.Triggerevent(Clicked!)
END IF
end event

event activate;call super::activate;w_int_promliped = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_promliped
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_promliped
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_promliped
integer x = 32
integer y = 8
integer width = 2400
integer height = 112
end type

type pb_1 from upb_salir within w_int_promliped
integer x = 2473
integer y = 12
integer width = 114
integer height = 108
integer taborder = 0
integer textsize = -8
end type

event clicked;Integer total1,total2
IF dw_control.RowCount()<>0 Then 
	total1 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total1"))
	total2 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total2"))
	IF total1 <> total2 Then
		f_mensaje("-- Aviso --","Existen paneles sin asignar al expositor")
	END IF
END IF
	CALL Super::Clicked
end event

type st_2 from statictext within w_int_promliped
integer x = 526
integer y = 140
integer width = 256
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
string text = "Pedido:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_int_promliped
integer x = 782
integer y = 144
integer width = 256
integer height = 72
integer taborder = 0
long textcolor = 128
boolean border = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

type st_3 from statictext within w_int_promliped
integer x = 59
integer y = 140
integer width = 174
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
string text = "Año :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_promliped
integer x = 827
integer y = 1468
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Piezas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_22 from statictext within w_int_promliped
integer x = 1079
integer y = 140
integer width = 247
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

type em_cliente from u_em_campo within w_int_promliped
integer x = 1335
integer y = 148
integer width = 210
integer height = 72
integer taborder = 0
integer textsize = -9
string facename = "Arial"
long textcolor = 128
boolean border = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

on modificado;call u_em_campo::modificado;  dw_detalle.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(em_pedido.text))
end on

type st_nombre_cliente from statictext within w_int_promliped
integer x = 1335
integer y = 144
integer width = 1083
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_promliped
integer x = 247
integer y = 144
integer width = 224
integer height = 72
integer taborder = 0
long textcolor = 128
boolean enabled = false
boolean border = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

type gb_1 from groupbox within w_int_promliped
integer x = 37
integer y = 96
integer width = 453
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_int_promliped
integer x = 507
integer y = 96
integer width = 544
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_int_promliped
integer x = 1061
integer y = 96
integer width = 1376
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type em_situacion from u_em_campo within w_int_promliped
boolean visible = false
integer x = 23
integer y = 1448
integer width = 123
integer taborder = 0
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_texto_cantidad2 from statictext within w_int_promliped
integer x = 1047
integer y = 528
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_articulo from statictext within w_int_promliped
integer x = 50
integer y = 1468
integer width = 777
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad_articulo from u_em_campo within w_int_promliped
integer x = 827
integer y = 1548
integer width = 270
integer taborder = 60
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = ""
end type

event getfocus;call super::getfocus;situacion= "ARTICULO"
f_control_campos()
end event

type st_panel from statictext within w_int_promliped
integer x = 41
integer y = 528
integer width = 1006
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Panel"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad_panel from u_em_campo within w_int_promliped
integer x = 1042
integer y = 604
integer width = 393
integer height = 88
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###.00"
end type

event getfocus;call super::getfocus;situacion= "PANEL"
f_control_campos()
end event

type uo_articulo from u_em_campo_2 within w_int_promliped
integer x = 50
integer y = 1548
integer width = 773
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;situacion     = "ARTICULO"
f_control_campos()
ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""




end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type dw_proceso2 from datawindow within w_int_promliped
boolean visible = false
integer x = 128
integer y = 64
integer width = 1563
integer height = 144
boolean bringtotop = true
string dataobject = "dw_proceso_prommapapaneles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_grabar_articulo from u_boton within w_int_promliped
integer x = 398
integer y = 1664
integer width = 343
integer height = 68
integer taborder = 0
string text = "F3 Modicar"
end type

event clicked;call super::clicked;f_activar_campo(uo_articulo.em_campo)
String var_articulo,var_montajeartcal,borrado
Dec{0} var_piezas,var_linea,var_orden
If dw_articulo.GetRow() = 0 Then Return
var_linea  = dw_articulo.GetItemnumber(dw_articulo.GetRow(),"linea")
var_orden  = dw_articulo.GetItemnumber(dw_articulo.GetRow(),"orden")
var_articulo  = uo_articulo.em_codigo.text
var_piezas= Dec(em_cantidad_articulo.text)
var_montajeartcal= f_componer_artcal(var_articulo,f_calidad_promparam(codigo_empresa))
If Trim(var_articulo) = "" Then Return
If var_piezas = 0 Then Return

 // control de modificar
 
 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para modificar.")
			 Return
	End if
 End if

borrado ="S"

  Select situacion Into :situacion From promlinped
  Where  empresa = :codigo_empresa
  And    anyo    = :var_anyo
  And    pedido  = :var_pedido
  And    linea  = :var_linea;
   IF situacion  = "P"  then
    f_mensaje("No se puede modificar"," El panel esta preparado")
	 borrado = "N"
  END IF
  IF borrado="S" Then
   IF situacion = "S" Then
    f_mensaje("No se puede modificar"," El panel esta servido")
	 borrado = "N"
  END IF
  END IF
  
IF borrado = "S" Then
UPdate promlinped
Set cambio_composicion = "S"
Where promlinped.empresa = :codigo_empresa
And   promlinped.anyo    = :var_anyo
And   promlinped.pedido    = :var_pedido
And   promlinped.linea   = :var_linea;
dw_detalle.SetItem(dw_detalle.GetRow(),"cambio_composicion","S")

  UPDATE promlindetallped  
     SET articulo = :var_articulo,   
         montajeartcal = :var_montajeartcal,   
         piezas = :var_piezas  
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo = :var_anyo ) AND  
         ( promlindetallped.pedido = :var_pedido ) AND  
         ( promlindetallped.linea = :var_linea ) AND  
         ( promlindetallped.orden = :var_orden )   ;
			COMMIT;
			f_calculo_linea(var_linea,var_orden)
			f_control2()


END IF

end event

type cb_borrar_articulo from u_boton within w_int_promliped
integer x = 741
integer y = 1664
integer width = 347
integer height = 68
integer taborder = 0
string text = "F4 Borrar "
end type

event clicked;call super::clicked;f_activar_campo(uo_articulo.em_campo)
Dec{0} var_linea,var_orden
String borrado
if dw_articulo.GetRow() = 0 Then Return
var_linea  = dw_articulo.GetItemNumber(dw_articulo.GetRow(),"linea")
var_orden  = dw_articulo.GetItemNumber(dw_articulo.GetRow(),"orden")


 // control de borrar
 
 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para borrar.")
			 Return
	End if
 End if

borrado ="S"

  Select situacion Into :situacion From promlinped
  Where  empresa = :codigo_empresa
  And    anyo    = :var_anyo
  And    pedido  = :var_pedido
  And    linea  = :var_linea;
   IF situacion  = "P"  then
    f_mensaje("La linea no se puede borrado"," El panel esta preparado")
	 borrado = "N"
  END IF
  IF borrado="S" Then
   IF situacion = "S" Then
    f_mensaje("La linea no se puede borrado"," El panel esta servido")
	 borrado = "N"
  END IF
  END IF
  
IF borrado = "S" Then
	UPdate promlinped
Set cambio_composicion = "S"
Where promlinped.empresa = :codigo_empresa
And   promlinped.anyo    = :var_anyo
And   promlinped.pedido    = :var_pedido
And   promlinped.linea   = :var_linea;
dw_detalle.SetItem(dw_detalle.GetRow(),"cambio_composicion","S")

Delete promlindetallped
Where  promlindetallped.empresa   = :codigo_empresa
and    promlindetallped.anyo      = :var_anyo
and    promlindetallped.pedido    = :var_pedido
and    promlindetallped.linea     = :var_linea
and    promlindetallped.orden     = :var_orden;
COMMIT;
f_control2()
f_calculo_linea(var_linea,var_orden)
uo_articulo.em_codigo.text=""
uo_articulo.em_campo.text=""
em_cantidad_articulo.text=""
END IF

end event

type dw_articulo from datawindow within w_int_promliped
event clicked pbm_dwnlbuttonclk
event rowfocuschanged pbm_dwnrowchange
integer x = 41
integer y = 916
integer width = 2217
integer height = 532
string dataobject = "dw_int_promlinped2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;If row = 0 Then Return

uo_articulo.em_codigo.text    = GetItemString(row,"articulo")
uo_articulo.em_campo.text     = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
uo_articulo.ue_valor_anterior = uo_articulo.em_campo.text
em_cantidad_articulo.text     = String(GetItemNumber(row,"piezas"))

f_activar_campo(uo_articulo.em_campo)

end event

event rowfocuschanged;If currentrow = 0 Then Return
IF this.GetRow() = 0 Then Return
uo_articulo.em_codigo.text = GetItemString(currentrow,"articulo")
uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
em_cantidad_articulo.text = String(GetItemNumber(currentrow,"piezas"))
end event

type cb_preparar_panel from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 960
integer y = 728
integer width = 466
integer height = 72
integer taborder = 0
string text = "F6 Preparar Ln "
end type

event clicked;call super::clicked;f_activar_campo(uo_panel.em_campo)
String  var_situacion,var_situ
Integer bien,registro
registro = dw_detalle.GetRow()
bien = 0
If dw_detalle.GetRow() = 0 Then Return

dec{0}  var_linea
var_linea  =  dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
var_situacion =dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion")

If var_situacion = "S" Then
	f_mensaje("Error en preparacion ","La linea ya esta servida")
	Return
END IF

If var_situacion = "C" Then
	var_situacion = "P"
Else
	var_situacion = "C"
End If
  UPDATE promlinped  
     SET situacion = :var_situacion  
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo    = :var_anyo ) AND  
         ( promlinped.pedido  = :var_pedido ) AND  
         ( promlinped.linea   = :var_linea )   ;
	UPDATE promlindetallped  
     SET situacion = :var_situacion  
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo    = :var_anyo ) AND  
         ( promlindetallped.pedido  = :var_pedido ) AND  
         ( promlindetallped.linea   = :var_linea )   ;


If Sqlca.SqlCode<>0 Then bien = 1

var_situ = f_situacion_promped_abr(codigo_empresa,var_anyo,var_pedido)
	  UPDATE promped  
     SET situacion = :var_situ
   WHERE ( promped.empresa = :codigo_empresa ) AND  
         ( promped.anyo    = :var_anyo ) AND  
         ( promped.pedido  = :var_pedido );
			If Sqlca.SqlCode<>0 Then bien = 1


If bien = 0 Then
	Commit;
Else
   RollBack;
	f_mensaje("Error en insercion de datos"," LA operacion no se actualiza")
End IF
f_control()
dw_detalle.ScrollToRow(registro)
end event

type cb_borrar_panel from u_boton within w_int_promliped
integer x = 489
integer y = 728
integer width = 443
integer height = 72
integer taborder = 0
string text = "F4 Borrar     "
end type

event clicked;call super::clicked;
Integer bien
String borrado
bien = 0
If dw_detalle.GetRow() = 0 Then Return

 // control de borrar
 
if trim(uo_panel.em_codigo.text) = "" then
      f_mensaje("! A t e n c i ó n ¡","No hay ninguna linea seleccionada.")
	   Return	
End if
if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para borrar.")
			 Return
	End if
 End if

dec{0}  var_linea
var_linea  =  dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")

borrado ="S"

  Select situacion Into :situacion From promlinped
  Where  empresa = :codigo_empresa
  And    anyo    = :var_anyo
  And    pedido  = :var_pedido
  And    linea  = :var_linea;
   IF situacion  = "P"  then
    f_mensaje("El panel no se puede borrado"," El panel esta preparado")
	 borrado = "N"
  END IF
  IF borrado="S" Then
   IF situacion = "S" Then
    f_mensaje("El panel no se puede borrado"," El panel esta servido")
	 borrado = "N"
  END IF
  END IF

IF borrado = "S" Then
Delete from promlinped
Where  promlinped.empresa = :codigo_empresa
And    promlinped.anyo    = :var_anyo
And    promlinped.pedido  = :var_pedido
And    promlinped.linea   = :var_linea;
If Sqlca.SqlCode<>0 Then bien = 1
Delete from promlindetallped
Where  promlindetallped.empresa = :codigo_empresa
And    promlindetallped.anyo    = :var_anyo
And    promlindetallped.pedido  = :var_pedido
And    promlindetallped.linea   = :var_linea;
If Sqlca.SqlCode<>0 Then bien = 1
If bien = 0 Then
	Commit;
Else
   RollBack;
	f_mensaje("Error en insercion de datos"," LA operacion no se actualiza")
End IF
dw_articulo.Reset()
f_control()

f_calculo_pedido()
END IF
uo_panel.em_codigo.text = ""
uo_panel.em_campo.text = ""
f_activar_campo(uo_panel.em_campo)
end event

type cb_insertar_panel from u_boton within w_int_promliped
integer x = 46
integer y = 728
integer width = 443
integer height = 72
integer taborder = 0
string text = "F2 Insertar "
end type

event clicked;call super::clicked;IF Dec(em_cantidad_panel.text) <= 0 Then
	f_mensaje("Error en introduccion de datos","La cantidad ha de ser mayor a cero")
	f_activar_campo(em_cantidad_panel)
	Return
END IF
f_grabar_panel(uo_panel.em_codigo.text,Dec(em_cantidad_panel.text))
f_control()
f_calculo_pedido()
dw_detalle.ScrollToRow(dw_detalle.RowCount())
f_activar_campo(uo_panel.em_campo)
end event

type cb_preparar_paneles from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 960
integer y = 800
integer width = 466
integer height = 72
integer taborder = 0
string text = "F7 Preparar To"
end type

event clicked;call super::clicked;f_activar_campo(uo_panel.em_campo)
String  var_situacion,var_situ
Integer bien
bien = 0
If dw_detalle.GetRow() = 0 Then Return

dec{0}  var_linea
var_linea  =  dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
var_situacion =dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion")
If var_situacion = "C" Then
	var_situacion = "P"
Else
	var_situacion = "C"
End If
  UPDATE promlinped  
     SET situacion = :var_situacion  
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo    = :var_anyo ) AND  
         ( promlinped.pedido  = :var_pedido )AND 
			( promlinped.situacion  <> 'S');
			
			UPDATE promlindetallped  
     SET situacion = :var_situacion  
   WHERE ( promlindetallped.empresa   = :codigo_empresa ) AND  
         ( promlindetallped.anyo      = :var_anyo ) AND  
         ( promlindetallped.pedido    = :var_pedido ) AND 
			( promlindetallped.situacion  <> 'S');



If Sqlca.SqlCode<>0 Then bien = 1


var_situ =  f_situacion_promped_abr(codigo_empresa,var_anyo,var_pedido)

	  UPDATE promped  
     SET situacion = :var_situ
   WHERE ( promped.empresa = :codigo_empresa ) AND  
         ( promped.anyo    = :var_anyo ) AND  
         ( promped.pedido  = :var_pedido );
			If Sqlca.SqlCode<>0 Then bien = 1


If bien = 0 Then
	Commit;
Else
   RollBack;
	f_mensaje("Error en base de datos"," LA operacion no se actualiza")
End IF
f_control()

end event

type cb_grabar_panel from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 46
integer y = 800
integer width = 443
integer height = 72
integer taborder = 0
string text = "F3 Modificar"
end type

event clicked;call super::clicked;IF Dec(em_cantidad_panel.text) <= 0 Then
	f_mensaje("Error en introduccion de datos","La cantidad ha de ser mayor a cero")
	f_activar_campo(em_cantidad_panel)
	Return
END IF

f_activar_campo(uo_panel.em_campo)
String codpanel,clase_panel,var_medidas,var_expositor,var_tipo_panel,var_situacion
Dec{0} var_piezas,var_linea,var_orden,ln
If dw_articulo.GetRow() = 0 Then Return
ln = dw_detalle.GetRow()
var_linea      = dw_detalle.GetItemnumber(dw_detalle.GetRow(),"linea")
var_situacion  = dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion")

 // control de modificar
 
if trim(uo_panel.em_codigo.text) = "" then
      f_mensaje("! A t e n c i ó n ¡","No hay ninguna linea seleccionada.")
	   Return	
End if

 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para modificar.")
			 Return
	End if
 End if

CHOOSE CASE var_situacion
	CASE "S"
		f_mensaje("No se puede modificar"," El panel esta servido")
      Return
	CASE "P"	
		f_mensaje("No se puede modificar"," El panel esta preparado")
      Return
END CHOOSE

codpanel       = uo_panel.em_codigo.text
clase_panel    = uo_clase_panel.em_codigo.text
var_piezas= Dec(em_cantidad_panel.text)
If var_piezas = 0 Then Return
IF var_panel = "N" Then
	var_tipo_panel = f_tipo_panel_prompaneles(codigo_empresa,codpanel)
	var_expositor  = dw_articulo.GetItemString(dw_articulo.GetRow(),"tipo_expositor")
   var_medidas = f_medida_prompaneles(codigo_empresa,linped.panel)
	linped.peso_panel  = f_peso_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
	linped.coste_panel = f_preciocoste_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
	linped.venta_panel = f_precioventa_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
	linped.coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medidas)
ELSE
	linped.peso_panel  = f_pesopanel_promparam(codigo_empresa)
	linped.coste_panel = f_costepanel_promparam(codigo_empresa)
	linped.venta_panel = f_pventapanel_promparam(codigo_empresa)
	linped.coste_manipulacion =0
END IF	

  UPDATE promlinped  
     SET cantidad     = :var_piezas , 
         panel        = :codpanel,
         clase_panel  = :clase_panel,
			peso_panel   = :linped.peso_panel,
			coste_panel  = :linped.coste_panel,
			venta_panel  = :linped.venta_panel
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo = :var_anyo ) AND  
         ( promlinped.pedido = :var_pedido ) AND  
         ( promlinped.linea = :var_linea );
			COMMIT;
			f_control()


f_calculo_pedido()
dw_detalle.ScrollToRow(ln)
end event

type cb_seleccion_panel from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 489
integer y = 800
integer width = 443
integer height = 72
integer taborder = 0
string text = "F5 Seleccion"
end type

event clicked;call super::clicked;f_activar_campo(uo_panel.em_campo)
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_in_promliped"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=String(var_anyo)
 lstr_param.s_argumentos[3]=String(var_pedido)
 lstr_param.s_argumentos[4]=String(var_panel)
 lstr_param.s_argumentos[5]=String(var_usuario_pedido)
 lstr_param.s_argumentos[6]=linped.tipo_expositor
 lstr_param.s_argumentos[7]=linped.clase_panel
 lstr_param.s_argumentos[8]=reposicion
 lstr_param.s_argumentos[9]=linped.tipo
 
 OpenWithParm(w_int_promliped2,lstr_param)
 IF Message.StringParm	= "1" Then
	f_control()
	f_calculo_pedido()
END IF

end event

type gb_6 from groupbox within w_int_promliped
integer x = 37
integer y = 692
integer width = 905
integer height = 188
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_clase_panel from statictext within w_int_promliped
integer x = 1042
integer y = 528
integer width = 393
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Clase"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_clase_panel from u_em_campo_2 within w_int_promliped
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1047
integer y = 604
integer width = 389
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_clase_panel.em_campo.text=f_nombre_clasepanel_abr(codigo_empresa,uo_clase_panel.em_codigo.text)
IF Trim(uo_clase_panel.em_campo.text)="" THEN 
 IF Trim(uo_clase_panel.em_codigo.text)<>"" Then uo_clase_panel.em_campo.SetFocus()
 uo_clase_panel.em_campo.text=""
 uo_clase_panel.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;situacion= "PANEL"
f_control_campos()
ue_titulo     = "Ayuda seleccion de clases de paneles"
ue_datawindow = "dw_ayuda_promclasepanel"



end event

on uo_clase_panel.destroy
call u_em_campo_2::destroy
end on

type cb_reponer from u_boton within w_int_promliped
event clicked pbm_bnclicked
boolean visible = false
integer x = 2071
integer y = 1360
integer width = 494
integer height = 56
integer taborder = 0
integer textsize = -7
string facename = "Small Fonts"
string text = "&Reponer"
end type

event clicked;call super::clicked;f_activar_campo(uo_panel.em_campo)
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_in_promliped"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=f_numserie_promped(codigo_empresa,var_anyo,var_pedido)
 lstr_param.s_argumentos[3]=String(var_anyo)
 lstr_param.s_argumentos[4]=String(var_pedido)
 OpenWithParm(w_int_prompedreposicion,lstr_param)
 IF Message.StringParm	= "1" Then
	dw_control.Retrieve(codigo_empresa,var_anyo,var_pedido,linped.tipo_expositor,reposicion)
 END IF

end event

type gb_4 from groupbox within w_int_promliped
integer x = 951
integer y = 692
integer width = 485
integer height = 188
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_insertar_articulo from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 64
integer y = 1664
integer width = 334
integer height = 68
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;call super::clicked;f_activar_campo(uo_articulo.em_campo)
IF dw_detalle.GetRow() = 0 Then Return

 // control de insertar
 
 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para insertar.")
			 Return
	End if
 End if

String borrado 
str_promlindetallped detalle
Integer registro
String var_empresa,formato,var_articulo,var_calidad,articulo
Dec{2} var_precio,var_cantidad

If Trim(uo_articulo.em_codigo.text) = "" Then Return
If Trim(em_cantidad_articulo.text) = "0" Then Return
registro = dw_articulo.find(" articulo='" + uo_articulo.em_codigo.text + "'",1,dw_articulo.RowCount())
If registro <> 0 Then
	dw_articulo.ScrollToRow(registro)
	f_mensaje("No puedo grabar la linea"," Existen mas lineas a este articulo")
	Return
End IF

detalle.empresa=  codigo_empresa
detalle.anyo=    var_anyo  
detalle.pedido=var_pedido
detalle.linea= dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
Select Max(orden) Into :detalle.orden From promlindetallped
Where promlindetallped.empresa  = :codigo_empresa
And   promlindetallped.anyo     = :detalle.anyo
And   promlindetallped.pedido   = :detalle.pedido
And   promlindetallped.linea    = :detalle.linea;
borrado ="S"

  Select situacion Into :situacion From promlinped
  Where  empresa = :codigo_empresa
  And    anyo    = :detalle.anyo
  And    pedido  = :detalle.pedido
  And    linea  = :detalle.linea;
   IF situacion  = "P"  then
    f_mensaje("No se puede insertar lineas"," El panel esta preparado")
	 borrado = "N"
   END IF
   IF borrado="S" Then
      IF situacion = "S" Then
         f_mensaje("No se pueden insertar lineas"," El panel esta servido")
      	borrado = "N"
      END IF
   END IF
  
IF borrado = "S" Then
IF IsNUll(detalle.orden) Then detalle.orden = 0
detalle.orden     = detalle.orden + 1
detalle.panel     = dw_detalle.GetItemString(dw_detalle.GetRow(),"panel")
detalle.articulo  = uo_articulo.em_codigo.text
detalle.calidad   = f_calidad_promparam(codigo_empresa)
detalle.montajeartcal=f_componer_artcal(detalle.articulo,detalle.calidad)
detalle.piezas   = Dec(em_cantidad_articulo.text)
detalle.usuario  = nombre_usuario
detalle.usuario_pedido = var_usuario_pedido
detalle.observaciones  = ""
detalle.peso  = 0 
detalle.coste = 0
detalle.venta = 0
formato = f_formato_articulo(codigo_empresa,detalle.articulo)
detalle.peso    = f_peso_articulo(codigo_empresa,detalle.articulo)
  SELECT almartcal.empresa,almartcal.articulo,   
         almartcal.calidad, almartcal.precio  
    INTO :var_empresa,:var_articulo,   
         :var_calidad,:var_precio  
    FROM almartcal  
   WHERE ( almartcal.empresa = :codigo_empresa ) AND  
         ( almartcal.articulo = :detalle.articulo ) AND  
         ( almartcal.calidad = :detalle.calidad )   ;

  SELECT articulos.empresa,   
         articulos.codigo,   
         articulos.precio_coste  
    INTO :var_empresa,   
         :var_articulo,   
         :detalle.coste  
    FROM articulos  
   WHERE ( articulos.empresa = :codigo_empresa ) AND  
         ( articulos.codigo = :articulo )   ;

IF IsNull(detalle.coste)  Then detalle.coste = 0
IF IsNull(detalle.peso)   Then detalle.peso = 0
IF IsNull(detalle.venta)  Then detalle.venta = 0
detalle.venta  = &
f_precio_articulo_venlintarifas(codigo_empresa,&
                           	  f_tarifa_promparam(codigo_empresa),&
								        f_activa_ventarifas(codigo_empresa,f_tarifa_promparam(codigo_empresa)),&
										  detalle.articulo,f_calidad_promparam(codigo_empresa)) * var_cantidad
var_cantidad = f_conversion_piezas_cantidad_bis(codigo_empresa,detalle.articulo,detalle.piezas)										  
detalle.coste   = detalle.coste  *  var_cantidad
detalle.peso    = detalle.peso   *  detalle.piezas
detalle.venta   = detalle.venta 


detalle.pais           =  linped.pais
detalle.cliente        =  linped.cliente
detalle.tipo           =  linped.tipo
detalle.reposicion     =  linped.reposicion
detalle.situacion      =  "C"
detalle.f_pedido       =  linped.f_pedido
detalle.f_entrega      =  linped.f_entrega
detalle.agente1        =  linped.agente1
detalle.agente2        =  linped.agente2
detalle.agente3        =  linped.agente3
detalle.tipo_expositor =  linped.tipo_expositor
detalle.expositor      =  linped.expositor
UPdate promlinped
Set cambio_composicion = "S"
Where promlinped.empresa = :detalle.empresa
And   promlinped.anyo    = :detalle.anyo
And   promlinped.pedido    = :detalle.pedido
And   promlinped.linea   = :detalle.linea;
dw_detalle.SetItem(dw_detalle.GetRow(),"cambio_composicion","S")


  INSERT INTO promlindetallped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           orden,   
           panel,   
           articulo,   
           calidad,   
           montajeartcal,   
           piezas,   
           usuario,   
           usuario_pedido,   
           observaciones,   
           peso,   
           coste,   
           venta,   
           pais,   
           cliente,
			  tipo,
			  reposicion,
			  situacion,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor)  
  VALUES ( :detalle.empresa,   
           :detalle.anyo,   
           :detalle.pedido,   
           :detalle.linea,   
           :detalle.orden,   
           :detalle.panel,   
           :detalle.articulo,   
           :detalle.calidad,   
           :detalle.montajeartcal,   
           :detalle.piezas,   
           :detalle.usuario,   
           :detalle.usuario_pedido,   
           :detalle.observaciones,   
           :detalle.peso,   
           :detalle.coste,   
           :detalle.venta,   
           :detalle.pais,   
           :detalle.cliente,
			  :detalle.tipo,
			  :detalle.reposicion,
			  :detalle.situacion,
			  :detalle.f_pedido,
			  :detalle.f_entrega,
			  :detalle.agente1,
			  :detalle.agente2,
			  :detalle.agente3,
			  :detalle.tipo_expositor,
			  :detalle.expositor)  ;

COMMIT;
f_calculo_linea(detalle.linea,detalle.orden)
f_control2()
END IF

end event

type gb_5 from groupbox within w_int_promliped
integer x = 55
integer y = 1628
integer width = 1042
integer height = 112
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_int_promliped
boolean visible = false
integer x = 2062
integer y = 1328
integer width = 512
integer height = 96
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type volcado from u_boton within w_int_promliped
event clicked pbm_bnclicked
integer x = 1440
integer y = 800
integer width = 366
integer height = 76
integer taborder = 0
string text = "Volcar Mapa"
end type

event clicked;call super::clicked;f_activar_campo(uo_panel.em_campo)
IF dw_mapa.Retrieve(codigo_empresa) <> 0 Then
	dw_mapa.visible=TRUE
END IF
end event

type dw_control from datawindow within w_int_promliped
boolean visible = false
integer x = 1435
integer y = 1056
integer width = 347
integer height = 384
string dataobject = "dw_int_promlinped5"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type uo_panel from u_em_campo_2 within w_int_promliped
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 41
integer y = 608
integer width = 1001
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_panel.em_campo.text=f_nombre_prompaneles(codigo_empresa,uo_panel.em_codigo.text)
IF Trim(uo_panel.em_campo.text)="" THEN 
 IF Trim(uo_panel.em_codigo.text)<>"" Then uo_panel.em_campo.SetFocus()
 uo_panel.em_campo.text  = ""
 uo_panel.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;situacion= "PANEL"
f_control_campos()
ue_titulo     = "Ayuda seleccion de paneles"

If linped.tipo= "1" Then
	ue_datawindow = "dw_ayuda_prompaneles_mano"
  ue_filtro     = ""
Else
	ue_datawindow = "dw_ayuda_prompaneles_expositor"
  ue_filtro     = "promlinexpositores_codigo= '" + linped.tipo_expositor + "'"
End if


end event

on uo_panel.destroy
call u_em_campo_2::destroy
end on

type dw_detalle from datawindow within w_int_promliped
integer x = 41
integer y = 252
integer width = 1856
integer height = 260
boolean bringtotop = true
string dataobject = "dw_int_promlinped1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;If row = 0 Then Return
uo_panel.em_codigo.text = dw_detalle.GetItemString(row,"panel")
uo_panel.em_campo.text  = f_nombre_prompaneles(codigo_empresa,uo_panel.em_codigo.text)

uo_clase_panel.em_codigo.text = dw_detalle.GetItemString(row,"clase_panel")
uo_clase_panel.em_campo.text  = f_nombre_clasepanel(codigo_empresa,uo_clase_panel.em_codigo.text)
uo_panel.TriggerEvent("modificado")
em_cantidad_panel.text  = String(dw_detalle.GetItemNumber(row,"cantidad"))
f_control2()
uo_panel.ue_valor_anterior = uo_panel.em_campo.text
f_activar_campo(uo_panel.em_campo)
end event

event rowfocuschanged;f_control2()

end event

type dw_mapa from datawindow within w_int_promliped
boolean visible = false
integer x = 1042
integer y = 252
integer width = 1810
integer height = 792
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_int_promlinped8"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "salir" Then
	Reset()
	visible= FALSE
END IF
end event

event doubleclicked;IF MessageBox("Proceso Volcado mapa paneles","¿Desea Volcar el mapa "+GetItemSTring(row,"descripcion")+"?",Question!,YesNo!) = 1 Then
Integer r , r1
DataStore d
String sel
sel = " Select panel,cantidad from promlinmapa "+&
		" Where  empresa = '"+codigo_empresa+"'"+&
		" And    codigo  = '"+GetItemSTring(row,"codigo")+"'"
d = f_cargar_cursor2(sel)
r1 = d.RowCount()
IF r1 = 0 Then Return
For r = 1 To r1
	f_grabar_panel(d.GetItemSTring(r,"panel"),d.GetItemNumber(r,"cantidad"))
	f_mensaje_proceso("Volcando:("+f_nombre_prompaneles(codigo_empresa,d.GetItemSTring(r,"panel"))+")",r,r1)
Next
REset()
visible= false
f_control()
f_calculo_pedido()
END IF

end event

