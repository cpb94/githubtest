$PBExportHeader$w_pase_albaranes_deposito.srw
forward
global type w_pase_albaranes_deposito from w_int_con_empresa
end type
type pb_1 from upb_salir within w_pase_albaranes_deposito
end type
type st_2 from statictext within w_pase_albaranes_deposito
end type
type dw_detalle from datawindow within w_pase_albaranes_deposito
end type
type uo_cliente from u_em_campo_2 within w_pase_albaranes_deposito
end type
type gb_1 from groupbox within w_pase_albaranes_deposito
end type
type cb_1 from commandbutton within w_pase_albaranes_deposito
end type
type rb_deposito from radiobutton within w_pase_albaranes_deposito
end type
type rb_2 from radiobutton within w_pase_albaranes_deposito
end type
type st_1 from statictext within w_pase_albaranes_deposito
end type
type em_albaran from editmask within w_pase_albaranes_deposito
end type
type dw_albaranes from datawindow within w_pase_albaranes_deposito
end type
end forward

global type w_pase_albaranes_deposito from w_int_con_empresa
integer width = 2898
integer height = 1660
pb_1 pb_1
st_2 st_2
dw_detalle dw_detalle
uo_cliente uo_cliente
gb_1 gb_1
cb_1 cb_1
rb_deposito rb_deposito
rb_2 rb_2
st_1 st_1
em_albaran em_albaran
dw_albaranes dw_albaranes
end type
global w_pase_albaranes_deposito w_pase_albaranes_deposito

type variables
Dec periodo,albaran

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_calculo (integer cod, integer linea)
public subroutine f_calcula_bruto_linea (integer cod, integer linea)
public subroutine f_procesar ()
public function boolean f_entrada_albaran (decimal var_anyo, decimal var_albaran, decimal var_linea)
public function boolean f_salida_albaran (decimal var_anyo, decimal var_albaran, decimal var_linea)
end prototypes

public subroutine f_control ();String deposito= "N"
If rb_deposito.checked  Then deposito = "S"
dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,deposito)
f_activar_campo(uo_cliente.em_campo)

end subroutine

public subroutine f_calculo (integer cod, integer linea);//dec{2} pallets,cajas,metros,unidades,kilos
//dec{2} total_pallets,total_cajas,total_metros,total_unidades,total_kilos
//string tipo
// unidades = 0
// metros = 0
// pallets = dw_detalle.GetItemNumber(linea,"pallets")
// cajas    =dw_detalle.GetItemNumber(linea,"cajas")
// Kilos    =dw_detalle.GetItemNumber(linea,"peso")
// tipo  =dw_detalle.GetItemString(linea,"tipo_unidad")
// If tipo = "1" then
//   metros  =dw_detalle.GetItemNumber(linea,"cantidad")
// Else
//   unidades =dw_detalle.GetItemNumber(linea,"cantidad")
// End if
//
// total_pallets  = Dec(em_pallets.text)
// total_cajas    = Dec(em_cajas.text)
// total_metros   = Dec(em_metros.text)
// total_unidades = Dec(em_unidades.text)
// total_kilos = Dec(em_kilos.text)
// If IsNull(total_pallets) Then total_pallets =0
// If IsNull(total_cajas) Then total_cajas =0
// If IsNull(total_metros) Then total_metros =0
// If IsNull(total_unidades) Then total_unidades =0
// If IsNull(total_kilos) Then total_kilos =0
//
// If IsNull(pallets)  Then pallets =0
// If IsNull(cajas)    Then cajas =0
// If IsNull(metros)   Then metros =0
// If IsNull(unidades) Then unidades =0
// If IsNull(kilos)    Then kilos =0
//
// IF cod =1 Then
//    total_pallets  = total_pallets + pallets   
//    total_cajas    = total_cajas + cajas   
//    total_metros   = total_metros + metros  
//    total_unidades = total_unidades + unidades   
//    total_kilos    = total_kilos + kilos   
//  END IF
// IF cod =2 Then
//    total_pallets  = total_pallets - pallets   
//    total_cajas    = total_cajas - cajas   
//    total_metros   = total_metros - metros  
//    total_unidades = total_unidades - unidades   
//    total_kilos    = total_kilos - kilos   
// END IF
//
//em_pallets.text  = String(total_pallets)  
//em_cajas.text    = String(total_cajas)
//em_metros.text   = String(total_metros)
//em_unidades.text = String(total_unidades)
//em_kilos.text    = String(total_kilos)
end subroutine

public subroutine f_calcula_bruto_linea (integer cod, integer linea);//integer claveiva,periodo
//String tipoiva
//dec{2} importedto,importe,bruto,total_iva
//dec{2} total_bruto,total_base,total_dto
//
//importe    = dw_detalle.GetItemNumber(linea,"importe")
//importedto = dw_detalle.GetItemNumber(linea,"importedto")
//tipoiva    = dw_detalle.GetItemString(linea,"tipoiva")
//
//bruto = importe + importedto
//
//periodo  = f_ejercicio_activo(codigo_empresa)
//claveiva = f_iva_contaiva(periodo,codigo_empresa,tipoiva)
//
//total_bruto = dec(em_totalbruto.text)
//total_base  = dec(em_totalbase.text)
//total_dto   = dec(em_totaldto.text)
//
//If IsNull(total_bruto) Then total_bruto = 0
//If IsNull(total_base) Then  total_base  = 0
//If IsNull(total_dto) Then   total_dto   = 0
//
//if cod=1 then
//     total_bruto = total_bruto + (importe+importedto)
//     total_base  = total_base  + importe
//     total_dto   = total_dto   + importedto
// else
//     total_bruto = total_bruto - (importe+importedto)
//     total_base  = total_base  - importe
//     total_dto   = total_dto   - importedto
//end if
//
//em_totalbruto.text  = String(total_bruto)  
//em_totaldto.text    = String(total_dto)
//em_totalbase.text   = String(total_base)
//
//IF total_base=0 or claveiva=0 then 
//   total_iva=0
// else
//   total_iva = (total_base * claveiva) /100
//End IF
//
//em_totaliva.text     = string(total_iva)
//em_totalgeneral.text = string(total_base+total_iva)
//
//return
end subroutine

public subroutine f_procesar ();Dec f1,e_linea,linea,bien = 0
Dec var_albaran,numero,var_albaran1,var_albaran2,var_ejercicio,e_anyo,e_albaran,nu
var_ejercicio = f_ejercicio_activo(codigo_empresa)
str_venalb   alb
str_venlialb linalb
alb.cliente = uo_cliente.em_codigo.text

alb.empresa = codigo_empresa
var_albaran = albaran
alb.albaran = var_albaran
alb.anyo    = periodo
IF Trim(em_albaran.text)<> "" Then

	IF	MessageBox("Proceso volcado albaran","¿Desea Acumular Sobre el albaran?  "+ em_albaran.text,Question!,YesNo!)= 2 Then
		em_albaran.text = ""
		Return
	END IF
ELSE
	periodo = Year(Today())
END IF



IF Trim(em_albaran.text)= "" Then
	SELECT venparamalb.albaran   INTO :var_albaran  FROM venparamalb  
				WHERE venparamalb.empresa = :codigo_empresa  
				And   venparamalb.anyo    = :periodo;
				If Sqlca.Sqlcode=100 Then
					 INSERT INTO venparamalb (empresa,anyo,albaran)  
					 VALUES (:codigo_empresa,:periodo,0);
				END IF
				IF IsNull(var_albaran) Then var_albaran=0
				var_albaran=var_albaran + 1
				Select  count(*) Into :numero From venalb
				Where   venalb.empresa    = :codigo_empresa
				And     venalb.anyo       = :periodo
				And     venalb.albaran    = :var_albaran;
				If IsNull(numero) Then numero=0
				IF numero = 0 Then
					Select  count(*) Into :numero From venfac
					  Where    venfac.empresa   = :codigo_empresa
						And     venfac.anyo_albaran       = :periodo
						And     venfac.albaran   = :var_albaran;
						If IsNull(numero) Then numero=0
				END IF
				If numero<>0 Then
					Select Max(venalb.albaran)  Into :var_albaran1 From venalb
					Where  venalb.empresa = :codigo_empresa
					And    venalb.anyo    = :periodo
					And    venalb.albaran = :var_albaran;
					IF IsNull(var_albaran1) Then var_albaran1 = 0
					Select Max(venfac.albaran)  Into :var_albaran2 From venfac
					Where  venfac.empresa         = :codigo_empresa
					And    venfac.anyo_albaran    = :periodo
					And    venfac.albaran    = :var_albaran;
					IF IsNull(var_albaran2) Then var_albaran2 = 0
					var_albaran = var_albaran1
					IF var_albaran2 > var_albaran Then var_albaran = var_albaran2
					var_albaran = var_albaran + 1
				End If
				
				UPDATE venparamalb
				SET    albaran = :var_albaran
				WHERE  venparamalb.empresa = :codigo_empresa
				And    venparamalb.anyo    = :periodo;
			alb.empresa = codigo_empresa
			alb.anyo    = periodo
			alb.albaran = var_albaran
			
   SELECT venclientes.zona,venclientes.serie,venclientes.agente1,   
                      venclientes.agente2,venclientes.agente3,venclientes.comision1, venclientes.comision2,   venclientes.comision31,
                      venclientes.cod_pago,venclientes.dtopp,venclientes.dtoesp1,   
                      venclientes.dtoesp2, venclientes.tipoiva,
						    venclientes.forma_envio, venclientes.tipo_portes,   
							 venclientes.cod_entrega, venclientes.periodo_fac,   
							 venclientes.explicaciondto1, venclientes.explicaciondto2,   
							 venclientes.tarifa,   
							 venclientes.comision11,      venclientes.comision22,   venclientes.comision31, 
							 venclientes.dtoesp3,         venclientes.dtoesp4,   
							 venclientes.explicaciondto3, venclientes.explicaciondto4,   
							 venclientes.tipodto1,        venclientes.tipodto2,   
							 venclientes.tipodto3,        venclientes.tipodto4,   
							 venclientes.empresa,         venclientes.codigo  ,
							 venclientes.cod_entrega,     venclientes.calculo_dto  ,
							 venclientes.banco_de_cobro,  venclientes.envio,
							 venclientes.correspondencia,venclientes.domiciliacion,venclientes.transportista,
							 venclientes.deposito,venclientes.agrupa
					INTO   :alb.zona, :alb.serie, :alb.agente1, :alb.agente2,:alb.agente3,:alb.comision1,   
                      :alb.comision2,:alb.comision31,:alb.codpago,:alb.dtopp,:alb.dtoesp1,
						    :alb.dtoesp2,:alb.tipoiva, :alb.forma_envio,   
						    :alb.tipo_portes,:alb.cod_entrega,:alb.periodo_fac,
						    :alb.explicaciondto1,:alb.explicaciondto2,   
						    :alb.tarifa,:alb.comision11,:alb.comision22,:alb.comision31,:alb.dtoesp3,   
					       :alb.dtoesp4,:alb.explicaciondto3,:alb.explicaciondto4,
						    :alb.tipodto1,:alb.tipodto2,:alb.tipodto3,:alb.tipodto4,   
						    :alb.empresa,:alb.cliente ,:alb.cod_entrega,
							 :alb.calculo_dto,:alb.banco_de_cobro,
							 :alb.envio,:alb.correspondencia,
							 :alb.domiciliacion,:alb.transportista,
							 :alb.deposito,:alb.agrupa
					FROM   venclientes  
               WHERE  ( venclientes.empresa = :codigo_empresa ) AND  
                      ( venclientes.codigo = :alb.cliente )   ;

					
               Select  genter.idioma,genter.moneda
               Into    :alb.idioma,:alb.divisa
               From genter
               Where   genter.empresa = :codigo_empresa 
               And     genter.tipoter = 'C'
               And     genter.codigo  = :alb.cliente;

   	  
					SELECT contaiva.iva  INTO :alb.iva  
					FROM contaiva  
					WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
					   	( contaiva.empresa = :codigo_empresa ) AND  
							( contaiva.tipoiva = :alb.tipoiva )   ;
					alb.falbaran = DateTime(Today())
					alb.flistado = DateTime(Today(),Now())
					alb.veces = 1
					alb.falta = DateTime(Today(),Now())
					alb.fcarga   = DateTime(Today())
					IF rb_deposito.checked Then
						alb.deposito = "N"
					ELSE
						alb.deposito = "S"
						alb.almacen_deposito  = f_depalmacen_cliente(codigo_empresa,alb.cliente)
					END IF
					alb.abono = "N"
					alb.observaciones = ""
					IF Not f_insertar_venalb(alb)		  Then
						f_mensaje("Error","insertar venalb")
						bien = 1
					END IF
ELSE
Select falbaran Into :alb.falbaran From venalb
Where  venalb.empresa = :codigo_empresa
And    venalb.anyo    = :alb.anyo
And    venalb.albaran = :alb.albaran;
END IF



Select Max(linea) Into :linea From venlialb
Where  venlialb.empresa = :codigo_empresa
And    venlialb.anyo    = :alb.anyo
And    venlialb.albaran = :alb.albaran;

IF IsNull(linea) Then linea = 0 
linalb.linea = linea
For f1 = 1 To dw_detalle.RowCount()
	linalb.linea = linalb.linea +1
	e_linea = dw_detalle.GetItemNumber(f1,"linea")
	IF dw_detalle.GetItemString(f1,"cmarca")= "X" Then
			e_anyo    = dw_detalle.GetItemNumber(f1,"anyo")
			e_albaran = dw_detalle.GetItemNumber(f1,"albaran")
			SELECT venlialb.serie,   
         venlialb.falbaran,   
         venlialb.fentrega,   
         venlialb.cliente,   
         venlialb.tipo_unidad,   
         venlialb.articulo,   
         venlialb.familia,   
         venlialb.formato,   
         venlialb.modelo,   
         venlialb.calidad,   
         venlialb.tono,   
         venlialb.calibre,   
         venlialb.precio,   
         venlialb.precio_estand,   
         venlialb.cantidad,   
         venlialb.pallets,   
         venlialb.total_cajas,   
         venlialb.cajas,   
         venlialb.dtocomer,   
         venlialb.dtoesp,   
         venlialb.descripcion,   
         venlialb.tipoiva,   
         venlialb.iva,   
         venlialb.linfab,   
         venlialb.provincia,   
         venlialb.pais,   
         venlialb.zona,   
         venlialb.tipolinea,   
         venlialb.texto1,   
         venlialb.texto2,   
         venlialb.texto3,   
         venlialb.texto4,   
         venlialb.referencia,   
         venlialb.montajeartcal,   
         venlialb.situacion,   
         venlialb.divisa,   
         venlialb.metros_lineales,   
         venlialb.peso,   
         venlialb.falta,   
         venlialb.usuario,   
         venlialb.tipo_pallet,   
         venlialb.importe,   
         venlialb.descuento,   
         venlialb.importedto,   
         venlialb.clase,   
         venlialb.sector,   
         venlialb.agente1,   
         venlialb.agente2,   
         venlialb.agente3,   
         venlialb.comision11,   
         venlialb.comision12,   
         venlialb.comision21,   
         venlialb.comision22,   
         venlialb.comision31,   
         venlialb.comision32,   
         venlialb.deposito,   
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
         venlialb.control_incremento,   
         venlialb.peso_neto,   
         venlialb.precio_aduana,   
         venlialb.control_descuentos,   
         venlialb.control_comisiones,   
         venlialb.importe_aduana,   
         venlialb.bruto,   
         venlialb.precio_neto,   
         venlialb.precio_aduana_neto,   
         venlialb.descuento_aduana,   
         venlialb.neto,   
         venlialb.impdtopp,   
         venlialb.ref_cli,   
         venlialb.transportista,   
         venlialb.almacen_ent,   
         venlialb.anyo_pedido_origen,   
         venlialb.pedido_origen,   
         venlialb.fcarga,   
         venlialb.almacen_deposito,   
         venlialb.ubicacion,   
         venlialb.envio  
    INTO :linalb.serie,   
         :linalb.falbaran,   
         :linalb.fentrega,   
         :linalb.cliente,   
         :linalb.tipo_unidad,   
         :linalb.articulo,   
         :linalb.familia,   
         :linalb.formato,   
         :linalb.modelo,   
         :linalb.calidad,   
         :linalb.tono,   
         :linalb.calibre,   
         :linalb.precio,   
         :linalb.precio_estand,   
         :linalb.cantidad,   
         :linalb.pallets,   
         :linalb.total_cajas,   
         :linalb.cajas,   
         :linalb.dtocomer,   
         :linalb.dtoesp,   
         :linalb.descripcion,   
         :linalb.tipoiva,   
         :linalb.iva,   
         :linalb.linfab,   
         :linalb.provincia,   
         :linalb.pais,   
         :linalb.zona,   
         :linalb.tipolinea,   
         :linalb.texto1,   
         :linalb.texto2,   
         :linalb.texto3,   
         :linalb.texto4,   
         :linalb.referencia,   
         :linalb.montajeartcal,   
         :linalb.situacion,   
         :linalb.divisa,   
         :linalb.metros_lineales,   
         :linalb.peso,   
         :linalb.falta,   
         :linalb.usuario,   
         :linalb.tipo_pallet,   
         :linalb.importe,   
         :linalb.descuento,   
         :linalb.importedto,   
         :linalb.clase,   
         :linalb.sector,   
         :linalb.agente1,   
         :linalb.agente2,   
         :linalb.agente3,   
         :linalb.comision11,   
         :linalb.comision12,   
         :linalb.comision21,   
         :linalb.comision22,   
         :linalb.comision31,   
         :linalb.comision32,   
         :linalb.deposito,   
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
         :linalb.control_incremento,   
         :linalb.peso_neto,   
         :linalb.precio_aduana,   
         :linalb.control_descuentos,   
         :linalb.control_comisiones,   
         :linalb.importe_aduana,   
         :linalb.bruto,   
         :linalb.precio_neto,   
         :linalb.precio_aduana_neto,   
         :linalb.descuento_aduana,   
         :linalb.neto,   
         :linalb.impdtopp,   
         :linalb.ref_cli,   
         :linalb.transportista,   
         :linalb.almacen_ent,   
         :linalb.anyo_pedido_origen,   
         :linalb.pedido_origen,   
         :linalb.fcarga,   
         :linalb.almacen_deposito,   
         :linalb.ubicacion,   
         :linalb.envio  
         FROM venlialb
			Where  venlialb.empresa = :codigo_empresa
			And    venlialb.anyo    = :e_anyo
			And    venlialb.albaran = :e_albaran
			And    venlialb.linea   = :e_linea;
			IF sqlca.sqlcode <> 0 Then 
				bien = 1
				f_mensaje("Error",sqlca.sqlerrtext)
			END IF
			linalb.empresa          = alb.empresa
			linalb.anyo             = alb.anyo
			linalb.albaran          = alb.albaran
			linalb.deposito         = alb.deposito
			linalb.almacen_deposito = alb.almacen_deposito
			linalb.falbaran         = alb.falbaran
			IF rb_deposito.checked Then
						linalb.deposito = "N"
						linalb.almacen_deposito  =""
					ELSE
						linalb.deposito = "S"
						linalb.almacen_deposito  = f_depalmacen_cliente(codigo_empresa,alb.cliente)
				END IF

			IF Not f_insertar_venlialb(linalb) Then
				bien = 1
				f_mensaje("Error",sqlca.sqlerrtext)
			END IF
			IF Not f_actualizar_linea_venalbaran(codigo_empresa,linalb.anyo,linalb.albaran,linalb.linea) Then
				bien = 1
				f_mensaje("Error actualizando linea albaran"+ String(linalb.anyo)+"/"+String(linalb.albaran),sqlca.sqlerrtext)
			END IF
			IF rb_deposito.checked Then
				IF Not f_salida_albaran(e_anyo,e_albaran,e_linea) Then  
					bien = 1
					f_mensaje("Salida almacen",sqlca.sqlerrtext)
				END IF
			ELSE
				IF Not f_entrada_albaran(alb.anyo,alb.albaran,linalb.linea) Then  
					bien = 1
					f_mensaje("Entrada almacen",sqlca.sqlerrtext)
				END IF
			END IF
			Delete from venlialb
			Where  venlialb.empresa = :codigo_empresa
			And    venlialb.anyo    = :e_anyo
			And    venlialb.albaran = :e_albaran
			And    venlialb.linea   = :e_linea;
			IF sqlca.sqlcode <> 0 Then 
				f_mensaje("Error",sqlca.sqlerrtext)
				bien = 1
			END IF
	END IF
Next
Select Count(*) Into :nu From venlialb
Where  empresa  = :codigo_empresa
And    anyo     = :e_anyo
And    albaran  = :e_albaran;
iF IsNull(nu) Then nu = 0
IF nu =  0 Then
		Delete From venalb
		Where  venalb.empresa  = :codigo_empresa
		And    venalb.anyo     = :e_anyo
		And    venalb.albaran  = :e_albaran;
Else
		IF Not f_actualizar_venalbaran(codigo_empresa,e_anyo,e_albaran) Then 
			bien = 1
			f_mensaje("Error","actualizar1 venalb")
		End If
End If
IF Not f_actualizar_venalbaran(codigo_empresa,alb.anyo,alb.albaran) Then 
	bien = 1
	f_mensaje("Error","actualizar1 venalb")
END IF
IF bien = 0 Then
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("error en fproceso",sqlca.sqlerrtext)
END IF
em_albaran.text = ""
f_control()
end subroutine

public function boolean f_entrada_albaran (decimal var_anyo, decimal var_albaran, decimal var_linea);Integer vbien = 0
String almacen,referencia,articulo,tipo_pallet,calidad,cliente
Int anyo
Dec cantidad
Str_deplinubica  ubi
Str_depmovhis    mov
Select  referencia,articulo,calidad,tipo_pallet,cantidad,almacen_deposito,cliente
Into    :referencia,:articulo,:calidad,:tipo_pallet,:cantidad,:almacen,:cliente
From   venlialb
Where  empresa   = :codigo_empresa
And    anyo      = :var_anyo
And    albaran   = :var_albaran
And    linea     = :var_linea;
IF SQLCA.SQLCODE = 100 Then
	f_mensaje("Error","Fallo integridad albaran"+String(var_albaran)+"/"+string(var_linea))
	vbien = 1
END IF
cantidad = cantidad  

 string codigo_articulo
 String codigo_calidad
 codigo_articulo = articulo
 codigo_calidad  = calidad
 ubi.empresa       = codigo_empresa
 mov.anyo          = year(Today())
 mov.usuario       = nombre_usuario
 ubi.almacen       = almacen
 ubi.articulo      = f_articulo_referencia(referencia)
 ubi.calidad       = f_calidad_referencia(referencia)
 ubi.tonochar      = Trim(f_tono_referencia(referencia))
 ubi.calibre       = Integer(f_calibre_referencia(referencia))
 mov.fechmov       = DateTime(Today())
 mov.f_alta        = Datetime(today(),now())
 mov.observaciones = ""
 mov.tipomov       = "1"
 ubi.tipo_pallet   = tipo_pallet
 mov.numdoc        = String(var_albaran,"##########")
 SELECT  articulos.familia,articulos.formato,articulos.modelo,
         articulos.unidad  
    INTO :ubi.familia,:ubi.formato,:ubi.modelo, :ubi.tipo_unidad  
    FROM articulos  
   WHERE articulos.empresa = :ubi.empresa 
	AND   articulos.codigo  = :ubi.articulo;
  IF SQLCA.SQLCode<>0 THEN 
	vbien=1
	f_mensaje("Seleccon articulo",sqlca.sqlerrtext)
	END IF
  
ubi.referencia   = f_componer_ref(ubi.articulo,ubi.calidad,ubi.tonochar,ubi.calibre)
ubi.cliente      = cliente
ubi.f_alta       =  DateTime(today(),now())
mov.cantidads = 0
mov.cantidade = cantidad
ubi.existencias      = cantidad 
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.codtercero       = cliente
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist=0      
mov.familia        = ubi.familia
mov.formato        = ubi.formato
mov.modelo         = ubi.modelo
mov.calidad        = ubi.calidad
mov.tonochar       = ubi.tonochar
mov.calibre        = ubi.calibre
mov.tipo_unidad    = ubi.tipo_unidad
mov.tipo_pallet    = ubi.tipo_pallet
mov.referencia     = ubi.referencia
mov.f_alta         = DateTime(today(),now())
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
	 And    deplinubica.tipo_pallet = :ubi.tipo_pallet;
	 IF SQLCA.SQLCODE = 0 Then
			Update deplinubica
				Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :almacen 
				And    deplinubica.referencia  = :ubi.referencia
 			   And    deplinubica.tipo_pallet = :ubi.tipo_pallet;
				 IF SQLCA.SQLCODE <> 0 Then
					vbien = 1
					f_mensaje("Salida albaran",sqlca.sqlerrtext)
				 END IF
		ELSE
				Select  max(deplinubica.linea) Into :ubi.linea from deplinubica
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :almacen;
				IF IsNUll(ubi.linea) Then ubi.linea = 0
				ubi.linea = ubi.linea +1
			 IF Not f_insert_deplinubica(ubi) Then
				vbien = 1
			 	f_mensaje("Salida albaran",sqlca.sqlerrtext)
				END IF
   END IF

// Grabo el movimiento en el historico
  IF NOT f_insert_depmovhis(mov) Then vbien=1
  IF NOT f_actualiza_depnummov(codigo_empresa,Year(Today()),mov.nummov) THEN
     vbien=1
  END IF
IF vbien = 0  Then
	Return True
Else
	Return False
End IF
end function

public function boolean f_salida_albaran (decimal var_anyo, decimal var_albaran, decimal var_linea);Integer vbien = 0
Int anyo
Str_deplinubica  ubi
Str_depmovhis    mov
String  referencia,articulo,calidad,tipo_pallet,almacen,cliente
Dec     cantidad

Select  cliente,referencia,articulo,calidad,tipo_pallet,cantidad,almacen_deposito,cliente,tonochar,calibre
Into    :cliente,:referencia,:articulo,:calidad,:tipo_pallet,:cantidad,:almacen,:cliente,:ubi.tonochar,:ubi.calibre
From   venlialb
Where  empresa   = :codigo_empresa
And    anyo      = :var_anyo
And    albaran   = :var_albaran
And    linea     = :var_linea;
IF SQLCA.SQLCODE = 100 Then
	f_mensaje("Error","No existe la linea de alabaran")
	vbien = 1
END IF

 string codigo_articulo
 String codigo_calidad
 codigo_articulo = articulo
 codigo_calidad  = calidad
 ubi.empresa       = codigo_empresa
 mov.anyo          = year(Today())
 mov.usuario       = nombre_usuario
 ubi.almacen       = almacen
 ubi.articulo      = f_articulo_referencia(referencia)
 ubi.calidad       = f_calidad_referencia(referencia)
 mov.fechmov       = DateTime(Today())
 mov.f_alta        = Datetime(today(),now())
 mov.observaciones = ""
 mov.tipomov       = "1"
 ubi.tipo_pallet   = tipo_pallet
 mov.numdoc        = STring(var_albaran,"########")
 
 SELECT  articulos.familia,articulos.formato,articulos.modelo,
         articulos.unidad  
    INTO :ubi.familia,:ubi.formato,:ubi.modelo, :ubi.tipo_unidad  
    FROM articulos  
   WHERE articulos.empresa = :ubi.empresa 
	AND   articulos.codigo  = :ubi.articulo;

         IF SQLCA.SQLCode<>0 THEN vbien=1
 ubi.referencia   = f_componer_ref(ubi.articulo,&
                                   ubi.calidad,ubi.tonochar,&
                                   ubi.calibre)

ubi.cliente = cliente
ubi.f_alta       =  DateTime(today(),now())
mov.cantidads = cantidad
mov.cantidade = 0
ubi.existencias      = mov.cantidads
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.cantidade        = 0
mov.codtercero       = cliente
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist=0      
mov.familia        = ubi.familia
mov.formato        = ubi.formato
mov.modelo         = ubi.modelo
mov.calidad        = ubi.calidad
mov.tonochar       = ubi.tonochar
mov.calibre        = ubi.calibre
mov.tipo_unidad    = ubi.tipo_unidad
mov.tipo_pallet    = ubi.tipo_pallet
mov.referencia     = ubi.referencia
mov.f_alta         = DateTime(today(),now())
mov.nummov  = f_depparam_nummov(codigo_empresa,Year(Today()))
  // Variables para cargar el cursor

      integer cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen
      decimal{4}  cur_existencias





	 Select deplinubica.existencias Into :cur_existencias From deplinubica
	 Where  deplinubica.empresa     = :codigo_empresa
	 And    deplinubica.almacen     = :almacen 
	 And    deplinubica.referencia  = :ubi.referencia
	 And    deplinubica.tipo_pallet = :ubi.tipo_pallet;
	 IF SQLCA.SQLCODE = 0 Then
		IF cur_existencias = mov.cantidads Then
			Delete from deplinubica
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :almacen 
				And    deplinubica.referencia  = :ubi.referencia
				And    deplinubica.tipo_pallet = :ubi.tipo_pallet;
				iF sqlca.sqlcode <> 0 Then vbien = 1
		ELSE
			IF cur_existencias < mov.cantidads Then
				vbien = 1
				f_mensaje("Error", "Falta stock")
			ELSE
				Update deplinubica
				Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :almacen 
				And    deplinubica.referencia  = :ubi.referencia
				And    deplinubica.tipo_pallet = :ubi.tipo_pallet;
				iF sqlca.sqlcode <> 0 Then vbien = 1
			END IF
		END IF
	ELSE
		f_mensaje("Error en proceso","Error al selecionar existencias" )	
		vbien = 1
   END IF

// Grabo el movimiento en el historico
  IF NOT f_insert_depmovhis(mov) Then vbien=1
  IF NOT f_actualiza_depnummov(codigo_empresa,Year(Today()),mov.nummov) THEN
     vbien=1
  END IF

IF vbien = 0  Then

	Return True
Else
		f_mensaje("Error en salida almacen",sqlca.sqlerrtext)
	Return False
End IF
end function

event close;call super::close;dw_detalle.reset()

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de albarán por cliente por deposito"
This.title=istr_parametros.s_titulo_ventana
dw_albaranes.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on w_pase_albaranes_deposito.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.dw_detalle=create dw_detalle
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.cb_1=create cb_1
this.rb_deposito=create rb_deposito
this.rb_2=create rb_2
this.st_1=create st_1
this.em_albaran=create em_albaran
this.dw_albaranes=create dw_albaranes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.rb_deposito
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_albaran
this.Control[iCurrent+11]=this.dw_albaranes
end on

on w_pase_albaranes_deposito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.dw_detalle)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.rb_deposito)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.em_albaran)
destroy(this.dw_albaranes)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_pase_albaranes_deposito
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_pase_albaranes_deposito
end type

type st_empresa from w_int_con_empresa`st_empresa within w_pase_albaranes_deposito
integer x = 9
integer width = 2427
end type

type pb_1 from upb_salir within w_pase_albaranes_deposito
integer x = 2715
integer width = 105
integer height = 96
integer taborder = 0
end type

type st_2 from statictext within w_pase_albaranes_deposito
integer x = 18
integer y = 124
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

type dw_detalle from datawindow within w_pase_albaranes_deposito
integer x = 5
integer y = 320
integer width = 2830
integer height = 1104
string dataobject = "dw_pase_albaranes_deposito"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(dw_detalle) = "cmarca"Then
	IF dw_detalle.GetItemString(row,"cmarca")= "" Then
		dw_detalle.SetItem(row,"cmarca","X")
	ELSE
		dw_detalle.SetItem(row,"cmarca","")
	END IF
END IF
IF f_objeto_datawindow(dw_detalle) = "procesar"Then
	f_procesar()
END IF
end event

type uo_cliente from u_em_campo_2 within w_pase_albaranes_deposito
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 120
integer width = 2135
integer taborder = 10
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

type gb_1 from groupbox within w_pase_albaranes_deposito
integer y = 72
integer width = 2816
integer height = 240
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_pase_albaranes_deposito
integer x = 2427
integer y = 120
integer width = 379
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type rb_deposito from radiobutton within w_pase_albaranes_deposito
integer x = 82
integer y = 216
integer width = 754
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Deposito a No Deposito"
boolean checked = true
end type

event clicked;dw_detalle.Reset()
dw_albaranes.Reset()
dw_albaranes.Visible = FALSE
em_albaran.text = ""

end event

type rb_2 from radiobutton within w_pase_albaranes_deposito
integer x = 937
integer y = 216
integer width = 754
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "No Deposito a Deposito"
end type

event clicked;dw_detalle.Reset()
dw_albaranes.Reset()
dw_albaranes.Visible = FALSE
em_albaran.text = ""
end event

type st_1 from statictext within w_pase_albaranes_deposito
integer x = 1906
integer y = 216
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 8388608
long backcolor = 67108864
string text = "Albaran:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;String deposito= "S"
If rb_deposito.checked  Then deposito = "N"
dw_albaranes.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,deposito)
dw_albaranes.visible = TRUE
f_activar_campo(uo_cliente.em_campo)

end event

type em_albaran from editmask within w_pase_albaranes_deposito
integer x = 2185
integer y = 216
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###"
string displaydata = ""
end type

type dw_albaranes from datawindow within w_pase_albaranes_deposito
boolean visible = false
integer x = 1906
integer y = 296
integer width = 891
integer height = 568
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_pase_albaranes_deposito2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;em_albaran.text = String(dw_albaranes.GetItemNumber(row,"albaran"))
periodo = dw_albaranes.GetItemNumber(row,"anyo")
albaran = dw_albaranes.GetItemNumber(row,"albaran")
visible = FALSE
reset()
end event

event clicked;IF f_objeto_datawindow(dw_albaranes) = "salir" Then
	dw_albaranes.reset()
	dw_albaranes.visible= FALSE
END IF
end event

