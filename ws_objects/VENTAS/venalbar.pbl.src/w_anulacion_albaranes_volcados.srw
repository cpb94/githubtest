$PBExportHeader$w_anulacion_albaranes_volcados.srw
forward
global type w_anulacion_albaranes_volcados from w_int_con_empresa
end type
type pb_1 from upb_salir within w_anulacion_albaranes_volcados
end type
type st_2 from statictext within w_anulacion_albaranes_volcados
end type
type uo_cliente from u_em_campo_2 within w_anulacion_albaranes_volcados
end type
type gb_1 from groupbox within w_anulacion_albaranes_volcados
end type
type cb_continuar from commandbutton within w_anulacion_albaranes_volcados
end type
type dw_detalle from u_datawindow_consultas within w_anulacion_albaranes_volcados
end type
type cb_marcar from commandbutton within w_anulacion_albaranes_volcados
end type
type dw_detalle2 from u_datawindow_consultas within w_anulacion_albaranes_volcados
end type
type cb_procesar from commandbutton within w_anulacion_albaranes_volcados
end type
type cb_desmarcar from commandbutton within w_anulacion_albaranes_volcados
end type
end forward

global type w_anulacion_albaranes_volcados from w_int_con_empresa
integer width = 2898
integer height = 1680
pb_1 pb_1
st_2 st_2
uo_cliente uo_cliente
gb_1 gb_1
cb_continuar cb_continuar
dw_detalle dw_detalle
cb_marcar cb_marcar
dw_detalle2 dw_detalle2
cb_procesar cb_procesar
cb_desmarcar cb_desmarcar
end type
global w_anulacion_albaranes_volcados w_anulacion_albaranes_volcados

type variables
Dec  d
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_detalle (integer reg)
public subroutine f_anular ()
public function boolean f_entrada_almacen (str_venliped l, string ubicacion)
end prototypes

public subroutine f_control ();STring   cli1,cli2
dw_detalle.Reset()
dw_detalle2.Reset()
IF Trim(uo_cliente.em_codigo.text) = "" Then
	cli1 = "."
	cli2 = "Z"
ELSE
	cli1 = 	uo_cliente.em_codigo.text
	cli2 = 	uo_cliente.em_codigo.text
END IF
dw_detalle.Retrieve(codigo_empresa,cli1,cli2)
f_activar_campo(uo_cliente.em_campo)


end subroutine

public subroutine f_detalle (integer reg);IF reg = 0 Then Return
IF dw_detalle.RowCount() = 0 Then Return
dw_detalle2.Retrieve(codigo_empresa,dw_detalle.GetItemNumber(reg,"venalb2_anyo"),dw_detalle.GetItemNumber(reg,"venalb2_albaran"))
end subroutine

public subroutine f_anular ();Dec  r,r1,anyo,albaran,linea,bien,pedido,anyo_ped,numero
String ubicacion

Str_venliped l
Str_venped p
l.empresa = codigo_empresa
bien = 0 
r1 = dw_detalle2.RowCount()	
// Proceso de Anulacion albaranes
For r = 1 To r1
	IF dw_detalle2.GetItemSTring(r,"cmarca") = "S" Then
		// Proceso linea a anular
		anyo      = dw_detalle2.GetItemNumber(r,"venlialb2_anyo")
		albaran   = dw_detalle2.GetItemNumber(r,"venlialb2_albaran")
		linea     = dw_detalle2.GetItemNumber(r,"venlialb2_linea")
		anyo_ped  = dw_detalle2.GetItemNumber(r,"venlialb2_anyo_pedido_origen")
		pedido    = dw_detalle2.GetItemNumber(r,"venlialb2_pedido_origen")
		
		  SELECT     venlialb2.serie,  venlialb2.falbaran, venlialb2.fentrega,   
         venlialb2.cliente,   venlialb2.tipo_unidad,    venlialb2.articulo,   
         venlialb2.familia,   venlialb2.formato,       venlialb2.modelo,   
         venlialb2.calidad,   venlialb2.tonochar,     venlialb2.calibre,   
         venlialb2.precio,    venlialb2.precio_estand,   venlialb2.cantidad,   
         venlialb2.pallets,   venlialb2.total_cajas,   venlialb2.cajas,   
         venlialb2.dtocomer,  venlialb2.dtoesp,     venlialb2.descripcion,   
         venlialb2.tipoiva,   venlialb2.iva,     venlialb2.linfab,   
         venlialb2.provincia,   venlialb2.pais,    venlialb2.zona,   
         venlialb2.tipolinea,  venlialb2.texto1,      venlialb2.texto2,   
         venlialb2.texto3,    venlialb2.texto4,    venlialb2.referencia,   
         venlialb2.montajeartcal,    venlialb2.situacion,  venlialb2.divisa,   
         venlialb2.metros_lineales,  venlialb2.peso,    venlialb2.falta,   
         venlialb2.usuario,   venlialb2.tipo_pallet,    venlialb2.importe,   
         venlialb2.descuento, venlialb2.importedto,     venlialb2.clase,   
         venlialb2.sector,   venlialb2.agente1,    venlialb2.agente2,   
         venlialb2.agente3,  venlialb2.comision11,   venlialb2.comision12,   
         venlialb2.comision21,  venlialb2.comision22,   venlialb2.comision31,   
         venlialb2.comision32,  venlialb2.deposito,     venlialb2.orden_preparacion,   
         venlialb2.cantidad_prepa,   venlialb2.es_pico, venlialb2.numero_pico,   
         venlialb2.anyo_ent,    venlialb2.nummov_ent,   venlialb2.anyo_sal,   
         venlialb2.nummov_sal,  venlialb2.fila_ent,    venlialb2.altura_ent,   
         venlialb2.operario_prepa, venlialb2.control_incremento,   
         venlialb2.peso_neto,      venlialb2.precio_aduana,   
         venlialb2.control_descuentos,  venlialb2.control_comisiones,   
         venlialb2.importe_aduana, venlialb2.bruto, venlialb2.precio_neto,   
         venlialb2.precio_aduana_neto, venlialb2.descuento_aduana,   
         venlialb2.neto, venlialb2.impdtopp, venlialb2.ref_cli,   
         venlialb2.transportista, venlialb2.almacen_ent,   
         venlialb2.anyo_pedido_origen,  venlialb2.pedido_origen,   
         venlialb2.almacen_deposito,   venlialb2.envio ,venlialb2.ubicacion,venlialb2.agrupa_exp
    INTO :l.serie,          :l.fpedido,       :l.fentrega,     :l.cliente,
			:l.tipo_unidad,    :l.articulo,      :l.familia,      :l.formato,
			:l.modelo,         :l.calidad,       :l.tonochar,     :l.calibre,   
         :l.precio,         :l.precio_estand, :l.cantidad,     :l.pallets,   
         :l.total_cajas,    :l.cajas,         :l.dtocomer,     :l.dtoesp,   
         :l.descripcion,    :l.tipoiva,       :l.iva,          :l.linfab,   
         :l.provincia,      :l.pais,          :l.zona,         :l.tipolinea,   
         :l.texto1,         :l.texto2,        :l.texto3,       :l.texto4,   
         :l.referencia,     :l.montajeartcal, :l.situacion,    :l.divisa,   
         :l.metros_lineales,:l.peso,          :l.falta,        :l.usuario,   
         :l.tipo_pallet,    :l.importe,       :l.descuento,    :l.importedto,   
         :l.clase,          :l.sector,        :l.agente1,      :l.agente2,   
         :l.agente3,        :l.comision11,    :l.comision12,   :l.comision21,   
         :l.comision22,     :l.comision31,    :l.comision32,   :l.deposito,   
         :l.orden_preparacion,   :l.cantidad_prepa,     :l.es_pico, 
			:l.numero_pico,         :l.anyo_ent,           :l.nummov_ent,   
         :l.anyo_sal,            :l.nummov_sal,         :l.fila_ent,   
         :l.altura_ent,          :l.operario_prepa,     :l.control_incremento,   
         :l.peso_neto,           :l.precio_aduana,      :l.control_descuentos,   
         :l.control_comisiones,  :l.importe_aduana,     :l.bruto,   
         :l.precio_neto,         :l.precio_aduana_neto, :l.descuento_aduana,   
         :l.neto,                :l.impdtopp,           :l.ref_cli,   
         :l.transportista,       :l.almacen_ent,        :l.anyo,   
         :l.pedido,       :l.almacen_deposito,   :l.envio  ,:ubicacion,:p.agrupa_exp
   FROM venlialb2  
   WHERE venlialb2.empresa  = :codigo_empresa 
	AND   venlialb2.anyo     = :anyo 
	AND   venlialb2.albaran  = :albaran 
	AND   venlialb2.linea    = :linea;
	IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("seleccion venlialb2 Error",SQLCA.SQLERRTEXT)
		bien = 1
	END IF
	
	if l.pedido>0  and not isnull(l.pedido) then
		Select Count(*) Into :numero From venped
		Where  venped.empresa = :codigo_empresa
		And    venped.anyo    = :l.anyo
		And    venped.pedido  = :l.pedido;
		IF IsNUll(numero) Then numero = 0
		IF numero = 0 Then
						  SELECT venalb2.empresa,venalb2.falbaran,venalb2.fentrega,venalb2.falta,   
								venalb2.cliente,venalb2.flistado,venalb2.observaciones,
								venalb2.codpago,venalb2.agente1,venalb2.agente2,venalb2.comision1,   
								venalb2.comision2,venalb2.comision11,venalb2.comision22,   
								venalb2.dtopp,venalb2.dtoesp1,venalb2.dtoesp2,venalb2.dtoesp3,   
								venalb2.dtoesp4,venalb2.tipodto1,venalb2.tipodto2,venalb2.tipodto3,   
								venalb2.tipodto4,venalb2.explicaciondto1,venalb2.explicaciondto2,   
								venalb2.explicaciondto3,venalb2.explicaciondto4,venalb2.tipoiva,   
								venalb2.iva,venalb2.numpedcli,venalb2.idioma,venalb2.divisa,   
								venalb2.cambio,venalb2.tarifa,venalb2.ftarifa,venalb2.fbloqueo,   
								venalb2.transportista,venalb2.serie,venalb2.zona,venalb2.envio,   
								venalb2.correspondencia,venalb2.domiciliacion,venalb2.forma_envio,   
								venalb2.cod_entrega,venalb2.usuario,venalb2.tipo_portes,   
								venalb2.periodo_fac,venalb2.peso,venalb2.usuario_pedido,   
								venalb2.agente3,venalb2.comision31,venalb2.comision32,venalb2.veces,   
								venalb2.textcomercial1,venalb2.textcomercial2,venalb2.textaduanaesp1,   
								venalb2.textaduanaesp2,venalb2.textaduanaext1,venalb2.textaduanaext2,   
								venalb2.textopie1,venalb2.textopie2,venalb2.condicion,venalb2.peso_neto,   
								venalb2.banco_de_cobro,venalb2.porcentaje_aduana,venalb2.bruto,   
								venalb2.importe_dto,venalb2.total_neto, venalb2.calculo_dto,   
								venalb2.agrupa,venalb2.deposito,venalb2.almacen_deposito
								INTO :p.empresa,:p.fpedido,:p.fentrega,:p.falta,:p.cliente,   
								:p.flistado,:p.observaciones, :p.codpago,:p.agente1,   
								:p.agente2,:p.comision1,:p.comision2,:p.comision11,:p.comision22,   
								:p.dtopp,:p.dtoesp1,:p.dtoesp2,:p.dtoesp3,:p.dtoesp4,:p.tipodto1,   
								:p.tipodto2,:p.tipodto3,:p.tipodto4,:p.explicaciondto1,:p.explicaciondto2,   
								:p.explicaciondto3, :p.explicaciondto4,:p.tipoiva,:p.iva,:p.numpedcli,   
								:p.idioma,:p.divisa, :p.cambio,  :p.tarifa, :p.ftarifa, :p.fbloqueo,   
								:p.transportista,  :p.serie, :p.zona, :p.envio,:p.correspondencia,   
								:p.domiciliacion,:p.forma_envio, :p.cod_entrega,  :p.usuario,   
								:p.tipo_portes,  :p.periodo_fac,  :p.peso,  :p.usuario_pedido,   
								:p.agente3,    :p.comision31,   :p.comision32,     :p.veces,   
								:p.textcomercial1,     :p.textcomercial2,    :p.textaduanaesp1,   
								:p.textaduanaesp2,        :p.textaduanaext1,          :p.textaduanaext2,   
								:p.textopie1,         :p.textopie2,           :p.condicion,   
								:p.peso_neto,           :p.banco_de_cobro,    :p.porcentaje_aduana,   
								:p.bruto,           :p.importe_dto,           :p.total_neto,   
								:p.calculo_dto,     :p.agrupa,           :p.deposito,   
								:p.almacen_deposito
					
	   				FROM venalb2  
						WHERE venalb2.empresa = :codigo_empresa 
						AND   venalb2.anyo    = :anyo 
						AND   venalb2.albaran = :albaran  ;
								IF SQLCA.SQLCODE <> 0 Then 
									bien = 1
									f_mensaje("sele venalb2Error",SQLCA.SQLERRTEXT)
								END IF
							p.usuario_pedido = nombre_usuario
							p.anyo = l.anyo
							p.pedido = l.pedido
							IF Not f_insertar_venped(p) Then 
								bien = 1
								f_mensaje("Error",SQLCA.SQLERRTEXT)
							END IF
	   END IF
	
	   Select Max(venliped.linea) Into :l.linea From venliped
		Where  venliped.empresa  = :codigo_empresa
		And    venliped.anyo     = :l.anyo
		And    venliped.pedido   = :l.pedido;
		IF IsNull(l.linea) Then l.linea = 0
		l.linea = l.linea  + 1
		l.situacion = "P"
		l.tipo_pallet_preparacion = l.tipo_pallet
		IF Not f_insertar_venliped(l) Then 
			bien = 1
			f_mensaje("insertar venliped Error",SQLCA.SQLERRTEXT)
		END IF
		iF Not f_actualizar_linea_venpedido(l.empresa,l.anyo,l.pedido,l.linea)	 Then
			bien = 1
			f_mensaje("actualizar linea pedido Error",SQLCA.SQLERRTEXT)
		END IF
   
   End if
				
	 IF Not f_entrada_almacen(l,ubicacion) Then 
			bien = 1
			f_mensaje("insertar venliped Error",SQLCA.SQLERRTEXT)
	 END IF
		
		Delete  From  venlialb2
		Where   venlialb2.empresa = :codigo_empresa
		And     venlialb2.anyo    = :anyo
		And     venlialb2.albaran = :albaran
		And     venlialb2.linea   = :linea;
		IF SQLCA.SQLCODE <> 0 Then
			bien = 1
			f_mensaje("delete venlialb2 Error",SQLCA.SQLERRTEXT)
		END IF
		
		Select  count(*) Into :linea From venlialb2
		Where   venlialb2.empresa = :codigo_empresa
		And     venlialb2.anyo    = :anyo
		And     venlialb2.albaran = :albaran;
		IF IsNull(linea) Then linea = 0
		IF linea = 0 Then
				Delete from venalb2
				Where  venalb2.empresa = :codigo_empresa
				And    venalb2.anyo    = :anyo
				And    venalb2.albaran = :albaran;
				IF SQLCA.SQLCODE <> 0 Then
					bien = 1
					f_mensaje("delete venalb2 Error",SQLCA.SQLERRTEXT)
				END IF
		ELSE
				IF Not f_actualizar_venalbaran2(codigo_empresa,anyo,albaran)	 Then
					bien = 1
					f_mensaje("actualizar venalb2 Error",sqlca.sqlerrtext)
				END IF
		END IF
	END IF
	
	f_mensaje_proceso("Procesando",r,r1)
Next

IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error Datos","La Operacion no se contabiliza")
END IF
cb_continuar.TriggerEvent(Clicked!)

end subroutine

public function boolean f_entrada_almacen (str_venliped l, string ubicacion);// Entrada almacen
str_almlinubicahis ubihis
str_almlinubica    ubi
str_almmovhis      mov

String  antealmacen
integer y1,longitudes
Date    fecha
integer numero,controles,x2,x1
Decimal{4} total_cantidad,contador_nummov,contador_orden,cur_linea,existencias
string  mensaje,nombre,campo
controles  = 0
total_cantidad   = l.cantidad
integer bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubihis.usuario       = nombre_usuario
 mov.usuario          = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = l.anyo
 ubihis.almacen       = f_almacen_ubicacion(ubicacion)
 ubihis.articulo      = l.articulo
 ubihis.calidad       = l.calidad
 ubihis.tonochar      = l.tonochar
 ubihis.calibre       = l.calibre
 IF IsNUll(ubihis.calibre) Then ubihis.calibre = 0
 IF IsNUll(ubihis.tonochar)    Then ubihis.tonochar = ""
 if IsNull(ubihis.calidad) or trim(ubihis.calidad)="0" then ubihis.calidad = ""
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = DateTime(Today(),now())
 ubihis.observaciones = ""
 ubihis.tipomov       = "104"
 ubihis.tipo_pallet   = l.tipo_pallet


SELECT   articulos.familia,   
			articulos.subfamilia,   
			articulos.formato,
			articulos.subformato,
			articulos.modelo,
			articulos.unidad,
			articulos.sector
INTO     :ubihis.familia,
			:ubihis.subfamilia,
			:ubihis.formato,
			:ubihis.subformato,   
			:ubihis.modelo,
			:ubihis.tipo_unidad,
			:ubihis.sector
FROM     articulos  
WHERE    articulos.empresa = :ubihis.empresa  
AND      articulos.codigo  = :ubihis.articulo;

IF SQLCA.SQLCode <> 0 THEN bien = 1

 ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                      ubihis.calidad,&
                                      ubihis.tonochar,ubihis.calibre)
ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.subfamilia =  ubihis.subfamilia
ubi.formato    =  ubihis.formato
ubi.subformato =  ubihis.subformato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
ubi.tipo_pallet=  ubihis.tipo_pallet
ubi.sector     =  ubihis.sector
ubi.tipo_unidad=  ubihis.tipo_unidad
ubi.referencia =  ubihis.referencia
ubi.f_alta     =  Datetime(today(),now())
// Valor movimiento historico
mov.empresa    =  ubihis.empresa
mov.almacen    =  ubihis.almacen
mov.articulo   =  ubihis.articulo
mov.familia    =  ubihis.familia
mov.subfamilia =  ubihis.subfamilia
mov.formato    =  ubihis.formato
mov.subformato =  ubihis.subformato
mov.modelo     =  ubihis.modelo
mov.calidad    =  ubihis.calidad
mov.tonochar   =  ubihis.tonochar
mov.calibre    =  ubihis.calibre
mov.tipo_unidad=  ubihis.tipo_unidad
mov.tipo_pallet=  ubihis.tipo_pallet
mov.sector     =  ubihis.sector
mov.referencia =  ubihis.referencia
ubi.referencia =  mov.referencia
mov.f_alta     =  DateTime(Today(),now())
fecha          =  today()
mov.anyo       =  year(fecha)
mov.origen     =  "9"
mov.fechmov    =  ubihis.fecha
mov.tipomov    =  ubihis.tipomov
mov.cantidade  =  l.cantidad
mov.cantidads  =  0
mov.precio     =  0
mov.codtercero =  l.cliente
mov.numdoc        = String(l.pedido,"#####")
mov.situacion     = "N"
mov.observaciones = ""
SetNull(mov.punteado)
mov.antexist   =0
IF Trim(ubicacion) = "" Then 
	f_mensaje("Error ubicacion","Error")
   Return FALSE
END IF
// almlinubica
ubi.empresa      = codigo_empresa
ubihis.empresa   = codigo_empresa
mov.empresa      = codigo_empresa
contador_nummov  = f_almparam_nummov(codigo_empresa,Year(Today()))
contador_orden   = f_almparam_numorden(codigo_empresa,Year(Today()))
  mov.nummov     = contador_nummov
  ubihis.nummov  = contador_nummov
  ubihis.orden   = contador_orden
  ubi.almacen    = f_almacen_ubicacion(ubicacion)
  ubihis.almacen = ubi.almacen
  mov.almacen    = ubi.almacen
ubihis.zona       = f_zona_ubicacion(ubicacion)
ubihis.fila       = f_fila_ubicacion(ubicacion)
ubihis.altura     = f_altura_ubicacion(ubicacion)
IF IsNull(ubihis.altura) Then ubihis.altura = 0
ubihis.cantidade  = l.cantidad
ubihis.orden      = contador_orden
ubihis.nummov     = contador_nummov
ubihis.observaciones  = ""
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
     ubihis.observaciones =  "" 
   IF Not f_insert_almlinubicahis(ubihis) Then  bien=1
   
	
   // comprobamos si el albaran no tiene pedido
	if l.pedido=0 or isnull(l.pedido) then
			SELECT almlinubica.existencias,almlinubica.linea
			INTO   :existencias,:cur_linea  
			FROM   almlinubica  
			WHERE  almlinubica.empresa     = :ubi.empresa 
			AND    almlinubica.ubicacion   = :ubi.ubicacion 
			AND    almlinubica.referencia  = :ubi.referencia 
			AND    almlinubica.tipo_pallet = :ubi.tipo_pallet 
			AND    almlinubica.pedido      is null ;
			IF SQLCA.SQLCode<>0 THEN bien=1
			
			if not isnull(existencias) and existencias>0 and (existencias + ubi.existencias)>=0 then
				if (existencias + ubi.existencias)=0 then
					DELETE almlinubica  
					WHERE  almlinubica.empresa   = :ubi.empresa 
					AND    almlinubica.ubicacion = :ubi.ubicacion 
					and    almlinubica.linea     = :cur_linea;
	            IF SQLCA.SQLCode<>0 THEN bien=1
				ELSE
					UPDATE almlinubica  
					SET    almlinubica.existencias = almlinubica.existencias + :ubi.existencias
					WHERE  almlinubica.empresa   = :ubi.empresa 
					AND    almlinubica.ubicacion = :ubi.ubicacion 
					and    almlinubica.linea     = :cur_linea;
					IF SQLCA.SQLCode<>0 THEN bien=1
		      End if	  
   		else
				MessageBox("Error en proceso","Modificando almlinubica",Exclamation!, OK!,1)
				bien=1
		   End if
		ELSE
		  	SELECT  max(almlinubica.linea)  INTO :cur_linea FROM almlinubica  
         WHERE   almlinubica.empresa   = :ubi.empresa 
	      AND     almlinubica.ubicacion = :ubi.ubicacion;
			
			IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
			 cur_linea = 0 
			END IF
			cur_linea       = cur_linea+1
			ubi.linea       = cur_linea
			SetNull(ubi.observaciones)
			ubi.existencias = l.cantidad
			ubi.pedido      = l.pedido
			ubi.anyo        = l.anyo
			ubi.linped      = l.linea
			ubi.cliente     = l.cliente

			IF NOT f_insert_almlinubica(ubi) Then  bien=1
	End if

// el contador incrementa uno para cada linea
     contador_orden = contador_orden + 1
 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_almmovhis(mov) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF NOT f_actualiza_nummov(mov.empresa,Year(Today()),mov.nummov) THEN
      bien=1
   END IF
   IF NOT f_actualiza_numorden(ubihis.empresa,Year(Today()),ubihis.orden) THEN
      bien=1
   END IF

  CHOOSE CASE bien
	CASE 1
		Return FALSE
	CASE ELSE
	   Return TRUE
  END CHOOSE



end function

event close;call super::close;dw_detalle.reset()

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;IF d= 1 Then
	f_pagina_arriba(dw_detalle)
ELSE
	f_pagina_arriba(dw_detalle2)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;IF d= 1 Then
	f_cursor_arriba(dw_detalle)
ELSE
	f_cursor_arriba(dw_detalle2)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF d= 1 Then
	f_pagina_abajo(dw_detalle)
ELSE
	f_pagina_abajo(dw_detalle2)
END IF
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Anulacion de albaranes Volcados"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle2.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on w_anulacion_albaranes_volcados.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.cb_continuar=create cb_continuar
this.dw_detalle=create dw_detalle
this.cb_marcar=create cb_marcar
this.dw_detalle2=create dw_detalle2
this.cb_procesar=create cb_procesar
this.cb_desmarcar=create cb_desmarcar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.uo_cliente
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_continuar
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.cb_marcar
this.Control[iCurrent+8]=this.dw_detalle2
this.Control[iCurrent+9]=this.cb_procesar
this.Control[iCurrent+10]=this.cb_desmarcar
end on

on w_anulacion_albaranes_volcados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cb_continuar)
destroy(this.dw_detalle)
destroy(this.cb_marcar)
destroy(this.dw_detalle2)
destroy(this.cb_procesar)
destroy(this.cb_desmarcar)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;IF d= 1 Then
	f_cursor_abajo(dw_detalle)
ELSE
	f_cursor_abajo(dw_detalle2)
END IF
end event

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_anulacion_albaranes_volcados
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_anulacion_albaranes_volcados
end type

type st_empresa from w_int_con_empresa`st_empresa within w_anulacion_albaranes_volcados
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_anulacion_albaranes_volcados
integer x = 2720
integer y = 4
integer width = 114
integer height = 104
integer taborder = 0
end type

type st_2 from statictext within w_anulacion_albaranes_volcados
integer x = 18
integer y = 152
integer width = 238
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

type uo_cliente from u_em_campo_2 within w_anulacion_albaranes_volcados
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 152
integer width = 1435
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_detalle.reset()
dw_detalle2.reset()
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
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

type gb_1 from groupbox within w_anulacion_albaranes_volcados
integer x = 9
integer y = 104
integer width = 2103
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_continuar from commandbutton within w_anulacion_albaranes_volcados
integer x = 1719
integer y = 152
integer width = 379
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type dw_detalle from u_datawindow_consultas within w_anulacion_albaranes_volcados
integer x = 5
integer y = 260
integer width = 1257
integer height = 1160
integer taborder = 0
string dataobject = "dw_anulacion_albaranes_volcados"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;d = 1
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"venalb2_anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"venalb2_albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

event rowfocuschanged;call super::rowfocuschanged;f_detalle(currentrow)
end event

event retrieveend;call super::retrieveend;IF rowcount = 1 Then f_detalle(1)
end event

type cb_marcar from commandbutton within w_anulacion_albaranes_volcados
event clicked pbm_bnclicked
integer x = 1266
integer y = 1344
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Procesar"
end type

event clicked;
if MessageBox("! A v i s o ¡","Este proceso pasa las lineas seleccionadas a pedido y borra el albaran, ¿Desea continuar?",Exclamation!, YesNo!,1)=1 then  f_anular()
end event

type dw_detalle2 from u_datawindow_consultas within w_anulacion_albaranes_volcados
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
integer x = 1262
integer y = 260
integer width = 1568
integer height = 1084
integer taborder = 0
string dataobject = "dw_anulacion_albaranes_volcados2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;d = 2
end event

type cb_procesar from commandbutton within w_anulacion_albaranes_volcados
integer x = 2121
integer y = 1344
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Marcar todo"
end type

event clicked;if dw_detalle2.RowCount()<>0 then
	int Xx
	for Xx=1 to dw_detalle2.RowCount()
		dw_detalle2.SetItem(Xx,"cmarca",'S')
	next
End if
end event

type cb_desmarcar from commandbutton within w_anulacion_albaranes_volcados
event clicked pbm_bnclicked
integer x = 2478
integer y = 1344
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Desmarcar"
end type

event clicked;if dw_detalle2.RowCount()<>0 then
	int Xx
	for Xx=1 to dw_detalle2.RowCount()
		dw_detalle2.SetItem(Xx,"cmarca",'N')
	next
End if
end event

