$PBExportHeader$w_actualizacion_fac.srw
$PBExportComments$€
forward
global type w_actualizacion_fac from w_int_con_empresa
end type
type em_fechadesde from u_em_campo within w_actualizacion_fac
end type
type gb_3 from groupbox within w_actualizacion_fac
end type
type gb_2 from groupbox within w_actualizacion_fac
end type
type cb_continuar from commandbutton within w_actualizacion_fac
end type
type dw_2 from datawindow within w_actualizacion_fac
end type
type cb_2 from commandbutton within w_actualizacion_fac
end type
type cb_actualizar from commandbutton within w_actualizacion_fac
end type
type pb_1 from upb_salir within w_actualizacion_fac
end type
type em_fecha from u_em_campo within w_actualizacion_fac
end type
type st_11 from statictext within w_actualizacion_fac
end type
type em_asiento from u_em_campo within w_actualizacion_fac
end type
type st_1 from statictext within w_actualizacion_fac
end type
type dw_fac from datawindow within w_actualizacion_fac
end type
type dw_1 from u_datawindow_consultas within w_actualizacion_fac
end type
type em_serie from u_em_campo within w_actualizacion_fac
end type
type st_nombre_serie from statictext within w_actualizacion_fac
end type
type st_22 from statictext within w_actualizacion_fac
end type
type em_fechahasta from u_em_campo within w_actualizacion_fac
end type
type st_2 from statictext within w_actualizacion_fac
end type
type uo_ejercicio from u_ejercicio within w_actualizacion_fac
end type
type cb_cambio from commandbutton within w_actualizacion_fac
end type
type dw_listado from datawindow within w_actualizacion_fac
end type
type dw_proceso from datawindow within w_actualizacion_fac
end type
type dw from datawindow within w_actualizacion_fac
end type
end forward

global type w_actualizacion_fac from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 2885
integer height = 2124
em_fechadesde em_fechadesde
gb_3 gb_3
gb_2 gb_2
cb_continuar cb_continuar
dw_2 dw_2
cb_2 cb_2
cb_actualizar cb_actualizar
pb_1 pb_1
em_fecha em_fecha
st_11 st_11
em_asiento em_asiento
st_1 st_1
dw_fac dw_fac
dw_1 dw_1
em_serie em_serie
st_nombre_serie st_nombre_serie
st_22 st_22
em_fechahasta em_fechahasta
st_2 st_2
uo_ejercicio uo_ejercicio
cb_cambio cb_cambio
dw_listado dw_listado
dw_proceso dw_proceso
dw dw
end type
global w_actualizacion_fac w_actualizacion_fac

type variables
str_venfac  fac
str_contaapun   conta
String  cobrado,tipovta,divisa
dec cambio
end variables

forward prototypes
public function boolean f_grabar_comisiones (integer i)
public function boolean f_grabar_cartera (integer i)
public function boolean f_grabar_apuntes ()
public subroutine f_grabar_apuntes_viejo ()
public function decimal f_dividir_efecto (long anyo, long orden, decimal nuevo_importe, long nuevo_anyo, long nuevo_efecto)
end prototypes

public function boolean f_grabar_comisiones (integer i);Long     n_lineas,j,k
String   c_agente,c_liquidado,c_nacional,c_condicion,c_fletes,c_control_fletes
Dec      c_comision,c_impfrapts
Dec      c_importeliquidado,c_importeliquidar
Dec      c_importeliquidadopts,c_basecomisionpts,c_importeliquidarpts,v_bien
Integer  c_anyo,c_linea,c_n_comision
DateTime c_fliquidacion,c_ffra
String   texto_agente,texto_comision,texto_comision_fija,c_comision_fija         
dec      c_base_comision_pz,c_base_comision_m2,c_comision_pz,c_comision_m2
v_bien=0

//GRABAR LINEAS COMISIONES//
Select Max(carcomisiones.linea)
Into   :c_linea
From   carcomisiones
Where  carcomisiones.empresa = :fac.empresa
And    carcomisiones.anyo    = :fac.anyo
And    carcomisiones.factura = :fac.factura;

IF IsNull(c_linea) Then c_linea = 0
c_impfrapts       = fac.total_fac_pts
if isnull(fac.base_comision_pts) then fac.base_comision_pts = 0
c_basecomisionpts = fac.base_comision_pts 
c_condicion       = dw_1.getitemString(i,"condicion")		
c_fletes          = f_fletes_vencondiciones(codigo_empresa,c_condicion)

IF Trim(c_fletes) = "" or IsNull(c_fletes) Then c_fletes = "N"
IF c_fletes = "N" Then
	c_control_fletes = "S"
ELSE
	c_control_fletes = "N"
END IF

IF c_basecomisionpts <> 0 Then
	for j=1 to 3
		texto_agente        = "agente"+trim(string(j))
		texto_comision_fija = "comision_fija"+trim(string(j))
		c_agente            = dw_1.getitemstring(i,texto_agente)
		c_comision_fija     = dw_1.getitemstring(i,texto_comision_fija)
		if not isnull(c_agente) and Trim(c_agente) <> "0" then
			if c_comision_fija = "S" then
				choose case j
					case 1
						c_importeliquidar     = Dec(String(f_comision_fija_agente1_fra(codigo_empresa,fac.anyo,fac.factura),f_mascara_moneda(divisa)))
						c_comision_m2         = dw_1.getitemnumber(i,"comision11")
						c_comision_pz			 = dw_1.getitemnumber(i,"comision12")						
					case 2
						c_importeliquidar     = Dec(String(f_comision_fija_agente2_fra(codigo_empresa,fac.anyo,fac.factura),f_mascara_moneda(divisa)))						
						c_comision_m2         = dw_1.getitemnumber(i,"comision21")
						c_comision_pz			 = dw_1.getitemnumber(i,"comision22")												
					case 3
						c_importeliquidar     = Dec(String(f_comision_fija_agente3_fra(codigo_empresa,fac.anyo,fac.factura),f_mascara_moneda(divisa)))
						c_comision_m2         = dw_1.getitemnumber(i,"comision31")
						c_comision_pz			 = dw_1.getitemnumber(i,"comision32")												
				end choose
				if c_importeliquidar <> 0 then
					c_linea               = c_linea+1
					setnull(c_fliquidacion)
					c_importeliquidado    = 0
					c_importeliquidadopts = 0
					c_comision            = 0
					c_liquidado           = "N"
					if cambio <> 0 then
						c_importeliquidarpts = Dec(String(c_importeliquidar / cambio,"###,###,##0.00"))					
					else
						v_bien = 1
						messagebox("Error","Factura sin cambio "+string(fac.factura,"###,###,###"))
					end if
					c_n_comision          = k
					c_nacional            = f_nacional_venagentes(codigo_empresa,c_agente)
					c_base_comision_pz    = f_pz_comision_fra(codigo_empresa,fac.anyo,fac.factura)
					c_base_comision_m2    = f_m2_comision_fra(codigo_empresa,fac.anyo,fac.factura)
					INSERT INTO carcomisiones  
									(empresa,				  anyo,
									factura,					  linea,
									agente,					  comision,
									impfra,					  impfrapts,
									cambiofra,				  fliquidacion,
									importeliquidado,		  basecomision,
									importeliquidar,		  liquidado,
									moneda,					  ffra,
									pais,						  cliente,
									n_comision,				  basecomisionpts,
									importeliquidarpts,	  importeliquidadopts,
									serie,					  cobrado,
									nacional,				  baseliqui,
									baseliquipts,			  comisionliqui,
									comisionliquipts,		  fletes,
									gastos_fletes,			  control_fletes,
									cambio_euros,          comision_fija,
									base_comision_pz,      base_comision_m2,
									comision_pz,           comision_m2, 
									fvto)  
					VALUES	  (:codigo_empresa,		  :fac.anyo,
									:fac.factura,			  :c_linea,
									:c_agente,				  :c_comision,
									:fac.total_fac,		  :c_impfrapts,
									:cambio,					  :c_fliquidacion,
									:c_importeliquidado,	  0,
									:c_importeliquidar,	  :c_liquidado,										
									:fac.divisa,			  :fac.ffactura,
									:fac.pais,				  :fac.cliente,
									:c_n_comision,			  0,
									:c_importeliquidarpts, :c_importeliquidadopts,
									:fac.serie,				  :cobrado,
									:c_nacional,			  0,
									0,                 	  :c_importeliquidar,
									:c_importeliquidarpts, :c_fletes,
									0,							  :c_control_fletes,
									:fac.cambio_euros,     "S",
									:c_base_comision_pz,   :c_base_comision_m2,
									:c_comision_pz,        :c_comision_m2,
									:fac.fvto_max);
									
					IF SQLCA.SQLCODE <> 0 Then
						v_bien = 1
						f_mensaje("ERROR EN BASE DE DATOS (f_grabar_comisiones)",SQLCA.SQLERRTEXT)
					END IF
					
				end if
			else
				for k=1 to 2
					texto_comision = "comision"+trim(string(j))+trim(string(k))
					c_comision     = dw_1.getitemnumber(i,texto_comision)
					if not isnull(c_agente) and Trim(c_agente) <> "0" and fac.base_comision_pts <> 0 then
						IF k =1 or(k=2 and c_comision<>0 and Not IsNUll(c_comision)) Then
							c_linea               = c_linea+1
							setnull(c_fliquidacion)
							c_importeliquidado    = 0
							c_importeliquidadopts = 0
							c_liquidado           = "N"
							IF IsNull(c_comision) Then c_comision = 0 
							c_importeliquidar     = Dec(String(fac.base_comision * c_comision / 100,f_mascara_moneda(divisa)))
							c_importeliquidarpts  = Dec(String(fac.base_comision_pts * c_comision / 100,f_mascara_decimales(2)))
							c_n_comision          = k
							c_nacional            = f_nacional_venagentes(codigo_empresa,c_agente)
							
							IF c_importeliquidar<>0 then
								INSERT INTO carcomisiones  
												(empresa,				anyo,
												factura,					linea,
												agente,					comision,
												impfra,					impfrapts,
												cambiofra,				fliquidacion,
												importeliquidado,		basecomision,
												importeliquidar,		liquidado,
												moneda,					ffra,
												pais,						cliente,
												n_comision,				basecomisionpts,
												importeliquidarpts,	importeliquidadopts,
												serie,					cobrado,
												nacional,				baseliqui,
												baseliquipts,			comisionliqui,
												comisionliquipts,		fletes,
												gastos_fletes,			control_fletes,
												cambio_euros,        comision_fija,
												fvto)  
								VALUES	  (:codigo_empresa,		:fac.anyo,
												:fac.factura,			:c_linea,
												:c_agente,				:c_comision,
												:fac.total_fac,		:c_impfrapts,
												:cambio,					:c_fliquidacion,
												:c_importeliquidado,	:fac.base_comision,
												:c_importeliquidar,	:c_liquidado,										
												:fac.divisa,			:fac.ffactura,
												:fac.pais,				:fac.cliente,
												:c_n_comision,			:c_basecomisionpts,
												:c_importeliquidarpts,:c_importeliquidadopts,
												:fac.serie,				:cobrado,
												:c_nacional,			:fac.base_comision,
												:c_basecomisionpts,	:c_importeliquidar,
												:c_importeliquidarpts,:c_fletes,
												0,							:c_control_fletes,
												:fac.cambio_euros,   "N",
												:fac.fvto_max);
												
								IF SQLCA.SQLCODE <> 0 Then
									v_bien = 1
									f_mensaje("ERROR EN BASE DE DATOS (f_grabar_comisiones)",SQLCA.SQLERRTEXT)
								END IF
							end if
						END IF
					end if
				next
			end if
		end if
	next
END IF

if v_bien = 1 Then
	Return False
Else
	Return True
End If
end function

public function boolean f_grabar_cartera (integer i);Integer v_bien,reg,r1,r,contro,ind_ordenes
String  factu,sel
Str_vencimientos   vto
Str_carefectos     car
DataStore pre
Dec  vanyo_orden,vdivisas,vimporte,vdivisas_restantes,vimporte_restante
Dec  vorden,array_ordenes[],array_divisas_ordenes[],array_importe_ordenes[]
dec  nuevo_importe_efecto
boolean agrupa_precartera,dividir_efecto
Datetime max_vto

v_bien = 0
car.empresa  = codigo_empresa
car.anyo     = fac.anyo
car.orden    = f_orden_carparam(car.empresa,car.anyo)
car.anyofra  = fac.anyo
car.factura  = String(fac.factura,"###########")
car.ffra     = fac.ffactura
SetNull(car.fcobro)
car.cliente  = fac.cliente
car.monedas  = fac.divisa
//car.fpago    = fac.codpago
//car.tipodoc  = f_tipodoc_carforpag(fac.empresa,fac.codpago)
//car.recibir_dmto = f_cartipodoc_recibir_dcto(fac.empresa,car.tipodoc)
SetNull(car.banco)
SetNull(car.remesa)
SetNull(car.fremesa)
SetNull(car.observaciones)
IF fac.cartera = "N" Then
	Select Count(*) Into :contro From venfaccar
	Where  empresa    = :codigo_empresa
	And    anyofac    = :car.anyo
	And    fac_orden  = :car.factura
	And    facturado  = "S";
	IF IsNull(contro) Then  contro = 0
	IF contro <> 0 Then Return TRUE
	//Situacion precartera
	car.situacion= "4"
ELSE
	//Pasa a cartera en la situacion que le damos en el matenimiento de
	//tipos de documento y si no tiene por defecto devuelve "0"
	car.situacion= f_tipodoc_situacion_pase_cartera(codigo_empresa,car.tipodoc)
END IF
IF fac.precartera= "S" and fac.cartera = "S" Then
	// Pase precartera a cartera	
	r1 = dw.Retrieve(codigo_empresa,car.anyofra,Dec(car.factura))
	IF r1 > 0 Then
		agrupa_precartera = true
		car.observaciones = "Facturas "+car.factura
		car.factura = "AGRUPADO"		
		For r = 1 To r1
			//car.factura = car.factura + "-" +dw.GetItemSTring(r,"fac_orden")
			car.observaciones = car.observaciones + "-" +dw.GetItemSTring(r,"fac_orden")			
		Next
	else
		agrupa_precartera = false
	END IF
END IF
car.agente1       = fac.agente1
car.agente2       = fac.agente2
car.agente3       = fac.agente3
car.comision11    = fac.comision11
car.comision12    = fac.comision12
car.comision21    = fac.comision21
car.comision22    = fac.comision22
car.comision31    = fac.comision31
car.comision32    = fac.comision32
car.pais          = fac.pais
car.cuenta        = f_cuenta_genter(fac.empresa,"C",fac.cliente)
car.domiciliacion = fac.domiciliacion
IF Trim(car.domiciliacion) = "" Then
	car.domiciliacion = f_domiciliacion_venclientes(car.empresa,car.cliente)
END IF
IF f_tipo_pais(car.pais) = "N" Then
	car.nacional = "S"
ELSE
	car.nacional = "N"
END IF
SetNull(car.libre)
SetNull(car.gasto)
SetNull(car.fdevolucion)
SetNull(car.efectoagrupa)
SetNull(car.anyoagrupa)
SetNull(car.anyo_remesa)
IF agrupa_precartera Then
	car.agrupado = "S"
else
	car.agrupado = "N"
end if
car.cambio       = cambio
car.cambio_euros = fac.cambio_euros
car.serie        = fac.serie
vto              = f_vencimientos_factura(codigo_empresa,fac.anyo,fac.factura)
For reg = 1 To vto.efectos 
	
	car.fvto     = DateTime(vto.vencimiento[reg])
	if reg = 1 then 
		max_vto = car.fvto
	elseif car.fvto > max_vto then
		max_vto = car.fvto
	end if
	
	car.fvto_original = car.fvto
	car.divisas  = vto.importe[reg]
	car.importe  = vto.importe_pts[reg]
	car.recibo   = reg
	choose case reg
		case 1
			car.fpago = f_codpago1_carforpag(codigo_empresa,fac.codpago)
		case 2
			car.fpago = f_codpago2_carforpag(codigo_empresa,fac.codpago)			
		case 3
			car.fpago = f_codpago3_carforpag(codigo_empresa,fac.codpago)						
		case 4
			car.fpago = f_codpago4_carforpag(codigo_empresa,fac.codpago)						
		case 5
			car.fpago = f_codpago5_carforpag(codigo_empresa,fac.codpago)						
		case 6
			car.fpago = f_codpago6_carforpag(codigo_empresa,fac.codpago)						
		case 7
			car.fpago = f_codpago7_carforpag(codigo_empresa,fac.codpago)						
		case 8
			car.fpago = f_codpago8_carforpag(codigo_empresa,fac.codpago)						
		case 9
			car.fpago = f_codpago9_carforpag(codigo_empresa,fac.codpago)						
	end choose
	

	car.tipodoc  = f_tipodoc_carforpag(fac.empresa,car.fpago)
	car.recibir_dmto = f_cartipodoc_recibir_dcto(fac.empresa,car.tipodoc)
	
	if car.tipodoc = "2" or car.tipodoc = "5" or car.tipodoc = "6" or car.tipodoc = "7" or car.tipodoc = "11" or car.tipodoc = "12" then
		car.situacion = "10"
	end if
		
	IF car.importe <> 0 Then
		IF Not f_insert_carefectos(car) Then 
			v_bien = 1
			messagebox("Error","Se ha producido un error al grabar en cartera")
		end if
		//Guardamos las ordenes que creamos en el array
		array_ordenes[reg]         = car.orden
		array_divisas_ordenes[reg] = car.divisas
		array_importe_ordenes[reg] = car.importe
		//
		car.orden = car.orden + 1
	END IF
Next

fac.fvto_max = max_vto

IF agrupa_precartera Then
	vto = f_vencimientos_factura_sin_precartera(codigo_empresa,fac.anyo,fac.factura)
	car.factura = String(fac.factura,"###########")	
	car.anyoagrupa = car.anyo	
	car.situacion  = "3"//Agrupado
	car.agrupado   = "N"
	setnull(car.observaciones)
	For reg = 1 To vto.efectos
		car.efectoagrupa = array_ordenes[reg]
		car.fvto     = DateTime(vto.vencimiento[reg])
		if reg = 1 then 
			max_vto = car.fvto
		elseif car.fvto > max_vto then
			max_vto = car.fvto
		end if
		car.fvto_original = car.fvto
		car.divisas  = vto.importe[reg]
		car.importe  = vto.importe_pts[reg]
		car.recibo   = reg
		IF car.importe <> 0 Then
			IF Not f_insert_carefectos(car) Then 
				v_bien = 1
				messagebox("Error","Se ha producido un error al grabar en cartera")
			end if
			array_divisas_ordenes[reg] = array_divisas_ordenes[reg] - car.divisas
			array_importe_ordenes[reg] = array_importe_ordenes[reg] - car.importe
			//
			car.orden = car.orden + 1
		END IF
	Next
	fac.fvto_max = max_vto
			
	sel = "Select anyo_orden,orden,divisas,importe "+&
			"from   venfaccar "+&
			"Where  empresa = '" + codigo_empresa + "'" +&
			"And    anyo    =  " + String(fac.anyo,"####") +&
			"And    factura =  " + String(fac.factura,"####") +&
			"And    facturado = 'S' "+&
			"And    cartera   = 'S' "+&
			"order by fvto "
			
//   pre = f_cargar_cursor(sel)			
	f_Cargar_cursor_nuevo(sel, pre)
	r1 = pre.RowCount()
	ind_ordenes = 1
	For r = 1 To r1
		if v_bien = 0 then
			//messagebox("r",string(r))
			dividir_efecto = false 
			vanyo_orden = pre.GetItemNumber(r,"anyo_orden")
			vorden      = pre.GetItemNumber(r,"orden")
			vdivisas    = pre.GetItemDecimal(r,"divisas")
			vimporte    = pre.GetItemDecimal(r,"importe")
			if array_divisas_ordenes[ind_ordenes] < 0 then
				if vdivisas < array_divisas_ordenes[ind_ordenes] then
					dividir_efecto = true
					nuevo_importe_efecto = vdivisas - array_divisas_ordenes[ind_ordenes]
				end if
			else
				if (array_divisas_ordenes[ind_ordenes] - vdivisas) < 0 then
					dividir_efecto = true
					nuevo_importe_efecto = vdivisas - array_divisas_ordenes[ind_ordenes]
				end if
			end if
			if dividir_efecto then			
				if f_dividir_efecto(vanyo_orden,vorden,nuevo_importe_efecto,car.anyo,car.orden) > 0 then
					
					select importe,divisas
					into   :vimporte_restante,:vdivisas_restantes
					from   carefectos
					where  empresa = :codigo_empresa
					and    anyo    = :car.anyo
					and    orden   = :car.orden;
					if isnull(vimporte_restante) or isnull(vdivisas_restantes) then
						v_bien = 1
					end if
					pre.insertrow(r + 1)
					
					pre.object.anyo_orden[r + 1] = car.anyo
					pre.object.orden[r + 1]      = car.orden
					pre.object.divisas[r + 1]    = vdivisas_restantes
					pre.object.importe[r + 1]    = vimporte_restante

					car.orden = car.orden + 1			
										
					Update carefectos  
					set    situacion    = "3",
							 anyoagrupa   = :car.anyo,
							 efectoagrupa = :array_ordenes[ind_ordenes],
							 divisas      = :array_divisas_ordenes[ind_ordenes],
							 importe      = :array_importe_ordenes[ind_ordenes]
					WHERE  carefectos.empresa    = :fac.empresa
					AND    carefectos.anyo       = :vanyo_orden
					AND    carefectos.orden      = :vorden;

					IF SQLCA.SQLCODE <> 0 Then 
						v_bien = 1
					end if					
					array_divisas_ordenes[ind_ordenes] = 0	
					array_importe_ordenes[ind_ordenes] = 0
					ind_ordenes = ind_ordenes +1
				else
					v_bien = 1
				end if
			else
				array_divisas_ordenes[ind_ordenes] = array_divisas_ordenes[ind_ordenes] - vdivisas
				array_importe_ordenes[ind_ordenes] = array_importe_ordenes[ind_ordenes] - vimporte
				Update carefectos  
				set    situacion    = "3",
						 anyoagrupa   = :car.anyo,
						 efectoagrupa = :array_ordenes[ind_ordenes]
				WHERE  carefectos.empresa    = :fac.empresa
				AND    carefectos.anyo       = :vanyo_orden
				AND    carefectos.orden      = :vorden;
				IF SQLCA.SQLCODE <> 0 Then 
					v_bien = 1
				end if
				if array_divisas_ordenes[ind_ordenes] = 0 then
					ind_ordenes = ind_ordenes +1
				end if
			end if
			r1 = pre.RowCount()
		end if
	Next	
END IF

IF Not f_actualizar_carparam(car.empresa,car.anyo,car.orden - 1) Then v_bien = 1

destroy pre
if v_bien = 1 Then
	Return False
 Else
	Return True
End If

end function

public function boolean f_grabar_apuntes ();int  var_decimales = 0
Dec  neto,impdtopp,descuadre=0,total_dtopp=0
String  cta_ventas[99] // Máximo: 99 cuentas
Dec  importe_ventas[99],indice_cta_ventas
Dec  importe_ventas_pts[99]
int apunte_ventas[99],maximo
Integer v_bien,r,r1,i
STring cta1,marcada,sel,var_familia,fac_provincia
v_bien = 0
str_venlifac    lifac
String   ante_cuenta,grabar,articulo,nombre_articulo,tipolinea,moneda_empresa
SetNull(ante_cuenta)
grabar = "N"

moneda_empresa = f_moneda_empresa_secundaria(codigo_empresa)
// Valores comunes a todos los apuntes de todos los asientos
conta.empresa    = codigo_empresa
conta.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen     = "1"

// Santiago. 14/09/00 Los asientos se tienen que generar con fecha de la factura

//conta.fapunte    = DateTime(Date(em_fecha.text))
//conta.mes        = Month(Date(conta.fapunte))
//conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
//conta.apunte     = 0
//em_asiento.text  = String(f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen),f_mascara_decimales(0))

// Santiago. 14/09/00 Los asientos se tienen que generar con fecha de la factura

FOR i = 1 To dw_1.RowCount()
	// Inicializamos los arrays de ventas
	for indice_cta_ventas = 1 to 99
		cta_ventas[indice_cta_ventas] = ""
		importe_ventas[indice_cta_ventas] = 0
		importe_ventas_pts[indice_cta_ventas] = 0
		apunte_ventas[indice_cta_ventas] = 0
	next
	
	marcada  = dw_1.getitemstring(i,"libre")
	impdtopp = 0
	
	IF marcada="S" THEN	
			fac.empresa     = dw_1.GetItemString(i,"empresa")
			fac.anyo        = dw_1.GetItemNumber(i,"anyo")
			fac.factura     = dw_1.GetItemNumber(i,"factura")
			
			SELECT venfac.cliente,venfac.divisa,venfac.ffactura, venfac.total_fac,venfac.pais,
						venfac.serie,venfac.tipoiva,venfac.iva,venfac.importe_iva,venfac.total_fac_pts,
						venfac.importe_iva_pts,venfac.codpago
			INTO :fac.cliente,:fac.divisa,:fac.ffactura,
						:fac.total_fac,:fac.pais,:fac.serie,:fac.tipoiva,
						:fac.iva,:fac.importe_iva,:fac.total_fac_pts,:fac.importe_iva_pts,:fac.codpago
			FROM   venfac  
			WHERE  venfac.empresa  = :fac.empresa
			AND    venfac.anyo     = :fac.anyo  
			AND    venfac.factura  = :fac.factura;				
			IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en base de datos",sqlca.SqlErrtext)
				
			cambio = f_cambio_venfac(codigo_empresa,fac.anyo,fac.factura)
			fac.pais = f_pais_genter(codigo_empresa,"C",fac.cliente)
			fac.provincia = f_provincia_venclientes(codigo_empresa,fac.cliente,fac.pais)
			
			conta.divisas = 0
			conta.debe = 0
			conta.haber = 0
			conta.deducible  = "N"
			conta.actualizado= "N"
			conta.listado = "N"
			SetNull(conta.registro)
			conta.tipoter = "C"
			conta.clipro  = fac.cliente
			SetNull(conta.conciliado)
			conta.nif = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
			SetNull(conta.punteado)
			SetNull(conta.fvalor)
			SetNull(conta.docpunteo)
			SetNull(conta.coste)
			SetNull(conta.fregistro)
			conta.moneda     = fac.divisa
			conta.cambio     = cambio
			conta.cambio_euros = fac.cambio_euros
			conta.imponible  = 0
			conta.tipoiva    = fac.tipoiva
			conta.iva        = fac.iva
			conta.concepto   =  "54"
			conta.ampliacion = STring(fac.factura,"###########") + "  F.fra.: " + STring(fac.ffactura,"dd-mm-yy")
			conta.documento  = STring(fac.factura,"###########")
			conta.factura    = STring(fac.factura,"###########")
			conta.ffactura   = fac.ffactura
			
			//--------------------------------------------------------------
			//--------------------------------------------------------------
			//--------------------------------------------------------------
			r1 = dw_proceso.retrieve(codigo_empresa,fac.anyo,fac.factura)  //Carga de las líneas de factura.
			SetNUll(ante_cuenta)
			FOR r = 1 TO r1
				articulo = dw_proceso.getItemString(r,"articulo")
				tipolinea = dw_proceso.getItemString(r,"tipolinea")
			//	IF f_control_almacen_ventipolin(codigo_empresa,tipolinea) = "S" Then
				conta.cuenta  = ""
				
				var_familia = f_familia_articulo(codigo_empresa,articulo)
				
				if f_compras_articulo(codigo_empresa,articulo) = "N" Then
//						conta.cuenta = f_cuenta_ventipolin_venserie(codigo_empresa,&
//												tipolinea,fac.serie)												
					conta.cuenta = f_cuenta_familia_tipolin_serie_artpropio(codigo_empresa,&
											var_familia,&
											tipolinea,&
											fac.serie)
					// Detectamos si la provincia del cliente es Canarias, Ceuta o Melilla
					if fac.provincia = "35" or fac.provincia = "38" or fac.provincia = "51" or fac.provincia = "52" then
						conta.cuenta = left(conta.cuenta,6)+"0003"
					end if
					
				ELSE
//						conta.cuenta = f_cuenta2_ventipolin_venserie(codigo_empresa,&
//												tipolinea,fac.serie)
					conta.cuenta = f_cuenta_familia_tipolin_serie_artcompra(codigo_empresa,&
											var_familia,&
											tipolinea,&
											fac.serie)
					// Detectamos si la provincia del cliente es Canarias, Ceuta o Melilla
					if fac.provincia = "35" or fac.provincia = "38" or fac.provincia = "51" or fac.provincia = "52" then
						conta.cuenta = left(conta.cuenta,6)+"0003"
					end if
				END IF


				if IsNull(conta.cuenta) or Trim(conta.cuenta) = "" then 
					v_bien = 1
					f_mensaje("Error","No existe la cuenta contable para la familia "+f_nombre_familia(codigo_empresa,var_familia)+" tipo de linea "+f_nombre_ventipolin(codigo_empresa,tipolinea)+" articulo "+articulo+" factura "+string(fac.factura))
				else						
					indice_cta_ventas = 0
					do
						indice_cta_ventas ++						
					loop while (cta_ventas[indice_cta_ventas] <> "") and (cta_ventas[indice_cta_ventas] <> conta.cuenta) and (indice_cta_ventas < 99)						
				end if
				
				
				if (cta_ventas[indice_cta_ventas] = "") or (cta_ventas[indice_cta_ventas] = conta.cuenta) then
					//-----------------------------------------------------
					// ----------------- Importe ventas  ------------------
					//-----------------------------------------------------
					neto      =  dw_proceso.getItemNumber(r,"neto")//dw_proceso.getItemNumber(r,"neto_nuevo")//
					impdtopp  =  impdtopp+dw_proceso.getItemNumber(r,"impdtopp")//dw_proceso.getItemNumber(r,"impdtopp_nuevo") //
					IF IsNull(impdtopp) Then impdtopp = 0
//					neto      =  neto - impdtopp
					
					importe_ventas[indice_cta_ventas] = importe_ventas[indice_cta_ventas] + neto
					
					if fac.divisa = moneda_empresa then
						importe_ventas_pts[indice_cta_ventas] = importe_ventas_pts[indice_cta_ventas] + neto	
					else
						importe_ventas_pts[indice_cta_ventas] = importe_ventas_pts[indice_cta_ventas] + (neto / conta.cambio)
					end if
					
					cta_ventas[indice_cta_ventas] = conta.cuenta
					//-----------------------------------------------------
				else
					messagebox("Atención","Se han agotado las 99 posibles cuentas de ventas")
					v_bien = 1
				END IF
			NEXT
			// Santiago. 14/09/00. Cada asiento se tiene que generar con fecha de la factura
			conta.fapunte    = fac.ffactura
			conta.mes        = Month(Date(conta.fapunte))
			conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
			conta.apunte     = 0
			// Santiago. 14/09/00. Cada asiento se tiene que generar con fecha de la factura
			//---------------------------------------------------------------------
			//---------------------------------------------------------------------
			//---------------------------------------------------------------------
			//---------------------------------------------------------------------
			conta.apunte   = conta.apunte + 1
			conta.concepto =  "54"
			conta.ampliacion  = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
			conta.documento = STring(fac.factura,"###########")
			conta.imponible = 0
			conta.cuenta    = f_cuenta_genter(codigo_empresa,"C",fac.cliente)
			conta.ffactura  = fac.ffactura
			iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
					f_mensaje("Error en datos","Cliente " + fac.cliente + "sin cuenta" )
					v_bien = 1
			END IF
			conta.tipoapu = f_tipocta_contaplan(conta.ejercicio,conta.empresa,conta.cuenta)
			if fac.total_fac_pts>0 then
				conta.haber =0				
				conta.debe  = fac.total_fac_pts
			else
				conta.haber = - fac.total_fac_pts
				conta.debe  = 0
			end if
			conta.divisas = fac.total_fac
			

			SetNUll(conta.nif)
			conta.imponible = 0
			SetNUll(conta.tipoapu)
			SetNUll(conta.tipoiva)
			SetNUll(conta.iva)
			IF Not f_insert_contaapun(conta) Then 
				v_bien = 1
				f_mensaje("Error","AL GRABAR ASIENTO")
			END IF
		//-----------------------------------------------------------
		// Apunte   iva
		//-----------------------------------------------------------
			conta.apunte   = conta.apunte + 1
			conta.concepto =  "54"
			conta.ampliacion  = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
			conta.imponible  = fac.total_fac_pts - fac.importe_iva_pts
			
			conta.tipoiva    = fac.tipoiva
			conta.iva        = fac.iva
			conta.cuenta  = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
				f_mensaje("Error en datos","Iva " + fac.tipoiva + "sin cuenta" )
				v_bien = 1
			END IF
			conta.tipoapu = f_libro_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
			//conta.haber    = Dec(String((f_conversion_pesetas(fac.importe_iva,conta.cambio_euros)),f_mascara_decimales(0)))
			if fac.importe_iva_pts>0 then
				conta.haber    = fac.importe_iva_pts
				conta.debe     = 0				
			else
				conta.haber    = 0
				conta.debe     = - fac.importe_iva_pts
			end if
			conta.divisas = fac.importe_iva
			//--------------------------
			// segun el tipo de contador
			//--------------------------
			IF f_tipo_contador_contalibros(conta.ejercicio,conta.empresa,conta.tipoapu)= "F" Then
				conta.registro  = fac.factura
			ELSE
				conta.registro = f_registro_tipoiva(conta.ejercicio,conta.empresa,conta.tipoiva)
				IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,conta.tipoapu,conta.registro) Then v_bien = 1
			END IF
			conta.fregistro = fac.ffactura
			conta.documento   = STring(fac.factura,"###########")
			conta.nif  = f_cif_genter(conta.empresa,"C",fac.cliente)
			conta.tipoter = "C"
			conta.clipro  = fac.cliente
			conta.ffactura  = fac.ffactura
			conta.listado = "N"

			IF Not f_insert_contaapun(conta) Then 
				v_bien = 1
				f_mensaje("Error","AL GRABAR ASIENTO")
			END IF

		//-----------------------------------------------------------
		// Apunte descuento por pronto pago
		//-----------------------------------------------------------
			conta.apunte   = conta.apunte + 1
			conta.concepto =  "54"
			conta.ampliacion  = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
			conta.imponible  = 0
			Choose case fac.serie
				case "1"  //Nacional
					conta.cuenta  = "7061010000"
				case "2"  //CEE
					conta.cuenta  = "7061020000"
				case "3"  // No CEE
					conta.cuenta  = "7061030000"
				case "4"	 // Rectif. Nacional
					conta.cuenta  = "7061010000"
				case "5"	 // Rectif. CEE
					conta.cuenta  = "7061020000"
				case "6"
					// Rectif. No CEE
					conta.cuenta  = "7061030000"
				case "7"
					conta.cuenta  = "7061030000"					
				case else
					v_bien=1
					f_mensaje("Error","Opción no contemplada")
			end choose
			if conta.moneda = moneda_empresa then
				total_dtopp=Dec(String(impdtopp,f_mascara_moneda(moneda_empresa)))
				if impdtopp>0 then
					conta.haber   = 0					
					conta.debe    =  total_dtopp
				else
					conta.haber   = 0
					conta.debe    =  total_dtopp
				end if
			else
				total_dtopp = Dec(String(impdtopp / conta.cambio,f_mascara_moneda(moneda_empresa)))
				if impdtopp>0 then
					conta.haber   = 0		
					conta.debe    =  total_dtopp
				else
					conta.debe    =  total_dtopp					
					conta.haber   = 0
				end if
			end if
			conta.divisas = impdtopp
			conta.fregistro = fac.ffactura
			conta.documento   = STring(fac.factura,"###########")
			conta.factura = ""				
			SetNull(conta.ffactura)
			SetNull(conta.tipoter)
			SetNull(conta.registro)
			SetNull(conta.tipoapu)
			SetNull(conta.tipoiva)
			SetNull(conta.iva)
			conta.ffactura  = fac.ffactura
			conta.listado = "N"
			if conta.debe	<> 0 then
				IF Not f_insert_contaapun(conta) Then 
					v_bien = 1
					f_mensaje("Error","AL GRABAR ASIENTO")
				END IF
			end if
				
	//-----------------------------------------------------------------
	//-----------------------------------------------------------------
	// Hacemos el apunte en la cuenta de ventas
	//-----------------------------------------------------------------
	//-----------------------------------------------------------------
		indice_cta_ventas = 0
		DO
			indice_cta_ventas ++							
			IF IsNull(importe_ventas[indice_cta_ventas]) Then importe_ventas[indice_cta_ventas]= 0
			
			IF importe_ventas[indice_cta_ventas]<> 0 Then
				conta.cuenta = cta_ventas[indice_cta_ventas]
				iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
						nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
						f_mensaje("Error en datos",Trim(nombre_articulo) + "sin cuenta" )
						v_bien = 1
				END IF
				conta.apunte  = conta.apunte + 1		
				apunte_ventas[indice_cta_ventas]=conta.apunte
				conta.concepto = "54"
				conta.documento = STring(fac.factura,"###########")
				conta.factura = ""
				conta.ffactura = fac.ffactura
				SetNull(conta.tipoter)
				SetNull(conta.registro)
				conta.imponible = 0
				SetNull(conta.tipoapu)
				SetNull(conta.tipoiva)
				SetNull(conta.iva)
				conta.ampliacion = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
				
//				if importe_ventas_pts[indice_cta_ventas]>0 then
//					conta.debe = 0				
//					conta.haber   = dec(string(importe_ventas_pts[indice_cta_ventas],f_mascara_moneda(moneda_empresa)))
//				else
//					conta.debe = - dec(string(importe_ventas_pts[indice_cta_ventas],f_mascara_moneda(moneda_empresa)))
//					conta.haber   = 0
//				end if		

				SELECT monedas.decimales  
				INTO   :var_decimales  
				FROM   monedas
				WHERE  monedas.moneda = :moneda_empresa;
				
				importe_ventas_pts[indice_cta_ventas] = 	round(importe_ventas_pts[indice_cta_ventas], var_decimales)

				if importe_ventas_pts[indice_cta_ventas]>0 then
					conta.debe = 0				
					conta.haber   = importe_ventas_pts[indice_cta_ventas]
				else
					conta.debe = - importe_ventas_pts[indice_cta_ventas]
					conta.haber   = 0
				end if		

				conta.divisas = importe_ventas[indice_cta_ventas]
				IF Not f_insert_contaapun(conta) Then 	
					v_bien = 1
					f_mensaje("Error","AL GRABAR ASIENTO")
				END IF
			END IF	
		LOOP WHILE (cta_ventas[indice_cta_ventas] <> "") and (indice_cta_ventas < 99)					

		//-----------------------
		//Corregimos el descuadre
		//-----------------------
		descuadre=0
		
		For indice_cta_ventas = 1 To upperbound(importe_ventas_pts)
			descuadre=descuadre + importe_ventas_pts[indice_cta_ventas]
		Next
		
		descuadre=fac.total_fac_pts + total_dtopp - (descuadre +fac.importe_iva_pts)
		
		IF descuadre<>0 THEN
			//Buscamos el apunte de ventas mayor
			maximo=1
			For indice_cta_ventas = 1 To upperbound(importe_ventas_pts)
				if importe_ventas_pts[indice_cta_ventas]>importe_ventas_pts[maximo] then
					maximo=indice_cta_ventas
				end if
			Next
			
			//Le añadimos el descuadre
			if importe_ventas_pts[maximo]>0 then
				update contaapun
				set haber=haber+:descuadre
				where empresa=:codigo_empresa and
						ejercicio=:conta.ejercicio and
						mes=:conta.mes and
						origen='1' and
						asiento=:conta.asiento and
						apunte=:apunte_ventas[maximo];
			else
				update contaapun
				set debe=debe+:descuadre
				where empresa=:codigo_empresa and
						ejercicio=:conta.ejercicio and
						mes=:conta.mes and
						origen='1' and
						asiento=:conta.asiento and
						apunte=:apunte_ventas[maximo];		
			end if
			if sqlca.sqlcode<>0 then
				v_bien=1
				f_mensaje("Atención","Error al corregir descuadre")
			end if		
		END IF		

		if v_bien=0 then
			if not f_comprueba_asiento(conta.ejercicio,codigo_empresa,conta.asiento,conta.origen,conta.mes) then
				v_bien=1
			end if
		end if
		
		//Lo quitamos el 30-01-2017 Paco Marin
		// Santiago 10/08/2000
		// Si la forma de pago de la factura ES REMESABLE entonces debe
		// añadir nuevas líneas en el asiento 4310 a 4300 Efectos en Cartera
//		IF f_remesable_codpago(codigo_empresa,fac.codpago) then
//			//---------
//			// Cliente
//			//---------
//			conta.apunte   = conta.apunte + 1
//			conta.concepto =  "54"
//			conta.ampliacion  = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
//			conta.documento = STring(fac.factura,"###########")
//			conta.imponible = 0
//			conta.cuenta    = f_cuenta_genter(codigo_empresa,"C",fac.cliente)
//			conta.ffactura  = fac.ffactura
//			iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
//					f_mensaje("Error en datos","Cliente " + fac.cliente + "sin cuenta" )
//					v_bien = 1
//			END IF
//			conta.tipoapu = f_tipocta_contaplan(conta.ejercicio,conta.empresa,conta.cuenta)
//			if fac.total_fac_pts>0 then
//				conta.haber = fac.total_fac_pts				
//				conta.debe  = 0
//			else
//				conta.haber = 0
//				conta.debe  = - fac.total_fac_pts
//			end if
//			conta.divisas = fac.total_fac
//			SetNUll(conta.nif)
//			conta.imponible = 0
//			SetNUll(conta.tipoapu)
//			SetNUll(conta.tipoiva)
//			SetNUll(conta.iva)
//			IF Not f_insert_contaapun(conta) Then 
//				v_bien = 1
//				f_mensaje("Error","AL GRABAR ASIENTO")
//			END IF
//			//---------
//			// Efectos Comerciales en Cartera
//			//---------
//			conta.apunte   = conta.apunte + 1
//			conta.concepto =  "54"
//			conta.ampliacion  = "NFRA.: " +conta.factura+" "+f_razon_genter(codigo_empresa,"C",fac.cliente)
//			conta.documento = STring(fac.factura,"###########")
//			conta.imponible = 0
//			// En lugar de COMPONER la cuenta, la extraemos de la tabla del cliente.
//			select cuenta_ecc into :cuenta_ecc from venclientes where empresa = :codigo_empresa and codigo = :fac.cliente;
////			conta.cuenta    = f_comp_cta_riesgo_431x("4310000000",conta.cuenta)
//			conta.cuenta    = cuenta_ecc
//			conta.ffactura  = fac.ffactura
//			iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
//					f_mensaje("Error en datos","Cliente " + fac.cliente + "sin cuenta de Efectos Comerciales" )
//					v_bien = 1
//			END IF
//			conta.tipoapu = f_tipocta_contaplan(conta.ejercicio,conta.empresa,conta.cuenta)
//			if fac.total_fac_pts>0 then
//				conta.haber = 0
//				conta.debe  = fac.total_fac_pts
//			else
//				conta.haber = - fac.total_fac_pts
//				conta.debe  = 0
//			end if
//			conta.divisas = fac.total_fac
//			SetNUll(conta.nif)
//			conta.imponible = 0
//			SetNUll(conta.tipoapu)
//			SetNUll(conta.tipoiva)
//			SetNUll(conta.iva)
//			IF Not f_insert_contaapun(conta) Then 
//				v_bien = 1
//				f_mensaje("Error","AL GRABAR ASIENTO")
//			END IF
//	   END IF		
		// Fin Santiago 10/08/2000
		//Lo quitamos el 30-01-2017 Paco Marin
	END IF
	
	f_mensaje_proceso("Contabilizando",i,dw_1.RowCount())
NEXT
	
if v_bien = 1 Then
	Return False
Else
	Return True
End If



end function

public subroutine f_grabar_apuntes_viejo ();//Dec  neto,impdtopp
//String  cta_ventas[99] // Máximo: 99 cuentas
//Dec  importe_ventas[99],indice_cta_ventas
//Dec  importe_ventas_pts[99]
//Integer v_bien,r,r1,i
//STring cta1,marcada,sel,var_familia
//v_bien = 0
//str_venlifac    lifac
//String   ante_cuenta,grabar,articulo,nombre_articulo,tipolinea
//SetNull(ante_cuenta)
//grabar = "N"
//
//// Inicializamos los arrays de ventas
//for indice_cta_ventas = 1 to 99
//	cta_ventas[indice_cta_ventas] = ""
//	importe_ventas[indice_cta_ventas] = 0
//	importe_ventas_pts[indice_cta_ventas] = 0
//next
//
//// Valores comunes a todos los apuntes de todos los asientos
//		conta.empresa    = codigo_empresa
//		conta.ejercicio  = Dec(uo_ejercicio.em_ejercicio.text)
//		conta.origen = "1"
//		conta.fapunte    = DateTime(Date(em_fecha.text))
//		conta.mes        = Month(Date(conta.fapunte))
//		conta.asiento    = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
//		conta.apunte = 0
//		em_asiento.text  = String(conta.asiento,f_mascara_decimales(0))
//
//FOR i = 1 To dw_1.RowCount()
//	marcada=dw_1.getitemstring(i,"libre")
//	impdtopp=0
//	IF marcada="S" THEN
//			fac.empresa     = dw_1.GetItemString(i,"empresa")
//			fac.anyo        = dw_1.GetItemNumber(i,"anyo")
//			fac.factura     = dw_1.GetItemNumber(i,"factura")
//			
//			  SELECT venfac.cliente,venfac.divisa, venfac.cambio,venfac.ffactura, venfac.total_fac,venfac.pais,
//						venfac.serie,venfac.tipoiva,venfac.iva,venfac.importe_iva,venfac.total_fac_pts,
//						venfac.importe_iva_pts,venfac.cambio_euros
//				 INTO :fac.cliente,:fac.divisa,:cambio,:fac.ffactura,
//						:fac.total_fac,:fac.pais,:fac.serie,:fac.tipoiva,
//						:fac.iva,:fac.importe_iva,:fac.total_fac_pts,:fac.importe_iva_pts,:fac.cambio_euros
//				FROM   venfac  
//				WHERE  venfac.empresa  = :fac.empresa
//				AND    venfac.anyo     = :fac.anyo  
//				AND    venfac.factura  = :fac.factura;
//				IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en base de datos",sqlca.SqlErrtext)
//				fac.pais = f_pais_genter(codigo_empresa,"C",fac.cliente)
//				//IF f_tipo_pais(fac.pais)  = "N"	Then 	tipovta = "1"
//				//IF f_tipo_pais(fac.pais) <> "N"	Then 	tipovta = "3"
//				//IF fac.pais = "100" Then  tipovta = "2"
//				conta.divisas =0
//				conta.debe =0
//				conta.haber =0
//				conta.deducible  = "N"
//				conta.actualizado= "N"
//				conta.listado = "N"
//				SetNull(conta.registro)
//				conta.tipoter = "C"
//				conta.clipro  = fac.cliente
//				SetNull(conta.conciliado)
//				conta.nif = f_cif_genter(conta.empresa,conta.tipoter,conta.clipro)
//				SetNull(conta.punteado)
//				SetNull(conta.fvalor)
//				SetNull(conta.docpunteo)
//				SetNull(conta.coste)
//				SetNull(conta.fregistro)
//				conta.moneda = fac.divisa
//				conta.cambio = cambio
//				conta.cambio_euros =fac.cambio_euros
//				conta.imponible = 0
//				conta.tipoiva    = fac.tipoiva
//				conta.iva        = fac.iva
//				conta.concepto =  "54"
//				conta.ampliacion  = STring(fac.factura,"###########") + "  F.fra.: " + STring(fac.ffactura,"dd-mm-yy")
//				conta.documento = STring(fac.factura,"###########")
//				conta.factura   = STring(fac.factura,"###########")
//				conta.ffactura  = fac.ffactura
//			
//			
//			//--------------------------------------------------------------
//			//--------------------------------------------------------------
//			//--------------------------------------------------------------
//			r1 = dw_proceso.retrieve(codigo_empresa,fac.anyo,fac.factura)
//			SetNUll(ante_cuenta)
//			For r = 1 To r1
//				articulo = dw_proceso.getItemString(r,"articulo")
//				tipolinea = dw_proceso.getItemString(r,"tipolinea")
//			//	IF f_control_almacen_ventipolin(codigo_empresa,tipolinea) = "S" Then
//					conta.cuenta  = ""
//					
//					var_familia = f_familia_articulo(codigo_empresa,articulo)
//					
//					if f_compras_articulo(codigo_empresa,articulo) = "N" Then
////						conta.cuenta = f_cuenta_ventipolin_venserie(codigo_empresa,&
////												tipolinea,fac.serie)												
//						conta.cuenta = f_cuenta_familia_tipolin_serie_artpropio(codigo_empresa,&
//												var_familia,&
//												tipolinea,&
//												fac.serie)
//												
//					ELSE
////						conta.cuenta = f_cuenta2_ventipolin_venserie(codigo_empresa,&
////												tipolinea,fac.serie)
//						conta.cuenta = f_cuenta_familia_tipolin_serie_artcompra(codigo_empresa,&
//												var_familia,&
//												tipolinea,&
//												fac.serie)
//
//					END IF
//
//
//					if IsNull(conta.cuenta) or Trim(conta.cuenta) = "" then 
//						v_bien = 1
//						f_mensaje("Error","No existe la cuenta contable para la familia "+&
//							f_nombre_familia(codigo_empresa,var_familia)+" y el tipo de linea "+f_nombre_ventipolin(codigo_empresa,tipolinea))
//					end if
//					
//					indice_cta_ventas = 0
//					do
//						indice_cta_ventas ++						
//					loop while (cta_ventas[indice_cta_ventas] <> "") and (cta_ventas[indice_cta_ventas] <> conta.cuenta) and (indice_cta_ventas < 99)
//					
//					if (cta_ventas[indice_cta_ventas] = "") or (cta_ventas[indice_cta_ventas] = conta.cuenta) then
//						//-----------------------------------------------------
//						// ----------------- Importe ventas  ------------------
//						//-----------------------------------------------------
//						neto      =  dw_proceso.getItemNumber(r,"neto")
//						impdtopp  =  impdtopp+dw_proceso.getItemNumber(r,"impdtopp")
//						IF IsNull(impdtopp) Then impdtopp = 0
//	//					neto      =  neto - impdtopp
//						
//						importe_ventas[indice_cta_ventas] = importe_ventas[indice_cta_ventas] + neto
//						
//						if fac.divisa = f_codigo_pts() then
//							importe_ventas_pts[indice_cta_ventas] = importe_ventas_pts[indice_cta_ventas] + neto	
//						else
//							importe_ventas_pts[indice_cta_ventas] = importe_ventas_pts[indice_cta_ventas] + f_conversion_pesetas(neto,conta.cambio_euros)
//						end if
//						
//						cta_ventas[indice_cta_ventas] = conta.cuenta
//						//-----------------------------------------------------
//				else
//					messagebox("Atención","Se han agotado las 99 posibles cuentas de ventas")
//					v_bien = 1
//				END IF
//			Next
//			
//			//---------------------------------------------------------------------
//			//---------------------------------------------------------------------
//			//---------------------------------------------------------------------
//			//---------------------------------------------------------------------
//				conta.apunte   = conta.apunte + 1
//				conta.concepto =  "54"
//				conta.ampliacion  = "F.fra.: " + STring(fac.ffactura,"dd-mm-yy")
//				conta.documento = STring(fac.factura,"###########")
//				conta.haber =0
//				conta.imponible = 0
//				conta.cuenta  =f_cuenta_genter(codigo_empresa,"C",fac.cliente)
//				conta.ffactura  = fac.ffactura
//				iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
//						f_mensaje("Error en datos","Cliente " + fac.cliente + "sin cuenta" )
//						v_bien = 1
//				END IF
//				conta.tipoapu = f_tipocta_contaplan(conta.ejercicio,conta.empresa,conta.cuenta)
//				conta.debe    = fac.total_fac_pts
//				conta.divisas = fac.total_fac
//				SetNUll(conta.nif)
//				conta.imponible = 0
//				SetNUll(conta.tipoapu)
//				SetNUll(conta.tipoiva)
//				SetNUll(conta.iva)
//				IF Not f_insert_contaapun(conta) Then 
//					v_bien = 1
//					f_mensaje("Error","AL GRABAR ASIENTO")
//				END IF
//			//-----------------------------------------------------------
//			// Apunte   iva
//			//-----------------------------------------------------------
//				conta.apunte   = conta.apunte + 1
//				conta.concepto =  "54"
//				conta.ampliacion  = "F.fra.: " + STring(fac.ffactura,"dd-mm-yy")
//				conta.debe       = 0
//				conta.imponible  = fac.total_fac_pts - fac.importe_iva_pts
//				conta.tipoiva    = fac.tipoiva
//				conta.iva        = fac.iva
//				conta.cuenta  = f_ctaiva_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
//				iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
//					f_mensaje("Error en datos","Iva " + fac.tipoiva + "sin cuenta" )
//					v_bien = 1
//				END IF
//				conta.tipoapu = f_libro_contaiva(conta.ejercicio,conta.empresa,conta.tipoiva)
//				//conta.haber    = Dec(String((f_conversion_pesetas(fac.importe_iva,conta.cambio_euros)),f_mascara_decimales(0)))
//				conta.haber    = fac.importe_iva_pts
//				conta.divisas = fac.importe_iva
//				//--------------------------
//				// segun el tipo de contador
//				//--------------------------
//				IF f_tipo_contador_contalibros(conta.ejercicio,conta.empresa,conta.tipoapu)= "F" Then
//					conta.registro  = fac.factura
//				ELSE
//					conta.registro = f_registro_tipoiva(conta.ejercicio,conta.empresa,conta.tipoiva)
//					IF Not f_actualizar_contalibros(conta.ejercicio,conta.empresa,conta.tipoapu,conta.registro) Then v_bien = 1
//				END IF
//				conta.fregistro = fac.ffactura
//				conta.documento   = STring(fac.factura,"###########")
//				conta.nif  = f_cif_genter(conta.empresa,"C",fac.cliente)
//				conta.tipoter = "C"
//				conta.clipro  = fac.cliente
//				conta.ffactura  = fac.ffactura
//				conta.listado = "N"
//				IF Not f_insert_contaapun(conta) Then 
//					v_bien = 1
//					f_mensaje("Error","AL GRABAR ASIENTO")
//				END IF
//
//			//-----------------------------------------------------------
//			// Apunte descuento por pronto pago
//			//-----------------------------------------------------------
//				conta.apunte   = conta.apunte + 1
//				conta.concepto =  "54"
//				conta.ampliacion  = "F.fra.: " + STring(fac.ffactura,"dd-mm-yy")
//				conta.haber      = 0
//				conta.imponible  = 0
//				Choose case fac.serie
//					case "1"  // Nacional
//						conta.cuenta  = "665030000"
//					case "2"  // Exportación
//						conta.cuenta  = "665030002"
//					case "3"  // CEE
//						conta.cuenta  = "665030003"
//					case "4"	 // Canarias
//						conta.cuenta  = "665030001"
//					case else
//						v_bien=1
//						f_mensaje("Error","Opción no contemplada")
//				end choose
//				if conta.moneda = f_codigo_pts() then
//					conta.debe    = Dec(String(impdtopp,f_mascara_moneda(f_moneda_empresa(codigo_empresa))))
//				else
//					conta.debe    = Dec(String((f_conversion_pesetas(impdtopp,conta.cambio_euros)),f_mascara_moneda(f_moneda_empresa(codigo_empresa))))
//				end if
//				conta.divisas = impdtopp
//				conta.fregistro = fac.ffactura
//				conta.documento   = STring(fac.factura,"###########")
//				conta.factura = ""				
//				SetNull(conta.ffactura)
//				SetNull(conta.tipoter)
//				SetNull(conta.registro)
//				SetNull(conta.tipoapu)
//				SetNull(conta.tipoiva)
//				SetNull(conta.iva)
//				conta.ffactura  = fac.ffactura
//				conta.listado = "N"
//				if conta.debe	<> 0 then
//					IF Not f_insert_contaapun(conta) Then 
//						v_bien = 1
//						f_mensaje("Error","AL GRABAR ASIENTO")
//					END IF
//				end if
//
//	END IF
//	f_mensaje_proceso("Contabilizando",i,dw_1.RowCount())
//Next
//conta.debe=0
//indice_cta_ventas = 0
//do
//	indice_cta_ventas ++							
//	IF IsNull(importe_ventas[indice_cta_ventas]) Then importe_ventas[indice_cta_ventas]= 0
//	IF importe_ventas[indice_cta_ventas]<> 0 Then
//		conta.cuenta = cta_ventas[indice_cta_ventas]
//		iF Trim(conta.cuenta) = ""  or  IsNull(conta.cuenta)Then
//				nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
//				f_mensaje("Error en datos",Trim(nombre_articulo) + "sin cuenta" )
//				v_bien = 1
//		END IF
//		conta.apunte  = conta.apunte + 1		
//		conta.concepto = "54"
//		conta.documento = ""
//		conta.factura = ""
//		SetNull(conta.ffactura)
//		SetNull(conta.tipoter)
//		SetNull(conta.registro)
//		conta.imponible = 0
//		SetNull(conta.tipoapu)
//		SetNull(conta.tipoiva)
//		SetNull(conta.iva)
//		conta.ampliacion = "Fecha "+STring(fac.ffactura,"dd-mm-yy")
//		conta.haber   = importe_ventas_pts[indice_cta_ventas]
//		conta.divisas = importe_ventas[indice_cta_ventas]
//		IF Not f_insert_contaapun(conta) Then 	
//			v_bien = 1
//			f_mensaje("Error","AL GRABAR ASIENTO")
//		END IF
//	END IF	
//	
//	
//loop while (cta_ventas[indice_cta_ventas] <> "") and (indice_cta_ventas < 99)
//
////For indice_cta_ventas = 1 To 99
////Next
//
//if v_bien = 1 Then
//	Return False
//Else
//	Return True
//End If
//
//
//
end subroutine

public function decimal f_dividir_efecto (long anyo, long orden, decimal nuevo_importe, long nuevo_anyo, long nuevo_efecto);dec importe
//messagebox("anyo "+string(anyo),"orden "+string(orden))
//messagebox("nuevo_efecto"+string(nuevo_efecto),"nuevo_importe "+string(nuevo_importe))
str_carefectos carefectos
SELECT carefectos.empresa,
		 carefectos.anyo,
		 carefectos.orden,
		 carefectos.anyofra,
		 carefectos.factura,
		 carefectos.recibo,
		 carefectos.fvto,
		 carefectos.fvto_original,
		 carefectos.ffra,
		 carefectos.fcobro,
		 carefectos.importe,
		 carefectos.divisas,
		 carefectos.monedas,
		 carefectos.fpago,
		 carefectos.tipodoc,
		 carefectos.banco,
		 carefectos.remesa,
		 carefectos.fremesa,
		 carefectos.situacion,
		 carefectos.agente1,
		 carefectos.pais,
		 carefectos.cuenta,
		 carefectos.domiciliacion,
		 carefectos.Nacional,
		 carefectos.observaciones,
		 carefectos.libre,
		 carefectos.gasto,
		 carefectos.fdevolucion,
		 carefectos.agrupado,
		 carefectos.efectoagrupa,
		 carefectos.anyoagrupa,
		 carefectos.cliente,
		 carefectos.anyo_remesa,
		 carefectos.comision11,
		 carefectos.comision12,
		 carefectos.agente2,
		 carefectos.comision21,
		 carefectos.comision22,
		 carefectos.agente3,
		 carefectos.comision31,
		 carefectos.comision32,
		 carefectos.cambio,
		 carefectos.serie,
		 carefectos.remesa_total,
		 carefectos.tipo_remesa,
		 carefectos.recibir_dmto,
		 carefectos.fecha_recibido,
		 carefectos.punteado,
		 carefectos.clase_efecto,
		 carefectos.cambio_euros
into   :carefectos.empresa,
		 :carefectos.anyo,
		 :carefectos.orden,
		 :carefectos.anyofra,
		 :carefectos.factura,
		 :carefectos.recibo,
		 :carefectos.fvto,
		 :carefectos.fvto_original,
		 :carefectos.ffra,
		 :carefectos.fcobro,
		 :carefectos.importe,
		 :carefectos.divisas,
		 :carefectos.monedas,
		 :carefectos.fpago,
		 :carefectos.tipodoc,
		 :carefectos.banco,
		 :carefectos.remesa,
		 :carefectos.fremesa,
		 :carefectos.situacion,
		 :carefectos.agente1,
		 :carefectos.pais,
		 :carefectos.cuenta,
		 :carefectos.domiciliacion,
		 :carefectos.Nacional,
		 :carefectos.observaciones,
		 :carefectos.libre,
		 :carefectos.gasto,
		 :carefectos.fdevolucion,
		 :carefectos.agrupado,
		 :carefectos.efectoagrupa,
		 :carefectos.anyoagrupa,
		 :carefectos.cliente,
		 :carefectos.anyo_remesa,
		 :carefectos.comision11,
		 :carefectos.comision12,
		 :carefectos.agente2,
		 :carefectos.comision21,
		 :carefectos.comision22,
		 :carefectos.agente3,
		 :carefectos.comision31,
		 :carefectos.comision32,
		 :carefectos.cambio,
		 :carefectos.serie,
		 :carefectos.remesa_total,
		 :carefectos.tipo_remesa,
		 :carefectos.recibir_dmto,
		 :carefectos.fecha_recibido,
		 :carefectos.punteado,
		 :carefectos.clase_efecto,
		 :carefectos.cambio_euros				 
FROM   carefectos
where  carefectos.empresa = :codigo_empresa
and    carefectos.anyo    = :anyo
and    carefectos.orden   = :orden;

if sqlca.sqlcode = 0 then
	carefectos.recibo ++
	carefectos.importe = nuevo_importe / carefectos.cambio //anteimporte - carefectos.importe
	carefectos.divisas = nuevo_importe  //carefectos.importe / carefectos.cambio
	carefectos.anyo    = nuevo_anyo
	carefectos.orden   = nuevo_efecto
	
	IF Not f_insert_carefectos(carefectos) Then 
		carefectos.orden = 0
		messagebox("Error","Se ha producido un error al dividir un efecto1")
	end if
else			
	carefectos.orden = 0
	messagebox("Atención","Se ha producido un error al dividir el efecto2")
end if

return carefectos.orden
end function

on w_actualizacion_fac.create
int iCurrent
call super::create
this.em_fechadesde=create em_fechadesde
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_continuar=create cb_continuar
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_actualizar=create cb_actualizar
this.pb_1=create pb_1
this.em_fecha=create em_fecha
this.st_11=create st_11
this.em_asiento=create em_asiento
this.st_1=create st_1
this.dw_fac=create dw_fac
this.dw_1=create dw_1
this.em_serie=create em_serie
this.st_nombre_serie=create st_nombre_serie
this.st_22=create st_22
this.em_fechahasta=create em_fechahasta
this.st_2=create st_2
this.uo_ejercicio=create uo_ejercicio
this.cb_cambio=create cb_cambio
this.dw_listado=create dw_listado
this.dw_proceso=create dw_proceso
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_fechadesde
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.cb_continuar
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_actualizar
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.st_11
this.Control[iCurrent+11]=this.em_asiento
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.dw_fac
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.em_serie
this.Control[iCurrent+16]=this.st_nombre_serie
this.Control[iCurrent+17]=this.st_22
this.Control[iCurrent+18]=this.em_fechahasta
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.uo_ejercicio
this.Control[iCurrent+21]=this.cb_cambio
this.Control[iCurrent+22]=this.dw_listado
this.Control[iCurrent+23]=this.dw_proceso
this.Control[iCurrent+24]=this.dw
end on

on w_actualizacion_fac.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_fechadesde)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_continuar)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_actualizar)
destroy(this.pb_1)
destroy(this.em_fecha)
destroy(this.st_11)
destroy(this.em_asiento)
destroy(this.st_1)
destroy(this.dw_fac)
destroy(this.dw_1)
destroy(this.em_serie)
destroy(this.st_nombre_serie)
destroy(this.st_22)
destroy(this.em_fechahasta)
destroy(this.st_2)
destroy(this.uo_ejercicio)
destroy(this.cb_cambio)
destroy(this.dw_listado)
destroy(this.dw_proceso)
destroy(this.dw)
end on

event open;call super::open;dw_1.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
Date  fecha

This.title = "Actualización de Facturas."

fecha = Today()
em_fecha.text =String(fecha,"dd-mm-yy")
em_fechadesde.text =String(fecha,"dd-mm-yy")
em_fechahasta.text =String(fecha,"dd-mm-yy")
f_activar_campo(em_serie)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_actualizacion_fac
integer x = 622
integer y = 620
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_actualizacion_fac
end type

type st_empresa from w_int_con_empresa`st_empresa within w_actualizacion_fac
integer y = 12
integer width = 2610
end type

type em_fechadesde from u_em_campo within w_actualizacion_fac
integer x = 27
integer y = 212
integer width = 288
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_3 from groupbox within w_actualizacion_fac
integer x = 1541
integer y = 184
integer width = 379
integer height = 124
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_actualizacion_fac
integer x = 686
integer y = 184
integer width = 841
integer height = 124
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_continuar from commandbutton within w_actualizacion_fac
integer x = 699
integer y = 228
integer width = 389
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;
IF Trim(em_serie.text) = "" Then
	f_mensaje("Campo Obligarorio","Introduzca la serie")
	f_activar_campo(em_serie)
	Return
END IF
dw_1.retrieve(codigo_empresa,em_serie.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

type dw_2 from datawindow within w_actualizacion_fac
boolean visible = false
integer x = 649
integer y = 444
integer width = 1783
integer height = 864
integer taborder = 110
string dataobject = "dw_con_actualizacion_linfac"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_actualizacion_fac
boolean visible = false
integer x = 677
integer y = 1220
integer width = 279
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;dw_2.visible=false
this.visible=false
end event

type cb_actualizar from commandbutton within w_actualizacion_fac
event clicked pbm_bnclicked
integer x = 1554
integer y = 228
integer width = 352
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contabilizar"
end type

event clicked;IF MessageBox("Proceso de actualización","¿Continuar?",Question!,YesNo!)= 2 Then Return

Integer bien,i
String marcada 
bien = 0
IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),DateTime(date(em_fecha.text))) Then 
	f_activar_campo(em_fecha)
	Return
END IF

FOR i = 1 To dw_1.RowCount()
	marcada=dw_1.getitemstring(i,"libre")
	IF marcada="S" THEN
		fac.empresa  = dw_1.GetItemString(i,"empresa")
		fac.anyo        = dw_1.GetItemNumber(i,"anyo")
		fac.factura     = dw_1.GetItemNumber(i,"factura")
		SELECT venfac.cliente,venfac.codpago,venfac.agente1, venfac.agente2,   
				venfac.comision11,    venfac.comision21,      venfac.comision12,   
				venfac.comision22,    venfac.idioma,          venfac.divisa,   
				venfac.cambio,        venfac.agente3,         venfac.comision32,   
				venfac.comision31,    venfac.ffactura,        venfac.total_fac,   
				venfac.base_comision, venfac.pais,    	       venfac.cartera,
				venfac.precartera,    venfac.domiciliacion,
				venfac.serie,venfac.tipoiva,venfac.iva,
				venfac.importe_iva,venfac.divisa,venfac.total_fac_pts,
				venfac.importe_iva_pts,venfac.base_comision_pts,
				venfac.generar_recibos,venfac.cambio_euros,
				venfac.comision_fija1,venfac.comision_fija2,venfac.comision_fija3
		 INTO :fac.cliente,       :fac.codpago,    :fac.agente1,    :fac.agente2,   
				:fac.comision11,    :fac.comision21, :fac.comision12, :fac.comision22,   
				:fac.idioma,        :fac.divisa,     :cambio,         :fac.agente3,   
				:fac.comision32,    :fac.comision31, :fac.ffactura,   :fac.total_fac,   
				:fac.base_comision, :fac.pais, 	    :fac.cartera, 	:fac.precartera,
				:fac.domiciliacion, :fac.serie, 	 	 :fac.tipoiva,		:fac.iva,
				:fac.importe_iva,:divisa,:fac.total_fac_pts,:fac.importe_iva_pts,:fac.base_comision_pts,
				:fac.generar_recibos,:fac.cambio_euros,
				:fac.comision_fija1,:fac.comision_fija2,:fac.comision_fija3
		FROM   venfac  
		WHERE  venfac.empresa  = :fac.empresa
		AND    venfac.anyo     = :fac.anyo  
		AND    venfac.factura  = :fac.factura;
		//***
		//f_mensaje("cambio 1",String(cambio))
		IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en base de datos",sqlca.SqlErrtext)
		cobrado = "N"
			
		IF IsNUll(fac.generar_recibos) or fac.generar_recibos = "" Then fac.generar_recibos= "S"
		
		IF fac.generar_recibos = "S" Then
			IF Not f_grabar_cartera(i)    Then 
				bien = 1
				f_mensaje("Error", "En cartera")
			END IF
		END IF
		
		IF Not f_grabar_comisiones(i) Then 
			bien = 1
			f_mensaje("Error", "En comisiones")
		END IF
		
		UPDATE venfac Set venfac.actualizada = "S"
		WHERE  venfac.empresa  = :fac.empresa
		AND    venfac.anyo     = :fac.anyo  
		AND    venfac.factura  = :fac.factura;

		IF SQLCA.SQLCODE <> 0 Then bien = 1
		
	END IF
	f_mensaje_proceso("Grabando Recibos",i,dw_1.RowCount())
NEXT

IF Not f_grabar_apuntes()    Then 
	bien = 1
	f_mensaje("Error", "En apuntes")
END IF

IF bien = 1 Then
	ROLLBACK;
	f_mensaje("Error en proceso","la operacion no se actualiza")
ELSE
	COMMIT;
END IF

cb_continuar.TriggerEvent(Clicked!)
end event

type pb_1 from upb_salir within w_actualizacion_fac
integer x = 2642
integer y = 8
integer width = 123
integer height = 108
integer taborder = 0
end type

type em_fecha from u_em_campo within w_actualizacion_fac
boolean visible = false
integer x = 2432
integer y = 140
integer width = 297
integer height = 76
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_11 from statictext within w_actualizacion_fac
boolean visible = false
integer x = 1984
integer y = 140
integer width = 142
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
string text = "Asto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_asiento from u_em_campo within w_actualizacion_fac
boolean visible = false
integer x = 2135
integer y = 140
integer width = 297
integer height = 76
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#####"
string displaydata = ""
end type

type st_1 from statictext within w_actualizacion_fac
integer x = 27
integer y = 140
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 79741120
string text = "Fecha Factura"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_fac.SetTRansObject(SQLCA)
IF dw_fac.Retrieve(codigo_empresa) = 0 Then
	dw_fac.visible= FALSE
ELSE
	dw_fac.visible= TRUE
END IF

end event

type dw_fac from datawindow within w_actualizacion_fac
boolean visible = false
integer x = 544
integer y = 148
integer width = 672
integer height = 408
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "Salir" Then
	This.visible = FALSE
	Reset()
	f_activar_campo(em_fechadesde)
END IF
end event

event doubleclicked;iF row = 0 Then Return
em_fechadesde.text = String(Date(GetItemDateTime(row,"ffactura")),"dd-mm-yy")
visible = false
reset()
f_activar_campo(em_fechadesde)
end event

type dw_1 from u_datawindow_consultas within w_actualizacion_fac
integer x = 9
integer y = 324
integer width = 2770
integer height = 1548
integer taborder = 0
string dataobject = "dw_con_actualizacion_fac"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;Dec r,r1,vfactura,vanyo,reg
IF f_objeto_datawindow(This) = "imprimir" Then
	dw_listado.retrieve(codigo_empresa,em_serie.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
	r1 = dw_listado.RowCount()
	For r = 1 To r1
		vfactura = dw_listado.GetItemNumber(r,"factura")
		vanyo = dw_listado.GetItemNumber(r,"anyo")
		reg = dw_1.Find("factura="+String(vfactura,"########")+ " and anyo="+String(vanyo,"#####")+ " and libre = 'S'",1,dw_1.RowCOunt())
		IF IsNull(reg) Then reg = 0
		IF reg = 0 Then 
			dw_listado.SetItem(r,"libre","N")
		ELSE
			dw_listado.SetItem(r,"libre","S")
		END IF
	Next
	dw_listado.Setfilter("libre='S'")
	dw_listado.filter()
	
	f_imprimir_datawindow(dw_listado)
END IF

if isnull(dwo) then return
string nombre_objeto
long i
nombre_objeto=dwo.name
CHOOSE CASE nombre_objeto
	CASE "marcar_todo"
		string mt
		mt=dwo.border
		if mt='5' then
			dwo.border='6'
			for i=1 to this.rowcount()
				this.setitem(i,"libre","N")
			next
		else
			dwo.border='5'
			for i=1 to this.rowcount()
				this.setitem(i,"libre","S")
			next
		end if
END CHOOSE

end event

event ue_valores;ue_marca_linea = False
end event

event retrieveend;call super::retrieveend;this.Object.marcar_todo.border="5"
end event

event rbuttondown;if row=0 then return
dec anyo_fact,fact
anyo_fact=dw_1.getitemnumber(row,"anyo")
fact=dw_1.getitemnumber(row,"factura")

long n_lineas 
n_lineas=dw_2.retrieve(codigo_empresa,anyo_fact,fact)

if n_lineas=0 then
	messagebox("Lineas de Factura","Esta factura no tiene lineas")
	return
end if

dw_2.visible=true
cb_2.visible=true
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF rowCount() = 0 Then Return
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

type em_serie from u_em_campo within w_actualizacion_fac
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 850
integer y = 128
integer width = 224
integer height = 80
integer taborder = 10
boolean bringtotop = true
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF


end event

type st_nombre_serie from statictext within w_actualizacion_fac
integer x = 1079
integer y = 128
integer width = 841
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_22 from statictext within w_actualizacion_fac
integer x = 672
integer y = 136
integer width = 174
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_actualizacion_fac
integer x = 366
integer y = 212
integer width = 293
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;em_fecha.text = this.text
end event

type st_2 from statictext within w_actualizacion_fac
integer x = 320
integer y = 208
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_actualizacion_fac
integer x = 2107
integer y = 220
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_cambio from commandbutton within w_actualizacion_fac
event clicked pbm_bnclicked
integer x = 1097
integer y = 228
integer width = 416
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Act.Cambio"
end type

event clicked;Dec r,r1,vfactura,vanyo,vcambio
dec {6} v_cambio_euros
String vmoneda
r1 = dw_1.RowCount()

IF r1 = 0 Then Return
For r = 1 To r1
	
	If dw_1.GetItemString(r,"libre") = "S" Then
		vfactura = dw_1.GetItemNumber(r,"factura")
		vanyo    = dw_1.GetItemNumber(r,"anyo")
		vmoneda    = dw_1.GetItemString(r,"divisa")
		vcambio = f_cambio_moneda(vmoneda)
		v_cambio_euros = f_cambio_euros (vmoneda)
		
		
		Update  venfac
		Set     venfac.cambio = :vcambio , venfac.cambio_euros = :v_cambio_euros
		Where   venfac.empresa = :codigo_empresa
		And     venfac.anyo    = :vanyo
		ANd     venfac.factura = :vfactura;
		COMMIT;
		f_actualizar_venfactura_peso(codigo_empresa,vanyo,vfactura,"N")
		COMMIT;
		IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
		dw_1.SetItem(r,"cambio",vcambio)
	END IF
	f_mensaje_proceso("Procesando factura "+String(vfactura),r,r1)
NExt
end event

type dw_listado from datawindow within w_actualizacion_fac
boolean visible = false
integer x = 14
integer y = 4
integer width = 494
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_actualizacion_fac"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_actualizacion_fac
boolean visible = false
integer x = 2249
integer y = 20
integer width = 91
integer height = 76
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac3"
boolean livescroll = true
end type

type dw from datawindow within w_actualizacion_fac
boolean visible = false
integer x = 2363
integer y = 20
integer width = 91
integer height = 76
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac4"
boolean livescroll = true
end type

