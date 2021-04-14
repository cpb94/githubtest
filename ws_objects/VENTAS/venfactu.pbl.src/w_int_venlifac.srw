$PBExportHeader$w_int_venlifac.srw
forward
global type w_int_venlifac from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_venlifac
end type
type st_3 from statictext within w_int_venlifac
end type
type st_texto_cantidad from statictext within w_int_venlifac
end type
type st_pallets from statictext within w_int_venlifac
end type
type st_total_cajas from statictext within w_int_venlifac
end type
type st_cajas from statictext within w_int_venlifac
end type
type st_tipopallet from statictext within w_int_venlifac
end type
type st_calidad from statictext within w_int_venlifac
end type
type st_articulo from statictext within w_int_venlifac
end type
type em_t_pallets from u_em_campo within w_int_venlifac
end type
type em_cajas from u_em_campo within w_int_venlifac
end type
type em_t_cajas from u_em_campo within w_int_venlifac
end type
type em_cantidad from u_em_campo within w_int_venlifac
end type
type uo_articulo from u_em_campo_2 within w_int_venlifac
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_venlifac
end type
type st_texto_mtrslinieales from statictext within w_int_venlifac
end type
type em_mtrs_lineales from u_em_campo within w_int_venlifac
end type
type em_cliente from u_em_campo within w_int_venlifac
end type
type st_nombre_cliente from statictext within w_int_venlifac
end type
type cb_grabar from u_boton within w_int_venlifac
end type
type cb_borrar from u_boton within w_int_venlifac
end type
type st_texto_precio from statictext within w_int_venlifac
end type
type em_precio from u_em_campo within w_int_venlifac
end type
type em_descripcion from u_em_campo within w_int_venlifac
end type
type st_33 from statictext within w_int_venlifac
end type
type cb_insertar from u_boton within w_int_venlifac
end type
type uo_tipolinea from u_em_campo_2 within w_int_venlifac
end type
type st_tplinea from statictext within w_int_venlifac
end type
type cb_stock from u_boton within w_int_venlifac
end type
type cb_reservas from u_boton within w_int_venlifac
end type
type st_dto from statictext within w_int_venlifac
end type
type em_descuento from u_em_campo within w_int_venlifac
end type
type dw_pie from datawindow within w_int_venlifac
end type
type em_anyo from u_em_campo within w_int_venlifac
end type
type gb_6 from groupbox within w_int_venlifac
end type
type gb_3 from groupbox within w_int_venlifac
end type
type em_situacion from u_em_campo within w_int_venlifac
end type
type gb_4 from groupbox within w_int_venlifac
end type
type cb_valorar from u_boton within w_int_venlifac
end type
type em_factura from u_em_campo within w_int_venlifac
end type
type st_4 from statictext within w_int_venlifac
end type
type st_5 from statictext within w_int_venlifac
end type
type st_peso_linea from statictext within w_int_venlifac
end type
type gb_1 from groupbox within w_int_venlifac
end type
type st_2 from statictext within w_int_venlifac
end type
type em_porcentaje from u_em_campo within w_int_venlifac
end type
type st_proforma from dropdownlistbox within w_int_venlifac
end type
type st_6 from statictext within w_int_venlifac
end type
type st_peso_total from statictext within w_int_venlifac
end type
type st_7 from statictext within w_int_venlifac
end type
type st_tono from statictext within w_int_venlifac
end type
type em_tono from u_em_campo within w_int_venlifac
end type
type em_calibre from u_em_campo within w_int_venlifac
end type
type gb_2 from groupbox within w_int_venlifac
end type
type uo_caja from u_em_campo_2 within w_int_venlifac
end type
type st_dto2 from statictext within w_int_venlifac
end type
type em_descuento2 from u_em_campo within w_int_venlifac
end type
type st_calibre from statictext within w_int_venlifac
end type
type st_caja from statictext within w_int_venlifac
end type
type em_observ_lin from u_em_campo within w_int_venlifac
end type
type st_44 from statictext within w_int_venlifac
end type
type st_texto_npal from statictext within w_int_venlifac
end type
type em_npal from u_em_campo within w_int_venlifac
end type
type p_1 from picture within w_int_venlifac
end type
type st_moneda from statictext within w_int_venlifac
end type
type st_idioma from statictext within w_int_venlifac
end type
type uo_idioma from u_em_campo_2 within w_int_venlifac
end type
type uo_calidad from u_em_campo_2 within w_int_venlifac
end type
type cb_palmas from u_boton within w_int_venlifac
end type
type cb_cajmas from u_boton within w_int_venlifac
end type
type cb_cajmenos from u_boton within w_int_venlifac
end type
type cb_palmenos from u_boton within w_int_venlifac
end type
type em_tono_imprimir from u_em_campo within w_int_venlifac
end type
type em_calibre_imprimir from u_em_campo within w_int_venlifac
end type
type st_1 from statictext within w_int_venlifac
end type
type st_8 from statictext within w_int_venlifac
end type
type dw_detalle from datawindow within w_int_venlifac
end type
type em_cantidad_en_pzs from u_em_campo within w_int_venlifac
end type
type em_precio_pzs from u_em_campo within w_int_venlifac
end type
end forward

global type w_int_venlifac from w_int_con_empresa
integer width = 5083
integer height = 2700
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
em_anyo em_anyo
gb_6 gb_6
gb_3 gb_3
em_situacion em_situacion
gb_4 gb_4
cb_valorar cb_valorar
em_factura em_factura
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
em_calibre em_calibre
gb_2 gb_2
uo_caja uo_caja
st_dto2 st_dto2
em_descuento2 em_descuento2
st_calibre st_calibre
st_caja st_caja
em_observ_lin em_observ_lin
st_44 st_44
st_texto_npal st_texto_npal
em_npal em_npal
p_1 p_1
st_moneda st_moneda
st_idioma st_idioma
uo_idioma uo_idioma
uo_calidad uo_calidad
cb_palmas cb_palmas
cb_cajmas cb_cajmas
cb_cajmenos cb_cajmenos
cb_palmenos cb_palmenos
em_tono_imprimir em_tono_imprimir
em_calibre_imprimir em_calibre_imprimir
st_1 st_1
st_8 st_8
dw_detalle dw_detalle
em_cantidad_en_pzs em_cantidad_en_pzs
em_precio_pzs em_precio_pzs
end type
global w_int_venlifac w_int_venlifac

type variables
string filtro,bloqueado
Integer bien,ante_pallets,ante_cajas
decimal{2} ante_valor
str_almmovhis mov
String  tipo // I-> inserción , M -> Modificación
Dec{0}  linea_factura
String  cod_tipo_unidad,cod_formato,cod_familia,var_control_alm,var_sector,var_clase,control_incremento
String articulo_ant,idioma_ant,calidad_ant,tipolinea_ant,referencia_ant,tipopallet_ant
Dec{2} precio_ant,ante_existencias
str_venfac venfac
String campo_actual,var_situacion,var_actualizada
Integer tipo_precio
boolean ib_gestionar_en_piezas = false
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

public subroutine f_grabar_linea ();str_venlifac linfac

SetNull(linfac.anyo_ent)
SetNull(linfac.nummov_ent)
SetNull(linfac.anyo_sal)
SetNull(linfac.nummov_sal)
SetNull(linfac.fila_ent)
SetNull(linfac.altura_ent)
SetNull(linfac.operario_prepa)
  
Dec{0}  ultima,factura,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas

periodo    =  Integer(em_anyo.text)
factura    =  Dec(em_factura.text)

linfac.empresa   = codigo_empresa
linfac.anyo      = Dec(em_anyo.text)
linfac.factura   = Dec(em_factura.text)
 
linfac.ffactura  = venfac.ffactura
linfac.cliente   = venfac.cliente
linfac.tipoiva   = venfac.tipoiva
linfac.iva       = venfac.iva
linfac.divisa    = venfac.divisa
linfac.serie     = venfac.serie
linfac.zona      = venfac.zona
linfac.agente1   = venfac.agente1
linfac.agente2   = venfac.agente2
linfac.agente3   = venfac.agente3
linfac.comision11= venfac.comision11
linfac.comision12= venfac.comision12
linfac.comision21= venfac.comision21
linfac.comision22= venfac.comision22
linfac.comision31= venfac.comision31
linfac.comision32= venfac.comision32
linfac.articulo  = uo_articulo.em_codigo.text
linfac.clase     = var_clase
linfac.calidad   = uo_calidad.em_codigo.text
linfac.observ_lin= em_observ_lin.text
linfac.numpalet  = dec(em_npal.text)
linfac.idioma    = uo_idioma.em_codigo.text
linfac.tonochar = em_tono_imprimir.text
linfac.calibre  = integer(em_calibre_imprimir.text)
linfac.tono_imprimir = em_tono_imprimir.text
linfac.calibre_imprimir = em_calibre_imprimir.text

if isnull(linfac.numpalet) then linfac.numpalet = 0

// lee los datos si es modificacion

if tipo = "M" then
	SELECT venlifac.precio_aduana,venlifac.precio,venlifac.cantidad_original,venlifac.linea_desdoblada_de,venlifac.tonochar,venlifac.calibre
	INTO :linfac.precio_aduana,   
			:linfac.precio,:linfac.cantidad_original,:linfac.linea_desdoblada_de,:linfac.tonochar,:linfac.calibre
	FROM venlifac  
	WHERE 	( venlifac.empresa = :linfac.empresa ) AND  
				( venlifac.anyo    = :linfac.anyo ) AND  
				( venlifac.factura = :linfac.factura ) AND  
				( venlifac.linea_factura   = :linea_factura )   ;
End if

IF Isnull(linfac.tono_imprimir)    Then linfac.tono_imprimir = ""
IF Isnull(linfac.calibre_imprimir) Then linfac.calibre_imprimir = ""
IF Isnull(linfac.tonochar)    Then linfac.tonochar = ""
IF Isnull(linfac.calibre) Then linfac.calibre = 0

SELECT articulos.familia,
       articulos.formato,articulos.modelo,articulos.unidad
INTO   :linfac.familia,:linfac.formato,
       :linfac.modelo,:linfac.tipo_unidad
FROM  articulos  
WHERE articulos.empresa = :codigo_empresa 
AND   articulos.codigo  = :linfac.articulo ;

//IF tipo_precio = 1 Then
//	linfac.precio           = Dec(em_precio.text)
//	IF tipo <> "M" Then 
//		linfac.precio_aduana = Dec(em_precio.text)
//	End if
//ELSE
//	linfac.precio_aduana = Dec(em_precio.text)
//END IF

linfac.precio        = Dec(em_precio.text)
linfac.precio_aduana = Dec(em_precio.text)
linfac.precio_pzs    = Dec(em_precio_pzs.text)

linfac.precio_estand   = linfac.precio
linfac.cantidad        = Dec(em_cantidad.text)
linfac.cantidad_pzs    = Dec(em_cantidad_en_pzs.text)
linfac.pallets         = Dec(em_t_pallets.text)
linfac.total_cajas     = Dec(em_t_cajas.text)
linfac.cajas           = Dec(em_cajas.text)
linfac.tipo_pallet     = uo_tipo_pallet.em_codigo.text
linfac.caja            = uo_caja.em_codigo.text
linfac.dtocomer        = 0

IF Trim(linfac.articulo) = "" Then
	linfac.peso      = 0
	linfac.peso_neto = 0
ELSE
	if ib_gestionar_en_piezas then
		linfac.peso                = f_calculo_peso_pzs(linfac.empresa,linfac.articulo,linfac.tipo_pallet,linfac.cajas,linfac.total_cajas,linfac.pallets,linfac.cantidad,linfac.caja)
		linfac.peso_neto           = f_calculo_peso_neto_pzs(linfac.empresa,linfac.articulo,linfac.cajas,linfac.total_cajas,linfac.cantidad,linfac.caja)		
	else
		linfac.peso                = f_calculo_peso(linfac.empresa,linfac.articulo,linfac.tipo_pallet,linfac.cajas,linfac.total_cajas,linfac.pallets,linfac.cantidad,linfac.caja)
		linfac.peso_neto           = f_calculo_peso_neto(linfac.empresa,linfac.articulo,linfac.cajas,linfac.total_cajas,linfac.cantidad,linfac.caja)
	end if
END IF
IF IsNull(linfac.peso)      Then linfac.peso = 0
IF IsNull(linfac.peso_neto) Then linfac.peso_neto = 0

If IsNull(em_descuento.text) or Trim(em_descuento.text) ="" THEN
  em_descuento.text ="0"
END IF
If IsNull(em_descuento2.text) or Trim(em_descuento2.text) ="" THEN
  em_descuento2.text ="0"
END IF

linfac.dtoesp          = Dec(em_descuento.text)
linfac.dtoesp2			  = Dec(em_descuento2.text)
linfac.descripcion     = em_descripcion.text

SELECT familias.linea INTO :linfac.linfab FROM familias  
WHERE familias.empresa = :codigo_empresa
AND   familias.codigo = :linfac.familia    ;

String   var_tipoter
linfac.tipolinea       = uo_tipolinea.em_codigo.text
linfac.texto1          = ""
linfac.texto2          = ""
linfac.texto3          = ""

IF isnull(linfac.articulo) then linfac.articulo = ""

if Trim(linfac.articulo)<>"" Then
	linfac.referencia      = f_componer_ref(linfac.articulo,linfac.calidad,linfac.tonochar,linfac.calibre)
	linfac.montajeartcal   = f_componer_artcal(linfac.articulo,linfac.calidad)
Else
	linfac.referencia    = ""
	linfac.montajeartcal = ""
End if

linfac.situacion       = em_situacion.text
linfac.metros_lineales = 0
linfac.falta           = Datetime(today())
linfac.usuario         = nombre_usuario
linfac.deposito        = "N"
linfac.sector          = f_sector_articulo(codigo_empresa,linfac.articulo)
linfac.control_comisiones  =  f_comision_ventipolin(codigo_empresa,linfac.tipolinea)
linfac.control_descuentos  =  f_descuento_ventipolin(codigo_empresa,linfac.tipolinea)

// 15-11-02 david 
//SetNull(linfac.calidad)
//SetNull(linfac.tonochar)
//SetNull(linfac.calibre)
//SetNull(linfac.pallets)
//SetNull(linfac.total_cajas)
//SetNull(linfac.cajas)
//SetNull(linfac.linfab)
//SetNull(linfac.referencia)
//SetNull(linfac.montajeartcal)
//SetNull(linfac.tipo_pallet)
//SetNull(linfac.caja)
//SetNull(linfac.orden_preparacion)
//linfac.cantidad_prepa = 0

IF tipo ="I" THEN
	 ultima =  0
	 Select max(venlifac.linea_factura) Into :ultima From venlifac
	 Where  venlifac.empresa    =   :linfac.empresa
	 And    venlifac.anyo       =   :linfac.anyo
	 And    venlifac.factura    =   :linfac.factura;
	 IF ISNull(ultima) Then ultima=0
	 ultima = ultima +1	 
	 linfac.linea_factura = ultima
	 linfac.anyo_proddiaria = 0
	 linfac.contador_proddiaria = 0
	 linfac.cantidad_original = Dec(em_cantidad.text)
	 SetNull(linfac.linea_desdoblada_de)
	 f_insertar_venlifac(linfac)
END IF

IF tipo="M" THEN	
	  UPDATE venlifac  
	  SET precio        = :linfac.precio,   
			precio_aduana = :linfac.precio_aduana,
			dtoesp        = :linfac.dtoesp,   
			descripcion   = :linfac.descripcion,   
			tipolinea = :linfac.tipolinea,   
			formato   = :linfac.formato,   
			familia   = :linfac.familia,   
			articulo  = :linfac.articulo,  
			calidad   = :linfac.calidad,  
			caja      = :linfac.caja,  
			tipo_pallet = :linfac.tipo_pallet,  
			modelo    = :linfac.modelo,   
			cantidad  = :linfac.cantidad, 
			pallets = :linfac.pallets,
			cajas = :linfac.cajas,
			total_cajas = :linfac.total_cajas,
			clase     = :linfac.clase,   
			sector    = :linfac.sector,
			peso      = :linfac.peso,
			peso_neto = :linfac.peso_neto,
			control_descuentos = :linfac.control_descuentos,
			control_comisiones = :linfac.control_comisiones,
			dtoesp2			= :linfac.dtoesp2,
			observ_lin     = :linfac.observ_lin,
			numpalet       = :linfac.numpalet,
			idioma         = :linfac.idioma,
			tonochar 	= :linfac.tonochar,
			calibre 	= :linfac.calibre,
			tono_imprimir = :linfac.tono_imprimir,
			calibre_imprimir = :linfac.calibre_imprimir,			
			cantidad_original = :linfac.cantidad_original,
			linea_desdoblada_de = :linfac.linea_desdoblada_de,
			venlifac.cantidad_pzs = :linfac.cantidad_pzs,
			venlifac.precio_pzs = :linfac.precio_pzs 	
	WHERE  venlifac.empresa   = :linfac.empresa 
	AND    venlifac.anyo      = :linfac.anyo 
	AND    venlifac.factura   = :linfac.factura 
	AND    venlifac.linea_factura     = :linea_factura;
	linfac.linea_factura   = linea_factura
END IF

f_actualizar_linea_venfac(linfac.empresa,linfac.anyo,linfac.factura,linfac.linea_factura)
f_actualizar_venfactura(codigo_empresa,linfac.anyo,linfac.factura)
COMMIT;

end subroutine

public subroutine f_borrar_linea ();Dec{0}periodo,factura

periodo = Dec(em_anyo.text)
factura  = Dec(em_factura.text)

   DELETE FROM venlifac 
   WHERE ( venlifac.empresa = :codigo_empresa ) AND  
         ( venlifac.anyo    = :periodo ) AND  
         ( venlifac.factura  = :factura ) AND  
         ( venlifac.linea_factura   = :linea_factura )   ;

COMMIT;

f_actualizar_venfactura(codigo_empresa,periodo,factura)
end subroutine

public subroutine f_botones ();if var_actualizada="S" and tipo_precio = 1 then
	cb_borrar.enabled   = False
	cb_insertar.enabled = False
   cb_reservas.enabled = False
	cb_stock.enabled = False
//	cb_grabar.enabled = False
	Return
End if
IF tipo_precio = 2 Then
	IF tipo = "I" Then
		cb_grabar.enabled   = FALSE		
	ELSE
		cb_grabar.enabled   = TRUE
	END IF
  	cb_borrar.enabled   = FALSE
	cb_insertar.enabled = FALSE
	cb_valorar.enabled  = FALSE
	Return
END IF
If tipo = "I" Then 
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
	cb_valorar.enabled  = FALSE
END IF
end subroutine

public subroutine f_calculo_precio ();string codpais,articulo,coleccion,tarifa,divisa
Dec incre,incre2,min_canti, cantidad
Integer t_pallets, i, contador
Dec{4}  t_cantidad,dto,v_precio_esp,v_precio_tarifa,v_pre,v_precio_esp_tar, dto2

IF IsNull(uo_articulo.em_codigo.text) or Trim(uo_articulo.em_codigo.text)= "" Then Return 
IF IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text)= "" Then Return 
  
//Obtención de la cantidad... para calculo de descuento
cantidad = Dec(em_cantidad.text)
contador = 0
For i=1 To dw_detalle.rowcount()
	/*
	if uo_articulo.em_codigo.text = String(dw_detalle.object.articulo[i]) then
		if  dw_detalle.getrow() = i and tipo = 'M' then
		else
			cantidad = cantidad + Dec(dw_detalle.object.venliped_cantidad_facturar[i])
		end if
	end if
	*/
	if uo_articulo.em_codigo.text = String(dw_detalle.object.articulo[i]) then
		if  dw_detalle.getrow() <> i then
			contador ++	
		end if
		if  dw_detalle.getrow() = i and tipo = 'M' then
		else
			cantidad = cantidad// + Dec(dw_detalle.object.venliped_cantidad_facturar[i])
		end if
	end if
Next

//11012017 COMENTAMOS ESTE TROZO DE SCRIPT (PMARIN)
//if contador > 1 then
//	MessageBox("Atención", "Hay más líneas de pedido de este artículo, revise los decuentos.")
//end if
//  
//dto   = f_dto_cliente_articulo(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,cantidad)
//if dto = 0 then
//	dto   = f_dto_tarifa_articulo(codigo_empresa, venfac.tarifa, uo_articulo.em_codigo.text, uo_calidad.em_codigo.text, cantidad)
//end if
//
//dto2  = f_dto_cliente_articulo_fecha(codigo_empresa, em_cliente.text, uo_articulo.em_codigo.text, datetime(today()))
//
//if dto2 <> 0 then
//	em_descuento2.visible = true
//	st_dto2.visible = true
//else	
//	em_descuento2.visible = false
//	st_dto2.visible = false
//end if
//
//em_descuento.text  = "0"
//em_descuento2.text = "0"
//v_pre              = 0
//
//articulo = uo_articulo.em_codigo.text
//
//v_pre = f_precio_articulo_esp_tar(codigo_empresa,venfac.tarifa,venfac.cliente,articulo,uo_calidad.em_codigo.text)
//if v_pre = 0 then
//	v_pre = f_precio_articulo_venlintarifas_activa(codigo_empresa,venfac.tarifa,articulo,uo_calidad.em_codigo.text)
//end if
//
//em_descuento.text = string(dto)
//em_descuento2.text = string(dto2)
//em_precio.text    = string(v_pre)
//precio_ant        = Dec(em_precio.text)
//
//Nuevo
string ls_articulo,ls_calidad,ls_caja,ls_pallet,ls_tipo_linea
dec    ld_cantidad

str_precio_y_dtos_articulo_cliente lstr_precio_y_dtos_articulo_cliente

ls_articulo   = uo_articulo.em_codigo.text
ls_calidad    = uo_calidad.em_codigo.text
ls_caja       = uo_caja.em_codigo.text
ls_pallet     = uo_tipo_pallet.em_codigo.text
ls_tipo_linea = uo_tipolinea.em_codigo.text
ld_cantidad   = Dec(em_cantidad.text)

f_precio_y_dtos_articulo_cliente(codigo_empresa,venfac.cliente,venfac.ffactura,venfac.tarifa,ls_articulo,ls_calidad,ls_caja,ls_pallet,ld_cantidad,ls_tipo_linea,lstr_precio_y_dtos_articulo_cliente)

em_descuento.text = string(lstr_precio_y_dtos_articulo_cliente.descuento1)
em_descuento2.text = string(lstr_precio_y_dtos_articulo_cliente.descuento2)
em_precio.text    = string(lstr_precio_y_dtos_articulo_cliente.precio)

dec  ld_m2_caja
long ll_piezas_caja

if f_unidad_articulo(codigo_empresa,ls_articulo) = "1" then
		
	ld_m2_caja     = f_metroscaja_articulo(codigo_empresa,ls_articulo,ls_caja)
	ll_piezas_caja = f_piezascaja_articulo(codigo_empresa,ls_articulo,ls_caja)
		
	if ll_piezas_caja <> 0 and ld_m2_caja <> 0 then	
		em_precio_pzs.text = string((lstr_precio_y_dtos_articulo_cliente.precio * ld_m2_caja) / ll_piezas_caja,em_precio_pzs.mask)
	else
		em_precio_pzs.text = string(0,em_precio_pzs.mask)
	end if
else
	em_precio_pzs.text = string(lstr_precio_y_dtos_articulo_cliente.precio,em_precio_pzs.mask)
end if

if dec(em_descuento2.text) <> 0 then
	em_descuento2.visible = true
	st_dto2.visible = true
else
	/* MARCOS 09/02/2021 */
	//em_descuento2.visible = false
	//st_dto2.visible = false
end if
//Fin de Nuevo
precio_ant        = Dec(em_precio.text)


////  string codpais
////  Integer t_pallets
////  Dec{4}  t_cantidad
////  em_precio.text = String(f_precio_articulo(codigo_empresa,em_cliente.text,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,venfac.tarifa))
////  t_pallets   = Integer(em_t_pallets.text)
////  t_cantidad  = Dec(em_cantidad.text)
////  IF IsNull(t_pallets) Then t_pallets=0
////  IF t_pallets <1 and t_cantidad <>0 Then 
////     codpais = f_pais_genter(codigo_empresa,"C",em_cliente.text)  
////     em_precio.text= String(f_incremento_precio(codigo_empresa,cod_familia,uo_calidad.em_codigo.text,Dec(em_precio.text),codpais))
////  End IF  
////  precio_ant = Dec(em_precio.text)
//
//string codpais,articulo,coleccion,tarifa,divisa
//Dec incre,incre2,min_canti
//Integer t_pallets
//Dec{4}  t_cantidad,dto,v_precio_esp,v_precio_tarifa,v_pre,v_precio_esp_tar
//IF IsNull(uo_articulo.em_codigo.text) or Trim(uo_articulo.em_codigo.text)= "" Then Return 
//IF IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text)= "" Then Return 
//  
//dto = 0
//em_descuento.text = "0"
//em_descuento2.text= '0'
//
//articulo=uo_articulo.em_codigo.text
//coleccion=f_coleccion_articulo(codigo_empresa,articulo)
//divisa = f_moneda_cliente(codigo_empresa,venfac.cliente)
//if uo_tipolinea.em_codigo.text<>'5' then
//	// santiago. 05/12/00 . Primero miramos si hay precio especial
//	v_pre = f_precio_articulo_esp_tar(codigo_empresa,venfac.tarifa,venfac.cliente,articulo,uo_calidad.em_codigo.text)
//	em_descuento.text =string(f_dto1_venclientes(codigo_empresa,em_cliente.text))
//	em_descuento2.text=string(f_dto2_venclientes(codigo_empresa,em_cliente.text))
//	if v_pre = 0 then
//		if f_precio_neto_almcolecciones(codigo_empresa,coleccion)='S' then
//			t_cantidad=dec(em_cantidad.text)
//			min_canti=f_minimo_almcolecciones(codigo_empresa,coleccion)
//			if t_cantidad>min_canti then
//				tarifa=f_tarifa_almcolecciones(codigo_empresa,coleccion)
//				v_pre=f_precio_articulo_venlintarifas_activa_m(codigo_empresa,tarifa,articulo,uo_calidad.em_codigo.text,divisa)
//			else
//				v_pre=f_precio_articulo_venlintarifas_activa_m(codigo_empresa,venfac.tarifa,articulo,uo_calidad.em_codigo.text,divisa)
//				em_descuento.text=string(f_dto1_venclientes(codigo_empresa,em_cliente.text))
//				em_descuento2.text=string(f_dto2_venclientes(codigo_empresa,em_cliente.text))			
//			end if
//		else
//			v_pre=f_precio_articulo_venlintarifas_activa_m(codigo_empresa,venfac.tarifa,articulo,uo_calidad.em_codigo.text,divisa)
//			em_descuento.text=string(f_dto1_venclientes(codigo_empresa,em_cliente.text))
//			em_descuento2.text=string(f_dto2_venclientes(codigo_empresa,em_cliente.text))	
//		end if
//	end if
//end if
//
//em_precio.text=string(v_pre)
//precio_ant = Dec(em_precio.text)  
end subroutine

public subroutine f_consulta_disponible ();str_parametros str
str.s_argumentos[1]= "w_int_venlifac"
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
OpenWithParm(w_con_stock_conjunto_articulos,str)

end subroutine

public subroutine f_activar_primer_campo ();//em_precio.enabled = TRUE
//uo_tipolinea.enabled = TRUE
//uo_articulo.enabled = TRUE
var_control_alm ="N"
var_control_alm = f_control_almacen_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)

if var_actualizada = "S" then
	f_activar_campo(em_descripcion)
else
	IF var_control_alm  = "S" Then
			f_activar_campo(em_precio)
			Return
	END IF
	IF tipo_precio = 2 Then
		f_activar_campo(em_precio)
		Return
	END IF
	
	f_activar_campo(uo_tipolinea.em_campo)
end if	

end subroutine

public subroutine f_consulta_reservas ();str_parametros str
str.s_argumentos[1]= "w_int_venlifac"
str.s_argumentos[2]= uo_articulo.em_codigo.text
str.s_argumentos[3]= uo_calidad.em_codigo.text
str.s_argumentos[6]= uo_tipo_pallet.em_codigo.text
str.s_argumentos[7]= uo_caja.em_codigo.text
str.i_nargumentos = 7
OpenWithParm(w_con_reservas_articulos,str)

end subroutine

public subroutine f_campos_segun_tiplin ();Boolean  sino,sino_articulo
String   var_empresa,var_codigo
String cod_tiplin, v_mostrar_Campos,ls_gestionar_en_piezas

cod_tiplin  = uo_tipolinea.em_codigo.text 

var_control_alm ="N"

SELECT  ventipolin.control_almacen ,
		  ventipolin.gestionar_en_piezas  
INTO   :var_control_alm,
		 :ls_gestionar_en_piezas
FROM   ventipolin  
WHERE (ventipolin.empresa = :codigo_empresa)
AND   (ventipolin.codigo  = :cod_tiplin);

if ls_gestionar_en_piezas = 'S' then
	ib_gestionar_en_piezas = true
else	
	ib_gestionar_en_piezas = false
end if

if ib_gestionar_en_piezas then
	em_cantidad.enabled         = false
	em_cantidad_en_pzs.enabled  = true
	em_precio.enabled           = false
	em_precio_pzs.enabled       = true
	
	em_cantidad.visible         = false
	em_cantidad_en_pzs.visible  = true
	em_precio.visible           = false
	em_precio_pzs.visible       = true	
	
	em_cantidad.TabOrder        = 0
	em_precio.TabOrder          = 0
	em_cantidad_en_pzs.TabOrder = 160
	em_precio_pzs.TabOrder      = 170
else
	em_cantidad.enabled         = true
	em_cantidad_en_pzs.enabled  = false
	em_precio.enabled           = true
	em_precio_pzs.enabled       = false	
	
	em_cantidad.visible         = true
	em_cantidad_en_pzs.visible  = false
	em_precio.visible           = true
	em_precio_pzs.visible       = false		
	
	em_cantidad.TabOrder        = 160
	em_precio.TabOrder          = 170
	em_cantidad_en_pzs.TabOrder = 0
	em_precio_pzs.TabOrder      = 0	
end if

IF var_actualizada     = "S"  then
	sino = False
	uo_tipolinea.enabled			= sino
	em_cajas.enabled				= sino
	em_calibre.enabled			= sino//true
	em_mtrs_lineales.enabled	= sino
	em_t_cajas.enabled			= sino
	em_t_pallets.enabled			= sino
	em_tono.enabled				= sino//true
	uo_calidad.enabled			= sino
	uo_tipo_pallet.enabled		= sino
	uo_articulo.enabled			= sino
	uo_tipolinea.enabled			= sino
	em_cantidad.enabled			= sino
	em_cantidad_en_pzs.enabled = sino
	em_npal.enabled				= sino
	em_precio.enabled				= sino
	em_precio_pzs.enabled		= sino
	em_descuento.enabled			= sino
	em_descuento2.enabled		= sino
	
	if tipo = "I" then
		uo_articulo.em_codigo.text = ""
		uo_articulo.em_campo.text  = ""
		uo_calidad.em_codigo.text = ""  
		uo_calidad.em_campo.text = ""
		em_tono.text = ""
		em_calibre.text = ""		
		em_tono_imprimir.text = ""
		em_calibre_imprimir.text = ""
		uo_tipo_pallet.em_codigo.text = ""
		uo_tipo_pallet.em_campo.text = ""
		uo_caja.em_codigo.text = ""
		uo_caja.em_campo.text = ""
		em_mtrs_lineales.text = ""
		em_t_cajas.text = ""
		em_t_pallets.text = ""
		em_cajas.text = ""					
		em_npal.text = ""					
	end if
else
	var_sector  = f_sector_familia(codigo_empresa,cod_familia)
	
	var_control_alm ="N"	
	var_control_alm = f_control_almacen_ventipolin(codigo_empresa,cod_tiplin)
	
	select mostrar_campos
	into :v_mostrar_Campos
	from ventipolin 
	where empresa = :codigo_empresa
	and codigo = :cod_tiplin;
	
	if v_mostrar_Campos = "S" then
		sino = true
		uo_tipolinea.enabled			= sino
		em_cantidad.enabled			= sino
		em_cantidad_en_pzs.enabled = sino
		em_cajas.enabled				= sino
		em_calibre.enabled			= true//sino
		em_mtrs_lineales.enabled	= sino
		em_t_cajas.enabled			= sino
		em_t_pallets.enabled			= sino
		em_tono.enabled				= true//sino
		uo_calidad.enabled			= sino
		uo_tipo_pallet.enabled		= sino
		uo_caja.enabled				= sino	 
		uo_articulo.enabled			= sino
		em_npal.enabled				= sino
	else
		sino = false
		uo_tipolinea.enabled			= true
		em_cantidad.enabled			= true
		em_cantidad_en_pzs.enabled = true
		em_cajas.enabled				= sino
		em_calibre.enabled			= true//sino
		em_mtrs_lineales.enabled	= sino
		em_t_cajas.enabled			= sino
		em_t_pallets.enabled			= sino
		em_tono.enabled				= true//sino
		uo_calidad.enabled			= sino
		uo_tipo_pallet.enabled		= sino
		uo_caja.enabled				= sino	 
		uo_articulo.enabled			= sino
		em_npal.enabled				= sino

		if tipo = "I" then
			uo_articulo.em_codigo.text = ""
			uo_articulo.em_campo.text  = ""
			uo_calidad.em_codigo.text = ""  
			uo_calidad.em_campo.text = ""
			em_tono.text = ""
			em_calibre.text = ""
			em_tono_imprimir.text = ""
			em_calibre_imprimir.text = ""		
			uo_tipo_pallet.em_codigo.text = ""
			uo_tipo_pallet.em_campo.text = ""
			uo_caja.em_codigo.text = ""
			uo_caja.em_campo.text = ""
			em_mtrs_lineales.text = ""
			em_t_cajas.text = ""
			em_t_pallets.text = ""
			em_cajas.text = ""					
			em_npal.text = ""
		end if		
	end if
	
	 if var_control_alm = "S" then
		em_cantidad.enabled			= false
		em_cantidad_en_pzs.enabled = false
		em_cajas.enabled				= false
		em_calibre.enabled			= false
		em_mtrs_lineales.enabled	= false
		em_t_cajas.enabled			= false
		em_t_pallets.enabled			= false
		em_tono.enabled				= false
		uo_calidad.enabled			= false
		uo_tipo_pallet.enabled		= false
		uo_caja.enabled				= false 
		uo_articulo.enabled			= false
		
		if trim(uo_articulo.em_codigo.text) <> "" then
			cb_reservas.enabled     = true
			cb_stock.enabled		= true
		else
			cb_reservas.enabled     = false
			cb_stock.enabled        = false
		end if
	else
		cb_reservas.enabled     = false
		cb_stock.enabled        = false
	end if
END IF
	

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Boolean  sino,sino_articulo
String   var_empresa,var_codigo
String cod_tiplin, v_mostrar_Campos

IF var_actualizada     = "S"  and tipo_precio = 1 Then  em_precio.enabled  = FALSE

uo_tipolinea.enabled            = TRUE
em_cantidad.enabled            = TRUE

IF tipo= "M"   or tipo_precio = 2 Then
	em_cajas.enabled               = FALSE
	em_calibre.enabled             = FALSE
	em_mtrs_lineales.enabled       = FALSE
	em_t_cajas.enabled             = FALSE
	em_t_pallets.enabled           = FALSE
	em_tono.enabled                = FALSE
	uo_calidad.enabled             = FALSE
	uo_tipo_pallet.enabled         = FALSE
	uo_articulo.enabled            = FALSE
	uo_tipolinea.enabled           = FALSE
	em_cantidad.enabled            = FALSE
	Return
END IF

var_sector  = f_sector_familia(codigo_empresa,cod_familia)
cod_tiplin  = uo_tipolinea.em_codigo.text 
var_control_alm ="N"
var_control_alm = f_control_almacen_ventipolin(codigo_empresa,cod_tiplin)

select mostrar_campos
into :v_mostrar_Campos
from ventipolin 
where empresa = :codigo_empresa
and codigo = :cod_tiplin;

//messagebox ("H","Y")
//messagebox("", cod_tiplin)

//if v_mostrar_campos = "S" then
//	 em_cajas.enabled         		= true
//	 em_calibre.enabled             	= true
//	 em_mtrs_lineales.enabled  	= true
//	 em_t_cajas.enabled 			= true
//	 em_t_pallets.enabled			= true
//	 em_tono.enabled                = true
//	 uo_calidad.enabled             = true
//	 uo_tipo_pallet.enabled		= true
//	 uo_caja.enabled				= true	 
//	 uo_articulo.enabled			= true
//else
	CHOOSE CASE var_control_alm
		CASE "S"
				 sino = TRUE
				 sino_articulo= TRUE
		 CASE "N"
			  IF Trim(em_descripcion.text) = "" Then
				  em_descripcion.text     = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
			  END IF
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
	 uo_caja.enabled         		  = sino	 
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
		uo_caja.em_codigo.text = ""
		uo_caja.em_campo.text = ""
		em_mtrs_lineales.text = ""
		em_t_cajas.text = ""
		em_t_pallets.text = ""
		em_cajas.text = ""
	END IF
//end if	


*/
end subroutine

public subroutine f_control ();dw_detalle.setredraw(false)
string donde,cuanto
donde=dw_detalle.Object.DataWindow.VerticalScrollPosition
dw_detalle.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(em_factura.text),tipo_precio)
dw_detalle.Object.DataWindow.VerticalScrollPosition=donde
dw_detalle.setredraw(true)


end subroutine

public subroutine f_peso_linea ();Dec{4} var_total,var_anyo,var_factura,var_peso_linea
string ls_gestionar_en_piezas_ventipolin

var_anyo     = Dec(em_anyo.text)
var_factura = Dec(em_factura.text)

//IF len(uo_articulo.em_codigo.text) <> 0  and len(uo_tipo_pallet.em_codigo.text) <> 0 Then
//	var_peso_linea= f_calculo_peso(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_t_pallets.text),Dec(em_cantidad.text),uo_caja.em_codigo.text)
//Else	
//	var_peso_linea=0
//END IF

IF len(uo_articulo.em_codigo.text) <> 0  and len(uo_tipo_pallet.em_codigo.text) <> 0 Then
	IF Dec(em_cantidad.text) = 0 Then
		var_peso_linea = 0
	ELSE
		ls_gestionar_en_piezas_ventipolin = f_gestionar_en_piezas_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
		
		if ls_gestionar_en_piezas_ventipolin = 'S' then
			var_peso_linea= f_calculo_peso_pzs(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text, +&
									Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_npal.text),Dec(em_cantidad_en_pzs.text),Trim(uo_caja.em_codigo.text))			
		else
			var_peso_linea= f_calculo_peso(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text, +&
									Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_npal.text),Dec(em_cantidad.text),Trim(uo_caja.em_codigo.text))
		end if
// David 21/05/2003	En lugar de pllets completos, utilizaremos el número de pallets reales
//								Dec(em_cajas.text),Dec(em_t_cajas.text),dec(em_t_pallets.text),Dec(em_cantidad.text),Trim(uo_caja.em_codigo.text))
	END IF
Else	
	var_peso_linea=0
END IF

st_peso_linea.text   = String(var_peso_linea,"###,###,###")

Select sum(peso) Into :var_total From venlifac
Where  empresa  = :codigo_empresa
And    anyo     = :var_anyo
And    factura = :var_factura
And    linea_factura    <>:linea_factura;
IF IsNull(var_total)      Then var_total       =  0
IF IsNull(var_peso_linea) Then var_peso_linea  =  0

st_peso_total.text = String(var_total + var_peso_linea,"###,###,###")
end subroutine

public subroutine f_recalcular_lineas ();str_venlifac  linfac
str_venfac   ped 
Integer  reg,reg1 
Dec{0}  ultima,factura,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
Dec{4}  impdto,importe,acumulado,importedto1,importedto2,importedto3,importedto4,importedtopp,importedtoesp,control_precio,control_bruto,control_importedto,control_importe
Dec{2}  var_dto1,var_dto2,var_dto3,var_dto4,var_dtopp,control_descuento
String  var_tipodto1,var_tipodto2,var_tipodto3,var_tipodto4,var_calculo_dto
Dec{4}  var_impdto1,var_impdto2,var_impdto3,var_impdto4
Integer procesos

periodo   =  Integer(em_anyo.text)
factura    =  Dec(em_factura.text)
reg1 = dw_detalle.RowCount()
linfac.empresa   = codigo_empresa
linfac.anyo      = periodo
linfac.factura  = factura
  SELECT venfac.dtoesp1,     venfac.dtoesp2,   
         venfac.dtoesp3,     venfac.dtoesp4,   
         venfac.dtopp,       venfac.tipodto1,   
         venfac.tipodto2,    venfac.tipodto3,   
         venfac.tipodto4,    venfac.divisa,
			venfac.calculo_dto
    INTO :var_dto1,    :var_dto2,    :var_dto3,  :var_dto4,   
         :var_dtopp,   :var_tipodto1,:var_tipodto2,   
         :var_tipodto3,:var_tipodto4,:linfac.divisa,
			:var_calculo_dto
    FROM venfac  
   WHERE (venfac.empresa  = :linfac.empresa ) AND  
         (venfac.anyo     = :linfac.anyo ) AND  
         (venfac.factura = :linfac.factura );


For reg = 1 To reg1 
 linfac.linea              = Dec(f_valor_columna(dw_detalle,reg,"linea"))
 linfac.cantidad           = Dec(f_valor_columna(dw_detalle,reg,"cantidad"))
 linfac.dtoesp             = Dec(f_valor_columna(dw_detalle,reg,"dtoesp"))
 linfac.tipolinea         = f_valor_columna(dw_detalle,reg,"tipolinea")
 linfac.control_comisiones = f_comision_ventipolin(linfac.empresa,linfac.tipolinea)
 linfac.control_descuentos = f_descuento_ventipolin(linfac.empresa,linfac.tipolinea)

 IF  IsNull(linfac.dtoesp) Then linfac.dtoesp= 0
 IF IsNull(var_dto1)  Then var_dto1  = 0
 IF IsNull(var_dto2)  Then var_dto2  = 0
 IF IsNull(var_dto3)  Then var_dto3  = 0
 IF IsNull(var_dto4)  Then var_dto4  = 0
 IF IsNull(var_dtopp) Then var_dtopp = 0

For procesos = 1 To 2
 linfac.precio_aduana      = Dec(f_valor_columna(dw_detalle,reg,"precio_aduana"))
 linfac.precio             = Dec(f_valor_columna(dw_detalle,reg,"precio"))
 IF procesos = 1 then control_precio = linfac.precio
 IF procesos = 2 then control_precio = linfac.precio_aduana
	
	control_bruto = Dec(String(linfac.cantidad * control_precio,f_mascara_moneda(linfac.divisa)))
	IF var_calculo_dto = "N" Then
		importedtoesp = Dec(String((control_bruto * linfac.dtoesp /100),f_mascara_moneda(linfac.divisa)))
		acumulado = control_bruto - importedtoesp
	ELSE
		acumulado = control_bruto
	END IF
	
	IF linfac.control_descuentos = "N" Then
		linfac.descuento = 0
	ELSE
	 IF var_tipodto1  = "L" Then 
			importedto1 = Dec(String((acumulado * var_dto1 /100),f_mascara_moneda(linfac.divisa)))
			acumulado = acumulado - importedto1
	 END IF
	 IF var_tipodto2  = "L" Then 
			importedto2 = Dec(String((acumulado * var_dto2 /100),f_mascara_moneda(linfac.divisa)))
			acumulado = acumulado - importedto2
	 END IF
	 IF var_tipodto3  = "L" Then 	
		   importedto3 = Dec(String((acumulado * var_dto3 /100),f_mascara_moneda(linfac.divisa)))
			acumulado = acumulado - importedto3
	 END IF
	 IF var_tipodto4  = "L" Then 	
			importedto4  = Dec(String((acumulado * var_dto4 /100),f_mascara_moneda(linfac.divisa)))
			acumulado = acumulado - importedto4
	 END IF
	 importedtopp  = Dec(String((acumulado * var_dtopp /100),f_mascara_moneda(linfac.divisa))) 
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
		Dec(String((control_precio * control_descuento)/100,f_mascara_moneda(linfac.divisa)))
		control_descuento = linfac.dtoesp
		control_bruto = Dec(String(linfac.cantidad * control_precio,f_mascara_moneda(linfac.divisa)))
	   importedtoesp = Dec(String((control_bruto * linfac.dtoesp /100),f_mascara_moneda(linfac.divisa)))
		control_importedto    = importedtoesp
	   control_importe       = control_bruto - importedtoesp
	END IF
	
	IF procesos = 1 Then
		linfac.descuento       = control_descuento
		linfac.bruto           = control_bruto
	   linfac.importedto      = control_importedto
	   linfac.importe         = control_importe
		linfac.precio_neto     = control_precio
		
	END IF
	IF procesos = 2 Then
		linfac.descuento_aduana       = control_descuento
	   linfac.importe_aduana         = control_importe
		linfac.precio_aduana_neto     = control_precio
	END IF
Next
  UPDATE venlifac  
     SET importe            = :linfac.importe,   
         descuento          = :linfac.descuento,   
         importedto         = :linfac.importedto,   
         precio_neto        = :linfac.precio_neto,   
         precio_aduana_neto = :linfac.precio_aduana_neto,   
         descuento_aduana   = :linfac.descuento_aduana,   
         importe_aduana     = :linfac.importe_aduana,   
         bruto = :linfac.bruto  
   WHERE ( venlifac.empresa = :linfac.empresa ) AND  
         ( venlifac.anyo = :linfac.anyo ) AND  
         ( venlifac.factura = :linfac.factura )  AND 
        ( venlifac.linea = :linfac.linea )   ;
COMMIT;
NEXT
f_actualizar_venfactura(codigo_empresa,periodo,factura)
end subroutine

event open;call super::open;string moneda_genter

istr_parametros = Message.PowerObjectParm
istr_parametros.s_titulo_ventana="Introducción lineas de facturas"
This.title=istr_parametros.s_titulo_ventana
tipo_precio = 1
dw_detalle.SetTransObject(SQLCA)
dw_pie.SetTransObject(SQLCA)



IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_factura.text=istr_parametros.s_argumentos[3]	
     IF Trim(em_anyo.text)<>"" and Trim(em_factura.text)<>"" THEN
         f_control()
     END IF
     istr_parametros.i_nargumentos=0

     
venfac.anyo   = Dec(em_anyo.text)
venfac.factura = Dec(em_factura.text)


  SELECT venfac.empresa,venfac.anyo,
  			venfac.factura,venfac.ffactura,   
         venfac.falta,venfac.cliente,
         venfac.observaciones,venfac.codpago,
			venfac.agente1,venfac.agente2,venfac.comision11,
			venfac.comision12,venfac.comision21,
			venfac.comision22,venfac.dtopp,venfac.dtoesp1,   
         venfac.dtoesp2,venfac.dtoesp3,   
         venfac.dtoesp4,venfac.tipodto1,   
         venfac.tipodto2,venfac.tipodto3,   
         venfac.tipodto4,venfac.explicaciondto1,   
         venfac.explicaciondto2,venfac.explicaciondto3,   
         venfac.explicaciondto4,venfac.tipoiva,   
         venfac.iva,venfac.numpedcli,venfac.idioma,   
         venfac.divisa,venfac.cambio,venfac.tarifa,   
         venfac.ftarifa,venfac.fbloqueo,
         venfac.serie,venfac.zona,
         venfac.forma_envio,venfac.cod_entrega,   
         venfac.usuario,venfac.tipo_portes,
			venfac.periodo_fac,venfac.peso,venfac.actualizada  
         INTO :venfac.empresa,:venfac.anyo,:venfac.factura,:venfac.ffactura,   
         :venfac.falta,:venfac.cliente,
         :venfac.observaciones,:venfac.codpago,:venfac.agente1,   
         :venfac.agente2,:venfac.comision11,:venfac.comision12,
         :venfac.comision21,:venfac.comision22,:venfac.dtopp,
         :venfac.dtoesp1,:venfac.dtoesp2,:venfac.dtoesp3,:venfac.dtoesp4,   
         :venfac.tipodto1,:venfac.tipodto2,:venfac.tipodto3,
         :venfac.tipodto4,:venfac.explicaciondto1,:venfac.explicaciondto2,   
         :venfac.explicaciondto3,:venfac.explicaciondto4,:venfac.tipoiva,   
         :venfac.iva,:venfac.numpedcli,:venfac.idioma,:venfac.divisa,   
         :venfac.cambio,:venfac.tarifa,:venfac.ftarifa,:venfac.fbloqueo,   
         :venfac.serie,:venfac.zona,:venfac.forma_envio,   
         :venfac.cod_entrega,:venfac.usuario,:venfac.tipo_portes,   
         :venfac.periodo_fac,:venfac.peso,:var_actualizada 
         FROM venfac  
         WHERE (venfac.empresa = :codigo_empresa)
         AND   (venfac.anyo    = :venfac.anyo)
         AND   (venfac.factura  = :venfac.factura)   
         ORDER BY venfac.empresa ASC,venfac.anyo ASC,venfac.factura ASC  ;

      em_cliente.text = venfac.cliente

     	st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)

     tipo = "I"
	  
		int li_decimales_precio
		string  ls_mascara_moneda_tarifa
		
		li_decimales_precio       = f_ventarifas_decimales_precios(codigo_empresa,venfac.tarifa)
		ls_mascara_moneda_tarifa  = f_mascara_decimales(li_decimales_precio)
		
		em_precio.setmask(DecimalMask!,ls_mascara_moneda_tarifa)
		
		f_mascara_columna(dw_detalle,"precio",ls_mascara_moneda_tarifa)
		f_mascara_columna(dw_detalle,"calculo_precio",ls_mascara_moneda_tarifa)	  
	  
	  moneda_genter = f_moneda_genter(codigo_empresa,"C",venfac.cliente)

		if moneda_genter = "7" then
			p_1.PictureName = "c:\bmp\ecu.bmp"
			st_moneda.text = "EUROS"
		else
			if moneda_genter = "1" then
				p_1.PictureName = "c:\bmp\nacional2.bmp"
				st_moneda.text = "PESETAS"
			else
				p_1.PictureName = "c:\bmp\globo.bmp"
				st_moneda.text = f_nombre_moneda(moneda_genter) 
			end if
		end if
END IF
cb_insertar.TriggerEvent(Clicked!)
f_peso_linea()
end event

event close;call super::close; longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(string(dec(em_anyo.text))))
 criterio[2]  =  trim(string(dec(em_anyo.text)))+space(20-longitud)
 longitud     =  len(Trim(string(dec(em_factura.text))))
 criterio[3]  =  trim(string(dec(em_factura.text)))+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "venfac"
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT;
 
 
end event

event ue_f7;call super::ue_f7;cb_valorar.TriggerEvent(Clicked!)
end event

event ue_f3;call super::ue_f3;if var_actualizada <> "S" then cb_grabar.TriggerEvent(Clicked!)
end event

event ue_f6;call super::ue_f6;if var_actualizada <> "S" then cb_reservas.TriggerEvent(Clicked!)
end event

event ue_f5;call super::ue_f5;if var_actualizada <> "S" then cb_stock.TriggerEvent(Clicked!)
end event

event ue_f4;call super::ue_f4;if var_actualizada <> "S" then cb_borrar.TriggerEvent(Clicked!)
end event

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

on w_int_venlifac.create
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
this.em_anyo=create em_anyo
this.gb_6=create gb_6
this.gb_3=create gb_3
this.em_situacion=create em_situacion
this.gb_4=create gb_4
this.cb_valorar=create cb_valorar
this.em_factura=create em_factura
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
this.em_calibre=create em_calibre
this.gb_2=create gb_2
this.uo_caja=create uo_caja
this.st_dto2=create st_dto2
this.em_descuento2=create em_descuento2
this.st_calibre=create st_calibre
this.st_caja=create st_caja
this.em_observ_lin=create em_observ_lin
this.st_44=create st_44
this.st_texto_npal=create st_texto_npal
this.em_npal=create em_npal
this.p_1=create p_1
this.st_moneda=create st_moneda
this.st_idioma=create st_idioma
this.uo_idioma=create uo_idioma
this.uo_calidad=create uo_calidad
this.cb_palmas=create cb_palmas
this.cb_cajmas=create cb_cajmas
this.cb_cajmenos=create cb_cajmenos
this.cb_palmenos=create cb_palmenos
this.em_tono_imprimir=create em_tono_imprimir
this.em_calibre_imprimir=create em_calibre_imprimir
this.st_1=create st_1
this.st_8=create st_8
this.dw_detalle=create dw_detalle
this.em_cantidad_en_pzs=create em_cantidad_en_pzs
this.em_precio_pzs=create em_precio_pzs
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
this.Control[iCurrent+33]=this.dw_pie
this.Control[iCurrent+34]=this.em_anyo
this.Control[iCurrent+35]=this.gb_6
this.Control[iCurrent+36]=this.gb_3
this.Control[iCurrent+37]=this.em_situacion
this.Control[iCurrent+38]=this.gb_4
this.Control[iCurrent+39]=this.cb_valorar
this.Control[iCurrent+40]=this.em_factura
this.Control[iCurrent+41]=this.st_4
this.Control[iCurrent+42]=this.st_5
this.Control[iCurrent+43]=this.st_peso_linea
this.Control[iCurrent+44]=this.gb_1
this.Control[iCurrent+45]=this.st_2
this.Control[iCurrent+46]=this.em_porcentaje
this.Control[iCurrent+47]=this.st_proforma
this.Control[iCurrent+48]=this.st_6
this.Control[iCurrent+49]=this.st_peso_total
this.Control[iCurrent+50]=this.st_7
this.Control[iCurrent+51]=this.st_tono
this.Control[iCurrent+52]=this.em_tono
this.Control[iCurrent+53]=this.em_calibre
this.Control[iCurrent+54]=this.gb_2
this.Control[iCurrent+55]=this.uo_caja
this.Control[iCurrent+56]=this.st_dto2
this.Control[iCurrent+57]=this.em_descuento2
this.Control[iCurrent+58]=this.st_calibre
this.Control[iCurrent+59]=this.st_caja
this.Control[iCurrent+60]=this.em_observ_lin
this.Control[iCurrent+61]=this.st_44
this.Control[iCurrent+62]=this.st_texto_npal
this.Control[iCurrent+63]=this.em_npal
this.Control[iCurrent+64]=this.p_1
this.Control[iCurrent+65]=this.st_moneda
this.Control[iCurrent+66]=this.st_idioma
this.Control[iCurrent+67]=this.uo_idioma
this.Control[iCurrent+68]=this.uo_calidad
this.Control[iCurrent+69]=this.cb_palmas
this.Control[iCurrent+70]=this.cb_cajmas
this.Control[iCurrent+71]=this.cb_cajmenos
this.Control[iCurrent+72]=this.cb_palmenos
this.Control[iCurrent+73]=this.em_tono_imprimir
this.Control[iCurrent+74]=this.em_calibre_imprimir
this.Control[iCurrent+75]=this.st_1
this.Control[iCurrent+76]=this.st_8
this.Control[iCurrent+77]=this.dw_detalle
this.Control[iCurrent+78]=this.em_cantidad_en_pzs
this.Control[iCurrent+79]=this.em_precio_pzs
end on

on w_int_venlifac.destroy
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
destroy(this.em_anyo)
destroy(this.gb_6)
destroy(this.gb_3)
destroy(this.em_situacion)
destroy(this.gb_4)
destroy(this.cb_valorar)
destroy(this.em_factura)
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
destroy(this.em_calibre)
destroy(this.gb_2)
destroy(this.uo_caja)
destroy(this.st_dto2)
destroy(this.em_descuento2)
destroy(this.st_calibre)
destroy(this.st_caja)
destroy(this.em_observ_lin)
destroy(this.st_44)
destroy(this.st_texto_npal)
destroy(this.em_npal)
destroy(this.p_1)
destroy(this.st_moneda)
destroy(this.st_idioma)
destroy(this.uo_idioma)
destroy(this.uo_calidad)
destroy(this.cb_palmas)
destroy(this.cb_cajmas)
destroy(this.cb_cajmenos)
destroy(this.cb_palmenos)
destroy(this.em_tono_imprimir)
destroy(this.em_calibre_imprimir)
destroy(this.st_1)
destroy(this.st_8)
destroy(this.dw_detalle)
destroy(this.em_cantidad_en_pzs)
destroy(this.em_precio_pzs)
end on

event ue_f2;call super::ue_f2;if var_actualizada <> "S" then cb_insertar.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_int_venlifac = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_venlifac
integer taborder = 120
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_venlifac
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_venlifac
integer x = 9
integer y = 4
integer width = 2629
integer height = 112
end type

type pb_1 from upb_salir within w_int_venlifac
integer x = 4951
integer y = 116
integer width = 110
integer height = 104
integer taborder = 0
end type

type st_3 from statictext within w_int_venlifac
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

type st_texto_cantidad from statictext within w_int_venlifac
integer x = 3973
integer y = 2088
integer width = 430
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

type st_pallets from statictext within w_int_venlifac
integer x = 3301
integer y = 2088
integer width = 119
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

type st_total_cajas from statictext within w_int_venlifac
integer x = 3552
integer y = 2088
integer width = 192
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

type st_cajas from statictext within w_int_venlifac
integer x = 3419
integer y = 2088
integer width = 133
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

type st_tipopallet from statictext within w_int_venlifac
integer x = 3182
integer y = 2088
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

type st_calidad from statictext within w_int_venlifac
integer x = 2551
integer y = 2088
integer width = 146
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

type st_articulo from statictext within w_int_venlifac
integer x = 814
integer y = 2088
integer width = 1618
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

type em_t_pallets from u_em_campo within w_int_venlifac
integer x = 3301
integer y = 2160
integer width = 119
integer height = 88
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = ""
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&								  
                          integer(em_t_pallets.text),&
                          0,0, uo_tipolinea.em_codigo.text)
                      
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

em_cantidad_en_pzs.text = string(f_conversion_cantidad_piezas( codigo_empresa, uo_articulo.em_codigo.text, uo_caja.em_codigo.text, dec(em_cantidad.text)), em_cantidad_en_pzs.mask)

IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
end event

event getfocus;call super::getfocus;ante_pallets = Integer(This.text)
campo_actual = "PALLETS"
f_peso_linea()
end event

type em_cajas from u_em_campo within w_int_venlifac
integer x = 3419
integer y = 2160
integer width = 133
integer height = 88
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena
long   posi,posi_aux

IF ante_cajas <> Integer(This.text) Then em_mtrs_lineales.text=""

//cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
//                          uo_tipo_pallet.em_codigo.text,&
//                          uo_caja.em_codigo.text,&								  
//                           integer(em_t_pallets.text),&
//                           integer(em_cajas.text),&
//                           Dec(em_cantidad.text))
cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&								  
                           0,&
                           integer(em_cajas.text),&
                           0, uo_tipolinea.em_codigo.text)
                      
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

em_cantidad_en_pzs.text = string(f_conversion_cantidad_piezas( codigo_empresa, uo_articulo.em_codigo.text, uo_caja.em_codigo.text, dec(em_cantidad.text)), em_cantidad_en_pzs.mask)

f_calculo_precio()

Dec metroscaja
String familia, unidad_articulo
Long n_piezascaja

unidad_articulo = f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)
n_piezascaja = 0
familia = ""
if not isnull(uo_articulo.em_codigo.text) and uo_articulo.em_codigo.text <> "" and not isnull(uo_caja.em_codigo.text) and uo_caja.em_codigo.text <> "" then
	SELECT  almartcajas.piezascaja, almartcajas.metroscaja, articulos.familia  
	INTO    	:n_piezascaja, :metroscaja, :familia  
	FROM    	almartcajas  INNER JOIN articulos ON almartcajas.empresa = articulos.empresa AND almartcajas.articulo = articulos.codigo  
	WHERE  almartcajas.empresa   = :codigo_empresa
	AND     	almartcajas.articulo  = :uo_articulo.em_codigo.text
	AND     	almartcajas.caja      = :uo_caja.em_codigo.text;
	if isnull(n_piezascaja) then n_piezascaja = 0
	if isnull(metroscaja) then metroscaja = 0
	//metroscaja = round(metroscaja,2)
end if





/*
string cadena
long   posi,posi_aux

cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&								  
                           integer(em_t_pallets.text),&
                           integer(em_cajas.text),&
                           Dec(em_cantidad.text), uo_tipolinea.em_codigo.text)
                      
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

IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
*/
end event

event getfocus;call super::getfocus;ante_cajas = Integer(This.text)
campo_actual = "CAJAS"
f_peso_linea()
end event

type em_t_cajas from u_em_campo within w_int_venlifac
integer x = 3552
integer y = 2160
integer width = 192
integer height = 88
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type em_cantidad from u_em_campo within w_int_venlifac
integer x = 3973
integer y = 2160
integer width = 430
integer height = 88
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.000"
end type

event modificado;call super::modificado;IF var_control_alm ="S"  and var_sector = "S" THEN
 If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_t_pallets.text=""
 em_mtrs_lineales.text =""
 END  IF



 string cadena
 long posi,posi_aux
 
 cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                            uo_tipo_pallet.em_codigo.text,&
                            uo_caja.em_codigo.text,&									 
                            integer(em_t_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text), uo_tipolinea.em_codigo.text)
                       
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

	em_cantidad_en_pzs.text = string(f_conversion_cantidad_piezas( codigo_empresa, uo_articulo.em_codigo.text, uo_caja.em_codigo.text, dec(em_cantidad.text)), em_cantidad_en_pzs.mask)

 IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()
END IF
f_peso_linea()
end event

event getfocus;call super::getfocus;IF var_control_alm = "N" Then st_texto_cantidad.text = "Unidades"
ante_valor= Dec(em_cantidad.text)
campo_actual = "CANTIDAD"
f_peso_linea()
end event

type uo_articulo from u_em_campo_2 within w_int_venlifac
integer x = 814
integer y = 2160
integer width = 1618
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_empresa,codigo_articulo,texto_unidad
String cod_tono,cod_calibre
Long   total_desc

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
em_descuento.text = ''
em_descuento2.text = ''

select count(descripcion)
into :total_desc
from almcliartdesc
where empresa=:codigo_empresa and
		cliente=:venfac.cliente and
		articulo=:uo_articulo.em_codigo.text
group by empresa,cliente,articulo;
	
if isnull(total_desc) then total_desc = 0
	
if total_desc >= 1 then
	uo_idioma.em_codigo.text = "1"
	uo_idioma.em_campo.text = "1"
	if total_desc = 1 then
		uo_idioma.em_codigo.enabled = FALSE
	else
		uo_idioma.em_codigo.enabled = TRUE
	end if
end if

if total_desc = 0 then
	uo_idioma.em_codigo.text = "0"
	uo_idioma.em_campo.text = "0"
	uo_idioma.em_codigo.enabled = FALSE
end if

IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
END IF

codigo_articulo=uo_articulo.em_codigo.text
SELECT articulos.empresa,articulos.codigo,articulos.familia ,articulos.formato,articulos.unidad
INTO :mov.empresa,:mov.articulo,:cod_familia,:cod_formato,:cod_tipo_unidad
FROM articulos  
WHERE (articulos.empresa = :codigo_empresa) AND  
		(articulos.codigo  = :codigo_articulo);

//if uo_tipolinea.em_codigo.text = "4" then cod_tipo_unidad = "0"  //MUY IMPORTANTE - Promoción siempre en piezas

if ib_gestionar_en_piezas then
	st_texto_cantidad.text = "Piezas"
else
	st_texto_cantidad.text = f_nombre_unidad(cod_tipo_unidad)
end if

if cod_tipo_unidad = "1" then
	em_cantidad.Setmask(DecimalMask!,"###,###,##0.000")
else
	em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(cod_tipo_unidad))
end if
f_campos_segun_tiplin()
f_peso_linea()
end event

event getfocus;call super::getfocus;// para controlar valor anterior
articulo_ant = uo_articulo.em_codigo.text


ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
f_botones()

campo_actual = "ARTICULO"
end event

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

type uo_tipo_pallet from u_em_campo_2 within w_int_venlifac
integer x = 3182
integer y = 2160
integer width = 114
integer height = 88
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tipo_pallet.em_campo.text=f_nombre_palarticulocaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)
//st_pal.text = string(f_cajas_pallet_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text),"###,###")
IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
   uo_tipo_pallet.em_campo.SetFocus()
 END IF
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF

f_peso_linea()
/*
uo_tipo_pallet.em_campo.text=f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)

IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
   uo_tipo_pallet.em_campo.SetFocus()
 END IF
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF


f_peso_linea()
*/
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 
campo_actual = "TIPO_PALLET"
/*
ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_pallets_abr"
ue_filtro     = ""
campo_actual = "TIPO_PALLET"


*/
end event

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

type st_texto_mtrslinieales from statictext within w_int_venlifac
integer x = 3744
integer y = 2088
integer width = 229
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

type em_mtrs_lineales from u_em_campo within w_int_venlifac
integer x = 3744
integer y = 2160
integer width = 229
integer height = 88
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
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
long posi,posi_aux

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
IF precio_ant = Dec(em_precio.text) Then f_calculo_precio()

end event

type em_cliente from u_em_campo within w_int_venlifac
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

type st_nombre_cliente from statictext within w_int_venlifac
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

type cb_grabar from u_boton within w_int_venlifac
integer x = 2971
integer y = 2352
integer width = 398
integer height = 68
integer taborder = 0
string text = "F3 Grabar  "
end type

event clicked;Dec{0}    var_anyo,var_factura
Dec{4}    var_precio
String    mascara,es_pico

mascara        = f_mascara_moneda(venfac.divisa)
var_anyo       = Dec(em_anyo.text)
var_factura    = Dec(em_factura.text)
var_precio     = Dec(em_precio.text)

IF tipo_precio = 2 Then
	f_grabar_linea()
	f_control()
	return
END IF

String motivo,controles,referencia,condicion,tipo_unidad,texto,acumular,condicion2
Integer  opcion,var_linea_acumulado
dec{2}   disponible,var_conjunto,diferencia,piezas_caja,dife,var_precio1,var_precio2
EditMask campo
tipo_unidad = f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)
if uo_tipolinea.em_codigo.text = "4" then tipo_unidad = "0" //PROMOCION SIEMPRE EN PIEZAS

IF This.visible = FALSE Then RETURN
controles ="N"
acumular = "N" 

IF Trim(uo_tipolinea.em_codigo.text) = "" or Trim(uo_tipolinea.em_campo.text)= ""  Then
  campo   = uo_tipolinea.em_campo
  motivo  = "(Campo Obligatorio) Introduzca el tipo de linea"
  controles = "S"
END IF

var_control_alm = f_control_almacen_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)

IF var_sector = "S" and var_control_alm = "S" THEN
//	uo_tipo_pallet.TriggerEvent("modificado")
	IF TRIM(uo_tipo_pallet.em_campo.text)="" or IsNull(uo_tipo_pallet.em_campo.text) Then
		campo=uo_tipo_pallet.em_campo
		motivo= "(Campo Obligatorio) Introduzca el tipo de pallet"
		controles="S"
	END IF
	
//	uo_caja.TriggerEvent("modificado")
	IF TRIM(uo_caja.em_campo.text)="" or IsNull(uo_caja.em_campo.text) Then
		campo=uo_caja.em_campo
		motivo= "(Campo Obligatorio) Introduzca la caja"
		controles="S"
	END IF	

//	uo_calidad.TriggerEvent("modificado")
	IF TRIM(uo_calidad.em_campo.text)="" or IsNull(uo_calidad.em_campo.text) Then
		campo=uo_calidad.em_campo
		motivo= "(Campo Obligatorio) Introduzca la calidad"
		controles="S"
	END IF	

END IF

IF (Dec(em_cantidad.text) = 0  or IsNull(em_cantidad.text)) and (Dec(em_cantidad_en_pzs.text) = 0  or IsNull(em_cantidad.text)) Then
	motivo= "(Campo Obligatorio) Introduzca la cantidad"
	controles="S"
	
	if ib_gestionar_en_piezas then
		campo = em_cantidad_en_pzs	
	else
		campo = em_cantidad
	end if	
END IF

IF controles="S" THEN
	MessageBox("No se puede grabar la linea",motivo,Exclamation!, OK!,1)
	f_activar_campo(campo)
	Return
END IF

// Control clase de venta
var_clase ="V"

  // V-> Venta (típica)
  // M-> Muestras sin precio
  // S-> Ventas sin cargo
  // P-> Precio pendiente

IF ( Dec(em_precio.text) = 0  or IsNull(em_precio.text) ) and ( Dec(em_precio_pzs.text) = 0  or IsNull(em_precio_pzs.text) ) Then
	campo=em_precio
	motivo= "(Campo Obligatorio) Introduzca el precio"
	controles="S"
	tipo_array arg
	arg.valor[1]  = "Linea de factura Sin precio"
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

type cb_borrar from u_boton within w_int_venlifac
integer x = 3369
integer y = 2284
integer width = 398
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F4 Borrar     "
end type

event clicked;call super::clicked;IF This.enabled = FALSE Then RETURN

//IF f_control_almacen_ventipolin(codigo_empresa,f_valor_columna(dw_detalle,dw_detalle.GetRow(),"tipolinea")) = "S" Then
//	f_mensaje("No se puede borrar la linea","Linea con control de almacen no se puede borrar")
//	Return
//END IF
If MessageBox("Comfirmacion Baja linea de factura","Desa borra la linea de pedido seleccionada",Question!, YesNo!,2)= 2 Then
  f_activar_primer_campo()
  Return
END IF

f_borrar_linea()
f_control()
cb_insertar.TriggerEvent(clicked!)

end event

type st_texto_precio from statictext within w_int_venlifac
integer x = 4416
integer y = 2088
integer width = 315
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

type em_precio from u_em_campo within w_int_venlifac
integer x = 4416
integer y = 2160
integer width = 315
integer height = 88
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.00"
end type

event modificado;call super::modificado;if venfac.divisa="1" then
	This.text = String(Dec(This.text),"###,###,###,###.00")
else
	This.text = String(Dec(This.text),f_mascara_precios_fra_moneda(venfac.divisa))
end if
campo_actual = "PRECIO"

end event

type em_descripcion from u_em_campo within w_int_venlifac
integer x = 14
integer y = 2344
integer width = 2043
integer taborder = 190
fontcharset fontcharset = ansi!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCRIPCION"
end on

type st_33 from statictext within w_int_venlifac
integer x = 14
integer y = 2268
integer width = 2048
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

type cb_insertar from u_boton within w_int_venlifac
integer x = 2971
integer y = 2284
integer width = 398
integer height = 68
integer taborder = 0
string text = "F2 Insertar"
end type

event clicked;control_incremento = "P"
tipo="I"
linea_factura = 0
em_cajas.text=""
em_tono.text=""
em_calibre.text=""
em_cantidad.text=""
em_descripcion.text=""
em_mtrs_lineales.text=""
em_precio.text=""
em_descuento.text=""
em_descuento2.text=''
em_situacion.text=""
em_t_cajas.text=""
em_t_pallets.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
uo_idioma.em_campo.text="0"
uo_idioma.em_codigo.text="0"
uo_tipo_pallet.em_campo.text=""
uo_articulo.em_codigo.text=""
articulo_ant=""
uo_calidad.em_codigo.text=""
uo_tipo_pallet.em_codigo.text=""
uo_tipolinea.em_codigo.text=""
em_observ_lin.text = ""
uo_tipolinea.em_campo.text = f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
uo_tipolinea.TriggerEvent("modificado")
em_situacion.text="S"
em_npal.text = "0"
f_botones()
dw_detalle.SelectRow(0,FALSE)
f_activar_primer_campo()
f_peso_linea()
end event

type uo_tipolinea from u_em_campo_2 within w_int_venlifac
integer x = 14
integer y = 2160
integer width = 795
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;f_campos_segun_tiplin()
uo_tipolinea.em_campo.text=f_nombre_ventipolin(codigo_empresa,uo_tipolinea.em_codigo.text)
IF Trim(uo_tipolinea.em_campo.text)=""  or IsNull(uo_tipolinea.em_campo.text)THEN 
 	IF Trim(uo_tipolinea.em_codigo.text)<>"" Then 
   		f_activar_campo(uo_tipolinea.em_campo)
 	END IF
 	uo_tipolinea.em_campo.text   = ""
 	uo_tipolinea.em_codigo.text  = ""
END IF
IF tipo = "I" Then  // "I" --> inserción, "M"-->  modificación
//	IF var_control_alm = "S" Then
//		f_mensaje("No se puede grabar la línea"," Sólo línea sin control de almacén")
//		uo_tipolinea.em_campo.text   = ""
//		uo_tipolinea.em_codigo.text  = ""
//		Return
//	END IF
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

type st_tplinea from statictext within w_int_venlifac
integer x = 14
integer y = 2088
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
string text = "Tp. linea"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stock from u_boton within w_int_venlifac
integer x = 3369
integer y = 2352
integer width = 398
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
          If em_tono.text= "0" Then em_tono.text="" 
          If em_calibre.text= "0" Then em_calibre.text="" 
          valores = Message.PowerObjectParm
          uo_articulo.em_campo.text= f_nombre_articulo(codigo_empresa,valores.s_argumentos[1])
          uo_articulo.em_codigo.text= valores.s_argumentos[1]
          uo_calidad.em_campo.text  = f_nombre_calidad_abr(codigo_empresa,valores.s_argumentos[2])
	   	 uo_calidad.em_codigo.text     = valores.s_argumentos[2]
		    em_tono.text                  = valores.s_argumentos[3]
		    em_calibre.text               = valores.s_argumentos[4]
          uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,valores.s_argumentos[5])
		    uo_tipo_pallet.em_codigo.text = valores.s_argumentos[5]
			 uo_calidad.ue_valor_anterior = uo_calidad.em_campo.text
			 f_activar_campo(uo_calidad.em_campo)
        END IF
end event

type cb_reservas from u_boton within w_int_venlifac
integer x = 3767
integer y = 2284
integer width = 398
integer height = 68
integer taborder = 0
string text = "F6 Reservas"
end type

event clicked;call super::clicked;IF This.enabled = FALSE Then RETURN
str_parametros valores
       IF var_control_alm = "N" Then Return
       f_consulta_reservas()
       IF Message.DoubleParm=-1  THEN 
       ELSE
        END IF
       f_activar_campo(uo_articulo.em_campo)

end event

type st_dto from statictext within w_int_venlifac
integer x = 2066
integer y = 2268
integer width = 174
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

type em_descuento from u_em_campo within w_int_venlifac
integer x = 2062
integer y = 2344
integer width = 178
integer taborder = 200
fontcharset fontcharset = ansi!
alignment alignment = right!
string mask = "xxxxxxxxxxxxx"
string displaydata = "Ì"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCUENTO"
end on

type dw_pie from datawindow within w_int_venlifac
boolean visible = false
integer x = 379
integer y = 440
integer width = 2185
integer height = 764
integer taborder = 280
boolean titlebar = true
string title = "Pie de Factura"
string dataobject = "dw_int_venlifac3"
boolean controlmenu = true
boolean livescroll = true
end type

on clicked;This.visible = FALSE
f_activar_primer_campo()
end on

type em_anyo from u_em_campo within w_int_venlifac
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

type gb_6 from groupbox within w_int_venlifac
integer x = 4672
integer y = 2272
integer width = 370
integer height = 308
integer taborder = 230
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Divisa Cliente"
end type

type gb_3 from groupbox within w_int_venlifac
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

type em_situacion from u_em_campo within w_int_venlifac
boolean visible = false
integer x = 23
integer y = 2128
integer width = 123
integer taborder = 250
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_int_venlifac
integer x = 2962
integer y = 2248
integer width = 1623
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_valorar from u_boton within w_int_venlifac
integer x = 3767
integer y = 2352
integer width = 398
integer height = 68
integer taborder = 0
boolean bringtotop = true
string text = "F7 Valorar   "
end type

event clicked;call super::clicked;dw_pie.visible = TRUE
dw_pie.InsertRow(1)
dw_pie.SetItem(1,"pie",f_pie_factura(codigo_empresa,Dec(em_anyo.text),Dec(em_factura.text)))
f_activar_primer_campo()


end event

type em_factura from u_em_campo within w_int_venlifac
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

type st_4 from statictext within w_int_venlifac
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

type st_5 from statictext within w_int_venlifac
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

type st_peso_linea from statictext within w_int_venlifac
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

type gb_1 from groupbox within w_int_venlifac
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

type st_2 from statictext within w_int_venlifac
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

type em_porcentaje from u_em_campo within w_int_venlifac
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
Dec{0} var_anyo,var_factura
var_porcentaje = Dec(em_porcentaje.text)
var_anyo     = Dec(em_anyo.text)
var_factura = Dec(em_factura.text)

IF messageBox("Proceso volcado de precios","Desea Volcar precios al "+ em_porcentaje.text +" %",Question!,YesNo!,2) = 1 Then
   UPDATE venlifac	
	Set    venlifac.precio_aduana = venlifac.precio * :var_porcentaje/100
	Where  venlifac.empresa  = :codigo_empresa
   And  	 venlifac.anyo     = :var_anyo
	And    venlifac.factura = :var_factura;
	UPDATE venfac	
	Set    venfac.porcentaje_aduana = :var_porcentaje
	Where  venfac.empresa  = :codigo_empresa
   And  	 venfac.anyo     = :var_anyo
	And    venfac.factura = :var_factura;
	COMMIT;
	f_control()
	f_recalcular_lineas()
	COMMIT;
	f_control()
END IF
end event

type st_proforma from dropdownlistbox within w_int_venlifac
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
string text = "Factura"
boolean vscrollbar = true
string item[] = {"Factura","Aduana"}
end type

event selectionchanged;Dec{4}  var_porcentaje
Dec{0}  var_anyo,var_factura

var_anyo= Dec(em_anyo.text)
var_factura= Dec(em_factura.text)

IF This.Text = "Aduana" Then
	tipo_precio = 2
	em_porcentaje.visible = TRUE
	Select venfac.porcentaje_aduana Into	:var_porcentaje
	From   venfac
	Where  venfac.empresa  = :codigo_empresa
	And  	 venfac.anyo     = :var_anyo
	And    venfac.factura = :var_factura;
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

type st_6 from statictext within w_int_venlifac
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

type st_peso_total from statictext within w_int_venlifac
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

type st_7 from statictext within w_int_venlifac
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

type st_tono from statictext within w_int_venlifac
integer x = 2912
integer y = 2088
integer width = 87
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_venlifac
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2702
integer y = 2160
integer width = 210
integer height = 88
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;campo_actual = "TONO"

end event

event modificado;call super::modificado;string cadena
long posi,posi_aux

cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&								  
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text), uo_tipolinea.em_codigo.text)
                      

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

type em_calibre from u_em_campo within w_int_venlifac
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2912
integer y = 2160
integer width = 87
integer height = 88
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;campo_actual = "TONO"

end event

event modificado;call super::modificado;string cadena
long   posi,posi_aux

cadena=f_calculo_unidades_tipolin(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&								  
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text), uo_tipolinea.em_codigo.text)
                      
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

type gb_2 from groupbox within w_int_venlifac
integer x = 512
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

type uo_caja from u_em_campo_2 within w_int_venlifac
event destroy ( )
integer x = 2999
integer y = 2160
integer width = 183
integer height = 88
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)
//st_pz.text = string(f_piezascaja_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text),"###,###")
//st_pal.text = string(f_cajas_pallet_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text),"###,###")
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
//ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"+" and almartcajas_pordefecto = 'S' "+" and palarticulo_pordefecto = 'S'"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
campo_actual  = "CAJA"

end event

type st_dto2 from statictext within w_int_venlifac
integer x = 2245
integer y = 2268
integer width = 174
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

type em_descuento2 from u_em_campo within w_int_venlifac
integer x = 2245
integer y = 2344
integer width = 178
integer taborder = 210
fontcharset fontcharset = ansi!
alignment alignment = right!
string mask = "xxxxxxxxxxxxx"
string displaydata = "Ì"
end type

on getfocus;call u_em_campo::getfocus;campo_actual = "DESCUENTO"
end on

type st_calibre from statictext within w_int_venlifac
integer x = 2702
integer y = 2088
integer width = 210
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_caja from statictext within w_int_venlifac
integer x = 2999
integer y = 2088
integer width = 183
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

type em_observ_lin from u_em_campo within w_int_venlifac
integer x = 14
integer y = 2520
integer width = 2775
integer taborder = 220
integer weight = 400
fontcharset fontcharset = ansi!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;campo_actual = "OBSERV_LIN"
end event

type st_44 from statictext within w_int_venlifac
integer x = 14
integer y = 2444
integer width = 2775
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones de la línea"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_npal from statictext within w_int_venlifac
integer x = 4736
integer y = 2088
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "NºPal."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_npal from u_em_campo within w_int_venlifac
integer x = 4736
integer y = 2160
integer width = 315
integer height = 88
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
string mask = "!!!!!"
end type

event modificado;call super::modificado;if venfac.divisa="1" then
	This.text = String(Dec(This.text),"###,###,###,###.00")
else
	This.text = String(Dec(This.text),f_mascara_precios_fra_moneda(venfac.divisa))
end if
campo_actual = "PRECIO"

end event

type p_1 from picture within w_int_venlifac
integer x = 4777
integer y = 2320
integer width = 165
integer height = 144
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_moneda from statictext within w_int_venlifac
integer x = 4699
integer y = 2476
integer width = 325
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_idioma from statictext within w_int_venlifac
integer x = 2437
integer y = 2088
integer width = 110
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Idi"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_idioma from u_em_campo_2 within w_int_venlifac
integer x = 2437
integer y = 2160
integer width = 110
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String des,desc2

uo_idioma.em_campo.text=uo_idioma.em_codigo.text
IF Trim(uo_idioma.em_campo.text)="" THEN 
 IF Trim(uo_idioma.em_codigo.text)<>"" Then uo_idioma.em_campo.SetFocus()
 uo_idioma.em_campo.text=""
 uo_idioma.em_codigo.text=""
END IF
des = uo_articulo.em_campo.text
desc2=f_descripcion_almcliartdesc2(codigo_empresa,venfac.cliente,uo_articulo.em_codigo.text,dec(uo_idioma.em_codigo.text))
if desc2<>'' then
	uo_articulo.em_campo.text=desc2
else		
	uo_articulo.em_campo.text=des
end if
em_descripcion.text = uo_articulo.em_campo.text
IF idioma_ant <> uo_idioma.em_codigo.text Then
   f_calculo_precio()
END IF
f_campos_segun_tiplin()
end event

event getfocus;call super::getfocus;// para controlar valor anterio
  idioma_ant = uo_idioma.em_codigo.text

valor_empresa = TRUE
ue_titulo     = "Ayuda seleccion de descripciones alternativas"
ue_datawindow = "dw_ayuda_almcliartdesc"
ue_filtro     = "cliente = '"+venfac.cliente+"' and codigo = '"+uo_articulo.em_codigo.text+"'"


campo_actual = "IDIOMA"
f_peso_linea()
end event

on uo_idioma.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_venlifac
integer x = 2551
integer y = 2160
integer width = 146
integer height = 88
integer taborder = 40
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

type cb_palmas from u_boton within w_int_venlifac
integer x = 4174
integer y = 2284
integer width = 302
integer height = 68
integer taborder = 240
boolean bringtotop = true
string text = "Pallets(+)"
end type

event clicked;call super::clicked;Dec pall,vanyo,vfactura,vlinea
IF dw_detalle.GetRow() <> 0 Then
//IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	vanyo    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vfactura = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"factura")
	vlinea   = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea_factura")
	IF IsNull(pall) Then pall = 0
	pall = pall +1
	
	Update venlifac
	Set pallets = :pall
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   factura = :vfactura
	And   linea_factura = :vlinea;
	
	if sqlca.sqlcode = 0 then
		Update venfac
		Set bultos = isnull(bultos,0) +1
		Where empresa = :codigo_empresa
		And   anyo    = :vanyo
		And   factura = :vfactura;		
		
		if sqlca.sqlcode = 0 then
			Commit;
			dw_detalle.SetItem(dw_detalle.GetRow(),"pallets",pall)
		else
			rollback;
		end if
		
	else
		rollback;
	end if
END IF
end event

type cb_cajmas from u_boton within w_int_venlifac
integer x = 4174
integer y = 2352
integer width = 302
integer height = 68
integer taborder = 260
boolean bringtotop = true
string text = "Cajas(+)"
end type

event clicked;call super::clicked;Dec cj,tcj,vanyo,vfactura,vlinea
IF dw_detalle.GetRow() <> 0 Then
//IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	cj     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	tcj     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vfactura = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"factura")
	vlinea   = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea_factura")
	IF IsNull(cj) Then cj = 0
	cj = cj +1
	IF IsNull(tcj) Then tcj = 0
	tcj = tcj +1
	dw_detalle.SetItem(dw_detalle.GetRow(),"cajas",cj)
	dw_detalle.SetItem(dw_detalle.GetRow(),"total_cajas",tcj)
	Update venlifac
	Set cajas = :cj,
	    total_cajas = :tcj
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   factura = :vfactura
	And   linea_factura = :vlinea;
	Commit;
END IF
end event

type cb_cajmenos from u_boton within w_int_venlifac
integer x = 4471
integer y = 2352
integer width = 91
integer height = 68
integer taborder = 290
boolean bringtotop = true
string text = "(-)"
end type

event clicked;call super::clicked;Dec cj,tcj,vanyo,vfactura,vlinea
IF dw_detalle.GetRow() <> 0 Then
//IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	cj     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cajas")
	tcj     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_cajas")
	vanyo    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vfactura = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"factura")
	vlinea   = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea_factura")
	IF IsNull(cj) Then cj = 0
	if cj=0 then return
	cj = cj - 1
	IF IsNull(tcj) Then tcj = 0
	tcj = tcj - 1
	dw_detalle.SetItem(dw_detalle.GetRow(),"cajas",cj)
	dw_detalle.SetItem(dw_detalle.GetRow(),"total_cajas",tcj)
	Update venlifac
	Set cajas = :cj,
	    total_cajas = :tcj
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   factura = :vfactura
	And   linea_factura = :vlinea;
	Commit;
END IF
end event

type cb_palmenos from u_boton within w_int_venlifac
integer x = 4471
integer y = 2284
integer width = 91
integer height = 68
integer taborder = 270
boolean bringtotop = true
string text = "(-)"
end type

event clicked;call super::clicked;Dec pall,vanyo,vfactura,vlinea
IF dw_detalle.GetRow() <> 0 Then
//IF f_control_almacen_ventipolin(codigo_empresa,dw_detalle.GetItemString(dw_detalle.GetRow(),"tipolinea")) = "N" Then Return
	pall     = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"pallets")
	vanyo    = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
	vfactura = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"factura")
	vlinea   = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"linea_factura")
	IF IsNull(pall) Then pall = 0
	IF pall = 0 then return
	pall = pall - 1
	
	Update venlifac
	Set pallets = :pall
	Where empresa = :codigo_empresa
	And   anyo    = :vanyo
	And   factura = :vfactura
	And   linea_factura = :vlinea;
	
	if sqlca.sqlcode = 0 then
		Update venfac
		Set bultos = isnull(bultos,0) -1
		Where empresa = :codigo_empresa
		And   anyo    = :vanyo
		And   factura = :vfactura;
		
		if sqlca.sqlcode = 0 then
			dw_detalle.SetItem(dw_detalle.GetRow(),"pallets",pall)
			Commit;
		else
			rollback;
		end if
	else
		rollback;
	end if
END IF
end event

type em_tono_imprimir from u_em_campo within w_int_venlifac
integer x = 2423
integer y = 2344
integer width = 425
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!!"
end type

type em_calibre_imprimir from u_em_campo within w_int_venlifac
integer x = 2853
integer y = 2344
integer width = 87
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

type st_1 from statictext within w_int_venlifac
integer x = 2853
integer y = 2268
integer width = 87
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
string text = "CI"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_venlifac
integer x = 2423
integer y = 2268
integer width = 425
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
string text = "Tono Imprimir"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_int_venlifac
integer x = 9
integer y = 240
integer width = 5051
integer height = 1832
string dataobject = "dw_int_venlifac2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;Dec vanyo,vfactura,vlinea_factura		
String lis

//f_campos_segun_tiplin()

IF Row = 0 Then 
   f_activar_primer_campo()
   Return
End IF
vanyo				= This.GetItemNumber(row,"anyo")
vfactura				= This.GetItemNumber(row,"factura")
vlinea_factura		= This.GetItemNumber(row,"linea_factura")

IF f_objeto_datawindow(This) = "listar_aduana" Then 
	IF This.getItemString(row,"listar_aduana") = "N" Then
		lis = "S"
		SetItem(row,"listar_aduana","S")
	ELSE
		IF This.GetItemNumber(row,"precio_aduana") <> 0 Then Return
		lis = "N"
		SetItem(row,"listar_aduana","N")
	END IF
	Update  venlifac 
	Set     listar_aduana = :lis
	Where empresa 		    = :codigo_empresa
	And   anyo    		    = :vanyo
	And   factura 		    = :vfactura
	And   linea_factura   = :vlinea_factura;
	COMMIT;
END IF

This.SelectRow(0,FALSE)
This.SelectRow(Row,TRUE)
uo_tipolinea.em_codigo.text =This.GetItemString(Row,"tipolinea")
uo_tipolinea.event modificado(0,0)
uo_tipolinea.ue_valor_anterior = uo_tipolinea.em_campo.text

tipo="M"
//f_campos_segun_tiplin()
uo_articulo.em_codigo.text    = This.GetItemString(Row,"articulo")
uo_articulo.event modificado(0,0) 
uo_articulo.ue_valor_anterior = uo_articulo.em_campo.text

em_cajas.text                 = String(This.GetItemNumber(Row,"cajas"))
em_cantidad.text              = String(This.GetItemNumber(Row,"cantidad"))
em_cantidad_en_pzs.text       = String(This.GetItemNumber(Row,"cantidad_pzs"))
ante_existencias              = Dec(em_cantidad.text)
em_descripcion.text           = This.GetItemString(Row,"descripcion")
em_mtrs_lineales.text         = String(This.GetItemNumber(Row,"metros_lineales"))
ante_valor                    = This.GetItemNumber(Row,"precio")
em_npal.text                  = String(This.GetItemNumber(Row,"numpalet"))
IF This.GetItemNumber(Row,"tipo_precio") = 1 Then
	em_precio.text                = String(This.GetItemNumber(Row,"precio"))
ELSE
	em_precio.text                = String(This.GetItemNumber(Row,"precio_aduana"))
END IF
em_precio_pzs.text            = f_valor_columna(This,Row,"precio_pzs")
em_descuento.text             = String(This.GetItemNumber(Row,"dtoesp"))
em_descuento2.text			   = String(This.GetItemNumber(Row,"dtoesp2"))
em_situacion.text             = This.GetItemString(Row,"situacion")
em_t_cajas.text               = String(This.GetItemNumber(Row,"total_cajas"))

uo_calidad.em_codigo.text     = This.GetItemString(Row,"calidad")
em_tono.text                  = Trim(This.GetItemString(Row,"tonochar"))
em_calibre.text               = String(This.GetItemNumber(Row,"calibre"))
em_tono_imprimir.text         = Trim(This.GetItemString(Row,"tono_imprimir"))
em_calibre_imprimir.text      = Trim(This.GetItemString(Row,"calibre_imprimir"))
uo_tipo_pallet.em_codigo.text = This.GetItemString(Row,"tipo_pallet")
uo_caja.em_codigo.text 		   = This.GetItemString(Row,"caja")
em_t_pallets.text             = String(This.GetItemNumber(Row,"pallets"))
linea_factura	               = This.GetItemNumber(Row,"linea_factura")
control_incremento            = This.GetItemString(Row,"control_incremento")
uo_calidad.em_campo.text      = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
uo_caja.em_campo.text         = f_nombre_caja_abr(codigo_empresa,uo_caja.em_codigo.text)
referencia_ant                = String(This.GetItemString(Row,"referencia"))
tipopallet_ant                = String(This.GetItemString(Row,"tipo_pallet"))
cod_familia                   = String(This.GetItemString(Row,"familia"))
cod_formato                   = String(This.GetItemString(Row,"formato"))
var_situacion                 = String(This.GetItemString(Row,"situacion"))
cod_tipo_unidad               = String(This.GetItemString(Row,"tipo_unidad"))
em_observ_lin.text            = This.GetItemString(Row,"observ_lin")
uo_idioma.em_codigo.text      = This.GetItemString(Row,"idioma")
uo_idioma.em_campo.text       = This.GetItemString(Row,"idioma")
//st_texto_cantidad.text=f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
//tipo="M"
f_botones()
f_peso_linea()
f_activar_primer_campo()
//f_campos_segun_tiplin()
Return
end event

event doubleclicked;/*
Dec v_fac,v_anyo,v_linea
String v_tipolinea
Boolean v_cambio=false

if row=0 then return
IF var_actualizada="S" then 
	f_mensaje("Cambio de Tipo de Línea","No se puede cambiar el tipo de línea porque la factura ya está contabilizada")
	return
end if

v_anyo      = dw_detalle.GetItemNumber(GetRow(),"anyo")
v_fac       = dw_detalle.GetItemNumber(GetRow(),"factura")
v_linea     = dw_detalle.GetItemNumber(GetRow(),"linea")
v_tipolinea = dw_detalle.GetItemString(GetRow(),"tipolinea")

if v_tipolinea = "1" then 
	v_tipolinea="7"
	v_cambio = true
else 
	if v_tipolinea="7" then
		v_tipolinea="1"
		v_cambio = true
	end if
end if

if v_cambio then
	update venlifac
	set tipolinea = :v_tipolinea
	where empresa = :codigo_empresa
	and   anyo    = :v_anyo
	and   factura = :v_fac
	and   linea   = :v_linea
	using sqlca;
	
	if sqlca.sqlcode = 0 then
		COMMIT;
		f_control()
	else
		f_mensaje ("Introducción de líneas","Error en el cambio de tipo de línea")
		ROLLBACK;
	end if
		
end if	

*/
end event

type em_cantidad_en_pzs from u_em_campo within w_int_venlifac
integer x = 3973
integer y = 2160
integer width = 430
integer height = 88
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

type em_precio_pzs from u_em_campo within w_int_venlifac
integer x = 4416
integer y = 2160
integer width = 315
integer height = 88
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.00"
end type

event modified;call super::modified;string ls_articulo,ls_caja
dec    ld_m2_caja
long   ll_piezas_caja


ls_articulo   = uo_articulo.em_codigo.text
ls_caja       = uo_caja.em_codigo.text

if f_unidad_articulo(codigo_empresa,ls_articulo) = "1" then
		
	ld_m2_caja     = f_metroscaja_articulo(codigo_empresa,ls_articulo,ls_caja)
	ll_piezas_caja = f_piezascaja_articulo(codigo_empresa,ls_articulo,ls_caja)
	
	if ll_piezas_caja <> 0 and ld_m2_caja <> 0 then
		em_precio.text = string( (dec(this.text) * ll_piezas_caja) / ld_m2_caja,em_precio.mask)
	else
		em_precio.text = "0"
	end if

else
	em_precio.text = em_precio_pzs.text
end if

end event

