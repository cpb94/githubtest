$PBExportHeader$w_int_venliproformas.srw
forward
global type w_int_venliproformas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_venliproformas
end type
type st_3 from statictext within w_int_venliproformas
end type
type st_texto_cantidad from statictext within w_int_venliproformas
end type
type st_pallets from statictext within w_int_venliproformas
end type
type st_total_cajas from statictext within w_int_venliproformas
end type
type st_cajas from statictext within w_int_venliproformas
end type
type st_tipopallet from statictext within w_int_venliproformas
end type
type st_calidad from statictext within w_int_venliproformas
end type
type st_articulo from statictext within w_int_venliproformas
end type
type em_t_pallets from u_em_campo within w_int_venliproformas
end type
type em_cajas from u_em_campo within w_int_venliproformas
end type
type em_t_cajas from u_em_campo within w_int_venliproformas
end type
type em_cantidad from u_em_campo within w_int_venliproformas
end type
type uo_articulo from u_em_campo_2 within w_int_venliproformas
end type
type uo_calidad from u_em_campo_2 within w_int_venliproformas
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_venliproformas
end type
type st_texto_mtrslinieales from statictext within w_int_venliproformas
end type
type em_mtrs_lineales from u_em_campo within w_int_venliproformas
end type
type em_cliente from u_em_campo within w_int_venliproformas
end type
type st_nombre_cliente from statictext within w_int_venliproformas
end type
type cb_grabar from u_boton within w_int_venliproformas
end type
type cb_borrar from u_boton within w_int_venliproformas
end type
type st_texto_precio from statictext within w_int_venliproformas
end type
type em_precio from u_em_campo within w_int_venliproformas
end type
type em_descripcion from u_em_campo within w_int_venliproformas
end type
type st_33 from statictext within w_int_venliproformas
end type
type cb_insertar from u_boton within w_int_venliproformas
end type
type uo_tipolinea from u_em_campo_2 within w_int_venliproformas
end type
type st_tplinea from statictext within w_int_venliproformas
end type
type cb_stock from u_boton within w_int_venliproformas
end type
type cb_reservas from u_boton within w_int_venliproformas
end type
type st_dto from statictext within w_int_venliproformas
end type
type em_descuento from u_em_campo within w_int_venliproformas
end type
type dw_pie from datawindow within w_int_venliproformas
end type
type dw_detalle from datawindow within w_int_venliproformas
end type
type em_anyo from u_em_campo within w_int_venliproformas
end type
type gb_3 from groupbox within w_int_venliproformas
end type
type em_situacion from u_em_campo within w_int_venliproformas
end type
type gb_4 from groupbox within w_int_venliproformas
end type
type cb_valorar from u_boton within w_int_venliproformas
end type
type em_proforma from u_em_campo within w_int_venliproformas
end type
type st_4 from statictext within w_int_venliproformas
end type
type st_5 from statictext within w_int_venliproformas
end type
type st_peso_linea from statictext within w_int_venliproformas
end type
type gb_1 from groupbox within w_int_venliproformas
end type
type st_2 from statictext within w_int_venliproformas
end type
type em_porcentaje from u_em_campo within w_int_venliproformas
end type
type gb_2 from groupbox within w_int_venliproformas
end type
type st_proforma from dropdownlistbox within w_int_venliproformas
end type
type st_6 from statictext within w_int_venliproformas
end type
type st_peso_total from statictext within w_int_venliproformas
end type
type st_7 from statictext within w_int_venliproformas
end type
type cb_palmas from u_boton within w_int_venliproformas
end type
type cb_palmenos from u_boton within w_int_venliproformas
end type
type cb_cajmenos from u_boton within w_int_venliproformas
end type
type cb_cajmas from u_boton within w_int_venliproformas
end type
type gb_5 from groupbox within w_int_venliproformas
end type
type st_caja from statictext within w_int_venliproformas
end type
type uo_caja from u_em_campo_2 within w_int_venliproformas
end type
type st_1 from statictext within w_int_venliproformas
end type
end forward

global type w_int_venliproformas from w_int_con_empresa
integer width = 2953
integer height = 1624
string menuname = ""
boolean minbox = false
boolean maxbox = false
windowtype windowtype = response!
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
em_cantidad em_cantidad
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
dw_pie dw_pie
dw_detalle dw_detalle
em_anyo em_anyo
gb_3 gb_3
em_situacion em_situacion
gb_4 gb_4
cb_valorar cb_valorar
em_proforma em_proforma
st_4 st_4
st_5 st_5
st_peso_linea st_peso_linea
gb_1 gb_1
st_2 st_2
em_porcentaje em_porcentaje
gb_2 gb_2
st_proforma st_proforma
st_6 st_6
st_peso_total st_peso_total
st_7 st_7
cb_palmas cb_palmas
cb_palmenos cb_palmenos
cb_cajmenos cb_cajmenos
cb_cajmas cb_cajmas
gb_5 gb_5
st_caja st_caja
uo_caja uo_caja
st_1 st_1
end type
global w_int_venliproformas w_int_venliproformas

type variables
string filtro,bloqueado
Integer bien,ante_pallets,ante_cajas
decimal{2} ante_valor
str_almmovhis mov
String  tipo // I-> inserción , M -> Modificación
Dec{0}  linea_proforma
String  cod_tipo_unidad,cod_formato,cod_familia,var_control_alm,var_sector,var_clase,control_incremento
String articulo_ant,calidad_ant,tipolinea_ant,referencia_ant,tipopallet_ant
Dec{2} precio_ant,ante_existencias
str_venproformas venproformas
String campo_actual
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
end prototypes

public subroutine f_grabar_linea ();str_venliproformas linprofor
str_venproformas   ped 
Dec{0}  ultima,proforma,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
periodo  =  Integer(em_anyo.text)
proforma =  Dec(em_proforma.text)

Select venliproformas.precio_aduana,venliproformas.precio 
Into   :linprofor.precio_aduana,:linprofor.precio
	From venliproformas
	WHERE ( venliproformas.empresa   = :codigo_empresa ) AND  
         ( venliproformas.anyo      = :periodo ) AND  
         ( venliproformas.proforma  = :proforma ) AND  
         ( venliproformas.linea     = :linea_proforma)   ;

linprofor.control_incremento = control_incremento 
IF Trim(linprofor.control_incremento) = "" or IsNull(linprofor.control_incremento) Then
 	linprofor.control_incremento = "S"
END IF	

IF tipo ="I" THEN
 ultima =  0
 Select max(venliproformas.linea) Into :ultima From venliproformas
 Where  venliproformas.empresa   =   :codigo_empresa
 And    venliproformas.anyo      =   :periodo
 And    venliproformas.proforma  =   :proforma;
 IF ISNull(ultima) Then ultima=0
 ultima = ultima +1
END IF

linprofor.empresa   = venproformas.empresa
linprofor.anyo      = venproformas.anyo
linprofor.proforma  = venproformas.proforma
linprofor.fproforma = venproformas.fproforma
linprofor.cliente   = venproformas.cliente
linprofor.tipoiva   = venproformas.tipoiva
linprofor.iva       = venproformas.iva
linprofor.divisa    = venproformas.divisa
linprofor.serie     = venproformas.serie
linprofor.zona      = venproformas.zona
linprofor.agente1   = venproformas.agente1
linprofor.agente2   = venproformas.agente2
linprofor.agente3   = venproformas.agente3
linprofor.comision11= venproformas.comision1
linprofor.comision12= venproformas.comision11
linprofor.comision21= venproformas.comision2
linprofor.comision22= venproformas.comision22
linprofor.comision31= venproformas.comision31
linprofor.comision32= venproformas.comision32
linprofor.linea     = ultima
linprofor.articulo  = uo_articulo.em_codigo.text
linprofor.clase     = var_clase
linprofor.sector    = var_sector


SELECT articulos.empresa,articulos.codigo,articulos.familia,
       articulos.formato,articulos.modelo,articulos.unidad,articulos.pesopieza
INTO   :linprofor.empresa,:linprofor.articulo,:linprofor.familia,:linprofor.formato,
       :linprofor.modelo,:linprofor.tipo_unidad,:linprofor.peso    
FROM articulos  
WHERE (articulos.empresa = :codigo_empresa )
AND   (articulos.codigo = :linprofor.articulo )   
ORDER BY articulos.empresa ASC,articulos.codigo ASC;


linprofor.calidad         = uo_calidad.em_codigo.text
linprofor.tonochar        = ""
linprofor.calibre         = 0
IF tipo_precio = 1 Then
	linprofor.precio       			   = Dec(em_precio.text)
ELSE
	linprofor.precio_aduana          = Dec(em_precio.text)
END IF
linprofor.precio_estand   = f_precio_articulo(linprofor.empresa,linprofor.cliente,linprofor.articulo,linprofor.calidad,f_tarifa_venproformas(linprofor.empresa,linprofor.anyo,linprofor.proforma))
linprofor.cantidad        = Dec(em_cantidad.text)
linprofor.pallets         = Integer(em_t_pallets.text)
linprofor.total_cajas     = Integer(em_t_cajas.text)
linprofor.cajas           = Integer(em_cajas.text)
linprofor.dtocomer        = 0
If IsNull(em_descuento.text) or Trim(em_descuento.text) ="" THEN
   em_descuento.text ="0"
END IF
linprofor.dtoesp          = Dec(em_descuento.text)
linprofor.descripcion     = em_descripcion.text


  SELECT familias.linea INTO :linprofor.linfab FROM familias  
   WHERE ( familias.empresa = :codigo_empresa ) AND  
         ( familias.codigo  = :linprofor.familia )   ;
String   var_tipoter
SELECT genter.empresa,genter.tipoter,genter.codigo,genter.pais,
       genter.provincia  
INTO   :ped.empresa,:var_tipoter,:ped.cliente,:linprofor.pais,:linprofor.provincia  
FROM   genter  
WHERE (genter.empresa = :codigo_empresa)
AND   (genter.tipoter = 'C' )
AND   (genter.codigo = :linprofor.cliente )   
ORDER BY genter.empresa ASC,genter.tipoter ASC,genter.codigo ASC  ;
linprofor.tipolinea       = uo_tipolinea.em_codigo.text
linprofor.texto1          = ""
linprofor.texto2          = ""
linprofor.texto3          = ""

if Trim(linprofor.articulo)<>"" and Not isnull(linprofor.articulo) then
	linprofor.referencia      = f_componer_ref(linprofor.articulo,linprofor.calidad,linprofor.tonochar,linprofor.calibre)
	linprofor.montajeartcal   = f_componer_artcal(linprofor.articulo,linprofor.calidad)
 else
	linprofor.referencia      = ""
	linprofor.montajeartcal   = ""
End if

linprofor.situacion       = em_situacion.text
linprofor.metros_lineales = Dec(em_mtrs_lineales.text)
linprofor.falta           = Datetime(today())
linprofor.usuario         = nombre_usuario
linprofor.tipo_pallet     = uo_tipo_pallet.em_codigo.text
linprofor.caja            = uo_caja.em_codigo.text
linprofor.deposito        = "N"
IF tipo="M" THEN
	DELETE FROM venliproformas  
   WHERE ( venliproformas.empresa   = :linprofor.empresa ) AND  
         ( venliproformas.anyo      = :linprofor.anyo ) AND  
         ( venliproformas.proforma  = :linprofor.proforma ) AND  
         ( venliproformas.linea   = :linea_proforma)   ;
     linprofor.linea   = linea_proforma
END IF


 IF var_control_alm = "N" Then 
    SetNull(linprofor.articulo)
    SetNull(linprofor.formato)
    SetNull(linprofor.modelo)
    SetNull(linprofor.calidad)
    SetNull(linprofor.tonochar)
    SetNull(linprofor.calibre)
    SetNull(linprofor.pallets)
    SetNull(linprofor.total_cajas)
    SetNull(linprofor.cajas)
    SetNull(linprofor.linfab)
    SetNull(linprofor.referencia)
    SetNull(linprofor.montajeartcal)
    SetNull(linprofor.tipo_pallet)
    SetNull(linprofor.caja)	 
    linprofor.tipo_unidad = "0"
  END IF
  f_insertar_venliproformas(linprofor)
  f_actualizar_linea_venproforma(linprofor.empresa,linprofor.anyo,linprofor.proforma,linprofor.linea)



COMMIT;
f_actualizar_venproforma(codigo_empresa,periodo,proforma)

end subroutine

public subroutine f_borrar_linea ();Dec{0}periodo,proforma

periodo = Dec(em_anyo.text)
proforma  = Dec(em_proforma.text)

   DELETE FROM venliproformas  
   WHERE ( venliproformas.empresa = :codigo_empresa ) AND  
         ( venliproformas.anyo    = :periodo ) AND  
         ( venliproformas.proforma  = :proforma ) AND  
         ( venliproformas.linea   = :linea_proforma )   ;

COMMIT;

f_actualizar_venproforma(codigo_empresa,periodo,proforma)
end subroutine

public subroutine f_botones ();If tipo = "I" Then 
  cb_insertar.enabled = FALSE
  cb_borrar.enabled   = FALSE
End If

If tipo = "M" Then
  cb_insertar.enabled = TRUE
  cb_borrar.enabled   = TRUE
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
end subroutine

public subroutine f_calculo_precio ();  string codpais
  Dec incre,incre2
  Integer t_pallets
  Dec{4}  t_cantidad,dto,v_precio_tarifa,v_precio_esp,v_pre,v_precio_esp_tar
  IF IsNull(uo_articulo.em_codigo.text) or Trim(uo_articulo.em_codigo.text)= "" Then Return 
  IF IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text)= "" Then Return 
  dto = 0
  em_descuento.text = "0"
  
  
  
  IF f_tipo_cliente_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))  = "S" Then
      v_precio_esp_tar = f_precio_articulo_esp_tar(codigo_empresa,venproformas.tarifa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
		IF v_precio_esp_tar <> 0 Then
			dto = 0
			em_descuento.text = "0"
			em_precio.text = String(v_precio_esp_tar,em_precio.mask)		
		ELSE
			v_precio_esp     = f_precio_articulo_especial(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
		   v_precio_tarifa  = f_precio_articulo_venlintarifas_activa(codigo_empresa,venproformas.tarifa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text)
   		dto   = f_dto_cliente_articulo(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Dec(em_t_pallets.text))
			v_pre = Dec(String(v_precio_tarifa - (v_precio_tarifa * dto/100),f_mascara_moneda(venproformas.divisa)))
			em_descuento.text = String(dto)
			if f_serie_venclientes(codigo_empresa,em_cliente.text)="1" then
				IF (v_pre < v_precio_esp) OR v_precio_esp = 0 Then
						em_precio.text = string(v_precio_tarifa,em_precio.mask)
				  Else
						em_precio.text = String(v_precio_esp,em_precio.mask)		
				END IF
			 Else
				IF v_precio_esp = 0 Then
						em_precio.text = string(v_precio_tarifa,em_precio.mask)
				  Else
						em_precio.text = String(v_precio_esp,em_precio.mask)		
				END IF
		  End if		
	END IF
		
     codpais = f_pais_genter(codigo_empresa,"C",em_cliente.text)  
  END IF
  
  
  
  
  
  
  
  
  
  
  
  IF f_tipo_cliente_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(em_proforma.text))  = "N" Then
      em_precio.text = String(f_precio_articulo_nocliente(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,venproformas.tarifa),em_precio.mask)
     codpais = f_pais_vencliproforma(codigo_empresa,em_cliente.text)  
  END IF
  IF Dec(em_precio.text) <> 0 AND Not IsNull(em_precio.text)Then
	  t_pallets   = Integer(em_t_pallets.text)
	  t_cantidad  = Dec(em_cantidad.text)
	  IF IsNull(t_pallets) Then t_pallets=0
	  IF t_pallets <1 and t_cantidad <>0 Then 
	     incre  = f_incremento_pallet_cliente(codigo_empresa,em_cliente.text)
		  incre2 = f_incremento_precio(codigo_empresa,cod_familia,uo_calidad.em_codigo.text,Dec(em_precio.text),codpais)
		  IF incre<> 0 and incre2 <> 0 Then incre2 = incre + Dec(em_precio.text)
		  em_precio.text= String(incre2,em_precio.mask)
	  End IF  
	END IF
	em_precio.text = STring(Dec(em_precio.text) / venproformas.cambio,em_precio.mask)
  precio_ant = Dec(em_precio.text)

end subroutine

public subroutine f_consulta_disponible ();str_parametros str
str.s_argumentos[1]= "w_int_venliped"
str.s_argumentos[2]= uo_articulo.em_codigo.text
str.s_argumentos[3]= uo_calidad.em_codigo.text
str.s_argumentos[6]= uo_tipo_pallet.em_codigo.text
str.s_argumentos[7]= uo_caja.em_codigo.text
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

str.i_nargumentos = 7
OpenWithParm(w_con_stock_articulos,str)

end subroutine

public subroutine f_activar_primer_campo ();IF tipo_precio = 2 Then
	f_activar_campo(em_precio)
	Return
END IF

IF var_control_alm = "N" THEN
   f_activar_campo(uo_tipolinea.em_campo)
ELSE
   f_activar_campo(uo_articulo.em_campo)
END IF
end subroutine

public subroutine f_consulta_reservas ();str_parametros str
str.s_argumentos[1]= "w_int_venliped"
str.s_argumentos[2]= uo_articulo.em_codigo.text
str.s_argumentos[3]= uo_calidad.em_codigo.text
str.s_argumentos[6]= uo_tipo_pallet.em_codigo.text
str.s_argumentos[7]= uo_caja.em_codigo.text
str.i_nargumentos = 7
OpenWithParm(w_con_reservas_articulos,str)

end subroutine

public subroutine f_campos_segun_tiplin ();Boolean  sino,sino_articulo
String   var_empresa,var_codigo
String cod_tiplin


	em_cajas.enabled         = TRUE
	em_cantidad.enabled      = TRUE
	em_descripcion.enabled   = TRUE
	em_descuento.enabled     = TRUE
	em_mtrs_lineales.enabled = TRUE
	em_t_pallets.enabled     = TRUE
	uo_articulo.enabled      = TRUE
	uo_calidad.enabled       = TRUE
	uo_tipo_pallet.enabled   = TRUE
	uo_tipolinea.enabled     = TRUE
	

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
         If var_sector = "S" Then
          em_descripcion.TabOrder = em_precio.TabOrder + 1
         Else
          em_descripcion.TabOrder = uo_tipolinea.TabOrder + 1
         End If
   CASE "N"
        em_descripcion.TabOrder = uo_tipolinea.TabOrder + 1
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
    em_mtrs_lineales.enabled       = sino
    em_t_cajas.enabled             = sino
    em_t_pallets.enabled           = sino
    uo_calidad.enabled             = sino
    uo_tipo_pallet.enabled         = sino
    st_texto_mtrslinieales.enabled = sino
    st_cajas.enabled               = sino
    st_calidad.enabled             = sino
    st_pallets.enabled             = sino
    st_tipopallet.enabled          = sino
    st_total_cajas.enabled         = sino
    uo_articulo.enabled            = sino_articulo
    st_articulo.enabled            = sino_articulo



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
   uo_tipo_pallet.em_codigo.text = ""
   uo_tipo_pallet.em_campo.text = ""
   em_mtrs_lineales.text = ""
   em_t_cajas.text = ""
   em_t_pallets.text = ""
   em_cajas.text = ""
END IF
    
IF tipo_precio = 2 Then
	em_cajas.enabled         = False
	em_cantidad.enabled      = False
	em_descripcion.enabled   = False
	em_descuento.enabled     = False
	em_mtrs_lineales.enabled = False
	em_t_pallets.enabled     = False
	uo_articulo.enabled      = False
	uo_calidad.enabled       = False
	uo_tipo_pallet.enabled   = False
	uo_tipolinea.enabled     = False
END IF

end subroutine

public subroutine f_control ();dw_detalle.setredraw(false)
string donde,cuanto
donde=dw_detalle.Object.DataWindow.VerticalScrollPosition
dw_detalle.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(em_proforma.text),tipo_precio)
dw_detalle.Object.DataWindow.VerticalScrollPosition=donde
dw_detalle.setredraw(true)



end subroutine

public subroutine f_peso_linea ();Dec{4} var_total,var_anyo,var_proforma,var_peso_linea
var_anyo     = Dec(em_anyo.text)
var_proforma = Dec(em_proforma.text)
IF len(uo_articulo.em_codigo.text) <> 0  and len(uo_tipo_pallet.em_codigo.text) <> 0 Then
	var_peso_linea= f_calculo_peso(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_t_pallets.text),Dec(em_cantidad.text),uo_caja.em_codigo.text)
Else	
	var_peso_linea=0
END IF
st_peso_linea.text   = String(var_peso_linea,"###,###,###")
Select sum(peso) Into :var_total From venliproformas
Where  empresa  = :codigo_empresa
And    anyo     = :var_anyo
And    proforma = :var_proforma
And    linea    <>:linea_proforma;
IF IsNull(var_total)      Then var_total       =  0
IF IsNull(var_peso_linea) Then var_peso_linea  =  0

st_peso_total.text = String(var_total + var_peso_linea,"###,###,###")
end subroutine

public subroutine f_recalcular_lineas ();str_venliproformas linprofor
Integer  reg,reg1 
Integer procesos




reg1 = dw_detalle.RowCount()
linprofor.empresa   = codigo_empresa
linprofor.anyo      = Integer(em_anyo.text)
linprofor.proforma  = Dec(em_proforma.text)
 
For reg = 1 To reg1 
 linprofor.linea              = Dec(f_valor_columna(dw_detalle,reg,"linea"))
f_actualizar_linea_venproforma(linprofor.empresa,linprofor.anyo,linprofor.proforma,linprofor.linea) 
COMMIT;
NEXT
f_actualizar_venproforma(codigo_empresa,linprofor.anyo,linprofor.proforma)
end subroutine

event open;call super::open;istr_parametros = Message.PowerObjectParm
istr_parametros.s_titulo_ventana="Introducción lineas de proforma"
This.title=istr_parametros.s_titulo_ventana
tipo_precio = 1
dw_detalle.SetTransObject(SQLCA)
dw_pie.SetTransObject(SQLCA)



IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_proforma.text=istr_parametros.s_argumentos[3]	
     IF Trim(em_anyo.text)<>"" and Trim(em_proforma.text)<>"" THEN
         f_control()
     END IF
     istr_parametros.i_nargumentos=0

     
venproformas.anyo   = Dec(em_anyo.text)
venproformas.proforma = Dec(em_proforma.text)


  SELECT venproformas.empresa,venproformas.anyo,
  			venproformas.proforma,venproformas.fproforma,   
         venproformas.falta,venproformas.cliente,
         venproformas.observaciones,venproformas.codpago,
			venproformas.agente1,venproformas.agente2,venproformas.comision1,
			venproformas.comision2,venproformas.comision11,
			venproformas.comision22,venproformas.dtopp,venproformas.dtoesp1,   
         venproformas.dtoesp2,venproformas.dtoesp3,   
         venproformas.dtoesp4,venproformas.tipodto1,   
         venproformas.tipodto2,venproformas.tipodto3,   
         venproformas.tipodto4,venproformas.explicaciondto1,   
         venproformas.explicaciondto2,venproformas.explicaciondto3,   
         venproformas.explicaciondto4,venproformas.tipoiva,   
         venproformas.iva,venproformas.numpedcli,venproformas.idioma,   
         venproformas.divisa,venproformas.cambio,venproformas.tarifa,   
         venproformas.ftarifa,venproformas.fbloqueo,
         venproformas.serie,venproformas.zona,
         venproformas.forma_envio,venproformas.cod_entrega,   
         venproformas.usuario,venproformas.tipo_portes,
			venproformas.periodo_fac,venproformas.peso  ,venproformas.tarifa
         INTO :venproformas.empresa,:venproformas.anyo,:venproformas.proforma,:venproformas.fproforma,   
         :venproformas.falta,:venproformas.cliente,
         :venproformas.observaciones,:venproformas.codpago,:venproformas.agente1,   
         :venproformas.agente2,:venproformas.comision1,:venproformas.comision2,
         :venproformas.comision11,:venproformas.comision22,:venproformas.dtopp,
         :venproformas.dtoesp1,:venproformas.dtoesp2,:venproformas.dtoesp3,:venproformas.dtoesp4,   
         :venproformas.tipodto1,:venproformas.tipodto2,:venproformas.tipodto3,
         :venproformas.tipodto4,:venproformas.explicaciondto1,:venproformas.explicaciondto2,   
         :venproformas.explicaciondto3,:venproformas.explicaciondto4,:venproformas.tipoiva,   
         :venproformas.iva,:venproformas.numpedcli,:venproformas.idioma,:venproformas.divisa,   
         :venproformas.cambio,:venproformas.tarifa,:venproformas.ftarifa,:venproformas.fbloqueo,   
         :venproformas.serie,:venproformas.zona,:venproformas.forma_envio,   
         :venproformas.cod_entrega,:venproformas.usuario,:venproformas.tipo_portes,   
         :venproformas.periodo_fac,:venproformas.peso  ,:venproformas.tarifa
         FROM  venproformas  
         WHERE venproformas.empresa = :codigo_empresa
         AND   venproformas.anyo    = :venproformas.anyo
         AND   venproformas.proforma  = :venproformas.proforma;

IF venproformas.cambio = 0 Then venproformas.cambio = 1

	int li_decimales_precio
	string  ls_mascara_moneda_tarifa
	
	li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,venproformas.tarifa)
	ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)
	
	em_precio.setmask(DecimalMask!,ls_mascara_moneda_tarifa)
	
	f_mascara_columna(dw_detalle,"precio",ls_mascara_moneda_tarifa)
	f_mascara_columna(dw_detalle,"calculo_precio",ls_mascara_moneda_tarifa)

     em_cliente.text = venproformas.cliente
	  IF f_tipo_cliente_venproformas(codigo_empresa,venproformas.anyo,venproformas.proforma) = "S" Then
     	st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)
     ELSE
	    st_nombre_cliente.text = f_nombre_vencliproforma(codigo_empresa,venproformas.cliente)
	END IF

     tipo = "I"
END IF
cb_insertar.TriggerEvent(Clicked!)
f_peso_linea()

end event

event close; longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(string(dec(em_anyo.text))))
 criterio[2]  =  trim(string(dec(em_anyo.text)))+space(20-longitud)
 longitud     =  len(Trim(string(dec(em_proforma.text))))
 criterio[3]  =  trim(string(dec(em_proforma.text)))+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "venproformas"
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

on w_int_venliproformas.create
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
this.em_cantidad=create em_cantidad
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
this.dw_pie=create dw_pie
this.dw_detalle=create dw_detalle
this.em_anyo=create em_anyo
this.gb_3=create gb_3
this.em_situacion=create em_situacion
this.gb_4=create gb_4
this.cb_valorar=create cb_valorar
this.em_proforma=create em_proforma
this.st_4=create st_4
this.st_5=create st_5
this.st_peso_linea=create st_peso_linea
this.gb_1=create gb_1
this.st_2=create st_2
this.em_porcentaje=create em_porcentaje
this.gb_2=create gb_2
this.st_proforma=create st_proforma
this.st_6=create st_6
this.st_peso_total=create st_peso_total
this.st_7=create st_7
this.cb_palmas=create cb_palmas
this.cb_palmenos=create cb_palmenos
this.cb_cajmenos=create cb_cajmenos
this.cb_cajmas=create cb_cajmas
this.gb_5=create gb_5
this.st_caja=create st_caja
this.uo_caja=create uo_caja
this.st_1=create st_1
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
this.Control[iCurrent+13]=this.em_cantidad
this.Control[iCurrent+14]=this.uo_articulo
this.Control[iCurrent+15]=this.uo_calidad
this.Control[iCurrent+16]=this.uo_tipo_pallet
this.Control[iCurrent+17]=this.st_texto_mtrslinieales
this.Control[iCurrent+18]=this.em_mtrs_lineales
this.Control[iCurrent+19]=this.em_cliente
this.Control[iCurrent+20]=this.st_nombre_cliente
this.Control[iCurrent+21]=this.cb_grabar
this.Control[iCurrent+22]=this.cb_borrar
this.Control[iCurrent+23]=this.st_texto_precio
this.Control[iCurrent+24]=this.em_precio
this.Control[iCurrent+25]=this.em_descripcion
this.Control[iCurrent+26]=this.st_33
this.Control[iCurrent+27]=this.cb_insertar
this.Control[iCurrent+28]=this.uo_tipolinea
this.Control[iCurrent+29]=this.st_tplinea
this.Control[iCurrent+30]=this.cb_stock
this.Control[iCurrent+31]=this.cb_reservas
this.Control[iCurrent+32]=this.st_dto
this.Control[iCurrent+33]=this.em_descuento
this.Control[iCurrent+34]=this.dw_pie
this.Control[iCurrent+35]=this.dw_detalle
this.Control[iCurrent+36]=this.em_anyo
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.em_situacion
this.Control[iCurrent+39]=this.gb_4
this.Control[iCurrent+40]=this.cb_valorar
this.Control[iCurrent+41]=this.em_proforma
this.Control[iCurrent+42]=this.st_4
this.Control[iCurrent+43]=this.st_5
this.Control[iCurrent+44]=this.st_peso_linea
this.Control[iCurrent+45]=this.gb_1
this.Control[iCurrent+46]=this.st_2
this.Control[iCurrent+47]=this.em_porcentaje
this.Control[iCurrent+48]=this.gb_2
this.Control[iCurrent+49]=this.st_proforma
this.Control[iCurrent+50]=this.st_6
this.Control[iCurrent+51]=this.st_peso_total
this.Control[iCurrent+52]=this.st_7
this.Control[iCurrent+53]=this.cb_palmas
this.Control[iCurrent+54]=this.cb_palmenos
this.Control[iCurrent+55]=this.cb_cajmenos
this.Control[iCurrent+56]=this.cb_cajmas
this.Control[iCurrent+57]=this.gb_5
this.Control[iCurrent+58]=this.st_caja
this.Control[iCurrent+59]=this.uo_caja
this.Control[iCurrent+60]=this.st_1
end on

on w_int_venliproformas.destroy
call super::destroy
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
destroy(this.em_cantidad)
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
destroy(this.dw_pie)
destroy(this.dw_detalle)
destroy(this.em_anyo)
destroy(this.gb_3)
destroy(this.em_situacion)
destroy(this.gb_4)
destroy(this.cb_valorar)
destroy(this.em_proforma)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_peso_linea)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.em_porcentaje)
destroy(this.gb_2)
destroy(this.st_proforma)
destroy(this.st_6)
destroy(this.st_peso_total)
destroy(this.st_7)
destroy(this.cb_palmas)
destroy(this.cb_palmenos)
destroy(this.cb_cajmenos)
destroy(this.cb_cajmas)
destroy(this.gb_5)
destroy(this.st_caja)
destroy(this.uo_caja)
destroy(this.st_1)
end on

on ue_f2;call w_int_con_empresa::ue_f2;cb_insertar.TriggerEvent(Clicked!)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_venliproformas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_venliproformas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_venliproformas
integer x = 9
integer y = 4
integer width = 2629
integer height = 112
end type

type pb_1 from upb_salir within w_int_venliproformas
integer x = 2729
integer y = 8
integer width = 110
integer height = 104
integer taborder = 0
end type

type st_3 from statictext within w_int_venliproformas
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

type st_texto_cantidad from statictext within w_int_venliproformas
integer x = 2226
integer y = 1108
integer width = 320
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

type st_pallets from statictext within w_int_venliproformas
integer x = 1490
integer y = 1108
integer width = 123
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_total_cajas from statictext within w_int_venliproformas
integer x = 1783
integer y = 1108
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "T.Cj"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cajas from statictext within w_int_venliproformas
integer x = 1614
integer y = 1108
integer width = 169
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cj"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tipopallet from statictext within w_int_venliproformas
integer x = 1376
integer y = 1108
integer width = 114
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_calidad from statictext within w_int_venliproformas
integer x = 1102
integer y = 1108
integer width = 96
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_articulo from statictext within w_int_venliproformas
integer x = 306
integer y = 1108
integer width = 795
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

type em_t_pallets from u_em_campo within w_int_venliproformas
integer x = 1490
integer y = 1184
integer width = 119
integer height = 88
integer taborder = 70
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
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

f_calculo_precio()

end event

event getfocus;call super::getfocus;ante_pallets = Integer(This.text)
campo_actual = "PALLETS"
f_peso_linea()
end event

type em_cajas from u_em_campo within w_int_venliproformas
integer x = 1609
integer y = 1184
integer width = 174
integer height = 88
integer taborder = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena
long   posi,posi_aux

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                           integer(em_t_pallets.text),&
                           integer(em_cajas.text),&
                           Dec(em_cantidad.text))
                      
IF ante_cajas <> Integer(This.text) Then em_mtrs_lineales.text=""
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
f_calculo_precio()

end event

event getfocus;call super::getfocus;ante_cajas = Integer(This.text)
campo_actual = "CAJAS"
f_peso_linea()
end event

type em_t_cajas from u_em_campo within w_int_venliproformas
integer x = 1783
integer y = 1184
integer width = 215
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

type em_cantidad from u_em_campo within w_int_venliproformas
integer x = 2226
integer y = 1184
integer width = 315
integer height = 88
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;IF var_control_alm ="S"  and var_sector = "S" THEN
 	If ante_valor<>Dec(em_cantidad.text) THEN
		em_cajas.text=""
		em_t_cajas.text=""
		em_t_pallets.text=""
		em_mtrs_lineales.text =""
 	END  IF
 	string cadena
 	long   posi,posi_aux
 	
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
END IF
f_peso_linea()
f_calculo_precio()

end event

event getfocus;call super::getfocus;IF var_control_alm = "N" Then st_texto_cantidad.text = "Unidades"
ante_valor= Dec(em_cantidad.text)
campo_actual = "CANTIDAD"
f_peso_linea()
end event

type uo_articulo from u_em_campo_2 within w_int_venliproformas
integer x = 297
integer y = 1184
integer width = 795
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_empresa,codigo_articulo,texto_unidad
string cod_tono,cod_calibre,sector

uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF uo_articulo.em_codigo.text <> articulo_ant  or IsNUll(articulo_ant)Then
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
END IF

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 END IF
  codigo_articulo=uo_articulo.em_codigo.text
  SELECT articulos.empresa,articulos.codigo,articulos.familia ,articulos.formato,articulos.unidad,articulos.sector
    INTO :mov.empresa,:mov.articulo,:cod_familia,:cod_formato,:cod_tipo_unidad,:sector
    FROM articulos  
   WHERE (articulos.empresa = :codigo_empresa) AND  
         (articulos.codigo  = :codigo_articulo);

st_texto_cantidad.text=f_nombre_unidad(cod_tipo_unidad)
uo_calidad.em_codigo.text    = f_calidad_venparametros(codigo_empresa)
uo_calidad.em_campo.text     = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
uo_calidad.ue_valor_anterior = uo_calidad.em_campo.text
em_cantidad.SetMask(DecimalMask!,f_mascara_unidad(cod_tipo_unidad))

if sector = "S" then 
	IF len(Trim(uo_articulo.em_codigo.text))<> 0 Then
		string tipo_cli
		tipo_cli = f_cliente_sino_venproformas(codigo_empresa,dec(em_anyo.text),dec(em_proforma.text))
		if tipo_cli ="S" then
			uo_tipo_pallet.em_codigo.text = f_pallet_almartpallet_cliente(codigo_empresa,uo_articulo.em_codigo.text,em_cliente.text)
		 else
			uo_tipo_pallet.em_codigo.text = f_pallet_almartpallet_no_cliente(codigo_empresa,uo_articulo.em_codigo.text,em_cliente.text) 
		End if
		uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
		uo_tipo_pallet.ue_valor_anterior = uo_tipo_pallet.em_campo.text  
	END IF
End if

f_campos_segun_tiplin()
f_peso_linea()
f_calculo_precio() 
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

type uo_calidad from u_em_campo_2 within w_int_venliproformas
integer x = 1097
integer y = 1184
integer width = 96
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF
IF calidad_ant <> uo_calidad.em_codigo.text Then
   f_calculo_precio()
END IF

end on

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

type uo_tipo_pallet from u_em_campo_2 within w_int_venliproformas
integer x = 1381
integer y = 1184
integer width = 110
integer height = 88
integer taborder = 60
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

type st_texto_mtrslinieales from statictext within w_int_venliproformas
integer x = 2002
integer y = 1108
integer width = 224
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "M. Lin"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_mtrs_lineales from u_em_campo within w_int_venliproformas
integer x = 1998
integer y = 1184
integer width = 229
integer height = 88
integer taborder = 90
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
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
long   posi,posi_aux
cadena=f_calculo_unidades_lineales(codigo_empresa,uo_articulo.em_codigo.text,&
								 uo_tipo_pallet.em_codigo.text,&
								 uo_caja.em_codigo.text,&
								 Dec(em_mtrs_lineales.text))
						  
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
f_calculo_precio()

end event

type em_cliente from u_em_campo within w_int_venliproformas
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

type st_nombre_cliente from statictext within w_int_venliproformas
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

type cb_grabar from u_boton within w_int_venliproformas
integer x = 1472
integer y = 1368
integer width = 334
integer height = 68
integer taborder = 0
string text = "F3 Grabar  "
end type

event clicked;Dec{0} var_anyo,var_proforma,ln_ant
Dec{4} var_precio
String mascara,art

art = uo_articulo.em_codigo.text
IF IsNUll(art) Then art = ""


mascara      = f_mascara_moneda(venproformas.divisa)
ln_ant       = dw_detalle.GetRow()
var_anyo     = Dec(em_anyo.text)
var_proforma = Dec(em_proforma.text)
var_precio   = Dec(em_precio.text)

IF tipo_precio = 2 Then
	f_grabar_linea()
	f_control()
	return
END IF

String motivo,controles,referencia,condicion,tipo_unidad,texto,acumular,condicion2
Integer  opcion,var_linea_acumulado
dec{2}   disponible,var_conjunto,diferencia,piezas_caja,dife,var_precio1,var_precio2
EditMask campo

IF Trim(art) = "" Then
	piezas_caja = 0
	tipo_unidad = ""
ELSE
   piezas_caja = f_piezascaja_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)
   tipo_unidad = f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)
End if	
IF This.visible = FALSE Then RETURN
controles="N"
acumular  = "N" 

IF var_control_alm ="S" and var_sector = "S" THEN
	 em_cajas.text=""
	 em_t_cajas.text=""
	 em_t_pallets.text=""
	 em_mtrs_lineales.text =""
	 string cadena
	 long   posi,posi_aux
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

	 // Control clase_pallet que coincida

	 String tipo_cli
	 tipo_cli = f_cliente_sino_venproformas(codigo_empresa,dec(em_anyo.text),dec(em_proforma.text))
	 if tipo_cli = "S" then
				IF f_tipo_pallet_venclientes(codigo_empresa,em_cliente.text) <> f_clase_pallets(codigo_empresa,uo_tipo_pallet.em_codigo.text) Then
					 IF MessageBox("El tipo de pallet no coincide segun el cliente","¿ Desea Grabar la linea ?",Question!, YesNo!,2) = 2 Then
						 f_activar_campo(uo_tipo_pallet.em_campo)
						Return
					END IF
				END IF
			Else
				IF f_tipo_pallet_vencliproformas(codigo_empresa,em_cliente.text) <> f_clase_pallets(codigo_empresa,uo_tipo_pallet.em_codigo.text) Then
					 IF MessageBox("El tipo de pallet no coincide segun el cliente","¿ Desea Grabar la linea ?",Question!, YesNo!,2) = 2 Then
						 f_activar_campo(uo_tipo_pallet.em_campo)
						Return
					END IF
				END IF
    End if

	 
	 IF var_control_alm ="S"  and var_sector = "S" THEN
	  uo_tipo_pallet.TriggerEvent("modificado")
	  IF TRIM(uo_tipo_pallet.em_campo.text)="" or IsNull(uo_tipo_pallet.em_campo.text) Then
			campo=uo_tipo_pallet.em_campo
			motivo= "(Campo Obligatorio) Introduzca el tipo de pallet"
			controles="S"
	  END IF
	 END IF

	 IF var_control_alm ="S"  and var_sector = "S" THEN
	  uo_caja.TriggerEvent("modificado")
	  IF TRIM(uo_caja.em_campo.text)="" or IsNull(uo_caja.em_campo.text) Then
			campo=uo_caja.em_campo
			motivo= "(Campo Obligatorio) Introduzca el tipo de caja"
			controles="S"
	  END IF
	end if

	 IF tipo_unidad = "0" Then
		  // control cajas sueltas
			  diferencia = Dec(em_cantidad.text) - (Dec(em_t_cajas.text) * piezas_caja) 
			  CHOOSE CASE diferencia
					 CASE IS < 0
						 dife = ABS(diferencia)
					 CASE IS > 0
						 dife = piezas_caja - diferencia
					 CASE ELSE
						 dife=0
			  END CHOOSE
			  IF diferencia <> 0 then
				 If  MessageBox("Observaciones","faltan " + String(abs(dife),"####") + " Piezas para completar la caja            ¿Desea grabar la linea? ",Question!, YesNo!,2) = 2 Then
				 em_cantidad.text = String(Dec(em_cantidad.text) + dife)
				 f_activar_campo(em_cantidad)
				 Return
			  END IF
		  END IF
	  END IF
END IF

IF Trim(uo_tipolinea.em_codigo.text) = "" or Trim(uo_tipolinea.em_campo.text)= ""  Then
  campo     = uo_tipolinea.em_campo
  motivo    = "(Campo Obligatorio) Introduzca el tipo de linea"
  controles = "S"
END IF

IF Dec(em_cantidad.text) = 0  or IsNull(em_cantidad.text) Then
   campo=em_cantidad
   motivo= "(Campo Obligatorio) Introduzca la cantidad"
   controles="S"
END IF

IF var_control_alm ="S" and var_sector ="S" THEN
  IF Trim(uo_calidad.em_codigo.text) = ""  or IsNull(uo_articulo.em_codigo.text) Then
   campo=uo_calidad.em_campo
   motivo= "(Campo Obligatorio) Introduzca la calidad"
   controles="S"
  END IF
END IF

IF var_control_alm = "S" THEN
  IF Trim(uo_articulo.em_codigo.text) = ""  or IsNull(uo_articulo.em_codigo.text) Then
   campo=uo_articulo.em_campo
   motivo= "(Campo Obligatorio) Introduzca el articulo"
   controles="S"
  END IF
 
  // Control piezas por conjunto
     var_conjunto= f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
     IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
      IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
          motivo= "Cantidad no valida Este articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto,"##")
          controles="S"
          campo= em_cantidad
      END IF
END IF


END IF

IF Trim(em_descripcion.text) = ""  or IsNull(em_descripcion.text) Then
   campo=em_descripcion
   motivo= "(Campo Obligatorio) Introduzca la descripcion"
   controles="S"
END IF


IF controles="S" THEN
 MessageBox("No se puede grabar la linea",motivo,Exclamation!, OK!,1)
 f_activar_campo(campo)
 Return
END IF

// Control clase de venta
var_clase ="V"
IF var_control_alm ="S" THEN
  referencia  = f_componer_ref(uo_articulo.em_codigo.text,&
                             uo_calidad.em_codigo.text,"",0)

						  
  
  em_situacion.text="C"
  
 

  // V-> Venta (típica)
  // M-> Muestras sin precio
  // S-> Ventas sin cargo

  IF dec(em_precio.text) = 0  or IsNull(em_precio.text) Then
   campo=em_precio
   motivo= "(Campo Obligatorio) Introduzca el precio"
   controles="S"
   tipo_array arg
   arg.valor[1]  = "Linea de Proforma Sin precio"
   arg.valor[11] = "Muestras"
   arg.valor[12] = "Sin Cargo"
   arg.valor[13] = "Cancelar" 
   opcion = f_opciones(arg)
   CHOOSE CASE opcion
 	 CASE 1
		var_clase ="M"
    CASE 2
		var_clase ="S"
	 CASE 3
		 f_activar_campo(em_precio)
		 Return
   END CHOOSE

    END IF
   END IF



//-------------------------------------------------------------------------
// controlo si existe alguna linea al mismo articulo el pedido par informar
//-------------------------------------------------------------------------

IF var_control_alm = "S" THEN
	
 condicion2 = " empresa       = '"  +  String(codigo_empresa) + "' " + &
              " and anyo      =  "  +  em_anyo.text + &
              " and proforma    =  "  +  em_proforma.text + &
              " and articulo  =  '" +  uo_articulo.em_codigo.text + "'" +&
   			  " and calidad   =  '" +  uo_calidad.em_codigo.text + "'" +&
				  " and tipo_pallet   =   '" +  uo_tipo_pallet.em_codigo.text + "'"  +&
				  " and String(precio,'"+mascara+"') =   '" + String(Dec(em_precio.text),mascara) +"'"+&
				  " and linea  <>  " + String(linea_proforma)
				  
//				  " and dtoesp =   " +  em_descuento.text   +&
  var_linea_acumulado = dw_detalle.find(condicion2,1,dw_detalle.RowCount()) 

  IF var_linea_acumulado <> 0 Then
     opcion = MessageBox("Existen mas lineas a este articulo al mismo precio ","Acumular a la linea existente?",Question!, YesNo!,2)
     IF opcion = 1 Then
        acumular="S"
     ELSE
   	  acumular ="N"
     END IF
  END IF
END IF

IF var_control_alm = "N" Then
  SetNull(uo_articulo.text)
  SetNull(uo_calidad.text)
  SetNull(uo_tipo_pallet.text)
  SetNull(referencia)
  // Siempre se graban el situacion= "C" 
  em_situacion.text="C"
END IF
IF acumular = "S" Then
	
	IF tipo = "M" Then
		Delete from venliproformas
		Where  venliproformas.empresa  = :codigo_empresa
		And    venliproformas.anyo     = :var_anyo
		And    venliproformas.proforma = :var_proforma
		And    venliproformas.linea    = :linea_proforma;
	END IF
	linea_proforma = dw_detalle.GetItemNumber(var_linea_acumulado,"linea")
	tipo= "M"
   em_cantidad.text =  String(Dec(em_cantidad.text) + Dec(f_valor_columna(dw_detalle,var_linea_acumulado,"cantidad") 	))
 em_cajas.text=""
 em_t_cajas.text=""
 em_t_pallets.text=""
 em_mtrs_lineales.text =""
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
END If

f_grabar_linea()

f_control()
IF tipo = "I" Then dw_detalle.ScrollToRow(dw_detalle.RowCount())
f_botones()
cb_insertar.TriggerEvent(clicked!)
articulo_ant=""
//dw_detalle.ScrollTorow(dw_detalle.RowCount())
COMMIT;
end event

type cb_borrar from u_boton within w_int_venliproformas
integer x = 1806
integer y = 1300
integer width = 379
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F4 Borrar     "
end type

event clicked;call super::clicked;IF This.enabled = FALSE Then RETURN
If MessageBox("Comfirmacion Baja linea de pedido","Desa borra la linea de pedido seleccionada",Question!, YesNo!,2)= 2 Then
  f_activar_primer_campo()
  Return
END IF


f_borrar_linea()
f_control()
cb_insertar.TriggerEvent(clicked!)
COMMIT;
end event

type st_texto_precio from statictext within w_int_venliproformas
integer x = 2546
integer y = 1108
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_precio from u_em_campo within w_int_venliproformas
integer x = 2542
integer y = 1184
integer width = 311
integer height = 88
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.00"
end type

event modificado;call super::modificado;This.text = String(Dec(This.text),f_mascara_precios_moneda(venproformas.divisa))
campo_actual = "PRECIO"

end event

type em_descripcion from u_em_campo within w_int_venliproformas
integer x = 5
integer y = 1360
integer width = 1170
integer taborder = 130
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCRIPCION"
end on

type st_33 from statictext within w_int_venliproformas
integer x = 9
integer y = 1284
integer width = 1170
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Descripción artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_insertar from u_boton within w_int_venliproformas
integer x = 1472
integer y = 1300
integer width = 334
integer height = 68
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;call super::clicked;control_incremento = "S"
tipo="I"
linea_proforma = 0
em_cajas.text=""
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
uo_tipolinea.em_codigo.text="100"
uo_tipolinea.em_campo.text = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
uo_tipolinea.TriggerEvent("modificado")
em_situacion.text="C"
f_botones()
dw_detalle.SelectRow(0,FALSE)
f_activar_primer_campo()
f_peso_linea()
end event

type uo_tipolinea from u_em_campo_2 within w_int_venliproformas
integer x = 9
integer y = 1184
integer width = 293
integer height = 88
integer taborder = 20
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
ELSE
IF tipolinea_ant <> this.em_codigo.text Then 
//  IF var_control_alm = "N" THEN f_activar_campo(em_cantidad)
//  IF var_control_alm = "S" THEN f_activar_campo(uo_articulo.em_campo)
END IF
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

type st_tplinea from statictext within w_int_venliproformas
integer x = 9
integer y = 1108
integer width = 297
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tp. linea"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stock from u_boton within w_int_venliproformas
integer x = 1806
integer y = 1368
integer width = 379
integer height = 68
integer taborder = 0
string text = "F5 Ver stock"
end type

event clicked;call super::clicked;IF This.enabled = FALSE Then RETURN
str_parametros valores
       IF var_control_alm = "N" Then Return
       f_consulta_disponible()
       IF Message.DoubleParm=-1  THEN 
       ELSE
          valores = Message.PowerObjectParm
          uo_articulo.em_campo.text= f_nombre_articulo(codigo_empresa,valores.s_argumentos[1])
          uo_articulo.em_codigo.text= valores.s_argumentos[1]
          uo_calidad.em_campo.text  = f_nombre_calidad_abr(codigo_empresa,valores.s_argumentos[2])
	   	 uo_calidad.em_codigo.text= valores.s_argumentos[2]
		    uo_tipo_pallet.em_campo.text = f_nombre_pallet_abr(codigo_empresa,valores.s_argumentos[5])
		    uo_tipo_pallet.em_codigo.text= valores.s_argumentos[5]
			 uo_articulo.ue_valor_anterior = uo_articulo.em_campo.text
			 uo_tipo_pallet.ue_valor_anterior = uo_tipo_pallet.em_campo.text
			 uo_calidad.ue_valor_anterior = uo_calidad.em_campo.text
        END IF
//       f_activar_campo(uo_articulo.em_campo)

end event

type cb_reservas from u_boton within w_int_venliproformas
integer x = 2185
integer y = 1300
integer width = 375
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

type st_dto from statictext within w_int_venliproformas
integer x = 1184
integer y = 1284
integer width = 197
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_descuento from u_em_campo within w_int_venliproformas
integer x = 1184
integer y = 1360
integer width = 197
integer taborder = 140
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "#0.00"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCUENTO"
end on

type dw_pie from datawindow within w_int_venliproformas
boolean visible = false
integer x = 329
integer y = 336
integer width = 2185
integer height = 764
integer taborder = 150
boolean titlebar = true
string title = "Pie de proformas"
string dataobject = "dw_int_venliproformas3"
boolean controlmenu = true
boolean livescroll = true
end type

on clicked;This.visible = FALSE
f_activar_primer_campo()
end on

type dw_detalle from datawindow within w_int_venliproformas
integer y = 248
integer width = 2848
integer height = 860
string dataobject = "dw_int_venliproformas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then 
   f_activar_campo(uo_articulo.em_campo)
   Return
End IF
This.SelectRow(0,FALSE)
This.SelectRow(Row,TRUE)


uo_tipolinea.em_codigo.text =This.GetItemString(Row,"tipolinea")
uo_tipolinea.em_campo.text   = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
uo_tipolinea.TriggerEvent("modificado")

em_cajas.text                 = String(This.GetItemNumber(Row,"cajas"))
ante_existencias              = Dec(em_cantidad.text)
em_descripcion.text           = This.GetItemString(Row,"descripcion")
em_mtrs_lineales.text         = String(This.GetItemNumber(Row,"metros_lineales"))
ante_valor                    = This.GetItemNumber(Row,"precio")
em_precio.text                = f_valor_columna(This,Row,"calculo_precio")
em_descuento.text             = String(This.GetItemNumber(Row,"dtoesp"))
em_situacion.text             = This.GetItemString(Row,"situacion")
em_t_cajas.text               = String(This.GetItemNumber(Row,"total_cajas"))
uo_articulo.em_codigo.text    = This.GetItemString(Row,"articulo")
uo_calidad.em_codigo.text     = This.GetItemString(Row,"calidad")
uo_tipo_pallet.em_codigo.text = This.GetItemString(Row,"tipo_pallet")
uo_caja.em_codigo.text = This.GetItemString(Row,"venliproformas_caja")
em_t_pallets.text             = String(This.GetItemNumber(Row,"pallets"))
linea_proforma                 = This.GetItemNumber(Row,"linea")
control_incremento            = This.GetItemString(Row,"control_incremento")
uo_articulo.em_campo.text     = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
articulo_ant                  = uo_articulo.em_codigo.text
uo_articulo.em_campo.TriggerEvent(getfocus!)
uo_calidad.em_campo.text      = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
uo_caja.em_campo.text         = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)
referencia_ant                = String(This.GetItemString(Row,"referencia"))
tipopallet_ant                = String(This.GetItemString(Row,"tipo_pallet"))
cod_familia                   = String(This.GetItemString(Row,"familia"))
cod_formato                   = String(This.GetItemString(Row,"formato"))
cod_tipo_unidad                   = String(This.GetItemString(Row,"tipo_unidad"))
st_texto_cantidad.text=f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
em_cantidad.SetMask(DecimalMask!,f_mascara_unidad(cod_tipo_unidad))
em_cantidad.text              = String(This.GetItemNumber(Row,"cantidad"))

tipo="M"
f_botones()
f_campos_segun_tiplin()
f_activar_primer_campo()
f_peso_linea()
Return
end event

type em_anyo from u_em_campo within w_int_venliproformas
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

type gb_3 from groupbox within w_int_venliproformas
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

type em_situacion from u_em_campo within w_int_venliproformas
boolean visible = false
integer x = 23
integer y = 1448
integer width = 123
integer taborder = 110
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_int_venliproformas
integer x = 1554
integer y = 1184
integer width = 1211
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_valorar from u_boton within w_int_venliproformas
integer x = 2185
integer y = 1368
integer width = 375
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F7 Valorar   "
end type

event clicked;call super::clicked;dw_pie.visible = TRUE
dw_pie.InsertRow(1)
dw_pie.SetItem(1,"pie",f_pie_proforma(venproformas.empresa,venproformas.anyo,venproformas.proforma))
f_activar_primer_campo()


end event

type em_proforma from u_em_campo within w_int_venliproformas
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

type st_4 from statictext within w_int_venliproformas
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

type st_5 from statictext within w_int_venliproformas
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

type st_peso_linea from statictext within w_int_venliproformas
integer x = 2606
integer y = 176
integer width = 233
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

type gb_1 from groupbox within w_int_venliproformas
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

type st_2 from statictext within w_int_venliproformas
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

type em_porcentaje from u_em_campo within w_int_venliproformas
boolean visible = false
integer x = 878
integer y = 136
integer width = 151
integer taborder = 0
integer weight = 400
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###"
string displaydata = ""
end type

event tecla_enter;call super::tecla_enter;Dec{4} var_porcentaje
Dec{0} var_anyo,var_proforma
var_porcentaje = Dec(em_porcentaje.text)
var_anyo     = Dec(em_anyo.text)
var_proforma = Dec(em_proforma.text)

IF messageBox("Proceso volcado de precios","Desea Volcar precios al "+ em_porcentaje.text +" %",Question!,YesNo!,2) = 1 Then
   UPDATE venliproformas	
	Set    venliproformas.precio_aduana = venliproformas.precio * :var_porcentaje/100
	Where  venliproformas.empresa  = :codigo_empresa
   And  	 venliproformas.anyo     = :var_anyo
	And    venliproformas.proforma = :var_proforma;
	UPDATE venproformas	
	Set    venproformas.porcentaje_aduana = :var_porcentaje
	Where  venproformas.empresa  = :codigo_empresa
   And  	 venproformas.anyo     = :var_anyo
	And    venproformas.proforma = :var_proforma;
	COMMIT;
	f_control()
	f_recalcular_lineas()
	COMMIT;
	f_control()
END IF
end event

type gb_2 from groupbox within w_int_venliproformas
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

type st_proforma from dropdownlistbox within w_int_venliproformas
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
string text = "Proforma"
boolean vscrollbar = true
string item[] = {"Proforma","Aduana"}
end type

event selectionchanged;Dec{4}  var_porcentaje
Dec{0}  var_anyo,var_proforma

var_anyo= Dec(em_anyo.text)
var_proforma= Dec(em_proforma.text)

IF This.Text = "Aduana" Then
  tipo_precio = 2
  em_porcentaje.visible = TRUE
	Select venproformas.porcentaje_aduana Into	:var_porcentaje
	From   venproformas
	Where  venproformas.empresa  = :codigo_empresa
   And  	 venproformas.anyo     = :var_anyo
	And    venproformas.proforma = :var_proforma;
	em_porcentaje.text = String(var_porcentaje)
ELSE
	 tipo_precio = 1
    em_porcentaje.visible = FALSE
END IF
f_control()


f_campos_segun_tiplin()
f_botones()
f_activar_primer_campo()
end event

type st_6 from statictext within w_int_venliproformas
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

type st_peso_total from statictext within w_int_venliproformas
integer x = 2606
integer y = 124
integer width = 233
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

type st_7 from statictext within w_int_venliproformas
integer x = 2597
integer y = 120
integer width = 247
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

type cb_palmas from u_boton within w_int_venliproformas
event clicked pbm_bnclicked
integer x = 2560
integer y = 1300
integer width = 169
integer height = 68
integer taborder = 0
string text = "Pal(+)"
end type

event clicked;Dec pall,vanyo,vproforma,vlinea,vcajas,vtotal_cajas,vcantidad,vpeso,vpeso_neto
string varticulo,vtipo_pallet,v_caja
IF dw_detalle.GetRow() <> 0 Then
IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall         = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	vcajas       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	vcantidad    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cantidad")
	vtotal_cajas = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo        = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vproforma    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"proforma")
	vlinea       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
	varticulo    = dw_detalle.GetItemString(dw_detalle.GetRow(),"articulo")
	vtipo_pallet = dw_detalle.GetItemString(dw_detalle.GetRow(),"tipo_pallet")
	v_caja        = dw_detalle.GetItemString(dw_detalle.GetRow(),"caja")	

	IF IsNull(pall) Then pall = 0
	pall = pall +1
	
	vpeso                = f_calculo_peso(codigo_empresa,varticulo,vtipo_pallet,vcajas,vtotal_cajas,pall,vcantidad,v_caja)
   vpeso_neto           = f_calculo_peso_neto(codigo_empresa,varticulo,vcajas,vtotal_cajas,vcantidad,v_caja)
	
	dw_detalle.SetItem(dw_detalle.GetRow(),"pallets",pall)
	Update venliproformas
	Set pallets   = :pall,
	    peso      = :vpeso,
		 peso_neto = :vpeso_neto
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   proforma = :vproforma
	And   linea   = :vlinea;
	Commit;
	f_actualizar_venproforma(codigo_empresa,vanyo,vproforma)
END IF
end event

type cb_palmenos from u_boton within w_int_venliproformas
event clicked pbm_bnclicked
integer x = 2729
integer y = 1300
integer width = 105
integer height = 68
integer taborder = 0
string text = "(-)"
end type

event clicked;Dec pall,vanyo,vproforma,vlinea,vcajas,vtotal_cajas,vcantidad,vpeso,vpeso_neto
string varticulo,vtipo_pallet,v_caja
IF dw_detalle.GetRow() <> 0 Then
IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall         = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	vcajas       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	vcantidad    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cantidad")
	vtotal_cajas = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo        = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vproforma    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"proforma")
	vlinea       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
	varticulo    = dw_detalle.GetItemString(dw_detalle.GetRow(),"articulo")
	vtipo_pallet = dw_detalle.GetItemString(dw_detalle.GetRow(),"tipo_pallet")
	v_caja       = dw_detalle.GetItemString(dw_detalle.GetRow(),"caja")	

	IF IsNull(pall) Then pall = 0
	if pall = 0 then Return
	pall = pall - 1
	
	vpeso                = f_calculo_peso(codigo_empresa,varticulo,vtipo_pallet,vcajas,vtotal_cajas,pall,vcantidad,v_caja)
   vpeso_neto           = f_calculo_peso_neto(codigo_empresa,varticulo,vcajas,vtotal_cajas,vcantidad,v_caja)
	
	dw_detalle.SetItem(dw_detalle.GetRow(),"pallets",pall)
	Update venliproformas
	Set pallets   = :pall,
	    peso      = :vpeso,
		 peso_neto = :vpeso_neto
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   proforma = :vproforma
	And   linea   = :vlinea;
	Commit;
	f_actualizar_venproforma(codigo_empresa,vanyo,vproforma)
END IF

end event

type cb_cajmenos from u_boton within w_int_venliproformas
event clicked pbm_bnclicked
integer x = 2729
integer y = 1368
integer width = 105
integer height = 68
integer taborder = 0
string text = "(-)"
end type

event clicked;String varticulo,vtipo_pallet,v_caja
Dec cj,tcj,vanyo,vproforma,vlinea,vcantidad,vpeso,vpeso_neto,pall
IF dw_detalle.GetRow() <> 0 Then
IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall         = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	cj           = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	tcj          = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo        = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vproforma    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"proforma")
	vlinea       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
	varticulo    = dw_detalle.GetItemString(dw_detalle.GetRow(),"articulo")
	vtipo_pallet = dw_detalle.GetItemString(dw_detalle.GetRow(),"tipo_pallet")
	v_caja       = dw_detalle.GetItemString(dw_detalle.GetRow(),"caja")	
	vcantidad    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cantidad")
	
	IF IsNull(cj) Then cj = 0
	if cj=0 then return
	cj = cj -1
	IF IsNull(tcj) Then tcj = 0
	tcj = tcj -1
	
	vpeso                = f_calculo_peso(codigo_empresa,varticulo,vtipo_pallet,cj,tcj,pall,vcantidad,v_caja)
   vpeso_neto           = f_calculo_peso_neto(codigo_empresa,varticulo,cj,tcj,vcantidad,v_caja)

	dw_detalle.SetItem(dw_detalle.GetRow(),"cajas",cj)
	dw_detalle.SetItem(dw_detalle.GetRow(),"total_cajas",tcj)
	
	Update venliproformas
	Set cajas       = :cj,
	    total_cajas = :tcj,
		 peso        = :vpeso,
		 peso_neto   = :vpeso_neto
	Where empresa  = :codigo_empresa
	And   anyo     = :vanyo
	And   proforma = :vproforma
	And   linea    = :vlinea;
	Commit;
	f_actualizar_venproforma(codigo_empresa,vanyo,vproforma)
END IF

end event

type cb_cajmas from u_boton within w_int_venliproformas
event clicked pbm_bnclicked
integer x = 2560
integer y = 1368
integer width = 169
integer height = 68
integer taborder = 0
string text = "Caj(+)"
end type

event clicked;String varticulo,vtipo_pallet,v_caja
Dec cj,tcj,vanyo,vproforma,vlinea,vcantidad,vpeso,vpeso_neto,pall
IF dw_detalle.GetRow() <> 0 Then
IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall         = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	cj           = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	tcj          = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo        = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vproforma    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"proforma")
	vlinea       = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea")
	varticulo    = dw_detalle.GetItemString(dw_detalle.GetRow(),"articulo")
	vtipo_pallet = dw_detalle.GetItemString(dw_detalle.GetRow(),"tipo_pallet")
	v_caja       = dw_detalle.GetItemString(dw_detalle.GetRow(),"caja")	
	vcantidad    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cantidad")
	
	IF IsNull(cj) Then cj = 0
	cj = cj +1
	IF IsNull(tcj) Then tcj = 0
	tcj = tcj +1
	
	vpeso                = f_calculo_peso(codigo_empresa,varticulo,vtipo_pallet,cj,tcj,pall,vcantidad,v_caja)
   vpeso_neto           = f_calculo_peso_neto(codigo_empresa,varticulo,cj,tcj,vcantidad,v_caja)

	dw_detalle.SetItem(dw_detalle.GetRow(),"cajas",cj)
	dw_detalle.SetItem(dw_detalle.GetRow(),"total_cajas",tcj)
	
	Update venliproformas
	Set cajas       = :cj,
	    total_cajas = :tcj,
		 peso        = :vpeso,
		 peso_neto   = :vpeso_neto
	Where empresa  = :codigo_empresa
	And   anyo     = :vanyo
	And   proforma = :vproforma
	And   linea    = :vlinea;
	Commit;
	f_actualizar_venproforma(codigo_empresa,vanyo,vproforma)
END IF


end event

type gb_5 from groupbox within w_int_venliproformas
integer x = 1454
integer y = 1264
integer width = 1394
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_caja from statictext within w_int_venliproformas
integer x = 1198
integer y = 1108
integer width = 178
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_venliproformas
event destroy ( )
integer x = 1198
integer y = 1184
integer width = 178
integer height = 88
integer taborder = 50
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

//f_peso_linea()	
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
campo_actual = "CAJA"



end event

type st_1 from statictext within w_int_venliproformas
integer x = 302
integer y = 1460
integer width = 2350
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 553648127
string text = "NO USAR CON ARTÍCULOS DE MUESTRA DADOS DE ALTA CON UNIDAD METROS"
boolean focusrectangle = false
end type

