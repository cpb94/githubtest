$PBExportHeader$w_int_deplinalb.srw
forward
global type w_int_deplinalb from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_deplinalb
end type
type st_3 from statictext within w_int_deplinalb
end type
type st_texto_cantidad from statictext within w_int_deplinalb
end type
type st_pallets from statictext within w_int_deplinalb
end type
type st_total_cajas from statictext within w_int_deplinalb
end type
type st_cajas from statictext within w_int_deplinalb
end type
type st_tipopallet from statictext within w_int_deplinalb
end type
type st_calidad from statictext within w_int_deplinalb
end type
type st_articulo from statictext within w_int_deplinalb
end type
type em_t_pallets from u_em_campo within w_int_deplinalb
end type
type em_cajas from u_em_campo within w_int_deplinalb
end type
type em_t_cajas from u_em_campo within w_int_deplinalb
end type
type uo_articulo from u_em_campo_2 within w_int_deplinalb
end type
type uo_calidad from u_em_campo_2 within w_int_deplinalb
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_deplinalb
end type
type st_texto_mtrslinieales from statictext within w_int_deplinalb
end type
type em_mtrs_lineales from u_em_campo within w_int_deplinalb
end type
type em_cliente from u_em_campo within w_int_deplinalb
end type
type st_nombre_cliente from statictext within w_int_deplinalb
end type
type cb_grabar from u_boton within w_int_deplinalb
end type
type cb_borrar from u_boton within w_int_deplinalb
end type
type st_texto_precio from statictext within w_int_deplinalb
end type
type em_precio from u_em_campo within w_int_deplinalb
end type
type em_descripcion from u_em_campo within w_int_deplinalb
end type
type st_33 from statictext within w_int_deplinalb
end type
type cb_insertar from u_boton within w_int_deplinalb
end type
type uo_tipolinea from u_em_campo_2 within w_int_deplinalb
end type
type st_tplinea from statictext within w_int_deplinalb
end type
type cb_stock from u_boton within w_int_deplinalb
end type
type cb_reservas from u_boton within w_int_deplinalb
end type
type st_dto from statictext within w_int_deplinalb
end type
type em_descuento from u_em_campo within w_int_deplinalb
end type
type st_1 from statictext within w_int_deplinalb
end type
type dw_pie from datawindow within w_int_deplinalb
end type
type dw_detalle from datawindow within w_int_deplinalb
end type
type em_anyo from u_em_campo within w_int_deplinalb
end type
type gb_3 from groupbox within w_int_deplinalb
end type
type em_situacion from u_em_campo within w_int_deplinalb
end type
type gb_4 from groupbox within w_int_deplinalb
end type
type cb_valorar from u_boton within w_int_deplinalb
end type
type em_albaran from u_em_campo within w_int_deplinalb
end type
type st_4 from statictext within w_int_deplinalb
end type
type st_5 from statictext within w_int_deplinalb
end type
type st_peso_linea from statictext within w_int_deplinalb
end type
type gb_1 from groupbox within w_int_deplinalb
end type
type st_2 from statictext within w_int_deplinalb
end type
type em_porcentaje from u_em_campo within w_int_deplinalb
end type
type st_proforma from dropdownlistbox within w_int_deplinalb
end type
type st_6 from statictext within w_int_deplinalb
end type
type st_peso_total from statictext within w_int_deplinalb
end type
type st_7 from statictext within w_int_deplinalb
end type
type st_tono from statictext within w_int_deplinalb
end type
type em_tono from u_em_campo within w_int_deplinalb
end type
type st_calibre from statictext within w_int_deplinalb
end type
type em_calibre from u_em_campo within w_int_deplinalb
end type
type gb_2 from groupbox within w_int_deplinalb
end type
type dw_stock from datawindow within w_int_deplinalb
end type
type st_caja from statictext within w_int_deplinalb
end type
type uo_caja from u_em_campo_2 within w_int_deplinalb
end type
type em_cantidad from u_em_campo within w_int_deplinalb
end type
end forward

global type w_int_deplinalb from w_int_con_empresa
integer width = 2930
integer height = 1660
pb_1 pb_1
st_3 st_3
st_texto_cantidad st_texto_cantidad
st_pallets st_pallets
st_total_cajas st_total_cajas
st_cajas st_cajas
st_tipopallet st_tipopallet
st_calidad st_calidad
st_articulo st_articulo
em_t_pallets em_t_pallets
em_cajas em_cajas
em_t_cajas em_t_cajas
uo_articulo uo_articulo
uo_calidad uo_calidad
uo_tipo_pallet uo_tipo_pallet
st_texto_mtrslinieales st_texto_mtrslinieales
em_mtrs_lineales em_mtrs_lineales
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
cb_grabar cb_grabar
cb_borrar cb_borrar
st_texto_precio st_texto_precio
em_precio em_precio
em_descripcion em_descripcion
st_33 st_33
cb_insertar cb_insertar
uo_tipolinea uo_tipolinea
st_tplinea st_tplinea
cb_stock cb_stock
cb_reservas cb_reservas
st_dto st_dto
em_descuento em_descuento
st_1 st_1
dw_pie dw_pie
dw_detalle dw_detalle
em_anyo em_anyo
gb_3 gb_3
em_situacion em_situacion
gb_4 gb_4
cb_valorar cb_valorar
em_albaran em_albaran
st_4 st_4
st_5 st_5
st_peso_linea st_peso_linea
gb_1 gb_1
st_2 st_2
em_porcentaje em_porcentaje
st_proforma st_proforma
st_6 st_6
st_peso_total st_peso_total
st_7 st_7
st_tono st_tono
em_tono em_tono
st_calibre st_calibre
em_calibre em_calibre
gb_2 gb_2
dw_stock dw_stock
st_caja st_caja
uo_caja uo_caja
em_cantidad em_cantidad
end type
global w_int_deplinalb w_int_deplinalb

type variables
string filtro,bloqueado
Integer bien,ante_pallets,ante_cajas
decimal{2} ante_valor
String  tipo // I-> inserción , M -> Modificación
Dec{0}  linea_albaran
String  cod_tipo_unidad,cod_formato,cod_familia,var_control_alm,var_sector,var_clase,control_incremento
String articulo_ant,calidad_ant,tipolinea_ant,referencia_ant,tipopallet_ant
Dec{2} precio_ant,ante_existencias
str_venalb venalb
String campo_actual,var_situacion
Integer tipo_precio
end variables

forward prototypes
public subroutine f_grabar_linea ()
public subroutine f_borrar_linea ()
public subroutine f_botones ()
public subroutine f_calculo_precio ()
public subroutine f_consulta_disponible ()
public subroutine f_activar_primer_campo ()
public subroutine f_consulta_reservas ()
public subroutine f_campos_segun_tiplin ()
public subroutine f_control ()
public subroutine f_peso_linea ()
public subroutine f_recalcular_lineas ()
public function boolean f_salida_almacen (string empresa, string almacen, string referencia, string tipo_pallet, string caja, decimal cantidad)
public function boolean f_entrada_almacen (string empresa, string almacen, string referencia, string tipo_pallet, decimal cantidad, string tipo_caja)
public subroutine f_calculo_precio_ant ()
end prototypes

public subroutine f_grabar_linea ();
str_venlialb linalb
str_venalb   ped 
SetNull(linalb.anyo_ent)
SetNull(linalb.nummov_ent)
SetNull(linalb.anyo_sal)
SetNull(linalb.nummov_sal)
SetNull(linalb.fila_ent)
SetNull(linalb.altura_ent)
SetNull(linalb.operario_prepa)
Dec{0}  ultima,albaran,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
int periodo
periodo   =  Integer(em_anyo.text)
albaran   =  Dec(em_albaran.text)

linalb.albaran_deposito   = 'S'


IF tipo = "M" Then
  SELECT venlialb.precio_estand,   
         venlialb.orden_preparacion,   
         venlialb.cantidad_prepa,   
         venlialb.es_pico,   
         venlialb.numero_pico,   
         venlialb.anyo_ent,   
         venlialb.nummov_ent,   
         venlialb.anyo_sal,   
         venlialb.nummov_sal,   
         venlialb.fila_ent,   
         venlialb.altura_ent,   
         venlialb.operario_prepa,   
         venlialb.almacen_ent,   
         venlialb.precio_aduana,   
         venlialb.precio  
    INTO :linalb.precio_estand,   
         :linalb.orden_preparacion,   
         :linalb.cantidad_prepa,   
         :linalb.es_pico,   
         :linalb.numero_pico,   
         :linalb.anyo_ent,   
         :linalb.nummov_ent,   
         :linalb.anyo_sal,   
         :linalb.nummov_sal,   
         :linalb.fila_ent,   
         :linalb.altura_ent,   
         :linalb.operario_prepa,   
         :linalb.almacen_ent,   
         :linalb.precio_aduana,   
         :linalb.precio  
   	From venlialb
	WHERE  venlialb.empresa   = :codigo_empresa
	  AND  venlialb.anyo      = :periodo  
	  AND  venlialb.albaran   = :albaran
	  AND  venlialb.linea     = :linea_albaran   ;
	IF sqlca.Sqlcode <> 0 Then f_mensaje("Error en base de datos(venlialb)"+string(sqlca.Sqlcode),Sqlca.SqlErrText)
End if
linalb.control_incremento = control_incremento 
IF Trim(linalb.control_incremento) = "" or IsNull(linalb.control_incremento) Then
 	linalb.control_incremento = "S"
END IF	

IF tipo ="I" THEN
 ultima =  0
 Select max(venlialb.linea) Into :ultima From venlialb
 Where  venlialb.empresa   =   :codigo_empresa
 And    venlialb.anyo      =   :periodo
 And    venlialb.albaran    =   :albaran;
 IF sqlca.Sqlcode <> 0 Then f_mensaje("Error selección ultima linea(venlialb)",Sqlca.SqlErrText)
 IF ISNull(ultima) Then ultima=0
 ultima = ultima +1
END IF

linalb.empresa   = venalb.empresa
linalb.anyo      = venalb.anyo
linalb.albaran   = venalb.albaran
linalb.falbaran  = venalb.falbaran
linalb.cliente   = venalb.cliente
linalb.tipoiva   = venalb.tipoiva
linalb.iva       = venalb.iva
linalb.divisa    = venalb.divisa
linalb.serie     = venalb.serie
linalb.zona      = venalb.zona
linalb.agente1   = venalb.agente1
linalb.agente2   = venalb.agente2
linalb.agente3   = venalb.agente3
linalb.comision11= venalb.comision1
linalb.comision12= venalb.comision11
linalb.comision21= venalb.comision2
linalb.comision22= venalb.comision22
linalb.comision31= venalb.comision31
linalb.comision32= venalb.comision32
linalb.linea     = ultima
linalb.articulo  = uo_articulo.em_codigo.text
linalb.clase     = var_clase
linalb.sector    = var_sector
linalb.tonochar  = Trim(em_tono.text)
linalb.calibre    = Dec(em_calibre.text)
IF Isnull(linalb.tonochar)    Then linalb.tonochar    = ""
IF Isnull(linalb.calibre) Then linalb.calibre = 0


SELECT articulos.empresa,articulos.codigo,articulos.familia,
       articulos.formato,articulos.modelo,articulos.unidad,articulos.pesopieza
INTO   :linalb.empresa,:linalb.articulo,:linalb.familia,:linalb.formato,
       :linalb.modelo,:linalb.tipo_unidad,:linalb.peso    
FROM articulos  
WHERE (articulos.empresa = :codigo_empresa )
AND   (articulos.codigo = :linalb.articulo );



linalb.calidad         = uo_calidad.em_codigo.text
IF tipo_precio = 1 Then
	linalb.precio       			   = Dec(em_precio.text)
ELSE
	linalb.precio_aduana          = Dec(em_precio.text)
END IF
linalb.precio_estand   = f_precio_articulo(linalb.empresa,linalb.cliente,linalb.articulo,linalb.calidad,f_tarifa_venalb(linalb.empresa,linalb.anyo,linalb.albaran))
linalb.cantidad        = Dec(em_cantidad.text)
linalb.pallets         = Integer(em_t_pallets.text)
linalb.total_cajas     = Integer(em_t_cajas.text)
linalb.cajas           = Integer(em_cajas.text)
linalb.dtocomer        = 0
If IsNull(em_descuento.text) or Trim(em_descuento.text) ="" THEN
   em_descuento.text ="0"
END IF
linalb.dtoesp          = Dec(em_descuento.text)
linalb.descripcion     = em_descripcion.text


  SELECT familias.linea INTO :linalb.linfab FROM familias  
   WHERE ( familias.empresa = :codigo_empresa ) AND  
         ( familias.codigo = :linalb.familia )   ;
String   var_tipoter
SELECT genter.empresa,genter.tipoter,genter.codigo,genter.pais,
       genter.provincia  
INTO   :ped.empresa,:var_tipoter,:ped.cliente,:linalb.pais,:linalb.provincia  
FROM   genter  
WHERE (genter.empresa = :codigo_empresa)
AND   (genter.tipoter = 'C' )
AND   (genter.codigo = :linalb.cliente )   ;

linalb.tipolinea       = uo_tipolinea.em_codigo.text
linalb.texto1          = ""
linalb.texto2          = ""
linalb.texto3          = ""
linalb.referencia      = f_componer_ref(linalb.articulo,linalb.calidad,linalb.tonochar,linalb.calibre)
linalb.montajeartcal   = f_componer_artcal(linalb.articulo,linalb.calidad)
linalb.situacion       = em_situacion.text
linalb.metros_lineales = Dec(em_mtrs_lineales.text)
linalb.falta           = Datetime(today())
linalb.usuario         = nombre_usuario
linalb.tipo_pallet     = uo_tipo_pallet.em_codigo.text
linalb.caja            = uo_caja.em_codigo.text
linalb.deposito        = "N"
IF tipo="M" THEN
	DELETE FROM venlialb  
   WHERE venlialb.empresa   = :linalb.empresa
	AND   venlialb.anyo      = :linalb.anyo 
	AND   venlialb.albaran  = :linalb.albaran 
	AND   venlialb.linea   = :linea_albaran ;
	IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error borrando linea(Venlialb)",sqlca.sqlerrtext)
     linalb.linea   = linea_albaran
END IF


 IF var_control_alm = "N" Then 
    SetNull(linalb.articulo)
    SetNull(linalb.formato)
    SetNull(linalb.modelo)
    SetNull(linalb.calidad)
    SetNull(linalb.tonochar)
    SetNull(linalb.calibre)
    SetNull(linalb.pallets)
    SetNull(linalb.total_cajas)
    SetNull(linalb.cajas)
    SetNull(linalb.linfab)
    SetNull(linalb.referencia)
    SetNull(linalb.montajeartcal)
    SetNull(linalb.tipo_pallet)
    SetNull(linalb.caja)
    linalb.tipo_unidad = "0"
  END IF
SetNull(linalb.orden_preparacion)
  linalb.cantidad_prepa = 0
  IF linalb.pallets = 0 or IsNull(linalb.pallets) Then
	    linalb.es_pico = "S"
  ELSE		 
	    linalb.es_pico = "N"
  END IF	
  parcial_cajas = 0
  parcial_cantidad = 0
  IF var_situacion<> "P" Then
    IF linalb.es_pico = "N" Then
	 IF linalb.tipo_unidad = "0" Then
			  parcial_cantidad  =  linalb.cantidad - (f_piezascaja_articulo(linalb.empresa,linalb.articulo,linalb.caja)*f_cajaspallet_palarticulo(linalb.empresa,linalb.articulo,linalb.tipo_pallet,linalb.caja))
		  	  parcial_cajas     =  linalb.cajas
	 Else
  	   	  parcial_cantidad  =  linalb.cajas *  f_metroscaja_articulo(linalb.empresa,linalb.articulo,linalb.caja)
		  	  parcial_cajas     =  linalb.cajas
    END IF		
	 linalb.cajas = 0
	 linalb.total_cajas = linalb.total_cajas - parcial_cajas
	 linalb.cantidad = linalb.cantidad - parcial_cantidad
  END IF	
  END IF
  If linalb.control_incremento = "S" Then 
	 If linalb.pallets >1 Then linalb.control_incremento = "N"
  END IF	
  
  f_insertar_venlialb(linalb)

  IF parcial_cantidad <> 0 then
    ultima =  0
    Select max(venlialb.linea) Into :ultima From venlialb
    Where  venlialb.empresa   =   :codigo_empresa
    And    venlialb.anyo      =   :periodo
    And    venlialb.albaran    =   :albaran;
    IF ISNull(ultima) Then ultima=0
    ultima = ultima +1
	 linalb.pallets = 0
	 linalb.total_cajas = parcial_cajas
 	 linalb.cajas       = parcial_cajas
  	 linalb.cantidad    = parcial_cantidad
	 linalb.linea       = ultima
	 linalb.es_pico         ="S"
    f_insertar_venlialb(linalb)
  END IF	 

COMMIT;
f_actualizar_venalbaran(codigo_empresa,periodo,albaran)

end subroutine

public subroutine f_borrar_linea ();Dec{0}periodo,albaran

periodo = Dec(em_anyo.text)
albaran  = Dec(em_albaran.text)

   DELETE FROM venlialb 
   WHERE ( venlialb.empresa = :codigo_empresa ) AND  
         ( venlialb.anyo    = :periodo ) AND  
         ( venlialb.albaran  = :albaran ) AND  
         ( venlialb.linea   = :linea_albaran )   ;

COMMIT;

f_actualizar_venalbaran(codigo_empresa,periodo,albaran)
end subroutine

public subroutine f_botones ();IF tipo_precio = 2 Then
	IF tipo = "I" Then
		cb_grabar.enabled   = FALSE		
	ELSE
		cb_grabar.enabled   = TRUE
	END IF
  	cb_borrar.enabled   = FALSE
	cb_insertar.enabled = FALSE
	cb_reservas.enabled = FALSE
	cb_stock.enabled    = FALSE
	cb_valorar.enabled  = FALSE
	Return
END IF

If tipo = "I" Then 
  cb_insertar.enabled = FALSE
  cb_borrar.enabled   = FALSE
End If



IF tipo_precio = 2 then
	IF tipo = "I" Then
		cb_grabar.enabled = FALSE
	END IF
	cb_grabar.enabled   = TRUE
  	cb_borrar.enabled   = FALSE
	cb_insertar.enabled = FALSE
	cb_reservas.enabled = FALSE
	cb_stock.enabled    = FALSE
	cb_valorar.enabled  = FALSE
END IF

If tipo = "M" Then
  cb_insertar.enabled = TRUE
  cb_borrar.enabled   = TRUE
End If
end subroutine

public subroutine f_calculo_precio ();string codpais,mascara
Dec incre,incre2
Integer t_pallets
Dec{4}  t_cantidad,dto,v_precio_esp,v_precio_tarifa,v_pre,v_precio_esp_tar
IF IsNull(uo_articulo.em_codigo.text) or Trim(uo_articulo.em_codigo.text)= "" Then Return 
IF IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text)= "" Then Return 

mascara = f_mascara_precios_moneda(venalb.divisa)

dto = 0
em_descuento.text = "0"

v_precio_esp_tar = f_precio_articulo_esp_tar(codigo_empresa,venalb.tarifa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)

IF v_precio_esp_tar <> 0 Then
	dto = 0
	em_descuento.text = "0"
	//em_precio.text = String(v_precio_esp_tar,f_mascara_moneda(venped.divisa))		
	em_precio.text = String(v_precio_esp_tar,mascara)		
ELSE
	v_precio_esp     = f_precio_articulo_especial(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
	
	v_precio_tarifa  = f_precio_articulo_venlintarifas_activa(codigo_empresa,venalb.tarifa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
	
	dto   = f_dto_cliente_articulo(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Dec(em_t_pallets.text))
	if dto = 0 then
			dto   = f_dto_tarifa_articulo(codigo_empresa, venalb.tarifa, uo_articulo.em_codigo.text, uo_calidad.em_codigo.text, Dec(em_t_pallets.text))
	end if
	
	//v_pre = Dec(String(v_precio_tarifa - (v_precio_tarifa * dto/100),f_mascara_moneda(venped.divisa)))
	v_pre = Dec(String(v_precio_tarifa - (v_precio_tarifa * dto/100),mascara))
	
	em_descuento.text = String(dto)
	if f_serie_venclientes(codigo_empresa,em_cliente.text)="1" then
		IF v_precio_esp = 0 or isnull(v_precio_esp) Then
			em_precio.text = string(v_precio_tarifa)
		Else
			//em_precio.text = String(v_precio_esp,f_mascara_moneda(venped.divisa))		
			em_precio.text = String(v_precio_esp,mascara)		
		END IF
	Else
		IF v_precio_esp = 0 Then
			em_precio.text = string(v_precio_tarifa)
		Else
			//em_precio.text = String(v_precio_esp,f_mascara_moneda(venped.divisa))		
			em_precio.text = String(v_precio_esp,mascara)		
		END IF
	End if		
END IF

codpais = f_pais_genter(codigo_empresa,"C",em_cliente.text)  
IF Dec(em_precio.text) <> 0 AND Not IsNull(em_precio.text)Then
t_pallets   = Integer(em_t_pallets.text)
t_cantidad  = Dec(em_cantidad.text)
IF IsNull(t_pallets) Then t_pallets=0
IF t_pallets <1 and t_cantidad <>0 Then 
incre  = f_incremento_pallet_cliente(codigo_empresa,em_cliente.text)
incre2 = f_incremento_precio(codigo_empresa,cod_familia,uo_calidad.em_codigo.text,Dec(em_precio.text),codpais)
IF incre<> 0 and incre2 <> dec(em_precio.text) Then incre2 = incre + Dec(em_precio.text)
em_precio.text= String(incre2)
End IF  
END IF
precio_ant = Dec(em_precio.text)

end subroutine

public subroutine f_consulta_disponible ();str_parametros str
str.s_argumentos[1]= "w_int_venliped"
str.s_argumentos[2]= uo_articulo.em_codigo.text
str.s_argumentos[3]= uo_calidad.em_codigo.text
str.s_argumentos[6]= uo_tipo_pallet.em_codigo.text
CHOOSE CASE campo_actual
	CASE "ARTICULO"
     str.s_argumentos[3]= ""
     str.s_argumentos[4]= ""
     str.s_argumentos[5]= ""
     str.s_argumentos[6]= ""
   CASE "CALIDAD"
     str.s_argumentos[4]= ""
     str.s_argumentos[5]= ""
     str.s_argumentos[6]= ""
END CHOOSE

str.i_nargumentos = 6
OpenWithParm(w_con_stock_articulos,str)

end subroutine

public subroutine f_activar_primer_campo ();em_precio.enabled = TRUE
uo_tipolinea.enabled = TRUE
uo_articulo.enabled = TRUE

IF tipo= "M" Then	 
	IF var_situacion	 = "P" Then
	   f_activar_campo(em_precio)
		Return
	END IF
END IF
IF tipo_precio = 2 Then
	f_activar_campo(em_precio)
	Return
END IF
f_activar_campo(uo_articulo.em_campo)


end subroutine

public subroutine f_consulta_reservas ();str_parametros str
str.s_argumentos[1]= "w_int_venlialb"
str.s_argumentos[2]= uo_articulo.em_codigo.text
str.s_argumentos[3]= uo_calidad.em_codigo.text
str.s_argumentos[6]= uo_tipo_pallet.em_codigo.text
str.i_nargumentos = 6
OpenWithParm(w_con_reservas_articulos,str)

end subroutine

public subroutine f_campos_segun_tiplin ();	 uo_tipolinea.enabled            = TRUE
 	 em_cantidad.enabled            = TRUE
IF( tipo= "M"  and  var_situacion	 = "P") or tipo_precio = 2 Then
	  	 em_cajas.enabled               = FALSE
	    em_calibre.enabled             = FALSE
	    em_mtrs_lineales.enabled       = FALSE
	    em_t_cajas.enabled             = FALSE
	    em_t_pallets.enabled           = FALSE
	    em_tono.enabled                = FALSE
	    uo_calidad.enabled             = FALSE
	    uo_tipo_pallet.enabled         = FALSE
		 uo_caja.enabled                = FALSE
	    uo_articulo.enabled            = FALSE
		 uo_tipolinea.enabled           = FALSE
	 	 em_cantidad.enabled            = FALSE
		 Return
	END IF


Boolean  sino,sino_articulo
String   var_empresa,var_codigo
String cod_tiplin

var_sector  = f_sector_familia(codigo_empresa,cod_familia)
cod_tiplin  = uo_tipolinea.em_codigo.text 
var_control_alm ="N"
SELECT  ventipolin.control_almacen INTO :var_control_alm  
FROM   ventipolin  
WHERE (ventipolin.empresa = :codigo_empresa)
AND   (ventipolin.codigo  = :cod_tiplin);

CHOOSE CASE var_control_alm
	CASE "S"
          sino = TRUE
          sino_articulo= TRUE
    CASE "N"
        em_descripcion.text     = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
        st_texto_cantidad.text = "Unidades"
        sino = FALSE
        sino_articulo = FALSE
	CASE ELSE
        Return
END CHOOSE
IF var_control_alm ="S" and var_sector = "N" Then
   sino_articulo = TRUE
   sino          = FALSE
END IF
    em_cajas.enabled               = sino
    em_calibre.enabled             = sino
    em_mtrs_lineales.enabled       = sino
    em_t_cajas.enabled             = sino
    em_t_pallets.enabled           = sino
    em_tono.enabled                = sino
    uo_calidad.enabled             = sino
    uo_tipo_pallet.enabled         = sino
	 uo_caja.enabled                = sino
    uo_articulo.enabled            = sino_articulo




    IF var_control_alm = "S" THEN
      IF trim(uo_articulo.em_codigo.text) <> "" THEN
        cb_reservas.enabled     = sino
        cb_stock.enabled        = sino
      ELSE
        cb_reservas.enabled     = FALSE
        cb_stock.enabled        = FALSE
      END IF
    ELSE
      cb_reservas.enabled     = sino
      cb_stock.enabled        = sino
    END IF

IF var_control_alm = "N"  THEN
  uo_articulo.em_codigo.text = ""
  uo_articulo.em_campo.text  = ""
END IF
IF (var_control_alm = "S" and var_sector ="N") or var_control_alm = "N" THEN 
   uo_calidad.em_codigo.text = ""  
   uo_calidad.em_campo.text = ""
   em_tono.text = ""
   em_calibre.text = ""
   uo_tipo_pallet.em_codigo.text = ""
   uo_tipo_pallet.em_campo.text = ""
   em_mtrs_lineales.text = ""
   uo_caja.em_codigo.text = ""
   uo_caja.em_campo.text = ""	
   em_t_cajas.text = ""
   em_t_pallets.text = ""
   em_cajas.text = ""
END IF
    

end subroutine

public subroutine f_control ();
string donde,cuanto
donde=dw_detalle.Object.DataWindow.VerticalScrollPosition
dw_detalle.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(em_albaran.text),tipo_precio)
dw_detalle.Object.DataWindow.VerticalScrollPosition=donde
dw_detalle.setredraw(true)

	
end subroutine

public subroutine f_peso_linea ();Dec{4} var_total,var_anyo,var_albaran,var_peso_linea
var_anyo     = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)
IF len(uo_articulo.em_codigo.text) <> 0  and len(uo_tipo_pallet.em_codigo.text) <> 0Then
	var_peso_linea= f_calculo_peso(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_t_pallets.text),Dec(em_cantidad.text),uo_caja.em_codigo.text)
Else	
	var_peso_linea=0
END IF
st_peso_linea.text   = String(var_peso_linea,"###,###,###")
Select sum(peso) Into :var_total From venlialb
Where  empresa  = :codigo_empresa
And    anyo     = :var_anyo
And    albaran = :var_albaran
And    linea    <>:linea_albaran;
IF IsNull(var_total)      Then var_total       =  0
IF IsNull(var_peso_linea) Then var_peso_linea  =  0

st_peso_total.text = String(var_total + var_peso_linea,"###,###,###")
end subroutine

public subroutine f_recalcular_lineas ();str_venlialb  linalb
str_venalb   ped 
Integer  reg,reg1 
Dec{0}  ultima,albaran,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
Dec{4}  impdto,importe,acumulado,importedto1,importedto2,importedto3,importedto4,importedtopp,importedtoesp,control_precio,control_bruto,control_importedto,control_importe
Dec{2}  var_dto1,var_dto2,var_dto3,var_dto4,var_dtopp,control_descuento
String  var_tipodto1,var_tipodto2,var_tipodto3,var_tipodto4,var_calculo_dto
Dec{4}  var_impdto1,var_impdto2,var_impdto3,var_impdto4
Integer procesos

periodo   =  Integer(em_anyo.text)
albaran    =  Dec(em_albaran.text)
reg1 = dw_detalle.RowCount()
linalb.empresa   = codigo_empresa
linalb.anyo      = periodo
linalb.albaran  = albaran
  SELECT venalb.dtoesp1,     venalb.dtoesp2,   
         venalb.dtoesp3,     venalb.dtoesp4,   
         venalb.dtopp,       venalb.tipodto1,   
         venalb.tipodto2,    venalb.tipodto3,   
         venalb.tipodto4,    venalb.divisa,
			venalb.calculo_dto
    INTO :var_dto1,    :var_dto2,    :var_dto3,  :var_dto4,   
         :var_dtopp,   :var_tipodto1,:var_tipodto2,   
         :var_tipodto3,:var_tipodto4,:linalb.divisa,
			:var_calculo_dto
    FROM venalb  
   WHERE (venalb.empresa  = :linalb.empresa ) AND  
         (venalb.anyo     = :linalb.anyo ) AND  
         (venalb.albaran = :linalb.albaran );


For reg = 1 To reg1 
 linalb.linea              = Dec(f_valor_columna(dw_detalle,reg,"linea"))
 linalb.cantidad           = Dec(f_valor_columna(dw_detalle,reg,"cantidad"))
 linalb.dtoesp             = Dec(f_valor_columna(dw_detalle,reg,"dtoesp"))
 linalb.tipolinea         = f_valor_columna(dw_detalle,reg,"tipolinea")
 linalb.control_comisiones = f_comision_ventipolin(linalb.empresa,linalb.tipolinea)
 linalb.control_descuentos = f_descuento_ventipolin(linalb.empresa,linalb.tipolinea)

 IF  IsNull(linalb.dtoesp) Then linalb.dtoesp= 0
 IF IsNull(var_dto1)  Then var_dto1  = 0
 IF IsNull(var_dto2)  Then var_dto2  = 0
 IF IsNull(var_dto3)  Then var_dto3  = 0
 IF IsNull(var_dto4)  Then var_dto4  = 0
 IF IsNull(var_dtopp) Then var_dtopp = 0

For procesos = 1 To 2
 linalb.precio_aduana      = Dec(f_valor_columna(dw_detalle,reg,"precio_aduana"))
 linalb.precio             = Dec(f_valor_columna(dw_detalle,reg,"precio"))
 IF procesos = 1 then control_precio = linalb.precio
 IF procesos = 2 then control_precio = linalb.precio_aduana
	
	control_bruto = Dec(String(linalb.cantidad * control_precio,f_mascara_moneda(linalb.divisa)))
	IF var_calculo_dto = "N" Then
		importedtoesp = Dec(String((control_bruto * linalb.dtoesp /100),f_mascara_moneda(linalb.divisa)))
		acumulado = control_bruto - importedtoesp
	ELSE
		acumulado = control_bruto
	END IF
	
	IF linalb.control_descuentos = "N" Then
		linalb.descuento = 0
	ELSE
	 IF var_tipodto1  = "L" Then 
			importedto1 = Dec(String((acumulado * var_dto1 /100),f_mascara_moneda(linalb.divisa)))
			acumulado = acumulado - importedto1
	 END IF
	 IF var_tipodto2  = "L" Then 
			importedto2 = Dec(String((acumulado * var_dto2 /100),f_mascara_moneda(linalb.divisa)))
			acumulado = acumulado - importedto2
	 END IF
	 IF var_tipodto3  = "L" Then 	
		   importedto3 = Dec(String((acumulado * var_dto3 /100),f_mascara_moneda(linalb.divisa)))
			acumulado = acumulado - importedto3
	 END IF
	 IF var_tipodto4  = "L" Then 	
			importedto4  = Dec(String((acumulado * var_dto4 /100),f_mascara_moneda(linalb.divisa)))
			acumulado = acumulado - importedto4
	 END IF
	 importedtopp  = Dec(String((acumulado * var_dtopp /100),f_mascara_moneda(linalb.divisa))) 
	END IF
	control_importedto    = control_bruto - acumulado 
	control_importe       = control_bruto - control_importedto
	If control_bruto = 0 then
		control_descuento  = 0
	ELse
		control_descuento  = (control_importedto/control_bruto)* 100
	END IF
	control_importedto    = control_bruto * control_descuento / 100
	control_importe       = control_bruto - control_importedto
	
	IF var_calculo_dto = "S" Then
		control_precio = control_precio - &
		Dec(String((control_precio * control_descuento)/100,f_mascara_moneda(linalb.divisa)))
		control_descuento = linalb.dtoesp
		control_bruto = Dec(String(linalb.cantidad * control_precio,f_mascara_moneda(linalb.divisa)))
	   importedtoesp = Dec(String((control_bruto * linalb.dtoesp /100),f_mascara_moneda(linalb.divisa)))
		control_importedto    = importedtoesp
	   control_importe       = control_bruto - importedtoesp
	END IF
	
	IF procesos = 1 Then
		linalb.descuento       = control_descuento
		linalb.bruto           = control_bruto
	   linalb.importedto      = control_importedto
	   linalb.importe         = control_importe
		linalb.precio_neto     = control_precio
		
	END IF
	IF procesos = 2 Then
		linalb.descuento_aduana       = control_descuento
	   linalb.importe_aduana         = control_importe
		linalb.precio_aduana_neto     = control_precio
	END IF
Next
  UPDATE venlialb  
     SET importe            = :linalb.importe,   
         descuento          = :linalb.descuento,   
         importedto         = :linalb.importedto,   
         precio_neto        = :linalb.precio_neto,   
         precio_aduana_neto = :linalb.precio_aduana_neto,   
         descuento_aduana   = :linalb.descuento_aduana,   
         importe_aduana     = :linalb.importe_aduana,   
         bruto = :linalb.bruto  
   WHERE ( venlialb.empresa = :linalb.empresa ) AND  
         ( venlialb.anyo = :linalb.anyo ) AND  
         ( venlialb.albaran = :linalb.albaran )  AND 
        ( venlialb.linea = :linalb.linea )   ;
COMMIT;
NEXT
f_actualizar_venalbaran(codigo_empresa,periodo,albaran)
end subroutine

public function boolean f_salida_almacen (string empresa, string almacen, string referencia, string tipo_pallet, string caja, decimal cantidad);Integer vbien = 0
Int anyo
Str_deplinubica  ubi
Str_depmovhis    mov
string codigo_articulo
String codigo_calidad

codigo_articulo   = uo_articulo.em_codigo.text
codigo_calidad    = uo_calidad.em_codigo.text
ubi.empresa       = codigo_empresa
mov.anyo          = year(Today())
mov.usuario       = nombre_usuario
ubi.almacen       = almacen
ubi.articulo      = f_articulo_referencia(referencia)
ubi.calidad       = f_calidad_referencia(referencia)
ubi.tonochar      = Trim(em_tono.text)
ubi.calibre       = Integer(em_calibre.text)
mov.fechmov       = venalb.falbaran //DateTime(Today())
mov.f_alta        = Datetime(today(),now())
mov.observaciones = ""
mov.tipomov       = "2"
ubi.tipo_pallet   = tipo_pallet
ubi.caja          = caja
mov.numdoc        = em_albaran.text

SELECT  articulos.familia,
		  articulos.formato,
		  articulos.modelo,
		  articulos.unidad  
INTO    :ubi.familia,
		  :ubi.formato,
		  :ubi.modelo, 
		  :ubi.tipo_unidad  
FROM    articulos  
WHERE   articulos.empresa = :ubi.empresa 
AND     articulos.codigo  = :ubi.articulo;

IF SQLCA.SQLCode<>0 THEN vbien = 1

ubi.referencia   = f_componer_ref(ubi.articulo,&
										  ubi.calidad,ubi.tonochar,&
										  ubi.calibre)

ubi.cliente          = venalb.cliente
ubi.f_alta           = DateTime(today(),now())
mov.cantidads        = Dec(em_cantidad.text)
mov.cantidade        = 0
ubi.existencias      = mov.cantidads
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.cantidade        = 0
mov.codtercero       = venalb.cliente
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist         = 0      
mov.familia          = ubi.familia
mov.formato          = ubi.formato
mov.modelo           = ubi.modelo
mov.calidad          = ubi.calidad
mov.tonochar         = ubi.tonochar
mov.calibre          = ubi.calibre
mov.tipo_unidad      = ubi.tipo_unidad
mov.tipo_pallet      = ubi.tipo_pallet
mov.caja             = ubi.caja
mov.referencia       = ubi.referencia
mov.f_alta           = DateTime(today(),now())
mov.nummov           = f_depparam_nummov(codigo_empresa,Year(Today()))

decimal{4} cur_existencias

Select deplinubica.existencias 
Into   :cur_existencias 
From   deplinubica
Where  deplinubica.empresa     = :codigo_empresa
And    deplinubica.almacen     = :almacen 
And    deplinubica.referencia  = :ubi.referencia
And    deplinubica.tipo_pallet = :ubi.tipo_pallet
and    deplinubica.caja        = :ubi.caja;

if SQLCA.SQLCODE = 0 Then
	
	if cur_existencias > mov.cantidads then
		Update deplinubica
		Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
		Where  deplinubica.empresa     = :codigo_empresa
		And    deplinubica.almacen     = :almacen 
		And    deplinubica.referencia  = :ubi.referencia
		And    deplinubica.tipo_pallet = :ubi.tipo_pallet
		and    deplinubica.caja        = :ubi.caja;
		
		iF sqlca.sqlcode <> 0 Then vbien = 1
	else
		if cur_existencias = mov.cantidads then
			delete deplinubica
			Where  deplinubica.empresa     = :codigo_empresa
			And    deplinubica.almacen     = :almacen 
			And    deplinubica.referencia  = :ubi.referencia
			And    deplinubica.tipo_pallet = :ubi.tipo_pallet
			and    deplinubica.caja        = :ubi.caja;
			
			iF sqlca.sqlcode <> 0 Then vbien = 1
		else
			messagebox("Error","No existe suficiente stock")
			vbien = 1			
		end if		
	end if
else
	messagebox("Error","En la selección del stock")
	vbien = 1			
end if

IF NOT f_insert_depmovhis(mov) Then vbien=1

IF NOT f_actualiza_depnummov(codigo_empresa,Year(Today()),mov.nummov) THEN
	vbien = 1
END IF

IF vbien = 0  Then
	Return True
Else
	f_mensaje("Error en salida almacen",sqlca.sqlerrtext)
	Return False
End IF
end function

public function boolean f_entrada_almacen (string empresa, string almacen, string referencia, string tipo_pallet, decimal cantidad, string tipo_caja);Integer vbien = 0
Int anyo
Str_deplinubica  ubi
Str_depmovhis    mov
cantidad = cantidad  * (- 1)

string codigo_articulo
String codigo_calidad,nombre_calidad

if isnull(tipo_pallet) then tipo_pallet = ""
if isnull(tipo_caja) then tipo_caja = ""

if trim(tipo_pallet) = "" then
	messagebox("Atención","Error pallet nulo.")
	vbien = 1
end if

if trim(tipo_caja) = "" then
	messagebox("Atención","Error caja nula.")
	vbien = 1
end if

codigo_articulo   = uo_articulo.em_codigo.text
codigo_calidad    = uo_calidad.em_codigo.text

nombre_calidad    = f_nombre_calidad_abr(codigo_empresa,codigo_calidad)
if isnull(nombre_calidad) then nombre_calidad = ""
if trim(nombre_calidad) = "" then
	messagebox("Atención","Error calidad nula.")
	vbien = 1
end if

ubi.empresa       = codigo_empresa
mov.anyo          = year(date(venalb.falbaran))//year(Today())
mov.usuario       = nombre_usuario
ubi.almacen       = almacen
ubi.articulo      = f_articulo_referencia(referencia)
ubi.calidad       = f_calidad_referencia(referencia)
if ubi.calidad <> codigo_calidad then
	messagebox("Atención","Error calidad de referencia no valida.")
	vbien = 1	
end if
ubi.tonochar      = Trim(f_tono_referencia(referencia))
ubi.calibre       = Integer(f_calibre_referencia(referencia))
mov.fechmov       = venalb.falbaran // DateTime(Today())
mov.f_alta        = venalb.falbaran  //Datetime(today(),now())
mov.observaciones = ""
mov.tipomov       = "2"
ubi.tipo_pallet   = tipo_pallet
ubi.caja          = tipo_caja
mov.numdoc        = em_albaran.text
 
SELECT  articulos.familia,
		  articulos.formato,
		  articulos.modelo,
		  articulos.unidad  
INTO    :ubi.familia,
		  :ubi.formato,
		  :ubi.modelo, 
		  :ubi.tipo_unidad  
FROM    articulos  
WHERE   articulos.empresa = :ubi.empresa 
AND     articulos.codigo  = :ubi.articulo;

IF SQLCA.SQLCode<>0 THEN vbien=1
  
ubi.referencia       = f_componer_ref(ubi.articulo,ubi.calidad,ubi.tonochar,ubi.calibre)
if ubi.referencia <> referencia then
	messagebox("Atención","Error en la composición de la referencia.")
	vbien = 1
end if
ubi.cliente          = venalb.cliente
ubi.f_alta           = DateTime(today(),now())
mov.cantidads        = cantidad
mov.cantidade        = 0
ubi.existencias      = cantidad * (-1)
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.codtercero       = venalb.cliente
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist         = 0      
mov.familia          = ubi.familia
mov.formato          = ubi.formato
mov.modelo           = ubi.modelo
mov.calidad          = ubi.calidad
mov.tonochar         = ubi.tonochar
mov.calibre          = ubi.calibre
mov.tipo_unidad      = ubi.tipo_unidad
mov.tipo_pallet      = ubi.tipo_pallet
mov.caja             = tipo_caja
mov.referencia       = ubi.referencia
mov.f_alta           = DateTime(today(),now())
   
mov.nummov  = f_depparam_nummov(codigo_empresa,Year(Today()))
// Variables para cargar el cursor

integer cur_pedido,cur_linea,cur_anyo
String  cur_empresa,cur_almacen
decimal{4}  cur_existencias

Select deplinubica.existencias 
Into   :cur_existencias 
From   deplinubica
Where  deplinubica.empresa     = :codigo_empresa
And    deplinubica.almacen     = :almacen 
And    deplinubica.referencia  = :ubi.referencia
And    deplinubica.tipo_pallet = :ubi.tipo_pallet
and    deplinubica.caja        = :tipo_caja;

IF SQLCA.SQLCODE = 0 Then
	Update deplinubica
	Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
	Where  deplinubica.empresa     = :codigo_empresa
	And    deplinubica.almacen     = :almacen 
	And    deplinubica.referencia  = :ubi.referencia
	And    deplinubica.tipo_pallet = :ubi.tipo_pallet
	and    deplinubica.caja        = :tipo_caja;
ELSE
	Select  max(deplinubica.linea) Into :ubi.linea from deplinubica
	Where  deplinubica.empresa     = :codigo_empresa
	And    deplinubica.almacen     = :almacen;
	
	IF IsNUll(ubi.linea) Then ubi.linea = 0
	ubi.linea = ubi.linea +1
	IF Not f_insert_deplinubica(ubi) Then vbien = 1
END IF

// Grabo el movimiento en el historico
IF NOT f_insert_depmovhis(mov) Then vbien=1
IF NOT f_actualiza_depnummov(codigo_empresa,Year(Today()),mov.nummov) THEN
  vbien = 1
END IF
IF vbien = 0  Then
	Return True
Else
	Return False
End IF
end function

public subroutine f_calculo_precio_ant ();  string codpais
  Dec incre,incre2
  Integer t_pallets
  Dec{4}  t_cantidad,dto,v_precio_esp,v_precio_tarifa,v_pre,v_precio_esp_tar
  IF IsNull(uo_articulo.em_codigo.text) or Trim(uo_articulo.em_codigo.text)= "" Then Return 
  IF IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text)= "" Then Return 
  
		dto = 0
		em_descuento.text = "0"
      
		v_precio_esp_tar = f_precio_articulo_esp_tar(codigo_empresa,venalb.tarifa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
		IF v_precio_esp_tar <> 0 Then
			dto = 0
			em_descuento.text = "0"
			em_precio.text = String(v_precio_esp_tar,f_mascara_moneda(venalb.divisa))		
		ELSE
			v_precio_esp     = f_precio_articulo_especial(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
		   	v_precio_tarifa  = f_precio_articulo_venlintarifas_activa(codigo_empresa,venalb.tarifa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
    			dto   = f_dto_cliente_articulo(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Dec(em_t_pallets.text))
			
			v_pre = Dec(String(v_precio_tarifa - (v_precio_tarifa * dto/100),f_mascara_moneda(venalb.divisa)))
			em_descuento.text = String(dto)
			if f_serie_venclientes(codigo_empresa,em_cliente.text)="1" then
				IF (v_pre < v_precio_esp) OR v_precio_esp = 0 Then
						em_precio.text = string(v_precio_tarifa)
				  Else
						em_precio.text = String(v_precio_esp,f_mascara_moneda(venalb.divisa))		
				END IF
			 Else
				IF v_precio_esp = 0 Then
						em_precio.text = string(v_precio_tarifa)
				  Else
						em_precio.text = String(v_precio_esp,f_mascara_moneda(venalb.divisa))		
				END IF
		  End if		
	END IF
		
  codpais = f_pais_genter(codigo_empresa,"C",em_cliente.text)  
  IF Dec(em_precio.text) <> 0 AND Not IsNull(em_precio.text)Then
	  t_pallets   = Integer(em_t_pallets.text)
	  t_cantidad  = Dec(em_cantidad.text)
	  IF IsNull(t_pallets) Then t_pallets=0
  END IF
  precio_ant = Dec(em_precio.text)

end subroutine

event open;call super::open;istr_parametros = Message.PowerObjectParm
istr_parametros.s_titulo_ventana="Introducción lineas de albaranes"
This.title=istr_parametros.s_titulo_ventana
tipo_precio = 1
dw_detalle.SetTransObject(SQLCA)
dw_pie.SetTransObject(SQLCA)
dw_stock.SetTransObject(SQLCA)

IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_albaran.text=istr_parametros.s_argumentos[3]	
     IF Trim(em_anyo.text)<>"" and Trim(em_albaran.text)<>"" THEN
         f_control()
     END IF
     istr_parametros.i_nargumentos=0

     
venalb.anyo   = Dec(em_anyo.text)
venalb.albaran = Dec(em_albaran.text)


  SELECT venalb.empresa,venalb.anyo,
  			venalb.albaran,venalb.falbaran,   
         venalb.falta,venalb.cliente,
         venalb.observaciones,venalb.codpago,
			venalb.agente1,venalb.agente2,venalb.comision1,
			venalb.comision2,venalb.comision11,
			venalb.comision22,venalb.dtopp,venalb.dtoesp1,   
         venalb.dtoesp2,venalb.dtoesp3,   
         venalb.dtoesp4,venalb.tipodto1,   
         venalb.tipodto2,venalb.tipodto3,   
         venalb.tipodto4,venalb.explicaciondto1,   
         venalb.explicaciondto2,venalb.explicaciondto3,   
         venalb.explicaciondto4,venalb.tipoiva,   
         venalb.iva,venalb.numpedcli,venalb.idioma,   
         venalb.divisa,venalb.cambio,venalb.tarifa,   
         venalb.ftarifa,venalb.fbloqueo,
         venalb.serie,venalb.zona,
         venalb.forma_envio,venalb.cod_entrega,   
         venalb.usuario,venalb.tipo_portes,
			venalb.periodo_fac,venalb.peso,venalb.deposito,venalb.almacen_deposito
         INTO :venalb.empresa,:venalb.anyo,:venalb.albaran,:venalb.falbaran,   
         :venalb.falta,:venalb.cliente,
         :venalb.observaciones,:venalb.codpago,:venalb.agente1,   
         :venalb.agente2,:venalb.comision1,:venalb.comision2,
         :venalb.comision11,:venalb.comision22,:venalb.dtopp,
         :venalb.dtoesp1,:venalb.dtoesp2,:venalb.dtoesp3,:venalb.dtoesp4,   
         :venalb.tipodto1,:venalb.tipodto2,:venalb.tipodto3,
         :venalb.tipodto4,:venalb.explicaciondto1,:venalb.explicaciondto2,   
         :venalb.explicaciondto3,:venalb.explicaciondto4,:venalb.tipoiva,   
         :venalb.iva,:venalb.numpedcli,:venalb.idioma,:venalb.divisa,   
         :venalb.cambio,:venalb.tarifa,:venalb.ftarifa,:venalb.fbloqueo,   
         :venalb.serie,:venalb.zona,:venalb.forma_envio,   
         :venalb.cod_entrega,:venalb.usuario,:venalb.tipo_portes,   
         :venalb.periodo_fac,:venalb.peso,:venalb.deposito,:venalb.almacen_deposito
			
			
         FROM  venalb  
         WHERE venalb.empresa = :codigo_empresa
         AND   venalb.anyo    = :venalb.anyo
         AND   venalb.albaran  = :venalb.albaran;

			em_cliente.text = venalb.cliente
			
			st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)
			
			tipo = "I"
			
			em_precio.setmask(decimalmask!,f_mascara_precios_moneda(venalb.divisa))
			f_mascara_columna(dw_detalle,"precio",f_mascara_precios_moneda(venalb.divisa))
END IF
uo_tipolinea.ue_valor_anterior = uo_tipolinea.em_campo.text
cb_insertar.TriggerEvent(Clicked!)
f_peso_linea()
end event

event close;call super::close; longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(em_albaran.text))
 criterio[3]  =  trim(em_albaran.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "venalb"
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT;
 
 
end event

on ue_f7;call w_int_con_empresa::ue_f7;cb_valorar.TriggerEvent(Clicked!)
end on

on ue_f3;call w_int_con_empresa::ue_f3;cb_grabar.TriggerEvent(Clicked!)
end on

on ue_f6;call w_int_con_empresa::ue_f6;cb_reservas.TriggerEvent(Clicked!)
end on

on ue_f5;call w_int_con_empresa::ue_f5;cb_stock.TriggerEvent(Clicked!)
end on

on ue_f4;call w_int_con_empresa::ue_f4;cb_borrar.TriggerEvent(Clicked!)
end on

on ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_int_deplinalb.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_3=create st_3
this.st_texto_cantidad=create st_texto_cantidad
this.st_pallets=create st_pallets
this.st_total_cajas=create st_total_cajas
this.st_cajas=create st_cajas
this.st_tipopallet=create st_tipopallet
this.st_calidad=create st_calidad
this.st_articulo=create st_articulo
this.em_t_pallets=create em_t_pallets
this.em_cajas=create em_cajas
this.em_t_cajas=create em_t_cajas
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.uo_tipo_pallet=create uo_tipo_pallet
this.st_texto_mtrslinieales=create st_texto_mtrslinieales
this.em_mtrs_lineales=create em_mtrs_lineales
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.cb_grabar=create cb_grabar
this.cb_borrar=create cb_borrar
this.st_texto_precio=create st_texto_precio
this.em_precio=create em_precio
this.em_descripcion=create em_descripcion
this.st_33=create st_33
this.cb_insertar=create cb_insertar
this.uo_tipolinea=create uo_tipolinea
this.st_tplinea=create st_tplinea
this.cb_stock=create cb_stock
this.cb_reservas=create cb_reservas
this.st_dto=create st_dto
this.em_descuento=create em_descuento
this.st_1=create st_1
this.dw_pie=create dw_pie
this.dw_detalle=create dw_detalle
this.em_anyo=create em_anyo
this.gb_3=create gb_3
this.em_situacion=create em_situacion
this.gb_4=create gb_4
this.cb_valorar=create cb_valorar
this.em_albaran=create em_albaran
this.st_4=create st_4
this.st_5=create st_5
this.st_peso_linea=create st_peso_linea
this.gb_1=create gb_1
this.st_2=create st_2
this.em_porcentaje=create em_porcentaje
this.st_proforma=create st_proforma
this.st_6=create st_6
this.st_peso_total=create st_peso_total
this.st_7=create st_7
this.st_tono=create st_tono
this.em_tono=create em_tono
this.st_calibre=create st_calibre
this.em_calibre=create em_calibre
this.gb_2=create gb_2
this.dw_stock=create dw_stock
this.st_caja=create st_caja
this.uo_caja=create uo_caja
this.em_cantidad=create em_cantidad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_texto_cantidad
this.Control[iCurrent+4]=this.st_pallets
this.Control[iCurrent+5]=this.st_total_cajas
this.Control[iCurrent+6]=this.st_cajas
this.Control[iCurrent+7]=this.st_tipopallet
this.Control[iCurrent+8]=this.st_calidad
this.Control[iCurrent+9]=this.st_articulo
this.Control[iCurrent+10]=this.em_t_pallets
this.Control[iCurrent+11]=this.em_cajas
this.Control[iCurrent+12]=this.em_t_cajas
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.uo_calidad
this.Control[iCurrent+15]=this.uo_tipo_pallet
this.Control[iCurrent+16]=this.st_texto_mtrslinieales
this.Control[iCurrent+17]=this.em_mtrs_lineales
this.Control[iCurrent+18]=this.em_cliente
this.Control[iCurrent+19]=this.st_nombre_cliente
this.Control[iCurrent+20]=this.cb_grabar
this.Control[iCurrent+21]=this.cb_borrar
this.Control[iCurrent+22]=this.st_texto_precio
this.Control[iCurrent+23]=this.em_precio
this.Control[iCurrent+24]=this.em_descripcion
this.Control[iCurrent+25]=this.st_33
this.Control[iCurrent+26]=this.cb_insertar
this.Control[iCurrent+27]=this.uo_tipolinea
this.Control[iCurrent+28]=this.st_tplinea
this.Control[iCurrent+29]=this.cb_stock
this.Control[iCurrent+30]=this.cb_reservas
this.Control[iCurrent+31]=this.st_dto
this.Control[iCurrent+32]=this.em_descuento
this.Control[iCurrent+33]=this.st_1
this.Control[iCurrent+34]=this.dw_pie
this.Control[iCurrent+35]=this.dw_detalle
this.Control[iCurrent+36]=this.em_anyo
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.em_situacion
this.Control[iCurrent+39]=this.gb_4
this.Control[iCurrent+40]=this.cb_valorar
this.Control[iCurrent+41]=this.em_albaran
this.Control[iCurrent+42]=this.st_4
this.Control[iCurrent+43]=this.st_5
this.Control[iCurrent+44]=this.st_peso_linea
this.Control[iCurrent+45]=this.gb_1
this.Control[iCurrent+46]=this.st_2
this.Control[iCurrent+47]=this.em_porcentaje
this.Control[iCurrent+48]=this.st_proforma
this.Control[iCurrent+49]=this.st_6
this.Control[iCurrent+50]=this.st_peso_total
this.Control[iCurrent+51]=this.st_7
this.Control[iCurrent+52]=this.st_tono
this.Control[iCurrent+53]=this.em_tono
this.Control[iCurrent+54]=this.st_calibre
this.Control[iCurrent+55]=this.em_calibre
this.Control[iCurrent+56]=this.gb_2
this.Control[iCurrent+57]=this.dw_stock
this.Control[iCurrent+58]=this.st_caja
this.Control[iCurrent+59]=this.uo_caja
this.Control[iCurrent+60]=this.em_cantidad
end on

on w_int_deplinalb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_3)
destroy(this.st_texto_cantidad)
destroy(this.st_pallets)
destroy(this.st_total_cajas)
destroy(this.st_cajas)
destroy(this.st_tipopallet)
destroy(this.st_calidad)
destroy(this.st_articulo)
destroy(this.em_t_pallets)
destroy(this.em_cajas)
destroy(this.em_t_cajas)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.uo_tipo_pallet)
destroy(this.st_texto_mtrslinieales)
destroy(this.em_mtrs_lineales)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.cb_grabar)
destroy(this.cb_borrar)
destroy(this.st_texto_precio)
destroy(this.em_precio)
destroy(this.em_descripcion)
destroy(this.st_33)
destroy(this.cb_insertar)
destroy(this.uo_tipolinea)
destroy(this.st_tplinea)
destroy(this.cb_stock)
destroy(this.cb_reservas)
destroy(this.st_dto)
destroy(this.em_descuento)
destroy(this.st_1)
destroy(this.dw_pie)
destroy(this.dw_detalle)
destroy(this.em_anyo)
destroy(this.gb_3)
destroy(this.em_situacion)
destroy(this.gb_4)
destroy(this.cb_valorar)
destroy(this.em_albaran)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_peso_linea)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.em_porcentaje)
destroy(this.st_proforma)
destroy(this.st_6)
destroy(this.st_peso_total)
destroy(this.st_7)
destroy(this.st_tono)
destroy(this.em_tono)
destroy(this.st_calibre)
destroy(this.em_calibre)
destroy(this.gb_2)
destroy(this.dw_stock)
destroy(this.st_caja)
destroy(this.uo_caja)
destroy(this.em_cantidad)
end on

on ue_f2;call w_int_con_empresa::ue_f2;cb_insertar.TriggerEvent(Clicked!)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_deplinalb
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_deplinalb
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_deplinalb
integer x = 9
integer y = 4
integer width = 2629
integer height = 112
end type

type pb_1 from upb_salir within w_int_deplinalb
integer x = 2738
integer y = 4
integer width = 110
integer height = 104
integer taborder = 0
end type

type st_3 from statictext within w_int_deplinalb
integer x = 27
integer y = 140
integer width = 78
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
string text = "Nº:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_deplinalb
integer x = 2249
integer y = 1096
integer width = 320
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pallets from statictext within w_int_deplinalb
integer x = 1582
integer y = 1096
integer width = 119
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_total_cajas from statictext within w_int_deplinalb
integer x = 1851
integer y = 1096
integer width = 174
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "T.Cj"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cajas from statictext within w_int_deplinalb
integer x = 1701
integer y = 1096
integer width = 151
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cj"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipopallet from statictext within w_int_deplinalb
integer x = 1499
integer y = 1096
integer width = 82
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_calidad from statictext within w_int_deplinalb
integer x = 1029
integer y = 1096
integer width = 96
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_articulo from statictext within w_int_deplinalb
integer x = 329
integer y = 1096
integer width = 699
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_t_pallets from u_em_campo within w_int_deplinalb
integer x = 1577
integer y = 1168
integer width = 114
integer height = 88
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = ""
end type

event modificado;call super::modificado;string cadena
long   posi,posi_aux

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                          integer(em_t_pallets.text),&
                          0,0)
                      
//em_t_pallets.text    =Mid(cadena,1,6)
//em_cajas.text        =Mid(cadena,7,6)
//em_t_cajas.text      =Mid(cadena,13,6)
//em_cantidad.text     =Mid(cadena,19,9)
//
//IF ante_pallets <> Integer(This.text) Then em_mtrs_lineales.text=""
////IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
//f_calculo_precio()
//


IF ante_pallets <> Integer(This.text) Then em_mtrs_lineales.text=""

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

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_mtrs_lineales.text = Mid(cadena,posi_aux,posi - posi_aux + 1)
end if

IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
end event

event getfocus;call super::getfocus;ante_pallets = Integer(This.text)
campo_actual = "PALLETS"
f_peso_linea()
end event

type em_cajas from u_em_campo within w_int_deplinalb
integer x = 1696
integer y = 1168
integer width = 151
integer height = 88
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena
cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&
								  integer(em_t_pallets.text),&
                           integer(em_cajas.text),&
                           Dec(em_cantidad.text))
                      
em_t_pallets.text  =Mid(cadena,1,6)
em_cajas.text      =Mid(cadena,7,6)
em_t_cajas.text    =Mid(cadena,13,6)
em_cantidad.text   =Mid(cadena,19,9)

IF ante_cajas <> Integer(This.text) Then em_mtrs_lineales.text=""
//IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
f_calculo_precio()
end event

event getfocus;call super::getfocus;ante_cajas = Integer(This.text)
campo_actual = "CAJAS"
f_peso_linea()
end event

type em_t_cajas from u_em_campo within w_int_deplinalb
integer x = 1851
integer y = 1168
integer width = 169
integer height = 88
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type uo_articulo from u_em_campo_2 within w_int_deplinalb
integer x = 329
integer y = 1168
integer width = 695
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
String var_empresa,codigo_articulo,texto_unidad
string cod_tono,cod_calibre
uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
 em_cajas.text            = ""
  em_cantidad.text         = ""
  em_mtrs_lineales.text    = ""
  em_t_cajas.text          = ""
  em_t_pallets.text        = ""
  uo_calidad.em_campo.text = ""
  em_precio.text           = ""
  uo_calidad.em_codigo.text= ""
  uo_tipo_pallet.em_campo.text= ""
  uo_tipo_pallet.em_codigo.text= ""
  em_descripcion.text = uo_articulo.em_campo.text

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 END IF



  codigo_articulo=uo_articulo.em_codigo.text
  SELECT articulos.familia ,articulos.formato,articulos.unidad
    INTO :cod_familia,:cod_formato,:cod_tipo_unidad
    FROM articulos  
   WHERE articulos.empresa = :codigo_empresa
	AND   articulos.codigo  = :codigo_articulo;
			
  



st_texto_cantidad.text=f_nombre_unidad(cod_tipo_unidad)
em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(cod_tipo_unidad))
f_campos_segun_tiplin()
f_peso_linea()
end event

on getfocus;call u_em_campo_2::getfocus;// para controlar valor anterior
  articulo_ant = uo_articulo.em_codigo.text


ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
f_botones()

campo_actual = "ARTICULO"
end on

on losefocus;call u_em_campo_2::losefocus;IF Trim(This.em_codigo.text) <> "" Then
  cb_reservas.enabled = TRUE
  cb_stock.enabled    = TRUE
ELSE
  cb_reservas.enabled = FALSE
  cb_stock.enabled    = FALSE
END IF
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_deplinalb
integer x = 1029
integer y = 1168
integer width = 91
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF
IF calidad_ant <> uo_calidad.em_codigo.text Then
   f_calculo_precio()
END IF
f_campos_segun_tiplin()
end event

event getfocus;call super::getfocus;// para controlar valor anterio
  calidad_ant = uo_calidad.em_codigo.text

ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

campo_actual = "CALIDAD"
f_peso_linea()
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type uo_tipo_pallet from u_em_campo_2 within w_int_deplinalb
integer x = 1495
integer y = 1168
integer width = 78
integer height = 88
integer taborder = 90
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


f_peso_linea()	
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 
campo_actual = "TIPO_PALLET"


end event

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

type st_texto_mtrslinieales from statictext within w_int_deplinalb
integer x = 2025
integer y = 1096
integer width = 224
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "M. Lin"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_mtrs_lineales from u_em_campo within w_int_deplinalb
integer x = 2025
integer y = 1168
integer width = 224
integer height = 88
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###.0"
end type

event getfocus;call super::getfocus;campo_actual = "METROS_LINEALES"
f_peso_linea()

end event

event modificado;call super::modificado;If Dec(em_mtrs_lineales.text)=0 THEN Return
em_cajas.text=""
em_t_cajas.text=""
em_t_pallets.text=""
string cadena
cadena=f_calculo_unidades_lineales(codigo_empresa,uo_articulo.em_codigo.text,&
								 uo_tipo_pallet.em_codigo.text,&
								 uo_caja.em_codigo.text,&
								 Dec(em_mtrs_lineales.text))
						  
em_t_pallets.text  =Mid(cadena,1,6)
em_cajas.text      =Mid(cadena,7,6)
em_t_cajas.text    =Mid(cadena,13,6)
em_cantidad.text   =Mid(cadena,19,9)
em_mtrs_lineales.text   =Mid(cadena,28,9)
//IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
f_calculo_precio()

end event

type em_cliente from u_em_campo within w_int_deplinalb
integer x = 1074
integer y = 148
integer width = 174
integer height = 76
integer taborder = 0
long textcolor = 128
boolean enabled = false
boolean border = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

type st_nombre_cliente from statictext within w_int_deplinalb
integer x = 1239
integer y = 148
integer width = 1010
integer height = 76
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

type cb_grabar from u_boton within w_int_deplinalb
integer x = 1550
integer y = 1360
integer width = 398
integer height = 68
integer taborder = 0
string text = "F3 Grabar  "
end type

event clicked;Dec{0}    var_anyo,var_albaran
Dec{4}    var_precio,cc
String    mascara,es_pico
String motivo,controles,referencia,condicion,tipo_unidad,texto,acumular,condicion2
Integer  opcion,var_linea_acumulado
dec{2}   disponible,var_conjunto,diferencia,piezas_caja,dife,var_precio1,var_precio2
EditMask campo

mascara     = f_mascara_moneda(venalb.divisa)
var_anyo    = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)
var_precio  = Dec(em_precio.text)

IF tipo= "M" and  var_situacion	 = "P" Then
	em_situacion.text = "P"
ELSE

tipo_unidad = f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF This.visible = FALSE Then RETURN

controles = "N"
acumular  = "N" 
END IF
IF Trim(uo_tipolinea.em_codigo.text) = "" or Trim(uo_tipolinea.em_campo.text)= ""  Then
  campo   = uo_tipolinea.em_campo
  motivo  = "(Campo Obligatorio) Introduzca el tipo de linea"
  controles = "S"
END IF
IF var_control_alm = "S"  and var_sector = "S" THEN
	uo_tipo_pallet.TriggerEvent("modificado")
	IF TRIM(uo_tipo_pallet.em_campo.text)="" or IsNull(uo_tipo_pallet.em_campo.text) Then
		campo     = uo_tipo_pallet.em_campo
		motivo    = "(Campo Obligatorio) Introduzca el tipo de pallet"
		controles = "S"
	else
		IF TRIM(uo_caja.em_campo.text)="" or IsNull(uo_caja.em_campo.text) Then
			campo     = uo_caja.em_campo
			motivo    = "(Campo Obligatorio) Introduzca el tipo de caja"
			controles = "S"
		END IF	
	END IF
END IF

IF Dec(em_cantidad.text) = 0  or IsNull(em_cantidad.text) Then
   campo     = em_cantidad
   motivo    = "(Campo Obligatorio) Introduzca la cantidad"
   controles = "S"
END IF

IF var_control_alm ="S" and var_sector ="S" THEN
	IF Trim(uo_calidad.em_codigo.text) = ""  or IsNull(uo_articulo.em_codigo.text) Then
		campo     = uo_calidad.em_campo
		motivo    = "(Campo Obligatorio) Introduzca la calidad"
		controles = "S"
	END IF
END IF

IF var_control_alm = "S" THEN
	IF Trim(uo_articulo.em_codigo.text) = ""  or IsNull(uo_articulo.em_codigo.text) Then
		campo     = uo_articulo.em_campo
		motivo    = "(Campo Obligatorio) Introduzca el articulo"
		controles = "S"
	END IF  
END IF

IF controles = "S" THEN
	MessageBox("No se puede grabar la linea",motivo,Exclamation!, OK!,1)
	f_activar_campo(campo)
	Return
END IF

IF tipo = "M" Then
	cc = ante_existencias
ELSE
	cc = 0
END IF
referencia = f_componer_ref(uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Trim(em_tono.text),DEC(em_calibre.text))
Dec stock
IF var_control_alm = "S" THEN
	stock = f_depstock_referencia_tipo_pallet(codigo_empresa,venalb.almacen_deposito,referencia,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)
	//F_MENSAJE("",STRING(STOCK))
	IF stock < (Dec(em_cantidad.text)-cc) Then
		f_mensaje("No se puede grabar la linea","No hay suficiente Stock")
		f_activar_campo(uo_articulo.em_campo)
		return
	END IF
end if

// Control clase de venta
var_clase = "V"

// V-> Venta (típica)
// M-> Muestras sin precio
// S-> Ventas sin cargo
// P-> Precio pendiente

IF dec(em_precio.text) = 0  or IsNull(em_precio.text) Then
	campo     = em_precio
	motivo    = "(Campo Obligatorio) Introduzca el precio"
	controles = "S"
	tipo_array arg
	arg.valor[1]  = "Linea de albaran Sin precio"
	arg.valor[11] = "Muestras"
	arg.valor[12] = "Sin Cargo"
	arg.valor[13] = "Precio Pdte." 
	arg.valor[14] = "Cancelar" 
	opcion = f_opciones(arg)
	CHOOSE CASE opcion
		CASE 1
			var_clase ="M"
		CASE 2
			var_clase ="S"
		CASE 3
			var_clase ="P"
		CASE 4
			f_activar_campo(em_precio)
			Return
	END CHOOSE
END IF

IF var_control_alm = "S" THEN
	IF tipo = "M" Then // modificación de la línea		
		cc = dw_detalle.GetItemNumber(dw_detalle.getRow(),"cantidad")
		// no es una entrada, aunque lo parezca. Es una salida con cant < 0
		// de la cantidad que había antes de la modificación.
		IF Not f_entrada_almacen(codigo_empresa,venalb.almacen_deposito,referencia,uo_tipo_pallet.em_codigo.text,cc,uo_caja.em_codigo.text) Then 
			ROLLBACK;
			f_mensaje("Error al procesar datos","Error al generar entrada del deposito")
			f_activar_campo(uo_articulo.em_campo)
			Return 
		END IF
	END IF
	
	IF Dec(em_cantidad.text) > 0 THEN
		// Salida almacen depósito		
		IF Not f_salida_almacen(codigo_empresa,venalb.almacen_deposito,referencia,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text,Dec(em_cantidad.text)) Then 
			ROLLBACK;
			f_mensaje("Error al procesar datos","Error al generar salida del deposito")
			f_activar_campo(uo_articulo.em_campo)
			Return 
		END IF
	ELSE		
		// Entrada almacen depósito		
		IF Not f_entrada_almacen(codigo_empresa,venalb.almacen_deposito,referencia,uo_tipo_pallet.em_codigo.text,((Dec(em_cantidad.text)) * -1),uo_caja.em_codigo.text) Then 
			ROLLBACK;
			f_mensaje("Error al procesar datos","Error al generar entrada del deposito")
			f_activar_campo(uo_articulo.em_campo)
			Return 
		END IF		
	END IF
end if

acumular ="N"
IF var_control_alm = "N" Then
	SetNull(uo_articulo.text)
	SetNull(uo_calidad.text)
	SetNull(uo_tipo_pallet.text)
	SetNull(referencia)
	// Siempre se graban el situacion= "C" 
	em_situacion.text="C"
END IF

f_grabar_linea()
f_control()
IF tipo = "I" Then dw_detalle.ScrollToRow(dw_detalle.RowCount())
f_botones()
cb_insertar.TriggerEvent(clicked!)
articulo_ant=""

end event

type cb_borrar from u_boton within w_int_deplinalb
integer x = 1947
integer y = 1292
integer width = 398
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F4 Borrar     "
end type

event clicked;IF This.enabled = FALSE Then RETURN
If MessageBox("Comfirmacion Baja linea de albaran","Desea borra la linea de pedido seleccionada",Question!, YesNo!,2)= 2 Then
  f_activar_primer_campo()
  Return
END IF
IF f_valor_columna(dw_detalle,dw_detalle.GetRow(),"situacion") = "P" Then
	f_mensaje("No se puede borrar la linea","Linea preparada no se puede borrar")
	Return
END IF

String referencia
Dec var_cantidad
IF var_control_alm = "S" THEN
	var_cantidad = dw_detalle.GetItemNumber(dw_detalle.getRow(),"cantidad")
	
	referencia = f_componer_ref(uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Trim(em_tono.text),DEC(em_calibre.text))
	
	IF Not f_entrada_almacen(codigo_empresa,venalb.almacen_deposito,referencia,uo_tipo_pallet.em_codigo.text,var_cantidad,uo_caja.em_codigo.text) Then 
		f_mensaje("Error al procesar datos","Error al generar salida del deposito")
		f_activar_campo(uo_articulo.em_campo)
		Return 
	END IF
end if
f_borrar_linea()
f_control()
cb_insertar.TriggerEvent(clicked!)

end event

type st_texto_precio from statictext within w_int_deplinalb
integer x = 2569
integer y = 1096
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_precio from u_em_campo within w_int_deplinalb
integer x = 2565
integer y = 1168
integer width = 293
integer height = 88
integer taborder = 150
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;This.text = String(Dec(This.text),f_mascara_precios_moneda(venalb.divisa))
campo_actual = "PRECIO"

end event

type em_descripcion from u_em_campo within w_int_deplinalb
integer x = 14
integer y = 1352
integer width = 1166
integer taborder = 160
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCRIPCION"
end on

type st_33 from statictext within w_int_deplinalb
integer x = 14
integer y = 1276
integer width = 1170
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Descripción artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_insertar from u_boton within w_int_deplinalb
integer x = 1550
integer y = 1292
integer width = 398
integer height = 68
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;control_incremento = "P"
tipo="I"
linea_albaran = 0
em_cajas.text=""
em_tono.text=""
em_calibre.text=""
em_cantidad.text=""
em_descripcion.text=""
em_mtrs_lineales.text=""
em_precio.text=""
em_descuento.text=""
em_situacion.text=""
em_t_cajas.text=""
em_t_pallets.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
uo_tipo_pallet.em_campo.text=""
uo_articulo.em_codigo.text=""
articulo_ant=""
uo_calidad.em_codigo.text=""
uo_tipo_pallet.em_codigo.text=""
uo_tipolinea.em_codigo.text="1"
uo_tipolinea.em_campo.text = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
uo_tipolinea.TriggerEvent("modificado")
em_situacion.text="S"
f_botones()
dw_detalle.SelectRow(0,FALSE)
f_activar_primer_campo()
f_peso_linea()
end event

type uo_tipolinea from u_em_campo_2 within w_int_deplinalb
integer x = 9
integer y = 1168
integer width = 315
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;f_campos_segun_tiplin()
uo_tipolinea.em_campo.text=f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
IF Trim(uo_tipolinea.em_campo.text)=""  or IsNull(uo_tipolinea.em_campo.text)THEN 
 IF Trim(uo_tipolinea.em_codigo.text)<>"" Then 
   f_activar_campo(uo_tipolinea.em_campo)
 END IF
 uo_tipolinea.em_campo.text   = ""
 uo_tipolinea.em_codigo.text  = ""
END IF

end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion tipos de linea (facturación)"
ue_datawindow = "dw_ayuda_ventipolin"
ue_filtro     = ""
tipolinea_ant = this.em_codigo.text

campo_actual = "TIPO_LINEA"
end on

on uo_tipolinea.destroy
call u_em_campo_2::destroy
end on

type st_tplinea from statictext within w_int_deplinalb
integer x = 9
integer y = 1096
integer width = 320
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tp. linea"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stock from u_boton within w_int_deplinalb
integer x = 1947
integer y = 1360
integer width = 398
integer height = 68
integer taborder = 0
string text = "F5 Ver stock"
end type

event clicked;//***
//f_mensaje("venalb.almacen_deposito",venalb.almacen_deposito)
if dw_stock.retrieve(codigo_empresa,venalb.almacen_deposito,uo_articulo.em_codigo.text) <> 0 tHEN
dw_stock.visible = TRUE
else
	f_mensaje("No Hay Stock","Articulo Sin Stock en Depósito")
	f_activar_campo(uo_articulo.em_campo)
	Return
end if
	
      
   
end event

type cb_reservas from u_boton within w_int_deplinalb
integer x = 2345
integer y = 1292
integer width = 398
integer height = 68
integer taborder = 0
string text = "F6 Reservas"
end type

on clicked;call u_boton::clicked;IF This.enabled = FALSE Then RETURN
str_parametros valores
       IF var_control_alm = "N" Then Return
       f_consulta_reservas()
       IF Message.DoubleParm=-1  THEN 
       ELSE
        END IF
       f_activar_campo(uo_articulo.em_campo)

end on

type st_dto from statictext within w_int_deplinalb
integer x = 1184
integer y = 1276
integer width = 215
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Dto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_descuento from u_em_campo within w_int_deplinalb
integer x = 1179
integer y = 1352
integer width = 224
integer taborder = 170
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#0.00"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCUENTO"
end on

type st_1 from statictext within w_int_deplinalb
integer x = 1408
integer y = 1356
integer width = 55
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "%"
boolean focusrectangle = false
end type

type dw_pie from datawindow within w_int_deplinalb
boolean visible = false
integer x = 517
integer y = 320
integer width = 2185
integer height = 764
integer taborder = 180
boolean titlebar = true
string title = "Pie de Albaran"
string dataobject = "dw_int_venlialb3"
boolean controlmenu = true
boolean livescroll = true
end type

on clicked;This.visible = FALSE
f_activar_primer_campo()
end on

type dw_detalle from datawindow within w_int_deplinalb
integer x = 5
integer y = 244
integer width = 2857
integer height = 848
string dataobject = "dw_int_venlialb2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then 
   f_activar_primer_campo()
   Return
End IF
tipo="M"
This.SelectRow(0,FALSE)
This.SelectRow(Row,TRUE)
This.SetRow(Row)
uo_tipolinea.em_codigo.text =This.GetItemString(Row,"tipolinea")
uo_tipolinea.em_campo.text   = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
uo_tipolinea.TriggerEvent("modificado")
uo_tipolinea.ue_valor_anterior   = uo_tipolinea.em_campo.text

em_cajas.text                    = String(This.GetItemNumber(Row,"cajas"))
ante_existencias                 = Dec(em_cantidad.text)
em_descripcion.text              = This.GetItemString(Row,"descripcion")
em_mtrs_lineales.text            = String(This.GetItemNumber(Row,"metros_lineales"))
ante_valor                       = This.GetItemNumber(Row,"precio")
em_precio.text                   = f_valor_columna(This,Row,"calculo_precio")
em_descuento.text                = String(This.GetItemNumber(Row,"dtoesp"))
em_situacion.text                = This.GetItemString(Row,"situacion")
em_t_cajas.text                  = String(This.GetItemNumber(Row,"total_cajas"))
uo_articulo.em_codigo.text       = This.GetItemString(Row,"venlialb_articulo")
uo_calidad.em_codigo.text        = This.GetItemString(Row,"calidad")
em_tono.text                     = This.GetItemString(Row,"tonochar")
em_calibre.text                  = String(This.GetItemNumber(Row,"calibre"))
uo_tipo_pallet.em_codigo.text    = This.GetItemString(Row,"tipo_pallet")
uo_caja.em_codigo.text 			   = This.GetItemString(Row,"venlialb_caja")
em_t_pallets.text                = String(This.GetItemNumber(Row,"pallets"))
linea_albaran	                  = This.GetItemNumber(Row,"linea")
control_incremento               = This.GetItemString(Row,"venlialb_control_incremento")

uo_articulo.em_campo.text        = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
uo_articulo.ue_valor_anterior    = uo_articulo.em_campo.text

uo_calidad.em_campo.text         = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
uo_calidad.ue_valor_anterior     = uo_calidad.em_campo.text

uo_tipo_pallet.em_campo.text     = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
uo_tipo_pallet.ue_valor_anterior = uo_tipo_pallet.em_campo.text

uo_caja.em_campo.text  			   = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)
uo_caja.ue_valor_anterior        = uo_caja.em_campo.text

referencia_ant                   = String(This.GetItemString(Row,"venlialb_referencia"))
tipopallet_ant                   = String(This.GetItemString(Row,"tipo_pallet"))
cod_familia                      = String(This.GetItemString(Row,"venlialb_familia"))
cod_formato                      = String(This.GetItemString(Row,"venlialb_formato"))
var_situacion                    = String(This.GetItemString(Row,"situacion"))
cod_tipo_unidad                  = String(This.GetItemString(Row,"tipo_unidad"))
st_texto_cantidad.text = f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
em_cantidad.Setmask(decimalMask!,f_mascara_unidad(cod_tipo_unidad))
em_cantidad.text                 = String(This.GetItemNumber(Row,"cantidad"))

f_botones()
f_peso_linea()
f_activar_primer_campo()
f_campos_segun_tiplin()
Return
end event

type em_anyo from u_em_campo within w_int_deplinalb
integer x = 105
integer y = 144
integer width = 165
integer height = 68
integer taborder = 0
long textcolor = 128
boolean enabled = false
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

type gb_3 from groupbox within w_int_deplinalb
integer x = 1061
integer y = 96
integer width = 1207
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

type em_situacion from u_em_campo within w_int_deplinalb
boolean visible = false
integer x = 23
integer y = 1448
integer width = 123
integer taborder = 140
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_int_deplinalb
integer x = 1541
integer y = 1256
integer width = 1211
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_valorar from u_boton within w_int_deplinalb
integer x = 2345
integer y = 1360
integer width = 398
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F7 Valorar   "
end type

event clicked;call super::clicked;dw_pie.visible = TRUE
dw_pie.InsertRow(1)
dw_pie.SetItem(1,"pie",f_pie_albaran(venalb.empresa,venalb.anyo,venalb.albaran))
f_activar_primer_campo()


end event

type em_albaran from u_em_campo within w_int_deplinalb
integer x = 325
integer y = 144
integer width = 165
integer height = 68
integer taborder = 0
long textcolor = 128
boolean enabled = false
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

type st_4 from statictext within w_int_deplinalb
integer x = 2286
integer y = 128
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso total"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_deplinalb
integer x = 2281
integer y = 176
integer width = 311
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso Linea"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_peso_linea from statictext within w_int_deplinalb
integer x = 2606
integer y = 176
integer width = 242
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_int_deplinalb
integer x = 14
integer y = 96
integer width = 489
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

type st_2 from statictext within w_int_deplinalb
integer x = 265
integer y = 144
integer width = 46
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = decorative!
string facename = "Algerian"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_porcentaje from u_em_campo within w_int_deplinalb
boolean visible = false
integer x = 878
integer y = 136
integer width = 151
integer taborder = 0
integer weight = 400
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###"
end type

event tecla_enter;call super::tecla_enter;Dec{4} var_porcentaje
Dec{0} var_anyo,var_albaran
var_porcentaje = Dec(em_porcentaje.text)
var_anyo     = Dec(em_anyo.text)
var_albaran = Dec(em_albaran.text)

IF messageBox("Proceso volcado de precios","Desea Volcar precios al "+ em_porcentaje.text +" %",Question!,YesNo!,2) = 1 Then
   UPDATE venlialb	
	Set    venlialb.precio_aduana = venlialb.precio * :var_porcentaje/100
	Where  venlialb.empresa  = :codigo_empresa
   And  	 venlialb.anyo     = :var_anyo
	And    venlialb.albaran = :var_albaran;
	UPDATE venalb	
	Set    venalb.porcentaje_aduana = :var_porcentaje
	Where  venalb.empresa  = :codigo_empresa
   And  	 venalb.anyo     = :var_anyo
	And    venalb.albaran = :var_albaran;
	COMMIT;
	f_control()
	f_recalcular_lineas()
	COMMIT;
	f_control()
END IF
end event

type st_proforma from dropdownlistbox within w_int_deplinalb
integer x = 535
integer y = 136
integer width = 343
integer height = 276
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Albaran"
boolean vscrollbar = true
string item[] = {"Albaran","Aduana"}
end type

event selectionchanged;Dec{4}  var_porcentaje
Dec{0}  var_anyo,var_albaran

var_anyo= Dec(em_anyo.text)
var_albaran= Dec(em_albaran.text)

IF This.Text = "Aduana" Then
  tipo_precio = 2
  em_porcentaje.visible = TRUE
	Select venalb.porcentaje_aduana Into	:var_porcentaje
	From   venalb
	Where  venalb.empresa  = :codigo_empresa
   And  	 venalb.anyo     = :var_anyo
	And    venalb.albaran = :var_albaran;
	em_porcentaje.text = String(var_porcentaje)
ELSE
	 tipo_precio = 1
    em_porcentaje.visible = FALSE
END IF
f_control()
tipo = "I"
cb_insertar.TriggerEvent(Clicked!)
f_peso_linea()
f_botones()
f_activar_primer_campo()
f_campos_segun_tiplin()
end event

type st_6 from statictext within w_int_deplinalb
integer x = 2277
integer y = 120
integer width = 320
integer height = 116
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_peso_total from statictext within w_int_deplinalb
integer x = 2606
integer y = 124
integer width = 242
integer height = 52
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_deplinalb
integer x = 2597
integer y = 120
integer width = 265
integer height = 116
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tono from statictext within w_int_deplinalb
integer x = 1248
integer y = 1096
integer width = 73
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_deplinalb
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1125
integer y = 1168
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "xxxxx"
end type

event getfocus;call super::getfocus;campo_actual = "TONO"

end event

event modificado;call super::modificado;string cadena
cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&
								  integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_t_pallets.text    =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_t_cajas.text      =Mid(cadena,13,6)
em_cantidad.text     =Mid(cadena,19,9)

IF ante_pallets <> Integer(This.text) Then em_mtrs_lineales.text=""
IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
end event

type st_calibre from statictext within w_int_deplinalb
integer x = 1125
integer y = 1096
integer width = 123
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_calibre from u_em_campo within w_int_deplinalb
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1248
integer y = 1168
integer width = 64
integer height = 88
integer taborder = 70
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;campo_actual = "TONO"

end event

event modificado;call super::modificado;string cadena
cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&
								  integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_t_pallets.text    =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_t_cajas.text      =Mid(cadena,13,6)
em_cantidad.text     =Mid(cadena,19,9)

IF ante_pallets <> Integer(This.text) Then em_mtrs_lineales.text=""
IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
end event

type gb_2 from groupbox within w_int_deplinalb
integer x = 521
integer y = 96
integer width = 526
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

type dw_stock from datawindow within w_int_deplinalb
boolean visible = false
integer x = 14
integer y = 248
integer width = 2843
integer height = 832
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_int_depalb6"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if f_objeto_datawindow(This) = "salir" Then
	This.Reset()
	This.visible = FALSE
	Return
END IF
f_activar_campo(em_t_pallets)
IF row = 0 Then Return
IF IsNull(row) Then Return
uo_articulo.em_codigo.text       = GetItemString(row,"deplinubica_articulo")
uo_articulo.em_campo.text        = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
uo_calidad.em_codigo.text        = GetItemString(row,"deplinubica_calidad")
uo_calidad.em_campo.text         = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
uo_tipo_pallet.em_codigo.text    = GetItemString(row,"deplinubica_tipo_pallet")
uo_tipo_pallet.em_campo.text     = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
uo_caja.em_codigo.text    			= GetItemString(row,"deplinubica_caja")
uo_caja.em_campo.text     			= f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)
em_tono.text                     = GetItemstring(row,"deplinubica_tonochar")
em_calibre.text                  = String(GetItemNumber(row,"deplinubica_calibre"),"####0")
uo_articulo.ue_valor_anterior    = uo_articulo.em_campo.text
uo_calidad.ue_valor_anterior     = uo_calidad.em_campo.text
uo_tipo_pallet.ue_valor_anterior = uo_tipo_pallet.em_campo.text
This.Reset()
This.visible = FALSE
f_activar_campo(uo_calidad.em_campo)

end event

type st_caja from statictext within w_int_deplinalb
integer x = 1321
integer y = 1096
integer width = 174
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_deplinalb
event destroy ( )
integer x = 1317
integer y = 1168
integer width = 174
integer height = 88
integer taborder = 80
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


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
campo_actual = "CAJA"



end event

type em_cantidad from u_em_campo within w_int_deplinalb
integer x = 2254
integer y = 1168
integer width = 306
integer height = 88
integer taborder = 130
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;string cadena
long   posi,posi_aux

IF var_control_alm ="S"  and var_sector = "S" THEN
	If ante_valor<>Dec(em_cantidad.text) THEN
		em_cajas.text=""
		em_t_cajas.text=""
		em_t_pallets.text=""
		em_mtrs_lineales.text =""
	END  IF
	
	cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
									 uo_tipo_pallet.em_codigo.text,&
									 uo_caja.em_codigo.text,&
									 integer(em_t_pallets.text),&
									 integer(em_cajas.text),&
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
	
	posi = pos(cadena,"|",posi_aux)
	if posi <>0 then
		em_mtrs_lineales.text = Mid(cadena,posi_aux,posi - posi_aux + 1)
	end if

 	IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
END IF
f_peso_linea()									 
						 
																 														  
//	em_t_pallets.text  =Mid(cadena,1,6)
//	em_cajas.text      =Mid(cadena,7,6)
//	em_t_cajas.text    =Mid(cadena,13,6)
//	em_cantidad.text   =Mid(cadena,19,9)
//	
//	//IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
//	f_calculo_precio()
//END IF
//f_peso_linea()
end event

event getfocus;call super::getfocus;IF var_control_alm = "N" Then st_texto_cantidad.text = "Unidades"
ante_valor= Dec(em_cantidad.text)
campo_actual = "CANTIDAD"
f_peso_linea()
end event

